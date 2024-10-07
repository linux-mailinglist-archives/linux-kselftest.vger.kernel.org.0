Return-Path: <linux-kselftest+bounces-19173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834B9934E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31431F25D50
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DCF1DD535;
	Mon,  7 Oct 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQUL69t7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E31DD536;
	Mon,  7 Oct 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321924; cv=fail; b=II+1/4AekH6RsDcZ9VyCNcN2U6umA99HkUUGKFAkHarV3lVmJrNjBFX2Ja9jfbAatVaaCtppzfqbfIYHazkHtn41q0FBc73GIxiob5xyWiFWXhtKBn/8I2jjznJpAUXsUOJ/MvH1zonL+6SY+RjblreW3y/Tp78+hfzVCZB5T+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321924; c=relaxed/simple;
	bh=/GZOIA50wzF432oKOQRRde0Dh2+XuPbjzLXAh+V3KP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmSJCFr1mAIRcQ4DjQWHTXkL/drq0LZPNYnTuO6rF8Q5jVYlm2/UtajZI+WujoI+6CxdUGKDJcP1SfvJkRsWNxAWsdi1GKU+CMVlyXTGVNLKttnB9blarR0793+Kelr+2kf0v2yfDCJFJsX6pFh4Qf/EHznPEqM4pxtry3mB/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQUL69t7; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfrlhMVqbDJCBK41cFzYnY3SHbpz4S11XuLG59c1EMtSOURJxXEMO8t3iNyQwmvnGtKWpPLQOvaG9qMv+p+DF2dP2pzFM++zlgRYKEm4Yt1MiJkILb6Y48mIV9QrcpY9yRMRFeYXBJj6qG1uYf8IIaPFMhHTNJTRKcFNN3fJ4b1qBaRaptzH0Zfga/Osjj2weUKggA+nZ5IwzdoFbJ5EEmm5PlBgjsspqTOJkJmQToyTJ1rctcV7m8QxTjZZUAIRNQF/Issq9HqhFgZLRes5NB4bIMhB2H7763SeWO1P2zfvnve1HxHohO9dVmWSR8YCC2ESoCaeEfRfzt43xY32jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xefdw51PCqLPoQScKF/Rqp0CISLVKbBtsQGz/Me4Jm8=;
 b=wMPUrO+ljipnuqBFLdXGmBaSeTlzBBqsPTywDXYwm1CRkUoN9U9WnhWMGbtiHYGAVb+tW9u3kcHoW7e08+9LMHvpZKqwH5wucEtKNPW/p3baGmJUAjkerdJzZ0vismKvFs2VCV82SZpPdxS/tjaJ+zenfS44xURFbIhIXppGo5sSENtyvQnfWMwXm8zR/JkUvaBwTxOXWGojkdnIHAgSdRFUGESO+/8LLdNv1Z5ipt6Uy3OoURmRaA8DFTC1zxnan0pdL1vjYFdLIpP+hjCItcqwNSgiREdWBuaCkDCUTTGKBVlIcG/pmI/SxSeYHx1Mnj93/Q3+EMvJt+C/j1ZxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xefdw51PCqLPoQScKF/Rqp0CISLVKbBtsQGz/Me4Jm8=;
 b=FQUL69t7gScoCa5K2MvpC7OE9zaTCC7fInnnkdZeWGmyR5JDNKWbxRSQ2Wx4PASztOKa2+S8ThK4C/wkyvh70KSmtcNVwuKtrQV3WAhl43BDr0Oh6A36zEHPZs3wqkE4Pfnhf9pop1TLMY/KullnA0OsKhoG0jAD6mwihK2FC1SA13PcQZhJhh0ZLKjClklH6tUBqoyhBoYXDhcQDvqPq7ykpy4z/xSdWdAsJKc5chu89E4ZyUerZBrI53nOS7heLW/vm7IiwuoL1jPaE3IEkPRaonqr3UrusN/3u9lbVL2ScSmIOj6S9NuHAy0H5hypVVsfezI0S8+5+PIaf21r/A==
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 17:25:18 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::38) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 17:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 17:25:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 10:25:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 10:25:04 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Oct 2024 10:25:02 -0700
Date: Mon, 7 Oct 2024 10:25:01 -0700
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
Message-ID: <ZwQZbYiCdf6WVGG5@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
 <20241007153837.GT1365916@nvidia.com>
 <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
 <20241007171119.GY1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007171119.GY1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dfe97a-c384-4722-e67f-08dce6f50355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGMPDVlCcbN2zI4ulEtmsIgnnuZhLXt1lu+8qC7tHHR9zsizXOwitB0Cq0ns?=
 =?us-ascii?Q?zKwm435XJQUq/FHRscnLi/gPIhfi/D2KrUfZOyRP0eoE/K/YlNrhPQH+uGC4?=
 =?us-ascii?Q?9nCtnqXhRYOen7evt4Ww4YEhjgyk8yf52wNWoadPrepgMHCu/y+EXttRiPZI?=
 =?us-ascii?Q?l2thV17IHiW1GJBGBA85PhhO0FesMZ+X89pWMzX9KIRnTQOgM1buYfJylo+G?=
 =?us-ascii?Q?9b7rOFLr2qE0RoRzhMNhSqvGh29x+vkok+q0wTau6oWZ/yvT34pbLtbhQhtQ?=
 =?us-ascii?Q?0WHxxy4Ziy12U3V8PmSfpZX1jU7iEh/7dX8foUkGlgKEZqTN5Tm12Z1y+yEL?=
 =?us-ascii?Q?114Yw/jBlYpnKaF9iA7X02RO4JV2mo9vqrj7pWL1pXkigg/0EcFUtSTZEt5+?=
 =?us-ascii?Q?QmFALABuse2jt+6gOu1eCxsF/7aVwi2sUqgyogiFAbCP6N2ylkMwZdTVI3oG?=
 =?us-ascii?Q?Mdvnn9tnHhaiXlWXPfpg4ityAqrIxJA84uyXxnhr1fN761wzPp+zwow2/opp?=
 =?us-ascii?Q?CMzu1fGcTPWSKNmzdKKj5tw0jWC/bGYdlWEOtY+uJ5rHyuy6rUqAjfzU4B5L?=
 =?us-ascii?Q?UEdtRf2iPNwkiGzBBEGxbk8ygP0Hq85CCXH6a1hKrg52AkSvHm2G0FizoBfh?=
 =?us-ascii?Q?MCX8SumQ+qDX4cFnYarM5gV/vX/w/g71FzBXrBO28fZx6a/zo4N1dtVKkHBE?=
 =?us-ascii?Q?Laq+3yLYQXBxFITumV+xGDsSrdNKXNZ/zinLZZL8QmH2dds3nveJpFEbf6O4?=
 =?us-ascii?Q?VvOgheaNqKPRkd6ZAczUglNL3AT2jb3F+fxfvdx7+Fgt8VjbnHTTPQMsHxjx?=
 =?us-ascii?Q?KMMA1NYt8L1NjthEWOZla1XnzYjxOkCIX1cMNuCkmqlYeBXNTDVmHQ027w1A?=
 =?us-ascii?Q?Wlh7Q6q+eJekR5Rjbx1a0vASfYcO+fXIH39ZyEUulqdI49IJwNROAcBMPiJN?=
 =?us-ascii?Q?goWse/mLOk/vNeunaOPrz1yFDTR0e2UYXo3ec6AhTtjf21f5GVQKL/DJthOr?=
 =?us-ascii?Q?8GyGclRI4G1790RsqasDsiTK9WhfcF5d4MIycjyIaJwiRXuD3CdJnWGSBUil?=
 =?us-ascii?Q?27rkLX/q7/8eiK/5a6vSKon1RrT4SapL5IgPQY+Ail4LCDVt3kkGJPEZQw5D?=
 =?us-ascii?Q?wpcDrC8xiEerA03GGBzxNAnNiWBJNLuK0JZj9/egoNkvJwdlsEXrq87yA3BL?=
 =?us-ascii?Q?olQz/y4AEdYsffxNsFlelPeevVkKLGLsMoxdiWTH9HxQfXVWa3Ora7Y+YGIL?=
 =?us-ascii?Q?PxSL85uFesn1VeBd4bR06CWpYet9Py3PZP10jIWz6b8FLuwtxw+iXCBe5MAX?=
 =?us-ascii?Q?p5JqchEoFEs3VqPDyBy6fSI9qlh/he9zFmYmrfM2Y+OrAkj66pSAaSFgtF5W?=
 =?us-ascii?Q?WoVX81fEK9gZaiXijgTWcSGJsu/O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:25:17.5542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dfe97a-c384-4722-e67f-08dce6f50355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044

On Mon, Oct 07, 2024 at 02:11:19PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 09:36:18AM -0700, Nicolin Chen wrote:
> > On Mon, Oct 07, 2024 at 12:38:37PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 04, 2024 at 10:19:43PM -0700, Nicolin Chen wrote:
> > > > I tried exposing the struct iommufd_viommu to drivers, and was
> > > > able to drop a couple of helpers, except these two:
> > > > 
> > > > struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
> > > > {
> > > > 	return vdev ? vdev->idev->dev : NULL;
> > > > } // Without it, we need to expose struct iommufd_device.
> > > > 
> > > > struct iommu_domain *
> > > > iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
> > > > {
> > > > 	if (!viommu || !viommu->hwpt)
> > > > 		return NULL;
> > > > 	return viommu->hwpt->common.domain;
> > > > } // Without it, we need to expose struct iommufd_hwpt_page.
> > > 
> > > It seems OK, there isn't really locking entanglements or performance
> > > path on this stuff?
> > 
> > -----
> > The typical use case of the first one is like:
> > 	dev = vdev_to_dev(xa_load(&viommu->vdevs, (unsigned long)vdev_id));
> > so I am asking for:
> > /* Caller should lock via viommu->vdevs_rwsem with proper permission */
> 
> Why would vdev_to_dev need that locking? The viommu cannot change hwpt
> during its lifecycle?

This is for vdev/dev v.s. hwpt. We need the lock for viommu's
vdev xarray.

Yet, giving a 2nd thought, I feel the lock would be useless if
a driver tries to refer the returned vdev (with this helper)
after the vdev object is destroyed..

We could only note something similar that caller must be aware
of the life cycle of vdev itself..

Nicolin

