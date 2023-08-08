Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B074773B47
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHHPsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjHHPq4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 11:46:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F50421C;
        Tue,  8 Aug 2023 08:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcd5UJX2KQARVu4r0qd/wajFN3RxXj+ZABJN4t7HfIkMeSp3ALCg9n3+Sq6Pj76i9Wv0nQjMDxR3CE5rXZcUr/Ba7m3ry+bFiQH8/zgSTty2UpsZRu5G6tGTyP7hB9DzA61qOtCGcGtUaDUkShSZgwna30kqPLIVybrdPnNWDHNrLkIIatsT9lrBZu63oNOlHsTfM2rrbhgsTsBfEP8RjwqwtwZjYTFgz+YeDAjC2vdeRywE9orMcwW67ZLmtL4F7GSfE8JjyeVxaDACDujUH+dmmtU7CT2GaIxm8rM2pkd65yHZVXFY2apYgb0Hn55uYAZ3MrrAKYo07XPebT01Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1fEJWmMSkweRj171hOxDzKbe6/eaIiDsKlBNNFeg88=;
 b=KpYNeFIQMCd2644RsrYUit+FGATWMlGOoXbImW61kUtmAHGbgZ31t48dAQHqj98XYFw4jqLArD27rVozjO6ciISdjqglpdCyCIx91OtNXcXFfmhaAwnv1F/XtYO2Mwk2aO0ngjr89m1WYBYtC8t6I85r3Kr50hFAl3yehClSu07mgSwLhT2EO2eXJOelsvKEKdFVqFD9TwNIQp8vRAD+kNZ2jRMKLzEY6ykzAfd6tvrWsZDZe09mVlYcow1rB+keGuxyd5Au0ot1h4iu7nXKpJQ0hEmzW0kDzQZ4SVy3sTQzqc1MH4nP8+9bnJvBGB95iaeqBINmasBBBcHc9quOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1fEJWmMSkweRj171hOxDzKbe6/eaIiDsKlBNNFeg88=;
 b=OouNbW8Bvbxl1k9vhCcpgUTzoELw/kAITfxaag2ceb+7vJW+POqrx42vV63X7JNHrO+MxmwP/npUzTsrh4Mwttg8KQ9U51XkdiLe4QfSV9U+k/6BaCpvLyCmk3PXIDYXgO+OFOmRYYguqlB4JvDs7G7MwhfNv/6aMTkNnkitDDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:40:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:40:54 +0000
Message-ID: <ca4c387e-77b8-4a16-94b0-b0dba2d6cbc7@amd.com>
Date:   Tue, 8 Aug 2023 10:40:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/6] Documentation: amd-pstate: introduce AMD Pstate
 Preferred Core
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-6-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230808081001.2215240-6-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0148.namprd02.prod.outlook.com
 (2603:10b6:5:332::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f51c43-3a9d-4e77-fd0e-08db9825d9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h/Y4g1kHrmm+l6FRxtx3iBTJYGeEw3K3r14UcB4nQLLtLCtnbIN6zyMitTVJNyTpjX4A+xgNSVgb5BjbdDy+AE9CnPlWLJ/Pnc04Hnqcm9Zr8XJ/mOtfafkh0lq0OjVOvlcEI0HHVCBIgWXhEdVJZ/CxlFb7A176pjN5ER4pUxw1izLhSQNQgnKgMHMVD93VPr29OHtSD6IrK4WxvdPS81WjD8CuEcqFzMUJCMpjDRWuSL83zHi7laVirXsdPXgi39yr7uO8gy15N90icX279/RYMZRsUVtzDFu6IUulhxpKf88L1oZWCZdvoX1EYYZONZj9i1Tjrxu1BL3w2f2m6nWVA/bJ33z0eZLGd1oFeqZPh4KA+K+onU7gK1qvp25DfMXAX9vpPAzsndKG+RFEjhI3wrkd6Te0rz9Bb2rsS5UQz5tt5fQ7GS4cFpfGBetnOf++NMaEWZYFScJrmYpzkRdaBrBwfWDjR7kffODZFgLZbBgJI45BUxrFXadBsMXJX4larmKiBWHZLH+MN3Kr+aCJI6+ZV8eoUydwkJkazWJqDZYMChgKzotSirtfwz7fpozK2SFnM03scByrBOeY8YGjZwCO61CR65HwqVk6zBq579C4Ey3n1W0rC0rhoSdEO9061wnz6nUR4X6kshpVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799003)(8936002)(44832011)(8676002)(5660300002)(6636002)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6486002)(6512007)(6666004)(2616005)(53546011)(26005)(6506007)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(110136005)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJWdHJPZllORis1Vnh5SUJBNW00OFdCaSsvaWFZWmRJcTIyTzVucWVwQmdq?=
 =?utf-8?B?cFR6Z3ZMbi93bUJPcy9EdzNQQW5WbTlhWTNYd0lta09nRmh5YjhDV2R3RnFD?=
 =?utf-8?B?WlU4ajUwZUJBNDU4S0dQQ3lZQ3BmT1RKSGQ3aElCTXROMWtrL2wrSXd2dmxt?=
 =?utf-8?B?R3dJOE4rVjBpOFl0Ylk3d0JBRjFHU1BLZGtNdGg2YStaV29qeHlvZEhxL2ta?=
 =?utf-8?B?Sng5THptRHFpN2RxVEtDb25JcjU1OHVGOXNzZkp3dXBNUTYwN3czMjJTSEwr?=
 =?utf-8?B?WHpWdjF3cGxzOTZxb2NFalUvbHFCdFROeWdVUWExOElwZXovM1ZGc0I3TXJV?=
 =?utf-8?B?djBHMWk3ZHVxdE5wVS90NmpETi9ieGIxZXk1dzZsU2RZY3BZeGpMVytlbGNL?=
 =?utf-8?B?N1RSUDU2ZEM3TEJCNW1PL0tZdXJYWGVTWGJwVll5TytHbC85WW10NEl0RHdw?=
 =?utf-8?B?MldoRmRqckkwREpLNm83aHBjek5FNkRHQWdwQTk0UWZvd04xajRseWdLZEVr?=
 =?utf-8?B?dTV4MWw2bjBVOU1jRUlQUHpJT1M5VXRHUTloOVB5dXdKVlRUenVGVlNXNWRB?=
 =?utf-8?B?TWJxT2lSVHQ2UytTRUtrTzYyeVZWSHVYK2wrUWkvVjl3U3lDY08weWVKRUlI?=
 =?utf-8?B?NEJtdnBSTzNPNDJRVHF2UFJCWmU3STViN0Z2SlJ6c3pqMCsxdjFOOXdnNnR2?=
 =?utf-8?B?b3dsRmxCVEQ0WCtVa09EcmJRa1N4RC94OXhwZ0VGTlVCdE5PUytMTDZ1OGUr?=
 =?utf-8?B?aXF1b3F3eFhIbUV1N2FUb2tTRldCVHFDa3VqZnBRRUNzZnNqMXVKRTF2WWVs?=
 =?utf-8?B?WnRJbWozZms5b0JRa1U4T0FlK0Evd0xvZ05jWlFMM2l3YzNXTjVmcythblIz?=
 =?utf-8?B?aGZoQkN6NENxVk5mdHNoaWlBdk5tREgyakhXNVNnY1NnMkF2VENLTFMwWmtY?=
 =?utf-8?B?THpibEYxYVNiQW5BaW5YVnoveFhqcFI5aWxyZ1ZUTzhEZ3ozSXVBL1Jwc0xQ?=
 =?utf-8?B?Vkx1dWpHaEpvTXVLNHgvMERrZWNZNVlEd0NoRmhCRXFReDYyQ0RGOStTczlN?=
 =?utf-8?B?R2YyQWJET2kzL1lOVTRCZnlDblpZMEhEcWRKZ2FtTTl1aEVrUUszY3JHMk4v?=
 =?utf-8?B?RW5TSHNtNWp5V1Qxc3A1OFdZVUxKaUV5NHJEQjZodVRkalFxR0dSMW1rbHZS?=
 =?utf-8?B?VWgyck5ESDlsbGI2TzBEa0VBRk1ZNVB2ZmtHckptUWFCZHcxSzFESWhQbldH?=
 =?utf-8?B?andhY0RNa0lSMlhlRlBqM1pSTzBVVU5iTzNLTk9tY09va1pDaW5aM0ljQkNk?=
 =?utf-8?B?R2RqcjFUMWlZd2F0eXJuSVNqME9kaEVZVFlMS1Zadzg0RWkrYjF1RUpUSkxU?=
 =?utf-8?B?bTBOeUJKak5hWTQxMjlicVBrd2t5Ums1VnBKa3p1Y3Y2YS9ielFLVHZUNmor?=
 =?utf-8?B?L0g3emVoVlNXNlFqdzRMaUd2dmhtZU96VjhjdVdTNkpoazhJSi9seHAwZElq?=
 =?utf-8?B?TU5SeGE4USswaEx2RUtIWU1KY1RJTUVuSFQ2bHp3NGNwZUg5emp6L1ZpdlJC?=
 =?utf-8?B?QXcyQ2N1UEJUR3R2S2lTTk1kSnl5NFFMYkREbnNiS0UrcnptMkJWMVpoSVRm?=
 =?utf-8?B?K2dXNHpHODJtTGZWMlZCeFZ4T2xVSmtJQVNiMkk1cnFpMm1kNVJ3SXNjdVc4?=
 =?utf-8?B?REZtYkdWZUt6RWNrWWNvK1B4a3BBcWVLWksrbHMwaUVmRHlxWVlETmpXWlpB?=
 =?utf-8?B?L2VrMnZzeVpyZjA1NjllTER1TlhzejlGbm05VkY3ZStRMDJIdTdyamhkK0lq?=
 =?utf-8?B?SjRCelY2anBiOHAyemx5a1hKRmRsaGdSU2hBaVU2TnVZZkxiRG1mQkNTYjlt?=
 =?utf-8?B?RXk0T01odWw3VWdsUDZ0bGJrQlRKODY4K3VUVzRCTmp4TTZOcDk3Qy9rbU4r?=
 =?utf-8?B?Qm1XZmpTeFlMRGVKZWl4a2Nqc3Q4dVhtVVkyRU9oOWJJTVo0Z0hONHBqMXk3?=
 =?utf-8?B?b1VsUEl5VEcva0lMKytVcGlkS1BrWHRtenUxUWNlbVJtUlhNY1cvSmxwdTJF?=
 =?utf-8?B?M2l5YTMrY24xTnpFaVUyUmZMWXB0c1B6NlZPaFZINTcxcjlWL0YvN0FmaXl6?=
 =?utf-8?Q?0cjLj/kXyP1s7Q0kNrnCy8vpe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f51c43-3a9d-4e77-fd0e-08db9825d9fd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:40:54.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2OUxqlUA+Ys8ToMzZ6PYh+LMJNEANavIOjuqSjC6+66LqWyCJhGt62k06ZRdqWMeDnUuhUYvC5iUhefK8pIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/2023 03:10, Meng Li wrote:
> Introduce AMD Pstate Preferred Core.
> 
> check preferred core state:
> $ cat /sys/devices/system/cpu/amd-pstate/prefcore_state
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 55 +++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..4a30cf235425 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -353,6 +353,49 @@ is activated.  In this mode, driver requests minimum and maximum performance
>   level and the platform autonomously selects a performance level in this range
>   and appropriate to the current workload.
>   
> +AMD Pstate Preferred Core
> +=================================
> +
> +The core frequency is subjected to the process variation in semiconductors.
> +Not all cores are able to reach the maximum frequency respecting the
> +infrastructure limits. Consequently, AMD has redefined the concept of
> +maximum frequency of a part. This means that a fraction of cores can reach
> +maximum frequency. To find the best process scheduling policy for a given
> +scenario, OS needs to know the core ordering informed by the platform through
> +highest performance capability register of the CPPC interface.
> +
> +``AMD Pstate Preferred Core`` use ITMT arch provides functions and data structures
> +for enabling the scheduler to favor scheduling on cores can be get a higher frequency
> +with lower voltage under preferred core. 

This sentence was useful for the commit message, but I don't think it 
should be in the user facing documentation.

> And it has the ability to dynamically
> +change the preferred core based on the workload and platform conditions and
> +accounting for thermals and aging.
> +
> +The priority metric will be initialized by the AMD Pstate driver. The AMD Pstate
> +driver will also determine whether or not ``AMD Pstate Preferred Core`` is
> +supported by the platform.
> +
> +AMD Pstate driver will provide an initial core ordering when the system boots.
> +The platform uses the CPPC interfaces to communicate the core ranking to the
> +operating system and scheduler to make sure that OS is choosing the cores
> +with highest performance firstly for scheduling the process. When AMD Pstate
> +driver receives a message with the highest performance change, it will
> +update the core ranking and set the cpu's priority.
> +
> +AMD Preferred Core Switch
> +=================================
> +Kernel Parameters
> +-----------------
> +
> +``AMD Pstate Preferred Core`` has two states: enable and disable.
> +Enable/disable states can be chosen by different kernel parameters.
> +Default disable ``AMD Pstate Preferred Core``.

Why default disable?

> +
> +``amd_prefcore=enable``
> +
> +If ``amd_prefcore=enable`` is passed to kernel command line option
> +then enable ``AMD Pstate Preferred Core`` if the processor and power
> +firmware can support preferred core feature.

This can be simplified as "platform can support the preferred core feature".

> +
>   User Space Interface in ``sysfs`` - General
>   ===========================================
>   
> @@ -385,6 +428,18 @@ control its functionality at the system level.  They are located in the
>           to the operation mode represented by that string - or to be
>           unregistered in the "disable" case.
>   
> +``prefcore_state``
> +	Preferred Core state of the driver: "enabled" or "disabled".
> +
> +	"enabled"
> +		Enable the AMD Preferred Core.
> +
> +	"disabled"
> +		Disable the AMD Preferred Core
> +
> +
> +        This attribute is read-only to check the state of Preferred Core.

As the attribute is read only and won't change at runtime, I don't think 
it makes sense to include the word "state" in the sysfs file name.

You can just rename it to "prefcore".

> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   

