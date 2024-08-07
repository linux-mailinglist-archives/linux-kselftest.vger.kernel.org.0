Return-Path: <linux-kselftest+bounces-14944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B394B02C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37591C211C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C713D265;
	Wed,  7 Aug 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DpjPUFf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB974070;
	Wed,  7 Aug 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057244; cv=fail; b=F+P+THWdFik8tjJ+0dFX7wQT9ijpQqW018kW5pBxfxMba8HyIiRRdXqnfS/a/hgPVN+gJL4ilCTz9z0qKcs4/Z0FjGrXetUPZwKQFFlVvu0ijvhdMfpYtSnTVl9BCDZGjgAbnx8dRIgsgU3GF81xmHk6xSrF9XtiCsoe/cH0SuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057244; c=relaxed/simple;
	bh=FwBavuPsPBdW3qKl+riYfo6pFbGW3FdUgIC+8hRyiUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7I2nF/ZKoYXOJMyOblgLZ0ZSNZMZ+dU3Y4Omh0kzOr4bNk2q5L12KB8KPZpeqovNLq+Oqk91TgET2C77rbHmHiOwWBow85FJTevv8LUXwa8VD+9s8RSkM3SPZFUgDO8eLPA2p/4ZR7arWSoMXiFRBdtQLzoQu5LcP9EJ2nbaVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DpjPUFf2; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3Y37S5PHPY07vouzh+H8tNV9MBAc9kwgOHjX873moJ/cvOAbFR4ghdZrcJUeZ5qcStRVSCkml+7gEnjrv7ZbMburfWe6FbpRHvQ3mHJ3uIfwIhZh/Rv5tngfx/VYDUrmeHxzfQIJhNcp6vZH7HVOcewK7Twf7hISr18aFEHh3yErGd1MF8SSqp0Q7nL0kraIE1xB/C4MDp+4pMwWezY54hajKvE0rgdfUTaGN6CIzAt21AzbJ6CZkr81xka2xdKZZSy36UMZtANIQXfnsj9pKGe74Dj01FLKr5LjYjJJ5JH8yvTv0Rkzxc+9VtwiMxka3OMjGPdsnLG5CFVZqXejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vohyraI0rmj8dodaAZYPOr5P+P7HvhqTjFoSKh0TeTY=;
 b=r72fcFKrJDxcV+UlMToPkDcAmPHhRKoC+pD01BVAd3nfkylSDDXl+0GcSEXEnu4i8rWcjNPjRcpb3PaI96nFQJ/uuP+IE1l1C1x9dEVEnXZysYtxQFoMziw0akXvLkPANHSY/IQF/Gnur1O/uYNaXlS2iZ+P0IjD8d/VCpwnrfoT2XZiujsnlHiR/DPcoDpNEOm32UE6ZYe6sy4SbvWszy1ccCqT/bVCxjO+opggYHgQACkXji9AltH2EVP1aE4APonbzjSBm8RhyU8C8OHfYvovAcLulqkjAWkHsU7Bt3S7ipzZdauMXjFa/A6MtUPXVWijeqOgfa9ObaCNYWtVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vohyraI0rmj8dodaAZYPOr5P+P7HvhqTjFoSKh0TeTY=;
 b=DpjPUFf20pVUQo3nvBCebOAFrQBVoR6XrptQ2zdezUkxcBp56p45tcEGu/fths/9goWb7zaUQp/aR2//IZWKHAYLlPHAno0P6UV5Iqu4oqVky1Av8qssVvs/Rpexey+1fxB0OrDZuCaHR/CPKllQqvqRPHgTz/qwkRRqfDiVTGlto3FQeitW55g67YGLxA1Fee/CMF8GRdKH5u+m8JTkYi2OSiCcneJu2SW0iXB0qimaSV6vAb9eP6uuKrcOUpqRmngt01JQCQR99dOJFGGqQ2KnxVf66Q8IAq9+Qm9IGUCrKYX2snvAhiHWezK3Rs8U6xfr71lE8x8Gc9n3hLc3Yw==
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 7 Aug
 2024 19:00:37 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::2c) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 19:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:00:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 12:00:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 0/4] iommu: Support IOMMU_RESV_SW_MSI with nesting
Date: Wed, 7 Aug 2024 12:00:03 -0700
Message-ID: <cover.1723056910.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8244b3-f3cf-4073-e061-08dcb7133835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DD5aDcCCaXfsHve4R86+9O28m4Vaj0+Guwbk9BMKHKDjj28dpn+POAa7TO+2?=
 =?us-ascii?Q?1GaX0KdJTuOJJnqjEfXW+N7fxjMEXbMhldv1cRCUFQhp3senbhikVqC1+HaV?=
 =?us-ascii?Q?T6BEXK58yMVqstBf9z34DlUi533QsYAT0Y/B4RY8a5TlaOP8+Y2t1/vFhG3Q?=
 =?us-ascii?Q?XHbmO4NBSRby/jc0aZV9iQ7c6x1q700cZAFGC2wmtPEVRQwDW/lGXLN6wl8f?=
 =?us-ascii?Q?dFMlJymcFCDrylSBS+68xcudwoNNyYuFTBlgRVa/qM0GNitTsJDH3p3ZV3aR?=
 =?us-ascii?Q?1+7W+EDIFA70sWQquNB80x99LkHgxJEJMGP0xxYT5TKzsJpaHCy9MQ5HlEs4?=
 =?us-ascii?Q?85IAfcAhz9IolRw9V+ElPxqzWjHH4/3bNiapNHhUPPPMLuM4dhW+UDngGKOI?=
 =?us-ascii?Q?J2PvrHF8OOrICaOcvXzcbwO5CF1b+nRYrr/UjE1Pn9lmFWPWo0NVe6tBrytS?=
 =?us-ascii?Q?p7N/fZ20m0rQkZN0RVDwB9xtwnA9fGq7Zd1U0lB6n193xArNZsdnhiPN+YnH?=
 =?us-ascii?Q?uFVgWQt8ynEtMXHOn1lCQv3wr4KLMGWQReH6aqnHrjEvyFOIWfhnTS6Ahpzw?=
 =?us-ascii?Q?CGL4Zi5LsIJfZgtv3XbZukTgOa2ITqrVaAgXFDaPjepLDv2mrxrJz8P9vGxv?=
 =?us-ascii?Q?syO4Q8Ms26XFhWK7pItGEpQ+KQU46RCophUV95n51yXSvDEmyGRFztEXAVvG?=
 =?us-ascii?Q?0VU6ant/mMy3VWqr832gm5ENOIAqykqcd7P/nDQwon69H3Ts0y0PA0VrOMT8?=
 =?us-ascii?Q?f9p6ds6hSHMgLMOSLSEyUpEuTgnU5HB9XvJusbZ9KbcJunQIVKiJnrc0L6ao?=
 =?us-ascii?Q?oXkYUhMQ0r8yWd7qlF+63dHV9HZZjyZY0ICBfm2wx3PezLCYvwiMTwuxPf0G?=
 =?us-ascii?Q?qc6WLJmHc3W9/xyuWV8cooeHPFigisKnCJg5DdB7tOHDW7Cgnu6xoocDJstQ?=
 =?us-ascii?Q?aKj3DbrjDw02fQVIdydQXFvxgSWPd3a2v7gNed23T5A3zLgQTwX4UUIATpH3?=
 =?us-ascii?Q?H1ijhAg3zfnGHWqMAVmbcedU72enkrakLOEB9oTObGFrlzJNRFClSkb+rg5d?=
 =?us-ascii?Q?3bDYKeuzayiytJ7UZo60O5YimEZdFj8mmMWX9ozM7qBcz5BBGCf9lOmrgQQV?=
 =?us-ascii?Q?i7knMx+yyzPiLQBLu3e7gk0Z6vVCFXjghla12so7aH9nX3uBpBfgD1HfzO/E?=
 =?us-ascii?Q?2v20/u+vsfqqzhFpJ49QRKtxZEPH5tWVKAKYikylpNdTssg6LzgxfxZQE/Wz?=
 =?us-ascii?Q?mWWPvNi3cZly4JdaYTeZ9nKT6luhRm54vC2qkSjDR4Q3zn/aQ72JuqvHJS3M?=
 =?us-ascii?Q?dU1ngIVa6V4YPSFxqFzAO66P655rZzeX3+nSanXZJVb91V7bXd9Rw/GFzhcD?=
 =?us-ascii?Q?RNpOm3WZBQk6OPTi7GNsddHhNd03ymXz0rbGyjxM18ZXi5+Lf6e2U3gPovuj?=
 =?us-ascii?Q?qlJHUflUD+IKAYsemO7PkUPig8vjFlQnvr9go7fLxUcV4i5FubtFrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:00:35.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8244b3-f3cf-4073-e061-08dcb7133835
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

The dma-iommu needs to find the correct domain for MSI mapping. With an
IOMMU_DOMAIN_NESTED, the mapping resides in its parent paging domain.

Add a get_msi_mapping_domain op for drivers to return paging domains.

Add an iommufd selftest coverage for that, by doing a loopback test.

Add arm_smmu_get_msi_mapping_domain in the SMMUv3 driver so its nesting
feature could work with MSI correctly.

This is based on top of the reserved-IOVA change:
https://lore.kernel.org/all/20240802053458.2754673-1-nicolinc@nvidia.com/
And Jason's SMMUv3 nesting series:
https://lore.kernel.org/all/0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com/

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_nesting_sw_msi/

[changelog]
v3:
 * Refined PATCH-2 commit message
 * Added domain->ops check in PATCH-2
 * Added PATCH-4 to implement in SMMUv3 driver
v2:
 https://lore.kernel.org/all/cover.1722644866.git.nicolinc@nvidia.com/
 * Resent with a proper bug fix.

Thanks
Nicolin

Nicolin Chen (3):
  iommufd: Reorder include files
  iommufd/selftest: Add coverage for IOMMU_RESV_SW_MSI
  iommu/arm-smmu-v3: Implement arm_smmu_get_msi_mapping_domain

Robin Murphy (1):
  iommu/dma: Support MSIs through nested domains

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++
 drivers/iommu/dma-iommu.c                     | 18 +++-
 drivers/iommu/iommufd/device.c                |  4 +-
 drivers/iommu/iommufd/fault.c                 |  4 +-
 drivers/iommu/iommufd/io_pagetable.c          |  8 +-
 drivers/iommu/iommufd/io_pagetable.h          |  2 +-
 drivers/iommu/iommufd/ioas.c                  |  2 +-
 drivers/iommu/iommufd/iommufd_private.h       |  9 +-
 drivers/iommu/iommufd/iommufd_test.h          |  6 +-
 drivers/iommu/iommufd/iova_bitmap.c           |  2 +-
 drivers/iommu/iommufd/main.c                  |  8 +-
 drivers/iommu/iommufd/pages.c                 | 10 +-
 drivers/iommu/iommufd/selftest.c              | 92 ++++++++++++++++++-
 include/linux/iommu.h                         |  4 +
 include/linux/iommufd.h                       |  4 +-
 include/uapi/linux/iommufd.h                  |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  9 ++
 17 files changed, 160 insertions(+), 34 deletions(-)

-- 
2.43.0


