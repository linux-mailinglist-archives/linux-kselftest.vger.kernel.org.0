Return-Path: <linux-kselftest+bounces-14965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC494B108
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1879F1F241DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE0155A56;
	Wed,  7 Aug 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="It+PJfao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F915535B;
	Wed,  7 Aug 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061507; cv=fail; b=Jx5cPhC+acJpGDrUiLWmLY86v31JxPHDIZgd7xLUfMS1+PJtjFLe6L4ZxV3M8O2ZMeimKSt7LRC9M0Y1uYMskYFk/fIdnmX+WCabEoL9Mh0hpq7h1Wrgkx8TyuvxHhC1nPgkJeX5bOIgKbu9+qu8/2W+77KFsJBt+V+ukQxMLmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061507; c=relaxed/simple;
	bh=b7i6yf0ZMAdTQpxjwdEVwlHkn1L4lxLl0wBUsCjc0EU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN/1c1NyuCaYIxNTM3yF7/AiSlYIAe2rPdO3898kM2s5YGVLJqV6ODNIDLaZmBv7KJVnc75nb2fxbhFvXSXj+fETcR7+AeselTuqDpiRpknHu4ImJJHhEWTpnWYXn/NGYPhdt/YtEsc5eDN+jAkVL1Zm7PZRrur4jLR5FU63eiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=It+PJfao; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSCX8JIjDmtQ6FUq0W7cm/gfYkY9XgSoiQfDwGhtpr5XJDAZMPj2TxFqiDJCXe+iSG5ltKw+961pXmEXveC8tpnIcioDSc8nUblGfweXCI5In46LMDi3W9c5nueMNeOnX19nJAHyj8UP2r3LBDgqQRzOjFZqVkqxtUMUME+1fq98k8vRgPHJbYQE6cwt++Ad4MFlR4cYowQNhcPCWcDkpO1DrKHQpo8DZJe6u3no3dtXzWjCFqs4RL9GGWVCt95E5w16MOhIoYQG09asztA/8UibdlTxGAtGR5SwzHfGxqdBf6llcT16xLYjKL+O3sdJK0XxvPtvrL9v9QS7z1t6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEagwWkHigxjr0995SwXhtPFsE/vSIE4k1B48AEqbRg=;
 b=gxW3WrNVPDM2+o8Lda/Ws2hI0mp+qx+i+znFR412kuqKSJC+ZD7ERWRHumREhkFxZNsJ769oNjvxhSJ/0CHWHyuyrv5g1eg+JUT3jLiLDrAu4QXlREAu0mOck8v4IZdXmnuhV3x8YyO8r4QNw22o5OBlrX2qQWgu5+F0Awa1x9eaYJNNE3He5QaXY5CGBt1ZmVfPzgnCcy9moIh3MfkUh+Mtu12GivcCYU8dY6AjfYBnzqQrHohnrFBy12avB36OAkxDpoSI0awV0pWjn57VbMG5FygAq/jRMHRkdo26FPy3bGlVijozEj/G5CzjKCczfp+KujvZO54tNCX1wX2GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEagwWkHigxjr0995SwXhtPFsE/vSIE4k1B48AEqbRg=;
 b=It+PJfaofea+Jd1eWkQO2VLzKduMUidJdhEBzXja0fm4xX2/iTzlYVd4S106wwtc9kyWlQh3kybXK0JPVxWQPc/Yl1hwx7K4xGVxiPSjlKPMrleK0/4HMnFlm+E1Kd5bY4JNWKYi8CBsAqNtCPV+czZJFKc3piM+V4Fzo0WNIWqFd/johxfIEot3zAw0WiieuhjP7Y45Esu6iq/ytY8hDyMZ8usBdF5qbJkXHLo/V2+0mzmEUq6o7yi4nSpaN3LJm/NijfcrL5VcHBP3eP/Y94DqQj4bggUU3aO8zZPymrJPXNfxmA/1P/QBm7K3NzGP86bVNBnytVrO10SdE+quYg==
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 20:11:41 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::96) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 20:11:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 13/16] iommufd/viommu: Add iommufd_viommu_to_parent_domain helper
Date: Wed, 7 Aug 2024 13:10:54 -0700
Message-ID: <3d61830fe978e1b5024ce1f36442dcd5ecc03362.1723061378.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0597e5f2-0e1f-4cbb-cc48-08dcb71d26be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYnKRwJ4wRbXPnbqvQoytg5rn6yeD5uzNZxj8qOqJDRJy9NCda08dy892jXK?=
 =?us-ascii?Q?PTSeZ2b860ZhFCI85WdJ3Xu3ckkLJWofwsVAJop4eQVwp4COaKx8uTWnaYh0?=
 =?us-ascii?Q?SdTLaYl+B7As9eQa7Sp+schlrM0tBBpFy+6F4rRLu7p3GKvRuRdplMsCCD7V?=
 =?us-ascii?Q?OvPuln2JxsVcOv4kWAA1+1xLcHmF/7dtYfTHt1Tw7LNKbwnRYpQPy4rPUdiB?=
 =?us-ascii?Q?EAgNB5rPGWpfmFHQu5rsoEJM9ypFRaZu/LX4b7p8GaJQnYmlZaf9+UwD/jlK?=
 =?us-ascii?Q?ERyJrwyRN/JaNTtcHXJ2di6Hr3pgMIayqUac2t2EAGvhtV0aU/YM/LSNJGTU?=
 =?us-ascii?Q?ppXSN7qe887/Nxa2OqaiplTDJNE23LN+V863702kZ/zhbRFHbS3Ox+H80Vsq?=
 =?us-ascii?Q?korm4iHsxFwYdrwp2l2/AIn0rzVxnovxexvN2F/7OeVKhzEIz1hZkeJHEfS5?=
 =?us-ascii?Q?VN8Ddv7QPac1qZ4m1fk2wM0yZdPEQwgegC6MZ9qp7xFnZR3bnlLSKAtsXbZ0?=
 =?us-ascii?Q?aSzhqMRBf/DH9+gunZCi+9ADQQGkNYd47WdyzJJravuAEayFmAAmFM7yrOnz?=
 =?us-ascii?Q?KGxsAo+Br9JhQ2sJuGZc3RrTg27V1cFr+kTpnKcF1P/vYPK1YT0F4/h8oZRy?=
 =?us-ascii?Q?HjgBuI2neq3bV/N+alM+4W3LcSFnT/9wDWiJVWY2z08j/uqLMNpIqvZi24MZ?=
 =?us-ascii?Q?PZ9bug44R5hwVooLN7YKkzysxl+U4zpbHBMh5QaglyUl/QP4D/qbucPA9MOd?=
 =?us-ascii?Q?LN8Ji1mzxDSXwHg6PCiihZBDW9XSzrlwna0ZrcJpDcooF49uhq8pdzTGRZgg?=
 =?us-ascii?Q?EEabO7VZRRW6DCZyKGeXvIjSu34/3n2hRPNpmv/ZD3l0JoZbPX9CKQBWOt5q?=
 =?us-ascii?Q?6GDM0B4s6um9d1R34v1yyU5WslqN55vRvB7w7GxoOyzUZrlDfy6JlOBIXs4X?=
 =?us-ascii?Q?lyOsTXGyqjKqUYHY3D2rtUnb9oSi5oejARjbgkfVAwWGmZx9TnAZv0Sgmuif?=
 =?us-ascii?Q?jdtgFrSYlOzQiNgg0teWWwrSjepFbYKFkXqIzOBYplNUsVWw+VyWO86ZdjnL?=
 =?us-ascii?Q?mfQrUMkBPY8zMe1OWg/JhQ1RVtehwqkVPumKlT6lOYkaXdOLk5AOTfT9IKkU?=
 =?us-ascii?Q?LvC73mx5xLoE1Q8jTmlu2/xn8xSp6mNf1agrYTekHVKBUCOFCfhmqGPAl/mA?=
 =?us-ascii?Q?Afgv817dYDXIPafMduHRFutRhbLVJvh1tvod8VSg3mom35zSukVCXVvnpyHR?=
 =?us-ascii?Q?umjNqYr9tiMMY20HBnZ9wmXVkEaAetPFzYjTfD2ypnfa/t8ABlKE5Fnzv2dM?=
 =?us-ascii?Q?puuRiosw5L0QMJMLnJyJ08N9eDtbXJLJqHyspQfIwPwc0ZoXRlYHCB+KvVqs?=
 =?us-ascii?Q?+p67kNyvFS7za3bvOoCiGSCzCdHPuzUhu7NGMi5QnhaKHfZxl+lPT32gZXT0?=
 =?us-ascii?Q?5gzg7INOhWz7TfTJkoK7ViEnaLrPv80C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:41.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0597e5f2-0e1f-4cbb-cc48-08dcb71d26be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

Allow an IOMMU driver to convert a core-managed viommu to a nested parent
domain for the info that the domain holds.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c | 8 ++++++++
 include/linux/iommufd.h        | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2304f199b033..39a7c04c4132 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -239,3 +239,11 @@ int iommufd_viommu_invalidate(struct iommufd_ucmd *ucmd)
 		return -EFAULT;
 	return rc;
 }
+
+struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
+{
+	if (!viommu || !viommu->hwpt)
+		return NULL;
+	return viommu->hwpt->common.domain;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index e0d7a53acbd5..c0ce12cb1374 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -91,6 +91,8 @@ int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
 struct device *
 iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id);
+struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -137,5 +139,11 @@ iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
 {
 	return NULL;
 }
+
+static inline struct iommu_domain *
+iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.43.0


