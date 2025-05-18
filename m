Return-Path: <linux-kselftest+bounces-33256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEDABAD22
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F907ABEB3
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F01922F4;
	Sun, 18 May 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqeXx2zV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF22AD00;
	Sun, 18 May 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538534; cv=fail; b=lIKeQ6pXfSluz7RFT6EA51UcJXBr34ye+1i+w2t92U7ytS80AirqPWSQgVguvn/o+h4abTrujvtCoBFqvG9Y17k7qRhY1GrQ3VXS1qPMi3o4GuALeRrCnZ23mZMCzUhzX8FUxCJoywXv7QoHJCBhx5gyYSr1xJmb1Ger9q/IGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538534; c=relaxed/simple;
	bh=/lfySOD8p1UjFerJ8MmVaTl1YGdIuVSOm/FEv4STEIA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULuqIDdmz9e/b5XSBeMun/zcwjyq41KgxC54OyWAkLUFf+ambfXXE5xTSH/UKcRxbBhcpBFrvEzWuS5T5orE3qUxER1KW/YqKmr4sxxFqbxLKMEsEjOAccrzugvRXs47z4c4MS2/mhj6MFguw/vf0WZyGI1W6/WEJ5HXlm8Jf7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqeXx2zV; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTXi6CWP7rUgxOX1rXK5EQtXKi4FleZKcRlKzcRTR36YSRiOb/v1F6p5xLqHKogYSoerO5jEnzOxj07ytWo4EYJwO3mCzYkpXjp7ya+disNk/sakaKZW/hbjpH3envUsFwIvnraaySkt9vaGewGbiRvHz844JCIiujT8ssfUdzTg841b9y+1UEpKV5ZMHdhmRl9mBJe9Qxdz3zZhbODMqz86ODPiH/oFQpg4KT2stWPBweQKsgsC93MbQUSP0Su1Jf6roJr0HqrENZnksgXTeTJFbNJZEReFgZb3Fe138Z8vbSSZSzIer61leNEFUY7mkC7ST1+GVHTA7VHHiK7C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spCWpFezkymLwYyKagVWaQ6z08021+QhHBicUSoX3EM=;
 b=sAGONKkskCaWX+nxc5IdhzUR7Pr1HfphaH5d2AcBaI6ksmfNnw9XqHBDsHO6jF+o1m+n7K8ALktOgGQpe2ALWmj96nqqj3HQvfa8VE5XOEQkUSk9tCt/Vpo0fvw/fyGaDP2/2wi5ApJfnHtD235hoLbE9/+gPV73GDUAaDoUU4/GPVjqJ/b/6swdK0wxIJ3qa5g9f5ZY/vg1GhAkEVwnSGqRSt9QTN6Wu45VeyD2z/5YqwwfQWkDwqF6dEjPtfB0zFAFbHpugFZSQPGwB5YG2U7/y5AbAGexxTzCfGhEkV2Y1joM9zRr1W5Gu2wQ8gneSdhu64HeIoFGDp2DHEzt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spCWpFezkymLwYyKagVWaQ6z08021+QhHBicUSoX3EM=;
 b=HqeXx2zVg1oCqbEnxuf2rwmGQbJpO/UEy4rXh/GBBMOR6PQyXy2p5Zc3lqGgYpAMCKihnQ81VWebYwxZb/hGH2mI2lXL3IwghEn+h0cDYDEQdsOEPS5eGRjX+qaWzjtuF0fQtEIRI82DamHbuKs703k+8rAFrP2c79l39FBLJRpiLzanRrbEBtLa0+fgIulUIFPoRGxeYSq0edKg+jZUfClpB8ga+cTIL7dmHSppC9J3y4zl0c5R6TLgg8Hgbq/klEbVTq5FPMqgVMw+3+epM5SZetmnDQVg8i0+oEdMejCsdYY1r/QaoB4TMWMfLKCyoQCe6rb5KOz+P1egAniUJQ==
Received: from SA0PR11CA0089.namprd11.prod.outlook.com (2603:10b6:806:d2::34)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sun, 18 May
 2025 03:22:06 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::7b) by SA0PR11CA0089.outlook.office365.com
 (2603:10b6:806:d2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Sun,
 18 May 2025 03:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:21:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:21:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:21:52 -0700
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
Subject: [PATCH v5 00/29] iommufd: Add vIOMMU infrastructure (Part-4 HW QUEUE)
Date: Sat, 17 May 2025 20:21:17 -0700
Message-ID: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf4917b-41da-45a1-2b28-08dd95bb2aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5x65hqSjr4S462P6F+U8foRzmbuJCU2hcnNPiYT3mL4KwgFdR1dBlQ9FN79?=
 =?us-ascii?Q?iwFjYvabdHc9WqJ3xff3CGi30qqanuT4u8Qt6GTAEoI2Hs+p7ksIqlPMpYlG?=
 =?us-ascii?Q?WJq0A2LNp0B3b/xJwjcfe4S9K0YZq5Jn8SnYO16IRmioU7OnJfeLsKsuM3T9?=
 =?us-ascii?Q?WADMzaokLvKjATwcUL/0VGmjR7g871oT3oyEb7fExfxrwps3ox7ayrWjRnkI?=
 =?us-ascii?Q?Y90jqVeEst3Djni4MHxUjPWer/5qlfcNdIz60+V0jPW05NYQfDr4GQS6KR1a?=
 =?us-ascii?Q?CWhIf89VQXoHV4XnJ4ulfHQAADGJ8w4s2iriQqNDhGvFwXG/t/xi5PvAMnVF?=
 =?us-ascii?Q?05PrDws8d/X5ETONDnsw1s9uGUIwaXvNrNCnUTMyENvGfFFfCBTsYPgOeUqr?=
 =?us-ascii?Q?V1PQWF0Gfe22rNMduCcBsKus/ZgiZnxXj0hBwWN5wxOgTbg0sItZBfag17zR?=
 =?us-ascii?Q?l+ZYZQioW7Q3XZ6AJ1HoC6rsS75f4rME6YZ+p0ycc/eB5UZUjw94WucJLVoz?=
 =?us-ascii?Q?PVQoO+vJk17peDpGfN9tkmG7lWES9hstK65XuVLdqAs7A+ie01ZqBLuluBcr?=
 =?us-ascii?Q?Rz56nl4C8FSAJLtiG6dGUZKc43iWWkVgp8qLSnG2cMCtcKgykfxyHDucFmgV?=
 =?us-ascii?Q?ZJ2fGJSsxDM+q20SS6NbetJ3wluunRFR2t9MM8VfVhrRAmjx9hwhptrSc6Bn?=
 =?us-ascii?Q?xY59uC4VXdB1bnXNadNGp+LkLotKrHt3jRKUJndHnTAHSqAz3Fj1+bD2VNQm?=
 =?us-ascii?Q?5l1UdEHkasIGiocNHAbwkOgerWVQWVwI77XeWSf7nYTF7sJ5uyjnyq4ipfO4?=
 =?us-ascii?Q?Ho1UaxrVOuJpfUE32MWpdNmzZvZs5WmytACwycvk7KNWzvipE1GyFebjYeGQ?=
 =?us-ascii?Q?/Z6QDvhp4h0kCgf6AHIEIQMN7Lsk6SHB9Cu2/uDZh13wogLHSPxnIryWgEcW?=
 =?us-ascii?Q?qL22tJ5GrbRQg8xA6TiITL0u3Bz7OlzzTf5aayoyXVX8KW/bs/VFMQTa8234?=
 =?us-ascii?Q?ofYcUuyEzhYKJhTTQ7VZ52JvhhILHAzHUkvvlzw+9a7tZ0eeNj+3wVZPTO5z?=
 =?us-ascii?Q?mP/h12/2EiyqKKz54WZCXVj7dNksG8UhOj2kvy/GF+IlQElxsqYZucqJSP7F?=
 =?us-ascii?Q?thGk56wKZ4Z+ddxMmKsB5JELnmTdjvnRqXzE/9zmCOKI3mx8y3UMfrZAtXa4?=
 =?us-ascii?Q?X8cqtrkzHz0opzQTOVyOuNabIncTK6ukQXAcFDIsU4IUFq90xV5pD1dW6YGc?=
 =?us-ascii?Q?XqVVWLJc9H8EI6WM+WdyfeZuro7UnW1B2l2vsSLYAXd64GlhEYUxbQGWDON1?=
 =?us-ascii?Q?gXs7v+GCSK2f7vHHrnNUXqSlr+M0poGc9Nin9TLSVnrDBDCfHQEuvr4Ha9Tg?=
 =?us-ascii?Q?cG9gpt+Qjj+v5us0SYTgxBtWFHu6k3krsyadzliZ2eabGx4AbbJAtWgQBRso?=
 =?us-ascii?Q?Q5onggkh7p7/8Riq2KCQUBpW3D+dMz3TZZHdi2J+UwYqpP8CFIfmLYRxbzV5?=
 =?us-ascii?Q?zq5lkFnBAL8MhZHWzfI5gKvYKi5h6EjrQ8MKwINABKibgkf5KePpf4oJ8w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:06.3004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf4917b-41da-45a1-2b28-08dd95bb2aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

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
https://github.com/nicolinc/iommufd/commits/iommufd_hw_queue-v5

Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_hw_queue-v5

Changelog
v5
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
  iommufd: Apply obvious cosmetic fixes
  iommufd: Introduce iommufd_object_alloc_ucmd helper
  iommu: Apply the new iommufd_object_alloc_ucmd helper
  iommu: Add iommu_copy_struct_to_user helper
  iommu: Pass in a driver-level user data structure to viommu_alloc op
  iommufd/viommu: Allow driver-specific user data for a vIOMMU object
  iommufd/selftest: Support user_data in mock_viommu_alloc
  iommufd/selftest: Add coverage for viommu data
  iommufd: Do not unmap an owned iopt_area
  iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
  iommufd/driver: Let iommufd_viommu_alloc helper save ictx to
    viommu->ictx
  iommufd/viommu: Add driver-allocated vDEVICE support
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
  iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl op
  iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
  iommu/tegra241-cmdqv: Use request_threaded_irq
  iommu/tegra241-cmdqv: Simplify deinit flow in
    tegra241_cmdqv_remove_vintf()
  iommu/tegra241-cmdqv: Do not statically map LVCMDQs
  iommu/tegra241-cmdqv: Add user-space use support
  iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  28 +-
 drivers/iommu/iommufd/io_pagetable.h          |  15 +-
 drivers/iommu/iommufd/iommufd_private.h       |  41 +-
 drivers/iommu/iommufd/iommufd_test.h          |  20 +
 include/linux/iommu.h                         |  53 +-
 include/linux/iommufd.h                       | 221 +++++++-
 include/uapi/linux/iommufd.h                  | 150 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  91 +++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  33 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 496 +++++++++++++++++-
 drivers/iommu/intel/iommu.c                   |   4 +
 drivers/iommu/iommufd/device.c                | 137 +----
 drivers/iommu/iommufd/driver.c                |  97 ++++
 drivers/iommu/iommufd/eventq.c                |  14 +-
 drivers/iommu/iommufd/hw_pagetable.c          |   6 +-
 drivers/iommu/iommufd/io_pagetable.c          | 106 +++-
 drivers/iommu/iommufd/iova_bitmap.c           |   1 -
 drivers/iommu/iommufd/main.c                  |  80 ++-
 drivers/iommu/iommufd/pages.c                 |  19 +-
 drivers/iommu/iommufd/selftest.c              | 158 +++++-
 drivers/iommu/iommufd/viommu.c                | 146 +++++-
 tools/testing/selftests/iommu/iommufd.c       | 146 +++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  15 +-
 Documentation/userspace-api/iommufd.rst       |  12 +
 24 files changed, 1794 insertions(+), 295 deletions(-)

-- 
2.43.0


