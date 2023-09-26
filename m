Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E77AF795
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjI0A4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 20:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjI0AyO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 20:54:14 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4426BD;
        Tue, 26 Sep 2023 14:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPp5m2uDy+5MEzmSIsXL9ZCVIydvoUIJfGOp++OW1FWYX00kIVFlnEEcQoNT0XRFeIAXF0XsWURDNHrK0lz+peOkTVGv9SPft9EFe0rbF2csqE/xsjrGZiWCxDPYmjYzbDKc8Ok+90Uhp8fyPqQZMYb2MlO36oYSTwrYCYuMZFCz0zSVISqG+WdKo9H3WReDGqkl2h9oQGnKZh/ESivCZA3aaWEMonHv7jHnZsJdxD5OYNkitZVP2Cpu6JcpM0zySYOcoL1ZVR001rn87eTbqh3U9u/stUf9hlqeTciWapT1eWpUaB+aub/m4Ic++Oed4Rv3ykTAanXqoVyAviSJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfNnIo10gO2cmvXLqQkMPlUlYPN6fzRKzz2RFShqYqo=;
 b=ITcA3wJRY3yaUHaTZLdM0It1SUWJDwYqgM+R6FXvzFSZpeDJV9jJ43yNvuAhLYVuUnGhirOKLnNbaZ9MN4dKqVVfU186VoAAqbTPioZE5kPOOvNjYPb2+qR9U/8OFWXVsMaGLVnYcM2uIOxfxAoQ5iJ1ccxDHSXRADet92tsOsQryDTtTLDibUnC8FLPQZL57UGc9ci0p1uqgokX8tH3Gdj1ee1ZaBBRoTjPc3VTmpGYr0kk8hj00icSU8GIUQfmzZejixLuJY/hPg1/X4EcGRF7th5phkwgyzEPQ4oo2OCy3A/01rGa7Cd8ln9Sno18MoEdeEX2tzA0lYK2fmhXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfNnIo10gO2cmvXLqQkMPlUlYPN6fzRKzz2RFShqYqo=;
 b=fcybKPA1SoyHb4Q602/tczWLSArpYM6orak4+5ly9psFh8JttwZ0b8QYptVJlTq8W4BIigcdxOCFHsoqfEueRB+jJhVNsdjZKThyYB1R69JIo+GR/V+sRXlNYUR2Ld8CjRflmK2o43y/lO85YrSVeJLEI6br1oDhROwCPLlAEaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:03:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 21:03:52 +0000
Message-ID: <c17b0269-a085-ee50-af3c-fb486b303577@amd.com>
Date:   Tue, 26 Sep 2023 16:03:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 0/8] selftests/resctrl: Rework benchmark command
 handling
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:806:24::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c43e27-21d4-4f28-63ff-08dbbed41684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufi6KA+bsGcIpIxKQ2LRz4iKWTb+M9XtJlNNBWbm0uiLA0ApaqEYLPtuE5YSyZfuYBgBTwZPig8YgKwjbQigyveaBSn3r7ZoPuulmr9jDSuP4E5c06DgAEnZN4XoaBo0G+6ReJiuMzNSmW1+EMXFPZG+ah8mjMoosEdj3OtnDvQF4UBYM8ZaJ2EndSV4py9YFTD78ra7XJZBL4B5wgBQs29TRouD/qdQbkdd/0oCXjrKNzg9aMO9MZLU+8ppvYdM7xdOGMHUslYao8QOC8rxxuiPwhF+myoO9S3rjOssvGc/d/NYcKhA0gH1slmbwNIg4jKwnsehUPLhxav9jIwh12dZ0Ek5InIfjXfFK2ZZaLUsxx+wExR3TN8PuQyUYXXk4ZFKYg8tBs7tze9/AAS+oq6HJqT+aYPX9Qrp+k5blMkH41YFxo1SIFDx545jhK8XBFpzi9ta+IV41mA+471PYg+JQAwFRj7kZME8tlPtAuWin6hxOipPU7cd1wh3i/zhVu1CkL7f9KtnTDZvrWNFgNJB3l5qbYsWeBAUa9X09CqRxQU7249qvU5OluNzTp6hPMO9WPVTmMv46xL5LZb7qKNsXMPdRk0RI+EOFP2brGyU+swZIJrddMnOSAx0ju46DBO4gYb8Ta6TJMTcqJatZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(3450700001)(2906002)(86362001)(31696002)(26005)(53546011)(6512007)(2616005)(6486002)(6506007)(478600001)(36756003)(38100700002)(83380400001)(8936002)(8676002)(4326008)(31686004)(41300700001)(66476007)(5660300002)(54906003)(66556008)(66946007)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdPait4U0h5dkN6cDhEQ1hucEQxeDhxSTA0TFBWbFN1UzBpWU1FSGUzMnhF?=
 =?utf-8?B?UXlZUE5aSW50aWpwSTZ4d2pIN3pjdmQrRkVFNWFJaWljQWtnT1M5T3JtK0Vs?=
 =?utf-8?B?TFJET3ZDOUx6S1RqcWEzOGpQYnR4NmpsdDlzY29tWjBPSmZjTGlydHZYY3NO?=
 =?utf-8?B?Zkx0SUhoQTNpSE15NXBjMFNZVHNnUCtDMUY2THhyTkwxWktMbHN3NmtUWW1I?=
 =?utf-8?B?NGt1elQ5OUpFVjFVWWZOOG1uV2M0Q2QzVk9KWERkRWNISnpLM0poK2luRTlU?=
 =?utf-8?B?cnkwSm1QZE1FTktEVU5VWXdZazNacTNTRU9HSFNPeUlzTS9lWEtGeXlrZnBQ?=
 =?utf-8?B?UlgwS3RraE1XR3ZvZFZEWHBlQ3VHRHJUYXF0UlhKVGQ3SjR0WC8rKzNiNE5Q?=
 =?utf-8?B?VUNNcmhwc0gvaXdBLzE2b0k4eU9RUm92VHdyM1ZCT0NoMytrUWJncUNHYURu?=
 =?utf-8?B?em0wVjBleEpSVWc1dXExNmFBckYvcnRDTnBpbXRJOGNlZUg2ZG0rRmZKMVhD?=
 =?utf-8?B?VGZIbTh3Wm1pVjVnSUN5Z2IxU21ZSzZlc1NmVFdMRndhb2tUNkJ6Ykk1em51?=
 =?utf-8?B?aDZSbkF5YkN2V2JNbjh0RXRUTC9HYVRLYVNEL1FmTjdXZ1NrQ0thZUFCZndu?=
 =?utf-8?B?eVZxMmhUcUltalJQL0d2MC9DWkZ5SW1nUGlvQU9UTE1jVWw3QXNSaHllSEZM?=
 =?utf-8?B?bXJSUVpVbjJrSEx1ZXV6T1JOU0MyMGl6WTJ4b2pBKzhBeWNkb0FWY3VvSTdy?=
 =?utf-8?B?bjZPeUNaQjl2MHdpb1lWUUh3anNOV1Q0UlUyOWpHVG5vUC9OSmVLYU5LWUJ6?=
 =?utf-8?B?ZVovVnZZZTBudStqVzZUYUt4VU92d0tQQlpyMWdRbWpEc29meWVIY1l3SzFJ?=
 =?utf-8?B?SU43K3hoTWtHNFhING90V3o0dlhqWHBKanRjWFRpTFNYanhrbEN1enpuLytB?=
 =?utf-8?B?OWVzOFJxaDUyZjR4amd0YkgyR2hFb1Y5QWlLUzgwWjlnOWhRV1lZSGlJcEpV?=
 =?utf-8?B?WW9XQ29HLzA3Ly9sNVhHSnp5S2VjamdlN0ZqL1htdHJKbTdWS0FzUHBMQkdI?=
 =?utf-8?B?Z2R5K3VzbGJiZXN5K0lSQ3FPS1lLbWp2UE1qWldaTmN6VmdudFZPYVlZUVM1?=
 =?utf-8?B?OXVMdjVUQTV4V1plbnJpNURKZGd4dFFSMWZxZVo0dGV5citvWmFuMW9tYVFG?=
 =?utf-8?B?OTcweHVOdlBUSVk4ZkM3WHg0WUV1TWRBcXppTENOV09pYmZkdXp0dytzWnhS?=
 =?utf-8?B?ZEcrUncvUkhVSnZiSW1zR3VweEdIb1V6ZUsvZTJDTWRta1NkVVJDTVdSeEI0?=
 =?utf-8?B?TTF0dGphUllLRE4rZW1oQlF6T3NFSUFPTUQxMGZkd3ZjcmoxY2pUSkxuVVFP?=
 =?utf-8?B?MDlMNFh1SlJEMFNseFFQLzYrclJzUkJrUXpnSGRoSDRjN3lVZHlPREQxU0FI?=
 =?utf-8?B?VGpVS2xHYTZDYUJPY1UrbnFWUlMrb2dYaWF1dWwvV0VsV3FSc251TENmbTg2?=
 =?utf-8?B?M3ZyeVA1aDVNTXlhRzg2UDEwb29Bd2RrcTdheWpnV3FFZWRzYmVKbnRiUFB6?=
 =?utf-8?B?b21qVmpQYXpXeCtQdWZENE1nbWM4N2R1RmxNTVp2NDRMQWRlR2lSei8zNThG?=
 =?utf-8?B?YXFEc0dqTGl4cTF6WmVKUkVEbUFLOVBPTTkxQkVzUVFGcmdOZ3FtVGE1Zkdx?=
 =?utf-8?B?azJaMWk1WHNxcXVGZndZc1RwNWVWa2N4Sk9DbHU0V2RjVjdvRVRpWGQ0ZnFi?=
 =?utf-8?B?TlVUS28wdG1pL1ZjUHlrMUV0cmVnUVBGeUpTQ0t1Q0NCODhZbVJuVk9Jc1Nk?=
 =?utf-8?B?WDlmR0FkTmpMS01RVGkyMFEvQnFoSUkzUXU3cXRveDUrWm5sVHljaVI4NFJy?=
 =?utf-8?B?ZWtmdGR5MjRLUFZkNllRWlNHVXE0MThuNm85eUtNYVlieVNRd3MzemsrcjBq?=
 =?utf-8?B?QmhwZExlZWdXcjlydm1DekNsZ21nSlBXWEFCQW9uQUV4RG1HaXg5T0dYb0NX?=
 =?utf-8?B?cWplMTVTelJmL0NzczRjSjY0TUNadnlYQnpKOUx6NVlZUEdUcUFjbHhpQnIw?=
 =?utf-8?B?bUYyeDkyQUQybmxZamZWRzlRck5HSVRLelllWTc0OVlVc1FPRWhXM2d6amFU?=
 =?utf-8?Q?jV7dXduprvI0yGmWKPR+O8d9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c43e27-21d4-4f28-63ff-08dbbed41684
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:03:52.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEhvIELtV077M8EmMtj27NotZHlIfj43eWffASZ/Yr+T5OxjQabCxkPcblSxxqmV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tested the series on AMD system. Looks good.

Tested-by: Babu Moger <babu.moger@amd.com>

There are few tests which are skipped on AMD. Will plan to look into it.
Thanks
Babu

On 9/4/23 04:53, Ilpo Järvinen wrote:
> The benchmark command handling (-b) in resctrl selftests is overly
> complicated code. This series turns the benchmark command immutable to
> preserve it for all selftests and improves benchmark command related
> error handling.
> 
> This series also ends up removing the strcpy() calls which were pointed
> out earlier.
> 
> v5:
> - Fix another off-by-one error
> - Reorder local var declarations in main() to follow rev. xmas tree
> 
> v4:
> - Correct off-by-one error in -b processing
> - Reordered code in main() to make freeing span_str simpler (in new patch)
> - Use consistent style for const char * const *
> 
> v3:
> - Removed DEFAULT_SPAN_STR for real and the duplicated copy of defines
>   that made to v2 likely due to my incorrect conflict resolutions
> 
> v2:
> - Added argument length check into patch 1/7
> - Updated also -b line in help message.
> - Document -b argument related "algorithm"
> - Use asprintf() to convert defined constant int to string
> - Improved changelog texts
> - Added \n to ksft_exit_fail_msg() call messages.
> - Print DEFAULT_SPAN with %u instead of %zu to avoid need to cast it
> 
> Ilpo Järvinen (8):
>   selftests/resctrl: Ensure the benchmark commands fits to its array
>   selftests/resctrl: Correct benchmark command help
>   selftests/resctrl: Remove bw_report and bm_type from main()
>   selftests/resctrl: Simplify span lifetime
>   selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
>   selftests/resctrl: Make benchmark command const and build it with
>     pointers
>   selftests/resctrl: Remove ben_count variable
>   selftests/resctrl: Cleanup benchmark argument parsing
> 
>  tools/testing/selftests/resctrl/cache.c       |   5 +-
>  tools/testing/selftests/resctrl/cat_test.c    |  13 +--
>  tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
>  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  16 +--
>  .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
>  tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
>  8 files changed, 104 insertions(+), 85 deletions(-)
> 

-- 
Thanks
Babu Moger
