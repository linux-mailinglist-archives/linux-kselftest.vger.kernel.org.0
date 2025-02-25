Return-Path: <linux-kselftest+bounces-27508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC5A44845
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA251885D95
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060D21323D;
	Tue, 25 Feb 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HfAOsLXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC242211719;
	Tue, 25 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504398; cv=fail; b=r0GePpVqRl4ZgIyrGsvRr+lRHO9xDd2F6McxbrBkvGXm/+fucWrCWhKTAwHO4kEKe4ynH29q1NVrhnZgcEnDDaSpwKNHheOHS6omSMjoBRcmhv0YsKJY3xLXFUIH4jjyygJI2h7AdAcCc2ovPA671Shf30nxiLO/DfcgnqUkvqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504398; c=relaxed/simple;
	bh=y9EwuhnZ4+htKahcyfG7QKERsMxBHRmJhcDtCf5qHZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvPJvBiohrx1mFQv1t7ilkYtkYzXsgE66/1hsUCv9b1Q6X09r8YtN4QoIxVTeFjHEnACSHgzIDE7TmE1ryh+xAhxgaj2p7k81OdireLXftcTBbJ2n9t9wOrUD4B3rwfWg7S8GuxvoAKo/ZJeRWXzW/TEzWKqlH5/RzQPzmS37k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HfAOsLXH; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjFR9nw94fmVjU8/TPRMpI+8vJyATH7UyV9Gu2AmU41upCD0mXc2wCOvXAzhkRH/OQPr9qUaIoflQtMey+rsOC8L2Qj8QHbtCNZhQ9qzFh6dK0suEhVB/AkB0TwdhCghTQVpXEcmSWmjVdmAcVQkCSkVMy7veZRi/F51ZjAp7t8Kw5dbQVoY+B3Y2EfbVnZeWMK2DGmYKNZ/g1u0DDHn/ISs6sVz9r8OMmN4vepLwK3yiScKTkTjFvprf7X+rpPeOhZnenUQvteJqBuBm26SY3GL3FjqUkQ7QMWWBeH0PGQGwSYoESCH1pOkM+fiLtnxVy/nvLi41oz15tR7W+oMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1PBtA0nWPMf1GqEAuJn+ZSwJlfKukhl+iKUn1Pwuzk=;
 b=VdOwFMzxKse7bruQiqdyw3r9JlMxTLBe61lFxr8W3BSc8OwPB56UXY//mc2Z087HPlYCAqxWuZgjsDoV2AXfPU3frNwxjqUXtGa3VKztbrYf/wSK5Lq800IKPMuExkrDHIXyzuID+oiud3PP/tV1DwbtmXzuKFr/BciprkoU4USqxxJIWq+F9WjDB2EWQlhPh+op7aZnVUYoGlsdJKfYaqtwlw4jj9PpfQcwMSBXfPSyHYRU8N9FbknTQA3qfeiFozrj8tlGtkg2spKd3MFcqTIKDGTAoBpmZwlL5yyBiklO2xJ+EdS3GuFnQ3yUMq0sEgRf//1BIOw4Blwttm4HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1PBtA0nWPMf1GqEAuJn+ZSwJlfKukhl+iKUn1Pwuzk=;
 b=HfAOsLXHq4Zx9JGlD2cX973OpNg74uLJ4z8blGtwnTaHbyrA1BFvC4zDfTCieNQEU0wKB8abE99v0PFpmwu+scxiuY1aGo886icI5DgJr6Y2jvhpwqVT76mOu5bhZWay3dvchsNdhEYMhrt/KPDulGRL+uXj4v4aFKVfdMbHWPD6V9npVr+oyfWTo5uhwH0VdfWncWdzSQgkuNDsKoRpRdT/kI7k23UZIfQEc7dKuNz0NG9uWqlaueV/U/pY8Zu5FTzUgOLUHtp4xgHUVvNBEXTd4/3tSBiCDoFRbuRk5mpvyXH3MVlj6PSLtVjkORImrfCvMmoPCJOC1trkaNG6OQ==
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:26:33 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::d2) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Tue,
 25 Feb 2025 17:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 08/14] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Tue, 25 Feb 2025 09:25:36 -0800
Message-ID: <037fe78b0de0d6aeece6ded3a384cdd0ef8f0d3d.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f3c410-7d01-47e3-16be-08dd55c18c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFD+ZbgthvXFaImy9LkFShc26TgJcEpOHh0tZL0uRBf/PFPiNCjRSLLW8k8w?=
 =?us-ascii?Q?fkm8duDKyjZ0oT0EAqqle/6K3anHLG7N0NLlL5XqaGKH6dMGBCH6a2v95Apd?=
 =?us-ascii?Q?tluK5a8bwbS0PQVA5NckvU7WebaaI343EdxX7WtYaylDPTKsJCcmczLhWaEU?=
 =?us-ascii?Q?fcBqiiItoJlPjvqYn2g+H/B0QkkYstVzi4GzMUh5PA6y/rs35RfhXAdO5J7b?=
 =?us-ascii?Q?/fVuBcrmoginU3lMfWj+237OmzUZ3mz3wcenpDtnVMJzQrXvDvxWPut1nP9r?=
 =?us-ascii?Q?mNBrEegsuV5PlEysBLXgMondh9QHoE8hYL7wimVW+y2p9ZU3nJF+Y8hJFqoj?=
 =?us-ascii?Q?TRKY/I6v/rrmcg8dDlbneaboidU0JQELsBKClCBVk4wVK7k0Vktd6VktSe8Y?=
 =?us-ascii?Q?dvFERBNbI8bbI107o7vp4yfKlVY9oFJb54rCuGwDbhvBvXXN3O9kFaLsb23B?=
 =?us-ascii?Q?vlg62tLziLas3arSmy7aY2rquibHbbEhRCCEd6logOWOSwnP5d6oaKSrDwHR?=
 =?us-ascii?Q?tiT/KMYSX/kCIq+YbaNt3Q1ggPfVkff5zy29Nju/E0bI83UQF1dvU/rsBoC+?=
 =?us-ascii?Q?p14r1ulGQ8tThT0AE5sDZSk72lT2k291sI/dzMvgtHDV7Fl+WqgcDaHaT1OM?=
 =?us-ascii?Q?gRHxpMd1mqGYrqoVfnH5ACG5aGQS44dcSj8x0KPVm9S0mF0ZfsS1t+jbJjHY?=
 =?us-ascii?Q?exM0W33N5oSO2YNzGlYQ4CzSoB9R7O0zHkYX5OVK65/u6/sswvv5UR5JGfU3?=
 =?us-ascii?Q?qn26vwMeUfdiX7E8qqiyz6v+08yHyj0bGppOohoQQNFt8TKIruwyqZnj83mk?=
 =?us-ascii?Q?/HOnQHHSLfE5EHO3PNL0aGNwiO9qSPjtrDj+0a83ACKb3bl/JCfUb2xuh1yi?=
 =?us-ascii?Q?G1rULSWDuG7tLTT5FnkmisZv2BpY1cIA119Tuf3maHLqSP3yS1ryvTRTBDtZ?=
 =?us-ascii?Q?myrSl3GFN7mFQ1IbyVgydSo/DhQ+NhVIFYhmHHAz9WMXKky7ffW0kYhhkVbZ?=
 =?us-ascii?Q?2h5P+INb92yLht0H0B9+8OpuTLTFMFBcInyfe3zID5mSaM1Wl2XaqLZeA6Xg?=
 =?us-ascii?Q?IUR3lxgMZt0oodAPfx7gr80vy3cMDENriXbp//BbdQJ1KFPDl4P4l7TQJ/SR?=
 =?us-ascii?Q?hpAa5gWEijASzBu7aolWatXC+7Y+6XjKuFASx3VVrjpFI5So1TuZs9Kj3MdN?=
 =?us-ascii?Q?YPEK1eUJuzURGUYZBHllvGsKyVWXP4U/4/6yKt96BRvnxddi1Mx5foysi8Tz?=
 =?us-ascii?Q?ghvWYYLTerGMz9e12++tQktv0w8FdJSz+4fCuSgKs07pZKTcRx9Ic+QssxM2?=
 =?us-ascii?Q?yKYG+tdrEZYmkyptuo2hSJ6uOlFNELflQzhhQGUiKQOfBkyGgLqyh1q2Gafo?=
 =?us-ascii?Q?UM9B+pI66wcf9RbfLV6BJx59r3VP8glL+ALv76md7PkJRM7HNNLP46WX6hLa?=
 =?us-ascii?Q?y/mXG5kuB8EMb2Tazz4n+4YeX+XpKxLD36pI+qKMqm9LlxxSdsw0oFX6umYv?=
 =?us-ascii?Q?YMFR8M9t0R5IWeg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:32.8217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f3c410-7d01-47e3-16be-08dd55c18c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

When attaching a device to a vIOMMU-based nested domain, vdev_id must be
present. Add a piece of code hard-requesting it, preparing for a vEVENTQ
support in the following patch. Then, update the TEST_F.

A HWPT-based nested domain will return a NULL new_viommu, thus no such a
vDEVICE requirement.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c        | 24 ++++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..ba84bacbce2e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -161,7 +161,10 @@ enum selftest_obj_type {
 
 struct mock_dev {
 	struct device dev;
+	struct mock_viommu *viommu;
+	struct rw_semaphore viommu_rwsem;
 	unsigned long flags;
+	unsigned long vdev_id;
 	int id;
 	u32 cache[MOCK_DEV_CACHE_NUM];
 };
@@ -193,10 +196,30 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	struct mock_viommu *new_viommu = NULL;
+	unsigned long vdev_id = 0;
+	int rc;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	iommu_group_mutex_assert(dev);
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		new_viommu = to_mock_nested(domain)->mock_viommu;
+		if (new_viommu) {
+			rc = iommufd_viommu_get_vdev_id(&new_viommu->core, dev,
+							&vdev_id);
+			if (rc)
+				return rc;
+		}
+	}
+	if (new_viommu != mdev->viommu) {
+		down_write(&mdev->viommu_rwsem);
+		mdev->viommu = new_viommu;
+		mdev->vdev_id = vdev_id;
+		up_write(&mdev->viommu_rwsem);
+	}
+
 	return 0;
 }
 
@@ -850,6 +873,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	if (!mdev)
 		return ERR_PTR(-ENOMEM);
 
+	init_rwsem(&mdev->viommu_rwsem);
 	device_initialize(&mdev->dev);
 	mdev->flags = dev_flags;
 	mdev->dev.release = mock_dev_release;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999d..212e5d62e13d 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2736,6 +2736,7 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t iopf_hwpt_id;
 	uint32_t fault_id;
 	uint32_t fault_fd;
+	uint32_t vdev_id;
 
 	if (self->device_id) {
 		test_ioctl_fault_alloc(&fault_id, &fault_fd);
@@ -2752,6 +2753,10 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
 			sizeof(data));
 
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     iopf_hwpt_id);
+		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
 		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
 		EXPECT_ERRNO(EBUSY,
 			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
-- 
2.43.0


