Return-Path: <linux-kselftest+bounces-36905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC153AFF8B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E397B8533
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 05:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E354287271;
	Thu, 10 Jul 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RndceLmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD61F948;
	Thu, 10 Jul 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127209; cv=fail; b=DHjdZclsDCsTLGMFaJnuukIxKNnXhcUQuWX2ldtNVItwzJMRbr96Vr0bMnLJ8AsN0OvTj2wL1+K6SNiCl5KHb3NxejYIY6bvBGKV7G2T8fkR69pJHUnP2YoHi2tA+S21uodxMoy+RxIJgx8UpoXg6ewMQGn6GlF0+ifKv7g53b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127209; c=relaxed/simple;
	bh=DjEs53CgkX+5gYx4Hbb+F1Zdm79QrMB7EHMSN5hAyOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i+2N15/DFaXi/EhjmcoafHNovVJPC3URQkVIpFH0KKpINWvFg9x/yIn7VAUCx9a3hcKssKCPrGlqNsxtojPooxfYF3BPfbLQmg3IvKmDLEWT3hBbbko8IiWiiMNAeqPaXR11oZZkZG8wxswKSvQ72nq7ePUVkYBAkIXq1MCe9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RndceLmF; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7WsR2cBxCCBWc5JKIJdwRkO1qfN+/7KWbHUKVwcmCpGHAIPcl7WcFwIYcJ8j5XXlf5WZ977I4sSulRDIPZ1c3aPjO5gH1vZrZeMey+OEqyh0AUG4OUaKxHLiFIQY1oGQjzx2/KdIimrXdpjBcskL9i/FgRyH0p3bsumiel2QfbNAR+Vnwz4d5SAewTWAB7kzoYK3UAQbIicjXr0It56QB5rvj2QSA32C2o0qKmKD3FOx66gS14WwyWGFDCr3aG7XUnh7ryjBYVQ8YdGP0VZxiVBdldcJGr1TMjVYpVonfHxT5/GfW8y7Y4O+74jhCLI/qe+gxGYJbHHhqZMfSwkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+LIoVq7w+eW2lM6Y3duxXQzYZaa5oDdhbHVlXmb8x0=;
 b=iQrDBDSdl/aYANCrQdUUoxIT27bo9fn6mAwa+qsKhecEpYtyRFeY2xfQf/WKhLy17JhS4KSqKBfomlNS7ZN6m6mHQtNoYvtKzM3c9tttw9QCgYeMfpwatYFfoLV5xsT2QRClPOf9sEBK55lFSkzZ0octE/lXaeKqI0bSjwE2qIGdBIdH8tvG16aZ9aNraCTOiUuGmwlzxEkPWs/lWS86kkUTrKyBl5UxMPw0EtRclbuUqS/bsCuyHFC9EmyRx+k6mpKwyqU+eDodS34pAN5o2CsJXqzpiOI5XgJhTDpmXtGm3IY5sRg1+34DIB3B22Kwp5VFpW+ByqLp+9d78kmlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+LIoVq7w+eW2lM6Y3duxXQzYZaa5oDdhbHVlXmb8x0=;
 b=RndceLmFIJ8/RGFBSteVN9ruEVQXoTClMp/RJNvFUaiBI5Z6mTHlNZvJoanc222LkQBMNKJ7+yHyqsWckdO0D+1ieLiBir7vf0ATIhHOpor9yC0Gj0m8iYRgJOnAJcbimcxciDfw07omzJS6wLX7X0oqudP9RDXi9UNnFlvtHXyurx1x7QZK7/DbHh/iUX4nO1dnlZIaf9/vYXbr/Y2wMqZKcEajEU17vWZty7yLcW4C20KyOrCh/ZnbgACkffY6wQ2z7OKzjd8vwFisCFAi6LDjVNFbOm2O2OVfSEGPrg+WcBEIc4o2P9jBmmfQ/sniwkFdcy3vKbQPspznCq8FjQ==
Received: from MN2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:208:1b4::21)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:00 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::b4) by MN2PR15CA0008.outlook.office365.com
 (2603:10b6:208:1b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 06:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 22:59:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 22:59:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 22:59:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 00/29] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Wed, 9 Jul 2025 22:58:52 -0700
Message-ID: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 32315aea-0710-4ef3-c492-08ddbf770168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6D4RX9JF/HEIYdKSerhYyiPUoUFwGQ9S5DIdMm3ntlIwedHovu2+TIT7V9E?=
 =?us-ascii?Q?DTI7qaInAi5Qow1KrZWFZA3vKDE3s3oUw1QJWaMi1LXA4mcvyTM0c7PSDWGz?=
 =?us-ascii?Q?6Bg2lUTEPEphlWDeYq9bicphs1J1CwAbv3eAMKuyZuvyJE9QHD1mt0T3/gbA?=
 =?us-ascii?Q?j1e7sRKWOBMC60xQ5DpeBB20oECDsJ0LTNS7N276KdIZriYzK0gyPwWb2Iuy?=
 =?us-ascii?Q?1k5GT7a02OcyBtksjzbhQEc02bfLHjXPZfrbNns0LPF1NJsoDGzPcJDhEZUO?=
 =?us-ascii?Q?JY6v7oAknHVOFOMvjAofL0BeyI143DRdxzHyI/Y1mXzQ8RzFUtXvRcD4bglg?=
 =?us-ascii?Q?9Xc5uX5UxSNBGn89rDI/eK7puhfvC2BzyTER/TvBf+gUoibNRBioh8pF2/ow?=
 =?us-ascii?Q?kO1Gms0de0P/0w1MN87q1JC9z2yp8hY839natEv/DRQwuRCqBptS3QQtUF2T?=
 =?us-ascii?Q?aiVrTLWSwtY4kSDqRnfL2vEWvet0/nZO5CvHUJXnNcr6ZESdK/z1Gya9yteK?=
 =?us-ascii?Q?+WWQqhPAPG9rIVPFNZ3+tnq5BhQseYy+nYYAmF50Zn502I4CvpWX3uHk4CQC?=
 =?us-ascii?Q?efKaRXZEvdyLTO1xpPMFhrvzpvVMXNWmGZvHGb1K3lyXkAIddPnyQwN5hMhP?=
 =?us-ascii?Q?hWaoiGJYh0p8EElQAUQ2auimfnEYos5iXUha+cLd1gcQbN5x/w03wqvK8t62?=
 =?us-ascii?Q?sdb25x9ec6+Hu/vF+/zPphuIxr43hzNtTXZy0v/EReT8DBHrRztfc1dZcoE5?=
 =?us-ascii?Q?v1IRYBHFxwOZ7c95DJIKGRy6/OQwhDrF43JXbgaD8hEYoEfMQ3X1ugHkBP9F?=
 =?us-ascii?Q?IBUwcDvRYLK6t+SoLOQgbTVn1dnA2QZosiKbPRh2nmhlOnjt+Ph13TI593SV?=
 =?us-ascii?Q?ra9pknUXnp+t3XN9Y20WRwiU5E9qDKughfGyVNibiJP5yak/BYvFuV/hT+ZE?=
 =?us-ascii?Q?Ro2lRgh+XOy5cmXFXpuANxL/qy7TeguD2bX4hghrcE38hFhZ+zfaRriFP5iT?=
 =?us-ascii?Q?pb1mZnuIthtHaC691xQ7RnevETg+RODxIMDMpiMzMphc5QvUEwYdP2F74/aE?=
 =?us-ascii?Q?QCUdOypRpYh9O28WmKmdHlP2NVz2eNj7RHNQaxFxp+AE7xTm+ZQ99sgIUTHZ?=
 =?us-ascii?Q?5TMehG6Jsjju9SRK9BHLaByLt5PZ4Iv1hmlfNuokezUQGHMxqmSRh+ndDmbA?=
 =?us-ascii?Q?p0ATBk1Q3ZJFcAtgdS+qOTpNlYr1yRegHQQ/Z6w3yPIIXLT46WfcEgf3x9vC?=
 =?us-ascii?Q?2tL7u2e79ScY+xIul2ZDxN21p5fmO1otuD4g4ncAq2lxqdfwCeGTeDdylwa0?=
 =?us-ascii?Q?Hq2HgeHfh7fVS0N4/qtufvVGYPuqja5Hz1OTtpZXF5rRTxnq/Gfb4VqthiEL?=
 =?us-ascii?Q?QdOuYGna1TXaHtSF2sEKiZ2XjI9bwobgL68FUEEiacVH+ePJz8kZL3oCZeVW?=
 =?us-ascii?Q?L4TuadaYhimjk8mmUGfpxt8TsSdMs9hWO3x/zd7/7NjgAcag9Vbq+KiFdiDo?=
 =?us-ascii?Q?86u3T9DAYm7iqXwhN35Y9zf3VlyXIex7bC4AJk+/jpQHFwmveKEXq8p+FQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:00.0165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32315aea-0710-4ef3-c492-08ddbf770168
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

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
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v9

Paring QEMU branch for testing (reusing v8):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v8

Changelog
v9  (attached git-diff v8..v9 at the end of this letter)
 * Add Reviewed-by from Vasant and Jason
 * [iommufd] Fix offset calculation
 * [iommufd] Add unaligned iova/length selftest coverage for hw_queue
 * [iommufd] Pass in aligned iova/length to iommufd_access_pin_pages()
 * [smmu] Change "u32 *type" at arm_smmu_hw_info() in the header
v8
 https://lore.kernel.org/all/cover.1751677708.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Pranj, Kevin and Jason
 * Improve kdoc and comments
 * [iommufd] Skip selftest for no_viommu variants
 * [iommufd] Add unmap coverage for non internal area
 * [iommufd] Skip the first page when mtree_alloc_range()
 * [iommufd] Correct the passed in index to mtree_erase()
 * [iommufd] Correct variable types in iommufd_hw_queue_alloc_phys()
 * [iommufd] Reject iopt_unmap_iova_range() if area->num_locks is set
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
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
 drivers/iommu/iommufd/viommu.c                | 218 +++++++-
 tools/testing/selftests/iommu/iommufd.c       | 141 +++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  15 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 21 files changed, 1745 insertions(+), 111 deletions(-)

-- 
2.43.0

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index aa25156e04a3..3fa02c51df9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1045,7 +1045,8 @@ struct arm_vsmmu {
 };
 
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
-void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
+void *arm_smmu_hw_info(struct device *dev, u32 *length,
+		       enum iommu_hw_info_type *type);
 size_t arm_smmu_get_viommu_size(struct device *dev,
 				enum iommu_viommu_type viommu_type);
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 00641204efb2..91339f799916 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -206,7 +206,11 @@ static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
 					    struct iommufd_access *access,
 					    u64 base_iova, size_t length)
 {
-	iommufd_access_unpin_pages(access, base_iova, length);
+	u64 aligned_iova = PAGE_ALIGN_DOWN(base_iova);
+	u64 offset = base_iova - aligned_iova;
+
+	iommufd_access_unpin_pages(access, aligned_iova,
+				   PAGE_ALIGN(length + offset));
 	iommufd_access_detach_internal(access);
 	iommufd_access_destroy_internal(ictx, access);
 }
@@ -239,22 +243,23 @@ static struct iommufd_access *
 iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
 {
+	u64 aligned_iova = PAGE_ALIGN_DOWN(cmd->nesting_parent_iova);
+	u64 offset = cmd->nesting_parent_iova - aligned_iova;
 	struct iommufd_access *access;
 	struct page **pages;
 	size_t max_npages;
 	size_t length;
-	u64 offset;
 	size_t i;
 	int rc;
 
-	offset =
-		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
-	/* DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
+	/* max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE) */
 	if (check_add_overflow(offset, cmd->length, &length))
 		return ERR_PTR(-ERANGE);
 	if (check_add_overflow(length, PAGE_SIZE - 1, &length))
 		return ERR_PTR(-ERANGE);
 	max_npages = length / PAGE_SIZE;
+	/* length needs to be page aligned too */
+	length = max_npages * PAGE_SIZE;
 
 	/*
 	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
@@ -274,8 +279,7 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 	if (rc)
 		goto out_destroy;
 
-	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
-				      cmd->length, pages, 0);
+	rc = iommufd_access_pin_pages(access, aligned_iova, length, pages, 0);
 	if (rc)
 		goto out_detach;
 
@@ -287,13 +291,12 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
 		goto out_unpin;
 	}
 
-	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
+	*base_pa = (page_to_pfn(pages[0]) << PAGE_SHIFT) + offset;
 	kfree(pages);
 	return access;
 
 out_unpin:
-	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
-				   cmd->length);
+	iommufd_access_unpin_pages(access, aligned_iova, length);
 out_detach:
 	iommufd_access_detach_internal(access);
 out_destroy:
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9d5b852d5e19..d59d48022a24 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3104,17 +3104,18 @@ TEST_F(iommufd_viommu, hw_queue)
 	/* Allocate index=0, declare ownership of the iova */
 	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 0,
 				iova, PAGE_SIZE, &hw_queue_id[0]);
-	/* Fail duplicate */
+	/* Fail duplicated index */
 	test_err_hw_queue_alloc(EEXIST, viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST,
 				0, iova, PAGE_SIZE, &hw_queue_id[0]);
 	/* Fail unmap, due to iova ownership */
 	test_err_ioctl_ioas_unmap(EBUSY, iova, PAGE_SIZE);
 	/* The 2nd page is not pinned, so it can be unmmap */
-	test_ioctl_ioas_unmap(iova + PAGE_SIZE, PAGE_SIZE);
+	test_ioctl_ioas_unmap(iova2, PAGE_SIZE);
 
-	/* Allocate index=1 */
+	/* Allocate index=1, with an unaligned case */
 	test_cmd_hw_queue_alloc(viommu_id, IOMMU_HW_QUEUE_TYPE_SELFTEST, 1,
-				iova, PAGE_SIZE, &hw_queue_id[1]);
+				iova + PAGE_SIZE / 2, PAGE_SIZE / 2,
+				&hw_queue_id[1]);
 	/* Fail to destroy, due to dependency */
 	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, hw_queue_id[0]));
 

