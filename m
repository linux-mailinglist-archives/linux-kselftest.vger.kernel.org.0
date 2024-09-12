Return-Path: <linux-kselftest+bounces-17777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C8975F96
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 05:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE86C286A57
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 03:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE378B4E;
	Thu, 12 Sep 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mS38T+Ss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0CA22301;
	Thu, 12 Sep 2024 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111049; cv=fail; b=G872d+XhG3ZwQMQe0vNE+eWzg6vQzh9UavjoYep5cgxCFg2YhxPGykmJXpQwHwHTd0WxKac2BPkte8YxNU/NTcnKQ8CMTxUdU/z06gg/xDp7qI0rMRp7GO0UM2mK+PWmPWzYru3y0cD07s7cY3q8vU+JIuyEk5zheHpasEOwkc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111049; c=relaxed/simple;
	bh=WSiUxnPR4Y4uxJEHTWkOXyeztGDanW6zyameJB3dCgw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYdjZiwYHz/BEbaYfi9ApkHpNAuVzZ/ZhY8Aoi99rZnUwYPDTFvnXO16Zgv4T0JiZBKXL7eo4gx2C643aYxV7i3hXiCV57+cns03R7w22OGqdC4GSdqIAw+LAmP6usW9GldygIGupFzObLfGo3HW9BEfgxczZ3CTVFHmKKZXuKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mS38T+Ss; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuYQMWo4a5iDiofYr3Ia0vczzapjkLk9Par1KQB8Eov9VJAaFEXUJ9wHMydqibprn5U4lzDcfOVHSx9jXos9/vOg9BR9FlxEeSMH3z+7cnqDLH/am1LHCfz59H73NoYS5pIYeuPhqfnj5BS1Pl63kwP4dCpOXTH9Vaa0ohO1jSPsKMiSNW5tW65ozy+RdNVOhUNgcYegfgQWHwvCsj45NVzFlGqKqm3IEJejM3LLE44r0FXHukGEJ240qtsVxDdwTYQLSDWenJ0BxuhnC9yo3IEnNA+zWsCK9FKFg3Jv/zPe+bOJw5NWGL8OZjIQSgwHdyZGJ++1pz8I0q8/DuM5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsPK6c1cScuODmkwIY/Zynm411B3bgdzpkeku6Smyxc=;
 b=jnFQlhrHbHTlS3LliBuP+yb3/Jgr19y/eD4dZ5QwrMUTeEABO/GgdCp8SaosEO/XmD5vnm/9mH+C73iGveUf6sv872MrsJ5jwI14Z4aD7tpGvHyyD/fMnVS6BPs5yGuidCMQgOLmLcEJ4HHckFkDSoBhgzAMMk0tQjgTZVdm7+LTH9KfvkUaaqtLHkP7JKPcI8rFaKz4WUCXgjPySTt5lhe+XFOueGgm0WTFSRtDO39TCCy0+Qygw+dYyvhGLd+qXTl5MrIYicDPe96BayCn62m4Lnx3Gb78/eQSr9RO0T/YiDHCUrz5ozI+9MZ1dZ0fqG83Io79EZuPXnuXb93CWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsPK6c1cScuODmkwIY/Zynm411B3bgdzpkeku6Smyxc=;
 b=mS38T+SsvEg1RkbYredIAt4aU1YfB1Dhojyq4qLGNcTbjy4k2H4KB5VT9LEJ1owYOteqNdg6euNZrA9W89ZmIi8331YWMgyovLHHKGfQQBRfjrOTOQAov6rKDyayp5S9Xhx60V2XVe0hdUPtrBAo05DkPAjFJksRoCOBO0iWmLmRg6PBmWTXK9H7ZaiFAUQgjW0b8X/m7r91nLn0xjVviU3rEtrtyaXHCdh6th2Af46M1TwXmAMSwqez/R/WMH0h/0dmRlhEIfMJedrw+lRYznZf00s6Ok2DrU/EJpBvMdPYofQeXwnahL3GMAtnEFd5ugQGUfgS4Rx2xxBlyOgVRA==
Received: from DS7PR03CA0112.namprd03.prod.outlook.com (2603:10b6:5:3b7::27)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Thu, 12 Sep
 2024 03:17:23 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::82) by DS7PR03CA0112.outlook.office365.com
 (2603:10b6:5:3b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 03:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 03:17:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 20:17:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 20:17:22 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 20:17:18 -0700
Date: Wed, 11 Sep 2024 20:17:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <ZuJdPHRbMeYFATT7@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240911231103.GR58321@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dea2eb-bef7-4308-2738-08dcd2d96b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?igB32czTBOX4U+g7HxBlzUj053VHSjbOQcyG2cVeNiseH0W3/pSmS3rsZgxN?=
 =?us-ascii?Q?WFwVS+LJUuIOXVQoZrFf4sDLZeGPdPzPCEFBwtkENciAJL+YqoZINVRe0EiP?=
 =?us-ascii?Q?BIu7MDn27sjJ5G7Lr5+ZGxtyWJOdvZmU/PnvRZ13HNcKVYuzphWEWCl5PFHz?=
 =?us-ascii?Q?opnIytWtTVJA08+OWdu2dZAku7JTnha7LcOpJ1Au7ukW13dbkqmZ4EUAmZ1D?=
 =?us-ascii?Q?znLWLPCwt71c/ZAYFIPKuExXJGnkk993IfraRErxbwJJ4SFD+s8bI8h/lS+o?=
 =?us-ascii?Q?oHI8LHO87T/etfRM3sDOhi1p3d/trABYr5esTQ+yfmQ6I39Su9OIUp3Yv0Pt?=
 =?us-ascii?Q?AZxO6yEol9A69pTKkMjHhSV06PVavy2sAn5kxsVmTVtyForDYzX3sjKLoce+?=
 =?us-ascii?Q?iY5uaz8ZLH42E4PyhuyuustyDQ18Pf8btpq7I0E/qQuY1IhowY2sOMp32m3a?=
 =?us-ascii?Q?6o/LSd6lTCX94bLfUEX4iA2vqtksIZQRNrvyyWgcOPdpV/wagQ/yFersBXef?=
 =?us-ascii?Q?sYPJh6Aq+TM4Jlq1gqhkLMbyjMiJLKhOlEfWsTpUcjAWdDKS1OnJNwawBx74?=
 =?us-ascii?Q?IobwTgevaTAwIJ1Mb+5gVyKBQ5wNA46FXR7xGJLBFRekqNlmVE++pc7bHdqb?=
 =?us-ascii?Q?YMBEpimrR15bde+YK5EY4ogyjwQWWrfGUf66WSHS6bbLTmiSjMafaUpkqkfK?=
 =?us-ascii?Q?PxA5AVMLx2nb/3swm0rQBOos9Nvetm2YpdTcQ7nsIm6SzzeDLPp7m44XY0Wd?=
 =?us-ascii?Q?U71iqBOOlgiON/oIk+sTybQJl3D+WK9r3kPYrny/MpuCOwa5nAtFoThKs6kk?=
 =?us-ascii?Q?IIhFz59KueUmjHwjezz0ZJGIHJYR7PkPauqIAQ7WWKEQrmr0pWak5TKtmRIa?=
 =?us-ascii?Q?OFERfyDPEArIUvZHB0GJkchGSKYSGPVZibcd20RvynjxLUKWnN/LPVpGhn2T?=
 =?us-ascii?Q?B+3Nn0ggHeIQjUEiSnROC1dLMFkp8F5PAvShYXmlzfobLrojB/fq7ko69+5+?=
 =?us-ascii?Q?CB2NBd4oHeq5L0te1LA+YdHsVyBaHFgi/h3JqtGKHkje0nDuQg/Dpan0izjl?=
 =?us-ascii?Q?dwTgykIbEOkVaD52GdJSnCL9TqLKSZqijgaJ7zj3nud1ClmDWftHHi77fzOW?=
 =?us-ascii?Q?GzamAC/wLRxmwe/KsimHHHUO/ADkg4WM5bltgq9CqpAfqhMRW/RZ5ySRDs2L?=
 =?us-ascii?Q?K+I5lKoz31lGNpgme/WrW3BaEg4R3ApExDEq3YfaRDfNGEPKsOUC3g1QCn1P?=
 =?us-ascii?Q?Pcyo9D/H7rqzt/s7MvpwcepVZxkztag0Kmr4AGnUiAmYzEx2QrCweva98x27?=
 =?us-ascii?Q?ENF6NYx8PgEcF5MXKWfMTZyIxDHVXggjtiIOfOXJzVTiZ2chKjauSJuczMBT?=
 =?us-ascii?Q?b2dbemLtUXBwuE9SzaeEmLVSyOMihIBwAoJVYfvtuYsznfIOooFFqdcrp5Ad?=
 =?us-ascii?Q?FRNbw1pido0Six9AkzShld2wTxmhcPsi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:17:22.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dea2eb-bef7-4308-2738-08dcd2d96b40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

On Wed, Sep 11, 2024 at 08:11:03PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2024 at 10:53:31AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 05, 2024 at 01:14:15PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 27, 2024 at 09:59:47AM -0700, Nicolin Chen wrote:
> > > > Driver can call the iommufd_viommu_find_device() to find a device pointer
> > > > using its per-viommu virtual ID. The returned device must be protected by
> > > > the pair of iommufd_viommu_lock/unlock_vdev_id() function.
> > > > 
> > > > Put these three functions into a new viommu_api file, to build it with the
> > > > IOMMUFD_DRIVER config.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > ---
> > > >  drivers/iommu/iommufd/Makefile     |  2 +-
> > > >  drivers/iommu/iommufd/viommu_api.c | 39 ++++++++++++++++++++++++++++++
> > > >  include/linux/iommufd.h            | 16 ++++++++++++
> > > >  3 files changed, 56 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/iommu/iommufd/viommu_api.c
> > > 
> > > I still think this is better to just share the struct content with the
> > > driver, eventually we want to do this anyhow as the driver will
> > > want to use container_of() techniques to reach its private data.
> > 
> > In my mind, exposing everything to the driver is something that
> > we have to (for driver-managed structures) v.s. we want to...
> > Even in that case, a driver actually only need to know the size
> > of the core structure, without touching what's inside(?).
> > 
> > I am a bit worried that drivers would abuse the content in the
> > core-level structure.. Providing a set of API would encourage
> > them to keep the core structure intact, hopefully..
> 
> This is always a tension in the kernel. If the core apis can be nice
> and tidy then it is a reasonable direction
> 
> But here I think we've cross some threshold where the APIs are
> complex, want to be inlined and really we just want to expose data not
> APIs to drivers.

OK. I'll think of a rework. And might need another justification
for a DEFAULT type of vIOMMU object to fit in.

> > > No need for this lock, xa_load is rcu safe against concurrent writer
> > 
> > I see iommufd's device.c and main.c grab xa_lock before xa_load?
> 
> That is not to protect the xa_load, it is to protect the lifetime of
> pointer it returns

I see. I'd drop it.

Thanks
Nicolin

