Return-Path: <linux-kselftest+bounces-20337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B6B9A94A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31951F2393B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8478289;
	Tue, 22 Oct 2024 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uzd/XGtH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C554652;
	Tue, 22 Oct 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556426; cv=fail; b=jNqVnR+HYg7ekVwkdpZcnR+B8ei1f3m51bK5h4QjQAdBrUTODHnL2Mn8ZOr7vd5ofhHdNlFcwNmO/gW1t+K+spjJF+6FF0lPps58iI1Riyduyz5ip2KcqvTz5CTVqgF5ylBGUiWDKJPARReWBlI9sDVyySvk2PnX49dn2CTvP1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556426; c=relaxed/simple;
	bh=bwehOYCy1nm4Z13PnM1A2jYh1t2+F1T8iVneY2NY1EM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhiH6YDNl0BSTFc77saEyDZi2BBW+wsul0nBWKpq5hQXFtdJkkTxvDt2CtpyiIfokMe/DxJ1Cz2nO3KH9vg7v3Mabfhgni2AEkFFUHTIyZRtas0jU/scmJRBfh/6TmM2odO5TcfgMdDLXNsGncMRS9CaCktcAwFT3N1rSVtpRqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uzd/XGtH; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4kKEg5Tun4Xm3BYB+spsAE47xku5UWF2I7pXJe+h48UURVIdlBuiU+kjzKxkMwYiLv+ohgMxCFfDjGz6hA//p0YgdjIy2BBcvRbzMslYYjteb9/zD+09CH7sl644RXEqtVGtx9+gUqt4WUkN3EsK05fAu3R0pHumGi9I9yJQzx6IqDlfqla3Att3Z2jcmTdbIpBDNIKB9YERRzv+KTdnv6SYUbqG/uxj3I2jqu90cBekb5u52qO80l4nCVLdpSuIF012buBmvQ6z1OllBkEaP1orsdDBVLVEWzRCEQESQNOX3QHoPvPYiMzpqHXy6HDlIPf61mOzEtS1VsA/uZiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCiiwbPRF3tMxjrTpTPyUaddxelaA0bQsArIpIV1apE=;
 b=H7ke4q8GEj6bEW2w2djdXNipXLKXWF31y4aJmaDiE4p5mKJnFe4GtMcYM7kyXwNhZt4pmIpkapyNfi4I30EYJpDd7OU7nPJqmZeVcvRpA4gj7JmjxONnAR1V4+4RzhivT711bn/w+2gHBefcR5LRVoqUr1lC/EBHu2nny6wCgyRZsj+3KmvgPFoCUKRYiEKsMx3SHvDOCfg6hXejKk+u/OD14jcKXHNTnba/gqUbcP9vwLM089r8ly7tK8EgbI94BWDSpV1vWQZUtH6lRutV0brZdHYMm+BRq/WX167ea4a34GAaEggMPGW+WXruDSURtzZhy82bQGC2Ib710fRx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCiiwbPRF3tMxjrTpTPyUaddxelaA0bQsArIpIV1apE=;
 b=Uzd/XGtH/nQAbenKntjv2ymsZxQCj7sxrjw0Ly4cDmBzXMLZiH6P7vucQC8leT4rbYEJWf3dkm2RniFbrbzQtm8s3nE8GQpgmu45On2DjHTExtsjJr+mPwAyShhVESCzIn8RTYpQhC+zDSgCQRpLS1wRHSh8p++ZiK96XZSRgV5LBaZtpUeyTAFq56NZIhfx1hl0HAfT6GS6N0RpVjzQc4NI8zQY2wTR/DszHqYFWnGvryLKgdR8dVf/ek0k1c6loP63/sVlgzjHHsYOEQuFyBxoJwdFPCxBeL8/0BbfX9ZpEjgttc7f89XYXKuvpKnqdbeXeqIgN64HLudy6VGKHg==
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:20:21 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::50) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 03/11] iommufd: Add iommufd_verify_unfinalized_object
Date: Mon, 21 Oct 2024 17:19:25 -0700
Message-ID: <b48254df9ee530bedaf436e5aff279d9a882a7ca.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f47bef-1b55-49b3-6579-08dcf22f50db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Law1FOcW+UEbGewWY7M++AYEvwXP4NO19sJoXoSJDM80kygPi8y7k14j3ckk?=
 =?us-ascii?Q?N0las2JcBl/jSQZtn+OhwrnqzRn206PJ0oNAwUv+FxG9rAxraGxZAWyUEYps?=
 =?us-ascii?Q?B/3cE9G5OCwN+fBUJHLiWsNIx5n3DsxVT+TxEXu0mvQdsxhUdD+wLTahGuZh?=
 =?us-ascii?Q?LtcXUjA5gP8apzr8EbTeVhzz0LUYsWcf1JxRJVZeCIlvEEgcuNk3U8DD/hN2?=
 =?us-ascii?Q?RZEBS3ZxN018vY6HcifKZCsyoFIdMbxhpyR/iCzKHbySy/eZ+r+/WLmKbC0L?=
 =?us-ascii?Q?BjtmsVtaTVr4Ul3WQGrfX0NOP3gd4m0FoOlUbGcCVNKduwFxN9xVOMsrStSp?=
 =?us-ascii?Q?4S1drLjpvkeOBrOlLS67+cFDCx/hQ4obJHdQsDzWGqx9u8CrBDv+Dz4CQGPa?=
 =?us-ascii?Q?lcAhDkqAQ+QbELyK8BgFQw//1rfm/Asuk5HArX0GW1qKlGUbMyMG3Abl6508?=
 =?us-ascii?Q?2kEgZwhe7/XNqM7QyyDAS2iIO4IpC8Tb2Ginjydn87VO6iwJ5F2tZmSE3m0n?=
 =?us-ascii?Q?Ye8A5jmbovE6nkckk9ebXhTtkq/OA+UJsJufXzV/AXb41rUE27YqO2s9qzFy?=
 =?us-ascii?Q?bVqkuRz0+fRUdNOF6xflVcLSbzCBDGRh2f69/VeH4mwCei9R2WKrlkT0wv8k?=
 =?us-ascii?Q?/44jHcktP2cyxwXYrMpmF9T0WTHwx7fP0Erx2rKXttEIGGCno/pF1l/MS/ab?=
 =?us-ascii?Q?2egZ/3m1HfgRVFTAs8cnLrQB3mLW535wcJyYl0nlibbcEjs7/trDnZ61hndv?=
 =?us-ascii?Q?Zg5FZOLraF0x75s5i4LvbC0HyYyk3JzbBXp1lu02ebxGpf5G+2HPx286aPr6?=
 =?us-ascii?Q?Bs5uSn7d8NT5R6pzQ0TNw9CFeXzIpKdxVHmQq2XbaREsvkUNUrmZ72lFWVF2?=
 =?us-ascii?Q?v7N1VGZZo0bw6lIZ2NVxpNKYCkYYtLbFd0NfIOrvB27/+WGd0olSYWyn3c5S?=
 =?us-ascii?Q?fuUpGGNaHq8J8VFXzp8g5Fj1zq7mmYGcU2um6F+C6H2megjNgsdf6GMjY1TT?=
 =?us-ascii?Q?N9+w+McMSR8nWsIrBZULcqTNJuUDp4WFRk+aNt5afwTl1gEO7rJHo/pYPZQt?=
 =?us-ascii?Q?BFCM7qIXZ7dj72Mh39+a6b+N6fNIdtOiowot4Olo31U/aEXFJoIiV0ps9e4v?=
 =?us-ascii?Q?mp6DskMcCS8/7O04ukHLqpqaikYPGJiRlUzgA23SQCIPLch9S6BAfO04KTRn?=
 =?us-ascii?Q?Yfglw2WOXnaomsHafvvVTSmvBi+YRl7ncpIzuHZ2iTMXDo/YgvPJbVJbEsK0?=
 =?us-ascii?Q?v1hNwkdCfq98glxOuIVH/VWetyVQKKVsVwD6aPXQDmVZc5nQK/tGDdTUYgEa?=
 =?us-ascii?Q?0j3tahPXIy95jlUJXx2mDCa8REJT+gxOY+XYSiwjTGPAwcUrPjIY8v9ruFVA?=
 =?us-ascii?Q?n4xdPmbXteojo6A6bB5OGQcRKOG9hiGeOsKC5uSdPhhDcpln4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:21.1676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f47bef-1b55-49b3-6579-08dcf22f50db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262

To support driver-allocated vIOMMU objects, it's suggested to call the
allocator helper in IOMMU dirvers. However, there is no guarantee that
drivers will all use it and allocate objects properly.

Add a helper for iommufd core to verify if an unfinalized object is at
least reserved in the ictx.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  3 +++
 drivers/iommu/iommufd/main.c            | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5bd41257f2ef..d53c1ca75532 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -152,6 +152,9 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
+int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
+				      struct iommufd_object *to_verify);
+
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 92bd075108e5..e244fed1b7ab 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -89,6 +89,26 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 	return obj;
 }
 
+int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
+				      struct iommufd_object *to_verify)
+{
+	XA_STATE(xas, &ictx->objects, 0);
+	struct iommufd_object *obj;
+	int rc = 0;
+
+	if (!to_verify || !to_verify->id)
+		return -EINVAL;
+	xas.xa_index = to_verify->id;
+
+	xa_lock(&ictx->objects);
+	obj = xas_load(&xas);
+	/* Being an unfinalized object, the loaded obj is a reserved space */
+	if (obj != XA_ZERO_ENTRY)
+		rc = -ENOENT;
+	xa_unlock(&ictx->objects);
+	return rc;
+}
+
 static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 					     struct iommufd_object *to_destroy)
 {
-- 
2.43.0


