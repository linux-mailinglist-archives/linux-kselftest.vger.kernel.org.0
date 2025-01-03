Return-Path: <linux-kselftest+bounces-23895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48060A00E95
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD003A39D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB11C3BEF;
	Fri,  3 Jan 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRsQHuqb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C91B4F14;
	Fri,  3 Jan 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933495; cv=fail; b=E07Vo7yecEs6PwIdDTsNctmUSUS4eGSTmlBTOiTBh5FcWulTPDjoL3W7k9AV4rE60Px7W7pP99ByuVBipwv67GQTEaIgdQ6QbL28IMBo+13Nxt3gDZYfNjy+OYQhaO96KaCsGNcsnT4nw8zf+ZaKjTugjWv5WLVarTCMBwWtncs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933495; c=relaxed/simple;
	bh=27NsB8TDVOzDaIg5RV5fodRf07eQWq+k3Yg/KINnkg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca+Jjvr1fBXf96S6fBsZQTno1qv7gVtbmcZN/Skte98p7jb9w64OZVChfzSf9YlM21p3EAbGlYV8q+8yuFt/3f9VRZ4LMa+koqj2K21xbMvh6AOxMqMhkrLMs7thLqg7OqNsiGE3x/MdeAd4hUD9aYcZVv3ccTHlnJE85nU/cos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRsQHuqb; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKDXf9SJxwbygkqpFikc4P6vGFDeeuPGzJDWIUjT/GIscZOoyy5OTjywBnyTaSkZsMeJbxG/Y66JjR4/T/1F1GHeUuxweVCLNDLY2IKE1UCDiUxg4rRb3yEU3TI0jrE/SrkCHmLr+cC/mc+GWn0s34tfZ2mTkBinifBhjRbW3h65e4nlvLriszKOcrILtZBq7YG72ixIIBpNFirtedQDhNgbJ7MkIyYpHFaTr6GPLq6mi9PmS/aZgL+uAHZ0sYbsAFFHberTA3mnvS34iervdvjPPk5Ewo9D+QoW/YHXMFwLLd9SZNGUMhYWl5Wy7lghN5i+Gol3DoEOntRoQelSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jffRvO4oObA1ZjnpZ/XbEvugjl9rVwaoweriqOMxav8=;
 b=k1ku9a3BXY1GBeL2PuyQKtS87UH8ufszXdAwN4095VXpZsMkouLddS6ZiHwxeUIjtxLumF8FIpllO4EEf7AdEBuSsJZJt6jPqn0Wk6s6H2S7XNZN5XBll85O9sRGu51+cAc0POXVHSDqlnDp8R/saykywXz3813ht2fKJ7tEBJr6ecMDSlJvhvdw0sh/5Zu9MBsnSuoY1zXYrfsJTi0xiw4tiv/Y2svod7AAxUNUmpPFVwdMv16ZPna8GTQ/PR1dL9b+RjktJ/sfrbpGehOKaicz8SRa7GjzqnEx3OBAyeZ990DtP9z3G3HC1wXfC3X8cUOquSXerj8QdkW4msZGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jffRvO4oObA1ZjnpZ/XbEvugjl9rVwaoweriqOMxav8=;
 b=JRsQHuqbV2XmsZluGf4iHhzsHsUa3S/x2JdaVsMeOOolhOdJf9w5J3jc/xrG1zLXbHtIVXiXUfvXl4XVHZgxE/5x9zC+olqeCXF6DUEOeaXOsLwXoHIrbPS+FSgzsBvKe0EmArlKkWnQoCD6A+TrErwgFcZaJBfCW1NOd3aDJLZaPuRyAoYPxSuMEdZUraw5pDZvWmpaJaDTb5ujwTMWtJvRG9DQH6LUN/cNnwwkJNpDgjCYnVP4lUe1koZw34LC8NmZ5YJyQfCXlkza1NN4dvsEkYU/Mbagoep2kkadbHDVjWtOPerKM9McejczUOLGeRlEP/OXcRZlUQS8vXWluA==
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 19:44:44 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::23) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.11 via Frontend Transport; Fri,
 3 Jan 2025 19:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Fri, 3 Jan 2025 19:44:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:22 -0800
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
Subject: [PATCH v4 10/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Date: Fri, 3 Jan 2025 11:43:33 -0800
Message-ID: <fb405b99ee86e8251276ad4fe2612c3ef14c1eb0.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 04249f4b-68a7-4e3d-6c60-08dd2c2f12c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhozgeyQ+TpDRdxLNw6p4AERXwWT3QgsQRMNuMz3D8U1oKfQitBjZ+JDGkK0?=
 =?us-ascii?Q?eW/pfXT0tZ8FDGE00CMpLJNxjfj5JijBE1SkKQZadxfkCz0Xxhna5Ql7OOqI?=
 =?us-ascii?Q?Qpvy+fqwd1WUPIu2a9Kge8RWYPCr41jj52uuHFKbnBww7QHTBaA3YU4RJoTp?=
 =?us-ascii?Q?UXbklDYUzRNfSsAiCEncaP4krSatP3XlqRuuhp72wXY8LOcjEtj0qnLVygXJ?=
 =?us-ascii?Q?5uagukA9TBW+fxcxo1FjkDfOh0+IkPddbfYdO6pG28AbeMffwr34eu+hdxF/?=
 =?us-ascii?Q?IS1ZgPshhQFD363Zfxds/Yr0sXFZTL+jgOUQW1rz8oBT8yHOpRpBYHXtogKe?=
 =?us-ascii?Q?hjxq1QJeAyMKK5ytpbvL7cw3sW3sxoD+Yj9YwnvMimVwYWEHtGFPbqnV/W65?=
 =?us-ascii?Q?ziZd+heasQaZ8TgGw34dsOmrY6Lt69Vs75o26rRv5TOcTmKzCMiomM4oVVKc?=
 =?us-ascii?Q?cdoBYA3+AxXi9FZfpz0hqf8YE/HSw6El6slUR4bVhz46GEo1/QYsI1R5BjKU?=
 =?us-ascii?Q?HGYj+uxKe0XcM5lJBgeLQdFe/tWWhmx1XgX4rm+zQUs2DHmUKML8wo4PeMjx?=
 =?us-ascii?Q?1tPf6yTx2VZ9ertZdnawbFXxXj6EhlCzNI/dCGY4o2jsw1WpV8BPLAFxD0A4?=
 =?us-ascii?Q?KsJcldrGgNAhP9bxUvC/NbKYgfavQvtpYguLMp5OxCDNEywMpnesY3dWTdfY?=
 =?us-ascii?Q?ZxyzFTETsV0g+eGeJhJz8sgaS/ktkbttpoWW68jjhngamzvngG41hIv7UMAC?=
 =?us-ascii?Q?h2bCZWdIYeXMj9y4oos9E4hzLeBxVWRNLRCBXXCFuv7gAGxVe/gvJ9mHbpwW?=
 =?us-ascii?Q?vk7jaw6HGpKkasM8GHQFPylzYOrwrXBig3q8lKvMKvGazXeimXZ9mC4VfU55?=
 =?us-ascii?Q?qkI82x/Ua0zDDrQELefc6dviO19WUqhan8NLmqdrJMvLz6toM5AiTunPijsy?=
 =?us-ascii?Q?poMZ1nzReA5/5a3ROv1IVK9hZQxC6lzkONMaC8aCHN1u3AChZZXXmIElmXeV?=
 =?us-ascii?Q?e/jCclRf7UMg/6QfsnJgIpL5AoFwZPBzYFkSO/hxM8R5k7fiT7+63TUBDeCm?=
 =?us-ascii?Q?DOyt+FdY8rwP80dhCHB0KmOoTQWnQ5GD7aWQDgJffyU39q3uZLZxFbxV174o?=
 =?us-ascii?Q?Sc08b+bzv8YcQscPBkYX0Ag0qBZJ7ZxYEF4BL9xk+7eWa9i+dILH6YUKkQZE?=
 =?us-ascii?Q?Jf99FHe/T3ujeLvTtOSXMLW++7No2m9Ken5onvckQh4ti718Qb2mn63TvuEu?=
 =?us-ascii?Q?5GL0ilTasVFZ0LSiSjM7g48mRMdIY95KCw1S9CK/lDuRxvKUH8qkNwhDZIhZ?=
 =?us-ascii?Q?KgpLZQOWP2SQrWshR/XLDUHOnEdlPyxyQTZ99XLaGOzNrhBPunxM9R1Jm5W3?=
 =?us-ascii?Q?B9APseJ8DNLKo58hN6SF7QrezG3TIC7+vPprsU5ZQmDT79OxD7j/FN+Kelue?=
 =?us-ascii?Q?du1GMqsYjdLf6EHfH+dI9wTslF+S+PLTxb2hAfyXzBqi7byTvyfVSJv62rp5?=
 =?us-ascii?Q?dNbduqKSHa8hBkk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:44.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04249f4b-68a7-4e3d-6c60-08dd2c2f12c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406

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


