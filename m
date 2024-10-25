Return-Path: <linux-kselftest+bounces-20676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100209B08A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333341C22C66
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBA18B481;
	Fri, 25 Oct 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="obVaT2ri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F817B428;
	Fri, 25 Oct 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870870; cv=fail; b=c3B+yfpNyqHqOLtn9GkvTcy34e969piGwFhhrfJnMPLsw9LeEK/3ZTd6gpbhg3eM7SFID6Ue25Y+7mwhBfS5tLWbXRhqsm4OfDIxMmlCyL9UqIQuGgBB14XEiRDD4mp6QYMQJBY9k1Mu1dIpFaQMt14dAJSfHbC7g4TJZJZ5Hs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870870; c=relaxed/simple;
	bh=rojsxuJFT50R57E54bAiOLp58heo6X5wVbGkdSy2PIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxKMiNAFx8rBDfZKOfuFg0qjHVYLtOnR9uTFECZbzrhN2sl4bFW7WB1qtPdZNXx65UKsvgx16evHxjUCWpP8ZeyH9u7J3T8vMBEgXepBgwac3Ixh4zoHRrkQMXSmnsdXZ3Le53dew6Kp+m3I3UbxKTPJ20MhdRsgl1lw4s78ZmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=obVaT2ri; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMJTCi7PfN8yUjW54xyxPj9mNLXHPk0ek4cTz4mKJwoCHGZegTiKVgCklDvyl/0hxBWnG3B0tNPt7H8Wwyf+jCqygZBs290EX2UrbMoZABPzYTES21dwKU6qN5shhwT8EkG9zh4iu/wnTPicWhQ5XTFLfZ4MSTFxM0Yn3YDP76yfw7oqeVxKaURWWlM2TiyfX/pekfXrzqfVtZNw48uovRZeTQij35CqFcz9Fdkwph1tHcii8W75IrCrHnhyWr+rPG1E/yvxaanxMKoirzEiKrozpV34RrK2PExRRF307Q7FxgTogaUqiJZzcdZ19GLUwhHFs4BvgpNGb30wZp3zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC+wKFkFB4zirm3fgZhjz0CMZ3bRFB3UE3TDR0Czu5M=;
 b=YEnDSkMz/+ksSupIADlDZCiOIn15+g7bhuG/ElMuEzdf01eG1IEZx1noVjkKXnhEMbaRix2AVLCxMNaY5tAdHGNhPqieTyyzXgDVEmbgprDFPS6O7/x3ACMTif7hQjBNqEYpzxETmQIgmsSJfAOzz0oCcNKRY3Og3+YyFBlOXQDlZt8k+ws63EisBGRPJ9tQqFp7TFaBHwMPXZnHCU6enK1QbMEPzx+jr/yndWVYk4362kTR9b32oc9gcRvato7UyJT+GiudppU/WmDqlw/gKv120rkti0KbDd1kPgrilZjsf15wdOwk6BKvFBAfPjP++ITdf27ludN8bOJreTx8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC+wKFkFB4zirm3fgZhjz0CMZ3bRFB3UE3TDR0Czu5M=;
 b=obVaT2riigReIqqQFm3Kn4N8YJZf7LahuucFwFRRK1+Y1OF89gWfezzsS+/7wHJERwVzHvMWFc9s7fH+iFgdE8JS0nHZYqHd5o86xRRhlKyhJ5lQ6V1tN8+yT0MViWZkVx2s1e9SDZ0UgGQh82g/682WdC08BtlIKchTPUGwgBHL6FIx03AwkzWauMYEtLjlRmUBZIsZfKQsV6C9hHPJ7VNDIIlG0TxIVOGIuDh0/DlB46SfiT11rSj86e/MkaJjXQOSU8SPxR2ZqFiFhd5wtbrMTx6ZxhSXBxSLMPVXF+ZPs1xNvYln6v8t1yCp6aXqb0i+FtKmGVemdpg9tCs/ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 15:41:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:41:03 +0000
Date: Fri, 25 Oct 2024 12:41:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com" <aik@amd.com>,
	"zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <20241025154102.GI6956@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <2180fdf423d0f2fcc5c031687690100b12c2ba51.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C3BC659CCCDF3A1189458C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C3BC659CCCDF3A1189458C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN6PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:405:75::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6f9c03-a343-4fbc-cbd5-08dcf50b6eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LypfrChAFwfwTx+NasvHgCoQ7ZWg2G/WBsdFTCfwncM6eVYvrQSd8A58HqI?=
 =?us-ascii?Q?/ByIlskqOS8FwWH+7rDYaABAc+I22zlg2MP6TujTZpRhZC5glqh/jo+GjFfD?=
 =?us-ascii?Q?TJHrm3fEirNpLrTvozG9RJJnb/6P/NYsYA7wak+kenKNzWsegyoGtJAiRlFk?=
 =?us-ascii?Q?YxNLr7fU1Ymc1G7/JtatRFncLoi3Uz25BdeqICJXcYhG4o3ZNnn4uk6DXVdl?=
 =?us-ascii?Q?2WASX5T36iDgDUuk90tmdOhjeOD0TPmr2weTNt8gW2lYzNkbIMqJ9ja+ippZ?=
 =?us-ascii?Q?BVW/5oaYAkEji6qBpqLdHLm+z91R31lUkrzL6W64i9E96pWyxqp/RdFrRLYr?=
 =?us-ascii?Q?mZeUqaCoqwGjyCn1MKh0qG+SJ3UXCSJ0HPVVZOw9H2K/iRaRCVHwaF7jnBTS?=
 =?us-ascii?Q?UgzNFFqejXL2Gh1Qe+68FMBU4O3GEGgzNZwBG+hpGeCcrJoB/+zcaoFfzaw9?=
 =?us-ascii?Q?XQcS7vIeho4lnzK0/NOB7gJhH+WdkqA9nyHSfT/PXUGv0fNmubRs7WGgsyss?=
 =?us-ascii?Q?Jet48gAvaUOHTztd5UL6XhugUx1Xhm4KPlf7j8w5E2KPP/3mVSmlM3XgXhk+?=
 =?us-ascii?Q?HHGeg2n4Jm3zUW7adu1spXjAeJLjJtphzhrJ+t9MUNfU2/XzRcnHa7cIjYmg?=
 =?us-ascii?Q?gH/QfEWFDsMM/R05pJRAWI0dg58HEk3a1aA7TE7CKs38AvH8/MjE5MAjoigI?=
 =?us-ascii?Q?x0uhBXhW6O8/ctZlbO183PoIy/jkwTSoOUFYWW7RbRnjGxtL2GQOd/ZxXagg?=
 =?us-ascii?Q?Po03kZOIDwxt47e7G/zsAfS8TNh5Boe/16YQ39qEW5wrFsnnDPHCrMst+Kfh?=
 =?us-ascii?Q?Ww9QF99Hu23oJLzVZrc5yw75tK4NjJrbQvHPVtulqaE3VWEb0Of3QGBn0NH1?=
 =?us-ascii?Q?VB/xUedNfzCdSq6OWKYwo/GCIRftuTbXojzztbcZIjUD3sF66DQXzC+hZM0L?=
 =?us-ascii?Q?0RBd80bQcX17+8HxBACh5n9ZUqYWiLkY3mZ+lLkvacyyT+QhprYkWCGfSwk5?=
 =?us-ascii?Q?1ds4LkDeVtSGamp8ATyxA124V25LlGXid3E1oX9AVMuWMRV/2mSDEWfHwg2P?=
 =?us-ascii?Q?rypAt5/dlcKjfnBIn98wY+phOF3paNVOR5cggktC9WOjwXaP1qWcJ9nq56BQ?=
 =?us-ascii?Q?MlmDb2hWzJ7/ZD+0uwv8mY8Kgx0BXoDFERQk4Zdtoaix/N5LxVgcD3Xl5QgO?=
 =?us-ascii?Q?zitf2VxpxgkNvbgrGZAXQ5cMLI9n+JuXJRgm0ykjKq/XusJ1FsNlYvZtWmXj?=
 =?us-ascii?Q?B1ikUr5VT2pmegrJBNuLjRojN4ZUI3W8HWfoYRjDRcT5WxJLcyDj9ofmyay6?=
 =?us-ascii?Q?sD6bvft9k3G8sfbMhtA1EuY9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mu+fsFP42vY8BNl4+bsaMc+uGemQ6zATd7NS5GZsA24BTQ1dUXJAbRzUmfe/?=
 =?us-ascii?Q?0m41vwnf7rbm4w9z74HN9GA3ENKvc2YHKdCU0xwzxH2ceKo/HASFypZUXUky?=
 =?us-ascii?Q?JSOSBK2LpTAWH0tVsYX+2IIT+r6MxSMDNmG+jCzaTR1HD8esj7PIxi2tKwfd?=
 =?us-ascii?Q?wTQXJ7QifDJ0dUPZEP7sjxb3c+jPmpGNhL09yoRBMPXzFL63HGfJeOHXVicW?=
 =?us-ascii?Q?FotRYB3SITALW2V/oEXdWZMr3uEdV+nEMsCoccGv99VWpudCK+BtlB1m7Equ?=
 =?us-ascii?Q?rzTI5IN6CJ+sshEow0ZyL5W9D+zXPcbI5gCxP2vVSyf6EzKhr7dV6Q003K82?=
 =?us-ascii?Q?gjvtxKGlFrKnP+vZ6ElXZaJ0XBy4x+psIkpJW30053fOC8hoJ0dVwPuxia8C?=
 =?us-ascii?Q?E47lodn2j57ph80ch3I9SbX4LzrUcjmTu2R2P/qkg2XK/0pg+lwLghn14FcT?=
 =?us-ascii?Q?xwx7+nzo7R9VfHMxmj9IC2bhcAc/ggpjTseRHdShNYxvTq7qia1DplBskmdU?=
 =?us-ascii?Q?XvSIuxXYhpcQxRl6vxcqtftXp1uPhfZJGPTWK5tsF6g0jPHQXuP/AcJyuvqm?=
 =?us-ascii?Q?c5UqfuOjiORuwKtFHZuIFE8ueF6r8egc+GatvL2e7qhSu/139XRSf4kGknwR?=
 =?us-ascii?Q?sKXxh+C6z02YEByygMpORjODqo9UMxst+3X0wMgqHO9fMz/ivIIGln1Udni+?=
 =?us-ascii?Q?5eg+qbS+C2aaiWmxwZFBnVI2yeCJmRIp3wsyhxIxtncg2FyVeq6mRfI7zkEJ?=
 =?us-ascii?Q?Wnf3AcghsykZIkVUNdhu+2Jovy/SOfwpJz4CZQwNuOuP96Br0sgYzXgEFWgb?=
 =?us-ascii?Q?jKap5tGpbrAc1mikKe5gMT/odHN3mvcwVPwsZOaPxZcBAeiZmWKN15NivuGk?=
 =?us-ascii?Q?JPAF2V3WpHtneZbtwJc5kfv+jWwEysliAQqRf/HELR/m0RAA49hTMoLb7MJy?=
 =?us-ascii?Q?/x0sRrr6/T+R6BkXz2nlC4fXHUv/0dN8u5u22h6a+SAW+FGtKR1TJSyY7K4k?=
 =?us-ascii?Q?BQkVeHvdO9cMcCv7jyL7zc40GiBFwC87kJ3RP7PHW1G/8TIFlS8o+a4Yvwq3?=
 =?us-ascii?Q?7ibzFTxOeVBCpIWtx0Ps4sr+P1rRALK84jLFlEmMc9Rfpl/D0juigQE7FrBu?=
 =?us-ascii?Q?jVvxfye1hT5qGcIXXrLSSoV7KAFrbicqFQrrOdhUB40TrYWQua2C5k2aZu0G?=
 =?us-ascii?Q?XaUqo0itNfN/b9NXO2Fs12RBC3PvsZhEfecKxUhILKuJLNVL0A/jWhcn7GKp?=
 =?us-ascii?Q?WBke8zTAqbsWfeSg+DEkubRlZNFFZP4L3n01bY/B9PU/zU1JEmTY6j3ALI9Y?=
 =?us-ascii?Q?2RqQ4xLghOEeKJ8hkPOrhxb1yE+/gFQBiUQPsRn9tJKfX6G9PiiD9Nd8XL0w?=
 =?us-ascii?Q?Ob/MKW9O9+A0xDau/PxosJWXsqZAJXxt7LEwgTXrHCbGhpYFifRh/HDJOZcT?=
 =?us-ascii?Q?YBTaZMmbuhCL+tUroZtZac2w+eLOBgaFbnEC+wJkTH3etcNFuMgsTlTVlWEQ?=
 =?us-ascii?Q?m1TGlWJ0ujmSpGxewdBEQ3fYA+06WltCWh1bMxBJBpT4VJG88zg8MQ6DMztl?=
 =?us-ascii?Q?i1wSUClBvpc68tjQEPOyjOE60zzrH4wf0L0t559p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f9c03-a343-4fbc-cbd5-08dcf50b6eff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:41:03.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmzPBCgszRs0/RO6yUXf6nzBDDJOVbag5y1k1enq3AmXHQ2br/Szs01RyseUPEfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211

On Fri, Oct 25, 2024 at 09:18:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, October 22, 2024 8:20 AM
> > 
> > Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type.
> > Implement
> > an arm_vsmmu_alloc() with its viommu op
> > arm_vsmmu_domain_alloc_nested(),
> > to replace arm_smmu_domain_alloc_nesting(). As an initial step, copy the
> > VMID from s2_parent. A later cleanup series is required to move the VMID
> > allocation out of the stage-2 domain allocation routine to this.
> > 
> > After that, replace nested_domain->s2_parent with nested_domain->vsmmu.
> > 
> > Note that the validatting conditions for a nested_domain allocation are
> > moved from arm_vsmmu_domain_alloc_nested to arm_vsmmu_alloc, since
> > there
> > is no point in creating a vIOMMU (vsmmu) from the beginning if it would
> > not support a nested_domain.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> hmm I wonder whether this series should be merged with Jason's
> nesting series together and directly use vIOMMU to create nesting.
> Otherwise it looks a bit weird for one series to first enable a uAPI
> which is immediately replaced by another uAPI from the following
> series.

It has changed from my original expectation, that's for sure. I've
wondered the same thing.

For now I've been keeping them separate and was going to review when
this is all settled down.

It is troublesome because of all the branches, but if we don't have a
conflict we could take the whole lot through iommufd.

Jason

