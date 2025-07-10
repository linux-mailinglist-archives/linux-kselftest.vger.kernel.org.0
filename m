Return-Path: <linux-kselftest+bounces-36914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133BAFF8D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AC64E12C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5F28B7C7;
	Thu, 10 Jul 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBSeeVNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED628B504;
	Thu, 10 Jul 2025 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127225; cv=fail; b=YimphnLy/6mhyMOmO+I6XrgDLfAQPp+6Up6aOTr/9zvP6yCc5Obt/jxNV2x2n4veceDGc+o7H+SNE82CfZGB+UXV41zDWSoy1v/kNuJVeUhsBAnnjzhm9NDHPV+k+hsE89nhGqEGB+K6Th9+YrU9ZoKagrVLeDFjaibnqy2zTKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127225; c=relaxed/simple;
	bh=GCfDj+aHZ1YtTPUlVUw0dKbquLyDpDhNCL0s7UaasXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtyqTjMQccDvWNw/e4xxUI8OYe28lnz++evdQB/KiqfMX4ZJmFWxunU0vhhRykTi9yeu3qFaP4ROuDn3F4MYRE6amQQ1LywGLj7sbF0vqq2WZ74p44wv7dZAiE+i1CqxJvo5PbqHIX6nQ2u3w+36R5T3J0IaSpyuMEhvGa3Eh9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBSeeVNL; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgxecabM5pLYWY+LAUQTNrAgVbj9MSQvvXe7vQO9N7XZsGpntgDBaFnJxlqR1QtQk8dhfcRSj3qJiVf8zyBF1u/CRxV+c3Dr7byAR10K9GP4g/5LRq+MXbcd4lbI4zrbqh0HGZWVHO1RzIJX3tPvEenGPypol2MlBatMTKSNKo/fkTIBc16YcnSqL7g1crpPbRiyQpuDzZLoMnL7BewwJqcRjfKkULX5yGHQIiHfnTI70mG6OLhudIHytw8AgxhGWz+98jGrVUqcgF3Ipf52uQeSRgKPgpCO6yaU+ph9liDcyFBlb2zmzjYKII3o+Ak+QsaTzktiOpdnl7UFURFZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdFFe9ZPEIG2FwgA8jVbPH7of1U/Mmj2C8zx4xULCtw=;
 b=lC8QlCBOBfgiTrA8vKYZM2CEgKZuTpo5uS/Rauv/6JZnibhqJM0JGMEEM/nvQSuMCHnDlKppVAiTCRouDwHJXqQgLWCu4AqqrGULWuiDm9hrCiAuCECTGebEMgFU9WKfZT2wpdgBoKw3qjTkrBTjrbAiLH6Z+4KxMh1Ze3ozG6TUpePak1ZjeOTuPui3NHySBhQdG3qfFa/7XCLB79MsWPkvv2hdEi9+YjQFWB/KsL9RBOQhcLLJLGxq8pSS9glcTxhPgxs6XgUwnBRCMRr1OyOmnrcjdnqrE6Ft7vjY4k+McU690c9u7ScPNuYkwKRNiv/zYec/H6VT7eHLFzD4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdFFe9ZPEIG2FwgA8jVbPH7of1U/Mmj2C8zx4xULCtw=;
 b=cBSeeVNLH128EdqyOq3909LLLoJjcDWxi0XA7uGT7Ghz5JjjKbPJtXnh/9l20R+8M7Si2oaqrWIO/CXpkDX20b/45MfvoXZ3HEd7n+WAG19SZJ0k0hxoTamqVv+OAxJ5yb7cn4X3rKnxoL1K8170HWwC0ocKmJah1BF01QWFWNsFXd8Fx27dBuziup+NjWbvku6a0bnFaGZ3sUxH4y7dIC5WIUE1OHOIic+bLp2WQNFfCeZ7EX39ckRhw/N/BC0kDygr4+n884V80QNU4q5RL2TYN+JtA/9u1n3LwE4pNRjAaiGPFCVf9HwS3593OcNZ/q52iXEo7SRv60AZYeyzlQ==
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:19 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::2d) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 10/29] iommufd/access: Add internal APIs for HW queue to use
Date: Wed, 9 Jul 2025 22:59:02 -0700
Message-ID: <d8d84bf99cbebec56034b57b966a3d431385b90d.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa48ba3-e325-48e2-7714-08ddbf770cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBsFEJZhCOLlsmyRRzxBXAhKfKOpfCjqzqkrGpAkL+860hrwFun2EsXAM7IO?=
 =?us-ascii?Q?K2OgjEqEwod1q7YcLbNSVWwaJcoaFakF+CY/i2677CjOPfgUMcGr2I/3LpFC?=
 =?us-ascii?Q?JisGK4XFPP0U2pQ0lRIu7ya0eh5DQfCg/jDC/0sSPd0VggBWTkWVTak3Pqu0?=
 =?us-ascii?Q?cupODcT0tfy3lP7gJwnE0vXUC0L85/zqepdb5mBPzaB2mJxU/5xng15ogCTJ?=
 =?us-ascii?Q?tnWzROj5eY1+kcEe6vP5/kNj1AwX9Jucaqx4Ou8c1fnkuXtvfmUt2fJK4BQl?=
 =?us-ascii?Q?uAOC45g0ugkgjXm5klRiQgW1wT+PxpNzTwpyyLddaz8q3C0a/JVPXbqTbUcP?=
 =?us-ascii?Q?zsLsdbzr2YreF5IqnQ97TNQ9oeoS1cuFSoMP6JjVWv3ivJA8xckLvKgYyyld?=
 =?us-ascii?Q?d54JbkVRVNamDIjCvCUt0XZd7/IGooJUV9IBQIYmniFevnOJVeZvDRhTxds9?=
 =?us-ascii?Q?ha7btH6+k5f5B1onXrcJ3oAE0mSLfP1pJNgJyQYwAnsosUfObfHsqAaPcVhh?=
 =?us-ascii?Q?PEg32p0Ewp+No/gb6ZK/cI6KeAvv4Ronc8DMQbEwzClrF++sSpNTAMOJ3IvI?=
 =?us-ascii?Q?LyuT/vYQi+EW/Vi5ZRLh9U43Y3Edhk9ZUTrSv9uKAsTlG+UQirLXYE85iZ17?=
 =?us-ascii?Q?KMUc4N5YzjITnaW85fAX2A0XKAH0/GS/7LNO/j8XhdFsLkCyQt53Et0r4rur?=
 =?us-ascii?Q?FnniTrdscdPcwiVvm94M1JfTdQb80Bb268XKO/kK3v7sCZAtQ0UbUuFoNHMA?=
 =?us-ascii?Q?hiTncBv50LDyAvWEh7WVL0N/yi7ZNDN2ttCtaceAromRDu6rln5ib/kf/B4j?=
 =?us-ascii?Q?6mSSP+y70vAKsdmYof1D4LpB3oYQFjobbMBKDDeyg316VO2Lrj/JdBq16jKX?=
 =?us-ascii?Q?1rJqd0e58nPVef98qBVaNFx+DskxFkm37g2bNvIqi4nUA6j5p77LpMGK1FyZ?=
 =?us-ascii?Q?Mwc4SgtICFHsTsrAUnvGvA1h6BMC0YMCtGr4A76ZvHgLafUXtzWgvXkCaRrU?=
 =?us-ascii?Q?WMhMC7t5iBnXmHPuKGn0x+/QJkE7q6K1UGoBntsE5lhwRA3GbqIekZFpOZOO?=
 =?us-ascii?Q?0zhHuPfLOEdZAkrz9AsbzQrX1U3p8/eQlyORAOollbJb2iy8WYtYEkFCqT6x?=
 =?us-ascii?Q?n23Q7mxEnrS0lf2sYe1+5rXhxHgkWfm8lkGI19Bfvl/2dC3JcImnYO/Pwwun?=
 =?us-ascii?Q?uwoi+DsCwM8uAhsOTBxDkCxrA2G9wcSvRR0ct9oHukmIcqBthibAcaA6zKcC?=
 =?us-ascii?Q?6C08hU/1UFMs1DfPuNk8Zeesq5VpzfV8KvRyGaUV6vhadpdeIYR75BmW9uZ+?=
 =?us-ascii?Q?sd3kXFr7or77eVoiIlVFgzGSv7Cyqd0pclZQYh6j+BweHSSDbDOug7Fv+Gpv?=
 =?us-ascii?Q?jRNlkVDMRKTnkDg372L8ih1EwDYEga1PUKsttp3uajJ9HFb/qJhMOMYWpn9v?=
 =?us-ascii?Q?CF5DGirOlKVdPL/2ZTplNrhJgRI0xLE+YU9fvyXDDvMigKYLSIWrOy7usACd?=
 =?us-ascii?Q?gc3ps68AsCd5LSOl+Aql450oFOYjPha2uhxZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:19.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa48ba3-e325-48e2-7714-08ddbf770cd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181

The new HW queue object, as an internal iommufd object, wants to reuse the
struct iommufd_access to pin some iova range in the iopt.

However, an access generally takes the refcount of an ictx. So, in such an
internal case, a deadlock could happen when the release of the ictx has to
wait for the release of the access first when releasing a hw_queue object,
which could wait for the release of the ictx that is refcounted:
    ictx --releases--> hw_queue --releases--> access
      ^                                         |
      |_________________releases________________v

To address this, add a set of lightweight internal APIs to unlink the ictx
and the access, i.e. no ictx refcounting by the access:
    ictx --releases--> hw_queue --releases--> access

Then, there's no point in setting the access->ictx. So simply define !ictx
as an flag for an internal use and add an inline helper.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++
 drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 320635a177b7..9fdbf5f21f2e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -484,6 +484,29 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access, u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/* iommufd_access for internal use */
+static inline bool iommufd_access_is_internal(struct iommufd_access *access)
+{
+	return !access->ictx;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx);
+
+static inline void
+iommufd_access_destroy_internal(struct iommufd_ctx *ictx,
+				struct iommufd_access *access)
+{
+	iommufd_object_destroy_user(ictx, &access->obj);
+}
+
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas);
+
+static inline void iommufd_access_detach_internal(struct iommufd_access *access)
+{
+	iommufd_access_detach(access);
+}
+
 struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9b6ca47095c..07a4ff753c12 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 	if (access->ioas)
 		WARN_ON(iommufd_access_change_ioas(access, NULL));
 	mutex_unlock(&access->ioas_lock);
-	iommufd_ctx_put(access->ictx);
+	if (!iommufd_access_is_internal(access))
+		iommufd_ctx_put(access->ictx);
+}
+
+static struct iommufd_access *__iommufd_access_create(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	/*
+	 * There is no uAPI for the access object, but to keep things symmetric
+	 * use the object infrastructure anyhow.
+	 */
+	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	if (IS_ERR(access))
+		return access;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	mutex_init(&access->ioas_lock);
+	return access;
+}
+
+struct iommufd_access *iommufd_access_create_internal(struct iommufd_ctx *ictx)
+{
+	struct iommufd_access *access;
+
+	access = __iommufd_access_create(ictx);
+	if (IS_ERR(access))
+		return access;
+	access->iova_alignment = PAGE_SIZE;
+
+	iommufd_object_finalize(ictx, &access->obj);
+	return access;
 }
 
 /**
@@ -1106,11 +1138,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 {
 	struct iommufd_access *access;
 
-	/*
-	 * There is no uAPI for the access object, but to keep things symmetric
-	 * use the object infrastructure anyhow.
-	 */
-	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	access = __iommufd_access_create(ictx);
 	if (IS_ERR(access))
 		return access;
 
@@ -1122,13 +1150,10 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 	else
 		access->iova_alignment = 1;
 
-	/* The calling driver is a user until iommufd_access_destroy() */
-	refcount_inc(&access->obj.users);
 	access->ictx = ictx;
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	*id = access->obj.id;
-	mutex_init(&access->ioas_lock);
 	return access;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, "IOMMUFD");
@@ -1173,6 +1198,22 @@ int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_attach, "IOMMUFD");
 
+int iommufd_access_attach_internal(struct iommufd_access *access,
+				   struct iommufd_ioas *ioas)
+{
+	int rc;
+
+	mutex_lock(&access->ioas_lock);
+	if (WARN_ON(access->ioas)) {
+		mutex_unlock(&access->ioas_lock);
+		return -EINVAL;
+	}
+
+	rc = iommufd_access_change_ioas(access, ioas);
+	mutex_unlock(&access->ioas_lock);
+	return rc;
+}
+
 int iommufd_access_replace(struct iommufd_access *access, u32 ioas_id)
 {
 	int rc;
-- 
2.43.0


