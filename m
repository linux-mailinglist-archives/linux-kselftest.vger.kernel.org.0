Return-Path: <linux-kselftest+bounces-26081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B26A2D4F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6A16A553
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BF19F10A;
	Sat,  8 Feb 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAzKuQCw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E3155A52;
	Sat,  8 Feb 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005402; cv=fail; b=Jluvtk9dFUvXjS9f0KnFYhO0oPbcBDZfRFunQzH0kRpjt4FBhRH6plU8DNAIfyLTW3zUNDRJ5AGOIif/fv+h4bBKxsrQqUiqW6N1CUKxhemK6dkNmAXTdaqkbS8GUuxb31GwHjBDuwwmMuAAR+rOcGjh3JnRwXqutBi6gtoszjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005402; c=relaxed/simple;
	bh=xnRRisDOUi/9E+7KwxOR0fAbYygX8sgbIZ7sbkE4kmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFu6XL5XmdZ3ZPHpkke2JUfYKfothw4lpoJirnsDBeOFfjI5AydpvkPf571sHu2j9YWuWjETRhmnnVJ37rdjtAh70N/KJ9gX4Ysp8syFCCtUtX18XxYNo3V8UFs9G8bY5/6HjsfCrPrpYrBQA/RHIkNjh4hUzdz/aSz5jpAShZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAzKuQCw; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMaK6UPI/SnzN7hZEyp3WG4moltG0MIjL+Nin0vcgsKgl+nTfHXHDfKkNPhE2mDMBr/YdhSbb6YlK9z54xh0uAGLmHkeLNFqiCFy90pnJLLoJFtx/6lwewFh1xdO1Wu90Xs1s8vhoDm8W7wzE4Qs/jtqIjkPcRE3FFsGGmWBKsx9iOfC6uN5DlsPs5ya363gBmkfzSKByfaK/h+q/7dqecxBXP7CgRAwDB1awLMpY9xY/YScy4Zg2dJgr46Z7r8eK66hv2vuRNRnA9ysvJjKUW8p91Zq+a7YEf80YULFIugyq4bV8IIS6Xp+/OnJRV5fJGRUHwsqUL6ODEohK1vLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1swU+DWD4iLb9nDrOqt1FAkZP8c6uZvZhajtiD3NSro=;
 b=gsDjmD5bXA9vDoAW84Yc8mLQIqLn1vAQvS8V8ddK9Qxqhhdw2PK90a4QQLovZ0+LYdfEQ1qHdCe5WV09J9dW5NTlANmPOJqyk8w9JKvtGUKeoN9BSGjIFvJfrAntbg9R1WUTg5PhgaMi+eiuCf/eF/zpPkKD/eT30kLVr/S/ezd4AvR0TnlOkg7wqj88fdRj3QpP86iHPNk7/Rc8kDPwFzysEH+SJFY4sZIUuqNC7e3jDqemdlkrp2RFUG35V4JtnNRAlIFzutI/H8luDy+CA+JkxvZSe30JffKsiZA2PiEl9EvQcsmGUUQytNzavpjoEwWQj8tXKlFZghWrvbSx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1swU+DWD4iLb9nDrOqt1FAkZP8c6uZvZhajtiD3NSro=;
 b=kAzKuQCwaAlGLax/Am0vXHKBHaMV3POP9oYQVM0YrkYq8L6e7ILWPJjYzWDxADazI6f2KFAfEgHqQDcZXcQKPmHhYAYB1rzA75+zeqGQiCtzuida+yZ4KiW4Icohh6YvjasJTlIaa3d4Kk8GLLJpVrTIxQVNdvxOCAnthp+ZgypDSsUNkPksoHhza4S84xOVRN9qapUOp6FyCpOYIE+Sxm7xx25VHwx7q+fkBN6m35jw97bzdImN0VQegSNOZMxyrDH1A1JbJU/GtlOt4+lfE9ah+X7UwFBmQIYo4A8+kYk/D2WlcD5p50OcTpQxJiRGnFdNBa71fcA41NgxBLwnvQ==
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Sat, 8 Feb
 2025 09:03:15 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b5) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.8 via Frontend Transport; Sat, 8
 Feb 2025 09:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 00/13] iommu: Add MSI mapping support with nested SMMU
Date: Sat, 8 Feb 2025 01:02:33 -0800
Message-ID: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: a35cb5dd-a2b1-4a7c-eab6-08dd481f6c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOvW1DLwVunXaSs/AvVIL49a/HAPxWhsMlhIK6At6GJn3Ae9MqvXq2ctJVVZ?=
 =?us-ascii?Q?R29p9e737EG2s0ylKmjJr0nGPkWtU+3u0+gf1bQ8uC7hvn356ULSIs7unCtD?=
 =?us-ascii?Q?0dF58MNWFvX2EPtBjRAxIp6tdrHduV4WhrvSKnYGtsoQCOFwyQepLVBIE+Q6?=
 =?us-ascii?Q?OH0HjlPXn3e1JW7UzOTc6U6X+TBWuJZa5RNdt21EV1E7sPojSyzofme/V+v0?=
 =?us-ascii?Q?gkZge4/2pHRDrWAL3LfQENlJL9hsEC7rmOmRTSTyfMmjD77pWzETUg90239L?=
 =?us-ascii?Q?DuZsViAkx/msBEcwqq8oEfgNwXv8etAuP20p1Dr8aQVjRGPnlq6HsNkQ+bir?=
 =?us-ascii?Q?mnqMoRBsYwRTRmVx+nhW63gWL2ZG4INhXo45hAi/wow5VawLFrGiJonVdxBP?=
 =?us-ascii?Q?8ys8Qt6KAAlMa0VxRQCh2u7dExt3MrrCBlrXi8YpMjc35og2H4/POyPVHh6G?=
 =?us-ascii?Q?AgCHjUiPGjDB4hQSXV3TCArYsQgNFsqTNyOsuf4X5KGP+Ay+01iFsnbTPBid?=
 =?us-ascii?Q?bPHpkFvZT9ifWsmAs86CQWLQIi2txrBvntezKgyEs3VTxFGjN5+Gx6mHMqmG?=
 =?us-ascii?Q?PHHp9y1E4AWmuoD+HRkJW5irywNhAjyqEJ4HJ5GueVIM1FLGpKor4hG46gYC?=
 =?us-ascii?Q?uFZTEbkY6aZ6KurFO0LaH0pBgtaTE/ECv/ipDi3qBFDYC7oLU6gzxIJe1+gf?=
 =?us-ascii?Q?rJuz5uA7m6ryajYH9sMnpKUexDxFD/Mx1b8f90IoTIzCWhV/HpDAp6+1SsLS?=
 =?us-ascii?Q?faqmWnXzd2xdwpWb5W/7aM4ioml0V6jHjdVA/9c4UCU5cLFICXiXg+3t5lb5?=
 =?us-ascii?Q?FKf1mshqL85WDXqzPJf2HQji5/oGBN2nb8JRtGQmiHEejxX4T2iP6IG88WaF?=
 =?us-ascii?Q?6pge37DwlYDi+QFKOEbgBhkW6xvcBOQ7XRn0HMSb/69GszJlp9lg6hLJ+Jn5?=
 =?us-ascii?Q?BS3/DG8SrOQpAUWSxwPzQkQWaNJ6ytH+nJlHgds5kIYStn0TFCAkjR8sa5z6?=
 =?us-ascii?Q?uMgABmpIiGBvsTp5TsevODeOHbKrD1zkmhqQvLUUivNnspP2K496FCeVYMnE?=
 =?us-ascii?Q?1MUEOysV0ntRc7JFGP8ZnzuK4Ii30CbOn/YIbsYAc+ZzxRIbxo4qPCi8N3Te?=
 =?us-ascii?Q?lx/S5umgdxsAfH4IMa/fMDkoC4MaK/eRpjJAj9jZBqh5l+JneqmCNqsmVey5?=
 =?us-ascii?Q?eQ01cTkQXg8Y6yA3znE+J7SajELZ8Qfq+sbrkqzl7AzzFngsuSm5FElteGPk?=
 =?us-ascii?Q?YyWpn3h9F2Mrqj6F3xGntmbUk3fjtYmyRN514UVFlfzIAvj5OB/R9uQj1gxA?=
 =?us-ascii?Q?oPDIO8CIOwPCH5xL2GE42HPIPBE4h0+nDWJpFUTK0UJAI7tYx4nYrWIQvsy4?=
 =?us-ascii?Q?/qGrErpi96htoa0GePurgzin8E4RjSEm9/jSwVe4sUQ4yYQgxrUEiUNFolM1?=
 =?us-ascii?Q?nnbnJROmxF9MRqM4BF6p+TBvaJPRgRHq6wy7wa2KL7VoVsUtXPzylwgkVlku?=
 =?us-ascii?Q?ecnXlHsiaZohdlR5pfrnAxqRJFv7wUDPH5Nk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:15.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35cb5dd-a2b1-4a7c-eab6-08dd481f6c55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618

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
Though these two approaches feel very different on the surface, they can
share some underlying common infrastructure. Currently, only one pair of
sw_msi functions (prepare/compose) are provided by dma-iommu for irqchip
drivers to directly use. There could be different versions of functions
from different domain owners: for existing VFIO passthrough cases and in-
kernel DMA domain cases, reuse the existing dma-iommu's version of sw_msi
functions; for nested translation use cases, there can be another version
of sw_msi functions to handle mapping and msi_msg(s) differently.

As a part-1 supporting the approach (1), i.e. the RMR solution:
 - Get rid of the duplication in the "compose" function
 - Introduce a function pointer for the previously "prepare" function
 - Allow different domain owners to set their own "sw_msi" implementations
 - Implement an iommufd_sw_msi function to additionally support a nested
   translation use case using the approach (1)
 - Add a pair of IOMMUFD options for a SW_MSI window for kernel and VMM to
   agree on (for approach 1)

[ Future Plan ]
Part-2 and beyond will continue the effort of supporting the approach (2)
for a complete vITS-to-pITS mapping:
 1) Map the phsical ITS page (potentially via IOMMUFD_CMD_IOAS_MAP_MSI)
 2) Convey the IOVAs per-irq (potentially via VFIO_IRQ_SET_ACTION_PREPARE)
    Note that the set_option uAPI in this series might not fit since this
    requires it is an array of MSI IOVAs.)

---

This is a joint effort that includes Jason's rework in irq/iommu/iommufd
base level and my additional patches on top of that for new uAPIs.

This series is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi_p1-v1
Pairing QEMU branch for testing (approach 1):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_msi_p1-v1-rmr
(Note: QEMU virt command no longer requires iommmufd object v.s. RFCv2)

Changelog
v1
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
  genirq/msi: Rename iommu_dma_compose_msi_msg() to msi_msg_set_addr()
  iommu: Make iommu_dma_prepare_msi() into a generic operation
  irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by the irqchips that
    need it
  iommufd: Implement sw_msi support natively

Nicolin Chen (8):
  iommu: Turn fault_data to iommufd private pointer
  iommu: Turn iova_cookie to dma-iommu private pointer
  iommufd/device: Move sw_msi_start from igroup to idev
  iommufd: Pass in idev to iopt_table_enforce_dev_resv_regions
  iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
  iommufd/selftest: Add MOCK_FLAGS_DEVICE_NO_ATTACH
  iommufd/selftest: Add a testing reserved region
  iommufd/selftest: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE

 drivers/iommu/Kconfig                         |   1 -
 drivers/irqchip/Kconfig                       |   4 +
 kernel/irq/Kconfig                            |   1 +
 drivers/iommu/iommufd/iommufd_private.h       |  29 ++-
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 include/linux/iommu.h                         |  58 ++++--
 include/linux/msi.h                           |  47 +++--
 include/uapi/linux/iommufd.h                  |  20 +-
 drivers/iommu/dma-iommu.c                     |  63 ++----
 drivers/iommu/iommu.c                         |  29 +++
 drivers/iommu/iommufd/device.c                | 196 ++++++++++++++----
 drivers/iommu/iommufd/fault.c                 |   2 +-
 drivers/iommu/iommufd/hw_pagetable.c          |   5 +-
 drivers/iommu/iommufd/io_pagetable.c          |  18 +-
 drivers/iommu/iommufd/ioas.c                  |  97 +++++++++
 drivers/iommu/iommufd/main.c                  |  13 ++
 drivers/iommu/iommufd/selftest.c              |  41 +++-
 drivers/irqchip/irq-gic-v2m.c                 |   5 +-
 drivers/irqchip/irq-gic-v3-its.c              |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c              |  12 +-
 drivers/irqchip/irq-ls-scfg-msi.c             |   5 +-
 tools/testing/selftests/iommu/iommufd.c       |  97 +++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  21 ++
 23 files changed, 608 insertions(+), 173 deletions(-)


base-commit: 2b5bc8c9425fd87e094a08f72498536133da80e1
-- 
2.43.0


