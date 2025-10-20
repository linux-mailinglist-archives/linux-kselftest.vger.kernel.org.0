Return-Path: <linux-kselftest+bounces-43545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EABF0F5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 13:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912E74EC29F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B648304962;
	Mon, 20 Oct 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvy4f+fW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA724A047;
	Mon, 20 Oct 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961462; cv=fail; b=ivJUlCyqsQHvCpd2woqOuwhVQnRdIkgFe7NLAL7oZEzdKojGzDnoPjql7tOEz5Nu0Uv6XYNY/Zw5dW2viBQ4tWWfWEYIgS8J0SWd10AyVOEiJUnNt3jqduKiAxqESpWRu4IoBki9v3jCxN5D5oc+B62a3g3wGRBLcUSAwTvfUhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961462; c=relaxed/simple;
	bh=HQHpscoA/m6/P2SrAR4ulc5dlfwM8aKAosMiYtdQpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZfmEHPCBlVWyRQK7Rt+mcRXGeb+0H7vrUJ1ciFMbZTe+c48RameaJrXixSZNVo5jEQHBbD/YDRLW9sLEPI+uwOlseavA5dnyjNAEIrEZXrKOlx2A9VXXKHrCOG/nv7rM5RJl1avbiIo1JZ+ZM5OfITDIeEEZ9Nag61nNt8u6Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvy4f+fW; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpnYFHVKxrywbFDduP7rR13mOjSyBMMFHdEWkEE/ru+9kknoDC38Vdx28MCMW2EtsaG88IoiCjZxBPx06DokoYlSH+AvyXYld1eq86Dz6dar028PouZaBcgb/ohqAxnXt8nfaQ4gRmeuzWISAjQ1shWWWCGtVBdgzvzaB8nIwJi+v9rcWTIVpgZgBT30GrSqNkUZSxa8qYzhrEqopqLE9D17v96ykSZFShricpctKFwjmKCXRqxTi3IFvAQ157bk7+HRPVBkJ9iWngJUV/MREBk9z+BJTpzKgGCYOHmRCiayzDV0FPIPOCgamWUUq2y2DNRVsb8/9VdsadhPknpl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foTPVV0lKp7sjSLImcSdySw0rmx0Pj3j75CDP0jdN98=;
 b=L2JdAfn5blotlAai4eG4UABieAWgfXm9Axl5vj7z0Vj38kkURIEiWAZ0UJzJm88OMn/SSSv9IQGxmlJ/KVwHyKTMRVRnPqPp4R07xR/B1Gr0IFwCWpqlv9l8m1QXkjXMTsughtLzieTZka9+0J9q08BSTWAvqHj6xbSx5uoND8kYSSIXxK7Z0MmEV6yD3wR74zjlL3REiFh9sr0l2/XBfo6Rb1bJyxqwgeUGm4w5yHl+t4n5ezQPXrjJojiJrXsS3J2A4pPwuoaQvYdSSSlDksGX5bVr3NDCKxRqnVNNZYn6dpALS5Ye3HONwCsql2cMWDlE7UEXfzXTSnWgTysBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foTPVV0lKp7sjSLImcSdySw0rmx0Pj3j75CDP0jdN98=;
 b=lvy4f+fWiz8COX85w5q6JEkIfQq0kbJXI6T9LsTHN7gxrSxfZNT2bfqkLQxjLIBfY7y5+3UmmkkaK5VmX+UDqKx5ublFAhLljvmM3lwqmHHTx86zIQJmQP445wyA8sFe+xeM48yWou57a+ci4d/cG6vOncOeMOZJG4IYDIk1Z5Rhb3tHKQm4EO9Zat+XtG4H9g+LfpI28sfcUHOqMh7+Mq+N1ZUgD+i29nG9zvS+MpJNQRv4kZEvpX1OpVNWlCJO39CDzTEII5vtuI9OZ7XREs4suNwz/zzT/4mSPl75La/M8okBOdvxZQK9cUR8JRjJppbrY6RzzzuISYtano6l8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 11:57:37 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 11:57:37 +0000
Date: Mon, 20 Oct 2025 08:57:34 -0300
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
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251020115734.GH316284@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPT-7TTgW_Xop99j@tzungbi-laptop>
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f4c373-2125-41dd-59a1-08de0fcfdc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ShT9cUNsqAtIujHfkcyOd/8hHZqZNgmAsbOIUSCU2oKSunrTe7T0QHKYqoJL?=
 =?us-ascii?Q?aQDrHQOkoB9B3Yz6KsRaIv72fYQg/Nk56GXUzvTNwSR8xRF0IaI+dA2StNQb?=
 =?us-ascii?Q?qPzfyzmg8idS+S/jXIvG63Nqba+pO6I6fcuGt9xRbGnYtBoe7XuGm1IpUujc?=
 =?us-ascii?Q?lHKtn7jVrc3SqNQEYEfQk5+oY+yTCdoi+asW5uEXk01VMcZ9YBrcsgSCnZVo?=
 =?us-ascii?Q?ItzqgtpxL+YJr/J0NihK7j68jR6WTF2r9zOugSamXnjZp1jETTSvIQ8SorXA?=
 =?us-ascii?Q?jNVQHObYJgFiXNBvaIoyU8jVryefcbKVKQN+KoGr9nN3eI5QN5CGn4bU06cg?=
 =?us-ascii?Q?N9F7x9uf6PRUx4PAgv4eCP3/j0d2uCtps9GXuXOZF/G7xpb/MdUIRdtMZ19t?=
 =?us-ascii?Q?jxSbUz6M/Xc/vGs0oqkwRT0dp+wMB/runZFXAnVYv60dvtiTllXCtAv88HPj?=
 =?us-ascii?Q?L5x3dw45dUv7Ejt7jQlpNg/mKkRAhM1D1+gX9bFot7o29oxtghZEAMmBkpLl?=
 =?us-ascii?Q?g8SDtm11k93EWT1tIIXJvsSnDC1Wd6LlZcxD2NRz6p98Z0ICzSwPEJwTZ6rw?=
 =?us-ascii?Q?cm54hRciFpdF8YVWxG7Er2Cv9AYJVnyk+mpOaVdUhpKaZ2VRqPbIeFWeg0rP?=
 =?us-ascii?Q?kkUm8OAtqP4utFrztjMcZIsfxlEvwdAhgnV48tXFBpK++rfOp34NwCpmQFH1?=
 =?us-ascii?Q?0QC9uB75Kil1co8mS+qrnwWyzgwfi5q/zeowTUpzl3FY2+bhQoWPNbM8iVWW?=
 =?us-ascii?Q?dtibtnf5JisJFR9sEJOgVHSZ6PEr/tSyfPRPDfOHzbrZjppggNUjvGxTYSXG?=
 =?us-ascii?Q?JDeXVjvwzj95w6SLIUTzMoIpWb/EyQER2tp9Qav5VqorgAWNQjatldIQ9Cfw?=
 =?us-ascii?Q?K6B468xnPX0yU3I+8IFzIXa9SWQ5GTJY/KGV8JIULUj20F0meUZKuXwdyTkq?=
 =?us-ascii?Q?s4bx5J1LL15CbY/IB7GvtYuRV5ZJaZqNKcqODSzoywqnO7ofrM/jxD4geVDB?=
 =?us-ascii?Q?XU9/ZLQf9U5ZZt5FbggOplym/6C+vkK9F9zbssVGxHQZbmXxfiP8zWmN5h/w?=
 =?us-ascii?Q?dB2hoxnZK2+sXi9AseF7qmz2Bz9sk0qcO/QeudbDlshuAS4GR8MSMD+d3WAQ?=
 =?us-ascii?Q?6iSfcwqxw3ULoKYV6cS93Tpocbn8vyq98o/gcAKyHlOjDtUJ+3taZ4yOlPmC?=
 =?us-ascii?Q?xZRmQRJMntKqqtRKz0zq4BMkArriwjo4FFvg0BCDSrtseKctj9NIwRonaGsv?=
 =?us-ascii?Q?zIRX3VztdXEEsDvQ2AxEogfI5XGUY0SWAN9ntAx4Mc4re/YlzAwyoUt1sl9d?=
 =?us-ascii?Q?TEIgVnH2oslg3jQ3gJHns3xuAYHNEjtb0ST+DWm61FSrduJH19LCO+/vx3YI?=
 =?us-ascii?Q?FgmvaLfbxxm8aeiZ7qkwQ4Ub+wGZw+TWdFaZM3FGEEO0KIvJFUs0YUfMIdE5?=
 =?us-ascii?Q?6UU0XMnCnM6c73/wmpSkG8gNCXsaipOO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJF15OyFC9rMipncFWN9nHYCvAO7admBamIV+LD9i7rxuEbmcGFPgTmhBwml?=
 =?us-ascii?Q?8pQv5AsMT1KQaXnO+SE4JRRt4aadaE0Z5ij0yWEU58ST40LswyCpi92Tq0Ls?=
 =?us-ascii?Q?YwiyZmZhz3f6ryOz51iH4NVF9Dn/U9zyVP74bRifhfaz0FaNqUWOwXakK5z8?=
 =?us-ascii?Q?+D7o1mW5aT0IXqy7Wxig4OQd5wG8HoHECHT7VKpmAITYIXaLao94ZJ7eZOtM?=
 =?us-ascii?Q?1mK4lZY3BzDl80HNq4wBxq7b6CQbuKvvip2hqVCkbrbgEvHFzJxfXfrUvkGy?=
 =?us-ascii?Q?bDsZs65y3/xTaU1BPS8RgyvdgpgFYKZDi684o7B/aOLSP1fZGBETOTxfhH1s?=
 =?us-ascii?Q?55Ry1w3JA35Je5jez9R+SxD5I4fXIJQ0pRB8YvdcNtp2diKLZGJ3Uk6cKJD5?=
 =?us-ascii?Q?MHTHGchbJRf1JAMlsLY4443DOxTDX7mVek5TkaYAYvCVhEeZ36JkQ2m3kkN7?=
 =?us-ascii?Q?zvFd1Wk/Dt5pA+CHpWdSgKwAW3JhXJoS+L7BZ1qkBlSBPreH9mjLgC5JdOio?=
 =?us-ascii?Q?Z4qddNGbyDxncGhPm5Dq4upHRTmprpEYx6/lgY0HBS0Ab+0Qkce/q0hxqJAR?=
 =?us-ascii?Q?8Rt3GKrD1EcxxhXlD59k0WaelbpqpvBZqKi4DJOj++XsOf5Do0B0f9mAu583?=
 =?us-ascii?Q?KNUCDlRD6do2wQWpGPmemV6ZJHwPXG9n/IVJMXwTMyB8K55Ebg7GrFe+89UM?=
 =?us-ascii?Q?1Y2Kuns4L+irKEPWzxcaukLGoaXWrxfm4xExq2TkrDqPIIr2j2E7wzbsOgq/?=
 =?us-ascii?Q?f3ORn/eqaoRKrCFiHs44Pp32g2jUV0hoGe6ryCG0wNFxTJI39Sd/fy2q+qjX?=
 =?us-ascii?Q?dGUv5eG6q+0+bphLMa8LNkH1mpcp0woQgh9GZkB9YehusHpnFwePCsA6Eiiv?=
 =?us-ascii?Q?1sjGoZ4vssrJvCKPg5TAchfhbYMVGLpkH5fj1yO1OM9GoSxt7tl4q43b8mVg?=
 =?us-ascii?Q?W2LI8j+L9jGkdhLKvSgd5lemgIfyAAkKgsgH7QsSyY+D6furlo/zLQMWOGbV?=
 =?us-ascii?Q?36smT6K/FsOtTFEVGUii9VKpMY9CrRKJvnUlqwxgp21a8/JeJ95VO7N1BSOu?=
 =?us-ascii?Q?nliqoKBtdBMbIqXDSBw5nzo9lmc6Lr6DKo3eIGQqeFe3LqNqxIu6/977WWKA?=
 =?us-ascii?Q?zovuD4Dt/H9hJNGaPGcioBXKwvWp4jLrnC8VeHkQ4mxlPGwArHLwczMyHenF?=
 =?us-ascii?Q?sOzbi8Qx+n1GY0jRlX5QGnb0r2eSmRWar1eYR2RmAvAT4JVUy79hVMybDTcM?=
 =?us-ascii?Q?3ixqyKmOTvzky1to2e4NAWXAxK44NfJIYUCCH4Zo07BaZu/j84HG8VsKbWyx?=
 =?us-ascii?Q?R4mjqbnXH0zwnAdud47rLVuBxW4MSDD+cMUf8BDRM9RVk3ekaNvbpu27qi5w?=
 =?us-ascii?Q?dGxDyiisuVxKN85c4O3Pxm1/LVL9+5ccZfhldD2XRk9g+f0SvmbJdrLLBDUh?=
 =?us-ascii?Q?0M+1f1qcJpk6KUQc0j2DPwpePC6rx9uOWaEEQaplT3CwZEla/fP3NYCwP9s/?=
 =?us-ascii?Q?0Hx2Mh3yI3s0Z/8hHrUFhpb6HPp1CyUODJMHKjxhJBT+5mSeSkTYW8yuzMBx?=
 =?us-ascii?Q?f9/PkXqWcW0ETbSJV3cbuwstM0jV3VNOBd2ktFB0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f4c373-2125-41dd-59a1-08de0fcfdc73
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 11:57:37.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ND+5fy7VZooPnq9fzbWonbChdOv40x0C5hXT0MqIHpXiQTsnCF7z9TGWmBpWPb4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Sun, Oct 19, 2025 at 11:08:29PM +0800, Tzung-Bi Shih wrote:
> On Fri, Oct 17, 2025 at 01:21:16PM -0300, Jason Gunthorpe wrote:
> > On Sat, Oct 18, 2025 at 12:07:58AM +0800, Tzung-Bi Shih wrote:
> > > > This is already properly lifetime controlled!
> > > > 
> > > > It *HAS* to be, and even your patches are assuming it by blindly
> > > > reaching into the parent's memory!
> > > > 
> > > > +	misc->rps[0] = ec->ec_dev->revocable_provider;
> > > > 
> > > > If the parent driver has been racily unbound at this point the
> > > > ec->ec_dev is already a UAF!
> > > 
> > > Not really, it uses the fact that the caller is from probe().  I think the
> > > driver can't be unbound when it is still in probe().
> > 
> > Right, but that's my point you are already relying on driver binding
> > lifetime rules to make your access valid. You should continue to rely
> > on that and fix the lack of synchronous remove to fix the bug.
> 
> I think what you're looking for is something similar to the following
> patches.
> 
> - Instead of having a real resource to protect with revocable, use the
>   subsystem device itself as a virtual resource.  Revoke the virtual
>   resource when unregistering the device from the subsystem.
> 
> - Exit earlier if the virtual resource is NULL (i.e. the subsystem device
>   has been unregistered) in the file operation wrappers.

Sure
 
> By doing so, we don't need to provide a misc_deregister_sync() which could
> probably maintain a list of opening files in miscdevice and handle with all
> opening files when unregistering.  

I don't think we want to change the default behavior of
misc_deregister.. Maybe if it was a mutex not srcu it would be OK, but
srcu you are looking at delaying driver removal by seconds
potentially.

> @@ -234,6 +240,10 @@ int misc_register(struct miscdevice *misc)
>                 return -EINVAL;
>         }
>  
> +       misc->rp = revocable_provider_alloc(misc);
> +       if (!misc->rp)
> +               return -ENOMEM;

Just get rid of all this revocable stuff, all this needs is a scru or
a mutex, none of this obfuscation around a simple lock is helpful in
core kernel code.

> @@ -1066,6 +1066,7 @@ struct file {
>                 freeptr_t               f_freeptr;
>         };
>         /* --- cacheline 3 boundary (192 bytes) --- */
> +       struct fs_revocable_replacement *f_rr;
>  } __randomize_layout

The thing that will likely attract objections is this. It is probably
a good idea to try to remove it.

For simple misc users the inode->i_cdev will always be valid and you
can reach the struct misc_dev/cdev from there in all the calls.

More complex cdev users replace the inode so that wouldn't work
universally but it is good enough to get started at least.

Jason

