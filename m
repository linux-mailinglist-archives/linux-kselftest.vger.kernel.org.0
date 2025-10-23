Return-Path: <linux-kselftest+bounces-43895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9BAC027D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 436734E8A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FB314D1E;
	Thu, 23 Oct 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnM7Y+zY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0E41760;
	Thu, 23 Oct 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238100; cv=fail; b=MCkanYuIXAeZHJFx9ajjIgKJ8MlB+DVZkJ+BBozoGlHZZPMe+F3sq9s2bzPG6nQwp64xUmKkIaVxePQ+IFtu7Lqpx0g5UOU5B4bBhqyd+whPiVQSXofVEwuL7tw56+QkzqE2zRiOa/r1R6/RYOfPL6XS/7qoVhB9+RZVXL2Tx6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238100; c=relaxed/simple;
	bh=KbPjXG/jTvjyGbaO9cTNI2h5om9lZe+D6QlTcHeGNH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fN0uhHbbZPMqMzq5dCybWhoQ9QjmjtnHpNVePerMV126QpXDSWyNXNd7cUcYIbsq+DOKO0G31r2vYBuGIctkLczCMHgnSUG8JLYJCtlRV3rKBlZRZBNJCS/t3B+kS1/gjY2r3YR6XTpT014b5rUoP7ZYx3hgR2qF6/xw5Wmft7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnM7Y+zY; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVYZj+U1wX6hNc9WvIqvyjejnA2gp0XkxJdiL6uKh5YBDycC/dWPQgcdZikyyA7T/AQHLK4w86vEhMnNa104PQDA9Z4jBKse1G0tLwgG3A4PNTkcM5egI23iK2X08tvSUCCWxrUAFKJr3fSii25LpEaeceBpeqWtVc9DQsIpnp7FEbtzLjvVgCkdASfdLTo08bsz6CVgcG4WjWVi7wCkv/Yn+8y4iBhg4ZrDrCYFSUy5bcfnZW1QFZp2tZrZDaXeM4w+tdP+jBq4wteEOClSlk0gRthxuLn3juVgVnH7pgfkiQ0833+j5zouK8Dv09miAGjKTcCwFVlczZkRoVCMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVXRJeFAiBXgjf+UpAVocTyn3HXsyriC68L9GMC3ANg=;
 b=iswfYpfI3Ji8I8FetlslUkQf+VlQulDZpBtijVW+1/2qXlV38P8CKsjxxnu0A/USXPuqCtOIQdrpwAFpR0kGR4JVKMPfUWX153Lx3JVWFZMu/JnATXOxKjzlUVRKaFFGHBC4w4Jv8ttmrChaR9Mp8UUE3q28RE/u95qZ43uaqx/Rixq/XuAL+shJzUvjBXxEGchcySfBUwFsWfg9sl8/z1mAJTKaZbaCyq2JcZ2/KrizrcVJSgQEcUi6SjYTN4EtBUzCn6tDfFLDhL0pTG2bIkpSVpH5QIJ2Flw3G38DZ1lZSjMaD2Kcb0WIkG6D/g/S5/n415+YfBd9990Q3zXYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVXRJeFAiBXgjf+UpAVocTyn3HXsyriC68L9GMC3ANg=;
 b=nnM7Y+zYTKnYT5jxkj+ZM27NqeSncUI73cboB3WhcVA34XLbSbvqvXfc3L6nMxG19pW2PqzPVjWvI/KPJDLcmseHQv/3pDwYzRI0ve34I2lGnvWZjJ5W+AuzOcNHuIutpb8dD9xdk7bTjFB3S/DzHoKVmnGAG4a4WRrE4HtFeMmy0UuC3qc3yP06ptnlob2jsthTDZohgO2p3x3Vr1KdKovCIbrcU1XbWHuBzI+4aX/pmyNTUi4Coqj367WfzsF3s9YcfyIEX1GS9PnmWv4lC6bm/9O3fSHrEqA2TQky1IvQylW/SbTTcoosZccpiLHkjdsSz1ipozhHBR8H1c4LzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:48:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:48:12 +0000
Date: Thu, 23 Oct 2025 13:48:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
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
Message-ID: <20251023164809.GN262900@nvidia.com>
References: <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251023155746.GL262900@nvidia.com>
 <DDPU75QB8MQ6.3HZ5N0GYKQ9QU@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDPU75QB8MQ6.3HZ5N0GYKQ9QU@kernel.org>
X-ClientProxiedBy: BY5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c3450-11d0-46f9-f9d9-08de1253f428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJS8sgqDPthEL1J3rYeWh70IfRUoNYY5y5qF9LOhou3NS4COaHsaNElA+VXk?=
 =?us-ascii?Q?cuzaYHiLRUrfRgACllGrPVW//QMbnWobjP8zBX0JPA7Nu6oAIOkws7MwCn47?=
 =?us-ascii?Q?Jb2DCAWfL4kPe6dnwBW/IT0TeMNtjWA6rQvSSb+OMJhuz0kOzbNiv8atL2cn?=
 =?us-ascii?Q?8qzUiaxN7120jt62G6EvOormTuFyBOtzlrq26keV31Vf8CB9+Sh5WNg0j6eG?=
 =?us-ascii?Q?rvQnvWhkr3gtkN/4K7DwGz+PXpaUXo+BL1I12uy1YkvyUiOdl6ni7BJCdlqK?=
 =?us-ascii?Q?zO7UCKuuUtUe8YrFtqcMniZ5km9KoZSv3XKRN3Ee8uuBRdNEYzlG0cSPLPhK?=
 =?us-ascii?Q?4/1aHyRvb8gR5dHG6nki5RrsSzyuR9iPstP0VSiz8J0qfBN9jE2zTNnOlxM1?=
 =?us-ascii?Q?qio5lZRlZigWKMbw+g1kc8fxc2D510U+inh/SQDECahWneUUBXKsa38JQswX?=
 =?us-ascii?Q?z87fq9RndCxsq0Vl1ip+GwFB27wjIHqljp+m43V3L6YxuWF+dmuZdfD1tXxJ?=
 =?us-ascii?Q?knbwZ1ERn9ZcZXD848glYtClTgfB7sSoC5rjo7B/j4mL+utoD5uHWHoNtN94?=
 =?us-ascii?Q?vBymLhhPoDfPIKFWQ73hINfSV8SwW82VkzUctL0VirNM2XVqPik3vZvoVPRz?=
 =?us-ascii?Q?zZKL7RV1QN3a47h2gccv/pMbrv0S3uxRYNiH8iFbNxK72tcGjVPB5zpFop5s?=
 =?us-ascii?Q?kXKCiJYc2o0GLWv9lD46xbKq3gcyA8bYWwQu9iku/UqU56/pMDgitUGmtAGb?=
 =?us-ascii?Q?qerLP7ZBMmDVi+KR+uJYoFsljzPF9/vfyTqXdshrOKbfuHe5/hc4R4U1whaQ?=
 =?us-ascii?Q?Hxn9EsanncP0wnE6dk9XgUKC5WoHNBbjDKEOIvri/I/byDaIX0b+TKDKXEGP?=
 =?us-ascii?Q?AUimKninuiG3/jQPyBm3UR22z5PpXctvh+nAuFu/+420Xpazb9lAtt6OddIJ?=
 =?us-ascii?Q?1qQJpZhOa+uNdKZ7ywJpAduo8dbsQbOJ49ARqnOvm8jxIn0iXx6p4JWyriLL?=
 =?us-ascii?Q?kMeIizUbRjxiBbx/UdS8Ep8xrhg7IPLDnGMSqfaD9A5I53nXGCxFjmGm8zQk?=
 =?us-ascii?Q?f8fGxmGHlrhxwsZ69LC/CyeRePct+vgIQUzfYILGw8TY0XF1xRDvkv2Ho4Tq?=
 =?us-ascii?Q?luqIeh3q7rbV1bI8WPh9WroyBFbWNn09YKW1SwTSXic6KPBddACfvTjqstM4?=
 =?us-ascii?Q?fcvnA9DwnVX2EjXxfAsA7g64vBoJy5kltfW7zx+dUiPkt33SgActgEGY6gEP?=
 =?us-ascii?Q?+zHn0bFUExu7wm1P9ehTNKl8Ljb+ydwx7QWrY4GBJ6ppjbNDkaw8SslQrt8e?=
 =?us-ascii?Q?JLuP1oeRq2hUYyf7wJnD/0BBsuA++TJ+6wndPTA49Yy8NLLEn/kxVd6pt1Gn?=
 =?us-ascii?Q?Ipu/EOecjjjZHsv/K9lnExJvVad04A11Qe8BS3zlNRjAv8GnFIJr4L9Shd6a?=
 =?us-ascii?Q?KjY12X4R+CzqLWE8asLQwelX8x9NTI7B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGFPsv+Q4Jnlz/ZNpo2kyEfD5/uUyZJRZR2JjPwP1Q/7en7jyZqvx72cTDP0?=
 =?us-ascii?Q?M5+0w/XLmwocU29oOOAEnB3+unUoSbf+86FSvak45NgpTtkGP487UPtVUzpM?=
 =?us-ascii?Q?vNjdb6NcJBAZJJdxOfxGjK87BuZhwZRZzUpghDTqd+O+mQr7tA72fEtpqZq0?=
 =?us-ascii?Q?nkLvdqrI6hpLdfDw98sdHMRXOdch/MMPHETlgoGZ8LO78vc2I/S6wSvGM1ur?=
 =?us-ascii?Q?RayHos/H65HJpG0mXTuTzXwQwq0piaat6TCsl83RjC8dSoCcShsMkurzsste?=
 =?us-ascii?Q?D6ch8L9rOYO17STtP95QIci5xECpK4xkuFvSB7wAezIBdzvXLrkiiWKLU7aV?=
 =?us-ascii?Q?Y8JQjWBKWqX5lEAukfiopqPdwQFXTiPbVV3hqvSQYAMyLLt6Qy7vOyAhhfZE?=
 =?us-ascii?Q?1uGAkyPqKJiB3uCaizqlox2gnK4h4GQzyiZyHVQRixtmmuhblMCGIv8+dxO9?=
 =?us-ascii?Q?6hEoZRmEM3x95X/wuHzSC3mcXDQ6ASnwBaMSo7lWTYs6ggyQRn2ZPAWSe9+w?=
 =?us-ascii?Q?NVrKeJtfsPrueTp5+Bl4Jw4TcTq+nTNUDPBXBomG9YhpcKoZ1hYgpr55wmF1?=
 =?us-ascii?Q?OlrVyIwye66tfqJ8F82/cOsWqZvvT/ralX3J5n4SXL8EJR2rQRG8AqNDEAYh?=
 =?us-ascii?Q?spZZHI7Lzo2Tzg9hs0/d0C8aIV4QJ2eNU9+m18nCMfUTJToUeB66jPqTAz8P?=
 =?us-ascii?Q?qxkhcLslHCsMDhaZeBX6Om5Qcr4d3YtQNJVEZnORXAl32zUCZmshu65Y4wyY?=
 =?us-ascii?Q?ci9AatatcwcmH/DLEIcONG68iqpTK5TgnAYfhYw5WRaVDl53XvAb1rwpNZAj?=
 =?us-ascii?Q?X77IvG+gVpwEuMOTJitL2nWS5QkXfWzmE4GAXk9zjuB0Of3Nf39mtOsVa4Db?=
 =?us-ascii?Q?hrzwOJpeOnYsO0sdIGXrItqlFQEEwj4UkiSC8Sv6fcXYsnzCQk2CEk0S/NZ3?=
 =?us-ascii?Q?NEWHKcgJZbKRhtY3DgYCM0YIQoar8Jjd9zZRGN59ChcRRhKOLx/YUcT/IM2I?=
 =?us-ascii?Q?7HfD19x+Mkj+7fufapZWW+f07BrxTwCus5VhCJ+yP8mpphJFFAwIlyXjmMmE?=
 =?us-ascii?Q?xZbHrdBA4Jio/0xhT/d7uKeVpFRqz6Hx7zGiG7dG+betvKck6c0UI+c/TS94?=
 =?us-ascii?Q?Pxl+F/KWP/1cPZztLPp2ZHnAe+2Ngs/+fM29wWfXsl0iMurgIceU0n9rV/Fw?=
 =?us-ascii?Q?nTH7PLgikqBEdeCB9OhfkqJhoAN5xGZKT3jMSgGrjm+qL2NjxbmPx+NOSGAI?=
 =?us-ascii?Q?bQxlUZO0I1rruO4p3Qmy0bISXv4lSM807BiigkWm/s4qgVgcLrtnUQhuuId1?=
 =?us-ascii?Q?Cdmnn5n7N/3Dodh6s6Q1k50bQH4cxR+OsnFv4/t8tq1xXPzTmDF2yCdxpkK/?=
 =?us-ascii?Q?/ijJr3Xj4trEkwk2FwLGvc6zMYpFvT09WkBvqzThwcJOEJqzl+m7rY1K5y4l?=
 =?us-ascii?Q?VPvHv5J3P7518olLWpntR4qGN22XwWtQ8rXIVVRF1slCVXvksjkRIcZxyX6l?=
 =?us-ascii?Q?5Lr56IUIKZOGYXql0lOwY47u2U2J8T5UValTLxGtktcceshHucIj7A7Phczh?=
 =?us-ascii?Q?G7B14N59fVvPbjX1gnUYmo8DHnRQNGd+Dm+Ifqda?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c3450-11d0-46f9-f9d9-08de1253f428
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:48:12.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdHoGSqIhDugufs28QFER+LPD169We0eeKJoVwWEsqajHc4j1S63rUcmMKfbYXhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

On Thu, Oct 23, 2025 at 06:20:02PM +0200, Danilo Krummrich wrote:
> On Thu Oct 23, 2025 at 5:57 PM CEST, Jason Gunthorpe wrote:
> > IMHO the rust code does it principally because the sync unregister
> > life cycle model does not fit naturally into rust.
> 
> That's not the case.
> 
> In fact, we try to give as much "sync" guarantees as possible. For instance,
> when a driver registers an IRQ the irq::Registration API enforces that the IRQ
> is unregistered before the registering device is unbound.
> 
> As a consequence, the IRQ callback can provide a &Device<Bound>, which acts as a
> "cookie" that proves that for this scope (IRQ callback) the device is guaranteed
> to be bound.
> 
> With this "cookie" we can then directly access device resources (such as I/O
> memory) that is within a Devres (and hence a Revocable) container directly,
> *without* any locking. I.e. we can safely bypass the Revocable and hence its
> overhead.

It is good news to hear it, but I think you are making the point I was
trying to make.

In rust if you have a Device<bound> and you skip the revocable
locking, I'd argue that you don't need "revocable" at all, just
enforcement of a Device<bound>.

IOW the presence of revocable in rust, with all the locking, is
because the sync life cycle model is not available.

Sounds like the idea is that the sync model will be widely available
and the revocable lock will rarely be used?

Jason

