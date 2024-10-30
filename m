Return-Path: <linux-kselftest+bounces-21183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3F9B6F6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361A21C22814
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382522CC7E;
	Wed, 30 Oct 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A4zcQ7Kd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E522ADEB;
	Wed, 30 Oct 2024 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324180; cv=fail; b=joR32ljpBzJCeg3kBmsf3M7cMW9SysBesu52wYoXV5zi2kcJsZmyTICfeAAdf/2Dp+grITP5c7XpTDRm784kQ9ah5psDMAuVRVAlOGceCl+uCRVd6FHYW6wolTYeguKVZ4SpcGEBfOhLzDtARAbMM4uzbsNltdI12UyIkKTB7QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324180; c=relaxed/simple;
	bh=8O01cPLBRqP1FopRN1a9N8b2GacFkqX+yaPryEGe2L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRFBj9sGAnUoKB9wUwhKuGTgPX9294ZEcx8/02g05FmXASFfzPBlIR4Dk2c++A7BcG+yCglxLU9p08YD9fL5pVb4v9hrhxjCGW1t37K09kWHUI8tvGKk2fh5yzWfF93Gc/Ab5jBnj2kN7oMEqYOOshLdAsnZOV9SRl3YK8I9p2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A4zcQ7Kd; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQLB1RRGJccnil43H+DkXbZDhztFqY1EEprI1uI2OX6Kov71lqqPuELOYIF821vQrzNy43A3rDT7irIFmkf5miy50MtEHUVXuOpR4lpD8V6+gS2jbpnVz3giWnQil8wiHG4OZsfpuLGpuAZ90gQr42D9mKQJea8qas65nON5+LMJiAVOHb62brJ8azfTbfXVdxAexi5Cpsu7AQSLpOaqqpn6NOXZrUP9hzR2xXRr2kJUm9IHHh+UwIkLVDPKAOM7TetA+VkQUWy/xP+xDMN+63XAtpJSBUlRKtEWCMQqmI8vjYeD7usd87L8DDlsenwS74KrQsFTsS8epYgbsxKcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0GdTRVgRkSVL7Bru7xOttqpEPyTCdSUtYr7KcpreHQ=;
 b=OEDNANHQ+iGQgSicZq28ZL6sSo2ihTz9SKq65Z+8L3YjMHV1jABZY8lfVW3v2EQ/ygJ54ThYBGwdQpePmZmiFR82vVnt5TQZacWFFngfqdylgs5VAC/euQ+kHha9COXqlckzjLjctFQWiHAooHkcfD3JNq4phuSXf3yxTkqJ3rahIpluzD7l1C2RMt5ooq0HfhaEyHvlDxg/t1dh39ylBNgIcQ8Efvs6IFDrkFSVKLgm6pGMfhScc4v7Av1YRQ7OWKEBYQrwPgkIu+6iQZ0KnBpLIhi9lwlJK74fNLMgfbD9ypOMqByHQoZ77T+hTBH5DICPOVU59Z5bRhGY7deURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0GdTRVgRkSVL7Bru7xOttqpEPyTCdSUtYr7KcpreHQ=;
 b=A4zcQ7Kd3d+GkW+iNyMsPCwSyfElcAM68KXKj5BdU4tMAYybl2G5MA3FcMLx0vjYimfkYCMjP6Pk4nBTLG1uizHYVSAR5v67lQ+LEfQxzA1YcUaVHaBe8iRvMy2yN5TQ6ZICp5MC+VUpgzg8uA09/VRzuHH5Lgwmbifdd69iBKR00C8DKs0i9dVRPUxRog2TIziD+WIycHbkMhZIESk7hDJwdDV8VlEHo3pqsZVhmlnlYXWcsLZESAs531R/xY7uVY9nXJGysZ5tT0FVVLWyJrPnWbBIv8CI9UGwhI5ILqygF/qwxDPcPMRlH2TST4hmk6f05AdJE5ICyjmlI2IPsA==
Received: from BN9PR03CA0485.namprd03.prod.outlook.com (2603:10b6:408:130::10)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 21:36:13 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::53) by BN9PR03CA0485.outlook.office365.com
 (2603:10b6:408:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:51 -0700
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
Subject: [PATCH v6 08/10] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Wed, 30 Oct 2024 14:35:34 -0700
Message-ID: <0f24485cbaa1b17335b8a785509c8a14c6f5989d.1730313494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313494.git.nicolinc@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: aff738ce-bb8b-48ce-7ce3-08dcf92ae0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X20RJ4JOte++v4jJmnXY2JYtUc/oI1oDdnmGzrkFaha9qznyabThFXzQ1ECU?=
 =?us-ascii?Q?tdzMBuRYZkGd240lmMQ2xZfDJrXF5URAOoSfzFKSVDja5Yz2IbtReDYEuPPC?=
 =?us-ascii?Q?eQMhOke9E6u+FukR3YR/vbgrWMtj5JRAQgNmQMX8XK+7DBfiO7nHR+aY5F1K?=
 =?us-ascii?Q?VYOsmCrUfhrx0f1qlYfbN6+YFtoS1+XygAl5gpZITjYB0+olB/6mVSqavOjA?=
 =?us-ascii?Q?jAsu/Fh+rezmTwx/crMZz+9ShYbgT+SZrCRM7hGh6hLDS337+qNRxLoxrSgG?=
 =?us-ascii?Q?Rl6Vc/7YjwhBVzPVLyULydBACwX02vkPa0eeyjrmqKH+/UfxvelmkbYqalGt?=
 =?us-ascii?Q?sXcs1Yiy6TtPwfhd4xHRc5tzt9RLogs2Y3fkAhObP9hw+vHC/ehQnrNbF5+c?=
 =?us-ascii?Q?jewg4Gq2kmZFYLF/F2O+BAlme1nzch80yIHdVHBGAr4N7w5SwrF+IuFJWWVm?=
 =?us-ascii?Q?p75c6UQCZHsrjaYvvJKlAxMFPfdMzVQEdwrbCeNjJeq2V6wjVm/r0bPspn1Q?=
 =?us-ascii?Q?mVoat0Z4DWhZnTi8UV5gd+oKK7sAvBWZI0vwtXhAOK8fUgRp+L+Td7mG7J3y?=
 =?us-ascii?Q?J42smCzAJsnlx7GZO4THHMz4jk5KGEUzPL7c4WwBLm0oLvJ1uASmRF2yt2Ql?=
 =?us-ascii?Q?3UnhrYgPrEOPpGc2CXfryOVFKcMy/MvqrydN2O56UxSChNniFqf9vO13/ccs?=
 =?us-ascii?Q?Pf0AkrdZf0q9l/MSTlRuHLrLPvlhiC+LmYfNYWEkhZIDKW80Ita3qSAAWHtF?=
 =?us-ascii?Q?Kav7VKGeKfJ+HUA9gnizQFEaRYEAc01oWPdg6DuauNcZMjGDdNtJEPfzD+hQ?=
 =?us-ascii?Q?lurfFJDEfHo/YoJC7kIXAo26TzqRs8I4cNuLxR+COyquas4z4rwa+XB03TGr?=
 =?us-ascii?Q?00/LV7C5pXwM1/z00ZahKJUifmyJbDKE3vdUUzCEtztmTwBacGIaJHyVdKdY?=
 =?us-ascii?Q?Q+PEOWQyVQIRx4crDi+bakgLkjRp4dEPKOSQ5Y+6R0C8gmEDIuxznjh19MiL?=
 =?us-ascii?Q?rlb/nCjWiUNVkmAyLaamCXjXbOLQrbbNaMnRl3jvDNO8tBluY3ZBcb/2HH5o?=
 =?us-ascii?Q?dgFf0s97T5tP2ylBhEMJy14i3gOxwX3J/GkOD/Ka+AG5f0Iaku4wd4495vxQ?=
 =?us-ascii?Q?m4vTbaykOdSt5aMsxTOseqNOTL2T95c7bT1PHDjLW1n+Gay/PLofFnQ8hrom?=
 =?us-ascii?Q?+SWpehhwnBjUdw853TBbmx6qS3RKGY/7/DD7VHFQpMy4p7QC63EmJ5GUR1pM?=
 =?us-ascii?Q?r0cZnHCCBXcHU6KmBxpe/A4pWYqhab7R7atUnxZxdPY/CTqDLjnY+zlm6rTD?=
 =?us-ascii?Q?lGZXa/VpbuSCPuriJLjo3+IAHM9Kn7fdTdKo2ig4P3tG1PTf1gAcU0Zabz1q?=
 =?us-ascii?Q?bxPUr26kx4Akd00Dgx7J8o6t6kjO0eRaBXObbwc0HDwzNNSSFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:13.4946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff738ce-bb8b-48ce-7ce3-08dcf92ae0e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index c47ad6502efc..54f3b81e5479 100644
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


