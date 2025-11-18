Return-Path: <linux-kselftest+bounces-45914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBEC6B7B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 20:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2BB032A005
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E12EE60F;
	Tue, 18 Nov 2025 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4lwrxbX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8A2EA15B;
	Tue, 18 Nov 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495055; cv=fail; b=Mwu8U16lekAZgA96t3d64UWzBQREgCPEEso2OYm5kCLFNTE0Vd4RgEoa7Jty35jygaL/Ji6HyVRgNOrmPqWBA67zRhxdpCSjSsLCLpvyQp6yFOyfpY4XzTigZEaDsfjgaJCCJJkx7QG0v6v2vzYgxExCFVfMOfxt0sXfDM5+0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495055; c=relaxed/simple;
	bh=TmXMa7pwcVdLSdgAovyDHN7pETPvGyXNO3/yeyKyaAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cso6AID0eSvIkJOgs7OCGWNeyP9DyK5F9UmNKXmZEEVQqVbim0XexqSY3gzjneQ9uEYnz7gzWxYzAOhN8p8yc7VmPTMMZGf6TpLCm07Di9IXrJId32E6dsh42siqfdmE5DGCAf4qcVq5LsjRamLaq7flxwnv4btR1Lg6V7+bXik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4lwrxbX; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtenEp3Y47nz/+gGfT9HSnvkzaIPeweJh1j9D+qwNATKAGYqygy6TX8cSbhFE5r1hz5+9ujxHQmxKd9M2Y7vO1LZMXvLv6sXWuLtaZzRsoRrgnHjGgfSI5SsJxt5mfNX+UJ9Aaqcq+CU5GvTeKUZxqS8+jkrOTfnZ4r/7+Pq5+oocam4B38GCrVwEn8vUZgfUv8HbR6Gn64D6gQKLxoVXRxTeszm38MgombZe10KvIkkJebxtAMAas8beTyGflwp4Hfx1dTMFtQYPGY4EHJCXLuD/AWV1Gz+G++uM6AwRNNPz6oysP25sRDNHtwRD/nlbAqT5yVz7z/00ma4cz2SlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HnAf9yjhyOVH8hgODzeC22SUAwjAH/IBMFKlO8EQNE=;
 b=s9lc1Wad680iMILsCLGALSxdNCEl6VU1vYC7v1oYP2eTzoCjqG8gZOv7uPyobRG7/72YC6MiOKHWlfB1G+vz8qzJEonAWiGwJgFa3ehwRm86LlgdBZE8BvTacZPJJ5QLgPdUdHXTFFFZLhPyjmobB39T2jUuBz7nZDTNH0xNezDyxOx9KL174GqSs2aTxeLRIsSCE2pYa92+z/6O/eSj1UTZQD52XAdm8GG1Ek+NR9cOjrSZaCnSfenSiFFfZ4o4x6oQp3f/0IwuEd3Ndgx0ikFzq/op4WVCTVrztn0dFkAXw9thnI8UzHHCPOV3oqy6ioHGfR0QrthWOjPooGxXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HnAf9yjhyOVH8hgODzeC22SUAwjAH/IBMFKlO8EQNE=;
 b=O4lwrxbX/CsbozudfZ/9poYQR6xMIZAovvrbpitujaPgyRPaOTLwrs96wGC8WO/IHW+oVh/w9YDwsu9+fyB/Dt0EAHS8/MBnbKPQCqCaIKwRyu0PDzEfF84CvgjJE+RsMSXVQCO04qk8ySlLSRBBsMVRerl8N141Po10DAiaSnkSgMyswAVJ19QKONRZcJo9YvRsmOSlbyUgCikfQxYZKsXqYaCiUtkh50LuhNukbCBeEmkmJ8Ome90xR7fh8q4QD5s479++aMkNlqsU0Sda4bWuS8jOPqzTKllXtdLO2OXb60F1EJO+s735lep1D+ya6KdepKQFVWcQQfIdCnCGEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 19:44:03 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:44:02 +0000
Date: Tue, 18 Nov 2025 15:44:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	patches@lists.linux.dev, Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Message-ID: <20251118194401.GB120075@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <8-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aRZyNaLxrwSKKMXG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZyNaLxrwSKKMXG@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:52f::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f277b1c-171a-465a-920c-08de26dad378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3tfG/vlG+l86C/S7ka9J17KbYcWvjM2ZKYQuLAC4c5PqNSpR0ABcNBUjjsDp?=
 =?us-ascii?Q?DLRtlb4cde0eBOSVauVm26our3DZr8U/fJFDEj8PVzkKuyWxx5hD2FQc7f3v?=
 =?us-ascii?Q?6ArrLpD84yk56GokXqWdsAeuRpzBuF00KW1pwbg/nPMaHllL7ZDyYjjpXTnF?=
 =?us-ascii?Q?gScKPRHiq6nOxnd9k02AON2MU40fo1ozitCd7mEgG7P/uleD2MonfMnFwiDT?=
 =?us-ascii?Q?JM3GHwj3I5UOEuDv1ll9SvwL+3r/lvSdg2TMHIEerME/juAp7ziy4AYQb8rw?=
 =?us-ascii?Q?R9C0HDxbey3WJZpm3xqwUAVvOZPF7M8YzNo+9HX0lP3+2ee7g5O6VBOvTZyJ?=
 =?us-ascii?Q?VbqsEVEI/2n2TbyQStNsZrktx3qrXRGwkdmkS+co3aoX1TvzriBGy6URu4LO?=
 =?us-ascii?Q?Us1xnLXTPMhzDvfOCODHeHCQQzneNvcQbAU7036nvra6sKG9HXzIQoBz2so5?=
 =?us-ascii?Q?uDCmOl3mtxnZU9k/qgDHNuap0G9aoBp/psb01rKntXKzn51czdI6zTed0gpr?=
 =?us-ascii?Q?xQKNDatlvKg/5HBFj8yMkyQ1X5C6Lk4dIvjUtDPyobuzeMZeGe64uwu6X11d?=
 =?us-ascii?Q?CtKBfWKPEWtfEzX0X+lNhNrSUmM1/sI1W4VIQblQnYOnIkZPEFkhj6hLBUjI?=
 =?us-ascii?Q?e0lQtmKwn3UtunTYxuMb/zdHBtQAK0EUEGvOd7E85IAIRZxOPjSmNWhxtud5?=
 =?us-ascii?Q?W+stS8jUJ6cb/QCbQMOX6at3x774n+XZskuJ5+KBJItFEbv9Zh6kPxBLkgnZ?=
 =?us-ascii?Q?X+PCudIPORrskzRLajSfVN6/FzazKzUktX5FpY96KHYlVJzfYocNRdDaqeDL?=
 =?us-ascii?Q?r2KSrnur7EVxnfN5i7b4reXST7LulCmtJwRJF1agQQRtfz177RUWop/EiPsi?=
 =?us-ascii?Q?Z4MPIjnRLp+pnG+w2saRZFTiPbanmoEfbP5GFBHCsj6jQe+JvjX+Rto0EiRD?=
 =?us-ascii?Q?OanVNE7wv8K5zRncnw7CgDcnQZAV+OKT34cIKdqLJRDo0XTD8hqnc5IVUQ+U?=
 =?us-ascii?Q?AdQ2vBRcxfu+R80uh7s/sJo1qPih2LfGAdLbswXsSSrVrys7ZHNEJ2GmnULY?=
 =?us-ascii?Q?YySHdXeejMbIlE4nzs5rqeTtI+U4iPZaVRTWi793dS+Llwnyu6+obil1wGZK?=
 =?us-ascii?Q?P1dhbhUcQGlELg4kZqTbUD8nDa5h0nEkHUwtCXNZz1vPoFwDUwkElIHwOvK5?=
 =?us-ascii?Q?Fb7jwYb4tgmEsQUyGyJ03GmsB7Tbuj6X2tPTdo65WrD2dwaKhTE045D8WDcx?=
 =?us-ascii?Q?up3pO7WLYc6pV2z2b77wPJMraeRgNDm/lo4GQn8rIzBeuIbBm15WodgrmHV6?=
 =?us-ascii?Q?JDlzUUdnpfnfTckvtz1+fZHkbZP3mNnpBnF7SNam0zbmk03ASur9k9DGBnv5?=
 =?us-ascii?Q?4irJRPxjnJp8IdNFeiQccp2YC+1H/qjuJShLFMCGg5c33z/kFqGqVILw7FMm?=
 =?us-ascii?Q?fIE0b5iuaeEePj119+0yDI70N16Y9j+x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8Ew0LHOtgr9vKYUDTax85WCjusOrVszHHW+zXlxBwK+DaiX+Sz/biKfmFA7?=
 =?us-ascii?Q?pCwBqQNUNNAk5A5Ef0CyIaL7YARV20qwJQC/68dK/qDNUNxB/0QwpW1QhNhu?=
 =?us-ascii?Q?dkFPSSY0GZSp17KcDEyr1ntcnxIEmHlMYZ0N8mFwixkPirviByAC8p9Uxx3Q?=
 =?us-ascii?Q?FQqKbr1Ly2l0cOet1ADjkTUDYXryPqyvL7vWCikE+m0FP6xD2XEjwTwrDn09?=
 =?us-ascii?Q?eqpLWFnLzhVkNGKsSXTWUlpMYUXcU3EIiW9xTyOeK9K/P1Iam26Q/WquxxWv?=
 =?us-ascii?Q?Rxtv5Y4/sMPaaBiNX8DdmMIh0fRxBpkEBFAV7GO7wGh14kiceFmuNWYUi7RC?=
 =?us-ascii?Q?64k58ka5hCXNGRnax80eRTMAVIMlk0euSZQ5smRGggMYJDjV9iI/4RMgLfF8?=
 =?us-ascii?Q?95LDuWyKatIrM9ISlKw57OKZJvGMvNv8DOIkxo59RP2V68+K6lfa4cHuUunS?=
 =?us-ascii?Q?8ACjck0i4CZPMCT3hTu6emDg3E6HiJRZzNKf7faCPrMaFYY5lwv3X1IwfGUj?=
 =?us-ascii?Q?16bxa6OjU7P93NMcI/+5AqJguj2NDmah7ENq8BpraNjn1f0Qusle3pNAk8nl?=
 =?us-ascii?Q?+ie4JkKoR20boHXfzoZ2M9u35lXKFl25ZaF7AEWrXFDkHuzr04N8CUGZDqwA?=
 =?us-ascii?Q?Rkaas8rvXCcBViRjine71dfsffnBVPV3VUfO2Yn1+JMgNZ/NblRgNMh9RnxC?=
 =?us-ascii?Q?H6VRfOFDr/whvp42t5as3E8bh+mKfvZY50d8lL/stQ7sTpsvJu33W2DCD9hC?=
 =?us-ascii?Q?yf7Akg47r4+VM0fBspSmY/0SsEyX0CNWIdRNML53a+S2FnBTbcW+AEw+aRoY?=
 =?us-ascii?Q?Ds9KOJLfkcJzIVKG3gBh0FhUAbX0V8kmbbH1iKKW2rUsWkIkOxaYdFBhXZRd?=
 =?us-ascii?Q?MdpL/tthBQJ+P1NT21Gshg2nnp/U1UqVbtgbRZBqCoIT4+pysVDYTNgZ75Nr?=
 =?us-ascii?Q?0nGk1v6bazzzE1O4KTZlRWOyf2cyzEt4nMEVrZ8hUollGSuljEFfZ3ekXexB?=
 =?us-ascii?Q?52yBHte6ANhHNU6B7+AIRcudlBgmtzRq6fJh2BDwm7DOcW5VKFV5uAMxxcLM?=
 =?us-ascii?Q?1DOQCFZsF2fwM7sNEwm2ftK8xxG2GuEt5Rhb4yhfTC1bmv9wRVx7QNuIhdCK?=
 =?us-ascii?Q?hLzfn00SOoqD40p4pKwwrgKpl7rntD1ipv8NfDDAaVJMekdYfhNGUCNe5frt?=
 =?us-ascii?Q?kb4rMJA5FTJ26cYhW+UYjGo5W8adiLsxi+iJIgkOj+/teZ5lcN2MLLA1kk/A?=
 =?us-ascii?Q?cS7VjPiDk7Y1YhMIx6zi7m0aBkLSToXw4lR8lshaLYvnwDjYmZbmZcr3iPCN?=
 =?us-ascii?Q?/Jng534XooKQZUd1gtBniXzww+T08Ba+i4FYz5bl1kdQ+Smxj5lnxQGQloWL?=
 =?us-ascii?Q?i6fY2O74Mmo6jbuNoFXYUorCMCaGD9LJ4awB2QdkAGXGk8VbKo/woqlFnZii?=
 =?us-ascii?Q?qCvf7yfA50BjxaUbDlvqSVd0PS+KD/gPYhtm2aTIGL2GfhX6vd1c/Cr6BpOo?=
 =?us-ascii?Q?3PHH1sQhEdh5MCadYJNo8C6WmQi9AbpRZisF2U/ty2McrfJKALTG/nX5+fx2?=
 =?us-ascii?Q?de5/VV2Ze1AEqVK5d9U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f277b1c-171a-465a-920c-08de26dad378
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:44:02.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMa9LA2PZuzihoH33jnWM0HSFSsPaRoWBuF++Vy3uMXwCfb/gSpWKtJ+j0TUdhwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240

On Thu, Nov 13, 2025 at 04:05:09PM -0800, Nicolin Chen wrote:
> > -struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
> > +struct iopt_pages *iopt_alloc_file_pages(struct file *file,
> > +					 unsigned long start_byte,
> > +					 unsigned long start,
> >  					 unsigned long length, bool writable);
> 
> Passing in start_byte looks like a cleanup to me, aligning with
> what iopt_map_common() has.

> Since we are doing this cleanup, maybe we could follow the same
> sequence: xxx, start, length, start_byte, writable?

??

static int iopt_map_common(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
			   struct iopt_pages *pages, unsigned long *iova,
			   unsigned long length, unsigned long start_byte,
			   int iommu_prot, unsigned int flags)

Not the same arguments, we don't pass start and start_byte there?

Jason

