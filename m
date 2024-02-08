Return-Path: <linux-kselftest+bounces-4335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1284DC64
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16A51F22356
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A176BB59;
	Thu,  8 Feb 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uhNxp1EG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2130.outbound.protection.outlook.com [40.107.20.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620ED67C7E
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383259; cv=fail; b=eqUkxmCgL8xif4MOUtykUeWwxckNDxD/VJNXA5xnbEaTj0v8iXxaNfDO+FoIgYgmVWAGVXiAGYhN7xWWalYBf9+y+KLKrv4nZ/a5sRatMBJN0xKvMVfOKvyLVCZ9AenC2WtsohpXtnkAp8XKBk1xT0kc4pQuR7U/nivS7f5i1mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383259; c=relaxed/simple;
	bh=ZdTR+R7sjBcVclGWnM/OlntsWasQ0l3QHqzNLxX7Z+A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWx2q5RYtfXTxmI2/K4hKWJrAcEPoDt6EYU46aSysl6iEmMS3gYevv0SlcGaT2AVhEq04yIO2qqEDJzFRvtmf8bXiXuM4QOdni5rO0NHzFiY8PwExCSailVP6AdTP/mHvVBr3q5O3KWrYKV0tb0OGb4QKh3rx2c992rd1rIJJOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=uhNxp1EG; arc=fail smtp.client-ip=40.107.20.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8p9wfI5Riayl1o8/zCLHq24zVp6mOZHGaQZ86npZktp/mViYJUNQBkqORiJiikXx95Hkz8dChATpwwbNwQjNPSdPWbCVXnnv6gsT7fzdS7kHPYboTH6SSEGem/1I4Q3YDfCHJ3yu+ODYHY6hXm/Ma+mOUJX7eI1+f/pQQXi1APAHZ/bfEvRAqZOT9sAgo2FfNHwgS+6UkGEySiWS3J+N949kEADpEw9xwfipJugpW5JN+VtstlufNT8KgYCU0j9n7d68UBB54oJz8pUTvJjrSnP93F0TyczZBY333uVy7tgcFu1UzCX76wARqUvoEoL2rpu8jU3RUHHq27iJ4WMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/QDUmchI/8giveOBkgQOOmdQlBw+oYeTjWUAGDah98=;
 b=S43rgsBNCUcOuTg2PRpQnjEqMaSo4Hhq8BdBnx06B8hXyZyVPuGQxqHYxsGGwpBMQMcz/6bYb840O0VeirW2T0RgHI6+QfIvhL0HR6fv9mYVJSIEuo9lVupGStwgIf9E4j+4Bv2mOlCv8yRwP24DmCayn9e1hjh3nECA1TE6mMthoDouKeaxpuHsVK2LDUrYS8BMbCxGMTkF/QbFr21XXUuJxUK8FIVSAWGkFXN7lYR+EwrkfB5P9HBIw6wB65z5lTf9jGt6LEJzPwRhpPkuzHDGUgR1+Yxe/U81L2/OUbj0R1j2b4wPHj3i0nugBT0FPLhnN/Jq2oZh5aiBkMprMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/QDUmchI/8giveOBkgQOOmdQlBw+oYeTjWUAGDah98=;
 b=uhNxp1EGgeJ8nV5j15hqvKp39zKxgLHbXNF+TBk9XgcgzAemPoqpfUP3gxZDhCyxSs/FNEPcPoIZvQDjyuSswC/A80Eck0p5Wq94A2ObeSYfF5wKz+oRfrLGnec5mqu65dvwNrHIWRxSM3tx+RPo3VvSFwP3SLBxFN7o/vgvBB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV2PR08MB8415.eurprd08.prod.outlook.com (2603:10a6:150:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 09:07:31 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 09:07:31 +0000
Message-ID: <bb312a1a-1103-471c-b32d-def068fc84db@wolfvision.net>
Date: Thu, 8 Feb 2024 10:07:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add missing gitignore entries
To: Bernd Edlinger <bernd.edlinger@hotmail.de>, SeongJae Park
 <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::15) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV2PR08MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: a535bff5-f974-4b4b-6cb2-08dc2885613e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sam2D+rSCtk1dbwPqIoMpHpIyEKx5ujuSiTjWcSAa0NPvYF2fEVjqPee26jcV1EuGnCo9AxQ8RFcx5VD4+QNUN60HHwplWMb8uXKDmhwePU6ttptkbAWb+cqmfHi/qjCifg5agaO+ewEYsRXOtCsdNlbvfZEVFIdHCZAGOQ8BuZMyhmFRsOXkZs3VAKbSe8GxX261oQ+Rf9iuKYXhWEWlKn9cFVMBBFMXP46EjcZ91wBA4/Qc+99GvUTce5kV+6pwsO5+uFflyI5NrcycePbdsr2WchXgfjRCxtiHxb4JSguNYXRhYOiqs5mfCYVrBqz8NtRoaC0jCdVK3XlKdBtevWmLiG7z5jKBpsDyj2p2Qwj4py0p8IfoPq9IctSQoJxsVkOBTAM/Q8PH0i8VzbAoLYGyLSgzciDsaVz1pqLZIB6oRAgn6dRhhddmzoHqpKRO1uJYwPUc58vjd/XZwfYmtiHV35kgMWRUL9Uk0X+jUYY/uKMG/yiKjiZCamDqvqLZzy23dh26VJOjw+ACJx/YdBEoNtk8z1mcYiTvU8Edrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(136003)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(8936002)(86362001)(8676002)(44832011)(31696002)(45080400002)(478600001)(6486002)(6506007)(6512007)(5660300002)(966005)(36756003)(53546011)(2616005)(316002)(110136005)(66476007)(66556008)(66946007)(26005)(83380400001)(38100700002)(2906002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE82YWlOd3ZNdlYyUnJCT2ZuVE82ZldwazV6ZEJYS2NtaE5uS3czaG50S1BI?=
 =?utf-8?B?SnNCOXBLNnk5WHA5V2RhWDlNRWpSejBEdk50cFROVEswbzdqa2JRS0Q1VWpE?=
 =?utf-8?B?UHVYOFZzcTkwTk5FQUlhMi9RVEVCOVNnYVBEWWJLRmdwQndXbFMxb1dPVHhW?=
 =?utf-8?B?NmFMbjNCVzgySFk2czJGTzIvTSt6WTVGTnBEL2VQelAxUkMzM2U4TDgxQTVl?=
 =?utf-8?B?cytUaERNanNrRXFhUHJ1a3BCL0VxdEtkb0E0MXV0ZFJkQndBb3VjWUhYeEw5?=
 =?utf-8?B?c2daVlNPWExvYUVGR1JJYlNIUkxoUFVuaEs5ck5XdnJOQ1JUeGZDRVdqL1pk?=
 =?utf-8?B?TFhtQkxGVDdrQlJhQTJ4bERRWjRxYmY1RGJNWlAyM2pjSU9DaDVsMUFmZ3dJ?=
 =?utf-8?B?SmZseWFkbHQxVFkxVSt5NWpkMkNIMGhwZm9WMEVvY2lvdDlVbnk2MnhXUTFt?=
 =?utf-8?B?eFFqNEl0QTgvK3RRYWJCSFV3NWMzQ2ZvU0N5Y09nSDdqVHlNYXRrdS9YVG93?=
 =?utf-8?B?VVBmY2djMWNOSXl6MGw1SHBuaTJ0cWNYY3ZTNm9wcUtlU0IyRlRNaE1pYmpi?=
 =?utf-8?B?MzFIazljY1BCN0hlU1dFcExjMDJpeUMyZlQxVDFGcVBBYWhjc3FBN3hLS0F3?=
 =?utf-8?B?OU52QlJTYTh0azNSb0xkUHk0dlpqbGdva3ZOK2NEM0E5Y0tjdThGLzVxRHps?=
 =?utf-8?B?VnVSWXVXcXoxdWpxcUhTbXlHdXBXNXlrQm1XSmFVbHNPVU01Qy9rMmlKVjN2?=
 =?utf-8?B?QkVIRHlZM0ZSenV3cG1DRkE0ZVdaYWxZM2gwK0d5eDJiS3gycm50dnlNellt?=
 =?utf-8?B?TnoyNWUybUlzaG52bzZLZjg5bHNXMEZRQllMS3FrYUFremRvczdnSEttNkNS?=
 =?utf-8?B?amVYcksydHRDYTdKcTdXTHh1cUlvVmRMWlZTUE1WcVZ5ZjM3RDdmVW0wbG1Z?=
 =?utf-8?B?bDRmc3I1bTZSUGUyNG94R0pJVi9VVnJoazc2WFNKVjZtVnVsUzNPT3BPYXll?=
 =?utf-8?B?V1Q2RnF2N2lVWEp0VFRSY0ZSSHh4d0VqK2NrcS9QYTk3T2ZSaDNVTitLcno4?=
 =?utf-8?B?LzhDN1QwS3JQSWFacnBldDEzMzZZSkxEK1hRSUpndkRUeWQxM0pPelUzZWQw?=
 =?utf-8?B?cE4vUmxzcUxCNFNXNUdONTlOVUp3Rjc0ZGNTdXJJdEg5ZytVQ2MyT3JQZnl5?=
 =?utf-8?B?dHg4NnhpUUtOWkV5TmhyNVlZQ1htb3V4RHM4ejBpcEsweWUxRldkRnZyd3ZX?=
 =?utf-8?B?QmVhWUFGUENLeUtnN1hXUWwwaGQ1MkIzWi9ySkQ0QU4ydGlmdU5CcmdsRGFk?=
 =?utf-8?B?cjVxbHhyMGRpQVhZM0lCUzJSS3BaeHBFdFdjbkJFSlZUcWJST25yTEx2U0ox?=
 =?utf-8?B?YXVIY0JZUS9MWHE5bkRHSEJ3aFdSWi9tYWNORG9QbFVhZk9TWTkvU1NSU3Jn?=
 =?utf-8?B?emo2Z3dZSzRSRGxCS3M0RFgyWDFFS2RWV0x3Z1gvZmNSR00vcllzYkJNSHZK?=
 =?utf-8?B?Zjh2YnUvMStsNWdTQUJncERhaHllcmdxcjJNZVkrNlhUd0hvYjIveGZSU0Yr?=
 =?utf-8?B?VlRPUUI5NE01S1dDeXN4T1BoSnhTQmVacGhWNDNmRTA4c2o4WmFQb1M1TU9p?=
 =?utf-8?B?cHdXN3hSMEZXdVpiOGQ5cy9hcWd6b2FKSlhCdUdQdTVMSkxHVDZTOXVNeXNF?=
 =?utf-8?B?OUsxV1ZScWxLdVVIWXl1MlFQd01FaG4vQ3FtQytqSW9rQ0VJZlp6L0ZkVlp2?=
 =?utf-8?B?SjJzdDhpN2tHaDJENG5GMmFoWDBhME5RcE9hdDB1dmtlNnFrMTAwcytPbWdU?=
 =?utf-8?B?YjBRM0ZCcmV3U1ovWEV2cGJySC8zWUZTNGFJYUxKNGoxdVc0UHk4NEVvc2Jr?=
 =?utf-8?B?M3NWMko2UnRJOC80UlR2L1NXQnBBVHJlL2pHUHNjQXBMZ1IzTTVNa3BNN2tw?=
 =?utf-8?B?djNZWGhlSWluMHVKZDVCdmJSZjd4VTNYN2diKzNpL1UraHVJSVpmaU9XWlh2?=
 =?utf-8?B?WFFsUXh2OTlrODhDSm5GZHByTmc4bHlGTngwUGpDVUI4WHdkWkI5YXcySDN0?=
 =?utf-8?B?bEd3ZTA4c2NVQWx4OHN6WHBTbkJIUEltNDNscUJENUs0aUZXZG5PaG9tWjkw?=
 =?utf-8?B?Y2dDSlF2NU9CT3Avb2pIeVZ3ZTM5SHJ1VUlzeXpOVU5EWDhEUklXK0g1YXNs?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a535bff5-f974-4b4b-6cb2-08dc2885613e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:07:30.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rqSO0LXUppM63SAZAEobc3Twdbq33DMdIbqbd7q7RlJKmr4IifNIHuMWQJ7Pclg3n4V0CqgKOfssBebWwEIMUiNOZfcw+Xu1U62nlY2DOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8415

On 26.01.24 06:24, Bernd Edlinger wrote:
> Prevent them from polluting git status after building selftests.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  tools/testing/selftests/damon/.gitignore                       | 1 +
>  tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 2 ++
>  tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 2 ++
>  tools/testing/selftests/uevent/.gitignore                      | 2 ++
>  4 files changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/thermal/intel/power_floor/.gitignore
>  create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/.gitignore
>  create mode 100644 tools/testing/selftests/uevent/.gitignore
> 
> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
> index c6c2965a6607..79b32e30fce3 100644
> --- a/tools/testing/selftests/damon/.gitignore
> +++ b/tools/testing/selftests/damon/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  huge_count_read_write
> +access_memory
> diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
> new file mode 100644
> index 000000000000..754810406b33
> --- /dev/null
> +++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +power_floor_test
> diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
> new file mode 100644
> index 000000000000..b5448c0576c9
> --- /dev/null
> +++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +workload_hint_test
> diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
> new file mode 100644
> index 000000000000..15127939d872
> --- /dev/null
> +++ b/tools/testing/selftests/uevent/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +uevent_filtering

Hi, there is already a series for this:

https://lore.kernel.org/linux-kselftest/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com/

which was sent longer than a month ago. That series still does not have

tools/testing/selftests/damon/.gitignore

and includes

tools/testing/selftests/netfilter/.gitignore

which is not required anymore.

tools/testing/selftests/thermal/intel/power_floor/.gitignore
tools/testing/selftests/thermal/intel/workload_hint/.gitignore
tools/testing/selftests/uevent/.gitignore

are still in the queue.

Best regards,
Javier Carrasco


