Return-Path: <linux-kselftest+bounces-32566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FEAADF1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAFF77A68E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575825EFB5;
	Wed,  7 May 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4/JifEN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04125D536;
	Wed,  7 May 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620893; cv=fail; b=sypiUF9QVkKYhw2XdnfnlXqfGCAqDMB61vo/COXiIvlTTMNCLS8jSnm50inCRPFv7+3g04djoLtlOQ+ABBeRZAwn3/vMBGdoVe4vMUBVxtR+msE9U0pMAmLlWTdm0z7By7HuDHwPyYr8I2gkoE5uGh8E1ToBcx5aGFe+Ewo9c+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620893; c=relaxed/simple;
	bh=ZrdUSHuauLWNHE4LW6l5CG7X6cBmg3/L3KfTA9g6xSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pwsh1vP6dZ1iaN3nGD84cYHwXBEBKvY+QKLUEMie/3cMm0cp1wOg2CBCZqOMgecFNmYEB7zFwlO1wn68fWJuv2gWZmJpgDgl2hpb4drtrZDWwoGwU8IrYQUCVw+bzXCLHq/NrUtBEfnOM5qhFeQ+2jBa85IZbPmGj1aFcHEt7o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4/JifEN; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNfgYMfqAp+hlPH918JcSUnSSytDpI/IkCZbEdWYiCbk7yZaQFVPYG9ewLqz5Rs3j1oOT1jnzn5vAoObr+Tv3OFJ201FmtS86dEpMtBL7TmvankwsWzUPI6ofutbpOC+nLFtLXzrKBheOhcBrlLUlvrWguZKSbV63le8aRqKN3gL5RU4GjNonrWJJ+r2vn9n19qYWrUlxb9YUysIAAK/So5lHJBi6xIJzutX9toDvXXK8i2I2UM96O82DqLmjkbh+Outi73ib+lKWt6LNiIjWFg8b82NjiZBkjUv+Ed12XL7xkCeguXSuNhDYGXYEHGxQU7ebkQDRVxwBfXkK8K1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80/h2RP6EngN2e6EQilRLitCpoIFclyqvTaIoPBFJJ8=;
 b=pJ3Ut0ttzd3LMtCx0QAEXL1fhlmUPUN/e6HLr4MU/R/PYlZbuHL/1a2cAcljUjrMbI+lW0r3eG5gznIMVpV77Yl5GT1bLEWJZ4WiJkJngzoFZmwj93IcoKjS9KTdCXx2N1FR7iA4geL+Gpnqa0RoBnJdI44CrTz/f48HAoE/EOtnr1FenRXCBWnwwNqGjlguNekdC0CUq1vWrI0fqKlanP+OUW2Q03h5ttJMeFkTICg9+QFr2E6wzm3Dka7eRvjYBZiMJVRJNyIIObGLDJCpPoTTYMoLbLhZPclVpUcRluQV3Eqf8M31eCwew4u/3KmDqCZ4o+PnfKcHFrvCDlB7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80/h2RP6EngN2e6EQilRLitCpoIFclyqvTaIoPBFJJ8=;
 b=k4/JifENkKbjoh6Tv6SMdh/FjNqYJdAPFUEYUCSW2j+vaqV6BrvmQOAcjrMRe9DHGSAjvsgoq30Q396CE6ZSPWg9G/7ygI6WvmEOcb6hezVCouPacwI9w5BBURPoVtvUlzGHCqoJAin3eq4kGLpReloFmo+fpZq7Yawl59/F7FDKalMu/CEe/5/mEDQeLHLUxWMExvs35kyAvTJc0dPteJMk9D9KRAE4DjZYMs8JisKkCewzQoUB4WP6LqwDbMOGbHZCkPEX8PNrcVwZ2NyhrKQgN3m6/9rgTArIUIOrZ9kb39WLITp0wVtDqIRMbyllt3i3CHnc/YBgSKGWVvWJLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 12:28:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:28:04 +0000
Date: Wed, 7 May 2025 09:28:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20250507122802.GB90261@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
 <20250506125847.GA2260709@nvidia.com>
 <aBppFi7eKngFipps@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBppFi7eKngFipps@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: f3531727-2a16-4c59-5025-08dd8d629d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtxHUTd+TSGBHKsAPqMvVpH4v6Ds2T1dEvhTjWbaBqV4elK4DF8YBIxeqG1r?=
 =?us-ascii?Q?O4YB8QJf3MtpU3UkwLR3MunJ/EceKQs7UPQvc8a2r3fJqx6GkVw5biMY8+3W?=
 =?us-ascii?Q?VFLhjbz21rVu2OwHZE0mimdYdTBaENGAJoAc6NN4W6hGNg/eLkPd2Bez5BGF?=
 =?us-ascii?Q?uj+kQSJ5GCHrWk9RgfEdenW5O4pgwbB7Nm1kx0N53g1TsGOBsYkqvHF3JahH?=
 =?us-ascii?Q?bAKyDxES8kN5xUl+i5eiT2KpdsJun/VJ0SjOEVqUs+VHY6t6UiBwBOwZff6c?=
 =?us-ascii?Q?wH8/2hXknWNvAd7nUfKOjabHct+jUo/uSl3yav1Wn8amx2vjFzWnsHDSNlpj?=
 =?us-ascii?Q?IXwTVVPLstHcxnLIaTZc5akyb2edkq7jJIfLu0PJL22R6pn/13w9mrIREQH7?=
 =?us-ascii?Q?NOnKYb8a1bmgK/y0mRu0gUak8EQOgIYzTLtGBTbbtIDtJUJXyBJD0fCy4+e6?=
 =?us-ascii?Q?i2NdptL11laNadgLs45r9MPujqdWRsSU3DKooGusLz+qzPWyh63Izw2eo8iY?=
 =?us-ascii?Q?3NR70w2oAr5eHnQkGwsRV8DDvcnlpmA5iS48nl4xM1JJlJLXRiggs7o/GvmP?=
 =?us-ascii?Q?EbUZ/vyQueYbj0RO/qSMRZmJlInOIBAOBrDSxscnixCrsj/KQCBJP4BISIPW?=
 =?us-ascii?Q?Sd0uvoZlRvhqxkJsnKIBnGBE9yTk7Ds2pmJ9Jy6HWDx3c2kECDISuUpv61vN?=
 =?us-ascii?Q?E1XNSSYsbas7DCHzlGOrSUvdhZTCzmkUQA8tL2t8x6OkFBfce33BsrumCChx?=
 =?us-ascii?Q?tLsYACQ8ORHvBWj+Tkh++SuMf0ngDJgEIgv2FPXkntnNg/+UZH2Jl8VGAE9h?=
 =?us-ascii?Q?+CNCThMv1H3ysD/zq55MUxohXBXsCX1Yc1m8RRHLcnFEVx2BQHtDRgmySXcW?=
 =?us-ascii?Q?8wAmP8ItDbKA9OYgVaCC9fIQbo15UXEQHiMQTRN9fkueRtYEvH7GLryaFiNo?=
 =?us-ascii?Q?KAjo08GRh4uAz2G6sWmCdtewgEHgq5UCH8yTo1XEThRiQAWAookn3XjTKQXO?=
 =?us-ascii?Q?wIAXwrPzRotHsAfS98KFZ6at/x4yWpMJkIsHS2eKplQ5VBjdTbXG7eTQIb5M?=
 =?us-ascii?Q?Y9pC1e10+n1x6fqS/0pYarWALPpzbiOWrMVLfchTvMeIk2KtWeK90YQaOPG5?=
 =?us-ascii?Q?//Hw664qA4kKGxe+HGxZjtDH01cDBlc1kpQk2xBtYt+qYUpJU/o6Q/v32w7W?=
 =?us-ascii?Q?I2hYldKGhvNyPJ6kg7Y1jbJJpqxhNatjRXkpyj45TnVmfYVtzx+MQJ2n1ffe?=
 =?us-ascii?Q?559Gng50Tndta9prwmN2x2KD52Ve5mPbrfpf6+8D+Furv4UF0W3uch8ifqwn?=
 =?us-ascii?Q?hqV56jI+bQojPFyzorA2IpX6PJJ1x8KHL8WTn9QMPg9/h3vneBmFg5lqbUwq?=
 =?us-ascii?Q?VLMVA76+rHDcoZi7zAO1H/oQHoAekcK6382iHEKF186Y1vHxWuzKr0BRTwUA?=
 =?us-ascii?Q?zuLEdjuilVU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZnHPRy6LpOpi4B2dkXeCkENv17FewPej/5qzHANFkm5Q9P6StM8Bl4y2NPh?=
 =?us-ascii?Q?xxuhgPm0NLmRsgGo6QN5sHtdC9+YNzkDIUBFil9LMjAdfUptFeJyhekhnNmG?=
 =?us-ascii?Q?242N4kEaf87HoAZcFRNd+5ja0J1EndYgO7nyWyPaM+C5+eymXexOEVAXxj07?=
 =?us-ascii?Q?DvO9mRfSEJMbb8nAJP4JlSlfVG5wNpy1A3HG6+HsXoF0qksABJib9vVaBANb?=
 =?us-ascii?Q?82bE4DiysaffoZFs8EWMiWDlKBtz0W7fEhUMSWNMjr7MiOq9+KTIPZkTbaR1?=
 =?us-ascii?Q?9UfrCP8BiCu5onkGZ+heJD1DPQusI0LR9n5HU3ZMT2782Jl7OuOFlgt5bgkr?=
 =?us-ascii?Q?rgtQyXdDimZVWU6X/7prRM9TNDDVEhyx3+bhjl0C0u8/gQg9nEfndzyqTi1r?=
 =?us-ascii?Q?hXMrpUhKaBkrctYvbMMuv2P5zjj5Q5BtMEzx978KsP2VAcZ+C6LGcbAAFad+?=
 =?us-ascii?Q?qCvqscBeRIH9mCTbSaCHAhoI2RY7ntvrBWrLpPbSd2VO8zMj+ChLU3gQbWwd?=
 =?us-ascii?Q?wAroqGv6gV5ubQtlNG/YXbi4Yhq+6n+Z6mymbtHWJGKNH6bxwHRC9w2ulHzB?=
 =?us-ascii?Q?AyP5rFXocm7eQyAgz3GBh7kc/WfJG/ucx9RPRx+ewMBKn22es+BthSy/eKvW?=
 =?us-ascii?Q?E7BPHhXo3PYxpkWr34ObTut8OqcLdPTWvZDpE8h9xitGJe8P8Av4Bj2Ny5ur?=
 =?us-ascii?Q?JsN0GIrG9T2eDAVXFHoo59NRRSeDJTzntJekHnS7UOB1DanP6VcSyCW19En4?=
 =?us-ascii?Q?qGVx20owy3tuQKsYDbawG4+JyVA84/LmIaddPB7SATH1nX0YcQCVPh65PY7x?=
 =?us-ascii?Q?eweqdQ+BOEJXd8T9mYgrBtsJu6if8X4JmMCYNhjREBQFbRqz5JMrL0MF69NA?=
 =?us-ascii?Q?UYkLyRDRMEPRfCvxGoUfLqEXgzZf/gRTVMOvOFpSPWGpTh0r2oxTIbHfoWbe?=
 =?us-ascii?Q?pHen8fIVSV21tb7xOe+0zWfyrYBWnsD0C/GJOHF8lctw9vXF1Np0+LPBJARm?=
 =?us-ascii?Q?JT2P0/uYCHADW3SDfriFwITovR/SF40VLzf4F2kBQzhV+iPrzVgkgT25hQJ4?=
 =?us-ascii?Q?FfD0PZC4Hn031UVjfmNQDqzghMSXi9V9DIKhGleAVM4cwBxw0oDX+5DJCjWX?=
 =?us-ascii?Q?5yEfdtOdsH3UgJNmyM4mG/ZcvhsfqxgXLyteSUcoEor/90IzMyQ7cNjHYwbT?=
 =?us-ascii?Q?cj93HzcYtG78NJSaT91P/oxrNfRqrZ4V/Dck+OAFmNwVyyKdt1na2vXf6tq9?=
 =?us-ascii?Q?A2e9yo6VVnFErXAFGFmbbZsHix93BGzB39CMIdJMhlA0uCZSOlHII+x9C6sB?=
 =?us-ascii?Q?FA/BTv11ocdsKOdywCeGMDaEmu3Xw3CupRWzyHvDsPh1YKwIZTrN9VtFj9hA?=
 =?us-ascii?Q?gIBteSFiBwoDElXXbq3qK4EI0EVAFeKE/D4zhiBzLXNZPxoHjutmxKd419nI?=
 =?us-ascii?Q?ZWQPmEROSVDGZLXVKb+UEn3fYDG+CZqahrh6sQgR+KI9jF42p8pJ7ig8Qh5R?=
 =?us-ascii?Q?JkcSuQbN2uqCvUjxJN9Tq7enQMab4kMU7XW5Hjl71+Lak6U+Wpf8l2l6H3XA?=
 =?us-ascii?Q?qHSzCQWOU9cxQuzACfxLtF2Qfs5F4sbkV04g9SEx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3531727-2a16-4c59-5025-08dd8d629d0a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:28:03.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhkn/N/S2roNwvA1+CyDok3wMRzMr2ACd/YTeJYNothwOn6b2HQLsvHwmL0XYkl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

On Tue, May 06, 2025 at 12:55:02PM -0700, Nicolin Chen wrote:
> On Tue, May 06, 2025 at 09:58:47AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 05, 2025 at 07:53:44PM -0700, Nicolin Chen wrote:
> > > On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
> > > > The bus numbers can be reassigned at any time on the fly by the guest
> > > > by reprogramming the PCI hierarchy.
> > > 
> > > Yes. If we take some aggressive use case into account, where its
> > > BDF number could change multiple times, I think it's natural for
> > > VMM to simply destroy the previous vDEVICE and allocate a new one
> > > with a new BDF number, right?
> > 
> > We should not destroy the vdevice for something like that. In a CC
> > case that would unplug it from the VM which is not right.
> 
> CC needs BDF to allocate a VDEV in the CC world. So, it cannot
> allocate a VDEV with BDF=0 firstly, which is what Alex reported.

I don't know that should be true. Since the BDF is under guest
control it can change at run time, is CC intending to somehow disable
that? If not then the BDF is dynamic. You could start with a non-zero
bus numebr by default but it isn't fixed.

> And even for a normal case that the device is migrating between
> PCI buses, CC might not be able to update the BDF (which can be
> a part of CC_VDEV_ALLOC instruction), even if iommufd supports
> an update ioctl. So, the underlying handler for an update ioctl
> is still to first destroy the VDEV and re-allocate a new one?

I think CC has to or it somehow has to disable bus number changing in
the VM as unsupported.

But I would not do destroy/reallocate of the vPCI device in a CC
world, that is completely wrong response for the VM changing a bus
number. Either the bus number does not change somehow or there is a
modify operation.

Jason

