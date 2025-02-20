Return-Path: <linux-kselftest+bounces-27027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A3A3CEC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F03B823C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC61C9DC6;
	Thu, 20 Feb 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdoOPKMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04D18A6AE;
	Thu, 20 Feb 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015177; cv=fail; b=CcWL4KdMdVM1yaoRffc88hi7NkxD/1mVT6hLe8KW0UpO+fUE9kPFNl9oaUng3GzjJWhSQYQuSSPZ/HW4aBor1QdtlK7zTWMRuVye17zZtXGkYABPcpuxiC093/wYBs9tEkMv0ow2t8Mz1d4BcyXgp2RczRiDAtLj44KsmU+yr3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015177; c=relaxed/simple;
	bh=/awyj9GHIb7IT7jjDyg3mJmsavAAO3YGgJZNRckwSCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtXaizXQI6rJ40qjBClcOEk088d7XYuGdURURA7sGh3eJjjA88Az0/XOAd/7f3zD1d43wmi45odu3q7zeAA+Iq3VK8icCj48bfcB+ZJReYVfZbflCFyRAlmBISzpza2Xj3KLIu8hCs9gLo0srVsCcQ28O1/MdFroT1ULQjoZmXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdoOPKMD; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBJZM4jrDoH+/X8mjINLGEj0NH9ToKa882sbXMCIQ0nGjox7hYH+r6GQoZ8uIexEosAGXGM6eYVdbh6yvQeRxMl7xMAn75nuJYJNS2atOQKMCFQSQj1eKuZkc19ExfGOFM4DOfppxI4JkQ8jdpqz2QSlc1UzoRcOGGmlmvd3GlcCgbOFS0fsuRO4QGUHWEa3X7MXeFhD7goQrTUaiUoQVzcOH1IoWXwaw6LiLPLcoRnxzKKmjI6dnYNW/5diNKPnG39208y2DsJsB3eqLJ0YFBGwyc+/BI5JygdpEsrAt5c2nVhXFedBSbrkVDYX0UTy44GdFi20nmEBEBZZkO/9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYz6ypHlJXMgFK72LsNye3N/Wjn3Y2DI+S220aephPE=;
 b=Rc6o7pb3B3JnnHci7bRsThL1DAxUEZ1NF9kiTUpfHn6OE5FTKS0Y4IcnEesq1/axjbCGdJ5faIY5TCLLLK61HDuM8xymOlWqArFnq/R7jUGuPRkNrxhbF2mx0w6RYjRBfBHwxafX5p8at9S/i4I0MejqwfYcm1D98uKJMzqO+QGY9IOxyzojWItpSFPK0RBR+bFKoej9nvHJwoZh1HNDtJ4xT1e4Sg5877/manzoIIJ5j+LrmoUXUXb8WZZTPz4BOBFe9I5qUtNzFuHsBX97xCAIRHkWOlUsYQUQH6WQEmFMO1xtSjjyvxiIf4wROYUnJxBrLjK+KBX1gqvNT4g80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYz6ypHlJXMgFK72LsNye3N/Wjn3Y2DI+S220aephPE=;
 b=qdoOPKMD311ub//DIaj3SgNWcYuhT8XQ9pCZ/hLNlvLTnYKpT0mAhB5usZBisqtBQyY6WIsaEh2FU0ZJX/uzXijlJO3a2qM5OExKW0f+rYi9egTsjF1qcgMVVoQMjBHJQx0ZpQR5TtIxSf0Y+j1CrDPVyGL2JrQ4l5zQjD2R2GeW3EIqT2QRsNZdojigjehYds4noKhnQMjfe4sbFuSZMBV9h0P1TKv9YShH4GgIYfsT8TxGZO5F3ENwbOCYG79qxH9Zs1z3TJAtNntZv02bukhnppiSu13ngP37e+dQmeg6VfZJP+Zx4N0OUJzPICj42a8uePE3wn14py3dgK3VLA==
Received: from BN9PR03CA0896.namprd03.prod.outlook.com (2603:10b6:408:13c::31)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Thu, 20 Feb
 2025 01:32:46 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::3f) by BN9PR03CA0896.outlook.office365.com
 (2603:10b6:408:13c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 01:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 01:32:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 17:32:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 17:32:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 17:32:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private pointer
Date: Wed, 19 Feb 2025 17:31:42 -0800
Message-ID: <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740014950.git.nicolinc@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: d450ad5b-2e62-4606-f608-08dd514e7aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAN8LJnb13ziq0m6AjIYTQ6hgJ7uabm7HXW/ratGQr2/LCw02t7WteGlxN+c?=
 =?us-ascii?Q?jNydE7ZMJi+w7PXSuE+YXU22W1L+gkeY5paedGki1OEfQB2+t+PCK7525II9?=
 =?us-ascii?Q?AEU3317VFzrpQtrHIV6KxED7RN6SSL/kWloTLwuvBCX05vqqnXoCWdpDVeit?=
 =?us-ascii?Q?Zjkep01tQaVnZIBbptQjvocT1GSohPPJyYAWDkAW7HIrUDY9S2tTOxIHg3Bl?=
 =?us-ascii?Q?9oatPDwJ5wsC/kzZsr8Ex3lCrhhxImTRoAMwLUKd274RPDi6ZjpJf1JUMq3M?=
 =?us-ascii?Q?48jSeLesj+wDoKaEVyEISi69fVBrgJZDTCzeVpj+JtHdhVMdGfdvJwLFBWvn?=
 =?us-ascii?Q?spS35AuZVAdfp5w+QVGUpdQ5hwndCpmwP/6LiLPqMWfACguce2xaDMQCWJcF?=
 =?us-ascii?Q?d3DAdK7dmQBV0vPkF3EgvqbjlIm4XVPuYwpyPMk8rkN4DCaq/Hc7EaJB8ICw?=
 =?us-ascii?Q?Lvizhj4+hFMlql2JpoAXy8kOPOAwgV0fooygqEnUJffiDeLZgDPjrdjroxq7?=
 =?us-ascii?Q?JyWjKVo1J7IIteTl3PBK5dZVLmbfdmzVfqKDTO0oqQ5J19dcWLsJD0huNivL?=
 =?us-ascii?Q?s1yCYm6dpCKjuX/1YnlyAiaCPaM9wjYIRBUI7pnsGFRtJ+7kmiKQr20g3vZf?=
 =?us-ascii?Q?LZdmPf9DxGSRMAVsPhhyx6U2m1BjCOmH7tevPuKqzCs0B7q1aL3/OQmdb75u?=
 =?us-ascii?Q?uAtmeznj9MDgy8/BJpVuZxtLcWrYZkD7nc0ZW1R2HL0Yh/BUd9pebMZKZZv4?=
 =?us-ascii?Q?ebmz0CtyjywsTeKaBpVj/i8PSVn8bys8bF7Yw8LxMNFyC+MUzko37HbkZngP?=
 =?us-ascii?Q?zV/LlvEmA6bT2YUBB2bF6/MGDbkBZzuQC24jRJG+aggaC+0au5U0QZknMYvw?=
 =?us-ascii?Q?0unQHnv4tLft4faks0N6Ylj5KLTphxSpxTgLOFm9UnhgwfbrAdsMsxGqrOLD?=
 =?us-ascii?Q?ew0QfZsD/eu5E2JH4sIiIPD131r0ULJbqCDy1XZX+3AZhjY4l+jVQDYoZ6ZC?=
 =?us-ascii?Q?JT4KHGE9x3BJBqiN2FnHL4yh+HXRB+Zn2w5R05/GjhaOzax2eeCY3iJO32+s?=
 =?us-ascii?Q?Zz/zVXcw3RHeRUWVh2eZUYgv7yf6r9D86MXN5fbd8PtXXOZdrzG2WH5Qyj0e?=
 =?us-ascii?Q?hrJ+EiqbrjDHX7paBmV3iXW0YUDlRWplL9+NVVizU7wC23kp+oIgdaBC06E2?=
 =?us-ascii?Q?9EKJ06ttoL1MLqVwFITd9wVUZvuL26ykY/Y61WhpBaRWLhmZIbVHbfsdBp7E?=
 =?us-ascii?Q?wZ1dRgm52wpdKE6FeUMVb4YrbMC5+MUZR/Tt0oCWCw8MDfBMc4HM3FlHzvrF?=
 =?us-ascii?Q?US7jCTwzjufOXxZZ9o0NVLRPt/UuYWbWiJb4bezp9WejrlM44EO+wXeNm+mp?=
 =?us-ascii?Q?2uXCEOLDwTuw1xssF9vlZtOuUlROACphocgicJR5siGHa3ppNX28/GCRNoGl?=
 =?us-ascii?Q?Ulq//ypYmEOWtu3GU3aLBQN39ixT17gSBCTH/YPzG6Cx/vnFJuCUscFcd1RC?=
 =?us-ascii?Q?eNePPD7vzbh0ljk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:32:46.6292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d450ad5b-2e62-4606-f608-08dd514e7aef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

Now that iommufd does not rely on dma-iommu.c for any purpose. We can
combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
union. This union is effectively 'owner data' and can be used by the
entity that allocated the domain. Note that legacy vfio type1 flows
continue to use dma-iommu.c for sw_msi and still need iova_cookie.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e93d2e918599..99dd72998cb7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -216,7 +216,6 @@ struct iommu_domain {
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
-	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
@@ -225,6 +224,7 @@ struct iommu_domain {
 #endif
 
 	union { /* Pointer usable by owner of the domain */
+		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
 		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
 	};
 	union { /* Fault handler */
-- 
2.43.0


