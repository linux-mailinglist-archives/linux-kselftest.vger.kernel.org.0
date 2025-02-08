Return-Path: <linux-kselftest+bounces-26090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB764A2D50B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CD03AB2C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8AE1C07DD;
	Sat,  8 Feb 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MemCyHvM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AB1ACEBE;
	Sat,  8 Feb 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005420; cv=fail; b=Re27NooZNNGApd4ZUbVgqxEs6eRXvg1vQPKE4zQWalc8CwJyfzSB3mShElrzImfBwnm3rN5m4I0p1/XKra1LT2Y5pTubfhMUp4UuBFZiH/zXYI2jO3uvm8cI6nqnH/q2hB3No7qYPbv4dNjklY+YjZKRN9mceauA+iNlXj//xhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005420; c=relaxed/simple;
	bh=8IgbYt7sjPJ6J73A3RwVoBtt7FS81878575Tj1HWNNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+Gr5dWEK9igxuVSoD6mSOa3AbdqlzMY4Wo1PEgCv+lwd5f2Nywq9DXeVyqtU/a3WJsgoiacMYKUMD5BYW5vPNHHjzHFO/Hb7/6G91OhIY+aw+eRlFrkdOxEjJtoBMWM8RIbwdjecJtpLis50ndJsbgMhcQs8ZcC1fXnsH1WFO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MemCyHvM; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdAnc1rvUbe7RN5szDbVsgCQMDhUPnnn8DjmEjIjkWDFN6Ba0b5awBHKEB5RJScZbFSJ13P3J4fWkI27zNL4Y2U5HxCH8bkMdDg2mXiy/YoyNrOdhOzZ5WdP5cb8q/vz+LB+HDg0KtEuFAeB9SCE+bQ//lvG2xBxW+/b1rrOtrWvmx9i9emyU0YXq86D7aADLUZ0sjVWjXnTYvrWmFNa/qHFbt/Khl9WKFIiippm6EyLTiC4W9YuEj5h0i8A1ZwP+o7MAR4iM85oYm8WdNLRl9g1w1e5WJlg1GAxs8vGgddseaPb3Ykmbk+qiwS8QoNTX7fRzRlZO0l4dntGpz9rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iqipAWJNsOzidSS57UFbifnGAokb7H+HFB6FjfIMx0=;
 b=HjPZCaJy5Mtbg/bXtJwTFPumXjCOb5frXTfyHIx+c4ZqPf4qV320f6hy0K/cumjRtdbhzIVyuIvfbYNdCwV+MakwHvE+ZciTgU6WRCKIzJGBnU6FJFHuXd4ipReO3zqFyvDLnkBCe+2R0RMfqGL9tGiwFmnAMt92fZi3dtxgL2mHKadCYrPUEZ1C04MjqUcABx8e7sAWoCarylLBY++PmOOAs9dV/ZAICnmgBTPUbGKAfGKcNwYKrrHdp52igTd0p0Nmi4pNRMvsINbWyGBdQhuOu/t+hCHcAYz5q+FtsXX1c4vfSGVUn/c3VoMPdIMbVvLui7NRkdtuRU3hLa7eJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iqipAWJNsOzidSS57UFbifnGAokb7H+HFB6FjfIMx0=;
 b=MemCyHvMb+wWpIV7tTBn/7Cyukw1ABlFf3ISKrvgtuT/Ed2mBVwrBEgvsyRvXxzf+k/gXiZ5a08r6B8X1Y6QB4lTSuleQtzEb9AVyH6CgRuwrYSnZp2b0BdowBmPz58ZNaiWs0+4K1DYXWL4vpO0V+FjEjzM63B5siWHTX6/zRgYhHLsWURVg8EIMwynRVyA4yg8AWGJ5QXH85oz/fW8/XYy2j2Iamih4p3TtrGWIICAQ+13WQLm+Sc/6KUFHU7bXe24v5+LKt7XQ7L6ELA1/70qMcmaJVEsigtpbu8q8pDDY5UjmhLDbGZd+841DAf+CGGd5eXCfm/+aco4iHrNOg==
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Sat, 8 Feb
 2025 09:03:32 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8d) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 09:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 09:03:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 8 Feb 2025
 01:03:19 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 8 Feb
 2025 01:03:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 8 Feb 2025 01:03:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <tglx@linutronix.de>,
	<maz@kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <baolu.lu@linux.intel.com>, <yi.l.liu@intel.com>,
	<yury.norov@gmail.com>, <jacob.pan@linux.microsoft.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v1 10/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
Date: Sat, 8 Feb 2025 01:02:43 -0800
Message-ID: <525b9ffa94dc5842f98bef8cbcbf426a2a8292be.1739005085.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d90a11-432a-4a8f-26ab-08dd481f7635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiwMPYcIuh40MRuOKu3GaZ49WT2CE7+uKgm3XDXWj8+q8szLkqHamcUd1Dbt?=
 =?us-ascii?Q?i0vTo+QHnS4QNAYZfTkf36DPGyOcxRAdFkT5tClhtp3cijZf6npeme+hsrwP?=
 =?us-ascii?Q?xx736mCgyFG+hOLvYP2iKsp/BXnkF1Utb1fzabhEXCOdsA2DkBST/usASzaa?=
 =?us-ascii?Q?oqnX+/1hO42bCs5QoY7DVK23RUvqEa/1ZpTihgj55AW4fsQVSdFayAroKwa1?=
 =?us-ascii?Q?hWFyrWP/rYtRGu04iVM7f6KISsiaQMunRiA7klqS2rgC2lwEG6WvZkL3wxxw?=
 =?us-ascii?Q?qtvFGfyqdR3Pt+MoEauOf0n+dTJX2HHosbyxaJWda+SWBQeE475QxxcUG3pL?=
 =?us-ascii?Q?82Sp0TxKxpjIX9l9DC44o6QTnEydQuClMN9ODMd4YKa3WShKoo790Ionq3bE?=
 =?us-ascii?Q?wif7NLHX/ERmQAmWHkC+5nJp6nrOwZnnps4ocRUAt21Ux5HXs0IYCCfQhpHF?=
 =?us-ascii?Q?GZPd8Gby0Os8A2G7nfDC4mAR1jDID4+4wgm64t9wmboPceqbmof7QnPfpJsw?=
 =?us-ascii?Q?jbtVGU3VVLDvPyhuG4u0GpqKAngnUeiRy4+DlxNnZvZExmHkhmCe+ECuX+fJ?=
 =?us-ascii?Q?2ZZv3m5hiQxNufq3/DG5lBcMib6qrZNHhHQdab0vwkG7uH4OTyujfHow92Ct?=
 =?us-ascii?Q?Quu0fDnVol7ZVrQTdPDsD/tSGlRMVWVR0WQ3Mw++UczOxxzE3XnZzeAFsf8I?=
 =?us-ascii?Q?MxYezTPmyHyCe43XZDgKIWGt8hGSGDTsJhnXdxSLUjc+20oyRg8f8gCf9i/L?=
 =?us-ascii?Q?yOL1jsg8MeU0ND8umVyKG4hRlDh2xcM+vD2Ca8LBYxZbXOVgKtG+FWgj99yO?=
 =?us-ascii?Q?s5nsIPG3FTwEpVsTtXXtpCfyZsct7pOfJaLxMB9BukbeitkML7cy8dzatDyq?=
 =?us-ascii?Q?eVoUwxtOgOLZh5E1Yz3ovvm++4XmMNmbec2CA4sliW5G01OAVwGNRdrZfAd5?=
 =?us-ascii?Q?UKUjm5keJxgmwugt+XjbKrVMpkKTdAD/K0FKqw+GzAQO9mg19/9+YndfMzcV?=
 =?us-ascii?Q?Tbx8cp0Dft0pvBjxb4Y++wsJGcExHzoLxjUhoi57V23+hUH+2C/Su+d28Apw?=
 =?us-ascii?Q?Sn2UVMrsY10+IbHWt4hcBaXM6F3ZxIjjk9HMtl6NBkzWXykhObWtccO0YwUq?=
 =?us-ascii?Q?y5WKVh8HCg2ygIO2OD22NvWkB+xLLyoHZXWC5O1xgY5S1fUrFrECjymepYEG?=
 =?us-ascii?Q?plL0LQmMKorR+5REnLhYxqNMec4CkO42OydB3RX+Pz74u48JKdKWqWl7waBW?=
 =?us-ascii?Q?TE7pKuxz16s/hb37afkLLLSy9sPi9qPWa+RkIJvKvwWYbOv+8vM1QjHCK+LZ?=
 =?us-ascii?Q?sYqWFKvwbpmRfmAmXbIhTku9OZakrXLVfFS1PudSUKdY88mJ5mckKeL5AFrR?=
 =?us-ascii?Q?yRrY0iiMraK0AWF2MhiY5QxdR3BX9iHBkfCpmjP1dUtkNQm0qHDSwm91EvAa?=
 =?us-ascii?Q?0tMfdIuPug8nQqyUDJjT1Dpp7hlH0wpsDPbzjChlCM+8JDFFFoDITgU4Y92m?=
 =?us-ascii?Q?Yy8Pj2l/XUGftVI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:03:31.9453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d90a11-432a-4a8f-26ab-08dd481f7635
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252

For systems that require MSI pages to be mapped into the IOMMU translation
the IOMMU driver provides an IOMMU_RESV_SW_MSI range, which is the default
recommended IOVA window to place these mappings. However, there is nothing
special about this address. And to support the RMR trick in VMM for nested
translation, the VMM needs to know what sw_msi window the kernel is using.

As there is no particular reason to force VMM to adopt the kernel default,
provide a simple IOMMU_OPTION_SW_MSI_START/SIZE ioctl that the VMM can use
to directly specify its desired sw_msi window, which replaces and disables
the default IOMMU_RESV_SW_MSI from the driver, to avoid having to build an
API to discover the default IOMMU_RESV_SW_MSI.

Since iommufd now has its own sw_msi function, this is easy to implement.

Keep these two options per iommufd_device, so each device can set its own
desired MSI window. VMM must set the values before attaching the device to
any HWPT/IOAS to have an effect.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 include/uapi/linux/iommufd.h            | 20 ++++-
 drivers/iommu/iommufd/io_pagetable.c    | 15 +++-
 drivers/iommu/iommufd/ioas.c            | 97 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  4 +
 5 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7a9cc6e61152..2d1aae7c8610 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -279,6 +279,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
+int iommufd_option_sw_msi(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
@@ -423,6 +424,7 @@ struct iommufd_device {
 	struct mutex iopf_lock;
 	unsigned int iopf_enabled;
 	phys_addr_t sw_msi_start;
+	size_t sw_msi_size;
 };
 
 static inline struct iommufd_device *
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..310256bc3dbf 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -294,7 +294,9 @@ struct iommu_ioas_unmap {
 
 /**
  * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
- *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
+ *                       ioctl(IOMMU_OPTION_HUGE_PAGES) and
+ *                       ioctl(IOMMU_OPTION_SW_MSI_START) and
+ *                       ioctl(IOMMU_OPTION_SW_MSI_SIZE)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
  *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
@@ -304,10 +306,26 @@ struct iommu_ioas_unmap {
  *    iommu mappings. Value 0 disables combining, everything is mapped to
  *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
  *    option, the object_id must be the IOAS ID.
+ * @IOMMU_OPTION_SW_MSI_START:
+ *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
+ *    This option being unset or @IOMMU_OPTION_SW_MSI_SIZE being value 0 tells
+ *    the kernel to pick its default MSI doorbell window, ignoring these two
+ *    options. To set this option, userspace must do before attaching a device
+ *    to an IOAS/HWPT. Otherwise, kernel will return error (-EBUSY). An address
+ *    must be 1MB aligned. This option is per-device, the object_id must be the
+ *    device ID.
+ * @IOMMU_OPTION_SW_MSI_SIZE:
+ *    Change the size (in MB) of the IOMMU mapping region for MSI doorbell(s).
+ *    The minimum value is 1 MB. A value 0 (default) tells the kernel to ignore
+ *    the base address value set to @IOMMU_OPTION_SW_MSI_START, and to pick its
+ *    default MSI doorbell window. Same requirements are applied to this option
+ *    too, so check @IOMMU_OPTION_SW_MSI_START for details.
  */
 enum iommufd_option {
 	IOMMU_OPTION_RLIMIT_MODE = 0,
 	IOMMU_OPTION_HUGE_PAGES = 1,
+	IOMMU_OPTION_SW_MSI_START = 2,
+	IOMMU_OPTION_SW_MSI_SIZE = 3,
 };
 
 /**
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 441da0314a54..6e6dcc480922 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1441,18 +1441,27 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	iommu_get_resv_regions(dev, &resv_regions);
 
 	list_for_each_entry(resv, &resv_regions, list) {
+		unsigned long start = PHYS_ADDR_MAX, last = 0;
+
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
 		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
 			num_hw_msi++;
 		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
-			*sw_msi_start = resv->start;
+			if (idev->sw_msi_size) {
+				start = *sw_msi_start;
+				last = idev->sw_msi_size - 1 + start;
+			}
 			num_sw_msi++;
 		}
 
-		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, dev);
+		if (start == PHYS_ADDR_MAX) {
+			start = resv->start;
+			last = resv->length - 1 + start;
+		}
+
+		rc = iopt_reserve_iova(iopt, start, last, dev);
 		if (rc)
 			goto out_reserved;
 	}
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a8..1fc93bc70bf4 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -620,6 +620,103 @@ int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 	return -EOPNOTSUPP;
 }
 
+static inline int iommufd_option_sw_msi_test(struct iommufd_device *idev,
+					     phys_addr_t start, size_t size)
+{
+	const phys_addr_t alignment = SZ_1M - 1;
+	struct iommu_resv_region *resv;
+	phys_addr_t resv_last, last;
+	LIST_HEAD(resv_regions);
+	int rc = 0;
+
+	/* Alignment Test */
+	if (start & alignment)
+		return -EINVAL;
+
+	/* Overlap Test */
+	if (!size)
+		size = SZ_1M;
+	last = size - 1 + start;
+	/* FIXME: drivers allocate memory but there is no failure propogated */
+	iommu_get_resv_regions(idev->dev, &resv_regions);
+	list_for_each_entry(resv, &resv_regions, list) {
+		if (resv->type == IOMMU_RESV_SW_MSI || /* iommufd will bypass */
+		    resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+		resv_last = resv->length - 1 + resv->start;
+		if (resv->start <= last && resv_last >= start) {
+			rc = -EADDRINUSE;
+			break;
+		}
+	}
+	iommu_put_resv_regions(idev->dev, &resv_regions);
+	return rc;
+}
+
+int iommufd_option_sw_msi(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_option *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->object_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+	/* Device cannot enforce the sw_msi window if already attached */
+	if (idev->igroup->hwpt) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (cmd->op == IOMMU_OPTION_OP_GET) {
+		switch (cmd->option_id) {
+		case IOMMU_OPTION_SW_MSI_START:
+			cmd->val64 = (u64)idev->sw_msi_start;
+			break;
+		case IOMMU_OPTION_SW_MSI_SIZE:
+			cmd->val64 = (u64)idev->sw_msi_size / SZ_1M;
+			break;
+		default:
+			rc = -EOPNOTSUPP;
+			break;
+		}
+	}
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		phys_addr_t start = idev->sw_msi_start;
+		size_t size = idev->sw_msi_size;
+
+		switch (cmd->option_id) {
+		case IOMMU_OPTION_SW_MSI_START:
+			start = (phys_addr_t)cmd->val64;
+			rc = iommufd_option_sw_msi_test(idev, start, size);
+			if (rc)
+				break;
+			idev->sw_msi_start = start;
+			break;
+		case IOMMU_OPTION_SW_MSI_SIZE:
+			size = (size_t)cmd->val64 * SZ_1M;
+			if (size) {
+				rc = iommufd_option_sw_msi_test(idev, start,
+								size);
+				if (rc)
+					break;
+			}
+			idev->sw_msi_size = size;
+			break;
+		default:
+			rc = -EOPNOTSUPP;
+			break;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
+
 static int iommufd_ioas_option_huge_pages(struct iommu_option *cmd,
 					  struct iommufd_ioas *ioas)
 {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b6fa9fd11bc1..f92fb03ca3c1 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -287,6 +287,10 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	case IOMMU_OPTION_RLIMIT_MODE:
 		rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);
 		break;
+	case IOMMU_OPTION_SW_MSI_START:
+	case IOMMU_OPTION_SW_MSI_SIZE:
+		rc = iommufd_option_sw_msi(ucmd);
+		break;
 	case IOMMU_OPTION_HUGE_PAGES:
 		rc = iommufd_ioas_option(ucmd);
 		break;
-- 
2.43.0


