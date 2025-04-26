Return-Path: <linux-kselftest+bounces-31693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF7A9D807
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CB4A1B44
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183C1E9B06;
	Sat, 26 Apr 2025 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHsn5Ghe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590911A83E5;
	Sat, 26 Apr 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647200; cv=fail; b=Dd6I+DCZhWAYbo+AvH+ONlhET3pGYpmwXoXUmxbn0IG9pQ9hpxDh4eGn7j00y74NoUc8sWmyJeU8Fzdwttik1yP+ne/crcM31s6TXDDAOzaawbFByV7Hjm9WCumklaGmCy3sRlZ86GBOKAPaso/hyuy+f68errMttt9h1Y7gMq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647200; c=relaxed/simple;
	bh=MXcQM3o2VvHas4QtJUqARZk/+bHK+ibaH3TMZKpzSao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTYOo7zhIdfwmRrUIHJ91r/G+ajKlXo2/Q9UEZQtWQyXvsP4YVkPGHTDX7xreLwfkAq6e9J6ii21BKNijr27tfKm4Q6LOHAk742JpdbJ4Z7934sMvTVg+dp3l6W3NkxN8xfYVeT0dW1HEWGd+FygJs7CO49yCrgvSB+YchTbVL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHsn5Ghe; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiEuDCdk4n68nnhVv1Z9u3+Rx7R80csAptIL8WQ85fwwOouWxXWYMuwEpdkaOyHnsmJ1x9D0+/JqoPPGykquaGgn6/4joHm1vkKo46L50jUJWaD8lG1pD68GrNDphjXZzqDn1JW0nVJVKoe5yyx23so0DwVbvTNazmSEs3FBTLiuzWZkHosimxjk1z8mmrQvm+NPVjuo6CIhrHXfN/0VrN6kd+otsY2R4UPOt1+Bi4YYwxm5CJET/In2v1XZYGC+lslXKvjyA60pZvtOv5Bz//m++bvf5pq3GaIIppsy6tbWnI+wrLRg6rneRM9CZtYiSgeZmN+axQtu3h3XOzxJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+lzI30fgqXRnfgOxGQdhtg1x09TCS12trGMedv7YOs=;
 b=pIHYCGrF8K0QmLZNW+bUaUqvjOyp6mHfTxOLeiD6fXCAQQasHJe/QmsnIkx/2BjyNY26l+ZDQX1C9P38tdY0Gj+pPo+QctgUUyKTa9XP/wYwtOsjtN8+SV6kkXP6RG7qzeJgkyO8cUDsdXc2bkXSdll+Q68RMe8hsM9lWZ377fUZFcigGSczQxUx3VO21wy3CKfkNpOcvsuEaeSgCamuHClyp+k6SYlmY+++wc1NSyRxfp3NS07DCIsY+vZIZQpb0Ndu+AGf9lxa82YxS+exhzjtEKpHbHZs0cZH649Wv1xfJnfqCpqr8v5TTJaatejYDu9Z0YUgrOx8ZrfAnJXmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+lzI30fgqXRnfgOxGQdhtg1x09TCS12trGMedv7YOs=;
 b=tHsn5Ghe3uymwd09R22pnNgEyJQ/3MAGO+hmXVy5/PhsXPNvJjrp4HGrMEZrnc5anNaicFEdmcefHsta9oBEMcs6N7umZbRWWFWxmVH4juHQxvKea+2iNx8B7BszNz7k34xGn6EdHq+uYCTi9s6lZ7nZWI93SSyY14ZdKvH8csd4ht/GxiR2ZQ53pYImeZdvLh1mUaCsN3B/kBAoYL+XU5fSXK6exyuNzVCcFutXfgkY/S+o73rYjMuzuxb+8qevFNZFIlnPMZuKvcC+kRyRKcpxQggIkG43XCzVvItZG1rszxb0S1fSe1AAvV01HRJkslPe90zXQ4MdpTINh4BTsg==
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.48; Sat, 26 Apr
 2025 05:59:54 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::f5) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Sat,
 26 Apr 2025 05:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v2 22/22] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Fri, 25 Apr 2025 22:58:17 -0700
Message-ID: <a7db1d2fe5dd43ac7ac075df662f3ab743ac6aa2.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e173b3d-b6a0-4717-554c-08dd848790cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iwjwrvfNHInnhQkW/Rd/Ag2MN0MhyMPJaNkRnoWCZTL4QY08oDBYpABgwR58?=
 =?us-ascii?Q?GPM6yxpIRTCYKJU8rFYM6JFN8vCkas4lnOgGiliaCtC6R2pLMc+WmUd3cO6h?=
 =?us-ascii?Q?xefZETqzYyKqwY34PQybRgn8aMCI1lU/nsPf87zXpR69aK7HaEGOWAe+dUsh?=
 =?us-ascii?Q?ALr5ZGxhB8ZHSx4ltoNQPPrAscrII7dYcaJd+HofndUn7v+tdOgeIOoaBRhA?=
 =?us-ascii?Q?+x20YhG00cWyJf3Vy8xcMMFV7XMLq0ujAysSrlzhC6+1c3/mezXnLN4wCiEl?=
 =?us-ascii?Q?0MiQZLQDNGwFZXzrwumelsd70Zi6546FHblkmq3IjflraE4bWT1V2w4Ux2Zz?=
 =?us-ascii?Q?aW+ksaktDdgnqfBtNDOzHO960deflAidqWUs9Za/nJe3lOSkPX6LxH6dg2jw?=
 =?us-ascii?Q?n+ZvSpnEPpmAWWaqUxvZdIZ8ZWDax5mQdgqRnyRAVVmhMthKxKb7NLFs7T/1?=
 =?us-ascii?Q?e/tnbVnJpN62e7V3R5kCWHY9oyyajmQUUNVAE8JgTzrlwtt5c4Dvgynotuyx?=
 =?us-ascii?Q?+HI/bNSpsEw7beNLF3fcd4KJCLZ49HPB0E/WEnPZwJKFn86GYiq2udKODOZ0?=
 =?us-ascii?Q?9xhOy7hlrmOq7CqxAVD8vFCRwOsvhyohat6NtmNSsliNJio5OEpBprm1+yVv?=
 =?us-ascii?Q?XUH2LcMigyRTT1y31s+4bV1+zIPMl/NtYaX7pLFH+rPr530TJ0WdecLetImy?=
 =?us-ascii?Q?+0tLJewW7ow4LEvXrezsGl7urd0xRLobvIwkNAoDNqLt7vEJ4sdOpDuqm7XD?=
 =?us-ascii?Q?7PHu3zwC/iEu8PnyFk43Twq8TID8TYh2i0C/QOUh/KuYjnlGLIVIVbQnYbP3?=
 =?us-ascii?Q?Z8tYgV9eAjvEWZ/un6kxERAC9YrZP6kSU8M0wdbkun2tQ4ty8VvNMYp4qnYx?=
 =?us-ascii?Q?2RhDMaCUzdFT86x/wwFas9aPVDJ/847gatc+Wot294VcvCZr72mkuDPF2fIJ?=
 =?us-ascii?Q?g38n+jJYh0hXmb0Rok9mB8u4eh3eN3v8BABYOkLjUQVac5OgpSwBpG9XCE+4?=
 =?us-ascii?Q?NslAjMWKBSqi1DLNRbeNLZfrtwe1b7AnCEN6JKP6X6wMG0ihMrt7PZFF8U9H?=
 =?us-ascii?Q?Je5zcoHI817I6JYG3ZzR0OIDGvqpCDFUWOwT6E/HuCw+2b8H3ev20ijVV0zC?=
 =?us-ascii?Q?hQQF/FpazyQhzpPuFGAhhAB3iITdFb5BG+kFLY5RWZ4uogToZHIcwLdg9V0H?=
 =?us-ascii?Q?DP9Vt/PIE7A3bgOIPYHOvDIEPl0V4pbbjXSH0ULE7Cc901AS/h6cGnoaaBHo?=
 =?us-ascii?Q?WeW4CqPfEsCDDPIbLYkDLsZsxHKaBOTaS6V5N+xx7QWFtz9cisCpU5/JWZQx?=
 =?us-ascii?Q?jutmXZYxCfy+vfe9Uc+YfMeT0BAZNqnPd0Yuc27wY2wgE2dtjADEuuJ4yWJr?=
 =?us-ascii?Q?m9QWz9LvlFjKI7MRu0N9E4XdlMGIRdB2wpQfKOYvdBEbqqivi4SFVaBAFf64?=
 =?us-ascii?Q?OOMvuu5w2LBJ+BQHuhFsimAELjshDGnNvJD7y7L1ztlYA8LchWYq2r4g1ucd?=
 =?us-ascii?Q?4wKSa7o8fKpc0C2zUL0ZiloeJ5/MvcmTr3ON?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:53.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e173b3d-b6a0-4717-554c-08dd848790cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d69e7c1d39ea..d814b0f61fad 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1113,10 +1113,12 @@ struct iommufd_vevent_header {
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
  * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
+ * @IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension IRQ
  */
 enum iommu_veventq_type {
 	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
 	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
+	IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV = 2,
 };
 
 /**
@@ -1140,6 +1142,19 @@ struct iommu_vevent_arm_smmuv3 {
 	__aligned_le64 evt[4];
 };
 
+/**
+ * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV IRQ
+ *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
+ * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
+ *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
+ *
+ * The 128-bit register value from HW exclusively reflect the error bits for a
+ * Virtual Interface represented by a vIOMMU object. Read and report directly.
+ */
+struct iommu_vevent_tegra241_cmdqv {
+	__aligned_le64 lvcmdq_err_map[2];
+};
+
 /**
  * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
  * @size: sizeof(struct iommu_veventq_alloc)
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 88e2b6506b3a..d8830b526601 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -292,6 +292,20 @@ static inline int vcmdq_write_config(struct tegra241_vcmdq *vcmdq, u32 regval)
 
 /* ISR Functions */
 
+static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
+{
+	struct iommufd_viommu *viommu = &vintf->vsmmu.core;
+	struct iommu_vevent_tegra241_cmdqv vevent_data;
+	int i;
+
+	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
+		vevent_data.lvcmdq_err_map[i] =
+			readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
+
+	iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+				    &vevent_data, sizeof(vevent_data));
+}
+
 static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 {
 	int i;
@@ -337,6 +351,14 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 		vintf_map &= ~BIT_ULL(0);
 	}
 
+	/* Handle other user VINTFs and their LVCMDQs */
+	while (vintf_map) {
+		unsigned long idx = __ffs64(vintf_map);
+
+		tegra241_vintf_user_handle_error(cmdqv->vintfs[idx]);
+		vintf_map &= ~BIT_ULL(idx);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


