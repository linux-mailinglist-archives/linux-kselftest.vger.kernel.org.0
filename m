Return-Path: <linux-kselftest+bounces-19385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE729997215
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF26E2835AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036F81E8845;
	Wed,  9 Oct 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJOKSvMd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275461E8820;
	Wed,  9 Oct 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491971; cv=fail; b=hd7LSOgqkh0LoKEZ3P9ohkD4MFY8XWWLpppCTEvTMp4PyhvxJtfKGBnhZHIMGjM9TN2WcXxJberq01TriuN3nTqqrdYPBYy05Jgzjht3sGIORIMPGxL/cnXc+Tyi7p4w1DuIJp/9/vxbNFgD6ua0G9hJGMCl8gy9gdiaJbAte5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491971; c=relaxed/simple;
	bh=92O78QIiljKNMhedB49VHlmTDri0sQuyM9CfWhaBgd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+PQ39hJbP+HKqb3zD5XrMjTXbQwA4wiVuwDkJNUKVVu6O92Zwbaa0eNSGsrh+xi8XTWE1ucdjRrfPClDVwo5gz78S/XJj0LgBpgl8EBZS2CBIT9wnxlmfyS9I2Q0o3M6BZR/xIkHVP4IMBXBF+c9FNUim1SeJXzwvPa/G0vfjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HJOKSvMd; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS7naL7bzzm1MJ3g2j98KntXlFprYZMmQbIpdMqnoKc4jqSVInjiAFkigiNEg2ZvUznDj4OtX2Xb6ZMrKd4g3g4FZpI+BRUnIKjVQj0CKq39JmmU+rYmcuda1Aosu99CvXqfaTOKqXlZdVLXR54VSW7Zv7eOHqrXTeZya/2DlgEGUejcMBrfOlQsPKH7A6VAe/70CsicLkDjAOZNaEDWyhIu45AB08+cXDZVhvpzYawJhndG5gT89qNdE/K12DjV+aFaGYayt5PKy31k/wzi7rJKuWGm8Y4iNyX6sJKpaWDFCvQhm2x5ky+yospH9qe4LR4efvD2yEKUyywQTRLm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5asN4gechTz+hjEKh9L0yFbZdpPyBvxZHorkwZtYA64=;
 b=VF4aK9RqtQ9gTnb3ApCPMRxepE+UnZ02OsbE9KXTmGH5CNCMi14ewElqszmqxuE9K44TELP7CHJzfRlvEyqrAK+kU0aw76zKyXKGeDYAtzz/bgGqJ8VC2rJV8fVcy4kDXXwrP++iNuO607c1HC2vO9RIVIB0zMbVBJrJqcT/U7keXtOXZ0FjmtIwgDQC+pGAsQkVgWwblNHm8U1zxVhj8vF5PLGSUn417XkJVEfTmocf0kFzNC789fAeLCeqpMt24KM0izmloTfOM+ZejkzBIg6Cvd7RtS+q6kN2sMbt300+t3hhaUZZ2NaXXWK1ohUu35B97eQ1Ir7C3h5rlVLiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asN4gechTz+hjEKh9L0yFbZdpPyBvxZHorkwZtYA64=;
 b=HJOKSvMdmE4vw6olASvB0mBRfcSUA5FNRjO33W9xUwMm5o5pb3Z6Zn3inxk5eXCuWabJCkFe2HWqZO8FaAo2Ww8Adux8dPgMT+tsInJo82s4j7o6ap3gjANImbWE3E1Cyw36SOqTheLgVJ42E4XJbe73wwLZSa/NFLR7dflOB8XJapqYPjOlFX229ir2q8n2uJ/Q43KUM9saUigADaiULnfNFj5LvkSgEgB+vDStcwQhwQGnlNiUnJa4i24nLINyrkvXkYN2k3nfile+eZm+uOulRZ58c1xQ8zuJJkUaLmU+W9URFcb5ECeNR7hHcNawZBOiHDNefJgBQKRKKDsLEw==
Received: from SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41) by
 DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 16:39:21 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::2e) by SN6PR01CA0028.outlook.office365.com
 (2603:10b6:805:b6::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:09 -0700
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
Subject: [PATCH v3 11/16] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Wed, 9 Oct 2024 09:38:23 -0700
Message-ID: <021a42e13a7aeded63451279480510a8bc8a4833.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: c80f0764-2d26-4761-8ba3-08dce880ed59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCBjyiU6rosXqAtV/WX06NgOMqlrvMpRtf78rhRK9VAOj6oYv5BW+stkLs0B?=
 =?us-ascii?Q?qJlCGP7GIAOMWlLQj0gO3R2d1gX+D5A9be/nJH4TGuQgEY4Cs6WnM/Pm9QLt?=
 =?us-ascii?Q?JcrIj+T2zrxHCfiJiVYhwARSl75hXI55V+daOpjCql/tfxw1hXyO8NuYogEb?=
 =?us-ascii?Q?swXmNHIGaRqlHGj3XOLtQsedwAsfzhCN3XGsRiukpe81TLpDAgBdvJYSLCTM?=
 =?us-ascii?Q?gp0ad2wrYHueO+rTOnEV+1Z6eIsA3dJBxw5WvmmegUmvHeLzlYvahcsmL9IK?=
 =?us-ascii?Q?clvlQfipgnEvAsIwLdsF9Evy0vrCKRGB/5QA0g4Hd61q2EYGp8u4eaRLCCF9?=
 =?us-ascii?Q?RMnnaw+I0Tnuhce8uYxx30dYc1v3ObtTjk2sd3AuaXae3AQtE2X4gxIDcN2Y?=
 =?us-ascii?Q?xew3UhPkNJ3TxLdXwo76ckPFSZyrGMGqq8SCMVXpKPHmZa7r0dNXU+DxaLoG?=
 =?us-ascii?Q?ulMeDbldvu1UKn/gJ0/JodQ7CNKqg2fB4tS91F9xPGT4k/Pdi80xOfS3mQsf?=
 =?us-ascii?Q?KtH5BdSwo1X4ssyfG9Zc0NRC1mDYG5mEsqV1WdRfqYw+1Q6ih1sL0p9gvcbT?=
 =?us-ascii?Q?RBvMazbzgAz8d4yh1VUQZ5Rd3V2ePVJAuTt23XGHL4v3Swhk53YgnDg6vVEV?=
 =?us-ascii?Q?KY7akFjy2V085ucokG7xtsIdqs8vSg5rYxH3NZVwXV/lRg0NT+l8354ai5TG?=
 =?us-ascii?Q?Q78EfNbGfkWkGGHUM8aDEeA3J9RPqNrcj4PPs/96IcI0BVfYF3/OuhEESYIo?=
 =?us-ascii?Q?Zbkcmvdd89Mxugzk+5H8eULz55nI1VyhB1xNPnjNuTvmT7zUdp6Zo/vsWcIu?=
 =?us-ascii?Q?kJzoIsPOh8Hmm/8YO/Q6/k4ccXxQQAQgF3Fj1WOSP12OTfTlT9gM1nqeWvyJ?=
 =?us-ascii?Q?Q0FebmUOXpdIb+383euH+bDnBZBKfHfOm4U9Rc5ecGNpXhy+RY9Una961BeK?=
 =?us-ascii?Q?nxe69EFw4UyTsxyLW9TVrBDYP5m+PkFmt92kCY2PSCNEszSST4eV6RngwsFX?=
 =?us-ascii?Q?wxEIgI7uyjror/lEXSFohOh1u3qWXKQHBJF0KXOl8vNgPLIUeYzR2IQCRCrC?=
 =?us-ascii?Q?Yx0D9YGHVAnFhbBWhSyiY4LMETWvjvl95UoBJJHXsPUgopIPlz/fAu39FWqn?=
 =?us-ascii?Q?+JFNPzWChWwRpH1YQJPXTJnGmJuEBplKMrN/7ky0q216N0CTNi4P1d3rRiym?=
 =?us-ascii?Q?cKUSej90fexMy26wop0Va4O5jtQ2Ubz/4pZvkBBzC9H9t75Lb/1K/mhUYIj5?=
 =?us-ascii?Q?+Zu7lNOhj+JqfW/SZm7OroG8zYsnSb9TJJ/mU6eekZoYAltkTnOiRw/JFyG0?=
 =?us-ascii?Q?h+z6moTmjCImFZPlxl2xXl9h5Te986XdBvwOm/XKPYSZnAblRhiJdZpM1pKi?=
 =?us-ascii?Q?74Iq9kYDggYKH5WaiKRm7Z2EySzb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:21.3575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80f0764-2d26-4761-8ba3-08dce880ed59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 24 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  7 +++++-
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 05f57a968d25..b226636aa07a 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -23,6 +23,7 @@ enum {
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
+	IOMMU_TEST_OP_DEV_CHECK_CACHE,
 };
 
 enum {
@@ -140,6 +141,10 @@ struct iommu_test_cmd {
 			__u32 perm;
 			__u64 addr;
 		} trigger_iopf;
+		struct {
+			__u32 id;
+			__u32 cache;
+		} check_dev_cache;
 	};
 	__u32 last;
 };
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index ccd1f65df0b0..b3da8c96a828 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -234,6 +234,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
 			test_cmd_hwpt_check_iotlb(hwpt_id, i, expected);       \
 	})
 
+#define test_cmd_dev_check_cache(device_id, cache_id, expected)                \
+	({                                                                     \
+		struct iommu_test_cmd test_cmd = {                             \
+			.size = sizeof(test_cmd),                              \
+			.op = IOMMU_TEST_OP_DEV_CHECK_CACHE,                   \
+			.id = device_id,                                       \
+			.check_dev_cache = {                                   \
+				.id = cache_id,                                \
+				.cache = expected,                             \
+			},                                                     \
+		};                                                             \
+		ASSERT_EQ(0,                                                   \
+			  ioctl(self->fd,                                      \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_CHECK_CACHE),\
+				&test_cmd));                                   \
+	})
+
+#define test_cmd_dev_check_cache_all(device_id, expected)                      \
+	({                                                                     \
+		int c;                                                         \
+		for (c = 0; c < MOCK_DEV_CACHE_NUM; c++)                       \
+			test_cmd_dev_check_cache(device_id, c, expected);      \
+	})
+
 static int _test_cmd_hwpt_invalidate(int fd, __u32 hwpt_id, void *reqs,
 				     uint32_t data_type, uint32_t lreq,
 				     uint32_t *nreqs)
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8a1aef857922..ac3836c1dbcd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1106,6 +1106,26 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_dev_check_cache(struct iommufd_ucmd *ucmd,
+					u32 idev_id, unsigned int cache_id,
+					u32 cache)
+{
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, idev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = container_of(idev->dev, struct mock_dev, dev);
+
+	if (cache_id > MOCK_DEV_CACHE_ID_MAX ||
+	    mdev->cache[cache_id] != cache)
+		rc = -EINVAL;
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1615,6 +1635,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
 						   cmd->check_iotlb.id,
 						   cmd->check_iotlb.iotlb);
+	case IOMMU_TEST_OP_DEV_CHECK_CACHE:
+		return iommufd_test_dev_check_cache(ucmd, cmd->id,
+						    cmd->check_dev_cache.id,
+						    cmd->check_dev_cache.cache);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2651e2b58423..d5c5e3389182 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -222,6 +222,8 @@ FIXTURE_SETUP(iommufd_ioas)
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
 				     &self->hwpt_id, &self->device_id);
+		test_cmd_dev_check_cache_all(self->device_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -1386,9 +1388,12 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
-	for (i = 0; i != variant->mock_domains; i++)
+	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
 				     &self->hwpt_ids[i], &self->idev_ids[i]);
+		test_cmd_dev_check_cache_all(self->idev_ids[0],
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
+	}
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
-- 
2.43.0


