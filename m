Return-Path: <linux-kselftest+bounces-19987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5789A293C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EAD1F24318
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6941DF72C;
	Thu, 17 Oct 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HArmdek1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECC1DF998;
	Thu, 17 Oct 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183293; cv=fail; b=Q5v7RQitb3U9zIchHYwa0HYK+rOcL3K5AamgaK2LWIamIcuVUyfjrXB0qsUA8vaZ/TuNWSfqXQcvIdvu3rGh6jEhG+G1u/Z51i57aB56u3z8WT4bRt7HVi6JeN3P6lmMiqW8p4ZCvxjett9Am5Kskgdh9cLsEYWGDMMOh271BxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183293; c=relaxed/simple;
	bh=dk/PCmW46MuzmOn1+IvnOfXcUzCVLBNM4HzgpPm1+pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ek4OQeCPUCH4La6lB79InukSa9mBJQMwPmNbRSm4HZDNypYH4XxYQLxSHUxRcTnasq25uCQmQs99QXHXLr213i/0XK/+KeucmNjsDJsh858Mg61ZxIupONHJfcYDcu2j8AMq+D5JlqAZ8jETZKSgiyEBR7bAy5ZiIAKsGz3vTuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HArmdek1; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdQ5NatSGIrh6IBp8PhygA1jC6E4QYHQsHkZWXRpWmvZgjZUwZtuNahO+tNgiGyJRcejy9X8uZJ6/smEAPNRKFeDFOd0wq7c4EiYPpO9sNSRnRSHSCAX1G90yh63BPEcq+JX403beVXdtRfSllYh+LqCVabgYJ7sxyETGeuQjeMhyYa9PPq3nDjv8wAaYcO5E7pIehw+FDM/IT1OaKKsMVIxxRMP1xdw2xPdNnba1bG0NbT6qyRRohFZDq/cy7aNHlM6KK8iA9GF2/PU77DBwuSdet3fQicN+13yFy+P/S7ery6SRfzCEyOoxUECurGaX+f128+0aAwj/4KMvMzl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/W3h3eryA/B+JzMYSvJr4vNXJUqt4t90p/uJKCdDc8=;
 b=CygR4LwVaO3vOE5vQhq9jLeQgF+Ri6Zw7KFv06jZJgxBez8vpr4qQZzh87/EcVLPeTBBmThDs/oD0KIzQOkJoVueCG0WXPb8YgHiiX8u5/WEoTsoGZCivb2GJ1VkH67wt16POMfM5AMqnjKcIpZAB62AVDtq3u2yFfHqOQh6+6b9/tyoRoqKrFPcJ3bidE+09v0bRldfK2TPclps5s9/TE7RW2d1MZNIujV1tzHMA5V1YgcLScIXP0c6FwUsbQyE612rkjWqK3NpWwjL+EExIVanXgZ1EgPbvMV9nQD3vQ3wg6Aewzz/+Af4wfDrxPQeh9KIw6SFCkrzEE2URyNz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/W3h3eryA/B+JzMYSvJr4vNXJUqt4t90p/uJKCdDc8=;
 b=HArmdek1KlPpO1hpmNjua2OsoIXkmPzZJoFEeEohcy1T03GEunYPsrSw0co3iVFU7x6j19pzigFS64U/stz3KHJviYJkb+Y18egwU+wckIb1rxmhsd6Zck0RsxLVrUU43MPGbc46ypfUr7IWqnN8eYnGQYm8rgiAhC315C6by5B8e9EQUhnLHBUZ0A36DU90e7n+ZB/pmrGbRyC8wVtjrFE1N1JWHkW8f6vj3ecwNrdSPmul3AI5npvskMiqNaxDyUbeMJSfD/O5hJVxSS18Lh6Nd6p5FTfMbdUfW+66IllKVDvbnPegsMlfBdoEZDwxpmbBoIKXbJHdzz9SXfd/dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 16:41:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:41:24 +0000
Date: Thu, 17 Oct 2024 13:41:23 -0300
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
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <20241017164123.GE3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
 <ZxE7ILug+SL5eMsl@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE7ILug+SL5eMsl@Asurada-Nvidia>
X-ClientProxiedBy: IA1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7bfe8d-fa9a-4b8a-e13b-08dceeca89b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PB7FG3pdtKjS9hdBl97NjxMEoXtdEFUOx1rCNFLJdt7pOKCFHCNSfj06iZ36?=
 =?us-ascii?Q?bPt97ju5uiMnBMqbC2zjKFat98OhobTT7EvOEQzm6VDeKJ7G/3ZkewlD1iig?=
 =?us-ascii?Q?nuK/bE0AMSrTyCe6DWWatZGOCj9qjq5/w4Beh4t0ktwZT/bj5P4ZIUreg801?=
 =?us-ascii?Q?hfI5aPGu7Bf35Cuz0SKAiVHZZBumrSJWLXyWnbXIioaTuz99HciipF1yMV38?=
 =?us-ascii?Q?4fjSuV/L/XAK6U4WjXrYIGf0D1Bx3Ww2s/VhGFTAN+N+hxwgUCdbpdZ6+v3m?=
 =?us-ascii?Q?iJKLfbm4lV+Td9pt4rZLHESOkIDSYZOcO2UZYR/UMnKlwkAQyhpvLaW7YhM8?=
 =?us-ascii?Q?QI0Zhw+shWdABJldPwr93naxM5j5zyguWGkyc616EIUTq140YYGnSq0g1TXJ?=
 =?us-ascii?Q?thfHHNEDfjnKIiQztMDjDRl5vR9GeA/ko60IZNln3yPnEvsTMzXD6J6UIruQ?=
 =?us-ascii?Q?g1S+X8s71f0Nb658Kp0nuha7S98Kyoi/pjXJZpl3M4kpClABprZu4ZzoGLkY?=
 =?us-ascii?Q?0cVtzlrGH0P+18z592JEiMnjYCvEQxGjnKTT7GwCJw9ANi766Mnh5amtwF2V?=
 =?us-ascii?Q?VWd1FUZy4rMY0aei8+wbGB3WCNLjUTHvffDS2eTFLJ13Mi8Q5f6wQZqGNsLQ?=
 =?us-ascii?Q?bFdga/4UWrQsvDHO4cnc8PSdIpik6nqJxPYHJl6JmQAjq/y3Xddopnzg+RHo?=
 =?us-ascii?Q?zkF+S4zBHcFeQc1Stbtk+VOeAV1gIGGN6nNbuqJvR9uJPlaAlG1qbQR7vMx0?=
 =?us-ascii?Q?I653oSaj+cWYnQd6A4ivwbQnKNuONm36KlPuIyNxgG411YME9c1mhFan846v?=
 =?us-ascii?Q?Cum4Eot4Hswij7u5yJddbG3Q/zIg0B7BjJ4aSUKTjHHwjRUWZ5aZNaJ1bE0J?=
 =?us-ascii?Q?aA0VyXaWSTr5XFNbGD/gOxACv9myBd4eV6gJXXJ3kxcxzU3HtxO9HaZD3G1W?=
 =?us-ascii?Q?PMklwsX60cYypuDPZ5lFl6IGTLYqkhsk0Hf1lHIs51th4GlDFSJb37xUCths?=
 =?us-ascii?Q?3fXrx+sT/Oo8vvw3Xeo9NcZDd8ISwqKljjpDeIZ/dHbtK83VbQFKbfRSvFmz?=
 =?us-ascii?Q?mWpt6iHskoFc5JfKih9O6M9ve6B7DB//SB9IkBDmvs3MTPOoRkhSjO7V4ht3?=
 =?us-ascii?Q?UDt2vbl1m2YL39pbV6wLWhbTmBxyv1rjRC5ZiJyPWq+QjuBav0hAZaPS+rsz?=
 =?us-ascii?Q?BWLaW5XZf+aNTj1o42eKCJIywlTeLhryE0YM8KRIKgwHBmbtxD/cwGapQbGa?=
 =?us-ascii?Q?a5m0WrUoLlwnKNChBy8woDhdtFIx0srBcEhI8V8iwOiedWj0zQ/8DfMf8S2j?=
 =?us-ascii?Q?Onzb6z9B3MeM7ii0YwE8v9jl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tcNdwdO1wjMZr3ZDLVStgddld1tqcSNswYdy2KCAEwbOsjJ8LZ4a3PpVMxER?=
 =?us-ascii?Q?vZOlF/uHSxaWw3CDnfAEkLBzLH6+tYHjAFI9s9PkDpXsdziNQxMZd2iByHcq?=
 =?us-ascii?Q?pcR+OTgdzU9a612yqb0sReIKPNjGvXEENrQqx8mzlsQPLvijbLi7R4Z4Mzk1?=
 =?us-ascii?Q?uzxU6WqovMz/PYpJ9Fo/vkPLu+diiSXubgCKl6qGxdZL8vbbOQ7InLoSzR1B?=
 =?us-ascii?Q?KF8rEvf/aLEfVNewdGtP7GNy2rnkbUtyIEg2myq/jIxXaSKeEY0+0CwY04e0?=
 =?us-ascii?Q?t53DxTl3LYRTBDlR6XGzYxgeh0GBHne6vPr8m3eaf6F1G2uAfDlvAoh0BTx7?=
 =?us-ascii?Q?3ofFCv0nwQc7HlzubBL1383/mltmxAog7YOg1p4Mqv4zOBBWora85Zg2yYA4?=
 =?us-ascii?Q?10iCadwfmapznZsDdc9wUHUcZ+q2dx9vAWJCYaVO+CAXAKDp6NSWaEM6n1ph?=
 =?us-ascii?Q?RB9Qeg/fecN50oWj5pDyBSN9aDVtmLd2Z44HmeQPzJDPppaCzoROE6t2HVXJ?=
 =?us-ascii?Q?s+YgBX61h2HzAeXtQT9T5jwzZsGCP7rMKldULDNZBh9TFL3xEytTxgBnLhGG?=
 =?us-ascii?Q?07rqjBOdcCNP42TzwSMpYh+TcOGomkh/vqZZpooTOzPe0TaK/0XfraNIw/5h?=
 =?us-ascii?Q?6cigkmdVzCfJ801DzxMzAwivbk0QjTqEDQyTqlCJHE1GTMdACcM5tXKEIKHN?=
 =?us-ascii?Q?KEYOuARyVDiBb50g5OYMFjVKFo4r+1pkLrtYz4kNc5gvJ+A34Aw0fFOZyi1D?=
 =?us-ascii?Q?/u8YQ5O2qR81+FTvCaMm/Q36mvJejaYwj/JhW2ewliuhkcFcUGgQKRolpUmQ?=
 =?us-ascii?Q?x5aaLgx2rdb7HP+DBft6oJGT0Mi1GgyQhla6UB4H1GUQcHHcDXKUo/8jOrmx?=
 =?us-ascii?Q?cSc22TMUTTqAIy+a+8U82rLgVUkgBcSCz6fU/2qoHIQoJEXGnLneCDft2TKn?=
 =?us-ascii?Q?JXD24c6JOTeTtueE/9ZdAevRt0SFZKSGQ1614CbnsDyxEslgbOtgIfMdsjEk?=
 =?us-ascii?Q?EMWxChGBQNFYXigpM4IIJ+GGC/G5C9DNWQqurA9Hohk6SjuPfLl/e841lnaf?=
 =?us-ascii?Q?Cs+HzhW98rFhIgs2zHHW6+fsYbaKYbPOtpONRhyd8gd8E/DRnPbj/vG+Blo5?=
 =?us-ascii?Q?S3WEtStU7jn8iIE70G+maLlR0GtLkhuwWdTr65quxWyZTjEojn3XqXjXhZ4V?=
 =?us-ascii?Q?5PTwsv6ACs1AQE5ZbigqnCxeGxzKMXo2aMsDowxN3ffo5nFlXloTw7tU49Ut?=
 =?us-ascii?Q?xXJ19XGxu06/a4vUFv6UIGwTN/nb8917hdGkEZSh26Wwx0arnQuJtrHjtUm/?=
 =?us-ascii?Q?Xdz7zk7VGWhOVEnrodA6Ft0Z+OCFrPM70z9TyLPWCVqEzi5/TuGeN4CYFj8P?=
 =?us-ascii?Q?EEaBX+DJp+SAryUXW2ar7UHC+AOoTipmromS9qigJMGlTZQSz+cn0IA6Bh/d?=
 =?us-ascii?Q?hUp8nkO0do6sQteGeiuaIv14yiKXAJkpxDkFHWgMA5K+Da7Nat7Pd9vmZFff?=
 =?us-ascii?Q?72+ylVXK7lNC2MfqyLe4iX6EUnuoNbNyaJsoUA+N2PW0jesS0y6hmhaAZbQm?=
 =?us-ascii?Q?kg2A5IVvTcqrAe4+xnc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7bfe8d-fa9a-4b8a-e13b-08dceeca89b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:41:24.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTI+QeoFbJZ62F2/zNKROlvxGyAaXVRNZ301NnYaY/vbIVMOQK68AdRM0T/fb4Pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

On Thu, Oct 17, 2024 at 09:28:16AM -0700, Nicolin Chen wrote:
> On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> > Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> > the viommu_alloc op with an arm_vsmmu_alloc function. As an initial step,
> > copy the VMID from s2_parent. A later cleanup series is required to move
> > the VMID allocation out of the stage-2 domain allocation routine to this.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 18 ++++++++++++++
> >  include/uapi/linux/iommufd.h                  |  2 ++
> >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 +++++++++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 +
> >  4 files changed, 45 insertions(+)
> 
> I squashed the following changes to this commit (will be in v4).
> It replaces nested_domain->s2_parent with nested_domain->vsmmu

Err, do we want to make a viommu a hard requirement to use nesting? Is
that what is happening here?

Jason

