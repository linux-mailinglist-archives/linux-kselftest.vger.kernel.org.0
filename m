Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AE7C7096
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjJLOp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJLOp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 10:45:57 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1FD7;
        Thu, 12 Oct 2023 07:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBF0nBJ0sTpo/He/tP7BfAHv3Vt+MrBS8xPT0yLz520U5araxyqz8qR7IzdMueFjXSKg2ooV1CKBmbCwv6U+fHWxJiKe+c/EAT4M98ZzRe3sZhq1KCUsRTBaeoHIhxH/8L5GhqnpNOzq3jz+JgEEq44R/XhgErzclOISazSWpA9M5BHqI7KjkbDBoL2dSZn7hvmcRxmKdrRMe77YVP6pFBhh6+MH0yBtYsJO+FlA2SA9YzERz/69TTd2WxfzmpWX65CvqiJtdH9/DmKWKwOhd1ZHbbGme5olxLudWY87mpXkTFNGILGCo9bnjjFlG1E0f/MQKjw0HhzeBwM/otJGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4vLnBkt7GG3CFQwatrSAmMZDq4EQ2KwlBV2F6cxi9Y=;
 b=Ubv4s3WRvs9He6KdQVPM7xrZwN/eNdLFhzX5GAZ6y6cCEVKvOg4+h2yNFR0gmT4sqVUdDSf/hoyMttPtjg0hi2JkardI8VQ9yIHitw+UnJyi29rf2rwqBg6nHuUfjKMee0ZvEey10ovVXXXKdNwLRBsBkKGJbBwuwu7rmcC7T7GagsFZfXucWBLlLtBZqii/t34BPjRcQd17syAi+lo6sL4h8cpJlKtWEcF8Ke9yNmfqFAsNt9ec/29dgdfy5kvgvqINNp4UYlWrxhF8fgD3nQX63Kz5mQNnEqbzyqZ0K9ZpDPw1udeEOGqulrSbXWlJVFbm1bJTB9R7Mml499MiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4vLnBkt7GG3CFQwatrSAmMZDq4EQ2KwlBV2F6cxi9Y=;
 b=KwPw1CXQoA0P7Fe1IS0su1Ee6V8Xb1BBvO9T08a4laftoNAbk2znuBzW4NJaQqabb/TiG5J1Za0qpZBZvqiNQs7iCG83nMdj1PqJTcpIcQ0/MrjR1kj0+tL4TCOmiRcOnLRGs45lxhU8sFaEr/LTvCKXfJ5XTKS9TYYxmI/Puy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Thu, 12 Oct
 2023 14:45:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 14:45:50 +0000
Message-ID: <f20f7773-0f05-47af-932b-12e78142496b@amd.com>
Date:   Thu, 12 Oct 2023 09:45:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] selftests/amd-pstate: Fix broken paths to run
 workloads in amd-pstate-ut
Content-Language: en-US
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231012093225.2045109-1-swapnil.sapkal@amd.com>
 <20231012093225.2045109-2-swapnil.sapkal@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231012093225.2045109-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:5:80::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abbe950-14c0-4d33-bc1d-08dbcb31ed49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfXEmd6tREMiGEj/vRkb6JspmmN1ee0b1xhKI6n++ovhwW+kclokOJlhzJfK57wdYBAgIUhxmOmi9b304gEg4IBBNh/5lwBjnmfA4qNQo3aRz3FwWnMazIGpgd97kzJfv7XiliKd9hC6gqxC0WwC+TyTkS5JZnQRZQ30E/YdqPcAo6Uqwvt7IiDkHuI4jp3wpzXPsoJs+XyQbf9b4b2ZPhodIzj9XaKSCOlvGAIhnT1n82DaKjZaPVDR2DQF/ncCuElpHoaDDChJGpy4VxyqmgnWI9+kKKdf6VJZbmYcXcCREg7XJH7z8rtUedPsk+X0iBuElGKdGhaYwNzPDSIn3LDGPHX4pkiFdU5V1A2bpERWZMXskRSxjx8BwhSXDVF/8VtcDuxV3lXLYKk3pZJC/cvub3hX4v35E06A6aZ0neVkb7YOj0I4soTaS1FQZT0FmzC7G36pFTP79qVccQmbtu+tmmb0nbNOSkGk+daDOfMKz8uDVpoYtqs1/TaqtiRpbeu/fl3IJ2Jer6GJ8GhgWNblFHOT+d6S5z7tkvEjaMxiPqZLON8eUEKfiMNXqAke3cojjNAzzlV78AzrMADWQvClTcpJ4utW87YPerylH2dIFkzIZDoB6b6RawriwsSblg5w8J4hUwNPIu0E/d4QvirYDYlH6vNwu3ZjNFz6C1/k+JL+ihnuK+7/JsUKvbjtZNBKD8eIF00PeTGgV+STIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(31686004)(26005)(66476007)(66946007)(2906002)(316002)(66556008)(38100700002)(5660300002)(41300700001)(8936002)(2616005)(8676002)(4326008)(44832011)(6666004)(86362001)(36756003)(31696002)(6512007)(6506007)(53546011)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtJbktDN0p4QjNIS1dqUFVHNlc5eTZwcEFOMi9IUE5vL1dyV0Rmc0haWENK?=
 =?utf-8?B?QkJIZThweXRaUW5tbXFRaG82NnlRb2wwRFFjTzJ5RTEzV0xlYVdqOHN0Q3Bm?=
 =?utf-8?B?OXoyN3h0ZFc3aTR6VGRKWjRON0xIV0ducEk2SCtyMFBMRlVvWHcxblhud0R3?=
 =?utf-8?B?SGlCM21qTXM4ZHpMM1Y5ektqTTBWbFdyMHBMQWZyeEFWUkU5dWtya2dsQnNz?=
 =?utf-8?B?OWVSdStmSlJYWEhINzRYNnlKTEMzVUZsN1JtbUM4L2JQRWsrOXlKMElaMWhQ?=
 =?utf-8?B?ZHFPZ2w0U0owQkpjZDNiTVA5ajZSRmNvVEIwQ2ExNjZEblRzTGpXakNuajRs?=
 =?utf-8?B?RE81VjdPTmlaZUJGb1RKeVhlSno2STlaQWhzc0NqdXBVWG1rMGRudzlMUk5E?=
 =?utf-8?B?TWJ5d1hiazNZaEswOGgxWVJweTlFb05UTm9VUHNwU2xnc2Q2dzk2dzlGM2R5?=
 =?utf-8?B?ZlNhdGR4L3VaSjVsUkhOa2lDNVRrVkdiUGtVVXVtRjArV2lMR3IwQXFSOUdx?=
 =?utf-8?B?VEhzT0pVeVpwMk9wdDVxbnluc0UwalAzYjdXaTlTZWZTR0RpRnFjdElSUUVY?=
 =?utf-8?B?RERqZ29zTFAycnM4RmdIOU93MHZ1VzM4OFdGVy9SUytRSmhnV2Jwa1VON1A0?=
 =?utf-8?B?VllpNWcwOVJ6S3BnYVhxQnU0QnUxQndNTTd0Qi9RNnk1aEk5Ym1sczR0dENQ?=
 =?utf-8?B?ejRQV2NtckY4OXN2QVR5dmgxVlkzVk1zcU1JUTgwRzlhUFNLalg1T1BubnF1?=
 =?utf-8?B?Rk5LR0QrVVdjM01tRGU0RWczSVFpMmNPaGFWUy9mdWcrVTIySGNPWlk1VzRD?=
 =?utf-8?B?cGNGdmJueGNYUFRLVUlRK01qcHM0QXpwSmswdTE3amMzb0RjYVpZN0FLV0la?=
 =?utf-8?B?MFJXc0hEbGlQKytUTzVib2xYc3N0em0xOW9ZQUgwSVFuV09yNjVkUGJrN04v?=
 =?utf-8?B?NmdzZk0wU1JPek9vRXJNSUlwTlFBUHFoMW1IY2tZSWVXZE95Q01pOVFmbE9E?=
 =?utf-8?B?NUVEWjI4YXhRTDFsVFpTc1pUR2Z4b3FyQVlDOUFkL1ZqYkJIdEJicFM4eGRS?=
 =?utf-8?B?S0RKSHZCUTl6NDRFUWdnZnBxdHY3U3hEOEczQnJiWlVKU2lNc3ZlRThxdDlS?=
 =?utf-8?B?NDlMWmJiV0tXWlJPa1NPeUdESFUvWUIrZTJIamJ2WHp5V2c2eG1KRUhlbjlO?=
 =?utf-8?B?RUVlNFFuYkJqUUNDOU1jL1pnTTMvaGpab2plVS9UZ3YrcUNYUEl5Z1BRd1c4?=
 =?utf-8?B?Um5mZlRCdDlESE9DNGV5cURWRHJKRTJ3Q1hTbVJlcC9takxCSUtweDN4TFpB?=
 =?utf-8?B?RkE3UWpGQVpLcjQyL3RPQ09tZGlaMGdxR29UangyVmtjdVo5K3oxU2VKNkRJ?=
 =?utf-8?B?dy90KzhyaHZJeEJTZUN4Y1JObE9hdXlWSEFreHBPeUFpWHRBUHJsOVVxRGVS?=
 =?utf-8?B?M0wxMFk1ZjgzWUphYWpLYWpmQlQ2UEQ2RWxxZ3huaHJnRTRVL3VydlRneG8z?=
 =?utf-8?B?YnpCeGlpMWZndnh5LzJYTmNOQWZobTAzR1g1Uk9naldFd3JsRHMyZlB4bXFE?=
 =?utf-8?B?L2xkeU1aQmpXMVJwck5IdVhWS0lkZGVmZnpuSzJ4dkRNVXRHc2NMYmRPVmZw?=
 =?utf-8?B?eFExNlorUjVPWG9KVkJiY3E0dzFia2xLbGxNOFE2ajQyNXBSL2pmbHFSWElN?=
 =?utf-8?B?NzgxMmtUcThMcFRDQmFpdHRvSWNHcUZVMklhc3lxQWRoK0E4d2NkbEh1TGJ6?=
 =?utf-8?B?dzNyVkhJcnVBRktvR0ZPNlRBMmVxVWozeXRuUzdPeVJyQW5sU0UxZFRCQlRO?=
 =?utf-8?B?eEVwNzNmREZ3ajBmM1M1dGYvdThJaDZLZ093Y0htQkYyTUkxM1d4OFppNXdN?=
 =?utf-8?B?OEF0N0hRWWdFci9zTkliMlNldlZ1Y1lhazE5MWUwZWZjalpBOVZhNnNoUnZa?=
 =?utf-8?B?akxhelErOG9RbWwvQ09ybkJiTFQ0UWYrSmRuU09IOUc3dkJaemNqbEFVR1RN?=
 =?utf-8?B?blNlbDFYR0k5bFpxalNuUnJlVDZpZktma2MyMnJvc0lRTFVZeVZyZTJpdDky?=
 =?utf-8?B?OUpsd3VGY1JoYndYMzRzMWpFeVhkbTBLeXUwTk5oWVFWQVJtT3hTbkVDTS9h?=
 =?utf-8?Q?piPe4/xyfIo8q/krTQ/Fdtk8+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abbe950-14c0-4d33-bc1d-08dbcb31ed49
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 14:45:49.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lYydZRjocczGpRd94nYlY30wAJt/T1t2xaY/ufsLihd0L5C+xOeXi65M7cylYlIdTLUZYexuiwez0BrRbQhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/2023 04:32, Swapnil Sapkal wrote:
> In selftests/amd-pstate, tbench and gitsource microbenchmarks are
> used to compare the performance with different governors. In current
> implementation the relative path to run `amd_pstate_tracer.py` is broken.
> Fix this by using absolute paths.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../x86/amd_pstate_tracer/amd_pstate_trace.py   |  3 +--
>   tools/testing/selftests/amd-pstate/gitsource.sh | 17 +++++++++++------
>   tools/testing/selftests/amd-pstate/run.sh       |  9 ++++++---
>   tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
>   4 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index 904df0ea0a1e..feb9f9421c7b 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -30,8 +30,7 @@ import getopt
>   import Gnuplot
>   from numpy import *
>   from decimal import *
> -sys.path.append('../intel_pstate_tracer')
> -#import intel_pstate_tracer
> +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
>   import intel_pstate_tracer as ipt
>   
>   __license__ = "GPL version 2"
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> index 5f2171f0116d..ab195ddcba4d 100755
> --- a/tools/testing/selftests/amd-pstate/gitsource.sh
> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: GPL-2.0
>   
>   # Testing and monitor the cpu desire performance, frequency, load,
> @@ -66,12 +66,15 @@ post_clear_gitsource()
>   
>   install_gitsource()
>   {
> -	if [ ! -d $git_name ]; then
> +	if [ ! -d $SCRIPTDIR/$git_name ]; then
> +		pushd $(pwd) > /dev/null 2>&1
> +		cd $SCRIPTDIR
>   		printf "Download gitsource, please wait a moment ...\n\n"
>   		wget -O $git_tar $gitsource_url > /dev/null 2>&1
>   
>   		printf "Tar gitsource ...\n\n"
>   		tar -xzf $git_tar
> +		popd > /dev/null 2>&1
>   	fi
>   }
>   
> @@ -79,12 +82,14 @@ install_gitsource()
>   run_gitsource()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$TRACER -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
> -	cd $git_name
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
> -	cd ..
> +	BACKUP_DIR=$(pwd)
> +	pushd $BACKUP_DIR > /dev/null 2>&1
> +	cd $SCRIPTDIR/$git_name
> +	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	popd > /dev/null 2>&1
>   
>   	for job in `jobs -p`
>   	do
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index de4d8e9c9565..279d073c5728 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -8,9 +8,12 @@ else
>   	FILE_MAIN=DONE
>   fi
>   
> -source basic.sh
> -source tbench.sh
> -source gitsource.sh
> +SCRIPTDIR=`dirname "$0"`
> +TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +
> +source $SCRIPTDIR/basic.sh
> +source $SCRIPTDIR/tbench.sh
> +source $SCRIPTDIR/gitsource.sh
>   
>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
> index 49c9850341f6..4d2e8ce2da3b 100755
> --- a/tools/testing/selftests/amd-pstate/tbench.sh
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -64,7 +64,7 @@ post_clear_tbench()
>   run_tbench()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$TRACER -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>   	tbench_srv > /dev/null 2>&1 &

