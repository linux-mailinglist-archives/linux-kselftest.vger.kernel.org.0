Return-Path: <linux-kselftest+bounces-24284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E5A0A07F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AA1699BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2616F851;
	Sat, 11 Jan 2025 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtOL8hwm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB2156236;
	Sat, 11 Jan 2025 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566382; cv=fail; b=PDeqlU1+gA17M1BiWdjkf4Mz25sZ0uBn1ohMpBRPyaPCZt/ETywd7lvxZZ4yJDKdOTp0fjTYLxq06hEkU543OWTcl+I8tFnBOYMVyal4imOCUhm04Q/CpVAEOxDoODo4oGEJUlJ4HaosLzTz5XXyLBJDnmdOJAJvLR2f6T8Kl7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566382; c=relaxed/simple;
	bh=iikYLJliYIAABCL9X2XFcZstqe7ljDe6qHIFlnBzqUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8Xnhay6uJWYMUkwPhZQkProswuvbm544QMT7CBnXIp7Nvtx21f11f5Am1UoTaNZL8IqdCUVdNEwEJkH8f6YaW9oXx+aVVxvFsCmQsnpZWhjF7oKlzgVyW7dPYIAQawrCzzlxxOfCN6DqLEbxZbAm5ASJmzYbfSsXYrFtttwMr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtOL8hwm; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM3Qh8P7QnzAgwRt4XpKajNd0khv7gthGx25oIVJuU3XBU86SfXW8CpeTTQyQpdjMmpYw5RC74aWbHGnJ1RONdLATzlUrNNFDHj7atZ6y5thXIWw+hDtFuNx0mL511Kl7EMChZeeBHIOVmuE5PtQO5jaYTpbcQZRDSj2SBF8zPjbFP+UAS7Hv2oxp2ZxJ0yS4oK5j4Hmwyjdc+YbSUqLC/r4B/RRsWRdt8v9Jrb9L9BhTO7v2AOpP8EM9hNgYNXJS+Hbwh4ggjlwWJAvbteptFs5P6qSZSAeqX2ONZJ7WM/c0xQrxlsioMYYcdNpTbzeaLdBD69PYQiKwhNz7yAV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1A+MI6IaEX1dvZ/uh7SdQwdwc+hRK4IZD+3tISW0xk=;
 b=n1eNt+qM3VeQusknxLZRHDPyanRWbCuR1qkuzDkqyeYr8PJDCb5q7cCT8QgLQhHwH1oLRo1Jnci3zsQkjeIkfvfZXBmctcaTq9GyHwWT5VH59KoQuNGmHgvi1RhSfe8pJ0PUpv9VFa8IinFZtGifeEOMpgvUlXJXenun2usf8nO6rInlz4Yf0hRJVaZiXyK30JpUjoDpMzHpvm/NasHWFdjrPfwrkNrwssk308BIlc1UGquhL7f5P7uou3/UvQZs81Ogr0Zvl5TlTMTff9R//iDoZT0ULhXKBAAlFw/8vltZY5IansaGn/j3WWJsHU0dFM+u5P9nKwKgBRyy4XqQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1A+MI6IaEX1dvZ/uh7SdQwdwc+hRK4IZD+3tISW0xk=;
 b=qtOL8hwm404lJBLikKiH+CQxCnzSuDJZi3RmH2oS0EIzfHhM8igUIOGAp3ZR8TQkJGTjrsU9O3JM4NUte/8LYotmkhLyIQZtYf880rNBT6hnsvYmH/w9a1sqXn0yZUv4zmAtvHyQid36eQvyTNlx2FIsxY6zZYxMqoBwRS5xGTuzLCjMO7DzkuyDKUWxgKxg6lhpl33Fix3KoM/vhZG1Y4e8+CmPtsOjeFcorOGFCeFSmUY2GQRVjmrfD3jydJfl2Y3Yk9qL/UJxQ4/gjetAZ5i8d/OA8+mQtdSfcj0mLlZQB6KXVsY0S9M+hXZIv+AgUdVJQWxU7e6aw+U/Kb3pzA==
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:32:55 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::d6) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Sat,
 11 Jan 2025 03:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:32:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:32:54 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:32:54 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:32:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 03/13] iommu: Make iommu_dma_prepare_msi() into a generic operation
Date: Fri, 10 Jan 2025 19:32:19 -0800
Message-ID: <9914f9e6b32d49f74ace2200fd50583def9f15f6.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 39be379c-9fb1-4ee2-7c06-08dd31f0a2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukipX/1Z0r15lLxLQCIobe635wmeWhYlgUrLOeIjxB7U6WCYxlC3Vg9cjgd6?=
 =?us-ascii?Q?eYZJd8gY3ZOnDKUfu+TWFA3+T8Kgax20VVoJ0GLngNkc9HXnTkf2d7/2Ce5y?=
 =?us-ascii?Q?bM1Xg7f3sL3/UWXBN2+A1lCV2VZzvxTafpNpinbWFMWX2NJ4N9uD8kVY5ABe?=
 =?us-ascii?Q?EnY9BLZlTxFQvOyYdxzs4hKSS8XZBCQXoO1d6soENOQFBG4AJCk4rdrRWBOA?=
 =?us-ascii?Q?2ifeZxVfsfZ+OMmhpIO/TTDTmnzadA9MLmoBQixeUkwhqlL7kP4B4FiHD8V1?=
 =?us-ascii?Q?WwUqWFZx9pOIL1t8NmhOFV8CbLgwyPEbtVn1EMzE/vd5bGWqMZi5hSQEsEZP?=
 =?us-ascii?Q?7FibL9Gbx+59yebAkSN2dsUQcxNwy7b1YQKD0Fwji8Ufg7+5uX0EytexQYn3?=
 =?us-ascii?Q?xSje4gSCWsNX8Xqdn/jilMaV6Et6oC8aV0Y0OCqVXSKikBYAR+CSWCW6Sok1?=
 =?us-ascii?Q?jWSbEYbefqgGC8CWjkH8A5PuV+/afuxLKnIAPZX+/D5MVV9qJimTirdD3jKd?=
 =?us-ascii?Q?4uq6X68lePLhN/wzZuKuLf7bnfRSzeSgSvF26H8XlMcY9Lm7qS9Uc1Y42EzW?=
 =?us-ascii?Q?xqf4so4q5DVfQtJj+FETmEYIo6iGFJjHvgdW5I6PJMi3Leokz2P3OfAfp0zB?=
 =?us-ascii?Q?WXzPttfHW9UuVuGodXB3AsFU/NDwTY3oBv4LGiHMj+N3nj7h7iAA9eY4sf+U?=
 =?us-ascii?Q?7qIbFEoRLGG7U2gByViUWaBZnSDduroBCqwq7eJCLyi0vWtxyTt3H0al/hTD?=
 =?us-ascii?Q?7wF0cWWOe6ejFHcch1+nDgMJi7JGbmccYHvB2kuBgX5ngPiVXaShx8a0mAY8?=
 =?us-ascii?Q?AvQnAEQF0x9hXxMbhfpJYeXE3Id4SzRmkK/uAPcMPKDAZY4HddFZfi5KP7o8?=
 =?us-ascii?Q?C9BeCz7kTr0PPVhvXJqhdE0q2GnXYsT5y0jK4Ywv5OFPuoBibZcUfgQlQO2w?=
 =?us-ascii?Q?Z0P4duOr+VNzkWRoeJTUQ9lbdC+vHxrDBBUeRReE4ilHz92ILNImycSGK2Km?=
 =?us-ascii?Q?a8gQ+Z+y1ugGO2+tuE3YwYwNFUGhDPcJPzYTqtXWf4/cJJyxWLaMGnVxVhMq?=
 =?us-ascii?Q?8p2s4DkPBOKeYpzCiPi0bRwM1PSKmf4UYoYIKOjB+4N8g1X+QGCKiQE5zrAG?=
 =?us-ascii?Q?iO7ubqYO5VSRCdXx2ZR86G31Da2TRGU+rjrY/9EYbc9sP9DCZUdEQVskusgM?=
 =?us-ascii?Q?PmynnDmacl7GvUHjJSbWhluo5J6vcYD+oInF+ihsc7pSBsPBB951pvQOYcSf?=
 =?us-ascii?Q?DWschDGBVT71P8hYyRKfejblneDRMjN/pQg3idnhIZTJlVcXF/hk06PLOPob?=
 =?us-ascii?Q?u54hsXeVAXt15tvpk1z8nSeRNFoSy5EqixD+B9yfhXBe2lLpIvCaTByWzhbn?=
 =?us-ascii?Q?CDFfKYcvApSpXByTS7IF5yak902jQLFaknhuR8UQI1MFHlI3d8/D9N5E4rA4?=
 =?us-ascii?Q?Ngz6m3ZMdLHPWCBYM8qCtVknHCJT2OzQYXAcIG8y73bWRn9XMRuOe34cnL+j?=
 =?us-ascii?Q?AAZExXvZhdhSqbw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:32:55.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39be379c-9fb1-4ee2-7c06-08dd31f0a2ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035

From: Jason Gunthorpe <jgg@nvidia.com>

SW_MSI supports IOMMU to translate an MSI message before the MSI message
is delivered to the interrupt controller. On such systems the iommu_domain
must have a translation for the MSI message for interrupts to work.

The IRQ subsystem will call into IOMMU to request that a physical page be
setup to receive MSI message, and the IOMMU then sets an IOVA that maps to
that physical page. Ultimately the IOVA is programmed into the device via
the msi_msg.

Generalize this to allow the iommu_domain owner to provide its own
implementation of this mapping. Add a function pointer to struct
iommu_domain to allow the domain owner to provide an implementation.

Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
the iommu_get_msi_cookie() path.

Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
doesn't change or become freed while running. Races with IRQ operations
from VFIO and domain changes from iommufd are possible here.

Rreplace the msi_prepare_lock with a lockdep assertion for the group mutex
as documentation. For the dma_iommu.c each iommu_domain unique to a
group.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[nicolinc: move iommu_domain_set_sw_msi() from iommu_dma_init_domain() to
 iommu_dma_init_domain(); add in iommu_put_dma_cookie() an sw_msi test]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h     | 44 ++++++++++++++++++++++++++-------------
 drivers/iommu/dma-iommu.c | 33 +++++++++++++----------------
 drivers/iommu/iommu.c     | 29 ++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3a4215966c1b..423fdfa6b3bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -44,6 +44,8 @@ struct iommu_dma_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
+struct msi_desc;
+struct msi_msg;
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
@@ -216,6 +218,12 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
+
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
+		      phys_addr_t msi_addr);
+#endif
+
 	void *fault_data;
 	union {
 		struct {
@@ -234,6 +242,16 @@ struct iommu_domain {
 	};
 };
 
+static inline void iommu_domain_set_sw_msi(
+	struct iommu_domain *domain,
+	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
+		      phys_addr_t msi_addr))
+{
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+	domain->sw_msi = sw_msi;
+#endif
+}
+
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 {
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
@@ -1475,6 +1493,18 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+#ifdef CONFIG_IOMMU_API
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+#else
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+#endif /* CONFIG_IOMMU_API */
+#endif /* CONFIG_IRQ_MSI_IOMMU */
+
 #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
 void iommu_group_mutex_assert(struct device *dev);
 #else
@@ -1508,26 +1538,12 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
-#include <linux/msi.h>
-
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
-
-int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
-
 #else /* CONFIG_IOMMU_DMA */
-
-struct msi_desc;
-struct msi_msg;
-
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
 }
-
-static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
-{
-	return 0;
-}
 #endif	/* CONFIG_IOMMU_DMA */
 
 /*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index bf91e014d179..3b58244e6344 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -24,6 +24,7 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/msi.h>
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
@@ -102,6 +103,9 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
+static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+			    phys_addr_t msi_addr);
+
 /* Number of entries per flush queue */
 #define IOVA_DEFAULT_FQ_SIZE	256
 #define IOVA_SINGLE_FQ_SIZE	32768
@@ -398,6 +402,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	mutex_init(&domain->iova_cookie->mutex);
+	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	return 0;
 }
 
@@ -429,6 +434,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
+	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
@@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
+	if (domain->sw_msi != iommu_dma_sw_msi)
+		return;
+
 	if (!cookie)
 		return;
 
@@ -1800,33 +1809,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-/**
- * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
- * @desc: MSI descriptor, will store the MSI page
- * @msi_addr: MSI target address to be mapped
- *
- * Return: 0 on success or negative error code if the mapping failed.
- */
-int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+			    phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_dma_msi_page *msi_page;
-	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
+	const struct iommu_dma_msi_page *msi_page;
 
-	if (!domain || !domain->iova_cookie) {
+	if (!domain->iova_cookie) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
-	/*
-	 * In fact the whole prepare operation should already be serialised by
-	 * irq_domain_mutex further up the callchain, but that's pretty subtle
-	 * on its own, so consider this locking as failsafe documentation...
-	 */
-	mutex_lock(&msi_prepare_lock);
+	iommu_group_mutex_assert(dev);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
-	mutex_unlock(&msi_prepare_lock);
 	if (!msi_page)
 		return -ENOMEM;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 599030e1e890..fbbbcdba8a4f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3587,3 +3587,32 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
+
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
+/**
+ * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
+ * @desc: MSI descriptor, will store the MSI page
+ * @msi_addr: MSI target address to be mapped
+ *
+ * The implementation of sw_msi() should take msi_addr and map it to
+ * an IOVA in the domain and call msi_desc_set_iommu_msi_iova() with the
+ * mapping information.
+ *
+ * Return: 0 on success or negative error code if the mapping failed.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_group *group = dev->iommu_group;
+	int ret = 0;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+	if (group->domain && group->domain->sw_msi)
+		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+#endif /* CONFIG_IRQ_MSI_IOMMU */
-- 
2.43.0


