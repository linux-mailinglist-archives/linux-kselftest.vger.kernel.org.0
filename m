Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB67931FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 00:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjIEWcZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjIEWcY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 18:32:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0ECE7;
        Tue,  5 Sep 2023 15:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhDn6oaxE5Qix1jItZte6TlBP4HUWexRP9IWPteD3i5ywPwsdnOo6jGg10yvrtqFhfgyvD0FcZZFasSOCKiqrwAc8MbkuoJ2U1vciEqLFjIHfBHPQHTdSGapdgU91mfT5K2wf+WqTyt8mE8J8UZn965GlYvIDYXRaV3iQD+cNQol00kCdJm7zZWOGEbMqona72gZ+P0OOC+FQCuOaetH2Af+eKJEGWIp7BhjDBqiMFRmYERLsf/CYcEblI0kx1uI8AtX2GlpX7yYFSqnuLt3WaEirFQ/tLosD2XkqXKzUjpKQQthpP1HFB+nV5Mdf8qdJmP1qGoJqr+bRo0ES/QqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrBucp5j9d5P+Aa6ai22aVr5xSdGG617Xl+lF5okQig=;
 b=eje8Ursct1D0W31dwoEfDdMW8PeH+hRDPpuBVCdXWPM7kEsWff1VfaF1j/Xruj/7cA+Yl/J5xa/o+aYS7iB8kL21AbH43gpRQKu8NJjrnVg5zwHDwbSCZAWajPA8c8cbX1e+AwxDhLGAE91x6o8qV+L2IQvWQOoxpdrt2VCrPDftqD4aV3qjP4ksXUBgAUFENbefj1mJp4cDvS918LgHdQ0kH3SAB07KLojRrqPpFRV+LqkTt0ZXgu078TcXUA3iK3GAj42CH2tfU+QD7gxJu4Qyl0qk09g94PyQr7wgdp02mK1R9QcU4nlK0f55romm5JjbO3Ko2wxPJSQLI2l9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrBucp5j9d5P+Aa6ai22aVr5xSdGG617Xl+lF5okQig=;
 b=QY9pTa+99aUYsSWb1/37U260ITcRzxrU4j952BZmdwiGTpoV//UwJxuGmDCbgOdRzW5cVNMi1B3v912XgGJzGEvLZpu7mjHJLmeu5/tk2g6N5Wnk89AwKNGfuisRrWCxd4pwORsTTPrIa4FHjlgu7VZlFAi1N3ilqVSC3AzrMCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 22:32:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:32:13 +0000
Message-ID: <2f1f0111-c9fb-472c-80b5-968267382e32@amd.com>
Date:   Tue, 5 Sep 2023 17:32:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the
 expansion.
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
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-2-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230905015116.2268926-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb5408a-d65b-4b21-c1a8-08dbae5ff337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLl3vgO4e6KMmn+J38Mhw+DGqAO7n4Bs+QqkoIjyYtwrDSvEFhif25RbMS6elU3dlSPRrIavlRD3F5SQ0BzHdIIa5y1FwUyWnNVXteDMeFObQm6JFGwHd6nCkP/gn6i/pYxtCJqKrXzzGqbI+JAzc0EPW2oSpv6rZ4lAKMREtz3k9pnFIo8OsXq2wPuA2ccZUjTGIBca0eG29QFxvbyc54uq0M2eH6TfiEXkIP11usFdSefsdZ+vGDZXmIgK36OYuNG2JRdYoQ0VSpV8lxoxmSLTVqvR8y5GbzXHgOhRLEmB56VYEq8yGP1gAZ4HK/9EEpdwA1fcrRTaNzvPQIR6zcPXtA50QjoWkZ0eXpZLbyTBniCNw6idyIxQU8VscqaS1WETaETmL78gIuAe5L3kbfvw1sJIx9Tu8sTqq1UYQIGfsnQSxwZNww86qRpYEuMYYQI5BC0CBlKR3mbq6nFvWGbQn8OlxCPufWmhLDuMSgkcSRlMcdBhLpLZE7QuX0xETKW3U4ousxSHER3lLmeV5/+cw25Ji7qYVyiehJoczQ+Js9dwy3Qr8YzMicaUUvKiOWTzMsAIZZ6F0WjKHuknXgrMbkVgMw42r0wdgYdRRi4sYB+bE2Hpv7tdlbqtlXbLb2pJLo69WpmI0Jm+3ZP0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6512007)(6506007)(6666004)(36756003)(38100700002)(86362001)(31696002)(2906002)(2616005)(4744005)(478600001)(26005)(83380400001)(66946007)(110136005)(4326008)(8936002)(8676002)(5660300002)(44832011)(316002)(54906003)(41300700001)(66476007)(6636002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFdOUWdPVE5VZ1NjbUZwU3JpZzdhN3kvSS9DVGNNZkJTYTkrRXJuaU9JVkhs?=
 =?utf-8?B?TTBFSzBrbGRYQ1diYmhoY2tOQzVpQ2lmamE0QVpWbXNHMUhkcmJIRm9xZWFy?=
 =?utf-8?B?YVQ4am4xUzFYTVptaFFZRXc5WDhjTnQ3dUs4WktNWVBmTVpJZlFHWFZIcHdG?=
 =?utf-8?B?emNXeGxGbnNBUnNZTXlZL2dpQWdFQ3ZGRlBVd0hLY1JkMis2cEIwcjF5SlBt?=
 =?utf-8?B?YUtibkNKSHFZbXg1bXNIbWxNZXVDRU8zTDlBNHlVVXdzV0FkMVdpcG5KWW9T?=
 =?utf-8?B?MHRBcTR6VkJ6SFQ2VTBKZHlxMFN5enVnOU1zemxPRnJBZGp3dlVaNTU4N2lF?=
 =?utf-8?B?ejVjdUdqQWdKekR3SkwycjNzRzBUQlh3RGw2TjBVUzZVRjlZTzlMQVMzbUF6?=
 =?utf-8?B?bFBIbC9iOFlXbkdPeHVWZlZtenpwS2pQT2I1NjdTYzBmTlpBUVpCbDZMK1lu?=
 =?utf-8?B?ZjV1d1d4VHJXR2J3ZFBWZ1l2TjN1aHlwTXlzTnhBZGFmOWhiZ1p2REZkOSt0?=
 =?utf-8?B?OWFyY1ArUEpFNnJkdEJETWE2bEVVNUFvaGtLaHM0QVVzcU9uVlFuRm54bXl5?=
 =?utf-8?B?dTZVT2c5T2RISVpwcVFSS0dHOUtpbmNUQVlzbXZpVGNCRmg0OHBid04rRzJj?=
 =?utf-8?B?RVl1TUNmM1FUYTRxZW9sbmcvZnlQRWNYL0xJTzZyeWhDQklpZi80YzF2YkJD?=
 =?utf-8?B?aXIzYmZXWTFIZldZMjhiUFRwWlE3cy9pT2RUMkpZOHZtSk9GOUQvdTJGNUo3?=
 =?utf-8?B?eTBwTVNjS05HeFRPU0FJZUpmY2VmVWp1d25tV1lpaHFNVFFhUzhPWmU2M1Rz?=
 =?utf-8?B?dENRcGVZaTFWaWFRcjBNVjg4S25odG00SWF0TkJzdkJKWk0rbFplOFNNUUgx?=
 =?utf-8?B?aGFkYzUwTjFsTkdZZk9BSG9iN2lUSHUzb09DeFhGU1B2UTRJR1RRQmRyL0Zl?=
 =?utf-8?B?WTQ0QzdOaEdFSENLSUJpNVVrNHVYbmF3ekY0YlM4cSsvMUxGT0xnYVcxVXJs?=
 =?utf-8?B?Ny9KOTNVOS91aE5DWE5na1ZLY2d3UDFuWGpBdlZVYWd3bUk3cmV5OWFkMTRt?=
 =?utf-8?B?S21aenVZU01YeG1BZndmUW9XVmtaUzBSQlNhR2RPM1N0Qy85cWNvaDM5cTJW?=
 =?utf-8?B?VkV0YnRIUis0alVqemVoOVBXUnl5d2dwNzFMY3hFTWVFenl6ZEhmdTlwUnhR?=
 =?utf-8?B?MmI3UlMxdTJ2SnQwdFFsQ3Z2bWVkOW9DWmRyRzY2YkZibXhsNGdQOW5NbnBB?=
 =?utf-8?B?ZE9OK1BGT1dmL240bHRkcGcwREZ6SkpvdVJia3dlbHRzbG1WdWhPdWFLTlRF?=
 =?utf-8?B?anpNK2Z2ZGo4U3pFQTd1b1kvMDFzT2hsVzh4VjV1dVh6YzRHRWJUUnpyY1dq?=
 =?utf-8?B?QWZZTDR1OTNXVDlKYzdCWUFVdjJaWjNFYllGb1NQMzFGd1RYWGNyb2FMNENm?=
 =?utf-8?B?RkYxYnBXQmRvenVPc0tHMElrRSs2UFpDUFlQc3BiQlZseHF4cmsyaW1rWFEz?=
 =?utf-8?B?T3BXU3BOSGJqQjBJSG8rcDFUK3RJK3JTYkJEV2RHcVZ1eUpEbjQ4TVR6MlFD?=
 =?utf-8?B?QjVaQVFYdzNWSzhDdmhDbndhc3NIVzN4bURDaW0vNkxiMkhFQU9DT1dHc1lZ?=
 =?utf-8?B?V1daU2FOZmZpYlA4SEJkV0ZFMHNLc3huMUkwUGZxaStmdzlIT0JZZzYxS3BB?=
 =?utf-8?B?WkVpdmJhQjNxSTFtbkwzWVY2NWQySUlObmJHNis4TkxLTjJsZklzd3ZFUXZN?=
 =?utf-8?B?YTNlRXRCZ2Y5emJoY2wrOVo0dlZRb0RwRkkyNHFWQ3VlbHVHQVVjdTFUMzJm?=
 =?utf-8?B?L1lIanRDNVFIcDRQeWp4SWQySmVjdHhWV3o2R0puam1jS2E3UG9sSUN2Vnhr?=
 =?utf-8?B?b2ltQzg5cW8rb2FjQkhRV2xpQTcrL2k2YXU3WWo2cHJNaDhQOXVDdlR6alY4?=
 =?utf-8?B?NVU5SUhMUkxnMFI0czZBNFNXY3lYcDlDUkk2ZVNGcVFFanhFZDZ4ODN2aFk0?=
 =?utf-8?B?N0pVODN4ZWcwU0syQ2pxNWtYMHNUWllMVjI5dkNjSTU1Y3JUc1R1QjQ4a2kv?=
 =?utf-8?B?cngwNU5zZjdWZDZHbTdySjgvbWZqWEJqa3J0NFRyV2xQcE5YazdLazRyRjBF?=
 =?utf-8?Q?Ihi5JR7+GU2lnZFhaAnwyuf2U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb5408a-d65b-4b21-c1a8-08dbae5ff337
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:32:13.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zVRM3f61ILCFZtidvXyYtqk/XDgBrxI589Pbcg1003eOg+jWnV1w9//VU2SBRthDfLPvZSjhhH4ZWd4KALNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/4/2023 20:51, Meng Li wrote:
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   arch/x86/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8d9e4b362572..887421b5ee8f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1052,8 +1052,9 @@ config SCHED_MC
>   
>   config SCHED_MC_PRIO
>   	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC
> +	select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +	select X86_AMD_PSTATE if CPU_SUP_AMD
>   	select CPU_FREQ
>   	default y
>   	help

