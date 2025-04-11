Return-Path: <linux-kselftest+bounces-30510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F864A85469
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199DA17EF99
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5228280A3A;
	Fri, 11 Apr 2025 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQS9Lfax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0F27D79D;
	Fri, 11 Apr 2025 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353522; cv=fail; b=VKyzGKh4D27u3ScYAn6H2nWFPMJb6oqNZteUji5NLT6n4IY+04uV9TXZd68PuliJrN7YWO7kLGe1FcK01WOLBLD2+DzuSdmO80efS3gjG7euhOid/D7d2tEzKukZaOc8A1VEwJt6P9Xq3XW0xO5YNtibcSfsOoO+7l98OgNXJJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353522; c=relaxed/simple;
	bh=ih5xQfYNVNLcqyz7LAcUCbSseJwrZqm5wf+4Z/3I6d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRPm9Gb5ScRHVwZiSuKM2Sk2yGieaGOmUDFzFdkQSh5WALqHoNhteXL6SYf93L5p2seCGLrGozN5uEkss2ZxD7PyhZgIeYEkI8Zg6+kAuM0dxHhvkOTXVT1xl7Mv1vR1dbzcpdIFn6qhhNEDdtYPUp4omHZgEZxmhw+3STCFAfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bQS9Lfax; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcQQEcuJap25r58Y6fXBSepQj6lt2THvs9756nX5K5AIT6wJDATwpZLXwt0SqxKMOeOtCVoP9bt3K0HF6cpj0J34Kl0D9xUPJGHfEpSlPOlu4Hc7jeP3lge2C14Pg2XFPlHSYsvprDb49PFWpLs57pc8HZQdmwjNiJbEJ5wIaFwJzG94c0MiqPf39otJ8fH/ZMiSZltQb/v/DwNjWT5AOJ9jsUV0KxjBEuHLS/i142sOLZvvc1JWjwPm57GMfT0bz39OtfV+My5X8X8rKWd5KmaLxpME2Uwy56i47YSBkWoe6kQyiq/Ab0oyFuQlfVzkrptVO8KfTB5t/m6R4Q+ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnlwdjnjsoFem4jnATOTWF4QhoR+5Xsj/mAgs7LBGBA=;
 b=CDKcb/hoK4tgz+zeO7QjOG/UqPs9biHQ/LpGKI0AbEd2090dYXP3/+gX+mrUa/cCwUgsWvIUHJQtyBxg2Nl4OlHxTsvsleMHWEOAz/9n5IByQtmJxqrTisAHy/nC5j5IifcvSmev0FNySwpYr0myQ4s1guCxLs9bxSnS+mTtQTLLMMVQJePlJ01evvUVLe5XNc4PJJeLmvfunA7Mz3Sc4FmuCzH6ydVmFirbl2i1rkmPMimHR6nmQnWm2WOMkfrBfxfnNr8v85Gev1nbhcbOx3QXJJ/VZ7iDxVY5b7UoaRPy+o94nJNCC+/v/YwHxA39ZBAtqa5kLcRsvNeF4V6k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnlwdjnjsoFem4jnATOTWF4QhoR+5Xsj/mAgs7LBGBA=;
 b=bQS9LfaxuZ0kv8hWPQUlvUh1MIptOH1kZ/wl1f+8OKKElcJy5kS3M3cJBwx1mxpIJ6xARzkffetXxbS8hrLABaosd4oHdt/QwpCO46gvPhflslAEdFZ2IjpUbRSejbTmJSbFSfC+sYvC1VIzeAT35n8zmlRS30bt10XfnKoZRD8kf0pz6s4FjPLOia9+mw2eK5l0AmVrWbIGe+BMG+6atmMfA2NjxGF0ieAxHPSfezNbkpCmGC3nuRdQLCbkSphjn7cY9ihFKjKdFzDg7aLVrcZRCyC8Hwxiu4su3YtGYxhyF5hISRGbXXF2qBq2qyqrwzyxEURS+PKLEuV8THm74Q==
Received: from PH7PR17CA0026.namprd17.prod.outlook.com (2603:10b6:510:323::19)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 06:38:33 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::46) by PH7PR17CA0026.outlook.office365.com
 (2603:10b6:510:323::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Fri,
 11 Apr 2025 06:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 06:38:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 06/16] iommufd/selftest: Add covearge for viommu data
Date: Thu, 10 Apr 2025 23:37:45 -0700
Message-ID: <a73531ef271474f352cb2d7acb87fb9702439a81.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dea0703-23b0-47ee-7c53-08dd78c37a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24jZ88fT00iIO7OkZKhpNYnj/fexHLE5D4I43LKQJomTunLYr8vuL684qDDK?=
 =?us-ascii?Q?KrTANy+tAp4xgCLO/1J89fQWAG33cV1heOQCE3vNmVg7m31seDeEOeaK/sIe?=
 =?us-ascii?Q?QFnwL8JootSpxOuJuc59uMQ7N4cWlf1mjF+xjZtbkk55BVoQqlad0RsF/QPp?=
 =?us-ascii?Q?wckfShktpyWhY2tQlvAF5wNaJ/DNaZKCpsMRvKp30rxTjYbE8qrq9n4lEKv2?=
 =?us-ascii?Q?WLlSECRNSwOIjOkogpSbtuFuwxopoD/NK/s4dVF2MDR+c43/y7azACQtEGME?=
 =?us-ascii?Q?jeOXgbYlJQ1gNl6KWH7t8vAWY07vVMQuceCLewVXcCOooWuA+ppXMKI+mFJ5?=
 =?us-ascii?Q?Kwpu7gbFsKn2o46ipz2qxGca0PKvehJCkzQzXDN9fczZdDcAp8taj1e7doRZ?=
 =?us-ascii?Q?M1G4tTvNGus66XwH807p7H8EPp6zLQeGBRBCR9kr9P1pW6AkRroIe8zg6AWt?=
 =?us-ascii?Q?/K9IDJF+gp0H1kali1jgAj0oxFCKz3I01Up+TSO/aG9K/lt4o2txIggqy24x?=
 =?us-ascii?Q?/PIABziLwY7M1JlrJrVn8CNK97ywvFYrr8DEW73RKOSh0NyKv4ziTuxYs6fm?=
 =?us-ascii?Q?1Kpd1RO//hBEulDUEDbx6MegGQQ8FiHRSEOW1EPXDn9ZAZv8+hFdbdK650pR?=
 =?us-ascii?Q?F1gqK01sr1PfL8u+HZ/hkgYUlthZU2iUBSnP2VxNqhZofRJMv/Jnl4j+ebDL?=
 =?us-ascii?Q?lDivh5DoyiudShpJDT2iHR8vegAbQbF+LFaIyxxLo3qFdyFbl6iMNVhyjTuN?=
 =?us-ascii?Q?mnQdH17GM5C4ho8zAdAxqX5v2b6GTfbROm/8UxHsMFeOTifGsFugnfxImhQZ?=
 =?us-ascii?Q?De7mu3uhqqfq24eCvlZB2GYmE74gLhbIcSDp/SIBMnlJwyhbd+IuWZd6flPQ?=
 =?us-ascii?Q?MygCCm7l5XxCjnl0oz8xZkDwBXNkwPQBEVpgJ1rwx4d6/GBdtNBn4UN29MNc?=
 =?us-ascii?Q?lUrSbqu4qTNUwwOJHWRl+uw6oUZrEXCf6APJHxpEa7m8jWGShXIY3hLfA9mW?=
 =?us-ascii?Q?eyuYSkgPmuWljcxQcI4V+8i2wqK3tNwUIzV1y0OnB/vCZmneJngQOA4u2lUX?=
 =?us-ascii?Q?EbduxXuV03a7vYACAA0T3wbYoaaa5XSvQVsbR78LlQ22KcHAeXar3pc4V8RV?=
 =?us-ascii?Q?Fq8XbvFUl4A/9Vyui+bGOrB5kU9DORF6FAg79NRFPfJpXmgiF8gg9q4Jeb6K?=
 =?us-ascii?Q?5w2BB4HlLyFG5839guM3oVlfUJsCZS9yl5D1pYO9QFfJaQWQb0plSur2rG7J?=
 =?us-ascii?Q?0IqT/7cMbuxdwYMioPYzo6mvgHBn0vgHbQaPnD68KlWDWy8rWL1Cz+QQFhW0?=
 =?us-ascii?Q?/Jo3nfQ3dWv5oxk9tDyXoCjxsz6jLHkAMVF+uTtQu03P/RK5P/1Woejn+Dt1?=
 =?us-ascii?Q?aK4h7m3U7gLDXX9LZpkRXqLFFOp6MpZxWyBpIuOycVIfZf9lMNFbUTenkRgA?=
 =?us-ascii?Q?T4zZ3vSNQV2MQXXhAR+AG9P+KXFJizQXWRW9XA23n07ssoF2uDgUtCB8rzp/?=
 =?us-ascii?Q?r4xNc3Jeyvod3IMt8VB/p1aRj4SIjv9SNcpl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:32.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dea0703-23b0-47ee-7c53-08dd78c37a97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
user data. And add a TEST_F for a loopback test.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++----
 .../selftests/iommu/iommufd_fail_nth.c        |  5 ++--
 3 files changed, 39 insertions(+), 16 deletions(-)

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
index 1a8e85afe9aa..8ebbb7fda02d 100644
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
@@ -3105,7 +3122,7 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 
 	/* Allocate a regular nested hwpt based on viommu */
 	test_cmd_viommu_alloc(self->device_id, parent_hwpt_id,
-			      IOMMU_VIOMMU_TYPE_SELFTEST,
+			      IOMMU_VIOMMU_TYPE_SELFTEST, NULL, 0,
 			      &viommu_id);
 	test_cmd_hwpt_alloc_nested(self->device_id, viommu_id,
 				   IOMMU_HWPT_ALLOC_PASID,
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


