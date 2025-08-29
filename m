Return-Path: <linux-kselftest+bounces-40327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EEB3C21C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCF01C803AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6873375DF;
	Fri, 29 Aug 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcok6k2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7393375BC;
	Fri, 29 Aug 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490133; cv=fail; b=T0fBsvUjfZSksAqjrkcFh8Z6icGaQJBz8IkF3uq60bohZp+rsmVWmf52QX82cuzes6KO9UgkkHdI9bmbvJhsQt5Svhh6OMzkY7lT9/M7qElwum+/d3lI3Tm0uiHnfWAuUzzbdxRmHie/ZoE7ISIUuL/NVlfM8TBW3GXfu5x+cZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490133; c=relaxed/simple;
	bh=l7ne5dTWVImrDoBpIXdw+NRibtH11SkaZI8sxqHRPS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jkh5Vx70b9tg7d63MLUngW5xcpVjscehbNdTJf/x37DHgpZ1zZc1KaSqfjfOm+q3SO3VjX13VltuLpg0JQRafqDsNQoaYsIR849yVgJcW5DoBcUz+ngaGRf3NauPjI7EG0AC1sVUEfcdAZr96loS4b2/Dq37b+uYpNVJ0Niez3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcok6k2g; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFLDy0pTaiUNAO29piZifTCH9z5lKeB5RqcYefWxpd4d9BlaLrhV7h7G8yzP9MJhn6UhKwHTuj/nzwAmmbDcj+kQkAhzFZF1wpbrim8Kn+ZHDNIf0+yzjDhBt5NuSxCubTDztHUdTKbDokpVuIDoV9HYIYHXfITyMcVx387+j5HigwxEt6c6VxE36E8/oBHuQZcSVNthM948BINX8ZAAxnHNQ7cphgr1WPoudESjmXfEm2KxfZXqRF76g4bJQXU7egAfUN2BRyD/Bj1tTd4EKkA0Vr6Lbhv9+C6p/kyMEjGd97tAi/p5vzLV0whQeWuU8ZS1hhTjkcW+ZpkVMM+6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIUOZobmyUXTXCmsrM9f79RZCidc/qtQiS8F4hCJDNY=;
 b=J2fHw5FP4kAmXimSSS+feR3aeInAdiS92ifSxOfkMfivFJo0Q6Yj46sjj7Mbgb1mvL04stsalK5fqXFTWNvLHMDcewZ4Udcz2aNC7KbmrM9lR3nFSb2KnTT04eH4AkvK1e5d41eWNBoPcHYis1rxU0npLsiDlX8CMDGMM2gkFxsiiNvMoY6qP6vFDPAsB/U9yVhasAwRcK9ihgeGgAlQfyCxmJjWgwkJJKiiW4hV/NjlAy9XexG1J4YllVZoN9VySBw2S7x2ld25imgTSzh7xP+5FArZc+HvKk0y746gBvBSWuV+fbcl6L8cHHr6MaaiTPfGJ4OwTayxJNNgqqpIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIUOZobmyUXTXCmsrM9f79RZCidc/qtQiS8F4hCJDNY=;
 b=kcok6k2gWRE6tHNOQONaNPIvC4cAZ8JDNNSoOAJAp4DDbuxCvc1D5yWBqPWJR0ErvWuFkxmq1lxsu6xf9UqrslqJew0P6PIfQUuOmOIsW+uJhEmiRWRY3DFLt/13SHxKeITahvYpXOAFezaDMSECPpbZDtQQjYW1Fwt+jRzO4DO1QYm0BtHceHnK4oJpYDrm5+yYFk9OznSIXTCdhO/Bio15+TjlM8cJApYxpvMMpcKbDg1lrnPxd6EMYhbkTN87R3REf5lchqFjBienOEckMHcTiLc71u35P26sP6n6J9vw26kZsSYUNjzp71mb4fZGulx/WxXhuf0R3xKLOlULyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:55:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 17:55:25 +0000
Date: Fri, 29 Aug 2025 14:55:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v4 06/15] iommupt: Add unmap_pages op
Message-ID: <20250829175523.GA79520@nvidia.com>
References: <6-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <d1150889-e693-4f37-896e-54a871cf4863@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1150889-e693-4f37-896e-54a871cf4863@infradead.org>
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 49205739-1dc2-4b09-1692-08dde7253b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s60ECexX/4RomK5Z/PHqyGnJhXWNUspjQ14IuTq0IURJWzk4LMSvaRVVHint?=
 =?us-ascii?Q?yzQf1sxEOC8FPZr0XyJsAiG4Ckv82LRl2VqR8uEfzw6qkxk+sTMXrwn+LD9V?=
 =?us-ascii?Q?ywR9t1FZu2W+/8DqTvXN43qDsT19TLbfCzRXn4tzetD/aPhBbVdlTGofGz2/?=
 =?us-ascii?Q?9UFrz8THaYf/c3pw20k0AIUuXo+04LHjPxUQYQlHxSRNZPFDgydu2JW3SN1h?=
 =?us-ascii?Q?K69PVkjDU+v0HMZdYfP6+SnPXWEGEe/mqokyFv6oqVzrQW+0hjiQJrQoWJrL?=
 =?us-ascii?Q?ipaFvhiCWVudgtTy7vGGw37MRgdZr9d1W+8DhylxOx/kW1leFRkLQZ1u6uHM?=
 =?us-ascii?Q?U7qrUzCp8Tv97AFwv5PP9hxqoHkAAMrqIcuVPbQV3ENM+xnmpT2T32Mz4lAi?=
 =?us-ascii?Q?fTH9E/4agcUyfDXIMhrJHHi3pWEmh9fjXhWawjDpEkL9eKKq5RV557qFFm5H?=
 =?us-ascii?Q?b4hefEQ0gwewcE1im6x7CBLsk96LV1+WsBIfcU1JSa0SIOuFqs4//vs1umLV?=
 =?us-ascii?Q?2ubY4KCRlbKaUlVGbLtG1kzlh+aT0osDcOINBONdeYXFHo4AK9YoKlqMAERs?=
 =?us-ascii?Q?wbanOPVqdH2MYUYDdma+3MNZ9Kz0+hHntNqLfSxiN88cePV6xSZ9Mp/K0sZt?=
 =?us-ascii?Q?RTeO7avLlLc/bpBYmXEgnsHTEm5dik02fj+j8vJymGOJ5EGqfcwi2kRYaSDe?=
 =?us-ascii?Q?BzCA/+qGYixGXdNqd9pKO/KJWMoYw4sKL1ZTO8MTgWKs02cUAuSy9FFoHgAH?=
 =?us-ascii?Q?q1W5cLoNYANxryvxnuXw+Aybfybfn/+9FZBLhYt/MjaMGeyjU1EiVrZ3k47D?=
 =?us-ascii?Q?vhbBdTG6/pmUIdxKBwGQfqDj3P70FF7E0JYo8z9joZSpaJfAsZszlTJSOeC2?=
 =?us-ascii?Q?B/cscV+3LQhwWO9Njkeuia5MeKBkUHhTD6ncXRkn3K7uLkAZqMwLlwo2JiG1?=
 =?us-ascii?Q?UMm6Qq4ajaR2Dj+Fxxbwdute/QrlabK6mH7pDmvVHLcdPZOp5E3f1mwTqXa7?=
 =?us-ascii?Q?p1lSzX+Ris/cg1j4LGNtk9vLqk73r6Hjx0IhBv5ZP9joHhuHsGW15IpRgGcn?=
 =?us-ascii?Q?y5xqGc6Li/A19fd1LNuXwUnYLXWv8dODWWrNmVt5nfr7I4ue59vJSJvSSx+9?=
 =?us-ascii?Q?erQ2ZzVNBEtRVxv/JFRlJtL/b/vdeuRq8yneuG5T3KKXXG/I0LbNODL39NEg?=
 =?us-ascii?Q?vCDSL4NQmzzMbOWZTZ1/R5sxhg+bQuoeBdcM5Fw3f3ca2Zmb2anBkAjCt9EB?=
 =?us-ascii?Q?zhSxySHQVLppXaLloUdBg9XFIgtuZfodBUuFup8G/Deg2XZWRJ4aAtn0fbS7?=
 =?us-ascii?Q?WXbl0AiHwfB2d/M1MWXLtPSzyYajFFRNVM1ujag7IJtnxq9lfA51YEmHbkYu?=
 =?us-ascii?Q?igGfNpcAmcygEl9yrkJ6kMpXd+P12w9avQ+2eyVAvOB+ewr7pf63vdMLfklr?=
 =?us-ascii?Q?69/xT+DHNbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pmfRaT0hg+rDu+UG6tn1He4syanc0+oLl/fk9fF9U3kLlyPmLqcq1efocNRJ?=
 =?us-ascii?Q?86GRVfF6oiAq99hA/XB8GUOhz+UrWZd/3ZnyG4C80ePnCIW8MOdpvpsHHJQ5?=
 =?us-ascii?Q?Ix5PNpymaSFRMEpqZCVDLK7A1ojFBWgAtKitRYnocdCiC7DLNvUtDXz8u4UC?=
 =?us-ascii?Q?0HWHCoQDodsf4e7/XrqZHtEN8jYQGJO2dwsuJXF7w+HFAM199mC9Ktr+ufCU?=
 =?us-ascii?Q?PUMaWYVSR/pu8yaEszVTBCSxidx9aP9GdyND6c/c7097TU+RIVZjdN3LxQXH?=
 =?us-ascii?Q?TEp8KyZvjWYUbPrKc4bmKhiCtIrKd28vZldyq61RMbALyWo9MRZAjU+qrgBC?=
 =?us-ascii?Q?1nwcQ0XZ0CFzMII2nied+N5YvzupD9RSD1WMcC4b4y31fO9HyLKoDXBHVuVA?=
 =?us-ascii?Q?eaBgc4H79Lg//4wBgrp2280wvWhVTXlUiKG7aTSczaX0l5Qw/rpTdSfnOMbd?=
 =?us-ascii?Q?RmiKcDssfQOVcGaz58C4oz0OL4P8Tr6FVVH06T9ak0FsUqFUNkHwBMlfuNQe?=
 =?us-ascii?Q?3196r/ODbDMj5Nr2fVl2YSXH9eUj46ApJVGqoRwbh8m9CamuFc5zT8fifyzN?=
 =?us-ascii?Q?ZSYQelIDr4NNRf69mCwagsHEhYYZu5ltDRxTY9A22/hpqTxSaWcp1/Q8F7gS?=
 =?us-ascii?Q?o75Qrnpkd5OUDaipmAIwOgLErJCOzBg7dgP6SkWjkzFKEkHcHAK857/lXRSv?=
 =?us-ascii?Q?yPV/clYygLqa1l6OkzpZHOF9RfvMP0T+dSWVQAU2IA5fgOAP4KaLdue7YWEc?=
 =?us-ascii?Q?JgdA9wuhqJPk2XqjqSR6g+AK1MdlMobRbRTpGblzPa3qdakgebTTUJA8+/Dc?=
 =?us-ascii?Q?Aw0HW02N4lYiqGPot7ZO5V2ExfIYFR/TwiZl5TgZ/u6ha0bRwylPL8a8sK3z?=
 =?us-ascii?Q?oszus6Gai35CtFysGW8oYHzYDfpc+iL2H+zZ9zLIcqLV7O8ecujPaEmnC+5u?=
 =?us-ascii?Q?x1aABe9jEbYEzt0ofameDZNGEs+NaJ3PHJOeqvgNTp6VuSt19HL4XZFRw/gp?=
 =?us-ascii?Q?SmsB3uxI6D5PiUL74ZjtODs4PrGsi4MIXbowYJ+4WscuAWrtlF+isfjjH1wv?=
 =?us-ascii?Q?vATxOsza3Uei6pcaQw1JnXD7X7GkP2GfYx28y1FFi1FUZvAWFpbfDrZkuGgQ?=
 =?us-ascii?Q?cQRuzUANrK3lOknyYf6yLExcLpgVN0a+dc6f21K87/a11/tw7c9F5LBQAhJk?=
 =?us-ascii?Q?y0p1sNIwsP3ZFnnZbbascziPbMb8zNICECtRq/UtEZCt+wJh4yysyluTGyhD?=
 =?us-ascii?Q?FTFQnj0DSVJcphCOICa9FyTVU19oLJdTzfuQju/ivMRGd02nzPXa/qHfRu0l?=
 =?us-ascii?Q?D6HWrSXMOjfuvXG0mgSz1X3lh8GY0RXLF1Vwon7U2IEs0EaAyCkxchzT11sB?=
 =?us-ascii?Q?WqbJiLa+R+xPwdsyMSy9GIOU/jSzHoa2AJG2S/71NxXPgw/cr9GiaAL4h/bz?=
 =?us-ascii?Q?0gws8Cc1l6RXbnubW7gBvRVKofkDZhu7rbrU5ZWqNL/VcdDCUOgyhxYr3k79?=
 =?us-ascii?Q?fFiqQwjnkcOryvDpgcIbQ9hcVOiNnDG2cD2/XL2yMNtw1sXsU4WTozi2Luxn?=
 =?us-ascii?Q?/+iejPzRrYMgJabLb40QffN8VNJw2Hvixw9rVdHW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49205739-1dc2-4b09-1692-08dde7253b36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:55:25.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pTMfrRJyj0tRCAVJeSpNFVE2N1Yz+MAvKXRPfM4XzBbBF+Jlq0Io/doN2L24SYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

On Tue, Aug 26, 2025 at 01:44:09PM -0700, Randy Dunlap wrote:
> > +/**
> > + * unmap_pages() - Make a range of IOVA empty/not present
> > + * @iommu_table: Table to manipulate
> > + * @iova: IO virtual address to start
> > + * @pgsize: Length of each page
> > + * @pgcount: Length of the range in pgsize units starting from @iova
> > + * @gather: Gather struct that must be flushed on return
> 
> Eh, 2 of these @params don't match the function's arguments (names).

Yeah, got lost in all the changes. Fixed it

Thanks,
Jason

