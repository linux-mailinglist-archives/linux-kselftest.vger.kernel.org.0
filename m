Return-Path: <linux-kselftest+bounces-16436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0819614F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AFC1F2134D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20511D4149;
	Tue, 27 Aug 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hri/Clc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB851D31A7;
	Tue, 27 Aug 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778128; cv=fail; b=OwIorZHUboBU5mHFbAg9Y5TcF9bkl7DwPNf6jm6EILjzi6c4wHgakRXlDdomc6zAyUGpZe7xFZF37tBTtFJdHAKuNpQH0JfKRBriCxReIJ5QaIIinypZy5rha4gwGyBrlN1pCichhuDl8wftnsK1uO2ST6WJIlJcsiq+r8jPuLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778128; c=relaxed/simple;
	bh=4MPWhsqj/FebZM6x/n/994TUhm9A6//Gy9ZMdKgkZsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsSicRxXQgdB3BUckgpM3QBLSNk7wo7M51Iy1zL1o/II2E1PBKuph78UdwpO8GKPQ5ZhXemaOtGpoz16YfDrmX6HWjefnWOuvTYt/Ik+/3kfz103+Pf0vpaG6ncvl9bPb0OWOfcG1vBVLLBVPTzSAnSGA2iZsPm4LWQZXUEs/ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hri/Clc0; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfmEiUWdJ8nVB0M/+8L37oyv8OfYaW4TrXMzVRMvMKIyppZ3F+41AsoOK/9hIe7wF0A3Bh6/sB9lOcffsK4uP4c42AcsbESimJUvjPmUQdp4vqpR2zZz0iyorurTDiVkj8JyjVGozNcJP7U8Y6xTzeXUOwmxemcAOtoXhfyxjiE5feGUJkMYj6wVgduqibvmRtJXs92lnAgZXMi+w4uOGqQlPuLlVyiulFiQJuhJ7PIc/cdgLBkmUzKkWvvdd0qtjL7KW7K98wZEZaGJAD+Zxq3+BwkCi6cVlA4QXuI9oLoYn7U74umpqypt9J4bZmkKayImS4sa1r8/18gv/GPQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb50j7u4dY7uovSJkFOcRrYksErIeVocq8zXlcpiRJs=;
 b=cdAHpEWwzHKFwdyIjMAZCUb8V2g8TqPqPE86rqS7mZcZzmZKblHartGa0sudEV6ScKCqz8UOqid3vqip5EQJoJ0Ppd8CEJ8c12VyCbgU35xGvXIFNoHn+lfJhKFfnzkPrvK/xtlQjZqqrOQs+a+8TN8GRdeeYC3URB6P22hpVokEynVe4QJ7wCMETFivojvjsCyZlD5F+Qe0Xi6g+YTJBUHrbQ8PyOWd98vgf9gdK+4KDMVuD1oRIl0OLX9rfLjzUwruL6J2126HQKfwQc7OsX8gwV0oBe1D3nHX+kGOM/3Wv+PP0EkWWNUxDvp6mj8PvNxY26GLfCCG4KTNnnSkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb50j7u4dY7uovSJkFOcRrYksErIeVocq8zXlcpiRJs=;
 b=Hri/Clc04HEvD/gYnT8Z0iAd4UqLUAPMLmnzi7/HMEjX9vQGYrlI2qtLbAAQzkh+hIthl4cwh2TWPpImlGZXMzFFIpn00kCBtGX0hzoWaQqypvVwrDIwGCzBA9NFFsgiPj9QJLMtkNype21hStTul9n/iHVqfbWqFi2SPI7o3kaDE5CGpUhUlxY9l3UihVmlEFRVo9wBejVYj2Gl5VEGS0PJKb1Y2ZP6k2FZey8w+22K/pLlc0XTcGwvKwYJQBjsKkHIUMuUOoQ++j0BzIUA3nMtVQFaoF/syJke5y8QQq9+YCinw4AxeQTVHFssqPiqHrl9+iw/p9CbJjKnPZqKoQ==
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 17:02:00 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::6f) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 13/19] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Tue, 27 Aug 2024 09:59:50 -0700
Message-ID: <a1be4a0d01fd9d6c3d307461ec2cfeb805e7984b.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: af78c2e3-1963-4eb5-6931-08dcc6b9f73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y6ZAP1MccFnI1sckeADIZaMEonMR07rtUuCcMkWPkJj+wTzNkCQzIvyyA65/?=
 =?us-ascii?Q?XLOmbjXsgBgcabvFTypBf5rXyyTm2t0kRwlq/3dESz3hCgL0OqZu7Rq0ZNpe?=
 =?us-ascii?Q?FRmGbJsxdDaeI23V/9JOALwEvqgCgxnBKXmQ97xfzQdCUB+Y/Vfncr7kO3Ej?=
 =?us-ascii?Q?03k12HPeGoOIFFtqj9hiXC0TNmF2hLYWuksAPgH3RFsDp0SxPhLkSLTFGVH6?=
 =?us-ascii?Q?+JRCl1/jHzsDRWmDr0pAuj7HbZMvebMAt5olUVaGQM/z2nzDtJR2HCn2DphW?=
 =?us-ascii?Q?hopIJjqlIWCbKs/oOIZQbifmWQFlk2unh2E7rh/jSFS7MnQvs3a8OyWG9tLT?=
 =?us-ascii?Q?SdK/HihsMERAlzRv06bnhMdAVIm4zI7z5UuV582Aj+IhPEWEE2b41GwNLQMA?=
 =?us-ascii?Q?LuyTcuwj5AMgayEcyXgl0VEmhJkYyK1XCKLET6gtIm/FwsHFhtB6//ngFo6q?=
 =?us-ascii?Q?PKM/B0mdMsioxbfnY3auO/6JBGwM6LLv+oG9r3dT3fffpFXIvQMLmgBA1qy9?=
 =?us-ascii?Q?q5imKl3LDFhXCXQI3Ic3OU1LmEs8+9SOV1Kj26NzbCzb6ipmZe2APY66EOgq?=
 =?us-ascii?Q?FTC/KznWSAvivYPkUqG9nlZczPydDXTcFXPuOUHCyczT9cuVTxrr10PT56rC?=
 =?us-ascii?Q?CbTRmSerSDofCxH0wgoVxjOo66ar9DqvRL50BSIV00RlBVQUfg11bSI8qylJ?=
 =?us-ascii?Q?O2oFreHSIoOd2dLvhK7ayLF0GY/isRBKk25gEswqw3bbRji1mP2DC5f1xp/3?=
 =?us-ascii?Q?+pXnoiTm4x3P8BxGuhzBzL0LoSVPJY0cQagnP/1i7KW1RAI0UalqC3lrqkqy?=
 =?us-ascii?Q?FRuauT6JhJt6hmWrkBi1ilTEgG4vvw+8r3eqFmZfXfGts1vabSG3Lc2tgD7F?=
 =?us-ascii?Q?M5m5X8Kl7O1CGbG7EkqGPe1L3Qo5+UDp3lSSghl3BbRqzwd1uKXCMXg5iua8?=
 =?us-ascii?Q?Ut1Omf70Hi3S5xBGSzbIJdtnGlspbSfEx6+Lb5ulUoBaiDGgxyJy4SSCfLe0?=
 =?us-ascii?Q?594W+7iwV/gfiapxDXLPzJaNzP2ygXD4BKMpj2vvRqbtpz5beWb2PMf4nvOD?=
 =?us-ascii?Q?4yLDyBMSoiJiKSr1giQw2yGb17ukWNUCHVW8feZSuYeJ+yPVs5JQIQNQKkh4?=
 =?us-ascii?Q?74w2ylFfJkfgWB2ilI2TDu4ezlMHU9yKZ6yrigQ5zoU3KWtSYwpabSzqgCFp?=
 =?us-ascii?Q?IdZpvLQfXHwobAlJ5kQgbXMqhj7lBCeAiNxKBgXQ9b2GmjaA2sHhCSxqpl/C?=
 =?us-ascii?Q?N7XAwW+mGg46Jdrb8Yr5WLSBLtAzftF+ksCfI3pDJmtXGQfkeVDvKs9QR9bp?=
 =?us-ascii?Q?gEyvqeNrOGbwZ7AjEwfrVEMbEssZGJUcdR0nSo2rjaBznGpKfThogtm2IbCP?=
 =?us-ascii?Q?grKU6yceOo/0HnKyGInAPTtQybj5T8huviDr8khkBvfxtz8DOx80lDscD+Qq?=
 =?us-ascii?Q?QUyUG4rDGmHQikiyV4pEjWKCGh2lCyBI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:59.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af78c2e3-1963-4eb5-6931-08dcc6b9f73b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

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
index 368076da10ca..56bade6146ff 100644
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
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8abffc7794c8..f512874105ac 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1035,6 +1035,26 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
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
@@ -1545,6 +1565,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 12b5a8f78d4b..1b45445dbd53 100644
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
@@ -1442,9 +1444,12 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
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
index be722ea88358..d697a7aa55c9 100644
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
-- 
2.43.0


