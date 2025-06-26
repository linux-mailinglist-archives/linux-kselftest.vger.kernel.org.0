Return-Path: <linux-kselftest+bounces-35895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D3AEA6A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FCC3A1449
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B822F2C48;
	Thu, 26 Jun 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZhAFPwmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BC2F271C;
	Thu, 26 Jun 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966539; cv=fail; b=ea7yXDbxmHy73uCKvWUPQZ1dkMplYHivYcTIMqvdQYzUSFY5m6DXn9V/1VtM1caYmPVhv8uwQCIjr0x1ed4HfMeIK6MKF2CzqVP14QHhuro/18dA18ARc78RMTdqCEOKtQPyXrT9+C8nIdcteojoRXkcrsEzkne4A8MHz5K0wYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966539; c=relaxed/simple;
	bh=UG5HZwyqA8WM6b+RJk0ftQq5gc21Eu58pJRV1u8S9kY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEPpXQ8mm8ecW64Z9a/OpK29lPKJTSoTrRjxuCiYOHHRvGyFP8NT4OzBATPfOaqhd37eBPPMD7Pniu/3hpIbMz8c51faEcCru9IXG3x7y/gdHTU6MOS0twRM8dqEWdCk0njk01ArqGcBcEof04ng9Mm+bxwkIGH0ViCTrakCzx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZhAFPwmd; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzio99a8+snHDZbgpKCqMHr8E06BVGtYk97UWEOEK9MwGIVFxd+uc8vhf268MghdFKPAY4LsmdwxBoqUFYQoD/pEC1AS97HyDP49vZvTl1POX+OPnoBR3IGDZFQBagv1dBNaYTUhoAhePSwyKsRU9t2VK5R12cn3r8UNrTIAASSnQa6+Qw/eKVOjSpYrrXJeVO2KKj4YLGRo2wICrqqXRO1PlZ8lT7j8WtwkBQKZ0H3yb32WkCLwD5JN4n6B1MZKR3ej02Is3b6zS3XyczORN4F2/T/FkZ/ssPVHVT6ngLJW9cK32CdzDWkSomtqAyj8wyBQfRewWf2trItjib7s8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=y3JMhZo2//sBfipzOugX8KBD05iUuAVRmV31Knp/wdvhQscM1ifsWQdv7N3dFLZKro52lQT40R7JD3l/6Eq/KI2Z49qzfMNKT8oKpag+E8kUodHOEBeHzfx+xOO3qomfIANyyRD+Sp0V1gwmOgaC2w8Naen12zjPG7fVKZRZ59Fywd3vQoteUG5wY0X6GZ1O7vZ8uC7T8XxYN7OCiepbO1sVrVbSwwGO92CouLG8idsQnDZBxWlZtbSFHnwmGCaxnhPy6xY75NHjY3CnlZ+x52CHu8tJr3I6HDyo+IgHrXlTncdfe7CZWG9o20P8n7dsFU7zLqgCCTtLxOxxGQgmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5GleiIACVsae32T7Z8cMfQLMmYhdsNmrJhP4lHynJA=;
 b=ZhAFPwmdY4pAHG4pGkKp2suSGDgu30QslhoDmK1UTrTEVgTmyqtVXIn4MGzCL4DjT2mKHRzkWuruStNJQAvfG+o4TVVVho7NbvMTwi0CzMQesEJPQrZ3G9DLO3g0z3bhhV5iLyJ/chRpxyHgUnJVT1f6xwU/t3j+oGlMHdHzM7ZMd3v/TIi3w/4XHDyBvnoIK+BAh89E2LDsiIFB6iN34HXahODsoFLwYLXSmExk4n3c4LrI3zRcrmlOelXX8HDm8onXbymKIUV+8V1qf5zLUEDY/c2k9AeR8Y5NwlK01eiM5nzQbwSewDE6EvDkewL2uzIs8ocOJuLojB/ZI4vYwg==
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 19:35:33 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::a) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:15 -0700
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
Subject: [PATCH v7 08/28] iommufd/selftest: Add coverage for viommu data
Date: Thu, 26 Jun 2025 12:34:39 -0700
Message-ID: <27177488c51a993edb0e949f736fd07776b19e3e.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: eab2b301-a54b-4987-fb11-08ddb4e89df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uETbaDUCrJRLIO1MUHOS9yM/ofWaNHbcsD1CTvFBleNFa6QMpp5oYl+fwouM?=
 =?us-ascii?Q?YkuM24bBvtmP/jCzWofn1YrHrsZPivNL6kQt1uuqAKegC6TUvjpx0EjmWcHa?=
 =?us-ascii?Q?Uq4TExx4X0G8maEmdX79/1Mz8/xh44samaW6SUjfLt/GXkDMrqs4UDeLeTL+?=
 =?us-ascii?Q?+4sFRIRLGpnic/bYZEneOsbsXu61a3NEtL+B2VXABAuhpBqStLJ9Hngq4U5a?=
 =?us-ascii?Q?2pNQxna42f1rq90N89z/ApzJr6skpfz4cZJL+gINoVfm4UYb6EwGQNhpRZ7+?=
 =?us-ascii?Q?kEbT3T8xKFhPs3ZIdhmkyoczDq1F9gYwOjdLX6WBET0rO5bhlk9piYdOtVVD?=
 =?us-ascii?Q?ORTmWqq+zHBnHu8yESvRXF8D/1A4xxNYuLT63VGqvb54ctpj9zfhm+Ab9PYc?=
 =?us-ascii?Q?qAp3SLWL9BPM+K9SkH1iF3YhoGdi1fV9PAQJnSMP4HMtgvxhpZP9iL+beMSa?=
 =?us-ascii?Q?0erQ+bn6BOHSEa7gVjNAerDNMApIP+lcbWfqGrtJI5au5yL5/9i9d23ZOSel?=
 =?us-ascii?Q?pEx409CC8uWqS/g8aYyCIsbP9c7ROoop/HwaERELbTkNK5kcPOge2troYaiC?=
 =?us-ascii?Q?VrF379XUUpMZLvPw0U64KQ5sMr7xzDwamTe9A2YGJQ9pjDcAClCNExj1YnbC?=
 =?us-ascii?Q?eTLWc1PXCfzNOsB75tmiL0JQQc4fTRhU6FUkLRki5gno4dYZZlcxg5eGP39E?=
 =?us-ascii?Q?QgTxKCktg3HXuY5RhXsPh8jSmrQACeh1Hbe+F+c9SH8/I0w8uVN188II+0br?=
 =?us-ascii?Q?xeja0KiVjgK9Qb9AQ4vMQqGPZsGjm453GNk9wqMjCpuQ08IRV/cVODLTB0Fv?=
 =?us-ascii?Q?PIp44062AQtaZtPBpDgxFiTwGg2UVIjIKEy8L00vPw8iwKyX1EIWQE3y86i5?=
 =?us-ascii?Q?iyZ7x4wWBcS0Gp9at8MvT469fj4RkWJhKzNYWv8wqDv2wWS8Y67sjy9wHM64?=
 =?us-ascii?Q?r52VSZkiz2Zg5P90z+Z/mlY+LTKXbTey0uUypX7yjVHspzOcB0dUynLCgYqK?=
 =?us-ascii?Q?pXa9S/dJAKkHYhF8AgsEG2YtLBOPyveI6OjQPMdjWET0ene/E+1Puw8hyNEY?=
 =?us-ascii?Q?AvVSu6PP1bXiceGuBTyjidolE0sJA3oZzrngP5Ht4Psmha7Mu5nl1RuPf4Q0?=
 =?us-ascii?Q?PpGnEHBgOLwHn8QpZlNw67kOKvCr85Y0uwvP3XwA/B+EkWpN6RZQeEYqMKhX?=
 =?us-ascii?Q?y7Roy0IFUo8ALmSjt0Se8A1zx+cewBl7R0/M/In4MamHcq4zDNTARBEbASj+?=
 =?us-ascii?Q?UcvDnTWcY98PehVqd5oTxySkcSBfA/5uRODXDLTInaG2Zd+rV4yZoOyuegxR?=
 =?us-ascii?Q?RzPkjqjekvZDYMzDtxz7EG95JDWv0biicJedMgELTxydCztobCTMQ6xMo6ox?=
 =?us-ascii?Q?kLCNT/V7IuoYeWEYdL3mB/405Uq1inHhXIMpPsOp3YTb7ekB3xWEtJgOY+qN?=
 =?us-ascii?Q?aoTOXAIJdoEvJwPa4XZpDHQhzxCQXwF3H+TCkqSLUJvCXndm3/iWY/j+N2fq?=
 =?us-ascii?Q?/ukbi4aq2JEw9pLkaLwWcyDXm9XvOkrY5zy9?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:33.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab2b301-a54b-4987-fb11-08ddb4e89df8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883

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


