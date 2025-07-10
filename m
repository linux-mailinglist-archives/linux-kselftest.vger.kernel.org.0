Return-Path: <linux-kselftest+bounces-36918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F83AFF8E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2974E6D31
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5428C2AA;
	Thu, 10 Jul 2025 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nE5hg5Tq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3D28C002;
	Thu, 10 Jul 2025 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127240; cv=fail; b=sYr9PqMwBLOe1DQB2nU8w+BwipKdFDlC8idoHLP5ailUrGkGZeyG3OCuB8aZsK4Jfmw6jGjk6UwvwWC2pS66HafRnb4cf6IMbAqx+BTxA5sAt/2/4hSfixvKyK2REkjmmUShaCjcic4xbNcwFHCskW6RjwTmrETgssfTtG/C3SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127240; c=relaxed/simple;
	bh=n+Frh3cP6rlPwORkIunHgJns2e2hgAbOo1klMDjv3Qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo2yjB+dxM18CgwfL6PjK9TvFTNl474pQ4vaz8g2Rn4BZgcCOdV/XuiYk/b2JPF6PsROZc2RVbsAkZmRpFritSmfVVK5vVSEAshRTleRfPtN7cEdB8H5AcJv0B2nHP0gCby3VNUZpLTnSS5AS5thSppw9jh++GDRCE9fJVSkTwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nE5hg5Tq; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9LKa7EmpjE5Thd4cSvrT7j/6RhhllU0KjG5NtBf6tOBl4S0VM8KdloghZoN2mAvQeg2t/y4AQjGB8TFjKnaIIaTANrU1shz/ZGxs1Z7FgC3IffEdsL+z49AlCIxALMiDgphvzqOajBTx5CzKmdzPIROQjjJguAN72BIVHdZpAZJXpd3G75+3iVGl44Wd6YmD4DYayxT3HCMjKhSwLT+Y+HFkomueuS8ImuKOagZSGpXlhYcf2V8yR53NKhvMmpiP7TTBdXDOdS49xutxxK4pQqZlhNtoZHD9F0HCrycBM+hUDDTwUj1y9w9razXRCNaxGjLgF7mdV27oN1i/GUJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrahDE26BiluYBTVRhYmNN2zMQDrtY2p9bqr+YJpsMI=;
 b=mTmXCKG8uM7/fVeYb7GkMWGdz83cDlcMXXWG4BQdHNB9SWR06f9BXWHnrTG32QjHLaOHPRIt/cyMcg//qQDkEu7b/r8+4iPSbIZGhcn/xf8xufVfdMLzptlSkMHZX576BeY4GTLFCYzJoQwsuLOYQu9o9zIPQbrxIHXfzJum9kW62SXssA6rDUsTjGWtZY0F1YI3J6vhIpYUNZbTe+BBLu/zInSlUVxRv9lEqAuLe9Y+aR+3wEUDbg28X077unQ5BTkE9LUWPFjHxPBI0ee7A9qLoEiFjipDDi0lLog0AyNfgv+9L93kIcUsfoOeLBbpBim7CZkfhhVL/+UMN4cUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrahDE26BiluYBTVRhYmNN2zMQDrtY2p9bqr+YJpsMI=;
 b=nE5hg5TqGlelDNkGry+Up84FV8b0x8GvymKhWFNLkUvhy2LkuytWijLX5m/jhOjUqUioH6ZV8f1vYU8bFKbyqyVWDmLvnDoH/a3tTH1ozSIS1Z+32PHTQ/z5ILYvdmHIRW8RdQhWeJnEvJEmSnt+qO006FJMNUpgYS7yyKxwqQ/NBk+/yzZPBIHKMKwGtVvysDqsHl/QTUU80zid/vj0vlVAT1StUpiaUxR7VEGevSMdhbqLfkQuSkcPVKeLObC+MKerVFpOMutTRDPBkHjpRh3c4o2A3C1JlXPVFs14NfXdsWnqRrZJUpl+3gASNKHkGKprYqkYnU3tKsRYrehKZQ==
Received: from CH2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:610:50::15)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 06:00:34 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::8) by CH2PR16CA0005.outlook.office365.com
 (2603:10b6:610:50::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 15/29] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Wed, 9 Jul 2025 22:59:07 -0700
Message-ID: <2735c32e759c82f2e6c87cb32134eaf09b7589b5.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: df2ae70a-4343-4d6f-7de6-08ddbf7715d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p509RLhS9e/DIpNPnBefjzOo3tJei2nVcf8eAa+5i5CkusKltqqBKLnKfoFF?=
 =?us-ascii?Q?6ZFF97+NDKddxkQD1Xx2EhnKGY56v50L0zImmIlVBgADukzynVZ7fWPCa/U+?=
 =?us-ascii?Q?tCi+1nXH05jFv/ebdgc+UcdSbxPPTEW++u/JNcPOfg5mH1F3zRHXZck+tsUz?=
 =?us-ascii?Q?rHfVT28bYp8jIFGMpoZ40o/oQyH7EwOztsMiJTvVbtd4iI14diA0/5c0OnbX?=
 =?us-ascii?Q?djsDCk5cmOh1mIGaFlMN5vOniUJP9vBXZjxbcq52q9wsxaoKd/uWAwH4+uz5?=
 =?us-ascii?Q?ar3FHGx7escfltc34Xdt9vdgcxAxuSr9rVaXtJ7c0DWYy143y6c9klOWvLfE?=
 =?us-ascii?Q?pj8U6xzS6ZsOssfeJ9OQX1/xvS2XOpqQj0ffPLW9eiVFMkTWYgTv31w2wTOU?=
 =?us-ascii?Q?tfmP+RA0MlYImDK6kROHy0UTfYa3AlpFPuxy/j2Xom0i8EJX6NFB19SnUfCq?=
 =?us-ascii?Q?UjQJD8wbIzNxEh5leTuyrmMasq+9qj41MX+ltv5M7RD35+X6q1YpG7ih0x50?=
 =?us-ascii?Q?2Y5TZNR7j2aCj9Ik3wMZUoHgbwc94315T58E6sx/eyBp5Ose1cStqYivtB21?=
 =?us-ascii?Q?0UW80gqMb4hABmrowCt2kRFsk+eH9zvQfFfyr+leaMs2qgphCgNQOaW/rRRF?=
 =?us-ascii?Q?pI5pdXqnZdNGkRI3j8L13+X38sBj2fXFc/++1qNlL9drz4VkPv5Un0QzIUmM?=
 =?us-ascii?Q?XXsMVWUHx/O/Z3NB9882eNCUvmowaJsSe6NouQ6hl/A9pEM4I9O/MKHIyK+8?=
 =?us-ascii?Q?UgWwCR0Ep8zMflobYyw4zFnjcVL/MlCSbyuGWq/xscymNmAHogiyeFkWFwOB?=
 =?us-ascii?Q?YEAtMmkmk6E8hj4Xs6xDGQMA+qyCxzgxhVLstziUEsVoaeTP3bA297JtDPI1?=
 =?us-ascii?Q?HtMkjZ07dcZZNp4Ik4pO1hQYImpCBGRnomHB5JvH3fp2LReTk/pEVUu6OQ07?=
 =?us-ascii?Q?weRwY0lS0CmiqmtQGRrM9ZK5Wzv8MqV/SjvUvlR/vIf4l6ptEK+r9b8wTNJZ?=
 =?us-ascii?Q?62TYc0UM8hyM74UR4SzVI45gJGGU1/wFdFHYI+47yY55Q8bl+GWfwZvldO1G?=
 =?us-ascii?Q?V7pmwArs/bIXD+8lC21+mexsE5dtHVBZz9j8KNgLGLjRKyl/h1gJ3fV48w0j?=
 =?us-ascii?Q?5oIX3vl0zcw65Q0HpjOqAeYCxyOx2JjPfZn3rw+UXT8ThKcb6FbxOGbXQfx/?=
 =?us-ascii?Q?eHY6jXSQNZwKnbhGECl4m/xh51rJnPMHReFKF/i2OE9j4x3WjDKALGty17DX?=
 =?us-ascii?Q?wrRjEHaTbj3VRboel4wwsQUtIuop39C2WZiOBZWZ/b79liwB+utOUDA3zV0t?=
 =?us-ascii?Q?AlYilxBkBp+WkKiWZVE4MgzU0oNTMQVGH5k6Ov5KI9oIolsLp/VUtk4ZTtme?=
 =?us-ascii?Q?FrGJ8f92nuwnY+Y6uaHk322MvXGQAaRl6xYgyvp+e/9jdfbg7o2XvfsMutxA?=
 =?us-ascii?Q?pCxmmWDEzvxmwDeOCYeP15+bnqY++FKWS5QaDt/FPUBYVbT5erNy4j4lrNPK?=
 =?us-ascii?Q?wL8uB76YgazbQNVkVAjETGsCKEgdBOB9W7tQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:34.2926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2ae70a-4343-4d6f-7de6-08ddbf7715d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h        | 44 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/driver.c | 28 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ce4011a2fc27..fa23439fa483 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -251,6 +251,10 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 #endif /* CONFIG_IOMMUFD */
 
 #if IS_ENABLED(CONFIG_IOMMUFD_DRIVER_CORE)
+int _iommufd_object_depend(struct iommufd_object *obj_dependent,
+			   struct iommufd_object *obj_depended);
+void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
+			      struct iommufd_object *obj_depended);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -259,6 +263,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 				enum iommu_veventq_type type, void *event_data,
 				size_t data_len);
 #else /* !CONFIG_IOMMUFD_DRIVER_CORE */
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
@@ -298,4 +314,32 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 	 BUILD_BUG_ON_ZERO(!__same_type(struct iommufd_hw_queue,               \
 					((drv_struct *)NULL)->member)))
 
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
+		if (!WARN_ON_ONCE(dependent->member.viommu !=                  \
+				  depended->member.viommu))                    \
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
+		WARN_ON_ONCE(dependent->member.viommu !=                       \
+			     depended->member.viommu);                         \
+		_iommufd_object_undepend(&dependent->member.obj,               \
+					 &depended->member.obj);               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 887719016804..e578ef32d30c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -3,6 +3,34 @@
  */
 #include "iommufd_private.h"
 
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


