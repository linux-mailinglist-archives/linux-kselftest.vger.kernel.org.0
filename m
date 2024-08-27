Return-Path: <linux-kselftest+bounces-16435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7537D9614EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0731F24BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323781D3639;
	Tue, 27 Aug 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hee69PfV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB631D3190;
	Tue, 27 Aug 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778127; cv=fail; b=hsIbx3+TYhj5d4QRCe07WO0LAcIjpJATqW1WQSsfP6+k9RBDCucOIa4PgCGr+g5G1+hg8WK36P4VwjBskkmtUjbh9HD5kNEcomm4nIwAIUAckOE6jtxM60e+9zTjUe9ZACwUH22t9xAWTIVPFznlIQrT8PlHhFTnxxpAYECIvSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778127; c=relaxed/simple;
	bh=r8svXObukZv1gTcZUHnHzbuWlQeae9Z/BWzEId9gkzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byJqShS0nBRHWXbJDARz0AaCg1IMsZIqxV1Bz6wNj/VVJUdc9xHeREX8ajo7C89MV3ZKHH0qzwf1ro36vmcuD5IcZnaTR8zQ+1JvkqST4QJia7u1q/OJeqCQ4m1+XEtzouVnCVU9FP8rNyi1SUnP42L60TYkNyb6nePbEiKu/uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hee69PfV; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUxqvWGKjdJWN8XSZbUYXoWbuXjfEYaNSCysskVRqoWBQnF84JhuhWIVL4eZwMagSb5XVTdwBa/eFQePyQ5oEaphCrNcUVwPJA8SoIKuhx1Tph9s9FBnVnZtlh+u/us7/r4D2UEepzQDBXR62CL3DGmFmlCzJPVsuCv8ByEj6Xx388SP36OJrLSOKLMVS1DSfyNUbhum4meRY6TAvMrP6WN1UBhNIkwGx6zz4Xme2i+V2w1vgcy1e3TwL5XHlzdNvoo9RRDQxxcngnowF5bilxX0vrg5aEvOFWIcGvNZFPMS+i/1h6ExycHF+927kkqfE0x3/+1pV13qAcUIoaaUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqj7E6gIFQVldasjfdEs7cByusGG3RDx1fRjN7lCdVs=;
 b=QcHLfbaPaahYkuG1u7Bx7/Yog7hw2c1abqLtnurXksxT719EfeCb1hH4h2M72pkhHvf5XssAzZHOoDq310DmL488UaoxB7SS5FUumOF3Tq7+4ZTQRCmtGs+u0e66lzjYxxkhGCzCQQqGx+rnWE17iaC1/CnYOgTzysp1n8z722Xb6Fjkoclcx//T4UMdubzsTGFjbEPPp3d874zONsp0Oz755yH2RPa5CRICCZJD+TbfVgMxC5lYYoeVFns6Q7iVdxU/8zpfFLVmBrPoNJpYj51Y9elnpNtrYn6NtbJbrH8+STp3yOq2iKw88ZRnq2nXB3ZoWu1saDdPSlCOiRbnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqj7E6gIFQVldasjfdEs7cByusGG3RDx1fRjN7lCdVs=;
 b=hee69PfVYVQk3ps/2UXviJElHjf1A1uFtJPCKA5sIDGWeLcZ/YfER4a/Asvc4Nb9KNSYhi5vJM4/PTlTgHbcgm9NKGq+YkS//vjq73fDRTqz40Tnnywdnpw0qnctxIHZtU6nDmqqj3mH4SB9b+hmU0VwklOAO/Z2aJCuPv78AyMH10Xn7o947XgWqZhoRN0a8T43Hk81vGBqOs8j4BaJ8sdUltPL5xvimVPz8Cl7bgpfhR8xU1gv6XAeXruqGUCFNHra3bd9O1DJDy+5Mu25+/h48Y+lgMYkW3t/lCy8BEYgcRwY57qNtn7Lgk2BJRK1OphRIrVmI+RXlptzx/998g==
Received: from PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::24)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:59 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::f0) by PH7P220CA0095.outlook.office365.com
 (2603:10b6:510:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 12/19] iommufd/selftest: Add mock_viommu_invalidate_user op
Date: Tue, 27 Aug 2024 09:59:49 -0700
Message-ID: <e39643e2f84d5ed939a37cd43fe98bdb81d8e839.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4e1b3a-2e5e-4a29-f45f-08dcc6b9f67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH+End6vs4VQNBxTvWqfKUM8yuQBZ9KaczL+8HzemKIJcN68AtplKNu04u8q?=
 =?us-ascii?Q?EyjG0R41jgatmzXgYyl2oZGsbS7u5+HeazzCI/JgfJSjru9MfGI6bhL5NLri?=
 =?us-ascii?Q?X8Nl+iYLLsniYbsUR8G3iHnacrJZBYu/4jMiWH46BO3XyT9KmSeXNmLbDlEr?=
 =?us-ascii?Q?K5iTiFOpcahkeRqQrca0SLvamhimcaXrB81cUQLMJ7jggpbvkFJ0Ftxsi+QU?=
 =?us-ascii?Q?4emAk9RGME9+osvj5bMST0htKrWUh4Jv0nE+cbd/MEUoh3MmSnxb3CUFbLqJ?=
 =?us-ascii?Q?pbmm5vE0IGiuzNxb0NWNtZi7ksAELWZS0CYgIyZMCutU1/3qQiTosgggHzAN?=
 =?us-ascii?Q?etUJxbt7YrBPnOr41ZWgjR40pcdZN6OH8Q48h90cqR+xj557t9QBsSV6FBkN?=
 =?us-ascii?Q?2BYY9n64gKzt0XN6kSBErz0l9x7P4xSNWz8VcC9joAl45oEcetNe4vJl5vpr?=
 =?us-ascii?Q?gh5jhZLVtLnlqXvxUCXbQieVb2r3MHOmHYfu8cQ1Cm3Y9y2W2amaBWn78sCo?=
 =?us-ascii?Q?wf0hmuyoviMMDgfymypVh5tNYglKNAL4f9ZVwjTSEySg2N+kWldwkpcAn6Gk?=
 =?us-ascii?Q?vzTofG0wRMXMM+kLH5q9QKXwHzc0l2ptoDS7TNDenBpiojGqzoNqfrVbGdsp?=
 =?us-ascii?Q?wbdRCVS3yjQytdIVAJk9p93wQGaE88z/7HwK9C2rF0vG6Ap9ZBWnDVo2G0ce?=
 =?us-ascii?Q?UD27mXIHTxHQllJH4cPAlURzXAaySe9wsDh+V9VFhNcf6tCuqhiSQw35T62m?=
 =?us-ascii?Q?/lypBhZb4SQ4KV6gVPRGnxfCkWK/TY9EbEq4dJeIc19Ri368XTRrJpxbVDDi?=
 =?us-ascii?Q?uQGvsrEDwIcNfAMb7RhOZOS6HSP2hax4xCRM0suYDb/R8286GD/x87IBIkC0?=
 =?us-ascii?Q?lzvb6hX8CigPtSbVxyYbuOFeF9rXPxg8nxQOCmLUfCMY7q7s6nh3fg1LL5/H?=
 =?us-ascii?Q?rXyK1MjmLU2Yq3F/yXqhKi5y07LyGLvQev4iy21rtqT44vtU3kNE7xWXKvwk?=
 =?us-ascii?Q?gfgJkjwGJEt4KjhvMBGS6ZMQheod7SPJL1zQHsokaRNDcYxCFL2TA5ZqSpNh?=
 =?us-ascii?Q?A9cz29MQIfwUMpGHkznnoCL+gfdqqEJ/M/lNGt2pGnztQanEPmpLQqrc8niB?=
 =?us-ascii?Q?ghu4cEhEu31FOqHUivUtFwDc6vYrC2yAq7q/j53q9LP/XfMFhkbf8R2xI7Wx?=
 =?us-ascii?Q?OwNmgzUUbubfzcV0H1NsCgVb4RD35G+gCd0T1OI6c5nxVJWnQCZyapFa56MX?=
 =?us-ascii?Q?QGzqxOHPQ3r669KSyaVFCTcmvQtJHIoe9viG/bhFxPwaKpFQFDAW820LrEEE?=
 =?us-ascii?Q?Rx6t0u9zYOj6m6aO2ph9txdKPMzWHiHLDmR6/IayKtkybyCNnMY0ucq4Qgp6?=
 =?us-ascii?Q?U5sqAqxlFQt13g27FMExBuZjqVQ5AqbqFW8XvaQx9giwu/nTvB3mrEFfEwED?=
 =?us-ascii?Q?270nAuTbly1IhtFFLqVDl1TjfdPO+1wW?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:58.5660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e1b3a-2e5e-4a29-f45f-08dcc6b9f67f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889

Similar to the coverage of cache_invalidate_user for iotlb invalidation,
add a device cache and an invalidation op to test IOMMU_VIOMMU_INVALIDATE
ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 25 +++++++++
 drivers/iommu/iommufd/selftest.c     | 76 +++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index f4bc23a92f9a..368076da10ca 100644
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
@@ -180,4 +186,23 @@ struct iommu_hwpt_invalidate_selftest {
 	__u32 iotlb_id;
 };
 
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
index 4a23530ea027..8abffc7794c8 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -139,6 +139,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	u32 cache[MOCK_DEV_CACHE_NUM];
 };
 
 struct selftest_obj {
@@ -540,6 +541,74 @@ static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features fea
 	return 0;
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
+	iommufd_viommu_lock_vdev_id(viommu);
+	while (cur != end) {
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
+		dev = iommufd_viommu_find_device(viommu, cur->vdev_id);
+		if (!dev) {
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
+
+		cur++;
+	}
+out:
+	iommufd_viommu_unlock_vdev_id(viommu);
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return rc;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -566,6 +635,9 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.default_viommu_ops = &(struct iommufd_viommu_ops){
+				.cache_invalidate = mock_viommu_cache_invalidate,
+			},
 		},
 };
 
@@ -691,7 +763,7 @@ static void mock_dev_release(struct device *dev)
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
 	struct mock_dev *mdev;
-	int rc;
+	int rc, i;
 
 	if (dev_flags &
 	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
@@ -705,6 +777,8 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
+	for (i = 0; i < MOCK_DEV_CACHE_NUM; i++)
+		mdev->cache[i] = IOMMU_TEST_DEV_CACHE_DEFAULT;
 
 	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
 	if (rc < 0)
-- 
2.43.0


