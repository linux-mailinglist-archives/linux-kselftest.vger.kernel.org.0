Return-Path: <linux-kselftest+bounces-44752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D2C32BF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 20:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F0A3BE35E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34B263F22;
	Tue,  4 Nov 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMR5KZI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D722333B;
	Tue,  4 Nov 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283849; cv=fail; b=Wq3hhtgzkAT6pv6ohqpoGJzILuC6Dv121Iz0WtY+vC6bmaewHrluppjKq7U69FvzZSavqPUcyRVm5OOJ4tTjXENJPF5NqrnvD5Vkjilyxiy6N/c5nQbGVz4Kt+IRuwf+6HeHy464Pp25+Nmtp9/J0it/1DuNKBO0SHQ6OdLX0l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283849; c=relaxed/simple;
	bh=Yqm7duY8SHWGp04OOUeqpQcWHCVO5Ah0rX/1YnW72MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FVTabWeX4E1CVLOzTd6VjCWxornoy3lsmDiDf+d3AEkFfvyCoGUqEemg4SB9SiDukMOjHyMIha/b2jSmf5PE7uDkmTX/tb8qW4PZfqgXJWMOgGYquv5fopukOpRtt/sr95fuDg/cXjdLXW9H6V3X/DkNtPIAEqSAdcJqKnuK5yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMR5KZI+; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oeeha0JstuLp+Y3WNpv5J7GKGE/zITO3z918BJErN645f773mCsY8SYRLmZ74njcCf4GjQiy/RrP/ZEshviqqxJvfzA6+BPCpJMeTHBQGyJX5CtB3goohngY3kvQOK4JCI46R/YY9uJ9HoCUDX/yc7f6DnzmANwi8tqbb/rbWM8B/hReuvC8H8TnTsxFRvpH6yWDjAXyq548ZhWkpJqaF3HXGOySL0XgypYFND6q2HmZmD1SrqILQMioYZL2J3soOMRNAimfZkRFY3UJKrJBjcgbapr7EVo52yi0PwP2jJcDDzvPuxbib7YmLvJMHz6yYgyt/4oOcJzJid4TDFQiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2FdJ7EYjeoVBIWy/EFmK63wX5WUQbL9pp39MVPd6Mc=;
 b=SNRJd+DOM9jAEH9bnIGfazT9aFq3LpGewSx4GpONcq6TkMwzY8R+gS5bJJP5OWqoACFMwdTIOGirmOkYoZCp3jqIlRXY/HGpViLbPZHhYjNWx8CjMqr0vGGo3tr2eGs7nx75D4j6/QFlBNBfuQBzk5z4QUySycDu9mq0GlSVVdWIB7yhEcnYzUPOSLO8f109QsF7h0IpojoJbPuPWjLBZferV56E0dLDprOf2DIFOlb9Wnp6PGaEcEJ4sgXI8i56p9H/yzzDQVkgvS5xjxe1ASlnSbvWGGWLgPueuzGGic1SQWDTHtOyuleqEijTb3jBbQ7sN1Oe0JlDQAq8+2wFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2FdJ7EYjeoVBIWy/EFmK63wX5WUQbL9pp39MVPd6Mc=;
 b=dMR5KZI+l8H4PNDXAHzKE5gw4gJJd4ZbQIHMQcOiVWzeZCtcQ4c7ovI5vaYZHg2su5taUTOAKIGuKNIJIxr1YDg816hYvcWkmp+z1QYxddxLKsGs7U1NFe5f9qps2joy16hdrYRMmnrcq9/aE050T6DFjJiTowL7YBxDXFmCwATJE8ZDH1IN+N4v6TShRcdFVKXtuKQslWsdnmoACy6qyM3gxM696ezLtyuuLqbP6HD/QvHBUaOBagc6xbc2A3JRB7tqkpIaW14+xhFGyM3ClYkNL61eL9+sLoYE4wb95zkpuNpalbvZe/yr2cgHdhkQHhYSdv5Y25oteg23zJ4DGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:17:24 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 19:17:24 +0000
Date: Tue, 4 Nov 2025 15:17:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v8 08/15] iommupt: Add read_and_clear_dirty op
Message-ID: <20251104191723.GB1678406@nvidia.com>
References: <8-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <5c0e6abd-f217-4361-b5bd-99f31c9094a7@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0e6abd-f217-4361-b5bd-99f31c9094a7@infradead.org>
X-ClientProxiedBy: MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ad0c67-b0ba-4dbc-2b04-08de1bd6c902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AwzUY4qxWBadfoJNSI5zbhYnGuGMIg1l1n/CSrfTO5b6cnjatx0D604Oyhtw?=
 =?us-ascii?Q?HXG9WNd/to3BJBdVcyiN8+QISnDJRjGrJ/9OVQfHxJY3PJBZyPEA9qePNSQb?=
 =?us-ascii?Q?m/JCxphWpW628DArx2xhjcw64e11AwaOC3/cwJ5F4bpLCr1mZ/K/M2CC9oYC?=
 =?us-ascii?Q?h39fsoYbo/TxfZJ0QB1ovoQ2ZRwrBYphi76YTh4QOKJwNogtghYsY8hCMfN/?=
 =?us-ascii?Q?WRmwPBkhSyjQ45WkiRzsP3dh72ph4Wud2bz2bc8rVyX7mWBvV/NxXRUK1nJ9?=
 =?us-ascii?Q?lhyGfnU7eF0/ojaqnehYcfqko2Sw+4AZ2J3adbrWtsSMKcd5APWWn//nU+SB?=
 =?us-ascii?Q?KmMC4qGpnUpCB9NVNZLE/pTZqXLkPXHaLPgwoU/CVlnWMJhaq4wkQVgjqCwB?=
 =?us-ascii?Q?JadWN7psVd1a/KQIwu+7KRP8Ar+FQfhZ8/VRc6Tf5a61YWkD3yMonlVW0yZG?=
 =?us-ascii?Q?nBFyQJE/5YLbLdFGNspKCbAyaFtP82mt7ynao8dbsY2o6Tr19R8lOVuue4Uq?=
 =?us-ascii?Q?YbNP6+weeh+Aq4dUSYj2YrXCkiOhLpHavpc30UuG05x45lk5SS91QEKkut2r?=
 =?us-ascii?Q?Wka/CB5bPJbNrZfaf0HhQFNBpIKSE4egDS2CPYN2wKOYYAmEZ7L7os+j8bND?=
 =?us-ascii?Q?/Qf6mjwgnQNfoyMGbqu7EC4iuRlAfVg7YAQQM1IYr9pu0tyG/SvUF3GWy5CW?=
 =?us-ascii?Q?EFbnwJ060JGcQNbxo1jmhj04hyGYAK23kY/jzgzOZkN0GzuNY2ZjUpgCIlMb?=
 =?us-ascii?Q?4H6JQyXhtYGccgYfpxDm7yTUQ3SrY1dXl7zDS5DZZ2w8WbL6x1CT3yjS290g?=
 =?us-ascii?Q?dNvufnpuCaT3N1x6RL+Bk3tcSztpt2C/i0ejhSB4ZuRCEeL8b/zWq4rIgxJM?=
 =?us-ascii?Q?CevpEhg669fqLwjQSXlRd0XHPN177nddRiwKjotS4TW58pXZfxiAx6w+rPP8?=
 =?us-ascii?Q?y6y7Yz7PHGrY+ASLFHfDJ1yBaVHmTb/lJZtr9kbrG8rU8R6tDafZQHoFNVt2?=
 =?us-ascii?Q?fq39hIpNO7Ku0dPAnMtF6qLoIW6gc7F3nGGVD6WQQMZc9cAqIekz+x7BiEXO?=
 =?us-ascii?Q?ZiV/lFsGPnFMwSezs//BgsnXWeBPtPrQqZwxeYxuCQcGDAuGK3bb8u2PCQhf?=
 =?us-ascii?Q?am3zFNRMkaQjaVLFIuV/9aohZw+m2MxLtTDmxYj+lsJ/lzDXe2wiqJKiHK2F?=
 =?us-ascii?Q?0rLqJPkI1HkHm1bt7FtAVqZA1KKBULzrmcrQYKswXLsfVKZ2QDeQ2VHpDMwq?=
 =?us-ascii?Q?ADdMBu9W/JfvX3+xpmR1mH7n8U7cowVLmhukCFau2jtYnEBsX01lMpuKFpOq?=
 =?us-ascii?Q?WpUHTq0qvIvzGq5rxVk4+pIixv6W/1wa8+qN2shOcZIKTQYfTsNaqTQBs7US?=
 =?us-ascii?Q?fhkrW9HW7eUH1ggVRCNukR4hP0dILQaA6xFOXxQ1AIWXSRTprdsig/lBuO5f?=
 =?us-ascii?Q?K0Ei4zOEf5rsm1NbFctVpLbSA8Ov856y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18TkVb1zgdtfkL9fimDJ7i5A2HdErpID/TTMGQmWoFEJ5LHEDj6xMtgNQJDS?=
 =?us-ascii?Q?cLiJoazh7qtBuBm9fsComZmSXvzhPizQj+iFkbLh9ctEjajygGx31VebgAbX?=
 =?us-ascii?Q?2OxSFj5m9bAqlvGhzsnx/3Lyn6b2qjUrS0Hv6jHWA73uHxzNrt14DU0PrIxU?=
 =?us-ascii?Q?SEboNdEYC631pqI6ExFojiXATRj5QVotwUAAruVruyq+hiEYl9x7QwWNP7Iw?=
 =?us-ascii?Q?iUXuWFy0xgo6HOGamqo2dnv01a9QdHk/zp2cjUmavtuqT4CdK0EAjGtbLE6v?=
 =?us-ascii?Q?HuGqirH5ZWk7qCJ+OriTIwVxxCqgVCkrYYPWLz0S5XNENDAn2SmX17YrjytC?=
 =?us-ascii?Q?6xXqzirLXTN+aKN1224km3+ydl8Cr7PrVvJXl1PrLryKwe5gXesryWK0z43i?=
 =?us-ascii?Q?6eMqBTkmKYA108fkp4wF9myAQEweEfROyIeQe2N8VedTNzxOO8yF7E8+bz56?=
 =?us-ascii?Q?AfK536ogXPxvaCrjYwFuy/bNVVKwIYKzxo0bac3LEwuJV7VxEuqncC+wAvmp?=
 =?us-ascii?Q?IKXxCv0DD4UhrxjFP/nZhqmjRzKoTIASbAkM5VaR2JzmcIiMNpQ/1sl2QZyq?=
 =?us-ascii?Q?GxcOYJ16R/kskMhxld0+qv4ddpFV46RFfW8YL8IFpw2/PFrejUy1GhRbFld+?=
 =?us-ascii?Q?lVTgl3hO6zewGAgRuLftze+7qhGoX9Qn36gwR2WGfDJ0TZd2ruzh3Mf5MGUf?=
 =?us-ascii?Q?iWg11sgLGD3JQXPBvlOCVn0TkjKZ8xRn9Gt7P3qPW5Mr08/FYySpWysG3QcX?=
 =?us-ascii?Q?RjwKeZlA1Z8BMtQ5XiHbr/LSeSIKghKbe3OtV9STKh5AI7C6+mHrOQgyoZZ2?=
 =?us-ascii?Q?nk7oZ3ZoYmxmkHzhxWCNrb8nE9t8rCnQqPM51Ug4caE6Md2TXbDKQRAQV50f?=
 =?us-ascii?Q?zu9+ROnS6hQgzkNcIOTHbwxg8f5PdTdSzP9QhJJZxTrtsHkvFLq55s+kbU7d?=
 =?us-ascii?Q?/LMW6T9xtvR0C9qXQpgPiRupnRUeZl1vXFooNaTW2Te7KTst+gigcbIPAijm?=
 =?us-ascii?Q?o8t+x5gqIvkhW40FTguD7AJhoX4QNrmTzSORomN6xFS4TTBackToFMi+Zhbf?=
 =?us-ascii?Q?wZsTAhJkpKKaCgIMbof+FWxKR+43nQ5oPRSG5oovGGeIX/SiAoZte5+KBICG?=
 =?us-ascii?Q?MytTvAiOuYxmoFCXu/Pcaxpr9WjqkzNeFVEUSNuVe08BBU6RJkPsbpvwmzv0?=
 =?us-ascii?Q?gzNOUNW2w8R8RYUFJ5Arz7iO6JjOGBHsfr8wRNF6LaR7mFV02ol5Rickt9KA?=
 =?us-ascii?Q?uo9QW/+aA+AWnwLzB6AoummrUKZyzZ1zPq41yWYvUSFKtb8ToD4cMefp9JyE?=
 =?us-ascii?Q?FzLdslVfItN9O3zForPgQ7s9//d88667DdZuBmzXfj8RoT5P/2+SZBciRfyd?=
 =?us-ascii?Q?6a/x492gwk0r3njSj+DGUwSyC/m1IE+mgS3gkLLwfk/jOGuc5WS+gCYIN0LO?=
 =?us-ascii?Q?oi1i/qE5CxoxAn5WaFEAYQkr4WaUoOQHeJnY293Y1QVZFDzXAr7GAmSPnQ1/?=
 =?us-ascii?Q?ItJc+gYTLUsiHg0coqJbGxwcittq6BKtDcnuW3eVd7L+PNKDysypRZRyye3R?=
 =?us-ascii?Q?ZzCLOlcigQX59xamN/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ad0c67-b0ba-4dbc-2b04-08de1bd6c902
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 19:17:24.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpiX8ImYkMelCMSKaVF59gkXmCuVzu1gqaoCmgxKJzUvSHYFsNdDQ5BDWAAblYNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

On Tue, Nov 04, 2025 at 11:13:06AM -0800, Randy Dunlap wrote:
> 
> 
> On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> > +/**
> > + * read_and_clear_dirty() - Manipulate the HW set write dirty state
> > + * @domain: Domain to manipulate
> > + * @iova: IO virtual address to start
> > + * @size: Length of the IOVA
> > + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
> > + * @dirty: Place to store the dirty bits
> > + *
> > + * Iterate over all the entries in the mapped range and record their write dirty
> > + * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
> > + * the entries will be left dirty, otherwise they are returned to being not
> > + * write dirty.
> > + *
> > + * Context: The caller must hold a read range lock that includes @iova.
> > + *
> > + * Returns: -ERRNO on failure, 0 on success.
> > + */
> > +int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
> > +				    unsigned long iova, size_t size,
> > +				    unsigned long flags,
> > +				    struct iommu_dirty_bitmap *dirty)
> > +{
> 
> Just FYI:
> 
> I guess that a function with DOMAIN_NS() is going to confuse
> scripts/kernel-doc.py.
> 
> From patch 3 of this series:
> 
> +#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)

Yeah, I don't think kdoc is pointed at this file. Still need to
document the function though..

Thanks,
Jason

