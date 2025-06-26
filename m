Return-Path: <linux-kselftest+bounces-35907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7ABAEA6D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6E81C43146
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B52FBFF4;
	Thu, 26 Jun 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrZutTYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E82F0E20;
	Thu, 26 Jun 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966562; cv=fail; b=GY0U9i1aSZO1ZcaSqZQN769I2t+88vz2A8KM8VCljpbH3v6vXd6jIopCTJ1B5CM0v7uxrOzQB8pP2u1qYvKXY8OzzgDt7SvKGBWX4NlGGIFtK7h1Y0ZiVPDBLDzn7o7xtjDwbA+ONWQJsDyTYaSpD2l5gsmfWwzs/GaWGyDzjQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966562; c=relaxed/simple;
	bh=362PUNNfU2NLDryUN3aHBfl0pTcAjVJVt+ViDLEU8LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVwMfuDTVlClzlLPfICTzj3q6YtX51lX+wQenLkv9vp6nQDcea5xhrqQkUK1yIdJAKKPl5ZYvEfxnuW3abuRMc0GZxwXI37jzGX/GC9G90nkTcGgZ+TuHT/ZXs7w6I6nseH0YlTR7/jSsktDaPspPaWc8tSuqKb7y7hFj7WB4VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hrZutTYW; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHQ8pnfbsfhhKuCJxBsl2MxJERXEsHbRivQG57mnFZMlinU3Wt1AWiZBhFIzMoO6Je/zSutLqNYSqm0YpQ/e5N6ibc40BFmUdI+daccTpKDaJk3NaAuVnGyObFbtkYyaNsK/z+ho01nB4pcKL+N+l5auoi6L2pxmGAdNGp9LSANTzml3Z5dP18AG8lOpyoSk/3uJM3YHwpyDps7O3Q8qR6LioS30P2CTPVD2aRMeWJEkyLlRdDKGWr0YKDgujbpG2etL7gQ7YjXLriAn2CJHbsBj+VzdU4sjQ3lwpp3HuLqmRq6hujaaHQoVkIkbzo+i2/hoF2CIDGJmPDAn0vtyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLIUwJpoP05Tw1QSXBU7D/FGXoUeHasQIIWDnPNcvK8=;
 b=sFLKBzwmEpO6kikZWVHe+DtGzlpZEWsKaa2IsnsiJumTxKyhAWszcMW+u9zyCfv9XPSJnMvbQXXVxkkvC0Yc79339UNWegsZPkKPee2z3rmi2zGk5ELb4b47QPMQ/7OpH57CjRgnFoEJVPg1jqLb7ftvzh7GvuxPiA7kAvcgOdk7kuQyNi2rTvOKPDpDT31WeP0bBnboGkBJuYqAx4IkRK8hqJ9p8USgUs7o20V07vTlNIxBDTo6ihMkFrOtAT0wqPZMCASJbsz/oVJ8NTRtCXBuzkLiJ1Qf0wlKPB3G2Mu6oiP1NGNBaVCvaIuG1v9IYFAX4IdxmqGpJ2Lk4mBH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLIUwJpoP05Tw1QSXBU7D/FGXoUeHasQIIWDnPNcvK8=;
 b=hrZutTYWbqYGuCX1O+1hY3ogqgkbheTPffdPiXLsCu5p1O5w8oPV/b01okgyyIBHDvwbymzqsfh7QVWH1puR14JDNlRBWzgrMt8RuI7yoBqB+2dKEXROx6s747w3ozrtm2nfx6f/kcdZQFNZqVUkae6rnlrK/yzeOwanSaI/KGIeNMywuRHCMBUwsAn2fEwhL5vA4xFOSMn5DFfcWJyIv//WAdGTUgrw/I5KTP5igzW0Eu625vmal3CuIzcJmCvAmPCXso3KRVPy1DE8aOyb94PU+X+fpZIm5VoMAuUKWOYN8oQcNLZxVTR88590EzglPCNQrbtaSnX6jyolBBLlCQ==
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 19:35:57 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::49) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:35 -0700
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
Subject: [PATCH v7 21/28] iommufd/selftest: Update hw_info coverage for an input data_type
Date: Thu, 26 Jun 2025 12:34:52 -0700
Message-ID: <cb44b23db862e28a1de508c5fa04a29062ab1063.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: a74f58c1-57a5-4ec5-bb29-08ddb4e8ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZyRR1xKJQbSNoKvegrMnx8qa5tsvUn3qy8/5AvLkn9cNLXSC2MKXLMolsNS?=
 =?us-ascii?Q?JUixt/83lcy52PzXNKvwACWBhW6mPOwvsYObiUoQFZHfDBYvxCAFfrAMCd8h?=
 =?us-ascii?Q?sS5gkLJ+jpO0GI+0MKazvatM6FvHNnOnZMepXB+YxOmyNHxmC7g/NhaTXY2L?=
 =?us-ascii?Q?mxyYXKcJqmHn4QJUQFFToyZ3KNayXLO8wavuwIet8dSgMn1mGjMSt1Ircqch?=
 =?us-ascii?Q?tJsD0h5/AzNQkE0a9gW23ZyFnoEmHjWMbRildR44KCu2JMbrwigepfj0c7jH?=
 =?us-ascii?Q?U+IBglygfAx4TLEizpLscEy8OWObyfqeza34noARiUy2NpImKfWtXz9YaVZr?=
 =?us-ascii?Q?Culg3uAjTvukhfgHf30CeBaZCNYum8FMYtGuIGVYnJYgHZiJZukhoiA0on8n?=
 =?us-ascii?Q?PFdA1SPO1OXV32yjuvLRTaxhamUPQBvI6yWYvxQfN/WMTgA64zI6B6JLXJS7?=
 =?us-ascii?Q?m5MxEuIU8Z36mGVpiCEc2hDf5ZNaqnunB0IaymzoPQhm5TbsFvmmaJnRpoMs?=
 =?us-ascii?Q?7VLqMTxANB7W1mPigfNflTn503wN4yVQ+ri67dFn+5mAy/RQRoYCSHNViezy?=
 =?us-ascii?Q?z4PyqH5XHygNJMtQcyp8fv9PcAlRwRNdmfmzGw73mC5Gfn47uZ0B9a3JC2E9?=
 =?us-ascii?Q?xqcwoS2hd49sGD3GJyDsSiC2HBzjLCHMWt7jklKwvn1Lytxcj5ZyOlHEFpxe?=
 =?us-ascii?Q?vQed+34QB7YgTYLwdzhS1+szaCvEDdhEE72rC8je8eZaZX0hKZuy/Tx0YfIX?=
 =?us-ascii?Q?z8bvRWjdck8Oa6BMf/r9Gd1Vn6HVRWm8P97GeZ4HDLcEEfhn1HbWZ+++PswQ?=
 =?us-ascii?Q?2Ll+HDr2c4SJ565AJRTTeGDTGUFk0xLsL1LI96K8jdBKmYahzEsWYB84WTeM?=
 =?us-ascii?Q?vDvVeY1+GoUvC7DIkdq2Rzdi7kh4SC/TczBeG8TzvNxA8grPcP2bYrvC+yT/?=
 =?us-ascii?Q?BnffhrcwhtA+4OxtQIbGFqrKFOQ7Re+tOFqKUCjWuikXldswCoh5CCPobTVS?=
 =?us-ascii?Q?gQKtHLFQPkD2Ct2Uvn507piY1kThEWPyNUhGmfkeOYJDFWBHInP2ngUE2vVO?=
 =?us-ascii?Q?qLG6Y/xXap1vWis1GOGl9Kx/fTj3mDlu5VLd+tpSiyWFvd1msh1l16IQm2wd?=
 =?us-ascii?Q?Wi3P2fAGtlZ/ktMu21fKwiCf+6Z8SFwjhQhpwgPFN+YATr8fBKSV12/3lFc1?=
 =?us-ascii?Q?GBGxS/D3Dqg0h8lvmNBlG47sfZs66bupD8iK0qrzBN32izguItOvTJOFZ1M2?=
 =?us-ascii?Q?1BdHlIBSxMQZQeauRLschZChHoNiaEKoxtlTLZH3SoUgOYym+4BNdJ8KWK/x?=
 =?us-ascii?Q?AhnVx3ZfrUReddhGQ/aE5Ubigbjt/B4KsFH5bpbHXfd2pX9Mx2IKtrhe17ER?=
 =?us-ascii?Q?tsrEoG/9IKdU/fUm7HposyFwSuWv213Wufuy28YSsjkXSG+ZhbL8D/hZ4t6r?=
 =?us-ascii?Q?Q06iO3uF3P/sQq567Mt2bBD/djHmVZxeexvVhSElkOhwsMfw3AWV3SkANuRN?=
 =?us-ascii?Q?muUtxgrZQZHN/vGJWfmDrT3LO09+1RubAD74?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:56.9710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74f58c1-57a5-4ec5-bb29-08ddb4e8ac23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
add a negative test for an unsupported type.

Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
is complaining.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 33 +++++++++++--------
 tools/testing/selftests/iommu/iommufd.c       | 32 +++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +--
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 4a1b2bade018..5384852ce038 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -761,20 +761,24 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
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
+		.in_data_type = data_type,
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
index 235504ee05e3..fda93a195e26 100644
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


