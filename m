Return-Path: <linux-kselftest+bounces-27266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41463A409A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD7B17A413
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF31E7C3A;
	Sat, 22 Feb 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZUu0XuX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797B1DDA1B;
	Sat, 22 Feb 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239677; cv=fail; b=bTWO/9Wgz4PZzQ+VNIOHqmizithMRyqe0JUNDcPlEOOR9X+OK2NrnNQlLtg5MEywMcg8oc2qvhtMS2Wqh0RyGTjiAysoslImY4I2WMVdEgyq0MCvEZPtyds7mfBHPelVrauMuXu+lgqWBj27EZDYoYz/mgA7W7yJcq391LVclA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239677; c=relaxed/simple;
	bh=wTio0yv2gBQ6U/iSzwRqq4uQ62BJLdo0YHTuy/VvcuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8yiUoDDdNJZfzt4NsdhPfA16RXXwY8Dh9wNxPAAw7qOOiqtgD3iSuJoVXmxPmRapXpo5WRHiMsuxbxoIcxxB3RkvFO0w4U8onNPBM1l/a10X/4HWbu0SFqZVa9tTBSx45Qb3cEdjmrDNIMtAY9aJWI8ogj3YfMOIm5t6n9e5i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZUu0XuX; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmxPLJkjA9NafZBACh6vdpXnNJhuSg2lI/aKCcPDKElJ2pbf8zt9yrjzwTRgrGZ1htmmj8E3mfhEsUvbj8lH0lU6tYb9mzr7dz/hO2dHe2LRwdBMefEVho4Z1N6W2G5ZoORG759Yjdp3p3dIWxjEJxRdOrv5qHEzxhQ1N/FMsU2exOd/NvUpPn7v2YFbfMOLF/kCxZX8iVQ/Nx9CdZuSSomerHa2LFjDJgl5LRXBCT0aidy4800Gvunai8S6NRs38PUqsAOakq3k1ePE4AYlSQ7OMolPeML0qe6/bJIwyo8LioIzn6RvtkJf74kU46LEcXbW6zFbWXo1mToQDqm98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=mIhad3JB2ANzoh+jf0Ri4A/jJxYyu43gp/2b1p/f1z6Tz/IQmkVAw3EfanjHPqreKDf7ZVywXf6dNbJoxRdQ33sXpM6aCdZJub++GVV1vIfHHvJ1kO8pDtBk3IaG7MljgRdCaBADgvk7dNGamrQg0TLXkFgQJQFMgACWIA4OSgde4YdCeYESULy9jyQq5o3GbAalO+lsLThkM3GCSRqMhKUc6JBg3a4tW4rInHrzn8HvkgBtS8KvphdD4fcSKbiNKd/55keqsbXaPzX3ztdj35JNpPeIeWrg8JLuIyl46F8XvWIUcL/Vxq1wOp+Uo54mTJmTwoIimOrDB2SMD869tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=lZUu0XuX+sUo6xzzfoGFHGBZgkSq91ia+WHRFWT/Vq/dSQMa0wV56pDjLrwYkyXI6CELAnVsGxUhfuP7CrJxbig6Gml5QKYWXsahaFIKIoiFm6oilx7+E1Y6UHEQdm+RRrFTf2+pj8NPJMQVdEsw9mXF73EJZoNNfdf2xbZlqMeiaJ3NpnzrI707nxjY7G3lgitqGZzsSYgxNkwR8R1s3nMWhu7Z7iCR5MvvTuMiU2LjYMyTyxxgUNApUuKEwWu1B+r3aiLFQb/YS0JgqNvuiZk69SnzybukmtUgSrXKjcgcLKhKuYZDhrlbR8i03zFMrFSbZWlaTKfsR8vLatC9ww==
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 15:54:25 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::f9) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:16 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:16 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:14 -0800
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
Subject: [PATCH v7 01/14] iommufd/fault: Move two fault functions out of the header
Date: Sat, 22 Feb 2025 07:53:58 -0800
Message-ID: <e87300713163c561580d79f08eb6a89762af4fde.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8191abdb-da61-4281-507f-08dd53592e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M6PSmU9xp3LgCxIuV17O5CcMtn92KB8jfaOtsd0ePq9o/9CGHv5eBoV0g8Wj?=
 =?us-ascii?Q?lU4niPDCaPtIHSleFZkh8qqf+LCF2yubW/S6+1TK4t9XEHd1rwmsmJxHCDzh?=
 =?us-ascii?Q?axYCHvsvI/zg+8giDa5mt0hwWgu8GzVQqZ7t0OEJRs++hxtbO2lAQnHKfzoD?=
 =?us-ascii?Q?Q10PeMcRryliHjAB1XUF++8rkzWebfVYcYgL4WXvmhBXrhNY6XKAHE4nxuu8?=
 =?us-ascii?Q?s/ylxyDHITHfxONvTRZb20qSS7erGxPVrnXvUJZ2msUHBmZuNLGd/napnWwO?=
 =?us-ascii?Q?1oeRPJtRNt9+EQE5VhmcufEU6GVfp1M6tc9T28lXlE5hPgYqyD6OLzqQ781d?=
 =?us-ascii?Q?bCeC7dwrma/z3EjR9cMmGV/vOMebbhb0oRL5GY6XS/ioapqX40fPFIYKc9gl?=
 =?us-ascii?Q?Qtp/mD6bSn2xPQgQxD4K4vdjBZ+Q1sJLqrvo4nF/JEfB1pY0L61Sz9IfHgbZ?=
 =?us-ascii?Q?nv1BYeKI+QfCW1I4mcE3zKh+byYaNes20TqFCOwWZS2NhNuMPVkQGz82k+7i?=
 =?us-ascii?Q?jZrMoSO/RopKAx5aq2pJryzz3USJKvol6MP4nfSC8Rn0xUlZvZNZbS8QsNPs?=
 =?us-ascii?Q?WK5cxUW0z5cKNUG12rktnrsVjpCBBkEKKJsb2Lj9u45kiYKynJKgIBE5AlIY?=
 =?us-ascii?Q?Y4wh6bgbrZ+qR3Bjm0+CWYphLGU8DZukr7dI2Tjbmp7LWvH5WBhqjMv83lvx?=
 =?us-ascii?Q?QG690zrZ92Ogoyt3g/FGcn4c2aloe6cWJf8YjhzgIriCnlLS2X3PAs+thNsB?=
 =?us-ascii?Q?V+ub6naLfceml0rCVLkp8JQo+qq1fG8UtxdoJJxDP2Nsv1RJIrpcJbEdITlN?=
 =?us-ascii?Q?iXPKuzmZPO23jjpIs2yYG0K+wGYVPpbIMB3RmTVZtoe8GEhLPsJ9fRVCMSyL?=
 =?us-ascii?Q?wAn1dxGCJDM1L/v2E9H5SvdVYav3P97KERvhxsQqzgoR1xQFGYd1sOJ3AIYh?=
 =?us-ascii?Q?e5g5XpKIh+aAm4KZLe1TB5mk9SE6ZmLEQvruauGqlyS2wewJw8+PIQzYwssN?=
 =?us-ascii?Q?cven6rfg7uuzGw5RZWz0KgoG8iW/wWRtqdwM0qIUxsACzUpZwHygtplVlkeA?=
 =?us-ascii?Q?8WYTncuKvRWuH26GIx7QYqcuIvGzNWaAqwHfbvBx6IuxMkJAv5/XGzps+yxb?=
 =?us-ascii?Q?OAPTvBbaMoKUSa/P/WYUp028nOpBpRo41H9fGu91lCdPVWJvYaIjXX9g61g7?=
 =?us-ascii?Q?OiojW/xV2gI4xpHCN/6g5e8jbVUfj9AOgEge9YY45Sp+iLHh6h331OmyB/b2?=
 =?us-ascii?Q?+obknTaiGfAWyyKKMgwz2CcsEKQKju/Zxg/7rJZl/f/CJd8OpYY0I0qL3NmO?=
 =?us-ascii?Q?cegMoO0/th/IrBtAag1GgLYGSOT5zj8KZu71fFcT1TQoF2mG8cmVZjyzoIBG?=
 =?us-ascii?Q?q6O5xgNLcD7Q+DxH+qFid7NPOTM9hTuF9bhDbh4FbGazyFRLRJCvKU+aOHTz?=
 =?us-ascii?Q?w2SD4qTjZ8Gb5cAMnH9JfZsG1DTv6K0/xi0z2B1+8pW2Wa/yf3sHE2TwUrR2?=
 =?us-ascii?Q?DnQz3mYJy01kIo0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:24.9478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8191abdb-da61-4281-507f-08dd53592e53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

There is no need to keep them in the header. The vEVENTQ version of these
two functions will turn out to be a different implementation and will not
share with this fault version. Thus, move them out of the header.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 25 -------------------------
 drivers/iommu/iommufd/fault.c           | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..1c58f5fe17b4 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -472,31 +472,6 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
-/* Fetch the first node out of the fault->deliver list */
-static inline struct iopf_group *
-iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
-{
-	struct list_head *list = &fault->deliver;
-	struct iopf_group *group = NULL;
-
-	spin_lock(&fault->lock);
-	if (!list_empty(list)) {
-		group = list_first_entry(list, struct iopf_group, node);
-		list_del(&group->node);
-	}
-	spin_unlock(&fault->lock);
-	return group;
-}
-
-/* Restore a node back to the head of the fault->deliver list */
-static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
-						 struct iopf_group *group)
-{
-	spin_lock(&fault->lock);
-	list_add(&group->node, &fault->deliver);
-	spin_unlock(&fault->lock);
-}
-
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index c48d72c9668c..29e3a97c73c6 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -138,6 +138,31 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
 	hwpt_fault->cookie = cookie;
 }
 
+/* Fetch the first node out of the fault->deliver list */
+static struct iopf_group *
+iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
+{
+	struct list_head *list = &fault->deliver;
+	struct iopf_group *group = NULL;
+
+	spin_lock(&fault->lock);
+	if (!list_empty(list)) {
+		group = list_first_entry(list, struct iopf_group, node);
+		list_del(&group->node);
+	}
+	spin_unlock(&fault->lock);
+	return group;
+}
+
+/* Restore a node back to the head of the fault->deliver list */
+static void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
+					  struct iopf_group *group)
+{
+	spin_lock(&fault->lock);
+	list_add(&group->node, &fault->deliver);
+	spin_unlock(&fault->lock);
+}
+
 static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
-- 
2.43.0


