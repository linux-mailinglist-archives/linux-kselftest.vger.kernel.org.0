Return-Path: <linux-kselftest+bounces-32657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842ACAAF988
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C92A7BFE45
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0782253EF;
	Thu,  8 May 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOzGvXrp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB51DF25C;
	Thu,  8 May 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706506; cv=fail; b=Iok5c9Ljm8jntw7GdfApGbtkY1+2qf6dE2JuyZwhpfZ78yWuCAenKAFhhuWozKd0Zls7b9zzRswZmeMetU0HT+ievoFtbcg/ew4AzBwaulNZ5XbRDsu0ldY9eT/ayp57S44LnP0ajVe35pNWLsk7I5OUA/WBvts2N+vy4Ve+8gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706506; c=relaxed/simple;
	bh=wbwyhSA/nJT1iX36ofW3stNjrcSxIpRPmcfN63y1dcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZRK0vOyZZnxJ14GtLBhSqnxPZmyi2LBuusHMBkKI7xzzYZl0sk+UDN3e30Loc0t1PhJ3zE9zc0SQ9jPUQ4xSro45n95hhldW5JjQQdGGNxVahBNpDrmvyRq2i29Pd+ionDCKmXQlVhDIs4auCD9FVDKLWS5OBfjcGIRsoF64NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOzGvXrp; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBkXLtIcB0dmdIup5lWJjLx+doNg3bTMluSLGoap9tAN/h/UK0PufL/aM6fiQ7qytXbELsuEEcVZos+/xYUOB55OHwZeatl8cYcQsPvT5D0rJ0sgh+ob2lpxJ6CdoGszVdP6B9vHOCQKeap+CmGrCaNe1N3d3NRE80O1mABtixLOYeGl0HwEwlD1zsumxY/br+xAB8wzGNZEdG8YjXXn+ZTjLQlDivYekKFyb93FsV6t5O+wizQ5XgplwzjOYYsdDfGvVc36Gnf6wJHZlTqc/Pi71wwUbB3XQbbLMEtE+ZB+dSdu/s66iMO7aWy85AzA2NBypOVx4nlTgiFk6XkpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbwyhSA/nJT1iX36ofW3stNjrcSxIpRPmcfN63y1dcY=;
 b=El0yg2+RrK4CECa8RDrTqVOodn1LxPklIkm5aJ2Qd2cu13YsUNW7930NFgqL6KCTC7HUhKNhGyPaJGmuznMX5Ikv5E5+KQT6Fzrij/nXUiVVX/M8A65plQls4jq6RRVuX2VO276MPH19irhSGJoK+Cjzo/h0vVGm+eOVLKDBkTI/z2BA2uhBiNL5N275V0oIm+MV85d80xyJT2qpynDrQUx2/M2uPAn6J5ivIHtTr4YM/VQfRR4AUVSrSIkNGsFFy76ZT0eLBHAC1mH2C1dwcIZMXuNFesB04q4CQllAjJKRnKOOtBHQkxbKC0VX/iQCxcmz1V5hY4sXKUPQ9Xr0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbwyhSA/nJT1iX36ofW3stNjrcSxIpRPmcfN63y1dcY=;
 b=HOzGvXrpWw/Lpls4LGVGcLR2X4ZeJHOd4YcGOR78ruBvEEer7nbhzh0x4FBhSu8Bcqzr2B5elYHoh4UD2fgvZbSzDDxbMGZJ6t9g1cgshTegLsGyLKqwTQuX0w9udz/Hb7sdk06HqfrJWn7DCk36H3kishO19EOVhr7rTrZ2zAvSmXztQoKT/ua19mqf9OElWk3q3KGajYVv8cSLD3V9h3v7ak/geqGSNJZRntyjUM1HLwT6EACFWt78RXAt8bCLvE+7ro+jeIP44nEynu1IJ8OHjdqPqHoY7DqOUZ6MwSzQO1D/PTAM86UB4QvqOh3tJn3XKrxh8PNx6A8ksG9ycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 8 May
 2025 12:14:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 12:14:57 +0000
Date: Thu, 8 May 2025 09:14:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Message-ID: <20250508121456.GB5657@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
 <20250507123103.GC90261@nvidia.com>
 <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com>
 <aBxHgf4llBd7vA5w@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxHgf4llBd7vA5w@nvidia.com>
X-ClientProxiedBy: MN2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:208:a8::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c4acf1-d7c1-4b2e-f4a4-08dd8e29f2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fWM3qprLz5Z6XxXwdnFpCCaz1SPcYd90ytL6dkAMay8dgTQPrLKrK141wAyx?=
 =?us-ascii?Q?4waAnQeyQ2zSE+p5u4wepHIONncq9Zw+JUYX7tdeuVSUya1DBt6Psj7+GLay?=
 =?us-ascii?Q?/llBbzBr5taelDkgZ5iVBgsSLTo0cFZY2kGIx5Mfr1zpGzOygwOUM3QhN8Np?=
 =?us-ascii?Q?pmde0YYtcDJrFgiYd3SZRSA6JbqHAXRgNoUxGmC1s7sikmlm64ihf69dxYBg?=
 =?us-ascii?Q?2qvveGNXjzrrKCnex2MvH2yIjO7ugpwGJx/QgjsNh43dZHMCYbBh2Y8GbwkX?=
 =?us-ascii?Q?qAAfx39USLQFJw89OTeDm9zeSfey89oXnKfzOHzZJIHT5yoDBZkZObHzjUyM?=
 =?us-ascii?Q?oVMCOCkmO1w7/QSxrGNeVZttC2St2ldvOwTpukJfeJiUQYh4PB7o6/5Ejr+S?=
 =?us-ascii?Q?jVsADOk8xObVEhY2eIXxf4vXdTrsVElHt1Vk8C1LF8mf1jxWCNz/Ut6fGSjW?=
 =?us-ascii?Q?9AtgTbfnX+FqqtatK4C1CGME0F22dD6TASbcRe0P+PFupE638mTNpf67WlFs?=
 =?us-ascii?Q?p2I7GChe767h+z7Ec+XQVWAL1kKRU76OoP0lHFCUBgWs4P34lDQkFdjz4szx?=
 =?us-ascii?Q?x9abtzJgWNk3bn9kClKWG636uSd2ApkicD32WKsx97rTJo5Ave83Svady04G?=
 =?us-ascii?Q?SMRXsJUkJPvhTTHKJz/z3C3c7sd7xzKuzzMq8Gys4eG0LUR1v7u4GUr7guaS?=
 =?us-ascii?Q?sA4NKEYIYzQbWKULG/sxl0ogq0ZQLwhBsEHvzkS9I+G/Mvt4Hh50s69MpNWe?=
 =?us-ascii?Q?lA7l4JnKmG7Nf5w8g/Hr0S21kRRgqTAwgIaz2tDOq6P14gZVVJCLZlPpw7MZ?=
 =?us-ascii?Q?pDkagkSG2+A6439uT2WrA/rsywZjGgX+yvHlbU4KNW9uoUVjzJ94sw/6tHn9?=
 =?us-ascii?Q?4bX5gHtndUnoK+oUwSRHmrcFwkkywdrdEZYT4MFthA8n1UGlnFB0pdSSjFOg?=
 =?us-ascii?Q?ayQaC+U0iaIiad/ioQUq+CmXNDLXrDUxlGzw91gcP7k28XmdTcDBRwe3Vav7?=
 =?us-ascii?Q?JxY1vdLyztP66oPM3EUSYJEJU3pS9qHZBff6TBJkNpG2jFHvhqPOsBjzqbxy?=
 =?us-ascii?Q?qDjrMjo6JjoXsrPRi20mpVyeiqFfhSdDNF4Xs639DUb62xDZ+Nl3d7EHRNJi?=
 =?us-ascii?Q?xB3X/FnHmTO9G9AvvhZLZVBz3JrJaKBbdA7VM8ZH0P/neDE5KHOMyLEomH99?=
 =?us-ascii?Q?syDAjemnhBBEot7motBV6pmQNHI212JP6mdYXh5nnCrSsoO6DnClZMESIa5W?=
 =?us-ascii?Q?mxO+Bd8jEqXmzp7FU42X3GNhNNDdb5vLePpDnMh0G7XcJJcqk2RvVvckj1S/?=
 =?us-ascii?Q?HIdHgSjce7gE4v1/3zVGSBBrf2hfk25VzWOwXSkvUdEbbzCHo8IrvnwkP5Xy?=
 =?us-ascii?Q?8z++JEJEvVoTvCeFFzkHIqvsGULyTUsAZBmq30W7tu07CHdnsG0x+dPHSBtL?=
 =?us-ascii?Q?9mvemSAj51U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fLGv+zuR2ju5xFYYMrQTYalvHQvBK8oOHm1umQvmkfm82jx9bUglXQ2+M4Ao?=
 =?us-ascii?Q?Kn7w+6vwmvaF5r4HDladtMEjGPehGe01ozfrl7bACAgC/w9vE+PZ4Y4srbeU?=
 =?us-ascii?Q?S81/nOxnCJsAnRPjX4uKaZibK5zLT0V2sw6wKxcV8xjlxbCsh5VsYtIu2+G/?=
 =?us-ascii?Q?t9Ewv8x7b15HB4oMaAHb/chc+ZrUgpkee/ATDUxcJ3iv+3zAHm7aNnP95wVD?=
 =?us-ascii?Q?ReootAGWHsQ20ONTB+NtiwgDVxg2Cf9e5S2amkBInLqMH+2AblY10G3GXm2S?=
 =?us-ascii?Q?YxdNMkQeDUMCU/YNdZMtcYGuhniBq2Syd2MAfI2FwqwzuEB+c6dlrEA20Xa5?=
 =?us-ascii?Q?NgTxKHQV0nNcfEuXHq2WJvk8v/zQWEqqZb4JqFJ6uLzZ+fMRX0+fXuSpom4k?=
 =?us-ascii?Q?5j9aePo+HgCuI5n7/k7s1qV+5bqhHUQrju2lqdnRPXcFi0Hqx9grRnSTkH7J?=
 =?us-ascii?Q?AhpzrKAsDZhtrFwQOmp4gOQiUfhW3Me8ibT0uz2S0DQ4nSCEnH45VYvuGFJW?=
 =?us-ascii?Q?+FsIob1dS+Btw/yxuDlusmRsQuGXGPBS1vSn/i1WnVkeayc8Uv9xoGPhSkAn?=
 =?us-ascii?Q?y9yZ/HVuH5cvnDnCa1sEDHOrO/bbKT2lASL4ZxbLHfZYb6TMnhQImSswgCco?=
 =?us-ascii?Q?oP084Qt7wLe9ckWozMDUFFIqED08ZDHm2v2ITylG/oLHhd+73fBp2tBjf76d?=
 =?us-ascii?Q?OqIDddNUWFfbTl9KyYAOvFGvoeae9TsHzYvhvRDq6NWQFKQmweqX9pASH1M2?=
 =?us-ascii?Q?rJc8oi2fiKkfdZ/BTQAmjX/gFxb4QYISSjIsVTzx1L/9+F20v7FpyC7yu6rL?=
 =?us-ascii?Q?f3aiQ0qVdAL/HpDkMil6KeX3oGW98il10j6OBee4hFBe6zRlNZl8lP0ZTC7j?=
 =?us-ascii?Q?xv6/qfzu6+zZazvOauzBgEvRnDZY8FLKBlr46+Ebnowk3CNsr/ubd/bVtEQy?=
 =?us-ascii?Q?jrMb1opO7qoeUfexE48ooNrVcYragXBhift8xccKrRhWV4T+/pWy1SkSJA5+?=
 =?us-ascii?Q?zaUsxVed++/qKUUrFx10uEsdh+bYBXA5/j7+97iS59QkoT4mG7BislJwlxCx?=
 =?us-ascii?Q?6IPRk6oTTlJi2fTxEOjMFvLT/IIBxTiUr3/jGnRGf3hxUGa3EcGI1Gf8rkHN?=
 =?us-ascii?Q?kPlnvkzD0Xd+lxldrsE7Y32uxpEcfOPBB6KWaiNeNrREKnnr+pxxC13SRq9X?=
 =?us-ascii?Q?xqIOXmNiZhKuI0q+T0dIZTvp8ZQTIMq0iZenvAIIJHu7w49UA4yeSXJEg5gd?=
 =?us-ascii?Q?fDyxb55AJ3b4vUHgfh1eZ/S0T2K2NqFhRbDq2uqMdo6eEvrU4js/m8nXpXzf?=
 =?us-ascii?Q?D3OascJuRFEX2IEnwDHvw9Hme7oIb377L0Et2j8N3QPocm5IrBP68sZv63/N?=
 =?us-ascii?Q?rXZU4OgmC8J83mmWLijFCDAVeu5THpKOBd4fBQ5DpPGcm0d+rjzY3K/Lf0xI?=
 =?us-ascii?Q?2Jj1LoFgeoctE2nBbS5GSZf4gTXSzHRbljz3wMp8WZa3Yh3cXk9zDsDcUBsD?=
 =?us-ascii?Q?dYZE5JZXc+2glL2dtQpOQD6qe1EFtkGQzHWAbP3QOGgJpNHUTjimy8Qtt6Pj?=
 =?us-ascii?Q?s1uiZQ5iIiuzRbp47ONl+Zf2GZaZLxUj8k/iLYFx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c4acf1-d7c1-4b2e-f4a4-08dd8e29f2b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:14:57.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbbzH8ogfr+vQq6sJiVxuuSCXXIhWu4ZCUemyZWD65EI0Nh87Mx0AOyRCKURz+cH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935

On Wed, May 07, 2025 at 10:56:17PM -0700, Nicolin Chen wrote:

> What I am not sure is if the HW allows setting the ComWaitIntEn bit
> after CmdBufEn=1, which seems to be unlikely but the spec does not
> highlight. If so, this would be an modification to the HW QUEUE, in
> which case we could either do an relocation of the HW QUEUE (where
> we can set the flag in the 2nd allocation) or add an new option via
> IOMMUFD_CMD_OPTION (as Kevin suggested), and I think it should be
> a per-HW_QUEUE option since it doesn't affect other type of queues
> like Event/PRR Log Buffers.

The main question is if the control is global to the entire VIOMMU and
all its HW QUEUE's or local to a single HW QUEUE.

If it is global then some "modify viommu" operation should be used to
change it.

If it is local then some "modify hw queu" operation.

IOMMUFD_CMD_OPTION could be used with an object_id == VIOMMU as a kind
of modify..

Jason

