Return-Path: <linux-kselftest+bounces-23888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B67A00E80
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 20:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC893A3528
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C511BD9CA;
	Fri,  3 Jan 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7ZRZRbH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938A7DA95;
	Fri,  3 Jan 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933477; cv=fail; b=nLCf+jQ6951snGvTgt4Yp0NhW5BIrXv0+jCxKOUGHZ+lgj701Lqndp/GbSG7l5EbkExDUTKijJuvGXwVmjks60jOkF8Ew/O3irzstPCL7iKgjI8i/CtDw9e4e2zT5mm3pr4FM2fp5PxBG2n/dCmkcnzSwlO4+8eSK6oRqmQk5sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933477; c=relaxed/simple;
	bh=uyvlttn3hhtqUTEilFAwyyGspQqDp/HVBzXm84ustgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgZaW93i7f8FtbtvoTqjWtuakFKSoIJ7SFR4O0w8hiLa4LbA1DZ1rBEkYgb/x2v1YRvo25s6EPmJIF200ELxWhYZ+J3ze0fG6I6Rrf586SZ9vmrDwoY/5BWbH6kLfUJ11bh+wOiQXZVjgF/KvdfWdSY6ai9fkzpMGPCSmu12NZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7ZRZRbH; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWTcY1pYupUz3FE0QmtgKMiat36/i+UwPHWgF6eeWOh/5hsH4vELWo085OKTwJUqxMCEyr9+QYugLZ2E84UOcs6ix3AaexCMJPp49TteM0GcgPmupmt/KRsiTO02WGHrR93uF1ELT8ABka3XBq1lbbGbAayvpPqMyQlnm9YsQwNJJVWmwbmsheAImkKlGqX1wcAUyF7W6qdITEMERmjjNLQCjOTU/iwOnYy4q4EM1xYp+/eKDleQhe5A7RcLYFhqbLT+y5dwrBIo1+q7s7BOZo3GuVFIB6sZKposyqJGFAiFoqqaFRr3r/XeNHYk8rgRK3r03CKqvED4U7s0xdB+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRkl+fZMxEYykug99pc9ntbWuoGTyAfUXFg8/3nf6rI=;
 b=Q+kAI9XKxI25njCiVmjNprOFTgJ/xpyGirr50R3xUdsSUnYBfyJLywJHYiv65Nhp7CCrZBwEGugnOv6BC26h9aoMx3GYq8Hkc0vckPwDqwvv32b+5KBhuc/NzwA4Di4U0d8Au8o1CrbjLkilU2IGRzuNoxLoh3XUSEsQF/OTYaj1OAtIccWMZ8VXUQuTvd85vcHKaUdnWyFdKMU3OkQ6eD7cX/fsx0+bT51TNDMHz/5Pl8Dc+7IfDWRjsDSIrRuNe9UyW2zuIXdXUq4aNbjpJA3CMRf5BQlsQRY+zn9cKDMiUH246gFpQSk9TAQk0WUte+3cIItN7HJrS5Ktyo3X5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRkl+fZMxEYykug99pc9ntbWuoGTyAfUXFg8/3nf6rI=;
 b=m7ZRZRbHyo++fcF1Q23+H0myIJtlRmGuR3MUGlIA3IKlImd+N6HZCk0mLvrXCy4sY6yRb5ASFvL9tFwbmggkb0VtzOOC/F7vW34rxLKKZv/s5K7ZxhzhBnieIf5qtpBw/lJGf4v8YomChLeH386ezXJHKQmd72OXrabIrlsf5ik5Za94jG9zpDuJxTaJbAi71vL8AP2OVmNjriJ0Q3PbRIHBZ0vq5oWpPYDQcFzQCzjRO88YI9Ht10Q7ewev/8g90lttwVcDt1EIAzemvVS9EEBzgsv3Sua0PHCfT2VcY7FpbpnRYZhDX+cJq2n7bd5yLSHG0h0Vg65a3dP69SKeJQ==
Received: from CH2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:610:38::38)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Fri, 3 Jan
 2025 19:44:26 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::45) by CH2PR05CA0061.outlook.office365.com
 (2603:10b6:610:38::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.5 via Frontend Transport; Fri, 3
 Jan 2025 19:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:44:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:14 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 Jan 2025
 11:44:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 11:44:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: [PATCH v4 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
Date: Fri, 3 Jan 2025 11:43:29 -0800
Message-ID: <d0edfde78e75b6941589392e618f6d43b3f10e6b.1735933254.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1735933254.git.nicolinc@nvidia.com>
References: <cover.1735933254.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 9792e41d-ef17-4ec3-ea0c-08dd2c2f080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jaoYA6lB+RPcOkHwoTWMuwr1RUOVvL9KTrlOg/s4ZjnSp9b4+jl/B0TwHBYY?=
 =?us-ascii?Q?f+nJ2QQfG4fFEcO7Cj65d0p9POTx9kmohC2U0Iv81rzAyFDFvL37rmFXDC+3?=
 =?us-ascii?Q?PlhZ3QbPZt+I9dwsavMtK5NcFmuVdSiAy38b+/k0rcQczABgeqH0m1PCFFP/?=
 =?us-ascii?Q?GB43H542X++gAFM7NyMyf18RZDud2wqNKl74vifVEYeYdOJdocc6l0J74EEZ?=
 =?us-ascii?Q?V3lahuGd0KoGARa4TOqZxmkKMIy7wujUkYJwVCL4tr2QfYKaP0/VGTivK8SR?=
 =?us-ascii?Q?pkuN65BosVmkRT2mst/YujYcRB9YX8mahZZBdrkN1eIuePprFRXGEuj8zO2Z?=
 =?us-ascii?Q?4PlH5McggFyjMQWeA0IKw2qRSfmao0Bwml9z3dAQBO3e21eJstvC7/EtPFn+?=
 =?us-ascii?Q?ACnT9VCzoRQ9DX7a3FEJ5BN14dd0bZhRvCZ5brRy0haOXiojTstGJ74rTCJe?=
 =?us-ascii?Q?C+xDq9048WVgTLt/3T625e5apovyYYsI8enG/jMfae0Jxk0ZudhPh1a/opQS?=
 =?us-ascii?Q?Bq46G32iZwCXFtwMZoYHlm+XJZF650smQkRlkb+KRp89zPdGlyZWYHj804dg?=
 =?us-ascii?Q?9QLh+I26Wkx0UZoNUkIHHxAab88Ia+TMW2x6Wu800m1h2kJCbF9kSG9SEpRa?=
 =?us-ascii?Q?BnVKKLIKQs8jFTz+JYHuaO9n746Lfd5nyPHskbJpz3w0B8qOUiNj6OlyVZfE?=
 =?us-ascii?Q?fVG7Nmk5onsbf3w0zU/1/VqYKtYVFk20GRqqsz8xXYw0Z2iBy9xWk4R5DVu2?=
 =?us-ascii?Q?5mqWn86ri424e/LnT+QXTAECYq/2Ja1j0zOCULsuWcp04LbHAH8wltu2513q?=
 =?us-ascii?Q?FcpJAhTViJ/kcsBmxFVGcXAoQ03DU9Y1ocbLIcd6S9E+bVE18r58IxiX3kIv?=
 =?us-ascii?Q?3YYjlr1t81x5GU+2qU+JSFddEsagwjnUDG7RdHLCOQBANxqaWsW8nYFfrX2P?=
 =?us-ascii?Q?624cF78Ztjz53ZxGNrmYrHygB6Wvs9UCNXkc0q7vqe387gTKxBRltRG60ruE?=
 =?us-ascii?Q?hGxSXIx9TuLLIEUlLe8m0lWByl3i07TDSwbyxcV3xTeYfW4KYYnbztQzDt5Q?=
 =?us-ascii?Q?WKWVe3Xja9su53lefl7ekJa254XQgjZM3MtNY9OtB3zjHQu6EuUV8m4CbYLx?=
 =?us-ascii?Q?/GNjWGaIqEO2oIche5CMIrQgaVqIjSmSqX6Jf5a3yiQ1xNxdbBrKOH+K1R7F?=
 =?us-ascii?Q?s5KjszXClySNsVQQYJkIwPoUQn6An2Xz+obE6CtY7ul8W3rnk3LYQ3qzxRrI?=
 =?us-ascii?Q?tPAk/sUReAdUwauA8oIICq8uq1FhTJh+0aBFgCvukeMIlH5CYedWY0ANME9q?=
 =?us-ascii?Q?1T+WdLQXPV5mJ8Lyra+YDOTfjU7CgOkTHd7RUbXEH7xNzt+vsVflPkHlpr4g?=
 =?us-ascii?Q?aXVvljeeyW7MOw1qfMyc4v1k0mPiMqH7gh1TUIurFZnPD0mrr5RgQnrZvPOW?=
 =?us-ascii?Q?1WW/OhjqGiIjK+PxBE20yzOwNQVlVn8z1jIrwg3UeMdhskHOzFQG6tf9w3s1?=
 =?us-ascii?Q?2ChlxCwD9uuG0eM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:44:26.5065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792e41d-ef17-4ec3-ea0c-08dd2c2f080c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
provides user space (VMM) another FD to read the vIOMMU Events.

Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
vIOMMU can only have one single vEVENTQ per type.

Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  58 +++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  31 ++++++
 drivers/iommu/iommufd/eventq.c          | 129 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   7 ++
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 230 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dfbc5cfbd164..9410f6275b5a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -547,6 +547,50 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+/*
+ * An iommufd_veventq object represents an interface to deliver vIOMMU events to
+ * the user space. It is created/destroyed by the user space and associated with
+ * vIOMMU object(s) during the allocations.
+ */
+struct iommufd_veventq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct list_head node; /* for iommufd_viommu::veventqs */
+
+	unsigned int type;
+};
+
+static inline struct iommufd_veventq *
+eventq_to_veventq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_veventq, common);
+}
+
+static inline struct iommufd_veventq *
+iommufd_get_veventq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VEVENTQ),
+			    struct iommufd_veventq, common.obj);
+}
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_veventq_destroy(struct iommufd_object *obj);
+void iommufd_veventq_abort(struct iommufd_object *obj);
+
+/* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
+struct iommufd_vevent {
+	struct list_head node; /* for iommufd_eventq::deliver */
+	ssize_t data_len;
+	u64 event_data[] __counted_by(data_len);
+};
+
+static inline int iommufd_vevent_handler(struct iommufd_veventq *veventq,
+					  struct iommufd_vevent *vevent)
+{
+	return iommufd_eventq_notify(&veventq->common, &vevent->node);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -555,6 +599,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_veventq *
+iommufd_viommu_find_veventq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_veventq *veventq, *next;
+
+	lockdep_assert_held(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(veventq, next, &viommu->veventqs, node) {
+		if (veventq->type == type)
+			return veventq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..8948b1836940 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -34,6 +34,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
+	IOMMUFD_OBJ_VEVENTQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head veventqs;
+	struct rw_semaphore veventqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 34810f6ae2b5..0a08aa82e7cc 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 };
 
 /**
@@ -1012,4 +1013,34 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_veventq_type - Virtual Event Queue Type
+ * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_veventq_type {
+	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
+ * @size: sizeof(struct iommu_veventq_alloc)
+ * @flags: Must be 0
+ * @viommu: virtual IOMMU ID to associate the vEVENTQ with
+ * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
+ * @out_veventq_id: The ID of the new vEVENTQ
+ * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
+ *                  successfully returned fd after using it
+ *
+ * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
+ * can have multiple FDs for different types, but is confined to one per @type.
+ */
+struct iommu_veventq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 out_veventq_id;
+	__u32 out_veventq_fd;
+};
+#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index e386b6c3e6ab..bf0c04f571a7 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -346,6 +346,73 @@ static const struct iommufd_eventq_ops iommufd_fault_ops = {
 	.write = &iommufd_fault_fops_write,
 };
 
+/* IOMMUFD_OBJ_VEVENTQ Functions */
+
+void iommufd_veventq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_viommu *viommu = veventq->viommu;
+	struct iommufd_vevent *cur, *next;
+
+	lockdep_assert_held_write(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
+		list_del(&cur->node);
+		kfree(cur);
+	}
+
+	refcount_dec(&viommu->obj.users);
+	mutex_destroy(&eventq->mutex);
+	list_del(&veventq->node);
+}
+
+void iommufd_veventq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_veventq *veventq = eventq_to_veventq(
+		container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&veventq->viommu->veventqs_rwsem);
+	iommufd_veventq_abort(obj);
+	up_write(&veventq->viommu->veventqs_rwsem);
+}
+
+static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
+					 char __user *buf, size_t count,
+					 loff_t *ppos)
+{
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	mutex_lock(&eventq->mutex);
+	while (!list_empty(&eventq->deliver) && count > done) {
+		struct iommufd_vevent *cur = list_first_entry(
+			&eventq->deliver, struct iommufd_vevent, node);
+
+		if (cur->data_len > count - done)
+			break;
+
+		if (copy_to_user(buf + done, cur->event_data, cur->data_len)) {
+			rc = -EFAULT;
+			break;
+		}
+		done += cur->data_len;
+		list_del(&cur->node);
+		kfree(cur);
+	}
+	mutex_unlock(&eventq->mutex);
+
+	return done == 0 ? rc : done;
+}
+
+static const struct iommufd_eventq_ops iommufd_veventq_ops = {
+	.read = &iommufd_veventq_fops_read,
+};
+
 /* Common Event Queue Functions */
 
 static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
@@ -473,3 +540,65 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_veventq_alloc *cmd = ucmd->cmd;
+	struct iommufd_veventq *veventq;
+	struct iommufd_viommu *viommu;
+	int fdno;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+	down_write(&viommu->veventqs_rwsem);
+
+	if (iommufd_viommu_find_veventq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_veventqs;
+	}
+
+	veventq = __iommufd_object_alloc(ucmd->ictx, veventq,
+					 IOMMUFD_OBJ_VEVENTQ, common.obj);
+	if (IS_ERR(veventq)) {
+		rc = PTR_ERR(veventq);
+		goto out_unlock_veventqs;
+	}
+
+	veventq->type = cmd->type;
+	veventq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	list_add_tail(&veventq->node, &viommu->veventqs);
+
+	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
+				   ucmd->ictx, &iommufd_veventq_ops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	cmd->out_veventq_id = veventq->common.obj.id;
+	cmd->out_veventq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
+	fd_install(fdno, veventq->common.filep);
+	goto out_unlock_veventqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(veventq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
+out_unlock_veventqs:
+	up_write(&viommu->veventqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 49be19305d98..985661a4af07 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -310,6 +310,7 @@ union ucmd_buffer {
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_veventq_alloc veventq;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -367,6 +368,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
+		 struct iommu_veventq_alloc, out_veventq_fd),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -502,6 +505,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VEVENTQ] = {
+		.destroy = iommufd_veventq_destroy,
+		.abort = iommufd_veventq_abort,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..01df2b985f02 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -59,6 +59,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
+	INIT_LIST_HEAD(&viommu->veventqs);
+	init_rwsem(&viommu->veventqs_rwsem);
 	/*
 	 * It is the most likely case that a physical IOMMU is unpluggable. A
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
-- 
2.43.0


