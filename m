Return-Path: <linux-kselftest+bounces-24281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC70A0A076
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2975C188E0ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E401494D8;
	Sat, 11 Jan 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJ6oWdH1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65195149DF0;
	Sat, 11 Jan 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566374; cv=fail; b=BZg1rjFc3UzyHNjmvt4pvbLhTOhztoV7VAhbQ291HvbTJCSWwCtGM0N3M/D+I06A3r56wykubiXh4WOzU2zeEo4k8Lsw7+Nu9PQFLa0rl4vm7YAnSqzpbsXlZaEzGXvLjtXOyYSFAZpqSAypWqo4Vttc2o/G9IEFzVVSxT2tFlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566374; c=relaxed/simple;
	bh=VgdZU1I7JZbfE1pTg7JsfM/8SYB4mwoJnpqq8ZwL9LI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJ9Z/2GcavPs6FxJMyX4BkrBgF0l4g9CgcoNgdd7vktxf4sZcKbNHQCOza9tGAu8LbEqcBmbmZc8s3I4akjOOPPnL3flUiAGuHEAXH5Sj9L+Dt3Oq4iLawbOJFWlo3y/MEEHRuIGat3sxWv0QJI9YBwzEcyqEOa4N4E2gR+f5Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJ6oWdH1; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgHp3IClmMPJO4pTQqHADgkehDQWph//NWPPqfTn2gsrboqDqYDfBBs+XQnqW+aj59R9XVzKyzS7J4nqYK45JbGb5emSw2/SpvTLL5lQBXgDm6uEr6krSWlTvXiqnyhEPZ6soi8Il3c2fNlWVCsyqbAf1220xprubniX2aayKFaUj/L+7TEdiqEk6y4eqC6SbzQpa9Xn5cAaIS+CrsZFcXvsD80H0YEdLX8OcDhPj0nUAMasHa4jTkhWbX0BTETb3YVx/MFmzxmsQDTPjADeicbpl4tBDhVPyYbNZkkOhc4hvexII6AwxfztQ3ucBVg26Zo89NDho960TWXl3R1TAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXEoudKpywhWWdJWYCfPZ2tsB98QT4kXh4FC6A4kRGQ=;
 b=kyfnF861NrDe19ZVnlHRwAeiziwPLcj6FWHQ1OkOd86Nl66x0HdYWkU7Wp9TGnd/ZIKbzB36KRiAFTz7dE9YsZqfq3qOkjWkpaL1z0Rh9ZvbDTkXMNBLtiZP02jop1mLGL6HDHTxc9bjwWtUk6E9ehdgnOrtwW7e9BaVbbRXrjris/YCxg/kS7HUdtt9B1k7m1ZKYs7sXXALT7B2WBzVWQ69xsVZ7swiO5SzVRniAblJoBAiEDoETMtoUcVQAq1WyeDNid5GqGSCTSzejf/SLvTWSbBQ56OaWmRl9JM6HdWqrwgpgFf8cRdEejXS5xKEHVRSg1YA7hmBkbPShkQnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXEoudKpywhWWdJWYCfPZ2tsB98QT4kXh4FC6A4kRGQ=;
 b=UJ6oWdH1YhM83nkI8b8YrOPLL+t+DofNPTLUNthHqwI+Vk0rX1f4v57y/XCpfjkuv2BFIjCnkFofJGckVH1CaAxmweYcuw+z6cJmSQoxd30rbLAbylIsKhMGprOPFwZ8tD7lfBEAV9ZS4siEG6uaHJUXPxyA9yp4BfIlKPzbrQXGBMusH3ykZZlzhhJSj+svsmtsqbVCH7EMHtVvHyO9j3UeaR1fPDmhFndpRVIQttuu0SuQBMIeRcyLBTvhjgFtL9kdoqOx+9WvGgM11KCL4qH5xFGKgW5qFotFN74AgObQRsmjshETLG8b9/r84KmEN3VmUfrY8/0poaiwOPlf0Q==
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 03:32:48 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::d1) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.15 via Frontend Transport; Sat,
 11 Jan 2025 03:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested SMMU
Date: Fri, 10 Jan 2025 19:32:16 -0800
Message-ID: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: c939503c-7d33-4bee-2032-08dd31f09ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5QXUwCe8iRVr0+iFGv79hm9lBKvAVYWwQvVIZ165gXkc0UeSGm62sxHqqpp?=
 =?us-ascii?Q?HK588xwpdXE7WE/TJFwQN/ngmNVQMVaOqEIayrSAhYsk7392Htw51FuyvEmE?=
 =?us-ascii?Q?wRRXgt62iS0fw69Lu1gvp82kx9fRbxjIPdwc/TQIWSMJWWMiXwXu9CZ5P+9i?=
 =?us-ascii?Q?SjvagdOfgvaKmU1pPlbJ85UUDSnSHK8jS5lB/Awm7rKgWMglig9Vu7D75TgN?=
 =?us-ascii?Q?hcEInTXe3anNvl2ttOxqDsVdir48yPp/63XFUvxbOxf9Ug+G9qjwUILkqLKe?=
 =?us-ascii?Q?i1R8J/QqIo1u6neDcKdbdfI1Y8g1srcwYMCY68bCA3xClWFvpcm74o1gI+WS?=
 =?us-ascii?Q?96lpTHAbNzH0WxOTqLFicD/a1rYQ2/V8TMnzK92lKO7Mvji8BSdVGMXfesh2?=
 =?us-ascii?Q?ei85qWTdR151CYCMFXFr/xO2oEU7XxLIN5Bsq+xTGrCCKMzxv/5CEv5qUgur?=
 =?us-ascii?Q?t58FO7uqiNtK69todW2oy4pRJkyU9cde8yAspVxVh3fNpSoGuOaRjPW/Vb8d?=
 =?us-ascii?Q?e3UmddhJzq7Rtrp4B8HxEIFWZwm0e1ri1VMHoCKkdI1q+kuN6ulA4sqZFDT0?=
 =?us-ascii?Q?UM8AjBofH+UMN/1XtNDYgUVkeHmXwc5wzXxDHUy+sQsQiW7OTurGr17zfWbo?=
 =?us-ascii?Q?6Pbg3z0F3hKfCTdPN2BzdP88opqXiCFIlDum2yTlEpzsVfz7vyeyHXKbqwyL?=
 =?us-ascii?Q?mDWxn1tSmCaI+5bsLP/3cFMK9lBSJFAlHMuZAKiuqDqZDOOb7PIRqxJgiYJb?=
 =?us-ascii?Q?0luZxMG6EfSbMPeddImEcn7pKnd97kOjBxzGJ/AZjp5BG+nX7A15LQa/K9ts?=
 =?us-ascii?Q?NcR00UUCzs+bBR1l5MjqQvxNXGVerHVzdPPeiN2aaQLZfu4QXLr/WoD4r52P?=
 =?us-ascii?Q?llK1DXPhRxU0wyX1jF/o7E1/+N6TFbC9lEXMxNt3LtL1C1Lk9S8GFU+8S5Xt?=
 =?us-ascii?Q?cClpUtR6cLTuGQei1hKS7tbl9wA558pQsM8b6u44qYyzyhovTsf5FBBBqClr?=
 =?us-ascii?Q?3MXnyr3pvThev24uPVge66PTDZm2alB8wDmC4fUEZqMU5farQqPAd/NAWuyc?=
 =?us-ascii?Q?sYB/BODg3aiDGS9iGs8uG/nI+wgvF23Ca4ZjMcj2gGybqh/iLEu7XYV4LCy0?=
 =?us-ascii?Q?rjgNt6XJlneFmSDPmZCzrMEHCQJQ8hOw0BrygQz4CcECRNhDmNp4e1Ni91ni?=
 =?us-ascii?Q?jk85WzSpuY4Pi7G8uXe5pTIZ1oVEZmQpyGTGW/4ZdbP6JsASsiByZzZMXFHa?=
 =?us-ascii?Q?xN7SSrRWOcdho4u7gMRLqXm7mCrhcD289h2Bb6UJ8K61n5nWhGCSF/d7ahsd?=
 =?us-ascii?Q?TDmG6o6hPv1BbCqxCOShSOAmHS6Q6V/Nrz2FjfvaqpHVZXopqfEdpO1bJwKs?=
 =?us-ascii?Q?D4+NDurAHgSWi6uCylmUyUa/km/6iwE2YLD4UBvxOsXT2SfqL9ITpKxvH9fr?=
 =?us-ascii?Q?BaPQNlUSFSpFD1dFsaQLPaEZWjHv8L/c9kyBvHoNrO0eaqZqVVt8k3ceVhDd?=
 =?us-ascii?Q?tdzYWAYWfSSfqq3rN9LjQ8z+l05RHeYB6Ccf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:48.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c939503c-7d33-4bee-2032-08dd31f09ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

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

To support both approaches, in this series
 - Get rid of the duplication in the "compose" function
 - Introduce a function pointer for the previously "prepare" function
 - Allow different domain owners to set their own "sw_msi" implementations
 - Implement an iommufd_sw_msi function to additionally support a nested
   translation use case using the approach (2), i.e. the RMR solution
 - Add a pair of IOMMUFD options for a SW_MSI window for kernel and VMM to
   agree on (for approach 1)
 - Add a new VFIO ioctl to set the MSI(x) vector(s) for iommufd_sw_msi()
   to update the msi_desc structure accordingly (for approach 2)

A missing piece
 - Potentially another IOMMUFD_CMD_IOAS_MAP_MSI ioctl for VMM to map the
   IPAs of the vITS page(s) in the stage-2 io page table. (for approach 2)
   (in this RFC, conveniently reuse the new IOMMUFD SW_MSI options to set
    the vITS page's IPA, which works finely in a single-vITS-page case.)

This is a joint effort that includes Jason's rework in irq/iommu/iommufd
base level and my additional patches on top of that for new uAPIs.

This series is on github:
https://github.com/nicolinc/iommufd/commits/iommufd_msi-rfcv2
Pairing QEMU branch for testing (approach 1):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_msi-rfcv2-rmr
Pairing QEMU branch for testing (approach 2):
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_msi-rfcv2-vits

Changelog
v2
 * Rebase on v6.13-rc6
 * Drop all the irq/pci patches and rework the compose function instead
 * Add a new sw_msi op to iommu_domain for a per type implementation and
   let iommufd core has its own implementation to support both approaches
 * Add RMR-solution (approach 1) support since it is straightforward and
   have been used in some out-of-tree projects widely
v1
 https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Jason Gunthorpe (5):
  genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of
    iommu_cookie
  genirq/msi: Rename iommu_dma_compose_msi_msg() to
    msi_msg_set_msi_addr()
  iommu: Make iommu_dma_prepare_msi() into a generic operation
  irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by the irqchips that
    need it
  iommufd: Implement sw_msi support natively

Nicolin Chen (8):
  iommu: Turn fault_data to iommufd private pointer
  iommufd: Make attach_handle generic
  iommu: Turn iova_cookie to dma-iommu private pointer
  iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
  iommufd/selftes: Add coverage for IOMMU_OPTION_SW_MSI_START/SIZE
  iommufd/device: Allow setting IOVAs for MSI(x) vectors
  vfio-iommufd: Provide another layer of msi_iova helpers
  vfio/pci: Allow preset MSI IOVAs via VFIO_IRQ_SET_ACTION_PREPARE

 drivers/iommu/Kconfig                         |   1 -
 drivers/irqchip/Kconfig                       |   4 +
 kernel/irq/Kconfig                            |   1 +
 drivers/iommu/iommufd/iommufd_private.h       |  69 ++--
 include/linux/iommu.h                         |  58 ++--
 include/linux/iommufd.h                       |   6 +
 include/linux/msi.h                           |  43 ++-
 include/linux/vfio.h                          |  25 ++
 include/uapi/linux/iommufd.h                  |  18 +-
 include/uapi/linux/vfio.h                     |   8 +-
 drivers/iommu/dma-iommu.c                     |  63 ++--
 drivers/iommu/iommu.c                         |  29 ++
 drivers/iommu/iommufd/device.c                | 312 ++++++++++++++++--
 drivers/iommu/iommufd/fault.c                 | 122 +------
 drivers/iommu/iommufd/hw_pagetable.c          |   5 +-
 drivers/iommu/iommufd/io_pagetable.c          |   4 +-
 drivers/iommu/iommufd/ioas.c                  |  34 ++
 drivers/iommu/iommufd/main.c                  |  15 +
 drivers/irqchip/irq-gic-v2m.c                 |   5 +-
 drivers/irqchip/irq-gic-v3-its.c              |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c              |  12 +-
 drivers/irqchip/irq-ls-scfg-msi.c             |   5 +-
 drivers/vfio/iommufd.c                        |  27 ++
 drivers/vfio/pci/vfio_pci_intrs.c             |  46 +++
 drivers/vfio/vfio_main.c                      |   3 +
 tools/testing/selftests/iommu/iommufd.c       |  53 +++
 .../selftests/iommu/iommufd_fail_nth.c        |  14 +
 27 files changed, 712 insertions(+), 283 deletions(-)

-- 
2.43.0


