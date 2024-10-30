Return-Path: <linux-kselftest+bounces-21168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBE9B6F3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F86B1F24669
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1E228B72;
	Wed, 30 Oct 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LKm5PMiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42796218582;
	Wed, 30 Oct 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324120; cv=fail; b=oMCDwi/LZhOxkN0Bc0f3ZOsifDy1naAqpvb4a4Aw1Ws2g2/kOtkqXuxMvs9TGb4jDF5i3ZKXu22ATWezGAMd9+7g7TCmo3w+L1uWNNxEMkbuyD8KCuHeAs4HGQaurakdVQSPcc+oY3WN5ilKSQk6b7EMiTZoM8sXiJn83GCShAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324120; c=relaxed/simple;
	bh=sBzU28DAjRKWzySh4SxnP3LzEEHZb6pTH9bJWOP8Ha0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNk8yuGNMaAU3HSdDZvY9MIr1v6L7FgigOzeiuIPebsZOauA9mqebnuKdCPypxesNlB8dt6LAcljhAKFDmLUMqCs2TH1XvOyB4G3C0n9pnznckCnPTY5Z5YufLpiKeufUwaMnvEg/QrDNE2B0CeGotEHojTsHvXazIDFuOjhaFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LKm5PMiR; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzheKyanZ6+GtCyOOU6IN/lqWMqdCiKA2p7IgLg3a1fkTswZB57wH6wuTaPrOKPhR/BMBrui+ZS5zKJApoAVroiOuKLeMh1XCpd2c6MQR8fL9RfoLxo04/zfBMWwmIq6F0BETqCreMR0R/9cDcrnFOFbQHEfNgUFszA1HMGtjQ6AjIYqqje525igagm7Ui74tIJfy2j78tcH27w44nLFvfy2GyfnzHkdKHYeJMrnVJgi+Sl1QdcwqxzunIwrcMvTZvnlnK8SIG8E5dc9085Q7z8zI24zaF1lzxwqoIvtLvDxe7nOccQmjm6JkWilfXaZe/EEC/nsJJktDGNObF0HFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15IebqioQLVniPg33q96CYi05OjcWulaE5tJTzOAFek=;
 b=YkCHEs98ixeVmiOIHEoRZf8+vyw9cviGZ8MAenOdjFXkF1sfJ6Iqmrs/MVR+5uKHqtQd327R1Rrg1eUXjH4jFuBqMLS1QtKtcelhz5YjKKKEZWY1L/U487ZAbFHnJn+nmTEFL+C0AHoxjjeBcd+h2QqZF4NO3MC+ZKO5o/c0IXLXT9Bme08VRp5IkZZ9Ovv+wzRZ7gcdRGahUxjaa9k25Hmo3O4Zzf1i3EWfxJs8eNvkmPtFfcyrVpHuaNZMYehWnbmExlM1H7c32GPjrzfUz7s9crqzrPpV9hhQorOIzIJG5lhqSThFOhje86JzyECtdbqsdb9Dv1wyAbdqGrFX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15IebqioQLVniPg33q96CYi05OjcWulaE5tJTzOAFek=;
 b=LKm5PMiRVu4K4SMQh+eltzKRzgUdmaXmOWcXmdRGHE6qZCcZWQK55zXTw3KEW4a/aDFoBb8UP6NxUuJMrIqylarV/u9HPr5HWGKo6FhR42NNLxt4TU6qTWWn4vfFAZ2gxNwjyz4P6/BFNLGNZ/fREd9xx/8iD8No5AnQYqjhjF59tkutC91CURAnbt0D00iOwJ2gHKiNxZdgcTHG5OwSFsgKodPzCQAoYPZWl7lrAjkvBtJSXgW/svpGRA2uqoIF0Pa5X44Ab72HAPqqBY+EodxVMyQT05jSvnPeoXUWUjKrKZl+A/8fGT3Ay9kIIUDVkuwN2y20uM6Htz6VKtLLcw==
Received: from CH2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:610:58::26)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 21:35:08 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::2f) by CH2PR20CA0016.outlook.office365.com
 (2603:10b6:610:58::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:01 -0700
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
Subject: [PATCH v6 05/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Date: Wed, 30 Oct 2024 14:34:31 -0700
Message-ID: <5d2efe229821f5db7a832d9d6be84217289ac3f4.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: c0464dfd-0b3f-4ecc-8baf-08dcf92ab9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEhFxC99pePxK0PWG/n4FFb6hW2BfBgU3bLwQJDghkawIvv6eTowtOV7qG4n?=
 =?us-ascii?Q?UPnSNz0tbnjkkG0lUpMFNksqDy21bM3fpCCu2NE1r8TL9RLYKson4/GSAcwE?=
 =?us-ascii?Q?DvUfc+8x4LWhqv0kiXFhYt/mE0LPNEcADLYQFIRdrCiVIXKp1B8rB44T39Vv?=
 =?us-ascii?Q?z4F1/OQZWyh6EPThueJUlEV6FJ4L5EUMQJpH93jJPKb74OHyoRVR4R/UA+qn?=
 =?us-ascii?Q?ZtTdQV9SvM/YC1rY8FVA8fiHoFG3EHcwR91YE0d0Zd5AB0hD2TtM9g5MCN1H?=
 =?us-ascii?Q?YG4uiFH1qZzi/oatGiPihrcwCaVO9h9G3N9RkzkntDUAbFdTUgZZG+WY5vr4?=
 =?us-ascii?Q?MPREbGM0Np1nRmWcWQtF0w90V3CMZ9JwQ1S2IFE6Vnarb0Atw87OnuoaAm7g?=
 =?us-ascii?Q?vVWLXNntGnLCpzkwugEjC0edYzN2l1X2Pg95ec8I1sSsHG8VF3NZP7F8GgQj?=
 =?us-ascii?Q?UCdXMgoSTbBixoBmXOkGPmL0BCdQXBUgv80rMX1ssEPrqv1p+9uHgx6ri6sz?=
 =?us-ascii?Q?x/3xunBKJjlUwUP+kTkX73qVuhwR3OtQBSHj8dwbRpcVmx6x5+Y/Pwo+eTRZ?=
 =?us-ascii?Q?olO6lCAV7EApp5c6nKfMlPEn95LrGALVnYFEvEy7tSiCtPVEnTzPV97zgphf?=
 =?us-ascii?Q?lAxAzVqnxh9AY+ZU0h3vvS2afWgxlCjtTFrt12DYUMXaU4sEKajlFWjlSula?=
 =?us-ascii?Q?yNyBKBYC+p1oCV+lnvIlbescNCbbk2GpZTSwk7sFSy5JEfbDJ1G7/dKIgtdB?=
 =?us-ascii?Q?QUuZQcjjlB6YpeaP+OFu2+A/KekSD/T3E9x77vVJG0TfDn1r85XWnAtRz7bq?=
 =?us-ascii?Q?WZb8SyGp87VNU1yTOdgjPZwUjU5TIfhKRnKky0mqZsmMZQkAkKM2+4R9HHFS?=
 =?us-ascii?Q?TSu9k8sjSE8NjZjAeHcwE6spoF1DD7m8vD5JYVjdsrJLiFI8GKla9rxGGDRd?=
 =?us-ascii?Q?wXmoVDGSIqur5uzp8h7/TcaUqN9KlicCBevygZNea8WMa60vMsUzK6G0onRI?=
 =?us-ascii?Q?lIBCE+HNOQu5ea2moCY7KSGkuYnvmAjsNMMsR1OizmjPuzMDlMms4LWIaweR?=
 =?us-ascii?Q?FpsPtMqv+ZzyvgBpw/Bdk0RCGV2mP7IbU5uDqSw2LniW7e+/sGibr00C2QR+?=
 =?us-ascii?Q?3gLtWeu48MmgHVoFvzsnl0O+nRSOsV4CNrsZpUHSkjXNuvuRX85W1iZuhMcK?=
 =?us-ascii?Q?QQDmjGCzwHZA+UMNJDXIEKwiENCOPYH7rM/SgL1Ily7/RsM9Aj78S//RyO2U?=
 =?us-ascii?Q?aqf6xHOAvaD7cPDQu1CRlcGA2pYVO2tyPISdcm3WNvHskObO+rwbOlGVcKvG?=
 =?us-ascii?Q?F01b2PpKIakush/dkR+h1Vkyd72ASv1xMXhNue+6XX2KBSQ7dgI4oV9cQ6eL?=
 =?us-ascii?Q?0Ox6vyYzNuvEot/IyFu8jikZNvYAZnw86BboKfkr+7ZAnx9Shw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:08.0436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0464dfd-0b3f-4ecc-8baf-08dcf92ab9d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366

Add a new ioctl for user space to do a vIOMMU allocation. It must be based
on a nesting parent HWPT, so take its refcount.

IOMMU driver wanting to support vIOMMUs must define its IOMMU_VIOMMU_TYPE_
in the uAPI header and implement a viommu_alloc op in its iommu_ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 +-
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 include/uapi/linux/iommufd.h            | 40 ++++++++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 81 +++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 266e23d657ff..8f6f0dd038d0 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -7,7 +7,8 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
-	vfio_compat.o
+	vfio_compat.o \
+	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index be347f726fda..a8104d9d4cef 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -506,6 +506,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 41b1a01e9293..302844136b02 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 };
 
 /**
@@ -822,4 +823,43 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
+ * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
+ * virtualization support that is a security-isolated slice of the real IOMMU HW
+ * that is unique to a specific VM. Operations global to the IOMMU are connected
+ * to the vIOMMU, such as:
+ * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
+ * - Non-device-affiliated event reporting, e.g. invalidation queue errors
+ * - Access to a sharable nesting parent pagetable across physical IOMMUs
+ * - Virtualization of various platforms IDs, e.g. RIDs and others
+ * - Delivery of paravirtualized invalidation
+ * - Direct assigned invalidation queues
+ * - Direct assigned interrupts
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 30e6c2af3b45..cc514f9bc3e6 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -307,6 +307,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -360,6 +361,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -495,6 +498,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
new file mode 100644
index 000000000000..888239b78667
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "iommufd_private.h"
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	if (viommu->ops && viommu->ops->destroy)
+		viommu->ops->destroy(viommu);
+	refcount_dec(&viommu->hwpt->common.obj.users);
+}
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops->viommu_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_idev;
+	}
+
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
+		goto out_put_idev;
+	}
+
+	if (!hwpt_paging->nest_parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
+				   ucmd->ictx, cmd->type);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_hwpt;
+	}
+
+	viommu->type = cmd->type;
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+	refcount_inc(&viommu->hwpt->common.obj.users);
+	/*
+	 * It is the most likely case that a physical IOMMU is unpluggable. A
+	 * pluggable IOMMU instance (if exists) is responsible for refcounting
+	 * on its own.
+	 */
+	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
+
+	cmd->out_viommu_id = viommu->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
+	goto out_put_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
-- 
2.43.0


