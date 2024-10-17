Return-Path: <linux-kselftest+bounces-20004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C69A2A84
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18861C20FA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A41DF962;
	Thu, 17 Oct 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8OYtM5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C221DE4E2;
	Thu, 17 Oct 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185405; cv=fail; b=JJ7dSUp3SWzthNSwbgrKG3RGJG1EPFhwwTGoIhKPEM6O3VrI9CSax+8Y7CN3ZneK7lY9SdTSPFqR9dVTvegApmnPNxVYHlfDtAlw8WMPh+h84+jfaoBnUb7c16k9vsRQOMhcVpL86j/kWALeWB4zbiKXjHyQlr4zb8BN5TUcua4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185405; c=relaxed/simple;
	bh=NBxuo3daYwIiapcZupPhdSYwxUy4UWsrvZWPgnxFopM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnzqTgalHti+IAgyeQol6hJVrhRKLrPvdSTiQJM5eIm15IoLbxy55/eLAC6hvebBpsU53Mfuh1XmjISBm8LMgpB0CteQx7FGwdqmoHBi4Zbwg/n5TysSA0LM8Lay9SeYejjK5StsflS5zXv5cziuLxLsni2W3CKFx/LzHkh5W/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o8OYtM5r; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE1K+UoEDDTkXLSFb5C1UpU6KvLSNiA+fBl8b9il+jeOTa1/feSJix3+VwZQviO7MRzmYgRovPSYeReMwyCJOTi8YPeJFrOxHcxRO62pfAfu6kxnahTn8dOsfEydIhqcX/JaTc9NoITKA0lpMxQ5DQTh96L3Rdjlzga8B2THStpeda8SUwdQ68rraypddk5aTMU2kOnzab3wCMdLsEWNA3I/mYBHadVPGAdB+tupLsLXHZasAPLMxpK+EEoEdX74IJmCO5oDIMhxQRl40uCzQAeAlTTDbp0Yu4sjwdIv9TaNj5Ndi7Yyin/zaP+b7+O+9O+g98S/lt3klI7q3QUqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wcIoj1Pwf/7k+7khT8v5kkLGzSNiO/2zZEn1hWjkSY=;
 b=IRKoILKLcxnHaXdH75rjyOeVu43ZuJyLsbl1qyn/730H5IiEkGMKQzBixFiPYyhfDtoldlmDyODFRFTUX1lUrwgV+a6wpJqbAZ49deMwUr1WWRzZyf6gLBQTGcKoUoYUeM2mTmgwusPyVrQ7y/4XC//6mH1J8+hIPHPuRkW99I4RNs8coQoAh3lFCxMn+neN4bJi7oFLUAyg5uEPVd3fPGhaltslmzogAAu2XT36zwrDaPq1x39FdJ/laz75uyLAORTWmiKbn8jIw+IwyJPJe0c/JVpE11bPIOmAloDA8qD7hw18FdOwXKYp2nB6uuLQlIl2/dmtDQl3iWPisDM85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wcIoj1Pwf/7k+7khT8v5kkLGzSNiO/2zZEn1hWjkSY=;
 b=o8OYtM5r9nP3HRWU6KlSCumLhYGlJRsg5Mnt3ESmT/dCWyux28t1RqEnbqv5cDdUR0SO6sEY7PNrTyjfszub+GMqnjVCZ7oYB/fxTo3OzqQD5v2MVbrAgI+DAGR6ChxmZYKX0n/NCVbxHiwZ4QJ0oG1q2tp+EQDOtvfjZPAUNRNgh9KWhDFJqnwjhLELJp/SMGyXqlqT+ZQyq8DS95n5TPjsIaPY8v6c/M50+CKmpS6uassYwDBz3bnA+E0RpWhyPJbbp9FNBPylCuMuiITa6dm2P6vo19r7OcoSRiB6ZTg9P3R66yVn7dkVjIp9fsaqSX9arJlH91IwZm35GK8/Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:16:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:16:40 +0000
Date: Thu, 17 Oct 2024 14:16:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Ackerley Tng <ackerleytng@google.com>,
	tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
	muchun.song@linux.dev, erdemaktas@google.com, vannapurve@google.com,
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org,
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com,
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org,
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com,
	ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <20241017171639.GN3559746@nvidia.com>
References: <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
 <a63f0f7a-e367-4f0e-8d8e-ca7b632712df@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63f0f7a-e367-4f0e-8d8e-ca7b632712df@redhat.com>
X-ClientProxiedBy: BN9PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:408:fb::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: d5eb4332-602a-4495-e24c-08dceecf7714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?em75bSjEFVM5S0uSbc1lEO3wM2PmaFZFV/hlC1TjaarMg2rxAoqiZNPxvzdZ?=
 =?us-ascii?Q?V7W+/+W2MxhVxLbd7icP3qDE58G157jRIBY5iCNRF3vJ0gd0dgym69EF39Hg?=
 =?us-ascii?Q?r1HLzMPgcV/IR8a4MiKmxoF+K2G2m1d5YHLBnf8LGrHgnGD079I2wT9ynqWu?=
 =?us-ascii?Q?yh/T/yppatgtFzXDcW0AyKero9s6UvPxVHKJTvJ04h324RYGqPrYteSLWYJk?=
 =?us-ascii?Q?IuowHaKbWQhQEdcn9TbAAvSFWZgaBI3rGL5EHDo2cpwaAoaCuEUpZhAz8CGj?=
 =?us-ascii?Q?qUTrh97IWoZV9txGJqPbavk7/BeauXOCbkO1mP4+TcGx9JJotN3HojtpwHfG?=
 =?us-ascii?Q?2LZNFSf84pySDnHmhAwri4BdFacxFYU8gmNEwQKmPPJ61Dn7QXbvBIMA24cf?=
 =?us-ascii?Q?aB7+oR4fcyxRZjxHV+RBk8v6GyoXh7uldnGqQgaIvtwV0BOXFxIF+vr4gjlb?=
 =?us-ascii?Q?dl3vObAuK+wAC8Iu8Zoh9/OtBAQAkGb3AL2nr6NmHdlB/OAwo36nmOM6EVsh?=
 =?us-ascii?Q?H9Tb2fJj3HZ/mVQmxM/eLbqw75A5vcXcg/d65GrXE15W4fPv5MU14kerF1Le?=
 =?us-ascii?Q?VHM7kPS6a9SfGOWcXfJ7jU+PE4xWY7iSASEsq9M0l9hvxhfu+BUpYKV/XrSv?=
 =?us-ascii?Q?oJAkqOTWhEqdvzB+a3ECXqdnzwf7Y8b0fFGl5so2l+e7GcGqeKMC+XRsBzuq?=
 =?us-ascii?Q?bY/fWGm0lHInK18bxQv5GViVOUytI8Y3nOFeSG2NZ6YptwNvZEeOomK4l2g4?=
 =?us-ascii?Q?DMh2pIyE/7Ws63xhmfzoZsnbYGo9xkw0X5VGuEuoOx4aNP1N5KWuigjVz75V?=
 =?us-ascii?Q?egrN+m9Wq10m+/X3+UorRwB1UFROcUU+g9oq5LXGNCLn+lKmETrf2LVZRUr1?=
 =?us-ascii?Q?NV6RXGxzMVJEtzysg6n6Ve2XRwHZSt6sjQ0H8ud5cv5nTOjyXwvJd0SoHfQR?=
 =?us-ascii?Q?aMBQExDU3WJf2mzIFo3LSYT2mUIAXGn43jH2Zs18F7vmj9rs6B1w09oKWKdA?=
 =?us-ascii?Q?ia7vTnganLl5CKJSTpA96ac5h2n5cQYrAVl9BXN6IWRzf165QtNkty4VIP++?=
 =?us-ascii?Q?H3wDayjwXlqYzPLP9uSj2qnFAIM5CrtlKXwxIwDOcMyyt8+Ng7pbXIvIiRUC?=
 =?us-ascii?Q?nE7vDmF3mKekd8zQL0U/4kDeB5LKolIuw817c+fZ2e6OzT1dURKXxODiOo1v?=
 =?us-ascii?Q?ZSbD2VpXbtAPLTnzzz2VEAy/olRBuTxg2zslhOXZHuWoMkY8G2CoJZADbQ5+?=
 =?us-ascii?Q?vdTYpA+mPlC9KXACiFB9Ye3W6kIgrPvWLLhQKUc9bKmDVrR0T/i7tSwlbDDn?=
 =?us-ascii?Q?dug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEekzAqc7qAo30rMexU1oR+JgD1Xj2H9+cpOnaweeqloZUszWMK3ioAJINcK?=
 =?us-ascii?Q?vFiOkYWJnCT0lGjxvrp6OX5CaHpFvQnNsrIOCcOc5jXIRVGwxbKsYXObZSSX?=
 =?us-ascii?Q?1h3Qft31yJKHcc2PGIP5EFn+gaIXaLGXrdm0lre2Lo3R9dHJU1jIQkSzUABM?=
 =?us-ascii?Q?OADoIQ9EOPsc2y1ZLraFRR5aHi4b6ci7ybVMMiFCaOjpKDqmq7tkREq8d5c9?=
 =?us-ascii?Q?6u/Z0Q7PgoRKWo52khq9RdiXbajNUMN2sLxZueMQ17OO5VD+gtvbbyIf3Ctd?=
 =?us-ascii?Q?sc/8MRs+YXGVBIUUUhZPFLDdZWGk4qc/kJaquU0Q5eBdsW47YO7IWqB38X9C?=
 =?us-ascii?Q?IUwgKH7+Hl47yPxZxfMRM8T9dCC3nvxbksEZ6ATTJUeWy2tkq61i1YzX6KFH?=
 =?us-ascii?Q?EEOr0LA4vJuuLLiXnwOr3Qn3BuMwzr86UJtedgKOsiq3q054XM0YfysOIL+H?=
 =?us-ascii?Q?+3oJ21cyOHRKCWg1IErOutCJI1XoSXjjPAklx9aSFp+i+qwuQFeB5C1qdhiK?=
 =?us-ascii?Q?hnBe+hH7hFYUT11c+rZYVvhb9XKIhnBbZLDfkoyI3+5UAX4+urpCGqthXMwM?=
 =?us-ascii?Q?0WMOOTVS0HGEfdQ5qzb+x/7C0T1vKrlr1QGU+m4H4bgrS214S4GTA2t0Wwth?=
 =?us-ascii?Q?+PKaqAUoapO9A54vZh0sDfUYOX54o14/exvlHpbbv3gtHp59OUWv3eyy90Zi?=
 =?us-ascii?Q?kFVRsWJNCCjdUOVi8p5Paeb0vcLz1QxewuCEB9Z+FF4dNEunV9WBmPt63LI6?=
 =?us-ascii?Q?vA2+eWXgO0dVElv6icdhqTEsdspy23mwGAnOdlxZR5iOBN76PyqanlyyNViX?=
 =?us-ascii?Q?RfG5Qtfd9i6f5lU6wlk33uOdyEnZuKSqB4eT207z7Dmcy43VT1iZA2zWj72h?=
 =?us-ascii?Q?UXUKsB0LOLSIL9/hSle5w//+4XXpquMmyKpNRUyAJTRHcZaFKut1tWuOq1BN?=
 =?us-ascii?Q?/RaiCEXYLvXPcJtSebN/kkNwy9vvwMvUETLTjKwTXgMb4GBThqf/F0SHdc5q?=
 =?us-ascii?Q?iE7SghtxTQ/l8zvPVjXyVIV2oYQi/gr07os5pbHjDcjPdlCeo+/vGTKpdRWr?=
 =?us-ascii?Q?Hmh4vkQWbFQNHqUmcwwkOEzYK1hYppCQ005AwRLH+Tqe0xJWiKuOsQH869QE?=
 =?us-ascii?Q?DJZPsrcSd4O+9ZQm/zkog3QCENfhrVYAMv4Ls8tyfLvx4W3Zpi6aPnmIo5U7?=
 =?us-ascii?Q?3qHHM+STN0oYBQWFd/5mkuDzU36oKwPxxky8mtmTvqH9uVy6uLenDcbxabMu?=
 =?us-ascii?Q?g626lFYB57HKVTuDweBUipkqHtW9+KfMreeZAxjsInezD2UfUmF2kMGmhMku?=
 =?us-ascii?Q?IpqgizJTMo5429OC2AARovzpodbv+mQDysaqBgkCqAHqVo1D0CqFsLtYfXoT?=
 =?us-ascii?Q?iL7Y3icvNVYmvuh1I85KW8MXn+jL4rskTq07UtzLJw7AUaseEpqTnVSpkptO?=
 =?us-ascii?Q?TK6Moz/ZFzPqIDDw6jLQ2yZGnI0Dvox6CSaffdyqtZqW1Edu7cwDVsETbQLA?=
 =?us-ascii?Q?P8A+zgaHG47suIEj3zYwlHNNNyesnyzFodvO8sRVMLK+4Eb3rwWgik3UPi+c?=
 =?us-ascii?Q?YF/3Bwvxfo2EDC1/3GA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5eb4332-602a-4495-e24c-08dceecf7714
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:16:40.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp/w/QLL+KmEBmGFyvZAJ8uh9a2F/bMbe32UJREvyA1nQXTYnwJr9zjm9AtWYXWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

On Thu, Oct 17, 2024 at 07:11:46PM +0200, David Hildenbrand wrote:
> On 17.10.24 18:47, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:
> > 
> > > My question was more torwards whether gmemfd could still expose the
> > > possibility to be used in VA forms to other modules that may not support
> > > fd+offsets yet.
> > 
> > I keep hearing they don't want to support page pinning on a guestmemfd
> > mapping, so VA based paths could not work.
> 
> For shared pages it absolutely must work. That's what I keep hearing :)

Oh that's confusing. I assume non longterm pins desired on shared
pages though??

Jason

