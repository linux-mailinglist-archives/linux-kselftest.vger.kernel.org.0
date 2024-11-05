Return-Path: <linux-kselftest+bounces-21476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5D9BD68A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8245828035D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67A216430;
	Tue,  5 Nov 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8kXirZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248C215C7A;
	Tue,  5 Nov 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837109; cv=fail; b=KvhztnJO3Bg9tv40zEqO8aXU/49kOqRFm1QvjxIcmPXqNoXuhBLFsX/PJIFEmIOTkETAGVoHMPfjyBVIbkZ0c7ldJm/XIKlbwDKOemVRhiNmmUx7MppgX54dx5Lr0RvYNJMZrho8vLnsCE72QqpdtHwAWop5cohXYFROCFAfdyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837109; c=relaxed/simple;
	bh=tIFadCIZtR9rHxbbxoRX1CXGPDdeWzKo2pkk18HFys0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naRR181yRKb5MPwy/MGdLV2rGAKj+wopt4wN4tWR84DqviwYuIy6722y4S9it1dPqlWtQBH9gk0ST8w53DDMbiVSJEVsfLcflQzJ9G/jy2hgyfgwdkAZT6jagwPUKrTchgQLNDSxco/QmF2DFgMH69TXsJPM4EpnaG6kB2ky0w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8kXirZ2; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNNPBpupYxvDgya9ee86LJZDsGyB7KWHBxir+rzG6r/6NGxFuRgLJKv3CZwRjW8voa1TXr8c4vlRz46zumLgR/xTRvOgiecjtsV6IE7zzK5Tasq5dsFm0rTFm926QxnTxrnntgCZ9N7SaPJmLilRHtCWAQGWiVDFcZ4DxBTH9549uz7HMXdNMKTWuuI8UF5StPHHdz9M8K2OBjZ/SLS9Q0QvsUwIzCryaHno3iAHnA+1fUG6rJ81jO1HhwkHqt2hFMKAkiKDGpPEKw1OO0i0dkRRTWSLuzKz2BG/X5JsLJUcwdn0y/jcj9L7ViBCNfrCgL1CQjK0WAfciDBf5tn5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOS47/eOsBy30CAGYZswnG/R+HoLPXvbTJ1xbqY66gI=;
 b=KQqCi9yAgqk4AKPWZhUbPc79sKHYPHuBSdKIX+E+j/zFqiTe+DSMstjnn64/W4eXNgtvHG29I8lCjWOzyyY6yhUbTaXN6SpFesOjjxLqXGv0GJDhJChqgazfqeKHjDQAM3Eb8CKyBf1LYxbrp3JhU7XErBdm8WwleIhd0sliOhjhu0W3VcmTDaY+rORme1bXdlvFybZp4ot1if87A9XzfricWecYSAffzrAIbEz3nBdFdMgtZO+p39X3LIUqg4g7OEJKibRzeZHlpJwubwBfS0K70/rvAnaulIL9QAy7/292C74QPRz5KtmCCLsyrfFS63JDd0UVoxeD0UxkCUSjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOS47/eOsBy30CAGYZswnG/R+HoLPXvbTJ1xbqY66gI=;
 b=T8kXirZ2Fb1JvTF0KcmW6E6GWFvB9mAclXbdMBod+XPdkndObpXMhXmTkcisseCn3MHX8OGDROSA1WqeFL9mjhPTPyUOAyhwvijwKQbVpylRiVU/5aVXrwVg+b6CfVUqiwBVyzYOClMkNs2eopWCoui9HqKbQGCFxucOKpcGDLw4muog2kIu735w1wlMuWaoI5Z8ul9k3QsQFpGdRwqUwxRYZR92KgLuZYTzmD5zREH6MVgdbMagG8PakMQZp77MsMoKkjFftQGKq+HovAstt5FVTZ1UpGwVC1bMOJgp1SkX41eO7YWIT2sVCQKGwsGg+t5W/2D7fTaKhPv1EuOZVQ==
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:05:01 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::55) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:45 -0800
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
Subject: [PATCH v7 05/13] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Date: Tue, 5 Nov 2024 12:04:21 -0800
Message-ID: <dc2b8ba9ac935007beff07c1761c31cd097ed780.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: c9282df3-f851-4ed2-bae4-08dcfdd5219a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+bSDSN1B7AvQV2bDUlhFSag4RPKUVKbhqvApx6eI7eYYLYalqGi2GCXpzuNh?=
 =?us-ascii?Q?L7wgSWm2eWwFid71HNXEJZUYu2IyhzW+7+djK9qn0Jp6BWPeBD6GcVXn0ZRK?=
 =?us-ascii?Q?c4oDxoKnBDE38a5RW2qmPwVxL1yOhjwZwom5DqWxcybzpiJh77//Qed2xYnU?=
 =?us-ascii?Q?kHjpGYNi2KEk7NqX6D+FPYA4PxUB7z5LzZjCePP7YrXFaLXP2t3XdUIxsgbH?=
 =?us-ascii?Q?lMPDaQzzPmyrbyNjfrw1klszT6Qdp0zkDWu+aJKQzcCaIy9Lzf8kl4XFbd0O?=
 =?us-ascii?Q?cyLjdxtlrnMheufO6DnCtTz9VP3kqdkw6e1rZSxVD6tPICCVFTpxzhxz4sUG?=
 =?us-ascii?Q?ssgKfnF+IiTHz8PQy9S9EJuk1RgjQL4CF1RRar3MUjoopRRfYPPRh4Gc9oJp?=
 =?us-ascii?Q?xHw7wc6H9NSnBVXFhzJcgzPHRpjACGGXCt946HB4nsBvDEo+3Vm9NryuZjim?=
 =?us-ascii?Q?5EnUnSu7FURacfY+MJue51RT0pyXBBWeV4A7yY4hYnKDLxvlxxROlIkBJuxJ?=
 =?us-ascii?Q?/DeTumyKw8DMlcVA9dPJjlcAuS9uzyKExkkE2w18q6Sd7GEd5Jz8VT1AEVo+?=
 =?us-ascii?Q?J3u6atJEZW9IHsIUJs5PcElq+S0QVOJk9NsXElXrteXixXyEWiuf2qr6buZ0?=
 =?us-ascii?Q?rFrHNsLiiS3eNrxptGCdWo4o3zIfmDFTCZm2rdpV1azMbZwqFkfuYVTsKRfH?=
 =?us-ascii?Q?fe1eL2uK6vakypo6d/tHncAK8ant19vsvuJjnI8VB18PaX0HPZySk9jrmvkW?=
 =?us-ascii?Q?cVT3AnL2llDuEUW5wKwcqeWWKMR1OrB+WgPL+WlUgThSso4VQS3AZT5IDFOC?=
 =?us-ascii?Q?nLzJ+IlKwpkwqk/p2lSgasqsrE+smGPIHqzdIfZ0hkEwLqaKHCqMN2hdOWgC?=
 =?us-ascii?Q?pWu7ycnCOawHovgLj5pJmKh8Lj187C0DhExj5HX+48c7iunVvGcRdclZJOVJ?=
 =?us-ascii?Q?AGbXg1knfFORFt2I5PPS9e/OJKCbloTn7OLyyEh0/hYZG5zefr7+mtytHvM7?=
 =?us-ascii?Q?YnPm/gR/ktVY8RPJQDS+0yaaETn8gzGo4p+yhI9AkUyTAweRNJcu0ZIaadpM?=
 =?us-ascii?Q?BCOPIauqApWbDNyCt04w1psDKf/zbWuXTad46ZOAsUNaP5MT1GkFaZC6bgPN?=
 =?us-ascii?Q?FUCXk01Ko113EkjjxGLV0n+PK2RPTK8Gw1xJk4u6DrZpEerDHfi5MZtV8CJo?=
 =?us-ascii?Q?QRarFiuxmyublRqEysqkISx8IIx18k98AXOh1fLDz+1V1lCccqELGkg+Dzcs?=
 =?us-ascii?Q?MZ5rUITpD47qe40Na4667w+sU1W3GT4f7EhAi68B6VphiueEMiPPgbXm/33q?=
 =?us-ascii?Q?qRS7SW8RijVdH6OW+pUl2eI5MPJFF/CX5LZHFUsJGEvn54z9fcMXy1cfd50y?=
 =?us-ascii?Q?fkSdkVmdvXZpLV0kcxWmp7wDn/hh8BFa+DuUXXpInfsosTfznw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:01.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9282df3-f851-4ed2-bae4-08dcfdd5219a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

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
index de675df52913..9e321140cccd 100644
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


