Return-Path: <linux-kselftest+bounces-20957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9969B4C5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C80D1F24641
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD452071E7;
	Tue, 29 Oct 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XoV1iF7X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F3206E9A;
	Tue, 29 Oct 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212974; cv=fail; b=CZS+HGx76t6Vy0uleLzWosNhJM4sV6xy6zDsVCdDWsbWgHjM1Q+I6ra0A4o6gS/BOU+7Hq04x2N5cdJ/ZHMA+h/yfnF2xRYaVqjw3tZLanfpTp/4xWzcHerMTRYN+FJhADnxhJEb/D5PtbaM6iVCHQHaUEnZfk2XaqZi+BWelVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212974; c=relaxed/simple;
	bh=3ml3QESvHyTtaNd+FHxwJss+zjqT0Q6YpMH2WUkU1Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A7pDwoWj5+Y2zJh7TpWLWHsNO30Oz/jGJV8I37LiZWfgJRQkvAjBYfZ8IiQ54sg/froUb1UnZiUSkdEGlCXOKRD9LnuuxiFenBPdSx5eZL607IO0oLW08usRNdG7abNwDV3mOe9fjpnSROmbpUqXefiWDeenNEU4GFmgN60saR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XoV1iF7X; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyqMpZKjf3bsssewNegdX5bad9mBNiXeAJdxDlQXs3fN6fvZe15/OtHGzTRDxPMsZHF3VOr6MD4akKjkD2AS7WjvbL9WkCJvYrjtXouJoapDwyzPYHjq/0EYrMKeNycV95Kfv6xvJtsmLBvW2XXeFo8hADGHqoLuSOIe1uDa7vlsoWOa3Fzh2p2N9KvRPy5MDuIue9xPh5l2HTLYjqJdvCLJ0/XH0fCmE78ONmk4ZFWs1IfdFnsxFo+dwN9/1erx7QX34YhomZOsa8UEKJDQtYCDbISaiTKye1wXopY1Mwir3JOU/iVSVDL/xp66rfhW8OZsz3ZI3DOaFBWtpnq6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h5vQxCJeDzyRwVKNHxGKWLM4F24idCZCnk5/EbgZp4=;
 b=C65BstvbRzFJTaxOOLFnrm+YGpj87aUHB0a04ojOKf21wrz34dWDOU2TYwHlOuRvRU658KZOSL1O4wznicr5XU9WiXH3wxkMyYiaUqun6wsdbxYiCj7NnW6Qz7kw6IinH9ZclGgp4xuhbc29NgbYS61cZ56rznnUD4qC3GXVTD9Q8r4TWv9uZI4BHtkP2SVknwG8wQLaAvODSD+lfl9D1ZbTRMwH5zjbRdDLYACzUYpvItw0FwGkaJ1cS2VJBILPwDOQnGdrW8m7FTXje4q9KGmIWsk4So2xIHjoTD98IVO1rKUTWz16DMZgmJk5LhFRaLJx9+hExEb2X0rU9X8nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h5vQxCJeDzyRwVKNHxGKWLM4F24idCZCnk5/EbgZp4=;
 b=XoV1iF7XoDUIsWrzZWyxZkP014oVamJcP+g3UqVdlX7huuWNqT/h2K3ur5HmlfQtJeTyolsFnvVFpqNKvG0TIKc6wrdv20F91Z0Gr6wR/rigF9asxrzJm7g4SW3S0fvS6+61wSmIW6t+3Q7UGxgqI9hCbQeXCzSj8uVJlMLf/Lpowbr+kqQTkJ9MlcVjc0XnLylev+b3akAFkrmNhz5jz/kZOkc0nNcVfWGxryfG6P9YvO8dCSv6TifuY6wsq2GiAhT+8kgQis5rf47pA1BDKcTtBQZUTn0oXrh0gCRQtLZFIxGFlYBOh1a21MpFM2ATL0s8z5aauaiMVlBEYuVwEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 14:42:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 14:42:48 +0000
Date: Tue, 29 Oct 2024 11:42:47 -0300
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
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 02/13] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <20241029144247.GA209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e172d2370223a5a012a70aea76175b71a95964f0.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e172d2370223a5a012a70aea76175b71a95964f0.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:408:fd::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 28cb35d3-f43c-46c6-db7c-08dcf827f52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQQVEpzsLkpnVjjiE1/fYaQGcYVag8aZX+iwSbZuNnKkQm7PLX+Z0ieWht7E?=
 =?us-ascii?Q?yQp0TKulp8EBeHVC1j/DlGycXsvejzxjiI2Zof0zTLUR9SNS7mBfU6dbS+EA?=
 =?us-ascii?Q?FEGEickezvCkOwDBAar0rCri/mc1ZCSU193f012YVnOat0M53QrMIZRYpLy9?=
 =?us-ascii?Q?pVremj5E51RxknciLx8MRJKafSgwmdyf23GVoY7cG0BkAVe3QcUaWkZZoPe1?=
 =?us-ascii?Q?/GCtJ/wB0nm0SmGvPyFt+D1tzgeNuXMdLWq5yCNExvJIWNqoobY4Ops9+RKt?=
 =?us-ascii?Q?6XY9jaUJ2Ua6yspjTYsH/lrVP0wIXm9afArktZq27hhztkPct0MBq1AXYMVl?=
 =?us-ascii?Q?lgOf/9RDTkQFFJ3csSUfCBEX4XI6iywsJvTDOhF6O6hzMqt5NIf1Uh3mzWVc?=
 =?us-ascii?Q?mnt5mUs9AYkI3niYQ/RsGKBNo0AVCNEOVpRznQvpZIIoNN2L7MNB3G9a0eZm?=
 =?us-ascii?Q?5xNS3xJjbfxY83Gzvr1qpBo7ELCdbKJFclJ3/mVYKUpzitm3tV3Xt/3C+td3?=
 =?us-ascii?Q?94GT3Py6x62T4wxCJUIrfpwKAnflkHwDguIgATPufYOHRVv5wIdIEGOJkSrG?=
 =?us-ascii?Q?aXgBNi6X1L5bkDehWOQ0F/hDuBC27aQIJHgmyvpCA3QVW2UWJpb+A+pmcbkC?=
 =?us-ascii?Q?L1FAQt+yrB5JcGdeMW4kzcSH05u5C2ODXQUisFAuzSpCb733jA1/sWF14/yB?=
 =?us-ascii?Q?nVvkqqb9h4ouzU6IBSFW3M+bka3GbP4Y3s201DbporTq1NTqwWDd23oR5IBn?=
 =?us-ascii?Q?LwyZvGWdhcBllfDgue+QDNX4M4zrrqNydTURKCEIPJnT+7j74CREBfZHICe7?=
 =?us-ascii?Q?ZBIR/Iq0rGOffyytkmB/8keXVF0N8a8MNdotSh2TjtLdE5DQ9u1ee93EViFv?=
 =?us-ascii?Q?UcS1kZEX3/S0Xp7pqZZb1SQKhulKVP45mF8BT9M7lwp20aMcrHMn8hHjJjwz?=
 =?us-ascii?Q?OftziGLQZjF2v0mlqPctTPF7bvfNOmKwfZq5uJ8+zflPi25NMvGzbx51khlb?=
 =?us-ascii?Q?KLTz8MrkVkM0RUYHZiUUy6eEIYi8wQmapVzPKRc07InD4CpDrc6uDDyV34z4?=
 =?us-ascii?Q?Q7KRJUtnCLb2XROAIBVt1w888bqOOetalhmHbVWhyuz7OgOx7frab11GJkbS?=
 =?us-ascii?Q?iouDLJmG6ThySIAFXxzE7lrM27wYyVWjJtdeJe7L+XDfqmNagyTCfIjRuwLY?=
 =?us-ascii?Q?ZWHSLEoy5yGw8GAsNc/1qFGofzyZMR0Qw1vJOLTCNnVcCetq8okOKRWM/Py2?=
 =?us-ascii?Q?P84/Pg/EwenSvBqBIcZTc7DpxUIqlwWv0R1KWHfIQYYl2N08XsiSQZlHskmf?=
 =?us-ascii?Q?pdzAl+zd77KtV9VUMFXvbYX3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/hIRD13EX0KjXxuzk81QxwvJaChd89+bwZUOcLTljBEhqIaAc3SIfhFOJUB?=
 =?us-ascii?Q?1PWzrt/qMs2O4kAQWgRUGEDtAUta8mDDhs8X0eBwM0xKJqYxfmEQ2uXMJICv?=
 =?us-ascii?Q?j06AVG3tj/C5a7sDz02of2EBIi8I62KntUAjgmsWmtD9Fi08G+gtbaO0+aLp?=
 =?us-ascii?Q?YmPotfVmla6ERHBwmL5WspVP86zlTT8f4cGG3Z1a9z59dbM7js83HPcPZFfb?=
 =?us-ascii?Q?ytEyvl8PZqStCPcrustj75O6gXdy6Zle0TtgXsOGaYRkGk/TH/bE+S1Fz5EN?=
 =?us-ascii?Q?1PFcJyKDwDYV+3385mMgJ0B+s7TEe1AvJDzoxLAc2AyIQG8PeOj2x1koVw/j?=
 =?us-ascii?Q?cyy59y/O4do6BpwoVpT+8VXwkuLYvyh0Rco/4szmNs2MBuX5EwpPM0MqQkoY?=
 =?us-ascii?Q?SEL4lCmKiFBMdeSliq4aSsmQ+h6FPLM0MwqLAhzC2S/PPrUS7AsIDXbniR/p?=
 =?us-ascii?Q?ip42zIlZKVaKMjD63MtbLNSDoSfQjpMnPRDdEJGrsn0I1mjhwqpRm+z+bu3x?=
 =?us-ascii?Q?AcrQGriYdmeANpvgXz4NovztpvnrATx29u40KRCy29sATBbZ8hvQDFz91XNf?=
 =?us-ascii?Q?A1DRKdcTR3fQRTzicPSYcotdONc+FJ5OM7XSjIaXQnSXxgFvMNLPG6P40rMy?=
 =?us-ascii?Q?0lUsjpatsAAvOAFMhgChdhgqpLrSjoYYCJ/Dcc+icc74p62ZSkMruj7mder0?=
 =?us-ascii?Q?HnqdMjWv/G639e1jY1aTQrhnhQD6MRQmL6ujj6DxXGwWgx+OxCAZ6rfiPDpC?=
 =?us-ascii?Q?VgtoZkrpCDEA3/TYLjaF8jjjw/hGXnkb+1aiK7cMRZCzj169H3M8TwuN+gSw?=
 =?us-ascii?Q?xflL7Zdc7JRZsYsil40ZTA+vZq+y27GqQImZ2K/LeDHjV9doAV5+28myGnKX?=
 =?us-ascii?Q?16aCObGS+dbSLUM0GE6ITDjWQyCRRcMaT1mLAmyzq4AFu+IbGzQqK1dCcE0d?=
 =?us-ascii?Q?KMO3MLGFMc1VkuMJMiYO00AlTgHWWbmfYNvqrzGip3RjpyOJ0pgpOu535YBc?=
 =?us-ascii?Q?M7WGzp/aonQWDpCPnarIJqcDLP3GWTW8FE9MVac3bAmacTNFPrCtEa840Oyl?=
 =?us-ascii?Q?RlOkZQqdfZWmmwAP7EJnzoyr+id1d0yPUa3nrOOT1GC82DvnSP+5WfVlfJ+d?=
 =?us-ascii?Q?tr3ojewCBOesnQ/5MhC2D8LC+2gTaLcxzedanZqBSQbWvtXefg2yQa5O/X1k?=
 =?us-ascii?Q?LmhntKiFObWQ9vI/7vYPs2Dp715wKh0p7eyku0QpwdwD1jqNALn8XuySuN5w?=
 =?us-ascii?Q?0SN9INVL32WfMf+EBh+wlKOJ27cLkIA1AJXwqoxQCZU4i4fPd2wAclPyaYoS?=
 =?us-ascii?Q?DBCFCoYleW8a5fqK1xFwlqR+i1MNMGfXVernZel38iAxsljjBj/d+yVo7ZuI?=
 =?us-ascii?Q?+W2jvErBeiWz68c5DQsVzCcuYda4w78M3n8JUy7x0p/KE/K3FGQgwYKtCO9X?=
 =?us-ascii?Q?zC74BiD9S4RyJFUQazwBpsZkasuX8p/pTZ4PR2173X1AGZXsGvuBce37Y3O/?=
 =?us-ascii?Q?3cmaX+q4u7TTsM95DyPAyupBhRkOPDku5Cm1kEtSCcW/z9q8ao1ciaxXJoAg?=
 =?us-ascii?Q?fHjgbDpf1q6cyfOClDc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cb35d3-f43c-46c6-db7c-08dcf827f52d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:42:48.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ID8Ju49NMB3z/NXKM/iSB5xZutpz3hOK933nw8H+Fugw/ron3y+WezUOmj1BGiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On Fri, Oct 25, 2024 at 04:49:42PM -0700, Nicolin Chen wrote:
> Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
> a slice of physical IOMMU device passed to or shared with a user space VM.
> This slice, now a vIOMMU object, is a group of virtualization resources of
> a physical IOMMU's, such as:
>  - Security namespace for guest owned ID, e.g. guest-controlled cache tags
>  - Access to a sharable nesting parent pagetable across physical IOMMUs
>  - Virtualization of various platforms IDs, e.g. RIDs and others
>  - Delivery of paravirtualized invalidation
>  - Direct assigned invalidation queues
>  - Direct assigned interrupts
>  - Non-affiliated event reporting
> 
> Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
> vIOMMU structures. And this allocation also needs a free(), so add struct
> iommufd_viommu_ops.
> 
> To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
> It's suggested that a driver should embed a core-level viommu structure in
> its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
> meanwhile the driver can also implement a viommu ops:
>     struct my_driver_viommu {
>         struct iommufd_viommu core;
>         /* driver-owned properties/features */
>         ....
>     };
> 
>     static const struct iommufd_viommu_ops my_driver_viommu_ops = {
>         .free = my_driver_viommu_free,
>         /* future ops for virtualization features */
>         ....
>     };
> 
>     static struct iommufd_viommu my_driver_viommu_alloc(...)
>     {
>         struct my_driver_viommu *my_viommu =
>                 iommufd_viommu_alloc(ictx, my_driver_viommu, core,
>                                      my_driver_viommu_ops);
>         /* Init my_viommu and related HW feature */
>         ....
>         return &my_viommu->core;
>     }
> 
>     static struct iommu_domain_ops my_driver_domain_ops = {
>         ....
>         .viommu_alloc = my_driver_viommu_alloc,
>     };
> 
> To make the Kernel config work between a driver and the iommufd core, move
> the _iommufd_object_alloc helper into a new driver.c file that builds with
> CONFIG_IOMMUFD_DRIVER.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  2 +-
>  drivers/iommu/iommufd/iommufd_private.h |  4 --
>  include/linux/iommu.h                   | 14 +++++++
>  include/linux/iommufd.h                 | 53 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/driver.c          | 38 ++++++++++++++++++
>  drivers/iommu/iommufd/main.c            | 32 ---------------
>  6 files changed, 106 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/driver.c

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

