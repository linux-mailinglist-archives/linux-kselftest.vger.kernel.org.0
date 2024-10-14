Return-Path: <linux-kselftest+bounces-19659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4299D3F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E779B2DFB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D401AB538;
	Mon, 14 Oct 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bFIdZdAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E791BC58;
	Mon, 14 Oct 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920810; cv=fail; b=eZRcie8HHl7oYh4yIT5K47D40OOpbuSB5h045T02Ag1qxfFazTwn6HJy4S472hncFRJ7BMwDiJ351KrBJEggVkTkGW2sS3WYjCg3xbhQw2/ycm7k6VHOWH+JVqb80/azkATkqbSIWKA40wfmvzFG7NkJFsjGpGCUVq9gNMi1m2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920810; c=relaxed/simple;
	bh=d34Bpdh1lneeDBoexiT3OsJzmlOvnvb8aaMw876uUjQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb/KjsLv4kv/2hkn7YOVHyCl24sRSZuQN1dW1Zgn++WYpwOELaTNeVOIE9D/T/6MATWE+loOkYTEvrjinpIPUCdUhUrtIrxGi5giQjIVlr2DPXwj+nlu3c6OaIebIWtFPnunIkQYsC1eDPqR7JehHzK4EC3uogurLkKOv8Sxasg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bFIdZdAz; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv0+wwq7LosGZyHXJDJdJOifz6lIjd8yM+QnOiYAx/zL6kmca7C1XVuU8/y0Cy36DO7wDOIqk66uJbqHtZ1T8QSZ5FMx30qyH2flCSJqGqwgu0daxbv3nzbGZ1iydCmSoLOXnGD+wqv4ZQ5EEb6Jvnt30+y8a/OxOJzRpksp+oOzRcK9Lx0DuY48NnQ+HK4cGPT1UOZ5XtqKrPJ/JQHDkg5RtSjxL1/o7dkCY9512bsB2h8kjwNdbXHdVwT++E5E+5bVNDpoagPEr1E01YmYEdhwztrZbOEZLK/3Se89I0XmDGQEVaOyQpfLXlOJJOquWzym3J/zuxCaL/RSCieW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hprnuArEAjorRpkGumKoidT5EeMLiZUBmcyeYN5xzfk=;
 b=grYI1HcMdCqQzH7uC9mKXqEwn3PnaOTujXo84KStBHTHi9K68s4bz22ZNAGQ7N5QgzdXKrVio1Tl4oB1uuouG8ffcvyk4qZWTCbGTlvGMC4IAlJpozKJI4YpgI4xaNmK0zqywR43b3t2pwMu2tVpT8csN5pVAkLHbChApCwtEFNI0TIpKJoYJke8Hrm83awFDn8aUvDdBh1UBT1fDQDKwo4NmJo6zzmCf22TSNxleZZLKX/PBmJ3Km/wxE0p8XzTacU7Pkb8DItZjkZsKfjUkIzA7SUaLYz2SbD0Go/AAPzbRIbjjnNNAgd7pR9W38ch1dJlFbT4vh7gw9VXLKFi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hprnuArEAjorRpkGumKoidT5EeMLiZUBmcyeYN5xzfk=;
 b=bFIdZdAznIdKI9tyq3QBmZhw+n9Fjhgz5+/lQsJCXeblmTbC3VZIcZiHMjzk/nsoMpM8nJTvzHb5A+gnYoHCom+9U8ReEKxHdS0oted99kiagzyIKu89gcCt3+MDJdn2F3nJKUAjsRXnmc0zkN97QnYkBqYeTlNZw031CSUUtru2ZlBGWPENATiZYw2OB9r6ms6xROFaW1szOQKE7ZNfzIss3xO6G32JAwaU38x/FMehq7wsurYmoJn3vxXTwLwkY3N5H5ZA0hXuUeIByyqaOnIdPJS+owO33avTOKU/W7vb+uvAkYvk80OwC+Y8aWOTZ0zGrqiEpqGk6b8YIut63Q==
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 15:46:42 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::65) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Mon, 14 Oct 2024 15:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 15:46:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 08:46:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 08:46:26 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 14 Oct 2024 08:46:25 -0700
Date: Mon, 14 Oct 2024 08:46:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <Zw08z9TOFL57z07O@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
 <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a857e0-683b-442e-6f4b-08dcec676695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5bXMduE3M44uTgdgKqRc7f2AzaY740v1hmDmf6nOOiM+Z7mmpeGtnPAWAbXh?=
 =?us-ascii?Q?vZ/Vag9XBEqAR/tJuotXWHa8U8SC8gy1bEGEkBHgxmppekcS8DotbwoM4T0h?=
 =?us-ascii?Q?pnxonCGoSnNOBingY0R8I3hKQgTXcO1VGOphtTcZ8dfHUAu8iDz+NGSpyiJO?=
 =?us-ascii?Q?8TaxeMmqy9MDwm2WyAWtLprkfohrbaLyck3kA/3zccMFD/UyXyd6jSTj+Rzr?=
 =?us-ascii?Q?1RLJQzJd3Yrej660fJ/zDlpSfd/q7chslHSCukU8MLIGTEbVPHLSnkxEqbSN?=
 =?us-ascii?Q?YlFxHqPhT+aq53GeIrOwuGtgud+h6z1D2CFuaZfTK2POx7d343UQ8fqEIr5K?=
 =?us-ascii?Q?GtpkHB7w2j0cPXdfA4kd2dIHpsev7hr0s2ZAEzPyxd6JxKgpPJh9rAe6va1o?=
 =?us-ascii?Q?03aZSgwSkNCMEb6B6yt9h39zTRaHumKAzNrrJFG50I2Jp6TbnB7TgBpaHTGV?=
 =?us-ascii?Q?t63MLlzZRJb9bN3c/3K3cZvP5f5WPH1B467oGFB7j27UNlqVxz/cj2+58VFN?=
 =?us-ascii?Q?5L6m4bVyKxUsY84HtuOJOGArfUnUmYVmwcgQXhSc4XgNPWxPdMO3VkwvhKT+?=
 =?us-ascii?Q?srb0caSnN3Vl+OBIu9Sw2+o4FIJoz6DD/znGKqn7BkS0DOrifre840EojNAo?=
 =?us-ascii?Q?1qhZ/RuVZ/JUDrcU7bcLA3jDdwFUzqrBbYhuRr4jA6R2+MwzhgBEs+d2um7c?=
 =?us-ascii?Q?znDutcQBRAba3LaV0GpIITWZVxZOX6KgvSDBkf9l0srck1TIqQyCMbujMptc?=
 =?us-ascii?Q?heCfemfbv0xxOsMPXRKNrXzHj3A/pRx4b45Ki/tZwiFWSssXhWWNDCXS27yc?=
 =?us-ascii?Q?K9ZhAnLVtrYNBkEhpXkx7dJCE+6FRi0O/ajYTsyj4kvYLv/vqmEYJ0fiEziL?=
 =?us-ascii?Q?i7yWeslAI7gAgGbavV5IcF6pqP7T0JhC/hoeihfW7U+9Yrww50DGPSmBFFCT?=
 =?us-ascii?Q?NqOnSUQ4ig0yxtCM1S2newOT2zg0SCZoq3RhxyAV6k+9/BKAppuaPn6X8ode?=
 =?us-ascii?Q?c1NB3fOU6bQIBBNy4+Ar3Zwpqn672Zbqn1QGM0JeRNB3FeVUXWJuqcQsGZ6z?=
 =?us-ascii?Q?RSFib5BBr5cib9URJGqjeZ7WF/IKvNR5pQau0UVXoMOYDdsSD+9wdG+bigyQ?=
 =?us-ascii?Q?qwG66M3vF4vVa5bdR5JDN93HL7is5gBvTH3zFg2Vw1IKTf3fhuo/zhySfVdS?=
 =?us-ascii?Q?dKKIwE6YvJfykGkbZGRonGP703BZYa/++qm4SQ/c8QBhby4U7mGQN4zVTjSF?=
 =?us-ascii?Q?YUH/4+598TSkuG4GyiOLUcyVAQDTpfAhmZNVwSRv+pi9y7LMXSyj1yFOgO4F?=
 =?us-ascii?Q?Zi9DctfTmo4yLtj60aiHdjLzolNXMZki5jH49qb0P7JzhEj++ow9Pgk+dKWx?=
 =?us-ascii?Q?u51BmxU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:46:42.5373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a857e0-683b-442e-6f4b-08dcec676695
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

On Mon, Oct 14, 2024 at 03:58:55PM +0800, Zhangfei Gao wrote:

> > > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > > +                                               size_t size,
> > > > > +                                               enum iommufd_object_type type)
> > > > > +{
> > > > > +       struct iommufd_object *obj;
> > > > > +       int rc;
> > > > > +
> > > > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > > > +       if (!obj)
> > > > > +               return ERR_PTR(-ENOMEM);
> > > > > +       obj->type = type;
> > > > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > > > +       refcount_set(&obj->shortterm_users, 1);
> > > > > +       refcount_set(&obj->users, 1);
> > > >
> > > > here set refcont 1
> > > >
> > > > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > > > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > > > refcount_inc(&idev->obj.users); refcount -> 2
> > > > will cause iommufd_device_unbind fail.
> > > >
> > > > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
> > >
> > > Hmm, why would it fail? Or is it failing on your system?
> >
> > Not sure, still in check, it may only be on my platform.
> >
> > it hit
> > iommufd_object_remove:
> > if (WARN_ON(obj != to_destroy))
> >
> > iommufd_device_bind refcount=2
> > iommufd_device_attach refcount=3
> > //still not sure which operation inc the count?
> > iommufd_device_detach refcount=4
> >
> 
> Have a question,
> when should iommufd_vdevice_destroy be called, before or after
> iommufd_device_unbind.

Before.

> Now iommufd_vdevice_destroy (ref--) is after unbind, hits the if
> (!refcount_dec_if_one(&obj->users)) check.

Hmm, where do we have an iommufd_vdevice_destroy after unbind?

> iommufd_device_bind
> iommufd_device_attach
> iommufd_vdevice_alloc_ioctl
> 
> iommufd_device_detach
> iommufd_device_unbind // refcount check fail
> iommufd_vdevice_destroy ref--

Things should be symmetric. As you suspected, vdevice should be
destroyed before iommufd_device_detach.

A vdev is an object on top of a vIOMMU obj and an idev obj, so
it takes a refcount from each of them. That's why idev couldn't
unbind.

Thanks
Nicolin

