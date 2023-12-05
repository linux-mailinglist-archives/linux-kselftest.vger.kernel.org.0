Return-Path: <linux-kselftest+bounces-1216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC48061A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 23:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9077A281FB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5056E2D6;
	Tue,  5 Dec 2023 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHplUQFE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43431137;
	Tue,  5 Dec 2023 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701814991; x=1733350991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=75nXF1PX/OGbg8oPuAHjox8625BmEXcwmrKZG+J08uQ=;
  b=HHplUQFEVO0e1A7Jg6q7q36MdKPHYK4V5zoaG+RbALo+cFTpcBr7pEHz
   ae+q0c+Z0BXut9ivuqE8VhgR7IanLX+FMqO42iFy+c9aEIvcrCefC5CFL
   VZcEGXEv77aAmNtisYHPaqwbE78NwckaBZ17VH12j1oaIoysnGriKY4kO
   A9xa5QTvRadt4+wnx7PsZaskQrJGH0KNDOgrHvORAPVqbG8Waf81Ry+Bg
   Xby1PAGn5Nad9t1teUnFd0rDzCKxbH894Z2IFNG2c0Deqifq1HVlcQZU6
   WyfN4uT7Ysj75Bm8aSmJOvR997Dfd04LrxjKESAyE+TK1w15wsERpFSam
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393701087"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="393701087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018358182"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="1018358182"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 14:23:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 14:23:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 14:23:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 14:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWqLruMR6atHz1H38Rlmt+o3oYbpvHWWaG8WX3B08bs0hTrsTM48I4wp9aUnlbxToEhzjkjsMzVLAtr/WoEOVIy0t/NTeZP84AyMP9eSBgmeJzyqOuEu3Vxdw5r7rXxrKxFuiooyZEiEG+O3WfalUediZ2ivWAN/GwAuDkAtVJRKbAe5dKPBm2qDXq0ExvVL6KTbo3uYbOFzP5CRTCnO4ZMnUyyPWNjTpWNMU9wmhmrttqf4CegqAZCeLsLZmudF8PUzqoVwDTS15r3VO6ItvRXZkH78oja+rB4PbPAn+un1JxgkGy8u9LKvj5J6Fg3UDBdLwgKiV9MmHdaHSeKNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75nXF1PX/OGbg8oPuAHjox8625BmEXcwmrKZG+J08uQ=;
 b=P5dw7JTZn3wt303hs+dm4SvLVU2DjFX1cVG/4Kq8nRaGV+DlshBTK6UQZJSHKgIdUbjqxxh3flpG21FL1sG/bwypzl1dhrVtn0Zq2MmGSK0ZnsaoHsSUKhQmmfXXuD9LL0DSbmErn8+nlM9R97xkpIwLPnpcFZdhJDJSwn8Cj9DVvgOTsK95JQa+WFGuDsvHdPtQlSDlPt7UdBReHc8+j+guggjA/JspRY8lKozXTttDhfiVIsXryvxE/R0jm3YtBbwzqihmUeCWJMurIyrxakB9cTaiEhGSC8lXKhHIM6IVknStqZ1DPqGSeyRiMBaSo8kKakpWrTFurUE5MEFcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB5422.namprd11.prod.outlook.com (2603:10b6:5:399::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 22:23:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 22:23:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Thread-Index: AQHaIimtYQoilRU6nUGk++gUbydlsbCZ3y+AgAECQ4CAAG14gA==
Date: Tue, 5 Dec 2023 22:23:08 +0000
Message-ID: <47bb581c20010552615125fce63e3c5c49d1c690.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
	 <61f80d032c6a630dd641c9b598b37c2eb40d51e8.camel@intel.com>
	 <ed665d6f-66b0-4eeb-8cf8-db852e017d6a@sirena.org.uk>
In-Reply-To: <ed665d6f-66b0-4eeb-8cf8-db852e017d6a@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB5422:EE_
x-ms-office365-filtering-correlation-id: 60a08633-fe5f-49fc-8911-08dbf5e0c21e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVqtnsDmO5I/Ik7tWs90Vljm2qJXUrtVRapEsTBQxUcFXbpmW5nKlW+CmnLzwkLmv+eSEdups/Eh92sQF5FRjAr/kK4/oaB//bdA8NcAyAGt1AbpQ2gk39DV0CrHGh1UjJ5LykVT5K8Yv1ozzy3seAYfjuauxo9ep8yyC8duz5/g9YFEIVzamIZHYGQ5hmxzHv5xxHTxcA6YjeTvD+KPetWKlErInWHhMoDG3dSBRcQ0qWPRizoRsvYZKL4Subzt9oAW/qFX0pLTlUS4EDdfmAHA+2q1XaF/qmwtH/YZh12oU+V+BadxdVqKsCW/E8Gj2eUdrBrITKZkCu0/Bd6y0R0HgNotxWSYshD6SCNDdcc5FGn9uinMYfCc+iadXKZ7kE1vfOyX6Yr966ItZqPc91/E8dL2867LyjagRK5eUjlnwdjxWuju56km+jDWOTacJJq6oyDJkyS7EHU0UrKcOQKmi6aDolyoHD8YaizH8xG6C1RWdTkS7oPHp1bccAiS7BMhonDHNvtlbYSHD4IAKH46X4N3mBwYUBw7URIlK8oQ+PGHQHuAt6Sc6H+KF1xtuXkt/A/EWqAnpRFSodHfvuqLuWFEtlJ86RKhUbiHC31mDIag00rioDS40bVbKf2V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(26005)(71200400001)(66946007)(66899024)(316002)(66476007)(91956017)(66446008)(64756008)(54906003)(6916009)(66556008)(86362001)(8676002)(4326008)(8936002)(41300700001)(76116006)(38070700009)(36756003)(7416002)(2906002)(4001150100001)(5660300002)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHB2N09aRFloN0d6b24zU1gyVEgwTjBrOW5nNDR6VWdZb0MzQ0R0SEkzWUwx?=
 =?utf-8?B?V2hDOGJPamUyRmswSTZzemtWcTB0L3k3OSt1a1pjM20rMDRLbzM5cUJURGdG?=
 =?utf-8?B?dlBwVnQ3cWJXRDg5cnFURmlWT2Nkd0RQcFY2L2NGQ3g3OEc1MU5qd0o0MUdG?=
 =?utf-8?B?MUdFWDBScytmbnNiMDFxVGpQUnEwa1BMcVBtY3c5SDM4SUJ3Y1pKdEVNdndG?=
 =?utf-8?B?eU1JUkxZaXNvSWZMbjZ1R2prSjd4N1RwTjJkTjM5ZGFDVlBwc0srbEc5T2dP?=
 =?utf-8?B?andVbGsyVVhkbUlpck5HK1RKdWtNUXU3VU5tL1ZZZmx1Y0h3cTV0RUdPYW5K?=
 =?utf-8?B?Q2JBQlBrQWJJa3NWcUtiL1N4ZU12aVVVYWJRQnppaitFcm5UMmhuRVNqNmZB?=
 =?utf-8?B?RE9wNTJMbWtHOHVsenJVVlcvaFZwN0FQTk5jWlJtdllYZ0lSbWljUmxMQ0Rr?=
 =?utf-8?B?bVgvQTZqYTdVeVdyaVMxdTZxeEpXK090bngrdzJZUUZuVjJvSkZMVmNHbWZM?=
 =?utf-8?B?cEcycVNOVC9QSzgzK29Fdyt5ZVVRNlRtdkJEbTE1THg3TXdKU1plOFZxd2U1?=
 =?utf-8?B?bW5oeVlGeVNWWENYazFoTkw5YmprUjg4WU51UFBIRisyYXpPUnBZMENDSk1i?=
 =?utf-8?B?OCt1Q3dtTnRoNGszcDlVYkRyNS9LUXhEZWxwZXVEVmhOZFRRemM2Y0N6c0tv?=
 =?utf-8?B?YWRjSDFwR2VCdTAvSmxQang1V1RMVTA1bkpzblNXSWp5cWZMdEZqRk4yckN1?=
 =?utf-8?B?c2YySkVHUzVsdlJXa0V3NzdZdnh4V0Foek1pQ0hHY3ZXMmp0RXJjYVRnblVi?=
 =?utf-8?B?am0ycHJKdHNqSEVpQ1VIWHIybXhyQVEvMHVJRlIxUGNzUWkvRnZHNi8xQmxQ?=
 =?utf-8?B?UXRTam9aZG9wNVZiLzB5akRndnIxQXdML3ZXR1pjN0lPdWttaHJyYUw4NHdr?=
 =?utf-8?B?RFZsWDFVcnZIeG8xcTd3V0kxM0M3TlE1cGJTYndXNkJCMTBmRHNQRDlZMlFx?=
 =?utf-8?B?cStteWkyVUFHM3J2dkpVSXJMR1NqWUNTTk1tdzh5ZDdDOEhBb3JiaWdEVk1O?=
 =?utf-8?B?dzRJY2lJZm1XS2pRd1Q1SWJlUEdKUHVCQmJ3MzZMM0d4OFJ6M3BLdCthRVl2?=
 =?utf-8?B?MjA2Z0N6VUlSc0JYNU9iK0h3d1VQNDVpdXRreFp0QTJXSWFGSk9kTEVuSysx?=
 =?utf-8?B?L2o5UXdoMGJWMnlRcTF1aEVhYUdPWmpqYnJVTDJEQkY4eDhHUks0bzVhRFQ5?=
 =?utf-8?B?Z3BhZU5nSjN0UDNxaVlQZkE0NnJhQU80eDhXTWJxWEM2WVNpRVdhMGtnRDkw?=
 =?utf-8?B?VTBLeU1ZclVaT3UzQlJOSkJKKzAyUFRQd3FPaElBdTR0NDJHYWVKMWI5RlJF?=
 =?utf-8?B?ajV5WTZiRjczRFFodm9KZlVKd2NzYlp0eGxLcHl0VFBmL01oYjRVOUhYSlU5?=
 =?utf-8?B?VGdOemxhbUFhU256cTV1anR1b3d4ODJzUm5VY01xUml0aFQvTTAxL3hvYzhz?=
 =?utf-8?B?dzl6TDJESHp2Ui80RW5lOXhUL2EyUHhyY2wybzRQQzdRaENaL2RMWDBGckNs?=
 =?utf-8?B?dis3bVBVTWFoY0dockxlM0l1YktGTVZYL0kvcFFzd2JNREp5dTgybE41UmN6?=
 =?utf-8?B?cjJaOUIrc2VVNHNGNGtYVURrVXVORDcxWGlaQ1B5SFZxdXFjOTM2ZkQ0UzRr?=
 =?utf-8?B?eFNBOXZiak5sTHpNbzNNZk1YemZEbG4yeVJRcThnMG0yYnJGQTVsK3hVQXJK?=
 =?utf-8?B?MTMxVEsvQTMwcFFvVjNBWXhrUWxlV0pZQnJ6VkNsdDRrZkVMQkRVT290eWFE?=
 =?utf-8?B?bWo4elFOdmpVVTJER1hLTHlqbEJrUUJmQTFqQ01uVGtKRXdtRURRN3RGVnRD?=
 =?utf-8?B?TVF2bHdTSXR1dkcxcFo5VExtUHlmeldvTnhPN2g3UENCVzdrOW9GTnIxYXd5?=
 =?utf-8?B?RGV1c3YxMzR5Z1VRYkJQRWl5SzQ3d2hPYWJ6Q1Q1U05saHhPdUQ5YTdSQjEw?=
 =?utf-8?B?NmU3bFpPMEl2MU5mSFVtVGM1NGpoVzVOaCs2WldPNEhObkdvOTA5eDB6ZkJR?=
 =?utf-8?B?dW9IWGJQTnRYU2laME9KODY1aXFGd1FwOWIzTHZlNkJpQWFXS0NWVGxyNEJ4?=
 =?utf-8?B?Q29pOXVHVmNFZkF0Vjl4TktxbUh3NXNlMHJYeUdRVVdnMktjUjBHbUlwdXRx?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5831F1132379D4A89338B21345EDF85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a08633-fe5f-49fc-8911-08dbf5e0c21e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 22:23:08.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sgwDIynkCE2NjfoZLRGKNaiXrBx8w/XoaC/A/94ijiBoWX9iSO6jg2v0XMm81BXVi82b2WMLJaa8GFP6HOymk6huKXZmKNaiNpihp34bro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5422
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTEyLTA1IGF0IDE1OjUxICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIERlYyAwNSwgMjAyMyBhdCAxMjoyNjo1N0FNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjMtMTEtMjggYXQgMTg6MjIgKzAwMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+IA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgc2l6ZSA9IGFkanVzdF9zaHN0a19z
aXplKHN0YWNrX3NpemUpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgc2l6ZSA9IGFkanVzdF9zaHN0
a19zaXplKHNpemUpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGFkZHIgPSBhbGxvY19zaHN0aygw
LCBzaXplLCAwLCBmYWxzZSk7DQo+IA0KPiA+IEhtbS4gSSBkaWRuJ3QgdGVzdCB0aGlzLCBidXQg
aW4gdGhlIGNvcHlfcHJvY2VzcygpLCBjb3B5X21tKCkNCj4gPiBoYXBwZW5zDQo+ID4gYmVmb3Jl
IHRoaXMgcG9pbnQuIFNvIHRoZSBzaGFkb3cgc3RhY2sgd291bGQgZ2V0IG1hcHBlZCBpbg0KPiA+
IGN1cnJlbnQncyBNTQ0KPiA+IChpLmUuIHRoZSBwYXJlbnQpLiBTbyBpbiB0aGUgIUNMT05FX1ZN
IGNhc2Ugd2l0aA0KPiA+IHNoYWRvd19zdGFja19zaXplIT0wDQo+ID4gdGhlIFNTUCBpbiB0aGUg
Y2hpbGQgd2lsbCBiZSB1cGRhdGVkIHRvIGFuIGFyZWEgdGhhdCBpcyBub3QgbWFwcGVkDQo+ID4g
aW4NCj4gPiB0aGUgY2hpbGQuIEkgdGhpbmsgd2UgbmVlZCB0byBwYXNzIHRzay0+bW0gaW50byBh
bGxvY19zaHN0aygpLiBCdXQNCj4gPiBzdWNoDQo+ID4gYW4gZXhvdGljIGNsb25lIHVzYWdlIGRv
ZXMgZ2l2ZSBtZSBwYXVzZSwgcmVnYXJkaW5nIHdoZXRoZXIgYWxsIG9mDQo+ID4gdGhpcw0KPiA+
IGlzIHByZW1hdHVyZS4NCj4gDQo+IEhybSwgcmlnaHQuwqAgQW5kIHdlIHRoZW4gY2FuJ3QgdXNl
IGRvX21tYXAoKSBlaXRoZXIuwqAgSSdkIGJlIHNvbWV3aGF0DQo+IHRlbXB0ZWQgdG8gZGlzYWxs
b3cgdGhhdCBzcGVjaWZpYyBjYXNlIGZvciBub3cgcmF0aGVyIHRoYW4gZGVhbCB3aXRoDQo+IGl0
DQo+IHRob3VnaCB0aGF0J3Mgbm90IHJlYWxseSBpbiB0aGUgc3Bpcml0IG9mIGp1c3QgYWx3YXlz
IGZvbGxvd2luZyB3aGF0DQo+IHRoZQ0KPiB1c2VyIGFza2VkIGZvci4NCg0KT2gsIHllYS4gV2hh
dCBhIHBhaW4uIEl0IGRvZXNuJ3Qgc2VlbSBsaWtlIHdlIGNvdWxkIGVhc2lseSBldmVuIGFkZCBh
DQpkb19tbWFwKCkgdmFyaWFudCB0aGF0IHRha2VzIGFuIG1tIGVpdGhlci4NCg0KSSBkaWQgYSBx
dWljayBsb2dnaW5nIHRlc3Qgb24gYSBGZWRvcmEgdXNlcnNwYWNlLiBzeXN0ZW1kIChJIHRoaW5r
KQ0KYXBwZWFycyB0byBkbyBhIGNsb25lKCFDTE9ORV9WTSkgd2l0aCBhIHN0YWNrIHBhc3NlZC4g
U28gbWF5YmUgdGhlDQpjb21ibyBtaWdodCBhY3R1YWxseSBnZXQgdXNlZCB3aXRoIGEgc2hhZG93
X3N0YWNrX3NpemUgaWYgaXQgdXNlZA0KY2xvbmUzIHNvbWUgZGF5LiBBdCB0aGUgc2FtZSB0aW1l
LCBmaXhpbmcgY2xvbmUgdG8gbW1hcCgpIGluIHRoZSBjaGlsZA0KZG9lc24ndCBzZWVtIHN0cmFp
Z2h0IGZvcndhcmQgYXQgYWxsLiBDaGVja2luZyB3aXRoIHNvbWUgb2Ygb3VyIE1NDQpmb2xrcywg
dGhlIHN1Z2dlc3Rpb24gd2FzIHRvIGxvb2sgYXQgZG9pbmcgdGhlIGNoaWxkJ3Mgc2hhZG93IHN0
YWNrDQptYXBwaW5nIGluIGR1cF9tbSgpIHRvIGF2b2lkIHRyaXBwaW5nIG92ZXIgY29tcGxpY2F0
aW9ucyB0aGF0IGhhcHBlbg0Kd2hlbiBhIHJlbW90ZSBNTSBiZWNvbWVzIG1vcmUgImxpdmUiLg0K
DQpJZiB3ZSBqdXN0IHB1bnQgb24gdGhpcyBjb21iaW5hdGlvbiBmb3Igbm93LCB0aGVuIHRoZSBk
b2N1bWVudGVkIHJ1bGVzDQpmb3IgYXJncy0+c2hhZG93X3N0YWNrX3NpemUgd291bGQgYmUgc29t
ZXRoaW5nIGxpa2U6DQpjbG9uZTMgd2lsbCB1c2UgdGhlIHBhcmVudHMgc2hhZG93IHN0YWNrIHdo
ZW4gQ0xPTkVfVk0gaXMgbm90IHByZXNlbnQuDQpJZiBDTE9ORV9WRk9SSyBpcyBzZXQgdGhlbiBp
dCB3aWxsIHVzZSB0aGUgcGFyZW50cyBzaGFkb3cgc3RhY2sgb25seQ0Kd2hlbiBhcmdzLT5zaGFk
b3dfc3RhY2tfc2l6ZSBpcyBub24temVyby4gSW4gdGhlIGNhc2VzIHdoZW4gdGhlIHBhcmVudHMN
CnNoYWRvdyBzdGFjayBpcyBub3QgdXNlZCwgYXJncy0+c2hhZG93X3N0YWNrX3NpemUgaXMgdXNl
ZCBmb3IgdGhlIHNpemUNCndoZW5ldmVyIG5vbi16ZXJvLg0KDQpJIGd1ZXNzIGl0IGRvZXNuJ3Qg
c2VlbSB0b28gb3Zlcmx5IGNvbXBsaWNhdGVkLiBCdXQgSSdtIG5vdCB0aGlua2luZw0KYW55IG9m
IHRoZSBvcHRpb25zIHNlZW0gZ3JlYXQuIEknZCB1bmhhcHBpbHkgbGVhbiB0b3dhcmRzIG5vdA0K
c3VwcG9ydGluZyBzaGFkb3dfc3RhY2tfc2l6ZSE9MCAmJiAhQ0xPTkVfVk0gZm9yIG5vdy4gQnV0
IGl0IHNlZW1zIGxpa2UNCnRoZXJlIG1heSBiZSBhIHVzZXIgZm9yIHRoZSB1bnN1cHBvcnRlZCBj
YXNlLCBzbyB0aGlzIHdvdWxkIGJlIGp1c3QNCmltcHJvdmluZyB0aGluZ3MgYSBsaXR0bGUgYW5k
IGtpY2tpbmcgdGhlIGNhbiBkb3duIHRoZSByb2FkLiBJIGFsc28NCndvbmRlciBpZiB0aGlzIGlz
IGEgc2lnbiB0byByZWNvbnNpZGVyIHRoZSBlYXJsaWVyIHRva2VuIGNvbnN1bWluZw0KZGVzaWdu
Lg0K

