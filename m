Return-Path: <linux-kselftest+bounces-35894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A7AEA6A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC62A7B5AFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7612F2737;
	Thu, 26 Jun 2025 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crItPkc9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73922F2715;
	Thu, 26 Jun 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966539; cv=fail; b=Chm1x+HecHxAtpo2O/YWBIQGvR4M6R3pBO+NAXA4R1pHqYCr40pxPXDsMZ5GYDz2HnnNpaiEt/U301DzijIhojAD24iFHZJ0DD/Y3Dw6iodE+nIaUSFoF6Py8irzpFejC37dV0CxbQsWEbmTm4/mMkmZgS4dFUD9ZgRO7fy4TmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966539; c=relaxed/simple;
	bh=9oywlUrESdce9HuMILrGCVLNY+AT4Kv/16kqYEyyujk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDeeb98S2tgtePwt42AI9YG5hRahKi+W0J0n++Kk9CC8QbI33aMLFNKur6+ePRxcqWWrBQ9qSfU9Z+e56HGFJ3RKjLHMfFYDAMwWo+urluKeOCl4Q6ZGW9k4PMC6UFLvwDG/BnBvzIWRJsQcJZ7KM0Qhg05pJaIwAWEVpNfD6ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=crItPkc9; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4VlJdmgDNj44i0/lh4Qz+66YApXH/gDGzV25y78+xZpObwSjIbrDFdtzDqq4nfnSU9j5Uo3jh5YZ+5Tz1SzaTMqeJ0axB+pOP6vOmsnUPaAz837ml1AuC2cGR248VdxwRPeVKMDvA+TlMN8ek7zmg+whVFNNFBMsxCZZ00u0SJVWxZdEKNKuXhsIi0Boj+tDJ++EANbPM4+xOrdTKVmh0zYCZ//Qf/9cM3wZyPxAGgvfwzXWZ0/KyOkbNl5xqQGB/dW7iTSS5NqCxd7Qo7H/lNby6RPka2gMbmVBWvdWo99tosf3GNgtEjG0SfhQnMGXMnwyaIYPYiYNQS0mQpGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iI4NA1xMim4pg0IeGZVfIRlgdlkPPBWJgSoilVnq9Q=;
 b=aLIFXo3btO0SH4tTHxq2nEr6QBDhARTykPa/+eNbzQSrmKaziWaWZ1ruexDeiNGjyS9MvGNKzDe5fJfrPVrPbd/vJguerQj0JmbhF4CMDZJOfwK9u35UOaGXV1EZ+TuVz7vO80ZVohZGvhKSb+XLQPkQvBaTKoukYS6/iFAzJjsH1ZE9ty2SoYGYf/HnuvppQn2UPYsTPZhKe3zaMNa/ypgtE5U4nLP8SpnP5nEmSKaSNbMi3jlqpT5X3Zhs7Ycr3xZJP2VtxkUstV6W7gdoil8FkSzehED6kr85Wj0ZkZCygGUI56sUlHG95o5oHqij8XBw4YrNq62jrgkSW2IUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iI4NA1xMim4pg0IeGZVfIRlgdlkPPBWJgSoilVnq9Q=;
 b=crItPkc95ibCCwvCuwcTT2GjCHFzP7fi4CV3rGkrhvNIPzVjflisANJXz/feUAjAeNyln1jYIAc04P9GLl6nPjuEPDDSrRTHUffvOCqFea4VOs3WVTzat80nuScHyH3maqDvryvskTRhVXrs3bohJxqOQELMvGSlnNbeijAaluk5DNnhAQDuunNl+XfUbH4QoZ2Wxj8VZ4R2VgkCHrpCv9aCfGGJg5RwR5fcEEpFRGYW/jdJgHLB7axIbEIvE3GcZkFcIsmH3RR/b7fr7VZBRWeXDFm3AJeuHVOQXt1lPHWhYhiPR1zUhMy7MkHCa50qVLNVKSyanR2QMexaYB+4Xg==
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 19:35:35 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::3d) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for internal use
Date: Thu, 26 Jun 2025 12:34:41 -0700
Message-ID: <a2b2a9704d7efff717448cbb76695e83f2fe67c9.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|LV9PR12MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d66b26e-ca03-46f9-2c67-08ddb4e89f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwpdpT5wWtic+U8qhnRptjYqqyAF6yCDeW53i6EKvJpA5zAH93wPbptmdr8I?=
 =?us-ascii?Q?4RSRZJdK+CSXaAAXZ4FypZ/xDkAnEteHMTyJg5BGtHCAnce1NHwZknjSmo6M?=
 =?us-ascii?Q?QX/ywKSYyj6GqO4dWyLC9roZrorB2Sfwe5cjkk2Sz3zsUc/FHEutJg4kXBQs?=
 =?us-ascii?Q?MqR42eibsMBZs6/Jq+sSV1LIgD5s1lbSI3Z515RyLqxyoAz+BtzUz/VW5mYa?=
 =?us-ascii?Q?UDJLH324+sVP6+AeGMrQE/A4mr4s2VdtEq2a5pa3oS2Z63kXUhSm598ym1B5?=
 =?us-ascii?Q?e5DjfOQcHsvI/HhjV88McnKASuFVF+Q7kzOlo5r1Fe9lyKY8XgjGBLBSyGct?=
 =?us-ascii?Q?GLZHAPzROThPLMzMoNsWrsjnDMlJ6TuAYaUbDEeHQ56OJAWBKInRSQlMSbcZ?=
 =?us-ascii?Q?CQRUyHv2Rz54Ws0a+Q8FG5uHx8EknEAeFs1G2b9JK39oaFZdPXki88LybOtH?=
 =?us-ascii?Q?g3lX/Q/VVmshJPEOFWHyTLdPuD37KDUuzBqA0paVQDNBIm2eUP3nAjJIP3/z?=
 =?us-ascii?Q?aDwPC+0ivws6f+z4kFXo0czFc83ysy0Rm7oaPrx/mKQGmsgucqWPu4mwcIGr?=
 =?us-ascii?Q?DCoiaGZPQ/bHxEQxlUCbU4J2gfAPZa5asD5nIEKoj3QqUvgE8ZaRU2Z2Yrco?=
 =?us-ascii?Q?5Y2wocTDT3S1JKvbPTz2ThpiMHA3LSiXR+tM5HOGq7rS4rdOLOJ1CfuPQVZ2?=
 =?us-ascii?Q?mB2m43X5VZkZ9Oan7P68BQhk388GYc0Ag4J/Mc8EDm0Hx/Pzl+R6daqf5Inl?=
 =?us-ascii?Q?p8or9GuWUoxT2dStY4bUD0jDv7aEqGsbQpj4ynSkN57FoavaoW1c1mXdfv4s?=
 =?us-ascii?Q?pRwJIwtKlo606/vDXdUTSBuWr2IFm49bgAKFEavaV6NAaNdcAlC5a8Mr78N2?=
 =?us-ascii?Q?hW6Zas775KMfU+JysOeFZGCYVSjyYPcFsdgBklJ7rYkNjWIuIShEXyGlBsRh?=
 =?us-ascii?Q?5NL2bWnJ+Rv6+TAKA3cjJAAfYQ77ZbIagsfti2sn2aeFb9ifW5kB2yp3MAOp?=
 =?us-ascii?Q?2JiP4wdVOZRH6w9LZGDX8IxLcIL2NbNU7zTPd/0h+jLuNugPgBCnMr8jbUN6?=
 =?us-ascii?Q?rMFwY0Fb0jmSwb5wuKr8dxkPvxzFnfN+wKlNJDpBkIGtU/cBv8cxrNTl85Q+?=
 =?us-ascii?Q?kSU/n2FnJvG4h2nGQlOjGmyTYwJj1agmpGQL4wt6UJRSPiepi0cfkLrG+eX1?=
 =?us-ascii?Q?O05oUIYNuAg4rcUWc9yuMlEja/YfZ9/oR3fJc/DpLV1wZLdqEU/QFNT4Ztdw?=
 =?us-ascii?Q?wOG4HTMVEdVeQkXxyj+2kbUYkSPMVXJ6PltMmh2oqFl8BnU30gvmP7HxNcWA?=
 =?us-ascii?Q?/Xy9zLy4VC9mJGwiwouKS/TaiibyYm1OZkOV5nCXzPnA1sryNdDbTk3g5yA1?=
 =?us-ascii?Q?5vT8bWx/fNY1XmRXawd36FtkFEx2ja6DPGFIpxLQp5E0simd+OIwDhPOJ4q+?=
 =?us-ascii?Q?03yDGMc6l8OusSBfd6oFpLlMn8j3gNnCgryPGwt8HKV5kHJq+Cm0jwWaxa5+?=
 =?us-ascii?Q?/umlzit1JOrMCOSbl+Xg5Pw5KBQSTsuFmyTj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:35.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d66b26e-ca03-46f9-2c67-08ddb4e89f6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

The access object has been used externally by VFIO mdev devices, allowing
them to pin/unpin physical pages (via needs_pin_pages). Meanwhile, a racy
unmap can occur in this case, so these devices usually implement an unmap
handler, invoked by iommufd_access_notify_unmap().

The new HW queue object will need the same pin/unpin feature, although it
(unlike the mdev case) wants to reject any unmap attempt, during its life
cycle. Instead, it would not implement an unmap handler. Thus, bypass any
access->ops->unmap call when the access is marked as internal. Also error
out the internal case in iommufd_access_notify_unmap() to reject an unmap
operation and propagatethe errno upwards.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  4 ++--
 drivers/iommu/iommufd/device.c          | 21 +++++++++++++++++----
 drivers/iommu/iommufd/io_pagetable.c    | 10 +++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9d1f55deb9ca..b849099e804b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -111,8 +111,8 @@ int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 int iopt_set_dirty_tracking(struct io_pagetable *iopt,
 			    struct iommu_domain *domain, bool enable);
 
-void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				 unsigned long length);
+int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 07a4ff753c12..8f078fda795a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1048,7 +1048,7 @@ static int iommufd_access_change_ioas(struct iommufd_access *access,
 	}
 
 	if (cur_ioas) {
-		if (access->ops->unmap) {
+		if (!iommufd_access_is_internal(access) && access->ops->unmap) {
 			mutex_unlock(&access->ioas_lock);
 			access->ops->unmap(access->data, 0, ULONG_MAX);
 			mutex_lock(&access->ioas_lock);
@@ -1245,15 +1245,24 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, "IOMMUFD");
  * run in the future. Due to this a driver must not create locking that prevents
  * unmap to complete while iommufd_access_destroy() is running.
  */
-void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
-				 unsigned long length)
+int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				unsigned long length)
 {
 	struct iommufd_ioas *ioas =
 		container_of(iopt, struct iommufd_ioas, iopt);
 	struct iommufd_access *access;
 	unsigned long index;
+	int ret = 0;
 
 	xa_lock(&ioas->iopt.access_list);
+	/* Bypass any unmap if there is an internal access */
+	xa_for_each(&ioas->iopt.access_list, index, access) {
+		if (iommufd_access_is_internal(access)) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+	}
+
 	xa_for_each(&ioas->iopt.access_list, index, access) {
 		if (!iommufd_lock_obj(&access->obj))
 			continue;
@@ -1264,7 +1273,9 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 		iommufd_put_object(access->ictx, &access->obj);
 		xa_lock(&ioas->iopt.access_list);
 	}
+unlock:
 	xa_unlock(&ioas->iopt.access_list);
+	return ret;
 }
 
 /**
@@ -1362,7 +1373,9 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
+	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
+		    (!iommufd_access_is_internal(access) &&
+		     !access->ops->unmap)))
 		return -EINVAL;
 
 	if (!length)
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 22fc3a12109f..6b8477b1f94b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -740,7 +740,15 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
 
-			iommufd_access_notify_unmap(iopt, area_first, length);
+			rc = iommufd_access_notify_unmap(iopt, area_first,
+							 length);
+			if (rc) {
+				down_read(&iopt->domains_rwsem);
+				down_write(&iopt->iova_rwsem);
+				area->prevent_access = false;
+				goto out_unlock_iova;
+			}
+
 			/* Something is not responding to unmap requests. */
 			tries++;
 			if (WARN_ON(tries > 100)) {
-- 
2.43.0


