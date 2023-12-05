Return-Path: <linux-kselftest+bounces-1101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76380435F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9819281300
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C5393;
	Tue,  5 Dec 2023 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJTSkCTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71BA0;
	Mon,  4 Dec 2023 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701736031; x=1733272031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s70Q6o7V9+qsXOyrfuiMlLnQIbd5raBaGXalgsRtbS0=;
  b=hJTSkCTgCJMu4OL8XDDNaXjAlGlzJZiHsESHO8UM0XEhJuADHY8zcjvv
   iDvSim0WLynd88xq0urAEz3fBA42R9b16Emujqfc6QUMsX7qP3uK41SPM
   VEN8VdSJwhF14Q4jpKeDkIS0akb/G+D/vn3CttXAme1WIROxzLa16cGkx
   Ilnopb3wmJk/93UKKjFE10OwYPg1f2j7oAq9yNQ3H+iTmBQlzF6Z4bLXs
   J6uKOPU5OQE0nkusJRdTRBO48HaOcPxupj4xOq8ZIRvfiDXO5Ynih0mzD
   31YQ0ZiRICxH81sdAmBCejeLPwB8HU3GmDx1EPPOYIB+fDIV9RvQ9/2QL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378845811"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="378845811"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747015890"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="747015890"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 16:27:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 16:27:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 16:27:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 16:27:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 16:27:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjSTtJKKlYakjbCkaeaLAgeTPuQKE+Qpd3YMmWMHlCnjdsp3BKvlx+GhNs97E/VGWxmOjrretHmpsA35r1wfIVrcopPLnxOMHZ9qpl9ikiVMxPmSuBXRLRzSUmREW4U9fzs3A2LqcQRKnDkkzvMXQjve/X28/g2KIv6uhiEEQOQXWVvB2la45RwVUWfhvEUq0VHHnaQzMEwXgWMfNIivlTI/rGUlWx2Wa9E4SyJOoVgeTjfwDn1XDAFv1nx9QTnqs0DZOIY23CGPvv9BmhC8C0tlSwI4Vr+q7aI47URND6oj2AG3zpe4dAsdb+f2nnWvD/Rn7MdXtoEgL+Th13scDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s70Q6o7V9+qsXOyrfuiMlLnQIbd5raBaGXalgsRtbS0=;
 b=PlornQr2yrEkQdomy5eL164nLlH5NnnQGiL7xruyK++mhTobgBTvAyvwijbGQqadMN//SM9JgiuxRXKlq3eveVUevxOxOizEoPmfMlS5U+a32SIJpI0g3jKtxaEPRuTbf5UXpAYiCEhGnA52d35VbAnCffiljvPCKrz97PUZlz8/ptHZZOgGl5oUMhr40WzTYXDhok0CfhWhzRfwgmb88b/xAcvQRwnnvsfJRmDGhxllsjiniWDN1QdgBEzL5AECmyQMLlO+9wN2udY0PRvGt3GxpUofvBarVibb1n3HpXWeDHhdhZ2BZ/21x860wIBzrwTWBCr3xYrmPi1hXYdCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:26:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 00:26:57 +0000
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
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Thread-Index: AQHaIimtYQoilRU6nUGk++gUbydlsbCZ3y+A
Date: Tue, 5 Dec 2023 00:26:57 +0000
Message-ID: <61f80d032c6a630dd641c9b598b37c2eb40d51e8.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
In-Reply-To: <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB7876:EE_
x-ms-office365-filtering-correlation-id: a2bd98d9-680d-4cec-bcbf-08dbf528e436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VjHH+UpFA2Gc1cWQfOD1B2tbQLx3+CP5WPwNoV3Q5KJUlO7lh0kRdNcBzY37/jvimE2HCY+fjYFxTs+W51oMAHRGzX8s40KvSJ/Tp2HpcWP9/viXyX3TZax3YrNHqOYR2OSvRuSjUrAOiP9QKJ+OU2et+IpuG9efFH/YUKRONalTmz2BElFtlwd/FFfSvJW6vy3CyT43Mfu1yGLYzgLRINw5LfdmRRMsTf5P7W827T7434zPM8gByTAgLgeFR1gUr+74FKrqYxujiZU7MVVuaeCbDy+Krd+NGL/Dzv7aBRm1iCTn24NfytOl0kFAbmOBo0lKwaDpneoex1WeQOKrxkOwf1K0rGEyAMY3MbwTJOojoO/cUuXl6l1AKfHi3KNlYunHlOYTRKnohSejmTD1OLiBKLQR2Y+f4ogPhUV7SD9WV/VD+xGeRjExEB2LhWGmg8ZMZOkb6mXNsyWaVVxfonSAXYuzenDCaKalIWcLF2QLKW+A8bJBrQeBxY1fxqqXhLhgxAezQzdlsh7hrjzI8Ic1CE0u9IKFDE+pH9K3NkLP+jL7PS0iUayfDV6O5ElTN41t13rewtVXH59rHiDJI6/xNS90w+k1V5MB2QpuDf2KMa4chPJ8w7/ftrDmFa2MH0UAeKiniZLRgy4M8vMtNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(86362001)(921008)(2906002)(7416002)(4001150100001)(5660300002)(41300700001)(38070700009)(122000001)(71200400001)(6506007)(6512007)(2616005)(26005)(83380400001)(82960400001)(6486002)(478600001)(8936002)(8676002)(38100700002)(4326008)(64756008)(54906003)(66556008)(91956017)(76116006)(66476007)(316002)(66446008)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFnKytHRDAwSEc1M1BkWHNNUUh1RElNcTVQa0t1Q0tCOGt3RENuR1dzbllQ?=
 =?utf-8?B?M1hOcTJVOWJ2anpZR29NVzVsaDZId3pSWVdhSWhIcFZ3azNDalpSQUcvR1Q2?=
 =?utf-8?B?eEpYKzQvVG9HZGlZTjJnaFFNS2dBdWZJV2lEVTNNbVRWakhQODcwTkJMMGRX?=
 =?utf-8?B?amhaNmQyYjZJWVNzR1k4TTdiUzZ5blgrU1VwekZ4dHppR09hQ29rSWlraXpy?=
 =?utf-8?B?K3luclFFa3paSjEvZHRKdnFXYW9TaWV1d1c1UlUycmVXR0FlSUpMMjR2aHk1?=
 =?utf-8?B?cThSSlcyaTBiSzZVdGxzOWFjdlNRWUtZdGl2ayt5eXNmRE5raGV3U2p0OUhv?=
 =?utf-8?B?QStYdGtyT2NxUCtCR3VPZVV0aUw2R0RzNzFYMUp6Y2pMUHdFRStIZzMydjIr?=
 =?utf-8?B?RlpUZGthSWU5amRjQ1FJNmlBeSt2Ky85MmQ0U1RkTlFRNWJSSDNmQkJaTEJq?=
 =?utf-8?B?V0MrejJDV090Rnp0eWlwdmlMMUFnNENCUXpHMjhlRWJzWkRna1loZXFNSVVL?=
 =?utf-8?B?MWh1Wk5FaGxMTnQ3cEpXZGxneTNnUlE5U2M4OEE3cXhyZ2RpN1FhdDJQbVpi?=
 =?utf-8?B?TU9BQXpaRUhvTlpYbS9iWStxaDlMY3JMV3pzcXlIOXJnem95MGlGWC80bUU1?=
 =?utf-8?B?UlJHWWIvZkdxM0ZIL0J3djVZQ05kZGhXY2h4UVE0YktIbjRDL0w1TllhNHdO?=
 =?utf-8?B?M2RnRkZHSzc5U1pLZkYwQzVkalJjd2JvaC9iOVhsOXR3bWhIYlh3TkFoQ0Uz?=
 =?utf-8?B?KzJFREh1QXozSFVteTJsUGUxbXNEQnhOTDdjNUlrZnFHV0RtcXUxakU2STJN?=
 =?utf-8?B?VCt5bkxlNW55N25xRjBSaDFxT0dCSWhLSlhmbGhPQ2FTR0daZ0ZaREVqQ0M5?=
 =?utf-8?B?ZEM3aW1SaFMrT0NsZlhtcUtxdVM2THBHUDI1MElzMElLMld1eFQzTmpzRVc4?=
 =?utf-8?B?cE9FOGNoRm13UHpVZmMvcGtLMS9JTnlONnRmVlVlVjBMa25TODBhK2NKUi8x?=
 =?utf-8?B?QWZXZ2RvelU5UTZQWjFqbUc1MEwrUHVkS1p3aTd3TnNEN0JPVFg1YkU2YlAv?=
 =?utf-8?B?TW5HYTBnM1drbElhSm4vUDRraEFwcmQycWgvTlI5YWpSbVdSQjUxWjRNQ2xH?=
 =?utf-8?B?d004alJ5Vnl2ZHpaM3BUQ1pkeHZGbm8vU1RvcVNIZ0xFMmdLSmpHeS9ma0NZ?=
 =?utf-8?B?UVMrVExnQjNBWkY2QXVKcHVVQU5nRVRNUks2Wk5McHB3SlF3bU9UYkNBdk9L?=
 =?utf-8?B?VnY4d2I1SkNDTGt0L2cyT3hVOWM5RGJjbEh1ZDg5MmhUYnNkQ0JiT3htRUdG?=
 =?utf-8?B?UjBDRHJySm0vVVkwL2ZpWW82bHNSVDZySTNrV1BNRDdxbGpFSTY4Rm5DSTVk?=
 =?utf-8?B?WU5pQnJzUWljSk81Q25tVVArRFhGV0dGUTlDb2dXcjdoa0c4bWdYaUN0a3l1?=
 =?utf-8?B?eG5BeWp0OWtFTUQwd0d4d0s5ZjNKaGtrMDU2bDc1eXFObHpBNjhkQk1nN1RB?=
 =?utf-8?B?cVdWMGJRejgvY1h3UWtpU1NxbE1IOUxvbHMrYnUxSFp2dDUrVVJ5MmgwZVBE?=
 =?utf-8?B?QUJDcGl0VXgwdSsxZlpQYjNPYTlpUTg4djB2V0FJeDRSSVMzdjNhSlVnUWpF?=
 =?utf-8?B?N004MmtIMUk1dTRlaDBJbmptSXVSL1hnT1RjQ1RGU2FqODNaTzc5bVNRaVha?=
 =?utf-8?B?dnFLWFlaaWlSVWFiTzU3bTIvWmpQSytoUFIzYkZQaFc2ZnRGZXJHc0pGWHFI?=
 =?utf-8?B?MG1qWXBScFYwU0dMVGlVQUdqcTA4M0M3QzFEZGdGSGJ1UkFYRzBwVXJxRlhq?=
 =?utf-8?B?ZkVQQlBDSVZLaEN5M3ZLQ0tKN2hhQVNCTEIxMkozajZLOWRCbWQ2alNtL2xC?=
 =?utf-8?B?UHgwRXZXWTdmeUprOVJISUpMTEFmQVc0cVZvL0p0dytyNGdoL053dHJVVU1X?=
 =?utf-8?B?bzByNStmSkF2akduKzZrVGNjNmcyMDhHR2lQMWJwMytJSFJNcjBqVndqZXVB?=
 =?utf-8?B?UzgxVHRubjRBb2N6emxuZEdYa3VNZExRZDliY2hoMFJsODZEYWlwcDFyY0x6?=
 =?utf-8?B?QlZQeGFSWE96ellGdmltT25VZ1g5b2FieHh6aU4zL05QaVZWSDBJQ2hRUVov?=
 =?utf-8?B?Sms5L1ZObDJ4TG9KUTNubzY2bk9CK1JqK2JyYjhGaHRMdnJlL1hvMVJOcjhY?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCFADF285EA6A94B94A76879ED37AAEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bd98d9-680d-4cec-bcbf-08dbf528e436
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 00:26:57.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFvJdH8ZlYHReexwVxhXX0rmIUE7BXHWyE/v2D/wvj4XEap9dDQhXXJ44eVPoEMk+pGlRpGsraKzTbCkFgEix2F3pdOsOn6gRRJPSRKjo6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTI4IGF0IDE4OjIyICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IC11
bnNpZ25lZCBsb25nIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QgdGFza19zdHJ1Y3Qg
KnRzaywKPiB1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIHN0YWNrX3NpemUpCj4gK3Vuc2lnbmVkIGxvbmcgc2hzdGtfYWxsb2NfdGhy
ZWFkX3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCBzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MKPiAqYXJncykKPiDCoHsKPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHRocmVhZF9zaHN0ayAqc2hzdGsgPSAmdHNrLT50aHJlYWQuc2hzdGs7Cj4g
K8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncyA9IGFyZ3MtPmZsYWdzOwo+
IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGFkZHIsIHNpemU7Cj4gwqAKPiDCoMKgwqDC
oMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogSWYgc2hhZG93IHN0YWNrIGlzIG5vdCBl
bmFibGVkIG9uIHRoZSBuZXcgdGhyZWFkLCBza2lwIGFueQo+IC3CoMKgwqDCoMKgwqDCoCAqIHN3
aXRjaCB0byBhIG5ldyBzaGFkb3cgc3RhY2suCj4gK8KgwqDCoMKgwqDCoMKgICogaW1wbGljaXQg
c3dpdGNoIHRvIGEgbmV3IHNoYWRvdyBzdGFjayBhbmQgcmVqZWN0IGF0dGVtcHRzCj4gdG8KPiAr
wqDCoMKgwqDCoMKgwqAgKiBleHBsY2lpdGx5IHNwZWNpZnkgb25lLgo+IMKgwqDCoMKgwqDCoMKg
wqAgKi8KPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWZlYXR1cmVzX2VuYWJsZWQoQVJDSF9TSFNUS19T
SFNUSykpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICvCoMKg
wqDCoMKgwqDCoGlmICghZmVhdHVyZXNfZW5hYmxlZChBUkNIX1NIU1RLX1NIU1RLKSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoYXJncy0+c2hhZG93X3N0YWNrX3NpemUp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
KHVuc2lnbmVkIGxvbmcpRVJSX1BUUigtRUlOVkFMKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoC8q
Cj4gLcKgwqDCoMKgwqDCoMKgICogRm9yIENMT05FX1ZGT1JLIHRoZSBjaGlsZCB3aWxsIHNoYXJl
IHRoZSBwYXJlbnRzIHNoYWRvdwo+IHN0YWNrLgo+IC3CoMKgwqDCoMKgwqDCoCAqIE1ha2Ugc3Vy
ZSB0byBjbGVhciB0aGUgaW50ZXJuYWwgdHJhY2tpbmcgb2YgdGhlIHRocmVhZAo+IHNoYWRvdwo+
IC3CoMKgwqDCoMKgwqDCoCAqIHN0YWNrIHNvIHRoZSBmcmVlaW5nIGxvZ2ljIHJ1biBmb3IgY2hp
bGQga25vd3MgdG8gbGVhdmUgaXQKPiBhbG9uZS4KPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDC
oMKgwqDCoMKgwqBpZiAoY2xvbmVfZmxhZ3MgJiBDTE9ORV9WRk9SSykgewo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzaHN0ay0+YmFzZSA9IDA7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHNoc3RrLT5zaXplID0gMDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgLyoKPiAtwqDCoMKgwqDCoMKgwqAgKiBGb3IgIUNMT05FX1ZNIHRoZSBjaGlsZCB3aWxsIHVz
ZSBhIGNvcHkgb2YgdGhlIHBhcmVudHMKPiBzaGFkb3cKPiAtwqDCoMKgwqDCoMKgwqAgKiBzdGFj
ay4KPiArwqDCoMKgwqDCoMKgwqAgKiBJZiB0aGUgdXNlciBzcGVjaWZpZWQgYSBzaGFkb3cgc3Rh
Y2sgdGhlbiBkbyBzb21lIGJhc2ljCj4gK8KgwqDCoMKgwqDCoMKgICogdmFsaWRhdGlvbiBhbmQg
dXNlIGl0LCBvdGhlcndpc2UgZmFsbCBiYWNrIHRvIGEgZGVmYXVsdAo+ICvCoMKgwqDCoMKgwqDC
oCAqIHNoYWRvdyBzdGFjayBzaXplIGlmIHRoZSBjbG9uZV9mbGFncyBkb24ndCBpbmRpY2F0ZSBh
bgo+ICvCoMKgwqDCoMKgwqDCoCAqIGFsbG9jYXRpb24gaXMgdW5uZWVkZWQuCj4gwqDCoMKgwqDC
oMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoGlmICghKGNsb25lX2ZsYWdzICYgQ0xPTkVfVk0p
KQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArwqDCoMKgwqDC
oMKgwqBpZiAoYXJncy0+c2hhZG93X3N0YWNrX3NpemUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc2l6ZSA9IGFyZ3MtPnNoYWRvd19zdGFja19zaXplOwo+ICvCoMKgwqDCoMKg
wqDCoH0gZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEZvciBDTE9ORV9WRk9SSyB0aGUgY2hpbGQgd2ls
bCBzaGFyZSB0aGUgcGFyZW50cwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBz
aGFkb3cgc3RhY2suwqAgTWFrZSBzdXJlIHRvIGNsZWFyIHRoZSBpbnRlcm5hbAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0cmFja2luZyBvZiB0aGUgdGhyZWFkIHNoYWRvdyBz
dGFjayBzbyB0aGUgZnJlZWluZwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBs
b2dpYyBydW4gZm9yIGNoaWxkIGtub3dzIHRvIGxlYXZlIGl0IGFsb25lLgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNsb25lX2ZsYWdzICYgQ0xPTkVfVkZPUkspIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNoc3RrLT5iYXNlID0gMDsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNoc3RrLT5zaXplID0gMDsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBGb3IgIUNM
T05FX1ZNIHRoZSBjaGlsZCB3aWxsIHVzZSBhIGNvcHkgb2YgdGhlCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIHBhcmVudHMgc2hhZG93IHN0YWNrLgo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KCEoY2xvbmVfZmxhZ3MgJiBDTE9ORV9WTSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHNpemUgPSBhcmdzLT5zdGFja19zaXplOwo+ICsKPiArwqDCoMKgwqDCoMKgwqB9
Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBzaXplID0gYWRqdXN0X3Noc3RrX3NpemUoc3RhY2tfc2l6
ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgc2l6ZSA9IGFkanVzdF9zaHN0a19zaXplKHNpemUpOwo+IMKg
wqDCoMKgwqDCoMKgwqBhZGRyID0gYWxsb2Nfc2hzdGsoMCwgc2l6ZSwgMCwgZmFsc2UpOwoKSG1t
LiBJIGRpZG4ndCB0ZXN0IHRoaXMsIGJ1dCBpbiB0aGUgY29weV9wcm9jZXNzKCksIGNvcHlfbW0o
KSBoYXBwZW5zCmJlZm9yZSB0aGlzIHBvaW50LiBTbyB0aGUgc2hhZG93IHN0YWNrIHdvdWxkIGdl
dCBtYXBwZWQgaW4gY3VycmVudCdzIE1NCihpLmUuIHRoZSBwYXJlbnQpLiBTbyBpbiB0aGUgIUNM
T05FX1ZNIGNhc2Ugd2l0aCBzaGFkb3dfc3RhY2tfc2l6ZSE9MAp0aGUgU1NQIGluIHRoZSBjaGls
ZCB3aWxsIGJlIHVwZGF0ZWQgdG8gYW4gYXJlYSB0aGF0IGlzIG5vdCBtYXBwZWQgaW4KdGhlIGNo
aWxkLiBJIHRoaW5rIHdlIG5lZWQgdG8gcGFzcyB0c2stPm1tIGludG8gYWxsb2Nfc2hzdGsoKS4g
QnV0IHN1Y2gKYW4gZXhvdGljIGNsb25lIHVzYWdlIGRvZXMgZ2l2ZSBtZSBwYXVzZSwgcmVnYXJk
aW5nIHdoZXRoZXIgYWxsIG9mIHRoaXMKaXMgcHJlbWF0dXJlLgoKT3RoZXJ3aXNlIGl0IGxvb2tl
ZCBvayBmcm9tIHRoZSB4ODYvc2hzdGsgcGVyc3BlY3RpdmUuCgo+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoSVNfRVJSX1ZBTFVFKGFkZHIpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIGFkZHI7Cgo=

