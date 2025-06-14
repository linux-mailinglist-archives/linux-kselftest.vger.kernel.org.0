Return-Path: <linux-kselftest+bounces-34979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B275BAD9AA0
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37431189BD9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1581F418D;
	Sat, 14 Jun 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Shm2MYPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B81C84CD;
	Sat, 14 Jun 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885317; cv=fail; b=gEs9oa71V6cvCvottYZllqBmukChzEqd9Z484r4HW+rNrcmILj4aW6GE5+yC6tWwkOC6udZe7jYMw73Ke/k0TnyTX4beFgNLc1LdFOCtpIXJx0gVRMHbxO09ogqoZzM4fgsC49Q0vDi9WWEH/6Z97nAY6BFzKkeFD4z7OHkPkcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885317; c=relaxed/simple;
	bh=N8Z3EJs/n0tAJeBNMKNl0WeomYA8vfMD7CO5SVV8iSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2Y6uVGCwSbVoHF80+LtbkBeulFoS3M/vq+CAx6xwGyPs9G/eka+d0tSLwxvUfZcMm1HwW82PCwHNEwo4W6RrONmGBgI1B2RxAyGpuFXXAjQzcIMGZocaL01Po6iHO9ZKMaWlG98ds+21RzSpFAAy8L2PbO1dvAe9HiYFEIleEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Shm2MYPP; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCJa2QOHLe7ehm4u/Izwl0nAxMgcvwqsXsv49MPZaSpruvL21QSnnVy7w495tPBW12SRnR/W615jn/Jj+Oda1DZ8koajxwhPHqigSolWwJlDIru2KdQ33B2HRWwrTuZLG6Mqy9HqY1XL7VgcaYCzzBXsT06DW/Nxe9rAwpfIYuNog2jnqr22twldzq2LAL53G445Vx6LCIIoHdWqGa/u1LQXrsmoUaH+7i9v8+sPizE450THdNieTUCGgxnGvTFSF7rF51X3ghQLJBVGkceieU0tYKGoiqyhclCIPg/WfjZH7BkJjC705JORTBpsepesFAerpQ/sTZEznizfv+N4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyZVqOPa2IQlNddzO883IG7iIS3zs/vZUkgVNTw6b3w=;
 b=b8zdwRsyx8RHIY0Yc9NZ2dXWtSZ9kgLYqSkCTrpso7HQWpxsWcQm+zcP/a/BkENyqa3ixV6XI+egMuxxL+qc0lyYpm5uEFWNH8zMTr11Sl9ryFSDeJvT6glwOQq8p5Xw18p/gEc9eXOp6Q91lbcbQhHW4Sag8p+3TiKT62uqSiGpBhpoHaG1vi3KuZ5d4daTAoL0BaoC0joiKOs6Lwoi4i7RwobUpL5gKy/JoSUvwW4c/wo97ytt3itgv4fI8RGhv+eGaaUXNLB5QRBsKfZryaExwnMW0bJUAGZsMjwWFX+eHE9zFdg1X+zOeCZJp/C503zuVmzg8xwPgP5k+iamSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyZVqOPa2IQlNddzO883IG7iIS3zs/vZUkgVNTw6b3w=;
 b=Shm2MYPPMwZ4OVq+p4xA5kToqB8dnxxSzLH7D00ug6joFC+ZejaqiWMRCdwLhdKz5nwx2SFPcQ9Ntvi5N9W/NCoJchqx8rZ2asdwEHURCo90sjCVJWx3wBP3j7n+9rncw8qCAnhHg+QYyl54H3kqxIXDwhq74EnHEFX9l44drgKOykI9qK0Jbh6XLQneBumo+ysSo5Vi8IFcs2m65q9afP3++i6SWPcfMX2gjuYa4tGUnGuxTi8ZgKnrFqI5XadJPlajrZe097eX8afdd/49l6tVMaGtBi620EPvggrtQtlziE01Oz+0GM6/mzmRDl07BRAAcDbKjDjbXbCQ94GP8g==
Received: from MN2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:208:23c::30)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Sat, 14 Jun
 2025 07:15:08 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::36) by MN2PR18CA0025.outlook.office365.com
 (2603:10b6:208:23c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Sat,
 14 Jun 2025 07:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:14:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:14:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:14:53 -0700
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
Subject: [PATCH v6 00/25] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Sat, 14 Jun 2025 00:14:25 -0700
Message-ID: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3883bd0e-513f-4a38-1ab6-08ddab1331e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mionrk1tmFAZenYGWqVrE26KE5APBmfwJtpMzCW3xYE4yA3KLrxqUoFaGpOn?=
 =?us-ascii?Q?bZCEQHYP996UWMS82l5Wo1lqIrwMekr2Ien5iiGcUI+c6CHkw9GsSky/0Faw?=
 =?us-ascii?Q?xo6pZ84m6pwMggw2Ssxmgrhld6tfPCCdWBxhGvfNhc/xxGCrcALu8/PRZ3kb?=
 =?us-ascii?Q?rqflYSQ8E4cSpZGxmrbUx5IjnxWXo4KG9fFjmuDexsadx4g2C13PfVfOLduq?=
 =?us-ascii?Q?kOphwxZsNBzxaky+cI8223ccy0If73Drm0VMCIxgFtONVsmkz0EdZCCB2Na/?=
 =?us-ascii?Q?KkW4kRyDg28E9QNiFmgsXr6q6TA9Rpga5THGJmHz5+SB4uaSWIfqxHqzxeZ5?=
 =?us-ascii?Q?96YYtHxr3c0w73vd2Qr6zHWwxwSM2lLzcJT0acotb8+X0WVNL6heGaWN4ebT?=
 =?us-ascii?Q?RThgSFxWILDvXjid2WZENZ5tg60GpBNu5OsJ9Xhib6dzQgZWCByL6TtaWbH2?=
 =?us-ascii?Q?gnS7DuSejKa4hJv1oEPukZ5KIt50/HzYqIa+n36H9TC1Zjd+9qGdCxsCj80b?=
 =?us-ascii?Q?25K5gWEpBsVYtOVX/mtzDyRbSdTO889qK0qXXc+gNszMmW7tzR/j4eWhHgU2?=
 =?us-ascii?Q?knY7LfKzMLdqQVvnhouLrWXJJuDxdHLLow1auan4/7B+6HmN1eP+CBTB+I0x?=
 =?us-ascii?Q?OtfAZ38+Zsk61fFTxf6ZbpfGCURuOqSXkrdFrDNIYtv9ZZKpvz+Zp5MJOuOg?=
 =?us-ascii?Q?VGRoFP67X+dg+42NyIrTgw2F3Ucuss2+L49zrFgN751Udmn2jKDetQuqP8zT?=
 =?us-ascii?Q?/qamPN8xDIiShnttNSzdRVSFJfbZ+3jI3iFwVB9ikrkFvWzds59wQyFZuz63?=
 =?us-ascii?Q?2BFO+dVoOWHED71c4YQuhrBW/XlHT0jQEPHY+MJ1F1oW2edHGEUnWJo7kXZ2?=
 =?us-ascii?Q?b0SJy+c39ub6otzZ7HuGD97JzDGyANb6xRnHv3EhnhQ3C9VIL7GkbPoFAiRP?=
 =?us-ascii?Q?VQrTbBvIQVAmV2Z/yVg87/v/jZVxnvNUFvpyAkKOB82Jyg9h9C3r2U+onniF?=
 =?us-ascii?Q?9U2jvMac4kjCILg+yVl38aFmfLNCbEQ6ksP3/MUAZFQ3u2tnoFODSo4KZrYB?=
 =?us-ascii?Q?9OqtQjDuuAOqCbK22AUfFnyTPizMyv9cEfK9tlNnCL/xVNGefRnxTRNppjpc?=
 =?us-ascii?Q?nZNhHSH9pzDc7p6EANEndd+pREftSK+zAjk8E3LRW0Z6XzvZHRQEUNkQ1moK?=
 =?us-ascii?Q?lEWw1Z2SEaU6pZkrcZILKmgJ7fOZptxxnv4vaRjYYVnLyZHXw5ksJsvZR1E0?=
 =?us-ascii?Q?vCoXDd+bwHPosySm3rludsTMnK6v+B8GmcYIBmXBK7S30SZ5RAfSPTM3oDER?=
 =?us-ascii?Q?z1Og35zDbcSUdlBT5F/5yT0obykUgS62xgz9uOlNrsaDHNY1msfcSSxdoy6b?=
 =?us-ascii?Q?9/BlolP80DCjqYGChG0zYVfNz6ckXKEm6AgJwLweH+pE0wAjp6L0gZvpC4mX?=
 =?us-ascii?Q?NirQYsESSbYl9sYWWCokfBKPeyAwHeSx38vVKNcTNRqm5WxKyrnzXrdMlgIW?=
 =?us-ascii?Q?8cVlqVBMAuzSQMSqd27nysS7azQ20Tm9/64T+ugRZu1H4redXNYXwpOXQQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:08.4426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3883bd0e-513f-4a38-1ab6-08ddab1331e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

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
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v6

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v6

Changelog
v6
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

Nicolin Chen (25):
  iommu: Add iommu_copy_struct_to_user helper
  iommu: Pass in a driver-level user data structure to viommu_init op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add coverage for viommu data
  iommufd/access: Allow access->ops to be NULL for internal use
  iommufd/access: Add internal APIs for HW queue to use
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  16 +-
 drivers/iommu/iommufd/iommufd_private.h       |  35 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  49 +-
 include/linux/iommufd.h                       | 156 ++++++
 include/uapi/linux/iommufd.h                  | 145 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  89 +++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  25 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 481 +++++++++++++++++-
 drivers/iommu/intel/iommu.c                   |   4 +
 drivers/iommu/iommufd/device.c                |  84 ++-
 drivers/iommu/iommufd/driver.c                |  79 +++
 drivers/iommu/iommufd/io_pagetable.c          |  17 +-
 drivers/iommu/iommufd/main.c                  |  70 +++
 drivers/iommu/iommufd/selftest.c              | 150 +++++-
 drivers/iommu/iommufd/viommu.c                | 218 +++++++-
 tools/testing/selftests/iommu/iommufd.c       | 143 +++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  15 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 19 files changed, 1708 insertions(+), 100 deletions(-)

-- 
2.43.0


