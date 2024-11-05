Return-Path: <linux-kselftest+bounces-21481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A639BD69B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D30282C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A5216E02;
	Tue,  5 Nov 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COGz5N9Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33728216A13;
	Tue,  5 Nov 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837119; cv=fail; b=fa78ClbViAIy3ALO62GjhHl8MkfwNuLrGSeeX+xakwsFimzR5kiSkB0laav9Y25J7ELdNb9skr/q7mCaQSfcyQh67DG2vN53wuFMd810KOrA467cRlBtGmwTwCQcaW8tj726NfVzNPFDs8Et8ohZSb/jdENpxo7fEg7AI5RDyBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837119; c=relaxed/simple;
	bh=gGhsKUAuS3tN+ZVvOMxcUVmYnU4xo6EcIIjj8fa0HYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjUvhnvspjgz1FUCZ+AtPm7W+hHc/BJ/bev2kXauFY5KbRoxspjZsySzn4pj+xtmplYnZlc8tUPRWFcfdG/R7AZVbEIKwKLa8ujHFZUgYOZ6HLj5el8ioWyri+1/yOqlArZqUN68eXLNTj4efqJwW62ThrofUKYRsf+7XET5PNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COGz5N9Z; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH7leVxJYmI0C0AtZtsmmnM45iiCUiz9w6T/Pbg7+gbiNd8jhcfAM1JEW8Hq4//MLBhMGqDex5HmowS7WNM2BCxM/ap5o2ogV0zbj/QDlWsldzDfOZOnpYZOaR1ytgc3qS1+34GA5zzY5h6uxjNeCHlBx8sBY4bNidRUzooY5/a78Bfsn21ecRqDCQ8oObDmqQUzIhKUtD0TEzuCDVtuGsWAe2kiJLWxzQLdGQPkC36X1kSZitd45tfiZ5M85IogmK8Z5VReRw0veEgB66uk//ISCZjwdBxKcQJolvA5yT9/DMbkxdV8IHe4wB2SxCH4dA1W+3Xp8HWLmN4n9DPg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUbjJXnib9EiC6H9vV18C3nn1EiLRyVYUNzy8Y9BqNA=;
 b=Mj4pKCxg7rKU/UKFIiqy4j4L4VqFdb3aPR1/sEXgpPmoCOaqTIJRIKj6A4QTcP2JTLJckcOpzjRWx9A8TpYZG33Gg0njQpFPdkvp/yv6LVZByrL1nUz3uQyIyaxGh4gXmoAcA2QABGFgHmAa25gMqMgUhf/T8LMSwH7UuNiUkTSp7w2K1Dy/S0wPjNzw9Y4Tv9/EAgwZY4grB6H9DyTxQN1FtjsbaYOs2IusnchM06Ay6N6iJc1suUWtyIJrOT5NX3ceOUCkC7nfmwqMqRQ07fAcT6TXFZBQflAe0SpwOdlFbCoKSqyYnd+u6xzTGECdDyFn2jNh3VaauxchhGHvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUbjJXnib9EiC6H9vV18C3nn1EiLRyVYUNzy8Y9BqNA=;
 b=COGz5N9ZiFEOes4MUcjQIbAAwHmVVzTBrQL9VmtUfDg8cXFY9hjNdMyY3ryzdifd8ayok7e8Ms79dXdtpSMZ/h6BPyhsaRLGuPPR9wqbxyj9vcrJHe3vsvGJVr1hglpW+phkfywm68It/EjfD7984Zo3W3F2NdFvT4YuSxwZap8gg0Kc+QyJ6yWxXW0c0rMIZNxb9ho834axJVb/GWn/5uWz8/0CuhbfQz2Bc+HzkHO0cT2iLO1W2zT67v8SSxGyBWEhwtwmHRIXUI1iPn7ZMDApIExMnTgvj3wYRnUZPb+iGU1ERnm5ISYabR4eYukmdd2czQ2/YRPYJOQxrEKJTg==
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.36; Tue, 5 Nov
 2024 20:05:10 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::16) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:54 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:54 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 09/13] iommufd/selftest: Prepare for mock_viommu_alloc_domain_nested()
Date: Tue, 5 Nov 2024 12:04:25 -0800
Message-ID: <f62894ad8ccae28a8a616845947fe4b76135d79b.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fe7baf-c359-4098-7a58-08dcfdd52715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sIrdTAd3tBws+qTBcsyW6qPxgmNLmxTN2uHY6ckyGn/ZZF7UfzfShCZsvL4X?=
 =?us-ascii?Q?15De4xwVNg5OfcjojdldSYLKaltmJP454WuIVC1szx+nnqflcNv+KnzaV7lm?=
 =?us-ascii?Q?5SyKklPKDw2/1oKtoVom2S61I76fiiTwVIBGqgL6bpjmxkV3vV7zRO8rd52p?=
 =?us-ascii?Q?HZcGiK0MSJOH7yYi4XwgyeU5fb66kO/aop98N10sfx03R0OJNN2fzDK5hVn4?=
 =?us-ascii?Q?aW26WyrznM/Nbl/wVMBh3OW4RZxz462Wz1iqA/38I3SFM8+ZvQg52V8Ta2aX?=
 =?us-ascii?Q?HDk7xq6zToP2SDugXTBBS6ScqV11X97fOZLcUa7Lw9q2qdY42dWxyLpDZLxT?=
 =?us-ascii?Q?GXceFVbndY6i9QpMn3MR0HLqNZZ/Ub+ju5clnoTzMwaIg9enMoudQh9pFu2K?=
 =?us-ascii?Q?Ud5Mtx45j/MRGFQve/uVX1MH7xnF1P4YS54xwC9P3JJk0iZTT+zs6SYXQhTf?=
 =?us-ascii?Q?kDWbY8jAO3kTGModnLndLE+4njlXNgfjCDYiy3eMQdtenGdYTpeCvYsW0ByB?=
 =?us-ascii?Q?mg5dVc+TfBAICg5WuDkl6+EW8KGrU+3RgvKbnA72jMBMUWkEZmckeOHfWlPv?=
 =?us-ascii?Q?8K+Gp/lL3r/BPkBhayd34ucoe2AekMn7PV9rwqBryvn1G6vUhp16aabU/M9P?=
 =?us-ascii?Q?aCMqsmNq1yAcZERWdQZ2V8ChZelvGwbuaSvt3ofDD+dJOwMWoEQ1sdbda5I3?=
 =?us-ascii?Q?/YvleGg1WV2jKb9Nfc+2P1AresM5Ech68ge6fXaV5ytkimW4rUgZFF4nAnF2?=
 =?us-ascii?Q?2dM/Qfk89lyyoqWTg3CzS7G72yDsMxpho3yoIxQQ+ra4ai5Kf04nHehE298p?=
 =?us-ascii?Q?5NwrJaEt2k0gkapY6Jh2aNBhmDA/RwAO0K2jLSFYLt52veOUW2+7VYs7tqEI?=
 =?us-ascii?Q?w/o+hLFoWKdzWo2U9+vnE4+x+7K1/7KCECDvRmRIbltRmThhmJs4rY0KkHd1?=
 =?us-ascii?Q?G+CzA1DkHD9lTuU2Y3EoaErHVxV0IQakyUF1r05qrvmlUPtNYFP0JlWILSxW?=
 =?us-ascii?Q?hNBo8qUgAjyQtvIXBsY2Ah9tojspAm5EpNfggy65/CcAnEK0SrELSZuw2+er?=
 =?us-ascii?Q?dYhL0wyp37P7ZoyXmR2dJIQsUZ6Hmng5Ou5qORsz6WA4aTDV2/hHE2bM4/OX?=
 =?us-ascii?Q?gPsbt3+DY5XohUQgyTRT+XA5EjFg89CJWrn+BZpruQ7sNuRdCB1TUS50YGQX?=
 =?us-ascii?Q?dPcpDGi6YQTNf0iNDJjGD/Ty9LUx35/eapAAAXKLehOfDvwI0/F2zsfyfStd?=
 =?us-ascii?Q?R2U42kX08HmmwLuCK7ybv+YM/eeiUd5blS+BL/pnAef21ikpzTp5nUQqbRgH?=
 =?us-ascii?Q?egUD7OeVy3ezmN6Id0uUCxqmtyQl9uUnH+xkYCEAtqWjFo432tROdysnl6Ni?=
 =?us-ascii?Q?9olpe5qej901UtiAWK5g4nQh6OYedjCVYzkiXhBPv2KKF/9z+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:10.3316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fe7baf-c359-4098-7a58-08dcfdd52715
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

A nested domain now can be allocated for a parent domain or for a vIOMMU
object. Rework the existing allocators to prepare for the latter case.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 89 ++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 322e57ff3605..92d753985640 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -318,55 +318,39 @@ static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 	return &mock->domain;
 }
 
-static struct iommu_domain *
-__mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
-			   const struct iommu_hwpt_selftest *user_cfg)
+static struct mock_iommu_domain_nested *
+__mock_domain_alloc_nested(const struct iommu_user_data *user_data)
 {
 	struct mock_iommu_domain_nested *mock_nested;
-	int i;
+	struct iommu_hwpt_selftest user_cfg;
+	int rc, i;
+
+	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
+					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
+	if (rc)
+		return ERR_PTR(rc);
 
 	mock_nested = kzalloc(sizeof(*mock_nested), GFP_KERNEL);
 	if (!mock_nested)
 		return ERR_PTR(-ENOMEM);
-	mock_nested->parent = mock_parent;
 	mock_nested->domain.ops = &domain_nested_ops;
 	mock_nested->domain.type = IOMMU_DOMAIN_NESTED;
 	for (i = 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
-		mock_nested->iotlb[i] = user_cfg->iotlb;
-	return &mock_nested->domain;
+		mock_nested->iotlb[i] = user_cfg.iotlb;
+	return mock_nested;
 }
 
 static struct iommu_domain *
-mock_domain_alloc_user(struct device *dev, u32 flags,
-		       struct iommu_domain *parent,
-		       const struct iommu_user_data *user_data)
+mock_domain_alloc_nested(struct iommu_domain *parent, u32 flags,
+			 const struct iommu_user_data *user_data)
 {
+	struct mock_iommu_domain_nested *mock_nested;
 	struct mock_iommu_domain *mock_parent;
-	struct iommu_hwpt_selftest user_cfg;
-	int rc;
-
-	/* must be mock_domain */
-	if (!parent) {
-		struct mock_dev *mdev = to_mock_dev(dev);
-		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
-		struct iommu_domain *domain;
-
-		if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
-			       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
-			return ERR_PTR(-EOPNOTSUPP);
-		if (user_data || (has_dirty_flag && no_dirty_ops))
-			return ERR_PTR(-EOPNOTSUPP);
-		domain = mock_domain_alloc_paging(dev);
-		if (!domain)
-			return ERR_PTR(-ENOMEM);
-		if (has_dirty_flag)
-			domain->dirty_ops = &dirty_ops;
-		return domain;
-	}
 
-	/* must be mock_domain_nested */
-	if (user_data->type != IOMMU_HWPT_DATA_SELFTEST || flags)
+	if (flags)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
@@ -375,12 +359,39 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 	if (!mock_parent)
 		return ERR_PTR(-EINVAL);
 
-	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
-					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
-	if (rc)
-		return ERR_PTR(rc);
+	mock_nested = __mock_domain_alloc_nested(user_data);
+	if (IS_ERR(mock_nested))
+		return ERR_CAST(mock_nested);
+	mock_nested->parent = mock_parent;
+	return &mock_nested->domain;
+}
+
+static struct iommu_domain *
+mock_domain_alloc_user(struct device *dev, u32 flags,
+		       struct iommu_domain *parent,
+		       const struct iommu_user_data *user_data)
+{
+	bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				 IOMMU_HWPT_ALLOC_NEST_PARENT;
+	bool no_dirty_ops = to_mock_dev(dev)->flags &
+			    MOCK_FLAGS_DEVICE_NO_DIRTY;
+	struct iommu_domain *domain;
+
+	if (parent)
+		return mock_domain_alloc_nested(parent, flags, user_data);
 
-	return __mock_domain_alloc_nested(mock_parent, &user_cfg);
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = mock_domain_alloc_paging(dev);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+	if (has_dirty_flag)
+		domain->dirty_ops = &dirty_ops;
+	return domain;
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
-- 
2.43.0


