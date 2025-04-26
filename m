Return-Path: <linux-kselftest+bounces-31672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F54A9D7B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D799C2F06
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04901A2393;
	Sat, 26 Apr 2025 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="abooRX2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736F22F01;
	Sat, 26 Apr 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647122; cv=fail; b=vFMCIAvIktcxRNtAod0f8sG6dDaHZWPh5cKWnMQ0vVt2Lq73pvdu9+V8Z618snfwylT7824mI+PwFPn9UaExg6Pt13KHNGHBlsYuDDvIAm0+TADHSSDwYKWXOTF99xnZZc+qET+tZ8el9NHazDQhxxtWCsG1tk3PZ1HDW83TpJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647122; c=relaxed/simple;
	bh=A8Kb7Kxs/0pFnyzVrsgt0PjeGCNy5HgC2ByVBUtONf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6KPbrvNOVXEjRp+iU5y54xXepxZLCtLIH3ewagNq0p4RPgLl1uOBEN34bXYKmZDJytWktllABE5M0ZFtanmmTyJpylkmxA/S3/RnJ+2O32OsyKqcr1S9tMqU9DI+mff3iYrqlEBwDZwh8k85JArRjJ2l48/7swJqn28Wzqza4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=abooRX2O; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erVabDw9N0KGq+2kO/wJeo44Rq0UU9JqEoJhuF6QvJNNPcTUXRUodHiXJupPNSatrQ0T9j8KCCwh9c6tdpFD1I0fuymB8nZ1O0lkxXQMPTxp0r08rxEpXKXhHiiRkfxy1CW95FPdMmNixmZOvmGXWfsLNvoms6P+XhNaqXiD2GP7bjJ2buRY6z/xm8JEimlJy3IerGS3Y/bE5SFld3/dd+mPHr8zgrXDq0+nfpDekl9I6Jto8d03TCiQml3oMqDIDOBRW8Y3ZKHTVRsSuXMV625gnhUnj+VWPO+icCPJKyCzD4iwKEfgbYJe/reNujthRz3wlN6cKtsucWVg13pJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsLMjrp2bGkItm6JuyNdoid0sdAooygk2FvULxNofQ0=;
 b=sfuY27B5WbYxPuAYLszDT8nH6YDUDvCiNoagDB3NDMuT4635mTv68ruPFMqoqScHIzoUUO42GUBH4Q1ZblBm7+0q962ggrq9WmZ0EjJrbCd7afomSrDibAtwVMzK3g6KRdF0bI/BoROx1wzQ/bQI7EEAR8dc/PcEH1tICzHMj0Enq4eYJ44BpLAMzzuobm0vmizmFBkK8cw65p1007PtD/O7DFoEhzG5eavOmRUoYsg+lM6vcOfTYC1Rci+j9mwc8IWpjj/QngMcku6NAnq2RkI4040EK6lt/76iiiRHjeRgggk4/iM3J9zn+mlrhVtQc7Wo1JCOWm175G0P2ML8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsLMjrp2bGkItm6JuyNdoid0sdAooygk2FvULxNofQ0=;
 b=abooRX2OuOg8OlEMrJlxUXesPmFsOcNgswe/mxyNdz3oCepP5HPOmIvQztIc4wlwm7S+NY2gu5qEFJCvEPX/pOrsIbyjKKQiflZQnZCX7LhaknBh0zxDjaArMd3RavKNkAR3gDoDYks194KQxnMkkB7t3XJx4k/2cObj0/1IIFguVgzXlnW9QbC2N5sAe+Zhw+bIWUBFyrivK8+V9wq7JZe8CNLzTwizCBaXf64+H/qIKsDJu2i5PHZC8zlHiQPGlMwhLUXq82uB8DUUJFC3TnwSJoFeYgkgpKu0kwgiffZbUf23/aqzj6UHgzDEgcAhkg62F6LNZ3B1h3wXiH6mBg==
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sat, 26 Apr
 2025 05:58:36 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::11) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Sat,
 26 Apr 2025 05:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:58:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:58:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:58:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:58:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 00/22] iommufd: Add vIOMMU infrastructure (Part-4 vCMDQ)
Date: Fri, 25 Apr 2025 22:57:55 -0700
Message-ID: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: de405cd5-eba3-4857-c9d4-08dd8487627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k2qfCypExjI1HS/omnKRqFTKrHqlLXfsi2aw8HZ6fg4K+i3kKwTxQaT5wTg8?=
 =?us-ascii?Q?jPjHb41yQz9VSB6mfWOAb0+5o95EQaHllEq8LiT9VDVGAGGvKg5NQTO09aC8?=
 =?us-ascii?Q?JUfemC3XWcc+gR/xrviOh8uB8h8EJ5CwQtQSy1MWRarLgxQc+dvxo4cZt/I6?=
 =?us-ascii?Q?AaBom7RmNTmQteGETj3uOfEemjbMxU7xqfR2M2rDazCAQPdNopc4BfneWitj?=
 =?us-ascii?Q?V4ifsbOltLPZkUgp8pyEWvhQ8CqXtLV45y6yca/ICuIMNz89aVmzr44FucSh?=
 =?us-ascii?Q?g6pCt5ikIX2jX+iFSVfMLmx7L80C0K66GmPdegQ5eekj6Y5tGq0Rkm2Kb12S?=
 =?us-ascii?Q?YnllMfMEv1XQ0H9zicMgJD3sSSV5MhahGxdHuSAqaTfdra/XQ/fv7uEne8JS?=
 =?us-ascii?Q?nu20pQKFIq/RHpd5c3gEdMH4RwQBmt/eLIEajJGgJgsv7JwWte0dlZHgsQXr?=
 =?us-ascii?Q?rejQOxdLFNZ15SYe4PW2j9sUddTsoNXINyN9tXPOk5QDiOhKtNqfcHA7vB2S?=
 =?us-ascii?Q?5pL3yp5jc/YJTBwNOFyQXqpDcRvXCs+rSvG+DsFTjQMduMaIjUW+IZyK98IV?=
 =?us-ascii?Q?R10PJ/n4d7LMN7ehrh0UhcPHOn1XgOJVuu7SscEhsxxwtk0Bn45iqkDE+YRT?=
 =?us-ascii?Q?oq1WiLjuc2DkM/QgZ5X9dP6/tEgKGSFj0hFnWSAIrx7puBb8Ho5eS4uxvgQa?=
 =?us-ascii?Q?zU3UMk3iP6BnR23iWfztlJvNw0olvSr6h2R7SP76Hz2FO34lpAklUIgulDAq?=
 =?us-ascii?Q?l9Izr/sXT+sxHTtb1DUoauLIAvAN8sR/QvBE0YLwuJ+/rBC+YYKgBRXh0J/3?=
 =?us-ascii?Q?Mf6FxHaiW5alI4of7suyTy/hLF3XQ6mJu9Fc3GEzpyUoc3Mz8wt20IsNS7JV?=
 =?us-ascii?Q?Ck0k4eg15H+8Nl5pDRfvLMqnP/tLst8cj16qcYk/duIC4U9xoCFeLljnYJ/v?=
 =?us-ascii?Q?Z/yO8HMw4oz2jcUv3I3Mzz2nUm7EIvng4xjoNGN+ezEyZ/ga+13YXf4hMzlj?=
 =?us-ascii?Q?2tNKHGhgEfWIQtpECCwmo/TEJtoLxHSrIcBVNw6USqDVvXUje6e9xok08DmC?=
 =?us-ascii?Q?3tko0IyPxJnQEiytndIi5q6stUKHknF5kxd+HD6I4O/Rs7h1vSDDZyffUL18?=
 =?us-ascii?Q?xMRfAfGR9I5J118tMj7kmtkNlmN6bU542yUKoPE8rZCY3RS4NN7BEebRmli8?=
 =?us-ascii?Q?AKix011u+cI8e4pw5QBIMC9vGpqgekHllSk5CMCc3qibfO3scM2J1Qj1cEeF?=
 =?us-ascii?Q?OsL1B1bG3+0po+64jo80nLB27kT98GXGAgTSX9fOWJmN3LSXcRSbB3UX4Dwa?=
 =?us-ascii?Q?wRnIA11y1LZaX+z27GQIxNGTs9WNK2e+tjdxq07PvfgTaKfa0Z6b5RAp7FU7?=
 =?us-ascii?Q?9qJToe1lg1Ki+uJ6UXv/4m4G1F9Paefz6ldrh3oS3jxM4i7LgAlMVdVF0s2I?=
 =?us-ascii?Q?2hV9X6+06f9YhAGS6Qo1IURTq8Sqlp+BWxm1rvTtZCdJB9ljj/Z1ZQaEqbGy?=
 =?us-ascii?Q?z5CEneLvId2ll/L2ZK1nCXQPEb7IMmF8Gh4pB0u1fgqCrvxNRyxRsyQ5Fw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:58:36.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de405cd5-eba3-4857-c9d4-08dd8487627f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138

The vIOMMU object is designed to represent a slice of an IOMMU HW for its
virtualization features shared with or passed to user space (a VM mostly)
in a way of HW acceleration. This extended the HWPT-based design for more
advanced virtualization feature.

A vCMDQ introduced by this series as a part of the vIOMMU infrastructure
represents a HW supported queue/buffer for VM to use exclusively, e.g.
  - NVIDIA's virtual command queue
  - AMD vIOMMU's command buffer
either of which is an IOMMU HW feature to directly load and execute cache
invalidation commands issued by a guest kernel, to shoot down TLB entries
that HW cached for guest-owned stage-1 page table entries. This is a big
improvement since there is no VM Exit during an invalidation, compared to
the traditional invalidation pathway by trapping a guest-own invalidation
queue and forwarding those commands/requests to the host kernel that will
eventually fill a HW-owned queue to execute those commands.

Thus, a vCMDQ object, as an initial use case, is all about a guest-owned
HW command queue that VMM can allocate/configure depending on the request
from a guest kernel. Introduce a new IOMMUFD_OBJ_VCMDQ and its allocator
IOMMUFD_CMD_VCMDQ_ALLOC allowing VMM to forward the IOMMU-specific queue
info, such as queue base address, size, and etc.

Meanwhile, a guest-owned command queue needs the kernel (a command queue
driver) to control the queue by reading/writing its consumer and producer
indexes, which means the command queue HW allows the guest kernel to get
a direct R/W access to those registers. Introduce an mmap infrastructure
to the iommufd core so as to support pass through a piece of MMIO region
from the host physical address space to the guest physical address space.
The VMA info (vm_pgoff/size) used by an mmap must be pre-allocated during
the IOMMUFD_CMD_VCMDQ_ALLOC and given those info to the user space as an
output driver-data by the IOMMUFD_CMD_VCMDQ_ALLOC. So, this requires a
driver-specific user data support by a vIOMMU object.

As a real-world use case, this series implements a vCMDQ support to the
tegra241-cmdqv driver for the vCMDQ on NVIDIA Grace CPU. In another word,
this is also the Tegra CMDQV series Part-2 (user-space support), reworked
from Previous RFCv1:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/
This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
the standard SMMUv3 operating in the nested translation mode trapping CMDQ
for TLBI and ATC_INV commands, this gives a huge performance improvement:
70% to 90% reductions of invalidation time were measured by various DMA
unmap tests running in a guest OS.

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_vcmdq-v2

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_vcmdq-v2

Changelog
v2
 * Add Reviewed-by from Jason
 * [smmu] Fix vsmmu initial value
 * [smmu] Support impl for hw_info
 * [tegra] Rename "slot" to "vsid"
 * [tegra] Update kdocs and commit logs
 * [tegra] Map/unmap LVCMDQ dynamically
 * [tegra] Refcount the previous LVCMDQ
 * [tegra] Return -EEXIST if LVCMDQ exists
 * [tegra] Simplify VINTF cleanup routine
 * [tegra] Use vmid and s2_domain in vsmmu
 * [tegra] Rename "mmap_pgoff" to "immap_id"
 * [tegra] Add more addr and length validation
 * [iommufd] Add more narrative to mmap's kdoc
 * [iommufd] Add iommufd_struct_depend/undepend()
 * [iommufd] Rename vcmdq_free op to vcmdq_destroy
 * [iommufd] Fix bug in iommu_copy_struct_to_user()
 * [iommufd] Drop is_io from iommufd_ctx_alloc_mmap()
 * [iommufd] Test the queue memory for its contiguity
 * [iommufd] Return -ENXIO if address or length fails
 * [iommufd] Do not change @min_last in mock_viommu_alloc()
 * [iommufd] Generalize TEGRA241_VCMDQ data in core structure
 * [iommufd] Add selftest coverage for IOMMUFD_CMD_VCMDQ_ALLOC
 * [iommufd] Add iopt_pin_pages() to prevent queue memory from unmapping
v1
 https://lore.kernel.org/all/cover.1744353300.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (22):
  iommufd/viommu: Add driver-allocated vDEVICE support
  iommu: Pass in a driver-level user data structure to viommu_alloc op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommu: Add iommu_copy_struct_to_user helper
  iommufd: Add iommufd_struct_destroy to revert iommufd_viommu_alloc
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add covearge for viommu data
  iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
  iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and its related struct
  iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC ioctl
  iommufd: Add for-driver helpers iommufd_vcmdq_depend/undepend()
  iommufd/selftest: Add coverage for IOMMUFD_CMD_VCMDQ_ALLOC
  iommufd: Add mmap interface
  iommufd/selftest: Add coverage for the new mmap interface
  Documentation: userspace-api: iommufd: Update vCMDQ
  iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
  iommu/arm-smmu-v3-iommufd: Support implementation-defined hw_info
  iommu/tegra241-cmdqv: Use request_threaded_irq
  iommu/tegra241-cmdqv: Simplify deinit flow in
    tegra241_cmdqv_remove_vintf()
  iommu/tegra241-cmdqv: Do not statically map LVCMDQs
  iommu/tegra241-cmdqv: Add user-space use support
  iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 drivers/iommu/iommufd/io_pagetable.h          |   8 +
 drivers/iommu/iommufd/iommufd_private.h       |  25 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  43 +-
 include/linux/iommufd.h                       | 146 ++++++
 include/uapi/linux/iommufd.h                  | 113 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  51 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  42 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 451 +++++++++++++++++-
 drivers/iommu/iommufd/device.c                | 117 +----
 drivers/iommu/iommufd/driver.c                |  81 ++++
 drivers/iommu/iommufd/io_pagetable.c          |  95 ++++
 drivers/iommu/iommufd/main.c                  |  58 ++-
 drivers/iommu/iommufd/selftest.c              | 123 ++++-
 drivers/iommu/iommufd/viommu.c                | 111 ++++-
 tools/testing/selftests/iommu/iommufd.c       |  93 +++-
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +-
 Documentation/userspace-api/iommufd.rst       |  14 +
 19 files changed, 1436 insertions(+), 191 deletions(-)

-- 
2.43.0


