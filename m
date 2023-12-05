Return-Path: <linux-kselftest+bounces-1100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9710804321
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 01:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1023F280FA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D16381;
	Tue,  5 Dec 2023 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+LRqqSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51562E6;
	Mon,  4 Dec 2023 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701735025; x=1733271025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mV3wbv9/rCdIaLHSBwH2Jafw+mLlcfWdg7Tc9QPwRJ8=;
  b=M+LRqqSBlpJvb8TwUuASUqCMe3FSwS8LTtQef6O+BvaOAeZUgFPVaMK/
   najBkxEOhuR7+fYoo1L2bNnxZUSP+xPVwb5t/12D27j6B67H/IcYRWMvj
   LtvJSSZRKLw1aI3IDJrYa7p/onb5mFyAk2zjYso3JaxW3gd+JIPpEjqD9
   rTvaiva4Fwj5HHnGrv5RBI/5lQt9u8KjcZzy50fWeRCNCYIj7nEVsyX+5
   UMmH2UIBOHsSuaMLT1M6MHStLB6Qij0/QeN5CmknOdgmz5Fn53DAlMHq9
   YmeO5TKxIfEHvxBQ/Y8ACquMduTgPqeZ3DLqPGICNElBkTWzzyXCb5q4a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15366093"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15366093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914600084"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="914600084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 16:10:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 16:10:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 16:10:23 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 16:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC9tK6qlTmkuVqukUrRuCAHES72h4vUP79jF5+qLDUNGM53/XtZIeczCEnZuNcfLd0pq3ux96xg3YRKFeBwjgofPdxQwMn4qijHaZbxn/azx8ZfyxouG/s4MnC5XUBscBYhnARnJ6ct10Z1k/sStlSoJehu2qOul+qkKM5b6isW0MLqRNSzVrjJxNEOvFoBxAMz0dYe7oNmr72W0+pqpDUL9daQ482la5yFVhm4ucYgR7jL7iPhdy1XYjy+ct2gfcJX7QdWgQ70vTlNQ9JdcCAJYbPYUCBtx0M6xX1JDiGdYrmzkGYCLJvF89C9ZYb8OAs6vbu0bCJ/2UanIW7Xq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV3wbv9/rCdIaLHSBwH2Jafw+mLlcfWdg7Tc9QPwRJ8=;
 b=CQeaSGMz+6waUCZEVWXsrcgeSp4Oo7rmwvdJQJTtI81hIT0Qid5r3f27BSLe5o1c8amr4efR+GdjHh4JLNNbijlCPT1pj4AyR5Y7P6h2QHbEwH5prRt7DJE6kxTkk8f363v386eTc5oilegwIeqA/u0pdftUEj77ry/bf55qxlKd6RVFNv3hNY966kDfhTAdwKjxZs/4rATz51woi6oM4BLZOTGkt/bDpKQguAhZhzr7oqQwEakQElXFEHXyfyB1SUWcB6/B90ovMPj9VKwqV7D4MvRwKHJUKOlKlAFkBwlGVxROKPMkZopWixkBjP3TSg85JyTPro75j8IztcLtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 00:10:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 00:10:20 +0000
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
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Topic: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Index: AQHaIim3AA2TizYED0GkvO+BE9w2Y7CZ2omA
Date: Tue, 5 Dec 2023 00:10:20 +0000
Message-ID: <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
In-Reply-To: <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA2PR11MB5035:EE_
x-ms-office365-filtering-correlation-id: c9e53e8b-1402-49ca-33a2-08dbf52691c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3UhuvyiC4dDNEe72X4fTaxlXY0TV8MdxKYLQzJCNixK+R07lOKiZhsrUQU0je27kObTDXExpoYsll7eGaYH9jQfAScMfvv53owz0wZQAUYKk/cGzofB5/zzPo5TYgAlynGsh7QY7L5FBMlkvXx6D+LO0g4lU17u54rHITxn3WWfsWcJeuPpn2RF8L9ZgcA2RKMUkq4sdc+iEPZG+Inm+zkz0UqO9SebDxor9GNOK/oQsxrCg20Npf+tko83F4MdqwlI7waNkUkzwPB7KJM5McnPkUwu4cGnKqbrEB+g9mAL3fs9EKKssK3vXAuP+xcDB5/zkfPFQ3zO4FnGEF1i84IGmNiGVGYVF8otcJ0ubqAL6uePUSPN95Y9vswYHmHCVtODVvULb/ikvIDEFMct7T/I0SOM8ZGKAHqKVTJoQB9jDnJ62SHqes7uUiAwde0ciIvCC8jad965uhFgUmpeNi7Qp+NOf1+HpP8QtBj3nripfITec82/M/Hc8D/tBp51vkigBZZ9GfO1uZ2gYdeLD+EMAKevQmEVgY4+1PFhI4wpGZermEHYo/HbdMfyPtTjgygU8N1GOy0jEpAt5nBkOEk7Mv1a2I1wMC1OuW5rkidQyXRn5uOQGH5cjF9zE/U/D6L25ydfnmGz0gyoZFaWeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(921008)(36756003)(41300700001)(5660300002)(2906002)(7416002)(86362001)(4001150100001)(38070700009)(82960400001)(83380400001)(91956017)(110136005)(122000001)(6506007)(71200400001)(478600001)(6486002)(26005)(2616005)(6512007)(76116006)(4326008)(38100700002)(8676002)(8936002)(54906003)(64756008)(66446008)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJwbHZpR2lNeW9zbHBQTXRvVzIzNHh2Mjk3U2VvTHdwN3pIT1BxT28yUkpo?=
 =?utf-8?B?enVjOFFMN2FTT3JYUmhxR3ZIZExyUjlpTFpCMlhYZjczc2NhYTNlOUhzMG1F?=
 =?utf-8?B?bkdFRWk1UEVFMG9aTjIvUXNEUFVENVdMN2pEekpDS2JERGpNVkpyNnhlMWxG?=
 =?utf-8?B?M0s2aVdaSWVINzViY09MS3BsYVRLQmpFeXhpOFdNN25uUXJOV2M0d0t3NG9s?=
 =?utf-8?B?L1l5d0JCWFhsMWk1VWVVdG1Kc0tseU9WckFraDhmekU1WHFzTE1rdTRFVnox?=
 =?utf-8?B?eFN6ZWx3cElQV1RYOG9YNzk1Z3hKVzA3U3p4RTNjRkFVWjQxeVMwMTNXSk5l?=
 =?utf-8?B?L0J1MDFJVDFEeGphTHJrbHcrL015cHdHYkwya2FreWZ6dk9NQTdJLzlLZTJn?=
 =?utf-8?B?ZU5COEVLMjFXRlR5R0ZZTmN4dkt0NDFuK2kyWlk4Q0lvbFdDdVkvQmlhN2NI?=
 =?utf-8?B?OVI0bkwxeEt5dk03NlVDT3p1b3VFcnlNc2FGd3hxMHJ2M21aWHE1WnJpWGJj?=
 =?utf-8?B?d21WZVEvSXpUQ1liOXl4aTJ6OG9NTVZRQmpLMkxOS2l2QitzZ293Wm9DL1Jz?=
 =?utf-8?B?bmNhWUFGVnJ0SHFJQzF5bys1eGdScWJYK0pUa3B3TDIrd21HejA5cTZhZmJp?=
 =?utf-8?B?Z2FhdWM0eDBwNDQyR0V0QTVUOUZteDYyazBBWWEwL2VMSmtKK1lHREplaVN4?=
 =?utf-8?B?WWJaTVBpOEZkMVlCWElZbmNySlR0RXIzMDAzR3FMREJFa09nVTV2aEhodU5M?=
 =?utf-8?B?bGFBb2EvaDVndk1jL3Y2WkRvS3RoMW80dUQ1QjRkb0xvYXY2eDBzV1RjdUdi?=
 =?utf-8?B?RGp3UUVHb1cyOUNNbzdQMmlpcUFPSngzR3ZFcjNxdUlOYjdQL0xkcmR6YUgy?=
 =?utf-8?B?N0Y5bGoyK2tmcjJWOFhOMUMvdGM2VUtRNnRxL2FBSXd0MkxFTTcxMUpzWmhu?=
 =?utf-8?B?amZRemlwTDdxZ2lQSm1uTkxaVlIvc0pNYVBLdE1ZYnF3UkVkaWVEUGxrVDdX?=
 =?utf-8?B?UzBVaG5PWFkwaWw5Vmc2T0pKR1JmS2NVemVZTE9yTFc4ekRyTTYreGVTV1V3?=
 =?utf-8?B?K1BoT0dmOFViK3FaRWd4b1kvRU5hRUhaUm5yY3RHZG1pRFNSUFNPRkpiTHF6?=
 =?utf-8?B?QllLRDBDZzJQQlhBZzBzQU9yNExtNStFdWZMNkRwOE96TFF3UHJHb053d3Vj?=
 =?utf-8?B?NWdoaFhMTG8ybmNQK1FBcmxNS3RtUDl6VUFRSUJ2UVl1M01kRlpTWm1iZkJ5?=
 =?utf-8?B?T1NzR1k1S2NnbDZxOHAyKzBod3BlMHI5Z1lqYnVZRWJEVThkRmhGenRBZkpW?=
 =?utf-8?B?ME4raFIyRFljVWZtSFRUWUNVMnQ3c3p2ODREU2x3d2hwL0IwVk92bVBidjkx?=
 =?utf-8?B?dDBtU0ZLRnkzOGFmeE5yY0ZZT2F0dlo0VEZ6b0VVUnl5UXpGZDc4bHhVNzlv?=
 =?utf-8?B?eVpYcHFPdEZ0MlNLSHdBTFIxdWhDZVFYOWRRWXhab25iL2xxMHd3dk9GTjVm?=
 =?utf-8?B?QUNyR3lyLzhhcy9RaGl2dW92OGUvSERYQ3pqOXNBZ1FJeE44cmdVdEVINW41?=
 =?utf-8?B?eklDT3I5dzBBbkN4bXNqaFRoM3kxbndQblc2bmxhV2RjVnNyUE01V2R3SkxO?=
 =?utf-8?B?UUJIU3E3aDRNTzVUU1Q4ZEhRdG5OQVZOMDBaK0t1UmZZa2svaS85akRYOC9M?=
 =?utf-8?B?bDlTUXc0dG0ySTR0ZGYrOWFnYisrR2pxK2wwUWtGZmp0M3RyVGxRejhlbGt0?=
 =?utf-8?B?U3R2RFRwQjBGSW5tSExtWDQ5bEY1cWxLc3B0S3BqTkVMM1hFLzlrbDdGZHpU?=
 =?utf-8?B?TDIzVG9PQTcvUHFxMDdzbjNVdVRTQTRqb2ZrVlBpU3BvbnRpNHcvRkNpckh0?=
 =?utf-8?B?aG0xODZKUTVJTWFmSVJJQ0F1bFF4N0JheDNZdk1pM1d5RjV0L1U3WTJQUm5P?=
 =?utf-8?B?ZDE0bk5uUURHMmF4NG9GK2RHYWM3WW9kRm9YYk5GaUF1bHZkRkJDeENTaG1s?=
 =?utf-8?B?TE5wMTdzNlJ4bHpHMEo2Zit5REhiNWR6WkpqUHlpYlF3VzlLdmRsblZEcVVQ?=
 =?utf-8?B?aFVpK2dQZnc1dXFkNXBHK0dCQWNTZUY3Z0FmdDU4R3RsUC9YVDJNV1MzSTBs?=
 =?utf-8?B?eS9YdGhUbTRsRHlzdXF2bE83cndBZ1oxOGtqemN2Y2QvdjhkQU54TVYyTktD?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8654CB3C5278F34F91E3326C7E6E8E54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e53e8b-1402-49ca-33a2-08dbf52691c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 00:10:20.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vg27yXse9vDfdwg81++Me81IRRtxA9jHtcufwqY9xIUkW96XloCeutG4aqwZhgKdvmYUnVTpMvcaudmWtLN6FPhlZpIanenL1m6hqSyCOpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTI4IGF0IDE4OjIyICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
DQo+ICsjZGVmaW5lIEVOQUJMRV9TSEFET1dfU1RBQ0sNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBl
bmFibGVfc2hhZG93X3N0YWNrKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoGludCByZXQg
PSBBUkNIX1BSQ1RMKEFSQ0hfU0hTVEtfRU5BQkxFLCBBUkNIX1NIU1RLX1NIU1RLKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKHJldCA9PSAwKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgc2hhZG93X3N0YWNrX2VuYWJsZWQgPSB0cnVlOw0KPiArfQ0KPiArDQo+ICsjZW5kaWYNCj4g
Kw0KPiArI2lmbmRlZiBFTkFCTEVfU0hBRE9XX1NUQUNLDQo+ICtzdGF0aWMgdm9pZCBlbmFibGVf
c2hhZG93X3N0YWNrKHZvaWQpDQo+ICt7DQo+ICt9DQo+ICsjZW5kaWYNCg0KV2l0aG91dCB0aGlz
IGRpZmYsIHRoZSB0ZXN0IGNyYXNoZWQgZm9yIG1lIG9uIGEgc2hhZG93IHN0YWNrIHN5c3RlbToN
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUzLmMNCmIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lMy5jDQppbmRleCBkYmU1MjU4MjU3
M2MuLjMyMzZkOTdlZDI2MSAxMDA2NDQNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Ns
b25lMy9jbG9uZTMuYw0KKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25l
My5jDQpAQCAtNDIzLDcgKzQyMyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVzdCB0ZXN0c1td
ID0gew0KIH0pDQogDQogI2RlZmluZSBFTkFCTEVfU0hBRE9XX1NUQUNLDQotc3RhdGljIGlubGlu
ZSB2b2lkIGVuYWJsZV9zaGFkb3dfc3RhY2sodm9pZCkNCitzdGF0aWMgaW5saW5lIF9fYXR0cmli
dXRlX18oKGFsd2F5c19pbmxpbmUpKSB2b2lkDQplbmFibGVfc2hhZG93X3N0YWNrKHZvaWQpDQog
ew0KICAgICAgICBpbnQgcmV0ID0gQVJDSF9QUkNUTChBUkNIX1NIU1RLX0VOQUJMRSwgQVJDSF9T
SFNUS19TSFNUSyk7DQogICAgICAgIGlmIChyZXQgPT0gMCkNCg0KVGhlIGZpeCB3b3JrcyBieSBt
YWtpbmcgc3VyZSBjb250cm9sIGZsb3cgbmV2ZXIgcmV0dXJucyB0byBiZWZvcmUgdGhlDQpwb2lu
dCBzaGFkb3cgc3RhY2sgd2FzIGVuYWJsZWQuIE90aGVyd2lzZSBpdCB3aWxsIHVuZGVyZmxvdyB0
aGUgc2hhZG93DQpzdGFjay4NCg0KDQoNCkJ1dCBJIHdvbmRlciBpZiB0aGUgY2xvbmUzIHRlc3Qg
c2hvdWxkIGdldCBpdHMgc2hhZG93IHN0YWNrIGVuYWJsZWQgdGhlDQpjb252ZW50aW9uYWwgZWxm
IGJpdCB3YXkuIFNvIGlmIGl0J3MgYWxsIHRoZXJlIChIVywga2VybmVsLCBnbGliYykgdGhlbg0K
dGhlIHRlc3Qgd2lsbCBydW4gd2l0aCBzaGFkb3cgc3RhY2suIE90aGVyd2lzZSB0aGUgdGVzdCB3
aWxsIHJ1bg0Kd2l0aG91dCBzaGFkb3cgc3RhY2suDQoNClRoZSBvdGhlciByZWFzb24gaXMgdGhh
dCB0aGUgc2hhZG93IHN0YWNrIHRlc3QgaW4gdGhlIHg4NiBzZWxmdGVzdA0KbWFudWFsIGVuYWJs
aW5nIGlzIGRlc2lnbmVkIHRvIHdvcmsgd2l0aG91dCBhIHNoYWRvdyBzdGFjayBlbmFibGVkDQpn
bGliYyBhbmQgaGFzIHRvIGJlIHNwZWNpYWxseSBjcmFmdGVkIHRvIHdvcmsgYXJvdW5kIHRoZSBt
aXNzaW5nDQpzdXBwb3J0LiBJJ20gbm90IHN1cmUgdGhlIG1vcmUgZ2VuZXJpYyBzZWxmdGVzdHMg
c2hvdWxkIGhhdmUgdG8ga25vdw0KaG93IHRvIGRvIHRoaXMuIFNvIHdoYXQgYWJvdXQgc29tZXRo
aW5nIGxpa2UgdGhpcyBpbnN0ZWFkOg0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvY2xvbmUzL01ha2VmaWxlDQpiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9N
YWtlZmlsZQ0KaW5kZXggODQ4MzJjMzY5YTJlLi43OTJiYzk2ODVjODIgMTAwNjQ0DQotLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvTWFrZWZpbGUNCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Nsb25lMy9NYWtlZmlsZQ0KQEAgLTIsNiArMiwxMyBAQA0KIENGTEFHUyAr
PSAtZyAtc3RkPWdudTk5ICQoS0hEUl9JTkNMVURFUykNCiBMRExJQlMgKz0gLWxjYXANCiANCitp
ZmVxICgkKHNoZWxsIHVuYW1lIC1tKSx4ODZfNjQpDQorQ0FOX0JVSUxEX1dJVEhfU0hTVEsgOj0g
JChzaGVsbCAuLi94ODYvY2hlY2tfY2Muc2ggZ2NjDQouLi94ODYvdHJpdmlhbF9wcm9ncmFtLmMg
LW1zaHN0ayAtZmNmLXByb3RlY3Rpb24pDQoraWZlcSAoJChDQU5fQlVJTERfV0lUSF9TSFNUSyks
MSkNCitDRkxBR1MgKz0gLW1zaHN0ayAtZmNmLXByb3RlY3Rpb249cmV0dXJuDQorZW5kaWYNCitl
bmRpZg0KKw0KIFRFU1RfR0VOX1BST0dTIDo9IGNsb25lMyBjbG9uZTNfY2xlYXJfc2lnaGFuZCBj
bG9uZTNfc2V0X3RpZCBcDQogICAgICAgIGNsb25lM19jYXBfY2hlY2twb2ludF9yZXN0b3JlDQog
DQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2xvbmUzL2Nsb25lMy5jDQpi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTMuYw0KaW5kZXggZGJlNTI1ODI1
NzNjLi5lZmY1ZThkNWE1YTYgMTAwNjQ0DQotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9j
bG9uZTMvY2xvbmUzLmMNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9u
ZTMuYw0KQEAgLTIzLDcgKzIzLDYgQEANCiAjaW5jbHVkZSAiY2xvbmUzX3NlbGZ0ZXN0cy5oIg0K
IA0KIHN0YXRpYyBib29sIHNoYWRvd19zdGFja19lbmFibGVkOw0KLXN0YXRpYyBib29sIHNoYWRv
d19zdGFja19zdXBwb3J0ZWQ7DQogc3RhdGljIHNpemVfdCBtYXhfc3VwcG9ydGVkX2FyZ3Nfc2l6
ZTsNCiANCiBlbnVtIHRlc3RfbW9kZSB7DQpAQCAtNTAsMzYgKzQ5LDYgQEAgc3RydWN0IHRlc3Qg
ew0KICAgICAgICBmaWx0ZXJfZnVuY3Rpb24gZmlsdGVyOw0KIH07DQogDQotI2lmbmRlZiBfX05S
X21hcF9zaGFkb3dfc3RhY2sNCi0jZGVmaW5lIF9fTlJfbWFwX3NoYWRvd19zdGFjayA0NTMNCi0j
ZW5kaWYNCi0NCi0vKg0KLSAqIFdlIGNoZWNrIGZvciBzaGFkb3cgc3RhY2sgc3VwcG9ydCBieSBh
dHRlbXB0aW5nIHRvIHVzZQ0KLSAqIG1hcF9zaGFkb3dfc3RhY2soKSBzaW5jZSBmZWF0dXJlcyBt
YXkgaGF2ZSBiZWVuIGxvY2tlZCBieSB0aGUNCi0gKiBkeW5hbWljIGxpbmtlciByZXN1bHRpbmcg
aW4gc3B1cmlvdXMgZXJyb3JzIHdoZW4gd2UgYXR0ZW1wdCB0bw0KLSAqIGVuYWJsZSBvbiBzdGFy
dHVwLiAgV2Ugd2FybiBpZiB0aGUgZW5hYmxlIGZhaWxlZC4NCi0gKi8NCi1zdGF0aWMgdm9pZCB0
ZXN0X3NoYWRvd19zdGFja19zdXBwb3J0ZWQodm9pZCkNCi17DQotICAgICAgICBsb25nIHNoYWRv
d19zdGFjazsNCi0NCi0gICAgICAgc2hhZG93X3N0YWNrID0gc3lzY2FsbChfX05SX21hcF9zaGFk
b3dfc3RhY2ssIDAsIGdldHBhZ2VzaXplKCksDQowKTsNCi0gICAgICAgaWYgKHNoYWRvd19zdGFj
ayA9PSAtMSkgew0KLSAgICAgICAgICAgICAgIGtzZnRfcHJpbnRfbXNnKCJtYXBfc2hhZG93X3N0
YWNrKCkgbm90IHN1cHBvcnRlZFxuIik7DQotICAgICAgIH0gZWxzZSBpZiAoKHZvaWQgKilzaGFk
b3dfc3RhY2sgPT0gTUFQX0ZBSUxFRCkgew0KLSAgICAgICAgICAgICAgIGtzZnRfcHJpbnRfbXNn
KCJGYWlsZWQgdG8gbWFwIHNoYWRvdyBzdGFja1xuIik7DQotICAgICAgIH0gZWxzZSB7DQotICAg
ICAgICAgICAgICAga3NmdF9wcmludF9tc2coIlNoYWRvdyBzdGFjayBzdXBwb3J0ZFxuIik7DQot
ICAgICAgICAgICAgICAgc2hhZG93X3N0YWNrX3N1cHBvcnRlZCA9IHRydWU7DQotDQotICAgICAg
ICAgICAgICAgaWYgKCFzaGFkb3dfc3RhY2tfZW5hYmxlZCkNCi0gICAgICAgICAgICAgICAgICAg
ICAgIGtzZnRfcHJpbnRfbXNnKCJNYXBwZWQgYnV0IGRpZCBub3QgZW5hYmxlDQpzaGFkb3cgc3Rh
Y2tcbiIpOw0KLQ0KLSAgICAgICAgICAgICAgIG11bm1hcCgodm9pZCAqKXNoYWRvd19zdGFjaywg
Z2V0cGFnZXNpemUoKSk7DQotICAgICAgIH0NCi19DQotDQogc3RhdGljIGludCBjYWxsX2Nsb25l
Myh1aW50NjRfdCBmbGFncywgc2l6ZV90IHNpemUsIGVudW0gdGVzdF9tb2RlDQp0ZXN0X21vZGUp
DQogew0KICAgICAgICBzdHJ1Y3QgX19jbG9uZV9hcmdzIGFyZ3MgPSB7DQpAQCAtMjIwLDcgKzE4
OSw3IEBAIHN0YXRpYyBib29sIG5vX3RpbWVuYW1lc3BhY2Uodm9pZCkNCiANCiBzdGF0aWMgYm9v
bCBoYXZlX3NoYWRvd19zdGFjayh2b2lkKQ0KIHsNCi0gICAgICAgaWYgKHNoYWRvd19zdGFja19z
dXBwb3J0ZWQpIHsNCisgICAgICAgaWYgKHNoYWRvd19zdGFja19lbmFibGVkKSB7DQogICAgICAg
ICAgICAgICAga3NmdF9wcmludF9tc2coIlNoYWRvdyBzdGFjayBzdXBwb3J0ZWRcbiIpOw0KICAg
ICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KICAgICAgICB9DQpAQCAtMjMwLDcgKzE5OSw3IEBA
IHN0YXRpYyBib29sIGhhdmVfc2hhZG93X3N0YWNrKHZvaWQpDQogDQogc3RhdGljIGJvb2wgbm9f
c2hhZG93X3N0YWNrKHZvaWQpDQogew0KLSAgICAgICBpZiAoIXNoYWRvd19zdGFja19zdXBwb3J0
ZWQpIHsNCisgICAgICAgaWYgKCFzaGFkb3dfc3RhY2tfZW5hYmxlZCkgew0KICAgICAgICAgICAg
ICAgIGtzZnRfcHJpbnRfbXNnKCJTaGFkb3cgc3RhY2sgbm90IHN1cHBvcnRlZFxuIik7DQogICAg
ICAgICAgICAgICAgcmV0dXJuIHRydWU7DQogICAgICAgIH0NCkBAIC00MDIsMzggKzM3MSwxOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlc3QgdGVzdHNbXSA9IHsNCiB9Ow0KIA0KICNpZmRlZiBf
X3g4Nl82NF9fDQotI2RlZmluZSBBUkNIX1NIU1RLX0VOQUJMRSAgICAgIDB4NTAwMQ0KKyNkZWZp
bmUgQVJDSF9TSFNUS19TVEFUVVMgICAgICAweDUwMDUNCiAjZGVmaW5lIEFSQ0hfU0hTVEtfU0hT
VEsgICAgICAgKDFVTEwgPDwgIDApDQogDQotI2RlZmluZSBBUkNIX1BSQ1RMKGFyZzEsIGFyZzIp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KLSh7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCi0gICAgICAgbG9u
ZyBfcmV0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQot
ICAgICAgIHJlZ2lzdGVyIGxvbmcgX251bSAgYXNtKCJlYXgiKSA9IF9fTlJfYXJjaF9wcmN0bDsg
ICAgICAgXA0KLSAgICAgICByZWdpc3RlciBsb25nIF9hcmcxIGFzbSgicmRpIikgPSAobG9uZyko
YXJnMSk7ICAgICAgICAgIFwNCi0gICAgICAgcmVnaXN0ZXIgbG9uZyBfYXJnMiBhc20oInJzaSIp
ID0gKGxvbmcpKGFyZzIpOyAgICAgICAgICBcDQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICBhc20gdm9sYXRp
bGUgKCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCi0gICAgICAg
ICAgICAgICAic3lzY2FsbFxuIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQotICAgICAgICAgICAgICAgOiAiPWEiKF9yZXQpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KLSAgICAgICAgICAgICAgIDogInIiKF9hcmcxKSwgInIiKF9hcmcyKSwgICAg
ICAgICAgICAgICAgICAgICAgIFwNCi0gICAgICAgICAgICAgICAgICIwIihfbnVtKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQotICAgICAgICAgICAgICAgOiAicmN4Iiwg
InIxMSIsICJtZW1vcnkiLCAiY2MiICAgICAgICAgICAgICAgICAgXA0KLSAgICAgICApOyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCi0gICAg
ICAgX3JldDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQotfSkNCi0NCi0jZGVmaW5lIEVOQUJMRV9TSEFET1dfU1RBQ0sNCi1zdGF0aWMgaW5saW5l
IHZvaWQgZW5hYmxlX3NoYWRvd19zdGFjayh2b2lkKQ0KK3N0YXRpYyBpbmxpbmUgX19hdHRyaWJ1
dGVfXygoYWx3YXlzX2lubGluZSkpIHZvaWQNCmNoZWNrX3NoYWRvd19zdGFjayh2b2lkKQ0KIHsN
Ci0gICAgICAgaW50IHJldCA9IEFSQ0hfUFJDVEwoQVJDSF9TSFNUS19FTkFCTEUsIEFSQ0hfU0hT
VEtfU0hTVEspOw0KLSAgICAgICBpZiAocmV0ID09IDApDQotICAgICAgICAgICAgICAgc2hhZG93
X3N0YWNrX2VuYWJsZWQgPSB0cnVlOw0KKyAgICAgICB1bnNpZ25lZCBsb25nIHN0YXR1cyA9IDA7
DQorDQorICAgICAgIHN5c2NhbGwoU1lTX2FyY2hfcHJjdGwsIEFSQ0hfU0hTVEtfU1RBVFVTLCAm
c3RhdHVzKTsNCisgICAgICAgc2hhZG93X3N0YWNrX2VuYWJsZWQgPSBzdGF0dXMgJiBBUkNIX1NI
U1RLX1NIU1RLOw0KIH0NCi0NCi0jZW5kaWYNCi0NCi0jaWZuZGVmIEVOQUJMRV9TSEFET1dfU1RB
Q0sNCi1zdGF0aWMgdm9pZCBlbmFibGVfc2hhZG93X3N0YWNrKHZvaWQpDQorI2Vsc2UgLyogX194
ODZfNjRfXyAqLw0KK3N0YXRpYyB2b2lkIGNoZWNrX3NoYWRvd19zdGFjayh2b2lkKQ0KIHsNCiB9
DQogI2VuZGlmDQpAQCAtNDQzLDEyICszOTIsMTEgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCiAgICAgICAgc2l6ZV90IHNpemU7DQogICAgICAgIGludCBpOw0KIA0KLSAgICAg
ICBlbmFibGVfc2hhZG93X3N0YWNrKCk7DQorICAgICAgIGNoZWNrX3NoYWRvd19zdGFjaygpOw0K
IA0KICAgICAgICBrc2Z0X3ByaW50X2hlYWRlcigpOw0KICAgICAgICBrc2Z0X3NldF9wbGFuKEFS
UkFZX1NJWkUodGVzdHMpKTsNCiAgICAgICAgdGVzdF9jbG9uZTNfc3VwcG9ydGVkKCk7DQotICAg
ICAgIHRlc3Rfc2hhZG93X3N0YWNrX3N1cHBvcnRlZCgpOw0KIA0KICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgQVJSQVlfU0laRSh0ZXN0cyk7IGkrKykNCiAgICAgICAgICAgICAgICB0ZXN0X2Nsb25l
MygmdGVzdHNbaV0pOw0KDQoNCg0K

