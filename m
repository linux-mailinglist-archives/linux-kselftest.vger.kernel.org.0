Return-Path: <linux-kselftest+bounces-35915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7DAEA706
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF8117BFB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE242FEE17;
	Thu, 26 Jun 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dlr8j7hU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C762FE388;
	Thu, 26 Jun 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966573; cv=fail; b=Rbl783Bm4hPUCwxc6D21qI2dj26nHwEIdfJR7z7O7Y3yDe7APuLpT1cF95z6iK3UfdNuq3rUS0WUJK9N54FC+scIMBmnUmGlAL9DzXtEPPO0z0Ut09+T4lfsOGY2+ZSAOILCOwJ6oEMKy9PQ8B3IRxV1N5Rq1YntU0GSlq+x4aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966573; c=relaxed/simple;
	bh=rkcr7wcYOHxzXc1e3VBoWVjyNCiHunKHfBa/i52WFNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHaq9ne7TJhJyqPPuQY9kGhV/QuTplrll5fs30TAIjjOwJP4IZeswauQWCv4j3SsZTuQ8r+l+PUwfUyMew/KA8A0h3m3nm03SQdWTqHv/5SUi7Es5zjlRde31yEk540gaHPbmr8aukv3cHhSTgk8JkxCjNQD6+DpiarT2du+jCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dlr8j7hU; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI7xBUaPvS5EUP9qGjfyzX7Zt0Y/jxyXCH/5bQ3aCxrjMX++CbSFVmVH5nFBkHgCENmZ6396mVmsv6+4pTvqjwMha2m4zm+KRO+XX2fazghu7GazGY021bz2hghR44+1ZcPwDgYsG+Fzx9cNXwDybz0pEF2DIgII57mpS+M+CrmHmU5kjf9cnoYxyibD377MsIphzentNFJPsnnUqNhfIxtLS5KBzsNcDbJuL7AisR/2AH3At9Q2AWqbUotPSB4yxZZ20oGGJmkhvwwzEvSo19z3KYR91TWNNm0tl/FufCHKMFq5SHXRfcZ7ke8qQgcAbyl2ePTrUk7bM2h2YC+7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wuKNlpDk6aL1kjc3au61C9aAKSsMH2HJuvD1Kooi7o=;
 b=bVa+dpT6HrAv0hSN6H53dT2LBZzuSMh5xraNncdDnKLydyuY8RuS8Pa6fWB8NmA/CmQtkWDdO3lSg8AtoUVo6mSub0FUeah3aTtslolNSo0y5NrzNYY0and3OSL77uQ8FlWW8qVnBP1ctAwhXdEej2E9XQBAYtJfHBxSPg7wwXM9fWijVn/Oa0zmWkz/Hbknn7GtIx9ckHie7BhqCbQpCWnYb4vOQjajhuyDrMo2gIrzu/npuuEWACcCtDLdzgeyBSsfzY8cPtrUA/vP801Xs/x67kzmtdnkPsrhky+XMaNRvD7UqpIgiVGOYQnkPUyk1PR0y722hNRJXgvMX1bkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wuKNlpDk6aL1kjc3au61C9aAKSsMH2HJuvD1Kooi7o=;
 b=dlr8j7hUz1u9C0vhjxrcnYL5vtLN1rQa1Z/WaI3CUdjtjK4dK930hXeLu7nLjwxtNcFTAjg8UXnlZM12kYfBlPjgiO+c+u9tC6FrnIM9nyBfhOKRx0yE1JPePEfP4VQoGcUdVzYnQg4LckyXpRFQRpxnu8MldQnF02NZXYNvqAP6eTPq2Dk6QywNXglB6NK/tokn4nn4EcbohPMYGWFKemb+16GcJPj/AgR6MnnQCHmU0sINCQ/R7vyKOjJuWaq91zEgh7Uu9VaMZfDnc/06Db6wjIFsE6UkSvALiNJoeah4TIJ5KO+1Uc1b238G4lEGnejP5x8ppyCsXMiEdUONkQ==
Received: from BN0PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:143::15)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 26 Jun
 2025 19:36:04 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::a8) by BN0PR10CA0024.outlook.office365.com
 (2603:10b6:408:143::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:36:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:44 -0700
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
Subject: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Date: Thu, 26 Jun 2025 12:34:58 -0700
Message-ID: <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2fc4e3-6204-46cf-75db-08ddb4e8b051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbg3senYO35FOOpU+Q3NQihl6SvLgaWzcYKc2UtdFvO9vXePvAkoMfoZluZO?=
 =?us-ascii?Q?10mi3wQnlXv6S5Q/D6TOLGxbCbUstVMYSXBf2P4xSHa4YrQuZ1fNOju8CtB4?=
 =?us-ascii?Q?tSCgKiddV8newWP1o0b6gN4jUd/QmAezyNS6RTxi94xHBr8Zc5tKr+lyIpV9?=
 =?us-ascii?Q?+Slbz0MhMetOZM0FHUhtQELdJcUMvMnxo6dvwFYMY7BXl3iqiY2Xi7lONZaW?=
 =?us-ascii?Q?VzRdhFxJZHWmCG0qQR7Mlt9v35ejL/UaNBUNpOCZI0K+Uswf/l0M9wsG9r8Z?=
 =?us-ascii?Q?VNWvwKPFcrAKNmjOtZOIarIYuLOxgwZ2w7CJBI3OZpUBojWN8I2Lp2PtIvKj?=
 =?us-ascii?Q?SOUsInKzWHnHTahyyEvtyPi8R6mHLkbOjAoFBpRXJSGWl1GhdLrAjl4bcze6?=
 =?us-ascii?Q?4eyKK+De0INaw2sXG6lfDnFlMcdg6E/71WiddDai9UyIwNUQtNNbQVOu38/k?=
 =?us-ascii?Q?ewKDupCvCY/YC3RCz89FAT8KkkKRFfNPUhh04XgaJ/Dr4kvdclzkvzT7h/1j?=
 =?us-ascii?Q?A+z4PqGaeJ7s75uXCd/FdSd+HwfgumknQiRHeQgVtvXG8JSgolU58JR35oCk?=
 =?us-ascii?Q?9ixE2dEwRFT5SulPj40xKGSYFRHv6lqFuHYwbmrU9ttC/che0+o2TdNmYkGM?=
 =?us-ascii?Q?hw1By2lW0rm29TyarlfjeVh0LGFJkl28laVxOW6P2bEHjrjTsLymKY7y/QoX?=
 =?us-ascii?Q?WhHMy+nVOXbqlvC8pbvg/o8rAcAE2h9Pwa3W6417HiWUDjnyHLZGofohslIw?=
 =?us-ascii?Q?+Z8UI44xtc2tpayySHzoiRnFqzPgp13fqgw14nyMelCBT1Ghz1q48CIK3e3N?=
 =?us-ascii?Q?T9rK+L5Xy5unwYWV9CYzjHP+6hTZVe915hN1GZwlX0IMPWIo2zPZzu+qhXf9?=
 =?us-ascii?Q?wPkVMDGShWzYgxDwXzLVLG8UYOmlHaK8QTK7qyeJVu3bx/s4/7H3do83G9/J?=
 =?us-ascii?Q?u6dihyilXoypYfl1Cvzd5kEaG9rDqv2iCs9jX3UsjfRxwJx9zYhwZFL4OgKB?=
 =?us-ascii?Q?isdtS1U1KKCjc6CSySZ+4ns2si0bGjBlAq8ylYDw21cay6cUUy5CegEbI6Nz?=
 =?us-ascii?Q?xRi+9lZhEgnii9ByJw2txZyWMoBDhHjUwk+sy2kD3Qs+XH1cawdT+zY0gQDV?=
 =?us-ascii?Q?eNXJke1GxukM1fny8mFKA9TeJdrgJA0ALGTsSjtODaBpgX4Cu6ZwuC221H7E?=
 =?us-ascii?Q?CdQRYMFMI9B9auEU8CvgGBe50O3jhgSNgPI/fYelRphdjxTCE0t6FV7wTNWO?=
 =?us-ascii?Q?43RnJArdMSF/iC4DhafiBhSrQEmNwDgoXTiTC8leo8ONABWD6fl8yTqknxxQ?=
 =?us-ascii?Q?73FuQ+W8zFtWY7Xt6yi1TuG7A9tbfCNTSLj2Y8YGFRfSuMXdwxCTRfEGgor3?=
 =?us-ascii?Q?F5L0Bfl0K1e5QLDNHh3BU3ZtzWQ3P8W2iHYqIgFyiTACvhVNrCtDOJnS0s38?=
 =?us-ascii?Q?5XcvxIoKqoz/uU+4CTEU7ne3vNaYQO3Xf2MyLfnf53rq+qV5EbxPOYTXdqbb?=
 =?us-ascii?Q?LR04cqAu+0DiKxOcpUwaXcJak3bXZJpwqT7P?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:36:03.8162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2fc4e3-6204-46cf-75db-08ddb4e8b051
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

The CMDQV HW supports a user-space use for virtualization cases. It allows
the VM to issue guest-level TLBI or ATC_INV commands directly to the queue
and executes them without a VMEXIT, as HW will replace the VMID field in a
TLBI command and the SID field in an ATC_INV command with the preset VMID
and SID.

This is built upon the vIOMMU infrastructure by allowing VMM to allocate a
VINTF (as a vIOMMU object) and assign VCMDQs (HW QUEUE objs) to the VINTF.

So firstly, replace the standard vSMMU model with the VINTF implementation
but reuse the standard cache_invalidate op (for unsupported commands) and
the standard alloc_domain_nested op (for standard nested STE).

Each VINTF has two 64KB MMIO pages (128B per logical VCMDQ):
 - Page0 (directly accessed by guest) has all the control and status bits.
 - Page1 (trapped by VMM) has guest-owned queue memory location/size info.

VMM should trap the emulated VINTF0's page1 of the guest VM for the guest-
level VCMDQ location/size info and forward that to the kernel to translate
to a physical memory location to program the VCMDQ HW during an allocation
call. Then, it should mmap the assigned VINTF's page0 to the VINTF0 page0
of the guest VM. This allows the guest OS to read and write the guest-own
VINTF's page0 for direct control of the VCMDQ HW.

For ATC invalidation commands that hold an SID, it requires all devices to
register their virtual SIDs to the SID_MATCH registers and their physical
SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
lookup table to replace those virtual SIDs with the correct physical SIDs.
Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
structure to allocate SID_REPLACE and to program the SIDs accordingly.

This enables the HW accelerated feature for NVIDIA Grace CPU. Compared to
the standard SMMUv3 operating in the nested translation mode trapping CMDQ
for TLBI and ATC_INV commands, this gives a huge performance improvement:
70% to 90% reductions of invalidation time were measured by various DMA
unmap tests running in a guest OS.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 +
 include/uapi/linux/iommufd.h                  |  58 +++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   6 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 407 +++++++++++++++++-
 4 files changed, 471 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 836d5556008e..aa25156e04a3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1056,10 +1056,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
+struct iommu_domain *
+arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data);
+int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+			       struct iommu_user_data_array *array);
 #else
 #define arm_smmu_get_viommu_size NULL
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_init NULL
+#define arm_vsmmu_alloc_domain_nested NULL
+#define arm_vsmmu_cache_invalidate NULL
 
 static inline int
 arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 6ae9d2102154..1c9e486113e3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -591,6 +591,27 @@ struct iommu_hw_info_arm_smmuv3 {
 	__u32 aidr;
 };
 
+/**
+ * iommu_hw_info_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Hardware Information
+ *                                (IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV)
+ * @flags: Must be 0
+ * @version: Version number for the CMDQ-V HW for PARAM bits[03:00]
+ * @log2vcmdqs: Log2 of the total number of VCMDQs for PARAM bits[07:04]
+ * @log2vsids: Log2 of the total number of SID replacements for PARAM bits[15:12]
+ * @__reserved: Must be 0
+ *
+ * VMM can use these fields directly in its emulated global PARAM register. Note
+ * that only one Virtual Interface (VINTF) should be exposed to a VM, i.e. PARAM
+ * bits[11:08] should be set to 0 for log2 of the total number of VINTFs.
+ */
+struct iommu_hw_info_tegra241_cmdqv {
+	__u32 flags;
+	__u8 version;
+	__u8 log2vcmdqs;
+	__u8 log2vsids;
+	__u8 __reserved;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -598,12 +619,15 @@ struct iommu_hw_info_arm_smmuv3 {
  * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
+ * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                     SMMUv3) info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
 	IOMMU_HW_INFO_TYPE_DEFAULT = 0,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
+	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 };
 
 /**
@@ -972,10 +996,29 @@ struct iommu_fault_alloc {
  * enum iommu_viommu_type - Virtual IOMMU Type
  * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
+ * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                    SMMUv3) Virtual Interface (VINTF)
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+};
+
+/**
+ * struct iommu_viommu_tegra241_cmdqv - NVIDIA Tegra241 CMDQV Virtual Interface
+ *                                      (IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
+ * @out_vintf_mmap_offset: mmap offset argument for VINTF's page0
+ * @out_vintf_mmap_length: mmap length argument for VINTF's page0
+ *
+ * Both @out_vintf_mmap_offset and @out_vintf_mmap_length are reported by kernel
+ * for user space to mmap the VINTF page0 from the host physical address space
+ * to the guest physical address space so that a guest kernel can directly R/W
+ * access to the VINTF page0 in order to control its virtual command queues.
+ */
+struct iommu_viommu_tegra241_cmdqv {
+	__aligned_u64 out_vintf_mmap_offset;
+	__aligned_u64 out_vintf_mmap_length;
 };
 
 /**
@@ -1172,9 +1215,24 @@ struct iommu_veventq_alloc {
 /**
  * enum iommu_hw_queue_type - HW Queue Type
  * @IOMMU_HW_QUEUE_TYPE_DEFAULT: Reserved for future use
+ * @IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
+ *                                      SMMUv3) Virtual Command Queue (VCMDQ)
  */
 enum iommu_hw_queue_type {
 	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
+	/*
+	 * TEGRA241_CMDQV requirements (otherwise, allocation will fail)
+	 * - alloc starts from the lowest @index=0 in ascending order
+	 * - destroy starts from the last allocated @index in descending order
+	 * - @base_addr must be aligned to @length in bytes and mapped in IOAS
+	 * - @length must be a power of 2, with a minimum 32 bytes and a maximum
+	 *   2 ^ idr[1].CMDQS * 16 bytes (use GET_HW_INFO call to read idr[1]
+	 *   from struct iommu_hw_info_arm_smmuv3)
+	 * - suggest to back the queue memory with contiguous physical pages or
+	 *   a single huge page with alignment of the queue size, and limit the
+	 *   emulated vSMMU's IDR1.CMDQS to log2(huge page size / 16 bytes)
+	 */
+	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1cf9646e776f..d9bea8f1f636 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -225,7 +225,7 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
 	return 0;
 }
 
-static struct iommu_domain *
+struct iommu_domain *
 arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
@@ -336,8 +336,8 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
-static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
-				      struct iommu_user_data_array *array)
+int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+			       struct iommu_user_data_array *array)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_device *smmu = vsmmu->smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 869c90b660c1..e073b64553d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -8,7 +8,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iopoll.h>
+#include <uapi/linux/iommufd.h>
 
 #include <acpi/acpixf.h>
 
@@ -26,8 +28,10 @@
 #define  CMDQV_EN			BIT(0)
 
 #define TEGRA241_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_SID_PER_VM_LOG2	GENMASK(15, 12)
 #define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
 #define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+#define  CMDQV_VER			GENMASK(3, 0)
 
 #define TEGRA241_CMDQV_STATUS		0x0008
 #define  CMDQV_ENABLED			BIT(0)
@@ -53,6 +57,9 @@
 #define  VINTF_STATUS			GENMASK(3, 1)
 #define  VINTF_ENABLED			BIT(0)
 
+#define TEGRA241_VINTF_SID_MATCH(s)	(0x0040 + 0x4*(s))
+#define TEGRA241_VINTF_SID_REPLACE(s)	(0x0080 + 0x4*(s))
+
 #define TEGRA241_VINTF_LVCMDQ_ERR_MAP_64(m) \
 					(0x00C0 + 0x8*(m))
 #define  LVCMDQ_ERR_MAP_NUM_64		2
@@ -114,16 +121,20 @@ MODULE_PARM_DESC(bypass_vcmdq,
 
 /**
  * struct tegra241_vcmdq - Virtual Command Queue
+ * @core: Embedded iommufd_hw_queue structure
  * @idx: Global index in the CMDQV
  * @lidx: Local index in the VINTF
  * @enabled: Enable status
  * @cmdqv: Parent CMDQV pointer
  * @vintf: Parent VINTF pointer
+ * @prev: Previous LVCMDQ to depend on
  * @cmdq: Command Queue struct
  * @page0: MMIO Page0 base address
  * @page1: MMIO Page1 base address
  */
 struct tegra241_vcmdq {
+	struct iommufd_hw_queue core;
+
 	u16 idx;
 	u16 lidx;
 
@@ -131,22 +142,30 @@ struct tegra241_vcmdq {
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vintf *vintf;
+	struct tegra241_vcmdq *prev;
 	struct arm_smmu_cmdq cmdq;
 
 	void __iomem *page0;
 	void __iomem *page1;
 };
+#define hw_queue_to_vcmdq(v) container_of(v, struct tegra241_vcmdq, core)
 
 /**
  * struct tegra241_vintf - Virtual Interface
+ * @vsmmu: Embedded arm_vsmmu structure
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
  * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
+ * @lvcmdq_mutex: Lock to serialize user-allocated lvcmdqs
  * @base: MMIO base address
+ * @mmap_offset: Offset argument for mmap() syscall
+ * @sids: Stream ID replacement resources
  */
 struct tegra241_vintf {
+	struct arm_vsmmu vsmmu;
+
 	u16 idx;
 
 	bool enabled;
@@ -154,19 +173,41 @@ struct tegra241_vintf {
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
+	struct mutex lvcmdq_mutex; /* user space race */
 
 	void __iomem *base;
+	unsigned long mmap_offset;
+
+	struct ida sids;
+};
+#define viommu_to_vintf(v) container_of(v, struct tegra241_vintf, vsmmu.core)
+
+/**
+ * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
+ * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
+ * @vintf: Parent VINTF pointer
+ * @sid: Physical Stream ID
+ * @idx: Replacement index in the VINTF
+ */
+struct tegra241_vintf_sid {
+	struct iommufd_vdevice core;
+	struct tegra241_vintf *vintf;
+	u32 sid;
+	u8 idx;
 };
+#define vdev_to_vsid(v) container_of(v, struct tegra241_vintf_sid, core)
 
 /**
  * struct tegra241_cmdqv - CMDQ-V for SMMUv3
  * @smmu: SMMUv3 device
  * @dev: CMDQV device
  * @base: MMIO base address
+ * @base_phys: MMIO physical base address, for mmap
  * @irq: IRQ number
  * @num_vintfs: Total number of VINTFs
  * @num_vcmdqs: Total number of VCMDQs
  * @num_lvcmdqs_per_vintf: Number of logical VCMDQs per VINTF
+ * @num_sids_per_vintf: Total number of SID replacements per VINTF
  * @vintf_ids: VINTF id allocator
  * @vintfs: List of VINTFs
  */
@@ -175,12 +216,14 @@ struct tegra241_cmdqv {
 	struct device *dev;
 
 	void __iomem *base;
+	phys_addr_t base_phys;
 	int irq;
 
 	/* CMDQV Hardware Params */
 	u16 num_vintfs;
 	u16 num_vcmdqs;
 	u16 num_lvcmdqs_per_vintf;
+	u16 num_sids_per_vintf;
 
 	struct ida vintf_ids;
 
@@ -351,6 +394,29 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 
 /* HW Reset Functions */
 
+/*
+ * When a guest-owned VCMDQ is disabled, if the guest did not enqueue a CMD_SYNC
+ * following an ATC_INV command at the end of the guest queue while this ATC_INV
+ * is timed out, the TIMEOUT will not be reported until this VCMDQ gets assigned
+ * to the next VM, which will be a false alarm potentially causing some unwanted
+ * behavior in the new VM. Thus, a guest-owned VCMDQ must flush the TIMEOUT when
+ * it gets disabled. This can be done by just issuing a CMD_SYNC to SMMU CMDQ.
+ */
+static void tegra241_vcmdq_hw_flush_timeout(struct tegra241_vcmdq *vcmdq)
+{
+	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
+	u64 cmd_sync[CMDQ_ENT_DWORDS] = {};
+
+	cmd_sync[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
+		      FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+
+	/*
+	 * It does not hurt to insert another CMD_SYNC, taking advantage of the
+	 * arm_smmu_cmdq_issue_cmdlist() that waits for the CMD_SYNC completion.
+	 */
+	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, cmd_sync, 1, true);
+}
+
 /* This function is for LVCMDQ, so @vcmdq must not be unmapped yet */
 static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
@@ -364,6 +430,8 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR)),
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, CONS)));
 	}
+	tegra241_vcmdq_hw_flush_timeout(vcmdq);
+
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, CONS));
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, BASE));
@@ -380,6 +448,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
 
+/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
+static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
+{
+	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+}
+
 /* This function is for LVCMDQ, so @vcmdq must be mapped prior */
 static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 {
@@ -390,7 +464,7 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	tegra241_vcmdq_hw_deinit(vcmdq);
 
 	/* Configure and enable VCMDQ */
-	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	_tegra241_vcmdq_hw_init(vcmdq);
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
@@ -420,6 +494,7 @@ static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
 static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 {
 	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
+	int sidx;
 
 	/* HW requires to unmap LVCMDQs in descending order */
 	while (lidx--) {
@@ -429,6 +504,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
 		}
 	}
 	vintf_write_config(vintf, 0);
+	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
+		writel(0, REG_VINTF(vintf, SID_MATCH(sidx)));
+		writel(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
+	}
 }
 
 /* Map a global VCMDQ to the pre-assigned LVCMDQ */
@@ -457,7 +536,8 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
 	 * restricted set of supported commands.
 	 */
-	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
+	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own) |
+		 FIELD_PREP(VINTF_VMID, vintf->vsmmu.vmid);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
@@ -584,7 +664,9 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 
 	dev_dbg(vintf->cmdqv->dev,
 		"%sdeallocated\n", lvcmdq_error_header(vcmdq, header, 64));
-	kfree(vcmdq);
+	/* Guest-owned VCMDQ is free-ed with hw_queue by iommufd core */
+	if (vcmdq->vintf->hyp_own)
+		kfree(vcmdq);
 }
 
 static struct tegra241_vcmdq *
@@ -671,7 +753,13 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 
 	dev_dbg(cmdqv->dev, "VINTF%u: deallocated\n", vintf->idx);
 	tegra241_cmdqv_deinit_vintf(cmdqv, idx);
-	kfree(vintf);
+	if (!vintf->hyp_own) {
+		mutex_destroy(&vintf->lvcmdq_mutex);
+		ida_destroy(&vintf->sids);
+		/* Guest-owned VINTF is free-ed with viommu by iommufd core */
+	} else {
+		kfree(vintf);
+	}
 }
 
 static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
@@ -699,10 +787,45 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	put_device(cmdqv->dev); /* smmu->impl_dev */
 }
 
+static int
+tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
+			       const struct iommu_user_data *user_data);
+
+static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu, u32 *length,
+				    enum iommu_hw_info_type *type)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct iommu_hw_info_tegra241_cmdqv *info;
+	u32 regval;
+
+	if (*type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
+	info->log2vcmdqs = ilog2(cmdqv->num_lvcmdqs_per_vintf);
+	info->log2vsids = ilog2(cmdqv->num_sids_per_vintf);
+	info->version = FIELD_GET(CMDQV_VER, regval);
+
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+	return info;
+}
+
 static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
+	/* For in-kernel use */
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_remove = tegra241_cmdqv_remove,
+	/* For user-space use */
+	.hw_info = tegra241_cmdqv_hw_info,
+	.vsmmu_size = VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core),
+	.vsmmu_type = IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
 };
 
 /* Probe Functions */
@@ -844,6 +967,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->irq = irq;
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
+	cmdqv->base_phys = res->start;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
@@ -860,6 +984,8 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
 	cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
 	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;
+	cmdqv->num_sids_per_vintf =
+		1 << FIELD_GET(CMDQV_NUM_SID_PER_VM_LOG2, regval);
 
 	cmdqv->vintfs =
 		kcalloc(cmdqv->num_vintfs, sizeof(*cmdqv->vintfs), GFP_KERNEL);
@@ -913,3 +1039,276 @@ struct arm_smmu_device *tegra241_cmdqv_probe(struct arm_smmu_device *smmu)
 	put_device(smmu->impl_dev);
 	return ERR_PTR(-ENODEV);
 }
+
+/* User space VINTF and VCMDQ Functions */
+
+static size_t tegra241_vintf_get_vcmdq_size(struct iommufd_viommu *viommu,
+					    enum iommu_hw_queue_type queue_type)
+{
+	if (queue_type != IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV)
+		return 0;
+	return HW_QUEUE_STRUCT_SIZE(struct tegra241_vcmdq, core);
+}
+
+static int tegra241_vcmdq_hw_init_user(struct tegra241_vcmdq *vcmdq)
+{
+	char header[64];
+
+	/* Configure the vcmdq only; User space does the enabling */
+	_tegra241_vcmdq_hw_init(vcmdq);
+
+	dev_dbg(vcmdq->cmdqv->dev, "%sinited at host PA 0x%llx size 0x%lx\n",
+		lvcmdq_error_header(vcmdq, header, 64),
+		vcmdq->cmdq.q.q_base & VCMDQ_ADDR,
+		1UL << (vcmdq->cmdq.q.q_base & VCMDQ_LOG2SIZE));
+	return 0;
+}
+
+static void
+tegra241_vintf_destroy_lvcmdq_user(struct iommufd_hw_queue *hw_queue)
+{
+	struct tegra241_vcmdq *vcmdq = hw_queue_to_vcmdq(hw_queue);
+
+	mutex_lock(&vcmdq->vintf->lvcmdq_mutex);
+	tegra241_vcmdq_hw_deinit(vcmdq);
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
+	if (vcmdq->prev)
+		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
+	mutex_unlock(&vcmdq->vintf->lvcmdq_mutex);
+}
+
+static int tegra241_vintf_alloc_lvcmdq_user(struct iommufd_hw_queue *hw_queue,
+					    u32 lidx, phys_addr_t base_addr_pa)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(hw_queue->viommu);
+	struct tegra241_vcmdq *vcmdq = hw_queue_to_vcmdq(hw_queue);
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
+	struct arm_smmu_device *smmu = &cmdqv->smmu;
+	struct tegra241_vcmdq *prev = NULL;
+	u32 log2size, max_n_shift;
+	char header[64];
+	int ret;
+
+	if (hw_queue->type != IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV)
+		return -EOPNOTSUPP;
+	if (lidx >= cmdqv->num_lvcmdqs_per_vintf)
+		return -EINVAL;
+
+	mutex_lock(&vintf->lvcmdq_mutex);
+
+	if (vintf->lvcmdqs[lidx]) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	/*
+	 * HW requires to map LVCMDQs in ascending order, so reject if the
+	 * previous lvcmdqs is not allocated yet.
+	 */
+	if (lidx) {
+		prev = vintf->lvcmdqs[lidx - 1];
+		if (!prev) {
+			ret = -EIO;
+			goto unlock;
+		}
+	}
+
+	/*
+	 * hw_queue->length must be a power of 2, in range of
+	 *   [ 32, 2 ^ (idr[1].CMDQS + CMDQ_ENT_SZ_SHIFT) ]
+	 */
+	max_n_shift = FIELD_GET(IDR1_CMDQS,
+				readl_relaxed(smmu->base + ARM_SMMU_IDR1));
+	if (!is_power_of_2(hw_queue->length) || hw_queue->length < 32 ||
+	    hw_queue->length > (1 << (max_n_shift + CMDQ_ENT_SZ_SHIFT))) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+	log2size = ilog2(hw_queue->length) - CMDQ_ENT_SZ_SHIFT;
+
+	/* base_addr_pa must be aligned to hw_queue->length */
+	if (base_addr_pa & ~VCMDQ_ADDR ||
+	    base_addr_pa & (hw_queue->length - 1)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/*
+	 * HW requires to unmap LVCMDQs in descending order, so destroy() must
+	 * follow this rule. Set a dependency on its previous LVCMDQ so iommufd
+	 * core will help enforce it.
+	 */
+	if (prev) {
+		ret = iommufd_hw_queue_depend(vcmdq, prev, core);
+		if (ret)
+			goto unlock;
+	}
+	vcmdq->prev = prev;
+
+	ret = tegra241_vintf_init_lvcmdq(vintf, lidx, vcmdq);
+	if (ret)
+		goto undepend_vcmdq;
+
+	dev_dbg(cmdqv->dev, "%sallocated\n",
+		lvcmdq_error_header(vcmdq, header, 64));
+
+	tegra241_vcmdq_map_lvcmdq(vcmdq);
+
+	vcmdq->cmdq.q.q_base = base_addr_pa & VCMDQ_ADDR;
+	vcmdq->cmdq.q.q_base |= log2size;
+
+	ret = tegra241_vcmdq_hw_init_user(vcmdq);
+	if (ret)
+		goto unmap_lvcmdq;
+
+	hw_queue->destroy = &tegra241_vintf_destroy_lvcmdq_user;
+	mutex_unlock(&vintf->lvcmdq_mutex);
+	return 0;
+
+unmap_lvcmdq:
+	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
+	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
+undepend_vcmdq:
+	if (vcmdq->prev)
+		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);
+unlock:
+	mutex_unlock(&vintf->lvcmdq_mutex);
+	return ret;
+}
+
+static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
+{
+	struct tegra241_vintf *vintf = viommu_to_vintf(viommu);
+
+	if (vintf->mmap_offset)
+		iommufd_viommu_destroy_mmap(&vintf->vsmmu.core,
+					    vintf->mmap_offset);
+	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
+}
+
+static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
+{
+	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
+	struct tegra241_vintf *vintf = vsid->vintf;
+
+	writel(0, REG_VINTF(vintf, SID_MATCH(vsid->idx)));
+	writel(0, REG_VINTF(vintf, SID_REPLACE(vsid->idx)));
+	ida_free(&vintf->sids, vsid->idx);
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: deallocated SID_REPLACE%d for pSID=%x\n", vintf->idx,
+		vsid->idx, vsid->sid);
+}
+
+static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->dev);
+	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
+	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
+	struct arm_smmu_stream *stream = &master->streams[0];
+	u64 virt_sid = vdev->virt_id;
+	int sidx;
+
+	if (virt_sid > UINT_MAX)
+		return -EINVAL;
+
+	WARN_ON_ONCE(master->num_streams != 1);
+
+	/* Find an empty pair of SID_REPLACE and SID_MATCH */
+	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
+			     GFP_KERNEL);
+	if (sidx < 0)
+		return sidx;
+
+	writel(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
+	writel(virt_sid << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
+	dev_dbg(vintf->cmdqv->dev,
+		"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
+		vintf->idx, sidx, stream->id, (u32)virt_sid);
+
+	vsid->idx = sidx;
+	vsid->vintf = vintf;
+	vsid->sid = stream->id;
+
+	vdev->destroy = &tegra241_vintf_destroy_vsid;
+	return 0;
+}
+
+static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
+	.destroy = tegra241_cmdqv_destroy_vintf_user,
+	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct tegra241_vintf_sid, core),
+	.vdevice_init = tegra241_vintf_init_vsid,
+	.get_hw_queue_size = tegra241_vintf_get_vcmdq_size,
+	.hw_queue_init_phys = tegra241_vintf_alloc_lvcmdq_user,
+};
+
+static int
+tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
+			       const struct iommu_user_data *user_data)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(vsmmu->smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = viommu_to_vintf(&vsmmu->core);
+	struct iommu_viommu_tegra241_cmdqv data;
+	phys_addr_t page0_base;
+	int ret;
+
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					  out_vintf_mmap_length);
+	if (ret)
+		return ret;
+
+	ret = tegra241_cmdqv_init_vintf(cmdqv, cmdqv->num_vintfs - 1, vintf);
+	if (ret < 0) {
+		dev_err(cmdqv->dev, "no more available vintf\n");
+		return ret;
+	}
+
+	/*
+	 * Initialize the user-owned VINTF without a LVCMDQ, as it cannot pre-
+	 * allocate a LVCMDQ until user space wants one, for security reasons.
+	 * It is different than the kernel-owned VINTF0, which had pre-assigned
+	 * and pre-allocated global VCMDQs that would be mapped to the LVCMDQs
+	 * by the tegra241_vintf_hw_init() call.
+	 */
+	ret = tegra241_vintf_hw_init(vintf, false);
+	if (ret)
+		goto deinit_vintf;
+
+	page0_base = cmdqv->base_phys + TEGRA241_VINTFi_PAGE0(vintf->idx);
+	ret = iommufd_viommu_alloc_mmap(&vintf->vsmmu.core, page0_base, SZ_64K,
+					&vintf->mmap_offset);
+	if (ret)
+		goto hw_deinit_vintf;
+
+	data.out_vintf_mmap_length = SZ_64K;
+	data.out_vintf_mmap_offset = vintf->mmap_offset;
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+					out_vintf_mmap_length);
+	if (ret)
+		goto free_mmap;
+
+	ida_init(&vintf->sids);
+	mutex_init(&vintf->lvcmdq_mutex);
+
+	dev_dbg(cmdqv->dev, "VINTF%u: allocated with vmid (%d)\n", vintf->idx,
+		vintf->vsmmu.vmid);
+
+	vsmmu->core.ops = &tegra241_cmdqv_viommu_ops;
+	return 0;
+
+free_mmap:
+	iommufd_viommu_destroy_mmap(&vintf->vsmmu.core, vintf->mmap_offset);
+hw_deinit_vintf:
+	tegra241_vintf_hw_deinit(vintf);
+deinit_vintf:
+	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
+	return ret;
+}
-- 
2.43.0


