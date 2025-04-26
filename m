Return-Path: <linux-kselftest+bounces-31683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01114A9D7E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603B4174A28
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A764F1FECBF;
	Sat, 26 Apr 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tk/OxJRN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD811FBEA4;
	Sat, 26 Apr 2025 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647162; cv=fail; b=p5MbaOcP94mD23/LGz3HeJ1T4QiE1PfPcUpwqOsk0EM36dMhuizGF+xgDitI0UpLcQywA5mZ3KJR/yZzTtmgEKg6f9dOSYocI+hTQ0npEqvlR+Up8xEm8BV2IvJMF++EQzUE6eLTADPJNJMhYJzag1dag/5JnZhB6wLBbgt8ZYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647162; c=relaxed/simple;
	bh=9a9s0TmnltXpFaLvdjQ/teZD2WwNmTTIoYG2AhuISyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s69epJOnqTL6o3pM3WTPXl/woZ+iGGNLlVpdAPYAG1y02ipuPbRXGAG274oQK3cZ1iJyi0TJngQbXwKncb8nuwvMArlmGg8nlMKFfaQi9CNtEm74uzKF8UB2dnPyXGFaxO++1dfTJvs8f5Puu1pDav5GnNA05M8PJsaIoX+Mghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tk/OxJRN; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyjCK+ncRRIkCJNK37IEeybELtig+z9PSHuXn1h37QM5phLabW+G5FO3BAZn/0Aw+O980x30Nlv0hx2jyboMb5/bd/KSX3hkzp2Djk5za6akDJy6MzVPGn73gEb0temQx5aPqCp7AnvLr3LjrmDSjpfrp1u5iLZQPC5SWBTvsmsOco0gd2yVuB/9LtNNnV/pwL9SBpwjNA9ZGOw37s3tIoPGZMBqVUSX644UETztJ3O7sDk1MG5xvkLEG6op1PFrEAQNjp6FcNPkjZeVw+ZN6cyOiyS8Vt9CqnDIondKdAGOzOeEqGImSRPt6CZsjlEXfDcOBIQX8fipQ15EgF4mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExNGKWLch23x8AVHhYe7HQuXaiL+u6muNtas+zt8/7o=;
 b=vODJW7e6mdvnlYU7WY1ClnTAPN/dubJE5J3RHmne7VBVZfdBD0ipD4Rtxi8j8Ci7CWkHNFLoUVvH1i0bSYnRiGo7wuNH4OUViTVOjv1RtRbgpdUWd01fx4MDgovEexFYvsbQxRI19BigI5lIlRcn6t6yLg6pNF97wb9O8hzdZbeJUzVonab1MxIH4UTKQQbjd+P02m82iNetEedNCu0KQlQFYLSJv4/VY0fBTUCw+cGMmAFhKbHnXGmiaodTtlHUGY+dX0ag5JCsg6XEOuGcNbd7HsS2TsSNWJQhbuUDcjuFGRmgbi9tfUwSU/7C2uweiw3tRfPbeMsoaX68gnSV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExNGKWLch23x8AVHhYe7HQuXaiL+u6muNtas+zt8/7o=;
 b=Tk/OxJRNfycszY77Hq+RV/D885Jw2n0PwiOryEt4EzfyeyBooLGyq9u3Ht5gl669rkrBeqWcJZ7xYkiJVibIvdtb7RRQ6CDOVsQAwVaWL6gSj+Yn+aK1aAF4+H2vjjBO3P2Kjl7ryFHerDmUFHL0TPRcZKbFLBPjca0J2WwZJ0lnh5lgikmWZEatKjCVV5SbIhJma1qaLUyKPddX4XVvvVymsXDlg4AbEqW7dTVW9uv3WI/zk6ifQCbOPzB8rPrPpMbUXuEeJaVxb3CA2X2iyd5l59mHzx5xwK3ma4kESwSZv4apPcoXsx4EiWZ6i2F5185Ljv6jceFSZ3bDTdgSeA==
Received: from SN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:805:f2::32)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Sat, 26 Apr
 2025 05:59:16 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:f2:cafe::d9) by SN6PR04CA0091.outlook.office365.com
 (2603:10b6:805:f2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Sat,
 26 Apr 2025 05:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:03 -0700
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
Subject: [PATCH v2 11/22] iommufd: Add for-driver helpers iommufd_vcmdq_depend/undepend()
Date: Fri, 25 Apr 2025 22:58:06 -0700
Message-ID: <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a30878-5ad2-4d34-6a52-08dd848779fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jiOh98bVubUBMLIUsSAr8amInNtkQ6SIcdh6jVOeXYjS/I+uqNBLkba1yt0w?=
 =?us-ascii?Q?V5xK6v6YpnW2fnYB1lRZN+b8vaRRzo3e/rFFHbIezOfTLgbc3evhTtvsuAsy?=
 =?us-ascii?Q?F9o2YAqiILwrmrANtQGmVil/pfS/voPlWoTFy90tLApMgDrb1Ys7M93eZDba?=
 =?us-ascii?Q?7t+waognOtRBPwymoV8Ktf42ElswcjaNDH6axwt1vvlN7cWp/3C8UA20lriS?=
 =?us-ascii?Q?xflbZrAe7d2FS6+ckJ5zQ/vjYo91wjF41m/tu/PanWo//q9EmEjHANMZOUfR?=
 =?us-ascii?Q?nStibV5Fj+Z3Q6kn3uQ/wb34W4mDLSk1EbWms4lgPz+sZBwiuaGtWscbrjzN?=
 =?us-ascii?Q?PQIBMv6Jb0BR5WJ2iIHkl7KF32nV+CkEGdb3ngi7WVjp45O8jMaqT1AkVCbx?=
 =?us-ascii?Q?yV/eNEm61WqRqr10wUK/MNMEY0WKOYNvMp14ZmlpRdOZ75Z+L10i0uR7H4Yx?=
 =?us-ascii?Q?PXDlXbTMVvIUfg7gHRSw4b2pMCvop2fpIGmF27RN4frxfpkx7xpDrNtiLZFL?=
 =?us-ascii?Q?5484K1nhfBBFyBi4GXfEABJ6RCw/vM4z03R+L+fl/dEtV9QJs2AJVh2ANas+?=
 =?us-ascii?Q?5Z22Aydswk1EDomt8Ri8yxp6LtVnnpS0DUT99qmF4kTJMHy5mYB/RkaDv/xA?=
 =?us-ascii?Q?sgSwS74bOn1EH94FuG6mfQsvuHtnrLw9oKrzV/9yLF1WLVIVf2R7JioQ4P1E?=
 =?us-ascii?Q?sKVX3cVMqUpl2laGI8qfEjoj5XGMmZH+F6beXEv8QgvOylhQo5TbdVnNR2vh?=
 =?us-ascii?Q?AjAXweI9T3R2BsqfLQDire3KsQH6P/QVhCC8gfPWNIZaUjxK+e37A3rb0ZwF?=
 =?us-ascii?Q?xdB/jIF38iI3MNmqp+2FBLkCEQixzrdLMZfwtXSS3ApC3sHfrQ6dKmQm9Zdl?=
 =?us-ascii?Q?c4EItLDpPXJo6U/RXYzJth7uDR7Me0lrdVi87G7Evh9wIB5BJyoGzImQb6o3?=
 =?us-ascii?Q?opFET/2YhgGn8RdfHelsywO4SwHfBKz6jLF/FTlVljg3Bin3V/tM0UXVemJQ?=
 =?us-ascii?Q?7wGSCXs0im5YxWGxebgtRmCkEXKGPkcYASBXGaT5KgXHlgp2J2fhA2OyQWo/?=
 =?us-ascii?Q?aPEXrqUYOMtDDJAXBm3Ry3/VUzD16WlXVcThGgW1IPHCReO6CyeQvLGAKIo7?=
 =?us-ascii?Q?Ptu+BhGnzYADnrPM9Lsocv9lGWc8nwM0f40HTj6v+wdrQQQ96skwZby0rFUN?=
 =?us-ascii?Q?kpDrxzZAhujXYThMdQjnxR8Q3TN6mh0tEv6X817TONS3kG8cG+pYi71J0I7a?=
 =?us-ascii?Q?ead0ECKsVMH3Jjn68Y9vsTOal0AOGvLPVRzrSfzSpTlq/J9Kr25h8+CAqcEM?=
 =?us-ascii?Q?AGcrrwBcYYHnMeSsepO6/bEf9uhkYVJmOHvg+zBM+rCcuh1cHnsrCm8LDDxp?=
 =?us-ascii?Q?fctgww4B5ebm5NIrh5scYx7jKuH85nq0jqLn4PkGqxSV7JU7qIu07dPg1OTj?=
 =?us-ascii?Q?/vPklMnzlFzH7pu8UzhpVDtE6Zd2imBQXp4VEYmd9uFPULrFrisk6LZuAJ3j?=
 =?us-ascii?Q?+0n5jw/Kimu1/WrEtSH7k8+M8JvlHKFfNInh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:15.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a30878-5ad2-4d34-6a52-08dd848779fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler, however it can't do the same for an unmapping since
the destroy op returns void.

Add iommufd_vcmdq_depend/undepend() for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec().

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 47 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index e91381aaec5a..5dff154e8ce1 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -232,6 +232,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
+int iommufd_object_depend(struct iommufd_object *obj_dependent,
+			  struct iommufd_object *obj_depended);
+void iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			     struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -252,6 +256,17 @@ static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
 {
 }
 
+static inline int iommufd_object_depend(struct iommufd_object *obj_dependent,
+					struct iommufd_object *obj_depended)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommufd_object_undepend(struct iommufd_object *obj_dependent,
+					   struct iommufd_object *obj_depended)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -329,4 +344,36 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		static_assert(offsetof(typeof(*drv_struct), member.obj) == 0); \
 		iommufd_object_abort(ictx, &drv_struct->member.obj);           \
 	})
+
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_vcmdq_depend(vcmdq_dependent, vcmdq_depended, member)          \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_object,               \
+					  vcmdq_dependent->member.obj));       \
+		static_assert(offsetof(typeof(*vcmdq_dependent),               \
+					      member.obj) == 0);               \
+		static_assert(__same_type(struct iommufd_object,               \
+					  vcmdq_depended->member.obj));        \
+		static_assert(offsetof(typeof(*vcmdq_depended),                \
+					      member.obj) == 0);               \
+		iommufd_object_depend(&vcmdq_dependent->member.obj,            \
+				      &vcmdq_depended->member.obj);            \
+	})
+
+#define iommufd_vcmdq_undepend(vcmdq_dependent, vcmdq_depended, member)        \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_object,               \
+					  vcmdq_dependent->member.obj));       \
+		static_assert(offsetof(typeof(*vcmdq_dependent),               \
+					      member.obj) == 0);               \
+		static_assert(__same_type(struct iommufd_object,               \
+					  vcmdq_depended->member.obj));        \
+		static_assert(offsetof(typeof(*vcmdq_depended),                \
+					      member.obj) == 0);               \
+		iommufd_object_undepend(&vcmdq_dependent->member.obj,          \
+					&vcmdq_depended->member.obj);          \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 7980a09761c2..fb7f8fe40f95 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -50,6 +50,34 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
 
+/* A per-structure helper is available in include/linux/iommufd.h */
+int iommufd_object_depend(struct iommufd_object *obj_dependent,
+			  struct iommufd_object *obj_depended)
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
+EXPORT_SYMBOL_NS_GPL(iommufd_object_depend, "IOMMUFD");
+
+/* A per-structure helper is available in include/linux/iommufd.h */
+void iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			     struct iommufd_object *obj_depended)
+{
+	if (WARN_ON_ONCE(obj_dependent == obj_depended ||
+			 obj_dependent->type != obj_depended->type))
+		return;
+
+	refcount_dec(&obj_depended->users);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
-- 
2.43.0


