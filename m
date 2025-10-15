Return-Path: <linux-kselftest+bounces-43145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77454BDBE9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FA944E122D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E81D5178;
	Wed, 15 Oct 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvYC4VHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D313AD3F;
	Wed, 15 Oct 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488280; cv=fail; b=XUt8xntg3bsHSO2T4ZWQn5lQyuxvveMIOOlTUzN4aKw/4JnMecp4cPaaPPTp9RjYqQEjFgUMbrNW9NzexSa34DIIJ+cQmpaq0KDlupzuisp8WxZYyF6idmEF0+S6esBjBwZAyLVHOBx+jAr+2UOVgS0sNcFPsY08cBZZilJUVFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488280; c=relaxed/simple;
	bh=j5Xt1NMOux44xKOVE4Zc+XShbUMZXLEQHCrlebijPBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AYpd6HRluixGzV8NLBBdL5ELBhCLkZCKZ2pMLEAq/0OqgMoRdQa+eqUH/rP7mr/5LMUfnImEQRWRidXLg3FA31yaYH0sjvkQRQDDybdrTCq/MiJvDAfOYdVoFoCqNdjxB5p1BSDDTHp6uGhnU/2VwvIhuG7ltC+N0kALaVQ/Ihw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvYC4VHS; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPWofTQdXbltXZsblwPxqq5CXnEnMzcc0kCaE+6yck7GzO/xU6rC/sd8CTjSzlUG7r/uV7csrqX38ijo0Hks2z5NDveQnnx5HMUKrA+TIAUxP7hHHlHnaRhfRIHRWdJDeTir8FGXcsTu7HOhId023BvGslilu1qeCbU1mY0E+76V9jkXMnv9NjSIajg8YKOMdLky41rc1jjx/iJG7NNdMXBCOlHPW+fei3kJxUu5WzUg0YV/Nh0hihFeCk5f+H8okxUXhcoI6qk7a6TSWFkcj4o2DeLG72Xr2rUzM/IJPhUesNcY4fA1Ywc0q2ngpIwt+LZvxZ2EsJA25ExdGUwZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzpnPt3AMh38rZpw4mTldTry7eVO92T4/2oLuCuHj6k=;
 b=iEAQ6BRLrBwBExrd9kI1P0ZaGE6HWlmHWRbxj/XWOYLiOsM6x4eExWPsgeLG/ACLumKBIYFIoKl5DPR46WaQ6PmeUQd6F0o3wL3WrvMooA7KD5jUzUPZDVAvx6Jjlt5L3aVRngYWpVMvFlaAmK1B5YNBIoIpT+dA7vrN73zFeP1W4aUcAyWctXozuOSqasgspWQAeyDaLlsqWtCd9rYcuw34ZrAs8ZTU9F5vH9bvo7eh5Dy9MGpn/KrF0TbAZwAhMyFJaSc77y5p3TuKTZlIMMPnZA5AQCS1c+XvHYKRL4cT+qvidvAFP3Lspi6YJ0HDZpAmLd4sTaDGUFDVf3agaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzpnPt3AMh38rZpw4mTldTry7eVO92T4/2oLuCuHj6k=;
 b=bvYC4VHSYo55e3Cwo06lJjctyb4cvXsP+Vad9xshZ0AiWrbVl/FZOzTKJKifx/5Y4+S5Kt5x/kXTMFRF6/l5nqW2PfdKKSywuDM0SzidCJplRCq1UmW2RZ9/7D5o/VsDw/ufQSzrXrmJs77a0jVUkCvTudivW0t5eKIG/TsxJsbkJjH0K1SwSRf2TogW2Cjy98BQeulMQsDIYQL0ey8MxCQc7wlwbH0vT1aDJvQ2MQwI5/rjaquCDtQFOegdygn289AM3RdK+TMVTdWaRGMEmq9M2CThA92w/++Vk3KKJyaC2moneLUHiO69p3ILGA8dwH0QuuYdefTdDJGKbGUpLQ==
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 00:31:15 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b2) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 00:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 00:31:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 17:31:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 0/7] iommufd: Add MSI mapping support with nested SMMU (Part-2 RMR)
Date: Tue, 14 Oct 2025 17:29:32 -0700
Message-ID: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 19617709-f1b3-4a72-7724-08de0b822654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCFb32GZJh8AmwIxmRvHxs/YuygWUMrTL+NMSrwGJ8CXDsMqq6iIUcZmFXkN?=
 =?us-ascii?Q?/fF/H7KVQendtAAHTSTBacTTJYgR2QJsG59kGoD/mN9Gpdhb9bO97rpN2RUH?=
 =?us-ascii?Q?q2SiVwiOBb9Ru6Z8y5p5eO7735M/dVxo/smARnAM9B5MP8hnPxVtoDxPl8Gj?=
 =?us-ascii?Q?fK1KC5Ws3z5/Gji/0O6+3u8YdAy/w8jnSmzbwKL+SLg34dIdsKnOVzYo8o8P?=
 =?us-ascii?Q?eHhIlETJLTf4PRZcMH/5XFWasvam1tsxTp2Yrcx6cDbRY7hEjaQrKSb+GrGP?=
 =?us-ascii?Q?9RbcmPcD1GS1l7ci0OGTjVLpPNblSPPQTCigNR3LGY99RiKkMucKxa2QyhBx?=
 =?us-ascii?Q?d1RdVQfFzHPlTw0wUAH+xvKZy/gEhJh2HaUqnDP3jNkWCVSZhWefHjOz1apN?=
 =?us-ascii?Q?4TlX9JOGDiW7uKg+JKpPWojsteXA3C4xOB9ElIRWxbhIV7NnGDfGrxm/183/?=
 =?us-ascii?Q?tr8+WykS+ZpGo+7Do2XGVspMa+25rORO+OxT0tWS4c/gibjqAgAETSyfosRm?=
 =?us-ascii?Q?2V9k4idJIe8yA6ptp7thunkGGc3/+Mn7WfDjm+lLLRtaLX0Qo5HXrsvar/at?=
 =?us-ascii?Q?qXxu1ZJIcUljBHDpAgYRrPqUVJXuerhKHAEnASOoMo9T8h9msufmrcNehdzA?=
 =?us-ascii?Q?kTHoV6HDpqWxjHiRRsZj+4EOFcsjRnDniTdmQ8+uhPRhsAHT6WKUf9g8XUNC?=
 =?us-ascii?Q?efmrEQF3lIbv2C0WggL6e8nr4l+KM6LSHQl42GXbIb2WHZDFVNtMbYGi7NGy?=
 =?us-ascii?Q?cwbWZZn4YzIs3fe2bsOhJrEYqBU4WQwbeSPlBaoSySTyODy7C38UV2crmfvT?=
 =?us-ascii?Q?/Bb3u49ffMqxNq2Pb6ih8/1Rc2K3FIwJevcFQ4/N0ItJ5GiJlfzGPTVBOeNF?=
 =?us-ascii?Q?yObKE3khJ1/qORJaK2VA6IFVJA/Y7SG6V+RJpFcxRtnxlTQ2Cf5DDgT+S7hG?=
 =?us-ascii?Q?MiWOIMs6fbuNxBajEumFESavVNYRvBi8kydY47kvmKx32VV/mQ0xCeMwhqTg?=
 =?us-ascii?Q?Yt89I6+OJ4Hn9CZl8cbxfahIRFS8u6x8mnRF+GHHhgaClLgdeLswZPjZ4fmg?=
 =?us-ascii?Q?xlIKP/nXuKl1UfLCOzcDM7Iz+9GvoH3ZeVvk6Eixa/4Pap/vL1YjyfBVUm/s?=
 =?us-ascii?Q?lqeAf5BQzONDmPDj/p30hneh1bcAJPgpRnRFN6O6DlDxZLDVNvsHI2z9e726?=
 =?us-ascii?Q?Fkuo9p5hd/VuJWxW59wQ3NHsiWEc5GXXVnOO2eyKPlKFUrBOLb5np2jd1Ywo?=
 =?us-ascii?Q?l0sT1np3oDtlUxdCzPhfK8sg6lTHTCh3NizLiSTkAam7ppVBy91R9Pa74ToJ?=
 =?us-ascii?Q?cOTLFp0o9Tc8lsyiyVqRziYHZRffDZviN6r0Rcpqt+v42BPnsnfanstzwGfQ?=
 =?us-ascii?Q?+cKkLS3lr4x+ZP2PEdyKWbqrqm8d5uG76q+2kp0jl8Ez5ljJFSV33fa8n1gt?=
 =?us-ascii?Q?vv39cFxC0l/Aa8twb/58LDOA7rD08HY/WnedZ3+ipw3wbeL9pcbKNkKiM9sr?=
 =?us-ascii?Q?bWBAexWvhOiglwPv2YUAMxYFoW0EUT+9rtSpSJllqLHgCnk8UZvW+mcoTe0V?=
 =?us-ascii?Q?MYq40i9Uwqb03QxH15JmxZnZQVENWdBYUIXWGq2Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:14.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19617709-f1b3-4a72-7724-08de0b822654
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

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
the VFIO iommu uAPI, he had the approach (2) first, and then switched to
the approach (1), suggested by Jean-Philippe for reduction of complexity.

The approach (1) basically feels like the existing VFIO passthrough that
has a 1-stage mapping for the unmanaged domain, yet only by shifting the
MSI mapping from stage 1 (guest-has-no-iommu case) to stage 2 (guest-has-
iommu case). So, it could reuse the existing IOMMU_RESV_SW_MSI piece, by
sharing the same idea of "VMM leaving everything to the kernel".

The approach (2) is an ideal solution, yet it requires additional effort
for kernel to be aware of the 1-stage gIOVA(s) and 2-stage IPAs for vITS
page(s), which demands VMM to closely cooperate.
 * It also brings some complicated use cases to the table where the host
   or/and guest system(s) has/have multiple ITS pages.

[ Execution ]
The iommu core rework (part-1) for iommufd_sw_msi is merged. So, now the
IOMMU_RESV_SW_MSI can be used as an ABI. VMM can take this hard coded MSI
window and create a direct stage-1 mapping using RMR in the guest's IORT.
However, a proper uAPI must be defined for kernel and VMM to agree on wrt
this virtual MSI window.

Moreover, some use cases might want to map the IOVAs in IOMMU_RESV_SW_MSI
for something else. This requires kernel to provide an interface to shift
the software MSI window to a different region:
https://lore.kernel.org/all/20250909154600.910110-1-shyamsaini@linux.microsoft.com/

This series, as a follow-up series, introduces a pair of iommufd options
for user space to configure the software MSI window.

[ Future Plan ]
Part-3 and beyond will continue the effort of supporting the approach (2)
for a complete vITS-to-pITS mapping:
 1) Map the phsical ITS page (potentially via IOMMUFD_CMD_IOAS_MAP_MSI)
 2) Convey the IOVAs per-irq (potentially via VFIO_IRQ_SET_ACTION_PREPARE)
    Note that the set_option uAPI in this series might not fit since this
    requires it is an array of MSI IOVAs.)

This series is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_p2-v2
Pairing QEMU branch for testing (approach 1):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_msi_p2-v2-rmr

Changelog
v2
 * Rebase on v6.18-rc1
 * Update commit logs and kdocs
 * Add a patch fixing iommufd_device_is_attached()
 * Add sanity check for overflow and cover it in the selftest
v1 (containing part-1 that is now merged)
 https://lore.kernel.org/all/cover.1739005085.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Nicolin Chen (7):
  iommufd/device: Move sw_msi_start from igroup to idev
  iommufd: Pass in idev to iopt_table_enforce_dev_resv_regions
  iommufd/device: Make iommufd_device_is_attached non-static
  iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
  iommufd/selftest: Add MOCK_FLAGS_DEVICE_NO_ATTACH
  iommufd/selftest: Add a testing reserved region
  iommufd/selftest: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE

 drivers/iommu/iommufd/iommufd_private.h       |   7 +-
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 include/uapi/linux/iommufd.h                  |  21 +++-
 drivers/iommu/iommufd/device.c                |  43 +++----
 drivers/iommu/iommufd/driver.c                |   4 +-
 drivers/iommu/iommufd/io_pagetable.c          |  18 ++-
 drivers/iommu/iommufd/ioas.c                  | 113 ++++++++++++++++++
 drivers/iommu/iommufd/main.c                  |   4 +
 drivers/iommu/iommufd/selftest.c              |  35 +++++-
 tools/testing/selftests/iommu/iommufd.c       | 105 ++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  21 ++++
 11 files changed, 339 insertions(+), 36 deletions(-)

-- 
2.43.0


