Return-Path: <linux-kselftest+bounces-20666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D99B03D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037981C2158A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16A212175;
	Fri, 25 Oct 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUb8VNOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C175212170;
	Fri, 25 Oct 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862466; cv=fail; b=o/ciuR2n/6wi83m8WJUCv0b7036KNjGo/veI+SMydzuB+uAenCjn/AL52pis1xpFTI/QzeLih4osP2rsmdbmGfk9ktTjJdlqFolQXZe3uubB2e6/US3VBSbwjkv6YTP4+zTZa3W4G/361WdUWfYY2wI1N5d+JSnh+388Ag+x0TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862466; c=relaxed/simple;
	bh=PaFajTAOxRo+IN+3W2S7Jar1rmDBE0dnSQGJXlatuww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rip9+3A1q8G01auw2/wt3m7We1vKQUoXhIr2yEoRXd27vV2eUAHjO+WcBiOIlCbMX6mcHBidTbsqO4dSfknCqG1+//KpITM0UX467I8SLVNkyNXbQlkBqH8zb9I5OKYLNOCmaYSpr4Q4q+hGOwFBWIztfVNYIJbzw9mKG3bfQuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUb8VNOl; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9kOeFLWVZJOqsRe1ZbzxdiqRhrZtno0Q0s/Wx3eOmrGsrpQlNmGFw2vRgqbmUsXSLA8WpuM1EB6iFv12Bet7urC4a10Wq69YIScCg0IAQaf7aF6sP+3gWp/Wm4XulKeWMjuakR1AABwav3hbV7Zci1B0ikFrW4hGPw1W+JTtS8AKxY3XH9qbDesw5S8yschV2EJhGyosYAb6ktdy6XKF3ugIeQr4FoGhu+mfmjNkOzbxA2xa8zoimIaIyc088AvSPWuS5ZlpTC93eNSi8W65d6AijpFSIvGsINjXxVha2hrQXkk42AviwWb6oJZOVOBthXFG4SSj35lpv6UwqeQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiOjV3UDoXTNZlpbwNibDRK/+GfCJSZGMJeoSXROglg=;
 b=zLZNRF0mRofguByNyxixBlJPWqTX9MyLpBOVwHur0ggcUgOP0iroBoF+tbex85mcl3J6FRbnPDSCZbD+sDMetfPqHy0K0z5KKoLzXwzyZQlCr2Zs6AHg5YPPpz1xDd+3xjtcFhTXA9mSkeHWjtnh+CY+4+SDCeXaVNbGuAlrXZfjxWt0WrSJML3kS8WKkj8vMyooP0Rl7ReWXJt6HkxIccRH1lsIbSkZOZ+X7ZQx8VaNBKHH6EVaeSD5nEjs526oY1Y30dmawRHpdpaplJ2NJ2mYF2ImgdkAW/V1XDwnaBQqL68iB8jWRiKugfWF2ZllxEvKXNOYqp3iqhP6/gHwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiOjV3UDoXTNZlpbwNibDRK/+GfCJSZGMJeoSXROglg=;
 b=QUb8VNOl/kxKFMEOceA2HJqw8Eno3fROesQcTNf0T9C7/0So5UhFYXxjkcWGnrhAC6N37wftbqNiBgA2Pc9TrBxfFdv/CgdEAW2u7f1rE/DNJySJYVKWM63IMLNVA3irXKR8wiQrdaXlE70iIP41xbVW0wUbYPB9+bO4Q3jvzNnpL7tCkqWjlFS2y3yfh8R1ynRAX5ZAw7y5PU0EEOGsYrYN69WjR7UOMzod0gJ8FpNhk/vEFn+qX9nUSW2fAu4GaJC5Uxmw0OLGpcq9l7qb6MCLlANwv1EiDG7LHHdZPQDt4g9b+kR17KxSitU+1GSrUKZGUv2IzJtzt5VTj+1NiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 13:20:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:20:55 +0000
Date: Fri, 25 Oct 2024 10:20:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 01/14] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <20241025132054.GE6956@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <ec230c740b649bba1ca4d2ef054d90c79be4be28.1729555967.git.nicolinc@nvidia.com>
 <11dfc0b3-9e45-4f9b-a029-714105fda9c1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11dfc0b3-9e45-4f9b-a029-714105fda9c1@amd.com>
X-ClientProxiedBy: BN1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:408:e2::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db73b04-f418-4216-1a16-08dcf4f7db57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gq0gustqufuwnB4cK4cxpWpFLunfigvxrc10SHG6fWwxHNYDbX0vZ+bG4R/?=
 =?us-ascii?Q?NoVJ22Yv/keJQJ+tZZgTOvKB5YljcFUtIXE+GwLsaL3DxBv39NX52ugq2pn3?=
 =?us-ascii?Q?YWe0XJBMr3cVTgb6QOASJSaezHL8bs1RkkB+ZpUHlfkS/DahVrrHlQP25jEq?=
 =?us-ascii?Q?ysfnASoSIppKB+OX/eum+efptOA21DGuRNURoeePrtFPcvPyVefnkNmqTXkt?=
 =?us-ascii?Q?dxn4sbVkpTtn48g8mToymgQ6CnYc1WxsiWnme9rTiJ8AHG0ks5B64Pi1DLtK?=
 =?us-ascii?Q?cUO0utw8Asu4xvpPnfr+pCz9sLYsQ2ZjLtFdc9y2kL09XkZjFmNc+h6yN9Td?=
 =?us-ascii?Q?5ZDZyooGsPMILxFnnjBBzmuemmOcpn29ZAZJV8fEf1n9iqo6IUT7lUi8oElU?=
 =?us-ascii?Q?l/nl58E4se/MkWHcKrrz+fTpiXh5rII1Yu+ljDUM1JNvbAv3ARFPub19eKqZ?=
 =?us-ascii?Q?lAb9Up4PFzy4sHI05WiE6MeKmr4bcE68FmiqQ2eQjVqI8gMhRtVtSkiMOp+e?=
 =?us-ascii?Q?0x8sFq+1aPPsdXsDEKtkl9cWgj1cOqjp5MwL55xPluwDK/z6A0AxERyZ8MIB?=
 =?us-ascii?Q?W9aeT37N5E7WlyBVqDvMeSBo95rWFXbv/iL44RkSTRBWd9ZsczqI1S1Hf1qX?=
 =?us-ascii?Q?11pI996HtMHvHwTMeQTbIxRa7Ys+4/Uc5q4shADxbWPJxF1EjujXO+TJFR51?=
 =?us-ascii?Q?Ezgksi6P6Gtr835QOzQ3JCOwNEg1f/fQhUNZZpDq+DiWSBngQ0+K8umU6/Mw?=
 =?us-ascii?Q?igsyGN7QVBPHVmkjhuZS7zvU60l+vXSuJfRJDoWolHgYKch63g06DzCh8VeB?=
 =?us-ascii?Q?adL4FFC4jIAhqM+4L3JhHhl36umf4i7UqNhxr8QvWcRFDla5dE1ALNtge6T0?=
 =?us-ascii?Q?/sM/Je6TACnIJX1RiTFDAOL5zT+OxEnX7e0Ey6kBSvBCDeH9RjUw8GK2Mvhn?=
 =?us-ascii?Q?S4nIlRSSM5hulxo+ttwvkUI/L4vSrXuxGqMcPLQ3icCNIQL0G+CQrvFVKK7r?=
 =?us-ascii?Q?moyKkHPiGGijUM3fM+ZatjiRxYXoj4e39nu8y17ZTsy4pcW9KD2WUBdu1vaa?=
 =?us-ascii?Q?il8Lr70kuU/msXtsKxXJiOUfeGDW3ey2UZ6e++hP8JJir0hQx38eWWwUlvRC?=
 =?us-ascii?Q?BOoY5T8GKhwCy80UP0PpWQgkjiiChQKRQ8E/NMGOF7nIz0dtiRrsQtJHEp5I?=
 =?us-ascii?Q?wOmSIqK7a8e64ytkBoL4qr/K43Clzo45GRkUHAl4zhRuQLvWi8RLEG2U1p7S?=
 =?us-ascii?Q?lIMoW6dhmXizTpWBYTbel8uRkPTduZ1NhAFAnoN5n9w97mLKXYnwfnn0f0U1?=
 =?us-ascii?Q?tdI3ovb/51t36sphOH0Z+1ph?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDSlpS/tU5rCeeMBBcye7t3mmUHVR03KU8AXe8qNhFmd5kfopfEL2KPXT15x?=
 =?us-ascii?Q?Yj0InW1XBHb3KLeKgEtCU4aPC01p63H922xj+YYBnj/40MO6R4e/8qbj3ohD?=
 =?us-ascii?Q?C92d6J8IzPJzvI7tgn2PEqPw2sq6cs7BfepftHCK7QP+gZgeu3mvhKdpA7Zu?=
 =?us-ascii?Q?8D2bIbumNVzYAecj9mDyx3FGkqY5iP7iVg2aiGA2E5ynuTNCynKgRzdqsp2E?=
 =?us-ascii?Q?c6Tfb50EjncsQ0FZctxK+PaZQoUGoKV7HbYGhFY8DrYSNnQyEMyt6bMaEpoI?=
 =?us-ascii?Q?wjzVHMLkCb1zrk52ikqWTjHdKTn1cIAAsw4peAKTcGrEBuXDYcPaJKzB0ifQ?=
 =?us-ascii?Q?CAn4PGYhDtLGa2UySHI8EFloYn3Wdx67ya5Ieg+qKjrnOhsTE01sM7w/iL1a?=
 =?us-ascii?Q?6DVJIZJUECGgQg70AO1POb2r5DrnJHYt5yz5Fa4/NugidbQhS9v9Yy6AEIMX?=
 =?us-ascii?Q?J80QBy9n/aVpE5P4JXq+GxGKU0Bise1LznZgE/aK2QUGHK4vMRlevfWMxlGy?=
 =?us-ascii?Q?NQMGhZBolI5kYguFG0s3R359IO7r1LqsFMmjoQx1jP/5SQnnh12TUD6tRRW0?=
 =?us-ascii?Q?l1lZ9/GD+nMq5BXzO8A1BW5L/F2kCThkJeWF/WYBeG/VtCQdQqHH/VEniTXb?=
 =?us-ascii?Q?S1YnXxyefF4lvmbPkRp0ycmfFzX3fD4VjsUUv0+8nVJ4yp3ptm21+Wa6rDF/?=
 =?us-ascii?Q?h2TBzwx/YUFvPU4f4TLGhmf6j3jZ/cngQ4QedisWr9ccb0gXPIf+Pz4nmSsz?=
 =?us-ascii?Q?+k2AJADKekBmDI/x9dTQtx+a2h9koidDrPIGRTfMIix0jAscQniMltnfxjYy?=
 =?us-ascii?Q?x61NhDhB3ZVDRGSO0OJd9YWKzq1LtYidLoVT0IzyGBty8HrX9h6bWTG9feWP?=
 =?us-ascii?Q?P8OT9SL5Qr5rkBGMCfdk9MhJC36l6gx6SpYrVxJ3F2mqFODPvZ7m/cBFfTaq?=
 =?us-ascii?Q?uVBRy/v2ICNRIz6SqreYTGZElqiLPLmRCFfUl29rgxVsVftNn9P8I2NBSIs0?=
 =?us-ascii?Q?Ni8btj83QwdMqI54gNiFjDybuntW/dQ14oyZuCWJ/xNbR8wqwZp82sMaeO5e?=
 =?us-ascii?Q?3gGoNaZf/C+3InqpfhNmJZnxwo1Y9UZZ2CDp5/mPXJcrAP5vjwm/gtsrSiHJ?=
 =?us-ascii?Q?joLHHLLTFtokxe3ChatSEj6EHvAGosFuVfLecUsm+dyBMZdBo610ML86g7iN?=
 =?us-ascii?Q?acC0apInFJsROuu/2ZqkAzNP0DlC5O1tuYV1gmFM7DpvUhK4eXsz+x4FLfEU?=
 =?us-ascii?Q?N2n6dJ/iyS9E7DOpPDbDMljl/sWwKmav4xy9YwmQzXQveHlGrwYkRcQb8x8r?=
 =?us-ascii?Q?4JkgCbJ/XQ4hORTYgYF8eJrwRm9sMkWswvOi/QHtXm8OMM/nsebxfsmpxYiG?=
 =?us-ascii?Q?UhjeAxcCVihobWK8zMYG0n/tbKl7aWyhf0lmyVllu4l+SeeQmSZTojdxzGUG?=
 =?us-ascii?Q?+TPkEOljC+bIeAsN3qItgeZd/m6g1tAdeeJqWZXm9aMpE9REAvFlJPNKXs+O?=
 =?us-ascii?Q?qYBQSGiF4xSINOCnQPGN23Ky11otBmMXmcXte2nRIKg7a5Iaq2EZAcgrJoDN?=
 =?us-ascii?Q?7lKVsnvmCTFUUZu+BuskqXRlzCTzW/FX3D71qwd0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db73b04-f418-4216-1a16-08dcf4f7db57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:20:55.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j6hmh9K79TovGZxkUFwfs+FO1dBeW9hHjKn7PxnnYe19bDABlI/+72dJ/5cmOEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

On Fri, Oct 25, 2024 at 06:53:01PM +1100, Alexey Kardashevskiy wrote:
> > +#define iommufd_vdevice_alloc(ictx, drv_struct, member)                        \
> > +	({                                                                     \
> > +		static_assert(                                                 \
> > +			__same_type(struct iommufd_vdevice,                    \
> > +				    ((struct drv_struct *)NULL)->member));     \
> > +		static_assert(offsetof(struct drv_struct, member.obj) == 0);   \
> > +		container_of(_iommufd_object_alloc(ictx,                       \
> > +						   sizeof(struct drv_struct),  \
> > +						   IOMMUFD_OBJ_VDEVICE),       \
> > +			     struct drv_struct, member.obj);                   \
> > +	})
> >   #endif
> 
> A nit: it hurts eyes to read:
> 
> mock_vdev = iommufd_vdevice_alloc(viommu->ictx, mock_vdevice, core);
> 
> vs.
> 
> mock_vdev = iommufd_vdevice_alloc(viommu->ictx, struct mock_vdevice, core);
> 
> as for the former I go searching for a "mock_vdevice" variable and for the
> latter it is clear it is 1) a macro 2) which does some type checking.
> 
> also, it makes it impossible to pass things like typeof(..) or a type from
> typedef. Thanks,

Makes sense to me

And the container_of() should not be used in these macros, the point
was to avoid it to make the PTR_ERR behavior cleraer. Just put a force
type cast

Jason

