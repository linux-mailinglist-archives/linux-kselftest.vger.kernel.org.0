Return-Path: <linux-kselftest+bounces-20724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A562F9B136E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA31C2166B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02202215C7B;
	Fri, 25 Oct 2024 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BoJGO0Y8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E18215C5A;
	Fri, 25 Oct 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900225; cv=fail; b=jPF9bhwo3/Tkw3/kvHrBxqUMKt/rcAN7HJV4BsDzAcYGbocuOHhHW1tO9ZVsA1YBP1cZOP8bukOjy4wge+XhQrDJMFW2W9KcDNfK36wbofbu9tD3duW6kHenUWj3ZNknYg/GdBMEBAkU0xxc1JyiMRVY0o/W1miYNOpcxsYFWng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900225; c=relaxed/simple;
	bh=JSfewWgNwvus83Nv+oNO8znMzG9DOtcqjmbDWCpJERw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHQ+a9sUG4vKvyhQCuQNUc/FOPBnTTKfVq83V6q6YmCL5k/XlRug89CTbbHBHqJuuBfz4bN2J7+WocTBKOzdROt8kKsBx7xN2syFDBaeJ2FwsItXKXIJIGKuZMpNICn8ucSV8CqyVqylu4OvF3H6VwZdzJXPd1YzTEUCrsMCK60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BoJGO0Y8; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQRhye8uvDqSc1k1yw/d2598JHmnZ/DkkokRbilsoOWcjDV9xhj8rC4jIv0F5KrLfqZ3/anNjTUu3+AQa9RLRkzeQA1mUq+Rdnyhzt8EwqUCzFx4pnJh+KhGtS1En45JWBMiElekiP3aaSPQdkAx2QvtThYgrxU33QeA+p0+OGWjoQcL06OfKMGRdFADKfQaXeDO1NAVXe/sFx376btHTMwwg0Upyoy6MBlrSYc6y+rPg+nwIJML45D6biE2z9MOSwocmkBXJWm35ZdQJ3PWaMYFyas0lsSECWZLKXaj9XBm0XeIsonL43Ol45FOYlslpj2OaDhlwRK9U6bzpvkJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtVtofzp8OcKTgoQwZaMi8BeKjx7X+hMztGUPlaFmbk=;
 b=TVA9ixHHhpSuiC8xXh7+uy5JxsqeNpAfKJRKEbl8nQUHlWq6Oe6WiZXYy6IHEEj0K/cIoxwPE4/m/0kXW654njsfEKFUP5LT9Q2iCjMANlaE2wNwT2lmNlFRpsuz1iy91AS7+u0RtFlLgYY3N/D2rMIFxAjUjGSgb0l451j2HKQhZXAUA9B39qcQxgOoMde4NlF1vUe5ClLzCiU/Vl0DoySPz3n+brh2rF0VFXbfq6TJIvGE90Bjlv5txfmYjYpVCMghSnstNOrgAGVPfkpim/xAbadlch/71Vrj+0/TVIJ9/lLbzxYDs/03hlf+LcaHbVQIhz3kNh/JZOLK5SqwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtVtofzp8OcKTgoQwZaMi8BeKjx7X+hMztGUPlaFmbk=;
 b=BoJGO0Y8EOVV8BYejXfWSfskk2G+e4nn4kTVAbE4cn8mk7MktyMHt9GQewKbP45BR/hdMa/mH2Jbf8yY/ZhjktKYAYAkJiC0+JVx2rC7+T2REBNrYq1wn43kab/DMyPT2jAELfqT49cVqAeIBalhYxCFqIN/3ju+gySyoXsoFfpKKOMXmvequwXWXWfFNEZ0ZmTPFMe9pywhw9dY6eHuzIBBZi5mjj/WgdDTlBSzLDw3XPKwKIwi2uLMUoVR4tHQhaJrxrPkXtP5JYcEFGyAO4IjyFwLjxpccfKWel5YS5WhgTcE7P6I190nBxX8L5EjrcAwto29Q1a0W2UEUIHOPQ==
Received: from SJ0PR05CA0135.namprd05.prod.outlook.com (2603:10b6:a03:33d::20)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 23:50:17 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c8) by SJ0PR05CA0135.outlook.office365.com
 (2603:10b6:a03:33d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:11 -0700
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
Subject: [PATCH v5 07/13] iommufd/selftest: Add container_of helpers
Date: Fri, 25 Oct 2024 16:49:47 -0700
Message-ID: <53484f80a671edcf337e93b2e2292f318eefb540.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7e5e4a-51be-4d41-63c8-08dcf54fc747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrdKdd3GZ0Wmifm8nTyH12JrxJWMKzwlOjdjfv5B+M++loFHM0eTRMUnOW5h?=
 =?us-ascii?Q?sQD0tlieBxrvQvNau/0iPBVSdPTXmsw3Op3sg8l4qFl2fPBqMDdJhUFsTViO?=
 =?us-ascii?Q?5epv3BmoecFWqXX9m1yPLRcOOr+8IJSZCW/aQPZLkuYPoj7HS6/X/C+eDcfV?=
 =?us-ascii?Q?9CoZVsY4OORjwlKd1zCUJPjeT2wdWsP1GAAdczn36TFRHC86nhVAgM3J54jR?=
 =?us-ascii?Q?rwSDdqnQRELZO8L9et742xNfwkhlc9hp7l3isJFZeKoA4z94iYDLnWdUIiOy?=
 =?us-ascii?Q?rkw9+G8ox/QjE9ioICIxYvDgxwIRsf324HH0M+rHo1NvT3g0KsvwvyzCLF2J?=
 =?us-ascii?Q?AyDydAfZqOM65sfnYW3Fgr366kSj3WKibsUm/PiApP56+b2hSTh17hQhgGDx?=
 =?us-ascii?Q?m2wRq+2f+1uFk2foRQpBlo63tyYrmTbcUsmXfxx7LowZ/D3KQPhd4FGDzHwa?=
 =?us-ascii?Q?EcFk8+2VPejKaAu6pICjvup7+JXNRqJXkJurzlkeHlX/EjLbSkNwcl8ZKd7O?=
 =?us-ascii?Q?MzSuApGNMcAOPCvjSza25lMZqZXmMZRiKKLf9lTMxOp1tCUo9n8eEBDTpG3B?=
 =?us-ascii?Q?y0NwjeYuWLGPCPlFh0ZqFS92zcGwIiHWdKMsg9A6aAMIbzkuPqrUM4OyAQkY?=
 =?us-ascii?Q?KXhCfnhd0kz/RsdUUaw01YP7NDXJeJbuOkhQNitH7AUwQyOyu3gheytyJ4D3?=
 =?us-ascii?Q?rFwxuZlJP3tMDR7JIiHlCpV3E2o1Quq9CHN/prmYN5Mp89pMfpTKkAUJnKDZ?=
 =?us-ascii?Q?Dsa72nsyephS/CZuSXvGdia5ImU3+HA8cl7rCkGnBAJJ8z3QcIyzQJU6SBU2?=
 =?us-ascii?Q?XkjiFOV+Xk53XIs58eFCH5nRcL1AJ7QzAl/mjsvELB228YBJ+2r5hPhZB+cf?=
 =?us-ascii?Q?kRaYW9WOnsv+898L+5rH6MOhES7WmgnLnlr6MbMK7Xzkg/cTz0GNt94XHoWT?=
 =?us-ascii?Q?3dDtJs4S3aOnNVfLaJEndm1KqwduhUxcs1bvp/j1dSDT3Cr+Z4K/bQgki1GK?=
 =?us-ascii?Q?6hgGzIs/7aIqX9JXhXhTuH5j/LcrsnZYXijb5J+L3pUIUr+9IOuDT8rvhJzD?=
 =?us-ascii?Q?EPT/ZaTlkVqcddqx4Zxpsanywr1APR+VUl5mql0Ad97l94Vn9y9TEyh5WFTU?=
 =?us-ascii?Q?U5h61GINv7IQmkW+zdTAEE7sk2Ns3ELTOp4jHxQj9y3Waw7WK3D2307fjcK5?=
 =?us-ascii?Q?d9D3IDoIrEmy5dCDH+Vsmsz54m6uQWDY8wDFClFXzrfjBq+xB+wL9Vl8BYIF?=
 =?us-ascii?Q?lMC6hL3lBW3xytIjo10T4H9LOKlogeS0iaDwyg2i71GQHBGxE9c6kIgKHptj?=
 =?us-ascii?Q?t/4Q2x4kABimUuq1sGsNO8D6BHsgciEG0DUmcBGEigcE//UqIcZyAMu+pajq?=
 =?us-ascii?Q?N+EXlFrGUXaAvEXgvYIW7/KKv6mhpG+4olzY5flisJNJmz9etQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:17.4021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e5e4a-51be-4d41-63c8-08dcf54fc747
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917

Use these inline helpers to shorten those container_of lines.

Note that one of them goes back and forth between iommu_domain and
mock_iommu_domain, which isn't necessary. So drop its container_of.

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


