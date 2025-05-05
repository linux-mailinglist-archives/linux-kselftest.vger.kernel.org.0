Return-Path: <linux-kselftest+bounces-32413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B0AA9A7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678373BE16F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEE326E142;
	Mon,  5 May 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEEq2lLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65026B96B;
	Mon,  5 May 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466116; cv=fail; b=WDPfMlLZmWeauqN1u6NLXwIwl/+cZf2UKotq4PeL0UDUKcGSIATZlslzIiFmQGF6aIRLQfl3NntknGH+XL0eaJ9ZWETUXrmHYlOCACH9uSCdIKRyAlSKvdqEVS54eTdQuB8aP9Y3MFIKZmmI6OI2gVp3tZRuT+ao3qUAhnUv8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466116; c=relaxed/simple;
	bh=d719GasSfULqb1l0oqLS7cQ9oQeiK9rwP181C5QuWUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCrYb8EDX+4QuFL9WaIzGHWkY5CEIlXuSVIBVr1HzWYGRQTJvRc3LLMZjsc2Jg1gG2rYET8RiN1K/+oTvC7zKRM6cyRlr3ga3JZaWN7b1STurcPoSs+Ov2EhMmv729anB2awrLzXwDPWUtr1JBLtxktlWY94y86l+/jgdzrJ38M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEEq2lLO; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD9spQGLRpA7VyRwtqonODl8DlHt1JaZv5sBieicGrqvwYA+U1yPWKzpqRbA7S9aj7hm2UEHVCB8nASsg8n6/eQDauRtBckBMQ8FsBTDbNN9+AHsjotru2pP4c7ed3W74wt8Bfazk4vwtTygO7FQtOZVVpnilcbtqi3YynEnlmUDdXEKDUHAYsm7nK3un349aJb5AN5I1e2kj1r6HLVBdRipFDe5AY6cI5LDnxuAe7pmjhCT71ZHZWgKwfuY85wiYmVhkGkAm/uwVkcF0Fy/FLC/osOVluTli87DPCQsr9TjoH3U3eLXL1qnUbGJSfM4eFCB6CbMkG/w8nSp1v9MIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IExccbVNWAl0HDgyiz3E62M0ZckXFGb3QOvjCysPLfQ=;
 b=IHQEBNk73KHc4+gaBCarO2Qb8XBHINVPV6PJLUp+2+xwk+ncd37eCh/hP2eFZIpfaj1gpmXqOTbnXPM786GVegmpimDdo6k9WjeRk1WvTzXN0sihJMRCRvXCCPM3tviR/Xx0g73g7so3W7LosxDJv0Rtlg2AQ8UQBERL71wSnOO/U9Z89IwGz1uIgc0sGk1wIb/i8BhNegVlzgpKsGT0CS5QsUOBQL0poOfYQbVnyXqZgdvurK2fRifJrOPcL4ZgINCMP4JYfl32l1mGQNPZE4yTW/pALetjPrdg0tGmQkpXHy1RS6QAOw7BlcQ8wJ+DLWQBWuQkNEzddllHux5tLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IExccbVNWAl0HDgyiz3E62M0ZckXFGb3QOvjCysPLfQ=;
 b=KEEq2lLOC/+OaTfp14BzVqk7opPZdYaqoQLg0yxCE4GHSj4xvcMaTmzwGUQLvFNCHStfJAlwOOKpp9WTWnDyFWhDkbNLyE9FoEcX5GGnupXVrtz/xsnUd/8ODSbbPmF0H4uDdTWrWt/LiKezc7kmvxn+2C30NfGRjnHFLjCRlKowvjv1cF9StrSq5ZZ28t2MfG4z46SxZ074jLd4a+tMoADmnDSh+yAa5lHrz6sMOfVWcc9IO7Mjw3w7Luu0TPoDNq48WIfaVgzPKD4wK0T/wD4NbKGyaNBPagEQ2p12SKD8eNEjQbflNHSqanAE+PsisTZvbx4COzkHQadZKud1ug==
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 17:28:30 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::5a) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 17:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 17:28:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 10:28:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by drhqmail201.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 10:28:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 10:28:15 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 10:27:50 -0700
Date: Mon, 5 May 2025 10:27:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <zhangzekun11@huawei.com>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <mochs@nvidia.com>, <alok.a.tiwari@oracle.com>,
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBj1Av6Xaj8flMN+@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505165552.GN2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7681fe26-03ea-48d6-4795-08dd8bfa4068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BYpD31c0TqANmuLWBsaLfmz8beu/Xs4LwsDXdnSup6Vxy1ybQsbpv2uHi25i?=
 =?us-ascii?Q?9VjSU+oHbNABFV6UCblvhsW5GnsfGabKjcyk8QExBvKWq0kkijZB6QobgW2C?=
 =?us-ascii?Q?NZ0BuDHymMOFkxUMEkiIVxNeHDA8i/eJkzoBRHptDsTTqskWugbM1/klSVe5?=
 =?us-ascii?Q?MN2LjBkGKXPwfoaXIF+t0h3POsvpo1jlcrw5HMUVITmSudl8/52phOXDLI6x?=
 =?us-ascii?Q?8BTrJQIXp2bBsofGyDSGGDmAX5R7YUDHNMTOx8H9GfVkqOTnU5lKZPS8gJ/a?=
 =?us-ascii?Q?e/DuWkWFRmv5dPN+SVIEuL4DD4/qmTsEKZLPFkNfGpaolTuTjZmnt18cQFzj?=
 =?us-ascii?Q?fj8ljqoZ0x7y2uMlyZJUv2Kw/Eqw5eHbAqlyYdjKPc49ozxASTF9viEbB1Pa?=
 =?us-ascii?Q?qVUYP8Zx0NacGmcf2iKm/fxw26zfJXrOrvnU17ESiLJ+26TyYdwtVsGIKcUa?=
 =?us-ascii?Q?InZHCQ/Po4kWg2Dn5JyD6uzsnQdQImsLjPbJgFHtTVnzRHu9UWL7I/FGAAec?=
 =?us-ascii?Q?SILVUDdGnnbXTCNDk0Y0e6BWkTlhOeSdE2Rc9M6ofBwTXOakzEA+Q1AZ2IHO?=
 =?us-ascii?Q?VQ96TNE5jdj49B5XhDJ+RlS1K05hiKs7v3HEFynkrDsAS6UzOIYc5wvTzrPs?=
 =?us-ascii?Q?GEVSKJ8G2q3OtSAfHha0QwCiCjcnutM63cg5IDUUbbiOMFjEyvgW4k7Ge0l+?=
 =?us-ascii?Q?7BsN4d610gYgxhXQHEsoWna0CuJuSauqScrbwkHC6J2HZcZ17nDnTroFym4H?=
 =?us-ascii?Q?cCW/s1/v0Eucu87+UsPfIp07G3whXsOgBBchtACtVl++vVGTyKGy07G1FcdP?=
 =?us-ascii?Q?gYtBbvAxQjsQc6eJJiDjxU+Zsu3qxuReaIyj1bFW/RTmedcbCLeas/pKVHfT?=
 =?us-ascii?Q?w9j/rqIJfhB11D6xmzrcAo2BW3QvkQS40GRavtYpo6G5efHd6ySekvGgazBh?=
 =?us-ascii?Q?Bl3fzbNCBVNHy/VU29opGUfyOkOUylsl8l3Uxcqx8mFccPiLzcaKD81Cwc5a?=
 =?us-ascii?Q?D/LXn3K9KZbN74QxR3pcix9I7myxOvnaRfi0jZYLPdjjBSvKdH46jGektZ7F?=
 =?us-ascii?Q?s17gjz3CekWs5kyyNgLoobjbK2SzZbyP9Zhrt7Xfzr7EjdGBtr4tIRW3Kz47?=
 =?us-ascii?Q?yrJLeZXB816KDHGm8xqraau8A1b9+H0XyRuu70sIGlgIY76wVa5M/dKKPVzx?=
 =?us-ascii?Q?3BiETNp7PO6e82WVaLudzRA0ZhMQeMbAGPQAf5IoJtNa8m9OE/DMowlCbmJg?=
 =?us-ascii?Q?jKOgdruNaE3pj3pR+D4DcmUP2+5xzqM/lRgP7Mgz2CLoM772dlN1OD2XRrlL?=
 =?us-ascii?Q?TbDlbIXcqHTmfmSinM1oBRSBXEFLsdHq7t9Pctz99fLSQajfB4OEuc5q5nKX?=
 =?us-ascii?Q?ljeMKyfgfn7Q3ZFAsmprdF+hurnVLN6wnsD21aDp7vZUjOyBCTzdnUvsvAHD?=
 =?us-ascii?Q?MtJ0lJi1ZWIdWbY5/tvEjfzOqaFN7V1WGhzT4JihPBSAcX9aXyVMH1xoc1Io?=
 =?us-ascii?Q?Kym3XnZ38cX/PFIyj/ohamRE3PjY6Cu7YIks?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:28:29.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7681fe26-03ea-48d6-4795-08dd8bfa4068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180

On Mon, May 05, 2025 at 01:55:52PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 29, 2025 at 02:46:25PM -0700, Nicolin Chen wrote:
> > > > > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > > > > +	if (!immap)
> > > > > > > > > +		return -ENOMEM;
> > > > > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > > > > +
> > > > > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > > > > 
> > > > > > > > I believe this should be sizeof(*immap) ?
> > > > > > > 
> > > > > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > > > > 
> > > > > > mtree_load() returns a "struct iommufd_map *" pointer.
> > > > > 
> > > > > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > > > > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > > > > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > > > > sufficient for the given "size". 
> > > > > 
> > > > > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > > > > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > > > > for a 64-bit machine. Whereas we really, just want to reserve a range
> > > > > for size >> PAGE_SHIFT pfns.
> > > > 
> > > > But we are not storing pfns but the immap pointer..
> 
> That doesn't seem right, the entire point of using a maple tree is to
> manage the pfn number space, ie the pgoff argument to mmap.
 
Hmm..looks like I misunderstood your comments previously.

> So when calling mtree_alloc_range:
> 
> int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> 		void *entry, unsigned long size, unsigned long min,
> 		unsigned long max, gfp_t gfp)
> 
> size should be the number of PFNs this mmap is going to use, which is
> not sizeof() anything
> 
> min should be 0 and max should be uh.. U32_MAX >> PAGE_SHIFT
> IIRC.. There is a different limit for pgof fon 32 bit mmap()

Should the startp (input) be the pfn_start (i.e. pgoff)?

In this case, it would return startp as the ID, which will
be further returned to the user space. So, basically user
space know the pfn range, v.s being given an mmap cookie?

> > > Ohh... so we are storing the raw pointer in the mtree.. I got confused
> > > with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!
> > 
> > Yes. We want the pointer at mtree_load(). The pfn range is for
> > validation after mtree_load(). And we are likely to stuff more
> > bits into the immap structure for other verifications.
> 
> Validation is fine, but you still have to reserve the whole pfn number
> space to get sensible non-overlapping pgoffs out of the allocator.

I see.

Thanks
Nicolin

