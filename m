Return-Path: <linux-kselftest+bounces-35138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F293ADB874
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218FB167C02
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC6286D69;
	Mon, 16 Jun 2025 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rl0yBx3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10C289810;
	Mon, 16 Jun 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097205; cv=fail; b=LMJ488+5YlqM8G1IcxTyZlTQ9IUIs8Nt5tbYuhqVYY+P0NXWyW0lK3vX+Vp41W2Pmte0JUiqDYnPOR7ayg0HcFYIo+Ev5nDIEWXu4dlkFnVuKuq8MYq1GmvbraWEvpHGqJvPoV4WyoDik3vfMY+KfuRj/mtPjPN6b4oW3EKl350=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097205; c=relaxed/simple;
	bh=5hl6g6TTF0bCJf9pdldcwIQTu0+z0zwIgHHTu0ix7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zdg2/AhI326uWXGpbatQZPvCGPKwVsW13HaaS3vqM9gOkunpi84TrXSoGj8Y1qL6rF1E/aedhOo2FF3K8KMuceZbh9zQqDZhIWFkHWEkHZfxohTm0koFRnLTuaWgdZsm+Qh6FlLuaFLZ/hnFINp4yw3F0iIeUA603LLbtGMZfOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rl0yBx3k; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp5Zx2sx4yZeonQiFeHZc3qE0C91ujOTzxRL5ps+Tzt1GQSXpdFLm/mP5/06x+UrGEqzFUFileKy5AqdpwZqOfOk+77mVibPDl+VKl6yeKWf/iTU1EFJtJUKHYi1lCO1CLwyzhAw4cNEpbMsCU72/NxqHZ5eTAtWSez72AO4z6065/grNWQxV6SHDDxIZq85YCcKNiZtXHUYCfHb8tmR90UmtLr3uZkuxA3Ru/SGjTy1jaQliTgtb5ys0o/0iJI93TY2mgf6yWU5d0Bg+uLhSMS6hrju4jiMNsGHSue7Q0ll/kzmYX2VjRE4IfzATx0tCKPyMuFevsug2zRB8KXI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scZF/i4RHg+pRROs0N2yOPXKyN+6japTyN4tYFD82yo=;
 b=TNdXcsQXkwzqiHh4ywZETMEEqYsAWAA3W8d9JAWoOecq3ZSN9LfeoM0lYXhoSCfjG6aPQPBBJvmOIVIa0zwibPeZP1uqG4fz3tQkmtMweZrQRp/HLOUt4fGUHLrLY4ot7zOzOcdpUAhZJD5Jo3sbT3Bgb/IAG6Ogv5h/Dwkn+c7yHjLiETWy8Q+a/u1WFXjBMApHty3yIP8PABK9S1p8mZG4y/kLRLhWLHDyO5/hfHr3LJ43aMWmoUMllFBsH9MYCg/RXqwNRRQqUluxN198WRS0eYCqGOnfLqrMPJoXyRbpvV5+NKSbaeE3V7LwutkX7RjSPvgdgJ9kAZadegLkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scZF/i4RHg+pRROs0N2yOPXKyN+6japTyN4tYFD82yo=;
 b=rl0yBx3kBXmMfMFbfpvp8NIAfi5U33bcD9OO30bJmavbE/Y31c/M0G7csSpjSG0CGhjlu7uOZQi1rhdYeW+aZge92k1t9U/9ZxaDoTQ6PokOtwOAn0jSpL5bCSZep8Fh8Eqbh9w0HFFlyP1hmQQHmQ6eQX6QJQaYWS+YAULoiMRvm0+AqEfZH/w0CYLunZ3OfpP6QqrgtT7iMn9NwK9Bvli7y8I904r1Ti9JM+DClDu0geRHZIJiWOtQRBYfQ2nIvqarrNzBvDYyVG0F2SlOkNLFOQ8wjx7VcrP5vwuSwsmoEPtI27a6bQPi1Pwn0YizNLBwaLn9LzMdNAaSoYbsiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:23 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v3 14/15] iommu/amd: Remove AMD io_pgtable support
Date: Mon, 16 Jun 2025 15:06:17 -0300
Message-ID: <14-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b9b6f6-289c-4523-da99-08ddad007f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qATARa23CV/fNY6c9DdJK9/hAwQVEs8JoaKYr+tC6JXPjaGVl9wv5wKOwN5y?=
 =?us-ascii?Q?asfoMMzCW7Y5DL52Zuej7pLaV7XGz7axL/CUoRORyb7nnzZ2L4r7K7qb7FZG?=
 =?us-ascii?Q?dn9eGaCdLLKv50AbEraTc+vPbHznj3dMPWIye0Pek/bu1hcmhdeEy5zPzizM?=
 =?us-ascii?Q?Mt1+eNbhxhrrqzUgTykWr+KFLSB9X82kGdabnEoSPvW8v8hQCTPasR99CbWN?=
 =?us-ascii?Q?JqBLFutwyrom5olrs1PcR0y9ZWK+aye+Vk0yb0/jp0BA8a4ZCCxHKa0SQyvr?=
 =?us-ascii?Q?p7QLyNE1/XFwDXSrla7KQOSrNVyrA+2RblqopUIyLRY/ajZAXpRsFm5SPXuh?=
 =?us-ascii?Q?xDjC4TyaCWHRkOjj47wDY2z9dNLvRPEvoeEEnzSvnwy+WWMHbloPdeAWFVae?=
 =?us-ascii?Q?HNUI55XWQVuyz7IWAuGn1Hv/0EyaClc9eqTdNCjLbiQ4FZLneNcH9BYSauQT?=
 =?us-ascii?Q?Gm7Q3nx4pXSgqd0qO/RVoHfWLNf0aToapEIoMybamYoqpj6TGvJKwvto1Wfz?=
 =?us-ascii?Q?GE99+jiOg2Eqby71EVApF5VNGmldhK1B7RWnaF3/5oPABZkdlGjiy7h8UgRu?=
 =?us-ascii?Q?ZphASUIk5sl6rK847MhPaELH2U4HT7ga5OxBcf/Oo112NTPZkvALteWscdmH?=
 =?us-ascii?Q?kiYESWXd5ielv3i4njunAtH/4F8Yrtc2lzpYXO5s8XIQ8NjKj/uo8RudkQei?=
 =?us-ascii?Q?wrHrRqrwyiPWHRr4bpFvRkAv1Ns6K1wXKv6ZBqIjmEtEE2fKyDEkqQtAL3OO?=
 =?us-ascii?Q?Whifx4zziCiM6gjsVwRnao0fb4k4cVb2Fw+8Sblr3TW6r3u0KHgFHww9bQ8D?=
 =?us-ascii?Q?KGqrH7z/OdNVChIzcPDcSXGTuthzNi++OjrAvISeQfqCZUe35gJusw/UOwdr?=
 =?us-ascii?Q?/UIMB/4XLFEdaWLBsYHhVanaOdhDY7G69JOrGTXNG6VtIbej9njJ44L6jGMQ?=
 =?us-ascii?Q?7Ui7TJav9r6WESrSpLcpIzB2LqZLg6jSIqSpRE0zUwg82uVxxQseHZWcgTj4?=
 =?us-ascii?Q?8b6VATEaBgkotPEBkDkhmF8WWsuN5K+RTmKXQ2NwoTCTaoEckWzbDtcv/7Tw?=
 =?us-ascii?Q?f3GeQ/KOVOPhPopKX44ogZwwkSdmdFi4lVOOZ08D4FjH5zrd7UPUygwdVcPS?=
 =?us-ascii?Q?415+v1Z3D50fFlCTX3yyBrS5Zw6M26UkYS/2zYYIR1WaT5vFxyDdo3c0t7qz?=
 =?us-ascii?Q?n7ai4azp7CCKZPV3ePbqjmB+saxfe9Cp411lElvbpkMGkb0VroFYPEIfs+Iu?=
 =?us-ascii?Q?yF7i/GKtVKq96IpW09UL6KtJqMvz1uMmdMXLYONbXsz+0n8cwjkCL73eUmYi?=
 =?us-ascii?Q?YRYLaLNMZ3kjsLThOlZJohGBIkOtnDiN8s5opAGC/7KWq6taxjbxY5OKa9FW?=
 =?us-ascii?Q?GtYuTwSwtCvkquW3u8CJp+XR3o5WP3HjYzAfIHCIFLEem7TQg1fU90tl8rix?=
 =?us-ascii?Q?NLqyvCIy3cEzxavIst/xb4y5Cr5OUxs0l9UEfML0TqJgKLalHwIraQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6PXHrMDtLWQwQsz2kGw4DgQ/YllT9/cp3g2/ytjEgKfpFreK4umFDpAQUJwD?=
 =?us-ascii?Q?SMLS+/5+DFAAGpYxLhLGIwKi7jkH3qQv2qx3CmfZb804ddH+FzLO29rK9Amj?=
 =?us-ascii?Q?YWmansdAvJgJeYakl/RX1nL8RahVpO5qWl68q1m06XvYAe73jLrD2ycdG0yU?=
 =?us-ascii?Q?TPIft5MSiSfDqFgZ0HkmWPQy5q4y7L9N1ozLKN48wp5CeTqU269E8dBZquO+?=
 =?us-ascii?Q?rQT6PFuftcwrcoiZVb/FR7oc4IQlSsGFSK12mY2UEPXBC0tDs9FRjPDqy2uV?=
 =?us-ascii?Q?BqwYfGTGWBvAMQ7W4C0nCBGrpU8DzZGTlAtnujmYdAJSO8cO7oPzXv/KELSJ?=
 =?us-ascii?Q?/L9kafbKgiDnaNaQL/zLZP92yrvI4CPcWSaoMcRO0B4yEKFAgEvXPNsh4EUB?=
 =?us-ascii?Q?113YgwtS0wALCuCpjjIJbmzFDwhdUN7yPDNHJj6AFk5D8yfqhSSv3mkjT720?=
 =?us-ascii?Q?hzuz7iMF+o6y7G24NAxrwPkmCViJLD7lJh6hRsVRsrcdLypYfDfKLrYF2b8t?=
 =?us-ascii?Q?MPJtR/ohqPmCka1GsVxKjHAB+SRQ9NkszXG6wzuKpX92WkHp0prByj8bSCN+?=
 =?us-ascii?Q?35bouy6iOTM02P5/0l4jvWoOoE4nXTv/PdUPgj8iKKM3LN2DTrYxqx4CAwmu?=
 =?us-ascii?Q?dhIDAeLZ+y0zU1e5Yf2HyUHhJhob3/ENHjFmsJKeF0Frg5zEE3Ez8BUw5zey?=
 =?us-ascii?Q?uiqCtuJbNinrTjHcCbtClsv76YGwgZAttQp0qGMo6fQcxgL85AuemHKn8kXr?=
 =?us-ascii?Q?F2F8zPCH68DWDgRF9QLMEhZNN5TG4B8tAO630LaCijwEdWrXkmBGs672z9Tm?=
 =?us-ascii?Q?9CLgeMa9t/zRQDfE2/3FzG4N/QlEx3bauwvcN6n9/okrhf/PBdnq4nofH3df?=
 =?us-ascii?Q?ogLvoNCwYD/wqr0/NS14Xef3T0XWiREmMY8CO34R4gUVjDAHnnG8rf7mDmRd?=
 =?us-ascii?Q?2MwP8Bhqlj0pewa3O31n9LbHqfJDl+sD/f3XhkM3dk5JH78vXxtS/7DkszXg?=
 =?us-ascii?Q?Ln8qlZ560vd/sBTnsh8nQ/zRBpxGF4yzQsPAotSlN251EZhbplriSmBm3DTg?=
 =?us-ascii?Q?uG0v5nBsTMFQvx84J1kAAzhoYaQ9ABOcQMTGnZyj8ocABHeFV/Vi0OT9SDxs?=
 =?us-ascii?Q?UBarEX3CwEx/gEV98Tue0Fc6+sEN8/yZR0i2Q25s+VAWC7OGNsk9GFNNuQB4?=
 =?us-ascii?Q?81esQ9BJX0cTY7Dll15Ak2iruCNH+6+vy3EYr3IZ1x4E8SJZsATw6Lq2yHqJ?=
 =?us-ascii?Q?OrtI/zfX/ZH51KW+3+mEr9D79x+LCbFsaT6SVpWiM6YxuEUxuySkQMZ5//Lg?=
 =?us-ascii?Q?d6n2t2medXoQz2oN9yZzU8zmR/PNnK7g7RDqbBHukiXZeVXLpDJ0U9zPJ28+?=
 =?us-ascii?Q?db1Rxiq5ya5760bt2q/as2hjhw0JHqr7FyjDO+6mrXKY7V8Ld+zMeec28sz7?=
 =?us-ascii?Q?gSRgQnZIUDXmYU3f7lRhbqZ90/0lw3CCQ3xc370WgjLrlzBEtXTePOQDSJga?=
 =?us-ascii?Q?4bKZkQv2BGnsmNIrxLZJhZn58ymuapH6e+15cQlypfV2QIQ6nFtMsEWluYQG?=
 =?us-ascii?Q?Uvgy1mA5YVNKuSexQDB1JaM5OKKhq3zBphE5usTP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9b6f6-289c-4523-da99-08ddad007f79
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:21.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVnEb94KD3BLKpPA97hG8LF4K67oVrQ/+aGPLENv0kxmjJTAv1bXp9DWqTcIIgRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

None of this is used anymore, delete it.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |  97 -----
 drivers/iommu/amd/io_pgtable.c      | 559 ----------------------------
 drivers/iommu/amd/io_pgtable_v2.c   | 370 ------------------
 drivers/iommu/io-pgtable.c          |   4 -
 include/linux/io-pgtable.h          |   2 -
 6 files changed, 1 insertion(+), 1033 deletions(-)
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f39825..5412a563c6979c 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-y += iommu.o init.o quirks.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 08b105536a8e5e..5cb5312057124b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
-#include <linux/io-pgtable.h>
 #include <linux/generic_pt/iommu.h>
 
 /*
@@ -337,76 +336,7 @@
 #define GUEST_PGTABLE_4_LEVEL	0x00
 #define GUEST_PGTABLE_5_LEVEL	0x01
 
-#define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
-#define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
-				   (0xffffffffffffffffULL))
-#define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
-#define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
-#define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
-#define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
-
-#define PM_MAP_4k		0
 #define PM_ADDR_MASK		0x000ffffffffff000ULL
-#define PM_MAP_MASK(lvl)	(PM_ADDR_MASK & \
-				(~((1ULL << (12 + ((lvl) * 9))) - 1)))
-#define PM_ALIGNED(lvl, addr)	((PM_MAP_MASK(lvl) & (addr)) == (addr))
-
-/*
- * Returns the page table level to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_LEVEL(pagesize) \
-		((__ffs(pagesize) - 12) / 9)
-/*
- * Returns the number of ptes to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_PTE_COUNT(pagesize) \
-		(1ULL << ((__ffs(pagesize) - 12) % 9))
-
-/*
- * Aligns a given io-virtual address to a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_ALIGN(address, pagesize) \
-		((address) & ~((pagesize) - 1))
-/*
- * Creates an IOMMU PTE for an address and a given pagesize
- * The PTE has no permission bits set
- * Pagesize is expected to be a power-of-two larger than 4096
- */
-#define PAGE_SIZE_PTE(address, pagesize)		\
-		(((address) | ((pagesize) - 1)) &	\
-		 (~(pagesize >> 1)) & PM_ADDR_MASK)
-
-/*
- * Takes a PTE value with mode=0x07 and returns the page size it maps
- */
-#define PTE_PAGE_SIZE(pte) \
-	(1ULL << (1 + ffz(((pte) | 0xfffULL))))
-
-/*
- * Takes a page-table level and returns the default page-size for this level
- */
-#define PTE_LEVEL_PAGE_SIZE(level)			\
-	(1ULL << (12 + (9 * (level))))
-
-/*
- * The IOPTE dirty bit
- */
-#define IOMMU_PTE_HD_BIT (6)
-
-/*
- * Bit value definition for I/O PTE fields
- */
-#define IOMMU_PTE_PR	BIT_ULL(0)
-#define IOMMU_PTE_HD	BIT_ULL(IOMMU_PTE_HD_BIT)
-#define IOMMU_PTE_U	BIT_ULL(59)
-#define IOMMU_PTE_FC	BIT_ULL(60)
-#define IOMMU_PTE_IR	BIT_ULL(61)
-#define IOMMU_PTE_IW	BIT_ULL(62)
 
 /*
  * Bit value definition for DTE fields
@@ -436,12 +366,6 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
-#define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
-#define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
-#define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
-
 #define IOMMU_PROT_MASK 0x03
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
@@ -531,19 +455,6 @@ struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
 
-#define io_pgtable_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl)
-
-#define io_pgtable_ops_to_data(x) \
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-#define io_pgtable_ops_to_domain(x) \
-	container_of(io_pgtable_ops_to_data(x), \
-		     struct protection_domain, iop)
-
-#define io_pgtable_cfg_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl.cfg)
-
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
@@ -551,13 +462,6 @@ struct gcr3_tbl_info {
 	u16	domid;		/* Per device domain ID */
 };
 
-struct amd_io_pgtable {
-	struct io_pgtable	pgtbl;
-	int			mode;
-	u64			*root;
-	u64			*pgd;		/* v2 pgtable pgd pointer */
-};
-
 enum protection_domain_mode {
 	PD_MODE_V1 = 1,
 	PD_MODE_V2,
@@ -591,7 +495,6 @@ struct protection_domain {
 		struct pt_iommu_x86_64 amdv2;
 	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
deleted file mode 100644
index e4b33eba554599..00000000000000
--- a/drivers/iommu/amd/io_pgtable.c
+++ /dev/null
@@ -1,559 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table allocator.
- *
- * Copyright (C) 2020 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- */
-
-#define pr_fmt(fmt)     "AMD-Vi: " fmt
-#define dev_fmt(fmt)    pr_fmt(fmt)
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-/*
- * Helper function to get the first pte of a large mapping
- */
-static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
-			 unsigned long *count)
-{
-	unsigned long pte_mask, pg_size, cnt;
-	u64 *fpte;
-
-	pg_size  = PTE_PAGE_SIZE(*pte);
-	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
-	pte_mask = ~((cnt << 3) - 1);
-	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
-
-	if (page_size)
-		*page_size = pg_size;
-
-	if (count)
-		*count = cnt;
-
-	return fpte;
-}
-
-static void free_pt_lvl(u64 *pt, struct iommu_pages_list *freelist, int lvl)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		/* Large PTE? */
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||
-		    PM_PTE_LEVEL(pt[i]) == 7)
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = IOMMU_PTE_PAGE(pt[i]);
-		if (lvl > 2)
-			free_pt_lvl(p, freelist, lvl - 1);
-		else
-			iommu_pages_list_add(freelist, p);
-	}
-
-	iommu_pages_list_add(freelist, pt);
-}
-
-static void free_sub_pt(u64 *root, int mode, struct iommu_pages_list *freelist)
-{
-	switch (mode) {
-	case PAGE_MODE_NONE:
-	case PAGE_MODE_7_LEVEL:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		iommu_pages_list_add(freelist, root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-	case PAGE_MODE_3_LEVEL:
-	case PAGE_MODE_4_LEVEL:
-	case PAGE_MODE_5_LEVEL:
-	case PAGE_MODE_6_LEVEL:
-		free_pt_lvl(root, freelist, mode);
-		break;
-	default:
-		BUG();
-	}
-}
-
-/*
- * This function is used to add another level to an IO page table. Adding
- * another level increases the size of the address space by 9 bits to a size up
- * to 64 bits.
- */
-static bool increase_address_space(struct amd_io_pgtable *pgtable,
-				   unsigned long address,
-				   unsigned int page_size_level,
-				   gfp_t gfp)
-{
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	struct protection_domain *domain =
-		container_of(pgtable, struct protection_domain, iop);
-	unsigned long flags;
-	bool ret = true;
-	u64 *pte;
-
-	pte = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp, SZ_4K);
-	if (!pte)
-		return false;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (address <= PM_LEVEL_SIZE(pgtable->mode) &&
-	    pgtable->mode - 1 >= page_size_level)
-		goto out;
-
-	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == PAGE_MODE_6_LEVEL))
-		goto out;
-
-	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
-
-	pgtable->root  = pte;
-	pgtable->mode += 1;
-
-	pte = NULL;
-	ret = true;
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-	iommu_free_pages(pte);
-
-	return ret;
-}
-
-static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long page_size,
-		      u64 **pte_page,
-		      gfp_t gfp,
-		      bool *updated)
-{
-	unsigned long last_addr = address + (page_size - 1);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	int level, end_lvl;
-	u64 *pte, *page;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	while (last_addr > PM_LEVEL_SIZE(pgtable->mode) ||
-	       pgtable->mode - 1 < PAGE_SIZE_LEVEL(page_size)) {
-		/*
-		 * Return an error if there is no memory to update the
-		 * page-table.
-		 */
-		if (!increase_address_space(pgtable, last_addr,
-					    PAGE_SIZE_LEVEL(page_size), gfp))
-			return NULL;
-	}
-
-
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	address = PAGE_SIZE_ALIGN(address, page_size);
-	end_lvl = PAGE_SIZE_LEVEL(page_size);
-
-	while (level > end_lvl) {
-		u64 __pte, __npte;
-		int pte_level;
-
-		__pte     = *pte;
-		pte_level = PM_PTE_LEVEL(__pte);
-
-		/*
-		 * If we replace a series of large PTEs, we need
-		 * to tear down all of them.
-		 */
-		if (IOMMU_PTE_PRESENT(__pte) &&
-		    pte_level == PAGE_MODE_7_LEVEL) {
-			unsigned long count, i;
-			u64 *lpte;
-
-			lpte = first_pte_l7(pte, NULL, &count);
-
-			/*
-			 * Unmap the replicated PTEs that still match the
-			 * original large mapping
-			 */
-			for (i = 0; i < count; ++i)
-				cmpxchg64(&lpte[i], __pte, 0ULL);
-
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE) {
-			page = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp,
-							 SZ_4K);
-
-			if (!page)
-				return NULL;
-
-			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
-
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		/* No level skipping support yet */
-		if (pte_level != level)
-			return NULL;
-
-		level -= 1;
-
-		pte = IOMMU_PTE_PAGE(__pte);
-
-		if (pte_page && level == end_lvl)
-			*pte_page = pte;
-
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address. If
- * there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long *page_size)
-{
-	int level;
-	u64 *pte;
-
-	*page_size = 0;
-
-	if (address > PM_LEVEL_SIZE(pgtable->mode))
-		return NULL;
-
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
-
-	while (level > 0) {
-
-		/* Not Present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
-		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
-			break;
-
-		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
-			return NULL;
-
-		level -= 1;
-
-		/* Walk to the next level */
-		pte	   = IOMMU_PTE_PAGE(*pte);
-		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
-		*page_size = PTE_LEVEL_PAGE_SIZE(level);
-	}
-
-	/*
-	 * If we have a series of large PTEs, make
-	 * sure to return a pointer to the first one.
-	 */
-	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
-		pte = first_pte_l7(pte, page_size, NULL);
-
-	return pte;
-}
-
-static void free_clear_pte(u64 *pte, u64 pteval,
-			   struct iommu_pages_list *freelist)
-{
-	u64 *pt;
-	int mode;
-
-	while (!try_cmpxchg64(pte, &pteval, 0))
-		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-
-	if (!IOMMU_PTE_PRESENT(pteval))
-		return;
-
-	pt   = IOMMU_PTE_PAGE(pteval);
-	mode = IOMMU_PTE_MODE(pteval);
-
-	free_sub_pt(pt, mode, freelist);
-}
-
-/*
- * Generic mapping functions. It maps a physical address into a DMA
- * address space. It allocates the page table pages if necessary.
- * In the future it can be extended to a generic mapping function
- * supporting all features of AMD IOMMU page tables like level skipping
- * and full 64 bit address spaces.
- */
-static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-	bool updated = false;
-	u64 __pte, *pte;
-	int ret, i, count;
-	size_t size = pgcount << __ffs(pgsize);
-	unsigned long o_iova = iova;
-
-	BUG_ON(!IS_ALIGNED(iova, pgsize));
-	BUG_ON(!IS_ALIGNED(paddr, pgsize));
-
-	ret = -EINVAL;
-	if (!(prot & IOMMU_PROT_MASK))
-		goto out;
-
-	while (pgcount > 0) {
-		count = PAGE_SIZE_PTE_COUNT(pgsize);
-		pte   = alloc_pte(pgtable, iova, pgsize, NULL, gfp, &updated);
-
-		ret = -ENOMEM;
-		if (!pte)
-			goto out;
-
-		for (i = 0; i < count; ++i)
-			free_clear_pte(&pte[i], pte[i], &freelist);
-
-		if (!iommu_pages_list_empty(&freelist))
-			updated = true;
-
-		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
-			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-
-		if (prot & IOMMU_PROT_IR)
-			__pte |= IOMMU_PTE_IR;
-		if (prot & IOMMU_PROT_IW)
-			__pte |= IOMMU_PTE_IW;
-
-		for (i = 0; i < count; ++i)
-			pte[i] = __pte;
-
-		iova  += pgsize;
-		paddr += pgsize;
-		pgcount--;
-		if (mapped)
-			*mapped += pgsize;
-	}
-
-	ret = 0;
-
-out:
-	if (updated) {
-		struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&dom->lock, flags);
-		/*
-		 * Flush domain TLB(s) and wait for completion. Any Device-Table
-		 * Updates and flushing already happened in
-		 * increase_address_space().
-		 */
-		amd_iommu_domain_flush_pages(dom, o_iova, size);
-		spin_unlock_irqrestore(&dom->lock, flags);
-	}
-
-	/* Everything flushed out, free pages now */
-	iommu_put_pages_list(&freelist);
-
-	return ret;
-}
-
-static unsigned long iommu_v1_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long long unmapped;
-	unsigned long unmap_size;
-	u64 *pte;
-	size_t size = pgcount << __ffs(pgsize);
-
-	BUG_ON(!is_power_of_2(pgsize));
-
-	unmapped = 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (pte) {
-			int i, count;
-
-			count = PAGE_SIZE_PTE_COUNT(unmap_size);
-			for (i = 0; i < count; i++)
-				pte[i] = 0ULL;
-		} else {
-			return unmapped;
-		}
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-static bool pte_test_and_clear_dirty(u64 *ptep, unsigned long size,
-				     unsigned long flags)
-{
-	bool test_only = flags & IOMMU_DIRTY_NO_CLEAR;
-	bool dirty = false;
-	int i, count;
-
-	/*
-	 * 2.2.3.2 Host Dirty Support
-	 * When a non-default page size is used , software must OR the
-	 * Dirty bits in all of the replicated host PTEs used to map
-	 * the page. The IOMMU does not guarantee the Dirty bits are
-	 * set in all of the replicated PTEs. Any portion of the page
-	 * may have been written even if the Dirty bit is set in only
-	 * one of the replicated PTEs.
-	 */
-	count = PAGE_SIZE_PTE_COUNT(size);
-	for (i = 0; i < count && test_only; i++) {
-		if (test_bit(IOMMU_PTE_HD_BIT, (unsigned long *)&ptep[i])) {
-			dirty = true;
-			break;
-		}
-	}
-
-	for (i = 0; i < count && !test_only; i++) {
-		if (test_and_clear_bit(IOMMU_PTE_HD_BIT,
-				       (unsigned long *)&ptep[i])) {
-			dirty = true;
-		}
-	}
-
-	return dirty;
-}
-
-static int iommu_v1_read_and_clear_dirty(struct io_pgtable_ops *ops,
-					 unsigned long iova, size_t size,
-					 unsigned long flags,
-					 struct iommu_dirty_bitmap *dirty)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long end = iova + size - 1;
-
-	do {
-		unsigned long pgsize = 0;
-		u64 *ptep, pte;
-
-		ptep = fetch_pte(pgtable, iova, &pgsize);
-		if (ptep)
-			pte = READ_ONCE(*ptep);
-		if (!ptep || !IOMMU_PTE_PRESENT(pte)) {
-			pgsize = pgsize ?: PTE_LEVEL_PAGE_SIZE(0);
-			iova += pgsize;
-			continue;
-		}
-
-		/*
-		 * Mark the whole IOVA range as dirty even if only one of
-		 * the replicated PTEs were marked dirty.
-		 */
-		if (pte_test_and_clear_dirty(ptep, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v1_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
-
-	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
-	iommu_put_pages_list(&freelist);
-}
-
-static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-
-	pgtable->root =
-		iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->root)
-		return NULL;
-	pgtable->mode = PAGE_MODE_3_LEVEL;
-
-	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v1_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v1_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v1_iova_to_phys;
-	pgtable->pgtbl.ops.read_and_clear_dirty = iommu_v1_read_and_clear_dirty;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
-	.alloc	= v1_alloc_pgtable,
-	.free	= v1_free_pgtable,
-};
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
deleted file mode 100644
index b47941353ccbb8..00000000000000
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ /dev/null
@@ -1,370 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table v2 allocator.
- *
- * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- * Author: Vasant Hegde <vasant.hegde@amd.com>
- */
-
-#define pr_fmt(fmt)	"AMD-Vi: " fmt
-#define dev_fmt(fmt)	pr_fmt(fmt)
-
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-#define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
-#define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
-#define IOMMU_PAGE_USER		BIT_ULL(2)	/* Userspace addressable */
-#define IOMMU_PAGE_PWT		BIT_ULL(3)	/* Page write through */
-#define IOMMU_PAGE_PCD		BIT_ULL(4)	/* Page cache disabled */
-#define IOMMU_PAGE_ACCESS	BIT_ULL(5)	/* Was accessed (updated by IOMMU) */
-#define IOMMU_PAGE_DIRTY	BIT_ULL(6)	/* Was written to (updated by IOMMU) */
-#define IOMMU_PAGE_PSE		BIT_ULL(7)	/* Page Size Extensions */
-#define IOMMU_PAGE_NX		BIT_ULL(63)	/* No execute */
-
-#define MAX_PTRS_PER_PAGE	512
-
-#define IOMMU_PAGE_SIZE_2M	BIT_ULL(21)
-#define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
-
-
-static inline int get_pgtable_level(void)
-{
-	return amd_iommu_gpt_level;
-}
-
-static inline bool is_large_pte(u64 pte)
-{
-	return (pte & IOMMU_PAGE_PSE);
-}
-
-static inline u64 set_pgtable_attr(u64 *page)
-{
-	u64 prot;
-
-	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS;
-
-	return (iommu_virt_to_phys(page) | prot);
-}
-
-static inline void *get_pgtable_pte(u64 pte)
-{
-	return iommu_phys_to_virt(pte & PM_ADDR_MASK);
-}
-
-static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
-{
-	u64 pte;
-
-	pte = __sme_set(paddr & PM_ADDR_MASK);
-	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
-	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
-
-	if (prot & IOMMU_PROT_IW)
-		pte |= IOMMU_PAGE_RW;
-
-	/* Large page */
-	if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
-		pte |= IOMMU_PAGE_PSE;
-
-	return pte;
-}
-
-static inline u64 get_alloc_page_size(u64 size)
-{
-	if (size >= IOMMU_PAGE_SIZE_1G)
-		return IOMMU_PAGE_SIZE_1G;
-
-	if (size >= IOMMU_PAGE_SIZE_2M)
-		return IOMMU_PAGE_SIZE_2M;
-
-	return PAGE_SIZE;
-}
-
-static inline int page_size_to_level(u64 pg_size)
-{
-	if (pg_size == IOMMU_PAGE_SIZE_1G)
-		return PAGE_MODE_3_LEVEL;
-	if (pg_size == IOMMU_PAGE_SIZE_2M)
-		return PAGE_MODE_2_LEVEL;
-
-	return PAGE_MODE_1_LEVEL;
-}
-
-static void free_pgtable(u64 *pt, int level)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < MAX_PTRS_PER_PAGE; i++) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		if (is_large_pte(pt[i]))
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = get_pgtable_pte(pt[i]);
-		if (level > 2)
-			free_pgtable(p, level - 1);
-		else
-			iommu_free_pages(p);
-	}
-
-	iommu_free_pages(pt);
-}
-
-/* Allocate page table */
-static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
-			 unsigned long pg_size, gfp_t gfp, bool *updated)
-{
-	u64 *pte, *page;
-	int level, end_level;
-
-	level = get_pgtable_level() - 1;
-	end_level = page_size_to_level(pg_size);
-	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
-	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
-
-	while (level >= end_level) {
-		u64 __pte, __npte;
-
-		__pte = *pte;
-
-		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
-			/* Unmap large pte */
-			cmpxchg64(pte, *pte, 0ULL);
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = iommu_alloc_pages_node_sz(nid, gfp, SZ_4K);
-			if (!page)
-				return NULL;
-
-			__npte = set_pgtable_attr(page);
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		level -= 1;
-		pte = get_pgtable_pte(__pte);
-		pte = &pte[PM_LEVEL_INDEX(level, iova)];
-	}
-
-	/* Tear down existing pte entries */
-	if (IOMMU_PTE_PRESENT(*pte)) {
-		u64 *__pte;
-
-		*updated = true;
-		__pte = get_pgtable_pte(*pte);
-		cmpxchg64(pte, *pte, 0ULL);
-		if (pg_size == IOMMU_PAGE_SIZE_1G)
-			free_pgtable(__pte, end_level - 1);
-		else if (pg_size == IOMMU_PAGE_SIZE_2M)
-			iommu_free_pages(__pte);
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address.
- * If there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long iova, unsigned long *page_size)
-{
-	u64 *pte;
-	int level;
-
-	level = get_pgtable_level() - 1;
-	pte = &pgtable->pgd[PM_LEVEL_INDEX(level, iova)];
-	/* Default page size is 4K */
-	*page_size = PAGE_SIZE;
-
-	while (level) {
-		/* Not present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Walk to the next level */
-		pte = get_pgtable_pte(*pte);
-		pte = &pte[PM_LEVEL_INDEX(level - 1, iova)];
-
-		/* Large page */
-		if (is_large_pte(*pte)) {
-			if (level == PAGE_MODE_3_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_1G;
-			else if (level == PAGE_MODE_2_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_2M;
-			else
-				return NULL;	/* Wrongly set PSE bit in PTE */
-
-			break;
-		}
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
-static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	u64 *pte;
-	unsigned long map_size;
-	unsigned long mapped_size = 0;
-	unsigned long o_iova = iova;
-	size_t size = pgcount << __ffs(pgsize);
-	int ret = 0;
-	bool updated = false;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize) || !pgcount)
-		return -EINVAL;
-
-	if (!(prot & IOMMU_PROT_MASK))
-		return -EINVAL;
-
-	while (mapped_size < size) {
-		map_size = get_alloc_page_size(pgsize);
-		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
-				   iova, map_size, gfp, &updated);
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		*pte = set_pte_attr(paddr, map_size, prot);
-
-		iova += map_size;
-		paddr += map_size;
-		mapped_size += map_size;
-	}
-
-out:
-	if (updated) {
-		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&pdom->lock, flags);
-		amd_iommu_domain_flush_pages(pdom, o_iova, size);
-		spin_unlock_irqrestore(&pdom->lock, flags);
-	}
-
-	if (mapped)
-		*mapped += mapped_size;
-
-	return ret;
-}
-
-static unsigned long iommu_v2_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	unsigned long unmap_size;
-	unsigned long unmapped = 0;
-	size_t size = pgcount << __ffs(pgsize);
-	u64 *pte;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
-		return 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (!pte)
-			return unmapped;
-
-		*pte = 0ULL;
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v2_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-
-	if (!pgtable || !pgtable->pgd)
-		return;
-
-	/* Free page table */
-	free_pgtable(pgtable->pgd, get_pgtable_level());
-	pgtable->pgd = NULL;
-}
-
-static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-	int ias = IOMMU_IN_ADDR_BIT_SIZE;
-
-	pgtable->pgd = iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->pgd)
-		return NULL;
-
-	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
-		ias = 57;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v2_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v2_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v2_iova_to_phys;
-
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-	cfg->ias           = ias;
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
-	.alloc	= v2_alloc_pgtable,
-	.free	= v2_free_pgtable,
-};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 8841c1487f0048..843fec8e8a511c 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -28,10 +28,6 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
-#ifdef CONFIG_AMD_IOMMU
-	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
-	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
-#endif
 };
 
 static int check_custom_allocator(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e633..75fd67cc2b7a46 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -15,8 +15,6 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S2,
 	ARM_V7S,
 	ARM_MALI_LPAE,
-	AMD_IOMMU_V1,
-	AMD_IOMMU_V2,
 	APPLE_DART,
 	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
-- 
2.43.0


