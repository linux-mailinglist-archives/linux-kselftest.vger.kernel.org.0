Return-Path: <linux-kselftest+bounces-26972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A30A3C017
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BE5188D3EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C551E3769;
	Wed, 19 Feb 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HxyoMvvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7D19CD01;
	Wed, 19 Feb 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972249; cv=fail; b=hsrfyy31DpQ9jdiaD7n65RKCBXQVnjEe/1MqWB+7pe8oMv+W+hapZc7HkQkm8GzB62v0CxrMXhiU3N9HsBjk0W3Ij12AoL8YjoRvgO6ErueJpEIhibO+wKEgK4CeRnhA0+9p2OoCszAzAA9XU0fcQxdegKSdNQQE0tvf/fHwZi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972249; c=relaxed/simple;
	bh=ZFRljIrS61iHNDKbGQSyo6EN5yf8sYDWDYWgzal9yvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwixUQ3Pvgr10mEtbASwb9sHlT9PUN+9RKpvlKTfi1IIPt1BVG19qG6PuqiLJplV5jILJd/uIt/SMFZNi2mOo4FiYzAGVZS8o/+XlZN1LazAR2NRSw4j7srW62Jyqxf2ORNe2i9W5XW7lPLjWaXBdDM5p/lZTU34b2QhTAz4e9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HxyoMvvs; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYPW622ysGkyWA3ubhb24DY0rsuDw+L64J5LiRDGntuoGkwZ3TKoTELxVD2hHsiH8c5C6kfq78M9RW40Lk/j+A4bpalX+kIc5lkORD23Gk/aONz0fzFg75rzbyHNYA7cPu7JMd1KDHZQsrfpRt6+jvzrSv5lRO9xX8pcn2iWbxgUkSWhxkAnuEkJ+ltLUzbn6ARmjRx+6gslv6BVC6hX1XpxCrzp5vYmkwJRTJ74MjP/xZOpGecE7E5M34srlqesCXiBxKQeUojncF6UyJE5b4HBCkaskOuBd9zDDh3EApVgL8Gv3ZuiMcbh6U4qcEw8FshnwgKXDeFg01yJpUssMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXag1oJei1Pso4/az2wQbmm8DNu6iBoVs9BdSZ+5ML4=;
 b=Ax9TvPXaEAOkPiwGrykt+rKiQC913nDrN45+ryhxiJqZIEkfDBwZNZfsmDVEWpp+DJFus7ZZlJv8letsRwI0/vCvyUqSz+CxzLgT+r+CTF2Mjyb0NcNiz0mtgrQz/HFSl4GV83gc8Z4TdgQ4gYvNM1dZg2KcRPKGIjNoeMDXqBUBYng9xNQ4aiENVctDktDyaRSUVItluvWNBiwG58lAl3yqMWMUXYHmqJw5qrtYINepw7NAUJPkGq+eyO+DEggtYPb9ciryo+A7QB+3NKZj/1PDh3aEyhTtlPStXlkRcZtc5Yh276jETFAlsEEun/uaGpAIiGUBDK5pXFi7SoiFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXag1oJei1Pso4/az2wQbmm8DNu6iBoVs9BdSZ+5ML4=;
 b=HxyoMvvscCtMvD2LC9PdwOCHNUIb3jVlBORK04xB59x3IFfI4yS3ZwwWsXfapqZBt6YcdTeUfHGZfJ97bWnlJH8FR9TSYbl4rNcrNq1I9hg2oR1nSfn+qtPbbfRYI1zxzJH3d3M5lCKNtfJPyQh14uoK3zDP+UAXcRmJQRgkwrkJn2FLbHYgHyzOsYqoIJUAzdkQ3dynks5mZ3MMH7/oWrv+5KEyHxmvoDX8e2xoGJRDBJu+v28UCYoY/Ls4O4O8QgJk8KKuLoPW35bQLQmgfoQ2au/KHKzXcP7Xev6Rm511ogdq9lWN3SCTkFRL7d8Ayly9ZSlntspywaQsTqxeVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 13:37:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 13:37:24 +0000
Date: Wed, 19 Feb 2025 09:37:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v1 00/13] iommu: Add MSI mapping support with nested SMMU
Message-ID: <20250219133723.GN4183890@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739005085.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e045eaf-c860-4bb7-2f93-08dd50ea8b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rAy965a2AJ6ZyldwL+Fy/6muZMrf5qusEZMmS4uT3eShnboyoS3GGkfIOXYR?=
 =?us-ascii?Q?hogsE+1FscrQffX25+zS70v8GJYnf7UHSwNRpKXWP8f8B1CGVRQKl6j2/K5F?=
 =?us-ascii?Q?x6GFzexhGob9/F/cEAw5PhesdT8A422MdRYFEUSOVoGo17MHKoD+ANfJsaD0?=
 =?us-ascii?Q?vFlEU5eHIulwFzd+XaoKHKF0OJAKsGoKgWrMrmbUqxosT5Vznydt5I9gFpvH?=
 =?us-ascii?Q?HlephifKuWHPFxnf+mFVhT2CPwzSt6UQb5NC2vddzL9gzoXBj1cHTpcFQxxM?=
 =?us-ascii?Q?/m4Zsclkm9JJy+0Ey/d/26fJln06SmQ+kkrdLWlPDnzmrTvhBWIfrxI2sseA?=
 =?us-ascii?Q?TsUm318RsaVOsL0Ck1ywN2HH72r6QjU2qvumnSc/E+gdxhgTTkTF3tKNwi7I?=
 =?us-ascii?Q?HECOztF67qKBgqEDjlD4zRWHOxBD71W0X0FlYUJs+0hZqlnAmO1/GQrH8F5Q?=
 =?us-ascii?Q?ZLaUJ416W+qxy7GvRS5imBQ0A9a9rf//5MnTO6K38Tw1i1CgAS7+Xhhx13go?=
 =?us-ascii?Q?BmnB+/1dDvDJOXxxeG4MHqYZoXKYJ1Rqh++ECNTwU04t58Ch5SJE7J+RU0y9?=
 =?us-ascii?Q?/RRiE3fNzXIFC5sBgB9xfVajs7js8oxmJ1L9Z8VB1R2q6X5uEyHY2/tvLmRi?=
 =?us-ascii?Q?zG1XILmPMgM0mAShB9YIhWscxB/Ti8pOt2IJI5+Ms7cuuxGH9mA5/D1bkjkk?=
 =?us-ascii?Q?qv/9k08fvnrDeHbF6e472pJzj7bXpBbdSMlhbmzxIGtUreeyRhtYnP/SYxUt?=
 =?us-ascii?Q?11ZIlAgDg3Pmyk5tB+mckkhzOPZjm90NJkS9XkRpJ0h4EC4hLgkl92gtqYFA?=
 =?us-ascii?Q?e8NV/xhNt50WiDnBnq350YxWTdcJKBInsjZKxcAzx68ztnOcB2IMGTSyTze8?=
 =?us-ascii?Q?OiXQQrhry/4m6IcDkDxyg52SguX4vJ9AO0ykUBC0IoSQ9zaHeki8OcSGvlha?=
 =?us-ascii?Q?DGhVk1y8JIm9NZjdxeocJYor2FgzHQ3hbuDU+WD7Vk1N1d4lHB502qPhTa6q?=
 =?us-ascii?Q?Xm3hiAstOP+gG3xhZiQM0sOtChMHLD9G8juXYypHPfAXYCosLMKZmFG6o4nX?=
 =?us-ascii?Q?PGqelURRnCOVR4Q7qtnAFl5Mu6W6psNywgnmBr/rcah1Lxjo/WTi5twg0W4v?=
 =?us-ascii?Q?9FNEfDNAilrE7V03UUFoJfYxN6aVh8JROLNi5IgScxDA2yrPRRnVfy+Otdy0?=
 =?us-ascii?Q?f6n8iSVs/2vwyjAj10rMdC3tz+hqqncOOlB0Fz6e/kxLHNz8w9utPBSyQf+Z?=
 =?us-ascii?Q?aEgUl3hjslxrlRoqcD16ScZQSnS6YiarvaZtymrEN4xHLDP5xJiud9m7zFji?=
 =?us-ascii?Q?yj4VJ0aPkpmUwW4iDKmIbOvDGHAoacIHjaohVc3kHl1wbey4HDW3FvboxJ/+?=
 =?us-ascii?Q?o4kOirMFpNCIbCwWAImnfNfoavvw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnrsSCF2glusFzulZmzEE0PSjyVsSVFI3BT7QCryCqMqV+I65EYmEh4Z0qlh?=
 =?us-ascii?Q?udMkN0DuCE+YmUYP6CRWGZ5ZlB0ZxLmuuXyzSbWq0845eElPKcSpK417QK7h?=
 =?us-ascii?Q?B1rDbkSaLt6/5UXZw5F5noxFDZsAclEPb4A3QO9Zf3eqPwLoMSisydMgcbsW?=
 =?us-ascii?Q?a6I6VCdhe83lmMQgsbReSWYOzsusbnyMa7K+g6WyjGkVuxyy3WInK/5MU6tv?=
 =?us-ascii?Q?5B0ti9IWXkgX5BH+SpSTQUztcS7rTmM1z/N6+AqkpeTZMv5Qf9yMjYz2d3ym?=
 =?us-ascii?Q?8yBOBdjg1h5534GYVOZtazhWR39J4cca8NnFPp7JJqt3Xgdn/Gldz4rc5CMs?=
 =?us-ascii?Q?7IDQIPdvTf5WgHt32M2UUzp21FU82sSoWiZ6GBrcNyAXxy++83udV0ivF+ry?=
 =?us-ascii?Q?N6EA6b79MlWl8w0pi2YHbq2buY2o7ghHVaggE8j1XriJ8xBA/L7TOaX/y5v8?=
 =?us-ascii?Q?oMW/NjFgWIlDl9qdwEeB9hf6uM7arSaExkACXaUsiHpiQ9hg6O6YpYsmNaBE?=
 =?us-ascii?Q?n7w3jNcrYH5HdyPw/pPcshoroUwptiddyyJDuEnU1fBwEzsdCgmkmwPz7B//?=
 =?us-ascii?Q?GOSrlmBouq0GiP6tMB4ka80QNH5hmYmtbU0DCKeiaqt7etruIkxjxRwrDGXJ?=
 =?us-ascii?Q?A4xVLgC+T4+hSsb1A+Am+vlrjVwWe1ktDraKFLtQgf376OJUyUfRVTNDWYtV?=
 =?us-ascii?Q?oFhfnbvxyS9wm0cePh15qM3LBHRb59dLQkE4JGwwtBU3fziZaRjON50B0Gyc?=
 =?us-ascii?Q?HKUokdn1PkL+eFO4J7bCnHUghzWRuzGHRy2/sV4RQ3Y6uR2FNJsfsdwIXRkR?=
 =?us-ascii?Q?le5fDLPgP5Iwoe7fxyOiKvK37t6TBfNwxvoEssPXVWQ4VQmn6/8Y02n8glsd?=
 =?us-ascii?Q?FLoifpBZ+Biz/hoQFSGNwdmu41XkV5Zhs5fe/5jC+WpE/wmynfqGALgvLeoY?=
 =?us-ascii?Q?2PxdLQqxzHD8w9pfXbkFLdWwVhanG3Tav1FTxWLrBJoQXjqi420P5an/VGkM?=
 =?us-ascii?Q?Rgg9rEfWHAeAnvDH0NUyPluMdyVDS2nmL7TH1fGdkytuuLBNdrwmULX/pBq/?=
 =?us-ascii?Q?iz4xtIWKmZijcxCuzgN/Y5VlkKRgw8va4v0Xla0paTfqz94u55FX7j3+gfa7?=
 =?us-ascii?Q?FIUz7tUxse0+DOVtJ+BL7TiJARkaA+0L0K4MKlzQ92Ev8FNhgRqNbrcgUBD6?=
 =?us-ascii?Q?cUqJ4g8uSvOpkxEbuOe1bR3nI5Xx1rSxXmNolv6bV9UMWJ5nwbFg77QLXk8z?=
 =?us-ascii?Q?5AviWQ7CJgiFjg09E+gGlfsSBobfb2eCO3BxfgYwQ/nbZZVTzE++KTFl3oOV?=
 =?us-ascii?Q?PPWqx7qSi0MbtnhRAWufoh0w0Jp8G/HeNbv9zgE0gpBpnBBmsfdFpbDFbyJe?=
 =?us-ascii?Q?9FconzGDIHlKC6OZOxyilHalU+uFGkr4eLW/NjoHFM44m9jtnZa7gHgEdeMW?=
 =?us-ascii?Q?dES8ZSFaTslGCbF9k+gITf+/MTpG9Q2SzW87ZRHjtD4sp7mvP6Bdf2A4gQ/u?=
 =?us-ascii?Q?HFoVw2Kla8Y9MVdWQLsVjPR0T0lmyyGlPde0g6I4Vp2dFylTTJrL0QwH37k5?=
 =?us-ascii?Q?T21W/JuXRKBqs2oKcWJVpHcQA3WVMrId5C2gf3Vz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e045eaf-c860-4bb7-2f93-08dd50ea8b22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:37:24.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: katB1DWaPdQNH+YPHHhlA47PdjkXrbHXrg+5KtfciRwlDnsgGqZgBdL7wTgdELGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

On Sat, Feb 08, 2025 at 01:02:33AM -0800, Nicolin Chen wrote:
>   iommu: Turn iova_cookie to dma-iommu private pointer

I suggest you respin this with the updates and stop here at this
patch, it is enough to get the core infrastructure updated and does
not bring any uAPI changes. The remainder can be done after we get to
this merged.

Jason

