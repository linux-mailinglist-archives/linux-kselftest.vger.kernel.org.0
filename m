Return-Path: <linux-kselftest+bounces-24021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEAA047CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A431618E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AC1F8670;
	Tue,  7 Jan 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XUhykekp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC901F76DA;
	Tue,  7 Jan 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269883; cv=fail; b=j8eXT8YTQCfZu9TgD/3oLG3YytFNk7zvOzoc/jhqQB/vJ2Fe8GsL+myUK6sEvGOAVtmIsV+e99U6xCb+WswuF/m0nJM8PbfYqeaeMQN/tKqmjcnOKUg4NDomMiMNQjflDGRQJKzUX0iOxC1JgTCBL9g1kyWolJ7gu5JPU/oH+gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269883; c=relaxed/simple;
	bh=27NsB8TDVOzDaIg5RV5fodRf07eQWq+k3Yg/KINnkg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Df50KT7nY4uFffkvVNM3YLzEV6NFVSXL3+9LFOT9rmQDSArqCzi6xYCvIpyAn9oog36sQPeoJZKoG5i3b1h9L2+HBt0tFa/Vg31WAxPhzq2Uy7AKMInIgVe9K7KoxyBd/yCLhI2iqGUKh1EYdWwvYCw25KGRI0E6gTFcld9G9fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XUhykekp; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCvfc1QfB969HmWcD2AdhI+Igi4/kks2PRofiF8jhInbLVTLEreKLYjc0jQlgDiFh7klMun8eOymt85yCogBNoIVIbnDRH9EJBTZ3HDZ1btv23/JRByMi51O4bH8RgwQ7gZUMXlmowRy6esaMg7GUjFdKFsM7gug4vC70+0WHBFnvc1+6BlTrsR7ZtqVGH9NzUusoF9OUM3uFFE8L/xduI/eeSICwj2NyVyw9BRXGxUXasz9ecWSmtkqHIcH7LeHHv7tn2YefqAt7kvFmrde0ibmcI/mNAF+J1pNTqjx93AbxE8ceEV/YNEMLltseQNdnNO5q9Z2W6DKxrD7hLveow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jffRvO4oObA1ZjnpZ/XbEvugjl9rVwaoweriqOMxav8=;
 b=eyNYJm0v4FNT/iauIPJIO6Qj8mAz/bCUlNN5cJ8++JCJJAaztU1rkVhyGn+dDJJrHojS4GElmwjB27to7MxFRhsrl/HRDshmcLFgVDvwU3/OrZwEfOVhp02LBnTYqPXp9QUIFNq6FhflLdCk2CBvBOsNDwhStaGJgp748pxP0yXoXzhj33v7bQNUC4zcfqYmaG/836KlxEFj+0seTwj5uRBKs/96gzjuR7zG51WbAqf/3hmdCGuBifBZgAkg6OiTEd70VB1pzd4nt1aDfTNdRRXP2NwCcNzPMgIfvhUkswESpwIzknhO+seqztyTP9eYM4tKpVeFBcocsePrblI04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jffRvO4oObA1ZjnpZ/XbEvugjl9rVwaoweriqOMxav8=;
 b=XUhykekp4FO5OF3mUhRfKopxfmzBM/fSHvQbzgphEKGLuala5Oqzm+1lA7R7quCjYwPzF5mYBtLjWs7ZCPNdV+yEqa+3MeguheDeE7g8tF0GzePIPNkQTcrB/SoFyEDwewaPLxfvHM5QT3/zsFbD8dfWv/0/0C6wVkkN83xWuJ8crhp4Ld6lyj2veO48ffOHqw7haXsKYBDgn2gsMmobN5V56desowDlgLWQYPD8JKk+OvJ8UCLGTeoZDZ4QCeAEuRaJhN7KvpHTxgMJyzcfb4uqYhRtZgnHLwd4gaMvkiD7nZZgDDkGOC19XBfIxNk5Vo2J0saO+Spmq+8CO2+erA==
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:11:12 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::ab) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Tue, 7 Jan 2025 17:11:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:53 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:50 -0800
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
Subject: [PATCH v5 10/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Date: Tue, 7 Jan 2025 09:10:13 -0800
Message-ID: <c857fc398ae86608ebb7ad1171ca66667ef76c15.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d61a79-1eec-4d4d-44c6-08dd2f3e497d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQu2W5d21bBCp71xNvgVEnHpRZb8tXbRx+uBIoBeh9oV7yOlC7EIFC+yMGam?=
 =?us-ascii?Q?R9BS03E5215NNfvzZHoKOckb5WEb+UQy4VqaK5xpEo1IS0Pb9qOKkz5Jb+BQ?=
 =?us-ascii?Q?q5PcfFYeGjXgI88q0YCnrPQd1xjfZynPPfCcl05sJmq0BM0npigMxU5K8j+5?=
 =?us-ascii?Q?Z2dQvTJC4Mxde7h+/oQ/jpzG5owpRcBX0yuxAoZVZG0sg4rTrP5kat9YsD4Y?=
 =?us-ascii?Q?47waTDB2RWM3/Nq27U/5MQnELU98IGE3HRBotnl42hzSMcIEzEoe1De5/fpC?=
 =?us-ascii?Q?3RxGs75C7m8ccMiZiazQ01T+ymIwbv4yCqxMdfK6cEZ5dbnGFTaBKFkZikgg?=
 =?us-ascii?Q?oduxaUNro8REbnBoNRMZwf3rMIL8Fj/jQHCYpTkKS5vdfODdOsXj1Mxrx6jE?=
 =?us-ascii?Q?gvQqm4JofJ75Ezf+BhzQI881S5NlS5jr2gqdjoJdFdEO7OTfxI1lv+msC40Q?=
 =?us-ascii?Q?KrYgnwpNsvbAEFpnE5oTu6N8ZOFi6NqI26JlBw3B0NTY7h6dkVFTaeWnJADt?=
 =?us-ascii?Q?DpbPcOMyAS0HQbttDv+WcJLUT1l9Rs9mVQ68Yoi1Pb90FtZx4+Od5x7jbrLj?=
 =?us-ascii?Q?NwhitZ9qbN5OioT6fBfkAakI2CKXJgB7bj+ssm0iXLg6/zPUlwgCNQMP4J6J?=
 =?us-ascii?Q?tP2qCN5YXV8VyDIuyN7a9ug4Bt8JrSIkofyR1U2kMRU8fyrZ5UHI4rqPKh0c?=
 =?us-ascii?Q?a6V31mP9AyO12klYlUpz9qETTP0sl2oY4E0DDTZStjzwYQf3yGTpAcgF5z06?=
 =?us-ascii?Q?uginFq/EW7d2yaCflrzB4yAPWVL3t+X7vCn5WXf9+bGLsbfuCblL21fBLzWl?=
 =?us-ascii?Q?4C7nMagtVXU9SgWl7uoiYcpYghzfKYJU++TbZU4yhAUUA9C0beocWSv7Evbj?=
 =?us-ascii?Q?vtaUqQHr5KkToYKrcBY7EVRTkcf8BmzILcYWUkco/6HyAb0bUL7I4g0F+2YS?=
 =?us-ascii?Q?SMlk887Ypzt6kQYKBqbzBYnTusQ0TWkgAWTFhbPFT+e3T/GrAAgWGiCdObO3?=
 =?us-ascii?Q?0yhr02LCSliseDwkgnVWBvee8l/yhE2zI0rT7LZCdV2rF8KJzyfn9uqmPNbY?=
 =?us-ascii?Q?vKKJVAA3R8U6ZUqJcnMhSLfSFfEM+TkJQwqC61JpqFdInwmkXR6R3a0Mhw2l?=
 =?us-ascii?Q?hkbpZd4joGNv+HqyIsA+yMFUNdbuRpCI3yGy32juEnBan/nDo8Yjr4wLkBU+?=
 =?us-ascii?Q?uMNEZ6Z7ECrp/D7bJZZicDz3O4u2thy4J6CN6N9h4f8Z35ecSKCawA1CYDpP?=
 =?us-ascii?Q?+0G5RVRm3eItP8Owgkb7aY2fSZrb9Z5QOTdHTca4Gt930SKt4nJfvr3WMBf7?=
 =?us-ascii?Q?nmuIVkzgfbAvplryTPqq7szrPTsU9U0jqmwSSfVC63PLa7cCQdJvCM9G7S/I?=
 =?us-ascii?Q?aHgM08GMmt24sM9DCznKA/LC9Jdkyf/7zm4pH8tRda/X54NZgGelSr3d7Zx9?=
 =?us-ascii?Q?wHY4UiDQ38o0+U0jbvyTmPKjUmGY+0v1pUNMykY1WH863BPnz5WhuT8ha+VT?=
 =?us-ascii?Q?t1UO4XNAyltaz2M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:11:12.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d61a79-1eec-4d4d-44c6-08dd2f3e497d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

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
index d1438d81e664..7c20a85ed142 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1631,6 +1631,34 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
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
@@ -1712,6 +1740,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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


