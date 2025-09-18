Return-Path: <linux-kselftest+bounces-41856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D51B85599
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D503A3B36
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8C30BB85;
	Thu, 18 Sep 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EkTMU5/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472272FFDF0;
	Thu, 18 Sep 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206990; cv=fail; b=kwVpRN0b7Dx0DuLvsyi32bUp2gCTMeGB2yjBalfS8s04YZeWTsxqWEhOEMGNKldDBXEISa8Tth4scd5m+YMw//LcUO+mNFJZcNiFdjJyRNp/cF8BlQtWDaRUDHSlDLYCJ5I6cUlUTt95MZ+h3ERqYfK0JRPlMY+5YjXvBVc5DMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206990; c=relaxed/simple;
	bh=eO0X/w+cMMyIYYgimFkgdsOqw/Mm98Zrmjj5/67Km7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H6LRZ5ffw6ElixJVG2gqMMMH+sETSARawSFNkaJxPRULBQ3mvo53opJPhOTPjPAQpQywymmyYvLVPkla95DlJeGijW1tgJuelsif+DV+Im2Gzhh01WfEX0kawy+A/zr5OLeIR8e+EnAeJluz48t4mQOUFINa2kYEcdvrF4OUyw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EkTMU5/5; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKnOpeMuY7dPFxfD37Mw8uKL387Qs8UqkWyDqRCW6GhwlTRS0DbJQ8pBiwSOfsfMCxbVc3cu+SSqnnZgYdZ6GrczF3pZY3psGI9OUSdA+8p9agWZH8pLL5oiXpE67IyUlF5kYuef1g+Yc+7gqrC8tm5L0JiSm1sL0qywMmH5lg8j/8c1aX1k6hH6SlDL534Jq8sfB1i4UODXmbr78Zy1Qis48WVnktUcGY+rPV2rtzrVoOSItoQh7mlAiWKXPaZZw7VDEJR+3tSCd0JQSAuTtxwnvjvobRNl3XUhAL4AFmxpFG+F8o9IV+K3vIf6vSTD8UsBZFybBF07gk7Y0n3mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjtANl4uG3VUY92m08V6Y8ONKDeeXfzA8kcPmqB9Clo=;
 b=EQxPbrhbmiQGswW5I0tb4QpJCHMiGEErb+NDp60KJwHrSHPSFe6MXiHlU17GKK/ss0UolQrbi0CDtGq7Fe6GX95fbhCgSA4T1zlCxopt6RbaSL9Znvl+qWRzV4ZyMiquYXmmofMh3v2qs6cwZAWJheA1hXXqRBY9AD9Fq9BtMkj0wdXYTAmXx1qfr0VaVPgFdQMuI9AZua3CQa+YrXuJvVx9GE6n+HBKEX2XTgYW+0AxP29m6MpAFV3IrSjPWUlZ6Il0XufG8CId9d1aIevXjo3cdHZcuwYuMIGZCDcps+fko82ad57Ve7iCNl0tJzv2BJDLm7D42UGdp/t9s8tywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjtANl4uG3VUY92m08V6Y8ONKDeeXfzA8kcPmqB9Clo=;
 b=EkTMU5/5GqLcO7k2ucG1uCkKqIghFeVpKoiI5k1m79GSg/5LqZSFUEOwRdl80HQPmzfrzFsVYXc/NBxaIBTvThFLGZSJwjxpqBwbn7KwWE2vVEz+mMFYh6RWd5HorEO2yvKhCqqgCf0gFckta45IDudU1STK3jggSxRcJalBiRjS2vgk9VAPi2fIr16y6DDMnAMu9yKrW0YQOwsyZGZH+3ZwucYEH4I/6Hc94pbzmZPlzI4pR1kfZm3R5+9GHhp0BgNxbUf/1f9ORihRRR37To470mcWegTLsaWrXVq8mW7fGHwRfnWVbLjjSOWBCrUPnAbKU0ZPCj1DbGnzBjDruA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 14:49:45 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:49:45 +0000
Date: Thu, 18 Sep 2025 11:49:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
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
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v5 01/15] genpt: Generic Page Table base API
Message-ID: <20250918144943.GP1391379@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <aMDzLC9nV47Xvud9@nvidia.com>
 <20250915155152.GC1057776@nvidia.com>
 <aMuxUzvxQLvouG3c@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMuxUzvxQLvouG3c@Asurada-Nvidia>
X-ClientProxiedBy: YT4P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: d803eeaa-c0a7-4e35-3f4a-08ddf6c29ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eagex2exxSu+dogm/NYUVJR1j0hqrO1+qvRNDMpIr9PrNjB9VhGOvs2Ib2Zs?=
 =?us-ascii?Q?ZsKyPW0Je8EsVCs0zn8R2Ir1FFxOJJklG2kBtGqsgMJEmKZpcbsbVJqyT5Gf?=
 =?us-ascii?Q?ftFTMxpyC3xcVCq3G1SeNxMqhyDiDNALKZQ1tnIOzuyqYlPav33yqRqZjC9l?=
 =?us-ascii?Q?VK7fc2053qhbAvp3RZ/2fEaSc+/itiEQrTUPdUESA//trikWvgm0Kwr25FDK?=
 =?us-ascii?Q?wOTFDtUAtv6/blh0VLFFNfk1pBD9mWOGRCQszz9AQLJd0zDLWvZkArJ8Xkf8?=
 =?us-ascii?Q?SZOHKLcfISIIYwdT3qTo1Yhf1JsF6tBEivGjtObQdKctaStPkSi4Sdz0TcwN?=
 =?us-ascii?Q?NsDFmUfkS2uNODHFJkorlmnUKgmH1CU6nBynTsKgv6zEEWnK5NKKH5mkwPs+?=
 =?us-ascii?Q?uahyKhoxabTHtAhGAKPuf4kIJ9xMdDowaR7WteCBqdDdGscnW1m93kFAIvqJ?=
 =?us-ascii?Q?sI39pt12tyXHyRIyiKuWsvmdJm0dFQewQ+7G1u6xWVUJgDQWPCDfWf8TuAN7?=
 =?us-ascii?Q?sT3EDvEIkeAEsfg/OladDMzft6+Xu0esS+Mx5q5seU3yJYgic2uIPoUJZEU9?=
 =?us-ascii?Q?J/AJzMZb7kIIykJcECdr5XCe6UXm/Ab3l1IsI7UV9BO2U994VW+0iaJIT2px?=
 =?us-ascii?Q?tRR9saksm7KWoQqhbqZosKmHFAW2BXZMh64oZ+9SyeAMbk9Otk6SqqSUznxr?=
 =?us-ascii?Q?st3rUkdb89fuouZA2GaulJ8MVcDonKbgNXnVs3PKXRXaM/PWnhVbo4oKc6oR?=
 =?us-ascii?Q?c0LuH3hIt6o88SmKC1Emt/yd856ExVoqVkXDlWcnP7gT4MRUiOGDr2tTFTlR?=
 =?us-ascii?Q?ZMmCVlfjgvYtMoxqzJ30xvnWY1JNFSYuwLQar4mkt1GuV/mIf4xlEDot/U4M?=
 =?us-ascii?Q?kVgN5DJcB4FqNqgClfaOcHbn8rcDPLcO1tyagTonZzZeLW3HTqIu6Vt0b3/R?=
 =?us-ascii?Q?Ji6MyIJFvvVeCWUG1O/PyMXW3ti/LmbSjy1Is2q29AGLhE//bRDebhUxaCB3?=
 =?us-ascii?Q?ok2HT0Td0g4dMVMfNtMHVuUoGmf3QlcSodJKf1ddo9RjNur2HmW4oP85Wd12?=
 =?us-ascii?Q?SG/Fon0l5njryTgAIqi7ElyNbR6QayvFLzCT+Ji4sis88KjRMqLbyEHAJ01C?=
 =?us-ascii?Q?hJv+5m2UzjyJ3ElZOaMv4EbNtWTrLr15mcHWtGlf2AckjsXfSGgn4l++qoVK?=
 =?us-ascii?Q?Qe4Qt+k2LgANUc+40oqXF1yKBN5GHeSn9A2XFwl9xrCpQKVaRdRP3uReBMKj?=
 =?us-ascii?Q?MQqEBrZYlFcluxbSXgmlr/joftVClM9zBDCrJrGhT5NhFOSNtF0QJYPazlNa?=
 =?us-ascii?Q?f/XRSY7yxVSgH0qykww1zdcpNUl5XvY5SRh7Gm1+350ObOaTusFnkcLgG7+3?=
 =?us-ascii?Q?bFENGcNCeCVdvLhDHzzv3BEvyX8CV8Sls3xW5TUerxmXnEAA2aEUv++WpjCP?=
 =?us-ascii?Q?m1npOEWCjfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElvBX6Rz4Q/dzTbOl5M9uTSbd7K/phEe9q/9k2S1Ichm3XvNmN3WqZeYbsiR?=
 =?us-ascii?Q?5j0iWX/42aY/l0hd/IBXlz8F7v/FesdvixzqHWRynCSW1dibj2tBB2Q5F7ZE?=
 =?us-ascii?Q?9kZ1BW3S60bYFOShw8qKrlva7hh5GiJZqxYWyXVcLkowbtv/jI5BdXQyZYET?=
 =?us-ascii?Q?LwZgOPfFE7xpblo9Q2X2757qL+p6Qj3DT2tintoDazXOyuB+lzLf14Ta1ck1?=
 =?us-ascii?Q?dL4Ns7a4+1uq51z7w/Y5OKHx203ceULv2kyI8pm3XrukBg2kNVbNGeguaTuA?=
 =?us-ascii?Q?BZ2agNIOnAsxtr5QDCVL7g1afU3lhfhQYlSu+cHaKLnDqxiUCWu/P3coPS98?=
 =?us-ascii?Q?/jdQ32TFKkT1GAf1h8PfEOmTNmFHu8uIupR56tiKI6/1OCbXLblQCwbDjqL9?=
 =?us-ascii?Q?eUuldiUOfpkKIWq0b6NVzDt/FxRyvhRRaQAp5kj/Y7lHU9lz1fVjdxwaqXno?=
 =?us-ascii?Q?AMrjLbIbN2ABIrj+7fPcd7ZupgjccqDG6h5Dn9qbS3PWci1q3bJEPZYhucsg?=
 =?us-ascii?Q?/AT4yAdB2MuqUGNm7hSRxLzVMWo+x7Mk5Q1BGuqmsv44K8GFBSveg01FDY8F?=
 =?us-ascii?Q?xtD6MeX7Fr+hawNYAoqmRTmAsa4xIEpzJxqI/AL6T3c2aZPNqKZpXKUKK4xn?=
 =?us-ascii?Q?bT5/xhz6AjOOeipTwctjXIE38lZFnF0b/QCrcKhfzKj1gXq6EkiQYbMIwhlh?=
 =?us-ascii?Q?0zRStihdeeR5+/m8JnRY4osC8BwnDoTgAdPIpBkrMtxh6QZbwOk6VpXEF0Oe?=
 =?us-ascii?Q?nDHVG9hxfzTl1cXyHlMd3z0OK10gScnwMpp88ffgPjkjbnqnsyWYuk1Tt9dh?=
 =?us-ascii?Q?BtG0e/QwESuM/0EMq2CcMbwqgsXZP9ZxnW/mOoGXSSAGc01dqP3GjRDK8Bpm?=
 =?us-ascii?Q?dTOfIcWmzRVofSzaWNAAMeo2czca75tw4TBx5BbcSZOCgIQOG1yW/tbg9920?=
 =?us-ascii?Q?HJlv+RoE7HxNhyEV4euD7mQZv016anau0Ix9FpxaYXr0Iz3nlqxADZE0s4CJ?=
 =?us-ascii?Q?AuMaan5jthWq1f3HZf9ZYo9ewtmawK+WhkLFSgHPk2/Rg0vyXKSKCE1UAE/B?=
 =?us-ascii?Q?iyY8WU3XqM4R7DIif9F7o+REQnBRrr2keHbHwgE7Iyu3krbSIQ2/G8z5VpwT?=
 =?us-ascii?Q?YDiYBjO8NdPnOgk31bH4OsrJzVYN/GgkwJTocNLt4raNkTbpJQlMusedWGf0?=
 =?us-ascii?Q?gS4ilpbDnw4cC9S/wNrIeSTEpDH2/9s8cQa1bzXZ9VCdtYz/E3s2qAkV+vHS?=
 =?us-ascii?Q?yNd/BQYX0R8jxU1by81ZJTd9V1ce+kUnvKE7A5gs/cP8t0GnyBW625NTu4/O?=
 =?us-ascii?Q?JATNZvDMaSqcPjGZyRrAIhzztvDMLF0HDVYmoz58TTBNso2OwwOQsaCv2Zox?=
 =?us-ascii?Q?vXvRP02mu/Xy24l0sA3Gu3XYvcimNDJB5k20WRFTg03v1XAeqGTe1jo6FZW9?=
 =?us-ascii?Q?zlOf3bSuNySY+vvUmz5DIpycV8CpuLa8YGE8E4n/0m81r5vVRHd0qdxAvoGx?=
 =?us-ascii?Q?LF43ekdflljO2Jq6NOVV2KLSm3rrY1hAKk/vNLR25T9ODm8k2IeQ+WB0sAt4?=
 =?us-ascii?Q?aGynHqaesoEjuh1+u3c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d803eeaa-c0a7-4e35-3f4a-08ddf6c29ba7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:49:45.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxBzxSdGo9L6chvILr0oFq45Qj3/GqhjTtf1IjgvUJSH99ivdJbibEoKp4fPBKln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

On Thu, Sep 18, 2025 at 12:14:27AM -0700, Nicolin Chen wrote:
> > > Then, the "entry" sounds like a physical (v.s. "logical") table
> > > entry, e.g. a PTE that we usually say?
> > 
> > I choose entry because it is related to PTE and in most cases you want
> > to work on the entries. The replication of entry to item is somewhat
> > hidden.
> > 
> > From a HW perspective the TLB should be loading entries.
> 
> In that case, "entry" should be a single "physical" element v.s.
> "logical", right? Because that's what HW/TLB physically loads.

I would say HW/TLB loads logical entries when it supports
contiguity. It read a single table item and expand it to the larger
TLB "entry".

Jason

