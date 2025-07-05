Return-Path: <linux-kselftest+bounces-36620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61CAF9D45
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 03:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928E95879B4
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Jul 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D258920299E;
	Sat,  5 Jul 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOmBtzHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16ED15990C;
	Sat,  5 Jul 2025 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678067; cv=fail; b=bnJlCQLtMBMY8NvP/dw5XwU3z6G+3KRiKN745b7mrkO/EicVafpeebpPrpfF1NacABBgZ7283cvC2b9jHl2LGUq6eYyR4pN6jPuV5wH+ON9UXkY8LpSM7s+SoNfp6yQ6kyicUq6IKIfw1i09oMY0YbSPBKpPCsO3PFiRSXKamgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678067; c=relaxed/simple;
	bh=n+Frh3cP6rlPwORkIunHgJns2e2hgAbOo1klMDjv3Qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2UK62T0uuycNqSanx3PtyFYpnklb3kdzmovC96OBsgvD1KSCOjJhdkWiOWujWC5i1B8+6dxvOLe3dHMKX7vYYxzX+YEo/EWsFILw0WzRxCQAk8TsGfaZSYIwMHTtdaoavATtT55EXe7+olo6Paiz3IiP/2J7kxvpqVrEWg+Z10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOmBtzHZ; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/Grv7yuM4XA0zfWHrgI6n82mJoJMPj32ZcOyfhOvSejQTVze/D896pJpq7KhTYPu5MfUp1kdNgJWhoy5APfk3G8+i2LOTda2jAX6IV8xLF/j97OiaUYrfMO0JckxLHJE6/jBxz82uej1G9we7/GbyDNcsZ2H8lx0iFV1Ad7BtuXxdnfv2gUg2SMm1NWy07yA2sb+E6QIHRW7nvUjWDGZzIL3jKOtM4fEtyX0VM0xRFhlXo0J6E1NkIIU37yQvqSXoDoqyEvvcydF8wm86Y+WTMe52CJ5P4w1TdNUoMmLemCfUk7a2bZgSfV9GCj15B7MzSaorh7Di1HbJDSTQLesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrahDE26BiluYBTVRhYmNN2zMQDrtY2p9bqr+YJpsMI=;
 b=vi6QkNlQXt1kln1DTkIej5mJPwJ2fnZZk5N90BCgljp1XnINdvfl7fjAHusKBWu+/EqeCutgwarTiCYnDzMMEC22NBeI+jlIv8g+j62RTwVL/wt9QqnRvMX7MgfLYDrIif/HF8/Xh0/O0k3X086McJ5DQNfLjZXj2kWAofbhgABoRF3oFaqGCEDQdc68Jme/olHLPG+tk6k5bLGWH9LEcPZCh6YRHmAXP0An/ZLjKMfwqm1nJahiUJLwHZYuqPUuCvnCFskoP8ysxLjlcncH5BnImNW7fTDCwYHzbKb+H27E0qC7JfX6VLxjuGw7nAY7gQW6BtOIbWECpkFxBNQohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrahDE26BiluYBTVRhYmNN2zMQDrtY2p9bqr+YJpsMI=;
 b=sOmBtzHZfFOnN4efzmWDXZq3XtiN/K5scu71mvWowo5wzbh6KF724/WIwC/kbYSLgaYM3/+Fe53kv2WQKHsU2iVkZcq66g+11cgmEao9xurgI8CtpPVhj6YS4Z8CMWCfAc/1sBAfYdhcquMOJUiWge00lO+FPB5IUjFHTYHrPBHcfT+HqH/K0flpDSTBVrtoDctNVA0e97JS3JSmwl6HTmSOxg9cc5Ka6JY9ifmPi2e4Dd65y+EzRQMq8ZtTozmgzhlJlVyDsUfQOxj6WP83aE9ypPKzaYOImBV8wzrvnOcM3uWOyVkFX/Zxl7ozVXc6oaz+3FOhQJnrooBUBuaOtA==
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 5 Jul
 2025 01:14:22 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::a0) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Sat,
 5 Jul 2025 01:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 01:14:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Jul 2025
 18:14:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Jul 2025 18:14:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 4 Jul 2025 18:14:17 -0700
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
Subject: [PATCH v8 15/29] iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
Date: Fri, 4 Jul 2025 18:13:31 -0700
Message-ID: <0340da77e8f2d83af3f9df226fce94bc0a1f4fe2.1751677708.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: d7247aa0-1f70-4986-0ae6-08ddbb61467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8llbG6qNcwppNsbBjvU/phCY/FXS5nmyjYkrw9mYgEKDu9EmrSDbud10EEnC?=
 =?us-ascii?Q?FAqUy1mGLyPEO5bo2E22GC/wZK59qvjLSiQwJRJPStlM115AaO1ryUXsERiy?=
 =?us-ascii?Q?jh3ig1mpUCvIyJvWCEqfjs7w/87LHVzr85SGPd4sD4Bus15DuVvEUkhLSVhB?=
 =?us-ascii?Q?zlBPf+CbJ8ot5l/5yDWMlB6qAVQ8VlHP5wr+Nku8/4gFzTPU8fOG3+sLJHna?=
 =?us-ascii?Q?vsXSDWOsy2fP8TaUzAzXLf8k0TVWrXMbqrUt0Do3Zk8WqUohnPHSY/Al4XPS?=
 =?us-ascii?Q?SEhqNJW4/vCjyq7fWgjjDRa3cF6Fcitk1Lw+eE3BRueF4d5wuL+MRCPLr7y7?=
 =?us-ascii?Q?QAY2UN1HFOnPTTYa3+QVFDeIt2DbSP8L+6ON3xxMtoDCStbFM5JKrYTZP4Iq?=
 =?us-ascii?Q?h4dR6tg48Wdxy5KsPFkN8tok86FmkoAogWJV7m3xff9lTHTQmyryUDOg0v5E?=
 =?us-ascii?Q?MWn1VdXYLi+WJV/+KDgZTAkZDl/JjdsuV+yHpls0mkKeV94AZvBECwqETvLn?=
 =?us-ascii?Q?B0nSLW7XwdQSokjXKefKftbTxuQrUC+xaoTQX3UWvt0IxKIF1Q1CK0OqegSC?=
 =?us-ascii?Q?WWUDT/0gW9KtG+N8WtihF614gv4L9oR91Dz/NWYM5YlPifJitUX1oA45fjt/?=
 =?us-ascii?Q?N+SPl7XQvifkaERK/Or1KRrwuIud4jfTGlcdiOAuWymqNcJZ+mTqmFkqrOLb?=
 =?us-ascii?Q?t3faFsALTpPo/L4nMyfKDZkIVlBb5OznmT4zq2zpETMLsU5m3vjMX1FIHQcr?=
 =?us-ascii?Q?mIGbTY9Wpdep+AqSJmsIQOnhBsdptQUAqoBqsPSzD5PPqI4Wra9/rP9iIUar?=
 =?us-ascii?Q?jo6uVjOKLDN5iq96tBd5VF+trO5GoXZEmYJNMg202jYsHVEwTvs0gHzOav4P?=
 =?us-ascii?Q?Vaj2Um5xnLHe+Gq72GgN0QH0POZB44+1VfVgBTbKKOv2qscOl0h4oiOuXOl0?=
 =?us-ascii?Q?FJqZMKt7sf8HW7OwP9kDJ6MydhpSJozX6WwP1wcEmDYORXPZR/hvqlmAiRn8?=
 =?us-ascii?Q?n1hq7iWMQRIhbEfX3YbzT9Omqi6lbtaw/gz+eaZZ7mqMBjmUUcSJgZOSW5KA?=
 =?us-ascii?Q?Gqc6k6T0EGEheLyYGyDqgTxEc7dn29QIMespevNoOwAU37IBVFhAjDED7MD9?=
 =?us-ascii?Q?pvlPydt+rDK1mtl2vJI9c9S71B0FrXkH7GPTSxQc9T9QJoqFpyML7JFcMHaI?=
 =?us-ascii?Q?Jihpb53z14IkBaFmyMIUEOBzA1TR4Mq495V7HtDAPRgASWKaQ4ufRLrDdDPU?=
 =?us-ascii?Q?s8D+ISoackBCwo75wMTxlWGBr+UhmSJjW2ksYEoRtLStPq9rzvf8z+N8ZVIh?=
 =?us-ascii?Q?djp+BlEAW/IxUBHsMEgtmPNx7wo8EODOorRD2b9M2tuQBS7kuWxPs6K/otAj?=
 =?us-ascii?Q?O0K52ZkmPQAim0OVF/hKzJ9po4mDhrWcwGiAN9loPxzl8fHMQxpPeiaQ9kFH?=
 =?us-ascii?Q?MtCYJUKOPp9l6mQ/D/VNW2LoFrULWpHac5nfZ7ghC/vIg2BtM6WgCIVC5QP2?=
 =?us-ascii?Q?QTmFG1jEVXC+qsUoWHxQilDp0Rl5S8KLqR8n?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 01:14:22.3268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7247aa0-1f70-4986-0ae6-08ddbb61467a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5

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


