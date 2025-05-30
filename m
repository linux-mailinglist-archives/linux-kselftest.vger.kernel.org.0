Return-Path: <linux-kselftest+bounces-34088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1DBAC9592
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0A4E1320
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5B23C4E5;
	Fri, 30 May 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suHVa/bE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01D230D1E;
	Fri, 30 May 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629408; cv=fail; b=rvHMx065qnVvRsQ/IhrWlf4XgMo5sflVFzDmb1RkdyftTkrLqI/n9xnPmk4I/w10ZOiBiP/koBxUlArDXVdUdCC9yfvmrkh2i8PNXyn2t9Ft4qimvTZ7HFzVFjNfaG/CQ960GyadyjeQre1zLnMGajiQOV9vOYK1XZjOiU+yrdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629408; c=relaxed/simple;
	bh=vwBbA0Bjm8YvDpJ+k69S2SXF05vNu0Qp8jAw+tPubAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7n6nByTaOT2t5tfOs+pMkVj419N3x4EzFTDKhb6NKL0ltO/mkV/ceicx4jts3Lq9gNUbfH7N/kzxB1ith3MPb2O1zmN9pcryQ2USQ1yrpeXyAJcdd0cN/CR6+WhXZkTAwXGr0Ee7jacAgJSqFe6BCFQsJnTx8/0lIbMGlKAo/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suHVa/bE; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upxbtksbj9HXFMBt1fHPFJebWgsmgw1wtfWPyjR3bIhTUxk9bqJfHJiIOpA8kWDQ/dtO8d2cttweVjPTWXgNgEK7jnGMI3HSCcfJqi4Lrx+L3YHXgALbJOWL3OJBzejsYygsj8hjwk9N0bmjGA7yPePoGYAmrv/3ZoJGfS4AUdONeCHLCW42ZPb3Y4bE4G4ypzjotJpKHXmQrkindA9L52C/4iLIOwP9Jq47CIJzjaiCie3vCthMk33MuTtb4BG/wWnk/QIRdCg4516tAl6LgxKkmvqTHjl3IFEdNz539wLuulfEqbIwYIf6U8JcNTcMqgETyAEvnE+k7geNgsFHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrkGAJrJGowkSZTolUFD0MqlSvIzR7OLE7ijdjf++rU=;
 b=I10avmWtXxfwzd3/AT+RA6RXP5K1+wtXpOhTJbS40PWPMNYBvGaUA1updxHN8dAvRkP9QWdD3ykr9xSBQSEYjKMrn6UQvtz6nbJiGq6CBcdqjOJTA+SZ8x1436Vk0kzN75cYaEYjNib2u4i93rdbW4geY/dh6/wB0bliSRBsNQO9rfBeVNZUJJ/xoc849WO6tBj70Lub3sdWHjkWGipaYjlNr5f6D25oqBX+QkpgAaxKC9Mjem+ek+JTaOSiNuKxTbTCuh+RqOGF6Jpt1/Pt4wWTrtQi6Ll/oWo04T4IwmN9l2GqCiniiWHTtxeoPt6b3RhIfoKUN6soQCkx5e4Z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrkGAJrJGowkSZTolUFD0MqlSvIzR7OLE7ijdjf++rU=;
 b=suHVa/bEvjho5dp64WVYzGREdFTG5dCxQDXvShpivRUgtbbtJVQHDz1tY+PbsNkMWR7Kr5CxcmbHNpKY4EXI/88cZJvDKeZ3u3XWwzokP0SPysxt3GCaH96AZ2dUw6IVzGhYpGQ1YFMDKg20+2J5D+GW0pA/JR68CwZVlmhb8rqer0aEIsQuJxml+XpdmArAygZrGmTd907z+6hMNjuf5VG9BopR2n5fmvbUfE1hysN0BBdsyEOypne4VzoxNtzcEbb7wqtr7+am6yN3mLs7whveHvpBM0s/d94MfzJ80t7X2rG0++a6UCO6wUpoQFVDCuJHp3hK8ESsXNlPAVrWRw==
Received: from PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::16)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 18:23:23 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::3e) by PH5P220CA0004.outlook.office365.com
 (2603:10b6:510:34a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 18:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 18:23:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 11:23:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 11:23:05 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 11:23:04 -0700
Date: Fri, 30 May 2025 11:23:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aDn3hueUhGKWFIkn@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
 <20250530161455.GE233377@nvidia.com>
 <aDntEDywhsgMoZwc@Asurada-Nvidia>
 <20250530174037.GR233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530174037.GR233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: b49f7c94-006d-4281-f995-08dd9fa70fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cLv9Dcxa9IO44pTvEE1nefcMIXQAp3FdpWwNaU2ZED/DfipIiTIUlRE9vri?=
 =?us-ascii?Q?P4H31tX1nIHj1EffkEdk32qArmwwuvUPlKICPYmoi3ypGjkrxB/YR3VE6OR9?=
 =?us-ascii?Q?CRbAwu/GyVnBa+iNZwzXgO0RWFEYoeFCR1sMHFN+HzTSY6OmMzU57kLbR2eG?=
 =?us-ascii?Q?PWZVo+0ugZ/sfjVxw5/dwEHizVQnvStlPdQqPGNGs1lGBftS88rCYGQv/6J5?=
 =?us-ascii?Q?5al6uanbpjf1mSb+M39F+lhn0/XJAlwcBOEgPxFTOKLpAUO7PI+a+u4mnSMi?=
 =?us-ascii?Q?5nEs+sfjkv/M0Y8y4qCO4yggWUFaYXwFzPjh3blxAwJV2bAY/4rHqzrGlVtM?=
 =?us-ascii?Q?LlR/Uh8UTxTvprkHBNtktpawVOPPdoDSdKC6z0YZDEPCzDjVYPEROdJDTmrD?=
 =?us-ascii?Q?5X1SLmJF8evUn+bCQxXOU+xF4mzBuwarfhaeE35jaFJSqukDWkYWIs6CLCyN?=
 =?us-ascii?Q?OZgrNNmm1hhc3A3N/VS9y/kTOcyIv/7xR90pg41WMze55cLJCgIiJ97jbaAd?=
 =?us-ascii?Q?mxkpfLifyLxAfU42SnbTwra0ZYx4DO8POlCmvvpIHj3YxROpOhtHkN5RfTN2?=
 =?us-ascii?Q?13fU5+CPdIPAdUw37Nsiqd6kXUixY1qnp6cs6TcsKfWCsJ/xbcV05INOI6Wq?=
 =?us-ascii?Q?3EMVc7y61UpQf1/a0OR4pwwe+lsCWdTFKkCjKeHvPmqIKQwnXET2wrDs8mUb?=
 =?us-ascii?Q?61e435XKv9W8M/BGVRo1hrzN/3kRcYODaqzFHWHJU5MDGUYdMSE335hHntYu?=
 =?us-ascii?Q?k0Q0WWzklY27IzR/2lr5Vy8E8gX7cIWB3VfSLxC6WjySZ6QODZWBs5LOuogN?=
 =?us-ascii?Q?RHJzyTK1grd1iNsGKgQpvaAIISQvX6xw0XzwASaj3ukshLrqGyhEpfFaTJ/G?=
 =?us-ascii?Q?MpwW4NBlnXLXXDLCA3wtDE838r/n9Otf6TBfhz26e6GnMx5NQ+U8bo0kR2hV?=
 =?us-ascii?Q?pCbKh+A0O4R53Zzw7awohH6+utIC9Fw3KUZljKfjJmT6GBETfvSVkT+7fsj+?=
 =?us-ascii?Q?m/+QpuM6Mo9UOsga/oWPWbHQlYCd7atvwa0Oy/ooNBNhkgnbW36VjkcGV/QC?=
 =?us-ascii?Q?yrYUgLnk+2HN/BV0TWS6wURYdla4vLhPEZrEyEm0Wj1Vi/NevsN82xy4Cacx?=
 =?us-ascii?Q?QYYo2zo36eRIZXPRkvnmzsyW/u6oYNAm8yjgPtvn7tLqujiw2yhehxIMizY2?=
 =?us-ascii?Q?q/Tw41EH7YbKOPLgHJCGiczvO419/8UeELQ4mSf3fpJzpP0eDQS281Tg2/VH?=
 =?us-ascii?Q?4oQyuZRN/1ytF+bBZYKlP043gYHP40zQlzbTHAbz1HvJFA3hXujTLyUQUfdN?=
 =?us-ascii?Q?aa0fx/ImYK8wBRClSFyqEqKoJaUKKxs6HuawBlnvMR5Sqj938zDnisqn5hbu?=
 =?us-ascii?Q?PaeKJmL+XTcXalKqx/paGWHHZD4Q6pdXMWwhLqyNV35R1VnQ0gwcguaDth2S?=
 =?us-ascii?Q?bBdCSdKS6bYsacmS3gnu2zdeYuiZ7yPsv3KjWelYIAe/L6gJlv4nKIXNG3l6?=
 =?us-ascii?Q?zgQc/P9rV0yeK8Z8o4S8mwszqQTKQVG9MAso?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:23:23.0305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49f7c94-006d-4281-f995-08dd9fa70fe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

On Fri, May 30, 2025 at 02:40:37PM -0300, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 10:38:24AM -0700, Nicolin Chen wrote:
> > On Fri, May 30, 2025 at 01:14:55PM -0300, Jason Gunthorpe wrote:
> > > On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> > > > +	offset =
> > > > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> > > > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> > > 
> > > This should probably be capped to PAGE_SIZE/sizeof(void *), return
> > > EINVAL if not
> > 
> > Hmm, mind elaborating where this PAGE_SIZE/sizeof comes from?
> 
> We can usually allocate up to a PAGE_SIZE without too much
> trouble. Beyond that it gets more likely to fail.

If PAGE_SIZE=4096, the upper limit for max_npages is 512, i.e. the
max size of a guest queue is 2MB? It seems to be too small, as the
VMM can use a larger huge page size to back the guest queue?

> > > > +	hw_queue->viommu = viommu;
> > > > +	refcount_inc(&viommu->obj.users);
> > > > +	hw_queue->length = cmd->length;
> > > > +	hw_queue->base_addr = cmd->nesting_parent_iova;
> > > 
> > > When the driver is running, which can be a source of bugs.
> > 
> > Hmm, I don't quite follow the "bugs" here. Any example?
> 
> Like if the driver thinks that hw_queue->length should be valid during
> init, it turns out it isn't.

Ah, I see. Yes.

Nicolin

