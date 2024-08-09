Return-Path: <linux-kselftest+bounces-15102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F494D930
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E32F1C2153C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232C916B3A5;
	Fri,  9 Aug 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cf7yNHSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099315A853;
	Fri,  9 Aug 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246716; cv=fail; b=FrGsM8WL3DjOZ4WvOjyARiaEifgc0uJN+ca4uIgvVsi8BtN2giZh3eHIubdmu8UBWNa/rQxV4oer1TMWIyeMp3Mdr4f/UvcTtvyxRPzyHyomhHKjA/7ZbXeRoExVgreebW5JH1UQntu66E7YomcXrnvQ3v+VcrH5HsT+9wE3uho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246716; c=relaxed/simple;
	bh=YBKMXnXH10t1G5L97jj3eHAfo/oe0u3ruNuRWVf1zcY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7Oo1l4VGaOwJfTaRtNRr/R/Ces/lYZwHngdmr4lY9NiubOPYfY8vpSKdxLPSBjVda/xPS96G2b4VPq3Oayw7TZXhJqGM0T95+tjq1sN4hwFIW04b054FnPidGFBUEts0988FiUCcU5aXOHjMw0+0U9qe6R1LBHIyK0VQlgt31s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cf7yNHSJ; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulIQZMr3L+NBhc53NeH1lpjIfJRBDfLGneTGfpTlbqlmnyiGFnZPI6pa4sDHznvCn9+5T/cJWabAv7uuVEp69ONYduG/yKkizPpc+fbxCQkbi379v1LYyDX2slKQd4tfM02OnfQa5iiGc/3wz7UGDRcIWpEiReJI5jpHuDLCbrMNJbmr8sbR8dJSsyGiZb0px/cW4gdxeDcK8wz0VYOlReiHTmLyw7kNi18Q631E+2sl80zunOVCJT7Y2Iq8C5ZpRhSNrWsZq1lqVc6CBVn7fnEarAKFZIEmCMxbfMH4DLpVAskVWkMT/fhpmI2WReFYhIu+1FgRKHnjkd1oSqj/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyAb9328tTtUZ0Y4f4GRkkKajImTBuiOXFiTunfRZ/U=;
 b=Az61CBd6RnKCb0cwU8AZUX9K+ftiHsJGhKbs+eOX8HE1XBOqJDB5yVWTj0CraYTKvYsxklB8BEHriNBNULgagw3bus9zphGe3tBRVHZwYm8qTj0bzTZMf72qNgwvMXM7s3HZeZ7lkBsnoTXgQ2nha0vkj+TvYXn3ThMT7ZtNMSuVOgxnqN/bI9H2lzCjJnlUUsxkQmg+60eXNvdgsCIqyb9Ye3H2qK6bbbuxvjW9FMpzFwizIWUMQqmnoxrJ5eyrmjIdLcMflPle3hAQdjsSsQ217KuLH8cYrdPwuBEAx1o3n6iZdSHZQglk+uqRtun/owJL1azNxkHg1byTG/Vd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyAb9328tTtUZ0Y4f4GRkkKajImTBuiOXFiTunfRZ/U=;
 b=Cf7yNHSJUbqfk+ANprWeqls+mKE/4/T0nMpQnhzR11N3EJLl6lLOYeL06gBUFFDXQRW/vTPOBsLIsqh7mwItESrbs9i1mYqdhFQyL1WpmgkCLvCPJBilukUOyCYw803KchQKKP8Jhy7ULo4SxiapU9F2jv6OYwy9uMEVZaTH12vUdB61rIJDAWkqm0xd9C3NkR5TWGZemDWdbVbpEpGhaVYbwklSWFf9ZhXIHhUWrCDss+JjOI0jfQNseKstxcWJGDdDR2FcZy3HfuVBqHqcPVQknav2e+W7Vin1tVuOx72V/7Pd7aukFsg9Wa/5nOQv84Ls/fpS2wP22hfOcqCt8A==
Received: from CH2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:59::30)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 23:38:28 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::e1) by CH2PR03CA0020.outlook.office365.com
 (2603:10b6:610:59::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32 via Frontend
 Transport; Fri, 9 Aug 2024 23:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 23:38:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 16:38:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 9 Aug 2024 16:38:23 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 9 Aug 2024 16:38:22 -0700
Date: Fri, 9 Aug 2024 16:38:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <Zraobe/Q9v3nsnmS@Asurada-Nvidia>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <20240809184136.GL8378@nvidia.com>
 <ZrZrku/Av/y7ID0w@Asurada-Nvidia>
 <20240809224910.GM8378@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809224910.GM8378@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bb47e5-7cbb-42b6-8617-08dcb8cc5ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8Fhth6LD0gxzm+DKBcnDdsFBh87OucupYgYgIl6JVIopl2v5k34uYuMtvvd?=
 =?us-ascii?Q?Kfpe0W8TTFoPQp1Awntrm5Zki6/tTtZPm84HFPbF5LW9u90+NodcHxtOwxT/?=
 =?us-ascii?Q?57S4EBDGYcKCDjyFj8lVurbLWbiIL3zLvaFvp9fnQuYvS3JXpvqUECqCRQlD?=
 =?us-ascii?Q?JK0VovMwUvS+pVLUUNMFFcp7dyctFsH22S1F4WL+LFerNFtRxdmv/cox2vAE?=
 =?us-ascii?Q?UbdcwKhqS0KBT91pbGauMTkpDZzYU5uGe3ukKAoi/lc3/w64c0kK0vgce6IZ?=
 =?us-ascii?Q?icmBTLMUCo7vAEr7yDrJ9pedXxOZwMIk0i3FZNkViLxhUUQQt84SaYCNTSea?=
 =?us-ascii?Q?nE2WKo7yxwkswXZQpq+Eiy9/IfO2uWdQssIlY8lMqiNA/ak2BYJlZlmGSLJ9?=
 =?us-ascii?Q?NIjF1uTIYK3RR+SM/QRVpYE/MBuevvUv2/7LDLaizDALd5lrQMEp+kg0RUHd?=
 =?us-ascii?Q?zT6SWW6IC8iW9u06KSYws8vwVe9xXNhtI1Ud4DBY1eTY1UDcfOP9yS8gZtqj?=
 =?us-ascii?Q?sHoqmYtL0w7wUUDg6a9Dtk+h5yUvHS08SGWnYgfyvnzVTVFD35XEwoDRffOK?=
 =?us-ascii?Q?K+Jx1SHnWpz9DhrFBDv4KS68uyDaQgCfZsqEJctrFdluVjyHGkhtNuk4MFVf?=
 =?us-ascii?Q?SDAZF//Vn0wA35HB0AJD0s+pOhr5PbtGMzdPXDXIp5D1s4fXwrKbtn9obktg?=
 =?us-ascii?Q?0MOEiP1szjY5/MNo2nLgerL5eq9cdiryZpRh08VM93NN0TRoPqbSZ8cNKjuV?=
 =?us-ascii?Q?BK4aluvJ0fkHGzjjAI5arwyPTmKBwu/MGH5yn2vLERIarmG+VgNAzewhtcU1?=
 =?us-ascii?Q?mNhclZz4ZsE7tiVG1kSj634kYRo6z05JrtVcx42tr/k1o7JuNLxeHzV7lEJu?=
 =?us-ascii?Q?rPjJfNcqxiddBJCAD9dYmriWID5U07cVSlAyF9kY5k34wvy1K8ZW2GNV5nZ+?=
 =?us-ascii?Q?p0nxQJS3rNRW4aQbhByikHz3BFeOJc1E5x6ybbn1Sv2G566pi/afIyUA1E+l?=
 =?us-ascii?Q?Sx6yMK90zkKC19E4MVCLB8VyRV0pK8wPNqgnsuR5Ovvd1G2ONcVVkHmO5lBI?=
 =?us-ascii?Q?zQSSXKbArrIJODI4sFV8D0i5CHKVBcgDxNdywLaoPwyfc8AkS80yEemPNXSU?=
 =?us-ascii?Q?oPwio7rlYwEAiNftqTB1/jUyxbm2PEOV2MX2MBqXXwiYhrCiABi3ZRIpP8yR?=
 =?us-ascii?Q?N+aT0h6uEeCsc/8ise9nDBLbA/4WnowpeR9M8g/NGPq69jUtiX2uAoyd5nkZ?=
 =?us-ascii?Q?JVMyHVSjmisNVR8qgwgpsf2Sm717vCLgHrO7R/2vPTfBuEdu0xFXsMzryGe8?=
 =?us-ascii?Q?mXGHb7cWnErC3x0p7cwIYQ9MlFfozNmLBfn95zyoVBwaGg1WDEuiD8mGhoV4?=
 =?us-ascii?Q?ByLJYfzn/xN3+yDHtrkNjOJnewboGoxxPTIc2mQ3e+2rGnYujA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 23:38:28.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bb47e5-7cbb-42b6-8617-08dcb8cc5ef8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

On Fri, Aug 09, 2024 at 07:49:10PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 09, 2024 at 12:18:42PM -0700, Nicolin Chen wrote:
> 
> > > The bigger issue is that we still have the hypervisor GIC driver
> > > controlling things and it will need to know to use the guest provided
> > > MSI address captured during the MSI trap, not its own address. I don't
> > > have an idea how to connect those two parts yet.
> > 
> > You mean the gPA of the vITS v.s. PA of the ITS, right? I think
> > that's because only VMM knows the virtual IRQ number to insert?
> > We don't seem to have a choice for that unless we want to poke
> > a hole to the vGIC design..
> 
> I mean what you explained in your other email:
> 
> > - MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
> >   hypercall) should set gIOVA instead of fetching from msi_cookie.
> >   That hypercall doesn't forward an address currently, since host
> >   kernel pre-sets the msi_cookie. So, we need a way to forward the
> >   gIOVA to kernel and pack it into the msi_msg structure. I haven't
> >   read the VFIO PCI code thoroughly, yet wonder if we could just
> >   let the guest program the gIOVA to the PCI register and fall it
> >   through to the hardware, so host kernel handling that hypercall
> >   can just read it back from the register?
> 
> We still need to convay the MSI-X address from the register trap into
> the kernel and use the VM supplied address instead of calling
> iommu_dma_compose_msi_msg().

Yes.

> When you did your test you may have lucked out that the guest was
> putting the ITS at the same place the host kernel expected because
> they are both running the same software and making the same 
> decision :)

Oh, the devil's in the details: I hard-coded every address in the
vITS's 2-stage mapping lol

> Maybe take a look at what pushing the address down through the
> VFIO_IRQ_SET_ACTION_TRIGGER would look like?

Yea, there's a data field and we can add a new flag to define the
format/type. Will take a closer look.

Thanks
Nicolin

