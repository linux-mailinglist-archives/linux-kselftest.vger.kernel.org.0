Return-Path: <linux-kselftest+bounces-34081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2949FAC949A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC36B3AB042
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A390236A8B;
	Fri, 30 May 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGj8wp2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36782367CA;
	Fri, 30 May 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625574; cv=fail; b=ual15xwXeFmN1ZT96J+m1EcALtVjP3u0tNkIB2JdfjRwkYN1Dgp5axfgaBO2bcPBnrWMeQ9ICpBRtIMZvpVpB9AgT2fPJDgkZKb5J7uOfGJNAJtpo5LLe8Z1AycJph4ulx7NSPk5Ru1yos+olBech4cJoR6mkfSrCqjiMXrHIqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625574; c=relaxed/simple;
	bh=moCnhffNFINe6T5268sazB3SjVIeZ2LQLv8sdFAV8Bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzigLUA+b6/LifMWrpKqMAN+KemkHchnu9UojQvUHwRND+d2atTg9r0FzOnGEYQ9j3+NXsFBYipFv2UxjlxfhZmGzxbxvvVFyOSREC+5f9KxFC9HBS6XUmtWpUemooQW/7cNWYU8Dq5qKoR9w1wJWx1FjgLjEvoXMOig9DPmIhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGj8wp2C; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRWfORWzQLz9T4UDa/rfSCMIajvSevgw3bjqlMyU0vTAG1PYtH8qdpmTQiz38yZMhu3nkxwvd7RvZ3Tjy2ronkPR4MIbOgMv80QDDINPS8y0+3LHF7HRi5j6hlmJ1Nfs71C9DtTFHWz7BxIgTfcDFN8EHMcKcrlpuFsIGX3fDGNrMZVAg9/J26+jvWXraDo5RTpNrwVmi78t+YyYRvrIX/3qJQjCWTZ/KjlgjMDsA6WmbdtAUAxLJt5G/9lVi+l3C+eYOz6MAfpTPzfiicGREqa67x/0EV09BEJ++vGHPqXWfABuIkDVki809ebgZUSEMgpOhlQgGcvd69NC8n4Q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qizEhiomuE6nYG5D/ARrFIwgLqPK91jCxOZb3uHEr40=;
 b=LtZ5VREBmAMD3/bF8GEbdSOH4QRbAanRBH8Ao0Ro8H4bFRJGPxm3rO//q2UcQz5HDt9tmHTNQRIBc8MXjcZRKJsEvSDYS59uZKxVHXxCWY6/nMYgN0HxZ8fHbISZge8IA4XC976YiOYZi1BUrlzFObtgTs2pFeulSuwCHGD5FGY29I8B/XzDRwndIQd/SOeLIidejY2uwtdPNDy7MeLMEdIzzlKTyA3dwHmsDabPMRkp7N7ogtC17JlyW4UxT3l6JjFaywthkFt1szr8dHy+7xSTLhq1XrWeL/xvBtNSl0ibJJeV9782RAr6FRc5nYltEeU1HyrNCXl+uCMisuOlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qizEhiomuE6nYG5D/ARrFIwgLqPK91jCxOZb3uHEr40=;
 b=OGj8wp2C7hKi3SBzDtBQns1TS/cXLb7vkDu3a0cUP3si+stsSS6mxgrvDdknKV8P7B4aT77ZakKs0BJByS4uKGRilLE4MiczDD9WLKp9/qeXLyGIDBvU1/splt0TY+6IBxfSZ5Xa42ETGPIjqh0hg+esy5j9fVkbf24f63rLt2Me8EIl76N+fXWuTBi82h8g/H2vquqF4XqIKkOYlAeINOKdOeQ98VqRWLsC0nGFwW/uQ/k1iXmcShnAeegdT6otSZ6OSd2JsPWIFfAeByuQUPh7vofyxRwiq1p0UzHiyl01NbVgdW1H7DRB9hfpsxM+cq1fkSpmoJMMUhmIA8LEsg==
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 17:19:28 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b0) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Fri,
 30 May 2025 17:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 17:19:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 10:19:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 10:19:14 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 10:19:12 -0700
Date: Fri, 30 May 2025 10:19:10 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 28/29] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aDnojjuMUqMbIRTb@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <4a84673ef6fe040f1b551d059be466c2c7bdf2af.1747537752.git.nicolinc@nvidia.com>
 <20250530171052.GM233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530171052.GM233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 562d4402-4e14-4e98-a84c-08dd9f9e2203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Z/gAUq682cGLKxfGzCPEzQYC3LhOU3OO6/3Xb9Mrpo8FyBruySfJ1vFpF0n?=
 =?us-ascii?Q?uUcsOiQ3CqQH1JGk0iGs5D6Nnb7o2OjoaoZjEUK84eXBsv29EjW5+ecX8l19?=
 =?us-ascii?Q?M8yJbzP2XgWvHNux+XVaxcpL2lf0/NAUY87sfg5I3RtSusjkrk7A5Q//q94u?=
 =?us-ascii?Q?Ra/k9xKfZT0c2HatFkIxnE8pvAOUGtIy9rJ7Yj3LhU4lKAYHs2FcbADUfq/l?=
 =?us-ascii?Q?gX+w4FIc/OxLA+0EBFHswZcXs2tDmaJlNomP42Q+R+U6cMfYBCb+bFr4PHV/?=
 =?us-ascii?Q?RiBRbkoGOat7ew8+RqyoaSga3TwC7/9I1QHyb7ggVcn4DNLLFarAzPb35tCO?=
 =?us-ascii?Q?2v09Y/xV6AcT/3ceKK0HvW1fAQIGWo01CaT59Q+awwYWMoN1J1KOYOPRl172?=
 =?us-ascii?Q?h5qsqYt/SULWkssKfwa4MdskR4VGmtVmOTAZ2/PpYU8Zv5IEtun/9Pcuj6Vj?=
 =?us-ascii?Q?faQ6odmlGHqBCtx6uYeuyuJzrf8JQwmNJZCgOyOLSPP5FzueVVs7FJcvX+jV?=
 =?us-ascii?Q?Uc9nTZtavp/rzBkl0X9/d3wmGiJCi/Bwra4vltnUWjOitMOUXgVu1JXL6YVz?=
 =?us-ascii?Q?LHU53s+XnRS60zV3Gl+EhmTkOEyNNH0T4tL75Mgpj/kzBwhXrxVDiLr8Bkhm?=
 =?us-ascii?Q?9kYS3UJldev1ldbOZqEQ9lTy2eojYpoX6tX1Txe1P+lIZa+MErrYdwwk8ETg?=
 =?us-ascii?Q?fG98lKf0XH8Cr32lyHUsOUuOvo4FCmy/6LhY+UFFxy1oLqyyequgmH++FOzk?=
 =?us-ascii?Q?zkdB1M2NRd5NmlemBC24Gc2Zg9nIUhh97lpUQ34C6rreqKGAWgD+iXSn4zCN?=
 =?us-ascii?Q?FrBok8X/qT6Z3Y6m7d3rHU8hTtuc5llJco4p/tsTOC3WuiA+unEelSxxvtID?=
 =?us-ascii?Q?I0/zgSw/IYDBpdlsnRLfPevi2dsIYSJcxNORzJ4ZzqLudfJmFbJTDu5yJgUl?=
 =?us-ascii?Q?k+14wO4FBgCbrvPzobYTA9OWpvc/OnQQ72Rg1tQ3vimkK0eXMUW2Fch0LZAQ?=
 =?us-ascii?Q?R0DDRj35L51JHiMyOKRpbMLQu6M7RBHxYXjC+HlMAy1qyVebAc0VOarScYrV?=
 =?us-ascii?Q?C/Ah+WY8kYCAZVGGXjrMLm5OW7TasCoxgp8UPMj3eBpFmbDNHd/iCK6vKEL/?=
 =?us-ascii?Q?8f81sBo0GetoeW1vuCv41EtXMoP/bsy7y44hki395j9O4qWtpqgUFOIcZ+oZ?=
 =?us-ascii?Q?995+9FqENYFTKctqFRbjj5eMc0ruD3iQgEs9C9/KsLaa1a/8QGfeJUNin2mv?=
 =?us-ascii?Q?FcG8On2M50SptjA1fA87Fyjqqi3zfEcfYmaXr+y3Zmc08O7ZSqphRPggUc0N?=
 =?us-ascii?Q?vs5ZHbV4g+lCapvcgDt82YcRKrQloQHFTG4onykQeBnX7oTl+sAl1OaVSG02?=
 =?us-ascii?Q?ybuQmjNufp2bhOifzrEqYJ+B22Xxlv7ZRFpdEgFTjqSMWw/dASeA1R//pGBt?=
 =?us-ascii?Q?ojPzSrMW6JZBaSM5q9tJgprKTHLyZkzAoXF1jSjJ58EZ/lbszlCxDR4VtP83?=
 =?us-ascii?Q?PGXBentj9bqJq1bKPasq726V6G9Acrg8JR9L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:19:27.9548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562d4402-4e14-4e98-a84c-08dd9f9e2203
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

On Fri, May 30, 2025 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:45PM -0700, Nicolin Chen wrote:
> > +static inline phys_addr_t
> > +arm_smmu_domain_ipa_to_pa(struct arm_smmu_domain *smmu_domain, u64 ipa)
> > +{
> > +	if (WARN_ON_ONCE(smmu_domain->stage != ARM_SMMU_DOMAIN_S2))
> > +		return 0;
> > +	return iommu_iova_to_phys(&smmu_domain->domain, ipa);
> > +}
> 
> It is not allowed to call this function unless you are holding a range
> lock on the IOAS that covers ipa, and this path does not.
> 
> This is why it has to go through an access to get the physical as that
> has the right locking.

OK. It would not be needed either once the core passes in type
phys_addr_t as you suggested in the other patch.

Thanks
Nicolin

