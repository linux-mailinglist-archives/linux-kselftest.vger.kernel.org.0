Return-Path: <linux-kselftest+bounces-14278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05193D885
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 20:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21BEB216DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445D249F9;
	Fri, 26 Jul 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOYpvaqj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF94D8BE;
	Fri, 26 Jul 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019578; cv=fail; b=EzkIqZYS4DFbY2yN5ia/hpY2O7jxY3fqwt8jzd2ltKW12ERJX3qqRxrTQEIJox8pdhQsSidf9I6OdFvqBdCVbghD24CknPUKJVR9jgZeR1yGXDpTQrKAnzoI71kVc8DUcY6dwv5gWRwz/aeYaOdp5ofye5grRDEKHEp5WE7bHK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019578; c=relaxed/simple;
	bh=1/8rF1m8D/CWWE3YfMllpjQ3R+I5XxPxozPFV++VZBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gpYiJKwWZCYhLCvmhXZhmQWCQ6f5hn8E34x9Gp75kEU5TT5f2fLxbZl38hux1ekLBpHVYniRMGFuaAND1XXGV827XoX152Cy4uDteJ580V/kbs+2NyvGeDvKZpXtfOyZqtabg791CnGPk3Euzme3pV3k5t10vwVc1ndj2ZjO8sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOYpvaqj; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkTAH9rlXmDAckcz4L0nRqphDmBdMKBMoXT1Q/eU4SeqpmC+Gef0YK1SAqey5JScB7WLMUDEUUKxEaaVMXceyQ38FleVKKlig63g8II1YrFlij5ZxBBd8lNjxXJfwMK1h6kPiSRLjWE0GzZUt+9taxFrvRSh8WbLnnAxsORg3elKcWuRfX+q3Doxnx8dftTLRVwluJL9PD/h6xriT6fS2PjmgoOyvJ98v5PpCgrngJ4EqjUNEET+4BESLeMqd8ldiOwK0VMsVINvOjxhFnWpLgX3nMsbtbYPbvst22jtgp6qi+H0V/htiL3eH8Qe3s5Snuf1bMzNaMPMerNY0i9uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqTK9JC5+gkBNB8qM7vnF0fB9Q9Rg5qIXzo8emWQH2Q=;
 b=pgRYYRyTuYWGpcbRX/Bk2+/CytsLEBWUwQ6MFk8VTBen8BhOYPZBphqWXe60W6jQBZ5AUu3Q/sHMxR6EOIJcMGZXpgcJq2hQ3BhHmVKfvN7l2oaJh/4BMSbI+STpZHFfYeH7ST07mWSR1+d0MTOI7U22wLajxeqKFdMAjXTnqaPiHpiUVL+LcZoQS2IKIsBalM5d+GK0kKzaKUAcGHJ8q/l+sp3MZz9UMGcya90ODZuHQSS/t8Yrf+Io+R2dcpGB4JtNl61Q8gvCok1nOuLRNUPNN/U5b0pFHLIvhP6qGjuozR7xexXQqdMqOv1UvKYzJhrfMXaYzlh9WrmC5uWvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqTK9JC5+gkBNB8qM7vnF0fB9Q9Rg5qIXzo8emWQH2Q=;
 b=eOYpvaqjusDLpi4RfnXZzf8tyNNxwdybHzg04m//vS6udE/sdvT+HRyuwpSHfJpDdTYwlkpuLz1VgHLKH1ZAki8ObjqMzfqZtS3fSWSkL6JT8PUVp3SYrYMaPEnhwTBRxgxhBlwfVYf7kLRl8cC4X3Bce4dqDLpXZ6+nwXUdfTy0GDY0CQMAQzo1b7xX7imC9moik2JNAViZTVb7WAOZcarv/2CXWpnII6XbE+UXIwaJR/KMq7a9YbCjK/stFBuvQP4PQS9MiK6xtZp6+n8t2Zt0EQ5VUBigUFV6o7oE570Fii2qBg/YVzh8HJm+W1l/xMqbwfi5nyER7U0RSvbZFQ==
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 18:46:12 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::cf) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 18:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 18:46:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Jul
 2024 11:45:57 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Jul
 2024 11:45:56 -0700
Message-ID: <f5aeeea3-1b6f-4ace-b346-b6650d6937a4@nvidia.com>
Date: Fri, 26 Jul 2024 11:45:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton
	<akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kees@kernel.org>, David Gow <davidgow@google.com>
CC: <kernel@collabora.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240726110658.2281070-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f5612c-9c4f-459c-776d-08dcada338a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBhM2lBZDFKd1ZsTG9GMW02UHUvNjJjWkR1U2tIQjY1WisyUUN1U0h3d0gz?=
 =?utf-8?B?MExuZXdzLzR1eHkxQWtkbnJlQUNKYUcwanlwMlpZdksyQjZTbXg2RCthZWZN?=
 =?utf-8?B?ckZ6cU16MVNZVWJrbjdVTjJubmlYcjRZTkxiN3hXMW9mai9JWXBwNVN0UEZT?=
 =?utf-8?B?Y2ova0JGSmhHUk9acjRiMWlNTUtHQTEvMUFieEJiNlhJNW0vaUNKOVoyN2Q5?=
 =?utf-8?B?cDdKM2s4eFVjWmxBSVhYNmkwSXUycEdCWHZSR2tDZlZZUGlwa0E1RXpvTy9H?=
 =?utf-8?B?U1hJRDJMY0tJSzlmZFdST0RtU0J4NW51a0NaZ1R6bjcwUmhGeFRwdEJKUXEr?=
 =?utf-8?B?VlFPQmJJVUo4ak12MFJTenVOUDhvWXF5N3Z2djNnKzB1YlJFUXBlVXJOTFdQ?=
 =?utf-8?B?SGFyd3lrS3pHVmkxcmhwbDI4WWFKYjJFR1lpcUtvQUtCY0VmUXZEUHpwQlpW?=
 =?utf-8?B?R0dmS0lXcUFNLzJDOFZPQnAyZUUyY08rK2ZjbkhXa1ZZcTRvMTJzaXpQeDZK?=
 =?utf-8?B?L2hmTUUvMDVleU1Ga0lEb3VBRy9yeTFQTnhQa2NyNHhiMXhPcU41dHdVdk1F?=
 =?utf-8?B?b2pLbTIwbGl4alpkOU5NVzNYK3doN0V1TkVFa01NQVNobEJwWVMzNG16N0lP?=
 =?utf-8?B?Q1R6Qmx0R002cFN6SEl5QlJmelVDOUx1cFkveU1IY093Uyt1NmZmZDB4V1BE?=
 =?utf-8?B?enA2aGpYR2pQQjhQWjcvM2g2dXR6OHhGdU9DNUVOOXRFdnVweHBaS3JERlRq?=
 =?utf-8?B?cGtaOXZHeTZ4d010T3V4U0JkSExNTDJ6L3FVaGtVeDYyalRsRzRTSW5pVnhT?=
 =?utf-8?B?ZWhXRWR0WHNnN0o0WHRmMXFBeEgxLzFLR0V6OEFBRXhzNzV5MVJPVGhGRzR1?=
 =?utf-8?B?R0oyUGdyblN1YUt5dWZCaE5CekpKUmVUUGV2d2hLMkV6QURXcThkaDVMSENz?=
 =?utf-8?B?MEZtNStoa0tuMHRYR2thVkZ0aU9ROTFYMWkyV1NYOUc1a2F2K29QSERNOW9t?=
 =?utf-8?B?bkxhYUJEWHJEUVY2WXNuUlVTVk9wenByUGtQNTJLaGlLK3FQTUo2bUI1T1FM?=
 =?utf-8?B?VzB0K1AvVzRWM0kxNmxWRk11MWk4RWY3RTg5T2thblVUbDNySXpOVm1qeUMz?=
 =?utf-8?B?VDdGL055Mmg1cHNGWXN2dzdwWGQycnZiM3kzazVQVFBncTJEbVN4STlJa2R3?=
 =?utf-8?B?bkdoZnRaWHI1L21ULy9YYkhOUDRtWGprWlBYWUNPOUtmK0JrUDVFNnY0UmIz?=
 =?utf-8?B?bW9ZUzZmOHVRbXNMT0pXNHBLYld2Lys0L0tkU2J6MjBQcDh3MUVsL1Q2ck9U?=
 =?utf-8?B?ZmZUT0xwbHpUQzlYYytYWjNJK0VHNVNpY2JjRm5uREY2WlVqMDZUNDJ0VnFh?=
 =?utf-8?B?RFo3Q2d4MXRPVHN0c2Jhb21Lc1VZSFZKblVnREkyd0R0ekFUT213MmRKSlhR?=
 =?utf-8?B?ZUhRRUt6QUlhaTd0NzV0UnN3Nmc5cTl1R0VHWE5sTFhnY1B5M1pLcHlFNEFx?=
 =?utf-8?B?TDJ5TmZjS3VkNWtrOGhuV3hGSzNENk5RQ0FJQkU3WHQzK0NrTkRIdThtN3lo?=
 =?utf-8?B?WVNodkFKdlFxalo3WkdYcUx2ZWFkaFRPdVdrMC80UENVQlNoWllFUC95eHhp?=
 =?utf-8?B?S0krQ2IzQmNIeHFhRnNsY3RCb2tjSHZFQ0NPcXQxMUQwZTV1M3dyMXZqVG50?=
 =?utf-8?B?SCswNGZoZTRUUXBFeUJJbk16dDloRzZuS1VGR0dKbHZ4UEJmcmRFMzZicGdJ?=
 =?utf-8?B?VmdhSHh2L0J2cUcrSllHQ0dqckY3TWRtUHlGck4ybEIzSERneG1UODRoNmlI?=
 =?utf-8?B?bzJaeG1xL0lYKy95T0ljWmc4ODVsK2FJdlY2MnFxUEFZQTdlM25OWjVrZlQv?=
 =?utf-8?B?MzdmVDRsYkk2dlgwSjR6Ylpjdi9YSWpKTkdkczNqcFBiQSs4SWpDNTBwSXZR?=
 =?utf-8?Q?wsSJaapyoWb1qCY/7nA3PgWmJhQAVY3O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 18:46:12.0357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f5612c-9c4f-459c-776d-08dcada338a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

On 7/26/24 4:06 AM, Muhammad Usama Anjum wrote:
> Rename module to bitmap_kunit and rename the configuration option
> compliant with kunit framework.
> 
> Cc: kees@kernel.org
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   MAINTAINERS                           |  2 +-
>   lib/Kconfig.debug                     | 15 ++++++++-------
>   lib/Makefile                          |  2 +-
>   lib/{test_bitmap.c => bitmap_kunit.c} |  0
>   4 files changed, 10 insertions(+), 9 deletions(-)
>   rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12b870712da4a..289b727344d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3814,13 +3814,13 @@ F:	include/linux/find.h
>   F:	include/linux/nodemask.h
>   F:	include/linux/nodemask_types.h
>   F:	include/vdso/bits.h
> +F:	lib/bitmap_kunit.c
>   F:	lib/bitmap-str.c
>   F:	lib/bitmap.c
>   F:	lib/cpumask.c
>   F:	lib/cpumask_kunit.c
>   F:	lib/find_bit.c
>   F:	lib/find_bit_benchmark.c
> -F:	lib/test_bitmap.c

This changes the situation from "works for Linus' tab completion
case", to "causes a tab completion problem"! :)

I think a tests/ subdir is how we eventually decided to do this [1],
right?

So:

     lib/tests/bitmap_kunit.c


[1] https://lore.kernel.org/20240724201354.make.730-kees@kernel.org

thanks,
-- 
John Hubbard
NVIDIA


>   F:	tools/include/linux/bitfield.h
>   F:	tools/include/linux/bitmap.h
>   F:	tools/include/linux/bits.h
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a661726..6bb02990a73e7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2420,13 +2420,6 @@ config TEST_PRINTF
>   config TEST_SCANF
>   	tristate "Test scanf() family of functions at runtime"
>   
> -config TEST_BITMAP
> -	tristate "Test bitmap_*() family of functions at runtime"
> -	help
> -	  Enable this option to test the bitmap functions at boot.
> -
> -	  If unsure, say N.
> -
>   config TEST_UUID
>   	tristate "Test functions located in the uuid module at runtime"
>   
> @@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
>   	  on the copy_to/from_user infrastructure, making sure basic
>   	  user/kernel boundary testing is working.
>   
> +config BITMAP_KUNIT_TEST
> +	tristate "KUnit Test for bitmap_*() family of functions"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the "bitmap_kunit" module that runs tests for
> +	  bitmaps int the kernel making sure that there isn't any bug.
> +
>   config TEST_UDELAY
>   	tristate "udelay test driver"
>   	help
> diff --git a/lib/Makefile b/lib/Makefile
> index 322bb127b4dc6..37e7359a7065e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>   obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>   obj-$(CONFIG_TEST_SCANF) += test_scanf.o
>   
> -obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>   ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
>   # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
>   GCOV_PROFILE_test_bitmap.o := n
> @@ -388,6 +387,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>   obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>   obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>   obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
> +obj-$(CONFIG_BITMAP_KUNIT_TEST) += bitmap_kunit.o
>   
>   obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>   
> diff --git a/lib/test_bitmap.c b/lib/bitmap_kunit.c
> similarity index 100%
> rename from lib/test_bitmap.c
> rename to lib/bitmap_kunit.c

thanks,
-- 
John Hubbard
NVIDIA


