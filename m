Return-Path: <linux-kselftest+bounces-27394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A70A4300B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1CE17AD13
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E64204C24;
	Mon, 24 Feb 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFpHnqGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47634205502;
	Mon, 24 Feb 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435911; cv=fail; b=bdTeNEBsz65m9SdXUImxmqzG9cpHz/RJFiZYgwMN7L1ejaK+Hi2ZmxQf5phbwOFAROap2YxcOCcakWBehlpLQrXIkUARXs+LcLSMJnNiFxLpwKocu+kMhaGtGsS/IN3Ahh19Dq1BKRGH9fvjOqao0pc/UTodhBKqIXI3h+6TNEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435911; c=relaxed/simple;
	bh=fd+S6U7j/f0aaFraPxB5JLmebpY5AqjVI+Dml9GLc+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptsnTMgZERPl3E3Df1o57N4siZYiqxa5kjyEBdikwVJSxYmqZ5pDpqxHBY7QDbInQEpW3pp7rcNSgJOC13JdNcbg3k6M/zu897CfZuvZonaTaa91b7fKCO5fE2xyeLB1INrOgpN9c5RIfwWeBM5S/A1AzPJvVHEeuBB/87o1QpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFpHnqGE; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW1RQQSQ7JJOpDd6RGyaPXYn7pZNL2mG4sZDKdTImz8LRyOFJQIOQV/vtMTVNudOtnEzAKHthTqx3kk8DaFPTsb/NCkjhE86s598l9NVPWB1xTNI6IFq3FEbQOxZzPtZY2wkP44wb7scARd8eMWD576hhSEpdjROcCKKFFToTT9RQ/cCBG8l0H09qHLBSkGlX1KluIsO/PVUCgSRX4KEDE0SS9JW4MiWe+1/+D4tarLPR4niDe1dPF8f2gymb/k/xl9knk3Jt8tzQRyDsistXzlZbG84aR/bM6bsgCzrjuXdoFrDd3VZnkbLi8UJnueXWS3FcWjkTqpxM8rqm29qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoYoG7UmIrw7C7LcYpxyi0Q+9LRtm0iYJgdTNAM3uVA=;
 b=kk6pKLTOSPNFlHrKe6w/G+yXrzzItu4o3QLjU/zNHEspmOI0s8BZV2zb/1sW2KCyQDhMdINtciZHnY7sqt8MFOpc685UsKB67zWnrNEerzWoOfdOxMUs172m4p73wyuq9P+QpkghflbxpC+gjRRLLw9Joij+bx3WSRqgADeODMGArbU+PFQFI/juQuJoCZER67/Jv3OGkiVtiy9P/T/hRs/lxIyJ10lSJ+cDAjUBfl7c5mqDpsmH3M1kUFHRZ9byjxGcwo/qHsw7jJ/6LC1WmAiYNzDPfOtktwWvwabebMUNneGAePWUSrcKVYDnvH6/sE61Yj08uEM9EtS3V5DIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoYoG7UmIrw7C7LcYpxyi0Q+9LRtm0iYJgdTNAM3uVA=;
 b=mFpHnqGEmBf4saGFSrgHz0kZ1CZvdHx/hHqD52FtQPstNiBRxbisIz6Ww7un4yx2WcHIo9H45DX+auDHwH6KH55a7XafspFaOXFEFbFtHgGlMRtgkWHX26i56Pqm3OG4eu16fFP3+gid6WWyFTD0Qy5AB9V2JUN0Mn60/IaROnCTyA6zRciEXx9HU17aEiAs9iUtg/2xrSpSRUu9jApr4U1yqxTkNZA89C0nBIn2E9Du06a5DXG/UvXgclmPWhueKallHLb3f601OSpVgzRT1QGe/OMWqYAIAIt/gg3ivyQ69JVsYDmBBELSr+y5Zi15rxd0UBIn7lnXLVtrX7ji5w==
Received: from CH0PR03CA0308.namprd03.prod.outlook.com (2603:10b6:610:118::10)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 22:25:01 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::82) by CH0PR03CA0308.outlook.office365.com
 (2603:10b6:610:118::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 22:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 22:25:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 14:24:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 14:24:51 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Feb 2025 14:24:50 -0800
Date: Mon, 24 Feb 2025 14:24:49 -0800
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
Message-ID: <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7zqdrQn7Q8yXfcn@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 01744dfd-aef8-4ead-1601-08dd5522145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUCYptckUlPsGP6kdARH0Cb3Zn3YoobGhHtUdmNpQLMqufDy+KfvSYM27t9w?=
 =?us-ascii?Q?4HumY+Lapsv51PBt4+nUzaUfhpzS9wCw6f3EaBUtms6AS58QB+92g7/+zYqI?=
 =?us-ascii?Q?pIodKVO/fOE+Xdv+gIS078kZiMDJbSFVssa3v79S20FkvGvy11Amsn5ef4sR?=
 =?us-ascii?Q?2X3RtzXLjv6Oqwb9q86LXnp9E8cMOtd05oVTDdHzVV9ZOBrESR6J3Q99no/i?=
 =?us-ascii?Q?37cq1uBVikNYTUX5hj0lpuYdYzNTBOyDde2TAgkgTloAaXkM7x3XrctxLKx1?=
 =?us-ascii?Q?xEg1gZl01yPKN6bu5HC55AymO7zDj0hF52JMdRj4UKUKIyEyLRENPUAQVu9i?=
 =?us-ascii?Q?sco+Fsa/oJOqMKnUtuRQb8zDv0rhmZGawCuOndmMdzCryBlePKRMrZ9cdQTb?=
 =?us-ascii?Q?qyI3plySuEk9BtR7ViD/fPqiLUhsKkpGeqhVy+Xwo5LX7wjcx518GouCnHoE?=
 =?us-ascii?Q?275uTqJONbKtFjDet6ImOIOvhgzRirsjBJy+nw/mAXm76IMFgsIv+erAWXix?=
 =?us-ascii?Q?JPLg6sf5sc4UPJ5yML21S3zQmSylPTmJcqIDLnjSm+EO1kHNFU0I2xpTP692?=
 =?us-ascii?Q?7Pv7OCUeHkx62QrduIcbpzvcv3y236+bgVhW8x2nhCv/thlhwVvM065Kq6g/?=
 =?us-ascii?Q?ozWjic1N0bgJOPsBJgvZe6SZH3WvNDJd0VnxvJsKVOhjAM2E6KUFt4KOpSzY?=
 =?us-ascii?Q?RGGIxkpLGOVm6W/atwSMkLptGAZJvvRXDZ5K4L62p60Q3OGu5kBPWH2/0YdB?=
 =?us-ascii?Q?f6wEieX4tBSwFOviGMFJjgshRIlSF0P+LPpft0m3Gq0m3EOboZUD9UzFcBlL?=
 =?us-ascii?Q?NW6QMQfZhMhAwwNp1glbPe0wYi0p8ezzplc4TQx/FJSKq3nUL1vW9we4E1ZK?=
 =?us-ascii?Q?GI3Ry77krMaYywPsgK8Js/ar8aoEZgIobCfgeBjtaFQxzP1nywvzqvT1vXce?=
 =?us-ascii?Q?e7BzaNWrhldR1oC/miiYYoKYexnhCs/bS4cLF6ADD02lqvnZVoZiczJJ1R9e?=
 =?us-ascii?Q?tUV2D4/H/tcLDg9/Fev0ov27DkIZ2dE8h2DUGAMIGtlbQbTMcTRwLw7/3lGe?=
 =?us-ascii?Q?WjYWYc30Zn4tYQqG3YnR2sRNlY8ar44IdXI4TCZPZWA+nCcIYuPxF1BEQhut?=
 =?us-ascii?Q?IBbLOdABNbS3K8rnTksX0MY5MG1pB5ye4B3tb7VPeNNqx7sP64ljgufqPNpy?=
 =?us-ascii?Q?qv4YRYr7/uU/oDDRJAezY/ig9WArSQP0i2Wt2yYXHNGe8pH0CV0bmSTcYdOs?=
 =?us-ascii?Q?tf8lH2phUay9Z4RGy1j35gyMK25f4qf9t0MTKocJZcB+ZlfUEBgKqAn2gEx0?=
 =?us-ascii?Q?vELqmBgdtrpG45ItRrKWKk+SAZVVtuiap/jK+uepjNB5S95o0iPXD8e52UiD?=
 =?us-ascii?Q?seJmHtSmXbt9TUCTiUWFxqkFY5mACggl+ndy09GBjt3WLqUh79t9Q9vUYP7x?=
 =?us-ascii?Q?5mFgSH+7EK2XFLycoAONw06S5cnpMrelnEQISFQRneZKjBgYHZ2oexvAGrqY?=
 =?us-ascii?Q?nIqk6s9HNuQlkmU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:25:01.3744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01744dfd-aef8-4ead-1601-08dd5522145c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

On Mon, Feb 24, 2025 at 09:53:58PM +0000, Pranjal Shrivastava wrote:
> On Mon, Feb 24, 2025 at 01:31:11PM -0800, Nicolin Chen wrote:
> > On Mon, Feb 24, 2025 at 08:35:56PM +0000, Pranjal Shrivastava wrote:
> > > oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > index 5aa2e7af58b4..364d8469a480 100644
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
> > > >  	}
> > > >  }
> > > >  
> > > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > > +				    struct iommu_domain *domain)
> > > > +{
> > > > +	struct arm_smmu_nested_domain *nested_domain;
> > > > +	struct arm_smmu_vmaster *vmaster;
> > > > +	unsigned long vsid;
> > > > +	int ret;
> > > > +
> > > > +	iommu_group_mutex_assert(state->master->dev);
> > > > +
> > > > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > > +		return 0;
> > > > +	nested_domain = to_smmu_nested_domain(domain);
> > > > +
> > > > +	/* Skip invalid vSTE */
> > > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > > +		return 0;
> > > > +
> > > > +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > > > +					 state->master->dev, &vsid);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> > > > +	if (!vmaster)
> > > > +		return -ENOMEM;
> > > > +	vmaster->vsmmu = nested_domain->vsmmu;
> > > > +	vmaster->vsid = vsid;
> > > > +	state->vmaster = vmaster;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > > > +{
> > > > +	struct arm_smmu_master *master = state->master;
> > > > +
> > > > +	mutex_lock(&master->smmu->streams_mutex);
> > > > +	if (state->vmaster != master->vmaster) {
> > > > +		kfree(master->vmaster);
> > > > +		master->vmaster = state->vmaster;
> > > > +	}
> > > 
> > > Does this condition suggest that we might end up calling
> > > `arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
> > > commiting to a vmaster?
> > 
> > No. prepare() and commit() are 1:1. How is it interpreted to have
> > "multiple times"?
> 
> Ohh alright. I was just confused about why do we need to check:
> `if (state->vmaster != master->vmaster)` ?

Hmm, it's probably not necessary, since we always allocate a new
vmaster pointer to the "state" or set a NULL.

I will clean that up a bit.

Thanks
Nicolin

