Return-Path: <linux-kselftest+bounces-32700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E1AB082B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843C19E1340
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B5239E9D;
	Fri,  9 May 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCBx6WIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F0237717;
	Fri,  9 May 2025 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759802; cv=fail; b=GKKXeb9udlu90Fosww8z2U2Pz4atAEd4EFE1fVEbpXm3oiHpwhMxnzLrPlBdQGBhg2JBziRL9yk0ClQbq6ol51FU4K6ZwNCJJ/4E7JrH/omQdfQkxbeFquxOMBEcE9M/NQHItIsBET7hEajSzYZ/sRR/CpHOQSA4GGMbefUHeNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759802; c=relaxed/simple;
	bh=oSJPn4CVmHgqYV/MauCBbiqABSjegYAseRKgIVjXZWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYJ7VQlcgAWz8kl+MuWxNU1TlKrjsU9AYNnQg79/0udg9V8y1MfXK0/1bCv1XBRoRKBGqi2ruxqUdBNhCSrtORmDTxX4iqTn3feLoGP+/XIuDvDY0585srYHNXTjSFMWQH+xqUy8mkbiYvekiI5+v5DanG/6GAL7Tu2+vcbzSKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCBx6WIw; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5siIkfZDbcqHN4ykP5kI1xgn3fRCwBopA7/83nxSh0B+xtU4Y97a305SsJhm0kNjeOCn7yUR2cPGvVFneN6KoEPwBZZp9tS9uYISGIvNcVc0KbiUMeyiViCXRcG2GCF+yqp7NI/bDt5MsvIwo7W3NqakiLSZjn74IMhgZf/B09NQhpYnD8c+fbX800rgruYWt3Ii/dQYAUiYas7K8G1l2a2HjUWrYiHzDGVUKrFjrfpkrVOkTze+MlU9FMC1J/awGkYhYWKMw7+sBfcPbreeE/ahaWAE51lVWcG3+r1wgyz/vaWt7dwGFXsB0Jbc2y/ohbdhDVD71E7VNd/R5D/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CDfkjpuAVETKVxddC5uWFp9/4sB9OtVMaY17UblVtI=;
 b=IFmMCqi5BAt15+v0pAJkbacRomMBHwWYFEWjal5UAvmNUINiEpkTlQmg9f59aySq/2V0/0tDxKH9jWGHblK7s6bldRnWkwvupPAN+rB1mE0o9TPwvVHIGWV7s4Ijf8bOVktLIDVGhP7Onzc0xWQ7bN3nLpdJPlI/I/nYAiEQmxgCSwHMZvNGsiudmk/8S9ts7YAzFIbrO9czQm3IA4FOEu/qMasL15XPuwPRswW1oTA6DOtCvvxY/QyUve/FUYBDITzBfpr82Qtj9BBKcLZM/gR21gAQYupDJp4SFmeXHNo9Zm/zKY0HRqxZsOVoQIVv3v/ErxlOLZzex9F4gNyN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CDfkjpuAVETKVxddC5uWFp9/4sB9OtVMaY17UblVtI=;
 b=QCBx6WIwSBsfGOkAe1vCNQx2JhdjHO3JULoiWotD+RMpDwqr/m4pj/d8nnwVVvSw308/SBHCTbHrZ/XUImDmO981eZqZg919iLdWTiV1yYmYVI2nPnC3JuyIP4I4rhH7proBlkFRvQNE1QYyk1v6yqgRH9tXlaAQirq5o/qM0h64mVz3i6NckSk6Q/x9rMwU60Ve5B5c9TMnPCaDbX7G0VrKgxS78JYJMqlfPBvX/ZyN835vOTxKPPtYsrqYbsRY/33XoPEDfO24sQ0YpOobHS2m03IbSJEnzRAuY7VFutVSw7gmJygR9hd4/PP73XF9zS0Wk/FK8eLSDPUcUXMalA==
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 9 May
 2025 03:03:06 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::1c) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 03:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:02:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:02:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:02:55 -0700
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
Subject: [PATCH v4 00/23] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Thu, 8 May 2025 20:02:21 -0700
Message-ID: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9a510f-9f6f-4e68-d8c4-08dd8ea6051d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQAOFwBstBfziAV630NQXk/cifAYJskJpqufID7Tdy4SbquFxyNxkkbvKPVX?=
 =?us-ascii?Q?zB/7AHRZgFnVR7bvsapzqYEAuecPY2m1ABmCAOYGIcP0hINgQLtfu3H0ci7v?=
 =?us-ascii?Q?BIH4JKN4tLsy7SlP9BPgPHpQ53HyWXlwOAhHLsbwA+/miVWpb/wuuZ+1HTv8?=
 =?us-ascii?Q?88N4F7CVOFGEc/JHc74TS6D1cYKh2RvUk/IEi36FCwOAi5sCGIHO37LNE9LQ?=
 =?us-ascii?Q?bb/4nyoDdSEjFpeqCaGTZiQdk33Gp0AimBhhEgv5wfpBzc3kPMxQAch9gfZx?=
 =?us-ascii?Q?UZyR4ls5qrGTtvWTJsSk7tuHqrU12xj+i90pfLfCErsvJLQEx6aExScqQTfj?=
 =?us-ascii?Q?Qn1AbcUcHWre01a21tmvm7rwg9UCDCuzoZftVbQ5HtiDVcC3RUy1MK+zuE/6?=
 =?us-ascii?Q?nZwhJTGMOXf/T4fEm1dST/L4+0lAVGTF0Ukh7AeobY1IB0WRhfMB0WzOsje1?=
 =?us-ascii?Q?LYvvnsExZB6F5uwmA/OqPv9XF16nZ3sWTOTxH8R20f+tk5JRxwTfTKb7d7O5?=
 =?us-ascii?Q?qHRJ/OqHlZ97wQpg6JVmr1J1jLcVYYevWcKBp7iZoXU/lNrVh/3wO+ylr9tK?=
 =?us-ascii?Q?X2TwCHq8E1AfjrVHTd9+08rODs8kz8YKedpt0dJIX50qebBK76JRXXHn+rSX?=
 =?us-ascii?Q?o2tQFY3gz8rin0KVJCuXPzG9Acu2JDA9W2CLCgQt3HQuBD6Hkps4ZhnrMaya?=
 =?us-ascii?Q?EXA1AobzBYHCTgqYhYgeKzp1corbIJ6UtKNeTjl/oR0h8G9Hr5yVecRf58Ld?=
 =?us-ascii?Q?Y6mQlgUiXlDjX+AP5MLg0r9gYo40QKHY5yY1guGiEbl408w9bvMPWk4Rw14Y?=
 =?us-ascii?Q?OBvi6jH5xfjLU1tKbfFxLCN3Mibc4ckxvGuPirT0e4AkZ9Ku0x5vpXPfqIY3?=
 =?us-ascii?Q?dSOUow2XhsFTx8staAYrcH247bWFvPMUBz8sPFj+M0IslDEc/4cCZq1h3nal?=
 =?us-ascii?Q?0qNxWezkueeqLF9EOw6wb/hKCUhGpukkJp4ssRetcb8igRlDndJP5aTyncDL?=
 =?us-ascii?Q?VFKwQN+BkPn6dlLS8bvpG86ujKeXxZYJppmxkkAhILQKwK29Pu7rH6Ugv8Lc?=
 =?us-ascii?Q?vyIuPpJWkjycN1udmjMy2Be14x/Ds8rokNg6apH1Qcey6Q4T6VP/EYonh66U?=
 =?us-ascii?Q?v1dimkH1hptwPGgVjRa8dm+tscTlgZNphoZtKacQDUE3JJkjw09xF+Q3UHVO?=
 =?us-ascii?Q?ZSz2G1pJaHXb4MjFo5tZ1uqOuHHIG3UR9mr09jwj59bCkHpIpizAHvSLqZ4i?=
 =?us-ascii?Q?WxB5SpnVam/4ZIBp0G+5RYqndlN7m6mS7fpU64WWwhwkxprtOmDtV5OMkaZB?=
 =?us-ascii?Q?/J9byMHtqNt1T6WSfAcicXCmSEORbC9U2Rd77+hxA7r7J8ll5UdgqmttoYiE?=
 =?us-ascii?Q?E37Y5zk4g77Ku41yIQ9gTdYEaSWDgq/nnsm2Sy67GHHyaMa5v1ahl+ldvDvR?=
 =?us-ascii?Q?JtiQaSNUUeWqJ2CZ8PJgxqyU+jtcanqxOccOa2QsfI2RECdAFUvnbE4DUXT1?=
 =?us-ascii?Q?+87zmdD26G8X6mHwcEafxL+FJlrOccl2IQ0uNqr8RiFoX1ojor1s1Wu82g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:05.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9a510f-9f6f-4e68-d8c4-08dd8ea6051d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

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
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v4

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v4

Changelog
v4
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

Nicolin Chen (23):
  iommufd/viommu: Add driver-allocated vDEVICE support
  iommu: Pass in a driver-level user data structure to viommu_alloc op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommu: Add iommu_copy_struct_to_user helper
  iommufd/driver: Let iommufd_viommu_alloc helper save ictx to
    viommu->ictx
  iommufd/driver: Add iommufd_struct_destroy to revert
    iommufd_viommu_alloc
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add covearge for viommu data
  iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
  iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
  iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
  iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
  iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
  iommufd: Add mmap interface
  iommufd/selftest: Add coverage for the new mmap interface
  Documentation: userspace-api: iommufd: Update HW QUEUE
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
 drivers/iommu/iommufd/iommufd_private.h       |  28 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  43 +-
 include/linux/iommufd.h                       | 186 ++++++-
 include/uapi/linux/iommufd.h                  | 116 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  52 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  43 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 490 +++++++++++++++++-
 drivers/iommu/iommufd/device.c                | 117 +----
 drivers/iommu/iommufd/driver.c                |  94 ++++
 drivers/iommu/iommufd/io_pagetable.c          |  95 ++++
 drivers/iommu/iommufd/main.c                  |  80 ++-
 drivers/iommu/iommufd/selftest.c              | 133 ++++-
 drivers/iommu/iommufd/viommu.c                | 121 ++++-
 tools/testing/selftests/iommu/iommufd.c       |  97 +++-
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 19 files changed, 1577 insertions(+), 194 deletions(-)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.43.0


