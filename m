Return-Path: <linux-kselftest+bounces-32119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7989AA66EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D94A16DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5A27780E;
	Thu,  1 May 2025 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWfM+h73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF8266B7E;
	Thu,  1 May 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140529; cv=fail; b=NQzE3yWicLr0sSc4vHIuvmIAmLucyTF5CqsDlYs89R2+7WZDxLDoipWST83y2Tx47WrNV05uEQuxtBZY/Alw72wtlCgsGyKfDBQ48xTHw4DcO8nsk24uJ63PwqrKbDiAknLZIprr8osAIl4yBhxmLXNTdMAq55FNbPs3VWgcy+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140529; c=relaxed/simple;
	bh=PgWPeXoELgVyf4W116NalOdWG3irwdM4ZZDr/Upu5WY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTgjMxESIQiFDw3V+KeDdW0iE/u9/BreIzbvl/LyShKBiyjBAiRykAQObZgj+yNgXKy8ziR2Befm+HRWwT/0NuiN5EAzz4inkyOGjk7wMvWUM4RPMTgp3uqcyfAfD4tjNtJnWsFImEeE2NaFVck2+7njGDGMUFGxMJqBzvNGgas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWfM+h73; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGaRardgd/MxkHh6UqonmANaT2T6fDQeOPXUyvAmbLewwWr4c5MdSyIptNYfsR4Vb1ZGJGLOb32xFUkVyalxgxTPD8tvVhC/MDM0LAOmKt0ijGn3eDk+LlfEcA4wtoUNaaBL7sHSREcT+vbwMtnqn+HPuccMYCFtpfPHwMdxbqjQvcxOV5fPydoMxvNz8G54n3ZUNSTSqQU074Kd/IDDt/IMzegStNtg0bA7klGKPlO+zGvdDxulW6rS+r+AJj7JaG2tGPM4pqlTEmcCS+17M1BTXDzP0CDDqFuKQJuXf4MTAnnGJ72BMGQFAiyeyNOUieEfJc+0pYJwobiuDVB7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kno55z162vrQiwcGO+RKaMp+3uwc20tmkt0AKWdXqQI=;
 b=sEm4qvSvqGDuUvh/1VDhcJQH5evGApdJng1AXGtnhUfi1bFSUdmQ1HiyUADVGs7nywFVVYI2LEVFjPagjsaayXpAriVgjyNM8NXCwXR8gHeJS6x4okquvN+0ixSzMVCYnmMivDjWpP7ViZdcMKmZz66jLOqrhELsBZA5k6rtXoQFSoJZfLs3E6ZiExF92HtCSMrAwxbe4nofvDGGI4r4slExjWkR/vDyeVFEIC5Z/NP3LIYDS8UORx9W1S3JwmDvH/wt4pf7QGbcwA5K1l8/b47O/WVhYNWE7Jkv1CcXxAHU4TgozbbpUy9KdOs7b1wlGZglo2ZNjOai3a5tQiS9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kno55z162vrQiwcGO+RKaMp+3uwc20tmkt0AKWdXqQI=;
 b=CWfM+h73+6ehAjGdv/fC4A8aiMsqhR4zzG3WW9eUFb+ymmtl/OphTVdDYQBAaOBExsoZLeC9UPFjpTSzFMEqUA77QJRDfEQJ7egSqK1Tbl5dDJfDNwO/0nSDBSzq4o9WSLxJobb6J2mE5QISsH7bMMbrNLiIj9/rZfRu0ZLslHHJ+d+wuQ+mCDfZbbI45u+8ZT6rqsRXhxvFR9iEB7JBJJrzIuyIPxG0/ftnZLJ5dPzSvV3uDG3b3jtnmasWyJ4WrrOY9oH/64diYj7+iWHIRi9fv/j+uQvsuZ3ShFNjuzbomcQa7YXL1PAdq2nQLyqt5A9U1ySgGotDptA5Af24fw==
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 23:02:03 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::83) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 23:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:52 -0700
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
Subject: [PATCH v3 08/23] iommufd/selftest: Add covearge for viommu data
Date: Thu, 1 May 2025 16:01:14 -0700
Message-ID: <2f8bd7facde0b6738ef5ecc81a70ee6f37acb376.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e80dea-6077-43a9-6f3b-08dd89042fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vFl/hDkkgCgjKyF7Xi6UzotkxA0f3M9wQZNM2yZH3mbn91DVuUQEUU3RuIT2?=
 =?us-ascii?Q?0/WByW+f8bmaN2mSKZituTR5EbNbroLmUmJdj/dTMJrmsx7P90ltEIM6ZCHe?=
 =?us-ascii?Q?j7rA9BIch8COC4kLnEgV0OpQuvjW0cY2cDojGSytBgxDRuQsV8NAR+25w4TT?=
 =?us-ascii?Q?cjuwC3dLNzGVE8v0lr7m8OD5B3yLf8BURDEQcQ6vD+gebNDxdpsr63O7dy4+?=
 =?us-ascii?Q?JAzABTQGTgXacxIRdPFvGLUU1Rr3SfwDuRISzQMQxrPrPhH0FFGikLjIyRU5?=
 =?us-ascii?Q?34iRfWQ1wZi/eDxFNwJoJIa0UdW21AyJtfI73nCV7j8IFEBt/siYy4QN3jTd?=
 =?us-ascii?Q?eG17Sg31n/apjr6xG6cKBpZJ8kEYG1aQBBJVhAjgdcAgeyzJSztnhNLGfDtA?=
 =?us-ascii?Q?h7qD1xQUpC6iOAbcG9s2R8M1lOhBsqrTQQbZh1Oouv241A1N2n+nfgZZqUEp?=
 =?us-ascii?Q?2itbH0fjW5f9hHNwqBv+OkewNBSZ7ro4nWGp2b+b6Auz2GiSJZS3i0G8VpHt?=
 =?us-ascii?Q?AuwM6hRbk5YuCyqxeqlqmaIwMDw7X44MkXZ8wnfiEMuUnEuEyNotcvKE09cu?=
 =?us-ascii?Q?trhRa+uNfWsO3+cjtofi02OTdCVBUHGtH+9O4BqSCIuUc22dYoCJBQwq0B8Z?=
 =?us-ascii?Q?BTJuymLEswLtB1EUBPtQFbUWpizoGgOyXVE6ykIay4XjBUuN+Jj/Zh+tgDbK?=
 =?us-ascii?Q?YBlRYoRx894OFRe6h0gzFSUUvtlqMUO0P+UDTo//8Jcd5wcGaA6ZwFKIfutC?=
 =?us-ascii?Q?We3s2kVsvmkZ6m4e9YDiCsFzMM4bxbMkbnckv3Wl39NolV+7zP8z7/93lCIo?=
 =?us-ascii?Q?UJxrdrmy3xReh8IdER/PkRdSkhNkLYBO0+7CEjYanSKZIWniXjCgipSZhf5w?=
 =?us-ascii?Q?5QiaD87SPObvwIkI9OTgOOgLuQJpYRcgTW2KMhYxiELYFcKxkuncv51hujWL?=
 =?us-ascii?Q?almO9GYG8uZRz/Y3gaRV+M3jGER+bYvUGctRL/6Qgt0pHVL3SKUAa/+WEEOS?=
 =?us-ascii?Q?d1fFtW/NMSyfwkOVH0kiwiXkqxILU4lkC6y9DBGRuwNLM8wdniG2EoFZlhSV?=
 =?us-ascii?Q?FzFAjvcRUvoFxVMrdSEebOEB1lUl4mdi4f4JHMy2FPDjjTiYeXfVt1YirDOe?=
 =?us-ascii?Q?/x9wrJAWM72pwtXVPH5k8E9/RWbZpxwY0c5svxe2gimK30uNOrguwTIC3Bpg?=
 =?us-ascii?Q?vAhXBkf6m8L1mIJOeKeJj45nowWup6y+4H1Ae8YSQVOACscHnIw6IjcLovyP?=
 =?us-ascii?Q?NWFFXzTfLW/vqYuv9dCKztuRXa7VIM4BrZkxAsDaIHUl6HM29LWwA88y1qfh?=
 =?us-ascii?Q?J88DHBD8tS92Wp3W/ox2yBDIb16BmfOzD1YL8rB7y2EwbqK6ex8g9SpQjvSF?=
 =?us-ascii?Q?9PaZt8t2A3FlQozXghlzGQsZkGiF6mctq/LPFOyC2SKowvNpNy8i1DlRZUPs?=
 =?us-ascii?Q?KdlVd2bTVHnlpuZd7nGj3QP4i0UcKc9lecIapKNdUDXMMet15lpIH1Cp8NvJ?=
 =?us-ascii?Q?ft7aYWl6yGnkQt3Pz3s+nqvKGluh+EMeQV8Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:03.1862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e80dea-6077-43a9-6f3b-08dd89042fed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD

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


