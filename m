Return-Path: <linux-kselftest+bounces-43404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C6BEB424
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E70E35CE84
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB87330323;
	Fri, 17 Oct 2025 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnApAvFD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0012FC034;
	Fri, 17 Oct 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726662; cv=fail; b=TvzabRqOIcVjlDMJcrEYu062xw1w79hZVDqMvmVZA5oLr1TwVF6kQ8YDjIihGlpV7DVuKCaZ7o3n5cJUBxubwI65+XW/MK7Wf2HnMBqaC8m+PXQI+9YFAg1yQsvOXArNgIiSL209GrTxNj764k8A0RbYJD+uxIFnffCr4I5sJy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726662; c=relaxed/simple;
	bh=OBDzFAVT7yAjeyBHec6B8VZjhGqondZBDn/k+Vw7Rlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1L14J71lmtJgVThpPw48Z4/M2t9FX04Kh6U0+CugKJMelUqY0MgEl8fUbHfnWVUb1Y9H6s7mD9PBqoHVkEgXiXAZczDM3qutTb32lA9vk4/FGvoAvafN2AwwMAPOalwP42cfgw7FyIT6FxUxAE7pNnxuzLmZuW+hYZdboMdX6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnApAvFD; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsRNO+6uO3yFbG9bfIo63GMsXh2Y6ps4yBSMDJHMUghC3I03jTqjr1GHwHHycPk89k02DRfy4VGZnqcV0jWLkF0878JnMbQYzppXVYAvlai38NDkJYG7+lzmc6J/wEhPB+0cGQ0t0KIWdPFFv+IVVIhHlFMUVQVTHMSFpePimBEA6W8iIMcGyb1ESDAGSZtlEWEeQx6MObdeN3ngm1w+4nE/yOThNonen49kwMFqCcwQsypOB4m9MGNcDqf6mjqby53mTxxb5REPAPCy38qgFjuykRMwzQMzR4qW07Q8s0vQ3hs2LisljBCdr/4qqjgPg1GAEdVa1ggDasj+yFlgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1VPJWMOJ6aJwu9v7R6N6py9c1jwldsvXKeIrpfFd5U=;
 b=mLjh4dpiyEazMIq3sc9ejuMpYh5MFT1YZ2YRrRKHg1MStdqi22DmMUtlQT0s7Wd0Al1UEqt2LKXHG6EYVxG7/Qpf8M+1iVy2UxHoTRauFjVVtJ5ZFb1exddiVfsGiDffxu9TPQBJ34Dt9jnuYuAV/InMc9R2TiUOydaE9D1OSk6KoNCc3bhCBhX6yoGfFMeOKgKLomztd4M9h4Kx1IklF66vt729TFhGvO7jZw7bouEifzOAM4eAVt21lPyi9mA3vaohfub5GHLhfMMuKbWqfGtq5qWS6Wt3RCAX/oeqfQysYRO3VBlOKAgmICX3HdqAVhKE6tLIHjkS9qPh1p+6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1VPJWMOJ6aJwu9v7R6N6py9c1jwldsvXKeIrpfFd5U=;
 b=dnApAvFDALQP3h9v4k4jHXAWgl2bShACSL+wj8mpVYBoOkNl9g3TTqgQDlqm3B40f0I7p1fDtMUT+rhk/ZlWSboMn3YxTuf4emb1VLdtkL0g2c4RhRkFMdvl0AdV2Jyk+CxrL1uqtpx/9TIPUTRjjCcUmR8T4QywgqbWLb8TKrU65tOWBRXo4xOZR5ANaF+mILCkV9CqNTijEKmxhjTmykAckl6n+mDeRYyYbeM+NapH+3+iUnJT42sh5EumiVz2t3HToJKsgK1gZHYBt+oShpeCunS92rzFZq3IdRSn6N3mlUBc2u0zpEK1XPZ9ou5TCOC3Lkh/kfUCyufKyXfq8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 18:44:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 18:44:17 +0000
Date: Fri, 17 Oct 2025 15:44:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251017184415.GE316284@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
 <20251017163738.GB316284@nvidia.com>
 <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
X-ClientProxiedBy: SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::10) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: dfad804e-5784-4e08-c6ad-08de0dad2d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yjd1fluoXnkW7jaicHwgdqemOOsAIcY3VRI6MoZpd3aN9OJIpd72FBkpPt2i?=
 =?us-ascii?Q?9gCPOf5x9TavGru4kOBQVibkW3QPhDh1jt/jfjWIdSyt35SJNE05FHr7M0En?=
 =?us-ascii?Q?uvPomqv/8UiTpL5xVEiQixWT90tJyHpoK330D6nCEGpls2mV9uiJJYelqDz9?=
 =?us-ascii?Q?bKqoZJ2V5ju1ejrv2q8ORGEUxwUU/60piC6rIyj7I8pmqw+292bA+4QWNMES?=
 =?us-ascii?Q?s3Gj1jAoZ5b/gaA/04bMWbdef9V52MQAYqE/GnXcDZb6QIiNucoMDte3/4/w?=
 =?us-ascii?Q?vwgZejJZmtuoBRJNX6+cA8d01oy0nSjpKU++XU82POibriRR197M406yk2Ef?=
 =?us-ascii?Q?Bxv20Hdybas/J2nnQKeVl2ryxdsQHHSspsKVL1vXDvcoq7AQuDhhZ+2D/xHM?=
 =?us-ascii?Q?7PSW9qg8e5RyB3NWmvuPhbzCZKu0SiqMWQceK19+oYgX7gwpkXyvlcH4zIZ+?=
 =?us-ascii?Q?RVxyLS+fdDOtyUfrshIUpVjDHTPnwqq77PEP7Zy1EPBT/ArcUg7GHAJSqBiW?=
 =?us-ascii?Q?MKbT5Wrtwmq2qOr8rXTd+ZNg4lnpIi48bvDV3ekmt4CLEJMAwTvcBmWPcWfB?=
 =?us-ascii?Q?NihDtd50t0HV2b+6bMOjcHu2AcvgrPaTAzVa6UxWVLPVDliJTmxGRHBr2pVu?=
 =?us-ascii?Q?v21/aCHHTNd7BJRI+Blrzwm9pIAxQswJ9maOflQV7J4cvjlOw8b3W2F9NVS0?=
 =?us-ascii?Q?+daOtqwwN8oJQ2xbQ2VBtqWgbRZ5ANckZ3BUJ4tFRdo2mhy2Ohr8lBk3n8x+?=
 =?us-ascii?Q?Wr5xl178zAb9Sz/oCTKI1xOFfqzIvTPBDtrYGVmnUlTAvKP5jt9dVy/vVktg?=
 =?us-ascii?Q?OZRvvh9z65ks9KT2mgp/of8TGC1u3vUCuIx05u5HyyzeWtaAqmA8BDJ4nKIJ?=
 =?us-ascii?Q?DQxLa7YBoTbL4BxknwH4NzeTIXjk6niAmyGoHNjVsDdeXSqWTxanMOR7Dwst?=
 =?us-ascii?Q?QlGS0vCm6XY7rhrg8ye6jHuAaTHm00SoZ7cMkee/u/izQekZqrdz8GvDqA+9?=
 =?us-ascii?Q?YFhaQCznIW9F/paFifjOKwrUJtQCsSmezdYQ6gvOwGFbrTF+/AB6aXOhoZh8?=
 =?us-ascii?Q?e0NvLQsWpRSs4XEE7HzBnncpoXKXDTlG2+M5oBbnG/PYx3+w0IdWZoav/3Nu?=
 =?us-ascii?Q?udV48sXd8hTVmdYXPOfOBLwIY4GQDtCPuhBWziFBBFGGRqLWLazTr6koKOJQ?=
 =?us-ascii?Q?T8kkwyp051hZOnrFtmhy9O6hpIQX0n+V+6rpIYFzn/9V1mU8v7B14Ct651dO?=
 =?us-ascii?Q?FvQWJrUhmRze4TKuPvORLmK+yTOUp6J+oM2WBud0IG9EJwyrD01LU0NMUNFP?=
 =?us-ascii?Q?8xBi8+xpl20d1PvF2y5170m4cGzDp6wEhLjUA6ZOJRJbCg1S5UUp+vqGY2f+?=
 =?us-ascii?Q?BaodtsTSJBkiQkepOoIFHPTGxwckv3SyG8t/+wS6Boib3tJTQYbuqeNZXO/4?=
 =?us-ascii?Q?NyX/9UltLtZYQMrVZfZdJVpA+M3ii3vF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0VXA03RaiYjed81IHhkoMVIJRjn9ityjVoyZaQl5SRijz5zXMe8Fvvg5P0z?=
 =?us-ascii?Q?5bFMC1sZq887qQnS4wCh36cgbV/FzVGSjArDgUlVM6C9aKgZ8Q7vq8h0uNcM?=
 =?us-ascii?Q?cYV7iK8SE99PIn2A2M4CAOE8o9aDcfwtOgGcJFO2TnC3ZDgh34gm5uffK8eL?=
 =?us-ascii?Q?yKAvRkdMH0v5pRIKDfgEbLNQz9aZW1OqtcJXHjuNDTjM3/h/iiXxU9Juewep?=
 =?us-ascii?Q?LotVCPz8fuok6o7zDj43gyqJC4IvPvfvSW8niY/Qiowc8g97kkvn9PPPEdig?=
 =?us-ascii?Q?W33R8QAcVVJxAWLBromSRwSCmHUPaM6UrETfX+gRm8QesrwVuP2nuHTgnIM5?=
 =?us-ascii?Q?bn0Anw95It+MxqeMyU0ERWFuthpNDez8xLMfK0mE5+v88WPOAxaGhQEsBbeX?=
 =?us-ascii?Q?Xcg2rW7qIrjVNv6J94AIX/FrH4Gt8LRJj/ueLRdXSlRkMz73FyrzqqycdsB4?=
 =?us-ascii?Q?oL7TeeNwaAh8oQckvkPfSI1T64g8T9+e/ec9sUsB3Ifyvwy8u3nXsTVOez1w?=
 =?us-ascii?Q?6UuhbmnZxpYNj94pmkDNqxDG6b3HbLQkZJMik5w6ycq4J11wjk5rhnwmljDL?=
 =?us-ascii?Q?aFBkijyeWCAlLABpRtso2ifM4rISsG1akkcX9plCkPvC3bCjRwcGfl71ABk4?=
 =?us-ascii?Q?fPF7wnTpCf0q9tN8zsCte98r3S5rWYcmDcowdI0XC1G1MjYNw/skzWUIPWsm?=
 =?us-ascii?Q?3nCrly1jvriZT8YXfti0Cpyg/yAK4hlfJnJ+NCA6YLIBvmPsUeYiDbScDbv3?=
 =?us-ascii?Q?/UnJAASLIN0AeY+SBPEoKFO3NOYVcvThvfqyGXz6yTDNuBsP99R9pwWL3v8U?=
 =?us-ascii?Q?QCLfQogQzi3OlX+0F4e1U7v4tQGi6s/ueum8BoZQywwRIplYR/wAfYJgmhdQ?=
 =?us-ascii?Q?hfXf2Nu9zkcaGJ+Ch87DsH9jM+TCimplPX74p5T8b1pqxZzqZtnjXb2Wgjyl?=
 =?us-ascii?Q?DN4EBZCgytNCe6kd3gK7Pwkj5DdF6n5rJhRKBiG7hrSZCj3ABZ+ysrfvOfmi?=
 =?us-ascii?Q?pyULoZZuCw1t4bPcuj6EcTLl29tgogkjzEjkhGRoVPNNdeLaLXcZHQNo8ZPz?=
 =?us-ascii?Q?vHgSBEGAdDr/9lTipTGldChPPd6LKSj7PdoXl/PTrt0pUEZHXdl9h0qPnAzG?=
 =?us-ascii?Q?DdhgWjQTduS1YYdbauj6jTXsGNcSiEprzDgwuzTfJ1jy+pfQmZv+0t2n28s/?=
 =?us-ascii?Q?4lx7I1WVn7+kbWFdeFYXm8E2Nsjsa+HuZGyspM7x5ByUnvKfx+2Es3re6clJ?=
 =?us-ascii?Q?47gWTkP2hNQC5ZLn4Lyzm/2IGEN013xjB9/5NY/h+JCcog4y1aNRNmQ36Thg?=
 =?us-ascii?Q?T9aYUcS9Zjnwa4pUCQz48XgIypVlVoaC8txSydM2wGjnMc1/Ol4AJYJ6NYGG?=
 =?us-ascii?Q?kt1Rl8fzz0IT8/XCsGsX7jaaH+ycX4Y+PcfcuHWwKlvXySF5n2LX03qd96ov?=
 =?us-ascii?Q?I8V6Yx18nI0P2V/TUOECF9GNedFDRMdjdc/t1ai6kiLV/km2lAA7nx0MLAhs?=
 =?us-ascii?Q?0aVVnxZ2HPJTUVe3USv7LdnLjEDKaXLjzv/FCy+1HDKdz5fQdgm2ueVhLjRh?=
 =?us-ascii?Q?VBegvLn66ozHrku1hPwSHZplX3F3KRX1fxwWTQ0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfad804e-5784-4e08-c6ad-08de0dad2d41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 18:44:17.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRmYuAxU8IbQL0CHOVXitO533pCDep+TALGoa46ezrEp/iJtRBjsKNIK+7zpj1p8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

On Fri, Oct 17, 2025 at 08:19:06PM +0200, Danilo Krummrich wrote:
> On 10/17/25 6:37 PM, Jason Gunthorpe wrote:
> > On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:
> > 
> >> I'm not sure about MISC device though. Unless there's a good reason,
> >> I think MISC device should be "fenced" instead.
> > 
> > misc is a very small wrapper around raw fops, and raw fops are
> > optimized for performance. Adding locking that many important things
> > like normal files don't need to all fops would not be agreed.
> > 
> > The sketch in this series where we have a core helper to provide a
> > shim fops that adds on the lock is smart and I think could be an
> > agreeable way to make a synchronous misc and cdev unregister for
> > everyone to trivially use.
> 
> Sure, for MISC devices without a parent for instance there are no device
> resources to access anyways.

There are many situations with misc that can get people into trouble without
parent:

 misc_deregister(x);
 timer_shutdown_sync(y);
 kfree(z);

For example. It is is buggy if the fops touch y or z.

This is why a _sync version is such a nice clean idea because with 5
letters the above can just be fixed.

Wrapping everything in a revocable would be a huge PITA.

Jason

