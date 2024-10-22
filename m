Return-Path: <linux-kselftest+bounces-20341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACB9A94B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAE71C22CDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60B71B3A;
	Tue, 22 Oct 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+kmXRpU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D430126C04;
	Tue, 22 Oct 2024 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556431; cv=fail; b=sd5UKIH6lvNWKmQ8iKEua7Wb8S9GPNYSEcjDA3qyd5vLvifS6yznwNYHddMX56VKdUT7OVlB6TNlmomnwClqnKdFfUD7tqnwb+Q8okqgUDk12CfnC5QLUoWxaOTGEzwB/G2uCcsKndRhnVlUie8GUNO+QFZR6qILMug1mFn6JDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556431; c=relaxed/simple;
	bh=yFHZGiTa3Kr6a9TZ98Gt1kGeEOt25pFOydFmBKLC2s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqIvpQayQYviv4pg3z92jsI9VbGcK81NwNjfjvAqrq1jGoj9j2YaKSib3c0tylUJ6z2TzNvwszVT9MlYe5IQ6yqiH8azdlJIC1u6rMrqv9qp9ywFOQSnjKc/qUL32RDnZ1lmIKAPV4qYaL6l4/uWCB/+bv45dQ2kFD/Q6W/UCns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+kmXRpU; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZctvWnaCZghXZ0hXBEzrMX7rLALiGZLuwjjAQ2FrWrluwDdb5jSk00MudZq/+L0Zar6VA7cTQesK7voQS0Ldod2KGAaAYW/pbjA2mP1Ruu3ZZD1njpCdL5tgpPGU2/x0hL6/w55llEB3AbYyrNZFGvKh+zKrddgnPWmv8tNWUwanZXMw/tlDI9DBM2icolXTmo+VO1nNy/Sn5VXtfK2S6SWgh8E/RU6IlZXSruX1GfSKrwIqyUiV0jGhJhBXVWx7JkPtpzuFfxJP1e75bC2R/93boOczWlWIM6MTBeN+v5ETzlE/FDFZOwLOtGLXMhlW973G7swNBuiD3AZx4ZeJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaZj/0/qzf2gqR5W4kDyC2Pv3YLPq974RgNJQnRyxMM=;
 b=RoR8qYVnJ9xfEJKpURxmwd3GnBStNu3P4TiXos7V+wJFuCU3rNcBbdl/wAZgXkFnoMZhXp8vDKeTyQolO3edP2wbYAgFqdPiwR9ZWnG/0//47HD2zg0JfIxBU1WI4M1bkcUg7kE8tiYuhPQJR2LfXKXjxmp3Suz6eOf+evAfWE1nouWfJ9/c2y1HcNPGUfwbFFx4WaShlD4k18DZOYeTI6wIAANFykk5k0PvXrHRLdHQntKdLhK/sW+T7t5inzz891UCGHCHfetqdbPtHFd5uQj5vZ+iIJZowgH/ph2vb7qawZHB47KIXUxg1J64l42f5Won0Qowj+w9lM4CHtxf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaZj/0/qzf2gqR5W4kDyC2Pv3YLPq974RgNJQnRyxMM=;
 b=I+kmXRpUPT6EUui3Jbfv4ezrwUOsni+M5aOucgDaSgxp8iKICU5FtT2DEbwH1fSCdWHoC7MvMuDFzWDLuU7NAbCsdUO9DDMiJyZ29BtlpQwD1igO/JXlh8zz9bwXKYdwapfJy3MGEFyWPEwJ0FbY0iTjlziHOBI1urTje/bJPgW3MUcT+WaMfnQ1fRnAsTiigubbZQ17btdth9sC4523qy/aDqSBFxI4Nht1rcyoRadAo3KIw9HFzrKP5TCH8QwbtI6VHQsmqmXgT0sH4v9QFF7cDY0BOlHnSacfxbDGGoR1r+w6A5UmJnIGhQ1GK1CB82n4eeZE7x1vLiFaNu7Bpg==
Received: from CH0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:610:b3::20)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:20:25 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::27) by CH0PR03CA0045.outlook.office365.com
 (2603:10b6:610:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:07 -0700
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
Subject: [PATCH v4 06/11] iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
Date: Mon, 21 Oct 2024 17:19:28 -0700
Message-ID: <ba9ce9b3c8a93c9c790fee52961d075dfbb63ca7.1729553811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729553811.git.nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: e88d6e03-1194-4834-3bea-08dcf22f535b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ut9DQR0v1Lu5Ju7PvbxnnosglX1o1WObY+ZiekqBBm7mFV1HVZ4Qky0aF17w?=
 =?us-ascii?Q?wIhY9c3jwnLfK6pLtwtwHzkIQFq4PEdPi6p9b6RmoocMShaZ9LuK+zGhgEFO?=
 =?us-ascii?Q?FIlokgf7UclFxLo6uMOVu2O7eKfNrzyaXNUbpdE7dVUKYWCrXV/3bLAMlKdV?=
 =?us-ascii?Q?AACjyl6X0uze0idwfdQ23Je31WZfpZE5+c06uH9QXLGeNtFBQX1HTZHDYlAq?=
 =?us-ascii?Q?6ysU65HOVqzHw4c+fP1ClsRKyV0Gc7vgc2Q4tOIjLnfpN/MzgfGjz7S8c8n7?=
 =?us-ascii?Q?s+RZ8pib/TUaeJuLUKPUPaemDH/rh9EXPRaVYjJfw+c8PSw29ffBqjxr4EhB?=
 =?us-ascii?Q?oCn7QAnX9S9PaWg+R7BNHjPEetiYD8XqdpamGvihZrkNAYJE3M1HXBgdkcrT?=
 =?us-ascii?Q?g3vxmu6BtaN5+lz0ccW9qKE4BhtJVL/xlhFACUph1ZR5WhqeIoYFDbrV4dwi?=
 =?us-ascii?Q?fy6IuzLZ6jaLPiB2ZY6NEcIWjbj3/XChW6Sl/BD4RaYTVyO+ZkV2juD9MulO?=
 =?us-ascii?Q?y0trQBvZHyKJ18dyHLhXkq1Th292KQH4MYYLRtb+/ZZ0TZEw1OGhnx/jAVNi?=
 =?us-ascii?Q?zYKUUXjj6Vx0szH/w4SxL3LATYbmXE6i7Vl9y7wuA4D4PABXxwody3nMZvGz?=
 =?us-ascii?Q?G4wREdCr2B9AsGd8divJ9mo1OlBiK2qRG1B6UxVQ3HIRNWzvW/EOfTBwaGpp?=
 =?us-ascii?Q?zUxCHoqo+ITxpyCqf26CG36Er240E7cZloJVUt3gtftN+e8dhn0idcuzY2r4?=
 =?us-ascii?Q?NhRD/4G3/MZWqB/7FpLMP+fe0ceKiuNwVEpfIJpo5ah98OB44jgSqbTOFeHY?=
 =?us-ascii?Q?LSejiPydLsCJdhlWA13m1I/s1UQC1G1oDtCSKYbsBoJ5oOgrZSTGhQEJ6rtm?=
 =?us-ascii?Q?GklIBrenRrIrVt7SdYh/0Hwgwes46+BCElX03xZ+gESUuPON6J/urZ6MaWQL?=
 =?us-ascii?Q?Htp0UWfvBVdn4eXsTN8jrNUUi2d28EVnVhdJ2UmpW8RINGDcA8mZhPh2ylQ4?=
 =?us-ascii?Q?SFuFsX4PSaWTdZEHpIYGrnw0UqRTR1P7fhFOQFssM/T9LxVMMj3v0rpRnnSx?=
 =?us-ascii?Q?Sq2Q8YKGDoth7Efktx+veoeSvPiHF/zKNk5NrbPmtdVswc3wvfVq/ZkRcAPv?=
 =?us-ascii?Q?n3zrSx90PEwyJr4ZyZRJAfjcRRxPkPexC7Wj+pgVM7zWIan7yRihAzSMeTU6?=
 =?us-ascii?Q?z4ylHQkxPE3k4ijji1Tr9LMpK+XQjUU/G3upo463g6F+KKvbu48lpOeBKyuQ?=
 =?us-ascii?Q?o3UWB+zudyJpa1z9XwOFdCMdFgbpte3+jR46tLtuhjGmF0TwymRvdKn3RZDP?=
 =?us-ascii?Q?QQEgth9+HUUObgTk8k/LKV8zsaK6mIYy0WsQVjg2nstU7AWX4VyWsz/lsPM6?=
 =?us-ascii?Q?IpkPKbJ6MV4QPE5t6pdtV2HcAoLY7J+famVPbWeLF+7wMtN3Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:25.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d6e03-1194-4834-3bea-08dcf22f535b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
that nesting parent HWPT to allocate a nested HWPT.

Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.

Also, add an iommufd_hwpt_nested_alloc_for_viommu helper to allocate a
nested HWPT for a vIOMMU object. Since a vIOMMU object holds the parent
hwpt's refcount already, increase the refcount of the vIOMMU only.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 include/uapi/linux/iommufd.h            | 14 ++---
 drivers/iommu/iommufd/hw_pagetable.c    | 69 ++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9adf8d616796..8c9ab35eaea5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -288,6 +288,7 @@ struct iommufd_hwpt_paging {
 struct iommufd_hwpt_nested {
 	struct iommufd_hw_pagetable common;
 	struct iommufd_hwpt_paging *parent;
+	struct iommufd_viommu *viommu;
 };
 
 static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d1c99285eda0..f835ccf4a494 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS or HWPT to connect this HWPT to
+ * @pt_id: The IOAS or HWPT or vIOMMU to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
@@ -449,11 +449,13 @@ enum iommu_hwpt_data_type {
  * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
  * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
  *
- * A user-managed nested HWPT will be created from a given parent HWPT via
- * @pt_id, in which the parent HWPT must be allocated previously via the
- * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
- * must be set to a pre-defined type corresponding to an I/O page table
- * type supported by the underlying IOMMU hardware.
+ * A user-managed nested HWPT will be created from a given vIOMMU (wrapping a
+ * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
+ * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
+ * case, the @data_type must be set to a pre-defined type corresponding to an
+ * I/O page table type supported by the underlying IOMMU hardware. The device
+ * via @dev_id and the vIOMMU via @pt_id must be associated to the same IOMMU
+ * instance.
  *
  * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
  * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..5314cd486ddb 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -57,7 +57,10 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
 	__iommufd_hwpt_destroy(&hwpt_nested->common);
-	refcount_dec(&hwpt_nested->parent->common.obj.users);
+	if (hwpt_nested->viommu)
+		refcount_dec(&hwpt_nested->viommu->obj.users);
+	else
+		refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
 void iommufd_hwpt_nested_abort(struct iommufd_object *obj)
@@ -260,6 +263,54 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 
+/**
+ * iommufd_hwpt_nested_alloc_for_viommu() - Get a hwpt_nested for a vIOMMU
+ * @viommu: vIOMMU ojbect to associate the hwpt_nested/domain with
+ * @user_data: user_data pointer. Must be valid
+ *
+ * Allocate a new IOMMU_DOMAIN_NESTED for a vIOMMU and return it as a NESTED
+ * hw_pagetable.
+ */
+static struct iommufd_hwpt_nested *
+iommufd_hwpt_nested_alloc_for_viommu(struct iommufd_viommu *viommu,
+				     const struct iommu_user_data *user_data)
+{
+	struct iommufd_hwpt_nested *hwpt_nested;
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	if (!viommu->ops || !viommu->ops->domain_alloc_nested)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hwpt_nested = __iommufd_object_alloc(
+		viommu->ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED, common.obj);
+	if (IS_ERR(hwpt_nested))
+		return ERR_CAST(hwpt_nested);
+	hwpt = &hwpt_nested->common;
+
+	hwpt_nested->viommu = viommu;
+	hwpt_nested->parent = viommu->hwpt;
+	refcount_inc(&viommu->obj.users);
+
+	hwpt->domain = viommu->ops->domain_alloc_nested(viommu, user_data);
+	if (IS_ERR(hwpt->domain)) {
+		rc = PTR_ERR(hwpt->domain);
+		hwpt->domain = NULL;
+		goto out_abort;
+	}
+	hwpt->domain->owner = viommu->iommu_dev->ops;
+
+	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+	return hwpt_nested;
+
+out_abort:
+	iommufd_object_abort_and_destroy(viommu->ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
@@ -316,6 +367,22 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_unlock;
 		}
 		hwpt = &hwpt_nested->common;
+	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
+		struct iommufd_hwpt_nested *hwpt_nested;
+		struct iommufd_viommu *viommu;
+
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
+		if (viommu->iommu_dev != __iommu_get_iommu_dev(idev->dev)) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
+		hwpt_nested = iommufd_hwpt_nested_alloc_for_viommu(viommu,
+								   &user_data);
+		if (IS_ERR(hwpt_nested)) {
+			rc = PTR_ERR(hwpt_nested);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_nested->common;
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
-- 
2.43.0


