Return-Path: <linux-kselftest+bounces-14963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D494B105
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74D71C21AE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B0E15530B;
	Wed,  7 Aug 2024 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAadpBYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F014E2ED;
	Wed,  7 Aug 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061504; cv=fail; b=lJ/JdpBde5nOiGX7bIi48ACAvbCzT/WYcoeIZDOvbvUSr7IrRM5Yvj61WmsDbjBcn3wJ5r5HSpjmpRxh61sk2KZt3qEXehDk90jfwGB75EBgEduteCoNU/TLe9DeQuc7s+ao5eArA/s5WEIg+ysYNB4WDDq3/Silp3w0AWU38ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061504; c=relaxed/simple;
	bh=HUZ777YdQv4iBkdAvnIOCMcgUGebLiEi6auDO4s32Rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiHD5DNCb4mDv0op+axN+BzHBPp8NNQGfh0wjr76ltJXoyx3fYUTzYpqRNTGnz1gjNLbWNVqprbrYcgS8N4znGMwotU9gMxh4LpElDUQU8R9CfNT+HnNEO+gMO0M3LDcrVdTZNbyfjBUPDZFHMKfm7IjawOoDhaWhtWy44nwMwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAadpBYR; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoutBs9Jb+VLP+QPwYDObhawMGmttQfFq+aH5S294HCqPGJM+IRycgp+/sLjyixS17YOqjZQwqWx3iSEdrLgUaOfKd2cW+YFR0bljnaBdg0YT6+E0KPkvxyxVwy9WojxPaOuW9H8RBhK35ESbxLd38hdNlhVmQbgrh47AaE+37JPFBCzTrJK5hR8Qwx1Yn4Hk4dDkvKpmwpFz3JU7kCUe/nLoF/sY6oXvM79HJaL0uDGQUyjDK9FIcoHn5UN9xfmPwn1PwFCDlhKelNxHbEuot/mUPtFuByDAEUqf8pRmYohE1k91H6IYsx+RmYTqk57BYkyJlo2HwWsmNnZ8BJQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC9SNW7IN7fFhJQHD5YDKVE2lhSn6XQdyrDWCjDgKqY=;
 b=Tn532meVyExfsO+eOqgktqLdmWtVL3YhhUGNjnomZTBqz0F/pS7bSXzzuc5Srqh4xewhvbBcPaWo6bzEU7qDdQ7uHeiy5zXZpcjvt5cibLaFsggcUbxX1s9xrCu04iSk8ZZTyd155qV4Y4bk545H0/kFvV0W2VZZriCYmk3nosdc2fjbNmE6HanGUYGGxFIAdKX1eXevmY0wHoXkhykeo6xf501YZWLE+1ba5FEb8OHRCIQsLnSV4CWUnOyKTaYh4y87MuGxOn0MmLXBjkaQSL85Wet3E/yj3xcIf8+J++VCfgbtgnrGvbsPR52M+3rPP4itnbZHDmHRefK1P9p/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC9SNW7IN7fFhJQHD5YDKVE2lhSn6XQdyrDWCjDgKqY=;
 b=fAadpBYRSFxcVTp17radY/bLzYE0o1Undp4nfRSVx8r2CpwTqjCIyGkpfUGlfrRZy9T3SxXFjeFSBuJTM13u0r74VDvr9pJ0SJ2IPZmcZaEVUg3DUZ74UoYNMKbkSGegKiviqMfHwi3j9hciS4VBS/L//XLP4oQ91NB+Q9EK5K4Oh2ZLr0Mcb95H48KsI47q/uUidgsk4WmIts8u0nAAGe5TMqIIkvmiUTsRik5dgtymdG9oJ3Sq/+o5TL5ehOA03w8mxRnml7UKZ9T6HuH/ZMzDo00dvK+TmOzd7gwSHknvHlpqwoA6ybyNMo8nUYY7YQdp80l1IQw9PVtRGq63Ew==
Received: from CH2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:610:54::12)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 20:11:37 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::48) by CH2PR11CA0002.outlook.office365.com
 (2603:10b6:610:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 11/16] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Wed, 7 Aug 2024 13:10:52 -0700
Message-ID: <8fb4b729182b39165e9594f71eb756fc9679b97d.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 14078cfc-e4e0-4bd2-f8ad-08dcb71d248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34flCrzNvKr19Kdf+yapPYGaNVH8ifp4qyESDdnkdQKMX1bn5o74GUy/9SWr?=
 =?us-ascii?Q?CGTtWmpFfay4rKXMY54/yQDLTt4u2nM/O4u3NBMX5MKIylp+Vi54AM6TUl9z?=
 =?us-ascii?Q?G4bLRPAwqxkmz9Pwz2uqvNbioeHKL62Bnrp0K71zbA/Wb8sQ4dJ1cH4lsvFC?=
 =?us-ascii?Q?blunAe6Jh3w6+0mbkcRngEhcn4EwwKvRuSALnXqJCxC6nmaKJdxzCrn4XLl3?=
 =?us-ascii?Q?4V0PGAmDOSpPFCuS3eb4FQ1CPpODlaxBPkUpCo7xJUQPgL9S4ECfzdm/Lj6n?=
 =?us-ascii?Q?66Zl/kZDUvzJBf76Qb6ywktnP2yII0EliXjDsv/9pXN6PdV1q8pCcaJE81sN?=
 =?us-ascii?Q?t7Zf581RrW6fLd8hxgyVO6QCNKsfuvMGALNYK8Kv6ZEvQFSGVcSEPAcD5eUL?=
 =?us-ascii?Q?NEr/RoLnONiNF3o+ol6tpEmZBnVB2ZiWdzoLCH7h4YJ7EmjU8FI+FQ9cJHat?=
 =?us-ascii?Q?F8xsmA+aoiiu7tbPfEqEXbjWuz3afmA+K3DEs67n0Zkujj+9nDJFZN4/wIHx?=
 =?us-ascii?Q?h1RHTKg0fGZSiGDXb9vhM+CvTfC+qJYpiT+Dl1nxs+32c1x2iZcvlrJneZVl?=
 =?us-ascii?Q?oI89w2JvgOb98ck223E69RwJd8MtDSyFRS5usuuDdpxyT7lPTn/+almhRiuz?=
 =?us-ascii?Q?UXfL6VGrsv7LNTkfRjQkBPZateHA9JLHgHJSsIjkWNVJO+2bFlRNcXLWkVxm?=
 =?us-ascii?Q?uRwk2j6LleHdzDx7vfw0RZeodkD7+QXCpkTfp9/9ij2ESa6MCodCAn2i28Ih?=
 =?us-ascii?Q?yatzgP/VcX+joqig4uO054TZP/ZezbMALE8Vp7P63OZQacU40VmeW+Jav3zl?=
 =?us-ascii?Q?D3VJ9WlO8JQYlKNmvYqrQSYvaVvBaX3+ynLAU/KlQu3qn99XQLO0oh99EXO7?=
 =?us-ascii?Q?rXgNcGVaV4vUaR9w7kzuwRLiZESfNUxh7UW2fFgy3/Qcv5iCS6Kc6NwS7pH8?=
 =?us-ascii?Q?PSJ9MGzDnLUfUGkJ/WAArRzUCswwqncEzJRS4UTG3qpyuvUIJELq+QYYBohu?=
 =?us-ascii?Q?nAmDzvjXE7Qz2BBpWwvSKEvlpjJNl01VkdMFDZwT7/42KbaXjkGp3JhQlWTR?=
 =?us-ascii?Q?DhmTy7pDvGOuNwGT2c9tFXzxvraSUtFluprAAXOIgIEnSFU4SW+oVmUwrwWE?=
 =?us-ascii?Q?riR63JOU2Cr5JWoYvIfaOw1eIykpruDuNH2Y8C+WhjzXk5VgQbTlEyRQEpiL?=
 =?us-ascii?Q?iZ7PD6zm0aB7FOiYamTI4xtQspoDFtobVysz7ONXxlICzclSmuo7G6LghVHn?=
 =?us-ascii?Q?pVQzRfWGHkqNRsQCNakPfo/2ARiyu7JsvfWGcUmuFPXfrViMcMUKaPYxbLkP?=
 =?us-ascii?Q?OG/qqPsXcJPCdJMDo2JhwBJof2tsVZrTz5AseTN164o42ns4qT7vesVLEnQV?=
 =?us-ascii?Q?H7pLGcXs6j7bzS58qIfN6CXd1d1SVv2UfGg42JL0zrnlVEH1W93VL3LiENNp?=
 =?us-ascii?Q?tRgraLIbdNGH8K+l09sMUMZOpaiERkDM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:37.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14078cfc-e4e0-4bd2-f8ad-08dcb71d248a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778

Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
 drivers/iommu/iommufd/selftest.c              | 24 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  7 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index da824b58927f..8c21c37a41cb 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,7 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_MD_CHECK_SW_MSI,
+	IOMMU_TEST_OP_DEV_CHECK_CACHE,
 };
 
 enum {
@@ -144,6 +145,10 @@ struct iommu_test_cmd {
 		struct {
 			__u32 stdev_id;
 		} check_sw_msi;
+		struct {
+			__u32 id;
+			__u32 cache;
+		} check_dev_cache;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 4858c74c67be..a79584fe8331 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1103,6 +1103,26 @@ static int iommufd_test_md_check_sw_msi(struct iommufd_ucmd *ucmd,
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
@@ -1616,6 +1636,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_MD_CHECK_SW_MSI:
 		return iommufd_test_md_check_sw_msi(ucmd, cmd->id,
 						    cmd->check_sw_msi.stdev_id);
+	case IOMMU_TEST_OP_DEV_CHECK_CACHE:
+		return iommufd_test_dev_check_cache(ucmd, cmd->id,
+						    cmd->check_dev_cache.id,
+						    cmd->check_dev_cache.cache);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2c11525ae754..ce2e8c9ede9e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -220,6 +220,8 @@ FIXTURE_SETUP(iommufd_ioas)
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
 				     &self->hwpt_id, &self->device_id);
+		test_cmd_dev_check_cache_all(self->device_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -1450,9 +1452,12 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
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
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 1b494752a87f..a2b9a6bbcfcc 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -243,6 +243,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
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
-- 
2.43.0


