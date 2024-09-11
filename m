Return-Path: <linux-kselftest+bounces-17726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F278B974C40
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DAE1F2637F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3914B08C;
	Wed, 11 Sep 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmtVkjLq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271B143878;
	Wed, 11 Sep 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042389; cv=fail; b=N3umln7OdLYsibLz+OvnZCzEKj9ZRKw19pAkCogO9Qhp7cCoOay3pwuAkk6a4VL3MEKFkxThFeqUgnLzeq0suO5LvId4NRqdnU0l7OWmn/GA+Sr8ynma7JRtYOL3Utw6bVxR04v07mfCfmzPonVHufvmT6i6wOdjXean2x7HROE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042389; c=relaxed/simple;
	bh=4lcXdCwa9WWH4AGL0SRPbQCdp7dWNKAbPH8IE1o+95U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDCL4U09SoIRPAoEnOmA1z9l3FQu5SEgYTRnNq6GeTh1r59eE9tecNPCPxff8kejKsGpG+Saf/YMOfbW/ZvnSemNt8g8+R+Jm9BJxrTw2nkqN4PlTegVr41YaVb37Iew9PbwqvHtRqcxxuckP6cUcgpPek9x4gcqdDRWF196JB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmtVkjLq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042388; x=1757578388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4lcXdCwa9WWH4AGL0SRPbQCdp7dWNKAbPH8IE1o+95U=;
  b=DmtVkjLq22RTKoFZ8IfnQMLZnbO2nQm8K3eet0FrDXHnslX4wD2ZL650
   HfF7Jsx1495Y/HWz1UFJlyARMULVyn7rKt9V8abcBpzPZB+MUXq2Dk8as
   6DX+TYA1ObhvehDsuVkcVb6YEAwYAmwa+NcHpqbcLeuaRAyLU/JeqpkTj
   gYlCng4esgKFWbOE00VoWShcMC0vtfcGvzJoK4jyAAbETl+SZxtZ9XHEe
   wk95JtBgRYNc3wIxi3umkXRGSaoPfqX6PsmJfvAfDSZxEDEbuDe9qH+mB
   oX3FczSDGjZBiFEkYYVTfAx3xo4zQvTQ3cVMq+2ntpMe5c6aibM1+sgR5
   A==;
X-CSE-ConnectionGUID: usmCyu/lTMu6aoJLqyxBQw==
X-CSE-MsgGUID: TQb2ccbmQS+lm6XGTX9CaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42305419"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="42305419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:13:07 -0700
X-CSE-ConnectionGUID: 9/rqN6SzRn26s7Hmuw3U0Q==
X-CSE-MsgGUID: ODeR3ANFTgGQBK3mKsHkbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67341074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 01:13:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:13:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:13:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx7TRNR0iUvoNfeV5ZA+QT8QyR6AJdejKQSXQ9btL6ZtrlENiYUvQTxjQ8O/qg86RUK/iNevE4ahdnd22n0fkqRIt2k7l6gidtId5s3J3sqSWE+VP/RpLxr+xaTp4xSWVMSX1W9pY64Ur7PsPtXycAPMIi8hzXc+qdeF7+4vdTxPg+oESoA8Icqpx6ZN1hjNESYrTeIxjY4YJIzUU52XHgF0+AI5AVOoPxFJg6LJpu+8lRnmKEGQW2g6SSeCa8Y4OQA224v3GcqbPF7ic8ybFCkdmxAW+clmzKZ/Ms/Ty30yihEASi/QyQx/Le8mIjxHeqwqFP6G9dv+3Ao5OIXbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnoVa6gXv0v2tsug/27yrCeKCHVq3K8nrGlQ4DpwV8Y=;
 b=n+MNZhSCUW2U7d48/fU7zzWmo/okroyQSO8gVgKLtMvpK8bbk1WJvC2UnrTZ77K/NC5pF9vmMfINBZMVKwSwTXzD1qexEfFohxq9xZ/UclfIFZk0dr0z+DzDcxCAZUo0kherhxA1PUKgzE1HjSLe69n31f/eDXqrkkQd/xDz2BLCvCPrFGkUSdFnpDDBW8TECdRuylDDiiXK/Baxn08DJ8HluMJAWk7OLl4cR89UPqqkVMgds26F69mMNqymJX8ASC/Mpgv3OpmLONL8hrW0O0Rhdv5cSWII+jdoMXy/Bv/hYXFzx1A+sXD7Slz/uW96Aoj1xFbK6C016i7T5Z1HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 08:13:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 08:13:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
Subject: RE: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Topic: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Index: AQHa+KLw6F1nSDclIE+ushKsvSKoLbJJbdGAgAAb/YCAAAXcAIAIpC/QgAARFYCAAA2CoA==
Date: Wed, 11 Sep 2024 08:13:01 +0000
Message-ID: <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
In-Reply-To: <ZuFEx7mp3v0/lY/g@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7982:EE_
x-ms-office365-filtering-correlation-id: fd635ba5-8718-4977-d3a8-08dcd2398e37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IB8DT5flEug2f1MhyGAgb3FvwlSKQXrztS5sSJCs1860W4Ko2zH3K2e1euFt?=
 =?us-ascii?Q?cmExf7NT/Ec4ngo7B1u/WwXZUYNdUZ38squmALxCfC8aqF4ff+mV3JTiLSOe?=
 =?us-ascii?Q?+b2cmRoyNxnO8nWxRaKIX0O02kLJx5wt+tV3rta4DVBBcXNyId4rGvN8ddt6?=
 =?us-ascii?Q?ESHnsz8wuQIVLPjZYIrB7/qSmKLelveNz+YjnTnaacLYYmqxoortyalRE4h1?=
 =?us-ascii?Q?i5VOrzfnGUftzlgTwTv7Mfms72DjXynwLCLZ5e+oqAlv7yDQlI9uR4uJIt1m?=
 =?us-ascii?Q?yHP5mPv5Pt8lrHbzMyV2nHyqz1niZlO6vBpanuN89/s2vw5zk2BZRMJVVHES?=
 =?us-ascii?Q?N58mPRtmPfln5NDJ6aQQU6Wrku/EXxganG5p011u+4BNVWOlEmvtovY+RMfy?=
 =?us-ascii?Q?hct834T+RhW/4PpWkc/Shz3y8cusCaUrt94l1MWx5jPoNb9Shl91u5zX8Yul?=
 =?us-ascii?Q?cQ/gtb7tHBqFBZCElqCFFsa1NHBIFeYzknhFQGfDduLfetGHrDLF2UhWF46n?=
 =?us-ascii?Q?Z4X6MZHe24obkKq/Ux0X4ZfQaGA1iTlbyI1BKdpDb5hRL/PVsnF+j/HKlPVZ?=
 =?us-ascii?Q?KVYwtiSLY6+c2K81jAZNatjqoneDYg5pwWtcuTKkSpHzIYgE8S77yHvLpsM2?=
 =?us-ascii?Q?1W48gDK2J4vrqn5OpkHosIVOFRGWC/hOwSxLnhgKVBPgOloz94ADZcuPZGu8?=
 =?us-ascii?Q?Uck9QlZLcBPUzjTHAnCnXefqIZbQXvWwRs9BAkbzkVTjT0bQqbjyMh1L6DOg?=
 =?us-ascii?Q?ltl/qIe+JuUugCneUXlGe5i+kN2AyTmygSg7uLfnTTdZThcEjOWkbcFa2Peo?=
 =?us-ascii?Q?ruV6zufA2IkiolPvxIGslThpwXhbyPcQdNz0X+d1gnS39Vet7fHZOhxnZj3/?=
 =?us-ascii?Q?oFObqIJAmEElfPwhVv1UbnXi/1CbaXGbxKYBj0bjMzdzYkeG78MXFvzRvQj0?=
 =?us-ascii?Q?EVNmkI3oVHprbCMyHuuG1mEnCun8DMFxHN5b+o45mPZ+X6jSc86RvO4ey69h?=
 =?us-ascii?Q?FGkm7nIKET/RMLHW6LCoQ/TMbxB20TvSAgKEkZxoNk6GdAm0oK2hK7rFcaS8?=
 =?us-ascii?Q?uSqoZxaKRIDKgS+QxfTG07PC0D2RMIbzSwtJLXiC8JTbihoOmriQeirLN/CY?=
 =?us-ascii?Q?XUWckkTB/nG6KgG2ZBvJrbuPjUiAcJkZw7sKoaK1bl/b+ykX+aoeo3sA4kRj?=
 =?us-ascii?Q?K35qskKyKuelqISvfpn/xlJp0VQDfjw+h1JBtr7uFBxYy9vnxJMfmMj6A23+?=
 =?us-ascii?Q?XrdQ210rJLKkdwEzXaoZk7Mt92d//EXOF9P8Z4rh8SBFdcDdog7o0T02/3g9?=
 =?us-ascii?Q?JN+hG0QsZ31prBVy5CrNXLqZHwZ2wl4ryEgXB7I9IPWmhmH4II037tpkPPHG?=
 =?us-ascii?Q?cPgUbPuJBL4hmh2Ir9BvqDswfe/kUZzAWssHYeKcLtcxyaANcg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zbydixQMuIU9hjywMHR8qzSbFWw57TW0UeuU9NCTOLFP3SAWdv93DJ48erR6?=
 =?us-ascii?Q?8DS+56panZXxjDZuWe6BohIRZdYNcINepsak4tVnBCZw9R2iTNYYfyPoiLM7?=
 =?us-ascii?Q?cxQnNQC43Bpnf2oCtJnIMrJOzNk1HQW7S5oUla1d+iFmXz6nulu4olQArdH+?=
 =?us-ascii?Q?rygjrVrlyv1eTu1PaU/cqfWM03im+B79wQwNOarMVd/HUaH2txsICh+aR6m+?=
 =?us-ascii?Q?2UZnllL0KTQcnaVsbMuop6QaXf07VzEI6nQe7319QzqX3HyFyQoOxGCcexw8?=
 =?us-ascii?Q?evIkQcIPAQCDuA6dp9ZMrfFProamhpV8sFgCOcVTaNFWIfhFpP9G0kP5/HLR?=
 =?us-ascii?Q?dMtvBJ9ML0U+9BqkgKqXwaeMHmvvC64Fpvo4N//Jv8upC9cZ1OM/GTARoOob?=
 =?us-ascii?Q?3LxeVCExjEN0gf8ZxZrdDperHz5b08XqcM002GtkijPq8StDeWC/8VC1jnvI?=
 =?us-ascii?Q?YUYgyqdwOJN0CI3m595btIBBFPFqb2CdxSUK5JG/42REc8mx9+Mv+81I+l75?=
 =?us-ascii?Q?560swmGFlXcSMOdYHT8nLCXtxuiaB6lgJ8ok2i7vlk1JycM2xgVjT3tRVzc3?=
 =?us-ascii?Q?7SQ68JMo4HzFVhsvJu3ZEZEaxQy9QtnpQ5iUzW4SYPWofUap2Ne78V2h3toE?=
 =?us-ascii?Q?WV//yWNwueruwLdcpmWBGnNfQueaFeWk+a5FY14ObLiisDdc6iAC+g2uP1Oj?=
 =?us-ascii?Q?DS8rI5p+WHcOyhgdU3NH4o+yRGAb40DCFhQZtgJNQJKmNKt0SbB0bFqqUxJo?=
 =?us-ascii?Q?D3AkyTMLesqamtovM7HBn08wFe2tzNTtM1dIaJMsGXZ7iaJKpqkgq9pZou29?=
 =?us-ascii?Q?raqQr+SQscJgRZtaKOtj4wF9UrfvOjFFKAr1LcjKZxZyJq37qvgNK6y2zXDD?=
 =?us-ascii?Q?WxZ8tEjIugXLL5FqmZjXZzbtaAVk9eKxp4p3/Nl+sKfQBy/ap7RsG0n0lk67?=
 =?us-ascii?Q?iawAPC7IWUa5QKYtC4j8KgsVmHeOTNgqzF9Bp102gW2SkLKjesdtiti4L/jD?=
 =?us-ascii?Q?COdCic/OXwkWtRj5NnFDlXfg6utlxYz9EzQroVeCpdTf6CjCdh69HR7/T3sx?=
 =?us-ascii?Q?5neIvQqKWHAaFYWLM0IlXa6FsR2aGRaueFVYZE6CZJ9YbkkmAT01q/wnTevj?=
 =?us-ascii?Q?BYrdhNH5rvKaGE4MpKU6xCaBJ/YnWROYgd7ibqJ/mV8Z2f+MG+J4FZx6L2Mz?=
 =?us-ascii?Q?ihd1Uz297gQH3n7sHIcPDFNJseDspJuD29dXB40H+cPpQ3Oyw4LDt+Ldz71T?=
 =?us-ascii?Q?oiFMg2R8kKHCAccFaDmFVj/bwLR2NRMSH5nzOU0mpB9pvZEjqFE+DNRYjsE+?=
 =?us-ascii?Q?hxKRkuJTRCMpL3F9uM7feRxQI476kGjWCBP0d0KW3nOkFR8iITckNfcGvWj8?=
 =?us-ascii?Q?mVoSqn3GheK6f+EZGynCqlh+40q/dLQCMr2XHOhRPwBqZIAu/T/7c8lOevcm?=
 =?us-ascii?Q?2OcP/wP26fbIgKVMDKNUUgrQMfaAzGBqGo5hugWTtouGzNaKYcPi4604sYyR?=
 =?us-ascii?Q?g4av2ol2ecGssGJ1tLqN3hU33StiqEc8mFSno0eRBVGlDnu+nqu7zZN3bpL/?=
 =?us-ascii?Q?IU+Do/xayRlG2yE+Dsv+mRFqIZaLEgs/yKusMPOW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd635ba5-8718-4977-d3a8-08dcd2398e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:13:02.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbj94ob+TjWyyas/7Zmo1Ihm+KW983GAQ7JJBLPbPWloEaeC7/Q6nxFy7h5pqsepncgGyeLGodb8/mIQEjhpzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 11, 2024 3:21 PM
>=20
> On Wed, Sep 11, 2024 at 06:25:16AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, September 6, 2024 2:22 AM
> > >
> > > On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
> > > > On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> > > > >
> > > > > > +static int arm_smmu_viommu_cache_invalidate(struct
> > > iommufd_viommu *viommu,
> > > > > > +                                           struct iommu_user_d=
ata_array
> > > *array)
> > > > > > +{
> > > > > > +       struct iommu_domain *domain =3D
> > > iommufd_viommu_to_parent_domain(viommu);
> > > > > > +
> > > > > > +       return __arm_smmu_cache_invalidate_user(
> > > > > > +                       to_smmu_domain(domain), viommu, array);
> > > > >
> > > > > I'd like to have the viommu struct directly hold the VMID. The ne=
sted
> > > > > parent should be sharable between multiple viommus, it doesn't
> make
> > > > > any sense that it would hold the vmid.
> > > > >
> > > > > This is struggling because it is trying too hard to not have the
> > > > > driver allocate the viommu, and I think we should just go ahead a=
nd
> do
> > > > > that. Store the vmid, today copied from the nesting parent in the=
 vmid
> > > > > private struct. No need for iommufd_viommu_to_parent_domain(),
> just
> > > > > rework the APIs to pass the vmid down not a domain.
> > > >
> > > > OK. When I designed all this stuff, we still haven't made mind
> > > > about sharing the s2 domain, i.e. moving the VMID, which might
> > > > need a couple of more patches to achieve.
> > >
> > > Yes, many more patches, and don't try to do it now.. But we can copy
> > > the vmid from the s2 and place it in the viommu struct during
> > > allocation time.
> > >
> >
> > does it assume that a viommu object cannot span multiple physical
> > IOMMUs so there is only one vmid per viommu?
>=20
> I think so. One the reasons of introducing vIOMMU is to maintain
> the shareability across physical IOMMUs at the s2 HWPT_PAGING.
>=20

I don't quite get it. e.g. for intel-iommu the S2 domain itself can
be shared across physical IOMMUs then what is the problem=20
preventing a vIOMMU object using that S2 to span multiple IOMMUs?

Probably there is a good reason e.g. for simplification or better
aligned with hw accel stuff. But it's not explained clearly so far.

