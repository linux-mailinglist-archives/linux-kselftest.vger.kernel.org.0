Return-Path: <linux-kselftest+bounces-27390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7EA42F30
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 22:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7CF18929FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88F1FFC44;
	Mon, 24 Feb 2025 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1ES2uCo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCB1DF993;
	Mon, 24 Feb 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432705; cv=fail; b=E2ewqwPM3XJMdellXx326LRSc4bpBqFEvH9AlkRX80pUMLei670DRzMvMfaZmYrksFUQng4WPvI+jphpxZxmMkKyl7uiqkurM20o589eC5vyvuYKv37vcUrW1G61RkSJWs7RINKKl+vNFAvUtvFRbjWPXyAPZVCFOFd05RbIeMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432705; c=relaxed/simple;
	bh=xm9CqLOxqDMtLAq9jomPyNricHkeUtd0aDxyZvmdhFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY4+hwf8Tsxr59y+FLnfTm5Y6SwT33ffsZUHjROT96mfXgcZqfr80g/qT7diuDgxcxfFy5oCSjKixJMLlCQWkMeZEgYbfp/W5kVB4/mVbfsptBRvbsy7R/r+F25QxC6zTZrRnGL9H4OFQFPPeBzU76JFuHImmrbXu/Kvlb3Io0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1ES2uCo; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXCrrYCRXRBXL/2ho1JBXYSaqO8wEz2aTaZ+tYFKrBNPnsYZFE3YUWAcoWhZxThadF84UbfHhOMD0n+9ahTVJy3krzn+nl80NKfJYQsWEtXcMb/BH1V9Ory28Vc7kCcK0uFWkrralJ4fSZy7ATiYgtNsJcU1Cy1nQnvbeZfpW7Gt7BwQjti/l3cXAVyL0o+ZQ5QjtylYh0xavncO5v51DE37Y9NKiz32LikBdRJZDkIL2OWIbnkI36QjXPnIGhk8mxT1L98YJ5aTCJdwkL8/k14Ioibt6mR7hN3iop4KxqaIyA9HrHon6uVH2keB/Ir7HSs2M1r0naLHrnCxTNvpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6ZrUb22burVSUKNy57tvHG3cx695UgynvFf7erlMfA=;
 b=gK1N9+zs4MaH1+eIGIUgv/L8Bs+x5ItVhLKwSJG039cLunuKngJXKk2JWy0EBIz+wdoCsItfKxuY9WIwt1u4IHmLHhD+M+OsFrThrwWlkDcPX8ieIr/j3VVOB1luOrm4+v59OSPQI/VDmiSeUWNusB7kbCjAQR9ZQR9ftumyMecJ+sBH79LCNZDiHq1lwk+6uLcbXTHfgL2dFT3Gi5wjeeGMWgn5fzs5YNTv0/lJReRQewC+67hYgDH/hbwv53rv+kwBKRPqqsfpw5ri4lj5hy+baF+Yurb/lZDffSpDa7O6icM1LJqB/Otxldg8jf/Mz48NLKHgOqdp3n+P7ywNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6ZrUb22burVSUKNy57tvHG3cx695UgynvFf7erlMfA=;
 b=X1ES2uCokVdBBw1BF0jK7sMo9H9AAG5qy7DD+UqHp7zwNsRUeeyXgR7T2vDDQV0fpXz4GQuJ1i4AYGxp139CaRjIYvlskbkjNDEodz7f578YIBqzJvCYtX41Lp5H4hFzPXLkOblvHJNb63n5M4fZBc46qRnTKAwGUeMl5v7ofCrucsTB2IzCO3wVt5wf59hpcsOqT7hBoHC8VSKIeIocoPnUpTOhPQbDUOCb9tnUES/hg+MEtdx8OykRC05cAjSeGjS+9HC5yEXpu7Xo0kHHWEXozNkffQPXhH/tGmy3JMmsdANl/3R297qgHSNr4qQ3cUphHZvgUrFM+1fzjnlqXA==
Received: from MN2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:208:134::28)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 21:31:30 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::2f) by MN2PR16CA0015.outlook.office365.com
 (2603:10b6:208:134::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 21:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 21:31:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 13:31:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 13:31:13 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Feb 2025 13:31:12 -0800
Date: Mon, 24 Feb 2025 13:31:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7zYLBLZGKim-5UL@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e6464b-7925-41d5-dd63-08dd551a9a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NMM33Cb1mljFXv85AhXR/JU9o7eHy3+8+mxC8L48gBHyfln1AKy+6pH+2HAf?=
 =?us-ascii?Q?ggwQQOOTqRYTr+zE8wkUObDJaAPhdlggd3HHMiYgNF29tVqJIfI6ZnvB2CJF?=
 =?us-ascii?Q?SA2OHz46K7zfNn2W3WOjECfgpO3HbZqacs+atd/Q7FlVL1BzYgzDeryBFDJ3?=
 =?us-ascii?Q?FbbocTP5aVhXgqeOVwQkgFIbBE4hXEt1sFro/sB3/OJ5yb+W7VSIiWtD5EW7?=
 =?us-ascii?Q?70Lb7gUOFcv7eEYZ9IG+W2ujP520J2e/goMQRJ+THq0enJXt8zJcXx/g2LWN?=
 =?us-ascii?Q?xYRvgEmLwCXdigs/pbMFWPkQICQAYubUlZUMZ/mCS3ehdOgZYtRVt3GH8/Vk?=
 =?us-ascii?Q?TJ5kvDTmhbEuRx115XA33QLyy/B4eXbZYrMmyyGlUPzf5rTt12pqvd/INsGL?=
 =?us-ascii?Q?RMvyCu+rdKyibh1qEkJNtWHDZmDu8a2X1PQjxn5xDljD86zRUxoc3c84Vtco?=
 =?us-ascii?Q?7OCrWP6lOp1ch3sYN0enLFc6qg2LwnSnTGgjQzhH7HJ0tFYOg+gl3yLkm96v?=
 =?us-ascii?Q?3WbGxIBZjGJ/Z6yklE1rQ1FvsJyFnEQRITrfyiPVcvCXEcZnUTGOKjXhE8jA?=
 =?us-ascii?Q?tkecnRBoonvNSMhRQ40HxujJ/fzP0OrWNhWVXSwLE6hB2oB989xs6/TgXODA?=
 =?us-ascii?Q?56fOPrJbQXEx9eJWrr6PsJST811PPJ1kavZnqxaez1Fm8P2pTd98S1QqEFdy?=
 =?us-ascii?Q?Ownla04RFP1EU7IAK5Pqz5wyywA43e4sbrhvn/5zkretJddmGqhRk124Wkki?=
 =?us-ascii?Q?cPsqapUFFOuh63zmAKj4DpoXlN657Akjv7uhmeL4dtr3IC0znCo6fY2aVoej?=
 =?us-ascii?Q?qb1BjZjE/uGbWVoMlwan3GnLhzvwOeNaPQgXvi8Z95lk82HMVOIFPBsCwspt?=
 =?us-ascii?Q?cJdjop2iSakDIgL+V2uIk/+02qLE/YO7q4OQ9rqGEIQO6Tir7pkVtR8qUgPV?=
 =?us-ascii?Q?D+HfJTPjVPfS2DeGOfkKgMZ362z5us7SiJlHLWw6KQORGG2XWvtUfRX8Q8EI?=
 =?us-ascii?Q?8Apo6RxxBagCu65ozPDxNR1CpTHsc+mIPqzl/L1JQQC1If0pDzRRRqafDfqb?=
 =?us-ascii?Q?8DwD68AIafxXQHWloMJ/7Bp/TZemIfweS/cwV4RDqqHJqASuycuc1P4KSqXz?=
 =?us-ascii?Q?W0+prIzXtzzvJqJ4yR1Vn8ymUB2kMAu/I/d53tI0DywwRXq0KPV2yyup1ke+?=
 =?us-ascii?Q?B9W9vcIc0H1PsFh0AyDkuTknvbUhO0czxSOE+5mSAB8NjwcRzdNJtZ7u+GTx?=
 =?us-ascii?Q?5sawysJlhFKoZVZth8xF4xuEjAXhVFmBejS5Y5rTBOA0ezXLU4BI2iJFxev1?=
 =?us-ascii?Q?zcCuSbuViQNF/QGs+hJHYxaH6FJnC7yeK3Xh14QxcioNVc/0WN61/k/NxotA?=
 =?us-ascii?Q?k0GT9msAZa5WTAumdwSlkmQ4oP7rlBBvLJyQ+HMDDFcdZi7hNvhPbAbDPjra?=
 =?us-ascii?Q?v8Hqg9qMzEPlRfX6FyEpDeGFrwRX5sFuijNtLHhXkeZonpcZTZSz1ZFCKuYo?=
 =?us-ascii?Q?a5s7WtM08z6rKZI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:31:30.0883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e6464b-7925-41d5-dd63-08dd551a9a4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256

On Mon, Feb 24, 2025 at 08:35:56PM +0000, Pranjal Shrivastava wrote:
> oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > index 5aa2e7af58b4..364d8469a480 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
> >  	}
> >  }
> >  
> > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > +				    struct iommu_domain *domain)
> > +{
> > +	struct arm_smmu_nested_domain *nested_domain;
> > +	struct arm_smmu_vmaster *vmaster;
> > +	unsigned long vsid;
> > +	int ret;
> > +
> > +	iommu_group_mutex_assert(state->master->dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > +		return 0;
> > +	nested_domain = to_smmu_nested_domain(domain);
> > +
> > +	/* Skip invalid vSTE */
> > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > +		return 0;
> > +
> > +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > +					 state->master->dev, &vsid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> > +	if (!vmaster)
> > +		return -ENOMEM;
> > +	vmaster->vsmmu = nested_domain->vsmmu;
> > +	vmaster->vsid = vsid;
> > +	state->vmaster = vmaster;
> > +
> > +	return 0;
> > +}
> > +
> > +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > +{
> > +	struct arm_smmu_master *master = state->master;
> > +
> > +	mutex_lock(&master->smmu->streams_mutex);
> > +	if (state->vmaster != master->vmaster) {
> > +		kfree(master->vmaster);
> > +		master->vmaster = state->vmaster;
> > +	}
> 
> Does this condition suggest that we might end up calling
> `arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
> commiting to a vmaster?

No. prepare() and commit() are 1:1. How is it interpreted to have
"multiple times"?

> > +	mutex_unlock(&master->smmu->streams_mutex);
> > +}
> > +
> > +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > +{
> > +	mutex_lock(&master->smmu->streams_mutex);
> > +	kfree(master->vmaster);
> > +	master->vmaster = NULL;
> > +	mutex_unlock(&master->smmu->streams_mutex);
> > +}
> > +
> >  static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
> >  				      struct device *dev)
> >  {
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 358072b4e293..9e50bcee69d1 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> >  	struct arm_smmu_domain *smmu_domain =
> >  		to_smmu_domain_devices(new_domain);
> >  	unsigned long flags;
> > +	int ret;
> >  
> >  	/*
> >  	 * arm_smmu_share_asid() must not see two domains pointing to the same
> > @@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> >  	}
> >  
> >  	if (smmu_domain) {
> > +		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
> 
> IMO, this adds a little confusion for folks not using iommufd.
> 
> I guess it'd be cleaner if we invoke this below within the:
> `if (new_domain->type == IOMMU_DOMAIN_NESTED)` condition instead of
> simply returning from the function if the new_domain->type isn't NESTED.

But the arm_smmu_attach_commit_vmaster() still has to be
unconditional as !NESTED domain should clean the vamster away..

Nicolin

