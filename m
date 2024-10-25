Return-Path: <linux-kselftest+bounces-20746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35189B139A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032F41C21FA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59C21F4B2;
	Fri, 25 Oct 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MnOMBhpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF921E741;
	Fri, 25 Oct 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900280; cv=fail; b=nc9Sl9X6f3Vcp+JCol0pRwsZuWhw0OMP/NJg7HTuqOQd1hToOwOhtusPb3AZ1DgI95LG5xRq02oFdfAudi13jO54TUUzm8N3DDribdMbLW76Mep6BnjxA5XG4Fnpu4TuIKOnd8gbAzWke6RfwHsrgJN90uNH9Ra/wNUo2Q9HnYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900280; c=relaxed/simple;
	bh=z+CIohTvZsyvKVADtR5qfpa3ofDVquHGeTqJn6uFHOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTqLKb7EaUTTAcUUEWaAvc71tWI9mYczbGQjQbzWpQhQdQSSPhiSl7n2AWSWucyjPoKZG5XPAjH/61/JGUBbeOwNZUSSCi+LEEZPFoNm9klBPgzsdeQSo1ioGrXZdYCmyXXwdomz7NO4Vp71INAQOShtn1pz1h5hrpXAjz5fQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MnOMBhpI; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBQpg4GQIK0YTD5m18eiSGTibeooZ/qTQ0YdSsZaM04ZTopPIVUvaq9kQ/7kQVv39rgLgL6PxCChNt48VnsnI+SZN6g7V+ou5EMMYemkeACQWlrqfFFzf4JFybYLB7/oFCaILm58StwLUX4drjIuEnPHVgyZJYB5o95yD9MUDDKzA2K+Fo/QrJyna2aLWWTxZ0SDY+gJZjY8zCDv70cP7M3L7FLVFlYPJA1WVaT7tuvOjr1FWhQEqJP6J03Bz8Od9nU9c3+27Ejal6FSlhWHvBGhfdU/wA8aIo3wSlakRpx5YnNMtOs/2YEATvG7PpXA3KeOB+q5C1b9sX0CCgrqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F5obBqATICOdBkQz/EV+SUSAYbGIVH1Y1YVLS+PyJw=;
 b=nNfwxvLnjYn2e09hmRgZp1hDvpK1Veyx7jOgj8qZOKum+9CMa50IJTMIxvPCoWLQO7lZTDpoNrT76sFM7ZnI16XWK1iHPCKa6O/dfjf22jymxwEFWHRXh5MZWZK4P4v1c4U/pnjqHeCiw5G7KkXVVxQp6pWzAQEfWAueJf4/wakt+OnqPsfAC3KFz/uFOdQkRPyRPDavy5odLXRtB0H1rlgSDUyPjAgdj8UkSg1L9yS9wjVfsia9tQRN/0bhlzflHzsiNHTSX272KtZZccwm1bQf4bAarKSYiBEFgISZ+9oF1kQQzBzzAzq1fQLU+ZhhdGG6FUhQ/dwF0C0WUucImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F5obBqATICOdBkQz/EV+SUSAYbGIVH1Y1YVLS+PyJw=;
 b=MnOMBhpIAGrPTBXzTDtjn+VH1WusOeGfydecLlewxkL6PcYOPu/jWui31RWywVnHAEplxanpGo5t6eB+qciikMQWoYjyhHzXnzkPSwh1tnTIh896LtdFYIDWOSaHOc7Ft2+tRA6mq/XXQ3z6ZNjahO4KLsWnkX0mQC8Ja5I91E3m6ggu90ANKgQyfk1AaM4htrqWqqZwzQBcT01avRlVfn9IKzf24RfeFKjpPIS/ZdZc2b69C4Rr3ctLcMPE4cJoUHPCT5h11m5UrL/lhCQLQHIP5+3nRXQ1+n+6uo1QR2bY/oXZoSoGXSriHuiGYdZ0EWKQxx5Li3ot8lb7TgPQ8w==
Received: from BYAPR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:e0::24)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 23:51:13 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::71) by BYAPR05CA0083.outlook.office365.com
 (2603:10b6:a03:e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 23:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:51:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:51:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:51:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:51:04 -0700
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
Subject: [PATCH v5 13/13] iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
Date: Fri, 25 Oct 2024 16:50:42 -0700
Message-ID: <ff85d234ccbe4e86640d9dad711ebc5602f0804a.1729897278.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897278.git.nicolinc@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ed0ed8-0ff2-4cdc-851d-08dcf54fe8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?As/6TN2aEMi2wxWHJ1a/Pbx7Z/i65/e1BXV9DN1ebpy/glTOth65hm9pdM+r?=
 =?us-ascii?Q?/n9x4xcfD2Ge8LNuJKi7/WpxNH3du6qQuh1eNwovNiM+nPQqVtEnm/bK6+HB?=
 =?us-ascii?Q?XKF1UnarIfcAdDWUms2XCNRep1LyYEBoPiNNl2oAhV2uzE3vtiRuz4JiHeot?=
 =?us-ascii?Q?eFgswfFZI9VJQ9FPIl1IZPXkzFJ/MSiEhBzCIM4Kn2aJqYtpdYtfZMA7lIlE?=
 =?us-ascii?Q?1FzGnGC802P2GuLenljazvhv8mIb1ZhpXjv8YqxOh0z2TgrDkuRpSwmsTpku?=
 =?us-ascii?Q?9edg8nLas3AYfW7gVzVylpJ7Xs7JG9fzY466BcG9w0qsoBNGZOHIxgP0/CDZ?=
 =?us-ascii?Q?R/ZIxUjH0aHerMVG3enGpcD8wZaW+VhuIL0TV7es40xlt7g34PisOJpz1Hbd?=
 =?us-ascii?Q?J79JfArUoySJpnIgp6BPPY04qRhB9G/LwdlVqkApuFB+op+5fDEd94sy37ZT?=
 =?us-ascii?Q?2AkBd5RD/uNxqkE7IQRZlk1Tk8KmHwVWv1uFbD1yF7x89T0PSdIRL2yEaVki?=
 =?us-ascii?Q?rsq7hGZpdTIZHjrzGhRiFae5kaTi5hn1HEG/ZCpyDl5iHnZsfFymgHRPf6/p?=
 =?us-ascii?Q?QT1GqVEaFHCbGtnV65rMytek6EKEn1yFJvabOZs/Il5cUshGRL16tibeM/Nr?=
 =?us-ascii?Q?0c+0r2r/kgPYEq5wneOu5Z/4uDdoHtWbFr8T31zFTX43Sp4CxLnLwAkgQKI4?=
 =?us-ascii?Q?Eb+wat1uOGplGNUZdIYZrwPgei5LRwLPus28JfzMWVuUSY0DW+nmdLTYn2R8?=
 =?us-ascii?Q?9Avh7lJS8gs35WgxE4PR6a3Xo26oURlRPzGrDKCAqzeocq1E8FaOIxf31D5P?=
 =?us-ascii?Q?LA/MIpJe8UVHWlcDZXNvwxNKH4iyoRxq2ISGeiVhSgNaTdQgdZU7FKZIColf?=
 =?us-ascii?Q?bwbNId2QPWrJ6Rsfke15tQLlabTCYHrwmn22M+WDQlR2gCs6jeSHgJF3vxpt?=
 =?us-ascii?Q?V0TY3xLtTqR+K+uSQySlftqCdiskRipPXfKeioihU9h3mptDU7hKnT41u7e3?=
 =?us-ascii?Q?neaxd8/MbuMoj5ZvkseYhBdDiJMUXED8ls1xbdwsmAVQjnZhmZJCiC55t9vi?=
 =?us-ascii?Q?VhwRpnMKHN92p/lTAyz4KpkP8WPuNro6oQIj7IOR5YMCWPh9CK0K6oYejSPv?=
 =?us-ascii?Q?dabDwfjmA77Pp4W5p98NwGMhGBX0EY4GcbH6YnBWWk7Zz7upMkr+7gkiapgG?=
 =?us-ascii?Q?cc2dl2ywsN9u/T87gfyeofn1NbhdDNhKLsW+vWMoqrONWR8qh4f5kIVoPVeu?=
 =?us-ascii?Q?vuXMrNy5w40ACjHvir4W4/6BXBd0P5xQh9DOTpbNkznXmprJH8Y5VRd3+kUb?=
 =?us-ascii?Q?9+Fo287wpT4hvHaOSwSzStHLwsJC2k8dB34VFUh/IT5z8NEyA4d665rDCCjT?=
 =?us-ascii?Q?UdxpBjJhQEzBVOARuDEBZnr8k/SPKGDhtNKX05JOIockThjg1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:51:13.7533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ed0ed8-0ff2-4cdc-851d-08dcf54fe8db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

From: Jason Gunthorpe <jgg@nvidia.com>

Now, ATC invalidation can be done with the vIOMMU invalidation op. A guest
owned IOMMU_DOMAIN_NESTED can do an ATS too. Allow it to pass in the EATS
field via the vSTE words.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++-
 include/uapi/linux/iommufd.h                  |  2 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 31 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 26 +++++++++++++---
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8bd740f537ee..af25f092303f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -305,7 +305,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_NESTING_ALLOWED                            \
 	cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |   \
 		    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |   \
-		    STRTAB_STE_1_S1STALLD)
+		    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_EATS)
 
 /*
  * Context descriptors.
@@ -838,6 +838,7 @@ struct arm_smmu_domain {
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
 	struct arm_vsmmu *vsmmu;
+	bool enable_ats : 1;
 
 	__le64 ste[2];
 };
@@ -879,6 +880,7 @@ struct arm_smmu_master_domain {
 	struct list_head devices_elm;
 	struct arm_smmu_master *master;
 	ioasid_t ssid;
+	bool nested_ats_flush : 1;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 8e66e2fde1dd..056ba05a8022 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -404,7 +404,7 @@ struct iommu_hwpt_vtd_s1 {
  *       a user stage-1 Context Descriptor Table. Must be little-endian.
  *       Allowed fields: (Refer to "5.2 Stream Table Entry" in SMMUv3 HW Spec)
  *       - word-0: V, Cfg, S1Fmt, S1ContextPtr, S1CDMax
- *       - word-1: S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
+ *       - word-1: EATS, S1DSS, S1CIR, S1COR, S1CSH, S1STALLD
  *
  * -EIO will be returned if @ste is not legal or contains any non-allowed field.
  * Cfg can be used to select a S1, Bypass or Abort configuration. A Bypass
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2479074db820..c0c5cd807d34 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -96,8 +96,6 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.master = master,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
-		/* Currently invalidation of ATC is not supported */
-		.disable_ats = true,
 	};
 	struct arm_smmu_ste ste;
 	int ret;
@@ -108,6 +106,15 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		return -EBUSY;
 
 	mutex_lock(&arm_smmu_asid_lock);
+	/*
+	 * The VM has to control the actual ATS state at the PCI device because
+	 * we forward the invalidations directly from the VM. If the VM doesn't
+	 * think ATS is on it will not generate ATC flushes and the ATC will
+	 * become incoherent. Since we can't access the actual virtual PCI ATS
+	 * config bit here base this off the EATS value in the STE. If the EATS
+	 * is set then the VM must generate ATC flushes.
+	 */
+	state.disable_ats = !nested_domain->enable_ats;
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -132,8 +139,10 @@ static const struct iommu_domain_ops arm_smmu_nested_ops = {
 	.free = arm_smmu_domain_nested_free,
 };
 
-static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
+static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg,
+				  bool *enable_ats)
 {
+	unsigned int eats;
 	unsigned int cfg;
 
 	if (!(arg->ste[0] & cpu_to_le64(STRTAB_STE_0_V))) {
@@ -150,6 +159,18 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
 	if (cfg != STRTAB_STE_0_CFG_ABORT && cfg != STRTAB_STE_0_CFG_BYPASS &&
 	    cfg != STRTAB_STE_0_CFG_S1_TRANS)
 		return -EIO;
+
+	/*
+	 * Only Full ATS or ATS UR is supported
+	 * The EATS field will be set by arm_smmu_make_nested_domain_ste()
+	 */
+	eats = FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(arg->ste[1]));
+	arg->ste[1] &= ~cpu_to_le64(STRTAB_STE_1_EATS);
+	if (eats != STRTAB_STE_1_EATS_ABT && eats != STRTAB_STE_1_EATS_TRANS)
+		return -EIO;
+
+	if (cfg == STRTAB_STE_0_CFG_S1_TRANS)
+		*enable_ats = (eats == STRTAB_STE_1_EATS_TRANS);
 	return 0;
 }
 
@@ -160,6 +181,7 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu,
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_nested_domain *nested_domain;
 	struct iommu_hwpt_arm_smmuv3 arg;
+	bool enable_ats = false;
 	int ret;
 
 	ret = iommu_copy_struct_from_user(&arg, user_data,
@@ -167,7 +189,7 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = arm_smmu_validate_vste(&arg);
+	ret = arm_smmu_validate_vste(&arg, &enable_ats);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -177,6 +199,7 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu,
 
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
+	nested_domain->enable_ats = enable_ats;
 	nested_domain->vsmmu = vsmmu;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d1abfb42d828..10b4dbc8d027 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2107,7 +2107,16 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 		if (!master->ats_enabled)
 			continue;
 
-		arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size, &cmd);
+		if (master_domain->nested_ats_flush) {
+			/*
+			 * If a S2 used as a nesting parent is changed we have
+			 * no option but to completely flush the ATC.
+			 */
+			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
+		} else {
+			arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size,
+						&cmd);
+		}
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
@@ -2631,7 +2640,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static struct arm_smmu_master_domain *
 arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 			    struct arm_smmu_master *master,
-			    ioasid_t ssid)
+			    ioasid_t ssid, bool nested_ats_flush)
 {
 	struct arm_smmu_master_domain *master_domain;
 
@@ -2640,7 +2649,8 @@ arm_smmu_find_master_domain(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master_domain, &smmu_domain->devices,
 			    devices_elm) {
 		if (master_domain->master == master &&
-		    master_domain->ssid == ssid)
+		    master_domain->ssid == ssid &&
+		    master_domain->nested_ats_flush == nested_ats_flush)
 			return master_domain;
 	}
 	return NULL;
@@ -2671,13 +2681,18 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
 	struct arm_smmu_master_domain *master_domain;
+	bool nested_ats_flush = false;
 	unsigned long flags;
 
 	if (!smmu_domain)
 		return;
 
+	if (domain->type == IOMMU_DOMAIN_NESTED)
+		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
+
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid);
+	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
+						    nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
 		kfree(master_domain);
@@ -2744,6 +2759,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			return -ENOMEM;
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
+		if (new_domain->type == IOMMU_DOMAIN_NESTED)
+			master_domain->nested_ats_flush =
+				to_smmu_nested_domain(new_domain)->enable_ats;
 
 		/*
 		 * During prepare we want the current smmu_domain and new
-- 
2.43.0


