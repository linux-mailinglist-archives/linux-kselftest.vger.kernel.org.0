Return-Path: <linux-kselftest+bounces-15802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686895916B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F490B21089
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B671C8FDB;
	Tue, 20 Aug 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsFtpo2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBB1C8FBE;
	Tue, 20 Aug 2024 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198250; cv=fail; b=exyMcHbtJlWRcfGeWUHuK8cxeuDRkzuxzSSziN8fV0VnBc3Rioe24H5fhEzHnX8bZkM7LwVrEbtOmT0KssJUmP3bSaPiTfKkJaZFvzJCcvKdhJb8KL06/I9KCq5CpgSsKIqq7ZRn9Pmsj8IdM1wGxmq9OlhjeC1a4zAsO7fpKwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198250; c=relaxed/simple;
	bh=pZxxTeygkrM4kSv1ZmZp8qpLg/RCw7SaSiVhk9BZLPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EiA3D2dz9sDHVG4dWXu3QLmA1gZYl/u3WS3VN4hHv/7RCcU4bP3KeYyXBYe1/pEDqHO3KNgE+KMd7ZAZKPDyPtD2NZA++0FhbpIcz2FcWhkO+9rwtWkB6/NQtplJ0NGLpx0MNn8pNrYvMSCUfH9a1BC4DE0n28TUDWDJTjPKetI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsFtpo2P; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724198248; x=1755734248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pZxxTeygkrM4kSv1ZmZp8qpLg/RCw7SaSiVhk9BZLPA=;
  b=SsFtpo2PmJB9yUh/2ZNr1mhULJQr11dNsHsl79+aRmFl631kpRsRFb5o
   /AGCsJbt4CyHH3KzAZvS/4zOg16T3riEHrnJVAgCto6FEWnIFRGG/tcLj
   W1F7oVa8IOPLuVyfwS9q/3N0n7UVftq7skSAmpDEh0ylnxMytmljWYsMC
   +poyWxrD/WrRj1D6dsRC8eaO8+9RUHNE9X0lnfYlT6Eo69LoNRnSf9MzG
   QW5dtDrNXA06K/eoV/1Lym7IHhSIStfABwAH8j8CpofTfv5UK6K6aoc6w
   Sg/NEXWiB7iMj93/m+TR730pWMp9g3xeuIQDknKdAnAhpXyFUYLPTIKH4
   w==;
X-CSE-ConnectionGUID: zmXtGk+NSd6l8NO/xfGJCw==
X-CSE-MsgGUID: Y00B9cyOTwWjj0saWc69UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22720402"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="22720402"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 16:57:27 -0700
X-CSE-ConnectionGUID: 3o1NVfQ4Svy4BlFVsGWN/g==
X-CSE-MsgGUID: ouG55CQ2SamdDqnTC3t9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="65600907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 16:57:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 16:57:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 16:57:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 16:57:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 16:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDKyMWjM6pV+ms/T4Na5Me8YIZ83GGR27kTDYLHvSNCFWLtBvKZykWGU4+/Mns4hMa3kA1fliY/BRz90lX5CyBJEeYhnP2CmPAGrf+QJ78tg1PUM/ns9B7a8dv106CBJjG4VrF/FXBcACSSBu6gqDMxS06YYtIpxUcjChqRh21l7rCVngmBqLMJpQc6r1qXw89OW0CGAXsD89iSy9iJ1ifC+BfL5hJyIkZfZrx8U+PhFAgXWW5XLOAASWGA5TNb+xgio5uDaarVDFMP3IUDqILna43YAdgQR1n5tIYPOo+JKIQCW31BGHPzOK4X+QwfdsoygiyYncqOGD6GWcyYtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZxxTeygkrM4kSv1ZmZp8qpLg/RCw7SaSiVhk9BZLPA=;
 b=vF7nc+/6+75c1sMpOwUtt1guJPKFA+9a2juQ6hCS9/zR24YCJErY3xtuEh6BRCfLwx3SCgJatAhvw7Ae/eLkwLHuXk6zABhfjvv0HocRdWox4YBZAhVw0IM99eJpgjgYMMAV1zV4VqRwm8rDBudhWm01X52P0fwTnTdHDqrWSo5M0XdL04VQTU6b5mowhnIG4DhJFwpsplfIKZ2i4s6vL+Gv543DEtS32IRcLLg15PskP/mWvCM1PAy5m4g1HpvlJt22VahdZTM3qwIDbWRBSzcZxvIrzNertDIoqdshzUMKk9Q4Vf4PxFtiISvKnrM9PF+FDP9T47SMSn58NU2ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 23:57:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 23:57:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"jannh@google.com" <jannh@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "wilco.dijkstra@arm.com"
	<wilco.dijkstra@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAA==
Date: Tue, 20 Aug 2024 23:57:23 +0000
Message-ID: <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
	 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
	 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
In-Reply-To: <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7604:EE_
x-ms-office365-filtering-correlation-id: 90ddedfb-3de8-4a35-a4b7-08dcc173d5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWhBK2J4ZzE3aTBvTEZRcVNvM1dvZTB0WGwxcUJxRUU2akE0dEs5N1Q5V3lL?=
 =?utf-8?B?WTBwR3B1blBNeTJLSDFCWFlqbEtmcVJFZE9UYjNzdWo1S0I1NWVqK0RGNDdY?=
 =?utf-8?B?SHpnZ2EvTTJKbXN5YlNUUG9LbWFlNXBtRVNLMGlFTXlNM2NQWVhMYi9KN3ZI?=
 =?utf-8?B?VkFFeW42SEhhUGk4cXVGS3cyUndHZU80YnpScktnYkkycHlDK1NyWFA1NVNm?=
 =?utf-8?B?RzN1bC95L2d4TXhhYlpROXE1Wjh2ZW1PVVpJa3NOMXcxVVRvcGE1VC9nbVpK?=
 =?utf-8?B?Nm1xYXpBS0diNmNoNW8rTTdsQzVSV1NhMUdGYlp4MW16Zm9GWURMQ3BGRUor?=
 =?utf-8?B?VDBOWGc4UjZzeDR4LzRSVlZWcGc3dUhnWU5BdjVyazZDTmJxaUpsdzg4RlFj?=
 =?utf-8?B?bnQ4L2RROGVVYnJZNk1ZRjVnVjZXT3VWWG0zMUdQNzBRbWRheU5TV3A2S2xL?=
 =?utf-8?B?WjJZR0xqK3E3b0dYK0dlWTdnTy9ySWVCV3ZxV1ZFZUdUOVR3YW1PMXVxM0th?=
 =?utf-8?B?ZDVGcmFsMENDTk1iL2NzSTVtZDU5VUhOVmVkRlljZHpIUVZPbWNNVVYzbm1l?=
 =?utf-8?B?SDQ5T1RTaTcxc1VYOExqdEczTkdEbjcxSEZvWVJwaTNRdVRZUWxBSUxoS1d0?=
 =?utf-8?B?d215c24veWJBSC9mNGxOb290Vm0xV211R1dKbDFDNkZOTzFLU2hRMEZuNjdO?=
 =?utf-8?B?WUVhTk5KOEpMeUxXY2xLeS9qSnBmS1Fha0ZkWU1XbVBFQ2l1K2Evd0srVFhv?=
 =?utf-8?B?RTd6S2xSMlV6bUJrSDF6OVFhbFd5TEdrTTF0emFkWUJPSndYTzFDMkFtTU5u?=
 =?utf-8?B?Q1VFSTBaYWRYOGZuaGJ0WldqMmoxRkN0UVRFVjg1RW5JZnlERS9Cc0tDNVdB?=
 =?utf-8?B?b3ROK2hxbkVxQTFadzl3QmFlc0pkL1hWZmhwNGVWRTBjc296b3RpUUphaHpG?=
 =?utf-8?B?dmZweVV0NXVQS0ZacnRXZmtqcWpsQnE5S3JMWkJ0TWdwalZ4VUtqOFBmSGJa?=
 =?utf-8?B?clAyVGxDME5GUEVQekxkbEpFZmM1MFc2OEhqRzcvbFd1RVBnZ1dUMlQwU2VD?=
 =?utf-8?B?bVl1ODBOc01ZbkZwWUpTeXRLa2tvMVdxOWYvaUNjZVlqQXY1TW1DUnJBRHJn?=
 =?utf-8?B?a3lQc05GUlBqVk1UdWV3aFBXZERqekwzODFNWk9DQVdxd2tiTjFOWUlidWlT?=
 =?utf-8?B?OElqNFFmRjRFbUU5NnZhdnN2YzNNVEtwOW5abkw5ZjZ5NnZmeHFnQUhKNG1Z?=
 =?utf-8?B?dXJuZUlaQ0lFZk82TUJid2tjclRzUkEvWitzbUJ2RUFzeGwvdU1odmZKV1RY?=
 =?utf-8?B?U2tjUFJ3ODQ3SzhhYjZvN2lPT0FZODlXaWNYS1V1OUt6TEpVL0lXSWhaanhT?=
 =?utf-8?B?QWtNWDNjcE9FQTdTSTJqL1o4blhYclN2bkQ3ZXJkenM5Z050c1RmUXdqeWNG?=
 =?utf-8?B?OHhvOXhwRWRKRGN6U2dITzJZSGlWNy9zL1FycE4yR0lUWDUybGN1NXdzU0FO?=
 =?utf-8?B?THBCRHdFNlNOTklQaGxzTVIzdlZlNlJSVlNpdWdVMXRXOXI2VzEzaHlJc1FM?=
 =?utf-8?B?Q09pakJtUFFUMnFhSk9mSTBWVkJXeXYySDlxNVd4U0UrN1MvajlaVDFBQ2FH?=
 =?utf-8?B?eVhOMDNmN0JUcWxVRWhMMnUzYU5EenlWMXc0dm92Q25jYWpXTHdOTTdPeTJq?=
 =?utf-8?B?cUZ5RmVFZGZRWkhNVGE1bXN0cmJudUxFNVU2SVJyaWFXSWV3U2ZQb1lMT1gx?=
 =?utf-8?B?dktFU1VoY2NEQWgxQklseWE0azZMQnVlU2piMWx3N09wQ0pTL2tYNkR4SVF1?=
 =?utf-8?B?VGE3cnN1MmR0eXoxUFlPaitlWElIbVdTZXhXY1ppQU5RVFRUZkxJbFRUNndm?=
 =?utf-8?B?c0FVNk5GMmQrNHFKWmFmS0ZjQTc1Q3M4dFZvYnExT1J3RGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXlGNHJEeEtnSnFQak56TWtvNjhoZlIzR2hGekNuZFFDVFBSbExRSExsd3cv?=
 =?utf-8?B?bUp0Y0drM1B6NnE4NUJhTDB2cEd6ODhqUVNKUlZ3aFZXUHZ1cTcweGJxSWI1?=
 =?utf-8?B?S1lhcURycWF4bHFiM3dQVVJ5VVJOeThVNW1VK24vOUQ4VjU5UDF2Y29iczAx?=
 =?utf-8?B?Q2plSkpBQWY3VmxDWjcvbUxpbE9TSlNlZkEwOE9WOHhtRDhPTVRYejNwTXcv?=
 =?utf-8?B?OU03VGpCZkthbGN3bDUzeFozemlNb3k0Wnp2aHVqVUcvR3ZmMm9JZlQxcUlz?=
 =?utf-8?B?ZTNRQW5IcS9jUHlTY1NPUzBSUzJvQjEyYUlIcUVtKzNJa0NpczR1NXJvVGhs?=
 =?utf-8?B?UDNIMmRpa1EwWVYrdEtNMDdvSVlkZGdpS2tJSFJRQlZ2aFNaYWFCbUN6Unhw?=
 =?utf-8?B?bzdCaCsvTk95K0hqY3pzRURCQ1lBaEs2UmVyR1o2SWY3YjJlZ3pwblQwVFVh?=
 =?utf-8?B?RDBNMkJpdUd1RXRvYzFCU2lQQkgrOEl0NTA5aEYyUFVBNnAyT1FOV1NDQzRG?=
 =?utf-8?B?SVZ5d0VVazNYd0U3VW45MWI2WGQ0dFptUVlsWXJiVHQ2a2RMUEZFbFpwaHpB?=
 =?utf-8?B?VkpmUXBvajBrbS9WTE5HVjd5YnBaMTdJUDFtN2x0dG8yYjZqdGcrWEFFMnNW?=
 =?utf-8?B?dXRrUE9XTkhCbEJxNnBVSGphMVNuenZpZXJ6Y3Z2Z2xoTlV1clVpSTBNendn?=
 =?utf-8?B?RmMybk1FUWcxOFdNK3RHbkdkSkptQlBRZHI5ZzF6MERYNUlwQUl0SFZwWFdT?=
 =?utf-8?B?dTBTL25oYnFnb3ZETlFWTkFGQ2h3UVpsZjNKT1hqd01abUZlc29JcXlSVVZn?=
 =?utf-8?B?OVVUTXgrbUEvVnFGS0NLUm9hOVl5Um5STHpYNUFiTjhsUmR0dEgxWFRiQXdW?=
 =?utf-8?B?M0xjMVVJTUVIQnRxT0QzRmVrSGRKWHB4ZitqeWh4VlZwTDdYeU1PdjhOck4v?=
 =?utf-8?B?aDJ1Z0tZUXNTaTRpbFkzTzMvem5CQ3JNQU5xZXFzSUpMUHo4UXd5eEYzSzY5?=
 =?utf-8?B?SCtFY2VQanNiWFZSTFgvV085UVYxbVBkUVR6aXQ5MnRpNU5CdXoyZytJcDQw?=
 =?utf-8?B?Rnk4V1labVNEQXBmUEJEOXFaSUNvWHJtM01JRDZMdFN1UjltdVFHZUpGSGZK?=
 =?utf-8?B?S3FwazFvSzhrOHhpbmhVVEN4YkpMWElyTU1tOERrVDVKMkVEMXFKMzNsUmRh?=
 =?utf-8?B?UzJOdFJ0K0s1bVBsc2Jxbllpd1FWQXN6WkhoME1WVFNHSkVJY040WUpkZXhu?=
 =?utf-8?B?OGNWalhwZWxWVGdjMTA0eEt1VUt0K1NpNmdKcGN4M2k1WHRvK1pvOVFjdE9U?=
 =?utf-8?B?dWpBYnNPQmxxZ3h6TUwzSWZRdW9hVXVoaHRObFp4TFYvTjBmY2ZKc0VLZVlt?=
 =?utf-8?B?UjFVdmlxbDhNZ1dReVZJcmg3T0IzaWtNZWVWazRLamJHVjEyTGxWaDhWejhp?=
 =?utf-8?B?TWlURmZvMTJRTmZ3bzExYnZ5bVhhQmRjMXExZ2MrZGVIaGRFWlFWRHpHKzJZ?=
 =?utf-8?B?eW43T1RDdEZFRDJUOGtZbHNOWVFGU2tXNnpqbEloQzBJeHNtK1NJVFplLzRC?=
 =?utf-8?B?UDlxcFBVSWZmc1hQaGQzMWswUWRZRysyVm1yS0g0eVJGVnhXL3ZFa3g0NUZE?=
 =?utf-8?B?WGMxRHRuRkl5cWFXUVVuenQ0cHNjZWtiYU5VZEozQy9pd3Jjd0wvVEg3NU1J?=
 =?utf-8?B?clN5Wis0V3JxL0hyQzE5Q1Fwa2lxY1h0T0pTb0VySUplUzF4MTRVV1Q4cE13?=
 =?utf-8?B?Y3FZZDltZld5eFJjZGxqUzBqdDBMRDNXWFZEMXovT2doVlRPN0dLOE1DbU13?=
 =?utf-8?B?a3o3UVphQUVrRGxYYkNHbW5USGgwZ0kvaW84MU02WXFKcUxtUk52aHErOVJr?=
 =?utf-8?B?QWdnbGE5QVQ5aG5rQ28vdHdWK1pDQzRrVjNMTFozUTJDcXBIa1Evbnd2S2w4?=
 =?utf-8?B?UTNjZWkzc2Y4Qmp4d3ZPaXNjV2tOQm1DZ0R3M3g5aGRaRzFKZEF4WExQNzF0?=
 =?utf-8?B?QTFJcE8wcHI2N0JzMTI3a0VLeFJCdlZyMDkxRldZVno4c0tScHZ4dEVIRzVj?=
 =?utf-8?B?SGxBRWNSRG9LVGFoOFlyNnhMTC9HQi9FS2RoOFRxL0MxVHJNemt2cTdPam9s?=
 =?utf-8?B?UVNRVVNCVVpCTFQzZEE5VGREcDg4NEVxbU9uK0xnYmF4WVBraFhNYzlMb0t3?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3F6CCC1340DF6469E0FC89D770BD40A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ddedfb-3de8-4a35-a4b7-08dcc173d5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 23:57:23.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jG1U0mC6/su3gk7GFyydhAtMypnDqsuUJFH2K4NPcV7xIErpch+iTG/24izXNx8WcjLR9CgwfkC2UiFY6HlNYQkWadd2G3qcckmeG1W1LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDAwOjM0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFdoeSBkbyB3ZSBuZWVkIGJvdGggc2hhZG93X3N0YWNrIGFuZCBzaGFkb3dfc3RhY2tfc2l6ZT8g
V2UgYXJlIGJhc2ljYWxseQ0KPiA+IGFza2luZw0KPiA+IGl0IHRvIGNvbnN1bWUgYSB0b2tlbiBh
dCBhIHBvaW50ZXIgYW5kIGhhdmUgdXNlcnNwYWNlIG1hbmFnZSB0aGUgc2hhZG93DQo+ID4gc3Rh
Y2sNCj4gPiBpdHNlbGYuIFNvIHdoeSBkb2VzIHRoZSBrZXJuZWwgY2FyZSB3aGF0IHNpemUgaXQg
aXM/IENvdWxkbid0IHdlIGp1c3QgaGF2ZQ0KPiA+ICdzaGFkb3dfc3RhY2snIGhhdmUgdGhhdCBt
ZWFuIGNvbnN1bWUgYSB0b2tlbiBoZXJlLg0KPiANCj4gSSB3YXMgZG9pbmcgdGhpbmdzIHRoaXMg
d2F5IGZvciBzeW1tZXRyeSB3aXRoIGhvdyB3ZSBzcGVjaWZ5IHRoZSBub3JtYWwNCj4gc3RhY2su
wqAgVGhhdCdzIGEgYml0IGRpZmZlcmVudCBzaW5jZSB0aGUga2VybmVsIHdpbGwgYWN0dWFsbHkg
dXNlIHRoZQ0KPiBzaXplIGZvciB0aGUgbm9ybWFsIHN0YWNrIGJ1dCBpdCBmZWx0IG5pY2VyIHRv
IGtlZXAgdGhpbmdzIGxvb2tpbmcNCj4gY29uc2lzdGVudCwgaXQgc2F2ZXMgdXNlcnMgd29uZGVy
aW5nIHdoeSB0aGV5IHdvcmsgZGlmZmVyZW50bHkuwqAgSXQncw0KPiBhbHNvIGEgYml0IG9mIGEg
aGVscCB3aXRoIHBvcnRhYmlsaXR5IGdpdmVuIHRoYXQgYXJtNjQgZXhwZWN0cyB0byBoYXZlIGEN
Cj4gdG9wIG9mIHN0YWNrIG1hcmtlciBhYm92ZSB0aGUgdG9rZW4gYnkgZGVmYXVsdCB3aGlsZSB4
ODYgZG9lc24ndCBzdXBwb3J0DQo+IHRoYXQuDQoNCkhtbSwgc28gdGhlbiBvbiBhcm0gdGhlIGtl
cm5lbCB3b3VsZCBsb29rIGZvciB0aGUgdG9rZW4gZG93biBhIGZyYW1lLiBIbW0uIEkNCnRoaW5r
IGl0IG1ha2VzIGl0IGV2ZW4gc3RyYW5nZXIgQUJJIHdpc2UuDQoNClNIQURPV19TVEFDS19TRVRf
TUFSS0VSIGNhbiBiZSBvcHRpb25hbCAobm90IG9uIGFybSwgYnV0IGNvdWxkIGJlIGluIHRoZQ0K
ZnV0dXJlKS4gVGhlbiB0aGUgc2hhZG93X3N0YWNrX3NpemUgdG8gdG9rZW4gb2Zmc2V0IGJlaGF2
aW9yIHdvdWxkIGRlcGVuZCBvbg0Kc29tZSBoaXN0b3JpY2FsIG9yaWdpbmFsbHkgc3VwcG9ydGVk
IGNvbWJpbmF0aW9uIG9mIG1hcF9zaGFkb3dfc3RhY2sgYXJncy4NCg0KQlRXLCBqdXN0IHRvIHRy
eSB0byByZWR1Y2UgcG90ZW50aWFsIGZ1dHVyZSByZXZpc2lvbnMsIHdoYXQgZG8geW91IHRoaW5r
IGFib3V0DQp0aGUgOCBieXRlIGFsaWdubWVudCBuZWVkPyBEaWQgSSBtaXNzIHRoZSBjaGVjayBz
b21ld2hlcmU/DQo=

