Return-Path: <linux-kselftest+bounces-21473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50D9BD683
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A401F23F0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5B2161E7;
	Tue,  5 Nov 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQ8SDEIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154E215F57;
	Tue,  5 Nov 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837104; cv=fail; b=b3loV+5fQYqOt6ApvcI7ER28W33qb+jqaQ4Q+SGTSXrQXf065+cors/lpADJlxXZGcqnukjJPZ+zZb4nXIxChBiiQX+N3oKLSKZHY6DSRqXe2FPzq/8GqHDEblSaTSXeFlNhEdVlnDPRlYI81jKiBavC+Kv22c+AQdT5vJ/QT6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837104; c=relaxed/simple;
	bh=hCFev36SssAvNAj4ePzCjgjWEUTEU7hBmMoLdbzmq9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJQ38tcP7sAMUy784puYjfi4vh6wuuuaf95oYMeVqXPQYHc/NwleFTGF4NmpVeiLWJU/mkef76VHhtyZ6Z5bKk191wZOaQBAK4l1J651a/6XzrDh63IW3mX8uKimAbPwOLreZ4GVlB01OY2TugxPvX0rFg26UBFnOKoJafBfGGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQ8SDEIw; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL0KMy3trYRTjoJpE1VUgrsxS40LgN68f5uxCxhoLKi90LD5Z6BDsqsaG/VSTqBm+rQOzWSCYqZ7YuY2H0AfW6V4HytCbIP64DFN9Bvzv9CFlapWfa/JwihMT2ZfodaoleZhbCuJyM9eDXceNwdDoelZWjTHRrzYtiGVIWhJ7YSxh5iaFpz4HtVid+f/6F1E1Q0Z3zhT3oKw/GYxg2/yTFkt68jpH2SohtEThVvjzTFwIPbFpFsZYsrCt5P30i5iICNe2lCPpSb5H8kQUez9gZJJ3hr/D0c51hlTMk5qeACqYXzPMOkusiP9T9o8flNbPBrEU0GTGNS4usrusETLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeLwBl0Lzx6OjJFGG4jla+hnp4tMo9mXkAX5K9Oq5Rw=;
 b=cE/Y4BVpJZUEMDOd2w1HVtjAoelMHSoKxkWgshCpbKKHJO3hV0ASWlRWeWlbJrvJ6IZ8ihkFa/3KYGYmclNZgumgT2tiI36TkAmaly7dxoiKO//wE5hq5V3v5GMnWBxCrOjKS1Cd4EEkCfzb0tEhavOQVBZ/o4kz2dyB+f+L3dlydAoj6W9sYcpSG2aSyEFoB4BcCPcVtwuigp0AcH9g8DIvPlhoh3S5KhRH3aBN8tWNxj5pxIZEL+2ZES7H/cK1WcIymqplQH81x30CBLDHzKhjPpBTnO2yBvIQ8ErW32qyyAUYXvIsGvSiXuG2sW29dj5y+ufnc7+TpCJp1fxUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeLwBl0Lzx6OjJFGG4jla+hnp4tMo9mXkAX5K9Oq5Rw=;
 b=hQ8SDEIw3pOhnj98sPdKbYIUrNJYhtLqbele/X5CYrjqmrHEGMejjLpUTA0VJcKnJQ7ByVpE2rjL56NDzgLiawVm5DGfMNsI7CuyQbSktp57ObiO/J1pebq1Ddwuo8811roRuiKQssao9ax8RMPLhqDI3rn6GWKzH6pL3k7CS3UvZJXFMXQiFuvSSjHaictxJt0YC4UufWSkIJYM71GFda9FJNccwFemjV/iGNrso6wql1RUjAZgsi1MqoExHcE6KLAQIEwX6+RIe0orZZPkBU+pICjwnRZQccMTyjwWf3M7Pi1c/KvkaSjm6ugtiFJf0COr/LKQIQvOiZn5ZrzvYQ==
Received: from BL6PEPF00013E08.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:5) by LV8PR12MB9084.namprd12.prod.outlook.com
 (2603:10b6:408:18e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:04:56 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF00013E08.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Tue, 5 Nov 2024 20:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:04:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:43 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:41 -0800
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
Subject: [PATCH v7 03/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its related struct
Date: Tue, 5 Nov 2024 12:04:19 -0800
Message-ID: <64685e2b79dea0f1dc56f6ede04809b72d578935.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: b60c9f2a-9ab3-4030-b254-08dcfdd51eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUYhZtFu7GaFjs793bVI6NTjxjjmhM1DnlV/L9mO6/Hzs9uQl2rAlL7h/9GG?=
 =?us-ascii?Q?7TXyv9M08q97yeTjsfmDw//BZQpujgHv8cRoY925uyCPcb8F4djmik+ftX9u?=
 =?us-ascii?Q?BdNAONlZvqoDeuwyhxE/hZExX/F+LEmKjSlk+8uqcHvNmK9/IPM8DJ637+vE?=
 =?us-ascii?Q?DhsMvG80hzB5UdcoToC7WejgnPXyajsFziiPSJbi8+d+mGi5X/+dNbYjDkx9?=
 =?us-ascii?Q?87mGJiLStpo36zATuHJ/y+H+AkEkDOa9soII5m/1bfVbGdb1srTXD5Y9tl8F?=
 =?us-ascii?Q?GafK6wuArXHTFj90v27tmk2LgiuWuRnYql5FenYro6zdaERmmBpGia2KI6lc?=
 =?us-ascii?Q?zbIBz3aCeDI5cHgjc4n+1PiIXRvF4MZa6O6jy6tfSu6sclEA5OyY/D+CnnvY?=
 =?us-ascii?Q?1xid/wABkGYjvvCAUlY5qHinlxnqkUdh+VHr8btpCqNnxXlbKU5bORzIIX+K?=
 =?us-ascii?Q?WHGTKIn3dJG911OC7yHmzX2wBGiy0CA0xTV6oTzdbVWSyxJhcfjVDXSk1HVE?=
 =?us-ascii?Q?oWKI8kzWnl3S4YDeRzuK0/OvgI61DJxnFd9GlzUDhtJe42/yhV6WbKcRRNd+?=
 =?us-ascii?Q?fitFcUUIWbNM3PfnjtWM4W6IpUkoWaq10xqWlzSp3+9epvhZJcEs3dn8og62?=
 =?us-ascii?Q?ZR1GUW9jpzfIdmHNhY3UJMPR+2JdK9VUsv7XGdafyWaZL4mYbqmFf6UImbZV?=
 =?us-ascii?Q?vmAdVdse+Sl4O9PFVXXov2QZgjBVkPC0pqmaueU7NlUqFJPF0dv9zLHev8/J?=
 =?us-ascii?Q?IB55iZyIDIex6k5aoTF2k6tg1ipeJB2zLYX2gWSUbqbIEnC3FLdNsAuLu4HZ?=
 =?us-ascii?Q?K3e6Mai74BPctzURzftEvE0rp0j1qfyH0qml/WMReL/0I1O6lohbAZJGuDNF?=
 =?us-ascii?Q?qn3ShvQhZHXTj5tUTSVRmFXPeRkV4KHtLXhUnVy2fMjLhRbI+YgXhuzjauFL?=
 =?us-ascii?Q?KbTuDUHLrhEsbgt2hl9dF6gg735BhqQkiuOLYslMwCQRKaszOxpSBQOT5p0P?=
 =?us-ascii?Q?OsNuYtJNiHEUzQCux5xmBbO4YwKvvCXPRU5XlsOZ1ezLZMvvYYBHi2YRD8td?=
 =?us-ascii?Q?HdXl4ibl2EjKgeZPcNmKt9RPEZTNS+KphkcWo1fGELSvJNddGA9BjOf6Ik0P?=
 =?us-ascii?Q?rKIdSEQOzRi8zbBtIpOPyEoNtwGtcRLKQ2UgHHtJTDZMEpVl/9sPQAe6CVpr?=
 =?us-ascii?Q?5I7Dtty00dxcaZF/hKV+jb630Phwz8FQOtq3EU09BAgU+c1net4+n6ku0hjp?=
 =?us-ascii?Q?eQNhR8EVA3KjVjQL2Srw2qfwxX0z/FO/nx2OoajcbHidvDwnYG8ASXmoRvJU?=
 =?us-ascii?Q?fmnOGhuww6mI1ghWfk0DbnpqE0qtiPrC86xg5PPGUSDiEmpfyKWt7v45cR3N?=
 =?us-ascii?Q?EMKx+JKOG5xZ/w908UT55/XLruJTRpNC3fKfv186Gt1Q49iYpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:04:56.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60c9f2a-9ab3-4030-b254-08dcfdd51eaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
a slice of physical IOMMU device passed to or shared with a user space VM.
This slice, now a vIOMMU object, is a group of virtualization resources of
a physical IOMMU's, such as:
 - Security namespace for guest owned ID, e.g. guest-controlled cache tags
 - Non-device-affiliated event reporting, e.g. invalidation queue errors
 - Access to a sharable nesting parent pagetable across physical IOMMUs
 - Virtualization of various platforms IDs, e.g. RIDs and others
 - Delivery of paravirtualized invalidation
 - Direct assigned invalidation queues
 - Direct assigned interrupts

Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
vIOMMU structures. And this allocation also needs a free(), so add struct
iommufd_viommu_ops.

To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
It's suggested that a driver should embed a core-level viommu structure in
its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
meanwhile the driver can also implement a viommu ops:
    struct my_driver_viommu {
        struct iommufd_viommu core;
        /* driver-owned properties/features */
        ....
    };

    static const struct iommufd_viommu_ops my_driver_viommu_ops = {
        .free = my_driver_viommu_free,
        /* future ops for virtualization features */
        ....
    };

    static struct iommufd_viommu my_driver_viommu_alloc(...)
    {
        struct my_driver_viommu *my_viommu =
                iommufd_viommu_alloc(ictx, my_driver_viommu, core,
                                     my_driver_viommu_ops);
        /* Init my_viommu and related HW feature */
        ....
        return &my_viommu->core;
    }

    static struct iommu_domain_ops my_driver_domain_ops = {
        ....
        .viommu_alloc = my_driver_viommu_alloc,
    };

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h   | 14 ++++++++++++++
 include/linux/iommufd.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..2574fc8abaf2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
+struct iommufd_ctx;
+struct iommufd_viommu;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -542,6 +544,14 @@ static inline int __iommu_copy_struct_from_user_array(
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
+ *                the @dev, as the set of virtualization resources shared/passed
+ *                to user space IOMMU instance. And associate it with a nesting
+ *                @parent_domain. The @viommu_type must be defined in the header
+ *                include/uapi/linux/iommufd.h
+ *                It is required to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structures,
+ *                using the given @ictx pointer.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  * @identity_domain: An always available, always attachable identity
@@ -591,6 +601,10 @@ struct iommu_ops {
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
 				 struct iommu_domain *domain);
 
+	struct iommufd_viommu *(*viommu_alloc)(
+		struct device *dev, struct iommu_domain *parent_domain,
+		struct iommufd_ctx *ictx, unsigned int viommu_type);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	unsigned long pgsize_bitmap;
 	struct module *owner;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 94522d4029ca..4fc2ce332f10 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,7 @@ struct iommu_group;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
+struct iommufd_viommu_ops;
 struct page;
 
 enum iommufd_object_type {
@@ -28,6 +29,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_FAULT,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -78,6 +80,26 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	const struct iommufd_viommu_ops *ops;
+
+	unsigned int type;
+};
+
+/**
+ * struct iommufd_viommu_ops - vIOMMU specific operations
+ * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
+ *           of the vIOMMU will be free-ed by iommufd core after calling this op
+ */
+struct iommufd_viommu_ops {
+	void (*destroy)(struct iommufd_viommu *viommu);
+};
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
@@ -148,4 +170,22 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_IOMMUFD_DRIVER_CORE */
+
+/*
+ * Helpers for IOMMU driver to allocate driver structures that will be freed by
+ * the iommufd core. The free op will be called prior to freeing the memory.
+ */
+#define iommufd_viommu_alloc(ictx, drv_struct, member, viommu_ops)             \
+	({                                                                     \
+		drv_struct *ret;                                               \
+									       \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  ((drv_struct *)NULL)->member));      \
+		static_assert(offsetof(drv_struct, member.obj) == 0);          \
+		ret = (drv_struct *)_iommufd_object_alloc(                     \
+			ictx, sizeof(drv_struct), IOMMUFD_OBJ_VIOMMU);         \
+		if (!IS_ERR(ret))                                              \
+			ret->member.ops = viommu_ops;                          \
+		ret;                                                           \
+	})
 #endif
-- 
2.43.0


