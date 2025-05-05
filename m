Return-Path: <linux-kselftest+bounces-32411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C268CAA9A59
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4D17C0C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364926AABE;
	Mon,  5 May 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jboxQEYQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C1267F59;
	Mon,  5 May 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465725; cv=fail; b=GCjkY7hMCu0LxJDQ5Wk0ZHl+Bo03EV6Irkz9LudF2blX4VpfInvsXQ2w6RRFZAmB6iFX9uMfCKv5trwYFNu47RDnaILlhsPBLXuPC2p/rru62K0fO7mwl5hqmavVqLXliixh7IrJH5bu7lYLYiN7Xa8Uyha2tFj3JmPj1HEl0PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465725; c=relaxed/simple;
	bh=BI4Nc0jMJE8MxmyP1s77W1s69A2nyTbDFerdt9T6bqM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9d40ejxURtCDixM3V0gDdpFaVMu7f1544JITTnUupqalD7jQ/d+H7u4Bm+6/7RvWITdKSQaIKLOUHIJ04W3g6kr2pIUpAvmWi6W5YXlHjLByWL5yaR6D10rJhsqyZz6XM3oRuOfYHGX7n+IX2uxGhiR96RfV7VFKmtJQK+Nzkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jboxQEYQ; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl9HTel85K5llJQxVlBYjkKzNr+9Qt8Vq0dBzlYCoZvMfHlEk1HSesuj/Pjs2LdO/LIECUqd6pBQYXxNVp5FfF1LK+FcU6N15wRPDE8pUV/xZ/AAjxFkw2eenXUkuFoMtWphnDzZD82FH4ecq5RlSItH6hOOAyufOntVpWDJZpjUqRxn1AmT5TcQBqK/f73ym1h2pkVv+HfODxXSIFIdg4weMbFHgVHX81VdDexxmpWJLGp4k9eKKNJP/rRRRc5Mos5KCdcZ+JvoQXuB2nIgAU8KoUJIcxyPLTc2eMCDVEf8bLqUb0wkrT+OmUcLOj3FX0ZiJvD+OaGC9RLLnEJwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfoUNRkWcljLWHU6dK3xrDvDKWt/8XXzox7lJBPJ0XY=;
 b=ZwEXfxEaYae0cTS2YC7MhrkqTBWbhuiofX856jt8o0j/womxlUgqoIIRKPyFzTjMKxnhESTuPK8cX9ueopJorQ0wwTQSD9eh88anf9AX734xoIZ+INqMph4tcwSrXeOpgHdJBqMDeAVhoxhWZIJf9tyB9YR6iC58anS7a+Tqb6860n83jP7Hiq7EGrXkcomqgMRqm0z1admPnS6DiB6f/fA99755fVGTAvKmDuz1jtec07i5MJ4J2ApdC1hIIqJc/skqzoGB0i4NDFM2sQhxbzcFs+8Oh5a7oBE/FngN/MxGsFAr42RgkJibt8ybTO2lZ+vViExjUUr0YJlr6AQTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfoUNRkWcljLWHU6dK3xrDvDKWt/8XXzox7lJBPJ0XY=;
 b=jboxQEYQKyP1R8JDEq799qN+LVX06D2zxxkBqo9K0tpnxaLLCHpdFSTi7uiirUlalypDepQk1G+N1j5h5tl7EAwurZgjZq4yzdhVfNj5l5Wm53PXq/HXlyMrSGGUb/mbp/0yGobBtYL4BjVVEtMv6nubfE4+Qw/XNzt8Qt//OjxDFsCv8Zzt3twijQFTEHOe2Je+tl1cnSy26JT/1TmD+R/hG+CUNQT3YtV9pQkHnRBmaMERbcGmGOW6z2GnxuNjBulBsUC0fmHWy+4VGlMt1+dz4yyA+/znlT3EJoKiqvLYy4IgLe7lVwXEm0IiyEAdVLR+NNclNDZETw9SDIVLZw==
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:21:56 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::ff) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 5 May 2025 17:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 17:21:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 May 2025
 10:21:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by drhqmail202.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 10:21:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 5 May
 2025 10:21:38 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 5 May 2025 10:21:12 -0700
Date: Mon, 5 May 2025 10:21:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBjzf9PrYnwF5uZN@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250505165019.GM2260709@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a41d27-57e2-4798-1c04-08dd8bf955f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7XiubZAculbzqVmX2gHKTfANHhpgZ2j/RJRW71YrkXWUHjxek6Ybwseg6CG?=
 =?us-ascii?Q?A5rFBMCqJ/dOACIdsXd8ZK4MWJ+aBgRwndB94AssACeZWlfkY5lgbR06s907?=
 =?us-ascii?Q?7EITuVM3J4OzigLRL2LJjO9/FDXa6YPe3s4/GadXaAmoBU0zvuFnqugZ+Py8?=
 =?us-ascii?Q?AAUpaMXUi5kgtH2KU3mCDqN+lbHNISI9ZZ/zstEDhJo/rGY/BY9jalHGTiId?=
 =?us-ascii?Q?rzygChlTRvsNgZ6nt7kOI7VylcpTYFpYDHklyeoAZQnDRgF+tTWy0tZ/0sGk?=
 =?us-ascii?Q?yM2yleXLzQHYsTE+4KMTHEQCWw8IANF8YoaA9ZmnAn8WxI1LGGM+HU7BqmSp?=
 =?us-ascii?Q?prHGd1pnc2XCSaAZBxz8P1NPTLQr6kBfTD3IxA8myi1rOaXD3TpQDOpkMuuX?=
 =?us-ascii?Q?pDYUrpiPkMVhYYZfISjI3X3hLybCVGnp+deIYHQPrbuT+GN0GjB6NWeYtbYy?=
 =?us-ascii?Q?K4gmLQc09ZbjMs4Ckno2wIerlaQnh8m9w79Ay5kksuRLAxq1Ik7UL46pIMC3?=
 =?us-ascii?Q?bnZ1LL9qR08mvwKhD6Wzq806Ka9JrNhruKd62IMXQnPk2LWfZ/y8jsxypyA9?=
 =?us-ascii?Q?x+/hN389YPStosrQaBTtIKPaBcH3diddDlm8HR9B3Puxury+xSGIQGXcP0jf?=
 =?us-ascii?Q?9Ls9PCWwCtCLoB4yrB6c/ZqBf4unGgQz/TUE+dB7pNRu4nK86OCXa3YQz49/?=
 =?us-ascii?Q?LWeaT2hYnMKVZT1yPN6+CxMnZIuZ+BWcVBPMO1AD7LyleFXcomBMGMbe2le7?=
 =?us-ascii?Q?JTjd2j1KzHokqff0Mq0+wVuYrop5X4WrrzuPdNUpxQ7DTctluwnGZaflcWD+?=
 =?us-ascii?Q?Yr7vdFNR+GcNJRbt3TOOrmadBdKf8zGR91czd51lWfFx9BKJjs7/0TFwA58T?=
 =?us-ascii?Q?c9YyCoPAAw40cq7BAOWEcYbjJw7HmEX852NmOIIRD30Jgg/DxjkXvRsbivBv?=
 =?us-ascii?Q?AQRf6zaKn14Wi7Vc+lmCHv+h3Zdb2ZCWHS8NazQWnbw13XmX6tI7q3Xvgisk?=
 =?us-ascii?Q?jU3oAMUDLn71CeAhwbOtJbA2R90nkkXDI4DVl7hSJB/0IJ1QR/QEN4EL8UP3?=
 =?us-ascii?Q?q5WUZTIXZHkNkuNBMTgJQEgzY9VFuuR1U9D+KLXW+2KaC9B1ck2U0pGYDOK8?=
 =?us-ascii?Q?VIrpCNkeeYN+Q+v/Rw677u73WcSe6O4w9jXa2hGne60O9AIOEDPS6gh3iOBY?=
 =?us-ascii?Q?n3tDKos9hqUcpiLhu9oe/CXglkNm9lmBG1stXh/QTKbrBSlb/teDk52wPS8I?=
 =?us-ascii?Q?pTX/99TvXDSjkCancZAO2xR9ApuI3oTJB/ZNq425QSxVPruwHruHucRmAmWs?=
 =?us-ascii?Q?0ZOKoyJVeGW0/XitAgmEtyVILzpSl35NyHVD4fFefabo+0xSyQZttA2Zot5i?=
 =?us-ascii?Q?rzZ1B8aQa3xZ/fahIdAs8UcVY6ZTwbc+H7icGjTNmVGVeedix2hwohKNzfq/?=
 =?us-ascii?Q?dfJLDuRR3bH5WQibt+dwCp5UKiy8RILw4d1yreN/ZSA+dZytg1kUAlMaiMAh?=
 =?us-ascii?Q?NPS9bIybOo5zGdOqggFUn7VdwUygB0JCQPiy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:21:56.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a41d27-57e2-4798-1c04-08dd8bf955f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

On Mon, May 05, 2025 at 01:50:19PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 28, 2025 at 10:50:32AM +0800, Baolu Lu wrote:
> > On 4/26/25 13:58, Nicolin Chen wrote:
> > > +/* Entry for iommufd_ctx::mt_mmap */
> > > +struct iommufd_mmap {
> > > +	unsigned long pfn_start;
> > > +	unsigned long pfn_end;
> > > +};
> > 
> > This structure is introduced to represent a mappable/mapped region,
> > right? It would be better to add comments specifying whether the start
> > and end are inclusive or exclusive.
> 
> start/end are supposed to be non-inclusive range in iommufd
> land. start/last for inclusive.
> 
> This should be a u64 too

Will fix.

> > > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > > +{
> > > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> > 
> > MMIO lifecycle question: what happens if a region is removed from the
> > maple tree (and is therefore no longer mappable), but is still mapped
> > and in use by userspace?
> 
> I think we should probably zap it and make any existing VMAs
> SIGBUS... Otherwise it is hard to reason about from the kernel side

I added in v3 a pair of open/close op that would refcount the
vIOMMU object (owner of the mmap region). This would EBUSY the
vIOMMU destroy ioctl that would call this function.

Thanks
Nicolin

