Return-Path: <linux-kselftest+bounces-21492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6069BD6BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D05282D53
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EA721790C;
	Tue,  5 Nov 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5Ryv70M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83421766C;
	Tue,  5 Nov 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837170; cv=fail; b=gFIvpaa6lRgugpXdQ5yDN8pa3mhBZ2IHC5pt4cWYQ709DrXAdeNsZtuFwQ8TBGOKBWMKSdEH2qT7sM7rxfCV5Zsd2vtcwM+4eeiJUEXj53/qU7k/5AVBWzBW9SnvRhKqcqrqdRKHgziaZpiyVFC4/kxz6XOQuPVXAY2Rlzq2PDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837170; c=relaxed/simple;
	bh=7FxJ6o/KJtduI/xHGmaahsEJI+V31s3Gvy76DoVx56Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPtfC2hFtRoAx42No07maXCtSZyxmAqrwMb2Gz5gaVQhnijYf+9w6Po5qqU4WDzXWxQpNbf50XHodTCH+ApE9vCxD9w0FLYfJ2eF1hpRuiZlTH2sI3ljLtYQxb64ewbutcySUwhz7Qp/GY5k6+1F8uk4TLJUqbRbW60oPh0TLS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5Ryv70M; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex460i/ELh99e9Rf8Fp6WcKI3yl8nRxCogev9JjxbeMdsqRjCDNVq8ePJfdTXEztXw18otEUorIem0K8MNy6flGJK10fXPA5GqBsDekW1F0EY1a0oURtEjrw1btQCVKzC6Ifq+zEP+qEv7PFMr0F32/1WM9teR1/ie7iep3ScsMaNo4BQk2irgSr3vjyY5P6Msj4hqoqfCfV2o9AEK/6Dc1y3EXAlygsWwAEfSFQF5zBSyVBGpbFPaYnWnwlMabflMlZDgVpT1jfx+ruUGUzorwW5qm61y14FnF968ExgtaSS9evyjk93PWSSfDPy9Mgso6q0B4kV7J9FIzzP6JaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5nKtAwwDxUk9gG84SVNW8j3lwMNm1vMBHvurJ8OvHc=;
 b=yoUF3j8p8bHAPAHd3oE0LGBV7feGAEIkH5WcQHfzLRggtPLzJwS/d/q1Zb+N6pfWrBohVKbv7b3YHHVNSbrMF5TOOm3EWjTqD2Z793XTG48gKrZ0ORcwVDL/4xG1ShBkcf56441b6s3DTUnJnQ9585Qc2fNEcbn8dO5h7rgeLdaLsXYOo6E8jJFpwq722YCHkDQRfiFesDcxTOJpSsaJIZZiNxPzaDcbtKfAd/oMrLZXCUvJsSH09jdaRJ523QxGCeUHAZG902rJ2C9v1SaYvdH72+JU2Matx+W6vxOAr4MIpoKCAir7ZY6N7lpboEn3nY3Q5uIPTit6p1h20wfbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5nKtAwwDxUk9gG84SVNW8j3lwMNm1vMBHvurJ8OvHc=;
 b=X5Ryv70Mo+5eC9+nFquwm7UMXWQO88puNAISe60+0KHaPT4K/DNiRslaI2PA/ZvherqxKdAtExF1X5yjriNuLDkaPE3nBtY14sHL8w8ODwBYzjASA+mnGp3yv6V1wqvTCgYU0n4ie0S0Hx/trUsvwjhEB/9eck1JLXQuTO1JQCsId/zaJXnGWBrgOAbC+tt33HBBVSmJXYgaMnRoTflke8vGIlpvhnwKywb1VYcyyjYuIQtvHYyIwRLPGnKMlTpF6A0OgWrmSGNoXX7Ku6scVoHtZRphkTAZw9gEvPjPX5HPnI+PaXDe6ilsODZf6Ovn+dMNAx915XM0EJ+r4Dt+EA==
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:06:04 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::9d) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:06:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:39 -0800
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
Subject: [PATCH v7 08/10] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Tue, 5 Nov 2024 12:05:16 -0800
Message-ID: <cd4082079d75427bd67ed90c3c825e15b5720a5f.1730836308.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836308.git.nicolinc@nvidia.com>
References: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e06084-6a43-4805-a775-08dcfdd546d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CkMciMzt4pD7j0g9eftQB9PyvQOnwK2LybdXopJdkArRfq3nCQNgjDMlFv4?=
 =?us-ascii?Q?sSZg/FL01ik9xBg29hQ/YEHlchR0D26MMCYftc067U0Qpnkxqy/KvOFLok1C?=
 =?us-ascii?Q?EzXre+fgPCUNXGWd1N0JyFWK6AcWXWouvHrTx/eFEUM/Pwib0Xfck5v0nwjY?=
 =?us-ascii?Q?Uijh5UkbwZ3oUDHu/WixFk2/TZLFGvDw18L73t6P2CRkWG2lq2H3f4Ts3SZA?=
 =?us-ascii?Q?NVsSICY0Xy6hNlux3r7tio19H+g/IIGFHXSSxl6Cm+6/Zqg8h2AcK3qS8VZx?=
 =?us-ascii?Q?jZtg+ToCXkMyYGwJlD8ZnuctF6rkwK5GccAVXAC4HEFbhd7ucnjJ+CAAJS4V?=
 =?us-ascii?Q?O0pME+S1NlfFIitC14tnWS3ZLPGsRa039vKdPIQw/7ziJoQXXI6LcUizSx3j?=
 =?us-ascii?Q?89vqwLrafMCW6ef4ZmFiWcLxYRjDWDdnEcnNRe8ZLKLjMz598V47xiQRsYCs?=
 =?us-ascii?Q?aXnFdB7J4U8YglIHZfzYtlI/UjUR9UJOH8uXQD9jgKN7o3TyyxwHIrKY7297?=
 =?us-ascii?Q?v2De6u949eSQZk1iBWAVvYYYzRQCKVz/jLOb1Bjqy8TqkWCbgDs6WLc08kya?=
 =?us-ascii?Q?YgqKBj4DDyNYPdnH4/M2YJN+zWdPso7pCNKWsKrcXlvpA6zPrhH3dxxpdDmy?=
 =?us-ascii?Q?CcDfTE7t+RUSXYlIOCuL5pVlVZ7FMFKpTYHLyBggHn3tRCOZgYKRAmIZRdFm?=
 =?us-ascii?Q?CO/O4kunGq5mUPqFsmgqh6/XKCw96FGZLTCZHfK7BJhu9+d7ZTHlRnxXyz8F?=
 =?us-ascii?Q?ZJi3i87928wQnOTGgCDdWyofmM4Hjq8Ss8tP+9Tp/xeUHEkeTOsxjfT/eBtX?=
 =?us-ascii?Q?S9TR5Tdo7Z2jU0HiGbqlObuQ5FVWjHBuatLylKkMjR39p8KKYYxbDNN4gXDr?=
 =?us-ascii?Q?ybw0F3Dl7BM15KWvhVyiWH0TetGAexyjGHMkgmBKY8jsY+JSocnuRpgnvISA?=
 =?us-ascii?Q?LlsjyGERhBMMFx4zF/mu2/5lHm2fzRtpG+OY19DvHaHmNu6wauws8KSE3YEz?=
 =?us-ascii?Q?n77JnyyXmYU95rCt+hBOL8GgtKTsvMo8yaQn8B3TlSYrXYavXhU8emfwjWLT?=
 =?us-ascii?Q?5Giqn21fNomsHq8rsW/v1jyqSf/e0vt6Q7WpkDfXN4/AAE2KR7IjbstMtSoz?=
 =?us-ascii?Q?/rFRTsIu9RAE3s429d7vtklhhYYsCN8y4M7XViYlNOb76aQWsVmyn+b/MmrN?=
 =?us-ascii?Q?xUJBV+jgZuHVfbgMssXXdsWo0dD4lZIx6Y3Wlc5qg4Yx6xUTRUpo8i101+T6?=
 =?us-ascii?Q?BmJiXC/l6wlYkaq8O19Roq7HxgWp3gIBSpVH0uoNXo/4OnabXBb0of9wOry7?=
 =?us-ascii?Q?Q3ljXT6ASKAjdbWay5g4WVkmPeM/Que6M1sfKM5vMpFB38tiV0GcXkDB2a7e?=
 =?us-ascii?Q?rGaMrOA6owhUHRTbjiLdTf77BjyRt9VAeW9MBCU7PVh5TbABUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:06:03.5914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e06084-6a43-4805-a775-08dcfdd546d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 22 +++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  7 +++++-
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 46558f83e734..a6b7a163f636 100644
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
index 7fe905924d72..619ffdb1e5e8 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -250,6 +250,30 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id, __u32 ft_i
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
+		ASSERT_EQ(0, ioctl(self->fd,                                   \
+				   _IOMMU_TEST_CMD(                            \
+					   IOMMU_TEST_OP_DEV_CHECK_CACHE),     \
+				   &test_cmd));                                \
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
index e20498667a2c..2f9de177dffc 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1125,6 +1125,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_dev_check_cache(struct iommufd_ucmd *ucmd, u32 idev_id,
+					unsigned int cache_id, u32 cache)
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
+	if (cache_id > MOCK_DEV_CACHE_ID_MAX || mdev->cache[cache_id] != cache)
+		rc = -EINVAL;
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1634,6 +1652,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 8cb3e835ca97..4bc9dd2e620a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -227,6 +227,8 @@ FIXTURE_SETUP(iommufd_ioas)
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
 				     &self->hwpt_id, &self->device_id);
+		test_cmd_dev_check_cache_all(self->device_id,
+					     IOMMU_TEST_DEV_CACHE_DEFAULT);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -1392,9 +1394,12 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
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


