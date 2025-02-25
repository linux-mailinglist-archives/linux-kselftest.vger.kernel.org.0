Return-Path: <linux-kselftest+bounces-27470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288BA44466
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3D63AE0CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251F26BD96;
	Tue, 25 Feb 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVr8JUil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C926B95B;
	Tue, 25 Feb 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497373; cv=fail; b=r81a4b49QuHv0a9BcDg2AzazEabaUcV3i9bSB7PokfZ+/Lum9COORHj3N29dM4vdkttPXA3PKg/55ptiPSqfoIINM+Xd8eYSBAPUZ65Xza4o+2VCmu1p6P0MlpUEwhFWgs62b4HKzvVOdCmLdvVmSR76bkjOkqa1k+vuBOh9BRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497373; c=relaxed/simple;
	bh=5AiiOQQ5Gqe7DWGQkEWknbyy+XSTfF9jHZCI3B7QvgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qko5eftAk98Pu0yb13xDAO7FB+gXPF96ohkA1xIytl0I/wJw3aYzWrx2OY4uLy26xCCZUpLI6cTiybnqs5oQgXvOiQvRhYtSvRi6tVE8I+as4PnA/yS8IJguixrztn3gyaV4TnZqyRtitEv215x+kY9yxNrH1KpDiJfwZezuZRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVr8JUil; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6/dyGrcFpHV6n1zizGhHPMq2srLX3eUVWkFMIaDF8djz0NURe4vpJgetUlSiSjk+01cEmYVE1huMjmufIsKLq24v2Vbrw7ZQjcdDLnhgaF1GrfBtTgZSr7NHO/8BWXQASbdj8WrT83oueHzkF5PmEAlv284AfmiDVlT96jSDDepnho9BW+EMcWQatrW+6sNGABxgx7txrX0KNQhunbcWpnBaH5hBhC7vDVGTTLYHQRxBMP5qTUAAM6CpggvWjmopPtTJj5QEa81pQ41Wbe+q0F3aFl1qFA/Ik98g5fQhkQJ8MizFCIi6c67rkIngLqQD9cvmd+PhFMScP8Tv06+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDB93IlLYsRfI0tBPFBSDv9S+dIan6jPsEbu+dhAzsU=;
 b=ZLsWZrc+2u7h4NCJwfUqy7NlA/kprcK8DllJWJS9gKfAXb0Vu2NbMHkLgifUfX45vVM0wvXiJuCsfDfrIr2MTpNzA0gr6+iHEAOyjUXULvzM3XQmBGyP9O81lEiUHPpc10b/pN+HgUFkdDyEPYBYwcEVSkkYgyIa7pvHGzB0un2rT7Rt6K6WWYQnKeGK/B+O/80v9YiLOH48A6H91PurTRQj/pOZ300rLeD+OiuNgyiCS02/n5/rNL/EeqKssXdDPXjxIUTDNOjh0cxuh0I8ZiF/iJ9zLfpwTdEwRjkrlpd61nC2TKSXDvUg/aNYNgPADpDZph5OGS7H3xIUECYU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDB93IlLYsRfI0tBPFBSDv9S+dIan6jPsEbu+dhAzsU=;
 b=UVr8JUilwDZCPc0xQyXVw41ObqEicfO4cJC+X0QZbn8wGRNXzysJHJYdBUswZXRJR8ZK95npktfV/ssUQhW8Ynf1XviMau72RLziHtXXk/vtuyhVhdwhyVcu7KmH/9W/Z2a7lBNHjS2ReoYoRPecnio7SGvx57hhEg3J/vc3/s50WYWXkBQJd77kUOBjCeEL1pDTEJp1QKcfGiy5uMahmwMOFdubdMCkmv6JQVZYMRz4idaHzFnlTMC7GAk1CD/1GZdpOqvEDAoSSm4hrs0E19cET5caYhDcQVxlaF8GqtEG71zyo5v+nThh5E9tVLaoDYaX/iGBheMbC3vW0BUznw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 15:29:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:29:19 +0000
Date: Tue, 25 Feb 2025 11:29:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v7 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250225152917.GB587949@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <69b6beab203b3546c066fee5e0c9ebe0ee1988de.1740238876.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b6beab203b3546c066fee5e0c9ebe0ee1988de.1740238876.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQXP288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 12890ab2-3432-4a1f-c92a-08dd55b12c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+tbk+SMull2dtqKtb073oY1gLA3StwlTxsw7d1wcRrGW4nhs0GHyngH8L42?=
 =?us-ascii?Q?J5TUaKTcA0i1sJjajZ8mt5grUwLd/DNB3DXK3bDZmL6YdrMaq1mYvC30o57C?=
 =?us-ascii?Q?GMZ4lo3qt2VU8WZ00Bx5sjmSqSnNUEpJvfpc159nEeSXFlNQ5lcn6BLaEF54?=
 =?us-ascii?Q?1d3yYZlPLbaicrBId/S9aNg/qSfnp4opRhxFCHUJlw3/gz0Z/D+uC1UrIhS/?=
 =?us-ascii?Q?aTHJkYvk3zg+hVlgJWuyZ3Bu6Zx1t/oyM7zCNL2+7jTs9vs+pAzxQmB7UUW5?=
 =?us-ascii?Q?m+XTRKlRvLlI8gzhiElOFbm3F78JcaEQQ/93tHL0k+CatLPnzMpEAEny7fGI?=
 =?us-ascii?Q?jCu+bJelf98p/3SLvWPAAXEUBP8glmS4fZVgjigXC5QqUJKFzr2ncDxxuF5F?=
 =?us-ascii?Q?dsaAaU7C7SwVXcBN854mKY2e0k85m2w+t3+xhmY1bNpAiGy8dt1vC9AufmK2?=
 =?us-ascii?Q?lh/ZLPRJZQArAbHQmL33MdIpj1IQP44hGCTh78a2xLHPkU6XDimeUdOL8eU3?=
 =?us-ascii?Q?PQ9GePdelnETEY0vPqi4ZNZIgmtjBSbVRQJjn5sKSWBNSE/cYbwq25CWiZOK?=
 =?us-ascii?Q?ZpNOdoZY+KFsWFLjPaN++wFPx83dCIJAJZ02TTjUwBfY3smDAHY1w8HXFYTn?=
 =?us-ascii?Q?5a5Nl9ydkBtHGh9P/Vyw8pIC0+8EvIe+fwt07L3SgLgjfOPc8uWe013IPdi/?=
 =?us-ascii?Q?7GmZ2fLqcHtvqc3lkKemWyQp8g0AxXnB7qTTaPC3fLQvsyztINPhBUnXjp6R?=
 =?us-ascii?Q?+UZy0SMgf1j6D/9TYBKXd7scXLt5UJWLs7uNz1En3H24rFSAE0Wdo2xGS1PV?=
 =?us-ascii?Q?cnchHq9tm+4+DChNPB8igRFkextp6Qk0MAstb0i4hXuNs9HOyQXNkYwyREqa?=
 =?us-ascii?Q?c6WOVz2qwBfVA/lj78nex23PyP0rs+UG8UMu2nmL5lbvPVTvvz/wlr8NyUj7?=
 =?us-ascii?Q?L42j4E27klXq+DZEJq0q9yqWRsjkShnTFnQZ+rg/Cfroi72xunCMmFJlWUop?=
 =?us-ascii?Q?YAITOYr5Mvmm7efBtemPDDsPPiIm8Cf05f30Q6uIYbj5FTqCDso62HEXdbn5?=
 =?us-ascii?Q?QP3YLH3cKMHwNoWl7ZNclp1TUO231W6uAMlWGmcMQI1pbJdMRikA0tDqjc9V?=
 =?us-ascii?Q?gGFCrx18RbQ7v8Aw5WJs4OY3umbYMQUYvKvyYzR57s3cswxjcBgsx15h2QVd?=
 =?us-ascii?Q?/FBE1B3+HfSYoY9vD3+USgDEQ6pFr+TqJe/NrxRDIci4m+bJSXG75eD3ig3Y?=
 =?us-ascii?Q?/5ddz+/r+WpLSfOkXxRuj/8nqsueiLA+pVxXjZt0Jv7WufbhSm1R3zmURUnL?=
 =?us-ascii?Q?k2iKAbyGkVpo7TMOt3UXMmS/CmgFcR2lY2GuJVpLFd9Y8xr1Du5a9QXIFHW/?=
 =?us-ascii?Q?/3Q6d5dZjV1JXRjclYMaWvcImNQo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7VzLXee+RZgIzMsTy9chVqEKEuRcdAkO8EHu7cITj+bAVrczgC6PnskG3foO?=
 =?us-ascii?Q?NyJ1wauVNNcFPU0VXqdwWVBypaor5ni/e0gbH6OLHMaUVv9emHioICoBTA0n?=
 =?us-ascii?Q?5bggQWHPVWNU/xXyaBg31URcpsuwV42RterznktHmyOw45w+g08p4rOBGdjD?=
 =?us-ascii?Q?msE3ZZ2xEO1JVekgBHBnYMMZHSlrP9RqApPefnUa5pdcAvD04njLwOP1MwGC?=
 =?us-ascii?Q?9X6LDVe/1PW3OI4+wvxigOX+SNc2PhG8mKO815tIf3dI7r3yaEaxvX2OEWtw?=
 =?us-ascii?Q?2Qo3RCGKwvYnI7GEiALe4XeP050XRLZrTp+eOVstunhIXNTrQGeLM7DkLO78?=
 =?us-ascii?Q?X7YTmlUmqmRnVRJGYNICZ97hXZWSMSB6/lc50M6lmaYZ6Es9DW+FzWh2GifT?=
 =?us-ascii?Q?WCB/5GQYayrEsN+xnzuLF19hWtW553omKeso/2bySkLDg+cni1rT3kct9pJ4?=
 =?us-ascii?Q?LdhMCgSBK1nrMfgB59vKaO08B5ptAmD/GgUsuNudy/GTGEJDA7AgG1BOYrty?=
 =?us-ascii?Q?jzJLRy0AskNZOBRPmdBMfsJw/3qv58RBVXSGcZNxd3MhPlhpnSihET2qpKwy?=
 =?us-ascii?Q?rIOvj28MfVQPFO61MxQNIn2/bmm+4jhOUb0Q9f7PSfL1j1jhWGm5Jom9hyGF?=
 =?us-ascii?Q?qNEsdjy3hoOqhTIhrBQRQiNT5RyjV2zkyN5WqoHY+f9Rqzh7GbYYaurmmf2p?=
 =?us-ascii?Q?I+LiF9MJ0vSNPKfCSu7zs7nf7fgjuqRThOWYqLqBAAqgxCOOwt3Lhre7Pgmg?=
 =?us-ascii?Q?vF8US0SkKHmplldmPDIHuWDoCg6tRftEdQK3AhcY9zmGS6d7BJT9XaD967Ys?=
 =?us-ascii?Q?BermEL5yMFgz11Fi4USHx8xp8d01A9wuRfY6V/wuOMuUy+xUs+pWF7W5n7Lg?=
 =?us-ascii?Q?CmomeQx7UVrVxNFRfEoKrJm979XSvYm8N2fvT8AHHUgnaz29Dd3gNECYpfqh?=
 =?us-ascii?Q?g4e/z+aBAdZXPAUtFW9xXXX/ai0e2XCHO3oU7scEMrOopo+BI6W0igSiHgBb?=
 =?us-ascii?Q?/kpJo/RFKAM10+JcP29ovZJ/d4gXi5bGvPJFiTsOD/bB5HZ65woWRR4EqioQ?=
 =?us-ascii?Q?mFliXA/HXU1jnNKV+y1mCAgJmKIWKXDOylCk9DZnl2wZlUa90iI+cgvUxJPk?=
 =?us-ascii?Q?DXiZ2vsd5zvpkm4jBHd38fn5JZLY08XR+UDADw0pmv0wqM6j7ayqEvO1GOp2?=
 =?us-ascii?Q?DfEbNETLSbZpB7yJ2yNUNTWwQah6mbyzZX9gAbqC1OMPsfmtEZV++FQrN5bm?=
 =?us-ascii?Q?trTUJAGDK55GUCMtP738aVu9IXMpINTNdk7ZvNI5m63UGVcSClU+ZTW9+mD3?=
 =?us-ascii?Q?K82UIjE/5XRfA3hxvoJESaxhdsk2/ooxbM6ZGcAVCIUjPFIpnRb27ZfDzvK5?=
 =?us-ascii?Q?QGn++b45lJmpSuMS5pysYsVUBwz5ly5jKcT/AGlgOZGVv8/C4AIE1wnIsHSL?=
 =?us-ascii?Q?6M/75U7DqDIu04ze/1isJJ4VBnfaPIfA6DcB6BstWTM4loCFjxy8qid/XeBY?=
 =?us-ascii?Q?zTMf7+HYyKNEnKe13PiLmi/r5KHTiveuKr9CsyvYYvQX1IsR1qaxZ2aiWR6L?=
 =?us-ascii?Q?aE2S0yO6WV6vQ/Zy2taHlzeuwgZdkS1Z+mPb7L+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12890ab2-3432-4a1f-c92a-08dd55b12c12
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:29:19.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq0XssK1E3F/Cdyomb7Z5SzTj335rjc+U0YLnUao8f0Y6U04W77kpTW6IRox2f0V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On Sat, Feb 22, 2025 at 07:54:02AM -0800, Nicolin Chen wrote:
> Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
> provides user space (VMM) another FD to read the vIOMMU Events.
> 
> Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
> vIOMMU can only have one single vEVENTQ per type.
> 
> Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  82 ++++++++++
>  include/linux/iommufd.h                 |   3 +
>  include/uapi/linux/iommufd.h            |  82 ++++++++++
>  drivers/iommu/iommufd/eventq.c          | 209 +++++++++++++++++++++++-
>  drivers/iommu/iommufd/main.c            |   7 +
>  drivers/iommu/iommufd/viommu.c          |   2 +
>  6 files changed, 384 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

