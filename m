Return-Path: <linux-kselftest+bounces-21172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41629B6F4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AF5B24014
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860B2296F5;
	Wed, 30 Oct 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fN/uYz3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E72296DD;
	Wed, 30 Oct 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324135; cv=fail; b=i0ft/uLqVJR8SKbSLA1P+s3V8of9n06nu5SJXi9KvwaaTe6PNvt9p6sUCY358Lxwl8mBKe32LqAt/94uci0P61zQcqvk6s/7O6tPsFHybrXTAvDQxhFHqjpa+/q459l56sqkogb7CxZyHObIYvWsGv1hpRaM5IWdxCh442Sdl+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324135; c=relaxed/simple;
	bh=ju5HyEZzFfmDYHxRYjKrj8DcYQoamkrIU8iuQIhWIUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbvktbvBKrkqALbv2AWqJIkEKIm1A2y0tAHVoGFhgTlODUxT5fUcS2TziFU4yvRukgH+VKbOxY1XwV+EouQpLe6ZtaAoKE8sE0G+dO0DDfspOiaAQHp3b4aA0axCE17abNRn6Fh1ifd4JxmBa53bzDIKGTwlVp85wesD0kBe4/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fN/uYz3L; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv9dfzaLiUNkpdprP6gr7EYeRxcZ+lRGkv4cgK4m7OE4XPcG5R2q2gcBtUTH2Zj+3PzMwPJ+ID4XSh50FHdpUO2LlYVtrs1/9xk4Bv/jZ8dGpfEJA+uNgM81nIajEIdtgkeFTLBwo0l8dUQJf31PYSkcVXIQRg2J9yV7jiBJsA5iSngDDPdQqeXYzYCZOgJXnGmfwQE1tm200256dUr9wlPDVBOqhzCD3In0xS44CH/D0FqEewkelSYiCGTni4tBEf+gpeAc5vvOh8TGdgPdWw0gOv+IdeSxOG5SeOmovxeIpkBO8xVymmY0ntcot4p5lnZPYg01J25BBy8jXhbo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae3NYYj8Mb/IQHqia9NXSz9x6kihsiTvFqB6gqoxl+Y=;
 b=YiRGxyniUchf+35Ky9PgDMi6fyeFdOXFSrLRygi9TcWl9bL3ULRhK0t1pLGNamW7oQ6Iju+UYPAsXPVRzKATGkKmIAGETrGfFY7yX6tEu8mE8nruiAv+KNCtLptfmcF5hj4t2qwdBR0OXyiLYyUbZYGUpLbiXY8H2u9hQ0uz3kE3Hix0FoRVPQxY9M3LP4pKTi7g5Y8hSXUloDTi5Lm6pP9QD2U3exvhxh/JR+6Xn4IfUsMYbiBxIS+e6JdRoHh4FBVIBOHEe9SK7OZgmL0+HkALBsjM2duTXLdr1ZRTvR4xsIMZOqL986XC50MXWsUujtM6+XrnzRCEgB+KY9zUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae3NYYj8Mb/IQHqia9NXSz9x6kihsiTvFqB6gqoxl+Y=;
 b=fN/uYz3L18GiZYSl1IoPjcb77WbgktvFW0/58lt42W1fmPBcxfpUY1u3Xtr6ynO45MbL0Bz3Rmvk/uFgEHQ2Xf2mwAj9M8E8nyAzNzQUSmoXzg0YF9uj9zk/Gors1/anZDKT+LA6OrpUHjDXGhknV3ct6CSXOWzbCjtXaPHwir5xFxErxJqa4gZVhsunv4/L+sMJRE/kWRt4zsSpeIhSvBAYPwez6HQf1H8ziAC9j9hFYKif9Nsio2KRLnnjO1VN0PsKyxUKJYU2jxIGuUwqGuVbsJxJ5QoM7X6jS5PGghktpC6JeWugJ8wVBdDGsh6CdmWSR6iiXzAVq283f04Dpw==
Received: from SA9PR13CA0126.namprd13.prod.outlook.com (2603:10b6:806:27::11)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:35:22 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::2d) by SA9PR13CA0126.outlook.office365.com
 (2603:10b6:806:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:07 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:06 -0700
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
Subject: [PATCH v6 08/13] iommufd/selftest: Add container_of helpers
Date: Wed, 30 Oct 2024 14:34:34 -0700
Message-ID: <e5ee98fb4dccabeba4653680c37063146d3cee6b.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 280cd6c8-7338-48c8-7066-08dcf92ac21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bp8OqrSLIedITnY0VY8QtLyDQA77iS1mw6V2mewU8eUOWNriNgabARMQXASn?=
 =?us-ascii?Q?ojhknmWVG5ZG/mM8sNqTvGg28TJkr0BEmETcjAXdXr+tS7BO4oK0wtGSdGFr?=
 =?us-ascii?Q?BcDRGz/5E3oURHMm6rQU82k7OKmcRMnqkCHYQFkAI7TI5HvOmVspjTLZs+ue?=
 =?us-ascii?Q?Ob6OI3l5HJ0oWY0OdaogFT5g4kI6FwCAvpJh77BKqg3UYqEOV5G3gphEh138?=
 =?us-ascii?Q?3qwtudKJTZmxQq4EXjk20QiuZW8EcG07cukZN0l8wJ4BhEa+u20BmxMDk0iz?=
 =?us-ascii?Q?dm8+IXN+C5G1xhg5e1kCqa5BDzbcWXo7f4IHqNHZY39ZyP1AXyRSEy+gzgYw?=
 =?us-ascii?Q?kPhSa8VCK0/yDvFtmkZYeefTcoxpbtYmo1ARNBn+T2YiW2wU73ne+IxbvOIB?=
 =?us-ascii?Q?X1Ef0tHLQb+OuZifc5Zhhqhgdc666HOwKx+lSIHGlXjwzc4Ip6w2NgT0xQjT?=
 =?us-ascii?Q?G7t5CfqUan4CiHtOLONQf0MItr/Ephbb35mjXZTdySruOUArflIKTt4vpUW7?=
 =?us-ascii?Q?/y6J1vru0IxUEIh6t3A3JgIlQDwTiMTRuMeS3eaxjcc3R6HscVrXsqikSSM7?=
 =?us-ascii?Q?4x0CubqRp2itjDmxcELdtY6diA9N+12JmrrzDNYWpr0BRQoMwhOSWhdL7d/V?=
 =?us-ascii?Q?iw4ZL19BmFvjFav8Q18RhfALiOSkp5AIfUt9uaFwqXLE5kuJF9Qv0N9+8qWo?=
 =?us-ascii?Q?2U0uvQ78ztJ6fKOfFJY/ExhxK2w+9vF8G/0jnvK+XiARfWo95nAMIttdnCVs?=
 =?us-ascii?Q?LpR3LfmDjMA6nV/Lt/K7zuwEvRWmlX7QFAMEK8vmxD/VQJUnVvoDcOruuJNX?=
 =?us-ascii?Q?j8rDHyrSaKfXCZ7a5QPOHIrjW6K/NLDXnfajl+CiDOUvkW2Umw7zCeBnblUG?=
 =?us-ascii?Q?x9BCzhzof4N4MvIjZXVtmlYpXSsZ8QNl9VHTrcnPG3q+azbq8VyW6MvZQ5Mf?=
 =?us-ascii?Q?TVAr2rnpK39ucCs278esumES5k1qmO7hrVfjk3cthAqX6UsUWwEdhXhHu6cP?=
 =?us-ascii?Q?qtsSGycllMNrAil7/8QowgMoOZ4SRXbxI6E4Tfg3oe3bULSnRDh0y8CigSMA?=
 =?us-ascii?Q?1VvNRjdjxs74TiuQbnl95gRCsjKv+xApXxMmYvkXySq4zjuKYpz70C+qPwpI?=
 =?us-ascii?Q?MZ6LNwmjG6BGJ2yyM3qvxTdu9bfzjLyhJ7GInacCHNc8k6CZO8Q5H/uw1JvO?=
 =?us-ascii?Q?VocoPrJqoesdaFm8IHgre7Z567uBVl59PlKZteenya4hXzHTTnnEOexVPXfb?=
 =?us-ascii?Q?0CzZO1hiGCv7Gg7XfR59ZjNuXf7bdP7kPB8SSGq/YbrvRY8waLCTUgFtENns?=
 =?us-ascii?Q?4u3mOP8cPNV99xCeaIZkT+3zzNCRDfqeqOEvFMLW0EZks7UvFLSW1wtOYxoR?=
 =?us-ascii?Q?+dlUuYicIXtQRikjmj3UX2Vt4pm/l92fOXsPqnW3V/UMe5Ot+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:21.9235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280cd6c8-7338-48c8-7066-08dcf92ac21e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

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


