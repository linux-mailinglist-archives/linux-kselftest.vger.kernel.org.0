Return-Path: <linux-kselftest+bounces-34995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58749AD9AE9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9921BC07CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54522655B;
	Sat, 14 Jun 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpvicdaD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E79224228;
	Sat, 14 Jun 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885355; cv=fail; b=QMV+K5XcbPPr0boSUR3HCBSs5U5zTfuMF+27yGB80gbi04vbzLyTlRSqgc/Huo/h3O5fTISHpzOqgWkB2//F1TJGt69IuaT3HMxc/KKRuOT3PZ7JiNOXSMj+vyK757O72AHB42FOIYcUs5f8SDDsPT4V8/FgBmhevL8HqDchx4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885355; c=relaxed/simple;
	bh=362PUNNfU2NLDryUN3aHBfl0pTcAjVJVt+ViDLEU8LI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq9JNP4E3N/H5MNK0V9we7zEM41c/d/2oIpoQt4YkN/hK2I2xeSjlygfGOrQcjedrxkZ2ZsvIB4SHeAj6+ccn76PHV7K3nBwmZtVjHa5UZUo61sySE0iiJhvQePJ+dIqdzAwBJQuOWjRchuwnz8uOCZuYfFXxSKfBF2FgIcmu6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpvicdaD; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPqiPtPwn8/E9qRKVYd2Rd9cqV/TaGumYufZ5fT1TcXQeS1WSYT/btYFjoMsd9ZtJQ8CHSMrMySvyaPXtkQJoRnq5cO31zUqmnA9Av/jjmd7LfE8lXRVVLRr5VlBjE3s4b7ch6EG/oXRlNuDzK5qe1JV/f8IgZzGJOHd7uTYJ8Pym1EtM4E9c+fHizpdHwJaplOoD06ckLE3lBN6jPK1kanQ65vCaq8n9LUcU18CfCqIBQEezKDSvPJiMhUOnwuc2wadcAeeR5xX0NZHj0v1sao0vuuqYzNsVJvJIPromzkNIamlH6SBfcewCsfU2K9q2hwVNsmjHOw37rzV7rgI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLIUwJpoP05Tw1QSXBU7D/FGXoUeHasQIIWDnPNcvK8=;
 b=ly4/azVnfLJsdb+Kp99GSsObZah936PGdXPE7pY0wahEUGPrA+AmklvM21C6v+dX2hJ3rqG4iguNJn/qxMvYE2I2E8WWOJt8qCFUsQvlFjBAO7gfEWQ90SQ0MmWS7sTt1IwaQuP0jr2NcYIHpppYZ26TqNx1RqqAT0144/fYDdsc9iTYWaHnE7RFXPAvy/dR3pJ/PCTB5JYsZqSAfssVBsLZYCBsy0qqeatSfDtpgZqEm3L9cIk9r6pscr/DeVpY/Wabci14qqbL3xKXkrkEDmdg8mH+s1mRuQNH3D8Agt62xtrRRpE5+l6c0am4k/bQ5/Hji58t7pr139ABPd3cmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLIUwJpoP05Tw1QSXBU7D/FGXoUeHasQIIWDnPNcvK8=;
 b=qpvicdaDAeMMKe20cckShSe6ihbmg9kgMqa0r0fmvMKGlehT5Qz0Cor8IljB9O+vuTV9qiiHYtO08y2fFGyJrW9UL4xUm6zvt4k6JgSCaFNWW+CChFlsHcNNsQ1lmcgk1i4asL+/S7iD5GW8PVdqjcD74Vji7QwcMEuFm6+B22VPQQqr38nct+R/I6/wnW7p1dCn55bt0SMITo23+WFiMX9oLHLYXi1jLP1mz2cMf0dWYQXhFbz1FWFNf9y19O+gsfa4+2ZYqF0abhvdNoASeQQk/EJ6wmS93WGLNJV5ErqCMr84QFtN8v4dY21Db0LY8yMtxUZcZd3a61pSC2yiDg==
Received: from BN0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:ea::7)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 14 Jun
 2025 07:15:46 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::5f) by BN0PR04CA0062.outlook.office365.com
 (2603:10b6:408:ea::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 07:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:30 -0700
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
Subject: [PATCH v6 18/25] iommufd/selftest: Update hw_info coverage for an input data_type
Date: Sat, 14 Jun 2025 00:14:43 -0700
Message-ID: <0929582fdb08cee8da9277f439834024b7deda15.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: afa85493-eddf-4f04-a716-08ddab134859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8Dv1Hk2moOFQ+QUCc4ObDTR5njgDycpq7WeRKVNkluv3OBY3wLfOdjpOxiZ?=
 =?us-ascii?Q?3RxS2M0qOep368lHzbsDjugFCnvXz/stoRZnuWXeKWBeXWTWlopMC40UsYkW?=
 =?us-ascii?Q?EfEP08LiR5bxgX7uWflIDYCDvbwo/wmL5EU1z/4UDzLSQG16Cmh9No7VtNqG?=
 =?us-ascii?Q?Ef6A4yyFj0C8XEJCN+omITzfpkXAWlKtW7A0V4KPGUry4TiDE8pxcEWAGzUO?=
 =?us-ascii?Q?BptlfgrHIPIeuNB96pCVWrQpcSlPFICaAdyLuBaU9S4SoR/5qZL1R52cMuZB?=
 =?us-ascii?Q?0QsVxsQO6iEf5mMGjWaroDeegVxsPd1cclZJpK9ozTvoedkCOFL7sJWokrut?=
 =?us-ascii?Q?q4ttyYyT1H1WPKtefmIHOgXfAn2aCT9N3ItvtwGn+x9JoouomVacuLTqsddL?=
 =?us-ascii?Q?+NQnWagTAYwJzqc/tVpvq5aopEk1gXK9RNPt3ZhkqugJcxT7p8AFXid+Ujhv?=
 =?us-ascii?Q?f7yTZRi6lZFkU4s4voEY4kOQ2KehfT2BqdUFh10HNnt+7rirwKJ0OCngB0KI?=
 =?us-ascii?Q?Ws3jkJHzdcv4w6kDoHAKbNDCpJFbp+oZA2bhBlX+fKyrrJwUPL4Tl7/6g/se?=
 =?us-ascii?Q?lqYieeeOyDXQU+0zhyaDzIJAhWytX6aysSM3rjHRojUwuql/t6Emrfsn77wc?=
 =?us-ascii?Q?3tzFm+yut4JI2q46Wn3oxNmuNB9RttGeAvslcqFTyr8NqfYCOOqnKoGBJpzW?=
 =?us-ascii?Q?ACUtTAWTXeFGqdbOTjwsnom0nC2n6rueFX4RXfV0fHx5H95por+x8mGAd9JU?=
 =?us-ascii?Q?s4LLKMgstZSIAySp7R1HeITTBnQKhoRpDVB2uSum4q5axcy8puhZzQE8tdto?=
 =?us-ascii?Q?Kv61gpZnVRbeq7MOq7OTOLc6LCfQZKpkL+zbOCqIkBLGEtPVDbC2rrtvhuIi?=
 =?us-ascii?Q?6/uyawCBPxVsjPdNHySB1OKz1iBMfF7SQatcLiVmKXmO3K1zgI0iKg6ZovVn?=
 =?us-ascii?Q?L5VJ3bKqxxEk6Ohu2LkhcDlIULm6Nh9aCMZw5FOJjkNsAcl4ZWeKGk51HCaC?=
 =?us-ascii?Q?0U6o6SVcycT1Np/zM5p0g8U2OzCHoLWtXzh9k8YhZojDd2dWzPuk1ncVpF1f?=
 =?us-ascii?Q?RZ65syOQQQrTn9+JfIW9vko/6YtXSERO7XjuvbsefDSFaWtrLBtjZMcBCuUt?=
 =?us-ascii?Q?cRMZjsPIhqgrOT4Z2wSTEAH7kskz7uoCt7Ru/tp2JtsA/B5WZWqJvo4iCwNI?=
 =?us-ascii?Q?Q5/mgFarEf8DJuH0GJ2d+f2eMJevV4aVqXI36y74CgRhXlTDQT2zKrFKIkob?=
 =?us-ascii?Q?TtUzAka3UjlFWTTN96XKGaNFD6n6xZqGdUiaNmJ1wisY4/POtYwJDCCG4bmF?=
 =?us-ascii?Q?iMEKcHAj0DvPJwt9VYyQ4JNv+g+njWQaYRK91FXbJNi8agXrd3yDdCGuZjFF?=
 =?us-ascii?Q?Pw7msH6MzJMAnpCuHW/QsZ5yL5KvYbvmoHSyPaHxhaf7T41Fu+iEb9EGSBii?=
 =?us-ascii?Q?FCiF8KqeWVlI6w6pDzcM6Chxr0sONMTHItEDue5/c2Js3+sLwzLM3OFM4/A3?=
 =?us-ascii?Q?55J7m1HO30CHvIHKd2mL5hYPX9otIe1sn+7K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:46.1034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa85493-eddf-4f04-a716-08ddab134859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

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


