Return-Path: <linux-kselftest+bounces-32606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CBAAED63
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD343AE4ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6A28FAAD;
	Wed,  7 May 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQZBUsr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4F28FA84;
	Wed,  7 May 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651021; cv=fail; b=p0UL8pg8+zSeF7X9AytdAr7NcCk4iTcjDQzPSg+delT06cacftW3jUuVcygAGO4yRaaFPV5ggkj6etmfu0hjzZCMsYJu55LgX9NsMQF9ShE4sAaJP0TC+R0hS5zgvmHyiZb76fecc+sqqXPVJaTp5ozrbJ3fJEfAq+OpH3OPldg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651021; c=relaxed/simple;
	bh=qtaB9zLrx4Ehei6z1FgN9br+hFHuSMtHRE4zkvf7QoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx9XMIM53UFMOd4KJBj1mBv7E1FY+AXVEH7K6n+aYifY1UuQZmATZcDDLPTNsYxqcRLAmMXYVvUeLvn9ZgxUbNa7l4LT/Q1dp9W9P+BygL0mWqXh8l6N71O8WUJd1YDYZDy5NQfnPLOBiWMBOhponOfl3hCUVb2qEE5XAOZrTXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQZBUsr/; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj/v9uIQ1qp8UU9ARMXEiLqHC0zyNUVdJSGKkQ1PIhV09muzaEk5idWNwIkUjwvKc8H0nVmwQwzECsdnpDwchHsFy9n6lhsLkh5qy2OeZB80XctWyV4mQolz91Mit/c4b3mX+loAn68pbgL7o3/rSxK2m/17o9r2odm7tfeTc1NymMQcPTd2l/KerAZ0rJTNWNOndgv0qd+r8Rwd+Hq00kGD4LNdM4W4423VaLhGwQ02xydgoXsv5yyeSerAWlLEdcoNxpmSZ42vmfw4mWh+48Wz1PSl+8KAz3izIdrkSyL12DDqNaFYZJ/vGiYQG/0eEuakkx3SvTRW2I2OhXwSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBBuKirHhbij22TbcvU6Mqo/8sTIvROlRm8Rgh0sDNg=;
 b=RcBIn2+cVvtrXjSxn/K9EjNiib1bpxIZNNPkxh8CnNwD1HzxJoWFpQDToojvk0Q5VXXyBxG2+vbm6cxbV2XDbLGMZrlu6i++ke2ovxjksrRpDao8wDwSbptGhhfaslfQjjc1H1T70XWPpTNcPd+16O1SVH/3xaYKn4OICeBv+OQl1bS9b98UqGy1erGG6yBPjXukJfTe1PKkNhXJqQtlF5zsZ6+b4/fTpT63eo6LgI0LmXrR02950q4CzG5aWmZdOI9eW3NFLJtPv3VNpH1OG4y2C7i07tX8X9qESQ46EO6o2IOmEIgmKr3AhPbhJdlK+grlSWe9yOkrpLTU9E/uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBBuKirHhbij22TbcvU6Mqo/8sTIvROlRm8Rgh0sDNg=;
 b=KQZBUsr/uEsZ6f5rQzi841Vg9SgKvfI+S6nWhwxLAg9kRf1EdwKhtemKj8o63zCRuP04DLSV/BxVMB/m0qpRCFVNYra40++vvr43qSZWRP7vvXFmvG1Lr52ipz7W9o6ha8j8NPgLALPmPg2tdP5XvLGUcF+v5bhjTpDIYk+pWoNSZFMftCnD/gkJK6ip9kvqPKThitPYpX8Feo1/sAyjgBfZkrVH+sJQqrYsLUeCwXI0ctbtCFTAtv2pRHrm/L/G7fFawj6eJfpNZ3F3ynGSzmA3GK4x+bB+0lsvNau9VW6/tsXv93AGzCl+i2cJF0zFlEthkVKVxWqHEWtG4oEskw==
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Wed, 7 May
 2025 20:50:16 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2a) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Wed,
 7 May 2025 20:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 20:50:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 13:50:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 13:50:03 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 13:49:57 -0700
Date: Wed, 7 May 2025 13:49:55 -0700
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
Message-ID: <aBvHcyrLbQGerWFa@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com>
 <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com>
 <aBkahmXQGxFC0Fdw@nvidia.com>
 <20250506125425.GX2260709@nvidia.com>
 <aBp28sjZpPfDUfYr@nvidia.com>
 <20250507123648.GE90261@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507123648.GE90261@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb38684-c7bc-4f1b-53cd-08dd8da8c5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VcAp2uMyLZbLRz0zIoEA9iiRkXKoO1WSQN2JziSBBU2oXSA6qCKqXvUt10qr?=
 =?us-ascii?Q?AGKbMjDHef86+5uKttI03OTLY3svRKkGDRvL9l4rItBWtUkPHwXObXCx+gJX?=
 =?us-ascii?Q?qLDyUCqxvo4tb2NKPYDX6oQlZlKoIs8JmYKRvKDrsGEVXwLd3BOKBndEYZ2Z?=
 =?us-ascii?Q?HUBCZs/MeWkGqNiJXmzsQGLE1OPPNXCm1MivqIH6/OK8aRcjMqYS62GWxg8F?=
 =?us-ascii?Q?lBlKNLgH/hwDDXdunuAsQWELj1bHvmCIoV+GxFO52y/cL7qiezdTFQC9KxUB?=
 =?us-ascii?Q?B940JiXWOcZEIxjjR9RmD/oZcpg7RSF7+GR7nIUQdYTPxlaxa5PRfnzNR01y?=
 =?us-ascii?Q?/lHh4HXYnrbgvMDapouEJ7QcqBOU2rY3oD/MfHuYJ8hIBlrKJJufwE/Daw+8?=
 =?us-ascii?Q?A1l3uWXw5KCWx0wVy/cIzlbHsxfw8OaYoRavVL28ssYeyiuJAj+zgdAYDZOX?=
 =?us-ascii?Q?NAwUOXPqy8gs9t3pPLfBdebWvqy7GGY0W3iJ3BGv/6fC7kFX7x3MVvHJszUr?=
 =?us-ascii?Q?fhjyuZwa3wCVmnosNREJA4fwyuBy87F7wdPlpekE5p7sETuvWft2T60E/9Hl?=
 =?us-ascii?Q?20TwxOWW00RjeWBBJ9dzKZlMuzvlW+LKiktPzIzOYXjESGJeYr9Kpd0Q4Z73?=
 =?us-ascii?Q?cb64YJ1zJwq+5joDf8nF3qejbVxyKQQnZVw/VW4BlQHZtNPXT5zr2wJ7w6Cm?=
 =?us-ascii?Q?rtgz9XXpdmURMN7SbBVHNQqULDCbtW2YswthY9HIOZ164zOpB4xeZHMJZY2j?=
 =?us-ascii?Q?ChacXocR4GQhR7G5fkjKihMaQpT8alrjuEgXfv3hJwOeXB7PEhrgVpzGQ8FL?=
 =?us-ascii?Q?lMslZTcc3PUwsQ2wqSm9CyUGI4NvZ6GXde783RofNdugqZxJTl+DXVGcuRjP?=
 =?us-ascii?Q?5f8t67TjBM3FOS/9brZnhAHJBvzIFBoFtvBrJA5PQHWd2ra7ixgu3uGun0PB?=
 =?us-ascii?Q?lR01N1Vo3Ua9PFKtBnZNCSfgqJ/GG6rIQNMdxE2jjp91zMbQKWsbjTlx24kh?=
 =?us-ascii?Q?N10hRH/EpAMmxoiniJw7AWmZYtZoZzWkZn5iL+tCb65vgtYdFKCCHtiy46/p?=
 =?us-ascii?Q?Kj9YpHGjgV82LpC9dWN/sPHUDPuoEg1RhOaTtr3FH+urjLxDAHXkMya7hFst?=
 =?us-ascii?Q?Bm2sXF5WVrm40GTy3Fcg63mg3pFs7uwXjAddpzUiuqX/k9FPFalIRSLrvZEJ?=
 =?us-ascii?Q?+RtToWAhdowcf3M10L2QXFbxKwj0XsXUvmvic9sg0E7QjJpE81Do+BengdBd?=
 =?us-ascii?Q?FSD3KtwbP8ySLyyManCq/xMzEVqPxnkJ9wpqd8OsjiSklMGm2HclB7+qyPt3?=
 =?us-ascii?Q?EHPXvcJAAbLIVgo9sl0REY85z6xJ3GzEjq9YR0tk5abYrT7wrRqaw7RLpn+D?=
 =?us-ascii?Q?q8BIuxT5OWKL1710K9aclniASRDblu0VurRh9p98fhEgwH6b6RvH09K3l9xr?=
 =?us-ascii?Q?GQ9D76rbaHOm9pZVLAZ9NacAkgCF127gjfgrrFz5UMP/qxZv1ogRdP/VFzq1?=
 =?us-ascii?Q?RxoI719o1oz7zhqJzsaKFUG5Z9TgRyOMeSEP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 20:50:16.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb38684-c7bc-4f1b-53cd-08dd8da8c5b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

On Wed, May 07, 2025 at 09:36:48AM -0300, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 01:54:10PM -0700, Nicolin Chen wrote:
> 
> > Now I start to think about the FD situation: either a fault queue or
> > an eventq returns an FD and holds a refcount on the event object. So
> > the event object can't be destroyed unless the FD is released first.
> > Are we doing it incorrectly here?
> 
> Not necessarily, and maybe that is a good point that we are already
> doing these cross dependencies. But we could fix the FDs with some
> work too.

Noted it down. Similar to unmap_mapping_range() in the mmap case,
is close_fd() or file_close_fd() the one that we should use in the
event object destroy()? Either of which is holding a spinlock, so
likely it's safe from a close racing, v.s. the mmap situation?

> > I see! It just needs to call that function when we remove the mmap
> > for a vIOMMU destroy().
> 
> It is a little fussy to setup the inode as well, but yes.
> 
> The other small advantage is you don't need to setup a special VMA ops
> and do VMA tracking to hold the refcount on the vqueue object.
> 
> But there is also any annoying race with unmap in setting up the mmap
> PFNs which is why vfio is doing it from a fault handler..

I see. That's why VFIO is doing vmf_insert_pfn() in the fault op,
instead of calling remap_pfn_range() in mmap().

> So maybe refcount is the simplest option for now. We could fix it
> later and it won't prevent close() from working right.

Ack. I will keep the one that I posted in v3.

Thanks
Nicolin

