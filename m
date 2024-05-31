Return-Path: <linux-kselftest+bounces-10977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E568D56FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 02:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FE8B23AC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 00:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35915B3;
	Fri, 31 May 2024 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+XPWx+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4DEAC0;
	Fri, 31 May 2024 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115654; cv=fail; b=nO0eO6/HJmpld3gjMc1lVb2kzHUYSYCPqNLcsQDntYbBa60NH8t9lcW7bvEi8HYOfFGbnSDfv7LO9TYjUNsuXVDXO9OlUfBOZ3yET3ZxgBEF+NvvtOQhQBAVVFIopDAu3lB5rTjh/EEqFLxn1z4qCXz3ne6zc1DqE6fYqMVw9rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115654; c=relaxed/simple;
	bh=irrdjYbai8zopap8Q/cs4mpXwBod4evTBHauWmoRMZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJO9+X1hrob/PtuZJhxHmOtsJnHcoHbPsj3ALbICCS/M6hoF7pAplsTIhbtI8/1Zq8gwJqiZ0zbl8dYRpWNr0sJHOxYhm0vAcBhpbB6upRGhrsMl5sTNhiLmkthZAia7QZtygIIu1YwT7L7rFhmY6QaxyaSLlMeEmE9CtH/SZIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+XPWx+s; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717115653; x=1748651653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=irrdjYbai8zopap8Q/cs4mpXwBod4evTBHauWmoRMZ4=;
  b=R+XPWx+sAdU3tooj84MJsvxdvNDZ1tZx8b0p6jhIrdNNftaxkgZpMxeh
   JtVXHBBMFRpRyJiLEpPz+xOTDxOTCQSpk5GNpseBx7vUGBMOcNk6vHonA
   7SABnFY5thWKmIELTW/J+9ZH96SZltE9VP2dgyKyYLF+HYWsdd6AkHJw8
   ldhMB6fhBmp039WhMTkKHWZ6NUwZDhZVpmIs6Wlm9bSEk45qjUII5mLd0
   6WQcNogCnwdLuXwG0ND9RwB8dyFyMolOsYhkFi8qTIMFaU/98dZ/gm/jb
   KuxMs4FXjbPby2W+S67BMWatzv3q2nldHHyF+im+xRJzCQVFoFIpjF3J2
   A==;
X-CSE-ConnectionGUID: OTaRzyZsRsW+p3tXKeIEIw==
X-CSE-MsgGUID: 9Rcvp2JLTYiiQmzkkJOwDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24277571"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24277571"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 17:34:12 -0700
X-CSE-ConnectionGUID: tMJC5Fy4QPS0+44BNg9o4A==
X-CSE-MsgGUID: PqdUe9dEQKGipo+N5Z8I1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35992556"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 17:34:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 17:34:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 17:34:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 17:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKk5lOoI0piFsjr28i04z67kYSFGHtkviyCaKOLNtMJCgvlqkeWMc2IbQSYYTZcsOHx0nUbrDMfJktrwHZ4lS+boa0ruTMA4yVaRdP0cIYYR/fuRJVei84N51ooeXq3drx1YGB149dDOxly+JoYO1W/aNEOCbIwQqiN+g+5e9rKnESkKvBTxHbWfRzW8UZRDAG62YlU3jkYc+oZ9wOrpRjo7MR1JrAdW322G960dgDCmMCQYZ03xWFD3GEFKNp4RvrG+yFvJjfCvCy8QpHdFDKHR+4akWWjx3tBVLb7bGtUquQCpO5RYacig8UAZnj2BASBWYCBWXZWfb1OmZ5KlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irrdjYbai8zopap8Q/cs4mpXwBod4evTBHauWmoRMZ4=;
 b=OhSDT5VkTq1tNfn9FICsKciOd0t+9OXueyTm+u4kW5VjCy2ItetiwOtouJnu7Gb8MC0dFHYwY/aw8JYKHvuSkecl4aR0+mA0FzAVipOjcqsRPR7JuDOiawCJYHqQWB3IShK6KWOyGHlIPZKyVHEZKjFrCGRln8FalDEo9Jkn3fBVoUZSG5KcrtVtxbKRtP49pQxFknkERqy7skf7oEhm9rPL7nfS9yJmoS3+EW7F8MFtoekOMdqOarS3yPgp27lbW6AEFMkNYor+kFGCOA2h5y0j8st/g0pNkZ9sSU87tvZWYO3HsGrMhGgiS07tAZJr0y2Wa2pG4wFMEtEqhvzxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 00:34:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:34:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: RE: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Topic: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Thread-Index: AQHaprmme8fjFWvJ30CJk2uljzCiTbGwftaAgAAI17CAAAN5gIAACvBg
Date: Fri, 31 May 2024 00:34:03 +0000
Message-ID: <SJ1PR11MB60835941880FC77E1B1E9FEFFCFC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <SJ1PR11MB60833CF8BD209555A5370299FCF32@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <992cd5db-1cc8-4238-879b-8ef0406edc33@intel.com>
In-Reply-To: <992cd5db-1cc8-4238-879b-8ef0406edc33@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4838:EE_
x-ms-office365-filtering-correlation-id: 7b095f80-2343-4c55-3f55-08dc81095f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Mm1rc0gwMmVoYytkMTVvRUpSdk1RalRZUHZ3SGI1OXNIcU13OGJaZjVwdWZ3?=
 =?utf-8?B?R0pxZGFETzZuOXZJVHhEb0pCRmxhZzkrK0QyWWdhT0cyQ1lxeHNySFlYZDU4?=
 =?utf-8?B?YWJiVGVnM1RuMHVWSzZ3aEIyR2dNcGhsQ2I0aTVESVNMQzBSQUxZclRoVFdn?=
 =?utf-8?B?Ukd0RTNJYTV6Y3d4WGZ6WWloTWw0UUV0dTFSTVNJTlZHY2FGdGFTV1N4b3N2?=
 =?utf-8?B?aUtQM0dnQWg4SnpRREpkM1RPUFdKTFJnazZOY1hFNlF4alMrREJmVi9heExm?=
 =?utf-8?B?MmNlL3NpemVLRzF2cGNIQWJIMGFxOHNaUWNSMWVPbC9wcXVIZkJreW9jRTRt?=
 =?utf-8?B?YzFQUVZ1Q0NJemNTV3JucDRGL3dYTHZqdzZIUE5mTTN4L0FuaGdwaHo0b2N4?=
 =?utf-8?B?dE42SVFYcHl3bkJXZ1lDMWFrNmMxci9QTE5UOWFiV1JoQmdlb2pzY2pYMW1G?=
 =?utf-8?B?dXI2NlhNTERlVnliT0RBSjdDVXc4N2E1cnI0dnNXNktzS2JKL2NleURHUFZP?=
 =?utf-8?B?QWxRSU4xVTZadEp5MmpzcTFUTTBOMUNjekw5d2k2aU5qYXNlQ3I1VXB2TDNu?=
 =?utf-8?B?V29wNGwyU0ZHcUxpTXRyUWc3aHhkOUMwbHFTbTRlL1gvYW5ZbFIwTUVXOUJv?=
 =?utf-8?B?aTZYQTU3WnY2SEg5NE12dHVYc1RkRjhpVCtnZENGekhKVFdhS1Y1WHVmYnhU?=
 =?utf-8?B?V3h6M3d3eVdLcjNMU0U5TnJIRVN5Z1JXcXp5Wkp6bFozQU1PamR3dTRXK2hj?=
 =?utf-8?B?OU1Ea0hNRVhGNkd5MGxsOFREY3BRcE01a1pOc3gyN1FBUTVNQ0pkRmM3VFFY?=
 =?utf-8?B?OFNnVXhwYWRuVHlmcTdvWHVnQS9JUVlRR1BPNHY4Zk9vLzNNOTc3cjMzMU8w?=
 =?utf-8?B?N0FlWlh0Uk9oOVdlYkp1c0ovQjJGTmd5eXpSRnRTSURHY1R2cWxkZ3RoQ2RV?=
 =?utf-8?B?UWdtRkk0TEx3alRXMFdCczVxcVdEOFpzTmdOYjNZekV3NTQ3aHZOTUdrOFNv?=
 =?utf-8?B?UTFXeDR0Wmk3eW05SitBaXpWbFdXQzBmUHJoN2d3L0lxQVFPbC9uTnlwT0Vz?=
 =?utf-8?B?U3BDZTNNc2dNUVpVMUNScjNJcmJDcmROeFI0ekRpL3VUVG1ESGNieWRoNkt5?=
 =?utf-8?B?NHlxOEhKL2dibUR0NDRUVzlITnpXZUh4dlBYbm5IZWdNYXNGb0VUN1hxT1cw?=
 =?utf-8?B?VjgxVXhXdStCV1A2YVJtZkNMc2pIUmhlN0h6RFhxYUw4aGxVTGovWUQ0bFZs?=
 =?utf-8?B?VWZZOXRXS3RZTS9aUHhkR0x3cmNBVlVzdXQ5WG1mN2RhYXN3UnM2cEpNbmRk?=
 =?utf-8?B?TDZOcnNMVlAwc2lrbCt3d0RGdlZadUN3NW1xSi9UWXp2RDdpNVVuZnJ2V1Jy?=
 =?utf-8?B?bm1xQlRNTkN3Q0NVMFR5SWxQSG5TSC84bC9BMVZlZlJOa3VYc29JSWk1ZnQr?=
 =?utf-8?B?dlJMMFVMZ1pIWUFQNXhlNlRwUGphemNnY1ZRRVFWaVE4WXVCY3hielV2ay9p?=
 =?utf-8?B?RjFwTWJlcUdXbkN2dHlsTkwvaDY4cWtNVG9LZTVTTUVGNkp4MFN1WUIrbEVp?=
 =?utf-8?B?Q0J5SjU0SHlhTnFSMEEvd2J4YWxnUksvS0N3L0MwMTlMOHhuMHpaSmZRQVRY?=
 =?utf-8?B?cVdkN1FidXJmSENjbFczS2wzcGhPeXJISUtaL09KU1hmV0JEREZZNEhwRk81?=
 =?utf-8?B?Y2FrNWhlSm55aTZYdVJpNVc2eU5aRFF0dThVNFdLWitwZnVvZjVvbDJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDlsQ3NUQ01OUjBNRnNTTnN3alJrcHh5YUNuMHJpb0wwRHhzdERDYTQ3NjVM?=
 =?utf-8?B?eW52S1M4TlJMenNBWDdTTTlVNXl2OHlpbUdMTHcvYmJFL2RaSDlhOGZnODZN?=
 =?utf-8?B?VlRUWlUwODYraTdCUDR5ZldtZjVLYklPVDFaa2tFNS9TZGV2VmRTbklLMkQ3?=
 =?utf-8?B?bUdDdGxVQWd5azRtbmNxOWdvalgrL2tOTU5jeVJjR1VndDBuUEtTRklvcVVY?=
 =?utf-8?B?cnZrdkdJZk1JU2ZqQ3lqVHZOcFVROFpBUVE1cEtZQUxsQ3Fmd0pLR2lSQmNi?=
 =?utf-8?B?T2NTalhoR1VsTjdMWWV6WXRCMmEvVVU0UGVrZXcwRHNENFhRR2RCd3pTdUFs?=
 =?utf-8?B?QTlMb1JoUEljc1NWZ1N2MlVBbDlxUEVpQVdzQzVPSzFmS2RLSmJhSkdUTHVM?=
 =?utf-8?B?MDFObXhoU3luY0tBZmRFUUFPUEtnTlpLYWpZdkp2V3BDM3REL3hFbGROa2RJ?=
 =?utf-8?B?MzhMUVArcE5MRGM2TmpNUmF5NVlDRXkyd1pWaFBoeXNmSU9kQkt0ekdjdkVs?=
 =?utf-8?B?c09rK080RTRsNTBWNWgrbG1uOHZFcTI2a0VOQ3JJY1FjWnZQYTNhSmZiNmJl?=
 =?utf-8?B?ZWQrS2JYTnB4Q1JjNHRKV0MrMnBQVDlqa2wzVmZTVndTRW9wMWpVV21IemlP?=
 =?utf-8?B?UXpCVXpDbXJWMkQyMnNxdkdCUFJuOFkxeFI5M0RZOG14T3Nyb25UWGUwM1lR?=
 =?utf-8?B?ekhZVEJxRlN3ZEN5Z2Z2N2FMUHlWUk0zODUvMGtMaE9oblNLWS9kalVyY1NN?=
 =?utf-8?B?b0xFM3crS0dobnRMeFovMUNwSDJrRTVzWk5kWDR3dG5Na2lBZy9RZUtycGlO?=
 =?utf-8?B?K2xSemVSaTJLSFdXYzA3NGRhMm1iTks0anBZTElYOVFwZ1RLYkdQSGU5cWlL?=
 =?utf-8?B?THpzY2lZWWJaekpZbDRrOVZIQ3ZXUWZocmJlN1Jocy9zWHVpVjhyK3pTQ0c5?=
 =?utf-8?B?Z0pPVTNaZUJmaGJmZ3NmeDMrNm5HM3NSRGlpM0ZHM1l0b2NhM0k4b21uZ293?=
 =?utf-8?B?c2F3eXNZc1ZnMGVLVWVvRG5sdGlLY2JqU0RpV2d5TW9BU2dXb3ZUNVNocUJG?=
 =?utf-8?B?NDlrM1VaNnhTM0hXNW96Vmt0eEFwdlpSdjN4THRXcjdYVFpHNEU4bmhvcUVI?=
 =?utf-8?B?NGdESm83NENtY1NOR1FhODRkMlZ1NW0zUW1zK0luMWdnQ3BRaEdFaExDL2hL?=
 =?utf-8?B?ejdlcElwYU9UMUp0VXdsWnpOMHNFb3MyZW8vR1p0V2JVM2pQTEtHell2ODJr?=
 =?utf-8?B?aWZRY25Eb2dWTmhWeUpTSG83Q0ZQbUdoNkJzdGpTa05hczBNYVpGY2I1UWtN?=
 =?utf-8?B?ZnYwNFRUL3FvSU56MExSQ3MwQVVUK1dRM1dVT0RnQ3VmTnE5YjlWdVpZdjlT?=
 =?utf-8?B?ak9zKy9qZ1dSZkJhRW5xY2h2ejVuYnFCS01mUXNQNTczeG5QT0s5WFlBWVBG?=
 =?utf-8?B?dFhsM3BCYlZmb05qYUcxRWt3Z3lDVkdONW1mdmxrekxTVzFiM1ZjQWtKaS9p?=
 =?utf-8?B?QlVnNTcvdS9ibGcrT0kvZ2ZHVzZoSUdJSkJDWGVCZXdvTmpOS1pSRWQ4QVJi?=
 =?utf-8?B?U1FLQWlIUHRpdk01NUY1U2doWTJQOUFmYTRZZ0JtSDIzbEZqTWVaSXMyNHFo?=
 =?utf-8?B?QlJpTi9GSzE5UGRPajNFekQ2NFBpbC8rbkRjdStVRmhmZ2RmNnI0cVNMVy94?=
 =?utf-8?B?aUc5MzJNWG9tdk5Vak1ZT000TDJIRVJFTjArZG1BRTFuSUZmS0lTWWRTK3Fq?=
 =?utf-8?B?eEhSa3dpMEhUNXkxaXcwQTdhWU1VekFlOU4yL0lIbzkyL1EyRk9hcXE3bmEy?=
 =?utf-8?B?eWRrYWR2Mzg1V2dSSXZoNkx3SEsyZWVIRTRBajR6VjZUTEcwK3FCVzlqVlF0?=
 =?utf-8?B?aU81dlBTVE52V05sQ2ZQemNjVFFjUGVwRWtFYUtuWi9JRWgxYjZvbWhBYjZD?=
 =?utf-8?B?RzkxWE92aTAxcFJjZkIzd2E2L25tc3R5Q1JCc1lWL1o5d0hIL0UrY1VmcGpj?=
 =?utf-8?B?cHhKOVFCZDhOSkRHVndzU1dOTVkwVFg3NlFUS250eVNsanBYY3EwSTVyN3p3?=
 =?utf-8?B?Nk9GNzQwTGJJeG9xVmVKWEFkbmpDck5YWjRPRG1udDRxa2w3ZFBWYmt3TnVz?=
 =?utf-8?Q?hzlHBxwevdEXhzKFWBYi9N+ZE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b095f80-2343-4c55-3f55-08dc81095f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 00:34:03.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZcNH1lYnadvUylIeK97HDDfiEMlG/PnoCuTQjUHC+1e9uFJZmg3HWB89Po9orGm0msiMtBlShQ7HzPEjaswlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com

PiA+Pj4gV2hlbiBTTkMgbW9kZSBpcyBlbmFibGVkIHRoZSBlZmZlY3RpdmUgYW1vdW50IG9mIEwz
IGNhY2hlIGF2YWlsYWJsZQ0KPiA+Pj4gZm9yIGFsbG9jYXRpb24gaXMgZGl2aWRlZCBieSB0aGUg
bnVtYmVyIG9mIG5vZGVzIHBlciBMMy4NCj4gPj4NCj4gPj4gVGhpcyB3YXMgYSBtaXN0YWtlIGlu
IG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIGFuZCBubyBsb25nZXIgZG9uZS4NCj4gPg0KPiA+IE15
IG9yaWdpbmFsIGtlcm5lbCBjb2RlIGFkanVzdGVkIHZhbHVlIHJlcG9ydGVkIGluIHRoZSAic2l6
ZSIgZmlsZSBpbiByZXNjdHJsLg0KPiA+IFRoYXQncyBubyBsb25nZXIgZG9uZSBiZWNhdXNlIHRo
ZSBlZmZlY3RpdmUgc2l6ZSBkZXBlbmRzIG9uIGhvdyBhcHBsaWNhdGlvbnMNCj4gPiBhcmUgYWxs
b2NhdGluZyBhbmQgdXNpbmcgbWVtb3J5LiBTaW5jZSB0aGUga2VybmVsIGNhbid0IGtub3cgdGhh
dCwgaXQNCj4gPiBzZWVtZWQgYmVzdCB0byBqdXN0IHJlcG9ydCB0aGUgdG90YWwgc2l6ZSBvZiB0
aGUgY2FjaGUuDQo+ID4NCj4gPiBCdXQgSSB0aGluayB0aGUgcmVzY3RybCB0ZXN0cyBzdGlsbCBu
ZWVkIHRvIHRha2UgdGhpcyBpbnRvIGFjY291bnQgd2hlbiBydW5uaW5nDQo+ID4gbGxjX29jY3Vw
YW5jeSB0ZXN0cy4NCj4gPg0KPiA+IEUuZy4gb24gYSAyLXdheSBTTkMgc3lzdGVtIHdpdGggYSAx
MDBNQiBMMyBjYWNoZSBhIHRlc3QgdGhhdCBhbGxvY2F0ZXMNCj4gPiBtZW1vcnkgZnJvbSBpdHMg
bG9jYWwgU05DIG5vZGUgKGRlZmF1bHQgYmVoYXZpb3Igd2l0aG91dCB1c2luZyBsaWJudW1hKQ0K
PiA+IHdpbGwgb25seSBzZWUgNTAgTUIgbGxjX29jY3VwYW5jeSB3aXRoIGEgZnVsbHkgcG9wdWxh
dGVkIEwzIG1hc2sgaW4gdGhlDQo+ID4gc2NoZW1hdGEgZmlsZS4NCj4NCj4gVGhpcyBzZWVtcyB0
byBjb250cmFkaWN0IHRoZSAiQ2FjaGUgYW5kIG1lbW9yeSBiYW5kd2lkdGggYWxsb2NhdGlvbiBm
ZWF0dXJlcw0KPiBjb250aW51ZSB0byBvcGVyYXRlIGF0IHRoZSBzY29wZSBvZiB0aGUgTDMgY2Fj
aGUuIiBzdGF0ZW1lbnQgZnJvbSBbMV0/DQoNCkknbGwgY2xlYW4gdGhhdCB1cC4gTUJBIGlzbid0
IGFmZmVjdGVkLiBCdXQgY2FjaGUgYWxsb2NhdGlvbiBpcyBhZmZlY3RlZCBpbiB0aGF0DQp0aGUg
YW1vdW50IG9mIGNhY2hlIHJlcHJlc2VudGVkIGJ5IGVhY2ggYml0IGluIHRoZSBtYXNrcyBpbiB0
aGUgc2NoZW1hdGENCmZpbGUgaXMgcmVkdWNlZCBieSBhIGZhY3RvciBlcXVhbCB0byBTTkMgbm9k
ZXMgcGVyIEwzIGNhY2hlLg0KDQotVG9ueQ0KPg0KPiBSZWluZXR0ZQ0KPg0KPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDUyODIyMjAwNi41ODI4My0xLXRvbnkubHVja0Bp
bnRlbC5jb20vDQo=

