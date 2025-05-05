Return-Path: <linux-kselftest+bounces-32436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54BCAA9CCE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 21:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0468417AF1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27D25EF97;
	Mon,  5 May 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPTx2CmJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31E2040BF;
	Mon,  5 May 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474721; cv=fail; b=eIDi/SPtiqvS9gFOg+qBPL2RNYGRTXCRl1VteILAow9FtD01qsRjQjQpK8Yw4Kyhw6+/43LXx4e/ItIDi+y1HPmdN99uVJpBaCoUp3lEfRyc7RVV+fomWS7nc0US77sBBDJFX7t+7UWNSRlA7LAkpEnrLjwGLUW65BFC1YVbT8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474721; c=relaxed/simple;
	bh=eO+d22S2C81Fjq1X4UMTLFFhbj4t4gy5citg6o8NrFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYQRNfz3ms/rcWmRQovM7/w9Yn+znYV/m776RyPtyK79JV9l4DlwOCidimZ0s/amCZGrPuMP1xpHyV2og1CP7HgCL4/dwE0BQ8XzdAjUBxYkTZWI64/3W8VGnGUW136EMCrrA/jys4jZInmfYBfn4CRn6ITwu5YcP0MA9ok84ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPTx2CmJ; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffQK/aqdXSmr4zZdoh2l6/UoOloYTCuEje3TQr1avStP7GRqUgKbBYhDMa4xhn1CJDfYoA4g3XuFYWeZ8XKhcHlsmGIp8XE2pmCsHhNy86iu5cFDuih7OOC/brg/V6lGau9T2NasZPK6M89sRdKi0XIZx3aXAkGRT1VKsoqLUkJkpTd9yLsiYJHNi6m8ITTPP9RmQ8xlPsbqHSF2H1dGfNBDnMUWlxy4QISkv0CR/IZ74gGSXTwsh91u0BCjlfju0c5E8ew5M+SOgdpMfuQXeBbUPoHrplxs8Nn5KJSZ9ZAiIGiaX5jCk6Bvz7um6aJIlI52ysfMzH9PqtAKtcCttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzYz1kQE776rppX2LjWBcEzYot/SUfNrKDUyz+RyId0=;
 b=gI0RbNlQPDEhprL8fLU2+rE9+jvV//cfQcc6kASgf2dsYA5E4hbHiuEXaof2mwseGvU0iLee4AaT3mK7+LUjcFjRvSnOqGDq3P5+G+5smNZQ9jCm6mxRSiNeLWNd3oxErOiLP+XTJJx4rVI/9bfcwZKhP/xvZS70tli7QVPd2yZAeMZYkLHDvbftM8d7tjdNY9A5vljPq8jJ/n1rqeGKxCfPGIZa3SgWofBQaLJtzjnoOAWD1AjAzSg1Gw5jteX2nKgeWjNf4VsEM1Wmy9re4M9J596rRz/SU/BjJFANTOfW0fNPojwZBVTZcNvoJsIQHDLb/RjhCDHJGUc4o+RfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzYz1kQE776rppX2LjWBcEzYot/SUfNrKDUyz+RyId0=;
 b=BPTx2CmJpt2SZLOgPcsu3iGTTQKEHXkXmi2EWp9nC5eSc6AsWnmDVIB2Meh8H9VCw6ty8alTSQOCAF2we9FzvKd7RfNWdNZj/7fiC0Dwc5+k7hw9C4+4xH3vIY2Ah9q7HFVKP8UgCN+q033dE5whIxFMzHK2i7PY8dI8K6DQglX6lCM/m6XDDEx87wMpFw7K4rz0oKmUj5WBusw/2F8nAnbOq55wE32+sf4LpJxE9KYg/qFjlRHIaOimTHFByEnEgx3jd9uchbz4kbWZxLFibUcxiddOMqDKPJLEuugLMaKCJJopWOKX3TnctX6YTYgX6usVhdwLDJvZla/2bV6WGA==
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 19:51:55 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::20) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 19:51:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 12:51:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 12:51:32 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 12:51:05 -0700
Date: Mon, 5 May 2025 12:50:56 -0700
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
Message-ID: <aBkWoH23VysYake3@nvidia.com>
References: <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505173101.GT2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d706f07-d75f-4763-2845-08dd8c0e4976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wnDJg8TfHKTv54yOKMCTOAojk6lC2PwLFxItsGRTOjvAqR+q2DgtDh+nzwj?=
 =?us-ascii?Q?73j2Ls1EBIEZcsgXP7WYkRWD4s63RwnABRhSgUo7p3v3RQqzy9jP0fNGJv0E?=
 =?us-ascii?Q?2CQys5kC8fgsqOHqetIktkxz81EnFB/VH68GAtNXFgBUc9DAEa5isvCAXUte?=
 =?us-ascii?Q?FtE7qAlqsLUVPXhoOQm4zDFK1va3p3s9yPAsgvSrlRmeRfizYGgw6UdGQ7xy?=
 =?us-ascii?Q?tR317b1JRXwVBE8OB+T6ThxEK3O3dKwLp+byAzYclgHynSFWAxZqt4FdPu3J?=
 =?us-ascii?Q?3fy/ss+ZgxYvEUGUod8OvFGgUFnrPtjd5cj3LmgeFojWF4qUWLpNcnTzBmcs?=
 =?us-ascii?Q?oFEmRnzz4+Gjiag5tUjAHEqThvfFCvZAUD97pqC/ApRY+u95FaIiwZx840qQ?=
 =?us-ascii?Q?CEEZhiuJxix7YIYe2MIpoMdHENShXRY99rS4AFM+8SXjEPE9sCby7IH2O6uS?=
 =?us-ascii?Q?ji1XMxiBdwDsL8Bpyd1nIX2xIjkPynXKk8zqmQ93sw+0ecKkmiyohmU8MNXy?=
 =?us-ascii?Q?mNOTqHAThesKyCNpao42YFnIXcHu5bCwFPypFUt1dT/2HJa7d0ffKT+3XPam?=
 =?us-ascii?Q?8gexgI1xTQ40U6VouP4/wzYOQqUplrlQJYNrQ8QCUxf4oJEVnVIwKFRSNP7u?=
 =?us-ascii?Q?0bLiJrAAGou/PnvRPlmBbuCGPOgRJexDhYaJM8HbfPkluZr6EDdW3aubsbP8?=
 =?us-ascii?Q?oNoD1GeckP6AT2qgY1Giq3CsVhk9ttG98eBByNsolEEFLULqkrzYAdehxGab?=
 =?us-ascii?Q?8hNSw/HpaYe/xRZB/zg9IMPX0TIKaOi/2o9f/mUV6H+cdQ2nAo5kw70udEJj?=
 =?us-ascii?Q?QV/HEhpwISmyTXUMFHzyFfoobSrvrqmmhydirW1hgt8MejQzThv7YQHf7sZR?=
 =?us-ascii?Q?3KGgOw4yMhndPVTGWE3nbgEgjHwqebEYZIqAF6Mck8YJjlaJWI1ketuAs8Ag?=
 =?us-ascii?Q?t67kYhVHPZIkztokI+pRPfb6ouUDVdWyFlhBVFQZzaAZinIlDyfDN3TGhcn+?=
 =?us-ascii?Q?IEvTU49qMBmt9DIsngCGmhp4LDvvO9uSDdF+V5ukPfriIRQEdnnfgnBLH7P/?=
 =?us-ascii?Q?TujLdFQ/6yyTLLi+IkW71kYS1IN88ZfWQGkbkvx3Kd1T8WNaBIB/X74FFWzZ?=
 =?us-ascii?Q?Sbz2tREnxkKPjbq0zYBey+SPbS3bp39NLUfW4DdYIyIZL1m5j+R3+9tu0uzu?=
 =?us-ascii?Q?Df/0dTMucw01d9HhRdBLAKCU2UzaPqadCBXSsKxXvMsSphRTC1gFWxPBLzg7?=
 =?us-ascii?Q?TR+tZWIFvwY8x538QlQPA5WfssIWFCYZM10pWmmN7pUhk2YZqcEVVJnxkaDP?=
 =?us-ascii?Q?w6yiv7b5pCRhhhT1GzU2iFmt69t0/lpAyehRlGgnOojB6Ih1hiBZpyyN+Zf0?=
 =?us-ascii?Q?kXGC/oWDUe+umz/LrYKzLZhuTs2Vp8YkOPjPjrbUe1NPkxk42i8bZwqOTxGu?=
 =?us-ascii?Q?MANXCT0aI3RzHQUammuQtTIvE+39uoW+Q9GCisER1m8R9Mc4YPPQmZmSaYyy?=
 =?us-ascii?Q?JZOnpJz8VmkI+AcxIq0rSbu6BKkLyGm9xKtIfk+jGPY4naYtHfjG06eS3Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 19:51:54.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d706f07-d75f-4763-2845-08dd8c0e4976
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Mon, May 05, 2025 at 02:31:01PM -0300, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 10:27:30AM -0700, Nicolin Chen wrote:
> > > So when calling mtree_alloc_range:
> > > 
> > > int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> > > 		void *entry, unsigned long size, unsigned long min,
> > > 		unsigned long max, gfp_t gfp)
> > > 
> > > size should be the number of PFNs this mmap is going to use, which is
> > > not sizeof() anything
> > > 
> > > min should be 0 and max should be uh.. U32_MAX >> PAGE_SHIFT
> > > IIRC.. There is a different limit for pgof fon 32 bit mmap()
> > 
> > Should the startp (input) be the pfn_start (i.e. pgoff)?
> 
> pfn_start/pgoff is the output of the allocation, it is not an input.

Sorry, I got it wrong. Not "startp": it's an output that should
be returned to user space, as pgoff of mmap.

I wanted to ask: what should we pass in to the "entry"? An mmap
structure that hold the pfn range? Or just pfn_start?

> > In this case, it would return startp as the ID, which will
> > be further returned to the user space. So, basically user
> > space know the pfn range, v.s being given an mmap cookie?
> 
> Userspace is given the pgoff to pass to mmap as a cookie, it doesn't
> know anything about it beyond that passing that pgoff will get the
> mmap it should get. Userspace must also know how big the mmap is.

Yes. I got this part.

> The pgoffs should all be allocated from non-overlapping ranges as
> though they were bytes in a file so that the mmaps are all
> disjoint. This makes debugging easier and the API saner.
> 
> There is no "id" here..

Ah, right. "ID" is more of the xarray term. Here it's "startp"
right? And it would be used as the "index" for mtree_load().

With that being said, it seems that I have been misusing the
mtree data structure, treating it as an xarray. In your very
first email suggesting the mmap design, where you mentioned
"xarray" first and "maple tree" following. So, I thought they
can be used in the similar way, especially after reading this:
https://lwn.net/Articles/846175/

Thanks
Nicolin

