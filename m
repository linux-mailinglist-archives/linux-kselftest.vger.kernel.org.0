Return-Path: <linux-kselftest+bounces-34385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF7ACF4B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D9717435C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BC27510C;
	Thu,  5 Jun 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuth8JfD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA36275104;
	Thu,  5 Jun 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142172; cv=fail; b=KA/c4z7ItpyQCz3xiTHlbSqvzb7Nu3WFH101iSyDldtlkiySUFdUCJEDiIuIff+AFueUVlvilTnAgg4LhcgtIB11NMwU9M5bUYSzBe3mLRSuNRuZkAiu/HnbIMmyoqzuGWj/C42/BpJXZaQp2HLfbZ2yHX5kc7M8FJZRwNVtPVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142172; c=relaxed/simple;
	bh=36OjYUn6VjpPSXOJwyDcND0A+ONYT2uI8/PIysFXssU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1tsfaSd3mXtwxDfQLVEHc0NAGn3ZQ2jf4LoUDNAm6UcUXQHEjeUOgSGqd0TvkmucHmvccPCr4LxtoosUxDwoqsQE0xrS9dVRHubloFErpLbEzzdDxA3Rju9SM12tM3qbDJltcYZHxk47wmFsDsVfbETQ87F/vCwTdvfGALSaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cuth8JfD; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaofXNhjyzWNw1do3ReMLzQ+3dazdz4tO37bvSOhsh04oWXrDQVmd281P8jH60UF7ImHtukSZP1NscEQTJhhCuV+kPVUzX6xFjvbXzOuJ9hU/V6/0eKTCg7sP7OVyoBV7q+34NCDR7IjEJawrF+RA6gf89H+u5BT0MakSBDN/tHHiP4c8cdGHUptrEKbn7hoemlZ7eL+PvKU3WSoBGJfa2CHsIqRgNALMiMhqxBwRj/+0SEMOyR4NyjE+ihf4MwYos3g2Kunpb4WVH4AfI+M+jjuL41gXH9AncA0HtAHb3IZcar6NI6QqeyAYCrIaUPIG55UGL1DwXCtnxAGG17xQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmjCw6neWPlSrp48D2uVzWngWwZ+1CIfsEbEJUrJx7U=;
 b=tjzswF4nyoeiOgzTQIQMyCQA3pA5/dYuS/rpQ1XcuCLsi2ActVE9M2et8twi4JPpgR7KHBOwYjhr2/CMp97fV3Trg3CR0fCht2sh22pvfEOekRMwcsIOl3Q0mUti0owp+fZ0IZkfiMCasaT9yKKcuGxUwc2U95POAU/y0Ieceqc7Ai5c9XwO+maeb+GlyQiDRf/pAr9ceq+EPkX94F2GGzv/jYH0Jka4oqCH1I9A0ib1fXL7oltcQCyxMXiJShoZHYT8i681bkRsP0MKQpVAt4Ji8qY//TxIUoLEONCpYNLvaRx2r9S/nAvValbT6XFBEMfFS2RiR8qrGOXKTgbz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmjCw6neWPlSrp48D2uVzWngWwZ+1CIfsEbEJUrJx7U=;
 b=cuth8JfDiqrlARjy9CbIKFVJA/UOT2cV6H8Dsp+8BV2xuzQalxkcaMDJ49dCAm5yQ8ckG8tFcmOrKiDSMFHQQmcBYvu+ulmwagz1Mlz+fn3s/4Y9thv0D+8mL2aFQkuW8Z2uhnfsOMWs8UnsLfNHgVtStw8nDFeTItc4KDLiMZ4PYanjpDmnstHUeu7IzDEdSAXOh7/6H/xFii3jqITKNaldCIXwPhSDGGC8PS7fNedU4LzxM2jZlDo1Ga8J4D5axEqvG9Kd8LyFFH86uIOB81VYiHcKoNhV38vclXyFuGWTfsqNzVXHc+765PWGCaHDcwJSLcnva/IxRRV7q0uBYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 16:49:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 16:49:28 +0000
Date: Thu, 5 Jun 2025 13:49:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 07/15] iommupt: Add map_pages op
Message-ID: <20250605164926.GA64967@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <7-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b92f40b-a253-4f3c-4683-08dda450ef73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GAtsaPuohfBP43Z7nRerRdpNa/ygf2qRpBA3hvpd4ihhbzHQdKXlOxBxvrM7?=
 =?us-ascii?Q?kmtfeHT6nxZ/owbBJOlAvwVdloymCLa51lPIjXzgfWL/SCcb/dBz/g/yG7sA?=
 =?us-ascii?Q?YumD6Xm20BTCVmPSgRWmtZp6rqOK8dQ/BNzcCRV8c2JImOroc24z5w9/LHbf?=
 =?us-ascii?Q?DUbeipOlk8vnvjrmHdk0MSy+VvPlZY0ZCzzhJFxu99VGD/a0tqt6LLf9pA8a?=
 =?us-ascii?Q?iABnd/Ev0MEdc31XRsZpEar6n4pI9NOKJSfmQ7s80IEoeWT6QA1p3WaSeJ9N?=
 =?us-ascii?Q?uq/WPPrKH0j3RGzppngfOzR2N0sMfoLO6nkRHIHl0znaTilPl+JJ5yhMqyOc?=
 =?us-ascii?Q?gmWl1T8LUpwTVPBPxaozXTI0kxs4kqFkBJAH49KwlUeHmUlioOc63kCvdud0?=
 =?us-ascii?Q?raIyZZgIg2qxZHLNHJf+kaVuTkwnEPtXfUNY6HSq68END6qgkQJEuLC6nqan?=
 =?us-ascii?Q?XaMDL+5Bv69U1zxizdgjMUdSCKIFMe+htgUssqsBQriDJV9B7+MGnyk1uYov?=
 =?us-ascii?Q?fiW/XDg1VK++ZZrbYXHAbn5ukkSKG758Wurg/DRC2PcOedSZ+vU7Jnmexe3V?=
 =?us-ascii?Q?lkZvqXarXeZ+LHhnMmm56npWObUBffoXY83IqYxRCboS0x8bfdb++xNazFke?=
 =?us-ascii?Q?qFX2IjOHfDe4eHQug76Si0gqoFu/TuaUA51iNIoP4G5APBKHHohZDXqkwwuk?=
 =?us-ascii?Q?dxjbrYfPMMzsP1QJYQJ5WKIpBfI3PIg0V7EHSCslTZ1rPMihYoyWkcPVKJsD?=
 =?us-ascii?Q?RK5MMzHhL5opWMHUoyNMhm8u6GHW3IEGLn6KdzWPJ1k+0+PnPZaDClGVtUWi?=
 =?us-ascii?Q?KQi4vMcZZVWpNeFuv2/PaDyRur/gwzujqx7V9zetK1HZ/jG/GFkBrmguoZHj?=
 =?us-ascii?Q?JnnTLo5ZINPS5YCIDoGwPAWElRCvXAqWKWwCxZZDmATJjD+N1csKk5bfm8un?=
 =?us-ascii?Q?Zx2OXtQ6mpi/cq2y+FU5PFGi89UQ6kRkt9h96aFQ9a/QuwJisRTNI9xa995z?=
 =?us-ascii?Q?o8wvkDAZnuzPZ+N0BQWKWT/2i31eI7SkTF35pz3nqPOV2NKtn3lujGFq0/bl?=
 =?us-ascii?Q?bAaX65221IAXveZjcfjsG3JS/vZUoEz9A7v1QiwQAQ3QyVtWclrPIJ6Ks8tl?=
 =?us-ascii?Q?SNBEfCo1Qv8PXvmg91oah7mCH4kZYMguKeJ8Mn7KxEZPgVz2IpVv91azYigr?=
 =?us-ascii?Q?t5cpXd/ED9QUhhpm3+041roe2SfTd9QubW2GDci21aJ3+yoLabg95SuebQnw?=
 =?us-ascii?Q?hBO1zLvVUogoZ+9wrClgvvRxi9U8qZLgo48boR/kpM72gzF/2jNObBVIuBNi?=
 =?us-ascii?Q?dnmadgXPaCelkoo4UO4u+PUpo88xUE/nE5K4/jVlXx+S8MseV/ePI8Tncyp/?=
 =?us-ascii?Q?mad4m6BKrS7FoJ2YqM1RLlRzGns5GEXKyD33/3/gTsBMZK4oU4oF+Z7+sJT8?=
 =?us-ascii?Q?ZK6iAq4KV2+nuBh8ueY7f44ztArNhXjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fTpPIgbKFmj5deJtEtHXI4yLAPsgm3GMAyMN5jHYvBXP13VIIGXcgHO90tiJ?=
 =?us-ascii?Q?TLA9n4fjZHa2uU1wrZwIym7+aqkMFQg7MLpKXQngC8oosj1+krE7bP85UV5Y?=
 =?us-ascii?Q?+p0UUZl6TYe9pTUqDe9+GmV+39wE/1YPyhIBji5Xr8eBMNLfg/USMKc28kN2?=
 =?us-ascii?Q?bMnZwDBvnLYIOrnWOlEcI3Q9EYV5te7cNq5unNZdJIByYoatRJon9OaTDgf/?=
 =?us-ascii?Q?NuEHp4mKrbRn4FArlFSvt8C09fciJjI3h65tVe4ia+ee2fTCcZo1C9zHzt2c?=
 =?us-ascii?Q?zGWZj8C0E1no6zFEzzuuv+SKeYJqwHa7JrdgrdRLlpGNR7jj7HPLEJJdUubg?=
 =?us-ascii?Q?EovHhLDvxysQiv8Dg2msxYD7GcSSNYIk+xkTvqEmhBYYaTg0KVYMEjuPxdUP?=
 =?us-ascii?Q?fNgb1ZDfe2TqOFQm9Pu6Qe/CFAHyU9XWAe0hPlxm1FID18+ddBaCHhBRaJR6?=
 =?us-ascii?Q?EsJwPSNrxmzbS31d6iwNQy3cJbN+q45TKHxl7qSZgZl9XW+Imdgh/3poyHlp?=
 =?us-ascii?Q?onm2Ch1WIw9ieWgbdBNBiCR8aqqO+mKzeyJHNZJdxkPdGSLa0eOD4yF+cMeo?=
 =?us-ascii?Q?smZ/FD2i8mOTpBEfd+iUI9du3vM1Wrh+hwMLrXZatrj1o0rNfgt/vHnAd+/q?=
 =?us-ascii?Q?aC22m+nc0cQ9de3IIsHV9r82pNhNnWeFxIaF0UQ8DSwIQeF2wJFEwRrB/x1k?=
 =?us-ascii?Q?shMwfzrhtDY4Ls5kk91VA1QnA/qeuq9QZ4nBTabDH6GllY7MDjn0Q2CSopCv?=
 =?us-ascii?Q?jliWz/wwoBdMIBCIWYKZlAuZwd1uhqRK3oSD5yW/XK9ijlmfG1yqxFsLL9kn?=
 =?us-ascii?Q?Z4nR424yg7ZiX/6Mx0RLA9nQiZe7v60f78DNncjQWT1EFLX5V+H4awenEmIq?=
 =?us-ascii?Q?+Ff0PLjn808JgDjt/nH7JOBwz3ERMhg5R/iQ1Tilb+OTO3p2fyULJf4W5Bdm?=
 =?us-ascii?Q?ZMTlKEnMpzflkjQjnybxsa0aNyCJNWftrzUET0m1gW70t5EwaV92ADHALbUu?=
 =?us-ascii?Q?0xE7h3sTq2hvouZoBtClGYCVdlFxS9hgQw92RnmxaqDq5PI2VJkp7yZhF2+m?=
 =?us-ascii?Q?i5+bfk+5Ly3gMQICS8x7+Knya/lBmwNJefd+RvRunpH1UnSaB1dBlb+KIii6?=
 =?us-ascii?Q?KAYE4a9Dn5e720VaOOfmL/MBzsd++ArqSsJorA6S4aZNsr0eOSGBI2KKl2LR?=
 =?us-ascii?Q?pFrp6sjjufe9uzWRE50/dIphSoXL0eNaQuTWWAtO05BaQ9wzSuwgEyD6y2Z7?=
 =?us-ascii?Q?OE7pby/SKbR987zSZVUrX8KuP5QR1Le3Tytg2M7fpB7rZ7Tm5mHGsz7weO8+?=
 =?us-ascii?Q?2qjlwd6NHmmJ1CulUeOVXGfYcigbsZVOuhEIkBHS8VaskWjMB36UUk0I7u1K?=
 =?us-ascii?Q?M6NvnpsjjkzPbbkUwkm/VEuPSvjdM19aF69ir3lrUHUw+cBpyI45RF1lp+kL?=
 =?us-ascii?Q?F2O27J9/X1zO9C1Ms/jOkjcy6YvdJ/EEL0D+E/H8AoHA76n+2p6Q+fIZmtlu?=
 =?us-ascii?Q?mo88ZHHvLNQYXdAWUD3TBU36WgCCzdQ4hGfSMNI7+VDPiCBSmWWyEbKn/51r?=
 =?us-ascii?Q?WZBRNNw8pT4vBl3fn9bk+LbZiV/hC9nbSwamg+f2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b92f40b-a253-4f3c-4683-08dda450ef73
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 16:49:28.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sFQNekbCbqxUvF36BLmMWYP7AJx7sHYwAekObKdqwCcSJcAgQpcNmDsGg/9udWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

On Mon, May 05, 2025 at 11:18:37AM -0300, Jason Gunthorpe wrote:
> +/*
> + * Check that the items in a contiguous block are all empty. This will
> + * recursively check any tables in the block to validate they are empty and
> + * accumulate them on the free list. Makes no change on failure. On success
> + * caller must fill the items.
> + */
> +static int clear_contig(const struct pt_state *start_pts,
> +			struct iommu_iotlb_gather *iotlb_gather,
> +			unsigned int step, unsigned int pgsize_lg2)
> +{
> +	struct pt_iommu *iommu_table =
> +		iommu_from_common(start_pts->range->common);
> +	struct pt_range range = *start_pts->range;
> +	struct pt_state pts =
> +		pt_init(&range, start_pts->level, start_pts->table);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +	};
> +	pt_vaddr_t start_va = range.va;
> +	int ret;
> +
> +	pts.index = start_pts->index;
> +	pts.end_index = start_pts->index + step;
> +	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			ret = pt_walk_descend_all(&pts, __collect_tables,
> +						  &collect);
> +			if (ret)
> +				return ret;
> +
> +			iommu_pages_list_add(&collect.free_list,
> +					     pt_table_ptr(&pts));
> +		} else if (pts.type != PT_ENTRY_EMPTY) {
> +			return -EADDRINUSE;
> +		}
> +	}
> +
> +	if (!iommu_pages_list_empty(&collect.free_list)) {
> +		gather_range(iotlb_gather, iommu_table, start_va,
> +			     range.va - start_va);
> +		iommu_pages_list_splice(&collect.free_list,
> +					&iotlb_gather->freelist);
> +	}

For the PT_FEAT_FLUSH_RANGE_NO_GAPS mode this doesn't work, it could
cause an iommu_iotlb_sync() and free to be done before the PTEs have
been updated. The original idea was that the PTEs would all be set
directly to the new OA PTEs by the caller, which worked OK only for
PT_FEAT_FLUSH_RANGE.

It looks like fixing it by clearing the table levels as soon as we
know they are empty is the best thing:

+                       /*
+                        * The table item must be cleared before we can update
+                        * the gather
+                        */
+                       pt_clear_entry(&pts, ilog2(1));
+
                        iommu_pages_list_add(&collect.free_list,
                                             pt_table_ptr(&pts));
+                       gather_range_pages(
+                               iotlb_gather, iommu_table, range.va,
+                               log2_to_int(pt_table_item_lg2sz(&pts)),
+                               &collect.free_list);

Jason

