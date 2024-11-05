Return-Path: <linux-kselftest+bounces-21485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C739BD6A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4819A28435B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1D215F74;
	Tue,  5 Nov 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pK/iFq8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5062215C6C;
	Tue,  5 Nov 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837152; cv=fail; b=AOmE1lUndVySX5RbixQF8hgxIMjnBRdXm4t6r8f1MlBhX9+aSbdwTmihxoFEXFu9qFORWhe+mBXlrhBJdcCcsSTQku1OSIqwPliObIeHRaweonD+DHZsFWSMYrHJMLgm/Mo5jG0AJLWmhrxmQve9cytqyaDi5UoZL9oARmSy+1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837152; c=relaxed/simple;
	bh=5xGdkKE8Q27S3x0nXfV0qHunqvEb1pkSHipd0dB7N7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb/XmMmOSICme2OMX4XGyfnkC2EhNSUMM+wltEEBm7rQLGz2yDy39tE4sgP75Waig3NrBWHXTSkllK2rqtPEp6Cl6cbJIunB2nmkDybhqEUoVd8WN919caCv8nkW8QvLDDGl144LF2PG/6L0Y1Vw8UBvL3RHmByG00UlpK0ApX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pK/iFq8L; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUPgqftBUDZQmkswkVjS49obgBnekZy0Xehw9shiMoqUHQ/m3qn4lCMPf1wsSiv/GbefjrK2r+CplZUiSiLtUggAsXbSS7ehosvxInuj8hhpJiFQC7uzdevrltp4VhpxejC7q5Y4u6exunTKmIw5eX9yK7+zTURKIiK/Q0Vw80Wdzip2/mrcNgx+hVg+7z6yxujIxJddoLDld1KCZthlj0x9FlGgyxDOhpbU1H22jZjnv68SRNXchDDQPTrnRoTXIG08q3sueg43MXkvuVaplGFAXvhNhDglprgZZWVP9gCgoocOREiBzhU7utk3+t3RErNq3H2OqIZ+3dQh9xQpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb/Wp8bs+0/YllOLVmbdWbUJBXGkr1b+RD1jk6qyIeQ=;
 b=Xkc8qwDvR5tbcCCSeuP5wrpQHuT6AHnKl/2xbKICt+1GLRopSUrUQ1hTugZqGtKTx1YxKgfCnnmP9HtMo6Spw8s75k6A1xJaEFbUc8gFPkiyczi0HizC5/2YhqMZ0xy0xR6eWUbX82sxCNNzgXb9r+K46g6hydt0V254fgM1PFSk1pNrVSuVwLYSfpPdF6dArWL52QlNQ+BbvdLBZB/JYSQ0d9IjEIhQViUuqORcAFJE4dBxqePhCEevlKgr2kkNicgSXBuu8PUviyC+EgXABu8GBrZ2EO2sDwEVUmH9dl6xx6B5aqDjJAnHsIXL2pgl8vQYzM1XR6wIpmmPgylgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb/Wp8bs+0/YllOLVmbdWbUJBXGkr1b+RD1jk6qyIeQ=;
 b=pK/iFq8LOoLLtWgH2zESxRLr4koxEX6LC3SMuL+E4DTF4VRBVWLDRslCwfGUNh94hYbM6Q9+/DcnuVf0gHn2Z5gz0mi+OHn1ivTDLJw9IdzY6r9a3GXPp8yXwU7AJ7BzAeKSCtmL1fBafsP4/6K6mJ/gY1VBD06iWz8KaAavNV5g8xDy84yF4GsXx/zo2QHASSwuDFYPUxhne25PwzXy3D9ZntzTXwXOJ5vQQDRZsWl/tsFUDJRiVqJM2Q0rVI2vhehhv5MYe28FM8x2smOGOoyuaiAgd7Ghvm6G1vZdl45vn1aMlB5+4oO3KPvRBhGin1j8GtwzTmuZMuDxiAJKvw==
Received: from MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:05:47 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::c) by MN2PR07CA0018.outlook.office365.com
 (2603:10b6:208:1a0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:26 -0800
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
Subject: [PATCH v7 01/10] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
Date: Tue, 5 Nov 2024 12:05:09 -0800
Message-ID: <cda8fd2263166e61b8191a3b3207e0d2b08545bf.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: ac416a04-5a09-468a-835d-08dcfdd53cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBXSRSUuMs7NOvLAOHq1n9ibW4fi/LPKJ7hBgmhZyHe0Bqb0EIo1qO8WLqyS?=
 =?us-ascii?Q?8qtphCy3iidWGGoQiAFLuVUjZkRzprhWCqEDhtSbFnNBkL7o/xNd5yY8APBJ?=
 =?us-ascii?Q?SKXaNM9SAiOzIKvWRRZe5UpHrKAS5IOML/ynN6Y6gBouuXD4cXqo600V9fDd?=
 =?us-ascii?Q?b3zQZjds5kVWDfzzG6bk15crVOTVnIUlUNk1DoYTT54mtg9wtpGzduuzjmk9?=
 =?us-ascii?Q?hbvpvcjm1RI5WQg1umyOuW70mS7vAc10z9HLHGxS6hrZb6ivzVSgHjBLNvaS?=
 =?us-ascii?Q?JQDABFDQ3Lg5Orj3AcU3n55gDOV2w/UHpA/QUJCStyMZZHKP3dQdCVuE3aC1?=
 =?us-ascii?Q?DZiee/pXws9wqU7ViUGHW3X4s/daacU4XENkuRuoz7ZAaLB2HpjXIRmaDK2i?=
 =?us-ascii?Q?3YjHLIjDg8vYrvqyjj52AeW2ZnihFDuYk07B+VuORxSeV/teZDwd9UId5uWm?=
 =?us-ascii?Q?06tgq3hQwfMrL1HucTWnU23KkntuAgZ9IzLAlDrlwkfSu0fOguiYsmA2kaRJ?=
 =?us-ascii?Q?iAMs7OI3tcccVHrKELOsxcPsmILJFI+e3HjbYz2B6MeoKDpca2gVrLBOT7Cc?=
 =?us-ascii?Q?pO0qQGJ5r6DReclfiwYwPdTEXyrkIA5aiZwYFBCgHBvSmnvIadO5HZ1rnFzB?=
 =?us-ascii?Q?8k+y+cFvMRIzLssXKJcidgDhimaQ0bW3JEvwElaKKo3mxdSpEujKmSTss6n4?=
 =?us-ascii?Q?TIXicyI+Vu1W6IOXjG5XSbdbof9cYuK2DEXTOBmunmdNdzjYBhCcnOOV8CmS?=
 =?us-ascii?Q?ALmJZxcm2wfiVbQtsKX8oz+3yj3nk0yqNVA1AE/PzMvNgTuM3ZImH1Wi8Ihw?=
 =?us-ascii?Q?Rx9ixosW8mAdEIbcqBvlh6hxRVxBuRYI72zH1cPn0KHHhzFeucsNOgmSdd0D?=
 =?us-ascii?Q?nhKRaUwHmiNgZGL54ZZAKY81KTjdjtxPxly3fnajdLQozWQsVXTBiRJ/gSN1?=
 =?us-ascii?Q?40oFTxOJBvi2pPiokuQR2vkquqOENlm/BWMWer8o7S1nHOMmwx9/IQKrpVMe?=
 =?us-ascii?Q?Cbrtnq+svX/rl68QOHt3Yph/+U9AJVJX2ryZgDGNz2yecspSD9INubyLFrnO?=
 =?us-ascii?Q?p2u46Oj6DXldwugT6FCaWIhWHCnVZ6KQJkmBpyjg3kuN0MGaQ2NXU05UUL/F?=
 =?us-ascii?Q?5ouIprNADcw1kEPuI+Es0mid4LmUh2sS1ffBZv56sa00+GaM863trIdmZjP3?=
 =?us-ascii?Q?7l4aad9g5tmRE7sy0YG1IpCObzqxXWdytIKlD7FIePwzrYIIZDHBqxOd/wb3?=
 =?us-ascii?Q?iuJ2PASPjMmTEKvZsPJemOxz2fyONeoS7FKwc3HFozetdNVItdXr01uCnf4Y?=
 =?us-ascii?Q?XEBygSqzOlBK/xbiZcXTpxBkiICjVOI6xzqNdr+IH/hb99H9QVp+hN0odgAV?=
 =?us-ascii?Q?cbhf+AFxMSnUs1sp43DeVtkQSwQCXDnsC8kq77T4iSrdu3/q2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:46.6912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac416a04-5a09-468a-835d-08dcfdd53cc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device (struct
device) against a vIOMMU (struct iommufd_viommu) object in a VM.

This vDEVICE object (and its structure) holds all the infos and attributes
in the VM, regarding the device related to the vIOMMU.

As an initial patch, add a per-vIOMMU virtual ID. This can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual RID on a nested Intel VT-D IOMMU, an index to a Context Table
Potentially, this vDEVICE structure would hold some vData for Confidential
Compute Architecture (CCA). Use this virtual ID to index an "vdevs" xarray
that belongs to a vIOMMU object.

Add a new ioctl for vDEVICE allocations. Since a vDEVICE is a connection
of a device object and an iommufd_viommu object, take two refcounts in the
ioctl handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++
 include/linux/iommufd.h                 |  4 ++
 include/uapi/linux/iommufd.h            | 22 +++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 76 +++++++++++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e8f5ef550cc9..062656c19a07 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,8 +507,26 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vdevice_destroy(struct iommufd_object *obj);
+
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+};
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index de9b56265c9c..71fa1e343023 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 struct device;
 struct file;
@@ -31,6 +32,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -89,6 +91,8 @@ struct iommufd_viommu {
 
 	const struct iommufd_viommu_ops *ops;
 
+	struct xarray vdevs;
+
 	unsigned int type;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index a498d4838f9a..9b5236004b8e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -53,6 +53,7 @@ enum {
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 };
 
 /**
@@ -864,4 +865,25 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The physical device to allocate a virtual instance on the vIOMMU
+ * @out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 out_vdevice_id;
+	__aligned_u64 virt_id;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index cc514f9bc3e6..d735fe04197f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -308,6 +308,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -363,6 +364,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, virt_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VDEVICE] = {
+		.destroy = iommufd_vdevice_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 888239b78667..69b88e8c7c26 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -11,6 +11,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	xa_destroy(&viommu->vdevs);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -53,6 +54,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
+	xa_init(&viommu->vdevs);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
@@ -79,3 +81,77 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_viommu *viommu = vdev->viommu;
+
+	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
+	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	refcount_dec(&viommu->obj.users);
+	put_device(vdev->dev);
+}
+
+int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vdevice_alloc *cmd = ucmd->cmd;
+	struct iommufd_vdevice *vdev, *curr;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 virt_id = cmd->virt_id;
+	int rc = 0;
+
+	/* virt_id indexes an xarray */
+	if (virt_id > ULONG_MAX)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+
+	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(vdev)) {
+		rc = PTR_ERR(vdev);
+		goto out_put_idev;
+	}
+
+	vdev->id = virt_id;
+	vdev->dev = idev->dev;
+	get_device(idev->dev);
+	vdev->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+
+	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ?: -EEXIST;
+		goto out_abort;
+	}
+
+	cmd->out_vdevice_id = vdev->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_put_idev;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


