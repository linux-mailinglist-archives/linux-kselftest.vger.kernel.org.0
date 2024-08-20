Return-Path: <linux-kselftest+bounces-15791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC6958FC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF911C21A5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 21:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914801C5791;
	Tue, 20 Aug 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAR6Ewhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB845008;
	Tue, 20 Aug 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189819; cv=fail; b=RfEBI+P8PdK50Q+JEXCYBVJ3HF9MepIUkJBV/htvO6LNw8QuQpZhIXzusXYQnywSPHscEKAjj8Q47NpxOl6cdgp9IGG/fqBGw7cyeckRGsISH7oCevuF18pbuS92rV6qxHBkCjGOghQau7eSy2KBs4aWOW4ygvb5teOE0YWce+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189819; c=relaxed/simple;
	bh=YUyOzfvp3WzD005ISf+uRqMOj5zsB1UNbWCMGi8BEjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cozig3CI3GFq+m/t48HP7F92bMgBLDroQ2bprjAf+beAKfcfPylr7m4LA9hrqABGRuEYHAjp3s9w5xz330jKDPjs3Ei0uRoMOvWp6yvJNnCf1nQih9pF2ahgf8pzA4f6KCN4rX6HKJD5X8Dl/s/Kf6I8UT0fyNTAoWmJd9a3EQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAR6Ewhk; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724189817; x=1755725817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YUyOzfvp3WzD005ISf+uRqMOj5zsB1UNbWCMGi8BEjA=;
  b=NAR6EwhkIyU9Qk2OYXS5WfuRFbdCK4O94ONYLb2EThZehZ8e25skErf+
   oSV/5s8oq+Z1u0h3vowrvcsGB8zU6Q4IAhG2SgDRrzIH5IqAAfpU9Gtra
   BC8nejAkxBsXkYOa3eBAMysQPA+4WfOBgyZlRyxuPjSF2SYwl3RvqxjS5
   Hir2rxKiqaSkKxE7Lm9R5cPSHE24yrIIAnVp3x+UGVtbQEDxKy3UL4GI1
   eNZhna0cvuMfD1TelqcESIjk2KYcjm34qR13rWpEa6vQkvxZQTfVLYndf
   Pd1lI8N5qqVyPZkx8rmcutK4+YitHOoW/fJxChwV/GYzZ4bgmkrLa8YZ3
   A==;
X-CSE-ConnectionGUID: 9WEdVHMqTE6TarYrq3YG3w==
X-CSE-MsgGUID: zKh7Vas/S0e3ZNq9lpUjGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33085811"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33085811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:36:56 -0700
X-CSE-ConnectionGUID: KD89MBEJRCO3Mbf5OwC9Vg==
X-CSE-MsgGUID: YkRDTWtWSiqRXyeSe+e77w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65560584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:36:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:36:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:36:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs+NnMEkJgKpjK9okWPT88p5TuaWFYGmmwV9Uc1YmnVDgCL/NFbcyWYbj21YgWq+NRqAoEMgM9jnm5TnMJoBXTlz/CLn6U7Yz7v7nIOjZYZdI4d8Xk9dHuES31T7AomL6gyWs1M0Qe4kZjhY2ulQJ9/c31Tnu4zBO1G/umkg1xURh2YodMZSwAZOwqAqmWs9O05ftnBnJODTDRNbIcsA+TxqvBNpGtQc0WxB/uv5avfLSI1MIpl/EBULzku4FHYfc5kARHmSEg9+QyLFtobpz81N6arA7Gr/4wl+quLQh3vUwkaGCScSvqsXWvknjFYAWC3nkZp/pC2DiU1DKYQftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUyOzfvp3WzD005ISf+uRqMOj5zsB1UNbWCMGi8BEjA=;
 b=Mam50whIMnWZypsEDSnkeLZ10Jy8CUQavs/9R1xVDwtVaJ35ZXrCFOyFJJy60vtOXIaQRR8tkEy81pdHaLSpB1GccWVb6d7Jj5Y+i38yfx8kjrYcDBOtaE90gfn2eTUX23MIgU5PQSAvf1+FOHKt75HlG3D7timLHOgDbmGdk0GBkmntxakDCalEjdkjvYNs2bR2qgbzi543X4p91icz7DkFU1o78NTOtbddnofh3UpjEoIhI9uYcBnyrkFVFw2XjxKHaUsNyQHf+U13dBnSPeYSXY7rKvEfJlLNTNHsgE55lbc75IjuA7EW7JDw66DNjhWieaysVWd38VzdZCNUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:36:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 21:36:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "kees@kernel.org"
	<kees@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEA
Date: Tue, 20 Aug 2024 21:36:46 +0000
Message-ID: <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6733:EE_
x-ms-office365-filtering-correlation-id: 6ca0f3f8-53bc-496a-8ecb-08dcc160314e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUlQZDdzeml2ZmFRRFkwMlBQd3NwMWN2cytVQVd0RnEyTlgra0t1MVN1aVUy?=
 =?utf-8?B?enB6VTBaMk8ydnN1REl4OGN6TmFCRllWUktTT1VDTDBJRlh5bll6S0crK0tz?=
 =?utf-8?B?M3gyREhnMm1pRGZoZHU5cmtwM1dYRy8rd2tKUmIvNzl6MmtBK1BFeWFEaUEr?=
 =?utf-8?B?QUhGeWM0TnR4b3JsM016MlZ4aThJRXo2TDMwNzhHNzdlN2lhT0V4Q3lFZi85?=
 =?utf-8?B?Z2x6UysyMFNqdHZnbHZSTjNwaG5oL09hSmtsVHFqUTdhNURGV0dDSzVCS1Br?=
 =?utf-8?B?VmJzZVhqRXRGdWNXQmVVcG9nd2pYVEhndWVwMll1Y08rTmozbTJaOFlLdDJR?=
 =?utf-8?B?NEdBNkVqY2hoeG1sM0VlRU9zblNXQzhFRnJ0RktWRkkyc2pOZHJENW4rWXdU?=
 =?utf-8?B?cS90SndicVlGOHNmQ3k2K091OS9aOXpKdlEvTnVOd1FvSXI5VFFCbER4Q3pr?=
 =?utf-8?B?S1RobjlWNkk4YkZ2RFltaDhNWmUrN0dOdzBkZVlPOTc2R004VzJYa1owcVVn?=
 =?utf-8?B?VUsrakdJRWNkNVFFZFA4M2tUVkFxdHhrd1FlNXd3VWxFU2habm9tUlMvQ1pB?=
 =?utf-8?B?R1NIOVBhSjIyT2hxblEveFdFMHFpaTRycUYxY2FDTklwZ3dkUDMyaGxkaExF?=
 =?utf-8?B?ZHlrWWhoUFFWdHp1TDR4OWNYQi9FSC80MmFVNXZlUlNjaGVocmxrbEJaeWdJ?=
 =?utf-8?B?a2o5T0REeXRXNkhsWDdPZUh0MDlhUUZidk1qd3FNNUN0a1d4blpYTitubmcz?=
 =?utf-8?B?WkdkcFJTbU1JbVA4Sjk0ZUtVamVwMXFUUWZVRjkxeDgzeUdBZWxQQWQ2bm8y?=
 =?utf-8?B?OHg2bnpJVm4rYWFFczRFeGM4Q3lzN2NBMnJ4MHpFUXpyZWRuTjBpaGIvaDlP?=
 =?utf-8?B?S3ZHZlFFNW9VQkw5Nk1FeTFSMFozc2tLN2tIbVFoWmFqdXc1eSt1ZVphRmxZ?=
 =?utf-8?B?MTRFVkI1SE1TNm9vWkZlKzZnYUZLMzZHWGJsK1R3OWtYeXFabEt2dXpMalhC?=
 =?utf-8?B?RElrSjJrWmM2My9XZy9QV2FQc0pzQnRRYm5zbmdpTmYzdEpXMzhJckFPeVRt?=
 =?utf-8?B?NW9iYmZPYTl1eW5jV3I3QXlKb1FBRWFPaUcvMyt3cW84S1gyaHIvdXBiM0Rj?=
 =?utf-8?B?dlU3bVgrTVFNajdEMjBtNmYyWGRRNU9JTGlqdjN5NngraUVwbFZsdUhyeUlk?=
 =?utf-8?B?MGNITC9UYnBFSHRqQWNIRFA3UnN2N0U0blc1SjFjankrV0hQdUR3RmZLZFhu?=
 =?utf-8?B?czkwdHFWaDk5RTVROXpBcWhYeC9OTVJDUldSUjI4MjFoYm9HZlg5YmpybkYx?=
 =?utf-8?B?RXJ4R3ljUC80Qm9yRWx6SktKSGJHc09ZcGxoSVB2aDZVN0o1OEgwdHgxQlIv?=
 =?utf-8?B?dFlOWWpDMmkrYU80aC9DWVI0Y2txWEp2elBuNzJuTGl3aktCSlNtR2JZWk1M?=
 =?utf-8?B?d3BCbUd3M3VBQitHQ3U0RngzaXBLSktKWElMamlmSmd1b3JTRFNWUzVRdkJq?=
 =?utf-8?B?VzdBbGZKaHdsaGZuVlpLQWtla2NSK1h1SGh1akYxNzQzZHgwOFIrRjNEaG1T?=
 =?utf-8?B?NmJoQVdiRGh3SE8wTlgwTTBJWlpBem9SclBROTErMjZhNEJrTDhPZkF3Y0FC?=
 =?utf-8?B?cHo1dTVqRkFnT1YxWFRTYVRMR2x0RzRubHZZY1J6Z2tBOHo0TUpERDFLRnF4?=
 =?utf-8?B?cVh2YVdGQ3FJOWNtLzl5U2hVVmExQmxNMjV1bS82NjdrRE1RbU1JWk1jZFU5?=
 =?utf-8?B?dFFFM1VYVmZaSm4vK213SG1SMnl0N09vNFdZOHhMYzh6UUdOMzBGYVJsdGJl?=
 =?utf-8?B?RVVPNTBpd0xFVStnRDVDVUdVaVdyZmI3Q2s3NkhuaVdZU2M5WDVCRFh4Tkls?=
 =?utf-8?B?WFJ3YVZZNmwrZkgrUmpOMU9sWFZrT05saEU0SENoa1lzbTFYVXV6VHUzQ043?=
 =?utf-8?Q?4XY9+DFlE0c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cURHRHZsWFZqS1dZQUh3ZzZud0x4NEh0Z0VoK1V4NlpsLzg4V2hKUVpSU0lU?=
 =?utf-8?B?UXI2RmNENWUrbE9QUmxMdjhsSkw1RmVuNTRQYzdySU1NOWduWnY1QnA4QmF5?=
 =?utf-8?B?djhFR21CTnJOaU00TUhIV0l1QVNraFI2ek8wOEQ1UGVtenIvbk1nTFlTVFo1?=
 =?utf-8?B?VFhnRlVZbmRxM3Bwczd0dXdXcmgvRU9LYWZ6OU14eDhjcHdCOUtxVmtpOWtH?=
 =?utf-8?B?TkJxWmpyeHQyek9JT1JINCs0SFdpM0ExZFhxdEhKdGppRkFMTlVUMXlRTVN4?=
 =?utf-8?B?RXlHWU83SldjazN4aE9ZRy9mWFBBdzZCN1F6WVBHYjY3TXFqeDhHQ21YcWYy?=
 =?utf-8?B?YmF0eFRMMEszZjZlZjBydjlqbCtHYXZQaTk2Qmg3NzlFbHZFRmU1bEgrakNW?=
 =?utf-8?B?TGoyS2RLYnhvMmlrQUF3YVBPYXJQSVZ6YTZFbUs2bFRoNlRWeDVDbW5ZZGEz?=
 =?utf-8?B?MkdLQUpwMW1GNTlOWDFsblJkUXladmxqd3ZUSWxwQlljOVI2WmhlRVNpRnQ4?=
 =?utf-8?B?Tm1WQmJYNHZURWgvbkFYZHNkNFIxMnZWelI5bXNWcmQxVllwU3VwdlJQT0VM?=
 =?utf-8?B?clY0c3djT080V0hsSUNyR3NuUW9SSzVMSUh2UlQ1bmhpR1EzekFKdjAyamNk?=
 =?utf-8?B?ZmdnVGtiZC93eUkyY2V1RlJuNVRZSi9xYnZPcUpoM1Q3dVE2bjlFak5LVmpR?=
 =?utf-8?B?THM4QXZOWHFiV3BQK29XTmR6aksvZGQxaUU4SWx6TEVQMFJRM2RBcWNrYldT?=
 =?utf-8?B?WC83a09ydG9udEFzWGRpL1NUMjUxVGFwUHQyM2RidVpOMFdoT0QyQVMxS2NQ?=
 =?utf-8?B?a0VOL3ZaeWxILzEyUHpzbm5HcDIyMDd6Y2p2dDBROS9HMGY4NWRrZDVZaVZ2?=
 =?utf-8?B?eTZjWG05U282Q0oyQzJOZDRRWExXWHFMOU9JMUlLU2FlUXB2UFVoVDVkMUJy?=
 =?utf-8?B?MnowajM1UWJzVkhTdmJXOVFuZGxYV2d1bnhIRWxRbW1FQjlvUklqNFZUdk1x?=
 =?utf-8?B?eGhGU3Y5WjBwc1cxbGNlU2pwMEhYb1JZd2tMUXJQNFZpd2pwZVRLU2JJMyto?=
 =?utf-8?B?eFZtWTJaWldQdStTU0RNSjhBU0M0RHhTaTVWTUh6NUprc1RrQTB1L1E2aC9S?=
 =?utf-8?B?OCtuK0VCZmZ4SlJCZWkwOGtYY1V4VkwyWFJFeFZiaW10dm5KVVpSU1FJTW9L?=
 =?utf-8?B?TmhpQXN0S3F1ZVkwek93NEJhUFRZZVl3eUU3b2x4Rkc1emcwQ1AvOFFCRWVj?=
 =?utf-8?B?QUh1dGU2SUVLcDRoaDNiTmJLQVR3dkxzYXIvRS9aSXU2bHVGTS9zek5rRDVS?=
 =?utf-8?B?ZGFtREZLcGc2OXFMRnk2elpQSE5tWGNqZVZQZ1didW05N0Jld3FCaHNJL3hP?=
 =?utf-8?B?YVo4cFpTT09hQkIxMDRDeTk4cHArNUlGYmZHTVVVNFF6RFV6TEFlQjNNZU16?=
 =?utf-8?B?RXdRQVphdzRxWmxXbkhMdTU5VG5sSUNaUGpNbHp5YnZIeERIKzdWYkNES1hY?=
 =?utf-8?B?S1o2c0UwQThYZVhnQ2ZpMHFicFBQV040ZmpQSnBoc2xvOXkyT0dkNm1scWlz?=
 =?utf-8?B?QmMrSHA0TjBlZTF5YVh4RVdtV2xhdGJjMmdRakV4UGxDQTMrUks0OHFPTlVu?=
 =?utf-8?B?RHd3MzlHT3FEZzg0cFVFdFQvMzlwdnQ1Z2NUMmQ0TmlIaGhaS2laU1VCUjlo?=
 =?utf-8?B?YWtrZkxmRm9rNWs1YjE5ZFJmMitzbHdzMWxyUDMxUDJaRE5ZYVZaSTdlLzRl?=
 =?utf-8?B?MllKN2xROEZRMWJJTk5RNWNJT3BoQXMzUUhsak1rbDU1YUpuNVVBYmNqczlL?=
 =?utf-8?B?eGVzNVJybWZjOEJDM1hFOTNNKzU2aG5HMEFSc2pHUmp5cnUwdmFoelFQQjVV?=
 =?utf-8?B?eTIzZUExQWFaQXNUTVZVeS9tSjFtSjZXOXpoYzZCU2cycEhmZG9obSt1cGls?=
 =?utf-8?B?QThMV3cyb2pHcndSQXBvODQ1WFppUUZGNFREZjRMWXQ3dnR6RXh2d1pReElz?=
 =?utf-8?B?dUFFTDBQQzUzbXFxcjVoMmlwUCtJQ3ZMd2l2S05kNDg0VDNmZmJPd3VpVklT?=
 =?utf-8?B?c2RvdEtMWTI5VXpKZ3ZwYUVTUVlYMUE3SHlMamRrR293TWF5dEZQenNERkh0?=
 =?utf-8?B?eHBOS3ZKSVNCTStkdDFWOFRzbXpmVE1Hd0pvVUNuTmVnS1ZpRlJqdHdwRXRO?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B48A2BE15361A248A97D0AF113271E74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0f3f8-53bc-496a-8ecb-08dcc160314e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 21:36:46.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gxZQZq2vkVnY/X1tefdh3IMQ8Tq4u1DrxDH0xYfTQHOXJfiV/aqLaaR0Qvi//POYAeJ3kjAbJTxNNImdkJL3jnmpULdwosX5djs3N1QsYXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDIwOjI0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgoKCltz
bmlwXQoKPiDCoAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyBiL2FyY2gv
eDg2L2tlcm5lbC9zaHN0ay5jCj4gaW5kZXggMDU5Njg1NjEyMzYyLi40MmIyYjE4ZGUyMGQgMTAw
NjQ0Cj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMKPiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvc2hzdGsuYwo+IEBAIC0xOTEsNDQgKzE5MSwxMDMgQEAgdm9pZCByZXNldF90aHJlYWRfZmVh
dHVyZXModm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKgY3VycmVudC0+dGhyZWFkLmZlYXR1cmVzX2xv
Y2tlZCA9IDA7Cj4gwqB9Cj4gwqAKPiAtdW5zaWduZWQgbG9uZyBzaHN0a19hbGxvY190aHJlYWRf
c3RhY2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHVuc2lnbmVkIGxvbmcKPiBjbG9uZV9mbGFn
cywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBzdGFja19zaXplKQo+ICtpbnQg
YXJjaF9zaHN0a192YWxpZGF0ZV9jbG9uZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGFnZSAqcGFnZSwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGtl
cm5lbF9jbG9uZV9hcmdzICphcmdzKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKg
wqDCoMKgwqAgKiBTU1AgaXMgYWxpZ25lZCwgc28gcmVzZXJ2ZWQgYml0cyBhbmQgbW9kZSBiaXQg
YXJlIGEgemVybywganVzdCBtYXJrCj4gK8KgwqDCoMKgwqDCoMKgICogdGhlIHRva2VuIDY0LWJp
dC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqB2b2lkICptYWRkciA9IGtt
YXBfbG9jYWxfcGFnZShwYWdlKTsKPiArwqDCoMKgwqDCoMKgwqBpbnQgb2Zmc2V0Owo+ICvCoMKg
wqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgYWRkciwgc3NwOwo+ICvCoMKgwqDCoMKgwqDCoHU2NCBl
eHBlY3RlZDsKPiArwqDCoMKgwqDCoMKgwqB1NjQgdmFsOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBp
ZiAoIWZlYXR1cmVzX2VuYWJsZWQoQVJDSF9TSFNUS19TSFNUSykpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBzc3AgPSBhcmdz
LT5zaGFkb3dfc3RhY2sgKyBhcmdzLT5zaGFkb3dfc3RhY2tfc2l6ZTsKPiArwqDCoMKgwqDCoMKg
wqBhZGRyID0gc3NwIC0gU1NfRlJBTUVfU0laRTsKPiArwqDCoMKgwqDCoMKgwqBleHBlY3RlZCA9
IHNzcCB8IEJJVCgwKTsKPiArwqDCoMKgwqDCoMKgwqBvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShz
c3ApOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBUaGlzIHNob3VsZCByZWFsbHkgYmUgYW4gYXRv
bWljIGNtcHhjaGcuwqAgSXQgaXMgbm90LiAqLwo+ICvCoMKgwqDCoMKgwqDCoGNvcHlfZnJvbV91
c2VyX3BhZ2Uodm1hLCBwYWdlLCBhZGRyLCAmdmFsLCBtYWRkciArIG9mZnNldCwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2YodmFs
KSk7CgpXZXJlIHNvIGNsb3NlIHRvIHRoZSByZWFsIGNtcHhjaGcgYXQgdGhpcyBwb2ludC4gSSB0
b29rIGEgc2hvdCBhdCBpdCB3aXRoIHRoZQpkaWZmIGF0IHRoZSBlbmQuIEknbSBub3Qgc3VyZSBp
ZiBpdCBtaWdodCBuZWVkIHNvbWUgb2YgdGhlIGluc3RydW1lbnRhdGlvbgpjYWxscy4KCj4gKwo+
ICvCoMKgwqDCoMKgwqDCoGlmICh2YWwgIT0gZXhwZWN0ZWQpCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKClJldHVybiBmYWxzZSBmb3IgYW4gaW50IHdpbGwg
YmUgMCAoaS5lLiBzdWNjZXNzKS4gSSB0aGluayBpdCBtaWdodCBiZSBjb3ZlcmluZwp1cCBhIGJ1
Zy4gVGhlIGd1cCBoYXBwZW5zIHRvIGFyZ3MtPnNoYWRvd19zdGFjayArIGFyZ3MtPnNoYWRvd19z
dGFja19zaXplIC0gMQoodGhlIHNpemUgaW5jbHVzaXZlKS4gQnV0IHRoZSBjb3B5IGhhcHBlbnMg
YXQgdGhlIHNpemUgZXhjbHVzaXZlLgoKU28gc2hhZG93X3N0YWNrX3NpemUgPSBQQUdFX1NJWkUs
IHdpbGwgdHJ5IHRvIHJlYWQgdGhlIHRva2VuIGF0IHRoZSBzdGFydCBvZiB0aGUKc2hhZG93IHN0
YWNrLCBidXQgdGhlIGZhaWx1cmUgd2lsbCBiZSByZXBvcnRlZCBhcyBzdWNjZXNzLiBJIHRoaW5r
Li4uCgpPbiBhbm90aGVyIG5vdGUsIEkgdGhpbmsgd2UgbmVlZCB0byB2ZXJpZnkgdGhhdCBzc3Ag
aXMgOCBieXRlIGFsaWduZWQsIG9yIGl0CmNvdWxkIGJlIG1hZGUgdG8gb3ZlcmZsb3cgdGhlIGFk
amFjZW50IGRpcmVjdCBtYXAgcGFnZSBhIGZldyBieXRlcy4gQXQgbGVhc3QgSQpkaWRuJ3Qgc2Vl
IGhvdyBpdCB3YXMgcHJldmVudGVkLgoKPiArwqDCoMKgwqDCoMKgwqB2YWwgPSAwOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqBjb3B5X3RvX3VzZXJfcGFnZSh2bWEsIHBhZ2UsIGFkZHIsIG1hZGRyICsg
b2Zmc2V0LCAmdmFsLCBzaXplb2YodmFsKSk7Cj4gK8KgwqDCoMKgwqDCoMKgc2V0X3BhZ2VfZGly
dHlfbG9jayhwYWdlKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gK30KPiArCj4g
CltzbmlwXQo+IMKgCj4gK3N0YXRpYyBpbnQgc2hzdGtfdmFsaWRhdGVfY2xvbmUoc3RydWN0IHRh
c2tfc3RydWN0ICpwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyAqYXJncykKPiAr
ewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtbV9zdHJ1Y3QgKm1tOwo+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBwYWdl
ICpwYWdlOwo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgYWRkcjsKPiArwqDCoMKgwqDC
oMKgwqBpbnQgcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIUlTX0VOQUJMRUQoQ09ORklH
X0FSQ0hfSEFTX1VTRVJfU0hBRE9XX1NUQUNLKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICghYXJncy0+c2hhZG93X3N0
YWNrKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArCj4gK8Kg
wqDCoMKgwqDCoMKgbW0gPSBnZXRfdGFza19tbShwKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIW1t
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVGQVVMVDsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgbW1hcF9yZWFkX2xvY2sobW0pOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAv
Kgo+ICvCoMKgwqDCoMKgwqDCoCAqIEFsbCBjdXJyZW50IHNoYWRvdyBzdGFjayBhcmNoaXRlY3R1
cmVzIGhhdmUgdG9rZW5zIGF0IHRoZQo+ICvCoMKgwqDCoMKgwqDCoCAqIHRvcCBvZiBhIGRvd253
YXJkIGdyb3dpbmcgc2hhZG93IHN0YWNrLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDC
oMKgwqDCoGFkZHIgPSBhcmdzLT5zaGFkb3dfc3RhY2sgKyBhcmdzLT5zaGFkb3dfc3RhY2tfc2l6
ZSAtIDE7Cj4gK8KgwqDCoMKgwqDCoMKgYWRkciA9IHVudGFnZ2VkX2FkZHJfcmVtb3RlKG1tLCBh
ZGRyKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcGFnZSA9IGdldF91c2VyX3BhZ2Vfdm1hX3JlbW90
ZShtbSwgYWRkciwgRk9MTF9GT1JDRSB8IEZPTExfV1JJVEUsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCZ2bWEpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIocGFnZSkpIHsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gLUVGQVVMVDsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKg
wqDCoMKgwqBpZiAoISh2bWEtPnZtX2ZsYWdzICYgVk1fU0hBRE9XX1NUQUNLKSkgewoKQ2FuIHdl
IGNoZWNrIFZNX1dSSVRFIGhlcmUgdG9vPyBBdCBsZWFzdCBvbiB4ODYsIHNoYWRvdyBzdGFja3Mg
Y2FuIGJlCm1wcm90ZWN0KCllZCBhcyByZWFkLW9ubHkuIFRoZSByZWFzb24gZm9yIHRoaXMgYmVm
b3JlIEkgdGhpbmsgZmVsbCBvdXQgb2YgdGhlCmltcGxlbWVudGF0aW9uIGRldGFpbHMsIGJ1dCBh
bGwgdGhlIHNhbWUgaXQgd291bGQgYmUgbmljZSBiZSBjb25zaXN0ZW50LiBUaGVuIGl0CnNob3Vs
ZCBiZWhhdmUgaWRlbnRpY2FsbHkgdG8gYSByZWFsIHNoYWRvdyBzdGFjayBhY2Nlc3MuCgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtRUZBVUxUOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9wYWdlOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gYXJjaF9zaHN0a192YWxpZGF0ZV9jbG9uZShwLCB2bWEs
IHBhZ2UsIGFyZ3MpOwo+ICsKPiArb3V0X3BhZ2U6Cj4gK8KgwqDCoMKgwqDCoMKgcHV0X3BhZ2Uo
cGFnZSk7Cj4gK291dDoKPiArwqDCoMKgwqDCoMKgwqBtbWFwX3JlYWRfdW5sb2NrKG1tKTsKPiAr
wqDCoMKgwqDCoMKgwqBtbXB1dChtbSk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiAr
fQo+ICsKPiAKW3NuaXBdCj4gwqAKPiArLyoqCj4gKyAqIGNsb25lM19zaGFkb3dfc3RhY2tfdmFs
aWQgLSBjaGVjayBhbmQgcHJlcGFyZSBzaGFkb3cgc3RhY2sKPiArICogQGthcmdzOiBrZXJuZWwg
Y2xvbmUgYXJncwo+ICsgKgo+ICsgKiBWZXJpZnkgdGhhdCBzaGFkb3cgc3RhY2tzIGFyZSBvbmx5
IGVuYWJsZWQgaWYgc3VwcG9ydGVkLgo+ICsgKi8KPiArc3RhdGljIGlubGluZSBib29sIGNsb25l
M19zaGFkb3dfc3RhY2tfdmFsaWQoc3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzICprYXJncykKPiAr
ewo+ICvCoMKgwqDCoMKgwqDCoGlmIChrYXJncy0+c2hhZG93X3N0YWNrKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgha2FyZ3MtPnNoYWRvd19zdGFja19zaXplKQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNl
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGthcmdzLT5zaGFkb3df
c3RhY2tfc2l6ZSA8IFNIQURPV19TVEFDS19TSVpFX01JTikKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsKPiArCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChrYXJncy0+c2hhZG93X3N0YWNrX3NpemUgPiBybGlt
aXQoUkxJTUlUX1NUQUNLKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBmYWxzZTsKCkF0IHRoZSByaXNrIG9mIGFza2luZyBhIHN0dXBpZCBx
dWVzdGlvbiBvciBvbmUgdGhhdCBJIHNob3VsZCBoYXZlIGFza2VkIGEgbG9uZwp0aW1lIGFnby4u
LgoKV2h5IGRvIHdlIG5lZWQgYm90aCBzaGFkb3dfc3RhY2sgYW5kIHNoYWRvd19zdGFja19zaXpl
PyBXZSBhcmUgYmFzaWNhbGx5IGFza2luZwppdCB0byBjb25zdW1lIGEgdG9rZW4gYXQgYSBwb2lu
dGVyIGFuZCBoYXZlIHVzZXJzcGFjZSBtYW5hZ2UgdGhlIHNoYWRvdyBzdGFjawppdHNlbGYuIFNv
IHdoeSBkb2VzIHRoZSBrZXJuZWwgY2FyZSB3aGF0IHNpemUgaXQgaXM/IENvdWxkbid0IHdlIGp1
c3QgaGF2ZQonc2hhZG93X3N0YWNrJyBoYXZlIHRoYXQgbWVhbiBjb25zdW1lIGEgdG9rZW4gaGVy
ZS4KCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgYXJjaGl0ZWN0dXJlIG11c3QgY2hlY2sgc3VwcG9y
dCBvbiB0aGUgc3BlY2lmaWMKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogbWFj
aGluZS4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19VU0VS
X1NIQURPV19TVEFDSyk7Cj4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICFrYXJncy0+c2hhZG93X3N0YWNrX3NpemU7Cj4gK8Kg
wqDCoMKgwqDCoMKgfQo+ICt9Cj4gKwoKRml4aW5nIHNvbWUgb2YgbWVudGlvbmVkIGJ1Z3MsIHRo
aXMgb24gdG9wIHBhc3NlZCB0aGUgc2VsZnRlc3RzIGZvciBtZS4gSXQKZG9lc24ndCBoYXZlIHRo
ZSA4IGJ5dGUgYWxpZ25tZW50IGNoZWNrIEkgbWVudGlvbmVkIGJlY2F1c2UgSSdtIGxlc3Mgc3Vy
ZSBJCm1pZ2h0IGJlIG1pc3NpbmcgaXQgc29tZXdoZXJlLgoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9zaHN0ay5jIGIvYXJjaC94ODYva2VybmVsL3Noc3RrLmMKaW5kZXggNDJiMmIxOGRl
MjBkLi4yNjg1MTgwYjhjNWMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jCisr
KyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jCkBAIC0yMDQsNyArMjA0LDYgQEAgaW50IGFyY2hf
c2hzdGtfdmFsaWRhdGVfY2xvbmUoc3RydWN0IHRhc2tfc3RydWN0ICp0LAogICAgICAgIGludCBv
ZmZzZXQ7CiAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyLCBzc3A7CiAgICAgICAgdTY0IGV4cGVj
dGVkOwotICAgICAgIHU2NCB2YWw7CiAKICAgICAgICBpZiAoIWZlYXR1cmVzX2VuYWJsZWQoQVJD
SF9TSFNUS19TSFNUSykpCiAgICAgICAgICAgICAgICByZXR1cm4gMDsKQEAgLTIxMiwxNyArMjEx
LDEyIEBAIGludCBhcmNoX3Noc3RrX3ZhbGlkYXRlX2Nsb25lKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dCwKICAgICAgICBzc3AgPSBhcmdzLT5zaGFkb3dfc3RhY2sgKyBhcmdzLT5zaGFkb3dfc3RhY2tf
c2l6ZTsKICAgICAgICBhZGRyID0gc3NwIC0gU1NfRlJBTUVfU0laRTsKICAgICAgICBleHBlY3Rl
ZCA9IHNzcCB8IEJJVCgwKTsKLSAgICAgICBvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShzc3ApOwor
ICAgICAgIG9mZnNldCA9IG9mZnNldF9pbl9wYWdlKGFkZHIpOwogCi0gICAgICAgLyogVGhpcyBz
aG91bGQgcmVhbGx5IGJlIGFuIGF0b21pYyBjbXB4Y2hnLiAgSXQgaXMgbm90LiAqLwotICAgICAg
IGNvcHlfZnJvbV91c2VyX3BhZ2Uodm1hLCBwYWdlLCBhZGRyLCAmdmFsLCBtYWRkciArIG9mZnNl
dCwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih2YWwpKTsKKyAgICAgICBpZiAo
IWNtcHhjaGdfdG9fdXNlcl9wYWdlKHZtYSwgcGFnZSwgYWRkciwgKHVuc2lnbmVkIGxvbmcgKiko
bWFkZHIgKwpvZmZzZXQpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhwZWN0
ZWQsIDApKQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CiAKLSAgICAgICBpZiAodmFs
ICE9IGV4cGVjdGVkKQotICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwotICAgICAgIHZhbCA9
IDA7Ci0KLSAgICAgICBjb3B5X3RvX3VzZXJfcGFnZSh2bWEsIHBhZ2UsIGFkZHIsIG1hZGRyICsg
b2Zmc2V0LCAmdmFsLCBzaXplb2YodmFsKSk7CiAgICAgICAgc2V0X3BhZ2VfZGlydHlfbG9jayhw
YWdlKTsKIAogICAgICAgIHJldHVybiAwOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJp
Yy9jYWNoZWZsdXNoLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2NhY2hlZmx1c2guaAppbmRleCA3
ZWU4YTE3OWQxMDMuLjE1MDBkNDliYzNmNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJp
Yy9jYWNoZWZsdXNoLmgKKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9jYWNoZWZsdXNoLmgKQEAg
LTEyNCw0ICsxMjQsMTUgQEAgc3RhdGljIGlubGluZSB2b2lkIGZsdXNoX2NhY2hlX3Z1bm1hcCh1
bnNpZ25lZCBsb25nIHN0YXJ0LAp1bnNpZ25lZCBsb25nIGVuZCkKICAgICAgICB9IHdoaWxlICgw
KQogI2VuZGlmCiAKKyNpZm5kZWYgY21weGNoZ190b191c2VyX3BhZ2UKKyNkZWZpbmUgY21weGNo
Z190b191c2VyX3BhZ2Uodm1hLCBwYWdlLCB2YWRkciwgcHRyLCBvbGQsIG5ldykgIFwKKyh7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKKyAgICAgICBib29sIHJldDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICByZXQgPSB0cnlfY21weGNoZyhwdHIsICZvbGQs
IG5ldyk7ICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICBmbHVzaF9pY2FjaGVfdXNlcl9w
YWdlKHZtYSwgcGFnZSwgdmFkZHIsIHNpemVvZigqcHRyKSk7IFwKKyAgICAgICByZXQ7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKK30pCisjZW5k
aWYKKwogI2VuZGlmIC8qIF9BU01fR0VORVJJQ19DQUNIRUZMVVNIX0ggKi8KCg==

