Return-Path: <linux-kselftest+bounces-27502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CFA44831
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85880188C330
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4620F066;
	Tue, 25 Feb 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYg91v6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392C1A2392;
	Tue, 25 Feb 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504390; cv=fail; b=D4DR9gTWR1gZ7pR7BqWflywZpvV3LvouFquBdIXRorF52bEJtPmhSaT21JnLe/lO1c+MLb90UF8DUzU5rmVD8lqZMluPp/wCnTCYwlyRUICrY8mAd3BH41+O2/qEHs9+k61Wh9Gz1MMcDYNCNPX/dKhyN/7YCafWHQnh1piqDWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504390; c=relaxed/simple;
	bh=/oovXKEvr85KL95liQV3fD1dIu9pcNraawI7G1d4TS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4UZsyNimKsAhZXZH4H44c2E3q9Z56oatFWhPvb/ob4mMNla/DmFngvU7jS4ptG9ykO/QadOgGlZCtACz93w230XzKMlhlLsNLjvHvFHQx9l4TC325JCnRvLlHXsl4yFj8xU8XNS21FH1X1RsTR45oFtTAopJOHYRQTavnRUSHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYg91v6T; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoglarXHRsObGxgImGSwcfHVn0c4eXNDsGvCMVtDOS410x95IqEBLy/y7qeUFsw3tMiaxeINkki7S906GImzdjTu3kxInhU7AWjst9F9M9hZZ1Dva70Rk62bUZ1+toHIoEMEvfmNCIcrc9tWVR9HwhUNtBY9K/GWXWGef1ku6siBbd1BxvVX8UZg5SzYKp/gjIr+IHA5dsBM3eqr0SOEZ8gJx41ojL8wGzatZcFC1KvQtmBKwNkmLFZAuJ4bv8hHBlJu7XHZiM3LO+l4d/jZkxCY1Ov+opxc8OyLur0bYBUXQiiMQk7SY0Wm1fLon3biyvxoC+Y/o3cIQ/rJu/TlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QszVBaTXI1X99FjxRjl89cCLhJn7jdyFtRK52yyNUqI=;
 b=FbGwmk4BqajtnlutX6mlsTc897/tSzaghiiwaVQcBNVDkQUiFE2YttJeUc/aEmfL3uk6K6Y85niZG2XzMDTwcARZtPangU2ikCWBwsgvOgHDMXSSvxWVWwy47DJGzcqq2X4lMLeac5ZrZS6MZlNOCzxNjEUzztTReN3gT9pz70HkOOXKNVCue/XWSm0ulnLFSKtd/4rzLroUMSbmTFGJZvNJUV0/IISxyFhqVOuCP+qQLoGPLUBkavkxW9oqwu0AEBzJYph2eiiVL4TdLQP8WeLdIvqa5ulVGnjelcRssouLw0dQIVz5SXtu3xtKBSecDB+veLckAkZ45PaoUPXJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QszVBaTXI1X99FjxRjl89cCLhJn7jdyFtRK52yyNUqI=;
 b=EYg91v6TmLxnjA8mh/OgDndbXmSS226MJjSs28TjLPiKqBSV4RAWKXEk1vmq3AzCBNdiGImaqsPLj5DSzW4EPhgmUQWqXFvzq8WNHySgnro5D/wZnCmaJZmelHwOHAoDlak/LVQVS8V6eCbMgfqOQltdAHmhrS7X3V4VxoO5bVICyMrrNd3Xcm/ZnYsZ1ys9YAbjqyrah7F+/fR6j8fzmQ2Er6Ii2pQbN8NBF/byYckqnIoWxV1liaC3qINDkSHtCSBW+O6PS9d3UHzjoZPGxxDFgVeUtZHsROS7RnHO9r2duItDBJw8gbELjFf7UoITteB0J/Bmjfr7hXTe2mOdtA==
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 17:26:25 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::1a) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 17:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:26:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
Date: Tue, 25 Feb 2025 09:25:40 -0800
Message-ID: <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dab517-711e-46c6-d399-08dd55c1879c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQ8qmjtTE8a44oFD2MEIR3pspR1Pxv1FWKMI/N5afGUJpZOJbWDai5EDy7o/?=
 =?us-ascii?Q?r5d8H5KoOqDKyPQcLgQY8EJ5sRKnH4ry4V0Kl2aP7O5kx72RF+muAhMw79Q1?=
 =?us-ascii?Q?8JW2Avn4dkA0INNPujpq9/uhxCm6jHjrEG1d8o8yTORMAsa7Pve7NZqT83dH?=
 =?us-ascii?Q?EbWVKz94gk6KwE2SiH20M/LYh5Xrk5ZoqagQG9bLek2exrp1dRnoBLFnVLcH?=
 =?us-ascii?Q?dPylds9VFJ4ffrxjPDC6ErueU+xqplETdc+YsGtvO0YXWE8em4mycsKqCxaf?=
 =?us-ascii?Q?hiotAeyjEPNi7QoZGQM6OLAYSe8irwD+xvgDqYxDmgL2pJpuf1YDTpRjqPAT?=
 =?us-ascii?Q?AORARaXwBQhD4cySfTVizcjeNjRAbANBQhEfcJ6Owjb6/wc/O0Ool02Hskg2?=
 =?us-ascii?Q?ewIRpGbCQdoBJT9WSmJsAkAswmgqGa5Df+h+Yp6VbJ9fEzgB0sZjOfk1q902?=
 =?us-ascii?Q?yQOvgvCpiEwRK0GRLmjhq7PQvdv7tql9H4uAwh9UU41relbirD4+CQEWtCm0?=
 =?us-ascii?Q?rOLave9o2oIZFOn0HL5OQvM3/NCCSwwVGTf8aqGPb1VDqqop/9UYv6J4Oqkn?=
 =?us-ascii?Q?bZvjz77hxpTcFRW7dmhZBYkvTg1ZePieZuoD4FPn4uqe/cfMf9tSIJ+tJSit?=
 =?us-ascii?Q?WmNE1sGP6JWxr8Q5pahbY7QQjr3iBBuGJ5fE0lg1MjkBmwRil1QHyV49LJxB?=
 =?us-ascii?Q?L6RKNml5wYigqB3cQ16g4+lu0UW1wjYLEZBkzzGF+Nq2KYheE9JYLb/qu2ub?=
 =?us-ascii?Q?0ouI/t8jZyY+y2woMrc3KcQbeManAHY7/vIAYMeoRkACxT9AdHRRu+U5AiAi?=
 =?us-ascii?Q?bWcBvZGTsDBDToFxkFiVtxFcxzDpn732jwIJDhohVE2rnzPo6aovK/uHeaqg?=
 =?us-ascii?Q?OYy3ov6jiV9GFiPbzAXn2Nd2gwDanBSjAdrADs9LpCruViZmSTSsQPN3DFb7?=
 =?us-ascii?Q?QebFXYQp2OgGS3Pdt9xa2PKfs0FXdfYHslRnUbkVtRRNngjcBYmv4mc0Asyz?=
 =?us-ascii?Q?Awp0162ewrgKuJ9rZwaD0WSGnlxi/Ai28GA0UvbSr89g8W4mKsSzLa+BXvCR?=
 =?us-ascii?Q?vzD+4AIcWGjPZH6EqaWRANwZg+LCM8WstPQ8qe4QjQUWRAAOFyK+5a0qgMlU?=
 =?us-ascii?Q?67Z6d2p1G35yTpfoT3dwI9TKZNhLwbcgFlf0tA8sg536e4hshDVJiyhBUQ5E?=
 =?us-ascii?Q?aslRDj3R7bsZjjgBIHkiPiSJT2M7of0GfJqBMb9Iz2eJgx8eC2xm34Tnm/G2?=
 =?us-ascii?Q?inGgV7QNBs6zMhbbWObc6Ec/+GEYqjPPL4yPxUTf9g4JUryiLIfqAWDLgRgA?=
 =?us-ascii?Q?HV5P4VDQKeCGlMHpku6YODDmQ6LOnWpJPaK8nik5qSHveZejsmLCITGIdbGP?=
 =?us-ascii?Q?VY2WWkfcCCRM5jL2bj5VZodiegyY+VuSJztwdJEe+BKRBr7o6hTaic3IuPJ8?=
 =?us-ascii?Q?V1129yU7ef2lc2Zkip7Bz6Szx3Jd0Cus4zXovzGj3I19F02M/2InxDA5G5ZJ?=
 =?us-ascii?Q?DD3uIlrQ6blV5NU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:24.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dab517-711e-46c6-d399-08dd55c1879c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583

Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
be the first use case. Since the vsid reader will be the eventq handler
that already holds a streams_mutex, reuse that to fenche the vmaster too.

Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
or unset the master->vmaster point. Put these helpers inside the existing
arm_smmu_attach_prepare/commit().

For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastavat <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 28 ++++++++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 45 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 +++++++-
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..36961a3579f2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -799,6 +799,11 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_vmaster {
+	struct arm_vsmmu		*vsmmu;
+	unsigned long			vsid;
+};
+
 struct arm_smmu_event {
 	u8				stall : 1,
 					ssv : 1,
@@ -824,6 +829,7 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
@@ -972,6 +978,7 @@ struct arm_smmu_attach_state {
 	bool disable_ats;
 	ioasid_t ssid;
 	/* Resulting state */
+	struct arm_smmu_vmaster *vmaster;
 	bool ats_enabled;
 };
 
@@ -1055,9 +1062,30 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 				       struct iommu_domain *parent,
 				       struct iommufd_ctx *ictx,
 				       unsigned int viommu_type);
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct arm_smmu_nested_domain *nested_domain);
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
+
+static inline int
+arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				struct arm_smmu_nested_domain *nested_domain)
+{
+	return 0; /* NOP */
+}
+
+static inline void
+arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
+{
+}
+
+static inline void
+arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5aa2e7af58b4..6b712b1ab429 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -85,6 +85,51 @@ static void arm_smmu_make_nested_domain_ste(
 	}
 }
 
+int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
+				    struct arm_smmu_nested_domain *nested_domain)
+{
+	struct arm_smmu_vmaster *vmaster;
+	unsigned long vsid;
+	int ret;
+
+	iommu_group_mutex_assert(state->master->dev);
+
+	/* Skip invalid vSTE */
+	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
+		return 0;
+
+	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
+					 state->master->dev, &vsid);
+	if (ret)
+		return ret;
+
+	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
+	if (!vmaster)
+		return -ENOMEM;
+	vmaster->vsmmu = nested_domain->vsmmu;
+	vmaster->vsid = vsid;
+	state->vmaster = vmaster;
+
+	return 0;
+}
+
+void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_master *master = state->master;
+
+	mutex_lock(&master->smmu->streams_mutex);
+	kfree(master->vmaster);
+	master->vmaster = state->vmaster;
+	mutex_unlock(&master->smmu->streams_mutex);
+}
+
+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+	struct arm_smmu_attach_state state = { .master = master };
+
+	arm_smmu_attach_commit_vmaster(&state);
+}
+
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 				      struct device *dev)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..964d2cf27d3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	struct arm_smmu_domain *smmu_domain =
 		to_smmu_domain_devices(new_domain);
 	unsigned long flags;
+	int ret;
 
 	/*
 	 * arm_smmu_share_asid() must not see two domains pointing to the same
@@ -2832,9 +2833,18 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	}
 
 	if (smmu_domain) {
+		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
+			ret = arm_smmu_attach_prepare_vmaster(
+				state, to_smmu_nested_domain(new_domain));
+			if (ret)
+				return ret;
+		}
+
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
-		if (!master_domain)
+		if (!master_domain) {
+			kfree(state->vmaster);
 			return -ENOMEM;
+		}
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
 		if (new_domain->type == IOMMU_DOMAIN_NESTED)
@@ -2861,6 +2871,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
+			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
@@ -2893,6 +2904,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 
 	lockdep_assert_held(&arm_smmu_asid_lock);
 
+	arm_smmu_attach_commit_vmaster(state);
+
 	if (state->ats_enabled && !master->ats_enabled) {
 		arm_smmu_enable_ats(master);
 	} else if (state->ats_enabled && master->ats_enabled) {
@@ -3162,6 +3175,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
 	return 0;
@@ -3180,7 +3194,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 					struct device *dev)
 {
 	struct arm_smmu_ste ste;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste,
 				STRTAB_STE_1_S1DSS_TERMINATE);
-- 
2.43.0


