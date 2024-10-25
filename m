Return-Path: <linux-kselftest+bounces-20735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7579B1383
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04921C21A48
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44D2161F6;
	Fri, 25 Oct 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mchuk+eS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C68215C67;
	Fri, 25 Oct 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900263; cv=fail; b=iHCiV+gVSqVCASLRK251nVjznx+jQk6AwT/JjhBdteP331YRi5MwmOJYSIYJe8Y0mpuRXDnLk3R/wlZPOz75IoeEEuNuNq9ZwQy6W2vunwM7A2t832DQFjgS8tcSjMGVyP2GOkdHQECkW/z6x6zYhR1N3tBqDs8IDoXoejck/4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900263; c=relaxed/simple;
	bh=FOBlebnyDihh8AbKGQ7xYR8v5Q80CG+iYvdsdbC5ru0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO3/rZf88hZfccx0p+s1KssfnuBVo8fr5iL/Jg7Bh263fazUU504JPdIHNgauIYV0bwhuN2jwNus4SetJdouo72+ybEUJhQBNA5zgKujKdDHaoPfb22yKVg4F1tDo9E+v6LGYcJCJ+vPRaWto+Q+pobro/NYqL8/mn9iiSAybTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mchuk+eS; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAlvD6eZtCSevCXeLSNPXv2V+C3j+1HI/u4J9LwpZmor2Z0NFPTDxCS6YXV4n8a9m2DjLUqFXm2gTH6JIwLCi4zT3cDdQQ2SpzYeEK9SfqaSRxoZpjqb1AVF4WrSPv/ayjhiWeGmWO9QvKsuD+XJD366tZiPSeyVn1X9+D/R+yS/skq04y08Z9aJ0dDk/rW06UncBkxQCPzW/h6C+mP6sNK0UykW3nF76VQnEkWBQdGl6IUUriG534ehqwdusV/6/QvCxrkS3eYyUqLi1OiIog8GHz7icmD8fGXpPXvnbB2Ro8/oSuMU1Wpz1Q16BLWUgtC/y9Cz87bBdboMoYxvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u2vSK34F1wYUBkrCQv22GvR6cRo+SHm4fs7kHqisyY=;
 b=PjV2lwgYaEI/WOn7T6s1WO/kU77dDxi3eFzeBSmvEC9+0TC8v/rhJDBmzoZ1RUmguZRU8Qvi/M0NTS38fDcHQ0KoZzmA5d8Aa2FWczrqQDR4hFz3LSGzMR6L8vNF9owjhS+JpsENT56aRjPE09XR7iko/gmRdvn8oZI1VYfph3fd9D5Z47L7a5XtIQJbRoz6tmdQrGNSn1NXb0wPEQdXjF+UkBtYiTXgRTFja1vC85n4qg9+i0YEvG4NgL/J16/702UpP0LPVdLN3OyRTdzQLOEc8aJ3s8uRK8aSm6F9eZVPBAgv6agwZPrBy/W86O/HmIybzB/oiSFtFXKchOOQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u2vSK34F1wYUBkrCQv22GvR6cRo+SHm4fs7kHqisyY=;
 b=mchuk+eSS4zTZmVDAdKUAAiTcc1ZxTKhy/J1vBPE4WJeZ0EHVuBSu8j5i6Zc36ZUZrdHFLUKQZBxxmmhAyotJMl610N89ZOlV3oisedGc3LKZpaq6SnpOMknV0YunjoGeh/Zln1uSwddGO4BPXlhMgm+UBykKXfftIY/Pg/a8UKpVplwD+9ksbGsSUta2HwpKKfwlXpmYj+gCqnT8hQXwqc0Z9+Q5M/gHBqXBvp14Rh5Pk+Ko0GiCPR6ilHKmm/8my/kbfNu2ukQ1VjoRDizFVXEoyXXgQIaOlenLwNAZaXLBEnpuoZVAjHfJSIXkW5EHagRSiQsDMIF7JNfjgKbTg==
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 23:50:57 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::54) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:47 -0700
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
Subject: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
Date: Fri, 25 Oct 2024 16:50:30 -0700
Message-ID: <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|BL4PR12MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: a86f6a58-8eb0-44da-268e-08dcf54fdf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joZ2axU1RRVx9pcVFnSeyWXY7HXZvNSeLC038O4J1BDrC/R1iDFA9w4Z6Ef+?=
 =?us-ascii?Q?erCGRGsi7Z6JOKNNV9iW/O/yTTl2q/nMYBWhCTqSDSzQzEo/ZU2iOum5ng6m?=
 =?us-ascii?Q?AsAsd33hZ5U1TZ6H4/cPe7rAHCEMHO286HocU9UW9+vPsNG2YuqmkkzqaSNu?=
 =?us-ascii?Q?nZUovUYjLhPPl1pA8s1k7Jap8aFgarpxH7yU20+ARjH4xUh4jz8Rfo7tzlW7?=
 =?us-ascii?Q?b3caN5YYdrqPVU9aXrV+WR4T0aRq8fiDl3135U/dJtXhDaLNdiv7+bNjTjRn?=
 =?us-ascii?Q?LwPiMiqQKPYDOmKMgXjvW+xBFaBPDGScaQpezjkWT7h3TeOmTbnXgw78JqQf?=
 =?us-ascii?Q?zx1WKyr36RuqKcuQk0LdxvcqCSIRE/gWTpVBFN+1nAUqZ8ZZKxgrggxBfCRN?=
 =?us-ascii?Q?/yzsjNKTnCxAujeHh4TU919AryhB1ILOVF+/v3oBykSbvcy6Nt3wnhtdWW5I?=
 =?us-ascii?Q?atgo8jw/d7IqQYznwQnWlm+LygbKSFAPRqZIP+yKBT8NXdl5rXpA35pKxHwm?=
 =?us-ascii?Q?EQXcl1PzfYdXMMeXUOcC2hUoBkl/d+2SemL4did7TWcDZtK6MPA53gm8L7kK?=
 =?us-ascii?Q?peKdD23oWLNV3HC8/nOPEGGj3oOVYJTdLEy0zdM2W2+z8D6yOclM+dSV2vhM?=
 =?us-ascii?Q?0QoqjASjPLFoDWGtnJ3JGaKakO/svyAff08brNxMqjBCSmuCkpVoDuGOSl6k?=
 =?us-ascii?Q?hHmEOk9wIKvyDBNQlrPDYinP2aVK0T+UDtVQo4T23+GBrpP9Qy9xe3Ps9F5d?=
 =?us-ascii?Q?8GAlP6cHOJ4poxEfexCzLDpNQNtriH1Y4Azrc/b+5o93fZrQe6EyAiQmoxPn?=
 =?us-ascii?Q?bNm4hj5AzI2U6o9cejfS1QycoSWtNnrusBxnx+MnpZz6JE8/cUwvf+8yWXnV?=
 =?us-ascii?Q?0/WLm59CxO1lJHW7aWRl7y8WyYAdh58j9loMULKTnzSKTHucptzBHDV//ucR?=
 =?us-ascii?Q?yFl1Hhx7EHpUc11MwBbY7T1AMzNLOd0vNr34au44BP4j6mQhkB6cs5t9zrxJ?=
 =?us-ascii?Q?bN9qvP2FHIsdNl2BIIhCdt1F8NcI9v26gCNKIOQaPWOd02PugTW5DDwSLtYc?=
 =?us-ascii?Q?hplDr8PZ90iCTcxc47yWy7ycm5WcfYQssntLdrHM8fVw5WkS576Y2lpqGY74?=
 =?us-ascii?Q?CqYs4KvuBzNc73hYIUoxiqEvryDJx/ENdZrAQLugfTTnM4oHDZcpHg2pjEu3?=
 =?us-ascii?Q?piBsp+VvekcW+ZHSZ45L3FvLoE4cUXmvSneuc7QDf9PI/jqI9bgrBxj9m8vM?=
 =?us-ascii?Q?/+w4a2zt1NMBIVTn5l6qVgMshjLQ9k40SsKdc584KrJ9iDz8dFTXyo6Qwda9?=
 =?us-ascii?Q?YpwF+rkx8Qo2yvBkdWESpJgXVOw9MO0jvZYTI74DojuBVhKQYBfG9cNExxZ7?=
 =?us-ascii?Q?ZzE54a3pbpddEO/op+2G7aBDwV0ZTM7GOUcnYcTVzUi7qAtCUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:57.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86f6a58-8eb0-44da-268e-08dcf54fdf1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9480

Introduce a new IOMMUFD_OBJ_VDEVICE to represent a physical device, i.e.
iommufd_device (idev) object, against an iommufd_viommu (vIOMMU) object in
the VM. This vDEVICE object (and its structure) holds all the information
and attributes in a VM, regarding the device related to the vIOMMU.

As an initial patch, add a per-vIOMMU virtual ID. This can be:
 - Virtual StreamID on a nested ARM SMMUv3, an index to a Stream Table
 - Virtual DeviceID on a nested AMD IOMMU, an index to a Device Table
 - Virtual ID on a nested Intel VT-D IOMMU, an index to a Context Table
Potentially, this vDEVICE structure would hold some vData for Confidential
Compute Architecture (CCA). Use this virtual ID to index an "vdevs" xarray
that belongs to a vIOMMU object.

Add a new ioctl for vDEVICE allocations. Since a vDEVICE is a connection
of an iommufd_device object and an iommufd_viommu object, require both as
the ioctl inputs and take refcounts in the ioctl handler.

Then, let the idev structure hold the allocated vdev pointer with a proper
locking protection.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  20 +++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  26 ++++++
 drivers/iommu/iommufd/device.c          |  11 +++
 drivers/iommu/iommufd/main.c            |   7 ++
 drivers/iommu/iommufd/viommu.c          | 101 ++++++++++++++++++++++++
 6 files changed, 168 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8c9ab35eaea5..365cf5a56cdf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -391,6 +391,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
+	struct iommufd_vdevice *vdev;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
@@ -505,8 +506,27 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
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
+void iommufd_vdevice_abort(struct iommufd_object *obj);
+
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_device *idev;
+	struct iommufd_viommu *viommu;
+	u64 id; /* per-vIOMMU virtual ID */
+};
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 083ceb209704..e6cd288e8b83 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -31,6 +31,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VDEVICE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -89,6 +90,8 @@ struct iommufd_viommu {
 
 	const struct iommufd_viommu_ops *ops;
 
+	struct xarray vdevs;
+
 	unsigned int type;
 };
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 56c742106a45..b699ecb7aa9c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
+	IOMMUFD_CMD_VDEVICE_ALLOC = 0x90,
 };
 
 /**
@@ -896,4 +897,29 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
+ * @size: sizeof(struct iommu_vdevice_alloc)
+ * @viommu_id: vIOMMU ID to associate with the virtual device
+ * @dev_id: The pyhsical device to allocate a virtual instance on the vIOMMU
+ * @__reserved: Must be 0
+ * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
+ *           of AMD IOMMU, and vID of a nested Intel VT-d to a Context Table.
+ * @out_vdevice_id: Output virtual instance ID for the allocated object
+ * @__reserved2: Must be 0
+ *
+ * Allocate a virtual device instance (for a physical device) against a vIOMMU.
+ * This instance holds the device's information (related to its vIOMMU) in a VM.
+ */
+struct iommu_vdevice_alloc {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 virt_id;
+	__u32 out_vdevice_id;
+	__u32 __reserved2;
+};
+#define IOMMU_VDEVICE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..e50113305a9c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
+	u32 vdev_id = 0;
+
+	/* idev->vdev object should be destroyed prior, yet just in case.. */
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev)
+		vdev_id = idev->vdev->obj.id;
+	mutex_unlock(&idev->igroup->lock);
+	/* Relying on xa_lock against a race with iommufd_destroy() */
+	if (vdev_id)
+		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
+
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ab5ee325d809..696ac9e0e74b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -322,6 +322,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vdevice_alloc vdev;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -375,6 +376,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
+		 struct iommu_vdevice_alloc, __reserved2),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -513,6 +516,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VDEVICE] = {
+		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index eb41e15ebab1..2b9a9a80298d 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -12,6 +12,7 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->free)
 		viommu->ops->free(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	xa_destroy(&viommu->vdevs);
 }
 
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -70,6 +71,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	 */
 	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
 
+	xa_init(&viommu->vdevs);
 	refcount_inc(&viommu->hwpt->common.obj.users);
 
 	cmd->out_viommu_id = viommu->obj.id;
@@ -87,3 +89,102 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vdevice_abort(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *old,
+		*vdev = container_of(obj, struct iommufd_vdevice, obj);
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
+	if (old)
+		WARN_ON(old != vdev);
+
+	refcount_dec(&viommu->obj.users);
+	refcount_dec(&idev->obj.users);
+	idev->vdev = NULL;
+}
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+
+	mutex_lock(&vdev->idev->igroup->lock);
+	iommufd_vdevice_abort(obj);
+	mutex_unlock(&vdev->idev->igroup->lock);
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
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
+	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (IS_ERR(vdev)) {
+		rc = PTR_ERR(vdev);
+		goto out_unlock_igroup;
+	}
+
+	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &vdev->obj);
+	if (rc) {
+		kfree(vdev);
+		goto out_unlock_igroup;
+	}
+
+	vdev->idev = idev;
+	vdev->id = virt_id;
+	vdev->viommu = viommu;
+
+	idev->vdev = vdev;
+	refcount_inc(&idev->obj.users);
+	refcount_inc(&viommu->obj.users);
+
+	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ?: -EBUSY;
+		goto out_abort;
+	}
+
+	cmd->out_vdevice_id = vdev->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
+	goto out_unlock_igroup;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


