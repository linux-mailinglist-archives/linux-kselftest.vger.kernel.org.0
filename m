Return-Path: <linux-kselftest+bounces-14752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281C946679
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11036282FAF
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584E7FF;
	Sat,  3 Aug 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDO3Ut5V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095663AE;
	Sat,  3 Aug 2024 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645149; cv=fail; b=MQY8UH8NMBchPpU8XxYeKNzLuWshAqOX3DTdq4kmxFUOB1YUMU5SRPu/oQX5CMh49O1HueAFnbK3IVNUOGN0I8IhV7YXFGuXvXJplEX0DKmEJMXa7D5+N3PGbj6C7VW/K+ZQVrwZGL73CR5Cqy1ZrNa9/nwb9KvuGxtQekZ6SQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645149; c=relaxed/simple;
	bh=6uA00BK2lf+Z1ga6tKxs2EdKKCLkYre2/i5yDGFhhw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWBAntal8uRcvEEMFhSXcumC5RWlyA89Oy8R5yzUzt+52sp83l57Q06YVm7ogAwYWvbSAXW/Fpi7P9TB2VFCVQU91GWnXOahZS0rl6jio7a2452FaxexRyI1zzb2cD651tz497WJG+ZrsNEOZhR5Fn31OxE2QszFd73cpIgHRWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDO3Ut5V; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSAoeX0rfv9X56kiV84O+3TWKXzS324wnT4siyPs8AEaIN4pSx2csHCjfUqFBXlmN1BOutdD5j2qRESNJEKgFvzQsk+6jNRIE0woAWgb4hZC1BLhsZUfZkCQ1b+orecqWo9QQm+JFYncbUUGzaxQw42GJSIjhSkdgPbW+Zgiq93FvUSOXhZQcubBroCnERQSXygZ+6cQ3nNJo4vgvROFFH2sA+DSwOa/qwko9HbAKoFlHhOOwmkA8YXUETqWR9TsktHdgpBVvNnXpbCn9qV0ikbRzQXRXdi2uBEnTGAOD9E+Dqeeedzx3VvjVYpZp4h9K9+hSMhYDJmUsmKQvSDXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D20G2M+aQVUdKCMe81xyHdP4RUwPObZi/qMHmlpzZLI=;
 b=nX+yV9mLtJSaDUa56pRvq9d4b/1YF0vg1x8lhz9o6IFbvOU0Zfr+1EXcON/i8pL3K9BdzQ9nMVjkT6Ni80O1vHpjYlwJ2VhP5KSfbVznRenopnuYy/iCJgNW5iOpwZsQ03wD1OiKCbKVK14+D4d5Al+fIpYvl8Q3AhA/mAKtkgH0/2g4ObA4LWZ+y+78qFmo+t48Dv/0kf0MrqJQlBHDo7A4BU4bFh0aQqGNALm6fRw9J0+HZ3+/RlEIxgoqUYIzTMZlTInnOxEFBHztEcdKPMGHXamswpGyKj/X7CKdguhUgY+DDtZPR0m5VKs1WdDQSbpctkepMUuyOvrXOcnISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D20G2M+aQVUdKCMe81xyHdP4RUwPObZi/qMHmlpzZLI=;
 b=tDO3Ut5V5saAoHhhFKEWitev97WO6KeG+a/nGphZHeaGA+ao9QCj8F/t5u3XxWKuRGqWISzhR8G5RkjBIoXB0URncQmvb+qpBIUbNEDOoSty2Rfay1ZjFFGOixc/AWloCbllXquCLIa2BuBlxCK0VShTE4xI5lQiwEGW9ge2HPcR1zKgjsvQ2QBoRyuWXp4VusEuAdEEj6gtuOzcrAgbbu4r3jTVwEHkNCvthtw3X4BPDdccd975CB6vGy8eIdZ3KpTIMWXzVhuSFPJ8bmwIAHXtH29d7ppCQ92xbeukQT7EtG4lB4E3SC9nUhwg00oJZ1Ah26nrar3OfuMPTrJIQw==
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 3 Aug
 2024 00:32:24 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d0) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Sat, 3 Aug 2024 00:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Sat, 3 Aug 2024 00:32:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:15 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 Aug 2024
 17:32:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 2 Aug 2024 17:32:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Date: Fri, 2 Aug 2024 17:32:03 -0700
Message-ID: <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722644866.git.nicolinc@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8883c4-825a-4eb3-bc1d-08dcb353bea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrFR9QP10ayRgcnJ5MmjaPGkqw8Z9uVo5xdQzBIhjz8kaLfCua95bBUPijYh?=
 =?us-ascii?Q?OjPUOFWmzixI+X7qh3v7WSDJd9Ae2zPyol3Yit9+K0G5wwiGYqAsPgvtoRwY?=
 =?us-ascii?Q?s8l37hsF25Mxy7nYibRZxm9e9y4G6E8++p7kk0PaJhwPmevaUlOLMkHxvE9X?=
 =?us-ascii?Q?KbFY1z0G/0OKjq8y/Yy4KviZSY/U4nLIzNCOcdgHvz7iEoXiY77sIdCa43PW?=
 =?us-ascii?Q?rkdl88kVudxKCujVONPtSVdDdAYjJ/7NjONjnaS6A90fWNfNuwyUTW8hEGJ+?=
 =?us-ascii?Q?aoLpXOVWy5enLpQnABYLi5yj8sati/dGSIfj08o8InE+NouUmp5mmdsBsRCN?=
 =?us-ascii?Q?kZZB6iamPehsspDRq0+rVt9H53LXRF+j5pEkdTw3g/PKuAkWOIdNBNHG9ECR?=
 =?us-ascii?Q?q3F2sxMOAJhlRVf/iF21lZWbWYPLfy2AUUGiKOmNLtRGiPw0fz2V616mRHxf?=
 =?us-ascii?Q?GRL++yNBGCWhmPZYXF4Wvk81m5LGrjZRYmyl0jLwr9srBgB8AgEm3qZ05E8c?=
 =?us-ascii?Q?7WwS199Ds3JKGheO2+jRBok+hbaSuyiagbs2Ocg3e6II/iP/zZMofu8u62KS?=
 =?us-ascii?Q?4N/l1zWP88Yijrdk8rqTEDQmJQ82Q5IFyQxlu+PbqLDbydCrXJ3Dkf413P4A?=
 =?us-ascii?Q?q3npdsE+zTxLT4oMCpYyTAJKubLEFl0e6j3rZ83SG0UHWEvCZJMFqStLx9i2?=
 =?us-ascii?Q?a8Rc47ie9UvVyEOlfzXlmD7M1mpXtcFBmNRy00p/zGC0uVoc3HaH48v8nD7T?=
 =?us-ascii?Q?JYkXB82xyWpspIMMGh8a0srFnGmunKiuFKtcnOcRy7AKq4QeMZGfNze+/P43?=
 =?us-ascii?Q?dWN8zgW3wqV0cw7VY3Zdlp3V7TNyec39b5l8mnNUDhE6CxqbAzeAhXxgOGJc?=
 =?us-ascii?Q?FOj0RmIBsjmhWBV4V4M94nrpQg24ugDkvaob11JtD6ZyK6FPNaMe03+rpgt5?=
 =?us-ascii?Q?6O82aEAlRXybVJxQ/BkW0ICvGlmmLlNNKkpBMZsIyX4vzG6uE7Kn4BSfvOq/?=
 =?us-ascii?Q?MFgvbUaAyke3bVixxYHg04EQ/8D2HPxgpSjdRAb4/3FJR/IghIi4Jg0dF70H?=
 =?us-ascii?Q?g8tS3fujusrtNnWkUNcC9Kn4QCq+C2Zoz6N9CeAGeAX7dis8DbAFLGijz9NN?=
 =?us-ascii?Q?EgNgMn7ZHFILVcpX6738xyikP0TQoeVZoA6K7Jgl041tUjP4tmYVA5aUvleL?=
 =?us-ascii?Q?LEns/eUPfhZdzFwr9LW43P/ji+61F7M+R9wk4yXvULUUr/kA+Jc6Nb0aqSzE?=
 =?us-ascii?Q?90QhOimowGjF7BF7N3DNC8u4u6Zy+n7gwMG2q6HVDY07WzEmRVSsWEa/RWvx?=
 =?us-ascii?Q?Cy0SQb7z9qQ/VNBOnYDh8e7eAD3zoJY+ouLmY/m0fZa+55KuxNYSXq5N3Y9l?=
 =?us-ascii?Q?8XoNcQOTY1dYFDxqeq/lhz1C/Z+U1QEUDWX+NM+0EXR+tJFfflipr5Ps+eug?=
 =?us-ascii?Q?zTnZQ5SYIGUg2FGuVAUXYoW22f8vsoWh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:32:24.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8883c4-825a-4eb3-bc1d-08dcb353bea2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

From: Robin Murphy <robin.murphy@arm.com>

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be in the legacy-VFIO-style case where we're
using host-managed MSIs with an identity mapping at stage 1, where it is
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
index 7b1dfa0665df6..05e04934a5f81 100644
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
+	    domain->ops->get_msi_mapping_domain)
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
index 4d47f2c333118..69ed76f9c3ec4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -638,6 +638,8 @@ struct iommu_ops {
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @get_msi_mapping_domain: Return the related iommu_domain that should hold the
+ *                          MSI cookie and accept mapping(s).
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -668,6 +670,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	struct iommu_domain *
+		(*get_msi_mapping_domain)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.43.0


