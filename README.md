<!DOCTYPE html>
<html>
<head>
    <style>
        .custom-table {
            width: 100%;
            border-collapse: collapse;
        }
        .custom-table th, .custom-table td {
            border: 1px solid #ddd; /* Light grey border */
            padding: 8px; /* Padding for content */
            text-align: left; /* Align text to the left */
        }
        .custom-table th {
            background-color: #000; /* Black background */
            color: #fff; /* White text */
        }
        .custom-table tr:nth-child(even) {
            background-color: #f9f9f9; /* Zebra striping for even rows */
        }
        .custom-table tr:hover {
            background-color: #eaeaea; /* Hover effect for table row */
        }
    </style>
</head>
<body>

<table class="custom-table">
    <thead>
        <tr>
            <th>Header 1</th>
            <th>Header 2</th>
            <th>Header 3</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Data 1</td>
            <td>Data 2</td>
            <td>Data 3</td>
        </tr>
        <tr>
            <td>Data 4</td>
            <td>Data 5</td>
            <td>Data 6</td>
        </tr>
        <!-- Add more rows as needed -->
    </tbody>
</table>

</body>
</html>
