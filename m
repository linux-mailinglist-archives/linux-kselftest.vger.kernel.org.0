Return-Path: <linux-kselftest+bounces-16427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD239614E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF62B2306B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659161D1F7C;
	Tue, 27 Aug 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sz29/fmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FB1D1F52;
	Tue, 27 Aug 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778118; cv=fail; b=SOblZ7FZRHlEQyg/VmW+WA4TEn/XYKFCrCy2GdrAmkHlHQNClh1mZNmUnwLmknXcXGcdHKzPJ005QT2kvy+NiMnoRSrfVnvc/UQO8Zj93+o6HZxPdcdZVS/0TVVBEcW+DJ3P5pLQIl6DjxA5W6fQv5pqMHx47akJve/B4W++zYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778118; c=relaxed/simple;
	bh=Z4jS70XyEoAuTs+0WPyexU4K6XeOI78usmbDp82mmRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a892ziChXqHIAsi7ac2vDcoAqK+N6Dt2FQ3S86gLVVo/NcjKpB5bG2vq2ep1jHf4X9D3RWVi/0Ifx2MXun2ni7GNOn0k1sQdBFiA8Wh3SBxuUvd87DP/iyGtnJl6euX39BTQTd18+wnzJgluCRpg3Tld0hraariqERGyeWBj7Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sz29/fmy; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okgv18xMTvHnCRW1Y1lF+UnOwP8sGfKVLYcd82AZF2Bo8Lwb+iMxInuxa8OSh4LqvbMTuO5Wl0XHfgeusovC4tSukm12LTscNRAiw1Rsn/XC4jkK/Zhwck3o7oqv2jsHL6gjnT1iPtnChY27YAXWRJXf/gh4+G2MaQAsipgQ2zH9G/Jf6feUYQTFUBB2/Pw0aJKY2Cn3qNPNJdXNADQgwOh58cf/2qQGdAMAW9S3IwtIkxL4l61l7mrS/L2z++/01gD3Bm2ImKek4kay5OyXAoTItfd10MzZjRcYpXQ5lI4W/8n7QE+lrTXQiZjgdR4s5HXpHP+zxK45n63qc1OcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keydAWl6Opawj1kud6d+9V9Z+xy/wE0UwmYD8tJmmsc=;
 b=g1tHeE0uA7TI+h6z1VAQTyD65NsbfmX9XmxT1jP6q3eCsPe5TMAdLawBCSE3KBH9SIo+/hi56V4QgZAOe+m4uVCjoPTcU6R3PdrXvB02mH+Qu2UiInuxBziT4ontz+cpEVcMgWnsfcVSvixd2qzNvmToSQFWmIkPpCu+d4Ocf4v+glMLpjy4pe85G9fzA/ZRZEX8RR9MXk139+EJk1GN0eA/r9aYAzUsV7ztN62y4EKjDorUDT4hf6v2DjpLnD1tq23gtK4UApZgneRWnu5UcLDYGGtZSwhNkCmh/6fkkgFkxWNsosnzS7obYRS1LRymuC87QW12SkNMuRwklkka4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keydAWl6Opawj1kud6d+9V9Z+xy/wE0UwmYD8tJmmsc=;
 b=Sz29/fmyJOFb9sYFkW2hyYvZS8aMwmjHhh9n+X7GdlhDNmoD8Q+AbBH3Xnd0nsOSyioQHIcqf/9caJPzrPNV1WaUMDgSO4cr73SPWHibEA9O3kFq6D7iOX/hxvOOIUnp8konJWW5+PgrO09afpRa23IBz6vqtdR2CA0eLz5eQjUSFgKySshU3tghyJaVfJtObGTIP7nBFLcSVScCNFGARQgNzA5weXYvlZyxgXbJFlLgKG960djLJGMH8mXx7GD9ksx2LOPcK69F7EcQZbK6/BaDuAWTNa0V+IRtnPCvzAa43GZy62VSyM1FCnsgty8T8mcs2c8A8INFOuNbQnLoBQ==
Received: from PH8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:2cd::20)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:49 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::20) by PH8PR07CA0015.outlook.office365.com
 (2603:10b6:510:2cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Tue, 27 Aug 2024 17:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 27 Aug 2024 17:01:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 05/19] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Tue, 27 Aug 2024 09:59:42 -0700
Message-ID: <c2bbc7e85ed5eb2e88d6c87acd9c679b00641ab2.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: b86d6145-9f75-49c6-e149-08dcc6b9f0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOMEbk3Jpdis8N/t3MUwZoNBo09yw9vkZ9jT04MAkfFnWhutMqQC04QGc8OD?=
 =?us-ascii?Q?b2DnxGG91TM+ZBxZDwLgwDTvu5HEY9lC7fpT16kT9bjyc0cIhVBqqSm2QjOj?=
 =?us-ascii?Q?79aYj13Avp1uStxdd+8oS7oR8mXqMOW0HXQZyWymIdbkd1AcdzYMHMVkUrJg?=
 =?us-ascii?Q?+5oaKIE6FmNWgcu6vdRJ4Ji07R9cMny51X4I3CN4bZEsmNmNWIHMH9NnlFWy?=
 =?us-ascii?Q?j5wirx+FVCSwaiZd7h9UXPTo/RIIqrgV0nfxQK6xgQCp8Ge9UiRsrBoIy+8n?=
 =?us-ascii?Q?Xm5iFb7mFHHzF2nn7hyc6dU779pfLOAKfXTb6ffdugQZAwRJfq3/yeWpSqb9?=
 =?us-ascii?Q?Fst0FrEr139J6P/PPQFmS0ywj4SalvU9Pu+N+PTjojgHMKQ+u/JOudsq6trt?=
 =?us-ascii?Q?xdCwy+K4XowqjmwgyuPUVVzE0Mvt0w+E5zLE0EFcOcqjhtYPFImqjx2VIn62?=
 =?us-ascii?Q?MO6R5/hQDSs0PBHDRvhU2TAcaXna11x6Pn/Vc/akOasyYo9GwtC5a9sftgEp?=
 =?us-ascii?Q?t8syJNrkK++0ItX5oyAFvA0zrxAppr4GlJkkpY4WnkpfatBiIVzrS+E81ffZ?=
 =?us-ascii?Q?AEwECiP7aXr3msPFMzGFZlg8CPLhPU4+l0d4G3KX8w8a3juSKb6+Rxq8gtDc?=
 =?us-ascii?Q?gRY9rBqqA9Ky/j1zKAx7r1ZSl64o+RJHGMEX51RVe1IOonOD0ZBPyhGtypw9?=
 =?us-ascii?Q?C6XhTxDeTot3s6nMgSqLMVcfMH/7OkAMD/ZU1kB8/ND0tIvOtRCMo1ChCqsy?=
 =?us-ascii?Q?Zo7a7eOoz8g7+SC+wuAk6LEGAnMZv77u9vMbVH98qInB+tBLJW879XUvEQ0q?=
 =?us-ascii?Q?nZ7lJ9s502aUXe8PVwNASYAVi9uo1q9TLWeuFghI9zg4eS7auhkDrXfwkB3H?=
 =?us-ascii?Q?+PXKPMqYOJz4xkW4p0M9gCCkdgK78Tq7G/5P+LwA9NeZcVh8JXwaDKQQo8W+?=
 =?us-ascii?Q?Lb/pmcX5n+37AD1Zht92lPh62fEd0t4RV7BcF87HGKwBm0iTK84V1cvwW+3R?=
 =?us-ascii?Q?2vsgKgnfgjQ4io8XisvPhkT9ctmFDh+6UHmM2cponJehEIjPtliat1uyyRf5?=
 =?us-ascii?Q?Rtad4TI7JpRpPD+UTmCHO/iVlPc2xF9BZR0YN2pyhBFfcmm3/DMhwLaGDPBZ?=
 =?us-ascii?Q?PQFyWz7Ayz3woEG4HyYIIUc0xFYbu0OzS5iWx7jOCctDfQUsgpsHCEZARj3y?=
 =?us-ascii?Q?KF6LITtpbKNtfMPr7P7Xo1JEOOZdHvWc/LTmSJMOyjQGNJQnI9dJx+Y6tQV2?=
 =?us-ascii?Q?3ENahuulE1X+jCTdjijVuFkOlvTVtCtP0YDOJlcv37nHsy9QmVjbtyLqrXZp?=
 =?us-ascii?Q?cWxE6M515OJMVs67fk9jdU3B6twSZO/hYMw+YiEnWOp4eT7dmwhY+BuI4bSM?=
 =?us-ascii?Q?Pl4NAepiFSI5/xSTWfhF0MQfyqftztMOulSI6IRy5JhGpqJ1YDWikiLBY4Qi?=
 =?us-ascii?Q?oLb3K5JvhLV62wPK08TUiI/ioD3QkBR2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:48.8243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86d6145-9f75-49c6-e149-08dcc6b9f0b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

Use IOMMU_VIOMMU_TYPE_DEFAULT to cover the new IOMMU_VIOMMU_ALLOC ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 35 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6343f4053bd4..5c770e94f299 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -554,6 +554,41 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 	}
 }
 
+TEST_F(iommufd_ioas, viommu_default)
+{
+	uint32_t dev_id = self->device_id;
+	uint32_t viommu_id = 0;
+	uint32_t hwpt_id = 0;
+
+	if (dev_id) {
+		/* Negative test -- invalid hwpt */
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+
+		/* Negative test -- not a nested parent hwpt */
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id, 0, &hwpt_id);
+		test_err_viommu_alloc(EINVAL, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_ioctl_destroy(hwpt_id);
+
+		/* Allocate a nested parent HWP */
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &hwpt_id);
+		/* Negative test -- unsupported viommu type */
+		test_err_viommu_alloc(EOPNOTSUPP, dev_id, hwpt_id,
+				      0xdead, &viommu_id);
+		/* Allocate a default type of viommu */
+		test_cmd_viommu_alloc(dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+		test_ioctl_destroy(viommu_id);
+		test_ioctl_destroy(hwpt_id);
+	} else {
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id,
+				      IOMMU_VIOMMU_TYPE_DEFAULT, &viommu_id);
+	}
+}
+
 TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 40f6f14ce136..307d097db9dd 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -762,3 +762,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
 
 #define test_cmd_trigger_iopf(device_id, fault_fd) \
 	ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
+
+static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
+				  __u32 type, __u32 flags, __u32 *viommu_id)
+{
+	struct iommu_viommu_alloc cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.type = type,
+		.dev_id = device_id,
+		.hwpt_id = hwpt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (viommu_id)
+		*viommu_id = cmd.out_viommu_id;
+	return 0;
+}
+
+#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
+					    type, 0, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id,   \
+						    hwpt_id, type, 0,      \
+						    viommu_id))
-- 
2.43.0


