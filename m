Return-Path: <linux-kselftest+bounces-20726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9507A9B1372
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83031C21A40
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502C216DEA;
	Fri, 25 Oct 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CR7LqNOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2A215C68;
	Fri, 25 Oct 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900227; cv=fail; b=dhEjUxGY1uTVwL3fSE1QAqZ5qfcHcEar8sFq54RT9TEkPzH96bNRaGdO49ate0won+QTZ7Xp4MgLst7odXI0N+tK8Ej3YcagpcWDZKcVxTDUIddhw9Sp75oycl/wfvijey6Csn3n6lGKTmiqi0oBmdznp0b9CZ0JdFZaJ4612jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900227; c=relaxed/simple;
	bh=K5szFrK6Ldyb/o15B6+BOiIC4wqJsIzjGK81jj0g6EY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2GP4G80Of+W9GeyzzgCWEqEGaVLWktTs6uRFAdxzoN3VYmvAcNPuUG8WGNdvzS/CsMlPvpr9/OlmpyC6CPnYjFbKu/rPcn5AMAPmqYzyQ6qA4fa/eK+m8spKmluXzH9VBClw4g+Il+lLvNasy5KCMtWQne/oZt0RFWtjgXNYsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CR7LqNOb; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcGWw2uUKL4TPbLqJJJ2pfqPVXDYkaMW3JBN/7Z0Ne9IJMiZEhMjIb4cqV+Euy9QMUcK0nAPlChFERkza9EyhUkDmwVQH6S2iaW7Rtpb+5Bj/OyBvzu29zGYXsyDnmdw4DOHWuhgywd9qu4/+pmGoVRxaOEdXdoWwVfath/P4vfwzZm2CX+R3DCuA2XAOWxWe1JkDhedA2LTiVO5sJw5U6xDqMLxwH3neBtojthT03DMfMylt2k3krGZWvFnjiDwc1LfXJhXkW99lgKTwY4yImTHe23BUjkTcu0skT+IO7e27GoRMaqEP+gJOXj+u7J+9IIbxOHpPqCtP3SPe4hpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4DkbmmPRFrYvE6j+gIv1bqGFqhBnWPIZr3Qv/a+ymY=;
 b=sMS5JTNMkkhnvWi6ITvRx7k8pDBcMe3nVfFGeXijwdkuagIZZxfZtJ0UjCdFJz9ab2Bs0RIqa8VXn+HN3bHF/+iG8nH5sYwSGa6Q9M2M9ZeWrTYzg+aDFrKEo8hq19oYrR7tnVQ+te3aznklBH4MzaMXcJD+EBBluKExN6XGuGgACJkuPeaAiKFOpX4XLnDlz6nzBVEuqSokGcmE/4Gd4QuY8IgswzMM6jgtx24bZ7+sfRdT/+u/X9TuofA+bQ5nSapG0Gbd5SqRo+VSaPxszGHQikgESPXZnZSsVLLrUKB/CL3gkgymphGRzbXegtMMAn19yS6qyaVajUyhAlAOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4DkbmmPRFrYvE6j+gIv1bqGFqhBnWPIZr3Qv/a+ymY=;
 b=CR7LqNOb48TKu9ZsFveH40g7DWx1Ioa5UEmbKVg6zMJoJPZOL05NegKCwp6ueLt13X4HjJxgStpW1te7b71tZyvSWCu9igLUgZsUmKYen4VZ2vl8u67DWg76zGKYdab8fp+0E8i6Vflul5aQPeby6pVqM1PE21kibze24F7jkK8cCgV+QLYqxgaNn5JudA4Xm0S+v+EL6ZoZ0PFJ1iO8dlGBgBHISKyKQdaEQ6NdBahLDuNXv1Za1PvwvxfiL3UPSXEv4m8Ra0PujZZf8q8Q0Qbh01jbgawhc2WJC3rToNFmL+msD8n2MEo4F9hJ1jXPWm5H+MMsngC0p6Mw3X8T7g==
Received: from MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 23:50:19 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::d2) by MW4PR03CA0242.outlook.office365.com
 (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 04/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Date: Fri, 25 Oct 2024 16:49:44 -0700
Message-ID: <f24628d774181da6df6e62bfa3376fbcacef8906.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 300960e3-b2a7-4bc1-b64d-08dcf54fc856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcYb0Vsebkte4Ka4N3/ag1BvY0bCvivZiBVpvv84zfzTKpZ03P4O8bH0Urmc?=
 =?us-ascii?Q?wYnJYdkEKDQ4RuMzxp6ADUVJCHmJ+zeYGLiLu+8nTuZJD4ka9/jVW+hki75d?=
 =?us-ascii?Q?u78PzyzL+4g/XYsfjI40xEFmpvcRlWPsSZXEVCef5R2tCCGBQo9K86pcOYL5?=
 =?us-ascii?Q?ODay7yvOeIbdiM1zRUZ2TfcocFRlZbR8+Uq+gxwPTD69jO+OedIo5HEDifzV?=
 =?us-ascii?Q?BbjHMpDMSj1LmGVNC7uRy8AWoqOnQWP+vk2x1JHsGpKy9x94jy7eO6fiVHEk?=
 =?us-ascii?Q?mDwmkObkDtI9LQwTwmiepPcwp6ZOADSzCeb/nvabAm9Ba/XzhaHwbt8JWN5s?=
 =?us-ascii?Q?SfDzxx31fWKcgifdlhpBfI9GqrgpzZdYyi1NOdiIfXiqhOEk6QFanauoBfo2?=
 =?us-ascii?Q?QRhsdU/VTsrVA10m9grICqs9AfquGx81dCkaexPGJb9ElTJjSS8YVsaVZCh9?=
 =?us-ascii?Q?jmkzTKc+Llm066Ikvo65Czr1RDGiOtggpYMQo+SD/2ui4w6UVQeu7mQtof0c?=
 =?us-ascii?Q?ujBRM3cyOVH9+01Ru1D+NvBkrauHC4DdKByCYkoqdTAs4+v1mYc73gPFhuRc?=
 =?us-ascii?Q?o5/nDxJNk982TCpk5isW6l3u4AkuDS3/f5IFLkLl79tN2ggX0IE/6OTL4IoJ?=
 =?us-ascii?Q?4ruhIAhbyq+TChb/AApk2SYL55h41uZw9Yg8/f/qcWBu0hvIOOxGbxC3PQPs?=
 =?us-ascii?Q?zWRRfx/nwXP6jJ2X6c0lV+RYyQHJFzbZaxK0XybvsqOxRAZt+nbr2FwGENQ8?=
 =?us-ascii?Q?M6t1vvD3TFBNV0cuxkoHUg8JNvcgNSmfNjX8P+UMxN9ozHsuBBCwo2YHIFZx?=
 =?us-ascii?Q?FgcpLYWlIZF75cJU9QEQSdrkN/0mPgGOt61L8jfYM9Hu5FhkYX0p1nNh5m3W?=
 =?us-ascii?Q?+fVOAE9zQbQB63ouLRqFRg7PM1X8lG9YePCtS66KDtG1FEyCc3X5NLIOC2KN?=
 =?us-ascii?Q?45wYroxc1wtfeZ1PqAC7omvTYK7J+9FGFJXCESfBZRdN7mvbdfkIZuKHme/0?=
 =?us-ascii?Q?xgClFMguFdotRda08wyasyesQRuv6sH0HGuxnUpXyp0lc5p1TDRe+EbvHC1Z?=
 =?us-ascii?Q?t9FiTdRo47ZP5YIgqZi9TZQHoHGSaeq6kry9+2nWW+aMuJLoxdXavQfX6ATn?=
 =?us-ascii?Q?oOnnJ127ujQBvWFHmEfLs3464l8vqQwutsfxZH94E3zt3jjwQQHA1tA/DTan?=
 =?us-ascii?Q?JrXlA1CgWXDeIbnnSSo2YdfWMQ5PI+Ku1SdkEcxkCeZV8UZnHsQbXvilSgkV?=
 =?us-ascii?Q?fJ3PY8Lw3HjkQlJTcLoWCppoWNYrJ1rj0TR+MDwdNa2N20bV17SBLgOZGedc?=
 =?us-ascii?Q?qzD6nMX2NpKnJ2Og4GATHojW6U+ezOVS+6gcoaa6PlLWJ3RA8NXbBZYtUl8A?=
 =?us-ascii?Q?LpZE2KapEBoUkHFanTXmHTvmoAbYaVwRaGHJlOibKJntuq/erw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:19.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300960e3-b2a7-4bc1-b64d-08dcf54fc856
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552

Add a new ioctl for user space to do a vIOMMU allocation. It must be based
on a nesting parent HWPT, so take its refcount.

IOMMU driver wanting to support vIOMMUs must define its IOMMU_VIOMMU_TYPE_
in the uAPI header and implement a viommu_alloc op in its iommu_ops.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 +-
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 include/uapi/linux/iommufd.h            | 40 +++++++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 89 +++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 435124a8e1f1..7c207c5f1eb6 100644
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
index d53c1ca75532..9adf8d616796 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -504,6 +504,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cd4920886ad0..3d320d069654 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 };
 
 /**
@@ -852,4 +853,43 @@ struct iommu_fault_alloc {
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
+ * - Access to a sharable nesting parent pagetable across physical IOMMUs
+ * - Non-affiliated event reporting (e.g. an invalidation queue error)
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
index e244fed1b7ab..ab5ee325d809 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -321,6 +321,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -372,6 +373,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -507,6 +510,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
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
index 000000000000..eb41e15ebab1
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	if (viommu->ops && viommu->ops->free)
+		viommu->ops->free(viommu);
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
+	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &viommu->obj);
+	if (rc) {
+		kfree(viommu);
+		goto out_put_hwpt;
+	}
+
+	viommu->type = cmd->type;
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+	/*
+	 * It is the most likely case that a physical IOMMU is unpluggable. A
+	 * pluggable IOMMU instance (if exists) is responsible for refcounting
+	 * on its own.
+	 */
+	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
+
+	refcount_inc(&viommu->hwpt->common.obj.users);
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


