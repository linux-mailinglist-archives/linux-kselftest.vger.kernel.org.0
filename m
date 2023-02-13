Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3F695086
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBMTVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBMTVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 14:21:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA98CC0E;
        Mon, 13 Feb 2023 11:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316068; x=1707852068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S5ROCceiEjaLvtlBdq9qbptRlcdlTKvDh6HjTMyASfY=;
  b=HnZTV+PYasAPMErwvLPhgjMV8id4y7/ESa8XkXeOGfOYO123to3E8ERE
   yMMFnyiuRTF2FG2WqnzsNA2KOVMU/rA4EFedntGahmKazKW2q8HFvbMwd
   8wUiTXZER3ypYioB67BwIupSieW4C9LHAXgclhgfBg1nQfyIf3CV2sCAC
   L6KrRmKaBOSpqH62W2gfzjCDsMV2RI3L+LLkTyE9QICluRhaqo6Myt7K3
   Goc9Q88pWfdcmfRCqQr6dU5A1wumzuVucIV/NUfxxDQ/7jIhLCD9mj67M
   c9g7fdUWrigx6wllCgBPAOGBf4GXeZ9Y/kd0f9WUSpDpgDcdno4z6TWVE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417193944"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="417193944"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="699258964"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="699258964"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2023 11:21:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 11:21:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 11:21:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUutMpRGxVHQ7qnxMTIxQ7kYWboj/wvOFfRxZuL1fBm8JpJbiGKeFsKVA6MKyCENU9fOAICltXEdgcsCsdLSHJQHE2PC8/MHQsT1LB7XunNujN4fdS5GQ7yQnQE1llZTJXSLG7oTHmZqHuQ4qN6lPipnerc/07xvg4Rhtbz1J6Onepmq8S0e9BzYVj9VIOfuF3z1B0YFxe1PqQwum4ITgRW6+DwltpzVpT1DZPJEG1F/sFeSG+lA/E7XMgQlBY8sDgfGiD1C//LTuROZm5uJqTWVJosWuDSsyBnqytGj7QMaBaNOB/YQYZGplwq/Kc3HgMVdzh5CEcRk1cZuNg/S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfltNfJl3c+v/zPdzvsKOrNB1WXw0Zjh9iAHeG+9cto=;
 b=EOul1m5lBQQh6x3SknYI3qTUn8xU+fd7vlM9sp05SYvbTHfds/LJrWjZTOozrJ18blleaa9S3AtjlCnYFXWfsNipa43Dki34gyclru3V3njTM+y1lkZcGwxT8m+rXV5rzz2VHxVOSPL8DaNcyEGjFvFzXYRHbli2azmcm0uyWSkxaxh5/XTXnvUkaXu96Iun8wL49na6en308LW6BnpWz+6wz9whXmFvqOKSabMkF+5YTGXpWKAElKe+zl/s6kafY8Wo7OI8T0hREISXUlA5blQa8Oex1hGAJPEiiFHBOgj8jxw+FiKXGqwuABpIYSza6YkLpuvbWPknoEv/ezvn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB8240.namprd11.prod.outlook.com (2603:10b6:610:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:21:03 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Mon, 13 Feb
 2023 19:21:03 +0000
Message-ID: <7a0a068f-7001-4e59-9e4d-cd4b3a148bb4@intel.com>
Date:   Mon, 13 Feb 2023 11:21:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v7 4/6] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com>
 <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230213062428.1721572-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b892a1-6891-4291-f68f-08db0df77281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3E9kGKjsVovxsoO2l5gHkIOzQiordFA5CDshpEKGEE84F2pc2Zx/JL+ETvmg+HksLqUbDjrAw62GXjoO5dK2nolr4fRSlIuGbqy1wCrhqOImuGJRXpsGIH9F8WjuB5d5N/uEEzILUlaTbI8c2KNjg28STaxfBN5t1IUPrtycIXOqgRGKbmMcoI9HNkTuhcAvDob16AshKAxO1CoBSy/9VqyWstOnJvB0oJAV6eucnUvw7isZs4oyIREDZdV6XSo31dEOO5TuijqYvzZk+gCiieRY9++exlMDdBRrHDudfn3GXcDFSABsVvnEW/60hzgMRVms6gE2XJVzZTM+Jsuf+idh6eDcVsnYw0C1C6EAYluwoXWORPHYMuPv84swdG0Jwr4Ye8aqB1An7MAkJEgqKkSA+LG+ZA67MKpMy34hn93sVFmcrmgVa4PlklYf/j6TiPAEgAJrS3iAaFGsctt2svQWi/J35KjJVrvZXNyPODKr50tz57ws//0x5uLKVHRVvT/IYMzQNswxZkGXcpjKrTGbDwFtjZu4QtIEtqTiHXkwUaLDvE5ZfgZS0JB/n3bNvF+fKUwwbw/WY41A4OFmExAYIRZdSCILBHV9eb7YyKpEJNzbfQZ78gehSx5foYSfSbNhnXuZYsad6fwuMIZi8a2HbHvIKcBsIn+ZQ45Zj032EWA+2pUfc7TGcXsBAwVmKT4/GNqyyJuBSo9LZ9LX2c8LUEL/SCMsJZVsck9i3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(83380400001)(66946007)(316002)(66476007)(8936002)(66556008)(5660300002)(4326008)(8676002)(2616005)(110136005)(41300700001)(478600001)(6506007)(53546011)(6512007)(186003)(26005)(6486002)(36756003)(86362001)(31696002)(2906002)(44832011)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkF5RTd5VWZyQklDazNsZUNUZU5CUnRFUHJBZER3VUwyckNrRWJSL3p6aVcx?=
 =?utf-8?B?c292WDNFVFZ0Qkk5cDZVdm5MTUhiaUE0OWZkUklkZjlrd2lraE5TcTZ3TENq?=
 =?utf-8?B?UTByRi81cUU4NktWczdjMUZoN0EvdlpGWUVFeUNuNmxhRmJrdmVKaHkrQzNI?=
 =?utf-8?B?R1p5dXR5bnE2MGhWT0JyS3d3ZDVvKy91TGJoV1hnWnVOMU12UVR1ZThJa2JS?=
 =?utf-8?B?aTRyc2RReUNWTm9QOUpTcExKTU9aN2RSemdnY0Q2UHpVUWtJcXM4alhGOXBM?=
 =?utf-8?B?L1hLVnFTKzVqNnl6WDJwVFNsZ2tXMm16U3pPaGpvTHd0YjVmL3ZJQ1pQVTBV?=
 =?utf-8?B?RmVpZFZJekdaRmdzVWhKdVd5ODloeU5Zakc3ZHppcjJsSG0vTlhHRk82RkFY?=
 =?utf-8?B?OGM4MHpZYXdiYnhZd3J6RzJqRmJobHluRS9wUWJvekRaM3hWL0p1SGo5Tm9t?=
 =?utf-8?B?eXZUamxieVRnL1h6NHgvWXlXRHRKZjh2VTc5K1ZsVVhBVjI2VmNSSVZXNWpB?=
 =?utf-8?B?aDlsd25xdjV3NjUwZjFjRUhTVGF0cEJkcFFEdGN6T0MrcDZubHdPZElsVnVj?=
 =?utf-8?B?dUs4ZkV4T3NCaTJoZ2JIZUVhVDAzSFhEb3lkWUsyU0x2ejdSWHBrR29DQWhT?=
 =?utf-8?B?azJSU2RCZEtGM1lGK0RaaC9POFJHTHpHSll3QTZWTFJkejdPSEo3ZWVuTWxi?=
 =?utf-8?B?SXdSTlV1QmhJWDNiMGZOcDFzZk9xenBMaVo4dzh0bitUR0ZUREZVUVQwK3Ra?=
 =?utf-8?B?TGo2QW5kNTM2TWZGRkVQOVBjMEk3RUh3MlRPSFNnQzR5MVZlTGNuREkxZ0Vx?=
 =?utf-8?B?Sng5MjhxamZmWlkvRFlMTlAybXZzeEFXOERzalNKcWNpT1MwNFJQYmVjSHZJ?=
 =?utf-8?B?bTIxcDVxVVFPNk5uS2JTTDFhMHVCU1pONnBLZXdxeWd6R3J2NW1EUTJCakZY?=
 =?utf-8?B?T2N1QUhVckpFU3JkZ28ySU9qeXFjWWY5NDE1UVM1bjdibTlrQ3BYUlQyazc0?=
 =?utf-8?B?elUxTGpPYUp1a2JLVzlLYmR1U3pxSUlkakxreTYwR3JST2pPUlJscmdwN0NO?=
 =?utf-8?B?ZkM0bUNZdkFORlFBcDVIMXM4NXdTUm5GTDBSbERlb0JwRU9GWSthb1Y0YkZl?=
 =?utf-8?B?aWRxSXBoNER4TDlWcUJTWXBnREtsaTYzbmpEZlVaYmxjNmUyOVBWMlQxSERr?=
 =?utf-8?B?eitmUFJvWXVIajg0VmFwbDQ1Yjc2ZnVDZUlyQk9DUzFlMzRicktUTld0R1Y1?=
 =?utf-8?B?czh5eEhQMEVFTjdjZ1F2RjV1VEIzVFUwc0FLYm42QUhTVCt0aGxDcjNZVTVL?=
 =?utf-8?B?dS9vU1VUcExncHFsYmo5cXJzMW1xMHNpUzg4Si9NUmcyNjVuWVQ1NTV1SEc2?=
 =?utf-8?B?UmNPNU1iQ0RIS3BYdDVOQTVQTE1hM3FCYnFmRGl1eW1yT2k4dGRHT2RIcXc2?=
 =?utf-8?B?QTVjNHBWK2ErYWRYZlJySEZISHJ0ekw0ZjBqRDJGdHR3VGRBaTFDUWdDNmI3?=
 =?utf-8?B?aDFndG8yQUJCeFVLV3FDTUxmWXAwNGJpcEQ1LzZ0MCtuMTVWZzZOV0VsUDdm?=
 =?utf-8?B?NHVvZ01XZVl6UHVkc1lTY2MvdzVKNGF6UE9FYzM4VDFHL2JOMHpmRGk0RTA3?=
 =?utf-8?B?Q2pBYXRzc3g5VkJBOHZPVGQyT2tvMWNWem44eWFDRXRsS1ExYnRzWmNMamRW?=
 =?utf-8?B?R055bGVhdnlMU0IxUGpkbFRVblhycGhoUWdrczNiRXQxemRraW1wTzVJbzhG?=
 =?utf-8?B?V1NoZGkvcUtTTjlZdUJ3eHlsOXZJeXp3UDJNd2N4QWdJU1I0V2F3UVFNV0FW?=
 =?utf-8?B?QmJ6czNic3l5aU5qZFV2ZjNZOEd2R2Y0Qks2REZPdmZKMll0N0ZSMEtxM2FQ?=
 =?utf-8?B?M3hJZWJoMmVoOStmVVVzTGU0d1hJWTNURVN5bitRUHB6SEsvaThSYWw3OXVa?=
 =?utf-8?B?VlFTVVk3SEU5VG9Tb2dSWThqT3hMQzhHVzZGUUNPZnVoNWdITitJMVNFeEkz?=
 =?utf-8?B?R0o1UUdGT1Y3OUcyMVMwSlR2WWwzV0hqZ3lhQk1IRGp6WjM1b3pnZFVBRE5G?=
 =?utf-8?B?elJtbkVZdDhVenoyYThLNzBzZHc1djBLVit2MnFmU04yUVE3NkZaQ2dUa00r?=
 =?utf-8?B?clRsdkxINWQ0T1Q2T2I3c0h6Mk1UVVBoTjdBb0VUb1Q4VUpIZEtqbXdhRSt2?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b892a1-6891-4291-f68f-08db0df77281
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:21:03.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb+eZNs27Kmg2HnrcmjdLhJDkSs1Kie0sFkNpBe76TsYB2Sm3ggenwEEH4kmKLJqLLSFy2vB0XNshnioI0i0FOfOGWY1jBgzptLE7Scn4zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8240
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 2/12/2023 10:24 PM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if an error
> occurs when parent process runs cat_val() or check_results(), the child
> process will not be killed and also resctrlfs is not unmounted. Also if
> an error occurs when child process runs cat_val() or check_results(),
> the child process is returned, but the parent process will wait pipe

"child process is returned" -> "child process returns"

> message from child.

"will wait pipe message from child" -> "will wait for the pipe message
from the child"

> Synchronize the exits between the parent and child. An error occurs
> whether in parents process or child process, the parents process
> always kills child process and runs umount_resctrlfs(), and the
> child process always waits to be killed by the parent process.

I think the above could be easier to read with a few slight changes:

"
Synchronize the exits between the parent and child. An error could
occur whether in parent process or child process. The parent process
always kills the child process and runs umount_resctrlfs(). The
child process always waits to be killed by the parent process."


> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..477b62dac546 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -186,23 +186,20 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	remove(param.filename);
>  
>  	ret = cat_val(&param);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_results(&param);
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		ret = check_results(&param);
>  
>  	if (bm_pid == 0) {
>  		/* Tell parent that child is ready */
>  		close(pipefd[0]);
>  		pipe_message = 1;
>  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			close(pipefd[1]);
> +		    sizeof(pipe_message))
> +			/*
> +			 * Just print the error message.
> +			 * Let while(1) run and wait for itself to be killed.
> +			 */
>  			perror("# failed signaling parent process");
> -			return errno;
> -		}
>  
>  		close(pipefd[1]);
>  		while (1)
> @@ -226,5 +223,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (bm_pid)
>  		umount_resctrlfs();
>  
> -	return 0;
> +	return ret;
>  }

Apart from the changelog comments:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much

Reinette
