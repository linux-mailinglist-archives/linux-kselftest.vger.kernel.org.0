Return-Path: <linux-kselftest+bounces-18490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE26988834
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1081C22E8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE81C172B;
	Fri, 27 Sep 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhA56BEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C56149C6D;
	Fri, 27 Sep 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450534; cv=fail; b=f5jBWmBy7Co7yOjdLyQkumyKjGNMEOprg2GTIyATo17HevArH6LNOLt/KfvRgbOnV6t3ePFh4MmPVOfX4UxxdJQlW2Ns4XRTJUO69RFmyvTQjAC1qmSJJ/LObcRIUChcX8wMY8n/kI2Pve1YUVXhJGx87nsFky4BRorg0oi9Myc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450534; c=relaxed/simple;
	bh=F6ojjfNW772gUwd88MoIhGybCs7SRN3beqtzaW+I5j4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsND6l17sSZUpUA4bXDKb0Z13l/YMtPSf8W7gnd9Uqzc39A3VkTjJwr7wGJV9aBwsxaEP5pt0qH3pLCGW6j0y/PzTwJOpP0XNFKJy9XSTnC7giIoSdOMf+FY/19pgpir0X+Q5S7QRGpMw9ALD/a7ravaYiSaX9Yh7XCgLzg6fDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhA56BEo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727450533; x=1758986533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F6ojjfNW772gUwd88MoIhGybCs7SRN3beqtzaW+I5j4=;
  b=lhA56BEoUHEFneVBmy1yJmdEJYSNvPkPRuPa5crjcLJKCHT3MReuRDQx
   w0w2MTAxBvQhSrtW+rgeMZwM/9TTCnon49XUGqn6TzOnbQZZ+R7H2PJaJ
   lU6atf2G9Ju3samQ1xhO9VEWpjmkBiEAkscM0/iMSQ3gkuZqNuftb9nam
   WGyeh8VdrJ7ZvgAuawYTfaO3T+AoxlnPNOq/7mzvhMJgNz2+tqebhGZgW
   v9pkQGhmttGG823+BLXWwThrxm9jZwf+QohU3ujYV1/jdFc2aJ7xtf+zl
   5XFVKdr+E8/DOT/6+09jKLOf+XVdGnhagZ40iLxAKMFEDzI4TvfhIduuP
   g==;
X-CSE-ConnectionGUID: 2X95xlOHRsi2+LRMJXJ7AA==
X-CSE-MsgGUID: /NahZuoqTy+xHqHTm+D/lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="30489725"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="30489725"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 08:22:09 -0700
X-CSE-ConnectionGUID: s5AiOhRwQm6UGt2VMtzrSg==
X-CSE-MsgGUID: zRiwsyVcRXiRkhm3Dvo/LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="77350342"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 08:22:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 08:22:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 08:22:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 08:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzG1eOghzXIuGITvwFdZdmxNyN/KIMblnGw10nT+SdiDQP+2fOKE4Q5LgGHkX7JHU2bqE98kay1BBPT05KlTbvw51TUYvyzN4zTRpTTp5YyfVCr6KRHodBiPtmJULzyexbFOQCUokmoqskmZ8Xvsb+RlohQ3wPDKJHRyntp1pgSD0iZJ4nEZiYPcabZHCPy2fEezfXrjYJ8fCsw7ozmVPeVq9yRmaUj+MjKkSaS/RQequHpS9AzfL8g72zwh0I41lMORqqx04XXYHbI34PULmOXIjx+R953DhOJsfxOMMhKCgO8ISMLQn3JSkbThE9EupOSzhMasZzlfSE4rBScjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6ojjfNW772gUwd88MoIhGybCs7SRN3beqtzaW+I5j4=;
 b=ffYjBxuDpnxDuBrjkGS2GZ2N4Dk4NWxWYKelBWKtnGlZNoxV9jXqnLzwNk69TsHTRJ6vtEgHpnSs02DpCpJutnpkCFFfNGTLo0bVn3feJi614Q74/ABOEtYFu4KhCSO0lOtPeZbr35VsB1RZ4NFl1eDXi3kd0W0sg9EyePwBZYON/LfN1pBaJxhqOebR23PPpd9s+POUDy/2dgHTrx/HfovH4LdKWNH7RoVGjoBAiOIb6s8IA7mjR61jQbo6LqzEBOAHvV+Q0m2hH0fQH1Kd4wZFm6QEKDX+nbkDIm9VOQzbL1ATJ6CLsf3hMJSWfSqt/6PvddsYgTxbktU71dqv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 15:21:59 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 15:21:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "will@kernel.org" <will@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "yury.khrustalev@arm.com"
	<yury.khrustalev@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bsegall@google.com" <bsegall@google.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAIAABi0AgAAX+ICAALiNgIAANM8AgAAYugCAOZcagIAAbUIA
Date: Fri, 27 Sep 2024 15:21:59 +0000
Message-ID: <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
	 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
	 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
	 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
	 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
	 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
	 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
	 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
	 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
	 <20240927-springen-fortpflanzen-34a303373088@brauner>
In-Reply-To: <20240927-springen-fortpflanzen-34a303373088@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA0PR11MB4767:EE_
x-ms-office365-filtering-correlation-id: 44e1aad8-9fbf-4a70-472c-08dcdf082151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXU5K1ArckVQNEFxdWREQU5ya2VWWnUrekZlYi8wZzFpVUZIODBzcTFvdHlx?=
 =?utf-8?B?dG9ic3VuQWViK1ZxSDRoNEI4NlR6d1RYNUpMZ3ZTQytWVG5GUHBNRmRTR3hw?=
 =?utf-8?B?b29uNGZ1OFBlajBFNDh6aCtub3NmQVFRNnNPMzhkVlh3NVpXdyt1MUUzVno5?=
 =?utf-8?B?dGtSMCtmL29IbWwxN3IrR0oxTlZHM3B2MDRrbTQrb0psZmNxVW93L0dHSFBZ?=
 =?utf-8?B?S2tmV1M4bTE2UkFxbWY3SkkvcXpweC92Z21TdGJnOHpCQVE2KytMeDZjYmhM?=
 =?utf-8?B?UDdDQnNad3ZmMEdvNWRPVFFIMGFtU1VEa0ZyZG5xVllVdzRRRXB2TExHSzJV?=
 =?utf-8?B?blgrRUJ3WTU3cHQrcUwwMDVRWXNhYWJsL3E4eXBzNUdraTBZdjRSeFN5ZElV?=
 =?utf-8?B?TTMyeVJwdXVHMk1EVkNmclNKZDRha09DM1NoSy9PUXZHS3F3VndBSy8rRE5q?=
 =?utf-8?B?cWFXZnhwcDUxbDFIZ2o2ZUhQY0s0aTlkMkNubHVaMWRPVjErbFRMWEVKdjRa?=
 =?utf-8?B?S2Z5NVk4TGlFaUp5eE5aT2hOa0FRM0dVVHMwand3NXorRWhSRVFiWU1XekFF?=
 =?utf-8?B?V3NDcTVYYUdpWHY4UWQvdlFUaEROS0JEcXZBbExNZ3lIbnkwVTN0S04yQ2ZT?=
 =?utf-8?B?V2kzUGFKa1Bra3ZRam11SHhvYXIwbGhvV1JSbE9GRSt4MVVKVnZpRHlaaC90?=
 =?utf-8?B?RmVYRjY3Q0RKNjA5MWJXNm9CTkwycTVYWGp4S3VEeTZaMXUwZXgra0NuTjZW?=
 =?utf-8?B?d2JMZ2QzTzFKaWhKZEF5SU42Q04xMHdyb2x5eld0TTA1UXU5dVh1eVlBOUNK?=
 =?utf-8?B?VEJsR0JSUXJsNUlRRFNpTVcxckNwOVFGSkN5bWVKbW9NSVJwQnNnVEtaOWI2?=
 =?utf-8?B?bkVYM3MvMXhKQnNpNjF0dGx6L1BHUlZzcEsvcHcwaGpqZWUrc0swU3F2S3p1?=
 =?utf-8?B?aitHQTZQRFRnWWZHTlN6RTZiRk4rY0JEUU1HanBmVUswM00yL0JIMXFxbHor?=
 =?utf-8?B?UzMvdHU0d2prMUdNb1Z1NFdXSlNqcXFRSzI0RFZoZDdEM1dldk5ybXFKSEpr?=
 =?utf-8?B?eDlHMWFKTEJmTGRWZW5jUC9VV0llZ2FvNVpsYTVUYlQrTjVnbVh4M2xQMmxp?=
 =?utf-8?B?RUdGTWovSXNyZmhKclZOOE1PaXplVThnT1dReTJ6Zk1WeDh1Sy9RV2VjSDdh?=
 =?utf-8?B?YU1oK09BdVVWT2tDZ1FVRm0wVHYrOHdaejVVTTJmeGI3Nll1ZzlSZEpqQ1dQ?=
 =?utf-8?B?MXhXQWdLMVAyTlY2bDF0emsvQTRCMEdxSjZvd0JQK0ZhSXBMdFBhZXZEb2hG?=
 =?utf-8?B?cU1GMHhaV2d4NjJIeG1Xa1ZTRnFyQTY0OWRQcU9DbGVWd2pPcEUxU1pvZEc2?=
 =?utf-8?B?aERyeUlPaW1BOTVDV1NrM0JmQll2ZXNJc09mU25xZ2xJRlFrUGxhK3hvd3lQ?=
 =?utf-8?B?YVpYM2N3b3diOWFnbllEejlseEl3cUpVNGJVTWVnODFQU0VsMmpTZGphWS9a?=
 =?utf-8?B?U3dIREtRQmhNejg0ZmVZdCtHMU82UmxEdFhKYVFRTjNwMUJvYVlIdkt2L3lO?=
 =?utf-8?B?Nzc1ZEh3Z0lQT3RBVFNKd1lXVWZQTnBydE9pSUs4N1VhWmQ1b3lYSCs4bnBk?=
 =?utf-8?B?OG9oT3dWL3d5UFpQV0xrek5waWFPMmVWM0ovV0tYc2duVDd0ci9hRHFabFdq?=
 =?utf-8?B?dGhpdWlQVTF1Z3FPVWdDSHJXZnhyVStZbWM4T0FGSVRaY2JKTFJibFRLYTFD?=
 =?utf-8?B?L0ozMUxLRm5WTWd4QXNvQlNvdU41ZHVuNWVtR2xmVVF6bXVHZHpaUW5xK2tp?=
 =?utf-8?B?QUpSdVNOUVFtU2tyb20wL200OWg5bWk3OUR6MXVXZXhMU0J0TGt6L3MyR3F4?=
 =?utf-8?B?U0IreDBsR2lMc1VVQ3hjV09vUkgzNzJydWsyV1pJZjNGR3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2o5TEQ4K0pIN1pobnREaHkyRm84amZBSWhnbWJ1SEFXMDJFdlpBdktkRGpv?=
 =?utf-8?B?ZVZqWGtyQWJZbzRLYm1vYng4aVhoYWxHWW1JVGNsbjh5Zm5iVFNvUG5PWDVm?=
 =?utf-8?B?c0YxMGdVQlNoSmNPcjJuWkJZUDBnV0JyTFZ5U0Z3emh5UUNWMVEwRUI0U29W?=
 =?utf-8?B?WGJrS2lhUUwxdjNnaUpBak8zK2lieXV1M1B2NWlHYzFLTEplb2ZqVXZlQzJT?=
 =?utf-8?B?Y2Y1TW80MXFzWmg5aHlYNlk3cHZ6QmdPdVg2QzFpSU9pb2dXQTBWeFNrTjNn?=
 =?utf-8?B?cXRyM3dPd09VMWE2UmlFVTFESGVkYmc1aE5XSlpDR2xLcnNMTERiZHJOekdQ?=
 =?utf-8?B?M2EyM3lqSS9mL1l0bnJWYmR1eS9rUmZHOHpaWk5xa3NCZ3o2ZjVhejdobU9s?=
 =?utf-8?B?MVZna09YZ2JsTnNTVVpYWkNrUDRUYnZxZ09hUUVUb0g0cW9lREJrVGt2WDBx?=
 =?utf-8?B?MW5EZkUrZXpLQllFY2lldmduVUdSekNneWFyb3FpNjFlQVZtRmlwNjdteWlG?=
 =?utf-8?B?WXFkb0JkS3VDbnRDQnV6ajl3WkEyOFZIMGI2VUxSNTV6NURrTHAraHRaeGR3?=
 =?utf-8?B?aFZJb3dyU0xjclVFbUg0R1BnSG5MUlNMeGZzWWVxbnQ1cWVXdmxLMWpFUlZl?=
 =?utf-8?B?MGYzWWplVE5xZXBVdDRRWXZvWEtHSFVzUURHSVJyME02NXZBdFZFWE1vZngx?=
 =?utf-8?B?WENycmF4bldWSWtCQnExaWViYjFiVTlGZ0J5UU1YTVJES3RZazlDNENXeldt?=
 =?utf-8?B?RTVtS3lsWFRkS1VablBIU2RWdlRsd2s4MU51OFV3TEdpNU5lcXVyVHhnK3Vk?=
 =?utf-8?B?dW1tbk10M1ZuWVhSeVJTR0luVmFETGlhaG1LSTBrWnB5R2xYUXBJS2RVYlVm?=
 =?utf-8?B?ZWwxQmZLVlU0SUpZSTFjNjhhdWVEUjNlYVp6L2lGN1ZteDJHWldkQjQwZElE?=
 =?utf-8?B?RVdJVkt6ZndJejBVYUlCSlhhMDFubnVkZE9TZ0w3UmZDSFcyNHo2VDJsZU9n?=
 =?utf-8?B?cEUvVFJyODRXU1ZuZ0hLclNaYktzTW44eG1LU012N3VnL3JvaEo2V3hZNDdo?=
 =?utf-8?B?VG0rR3VqUmZqVXQzTVBFK3FId2ppVHcyRVUvVDJEVk5raGpsSEJGeHh2QklJ?=
 =?utf-8?B?YXdTYzZjdjN3c0F5d1A2TFIvL2cyRnNJRnMxcldVZllOMGNrck1VVVBDTEhz?=
 =?utf-8?B?NTJaZDhqS0p2aTIyeGxKa1pKQjM4QXV2eHFSZzNRdVJQODl1Q1d4Y2VTNTZO?=
 =?utf-8?B?dWxFMG55TDVPSm0xRjhhTVp2OHp3U3ZSUkpLK3lzeG5sTms3LzJQUjFnNWFR?=
 =?utf-8?B?TWx6dVVmV1BQbWcxUWFKNUtNSHBQZHZxMkhWLzdWdndwV1BGb2V0dU9KTS85?=
 =?utf-8?B?aEpTR1hhQm1zWVIvZ2x6QTVoaDdQd1pXZ1ZSQzN2SVoybkk5WjhzdnpLaVhB?=
 =?utf-8?B?NElVSkdLN3RJS2tMMWQ2OEI2LzdSMmZpWUN4SzdhS2NjVUxBUVUvVENoVWxo?=
 =?utf-8?B?MU00N21vdGY5OFFXK0hoSDhXdEtOY0pYMldyNDY4c2dDbDk5MnZNd05xWlFx?=
 =?utf-8?B?UkhVUWR2YWZ2Q3MxRU5jNHNtWVlBdDl0bUVzWm9oOWtiN2RyUWw1MWRGV2JP?=
 =?utf-8?B?QUNmN3RXV3h3NjZlVjIxNjRsQ2N0c3ptTEpVKzJQYWozVDhxOHhCSi9ZdHJr?=
 =?utf-8?B?eEFKdWxieUhxSnhadDdUcHk4bnN4NzRsNXFselovNjZjbXVTN0t4YUFiZ3ZX?=
 =?utf-8?B?VFVVRFdzcDVPT0RPUVhxUDFzT2ZtdlV0aFQrQzkyWEZJaWs5WDZ5UU1lazA3?=
 =?utf-8?B?OXFEWm56VUpDYWpkcFF1YkxWVXhxSnZIak9FV1dFSy9qSXEyZFJ1RmNVSlNT?=
 =?utf-8?B?bk5TQmVSUU4wSjJMaDVTdUdXKzZPUllYcis2SzJSaEZaSjdCQWltQUhFc1hw?=
 =?utf-8?B?S0xoWFJhYUNsY1BpREdnbUpEdUUvSEErQWw5aWlvSFo3UWRSUWhGamRRaTlt?=
 =?utf-8?B?QTlWTHkxOEhNYlpROENtRnhZVGRTaWNUNG1MbE92VW5VR3h4SUhmWEkycjhS?=
 =?utf-8?B?U1RMY2VUV2ZHbjUycHd3cjR6bDVzSUZDSjduNEpGNWNXN3NyOXRhUU9abWVB?=
 =?utf-8?B?UHAwNnFzaXRIZDRJK0w2VWZBM0ZVZ1FYRG8vdG9mTkY2aGZPbTA1b3N4OEtS?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5982996A34CEB4583F9C7784932DC20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e1aad8-9fbf-4a70-472c-08dcdf082151
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 15:21:59.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1B7BGdB24CjY0gaDcWAHg1s4wSfH/NAYy+qrE3rDeo5DB4gmobifhkKlJoeP3X4jg4rQaq1qq/1oiPcRMB3ko21IYbD+G1xgRpvDSGKq2aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA5LTI3IGF0IDEwOjUwICswMjAwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90
ZToNCj4gVGhlIGxlZ2FjeSBjbG9uZSBzeXN0ZW0gY2FsbCBoYWQgcmVxdWlyZWQgdXNlcnNwYWNl
IHRvIGtub3cgaW4gd2hpY2gNCj4gZGlyZWN0aW9uIHRoZSBzdGFjayB3YXMgZ3Jvd2luZyBhbmQg
dGhlbiBwYXNzIGRvd24gdGhlIHN0YWNrIHBvaW50ZXINCj4gYXBwcm9wcmlhdGVseSAoZS5nLiwg
cGFyaXNjIGdyb3dzIHVwd2FyZHMpLg0KPiANCj4gQW5kIGluIGZhY3QsIHRoZSBvbGQgY2xvbmUo
KSBzeXN0ZW0gY2FsbCBkaWQgdGFrZSBhbiBhZGRpdGlvbmFsDQo+IHN0YWNrX3NpemUgYXJndW1l
bnQgb24gc3BlY2lmaWMgYXJjaGl0ZWN0dXJlcy4gRm9yIGV4YW1wbGUsIG9uDQo+IG1pY3JvYmxh
emUuDQo+IA0KPiBBbHNvLCB3aGVuIGNsb25lMygpIHdhcyBkb25lIHdlIHN0aWxsIGhhZCBpYTY0
IGluIHRoZSB0cmVlIHdoaWNoIGhhZCBhDQo+IHNlcGFyYXRlIGNsb25lMigpIHN5c3RlbSBjYWxs
IHRoYXQgYWxzbyByZXF1aXJlZCBhIHN0YWNrX3NpemUgYXJndW1lbnQuDQo+IA0KPiBTbyB1c2Vy
c3BhY2UgZW5kZWQgdXAgd2l0aCBjb2RlIGxpa2UgdGhpcyBvciB3b3JzZToNCj4gDQo+IMKgwqDC
oMKgICNkZWZpbmUgX19TVEFDS19TSVpFICg4ICogMTAyNCAqIDEwMjQpDQo+IMKgwqDCoMKgIHBp
ZF90IHN5c19jbG9uZShpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAqYXJnLCBpbnQgZmxhZ3MsIGlu
dCAqcGlkZmQpDQo+IMKgwqDCoMKgIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBpZF90
IHJldDsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKnN0YWNrOw0KPiANCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YWNrID0gbWFsbG9jKF9fU1RBQ0tfU0laRSk7DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXN0YWNrKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gwqDCoMKgwqAgI2lm
ZGVmIF9faWE2NF9fDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBfX2Nsb25lMihm
biwgc3RhY2ssIF9fU1RBQ0tfU0laRSwgZmxhZ3MgfCBTSUdDSExELCBhcmcsIHBpZGZkKTsNCj4g
wqDCoMKgwqAgI2VsaWYgZGVmaW5lZChfX3BhcmlzY19fKSAvKiBzdGFjayBncm93cyB1cCAqLw0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gY2xvbmUoZm4sIHN0YWNrLCBmbGFncyB8
IFNJR0NITEQsIGFyZywgcGlkZmQpOw0KPiDCoMKgwqDCoCAjZWxzZQ0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gY2xvbmUoZm4sIHN0YWNrICsgX19TVEFDS19TSVpFLCBmbGFncyB8
IFNJR0NITEQsIGFyZywgcGlkZmQpOw0KPiDCoMKgwqDCoCAjZW5kaWYNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+IMKgwqDCoMKgIH0NCj4gDQo+IFNvIHdlIHRhbGtl
ZCB0byB0aGUgZ2xpYmMgZm9sa3Mgd2hpY2ggcHJlZmVycmVkIHRoZSBrZXJuZWwgdG8gZG8gYWxs
DQo+IHRoaXMgbm9uc2Vuc2UgZm9yIHRoZW0gYXMgaXQgaGFzIHRoYXQga25vd2xlZGdlLg0KDQpU
aGFua3MgZm9yIHRoZSBpbmZvIQ0KDQo+IA0KPiBNeSBwcmVmZXJlbmNlIGlzIHRvIGtlZXAgdGhl
IGFwaSBjb25zaXN0ZW50IGFuZCByZXF1aXJlIGEgc3RhY2tfc2l6ZSBmb3INCj4gc2hhZG93IHN0
YWNrcyBhcyB3ZWxsLg0KDQpEaWQgeW91IGNhdGNoIHRoYXQgYSB0b2tlbiBjYW4gYmUgYXQgYSBk
aWZmZXJlbnQgb2Zmc2V0cyBsb2NhdGlvbiBvbiB0aGUgc3RhY2sNCmRlcGVuZGluZyBvbiBhcmdz
IHBhc3NlZCB0byBtYXBfc2hhZG93X3N0YWNrPyBTbyB1c2Vyc3BhY2Ugd2lsbCBuZWVkIHNvbWV0
aGluZw0KbGlrZSB0aGUgY29kZSBhYm92ZSwgYnV0IHRoYXQgYWRqdXN0cyB0aGUgJ3NoYWRvd19z
dGFja19zaXplJyBzdWNoIHRoYXQgdGhlDQprZXJuZWwgbG9va3MgZm9yIHRoZSB0b2tlbiBpbiB0
aGUgcmlnaHQgcGxhY2UuIEl0IHdpbGwgYmUgZXZlbiB3ZWlyZGVyIGlmDQpzb21lb25lIHVzZXMg
Y2xvbmUzIHRvIHN3aXRjaCB0byBhIHN0YWNrIHRoYXQgaGFzIGFscmVhZHkgYmVlbiB1c2VkLCBh
bmQgcGl2b3RlZA0Kb2ZmIG9mLCBzdWNoIHRoYXQgYSB0b2tlbiB3YXMgbGVmdCBpbiB0aGUgbWlk
ZGxlIG9mIHRoZSBzdGFjay4gSW4gdGhhdCBjYXNlDQp1c2Vyc3BhY2Ugd291bGQgaGF2ZSB0byBj
b21lIHVwIHdpdGggYXJncyBkaXNjb25uZWN0ZWQgZnJvbSB0aGUgYWN0dWFsIHNpemUgb2YNCnRo
ZSBzaGFkb3cgc3RhY2sgc3VjaCB0aGF0IHRoZSBrZXJuZWwgd291bGQgYmUgY2Fqb2xlZCBpbnRv
IGxvb2tpbmcgZm9yIHRoZQ0KdG9rZW4gaW4gdGhlIHJpZ2h0IHBsYWNlLg0KDQpBIHNoYWRvdyBz
dGFjayBzaXplIGlzIG1vcmUgc3ltbWV0cmljIG9uIHRoZSBzdXJmYWNlLCBidXQgSSdtIG5vdCBz
dXJlIGl0IHdpbGwNCmJlIGVhc2llciBmb3IgdXNlcnNwYWNlIHRvIGhhbmRsZS4gU28gSSB0aGlu
ayB3ZSBzaG91bGQganVzdCBoYXZlIGEgcG9pbnRlciB0bw0KdGhlIHRva2VuLiBCdXQgaXQgd2ls
bCBiZSBhIHVzYWJsZSBpbXBsZW1lbnRhdGlvbiBlaXRoZXIgd2F5Lg0K

