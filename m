Return-Path: <linux-kselftest+bounces-45756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFCC64E3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACD993560E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096226E6E4;
	Mon, 17 Nov 2025 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q48Sss0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E526E703;
	Mon, 17 Nov 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393589; cv=fail; b=WupOmkXLn+INk5TVtwHplcjUPtcTcgomirBStLXaKJ5qwL4G4Y8+9sqR5/WhOfDRp7b63jmoY7TJ+biPz9BleFMR9eV8YRKH6k9n/OnpByJgrwFJXYZKI//LK7hD9LWN+YryxlLrxGHZUCU6W6LrjTZnb2Gim272igbcLt81hpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393589; c=relaxed/simple;
	bh=wZxmslFvjlIY+Vdq+n42KW6TCgfcaFHYBVEJgxZbrr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GrQwCJGW/QRJfAEks+mafkU5gkzwe1Fb4ezFY85LR9gZ2yj1wL5NMl4/vVfiOAVXGBkG0V/BhTnmGxJ4Cx1WQupdSVWqn+NHaH4EUI1ryFjjGiO47ptkab6APTRw5VlpuT9BSfAFu8FQdjjPOsdIYWjD+3ULL7gXAGgjpXAX8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q48Sss0A; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyzqx/DL/DqwHh6BB89+7Bdmj9RoH7/c/cBQbbweehpFrnS9a9xK5Lp1oLCWHl8VPPDdOFlKLwS0tlZ4jDX+hHw0xkCT8gqFlvR4b/kpdXAoszL/2D/LxAnmPyDNr61fcN5wOAHtE/UdwGHDHVPqQ/hCLvTH9+lB4G2tMnysjPt9IsMVEaBoz4Li4UdV9XkNUIeqFbAOGEVbZkErkRVxAO55ewDX3f4SlkLEFI/CjyYyhQhHQpqf1uI4M64ml1G11hfnUJ4vzb1OO75/4tQjQTor5LvQ6e6MRMrPPVYmvzBZHfTD0FS7N06MuryHUHfSChC6CvGoCPaAtMZXUCokvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRRbxp1iJ9sxAtXW5XJQTqH8LSXuGMEkpE3QHqh8rYs=;
 b=rice5pToBD+PGYBfdVa+437QpLFSCJCK1prLShLOPWzanYsjmWvQaZ5TLnLyvssUvx4lBtQFegNvjA7drz33giF0GyGyfTI9F/oFf9gGkkP+sehQZfZz7goG7pOJyfFmOWdwhFpEHaU1UGcLJg2WLBSQ1aheMBkTWuTHP9sI037a4oNwlSBZtVxp6T35EaNdeiNAltoFzrzCOUVc9mzSY6B05ZYTZQtcL2Qxn4BsZYfHlA1ZrhuoZHi9Yz9vaD4kOSw1GNz2JDG55Vu8GSs/SiLezt5mmBYojIn4uiczXrkoA3peWg4BsfLruB3Y/Ngn6Mb4tdSfDvbMbpGlkPSmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRRbxp1iJ9sxAtXW5XJQTqH8LSXuGMEkpE3QHqh8rYs=;
 b=q48Sss0ASyLcXglFvJ/bnHbw7fzXzWLx02jWQKw2VMLnAvbpfuaJpith+pIhGDt5sBClcdOoVn11oamtygkkPgPLN+IoTMKeas5PQy/c94vS12eq6P9ETqa++9sSdnfH/FMhgnehZxtG6jArqPvLhg+Kf3ytSt2xEqAM/5aja3gIAecZK7cTcAe1/TRkERUCRmNnYeLOpAc7Yj2X7th/OfxoTnlP5QuPGnFWGru6r7muctsPylGsE9DsQ0fsYnrgX8GdQOLvg4bS55awcJAqw6EzIFbUhMt9wJZaIG+HHMCffSjRgf+YTyh/SR+//gVWaoZAzjnFUOOFfcwer649kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 15:33:03 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:33:02 +0000
Date: Mon, 17 Nov 2025 11:33:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 1/3] revocable: Add fops replacement
Message-ID: <20251117153301.GD10864@nvidia.com>
References: <20251106152712.11850-1-tzungbi@kernel.org>
 <20251106152712.11850-2-tzungbi@kernel.org>
 <20251106154715.GB1732817@nvidia.com>
 <aQ1-qj0ztQ29h-oc@google.com>
 <20251107141509.GK1732817@nvidia.com>
 <aRGGARe6ExyGpaRh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGGARe6ExyGpaRh@google.com>
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 33727572-8851-4766-decf-08de25ee9861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?auOAcAHihgko1nJ/hNJUQpxkN53Q8cVkLPRsiTaqS5IyvREJCHe2JC+Ms9uU?=
 =?us-ascii?Q?gmUOWk+sIw6MPW3kHpeK2fe1HDJl3eRVoBWUdJwyITRZXkP3y2ZIy0SKxtvQ?=
 =?us-ascii?Q?YlnhElN2iFqdnvZcOlHZHi4LCJHZgfvj82rhRHhnQkUjbvyrcDAA/wvExC/5?=
 =?us-ascii?Q?U1GqynTFQX3a7pFXkSvTFDLZuNhGgHJkYH+hjW5zEw8IqqGdkWgc6N3TSbUw?=
 =?us-ascii?Q?p7Wtz/kupV2pQm80pAYCAxequRpQK0UmJ3AdhD1pDcyP8Y04pgmg63rYVutH?=
 =?us-ascii?Q?oiR1ys7FQVyCaCFiYlBBmNrbUdt9IVMxVOTQEha5jqbKZCMW+gwyCUP6LUfQ?=
 =?us-ascii?Q?9ZRYguZELaaF9E4YPawOELdr7vFxXWUfNLNAri3SB2t2Je87XQAxWsg9CTfU?=
 =?us-ascii?Q?Z/ZtF18WDfOvCPaxOPOYKz97e3VrChGCLT48J5Yw787PW+SlYEUJ6wxRZ6n1?=
 =?us-ascii?Q?w4zyO28xcWuaC2/l/SonOR0Ok/BBZEKYLSJSuDn91oSYOf2y/KyqgKtbhJEM?=
 =?us-ascii?Q?2rVkJIpGvLd/hkNkahlnbpHejcau6L0xlvXmxFgjDHgl3Tj4Ii7cQYCRjKGP?=
 =?us-ascii?Q?qwV5ANcFPltGIeJQuBwoeX/nsfmezX0L/hBqoQR3Do1HmgNZWl9qxN5tmb7s?=
 =?us-ascii?Q?sHbu4uPOAIV9J+vvJH7SaNIVb1mnqgjpU76tPluXna1SmoI3rRhuWSritF0k?=
 =?us-ascii?Q?PfWqctJwVFLBR6O8ADu2VzthQ4sHrbno3uQOTK64xCkylzCfrQ2XBxfBvibF?=
 =?us-ascii?Q?+BCSluPsAUtm0gIO+oEEODk+hn7lWvpCjnJHQIa6BK+ePRV9+PeSuudkg/Ay?=
 =?us-ascii?Q?KqJV7fMUThfD+M3P9j7xJ8uqEIiIpdpbbuareriqr34/hUaZqOO4L8Z/HfL5?=
 =?us-ascii?Q?q5ePbJNcVld2sbACoh6lZ4yRDiX8gjiUKk3kGzlMVTYe1fNNVyU8MQOifG4k?=
 =?us-ascii?Q?R3fy9e5x/dSqmjyo9+NxZ4hT2SLlLIT8kpTo2wJ8E3az9Ni9+79+MnN5InqB?=
 =?us-ascii?Q?eGsM9szVMukz/W9AhtxZpu6B5x6BArQgPA/i9XeH118UBCzmzL4rl3Nr0eP2?=
 =?us-ascii?Q?A8oCfZsdVjtMRRsnMqzUb0kRdlC6QlorYUovvLFF9cpTftOVB03gmLnkV4Qs?=
 =?us-ascii?Q?mEkcAnH/yIb7RNsTw6zZTR6+yaE15p3zQGMZ+KStcrS9MwOflnK1VO3Pggb+?=
 =?us-ascii?Q?+tyqZBBqiEWCNtOGu34hDhy2KX1eMKA0CEUi320m/OQkQbAzHONrge06iWvc?=
 =?us-ascii?Q?rLiYCyHJsmT9PcpRKnVqelzfA1JvsakCdts1v4arSkGbR5C+5/tYoGCnNbC3?=
 =?us-ascii?Q?FSPedYb8DgV/Ecd5bq3QDS+uXqvDqLTx3w/0nn620Q8DVKYYAGNP5+rN5o8w?=
 =?us-ascii?Q?/A89jq+Bt5xoYSFP/zX7fxDioFY4MPoENxzfBr8WodKVh3XppIsInntnCdCY?=
 =?us-ascii?Q?h9jsVWqKgxzNNG6ge1GiR1o+8coDmvxM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5mXOUpxLq5usteHRi5xomhyHcNKYgukrlJGfHegeaTpvd59+2g6zdoFuwMb?=
 =?us-ascii?Q?P+zq1ycn1fSmChkabY5WkaYU8nb7EhHBkqt7x20HCUzoFGjO0bt0oQCyzZd0?=
 =?us-ascii?Q?wnzh8IVokLqCJaCp7beg1OkjIxopZP8RlTlnX8L+EUrWsRr0GfO9nh/hp020?=
 =?us-ascii?Q?w2dEniTJJzWIfS5prIatCgsrJN7esoEgcwSln39gKvias4ooiH66NCBrWpcI?=
 =?us-ascii?Q?Z/Iiry+lP+eXcVlx8ExfYxiVtQJPuDONdskSH26QO3YsIkUWYTosh0xzpRGe?=
 =?us-ascii?Q?fS1PvGt/j6oDs8LLS9p1C7/eQAhGOme/VWgDR0HCdUd8iaWDSkz0j7b8H/1J?=
 =?us-ascii?Q?53gmnqp7obJQGuOU95zU9derdRXeaW+g4ZGI79HVNAPrEWlAXj4ubzstoUFS?=
 =?us-ascii?Q?kMIMRI5j8+1cEnOi9FzZ9N8UIV7+bfoOrJ2gncYDT2PnyRSYB553Zjw92Jyu?=
 =?us-ascii?Q?HYE1VmAHOpw6fohYEzc0aBNL8vGnJUS6mrUk9F1D4fTemkDdl8gWMRnvxjl2?=
 =?us-ascii?Q?KjWu456QUSmLxOrkC+jcH8hs9qLALnfRChRnXj+FKdOWabF3SiLLz2rtYIzW?=
 =?us-ascii?Q?a0wtcPMsR56E2yDnpKitX460odaeqvr1O3T/nv5QOw3moiTOYhFi+GYgGwme?=
 =?us-ascii?Q?JMd6kEi/kz3P0tPpZSnePBtVW8Yw7nHekV0QUZN141YYX5j5ZPkhqeL+4rNV?=
 =?us-ascii?Q?9G6TiICfdHdKhSqQfXI4xi5d36GQ+JwY9pBIVwLQS4dAIuZnvOwUZY57e2ii?=
 =?us-ascii?Q?lJANBSnC35ND0nFq3j7x+KwtjlYgKiGyHIy7yO3DHDZ5AhKKDJe2YL5Ql79c?=
 =?us-ascii?Q?U2nbZd1gbbJim53UZj75NRxJ1Ab1qB1vpYheO6lcTvXWwfvHIEYRotYM7QvJ?=
 =?us-ascii?Q?EOVjVBcgnwfa4baeZD8PXQrq662sQ0ZibuNeS0ZXDRa2VOyMYNUfxt3LprX5?=
 =?us-ascii?Q?BmoPyPyizjYp7JkRRxF6fXeRWkiOkg8byWVvcwrgnBAmXiO83pRvm4yXGFDz?=
 =?us-ascii?Q?iTRCUE8lQkQHuTs82SJ3RSm0Vnn+cc9V+Ljz8MvC9hi9ok2mhkD5WtFrQswk?=
 =?us-ascii?Q?MZJEx5FJVJgoPwttDpO/tPAvB5VAraHJYDWRFIbwIxRb78valVtEGsjgDVo7?=
 =?us-ascii?Q?DV3Ijip/arGeRc2Z+3OaZtWO8qPXTrWwNgVT2+g0qL7TpNXBsPeDJoKxxDJy?=
 =?us-ascii?Q?5KFypDn9Xzt2ohxDy+AYC7KxFyYCzrODokjh4XLUB/A5l3ZAfE8Wr5yITYW3?=
 =?us-ascii?Q?zMqUzEQDAoxwxx+GPze2zG+O0c1Wc/U4RjeUS8luNgudpX8wvVRKMf94tsDp?=
 =?us-ascii?Q?bQgd3qv5z6iiBXtWe3YSYaM+jGBo3f6Heex2hRe3TqWxGE/16HLKqvNw1MME?=
 =?us-ascii?Q?P5DEAcqVHXdiaGthIXZTQ3v0rOtDlsIlwClZuTAswXargeyKDRUFgxvpaVz/?=
 =?us-ascii?Q?JhFZt690mB+81rFx8yzq201DoqHYq6vA1hCKoQ0NLR86ndmas/Yw3Ph4u8GC?=
 =?us-ascii?Q?enzWdefll1S1gIIQSUG0hGcTpVyntSnFkl80MMxoGMKja/EirZt5l7PMAJV/?=
 =?us-ascii?Q?ngLnOgPrPVvzBREcgeY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33727572-8851-4766-decf-08de25ee9861
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:33:02.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qMEQDITepSXyqQn+/5a+MM/w2ukcGbS19nV7XJlAhcIOhTFhreP3E0Fd6RrWKa8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

On Mon, Nov 10, 2025 at 06:28:17AM +0000, Tzung-Bi Shih wrote:
> > It just means the user of this needs to understand there are
> > limitations on what release can do. Usually release just frees memory,
> > that is fine.
> > 
> > I think it would be strange for a release to touch revocable data,
> > that might suggest some larger problem.
> 
> I think it'd be inevitable for accessing some devm memory in ->release(),
> e.g. [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.17/source/drivers/platform/chrome/cros_ec_chardev.c#L260

Again, that's symptomatic of a "larger problem" :\

The blocking notifier registration to receive events to relay out to
the file descriptors should be part this drivers probe/remove
lifecycle so it has the proper lifetime. Trying to use a revocable
idea here will create a weirdly unbalanced/dangling blocking notifier
registration :(

Inside cros_ec_chardev it should have a simple list of open file
descriptors and the single blocking notifier callback can iterate over
the list and memdup the events.  Then your release is just a simple
locked list del on a global list which doesn't have a lifecycle
problem.

Jason

