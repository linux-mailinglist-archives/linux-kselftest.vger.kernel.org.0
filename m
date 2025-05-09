Return-Path: <linux-kselftest+bounces-32707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8BAB0853
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5E0506E0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58865245019;
	Fri,  9 May 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PjUMqkMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C3244EA0;
	Fri,  9 May 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759816; cv=fail; b=bgB91UO7eaHsDKPs9jDs++WKyABBYtvzo4kZNhTLKEWPPmyxWxSfNB2Siwr3FAjJwfZP4CBL0cc8N6tfEzzDkY3mUwuNUAobqFpSpGF7HalQFbFON/KtW/8Fj+T5yFGm0LRIGWjk9XDCvI63fw+H+74bHyRBE9RA/3ryqyZl2wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759816; c=relaxed/simple;
	bh=PgWPeXoELgVyf4W116NalOdWG3irwdM4ZZDr/Upu5WY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFliAR0FLapX4+hwywA4Bvb5w4wVMcQYsVZB5/6bqRf7/VoiNzCKQPcIFMT8wx49yLUp31j1cLlwdLKSphbLHPoMdOsqF4qZF0mNMtSBQ2JBdhmyP/m5/m065OsvhhrAkqjRC46K05b9JEcnSwFeNj6loValAf+5816tGmO2Lrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PjUMqkMa; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRrhl8+K1uLrKYu6d2odBr+CG8KpUIVXoqBfjcbVSQqIaM9ut5xGzk0oZon9pya7ZEpHp9nnvjR8dPzWs2HXMLIk0QMxafhiNBvH2sHwjxVkgTs0tlWhiqnbsgCAcKyJ2vZ1v5M98Spne9KKkCN2xZYHkUm0vKNwDAbtPGhSIFpG0260jmd305Hd32W8lLZdHFAAUi9aXOepcI8roWE0A3ZazZiKnZxhC4uyyeANo0/UV+ugsakcpFduKRg0mVD7LRPctLitHCeg5qh/oGXvEpNGddrs/+BxuPAxXViEppFUnkaZekIfjJrKCrFtxMtVc250ZkRf7QZ5NdzICIrm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kno55z162vrQiwcGO+RKaMp+3uwc20tmkt0AKWdXqQI=;
 b=IK89XJgdVoQIe0shxxmxS888CsGVP3S17pdWafIMsR08QCiDrlDWkBuXkNQ/y0BBj+ve+/5MVqdNxDP1mfDhOS4+YpghJqDgvnmI9praHM1RubF+3dMzubcU3vfi2gmoMYJQ/Y6vPmNzTEBzCK8zBwDm1k+FkVuJVqYvEwK66u41cves2l7733ZvpIZg3yjXtRWcASJrBsZupuDamenTjdjMYltiBtZjuvxgyiLcwsryhpLqWo0yiGs19H+I/PF9bbCjLyFGZCRnAB3SAnwY1s8x+HMvvVGWecDMuLf5yBzdn6cY+QUhQjTggqNmh+fPA7pc62JTVlYhUDjKZVA9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kno55z162vrQiwcGO+RKaMp+3uwc20tmkt0AKWdXqQI=;
 b=PjUMqkMaTGOl7FWLNC2bC38CJw3/dNDdJApsfF+MYqHPFldi2bsvyygRloq2a+0YaMUACH56i43/dDMLARV/jWr4ctEmmWJXj2GDU1RMzgTmxxSJhbwye42dpDypJ6pBtFRuYFNhGFmowS+J3bz3u2Qw8t2Cs9XIVGlFDfHnEPEk36Wa1MblZwjq0qFdeJmhL7Zd1p+CtuuSsRpUC0h+H9TTC8Dp1jEf26Wwocz6XW9F8q2c72BJ4EErEEMWjs0+R+I/8jhXI2CNJD1EsWQuWTewrV7KXSnam7anMPsPi3MZrxxqRKxJQhY8EntGuQ4aOBylnY1h26PbblSIeSU1ig==
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 03:03:25 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a8) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 03:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:14 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 08/23] iommufd/selftest: Add covearge for viommu data
Date: Thu, 8 May 2025 20:02:29 -0700
Message-ID: <651538176a854f6c6aaa76f2f5f17a68cd270c0c.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 561dc20f-84fa-4183-7c0f-08dd8ea610e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xn6Z1oPeteyB+V/ewqL+pIKXOUnKJvWo2TGzUjhCFTbvHCTL9CLvIDL31Q/F?=
 =?us-ascii?Q?MQGRNgpTynYpbrWEwymQLvQQD+GhxczgH1OrKWsEwR55YtEl+RvNnb7kmE+4?=
 =?us-ascii?Q?L0jstM0BjZii4s+VVIpTShGtzknVeJnvZxiqCBofIoaLCUnzb7Ftp7X6DXzf?=
 =?us-ascii?Q?whSILXle7nNabRbNoxlZCgJQ2lsLX2icrhM8MIK5VGB3LG9Ih8H6AwpYnr2S?=
 =?us-ascii?Q?V+aDI62koHSpUxq0kxV+H0TES8RO0m4nnlULAvywXu/u87UK/z20jgrfCg8n?=
 =?us-ascii?Q?raCFxwsZvUGn2EBdH3+s1ynUakTRhMxpPRwrTGu2G3ofztawJJwheoyv1d88?=
 =?us-ascii?Q?YN07F0cGuYYzh/g8GusHJgwbzn/u+oVqXbPr7g/0jh9xbmeD3yNjRnBLWN35?=
 =?us-ascii?Q?WJuZEpTxNGduHg2g537GblL3TQ9uurbAcUgatn167yDSg1tvSFAsyYgwUFTK?=
 =?us-ascii?Q?9Pi54y+vE6cINrig+Ipoom6OYFwakz9cAmBhfnYEe5FZU8tgWHEjIg5ar9PB?=
 =?us-ascii?Q?FzQtlcGOw3mBVfBL5aY9ZQmK6P62FyQgJiAfM6fgOYrm7SuoTOtgz02BKOq6?=
 =?us-ascii?Q?uyn8R9oBoaayfUtfeXDfHuLgmmWoqRFeLje0zAmQ1tT8USdIRJGK8jDjQ275?=
 =?us-ascii?Q?UbsH37ch5ZzcCf1akfw4KduxCp/vNLJ/s7hKUqU583tpRpO1byJwKm1xiHDt?=
 =?us-ascii?Q?FC4K+lAMOS5Cs2Z5+53XCjDZ6ZA71WhyJk23s0BdtDB7+WNBWq9yZ0HSl+eq?=
 =?us-ascii?Q?yLdR0G0QSluZU2t4Etyr+620dcu7QXMTL7tKaQcc79fwN5Ad2/W6rngjrcr0?=
 =?us-ascii?Q?FgxwklUmNpQB3hTQUOwAUxla44B+X/bqWT4mzGOWysVunK9ULlY/qbTKWCMl?=
 =?us-ascii?Q?eTqpayH/TF8FlUd0Y9TSwDmiNC776DVcJ8C55gplqgYPlkla4AQswAlEqTnV?=
 =?us-ascii?Q?B11DHpUTyt9gLdZV+7usFwpptK66e/gY6fi7YkUIk3OU9A3ToxTeLhHjS0T+?=
 =?us-ascii?Q?zsSLWEsQQyVQTnAho2wS7MA75NkKtEGwka+7C/9neQQQbLS0R7VLYfWdD6Ni?=
 =?us-ascii?Q?Lyl4fn4QjD4yi3vVuvtcxQezoBgl5aP7327oFo9vDssLEOAONgorUEvCToP2?=
 =?us-ascii?Q?0uFZJ764zC92Vj3gRaQZhlVznwUkG7U3QmndsO4MtaxvngO7irfQzryMqCxt?=
 =?us-ascii?Q?/lkB6kWfM6pEgNPoPVmygFni+lpbxdK6yNTi9aJox8wM7/W55oWXthBRfl7G?=
 =?us-ascii?Q?RTG4lPl5pLANVju0rtmLE/E3QapEYxXD4RlIlmTTC6AGamF1TdAUNLL60xSW?=
 =?us-ascii?Q?IfFZKVXT29Sab4z4cgOF/vJh/nWftaf2NRz585beiJNT4uOo8taWDoOzMcBv?=
 =?us-ascii?Q?DWl7RQJWursWdEHUNhGjJqbxpuGTX0qqZIjIswHYbBn9EMWsjYB0wDHk7fTZ?=
 =?us-ascii?Q?Zun9RCYMDgAHm3/Me0+r3JefYeUWj2IdGvm/pNLAPJFjJcQ0lcE0BjFhLBDF?=
 =?us-ascii?Q?1dUgT/CbfNdSmtbTuX9dQqStfeIFhb4lK+li?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:25.4309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561dc20f-84fa-4183-7c0f-08dd8ea610e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
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
index 1a8e85afe9aa..666a91d53195 100644
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
+		assert(data.out_data == data.in_data);
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


