Return-Path: <linux-kselftest+bounces-17288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54096DF75
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D18B23444
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109281A00E7;
	Thu,  5 Sep 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kI0scIcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F019FA8E;
	Thu,  5 Sep 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553402; cv=fail; b=VP2aD/rcP873LgzKPCc2wffjwtiLv1xrq1DmkLjMrb+1gMih+PsG5FRcdozuUHZLvmKrQWscWSuKl9e4yay+omi33OYN+o8n0IAJKugbtkSDFUZu5BVhBfThAGqTyoy8yuMaBV4oM2RdaS0tdcbR62loBs55RMI0w5Eb5Sl89V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553402; c=relaxed/simple;
	bh=LmwEowQcsH8+e78EZLXIT1io9ZemMe+NEb2+Xa5azD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XiGY0C4xMM+rGCFkbHYhNLCuSzJi5HH0JYYBBwg/o64gtSIgrY8TwAKOS3A1JtIM2ww++4wgqlT8t+WCu8KkvR5R+EfawruJh07KdxdVvZLVy758XTUHLLRlbmWGyb3lfbDGFhogSTTrCb+kRDFurJ4UgYCquIYYgjF5raMspmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kI0scIcP; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiEvG+JRosCkhSw0DnZ/kcVdXygxhaqep/sWnKQBQ9mrCw35S/XYNtJiZEsDKyz8vmB4ocqHgXWBtISYMQkJdRQ0xmUjW5zUejuYMLv4aMACQyIIqQvBZ/4BH0GnQBeTaKCRQ5CRYv83iGEOiO26eQEqbPAq1AJQlLzBWfDOO6yradb64AgD2XquuPf10rxQe09+rsUi/LT/wsqBd+rZVu8/+iiXlqxA3+ZEcG9+uGXTRgZ90VjobPvNCHeVUKnYBVCrw0pVsNVWQyhFCPPEFHGW31VesCpxTXVl8qFcSlDRoMpil1PQJWu7jPIORwpJGTn6+smCasRp0rHTVKPfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNUVPg48vb76OaduxAU42VliJn10NX8pWVKeRNwu6Mg=;
 b=VF6X/pxqGiJq8YptbRcuiy8RDuz6S7jZxKueODIkwHBhs942efMp7BOe2X1lcuwJdT3AexAeq8mKnYiVQlVNyRq6ck3jTACF4IziUuQmG3oTvjmUkaQ6T2UxZA3PI5kte8xC2e4tXp0McYPDbGykv8mWDKREaP1V5PKeVGtxOdKmnykM5QhwbpU5q0Km+olY5Ya25UjpjRwYid/5g/F63o+nWPLAzANxd94yR64OuA1dAcnA3bj+6gWrt+nv9L/FqcXkoCSGBAAzOydiHSZ9j1imMXO1rgW/m/8ps5WNP9+D80hQHWeqgaDdwhvkYUqHZiOEOxdHfM+4u8BEtTSIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNUVPg48vb76OaduxAU42VliJn10NX8pWVKeRNwu6Mg=;
 b=kI0scIcPlpR0OOApftxYRPSX2tF3//mPS+l/zV/noCvTCH4VdFg2CWq3jCQX/XxHf8b5gIfjy7WqEsREnKBQAuxJUGAgX7uPocH7nqGu+AjfeU32kac0hIG5AKBWPfNNvgeKy5a03F7YV7p/TMBALDNpl6x0zZIXpDleNck1vmzOq7dkjwIyg661GWJ7oqucsEWC2qdMA6g1ECDROC5/s1p6AP2Pvn4TkhC2IpGSEVDFbLzPm2R7ZxDsLjV7cup3lHQHNLtpbIkZFZsNcAi2bT+7b2zO8oRYtSt8doGsKzRsVSUbCXOXEKKFMsWhe1kXMmHL6vZ2vpsLp7AlYsF+Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:23:18 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:23:18 +0000
Date: Thu, 5 Sep 2024 13:23:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 16/19] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <20240905162317.GU1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <3548bfff43a0e1c072b77fc37a1a8a6c930bcec9.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3548bfff43a0e1c072b77fc37a1a8a6c930bcec9.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:408:fc::21) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: ee421739-f424-4a39-f042-08dccdc70d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pCi7Ga7FRmPCdQvpArvTso5oTdZGL1n3BxB2zcHwkM89vIC5yYZclsCSTf2m?=
 =?us-ascii?Q?dpJeMpJToZfQUwWQs0ah4kyLDi3VazzDlg2Z7cNn54fcxel6w0K0ku87WMBC?=
 =?us-ascii?Q?g8dvR121pKect5DV7Y5SSurMWIiMIl2Ky9z2E+bSu5O3iQTlSeUElZiDcwVb?=
 =?us-ascii?Q?sYGAFOVXXH2QF3gGQ2NICYMnBUtUhsg5yD1yQ92M+LqLch3LK3/+I1JgnagO?=
 =?us-ascii?Q?8MKztVFzm4ToJBhh789WQIHDWjnciv301p4zzSxAm/Dxmnisz1+MRlPjSpku?=
 =?us-ascii?Q?g5hvodUbWwfd54n8RLZxWimam53x6P46DVkclV/wSQ1L0umrGECyxt5YYdwU?=
 =?us-ascii?Q?W6y1BX8WCYCZqnSLTYbk3HOlMMHMvtvWJUyqyiy0ggLHycfLVkA8+Fnxvwy5?=
 =?us-ascii?Q?FRqtFnKX7jhdGW0l1B74YBO9VRikTLr5IWC2m+Q9fgj7G5JlksZ7HjJCuhxe?=
 =?us-ascii?Q?ED4vr7i6Vj4njb4DGogz/SROkhc6P9RNsX/lvBW3rOL6/mMiStxdh6nxdrCD?=
 =?us-ascii?Q?2+9ozTjoWKXFF+0hkS+LjYtdXvEItg30k7wxg9rNeKIzOR41pKGTArQdat5A?=
 =?us-ascii?Q?x+B/MbrOUrScH7ibMc9XH34dSDSt3n88fmu/+ORo2b0M8vTm0GiHMyOsCiO5?=
 =?us-ascii?Q?Dcx7fTEFlPJkpOrkrvSHyQXLTHT3aydlDQ2z5jXoOpo1ANYKl6pZOosbeYDe?=
 =?us-ascii?Q?qHqtZUl2YJuuGw1Yclf86JQJvyBBpjfbN8ebFxWaOUc+kEB4rdTArEKRhYVW?=
 =?us-ascii?Q?HCXrLViiXUnOGIlViKL1EoLt4Xnqvxfz/IVEDw+SZ9g2XmHUeI0PUVOwmzr3?=
 =?us-ascii?Q?Oi24S2tl8EZC0I99xAuANnUb9Jyfy09P95ohAConP/tY66GsLsYHMC2MWBeo?=
 =?us-ascii?Q?TCQsthumxwranhuhKSAG1Qpw5eDoK5/4+/bmSY9RdfKCMJUbwzmY+IOwnrqt?=
 =?us-ascii?Q?jkkOKUehg+4Nf8nElAzE+Pqzqmltt8/QttKFJTL5QhgKosKDW3w7hp8kPckF?=
 =?us-ascii?Q?hqA55eZW6dsLJ1fBJ9mphzs82hQG1G1tFb8yJsB7E39FiPOoCCWr6aslfxtz?=
 =?us-ascii?Q?NxLjnbyiqj7L6CkYZjl4mdOk6fRQB5gYiUc09RgT16sKs1IJUy7j7o9cMwbK?=
 =?us-ascii?Q?gTHJxKsKN9basevh1TeAHm13UlTw0DgQcXWcmmQlZHB9oLPeOmI5feAwu4XS?=
 =?us-ascii?Q?7KblYQonczYQsQHSNMChgrc7/nkITqK2NPlcCZI6uZODrArq2dLWS6wl39Ai?=
 =?us-ascii?Q?FThL+KyRSy0lbinsJhLxdSDkoo0cTrJDDERPi17xXlSmmXG9hg+mEZni8BVv?=
 =?us-ascii?Q?VKapOr4MIHmsi2UcVw4zsC7lxfO207rIuLwotK5niCFRAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Z/RTezHUty44jSlZaH0e52ZV198JgIS9QiAGh/A+0p+kBEB0lCQyz/DjMWV?=
 =?us-ascii?Q?DODovhYnbQxhlHjQVF31GnlseMN7dJM2yQOgSYgTStSMAQmZBfpqPI/YNuvD?=
 =?us-ascii?Q?HBAbouGeiSk+lSAlBqpoGgbQiBjf1ta86kL08Yt2U5svdorxq82bYhS0SRg3?=
 =?us-ascii?Q?8A6+8PP4bfZAjqhPbUCNJEH6xyWDRR+RgXRbvr0JmE5iDvBYGUAKGt8haS0o?=
 =?us-ascii?Q?HC3T/+q5JM6sShrJ2JXEYT+k62sQzsES84v3aaHAvmZQfhuWA6OHc6sIQZIy?=
 =?us-ascii?Q?FTnoQH1K12HIamRlyfFLlOz4plHNokSvsy5fyNSf6aqRWaaVrJNc20TRPBMv?=
 =?us-ascii?Q?cUDtQag0xxP2s+9Y001zT0ZPsIGY+LeAwxSBW7yUfBFCW4w3qyh5/S+AvX19?=
 =?us-ascii?Q?Xfuo9IAglR0vaY7kdmjDUgM9KYYgY9S/d0dRBtm91mDy8t1gX0BfsQdj1Cga?=
 =?us-ascii?Q?jaQ5zXbmNeEOUETP6yTHlOpZGnDi79XNSWW5eYDEacNmdIZqVz7U2cWLiFon?=
 =?us-ascii?Q?fJFSv8vrFe6dzj/JtQSUHsZGip37d6LtEmCK/+Clgo3CE1Yjd6mU8ZV3TGRO?=
 =?us-ascii?Q?Z1MvdKA1OhXwGjNfJPvzWhQkiQlKlNqOegF4V+lnOL4ML+88u652ah4XuqRb?=
 =?us-ascii?Q?5i1v7tOtDZ0KGxiJKAVKanBav3ElfgAOX6N55oiVWliQ0b5C4E3b3mnpT6PR?=
 =?us-ascii?Q?KzanOqt4c9N2rDvDrQnrCedoeiDWnKtKw0903r98v+OfV3QO0mZw1oTgAHHn?=
 =?us-ascii?Q?QiFXPeAJwxWA5gIzvj+znxNnHRDloiaMcsRumQd1nAnJuGwgoXmMISSY3mOt?=
 =?us-ascii?Q?lln7X24fq2mG6kFSShydytoYlRik8CnSVimMo64Oo2B6nT6Ytf2nfr6Fn3+Z?=
 =?us-ascii?Q?YYtnjU4EF3o/SiQtOMyXSRnbFleQLotUBCnlQN8GRpRzOEP5CeVT688K4+Yd?=
 =?us-ascii?Q?NUQ+hjIHTH2pZxjLuHqoqfXw8+YaTQuP8GSFjfFq5udALZ3OpPT2pTZ6K59Y?=
 =?us-ascii?Q?VV6jk5kpdsLTcjv6Kr8us88lG5aHmKlBwF5weU1/yDwQsOheUfEQbtk5y4Eq?=
 =?us-ascii?Q?QQPlqDRLfbJCDaUcuhqNXMwYeic9G7Qg3QHylIra+lhZC1+XQDhLDP/f2YyT?=
 =?us-ascii?Q?gFrKOaTtDtI88TVs+7/JUkAmQow34nUOHV7jQSMud0tSqq6xKTsBnaq8jo5w?=
 =?us-ascii?Q?1CE1gd1PM4ECfs4+8VyWa6Mr3+2GucVvM7zTGXFtwQksxpoYfqPVnpfXeYk3?=
 =?us-ascii?Q?HjNsiWS/g+RLnfisGEduy6JnN7mTPAnZqBgh+jfEScl15ya/c74Mh2/bkOXL?=
 =?us-ascii?Q?eWkaXcPB398JTcrQUKL74kT+eJ5NnT4QLbefYp900vC6HX8GAe3e6GEjjSRj?=
 =?us-ascii?Q?3CV3Ca0PZjeFk+nitYhXfgMsLsvHFQXHzEWK9kqF9CMmRos4ADo0cEDWHwYJ?=
 =?us-ascii?Q?XQb3l3xngCK0uNLR6+1q8I2dzVLxH4POVfRyTE78W5kFz149vh/TbUn8XCft?=
 =?us-ascii?Q?XHxm7VhceleQpQcR5aIqh39gYqtqOPzOBohwYZqlaCOGjGaPLeN1hMUKls3G?=
 =?us-ascii?Q?a+Tw63jVb/mH4A6a5HimgXg36wIDjwRAxtBnu9hL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee421739-f424-4a39-f042-08dccdc70d32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:23:18.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRL1+wiPj7WnUBY1chhEer6WJWhzkVgYBFSbIvPQU4oD2/alt9kRCwGYHFgd1HDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Tue, Aug 27, 2024 at 09:59:53AM -0700, Nicolin Chen wrote:

>  static const struct iommu_domain_ops arm_smmu_nested_ops = {
>  	.get_msi_mapping_domain	= arm_smmu_get_msi_mapping_domain,
>  	.attach_dev = arm_smmu_attach_dev_nested,
>  	.free = arm_smmu_domain_nested_free,
> +	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
>  };

I think we should drop this op. The original intention was to do
things in parts to split up the patches, but it turns out this is
functionally useless so lets not even expose it to userspace.

So the patch can maybe be split differently and combined with the next
patch

Jason

