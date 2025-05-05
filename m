Return-Path: <linux-kselftest+bounces-32404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F3AA99CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE90A7A8DCC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A926A083;
	Mon,  5 May 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqnaI67y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1B1459F7;
	Mon,  5 May 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464160; cv=fail; b=GP5fA6BiPCRhlMtSq/kCI5ouHdcckJBWbYFTyjFRuOwv306YlNCZWOmaTw5R44txzHPQ89nnwTeVPQBigdPX0h7gqlaVQx9BE6cHCrEyo8LEwzjAIjTcPJG/E7WdS17WAfpX9ESHtoltgEZUJDO7CSWCFgjyZS49of388sPE1rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464160; c=relaxed/simple;
	bh=q1ljH0dXPLjNFqUF13JzVVjiw4XXMuZaDPVGeESbQPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FgjHJvAXyOVr4fYOO/MpUXYmuz3z+PaI181SzHD0REE0CuA+t0iEi3+6VLy/FWYI5lYqJSOkJ/DpcVFGxReeAn/E9slrI2nkqNNOaoRrQ6RE5F2I0lKl4FtXd7Y6f7Io3DtUPDpTCZEI6iJWG64WaSox6q1YrMTefPSsbHiC5uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqnaI67y; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oALTc3Dr+Rv3cCuM6rukfEhYMxXLN0x/u/DOJ4GSvaJjGgty+pKxE8Vcy3szLWdxlO6KKfqFZhlNDGQRminqpx5PtyFFDuEdWFKsKkkkSe+Jof8OusIhUw0J0231I0OTvxUUm5gBw45Ah0qQm3fd/gSOTvyF/RWF0cvxzzJl7qbKeOKb1jGoDt1csGfJ5/js7O9P5IaZ5RD493PObw0cWhFKqlQspB2khO9mBmj9YHUOxZ+YtQ4Vi+6ivizZFs1CDpWPrYBx+Ve2sft0k8fpXSL9s39R4Kr1G498xj8m8oZ90OeS3iKHT3Q98gEdk4xIBCmE8hh7QzgShNrqbibB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t/EqPEg/XF45bLN28X/lKk2jdbdTm8YYyLoA3KA4vY=;
 b=jY0gfIEY+FTGIkcK6vZo1yzyeaIz8eAr/CkS7ksOCSvv6UvElcOm1LQN5FHzYxIYMYBOLcJw3T94DUT/syUCR3JYoA98PDIC3fpSWVfhTkJjBVZLVi1VSy9PL0Wsfy73Z5CnSn6Y/ARYDwx+SpYmxa9pJWqaA0j5YOSacLYqRq4Ab/ecL+fdEHHTVWpt8mNQ6DEnpf90+IIGZmcGcicH2DYFpXA26xXBPOVKkVI14hHTfCd0uh7h3c0TH07Up+GsLG0sriiCWAmiCDsIi3wU8OCz8iGxCtVkHWKJ464tN/riqpFs2e96vVIylLAvvbG/33+74WL5qK1ANWuL+rZDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t/EqPEg/XF45bLN28X/lKk2jdbdTm8YYyLoA3KA4vY=;
 b=FqnaI67y+JcvSeqejnthR2n/6qG9xgqY/3ycaKCavydMHJEI1jvDElf8DyAjQjNKe8eFnsOSL4MCIDoqoxxqeg3nxAPXlKzS6zHp6OCtb3uq03OQM/z2CeJCzE8EgOjZtQdgFHQGTs9v+p0h5vR/1Eruy7HjPo8Ja49mr1raGcHtJ5p31pkde7wyY9yTvFuni2r08L8mo7En7fWMGJcuker7l9lPRlEubvy0xEbdSGlik3Cl5dIgQv1JPbOzWbLL3VN2sW6AfnJuoUkWecEjjp5x8ciDDZijpnWTwf/X6+zZohFBXvfNDVINdg6mGTh1zWRMevc8pLY6Hy14Z+PJDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 16:55:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 16:55:53 +0000
Date: Mon, 5 May 2025 13:55:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250505165552.GN2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:408:e7::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7802a2-847a-4b49-eb32-08dd8bf5b28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZ3UFKWUXJurwJxN20qz/x22G3twc6J0jjxLATXXj9wT7CbuNtQIfEDch7uh?=
 =?us-ascii?Q?rJruZURUz3xhakfP6croxTsfggVLfUL2vVK64OxsT+Tee24bFvrYkML//Dd4?=
 =?us-ascii?Q?wqxeiTbZ+J0DAHvykm9HVDnC242lJbvBxYiPoJcmMhkhYovQsPzhMO+ak2nl?=
 =?us-ascii?Q?Ir5pQudDClTf6VoCgxGlD+e1yeOdFpQY9HkEw7YTQZ4TLlXwRt4ccGfpxB/7?=
 =?us-ascii?Q?50/mwz7JNTP2ypVktH/Zj4GrBPBzv1wemMF6x8QBSc+S+cuIWnRHBIOv9Odg?=
 =?us-ascii?Q?9mTeIDINjJzgQREjUMWeoinJPzjKjAhXDRVKeRrprKRMVQN+pE+5pP3GEKNe?=
 =?us-ascii?Q?JG3zFtglbmRBgFvFfSg/pLVBFutHRizhgqnfpnv71aCPeFAj5m2lmN4j8teT?=
 =?us-ascii?Q?0D/vQbTN3dIr02v1qN/K3rAu4NqQdJYap3UhE9bXnaDH86Sc4iwxnv5yU12l?=
 =?us-ascii?Q?m3RFh1yHxXpDeR5vdgs4kAV2vw+T5vSOJxGP65stciwFyuL1dH2qLLdYctck?=
 =?us-ascii?Q?Aoio2jhJXX43t/mgTCMRvtAJi/gNa3nJLXmiKl/YnycBHgvLcCMCa7Qg5H1G?=
 =?us-ascii?Q?HSANRLKd06oBfYQymjTZc/+r4D6WIMuNhzdOKrUy3s7f8HkHOUMHmSHO5Utl?=
 =?us-ascii?Q?SL694+D6SfoYiOdgUvnrOLWgg/d53ubxO5rBVXQCLoMBjMFUbzfWmlqv4Qa3?=
 =?us-ascii?Q?da+6Gxi2FcjUnACj9GknDTtLTTsyLmRcDnzYL956eCex9fsmCr0gHa5OyWzK?=
 =?us-ascii?Q?KyM5bow1dTMNb9mdAnmPJvzKmSdj7BmhPJJuhTj1PY7fiGntHy12mTYcjNAE?=
 =?us-ascii?Q?z4q8/oFUb05JryrE1n9uSSKuNoziBTcDeZFYgha2nuM4ycONSxRGCsRHaVxK?=
 =?us-ascii?Q?yy8laMCglk01baZ/dFqr32jSNv9AAilz1draJWnAlpSUpnxqVsmKK1G9sSfL?=
 =?us-ascii?Q?MXYMPpQX57aRJPR5oZAnvlszU2uFArOEhPYTXr3BCYgvuxZKhv2KO8JmhY36?=
 =?us-ascii?Q?1sFtlHf2fZZ+drj7fTaxu4Qj7utFoAP/k1gnp8Jn2dxpKT4oow0EO/1EgnPD?=
 =?us-ascii?Q?W3Ka0FYdj+foM5vjw4oQX3XsmRzicJ/Ez/zUQ6OFbA/KC/DdCuuIcwEdqPQY?=
 =?us-ascii?Q?nA3MV+L83Wl2lJ4x3G8YJxmmlji1agrsklc8jRiZsmjsKEBhRkLsxqyM6Wa5?=
 =?us-ascii?Q?PT6vznSnxRNoqoOIdsvliYAJUeXl6A8Ucv6kT9xZOdWdf3nB6+WgzOa0/kjU?=
 =?us-ascii?Q?sv+VP8jsGOrZaF/yGp2kRwzzOuVDFayzzHGQVgJthJB0qAa+ksEQJoWtm4fK?=
 =?us-ascii?Q?Go6tZJyIyaHfiFGeOnM42b4xmz2pGVF3b/4JvF40xaTpBtuAbluJE8Qr1GRC?=
 =?us-ascii?Q?y5lUc1Z0oL5YoLA+hErkjjjfRYU7bkWKL6bmELQXtG/WJnpB4CPJN2w77f1b?=
 =?us-ascii?Q?JaN6KWtOmjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkO3F8nNCDlDFAmyAgbi7F7uS9JYGGQ1n5+VelwwXD8Jv5iozrJuOOVUCV6i?=
 =?us-ascii?Q?gh7vvkpEKZX7WjgaAvvImJY9Ioxk7ULXcuRzE2flKb2EcF2J9hqVaLXMoZvP?=
 =?us-ascii?Q?CBP+XT3bWxsckUxxyU7RDJA6Q8jgV4aek7Zs/lGsCzQI8gyqklEjBB9GEOPs?=
 =?us-ascii?Q?uTvT3A85XF1qn4uUo94hicy2RrpBOABpvR1oOGmUROyITKBjVhZAoUlz5vit?=
 =?us-ascii?Q?Rt2NYPJ9AjXJYTfYOyqlPcIeZ5CeqVww27KKkv9gut/63hsHLcoONGTK0CEl?=
 =?us-ascii?Q?M9KMDqhfxARw4P2aLr9Dss/R58IW7SrFdQpLY/c2gM1ME2PeFdRDqliKeDsl?=
 =?us-ascii?Q?/YGa1NA/+7yrOFo1OpoLImAV8nLIGnrWMID/6Yh49FkA2CMY652AWpAIkJdq?=
 =?us-ascii?Q?occ/IKUJOlv+6Sy5gb8IRdLNbBEdzmmJSQZmun55w5ycZGYBRIHCQCBGJCgl?=
 =?us-ascii?Q?nhxgoLCKP85t4vLde8QUger7BQPjypBKRvF4KerqierLAM1BfPk8lqjjLG99?=
 =?us-ascii?Q?ZoxoPg+i3K+x8grjeZ2pwDhaa4ZrcXmrvtW3ZyEzfTTyTEOlzotT9YKixVrh?=
 =?us-ascii?Q?EZafQKXKpfAfq54TXhSDSBTSPj+rHgG2lZzIwvGQh29sxwv2GzAe9Y/ey5U2?=
 =?us-ascii?Q?Mu5p8uQ1BhbrsgnXMMMCb4ZQpUMZ3TTYdrGx7O684Y8waNFMsy4hpwY3546E?=
 =?us-ascii?Q?/+abP8FAkWh1vxnZSH/VXiK0RnmxWBqLdwji02W9HowCKTf+f6yDuG6Tpm7q?=
 =?us-ascii?Q?6HGVFNv5FoyhwDBNugLMKVk4vo+0vXsjgmr+Z/RAI6ow/hTv8hNhHUc/G9kN?=
 =?us-ascii?Q?mPp1wwmRDPSPsruzV1KLrMCSR1ORoa7Co/eiHMh9OHWZHClPA9ktvdP54mEq?=
 =?us-ascii?Q?rdqH7ON6kXo5CU8m9Y4MU9poanpzQcUMIsYsEy5wn1zL4EbJW+fTMMevvwly?=
 =?us-ascii?Q?3mShVCSbco5T/liAhLeCfcIiicLMZ0ZeUJjNmVau3EyfZJJBxXQeP728dLRN?=
 =?us-ascii?Q?nB/9StifJLiw7hpT/cpcpb9mbrUbOZydSS9euBAPSP0ZV6T3gOOcrZ12CC0+?=
 =?us-ascii?Q?x87i9CURxIY2qM3xQ1ImSuTfKq4AxAyMrlaW9SPUGaziiYgFqE84QfHiJOF1?=
 =?us-ascii?Q?5M2XUNbI53vQI1TXNdTpmeyorIm43vlz7EdJhQpVdhB6HtppNBy2g8QLi/3O?=
 =?us-ascii?Q?6YMIBrvkmd8C/BEbQklYxTmP0Th0TygKxPPID6bsS2GFJ3ZG3HJCI3SleTow?=
 =?us-ascii?Q?Zko/jbCneT1ywam5foWQu/J2nI7tOhvTqZjptyOWVJSJ3OZOW9OmmMOebhSK?=
 =?us-ascii?Q?hUTW0bvjycBV3eubmBNArVxW5LHdIc05MSCXeuuD1ucLHvGGqY+dVu0EOl/o?=
 =?us-ascii?Q?yD8YL+l9mafvnVir9kyLyuirpHlrPJ7ZyRZlmBz9g5/noXoWKFQ4cPd9pjF6?=
 =?us-ascii?Q?hj5xJduY0zYn9e5lLlx4IIHWJxLY5YNwEDAemgiyepvA1NJHOSSjHY1wtxMf?=
 =?us-ascii?Q?JJP9hsJPk2cQJ6Oh2ppk7TVi9qSom+3G98OPI/qyt8wD+RO51UWF5k2lreCS?=
 =?us-ascii?Q?UhxaEr+13n2S1m7xdg1Q37mshSKbnnSLzuCPUBF2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7802a2-847a-4b49-eb32-08dd8bf5b28c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:55:53.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iQihJyXzoVVdO0Yid0Vw/dqeBmEv7mslfqplcGcLriEgV3V8UkJq3y5Xfzpo+eY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

On Tue, Apr 29, 2025 at 02:46:25PM -0700, Nicolin Chen wrote:
> > > > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > > > +	if (!immap)
> > > > > > > > +		return -ENOMEM;
> > > > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > > > +
> > > > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > > > 
> > > > > > > I believe this should be sizeof(*immap) ?
> > > > > > 
> > > > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > > > 
> > > > > mtree_load() returns a "struct iommufd_map *" pointer.
> > > > 
> > > > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > > > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > > > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > > > sufficient for the given "size". 
> > > > 
> > > > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > > > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > > > for a 64-bit machine. Whereas we really, just want to reserve a range
> > > > for size >> PAGE_SHIFT pfns.
> > > 
> > > But we are not storing pfns but the immap pointer..

That doesn't seem right, the entire point of using a maple tree is to
manage the pfn number space, ie the pgoff argument to mmap.

So when calling mtree_alloc_range:

int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
		void *entry, unsigned long size, unsigned long min,
		unsigned long max, gfp_t gfp)

size should be the number of PFNs this mmap is going to use, which is
not sizeof() anything

min should be 0 and max should be uh.. U32_MAX >> PAGE_SHIFT
IIRC.. There is a different limit for pgof fon 32 bit mmap()

> > Ohh... so we are storing the raw pointer in the mtree.. I got confused
> > with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!
> 
> Yes. We want the pointer at mtree_load(). The pfn range is for
> validation after mtree_load(). And we are likely to stuff more
> bits into the immap structure for other verifications.

Validation is fine, but you still have to reserve the whole pfn number
space to get sensible non-overlapping pgoffs out of the allocator.

Jason

