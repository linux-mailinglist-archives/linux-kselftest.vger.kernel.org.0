Return-Path: <linux-kselftest+bounces-30271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DD2A7E7FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075407A529F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE163215F6A;
	Mon,  7 Apr 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgK3RTli"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5861A5BA3;
	Mon,  7 Apr 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046230; cv=fail; b=TNTn5RH2SBazKRRvDBoQ5aiXoGCtsMebRC7pdg1SJKhT3oE1kfAjDniT+SZDkwBzS+5rKf9UOmuqpiH2b/+PY6hKAS5rcZGBo00+eXpSrDyUv3M5/ZqujShN2voKeK6gbA15UCcAqjWo5jsSM83baSGGNWDhvsYcf89vrRehuHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046230; c=relaxed/simple;
	bh=dyCebed0Pmv+GqI7EX/QsGmCgEVPSDrKWJfdeA5jgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b53VUQUsUgWEp431p8+jS3oQnDAaYAVcinINqchFjB0jvEPprPaLQ4JKSLag/p6jS5BY/VoIafpOr23gzz95ndxoz7hqOaj86v6z3xThXggZZTC/eflqSHxt6zD/FViL0KZjuS/YzGnlZH6l7QsUnrRl6eyypk0jTD7FT/wteNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgK3RTli; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSR40rG4MoLItQfyiCFs2UKnx40GZ8XycSLNIOrKS/LVMy1uGpHB0idxZcS2cV12UPPgRtnLVP4xKoGxEnqzQRsjKz9l5tJ1ouvI9jbjTX0HvyWmxGn6HvCM0XE2ctJPEk2D+QWbmvLuhI0kGUQ67Jr6whov2d4wWMX3VjVFp2Dxv93oxuPQu08qw45TBMEGAF0oH13QnrsapEef2CI8JT/76PdQ3KupcB6JOW9rM+3iFpx6RyJnc95VKuNWC/1z3qmg2xtPkSWtpFzVoC5i+7WWU7eWtiXj8vE4CZ40Fru/nnst3kdXo/Gt0CpF91I963p1Of4Yf4p2faYu2yvqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH5TUe0STTpsuxxrdPluVVlVFt6OBkU8CDO/YYJS1wE=;
 b=qAnH6uwSHfatH+woxfUa19KLWMh3MtFH/to5S3bIcBQ5BlkSY3SLOM5ERq4Bv1kzuO5Mr6pN89/rJgkfNlTREbyoCT5pL2J42wr44HqGvSu765sJVfR1MPQzO9bJqoXEbPFmQUR2HWFvKpQeLgj3jt79h+Qn1M5lcgupr74YrZU/oHlrQBIs7bkBs7kZiSMzNKT7yFFTnryj+ParhQ273lndKKhUulffH+JM6Oo4YL8myeqi9H3z1KqnF5PLy0cjxNFUgS1UJYBafdVj1WuvmdZZmZATUXO6kBwb44mH42/AP/A7/eaLMX1lLU30sk86dnuwct10uaCa2pOKI17Iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH5TUe0STTpsuxxrdPluVVlVFt6OBkU8CDO/YYJS1wE=;
 b=PgK3RTliPeSKgNSUBXfH4aCMmg+FTZSfbkwVr0YI2NSK22dlGXYiW8C8xtWd5VGKcqctwlghZINcFPYt55uGwI8Ku/7Eky89VlPDh1GwCYu8UysYQLUWeDQxuAKKqda+6QC25DawXeZZqulWvPOdDWwlk+J/D0dchxDCkwgJH7KM7TNEGnH8mH3YtrETsFbdh/ltw3Lt8uvJAXyTwGB+adxdIgmIMdcnWZeoFIZZ5flxS2yaFaZno9MUkff1ILjULyW4x8Txx7/mTjk7MsbjiULiYAwzSuHnKaj/4OXvwMhatiuulF+2uCECnLUzHlE2KPpAIZycHgYakoLGt3OEWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 17:17:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:17:03 +0000
Date: Mon, 7 Apr 2025 14:17:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250407171702.GK1557073@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0259.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 49912ecd-3e2e-4c0d-55a0-08dd75f803af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PmCyhMPw5B5+3+PHu0gQ7SqFoUILccjcZEeIFACc/T8ObXprnF4uOn82x4Lf?=
 =?us-ascii?Q?+tU+l0OJK3WnsBvUdPBxviiep6qaPKHulefzk7vCgd4fB5JQlX9hgsNiW8xv?=
 =?us-ascii?Q?Lbe0UUvmhm9zQSllJdaeOEeaa3cGqJ4kbwCfF/VSwAGvIYeH1wdk3jwdGn8q?=
 =?us-ascii?Q?P+xleEoU+jwD1ZlRkdATvDtdPuptcE8dH6VJ9IiRNhUz/GarmaXZWMK6YQmL?=
 =?us-ascii?Q?GebfLeobzacqItK7x+HW4I2yPEVd8l5XI53d/qRow6AjZWB+586qEuj69nTx?=
 =?us-ascii?Q?8nkPdb8bEQiVDxpIGJdxMEVLTaXYeaZ3gkX7RI/0wun/fwHZJMCyMWFY6E4c?=
 =?us-ascii?Q?1NCUND0+GeB14xN4ESlTHu/bqky1TEQsYyZS0p32qMW7HqDt25+Bbs44aRl9?=
 =?us-ascii?Q?qxUDTg9LkJKHVXskW5D9HWPaaxUAvKYPfdStdaesaDNKygYxcJr4zuANd1Fq?=
 =?us-ascii?Q?GbB4qUbOnlvP04RfM2+l4DxgzzsrzHnkFqQYszwBIvw4Z5Izu2i96HCFjeyD?=
 =?us-ascii?Q?Zc4Q/FFKNvVWvetpBYK0iVuGbsZg1b9YrSmDqmHCm21MQjKnPFsj9FmBFrN3?=
 =?us-ascii?Q?XQ/zUXNyUkyCND680uvCwZ55AzkKjeOjbTsIAloY1r4Wzpi8LRecAlu7YgCK?=
 =?us-ascii?Q?FcNT/r7fxQVe2voG//yP24XqmpUpSIdPBlciWdDKKC/zJRDN5H1ECBcAOdqT?=
 =?us-ascii?Q?hbfBRiMaWrzrANLdQ70+5kTwGB/6RvIXJzf7PTCeZ5VfjdswFcmNXPExpbBO?=
 =?us-ascii?Q?2kFM+jdPWy7C0SuA/63UQa9kMmWWiwuYU/20hcwMPjUbYokVbyy2YAzNjEd3?=
 =?us-ascii?Q?uOuWMb436v4pbi7SR5oDApMPgbMvm3xilUjRnEI7Ph58toQK1kVW8IumY8Lk?=
 =?us-ascii?Q?Xbdmwd61Fv0CzR/eJtvmpuH2Y+9b1txLpZP7ECPwjJWvlyhuvx+an7ObmJF8?=
 =?us-ascii?Q?3LT5Nkg0pG70deGXnkEnR4mInruH8Kyd5DzrcjPiSBdOBCjYts/3e+YYSk24?=
 =?us-ascii?Q?/occbpY+lnkzRMAqR7F3+3HhYyaHP5/DbXxLVQj9Fr7SYYy20LT/xpqV9noO?=
 =?us-ascii?Q?CjZw5j5UP1GxyDNNb7APsmhqfgV3xPs06oupt8nlR4YC9r97z0ZPjBsXIdu9?=
 =?us-ascii?Q?9MGsc5R4XKP7gas7SCHQgDNj71c9Kar+QqmVZXHtOtIYIeHiclDrB0YnfftZ?=
 =?us-ascii?Q?gpISeLD/ZCrLLi2vHzYvGwHa/XvlzEdKafIS5d3yowK/x8vHEq/3rakYy2KI?=
 =?us-ascii?Q?NhvCYnmDJhjyvgRLv4f69Y+DmI4SqTjwNV4GB/hviLF1f0Ruy0sjQVmkyGSH?=
 =?us-ascii?Q?hror61Wa7j+726S1EfT09urYBev94oRrIZG32Q06FkmjN6yd7+vSPczL0MhT?=
 =?us-ascii?Q?Xrk/ssKXwoONePa8sgRsy7Mju19n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjJzOSly2kEksav+RRp00Qba1YDFTmyu//XGxgvTvHpV995ETu36B7ltyPt/?=
 =?us-ascii?Q?zNdF0Jd6XUCJK4mUNJ2jq+3R52Jjp5esBP8GfIxvl6fMZpojHMm729867Q0O?=
 =?us-ascii?Q?jP8c0Vonx1eMDnmn6kz+rMkBwOuFuDhJR3+0Ppu4VYIpVLk0j4bChLCwwuky?=
 =?us-ascii?Q?V6oe7h0iYdTDDg8pNn+yA4ADIojUQK2YuiAtBV+f31Ai32pW9rWj/hosbqgl?=
 =?us-ascii?Q?32QtfRxlzqCLOZz3ftSId/vA4Q8F28E2CZaKFJqrWQjY7U+nilot9bv0L1S5?=
 =?us-ascii?Q?DKaOSwgZSw7l2WjaYf7KqWfAm0REVAq9V6eZglppmiSKSlyGpZRRxdqwL9lH?=
 =?us-ascii?Q?eaVW6InmF7Y4zm7+1dX6mqGiKnzOV2jmDTemFfHqFN+W8quJ5L0/BK9NLoDI?=
 =?us-ascii?Q?0csN4azXGEWDJEMuprMKdL2WO/3yqDDdhemd54Um27J8hFxfm2Z5kJ/VaE5F?=
 =?us-ascii?Q?0zoITAAYEkd7ecgOrXJK7gB726S7zCFBp53tFPOQ2MqUTkmJVqtJLEbgjAFN?=
 =?us-ascii?Q?t2gDxw8vp+/mdz7+RmsTP8iMwh19WA+/RexE5Jigqy107H4PdhqKqNbgt02n?=
 =?us-ascii?Q?qSOUHJ8rJL1ICVPydzkAhOep5/CB8Vo78oyvNh+5VVLmOWd1MNFXFUjP+U5l?=
 =?us-ascii?Q?Dh94bcFi9JS6Go69pnXCyyM8LhgxSM5cVM/lIyniq+bhmpVwwOAQpziNkcI7?=
 =?us-ascii?Q?dZqwZpcrEN82agDN1OJBZMEiCisR40QIV/8H0EAOIGcA00c1QuLY+q5HugxJ?=
 =?us-ascii?Q?ltY/ieadLQ7OcuQrPLVB8McuxYFijTCJ5ga1MgYdnrA8xnHskcQTpSBmj1Tv?=
 =?us-ascii?Q?0/VOM6tj4MKRGnMCrQyvp3GCqeQir/+fQgwXEYc3aNhH7FcDBHHHRZzUtEOM?=
 =?us-ascii?Q?cGWh7C8vs6Qa+liprek55aLzQY7nGYSawc0Rpe74IliSX5u0UVuxGkcfWFFK?=
 =?us-ascii?Q?q5YB13U12u/I0hYJdkZJ0/2ERfAkUkSrv6ofDv3EnQ0BafoHSK6Nq+Ia56Xr?=
 =?us-ascii?Q?e8JQj5/h+zz1SUdzWXHSzVTigzkAo0hnIW/x68Atj7iQpxWQRPGqY/WDs8E5?=
 =?us-ascii?Q?aznhGswn5AmT4c25xu5Na+T8yc/uuvrw4ahgMyXoHiVY9v5++C/iInP9Qabb?=
 =?us-ascii?Q?o5gWfq91U9Ng3Por1zp6i6mzFJ7H/Lv2ykyplTFQlX+QAr30A5UpsiLNDRxB?=
 =?us-ascii?Q?L+PtL1iNC4sZ+SiESWaoepgEfDWPpHd/pWaFvAke452ETF7T+AlRnCvWGP48?=
 =?us-ascii?Q?fwBE6fecjXumwO/wQMD72DoaNfurhc3AGKxVpdR57E/iiqYf4sO/KQMi64zA?=
 =?us-ascii?Q?0W7p7DfOQJfkWsBmM+DjP6dt5+Sgvw5aLR6FduKvfknosrK2KLci6VXmyMqL?=
 =?us-ascii?Q?uU2NtJCTPRTCq5gPqyB6ud3y+XzuBU7i4UtIEgA1C4lA1CYgP1oBmBxY2+N7?=
 =?us-ascii?Q?BLqMe37BQmbtwdsxmYuLKEQV0tatChbvRuTJsqK0UMY0W+VSmYFXeD+7ipRA?=
 =?us-ascii?Q?Y1vZPqCkPtYSlBn5+jumSt9WzARlK9OXA4hQoaRke/d6yuiLNENgaufykzT+?=
 =?us-ascii?Q?hCn3RyRwg3lX80clkmfeo36g6r/iiCArIf+f+XML?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49912ecd-3e2e-4c0d-55a0-08dd75f803af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:17:03.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQXlwRQolQOGmXrCwTjtCZed8PhPgIyZu2YeiGOTSXyY2o1wLDW/kEihPDQhiRwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

On Mon, Apr 07, 2025 at 08:08:57PM +0800, Zhangfei Gao wrote:
> Hi, Nico
> 
> On Wed, 26 Feb 2025 at 01:35, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> > be the first use case. Since the vsid reader will be the eventq handler
> > that already holds a streams_mutex, reuse that to fenche the vmaster too.
> >
> > Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> > or unset the master->vmaster point. Put these helpers inside the existing
> > arm_smmu_attach_prepare/commit().
> >
> > For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> > add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> 
> >
> > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > +                                   struct arm_smmu_nested_domain *nested_domain)
> > +{
> > +       struct arm_smmu_vmaster *vmaster;
> > +       unsigned long vsid;
> > +       int ret;
> > +
> > +       iommu_group_mutex_assert(state->master->dev);
> > +
> > +       /* Skip invalid vSTE */
> > +       if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > +               return 0;
> 
> Why this is removed in v9 and 6.15-rc1?
> 
> I tested 6.15-rc1 the qemu failed to boot with qemu branch:
> for_iommufd_veventq-v8
> "failed to attach the bypass pagetable"
> 
> After adding this "skip check" back, the qemu works again.
> 
> Do we need to add this back?

Shouldn't need too.. Do you know what failed to cause the failed to
attach? There is nothing in this function that should cause that.

Jason

