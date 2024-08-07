Return-Path: <linux-kselftest+bounces-14960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5815A94B0FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C3F1F24976
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C66149C52;
	Wed,  7 Aug 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTjWHABe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0D148317;
	Wed,  7 Aug 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061499; cv=fail; b=u3r33rlwrguLU2XitE9a5dzVPHnwGaSJQJ9+DZ+x3yax4Tc4oFVW7WGAZaO9oUDjqbZEUhubv1AipPTKBsSG8beC7Pks3OvgrqIPc0IPYOFAUKfmvXFjqUIrPFMtuK5Haou3mIK3T4AL6qeKAHZQoqNUMGiN0KdH8BtfzPUT/wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061499; c=relaxed/simple;
	bh=2fO0QsF51HfZiSI2FYfkZdM9OTGM4XnX400qzs6ujN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp1+F0zEGKiUd34JtX7kpYpgJudDaRbXGN6+tFIJCyeWGirA/Mo2cwOuabTT960Iabd0TZE6ItdHl9XZQtqVeP2+8pXrgdgFN6MKhuTGX3zm6j6DhxbyBFw6rsIawYfxycslZo1YFGEezeW7//On4ZraEU+1WWkoaoCImrWQRyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTjWHABe; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyT5n/qIegXoGRsXq9MA2byIYuLgZB4ymh8Mfd7mkFQLT1jN82E4OtJJ79t5odK5MKacOSjGrOVaFQfNquUzsk/j/j0c+RO8c5Md+tR+dTLl4ivdQTFgHUABIem4O15KhgafflVfTytuuvKmD/W2TeGpkhrDdQhpatsHVO+8c78pOrhXahO5AaQu8MQkfTO5W+o2SH19mJzDWqmpm3/Eti+AlUINOe0Bz8Cwpxh3hfzkrkVAVPrthZSpST3gyHPhcRUfXD7/i/mokcZAx8onVWPI1mYBPxBMhq8Rb05erASp5/uPJDNvMIBguSk9fE2EF8a4oiRZLYVcMlyDusTeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os7gZ54YSo6aStBmNuIepdODOB+OiN1a5hqWeP9if0U=;
 b=gevAAx5BAGsqPnh3UBw75s9RMsp4pHP8oIJMn550Y9GCpaVkIQOliYvKC+IyMNSOyfnR/pPg9E6ao+RVxsmSmYaYFl3HykWZ+VNhcvtjJRNj/mFzw6Eca/hb/9XSl11CdgtxJi8aXD9yfWvNTFq0Mchj1RkHQoF6S2cyuvy+tbhDBd4iBAjLdB/HpsAa7aARmnJ/hX3OWEPYOTVTod/n9osFOrGdKJDTsnU2C5cUwhgOYvZI9k3Ne0kjUAIF1Q+/C5XYtDpJX2upVOKoJQ9dzuMfy1mOJH1KBuRNMjfwHOz/x0zk6swmIzymA68X9Kdcep6ejnWGoL1bZsfUvskOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os7gZ54YSo6aStBmNuIepdODOB+OiN1a5hqWeP9if0U=;
 b=CTjWHABe5LkV6yRRozGfo3zQZfJ5cy9zZqwD1wofPGlQUn6CprzI2gnq8GBOXlYibWkbUKTOuZOZ5YcMGnw7smmX1LYu8ozoWHeWuwiZ3aaYyd/tQvKYfWajKB53Pfe5q979GzmjeFyNmnNVXVxJs4FlrGKtmoqXckX/DY2oeZC5hlgSMxB1tOsPD8X5wR6fauv1fGyw/yairHeqro32mxlV4m/uIipIDpym0lHNeCtvS+NyxKocpetvkUNn/T9tP6bEwzik+6wHTc31+Yrdc0eCFe74hURu93Jdd/MWozk8qsl2+CW834aThZb31ZZBgu50RYpqioQ9/qopKupOdQ==
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 20:11:33 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::53) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 08/16] iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE ioctl
Date: Wed, 7 Aug 2024 13:10:49 -0700
Message-ID: <59ad8c075bfa9de7098fd79a30b51d1f53d61a94.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: f532e0e0-df37-4afb-2a37-08dcb71d2227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ER9rIOvXWCqAn7hIk8oelCDmi1pxY9B9iDlHbeFE2rVNHzNczSZzAjqWU3qi?=
 =?us-ascii?Q?uh4J8kbccOTTuYx1WMDlniDxI68HMzBm9nZmEpSUh3I4gYLRS8GPa7NfQqN+?=
 =?us-ascii?Q?QGXZ7yUcPLaz8T233VNxWULfcovQwgOmdNjHFGzzJvom+CH+qCosZnwbDJFG?=
 =?us-ascii?Q?bTOYChIt760eWtaI7gVpaK6EVgHyUJMme0oIAVDl+IOrBxKmKgIw0LSsrWZV?=
 =?us-ascii?Q?0ydVjiNx34AGa+72Yg1G+Noc24VDzikgmytEJVwTKKQw2+jZIfoU3larCp3W?=
 =?us-ascii?Q?AHWgONG7jrQbYQQpBGuEJPb+OtTSwrxH8qu1F/dhdm2NDFWaOChkO5QDC/7M?=
 =?us-ascii?Q?HlFsMWYj17QqLl52Tvi+Xftl53nvNiHB+Gq2175vf+Mev9vF8TM7pujj5/B+?=
 =?us-ascii?Q?b4cI5iP8QnTap5i/eiLn1GH90HxiijIJ7sZOBoofKgTLwkGfNhFyWc30k/VX?=
 =?us-ascii?Q?SNsd2Xs+fFBkkxHfP9tCuRDCCMTCJZ0GxSDYj4j/oSVL/3qv0I4ACiQW9ZiN?=
 =?us-ascii?Q?e5pzc+GX4M2z47f5CMZ10lKXJBy8R/QojM+jLHdmfnVAubLJvj/rRDIiN5Pf?=
 =?us-ascii?Q?mEq2Ne9OnOriAy4YG1sBVXU1ckaNhEoK9v9LsYPGI+6QaXEgPb6Z2TJID/r3?=
 =?us-ascii?Q?d5E5Jq5vdx0VIsxt+iNdw1k5SQcHq4O9Gbj9Al/PjVlOvXuaFo2+xjV7uchu?=
 =?us-ascii?Q?DlX8sf56fBN8lz7ifSOddmBQHtEFDeXoLPsOizn9aXfNzCs/h74PAQhidrQK?=
 =?us-ascii?Q?hKwArxg8wWZwF5brANN9Pt41zKWgia3cvtOMOaW+0ETANNm0M/t2zJ5/oSkP?=
 =?us-ascii?Q?lO+S6BzfZIDHIU1WPLXEb6h2z8z/V7ZG65FgoMDgkDnrdOwKZGXVtLfDsiMl?=
 =?us-ascii?Q?MQi8fH5o/DQx9rrcB96DXzHc7H3W9HqbY54ExbyhYSlah5aU0sSgr21SIWQs?=
 =?us-ascii?Q?aJZLVOE/cCi3lujNygkDD1QTaV6Oyjw7U+Hb4D+zFI98v6sdVL3NhfqYFAb1?=
 =?us-ascii?Q?0GOEp2GeB8dJbEk7rfKF2za2yXvF06hLXPP2qIoTDSNfyM9TW0V6w5L+l8xu?=
 =?us-ascii?Q?+0zBMAgNsPckyZzgqQjBgfr0IFU3M9vAuFJgqXKFZwEjSZLqgamyfIBw1bIb?=
 =?us-ascii?Q?x6AcJgRVMrtgDSP8+LWNuyE2V7cNyEOD+Ng1qW6Obb0qFQ+3HSmGi3Tgvm0w?=
 =?us-ascii?Q?DeQKDFflcTkQCqD38osEe+HZs5Hqn3YZQXZlZCjKGpk7VhwiYmdcDp4s+n3g?=
 =?us-ascii?Q?04GfCnjE6dYF/YT35FYnQlty69KyaGya8KRoijM2Yw4M4z58lXP6G67fuZ4j?=
 =?us-ascii?Q?zcRLZQnbwUVs0ZGApc9FHeB7jZNHxnVwSfguDUTBtHOQzHllt4/pgsA1hVEA?=
 =?us-ascii?Q?OK4mIR2ubmGC5e6lzwOtJVs6R0I6KEhrqd1tnTE2KbFyfMZsPUcCAPW+/WEN?=
 =?us-ascii?Q?7aBJBIMfZbsciNI+YX3YpFIhYx5jlYk8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:33.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f532e0e0-df37-4afb-2a37-08dcb71d2227
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

Add a new IOMMU_VIOMMU_INVALIDATE ioctl, similar to IOMMU_HWPT_INVALIDATE.
This is used by the user space to flush any IOMMU specific cache that can
be directed using a viommu object.

Add IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 as the initial data type whose
support is in the one of the following patches.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 drivers/iommu/iommufd/viommu.c          | 45 +++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 37 ++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 65023211db47..57c4045f3788 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -561,6 +561,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
 int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd);
+int iommufd_viommu_invalidate(struct iommufd_ucmd *ucmd);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 199ad90fa36b..85d4d01f9ef6 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -334,6 +334,7 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_viommu_invalidate viommu_cache;
 	struct iommu_viommu_set_vdev_id set_vdev_id;
 	struct iommu_viommu_unset_vdev_id unset_vdev_id;
 #ifdef CONFIG_IOMMUFD_TEST
@@ -389,6 +390,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIOMMU_INVALIDATE, iommufd_viommu_invalidate,
+		 struct iommu_viommu_invalidate, entry_num),
 	IOCTL_OP(IOMMU_VIOMMU_SET_VDEV_ID, iommufd_viommu_set_vdev_id,
 		 struct iommu_viommu_set_vdev_id, vdev_id),
 	IOCTL_OP(IOMMU_VIOMMU_UNSET_VDEV_ID, iommufd_viommu_unset_vdev_id,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 209d419fe5cd..ada9f968b9f6 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -194,3 +194,48 @@ int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+int iommufd_viommu_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_invalidate *cmd = ucmd->cmd;
+	struct iommu_user_data_array data_array = {
+		.type = cmd->data_type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.entry_len = cmd->entry_len,
+		.entry_num = cmd->entry_num,
+	};
+	struct iommufd_viommu *viommu;
+	u32 done_num = 0;
+	int rc;
+
+	if (cmd->__reserved) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (cmd->entry_num && (!cmd->data_uptr || !cmd->entry_len)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->cache_invalidate) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	rc = viommu->ops->cache_invalidate(viommu, &data_array);
+
+	done_num = data_array.entry_num;
+
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out:
+	cmd->entry_num = done_num;
+	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
+		return -EFAULT;
+	return rc;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d5e72682ba57..998b3f2cd2b5 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -54,6 +54,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
 	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
+	IOMMUFD_CMD_VIOMMU_INVALIDATE = 0x92,
 };
 
 /**
@@ -946,4 +947,40 @@ struct iommu_viommu_unset_vdev_id {
 	__aligned_u64 vdev_id;
 };
 #define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
+
+/**
+ * enum iommu_viommu_invalidate_data_type - VIOMMU Cache Invalidate Data Type
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
+ */
+enum iommu_viommu_invalidate_data_type {
+	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+};
+
+/**
+ * struct iommu_viommu_invalidate - ioctl(IOMMU_VIOMMU_INVALIDATE)
+ * @size: sizeof(struct iommu_viommu_invalidate)
+ * @viommu_id: viommu ID for cache invalidation
+ * @data_uptr: User pointer to an array of driver-specific viommu cache
+ *             invalidation data
+ * @data_type: One of enum iommu_viommu_invalidate_data_type, defining the data
+ *             type of all the entries in the invalidation request array.
+ * @entry_len: Length (in bytes) of a request entry in the request array
+ * @entry_num: Input the number of cache invalidation requests in the array.
+ *             Output the number of requests successfully handled by kernel.
+ * @__reserved: Must be 0
+ *
+ * Invalidate an iommu HW cache used by a viommu in the user space.
+ * Each ioctl can support one or more cache invalidation requests in the array
+ * that has a total size of @entry_len * @entry_num.
+ */
+struct iommu_viommu_invalidate {
+	__u32 size;
+	__u32 viommu_id;
+	__aligned_u64 data_uptr;
+	__u32 data_type;
+	__u32 entry_len;
+	__u32 entry_num;
+	__u32 __reserved;
+};
+#define IOMMU_VIOMMU_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_INVALIDATE)
 #endif
-- 
2.43.0


