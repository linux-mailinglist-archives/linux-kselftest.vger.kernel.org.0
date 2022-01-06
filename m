Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704F1485DCF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jan 2022 02:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiAFBEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 20:04:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:40083 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240018AbiAFBEG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 20:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641431046; x=1672967046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xUuCrTK7WOeaYmchr2QxKYWkY/x7udGeJvvUBvkCtPo=;
  b=JHFu5rwDTxC4W3cS2qm46FxQRSVqfwKTimYLfMtI5bxldFlXzXLUHxQs
   R7aSB6cyU3QnQiqF7noQxzSXDLyoqGty+EDYsFkv72CytAWOB73UcDBxI
   hQqGu7LiNPm55tBmezC6Bdg2DdCrt+w826j45msKHdriJa/02DkdrTHHW
   ux7FFIEB8lmetlFBVaOusANgllXCeGC6JGHrrxICP/U6ymiS8NpyfikQz
   xq+8J/BQlxSb1VsX1tAvcr9khFr74Z/Vf34txm6y37kSyZaWLxqPKUQ/W
   aeGO/GT0HwyR2o5v5yI34blgvpTfg3j89mHEmn40pZbmCWphTU4MRaucX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229379505"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229379505"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 17:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="574574169"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2022 17:04:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 17:04:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 17:04:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 17:04:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 17:04:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ0zFwmpZ/PaVHWD/WMZ4yLU/+Ktd0WS6zU3gnQieQ8umR8n0v3O3w16209bp+l7LNyuy9IiCpsm9GMzTgGcZIaO+bcyawb44VlRLCNwtUrjW0Z5e7YSPUhaqlN1MOZKbgrcL2QO7UnCeDa6Nq1sKz3+9u4y/GEir0opqoXfcoW11amPbYEW+8pomCrniuj3x9ieioNAZoM9e0lxsmR7uSFxlSx64N8FOAPfZVLvXvW3w2SiMq0zq2YRjCpGXcgMG4oyK+n3jWeiV1YL7yub9knlVk4kj5atqhHEk/J4NWcb0hLCauicn/nknHpuAFiDBcFIHfOLt6LewKAHPOgFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUuCrTK7WOeaYmchr2QxKYWkY/x7udGeJvvUBvkCtPo=;
 b=dN1wCn0NcuKShBpYvW1K1BlOt/3mWv7m6UIlQH3XfZINJivJEaPZiiTkiQn8kr/PpTkQSPGKvUj1xshuu8vuFwPf0sIHUPp3QDmahcPTnwRkp2GPJzok3H8UtlKLH1TU2RVot9WQsNjXJ7mQJACJvZDAr3CaLJY5Kk7+pv/zGMz6rKFQXM+pPlNHYH0sOdD28SDTHpG9nX5r2vV39QrMd0fqu9YCeYFfyUB0VQOeQk7MgVDQGJsSIxzum2wupTW7vqBVUgWth/fdV1KsgIZIjRwyBngoEbEo0z4LU+25D/jUR2eGkQv2llyrd9BQCM+WlscRugTovP01sG4p7f7zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2803.namprd11.prod.outlook.com (2603:10b6:406:b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 01:04:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 01:04:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jim Mattson <jmattson@google.com>,
        "Christopherson,, Sean" <seanjc@google.com>
CC:     "Zhong, Yang" <yang.zhong@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
Subject: RE: [PATCH v5 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Topic: [PATCH v5 12/21] kvm: x86: Intercept #NM for saving IA32_XFD_ERR
Thread-Index: AQHYAjDG3grRPUB6WkKC4V40NrLWoqxVAQqAgAACVoCAACiN8A==
Date:   Thu, 6 Jan 2022 01:04:01 +0000
Message-ID: <BN9PR11MB527690FEDDB3A46EF2986E258C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-13-yang.zhong@intel.com> <YdYaH7buoApEVPOg@google.com>
 <CALMp9eQi1xU_YgYBTa=zvAkD8=4WAntSFt6V2zcR6G9eQFg2GQ@mail.gmail.com>
In-Reply-To: <CALMp9eQi1xU_YgYBTa=zvAkD8=4WAntSFt6V2zcR6G9eQFg2GQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa35eb8d-6666-4fc5-46f2-08d9d0b06d1d
x-ms-traffictypediagnostic: BN7PR11MB2803:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB2803E616B1B3F2764F748DF58C4C9@BN7PR11MB2803.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KC7kD9dSnu8rozVsRNjYLWC9duvRj5DoTeTBfDGqZO+Nj+XbrVethHFa1LaSxFVa87t8b3sQC83Ofia+bXWzsWgRsZzjb5FOvEd99rkyvii/tM8YkOm37Hn5g1raPfJN4fHVNvjNy8Fg0F0rtarCqc5F08gg4YH4QkHRLYB26S4dEdXJktuHGxLeHhkw7zg8azMWgR+E2D3eC+IP/bMvQT0imBAPva5FAZ7pKxguC50RmxqCIx/61XATstCCw9ib2gP9obH/HWq/ZlMHM566c5es025/osHN5R53u8g7u1Bz5wxfiQ240mcssAoyWqhDKoGh1FW70PjTOtuLmgvU7UK7UK01Hz/cb6XRDSFRggD/T7grpNbTpL5Izq40tODpQ1wcgL07ZfjslnJKf42qGWkMvY3jOZoR63hlj0p4pts8vzkGVJH9mMGNEkO1ueFjZjgRlwHtGoROaUcalo2wxT+T5wCq909mhFXkUSyof2BP9i1B4MRl7X9wPoVvarYsJvjAlgg7hZMBEs/dXrMmQ6cjBVOUT9prsuTQnydqiIF8vD1wEcwV8FP7QzTIYIbGnCGapCB7JwQT25S/6QQ8s2mnYbdIpRBlcmnNvP3+sZ5hAcD4sbg+2vKUGYeZZ5axEQhyxkRLloeyHZF+1v+IAiTh3REbozVddVQ542DGnu0YDcOH9utxoLYpeG18kQ3YZU7xD//64jEg5kkZGcISOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(4326008)(33656002)(55016003)(38070700005)(5660300002)(76116006)(508600001)(9686003)(53546011)(7416002)(6506007)(110136005)(7696005)(316002)(2906002)(8936002)(8676002)(26005)(186003)(54906003)(38100700002)(122000001)(66556008)(64756008)(66946007)(52536014)(82960400001)(66476007)(66446008)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWZCS21IbUJOcHFsUDNNdnB2OWdzUFZoUTBYOXYrWFp1NzNBQVptQysxM0FG?=
 =?utf-8?B?K1U4aWdYMUNpYTI2U2RScG9PVUJZeUFuandLV1hDL1B0aTlwbEs5S25hZVdG?=
 =?utf-8?B?LzFIbEs4WU1Ja1I2aFgybEFiSzVVV2hUMWNQSkRCR0NNdXFVMDAvRnBDc2Fq?=
 =?utf-8?B?OWtxVFpPUVBoR0ZmSml0VllCVjdxZjE5ckhmcENvWGppTHZ6UEdlcFZGREkz?=
 =?utf-8?B?YWtXOW9XM1lJck95Rnp2eFZLZjJTaXJDWGhHOE4yaTJRQlBSakRTZTVmZVJE?=
 =?utf-8?B?MVFNQXIzUGJxTklPTVBJUnp2MnN2Q2VZS0JUTUd1VXluWFdHdHVPRm1idUFB?=
 =?utf-8?B?N2oxaEFlU1lpbXBDQmhBcG9Fc3RGZkxFeXR0Wlh0em5tWEN4K1FrTGd5ZVRH?=
 =?utf-8?B?dGZoWGNjdjEreGhDL2cwdGF4bkRZU05zVTR4QmR6VWRxK29RT3g1dGl6RVVP?=
 =?utf-8?B?alliQWE4V3VBZ1V1QzJXMDlwMXlCU3I4aTQwdmJCd2JidHozUmFjWXlVSGFJ?=
 =?utf-8?B?TC93dDh3UjAwQjBPU091Y1J0UmpSOGcxdnBiZ2tXcE4wUG02bnJDdGppVVRJ?=
 =?utf-8?B?RGtOYmhXSS9jQkdJV3c1QlExMGpUSS8wVEIxc3Q5UkludkZkTE5iMmJyeEU2?=
 =?utf-8?B?bGRhY3AwUTNSSExPOUk4aFlodC9iNm0vZVF3TTc1VjcvdkJhWksyWG1SQ0Jk?=
 =?utf-8?B?bVROdEdZcHFzUHdXalF2cHZPL2JyQ0tTWVEyV0VXakFzSXJiYU1XRmJDTDA3?=
 =?utf-8?B?SEVUdHQxMkJjSjhzK29iMnlTT1phdUNLMXdkclBzQU9VM28xZGxMc21QL2hD?=
 =?utf-8?B?T2xLSkt4dUo4UnR5dUwzZ1QxdU9UakJOcklsSjM4MHVmM3hvTGVhSlpmbkt5?=
 =?utf-8?B?b2JWWEo4eVBCVmxuNEE3OXBKS1V6cTd3SHBsWmlIcWZJU2ZzcmNwdmVTekpu?=
 =?utf-8?B?YzNVZVVWREFPZjdlaTROSkVERHd2VjFJTnNyYnQ4NGNaNm4xRkRWeTNURHhN?=
 =?utf-8?B?RWsrSHQxRG1VamtQZ25odWhmeFpKZCtCdGZvMDhIRWZzSHhFWXRXZExTdGY1?=
 =?utf-8?B?OHhxZElwZHp6NjlCMGY5N3RMRzQ5QVhJTGRrTldaaWhPL3M2ZWUxK1lpblRU?=
 =?utf-8?B?aSs0U2Z0UlBVQ1hlN0o4VHlqeTIrNU9BSDFvenZkaEdrUEg5dU04Rm4rSzdz?=
 =?utf-8?B?cldoUTF5M1QrdU91ZG5vMXlOMXU3VThXR1puekJySlUyQVVLUDhPRkxmUW5l?=
 =?utf-8?B?Z2FvZ1dPZUREZnFoNG5vdDMzcHFxUFBYVjEzRjZzTFRoQjJOckJmejk2MFlP?=
 =?utf-8?B?YUhER05PV3JHaUIzeE1NczhYKzhaV29hSE95QWpza2NlQ1BMYVNYa1BUdkJr?=
 =?utf-8?B?QkFFK2huSnltVDFiTDZsazBiTmhEeUU0dmdrSUpZY0ZjbnBXVmFlQlFlNDdV?=
 =?utf-8?B?V0ZxcXZRd1FrWksvaDVvZnp4TU5WSmlHaXVLSkh2NlBkenU3ZHNLVjJaUlZJ?=
 =?utf-8?B?MHBld3dTSXZ5SVVKTkdjVzN3TnBhVUpheXBhTXcxSDJlZFdReUxHOEtLZFRU?=
 =?utf-8?B?Z1hsamZQRXpxVGQvRi9DSitWSWpJRnhmejlHZXJJN2x2NFVZQmU1M3I5aktn?=
 =?utf-8?B?UzlLTFB2bVZWVjFCbjJiTTVmWUZDeStLNklyREx0ckdHeUhoVG01V0RlREVF?=
 =?utf-8?B?QnNndVZVMmlydUhUVDY4ak05ckZnQytVYzl3OVNUa3JncisyMEFkUTdpSXYv?=
 =?utf-8?B?V3ZIaVpobFc5NG9yM1lwQUs3c29ZalBVM0UzdWZKTmQzQW5DU0hZYWUxMWtI?=
 =?utf-8?B?VllvR0w0NFdPK0NYUHZyOFBYWllDN0c5cmI4bXRoSlhEUGtUcXorWDlsMy9X?=
 =?utf-8?B?YTkzVU1QVlBmeG1raGtLVHhQWFlQZVhtMDJ6THVldU1ZeHUrcnZ3ZGM1bUFs?=
 =?utf-8?B?L0RnRlVSNHpwb0NmNkd1Ry8zOTJZSkhjc3JaSm4rRXZmVzJWWFMwbWNZRFQy?=
 =?utf-8?B?dVRVUEdGSTIzOS8wbzBNbTcxckowNUVaeEFnRDFpNFNGbks3bDJ5TjJYY1dO?=
 =?utf-8?B?cjBxWUVMWXhDVjJMckdGV3BHV3A4ekxzdWtGaXdHT2ZVT3pMZ29MQTB3NVhK?=
 =?utf-8?B?YXFNVUk5eXA1VlVXK0IxSWJiV2JEWTJJUTF3OXdObUVBYkhTQkdQK1k2TkNm?=
 =?utf-8?Q?XlsjO9VxyG4yz0a1pETOPyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa35eb8d-6666-4fc5-46f2-08d9d0b06d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 01:04:01.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uC46zEyA7BK/qMl0cdlzsZAX6MBOThcmvinf2p20v/gCwguT1lVQiYkSJ6y0Ur49db9/MAThi14HMaekHzqiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2803
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKaW0gTWF0dHNvbiA8am1hdHRzb25AZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEphbnVhcnkgNiwgMjAyMiA2OjMxIEFNDQo+IA0KPiBPbiBXZWQsIEphbiA1LCAyMDIyIGF0
IDI6MjIgUE0gU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gT24gV2VkLCBKYW4gMDUsIDIwMjIsIFlhbmcgWmhvbmcgd3JvdGU6DQo+ID4g
PiBAQCAtNjM5OSw2ICs2NDI0LDI2IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9pbnRlcnJ1cHRfbm1p
X2lycW9mZihzdHJ1Y3QNCj4ga3ZtX3ZjcHUgKnZjcHUsDQo+ID4gPiAgICAgICBrdm1fYWZ0ZXJf
aW50ZXJydXB0KHZjcHUpOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIHZvaWQgaGFu
ZGxlX25tX2ZhdWx0X2lycW9mZihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ID4gPiArew0KPiA+
ID4gKyAgICAgLyoNCj4gPiA+ICsgICAgICAqIFNhdmUgeGZkX2VyciB0byBndWVzdF9mcHUgYmVm
b3JlIGludGVycnVwdCBpcyBlbmFibGVkLCBzbyB0aGUNCj4gPiA+ICsgICAgICAqIE1TUiB2YWx1
ZSBpcyBub3QgY2xvYmJlcmVkIGJ5IHRoZSBob3N0IGFjdGl2aXR5IGJlZm9yZSB0aGUgZ3Vlc3QN
Cj4gPiA+ICsgICAgICAqIGhhcyBjaGFuY2UgdG8gY29uc3VtZSBpdC4NCj4gPiA+ICsgICAgICAq
DQo+ID4gPiArICAgICAgKiBXZSBzaG91bGQgbm90IGJsaW5kbHkgcmVhZCB4ZmRfZXJyIGhlcmUs
IHNpbmNlIHRoaXMgZXhjZXB0aW9uDQo+ID4NCj4gPiBOaXQsIGF2b2lkICJ3ZSIsIGFuZCBleHBs
YWluIHdoYXQgS1ZNIGRvZXMgKG9yIGRvZXNuJ3QpIGRvLCBub3Qgd2hhdCBLVk0NCj4gInNob3Vs
ZCINCj4gPiBkbywgZS5nLiBqdXN0IHNheQ0KPiA+DQo+ID4gICAgICAgICAgKiBEbyBub3QgYmxp
bmRseSByZWFkIC4uLg0KPiA+DQo+ID4gPiArICAgICAgKiBtaWdodCBiZSBjYXVzZWQgYnkgTDEg
aW50ZXJjZXB0aW9uIG9uIGEgcGxhdGZvcm0gd2hpY2ggZG9lc24ndA0KPiA+ID4gKyAgICAgICog
c3VwcG9ydCB4ZmQgYXQgYWxsLg0KPiA+ID4gKyAgICAgICoNCj4gPiA+ICsgICAgICAqIERvIGl0
IGNvbmRpdGlvbmFsbHkgdXBvbiBndWVzdF9mcHU6OnhmZC4geGZkX2VyciBtYXR0ZXJzDQo+ID4g
PiArICAgICAgKiBvbmx5IHdoZW4geGZkIGNvbnRhaW5zIGEgbm9uLXplcm8gdmFsdWUuDQo+ID4g
PiArICAgICAgKg0KPiA+ID4gKyAgICAgICogUXVldWluZyBleGNlcHRpb24gaXMgZG9uZSBpbiB2
bXhfaGFuZGxlX2V4aXQuIFNlZSBjb21tZW50IHRoZXJlLg0KPiA+DQo+ID4gQW5vdGhlciBuaXQs
IGl0J3Mgd29ydGggZXhwbGFpbmluZyB3aHkgWEZEX0VSUiBuZWVkcyB0byBiZSByZWFkIGhlcmUN
Cj4gcmVnYXJkbGVzcw0KPiA+IG9mIGlzX2d1ZXN0X21vZGUoKS4gIEUuZy4NCj4gPg0KPiA+ICAg
ICAgICAgICogSW5qZWN0aW5nIHRoZSAjTk0gYmFjayBpbnRvIHRoZSBndWVzdCBpcyBoYW5kbGVk
IGluIHRoZSBzdGFuZGFyZCBwYXRoDQo+ID4gICAgICAgICAgKiBhcyBhbiAjTk0gaW4gTDIgbWF5
IGJlIHJlZmxlY3RlZCBpbnRvIEwxIGFzIGEgVk0tRXhpdC4gIFJlYWQNCj4gWEZEX0VSUg0KPiA+
ICAgICAgICAgICogZXZlbiBpZiB0aGUgI05NIGlzIGZyb20gTDIsIGFzIEwxIG1heSBoYXZlIGV4
cG9zZWQgWEZEIHRvIEwyLg0KPiANCj4gRG8gd2UgaGF2ZSB0ZXN0cyBvZiBMMSBwYXNzaW5nIHRo
cm91Z2ggWEZEIHRvIEwyPw0KDQpBcyBTZWFuIG1lbnRpb25lZCBwYXNzaW5nIHRocm91Z2ggWEZE
IHRvIEwyIHN0aWxsIG5lZWRzIG9uZSBtb3JlIGNoYW5nZQ0KaW4gbmVzdGVkX3ZteF9wcmVwYXJl
X21zcl9iaXRtYXAoKS4gVGhpcyB3aWxsIGJlIGRvbmUgaW4gYSBmb2xsb3ctdXAgcGF0Y2guDQoN
CmJ0dyB3ZSBkaWQgdmVyaWZ5IGhhdmluZyBMMSBlbXVsYXRlIFhGRCBmb3IgTDIsIGJ5IHJ1bm5p
bmcgdGhlIGFteCBzZWxmdGVzdA0KaW4gTDEuIEJ1dCBvdmVyYWxsIG5lc3RlZCBjb25maWd1cmF0
aW9uIHdpbGwgbmVlZCBtb3JlIHRlc3QgYW5kIHBvbGlzaCBhZnRlcg0KdGhpcyBzZXJpZXMuDQoN
ClRoYW5rcw0KS2V2aW4NCg==
