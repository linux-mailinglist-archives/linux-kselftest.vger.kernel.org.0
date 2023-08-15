Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1377CF42
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbjHOPfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbjHOPfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:35:25 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE91FD7;
        Tue, 15 Aug 2023 08:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBjDHZuh1EpW/3yZs9WSLj4aJjjQylIxbcgNB+GwE1ZmOvL8bpTduODH0UdrbEJSfH9x0DLrkk4j+95IvhLAV9YncMJIPsakQqQ+SjrT24AWNo1/rmvc9xcjOVVuO2ci5f4DURgSAKorIF46JGBXtO8YdBgzCRbvP4OxQHMwBltLpVBmp+zaxBxlu2JdO+0p0yoypcMsqp4EXLn98dDj3JF0SqDEac758mG0UiftzO6kJyrY7Bobc3YlhUx5X+MITC+CNYev7xtpPHdLGr7E5YbKYDj0TQLa28QEDb2FQxe7iNqMYEmwv7zrUD+eAztU4ogDjyBoRTQr47J6Q8vIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw2KzSS67WO7EXaKmOp3uhhsSLfTNgK6dys7c7sicPs=;
 b=bDZutbEeMF0/EQ+inyBiITr8BeQdAXqRdCklxK9XIVFX9sch5kueColHRxqS+GTA9RWh3iyH9e6UhFcUn0gJFAjdsleM4KL5DXdyrJh0dAVSipT/Ynbcqxxy5wkjHLKUXya8+TiJh96gIX40uuKGk/VCsKxr5FJnHTt9YL4IxEUovyXM6pLZZuy1czzmvmrrUV5A4TEPTtOZmwFdSgDCk83IXBCW4nNqzlymQkrkS89B/4pOm9NvVAAebN6pqLda+a2ePQL70PbEwaGEZH1aHEYEh1yJyYbH+2F+53BeMbzoaN87+WFny2uYgKmtzjyzlHUVjv/2b9UyexRMef1ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw2KzSS67WO7EXaKmOp3uhhsSLfTNgK6dys7c7sicPs=;
 b=akOP3WSQP8s5juW1k8zaM+xcKDOS7E9Wv81DyTW99LhG+GTSo6n1bcFaeG5a1U4pfmnA1t0ifwwthsoQH5wCbywghIHD+/scaN6ArGMml1h07XeLTpG6dIUgBNJ9px8l7joYcYO5VH34575PVvE/vp5LViCeN0GSne+dQ9Fa9W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:34:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:34:30 +0000
Message-ID: <d7188228-14b5-493c-871e-5c83c1f0f1de@amd.com>
Date:   Tue, 15 Aug 2023 10:34:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] Documentation: introduce AMD Pstate Preferrd Core
 mode kernel command line options
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
References: <20230815061546.3556083-1-li.meng@amd.com>
 <20230815061546.3556083-8-li.meng@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230815061546.3556083-8-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d74af86-bd14-4f09-62c1-08db9da51dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzdhWD3I+grhHRH0EaZeTsk7JmtigcWwbGI0uYwNWLVY5B31Dij9EQ7lAOS1Ghj8jq5aXl1RLqn7JHGHejrs/szPFi1HXh+I1/B18FLW4rgDOVrDihnuh77fCQRdHtfOzyISGZpsaXmEzx5lIO7iJgpnOYCd1ChEu0SLDW4xIG4WtnHgpQqI1v6S4sOCcsG4wDFvpnY2QiU/QTg6nVarW0loiA0JkHP3VAnX/BXv1TkUBhsAnalpIshoMGt8zWPYskCBcDSViZdvpn/PDxYH01Zj5Z1d9loqdO+Rjc+9bcqaVnoAICSxxU3vlXv0LViKVIKvu4q1CHBDOUEK6j7f/60vUw9uZal3J0gAWPwRuIaf3AEIjqCJYoEUIPQ2lEgoY+Kl8Y4qDOjmbOwtc97N3OWok8IXtRA+GwScXABSal2+lN0q1OlWkcg0N/sRAS7nRERZvqHkyDYSujQZnzBDSmRDJwIss4JC5xI2O0vRRR3AHB9OABvg9uW/+I7rrtCleqD/kYuIQ64ZHZAwnYtVg0xabbEY4TKaSN+zsSIAJYIuPtWHlq4oQteQgT07EMZk8tPbI4GExQFDVUXDcft8iKdmxK18fVRklHPbBKtUbFYIM/F2pI5d36zNcmArwdq9MsrYORP+vKJ9VQdASJsB1ASVGbhSJB+hbnuaBvLKciB3I/BZSgSpepnqAK5wxLml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(6512007)(26005)(110136005)(66556008)(2616005)(31686004)(66476007)(66946007)(4326008)(6636002)(316002)(54906003)(41300700001)(8936002)(86362001)(8676002)(83380400001)(31696002)(2906002)(36756003)(44832011)(5660300002)(6486002)(38100700002)(478600001)(53546011)(6506007)(45980500001)(43740500002)(14943795004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhFc3FiUGVVTllLM05rUXMwU0I0ZmtVUmdtYUpyR2Q4S2FvZ0VkR3B0Mi9z?=
 =?utf-8?B?aDRhelhKZ0pVUEZiZVpFa0dFeHVGWkxvWnRpcFNqaUxmeVJuQVd6cjhnSHRk?=
 =?utf-8?B?cTY0d1dXMXhqb2NGS2kxd0lDdnhWay9kbGg1bzVvb1VKOExOS3FCWEpRWFBy?=
 =?utf-8?B?QkdJNC8reWkvOU8zVjBYb2w4cU0xeFZ4NExGKzVpUVBaYmNaSzRtcmZ0amFD?=
 =?utf-8?B?bUhWbVJZRDYzS3hTdjI5SXg3a21IaVI4RFhkZFZEMFBneUh4ZGh6V0pmbWZC?=
 =?utf-8?B?MzFscnh5bmNaWjVXbXR3SzNTaE82UXpoRFdlK21McFFmM2ZzMDAvTzBkU0VC?=
 =?utf-8?B?QUtMTlZ6RTdBMEQrN3YvZVNmYll0a3l4NXg3Q3VRUTNzdThxS0lNbWFscWxM?=
 =?utf-8?B?eFZ1aFJFM2Q1VE52QnVHVk9zd25RbjEzbkNDTEE1MjRLNEEwdGtuRzdsL1Bw?=
 =?utf-8?B?elZyZzNBZ1d5TnVWL0loS2FpQlVQNERQWS92M0c3bnhnS2pnQnFiQTk2dnF2?=
 =?utf-8?B?VUlxY0UrRTV0dm9KR2QwRml2M3VLR2FGR3phelpqV3pYUjVCN3lmbnl6WSto?=
 =?utf-8?B?Y0VOVXBSVUlkdmVKOXUrTDRxZjM3enB1T1YrSGpJN0J0R0diNVg4bGxubEJp?=
 =?utf-8?B?WC91U1VNVTRkVDNweEdqbEpWUXZnbzd2T3ZzZFNVYnNzaGdocCtYWUQ3alBB?=
 =?utf-8?B?ZnE4dHRVU0hOZmNBL1lqc3JFWC8rQU1obEp3RE4xS2tYTjBmQkVMMEtuRGlY?=
 =?utf-8?B?WWxWM2xocFI4aXR0ZkVVV1A1M2diWnlBMEp5SU9xQ2IzUHMzS1o5cEkydXpO?=
 =?utf-8?B?QUxsT3dyd3J4Z3lLeDFLajNVZ2hCZG9EWjA5OU8wYWU2R3ZVRGRaR3NiczFU?=
 =?utf-8?B?OVN5Q0JOYzJjRjJpYkVKYzdrekRLU2VvSk4wUmdRVnptVU1lNy8rQ1A0djhD?=
 =?utf-8?B?YVpjdlFhdGxCYkNNWStISHRoOEtybXdTeEs1aU53L3F1cmxDR3lPYW9vOWRN?=
 =?utf-8?B?ZVdHUEo0RmRsV2xXQWlDa3BtWHdQRFRQWUx2Yi90N2xsYW12U0ZQZVhjK0JJ?=
 =?utf-8?B?NzBkSCtpK0s1Y1Q0RkNDanZGc3NQRkFIaDhUR2NzU1FWcFpyNkloWXlIZXcv?=
 =?utf-8?B?aHpxMFpMUlhPNlZIa3FXbUhIZHBVTzV3N3JuNjI2YnhvQ21BMDBBTDBFRVhC?=
 =?utf-8?B?WnhTc3FWeVJBZldjSlAzWW9TT2w0dUVZMzdGdGFwbjNLRjdsbTBqWkp4MGp3?=
 =?utf-8?B?RVBGRnZCUUFsR1JCYmZ5RVY0WDBMYjNlWWFzWVVHL21FeXgwR3pRODVLQi8w?=
 =?utf-8?B?ZVRjSDA5bThSZXBvZlg3UXhEdHc3Y09NdTZ0NFZZSWIraFQ2bldnNzBaaFpG?=
 =?utf-8?B?TWl4UXlYZ3BoNDJGcnJNN0tqbGdiUGY3THJnQklpMVdtY3g4ZndJeDJKcGd0?=
 =?utf-8?B?V3VzSnF1MmxBVFgvcDJrRDdra3pLejJ1TS9FM0wyZTl3ZkV0VjA4MHVGcEUr?=
 =?utf-8?B?T1R1cysyMjJOY0VSa1k1QnI1bVYvNkVOZFJVbm5hRTVMdWdUTVpXVEQ0VE11?=
 =?utf-8?B?Y1VURURwbUNjeE1ISW45UjZ6K0VXWFhoeW5zWTBJa2VjaUhRcFN3cnp4M3Ax?=
 =?utf-8?B?WWhKSUtRQ1NzS2FYUlRXYTJIQkMvd2RtdWpUa3Z4M1pmQW0yb3psTmhMc0tP?=
 =?utf-8?B?M0h5dzF3RThtKytMaW9vRU5hWTljTnR3RlJmMkFkczhndlVlVHB6aFNpWWpl?=
 =?utf-8?B?bWZLK1pSZXU2M081dVVENUd3MU1DTlg5WnF5MXFmd21sQlJ6ZzM1d1JOQ1di?=
 =?utf-8?B?WXFqcDUyVEhtQmNlUktyS2ovMHVsZC94dkRxallHczE0Qy9tWmdMd1lydXoy?=
 =?utf-8?B?ZXFnMjArYmgyKy93S01oaDhjclplWFVXSHFNSHpoajRuUnRTZ1lSMzl3T3V2?=
 =?utf-8?B?VkliSjBCWmZuQmdhSnBBck95bnE2MjZqcGdWazYzbUl2c0FKMVpqVUl1L01z?=
 =?utf-8?B?RXZ4NWlqN3c2UzN3eDFnWllnN2dSQWtRYmJhYkJGRmVBTnFselkxdytpRUdG?=
 =?utf-8?B?V1JsRUFnWHFDcFV1Q2xodEhBYnpsZVB6STdFYmRuaG5wZnFDcXFHejhVeWty?=
 =?utf-8?Q?Wb+PUYBQk6lgg1q0ZneEnsZjZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d74af86-bd14-4f09-62c1-08db9da51dfd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:34:30.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU+4PmrXxT/8r96EmxPws5xAkw12h74oh9qlHWb261kpbEytJv5LVWHEtCJrq/H6WCm1fgNZdc/u/BV9TZgr3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/2023 01:15, Meng Li wrote:
> AMD Pstate driver support enable/disable Preferred core.
> Default enabled on platforms supporting AMD Preferred Core.
> Disable AMD Pstate Preferred Core with
> "amd_prefcore=disable" added to the kernel command line.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 23ebe34ff901..4f78067bb8af 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,11 @@
>   			  selects a performance level in this range and appropriate
>   			  to the current workload.
>   
> +	amd_prefcore=
> +			[X86]
> +			disable
> +			  Disable AMD Pstate Preferred Core.
> +
>   	amijoy.map=	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>

