Return-Path: <linux-kselftest+bounces-27399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0EA43150
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 00:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C27E3A78CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359220C485;
	Mon, 24 Feb 2025 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h9V9mOPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4220B80F;
	Mon, 24 Feb 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440769; cv=fail; b=MuzI7g8sCUKfrk/vWPBECzCN1aag1Srz3zSmOq2MHUHr2MIZg4m70yM6+HTyjlxQsfSa68M9naai9nK2NVZjq3M+9ylq2SFHiMubM3LZZJY2Od/Z6VVf+vrM+i4wMPwVy0i0AFaWFzyqjHwIWGMP54iYT2N5m1OhAzhYyzRZkmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440769; c=relaxed/simple;
	bh=doBYHcj0OeVQI0TNqf7bA2CWtOxVldapySalZmZs5gM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4mDCEBy5srlSjfDLK8AJMP8ySokamGC/Pt/C/URhIXD5QAQZS+oI2yBI6PCSis0sqFcVTI1RV4SCmA5I4w10iIly5o+53q0jK/NpY8OXNRqh7rnU+SPtpFH98sWDMj3vvuUb3R/2qaAJIBNMgdJsZGRfrYGkFfn9vLqDzloY3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h9V9mOPi; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvS6/Umu0s8Tt8RHI/nMrucCmkzMcLEUkamnKiQDGFT3VikL6fSWb6N/Sss+nQLFMui9FcEl/e2nLDPMlWUSRhmYfRWnVhba3WSpnW+HfdSEw/MKLC84thiA0hIAoMK79xOpGps0U96CSGn2LHIOg1laJ+PD3krX2mbL3rBtzrY7zk6rGGEmIO6PRrz9VQaRUvLU4z1/E6+K1SetTLzeNn2EUbZMrGTl+aTpICg3CfcdU1EtyD99iGmvg7Y5o4/73SWZp+zI3e9wDf/lW+ArsCg9u6DJeABKKE6SF1e5x9n55Ruevshsn2+rcQm18qfmTq4W+jSovCe6QV+dEesOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1pplp07kf4rdpIRwx61vGsZkb9qsjUKhKjs1UNgg84=;
 b=nPz7KLmUwx9pelNyn8/pU11A3cZ2iX1P0fWHAYa8FZq9fN6+Q8YVORqD3KabSQmEni/i6RY01uUByW/79hVdFla5Gr3xuvouNqxXvpYYf+MzNPQZ0RPfZ6TTeR3G8nXwi6wepkGJeI4pEr8OIZ9BIWsKJv+GmBBqXJRp1kkSK6pYA8WWYLYH7ULYnU/X3THldjN6tazPlZm0RvPUC/kTO0gvpveGms8TnGsfu1b2oIZ3eqj1voK7aBocDnC/4Z2cl/lDs0Hosp+3a8GhSf0aOT/ZhfxuUa2NNUy5IWMlyrb4ryvotlKFM1piMBzAb7/g8ggaPqcs2N1A31c3LOkZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1pplp07kf4rdpIRwx61vGsZkb9qsjUKhKjs1UNgg84=;
 b=h9V9mOPizsQf419Au1M1DZa+RgCyTUNAI3XEJma+mAgpzMjQECrLXd5rRFTAopEddqKwJuVqbS1vJhrR1Mm7wrRScpG7pwEKBSEixM2P54TsJ1F/31bco8YdIXb2Tx/d2ji0A0cofliWOp89VYZQlWsffaOZW96mR6sg1dD2yhVZNwWWuakWvZR0iU97/gfddDswXJKZvqskJk+McS55fHPpQVLqJq/IiznZPyvg0ooDIgeRBSdBTlrQyJclXafl1BxSUdzw1+0TuZJoEO2FI/fcVVXC/jOvryT6w6q8R9JGWuUhAdQNCM/GJfyV1JxW+RW1pHRcUTnLVCuJ/7fgvA==
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 23:45:57 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::29) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 23:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 23:45:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 15:45:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 15:45:37 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Feb 2025 15:45:35 -0800
Date: Mon, 24 Feb 2025 15:45:33 -0800
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
Message-ID: <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee9a13a-46ef-4c88-b3a0-08dd552d6283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SULUp/RIeMAoON0MCnq6a8wtRl2I09AHUQWD/AIUemHXpb9QQk2ZG/Eb4+Wj?=
 =?us-ascii?Q?7Hxp8r+F5hw5OWqQ5YG9/WGznMZqUym6741ficYw0dLtn76r/v0xJu4C/NWB?=
 =?us-ascii?Q?kCv7xcmDEbrCq+PaE/06VS+OtkKr3gHJ7gSBlbXfNHe3cfkTl2Uzmtlo1oE9?=
 =?us-ascii?Q?3PZtxTarPsASTR3tdKvhAevHOWP+QrG+nLpAwEVRRaUeZ3r4vPjJ69tcd3ij?=
 =?us-ascii?Q?yAQ4C4HH1e/eCgZDdu1y9EhbAoRqwRyP8cvSChNU0zi8DJkzyS3k4Lw9REUn?=
 =?us-ascii?Q?Tgc7udJVIXAh7bUCUgWdcC60a8yV1ku7tctLAUQzpuVsj6zQNUsORR3RYXvI?=
 =?us-ascii?Q?eVJyghdJ2xU9wX7Lv3JIgOPlF+YJrvlWE0knNwqBxoW4JtUJU8W6WV7N+qNQ?=
 =?us-ascii?Q?/1CTgj0QfmJLd/wqjV3Z5sTfgBb8cnL3KwTUC1fWVUdK4Ddf2LLQx6pXzHw4?=
 =?us-ascii?Q?7+ZtMINIYXqz5aIxn0za3ajIsL5GepRICUZ6vmtut+rogsBtYcAjKzGegJRE?=
 =?us-ascii?Q?fdv/VnKvOtur3SR2i/WEmMz/b0fAq5+XuEVgp9VwTdBy/cgRcZUAJFX6INKM?=
 =?us-ascii?Q?VpVyY05tXvhkb1zew0EXX2JN/nCWqMlW1HvAN2rNezSCMu4F/V3u01IEkfWV?=
 =?us-ascii?Q?Qx94Ls6PBEYdSVbyef7nSfoqeHIvK/7BQl61zKZoqaMRKfjzIv+KZX79LsOT?=
 =?us-ascii?Q?1/bRTz2kpiv2gdJXs3L/zpZXWQP+K9SYNHw1J6m2rvhG253lfHkKl5e9CP4f?=
 =?us-ascii?Q?ngAPFQdI/h/E8dYwkcoY+4XysISFLAttYf8D5ykxH8HxymIVcq4HdmruOVRR?=
 =?us-ascii?Q?axpmuRVjCkJlCWnr4vFGtKwG7HVNJopCwV+8O8Ii3xRZOl6HvwwV8IWcfimp?=
 =?us-ascii?Q?bA2aHBTBW1g8ccwieMl1Wwo355RVTdIqXcw7+6Ys4Hpc2TWchxD1MWYjmKhL?=
 =?us-ascii?Q?AScHPh2CqdXiHu7SMwJBsXfv26rFgyAWPty7aTUBOHjlmhWDhuJZDQQioFeI?=
 =?us-ascii?Q?lj85/XSHT8QFmuzgTcbKFka3PZvSsFVkPmwi3yok7wp+xR4OuMJ2XTyhIk+S?=
 =?us-ascii?Q?OHmkwgXOFaYFXwed72CxIWajCr38wozX3ONAu5BA/oXRDt6SlWzkYrjpNubZ?=
 =?us-ascii?Q?Nem46KilTFGGGlXUzb/lHOBkXhJuMXurIsHh+7iMLkErBMkWX761i5lE9LcY?=
 =?us-ascii?Q?Tm+cVHAI4JMpVCyAHP8ub3yeAp8VgoVVZyjYJrerC6U839VsAKzEKLfIKrxT?=
 =?us-ascii?Q?vpEcJ3WiZS32etaTITsl2dNWhDChhLCHg7Mzcai5VKS216iX0CfH42i5sOHi?=
 =?us-ascii?Q?khyvX9/mR8QQW9mmiup/uqa+ZiGOlTHkinSibzd/70qt61eo8+p5o7d2vtHh?=
 =?us-ascii?Q?hxteoCQDNgoGFOYbVGof1svwiz4MSrXTSmwYxIDWJ77g8My+shpAF3sDS3jo?=
 =?us-ascii?Q?H33v8R4Fc58+5shyBTEYBvHX5FF2oYAcjQr/WNIw/3DsdUhtiws1Mg1Qgzct?=
 =?us-ascii?Q?/bVSIrcnVEOC8IE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 23:45:56.9603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee9a13a-46ef-4c88-b3a0-08dd552d6283
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

On Mon, Feb 24, 2025 at 02:24:55PM -0800, Nicolin Chen wrote:
> On Mon, Feb 24, 2025 at 09:53:58PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Feb 24, 2025 at 01:31:11PM -0800, Nicolin Chen wrote:
> > > On Mon, Feb 24, 2025 at 08:35:56PM +0000, Pranjal Shrivastava wrote:
> > > > oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> > > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > > index 5aa2e7af58b4..364d8469a480 100644
> > > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > > > @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
> > > > >  	}
> > > > >  }
> > > > >  
> > > > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > > > +				    struct iommu_domain *domain)
> > > > > +{
> > > > > +	struct arm_smmu_nested_domain *nested_domain;
> > > > > +	struct arm_smmu_vmaster *vmaster;
> > > > > +	unsigned long vsid;
> > > > > +	int ret;
> > > > > +
> > > > > +	iommu_group_mutex_assert(state->master->dev);
> > > > > +
> > > > > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > > > +		return 0;
> > > > > +	nested_domain = to_smmu_nested_domain(domain);
> > > > > +
> > > > > +	/* Skip invalid vSTE */
> > > > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > > > +		return 0;
> > > > > +
> > > > > +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > > > > +					 state->master->dev, &vsid);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> > > > > +	if (!vmaster)
> > > > > +		return -ENOMEM;
> > > > > +	vmaster->vsmmu = nested_domain->vsmmu;
> > > > > +	vmaster->vsid = vsid;
> > > > > +	state->vmaster = vmaster;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > > > > +{
> > > > > +	struct arm_smmu_master *master = state->master;
> > > > > +
> > > > > +	mutex_lock(&master->smmu->streams_mutex);
> > > > > +	if (state->vmaster != master->vmaster) {
> > > > > +		kfree(master->vmaster);
> > > > > +		master->vmaster = state->vmaster;
> > > > > +	}
> > > > 
> > > > Does this condition suggest that we might end up calling
> > > > `arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
> > > > commiting to a vmaster?
> > > 
> > > No. prepare() and commit() are 1:1. How is it interpreted to have
> > > "multiple times"?
> > 
> > Ohh alright. I was just confused about why do we need to check:
> > `if (state->vmaster != master->vmaster)` ?
> 
> Hmm, it's probably not necessary, since we always allocate a new
> vmaster pointer to the "state" or set a NULL.
> 
> I will clean that up a bit.

I made the following change on top of this patch (will squash):

-------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 364d8469a480..2c1a51c360fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 
 	iommu_group_mutex_assert(state->master->dev);
 
-	if (domain->type != IOMMU_DOMAIN_NESTED)
-		return 0;
 	nested_domain = to_smmu_nested_domain(domain);
 
 	/* Skip invalid vSTE */
@@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 {
 	struct arm_smmu_master *master = state->master;
 
-	mutex_lock(&master->smmu->streams_mutex);
-	if (state->vmaster != master->vmaster) {
-		kfree(master->vmaster);
-		master->vmaster = state->vmaster;
-	}
-	mutex_unlock(&master->smmu->streams_mutex);
-}
-
-void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
-{
 	mutex_lock(&master->smmu->streams_mutex);
 	kfree(master->vmaster);
-	master->vmaster = NULL;
+	master->vmaster = state->vmaster;
 	mutex_unlock(&master->smmu->streams_mutex);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9e50bcee69d1..b9d0cf571da0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2833,9 +2833,11 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	}
 
 	if (smmu_domain) {
-		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
-		if (ret)
-			return ret;
+		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
+			ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
+			if (ret)
+				return ret;
+		}
 
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 		if (!master_domain) {
@@ -3171,8 +3173,9 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 {
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = { .master = master };
 
-	arm_smmu_master_clear_vmaster(master);
+	arm_smmu_attach_commit_vmaster(&state);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
 	return 0;
@@ -3192,8 +3195,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 {
 	struct arm_smmu_ste ste;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = { .master = master };
 
-	arm_smmu_master_clear_vmaster(master);
+	arm_smmu_attach_commit_vmaster(&state);
 	arm_smmu_make_abort_ste(&ste);
 	arm_smmu_attach_dev_ste(domain, dev, &ste,
 				STRTAB_STE_1_S1DSS_TERMINATE);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 85352504343b..eeec302f1b4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1066,7 +1066,6 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
 				    struct iommu_domain *domain);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
-void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
 #else
 #define arm_smmu_hw_info NULL
 #define arm_vsmmu_alloc NULL
@@ -1082,9 +1081,6 @@ static inline void
 arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
 {
 }
-static inline void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
-{
-}
 #endif /* CONFIG_ARM_SMMU_V3_IOMMUFD */
 
 #endif /* _ARM_SMMU_V3_H */
-------------------------------------------------------------

Thanks
Nicolin

