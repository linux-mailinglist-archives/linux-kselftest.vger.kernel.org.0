Return-Path: <linux-kselftest+bounces-33102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E50AB8DD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41B9171731
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2CA2580D0;
	Thu, 15 May 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Puap+MfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853C198A08;
	Thu, 15 May 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330383; cv=fail; b=qwHn2/2rA0tq5Sb/PA43+BLOWclFc5ofcflt7U+aBF5c7Puvx4L4brreyCFrMCrJO2ghDip8ah/RnwEqIcVhGyXkOsVyOl473MN0cXVbwPt31xY46s2vti2ljYh77vb+7D5nKLBETgraWmixpiZFRDcx1ulOG/W29ttYyBUThgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330383; c=relaxed/simple;
	bh=BCVhNRSOFcsgv2RywLOopxKLDS6OI9xSck8R+ThDvIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6AFv7a6Snj54+elo7ZUjr0idKMuRAgw1VWzsrdIH1zkREbsqbtDajq0mu/3GadiMby9bj47rHkW9hQlNV4/db7bX1o+EH/UqyBJ2WKqZ1kG44vuq4F40RkCNxqXM96eThEuNgeb2A0zpU7eHB4HAg9fMoSEUcbNW57lJQmv6Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Puap+MfH; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyFNfkOzVBpqr8CVbIVhVYIvQOnRYrbWji9e9TSHZgVB2xiIh6FDBAmmn0LICKrWWruc2fiWk19y0wWbLUk4HYuLL7PRKsVvzjSu1VZGAbPBAKL+SArI98GJzsSwap/5OZyVemf3f9FsaWM1otlOnwJRGU0psvhLGbwzCw4z5e5Ecfv9k7m3LJ/jTOqug/NbytTCFBl1EtI1UEuzkY2rRkjP+Jph7YMTiZMtuSA1vCzuw7vzMoXrohM5K6+T+aRHME90BeGIwkX+ZrvH+eCm3RkAMoRZliKa2GI+rvL/rpV4nz8Ple5IleJRitoY/wXkD67THuz0HVKPcT0l1YWHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcCJT2n+NdwluftUBOxmhv2A5eFeAUiAZd/40z5yTxA=;
 b=AphaknoYN0lbE2NDjuIMrxzuJ5YvbdqfzxTJMLisOScEo01d07kj429aOoRm6Ik8ZeVzU9EH83b1etbTJZ+qQEEaXewegnZ5P643E4eZwTnraUjPcCCw2icpifcI9Iq29e3kNDo+OZ5C3d0/bUijAS+eiUvvxT/x0xziaapLxuYchZV2J0SEV0IydkmSkfk/dMwYMV+751y/2h1nT2sVvoqR90l/BWraU3IL1+hwGk/EIhUgpQDupkCa7bwxFPE+8lczEGCTSonzlrfRLJxC57BW0jCk2O70cZT1NWQaEGk0JDKEFG+r51k9fsaqmfD8bKHIqf2lA0Wt+b1wq0jAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcCJT2n+NdwluftUBOxmhv2A5eFeAUiAZd/40z5yTxA=;
 b=Puap+MfHJcvzHX5pT6SLUmPv/JBzk7nxbmKBtny0tF/VOJuQUOsXwclqo7vPsfrt3vHhgmZI1eL6esBNEbP+cOvxxr4tj3ixER4nfGzo+prtxcOKlA+n4DSc5Vd3zWAFrOOqrmMvI7Xo/ZVedDgDdXevLD+ZX3bVm/E/B5uFR/c8Dup3pCC+JJC1gkgcYnIFtraYvQf1TOsX/Lk2g8VSyg4ytOEZcEvCDzarQb47Mm+4KR4Ms/3XR+PWFsaHA3lhQ8cIqTU5NS0Ls/VmrZAPIRR+E/XM5aPqu47QJ4QtpHC8owQITiYqzsd7/uj/UIhdgzIJs9a/VUzeGhFy0YkYEw==
Received: from BL1PR13CA0395.namprd13.prod.outlook.com (2603:10b6:208:2c2::10)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 17:32:58 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::7b) by BL1PR13CA0395.outlook.office365.com
 (2603:10b6:208:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Thu,
 15 May 2025 17:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 17:32:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 10:32:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 10:32:40 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 10:32:38 -0700
Date: Thu, 15 May 2025 10:32:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v4 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl
 op
Message-ID: <aCYlNROYiTFv0XCk@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
 <20250515171902.GO382960@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250515171902.GO382960@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f197e89-f440-489a-b16f-08dd93d688c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEyHQZMq8gnssFhVGGp44Hv8sLVPum2X1mDSPa6jCa4VRTFFwiB+kvKQi4vx?=
 =?us-ascii?Q?1IwOEIAzgC5jH7z3dl0T8R9b1al0BbFjUmO4goaAmPuWt09desgfV6vPfART?=
 =?us-ascii?Q?S7htricjxjJLf7wQkKShn7zoaFkpLF09ggcbjacGVS82UHh9fSi3/2v8uMdJ?=
 =?us-ascii?Q?XsfjLWz44NbFI1pEKvA4EqoaZaaOScx+5kqKsxG+KC0qzd0zINwYLfb+uw0K?=
 =?us-ascii?Q?s1HqJ4pWTLXoLpgxNxdjfs4CJ/twJz/c1xSY2BBFk80wY99atB/6QOwOY/9k?=
 =?us-ascii?Q?kXfmveDzgJzZS7KlTCv54l9NYw3j4uk10vx8Y6wusEQRg/K4ZmP4agO9i3vG?=
 =?us-ascii?Q?lfVpSXMx+gEGyHRxtgdkryonhiSElLLGVF2mhth7sJvve+BInUCZ66N/F9s7?=
 =?us-ascii?Q?gq91w5fV1m46pCl+hoEcDFmQtSD8JtE9Tg6sUwC+0/MaM+ZhfkKZQQQzjIg+?=
 =?us-ascii?Q?4ntVHa3fv2K2jZ5MX2tDOH+4xjEDqdtJSEzBMvtrKsBQtyzEXN/SOcfINleH?=
 =?us-ascii?Q?6JpV+bgIAMIP1AsSfm5CM18cnOb1shS0LdxlsgnWMDpZ09BGl7J8mJaaq5jJ?=
 =?us-ascii?Q?X0KJQZTJ+DKnRU6BCpaYVXi3oWMPpsoMFWUlBgUNdYGNuAio4AYrflsDd47U?=
 =?us-ascii?Q?mEPAxcC8clQRDEt2jj633THhAWm52YnN3oEuVbsMKnrx/aayjgr20ojnYxwm?=
 =?us-ascii?Q?fBmw0uqDgsa3iqPW6Fvy7I9pyfKlwbR/mfvyOpoSabEaUTc9dit+FEdDcfoI?=
 =?us-ascii?Q?+M0f/dFXD4CKu4afPEflAed5Clz50h7M/0DpEiGxGsZTG933RwQqRBSGKB65?=
 =?us-ascii?Q?C2gaf2mnK2XMXf41GmMM3aXpMxxuNp/H6mzjQaLFt99K/SOg6Mk3TxqOXtDA?=
 =?us-ascii?Q?sQ4fHetSv4dBujb4hCTD+Dx2JsgMhl74NtYUBRezZLRg4wRq6p/3NkguX/jk?=
 =?us-ascii?Q?jlFEagnKzmUke1vf0+N4spuf48d+LpXkNuuE4ie7dtsAq9v5fznV+7lwM8NM?=
 =?us-ascii?Q?+sbxiNqwLGiNS5fUTL1EGOR3GmFgFucbzHiZ2tJkRCizZePhHtEkoIYGHrTW?=
 =?us-ascii?Q?TosCoMm1R4eDW1bCkzARH8e4rC5hlbEoBIdmx0TfMYC8omyx12xkrkFLlE6u?=
 =?us-ascii?Q?Hp2VLqpjSmP2h8/71jMhkM6tvb2FtWp3YuJBC3c1zkp30Pds5kv7JN7NOXuW?=
 =?us-ascii?Q?J/l6+aRg75JQiUE++xG3EDJIQ8BpMhDuLa2ARVUh9sfaNcPtJfvYRhkG6ffz?=
 =?us-ascii?Q?vDLsOq4LOgdTBv5qVhRdUU+poAwBGHyGQd5uUjfLD5MSXcC/FbEi/HrbTdOF?=
 =?us-ascii?Q?gtIjR66ZbQElGvy1ikNUL9e9uxp9nRKsX4xLWpvvoVTQrXY++krwveSnAvjg?=
 =?us-ascii?Q?q6kmW0uhhr9TJ9iR6RJVRWGJgHqyJvzjcssDdNbwBaWGRpAV5r/YSEQ9hlg1?=
 =?us-ascii?Q?BaeqC81+AC1CDG2nX1NwR+jYMtbLLVzi0fCsiJi2k1fYPUFIP8wq2hWJRdD/?=
 =?us-ascii?Q?MJZw8PfwQpQEsfHU0Nxmw4GxY4RmZAxPOgjB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:32:58.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f197e89-f440-489a-b16f-08dd93d688c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

On Thu, May 15, 2025 at 02:19:02PM -0300, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:38PM -0700, Nicolin Chen wrote:
> > An impl driver might want to allocate its own type of vIOMMU object or the
> > standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
> > the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
> > 
> > Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  6 ++++++
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 17 +++++++++++------
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 6b8f0d20dac3..a5835af72417 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/sizes.h>
> >  
> >  struct arm_smmu_device;
> > +struct arm_smmu_domain;
> >  
> >  /* MMIO registers */
> >  #define ARM_SMMU_IDR0			0x0
> > @@ -720,6 +721,11 @@ struct arm_smmu_impl_ops {
> >  	int (*init_structures)(struct arm_smmu_device *smmu);
> >  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
> >  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> > +	struct arm_vsmmu *(*vsmmu_alloc)(
> > +		struct arm_smmu_device *smmu,
> > +		struct arm_smmu_domain *smmu_domain, struct iommufd_ctx *ictx,
> > +		unsigned int viommu_type,
> > +		const struct iommu_user_data *user_data);
> >  };
> 
> I think you should put the supported viommu type here in the ops
> struct and match it here:

OK. A single type per impl might be enough for now, so it can
be a static one.

> > +	/* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
> > +	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> > +		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> > +			master->smmu, s2_parent, ictx, viommu_type, user_data);
> 
> instead of the EOPNOTSUPP dance. Either the impl_ops supports the
> requested viommu as an extension or we are running in the normal mode?

I think we can only do normal mode if requested viommu is the
normal SMMUV3 type, i.e. still need to reject a type other than
!CMDQV nor !SMMUV3, right?

> Is there a reason to allocate a different viommu if the userspace does
> not enable the implementation specific features?

Hmm, what is this different viommu?

If VMM doesn't want VCMDQ, it should go with the normal SMMUV3
type.

Thanks
Nicolin

