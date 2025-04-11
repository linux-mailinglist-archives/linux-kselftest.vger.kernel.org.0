Return-Path: <linux-kselftest+bounces-30515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD42A8547B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0184C4B39
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597F283C93;
	Fri, 11 Apr 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IlZZjTQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527C28152F;
	Fri, 11 Apr 2025 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353532; cv=fail; b=c3lBwctZjOVeaYgOM/XUm6rgUvFxSQn+tNIASVxTKJeBRsAKdeRL1qVcahoYjmEq1zMm/ILxSU/61ccMgFeValTVp39BeprkjOZU0xNq2mh6NQQn9MacgHtggPEd/vi4jwr5jM3W76PlSSyuB8bgr2dRN70BSdpcEJ6L04AdSyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353532; c=relaxed/simple;
	bh=VCc/ll5Dev7wAimiV2e7egiLS8RuzJmRBR/3QmNXoyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avebwlZ2EWHbivIiyKj1M52hvwSl6xmgSwPwtKKZY6EKTPQcaghF7dMJ3CFlAVhQZUx/fiHaJKHzbyu7BVsVYWowOCYhYUnhGvcRXGVsDvbU3ckuXlGrnoV9ad5nLTI6EYU5blid7IvaOcPnc1tewpN4tC5AmZV1/QrnS8IOlgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IlZZjTQ2; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuuEAPFVoR87JHhJp7np0pX+xOhCdFLbAeofbG/Uqd9NvSY1zMGSSJznS08y9eKigTQkKvefxYfi4aIgn7k+1hKkbVTUndampj+khHJTEY4oCPqh1GHJtQW8EE7NQW+w92yaZEJ2jrx4nrDdRZ4uIycW7LvEX93sUjnfjPrqeCy3Aw0/UKFRET2XGTgpvGRVqj0wm5tWXgGMsgACZHHkgmJeU+bbba0V0EKFK3PPp3GI1/QLGHOhqWt6lNHd+7zjVRkvI7E8lnMTwiCU73Ed4rqAgo1H1iDKmmsoCeap8qKf9zLMEox1kix19sBwCwcwbzPa5DC0rLrLolzBhD5EMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7gPTdDnFSQn+n3MYxvJDXUwZhr+1/Fg90lwDTJNLPI=;
 b=UPPMTK4uBTjOqBmk2B1AKTK3ajZUuv9alSH7ihQXKPZnASXqC8PKtorN8NRFaWkrOuVf31TggEkeiwf7mh2vIUp3MakXxvAwhefBkDYakvuUNC9Vyv8Z0rH86aQKYPCjAp0K1yZG/GQ2HpcHB+Y+JBS+UfzqZSNOFW5lacrdRFg4XLYxC4BhkUio+I2giV+EzVD4fTk8gRQJGex9Zq63v10pVuAH1fXcdwdAaG2OpDSmd2vwuob2gTc4tXDEz8SOHMf9dgBH+8Ko1t65eXkJ3jnaZPVxiM7YuXYYsKR64lJQz250KUsGo9F6YiQp1YrzvaaycQbg6aR0NF8k4V9E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7gPTdDnFSQn+n3MYxvJDXUwZhr+1/Fg90lwDTJNLPI=;
 b=IlZZjTQ2+ITK5RHCZUE31ygytFiWkmXIQ74A30HpyqSJZrXT3Ldqh6FYIOqapuC/2V3eshrrIGaD3Y4jtWzXpMhYOfp8mj0YrX0CeMbvJ/8Olr+UMoxJNYVzkgV2a2FUYac206+VjiJrCDbB9YLzynFxLMY/NDAgHakQGk3I2UfKSXfhorUoGwRLIe49K2015vPu6LaEsECS2ONEP10HVz1/o8kogrBCBy4pL0HaRGun/o+CIwQX18b/waZfQ3elFZjCEAF1wCRO5Xq61dMNIzCnTnRyP6dQFRHe+wN81YNSsIYnpMBqZDvbMIwaF20oojSJ4431Zh675Wq+LuKFZw==
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:38:46 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::ba) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 06:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 16/16] iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support
Date: Thu, 10 Apr 2025 23:37:55 -0700
Message-ID: <f95d5276e5a1d09d82c6865a5d02e7504d24a400.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d62232-6d1b-4e65-d974-08dd78c382d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYGHHOoWT4GfFTmXzgTXstoCSnU1VBCCePXgCeikAi+errbZcY9VS+NGR9+o?=
 =?us-ascii?Q?jCZmLVae+rIGLLlcKfa7v/PKi96+w6MgUlYDN2VyTLoJ5emjHnzE2cqhbrC1?=
 =?us-ascii?Q?jDM+h2D32LdH56EYNdnKDkW/intNJt8LA7E89JyNXp5Rk+ei260CxrHPzp9g?=
 =?us-ascii?Q?9bWY6mFTPALMgJvYzpUr4KlFts4zcPlWW04L/YQsspgA6QbWNS2OH+ETkhVf?=
 =?us-ascii?Q?DESiJuyrrygdI8pp3D2m6aMGj9tdLoi3MwB4/e6gr1UfePZbvd3Li0iFlPsP?=
 =?us-ascii?Q?JWsr3xRYjslMa46NqJmUWrUAiKBZSNkmOADxXmBshNGpsHWjtdiySy93rEEe?=
 =?us-ascii?Q?Sn6ayFpSUmx8t5s0smSWGwTzsnb73FdnCnaPfvDmskR6BE7YIg2QMF5UAixs?=
 =?us-ascii?Q?Ft57c+njOJJpqiG+dbdFLadhrTO5ngH5gSMneURPVeso6H8+2rDBMF/XvIpp?=
 =?us-ascii?Q?6yZt5cv41DmUgJWNoUAVJ8le++VLcYomltqE2u/s+COQswEINL307LsuOGbk?=
 =?us-ascii?Q?CqBK+mdLsCop3KVt2qW1CsYIQeAhvLcHuzWR7AqrCbdHE2f80kzqV62gPKmr?=
 =?us-ascii?Q?ARBynndfJ+rsTM/N34j07ZNoug02cRrmDd0xJic6Em2UOiqi3I55EYWWi/+1?=
 =?us-ascii?Q?2nIVPBw79PKq9QKQPpfVbDfyapd/IeWVREpa2Vj/NXxnTW/tdtZ2PK5Re7D2?=
 =?us-ascii?Q?gwDkb5OnCp9Vang6htDYT4gXxUMDR8RUwCx3jDRlQ9ftgbzoIo9XNheGdUSY?=
 =?us-ascii?Q?g1WcTBEv/4yi9TiRL8ypUMhzeOlbinbDxbpdnaJpQLXsFAcTpp9xLSvuXokT?=
 =?us-ascii?Q?bfrJnkHqZmMyd+oJseK8DGzL8S6BxUJEwQZw/1SnfrccUlegRUFjHB/8ZzxM?=
 =?us-ascii?Q?he0lLXwv5n64euOB9IqNamgeEUCsuWBfeNtKoMprlmIVr9exrNksDtXeRjdw?=
 =?us-ascii?Q?bnskagEfBrnFGkrSugmjQV8LeGPdvG+l2qBoNGNpBr2NoTLu3dKxR1GF9YVM?=
 =?us-ascii?Q?TVR3lrWBDhx5EdDUAv25WvIzUbsAHDNhVJN2HEnhrdjV3uKC9jdIuXqUtmub?=
 =?us-ascii?Q?hQP+VCCRBt3ohEkmxl5/Z1GYSuPlgZq7TMhuuMH7cr9y18ggNogGDavxrv0I?=
 =?us-ascii?Q?rHPApZCdJZ2El39BNsNeYutLJJsT3bVZlmW2PP4ui9gDVJU7NY3Ns7T0MqE/?=
 =?us-ascii?Q?Pf1I1aPTk4Knu5lPu3eqb2o64XZ0V5D+2LolKhuqstHouBnozYbyn2SiKmR0?=
 =?us-ascii?Q?CKAimsJbwRxpieziApUjy/B2yN3/xK9f8KJhmV75G15bzi1LdLiUSPlE+IWD?=
 =?us-ascii?Q?LEDdPqgvx06GG9BqY2fTx2EdP44u3gJYMEnlIO4HBdQ90KmkEVOc4W0WRq6w?=
 =?us-ascii?Q?JErFAVn2l+Q597kDFuhozLXXtgvKH3YX+Y+tK0CyDqB4BqnERucx51Ok7pH4?=
 =?us-ascii?Q?zBNyl2jHQgOadm2DRYOfQdyc/pGL93saipQz5AVUmoMhmXb0MQGG8AZ7T2+g?=
 =?us-ascii?Q?89y5rvF8ASUMTUOrV9tLZcibHf+3EKO6RONy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:46.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d62232-6d1b-4e65-d974-08dd78c382d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

Add a new vEVENTQ type for VINTFs that are assigned to the user space.
Simply report the two 64-bit LVCMDQ_ERR_MAPs register values.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  | 15 +++++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 22 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ce20f038b56b..dd3f6c021024 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1100,10 +1100,12 @@ struct iommufd_vevent_header {
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
@@ -1127,6 +1129,19 @@ struct iommu_vevent_arm_smmuv3 {
 	__aligned_le64 evt[4];
 };
 
+/**
+ * struct iommu_vevent_tegra241_cmdqv - Tegra241 CMDQV Virtual IRQ
+ *                                      (IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV)
+ * @lvcmdq_err_map: 128-bit logical vcmdq error map, little-endian.
+ *                  (Refer to register LVCMDQ_ERR_MAPs per VINTF )
+ *
+ * The 128-bit register values from HW exclusively reflect the error bits for a
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
index b778739f845a..dafaeff8d51d 100644
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


