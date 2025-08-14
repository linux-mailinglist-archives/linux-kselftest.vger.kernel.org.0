Return-Path: <linux-kselftest+bounces-38921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DCBB2588F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 02:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657BA1C05D3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026F341AA;
	Thu, 14 Aug 2025 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTfsyeP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110A2FF652;
	Thu, 14 Aug 2025 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132541; cv=fail; b=IkG1DoW/5kQVJSxVK3pvBeQHTa+es04h5PjZrAKCM9Het/GI7Ib7ZjTA2zo32uiys6oZhQ88GhvUsEFnFyi0p2dNhcFLPOYoDfKocJW94C0CU6f/pSU8EOAw/AiMXUMw6+5Y0Xq/nGxfoAmcIWU8FRTu9wqqTNVstoQDejKAjEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132541; c=relaxed/simple;
	bh=ck0ICh+sUD3z5hGQjf5fZQd5z9Rs4i6KQhKQyWJYpH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aaeg1Sg4mTmlvIyz4VsaGz43rRUzaj5uxv34hbgqQZ8uBIoZvd8QTTdbWyEZV+fJWAyrAPZp/5a9e7U1B5HAc0cGXr4f/OTBB3eKpworN4c9zSsrhVaS6STnGCbBDHHlkqrDwzL32TfpI19Ul0Wf3omavXrFjj+4QWsZPSkH4fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTfsyeP/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755132539; x=1786668539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ck0ICh+sUD3z5hGQjf5fZQd5z9Rs4i6KQhKQyWJYpH4=;
  b=iTfsyeP/EAiLp3O5V/taNRiGF+oprOQLweXRvB4JnDm72xHUgS0r4oU1
   Ux7hVRZpAfnuarWQXXKHXBDFX3ukMn2RTQXmVX0XhT8h4GCwNOsaHb4Gz
   o/eQnbMeJv0S7fjg4CtgNbMcWScnURfep+n/AeDpLtgJ9kx5+ONZLIm0J
   ve0ulAi5PViCacjtAeancfl9zwJke+UBUrn/hfVuvUmBMNKKyh2IGByZx
   5ZPhxO75Jgl3dwoba1KqiCg9G5gjhyaQCr2qa71k2qNIw+eBAb6VtR9Nc
   GKvzPE/05W0g5c0zK118rTj207mlB5F3d0QeGIYjicE3iKF6vXO9maPod
   g==;
X-CSE-ConnectionGUID: Nv9quagFSI6c9VwMzlpYlg==
X-CSE-MsgGUID: 4mIwyOtqQUusxcJ6+SbuJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="45020613"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45020613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:48:58 -0700
X-CSE-ConnectionGUID: PZNHABOCRDWVr+cyu21Yww==
X-CSE-MsgGUID: C02RdndrQQmpEhxh/O5okQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166531405"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:48:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 17:48:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 17:48:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.81)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 17:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt7O+PlrdApE4o6kJx09GY7fUXNbbr0wNv3wxxiTfQ9Qd/TZ9WDWH4njhAn9Yi1OPR9QZ/Fr4gGl+9W4rLk8UVXnzEDHl8zirdLxDb2MWX+F2JWfHIA1xaEdbXNPQUQVGCqbY4XnoNs44alQIowZKfwUg9v1O4IDtVw6YaFVcISqhM1DujfzG1KdE6zPa9MKgPCouKipJmdWOAe4Bn9/fv6VJERIUYx/pwd4BSSF2GIFlXmRl/H2HMmj2tQDRgjsFxh0KasLAlpMpbAJA9puHGk/12dS8LqRsqLIOahtlgVvWFw++gxZWm9ZQxnONy/aj0iTrf5Qj9Th0COSvvMylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck0ICh+sUD3z5hGQjf5fZQd5z9Rs4i6KQhKQyWJYpH4=;
 b=qbtfFEP8fjA6rPpmjhVjW1qRsd+I4qXeGsBE8jFYXut365gi+2J/mtEd17a67ebmEiE78RzFIzJgyleJvDhSoO28YIPzazokB/BgXy81Q9gA528O5FdXPpJaThb6UnLWANERGuLnDZkZuICGOQfVmYshPV1DpbVssZfg7BGX4ZLoMhopO+H5cBx6xBb9/p1WorRvCOTyEix/F+AhHb3eWPs56M75kv2O+5nfBsU9qCno/4byitAf1aCnXsbJ56T2Aa8NgAiQFTpkR1/YC9X019/XcgexoDb5YJGexH1Z7S0IJgYw4bvbf/Aay1xqBuazCSgtcs7dLbe0jJNJsGPqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 00:48:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 00:48:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Afranji, Ryan" <afranji@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny,
 Ira" <ira.weiny@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "sagis@google.com"
	<sagis@google.com>, "Wang, Roger" <runanwang@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
Thread-Topic: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
Thread-Index: AQHcB9g6PEq/oRXQ90mg9xip9xLzNLRhWrMA
Date: Thu, 14 Aug 2025 00:48:49 +0000
Message-ID: <1348bb0bed9da95489b83312998352060ac3defb.camel@intel.com>
References: <20250807201628.1185915-1-sagis@google.com>
	 <20250807201628.1185915-7-sagis@google.com>
In-Reply-To: <20250807201628.1185915-7-sagis@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5220:EE_
x-ms-office365-filtering-correlation-id: 6caf7ca8-3103-4a46-94a8-08dddacc556e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkI5L3dwb2FLMGNZWnZ5RFdMdGcxQURmQ2o5cVhaMDhhN0ZHanhtaUVrdmhv?=
 =?utf-8?B?b2srd1M4MTZ4L2o3dmc0ZVRlREUyT21XYVk5WW00aStBV1JBbUVxWFlPQWlO?=
 =?utf-8?B?R3VpYTl4S0FXQ0xoR3p5TmJTRXNEOUREU1YzWmNEajVWSHJtaHlBZGhIYm4y?=
 =?utf-8?B?VVNJY2dyVkdGTEpqV2RveklFRko0ekhocDMyYTJ0UEN0UnVoT015SEZzWXdN?=
 =?utf-8?B?UXNVS2VjbWpWMFY0QXBENTBSREhhZHRuMWFGcmphZjQrUWF1b0JNTEFKZkNW?=
 =?utf-8?B?Mzl3dy9ZSGNLV2ZtREJsaHZHRUZBLzBIQ1pDUW1lQXRiNW9TNENHT0VmeGhW?=
 =?utf-8?B?VlVIUytQTUZENkw3d3VqZTR4SExXNncrRFNtZlhqRkY2TXVtUkxOWWxQTFRI?=
 =?utf-8?B?MUd4S2s5eXhZUlNra1ZUeWczZGM1RzJhdGJQTjMzRlExQXBMTVBxa0J0bjNo?=
 =?utf-8?B?RlJ1dGtFd0Z3eDFBeEp0SUJjTmRLRVZPSkVlYkFFOTlJVkIzUDUxWHBzcW9W?=
 =?utf-8?B?VSt5VWJhdUlNMUFSSlBjdjZYczhDbk5ZRjRLVHJXQ0dZTE45Y2JHVTJNakdQ?=
 =?utf-8?B?L1ZFeW1zRkdYV1FCd2FjMmhnUXowdFRWcnZIQU1PWEp2Q1ZVWk92V0dEM0lY?=
 =?utf-8?B?WXhTbEI1OXpsNVk2N3ZONXJpTWpQekVUNzlmU296Y2V3WVo1MWlsM0xNKy9T?=
 =?utf-8?B?LzRjR2FEOTc1Y09UVzVRd01LSGlaVHZlYnVsdDdpN28vQXVxcFFydmEwVjZi?=
 =?utf-8?B?MWNuQWtNQXNqTUUreHg2OEFpSDc2UXB5TGdERFViNml1UDRNMnMzVGh1Wis1?=
 =?utf-8?B?aS9aY28zRnpZaC90K1hFaURaa2tIQnFDZ1FxWXJhdXl4WlptL0xvQmJCVy9L?=
 =?utf-8?B?UWsyRW0vbDNoNEFvQ2g5ZnNIeDAwSTBLQmdtY3hubDltZHcyVkxVMjdySTZJ?=
 =?utf-8?B?dFhkZUptK2pXMkttUEx4Z241alhoYnJjcElSdlNLWHREMmRXMXNxSlkxdms1?=
 =?utf-8?B?OGdIUXFLcEZZdEVzdzNSVVJEc3JhVVZ4SWlQSi9YQmVJYmVIT2lmQzNPT25W?=
 =?utf-8?B?R0dWa0RjQ3NaR0ZBaDQ0WnF5em1aWUx4Q0t6b3gzYysvcjFUUUhSOVdZZ3Z6?=
 =?utf-8?B?K1czanJKYUJyYlhkSDdWOGh0aWZJUVFJcWR1ZHMycG9ZOFEycVAvVHhJV1FS?=
 =?utf-8?B?elZ2RDFiMy9BOENWNmNyNzNBR1ZBbVBIbDRhQjA4NHk0QWFkQVIzK251V3dT?=
 =?utf-8?B?YTdrdjlUOGFYM1BDS1hMdldJYi9abk5EQWh2QzZjUjQydXVMMVlFT1p2cXRz?=
 =?utf-8?B?UUVZMlZpczdsZlhtYnJBVE1IRHdNd3RTUENnMUNXOWN6QW54MWJrZkRxdW1D?=
 =?utf-8?B?RGtqY25lRmdKeHpBQXpPOHlhdGc2dGx6MGhPQkxRNkJZNWlsY0NVcVBMNlBQ?=
 =?utf-8?B?blU5OGtHajdRWkRtVGVvR3REVzcyRVZSbkFmWjBoR25jZ0hPMEJyTUFpUlNB?=
 =?utf-8?B?V0pLTVFUZm5BNmwySFcvMlNrV1ZlMk83ZHRGV3A3RTFTZThVMHJubFhTQzhz?=
 =?utf-8?B?dUd2SjRRMk1LV01DRHQ2UThwNDQ0Y0FDQmtadHp4b24zQlBQQTdNbURVUGM3?=
 =?utf-8?B?Q2c3WU45bjByWkc5Qlg1ektZWXM5a2xCR1NIS1ZFYnQwUU1TSy9ObUtERXBW?=
 =?utf-8?B?ZE9NZHorSTNQcmh1b2ptL085NG1DTThpRFpEenFuWlJzVStJUG82M2p4bmlx?=
 =?utf-8?B?WTFURXJhOEs4V051U25zUUN4eEtodVV2RDZ1S1Jvc3BaNmxFY3JqNDBhUWxY?=
 =?utf-8?B?VDRZN3duRFdXUFlRNWtHTVM1akM2MldjY3E4RytzMzNuQ1VjWXBGWnJpZ1dL?=
 =?utf-8?B?QlR1Vk5UejhlQVpSRktIRitUMnVraVJDSjZ5Tjl0MVd2UzBKaVIzOEEwWlla?=
 =?utf-8?B?Z09IOWU2Q0RQR0o0OERXVnJoS0FpL1RBdWhyeWhWOEx3WjluVU83NlYzT0dG?=
 =?utf-8?Q?OqgrWpNaOUX73L7cV+ArOmGUvjUvlE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3N0c1ZXYzF1UzVVNk9yZ3dnUFpWVnNRakVsaHdweXdJL2M3eUQ2TDVUR0Fr?=
 =?utf-8?B?Y0tFZENSWGE1UEtmbGErc3ZYUTFRZzBjOXYwNFJNZzRCRjBET0o3RU5QOEVq?=
 =?utf-8?B?bndOc25VZkxhNFZqaDgwekMzS1M4SFU5eHczOEpBdkZRdE9qTmNNZG5La2NY?=
 =?utf-8?B?d3dDOHVNQmx4MEgyVkw3a2RDOUlEdU9jNU1LZ3V5eVMwajBJVUxPUldLdSt3?=
 =?utf-8?B?K2ZvODR2TVpXSEFtR2dwaUZFTjFualNjMTlnM1pKemMzT2RDY1FkQUJOMnJ1?=
 =?utf-8?B?c2JZZ3JBcmFGSHdJcDN2ZmUwcUl6RWlpN2grMGhySGVtSStScnNkaFRsSG1U?=
 =?utf-8?B?bVlnamNmYkcyZGQ4NmxuckU2Umhna3RxS0ZGNWlKSjlzYm1OTElsZHNDTS9K?=
 =?utf-8?B?UUdtM0R4OHFIcHJ3eTZTYm5YSGlZaXFObEFzK1Vxczc1WEN0T0Uvb2dURmVp?=
 =?utf-8?B?K1I5bVdaelBja0VXUWYremQ4TTZub3lLTkQzMHR5M1BRdWRSN2grWTV3WGtV?=
 =?utf-8?B?VU5BNjJQcmsvUFhQZ1VMWWlVL1NlM2wwcjcycU1Hd0R0azR1b1crR2RRWDZP?=
 =?utf-8?B?R1luTm1WQ1ZnTGtVNTRESHdaZ3k0YzNzQ3ZISzJBSVVqUnlLS25HZklJcC9U?=
 =?utf-8?B?bW93cURvbzJSeFFZd1FUeWtsQVdMQ1lkNmRzL29zNGsyRk01ZHVFbTJEQ2I2?=
 =?utf-8?B?Mkd2VWI0R3RpTjQ4QU9PSUphL3p6QnM5c0p2SGJHOWxsb25FM3J1NmhMUG5m?=
 =?utf-8?B?OGJ0MldSQVpmT2dyYXNWdjZJL1Y2SERSaTBQYm1oRzhJNGdxNjFaWTI1cVJx?=
 =?utf-8?B?eWxJWHRoT3YzOTQ4ZkNBRzl6VXNrN0FRb3BYTVdoZHhnT1drQXZiZDRjOVFF?=
 =?utf-8?B?NzdkQU93MGFLRHVtWWtRSVhFckJ0UkJwdENWd3JvQmpYaTcyWnE2ODVvUXFX?=
 =?utf-8?B?KzBNSzJZeThGTm9RSzJKcXpXeUJDUXpwRmp0dU5vVGViUU1iQ0ZJeXdtOFgw?=
 =?utf-8?B?WTRCV0liUlpzNU9OMnZSOUc0UVpUT2VFWjBETlloMGdtY3JSR1VRQVo1Ny81?=
 =?utf-8?B?TjcrUDFyd0I5QjlhdENNVDc5NnJiSzRVQysrMmlENzh0NDZ1YlVIYlhXTHln?=
 =?utf-8?B?UWk3ZzY0VWhRR2hMR2dvdkFDSVBxbXc4MGhRYVlVdnhkVnhud3hOMGo5YTBl?=
 =?utf-8?B?UUdzUVBFd3phVHZnQ1VQVElzZ040aW41YWlzNHpSMTlJQzE3VVF3NjMxWGti?=
 =?utf-8?B?MllGdEtJRExpQlZHa2YzUWRlQTRQMllFZ1BaYnZUTGtnS0I3TC9SN0lQUGE2?=
 =?utf-8?B?OTVXcUYvWUpUOHN5WlNZM3hVRUM4SWRMZ3NScGFObkVKYmxOUEN3ZFpQVFNx?=
 =?utf-8?B?RzNtYllrQ2gyZldOQ0N0S2diLzdRUmVJVmtlM0FMYzg0WU8ybmtDQjZMMkRt?=
 =?utf-8?B?ZHQ1cDYrZXlFS2FmM1ZEckwyZkMrQ08vTksxbFpNNVBuNTJNS0FDY2k3akJM?=
 =?utf-8?B?RXd3UGlSbFNkNHJLTnlCWDl1a1lWdk9HcXdwMFB6TmtMOUhDVnQ1MHZRaFUv?=
 =?utf-8?B?ME9OeWNVNk5EUUVHeDVZSFBGcERrMkFGVmdZZmVPa0l4dldOb0M1WSt4dlpE?=
 =?utf-8?B?aEFnUUxaV09TRkJFb3k4UG1QYUtWbGZDL2hieDR4L01IQSsvYmtNWHVKb3BU?=
 =?utf-8?B?ZnF0dDRoaVZpQlF0OEdydHl3eDZFSTFOME1vV3ZXZzIzRzhJSGtsRnJOMmM2?=
 =?utf-8?B?WlZ5RmNjR1VkTDFRdU16YzhDbUd3NmwyNjBsTnNmWXA5Y0Y2MkRtTFliQXli?=
 =?utf-8?B?U1BMOUpWckFhUXh5VndlRXRPdEZuZkMvNTNXTFBnQWJUWHNkTnVxTGRFNUVj?=
 =?utf-8?B?ZlpOcXlkeTBsRWlMZjlpRjRJV3pGK09MTGY2Ri9kbGFvSEQ3OTBTR2NPQ3lD?=
 =?utf-8?B?NlNyTFdDUGN4Y2xYc1dyYTFKZGo4U2pWZXdjdWxlVEpjM2FRNHdKU0Z4eEVQ?=
 =?utf-8?B?OHBOc3c4eFYxMkduN3gvUDRJcmtmeDh2RktYNkpaZFlidWh3VHRwNWlFUnlz?=
 =?utf-8?B?L0hCSlVmbDZvRWQ1NUhFckZtQkZJSW5aTWU3cEFZL0NsSkt5MUs2d3FvLzZr?=
 =?utf-8?B?MUlLV252OEZRS2VSZFUwc1FXSDN1R0VjQU9SdWYxQWZ6Vm52YW1hblJuQmtR?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FAA3D67CA9DB04498348992BD85E984@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caf7ca8-3103-4a46-94a8-08dddacc556e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 00:48:49.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdzci825ZwYs5i7yxnXaTQE92/gpc/9StTwbIrQCylXFs85b2p/OOjDRqfr86shCZGUdt4QZXaofxlELyGOrRiNBTL4bFBVPy0pZQxdtBcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTA3IGF0IDEzOjE2IC0wNzAwLCBTYWdpIFNoYWhhciB3cm90ZToNCj4g
KyNkZWZpbmUgWEZFQVRVUkVfTUFTS19DRVQgKFhGRUFUVVJFX01BU0tfQ0VUX1VTRVIgfCBYRkVB
VFVSRV9NQVNLX0NFVF9LRVJORUwpDQo+ICsNCj4gK3N0YXRpYyB2b2lkIHRkeF9hcHBseV9jcHVp
ZF9yZXN0cmljdGlvbnMoc3RydWN0IGt2bV9jcHVpZDIgKmNwdWlkX2RhdGEpDQo+ICt7DQo+ICsJ
Zm9yIChpbnQgaSA9IDA7IGkgPCBjcHVpZF9kYXRhLT5uZW50OyBpKyspIHsNCj4gKwkJc3RydWN0
IGt2bV9jcHVpZF9lbnRyeTIgKmUgPSAmY3B1aWRfZGF0YS0+ZW50cmllc1tpXTsNCj4gKw0KPiAr
CQlpZiAoZS0+ZnVuY3Rpb24gPT0gMHhkICYmIGUtPmluZGV4ID09IDApIHsNCj4gKwkJCS8qDQo+
ICsJCQkgKiBURFggbW9kdWxlIHJlcXVpcmVzIGJvdGggWFRJTEVfe0NGRywgREFUQX0gdG8gYmUg
c2V0Lg0KPiArCQkJICogQm90aCBiaXRzIGFyZSByZXF1aXJlZCBmb3IgQU1YIHRvIGJlIGZ1bmN0
aW9uYWwuDQo+ICsJCQkgKi8NCj4gKwkJCWlmICgoZS0+ZWF4ICYgWEZFQVRVUkVfTUFTS19YVElM
RSkgIT0NCj4gKwkJCcKgwqDCoCBYRkVBVFVSRV9NQVNLX1hUSUxFKSB7DQo+ICsJCQkJZS0+ZWF4
ICY9IH5YRkVBVFVSRV9NQVNLX1hUSUxFOw0KPiArCQkJfQ0KPiArCQl9DQo+ICsJCWlmIChlLT5m
dW5jdGlvbiA9PSAweGQgJiYgZS0+aW5kZXggPT0gMSkgew0KPiArCQkJLyoNCj4gKwkJCSAqIFRE
WCBkb2Vzbid0IHN1cHBvcnQgTEJSIHlldC4NCj4gKwkJCSAqIERpc2FibGUgYml0cyBmcm9tIHRo
ZSBYQ1IwIHJlZ2lzdGVyLg0KPiArCQkJICovDQo+ICsJCQllLT5lY3ggJj0gflhGRUFUVVJFX01B
U0tfTEJSOw0KPiArCQkJLyoNCj4gKwkJCSAqIFREWCBtb2R1bGVzIHJlcXVpcmVzIGJvdGggQ0VU
X3tVLCBTfSB0byBiZSBzZXQgZXZlbg0KPiArCQkJICogaWYgb25seSBvbmUgaXMgc3VwcG9ydGVk
Lg0KPiArCQkJICovDQo+ICsJCQlpZiAoZS0+ZWN4ICYgWEZFQVRVUkVfTUFTS19DRVQpDQo+ICsJ
CQkJZS0+ZWN4IHw9IFhGRUFUVVJFX01BU0tfQ0VUOw0KPiArCQl9DQo+ICsJfQ0KPiArfQ0KDQpT
aW5jZSB0aGlzIGlzIG9ubHkgZ29pbmcgdG8gYmUgdXNlZCBjb250cm9sIHRoZSBkaXJlY3RseSBj
b25maWd1cmFibGUgYml0cywgZG8NCndlIHJlYWxseSBuZWVkIHRvIGRvIHRoaXM/IFNFVF9DUFVJ
RDIgd2lsbCBqdXN0IGdldCB3aGF0IGNvbWVzIG91dCBvZg0KS1ZNX1REWF9HRVRfQ1BVSUQsIHNv
IGl0IHNob3VsZCBwaWNrIHVwIHRoZSBjb3JyZWN0IHZhbHVlcy4NCg0KDQo8c25pcD4NCg0KPiAr
DQo+ICtzdGF0aWMgdm9pZCB0ZHhfdGRfaW5pdChzdHJ1Y3Qga3ZtX3ZtICp2bSwgdWludDY0X3Qg
YXR0cmlidXRlcykNCj4gK3sNCj4gKwlzdHJ1Y3Qga3ZtX3RkeF9pbml0X3ZtICppbml0X3ZtOw0K
PiArCWNvbnN0IHN0cnVjdCBrdm1fY3B1aWQyICp0bXA7DQo+ICsJc3RydWN0IGt2bV9jcHVpZDIg
KmNwdWlkOw0KPiArDQo+ICsJdG1wID0ga3ZtX2dldF9zdXBwb3J0ZWRfY3B1aWQoKTsNCj4gKw0K
PiArCWNwdWlkID0gYWxsb2NhdGVfa3ZtX2NwdWlkMihLVk1fTUFYX0NQVUlEX0VOVFJJRVMpOw0K
PiArCW1lbWNweShjcHVpZCwgdG1wLCBrdm1fY3B1aWQyX3NpemUodG1wLT5uZW50KSk7DQo+ICsJ
dGR4X21hc2tfY3B1aWRfZmVhdHVyZXMoY3B1aWQpOw0KPiArDQo+ICsJaW5pdF92bSA9IGNhbGxv
YygxLCBzaXplb2YoKmluaXRfdm0pICsNCj4gKwkJCSBzaXplb2YoaW5pdF92bS0+Y3B1aWQuZW50
cmllc1swXSkgKiBjcHVpZC0+bmVudCk7DQo+ICsJVEVTVF9BU1NFUlQoaW5pdF92bSwgInZtIGFs
bG9jYXRpb24gZmFpbGVkIik7DQo+ICsNCj4gKwltZW1jcHkoJmluaXRfdm0tPmNwdWlkLCBjcHVp
ZCwga3ZtX2NwdWlkMl9zaXplKGNwdWlkLT5uZW50KSk7DQo+ICsJZnJlZShjcHVpZCk7DQo+ICsN
Cj4gKwlpbml0X3ZtLT5hdHRyaWJ1dGVzID0gYXR0cmlidXRlczsNCj4gKw0KPiArCXRkeF9hcHBs
eV9jcHVpZF9yZXN0cmljdGlvbnMoJmluaXRfdm0tPmNwdWlkKTsNCj4gKwl0ZHhfZmlsdGVyX2Nw
dWlkKHZtLCAmaW5pdF92bS0+Y3B1aWQpOw0KPiArDQo+ICsJdGR4X2lvY3RsKHZtLT5mZCwgS1ZN
X1REWF9JTklUX1ZNLCAwLCBpbml0X3ZtKTsNCj4gKwlmcmVlKGluaXRfdm0pOw0KPiArfQ0KDQpX
ZSBzaG91bGQgY29tbWVudCB0aGUgQ1BVSUQgdHdpZGRsaW5nIHRoYXQgaGFwcGVucyBoZXJlLiBJ
dCBtYXNrcywgZmlsdGVycywgYW5kDQphcHBsaWVzIHJlc3RyaWN0aW9ucy4gU291bmRzIGxpa2Ug
YWxsIHRoZSBzYW1lIHRoaW5nLg0KDQoNCg0K

