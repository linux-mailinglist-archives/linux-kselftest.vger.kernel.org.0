Return-Path: <linux-kselftest+bounces-20743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBD9B1392
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E92D1F23763
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623421E607;
	Fri, 25 Oct 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NWAfM/hQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA621C2CC;
	Fri, 25 Oct 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900274; cv=fail; b=u6sOx3l/yPukoveqbotDan9umEMKfk5VII2KWeA/KLAYQ5oPJFmwGoTXarpzqFA/qmvffHNxQCKOYJVYtlygD3y0ioQp/80G4hAbwDkoqCcAjMqKOaKY/uRWYWNFWTgATYrmxnCASlu2STjxY9hGWkSCWjSnjkh1YCf5Xs5AU7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900274; c=relaxed/simple;
	bh=T+C0rUgAM9mbD6ZhnLQA5x4Dn9VRPK5ibas/YkbfQxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsAQZPXq5S20/zwPww08E6miBEXbx5oPjAxE4hRbv7tRoyYf+YQKcIPOOR/O0+uPx0S1iSzWHYmwzuVzUgRObOiB7rtWnxV3AS9zR3RslOCcFXKErjI3aVmOxYMA1hr/eLwN+VOh1pwFyKPA2sUuOgvjfukq3bnCD6R5GIAv7CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NWAfM/hQ; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S93ehYv1fzP+oGzq+vZoFErv15Z3liSuHaDWS6lfekVTJwia4TMvKd0ReG6goIuxT7H76ywK/GxVkMoU2NXTHzMWz+VqMYQnq8kvs1lU8XWLs078U8cEOPJFNnlrTMOh1QJ1PGRIcZrANXQFk02Q4tFQgtwBmkgcE2a+0zSgni/hORSqPBXN6kjmrxq7dPgq5AGu6gRpyzI3NySvwSoxLmArnXnr2b57/+6AVubhB3+6PGopEwL9OD2NLmSjJOMlCtxfXX+GI1B4C8WHjYrv/t64prIhNrthMiLYD5kllJTaRyVpy+z7FmqG5nvjUQnF2+CBOt/5sXFrrvy4ejFQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOFjVVxa+45dNXcuwjARBQP7UbO9XNA94R1VE5QaRAY=;
 b=FCbf2hOyv9GY+nzcTEoFW0xYXfhsDmPKvz54v/ScqIomBlOb/bCZXKpO8ISdSSjGUMF7tiwXjAIMdFvGjAjFtJZzVuYR3y6afVpscoaXFPbg9KeNKBvU1YnFP5ptuLhorXCfVIw9DGL/6Ze3QCeSEU/vAz+uIFnUCojwI6PcpwicVMgxY81MEmb54SWwp2+IoufduCd+A6quyt2kwoDw8oLBZo7IFh0ni9OCD42bAnpxCVI59LHBXtsZ6PHIKarmOnjsBU1VjGs0JR0XUS+cIZRW1NgydgjzcaQ/hsJ4gECE0vmV9EdHsj371jUsEOT0UdS1MoH55fyu4XPudJrQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOFjVVxa+45dNXcuwjARBQP7UbO9XNA94R1VE5QaRAY=;
 b=NWAfM/hQHExvleTnfxEMtqrD4gGyUWHmmP2jcjK+lhsZkxuKuHVhDA4VBApZYh1wj6w7KmICi/6NcqXJhE2pwMbDAb9j18D0TwU86sLhfevG3654bUNNa8yieg6PDuSB5Ku5WoV7kVCLS+Y3OqrWPd01aucyId2wq2YWNrc12/cQe0UexpGRDIItbNvdzdfbJd72FBT5tEL/J7Il0NGPWoZ7pwlOKFeHHPf8b0EWYUM2P9uZemdxaaELcP3Q/6bpjZWKmh6ynMU8bvFDfGrgD5PbwIWpZSkX7ij0qDk1qUg8P2DGgtyoYXX1wN9V9McDu0NiwB/ZlKlFdFDaL54tYA==
Received: from BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 23:51:08 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::34) by BY5PR03CA0003.outlook.office365.com
 (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:51:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:51:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:59 -0700
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
Subject: [PATCH v5 09/13] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Date: Fri, 25 Oct 2024 16:50:38 -0700
Message-ID: <6e578f2cb32141a676a6cb82c04506662d1a1254.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1ee68f-5666-41ce-6502-08dcf54fe56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/74Pei6FsX/XgheJpK919geN4OS6NKbsiSzQGwDVRXLpLD10JB8Ths0KIfCK?=
 =?us-ascii?Q?37/vXsuUeYyY2W4H80cTiOwnBw3ly9O7m5hbr/cu/Uu/RgzUTcaAUQF99vSM?=
 =?us-ascii?Q?JQyWDncQ72QibQQvbgU+XYcxoRVLR8h5SPDl47f4zPaEfYwcy/CVHhp9kSa6?=
 =?us-ascii?Q?rgMwCuO7xyQHuJ2ZB8sMYsWZ1msWhELcaMrklsFYboUCs6Y+ctSPM6bk3t67?=
 =?us-ascii?Q?/tRzvMZk8jDlXdluLdp7skaNzbrTVRBKiO/c4W6L+9vJ2BvYMdEntlwh/QM8?=
 =?us-ascii?Q?BIlo9qIyYh9sCy6tqoOAmYq5vV1ul5HiRw2jxWP9sU0lw1S4zn1i6I5T5yw7?=
 =?us-ascii?Q?c3BaELWmsq3VVct1IPLuzaqOOQVKWIg8m0fSRHB92B5TCnmZv9f9J8f/p15i?=
 =?us-ascii?Q?WxQASUV2LaNvODSnyhSeCfhi4h8S2AfW3hkBPAdyiYAK86ETdu4Kapg5Jslf?=
 =?us-ascii?Q?M+oD9DoZuGLqna2fOhh0v2ZALAnhYE0uxAmZroo230Zgx1yqDcMEFC2JLFlx?=
 =?us-ascii?Q?bRzMy09Ov+I9fthloT/e6YZ9QV3dourIVfN4XzythCNMnpX4Cfx9JL5dNYpA?=
 =?us-ascii?Q?LUVSknrETZF29FNxWC1dRTcQNLzoFjX4rEWZVDNtnvVgj8z7vmZrQ0pG92eO?=
 =?us-ascii?Q?YpOUTaLq/oRmVj22SvRCbj4qInYz20O5wPDUXHE1k5q+Wg1e/s9DqJeYCRK7?=
 =?us-ascii?Q?c4FPrWrSVs7GoTELuiRZtqehzRtYCLEpmNXijrwq2MFWPEFHZ00ahpE8asQg?=
 =?us-ascii?Q?4BTBujbB7yUEWnuynNCWDi/8pTZ0d6GghZHOtQdy9wpcAouB5Bn0RmDyM56W?=
 =?us-ascii?Q?2cFWXo7MpZ8MrqlmZSQ85av7MCiGLAb96qPeHaBXrdQeDgBC3+P1Hu8R4qA/?=
 =?us-ascii?Q?sNNeSxq79uo2SN51ocuW9gst1VvdxlrThGIxSzyqO3J6rBSp/huZVGlr5YHA?=
 =?us-ascii?Q?ybk1sNXPc+yur7NRHNK7AKWrIL34uUlZOUTvC5OF8KVc6l1Rn+dm6OTYJvda?=
 =?us-ascii?Q?9hKkrULvl5PhdDYK7tGVEoWAiFjZGz4rrRVPYoczs2lSoNIANyfh9w1WNVDU?=
 =?us-ascii?Q?njXp+I3ItOBy+YLCrcLXvm3JGcuGJSkK2gIIiu2JRB+kQh54anxOCzNtu4sR?=
 =?us-ascii?Q?cu6A9ian1zkkJeuC4HbcBLLUxiPR6SnMhWN+gcED3o58J337oA2YuRKD2d6c?=
 =?us-ascii?Q?tK0uQvjSkXaoBK1pKo7do91fAhQocqFb9dXH/IpwxmOjjfjWwvB3H+OuR1cz?=
 =?us-ascii?Q?B6wPCvXL3+4Jjtge1oItbAuEkwa53J703JWROR81xvde7ucUvzQ7hAK1eD+e?=
 =?us-ascii?Q?MOBICyuYgpbwUdc5wUSlQ/wWL8ocsWwQphQISKskLubG9GQgU0mbXFEoGtRX?=
 =?us-ascii?Q?p5poU5eIDN2PREB6WBhtVk7nZMJSVxsVBqG0j8aM9xbfmSEGxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:07.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1ee68f-5666-41ce-6502-08dcf54fe56f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

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
index 01556854f2f2..7bb47b4a6d63 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1122,6 +1122,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
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
@@ -1631,6 +1649,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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
index 44fbc7e5aa2e..ff0181e5db48 100644
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


