Return-Path: <linux-kselftest+bounces-35128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36801ADB865
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA5C16757D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27417289345;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfM6rCd2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2F288C8E;
	Mon, 16 Jun 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097192; cv=fail; b=TX7Ebm4bdUgTNU5fa5LN+D+/Pxit+kdUTnY0J7LVfOEHpZnl1n0IZs3mCYbU1lysPFu0H2EBEtJiigmFNWEEC1GX32C+CwqHjfFzzFmk5AqkIo3RXAw5XYE7/Oub77E3AaBvwuGc6sJWGYuM2YXXpM3D8XOEKOajes1p5YasTE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097192; c=relaxed/simple;
	bh=bJbpGax42cBq250sT2PmiSclQ1VtdoNPjQqnZcMFUwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8C4Wy8KE1QLeOYUiBk3UsHwB8Hil+bWkala7gWYfj2fYhffDTXjECdUkR0uiRG+qkBmhL+shGJV1d+uawc0/PStwXIvWAxuP5hzq430z+1FvcFsC02dvu8QvKlAJf6BXMqx6uo7IN3R8ZfgBY89bRtAV2FuDSdGT8X8HPMb4Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfM6rCd2; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaKWkABICg3goaj9GzgSA0VWQhD8Bx2P2YqXrZMDImgeAGxir3S9U0cX10T08bWtVat1BoDEZDS1ptdq2JIfE+m1J5n6H//54GIwgWQG6uGvnhGRHRV+/yzDL36iDlmqmCKYXr2Teev6IJayDv6IbENawgzFmfJs1ZK3ORFUhARUUW0FIDYGI0Rp8vOERAgWNtdRQ/4+Rnt88c0cUp2sqZlZFeDQ/vj7B2T56/bHATU0dvOjbjP3KYkTen1fK974s3C3ukGDUQjSrjafyndzJGkjhOMHgpmZWwSRc2oPgMTcrrGnodNOlzVwtcuzDVA39BW5Ek+2ZicPjit5S3B6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47FMNxPrO1KBvICCXZFtGsM/0nQ0u69j1QgilH2oirg=;
 b=Sxa/Eq62XiA5j4z7uZsgl2EoDSOZjyWHoWCshutGKAGDI2Kwqq+kQ96Hj5NHMQvxXE7/+1tZrVqMm+knN3yH2gSDLEXPmwCg3eUzlf5uPk4Y0uy2ObZVK98aJUsI34//wMyyzjioZXYtetrTd3zECJd1P0GtzWC2z64olMEbmcO9qYZbnCQQ84Wht6CXydeTe1rqraKNRKza+JIGrjzy1aBXlSqwEdDR4VpK7xFj/Nbdlip8dfOK3QT/PflF4Izu9uw34Na222atB6hmYXEjjSTAF0xSSP1k9CvrkLAPf2tyVXxOVXsqoAzKqmRZ0Q2sA9BTxfEFoULLkIABYoF4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47FMNxPrO1KBvICCXZFtGsM/0nQ0u69j1QgilH2oirg=;
 b=GfM6rCd2GnOs74YvSQZ9cS5cNu0wRHyDpv0agAQKu045B4HmWjnratYdioUxMqlkCpgVHa7AdDawCtlhicvj59we/+iInw8Rt1QzQlE6vuTjaR1EHrSqVqJ9D5xZj2t0FjofgJCxrn24DhAqde1pIehAPkmwyc0tVB/yJQa2Qxt9DsZNLis1QxKUvl94CGv2wSUZkWqm1D3TNs6GwXes9k30a+VL1Xh9JnFuTmQpPSce+qyrm5H9gW9+IICR5O1shdIsTz75nJ7hPX8d44HtA1nwnRYGUBNyR6vA6p8AGMrp5CR5esrIoNA6qexU224CkqWE7RV26v0BNDxYUF8uaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:21 +0000
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
Subject: [PATCH v3 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Mon, 16 Jun 2025 15:06:06 -0300
Message-ID: <3-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:8:54::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bbaeca-d5a3-4c9c-f187-08ddad007edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HvrCvgWtONTqrwFjv2gt3qwX8AN6DAeFUkPadcEYaoiBKJ2Qa0cf+9obodC6?=
 =?us-ascii?Q?TSzhwnLpGkTspW5k1uqv48y02gfyrsoudVrgxPzZHozvDWxRx8IUT44QYt2C?=
 =?us-ascii?Q?MGhExudtD4/+HO1n+t2bolzstV/FhZFuKsrJUv8tS7hzEELgfpw5XiHAs4LM?=
 =?us-ascii?Q?KwLrkBgUqSouWaiODuxuYygKShU8MEFSa6DK0rX/gEwF08sK8183ukZNVaHy?=
 =?us-ascii?Q?vZCeK9SxUJNxhVmSPzCKYKxFWypxMYg/zCg0IfK03zzOfirOuSYucSWUZGAM?=
 =?us-ascii?Q?5h3c1GqXubRV33Lbcn2Q1K54XE3HegWBgG/EGF3p8x6dOXweJdL1IYoq0uHH?=
 =?us-ascii?Q?zAtk2bb4ToX+ayU+sexkwhR+rZc9i2zmly1iYsW3j9MNHoMhi5AOSZjE1WeG?=
 =?us-ascii?Q?uqXWYGQACXK5BhRghcEzV7dq5fH2HqiKFe82arghyCk0vSJDWDDr72LXj5Aj?=
 =?us-ascii?Q?MQLPZuLrgvKEjHzANmgtwVTOwRM23UZnTpRxEK+Yrw7nqeota0qY7E/DgIym?=
 =?us-ascii?Q?BOp6RKA/XZ3CasVL+zKSfGvRtzOKyaDiE3R6xpA4mB6MeooA/0gWGFXb0xwn?=
 =?us-ascii?Q?h2KPVFitOr1DV6ckjPt+VsWXjeclefyyLv3qMVBbR6SlHX99BUIYHCeeA2x3?=
 =?us-ascii?Q?urt6X4kiTYwlHWJtPj+NxyRXIdF9i9p8g2Q3X5ZR+lZVO3Kmr4hiVGlh/d4C?=
 =?us-ascii?Q?rC5ORcVyFE7rE49hfJrjlTkhwfP4Tlm1+ycPfkLcaLG4SlJpgVZHgf/R2mrq?=
 =?us-ascii?Q?prN7YeK4dTyxIbVc40+N4EYwMCchSkw7gT81qgmLmDipWFwqc+MSe8urcYc6?=
 =?us-ascii?Q?vg8CciDJ+Fnm0UF07QHsL8lsx9o0INDg/ybtUSMVSXoCtzuOWo13uHP64XZ2?=
 =?us-ascii?Q?voCkMg5xjY9ojX0XEPOPyMjLr7UX3REXPAP5LckCEprKekdQ4CQ2eDhdlyDK?=
 =?us-ascii?Q?ANC0D+cFn5kbQNctducTKRBi6oQ9tk/3GlB/xwff3Ld+im7kI4/KAZIkyaER?=
 =?us-ascii?Q?klfSOBrKrz8kvbuzVQG+dWIntP6iTWSB5E/FdLHAb9FgmHMvcTA1LO1FTWxj?=
 =?us-ascii?Q?ZGvkLxKR9GjF1KN+S4jRTcX+bzZAJWgKmtLw6Xd5OPNVQGn1rXyeMG/LBaKE?=
 =?us-ascii?Q?TfSETnHLbufLXluEC9RNjh8Sq7CTNTVvbVcwd71ybskoZ5o6Lsit8fsQI9VI?=
 =?us-ascii?Q?lrJNqDluFZ25vLT/jAUhGpu7aaVfPesSdkIQsUlAI5BbxKppx7t7vdN3UADi?=
 =?us-ascii?Q?kjvzw/6/hKsK9MhHAj1pbyNXin96c8C1v/5oUdSdC1kiRC8LSPwCrljYCu3G?=
 =?us-ascii?Q?DoXL8HRNMtBgUrqphGmIdcmeXhmG1pCaFsBsfGFIGF24d2EI1ugbKl4IYKON?=
 =?us-ascii?Q?0KFePfrMyCj91jXyZZmKC/kA7nAUeDetMLOTfSgZ4F17/gi0qSJvLCcmVRNA?=
 =?us-ascii?Q?AF50U/rGiaJv0tulxkK50U9y56cGTWep?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWfGD3wwWyoA8PbxMn2r4m26P38egWElEj9jO+Xd8xT/Y4IweNvxVQK4DBet?=
 =?us-ascii?Q?99TboK9HZSaalDQCzMLxwQX40q2gBq0TyeImKT82cmPr5j5KPVpDrZS+WLuJ?=
 =?us-ascii?Q?sJoKZX+TB+l6iMftdmZlqkNLEELNKHH1kNBnRY+qCx5vrABN4tYC5iMPaXm4?=
 =?us-ascii?Q?I9IfQj8u9mtJ1/TpJNZIprCgtUR7Sux8NkZpmAkonmYXhv8ArsNEJ/3KfsAn?=
 =?us-ascii?Q?AxWGX5JyuzrpEA6TvjjDVVnlob8x1UBWnCRfZyUhOjjlTCDip10JZ02C8qpe?=
 =?us-ascii?Q?716u0Nc0LMoYJe19RNkT3+tbWlnvY1Vbmqw4W9uQ6X7hsAMhHds6sD2jQakd?=
 =?us-ascii?Q?t/f1+64l+o9s1InGwPOkGlOgEShfkkc+WRL6gg56DX0sGRK5MXQnmUmMe5r1?=
 =?us-ascii?Q?/HgbboWzeTeTAPn4Fx25lZQ2e2yzghkcCz78BizgRGC1m0RZN8cMjiMpg20Q?=
 =?us-ascii?Q?/lYEPBnGEnu+963mNWtA0Fy6/t06R9vEx3mrsleNLyMA9B6q+zmcze01ZnlA?=
 =?us-ascii?Q?0E8GGwiDOM8e0nBP/BDBz6Oj5PHZV3RAy2KTwPCfHAPV9EoPnigh0Of90U+M?=
 =?us-ascii?Q?H1uuKHUnlSdJpIZYLiFMxtX9UWf7OFrzs+y4es00o6YRuyVyoO9l1ZaalWTU?=
 =?us-ascii?Q?ImagZQFtU5a4APSrrSMqFYo9AnEy1fisLuPp4MVrjHL0YhU/0C5UejVOHxIM?=
 =?us-ascii?Q?amYNQWH5HR1xlqV1oJYYldOos4wl6G+C6qB8z9hwJ9Onxg16Rp2JfaGVQgmx?=
 =?us-ascii?Q?hJXvYCK9V6EIbeVFNqAqHN3O3P3g+OHX+9JVZkbo3aEqIMxmTCwlOb1zKGZO?=
 =?us-ascii?Q?0BrWvNlxAF7xq1wZQfIxW3JeN5MakgUQtRw0OXDYL0AwFP/1SYknk3mLhMKi?=
 =?us-ascii?Q?R5m64P2y81+C9FSl3dXaRi5QVEgM+bZLMI6uSC8P+jhFp+PB0qYXQ9oDi/TZ?=
 =?us-ascii?Q?W1r79gLS1YOXhJUSd6G7ZcBgjv1N7jnRrk9b5H0BS+89zzh/4/q17RaO8Yav?=
 =?us-ascii?Q?U1eWlsL7G5ReUpCqmvdXgXZMzmwMAWBeVT0UyJmdPLdZNRwQrRQFTfCptxNN?=
 =?us-ascii?Q?fQwEmWSoB/jbERb0rBFzBEcP/ZABu2G3E+Ike88+7QodWMKOlDe8Fm3AkJhY?=
 =?us-ascii?Q?nmcF4nU56kn9Xivj7FzfSaayZd+H2UZFBRkMlnz/gjhOPrkmk3GunJVKWlLX?=
 =?us-ascii?Q?iipqn8BjdkVA2OFXCwiaWVdvvRIXf4Ftq/RQAXnm9Y5OUS7+Gm1jnTN9fTX7?=
 =?us-ascii?Q?mucwEOPSX39O/apqkZXQ19MRUTZ68dSc80GR8w9c/bOyQXYJ5KtxoHpxoCcp?=
 =?us-ascii?Q?2fSrk0QhKUFHQqJhyxOgNC4FUGmRvgbgdsZCW5GaIW7GFq9B5trFYHY5xwAM?=
 =?us-ascii?Q?4QRvyd/oCFnG30VuMn3Saf2IweilgQieYA2SN2hieW4VZNCtXXK6enA4Y6ps?=
 =?us-ascii?Q?kvM1B0eEP9eNj6GUdbXwhMutqRUhu90unR6STCcYQcNISNF0pgVpKktflsxq?=
 =?us-ascii?Q?Jl9moq18frE724PJPQXDFq4w25sB4uPldlVYJIy77oegEJM7xhc4eppucS1Q?=
 =?us-ascii?Q?xAGt2fekaqggivt/Uu+VoJ+Ole7x6ikGIRtRlViA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bbaeca-d5a3-4c9c-f187-08ddad007edd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:20.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMCGK7RKHw0A3CvpzEegyQ98PaZfToxcQey4tN2wrtxZ/Vz6xWrN6WGgW19ywjx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common {
	      } common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with it's own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  13 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 268 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 118 ++++++++
 4 files changed, 438 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 775a3afb563f72..73b7a54375f9bd 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -19,4 +19,17 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	default n
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related struct iommu_domain using GENERIC_PT to abstract the page
+	  table format.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..205c232bda68b5
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,268 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+#include <linux/export.h>
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+	u8 ignore_mapped : 1;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (collect->ignore_mapped && !pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && !collect->ignore_mapped)
+			return -EADDRINUSE;
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+		.ignore_mapped = true,
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_output_address_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_output_address_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/*
+	 * A 64 bit high address space table on a 32 bit system cannot work.
+	 */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va ||
+	    range.va > ULONG_MAX)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end is a last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+#ifdef PT_FIXED_TOP_LEVEL
+	pt_top_set_level(common, PT_FIXED_TOP_LEVEL);
+#endif
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_output_address_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..9d2152bc64c0d6
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The iommu implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for iommu page tables
+ *
+ * The format specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain - The core iommu domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops - Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid - Node ID to use for table memory allocations. The iommu driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the iommu page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap - A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * get_info() - Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * deinit() - Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NUL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features - Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2 - Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2 - Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+#endif
-- 
2.43.0


