Return-Path: <linux-kselftest+bounces-19982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969B9A28CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687F128ABEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA81DF26F;
	Thu, 17 Oct 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqCwpGuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E211DF269;
	Thu, 17 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182537; cv=fail; b=ICNYuKvhE68/O758UShC2Q1ulYvF9/Il4gIoi+qzYjF1DHWaB6yc8Zo6AJij+0biVA8I6eq3MXO6V9TmMLamkLOipbxddrqQqdwiud8HMT+8NIsG4p6sfJ1zvdpLW6wV9DnwPqRiVoMMgzbZIxpVoPq/JvY0jaJwPfXlmkWfsBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182537; c=relaxed/simple;
	bh=/b/fgjyJFh+BQ9dN3+8yewOf8QHPaUvpcBb43UV7Psk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlZMS7RSUnTGjY/p2S9iRy3lefr6rPXt8ABoREB5dcS0MN7HxxanBzivhZ7r5yHvFOngYRd+eyYCbMhASGcIJUKiqx3Bt+b9HtvQCwIfI6vuLgSGnACDFiHCNamzr4DVrEtlaRRjawXKSTxL27ytRe61S8tbE5VTjSxsBDpeQ34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tqCwpGuT; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo0IKJWgwoQUmdnQwhtwP/j6d5hDKtJpDIvbdFNCbQhp6hCdncXmwIIxtGgusfEn7YBeQMeTKFxbneNOHuOaVvg1Wnua+ix8fuY+T4KX+Q0HLkizBiWCI8HX/Kochk9zAPf1qQPdDK9J2BeY+FC3xFg/SvvkYNFLtr8BR3GiISgVcO9fV9oi+KO8hP6j1EF/aAJt63K6L7jOmQrAakHJ2MAlPgab40sjArx+Dtw6YdbFW6zKt8urJHq4wDPvUCyfufa8JNZOjoyn0mwHeB4/o4i5LPFFWyjtRL/3hCcyTDlH8dqZD+hs9g5t77H70IpNYmjSBF8SCtHNnzvPESwqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7q2fblI94BYYI3t7uT/LZ9sSmdMTs0ObdEeNxR1tr0=;
 b=uGX/ITZ/oqq8qyn640RjqH8X9sSWjdL8bmijkd5UH0uYtuu3AzhwvjUAc4993TDgd2izW0rqu2dN+DnpZfeGoZ3JL8HnlEnQrPSf+9SWAEMHG2tSk91xw3QnQvnt28VEO/0E4jNHSD/1svQ/rMklepguA6S9F7axxjYSuqNw32q5boBob4AijL6OcVPhPvLij0MsTXtuqO4I76mkEGlbCpKB3cs8/IofQjLrM+cgmAFyb2ZtAqLO0KbG4Z0nISVxuGaDBCUQDbwM+ADs8F8sk6LyvereRCvf8SQgIa9C8a5fZbiZjDEMd2mBDaPkTtGJTO0ZPitlVx7DAx0xsu9EvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7q2fblI94BYYI3t7uT/LZ9sSmdMTs0ObdEeNxR1tr0=;
 b=tqCwpGuTmU2YS/7zDEdVGaSCKTE4a+J5sqJ1d2wSR0tXqjpz6L5eKooKnA+vTvolSkYGNQvsT+3KuU++gM3rGR/PhH2o+oNjx4tXz3cSGEgpfNX2JAk1AlCOsaR8lgJnSaVvkp9qWqy0D4koEnz2lqTWFJnMc3CVUZ7M8JBl60gig5oOC3BTxbtO1z9/ZQfLzunTpcAg37NRrfPg3mmiEEEvVsMMxwoyIzWmMalggQcoy1ZK+Uhy9mEDV2T/S3VvPTBsfZH5P50Hb49gHo7NF3W8TGsVi6b86qZEtkQv6lBH0acZOVesm2j3q2jlckC5krWOcsnnEUk59Q60mhjWmg==
Received: from BL0PR0102CA0029.prod.exchangelabs.com (2603:10b6:207:18::42) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 16:28:44 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::9) by BL0PR0102CA0029.outlook.office365.com
 (2603:10b6:207:18::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:28:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 09:28:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 09:28:19 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Oct 2024 09:28:18 -0700
Date: Thu, 17 Oct 2024 09:28:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <ZxE7ILug+SL5eMsl@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b09ee74-6c79-46a9-737f-08dceec8c4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eAVN5Q00pg0qJCJipS/Cofo8KgkaKT+NsYjjmLvBBwZFgPhe1bUeIF9Fo7N0?=
 =?us-ascii?Q?7eRHgrDVoXdT78VSIwLmdcuSAJRP3gmZkj3CTrTDJq53DxwWAe+c1Agm5qBd?=
 =?us-ascii?Q?v+qFkQ2jh7JgWcETm/xBlNRTB7OYRRF8QTkXlZFTahYHWUxgKIsIYcy9gK0i?=
 =?us-ascii?Q?XmlG2DOcrz6nEq+Z/YGL4hSie2X0YT8q3OzyNRKVHuSZbzeXEgAuY0iTzzPP?=
 =?us-ascii?Q?FQmASfYF9ECfkY30cWL076jD+ZFK/bozaer00u8Hp+H6APR7JQXgUgNSILdG?=
 =?us-ascii?Q?BRWX6T5n9lwW5EG7Q/EgwF9xwUjFr49K9o/kRvx06nffrzagGuLE57O0P4lL?=
 =?us-ascii?Q?nNuRpahHuu5J9IUeiwqA2mFn4LXBRbD6CT0jxYuo3jNWB9xGXWT5lW24phdk?=
 =?us-ascii?Q?K5gawFmYNU85P276I/Ms1S1x5apHQNfOQAi/BbiO/AeyEbrPrO1NWKdbWUir?=
 =?us-ascii?Q?qFK4VjnpJJXjdKC00otMY07zQZxmBg8V6xF6vpgnAajh3/FJKneCN116zlQw?=
 =?us-ascii?Q?HsW3OAjY65QV6TwJ3l1imGCF4Rl4dXNRn08tUJyb3z7Lckf8XSznPN9ae88P?=
 =?us-ascii?Q?sUcqVMtziGtOzwovOY++IBLQcQ91H7FspTRpw8gbQmv2xL8KpudD/dSuE678?=
 =?us-ascii?Q?H/A1z0oxAfOIiRh6zZVZF51Tkv361Bk/MltvvY4yQv6/jclm0Ije7rx5NfuY?=
 =?us-ascii?Q?HrY0+HYCNGZcEQ/9YrjiA2P1QJz59+sRURpOg33m8PunPeKwmaErg8Wx8Uwy?=
 =?us-ascii?Q?NIhn8AJVi4a7YW4sZ/Djeihve9kVp1A465P/ln66Anud4CNydlbmHIhJVUD2?=
 =?us-ascii?Q?pcCMax3pXp+K1lwBtCInts5se5YOOon3qm2Sz8/TEE9S84eQOR3l5HG+SW94?=
 =?us-ascii?Q?47+6KUbMzGReAMKYCsNM6QKxfeY21wcRBK1n/n5HHm5XmEFUWhWHuBnqVSXV?=
 =?us-ascii?Q?W03Bndt4VKI5E2U7Ez5Wld5Pg30dLzIjCDZQ8ABPJj1F+WASsxtvzQK8SksT?=
 =?us-ascii?Q?ywkNduD0GOWDMsG0EOyGhu0Xt6YoYlhuckkUzaHZYks1Lo7SOeetrJs2Xdoq?=
 =?us-ascii?Q?NC01gYClN2x7NK8gDebRbspTf4wgdx0BljSviwBV7zOjBHeLSB3GrSRnpeXD?=
 =?us-ascii?Q?xO0yMgJI3cy4Wrm6u3rG/BY2cjqmzmzmVC1jpKBTMIykiGRsDBXj2SU4QcR+?=
 =?us-ascii?Q?IBRLuGAV7Zg+JJIqYmPBDCPcc9fkNNg8aVGl3fRiWpxulT2xgSswlnDFLBV1?=
 =?us-ascii?Q?ywZOhY5VB3XYD7cupUIT2FR9Ru3+cKSiwsqd7jiiuubtHz+G1oXO8BN2h//O?=
 =?us-ascii?Q?vNjZ2V+Ur5MGHH4SbvBItrp+dqmUw8KdXES4DFdnj9PRs0WaSoNZuvZR/Qhb?=
 =?us-ascii?Q?92QZk7eiLLWpQteG4lRUBpMgnfJGbP7H4SbK7nRpD1PgPZKWYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:28:44.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b09ee74-6c79-46a9-737f-08dceec8c4fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> the viommu_alloc op with an arm_vsmmu_alloc function. As an initial step,
> copy the VMID from s2_parent. A later cleanup series is required to move
> the VMID allocation out of the stage-2 domain allocation routine to this.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++++++++++++
>  include/uapi/linux/iommufd.h                  |  2 ++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 +
>  4 files changed, 45 insertions(+)

I squashed the following changes to this commit (will be in v4).
It replaces nested_domain->s2_parent with nested_domain->vsmmu:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 5e235fca8f13..3cd8ad0a8980 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -36,14 +36,15 @@ arm_smmu_get_msi_mapping_domain(struct iommu_domain *domain)
 	struct arm_smmu_nested_domain *nested_domain =
 		container_of(domain, struct arm_smmu_nested_domain, domain);
 
-	return &nested_domain->s2_parent->domain;
+	return &nested_domain->vsmmu->s2_parent->domain;
 }
 
 static void arm_smmu_make_nested_cd_table_ste(
 	struct arm_smmu_ste *target, struct arm_smmu_master *master,
 	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
 {
-	arm_smmu_make_s2_domain_ste(target, master, nested_domain->s2_parent,
+	arm_smmu_make_s2_domain_ste(target, master,
+				    nested_domain->vsmmu->s2_parent,
 				    ats_enabled);
 
 	target->data[0] = cpu_to_le64(STRTAB_STE_0_V |
@@ -84,7 +85,8 @@ static void arm_smmu_make_nested_domain_ste(
 		break;
 	case STRTAB_STE_0_CFG_BYPASS:
 		arm_smmu_make_s2_domain_ste(
-			target, master, nested_domain->s2_parent, ats_enabled);
+			target, master, nested_domain->vsmmu->s2_parent,
+			ats_enabled);
 		break;
 	case STRTAB_STE_0_CFG_ABORT:
 	default:
@@ -109,7 +111,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	struct arm_smmu_ste ste;
 	int ret;
 
-	if (nested_domain->s2_parent->smmu != master->smmu)
+	if (nested_domain->vsmmu->smmu != master->smmu)
 		return -EINVAL;
 	if (arm_smmu_ssids_in_use(&master->cd_table))
 		return -EBUSY;
@@ -164,8 +166,10 @@ static int arm_smmu_validate_vste(struct iommu_hwpt_arm_smmuv3 *arg)
 struct iommu_domain *
 arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_nested_domain *nested_domain;
 	struct arm_smmu_domain *smmu_parent;
@@ -183,6 +187,10 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 	    !(master->smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* Driver only supports nesting with the vIOMMU infrastructure */
+	if (!viommu)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * The core code checks that parent was created with
 	 * IOMMU_HWPT_ALLOC_NEST_PARENT
@@ -206,7 +214,7 @@ arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 
 	nested_domain->domain.type = IOMMU_DOMAIN_NESTED;
 	nested_domain->domain.ops = &arm_smmu_nested_ops;
-	nested_domain->s2_parent = smmu_parent;
+	nested_domain->vsmmu = vsmmu;
 	nested_domain->ste[0] = arg.ste[0];
 	nested_domain->ste[1] = arg.ste[1] & ~cpu_to_le64(STRTAB_STE_1_EATS);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a23e6dcd5cf..460d2fe5dd49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2660,7 +2661,7 @@ to_smmu_domain_devices(struct iommu_domain *domain)
 	    domain->type == IOMMU_DOMAIN_SVA)
 		return to_smmu_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_NESTED)
-		return to_smmu_nested_domain(domain)->s2_parent;
+		return to_smmu_nested_domain(domain)->vsmmu->s2_parent;
 	return NULL;
 }
 
@@ -3128,7 +3129,7 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 
 	if (parent)
 		return arm_smmu_domain_alloc_nesting(dev, flags, parent,
-						     user_data);
+						     viommu, user_data);
 
 	if (flags & ~PAGING_FLAGS)
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 844d1dfdea55..0ea1afe1bb7a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -836,7 +836,7 @@ struct arm_smmu_domain {
 
 struct arm_smmu_nested_domain {
 	struct iommu_domain domain;
-	struct arm_smmu_domain *s2_parent;
+	struct arm_vsmmu *vsmmu;
 
 	__le64 ste[2];
 };
@@ -1018,6 +1018,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
 struct iommu_domain *
 arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data);
 struct iommufd_viommu *
 arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
@@ -1027,6 +1028,7 @@ arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
 static inline struct iommu_domain *
 arm_smmu_domain_alloc_nesting(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
+			      struct iommufd_viommu *viommu,
 			      const struct iommu_user_data *user_data)
 {
 	return ERR_PTR(-EOPNOTSUPP);

