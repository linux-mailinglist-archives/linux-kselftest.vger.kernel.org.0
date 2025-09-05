Return-Path: <linux-kselftest+bounces-40854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079CB45D12
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EF27AAD74
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC131D73F;
	Fri,  5 Sep 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHuNARpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5331D731;
	Fri,  5 Sep 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087616; cv=fail; b=tFVNtG4RtHmVZk2lOGM3MFfVsphmbQzmNGOHQIz0nbhBzc2ifmuQvZbMu9WwLK406os2JGnK6nkrquyaYta7kNCTkHUseLLTlfSLgcq1hMMSjq3ihYla7WwffZrbnwpyMYLIEzkWRIyImP2TIT0m7VtBkkiYE5IC75ITU6USJew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087616; c=relaxed/simple;
	bh=ErrpFQ9n9LWJ/llbMxDky742nJyrgcPUXWaoIlKaBo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Etig0iarMxX7JOg/j2F7m27cPcs8DSVxyE3cB5+AtsGBDpH8ko0OIcNSDXiiEW1MVRvGB4OmD+OYPUydzMCWXOkCXiGVA9rcX278w8bPTExDoElQgHTp3AGhzz852C8dWdFtj+2N2ykNRkr+xVrDaaxEeKuuVrPjWvHlhO6xXkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHuNARpp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087615; x=1788623615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ErrpFQ9n9LWJ/llbMxDky742nJyrgcPUXWaoIlKaBo8=;
  b=PHuNARppg5BOsbzPF1qDxsyKEiI0EMRQVBMVeSz5+p10EI7hkwkw0wui
   DgWCRUbsoEUbHu1ltortGYkLAdOqhZxd+l7z5MA0BXsQhg6lGQSnEDHCR
   tcvpTOcHX89pM9j/BjJQ7LXirvsEth0jO79efzeNF53JWfiZuxPfdEnyU
   FY09H11jKerrkiD4O2D3WUj5TE93upOB5/rgzq8EQOGfITKR3MQlOSgF3
   +R2u5KDSXBil7C27RU3Obd+CVYisd1xstJwnock8KsNobtYxSoloHl7UI
   mRuC8r6o+qtJj4tPa1s2bVojGPrqEsEyB4+aNWvu8TYLfu21XdPJUI4O4
   Q==;
X-CSE-ConnectionGUID: HoAEumjHTkS7IGcTULm+Jw==
X-CSE-MsgGUID: WROyJBbiTx+2V40GptJ5hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70818771"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70818771"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:53:34 -0700
X-CSE-ConnectionGUID: udzZQa+IR7ua18/ExhHl1Q==
X-CSE-MsgGUID: y9aNQlc3RXi1fW+0nD/eCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="195852556"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:53:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:53:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:53:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbSWHSJddcEe0jbKIDiUiGf7HL6DJyue3crB2VR8twoY5grLf+uWcejnAlyfhaBlZ12KBIxBDmbB5cBrIgnVNrgs67/O4OeOqnHcC2Vayq6245NtbvE9VVtG5Q1rJNb76FnKVaPnuwVpUKTXYdepd6vBL8Z/v8DJys2tW60pKYE1sjZ3I3uPOp/yyYThvVLHmnGtgF0/0ZZWwDE5SlKULaDf717DCefV/18VngblILoYsaZ2pwltZk8UkPPabnX4phtjI27PrycA+7d8LCoWIxyn8BVw1ba6Q+jOGhJ84lRGkhk3cLA81u+YX/Il7sneMH7LpZz1ILz+gtGQJfqxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErrpFQ9n9LWJ/llbMxDky742nJyrgcPUXWaoIlKaBo8=;
 b=xIBBwRCrOB50tv06EVATg+X/TtofMODFoX5oVJO8J43uyptPJ5f+KkAZ7jilXkxCXIcYVBg0PXSpp831qWXe4BShq7if+uSj+wsJcvgfIQWY1kjwApfkDmGQv9Kje3Ewgg2EfgTxoRtK5d7758TFJ5paP5oMYBwH6J9HbvDW803od8dm7d5nSBxLmGfZijw5EGKiZoS7gcdjAWZlXErgtPt6yT6t7bq5di08L1KvAzkqX0greYlc3VS57Mqgp8NFRr42P655oed8kEtn2lQBVNEdz51hTpRbPqtdbX3oYmBbUqHePm9Y5r9N9Hb6AZablLZhSA4mldmTzaIdqEQ9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 15:53:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 15:53:22 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "will@kernel.org" <will@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"jannh@google.com" <jannh@google.com>, "yury.khrustalev@arm.com"
	<yury.khrustalev@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHcG/OOY06t2CIsjUO8Cf9WafJZD7SEub2AgAAF+gCAAALLAA==
Date: Fri, 5 Sep 2025 15:53:22 +0000
Message-ID: <f374415d5738b8c69031cf57f27f4351045993d4.camel@intel.com>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
	 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
	 <20250905-nutria-befund-2f3e92003734@brauner>
	 <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
In-Reply-To: <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB5991:EE_
x-ms-office365-filtering-correlation-id: c3752b82-5596-41f8-20d3-08ddec9457d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YlczZHFlS2JrbmJ1akNVdXNCV3NHcjI4T0FJY0pXVWdxaXZJVmdpdGNrcFk4?=
 =?utf-8?B?MDZZVTVHUCt6dGh2dWdmTVhhOWt6SVFxMHpuQkh5RWZZZWxRaUxuMkpiaWU2?=
 =?utf-8?B?U1FlVVFGWFpkVHhudEgwcHdWcE1WUWlRQWFwYThmODRBdjZkZ0NFMUg3T2s0?=
 =?utf-8?B?QnhkZVpoQ2MrRG1uaE5qMlVtSWQwc1AyRU1OYkF6djFoUjFDSm5kZ2xEalpo?=
 =?utf-8?B?WXVBVkxJdExGMU5JS3dnV3lDZjcrRzFTY3M5VUhJRFN3aWpXbWcwcWw2dWgx?=
 =?utf-8?B?OWlSbEo2OFJvclJqb1c5R0VrTHExL0l2ek03U0tTTmF3SnZsa1JnMCtpa3Vl?=
 =?utf-8?B?bUpSdDBIVHorMk9TYWJqbVNrYlV1cUdnL2orbVNpaFlONVlaWWFFaEFINHFR?=
 =?utf-8?B?UklVNmpRdjlMNUtTYTZQc3IrQms3akJxdGVwRFpvbEp5bnhuU1ZEVXFOVkYy?=
 =?utf-8?B?NU1Ick5FQ1Vhc0x6aVc4dlFsSzhhRk9OS3JoZTY4djh4YVhWUGNJSVZzRmQ0?=
 =?utf-8?B?QUNFckI0SlZkT2diVVVwaGpMaWdHckl6bEgwdVJqRlhiK0orRG9weXlCdVVk?=
 =?utf-8?B?R1RkOUZ1RC9KUzF4dWE3Sm4xVW1XQmt2d0VFc0Q0UE1FeWllY290Yk1LQ2xr?=
 =?utf-8?B?ejhveW5tTituN2lYYzNhaDVjYXIzVjdGaW9WVll3eXVCWkprZDVJeWNMM1Iv?=
 =?utf-8?B?Zmo3MWltbkptV0RUazdGOFkybVFvQVo0eUhoZFpWVmJGTkFyOXFlMG1hT2J3?=
 =?utf-8?B?RE1LRDJVMGxUdjFyZVh6MGtwdjJ6ODBFVitnbHVGcEs1UjhINXhKRXMyLy9l?=
 =?utf-8?B?OVRuTHhHeTcydUNNclJodDVyQ1JKODJXK0drQm1CZDVEZGhCOW94cWJsZGZL?=
 =?utf-8?B?eXZGY3pNdEtpeGd0eTczbHZnNUF3eXJKWVFvNEFRVm0rSVFXc3lvSnFEaVNm?=
 =?utf-8?B?ZitpQlR0MklkTnZzZ3pyeEFaeGlXTmQ0U3Z6OHQxMkRXNmpiNnd5RDRPY1Mv?=
 =?utf-8?B?WU9qYU8rSG9vS1V0MGJjQWdLTEtFaXA0bWtTLzlvL1dvZTJxTy9UdlNlb1Fp?=
 =?utf-8?B?ajErU29nU2FzdDI3a3l2RVluMENtUTVkdGhRV24vRGtiOTNyK09idEVIWVJ6?=
 =?utf-8?B?R3NqWEI1bW1IV1lGNHNFK0RjalFvZldGelhVNm5xNzRJb0JZY3JmNXhzOWpw?=
 =?utf-8?B?alJOYmdIaTJTOGptS3B3SEt4NU5LK0R5UnVHQWFWa0k0VlJLdTZscUtaZWpD?=
 =?utf-8?B?MkF5UHllY1MwbW9VVzFsZ3ZXaXdSbklmdWZtNU5oNFp0VXd5c0g0U3cxYVUy?=
 =?utf-8?B?L2p2Zm4rZXhIblp2YlFGRmxuOGV3MStYbkxVa0lrOVY2RVZoV1pPQlNkamlB?=
 =?utf-8?B?VkVVN3hQN1dxU0FmSXc0SmtNWTU4anM1Z2U4WE5hSE8ycGZ0Z3hLWUNETXlW?=
 =?utf-8?B?blVBNWZNait4d2x5SGhzcUdCa1RYbk9iMW1EVGdPYXIzaERHY3d6WHhwZE5X?=
 =?utf-8?B?Z3NmWmhEblhOZDR5L3lmVnhzaUtTWEp1L3RkU1ZYa3QxbC9HVklzOUVRcVdt?=
 =?utf-8?B?Tk04akVndm1sR0o1b250MjRrRE9oSmZzaWZNZWtnYTNwSE81SVpVQlcvNjJW?=
 =?utf-8?B?dkR5MDY3Y3ZJNHNlVkRpMzQzRE9IMkRJbm9jL0tkSkVnUVlzZzdhd3NiY081?=
 =?utf-8?B?dVhpaHREczBCMk1XbW12Wit6V04rSFgzWTJrQzQrQURRcDZ1S0dsN2NYQmpr?=
 =?utf-8?B?SFZ0c0hpb3Z6bGdmdERGMzRGdEJrN25XZDgxVFJtMUVDQTRjSUJNdnVmelI4?=
 =?utf-8?B?V1dGTW1JZm9LWi9XazVpREtDUnBvUmxlMFZOdWxFRzBjeC9jRG5Hd2FRSCtM?=
 =?utf-8?B?Vm1pUHh2V3VKTkRaaWYxQVp4V2NJbS9HTE1hdUFZeWp1RlZEMHRNOFl4SXdQ?=
 =?utf-8?B?NXV1VTAvK0JTNEhZZmxDQ0RLVi9MSHUxaHd1TWhuT09FV21UYXMyR0hVcDdZ?=
 =?utf-8?B?UEdiNW51OXFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlNRTNmdm9EWlZsSk5teDBCVlhRRDZBdDBYU0xRQnRWdHhwWE16dmRCR3NS?=
 =?utf-8?B?RkVVTmZvS1pCcVFyN0JxUUswODdEdTRlRDRwWWVHblVDcWdjZHBtTTdjSXgr?=
 =?utf-8?B?UEdIQ0xOTUQ1czlLYm1ncWVXUUtmdmlmdUp0Q21zNGRLeU14aHFVbVF0UFJl?=
 =?utf-8?B?TWVnQ2E0SnRhUmNMTFFYN1Fpc0lQNVdXZWg1bEFZYm1DWVZBRXA0RGZnU1Av?=
 =?utf-8?B?emEyc3ZCRFBhWWsxT2QzVWFONHk4N3k1VnZBcExmWHlRaXlWaTh6K2VucEht?=
 =?utf-8?B?eENBdklCNTlQTTRqVW0vbUJWYm9udnJhd1gzYkhRcVQyM2pRTU9hQ2Q4YzBZ?=
 =?utf-8?B?M3RRNWNGUlpIdGdMM2Y2dS9DMmQ0SzUyaVdmeDFwSDE1ejVLYWpVOFpsaXZy?=
 =?utf-8?B?bjF1TmlnbmR4dU96S1NyZ0ZqQ1RtTGZZU2g3MW55cWlYQ3ZPVzNlcDVqaFly?=
 =?utf-8?B?MzAvTThDMkp6TkhNOThyRHF5eVE0NEtHc2I2WWVtZkg4WDlsQWY4a2htZnBM?=
 =?utf-8?B?QXdTNWhzVW5rQjF1bklxdVkyZXRkYnBxVEFmd0x5MndSVmM2T1BzbTF6QVFM?=
 =?utf-8?B?V2JaY09JNXdsYmM1RHRiK1g3UnMra0l5RWcyaGFCWnBUdzJnWSswbHhXNUtl?=
 =?utf-8?B?REp4TVcrYWk5U21uRE56WmQzNnQ4VklxMXJjVUM1WWlPY2dPUkQrdjRGeGtP?=
 =?utf-8?B?T0FhQzl2eHI4MGhPUnhuZjg3NVgwQXhLYmFHdko2U0IyU2w5S1A2L0c1cTZF?=
 =?utf-8?B?RnR5SnkwMll0Vld0WXZYWUhDL3ZaZGIwZlFTTGRkWEI1cGE2YWJLY3BZWmE2?=
 =?utf-8?B?T3ZkMmZHamNNRU9ZSjFCN1Uzb0p1cjBsRzd5Uzh5Sy9kMXowRlREOXhwVDJ3?=
 =?utf-8?B?MlB6UkFMbWlUU3U0VFBULzZRSFRlYTdPQkI5Zlp3OVI3RDNkVzhOdUdpK3R1?=
 =?utf-8?B?QlVKL2w1UkVQMmw5OVpzd1Y3WXI2TU40YWJVRThNZUJlRDZLZWR0YTFHUmtO?=
 =?utf-8?B?MHloOEpuUXlORE5KbU15bGM3WFd4a1FCY3RWZmllZ3BWMnlscXpWcjkxL3RM?=
 =?utf-8?B?VmpWb0xiQmZEa2VOQ1U0enQwek85aVJ2Q3cxbFdnNCtsb0V4NStLL3RMNldX?=
 =?utf-8?B?cG4xUDdjN0RKMTRhamluelpaK0IyVXRFSDhvQW9seXE4LzZ3aGtQZEtJRlhk?=
 =?utf-8?B?dXpuSmYzb2Z3YmJUOUFGSEJ0T3d5UWhjYXczUDNFS1FWeTZaQlJ4a2xaNHhZ?=
 =?utf-8?B?OWpLbmx5SkhKTmZLTjNPQjhnc1I4NnFSRlAwcEF5bjl3K0k4UG1MQ2xOR01v?=
 =?utf-8?B?akh2TlZGUllkYjNXb0diV3Z2cU1Nc29IUWc5b0MwSTcrd3JJbzB0Tk0yZTdw?=
 =?utf-8?B?K2doSEhCeW9GSnFWODA5UFhZNlRwMnlhNjdvV09vMWkya3J4RHpSbUYzbmFQ?=
 =?utf-8?B?NEcrMzFZQVNpaTVTMlpncWZDNGlQY1FCUDZad0hLMHo2bkNraVJ4NTRIUXI4?=
 =?utf-8?B?OVBDZkIwemJWcDRVcFpLMkY4cHBMblVyTm00Z2trdWJmODlORE5TdXdLWXpO?=
 =?utf-8?B?K0VQMjhvMTEzVEV3akFONG1XMjdoeFUyTW5NVDdUWnN1ejFxMmd6bUNNZlVQ?=
 =?utf-8?B?U0NUZWRSQXB4NGRUYllQWlJHVThpZVIrVzdIOG1rdURERS9uSTJaRGhPQjJ4?=
 =?utf-8?B?bFQwZFl5b1lHcTU5SkpiQUtGODhjbld6VTBWNGlYZU5XN0wyL1BPUHk5LzlF?=
 =?utf-8?B?NEdpN044OHU3YnFEdVBXakF4WGpmV2tpTUl4a1FVaGxWalIyZUlYRVUyd1NG?=
 =?utf-8?B?bGFMZ2p4bmVwY2MrUVBYQ3dWenhwUkdma084Z1ZYUkUzTEhEcHhEbmFrRXYz?=
 =?utf-8?B?VXBuSnB5RFpQTzhLcGhuK3RKVzEvem0vVDdqOUZQNnVjNm10RzgrdTNzZ2FF?=
 =?utf-8?B?UlVKT1pPYjJMNzBDZGtTRDJUU213ZjVGT2F2VVNnektsRVl0RzRITUc3clk0?=
 =?utf-8?B?T1BGZjVlMWVXQXVVeEowUFZtTU5QMDNuWkRWcDdWcGV6NWxhRktvOVhIM3pU?=
 =?utf-8?B?ZDZnWlFaczFPQ2cxbnVqTmowNlkydDdiQmhWdW8zR2xMU3l5eHFkNDBTRWkx?=
 =?utf-8?B?My9aRHYzVCtrYUhEK3crcEFxQ3cyUklVQ1dqcHVBYzVaVGIxTmdrRlExam1m?=
 =?utf-8?Q?7PMbFjGt7GViGbeAZxy0ViI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D52E0BAFAC9C3A44886849197E33B2E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3752b82-5596-41f8-20d3-08ddec9457d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 15:53:22.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiraNINafYqRDh+ttxN3G6r85RDQ4NBeQ3qr4LXsB3PWEYRmAsMjPl7OV+Bqmj+ebpQO45yanGo3shEDCka/tLbwGqtRCGDlspU4E2qFG1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA5LTA1IGF0IDE2OjQzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIFNlcCAwNSwgMjAyNSBhdCAwNToyMTo1OVBNICswMjAwLCBDaHJpc3RpYW4gQnJhdW5l
ciB3cm90ZToNCj4gPiBPbiBUdWUsIFNlcCAwMiwgMjAyNSBhdCAxMToyMTo0OEFNICswMTAwLCBN
YXJrIEJyb3duIHdyb3RlOg0KPiANCj4gPiA+ICsJCS5zaGFkb3dfc3RhY2tfdG9rZW4JPSBhcmdz
LnNoYWRvd19zdGFja190b2tlbiwNCj4gDQo+ID4gSSdtIG5vdCBzdXJlIHdoeSB0aGlzIGhhcyB0
byBiZSBuYW1lZCAic2hhZG93X3N0YWNrX3Rva2VuIiBJIHRoaW5rDQo+ID4gdGhhdCdzIGp1c3Qg
Y29uZnVzaW5nIGFuZCB3ZSBzaG91bGQganVzdCBjYWxsIGl0ICJzaGFkb3dfc3RhY2siIGFuZCBi
ZQ0KPiA+IGRvbmUgd2l0aCBpdC4gSXQncyBhbHNvIGEgYml0IGxvbmcgb2YgYSBmaWVsZCBuYW1l
IGltaG8uDQo+IA0KPiBJJ20gbm90IGh1Z2VseSBhdHRhY2hlZCB0byB0aGUgbmFtZSwgaWYgeW91
IHdhbnQgdG8gcmVuYW1lIHRoYXQncw0KPiBwZXJmZWN0bHkgZmluZSBieSBtZS7CoCBNeSB0aGlu
a2luZyB3YXMgdGhhdCB0aGVyZSdzIGEgcG90ZW50aWFsDQo+IGNvbmZ1c2lvbiB3aXRoIGl0IGJl
aW5nIGEgcG9pbnRlciB0byB0aGUgYmFzZSBvZiB0aGUgc2hhZG93IHN0YWNrIGJ5DQo+IGNvbXBh
cmlzb24gd2l0aCB0aGUgZXhpc3RpbmcgInN0YWNrIiBidXQgSSBkbyBhZ3JlZSB0aGF0IHRoZSBy
ZXN1bHRpbmcNCj4gbmFtZSBpcyBxdWl0ZSBsb25nIGFuZCBpZiBzb21lb25lIGRvZXMgYWN0dWFs
bHkgZ2V0IGNvbmZ1c2VkIHRoZXkgc2hvdWxkDQo+IGRpc2NvdmVyIHRoZSBwcm9ibGVtIGZhaXJs
eSByYXBpZGx5IGluIHRlc3RpbmcuwqAgc3NfdG9rZW4gd291bGQgc2hvcnRlcg0KPiBidXQgdGhl
IGFiYnJldmlhdGlvbiBpcyBsZXNzIGNsZWFyLCB3aGF0ZXZlciBuYW1lIHlvdSBwcmVmZXIgaXMg
ZmluZSBieQ0KPiBtZS4NCg0KWWVhIHRoZSB0b2tlbiBwb2ludCBoZXJlIGlzIGtpbmQgb2YgaW1w
b3J0YW50LiBUaGF0IHNhaWQsIHdlIGNvdWxkIHByb2JhYmx5IG1ha2UNCnVwIGZvciBpdCB3aXRo
IGRvY3VtZW50YXRpb24uDQo=

