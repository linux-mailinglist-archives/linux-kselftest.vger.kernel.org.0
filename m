Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653177CEF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjHOPUg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbjHOPUL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:20:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0287173C;
        Tue, 15 Aug 2023 08:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+G1andYug4s8SOJjltEWEmnsWKND3HNnY5AE616DCawKHo+M61lFaeWAY9+evoX36KDmfvAdvt2IpJb+JnInS3h7G70SgbjOxJj6o2/TL+/1i34uBq2EAgAfOKpTChuIYfQn8dSsQMqoRiDVaIwTo77G8hFDNb5IFvvBFt5i/bcK8OGUeYAK+3uy+7IQerGBb0SKivHG6kaWJNP3HrcKD+UwCDJ+7FyiKh1cpDC1Y01/QaPMSdUWR4XcY1fRb/NymVxuyi7YvV0NEkoEjoWorJlI+0b8fZOLFarA/XIKP54gChhs9o7EMjEbCUxGy30qePVxNfZUDNnIJUYq6ojsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wYeLzIt3x9uzkecseLExyNPtOoOiE7b5oW0utbq6rA=;
 b=N3BYLjPtvCi5PC58VkwoaE/drICnPzR+/2z807eVhZETYlI3PeqWsR+FSiqhB94vCgImTaNUFKjpooALfdAcwFQEIIF8gFAs7gzwYQNzBdOlytUsOo2UL5wKPDGBvYhOaLhVscvgstf5LxYRXL2Mv6oO157oWZp2ZLbLSSZf1dhkWyEK4VYZEqItXAeKBcO3mdpZ18eJQVwT+zLuWmFvYo5ZLRzwuqRWYDm6zZ4qofjhSV7aDITK3PJAMHxXXEWr+H/E4UkDkRf8gTKx/7Tbqizpykl16cYt5Pjk8uxuaQvlT9uUc9ITO03m2wA/lAYfjnqHE5qpSYNhtiDR44boFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wYeLzIt3x9uzkecseLExyNPtOoOiE7b5oW0utbq6rA=;
 b=EAER3j1Sppc+3lB4yQ17yurZfgcxsEA3/nnA915svszygOABQOGeQTrcxKPzIui9wrfgDQiXsrbD+vwH7tLguA7rJVtmigofiw/CPIOrq2Gll/5LDzKYFHbpjuG5yVgXkLgLPf5vNnem1wfgkCt5LSToMEXbAI2E5sNF0DkbElg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:20:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:20:06 +0000
Message-ID: <dca26c63-9a89-4be0-aa60-6dc99b7927d0@amd.com>
Date:   Tue, 15 Aug 2023 10:20:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the
 expansion.
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
References: <20230815061546.3556083-1-li.meng@amd.com>
 <20230815061546.3556083-2-li.meng@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815061546.3556083-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 13567338-0813-498b-fa47-08db9da31ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibX6VQ0UVnz/iuprAdzsohKFjkD/6pKmYNKaHxJpSsghFS/1UjY3zNQSpUpmXrLxTA0JtG81UqIKp/7Af1fA4IcccJpvYwLd51L67oZr99nTn1b9pq1A4d9uJpObhFgM7EItmj7b3BnKUwMB6evUkNOchvRcLlWiT7Dmybnm8AKNViQgG3bsQvbd7yh3El5A4jc34VNbcqMgn3w05sG2M18kAOWbPl+uRWnge7co3DJnyzgnIPyW6WN+18azgywDRTeohnk+43gvzaZ+fusqWnaGMTmT1ymwDI3vHErw+gso5YP68dojcBAAjeEh7lT7JfAD/HS9e3mxSDxD5slSiNZjn5h4lBjpB9obXstXuMHCa0BTaV+5eHfENKhgMU5ZHdYZrip4HS2+aG/0vznCujVgKgKZj2PdOJ+J7REITk/g94/tBUiZCVrRMsEYwkFYlwzrLYHiVvfKGVD+Y26R/3wQtBEjzbx8FUVXhkOlKMwpox7KZEBCIVf5oOuZFZ926TsRtn2dbxJ0ESi3D2GAgAGMiHYHcthgAWKMNNblJdcdugrRRNHRbe9itH2Eq1anvR2xSYZ3wAGrDeInOC5yJqProi6Bg4bPIMNRTGgXwBZwnGdXhGJx0IxepXvA8WQRjcvKNJJAOXOFAQO/mw+vUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6506007)(31696002)(6486002)(31686004)(86362001)(8936002)(83380400001)(66476007)(36756003)(5660300002)(41300700001)(8676002)(2906002)(53546011)(54906003)(6636002)(6512007)(6666004)(110136005)(26005)(66946007)(478600001)(2616005)(4326008)(66556008)(316002)(44832011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJiZ0VFa3FqNEdoa1d4eEQ2TWRZc0VBZ1B4T0lyazUxV3Y0TDBRcHJjUXB2?=
 =?utf-8?B?ZERWVUNyYk9xb0hicTNxVXBtZ21CUWJ1MU80YUZxSTlwdVpCYlFWZkRkRUdi?=
 =?utf-8?B?OEdjc1ZZVFhqZXRTMWpRZTdLTHRhSDJJQ1ZVM0dURUd6U2hWa2ZDSXUrV1cv?=
 =?utf-8?B?N3ZDRThQUTJvYkdhMTdXM00yR1dxaVdxSlV1ait2TlllZGVBQ3g0ampZb1gz?=
 =?utf-8?B?TThJZEhKRVRuYldrdkZ6eHdvTWl0T0JPVmNnNU5YTEJBeDdjOWVDN0NxL2tM?=
 =?utf-8?B?bXNPSVAvMHZtQnI5K3FTd2VtYm40UzZvdW5xek5xZERGRTRXVHFWcXVFcThv?=
 =?utf-8?B?eUVHRFhjYUVRT0hKVzlWNU13YXJTc2dVSnRqQjVXM1Q4bWNlYm12bFE5TCsx?=
 =?utf-8?B?aFljWlN6ZFFONTFTQzNPTzZucEZBYjl6Q3pxb1NvN3VRQkkvcldxQWlXK04z?=
 =?utf-8?B?MFBGUFY0eDV1N1dQT2RaNndWL2gxdDNRVjZQLzJzcmlGbFNYVkIzY3FpMUxU?=
 =?utf-8?B?RDZCeVhYT0lSNWZyOEJTUUticy9JK3RBZDl0YnhrNHJDTVRsTDlsUzdCcnp4?=
 =?utf-8?B?Y0FBRGsrNjVLNTJubkFucHVBcCtVNEhpekQzS0c0SmxFN3htMGl5VDlVcmk2?=
 =?utf-8?B?MFY1bm04aEdxRlVyeGdpWkl3OUM4d3hZNllYaUR3T092Tk1jK0gxNnhMV1g3?=
 =?utf-8?B?bDcydzhRVEs5em53YlMwUkkyMW9ydUZQNW14SlFvWkJjTjFqaEZQMGVzM2tw?=
 =?utf-8?B?ZngwSlFSSmY0Zld3cUFBUTZValp2WXRlL3Q1RzZOemFid2haTWYvSVdJRTRa?=
 =?utf-8?B?MEh0N0lPcmxrNzgxTG8yekZjQll3ZmlnNDdaMDFJMDMveWhvdS9BZ29pNE9P?=
 =?utf-8?B?SkVpV1FmOWVwUG9MYUcva2ZRWVhSMXo4M1VVN3k2YlVsa0dtMllXZmo5VkY0?=
 =?utf-8?B?d3M5OGV6czVJSnE2V3BBeXAzYUtFVTdFUEVQa3FERFptSnNLb3pZdGRsUllT?=
 =?utf-8?B?MUUweGxrbzg2bGloRWhOdGhMQWpXZVdrM2RkVEUxYkkranpuN0dzbHNBbWFJ?=
 =?utf-8?B?K0JUaXhQMVhQSlNIZ2tnSWNDVUNvVWlJMERrdXE2S3VxRmd3ZlY0Q2tpYzhu?=
 =?utf-8?B?TUhzN003b2FCK1FTV2diOUJlZm12OEE0NnZmcWRFbndNbGlySmtGSzZjOEh0?=
 =?utf-8?B?a0JEam1FOEEwanJmYlg2SWwzaS9LY2Y5Y1RmWFFZbjJ1M2ZCSlJRb3JydWNS?=
 =?utf-8?B?R3dxUkdGai9Za3V0MHhpQjJFTWpxdWN2dW5HWVZ3S1UwUGQzVUdwK3VKYk13?=
 =?utf-8?B?YmtJNG5JRGVsbHhLaUZ0bmZ6Rzcvc1RkRTRpOCs0dmsrMysrZlpBYVQwWHJt?=
 =?utf-8?B?Yyt4NTlJN1NnSVk3KytJRjhsNXdNQ0lEdmtNNGg0OEE0QWFUVGwydkkySGtS?=
 =?utf-8?B?SVRFQ3dEQWlEdnpOdVZoWDBzT08rd01SM252RzNzZEZxWURXZVBUV2ZLUk5h?=
 =?utf-8?B?RFZ6R0xYY1lZVDhBTWUwbmw3UHQ1dmtibWZseGE2TTYzSUFDSW9CMTRwTDky?=
 =?utf-8?B?LzZ0V0RHRWRnRGorSWlreHplYTYzN1hsQzg1ckxpMk1VcWR2bndEZlBlUk0x?=
 =?utf-8?B?YnVFZHBrcmVTSlFqL3FqclRZcDF1Rm5UNldZSU44VWxsM2NxT0RuMElVditq?=
 =?utf-8?B?UDVrYktrdFpiWW8yV29WdVNHeHRpbVA3N0dRUWpHZ0ZyKzN2YjRKUzRvbkJC?=
 =?utf-8?B?dG1QclNtemdKYnJYZ2l1TkNDWHlSSXdxaGQ4RUI3alBHWklGZ2xWdW5Zamhr?=
 =?utf-8?B?cTFMWXljamJBd3o4YWRFdEYrZFJEa1NlUDYrMUhWYnU4bG9pYXhmQkJwakxo?=
 =?utf-8?B?enNacGVYMjkrQU5tRGhPZVZOVXc4WVZrN3VJNkpsZHl2TXNXdWRucjQvZ1k4?=
 =?utf-8?B?dEhkRzVZZ2ZER3poNGQ4RnJzT0VQVERmUEZhd2ZkUmp0aUJxOWJlVCt4ekox?=
 =?utf-8?B?SFJjaDZOVDVCa1o4a3BPanZhSlNJZmEvcGdSUVVtN0RSekM0SWh5S1pjMlNq?=
 =?utf-8?B?Vk9iaGVFRVhobDZHNFh5MmcvNTBvZE5zTE11ZEppZmtWZnVFTXQ3OWZ4TDQy?=
 =?utf-8?Q?kBiXE2/y7p62KAzNQ/zVw8ZLb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13567338-0813-498b-fa47-08db9da31ad1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:20:06.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sftXIi5ewCSwYwt/syEMrWmIa45yVcIthkH0VJYIU65Qs7v5hyX3zvQO9nUWnKJCuRSFbCe8OS7y7qWBT1E4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/2023 01:15, Meng Li wrote:
> Drop CPU_SUP_INTE from SCHED_MC_PRIO, and it can be used by X86_AMD_PSTATE.

s/CPU_SUP_INTE/CPU_SUP_INTEL/

Also I think this should have a wider description.

Something like:

"amd-pstate also uses SCHED_MC_PRIO, so decouple the requirement
of CPU_SUP_INTEL from the dependencies to allow compilation in kernels 
without Intel CPU support."

> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   arch/x86/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e36261b4ea14..03322d2840fa 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1052,8 +1052,9 @@ config SCHED_MC
>   
>   config SCHED_MC_PRIO
>   	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> +	depends on SCHED_MC
>   	select X86_INTEL_PSTATE
> +	select X86_AMD_PSTATE

Thinking about it further I wonder if what we actually want is
something like this:

select X86_INTEL_PSTATE if CPU_SUP_INTEL
select X86_INTEL_PSTATE if CPU_SUP_AMD

Then it will work functionally the same for Intel systems
but now you can compile the kernel with support for one
or both and get the right combination included.

>   	select CPU_FREQ
>   	default y
>   	help

