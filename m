Return-Path: <linux-kselftest+bounces-24019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE65A047C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F0D161E0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534821F75B5;
	Tue,  7 Jan 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4OyfDcd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607C1F3D35;
	Tue,  7 Jan 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269874; cv=fail; b=sJ7pOGCbPaBaVV6DVKukLxTpU4QtIYjFVlT9pSZ0IaNIsHFTxiN8sFphTG7fvYNNk9IM3ksjiMjwQ+IznIrpH21vUckDKUgBb1vE6KGCPMDkiYfJ44GRG0oyyGRJVstPOCrcASF+Qbk6y1KWvXXyL6/B0FD2LRSKr3W019JQ8fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269874; c=relaxed/simple;
	bh=vOK7ifOVnMqREoXgx8ARJ0fAnUloUqDRtxhBfaMGsq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEazrbHG0XM+jb+0Rk1fR2DV3fmsOcQFMn9TUZAxuIT/FX3kLd64vpE6USEHkddb2cSoxLCwDHrLlFG2dNrQzmXEtagYhtQjcLVpeuKhXo8QxozUPq8uoFktyZjJaB88q4PJrRHybt0vKcM5KolZezVootA8LTCgDiyyl2bAV4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4OyfDcd; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/d6ffaomR7UJa698u+jR5mJcZ7fNiQgvAEMJr9eRq94zYpzGUBrVCT7kt24jtvg7QY1uirAGVkg+RXHzwZHSdC4A19bEwJv+vofulteM61eaq06RjxjKNbFDbq67PQ6WY79POdijDvcDz0yOic2uR8E8U9Nmkx96zsZKnDEU6ssNapztLklPsYrz7jP+qfgtOCMC6mnUyrwlYM1OK+VCsOom+EUq3gv0NJj9F2O1e1aAhbrwQIAOrntS0gK0lpu44sBQZIfTlNfpk62y1GyY9HiQyjTV/CnUQ09oI8QTuPIueq7FL18TUt79nbKBiz25pMjF3wkJMtyoYjM6zwkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD8L+p94ij/cRbnTaS398W97mnn1eUsxlqmIjapeULU=;
 b=es2q/AX1h9GpkiTXfCk7PA8WHsFPGwf9NwoTeFnp+STsSXkwEZtu/k5TdeY942zFgKW2inXcYM9NGa2YaKwMHd9cKyU56SIFDmCmimwI9+DxLBiGDz5MEFVVZX57tkZM+o6+WjPnaddrQEq1XiGmXoijyMjC9zP0m9jSzESGGMpgGa7Qu9CqRFv6xTSW4N+FzAPUS7AOWmqViq5hIXXUxF6SUZDNHLuq+eJfMOFztA5bs8hPVEMS3VNBg1WBVmlcNTfXqSsgIooMqANiN9jqu1iDW4FyR5U7toEiRrQJfKMVH/EARTkPuUIaJtkBn/gV+eqgmfNSz/il1FoEkOO9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD8L+p94ij/cRbnTaS398W97mnn1eUsxlqmIjapeULU=;
 b=C4OyfDcd9cSPN4TuQ/iYUXnfQl+Zmtxlk/VYsRR6xqyqgCE0774B/XH4ASPjfAxDw6RhY4dukZKs72PHhBw7EOKf0i5xtZLtHoa7J6n0jUFRaHBhNaKrTeBzasnKRyWODDQ3nCb3N/XjaD7Q+/gbc0J13abFb/uAcyb7daoCBCcJ8tEGJGxfy8nqLb9mNYFB7xJIOZVMJ9vw+pTl/vD79QzLThVMjenKFsI5/c6TcONazt5s2icrSN+TxE9yMV9UFSemucalwwYEJZFHe3FOCFnTm0nDnW7qpXP33/NskpekISN0CkcYget/gpi1PFL7zdDaljf0UGptQySIJ2/kKg==
Received: from SA9PR13CA0123.namprd13.prod.outlook.com (2603:10b6:806:27::8)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:10:59 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::84) by SA9PR13CA0123.outlook.office365.com
 (2603:10b6:806:27::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 17:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 17:10:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:42 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:10:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 09:10:39 -0800
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
Subject: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
Date: Tue, 7 Jan 2025 09:10:09 -0800
Message-ID: <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736237481.git.nicolinc@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 365e6b84-5a7f-423e-694b-08dd2f3e4180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYmXyEFC4JBly8RZeHijW4iB2cZeMGxjz1hQsFiG5hkwXcSMtIDwqttJ+8EV?=
 =?us-ascii?Q?k4LRb5c34vdpWda5PAtG6vrK6d3D6zE44X1PvcQAK01fkjoQBMOpzspvsHUx?=
 =?us-ascii?Q?pjmPFFYw0SDrCifj/u7y2pWVLB3Tp4hBC8/za637Y7bjngqEOw7nCYRIX45X?=
 =?us-ascii?Q?S++Owgk/QNX3NzvvnoqNfaSIvpj2f8kc2nEwYeZ9p8WfFkg3pLoxQ++SdwwA?=
 =?us-ascii?Q?J1tWL2ikZ8DViW1YhZIi4SQ5ei4Xz77mIruLxyMKvfwo4gHGRULuMIDu2+Lc?=
 =?us-ascii?Q?HN0DMJ+2vBR02/G25qOMT/y8X0yLps8A6bDfN+9FqltqBvxyyiVca940NGH5?=
 =?us-ascii?Q?C1+P2IZSlpJpsCLQ+Gdjvbxfj8OvTtTeTtFiaaXhHVETmJHDzETEnjtky2Lm?=
 =?us-ascii?Q?EH+0ngMdpSRrQbtMzvtPZUPWTtGhNjV5pVxS5XDPLi2xiQMGJpARSVcfWUCz?=
 =?us-ascii?Q?YgkOiwYNMj9WtoxzZ49gkfpNiyDkvvPdgsqfTgq9v3ksklUptq4Qk5YTjGBN?=
 =?us-ascii?Q?ZWGdRzEJvo65KtiAaVLiLxQ0mBwUhgQ6MepMGMlMb5w5aNS4TpKGZM/AKRn/?=
 =?us-ascii?Q?xJJYE6U580h/u57UPz7yp+SQ/UWZmlSs/Pe8SAmUMbjtl8GUnTFSa1oegbf5?=
 =?us-ascii?Q?AadWQjB0Cer+bYqsExStpJXSBfHXqvkRCg0RbtzK/n/UrvdsE8LDr9dAh89i?=
 =?us-ascii?Q?rIO2EZJBfc3PtYodYMbyMXAMhjdbi7UcEafFQj4QUXAF2+UIttK56r7vuFTV?=
 =?us-ascii?Q?fs286P5qMX9QiMuIU+RPt3xhcDpQJaZd7mO51dNDgC7pzgry22ARavQQmF7S?=
 =?us-ascii?Q?A79l+bMU4lwRRAjp1muEe9OYP1AqZCKDZk8uHJqrF/UQAVR4uHI0klTkkvSu?=
 =?us-ascii?Q?BmwUAI/otdlDUGPURBBhsg1UHEiBUatzyXjKqVhyCeCeLT9e6LGa3Wh8Opfb?=
 =?us-ascii?Q?YNsDQ5qvkVHkjryK3ZGjpchjMn/w7L9OA/f4mXmomjIaDF4NWRt4rMfXpNLR?=
 =?us-ascii?Q?FTiraOcLTACzbnbVChSp8T7rrZxiCaj7ZEPWaf/Px6KySzYTqTSeoYEatbGR?=
 =?us-ascii?Q?HHYA6h9Rb7xFzHtMTrGQrRIMI4weKGkr3jv019zftzREJHBC+b88cKL45edp?=
 =?us-ascii?Q?gYBBUgs1J0IfV3IaonYnHAXnoCTG4UV6nPEYliJWP4784ghQOyHLPJhsztDt?=
 =?us-ascii?Q?S7YAKiWRXyvlT1b+QOXAK6qukS8uUU6K96zkkY5/xieaOr6CeGyep0Q9cT+g?=
 =?us-ascii?Q?pjktTvVBQbycVXtDcHVg57KHEfft1ceG9e3v4da899MpJNNlirKGpuNkgN5T?=
 =?us-ascii?Q?WgCBnMwUBWpvgLzyMlviWRmRQryb99MbyalFbMpCm6i092cGhj5dEeIJWOzW?=
 =?us-ascii?Q?vrJQn/kpiFRIv8Jneq8SfKizVRNn18E//lZMlJWDbMZOWdIJAbFb7AmPcSP6?=
 =?us-ascii?Q?vMTuCbegW/nN8EgFv0BcVSD6+38g5Os79Jse1nISiQSPx52Lo3gnE50bxQQ4?=
 =?us-ascii?Q?tqX/PrKdlIUUndQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:10:58.8328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365e6b84-5a7f-423e-694b-08dd2f3e4180
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
provides user space (VMM) another FD to read the vIOMMU Events.

Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
vIOMMU can only have one single vEVENTQ per type.

Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.

And add a supports_veventq viommu op for drivers to help the core code
validate the input vEVENTQ type.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  58 ++++++++++
 include/linux/iommufd.h                 |   5 +
 include/uapi/linux/iommufd.h            |  31 ++++++
 drivers/iommu/iommufd/eventq.c          | 134 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   7 ++
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 237 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dfbc5cfbd164..3c0374154a94 100644
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
+					 struct iommufd_vevent *vevent)
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
index 11110c749200..941f2ed29914 100644
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
@@ -113,6 +116,7 @@ struct iommufd_viommu {
  *                    array->entry_num to report the number of handled requests.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
+ * @supports_veventq: Whether the vIOMMU supports a given vEVENTQ type
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
@@ -121,6 +125,7 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	bool (*supports_veventq)(unsigned int type);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
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
index e386b6c3e6ab..b5be629f38ed 100644
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
@@ -473,3 +540,70 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
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
+
+	if (!viommu->ops || !viommu->ops->supports_veventq ||
+	    !viommu->ops->supports_veventq(cmd->type))
+		return -EOPNOTSUPP;
+
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
index a11e9cfd790f..0d451601fb9a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -308,6 +308,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vdevice_alloc vdev;
+	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
@@ -363,6 +364,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
+	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
+		 struct iommu_veventq_alloc, out_veventq_fd),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
@@ -505,6 +508,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
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


