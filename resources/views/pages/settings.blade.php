<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Table Right Click Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Ensure body and html cover full height and width */
        html, body {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .col-12 {
            width: 100%;
            height: auto;
        }
        .card {
            width: 100%;
            height: 90%;
            overflow: auto;
        }

        .table-responsive {
            height: 100%;
            overflow-y: auto;
        }

        #contextMenu {
            z-index: 9999;
            background-color: white;
            border: 1px solid #ddd;
            padding: 10px 0;
            width: 150px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        #contextMenu .dropdown-item {
            cursor: pointer;
            padding: 5px 10px;
        }

        #contextMenu .dropdown-item:hover {
            background-color: #f1f1f1;
        }

        /* Highlight selected cells */
        .selected {
            background-color: rgba(0, 123, 255, 0.5);
        }
        /* Highlight td on hover */
        #myTable td:hover {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        .modal-dialog {
            max-width: 1200px; /* 增加模态框的宽度 */
        }
        .fieldList span {
            display: inline-block; /* 让 span 元素能使用宽度和高度 */
            padding: 5px 10px; /* 给 span 一些内边距 */
            border: 2px solid #ccc; /* 默认边框颜色 */
            margin: 3px; /* 添加一点外边距 */
            border-radius: 5px; /* 可选：给边框圆角 */
            transition: background-color 0.3s ease; /* 平滑过渡效果 */
        }

        .fieldList span:hover {
            background-color: #00b44e; /* hover 时的背景颜色 */
            cursor: pointer;
        }

    </style>
</head>
<body>
<div class="card">
    <div class="card-header bg-primary text-white">
        <h4>Page Field Settings</h4>
    </div>

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="myTable">
                <tbody>
                <tr>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                    <td>Field Setting</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Right-click Menu -->
<div id="contextMenu" class="dropdown-menu" style="display:none; position: absolute;">
    <a class="dropdown-item" href="#" id="addRow">Add Row</a>
    <a class="dropdown-item" href="#" id="addColumn">Add Column</a>
    <a class="dropdown-item" href="#" id="deleteRow">Delete Row</a>
    <a class="dropdown-item" href="#" id="deleteColumn">Delete Column</a>
    <a class="dropdown-item" href="#" id="mergeCells">Merge Cells</a>
    <a class="dropdown-item" href="#" id="splitCells">Split Cells</a>
</div>

<!-- 字段设置表单 -->
<div class="modal fade" id="editCellModal" tabindex="-1" aria-labelledby="editCellModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCellModalLabel">Edit Cell</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="chineseName" class="form-label">china name</label>
                            <input type="text" class="form-control" id="chineseName" placeholder="china name" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="englishName" class="form-label">en name</label>
                            <input type="text" class="form-control" id="englishName" placeholder="en name" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="value" class="form-label">value</label>
                            <input type="text" class="form-control" id="setValue" placeholder="value" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="isVisible" class="form-label">visible</label>
                            <select class="form-select" id="isVisible">
                                <option value="1">yes</option>
                                <option value="0">no</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="customSql" class="form-label">customize</label>
                    <textarea class="form-control" id="customSql" rows="3" placeholder="customize"></textarea>
                </div>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveCellValue">Save</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<!-- 操作符模态框 -->
<div class="modal fade" id="operationModal" tabindex="-1" aria-labelledby="operationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="operationModalLabel">Edit Value</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="operationField"  class="form-label">Display Column</label>
                    <input type="text" class="form-control" id="operationField" placeholder="Enter column value" />
                    <div class="mt-2">
                        <button class="btn btn-secondary btn-sm" id="plus">＋</button>
                        <button class="btn btn-secondary btn-sm" id="minus">－</button>
                        <button class="btn btn-secondary btn-sm" id="multiply">＊</button>
                        <button class="btn btn-secondary btn-sm" id="divide">／</button>
                        <button class="btn btn-secondary btn-sm" id="percent">％</button>
                        <button class="btn btn-secondary btn-sm" id="leftParen">(</button>
                        <button class="btn btn-secondary btn-sm" id="rightParen">)</button>
                        <button class="btn btn-secondary btn-sm" id="or">||</button>
                        <button class="btn btn-secondary btn-sm" id="if">if</button>
                        <button class="btn btn-secondary btn-sm" id="elseif">elseif</button>
                        <button class="btn btn-secondary btn-sm" id="else">else</button>
                        <button class="btn btn-secondary btn-sm" id="endElse">endElse</button>
                        <button class="btn btn-secondary btn-sm" id="backward">←</button>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="operationContent" class="form-label">Content</label>
                    <textarea class="form-control" id="operationContent" rows="3" placeholder="Enter content"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveOperationValue">Save</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



<!-- 字段设置模态框 -->
<div class="modal fade" id="fielSettingModal" tabindex="-1" aria-labelledby="operationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="operationModalLabel">Edit Value</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 第一部分：选择字段类型 -->
                <div class="mb-3">
                    <div class="row">
                        <!-- 字符串类型输入框 -->
                        <div class="col-3">
                            <label for="textField" class="form-label">字符串</label>
                            <input type="text" class="form-control" id="textField" placeholder="Enter text">
                        </div>
                        <!-- 数字类型输入框 -->
                        <div class="col-3">
                            <label for="numberField" class="form-label">数字</label>
                            <input type="number" class="form-control" id="numberField" placeholder="Enter number">
                        </div>
                        <!-- 日期类型输入框 -->
                        <div class="col-3">
                            <label for="dateField" class="form-label">日期</label>
                            <input type="date" class="form-control" id="dateField">
                        </div>
                        <!-- 时间类型输入框 -->
                        <div class="col-3">
                            <label for="timeField" class="form-label">时间</label>
                            <input type="time" class="form-control" id="timeField">
                        </div>
                    </div>
                </div>

                <!-- 第二部分：tab切换区域 -->
                <ul class="nav nav-tabs" id="operationTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="currentAttributes-tab" data-bs-toggle="tab" href="#currentAttributes" role="tab" aria-controls="currentAttributes" aria-selected="true">当前属性</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="systemInfo-tab" data-bs-toggle="tab" href="#systemInfo" role="tab" aria-controls="systemInfo" aria-selected="false">系统信息</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="managementDimensions-tab" data-bs-toggle="tab" href="#managementDimensions" role="tab" aria-controls="managementDimensions" aria-selected="false">管理维度</a>
                    </li>
                </ul>
                <div class="tab-content mt-3" id="operationTabsContent">
                    <!-- 当前属性 -->
                    <div class="tab-pane fade show active" id="currentAttributes" role="tabpanel" aria-labelledby="currentAttributes-tab">
                        <div class="form-check d-flex fieldList" style="width: 100%; gap: 20px;">
                            <span class="form-check-label">主键</span>
                            <span class="form-check-label">名称</span>
                        </div>

                    </div>



                    <!-- 系统信息 -->
                    <div class="tab-pane fade" id="systemInfo" role="tabpanel" aria-labelledby="systemInfo-tab">
                        <div class="form-check d-flex fieldList" style="width: 100%; gap: 20px;">
                            <span class="form-check-label">主键</span>
                            <span class="form-check-label">名称</span>
                        </div>
                    </div>
                    <!-- 管理维度 -->
                    <div class="tab-pane fade" id="managementDimensions" role="tabpanel" aria-labelledby="managementDimensions-tab">
                        <div class="form-check d-flex fieldList" style="width: 100%; gap: 20px;">
                            <span class="form-check-label">主键</span>
                            <span class="form-check-label">名称</span>
                        </div>
                    </div>
                </div>

                <!-- 输入内容 -->
                <div class="mb-3">
                    <label for="operationContent" class="form-label">Content</label>
                    <textarea class="form-control" id="operationContent" rows="3" placeholder="Enter content"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveOperationValue">Save</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>




<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        var selectedCell = null;
        // Show context menu
        $('#myTable').on('contextmenu', 'td', function(e) {
            e.preventDefault(); // Prevent the default right-click menu
            selectedCell = $(this); // Store the clicked cell

            var menu = $('#contextMenu');
            menu.css({ top: e.pageY + 'px', left: e.pageX + 'px' });
            menu.show(); // Show custom context menu
        });


        // Hide context menu when clicking elsewhere
        $(document).on('click', function() {
            $('#contextMenu').hide();
        });

        // Toggle cell selection on click
        $('#myTable').on('click', 'td', function() {
            $(this).toggleClass('selected');
        });

        // Show modal on double-click
        $('#myTable').on('dblclick', 'td', function() {
            selectedCell = $(this); // Store the clicked cell
            var currentValue = selectedCell.text(); // Get current text
            $('#cellValueInput').val(currentValue); // Set input field to current value
            $('#editCellModal').modal('show'); // Show modal
        });


        // Show modal on double-click on value cell
        $('#setValue').on('dblclick', function() {
            $('#operationModal').modal('show'); // Show operation modal
        });

        $('#operationField').on('dblclick', function() {
            console.log(22222222222);
            $('#fielSettingModal').modal('show');
        });

        // Handle saving the operation value
        $('#saveOperationValue').on('click', function() {
            // Get the field type and content from the modal
            var fieldType = $('#fieldType').val();
            var content = $('#operationContent').val();
            var selectedAttributes = [];

            // Get the selected checkboxes from the current attributes
            $('#currentAttributes input:checked').each(function() {
                selectedAttributes.push($(this).val());
            });

            // You can further handle saving the data here
            console.log('Field Type:', fieldType);
            console.log('Content:', content);
            console.log('Selected Attributes:', selectedAttributes);
            // You can also update the input field with the new value
            $('#operationField').val(content);

            // Hide the modal
            $('#operationModal').modal('hide');
        });



        // Save new value from modal input
        $('#saveCellValue').on('click', function() {
            var newValue = $('#cellValueInput').val(); // Get the new value from the input
            selectedCell.text(newValue); // Update the cell value
            $('#editCellModal').modal('hide'); // Hide modal
        });

        // Add Row
        $('#addRow').on('click', function() {
            var newRow = $('<tr>');
            var cellsCount = selectedCell.closest('tr').children('td').length;

            for (var i = 0; i < cellsCount; i++) {
                newRow.append('<td>Field Setting</td>');
            }

            $('#myTable tbody').append(newRow);
            $('#contextMenu').hide();
        });

        // Add Column
        $('#addColumn').on('click', function() {
            $('#myTable tbody tr').each(function() {
                $(this).append('<td>Field Setting</td>');
            });
            $('#contextMenu').hide();
        });

        // Delete Row
        $('#deleteRow').on('click', function() {
            selectedCell.closest('tr').remove();
            $('#contextMenu').hide();
        });

        // Delete Column
        $('#deleteColumn').on('click', function() {
            selectedCell.closest('table').find('tr').each(function() {
                $(this).children('td').eq(selectedCell.index()).remove();
            });
            $('#contextMenu').hide();
        });

        // Merge Cells
        $('#mergeCells').on('click', function() {
            var selectedCells = $('#myTable td.selected');
            if (selectedCells.length > 1) {
                var colspan = selectedCells.length;
                selectedCells.first().attr('colspan', colspan);
                selectedCells.slice(1).remove();
            }
            $('#contextMenu').hide();
        });

        // Split Cells
        $('#splitCells').on('click', function() {
            var startCell = selectedCell;
            var colspan = startCell.attr('colspan') || 1;

            if (colspan > 1) {
                startCell.removeAttr('colspan');
                for (var i = 1; i < colspan; i++) {
                    startCell.after('<td>Field Setting</td>');
                }
            }
            $('#contextMenu').hide();
        });
    });
</script>
</body>
</html>
