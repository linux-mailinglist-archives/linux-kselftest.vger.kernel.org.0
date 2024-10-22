Return-Path: <linux-kselftest+bounces-20358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C99A94D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BD1C231CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C761FF7DA;
	Tue, 22 Oct 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGxCwA2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9321FF7B8;
	Tue, 22 Oct 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556466; cv=fail; b=u+vfZBXg4BL75v5VZnm3ULbQcTCdhVxUwDD0bxBIcdyjRaNocdaHuGeIxMsPnYBZvxTdZbgJCt98dF7YbKj+v/7qriJhHUzC3T9+5dutlZqkqKvGPpAiMwzNgwE7y6vcvrhcQj43ipOYvloCIONbxbrgYtpGz6y63wVWX2VrmTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556466; c=relaxed/simple;
	bh=0GzycCaDAkC5UbdtN+gm7gfKFgo+YgG6iYpneVO0xVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjJpLiTue7mEq3Vx0zzO93kvhCGBwEH31Eyfqr5y/Dk6gNc1wCF3tOxCa2Dy4y8YXzyMeHeXH9euP7EL8td39XB9mr0UbcBFs2WD5H8I4Pd6x/eeqp/3gxQvO1gk0GZ+fQz45ZOtGcNLj+TGdJcsqqPCvI0OvJ2Ehq9rKydwO/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGxCwA2W; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8RqXl5HfhB/KvAg45TdW0KvufodS0BLQHS/gW+a4jkbrOtNY1gv7KzGsVYFLuflpUsv3YM0bvxTWVm+MzYnQHNuqClaEa6e6peK+SS7GqlhBfarfTsA9oey5GF/tKeq+0JgynHWbwz6h8y/mOQCxmBZCmLmS8rPwUhK5j/lZuYYDKXyZ+IOK9M4j5awc6FKB5dx1ipvSAlCEjyHJF/KK1N7maqipTbj/Glv2YnVznMTvf9RkiWVfBpKPjgizLQZC0ldhlA/CC7x2SBsqUSwi8K+sRNzkr70PjemL66BphDkEGZ6B5RQrNmRtrnapzCCXSYGoLl7f5CKrEcTvkWmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJE+DAkdk9h6my36uUEdbBG8OQFxfETs6lFxjFJiNLk=;
 b=jaUFk4JEroGQgvdPBsx3g3U04IaU7oY1CyUXZB1ZZ/DpSDwBG0ROaEBhkQjADk1gzUY0S4QCVn7PiuhLL6h0IpcggydH4zIDp4sdyvBjU+hcRUAnDQQPGdbvfgbJ8KU1Fnv/QIxIko0IMWfYEYJ2u0GG9KhxF0psKEmq5/sDErV3O4MydvmqzFAKSRUcHy9K4QXBcQ312THHZ3ZhYUJmesXgx3lsGYKHaq1fE22QjgSJ5RjxWjsJJAq1DgRiolgQO12axe0Nlf0MDsSZ8kgRVM6atreVFVmy0kFXZs4RaHPK9sMFkZz3zNYTh3x59304I36Spfu2Ru3j8VmnJx32rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJE+DAkdk9h6my36uUEdbBG8OQFxfETs6lFxjFJiNLk=;
 b=OGxCwA2Wm+rHGWkNRS43Q3bn28FPfsZMD3KmK2YEqG1qhLv97EIaaZJw7QRiUSJFCf8iKMLQxhXV7qDr0QGTB8ym5HJi9kmzByRveoE1guvhacES5Q7EuevOHU6Jfa5X+3zVBruE4ZbIXiRC2dCf82LpcvxHtAniRBu2mwENha8Y6gq0yuSmJIbiiLNj2jEzflKYvq2zxXu8N94MUukKfF05zlCIqpni13YxHm2I3VcQ/AOKejiEAxzKA8AtY4O5UVaZCExkKPGLVLopC5suCXHS4Ir1oNccJaqMTNX1xfthNVwOZHKdtH0AIDpWa9W6pxEpMb+5Ca4xFj77LoGUtA==
Received: from BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::12)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:21:00 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ea) by BL1P222CA0007.outlook.office365.com
 (2603:10b6:208:2c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:21:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 10/14] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Mon, 21 Oct 2024 17:20:19 -0700
Message-ID: <2e3c050eb9a7dc2a9c06151963959de80144c832.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c93dda1-6e52-4f36-1a3a-08dcf22f6819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tSBQvDonu3YsKOJRmDFhclsQUGEesoqShfZ8jEPDhIIugnqgAYJlCmP5HZ1?=
 =?us-ascii?Q?IZ5+1aSihCtDHNp8YOOkq8mYMBZ0ceVhY0fkEWesZFx7FhKDuG3Y6ag0vkJm?=
 =?us-ascii?Q?CfsMrwtDwGb0t5Ad6gL07FJAxhauY6ZDvCre28w9gPYtyV+nKXjlWBYoiQ3Q?=
 =?us-ascii?Q?MIoQERD3QFdt0EJt64ta8XLNWsy+nbNKb4u7axEJ06DkYp/jwe8YAQaJf4BG?=
 =?us-ascii?Q?MawmSy0Xxl7/7hYb7jP0nYMNEqOBQ6agr2hsgI6ZlyxsGEGR8SHfJ3e8UnE1?=
 =?us-ascii?Q?MJOacyY50N+QTDV2nExTqUtWJ2aKRF+B3tA9M/+aTHZCtPQHZFeZj4pclZhO?=
 =?us-ascii?Q?VOVPhtAeQABrqw5u1/hWeci8S3WYwhTcpWDCPS3XJoPD+gjCOd99jprLcrB+?=
 =?us-ascii?Q?2w53S+rlWbUNHkz0qNAPhJOoBaeJO34/+WeK2qnO5oTKWq2XZZkRyrd/cCS/?=
 =?us-ascii?Q?VmrKGHl0GkwqtDggakMHgqbAeNL03K3Acgo2z/xyHSB6smiRpXqLA0VTwkYE?=
 =?us-ascii?Q?E1+jAzL9Hrc5GNs2LlxLcwHSuFM9WQ2IeErOqQcu9KRe+7Q7EVxZVgeb5E16?=
 =?us-ascii?Q?ZrLXGH7skJXdAeNvA1KNT0eaxJYJJGPIykAM3TCqhfB2BvPgsilAR7DstyIB?=
 =?us-ascii?Q?lyY9SW8Q49IJbYHeCuYtDQRolttzbF7sEsffC8c1a7ryVtrzbS8H6tjwhgUp?=
 =?us-ascii?Q?Wdily7M688KXu14rhvKdgdojoIWMAZ8CAbeQ/j9AXeO/cAWLpsaoKcxigmu1?=
 =?us-ascii?Q?Vle5S5HTSlRTTs8mmImQE9hEh0VpuMcxhp5u/1glSNGpUCuYIR1TmxzwmF/X?=
 =?us-ascii?Q?xkJOQs5hfnsFFRziKt0tcWtAT0XiiTRfztFZt+5X+Xo6zAoGtyXnFBGXBFNf?=
 =?us-ascii?Q?7IEC5T3hfDtgUx/OkXZfCe7YRACwdEwuICRT8xrUQkcB9gVtk1nhMHy6ep42?=
 =?us-ascii?Q?MBqDoFxWihil5Fjh7oYM3S/v2ujeJAntbSlGBpzRNWaEG1nIVjhrJEiXlt27?=
 =?us-ascii?Q?JJ6C3A1lSKYTb1WD/jvnvD9p+gDOzMozkZHzdtcWDLrDumM5ObdjAUEGvIvP?=
 =?us-ascii?Q?vGxpQIIdVTTYLCJf850vqPA7QNpe0LmX1Nyx01dhOQdLffBexArvZsqMZ2jM?=
 =?us-ascii?Q?ggaAf8SZ91cGjxprWMDnGTvHPT9rIWoWJOXspomz+2Y+XyY1ys7bgMsou0Ar?=
 =?us-ascii?Q?mVHZlWVoCdG9KFdhc5EHlT/RTLQ4mZM9zOHxeiecWeZTAmMu1KxfV8ka9ps/?=
 =?us-ascii?Q?TLksAzRqrjQr1YC9ecDsgp+GeFgy3tO9cmDFOi9at0wSeZerrCACmuNs2x/Z?=
 =?us-ascii?Q?ewKRwb5zffQgxFfn/wDanRT8KiwQ9qChWGSC7EVzFePeBKZLiMe/KRQmz6FD?=
 =?us-ascii?Q?oXSl3KuC+RPqrzQoGwkCjAjOPadn1K02X/WtY5n2BJt6BZnjKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:21:00.1596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c93dda1-6e52-4f36-1a3a-08dcf22f6819
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 22 +++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  7 +++++-
 4 files changed, 57 insertions(+), 1 deletion(-)

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
index 5b17d7b2ac5c..3ae6cb5eed7d 100644
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
index 11e0c81c77c4..6f524cea045f 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1096,6 +1096,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
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
@@ -1605,6 +1623,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index e09dba3588ee..79b0739d586b 100644
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


