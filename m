Return-Path: <linux-kselftest+bounces-16432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E025D9614E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A38F1F2326A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61D1D1752;
	Tue, 27 Aug 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vw2wDmty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C21D27AC;
	Tue, 27 Aug 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778123; cv=fail; b=E5g5t8aPJ6teLeBn79IFzq6PMApbsudBwBMY6TnN+JMzaugFdJ0qY+phzL66En1nwZlbItGZHiNv9jN31xa8AgJ7R14gF7uvvMH1UVx9KTknQm1Tgz8qRjK5RDs2B3UeBjgrziDW/i+QA8XP+HjmxhnqiYPAGVumFPnjt6xdMvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778123; c=relaxed/simple;
	bh=1dLSKUz9cK0Tk2PP60sO4XwJ8F7R7l5nrqEqvYg4PDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIL/uDBSDDWGOQ1sbFNf5z1Bok5rk/SPVLkMTTWbRwjZ90NxTWl98jlfcBSJ8fQDrbHlnJXElxC706/YDSM+/E9pED5xIy8/wCoDUs3qCpsaJeNbx3KEnJYr9KRQqNCabtprsGa8dqfcCwa46YYOH6dtFm4rIxrrJAiCslUIwKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vw2wDmty; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YivpvPxnpR849GG9eGSLRsKW+t3Hsc1f6Sq4pKkP8vG5/9k64Q17o1ly5jslbbrhY0hFE+lo38T4H9iv79Vk6kxvg6WTL7zTcbs9AQ7xiMqa2TcpjKMYjmE6JzuvgX7hH8Bshcf2UYzK6Hee1NsleOwizVhqblScZJfQHdKMO3R0h+wIVBMRBm8e+Dn6kaL1gpS41OE27oFAiU621lrUtKXfIPK8AxY5Ho2GpeFSdlxfMJVUR08Y1wSwBx7WIYE4dn37BZyJPPZT9p9d20OIw1KhQRL/Sn3+Vns9X9YNQZOaIfy7tGwpJdwpar4XU6S5aivoTRzBdstlQmhu5OYv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEXfljgMHZ5gX2bgJxGX7K1I4JK7NDnLdML1lryI6L4=;
 b=JTHPwhk6PtlBtuotyy7kndc3/Gxd2vY4r+Gts+3kow8McxJXahmiyb9Bpj7GfVvvLV6upa7QdYNDZ7qX4AEKvt234Gg0oYh0JmlESD3Y0nq34Pneo+v7wyWehuI/djZbzDKWvgBay8Upst9ljs1EraVE+2DcaiYsI3dybLoCZLF9uKPSxFEvqwJh9Dj0TuE6Eq2PFIBwm8GuWHKdNVEPFSoMwu5scyOrmt9u4gVD51A17dpwXKyx3YkihWYP//6AZimmEuZk+0n15ogHYtz9YV3g+4gB0+GIHGlB/uAiUkh1LfUlZX5kfWFfAGO407nF1RurzTucF4ZMOUVBPXWhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEXfljgMHZ5gX2bgJxGX7K1I4JK7NDnLdML1lryI6L4=;
 b=Vw2wDmty3E7wRbqO18adkCzP/0KlkYmmW4pO4WKn5ebNmcJuiXQRSgaMu+YX2PocXxViu/xpyjj7lY58/MBSzadosQqYIms1L5d/KDH+OD4cpXJHMDTJPlmIgTExVe0SJ4mMIhNGQu/DbmJnVBmRjsQgmtXinq1Jh3CNHZf82QZGdK/R/J2T04FAwlbYddJYE7jUSWORG6TUDmYN15YroDxRZrdBEdrxOLwxhojeP8L5E9yiubVWGVLnXN2pWuvixa/cgNxQCnrGyjH7p4o2GQZ51IYebJrpSwh35dQmUr8jiFetgbWHdKxiLFMYk0jEM5WB7Tpg5/c5KWbOIAtmDQ==
Received: from PH0PR07CA0104.namprd07.prod.outlook.com (2603:10b6:510:4::19)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:01:55 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a9) by PH0PR07CA0104.outlook.office365.com
 (2603:10b6:510:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:01:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 06/19] iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Date: Tue, 27 Aug 2024 09:59:43 -0700
Message-ID: <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3ab3d4-8552-4af2-7c6d-08dcc6b9f392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NNo0A4BJrpWX0blTiwkun9NdIW94XBP3kFjugZxhSwXfOwjrhLzJK7vlZP+?=
 =?us-ascii?Q?O9tR+mAsGHt0YYUuDhZl5jod2L1EU6/Kq2FHAQ4Kz+gb+jgvAdHqJgJDnklc?=
 =?us-ascii?Q?okttfkBNgldvGz5jTaVTORMqWyh+Dwaf/V+kP3sAe68GjSfEXtmcecMkIn7+?=
 =?us-ascii?Q?aMiI1Z1W0j42Ys9ndLFw+OKvOrPRZLd/iF+9C2M3yxrfT6Cp5VbzviUy2pT3?=
 =?us-ascii?Q?HRs3iNjy6ZZnW9WxP0rYRgW6Ql1C4NfpnWzJ6J9vNtLjG3YiJbU+G4dJ23Ne?=
 =?us-ascii?Q?cwlenesw7xXeCUsuJp5TvwMZyjHHBK6YHGnQt3BmQjKQlzfVlxVu1pnK8SsS?=
 =?us-ascii?Q?WUAAWOX0czAAnENAxb7NA+Dy2D281V8hcAwbGwc3aFAJl1PpF4l5Z6gxzHWU?=
 =?us-ascii?Q?ypBFB0NYFr4fLjxfL6pYQg+La5OUaR2YnlS/vMV0Rfed1HNU/CZDvg7/SiaV?=
 =?us-ascii?Q?sUv7QPqZpLI7rKjXfUXvqxjuGt3N1+KU+LV4+KclAqIkU38jp2ExDD7v19x/?=
 =?us-ascii?Q?AtzbY5fTc4S8XdHeOd/HkAjHBzYvdORpVnSCg8ca/HauXaQsWtQOq9wQ/JtQ?=
 =?us-ascii?Q?nS6D09aSa4088pyBj7XiySl05TgMXYX8Jkz8wxZwUcIDgC01NwjM7TtuGzag?=
 =?us-ascii?Q?gNb3JVU9EEvncyky93wIx9RHAZSRdODArU5Soqf5rWQcwy1L3ymcN4kkQ6gd?=
 =?us-ascii?Q?eaM38BHCpK88K/UATdehj53Rf65x9adHQ26MYPTPn34MnFENGnoVW/7Cji1X?=
 =?us-ascii?Q?qeN0+VROWyB9RpDQLrR94ftSfBwnJ6dE7KSMx7eKWIZBYqay5BsW6cIAEJRp?=
 =?us-ascii?Q?C/f0heOY4E6XXKmDbT3QxbNHQN6ut67w05OTLE9XStfW3E81wdQCNu0R3t/2?=
 =?us-ascii?Q?bBRXVnI4u0M+LKYrBNrgChAOlH01nu0JKuQrxm7ifRkX009jq0QQ1PFnX025?=
 =?us-ascii?Q?P8ziq4f90DuyVLlZMhm4lGOVxEHfaEPTBhBkf65PVbfOqJZGfK8rH9429/cE?=
 =?us-ascii?Q?GXyXdF3rsIYeWnFygmfqjcvfMt0gERtxYDffjFjmItlwzIqtpFovzEIUnhdx?=
 =?us-ascii?Q?SqTbvPZZuCKfV+8JekSuQX/g0Cgf0aG2M23lhwUjnKSgsy5BdWKzCL4p8J3n?=
 =?us-ascii?Q?7JWywDtGvu8scgtfrmSBbzayHm2KTmgA5tLa5HunpyWnI//r0M6l+Rr5yKXW?=
 =?us-ascii?Q?PG1Ig70B/+sg7ImCYXL1Q6Q3qwUJ6ho+S1kyRuXXr2LcqL2KUYhLygFisuWW?=
 =?us-ascii?Q?QPA618BICE5ysX81l3KxJMU/roJ3i4FgtXGCskNRNqc2n9rjxH+EOMLRaDQA?=
 =?us-ascii?Q?bRw/NLahiD2g1WJ4Z6gCKJXuUdbrYejcnwc1pVB1aePuKGr0djGMy6IQlgwX?=
 =?us-ascii?Q?svfBG4ge31qFdoK2IX59x0VGDVBpjwMRVfF7ze6c0lrDfr90yj1c5pfq68nW?=
 =?us-ascii?Q?j5Q+jNzw/BqAQGKYR5YK0JV818P6dc/3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:53.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3ab3d4-8552-4af2-7c6d-08dcc6b9f392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
that should be linked to a physical device id via an idev pointer.

Continue the support IOMMU_VIOMMU_TYPE_DEFAULT for a core-managed viommu.
Provide a lookup function for drivers to load device pointer by a virtual
device id.

Add a rw_semaphore protection around the vdev_id list. Any future ioctl
handlers that potentially access the list must grab the lock too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  12 +++
 drivers/iommu/iommufd/iommufd_private.h |  21 ++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          | 121 ++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            |  40 ++++++++
 5 files changed, 200 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..3ad759971b32 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,18 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	/* Unlocked since there should be no race in a destroy() */
+	if (idev->vdev_id) {
+		struct iommufd_vdev_id *vdev_id = idev->vdev_id;
+		struct iommufd_viommu *viommu = vdev_id->viommu;
+		struct iommufd_vdev_id *old;
+
+		old = xa_cmpxchg(&viommu->vdev_ids, vdev_id->id, vdev_id, NULL,
+				 GFP_KERNEL);
+		WARN_ON(old != vdev_id);
+		kfree(vdev_id);
+		idev->vdev_id = NULL;
+	}
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1f2a1c133b9a..2c6e168c5300 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -416,6 +416,7 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
+	struct iommufd_vdev_id *vdev_id;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
@@ -533,11 +534,31 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommufd_hwpt_paging *hwpt;
 
+	/* The locking order is vdev_ids_rwsem -> igroup::lock */
+	struct rw_semaphore vdev_ids_rwsem;
+	struct xarray vdev_ids;
+
 	unsigned int type;
 };
 
+struct iommufd_vdev_id {
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	u64 id;
+};
+
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
+int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
+int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 288ee51b6829..199ad90fa36b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -334,6 +334,8 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_viommu_set_vdev_id set_vdev_id;
+	struct iommu_viommu_unset_vdev_id unset_vdev_id;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -387,6 +389,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIOMMU_SET_VDEV_ID, iommufd_viommu_set_vdev_id,
+		 struct iommu_viommu_set_vdev_id, vdev_id),
+	IOCTL_OP(IOMMU_VIOMMU_UNSET_VDEV_ID, iommufd_viommu_unset_vdev_id,
+		 struct iommu_viommu_unset_vdev_id, vdev_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 200653a4bf57..8ffcd72b16b8 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -8,6 +8,15 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_viommu *viommu =
 		container_of(obj, struct iommufd_viommu, obj);
+	struct iommufd_vdev_id *vdev_id;
+	unsigned long index;
+
+	xa_for_each(&viommu->vdev_ids, index, vdev_id) {
+		/* Unlocked since there should be no race in a destroy() */
+		vdev_id->idev->vdev_id = NULL;
+		kfree(vdev_id);
+	}
+	xa_destroy(&viommu->vdev_ids);
 
 	refcount_dec(&viommu->hwpt->common.obj.users);
 }
@@ -53,6 +62,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 
+	xa_init(&viommu->vdev_ids);
+	init_rwsem(&viommu->vdev_ids_rwsem);
+
 	refcount_inc(&viommu->hwpt->common.obj.users);
 
 	cmd->out_viommu_id = viommu->obj.id;
@@ -70,3 +82,112 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
+	struct iommufd_vdev_id *vdev_id, *curr;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	if (cmd->vdev_id > ULONG_MAX)
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
+	down_write(&viommu->vdev_ids_rwsem);
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev_id) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
+	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
+	if (!vdev_id) {
+		rc = -ENOMEM;
+		goto out_unlock_igroup;
+	}
+
+	vdev_id->idev = idev;
+	vdev_id->viommu = viommu;
+	vdev_id->id = cmd->vdev_id;
+
+	curr = xa_cmpxchg(&viommu->vdev_ids, cmd->vdev_id, NULL, vdev_id,
+			  GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ? : -EBUSY;
+		goto out_free;
+	}
+
+	idev->vdev_id = vdev_id;
+	goto out_unlock_igroup;
+
+out_free:
+	kfree(vdev_id);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
+	up_write(&viommu->vdev_ids_rwsem);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
+
+int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	struct iommufd_vdev_id *old;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	if (cmd->vdev_id > ULONG_MAX)
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
+	down_write(&viommu->vdev_ids_rwsem);
+	mutex_lock(&idev->igroup->lock);
+	if (!idev->vdev_id) {
+		rc = -ENOENT;
+		goto out_unlock_igroup;
+	}
+	if (idev->vdev_id->id != cmd->vdev_id) {
+		rc = -EINVAL;
+		goto out_unlock_igroup;
+	}
+
+	old = xa_cmpxchg(&viommu->vdev_ids, idev->vdev_id->id,
+			 idev->vdev_id, NULL, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		rc = xa_err(old);
+		goto out_unlock_igroup;
+	}
+	kfree(old);
+	idev->vdev_id = NULL;
+
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
+	up_write(&viommu->vdev_ids_rwsem);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 51ce6a019c34..1816e89c922d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,8 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
+	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
+	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
 };
 
 /**
@@ -882,4 +884,42 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_viommu_set_vdev_id - ioctl(IOMMU_VIOMMU_SET_VDEV_ID)
+ * @size: sizeof(struct iommu_viommu_set_vdev_id)
+ * @viommu_id: viommu ID to associate with the device to store its virtual ID
+ * @dev_id: device ID to set its virtual ID
+ * @__reserved: Must be 0
+ * @vdev_id: Virtual device ID
+ *
+ * Set a viommu-specific virtual ID of a device
+ */
+struct iommu_viommu_set_vdev_id {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 vdev_id;
+};
+#define IOMMU_VIOMMU_SET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_VDEV_ID)
+
+/**
+ * struct iommu_viommu_unset_vdev_id - ioctl(IOMMU_VIOMMU_UNSET_VDEV_ID)
+ * @size: sizeof(struct iommu_viommu_unset_vdev_id)
+ * @viommu_id: viommu ID associated with the device to delete its virtual ID
+ * @dev_id: device ID to unset its virtual ID
+ * @__reserved: Must be 0
+ * @vdev_id: Virtual device ID (for verification)
+ *
+ * Unset a viommu-specific virtual ID of a device
+ */
+struct iommu_viommu_unset_vdev_id {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 vdev_id;
+};
+#define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
 #endif
-- 
2.43.0


