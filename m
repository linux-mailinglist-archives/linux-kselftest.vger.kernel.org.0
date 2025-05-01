Return-Path: <linux-kselftest+bounces-32111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70DAA66D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742263B14AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EC235076;
	Thu,  1 May 2025 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ShSfhcMv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63F38385;
	Thu,  1 May 2025 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140512; cv=fail; b=oMrpB6TDoe/M4YDFogbJLv/BV3BXF2w1fwZ3t03la4E0bcRbumrgbJDRwL1ISq+nPZj38m5cJXXPO1r5FOgScVZy0q/9HwKVIEWCqyonAfBrir+QSYCqydf1CmaxdX0hOQUueUQCdYs8cmlo6s3HlNcp7j3AyYtleuVFB7JNpoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140512; c=relaxed/simple;
	bh=+i6YMupICgczTO+gWpcfn1FmRVeGs+ESo5adjTYf71Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SkUJyRTC3lZIJRyfXI+JFvGbrw5tEQ+/yRsY2LdQz8iWCvk0PdtEslYeNXTVmy69XyiA7mhKBxQaTaLkNZDg9cX7pXJj/LCzKzCY7AvgDe2aAu74lrJ4FXqXGADkRyj/70osyhynWeG+k0XJW1NWB7bbCkem+tp/AfEIoIL4kPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ShSfhcMv; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAHe5ya6jSEyP+FQngSX5yCXAg9BzZezdhN9r7v8TTF1PKW8Rf+HKDXW8WM+R0cABmsc7t8jX+NK4qfKJnLTAuHdVOs4+FUVN5LjZ2YJHhit3KA3sYbi9BE3CcNhVND5gN9N9mz2hUT3pGAAyHL00hlCJPLg6zP9MwJSOhCipRyduiORMNDg2BEG2m2nZRTcVJHYdma8wXUULYqPdMquzkmHKtmNJ93DN4f5F1j1BL4XkNCKlFujdlDqIM1VNqazdssui3U4j1jP8/A4v7FGc7Cdrc6C099KuxnmhoEDHEpzPA5sokmEorebKNZx24kb7uh/EAu3zKX3d8kM1PtjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAbyyiccN+v8CQT6cEq737dypptlAGv+FAL54/IG7OY=;
 b=UeSnZ9OCoZbAMOni9vmxbfTS13vNhztr6ScFYxKlS1twaleBKa2TooteuW75CAU1l5X7ZtgjWMxlLuH1+19NstMMG0fzQNi8Lsvoss/BEDH7TlF8YEMjOMewK5Y8G7VCbWIcEyGoydTxEVJjAmJiEJGyzhkYHz0nr6kktEOXmjeA4fu/ccljJjP/D/gfnkZLOI18PnevzpNcfJOwy2UieyBrKP7mBmEaOOPX18bFlc+6J1ZZ70NSRrktAV/KggwJ6Du2Rp9q72+34I4aKU6qAwwJx2ocZNAEf4bMFocYldKv09vRwsrunvFSYU/03NphXv1xzcBRkCAq06mbUhkeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAbyyiccN+v8CQT6cEq737dypptlAGv+FAL54/IG7OY=;
 b=ShSfhcMvPwYz6YfuAxBBDLIr1aFNOPE/4ixAmbJTQde2ZgQ3FuhWQG26dh/BJZcmRYgWnCJ2ROvXLmUL4ZaB6uK4GVSz2HK3Mrj0yl57PjJc0BClepeLQ3gZfeHHXr0dIj1988NK2/a+7KtxhnvCzCQDBI7N9hbypPwfM66CdG39CRqwNSntiufL8HxRCVezfu0kz2ytp9R5aP69S0+Lws1JnRNeXDUntd2yVRTvW8i0rJBjpaBdbQMGPmXQSLe1daze5Kr2AlQz8IrJcs/h4u3+yeSazoPtAtijrdCj+IVdE1adL+yW9ltA38Ny1S7zTJniYJbSexWjcptQDSCMKw==
Received: from CH2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:20::23)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 1 May
 2025 23:01:45 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::c3) by CH2PR07CA0010.outlook.office365.com
 (2603:10b6:610:20::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:01:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:33 -0700
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
Subject: [PATCH v3 00/23] iommufd: Add vIOMMU infrastructure (Part-4 vQUEUE)
Date: Thu, 1 May 2025 16:01:06 -0700
Message-ID: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f88cc3-c2fe-4e61-17bf-08dd8904254d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gH25y/NgxanU5KD2068diYdda9a4iaufJoSO1qRBs0J6Xxle2B/FV2hMpWIJ?=
 =?us-ascii?Q?u7qzMslKsSKTFCnZAszEcFAIBGThDN8zNwmH7ger+2Y7G0UnBzhNZXsNByb6?=
 =?us-ascii?Q?u3x2ioOP9TW7UNcQZSwiTGhfqP2EWufWsuJtFkGWbbEKZtBX8i90Fg//vQB/?=
 =?us-ascii?Q?J1mSxjm2c6SgMwyyv0uwPfpg5Q+3GLjnoX0o2kxaKwvSmRfWfQTzAcpVPj2t?=
 =?us-ascii?Q?1kcAp8Mcmplp4lwTLSjSZ3r3hvTBv3OCdyO/jdFgGTQ7TExvedm3U0bPw+xp?=
 =?us-ascii?Q?3jmryDN/trC4RsOF5QLvuj152YNtu3N3iyDG6wisNFKkjLvvGCL7sHmY4FKv?=
 =?us-ascii?Q?VxfW3gjUAI5+qyZDpPDglWcuWotTooANXCiJ8fNfkJUESg12feVWt9NTjfpq?=
 =?us-ascii?Q?la57FY3kCRyr10UseFjbpzyN65eTsH12u6CZL9GNx2JcZSTVIxpVvsdaU/sB?=
 =?us-ascii?Q?myVIUKvFGkTYE6Q8hDzW8v3cqJWKGgJF3SBk+c7z4oPLUKdiIicnVmjdxkqJ?=
 =?us-ascii?Q?NkbS752hJw5bXd3VgdHmUl6CuvASamsQYI3G0fFFnhqQcfhw6fg1q2nplMMZ?=
 =?us-ascii?Q?Jx8CPIUSCwAg9+K9osuZQaHj2Y0e+7SGrKkFKoDOlQymbS0AJoe2Zr28DFBa?=
 =?us-ascii?Q?r8GkC2tIshUGbpm7Lj5lWnI7ZM0QbymIBUZns/gNLM9owBdgYgRtgSYWAkfX?=
 =?us-ascii?Q?U8YrgJhhHm88rZDT5nwumVcGyOy0v4wr0XGFIZKznat041ySaeNNiMb3t/Am?=
 =?us-ascii?Q?CvaHfHnwybfvn42YSNl3gIEtLBYoUVXYFDQs2boxAlR9h+45xlFh5bUpQmqt?=
 =?us-ascii?Q?kHbAF/6PFkhUqbji41We8V9EJ6C1Q/3uf0bRnqi3ecoRvIQDYDYVoH45gwLU?=
 =?us-ascii?Q?zBmhJ/vPsWgqqjqbElPbXwPFQFWFPvRG5OIXOarqwQi3CaaBiI6bt62cHuXw?=
 =?us-ascii?Q?Iqzu1eOwFoptnx5HcOtp6M41XHSeg6eDyssstxsvzDNwFzohe85jKAXdgih4?=
 =?us-ascii?Q?xGQNN4DD8R7raoKDFZ2EWOVsVvqoNdkbOEMiLwGAvvvfOpRYYIyV7hrltJFZ?=
 =?us-ascii?Q?aD7D/TQIEvfZbM3kof8ykJUowh7c7OBLtP2+cIm1zWR3cevTQd07yDXZQHns?=
 =?us-ascii?Q?O+cSH378PdZ28HFJwZd/er/iuxxNl27p/LfCp9Hj4aLzxhvACNkmpd1fupd3?=
 =?us-ascii?Q?KdCDDeuaNWJ2ZRBbyRjEFvRcYp/IKBlZy5I1CsCgJz7ncbhclgqsSpVRP7lE?=
 =?us-ascii?Q?X7wgQm5aHQbv12RXsjgcnT7mhwK5jXhGEpr3QUoVRHFGyCUl6JAXtKd3QazE?=
 =?us-ascii?Q?qO2prcVpAL4w4qg9LsKnQoTnScaUbDA4+n6dhq9XOkc8jZ5ZQdhWuIE3fJCD?=
 =?us-ascii?Q?vAcXDoY0hJn3Vn0aqYDSHtfc9/b0LguWZ58b54jAHRqPaUGleGYqGOLHlXTF?=
 =?us-ascii?Q?TTSmGQ31q5hvO4jNIdXzLE9CB4WBmKzEFeb9XDFA23jXEX+1g4Hlcgelol5a?=
 =?us-ascii?Q?Au8EwhZnPT5Ilw2Ke9GEvgCot6bYKLKl/waP0EWH1JByZ4ZAwadz2gyvLA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:01:45.3590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f88cc3-c2fe-4e61-17bf-08dd8904254d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429

The vIOMMU object is designed to represent a slice of an IOMMU HW for its
virtualization features shared with or passed to user space (a VM mostly)
in a way of HW acceleration. This extended the HWPT-based design for more
advanced virtualization feature.

A vQUEUE introduced by this series as a part of the vIOMMU infrastructure
represents a HW accelerated queue/buffer for VM to use exclusively, e.g.
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
each of which is an IOMMU HW feature to directly access the virtual queue
in the guest address space, to avoid VM Exits to improve the performance.

As an initial use case, it adds support for guest-owned HW virtual queues
that VMM can allocate per request from a guest OS writing the VM register.
Introduce IOMMUFD_OBJ_VQUEUE and its allocator IOMMUFD_CMD_VQUEUE_ALLOC,
allowing VMM to forward the IOMMU-specific queue info, such as queue base
address, size, and etc.

Meanwhile, a guest-owned virtual queue needs the kernel (a virtual queue
driver) to control the queue by reading/writing its consumer and producer
indexes, which means the virtual queue HW allows the guest kernel to get
a direct R/W access to those registers. Introduce an mmap infrastructure
to the iommufd core so as to support pass through a piece of MMIO region
from the host physical address space to the guest physical address space.
The VMA info (vm_pgoff/size) used by an mmap must be pre-allocated during
the IOMMUFD_CMD_VQUEUE_ALLOC and returned to the user space as an output
driver-data carried via the IOMMUFD_CMD_VQUEUE_ALLOC. So, this requires a
driver-specific user data support in the vIOMMU allocation flow.

As a real-world use case, this series implements a vQUEUE support to the
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
https://github.com/nicolinc/iommufd/commits/iommufd_vqueue-v3

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_vqueue-v3

Changelog
v3
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
  iommufd/viommu: Introduce IOMMUFD_OBJ_VQUEUE and its related struct
  iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC ioctl
  iommufd/driver: Add iommufd_vqueue_depend/undepend() helpers
  iommufd/selftest: Add coverage for IOMMUFD_CMD_VQUEUE_ALLOC
  iommufd: Add mmap interface
  iommufd/selftest: Add coverage for the new mmap interface
  Documentation: userspace-api: iommufd: Update vQUEUE
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
 include/linux/iommufd.h                       | 184 ++++++-
 include/uapi/linux/iommufd.h                  | 117 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  52 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  42 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 481 +++++++++++++++++-
 drivers/iommu/iommufd/device.c                | 117 +----
 drivers/iommu/iommufd/driver.c                |  88 ++++
 drivers/iommu/iommufd/io_pagetable.c          |  95 ++++
 drivers/iommu/iommufd/main.c                  |  84 ++-
 drivers/iommu/iommufd/selftest.c              | 126 ++++-
 drivers/iommu/iommufd/viommu.c                | 116 ++++-
 tools/testing/selftests/iommu/iommufd.c       |  96 +++-
 .../selftests/iommu/iommufd_fail_nth.c        |  11 +-
 Documentation/userspace-api/iommufd.rst       |  15 +
 19 files changed, 1555 insertions(+), 193 deletions(-)

-- 
2.43.0


