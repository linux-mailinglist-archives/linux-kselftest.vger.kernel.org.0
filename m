Return-Path: <linux-kselftest+bounces-31744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B1A9E585
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98583B3996
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC78F4E;
	Mon, 28 Apr 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1rv9pVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4181E871;
	Mon, 28 Apr 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745800903; cv=fail; b=c8NE1B2KDRVaOs9pzqd/lO3Ywyp3eDcUBBiFUjHlS9YCdeNe0RPnrpQuKHgYDLGuv2gY/9PIy4Ly35hU4CYpZ/7EHU2OUfoOsEngS/2LRtZaggWKXlx3klPyFdPW4KgsZaVowJNSBzSW14Patgw+H6ZRzXAntgAt3xPNnjAV3eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745800903; c=relaxed/simple;
	bh=j8tPvRpAl0zyCRcd+AvTSfnRzzgb5BrFC9vMCYDGSEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/BotKI0n6kkFSjHJQLOiwdkUuZ8ELMfNMoUiXnULcwjVoIOi54jpDR5DT94MvRCxE4uOFDKumxVtC269zHjb2exbTRYjw/nwaPJAFNS1D4gYJNSk8VrRfmV1MfUx+/qIKoPUFKXMnhB/1Ivli13e/cj/3G7zylF8OspQ3ZOQnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1rv9pVF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745800901; x=1777336901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j8tPvRpAl0zyCRcd+AvTSfnRzzgb5BrFC9vMCYDGSEA=;
  b=h1rv9pVFsbrwMRxa1U4eHVnoK/C4QIDiLBAZ7s8qRRaLY4oOKp307JIQ
   jegtfUvBmiuIaqNs5cfXRezpsk2PUCKEN69z9/zdrvOOh2KCY9w4U9Owa
   rYmQ2+YbUfQ33lq/hiXBb43FSrQUB04j8qOeFKqPX930j/AWVO5kcRQl1
   8f5F6jGPEPBNyMfyPQOcNdE5/XmS7oSZiAyBOmoOhWrbGsGEt3HnmF4XE
   gOV63Mt9nqIRYebO2Xam7e4UCEqjDGsoqvenXBD6TAXNIEVITPQbF+f3x
   Z1nesnqKZIJBsGICHtgjydBzPwzB2ykB+ScO3rgLKIHKC4UvtrHTQ8DC5
   A==;
X-CSE-ConnectionGUID: Y+hMp280RmCX+AVDnXf/fA==
X-CSE-MsgGUID: l2ggqj2uT7eQMoSzirSbyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47257650"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="47257650"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 17:41:40 -0700
X-CSE-ConnectionGUID: LQil4N7PRdugAyykTWuGcg==
X-CSE-MsgGUID: POqn1DbvQBGM1tkdGc2oLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="138187124"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 17:41:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 17:41:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 27 Apr 2025 17:41:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 27 Apr 2025 17:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGCmCNF0kVYJ8ciMrse2LUmM5PyNOpDGw/8x9td+ESIjzVpqSMZSBbHGRmkltonZi2uJm13Jpv31hSJ2lxymU/oqSx8j90DQi36vQspMXXYrFl+dqyz0L4q0g8HavB8jXlHMBsRLQChUVGaeVOxd6w9w3d5yDpRK2Ps2mUJ++hcP08iV8QCj9jfYyCM5KV1Rg3zVGStTi6cNQCakCOTuqLFzS7NMDgUY7XOXargUFZ2+4hSCCKAddYwsc/oebwDkucmS8pVb65ziX7YIEP0cGwfK1t2bmCN+HCmhzNxFj1SOc4ikQgmc++R3CcRzJ9z0i1Z7tJPdKruqmEjajO6xRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8tPvRpAl0zyCRcd+AvTSfnRzzgb5BrFC9vMCYDGSEA=;
 b=yWYaIXFfuEIaTJK3Jq/oDeuMJoqJEO9OrVHV5527sGOU9JaHijRGy7RWEIfpIVqUXR+ImRCdoGRJagXkWaW+8FrqDZvF5bXpIGhKuFOJSA4T7LGcGoZjP4BcJDY1dmJ2woQbW4t9Asr9YM0T7iT6o92RVVK+5/aJYbYjeEJ8Zlvziy+FzKKinxqFrJRuyOjWvPXmVkA6Cb0u+QmPhyW6L3S53EaSdKgDWMtrIWk+1ysii8xR8J8c+Qidjy/MwXzwAXyUuf/bfOzQtvsUhKcWHNmksImknJ/Xrbe641r/BSot38/4NIq9+F5VBPJMX6BzYVMB+sEUDD+iRqvNZg3ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 00:41:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 00:41:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v2 01/22] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Topic: [PATCH v2 01/22] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Index: AQHbtnBS+nw+C8MhiEejSG/SHyggObO3DQUAgAEwzBA=
Date: Mon, 28 Apr 2025 00:41:33 +0000
Message-ID: <BN9PR11MB52768ABB21EF05E8FF0BD2588C812@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <14781558dbc291e515b5e249535e3c08290a6792.1745646960.git.nicolinc@nvidia.com>
 <ee9d46f2-5953-4ca4-adac-c3e35c9001a3@linux.intel.com>
In-Reply-To: <ee9d46f2-5953-4ca4-adac-c3e35c9001a3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: 954089e0-fc69-4e2d-f002-08dd85ed6cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NE9yQVQvcURIM2IwOCtHdWVva0R5MXlJQ0hxYUJEaCttemlJZlRBdlFsSXdN?=
 =?utf-8?B?bVpWbGtqZHFPWWNielI2ZjBFeCs0Ui9vdU9qY1Q3bE5QQkJMRDYyR3c2bjlu?=
 =?utf-8?B?ZStqcWppN0hRVlZnWXd1MnZIWUQwM09MZHNzNHFrNjlJQzJFOVd3MkViM3Vn?=
 =?utf-8?B?bno2dlNOSm5OMys2c0E1M1dBK3dLQmJLWnJlNi9icForT25RYk9ZUU9DYXRE?=
 =?utf-8?B?RkFLcndQR21rcHczaFF4UHlCLzV6RjNta0l5VnZDOHFYSVp5WDhZV2Z2bk9B?=
 =?utf-8?B?WGtncldSbmpkblNZNHdIYlZEWXFweDF4VFQ5RW03eE82b242aCsrQ3NxZ3dK?=
 =?utf-8?B?dEpwRzJSa0xOTHcrZ0lpTG5nZTB4b1lleTJhdWZpaVV0eUdyMllYTnphNnlQ?=
 =?utf-8?B?R3BSWXBuaHluTnBVbjQ4Nmx6RGNPNE1JVm5DZEFFdlhVcUUxbUV2UURxN1pH?=
 =?utf-8?B?S0p3Mms1S0lWR1F0Mmd6TnBKVHRMTGZIcnF3ZGs3cWY0eEViUU53NDJFVllJ?=
 =?utf-8?B?SjIxdXF6N243QTZQNzQzRUlCV2xHZHh6UTErKzFidXFHcU9ibmV6OWtNcGFh?=
 =?utf-8?B?ZTUzZG8wY3ZvL3dHQi9WQXJpbjhvWUFiQjJLSG44ditQeGYrd1dscVZjck9w?=
 =?utf-8?B?VlBGZFgxR0tGRHhNZkx4NE5Rb2k3NmhqME1CUUkrSkx3ZW5VeE56dEJUbGJx?=
 =?utf-8?B?WTYyemJVWmxEdWs4Qk92Uys3WkVXVGV3dTcwUlUxVjM1YlJYWURSeDUvZWpB?=
 =?utf-8?B?VjF4ZlVEdEJkTkhEdWROdjV0S2grd1hyTDFhK05xd3dBbmdMcnJoOE9UUzN4?=
 =?utf-8?B?Q21sQkRwdCtYNkZDWE1IQU14TlljbHhvTWF5NHFTc3lUU1FRUVBDTENhc0Zk?=
 =?utf-8?B?bFp4ZTlZS1hONFRUb0svM00rL2dlZzVZN3R1Wmw2RGJ4TEFyQ3dMamJJNzlY?=
 =?utf-8?B?S1RBZ3ViMlYyMkZYWW04SVZLRElHN3hua2pnNVF3VlVRSEd6d0xHeXd3ZDlk?=
 =?utf-8?B?eFRUVU1kb3R3blBIZDh4NUUyQThNQlA1QXhOTjJ2RGRwMkpTL1pXR3pNN3Fp?=
 =?utf-8?B?eWNNeFFvZ1BFelRPR3QvZG9KanR1UVppcTVSbVZLS0lYcHREc3VycmRhME54?=
 =?utf-8?B?MEFRV0VsNkdyMm8xa09Lc1BSMTgrcW5wUkhCY0kwVE5qYU5yZ0k0V29QdnhO?=
 =?utf-8?B?QzBadnFhWFJwVUdocU5HOWh3MG5ZT1QxN0lWUVl0U1RsM29INkdyaGlZYWpO?=
 =?utf-8?B?MnBuSWpXTzlUeVpIeEFFcTdHM082WTIycnJiaGNITmtOVGxJcEplMGlVcCt5?=
 =?utf-8?B?S0pEWUhvQm1XQ2QzeENzeC9FNnBTZG1XcmZneU5oSnAyYzdJVEgvc0haRHlt?=
 =?utf-8?B?aFkzTGdrT2FHZHV2Z1hVYTZXK3RvbGkvMlNnSGpoZmVRYTRlZ2F5TEd1ZjM0?=
 =?utf-8?B?KzMzSXVIM3NhK2tobm5xYWVHTzI0bjJYMFFvU1J1QnBpM3M4d25TeDJCd29k?=
 =?utf-8?B?YXYrTElhbmFYNC81Y1lrNTFIZXhYalRDK25ub3dERXEwZE8ySmVhdjZtS3pF?=
 =?utf-8?B?WVpkek9GbURSZ1BZcTZYRmszQ1RaSVdMWmxQWHFrRTNnM2g3dWZqTXdxK0R6?=
 =?utf-8?B?Z1JVdFdDdUtIZTVvV2J4VkZPUkt2R3orRklzQVFvS3AxMXlJYWZocGNHT0wz?=
 =?utf-8?B?QVUvMlRLZ1RsVCthZlZmY0NTT2daSGdDY0d5RnNUVzVWOWIrNlFFaXlyWEdh?=
 =?utf-8?B?VWNMOU5XdGhFVXBJQmplRGZMVHBSZVhTTG9yOGtKV0M3WGJXVkdSNkFQQkZC?=
 =?utf-8?B?TmpCaWphNWVZU0hGZnZjNDk5QTVCYTdDcmxaQVpQZUYzUzNmSjNhclUweE80?=
 =?utf-8?B?TzhlZVZxdTBIYzZodkptQUd3S2FteU9ud3ZhVUU4dlVvOFNGT2lyNm0rYjdl?=
 =?utf-8?B?UUF5cVVjZzIyMGJLMCtnQ2Npem1UUW1xL2M0QUFlQ3VoUmkyckJFQU1pVENt?=
 =?utf-8?B?aG4yOVp3WVJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWtFTHcybE9MdzdKdmEvOTlJcXRVR1NkOWoraWprcjFzL2xKMVE1a3ZkL0FL?=
 =?utf-8?B?dktpK2JHYlAybXBWTERYMTU4VWlSTk1YOXpycUtJSFE4SW5adExYMTU4ejBY?=
 =?utf-8?B?ZjVwYW4wNTlEVUJDUEFxSy9kOWtpN2tBaStocWtBODZFWW4zNWxJbWdHdkR2?=
 =?utf-8?B?TlcrSmhCQzVYZXlVWCtRSHQ1R2tUOVUvenNRWFJITWVrcWJkdWJ4dnUwZDF4?=
 =?utf-8?B?b3d5TGxiOWtQamhwUHdvZ0xJdXdGK1ZqaDhyLzFJTzRXQm53c1NzeVJDWHhz?=
 =?utf-8?B?SmxBRnRWcm9Td2w5NXVsaVptMGx2ZjFpTktROWtVcERqT2hmNzUzdUE3cTBi?=
 =?utf-8?B?dVB1T29oQlNiUy9kWDk1eUp6dzN4Qk1hREVlR0hPVkJFUE84aGZqaEpCUmZl?=
 =?utf-8?B?QzdNSDJQVENqclRGVDk5dnU1TFhqdzNvdllKUlBzSXF1WnlSUkZWVWFhbVBi?=
 =?utf-8?B?bmRCVjRDMEF1b2dBd1ZMU2ptcDdReTRaTnl4SzQzUUJBRDZYMGJkN3Q3dFBm?=
 =?utf-8?B?eFZmTHAvSDhQbXU0WHhpNy9aSVpOLzRCM0VlUHNMaEJwV0tWajN5eWs2ZWxU?=
 =?utf-8?B?RUM2WmpSak5mWDVSYnRKLzh4SWlKSmgzWnEwUXVyYTdCU3Q0WGpGaDRJSFJl?=
 =?utf-8?B?dmdERENPZXpwL1RQUnhhck11NXBsWG1jSTAzSUNYTlhyelBwb2lIU1NiK0Q3?=
 =?utf-8?B?QmkycVA0TDQ2YnBWQ1EzQXJ5WEd6VGw5SGFtTG1JWUtzUGlWN3lDUk44bitE?=
 =?utf-8?B?MnRLbEoxcXBqNzBmbitac0lyS1YveFU4UHYxcDllM0tZeDNGZm1yWlQ5Rkt0?=
 =?utf-8?B?NmJWcTlUY2ZKNEhZRDZYOVQyOVpLWTRIV0UvRThIY2VFaXFLdXpad0pYOVhp?=
 =?utf-8?B?N2k2YXZtUDY4eCtmdWlXUWtaVHhob2IvUnNGMERUN1BYVTQ2YmpCdHkvNDE0?=
 =?utf-8?B?ZXllcFV4SFV1Z016dkRMVy9YZFNBZyt5ZmxYN3J1TERYZGI1ano4eVVjUmF2?=
 =?utf-8?B?TlNhQ0FYOENvYVNKSnRaWStJdklueFd1OW9WYzQzNm11aVFwN3lNTDNmWXBl?=
 =?utf-8?B?aGVFeUwwVStHcFFXQ04xNDlhSTIwaklmV05GNzJTVmdvUDZ6NHdVTTA5Wko2?=
 =?utf-8?B?eU9ObHVtcjd2YThWKzdPRmF3NGJ6QjBKZHVrTFBGc3Q5Tnd5V3dTUm5wd3d2?=
 =?utf-8?B?UXU4RkFqaUFMRzFGNXR3bUExVFFRUzEvaExJVG1aSzhrZmYvaUFQa2k2cVhC?=
 =?utf-8?B?djZFbExwNzdTUVY2RWlQeTR4Zy9wWWFlUnpaS2QrRWNEVkE2SlE0TjJONGNW?=
 =?utf-8?B?M2RGUUF5a2llQ09VOXdlS0tCb3pDa1BCS2JvMzJsbXpnOGJlOC94TXRKSlRt?=
 =?utf-8?B?WWF4M0ZwMkNsZTNnekJMRXgxWG1WdEFlazFMUTI4ckFQSlJBbUg0K1N5clVQ?=
 =?utf-8?B?ajdkWXcwWFZHRjhPZmZMUjNLS1pYdlJMUmlOMjlBVHErM1FSQ1E0SHdScThq?=
 =?utf-8?B?WnQ1UkdKNU02aGsrQ1d1QVZNNUN5eUkzSDJRYWl1UG5kQkpNU01yRGhocjlL?=
 =?utf-8?B?QWJtZ0ZzM0FQUS95cTdhRlNLTHF5YXU5ZUJLNEdTeG90QUE0bGd5QWovbng1?=
 =?utf-8?B?N0hmR1NPWTBTWHRBTGpIcmYvUkxhWGFvOUhDSEFvRWR4c0lHQXpZNHN0ZEFS?=
 =?utf-8?B?a3VTNTZaR05kQ1pXZnFRaUttdjR1RHpJTWhrMG1SZkRCSkVEQVJnMUZnM2c5?=
 =?utf-8?B?M3Nrdkpka2lxYTdlUEZjYmd3RnpZVkJNZURzSXRvNDk1azJwN3hHZnBHa294?=
 =?utf-8?B?L2R5SWI3REZ5eUVQQXJoczZBbVBSYXdKbTVqNkdVcEdyYnY4RE0zSEQ2NGFE?=
 =?utf-8?B?Z0lRQ0JxaVhSYUVlQnVYNlJ6eGpkdVRZZjI5TkQ4ekFXeGpHaDVYUEVoZE0r?=
 =?utf-8?B?WU1xSTR0RWMyRGhCRnRZZFNGeWxCMDIzaGFnS0VEOG05a0ZVNlZqckY0NXd6?=
 =?utf-8?B?Wm5CZ2RGa24zMHViY0F2eGwwdW1kUkdqVitKeWFNb1ZJQVE4Wml3K3ZsU1lH?=
 =?utf-8?B?R25sc2R4bW5XK3NOQnUweEdGZFBEZGNpdkJmL3BJNFFNK1hQUG5aeXNuNGFP?=
 =?utf-8?Q?wWC9sqrjVN/rIDkLVAUxUXDOg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 954089e0-fc69-4e2d-f002-08dd85ed6cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 00:41:33.5891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZM0T4obHURIsqOm59t/PTsP2QKforUtqLQoyT9cv/fb4ZobBRH/1vcb3BZUJ4L6xOwPp1jSXRIZWvVx2SAq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDI3LCAyMDI1IDI6MjQgUE0NCj4gDQo+IE9uIDQvMjYvMjUgMTM6NTcsIE5pY29s
aW4gQ2hlbiB3cm90ZToNCj4gPiBAQCAtMTIwLDYgKzEyOCwxMyBAQCBzdHJ1Y3QgaW9tbXVmZF92
aW9tbXUgew0KPiA+ICAgICogICAgICAgICAgICAgICAgICAgIGFycmF5LT5lbnRyeV9udW0gdG8g
cmVwb3J0IHRoZSBudW1iZXIgb2YgaGFuZGxlZCByZXF1ZXN0cy4NCj4gPiAgICAqICAgICAgICAg
ICAgICAgICAgICBUaGUgZGF0YSBzdHJ1Y3R1cmUgb2YgdGhlIGFycmF5IGVudHJ5IG11c3QgYmUg
ZGVmaW5lZCBpbg0KPiA+ICAgICogICAgICAgICAgICAgICAgICAgIGluY2x1ZGUvdWFwaS9saW51
eC9pb21tdWZkLmgNCj4gPiArICogQHZkZXZpY2VfYWxsb2M6IEFsbG9jYXRlIGEgdkRFVklDRSBv
YmplY3QgYW5kIGluaXQgaXRzIGRyaXZlci1sZXZlbA0KPiBzdHJ1Y3R1cmUNCj4gPiArICogICAg
ICAgICAgICAgICAgIG9yIEhXIHByb2NlZHVyZS4gTm90ZSB0aGF0IHRoZSBjb3JlLWxldmVsIHN0
cnVjdHVyZSBpcyBmaWxsZWQNCj4gPiArICogICAgICAgICAgICAgICAgIGJ5IHRoZSBpb21tdWZk
IGNvcmUgYWZ0ZXIgY2FsbGluZyB0aGlzIG9wLiBAdmlydF9pZCBjYXJyaWVzIGENCj4gPiArICog
ICAgICAgICAgICAgICAgIHBlci12SU9NTVUgdmlydHVhbCBJRCBmb3IgdGhlIGRyaXZlciB0byBp
bml0aWFsaXplIGl0cyBIVy4NCj4gDQo+IEknbSB3b25kZXJpbmcgd2hldGhlciB0aGUgJ3Blci12
SU9NTVUgdmlydHVhbCBJRCcgaXMgaW50ZW5kZWQgdG8gYmUNCj4gZ2VuZXJpYyBmb3Igb3RoZXIg
ZmVhdHVyZXMgdGhhdCBtaWdodCByZXF1aXJlIGEgdmRldmljZS4gSSdtIGFsc28gbm90DQo+IHN1
cmUgd2hlcmUgdGhpcyB2aXJ0dWFsIElEIG9yaWdpbmF0ZXMgd2hlbiBJIHJlYWQgaXQgaGVyZS4g
Q291bGQgaXQNCg0KZm9yIFBDSSBpdCdzIHRoZSB2aXJ0dWFsIEJERiBpbiB0aGUgZ3Vlc3QgUENJ
IHRvcG9sb2d5LCBoZW5jZSBwcm92aWRlZA0KYnkgdGhlIFZNTSB3aGVuIGNhbGxpbmcgQHZkZXZp
Y2VfYWxsb2M6DQoNCj4gcG90ZW50aWFsbHkgY29tZSBmcm9tIHRoZSBLVk0gaW5zdGFuY2U/IElm
IHNvLCBob3cgYWJvdXQgcmV0cmlldmluZyBpdA0KPiBkaXJlY3RseSBmcm9tIGEgc3RydWN0IGt2
bSBwb2ludGVyPyBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdklPTU1VIGluDQo+IElPTU1VRkQg
YWN0cyBhcyBhIGhhbmRsZSB0byBLVk0sIHNvIHBlcmhhcHMgd2Ugc2hvdWxkIG1haW50YWluIGEN
Cj4gcmVmZXJlbmNlIHRvIHRoZSBrdm0gcG9pbnRlciB3aXRoaW4gdGhlIGlvbW11ZmRfdmlvbW11
IHN0cnVjdHVyZT8NCj4gDQoNCkl0J3MgT0sgdG8gbWFpbnRhaW4gYSBLVk0gcG9pbnRlciBpbiB2
aW9tbXUgKGZvciB3aGljaCBJIHJlY2FsbA0Kc3VjaCBkaXNjdXNzaW9uIGZvciBjb25maWRlbnRp
YWwgaW8pLCBidXQgb2J2aW91c2x5IGl0J3Mgbm90IHRoZQ0KcmVxdWlyZW1lbnQgaW4gdGhpcyBz
ZXJpZXMuDQo=

