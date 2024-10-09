Return-Path: <linux-kselftest+bounces-19382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49C997210
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB11C23694
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECD1E7C3C;
	Wed,  9 Oct 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R79tyU9O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F01E1029;
	Wed,  9 Oct 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491969; cv=fail; b=cAfdDeOXJNvO5lxC4Yrfe6Ehw9XQuQ/Z+kI+lgY2tBzBfElKAoZLFxr2t5Yvl8F8UW7tAOeeMiVnTf3l65+qJ/7PPCj7GVBU/UR5r6G0s3EfMKZGUYTFMgRxI1y/8QREsELnxHyzMgZN2Xmu2avXXGh/AOS+NaSfyp1n+JBkbW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491969; c=relaxed/simple;
	bh=rPz8dR+964cKHG5dic16UGYl+MsDfqldHqd3TuepPP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFTN4UwJct9hErbV/lEmBvDWfRdS3kcLnUQlA4WXbQXAOKRIEKsqf8AvsAZ8VUPmqa6a5CUDVyySGJdzUnTANt8MO8CHknD98W9u4PnZcaCegmEwVSzrFaT8J/HG+k3mnwyWj77alW5cHmRR80qtF0foIYtT2Zk/7GQhZpEb9FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R79tyU9O; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqLlaYlpK7bGam83dYa8+3SleejDfblM6O1DRPCfrtxSyhkGsnlEuV3eofh8ArMd9rKG+46lozT0LJYDfGOY7iNWPc9dqgJf6GCI2PwiSZkthDFv5C/5rueW1MXfNa2mmke4bgAEIXFxypldt8THeoIcBrdjsbDPePIixOftkzPcSaIiXAl/+NLNWXonwThntJRANNGGMrfE91sRjd8YoWqoqvagHrEVnC/56WrG6X1TIQ6uwxxvhzAgqOqhekWBTV41fPOJ1imWWwFl6eywBEYGv2Go7gQeYB7lHWN+UDQNPM7LFqaFChnnzRvpCyztRNkopQDYAKTTIvExeabPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adhn2ntk7aCGtHZ2wiYuwOVsWCP5l+BSEnYAMVhXZVE=;
 b=xRlbEl3UZgQmbphiL9B4XyZSYxrZi3M7Ph24vGnUDLcV54CDYrVNOksZku+RHeAx+E9xhZ1zJl+j1rV0mMiy3sRrGRprcxU6netmU5j7dBHD9DdjocIWAelz6t4Qg78NXjpLArDyyxKSck3KOyR9yk8hnceHlg8o1CPKoz0e0hjQRao6zNXiOphuMM4GVhAQBiOftKoST+z+DTLX54fAZUi3HwYbWOQrWQCT4IFOQ5En3dd5eibwE5AfhHodq7e9zUFxHzsbbDqPIbiO3JG9drbx6NKSf+saz1csDnc1xP47Mp+icH+IrKhwknn2zfdj/KRuhKrN7JN9gqKNCDwWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adhn2ntk7aCGtHZ2wiYuwOVsWCP5l+BSEnYAMVhXZVE=;
 b=R79tyU9OVw6JysBxVygTen/PpK3J7rRFuJYcTiFjJrlz2i2TpRl3lxnbIV2JuGozGa67vTOpynN83haDZGWyWMWpAdtMG8FuX7vv2PE3ewJq4x1pXLUxdDn11wBH+cPrWm9gcCaEVIzF4Eoeu3GBulDnTlxjlRhh3B1N/YG+MCmFmaVmGu+9eYfZaubmZqHIuYdj7LfR/R7awmAUc6wAgeTAi7Aa1kam3dP9oN1SO9Mon/fsv1suoDgZtorse5Jd/xbxHPhuuonoK6jS07pEhcrde/9JuZJ11KkV9XG25U3uv20gyQ0Rzz4tAllP5TeTyB0WWIxkprSNWFbvtJBlEw==
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 16:39:17 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::7b) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 10/16] iommufd/selftest: Add mock_viommu_cache_invalidate
Date: Wed, 9 Oct 2024 09:38:22 -0700
Message-ID: <4a080b2ad3c543a09b01bd021ff7d3fbc5294ce4.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: f20e77ce-b3d2-49b8-795a-08dce880eb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptxMRwfCmo0q591pqhXS9njqQBiIZ2pZZQY0f8VGwvVG92dKMA9UFw1uitMl?=
 =?us-ascii?Q?8l7HZr8grEvRLhaqo/SdPuyhUClVocartmFDrMdvBKxLt8PHT18DPlCe00BF?=
 =?us-ascii?Q?Q1fvnBrLRN5RuuQYxa7FDVkmPZpgbgh0Yj/XSLuXAZFhtV2wS8I/2O+gOrzs?=
 =?us-ascii?Q?Er9PDQYNSTrIMLMkFRMV3cpm+rQt7x4Tt/z6ZVpe2iSbSo8o4hx4yYaskySI?=
 =?us-ascii?Q?EBtZv3Zn2lDaVGEsDrVbWOvOoBKhstsF3tP8LkRsC6f+DZcYgtRJzvbnW/9W?=
 =?us-ascii?Q?3heoWfR9drpo7mw/7a68x6E1yvFqC7vOrrJvHPzLmir+/+ArFX1f7HIaK4Ie?=
 =?us-ascii?Q?OaLvmFxeBPVIo/6oI/YVNh5NFGwzXj77GyoZOta6aOUOp3vhi2n3p0h1PUfS?=
 =?us-ascii?Q?ej/E0a20NIq/Nt7UeOUQp2kw+MRoQkJRKC/BOUPjGeTtP4BYJO8sMrITiW0w?=
 =?us-ascii?Q?+SiDerTh9z8mFvbug4VwypWMPyHl2abSuMUM08OJjdyV9BVfxSuV/zEB4ILi?=
 =?us-ascii?Q?AMZ0VhDsIkaGmU1H6sO4vLQGGuWj1Qm8feH+t3P1Bm1q/ZBxevDLwg+M8MfD?=
 =?us-ascii?Q?2LggVN8XnvJc/fUsVaF3anGrjo2lEnKpzwoKucpe3DIWEoI13RZGRa1y89Tr?=
 =?us-ascii?Q?tgG847s9HTK2HLDfyrDgmob7AJyCgQexuCculkb1DjfUZz1dVDqu20bmzhay?=
 =?us-ascii?Q?FA09vmaBBEVWGcnYylOs7jibLmscj3QeoQ46/FnMpwhzcRvktETFXZ9DllBL?=
 =?us-ascii?Q?lF0RbR0ljSyZYCfAFePmbIeDJPR+pyObUnTz0VvjcXQO5hbED2kkao6A3yNI?=
 =?us-ascii?Q?xUKg5zrOCDEVtc3PDyRRDOXBKWzsgoGi/fvNMAUlAB05YqmREpB2hOdFwAE+?=
 =?us-ascii?Q?eCCMYbTEninMv47mjK3f9OP4gZf/620wXZCN36556Uhazh4uQTalc4FmP6d3?=
 =?us-ascii?Q?ENSYJObZi3zmeFXE3Z7TMg6rfLHz7n/v4tjiHZjRSDl874SJA47RXL93YFV6?=
 =?us-ascii?Q?BJ/T8aUCVD9tf3/+YWc+PSID+4Q4F7EJkNIDi9k/wgLnAJMyN6IY9Ob3Okwa?=
 =?us-ascii?Q?MRZOdtfUdG+koZc+v9euBNCej6dZbNe+alCZoMIgr2EkCNTf9dA2q+aLS0Qj?=
 =?us-ascii?Q?48lSfXFeLKOWSU7ZM+2qzPSOrDoeTr/X/Atfo8wgZjkclZ2IaYA9nsneVBi+?=
 =?us-ascii?Q?bF7AMaOF+WDo7Sh27OMtCnaFXKuJkCNtoHhXdSopjaXKNzAen+28Ma69bXvf?=
 =?us-ascii?Q?TC7F6g2A5Rcir3N7ijQyh0b6mZu+af0ddb7jPCr4eqE/pD95B6XQcr4qb8ZU?=
 =?us-ascii?Q?6scBI/rdz9/p3H1ARovcdCt28Or37N1slNWyg9aDvoovpk+r/z4Ax7AT0056?=
 =?us-ascii?Q?ggtlr+8dy6TR1dygzB6t66molKFA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:17.5413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f20e77ce-b3d2-49b8-795a-08dce880eb0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and a viommu_cache_invalidate function to test it out.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 25 +++++++++
 drivers/iommu/iommufd/selftest.c     | 79 +++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index edced4ac7cd3..05f57a968d25 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -54,6 +54,11 @@ enum {
 	MOCK_NESTED_DOMAIN_IOTLB_NUM = 4,
 };
 
+enum {
+	MOCK_DEV_CACHE_ID_MAX = 3,
+	MOCK_DEV_CACHE_NUM = 4,
+};
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -152,6 +157,7 @@ struct iommu_test_hw_info {
 /* Should not be equal to any defined value in enum iommu_hwpt_data_type */
 #define IOMMU_HWPT_DATA_SELFTEST 0xdead
 #define IOMMU_TEST_IOTLB_DEFAULT 0xbadbeef
+#define IOMMU_TEST_DEV_CACHE_DEFAULT 0xbaddad
 
 /**
  * struct iommu_hwpt_selftest
@@ -182,4 +188,23 @@ struct iommu_hwpt_invalidate_selftest {
 
 #define IOMMU_VIOMMU_TYPE_SELFTEST 0xdeadbeef
 
+/* Should not be equal to any defined value in enum iommu_viommu_invalidate_data_type */
+#define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST 0xdeadbeef
+#define IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID 0xdadbeef
+
+/**
+ * struct iommu_viommu_invalidate_selftest - Invalidation data for Mock VIOMMU
+ *                                        (IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST)
+ * @flags: Invalidate flags
+ * @cache_id: Invalidate cache entry index
+ *
+ * If IOMMU_TEST_INVALIDATE_ALL is set in @flags, @cache_id will be ignored
+ */
+struct iommu_viommu_invalidate_selftest {
+#define IOMMU_TEST_INVALIDATE_FLAG_ALL	(1 << 0)
+	__u32 flags;
+	__u32 vdev_id;
+	__u32 cache_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 87bc45b86f9e..8a1aef857922 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -149,6 +149,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 struct selftest_obj {
@@ -578,9 +579,80 @@ static struct iommufd_vdevice *mock_vdevice_alloc(struct iommufd_viommu *viommu,
 	return &mock_vdev->core;
 }
 
+static int mock_viommu_cache_invalidate(struct iommufd_viommu *viommu,
+					struct iommu_user_data_array *array)
+{
+	struct iommu_viommu_invalidate_selftest *cmds;
+	struct iommu_viommu_invalidate_selftest *cur;
+	struct iommu_viommu_invalidate_selftest *end;
+	int rc;
+
+	/* A zero-length array is allowed to validate the array type */
+	if (array->entry_num == 0 &&
+	    array->type == IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST) {
+		array->entry_num = 0;
+		return 0;
+	}
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+	cur = cmds;
+	end = cmds + array->entry_num;
+
+	static_assert(sizeof(*cmds) == 3 * sizeof(u32));
+	rc = iommu_copy_struct_from_full_user_array(
+			cmds, sizeof(*cmds), array,
+			IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST);
+	if (rc)
+		goto out;
+
+	while (cur != end) {
+		XA_STATE(xas, &viommu->vdevs, (unsigned long)cur->vdev_id);
+		struct mock_dev *mdev;
+		struct device *dev;
+		int i;
+
+		if (cur->flags & ~IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			rc = -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (cur->cache_id > MOCK_DEV_CACHE_ID_MAX) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		xa_lock(&viommu->vdevs);
+		dev = vdev_to_dev(xas_load(&xas));
+		if (!dev) {
+			xa_unlock(&viommu->vdevs);
+			rc = -EINVAL;
+			goto out;
+		}
+		mdev = container_of(dev, struct mock_dev, dev);
+
+		if (cur->flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) {
+			/* Invalidate all cache entries and ignore cache_id */
+			for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+				mdev->cache[i] = 0;
+		} else {
+			mdev->cache[cur->cache_id] = 0;
+		}
+		xa_unlock(&viommu->vdevs);
+
+		cur++;
+	}
+out:
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return rc;
+}
+
 static struct iommufd_viommu_ops mock_viommu_ops = {
 	.free = mock_viommu_free,
 	.vdevice_alloc = mock_vdevice_alloc,
+	.cache_invalidate = mock_viommu_cache_invalidate,
 };
 
 static struct iommufd_viommu *
@@ -627,6 +699,9 @@ static const struct iommu_ops mock_ops = {
 	.dev_disable_feat = mock_dev_disable_feat,
 	.user_pasid_table = true,
 	.viommu_alloc = mock_viommu_alloc,
+	.default_viommu_ops = &(struct iommufd_viommu_ops){
+		.cache_invalidate = mock_viommu_cache_invalidate,
+	},
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -759,7 +834,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -773,6 +848,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


