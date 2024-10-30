Return-Path: <linux-kselftest+bounces-21165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613289B6F30
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACF1C2235E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AE32281CB;
	Wed, 30 Oct 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbsFUHL0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66322803E;
	Wed, 30 Oct 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324108; cv=fail; b=GBoPyMv1kp1Gjf7sOJ3TZEGWoRUSj9BF9+wPzI3p0yRmTfXLDzYOP4u0G/ZX2GQdP88do3n3DTFy3wGgsdPe0OTmj/xQ+aF0ahfje7w65UUVZKjqlOx8PMo8VtL1ZWvkQ60n/y6GEKJNbrbq49vlg3UkXpl/VsAnOGDJQrmHoyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324108; c=relaxed/simple;
	bh=GnlEqUbtCOBugdwWenf0URGYG1gs8cNFbdOk87yROeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvhuqngyJO74RMOkVyjgaO4bwSUuzIb3SI8HiDKKZ45+7bZKssrm5KwMr45kX0UBkgFJxTBnWvL3TO6tpIHGodzNCdAZ0t+odFoxW3xdNBmvPSQdkqtAVF7qOBnGr1lUvCau9Xa5Qz3FgWUh7eAbUtDOExPHD9GKISmHNn1WIhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hbsFUHL0; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLUelmJn0yxo6yacZvOiZd3+gd4TwwVqXaBXgIlzr15k6O2kF+SPm3BfoKZpVDb/fUV4EQH2Hlb2Eb1UVQXfI/E4wZLw6VTLSTpldR69tegFwbmcQeIgZDs3U6lwZKF+eHhYiHyqVCSzRsT6onnFXuOlo7gpfFkgsoJkEsnsyW2MHsWMfLrVH9kHd8N0c+woa21Xv/rNgL+TY1jDeHLMx++Q6B249lpwSgG+i8Nr4Fmtk7f2g1skhcFoY4J96nfJfsIuUlzMMjW7D2MOtV1cBK60H+1NajspieUkp71glk84dk5DE/zOII6QyeeNWFiTHKfr/mYa7ndNL0gNpC5Lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hkztPKrOqqa7rC7sObEukfJLKe85KtYYTJxH2Ol71A=;
 b=IaohbSuSEAtjAQ9f8cWfDYZfff73uQ05gjF2cIch/+In/xDN09gziNmiRmkTyU6VlMl1vxuscdoaLWcvSYU0n+M8hHtL8T+dg/SOHlpAqEbFUMShBpiz/W+pRtArU4AvU1MyX5t3NHu8XCQZ+RHPbAvAlgKLJMALhSIhuGLvyQw414nnA7a9VcMhiY0KCS8/qeZ0YsuyDvLMllCtqtqjiYaCYI704tZIWQAvAMdl83moKI3WSL2og8vGT8mES1E98UvZvaR0wx8kbg4G2jtgiJXiilHtDMvw78RTz/tOyWMJkUZSDF95lZUtL4+6winyyRd9mZdOIfOc7jQLFTkFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hkztPKrOqqa7rC7sObEukfJLKe85KtYYTJxH2Ol71A=;
 b=hbsFUHL0CmnlAt/wH6grvu0V3lzxNS7xbyZXVZ3C+qVuEVZS9LBXgcnF7qiHPYI8qhbYnGrJGK2lxUZfVT66IcstSJelv1+o/H/IlvHvXDrVU3IcdiU1cW6wyOc0kxa8H4Pu0REbUvhxydJIEFeUiSghOjP3xq14ZWf5F2MHRGGxzwkLdSCW5BtrmhaTILVY5N5Lk8k6dl8GahWtYgbEhRjDYD1C29XLKM5IO5PKVAqfHQvbiNPhGJ/VZmHOeVnEfmgUQvfTBC8nNNNfU89PY5r5PeEe+ZBnurLtLrAvnOF9YOAnr6vOw5wIO7ncrwkx1FDEiU2vA7O4PaH3+cGH3A==
Received: from SN7PR04CA0118.namprd04.prod.outlook.com (2603:10b6:806:122::33)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:01 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::6e) by SN7PR04CA0118.outlook.office365.com
 (2603:10b6:806:122::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:34:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 03/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
Date: Wed, 30 Oct 2024 14:34:29 -0700
Message-ID: <83a5bc32b62e42def9395f48da961263e18adf77.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf4e93f-c410-49d7-06c5-08dcf92ab5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OeBsya4xnuVmMbIZKuTGm4wSwREQylGu0z9xWMl28nNvP1gFOKiRoJOuUS+9?=
 =?us-ascii?Q?COmwwIjypyT7Kf070t5sHqaes752Z21vPIIIrDn0boyc4uJP5rs3/zpEUmHQ?=
 =?us-ascii?Q?kOFl7TiOhE18+tQl6/7oQdukK3wGUxbg0VVL75D1LIxi0frtxeWCwltIitbg?=
 =?us-ascii?Q?bgHDpV1soYin4QKUJHPGiqXONSxKentGXfze7ilGuRQjfidEhsul6JkJAo8U?=
 =?us-ascii?Q?2E6jwJfuLkZpIDXbkBTOTDjzoxlX+ID3QV3ia4pEb2RPBNOhhHGfQpgdam4u?=
 =?us-ascii?Q?Ar2K8KEmSXZvAFzIGOMyQKDM/w3prg1YgRKVV0NAZmlhMAUbJRKXLJ5LzNIs?=
 =?us-ascii?Q?JVCxp3FPjJP8V77ncdWaF2vLh4ecYK7klcJwMaUJD6WUwDEFrXb6hWhuwsy8?=
 =?us-ascii?Q?vpV3vkRK6WKRwCQFz1FXfTwCz5Ibe4sKBCEyxA6ZAlWC8K4j0o4YM09wPCS4?=
 =?us-ascii?Q?wkdEVX6i5PnVO7Eo22+v5hpSHPC5urVzsS6FU61ZuRyvie2drgW7qjYrGiMp?=
 =?us-ascii?Q?9hqU/XpD4cZO5A2i88AaRfOobzsuxBbZ4sxBg/bUrWbgjupOlchqPng17631?=
 =?us-ascii?Q?thbkGjOjAMVEp2fdcDgqb7GSPo7Dh9x5mjrzM/NYaEw9ghtrc0AxLpueN1HL?=
 =?us-ascii?Q?zkS1kXSzuHWX+CP0eubtcWqnGjZu6Ed3TnlCkGIPw5MnkQMaoHOYlJw6tDG4?=
 =?us-ascii?Q?8hWJz8M+VoD4bcRWc8NTJ2YEtj4weqbtWrVD3m+RjdMejRelh68G0xsvehD6?=
 =?us-ascii?Q?ATrREkz27oE7CDqr4uylf+Vnu3kmL2MyxAy5iCjEPjfuxjxDGFQO2REsPs1m?=
 =?us-ascii?Q?vHo4HSIWQmSJH4I/F7WrqqcfHiKUfwNZLOUo1ISy+gVp56ouiMydhWa5qzHq?=
 =?us-ascii?Q?2N6QIebQUW/V38hHiscYbWEFQqmB6fG7BTRNnH6i/1j4CavRGOJx8Uydw8ou?=
 =?us-ascii?Q?3FgJq7oCaWOda9YKHCdEoHFHAyApSd8w0NojCj4xyyu8qUPOQJcV+bce80xe?=
 =?us-ascii?Q?/RPoFgzG5P3Y+5Tptvf8Rx6Z/h8RbcpewmJsjFbQ4qxU2P54yHR48NoJOoJZ?=
 =?us-ascii?Q?LVWd/Q3t3RJAE1ntL75QMoWKsmcgs/E/JLoEc7t16YOw1Do2KXoUVPUJzb+Z?=
 =?us-ascii?Q?uiRF20L+INEVRGQDGwYE5UPbd9LLAK+k3otGRYclTRdyp+WDcUszgjUHd6gD?=
 =?us-ascii?Q?LN3Oe5L+ydHe10NfLjW1u47nM942OkAkQRLPBqr7K4Cj9rXSSHl1IT+Ev0Hv?=
 =?us-ascii?Q?mPvoRo46wFjVnzXOb8YAIK9oCSOiRKxh1Rmksxl/HzQTQaZ07PE6ORsWX7P9?=
 =?us-ascii?Q?lGF9+Ec9rcmYPTa29dTQf3VWXvi01SIaAyNfM9c/Afjvnp2OixGnZF86b9wK?=
 =?us-ascii?Q?82YN20QD1LU1giGMvgT5oCxAqBs0iAwK8ALDtMbI2n5yXIBfIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:01.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf4e93f-c410-49d7-06c5-08dcf92ab5d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
a slice of physical IOMMU device passed to or shared with a user space VM.
This slice, now a vIOMMU object, is a group of virtualization resources of
a physical IOMMU's, such as:
 - Security namespace for guest owned ID, e.g. guest-controlled cache tags
 - Non-device-affiliated event reporting, e.g. invalidation queue errors
 - Access to a sharable nesting parent pagetable across physical IOMMUs
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts

Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
vIOMMU structures. And this allocation also needs a free(), so add struct
iommufd_viommu_ops.

To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
It's suggested that a driver should embed a core-level viommu structure in
its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
meanwhile the driver can also implement a viommu ops:
    struct my_driver_viommu {
        struct iommufd_viommu core;
        /* driver-owned properties/features */
        ....
    };

    static const struct iommufd_viommu_ops my_driver_viommu_ops = {
        .free = my_driver_viommu_free,
        /* future ops for virtualization features */
        ....
    };

    static struct iommufd_viommu my_driver_viommu_alloc(...)
    {
        struct my_driver_viommu *my_viommu =
                iommufd_viommu_alloc(ictx, my_driver_viommu, core,
                                     my_driver_viommu_ops);
        /* Init my_viommu and related HW feature */
        ....
        return &my_viommu->core;
    }

    static struct iommu_domain_ops my_driver_domain_ops = {
        ....
        .viommu_alloc = my_driver_viommu_alloc,
    };

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h   | 14 ++++++++++++++
 include/linux/iommufd.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..2574fc8abaf2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_ctx;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -542,6 +544,14 @@ static inline int __iommu_copy_struct_from_user_array(
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
+ *                the @dev, as the set of virtualization resources shared/passed
+ *                to user space IOMMU instance. And associate it with a nesting
+ *                @parent_domain. The @viommu_type must be defined in the header
+ *                include/uapi/linux/iommufd.h
+ *                It is required to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structures,
+ *                using the given @ictx pointer.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -591,6 +601,10 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
 				 struct iommu_domain *domain);
 
+	struct iommufd_viommu *(*viommu_alloc)(
+		struct device *dev, struct iommu_domain *parent_domain,
+		struct iommufd_ctx *ictx, unsigned int viommu_type);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2f72452fad27..457e763e8b63 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,7 @@ struct iommu_group;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu_ops;
 struct page;
 
 enum iommufd_object_type {
@@ -28,6 +29,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -78,6 +80,26 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	const struct iommufd_viommu_ops *ops;
+
+	unsigned int type;
+};
+
+/**
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
+ *           of the vIOMMU will be free-ed by iommufd core after calling this op
+ */
+struct iommufd_viommu_ops {
+	void (*destroy)(struct iommufd_viommu *viommu);
+};
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
@@ -145,4 +167,22 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_IOMMUFD */
+
+/*
+ * Helpers for IOMMU driver to allocate driver structures that will be freed by
+ * the iommufd core. The free op will be called prior to freeing the memory.
+ */
+#define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)             \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			ictx, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
+		if (!IS_ERR(ret))                                              \
+			ret->member.ops = viommu_ops;                          \
+		ret;                                                           \
+	})
 #endif
-- 
2.43.0


