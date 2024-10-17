Return-Path: <linux-kselftest+bounces-19969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D99A270F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E21C21B3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4D1DEFCB;
	Thu, 17 Oct 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGs95Ayk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657B1DE3B1;
	Thu, 17 Oct 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179480; cv=fail; b=dJWSYXU1o47/mFN/JVykbGK1PLBYnJG7EBqVIa1aYZMgupxliQ8TypXsrokY+W3Iil/Vz7nDdlaUoz5F4COAEk2DstMhKo1Vfs1M0BDfxylKXbEAGz2EzprfC0HpEY33YhLkvybLGh1cJW9R9B3uSkSPO834HYfvjarXncReZTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179480; c=relaxed/simple;
	bh=i7p2NNDylz9yUiy+AVYF0VuWo7ACQEqK+uKeJ8QvTEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IS4M1xMKr+bE3C26KqvogewbJA3r1XSJzln+9pD6DDBhHegRKACDbqCLjz0IvdAO/JQkpu0xUDi3rAomQRmTSBX64Unq0JCf1bD/PG2GEcVwnhEsP+RUYhK/AEP0TNdwMigSCMOt+6AffeVjhxqUthsrDkyPdNlfUcHit41RQKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGs95Ayk; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmvT/mrC0nRYUpBKKeTjBk0I/Nz0wx2eYG4S8F3gXtz6qsHGJlHCB4TCXkSOLrxmN7buLLDFw1lJ9/xBeu89NI0jpY/XWRf0BXPAo1btxie+U2XEInCNDduo6hkQ5i7t36DQQTuVIdOC4nKj4LWmFfIq6TCjQnEKOcHuIALTciEBn4mo9KWXp4RxlNkfGGeN+k8w0st7h9VcMGtBaQcYPKuE/w1x5vQZJ8yB7u1U364vj+ceriX4ycewhQwGAfIKwDoni6F5tGVDaJYBcBkDtAZYcN/fPEBjzMAci+/dymgoIQzVviJsZg2dfYlRD4S2Yam6XdhAxoPq1+Un5zKdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpoU2JU+tvsu3Fk6J79037N2ueEErrpYRIa52SKJ1N0=;
 b=MLgAaOm7o/t6uG7c0s+u3ONoJV6fNVdDT2YJ2QAxpNr5SLINt5lM43dnBOP+6b3sIsDe0cAXoxxvVWR+PUrYrp4niMsqfNFEKG3EiBsQL1cQXfSTDlVrrVHNkn5qfKcddM6AeTOY05t+/+BCMBcGRjKle0BMPNu0z6GZBFdTc/kxytRyg2kG2hm5bDNvhKUSNaZPhf6g3Rfwvp8RA8d0nEIidE/+HTRf9qBFzxfkXRC1yLqmDNdFq51BHDn1DDy55k9rzHc2TQsB/1YVmwVmUZ5mbDZaSf1LjLANjIhxZHa1BEMwLYwZhirsAsZ0QgkZJocaX9U6tU5o0pichpvfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpoU2JU+tvsu3Fk6J79037N2ueEErrpYRIa52SKJ1N0=;
 b=aGs95AykLr55fpbqMfSR2Fhgujh4Lpg1ZCWTI9tavRO4j9+jzMnbRI3aCe50Ua8qMq2XpuuRD6+0VSnSOY09KiaodKgFyzi+21ZR6eGmRGl5UdnSyQQBdNZ1mmB2dIyZULWw/um9duR+FGeMWpNB11tFDFn85LvTcVgIdJoyPoZWqhuT2KMnYoiy5AyT6OLKMX83Qx1OQUdJ4ODm0LnsVLAOEgEDq6c23zo+gbpTeZCZcJaAsIh/O8KBjrU4pevoWoDXbinl9IIhUQVny2Ij5RoHPhUiSqpLd6hp45x1LF9gAYGFUYRNDGN7vH6qQ+U9T73EPWiRp2WJeRRW0CZLYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:37:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:37:50 +0000
Date: Thu, 17 Oct 2024 12:37:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <20241017153749.GA3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017141416.GZ3559746@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:408:ee::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: a1843724-3ed6-4c46-d974-08dceec1a853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGYgCDvFis9RVNV819EgygHmWqVCxXwIYL4e89RyTDwjStPjY7Xy3tQHje7O?=
 =?us-ascii?Q?nc0lChaAsHi6VWUBLjlC9+7QsE5K4tV6ldZPsfEr/u927POyb9BCrvdlXzDf?=
 =?us-ascii?Q?fjGhR0xswMltJApKi8zpmTmyaiPr1K3YjdbNC4d8R5fsajA8KhqH3C4aJpPC?=
 =?us-ascii?Q?pXOwNjMVBFhx+SaLFGGwHwD3+OFGfvba955deyQ1HYiSU2xdKp7FtivOwny8?=
 =?us-ascii?Q?ZBPuQcFFDtpQPc0QXdd2NcPBTAcmapcrKlqy3hOhvsuu9PWIICvKFTxKZnvu?=
 =?us-ascii?Q?RJagzhv9t4i/Z5peKUJry568cTWo7n71/cKBWn/8biZiw1wYw/1JTinEx4WW?=
 =?us-ascii?Q?ImZ1uYs9Qmo3ha9etZHYAxCEUXRYGSql2CA2j8h1SkUQ8aXWRWROqI/eGszL?=
 =?us-ascii?Q?5TxGFlLkYVuEj+tWqxc58rsiI2OXkARLnOhvOghpcUZ1FwUh6hZimAW2EdIJ?=
 =?us-ascii?Q?C7qz8yPFwwuAlR3bajovmezwUz0UWs2jtFjGexX2kpu3A8YNYICLnSf0h6KB?=
 =?us-ascii?Q?arq46Uf5kXZkjb2V4NqLKl4o1KqlCVQbQrjvg8jBcvyuwHkCqy7hYC6OmJEq?=
 =?us-ascii?Q?a2vklxMyWvQlSrUWKZPvTZmhzgl4Z7eEXekQmYLs/QLurlt8DXZ2igq4cSHd?=
 =?us-ascii?Q?yJbFzsckogcRBwIJASe4ka5Np2C52sd+3f45iW/Ylc+ooxqIYcemR/WjrHs/?=
 =?us-ascii?Q?dkUDnFVZx3Yab4X21hrC+U7L6/ZLPDPl8Zy9ZXKKzRhSQ9Pag+mVVgf479CP?=
 =?us-ascii?Q?xmiCkJDUL2x5iHQvs7xm8PQkz6MeU+79cDLFRXjrPREgp69k2KfwM09ThzaI?=
 =?us-ascii?Q?CLye65ckFlR/ElI1SDUJ2JeuboMCFFoQ6lcKZyglkFDE+b/9pwhoH+BXYVMM?=
 =?us-ascii?Q?rLJzq+KQftkYBOTlCc5cLl38J2v3+8Eph8jSUbSOgFexC+yQyJtlR/BOWMKU?=
 =?us-ascii?Q?cezb/4hyEqEfZxt/RTFmGonpALmKUIvshutmriS7ok9YST0fFsVAxnc5WRYF?=
 =?us-ascii?Q?vFHVJSJqv1OtpSzz8MP1QXgsktdAd3TXmpvxs9spP5Z6qZC31BzmbiUanSg6?=
 =?us-ascii?Q?zuSdQ9eEEk3u2plWiqTg5O90FEPk6dbdDGOIRgxkwIs1+KqmfYIFJsnk2nQH?=
 =?us-ascii?Q?wx+Mv/DT377iqfjoZV6FVGO+GkGrg/iYFwaE0bmbPFUjSH8jwJ2TH/TNKB1/?=
 =?us-ascii?Q?dDjKWhew2JRErc3r+4xiGWzHXEredU45Pwiaa8DO4BmaP9IsPsXhz1XwAVa9?=
 =?us-ascii?Q?WrTS3QKCMm+Ae5PQPOcEOY60y4SqPddQPA9bWXKrJ8rxY3qZ/UhTRCkzBjqp?=
 =?us-ascii?Q?y+untS40oL7zoUR6wcN0IISr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QH3t7i+ENXbDkiYmWLSRiUM44Fol/GG+PSRy33m+13iPJ7YfAFRIaVWYTqij?=
 =?us-ascii?Q?SxyfEWOlYUU6r8uK6gf+S//QcK1osw6hLKg576fYnYydisTlLfHjBfxcY78f?=
 =?us-ascii?Q?s34RJ4UqKH3Zldds4qLfiL+pPHr/3+kp6NuHFgxFzY7yOh+RRFKqG/C9PNJ6?=
 =?us-ascii?Q?1k1uzS5nl1cIoe0V9Bmi3fYFdS/UgluOGNzj4WtpYDRy9imCU8UtYO5vjrIF?=
 =?us-ascii?Q?XuUdrz6M70VGqO8mK7o0STcn4rSb6+mL857Rx8mYlbtjCXJxZtcj/M/joFRo?=
 =?us-ascii?Q?RequkcPzLmhXciuv6slCVk59vAaUo+S0BkeavcFdA2U642j6lf/GQyGi1P5Z?=
 =?us-ascii?Q?u134bI+pDSm7/CmLCwwR9x7VVQzVQ4xo7nFkUN88XtdDa9hdHwlJQHGaPhiY?=
 =?us-ascii?Q?YvE8ZXmzN1dPYyrhxJXZ92ovni8RLa9JXcU7dR8T8R1umdTVikPOloou66ip?=
 =?us-ascii?Q?pKOsajh8X6VVCPXNsQWuzlKAgTfmdg8vrN8upmQ6zxFIXCCOI/OuWmciniuq?=
 =?us-ascii?Q?JQlz19A+WGfgIjUDckJo1hQc0Qs4Bs4u+tMrmeDYYT7G6bcIiXtbzewu/fXM?=
 =?us-ascii?Q?WYjE0yXYTS14sW5PJ8vcapTDp1sAZpLDlVqzJtpLtVIJllIW+en3u5qSgmZk?=
 =?us-ascii?Q?K5H1sANpttdlUc5U0bGumtSur8QgL56yoAfORQBd8RZEYNjLD5S7dsONzYds?=
 =?us-ascii?Q?1Rv9fL3voIBGfS2L5Xe8Q+op+EfGfwBIZKrpx5in3lj4yuk0D0ax8Lwfp/N9?=
 =?us-ascii?Q?QfvHu0wJhdNjqPrFjhopzDvoVz7dfJlZv7xw+Y5hafAkJ2sS6Bq1tpQ+ntA6?=
 =?us-ascii?Q?qcQDzvHZ/VVoGVYrA0kqTAZxZLuzotg606FzCe2h6l9I+lxTLHCK2T0oyiZu?=
 =?us-ascii?Q?PRPD85XBUwpOrFxvJX7w92/SOf1GnbVKVsOUILh3vshGYjjOWyakq+AOXxdW?=
 =?us-ascii?Q?29aM8anu2U4lgnuyJkcv9hGnDBxVh0VcnxxA6VgPBYoA8a+Wm8FPesGEVfln?=
 =?us-ascii?Q?cqlYEXtErSp730N7keBFdOjZNhSJXEubDy4DaIk9C5MUbiGtt9JO0gBXjBHm?=
 =?us-ascii?Q?SUiem7d5uh2Sx0897R4aEnyvOPyFBTqJhF/NsQNtX1LYRv9MuuzlugbJjDS2?=
 =?us-ascii?Q?Nx/y8TIejtrErsnhFisnv9JaTDyX76cHiEJ9WPjBpWHAx/P4gWjoTwisL4jK?=
 =?us-ascii?Q?LaAHi6eejg12TS4qz6M6aL7Djds7mzoadN2l1c85/cgPMhRa2ukpiwAN+Se6?=
 =?us-ascii?Q?SbHBkTrEQ6yV1AjZkQKbuh7Cdbo2QjR2lIcYhyVw7lDoCfaTU4sbuVOFDUPA?=
 =?us-ascii?Q?vekj3bf4p59m97iGHS+Linz7D+406mPwXyAjLaQ8yTaIPe9HGQnbhYZEz+Ua?=
 =?us-ascii?Q?2tWUgCkJpU1lOeh/JEZ89rFZVU6FeMq79PWHQlNF6c0OHoblqIQLM5xC7HHT?=
 =?us-ascii?Q?17Cctx2EpNQkbn6X71XFWzpsG1c5tRASrRhj/WRVAPvkelbWkAVuJHjVvoM9?=
 =?us-ascii?Q?VREJbH/EoMl1fgHQ5FKbJltHV5GT2ZYG5KbpKDeHyA1sWcTmxVRN8qInN1pq?=
 =?us-ascii?Q?2xmUdPupAwI3vmXY4vs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1843724-3ed6-4c46-d974-08dceec1a853
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:37:50.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLwyIEzCcaBHZ6JJvM/fhADZgAyFeZ+BgKeZ0MyRMlGhAaCZrijebrTsRhnJBZyL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

On Thu, Oct 17, 2024 at 11:14:16AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2024 at 09:38:02AM -0700, Nicolin Chen wrote:
> 
> > @@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
> >  	iommufd_object_remove(ictx, obj, obj->id, 0);
> >  }
> >  
> > -struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> > -					     size_t size,
> > -					     enum iommufd_object_type type);
> > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > +						size_t size,
> > +						enum iommufd_object_type type);
> 
> Maybe call it raw instead of elm? elm suggests it is an item in an
> array or likewise

Or keep this as the __ and rename

#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \

That one to _elm like this:

#define iommufd_object_alloc_elm(ictx, ptr, type, elm)                           \
	container_of(_iommufd_object_alloc(                                    \
			     ictx,                                             \
			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
						      offsetof(typeof(*(ptr)), \
							       obj) != 0),     \
			     type),                                            \
		     typeof(*(ptr)), elm)

#define iommufd_object_alloc(ictx, ptr, type) \
	iommufd_object_alloc_elm(ictx, ptr, type, obj)

Then you can keep the pattern of _ being the allocation function of
the macro

Jason

