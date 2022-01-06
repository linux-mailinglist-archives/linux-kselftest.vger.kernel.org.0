Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E141485DC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 01:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbiAFAzy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 19:55:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:4501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344476AbiAFAza (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 19:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641430530; x=1672966530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WpkyKr4DOwZBvLmXo1zSCELMnb6hcSYp3ajeTfjQCHA=;
  b=OxzXg5TXpkus04YJD0AgpwCHQQ5L7XArXPQGyPmtlJ2JM3BcnMH5Bmpd
   g4BKbw1Bg0X7rZABVL0oGMmidpRJ9QNYsMCDiEHh1FfrtnywzhPLPaC1A
   HEyJWdq2p7aQWQgn3xqZd76QF2UVVR1kaC40PMtbR0+AOPWihpbeRyF7e
   DI+6Qh9pQOFJMnXHPXe87s4PzgqER0vKr/imlET0jitvwq69CS7cSO4T8
   Uksp3iRJSHJwzJj1r0U5JDa3m9o3optFoP242FUEmxI4DALU+WY2rZH61
   gGLLEJHSHaG5KVKkoUiB0Bbu4KCOEGtbpHWLt0LDDCPlpAzg9TTdOJUYE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241384013"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="241384013"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:53:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="621337572"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 16:53:00 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:52:59 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:52:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 16:52:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 16:52:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzAWBMN50XiEJfajWBEmFup2C/pbl5reXIovPNFK413exJuGU6sZAeGmgwqDLZGCUlCr7clmTa9leUsSBdJK6YWCXUD3aNsB7IkrCcin2c2pPWg89hDcRhQH65OAUCa7Z61jK5R4PfZZAUsnyfJOB2Iztd9gYiBa1BuYUtVD08HVZNcMVt0S2qAr/O/EJ+w2qrgxCY/hjCmAVORz+0Yg+8yudqm37cLngMjZTFcznFshXnkMhu+ZAJGEd2rUVGcMnUb7Le0CuhUDZaJn6UGuVJetO4ZcgDrTuRlBQED4JRerS4HMiVoREgw80XkhZLZX6imObFygcjWRBE2LEbiP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpkyKr4DOwZBvLmXo1zSCELMnb6hcSYp3ajeTfjQCHA=;
 b=N9tnpq08qufxyIfT8Ru60gT9KW72fNJNn1wIubBWvu6ZftkhnzOBlzCttfoECYX6lQE/qjsqPW+l3kIOlHckx2J9gOfmEg8A50hNybmJb/f8muvtH/QZYriby41LeZhvCgGZ+iQCsFqYdX/KYBoWe6Qwecs+fPhN4kzrA/v/8Nmo6Sw+RtuoLi4qgB4GseKN/zgP1QyjHHOmdKaYx/i80Xbx814besxJtjaNtlW8soZ48IrAh7PJzoSbIGyCkW422GTwBq1YnDgwLpA+T9bdnjrmkboxinNKyjEj+DwF3LYRGXsDE0On/hvlA62Rfq3sp36abVQ8vIGAlxjSLgcfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3713.namprd11.prod.outlook.com (2603:10b6:408:8e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 00:52:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 00:52:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v5 16/21] kvm: x86: Add CPUID support for Intel AMX
Thread-Topic: [PATCH v5 16/21] kvm: x86: Add CPUID support for Intel AMX
Thread-Index: AQHYAjDHiOt9jodYcEidfa6np/qPkaxVAumAgAAn3JA=
Date:   Thu, 6 Jan 2022 00:52:55 +0000
Message-ID: <BN9PR11MB527646BB14CE77A8FE1A639B8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-17-yang.zhong@intel.com> <YdYbsQ/q6VzR3m7d@google.com>
In-Reply-To: <YdYbsQ/q6VzR3m7d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8f5850-76b8-4e28-cd93-08d9d0aee042
x-ms-traffictypediagnostic: BN8PR11MB3713:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB37133405705CB01E5785F39C8C4C9@BN8PR11MB3713.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdEBtHy0S52yfTO2Ljp2vBFPLsPcXiOwXrZyYn+3ROMN558zDKdzUmQl1TD0dcVChiF36kz5RFrswNOdindgRIF88tKnXDsBH0OaKPImwHpG9j4C7FyMkE0t1RSD9vjJT1n6hxNktwllSD+uT3HjnZlGBoNeHloVCpt+2j23X4Lavn5Xztnc8YFi8YlTK/+a9bYsQJBZKLAZl8WneNdrzrfWMsq0UNze6r9n9duBsH4flG6YScKWvyXjMNzAeiKj4YJbe6K+/cO88GzoO55nnOaOpFQJF7Ar1+CLbMpWpPHulpA1WMliuDRZx3zQX3n2ygOa6puKAPHerYibBZ+A63RW8IQAHC9t8zUZ4T7vlrLbiopQfbxYwahyDkAjZnUPXZM5aQGD/PV3DrQdv+6t5QYdrBlGZ+bqQLNy7+oFYEOe+06prMqaSSTsu58Rzdaijp5KaiP9MlWbhzRMZpeEk2gX3vmx/uN2UmEfUMVziHJanDV5aBySs9MOdOUjQEgN66krAA0m3PvQtMwPuGO/nQuBql7hWsLruQHadmheiz/7uozsMi0Db8o/Cd9gmek1YWuWehI37io1EUW0y4yg2aopH5vQoaJq6EI5HVlaN2Kabor3yBvQaUTxikPIikx4NSaxJvtMW4Gj+iNdfFSLy9JuQVcW5ZFtZV6FQ4x398HSbrltLICsNdlslEfevfKTBLWLrsG/aqxuDylxHT3fZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(66446008)(82960400001)(76116006)(316002)(4326008)(2906002)(55016003)(186003)(508600001)(4744005)(33656002)(9686003)(66476007)(71200400001)(7416002)(66946007)(64756008)(66556008)(5660300002)(38070700005)(110136005)(7696005)(86362001)(52536014)(38100700002)(83380400001)(26005)(122000001)(8936002)(6636002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFpDOTA0dFRVK3FTL2lSMjBGbStNUU5aY24wRHBMSzRJTmNjTFdaWnZJeUI5?=
 =?utf-8?B?anZHbk52bXdYSXM0dUU5aHhOa05rYjZHUkJsMGVwaGcrR1JId3JidXg2OFdx?=
 =?utf-8?B?ZWIwN1VMTDdVZ3YwRkwxUC91c0d5OW1oaktPd25zbjVIN1JoRWFYcWNXbDN6?=
 =?utf-8?B?YkZvS1NvSXFlRThPTDZhS29xeEpJSUY1R2ZuRXFhbGYvUFgvM3EySlNSY2lH?=
 =?utf-8?B?MFl6U2RnZmdtK1pEUmZmNFFDclczenFKS1RBc3VqTHBIQ0lIQzNqT3p0cTJF?=
 =?utf-8?B?TDJHcVBXSktQMVVwSlBNb0FsT1VGdkhpcWJ4NW43a055OTdmZmM0WFR5SkdE?=
 =?utf-8?B?REtVY0tmZlNpRXJoRzBKVmwrUXo2SUZhUlZVOXcxMXNXdU5FWmRQKzhCOXZF?=
 =?utf-8?B?bGNJcGJNRjdFdWNpQkZCaUlVTHpWeTJmYWRXV2xEUnZBUXZaWWJwZDN6TWM3?=
 =?utf-8?B?SnRCbThhK3lzZDZ2RnpYUm9Db2xoU3JsMDMrZWYvTlVvTnNnZ1hhYnB1OXlm?=
 =?utf-8?B?WWI3ZFNUOE5OZnBlNW9JTGZNY3VXcGt3VzRNd0RLRGNkcGxPTzF6Wkx4UTQ0?=
 =?utf-8?B?Q0VKZEZDUHBMWVhqQkcwaUZsSXZEekxhclE4TWpxVVQ2NXU1VW9ZUnVNYlBa?=
 =?utf-8?B?RENKWGhleDRFQXFaWldlbXBkZmxTV3hZNTZPWWFFb1NjQkZYMHJtY0o3M2tY?=
 =?utf-8?B?MjNSUmIzOGJxaGs5UVdadTlRaGJBYmEyTitsYUwwVWZHUUl3RkgwUGxpRzU1?=
 =?utf-8?B?VXVJSy93V0p5am82SlQzZFlhVHptM3VTSXdjMWp6THg3bEJ4Sm1TRUxpb3lD?=
 =?utf-8?B?MC9KTmNacHpjbnluYUd1ZStEUUtrOGRValNmbndYWW9uajJBZlRqOTdvV1R5?=
 =?utf-8?B?SXFaZEpuRmlKYjRSamd4NUUrNnlkM3ZGY2s3aXdhV1JtVGFwQ1VzRklKNkM3?=
 =?utf-8?B?c25KVkZEZUVqa3FyZmNDUlBHMHp4Y3V5WVFYTy8vNytua3NiN2t0TGQzdStn?=
 =?utf-8?B?NUJYdzFtTXdmS3g5V2h5aEFmZU5CaGJiMlc0bExyaXBZU1ZhUE9UditqWTBY?=
 =?utf-8?B?S0VuOExTNnZ6dlBhMUJ5QUtqTUUvRjN3MTNTclVmRWxlSVpzcTl2Rllob1Bz?=
 =?utf-8?B?UlU0WklJMW9VanMydnh5czVtQ3U5eXVQaVByN0ZZTVV5VmsySE16U2JvZm4r?=
 =?utf-8?B?VDRUYWxaYVE3TC9LbmFEMndNNFZWemFzWFMyNmVNejlNeEJoajZNa3NIYVcz?=
 =?utf-8?B?K3Y2am54Q3g0VCt4R3B3QmVkelVSd0IvM1BmRnNBa0t4SmloOHM4V0h5aVRB?=
 =?utf-8?B?NjVUV0xxWUFEZTFmSStLVDhWVWZTbHlMM3NrcG5EaTY4K1pkbE5sWDNIcFRQ?=
 =?utf-8?B?dThqMEhyV2tZT0lEczVtd3NoMFdEaVNxbXNDT0NjN2loUGc0TUdtYTBYUnBo?=
 =?utf-8?B?cm01eVdqQXlEVDJVdmNpdUZ4Mk9GRmcveWd3clN2b0tMUW80clpJZDdHOWxk?=
 =?utf-8?B?MGxMVndQVExMYUJLTCtqVVBlWW5yVVVpdDBieW40Tjd4dU9IMU1lZURvZm5u?=
 =?utf-8?B?dkxrSXlrVEFvdXl0STI4TEhJYUFCOUVRNStsSXRDOXpVU3JQOHIxVVJqUlQ2?=
 =?utf-8?B?eTh0UWdaWE9lY2VMZWVsSFIxSGNLSDEyOFo1dzk1NTRnMENFM0lXcnRwVWNG?=
 =?utf-8?B?TWFHelJJaUNnaEgwdUNrN1hwTHJPYXlJRkFOQUFEWTBCNTd2aTI4RmN6ZjJR?=
 =?utf-8?B?ZEpvTXhQNkJxVjU2aURZajl5VGJyZ3VOdjIzbXo3SEZ6azNOU0o4dEk4Qks1?=
 =?utf-8?B?M3RKajhjNFZCdmlTb1Q3RWF0VVFMa25uLzZrTHl6ZjlZTW04K0NnQTVWTjJL?=
 =?utf-8?B?RjF2Qm1QNmxlMEIxd1QwbW1MZm5KWjIwM1YrbTVpTWluaWtwQ253NHhoMDhr?=
 =?utf-8?B?eEVUMkR1RUhDUWhqWlBYWUUxdHVNY3B6R1NNbDdOc0FMMW54QnhDTkdDTFov?=
 =?utf-8?B?UklFbGViK0tOazVmMTJOTlAzSG80L1FMWS94RFdxUkJqUEt2SGh3cW9kTktu?=
 =?utf-8?B?SEY1YW4zQTRncVdkWUJWQmIxczhnekJUTVkxeG91OGdiWFRsQzY0WjBWSWF1?=
 =?utf-8?B?aGZyY2tYY3lkY2xJZ0lmYWVWVWR0ZFIxdGlZZWhLN2NRZzFPSFJQR3luU0FO?=
 =?utf-8?Q?nm1CsNFXwdglGeD3EEVWkSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f5850-76b8-4e28-cd93-08d9d0aee042
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 00:52:55.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsYijapyX6q8bvFY20Vx59wJzPjT/xYKVlkJ/7WqLuo5FjRdBNi/L4XokvN2BzOxKl3+ldDUidHKennqPbD4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3713
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEphbnVhcnkgNiwgMjAyMiA2OjI5IEFNDQo+IA0KPiBPbiBXZWQsIEphbiAwNSwg
MjAyMiwgWWFuZyBaaG9uZyB3cm90ZToNCj4gPiBGcm9tOiBKaW5nIExpdSA8amluZzIubGl1QGlu
dGVsLmNvbT4NCj4gPg0KPiA+IEV4dGVuZCBDUFVJRCBlbXVsYXRpb24gdG8gc3VwcG9ydCBYRkQs
IEFNWF9USUxFLCBBTVhfSU5UOCBhbmQNCj4gPiBBTVhfQkYxNi4gQWRkaW5nIHRob3NlIGJpdHMg
aW50byBrdm1fY3B1X2NhcHMgZmluYWxseSBhY3RpdmF0ZXMgYWxsDQo+ID4gcHJldmlvdXMgbG9n
aWNzIGluIHRoaXMgc2VyaWVzLg0KPiA+DQo+ID4gSGlkZSBYRkQgb24gMzJiaXQgaG9zdCBrZXJu
ZWxzLiBPdGhlcndpc2UgaXQgbGVhZHMgdG8gYSB3ZWlyZCBzaXR1YXRpb24NCj4gPiB3aGVyZSBL
Vk0gdGVsbHMgdXNlcnNwYWNlIHRvIG1pZ3JhdGUgTVNSX0lBMzJfWEZEIGFuZCB0aGVuIHJlamVj
dHMNCj4gPiBhdHRlbXB0cyB0byByZWFkL3dyaXRlIHRoZSBNU1IuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKaW5nIExpdSA8amluZzIubGl1QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+IE5vIG5lZWQg
Zm9yIG15IFNvQiwgSSBwcm92aWRlZCBhIHZlcnkgdGlueSBzbmlwcGV0IG9mIGNvZGUgcmV2aWV3
Lg0KPiANCg0KSXQncyBub3QgdGlueSBpZiBjb21wYXJlZCB0byB0aGUgcmVzdCBvZiB0aGUgcGF0
Y2gsIGJ1dCB3ZSBjZXJ0YWlubHkgY2FuDQpyZW1vdmUgaXQuIGFueXdheSB0aGFua3MgZm9yIGFs
bCB5b3VyIHN1Z2dlc3Rpb25zIHdoaWNoIGFyZSBhbGwgZ29vZC4g8J+Yig0K
