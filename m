Return-Path: <linux-kselftest+bounces-31945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECFAA3A17
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4394C34D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D7D25EF84;
	Tue, 29 Apr 2025 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLEmBMJh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320F257452;
	Tue, 29 Apr 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963207; cv=fail; b=f/0JihybjHfe073Jz5lhEHqFlPmicTfqnxlZGLqjlA3nRtUZ2eWtu3hzoF+4m1BLiKK00Klr3xCMMEsshbtyqACR5YalOLzjNBHHh6caG7NYXlS2GEKjMpH+SdrmAIzoD806CUZsjVHn7nXubgo5vgKNHlbG5twlDEGSr+M03IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963207; c=relaxed/simple;
	bh=vj7AD+xUPfmdWiL4DTrQjNuw9Xv7m3vSJuNiUl50VNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9zFlItrpSAf1v8tF68Yaxz75/Zou+tUieXkUUOa3evJE53AP32QAGlJhFvvTV/UKIWx3dDyS6ateKrC+HrKVfGAKu2OOURgT5nHWdsXrouiLKqiNSBkKk8zh93F975O9wBANLI08yUMBrxV+CTmEj2DmzUh6Qv3JnAC0bDc9g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLEmBMJh; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdvON6sLggtz25Qe2Kgh/hW16Mrd5jdUBr5LFgGHkxrD7EEBgPIs4XU4y3oxMXSnM5lWzYxyn3AjaJripexpEbiFnqDvjX+wpvfGOaslZ8AjGQ3o7FvmLU3UJKGC5OCyRVU3HGUaTGnkC7Lu1du+QKiQpi3q9zBvlb9XK5qsUtvyOfjrmk+gjCyRGYYJgKCXhh/yicwyoVyBXvPjPVxenLDKgP+USCkvOkJcXrIURf5ufnyE8LvBxDXbal/al1qG7b3b6pLLWKPx9p4XK0+bwQDWqeSCgMi884Otz+WZODH/6TMbr6l3DP78ybHh+KrZ9RGGeNPHSr2C/kvpioRjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6Y7qu+vJUjVQaSkq/TB645V4JMvB9WmNVJFD7+ANEE=;
 b=KF2qX1RpowLEY4vbKMqYc5u/ZqRZe/3G3sjBddshBUosHloZwB6y+R5T8ZDBh0cibg9Dc2DRfwjr0LujhZyYbCB7h64c8YoabpWB8+aUSAwGOTNg4yhSN50cD01SZrAxIlD49h2BYM3NV/suqj4CnZ4mWXI2Hyd9YiKuyQH5rYKO0jgRSrgNQSt3ECI6cFmvp0HTpWT3DMI8XhU8jnbVGe56mduzICkP+p0GfaNrFeQDOsol3jaa34CBPzD1EzNZHdB3AamAgykj5zB8HF52T46dXpzHtu5thIJXwyT0qhzO7TOHH+GcjW6HogyWQs15jeWpHk7bJ3ww9Nn/ppYYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6Y7qu+vJUjVQaSkq/TB645V4JMvB9WmNVJFD7+ANEE=;
 b=fLEmBMJhT4dzShUavetUYFIZG6RVFbxFkBMLnUUJybMjNRGBznOqMgoJiStP/peRZNzDyZ93LkcONQi7z7gcjlXDNr03oq3/Th4nsePCdKsdabwuJTBjxgNTYYms8PMHLBUxFr2E2XiyUPwDDDj1TJnsZu8RaCV3ovOOx/QjPES7oh6zci+dpMpwQiRmOzo0hTcCx+fi6Mfiup04pgdBwz3b8g20Uz8m0+uKQ7YLUut4EdBMDHrQyL1f6/JksxC73ikmTOJRChe3cqE6/1vL/OGMTkWVXCWL/aw4z/F9C/VEQXI/uVINxC/oZ3XWz9eXD6GDbYq7TYvAR5H2OZO1uw==
Received: from MN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:530::22)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 21:46:40 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::fa) by MN0PR02CA0028.outlook.office365.com
 (2603:10b6:208:530::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Tue,
 29 Apr 2025 21:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:46:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 14:46:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 14:46:29 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Apr 2025 14:46:26 -0700
Date: Tue, 29 Apr 2025 14:46:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <bagasdotme@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <shuah@kernel.org>, <jsnitsel@redhat.com>,
	<nathan@kernel.org>, <peterz@infradead.org>, <yi.l.liu@intel.com>,
	<mshavit@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBFGCxcTh54pecsk@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 034ec9ce-8a34-486c-6b16-08dd87675350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tg29d/oKrJE+6h35+T9B/08T2yz3PQS1BIv8xaO3lLrA/9S0jkkeBBg0FVmK?=
 =?us-ascii?Q?N0x2lUh78mjIoaNcftc2/npneWuASysj9z9xK/v1cixWW56NI1c5qLtmizX7?=
 =?us-ascii?Q?7xTuZzMLCT92Z86HwsA7vhHfeA5bQCbKi2FZgZ77snrwY4OfsxPpahax+gTi?=
 =?us-ascii?Q?i0j+ZHoyavfz493v9k0Q0Yj1c9//Fms15AlNZVZO1pWgJlJ7b4ZonF+T6VWa?=
 =?us-ascii?Q?CMl7krOYpXJBtOK+li0jyXzxwJoDJpy6UxP8eK9/nct2AoCfXe6oK4c9AtFs?=
 =?us-ascii?Q?g7V7ITx81kywvLCNstOJAKbQB1gHGvm/IWoQbnCcDvQvyqjrNxNPBEi8+J4e?=
 =?us-ascii?Q?0op+gjtAC/MBbv4Dbe1Pe1WWDhqDDZRu/OR6IH4PhEoVrZid7t4I32fWoGhq?=
 =?us-ascii?Q?dwnKfSUfxstbTJltCJS4WD+6/JQYgMKjZ3D6p68i3Ok0bmv6m38Wq+a0BaD+?=
 =?us-ascii?Q?0k/fC5rykEGNZKCZHUe3FM9NvJcd6V87ksaNEo+020T0er8hIKDARN8JeqbF?=
 =?us-ascii?Q?dsyzSnRY3Q2amlRW6Nf5zcZTFC+dHlJJLs8GjqS/8M/c1q2NqoRje+ULro20?=
 =?us-ascii?Q?QXA0c6NdstQWcRztPsFyqdEuku+mz4Z//AjEY8zzN8rfiU+SRVcbWsdCW46u?=
 =?us-ascii?Q?pyQJU3xPl3geyfFIxRn0jKek9DPFSrBnd2lgii3f4pc1gcEWW4HbADEBzqAs?=
 =?us-ascii?Q?N8ITQabQz4i0u03dFaj4j856r+ddLjymbXOmlFEop6MH51hl1HqXxMbZ7oTe?=
 =?us-ascii?Q?70p+yk0tHgQQsvdf3triOie9Ergxg8SAqXMwz8ZYFYXu5O6YG3BGlZKDPTyj?=
 =?us-ascii?Q?F7UTugaefHnOPyG9rsXNLF0qERUyQeNXSGLxdL3UCc0qEJ2SAmSb1RCEq/qZ?=
 =?us-ascii?Q?gudilKhxdY8hgiVUVWQIc+dFtkIld+uHRaB2u9atr3YNk8HmeyxAU+XXNBP6?=
 =?us-ascii?Q?KejqUyHoHSXK1hYUfJolS4lr5MPo1JaTUxqT1PIU4e+3c3VZ1dciK+hqSx3P?=
 =?us-ascii?Q?EyH6h6RDdsirFQBvnpD/VgE3iYxIOiA2Oq+he4b1Ho+QfL9xaBOwVTd4wemF?=
 =?us-ascii?Q?MHJxwNYJHEOm2yvuUY/afuqnHVxY6M0zp265tFGSLfCDe4RAcCu2TIowy23s?=
 =?us-ascii?Q?UmwLdr2vl7Hxxke3SjaHdADJ9I1eFD587fVwHmJwIyEDPnBQkRCswqAygf4S?=
 =?us-ascii?Q?YLB5e4JMrdIjLsYo/Hje81YdU54nuIGQYQMZ20mE93bUsA9WUdWVJ47QP21d?=
 =?us-ascii?Q?o+ROXik1XbIm8UGLwwDpjFoeEjtm0Imesijd3CRi1hY0NpUeA4IBJKyjeKLN?=
 =?us-ascii?Q?roWb51rEJlCfroE4DazKfqbjoJTkcK+hYEwRmhLZq6QihBjURxvKhMZdCRr0?=
 =?us-ascii?Q?uHVNhteRfzDarTe3HzcL7Mh1PflZifFcHD4MuY7OgQ7RV2Q5Q1VX+YBFxuVB?=
 =?us-ascii?Q?WCn/oaa9qjqkrIlPhoKdMVUQTNxkG+WLW3NidDtuOKnczOzG21xpNn+ziGZ1?=
 =?us-ascii?Q?b90Q2Zfuz3dVjK91dOtyxF+qNmizmLuRYkiC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:46:40.3654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ec9ce-8a34-486c-6b16-08dd87675350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

On Tue, Apr 29, 2025 at 09:35:07PM +0000, Pranjal Shrivastava wrote:
> On Tue, Apr 29, 2025 at 02:05:12PM -0700, Nicolin Chen wrote:
> > On Tue, Apr 29, 2025 at 08:55:47PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, Apr 29, 2025 at 01:39:09PM -0700, Nicolin Chen wrote:
> > > > On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> > > > > On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > > > > > +	struct iommufd_mmap *immap;
> > > > > > > +	int rc;
> > > > > > > +
> > > > > > > +	if (WARN_ON_ONCE(!immap_id))
> > > > > > > +		return -EINVAL;
> > > > > > > +	if (base & ~PAGE_MASK)
> > > > > > > +		return -EINVAL;
> > > > > > > +	if (!size || size & ~PAGE_MASK)
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > > +	if (!immap)
> > > > > > > +		return -ENOMEM;
> > > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > > +
> > > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > > 
> > > > > > I believe this should be sizeof(*immap) ?
> > > > > 
> > > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > > 
> > > > mtree_load() returns a "struct iommufd_map *" pointer.
> > > 
> > > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > > sufficient for the given "size". 
> > > 
> > > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > > for a 64-bit machine. Whereas we really, just want to reserve a range
> > > for size >> PAGE_SHIFT pfns.
> > 
> > But we are not storing pfns but the immap pointer..
> 
> Ohh... so we are storing the raw pointer in the mtree.. I got confused
> with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!

Yes. We want the pointer at mtree_load(). The pfn range is for
validation after mtree_load(). And we are likely to stuff more
bits into the immap structure for other verifications.

Thanks
Nicolin

