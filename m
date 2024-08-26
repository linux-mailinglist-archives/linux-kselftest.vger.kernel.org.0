Return-Path: <linux-kselftest+bounces-16231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D995E862
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DB1C20885
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525E78C89;
	Mon, 26 Aug 2024 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHpqrqbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574144205D
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653212; cv=fail; b=Qkskqyroblo/s6bdxxF617DUDWPKoIqsgPPchtqLgAlpYTbrJWTHsFHqwBxYvmnUt+NjvfEs9Dxc4JCFf34u6umsGwoc2Au3f8k7RG7ZYR4Kaneee9pXHUSvdo9/TWfib4zgtkoP7Rsgt4JpkVFL2raee1RITPBzuGaireZN7PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653212; c=relaxed/simple;
	bh=SSK9Gch90wrygVgnlfwgRuAUd5NdnYZKQrYnd2BqXD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nh96nmjLxTOQ2Lh0VPT5I2hz4xDWakZvmhFoAiOLaLj/dNKiNCzZYbXGEjU6lQ4v2PQCx5feQKGaD+UHAK0/IWHr+87GBCyZjSU3JHwG6/HiIX8lxRm/tFJ8KrkiXDV4KDAyH3CFGM0byUAFDCZ1Lkdg39jdsJzefcTCziZugpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHpqrqbh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724653210; x=1756189210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SSK9Gch90wrygVgnlfwgRuAUd5NdnYZKQrYnd2BqXD0=;
  b=IHpqrqbh91KE42hkwJeDf6wwQ/83B3J3S+EYDC8nE6nORcTy0miesi8x
   QgRXAyRnkh3XhvCZgpKcrQdEch3iOVhZdDRbpWVEI/gAbVPq0pwyvgtuj
   0QF3uKLhe/AHTOEUxLki11iOo5skdUdnY/FY+NA6l4k0fXmfxaQi7n3Uh
   1opNDvLcB4zl9qPB/0seCP/+jvP0y8HCdGPMqG1ODU4/lkMjd0npypRCx
   LUlcy7UyRx0hNWazPxPgAbmyPT3TDOUtKQ/tZtXg1GmETk0RpTx26E0lE
   1jhDjg4r+0PtbgNfLjpYpVZVNBNZEKSywJG6R+NzBI3uYd8ZupgmNOOAt
   Q==;
X-CSE-ConnectionGUID: LOpEq/hlRUG9xsMW1Qcmog==
X-CSE-MsgGUID: nJRNdB71QIm/Xnq60Wm/yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="13204839"
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="13204839"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 23:20:09 -0700
X-CSE-ConnectionGUID: HMIxKjsyQ7+eDJBHyyodYA==
X-CSE-MsgGUID: xcTT1BCHTeWj9oscI7bMeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,176,1719903600"; 
   d="scan'208";a="62372347"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 23:20:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 23:20:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 23:20:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 23:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbW3VZmNYXISB98zu1108Kn5ZYDz8dV2kf1ASA+GXxiGPt3cegCux4xwEtyPWJI9L3jcXm9NpAtQlkyq7uv0DKJVsz+UENMtgmyoxGqPGX0fVFCVYFgGinRlUM+0hIgN2XG8tc8g1Ry4GYrEOzpLJWCufMhly2h0+pbbzD7mv3hjfk5OTMxbUKHhkjNDdHNz4B9KO9+KpUPZyXJeMWhzGapim5ZWpzvrJd1/EHKFmYPmLKFgJh3uUlpsLSB8hAYjg34XQ08WLZZy1/lFNQyHSiQ0E/4Tt1UMs5zqVc4/DTJv3jSZ/WFrDamgpXgQRxDloIYu1Rl/ErPFoJTbQ+m91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzU7RhSPA43JqCT8rFj8ut9S67P2p3kgvQ3cpCqP520=;
 b=J8sww3HfqkUQoWc11KH3qe7Ug4WGAmyFqnMYGjWauA7dxm8mZ1bHmgx2lNGywlhyycJ8/JDWk86YIVvTWLx8jODe3Qr91A6GHKAEDzeI+5Ju1f3iP00CekYP1JNPUeZHWZn0T4WsCb02J8jN1QoMIt5Cg0OViIZHDNqo1BHUAcGwf4XFaQHxMFfcpByZyorz6ZRrH1eqKrRlTclcjlIAI1xzvadujmee8/hPBrMHyPeinPhheZrO4XEesD+W0a/0z6NSQSQA3f//G0Zj0j9/D11yUv9Qy9BBskKvkW87YgxwQrE9gxlQTr1VVkuzYACmEyUNpOa/YwUUPg9Vuv61nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:20:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:20:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah
 Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
CC: Eric Auger <eric.auger@redhat.com>, Janne Grunau <j@jannau.net>, "Rodel,
 Jorg" <jroedel@suse.de>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>, Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Sven Peter <sven@svenpeter.dev>, Will Deacon
	<will.deacon@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Yong Wu
	<yong.wu@mediatek.com>
Subject: RE: [PATCH rc 1/2] iommufd: Do not allow creating areas without READ
 or WRITE
Thread-Topic: [PATCH rc 1/2] iommufd: Do not allow creating areas without READ
 or WRITE
Thread-Index: AQHa9KIVmymZS5W9vUa5jboYvoPyB7I5FpmQ
Date: Mon, 26 Aug 2024 06:20:05 +0000
Message-ID: <BN9PR11MB5276DBEE269BC218756D84D88C8B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
 <1-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
In-Reply-To: <1-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8497:EE_
x-ms-office365-filtering-correlation-id: a97670cf-0c09-4282-8876-08dcc59720b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bS5ymVbUepc+NpnXL9d3EcTlF2pL2ynjzsxTKsYQi2vDuMByZc8ifKXAQZxd?=
 =?us-ascii?Q?CmB4R9fBXX4HXD9mOPci9j+yRUo8dJqghTlC8quYEvOlyRZE91aT+SYGWT6i?=
 =?us-ascii?Q?XQzsJHcvUUvASsZ/+MHCq6Kj5HOcffMAFeuaGpOc83wAb2xC7zOM93IJNXU1?=
 =?us-ascii?Q?EMJ1FElsYdu1qDaaqfqrn0I04PdBrh5BkFAm5lX4PTo4F/ABBwHPSLPBKOMN?=
 =?us-ascii?Q?9qN3V08z3wHBAq56SM7kwozKJyFg7dV3ehrWtrUZqu5NYdZjfDsjeJg0Ok3V?=
 =?us-ascii?Q?l3/10D7QOI3X4HSMJ4wC2g7ifkO4y73K//qagbJvqIVJgKpzO/EVglzusR2b?=
 =?us-ascii?Q?+tk2oHfAEwqab2Zf/QRKK4v5xN0sMikIHWBygoS+QeBnvpUDVKcLNFXKGzw4?=
 =?us-ascii?Q?hgh9RmahFsnVloz7VgXT5bVB3lOm9srUOmJuDSfwRyv/DkCorG71NeVhNnmu?=
 =?us-ascii?Q?1//tMfe40vXiYAQivkPWS5Jsg9JZmNOYjddAfJANm3aNaSLTLagutsl9w7Bo?=
 =?us-ascii?Q?AaB2/qIFfTFvwIkiFVV2YddWqHHBuipH2hhRTvCtEp798g/0QJXPLwyNZm8T?=
 =?us-ascii?Q?gY9Y25z4bP+sFp9Vuxb2JbYMFCqxiREx5/mIvpSoIge7H/QqI6dmV/QZuH3d?=
 =?us-ascii?Q?i6j8Sqaxpw0Ph/oanNSy239BhNhUqgqukYze1XZwQkQkLpgvWkmUzh8lFYJQ?=
 =?us-ascii?Q?6qnE8bW0zWSwdJkNdxGU3b/KHYmojxDmBcJyAjt09wUgJiETesRiPEaAwJ0W?=
 =?us-ascii?Q?ekxDruaasfIQkI6Rzs7wfhMaLk+z/QGhr0dXEvTwZBMOe9GFlX72jGEupKMc?=
 =?us-ascii?Q?EdL+EdeDCKLqDyW6RPJy+GZW4cWvuCzAaOb9eCjf/7ai5GkElZI80U9jXNm1?=
 =?us-ascii?Q?kDk2LsE+RTv3HifCE2ZZQ/YJiNEKva73COqFnH6XggMQBI4+alRkWXRdNaX1?=
 =?us-ascii?Q?Ke+VLZOdybp1iOawD+fXxD+2Vi3ye1qfwtK4gjcV3Iu7GPKTLahvM8X12wQM?=
 =?us-ascii?Q?0hapWiRm2fmayABNeiM97/sHIgRyzCftw4ng2vsD+Rypfufz/qahXeg2tFYI?=
 =?us-ascii?Q?yDMXjh0qv5F3rYgpGQ8BwBj+MVod42MTrJR9d1ZKN6qvVOB7fH3yY1Zm5Rhi?=
 =?us-ascii?Q?XWRxJMHaFRVfhIflsVi38lZM9a+PWunzz/JJ2umNJRLqmGTRsRnTvQhTWTwx?=
 =?us-ascii?Q?TiaXosf48eAKU8wEKiIUAB1znBmgNe+CGEkUdt5fceLoG4Uhx/G6E9gVAwwn?=
 =?us-ascii?Q?g/n0S9/HhQ1RWjd1kCeWscYvdXe4f/f0ef9PPOwdYbfFNGOAG5Q0klXzMpoQ?=
 =?us-ascii?Q?DWiPGO27t7acjQGbXPm1CcyOTAnq45qRCRvLtuV/e65clIGtAnAaxRmL7nAz?=
 =?us-ascii?Q?bW/18tX/1WxhuOM/SGoYee3WqCop7/jTr4vPVIVxhDPHv24iWHZbveOIsg3e?=
 =?us-ascii?Q?Tak51gBi+78=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RvHmgsXBB9PEdJPpog9RdAYBQFjrSBcvRUMpcOOzawhJTvhvP5euGCn9DM2R?=
 =?us-ascii?Q?EJOBsjTtwK4C1+cD2YGvW1wtJJmOUacpC9jnV405rWlq9kiXuXm9kbiPwmrH?=
 =?us-ascii?Q?900eAKwt28OTyXjjoq7QXkmJqpz8naCWsMQarz860YQd3YOic8OGND3JWzZf?=
 =?us-ascii?Q?xSxI4H5UYsIPafxf9SsAMAXDPeJUMVsF2sH1AlMQSV0Gs5seimDpKtDfLlf8?=
 =?us-ascii?Q?dmghPRHGLaDgfaa/Nd45Wez5QHvdRl9xbjO5cGZmN8V4i5d3aWAODBWqhNIU?=
 =?us-ascii?Q?LrCmpYzYQvKgEZ+bEJFSHf/zs0qIQvVO8cMoNKTjY3lW6GgYh/Ia933SUBgV?=
 =?us-ascii?Q?dzaigvA1N5RqoH0Oh6qiACkH/yomLtHNydSoGbe3y0UPuhY9R0L17yUOY8uU?=
 =?us-ascii?Q?6qM4slxDS7YKmYiicQJwLDSAYyG69TOqiGLlgotzqvy+qHyBwiCyQzaqM6uz?=
 =?us-ascii?Q?841qZEAjeAONezrvXe2hlRqbn+gv2vyyWoMHROyb0e2600L3eg5iYJOtqjkV?=
 =?us-ascii?Q?Jn/UGYjVOnIVrN7Yc5ya8LEMFgC0IamXJw8nTpSqoAtwQk3eV5Dap0i873SE?=
 =?us-ascii?Q?p9nFUmSQmAQb91DjFIFxAfJ1NBAS3KJ6B1vOQ5O+3OdgBSvyCodFTjcr98WQ?=
 =?us-ascii?Q?EXolT9nmCbUWb3w+5kJP3CWA9n23uh+yP6Wc4diyTPPhWu7EF2+HZkj7ArSJ?=
 =?us-ascii?Q?10iU90xWuy74mCwdX1zUoZLO1DcSThEjmXOq9bc6HbaAOMV0P2Jop+9srnFJ?=
 =?us-ascii?Q?/2BZU2Z0hcLybkRMQOwSIIBa4ClhM9iCeXEhtiHLCKkrVzIDWbNfWKNx2TLY?=
 =?us-ascii?Q?1Zxg08qm3SAmqnynfls3ez4pFed3XzHMRFiaCQOK9AKM3c7C36abuEfquuOT?=
 =?us-ascii?Q?8L7EaJGvcuYc8bnvLQ+gJeRBK6CAc1ZxvoUfKC6FrAwYkNbn7gqTHnOLUA6X?=
 =?us-ascii?Q?h7TpMB5GVIeJGo58tmB7RZ84bxmkkOX5tVSkHWzgizoBPBnwDa0Jee6yPjWp?=
 =?us-ascii?Q?GlE5VwXOVMpEGXBk2Ffev1I2O6sVQ19ly5/SP/i4yuBTurGf4Mt2DLKExeu7?=
 =?us-ascii?Q?WcNaoz7hm1mCmcOumEYYhsilWVYBEV59K+F42KJd7/czdTrgzdz8lK/Rv2EZ?=
 =?us-ascii?Q?o9tmwG+l8FiLlSvYAjJJMSzMKUEQ+713ES5/iJDVCJ2UKZ7v1h9IjT9D5AXb?=
 =?us-ascii?Q?gs0gBgsMYh0sw1HtITQG3/hUR4GAUcmSDbkqFGBtlNKzuTxoo5dK15bTjnki?=
 =?us-ascii?Q?79Bd11zoNRUhTaOwQEd/EsQpowqvoDQQ3bZNhwOyczBhwSVa69Ztr6VjE4sq?=
 =?us-ascii?Q?IDS+oq8EOa+yYuAsT2+0c+B7leYrSiZ888zIZMLERdEYgs6uzoWcdZOfLxPG?=
 =?us-ascii?Q?gGv7CADqpMYSFTgdCqIcWzk6pb0vVydl0QP27EGCK6zryIAC5fTcSx1qeS/g?=
 =?us-ascii?Q?9SSfuWKfp+ETpSKf9vc6PCedvh+yv+W4bNHCVoh7bspAPmshfS2HmHMJ1wU1?=
 =?us-ascii?Q?X664kWrEz+sKaNG5IXdaIWg0Ky3Ipvk8hxnN+md9gbsq+yljnIwbjSWXp4LO?=
 =?us-ascii?Q?1GqhYSm4ecBizg0v8Vz+YkUI1Fj3o7A6w43sA9Yp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97670cf-0c09-4282-8876-08dcc59720b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 06:20:05.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp1cH1nIJe96JZ4c0RoCyxiw+onWxIPT1dFeZTh5bTSuJYTrBek05NLL6uSXOx1IZhn75OtdzXUiuYctTZHjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, August 22, 2024 10:46 PM
>=20
> This results in passing 0 or just IOMMU_CACHE to iommu_map(). Most of
> the page table formats don't like this:
>=20
>   amdv1 - -EINVAL
>   armv7s - returns 0, doesn't update mapped
>   arm-lpae - returns 0 doesn't update mapped
>   dart - returns 0, doesn't update mapped
>   VT-D - returns -EINVAL
>=20
> Unfortunately the three formats that return 0 cause serious problems:
>=20
>  - Returning ret =3D but not uppdating mapped from domain->map_pages()
>    causes an infinite loop in __iommu_map()
>=20
>  - Not writing ioptes means that VFIO/iommufd have no way to recover them
>    and we will have memory leaks and worse during unmap
>=20
> Since almost nothing can support this, and it is a useless thing to do,
> block it early in iommufd.
>=20
> Cc: stable@kernel.org
> Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

