Return-Path: <linux-kselftest+bounces-28764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B113A5CFAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EC189D949
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32E25E82F;
	Tue, 11 Mar 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwbFWxsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187122173D;
	Tue, 11 Mar 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722330; cv=fail; b=Kr3LnHIqu+B/jgAL8i+NByKAVI7gHgmy1hOyuEyowfg5ZHpJIRDWKv7dk99QtXOUTszJ/KULOc/3HwsYCrNpumkgUq1gzlWn7GREVl/7HtEIsn7VDxhgih4BzQDvdf8Ag7xjlcRL1u8rNNNIbhuVIs5weAa5ECILmsa+j4gsb8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722330; c=relaxed/simple;
	bh=wTio0yv2gBQ6U/iSzwRqq4uQ62BJLdo0YHTuy/VvcuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUAzLWha/gP8OsUT0yygXPo6NTBtznYBwGck7kTK3QBUaGw2dvcRTrUSZ+SEwiSasGS8TIL1bIpzZYKj9MIC+idSfS3ZGLcF9FsJdrxksJLS19HISmFk1XoSEHHZXFN4moV7kSFSTZGbikJ/Bey2+tPKDTMNMNxPukaqdmIlwHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwbFWxsJ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrJChJTEf7NyBkwjggAogD1c1gHlDH79JZ3tdHBGYXkmAjNzmZiZ2zjsVnY0mXofkA8jWMxEreaVEtziIkjtcoJ8g79Cb31hMwV0ftt4jSbQktjfZ//7RrhAoYSxW9EN6Vev+//U7dz4b3OtrdF6lpUana+PwV5jxEcePn6Nc9T2wNdkwJnXtR1Qr9GLkOaXyWbEZPKX1gga6GNUn7aO7hGYr3ZdITYZ1VuoBqfvGVAirlFENmfQkoLPyKwjO2Hmgni29CigL1lEz/2aKDp5tlQm7ArcHJOgel4Gs88iu+Pf0RuwMSvYJt+YTyWlUkChXS83UbkbVBgvCtiP81HNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=nE4hqFCDvERVWUu9GwJisWhRYRWZGBI/ZfpZQ+wEKB2aFnedtMd2x7K5N/nRut7MJrKkpIK4Al9ZN1j2ypa5EBrRFx+kV7fUu/xCKGoWS0y2rWt2Xd5H91Gmc+XnXpRyayhqg3HMuXwTjkYi2B6lgH/VegajUa2Sq5Vu4+To4DoAUJ3MYx0zVUJL1Jj1vk/rzxB+rP357jZBiIDRoUXHPgeypNt8V3g+YoK4vFCaXwrtFftnXiMOd6+ChgAF7rwuUpqUcC1HtGSZ9tHo1Ej7+B+w9TlLLw3zmpUTyQBt8yXYpqGC2/zXYccmIUteE0Ma9edRtF46tR8yavdRazr68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUNM+8Bv5Nfzbqa7qDebAIwRc+J2TKyqV+0Ykxi7QjI=;
 b=iwbFWxsJBDOUHDAbGYxAEP1H4wC5eGrWCBNxpA8MMiZYsfcHncXvJSR1fs8ZDOzVOIEEEXxhDzJ/F4k3BiUsAzOClJOpNvkvTmPnC9Sj0Iim6yurB/zftI5/yLoj6OtBa0mnj0FDZadSiTwdweEE6NtNyjC+yph8ykftr6q7Sm5MiwvweCQ7nh0setIIj4tJbD73qGcWAOjAYj50XMFifIVx7nLi4elQswmSZ6D5oF9m6dgQZ7nw9NNyK201FVuC12ZTFzdKsHTSEXL0FO3HaYUC+x5zTZG1Cau5yqJt7OSsH5fKjxEr1Y13X1Dc9srQaDhghBXfqFAcqVdzdQzkIw==
Received: from MW4PR03CA0320.namprd03.prod.outlook.com (2603:10b6:303:dd::25)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:45:25 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::a6) by MW4PR03CA0320.outlook.office365.com
 (2603:10b6:303:dd::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Tue,
 11 Mar 2025 19:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 19:45:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 12:45:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 12:45:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 12:45:06 -0700
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
Subject: [PATCH v9 01/14] iommufd/fault: Move two fault functions out of the header
Date: Tue, 11 Mar 2025 12:44:19 -0700
Message-ID: <7eebe32f3d354799f5e28128c693c3c284740b21.1741719725.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 155ab0da-97e1-4c29-956f-08dd60d54408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ietrumcAWjthRtp14dz46EdOdZEQEaRlwN1oZWzBcJyRjFG7bq1BW4sCwE3h?=
 =?us-ascii?Q?0RBNgdxeW5pizTtiNWito/B1//bmjrmifm2WwNBCyvz4uar80mmJoDm2AMLy?=
 =?us-ascii?Q?VGV65vNCvBuSNK/hWkW2tLQeyaRRRvNsXT+825X5mrEW8TCD93HYwtqtLeOU?=
 =?us-ascii?Q?JGfVyCLQumUbO83SClar7vTm00I71dpmGqyu8IOyy7EZqbFhu73gCBlZaGhL?=
 =?us-ascii?Q?puH/j2Uz/7ofTPtdiP9ji4vbkL1qqJ1e7cta2kI30BJHB4S8n5xQ40FbkiBH?=
 =?us-ascii?Q?tVmp+cr+YODKzEUT7ymGeiA5RfKlwthqI36x23RSyTJ2osBiAJL9lP2NW2tB?=
 =?us-ascii?Q?8aA7elNh7clDKyq2KHVBLYEzOnTmgTi+DupCMeKTmkJizIFnIE1sKmG+pt8L?=
 =?us-ascii?Q?06KdBNmG51btV6dEEWDB10p6sh0pal3MEXUMnjAJCntj79bMdVcLFaYJZSvd?=
 =?us-ascii?Q?60NYn6ZVQZ7e+TcqTlKNQ2enu+G0sGsVALcO93Ge/XHaVap7TqOpqQ5ev36B?=
 =?us-ascii?Q?6tOekX84kB6mUCKXn94rPi7q7Pdz/pUJN+oQY+GYGJUcNl18pWEzQD1T73uH?=
 =?us-ascii?Q?jza0kqLd8a+nXbbdEOmY4eJVNdEk9jUMriIyfJzoB/katupvNeWdZJP1SOGb?=
 =?us-ascii?Q?ysBMJ57PgH1NsXP6dY9d6QJoVAqKgJUm3k9V8fyirYa6TbTGtsUVBMV5TjlG?=
 =?us-ascii?Q?Q5dcJ+MDMj9TmR8/lHCBOtJEsR4JRt4zqapnBkMaHJZT9a7hFbH7jsLvIEfo?=
 =?us-ascii?Q?vW3wXy1Ag3LUH7zwAYEuCW0n6PmIpWZlNTzTNcO60AekpaTyPDTwXaiviT9x?=
 =?us-ascii?Q?RlaGeBzaDcAvcQlUVuGSocxf1iVWT+JnJy1orhaKRFBkKhSCBu6hZurOzue7?=
 =?us-ascii?Q?Y1tpFLOEWsiT3u3QL5bJmdURjI3W6WMdCu4KvT29+iOi8zEUWNvOSwHITlGi?=
 =?us-ascii?Q?VZaNfb0FgfYqS7b5xh5oDHIMsiqhg4zrWcZfDP5CFmIBlup0fav/TLiJMNx8?=
 =?us-ascii?Q?nmg4x63dPRbDYnqy95xR+THfEGRVF0aInYL7OHFwxHDcy6qaqc9FnbD9QMJi?=
 =?us-ascii?Q?y3xWNL3TXe+hyM3heLmj9rSRcmfyZOOnqKhqVpm4Otl0basiAOE1VHN/xUHM?=
 =?us-ascii?Q?uKzHxBrkUaV8x2SoTuUH6vISojo8zge/B4uA4In+juDLBh25AztivXReG4Xo?=
 =?us-ascii?Q?/82ZIUcCPlLgCMibo7OZwkjvpz3mQCSyPUW+JFtaf/dfAqnlkpbJZ/0WvOw3?=
 =?us-ascii?Q?DjMXFghPX9C/BozSZ4FasAFOR4Nmyb8URPAiTj3NTNCHvzbJ7gWGBskcJMUT?=
 =?us-ascii?Q?1g3NXPYfCCrTgwCvKnuDFWu1RNEe1YNckaIQ+nR0kFIipNfHy3Me9fOhKuda?=
 =?us-ascii?Q?eHYs79fbgF+Qow7hOdvGAZJNhjJhaKUTxqVIwttQnna720mPHaYsC1DMEMF7?=
 =?us-ascii?Q?brXpsBOQs11BojNc9kM8UyMUNZLIfOQ29lHzPMEQwriwaCwp8JQa70YiEntN?=
 =?us-ascii?Q?uHtVcTYFJP5Q3IU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:45:24.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155ab0da-97e1-4c29-956f-08dd60d54408
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452

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


