Return-Path: <linux-kselftest+bounces-45869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311AC6A365
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E455C4F84D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443EA363C50;
	Tue, 18 Nov 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9ZNRNQt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0735A953;
	Tue, 18 Nov 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477990; cv=fail; b=N0WmJysd2kSGMDCuK9kqeugZDmMGIKyyO0dd0tYJNCY/4FVbFd1075LmfxUXl9pGnubqkUKO6xoFJ6upZHRYfo3NMI9CUTWypLk35nU9XQTP/RzZfkUx982msifISFT8tbUyAcMZtXipl4OMnPmu2mIEwjVKVk7vPmxRo3xB4Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477990; c=relaxed/simple;
	bh=nd8L7ikJFnYZvUzIbVySp31pn4RrBdkVjFB25Nv+68M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jg341qEX6l7v/pbz7lwIgMS0BuktjyfTE2IOQl3kxOlsMFJSVbNvMkw9AIDoE09sYKfUgXqE4Ddetj4AE5vh2Zq9WYsGqsGNgPo2b5gEPJSpeu+k+xjmFNwdGFsVfHztDYNHxO+cFNbxV0y2mn3h2hfLw6I/he0e2TeD66fah54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9ZNRNQt; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmNqY/u+nshwOR+47CMMUJonRkwS6mwkAWelpRRYknRbLRSKfX80SYOF/1b6su6aeto9mVvV7jHoeOJbGGeSTVRtmyIjEr498ZzGRqh8zZAipr5v+/9h1Jp4G1CzF53D4o8nTQeQBUK4tITpgbSMYi2Dte8hf5mfk7lLu1onJcE8zDRFI4fQ11vUoarQbW/vepl8pQawRo4EPYgyXWjD3onMWxUh8jPkL8OXAjIVb86/vWXwdAv/Ve7gvIxG2djobTjLkV7BhJgp0m09hrVgVEffO7MNkicv4qRwOnBJPatsqRQd2W7XTzjaZ0D17a5ctD3x4px14pcmGueRcnUXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHD1vo+58VmqVJm9QaUdZRKerPUeq2VfZ8GTp8GOW90=;
 b=WLYTRL+pqB/BssCepnABBhk3KuBFkKy6TXNPLZOsDNJ9y+dLGcW+Z7oi1Yls9ozhEerv0JunP0mhskUHF3hf+8+yGfRahxvnCGKIR4vtZLGBBFinYOsDghlycM0tDlfitIVD7hpwwC5XBPu+NPRtL1uWfRsJXbo006aL8Ul9IAXl861K2yTYGHqx7q/XBK7nQBhumxqqRiot7eRMq4M0mU1oBY/k0lU13yH02+BsqWCDIGgusmIJs9uFrUG9q5d+ilcUr4cCV0r06TZ/Lvmpv3URO9McPZu/aXDVOClqTPk0NHFNo+Ox+hcdXmpaCIPoOoIy2QVkzBi9K/DLWEMY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHD1vo+58VmqVJm9QaUdZRKerPUeq2VfZ8GTp8GOW90=;
 b=V9ZNRNQtmq+EqBWt/GRN6hrlwtUqQ/PAZXVtoXvEhwrOYTNdIaqoEJFRn5Vl1oD/PYIVdWYYF4x8mD8OMXGVrIeY6/8Wsf/B7eTIWzEnesi7OyX2gktnzmX8TyB0ky0I/fIDjMDBJKJjHr+wlhDTQu443TM6vWSdzujylZqCSpWY25K44bSklYl3ITV+YXaLsCYkyTR75ImBz95ktUtsVmDO5jH35gP6RNIr/BXceu2CfZQLRdu+ZMR0wWY42FGwY+FtMd80m61b8iuen3kdOqi9YUi2BjnHpfXROKCJ9mgvprxYbXtdeybTYGC54jQK0P5f8tJvz+bq6ToFDKWpCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 14:59:43 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 14:59:43 +0000
Date: Tue, 18 Nov 2025 10:59:42 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
Message-ID: <20251118145942.GM10864@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <20251113113712.5691cbaf.alex@shazbot.org>
 <20251117155017.GF10864@nvidia.com>
 <IA0PR11MB71850B9B3A4D284BA7967445F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA0PR11MB71850B9B3A4D284BA7967445F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN1PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:408:e1::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af95e13-7066-478c-a7e8-08de26b31b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWEGVMtxETuYnwm2KYgcW7+OwMlNO+lmekHwONH1WBIVjr3/mIPtBgB3T2BW?=
 =?us-ascii?Q?dxC77i9PTc5vzD+cdMOZ+r3EuHEXP6zfSfh7Sat6TjqZtdVOczUSpPEigBYT?=
 =?us-ascii?Q?B/yhWbBsCxulT4kjunnHvkmwV+TwODrbpHDuwoQOT9wsRYFW4E8nTkiTMDaC?=
 =?us-ascii?Q?zHb7z8uQAtawp6uugb/1gHw8LMSxN9EDUItkFlHyLj1Du+VplI0JP1QSVirO?=
 =?us-ascii?Q?hzVgG2KR049F9BKyfhOm+emsSWJobxAam6KxP1g8468LOasiQ7mgMzPaeFUB?=
 =?us-ascii?Q?ebVFRp7pQMnZI2C22AmPf95djXgkGZ9cagMfViUNv8daWTHNoEQ7FYWXtcHp?=
 =?us-ascii?Q?VYuIBSRNh/cdAIU1yiRm45hfLJpp5b1GHJpUr1CkKe4HFF3YOxeNRD2Kq+4w?=
 =?us-ascii?Q?J3sfgoDZtdC43zOoJC4rMURqKzdAlTlYT8bSwG8O9YMUKMeeGcFYRGrk+0gy?=
 =?us-ascii?Q?UedotOnj8bz9jqXC36fHT7Ic54xoo/nXzRIEpxnYyv9EW0M0orXMQhfkv9WH?=
 =?us-ascii?Q?XeSZI2zEPmbXjGSAJCG4Hin3iCRlqoyzA7h08iyOW54tGMXIp6IPbIGTFS0V?=
 =?us-ascii?Q?XJaeulMlDRJjPV4GsPuGKh6D9TLL2T3Hnd3GarW+MksnWuPPDjjfQKZztfyD?=
 =?us-ascii?Q?Fb/UQkylbe0WevnStVKBImjOL+oEitlqVg+3LsqFhsyF11JSIW4LypywfQGU?=
 =?us-ascii?Q?yXoX2sddFce32oDCcpqiXQCbxr0yFe70zjbnHwgcFs8dVQXbX9QLsc2cXNu0?=
 =?us-ascii?Q?rd2nZxMLZQLai+KkZSTXafe9824hXqKYjRS1guDJgGIOjFZUPw+tPP5PLoYk?=
 =?us-ascii?Q?R4lUAgj4guZI+q5KPrgVHQXYR5FW1r/Mwj4hbTaroPu1EKjqoedmc8xAA1RW?=
 =?us-ascii?Q?qWFs9IT8ME3512HlfED6SqINrqShWRYHVZen/GAoAsnjBmfdwSO1okqHeG9L?=
 =?us-ascii?Q?QApChw5FSMt5ZLdYhN+rsWResQA3kj4LI/anlsmblMXcWYxuvLRBFF0uZHPT?=
 =?us-ascii?Q?cXKRU29iVXY5V/3XydhrklrKn6Z8US9N41FNjGOUazyQ0Fg2d1ygsPyB4TjX?=
 =?us-ascii?Q?lX59uhQpSqwIkqfb2zyYw5d6cgd88U+i+TvE+YsJ75hVYo0tfe2cpXpLfbrh?=
 =?us-ascii?Q?T1Blus/Mw9AphWxY/8BgtVeid4Lj4tqJY1WNHq/EBDbQVMJ6RMUC0YsYd6J4?=
 =?us-ascii?Q?0DrZbghJEZClNz5+WAwg3kfNsnQ93R1VLSmsp6GLdzhcAyaL+VBkZOs/Wf1M?=
 =?us-ascii?Q?VG2wQhjeBxZWTnq7xCEsfFsGDLAkOW6BQiphhVoUzHwwzqHuLbGcib60OkU6?=
 =?us-ascii?Q?Zu6lN9BYoVpiE7GSqActie57eKP61oLcK3o4/jeumoTkpbNREuGAuHXwzjrh?=
 =?us-ascii?Q?tUiYDQQ41yOr/D2rdlZHzLekLAT49WzYZxP4mvz0c/v7zhs/l35lVcXJ7Rlt?=
 =?us-ascii?Q?TmmoaROF01TmtYQzkKMZRb3WRcmEotiS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sXkUhBta1Trk874aFW7fmAmKA9HvJtGZA41t0aQQ9Ga4os6klJzm+GcSAWID?=
 =?us-ascii?Q?vzpWvGQ1RXtysJdgv/FpzkMVYlBB5L9mfycnpq4geriwPpNqfItrthM4pfGY?=
 =?us-ascii?Q?NwvUiyYQB352ghs10g/BTDfSNcSxLKNSYQxaA2VDzUZ5EGSwCUAc19qnKhZ3?=
 =?us-ascii?Q?mXqHN6qfb2u8/uOV93s4QBYyRyXpGEoQEnl6tC4+30r0bvGx6L1gy6aXf7VS?=
 =?us-ascii?Q?3yknDCQllmQtTxbGIkmJ5s2yrbVoQtO6ViSJco5XkVAzvJDlwuxPcic2h3Ti?=
 =?us-ascii?Q?/I3ijPMFNULz0d2/Uo1mJTWVqI/2uy+zl/EWdMZtqRxow8jQzbZUVEu9Q+K/?=
 =?us-ascii?Q?UYLdx+FbZKiPmijSeYNe2hw/6KCpQAPO3nBKVC2pGUZ40VONa+r1bNPQDLFm?=
 =?us-ascii?Q?oNaJmPsCT4YD8Y6Nv0Kw2HFMmiF66X+3A48HtE+bxkfLL4KGiGRpBBrlT+YV?=
 =?us-ascii?Q?oRYeJnBiET8KNcLVhnHajANh55SlJl+99tz9k0LkCp3cYaQ9K87eZ2oCjT9D?=
 =?us-ascii?Q?RK1EPllNCsXU4gtCBz/8QFguvJ5ztkHHeYHqpXWy2iYqzILE279DVpaR5UVA?=
 =?us-ascii?Q?yHWS/eEUiGprEaHM1AsGe/SA5MnrnyNlmvyaIr3JuGPCSmCCLlsvuSfZdmS0?=
 =?us-ascii?Q?lpEVPWy1fvHWtG7SM9oJG/a5kzmtlXcQJ/dRyqqVnEoZ+gB2Q3cpYrGJtOJD?=
 =?us-ascii?Q?zJzg4Z1TlVGvujkDlhwcHdDv1ZbChl8f7HD3+SNTn1/xjFKHW98HGc0ACZQ0?=
 =?us-ascii?Q?JESg/NnZAF+cyh726ej5s+ptzwcPaIYoSy1nj/McHDg6boJe9O/oahXyrfzL?=
 =?us-ascii?Q?PEsS0h5Y+9JenqjFLKog/fbKoyH7KXJdVWkHvJeUIo6rxzKLtiqmvB0HID8H?=
 =?us-ascii?Q?yZVgMI6jZZAYdFaxfdepc8GxM/eee6SJdnwD3/vqg1ZZTPzIglRNik3KEzfN?=
 =?us-ascii?Q?92eu6JhN3Gizc+m3eeiFYYdS76Mn0i2k4cW2S8FmNmb2mg7P31rHvq8VcGgH?=
 =?us-ascii?Q?sgViNKvrE5Os+C+mPfxTZPYzJL9JA/0EvHPey2ShikWFSLuPKDMb/NjR8JUC?=
 =?us-ascii?Q?Bl4+pj17zufpcAii+CDdTQ2oQaHviyN6x23da6ZH1ctkuGpjTA6MwSnN+/d0?=
 =?us-ascii?Q?ZSwQMqGQdAY5++Av/UvSBVy6qrGhLGIsxGyFy/lcx/QXzC8/86yukFsEr68I?=
 =?us-ascii?Q?JP78i3AKb/6U1+YM41iLJG8z/BxCPtyArKgVdl63K/46abAVBZKjUD72pHVt?=
 =?us-ascii?Q?ds8ZipHZgbPAewhyNP/PcBioK4eqYJ97ZC/utqcYI8g7hYKq4iy8o+mUKQ+K?=
 =?us-ascii?Q?HI/j1Iiy7B5uUxdiszkaECmibaWla6uOXLkmQRmTRdHinJETOy0vCJjLQiEG?=
 =?us-ascii?Q?6EAWiFhAr+gOwIiZp8DSUymBxqBsbf1b/+vg/VCW8Jgg/KKHtKmEGC7GdptV?=
 =?us-ascii?Q?TL77hzanHnZ7QAb6feM/Ov1ZSOGAaVo158oz7ZSdbGqW/Xgio+vM4K43A4Gt?=
 =?us-ascii?Q?sBREyU99fhXX19++QqaaukrcoDmRywbK5dQJY9pehgBHFqagQ2xxfPYuRLQ1?=
 =?us-ascii?Q?bCEsvp9cwcbgqM9PEAM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af95e13-7066-478c-a7e8-08de26b31b1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:59:43.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNtnNwT91HUl3QuqasmP9zPaXSQg8JWZgN/ft9qnccJo2KSwAfIhg5i9hfeDAkVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

On Tue, Nov 18, 2025 at 05:37:59AM +0000, Kasireddy, Vivek wrote:
> Hi Jason,
> 
> > Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
> > 
> > On Thu, Nov 13, 2025 at 11:37:12AM -0700, Alex Williamson wrote:
> > > > The latest series for interconnect negotation to exchange a phys_addr is:
> > > >  https://lore.kernel.org/r/20251027044712.1676175-1-
> > vivek.kasireddy@intel.com
> > >
> > > If this is in development, why are we pursuing a vfio specific
> > > temporary "private interconnect" here rather than building on that
> > > work?  What are the gaps/barriers/timeline?
> >
> > I broadly don't expect to see an agreement on the above for probably
> Are you planning to post your SGT mapping type patches soon, so that we
> can start discussion on the design?

It is on my list, but probably not soon enough :\

I wanted to address the remarks given and I still have to conclude
some urgent things for this merge window.

> I went ahead and tested your patches and did not notice any regressions
> with my test-cases (after adding some minor fixups). I have also added/tested
> support for IOV mapping type based on your design:
> https://gitlab.freedesktop.org/Vivek/drm-tip/-/commits/dmabuf_iov_v1

Wow, that's great!

Jason

