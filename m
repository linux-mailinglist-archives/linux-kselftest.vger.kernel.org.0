Return-Path: <linux-kselftest+bounces-21480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C39BD697
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A80F1F23FA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B1216A3D;
	Tue,  5 Nov 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bTOr/O5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B21FF7B3;
	Tue,  5 Nov 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837117; cv=fail; b=YYfp/0LMFhEVd2OAAVaYZ10IzOJP33xL/FSeowhpsMMNTtl3V1RoMCl8qVVYwLGATOsnTjukdjwlPOLBYCQP3KgcD3bygR8wNhggifaaSr2eHRtxfe7sfUAwA8xPjES6ouKiU3YFCWtF5/4Td3hT1qf58iBs8EAqVdLv5a5lFCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837117; c=relaxed/simple;
	bh=ju5HyEZzFfmDYHxRYjKrj8DcYQoamkrIU8iuQIhWIUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEjdUbn6Oy687gtbZh4MY6BuUX4tWUoIDNE7NqhClH7lg/6xyqBueJXP2wwLm1+X6ILylB6I47V+AEJUdhKZN1Q2dWL8CXjFi5OtI/VxKYfv4pkbgvETMt8esT0qsTEn9unihDTcil2fUUF1sFCQwIyNPzv2K0ZnSDdujqwRllc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bTOr/O5b; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vW7NbkTY96mY2q1b7N9D/x9gT95u1DafmK6pFSkZ1U5fQkP2SiY88slAkwVC1lg+vyYiLQ19wbryqZMmrmrit5cUFbRdA6QM/n1UD9YjB1nKqlfHPZWQYlrj7HAjQ90vFALqkaEBzlyjiKMh5yClD2aqow07ZqYjeXK21Y5klrMZnjqSlLPyLqBChNYp7r9L3aOVFWR0VZZxjHXxHY1FiRiyh/+T66u8lSqnHsf3XQQuHrdF7PJkB5NFZw1rvNEU6EoA+DCkoplw3+DUFuamZkZnpbzbdG0raKVhkoc/pDYLF8JNNb5UldNzUzfR97lKiioG+7PuZBuYBwiyAuJXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae3NYYj8Mb/IQHqia9NXSz9x6kihsiTvFqB6gqoxl+Y=;
 b=UBm9+5kfgOvKWmuUYbzfGHKPas7RYA7C8XHt+5pbdSzAV6SRKFYRS+vpZNe7DamXBCw3H3J20hWUcvjjeZm9mbMTcQQeOMZcJJNb95VhoxnqjVvVsGvOL9XFWR2EVKzyVHBJVv0Ghf5H9yFgDwizxklBrCjY2HHhLonNqhzaKQxrD3Of19ts5+wk0U9y4QC1TJQ9AXY235gSVEN5UkdEl9vzZ7zUoHIADVeESOzBB7500OmTqKOXE0AWdj0E3Rfduc4fp+n7Cu2HJsD2LSPA1gJMb2VlG0H3PuHkj+x42HydMo4MR7BaEl6R5sUMKTOkJFNTqZwrg4Kdd610kLqKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae3NYYj8Mb/IQHqia9NXSz9x6kihsiTvFqB6gqoxl+Y=;
 b=bTOr/O5b7uk0kxM2X6u2ZnY9oUCH8BdblikIsmXrcerLtKTG3EDcPWUBkO2FRw3eznYuN+K9d9lrLnLBkDwPLhTIyksS3OC2DsukEiz9X56l2r+rstzD3/HX+drNrS9F5IO45L1yZVMhHNVJyc6v6pmzWkPGgdWUjtBos3cAnjX4KBkUeB37MiQlRqdmtWCe4wiMSBJk/oA8I/qROiZ5pMrwZo7CImnXB88Ni31dV2MUER1F5TI+PgBqXZxxdXaciYhFNnfc0GYQf/HzzQLgx5MJjeXgDENDJOpMivxrU0EwqCbCdT594eE7V3J0j7u5m/JUvG7/Byj5aVGY8S2g9w==
Received: from LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::33)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Tue, 5 Nov
 2024 20:05:06 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::f9) by LV3P220CA0001.outlook.office365.com
 (2603:10b6:408:234::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:52 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:52 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:50 -0800
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
Subject: [PATCH v7 08/13] iommufd/selftest: Add container_of helpers
Date: Tue, 5 Nov 2024 12:04:24 -0800
Message-ID: <518ec64dae2e814eb29fd9f170f58a3aad56c81c.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe2a915-a9c9-4565-9a53-08dcfdd52448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Hdb4RCo3sTaNKjeiJwfxIkMh85OX0oM9iDku6b9+wVHIMcwP0ayPbj0msWS?=
 =?us-ascii?Q?gP+dmGlksL8ZwPGRPYxO7VhSN/t75TEnljxz8cs6OWhPy2vFeYSC8tko0wqR?=
 =?us-ascii?Q?oUa3YwHpykgOOozaXRMW5FdjGjS0qaMZWOLRRE8KMFmNR3fMePKGye1rr3MM?=
 =?us-ascii?Q?8zqClsTkv3cHnz/ofNvHdhyTV8K9GqjPrvbI3bTwCMcvptqa7efi6kYoIGkv?=
 =?us-ascii?Q?D3fH6e61PyKga1EMP6/IKweTOw4EUff7tGHH5MduAiYYGevYgn+nAdNDzEZd?=
 =?us-ascii?Q?ej9dHaevAfEKtTwjR0l1Ci98XRM7li6KBV7ZceV6dC2uVtaL6My605ECl5gG?=
 =?us-ascii?Q?bZMmuiZhgIrRNb2+Ez43j/l8fKH5rAOQytkscXWY06OO5uCM5LPRHminRACw?=
 =?us-ascii?Q?9IEHzuS0O/VCzSuDDuMrDvBhyRJFJlWYEVXv3oiJFOLvK7ZHJ7pUG3GqYwSM?=
 =?us-ascii?Q?sIkOVYnn4GrDEb4qJ7o/DmaB2R3jsVOWtS8OhlkXORi69VWbxpmmtBPu3w//?=
 =?us-ascii?Q?xR6IKvVcYki7uAF1ejPD8NJZJ6ItbAxDW5sc+tAuiYS/n6rL0+wj0ETYR4Ky?=
 =?us-ascii?Q?F23tjCAe4ab+mHeR5xizxv57dWnl3+jE240lDQ9YTinwvmUFpn9AO/4fUOxg?=
 =?us-ascii?Q?AsRneor9AkH9Ki0i/bvUzqeXWJX/s6jT+SYNC9b0Kmx3ORa6XNibxQ114ywP?=
 =?us-ascii?Q?EkEswL/9Vg0csHYOK712KCCxTZBsHPwR58WWQ4iM2h0JVswKZq9gbh+XgVpb?=
 =?us-ascii?Q?PwUIcLqmGitkhO/EYyZHdlKhM7PCvX9Okp0OXyaOcmVUJ3AFk7S37NqUqtMG?=
 =?us-ascii?Q?ErU6k1B+MtXsFPHQo0nMredZ2Biaqyn0+SI3RnJFXkvDOqvpRYlhVHSwtG3l?=
 =?us-ascii?Q?4H6chamX8ljpYaXNECsbBQRo4xIwiAchsE8TatiSRY2V6LZb0qf5j2ndOFB0?=
 =?us-ascii?Q?rEccsysbdV070QMQoq2FDKFzrMKTdBofYU8SRMl1muab3VxIEk2s9Sjp0F3q?=
 =?us-ascii?Q?MP9geSIm4i9fz5y6FN8ctihPV2axBZWRLiSQ50uynPvEIeLh4qtTtIOiJRwx?=
 =?us-ascii?Q?JzXHl/dG5AVPaMtBdgk1VbM61zaJklLwMzae/mXysvRW+551+pZmbX/B0rmH?=
 =?us-ascii?Q?yKhXtrlPQSz+xNbbbE16N9Lm78L69VMns1/NJAVkArUBUcEchtlcqMpWWort?=
 =?us-ascii?Q?2+yF3yjoyWp1l7Tjpeq/HWY+w9gxHrmP3HSfP/sxJkIC/PZBkg8/kPfFZSeg?=
 =?us-ascii?Q?8lHK8eyShr8EdhYPoQ7ndXawvEwvjE88vOtEFPpjhKXo7ojFUOauNol2env8?=
 =?us-ascii?Q?/K36I66MmE/Ix6P11Fo3Ok+nbzAGosjosCDgCUV0+ekFbW+/XFxfO58QqZoj?=
 =?us-ascii?Q?SBE32hohgxAuq0sdgeBR7/XJGY0OPiFF6cwPazyWhRtgQIuExg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:05.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe2a915-a9c9-4565-9a53-08dcfdd52448
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

Use these inline helpers to shorten those container_of lines.

Note that one of them goes back and forth between iommu_domain and
mock_iommu_domain, which isn't necessary. So drop its container_of.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 75 ++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 540437be168a..322e57ff3605 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -126,12 +126,24 @@ struct mock_iommu_domain {
 	struct xarray pfns;
 };
 
+static inline struct mock_iommu_domain *
+to_mock_domain(struct iommu_domain *domain)
+{
+	return container_of(domain, struct mock_iommu_domain, domain);
+}
+
 struct mock_iommu_domain_nested {
 	struct iommu_domain domain;
 	struct mock_iommu_domain *parent;
 	u32 iotlb[MOCK_NESTED_DOMAIN_IOTLB_NUM];
 };
 
+static inline struct mock_iommu_domain_nested *
+to_mock_nested(struct iommu_domain *domain)
+{
+	return container_of(domain, struct mock_iommu_domain_nested, domain);
+}
+
 enum selftest_obj_type {
 	TYPE_IDEV,
 };
@@ -142,6 +154,11 @@ struct mock_dev {
 	int id;
 };
 
+static inline struct mock_dev *to_mock_dev(struct device *dev)
+{
+	return container_of(dev, struct mock_dev, dev);
+}
+
 struct selftest_obj {
 	struct iommufd_object obj;
 	enum selftest_obj_type type;
@@ -155,10 +172,15 @@ struct selftest_obj {
 	};
 };
 
+static inline struct selftest_obj *to_selftest_obj(struct iommufd_object *obj)
+{
+	return container_of(obj, struct selftest_obj, obj);
+}
+
 static int mock_domain_nop_attach(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct mock_dev *mdev = to_mock_dev(dev);
 
 	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
 		return -EINVAL;
@@ -193,8 +215,7 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 static int mock_domain_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 	unsigned long flags = mock->flags;
 
 	if (enable && !domain->dirty_ops)
@@ -243,8 +264,7 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 					    unsigned long flags,
 					    struct iommu_dirty_bitmap *dirty)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 	unsigned long end = iova + size;
 	void *ent;
 
@@ -281,7 +301,7 @@ static const struct iommu_dirty_ops dirty_ops = {
 
 static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
 {
-	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct mock_dev *mdev = to_mock_dev(dev);
 	struct mock_iommu_domain *mock;
 
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
@@ -327,7 +347,7 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 
 	/* must be mock_domain */
 	if (!parent) {
-		struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+		struct mock_dev *mdev = to_mock_dev(dev);
 		bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 		bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
 		struct iommu_domain *domain;
@@ -341,8 +361,7 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 		if (!domain)
 			return ERR_PTR(-ENOMEM);
 		if (has_dirty_flag)
-			container_of(domain, struct mock_iommu_domain, domain)
-				->domain.dirty_ops = &dirty_ops;
+			domain->dirty_ops = &dirty_ops;
 		return domain;
 	}
 
@@ -352,7 +371,7 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 	if (!parent || parent->ops != mock_ops.default_domain_ops)
 		return ERR_PTR(-EINVAL);
 
-	mock_parent = container_of(parent, struct mock_iommu_domain, domain);
+	mock_parent = to_mock_domain(parent);
 	if (!mock_parent)
 		return ERR_PTR(-EINVAL);
 
@@ -366,8 +385,7 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
 
 static void mock_domain_free(struct iommu_domain *domain)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 
 	WARN_ON(!xa_empty(&mock->pfns));
 	kfree(mock);
@@ -378,8 +396,7 @@ static int mock_domain_map_pages(struct iommu_domain *domain,
 				 size_t pgsize, size_t pgcount, int prot,
 				 gfp_t gfp, size_t *mapped)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 	unsigned long flags = MOCK_PFN_START_IOVA;
 	unsigned long start_iova = iova;
 
@@ -430,8 +447,7 @@ static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
 				      size_t pgcount,
 				      struct iommu_iotlb_gather *iotlb_gather)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 	bool first = true;
 	size_t ret = 0;
 	void *ent;
@@ -479,8 +495,7 @@ static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
 static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova)
 {
-	struct mock_iommu_domain *mock =
-		container_of(domain, struct mock_iommu_domain, domain);
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
 	void *ent;
 
 	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
@@ -491,7 +506,7 @@ static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
 
 static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
 {
-	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct mock_dev *mdev = to_mock_dev(dev);
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
@@ -571,18 +586,14 @@ static const struct iommu_ops mock_ops = {
 
 static void mock_domain_free_nested(struct iommu_domain *domain)
 {
-	struct mock_iommu_domain_nested *mock_nested =
-		container_of(domain, struct mock_iommu_domain_nested, domain);
-
-	kfree(mock_nested);
+	kfree(to_mock_nested(domain));
 }
 
 static int
 mock_domain_cache_invalidate_user(struct iommu_domain *domain,
 				  struct iommu_user_data_array *array)
 {
-	struct mock_iommu_domain_nested *mock_nested =
-		container_of(domain, struct mock_iommu_domain_nested, domain);
+	struct mock_iommu_domain_nested *mock_nested = to_mock_nested(domain);
 	struct iommu_hwpt_invalidate_selftest inv;
 	u32 processed = 0;
 	int i = 0, j;
@@ -657,7 +668,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 		iommufd_put_object(ucmd->ictx, &hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
-	*mock = container_of(hwpt->domain, struct mock_iommu_domain, domain);
+	*mock = to_mock_domain(hwpt->domain);
 	return hwpt;
 }
 
@@ -675,14 +686,13 @@ get_md_pagetable_nested(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 		iommufd_put_object(ucmd->ictx, &hwpt->obj);
 		return ERR_PTR(-EINVAL);
 	}
-	*mock_nested = container_of(hwpt->domain,
-				    struct mock_iommu_domain_nested, domain);
+	*mock_nested = to_mock_nested(hwpt->domain);
 	return hwpt;
 }
 
 static void mock_dev_release(struct device *dev)
 {
-	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct mock_dev *mdev = to_mock_dev(dev);
 
 	ida_free(&mock_dev_ida, mdev->id);
 	kfree(mdev);
@@ -813,7 +823,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(dev_obj))
 		return PTR_ERR(dev_obj);
 
-	sobj = container_of(dev_obj, struct selftest_obj, obj);
+	sobj = to_selftest_obj(dev_obj);
 	if (sobj->type != TYPE_IDEV) {
 		rc = -EINVAL;
 		goto out_dev_obj;
@@ -951,8 +961,7 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	if (IS_ERR(hwpt))
 		return PTR_ERR(hwpt);
 
-	mock_nested = container_of(hwpt->domain,
-				   struct mock_iommu_domain_nested, domain);
+	mock_nested = to_mock_nested(hwpt->domain);
 
 	if (iotlb_id > MOCK_NESTED_DOMAIN_IOTLB_ID_MAX ||
 	    mock_nested->iotlb[iotlb_id] != iotlb)
@@ -1431,7 +1440,7 @@ static int iommufd_test_trigger_iopf(struct iommufd_ucmd *ucmd,
 
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
-	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
+	struct selftest_obj *sobj = to_selftest_obj(obj);
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
-- 
2.43.0


