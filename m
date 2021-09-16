Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41640DEA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhIPPvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:51:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:36812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240371AbhIPPvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:51:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="286281224"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="286281224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 08:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="482756783"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2021 08:50:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 08:50:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 08:50:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 08:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igt9MPROZOzJ/oF1xuvZ5TYSvga8NiJcS0UZHFw3nHkXSMiCLs68jawpz4d3079dpWNPI+H8jzDfqhmo+0F5shHZT4otSpb5bWpKqU+vv+1XYnpL/5c80h5k6rZCmWjWbmOwY8YHVcpYQWWjyYcq9Y7ajRH79Ao20mdOvLTXw3Jp5QbR8UvQ8haWEssc5Rl8nf6XeQAmzJHISTPqjQW7ovWn8Wmw2DM7qINGEa1YTDMjyj3OOwdANeW3N1bNMQB+wq05vyHozub/tDozJpQBBs+Zw6w6LNk1M2YYgUqC+qHGihrAmCn/D3NOm3IXILUhZxdMeWM+IR7aq/BBGbYvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0hm/+9710DHp+YP1mYm1hfRFtXKNaZklMEN0IBf4XSM=;
 b=K2EJSooVpZ30acRlZH5Bc+tcrGgp5spvEx0HdbAyhGWogaHd/figCehVxhE+DtfiNEhxrKIakxc0cJAmQ2a0jBDunvMLDyuBFV47+o3/Qpez9cxyWCqK3/CkH4ZQT9kLs88Sa5FqwK4AOMIaGsIHhNZ2A9qRYmllPynjx3fBrlmD6/fp5JlXq+u+LwaPwgltZaQFGZqmfcWHqZx5oxVT9pyIcdjvT5f7zbJqYpN+Y0/Z0ACMaAoqoSSbBn3ZuOML8X8JLTbKmWYxSykQ5HBLUkXkSSPGudhTRizG3WFuXQDFjnAXoEj6WaXjOyhL6m3gjDvnzyNZ0zNr/2uQz1eTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hm/+9710DHp+YP1mYm1hfRFtXKNaZklMEN0IBf4XSM=;
 b=A9IUvz16yrkYJgG996WkRYHCs/bXajx6EiFasdji7zO8FJ+wzvU3fi65FgsAXQn75iyvuoUZr26flBD4vQNgm/Q67wsBry7Sz/SpbAbmU6xizAvWGJsHOkQaTpPXw4SXrPcZPm3AOuYS5bSDsL7zyWS8yma3R1QeLnim2emN8Aw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1668.namprd11.prod.outlook.com (2603:10b6:405:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 15:50:07 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:50:07 +0000
Subject: Re: [PATCH 12/14] selftests/sgx: Add page permission and exception
 test
To:     Dave Hansen <dave.hansen@intel.com>, <linux-sgx@vger.kernel.org>,
        <jarkko@kernel.org>, <shuah@kernel.org>
CC:     <seanjc@google.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
 <a6e69ea22a2694d252302af283ee3e3f023d3577.1631731214.git.reinette.chatre@intel.com>
 <9990d737-9b9c-911f-3850-c9f3bc43c29b@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <839c8954-8b95-1dc9-944c-eda4c95abc5a@intel.com>
Date:   Thu, 16 Sep 2021 08:50:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <9990d737-9b9c-911f-3850-c9f3bc43c29b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0069.namprd16.prod.outlook.com
 (2603:10b6:907:1::46) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c614c0-82a7-4dff-fda1-08d97929a850
X-MS-TrafficTypeDiagnostic: BN6PR11MB1668:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1668D675259B8348BE6AF4F0F8DC9@BN6PR11MB1668.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkWQJ/4qgf3wkS02Jef+eHe9M7v59HScJ9tMK+jp4jm7CYTyN8c0El/eOUp+EwFl2FVBbiHcTTtqJxCA86qa/RMug9a9njIrao2vv3fwJIrzMy12XTgNbxNRy/BkkMjjR5X0CnDFT7OEGsErE78oNvcGg2qqjQilQMuYEMKUzRsiNZr0gVo2Wu8iPnLm88VtqKq3BxHZ91BIua2laAk0TvLky90JSemAJG02fpN2sd5nBDFOTOLusREfhTQwezZruKhFRdzxU6S6h54GZh0wSxxLAffUcDMDTUQblv9qQ6GVnnQrI9hqJnV9Jqz2jZNoRu5+2+B96SE5fMEPGS31B4WuxlFF2JQ90/fdaB6amhNlQ5hKnjRlg7SJHIGDrkyYHSvOzYV3onNHpmTRhG0ALrK0PwzliCKDZRHCyZlxguUyA2jUoYUdPDIBSWwpaPHomMe3AvbUjwKInKrrTIbL82g5PqOJXaphyewJKgD3CoetcDqMUIbDsGk+5p9IcvFqu7Qbv1ia0Xviyi2n03XyZW2Bh0u6JcGooyiR7gGJcW1sfIt48FtAMpF7xjhf5YOpsLoOv4ua4ug3zNxBliRjlyIoFkpim0prGDeAku21wosfR4cxp/FTK8GFnNF+IY3RV1QvQ17pF9ZumobzG3XwPY9abGLb7fjCkzHm0MlAoHNxqzsj8C1Fe7Do8/H4YBn7QQZ4pvJEvrV/wF175NeLL20JfbuIKSjE5bGJiFmDhWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6666004)(4326008)(38100700002)(44832011)(956004)(186003)(66946007)(66476007)(66556008)(8936002)(83380400001)(53546011)(6486002)(5660300002)(31686004)(26005)(478600001)(8676002)(31696002)(316002)(2616005)(16576012)(86362001)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNhNUEzSnZwM2FMeTY5bktZcUdER0lNNzMwR1FvNkUrc1doUjc2U1VjMmtk?=
 =?utf-8?B?NFZhTXZpc2UrWHhHeU1KSk5UdDNseDNWTlFVbUFRNW53MEZVR3VPQWJ2OVlm?=
 =?utf-8?B?Zis4ckdqWXM2bXI1NVFyclZnUGhtZGtNVDZPY0lrc2R5V21VLzh1MkI4eGpk?=
 =?utf-8?B?SmJoRFVHN0N6V25RMFlmbXhBZVdkY2xqZHpTa29qVTBFRW5yWjFLekZQVC9F?=
 =?utf-8?B?WDA2QjZaRDBKVS9xbmx4M2xtRWljRGpHTnZGSHBYaFRxTnZHdERPMUtJWmVr?=
 =?utf-8?B?bjFnbER1Y1pGRlhFODEvQ1pBeGdmaktOcXJRRTBON2xYYS91YnExN2xaZ240?=
 =?utf-8?B?WlBHczdPZWJjVDNTeTdIRWFVRTdpZmNzRTNzZkVNZm56WkNOOWc1OVJjZnVG?=
 =?utf-8?B?STU0RkVtYWZhOFJqR3owbkI3WEM3L2ZYUFp5YUIyRWViY0U4WXVjQWhuU2NS?=
 =?utf-8?B?ZzVXbFVIalFrV2xnSlJxK2pQRE8xbDNjQTZIQzhzZ01oRmlsS294SjZuNGJX?=
 =?utf-8?B?VlUzMHdCZHVHcTdsNzAwZ1hVRk12LzRwdk5NelpoVlJPZHQwRm50QXZTOTVm?=
 =?utf-8?B?TE1ELzIxTjcxMnhoOVZ3am9zVlN5dm5tTU1oc21JZHlQWGFobWliQ3QvRGJ6?=
 =?utf-8?B?SUJhTEFka1NaYWZ5VTNvb3ZlTkxTcnhkQXlYaUxob1RaUGhXU1MxR21wYmsy?=
 =?utf-8?B?N24zVnlUcll1d0ZheHJ5TXkrUjUzQURneGZOcHNhM0xHYkd5cE5sOWtwWmh3?=
 =?utf-8?B?U0hyb0NpZTJNM3VTTlVxWWNVWUR3QUc3NTRXSTg5MXJpazUyaTBIL2FOZzBO?=
 =?utf-8?B?R3RKc3lqVm5VL2NIc2xoRnVGYkxpMGdsLzhuaGUvNWExcDliYmtpVCtlcHBG?=
 =?utf-8?B?QXFDZTZ4NUE4UDc4enk3K3FkZkVzRndaQzk4VXhtbFlhMDlBS0c2bWRtUDVz?=
 =?utf-8?B?akxhcU9yNDNna1dyOTd4OW1rRjY1cExiUHUxRk9RTkJDL2ZwRzBVQS8zZHRL?=
 =?utf-8?B?ZmdMQ1FYNlhNZkdPa0g3V2ZpaGk1L2ZIVmRWdXJsM05Lcm9UK0xYS0kva0gr?=
 =?utf-8?B?VVpqMG4rM1Z5ay9iT1dXcVhIKzVFZ1p2dFpBeWxhVEV4ZHJxd0RDUExncmM5?=
 =?utf-8?B?ZmU3VkR3d2hWN2t4UnhqbFpqSWEvUHQxMy85RFJZTE9yZWNpYVpPeW1oZkJ1?=
 =?utf-8?B?RDZXblI4OEpNeWNtaXUyKzhPREdnanQwQ3BEVmllOE82RjRZam5BUjljRlZQ?=
 =?utf-8?B?bVhONWFUZjU5RGF1MFZZenB1eVRRRkQ1T0MrWEdKdkx5TGI0TUR2aWJINy9Z?=
 =?utf-8?B?cm9TQ0Q2dStXTjg5c0VraDZoS1hLU2x5VFp6emJDOEZiOXVTazhjamhVNEha?=
 =?utf-8?B?SnNod3BGSU5iVyt5eWpUZ2lvVlZ6bURBWEMwRXVVUU9ISHVNNmVWU2oyRjVM?=
 =?utf-8?B?eDU3ZTFXcXc0bjRjVTgwZ2w0Y2lhRi84U1dPMGdjTmJHMm5WVW8rRWZGKzEr?=
 =?utf-8?B?UTBtUkFIaW5XOVM4QkxrYVRRUzJkNmVrNkJUUnFJQ0tNK2VvQWdiNFZlcGt0?=
 =?utf-8?B?MjFsQVZHb3FIYXJoTWhWS0JVWGdjVlNWRno0RURHUzN4NEdud3VXY21YVXMw?=
 =?utf-8?B?VDNPUVJ2Q3VMV2t0am9Ib2J3cjNrbitiUzBNaXhSaUVUMFhlTkYzU0srQ3RU?=
 =?utf-8?B?NWVuSk9MZlNWSFJ4anRyUWsvZGdyK2ZsenVyQUNSdGNSa3ZCVGtpM1ZzU3JT?=
 =?utf-8?Q?WodJHX3zIggg1Di2Iy8YQd82XWHRkXiLlr5itG1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c614c0-82a7-4dff-fda1-08d97929a850
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:50:07.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iZ+iyxpUkB5eIm1riZlBnH1wq1yrLNXA4WIggoDkn+9jl7FuxijfWmbiucnyGVNvN+B1G+zmSpKHx2UW8ZgIQsFNFvf5Jf6ZYmGk7v1oeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 9/16/2021 8:30 AM, Dave Hansen wrote:
> On 9/15/21 1:31 PM, Reinette Chatre wrote:
>> Add a test to ensure that (1) PTE permissions can be changed as long as
>> they do not exceed EPCM permissions, and (2) even if EPCM permissions
>> allow a page to be written to, if the PTE permissions do not then a #PF
>> should be generated when attempting to write to a (from PTE perspective)
>> read-only page.
> 
> It took me a minute to figure out what this was trying to say.

The goal was to describe what features/functionalities are being tested. 
You accurately point out that it is not clear how the test implemented 
in the patch matches with these test goals.

>  Maybe
> breaking it down into these three steps would help:
> 
> Add a test that:
>   (1) Creates an SGX enclave page with writable EPCM permission
>   (2) Changes the PTE permission on the page to read-only.  This should
>       be permitted because the permission does not exceed the EPCM
>       permission.
>   (3) Attempts a write to the page and generate a page fault (#PF)
>       because of the read-only PTE.

Thank you for the suggestion. What I understand from your feedback is 
that I should mix the description of the actual test with what 
features/functionalities are being tested. You do so in your suggestion 
for (2) and to do the same for (3) I now plan to expand it to:

    (3) Attempts a write to the page. This should generate a page fault
        (#PF) because of the read-only PTE even though the EPCM
        permissions allow the page to be written to.

Reinette

