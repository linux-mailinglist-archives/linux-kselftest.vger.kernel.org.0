Return-Path: <linux-kselftest+bounces-14955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40394B0F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FAB1C2184A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFF14600D;
	Wed,  7 Aug 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ip4L2Ti2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12B145B03;
	Wed,  7 Aug 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061493; cv=fail; b=ne73F9hvtn6c+P6SMigIPKzUr1Jvd2PoaoiqRe5lkAUprCMBQSOuiSN1hRM4shIs/18lNkrjYVuVitGlS6MdxaMs7zioJW9N3KuGDNf5CK0YG+pcOcdAZNqZ0YQ/kucw88eX54W9XAkbARayesxtZLoGMMHoreKgYKiscC4fndA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061493; c=relaxed/simple;
	bh=V4HN4aRZY5N2Mq17MwP2I2BipveU9v94uR8CetqgcDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ur4hyhpwNT5Lpr2R1UzpCx/F+JXYPd1BNf5X0wW9DcuGelJF2WEUZhqH0t4H08kkcdH+VMBeEwI/QE3bGdKjqtA94I11mc/+EtY5FqyPmXCr+pMqOqHJt1nkwrmL7wHBVbNPkB+6gbZAf7pEc9xgha0ed+II83GY8yu0RXiTKNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ip4L2Ti2; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHL+1+KUKUywUv9wX+qCLr50C7E00AYsDC4Psnh+Y9pXZgg9rdaUMHPoxcbITOzyfCnHViXvTfN7QqBIN729w3HBegrVx2zQYzgAk21gm3c14AYZqkV0APtH0CL0d/WaB72koOIzwoW2aStGw+F4uZ2cpRCyRJ5dkbAoXvYp3c2T2rDcDVL/0d1htSkJMU7LJ4do31QmWE44Odo7m6pFfWJ91CavON4OhezWsFLSWZ4hp418BZKuYI2/qUWFFLW77uFmOWhIsdNbqebrWhJx9lrxRtBHfZXLETkI38tY53thsRn/F6Rd8V3+0aGGsbES67jqLD2vvRpK9vUFUd6viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aQWktePkOW4o78zFKMWXR88Zqd2sc4/zCRsO6x5eI8=;
 b=dfNu8FekFL1DjiZljfM1nmH4Om8/QQS7zEJsWXhyKN4paxXwKNBrWaE7tc/gEckFG3ZXv7+pQuw/7rgJDeb/ukml+LpnvIQeC6iLLupO99a8kD6sDU8LugM6wUrDJ7NkN5VGoZBb7091PCuq+RxN9OOqLxZfV8iTCNS1shPqS761sMw9M6a59iUTMRvgC3QxEiTvi81vYJleJJLLpldzifikpKsNw687Bb4UU5rFS0kSjfzbJbvOUV/Dfm5mDuu77fDHcS3X8xOjyTQpKTnCI8Z6XLVUQKT7Nz2seySvVoVcMmZejUEkheXkdgVULJG5YPRzRduNILs8ldDNIHANeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aQWktePkOW4o78zFKMWXR88Zqd2sc4/zCRsO6x5eI8=;
 b=Ip4L2Ti2RkU4Ixfgp5AluWsZexyxbEpkpai9Xw/mH6zVSer14bEW3RB9IucBtok5PmJ6qg518eVWU4KbxSvCoeO94Vv3lw/2teA6B3k55BE/pqL6K/Wj0PKnKHD6Bs2A6/FnZATJV5qRkNxXg6vnK6qq9OGaeU8W1P1wHkrK9Ja6VMfHK+1mEuoEgHw1qab/liovq0ruhSycbMW0ibf3aXaYHz4JQmY4UEvNwvgoDCw7ZYY/qv+T0T2AFFIXC7pEsmuCe1dNrtTNBEUaAH9aF7drMMvwMKnDy8Tp8INYDEOs+3xcHaeduJU2SA/Lo59WO7spDlw/MyandGYGMISfXA==
Received: from BN8PR15CA0054.namprd15.prod.outlook.com (2603:10b6:408:80::31)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 20:11:26 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::cd) by BN8PR15CA0054.outlook.office365.com
 (2603:10b6:408:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 03/16] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Wed, 7 Aug 2024 13:10:44 -0700
Message-ID: <a3c52bc039408987b475e9b911d7e4cf78df563e.1723061378.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d80817-c339-457e-9b59-08dcb71d1de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBlRCTFKKbPctNSvP3WXje2yh/UMMVadIIPYjsFDOPw7sSlOFjfXocvXOUzf?=
 =?us-ascii?Q?QUNKUaCjWNOWnVp+vLMBmFXTd8rxtyC2lSmnxhTI6tVXxsRkjcbXSO7orWKn?=
 =?us-ascii?Q?djjeW6K0+xkyOv9jftwDHua5vq7xfCDdpiAjfZKlbxJOYXQNh7AXRH83b5Bw?=
 =?us-ascii?Q?Nkb1C5x7+I33hwyY23slhoDZ24YjNYMHWgp0KWDb9XTewg+7YLsB8BYhljrI?=
 =?us-ascii?Q?rk7pRKTULcp3/TdQNZogKv1QncOpBPgDp4QZnl7Zfk3qm2U75bQuONsD/xt3?=
 =?us-ascii?Q?71FHjIu7yyuMKaQ/mmH3aBCZYNNyrzFXdChchTWNFAxI+Pk8qzq3ohQ27pYM?=
 =?us-ascii?Q?Qnlub4SMOe+Fv7WTSxBgyPcYeiKVfUAUIotxwRRhdsu23fAK2wnHX/dOUCoR?=
 =?us-ascii?Q?LCFR3bJqEr/0o9ZE3bFRCM1MJaFLkLHCd5elsJGbRXFCI7uG3oT/acv2/s++?=
 =?us-ascii?Q?mkmv+1Hp75eTocgOQjTamckXK9Ah4WOfSKsoniqgbJAhYTWcqMd95IuNTP+N?=
 =?us-ascii?Q?3bdPwhicJnhA3wAdWEx/KjWG2C1k9cAcJoikK2ozVl6mkMdF/OE9AwjuZuIU?=
 =?us-ascii?Q?cqGoULStQYW9cwAR0zYwD5TqFWcYEtBSHdRfzkr7FQ2yFMI5sflIjUA9R3yz?=
 =?us-ascii?Q?Hl3G06KAFMMQctn94DUwSAXMoZx/ex8C1M+pm57g4OppD+qlo/bO2YcD43z3?=
 =?us-ascii?Q?xlFsBsQHf10SihERA42LMqnP1BxUGmGfLQxNilO5tcZ30UtJe3MHfywH9OJh?=
 =?us-ascii?Q?GxENn2N5NjEW3NctBkjue0qO/vJdUNLOHlPwDrkBz3pXKT+Rxn/09U3+a+6B?=
 =?us-ascii?Q?YqXeo8fAh14xv86H9Qy72+f34pBWRhr3xqEpgICvh1yBjcR2PDTOdTyWdv0Q?=
 =?us-ascii?Q?QZ2eNl/7+VWbqIqyXhf2nR6AOyTPG3uVK964Hj67iW89QLKu9RZ+QoBC69aK?=
 =?us-ascii?Q?wDklHDIYQ832xmXqxDblgBA9sUTvIwav7btY6VQ9UXpTaQh/rWH9T9Ume3e/?=
 =?us-ascii?Q?C2jfpreCRqBvD2+5Hxnweh4Q+34Hdohx7w1KHB3n9maajsqeO4EMMTJDtB01?=
 =?us-ascii?Q?f2KbZ9V+9X4205a6BcvrIQoc0ymYh+9UBcF41rm299IbBhtTCwmzY0R6hCCX?=
 =?us-ascii?Q?OBSz8SmJ2TtSujvS38owqQGBUPg2POY0srwsjCTBCh/p5LwRLyivPqswqZSy?=
 =?us-ascii?Q?hIX1VdVb86HgJKHd861YVf1KW4wVNVH53H5TECXmwbvkI16VMq+nCcHNox3N?=
 =?us-ascii?Q?w6LCNKvj510LLr6AI4C0SX8FLYj9Y6MtP5TdTeYg/1FqSqPMjzB+jPYdw0jO?=
 =?us-ascii?Q?8C58V9wjXhT4tewmQ1TRwX7oqkRhbsagRR+V4QJtSVKuVvLZjqnznCZcfN9M?=
 =?us-ascii?Q?I/nWm6rk/klB5FKOW/fK1nkueLV0Uhih4BZkRl2eHBekjacE+JvSuBT5N4rQ?=
 =?us-ascii?Q?NojornAoTpq8rDsxMPxhK5aLb4IpmijO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:26.1348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d80817-c339-457e-9b59-08dcb71d1de4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016

Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
a nested parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, associate a viommu to an allocating nested HWPT.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 24 ++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 12 ++++++------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index c21bb59c4022..06adbcc304bc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,6 +57,9 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
+
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,6 +216,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
  */
 static struct iommufd_hwpt_nested *
 iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
+			  struct iommufd_viommu *viommu,
 			  struct iommufd_hwpt_paging *parent,
 			  struct iommufd_device *idev, u32 flags,
 			  const struct iommu_user_data *user_data)
@@ -234,13 +238,16 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
 
+	if (viommu)
+		refcount_inc(&viommu->obj.users);
+	hwpt_nested->viommu = viommu;
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
 	hwpt->domain = ops->domain_alloc_user(idev->dev,
 					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
 					      parent->common.domain,
-					      NULL, user_data);
+					      viommu, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
 		hwpt->domain = NULL;
@@ -307,7 +314,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		struct iommufd_hwpt_nested *hwpt_nested;
 
 		hwpt_nested = iommufd_hwpt_nested_alloc(
-			ucmd->ictx,
+			ucmd->ictx, NULL,
 			container_of(pt_obj, struct iommufd_hwpt_paging,
 				     common.obj),
 			idev, cmd->flags, &user_data);
@@ -316,6 +323,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		hwpt_nested = iommufd_hwpt_nested_alloc(
+			ucmd->ictx, viommu, viommu->hwpt, idev,
+			cmd->flags, &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0e3755408911..443575fd3dd4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -313,6 +313,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ed6cdc2e0be1..0e384331a9c8 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or VIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -449,11 +449,11 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given VIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
-- 
2.43.0


