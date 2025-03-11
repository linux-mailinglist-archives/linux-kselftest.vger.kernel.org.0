Return-Path: <linux-kselftest+bounces-28773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4375A5CFC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E2E7A73A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5953265601;
	Tue, 11 Mar 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvwT2WZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553826462C;
	Tue, 11 Mar 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722340; cv=fail; b=XDzGcURQIuS6hMAYM+/UTytleCBnvTLZeFrpcSF7uMNfYmf+Yw24tDPqkkgKdz1r14FkCDwFPeEKiQfXT2rMEYrwQb8eCzJJ8Ta1Ezd6d55/sfx/egRLb3KHlOVI8JA6QgKAwOCzY3nMNkdaXeXE//lm/9Pw1paRqxmvB2/6Ys0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722340; c=relaxed/simple;
	bh=RbmqYB3ouXEt01BYZKTJXPb8OVGmtcC88trq8l19SJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKie8HgRuTuplyLFut4l1J9yJ6O3TBGWORPfKZkH5+bFgPEv7C3eYK7hKA4ThKYnxNP5UKqNhfTSFQBTZY7xNql8wJFrZhDhA7EOStrkxh13Qnh0nXA6l2gUODf93l0gFL0jdIkovYw8GIlEECPl0NkOj+wOLVjyph7ejJ8W3hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvwT2WZe; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYFo9LfwYbjPWQn1JBUJfqaZkyhGKQsqNFo6Ciel5iC5PM/yLRjNW+UNN3ZDgaVoXcSWSfajq1MQp8wN3YQsQ6DGTqT69wHjNoCM0qUF7jZiu+oS5Nx218jRVvBVJAHKBm02wD2IERGzR+pkSozapBDaZmGTT2lhVlAyy832RR02odXq1XT/S+DKRLX12IV6f2lrXAxOYSiR2dOq6fbuetrg+mYUNNCvR6ewVW65it8nG2vDYqtPxJDkt3r7+OvBmPRgLD5MiVXSmNCciBHahUWbvayFwbVA7HabzPPTLf+hkFvdubPEtTQSaMjYUWo9kQb1VJbo5fHBc+V/ZkCMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H23MZTa9PfhxhiEvruW5o79lf9Zye7dvmLXJYsQIxuw=;
 b=vbNRznMwqdEhhZbynq/urZQyABvRK3C2WPxFYzw62rUOYr+EG+j+F2a2nk3Sz9zNuiO/lnggLFFsQnD1rLMY+qvKOqCvc79XRG775isHeQjR12a0qaboAwBh4Td8rkk7sU/lfmxk3Tw2DulSGTQ6nX9iETTILRqsVqw/MEAPm9RUbE+rHN47YbOKEm/OwKkhRe9JNdnPIv136M0Iqds2Qc/A4Ly1TsyFC4H8g6qsi+vTTtgBzQBVfaj+q1ozNDLNKvMYLNFo1/n5ClRQ9tYjpX683UYZ6ss7Vph0fXa+PRSttH3IAVFPMtfY3Rr1Ef4a2N7QJrMydjxqgJsJ6ThldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H23MZTa9PfhxhiEvruW5o79lf9Zye7dvmLXJYsQIxuw=;
 b=SvwT2WZebqX7O0lZ6YmgbdolWIzf625gVNkGHez6Ew/F+DkzGDeXMnfUnCv0CCEaXtvAPr4PvruX+CRltEMrcViMvmtNZEo8JEscx3jQl+uIy1c9YQXeFJQwsIi0WNL8BRKWIcJZWSyVRw2WPB8nJNFUWESI+EAy2dcykV2awpdghbCcH2a1hsEJXRUgTTBPVt2zt4GsBiUAFipNmiHw0IR+TSdgRKERJiniQPcB8plI4pV2GxkB4bhJCMlwgRmDkUCj3d5vLgEi8lMyfbyN7c5AvcTR21ixELWZozr74XbPLnYg5xfCnG+nCgTOVGtwcbDRYNlAgOppVHiw3GfHWA==
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:33 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::cd) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 19:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v9 09/14] iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Date: Tue, 11 Mar 2025 12:44:27 -0700
Message-ID: <1ea874d20e56d65e7cfd6e0e8e01bd3dbd038761.1741719725.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741719725.git.nicolinc@nvidia.com>
References: <cover.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: baab3fae-4118-406a-90a4-08dd60d54971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yzFdU27NVVlxnl3hkNV6SpA5xNAHTjjCwBoCpXujbvTINulfwDIW6PpW2pN?=
 =?us-ascii?Q?1lZ0Uk2aMYaXSo8uGLxSL/MMVZ6qPyBZNaE+sm2nSozgusJXcg7SEnKzHjeq?=
 =?us-ascii?Q?6PlVqRBj7NE7RQvAk3Hc6rFvdnI8x52UJ7AMlkQgryBrbpxpDXHmfBeVIYTU?=
 =?us-ascii?Q?yzV2M9I9kfa8qyZppG7zKUjhgS+I8egNpEyDsq6iw+Avdr0yoDCFKSivoSyt?=
 =?us-ascii?Q?2U08+a4daIHZs2yM5ow9aOeDz8y7MQa6uHwpH8SgDW6LqN5Biz/S1EGBr7OD?=
 =?us-ascii?Q?5LbA3g/BVAC7Z0OrN3Uv7w8xwWJlc22zt+8sRgvUW2fJdDfsN/Us9w0KCBXU?=
 =?us-ascii?Q?8zEDS+SywSkgAW8JQ8Sk9oToezHAClI1s3zpPt04P0XgzJcQ7eCRQaxJxH80?=
 =?us-ascii?Q?uCl3358OcrcJmoB2c/TwVX66YbY0XQIo/YPTBjSyDHGz9KuQYn2y+RpQGKtA?=
 =?us-ascii?Q?CS2+rh8aUp1F6PbEvrNui5qDd7FXsG16zQx9XNSOcTebyCl2iUnyAVzEo3bf?=
 =?us-ascii?Q?pAva0+OJFzKAsNH5bEpa7Vg0WsuvNNjj5tFFgG4t5AKREKjOqPsLezwtSsGA?=
 =?us-ascii?Q?L6YPEjGOmRE3XFH+9ReqyL1jaNCYaMyPpvNyPgidOhQpYU82RydZxE7P641G?=
 =?us-ascii?Q?GQhlwsE/HBOiGybFDg+tqOXoyBxfgtQZ4l4s8387sa2APA7ldRvZ+CccQ2AJ?=
 =?us-ascii?Q?bXWWgJ6lyTfh31AD0uvnPzbmc680rPf1KFq5bNfLXU6GCpIETpVWPF4ZWYYn?=
 =?us-ascii?Q?fyXZQdhwf4MBSO/1YQSk5ZhiOmJelsgz7ouABBTv60dHNQbHVkw6F5uUuKa1?=
 =?us-ascii?Q?pFi3TuDX0kfdFvp7inOrfjXButj5TxbAVPWxoo6UGmMM/Yk1BZ3sc8jJq0s2?=
 =?us-ascii?Q?dN64VQmy/3v/nuuTpo+Qf+w2E7TrgUGctz2Jn+pAk3bnm6q3y60Mhar1ADk4?=
 =?us-ascii?Q?xLYFhwm7rv84XkKofdLRN8wzP77+JxjUa3phitBciEdDoEcwJr62ammkd5Gf?=
 =?us-ascii?Q?8Tuk/6cWhKbzC5cvI7d9pka01pAmCQof/dopgU8VtkdQcJvMyHJ+sphiPXdr?=
 =?us-ascii?Q?x+49zm3RSm5reQTHOs3tU5iPZ+X71RDcwu7wMG7v7DRW23LPtk7H6sJvbP+i?=
 =?us-ascii?Q?luf3bW/4K197d938E58Pnf+b49mmbA0Rt9iH2AXflT4AR7Z3Cj8TVRinRdvM?=
 =?us-ascii?Q?L4dJtsuS1qMpIMcgQ7ISO+zr3a+ZMLOcY/OwVyXnh0lpSNy26NbaASpUKVcY?=
 =?us-ascii?Q?KsN3Ccu12u8+JHviFNolhcNc23EbUFvnZNpSXyq33v0DYXqGfUbltsK9UZSx?=
 =?us-ascii?Q?xSU4aw6URLWKnY1w5T7bGsOeIuOOMj0EnxHQDSmsasX+OO+6WyqTEWkXDF6W?=
 =?us-ascii?Q?hWY+Ht/6033IItw543qgU1MH0hsVkPicxiwb25bWN6z+Zj/qYlc92AAMLdpI?=
 =?us-ascii?Q?Qyaw+y445Z/g8d51hgQ7R0trfzw6uqVFLD2J55Nd7wNk3gQi1cx8qOTnZ+y2?=
 =?us-ascii?Q?kuzEpAQXlSeVxPo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:33.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baab3fae-4118-406a-90a4-08dd60d54971
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

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


