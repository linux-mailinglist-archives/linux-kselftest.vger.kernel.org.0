Return-Path: <linux-kselftest+bounces-26091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4DA2D50D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA1C18867B1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296C1C1F07;
	Sat,  8 Feb 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+kMnVRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75A1ADFEB;
	Sat,  8 Feb 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005421; cv=fail; b=Bpu4wdcG+JEfnLBb+bD8r3ABU9pVSN3K0oQPexAib8X+BeoPjuniuz+wY7j5eBFF7myiovdw83MXHEo+S4Hwt9bdOJ/nSQI6tkpT4CeZ0w3o96+ZCn1QGgrht4CT2jpEWaYVJuvJrz5oPpu6kyQf2uSfCgKyNlQGW/XtCSgEug0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005421; c=relaxed/simple;
	bh=N4SIZC8F7dFHyxEfLiZ9FZ3FzUxRm259bUX3B7CHvSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlX/fuIjBWJTVCwcHKUcszGqEu0hXlEvnIxRjBQFZAhjgjPe6EuUa6FjcC7hkBElftlEKwDfAGhUvimO+ZyR9SIySZl54STXdX6ChJcTcz2Gd2gZst4MRuNWc9Jew3RBbjrjWi/LHTKYV03RRaci0A+RSEbtASPef8wIbYoeGHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+kMnVRx; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRgd46ykGL1hyUR7DHpHV0OLlBjeiSHldVYu/lU3mT9vVZQu4TysBQUw5vLTr4fIKwkGaQsxLMyvPzJg/7wVLNL6XIXBDR5XfQpdbshuW4Sserpcb++K1iFco6/7B7W0VO9EQsCD5oFjNZCKO1ozlAMBzehNyBGoMS6sv+iKu/tRkjzLXqhTXYtzo6CMrPdM6E83J3jkDdewG1tOtylsCM+rGnRT9CiIEyz2ywxrAMyEqenzC4O/VFBFcDXq3g7owJ6jW+lywHLJ2JPk1ES+U3lKcdg8MQCOT+NvkEsMt39bkdvUhKy/og/YunXLuJLXLMtHHnnng4oYpKARdq/DtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obj3RMNpbGw+TuSM+Tba8vh34iUoRGo7G9+DFj/uVuo=;
 b=JboOVuzdeBnL5cV6HzUVzEqMUdDQtpf9NEoBJ5Avk9GzYivjZLd+jxBQKamcgixtFeJShlsdiwARu1SMy3aPSiY3+3Z6ZZesLVeuVUdiBVPcr+BM8RVGcy2ZCZc1TTVvNRa9VBcrr5j9ZthfLRHn0uPgf4NYMcCsteXZydLS7kKzHBCfc2nhUu5QpTNAHtNiYbxfa1HZVeyaBzznShfsvjiqUjXgP397cJZykDSxfaVDjGiiQthie1eu6mN/QwbBsoGPSLVyzwtvTTKZ98he33UkhRpwjXK0gp0Kl0bKMoUqI5CAOx5O2Cf1BFHttAsIwgDs+O62BKetWDQrIOb5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obj3RMNpbGw+TuSM+Tba8vh34iUoRGo7G9+DFj/uVuo=;
 b=V+kMnVRx+29+/BQI+UVc/B053RgLpcVg57fVIhWUqP1NLwcVeIU1JNqzYXKITNoRVmmQObPZykJxatHgi9jh8GdQNts0zw7zmr8aWf2vxA7Mg1g2cz5W8+27fsMQL96cysBxUs17IiZVbu+oHFJ+msmuloaFnQ7hoJV3paXiFCXkER9tY09U7pCDY4fIp5BRUG0C9YhWPOB7Qw1TzTUSPbrjSPeOQAMyY4XbMqyubHAJYZeoVF+vGNcsz1u3IL4v/2EW1P/ZgyD2VSh66MwzcvfMJVD/6vLT1p3D3VtcDFFZE/RY95dwICaehdU6t0WlI4cJF/TVP8gFhnM0WRjR/A==
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 09:03:36 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::47) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Sat,
 8 Feb 2025 09:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 11/13] iommufd/selftest: Add MOCK_FLAGS_DEVICE_NO_ATTACH
Date: Sat, 8 Feb 2025 01:02:44 -0800
Message-ID: <22918a1e623840310ec4cc35a198722a41ee13a5.1739005085.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c6acc2fd-79cf-49be-a500-08dd481f784a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GkphxLMRlheG1A58KQGyl2uXae6Eaxp9JV+EwFs0xygAV6xSwnka1Uxax00w?=
 =?us-ascii?Q?bKdeSnM/u9uRsTvdG3fq7AXfyDjR8AVjWyIUmL1Tikdo3PoCsSyex6BBh1Aq?=
 =?us-ascii?Q?GtM7KawxBpDdO4XSruKQPFj4r9S+AqLKneZYbJDvzUs7AgZMRkDRgAEjAmUp?=
 =?us-ascii?Q?8Su3wALRYvbXKIOcRPJXwnCIHENqvCTyPNXifNySNGywveNBOCqPoF7rsWjw?=
 =?us-ascii?Q?QkHl9Ra3leYo2Z1tTKNMKqQhDordWi6XZsgl+tzptlXos3YJRY6LFWFi0AK3?=
 =?us-ascii?Q?wFuvmcojaW3Oii2wM+cxFuCkGnvlMiFLA2s+HnJz6j/Vl+ZkWTuNLD91OyRy?=
 =?us-ascii?Q?w7nIVzdlbD9RZAWlboCGsG9yO1PJuWxc6L8VERAVYpW40PSlU8ZXRVhFqAjL?=
 =?us-ascii?Q?glmf4WTmNTKUCV8o1E5YA+nPZgVmplwSUvSxOWcqhy05sdaXroYBDlTQr8d9?=
 =?us-ascii?Q?lBcRC2smMgj2HtVipQfgEKPA7LebKNMTlWoD1ovsJzxUCsH9YeER1570SYCq?=
 =?us-ascii?Q?95fYQvht2mNVnAUkEw1CNXcJ4vQayLcG1Ii8WgvQ2SflKj0w5iojKCHcTPw2?=
 =?us-ascii?Q?/GWMlYBbrGDyg01CnOjbcJZF8myiAmcmUp8hEE/WXJMj6qSO3uE22HDMsfPS?=
 =?us-ascii?Q?xfva/oi889PVI1B0MTC1jyu/I9Qxqa0RbWGENMWOUcci8c3QUBImaqYr2prm?=
 =?us-ascii?Q?ihDVa9ufWp6+YC3De37mZJqlkHpKJdMG45eTmIJHuB664qrO0d9xOfl7FA1g?=
 =?us-ascii?Q?EiBJdVTbVSl/mfbnPRwlPJFYkOnvazP3+xMl/JAKETjCNFlcxglkMcWfBA1/?=
 =?us-ascii?Q?XWQoiZjdMKDZ6KfjGbLsNKGFqvHcB+mz1nV2fdpxDTadRznXGcNmxOevjhMH?=
 =?us-ascii?Q?iq0W55ATKsMU7GsekwovtT/yw0Bq+ozSJ49o/V85yFI8XUpM8YWHsc9xDIIH?=
 =?us-ascii?Q?5z9cyVY7vjswSVFcZ4lN5fkH3q1WzUFTHPPa58ib+NxArVMhd6YYsLxQyYdA?=
 =?us-ascii?Q?n17WXy9u0mGZaoy4E8zGbvzoreA99sMQkj1TtvsNHInSuuvUidt8EVxqslOf?=
 =?us-ascii?Q?1uAZrD/vILKOnHlUHsvj3tR7OiOj4156xTYSxPuWmOvoruYFnLlL2pMbM6A8?=
 =?us-ascii?Q?ueF8SVcD2uSgF28VhBdnzWB0KdBbrhWOSPYz+fo7NXJYDNATnLEvMkekkSuc?=
 =?us-ascii?Q?vzVNn7j5Sr8TJ2vLPAKGxAiflfJ+z0Y0Od/d3c9PSIZDZWQ2Tk1OlFmEkf2n?=
 =?us-ascii?Q?aPBdigSTzp48Aj3jfUseoPJfDt04+5mQw5nHi7TXkNfiiKqBgSLwdAeqNk9w?=
 =?us-ascii?Q?/6qeNYmaLZfIFNTSuUt7ZRPkzqI2dvxnsUKvqX8fJia2+U7rRWPxeZE4Fpf1?=
 =?us-ascii?Q?leHE02cBTU+2F/gdVatmfBpcYBid0f2mx3B+gPivgRAK7qYTVeCBFf7vGTJK?=
 =?us-ascii?Q?mbyATo6OpYscHE/FLzOMGykWyDyNBjS8v7d86H11WA3rmVqOS+BEsEwOvEDe?=
 =?us-ascii?Q?aRPdshGwH9E+QFw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:35.3634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6acc2fd-79cf-49be-a500-08dd481f784a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122

Add a new MOCK_FLAGS_DEVICE_NO_ATTACH flag to allow the mock_domain cmd to
bypass the attach step, as IOMMU_OPTION_SW_MSI_START/SIZE only allow users
to set prior to an IOAS/HWPT attachment.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  1 +
 drivers/iommu/iommufd/selftest.c     | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index a6b7a163f636..02be242f8f34 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -48,6 +48,7 @@ enum {
 enum {
 	MOCK_FLAGS_DEVICE_NO_DIRTY = 1 << 0,
 	MOCK_FLAGS_DEVICE_HUGE_IOVA = 1 << 1,
+	MOCK_FLAGS_DEVICE_NO_ATTACH = 1 << 2,
 };
 
 enum {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index d40deb0a4f06..37a5cb89e27c 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -839,11 +839,13 @@ static void mock_dev_release(struct device *dev)
 
 static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 {
+	const u32 SUPPORTED_FLAGS = MOCK_FLAGS_DEVICE_NO_DIRTY |
+				    MOCK_FLAGS_DEVICE_HUGE_IOVA |
+				    MOCK_FLAGS_DEVICE_NO_ATTACH;
 	struct mock_dev *mdev;
 	int rc, i;
 
-	if (dev_flags &
-	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
+	if (dev_flags & ~SUPPORTED_FLAGS)
 		return ERR_PTR(-EINVAL);
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
@@ -921,9 +923,13 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	}
 	sobj->idev.idev = idev;
 
-	rc = iommufd_device_attach(idev, &pt_id);
-	if (rc)
-		goto out_unbind;
+	if (dev_flags & MOCK_FLAGS_DEVICE_NO_ATTACH) {
+		pt_id = 0;
+	} else {
+		rc = iommufd_device_attach(idev, &pt_id);
+		if (rc)
+			goto out_unbind;
+	}
 
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
@@ -936,7 +942,8 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return 0;
 
 out_detach:
-	iommufd_device_detach(idev);
+	if (!(dev_flags & MOCK_FLAGS_DEVICE_NO_ATTACH))
+		iommufd_device_detach(idev);
 out_unbind:
 	iommufd_device_unbind(idev);
 out_mdev:
@@ -1603,7 +1610,8 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 
 	switch (sobj->type) {
 	case TYPE_IDEV:
-		iommufd_device_detach(sobj->idev.idev);
+		if (!(sobj->idev.mock_dev->flags & MOCK_FLAGS_DEVICE_NO_ATTACH))
+			iommufd_device_detach(sobj->idev.idev);
 		iommufd_device_unbind(sobj->idev.idev);
 		mock_dev_destroy(sobj->idev.mock_dev);
 		break;
-- 
2.43.0


