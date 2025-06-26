Return-Path: <linux-kselftest+bounces-35888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FBAEA68B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AB8169C68
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72B2F0C59;
	Thu, 26 Jun 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVo107ER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60E2F0055;
	Thu, 26 Jun 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966527; cv=fail; b=IhS+vx5aZBtMSNyWtVoqYn4XnTu+3+dfMYBVxVozbB6wjpuwXUNmCOO2YlFTBApbWus05zSekJetW6MmrcsUWk6ISUEFrzroT+kf0kuUTixrg/lqTsy3aIuqoU0k/f7g23WarfgSZEeJM21Ge/issEt/fZ/FEhf4wNfwRnEgzRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966527; c=relaxed/simple;
	bh=k/AKgbClh4PCM5p43AiGzlUzrQBxe2j8T6EYuS3GZzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6bs9OSMdxqaY/NVEBx+CfE5jzzLQOO7Ooz3ePG6CYEIpzZw6brceIp+7jUIBc5KG6QEvltrL56gGQJguymEFD+ij4CJ8tozV+0zum+M0EFcfsGsgOS8nuL+ceQypvAcasQkZx1DFexqTpvuatGZgdHXM2Cg0K/hjMyOT6TAlNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVo107ER; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwLzCLAvjJ85Ghmha0CcZFMeX/57z0yJFJ0EPNhfuQJSJ+EoFV+noAS1INvvBuQJfmGBu4TVavNmrNs+xOKJlUTpZ9Y3AQxjR70x/3Cl3QL7Svxgjc+vNtPv3pII8R34RRhxY6yOxDwtvWxkEMB20f3ujz+8yrgdKz4097AMUB0NoWX0iLddNiA9kB+KaHGyNbF6jNZwLnqU8Mps/JpQbcGgPVreGRyZvaJ7pdxolypuNGboNO34lHoB+sm/yYcnujYAXZHKp3gYa0K8gBq9J9LQIEmTSRAOHM2sT2WfCo/H45EtK6qgkjveBvB6AsMD/70mj2aU26d9cpOoywvp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKLeExZjKytQU/LxjF9V/pX3JV++KFQAsBTw23Wq8ew=;
 b=m4BiJEOtlJeZr0lNoiSNb02YBkDf94+BWZEuS5OE0ANzyH9aNTwGI++egsp5UH2KeVNSq7sWs4x2/+O4XSxS1Ut3gZlAE9SAA61PKUjtNfan6hMigIAn/tGBzrsQDdsbF32a8GjAi0pPUe6UCFkJU3Txw2fUm1OeJ1FrcZnUtFd+r+6riiyIiatGS0iGWgjZ+FnLbp9XkfSdEdP7cnri4ZmTNVX42Mgfg9I4KTAqIYQhEBxc8EOPL79kghmPUMOSKVOAGbgEt9+XJmAxfZC5jv/QOk2ziL22GZ+pRQnunJhegxwbQhzXbv356paFvjvpeKjVykG/e4T+7TlyTdaz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKLeExZjKytQU/LxjF9V/pX3JV++KFQAsBTw23Wq8ew=;
 b=LVo107ERhn4ndIyufN/A78P5i6cttgXdFLXC3qelaikYOYrBF7x6tTm1/LS9hTJJOBeaK54IlQkf0MrBa6HdFfM7qeHmWzdATO32BwSvKSf5lU466Qhr3RWb4h5aRmLYM0O75TKSb4QT5OniGF2U06wnFIeYnxpjB7DGvHy8XX49SaOgZVBt1/4HZIQFXLSRno5oPI4aFnHHadzFj3Pr0AH7sla3bRrqFQ+1KJXcaZ9NeolIAbXmEP74JnRzPbT6wAe84LD/mw9zWyTfwyHwK++jfH+GHxL2GwSuzPyN/ZY+xiVpfg4U5S5RL+TUaGoS5KoCIwSqkD3RqwjPEnVufA==
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.35; Thu, 26 Jun
 2025 19:35:20 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::e2) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:03 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 00/28] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Thu, 26 Jun 2025 12:34:31 -0700
Message-ID: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 599b892d-7fb2-476f-43e1-08ddb4e89669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T4fZxoRz2JfcxTMxVPEI1Mk6Nerjg74BD7TQT1i3kFUnHCb2G1X5/Ly0dzMj?=
 =?us-ascii?Q?2uECcLfricmYXCOxffpP4GRZAhKj6rMhHZn5hXZHESlVxa3IaJJRdm+ptdZf?=
 =?us-ascii?Q?R4R4wisi5hr5e5CZeIzRod7KWyDAKwTiet1f8tZpoa1H2ems9ddTdUTIfiFE?=
 =?us-ascii?Q?edwUANtxBOLyonfV/dsDmuW6K3K3jeu82P7VNNwBufY4R5NbS7Wgjq0aVl7x?=
 =?us-ascii?Q?y6/UDB8qT5Bha+3THQZ4r1T7rNY1kzAa5ckAynYMRM7POpHL6O1j6SX+uyNK?=
 =?us-ascii?Q?OClSTppwGr1H0/i1pdTLrTVsmlZBEIWPBNuSlxv8YseWjC6NFXqlg2B8si50?=
 =?us-ascii?Q?kZiQf2bjTsppo3UtZ7sSVCdgiTfTwBFQ4y+B4mDFBzfwSfa3Z6nvFyLaATKZ?=
 =?us-ascii?Q?yX9VmShQ81IOi2mtg0vIxkDJHbEopxbkw+uWubOkF3TlmTdCC30vj3GzcMPv?=
 =?us-ascii?Q?QyejhamqLzSEqdKwoalLSFO7Q7yh0CkR78EHRm6auwEiN2SqMk/n4dFgTXj6?=
 =?us-ascii?Q?M7BrekkFgwS+baLqB+DbO8clD/Uexij7HkluAXjxVhyp12+fjhqmBoswCr9r?=
 =?us-ascii?Q?cm+3ETpUTrQCy/WXbGuXBklv5WltjXDBErlS97HV58SFE/sV0VRcRTLS0GLg?=
 =?us-ascii?Q?In1E+mpkcQNjQJJCYbr8PU5kywzgpU7CR2WjJuJJ9DGc33aEelgx5q8zkTS6?=
 =?us-ascii?Q?PBVKuCRQNUOrKbFJamQr5xlkMj1Xwf2RAlttzkYmiyZmicqYBq37ICY5bBKU?=
 =?us-ascii?Q?o42Xf1gTiaoq7ZywZ6/P538EolMy9MnzTyZGyu2tBTk/m8xxDFx8ADSYcljQ?=
 =?us-ascii?Q?7/2KGZFPz8EWxk11NcYQO4M00aH//kIHcwHoD86gfOiQCMCN0trXmEhmy9FM?=
 =?us-ascii?Q?UjlWvULYL/Lwv9llPzPIjGT8+FfocqSA7cggeJwyGuknfKDgmt6tJAQUH3sB?=
 =?us-ascii?Q?IdniJvnUtfTyFk0rQ7UHTdJh7h/ZxVIc9Wn6Oa9mQv77Es4x/rBDVylKPxf3?=
 =?us-ascii?Q?035EpWc69akMQbnrYPn+J+T38dv66WHGdU3bI+IPLXkHdHwYqIrOZ4xqsOhF?=
 =?us-ascii?Q?OfxzWr8qBrhegJesjaDfNw8ovi9RsEjEolQGKDYHpt7Odl+U47HS7N8z1J7l?=
 =?us-ascii?Q?H5z3Bct08ZwHVzPtT1283R5gn48pJsfu0a59RTsXda8Nm2lfNDtXvWoBUwXu?=
 =?us-ascii?Q?4iJLVaNaQRN+ydUInBNFhHaFRQq1GMAvudIrKCWoLQ9V/KoJP5Bm38jm/Ufk?=
 =?us-ascii?Q?6+RrOG71BqZrNiX0nYvfrbKeKcGm6F5W+b6WzMh+kJxuYmPA7n07mNsaiBqQ?=
 =?us-ascii?Q?FjrqUmtWAfrPk1J31vF3boKB7/KzlbJQIukwDCG6LKIdZO21e5vmPTbAhmdP?=
 =?us-ascii?Q?zrBRHgMAEwn4iRHUGWX1GXLpLoeZkHT/3fuzOqvqdb5yy5Tgl+49AAF1//Sg?=
 =?us-ascii?Q?vntEvMdHnVQbdN4/IBJnnDF/VxksZ8AgsUiTcMFoDQYfR0JJxPUEcdxR7/Tu?=
 =?us-ascii?Q?rwm/pN5fnGNVPeZKd/fGbdMHO4LnoWwvA5zXbqTmYdEg4lIcGz3HLrrfzg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:20.3385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b892d-7fb2-476f-43e1-08ddb4e89669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074

The vIOMMU object is designed to represent a slice of an IOMMU HW for its
virtualization features shared with or passed to user space (a VM mostly)
in a way of HW acceleration. This extended the HWPT-based design for more
advanced virtualization feature.

HW QUEUE introduced by this series as a part of the vIOMMU infrastructure
represents a HW accelerated queue/buffer for VM to use exclusively, e.g.
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
each of which allows its IOMMU HW to directly access a queue memory owned
by a guest VM and allows a guest OS to control the HW queue direclty, to
avoid VM Exit overheads to improve the performance.

Introduce IOMMUFD_OBJ_HW_QUEUE and its pairing IOMMUFD_CMD_HW_QUEUE_ALLOC
allowing VMM to forward the IOMMU-specific queue info, such as queue base
address, size, and etc.

Meanwhile, a guest-owned queue needs the guest kernel to control the queue
by reading/writing its consumer and producer indexes, via MMIO acceses to
the hardware MMIO registers. Introduce an mmap infrastructure for iommufd
to support passing through a piece of MMIO region from the host physical
address space to the guest physical address space. The mmap info (offset/
length) used by an mmap syscall must be pre-allocated and returned to the
user space via an output driver-data during an IOMMUFD_CMD_HW_QUEUE_ALLOC
call. Thus, it requires a driver-specific user data support in the vIOMMU
allocation flow.

As a real-world use case, this series implements a HW QUEUE support in the
tegra241-cmdqv driver for VCMDQs on NVIDIA Grace CPU. In another word, it
is also the Tegra CMDQV series Part-2 (user-space support), reworked from
Previous RFCv1:
    https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/
This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
the standard SMMUv3 operating in the nested translation mode trapping CMDQ
for TLBI and ATC_INV commands, this gives a huge performance improvement:
70% to 90% reductions of invalidation time were measured by various DMA
unmap tests running in a guest OS.

// Unmap latencies from "dma_map_benchmark -g @granule -t @threads",
// by toggling "/sys/kernel/debug/iommu/tegra241_cmdqv/bypass_vcmdq"
@granule | @threads | bypass_vcmdq=1 | bypass_vcmdq=0
    4KB        1          35.7 us          5.3 us
   16KB        1          41.8 us          6.8 us
   64KB        1          68.9 us          9.9 us
  128KB        1         109.0 us         12.6 us
  256KB        1         187.1 us         18.0 us
    4KB        2          96.9 us          6.8 us
   16KB        2          97.8 us          7.5 us
   64KB        2         151.5 us         10.7 us
  128KB        2         257.8 us         12.7 us
  256KB        2         443.0 us         17.9 us

This is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v7

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v7

Changelog
v7
 * Rebased on Jason's for-next tree (iommufd_hw_queue-prep series)
 * Add Reviewed-by from Baolu, Jason, Pranjal
 * Update kdocs and notes
 * [iommu] Replace "u32" with "enum iommu_hw_info_type"
 * [iommufd] Rename vdev->id to vdev->virt_id
 * [iommufd] Replace macros with inline helpers
 * [iommufd] Report unmapped_bytes in error path
 * [iommufd] Add iommufd_access_is_internal helper
 * [iommufd] Do not drop ops->unmap check for mdevs
 * [iommufd] Store physical addresses in immap structure
 * [iommufd] Reorder access and hw_queue object allocations
 * [iommufd] Scan for an internal access before any unmap call
 * [iommufd] Drop unused ictx pointer in struct iommufd_hw_queue
 * [iommufd] Use kcalloc to avoid failure due to memory fragmentation
 * [tegra] Use "else"
 * [tegra] Lock destroy() using lvcmdq_mutex
v6
 https://lore.kernel.org/all/cover.1749884998.git.nicolinc@nvidia.com/
 * Rebase on iommufd_hw_queue-prep-v2
 * Add Reviewed-by from Kevin and Jason
 * [iommufd] Update kdocs and notes
 * [iommufd] Drop redundant pages[i] check
 * [iommufd] Allow nesting_parent_iova to be 0
 * [iommufd] Add iommufd_hw_queue_alloc_phys()
 * [iommufd] Revise iommufd_viommu_alloc/destroy_mmap APIs
 * [iommufd] Move destroy ops to vdevice/hw_queue structures
 * [iommufd] Add union in hw_info struct to share out_data_type field
 * [iommufd] Replace iopt_pin/unpin_pages() with internal access APIs
 * [iommufd] Replace vdevice_alloc with vdevice_size and vdevice_init
 * [iommufd] Replace hw_queue_alloc with get_hw_queue_size/hw_queue_init
 * [iommufd] Replace IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA with init_phys
 * [smmu] Drop arm_smmu_domain_ipa_to_pa
 * [smmu] Update arm_smmu_impl_ops changes for vsmmu_init
 * [tegra] Add a vdev_to_vsid macro
 * [tegra] Add lvcmdq_mutex to protect multi queues
 * [tegra] Drop duplicated kcalloc for vintf->lvcmdqs (memory leak)
v5
 https://lore.kernel.org/all/cover.1747537752.git.nicolinc@nvidia.com/
 * Rebase on v6.15-rc6
 * Add Reviewed-by from Jason and Kevin
 * Correct typos in kdoc and update commit logs
 * [iommufd] Add a cosmetic fix
 * [iommufd] Drop unused num_pfns
 * [iommufd] Drop unnecessary check
 * [iommufd] Reorder patch sequence
 * [iommufd] Use io_remap_pfn_range()
 * [iommufd] Use success oriented flow
 * [iommufd] Fix max_npages calculation
 * [iommufd] Add more selftest coverage
 * [iommufd] Drop redundant static_assert
 * [iommufd] Fix mmap pfn range validation
 * [iommufd] Reject unmap on pinned iovas
 * [iommufd] Drop redundant vm_flags_set()
 * [iommufd] Drop iommufd_struct_destroy()
 * [iommufd] Drop redundant queue iova test
 * [iommufd] Use "mmio_addr" and "mmio_pfn"
 * [iommufd] Rename to "nesting_parent_iova"
 * [iommufd] Make iopt_pin_pages call option
 * [iommufd] Add ictx comparison in depend()
 * [iommufd] Add iommufd_object_alloc_ucmd()
 * [iommufd] Move kcalloc() after validations
 * [iommufd] Replace ictx setting with WARN_ON
 * [iommufd] Make hw_info's type bidirectional
 * [smmu] Add supported_vsmmu_type in impl_ops
 * [smmu] Drop impl report in smmu vendor struct
 * [tegra] Add IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV
 * [tegra] Replace "number of VINTFs" with a note
 * [tegra] Drop the redundant lvcmdq pointer setting
 * [tegra] Flag IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA
 * [tegra] Use "vintf_alloc_vsid" for vdevice_alloc op
v4
 https://lore.kernel.org/all/cover.1746757630.git.nicolinc@nvidia.com/
 * Rebase on v6.15-rc5
 * Add Reviewed-by from Vasant
 * Rename "vQUEUE" to "HW QUEUE"
 * Use "offset" and "length" for all mmap-related variables
 * [iommufd] Use u64 for guest PA
 * [iommufd] Fix typo in uAPI doc
 * [iommufd] Rename immap_id to offset
 * [iommufd] Drop the partial-size mmap support
 * [iommufd] Do not replace WARN_ON with WARN_ON_ONCE
 * [iommufd] Use "u64 base_addr" for queue base address
 * [iommufd] Use u64 base_pfn/num_pfns for immap structure
 * [iommufd] Correct the size passed in to mtree_alloc_range()
 * [iommufd] Add IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to viommu_ops
v3
 https://lore.kernel.org/all/cover.1746139811.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Baolu, Pranjal, and Alok
 * Revise kdocs, uAPI docs, and commit logs
 * Rename "vCMDQ" back to "vQUEUE" for AMD cases
 * [tegra] Add tegra241_vcmdq_hw_flush_timeout()
 * [tegra] Rename vsmmu_alloc to alloc_vintf_user
 * [tegra] Use writel for SID replacement registers
 * [tegra] Move mmap removal call to vsmmu_destroy op
 * [tegra] Fix revert in tegra241_vintf_alloc_lvcmdq_user()
 * [iommufd] Replace "& ~PAGE_MASK" with PAGE_ALIGNED()
 * [iommufd] Add an object-type "owner" to immap structure
 * [iommufd] Drop the ictx input in the new for-driver APIs
 * [iommufd] Add iommufd_vma_ops to keep track of mmap lifecycle
 * [iommufd] Add viommu-based iommufd_viommu_alloc/destroy_mmap helpers
 * [iommufd] Rename iommufd_ctx_alloc/free_mmap to
             _iommufd_alloc/destroy_mmap
v2
 https://lore.kernel.org/all/cover.1745646960.git.nicolinc@nvidia.com/
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

Nicolin Chen (28):
  iommufd: Report unmapped bytes in the error path of
    iopt_unmap_iova_range
  iommufd/viommu: Explicitly define vdev->virt_id
  iommu: Use enum iommu_hw_info_type for type in hw_info op
  iommu: Add iommu_copy_struct_to_user helper
  iommu: Pass in a driver-level user data structure to viommu_init op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add coverage for viommu data
  iommufd/access: Add internal APIs for HW queue to use
  iommufd/access: Bypass access->ops->unmap for internal use
  iommufd/viommu: Add driver-defined vDEVICE support
  iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
  iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
  iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
  iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
  iommufd: Add mmap interface
  iommufd/selftest: Add coverage for the new mmap interface
  Documentation: userspace-api: iommufd: Update HW QUEUE
  iommu: Allow an input type in hw_info op
  iommufd: Allow an input data_type via iommu_hw_info
  iommufd/selftest: Update hw_info coverage for an input data_type
  iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
  iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
  iommu/tegra241-cmdqv: Use request_threaded_irq
  iommu/tegra241-cmdqv: Simplify deinit flow in
    tegra241_cmdqv_remove_vintf()
  iommu/tegra241-cmdqv: Do not statically map LVCMDQs
  iommu/tegra241-cmdqv: Add user-space use support
  iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 drivers/iommu/iommufd/iommufd_private.h       |  50 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  50 +-
 include/linux/iommufd.h                       | 160 ++++++
 include/uapi/linux/iommufd.h                  | 145 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  89 +++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  28 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 484 +++++++++++++++++-
 drivers/iommu/intel/iommu.c                   |   7 +-
 drivers/iommu/iommufd/device.c                |  90 +++-
 drivers/iommu/iommufd/driver.c                |  81 ++-
 drivers/iommu/iommufd/io_pagetable.c          |  17 +-
 drivers/iommu/iommufd/main.c                  |  69 +++
 drivers/iommu/iommufd/selftest.c              | 153 +++++-
 drivers/iommu/iommufd/viommu.c                | 208 +++++++-
 tools/testing/selftests/iommu/iommufd.c       | 143 +++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  15 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 19 files changed, 1736 insertions(+), 107 deletions(-)

-- 
2.43.0


