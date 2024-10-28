Return-Path: <linux-kselftest+bounces-20769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E59B22BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D689F281F2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3215F3F9;
	Mon, 28 Oct 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fShUdgVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7323CF58;
	Mon, 28 Oct 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082631; cv=fail; b=ExsIZqo1iKjIwV7rXl2pqSr9z0lDjx/egwlHYOhR1MZjwjDFWn5KIvvdZ/2tqvd8vqVW7uFzJ483W8kkOwKfHRoDz1R9/7qANG+5T0ea4JulEo7XGxWmfrHjiGSTYkcKQ77lNAt5e/iPZFIMP8PfRCKFxg9RPB6VpcIVDEinyNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082631; c=relaxed/simple;
	bh=5HAwbJ2PMWvaJ/I2Cldnk8mGmqc2Av+5I3gtsEmgyA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4R8XlCbxucoxFwvV+vFp8t0NYPr5GiUq56EM6NPeO8vyw1Ik7uy34pWB38CRSo0W5iDQux3/xMsiYj+A9k4kWj4BoT2xpqMvKvcW5GYfeXW7rNa4HPYN/SNiiQn0B660H1jxsffLo2ko1DyShYv3CNNNiRlTOqQNUNjRZTS5dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fShUdgVe; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730082629; x=1761618629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5HAwbJ2PMWvaJ/I2Cldnk8mGmqc2Av+5I3gtsEmgyA8=;
  b=fShUdgVe6gFNtcafdmCTzYzcuJy5Qz8R4e3D+ipBPgqzs1V/eX+TFTsw
   iO9adQokG9rUQh3f89fU6CG/IoGlBhYZa2j4nLRnre2foJvq4pKksAW9i
   vZcA/EwvAEOSwVEjHg7Dhzuv8TF4UOJwkXlH7Y7PYxK5m1AZ0jPviafbL
   wQsVcPJm5rDHgFAlzkaoYQ8rnpKcforxRDcWvpAbR17m+qdfk8DVpynkQ
   nOsXvsK4ydAB81qGAkrBOdZ5YIJj0h1GhTFDceAsntdO6svcQx8Iue5pW
   nQEkvPEsDXEMC4+MgyV+27AqTwEN9eSWsCWMZDo9YZMpNJ1fZ/FedgV7g
   g==;
X-CSE-ConnectionGUID: 8i8pTdc5SVuOsFdsejvWIw==
X-CSE-MsgGUID: tkagAXmvSYmK3BCUPVUMLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40247809"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40247809"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:30:27 -0700
X-CSE-ConnectionGUID: X5TfDLgAT9qg4gGw2c6YTA==
X-CSE-MsgGUID: lkbQHlaQS8i2+H8Z1gsWkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82291501"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:30:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:30:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:30:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N24fGIw2kggZgLt+s0Yyq1NGrW2GaBhpzTwqiTo/oY3pYC0pIwPik2ECJamNe/BbvATELWAwIzQoADOWi+VukQqEaWh3QEUNJeTQVuebBunEmTqmbSOGhtbJbSw3oQ6c1h11rYHUkTxt3xuUDEhDSaGLRXzJou78V9AGAn/BPjKW47RdT0KM5E0VU+IWoDQ3iuKDUPPNzq5fdusBQQqFIb8aJXKBe5sn7fb/4wAQm3Bq49X6B/O6cCdBfZa5o4LuBHhWPFERgY8FEbhwY3gZ9kgxxUFfzyd6l8j2LL9LB+QBWzhibu40Nx4ebIvFcdioOJFqX6WMBYY3kxohTYmDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HAwbJ2PMWvaJ/I2Cldnk8mGmqc2Av+5I3gtsEmgyA8=;
 b=moZv/P/jva3Wim7bXd3GsbHBMvKgJ1VZ3Sshzt8Vwwd4XEcurwDnHjSAoVNM7vvi4xRU9GqXn1Yp7ysZxdg7OWfDfew1Mt77wgR0/kgP2z4g+exw1Ui0xK4EB7pYZ3z8tlE7PnRnEENlyv941kIvIAF7GBCeBcBlxelEcKCSSWXQ/xkPABt2Buk91DQnt9OK6ojsyjm9ATrzod4qMd7nJXffCb0NSqESZHHZb5qC6yWheH12C3ZFJo3i7rjU331jvmScqmX9gTfYyEiisak6uKqEfXTXJBAY00yWrKoYRCqbxx8a3qHIMV3SqRkKjzXyUf60BwNRvOStrKvLtrVgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:30:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:30:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Topic: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Thread-Index: AQHbJBg7FXDUaWdZv0ygWScRExsQ57KSC/kAgAAkxICAAEhfgIAAR78AgARpA/CAAHHTgIAD3hag
Date: Mon, 28 Oct 2024 02:30:22 +0000
Message-ID: <BN9PR11MB527624ABC2E5D1E4C7AC23208C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
 <ZxcspVGPBmABjUPu@nvidia.com>
 <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
 <20241022131554.GF13034@nvidia.com>
 <BN9PR11MB527637A495A46F32F722FB9C8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241025152411.GH6956@nvidia.com>
In-Reply-To: <20241025152411.GH6956@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6459:EE_
x-ms-office365-filtering-correlation-id: 063e4d59-c6df-4aa9-24f3-08dcf6f878fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmN0OWp3K2lEYkVweEpUa25BWHlzMlhVZDFyZUNvT1dtVEF5N0dTYmJjWW11?=
 =?utf-8?B?QVZudmZsWHNSamxXa1VOQ21oMDR3SzFNV1ZJS1puNmlrNjBKZElib1pqdHlj?=
 =?utf-8?B?ekxKN1RVSWRvblpGRmZ6bkZ4OW9KejdDNEJmR3JFV0g0eTZXT1FFdVVHYWRa?=
 =?utf-8?B?enNNNVNIdVpPWURLa0lTeVN0ZWhNL24yc2hNWlNVOWJVbFZQQW52VVJVcVlk?=
 =?utf-8?B?bmVZdjBMRDQ1UGVZU0pkamltUyszOTE3TEZGNXkyTzZmWjdFL2tJejhvclJR?=
 =?utf-8?B?VHNEY3A2STFLZm95TkVZNEI5LytCWjkwM1VXbFJxY2t6akpFUkZpd1lySVli?=
 =?utf-8?B?ZnJjc1lXWkdPNWxhWVZFUW1PSmRoUnBnTTdvOUMxcVZUZ1JYd253TDNlNXBU?=
 =?utf-8?B?b0JCeWMwVCtPNWNMK1RvMzFINjNrcjZKS1NTRHBxK3hwMm5YV3N0U05ZbERw?=
 =?utf-8?B?RXpkTExtUXZPamwvVFk1OGlvT2ZWdHliTXBLa3liVFJSdktFR1RaTFRxSXNI?=
 =?utf-8?B?V09PbE9xSkt0Uk5lZXFFU0wzaEFIaEZwUnpoaTBXM0JJR1gwdjRLZzNIMzN1?=
 =?utf-8?B?Y2RvRjBpbnpEZEt2cElGOHpJZCszaU5kTmorY3RrZWg2YXo4VWRGZSs0OS9Q?=
 =?utf-8?B?N3YrNEY4OWFFN3QzTVo3djFHQ2ErQXpWelYzdlNCR3lJajBVVW5aVyt0OEhV?=
 =?utf-8?B?dzFHRnAyUFJJZUtQMGJkeEpoaVVwbUFMNFFITXYxSkdjS0dML3hqOE85NzIv?=
 =?utf-8?B?ZFZ2RFU5SjFRL0dBd3BMcnRrZjNSOGdJTXpZZTVFWXJIZXE2Yi9RZllDdWhT?=
 =?utf-8?B?S3E0RWFMUFZUZjdZa2lVNjU2aWI3T0FWbWtQcU02WEJTWG56dkFuTEgyUENU?=
 =?utf-8?B?Vk5sRVEvUXN3Y0lQTFNDTU8yZXNIa2w2MENoWjJnUUJoMDk2R0poZHFCRFdv?=
 =?utf-8?B?SkxiR1hwdzc1Z0IwTzFDU2h4Nm9GWEh3SzFLYUxpOUxjQU5BUjhNTDNpbGZO?=
 =?utf-8?B?MGFjNVcwMCsySVpRVWN4NEVGM2pyTS9MODFpMGVKUGR0SGxVT3E2TW5wSnpu?=
 =?utf-8?B?WEJFMjlxM2tEN0dTai90bTlBUnkwY1pOVVQ2b0ZUalpiMWsrbm9aMmpYRHV0?=
 =?utf-8?B?R0ptMlRMT3J0aDNTZ0dwTldmbkJML1IwdkxrSEtaQ1RRaVVOVVBNOXQ2Z1pl?=
 =?utf-8?B?NXhlZ0JFak9FdkNxQjg5d2Nja1RpeXpjQ1hUQzdxbFRsckJzTWhYR3ZkaTBj?=
 =?utf-8?B?dzltRVFVZDVmRHR1c2NuUjRDMnp4Rm0vcTN2Tm1CMGZaSGFOOFVtb0ovanpC?=
 =?utf-8?B?TGFPRDFlSm9HdGtwWEpGc1MzY052MVNiQy9KQm5ObHkyUmp6WTdoeU8wN29Q?=
 =?utf-8?B?bXVkQ3dVZzMvZ0JXYkRINzRGeHBWNjM4ZGVQKys2bXdTVkhDYUJySGtUUjhC?=
 =?utf-8?B?ODRGOWl4VEt4TVdBcitlNWM1TEg2RUpEbWlkb1pONHdCQ3Rwb0dHTzFSZHI0?=
 =?utf-8?B?eHhzK2JFUkxRVWdUMktCRjhxaFNaZ3VTU241Q3UwaDZleGF3RjdaOHNBWG9h?=
 =?utf-8?B?MGc2YzNtR200OThhUW10Umd2bmlkajd5WlRzaTlXSGo3MGZ3QzZBNi9mRkQx?=
 =?utf-8?B?T2pQa1VYZGtvTHZtVnBvYUx3azVqeVQ4L2k1YlhOZ1BGbGl1Y1BtNXgyYnhP?=
 =?utf-8?B?dkRYZVpNRTlvSjAwbHZQcEFRczErZ1dZLzZaL3d6RmRFVFU4RC8yRE0wSDFr?=
 =?utf-8?B?UEwrZmdWQWVsWU0yR3VsSlUrYnBvSFJpRjhpRTM0bEE4Q3k0akQ5QTdWK3U4?=
 =?utf-8?Q?pM/b2i6518QjgN3hdtXEjPR+EsI9H2fN1Siew=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2tJaWh1UHplUytaUnZBQ2RwK01pelFtdklFMVp6bmZHaEtib0lLSDZGdWEy?=
 =?utf-8?B?emZ3RnVjdytHcTYxbGRRb0FtOVFJaTR1UmpmT3JDaVhMa3VyMWZ5SDYyMHZR?=
 =?utf-8?B?bURJeVRydG5WSVl5bS9Kd0VkL1RRY0l0akRXMk5JYUZvU3prWm5nZ2V4Z0pS?=
 =?utf-8?B?akx5OXlPVzduMkRMK1pFKzlXeFYwT1MwOEtzWU9zcERlYy9QaERvMXhBVWNH?=
 =?utf-8?B?anIxM0laZnpZRHhEaGUyV0IwWFI2STF6Z3M0UVdtanE2b3FlbXNuM2tiYkxN?=
 =?utf-8?B?ZE9pOFBDbDY0N3dScStrUU5JSTlNNEwyc1MrWTllUkNRYlhFd2hjaHVlbVF1?=
 =?utf-8?B?eXljeStGM2NjNDJTRVd2VHNiS21uT2ZIUk5td2lxZ0E4Z2V6N1VBSDBjUnVs?=
 =?utf-8?B?cjBTMTl5Qkxha1FuYlJpeHVibGtKUXNIQVliaVRUNE5JbjhYMnVaTm9LK1RZ?=
 =?utf-8?B?V2ZPdDBoM3U0clYrSFNsT0ViOEt4UG1ZdlFMa3VEbTduWXN3MW5MK1JJZmgw?=
 =?utf-8?B?bmh0alhPeWZ5ZVNkZmdOQmI4cHZIV01KTy9hcmRhSWdCdXVBVVkraXorb1BE?=
 =?utf-8?B?NnMxZEw1S01VdmkwNm5WMmt0bFowanJkaXFYYWVuS1pUdEtpd3V6THRZRGZ3?=
 =?utf-8?B?b3lkVlIzdjhSU2dUM0YxcjJPakx4d3AzV0d4TzFGWGdsZ0pTT05TYWxqVk1v?=
 =?utf-8?B?SlNNbDFoaUxzcEtTNkFRWStaVWpJRGc0Y1JZTHFqYUpyTzVwUEprMC9Zc1l4?=
 =?utf-8?B?WThtNS9IUk1PM25JWm1iS043bWg3NkdQUmJ1R0E2VzVrVXlOUWsrTzNIdTRq?=
 =?utf-8?B?R2JrL0tVQXp2Nlo2anBRMFZuZWlkZGQ5eVlGSC9nakxCS3dETXhPb3hHdkY2?=
 =?utf-8?B?M0tQYmdadTF0WHFVdjBJZnMzb1NmYStxa2JRaTcvb2xxYVFzYWZRY2ZFWXV1?=
 =?utf-8?B?VjZGSEdGMlpEbDAzcGZFK3F3MWk0MmxVWkhCY25PNXJ6NU5xUG15NHVYTUNH?=
 =?utf-8?B?UFlWZzIzRlJET3lnRE1zZVIwZEJwT3R1TS9wQmRHL0dFKys4U011aW5VUHpN?=
 =?utf-8?B?d0UvUjlhRkRYNE5DdW5aM1ovU0RwdjlZVHJYS3I4d25MTVRsNjBna3p1UEZj?=
 =?utf-8?B?bUMwQnBnREZlVGlTQ21iUmdMdHo4WHQ4TTU5V09FR250aVFGeU9XY3lEekZ1?=
 =?utf-8?B?M3BBWWNQbkg3Q1FoZ0hkVlJXTlhKNHdaUExhcXlKaDZueVliYWJJMFRkSTNR?=
 =?utf-8?B?WGFLZUtqeUZzQUV6TmhKWWRBQ2ljVUE4OTFuMVpSRFA1bUpoaG9MYzJGb2J1?=
 =?utf-8?B?dllNMFZhQXlTVUZlbVY0VDdES1gvUFZCQjF5VXpjSzBHdU9DOEt4Wk9CMzFF?=
 =?utf-8?B?WWVoeEdWWEp1T29pUVhRZnR6VEtHWFJVL1RGaldITzV3K3BrZkZqUkJXSHpR?=
 =?utf-8?B?YjRSMEpBS2ZRelVXbkZCaUtiUmY1eXRWNDBIM2tyRWIvQ3hkSUZ3NzN2RURs?=
 =?utf-8?B?MFlSbjhhNCtPUEpOWEhYai9DRFBCT1pLWnBDOHNkSGl4dUtzNWNHdy9YSzdF?=
 =?utf-8?B?Qll5VHEvKzUxazdiRFVNRTNOa0E2RFliUWg0NUMwSEhQNnVsVlliKzNWb0NH?=
 =?utf-8?B?bGN2OUJvUjEvckw0UndoVm4yZ1VSUEd4YzZKRnUwTUZ5bjdJZ1ZITkZJdmhM?=
 =?utf-8?B?VVViQ3lPTGd4OUV0YlB6MWRvOVRhNmFOM2k1c1piSEdwUk1ObE9tdDY0VVRu?=
 =?utf-8?B?ZnpRcXRnZkNBSlgwdjVzTVYrVFZmM040bmtDaUt4NVQ1NkdLbXpleDczYm40?=
 =?utf-8?B?TUlVenY0ZVdjRWwrMy9nSXd4TE8xVnlmNUZmVGJ5K1V6bldDazhzdmYvdXNl?=
 =?utf-8?B?S3R4QStEMGVBLzh3Z29meFdEQWMwTVZQTks4YVhkRXpiY3F3S2MwZUtqUWxi?=
 =?utf-8?B?anNhUWsvcTJleXNzUWNOQlZCS1lJcjZlOTJoajlVSkNyS0dkOUlDL05Pam5X?=
 =?utf-8?B?a0tVSXhJajUrd3ZpM1AzTUszaUJoWGhMdFJDWkhsTEhZcnVKNExiZ3hSK2RP?=
 =?utf-8?B?L3V4cnhnVU5PcEt6RUhjNTBiQjhTSVg5VFZBcmRVVlZlMDdPSlFlWjdjRWpo?=
 =?utf-8?Q?QgEwpZ25cOM9v0jRzuXJsROeu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e4d59-c6df-4aa9-24f3-08dcf6f878fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:30:22.1524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4z1DJeIZtPmfvqXSlFiE/O/+24OmD3oEWKSJlTn9PdA57G3ADSKc0jjAzG/XOnxxmqfkn8w6RmafGBW8ACq0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgMjUsIDIwMjQgMTE6MjQgUE0NCj4gDQo+IE9uIEZyaSwgT2N0IDI1LCAyMDI0IGF0
IDA4OjQ3OjQwQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIg
MjIsIDIwMjQgOToxNiBQTQ0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgT2N0IDIyLCAyMDI0IGF0IDA0
OjU5OjA3UE0gKzA4MDAsIEJhb2x1IEx1IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gSXMgaXQgZmVh
c2libGUgdG8gbWFrZSB2SU9NTVUgb2JqZWN0IG1vcmUgZ2VuZXJpYywgcmF0aGVyIHRoYW4gc3Ry
aWN0bHkNCj4gPiA+ID4gdHlpbmcgaXQgdG8gbmVzdGVkIHRyYW5zbGF0aW9uPyBGb3IgZXhhbXBs
ZSwgYSBub3JtYWwgcGFnaW5nIGRvbWFpbg0KPiB0aGF0DQo+ID4gPiA+IHRyYW5zbGF0ZXMgZ1BB
cyB0byBoUEFzIGNvdWxkIGFsc28gaGF2ZSBhIHZJT01NVSBvYmplY3QgYXNzb2NpYXRlZA0KPiB3
aXRoDQo+ID4gPiA+IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBXaGlsZSB3ZSBjYW4gb25seSBzdXBw
b3J0IHZJT01NVSBvYmplY3QgYWxsb2NhdGlvbiB1QVBJIGZvciBTMiBwYWdpbmcNCj4gPiA+ID4g
ZG9tYWlucyBpbiB0aGUgY29udGV4dCBvZiB0aGlzIHNlcmllcywgd2UgY291bGQgY29uc2lkZXIg
bGVhdmluZyB0aGUNCj4gPiA+ID4gb3B0aW9uIG9wZW4gdG8gYXNzb2NpYXRlIGEgdklPTU1VIG9i
amVjdCB3aXRoIG90aGVyIG5vcm1hbCBwYWdpbmcNCj4gPiA+ID4gZG9tYWlucyB0aGF0IGFyZSBu
b3QgYSBuZXN0ZWQgcGFyZW50Pw0KPiA+ID4NCj4gPiA+IFdoeT8gVGhlIG5lc3RlZCBwYXJlbnQg
Zmxhdm91ciBvZiB0aGUgZG9tYWluIGlzIGJhc2ljYWxseSBmcmVlIHRvDQo+ID4gPiBjcmVhdGUs
IHdoYXQgcmVhc29uIHdvdWxkIGJlIHRvIG5vdCBkbyB0aGF0Pw0KPiA+ID4NCj4gPiA+IElmIHRo
ZSBIVyBkb2Vzbid0IHN1cHBvcnQgaXQsIHRoZW4gZG9lcyB0aGUgSFcgcmVhbGx5IG5lZWQvc3Vw
cG9ydCBhDQo+ID4gPiBWSU9NTVU/DQo+ID4NCj4gPiBOb3cgaXQncyBhZ3JlZWQgdG8gYnVpbGQg
dHJ1c3RlZCBJL08gb24gdG9wIG9mIHRoaXMgbmV3IHZJT01NVSBvYmplY3QuDQo+ID4gZm9ybWF0
LXdpc2UgcHJvYmFibHkgaXQncyBmcmVlIHRvIGFzc3VtZSB0aGF0IG5lc3RlZCBwYXJlbnQgaXMg
c3VwcG9ydGVkDQo+ID4gb24gYW55IG5ldyBwbGF0Zm9ybSB3aGljaCB3aWxsIHN1cHBvcnQgdHJ1
c3RlZCBJL08uIEJ1dCBJJ20gbm90IHN1cmUNCj4gPiBhbGwgdGhlIGNvbmRpdGlvbnMgYXJvdW5k
IGFsbG93aW5nIG5lc3RlZCBhcmUgc2FtZSBhcyBmb3IgdHJ1c3RlZCBJL08sDQo+ID4gZS5nLiBm
b3IgQVJNIG5lc3RpbmcgaXMgYWxsb3dlZCBvbmx5IGZvciBDQU5XQlMvUzJGV0IuIEFyZSB0aGV5
DQo+ID4gYWx3YXlzIGd1YXJhbnRlZWQgaW4gdHJ1c3RlZCBJL08gY29uZmlndXJhdGlvbj8NCj4g
DQo+IEFSTSBpcyBhIGJpZyA/IHdoYXQgZXhhY3RseSB3aWxsIGNvbWUsIGJ1dCBJJ20gZXhwZWN0
aW5nIHRoYXQgdG8gYmUNCj4gcmVzb2x2ZWQgZWl0aGVyIHdpdGggY29udGludWVkIEhXIHN1cHBv
cnQgb3IgTGludXggd2lsbCBhZGQgdGhlIGNhY2hlDQo+IGZsdXNoaW5nIGFuZCByZWxheCB0aGUg
dGVzdC4NCj4gDQo+ID4gQmFvbHUgZGlkIHJhaXNlIGEgZ29vZCBvcGVuIHRvIGNvbmZpcm0gZ2l2
ZW4gaXQgd2lsbCBiZSB1c2VkIGJleW9uZA0KPiA+IG5lc3RpbmcuIPCfmIoNCj4gDQo+IEV2ZW4g
Q0MgaXMgIm5lc3RpbmciLCBpdCBpcyBqdXN0IG5lc3RlZCB3aXRoIGEgZml4ZWQgSWRlbnRpdHkg
UzEgaW4NCj4gdGhlIGJhc2VsaW5lIGNhc2UuIFRoZSBTMiB0cmFuc2xhdGlvbiBzdGlsbCBleGlz
dHMgYW5kIHN0aWxsIGhhcyB0byBiZQ0KPiBjb25zaXN0ZW50IHdpdGggd2hhdGV2ZXIgdGhlIHNl
Y3VyZSB3b3JsZCBpcyBkb2luZy4NCg0KdGhpcyBpcyB0cnVlLiBUaGF0IGlzIHdoeSBJIGFza2Vk
IG1vcmUgZnJvbSB0aGUgY29uZGl0aW9ucyBhcm91bmQNCmVuYWJsaW5nIG5lc3RlZCBpbnN0ZWFk
IG9mIHRoZSB0cmFuc2xhdGlvbi9mb3JtYXQgaXRzZWxmLiANCg0KPiANCj4gU28sIG15IGZlZWxp
bmcgaXMgdGhhdCB0aGUgUzIgbmVzdGVkIGRvbWFpbiBpcyBtYW5kYXRvcnkgZm9yIHRoZQ0KPiB2
aW9tbXUsIGVzcGVjaWFsbHkgZm9yIENDLCBpdCBtdXN0IGV4aXN0cy4gSW4gdGhlIGVuZCB0aGVy
ZSBtYXkgYmUNCj4gbW9yZSBvcHRpb25zIHRoYW4ganVzdCBhIG5lc3RlZCBwYXJlbnQuDQo+IA0K
PiBGb3IgaW5zdGFuY2UgaWYgdGhlIENDIGRlc2lnbiByZWxpZXMgb24gdGhlIHNlY3VyZSB3b3Js
ZCBzaGFyaW5nIHRoZQ0KPiBDUFUgYW5kIElPTU1VIHBhZ2UgdGFibGUgd2UgbWlnaHQgbmVlZCBh
IG5ldyBIV1BUIHR5cGUgdG8gcmVwcmVzZW50DQo+IHRoYXQgY29uZmlndXJhdGlvbi4NCj4gDQo+
IEZyb20gYSB1YXBpIHBlcnNwZWN0aXZlIHdlIHNlZW0gT0sgaGVyZSBhcyB0aGUgaHdwdCBpbnB1
dCBjb3VsZCBiZQ0KPiBhbnl0aGluZy4gV2UgbWlnaHQgaGF2ZSB0byBhZGp1c3Qgc29tZSBjaGVj
a3MgaW4gdGhlIGtlcm5lbCBzb21lZGF5Lg0KPiANCg0KeWVzLCB0aGF0IGNvdWxkIGJlIGV4dGVu
ZGVkIGluIGNhc2Ugb2YgYSBuZWVkLg0K

