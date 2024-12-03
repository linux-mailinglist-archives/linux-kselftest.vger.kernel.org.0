Return-Path: <linux-kselftest+bounces-22787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA439E2F90
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 00:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AA6B37C32
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E720B7F0;
	Tue,  3 Dec 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSOKOy08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDE20ADF4;
	Tue,  3 Dec 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263867; cv=fail; b=rtRBLvVlQM5/WawQ1LcNO7a4d+ngWhz2eiZA7YG/vIDEs3bY7IxG+bnn9gIW+WW4X6nhN8ImeLAI+OPlgz9+QgFv/fDUqUJb+zH9+5c9pP74ZM5olLbhknAJVxIyVrWY/+U8GyTE4GhljY/VVba7lSXhQDvBALWNeYF4up/F2KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263867; c=relaxed/simple;
	bh=9AC8Rf4fE3NRuwccz07xoV9B5wCWtCUENPR5gcbV8FI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6R03Ng2VrBdcvrc9ivI0+F8svKLePMbSFaJBe94TQKYzLQRdSVaAOxHLh7EnkeKaCxne6Vx/8ckd9jQ39ymRnQqPv4mxT0QhM7TilVDCMOv6knMYFA27REBQZ0YXUH41krCQcWrg/poYP6gsWmRIuuAKChn/BZrRZEQovA1Pms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSOKOy08; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPPHqmqt/tWmLyaq0vHeuna9aulkP/8wjOtv2AsuZZO1Fr6Nxva+1rdqpunK0LahHu26fXLZTzRAa8vJz4DNnJDmE54VgVGB86lq9E+6vQkOHQMCRNK/bxbckQdfGahXJH7XFprw9A/I5fZ+xL+kmsHsd7lHCju/jS+bBxtrjtCgLhnTRjae/N7Pf4R84frnVDLjB3tNDGzx5tgBCBcwkpQEbVueTngQzFXdZjb8iTBAymqJDdQ2imGmyCUiXrPbdJYKOP3HjLYKPl2ySoihrL7o0lpsxyrz5ei+8M5yt02/cHW6kh6QPH60CYj4dHjqGT1UUtLjs7Ixvdja8xAFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLFWnsrYARGfxlSa8XyyJGyfIrvyXtFZaN3aeRVrNxA=;
 b=zA+M93+zV1rWXM/y3bsoYV9+sR9/plg4ztaAGUFkxIs9dF93xzPvGEr5m4PxXS/7OYdArZo6CGTKk8SQDrnbj6GJU5yF8LA1U3oVj5EYX6k+ICHlSU6rYuuoC6o3mhah8b6KQCdU5lWZ0vUMEaLhdaEjMwFTl0kUmMT+cZO7fDkoCaA+kYohgWD46YUJzxP8o7B3ZvQoOw2ZbgkNY1gsM/Tj4ktVadryZZEsgizrvvJMkcl9FnMC74ReLwTIw4BtEyIik3v1qDFwkFUsHV6Y7QjvwWQYxXbjon7fO1EmBMcBBbupdVyMGDHIe5zzIp0zuukaScnCps+6LSAJlBYANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLFWnsrYARGfxlSa8XyyJGyfIrvyXtFZaN3aeRVrNxA=;
 b=GSOKOy08kITQtuNkdb4GsoHFxe53l1SeON+BkDodwy4ddMmgmybcHPx6PCmZY8H1ww96Rko3t6NNFUKh4MDIOqgoA3+ScJxGfXXllSdVBpm9gZtk3KO9zPBEAB7gmr5r+pWVP+xWmL8P5FsSN6nndrkbO0jt9li7PRh4gk3cooqdDbPIY1CqZupJogCbuI9n/Ott++72LmGL+sV7mVKuh9azsIs4sW0PWGWNaeCQ/X+FztypmYZZTjWFKi6CofpFnguNu5kGsZ1076+8nw2Jy1UpHFM6bqsXYMgrAd+N0Na3RJTnu5rpb+0PlDRjb+lx5zgIppoPsQVOpcjAoMeDvQ==
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 22:11:00 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::c5) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 22:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:11:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:43 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 08/13] iommufd/selftest: Require vdev_id when attaching to a nested domain
Date: Tue, 3 Dec 2024 14:10:13 -0800
Message-ID: <cb654aaceb5976ff34b80e3c783182ebd51840d4.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fac7154-1e23-4275-7800-08dd13e75e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMfysyHc6C4zBZm/GUEyo8TJTo3a8Q8/KBlrabBlunfKzxw06tk6YzZKXXUX?=
 =?us-ascii?Q?gbVjjBEm/csBj/rXsdV1ybpzAMqyd7fJfV+bWOjOfnjtlidYwg5ISlOgv9XQ?=
 =?us-ascii?Q?753Fxbzyp3vytICLGpY5FKxrzZ8PXyOyrjqgnNWAFLQyLokikOoFYaDFLJc0?=
 =?us-ascii?Q?S+KGZtnR7Sv2bo+CBpia4oLZG6Xvv7wc6dTEhC5eGwtFF0iD8mpyJzQflucd?=
 =?us-ascii?Q?DQ6ZB9Di02/AG9rnbFACro4KIBTrZXJi8erxrryDmy90UrD0g9YwapQIhnCl?=
 =?us-ascii?Q?J/pqF4o7s/LqQgEjz01DMfnH298hLx7IJEKo13VV5rg6I+ARQaEykNwL8HxZ?=
 =?us-ascii?Q?pq/b/Z8/TQdn1AzPLrnKP2y1MDjHFrwn0iv2YpYKzJUbIQ8v9Z+gYAu6N5g/?=
 =?us-ascii?Q?ZgMVUbIG1/PPXMOdqBzXuJFTIjNbW5pm1JYnjNR31aQQ867xXzN3ENBZ+yh4?=
 =?us-ascii?Q?k8B00ZG6ULei10lQFNDm7rMIcoSnE6ASPFAiHCOKqnB5Cqfz3Su6s4TG70S/?=
 =?us-ascii?Q?QW8UzDgZAAOEZzvw3hTX4LvFjgpbVx9KmUMf3hWyC4d2zkxWVNOKsb11jo86?=
 =?us-ascii?Q?5eihFxOP46JOerJM+CFTgjVylKG0lvkZInD74jlJi+ji4Z13gVScn0dum2ve?=
 =?us-ascii?Q?BJ7E6Y4MqOwJdUY03DbY6QAc1ictfQEY1SEvhIEjInHAlpW61mzvkWnfNGFF?=
 =?us-ascii?Q?aliOpAWN9kIbyaLCjSpux+p/92iil9xxWqUOnDNKgpmfTOh1y/Xc1pNwXR2n?=
 =?us-ascii?Q?5l+F3Dx2wiUIzeXcnAInfE4qQLdaQx+tk8qPsNrnV/2CvAO+vYO2b6ItAPgv?=
 =?us-ascii?Q?mgTDsGR9qKl5jiEsMQg+IxPKzYHYG84awQ8Gw5dbOGfYQSYRdU79XYRZEHjD?=
 =?us-ascii?Q?ce1W7Pu2q8j499mSSC+J25HinwKacKDQNpHiPxkTLdDMShpT5vY85fb1450e?=
 =?us-ascii?Q?mR7ZwTNGcECh8wjahlaRsmAqKNbdAObn/Act8AtJBf8310dS+K/1wRDYExWx?=
 =?us-ascii?Q?B3Gssi+sVdv8fGEDNc39qnaQIxjOciHItWa9v0poTX4H/PuFHFL6LymjIddl?=
 =?us-ascii?Q?sIruDkXwUEqrpLShgigjTBBIE9ox4Yh5UI8Vladt3jWD3icDzJiFhwJa41hZ?=
 =?us-ascii?Q?slC9vW/4Jzoknc6SwGFsSpJ06PGd3adbEhMg0UZugzBugbwGcG9sh6kKmhCm?=
 =?us-ascii?Q?4pSyfZqVbRtRmZ0L4mFS0iIUNC77RwOqg4g6UUJOPuHfg7K0zhkALMLGG/KE?=
 =?us-ascii?Q?7o51cZCYwZ72YxQXPtqZXuN6lisoYXi+YEifryLhtHdTs+cHqixm9buvFlvf?=
 =?us-ascii?Q?q/YDgPy/rG73sHTxZ2Ixd6cG9/HudOUBTneCSh+Iq/2JOkWvQoU0zgMavdjv?=
 =?us-ascii?Q?jeFUrIpZSywauw+CHrHG/Ixq/k/ImxJzFlaZ1PNzOH5Vdo0cErECcPhT+Ysf?=
 =?us-ascii?Q?2KYvcFArU74x+K9EaR8Zouh+nqLWJzCR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:11:00.0172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac7154-1e23-4275-7800-08dd13e75e80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253

When attaching a device to a vIOMMU-based nested domain, vdev_id must be
present. Add a piece of code hard-requesting it, for vIRQ support in the
following patch. Then, update the TEST_F.

A HWPT-based nested domain will return a NULL new_viommu, thus no such a
vDEVICE requirement.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c        | 23 +++++++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a0de6d6d4e68..d1438d81e664 100644
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
@@ -193,10 +196,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
 	struct mock_dev *mdev = to_mock_dev(dev);
+	struct mock_viommu *new_viommu = NULL;
+	unsigned long vdev_id = 0;
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
 
+	iommu_group_mutex_assert(dev);
+	if (domain->type == IOMMU_DOMAIN_NESTED) {
+		new_viommu = to_mock_nested(domain)->mock_viommu;
+		if (new_viommu) {
+			vdev_id = iommufd_viommu_get_vdev_id(&new_viommu->core,
+							     dev);
+			if (!vdev_id)
+				return -ENOENT;
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
 
@@ -861,6 +883,7 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
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


