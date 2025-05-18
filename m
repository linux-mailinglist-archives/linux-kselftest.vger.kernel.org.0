Return-Path: <linux-kselftest+bounces-33266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48132ABAD4A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C50F189C0A1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCC2116F0;
	Sun, 18 May 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="us8xTi4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786A201113;
	Sun, 18 May 2025 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538556; cv=fail; b=ObWnQAUwIgLD2kPnGp6zUesIj7a4UdVAwfKJgpzlFxnmaWEwJr3ZvC34a2UGB97T/51FF6OHb8zcEBz83OO+ACdjrr50qQxAKnJ32qaDDKyNUpN8ayrs2gE6aNiZIJZC/8rQoRSwQNMVv/6dl7kN+gGMH91YhdN+2hhkEZZo4Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538556; c=relaxed/simple;
	bh=D4qoWDx0gSoFQ3Qj7QD9gVPErKiU2n5S6D5+4cfQBkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+l1ZxN+XE0j4LaWFQ7re0YH7s3G3W8YJ6LDdsa9IhF+dIfAnyBst9+uRvLMo2vV0B+JZVBf+9kdl/6fDbcgMacGVDQXgup3bshZFWWl3DJ92Dt38NOcrsBx/XHXNFrXJAqeAHIXhzvn81llzDauZcCxkHIC9oAEpeNEm/iwZw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=us8xTi4f; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Y7CZumzoHeQo/GxDU0saTBr1UDvWuR++9DdcJUwaiIIYN87/KWImki4Nforb1iw/jalWoA9hPKs05UYN06eGDpNZHjANe4G1z40zOIE+pWpv9aaaf9RFojsdpDn8/CLv3GZKpZVac/7sT8LqQtWxVwBgMO1BkFqc5mSjkg1XjMCFWT9TbJupEmAewEsD9LtNynsc1tOgl9tV6yU/HMtBwkiLrhCZHr75LX+bjMUO8TG5guYLTIogbh385J2Hva488dMowvbPWSRKskGUAKX3ct2ZzeHheiEpgBOrK9byoFqWIXPDaKQ7vbP0MISWBP/M+TFxbPsfjJPXtdOemPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzqhrN4m8bEF1bjFaIG1G4X930K5tHrW6Zx1FM3UNt8=;
 b=KxhgRnzXcB4aD9fnS00GFHw5r/QnAOtAHRvWryZ47UuIUYs4vfggnFr+L2SxUKOKxQEXIoo65J5Ej2nNtu/BzU4TGbEWHjialNbFM8YkhYhN3OR+BbG2iJDNHtif1lZwSU+T+LZ3SDtj/gNUOE/011mJ4UES/WFPLU5onmbmhMc7mYClbGO3YoHblqYxQqIHOjogcY9FPG2ckIxRdKKlc+M2SPrEy5+163/chuafjb3rSj4lLSVF2g/TFufm6c3/FaOSSzClCjHroDl4/VYkx/iOCAEOm0aqRct2zHCS9NPrVlDEda0zq0bABYfIrUodGDBihqBTmLtgpcAE/JePpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzqhrN4m8bEF1bjFaIG1G4X930K5tHrW6Zx1FM3UNt8=;
 b=us8xTi4f4wVpzaPor638OwPcCK1sd+JLq5/zJ+hOW94t/e5Li6yGmmkIPGy4jQB46LqJYHiag5qdFlTU9dbGYS6oH27wY1YBpdpXF9gMhTf6P7M1Ol67+OzoAOvOeyMW2QcEcEVtL8lQVEu9bhTtNPxtq8NJ7yv4u8y2VpBzhxcuvY7MkbwdzQzPQFG/1gIbHCbVkx3fEDQjOMyXQjIegJrem36orGl7lSMBSzQKLuDwoGloRR5Jy53OON7cLWGp8sAFOvMaPZ1HUcjeyxjn1Onh1tfEH52gF+6Lx0DdMIf8iE1SRyry4nX/j8tuhfuSXJCy2Bh6UzR9szLP1W0/kQ==
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Sun, 18 May
 2025 03:22:28 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::d4) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Sun,
 18 May 2025 03:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:15 -0700
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
Subject: [PATCH v5 12/29] iommufd/viommu: Add driver-allocated vDEVICE support
Date: Sat, 17 May 2025 20:21:29 -0700
Message-ID: <2dc3987361637e1fb46d210c9591248962670651.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: c44fca05-4585-4d17-1c16-08dd95bb378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xVLZPBkVzetxJ6UYcJaqSS+vqgQ/y2GIVzKlPP0pMxdfmyx+vnAiXiwvrae?=
 =?us-ascii?Q?Ns6tYQ4TbQSC4YtcpBSdmcQUzTK0MmFR+WIvyy2Xtqh4i9dXsNYDIIubMYXE?=
 =?us-ascii?Q?Sx03iO30GlvTGBOItN+Dd3XlLLbho3MU4bXJZXhjuiG5vvGNY7cjiJ1bW50s?=
 =?us-ascii?Q?v8mjHagGNdZVVlrWy6Trqmi+EBdftHZbsJnIcA1s+uMWY/IHz+mvwDxYJCXu?=
 =?us-ascii?Q?hwW9/4X/ESX0Y0Ueu0Db4ZS175ucvqrRF1bMn3s93wF6En1sAcs/gOalueeU?=
 =?us-ascii?Q?aTa1C5TveRtcI+mYJ1caFmaosp6eTOUdHcnNfhIQpAXClYCizC8wBqh9AWdo?=
 =?us-ascii?Q?hl0p38RbhyghWePl100hGtyW6JpfgmvOM+fk9kAf/DJXrxbPP7r3aohB9nZd?=
 =?us-ascii?Q?8G/0kuQ8pCCNV9kAnmzfuU7e21egD9AgyDK0zC6ai9aRlZOrseWwr6/Se4+2?=
 =?us-ascii?Q?g3zh67YnygpCbd+vkai7JoCJ/J/TDHzb/SqyJolzU6uqPmVquYR358d/4BvS?=
 =?us-ascii?Q?AcjTzlXQqjh/I+dwJljM16C1P235FjG7pB4cj927HSlUtMyDIUKccPCr3a2s?=
 =?us-ascii?Q?qql++WiHm/KtmoBd4gymS53uRI27V7iqdMGPKRe3X5s5x7ozXUYp+j7uLDN3?=
 =?us-ascii?Q?eVcmL+YZ9JWqzMyLPNqHKXFxEUdNm9J5rVA2zReq1qdBOvpGJ1Y+NbloPZPA?=
 =?us-ascii?Q?beYUNp5MKju9wXgjhvOiDdYgP3mK26cLhfdjnJxAhM8b5123nlYaFycYV87G?=
 =?us-ascii?Q?nmiqCCci9xDEGpQOeFqLqtxHVc5EHvQ0NEvDN9ZGSBr4aJTRNSkTS8qPwnKD?=
 =?us-ascii?Q?eCxuw10jCGcixtmn4aKiv86FZvaRGEfRKHhVW1GiSQv7MK1jzSaH+zq7a8bw?=
 =?us-ascii?Q?CufmwHTpvF6OJ5A87BFmr4z3Jya+VsG19ZMSOe3dD8jwqnUfj3bNDFRlP0fI?=
 =?us-ascii?Q?gF8SqW7q0gYz6ObksC21Jq8YbBBz+8kH4ehBq2leZwLSQUpNhFYvGk+PUZ5s?=
 =?us-ascii?Q?hhTNeIbDTAFMSXe9ui/6F5cRLW/GiD2emFnqeQo5HF44ihnERPwDgACHDeDQ?=
 =?us-ascii?Q?5TYCWi3OcqRscdfrF8dx15M9I/EJtpPv3jwjdiMd0wmi2yWQw2OnFiHGtlvp?=
 =?us-ascii?Q?Zh6c6TzJ1kYvjnFpOlCBVeKbpRMXIuiCcko25bHoNcoQ2mSsrKy8pZhLv0ov?=
 =?us-ascii?Q?UzzAJ1/sl7ulkmdbYF71b72eOqIhVy2qF3Oc2NFFRvAPYGZU/Lt0VFrWi9go?=
 =?us-ascii?Q?EJh1ivAskKZyRVmrFfBknsZKB8bGsVC65OlkyMz5DfxuNSDxvHFpALRSkF9/?=
 =?us-ascii?Q?2YzSfKTo4Bs3c1GlNh02/04PiF4lXzMurCNgF+0KPfyd+vI5EqM3K6SpSRtR?=
 =?us-ascii?Q?wyjqxpjax2GSKKsn23HAILdnt1mIbFoK5YZ/bWrh6fp4IWhWVDUzuf/3eGmu?=
 =?us-ascii?Q?lmk9HQY8LemUdH2R82+WTN6I2d+NbFim9YlWWDq+AoSdGeKSegkqorUnVu9F?=
 =?us-ascii?Q?E5+FF96KxMcJ+yn/FXabYKHflA3I2S3Te7nU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:27.8908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c44fca05-4585-4d17-1c16-08dd95bb378e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

To allow IOMMU drivers to allocate own vDEVICE structures, move the struct
iommufd_vdevice to the public header and provide a pair of viommu ops.

The iommufd_vdevice_alloc_ioctl will prioritize the callback function from
the viommu ops, i.e. a driver-allocated vDEVICE.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  8 ------
 include/linux/iommufd.h                 | 36 +++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c          | 10 ++++++-
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 44286216ac5a..35088478cb07 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -604,14 +604,6 @@ void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
 
-struct iommufd_vdevice {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_viommu *viommu;
-	struct device *dev;
-	u64 id; /* per-vIOMMU virtual ID */
-};
-
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index a07466333c48..266ac6805213 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -125,6 +125,14 @@ struct iommufd_viommu {
 	unsigned int type;
 };
 
+struct iommufd_vdevice {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 id; /* per-vIOMMU virtual ID */
+};
+
 /**
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
@@ -141,6 +149,15 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
+ *                 or HW procedure. Note that the core-level structure is filled
+ *                 by the iommufd core after calling this op. @virt_id carries a
+ *                 per-vIOMMU virtual ID (refer to struct iommu_vdevice_alloc in
+ *                 include/uapi/linux/iommufd.h) for the driver to initialize HW
+ *                 for an attached physical device.
+ * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
+ *                   The memory of the vDEVICE will be free-ed by iommufd core
+ *                   after calling this op
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -149,6 +166,11 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_ucmd *ucmd,
+						 struct iommufd_viommu *viommu,
+						 struct device *dev,
+						 u64 virt_id);
+	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -276,4 +298,18 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		}                                                              \
 		ret;                                                           \
 	})
+
+#define iommufd_vdevice_alloc(ucmd, viommu, drv_struct, member)                \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu, *viommu));    \
+		ret = (drv_struct *)__iommufd_object_alloc_ucmd(               \
+			ucmd, ret, IOMMUFD_OBJ_VDEVICE, member.obj);           \
+		if (!IS_ERR(ret)) {                                            \
+			ret->member.viommu = viommu;                           \
+			ret->member.ictx = viommu->ictx;                       \
+		}                                                              \
+		ret;                                                           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 662f5c1b1935..7248fb7c7baf 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -95,6 +95,9 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
 
+	if (viommu->ops && viommu->ops->vdevice_destroy)
+		viommu->ops->vdevice_destroy(vdev);
+
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
@@ -129,7 +132,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
-	vdev = iommufd_object_alloc_ucmd(ucmd, vdev, IOMMUFD_OBJ_VDEVICE);
+	if (viommu->ops && viommu->ops->vdevice_alloc)
+		vdev = viommu->ops->vdevice_alloc(ucmd, viommu, idev->dev,
+						  virt_id);
+	else
+		vdev = iommufd_object_alloc_ucmd(ucmd, vdev,
+						 IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_put_idev;
-- 
2.43.0


