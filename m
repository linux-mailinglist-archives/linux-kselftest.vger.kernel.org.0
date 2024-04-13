Return-Path: <linux-kselftest+bounces-7910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E18A3F58
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 00:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906991C20A6A
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 22:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B856B72;
	Sat, 13 Apr 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEQySvwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A456B64;
	Sat, 13 Apr 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713046243; cv=fail; b=lMerbfOYNk+leq2fpOcmPy/aNnxNtfqCDmZv2Zm+wEo2QKd0BDn9PzB4ppMBveXFCbMn0KHJgd02oIsqG7gnE8Cf4brRFl2AqEjMqOQUc4Sfo7fmtWQOArHUEeM947Xj5w64H7DxYX8Njuwx7K25ORLN5X2iyMq6Pm+87QrDbHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713046243; c=relaxed/simple;
	bh=Cwm2It0pRrVWliufBDS//8AqT2kHBz/WIWOQ4uz4E8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fq1llK6/7Y2r0zhht299vt928XjtEBEiQNeqCK7WngEI+LI0Gv/jdWRoYMexFI6NGmsrfac1xq0IEeJ0st+x7LMtSj+ehHlZ/ZSgCV9b3DCOhgUKdONSibTWelvcjBs/6srOT4YckQCVKrUCS4/GJzW2cF0k1zSTSj5Ra9EFsdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tEQySvwH; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIgD+H+LqqjxwEHwtrLFEkwDhGKDYUwgegic8h2GcW7+TiLVMR7Dyl652OdMs28jnFtAVaR+1FQMvlFGQtURQ1vVLeVwhdzZYI15lgpNrNa8mvRbewosF7m3w1Eg981sbJdq0HOb0WViITpF0Dfcl457hth95Smyz3aYlyIPo/T8rYmEPGWw9n+dMsJ0KNbwdBUcr3XcKxHtRjtKlJBxObr/abgDZM/HZ2Ny06b8nRFnIRwbohNOx/TcmCvL+jQ2+LvhrKYjPyDHI2m4fFj4X8W0CReHKcTuvE3dgSMfLI/9G2nqWRc3cCtAyEB2Pws5fLg9LSOzIFR2itbrpGQt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2REl4WPya79rcYfdIPjE545vRUwPlOtzqP5BDaa5/60=;
 b=RXjR8eD53H7xgmkxUMckbq2k5l8sAKnwML2SMWFk25CX1ioHovuD6kPatc9bgk6kUZcAhPERfDEwZ1QfCXlQ/JvNgtXHN6ihD80Q13giYmSoeyyRzMot9k2o/9LlMp8hYwuiTV0LZH51bBvimQK0AoafE3a0mj+/W6EdlJUBztCrttGg74qoJ1ilQob3hhGQZiNdNiPhE1HcPj9WJ9C13Jh/redrOCQvWm4vItqCJATNf6wQOwzBNGJp+1y9DwSdpAo7F0SI6A5WDvEzDEF2EaKiKZLRJQRcyH51fElA/n5/M0iXljK0acPHx7ZvaT9aaP0teE0xtBhr34YE8D76+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=valentinobst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2REl4WPya79rcYfdIPjE545vRUwPlOtzqP5BDaa5/60=;
 b=tEQySvwH3qjHExNBCh3oMGVKH4USZxiMogB/V6z2K44LTuPqhLPPcXill3q484x/fzDMHz/FJMGHf9FKdcihYKaRiXh55wnfaoKXskqVo2VJkFYC4trZwv/7qTjcY6Uoa0+3+y32Imk7tNwaeA1jksW5vl8eDMsmrEem8MnmjwpT1MOCoAwjGIHHhc8OMX7kNXVdMR5BZvNJT5MP/enZX9OUcLVcDqZZ2RJ8HsvUeuPvY+LBvEgu3Ka+SIknFkAhgvjUT5yTYw5MLdKrvnXxEPVC9gv5QWV1SgfT3mhsGN4vstdXY9HMZ7QGSPx2sVP885/acnjhSa3Muzv7Pvv03A==
Received: from BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.56; Sat, 13 Apr 2024 22:10:37 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::4b) by BL0PR01CA0029.outlook.office365.com
 (2603:10b6:208:71::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 22:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 22:10:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 13 Apr
 2024 15:10:19 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sat, 13 Apr
 2024 15:10:18 -0700
Message-ID: <6d398f1d-6882-40fb-8ced-7fe6bee2aee7@nvidia.com>
Date: Sat, 13 Apr 2024 15:10:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
To: Valentin Obst <kernel@valentinobst.de>, Shuah Khan <shuah@kernel.org>
CC: Anders Roxell <anders.roxell@linaro.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Guillaume Tucker <guillaume.tucker@collabora.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mark Brown <broonie@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Sasha Levin <sashal@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: d3144ca0-5855-42fd-98b8-08dc5c068c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sU5rWSwKtsg07jg9Up6JHal0UhFm5sLErVVw0YVOJWS/ZBAjE90LXfgusuG4q04+HrlmBaS4x7/GlcpxmF5WTRnj3QkrQu5wRNS0ZaFCIinyuXL5TPwte7xjWNinNQfYoFGxE7YQ+3ksXbMrWDWR/G2UGqUpgqM2YxF2vJXln5cEkIJ37u45bUF5Jxa/55aZTDQwSq3RZ769o3ufC8hEdTPNQFQQ8HpCU5tWLzJ5eXcurMwKu3jHZcIxLVWcF7DtrY+Z/YI3QmG/oXf4H444OH3TB+FzZyRtjzeWBhEbO1D5e5EBVDu7yCZkLhGEzAhCYZ6fTa19jPJhpJRP4NyIZY6TggHvzd+zmEBEsi74E4frNb6B0RN/HZ3r7st5xFKQ+fxr11lF5/4noBtCJOwxds+xd0QEi2eSFMwf/tpzzvKxnEQSjX+igrluCzLe9QssO+27xpxKnOU/giYg0N5esMh/bk/fJfXmz35f6kOkpUAsD5VZsedwnqR4QcQ7jS5wH3VIODHhSaXxXlqiTJH9MFWbzID3wvS7Sd/9v3ckQJ9VhOIGuoI98syI6fYqAG4M0to7Y7mWzQBK1zC570a8rdUwL6wkbV+0ezGYk3/3viT2nd/VxDg5RHhQWp0j4r5CS4X9McCLoxroeg35ttlGPUNfzHvU9MJygMKB5X1DYo1sOuFu/ra+Q9k6zmjXSYrPfXhwriutzYyJ0dxp4SYTUD8VKUWhpkoiPTCYvDTuNpTkr84DytjvNr7XS1Ei+mNJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 22:10:36.6694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3144ca0-5855-42fd-98b8-08dc5c068c06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

On 3/29/24 3:49 AM, Valentin Obst wrote:
> Align the behavior for gcc and clang builds by interpreting unset
> `ARCH` and `CROSS_COMPILE` variables in `LLVM` builds as a sign that the
> user wants to build for the host architecture.
> 
> This patch preserves the properties that setting the `ARCH` variable to an
> unknown value will trigger an error that complains about insufficient
> information, and that a set `CROSS_COMPILE` variable will override the
> target triple that is determined based on presence/absence of `ARCH`.
> 
> When compiling with clang, i.e., `LLVM` is set, an unset `ARCH` variable in
> combination with an unset `CROSS_COMPILE` variable, i.e., compiling for
> the host architecture, leads to compilation failures since `lib.mk` can
> not determine the clang target triple. In this case, the following error
> message is displayed for each subsystem that does not set `ARCH` in its
> own Makefile before including `lib.mk` (lines wrapped at 75 chrs):
> 
>    make[1]: Entering directory '/mnt/build/linux/tools/testing/selftests/
>     sysctl'
>    ../lib.mk:33: *** Specify CROSS_COMPILE or add '--target=' option to
>     lib.mk.  Stop.
>    make[1]: Leaving directory '/mnt/build/linux/tools/testing/selftests/
>     sysctl'

Thanks for fixing this.

And yes, the selftests "normal" (non-cross-compile) build is *broken*
right now, for clang. I didn't realize from the patch title that this is
actually a significant fix. Maybe we should change the subject line (patch
title) to something like:

     [PATCH] selftests: fix the clang build: default to host arch for LLVM builds

?

Just a thought. The "Fixes:" tag covers it already, I realize.

Anyway, this looks correct, and fixes that aspect of the build for me, so
either way, please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> In the same scenario a gcc build would default to the host architecture,
> i.e., it would use plain `gcc`.
> 
> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
> I am not entirely sure whether this behavior is in fact known and intended
> and whether the way to obtain the host target triple is sufficiently
> general. The flag was introduced in llvm-8 with [1], it will be an error in
> older clang versions.
> 
> The target triple you get with `-print-target-triple` may not be the
> same that you would get when explicitly setting ARCH to you host
> architecture. For example on my x86_64 system it get
> `x86_64-pc-linux-gnu` instead of `x86_64-linux-gnu`, similar deviations
> were observed when testing other clang binaries on compiler-explorer,
> e.g., [2].
> 
> An alternative could be to simply do:
> 
>        ARCH ?= $(shell uname -m)
> 
> before using it to select the target. Possibly with some post processing,
> but at that point we would likely be replicating `scripts/subarch.include`.
> This is what some subsystem Makefiles do before including `lib.mk`. This
> change might make it possible to remove the explicit setting of `ARCH` from
> the few subsystem Makefiles that do it.
> 
> [1]: https://reviews.llvm.org/D50755
> [2]: https://godbolt.org/z/r7Gn9bvv1
> 
> Changes in v1:
> - Shortened commit message.
> - Link to RFC: https://lore.kernel.org/r/20240303-selftests-libmk-llvm-rfc-v1-1-9ab53e365e31@valentinobst.de
> ---
>   tools/testing/selftests/lib.mk | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index da2cade3bab0..8ae203d8ed7f 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -7,6 +7,8 @@ else ifneq ($(filter -%,$(LLVM)),)
>   LLVM_SUFFIX := $(LLVM)
>   endif
> 
> +CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> +
>   CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
>   CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
>   CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
> @@ -18,7 +20,13 @@ CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
>   CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
>   CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
>   CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
> -CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
> +
> +# Default to host architecture if ARCH is not explicitly given.
> +ifeq ($(ARCH),)
> +CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
> +else
> +CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
> +endif
> 
>   ifeq ($(CROSS_COMPILE),)
>   ifeq ($(CLANG_TARGET_FLAGS),)
> @@ -30,7 +38,7 @@ else
>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>   endif # CROSS_COMPILE
> 
> -CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
> +CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>   else
>   CC := $(CROSS_COMPILE)gcc
>   endif # LLVM
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240303-selftests-libmk-llvm-rfc-5fe3cfa9f094
> 
> Best regards,
> --
> Valentin Obst <kernel@valentinobst.de>
> 




