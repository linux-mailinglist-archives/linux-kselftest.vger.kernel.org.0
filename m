Return-Path: <linux-kselftest+bounces-36611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E3AF9D20
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12085871CC
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE618871F;
	Sat,  5 Jul 2025 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2Pzmu+C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3B156C40;
	Sat,  5 Jul 2025 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678049; cv=fail; b=JPzY++tWN4SeqgEu3BRt7XhK2DCXzVG+VX4yM3L8/2/sOungetwgb5gholRyIxxO/M6cym703PJ3yL/OhbLvRJXrXKzMQiEKfwQDbYwF+ls26eABnjIlBhOMY3uOZieDr57kBKChrOaUk1T5DuR34ag81OyJMWFw1gm2av2QkdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678049; c=relaxed/simple;
	bh=oSq5wicUnCMAoC+fCHww2ssj5F/Z3MinGoDkWIDqEV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhN/jacUfHPVDaPsncshK9dB96XGm9zsgsDibvDZ4N3gMiHSTVM91jDmC4Typ9slmY2Q4jVRbVF0qqeMkRpz3kSTwh2rrSnxKIg/rASvKNNCZBFxAsZp+buQwhRIMbeI+X+/9KTN7mfWZoKQ3s00l11fMB54wEpdExH71uSAOyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2Pzmu+C; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCmS0oU0XvddzIO2nX9fKsvCm8eA/r5BGoDyaGrK0oh/pknqExQJCX9+AUckfHivBkQeGNYPYmowZzqY/gpQGVsYnlGvC+US0K3CfAmPZUurFDcBbiaMOFCDOA70sQPt2qK+0KuGtIeVyURaTYTeL57gacdOdrkFz+j3LRFsqCweaUMOx7sVs29SBigPA84RdXzjyv7XNbb+ZweegTvScP2wzJNczhc35bDkai1vGDJUT2HjvQ7jirFO28TL9LRsz7CQuAXnVcKVqaWKnfze+eqhBpsROpcr+EFcFAbMF+HBCOh5SoPBVETuzc/WNXBWrFStG5C3AAkaT0/WtTV1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enIYLRWx36iGm4fS34BGMfBukdgry184sdgJmxRRc9I=;
 b=dAub+sR4CdJ63PbDpo5JCxR00QrSgwmMkRyUuOSjI0MnM0BrpSf1/NWmTBip3IUaj+UwfN1n6PZhK4xwGZxsaxyFlOfkuF20cl8z5DBZ3mfNrJtxnJn/JkYZh7fQ5OMsy4znCjSIOcfTeESs+b7F15Q4wLeVijAZNONoBl09j7wf68UbHSGkn59upEqjTgXM7sXkhqOml90k+Mrj93DtCgUpr94huSFqNk9HnseteRDjTNlM+1OMYHSqGo23mW5xzLllXdyWIrtzhz3br7KXcIkTZFxykrbeQ9tiRozcN9tb+oVHp570R43yfd0qVFpAcbjDVdCExqcekSARhSg2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enIYLRWx36iGm4fS34BGMfBukdgry184sdgJmxRRc9I=;
 b=e2Pzmu+CwhE28kpRku/AWoUHoIyYk22uVxjtrC0E7s0sOnB0PlI/xI5WMcYH2wTxEVOaYmrZtnSeHMYxJf0aGB2jJe8y8O/u7ptTpEPQ92ej/gz9r4/7i0yPao76wpDc9swZjT0cX9BIXKK2PRyCml3KLjfGiwSONQ+4SfTAex+dclqXSJ/i4RsyIVxvAgs7RgHBqbfy0O3cIaw38Dg+eORwmpnxGz/vvFwvZ9K40jxdHOQt1UmDJQ5nCLPjKXCcLsnrpRBGH5tDDVUwPmoAJdPGwt7ttJgLTPs3ZRqfymsha9Rpz090Z3he8E2BElS3QaE+kiGw9oIDsSYEGUj3fw==
Received: from BY5PR16CA0010.namprd16.prod.outlook.com (2603:10b6:a03:1a0::23)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Sat, 5 Jul
 2025 01:13:57 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ba) by BY5PR16CA0010.outlook.office365.com
 (2603:10b6:a03:1a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:13:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:13:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:13:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:13:53 -0700
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
Subject: [PATCH v8 00/29] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Fri, 4 Jul 2025 18:13:16 -0700
Message-ID: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f06944-8ea8-462f-1284-08ddbb6136ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8gx6mZLpcjghmVpUJ5EzaF6yiXTXQ/siIXGGaKfJVfdrhqKk7j81AeJR7u7?=
 =?us-ascii?Q?FH05xwA8ehI6YkVVz/dKTMD9uGtme96F8qDOa10nFeqUjmaI9efpVGU44Csy?=
 =?us-ascii?Q?gyib0QglmexkkGRZSFJvaiAO1JnqPN3h/P6R8bsCRO7vfu0kBGl3k0tLR4nw?=
 =?us-ascii?Q?fsnOG3Ma/DcCmWBpQxmSTo+6eLjeiKOXHpWn34l9KBmkMtHs0b0Z/hHXkQhi?=
 =?us-ascii?Q?trAoSZ8rKQ+/ITCfL5gyB0zrUt+tu0X4/rjt9HjFOdfJTIPVtn8HJbMSNM5O?=
 =?us-ascii?Q?uNwPkeaLFG+LVlrHTpztD/6lt0esh/57pwhFTbJRU4YkvL70m2+WygS8PHsD?=
 =?us-ascii?Q?vLmlbAoiC5VtLC1Bc0a8HvYWNHpiDBF5TTJTOsO564jpReFJDoOfweAGncJi?=
 =?us-ascii?Q?YRz6dItjLNGKypVRNk5AGfST4MakOMTYB7zblSTX3iGeBsoR8ptovNLZbhZW?=
 =?us-ascii?Q?zseG9Q4gCAxSexCmdnAa3EdKK3j6Cjtw78RJihRDzvvf8Z0jqmouVh2ZW4Of?=
 =?us-ascii?Q?K8mu1Xc6HxY37mpywUijf3F2VXgfblScyQxqAtmy8N0t8rN1fpZWvzosxyRu?=
 =?us-ascii?Q?aRVY7Nd3jVlQn51sNeMKmqojZOomKQscQaQu0pV4CNe4gQ30gwxVlhyrGwtF?=
 =?us-ascii?Q?be7se2NWzQYo61zFMnUS4m5Xd5dViDKB+1miXziw+SeJYF3ZEPR2fPutYA78?=
 =?us-ascii?Q?gwKO5LFZ0GMuB6lIAUHsnYgs36ze1PZjNJ0eK6kUxquJ5Xg69+VwY+8sWM5r?=
 =?us-ascii?Q?/IXen+8emYTdhhWHl52MV4+jnPj9hyjokrKcQ9rYpYWcPA+lyJ82nRZay/QG?=
 =?us-ascii?Q?G5xEOkjYi+kO0b95n4fN71TVWeqJ2GCrQN/KgQuyOjlfKfpnmbFBJDqzNL5m?=
 =?us-ascii?Q?enqR92fbRMh/96mase3fkiDMz4gRZjWUH6WHm+DOrDM+UJZJezevxkK9pArR?=
 =?us-ascii?Q?IQ7bpcW9gN/nQZAxQdkmfWmwiHf5V0BClNFSbxQpmerTFbGNmgHh3Xx6K2vS?=
 =?us-ascii?Q?yZi/PE4BpoWEKlouioPqUMf5XnMqZuOUGyGedJKIAbe+4NQ6BMW5mTPemGzc?=
 =?us-ascii?Q?12Un3DLPUbZMaDGXkRCuxmtAHaixfhSfEaIN7O8Bqoz73Ozu472U+XeHVbJZ?=
 =?us-ascii?Q?p9thJEwsruJsBdBTzfjdkFTK43JXS+uw2E0IOkNvABVR/9poohHGFzudbHxe?=
 =?us-ascii?Q?S+OXsePXsyM1nsb6xg5appWAaFWhQgvddD7aMpZhiWsSKBk/ZnGZEFBUtOzO?=
 =?us-ascii?Q?2tZ1vuZhvPUvHVAYsBjHBsWLtVGebM1UetIAHX04tvOny/qE4F6G0f/55J8v?=
 =?us-ascii?Q?LQfFEOvemejeIa/Mj1omCvVaoNXzWtlPyjsLw7NvhUsclcHsVdwSciMY2kU0?=
 =?us-ascii?Q?YEygCShYLYKnSMeAeA/wbMP+YdqyjyR8CVcqexJhPP3NtobOZd4mwrPfloYJ?=
 =?us-ascii?Q?1fOLcqoaaxYTxO/kX3lXZlsPKSfFKp/e0NGw43JtJ3O++B1xlDVAyHy8qF6R?=
 =?us-ascii?Q?vUcXJ6pLo/SfvDFEW5RJKx9A7k873tpSYW/qaCqoMwdqCjq4r5/Ec+u4Ww?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:13:56.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f06944-8ea8-462f-1284-08ddbb6136ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

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
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v8

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v8

Changelog (attached git-diff v7..v8 at the end of this letter)
v8
 * Add Reviewed-by from Pranj, Kevin and Jason
 * Improve kdoc and comments
 * [iommufd] Skip selftest for no_viommu variants
 * [iommufd] Add unmap coverage for non internal area
 * [iommufd] Skip the first page when mtree_alloc_range()
 * [iommufd] Correct the passed in index to mtree_erase()
 * [iommufd] Correct variable types in iommufd_hw_queue_alloc_phys()
 * [iommufd] Reject iopt_unmap_iova_range() if area->num_locked is set
 * [tegra] Rename "SID replacement" with "SID mapping"
 * [tegra] Unwrap useless _tegra241_vcmdq_hw_init helper
v7
 https://lore.kernel.org/all/cover.1750966133.git.nicolinc@nvidia.com/
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

Nicolin Chen (29):
  iommufd: Report unmapped bytes in the error path of
    iopt_unmap_iova_range
  iommufd: Correct virt_id kdoc at struct iommu_vdevice_alloc
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
 drivers/iommu/iommufd/io_pagetable.h          |   5 +-
 drivers/iommu/iommufd/iommufd_private.h       |  46 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  50 +-
 include/linux/iommufd.h                       | 160 ++++++
 include/uapi/linux/iommufd.h                  | 147 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  89 +++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  28 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 477 +++++++++++++++++-
 drivers/iommu/intel/iommu.c                   |   7 +-
 drivers/iommu/iommufd/device.c                |  87 +++-
 drivers/iommu/iommufd/driver.c                |  82 ++-
 drivers/iommu/iommufd/io_pagetable.c          |  13 +-
 drivers/iommu/iommufd/main.c                  |  69 +++
 drivers/iommu/iommufd/pages.c                 |  12 +-
 drivers/iommu/iommufd/selftest.c              | 153 +++++-
 drivers/iommu/iommufd/viommu.c                | 215 +++++++-
 tools/testing/selftests/iommu/iommufd.c       | 140 ++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  15 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 21 files changed, 1739 insertions(+), 110 deletions(-)

-- 
2.43.0

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d57a3bea948c..d5d43a1c7708 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -161,7 +161,7 @@ struct tegra241_vcmdq {
  * @lvcmdq_mutex: Lock to serialize user-allocated lvcmdqs
  * @base: MMIO base address
  * @mmap_offset: Offset argument for mmap() syscall
- * @sids: Stream ID replacement resources
+ * @sids: Stream ID mapping resources
  */
 struct tegra241_vintf {
 	struct arm_vsmmu vsmmu;
@@ -183,11 +183,11 @@ struct tegra241_vintf {
 #define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, vsmmu.core)
 
 /**
- * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
+ * struct tegra241_vintf_sid - Virtual Interface Stream ID Mapping
  * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
  * @vintf: Parent VINTF pointer
  * @sid: Physical Stream ID
- * @idx: Replacement index in the VINTF
+ * @idx: Mapping index in the VINTF
  */
 struct tegra241_vintf_sid {
 	struct iommufd_vdevice core;
@@ -207,7 +207,7 @@ struct tegra241_vintf_sid {
  * @num_vintfs: Total number of VINTFs
  * @num_vcmdqs: Total number of VCMDQs
  * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
- * @num_sids_per_vintf: Total number of SID replacements per VINTF
+ * @num_sids_per_vintf: Total number of SID mappings per VINTF
  * @vintf_ids: VINTF id allocator
  * @vintfs: List of VINTFs
  */
@@ -470,12 +470,6 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
 
-/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
-static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
-{
-	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
-}
-
 /* This function is for LVCMDQ, so @vcmdq must be mapped prior */
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
@@ -486,7 +480,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	/* Configure and enable VCMDQ */
-	_tegra241_vcmdq_hw_init(vcmdq);
+	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
@@ -1077,7 +1071,7 @@ static int tegra241_vcmdq_hw_init_user(struct tegra241_vcmdq *vcmdq)
 	char header[64];
 
 	/* Configure the vcmdq only; User space does the enabling */
-	_tegra241_vcmdq_hw_init(vcmdq);
+	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
 	dev_dbg(vcmdq->cmdqv->dev, "%sinited at host PA 0x%llx size 0x%lx\n",
 		lvcmdq_error_header(vcmdq, header, 64),
@@ -1259,6 +1253,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
 	.destroy = tegra241_cmdqv_destroy_vintf_user,
 	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	/* Non-accelerated commands will be still handled by the kernel */
 	.cache_invalidate = arm_vsmmu_cache_invalidate,
 	.vdevice_size = VDEVICE_STRUCT_SIZE(struct tegra241_vintf_sid, core),
 	.vdevice_init = tegra241_vintf_init_vsid,
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index cbd86aabdd1c..e2ba21c43ad2 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1245,26 +1245,18 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, "IOMMUFD");
  * run in the future. Due to this a driver must not create locking that prevents
  * unmap to complete while iommufd_access_destroy() is running.
  */
-int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				unsigned long length)
+void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				 unsigned long length)
 {
 	struct iommufd_ioas *ioas =
 		container_of(iopt, struct iommufd_ioas, iopt);
 	struct iommufd_access *access;
 	unsigned long index;
-	int ret = 0;
 
 	xa_lock(&ioas->iopt.access_list);
-	/* Bypass any unmap if there is an internal access */
 	xa_for_each(&ioas->iopt.access_list, index, access) {
-		if (iommufd_access_is_internal(access)) {
-			ret = -EBUSY;
-			goto unlock;
-		}
-	}
-
-	xa_for_each(&ioas->iopt.access_list, index, access) {
-		if (!iommufd_lock_obj(&access->obj))
+		if (!iommufd_lock_obj(&access->obj) ||
+		    iommufd_access_is_internal(access))
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
 
@@ -1273,9 +1265,7 @@ int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 		iommufd_put_object(access->ictx, &access->obj);
 		xa_lock(&ioas->iopt.access_list);
 	}
-unlock:
 	xa_unlock(&ioas->iopt.access_list);
-	return ret;
 }
 
 /**
@@ -1290,6 +1280,7 @@ int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1316,7 +1307,8 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 			area, iopt_area_iova_to_index(area, iter.cur_iova),
 			iopt_area_iova_to_index(
 				area,
-				min(last_iova, iopt_area_last_iova(area))));
+				min(last_iova, iopt_area_last_iova(area))),
+			internal);
 	WARN_ON(!iopt_area_contig_done(&iter));
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
@@ -1365,6 +1357,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1374,8 +1367,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
 	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
-		    (!iommufd_access_is_internal(access) &&
-		     !access->ops->unmap)))
+		    (!internal && !access->ops->unmap)))
 		return -EINVAL;
 
 	if (!length)
@@ -1409,7 +1401,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 		}
 
 		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
+					  flags, internal);
 		if (rc)
 			goto err_remove;
 		out_pages += last_index - index + 1;
@@ -1432,7 +1424,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 				iopt_area_iova_to_index(area, iter.cur_iova),
 				iopt_area_iova_to_index(
 					area, min(last_iova,
-						  iopt_area_last_iova(area))));
+						  iopt_area_last_iova(area))),
+				internal);
 	}
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2c9af93217f1..153e4720ee18 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -56,8 +56,9 @@ int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
 	immap->length = length;
 	immap->mmio_addr = mmio_addr;
 
-	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length, 0,
-			       PHYS_ADDR_MAX, GFP_KERNEL);
+	/* Skip the first page to ease caller identifying the returned offset */
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length,
+			       PAGE_SIZE, PHYS_ADDR_MAX, GFP_KERNEL);
 	if (rc < 0) {
 		kfree(immap);
 		return rc;
@@ -76,7 +77,7 @@ void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 {
 	struct iommufd_mmap *immap;
 
-	immap = mtree_erase(&ictx->mt_mmap, offset >> PAGE_SHIFT);
+	immap = mtree_erase(&ictx->mt_mmap, offset);
 	WARN_ON_ONCE(!immap || immap->owner != owner);
 	kfree(immap);
 }
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 6b8477b1f94b..abf4aadca96c 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -719,6 +719,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		/* The area is locked by an object that has not been destroyed */
+		if (area->num_locks) {
+			rc = -EBUSY;
+			goto out_unlock_iova;
+		}
+
 		if (area_first < start || area_last > last) {
 			rc = -ENOENT;
 			goto out_unlock_iova;
@@ -740,15 +746,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
 
-			rc = iommufd_access_notify_unmap(iopt, area_first,
-							 length);
-			if (rc) {
-				down_read(&iopt->domains_rwsem);
-				down_write(&iopt->iova_rwsem);
-				area->prevent_access = false;
-				goto out_unlock_iova;
-			}
-
+			iommufd_access_notify_unmap(iopt, area_first, length);
 			/* Something is not responding to unmap requests. */
 			tries++;
 			if (WARN_ON(tries > 100)) {
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c115a51d9384..b6064f4ce4af 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -48,6 +48,7 @@ struct iopt_area {
 	int iommu_prot;
 	bool prevent_access : 1;
 	unsigned int num_accesses;
+	unsigned int num_locks;
 };
 
 struct iopt_allowed {
@@ -238,9 +239,9 @@ void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
 
 int iopt_area_add_access(struct iopt_area *area, unsigned long start,
 			 unsigned long last, struct page **out_pages,
-			 unsigned int flags);
+			 unsigned int flags, bool lock_area);
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
-			     unsigned long last);
+			     unsigned long last, bool unlock_area);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index ebac6a4b3538..cd14163abdd1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -125,8 +125,8 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 int iopt_set_dirty_tracking(struct io_pagetable *iopt,
 			    struct iommu_domain *domain, bool enable);
 
-int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				unsigned long length);
+void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				 unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index cbdde642d2af..301c232462bd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -2111,7 +2111,7 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  */
 int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 			 unsigned long last_index, struct page **out_pages,
-			 unsigned int flags)
+			 unsigned int flags, bool lock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2124,6 +2124,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
 		area->num_accesses++;
+		if (lock_area)
+			area->num_locks++;
 		access->users++;
 		iopt_pages_fill_from_xarray(pages, start_index, last_index,
 					    out_pages);
@@ -2145,6 +2147,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access->node.last = last_index;
 	access->users = 1;
 	area->num_accesses++;
+	if (lock_area)
+		area->num_locks++;
 	interval_tree_insert(&access->node, &pages->access_itree);
 	mutex_unlock(&pages->mutex);
 	return 0;
@@ -2166,7 +2170,7 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
  * must stop using the PFNs before calling this.
  */
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
-			     unsigned long last_index)
+			     unsigned long last_index, bool unlock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2177,6 +2181,10 @@ void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
 		goto out_unlock;
 
 	WARN_ON(area->num_accesses == 0 || access->users == 0);
+	if (unlock_area) {
+		WARN_ON(area->num_locks == 0);
+		area->num_locks--;
+	}
 	area->num_accesses--;
 	access->users--;
 	if (access->users)
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index ce509a827721..00641204efb2 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -241,13 +241,20 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 {
 	struct iommufd_access *access;
 	struct page **pages;
-	int max_npages, i;
+	size_t max_npages;
+	size_t length;
 	u64 offset;
+	size_t i;
 	int rc;
 
 	offset =
 		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
-	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
+	/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
+	if (check_add_overflow(offset, cmd->length, &length))
+		return ERR_PTR(-ERANGE);
+	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
+		return ERR_PTR(-ERANGE);
+	max_npages = length / PAGE_SIZE;
 
 	/*
 	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 7ab9e3e928b3..e3a0cd47384d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -112,7 +112,7 @@ struct iommufd_vdevice {
 
 	/*
 	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
-	 * AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+	 * AMD IOMMU, and vRID of Intel VT-d
 	 */
 	u64 virt_id;
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index a2840beefa8c..111ea81f91a2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -997,7 +997,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
- *                                    SMMUv3) Virtual Interface (VINTF)
+ *                                    SMMUv3) enabled ARM SMMUv3 type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1065,7 +1065,7 @@ struct iommu_viommu_alloc {
  * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
  * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
  * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
- *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *           of AMD IOMMU, and vRID of Intel VT-d
  *
  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
  * This instance holds the device's information (related to its vIOMMU) in a VM.
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index fda93a195e26..9d5b852d5e19 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2817,33 +2817,31 @@ TEST_F(iommufd_viommu, viommu_alloc_with_data)
 	};
 	uint32_t *test;
 
-	if (self->device_id) {
-		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
-				      sizeof(data), &self->viommu_id);
-		ASSERT_EQ(data.out_data, data.in_data);
-
-		/* Negative mmap tests -- offset and length cannot be changed */
-		test_err_mmap(ENXIO, data.out_mmap_length,
-			      data.out_mmap_offset + PAGE_SIZE);
-		test_err_mmap(ENXIO, data.out_mmap_length,
-			      data.out_mmap_offset + PAGE_SIZE * 2);
-		test_err_mmap(ENXIO, data.out_mmap_length / 2,
-			      data.out_mmap_offset);
-		test_err_mmap(ENXIO, data.out_mmap_length * 2,
-			      data.out_mmap_offset);
-
-		/* Now do a correct mmap for a loopback test */
-		test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, self->fd, data.out_mmap_offset);
-		ASSERT_NE(MAP_FAILED, test);
-		ASSERT_EQ(data.in_data, *test);
-
-		/* The owner of the mmap region should be blocked */
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, self->viommu_id));
-		munmap(test, data.out_mmap_length);
-	}
+	if (!self->device_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+			      IOMMU_VIOMMU_TYPE_SELFTEST, &data, sizeof(data),
+			      &self->viommu_id);
+	ASSERT_EQ(data.out_data, data.in_data);
+
+	/* Negative mmap tests -- offset and length cannot be changed */
+	test_err_mmap(ENXIO, data.out_mmap_length,
+		      data.out_mmap_offset + PAGE_SIZE);
+	test_err_mmap(ENXIO, data.out_mmap_length,
+		      data.out_mmap_offset + PAGE_SIZE * 2);
+	test_err_mmap(ENXIO, data.out_mmap_length / 2, data.out_mmap_offset);
+	test_err_mmap(ENXIO, data.out_mmap_length * 2, data.out_mmap_offset);
+
+	/* Now do a correct mmap for a loopback test */
+	test = mmap(NULL, data.out_mmap_length, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, self->fd, data.out_mmap_offset);
+	ASSERT_NE(MAP_FAILED, test);
+	ASSERT_EQ(data.in_data, *test);
+
+	/* The owner of the mmap region should be blocked */
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, self->viommu_id));
+	munmap(test, data.out_mmap_length);
 }
 
 TEST_F(iommufd_viommu, vdevice_alloc)
@@ -3071,61 +3069,60 @@ TEST_F(iommufd_viommu, vdevice_cache)
 
 TEST_F(iommufd_viommu, hw_queue)
 {
+	__u64 iova = MOCK_APERTURE_START, iova2;
 	uint32_t viommu_id = self->viommu_id;
-	__u64 iova = MOCK_APERTURE_START;
 	uint32_t hw_queue_id[2];
 
-	if (viommu_id) {
-		/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
-		test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova,
-					PAGE_SIZE, &hw_queue_id[0]);
-		/* Fail queue addr and length */
-		test_err_hw_queue_alloc(EINVAL, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
-					0, &hw_queue_id[0]);
-		test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
-					~(uint64_t)0, PAGE_SIZE,
-					&hw_queue_id[0]);
-		/* Fail missing iova */
-		test_err_hw_queue_alloc(ENOENT, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
-					PAGE_SIZE, &hw_queue_id[0]);
-
-		/* Map iova */
-		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
-
-		/* Fail index=1 and =MAX; must start from index=0 */
-		test_err_hw_queue_alloc(EIO, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST, 1, iova,
-					PAGE_SIZE, &hw_queue_id[0]);
-		test_err_hw_queue_alloc(EINVAL, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST,
-					IOMMU_TEST_HW_QUEUE_MAX, iova,
-					PAGE_SIZE, &hw_queue_id[0]);
-
-		/* Allocate index=0, declare ownership of the iova */
-		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
-					0, iova, PAGE_SIZE, &hw_queue_id[0]);
-		/* Fail duplicate */
-		test_err_hw_queue_alloc(EEXIST, viommu_id,
-					IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, iova,
-					PAGE_SIZE, &hw_queue_id[0]);
-		/* Fail unmap, due to iova ownership */
-		test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
-
-		/* Allocate index=1 */
-		test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
-					1, iova, PAGE_SIZE, &hw_queue_id[1]);
-		/* Fail to destroy, due to dependency */
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, hw_queue_id[0]));
-
-		/* Destroy in descending order */
-		test_ioctl_destroy(hw_queue_id[1]);
-		test_ioctl_destroy(hw_queue_id[0]);
-	}
+	if (!viommu_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	/* Fail IOMMU_HW_QUEUE_TYPE_DEFAULT */
+	test_err_hw_queue_alloc(EOPNOTSUPP, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_DEFAULT, 0, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+	/* Fail queue addr and length */
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, 0, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EOVERFLOW, viommu_id,
+				IOMMU_HW_QUEUE_TYPE_SELFTEST, 0, ~(uint64_t)0,
+				PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail missing iova */
+	test_err_hw_queue_alloc(ENOENT, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+
+	/* Map iova */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	test_ioctl_ioas_map(buffer + PAGE_SIZE, PAGE_SIZE, &iova2);
+
+	/* Fail index=1 and =MAX; must start from index=0 */
+	test_err_hw_queue_alloc(EIO, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	test_err_hw_queue_alloc(EINVAL, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				IOMMU_TEST_HW_QUEUE_MAX, iova, PAGE_SIZE,
+				&hw_queue_id[0]);
+
+	/* Allocate index=0, declare ownership of the iova */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
+				iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail duplicate */
+	test_err_hw_queue_alloc(EEXIST, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
+				0, iova, PAGE_SIZE, &hw_queue_id[0]);
+	/* Fail unmap, due to iova ownership */
+	test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
+	/* The 2nd page is not pinned, so it can be unmmap */
+	test_ioctl_ioas_unmap(iova + PAGE_SIZE, PAGE_SIZE);
+
+	/* Allocate index=1 */
+	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
+				iova, PAGE_SIZE, &hw_queue_id[1]);
+	/* Fail to destroy, due to dependency */
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hw_queue_id[0]));
+
+	/* Destroy in descending order */
+	test_ioctl_destroy(hw_queue_id[1]);
+	test_ioctl_destroy(hw_queue_id[0]);
+	/* Now it can unmap the first page */
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
 }
 
 FIXTURE(iommufd_device_pasid)

