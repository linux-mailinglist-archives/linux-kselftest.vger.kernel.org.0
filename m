Return-Path: <linux-kselftest+bounces-1153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E416805961
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A6FB20DE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D760BA3;
	Tue,  5 Dec 2023 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecwKIBmQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2706D42;
	Tue,  5 Dec 2023 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792123; x=1733328123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kXkLMdUd+/nRogFpB8r+tFz+0nb8qUHvaaVuvksCUi8=;
  b=ecwKIBmQjJG88+M2r/SUWRfD0klygTJ75Yiqn3hjw/3+w9SzFVM+y9o/
   2VtzAwwUDpJWMQJyc7Dth2PfUncU/WfkelqeUAvLQXt3Xvsm1CPbGjFuJ
   3EFb0smAh5m0Y/h66pgjKpX5z8hlOtwNhLJiWwPjIMqFmn5fL+XPMjLB8
   LUTOWaEC6aTTaeplfQWzoJwp8UIiGTL5CwTUND0V/3LILvVa4HF/WC3Ah
   FgXZWfPpMVk3VC3j7vsJ5xuOm2nXvOo9dp75KmFhLzaVDJ7Z52Hq5DVYi
   nSd2OGuhTz/NQHEYzC7Fi57DTGUtyyhR5llqqu35hQ0CH18nfgrFlfFlA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="795535"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="795535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805320116"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="805320116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 08:01:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 08:01:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 08:01:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 08:01:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 08:01:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIeQTf9dl+zML6PaGLEEhHa4BYlPrC5WCQXt4/eRF+0ZGFnfezSfPCPYZdS/JX3V9bwd8NnEraOMk4vcsTvjXgOv7G9UPkSEd5sPD3pJ9FAZ5T5Hh7PrVChnk1HsgN2QrHIG+4gMJ9wbdiyZoKThgt5Bh9+g32NgroZ8sJKmU85X93OBczvi7GZf1z1lfx/V93w9Oz6xml8BKQ+J+vnAibOqKFet9QhMPp5XZnxA8+k4cYc1q2X4nODEKF4OOPxw772ulFFoyUpRtn5PFIig+0BjEYvEtQHB80/E3EzW2l9+3+L3G1LbUrIcdjfNcA6kfSlaNbzOqfDnPlpLsWD6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXkLMdUd+/nRogFpB8r+tFz+0nb8qUHvaaVuvksCUi8=;
 b=Vzm3qj6FrBTivXZVqFmCVqcGA2DZrrDr77UFPh6+DTkTeeVL2qdHtOQ+EzV6UP03RXx1w31JuKZXAODNla8wnRp5Bqx6urjnzVi4XKhJTyGj2Nyl4d2xr9NK4gWVCod8Usa8q4NWmzI2Lie+bY+QO3rydpQFxuENZjqAsdZvvxmOW9x4cNGm1szVDfCmQS+AQvL7a5YJ5cJCBwRHqyrj0IgU7zStGEKlLFHi+/YJqeCzP7D/XFTePr0OqU+aTlo3ZfFXK7o1HSvCE972FUTpJ3PL93dAnFwp3BxK1tnbiJx+3IR48E1kbDKQBKrpcBkayccHqDLaeGgpvlROh/bSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7913.namprd11.prod.outlook.com (2603:10b6:610:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 16:01:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 16:01:50 +0000
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
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Topic: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Index: AQHaIim3AA2TizYED0GkvO+BE9w2Y7CZ2omAgAD6IwCAAA+1gA==
Date: Tue, 5 Dec 2023 16:01:50 +0000
Message-ID: <a6bf192a1568620826dd79124511ea61472873c8.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
	 <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
	 <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
In-Reply-To: <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7913:EE_
x-ms-office365-filtering-correlation-id: d12404c3-f91c-4f7e-a4a1-08dbf5ab7dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlWdIUuguKvGE0CFvYIqhKDE37pp7hbv1KagWQO3u2G5SA0ZYAqoGKdDM2gMiUO8Y5IoiT0s3BKAJuL3SVe3nK+XGfAfumnhru6+xZeAN8fbOW6h0iqoNHZdvmVx3W0AQgtZoX+Pz6QLAUwkd8DMsKOU+BuQEJa7dff5g65KiypGwRfjwG/v233tzdo5vBtyx+67whsxNLBnV8Qz673eCRDJBptBWyAKSno6BNvAuIow1HOqhF74Be0NryRe1SYtw3+z0pLDuk+tux1M+RC+DJtasCOYvz+sCOdS8+vUH71B5sw8xWcaT6zPLBiOHuokzqwa0b1r6CdmafPK4clUpha/Zrn/4fcu22f1BNyibn8cbjlLpjhuR7LnSzsOmX8U1jScDFNF+szlaJG9Ts+LJQcQzscf5yTnNg/Z9wbT45KjQCQsz5A5gjpCJOhQWQaywsDPDaOEIFWbFFZVQfR/TJWiigPA7n3Y8KgUAsJ4M4I2LGtIA6kOqoAOc5LSSrh0HEi/svcv4a1RhnJCeQqSEBJ0ek6bM1C0XuQO5asb79bk8kRtBN0Rpe0+85zN6OELaPyy2fE6CjoSMeXY117Z5GG+dKX/Dy233V2Yewdi7REu40oFSgxACS+XrnDp1CcN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(2906002)(316002)(66446008)(91956017)(64756008)(54906003)(66556008)(6916009)(66476007)(38070700009)(76116006)(86362001)(66946007)(8676002)(36756003)(41300700001)(8936002)(4326008)(5660300002)(38100700002)(122000001)(82960400001)(6486002)(83380400001)(478600001)(26005)(71200400001)(2616005)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlBBajFkRElPMWZTcHdGTFY3S05ka0JHUjBZM1BZdU9JOVRtVXVkcnBaNlFQ?=
 =?utf-8?B?RG1sN1REVTNVL0ZFa2xYd283UmQyZTdwb1o4ZzMwVzR2UXRHelhDYi9zNUJB?=
 =?utf-8?B?MkJyc2lXODBYZmxBdWdtc0Ura3pEeWY1RVd3T0lVMEg4VXkySXRZeUdIQjU4?=
 =?utf-8?B?aUdwMnl0SU9DSDFHS0xBMEZqSFFjeGFiRDlBczBSSE5zU2lDSFNWR1NMZEVV?=
 =?utf-8?B?WWRKVUVFNGZkWVE1ajh3ZkEvT1FaUmJPUzdadFpBYTBxaWdxUEpaWVdrRzhB?=
 =?utf-8?B?SUpBc0RGcCtPclNJV2Q2eTRYY2lUNnJ1NHl2akRWclpoMWxuMTNTUXNlYjIy?=
 =?utf-8?B?ZWVxYTRTUWlOYTdIVm1nN3ArSE0wMnpnRnF5UnBhTlB6dzB1YjZZZ3ZUclh5?=
 =?utf-8?B?RDJSQkExN3ZZZW1vYTlvTXlINlQ1Umdwck03cnhqV2MyZmQwNW5sOXJISmdp?=
 =?utf-8?B?RGpERlpqak5wTzlycHIyWG1WSFRDZVpOZUxmY0ZzcXMzYlF4NzhuY0RCNml3?=
 =?utf-8?B?TjNObjNoTjFpYk00c1pKTHVNQTlSd0laRGFsNDlyRytGQkJ0T3BldFM5Z0JX?=
 =?utf-8?B?MWZ0MDZVNkhRdllGYkh0VDhlT1h0OWJ1YmVSOVJ1UU9IOWEycW53V1N4TWww?=
 =?utf-8?B?ZmIzaGRwRU9sZ2ZPVXpMMzlxQjhoNlpTUlFuTEdBNlBSMFdpNWVhc0x2S3hV?=
 =?utf-8?B?ZmlCZWpJOTBUWHo4NHh0T0ZzeXBqTk45VHFYZXNwaWpQRnZySHYxTlo4L0d4?=
 =?utf-8?B?SWxzMUZCanVLRVNsSUd4U1pIYlV5SkFENHBkOWRNZ2cxbWwrdnE1MW1LeCtL?=
 =?utf-8?B?dDVEdlhnWHpsWWdLczF5ZHBiNEViR2MvaUsrcmRZRGRGYkN0L1RkVlRRT1Jq?=
 =?utf-8?B?dWdVbGR5RU5kLzdkRmkzWGxqeVA4TGFpTjhTOWdSMHZFbzVWMUgvMWIwOHNq?=
 =?utf-8?B?bE1xNXVMdjJTYmFuYVYvdmtXMG9ldlNQWGhWTjdodHcwZk5nbjNsQUtYQlBj?=
 =?utf-8?B?NGZsUzFGYzBsV2VINWN5S0xhRFRRbWRGZkhjZFZyTmFOU2txL3l0RlNlQzVw?=
 =?utf-8?B?OVFVNDRXaWpZSjlmVGxnTExZejdoWWhZYVZMblV0QWlhUjlzSzJXaCtudzdC?=
 =?utf-8?B?WEdINWFNWG5BVVpJNnI0NVVPRjZ4ODZVb3VvSFVWSENJQXVOQ0NpWTdxUzZG?=
 =?utf-8?B?SWwxdjl2MFVmRFlKb2o3Q1BoaGlOTllBMDkzTkVTQUtNSVJxc1BobGs5NEI1?=
 =?utf-8?B?VFJFMldxRmNwVmYzdjRrbDZ2dTQxWlpwQllRTTV3RkFlN1kwR0F5S2RINXNa?=
 =?utf-8?B?dnZyZkk3dGZmNEYwdnBqdFhVeTRtN0d2Q2R0ZmtFZThFY3ZyMHQrYjRldlAx?=
 =?utf-8?B?alpaZTA5QXZuZnlHTGNhaUVaNzB0UjRQa1pLRUZ0QlQ2M1ppaEkyTXNkR2dj?=
 =?utf-8?B?elNRdU1hbmVwazRZUW5Oa29SWnJESVY5MlZ3Qi83NWdocm9xS0hZYkh5VEJq?=
 =?utf-8?B?TFh6MXhUaEpVenVacTBnS2tOWnlzUDlIOXd4RXFCc1l0SENwQm9nQzV0Nm8w?=
 =?utf-8?B?ZmdETTlESWkzWnpTeTFwTGdWMXRHdU5kalYwNkdoanJaVDM3M3pFZ1VUVTR2?=
 =?utf-8?B?cTNDUTdwU29FSWgxVFF1TUhTNXFXc0Roc2dqMlU2TE1TLzNDSy9VMVd0bENL?=
 =?utf-8?B?RnVncU9jOVlxdkNSclNmUisyNHhSMURnNGI1ZEJsOFZkeVJUWVJFaTlGK2Va?=
 =?utf-8?B?VzlMajI4MkRONTV4MXJENnFCZWJoaFhlUGpDZlhqamZqS25pUWRoMm5TRXpE?=
 =?utf-8?B?WXZtcVZ4ZCtxcTlvMzBWR0NJTzNJbjdaeWt6OVRVMWw4MFJUdlVYM3hMZklG?=
 =?utf-8?B?YkRtN1FYdFNCcDkxOTYvYnNDZ0FNN1RQeWFlY3NOYmxhM2pOdGh3aGR3VGpC?=
 =?utf-8?B?VWM0U0ZMMFBHMDZhbGpReEZJL2FPTStjRkYvV29mdHBxRlFWazc4USt1dTdY?=
 =?utf-8?B?cU1hSTZWV1JLbnJYN3FCL0xMMGRoUUgzWEVNbWlqT1JTdXBpd3hNa0JKVFAx?=
 =?utf-8?B?WFJOQ2pLZWlpTTZ3eFFTVnNOb2FubDI1SFdYWW90L3dPa1ZkUWNoZmUyQm14?=
 =?utf-8?B?emU4R2g0Z2E2Y1lGVlEwT3U5bnp3eGlxcDIxRjRhNkFYR09zaXhWbUFNak1n?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E65371E69E3A804282AC5BB2D841065D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12404c3-f91c-4f7e-a4a1-08dbf5ab7dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 16:01:50.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEkJzUeEN9M2L98wuGdkkzS+l0a9W7jvdPZSyKK/TxLC/i82DXfoLbL5mpvKVuV6z8msgl8uwsUZaEjmNPUbSYXEl91P+Ewzgnevsc4VzjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTEyLTA1IGF0IDE1OjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IEJ1dCBJIHdvbmRlciBpZiB0aGUgY2xvbmUzIHRlc3Qgc2hvdWxkIGdldCBpdHMgc2hhZG93IHN0
YWNrIGVuYWJsZWQNCj4gPiB0aGUNCj4gPiBjb252ZW50aW9uYWwgZWxmIGJpdCB3YXkuIFNvIGlm
IGl0J3MgYWxsIHRoZXJlIChIVywga2VybmVsLCBnbGliYykNCj4gPiB0aGVuDQo+ID4gdGhlIHRl
c3Qgd2lsbCBydW4gd2l0aCBzaGFkb3cgc3RhY2suIE90aGVyd2lzZSB0aGUgdGVzdCB3aWxsIHJ1
bg0KPiA+IHdpdGhvdXQgc2hhZG93IHN0YWNrLg0KPiANCj4gVGhpcyBjcmVhdGVzIGJvb3RzdHJh
cHBpbmcgaXNzdWVzIGlmIHdlIGRvIGl0IGZvciBhcm02NCB3aGVyZSBub3RoaW5nDQo+IGlzDQo+
IG1lcmdlZCB5ZXQgZXhjZXB0IGZvciB0aGUgbW9kZWwgYW5kIEVMMyBzdXBwb3J0IC0gaW4gb3Jk
ZXIgdG8gZ2V0IGFueQ0KPiB0ZXN0IGNvdmVyYWdlIHlvdSBuZWVkIHRvIGJlIHVzaW5nIGFuIE9T
IHdpdGggdGhlIGxpYmMgYW5kIHRvb2xjaGFpbg0KPiBzdXBwb3J0IGF2YWlsYWJsZSBhbmQgdGhh
dCdzIG5vdCBnb2luZyB0byBiZSBzb21ldGhpbmcgd2UgY2FuIHJlbHkgb24NCj4gZm9yIGEgd2hp
bGUgKGFuZCBldmVuIHdoZW4gdGhpbmdzIGFyZSBtZXJnZWQgYSBsb3Qgb2YgdGhlIENJIHN5c3Rl
bXMNCj4gdXNlDQo+IERlYmlhbikuwqAgVGhlcmUgaXMgYSBzbWFsbCByaXNrIHRoYXQgdGhlIHRv
b2xjaGFpbiB3aWxsIGdlbmVyYXRlDQo+IGluY29tcGF0aWJsZSBjb2RlIGlmIGl0IGRvZXNuJ3Qg
a25vdyBpdCdzIHNwZWNpZmljYWxseSB0YXJnZXR0aW5nDQo+IHNoYWRvdw0KPiBzdGFja3MgYnV0
IHRoZSB0b29sY2hhaW4gcGVvcGxlIGRpZG4ndCBzZWVtIGNvbmNlcm5lZCBhYm91dCB0aGF0IHJp
c2sNCj4gYW5kIHdlJ3ZlIG5vdCBiZWVuIHJ1bm5pbmcgaW50byBwcm9ibGVtcy4NCj4gDQo+IEl0
IGxvb2tzIHg4NiBpcyBpbiBiZXR0ZXIgc2hhcGUgaGVyZSB3aXRoIHRoZSB1c2Vyc3BhY2UgaGF2
aW5nIHJ1bg0KPiBhaGVhZA0KPiBvZiB0aGUga2VybmVsIHN1cHBvcnQgdGhvdWdoIEknbSBub3Qg
MTAwJSBjbGVhciBpZiBldmVyeXRoaW5nIGlzDQo+IGZ1bGx5DQo+IGxpbmVkIHVwP8KgIC1tc2hz
dGsgLWZjZi1wcm90ZWN0aW9uIGFwcGVhcnMgdG8gYnVpbGQgZmluZSB3aXRoIGdjYyA4DQo+IGJ1
dA0KPiBJJ20gYSBiaXQgbGVzcyBjbGVhciBvbiBnbGliYyBhbmQgYW55IEFCSSB2YXJpYXRpb25z
Lg0KDQpSaWdodCwgeW91IHdvdWxkIG5lZWQgYSBzaGFkb3cgc3RhY2sgZW5hYmxlZCBjb21waWxl
ciB0b28uIFRoZQ0KY2hlY2tfY2Muc2ggcGllY2UgaW4gdGhlIE1ha2VmaWxlIHdpbGwgZGV0ZWN0
IHRoYXQuDQoNCkhtbSwgSSBkaWRuJ3QgcmVhbGl6ZSB5b3Ugd2VyZSBwbGFubmluZyB0byBoYXZl
IHRoZSBrZXJuZWwgc3VwcG9ydA0KdXBzdHJlYW0gYmVmb3JlIHRoZSBsaWJjIHN1cHBvcnQgd2Fz
IGluIHRlc3RhYmxlIHNoYXBlLg0KDQoNCj4gDQo+ID4gVGhlIG90aGVyIHJlYXNvbiBpcyB0aGF0
IHRoZSBzaGFkb3cgc3RhY2sgdGVzdCBpbiB0aGUgeDg2IHNlbGZ0ZXN0DQo+ID4gbWFudWFsIGVu
YWJsaW5nIGlzIGRlc2lnbmVkIHRvIHdvcmsgd2l0aG91dCBhIHNoYWRvdyBzdGFjayBlbmFibGVk
DQo+ID4gZ2xpYmMgYW5kIGhhcyB0byBiZSBzcGVjaWFsbHkgY3JhZnRlZCB0byB3b3JrIGFyb3Vu
ZCB0aGUgbWlzc2luZw0KPiA+IHN1cHBvcnQuIEknbSBub3Qgc3VyZSB0aGUgbW9yZSBnZW5lcmlj
IHNlbGZ0ZXN0cyBzaG91bGQgaGF2ZSB0bw0KPiA+IGtub3cNCj4gPiBob3cgdG8gZG8gdGhpcy4g
U28gd2hhdCBhYm91dCBzb21ldGhpbmcgbGlrZSB0aGlzIGluc3RlYWQ6DQo+IA0KPiBXaGF0J3Mg
dGhlIGlzc3VlIHdpdGggd29ya2luZyBhcm91bmQgdGhlIG1pc3Npbmcgc3VwcG9ydD/CoCBNeQ0K
PiB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0IHRoZXJlIHNob3VsZCBiZSBubyBpbGwgZWZmZWN0cyBm
cm9tIHJlcGVhdGVkDQo+IGF0dGVtcHRzIHRvIGVuYWJsZS7CoCBXZSBjb3VsZCBhZGQgYSBjaGVj
ayBmb3IgdGhpbmdzIGFscmVhZHkgYmVpbmcNCj4gZW5hYmxlZA0KDQpOb3JtYWxseSB0aGUgbG9h
ZGVyIGVuYWJsZXMgc2hhZG93IHN0YWNrIGFuZCBnbGliYyB0aGVuIGtub3dzIHRvIGRvDQp0aGlu
Z3MgaW4gc3BlY2lhbCB3YXlzIHdoZW4gaXQgaXMgc3VjY2Vzc2Z1bC4gSWYgaXQgaW5zdGVhZCBt
YW51YWxseQ0KZW5hYmxlcyBpbiB0aGUgYXBwOg0KIC0gVGhlIGFwcCBjYW4ndCByZXR1cm4gZnJv
bSBtYWluKCkgd2l0aG91dCBkaXNhYmxpbmcgc2hhZG93IHN0YWNrwqANCiAgIGJlZm9yZWhhbmQu
IEx1Y2tpbHkgdGhpcyB0ZXN0IGRpcmVjdGx5IGNhbGxzIGV4aXQoKQ0KIC0gVGhlIGFwcCBjYW4n
dCBkbyBsb25nam1wKCkNCiAtIFRoZSBhcHAgY2FuJ3QgZG8gdWNvbnRleHQgc3R1ZmYNCiAtIFRo
ZSBlbmFibGluZyBjb2RlIG5lZWRzIHRvIGJlIGNhcmVmdWxseSBjcmFmdGVkICh0aGUgaW5saW5l
IHByb2JsZW3CoA0KICAgeW91IGhpdCkNCg0KSSBndWVzcyBpdCdzIG5vdCBhIGh1Z2UgbGlzdCwg
YW5kIG1vc3RseSB0ZXN0cyB3aWxsIHJ1biBvay4gQnV0IGl0DQpkb2Vzbid0IHNlZW0gcmlnaHQg
dG8gYWRkIHNvbWV3aGF0IGhhY2t5IHNoYWRvdyBzdGFjayBjcnVkIGludG8gZ2VuZXJpYw0KdGVz
dHMuDQoNClNvIHlvdSB3ZXJlIHBsYW5uaW5nIHRvIGVuYWJsZSBHQ1MgaW4gdGhpcyB0ZXN0IG1h
bnVhbGx5IGFzIHdlbGw/IEhvdw0KbWFueSB0ZXN0cyB3ZXJlIHlvdSBwbGFubmluZyB0byBhZGQg
aXQgbGlrZSB0aGlzPw0K

