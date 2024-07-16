Return-Path: <linux-kselftest+bounces-13786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDE932DC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55A3280D9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6B19DFB3;
	Tue, 16 Jul 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgkiTmL/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829C1DDCE;
	Tue, 16 Jul 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146131; cv=fail; b=TNPm4Q7fc8hC/utwGrSOhKPtym3MES4Rnm+IyNJUZgTIeNx9PLDTPsqTsLZvC/qSwyhuO3O/WiFJgyW4WLdhCI26uNpZBBbCSzTwDKjiu+Dx69yKTQC8d+Kh3HYzFT0sFM5YB43va6wFgi6+qG2IbXZD8WPs3SNWS4jXvnA/YcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146131; c=relaxed/simple;
	bh=ehtM24vnX5HUGlSkEVnpUQxZVqS9bibu6pdUNz1r+74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=do8wK8nroNBVlqjBW1BhmIDh8yN2JS2cyZveU9SQWUyf1vfjbFBstRb0MxqoWWfMkTc0hwXP+Q/seKTTJiOjKDtuqpWPdXtrhh4Hob7qJPw8GXiY4EjuuexOP2y/sBjNvDUrXcEso6mh1S8qyAuro2LI/yY+kOaYdoEBpkYeyzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bgkiTmL/; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrPm/dStiPKBJun/EHCLVmpBVv9QDrb+BO92yYPywro/53hgDxb3H2gbdlpAndaI9aA2GIVUN/MWuEQacBs79HR+WZFip0NVfXUyR6qWfK+v2fxzyi4VvMwfYpjlHIGEXn8v50yvXkIG/9Ii0AKZZCD1HF8iomn+QUg7Ytw3Be0syM/DRs1HcqLJbUvUO2ClTDvCxzbEr1lW4HVJy20Bg+LBNrZMBTENZUWQB3XBKdhLEdtkgHf5oTavdh+IBaDsM4YnlbkryLABsniq63FKYfekfCN55K7FmYoAkLwhbDEeGJ9o+/nvA2bkhx1PQC1gsz1ROYIGOd8Rpsqy5OJ2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL8aK2DcD27A96vmhuZI0qzMSQONWHchgTrHcD4nveI=;
 b=VLgmEYgUowSAxzZ5/emHfkXFxf2uf8xgMwkJKoD/oa+jpvf3Rib1EkOMZsA39esGUPNz0dcbYLtGc1WsP0uECyKudqsMIQB4M9SEy+NDqoQBVEPUcqQ4zPyS/bvt/GCWQ4fH6ZmnvlNLt804g0ytbCR9IjQabZefeNyNLycBYoHXh6ixr0wEzPnJyT8NWgaKi2D0zSVWHfU597MP7ZDS5RM8yqL1+rozBto4+zSFH/IjBfK6Ne/4hQl2FTeyKFOdG8MnHJPhuTwHw/fvO0D5M6N0DG7CIOYjc97OMFRhM4dNtNRMeQlBMEzuu3ucw9tPOd15tYYMsGwFhwJ2eQRHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL8aK2DcD27A96vmhuZI0qzMSQONWHchgTrHcD4nveI=;
 b=bgkiTmL/hJ4QD4m+o6ZuAj/xlGyXTAjz6fVwfJfi6dSk7/iGZVb4EDRq4CdXG8Q8bOuXSXGM4yCbzbO8weRlSHkgHQySOnFXg+4ztJp74gYjVeNnI0l+fEd/7+d1D9CdGZsA2EYZnGARIN6OzUMYr/pTbxpmjQ+vn6xtDM/Iz6OStiKh28oa7EkMcpAFxmh2mHf9soaMGG2ZbtLFO3WVq1grDIUVgU31Iww/mHfvhC+el/gtnWV5Jb2x10T+Kot88ICseDI9nHOFiXGAPpQXWq8kT8Xf1/+HmUgtxY7Nh5Zx8T2i9fJIEn8apO4ZG247qopj/sQw5vU7gDN5gObktQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 16:08:44 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 16:08:43 +0000
Date: Tue, 16 Jul 2024 13:08:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, quic_eberman@quicinc.com,
	akpm@linux-foundation.org, david@redhat.com, kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, maz@kernel.org,
	pbonzini@redhat.com, shuah@kernel.org, tabba@google.com,
	willy@infradead.org, vannapurve@google.com, hch@infradead.org,
	rientjes@google.com, jhubbard@nvidia.com, qperret@google.com,
	smostafa@google.com, fvdl@google.com, hughd@google.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240716160842.GD1482543@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <20240712232937.2861788-1-ackerleytng@google.com>
 <ZpaZtPKrXolEduZH@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaZtPKrXolEduZH@google.com>
X-ClientProxiedBy: MN2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:d4::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3883fb2d-dd7b-4dd2-321c-08dca5b190c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+jRlk9L3mOL9ATuCMWCbLJEjFvBEAn9a7j7kODPezVqpYgHLzZJ3GNaPSMC?=
 =?us-ascii?Q?+70mXMnfFQjyhv0cZTQl5QiK3XoXvf1scHs8mbXNWN3dV8TSks9bqw88e3IK?=
 =?us-ascii?Q?qD/cXDTAVVD1esuyu2gtUJr7urDfP9NrpOJk81cJdD3SwPHpj1FzYPR3mlz/?=
 =?us-ascii?Q?RoaGMc/OT5ECU/ROoEq36pqaCKWzkgRVm6uzKu5O0+fPScUMI8CXTnw2n8bN?=
 =?us-ascii?Q?Xn1LKPr/lK3c0TVpB/CWtfzsy2XoWrfk5ieq/zje+vAa4NTUD+ooVRo0AXVR?=
 =?us-ascii?Q?VyZJtA+YKJfSxMoebgTHoYr9XPC+7/BUC8SgppTg3eM0p5hgakCOtZ+4j3QW?=
 =?us-ascii?Q?YOqrIjf6WyqxgWi/FzFb0Y9OqaYs6mdRZ8ao3FL5WoSo7KARiNonUaVakp+R?=
 =?us-ascii?Q?SkDBMnkU6ZxV3z8rw4zg82ITPqgVPC20tFxW7DiNNDOPi/Ml2rAygR00CccC?=
 =?us-ascii?Q?iHL9c3NGKJDhI26ZdR2R2fPLyYGe4iAXW3eakKc4imjcJ39wlBufxMM/DYZA?=
 =?us-ascii?Q?SxRwsOh0w5ryOe2rOzoAiqi2lZDj7VoiHtup6Oo94v6FNvsJEHL73gn4CgUP?=
 =?us-ascii?Q?EyFFa/YRAHUN2HVSrk3Bbku4l8T3LPdzmW422Ka64WjXAuAdCj0QrPuhKGVC?=
 =?us-ascii?Q?pYPX7U91hsjbcx54SdArgoXTVSxAl1TnZh6N7Xy6GXsZoEemVIWKaFgd5G1y?=
 =?us-ascii?Q?zmqtU9tgX0hhOPciKQdYTgaITUN0Ud5ZkSwC7TSnkWKn++078FmL2yTOiaLz?=
 =?us-ascii?Q?SFg78/Ebx19ypHLz/O6dRsib/ywnSk3sEyXZe7weT84uCj5o4WQ592GIo1sv?=
 =?us-ascii?Q?wgcQEDWLdnMqOQRFlIdMekCBDGUf3RbASEB47+Ajm1+P430HCns3Tx6ydd+z?=
 =?us-ascii?Q?+kh1Bemii9H0gjyJ52YP1Zahp3fmwnqAoE9zmGAumbjsMUljBPuZCjT3Ypl6?=
 =?us-ascii?Q?fMRvWr7IMLIGzIuchzdqTOlIovQVHE9L+u0SrauenUVzUYUNkMD513EU3ZWv?=
 =?us-ascii?Q?dEnzFRf2Rk6elIb5SVLoO58j7y44DCqCEekSsf3h+RXqHUyPWgxzC5RH0lV8?=
 =?us-ascii?Q?OyAQ/YjaKMBf+zL2NWNzlARGaAhBcyEEEzpMjPkhBEyuXgMP5CT4T7kNX/Xy?=
 =?us-ascii?Q?lUZwXmQVNwjy+uZk/2KZ23O16w+BJQch7sfYvA7MjEmOdyNqXDegH1gI+zPJ?=
 =?us-ascii?Q?grpV3jefYkUzNzPQ1LYlNjjlDxFkyD6vmGSD6tEBS0Z9b+rpl9dibLOtHv8k?=
 =?us-ascii?Q?r8ew4XHqIZ0oOPXtL5l4MQefWqzaR4wd2kOxK2Mw2HkoYTzMbPD6sghrBKj8?=
 =?us-ascii?Q?6xwJlSXXxnKvGE8kh2kGs9KHNpqJJuu7+sD1ESeLhOmdNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uSDr3QUwuaPXNUTq1H1Jy8BnH3NIxpDaEiT8DhLlQkoIA3/OI/n+lzUQPRK?=
 =?us-ascii?Q?WjUFN+SE8lEtK7zWwtt25wfyrmb+5aydcebsLYJAjwFYZxubcgQwP7eG4WYa?=
 =?us-ascii?Q?iOc5dD826U4p3heIlcIRImf+tfIbpNua+hDlPQYXpjSCEg5JkE4LHKeazubo?=
 =?us-ascii?Q?BFTB6JFbWZvUf9fj3j5AFhhw9rGdfbdmy2ZcBuE7/zz8ViPO26uhKqhapqfd?=
 =?us-ascii?Q?C+xhipwKkMGBuiSy/vTgMJROPPdhgN96QpWlyxij+HQge9X6M99k6DlvycfY?=
 =?us-ascii?Q?lFUHXVcgUaLKe19z2Piidx+AHgmEZB1o4xjN/AqCumXRygl40/gzxxE93SjJ?=
 =?us-ascii?Q?NC3KM0r7I6jqxC6JX02gM3EGKyEInSHrhFqdZTM+xChgyxnOFZH1pafbMkNI?=
 =?us-ascii?Q?kX80JKdh53Qu3wcCFuk9moA7/JgG2lekHbavcWZxRjA+gW0Mf6PXlyVNrQX4?=
 =?us-ascii?Q?5zFHAeTZxHFbBVdIO/NzyVIoW4PlKikw9YLmZxemZ1FuSBkDr0fbmU66q5Bo?=
 =?us-ascii?Q?L+8JV5YtW493bZkLsXvH8l/I/PXFGAA/FEUcK1pHdqNrKYo3jCnod3/hm1R/?=
 =?us-ascii?Q?rhtiTYoFOBM82YS22gtdSaqxckbumLandW6NHum2+NOr+rt81Ido4zxt7Vx4?=
 =?us-ascii?Q?1hMhDC8ckJyLcIPH5IJ+UlytYmH7M4OJ0Dv70FMrzGu2p8GUHfB+ASNXWVpn?=
 =?us-ascii?Q?P66S5GxCp1nUA0mGFGtsGhULmUrYxRQ2uBpUp5ssg6Hjzn4thzDSazbI2vc3?=
 =?us-ascii?Q?ofP4E9gVX5OHffz2KKvccp5faIOuKzGkx0SCcHNUA04mzPGbB3GGIvWkR3Y9?=
 =?us-ascii?Q?8NFkUcaTtC5iGTSwUOOVFQuXej9bJ1IxZHu0S+YheRKm4ykKch0hl4EH92aB?=
 =?us-ascii?Q?qgZvYJ+RI3jqhzwZ3MvHytCHr43IT9Ko1JGeznR9L4+S5IQjCJIYXLs2a13L?=
 =?us-ascii?Q?IxN5lGR7vjjx2nfGaNIiOxVQLdCw5t1113Bz6zKuObf/wX6oTLJn0mbvnU7G?=
 =?us-ascii?Q?qv5uVOYcGBQFn93Y2FnWzf92XOX2Y8MH7p8sWDxkwqYj+BPXL4ryQqFx5R8N?=
 =?us-ascii?Q?6AZD8M0ncx1wW+LBxqfR+cx7BbjPoFsZUFhyUf3noRPKMvAaLnBmmZP71W0X?=
 =?us-ascii?Q?/JcZNyP/2+1QWfCRvN3k+8Up1fmaeCG15FLDAPLHJWcMJPVtKh7qYfQTE1fE?=
 =?us-ascii?Q?e36pFsP51cbgjxJmzaCAUZeLsGh+b3wWW5ATiDZyBcdKmDxJZ+P5WL/LTo25?=
 =?us-ascii?Q?ufHrpCs2B0PDC3DPNcWNiaV4uka1ZRBh80TZAgdbTChCVBUklQykLXPFylem?=
 =?us-ascii?Q?IS6G4DUp/vAfVc2bpj2XZTKUgmPTJinzs5yHIVS1ZIbpvS+XOHCZVh2FCxbk?=
 =?us-ascii?Q?7uRhjfcLA9NZSl55lJCWnslGXh8L2RsrcdPU2ufj3OuQfIUONLMXEAQG3kwc?=
 =?us-ascii?Q?jR4uF91Ue5PtCDv1w4qX9xjU4NaClLj9NE0aOUkGqUNeFFpGeaVFY8+Mydzr?=
 =?us-ascii?Q?Fcw4HZ33ZeDmohC1AIA4qq5VnGjJBSX8BEIKxeI08JA9Br5xHbkynDS3WwuU?=
 =?us-ascii?Q?ooz1Y4ZKZcIpZvGlWOSB5w5bWbxvtAx3t6ir8D/1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3883fb2d-dd7b-4dd2-321c-08dca5b190c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 16:08:43.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux6IFTh1L3AiaW+VvMWFow65imyMyiRAQL1eiPT/KjpqFlt08RVQsYOGfTbgaRoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

On Tue, Jul 16, 2024 at 09:03:00AM -0700, Sean Christopherson wrote:

> > + To support huge pages, guest_memfd will take ownership of the hugepages, and
> >   provide interested parties (userspace, KVM, iommu) with pages to be used.
> >   + guest_memfd will track usage of (sub)pages, for both private and shared
> >     memory
> >   + Pages will be broken into smaller (probably 4K) chunks at creation time to
> >     simplify implementation (as opposed to splitting at runtime when private to
> >     shared conversion is requested by the guest)
> 
> FWIW, I doubt we'll ever release a version with mmap()+guest_memfd support that
> shatters pages at creation.  I can see it being an intermediate step, e.g. to
> prove correctness and provide a bisection point, but shattering hugepages at
> creation would effectively make hugepage support useless.

Why? If the private memory retains its contiguity seperately but the
struct pages are removed from the vmemmap, what is the downside?

As I understand it the point is to give a large contiguous range to
the private world and use only 4k pages to give the hypervisor world
access to limited amounts of the memory.

Is there a reason that not having the shared memory elevated to higher
contiguity a deal breaker?

Jason

