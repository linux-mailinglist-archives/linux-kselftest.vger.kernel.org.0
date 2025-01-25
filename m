Return-Path: <linux-kselftest+bounces-25148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4965DA1BFC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD48E16C5E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3FA94A;
	Sat, 25 Jan 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIHdjdcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA969D2B;
	Sat, 25 Jan 2025 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765084; cv=fail; b=BhjfqUN+KFCuukSgSlpSqbiSBdy53j3zN8ybih2fY3ILecf1oJit3ake+ZWWwSBCjrB9rUmY4cbWtf/mg9CkBoZTRPqwiZrue2KJav7cdFIJU5OEwefTwIaFRnaAIpX1WydMtaeXFB5Z58x0yG7GmVxp+3LC2O70zoIC/+eEH3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765084; c=relaxed/simple;
	bh=bZb+7YsvYNVsln6px4bFay7++R1NOEPNLfWOLrYyj7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvr2nfSMqzG5nnQi7UOcx1exw+Sw1e8mMhkYkPtPN1Mo6J1bWUW0MJmZO9qeYK5C62pVC7E830R2S8QYqBKoR3+1eJvt3RfAR3LvEjDE5nQBWPOMSsUaAKIuoypNaapoGEg9uQMcSDYRkSA3Mx8uiWOGIHhe3BTQd3wkVlJvt9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIHdjdcU; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jewx2MvvpSNB39ShGJ82DFfC+Afr0dBjgY99zP60kMcJtilw8MVwzhEgtx/K+ThPzxJiV4JwmnaFjYuZJ4SP0BKZ0UkpzSL3MmhJ1A32YJB1r4V+l9fnltkY5OebbFL318uQ6kCPjYQ6e/I9hN2ZX0Xx/UM4xJSG4kzvhET82KMYqqUjGd+R+rwHqu/dhkYU/Udz7Y8Q7fWsrG/NVpQ1gi6wH0/eJNcnP2kIqrD4tj79zDIHnzScXrBSgOGAiA7Ty2JZBmepNYRnHrqxuxidsUBajEBDZi7iT8Z4yayC93+v6Aa9k4g2W0OOTKyWGLbkYfu+0SvZR6t1hocN2o4VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMwrkE++/+KUx7J8X2xhRHFwVNTxWTYi4ztE5M6avRU=;
 b=y09r9grKMOuWEby0FscfnVMlk4mDSED/XxAA35/brAzy4UDdRjGCwx6dTzh2amBi2hsWTdHVBmjpGNFXycDCBz8oTFGRHZhE4eCfP6jQWdu6cUfNMJaVLZlR1mo72mdzwDhs+QagyIV1e5UMnD2B2nBddEJj4BBxaYt4AAqDXcH5gR59xBYkMITYdPl+HS5nzQeB4r/luew2lbaeJHg9YLhqrAdg9Og7uUj+S7179ANk99NNxn89D4Mih3iVEnc4H/Po4ZQBUj6miY5I5zLpz894FS8oPDuapYOKW2MW0QtPvsyuL3XFTjGxnzH2faS9xlUVuk0VGDTVyx4ny7Gu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMwrkE++/+KUx7J8X2xhRHFwVNTxWTYi4ztE5M6avRU=;
 b=lIHdjdcUPNg6AzV9/GVi4NPmHaFHn9BE8rUBbHj2sEfCP0OfKI98hZq/Byznz3OU/DnIJ+Ijgi/0KKCUe9v7HsdEuUU3mEplhZgqIR8TBWFxmi9UbqLe6u9DjQkEpMBYBcVo+7PLfQHkjQ6H7v6AmV9i3jek4zoDd4OT/f6L3R9ennETv/p5QHcJzrnS0JStNS9vcDRZLpKvfx1ZpyZDr17MH13uTLluwEQbulEpzBWCwvQIwyswiwX4i7lucoS6ibudcg2rKOiFlySl7a0qmIw8nUbvstMjaU8bHyqOZZJ+vsImN3arYTBKKlCGfmyrtEaqwIIgqa1Ch6NheO4lOw==
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sat, 25 Jan
 2025 00:31:17 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::7a) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sat,
 25 Jan 2025 00:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 25 Jan 2025 00:31:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 24 Jan
 2025 16:31:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 24 Jan 2025 16:31:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 24 Jan 2025 16:31:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v6 09/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Date: Fri, 24 Jan 2025 16:30:38 -0800
Message-ID: <0f5250dc0fd17234cce91d45a869c4f8dbace56e.1737754129.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737754129.git.nicolinc@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: d4159c95-de92-440a-bbea-08dd3cd794d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGvYFnQf84j0XOtG7sAtIVK1POliIWyQi8W1fMM8vO60bJMmT2JRdBOg35QT?=
 =?us-ascii?Q?wOljumsoJyQJxytGokQkgKI8UdKMCIi/AKRmFcPpuCKWNkHxgjjZ50SPR/Rf?=
 =?us-ascii?Q?icXI5peaMlay+LjeTNRFg8HZzWd/P/Kd5HwR6xR3eZcTull29E3me8Vayh57?=
 =?us-ascii?Q?J5PCAI2ebAMTGV2advNCLUtfCG1GiN+dCZUYEpQB695l4kHoiU0cUaIS+5z4?=
 =?us-ascii?Q?V5AQcTAt2tSYlAaoX53hO6s9I+RCm3tPzvQFg7vVsqipHj3Y7+3TN87Sh2Zb?=
 =?us-ascii?Q?mhuXG5oivq1ZZOsKuSSiKM690+N5wNsoZUvoSLHRmVOU9A3V7ScCxbZ+mhDn?=
 =?us-ascii?Q?aIqYmd/7nW10RNakU+5YLZjJYXwOuqsD2KKgXclMZSB8UliTNIHkmjzDlsRG?=
 =?us-ascii?Q?fZwKgw2hS54T0JocEtvwCLH9VYPXr18lxDrhxegbq/9UTq9pMNC8zefW0d+A?=
 =?us-ascii?Q?QTNV9RU+ESd2dOaTlj6S7uU3a2beigHe6eviArg2otMEhaSNO9DxfvrPMBql?=
 =?us-ascii?Q?4QTY+sYM+f4ctjAMKODguvEQJcUbRyJgQMTDCuLzMqSJfla3HZd14QGqMopk?=
 =?us-ascii?Q?gbNAvo6sBeLoX7e2hkWvn5CV5E0tE3bf9pesanTT4Zcl+bj5ZjuzEMwfTXIA?=
 =?us-ascii?Q?Yh8mGmERdOCkDYBbvCRadMpAejdvfwnUGF5VbiYjz/dBM57sX1o2opK7vQ7E?=
 =?us-ascii?Q?RPWeb3q18jqVWheGXgbiPM1Getn2cdcwN7Dur+RdyflwamdEzSJ/9+Riww5q?=
 =?us-ascii?Q?KqBd2TC2pM9YGURHt6NzCYNPhzzLgP0+Du0x1waW1XjERtnryelcl7qApFb1?=
 =?us-ascii?Q?mTaEwHSDXtthJxfCnjuITfQOLwJiwmdtroK8ZR74tYQrlkuS3E69DCAZ5APv?=
 =?us-ascii?Q?dEcpxyjGKnsIEA5MXFlfY1UkEBzCJRaMlVIxa9zEA3WUxn0ipebNyV5TzeLz?=
 =?us-ascii?Q?gAeR/m9q7qBYK2eUyb0BbPul4XFvH1yS1n/KNo+iP+oe4XiuKOEUSC3Jyv19?=
 =?us-ascii?Q?F2/FLVB4dKa99zFa2DfuC6sRw3O8NlEQnaBNE+lY0tSzePYKa0zkodjrP6UU?=
 =?us-ascii?Q?+FrbfUDud5abItQJ45YagEqna4HFbd5afy+hgvSQXWCzPouRW/DmjM1ck+J+?=
 =?us-ascii?Q?qN2wuOJKu8axhddW7QuCqgtZIVmH0UhXVN+VrlHSE4P9Ie5vfXP9rCe5kjRH?=
 =?us-ascii?Q?wQCEzoxBmYZtSLAdW7mALtmoYOU0ESvegzIScBaZx3haABf6DwmmRcNU21GL?=
 =?us-ascii?Q?DDnFXBg4EwCuyBZA79Ap2PWVpFDTLzCGTSoAAVTk0ykCo1RjjYq9dbty8QVQ?=
 =?us-ascii?Q?+q3QYLFHlsIBk+R8OIQ71oM6YPwF+x8+f03Uub2esxtrO9OxCUeZn3pafxQ+?=
 =?us-ascii?Q?cTFKUH+oJBLwN2Qvd1+HIcviYitJ5+YyvxhjJba9dK4zT0WcbyFeRYGlVHGN?=
 =?us-ascii?Q?uOhoM3ZZyBV1H6KChbSp8n0qaSLTm8/1UzChkYnSto9h1ThLozP1tgZUPQ3W?=
 =?us-ascii?Q?TTx0kMjp/cxNApg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:31:16.7183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4159c95-de92-440a-bbea-08dd3cd794d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

The handler will get vDEVICE object from the given mdev and convert it to
its per-vIOMMU virtual ID to mimic a real IOMMU driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 10 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 30 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a6b7a163f636..87e9165cea27 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -24,6 +24,7 @@ enum {
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
 	IOMMU_TEST_OP_TRIGGER_IOPF,
 	IOMMU_TEST_OP_DEV_CHECK_CACHE,
+	IOMMU_TEST_OP_TRIGGER_VEVENT,
 };
 
 enum {
@@ -145,6 +146,9 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 cache;
 		} check_dev_cache;
+		struct {
+			__u32 dev_id;
+		} trigger_vevent;
 	};
 	__u32 last;
 };
@@ -212,4 +216,10 @@ struct iommu_viommu_invalidate_selftest {
 	__u32 cache_id;
 };
 
+#define IOMMU_VEVENTQ_TYPE_SELFTEST 0xbeefbeef
+
+struct iommu_viommu_event_selftest {
+	__u32 virt_id;
+};
+
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d786561359c4..0ebaaf795676 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1632,6 +1632,34 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
+static int iommufd_test_trigger_vevent(struct iommufd_ucmd *ucmd,
+				       struct iommu_test_cmd *cmd)
+{
+	struct iommu_viommu_event_selftest test = {};
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+	int rc = -ENOENT;
+
+	idev = iommufd_get_device(ucmd, cmd->trigger_vevent.dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = to_mock_dev(idev->dev);
+
+	down_read(&mdev->viommu_rwsem);
+	if (!mdev->viommu || !mdev->vdev_id)
+		goto out_unlock;
+
+	test.virt_id = mdev->vdev_id;
+	rc = iommufd_viommu_report_event(&mdev->viommu->core,
+					 IOMMU_VEVENTQ_TYPE_SELFTEST, &test,
+					 sizeof(test));
+out_unlock:
+	up_read(&mdev->viommu_rwsem);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = to_selftest_obj(obj);
@@ -1713,6 +1741,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.flags);
 	case IOMMU_TEST_OP_TRIGGER_IOPF:
 		return iommufd_test_trigger_iopf(ucmd, cmd);
+	case IOMMU_TEST_OP_TRIGGER_VEVENT:
+		return iommufd_test_trigger_vevent(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0


