Return-Path: <linux-kselftest+bounces-27275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F2BA409BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0245E17D426
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC53B20B1F7;
	Sat, 22 Feb 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDKzu3b3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277A20AF85;
	Sat, 22 Feb 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239695; cv=fail; b=H7ASRDyMKpjeAH0DGEMgxm0/AptZ5uokZkkzHjcaWeG+7kfKnBhB+7N8M906Y0baYfTQpRhuvQMa27LQ5DeNWNwg+9MXtjMqq3a7NmAwaQGy/O2HD/xV30dKMxXyMi08nQBjqJOmIaxIpdptg0N4ZHDXLsA2FyRzbNMgxe2ZjKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239695; c=relaxed/simple;
	bh=RbmqYB3ouXEt01BYZKTJXPb8OVGmtcC88trq8l19SJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTixHLTgt14soXUp18sY0j0AHxSBdeL7MAkB75P4Cuit//GgigT9y8+Bv6ue2675bt00ybd/MXoR9ymWLB+kHqgVnw0R7qr+BJ75rNFQ7Pee2tFUFJFuKDspz/au70J448EBiB8t2y6yyRpQf/pv6JlyGpZORdu/qKWTmZz2g+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qDKzu3b3; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk6qCovlAWxP9HT7rKaxCzkNrXexhlbIoPfVyNztzIHY0HW0jEaAzOEc4kSMxETCZ9/zCHm0pRmdZpB5LmcVs/WPiae0mMwJu5Jk5I+dfN1lfcoZ+p2BC6+R9XWe4Trdm7Uvp7qr/ivKRpgIz9GUMZSinrnlqpoX9ELkhW3FKIa1bx32Jz3OZKZkgXvOBoUzp88bqyNznvQmZuRFQCX72qWgGbhDbPhIMW9MRtS0vIuoMkw5by38Rdro35v4CPJFaUKrusazlTJDtC8ZoWxXBv5A1A9RWlvDVff4CTcTPK2tiD4SWw04uEanxPFvxFl9be+0QvQlp/bS/IbZIFRBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H23MZTa9PfhxhiEvruW5o79lf9Zye7dvmLXJYsQIxuw=;
 b=ld87A5IYB0U5wXP2eNVhk9t3jmRSn1HojCbNmsBA19/C2kkGLvHhGh8tHjPnPupRNIzZyVVlbtvjmAPwXZn4aeUWOr/wA40PrfKswGw+M0rh+4EyEUOs4qmHtFIRk0PK1Wp83/L9HSqKSxSOd2dHUCbrlzbvg+DZzrajQCxPDiDbaC13rxh8xhpFtqU0BLvW7obzgOwmhDe09S2CWjSKs6ayZ0Fp7ixNrZWmiFz184whKXNmz8uWhQd3ys/MMZ0DFks0WZBRMdqO57FSCekve+KX5GM867yEHSN0pZBKVhVBPR3jPWjOExt0PKn+NVu7Eb3aTcCuupphnCQO1z6fcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H23MZTa9PfhxhiEvruW5o79lf9Zye7dvmLXJYsQIxuw=;
 b=qDKzu3b3BDzadU6C4OVLijoeMIZoZb+e7JjnepmuGDfz2etYOJRzrqeOxI4G7LxeXhEsJG/fqQ/YtH8+nSc15Zh1Nh0QlbHiz6MYxV1f8LLEg4k8q0C2VNyOWOVpD66n/gIyfnYFcjvQHFIDyTVOuqE3qoZzc1Eq4rub1G5a2YLmg7qvGilGWk4nRDVklw0qD7+N+Hzyo6p3ttrlUjTQjE7t6AZ7pvSsFfpMqkIsTlQfNnkUm6blLfNGCl/NAl+OsJKGUba2P4f5RprlQ0eE1GScMoF9GkdK8ik8gygMptTWStUNxpi6zu2ZSFcpMMK2qcGJgngkTb1enbMyWa2uSQ==
Received: from SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::9)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 15:54:45 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::91) by SA1P222CA0101.outlook.office365.com
 (2603:10b6:806:35e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Sat,
 22 Feb 2025 15:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:30 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:28 -0800
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
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 09/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Date: Sat, 22 Feb 2025 07:54:06 -0800
Message-ID: <32f3fd6cf4c4a1cb84eaebc599fd401fd9007be6.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 433ab7f6-1972-4287-9227-08dd53593a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVQv5zq7ojvUHBHXRfagm6AyzZ+GbLmpN23mMURJulP3iriwBfXJ5VaJxtXh?=
 =?us-ascii?Q?P2Jd9jGgKn/lufK0AdKFJEbiDvx/J+gm0MAtqYSCR0zLYP14+CI+Y0k5nhd/?=
 =?us-ascii?Q?BKEHIaLtb1Pth+rKHbF+nc6B4He/3QeHFyoU0RVHNouij3xxPlw5blTxM4zH?=
 =?us-ascii?Q?Lko5T9W0yBhxF6o/4Vn8j3O/Ot3MUZlB4F8Tz+7MRpBPshkFX5RFLWYSaVwd?=
 =?us-ascii?Q?6doq5wTwxvBQH0CG1/7bpL5gYeT4aG8lZPvz+ti2dFEDY+7QBDSRRjEn1x/L?=
 =?us-ascii?Q?NUh9yhBQ1je53Tnxmq4B+dDsmZUJRXnbpWz02tGAgCqvTc4gXRouUDtzrNwk?=
 =?us-ascii?Q?nUE7I+T+R3NcMOPCZDSpwpjq7mSlbkC2sY2PAzCQacWZVkRXSdG+EXtViAGd?=
 =?us-ascii?Q?BpHAudKiw8sWzxc0GeEh6vRV7+HBJhoQIIolwj+LBqCamosYzQ4Gc0ry+lSj?=
 =?us-ascii?Q?4ZmA+LWlZm/HJdL90ddCzr/aEcK7s7ZbH6T+7XU11Li2xeuc0qtJnNzY06R4?=
 =?us-ascii?Q?osS94Z224kDMO0CkBU1jBa9ewkuf+tYTz8Fa6HrYZ2m0CexIe7gMvjPu0mrH?=
 =?us-ascii?Q?d3TY29frRlwrwuKYs+ROlyYurcpNMLzg2PeuLaT6i7OhV1caOWVKZLyaI+/c?=
 =?us-ascii?Q?nmCQ4MtrxsT7wnJ3xiLoH07fwyfMHcN8aqaKkt3GzEP/WLmEGJAGZXRvopWC?=
 =?us-ascii?Q?MGG0N4iYg+zkECuEXzLkuPQ3BLaBmHvlMGJZ3P86sP1Szvbta7CsuUxG9t7r?=
 =?us-ascii?Q?eRbRNkECPPb/5d84uAYBxiWGN2/l2FtXH37P0bB8h+UkLKDtsLYMDhs3kr0y?=
 =?us-ascii?Q?QG9RxFR7Ob4x2HL97MixXvSJyJXLhvCq1IOBX/7GVAZKcy48UcmxobQeYCbc?=
 =?us-ascii?Q?wgix45ma74xaOtWsNql+r9hydHxnq0CxOLJWYzGQ8Me9yo4vwXjnvrgOxT0u?=
 =?us-ascii?Q?d0nbAI4/mp1jqztUEnzbBnEf7IzSSvi6MDaTkB2+UJZEjhivs5P7mdC2HulF?=
 =?us-ascii?Q?ieoyYh7l6tpG+PgS/+CnA1ZzliJfi1Tv4YzemsiRAUP9yWGwrWAv2WIfnRCZ?=
 =?us-ascii?Q?3YAwm4LBXe0K0mJpIUNGmTwjY88SV7MHzIOT99OIcSTc9i2Pv6nleErZPpAB?=
 =?us-ascii?Q?KMprXYOEOeMrbCp6T69f55kbTBir9tnM28ZeYkLahNMxOJ/iIJVVXjRvQEf+?=
 =?us-ascii?Q?qgEcO2R9TJOsqvozYTzzs98xYpdBBOBC/RuD42zLKJNyjFhHeOXSPotC6JNf?=
 =?us-ascii?Q?KrzAui2TMvmmWP3xyyVSYYlVKXFluvrwMjG8ZvvOKWrtTm7XGqQupPZWvJlj?=
 =?us-ascii?Q?oToOmYH4dckbN6/YvU9obmDApvClr8oJjWBIdMPttvni7x4zg3wpYNZU60vU?=
 =?us-ascii?Q?W6/hHQ3zLhUGbdaDLmVYtk9OL8ev0Xq6M02IduX8lhZpKx8g4ltTLo+YwLFO?=
 =?us-ascii?Q?iIMA5Zo1C4jv2VU/UwThHFUOi6fqnvr8cX6cElPH0km1ZidCE483cnVAZSjP?=
 =?us-ascii?Q?FNVTJoIu5pc8N6U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:45.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433ab7f6-1972-4287-9227-08dd53593a60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

The handler will get vDEVICE object from the given mdev and convert it to
its per-vIOMMU virtual ID to mimic a real IOMMU driver.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index ba84bacbce2e..d55dde28e9bc 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1621,6 +1621,34 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
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
@@ -1702,6 +1730,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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


