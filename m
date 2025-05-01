Return-Path: <linux-kselftest+bounces-32123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED9AA6713
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA68D3AB7D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4A27A464;
	Thu,  1 May 2025 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsqvOqFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46ED27A444;
	Thu,  1 May 2025 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140542; cv=fail; b=tzuEpN17KwCxGenbEY466paouyCOxV6MhVLxGcwXi0iqLFEoRKp8fGQ+HS2qo3XNwf+1472cY76vW6rlEOYdfwfLSgLSHMHPwKZrYJZ4YuGKd5Quk53FgLMjZsTLjnmrtWPm9EGZORHGEZPQvfapUvqHsaiqsnsU11YSE42HcZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140542; c=relaxed/simple;
	bh=LxPv0PlPqyw/qOwCzbYx0w2eLP9FGU+0of7uaiKZccU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlL+Vdaho3Kc9ue5Vf256g+ORdAtg5XJovGcM/5ia1wYuLBg/CsHNWY4UUd9GcQBaMwszZHXsOJ3ISYoN1sd9V9FrWZdETFCENC/GkH3FePArJiv1qXfY2LgvXviPQ4MXuzpNdMqGBWCG93E2KK6IQXF5jkN4nSATXOkP4UzC2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsqvOqFb; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glPEG98zhPWhe9dZbi4zaFpjC9drZZLyO4Dl6WsNogrCV7tUJh6aqpPW9icOYi6AS+FAmq3PkWJbkX8mLJFDG0D8WdwvcF5Lxe9TZrCvRGBnqsxUaI7RdD67tD7LDPSLWfZRNOQ3pi5nvT7PZJxydl1rmrLYvPua9mj3694pWC0Gk2SzQZ0nKJfoLtn2qOPyTAwi4c9w5Yv/IrcTsrfgNFfp0KGKjbPmQQZnJOODVDRd9zNmt0lJ+h9mA8obFV2T0/Jp0NgNpiJkaT3ssoZ+gWFdNUQiu/x6QmNgGjlF9H+BVBbClUo9h0Mf1m8oUrvEfVlPsAcRBzONdGK7vQi5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AThxCvd9CIegOd62FhY1SN/SWoDbT3agVYt/hu8+2t8=;
 b=aTSXa2Da+ZkvXR3vRff4nXiRs2tIYZX18WB9nEvXdqrhToFtzUPPoDfFfKrdDfxEauzrG51nPu1dc04qTvwAHYZr+Q7joVVJUAeCnzFpyECMVA1K3u5IJ5FRdsWjqQXFiuu+E3e2JHiR+D/y6cjn9inFrs2l8DA3t2gfbEstpUdz/yNqBvNrQHJSOLe9m/GXt6EQCElVHitXUXIN7KSs15rNfIPdzbXBN9SqLWiK9+GFFV+3TUPQsfbXb0LqAlFQXvjJzUy6rDbW4JUb5SDMP00Jbgc/PrbNaHGSUrqW1tMAuG08fy8HvdMmWGYgXdPGlJmFi0tlHvYMRXKWYa1fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AThxCvd9CIegOd62FhY1SN/SWoDbT3agVYt/hu8+2t8=;
 b=JsqvOqFbFkSx8X9csfXV2CJIbbus9nzfOVxho8ZEjgOyMtlZkljMCZT4hWvht+XoAF9dgal7dhovB6WAJTfYb9FZovunDARV6GZBOIez4ntx7jNbP30gD2hOO8hA1pDTSmproWkf4CM4OLRLb6/ZMBiOYSqDX52CtPh1nphYNaksgs6ubWcvei78mLvbqmCoSUk7JEzYTSqCU5yi2CkrgDVAqxvAjiAZi7rFB3XXPWk0MdAse5EDrrXLrVWTugm0GvmvRun23dn9cLwHWFeqEQVQMm3RmylawpdOU88etgbvbYHcazNSdKs2LMQncudV19BeVrnHESuNIBCckIEY1A==
Received: from SA1P222CA0100.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::6)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 1 May
 2025 23:02:16 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::a) by SA1P222CA0100.outlook.office365.com
 (2603:10b6:806:35e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:01 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v3 12/23] iommufd/driver: Add iommufd_vqueue_depend/undepend() helpers
Date: Thu, 1 May 2025 16:01:18 -0700
Message-ID: <0f24731bc94c7cde84d2a6bfaec6095a55072e01.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 186a9331-46e9-4a7e-691c-08dd890437b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mj2pdACcfuEPe9fJ7HBUIl5MkuNVBmDVfK5z7zPhhmsWWdvGUzLAxBhO7PI5?=
 =?us-ascii?Q?Yp4MFmCjE2mlAmMAGN/n7bY4VA+1yU8T/qRJVitfVBUOowFqRWi2MstfWuIi?=
 =?us-ascii?Q?/U2rM96w0O4X934pG0e/O0Upo+6unEiPPZtmQcQLIyM/WIofMMWhd3gZ4/L7?=
 =?us-ascii?Q?MjkU0m/SE7b80hgpEBaylKP56QOunJKSo54+Fx+ABDd95/W7Z+iwg4TRwX48?=
 =?us-ascii?Q?q7hzIcjuhgXVzHEhbYLqujMHmTaaRAeNTMMRaf0afbixurCj/q8Owuve66zf?=
 =?us-ascii?Q?BK9LcB7FhxD+2zMVrPLj36t18ODcGMpQP0vKi3DV7TxFtqavIxfseZlEdHdy?=
 =?us-ascii?Q?0JFp020eWewHd2Ifktbf22zTM/RBBrflSzT3YZ/SafB8jrQ/zMtwM3xQOmDH?=
 =?us-ascii?Q?P8KZ2/ZsrwaKWHwBvcJjzRJ0lxyt7OIGNeRxJf6NVkemwv+Ww+O4dhWj+woW?=
 =?us-ascii?Q?bpZua1YWkIxbD/P872c+N2y0MFfcdqHEUj3+pdTNlpXFwf5cXtcARu0IlD24?=
 =?us-ascii?Q?sRYSPnrODFU3I1i6Wl96r6sL9ZEAax9VfOO9HmeTvc9DWuWjc9w449reVFrn?=
 =?us-ascii?Q?BLJCY7nKiLmiQO9mxWHabIYrNt7mru/TDc72sJWWVSawZKnPpHxL/ovpB5kI?=
 =?us-ascii?Q?FH8gmQ4s+EnqYb68wuv3qsbuOlHjzFpieJ7RfClxJQrX0PFdoxy7BKYdBuhd?=
 =?us-ascii?Q?vsEvOgB1c3yYufWNOpoGObuXN/YeE2T6KJaKy7FhfK32YajXmX2fusTRQiAS?=
 =?us-ascii?Q?F+vHPGXqqlWNi58Sdy8Uu6h+aZPoJAI+5NYcZ/sVtkNRREH679LXRHByFOMf?=
 =?us-ascii?Q?dArPDJfbvN+hC3tHRk/z5gh8UVdUpEK2xxbJH2zM7zCZacxZ0OsBmfZG79Js?=
 =?us-ascii?Q?SF0MUS4S1+X33s2azdlJM17tv6tA1gY9n1rJtpu2ci0HZitYCdUNXzIr8CTQ?=
 =?us-ascii?Q?mUZQUWVXLhRGuCc6BUiFaQoAx3/aw7eHDInu9Q5t0LyTWFDwj0FWi2/yDQk6?=
 =?us-ascii?Q?zbGZo6OcHLDMjEHudvc3ylTehU4fzR+ESfIKTWLdmdmby2VivyIqlV/GvRuZ?=
 =?us-ascii?Q?KXEJLiffA7xHUzCKQZjjyH/CJgS5mYO0nCGF2hz5X13WTeV7yQcVZ/hdlgUS?=
 =?us-ascii?Q?FvpCTxVPsyjUbVAkn+6AxSDrlb/4vTGcY98L/HuQYeviA/UkftfesHEJXuDr?=
 =?us-ascii?Q?0zLMNrWei/VPSuIM79m3FLWciN9Gx5RN+eWqAhucj7pzbCinugdjj7tcZgOF?=
 =?us-ascii?Q?2qqAig3HsF+rlwebNbNKxFReJ9zAYcQcNg4quEKt63WrHsYIiw/hy/KOyHLw?=
 =?us-ascii?Q?gHRqaSUhZTzvs1VHpR9ZYa3hiC8jdHkAVnDs5qM4rcKXoT/SHJ4N8yMjUgOY?=
 =?us-ascii?Q?tu1f40TIFDXu+2m2/Hf4e8UR+/ZNS/gO/o9yU1ioW/eJV5kzA8YG8v1vGVe7?=
 =?us-ascii?Q?8k7BsLjJOCVIsOulaZNplriIT0fWuCfZwYGXv2LdUrA7cVGwUtfwX0sMh6+S?=
 =?us-ascii?Q?TxKPrtybZ3+tp9Qq9omAvNMU9ZRD31HJGBH3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:16.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186a9331-46e9-4a7e-691c-08dd890437b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_vqueue_depend/undepend() for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case. And encourage to
use the macro version that currently supports the vQUEUE objects only.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 48 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 676b54c5cf53..cbe9910dbdff 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -235,6 +235,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -255,6 +259,18 @@ static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
 {
 }
 
+static inline int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+					 struct iommufd_object *obj_depended)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+_iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			 struct iommufd_object *obj_depended)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -339,4 +355,36 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		iommufd_object_abort(drv_struct->member.ictx,                  \
 				     &drv_struct->member.obj);                 \
 	})
+
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_vqueue_depend(vqueue_dependent, vqueue_depended, member)       \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_vqueue,               \
+					  vqueue_dependent->member));          \
+		static_assert(offsetof(typeof(*vqueue_dependent),              \
+					      member.obj) == 0);               \
+		static_assert(__same_type(struct iommufd_vqueue,               \
+					  vqueue_depended->member));           \
+		static_assert(offsetof(typeof(*vqueue_depended),               \
+					      member.obj) == 0);               \
+		_iommufd_object_depend(&vqueue_dependent->member.obj,          \
+				       &vqueue_depended->member.obj);          \
+	})
+
+#define iommufd_vqueue_undepend(vqueue_dependent, vqueue_depended, member)     \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_vqueue,               \
+					  vqueue_dependent->member));          \
+		static_assert(offsetof(typeof(*vqueue_dependent),              \
+					      member.obj) == 0);               \
+		static_assert(__same_type(struct iommufd_vqueue,               \
+					  vqueue_depended->member));           \
+		static_assert(offsetof(typeof(*vqueue_depended),               \
+					      member.obj) == 0);               \
+		_iommufd_object_undepend(&vqueue_dependent->member.obj,        \
+					 &vqueue_depended->member.obj);        \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 7980a09761c2..0bcf0438d255 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -50,6 +50,34 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
 
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended)
+{
+	/* Reject self dependency that dead locks */
+	if (obj_dependent == obj_depended)
+		return -EINVAL;
+	/* Only support dependency between two objects of the same type */
+	if (obj_dependent->type != obj_depended->type)
+		return -EINVAL;
+
+	refcount_inc(&obj_depended->users);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_depend, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended)
+{
+	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
+			 obj_dependent->type != obj_depended->type))
+		return;
+
+	refcount_dec(&obj_depended->users);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
-- 
2.43.0


