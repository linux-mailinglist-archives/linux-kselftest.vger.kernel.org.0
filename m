Return-Path: <linux-kselftest+bounces-20728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69F9B1376
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200901F22FFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1D21442A;
	Fri, 25 Oct 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+vWR5Uz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207421315D;
	Fri, 25 Oct 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900233; cv=fail; b=ZwyffDxaQyjqhBjeXiWNklmzImUIA88U1UeQojUs6fVhxBeo/8Hq5cwN+n295CuDqi7HqM3y5dsH1B/13ei2RhKGm89qGFPERbgFakrUxhLvefIN1sXyebTm2UEPwMTJgJz0+fDYQN1AQeb+xqn2SC7ALn/jJB8lxBq4iehC97s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900233; c=relaxed/simple;
	bh=YDxGcCDCEm0TfSoNPnbyKtaPR6oaHo8vaMQA9WOGKxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpDomOMXjisiHc2LJRYZmNbo2eDh/emtDFyJP5oQX0J9M+fKr4vzzy5Jx59TCua0ZV16vm2L4I+mk6a1jmGjt544BgAE7hZv3nUnbqO9vDnKTYH4e5gAnN6n4xziZWq+QxKj8yweyJApyWb08VhmEZ8ViKZvMt+7j6WTcQgc6WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+vWR5Uz; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZw3++yTQ/QZbGxsLyXp5yO5o+SsIs2tS3987Ds7kX+O4bJHf9Iv5WwJadQQN2CXyIVj8TxbakM/yQwquyJP60VeYkPalAYeuFABocHAWIIMw/iQowwO9+UYnwe8CSCEIy3w4for3v0k75+Mj06WsIQPJIexRPFfmjgv6lbWjbSBm+zrUOmnw/bqrN4MYe1UtO2HJYUxdeCDKQM9YH0b4+nbomN7uY0qoF+aJmgLT2vUAVE9DKGCWhV3oMRWxvknphpxXpG5M5XcBhKDRRugpt36omXNta7ZSdoVGWLvk2OBpRz/yBoYT0oMG5k9R7GGUugbdmWfqkmwuvaakibE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPI9qB6TcqjtMIeZEoOeZbYLJ2rCz84Ql0z1L/kYQCI=;
 b=HI3NVNzYpYBNipSjdvbdmiXE+kSDOHU2KCok6JJSVjsIemlbkbrtWC8g1xccwUEkI4fw+AiY3jPFmdRUETWBIW4Ds4nTfdJDinul8y3iQDafoKUtz11htqsRDAXxKjgEcstT9tbzWLXTkprqoi4nLdoGkYSdj+4tO1POcQiPk687/BIWyveKnW6bRl2QGWlBEV/sXm2gjv0edDOZnn/+pYJ8XEwwCg90MJI7Kkq0oMEM6lyK66CU+aA4q8dvLHD/xg/HJc2AIC2Q4OR9e+y/ntNtZ+MAZ3hch3TcO8iIYddvwOVbRlfBlneEjqTVb3fHAH2xlkYvZWBCdHQ5wBzvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPI9qB6TcqjtMIeZEoOeZbYLJ2rCz84Ql0z1L/kYQCI=;
 b=p+vWR5UzctyFSXhMSs5gDFQJUAkBNlm7FKzSlDzC+ayj65gLFOrWDO4KLuKYsvChvLiR9ANUBuFGC8Y6fWF4472CLBjj2vp4zbrkOpvwQMmV8/R6R+78O0+/qB6gVXyE6JUiB/xGraoc6g1lL/33z4F4HsDWciAd8aXvZI/NjnwguIa/O596cCenDrJPMVmy+BqskZKQVv9Jf3AMlZZchT305kZFAIpmwEbM9IQzkbyqJGW4IhvEKO3KuB21TkDxwsSKGae3hpr0RWEWTd4az3fDgol69s0ZTihGe3v/iy/IcRd6lmUngS0VZAI0DyRHJG4NX7AGp75FJDqPUvE7LA==
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 23:50:25 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::88) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:13 -0700
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
Subject: [PATCH v5 09/13] iommufd/selftest: Add refcount to mock_iommu_device
Date: Fri, 25 Oct 2024 16:49:49 -0700
Message-ID: <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 34847e4e-5c65-4b12-4456-08dcf54fcc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBdFsn0mpib2luzKRjz6LhRA3iy3WiSPpAoILGZGfn/4yU7Ns6kEZKUC8mbT?=
 =?us-ascii?Q?FoEHn60B8vg7rfCD7PUn6VWbf532Huoday2Kv7haLVCzNf1KaKWN/awaqDx1?=
 =?us-ascii?Q?KboB7ZZ7iuWhwIWqQ7oCa0eH7Z8MxWhjQ+g6WZBguIspABIIgLYrlw0cvdKP?=
 =?us-ascii?Q?Ep1ZEIpKpZsoYpNMxzUSL2w5gmG8ZccgeoLMe4ykCapWvB4TqJ0GkSXhXWfl?=
 =?us-ascii?Q?q2p+mrceGfz92iEjDn5H2fhcxrlgx0ZSSihGKwk/+PJljBrrNJi98D80A3YX?=
 =?us-ascii?Q?w1aWSuSsjSs2loQ0RC1zf8eVVF7IzG9iU6jvUQbF7Yo8slItfBdBTDBUl43f?=
 =?us-ascii?Q?waf1vi/XtlKVLBapzVbv8vfbX1klhZq+bezP0S/yN27TLH3/uDB+mx70Msgd?=
 =?us-ascii?Q?WT/6JLDK6UxAM5vm4w6IkUoXfzR26w2WLEApRtfJsdO9si07tMlZyQBmquLt?=
 =?us-ascii?Q?Vn/0e2OWY/gRC+1slfrO+ifG3kEyuvfPQvaDBhQa7630D1mYbLtnq5ndqgUI?=
 =?us-ascii?Q?sD9F/bdDbowNiGb05Cem0CZ3GsOf7qZa9sfqqftxFr7F4hx83GBq8hOFWyNH?=
 =?us-ascii?Q?V67aGFjtj1/ecfuu3YUkeQqt74MzOOFvXnGicaexwFtM3Uols68Ex5coW5pX?=
 =?us-ascii?Q?oWLHBHD+PmhCe8yY1pPS8YmhUMBdmQXutAzqbI4JitMAH76NFXlcpo4K/eyk?=
 =?us-ascii?Q?LyOKtnZ7y7Brqm8LkL3eJjjNxhHs7jGxA3Y7qQWjbI2GMH2RpSR7HrTsq1ck?=
 =?us-ascii?Q?bc30ngQiIZplmgUV+4Z0n36wMbybLZrUjy8S76L+A0T8LsYFSLES/7ros9wC?=
 =?us-ascii?Q?OVZexUqy0z3jvLMBSqnrNkspLSX5xRb8ClnM4JOIFII6LWG2OBXOsoJA0R/9?=
 =?us-ascii?Q?ILPZgjUixTdXQc45Ub2qHnCZwrAVkO6ySc17lz1LGJuM6YUbV9PtBFg8H9MX?=
 =?us-ascii?Q?xcN8ZqiuiAVOX6UIvCeRHuY4HN4Ym4iNMKmKNCFK6gnVm5pbYh3o/Zzsswii?=
 =?us-ascii?Q?xqXKw+b2JO7VBg/xUrk2kIqF+e5okt1Zu4cKAKoHdn1G7xtUuLRjeV6wontv?=
 =?us-ascii?Q?WMK38pA6jeflB+TDbmZ2dyPMXPByuhJA9ZMJwyAO1Eg7wT6jKKvZfRnPnh/4?=
 =?us-ascii?Q?DJ8GLwrX7N2in3tFXWxPNMPzgrNRCT6JuIPCBamWcRKaitDFS0o1S7JMnX7Y?=
 =?us-ascii?Q?kN975X7P3GEf8cHOp+1S7dbVwozdnlQZIMXSbHRmM87CcqzH1I7IBRF9IUxD?=
 =?us-ascii?Q?V9jrpsD84uDqQiGbePZcUtmIbUOUv/kzy5Y0kifQMVpKt9UXGnR6s2ti7RBg?=
 =?us-ascii?Q?SEOUfliewOBpEbcgkJlqIqkXpe0fJuhRnE4CHxC5Y6Jv6BHd5lP9pEbokdQg?=
 =?us-ascii?Q?t8PPpHBxS7GQGT6o0HdKk1F/o1EgLTXQDPtX02cyh8BzK6cp7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:25.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34847e4e-5c65-4b12-4456-08dcf54fcc32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

For an iommu_dev that can unplug (so far only this selftest does so), the
viommu->iommu_dev pointer has no guarantee of its life cycle after it is
copied from the idev->dev->iommu->iommu_dev.

Track the user count of the iommu_dev. Postpone the exit routine using a
completion, if refcount is unbalanced. The refcount inc/dec will be added
in the following patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 92d753985640..2d33b35da704 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -533,14 +533,17 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iopf_queue *mock_iommu_iopf_queue;
 
-static struct iommu_device mock_iommu_device = {
-};
+static struct mock_iommu_device {
+	struct iommu_device iommu_dev;
+	struct completion complete;
+	refcount_t users;
+} mock_iommu;
 
 static struct iommu_device *mock_probe_device(struct device *dev)
 {
 	if (dev->bus != &iommufd_mock_bus_type.bus)
 		return ERR_PTR(-ENODEV);
-	return &mock_iommu_device;
+	return &mock_iommu.iommu_dev;
 }
 
 static void mock_domain_page_response(struct device *dev, struct iopf_fault *evt,
@@ -1556,24 +1559,27 @@ int __init iommufd_test_init(void)
 	if (rc)
 		goto err_platform;
 
-	rc = iommu_device_sysfs_add(&mock_iommu_device,
+	rc = iommu_device_sysfs_add(&mock_iommu.iommu_dev,
 				    &selftest_iommu_dev->dev, NULL, "%s",
 				    dev_name(&selftest_iommu_dev->dev));
 	if (rc)
 		goto err_bus;
 
-	rc = iommu_device_register_bus(&mock_iommu_device, &mock_ops,
+	rc = iommu_device_register_bus(&mock_iommu.iommu_dev, &mock_ops,
 				  &iommufd_mock_bus_type.bus,
 				  &iommufd_mock_bus_type.nb);
 	if (rc)
 		goto err_sysfs;
 
+	refcount_set(&mock_iommu.users, 1);
+	init_completion(&mock_iommu.complete);
+
 	mock_iommu_iopf_queue = iopf_queue_alloc("mock-iopfq");
 
 	return 0;
 
 err_sysfs:
-	iommu_device_sysfs_remove(&mock_iommu_device);
+	iommu_device_sysfs_remove(&mock_iommu.iommu_dev);
 err_bus:
 	bus_unregister(&iommufd_mock_bus_type.bus);
 err_platform:
@@ -1583,6 +1589,15 @@ int __init iommufd_test_init(void)
 	return rc;
 }
 
+static void iommufd_test_wait_for_users(void)
+{
+	if (refcount_dec_and_test(&mock_iommu.users))
+		return;
+	/* Time out waiting for iommu device user count to become 0 */
+	WARN_ON(!wait_for_completion_timeout(&mock_iommu.complete,
+					     msecs_to_jiffies(10000)));
+}
+
 void iommufd_test_exit(void)
 {
 	if (mock_iommu_iopf_queue) {
@@ -1590,8 +1605,9 @@ void iommufd_test_exit(void)
 		mock_iommu_iopf_queue = NULL;
 	}
 
-	iommu_device_sysfs_remove(&mock_iommu_device);
-	iommu_device_unregister_bus(&mock_iommu_device,
+	iommufd_test_wait_for_users();
+	iommu_device_sysfs_remove(&mock_iommu.iommu_dev);
+	iommu_device_unregister_bus(&mock_iommu.iommu_dev,
 				    &iommufd_mock_bus_type.bus,
 				    &iommufd_mock_bus_type.nb);
 	bus_unregister(&iommufd_mock_bus_type.bus);
-- 
2.43.0


