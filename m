Return-Path: <linux-kselftest+bounces-14945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AD94B02E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F0F1C22560
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB692143734;
	Wed,  7 Aug 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dLzXK+3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFF13FD69;
	Wed,  7 Aug 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057245; cv=fail; b=FPTSCEToLnqRIHtS9NisOvsdFQ3IizaCoR1lLOVC/nHc6fRh+ifVnyNzRC1bob6qBPmEqYTMAPjj074cguH+Ra38XpfKSv0AxZ8TxryDSwB3FXVWphW+vNsllRdnl+aH0sFEdrU2zpJlqxdXhhuFuaZT3kATkjkyhq8ZzEUoGH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057245; c=relaxed/simple;
	bh=1sW2DrqZEyek8n7fqPqwOatGzWYXGELID7WbIQYjARQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB7XtBK8NlCZAe9dAES7VbcZ9/R9WIEWf6KEVATeXxbwz6M43rhWOQJh1qcBja5qIeN00HTih6NGbMtlq5mKvF7nqVzDxR2jyjdBWLNfevpiLyP5VnUYAvCP5FilU0urgfb5nQkfQX1JUPemxreIRTDnbTMnqR5gb5g+0DVJnv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dLzXK+3O; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs736gIAS3i6p0VGUWbst6X4UmXyUAjbHoMBgcgC32bcuOqsABRYq9w1rfMiqKBk4FMsBA3sg+ji6V1xFNw6QKYFdwyFWIOWH4hj54SUJUPMpOM3/PCPO0NSZh/vapIgOmWZ/rY4m8lYB9nNieraNNE+VMW9u+yUxaNPSaJhULaWUwfK9fJVns4NW5t2Jlf1iHtDxaKbMsWMkIwVupVNajON0YGTYKnUzOKQegas2QU2k6p32NJq9l0TT3dP1/6+3IbA4LE6QVfXQ9ypLeM5IPeTd5CcKVGYTBAqYipqlBx9yKfd+ChRcrkx6Aa3AsO6TE5YqeU76neBCEfaFO7jDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj4m0tX1xLyV1bTSGYsOSOIOM0VT2LUs7Ewe7ekAIj0=;
 b=HDdlMBer67Uhkael0rpF1luUVMKgXNMDmvBtwKIFeo22wwBkih3ohcSDseP3feyFfSbYIZkolaozimCZwFCW+Ttu6NPgJr0sIdsBnsqRKP/WCJ2daGiHmsVFkRHxZ6j6BiLl6N8IoFd/7Kt6SeJqewcfwbh8QAc1S+XI4gFqB42iJXBoSH0Q/84iXA/CjXyDlM4TZ1vPTw9+0fBZHZB+ISz8gr3YYsGG/0O/k13gjLQ7DVVx5OipdVf7jZon/A4sqWAJQgxm4z1A0PGJux2tYFmlOg4VfyyIWm5I5Wc86kLz3qHTa1ypGqWt7rtOcocslumpLaXEAIbO6Ml5c9idUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj4m0tX1xLyV1bTSGYsOSOIOM0VT2LUs7Ewe7ekAIj0=;
 b=dLzXK+3OjxqsJ1G+3yyk6FxCEgwc7NMyN7H8jZMqvkgD0268Z/IfU8wOUoR7d09Ux8rgy9EM6F/uKyJMpOMykzsQAfI31WvOMsr0aRqqx8ziSLoyqmC8z3QYJatUzHzKBU85pzPzX1lTLa28A0PV2Kcr9C1lZTsTdd8fwaZfJV3+DxzHGGgVc+qVoFeQsAjyZ9RDOy3trGxaRTIEuCIVYJOe8J1fs5sJqIwPKhDVItUaBrLbu5t9DH4qrFhiHHehieyXMW3hSvhuMt43qdXZyEw6RDCzULECi1HYzF79OoFokxSzsYap6wrKa/xox9Bd23YeEmv8W0YEDPdRSpHG4A==
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 19:00:39 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::aa) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 19:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:00:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 12:00:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 2/4] iommu/dma: Support MSIs through nested domains
Date: Wed, 7 Aug 2024 12:00:05 -0700
Message-ID: <a837a532e5fb150165e2afd0e1ee334b82c5e686.1723056910.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723056910.git.nicolinc@nvidia.com>
References: <cover.1723056910.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: e9349ec6-1396-48ea-69dc-08dcb7133a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWivJcjjzqjmdN2BhNKT7xdKOKrZcLS8UDM3dduUOU2gc4PBheNWSAJUavuF?=
 =?us-ascii?Q?Adz/l/JTVtg8vehbJfooawNMKXkVynwWnd1zkuqdt5OYiaghKZifopmAPBp0?=
 =?us-ascii?Q?mpEavj8xlklHV6wIOJ9AkEF/ccgO0F4Qt8zFYKb6juQp6lA7kxABwyKXaKrl?=
 =?us-ascii?Q?YTecb8pP2ULJwygdZs752DQRiUgjofhHXdUZjPBMmzrxJR/SX84XM+ip8KPO?=
 =?us-ascii?Q?b7etUeWm0AiYq27lMlbhJf1MylpMUfInLTvKe90rGTwm/bPmGtY9QGqPHOcR?=
 =?us-ascii?Q?mjRVnQWNHG6tcMcUskYW0wyIZBXwgVC7D12hWDTsmq/MrKdL5zkK7PIIUOrP?=
 =?us-ascii?Q?diIe1lgcUXHz/555ElzbLirS1qyYTDoy4aJsYDOJ0cQ97HriV4MtMerCuprL?=
 =?us-ascii?Q?LVAZw9SlVndGTxjRkrc4OsstDghoaNefb8icJMWbeai73jWTK6hqdNm5N1/3?=
 =?us-ascii?Q?vF66fNvh1fj2Ng8m+OkKr13HF7xP1xH5VO5qvFc6SjEtvcdDs9yJVu9JdKD5?=
 =?us-ascii?Q?iILLRjErWG1wCkggqacYUixtIhxmDRIvyJlBVF0B3f2K2kl1xPIpdWiY+kj/?=
 =?us-ascii?Q?O8rNvC+hl1LWrj7KMrw0HJujjdTWYRPCZLPFE4uD8iIDaToxvMJzB/NMLprP?=
 =?us-ascii?Q?ez1U322RaJFlZt3TzPbFMJlJDITgrXzGpnX+kNSuknU9K2Hh37C/g5/YzeXT?=
 =?us-ascii?Q?cTowGf5RV0Uffx8V09dC6+h/PJQzbbEctHfkRZFF28zgWKwMzPovjhv/b1VO?=
 =?us-ascii?Q?ju4OHffMSK+17HWujO8n4IGJd1piXE7A/lDRgH/bugGNCRwlxIqcYUhV/92B?=
 =?us-ascii?Q?wC6OwuH8wl7wAEI8kSuOvwJNIZi9tYDKV+XwToGhMRZwkYzYN4OqgNQ/yBgZ?=
 =?us-ascii?Q?MGfsygBH1X9svcgdFclp+tGyyc3U1aS5wDyZrCTEX96m4ubgp3ukFP/MwfIe?=
 =?us-ascii?Q?x9HhfIPi9lZzpqxwY2+9EWd4f9m5Zj0x7s2/iXN0dG4zJmFHKeSbpUmKvJMU?=
 =?us-ascii?Q?t8fvUrygYNGKreRt0JHCOZ6sIyGZcdHOI7T1TaDSYS0QompC0UKWUrAQBS+I?=
 =?us-ascii?Q?OKXViR9SbxrJnshK0tKB7fnTMXVMLBMvlxMqZ+Mnsq3XFHyz3EL1GxxMJdYe?=
 =?us-ascii?Q?5A6Jk+U2ex1vtoilDtpC9QtvdmfGQHN8KgFjHwYuxB8uGlOYfhcVLWLzGvUV?=
 =?us-ascii?Q?RNIY6M9UKtMGblX0mdnkFamPIhod8d+OMbJCFoH+YKj7OztnVX7S6eDLU70m?=
 =?us-ascii?Q?fsVh9hs/1l8nRZ+sdKecJu1wydVebzpLT1ob3GrTbucB15Cc4VB18YgKiFBN?=
 =?us-ascii?Q?Lacxr9qT5KULe6qi3jG35tciG2Ki1IzU6uYq5923De9HDXrZGgNi/RanXrS2?=
 =?us-ascii?Q?Y+nS01Ae2RsPX+VGvu/INfv6E8dMXkFvp9m6LqQcRTf+v/ZopNxE9AyHEwTY?=
 =?us-ascii?Q?wdFpoq82WuYGL7+xcbNpWEXBakCDf3q+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:00:39.1482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9349ec6-1396-48ea-69dc-08dcb7133a68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

From: Robin Murphy <robin.murphy@arm.com>

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be still the RMR solution where we're using
host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
 include/linux/iommu.h     |  4 ++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7b1dfa0665df..5b21be04e04a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1799,6 +1799,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
+/*
+ * Nested domains may not have an MSI cookie or accept mappings, but they may
+ * be related to a domain which does, so we let them tell us what they need.
+ */
+static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
+	    domain->ops && domain->ops->get_msi_mapping_domain)
+		domain = domain->ops->get_msi_mapping_domain(domain);
+	return domain;
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
@@ -1809,7 +1823,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1842,7 +1856,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	const struct iommu_dma_msi_page *msi_page;
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b0323290cb6c..20a40fd6c4ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -684,6 +684,8 @@ struct iommu_ops {
  *                           specific mechanisms.
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @get_msi_mapping_domain: Return the related iommu_domain that should hold the
+ *                          MSI cookie and accept mapping(s).
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -713,6 +715,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	struct iommu_domain *
+		(*get_msi_mapping_domain)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.43.0


