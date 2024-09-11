Return-Path: <linux-kselftest+bounces-17725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A3974C33
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06426283A90
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E214E2FA;
	Wed, 11 Sep 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCu00nav"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9C14D6F9;
	Wed, 11 Sep 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042092; cv=fail; b=ATy7jKo/g2Rx8TrR4tYQv9RGr8n0LRG2jjusoUovjW0qVjhG45g83BpNXjhRvDk/o/3j0xi4sQj116ix3Uz9wkY7S5loLDPXhfzFzQ/149J943WCi0M0vMMGdPTASGzPxWhhUsIUnM+hRGO3zkrme1+5uTlIUoB0ueYcEzQyoKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042092; c=relaxed/simple;
	bh=PSJtRXPQjvroMbz6tgdWOosQDlnrM6IHlnTo0XRjXOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cce7Y1bWOsaRfI1TyJSeGNW5ZUKJ3BJesmGjkLLFyxUlf3qWzJmneW2ymDdLzQj7YJJc/QlG8KgT6heXmPNz6NdZHyGI7JL9atD/oT73PrDxnmTv18V9QOo4HRYAnnJpDKzh6yHS6f7sSCChZZwsx5ET+ke3tWQWPWAWIQYzSjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCu00nav; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042091; x=1757578091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PSJtRXPQjvroMbz6tgdWOosQDlnrM6IHlnTo0XRjXOA=;
  b=DCu00navzgjJzIjwWuWwa077zMpKeTPGR8RI9PO9o4oHwFlfhNLlAHlO
   oL2lQmkLDR6rxHg3pjl+ExQCrF6fmByvI0vbzT5ZZtMjS5drzOYsEOGzW
   lSzJXe1Lfn/BIlgk2Av8WiaySTpKQqM3gKXwXmVAkiyXk8sgG0UifzA78
   8Gxsku6GScdqhNq9E2FewpXT4KuZkl1BhL5jWjvgOi9HU/6BoKIjTx9Eh
   QjgGm1bd+vF8YKRQf1OeSzH30Jzcn/u/nlfFlo0c6iHqPMU8frU3+nMsq
   WIK+h6IvE9FVFMVG/fOgAkyBSxAJymH3cH4oe7aGY9p2bpiK1Z7dQ4O2l
   w==;
X-CSE-ConnectionGUID: xGuubTpBRLaKdBUNRPEksQ==
X-CSE-MsgGUID: aiAQVEz/SIqWzNcQOYBhMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="13468640"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="13468640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:08:10 -0700
X-CSE-ConnectionGUID: nG083hsNRjqXtHl5V0Rb0A==
X-CSE-MsgGUID: rUQbKHqgRCui8rKXdSTPnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67517874"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 01:08:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:08:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:08:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:08:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiv/2GQCDySPgG6IzIbCkMBEd3cRmCBG/E5k1Hfuo6mYewlLH4m6sKr9fJt31wadCdGasB0VipipNKa/eEayTarN/yJHsglNXIcuAg8+U5jQu7X3gebP34vWeeGJJu9ihrkO9xGIQToWixCyZxSVzFpEUpB3bEIf5ToPMk+cmLgDXEj4DUFXMFv6K/IfNfYhYVfV75H8OYuCZK2/RM2C59svn39hCSWJHgntZZM3BN3v6W6Bt6nE4JUyhjjJTkPe/b6KNOpM0V6hsK4oK1qxP26mKn5YT+p/wXsfojmwSZ39hwEgV8ZJhX5AhaXYNtrLnu/VWeEA1M27SlZJC4kluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSJtRXPQjvroMbz6tgdWOosQDlnrM6IHlnTo0XRjXOA=;
 b=tghMhBhQEx67tFQi34+yCP/Y71bIeyGqra5G9ZK4fqBHOSwakqoeXLkLL9o1i4cmPwsZccyiJ+MT+/pVGvTDrrFy7lRhSAsSzHQ138ysQeNIH0XzvA09kH01I4jKLc4LG3/NEnhH+8mCFqPqoMCOMSclXPyYsTLp3Y3zDf99M8C3UTp3uMex79nrnxf0FZxRexd0+69G8ManMK+M0h6VYYdgVpnx1D4DmTSLe8Db+nwX4msQhijNfXAz7jx43d5nV8fr9NX5VI+9CmMRVHXPdEHjX5MK1ew/AVBwrXEB/UwOTc8ugbjGMaH1pc2Vm6cjxq3VaQek9kESaf4pwwHY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Wed, 11 Sep 2024 08:08:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 08:08:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Topic: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Thread-Index: AQHa+KLdGUnDM+C8EEu4QYu86AlEobJSMNBggAAQmYCAAAEN4IAACCKAgAAHTEA=
Date: Wed, 11 Sep 2024 08:08:04 +0000
Message-ID: <BN9PR11MB52768D6E30FF5CFD66B2ABAE8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
 <BN9PR11MB5276554A016C2A54C41C64808C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZuFJh8t62LKi3FJY@nvidia.com>
In-Reply-To: <ZuFJh8t62LKi3FJY@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5990:EE_
x-ms-office365-filtering-correlation-id: d514415b-857c-49c7-21e8-08dcd238dcf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bN54U3IH+BwbUz1fQvkm40OdfC24cRjV6j1YdPwvCgDjK1WqW6mEu/JpI3A2?=
 =?us-ascii?Q?scPd8UlSQ5ybG7h4cXTe9QlSvhCwuiTkPF3YB7g0nFNdmJJiQekO/Lpgr5Kp?=
 =?us-ascii?Q?wWfKA2U9NPPbttY6+KXLTkx+xpN/POkxFApMXBEAvSq11V986bGMmgVybT4y?=
 =?us-ascii?Q?4J4zGO2Vw8YUV2WeBs3p/3AKfFLQdO8wCbUnNZ4A3LcDQAFvCjdP0Z7R4cVl?=
 =?us-ascii?Q?nty3QLPmvIDidmcyFGYSPyvRopmFzjHKv3MWwRIB+lvYfyUm3lpcc/Hbu1Ew?=
 =?us-ascii?Q?s7x6Yf4NixZh56uTWmDdt7UQZ82Ra0ZJN1lssuMIiSri++cF3souT207YaDu?=
 =?us-ascii?Q?f5Ge8fIDhKo3Sw6ot5BT4CJc61VjuMesXC+AcB19zBV9jdAV84J9rU1WjEO6?=
 =?us-ascii?Q?sascgwNSSLNnsZDSuMsEUEZLghp+QifBAASUo2geaHb3VxWmvsTCnb/GRvK5?=
 =?us-ascii?Q?lZcWsXZTwiK6FWQbvQw6+9Y4vK6j61Nyloi5wlShT6O/1L+RhI5Oi7PIvVgi?=
 =?us-ascii?Q?WicL66Oz6Fb4kEVlD7VmlYrtGHtTj753zf2R4kfKHazqb60iPZBHSGkOqfA+?=
 =?us-ascii?Q?21vR55/WVqzTMiO14GVi/WK498ONretCeXFyzF7xxP8//EJQ/WtkBYZ011MT?=
 =?us-ascii?Q?/wpJkwkYL0iNjf4nRYnBdusml9plviItVqualHYV0UhTotxSB0mkcS+gYlCq?=
 =?us-ascii?Q?y8fJLq5JULpIDvPROkqavfB7JxVYPKw5DjrKQ3nstXR33IX6f77hEybdTkUp?=
 =?us-ascii?Q?ghWZL12SuFgZLkkPoOt4L4mLzfi+/F91vxrJLuHz68rngrIFeCkKZgyGw9n2?=
 =?us-ascii?Q?UGybJgmlgKB0ojSNdYQ/mTvELuNoS6mZkbfaY6WuBfv3aC/PjIyv2cj9MR6/?=
 =?us-ascii?Q?2N4e1EjAR91y0EmIZaG1WkzN0FUOW1nN/hmyIR7HyWN7sUY5AyA+xWyoe7aS?=
 =?us-ascii?Q?MnaIIaTvNordv49lgjsNipYWKHL7RkXewfPln6Gd+D6sMec/W8AiCL5ZRH+V?=
 =?us-ascii?Q?s3b/v5CSysvHoTMjpg670NJG88wntQw5+8HvPwCr6nyFpaH/1eDcfRTQD6z7?=
 =?us-ascii?Q?EQniXkbRSvLLurRh4HxkeZlvgm8ryeVJ/eBIYCQD4w2MlIEtSQvTsBzqbIht?=
 =?us-ascii?Q?F3bsSEbGY8SLvCZsnb4odeuLjTyfTgJiKJm9xdy0v0AAUzBogmLFaj9v37cX?=
 =?us-ascii?Q?kVQHtyE3y5ut4xGxz5QyZhCETj4piXs5mTZjqPmxlCOvuK8w9ygYDoV4cYf4?=
 =?us-ascii?Q?9MgYbzCLQLcz3XK92PRIrHfC5oh3Pe8SIwtPhxApIl3Atk4wyOzi8QZS7ZON?=
 =?us-ascii?Q?aZGHxGERkrnEM7IfaupofNDM/QEs0qbV/APfTXFK2HAZImPpxN73T/l/hz+9?=
 =?us-ascii?Q?baZq/yxlP5fEKwVhX01xuNm0i4PvigglwSOE3mONloploeMs1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uff4kA7mpxl9FozO7xvdkvle6iGBY00qmBMQ8aSHQy2iDex2RCIN/xqi53k0?=
 =?us-ascii?Q?yim0lsC7+n3UtVlLhlLsNqzpJrLWtKWL8n+Sdl+/eQT5sX4EqfoSdrIKsQpi?=
 =?us-ascii?Q?DebIskoYZtUh6tLRie3ACsIom2hh8zlgMDAHzhf0QFNIn0r1LbpkvAjCS7LU?=
 =?us-ascii?Q?mhW/UTk8Km7E6lt4ihFzTZzjzoANrDF+lvFICLOWS7C8x8cyCrsNqt4/X22L?=
 =?us-ascii?Q?xnH78ByxxjQkuzbhWDmq3SAx6+yZyKdBLXrhCBXoltfixcjFgW2gqsyC6CeM?=
 =?us-ascii?Q?z0aSWaDo7ra0H77R7rFdAwLJDmDTbo/ZyNatfF8fBuNKyQSO4hW0tK3ee4IY?=
 =?us-ascii?Q?uxaQQPYo80Hv92jSnj809+r0UcTQMA30JdcZ1BH54nfXZ+mMT68exKgUFfBq?=
 =?us-ascii?Q?6Y7Dko77AaoREICMDFRmCjZUxDwUJxeu4X5kpURjYAqqfoU4a6q5dMW/+vAi?=
 =?us-ascii?Q?flfyTqZQk5QSOpWTuHbvLxFLmG89ZWUl5sD+aUr6pgVpDcxLeKdBbqVsXa1a?=
 =?us-ascii?Q?b+xt/5PCop6OoCdyBFSzko92yfS4BU4T6FRxpbtJUGaWiPenzYuHGZYB6IMy?=
 =?us-ascii?Q?RvPXU5ssojQs3bVKbjiRbFkfX1Xr9EkVQbZWljpwMBqRbew0thpEdzsOZg86?=
 =?us-ascii?Q?Vnit1BX8YK5uv+PLAjKkQgnTdzssvK4l+KvjI71PCKhgU58XS62veAE8J1Yx?=
 =?us-ascii?Q?y+rZYF8zBFcxs8nW4GyJ6ei2zVLN7n0zu5kzGmfDXzbAyw4XJ2k+OsNmA+zM?=
 =?us-ascii?Q?1H0l1+Obm2Z2CUteF0bx5X7E5ufRYHVpRkWFvC4D13FhCD26aS64YQht2iXt?=
 =?us-ascii?Q?ksJpbIXovR6DR20V8PuZFsDW5YnbGR/RUsNOc3/5fW0r6huazCLJkPCuAxso?=
 =?us-ascii?Q?pxxwCiSj6yGM1ze+AZ11pgXAoc8en0/gjHI3US5oKgfkPFwUm9oVXLkyjAa8?=
 =?us-ascii?Q?s4knqYYYI6XC0s4VU5VsUKmbYy9qUm9AuXeodxSnTQYRyj0NUEAUd8dzsKDw?=
 =?us-ascii?Q?6Fp1uGrlTl6R69HlswlcNQiaAHDWk3ku9pl0M+HFQi3JvXV960kPnf3Lgesl?=
 =?us-ascii?Q?HnDIgRdjRItfE7lSCssNJGdwNP9rsUwOlgzvV3fWcA9WpzjHpkOzk2whNG9j?=
 =?us-ascii?Q?ISuhRUMXAVVIlFfIXUKzfLzhs8Ur4dNOm2eRXrOswqOoeR0vmgckrzxbB19B?=
 =?us-ascii?Q?4/zPegSPh9b/wnpETMmol7HWplK060U9niZcTUoAHC0nc3/kcQoujstFjglS?=
 =?us-ascii?Q?Pq0Jd/8MdSigzkFfV46qDUJjhEKjFw7dkl8ufUSHA5TsoqDfwnyqlOhnb9/b?=
 =?us-ascii?Q?PMja4YuE2x3dmGolIpoiJEC3uL1+HMZ07daxV0cMf7x1q1a4uDe1LDriNwbP?=
 =?us-ascii?Q?PNr4FkkOrt+pDyPE7SM3+jIVzUQAQASNk9tP8AkW6X+G7AQmrbGjGQjfVX5u?=
 =?us-ascii?Q?mZ28dWO7zETemj06lWuXn6GzuTvJY6Rc6+NC+smLZ6JxJ05+wufjb5mov1VB?=
 =?us-ascii?Q?HKZuyiKJpUn4/QK9h5fdEVofH1UMTpRfvFIbuWd3rlCOhcoVcW/S9LINxOAT?=
 =?us-ascii?Q?YHSjbSrjwu+YDYkac9wKzUNAD2//XoSRwVDWHD9C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d514415b-857c-49c7-21e8-08dcd238dcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:08:04.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYOP/5g1uAvbylOTTLFrnHCOi4dA131tYkrm3AsZer0QJBZLXo20iVYOrg7CO5d3hI2qBknoZ/IvnnG4cn65BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 11, 2024 3:41 PM
>=20
> On Wed, Sep 11, 2024 at 07:18:10AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, September 11, 2024 3:08 PM
> > >
> > > On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Wednesday, August 28, 2024 1:00 AM
> > > > >
> > > > > stage-2 IO pagetable. Each VIOMMU then just need to only allocate=
 its
> > > own
> > > > > VMID to attach the shared stage-2 IO pagetable to the physical IO=
MMU:
> > > >
> > > > this reads like 'VMID' is a virtual ID allocated by vIOMMU. But fro=
m the
> > > > entire context it actually means the physical 'VMID' allocated on t=
he
> > > > associated physical IOMMU, correct?
> > >
> > > Quoting Jason's narratives, a VMID is a "Security namespace for
> > > guest owned ID". The allocation, using SMMU as an example, should
> >
> > the VMID alone is not a namespace. It's one ID to tag another namespace=
.
> >
> > > be a part of vIOMMU instance allocation in the host SMMU driver.
> > > Then, this VMID will be used to mark the cache tags. So, it is
> > > still a software allocated ID, while HW would use it too.
> > >
> >
> > VMIDs are physical resource belonging to the host SMMU driver.
>=20
> Yes. Just the lifecycle of a VMID is controlled by a vIOMMU, i.e.
> the guest.
>=20
> > but I got your original point that it's each vIOMMU gets an unique VMID
> > from the host SMMU driver, not exactly that each vIOMMU maintains
> > its own VMID namespace. that'd be a different concept.
>=20
> What's a VMID namespace actually? Please educate me :)
>=20

I meant the 16bit VMID pool under each SMMU.

