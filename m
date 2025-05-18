Return-Path: <linux-kselftest+bounces-33265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D215EABAD45
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD44189C027
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2D204097;
	Sun, 18 May 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaMMzKQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B51FF1B4;
	Sun, 18 May 2025 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538553; cv=fail; b=sXzuFBre7q55k+4fsora44E2xqBKZXCTONLrjqhKNiFQb6COhn+5Nd6FAuy74lM238NnJdReYS5PRs8rqX2m4fswXd32yuDIHFdOFRa/4+D5L3qMu5/55wfmuXLGKKfVsg1wRktpkh8Ux170sWggv0CebCkSY/QOKtF5Wms6W6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538553; c=relaxed/simple;
	bh=UG5HZwyqA8WM6b+RJk0ftQq5gc21Eu58pJRV1u8S9kY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gduM5XMEQwZIasSkkl6T8tjHXIneqkLyXkYSwfGs7mDHQ6mwQJ9ZCTgJqz0poSkTNoUtcD+dQvI5irIjRr6KTNSUrEix5ulHzhxmE4DbFTNKLy42isAmHMsFg+ZMN8Dwtuz5bMNxn5G6i+rjyWq3CZtcr9C+oyVAUyKuvbh0o9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaMMzKQt; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCUzSSWmGf/gEKdfgP2I/5fy/wElC9hQcWT/JTSTqWBKxQ5REyKe8L9Hzpz115jO6vbaG+VZ49czuf4hJe2W26ER8KzzFQh2EnQ90aDY1YffuS7uA2p+7m8KhWKxttyLr8d8PzlEoYaiTe5FtL1TZSFHe7z71kNyrsR3dSwG2KqNDM61InsvmcTkvEzJkH7GdlnX0Gvi+GAyjgI42HnrSxeI+9mZ292ZzWop4gU4DeXkjat6Md1FbyIb6k75cuNWM8kvEUzc8WB5xBUNaFEqy2vxLbg6V3pyWWXeleN5RxCAgMhI1UEFqxXJQkodDIfpai2T1K9JMIwZCBMNjBW9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=kNBQQe95u/luEAvDl+C9nTz+4mNp8GBmS4IBLCmAJLd5ok1iW5Tm6R5rH9Q7m0yFKthxZY/nuJbrH4r4N/SQFzP1BnKVrnjMT2SkqaFz9/XBBJ5BvIH0H9muEFCaMZxNJitoEBlkOKz+qnl27fZbGtoytfuU5g/yqBMwHT4/iokj/BI70m1GzCHLgEAzdQvxWEBTT9a9QCqSuGi+/wBa/7fq947u4MQ0W2Wsie/t6ExRG3lKDmPIPAbWWZbURUita+SLhGWEDNjPL5+MmbrxH8SJf1Y0ohbW9PxbC4byQhjKQr1yVyToXTt7E1GWIsECBsJ+wlMBGO/wBgtChH26VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=kaMMzKQt+sJeEbaLZMj/JJ6JXMJ1H+pWDKsPYYbC4a84ZZAY+XCF8tEd7He+0n2BTGyDiKW9hSsSCl+tJzrQNX5x1oEAxuO+cxiokXEQyX0e+Kh8K4uRBO215paVYocPEgtSKrOC1k6Z3K/WM1OLfT3FQsQS1hTramKlqZCsbD8LVPkI/mWOcNMpn08OTbcwfcRT+EKAeNWJFERB3N18b72mF9nK1s0+fHO8y1XNmOwVmBEayHz8OjrPq78tnCaXpCV0QnVQXjusdbWLuE8VnBRshpZ1T7An0HI5ibf52p5G9vofGYrNmnwoq8fyH6VE13iV/u/V1uE7QjXwrHEowA==
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:22:21 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::79) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Sun,
 18 May 2025 03:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:08 -0700
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
Subject: [PATCH v5 08/29] iommufd/selftest: Add coverage for viommu data
Date: Sat, 17 May 2025 20:21:25 -0700
Message-ID: <45d278d4cb4f1420c73f82566efd5919e2c4687b.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8a521d-6d09-47ad-28b8-08dd95bb3375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?120bp6oH5iDnRtDVSUS8EsRH8W0dJKMiCZRXeo64JB7BU9IaSIwwNnrEp7yl?=
 =?us-ascii?Q?7/v7YhAEKYOlvCF4IxV0BdaN7oXCQ8mTOvG6ComKuJTBhPkHmBw+LyfUBbip?=
 =?us-ascii?Q?9n0Y0D9zoeKiyofJUFR7yk7CZ9S/RYc0NzNaoteg8DOGzAa/rzZYd0ant8sD?=
 =?us-ascii?Q?g6F0/VrXRPVu3N8whUWNoTeoa7Bx2YS5/uLoSOzePJLVI7Pcp1hkvEwuTwUh?=
 =?us-ascii?Q?rwHe/TyB44aLs5+HaCftjn1jv+7EQxmewsa6l/NPGqiC+tAnWZTrC3TWrcDh?=
 =?us-ascii?Q?L9yzgMHIuZ/6yEzWSPc1yfowzLsaA6sVfekGMGVxcmV+PvJ21QHjkUq5GnHZ?=
 =?us-ascii?Q?GG7mqb+DYpsXgoZN1rZGykDETm4Lsp4zw9PT24QkhxJTFXEHIXZGIr4hVAHv?=
 =?us-ascii?Q?5yyLriNHL+4ScdVetwKDlzDuTuo6xlc6MIBDQn0vfl9xZwD/920bjaY3Q3ZO?=
 =?us-ascii?Q?8Y5E2WkiZksiS/nBIic3u/fYrkWDR61Y55LO3w20+NIj2o0Ijut4122FJm0g?=
 =?us-ascii?Q?ZG/0/nCZqtb6PbHf1iz9bVfbJkbbN0fUuZUpB5KvJsERspfUUwHPCbSrPMRC?=
 =?us-ascii?Q?Ji0L7ofi1rRrQ1lKtQNPtFsQndcRwOe4kRvIhe6uSLvQqROzOLBSAMipJGmJ?=
 =?us-ascii?Q?nqvyWy5XyldZ6C8AMUMnS8mAZDmrb1EGbn2FTW7ea5uDv51z+vOq3/yt49Wu?=
 =?us-ascii?Q?x68h5Hdv9oEdSgmwDK1SAzesjwhLTyVOowRW0Nt35iuzbtJ79dnyQWGJiA8u?=
 =?us-ascii?Q?utKwvCoI40LhZjlwX3dCrGmSTeVq6S9s2fr8vSyId/sbkaJ39Zc+h7IaSf2z?=
 =?us-ascii?Q?k2S78HLPI7VIo6iTnMs4hjXuXshxLZa+l+3rTcFPIpbAb5hMgdgQgb/GTHqG?=
 =?us-ascii?Q?y1GwE2juRvYSAccfnqPVlizrSYUbKC1RR4yU87h+fOu5kFnXPH7bbXaPuPQB?=
 =?us-ascii?Q?YEFzZB4g6C1W+jhlc7hfsrwG40ENiaoGI3e+b3kIXEjZfQdmFMVO23Urixoq?=
 =?us-ascii?Q?MGgjiaWaa4VlSfmjS1EddfS3T3GEoez8G0M8kVvYFRsoFE86oXfYjXVuQdhd?=
 =?us-ascii?Q?Y0M893oUFW53ppha/bVjEDSBOStxb+PGiRngAPxQ7EzVkE3j8irN8Pg8cTai?=
 =?us-ascii?Q?pgN0VeGTf1FxTgzcI/ggS98vk9kWzfty4VLiCcyaZvd9LMUcfVK3+QjdHqrn?=
 =?us-ascii?Q?4SF41rT8NExmoZHNsDRtF3tpnF0Tk/5hZbXATvf1BA9LA7KCTz9QUq9bNg2u?=
 =?us-ascii?Q?PKztbIwg49v7nOlp9bGV+9kWmb0B7FqoufKy6/HHBvGaceioGkDPMP9WbD5F?=
 =?us-ascii?Q?UaxUluf588cFVWUfcRwxv1mA0js+YfG41dTYVsMtnSxQRIrHN882C1YEObQC?=
 =?us-ascii?Q?BAn48y5QLdNsTFSg3BMDFCxoyrjrXnQPkARcJgMzghJKZvCBA1gPyFeQjxjI?=
 =?us-ascii?Q?qwHPpGsAUxJyt1LdXnc2+Qd6SbjTAKCyqJaUxv/DM4e6oxkIxULdIjYIYngH?=
 =?us-ascii?Q?y0o9aGlVQjpNMsL8z8ZzSZSkqTcGKAX9A0CV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:21.0076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8a521d-6d09-47ad-28b8-08dd95bb3375
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 21 ++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 30 ++++++++++++++-----
 .../selftests/iommu/iommufd_fail_nth.c        |  5 ++--
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 72f6636e5d90..a5d4cbd089ba 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -897,7 +897,8 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 pasid,
 					    pasid, fault_fd))
 
 static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
-				  __u32 type, __u32 flags, __u32 *viommu_id)
+				  __u32 flags, __u32 type, void *data,
+				  __u32 data_len, __u32 *viommu_id)
 {
 	struct iommu_viommu_alloc cmd = {
 		.size = sizeof(cmd),
@@ -905,6 +906,8 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 		.type = type,
 		.dev_id = device_id,
 		.hwpt_id = hwpt_id,
+		.data_uptr = (uint64_t)data,
+		.data_len = data_len,
 	};
 	int ret;
 
@@ -916,13 +919,15 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 	return 0;
 }
 
-#define test_cmd_viommu_alloc(device_id, hwpt_id, type, viommu_id)        \
-	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
-					    type, 0, viommu_id))
-#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, viommu_id) \
-	EXPECT_ERRNO(_errno,                                               \
-		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id,  \
-					    type, 0, viommu_id))
+#define test_cmd_viommu_alloc(device_id, hwpt_id, type, data, data_len,      \
+			      viommu_id)                                     \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
+					    type, data, data_len, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, type, data,        \
+			      data_len, viommu_id)                           \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, 0, \
+					    type, data, data_len, viommu_id))
 
 static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 				   __u64 virt_id, __u32 *vdev_id)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..f22388dfacad 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2688,7 +2688,7 @@ FIXTURE_SETUP(iommufd_viommu)
 
 		/* Allocate a vIOMMU taking refcount of the parent hwpt */
 		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
 				      &self->viommu_id);
 
 		/* Allocate a regular nested hwpt */
@@ -2727,24 +2727,27 @@ TEST_F(iommufd_viommu, viommu_negative_tests)
 	if (self->device_id) {
 		/* Negative test -- invalid hwpt (hwpt_id=0) */
 		test_err_viommu_alloc(ENOENT, device_id, 0,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 
 		/* Negative test -- not a nesting parent hwpt */
 		test_cmd_hwpt_alloc(device_id, ioas_id, 0, &hwpt_id);
 		test_err_viommu_alloc(EINVAL, device_id, hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 		test_ioctl_destroy(hwpt_id);
 
 		/* Negative test -- unsupported viommu type */
 		test_err_viommu_alloc(EOPNOTSUPP, device_id, self->hwpt_id,
-				      0xdead, NULL);
+				      0xdead, NULL, 0, NULL);
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->hwpt_id));
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, self->viommu_id));
 	} else {
 		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
-				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
+				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				      NULL);
 	}
 }
 
@@ -2791,6 +2794,20 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	}
 }
 
+TEST_F(iommufd_viommu, viommu_alloc_with_data)
+{
+	struct iommu_viommu_selftest data = {
+		.in_data = 0xbeef,
+	};
+
+	if (self->device_id) {
+		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
+				      IOMMU_VIOMMU_TYPE_SELFTEST, &data,
+				      sizeof(data), &self->viommu_id);
+		ASSERT_EQ(data.out_data, data.in_data);
+	}
+}
+
 TEST_F(iommufd_viommu, vdevice_alloc)
 {
 	uint32_t viommu_id = self->viommu_id;
@@ -3105,8 +3122,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 
 	/* Allocate a regular nested hwpt based on viommu */
 	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
-			      IOMMU_VIOMMU_TYPE_SELFTEST,
-			      &viommu_id);
+			      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0, &viommu_id);
 	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
 				   IOMMU_HWPT_ALLOC_PASID,
 				   &nested_hwpt_id[2],
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index e11ec4b121fc..f7ccf1822108 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -688,8 +688,9 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_NONE, 0, 0))
 		return -1;
 
-	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id,
-				   IOMMU_VIOMMU_TYPE_SELFTEST, 0, &viommu_id))
+	if (_test_cmd_viommu_alloc(self->fd, idev_id, hwpt_id, 0,
+				   IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
+				   &viommu_id))
 		return -1;
 
 	if (_test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id, 0, &vdev_id))
-- 
2.43.0


