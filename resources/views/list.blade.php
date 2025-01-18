{{-- resources/views/list.blade.php --}}

    <div class="box">
        <div class="box-header">
            <h3 class="box-title">
                Data from {{ $modelNameEn }}
                (Table ID: {{ $tableid }} | Page ID: {{ $pageid }})
            </h3>
        </div>
        <div class="box-body">
            {{-- 确保 $data 不为空 --}}
            @if($data->isNotEmpty())
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        {{-- 获取第一行数据并遍历列名 --}}
                        @foreach ($data->first() as $key => $value)  {{-- 强制转换为数组 --}}
                        <th>{{ ucfirst($key) }}</th>
                        @endforeach
                    </tr>
                    </thead>
                    <tbody>
                    {{-- 遍历数据 --}}
                    @foreach ($data as $row)
                        <tr>
                            {{-- 将每行数据强制转换为数组后遍历 --}}
                            @foreach ($row as $column)
                                <td>{{ $column }}</td>
                            @endforeach
                        </tr>
                    @endforeach
                    </tbody>
                </table>
            @else
                <p>No data available.</p>
            @endif
        </div>
    </div>
