Return-Path: <linux-kselftest+bounces-33269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A074ABAD50
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6657A7E1F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B062185B1;
	Sun, 18 May 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTxKaj+a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551C142E77;
	Sun, 18 May 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538560; cv=fail; b=Ga4e5JbBHV5OE9/yczs+tMFAZyaY1wh6R2JQ/1h3YZlJfhY/jPgoIP0iopAzB3zPeqVRlQNiIy52n6aupPuayEzr5C3FaK870ZBAa/XfylDFKrUxrlk+OTS2rDM3bs6/hEoe3VysFwlEuYem9tWMJtZaGFD9UzGiiojBDnxMQn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538560; c=relaxed/simple;
	bh=ONNLpzvoeb7+gtrl2GFK/qn+9S0np0okaN50IMqviBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6wXZEsMkRFzXzZVbM3glO0f8Id/ltvTXb84iQg0A7M8tGD0G6JXCq7e3XaNPmcCQybUITrYANjOdWqD+Rp/uAY9iDYsjSWUDsvkgpHNVzkefnMAo0c9pIhojY5lnL7WE1KwG6LGkO6VebFhpikqkMUOE1KZYdp54Vsq7AXyn+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTxKaj+a; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq3qJhGEZwjlYGfyPWRylj1EDlYoZcsw+ph3fL5dV7SESlTZnkEVZD/UcFkpXFVCZGnVfbVv6utXGp/wQ03ee/B3SsisbMGk2TgBzqQEIcrFa9kOD339hZoyhoOu6FB+MgA7Tjb2XqmW/4kHoiWr0jruV5EMPh6yXzOU32DoE7736AaZYeN/80b3QVGaOJyCevHxeH7xfMqvAGz7aH7jR68qPtqT5CYJxP4hHhUlhJ2hIubHkHjhig7Y0E8cMJtmZPgKKMdM0WZv3Q+g6u4Pa8Ci/8EDTnV34t7T4vwlfHG+QykwKj7SXjjYrPtfjwR0eIfiNIbp0EJgf438mXitSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5hChh3BxFnxYv0eyiuohfbZGhNB6xhd2FbN2CVi7WI=;
 b=PUcC4YpgQEjKPoqTkBzIIK4A76KKnE/c5eoSS4ZMiee2Kk0iKZR7BI/gmsM10TbBLh6yLnMjZDZPZJbe+9VRS5JOx60zoq/h8pfxBFNuVXrfdixGHpKVNK4g8eBg195T7Hs3kIVtKH5DSZA8c5IcDlhRAnKsq4CU5XMhnSCGmzy2Yr0UpdPoXC0ys3ZrlJMsQTk41fVCbNfEEIgiDYlUA/v9Y/Jlj9GIyypGOo/ELzY1M3OooupfuoFs21X/ySFeUhvCI10IF9SUVc8YLXkD0dbS+hFfeVstTfNUqAhjm4umQEXdWo1R++Frvyvl8tvn2AADeg4w3ll2ODSRYopFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5hChh3BxFnxYv0eyiuohfbZGhNB6xhd2FbN2CVi7WI=;
 b=HTxKaj+a2lQ4VnrNKWciTgyWe5pi+hyvMUf9nw++pfvgwVCLG1OcxrK3JUPzRzIK7hhPOUn2itC2VNaBVJruiyi7V0SZwWO8j7sFiaSYqh4i5Ev3yuxvLgR7E7OUIppZAsI81VhYOIr1XWlMOmRmdcsyqplsQ4bpllpNsu6W3GH0eSiuMKme1oVXfgQjsrqncMnOavRsaMjStDDiQuFtzky18bYrrsMig/2sHd6aH45FoUf2mvnp3+lJXKtJoVAyXuBMuIaPzCxgLy6oTXuquAFKrsPjfV7vrv7ThXniqMGLX4pzpu9uHEB1y3rIfFuu0+1DbgWLFRI/Myfybd2HlA==
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:34 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::b5) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Sun,
 18 May 2025 03:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:22 -0700
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
Subject: [PATCH v5 15/29] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Sat, 17 May 2025 20:21:32 -0700
Message-ID: <8989f316a150a0eea15ce1e58abc311293d1692b.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce7715a-ef8f-4ae9-d523-08dd95bb3b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KTS7y8W2s67G+EYW8ZfR4Xpdunhe0l7M/cl9Bgucpzb5deMEg8Z3jYG5sSAA?=
 =?us-ascii?Q?e9Vv/DjW19UdICbNP8hHzd9ZwH0GTspEYFi3eylJBuJYJjaRxyRuL3EHFhAs?=
 =?us-ascii?Q?y5COVLhV/b0hLJ+RQ118laVOyW+voOl8vx1YDR8PfOJVei9oNVi9ZpG2K4G/?=
 =?us-ascii?Q?a+7y6jK6YuyM8f9KybPPXt33KS9qa4TzpJ1pp/zhN1TyMLLvuvRxLSbI36Cm?=
 =?us-ascii?Q?/ijw1Xj/xsHvR60js6i7Tro8DN04ClsKIO+P7SILPUxoNR2NUQ1SoEBe4/Yp?=
 =?us-ascii?Q?ZWwVt+C0po5aj0MAuPi+nExnqNDDRd/dDbBr66n9vw/dhyLZ6z9URz8qVlvn?=
 =?us-ascii?Q?570xg6aNt2isWj2qtR/BpwuFeHEnpTio2i0/5BhekvHsU+toCSrE4eZw6jZh?=
 =?us-ascii?Q?btF2TCXdm20oZPM93X/Pook3vBPBQ4yVC2pagYYrE7+RpSoMrcvjsWfOLnNt?=
 =?us-ascii?Q?UkquAViIATEwU1ONTh0S9eExq0UDHqjZ8lKoz1dwV/68Z4LOwemuDLs0nCGL?=
 =?us-ascii?Q?LTPv4LAuQwPHmzp61cbBITzAgmPbHOYRuaO0RH4J8BI3u5toTx0QG4y0xoWP?=
 =?us-ascii?Q?nME59GcRMqmNP6/p4zVduYxRmmIclXQ/PTF6szoTsufIY9M5Mi9ZDXE6qMxL?=
 =?us-ascii?Q?COMTH5wqqGcrP7aeDTI37sGYuwqQVsaLsopc+016Amfx/vslSG6c+6s9AAhx?=
 =?us-ascii?Q?/nG0a3t75mxFPbxjcb7L9QJVQwVMFqKDnOohC89E6a6rgLZw9ZPT3jDWtO46?=
 =?us-ascii?Q?OfA4rK0C+TD9WdKptCOLBUzilrLLVtkU1CNlWc8EeEpgYPEEu2Go4dVnOyM1?=
 =?us-ascii?Q?7x0ghFqO5TwIN7ZBqnVKA6XP+RUpugluNJSWN9vXGbjMgIthWtI+bIcFMbEt?=
 =?us-ascii?Q?+Z4zAepH7aMfywBdYBLdqFvpmaMg2OzkdRIYqbk5ib1Alu2Ci5I45976VDsX?=
 =?us-ascii?Q?G8rVqD3ADgjLtmNC8VHrjmiK8zA9rL1cJ/JIBIRcTMvMIZAXEwXu8ddQbEnv?=
 =?us-ascii?Q?LKNjjBqhgc4WPZxqwa7YXGPYivtQJfCG95iyUsdHFvoU6GbjPO2GsJGUX5fl?=
 =?us-ascii?Q?CHmlecDVp59XqvO+YRE/rofLutz/hdMrgjfiMFtnpGCzncHIZHbiK9mN34nT?=
 =?us-ascii?Q?eM6gptjcGXI37SLxQW36NKGCv6g21/dwmGGQTJhiZsu2QyWkAvLjc2iFyIvv?=
 =?us-ascii?Q?tFeBFxzDMsSXEBMee9nMTHSvi4ntbTdRW1mUW8f29NG37woUS7ekCxMa/gga?=
 =?us-ascii?Q?W+Fspc5ahA9JyDWsfqPuBGOuLdPDowluYsMFZMqOimPRxT0txiWBlmsLAXmg?=
 =?us-ascii?Q?3VskyOfdrBTp2DAcZRqDIS7A043jNprR4QVFSpj77/IHta+q3bqgLESGf44n?=
 =?us-ascii?Q?w/vSnK1flg/sAoWSF6dYV5tVAgyEc2pe8aPzLJbBa+IVQKKegqkT6gup2myq?=
 =?us-ascii?Q?BjCOxh2s28upSVSCp22V5NdttM8q6edCnYipJeI8QcMosDc4Oe6jQHWi2MNL?=
 =?us-ascii?Q?9oM0JtrMTJooZj5EKudYFtfKY4JoHRdTECbd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:33.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce7715a-ef8f-4ae9-d523-08dd95bb3b1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

NVIDIA Virtual Command Queue is one of the iommufd users exposing vIOMMU
features to user space VMs. Its hardware has a strict rule when mapping
and unmapping multiple global CMDQVs to/from a VM-owned VINTF, requiring
mappings in ascending order and unmappings in descending order.

The tegra241-cmdqv driver can apply the rule for a mapping in the LVCMDQ
allocation handler. However, it can't do the same for an unmapping since
user space could start random destroy calls breaking the rule, while the
destroy op in the driver level can't reject a destroy call as it returns
void.

Add iommufd_hw_queue_depend/undepend for-driver helpers, allowing LVCMDQ
allocator to refcount_inc() a sibling LVCMDQ object and LVCMDQ destroyer
to refcount_dec(), so that iommufd core will help block a random destroy
call that breaks the rule.

This is a bit of compromise, because a driver might end up with abusing
the API that deadlocks the objects. So restrict the API to a dependency
between two driver-allocated objects of the same type, as iommufd would
unlikely build any core-level dependency in this case. And encourage to
use the macro version that currently supports the HW QUEUE objects only.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 44 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 923c66ccc15a..a89797307379 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -272,6 +272,10 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 struct iommufd_object *
 _iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd, size_t size,
 			   enum iommufd_object_type type);
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -294,6 +298,18 @@ _iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
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
@@ -359,4 +375,32 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		}                                                              \
 		ret;                                                           \
 	})
+
+/*
+ * Helpers for IOMMU driver to build/destroy a dependency between two sibling
+ * structures created by one of the allocators above
+ */
+#define iommufd_hw_queue_depend(dependent, depended, member)                   \
+	({                                                                     \
+		int ret = -EINVAL;                                             \
+									       \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		if (!WARN_ON_ONCE(dependent->member.ictx !=                    \
+				  depended->member.ictx))                      \
+			ret = _iommufd_object_depend(&dependent->member.obj,   \
+						     &depended->member.obj);   \
+		ret;                                                           \
+	})
+
+#define iommufd_hw_queue_undepend(dependent, depended, member)                 \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_hw_queue,             \
+					  dependent->member));                 \
+		static_assert(__same_type(typeof(*dependent), *depended));     \
+		WARN_ON_ONCE(dependent->member.ictx != depended->member.ictx); \
+		_iommufd_object_undepend(&dependent->member.obj,               \
+					 &depended->member.obj);               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 28dec9e09720..529968126f85 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -54,6 +54,34 @@ struct iommufd_object *_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc_ucmd, "IOMMUFD");
 
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


