Return-Path: <linux-kselftest+bounces-11989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81E9094D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780631C20DB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B625186E5C;
	Fri, 14 Jun 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kScD13Hs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFE185093;
	Fri, 14 Jun 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408347; cv=fail; b=c86SDLOKnr54dAQcw8ze+w0CPpQQzk0H4h1IRTFx4FlrS7ZIEJeUqal7bmo0y2jCI9JtDN2xcrNIuFJ/mUCWcBgPg8GkN2qc+E+QCVbqOY4z64sbCgl/MrMsjXgk+h56Hy7Ijy8z5W/Kv1RN8gnaj0Yk5OAHGMLZZB/bo/pDmMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408347; c=relaxed/simple;
	bh=Pk1/ObaVXI98/IC0ygKdMUWnxqef12lUnrLMgPmG9u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nkFPUMYq/MQ2Bkg66cF4O2NL943i7VinT6XmKstl5SA3Q6fkVo9YqiTbYwXWdk9heGXxw7Y3ptxEb1qQqJRv6zFg9LkE4wEpsH2fthT6GlUZicKSZOX9RrFe1hfwV5UL7VHbxwRuWZJefLW/Xa/t48abCBxNKuSvOcJ+9UiICjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kScD13Hs; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igeUzbrMaHPlch7Nv7Sxdg6+wfQqSqddD3NacCxdTUlGYFgdcoDhyg0l5jeVW/zcnJeX7vjqywQ4yXWniZgSofu5Ibhta5N7MEkEXpr88FP96sjctfIYAj6HjRRkHkGmMIb49qJFD6YJNXwt/K1EnjF8sj8TA+AOasuZ0z/kEcSOC9paY7yEE6+ylVnLvfEls6FRZWMRvbE8/XOibf88YRYmUawTxsljy7Hff6s/iaeKpLb5/i9hH6waT5G5TFaRD3is59gXCHqZxzTlLhT8WZYsZxwg7nZcUtuyP4bsDhf/EreuZGHaeGzYyVw17qcMK/2jyv4UyTiWtetdBWJEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhVPvdU41zpfsVovB+m/5TIi4QEi4IZ8DvFmagAyWM=;
 b=jDd37G4x0oIxruV98s8Q+QEC7q19WdedP26k8/HMyRj2/P2xrYC9MwYs0aUeWK/pd1GH94ftLVUc3EpCuy+gTHwT+ZCFdV0QVJtu0O+IItY08IotBME4NXAP2cVClsHxzw6UG2RZQSMFvtrfXg9SYbpjRiieNyfzuNqc4Q42AYZUdEO9k6NHwI3Huav9Erg/AvHQjLJji4quihH5ra+ibkSMROQZC6Dn0gxrE2HQS3n7qkIuXcDU6xl/WQ2xHFDh76KWG+D1x9n24r+nIy8G/J9hKvh30qaUgOaoRN01yIp9JNHQxclWY+0Cl30uwQfRtMPDJm3YqpYtqird99NLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhVPvdU41zpfsVovB+m/5TIi4QEi4IZ8DvFmagAyWM=;
 b=kScD13HsaagFD4wnvMuM6KEfxh7Xj6oRkBKAZvixkKDxF/5FYHZ37tpQspaNFQ82SmErbsW2UdGYaYXa5vSvcFIhn0XrkP1kbEtenJJ5/MFK2SpIcFFTw0DMl7yx94QrFAiPEwN7E2BRNFBo+FCBtvaJaTtxmDpnnmL2FyVcRw4aLB36ZDeM6l57sdtnJR/qD/bLvb3J7Hg8wVDXaGkFTiWgARWoHvRxCGvTeM1lq7aAGDVJINPvyn0QGzgA4q9VjjyXIImDOR1v28o2hZ4B4r8iOEwCvst6vZrCis71ouLaatJAwuWbtKzZJ6tlbpOH/VAg6MyxJi2Ckun4iY7b/g==
Received: from SA0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:130::21)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 23:39:02 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::53) by SA0PR13CA0016.outlook.office365.com
 (2603:10b6:806:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Fri, 14 Jun 2024 23:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 23:39:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 16:38:53 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 16:38:52 -0700
Message-ID: <ab6124eb-88a7-441b-add9-b12176308155@nvidia.com>
Date: Fri, 14 Jun 2024 16:38:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and
 warnings
To: Shuah Khan <shuah@kernel.org>
CC: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andy Lutomirski
	<luto@kernel.org>, Mark Brown <broonie@kernel.org>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, Carlos Llamas
	<cmllamas@google.com>, Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
 <20240614233105.265009-2-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240614233105.265009-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4cbf64-1c16-4d9e-331b-08dc8ccb2c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWxCMGVra0lBekEzNG5qL1pZWTZKMnBCMkIzUDlaT2pkejdQUVBtNC8xTEFN?=
 =?utf-8?B?aG56YUQ4L2JWa2s3VEhGTHdpQ0dEVXRSSUpoZWtHYVFWQ1lVdjQrUnY0NmR1?=
 =?utf-8?B?Q0RMTlk3UHBsTHU5VTFSdzFtUXJIV3A3UTNORWIwL2JKRWw3RzUzQWtqSUdw?=
 =?utf-8?B?blRvWVgveDBzMHJyS1kvU29LdVluV3IybjNhTDMvMWtMSmtXVytCaElhTzA0?=
 =?utf-8?B?UXZyZ3hZU1orR0xBWDNSR0hVdjRmWTc4SXE4UzJvTkVrQktpSXNZeGt5YXlZ?=
 =?utf-8?B?V0tVb01JNDU5STBtQldRWFF4MTdmVkxEaU9OZTdMb1dEVjhiRXFESnNjclF5?=
 =?utf-8?B?amhqODhUVUJBSU02K3U0UGdiR2c2bGUxM1o3R1kvUFBtMDdKNnBFV3lkZHJa?=
 =?utf-8?B?TG0wb1hPTE5BVDRuNCs5UWs3NDdmSmdKNDVCWjhaRlArNXd5MlZ0RVBOSXdC?=
 =?utf-8?B?QUN6eW1pbzVqUkYwWVRHL1VHRHlFSHlnOWUrWlErbTExN1VoelJ6dzJld0xT?=
 =?utf-8?B?ZW5GNHNuYm1RWFdIbGlPa1VvZDVBb3o3Y3pSdjRTalNTY1hVVVFielppVTFD?=
 =?utf-8?B?bDVibGRXVXFSRy8rOFVRSkVVeWgrWWpveEs0MTZWYlArYWdzMTBGRC8yZUhR?=
 =?utf-8?B?UHpMeDk4UzdqYldCTE5RcmFrTXVhUnZNdzJlendyYUxMZjkxQ3l3NDBBc3R3?=
 =?utf-8?B?cHpta0xkd2pMb25Ick9FbmRkZlhCbmdvL1p2WkxKaWgvMlJMQXZmYVVVSmlp?=
 =?utf-8?B?L0k4ajA2STdBdDJBeVdBNzNaWFh3Nk5RWGQrdnNCZTU2bkRqajZQK2I2Wnk1?=
 =?utf-8?B?L29OVFoySzFEbWRxMk1HVjlTRWpTZGY2U2lldi9haStXRWthMy9pY1Z3YkFN?=
 =?utf-8?B?T1Z4VkxyY3NrQXdkeVNncFdvSDZDdXMwSGc4N2tsdFBZQlY3Zk9BRXRZNEJG?=
 =?utf-8?B?Sm5EUDNSTjJnN2FxNmZFT2k4NDJ3aU54YjRBMTBDbDc5dFFjWHo2UXRGcEpH?=
 =?utf-8?B?Y0hTa2pSRzUrZzRoeUluOFpXMEZITmc5eENLbEVXaVk0djlPSkZUcGlRZExi?=
 =?utf-8?B?VU0yOVRNVkx4cGExWGpINXYzZDUxN0x2V2JIcE9oOXdoVHpmcU1RTG41WWZ6?=
 =?utf-8?B?TEpoZXFZY1hpWFR6djdjSXpSNStoaVFWbWZqTmJ3ZWJYYzE4ekF6NlZzSitk?=
 =?utf-8?B?Rk5leVhMVk0xOEtMQ29BV2p1MmpjQmVnRWh0d21obXdHck9vVGJYYTdaTWRh?=
 =?utf-8?B?bm00YnNwc3pwTlcvM2ZuaGtDVlpTL3pLSFZ4K2hOVEtlOXZicmZWNmk0bTh0?=
 =?utf-8?B?d2lsNDhRbmxCUnNObmdvSXlTWGl3cWRiOFpNTEhaYU1FNWorTmpHajF4SWN5?=
 =?utf-8?B?azY0bEJxSmVKSk41a1oxNzhGU2JOUk5xOUJFMXQ3bXFQWTVnZS9ITS8xYk54?=
 =?utf-8?B?VXRwN0hid0t0Y0srOHpocEx5NjVOYWl4V0drRDFUNnoxM3FYaVZlc29ZQlJq?=
 =?utf-8?B?YTlUZ29NUk1GalF4S3NlUnV0RkpFZTYxNjNkbFNtOW8zWUNNdUtHSzBhUFpt?=
 =?utf-8?B?YWlUeXdPbEw1T2E0dWlFQmxZYisvVkVyODNkdHhhZG04L0JYZko3RllYOHM4?=
 =?utf-8?B?blg4elR3L1FQelpTbHNHbGg0VkxUbVVsS00yYTAzNmNuRmZ5aGtxN1pMRWpo?=
 =?utf-8?B?WnljUlZoVGF5OXU5N1J4VnFJbHA1VnpDK0t5YmJ6ZU5XUk1Fb0hCeExmTzNn?=
 =?utf-8?B?eUoydW5CNGpsWEdhcTVzZ0lSQVluMnEwN21TcDhhU3NqOFJIbXIvZlMvVThh?=
 =?utf-8?B?Z2F4d295NGV1OWIrQVM0RzVZbFdFMHBJQ01JMHY3dlJrQVRaVjJKVGp5bjVD?=
 =?utf-8?B?ZXlzeTVZK0pMTUpjVmlsc2k5Um9XME1QNy9BZDhVNDVqZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:39:02.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4cbf64-1c16-4d9e-331b-08dc8ccb2c02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

Also Cc'ing Thomas Gleixner on this one, sorry for the omission.

On 6/14/24 4:31 PM, John Hubbard wrote:
> When building with clang, via:
> 
>      make LLVM=1 -C tools/testing/selftests
> 
> ...there are several warnings, and an error. This fixes all of those and
> allows these tests to run and pass.
> 
> 1. Fix linker error (undefined reference to memcpy) by providing a local
>     version of memcpy.
> 
> 2. clang complains about using this form:
> 
>      if (g = h & 0xf0000000)
> 
> ...so factor out the assignment into a separate step.
> 
> 3. The code is passing a signed const char* to elf_hash(), which expects
>     a const unsigned char *. There are several callers, so fix this at
>     the source by allowing the function to accept a signed argument, and
>     then converting to unsigned operations, once inside the function.
> 
> 4. clang doesn't have __attribute__((externally_visible)) and generates
>     a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>     to require that attribute in order to build, run and pass tests here,
>     so remove it.
> 
> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Edward Liaw <edliaw@google.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
>   .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
>   2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..4ae417372e9e 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -55,14 +55,20 @@ static struct vdso_info
>   	ELF(Verdef) *verdef;
>   } vdso_info;
>   
> -/* Straight from the ELF specification. */
> -static unsigned long elf_hash(const unsigned char *name)
> +/*
> + * Straight from the ELF specification...and then tweaked slightly, in order to
> + * avoid a few clang warnings.
> + */
> +static unsigned long elf_hash(const char *name)
>   {
>   	unsigned long h = 0, g;
> -	while (*name)
> +	const unsigned char *uch_name = (const unsigned char *)name;
> +
> +	while (*uch_name)
>   	{
> -		h = (h << 4) + *name++;
> -		if (g = h & 0xf0000000)
> +		h = (h << 4) + *uch_name++;
> +		g = h & 0xf0000000;
> +		if (g)
>   			h ^= g >> 24;
>   		h &= ~g;
>   	}
> diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> index 8a44ff973ee1..27f6fdf11969 100644
> --- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> +++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
> @@ -18,7 +18,7 @@
>   
>   #include "parse_vdso.h"
>   
> -/* We need a libc functions... */
> +/* We need some libc functions... */
>   int strcmp(const char *a, const char *b)
>   {
>   	/* This implementation is buggy: it never returns -1. */
> @@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
>   	return 0;
>   }
>   
> +/*
> + * The clang build needs this, although gcc does not.
> + * Stolen from lib/string.c.
> + */
> +void *memcpy(void *dest, const void *src, size_t count)
> +{
> +	char *tmp = dest;
> +	const char *s = src;
> +
> +	while (count--)
> +		*tmp++ = *s++;
> +	return dest;
> +}
> +
>   /* ...and two syscalls.  This is x86-specific. */
>   static inline long x86_syscall3(long nr, long a0, long a1, long a2)
>   {
> @@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
>   	}
>   }
>   
> -__attribute__((externally_visible)) void c_main(void **stack)
> +void c_main(void **stack)
>   {
>   	/* Parse the stack */
>   	long argc = (long)*stack;

thanks,
-- 
John Hubbard
NVIDIA


