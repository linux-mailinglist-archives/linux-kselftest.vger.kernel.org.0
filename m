Return-Path: <linux-kselftest+bounces-15807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701F95924A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 03:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EA7B21A85
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 01:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDE2206E;
	Wed, 21 Aug 2024 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJo8vbW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9429A0;
	Wed, 21 Aug 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204731; cv=fail; b=obGfRqzKFpGos7hH2k8dzO/5YVTGwAhSNmQ/yQOnT4IvrUxN25mOFffX7p/c/mEPGdy8oW+2dvzV1XK2MutXlLJ5FIdvCI8+61rOvi2yCONCQQdsI6YqFhKgqpwwfF5kJO/Qpj0Oc5WYAB+IN+pNBuKw+7HFKb106iFMgZGtrwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204731; c=relaxed/simple;
	bh=i7Zm+Cd1M6QjjYSdP8gy5j/hSYkwYL4u0/vAwviqGj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aOGF79jqSrSxtjscD8STHv7KshOdIqx9pAB9YexF8VEXZRiicb7h5mXA1rkpiCSrxJeFTBKHmX02GdS3YCmDKqlIyAdn1FLgGGoDxoj1fF1fHNB+mlIAPC9sC/ZAPg7xFaf7YaM/bFTXxLsErhjaLq16hyHUu5tOkinX3lPpxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJo8vbW+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724204730; x=1755740730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i7Zm+Cd1M6QjjYSdP8gy5j/hSYkwYL4u0/vAwviqGj0=;
  b=GJo8vbW+KuuNTka7ClFwfhoxnckfg/x7RkEz9nhwlNRfyEiyJjBcAYUH
   qUrIFJ+YMPGwmWxjikQQyPfn6Dsi/XfbuH4FPL2uirty//w+ni5MJTamF
   3YDBXia2vaW0leIG7vVWoRk0xzJaJ7psPMtF5vykbhXPdGkWE48GUniWI
   WW67z4BE3aWgTFPmP0BJkDa7sbSvD1/i8dVP3uHywkssqAfvb6wNvKJFj
   BJNefDH9xbsGTGaqVRsLOqF2CCu49c+CZhvy4j/2fWGu2JFSl0e6BAzQk
   VCEyzH2KAbzKaPqT732l+K9/Pk9fDseHjEwo3KQeX9UnFwaMezATME+zp
   g==;
X-CSE-ConnectionGUID: mZ+IRXHgQ8695NcWLNFPVQ==
X-CSE-MsgGUID: QiLTUXLsSPK9HxBjqPPw7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="40052648"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="40052648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:45:28 -0700
X-CSE-ConnectionGUID: KDnkEVqYREeUx+rXLwnXUA==
X-CSE-MsgGUID: PYRHQOUiSdeVSPBd3kKdLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60634728"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 18:45:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:45:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 18:45:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 18:45:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 18:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugs9t3EpLVro8lhw2TQpLmrpcQdj0yAF0Tk93hVxPurAiyxKq/kl6sbpxOGIpBH18mS7ktI3QUTvrBwRWL2XEpOfep6Cg+w79L86GcuV4bMYs37Ia6zNNB4wCOHtw32ayTvrFjSEp01dX1SE/Sf9iFw9CUbeARmEiSmXm0gGAZ4DGIA36NXhTlwHUcbZDErFNUn2sNG8xhfklidaMQreng6E0ueSX93EEaHW0Z1aLwGQU9S8j3BznLV5d2LEJnuet4umuRpvfKPsKfLSthUsS6r1yNxpLC0mgIQ0XshM6E0HYQFsYFwvwH6jvlbs8PXbJ9yIxfZ/1tIrGQyKro90pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Zm+Cd1M6QjjYSdP8gy5j/hSYkwYL4u0/vAwviqGj0=;
 b=Ryse19xW92GVwEn56BRYRRQ7GvxQBjXZcumUDkHEzKQOhjl576BiOhsEkXyNSTc22KTLtYK1nQ9GG4fOhDBPjkED56WCcCjAfPq+VaJ55SB2SGlc32m8pVCWR2EqfewfZdD4dEuupvHl6oGJQJDn+DO64ZJFJ26tbgXZ+/7k7KPDb5lDl+GizzY0QxtcJzcxCEVUtDSXHf81YxGHs/eehkIL4Bgws+MEieM7UkgqIDC8gwoIygg5zY6y2tj7l+7h6nC+bnyDMXLFLXUi+CKXTb9b700lZDVguODB86XaVJTLUJB0TlEOC455vfz6llSH0c1sMw/wWYtI5CBvBid2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 01:45:16 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 01:45:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "kees@kernel.org" <kees@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "jannh@google.com"
	<jannh@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>, "bp@alien8.de"
	<bp@alien8.de>, "wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAIAABi0AgAAX+IA=
Date: Wed, 21 Aug 2024 01:45:16 +0000
Message-ID: <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
	 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
	 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
	 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
	 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
In-Reply-To: <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB7477:EE_
x-ms-office365-filtering-correlation-id: 32852de0-871f-4381-b9c3-08dcc182e852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YldPYkxVNCtsSjlxSzBkcURrYVZYdGh2a1g3ZzV5S3FyektIeFBDZEI3MjhD?=
 =?utf-8?B?QVNTeVpiRGFFRVA4TEJBQUVZT2I3VVRST2hnT0JyQlF1R1pBdzMyQjhQdnln?=
 =?utf-8?B?S1lRL0EydFNUWXlkdGdGSklpNWhFSkZUdHdYNndVVUozWjZUV1R0NWpFOUxW?=
 =?utf-8?B?aHpNWEd6ZVUrRVBJRm9VN3BzazNnUzdscjI5am0yNHlNNXJxRmpVcVEvaGFN?=
 =?utf-8?B?ejZBMWtjeE9keFJ3UlhzdmlJUHpyU0paTWtjYVUxM2R5RHM2YXRRTXJkYmlT?=
 =?utf-8?B?U3BIVVUwcEp6ZHQ2L1JuTzZVeS9IWVFGN1ZMdGllaDhScWdsL0Y3VE93MXJm?=
 =?utf-8?B?ZVMrTENUWldwSHdxbzF3dExsTC9yMkhUMm9SalJQdmRNTGpiSmhWZnJEdTcz?=
 =?utf-8?B?Yk41MWx2WktsQUpBNW5QbGc1SmF5YUNPZ2pQOG5lQnRTQ1V2ckhLOXhOVEZp?=
 =?utf-8?B?YU1CaWlTNlBlOVplYTJoU2h5MFQ4K04zQUlhaHlzUlBNOG5sSVZXYm83bWdG?=
 =?utf-8?B?OUNuM1pNOU9SSXhuNEcvVjBKUjdwTXlESFFiak5xQzRNdzU1dVhKTWp3QUxh?=
 =?utf-8?B?L21QK3NuM0xnelpsaW9YM1BqNE90WHE4NjU2S2UyN3BCSzFLblhLT1pDeFZq?=
 =?utf-8?B?NmdzQ1lqc2cxK01UQmlmWXQ4VnA3SHlKZEJwcUwvNXk5eXplR2pDRDhidyt4?=
 =?utf-8?B?OUM2blQ5b3k1bzlKQktXUmlDdVhOdVd4aXlndUhTaWFNUWw4dEREZ1RzVmgv?=
 =?utf-8?B?bm5wY25OUnYweHdsRTFZL0VhZ21TbWdQSXhqb2pqUUJaT3hhSGNheVBNWXdE?=
 =?utf-8?B?UXRZZXRMZjEyOHZ5OXBodCt4bjU3OUdkdFFOaDMzemkvaUJHYys5K1FWVk1Z?=
 =?utf-8?B?VEVhSlBNQkovV05qczVGem85dkxaYjZ0aEg5WkMxaWt4UG1VNWNTOGhkUWN1?=
 =?utf-8?B?R09zUmdUQlphZU5rdlRaN0ZLMHN6ejFoa3lYa05Zb2RxU0h5SkRublE1dWNT?=
 =?utf-8?B?MHhaK3ZNRzNpT1lFekVRNk04YmhrMkw5aWFhckxSUjRKVkJQYjllVHhreFJn?=
 =?utf-8?B?MkhrWDBoRDdFbEQ4OEdnSVcxdnovWE5sUGhUeWxEaDdtenNGd1FvUE9ESzNW?=
 =?utf-8?B?U29zQUhRYXVCcDI0OURURXZvUTZwcW1vSVNmejJKSVRLV25ybkdKMWVBdlc5?=
 =?utf-8?B?QzFtcE9QMVprbWdldW5DdlQ2M29mYUI1dUlVdTJpZFJnVFBHemxUVDgwMjkr?=
 =?utf-8?B?UHorOC9Ra1pKVS92RjBCRlp6TFJiaGZ5cVRaVGt0dEtVdStMa2FrUEFsSDlG?=
 =?utf-8?B?LzJhSDVFb3E3NHV5NFdnQnRKeXg1bEpaN0ZsS2pZYno4U1VkektmQS9VSER6?=
 =?utf-8?B?OWtGUmVqa2tCSUE2MEt5VWpUODl0c3NMMG1sNng5dTk0Zmp0d1NDaHBOWUlJ?=
 =?utf-8?B?ekxQOVllL0daQ09QdkNoanZ2Ym9FYzdRNEtacUtIN3ltUUdrZlJBZXh4S2lY?=
 =?utf-8?B?d2NURGNYUFBPUDNFTnhLZ0RSTXJoVUlLN0VFbDlxd0ZFSnhkTmlna0s2TzMv?=
 =?utf-8?B?T2dCOXJMSVB1MjVDNmdtbVNmKzB4Z2xxYnBpSkgyWTlYU3djTjFGdDYrTGxM?=
 =?utf-8?B?c2RBRnZFbkxnV3ptb1RRVWorNFlRdEJGQ2lQK0VkUTloODQvZDN1TlN6RkFl?=
 =?utf-8?B?TTNPVDZQMW5OelNPdTJDaWJraStISHZZZFRha25nTDVvOXY5cW9xVC9wRU4z?=
 =?utf-8?B?VXNxMEZFUWNLOThiRWYxeDNUbVM0Rmh5by9oemxjSlJkaG4vbW54cDFtSkph?=
 =?utf-8?B?SU5GQjJ5Y2JWWHZRNWswdDliNUJmRFdBdkcxb01qbXJVOW9oeXRpWTRMeXFy?=
 =?utf-8?B?N1RreHRzaGZCT0RVSHU1VFo0WnJkbjlOSVFYRlhmeTQ0RUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmNFTjNkR1Jndk5uMGxSbzczWkt0SE9aRy9RVkY5Tkl5UHZkdy9XaWovbmMy?=
 =?utf-8?B?bzFtUytGR3ArOS85MHYvMjBCNC93cHppR2xNTGZ6bUhVcGpZM1UyS21GQWhN?=
 =?utf-8?B?SU1WWWVLemR5VzRoa0x1NmgyWGoyaEE2c2tKTGg5TU15SWJxL3lVdWQ3c2w4?=
 =?utf-8?B?MjVpemVCVXZoZXBqbDRBTGlHQ2Y5OVJxUFZEemxEUitSNkFncmw0SitVVFlE?=
 =?utf-8?B?MjljUlRidmZ6cUxhU2VncnJMdFJvUWdaT2Nka0xrWFQyL0w1aXJER0NhKzRP?=
 =?utf-8?B?c25lMGNKUTJlK2dDUkUrTVNlaXFueFcvOTBUdFNzZ29TMndyczhIcTRWYTRz?=
 =?utf-8?B?UHhqL1B3YmRHMWhoUzE2Mzd1K1A4YU9aVlQ3ZnFUVHgzNGEzaWMxUmdGYnZW?=
 =?utf-8?B?ejdWMTBHUmV0WlRYK0NESnZHZ3IxUDBva3J6MHVYbnpyQUdFZEhGczlmejU2?=
 =?utf-8?B?ZGhpczA5QS9iWENxZGh3R3B2VXM5bGNzVkt2eVBERGxuRGd4UElYU2NNOGt2?=
 =?utf-8?B?OHB2K3paNnVQekY5QXhpemFWU2draDhrYkgvbm54MEhoR1h4ZEVRSGpsemhs?=
 =?utf-8?B?ZWFrZll2VnE2aXdEaE1OY25kWEE5M2pFYjFpZnNnZ1VKWkxaRUlLblZUZENS?=
 =?utf-8?B?Wlg0NHJoekUwZEljYlhlMWtIaWhacG5jTzF1U2NMT3FZNFUxRFdlNDEyMjRE?=
 =?utf-8?B?ODczS1dycE5ndXZ5TzlpNDdhdHhDblg4SnFDaWNWLzJYcnFZSXlTRlVzMXh0?=
 =?utf-8?B?YXZ1QzdPTW5jQWp4S0QzUk1sQWtpR2kxeG4yWmRYZG1BdTZmOEhWWDR6d3dN?=
 =?utf-8?B?TGxxTG5TTTZpbnJ0S1h1YVluNlZtRUVzM0dwcGJ6NjhocDloSDBnNldMSjUy?=
 =?utf-8?B?dnZ6NFBnTGpRamw5SWQ0cExrZGZqa2JuSEN3ZDVDS2x1NDdSRGhCb2o1dEo0?=
 =?utf-8?B?VEtmTDEvaDFJQ1JqOGJ6a1ZCeFJvK3VmcjNrek1nNTFaQTVkNkRaWXRTdjk2?=
 =?utf-8?B?QkhJQTlmYmlIV1FUeGxwenlEekE0eWt3VXl5WndtcTE3SXV0YlppdDRSRjNY?=
 =?utf-8?B?MUVCYnZRR3M5K3ZMSDNxZXVMaldsQVhCUjhKU3E2cXBuWjQxYWNzUzVoT3BP?=
 =?utf-8?B?SU9LUnlZZGgxL200cU91RnIwM1BDbnJHQ0RFWFJJZDJhV3haRHBJNUtScStB?=
 =?utf-8?B?SkN0aXljMWRsb05WZFFyemthem9QYVRWTHFrOGxWY2JqMFZzOWlCS1RteFlz?=
 =?utf-8?B?L1JpYTQyMk1DeDRicEwyRzc2eUJXTExhd05kMUtOV1dGZ3BWc2dDbk5SMm4x?=
 =?utf-8?B?YXVXZS90RjhoWnQ3ZlpDVVkvbGNYQkFwUmYrMlFoVnFYM3ZRQk9hT2JBNFpS?=
 =?utf-8?B?alZETEJIRFJvd0FUMm8yR1hUY29XVUtGbHhia2JDT2JuSlpYclRwZDRBd1lz?=
 =?utf-8?B?eVg2K1pYblZBdDhFTFZ4WW51QXQxczU5cEo0Uk9ldDN5ZncxY1pGbmY3RFB1?=
 =?utf-8?B?aVhPTjdtWDdVa1hvTHl5dFpPdVRKN2dHSjJrYnFEaUFUUDlza3Z5WURaMFZT?=
 =?utf-8?B?RmpISkJtSHgwZ29kazcrVDZSdmQ2emFHOFV6OHhINkY2R0tvVzdHOHBVa29I?=
 =?utf-8?B?TCtONm5PVVR1ZHZ4UTdjUlBiUkFLNWxHS2t2anFKTFZXZ0VVTXAzaGRkYjZG?=
 =?utf-8?B?enJmakNJWnl1ZEN2NUJseUtRSkhsVWQ3QTd2Rk1WTUhqZGdLSkVVQ2FVblYx?=
 =?utf-8?B?UC9EckxaMTRHYnJ2cTgwNEFrOHpqZjRPRnNndE9iR3gvYmVFdE15bGF5NXN0?=
 =?utf-8?B?ZjR2TFcrcXJXVzR0a0o4TDJFQnNnWkE5VTlvVnh3eG1NUEswc0gxMm8yOFNm?=
 =?utf-8?B?REFLR0doRW5Uc3VjRU1oaVBFRzV2QVZGOVhSUDRTZWNIQUpaUjBycXlDd0x6?=
 =?utf-8?B?RHB3TTJQWVpldjQzcWlMODVTRXlVVlkreEEydkZIVFhlOXZMMHVuRVNoSXVX?=
 =?utf-8?B?VUJxalorVXRNV25sRkp0VnI3dVMxT003OTVwb0pjamR1N0JpSVB6RHNqNm9u?=
 =?utf-8?B?eFE2a2IwbmxwcERuc0NyZ3UwK050ZkYxRWFFckF2YVhid0JBb0xVQnNUSEp6?=
 =?utf-8?B?SXhFTVJ0Qjg0d2FiSVc4cC9JUkN2OEhyUjR5clR6R3dHcGsvRGxseWJzdlF6?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <857CCE7BFBA5C54BA52D94E1D89A04F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32852de0-871f-4381-b9c3-08dcc182e852
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:45:16.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiAPZWSw1EHDs9uqVcL3Ht+49r6Nvx7ViB177CVNoNnCmdB8soOblw4C9rclf7rrHrrgQpqLOzoP0SiGusIZ9ulrLu4VCUMwvec1yNEQIg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDAxOjE5ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBJ
IHRoaW5rIGl0J3MgZ29pbmcgdG8gYmUgc3RyYW5nZSBvbmUgd2F5IG9yIGFub3RoZXIsIGVpdGhl
ciB5b3Ugc3BlY2lmeQ0KPiBhIHNpemUgdGhhdCB3ZSBkb24ndCBjdXJyZW50bHkgcmVhbGx5IHVz
ZSBvciB5b3UgaGF2ZSB0d28gdGhpbmdzIGJvdGgNCj4gY2FsbGVkIHN0YWNrcyB3aGljaCBhcmUg
ZGVzY3JpYmVkIGRpZmZlcmVudGx5Lg0KDQpJIHdvdWxkIGd1ZXNzIHVzZXJzIG9mIHJhdyBjbG9u
ZTMgY2FsbHMgd291bGQgYmUgYWJsZSB0byBoYW5kbGUgdGhhdCBraW5kIG9mDQp2YXJpYXRpb24u
DQoNCkkgd2FzIGp1c3QgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2h5IHRoZXJlIGlzIGJvdGggdGhl
IHBvaW50ZXIgYW5kIHNpemUgZm9yDQpub3JtYWwgc3RhY2tzLiBJdCBzZWVtcyB0aGF0IG9uZSB1
c2FnZSBpcyB0aGF0IHlvdSBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0DQp3aGV0aGVyIHlvdXIg
YXJjaCdzIHN0YWNrIGdyb3dzIHVwIG9yIGRvd24uIEJ1dCBvdGhlcndpc2UsIHRoZSBwcmV2aW91
cyBjbG9uZSdzDQpkaWRuJ3QgbmVlZCB0aGUgc2l6ZS4gQmVmb3JlIGNsb25lMyB0aGUgc3RhY2sg
c2l6ZSB1c2VycyBzZWVtIHRvIGJlIGtlcm5lbA0KdGhyZWFkcywgc28gd2hlbiB0aGV5IHVuaWZp
ZWQgdGhlIGluZnJhc3RydWN0dXJlIGJlaGluZCBrZXJuZWxfY2xvbmVfYXJncywNCnN0YWNrX3Np
emUgd2FzIG5lZWRlZCBmb3IgdGhlIHN0cnVjdC4gQ291bGQgaXQgYmUgdGhhdCBpdCBqdXN0IGxl
YWtlZCB0bw0KdXNlcnNwYWNlIGZvciB0aGF0IHJlYXNvbj8gSSBkb24ndCBrbm93LCBidXQgSSB3
b3VsZCB0aGluayBhIHR3ZWFrIHRvIHN1Y2ggYQ0KZnVuZGFtZW50YWwgc3lzY2FsbCBzaG91bGQg
aGF2ZSBzb21lIHB1cnBvc2VmdWwgZGVzaWduIGJlaGluZCBpdC4NCg0KPiDCoCBJIHN1cHBvc2Ug
d2UgY291bGQgY2FsbA0KPiBhIHNpbmdsZSBwYXJhbWV0ZXIgc2hhZG93X3N0YWNrX3BvaW50ZXI/
wqAgVGhvdWdoIEkgZG8gbm90ZSB0aGF0IGFzIHlvdQ0KPiBpbmRpY2F0ZWQgd2UndmUgYmVlbiBn
b2luZyBmb3Igc29tZSB0aW1lIGFuZCB0aGlzIGlzIHRoZSBmaXJzdCB0aW1lIGl0DQo+IGNhbWUg
dXAuLi4NCg0KU29ycnkgZm9yIHRoYXQuIEkgbG9va2VkIHRocm91Z2ggYWxsIHRoZSBvbGQgdGhy
ZWFkcyBleHBlY3RpbmcgdG8gZmluZA0KZGlzY3Vzc2lvbiwgYnV0IGNvdWxkbid0IGZpbmQgYW4g
YW5zd2VyLiBJcyBjbG9uZTMgc3VwcG9ydCBhIGRlcGVuZGVuY3kgZm9yIGFybQ0Kc2hhZG93IHN0
YWNrcz8NCg0KDQoNCg==

