function New-ITGlueOrganizations {
    Param (
        [Parameter(Mandatory = $true)]
        $data
    )

    $resource_uri = '/organizations/'

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'POST' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Get-ITGlueOrganizations {
    [CmdletBinding(DefaultParameterSetName = 'index')]
    Param (
        [Parameter(ParameterSetName = 'index')]
        [String]$filter_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [String]$filter_exclude_name = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$filter_exclude_organization_status_id = $null,

        [Parameter(ParameterSetName = 'index')]
        [ValidateSet( 'name', 'id', 'updated-at', 'organization_status_name', 'organization_type_name', `
                '-name', '-id', '-updated-at', '-organization_status_name', '-organization_type_name')]
        [String]$sort = '',

        [Parameter(ParameterSetName = 'index')]
        [Nullable[Int64]]$page_number = $null,

        [Parameter(ParameterSetName = 'index')]
        [Nullable[int]]$page_size = $null,

        [Parameter(ParameterSetName = 'show')]
        [Nullable[Int64]]$id = $null
    )

    $resource_uri = ('/organizations/{0}' -f $id)

    if ($PSCmdlet.ParameterSetName -eq 'index') {
        $body = @{
            'filter[name]'          = $filter_name
            'filter[exclude][name]' = $filter_exclude_name
            'sort'                  = $sort
        }
        if ($filter_organization_type_id) {
            $body += @{'filter[organization_type_id]' = $filter_organization_type_id}
        }
        if ($filter_organization_type_id) {
            $body += @{'filter[organization_status_id]' = $filter_organization_status_id}
        }
        if ($filter_exclude_organization_type_id) {
            $body += @{'filter[exclude][organization_type_id]' = $filter_exclude_organization_type_id}
        }
        if ($filter_exclude_organization_type_id) {
            $body += @{'filter[exclude][organization_status_id]' = $filter_exclude_organization_status_id}
        }
        if ($page_number) {
            $body += @{'page[number]' = $page_number}
        }
        if ($page_size) {
            $body += @{'page[size]' = $page_size}
        }
    }


    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'GET' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}

function Set-ITGlueOrganizations {
    Param (
        [Nullable[Int64]]$id = $null,

        [Parameter(Mandatory = $true)]
        $data,

        [Nullable[Int64]]$filter_id = $null,
        
        [String]$filter_name = '',

        [Nullable[Int64]]$filter_organization_type_id = $null,

        [Nullable[Int64]]$filter_organization_status_id = $null,

        [String]$filter_created_at = '',

        [String]$filter_updated_at = '',

        [Nullable[Int64]]$filter_my_glue_account_id = $null,

        [Nullable[Int64]]$filter_exclude_id = $null,

        [String]$filter_exclude_name = '',

        [Nullable[Int64]]$filter_exclude_organization_type_id = $null,

        [Nullable[Int64]]$filter_exclude_organization_status_id = $null

    )

    $resource_uri = ('/organizations/{0}' -f $id)

    $body = ConvertTo-Json -InputObject $data -Depth $ITGlue_JSON_Conversion_Depth

    if($filter_name) {
        $body += @{'filter[name]' = $filter_name}
    }
    if($filter_organization_type_id) {
        $body += @{'filter[organization_type_id]' = $filter_organization_type_id}
    }
    if($filter_organization_status_id) {
        $body += @{'filter[organization_status_id]' = $filter_organization_status_id}
    }
    if($filter_created_at) {
        $body += @{'filter[created_at]' = $filter_created_at}
    }
    if($filter_updated_at) {
        $body += @{'filter[updated_at]' = $filter_updated_at}
    }
    if($filter_my_glue_account_id) {
        $body += @{'filter[my_glue_account_id]' = $filter_my_glue_account_id}
    }
    if($filter_exclude_id) {
        $body += @{'filter[exclude][id]' = $filter_exclude_id}
    }
    if($filter_exclude_name) {
        $body += @{'filter[exclude][name]' = $filter_exclude_name}
    }
    if($filter_exclude_organization_type_id) {
        $body += @{'filter[exclude][organization_type_id]' = $filter_exclude_organization_type_id}
    }
    if($filter_exclude_organization_status_id) {
        $body += @{'filter[exclude][organization_status_id]' = $filter_exclude_organization_status_id}
    }

    $ITGlue_Headers.Add('x-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $ITGlue_API_Key).GetNetworkCredential().Password)
    $rest_output = Invoke-RestMethod -method 'PATCH' -uri ($ITGlue_Base_URI + $resource_uri) -headers $ITGlue_Headers `
        -body $body -ErrorAction Stop -ErrorVariable $web_error
    $ITGlue_Headers.Remove('x-api-key') >$null # Quietly clean up scope so the API key doesn't persist

    $data = @{}
    $data = $rest_output 
    return $data
}