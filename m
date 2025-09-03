Return-Path: <linux-kselftest+bounces-40695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A902B42830
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18803581EE6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA8324B36;
	Wed,  3 Sep 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zml03VAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10774324B15;
	Wed,  3 Sep 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921617; cv=fail; b=Kllmb9bZnWKfNufN5sjtVLvzxas2c8kpmumLRZMy4dwzygNq3EGWgsDAEnPGXyyq+XLZLJGqjFE76Bxl4b5iojUu4krh80M4ZNMI/IAlZ1wfII87LU4uZaUTcNw/QYGI2Uj9FrimBEfpYqHtjQNjOSzLaow7JNF+WUUGpwLVMOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921617; c=relaxed/simple;
	bh=vDZ6UCUKHk94Zr6j6gHUxnmDaTg5Anrx81YV35lC3pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbJdOeQ31LQik7ARCrYsUyAK5phFyS3THe/+t1ReKuSYS3otzBlMQWeQ94sL6cw+/xB9z2J+8qwanm3oDpgZO+CCLXPeST+rUtpbFne6xFX1QX0x7JMrq4uRPkVP/WNk7IYHP3WsojHnIANaxiLksP0hQW2KhbKH179vTvobI6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zml03VAR; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjnpQbEVGh1UZay6WngNnzrpPXxNcH9SEpNbqov0Zuz08k3Vl4vJtY2aYqIuMlDxuU5DS5e99IVQrrGbebY0l+Paofr4xU04aUITs8mGYcwGTUPKoEYryo+QynWKPSfW7aZs3UOIFgQITEk938A0ZHkjSE6/XX2GV7Pr94m8oUsV+3SBAtFXOY+iuc4bRR1/htM3/vN9gMTfJfOlW5s1pdlM8X5hFhUGI7nm0hwgnHQHhL0QYAPWcSnPVPKxV8MpM3PCHguF1AkD4FA9zXNCU1h6uBa0vqrdVFfI+Yv3VZ04PR+HnL6Q1K786Mux3/qfkhGmKwCWB0+woOKDUKyf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhDKbh+uiXMoMvBvF3er45Rs8ROgnoc+TPCqt+jxFRU=;
 b=aXL7BlL/McKVmNaNwuXZe56GX/DwOwCy7RnH1Ua1fnhQ8ZUldDtMB7T8WtIL1ujoJfYmHIhtZs+0DxNOIWrDNunxxdOrF99WQeywenwr9GTFjO3P5p/cmmDg5M2CSV3Glktkl/VmV6hrYqNZq7Qa/jQhIiNPsROjh1qlErlF1clGcI93uxbZzzxiFy2FGNGjEoeSa7hNQJps9v6/GgAmDId983R6EE8YAkSrPUmC5Xyl7PXIPkt+0WklUm6Va3Re7CFGpHLNsHNLDexuTxnyv34ZXQyhBnWuma9KevsHr+xT12nC+eDi9mDvAdS7BJiYyA4GFqS56BmCOWklReWGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhDKbh+uiXMoMvBvF3er45Rs8ROgnoc+TPCqt+jxFRU=;
 b=Zml03VARlu2J0s63LUmqpPTTy6zkoidAbe6F5FKorHFpjH+P7JJpvpcZzWaPJkdnuROZFIRISSsjF7aQteMG0F3itwsWbs0+WcYghWMg+LqU6mSPMp4cT1s4MQYF9X9f7NBM3k3nkti64WB7IksbS3cONpdPe0xQFu/3uTmM+SzKeL4d/ninpHnGN3ZhjRwyjV6nmZ9pezHutfyfUcC9C3FXUMWmdSyGfzTuVeqBszF/Pabt91h3N1oIJb9ZgNz2cY3h7xFJdlCAmHJZcYzKAyGVpm1QIV8zup4uoqKSUcyXuZzqJXTten3RLoy26xgeB+XTDlfbOjABzD5Pqb4SUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:49 +0000
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
Subject: [PATCH v5 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Wed,  3 Sep 2025 14:46:37 -0300
Message-ID: <10-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0370.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::27) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2dec76-0936-4027-0ef3-08ddeb11d902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUlGTJLxcMbZZbdcbGKMnBczE10XonfqqBKaIjAouFLoULctNe1XKBhi2nJN?=
 =?us-ascii?Q?m1KUhxyWf8TOW9VT4UKolHt5wJIeSXM8s2HfQapXvEZ62bNS0THZlsQBAsIR?=
 =?us-ascii?Q?2szgCq2jk4PZ2YDH+19v3y4iUvnnRB19WdTqqoja7N0nfbNL1DpDw8nlw14Y?=
 =?us-ascii?Q?uuWOiZqrFxrp8NaGF1sgtEUKD+xZAU8hYWaW4wvJeF2QQVjEt2YmElEAqyeA?=
 =?us-ascii?Q?VVPIvcOtC1Mp4vv70pECVYT/3Fvb0Un60xzoZIvEda2sBTi0Ef/LdHi63iV5?=
 =?us-ascii?Q?zLa7bQJOs6vyRMaU0V9WineHQc9HtW6MiXiZm4M9iNQG9B45kAx9dZ9hc587?=
 =?us-ascii?Q?HeuKPdfZBuA5bCM5ZUPrmqpX3qJmzma3V3sIxg8zALitQSrGIbT6IgbT7XA/?=
 =?us-ascii?Q?0ot1Mjv9MfyzB76eZtU+nv1d6jAX3kW/tY7IHOAG1Mmb5jQl8Bo1ryiisjcU?=
 =?us-ascii?Q?dScN3YHeMjsy4jeZaFaY34Lm8YOK3i7QskJ7nYN3YAsqRFJdplxSeWkpbw7l?=
 =?us-ascii?Q?2RET3R3N7AePTrLE8ekk9Nhe1tSzS3y08Hb/xwzbYpccFoi2w+GgcTDY1iX6?=
 =?us-ascii?Q?vjXsHpR+esPfUeeNfXAVaLL4dROuFxsp71lXgZH6ULloOiH7p/q+dUsolJl0?=
 =?us-ascii?Q?4u+xabb6ezsJdpuhtL+/hq9dleYcDjrAqKSl4Y6/p0kjhYqWVuRUwsKdmay0?=
 =?us-ascii?Q?e3bbaUvLcC5ndUu5fqSlhe0GT5eFRLkkciF3elaB2BugjL4QJt6jEedoo95u?=
 =?us-ascii?Q?MnBv+5y797eVlEGwb+uVhdwNGA3JxYRJozcdsOb463irsUpYmyXJ3/3wFQOP?=
 =?us-ascii?Q?Igcm4qGWqJq9g86zIIcGgsH/WcJ8TnK+LcpovxSelQBcODnA1Yxy3ghmpxy8?=
 =?us-ascii?Q?V8jjANKIyOuIJWWhVl+FleZHG9XHdJa/ujsqYtwlARjlsWsQR8zs+WiWcivC?=
 =?us-ascii?Q?5c1AAMoP7FDHhTKSoUZJyZ15OCCD/yKWuoiritTi/GMaIRJlzfX6ZTQfDZXQ?=
 =?us-ascii?Q?0SeiURywtyNt5gct0JRFtrNlG4qW+hOYF0nqH2mOQ2YAGmhonfuemwLbFCVr?=
 =?us-ascii?Q?JE5QXFa817CiBpnptMJEc7n1l21nXmxict/fTKtyUG02tv6ELhvdgwgDYn+f?=
 =?us-ascii?Q?G7yZAgg7D+GFoI1BdcopdIHGTnIX0xopK+cY/toWxdD6HFnjh4X7m3HodGA1?=
 =?us-ascii?Q?9DdYnfaSOsf9OfnHo4wVQMcnuUcrLOh52LtU2ZV76CHV+ZcV4dITAwXUIrPf?=
 =?us-ascii?Q?Pp3srJf5cFVysnfsz4H/rrs9TERziCE6rcEgk/mMzLmbpNpTHs6DeWI+hUQG?=
 =?us-ascii?Q?32rzqqXv2ed16C2gNWfbgFjlTXTcz7d0Fa6R5UMjNjgfaObt0R0k+UjmOlNt?=
 =?us-ascii?Q?FCZNMbIE/Y5bVrLsvYIb9G8OUvZmv1RjhkSaZVqr99kYs/u4d7Y/sDOefuuR?=
 =?us-ascii?Q?/e0vnJM2uQISEKZHZxipjYfa1ieJlC+vK7nzxVp1osqOSCeqoTJcnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pK2FvHnG3pzwhbd7Xz61UMjlbhnWYEEBT06xGUz8VsHJXiSgkYrqZ2wZhTly?=
 =?us-ascii?Q?bG38KV/3ISuFlnjv2ctAPARMlAVfqIR4LbojtVuqe14VVS2eelCt0e4ft+PN?=
 =?us-ascii?Q?CObXLeJT4RfM20adWbxkdMtZo49zWjf2NO18TuLuBgK/C8846PIZx70/ducR?=
 =?us-ascii?Q?XUl6WoWqzeJV3RIireVxCLvLkRJ5yoDxqLAd11gWVpV8txvJrCBhtgic2yvp?=
 =?us-ascii?Q?40L3qmrtqqyYoR9ymA2MgnEJ1YpqmUcuYYHoSrtIp+bs3qprG314L9P8otvJ?=
 =?us-ascii?Q?v+ZKoQkdVlD1Qer0MMLDPzA0HtQ8ifRHo4qRmQrfpZh8JMkwXZbf8sZo/1/a?=
 =?us-ascii?Q?yWEYZXM7rCRCwZc19oZAFTp+hsDq8FwLwztjXWTXeQYFCcIkmeV1i/bqM19A?=
 =?us-ascii?Q?HhWVCgQeznRokBTi89UOidf7jiLl5aqVqKFReUTMQqZ/zn4MZDFL+2DSKbVo?=
 =?us-ascii?Q?h2z2VQb0d1GXHxmpTXhNBomcbeykJ/dD7GOdMzOdJBNCX/g1UOGZ6RuOaFWO?=
 =?us-ascii?Q?dYcskAXP5z6C8RPSoE7tf205sduchNAYcOnPzvAvxsMgvJDKxffECGzeiUjK?=
 =?us-ascii?Q?+CSb83H8sZ9Mh5wTAyZ8iBf8psrTRBKUsxUPF2bRdE+mx9+DMnZR+KlN0j/W?=
 =?us-ascii?Q?ptnAAZVHgKjtFsdIXlyO6boG3yuQSRfWioZR6YWwYOsHudptg6BsEka8CXBz?=
 =?us-ascii?Q?qEDIxit0wOZNxs4+aGhJVW7rG+GfnfP6YC+7Rc+p18Tv6pydT2es7AQ1n3NS?=
 =?us-ascii?Q?hbVK5fdgOI0ZUff8Wh/5rOA9RbHHFgxMV7M++AfYGVBdBhqCePkBUqkLmaOo?=
 =?us-ascii?Q?L1Q1BLQFclfJO3NrFage3kuZ9QLvCyhTu90Kk2lckfI0p6e7dnvnav7toMx7?=
 =?us-ascii?Q?ad11e3Fau8Dpti/3XQVMdNrSv5UcZDHw6TGTQDmyovvJe8qmwQbafVscy9Y8?=
 =?us-ascii?Q?0LKexW+HPx1YrIFHdzy2l5O4KAotVjL8tT3lVqXx8r8soRKntdedUahimb5e?=
 =?us-ascii?Q?G1PS3rVMTBfk81ROzhag+tCfoJLxXezOZacd32sFl4TUrMrWtsuN8uwYNY7E?=
 =?us-ascii?Q?ecT3jvuwUeKQhfJj9wIi8r1oHUupQ47JYyEEKhaXL6uUFTR9c8vkdZ42n+nv?=
 =?us-ascii?Q?2TrBkrHgYsvuyERXOCNW8BmfseJ7kOkLr+rjLPQSbEPFb9NUHEvj/XHe8QWP?=
 =?us-ascii?Q?lye5Nvp5UFcqn487q2mL8GGxKRQv98qpHki1xB58cPjVZl6czi+8Lx1rxb37?=
 =?us-ascii?Q?zG2zQNBQP9Q39Tpi8IGh8EXF0bnMjNrnWV7MAD2fopYUYKgLYqbT3Js5WWkW?=
 =?us-ascii?Q?swxjN7+Z1Z11yMZqvKYbrmfz0XMF2Q25cansGrp0Y1klrgueImrBHG6urmLn?=
 =?us-ascii?Q?HURHFY9WZGkz+EDy2Lf3dmw9CfUBJl423lXR7WxQCNHf6KtIObpXmCp0EA0h?=
 =?us-ascii?Q?Qy2XmamTtoLk0EmSwQMItpc+le+83pspMhxkgCvuXaX2EmvDaT72Ow+lOdrD?=
 =?us-ascii?Q?Bxfue3hSS4hhlPNtnn+B726ikl4mtUPUK3c6M5LHtrY7hF+aGAgPCl0RuyXs?=
 =?us-ascii?Q?NoS25jDyWCsIaQX4LXs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2dec76-0936-4027-0ef3-08ddeb11d902
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oN+Q9r+bJafUDJbqJaDZLxQK+HPrS4XvveDtVHAU+uURReNzhb8ee65REC+sP7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index cd72688322c6bd..c7442d85a919fa 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -372,6 +384,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -382,6 +395,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 21dbe0bf3880b3..dc06b2c720b0a4 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -236,6 +236,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


