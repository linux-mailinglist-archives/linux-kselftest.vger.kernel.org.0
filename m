Return-Path: <linux-kselftest+bounces-33162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC0AB951F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 06:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978217B00FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92E22F395;
	Fri, 16 May 2025 04:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CiCuWzXj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479FA440C;
	Fri, 16 May 2025 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368331; cv=fail; b=pukrOOthoU9QYl8SU/+DYUSQ0JbLUCfNToRqUwyyfzX+sn0NF3RnP2/gp0+s9Db6pl4LlPZMBpYLOL0ImkI0BfTuAXdLtgIVZmUVBCvNt8jWBYZBXOTv8pOsOJvxGiy2XAv9mqfI71gjj9e5vKgDbToVoBJ3PjyjzcflbE+SJlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368331; c=relaxed/simple;
	bh=3U9dYsN+8uFZX+C6iXXbHCuXB0KrIbut6VJJ9Ev3EmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF6Bqti2gLhJK1X6EL/b6Ae39g4D+ax2t5qWn20MChV0uH6WqqSy11vG/bip3m2Exrd3ftxiHWXm0I4uISOKhOP4yWAZHjrJbpNvc0c0PA1Jpuy2qBPTOtkjliHORCvhGfwD6xDQsZmFxMD1zg0zzgdgIWvuqrrtwIuFvFsB1p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CiCuWzXj; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIP8phn8JheeoQnt5bUm3KsWfSZmH7k2vDzi91md8+u3SCiAj698wAeqIy837pgTCEflYit3j7NEYuNnSEOulJkmTWn0ECz5jQ0DFnT3RTcT5I5B9jTg0Gtx06gLcvHYgCAdo54129l0p2hbWtWNTTKwAORuhW4UJdLh+uIKc0Jw8D4cZibCjNRA1FTYnP8/EBciChltyRqwapyyZdnwIj0luMRHkwukfE+3fzamIcwKLDMBaGkLjsTqNRszHfzJkoeh1iPBa2usGwLb/bWRYKW71zvBsPF10pUZ4bxsAadp/UIZXtCkvEA+DDPWlLzTHxjbyh7MZt+LiSPSecAYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KQZsYuF5Zj1b5clzhzIPVLxBId0xARUK/WSURvzz8g=;
 b=UxHswhZtu/BcmIx6V1iDNsN2uRwbtNSQCkWlkDzjzpLnM2JCcMfRoXOSJmozFq84sKccJT+eby0ftKEWanm2rR5GL3EglpAp0DrW5Vi6kWnb3sar1Bdn04QC1PXg5Tt4ICyeqCsr06SnPN3xWwx+RYKQWes4MtfO4ljz+1sCAgQz/bb/Siea7y7FUztBsaZEMU0bsIjEWz5Pl1PH7peANePY+znO8rNfOsJBpQffLWeisBvzbqpgYvk6Bj3Hh3YsUchnUu6SIc9KOFNfOtp9jWRmfbpGto37jvTkJP2Gh5LqPXftWfJGUBUYSKjT0LZT6BIiflTweS4Jn1O0FRAJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KQZsYuF5Zj1b5clzhzIPVLxBId0xARUK/WSURvzz8g=;
 b=CiCuWzXjlfHkMCNPkHhttncmAgoVYbVvppTescuiprFrqSH5FvK/MWPZkJHYBcF68ipDVEyYicIffuTACGZx4RB0XCwDYDMrwy5czFB/i0zrrlWn6tsEnJl5dKb5+GpIzBk4XwrJcryWML0/0L+zoNGPw7Ffj046OE29JO4XtW9yYQYiU/qrqSX3Asfctljf8xcyVxl0JqUx8Y1pFKKliwfC4YNsJ1eNmlggxn1E1/JRMvJsdehrkIqqmX07KqN6ZIEqprIrXgmjEdcyyek68fWhH0a0x3Q0W1fqm/FrNvTax8OFkudNvv9nuycuQeCz+mDBbpW2jIHJ++wMNg3azA==
Received: from SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 16 May
 2025 04:05:25 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::d3) by SA0PR11CA0102.outlook.office365.com
 (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Fri,
 16 May 2025 04:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 04:05:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 21:05:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 21:05:10 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 15 May 2025 21:05:09 -0700
Date: Thu, 15 May 2025 21:05:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aCa5dLKso2WXliut@Asurada-Nvidia>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCY2GKfMh6f+vXHj@Asurada-Nvidia>
 <BN9PR11MB52761839AABD5AA55DF3FE118C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCauEGCqk5lVikwR@Asurada-Nvidia>
 <BN9PR11MB5276C2D25DCF30A7367EFD168C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C2D25DCF30A7367EFD168C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: e41645a4-87bd-4952-ddbe-08dd942ee2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pq1kumWf2OOkzWvFmj6bcJ1KSdxKgQU0vre7EP/tRXpMfPaZ5Mwe6e0+Y0jD?=
 =?us-ascii?Q?vAASKODU7baVulV1FhNhbU6QAYmTMGWgJSG52Zh2c7eTi9kKfBCjqIPGIOUl?=
 =?us-ascii?Q?heYc4Kj1hmk29+TLcScB2p9GC1x+tSlejR37p2HLUK0oIG6++94H7zlIA5dz?=
 =?us-ascii?Q?2Ntx9QwfM6ny9GAjc0YfwWgGuURyDP182bDxjbwfvqATQtg7JtaTZEafnC7r?=
 =?us-ascii?Q?C/LZN4adL5zFj4NB9k6wEcnHsLn1/3SjGHTEVlMkiDL06JjTxXOwgdlwX6D1?=
 =?us-ascii?Q?YZArLMj1JW8bgBTJW83eyFOWPB4+uhj2xRSgx3XazhJGf56Zf0uFdVpz32c0?=
 =?us-ascii?Q?6oEmwjnuQpNyg6CjeTPu9F7PcYCojJxD9uvQJX3bV2Vx62eLannyaZverc3V?=
 =?us-ascii?Q?b6381BxYp8SDtfEsK/hxAY7Vca6ZIzYfwBYilmLlFcwAz6k7wYrZn48FBDlV?=
 =?us-ascii?Q?ci2+GqrzfJsRbPOb3WoYavlpqJI9aws2qsNsgsKAEGOEk+jH66cM7NOEYRvl?=
 =?us-ascii?Q?Q3nDDDrCTEkJT7FR2fMsjndTJtk7TFlRWnvpkwP1ZeShvrIjvmrb7TQBIj/9?=
 =?us-ascii?Q?CrxjMn7oz1AQc2beyB1aIxKKGmx+kLoHPproYtWoaQLaOQtCkk73ltcIZ8dB?=
 =?us-ascii?Q?OCU6AlYPePXIXckIDXL4YCLdTv3VaefMdGgxYdt0xaVrGCakXDflkPuAMkFz?=
 =?us-ascii?Q?PxcmVe4Cm1sk4pGmrFQlsEn016lrwDGvAolcTCdnkOGj4dG3FudkWMOC2LSn?=
 =?us-ascii?Q?OH+fU1RWlpNaws+0/dov/F/zin67w7/zbv31B7k0PkG4xnpY6cp1hjNzERPG?=
 =?us-ascii?Q?a3SHLr+p0D3zk+p+2rK/TkiknOt/0pNrtySJc94rj67MmEEWRZ+LNZAU/Gm/?=
 =?us-ascii?Q?znWn8oaqkZKQXSz+lO0flziDiYTOWXVoHrLvxL8e0OUg807qwkKtYDj1FDTt?=
 =?us-ascii?Q?LR+vrPguwqT3FtxhxKh/5kFuYrEr/MXdtR0Vbskr+NOfM+xg/aoGse4gfE3c?=
 =?us-ascii?Q?K+38csVmhl+CxOzZNCgj5Lt+S0numgub65PDkzVwHiAA/w7892GN8etKSWEC?=
 =?us-ascii?Q?gzeCfHM4CZLoh+d0CmJTt28Qg5bC1SXtCNG4ZIx6Xuvew14hJCH4mvEJfETE?=
 =?us-ascii?Q?3Q/KVOmlPW2oT5VFjw1rHm2Ux5sBhKRM8BDWaJ0VpWzNOafhgaYeNWWp8gV/?=
 =?us-ascii?Q?7jiPWCYEz3K78LCgtb4/FX5VnW44F4lILL/ycHdjWQzKnjA2BWy8mwdCe/sN?=
 =?us-ascii?Q?lEnzyUU5SShU23iB/wG+Y6dcCB1xIYpklBcsGpbwyPCifh2D1EAu4RMKsKOw?=
 =?us-ascii?Q?ReUwfKOyJn6JLZH4RDI+NgRMvXhdCPZwmj6TryKZ6IBNartiJlEwIGuQG1Q5?=
 =?us-ascii?Q?VP7cCnKNqbQFoeTHSg//odrAQiO35GJngrel8WhZkajd9X372KnEWm488tv+?=
 =?us-ascii?Q?CcXqr7uDNxU8qEEhc/zZ0JIhElrSiLdOIgwHAwRE+IygO1qaHmNIHNSt5jm1?=
 =?us-ascii?Q?ZO1VV/49plOrE4ZHPmCsQ8ijH8XyMYT30DaT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:05:25.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41645a4-87bd-4952-ddbe-08dd942ee2f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

On Fri, May 16, 2025 at 03:52:16AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, May 16, 2025 11:17 AM
> > 
> > On Fri, May 16, 2025 at 02:49:44AM +0000, Tian, Kevin wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, May 16, 2025 2:45 AM
> > > >
> > > > On Thu, May 15, 2025 at 06:30:27AM +0000, Tian, Kevin wrote:
> > > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Sent: Friday, May 9, 2025 11:03 AM
> > > > > >
> > > > > > +
> > > > > > +/**
> > > > > > + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> > > > > > + * @size: sizeof(struct iommu_hw_queue_alloc)
> > > > > > + * @flags: Must be 0
> > > > > > + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> > > > > > + * @type: One of enum iommu_hw_queue_type
> > > > > > + * @index: The logical index to the HW queue per virtual IOMMU for
> > a
> > > > > > multi-queue
> > > > > > + *         model
> > > > >
> > > > > I'm thinking of an alternative way w/o having the user to assign index
> > > > > and allowing the driver to poke object dependency (next patch).
> > > > >
> > > > > Let's say the index is internally assigned by the driver. so this cmd is
> > > > > just for allowing a hw queue and it's the driver to decide the allocation
> > > > > policy, e.g. in ascending order.
> > > > >
> > > > > Introduce a new flag in viommu_ops to indicate to core that the
> > > > > new hw queue should hold a reference to the previous hw queue.
> > > > >
> > > > > core maintains a last_queue field in viommu. Upon success return
> > > > > from @hw_queue_alloc() the core increments the users refcnt of
> > > > > last_queue, records the dependency in iommufd_hw_queue struct,
> > > > > and update viommu->last_queue.
> > > > >
> > > > > Then the destroy order is naturally guaranteed.
> > > >
> > > > I have thought about that too. It's nice that the core can easily
> > > > maintain the dependency for the driver.
> > > >
> > > > But there would still need an out_index to mark each dynamically
> > > > allocated queue. So VMM would know where it should map the queue.
> > > >
> > > > For example, if VMM wants to allocate a queue at its own index=1
> > > > without allocating index=0 first, kernel cannot fail that as VMM
> > > > doesn't provide the index. The only way left for kernel would be
> > > > to output the allocated queue with index=0 and then wish VMM can
> > > > validate it, which doesn't sound safe..
> > > >
> > >
> > > VMM's index is virtual which could be mapped to whatever queue
> > > object created at its own disposal.
> > >
> > > the uAPI just requires VMM to remember a sequential list of  allocated
> > > queue objects and destroy them in reverse order of allocation, instead
> > > of in the reverse order of virtual indexes.
> > 
> > But that's not going to work for VCMDQ.
> > 
> > VINTF mmaps only a single page that controls multiple queues. And
> > all queues have to be mapped correctly between HW and VM indexes.
> > Otherwise, it won't work if VMM maps:
> > 
> > HW-level VINTF1 LVCMDQ0 <==> VM-level VINTF0 LVCMDQ1
> > HW-level VINTF1 LVCMDQ1 <==> VM-level VINTF0 LVCMDQ0
> > 
> > So, one way or another, kernel has to ensure the static mappings
> > of the indexes. And I think it's safer in the way that VMM tells
> > what index to allocate..
> > 
> 
> Okay, that's a valid point.
> 
> But hey, we are already adding various restrictions to the uAPI
> about dependency, contiguity, etc. which the VMM should conform
> to. What hurts if we further say that the VMM should allocate
> virtual index in an ascending order along with hw queue allocation?

You mean adding another flag to manage the dependency in the core,
right?

I talked with Jason offline when adding that depend API. He didn't
want it to be in the core, saying that is a driver thing.

But that was before we added pin and contiguity, which he doesn't
really enjoy being in the core either.

So, yea, I think you have a point here..

@Jason?

Thanks
Nicolin

