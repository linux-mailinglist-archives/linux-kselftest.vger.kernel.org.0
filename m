Return-Path: <linux-kselftest+bounces-16428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E736C9614E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175621C22674
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA331D27B2;
	Tue, 27 Aug 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2wtJs6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131761D1F55;
	Tue, 27 Aug 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778121; cv=fail; b=ZphVWDQAFoUaQQYHDOMYVuPd+d4zLd5exPkdAUoJyJ6Zw9TzAZTnB7k9B7X7egCK5q/AzAvBY+d7JGQdU7GPWInbsB+jQisV1MWqhHp0iv7XYI6ByPrL6NvwEyVQ1hlE5o5kss85PIbyrcs8+NMyi6UpTP/9dGsTWTiTTdtVklQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778121; c=relaxed/simple;
	bh=hdrvHo+cpmncv0gLtnV1LzMlee7mCa2eLbx+7qHMU7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTIJNzgKDEc8HENTG7a4BRJXkfkJd/91ZphukMXZ1yquhqHOuWlFkYx31DYho/mM6Umcu76Vov0lOvvnKa2VfmpGuKbsPXgXenirmfh1aVc8JPwqPWG3aonLHqWF936FY0R79ltOrXLX4g6klouq57h5ihcxDch2Zpjcm2YA/+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B2wtJs6w; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhcWQhBOR4K17jbmqrLRrXPsZy5JOiqpMoFcP07dCTg7dtDUM6qoT3wz0JRJu+aac+54Oev5IdFJkPHhmqEkcEztInhqCR23br75rfZK39LStJYCjfKaSprF5lal6DcNyxUT5C0e94yS9ASkcMq86h9gDZNbWpSOST9MHF64HKFM0BWlASIF84dIpECzDEYiLJMd8ZwRGydrEgvn16bipgdHsP0dYySsI0Kjm0P0ffMnNJVHKzIg+iQPBrxVA40wLWYwrLldKW3C4GFmqFTI4zyXjEn3w+MyHSbxeNdtp899UqwteRFYd0L6cRoBTrrNp+PDbHBu7WxnEkF/fJCY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psrH7MS6rlNiHBO9Z0q+XH9RD0CwC7/PxtOF5kAMoFM=;
 b=RsUnAYq39t7Ci49B6xtUGZKwoUPbyTkwFThYUDOAOOZJQLI35HBDY6PiJMjGUXQUu7w53g3GT2KE2preNW62Hn2a0RhPea4UFTLxuWbC9mxtSYUAO7mj0IWYgQxMs50ft3U6srG0aWYKrJB30UopJ34a2Go/whTDV9R0zVl0O6NGThLBttPM+U2l3nQgxNRthkHf03d2OYgEKd1V+mWyxsq5Gl1o6B6tRnG/yy0V5zY8CMIjxgzi0NXr9CGv8BNFB//NVVwYveTNTf/HmCLLEU5q6Bi6LOZ9usSMkEbSy/EpccvvHLtvX2yTkWIUj18k/6DM4Gl/0pTnvqAVEOOz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psrH7MS6rlNiHBO9Z0q+XH9RD0CwC7/PxtOF5kAMoFM=;
 b=B2wtJs6wPBFA4ZG0ABhK09Ou3pnqfaKJMoR1pYzPph0XBO9W2teE/Kd1z8W+06DDrniDsMzTH1x4HJxnq8MMzMqPRVlcipmsXcglvCFm+kqLUk6i0MLn144M3JYz0VcaiUda+OpxE2WPZ0e+XevqZ2/lqRab+DUr8O0JShvvHRImvJ+VVDMMBbDPxrWb+LCdTFWKmEnpt/zN+iYtexIuOs73ESOglJbVg+RjMpQtDPDrJJ1A5Q16kduYXN6r2F7qcN3xMf+p63u+XZbG6Y7nmOqXMZld36S5IXul21/HUfcnvTt5wGCV6B593QtDy/yMfvdhDU7bvP9rmEHXl9Olow==
Received: from PH8PR07CA0005.namprd07.prod.outlook.com (2603:10b6:510:2cd::29)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 17:01:53 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::ae) by PH8PR07CA0005.outlook.office365.com
 (2603:10b6:510:2cd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 07/19] iommufd/selftest: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID test coverage
Date: Tue, 27 Aug 2024 09:59:44 -0700
Message-ID: <ea7478fd481672487a465f8fe6e9e546fb140a14.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: c80cfed1-e71e-48c0-d5a9-08dcc6b9f351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z82I4EHS+AMpnzsCJToIVmpTxZaFegM1Y7fV4VZAe7eoVMbT912iAtqvehZS?=
 =?us-ascii?Q?6JPSnhkJddbzEIyrSXtiRX003AvR50gEgfMkEu5/Jgs+SzuflIPYzZVNxDYT?=
 =?us-ascii?Q?ciBxK3nPgScCYocc6q5uHNmTGOKyoKbE+oeEjvQMv6Vhnxx9pLnBJB7FJ5oK?=
 =?us-ascii?Q?Z5OUki7jBelFgHXyySvb+H5853NVbRNohH3ey5XkX4x6UqZy5leLWPZFd590?=
 =?us-ascii?Q?EGCC3eL6gz6r7cRxeMemSPRC9n5JnGEmri0C4dH1fzpeciu8/umX3qKhaWDu?=
 =?us-ascii?Q?beChIy5PsQx1d5m/6iibKustGy8N9iK3f9QveCrSDdDldtPbRfkAB/+cLkA4?=
 =?us-ascii?Q?jmFnXDeyNVUDDpI+nTL8Qi2NTTPNORPAqh683Z0nybJADvxABovLsvP6Mp+D?=
 =?us-ascii?Q?hE2SAGoMhVlx3tOq9QvbljuwdzHmJnIXRYLNapZappY1QdotH/RM9QHMlNBs?=
 =?us-ascii?Q?iJRRXH5FzQBfPYC8baM0rkiBDsllFjHvmafELExJ3EmWJGv3i8xM9skfEZDI?=
 =?us-ascii?Q?oTcemDfRgRy0FYpqalrfzvJleiJtKuampURO8qbRx30S+T+cVGmBJ4mui1ZU?=
 =?us-ascii?Q?+E9mgJrT0ntjV/qalABGm898Et4xH+AHEcnMvCUm6zIEqfuVqOleabtuMmFj?=
 =?us-ascii?Q?pUp4ejMSFE6xbDDKjhqMKRiNgWgx3xYPXomJ22+yZNBUYuLljPalG4cQKmo7?=
 =?us-ascii?Q?EK8f/mDk/txj6gqaVR+FAF388B8tpdDWK1deyP2kotiopc+MjP/goKapPnt3?=
 =?us-ascii?Q?6y43KhTBd/NImsUubFGrrR435fFcSigdGWiZvdJ6B8Utu8f/rHO3QN4ueQzi?=
 =?us-ascii?Q?mmFxFL46Ap9BEMuCr3hpuq4au7VHQsVNt0Fxm6hSh1GJkm6ieTP6G1lGt9bO?=
 =?us-ascii?Q?Yz3uqsFOzCUTlvUfMv8PDpyb8q1gCYaHPRS7vNNQzjPCH8pl2cDHOGuu95k3?=
 =?us-ascii?Q?sbYptKENcYesqEicmMqWQKyDIB6ySww5mU9gGYnugKhHh7nHGhNbqlx+1P7r?=
 =?us-ascii?Q?MT3uV9J6Ow0mKw9rG9DDK0ZpAxkptCMzLa2qT+U9UqCVAmBv+tzZ030Ik2W7?=
 =?us-ascii?Q?EUNoCQCu/STkoRMyQzw4i+8iJKm9HYxUwGz57Rka9LVzBXmuIi0CiKim6QWw?=
 =?us-ascii?Q?JuEm+3Iu1/HZvJL5r9T0nxELmH7xW0yWNYA2UOvua3Q9CrPCvsDm/6rV9ChP?=
 =?us-ascii?Q?VjFgNjntOG0IB2B+VOApZmieLkQNV7PjBG+iyiWsDASc7O5aOvejuOscmVGn?=
 =?us-ascii?Q?lzwRLIYyP9UoGaWtEW/rST7bnr9flpOzlWYC1VHuOBRLiPDvuKRLHJcI10jB?=
 =?us-ascii?Q?WOi/pcNVrDaY4qQGTV8X7L3r6YuYQvBIstqxvVnYzWL90tDDV3BHB2c2a4my?=
 =?us-ascii?Q?ZVd2MW8V6o+cngGJf/IzoI1VghhgBK0Lqcm+cOwZ3D8E9ooDP8984iPDgauw?=
 =?us-ascii?Q?QcnimD86qpkPCglJLS/Hv21RzGV0C9Gd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:53.2150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80cfed1-e71e-48c0-d5a9-08dcc6b9f351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

A core-managed VIOMMU maintains an xarray to store a list of virtual ids
to mock_devs.

Add test cases to cover the new IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctls.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 27 +++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 42 +++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 5c770e94f299..f383f3bc7c8b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -556,9 +556,12 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 
 TEST_F(iommufd_ioas, viommu_default)
 {
+	struct iommu_hwpt_selftest data = {
+		.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
+	};
+	uint32_t nested_hwpt_id = 0, hwpt_id = 0;
 	uint32_t dev_id = self->device_id;
 	uint32_t viommu_id = 0;
-	uint32_t hwpt_id = 0;
 
 	if (dev_id) {
 		/* Negative test -- invalid hwpt */
@@ -575,17 +578,37 @@ TEST_F(iommufd_ioas, viommu_default)
 		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
 				    &hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+
 		/* Negative test -- unsupported viommu type */
 		test_err_viommu_alloc(EOPNOTSUPP, dev_id, hwpt_id,
 				      0xdead, &viommu_id);
-		/* Allocate a default type of viommu */
+
+		/* Allocate a default type of viommu and a nested hwpt on top */
 		test_cmd_viommu_alloc(dev_id, hwpt_id,
 				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_cmd_hwpt_alloc_nested(self->device_id, viommu_id, 0,
+					   &nested_hwpt_id,
+					   IOMMU_HWPT_DATA_SELFTEST, &data,
+					   sizeof(data));
+		test_cmd_mock_domain_replace(self->stdev_id, nested_hwpt_id);
+
+		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x99);
+		test_err_viommu_set_vdev_id(EEXIST, viommu_id, dev_id, 0x99);
+		test_err_viommu_unset_vdev_id(EINVAL, viommu_id, dev_id, 0x88);
+		test_cmd_viommu_unset_vdev_id(viommu_id, dev_id, 0x99);
+		test_cmd_viommu_set_vdev_id(viommu_id, dev_id, 0x88);
+
+		test_cmd_mock_domain_replace(self->stdev_id, hwpt_id);
+		test_ioctl_destroy(nested_hwpt_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(viommu_id);
 		test_ioctl_destroy(hwpt_id);
 	} else {
 		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
 				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_err_viommu_set_vdev_id(ENOENT, viommu_id, dev_id, 0x99);
 	}
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 307d097db9dd..be722ea88358 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -790,3 +790,45 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
 						    hwpt_id, type, 0,      \
 						    viommu_id))
+
+static int _test_cmd_viommu_set_vdev_id(int fd, __u32 viommu_id,
+					__u32 idev_id, __u64 vdev_id)
+{
+	struct iommu_viommu_set_vdev_id cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.vdev_id = vdev_id,
+	};
+
+	return ioctl(fd, IOMMU_VIOMMU_SET_VDEV_ID, &cmd);
+}
+
+#define test_cmd_viommu_set_vdev_id(viommu_id, idev_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_viommu_set_vdev_id(self->fd, viommu_id, \
+						  idev_id, vdev_id))
+#define test_err_viommu_set_vdev_id(_errno, viommu_id, idev_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                             \
+		     _test_cmd_viommu_set_vdev_id(self->fd, viommu_id,   \
+						  idev_id, vdev_id))
+
+static int _test_cmd_viommu_unset_vdev_id(int fd, __u32 viommu_id,
+					  __u32 idev_id, __u64 vdev_id)
+{
+	struct iommu_viommu_unset_vdev_id cmd = {
+		.size = sizeof(cmd),
+		.dev_id = idev_id,
+		.viommu_id = viommu_id,
+		.vdev_id = vdev_id,
+	};
+
+	return ioctl(fd, IOMMU_VIOMMU_UNSET_VDEV_ID, &cmd);
+}
+
+#define test_cmd_viommu_unset_vdev_id(viommu_id, idev_id, vdev_id)       \
+	ASSERT_EQ(0, _test_cmd_viommu_unset_vdev_id(self->fd, viommu_id, \
+						    idev_id, vdev_id))
+#define test_err_viommu_unset_vdev_id(_errno, viommu_id, idev_id, vdev_id) \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_viommu_unset_vdev_id(self->fd, viommu_id,   \
+						    idev_id, vdev_id))
-- 
2.43.0


