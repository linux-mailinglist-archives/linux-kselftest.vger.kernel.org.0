Return-Path: <linux-kselftest+bounces-33276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1218ABAD75
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD217CAA1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736022D9E2;
	Sun, 18 May 2025 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJGz8QEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD8227B81;
	Sun, 18 May 2025 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538575; cv=fail; b=tiCrc/6EGzEznj6iWUOh20OH0SJXxtqnYkVWwCCQJzinhmpu2bmLoXasivhJEqF9KZx7V0HYT1DtF8GdChzwgvhX8IiEBmF/vWR031/pPfxVWX9R2+dXIEnkFPLoKcPTwcFGWsrkIh7r8o1WQIgVTEbNrrBOaVVhr5AquqkiATM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538575; c=relaxed/simple;
	bh=/eLEIfzQDpxfKFMh8bpe7TsO8Hvxd8uZkJqeBqNcaWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1nK4jqyDHwQSRDLB1BhMi4Orf1TMSlEsYA5kdYf6UZ1ea+ivE8ftZ9zy4QIvaNXELmSKdX/rAnnA3HiTk9ZuXiz083S2V0KTS/Q+wnFP6q+jaTtRrQkkIWM1kvnvMFiK43xc3V7rNn2pqylyeDrvRxHGGzvHEiEESb/w0y0DcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJGz8QEL; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOG+g1q8pi3EFMx5ANnpuwFSe/zQdfaPkkBRH1txcisVuJVsS5WB6z3QTKNKtVsEKXzKtBnrgRfimmslFXWY+olPo425KSXOdcPyl+9hZaxF5IGcDt9EsqXcjgE+sW144Nkm3oYiMm2olOFbBCBHtokIx10b1u1mkC9cGPzJ92oGBiUcJ3Pbzec+EC/QxWH6uBoaC1vwOsFE0sDpuiAdBzxx4UH38rzOXqUJ8Zd9desGdcs32ckI4j+ipc/2BpmnNIv42xM/qEIUnf1vhkXjFXe839Ez38m4ZyyuxYY/6b829E4LedzszO088UbQ4Tg76J5n1Bw0FHAKsqPpbTUjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4HojS49TgLrFyjn+pm6N47+T5bs5nD8oqRSAI25hXE=;
 b=gIQrQwbytmg0hwnnuc8rSi6AB4WxOwMMO/2rBtOVOCNXqQft1Hqb/9a4HJa2PZ9oqXBRqW2BZr4CiT3V9DrI+q/0A13EIKD5g0DFo0eLWavnYAdleyQz2/htdfxxgdJJ3CYUtOGhwvApqi7OICarh0ItZV/WiXq3DeXfC6YYE5wQi2H+P50gtEFPvqi/YcizMd1nnWOffmxtL7P0cvysUF7vJbatiJ5uCO3rAfuT2Y36kSY8RQ4RtbF/Upgc425uO7NdXF8pmjWx8ueoKS9qlzT48t06Z6GTOlCQ26G2wDPAZPCfSBqIMDIgbbh9IYNqOUs8Y++jDCVxxHALhtSJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4HojS49TgLrFyjn+pm6N47+T5bs5nD8oqRSAI25hXE=;
 b=CJGz8QEL9xPHTcwRvgAfb+SvPQBDx299SgoyziBvLscMXLlicGIS0c9CQqcn4znxxPfLAhL/xtd8LVbjgaoSAtpwHWprr7eJWhTqw2SVA5fhh9H458skx+ji20lDaAI6y+plHEnhmwQXcIIJ9EBQ3a6ANyxuCq0sl8nmab/uULy/Az3Y6yGXfnVzOW3B3mqQAu2p+z/ImFMJcv0PV1Czd3QQRbU8lISRgOTiCapG72Fx41VGYkGVE0wsspChDn3JXkpysuecOCf4G9fiCgkoNkxzweAmDmehtvKBKGJzuYp/V+n7566OIyMXNm6FTqo7hrWU0EsVLojl+GbdHheyNw==
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 03:22:47 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::a8) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.25 via Frontend Transport; Sun,
 18 May 2025 03:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v5 22/29] iommufd/selftest: Update hw_info coverage for an input data_type
Date: Sat, 17 May 2025 20:21:39 -0700
Message-ID: <523aaea4faf9b91a54aeaecdb721c68ea3a675c3.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 155f0b52-f0b6-49fb-9061-08dd95bb42f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nzXGQw9JH+Tf+W2pC0I31M33UpmHCG4/1AYtnR3nftNc0HjPQ4dfNMjcjF2?=
 =?us-ascii?Q?dBJa30Lr/hp9ymQwvp1Vd1esPyoAwu2PLhS5bPLx51HUfwrWakwEwgjSq4JR?=
 =?us-ascii?Q?OPuV1BY90uT6fLh/TMYXncZGhY/ZwLaqhNZOKyDySQ6NgLe8BrGCGLLjhOfz?=
 =?us-ascii?Q?9hlEfZ5OFlxrdR0SO28ycClRdCRCa+BBxtF7PTLe3jWGbjsK7cihiXIn8XR7?=
 =?us-ascii?Q?A6HFcG1ForpGkYp2iVT76HWu+tdmxjuKh6i1G6LK+dGSj9TOnXm9XHE+IGi8?=
 =?us-ascii?Q?aXz0bZOTRfb5O524le0B3+XZk6W5cpOXaxQY3DZh+VXKzyPsviMSVhG48K4a?=
 =?us-ascii?Q?k9Rj8M7Y0uERIuuVbgIbs6qnjyBmdCqR4tYT9N48gYpy9bK2fq4s10+/i94y?=
 =?us-ascii?Q?2rkQPTkhhfJls6LWTX+KG1x8wM+h+qEebCtRlO0vuTYscx1N9vtnbLmsag1b?=
 =?us-ascii?Q?JfqX25+lkrxC3Go+KFGM6ldT2Tj432IIVPcTHrc9m1EO1np31ZEwqozhXeWb?=
 =?us-ascii?Q?CGIB94iMyAsnasPQgvEnLx7jAtgL2+LhyaDamfDccMYnQbTh3Hm8jE1yCSVc?=
 =?us-ascii?Q?G559mGL7ulXlK8yu3i6AY6Qohw6Py2+e3xMPYVeL6jn8UAYHMt7LZIu0hd5T?=
 =?us-ascii?Q?s3NDd6z3pBJh66HOkGnaWVz6uUbz2y7xAyrmBWdeB+1uU8Q4lgAe0fAQ9rgl?=
 =?us-ascii?Q?BOgw3WRDmvOXsQrtOBA3jffT9ss8ZFZnI2HArTnhwVe2WVx/TcZYotf7qQeX?=
 =?us-ascii?Q?ynObSMPOCCHc+Ju5y/e4NusWbwTj0xy05U7NFAdenOBszBj675qOYHHG52Rp?=
 =?us-ascii?Q?9D1cGn09VA6WvSPoSdBN9iYCCNoMy2jq+72/l+n1/Gnk2AriNnVi3jUf64S8?=
 =?us-ascii?Q?6EGCp6Bjt273g1gwHt4O7NN6nB+zVI5ChIIiRmCQ8vhmpo8sBfxHTFhGun7J?=
 =?us-ascii?Q?pWMNC18YArHPCa9hAvvB5BhWGb2FQBV1TUR5w6aGEneyc2YHiIKoPXVjtK/8?=
 =?us-ascii?Q?LSdLpZLUgDf/IlQn1YL7X0D45aPjoaKWMTMUvObKC40dsUYWSb2xAoVszOiL?=
 =?us-ascii?Q?HvXf2dnOvizFmAM4aCIAT8QdA1ywIhcOeVIib9pKzkFVj0CThI6SrCVzrX73?=
 =?us-ascii?Q?3P06gU05AAMyHjxZMbFGsUYCUWX4a02A0pnT04J7dJo/1heue+h6CJo7qD1w?=
 =?us-ascii?Q?HkFFX65giyxdwPldITwu1ymO2n03dACJYp62hqpp9DAmFVRswTZyY5F/5b4U?=
 =?us-ascii?Q?B4GEN+nJmum6uT9SKKTGZmWnnCN30ZX20CqAE6YVNfJsFiaHW1Jj2s+QcJa8?=
 =?us-ascii?Q?PJ++NzAP5rlQ/rixrXJQvoBQTGN1xcH19yiAY/ubT6mY0dHhJdJ/ZmiqsJvt?=
 =?us-ascii?Q?p49wfDJbjMtdPNAJc926bTsyEh8pOmsoEBve459Cg8BYaToG0tCu5kN3ubAE?=
 =?us-ascii?Q?lvbvYhTp1P/IEAWvT5w0K42nRVaEvIYHagU81cPeWU0Jxj6U39/Hr98y0YNE?=
 =?us-ascii?Q?bjcbIazMWSRR9vBU+xw0MQB9OjR4ykcCFcMR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:47.0125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155f0b52-f0b6-49fb-9061-08dd95bb42f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161

Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
add a negative test for an unsupported type.

Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
is complaining.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 35 +++++++++++--------
 tools/testing/selftests/iommu/iommufd.c       | 32 ++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +--
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 4a1b2bade018..399d0dd18daf 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -761,25 +761,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 #endif
 
 /* @data can be NULL */
-static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
-				 size_t data_len, uint32_t *capabilities,
-				 uint8_t *max_pasid)
+static int _test_cmd_get_hw_info(int fd, __u32 device_id, __u32 data_type,
+				 void *data, size_t data_len,
+				 uint32_t *capabilities, uint8_t *max_pasid)
 {
 	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
 		.size = sizeof(cmd),
 		.dev_id = device_id,
 		.data_len = data_len,
+		.data_type = data_type,
 		.data_uptr = (uint64_t)data,
 		.out_capabilities = 0,
 	};
 	int ret;
 
+	if (data_type != IOMMU_HW_INFO_TYPE_DEFAULT)
+		cmd.flags |= IOMMU_HW_INFO_FLAG_INPUT_TYPE;
+
 	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
 	if (ret)
 		return ret;
 
-	assert(cmd.out_data_type == IOMMU_HW_INFO_TYPE_SELFTEST);
+	assert(cmd.data_type == IOMMU_HW_INFO_TYPE_SELFTEST);
 
 	/*
 	 * The struct iommu_test_hw_info should be the one defined
@@ -817,20 +821,23 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 	return 0;
 }
 
-#define test_cmd_get_hw_info(device_id, data, data_len)               \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, data, \
-					   data_len, NULL, NULL))
+#define test_cmd_get_hw_info(device_id, data_type, data, data_len)         \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, data_type, \
+					   data, data_len, NULL, NULL))
 
-#define test_err_get_hw_info(_errno, device_id, data, data_len)               \
-	EXPECT_ERRNO(_errno, _test_cmd_get_hw_info(self->fd, device_id, data, \
-						   data_len, NULL, NULL))
+#define test_err_get_hw_info(_errno, device_id, data_type, data, data_len) \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_cmd_get_hw_info(self->fd, device_id, data_type, \
+					   data, data_len, NULL, NULL))
 
-#define test_cmd_get_hw_capabilities(device_id, caps, mask) \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, \
+#define test_cmd_get_hw_capabilities(device_id, caps)                        \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id,              \
+					   IOMMU_HW_INFO_TYPE_DEFAULT, NULL, \
 					   0, &caps, NULL))
 
-#define test_cmd_get_hw_info_pasid(device_id, max_pasid)              \
-	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, \
+#define test_cmd_get_hw_info_pasid(device_id, max_pasid)                     \
+	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id,              \
+					   IOMMU_HW_INFO_TYPE_DEFAULT, NULL, \
 					   0, NULL, max_pasid))
 
 static int _test_ioctl_fault_alloc(int fd, __u32 *fault_id, __u32 *fault_fd)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2b3274015832..eb5b0adb16a5 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -764,19 +764,34 @@ TEST_F(iommufd_ioas, get_hw_info)
 		uint8_t max_pasid = 0;
 
 		/* Provide a zero-size user_buffer */
-		test_cmd_get_hw_info(self->device_id, NULL, 0);
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, NULL, 0);
 		/* Provide a user_buffer with exact size */
-		test_cmd_get_hw_info(self->device_id, &buffer_exact, sizeof(buffer_exact));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_exact,
+				     sizeof(buffer_exact));
+
+		/* Request for a wrong data_type, and a correct one */
+		test_err_get_hw_info(EOPNOTSUPP, self->device_id,
+				     IOMMU_HW_INFO_TYPE_SELFTEST + 1,
+				     &buffer_exact, sizeof(buffer_exact));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_SELFTEST, &buffer_exact,
+				     sizeof(buffer_exact));
 		/*
 		 * Provide a user_buffer with size larger than the exact size to check if
 		 * kernel zero the trailing bytes.
 		 */
-		test_cmd_get_hw_info(self->device_id, &buffer_larger, sizeof(buffer_larger));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_larger,
+				     sizeof(buffer_larger));
 		/*
 		 * Provide a user_buffer with size smaller than the exact size to check if
 		 * the fields within the size range still gets updated.
 		 */
-		test_cmd_get_hw_info(self->device_id, &buffer_smaller, sizeof(buffer_smaller));
+		test_cmd_get_hw_info(self->device_id,
+				     IOMMU_HW_INFO_TYPE_DEFAULT,
+				     &buffer_smaller, sizeof(buffer_smaller));
 		test_cmd_get_hw_info_pasid(self->device_id, &max_pasid);
 		ASSERT_EQ(0, max_pasid);
 		if (variant->pasid_capable) {
@@ -786,9 +801,11 @@ TEST_F(iommufd_ioas, get_hw_info)
 		}
 	} else {
 		test_err_get_hw_info(ENOENT, self->device_id,
-				     &buffer_exact, sizeof(buffer_exact));
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_exact,
+				     sizeof(buffer_exact));
 		test_err_get_hw_info(ENOENT, self->device_id,
-				     &buffer_larger, sizeof(buffer_larger));
+				     IOMMU_HW_INFO_TYPE_DEFAULT, &buffer_larger,
+				     sizeof(buffer_larger));
 	}
 }
 
@@ -2175,8 +2192,7 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capability)
 
 	test_cmd_hwpt_alloc(self->idev_id, self->ioas_id, 0, &hwpt_id);
 	test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
-	test_cmd_get_hw_capabilities(self->idev_id, caps,
-				     IOMMU_HW_CAP_DIRTY_TRACKING);
+	test_cmd_get_hw_capabilities(self->idev_id, caps);
 	ASSERT_EQ(IOMMU_HW_CAP_DIRTY_TRACKING,
 		  caps & IOMMU_HW_CAP_DIRTY_TRACKING);
 
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 41c685bbd252..651fc9f13c08 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -667,8 +667,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 					&self->stdev_id, NULL, &idev_id))
 		return -1;
 
-	if (_test_cmd_get_hw_info(self->fd, idev_id, &info,
-				  sizeof(info), NULL, NULL))
+	if (_test_cmd_get_hw_info(self->fd, idev_id, IOMMU_HW_INFO_TYPE_DEFAULT,
+				  &info, sizeof(info), NULL, NULL))
 		return -1;
 
 	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, 0,
-- 
2.43.0


