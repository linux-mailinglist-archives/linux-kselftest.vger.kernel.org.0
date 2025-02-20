Return-Path: <linux-kselftest+bounces-27026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1915A3CEBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CBA1899819
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87A130A73;
	Thu, 20 Feb 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C1Lpw3yQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730811C5D5E;
	Thu, 20 Feb 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015177; cv=fail; b=rQUbsM6dR0pqvqfBt3tXTKnzOzDsESSGfo9lxVAJXEpvsYcR3WTKHS0wmm1uUQ0tJWPP7RZit1Go+MwCM4z7MRP3S02W/S6fhph0c87ijLEV++NemrbkbnnNpbdrjhjGaW4V6WHJnrQlxiNrbYqMvIQkXW/PeYCBBFvcD/mRJFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015177; c=relaxed/simple;
	bh=AWIKk6LNcgclVY7dFmxvTmydCRbn7VufkLNGHDdj6GM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzFK5DvD4F51aoPzPOc6P2JLDf4se58rLGLwkA9cGlEoV5pu4z2D1zN0mW45zzyp9JNymdPPiDb06nZbYt6BDEwHtxxeUzeeNSzMllfIkQx9eq3N7aungYAPqewAi5ZD/5xIcnn13z3oQzVtrqgnnk59H0xqiExTaLa9VBtT9wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C1Lpw3yQ; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srbVjzBQOhISl/doZqsvb82Txbc28e5qMqV4cSYSE29+/GbMtoIVjMtrHsTg7jBuJM+EbS4Xen2hYVqMiRizPAlEK1O1p+EUkaMs6M5Wyz0DDGGCdNLnQDo35m8+aTrtYrwOiRSVXuNRztWZkqhZOrfsuM2BLQaBMg6ksxE65NI7vCLLsIWyw1eppsClB1ecraz10aJWf4j9fOOPiaJsHKt83Qq1sPKgjptijX5juyQFa+GcNGiMFzugZZyhhKEeY5n8sq7I9b26GD7kKuARkr+qhvSMTzSmyzoEGO+k50kK1US1CyhhDY9KS/BdWI1AcutyYM+02Y14B7hg70oMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQstgESk+Qf+43/GmkvZDroq54ErnuRwTUlqr9D7GW0=;
 b=W4Cx2x3BBaDU93gw4+MQzdC0D6wFkLajOLRgrEUd/PmpBbRLR81nBAKAizUxrgalSDPktYnFgAAbBzkHSesDG823+aiwf0xWqlElE62JzMoH6CbqYfqT7gwSR1m6TilJ1IDfDApFMBM/HX5QoWznW7xjL5t/ymLs1/aB9IjDcUWHBpkdvVyQH7p1g/csWOljdHLwpvxxENvW28VqG3Lw8KIpEwsIwSBT5aLV+YusB2Tcvspl+r3VXeNUrLw6OLUtsCiXk6MrkCOzcU9Wd+pDPXmna/kYnoxEklpmLDxSCACLzgspDMU8VUuOmro8A5o+6iAZZt0qSiQUTbC8WoDLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQstgESk+Qf+43/GmkvZDroq54ErnuRwTUlqr9D7GW0=;
 b=C1Lpw3yQ7NqJGpZUTlBFsAJ1Y5Q6g+ZO27Wg/QHY2V7oal9lM3wg7pl/ZdyZ27VVLvKLRBWEK4DsGQKC8c0h/KvohokMNgoATlegc/Q9EfY2+anWTrSAgF41gMZneDwseKmiPWwaQFSTzUz+CTl8PkEaxZCEcayUUVxIPs+yk9Kt+oF8eLk+NwO6EbrgpvtgZUdjp/dU+i5KzFeJIxbNBFyOonlNz5RYcSOTqoON4M05S+LgwIn3SEW9+NfU2sZqrqdLrQzUiwA7QG5ZCLIm+/t3yj333BwfvutkSOWdsgcxWHSjVAW9aeiwjDZ7lkaeuuixvW5l5VHL2Kpi4uFtOQ==
Received: from BN9P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::15)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 01:32:36 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::16) by BN9P220CA0010.outlook.office365.com
 (2603:10b6:408:13e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 01:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 0/7] iommu: Add MSI mapping support with nested SMMU (Part-1 core)
Date: Wed, 19 Feb 2025 17:31:35 -0800
Message-ID: <cover.1740014950.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9b08ce-0948-497a-518b-08dd514e74ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MO9jGkesP7vCHzfPWknVoShxYsW1y2HmOdolBZv6nl9S4EBqgUbT+jGwOOFG?=
 =?us-ascii?Q?R1D+gtZOrMm3Mh6v2TR2tHOZgahhk5MyPXxo2PV/fE5OnR59G8+3Me3CH4EB?=
 =?us-ascii?Q?Fy1rF7st9EJFGWVzL8dUa7NI+1yn/mhPHxKVnKZ5d/urHPqF14YSWhvGPwyX?=
 =?us-ascii?Q?h4jqH/7bU57QzGVf9IZtKb9MhBI+PECYwhVfwY1b7yr1DjYXu2JOK5QVRP1y?=
 =?us-ascii?Q?p4SpkGLX9cq0tbcOBkghOca2XPN1n4pM3b53VAeihvb88UTdn52y2Cfd3rwm?=
 =?us-ascii?Q?ULSVAO8wzNE1dm8awifs2RrIW9wuX0ad5iPcQmhFWHaelPyj6DaKn+ELlEdG?=
 =?us-ascii?Q?eAH+wgyx9wRGaJk0LHhcpUY/mkAR4k/fbhQNKnme7rP9VRIFltjHKdvrNWxp?=
 =?us-ascii?Q?lrbSE/aX0vEjN8se6dhrjJdELCUB1vUpXUkVWGijJ2i8D4ZIvF2d8gIDgVlO?=
 =?us-ascii?Q?SLFiuQ1ovIx3yGC8DxjeDRD6akhpizWaMRsXImC+Reb3UtQP/ctoG1iLxXaz?=
 =?us-ascii?Q?BtMSDjvrN+VKz7WdzoTQCHq1uKp05opJCQKuv0yl3qY4cpnIi6AGqOdus5Px?=
 =?us-ascii?Q?pmWYCOeizhdu3Si675LMdJqkhfSosICWvDBeoKQ9MlPzf+tB6zyTkHa9ot39?=
 =?us-ascii?Q?3HjXpqQqJbtDZF2Y49vBw3F8eDnXu3gIEaM05gtf7Y2hm47x3ZFfdUoQsgmy?=
 =?us-ascii?Q?UujVF4IhPc0iYsF8m+3aW5jYfODuChIyPx1CNQargKpWgimAkFPIAYK+lqCZ?=
 =?us-ascii?Q?QBLwuRVUZWzpeh7FsSSnuEKdVQImzHzbKMFEZGzaDY5DYCNtockKigPl9SeB?=
 =?us-ascii?Q?EHMUD8oYJmDgo0CAOX7oWJ6pWaWzJ1QbED3oLJhj4HavhvHcjw3Jal0IGf3O?=
 =?us-ascii?Q?nTI1ccHJjsuSoh41VLSPEan7tXIRz3qnNyxLe16KC9mJx0FFm+quyY4rorZm?=
 =?us-ascii?Q?ngj8hosI8IBkDg4Si5KFZ1EQZvpm5cyT1rFQaEe+/f9vYxBb/s2a6Qw0AXqB?=
 =?us-ascii?Q?XrmVvGwbROI9SodgdpxgmRw/pqR4/0piczT7wlg8ZCu1yyHB/JchJombiXre?=
 =?us-ascii?Q?TNaDHI6aBixCfZy/i79Zrnm4U/9tlU11mArarSODCWjorrLH+JrkyURBV9Jz?=
 =?us-ascii?Q?Lz9a7nPj1uq00BkpcYFdUiK5Kkz3P4CCaRm91mPdmBXNPT/t193G/OHaP/cU?=
 =?us-ascii?Q?iQOBtZkEcBBBgZ2YWVefla+rzLdPM3Rt2uPygypKBPhgN8LU8ZRvlVU/uvp7?=
 =?us-ascii?Q?J0KLu7R0TcZoJItN9Gf75j+ZbcaCaDeoYnaa32MdXhTilB45hejF6+XllW+r?=
 =?us-ascii?Q?3/miuKobWIDMJLZng+4zFaERFTkbAD3N466SKnLFe2FKusSOAYfOd1u4fjLi?=
 =?us-ascii?Q?dCr4o28sz0X9SqYatwrmCHPDqX0MLUX6VlsAXTeku/5C63HYPORz8PgMCyz6?=
 =?us-ascii?Q?EiGIZqoE8+gKF6dJT4GM7/JmBChC9N7Sc/TaMw3bBGZHZ6sxX61sH0x5txrj?=
 =?us-ascii?Q?g70w7HWozYjm5wI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:36.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9b08ce-0948-497a-518b-08dd514e74ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

[ Background ]
On ARM GIC systems and others, the target address of the MSI is translated
by the IOMMU. For GIC, the MSI address page is called "ITS" page. When the
IOMMU is disabled, the MSI address is programmed to the physical location
of the GIC ITS page (e.g. 0x20200000). When the IOMMU is enabled, the ITS
page is behind the IOMMU, so the MSI address is programmed to an allocated
IO virtual address (a.k.a IOVA), e.g. 0xFFFF0000, which must be mapped to
the physical ITS page: IOVA (0xFFFF0000) ===> PA (0x20200000).
When a 2-stage translation is enabled, IOVA will be still used to program
the MSI address, though the mappings will be in two stages:
  IOVA (0xFFFF0000) ===> IPA (e.g. 0x80900000) ===> PA (0x20200000)
(IPA stands for Intermediate Physical Address).

If the device that generates MSI is attached to an IOMMU_DOMAIN_DMA, the
IOVA is dynamically allocated from the top of the IOVA space. If attached
to an IOMMU_DOMAIN_UNMANAGED (e.g. a VFIO passthrough device), the IOVA is
fixed to an MSI window reported by the IOMMU driver via IOMMU_RESV_SW_MSI,
which is hardwired to MSI_IOVA_BASE (IOVA==0x8000000) for ARM IOMMUs.

So far, this IOMMU_RESV_SW_MSI works well as kernel is entirely in charge
of the IOMMU translation (1-stage translation), since the IOVA for the ITS
page is fixed and known by kernel. However, with virtual machine enabling
a nested IOMMU translation (2-stage), a guest kernel directly controls the
stage-1 translation with an IOMMU_DOMAIN_DMA, mapping a vITS page (at an
IPA 0x80900000) onto its own IOVA space (e.g. 0xEEEE0000). Then, the host
kernel can't know that guest-level IOVA to program the MSI address.

There have been two approaches to solve this problem:
1. Create an identity mapping in the stage-1. VMM could insert a few RMRs
   (Reserved Memory Regions) in guest's IORT. Then the guest kernel would
   fetch these RMR entries from the IORT and create an IOMMU_RESV_DIRECT
   region per iommu group for a direct mapping. Eventually, the mappings
   would look like: IOVA (0x8000000) === IPA (0x8000000) ===> 0x20200000
   This requires an IOMMUFD ioctl for kernel and VMM to agree on the IPA.
2. Forward the guest-level MSI IOVA captured by VMM to the host-level GIC
   driver, to program the correct MSI IOVA. Forward the VMM-defined vITS
   page location (IPA) to the kernel for the stage-2 mapping. Eventually:
   IOVA (0xFFFF0000) ===> IPA (0x80900000) ===> PA (0x20200000)
   This requires a VFIO ioctl (for IOVA) and an IOMMUFD ioctl (for IPA).

Worth mentioning that when Eric Auger was working on the same topic with
the VFIO iommu uAPI, he had a solution for approach (2) first, and then
switched to approach (1), suggested by Jean-Philippe for the reduction of
complexity.

Approach (1) basically feels like the existing VFIO passthrough that has
a 1-stage mapping for the unmanaged domain, yet only by shifting the MSI
mapping from stage 1 (no-viommu case) to stage 2 (has-viommu case). So,
it could reuse the existing IOMMU_RESV_SW_MSI piece, by sharing the same
idea of "VMM leaving everything to the kernel".

Approach (2) is an ideal solution, yet it requires additional effort for
kernel to be aware of the stage-1 gIOVAs and the stage-2 IPAs for vITS
page(s), which demands VMM to closely cooperate.
 * It also brings some complicated use cases to the table where the host
   or/and guest system(s) has/have multiple ITS pages.

[ Execution ]
Though these two approaches feel very different on the surface, they can
share some underlying common infrastructure. Currently, only one pair of
sw_msi functions (prepare/compose) are provided by dma-iommu for irqchip
drivers to directly use. There could be different versions of functions
from different domain owners: for existing VFIO passthrough cases and in-
kernel DMA domain cases, reuse the existing dma-iommu's version of sw_msi
functions; for nested translation use cases, there can be another version
of sw_msi functions to handle mapping and msi_msg(s) differently.

As a part-1 series, this refactors the core infrastructure:
 - Get rid of the duplication in the "compose" function
 - Introduce a function pointer for the previously "prepare" function
 - Allow different domain owners to set their own "sw_msi" implementations
 - Implement an iommufd_sw_msi function to additionally support non-nested
   use cases and also prepare for a nested translation use case using the
   approach (1)

[ Future Plan ]
Part-2 will add support of approach (1), i.e. RMR solution:
 - Add a pair of IOMMUFD options for a SW_MSI window for kernel and VMM to
   agree on (for approach 1)
Part-3 and beyond will continue the effort of supporting approach (2) i.e.
a complete vITS-to-pITS mapping:
 - Map the phsical ITS page (potentially via IOMMUFD_CMD_IOAS_MAP_MSI)
 - Convey the IOVAs per-irq (potentially via VFIO_IRQ_SET_ACTION_PREPARE)

---

This is a joint effort that includes Jason's rework in irq/iommu/iommufd
base level and my additional patches on top of that for new uAPIs.

This series is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_p1-v2

For testing with nested SMMU (approach 1):
https://github.com/nicolinc/iommufd/commits/wip/iommufd_msi_p2-v2
Pairing QEMU branch for testing (approach 1):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_msi_p2-v2-rmr

Changelog
v2
 * Split the iommufd ioctl for approach (1) out of this part-1
 * Rebase on Jason's for-next tree (6.14-rc2) for two iommufd patches
 * Update commit logs in two irqchip patches to make narrative clearer
 * Keep iommu_dma_compose_msi_msg() in PATCH-1 as a small cleaner step
 * Improve with some coding style changes: kdoc and 100-char wrapping
v1
 https://lore.kernel.org/kvm/cover.1739005085.git.nicolinc@nvidia.com/
 * Rebase on v6.14-rc1 and iommufd_attach_handle-v1 series
   https://lore.kernel.org/all/cover.1738645017.git.nicolinc@nvidia.com/
 * Correct typos
 * Replace set_bit with __set_bit
 * Use a common helper to get iommufd_handle
 * Add kdoc for iommu_msi_iova/iommu_msi_page_shift
 * Rename msi_msg_set_msi_addr() to msi_msg_set_addr()
 * Update selftest for a better coverage for the new options
 * Change IOMMU_OPTION_SW_MSI_START/SIZE to be per-idev and properly
   check against device's reserved region list
RFCv2
 https://lore.kernel.org/kvm/cover.1736550979.git.nicolinc@nvidia.com/
 * Rebase on v6.13-rc6
 * Drop all the irq/pci patches and rework the compose function instead
 * Add a new sw_msi op to iommu_domain for a per type implementation and
   let iommufd core has its own implementation to support both approaches
 * Add RMR-solution (approach 1) support since it is straightforward and
   have been used in some out-of-tree projects widely
RFCv1
 https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Jason Gunthorpe (5):
  genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of
    iommu_cookie
  genirq/msi: Refactor iommu_dma_compose_msi_msg()
  iommu: Make iommu_dma_prepare_msi() into a generic operation
  irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by irqchips that need
    it
  iommufd: Implement sw_msi support natively

Nicolin Chen (2):
  iommu: Turn fault_data to iommufd private pointer
  iommu: Turn iova_cookie to dma-iommu private pointer

 drivers/iommu/Kconfig                   |   1 -
 drivers/irqchip/Kconfig                 |   4 +
 kernel/irq/Kconfig                      |   1 +
 drivers/iommu/iommufd/iommufd_private.h |  23 +++-
 include/linux/iommu.h                   |  58 +++++----
 include/linux/msi.h                     |  55 +++++---
 drivers/iommu/dma-iommu.c               |  63 +++-------
 drivers/iommu/iommu.c                   |  29 +++++
 drivers/iommu/iommufd/device.c          | 160 ++++++++++++++++++++----
 drivers/iommu/iommufd/fault.c           |   2 +-
 drivers/iommu/iommufd/hw_pagetable.c    |   5 +-
 drivers/iommu/iommufd/main.c            |   9 ++
 drivers/irqchip/irq-gic-v2m.c           |   5 +-
 drivers/irqchip/irq-gic-v3-its.c        |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c        |  12 +-
 drivers/irqchip/irq-ls-scfg-msi.c       |   5 +-
 16 files changed, 309 insertions(+), 136 deletions(-)


base-commit: dc10ba25d43f433ad5d9e8e6be4f4d2bb3cd9ddb
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.43.0


