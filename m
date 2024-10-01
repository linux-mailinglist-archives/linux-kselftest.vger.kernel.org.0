Return-Path: <linux-kselftest+bounces-18729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEADF98B79F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3ACB24C59
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007619D08C;
	Tue,  1 Oct 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qtValy6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392D19D07A;
	Tue,  1 Oct 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772859; cv=fail; b=Bpi7lyQvsg8B8+4vBJTZUmh078UggKHpSPOXpgqtg8QM7XnBBNL4XUrpKnoGKrsQ7TFbEhZrFppZC0qIg5aQnlUUQTRKujgtbaibGdhpOC+dE/5luKNNBIvRTtE0TWd7pqSA43BJvcHoToIXBs0RYRoQrjYCNx3JKz5BMSz+YQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772859; c=relaxed/simple;
	bh=o6yLI5UtVm9uGSUy4BjEpoNa8ahIZuJ0Ec2GE14lMYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5oP4sQWScypYcMGWSJ3RnDjPzRow2d8RbqIbIzUzukM3E+S/SnIgl5cKT99OKvZBSBFp0C+mu/UKqeRAkWUak88XTJht2UH3hPLt6WjrKhuNB3t8/tVA9os3R+g76ZrI1a2RcaTMREBbK2isGxZEl4xa5/thGf+TFfRKYPBLKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qtValy6a; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRHpNtSWogwiBr5yk0+IL62C2DhTCVgQHIwfAdMvfARASBb0fMgc9a7imxysosynfsBAnxKRkJpUZhNQ0S6V2i+DE2biU/EZ5yJ4IcJU8MhudU8uYGocJj0ZFGYaUNxfKzkZjDAFDfjQr+zg3ODwCE/MK9O/NJO1+N+g/8rC84s/5sVUS+M7qQ+E9969jdpunSPCrER1bClzC7hYJA5E0nf6Wov7ZvXLbZTZoWuT50RiCmm78XnQr0lKTv84UV6/YvT8wt4efNg8AF1l1XdNtGt8+sbSP5sIZGyRD0nZ0X/YKUlQ1i85FckHhbau3Qv/ViYyGPu2TwNcI7WcR0Ra/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUtBzc50RdH+EFt2YLXMObkUbfdaMdsP0sTO6Y/RVg4=;
 b=XDB18NLFUH7XI3AiH+sfPsrT1dXdW9Nk0IQAhe0+i+QnA5AhmLIRUac5D6Sb871R0lpccT4BYQ0NpMyXrfpnNx/e1d2oJ6ukqBY7mxbfEOVLCBGP4T0+ACcfp0Y25eT+825WavNWQJrqJsoUkwzq3GibCsIcLdbR/jyXhR+qNu3FXSCjtcg0S77k5eeuWMFNrzXkFMyh9mWeai50i7+6dd0x8cNWH5Cuc80fTHqkepf4bPO1W1X1CCA0ptlEu2f04s89khi63SZuh6QsIvRvgNXuKhKQxqrKzw8jjdRGusb9wgmyRvD3StEHb7HY9fk3Wb92Nyb0tTUTSCsBA2qeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUtBzc50RdH+EFt2YLXMObkUbfdaMdsP0sTO6Y/RVg4=;
 b=qtValy6aJ+QVP8bW+NjTyBwuUVKDhWLLWSdA0xI/R9r4OFpphB4ylP+ATbTel/AU319TY5Iidzol44pxA/Vmxh7ywDtkq6bqDNZgFla8kQ7KQYLdDnKsXIKStMsC71nZjyPAqKFDAklFGWM3Bm/7zF2lZL9/uMEVIYSftOH4ci1X9ouLBqHKGFyYmDVxJqx0tmCq3ZS47ON8xafE9X7Mdw5TCYTvp9PPeMdyEn6/If6BJIUg8AvbRfhE4vHOLvGfuigXRnT4TVOjBUMZOgN/cT9p7NVG1ZhWQhHgYgVbPNeeg4ETGMwyb3RvF6Xq+ocVAIRbH+wzjqtXR7VmnloAPA==
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:54:14 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::91) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 08:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:54:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 01:54:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 01:54:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 01:54:07 -0700
Date: Tue, 1 Oct 2024 01:54:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zvu4rZosYFjCuEC/@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtnsaWgeuuy7+cJG@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f30d74-aefb-4f18-1f9c-08dce1f69fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hv219JXzZBwJSWw1HjzOR2wWGuVXQG1hDGHZUUcrdiS9boRdK3liuWZrCe83?=
 =?us-ascii?Q?JrDCbq7jCpWTovSzpMwGWcl8o+Qj9RBPuyLtYUZbbBDUMrxz4q9nbD8EsAqL?=
 =?us-ascii?Q?za1vjD6IwhFl10WmwnFOMYjKXvdUyu66JnwMHUYRu3B5LNzEG/s63UVzkn5B?=
 =?us-ascii?Q?9r6xnhxhNah7O3ghANZPc+24+Osg6/Hi20ivjNlpOO53HkF384/UWTmJaJ1+?=
 =?us-ascii?Q?tuOYjhFNDDiPlrE4laIrjIAT+1gySOXsH0yesM49wgP31nC/VWONkm1IVYiW?=
 =?us-ascii?Q?cYVISvtlcpGzI3t58rI3apsyB0+OMJYQm57CyWfG9gxM2eELAMjWd6SRJYQa?=
 =?us-ascii?Q?lf/Zy9Ww04fztMk6ET6gQvrxAPiEDrJ4jD2JgdlAeBu2LvMB1K5DZpoN+h+5?=
 =?us-ascii?Q?DQ7iynZVarNkh6XqMQFDjwq9Bk+k8YeBvAhqh3WXoTdGtsNIqiOBmOkJ1UHK?=
 =?us-ascii?Q?6auLkrbXIjS13IEWgH4yzgyY5LyOM+rwyegu0ZeVRrnnaHpO0sPJC80SUZil?=
 =?us-ascii?Q?xWU0Tcj3uqIoSoak9d1Z8q60nz3unnEN6bhrAy196s16XjpMHLZA0DsUWTP5?=
 =?us-ascii?Q?8VFDh+PEjQCNcjqdhAI7NXVhqRJtmYqN36kgbsUCddLMZqkfUBSQIaZKk97Y?=
 =?us-ascii?Q?G99Uw9veLD7iEfdk8N7csS0MGhHnrUamiSASAa/8Bs7j6TgZlsICrlDk3vg9?=
 =?us-ascii?Q?vllc3FZAhhGqgS/NNityeicUOUOT0/syMP2cAYNxEoxqRizusCF/ZZxHOaIs?=
 =?us-ascii?Q?cDSyKgudqGZ2gRDMx5TlfkqxlAeS0dHarAyqxljtmShC4KeSHpf7n0fwFUZr?=
 =?us-ascii?Q?EwHAXhgad+jUNfG6Z9StaVpxHFP3a2in9Ez3DTbVkWGRRRWzd6addS/8ptLE?=
 =?us-ascii?Q?u+YGty4HUfPge+dzXuAs3M6AtBeHnrZTz5F6WhHTCikab/toPJasUdkqIWzJ?=
 =?us-ascii?Q?jh8oIBm2icrI0ClrS2MPbqwewf9EaXQBesqr5/WFUl1IbL2A/fjAXjOx04pk?=
 =?us-ascii?Q?tlCgYv0S/rOkZwwTxzUVVHhMKux66xSpAxViy9+uKFrOfzFSog6ic4M3Z6Xg?=
 =?us-ascii?Q?mmzViaQDAh7ovx+WwIPhN8qu+l26FvjTXDFHiuGZCkTmjOyhXPM6ZADDG3aG?=
 =?us-ascii?Q?afn752qybakFWmQb58Pmy804WFD6Awt3fuTqFUzOlJZhE6hbsqf/Zi1g6MC+?=
 =?us-ascii?Q?YCwQBHypnapkRkusydJ4GBGMNT+nnC5pmI2Zw7MhsCT6gLrd5F4cSm/DJ6wp?=
 =?us-ascii?Q?WQ8K3de+NrJdszwt9X0B+WjPREjMKz6cl5Flkuiglt9Mwkpwbt0k6GG98Kdt?=
 =?us-ascii?Q?tHsTJNChaeY/goDjfqam037ukgp7wtyGH7adMFKoZMP/p/pUgX//5J4r94R0?=
 =?us-ascii?Q?URmyMsVCE93JXyGofpm6JT3YMoPh+zCbm3bwDQTmzYC64/uQFuEuCSzGlv0W?=
 =?us-ascii?Q?JZMurQidBPenoNR5/yCQTWnsHosHW1Zv?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:54:13.5993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f30d74-aefb-4f18-1f9c-08dce1f69fa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

On Thu, Sep 05, 2024 at 10:38:23AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 01:03:53PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> > > Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> > > that should be linked to a physical device id via an idev pointer.
> > 
> > Given some of the other discussions around CC I suspect we should
> > rename these to 'create/destroy virtual device' with an eye that
> > eventually they would be extended like other ops with per-CC platform
> > data.
> > 
> > ie this would be the interface to tell the CC trusted world that a
> > secure device is being added to a VM with some additional flags..
> > 
> > Right now it only conveys the vRID parameter of the virtual device
> > being created.
> >
> > A following question is if these objects should have their own IDs in
> > the iommufd space too, and then unset is not unset but just a normal
> > destroy object. If so then the thing you put in the ids xarray would
> > also just be a normal object struct.

I found that adding it as a new object makes things a lot of easier
since a vdevice can take refcounts of both viommu and idev. So both
destroy() callbacks wouldn't be bothered.

While confirming if I am missing something from the review comments,
I am not quite sure what is "the thing you put in the ids xarray"..
I only added a vRID xarray per viommu, yet that doesn't seem to be
able to merge into the normal object struct. Mind elaborating?

Thanks
Nicolin

> > This is probably worth doing if this is going to grow more CC stuff
> > later.
> 
> Having to admit that I have been struggling to find a better name
> than set_vdev_id, I also thought about something similar to that
> "create/destroy virtual device', yet was not that confident since
> we only have virtual device ID in its data structure. Also, the
> virtual device sounds a bit confusing, given we already have idev.
> 
> That being said, if we have a clear picture that in the long term
> we would extend it to hold more information, I think it could be
> a smart move.
> 
> Perhaps virtual device can have its own "attach" to vIOMMU? Or
> would you still prefer attaching via proxy hwpt_nested?
> 
> Thanks
> Nicolin

