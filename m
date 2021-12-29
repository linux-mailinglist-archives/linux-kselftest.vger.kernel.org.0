Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30648109C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhL2HSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 02:18:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:37843 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhL2HSa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 02:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640762310; x=1672298310;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gB/YuEQ5ossjy6hrRVBTTAvzwBVbSNlEhkjl+wZ/R0w=;
  b=lEAy0gWY1XnHrwIVPRVd1uYqWp17hxUn2ZaxH9t5XN4vILEBObFTJfKk
   E592WBMi4gQvn4A7Dm8ge0+H59RiXlutnl5Zi1z6MDPxkGxpnEc6ToBQ5
   JEkpXvDIsMkqYnFAUP5sFaCExc5Fd6ChASksii1W33BsgD9+cVch8mJP/
   qmPd9AEFM7BzMrpqXXR4ALNhXcOJQSAd9UnmftoqjAuYcv9iV4j5IU0AP
   Ad2nG9kpotr8Ts1C0d8nHJcKPVTyzipxP+eThCy2LFHs4o/h8LpfltmfB
   lIXvLe54wHq+4OnDjrYzKYaSsj4Afj5/kLtU90FVjjheVnN0YBCaTAwea
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="222149782"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="222149782"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 23:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="486542345"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2021 23:16:20 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 23:16:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 23:16:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 28 Dec 2021 23:16:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 28 Dec 2021 23:16:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2eCVEIQ18/TeqY0x39xvLVUni/0RPxcy8ct8LhkptGRjkutW7Vms5X3utQUYqwI6YUFzvZSHQNzcf8N6w3tezpf+RbbVv+VORwuC9/Z7WkH6WVhh4Yd1aK2RI5eTfkzj9gRPCcI86gPf1IxOGo4CM/J+KTxxF/1cBapO2/zIUnZFCwyn/X9OOqn+UOdFL/09j0xzfyPv6YxkHPbB1zDyED9KR+v8qM8487OvTTGkOlpZNQVjQ/74p2OAgdyhAcrhq+bJYAQAXCir/u0ABDTtcrtH8+84Qyolt6GsckW2mVHXp/hBE8WTI88eduYBSTIffuZo3UYew38a03VjDLIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB/YuEQ5ossjy6hrRVBTTAvzwBVbSNlEhkjl+wZ/R0w=;
 b=cNuwHGrkvPLOYB+WGUZs0fYUlTyeTiDTeY3fKdZES+TaM1vC/sNpulegqCfGlcAzSr01szPk9GRgqeWBy/zSqNeTxLL4LXsK4ST6zbGA4hbo0/jQI+E7/D1jjAFpkmgOylTDz3T2aQnfPGDjOJAcjORdANj4m/ezoHR1Gwo8CFdjTh8694mL4GjuRhcvp4+5H1MMZD7Pd4FaQ7BNZH8CPPfWraAeUQaW46fVkGfcWRBdfftmQF0jtuCmj8rsq7yfs1C3WuPjk/T9WlTa3dC0CEZBTCjoI9dRUNDIz1MQKb/QMPAZo7ElJcCNZ1SmeiCcOQC3tVZq9/R4oCIZgMb2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1748.namprd11.prod.outlook.com (2603:10b6:404:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 07:16:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 07:16:11 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Liu, Jing2" <jing2.liu@intel.com>
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
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgAAjG3CAAD2qsA==
Date:   Wed, 29 Dec 2021 07:16:10 +0000
Message-ID: <BN9PR11MB5276CE5635898CE13BFC57FC8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8019ab44-f02e-4b39-fb80-08d9ca9b1765
x-ms-traffictypediagnostic: BN6PR11MB1748:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB174878CDEB5B683AEFCDEBC18C449@BN6PR11MB1748.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfAWBntZS+VuZdHtdYev+2Uzg/lWMVqiS43sS31wVyIdLLsE2/5ujHHU8UqwVqzAg3iceviFPQxS1JUQjcLM/hDLLzAwGj2KYcYbym0NJ1x4jmfCDDmTAiSqXVG53AyUYPhs0RFKVJfN6opv2GeVpcpdIU5BB6TLQMNK9R4igjYtiOK2P8+HJrXR3W73Y33wiQQZJGjdJKgBzw1vs8pqhlk4dBVvffWzij3xyWV2xsbSAV4ZcDGQSADGf64PGH6QGri1JaehlR1/wNxQ6s/WiohbbEoaLeulaTPgWsmdmktwVD16NDwyxfi9MmxgzynxPrMIfp/kW29H1uoUZO0wtCvFVSiZ3LLxAYeNubpiJqSfe8/24mM/SXopmwmtJU/G84C0D6qd7dkqL8SSFeQ0shMfN5DRVkWCx3xLgLQahckq/r26pIt42RmYNI28pxxPhsYMVrcwjnm6A4Mjs3E7Xzk22M6y3iSN6UxxQqJaPvOwMY2sEoHCDBcCiwSS85JYidQZ1qwK+vdPqVXHJm5KvpdxVhKjFSPoYycyopK7sTU9KmL0+4zQZAgRdvG8tF0lSmxzuWptZAzRSPIWk1lDjWpc+66sYWqClokE9IG+bp57iYKS4cULGMxaSQikor58SbyrGOxkBqg7WdLYt7fY49wtaBe8U5B+HZ+ZJ8n49p7pt7Z+F0PdkJ4fIkozJ2D4MCE5+Dtmn6586QMBZGlV7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(9686003)(33656002)(508600001)(2906002)(55016003)(4326008)(38100700002)(86362001)(122000001)(5660300002)(7696005)(83380400001)(316002)(38070700005)(82960400001)(6636002)(54906003)(8936002)(8676002)(110136005)(6506007)(66476007)(66446008)(66556008)(66946007)(64756008)(76116006)(7416002)(52536014)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JlMUt5Y0ZuUlltN2EwelA0U2RGRHQ1bTNkR1B2bUpZNkgrclA3UUdmQzhD?=
 =?utf-8?B?bUpVbEhtZlJtUHZzSXZ1YXBSU3RiWGhMZEovUERRWjdRS0NEMEhLcHBYZXZi?=
 =?utf-8?B?TXYrU1NQc0YwbGcwZHVFcE1DQTVzNENwQW5KenNaaW9uemN0MFBYWTVPVDBu?=
 =?utf-8?B?Q0R2bXhNcCtCbjQ1NWYydHVXMTU5cHB0YlhkVitXeWRKZTh0WGEvODNueG9M?=
 =?utf-8?B?UWxDbXBEbk80T3BLN0s1SGpXVnBvOG4zZHFVTWhJNkxIM3pUeHpzK0FZVkJR?=
 =?utf-8?B?a2xGb25lMUlWbEloMUI1MXJBY1dtQ0oxVnlxMXdDMWFhOC8vcUZ4NE04RjdW?=
 =?utf-8?B?ZVFhZW03SHNkVlFra25SM1FGVTVNTEpudXI2RHFYWVNubE54WkpxYkIvc0Nh?=
 =?utf-8?B?ZUdMWm42VXNlMlVNOGtoWkVnVFFUejE2ZlZJNW5jcE9kM0RIUndWczUyQm1R?=
 =?utf-8?B?Z3VaRnR0WW5aQ0tXcXBwcEtTZ2g4WmV6QjgvVm5iSkt5TDdhVmVlaGxLcTBX?=
 =?utf-8?B?enJjNGhBQS9PNGNacGlEYXJIQXFxUyswWEJZQy92ZXhTZGR1UEc2OU1XeGJE?=
 =?utf-8?B?VHZPU0h2cVJLbGNZOHJZRjdEM290MnZmYjhZa2VTeExwWFdyM2dJdVdLMW51?=
 =?utf-8?B?MDNRY2JScFQxaVdOcjU1R0g4MDZZalprd3ZsZEhEL3gzdm54V1BlTGI5UG1a?=
 =?utf-8?B?MzlzV2tOTGl4dTNpYUw1WitrNHhIVzlyeDJqV1BCTmg1YUJKSHlmcDJWYk1V?=
 =?utf-8?B?RU50bkpSVkg1NS9IM2lXZG16cG1VNU5ETEJxakFsMUVxOVA5M3Q1RVE1NU13?=
 =?utf-8?B?bjFtNWFJVzFjN0RDekN4WWQrRUo1OWlwc2FSUzI1cHF3OU5SRnliZ3JRWEdv?=
 =?utf-8?B?dUJuK0xSNDNOdERLUDAvL252WUo1WnBIcytQanhaTjBWcGRSQWEwY0oxcmtn?=
 =?utf-8?B?bzVmNXAvbTcwcDNNQm5Fc2oveCtaTW10Zm43Vk9rRll4ZEV4VytGKzUySnlR?=
 =?utf-8?B?NkRuQ2E5azFZN1p5a0NIbGd1dmhGNCszMVVOYXhzcG45QVJGK0p1S0NJaU5T?=
 =?utf-8?B?Tm9BMlU2a214bk1MM2hDNEZCNUwzbFlvSTBDc1RoUHdVb0ltLzliV3RraDF5?=
 =?utf-8?B?blE0NmxVN0xIMURueVpyWDlMUGE3RGYvRDlGT242Mnh2VEZUc0c1YTNFZ2ly?=
 =?utf-8?B?VlJ4aGVHSGc0dEJDWXR0dXp5ZWQ3UkdnaXlZSysxRW9RcUJFRU1oTUpyUkEr?=
 =?utf-8?B?bXpRdUIwTDBzMmVVdGdTMm5hYVBVSnZMcW9kMC9BeFBaeDJwMytiOWNXTWxU?=
 =?utf-8?B?ZVZudi9UZTZROG1CdWZrQjE3Qlc0MGRxUVZXVEhXanBmQklJSHpIQXFIQnVO?=
 =?utf-8?B?Zm5kREh1c3RuRnpRRlIvL1Zvc1BVTC9QemR4ZkZrL1ZvbWhQTW5BRFBMZjVx?=
 =?utf-8?B?T1pNNXJybTFYOTViVmNkcGh2MkRxaUhSNjhOSTJGVitLbWJ1MUNSM1dvazRY?=
 =?utf-8?B?NDJNeWJSR0kwd1RqV0t4dEZRcktrdWQzN0EvSFJBcVJtRjhpRlg2eEV2bDI2?=
 =?utf-8?B?Wlp3eGFqcDFvTSs2SHNLck5lMFRyRSs2SnU5V29yNzZ6Q3NlWDFqSlAzb1lG?=
 =?utf-8?B?bUdLbk1RVU9kTG1ZWGxIU2RkdFU4REhKc3dGdGs3Y0gvU1pqc0NjR1RzcWpN?=
 =?utf-8?B?WW91am0zWTFlaUtOT3ZZNit2eW1wSmdmN3YvMnl3eEU1ZXB6MDBkOTMxMzZt?=
 =?utf-8?B?S21mT0N3U3lLaHNxYXlOaExvWkZrMnN5bHhZNjJ4NUNNZUxQdk1TT0dxZlFm?=
 =?utf-8?B?eUJWdjMwQjZIQlcvcG5jU0M2SUxjektud1hScWlGTEFCYVlNTzdkRFZaVlVx?=
 =?utf-8?B?Vm95b3Evc3dUTm9sSTVnOVlVMzE0K2VGZG1UQVdiemxVUUFvbkxMZGxvQ3E0?=
 =?utf-8?B?STg5dUN3SkVEeXB3a2RHOU1CcTBYU2JodUVNRTJ5VTEwL29jMFNVZFdoTk1R?=
 =?utf-8?B?RnVUd2ozcEVzblZRenFFSHo3NUdLcm13bEZIOG1yS3Y3b200VzRzaFVpbjJW?=
 =?utf-8?B?NFVkbURUb2NDeUoxTXdFSkpFNEZyT1h5K0tVR2VNWXhOMmxnNUdSVzJCelpp?=
 =?utf-8?B?akp4cTFOZHovejU2TUNDZlJIWXU4ZG01Vld5Zm9MbXJKUFBJVG9CdENBc2NG?=
 =?utf-8?Q?rya8JyHJ5N6GANLRLpF6/7U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8019ab44-f02e-4b39-fb80-08d9ca9b1765
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 07:16:10.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZWZwjVsdAU4hZ+6UTb2Trc2sDNm8cZqFyMcsA6ocrswTevSoQGifJlkQOKonu6EO9jP5L5AkFdHAiAsUUaZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1748
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDI5LCAyMDIx
IDExOjM1IEFNDQo+ID4NCj4gPiBTcGVha2luZyBvZiBuZXN0ZWQsIGludGVyY2VwdGlvbiBvZiAj
Tk0gaW4NCj4gdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKCkNCj4gPiBpcyB3cm9uZw0KPiA+
IHdpdGggcmVzcGVjdCB0byBuZXN0ZWQgZ3Vlc3RzLiAgVW50aWwgWEZEIGlzIHN1cHBvcnRlZCBm
b3IgTDIsIHdoaWNoIEkgZGlkbid0DQo+ID4gc2VlDQo+ID4gaW4gdGhpcyBzZXJpZXMsICNOTSBz
aG91bGQgbm90IGJlIGludGVyY2VwdGVkIHdoaWxlIEwyIGlzIHJ1bm5pbmcuDQo+IA0KPiBDYW4g
eW91IHJlbWluZCB3aGF0IGFkZGl0aW9uYWwgdGhpbmcgaXMgcmVxdWlyZWQgdG8gc3VwcG9ydCBY
RkQgZm9yIEwyPw0KDQpvaywgYXQgbGVhc3Qgd2UgcmVxdWlyZSBhZGRpdGlvbmFsIHdvcmsgb24g
d2hlbiB0byBkaXNhYmxlIHdyaXRlIGludGVyY2VwdGlvbi4NCkl0IGNhbiBiZSBkb25lIG9ubHkg
d2hlbiBib3RoIEwwIGFuZCBMMSBtYWtlIHRoZSBzYW1lIGRlY2lzaW9uLCBqdXN0IGxpa2UgDQp3
aGF0IHdlIGRpZCBmb3IgbWFueSBvdGhlciBWTUNTIHNldHRpbmdzLi4uDQoNCj4gSWYgb25seSBh
Ym91dCBwZXJmb3JtYW5jZSBJIHByZWZlciB0byB0aGUgY3VycmVudCBjb25zZXJ2YXRpdmUgYXBw
cm9hY2gNCj4gYXMgdGhlIGZpcnN0IHN0ZXAuIEFzIGV4cGxhaW5lZCBlYXJsaWVyLCAjTk0gc2hv
dWxkIGJlIHJhcmUgaWYgdGhlIGd1ZXN0DQo+IGRvZXNuJ3QgcnVuIEFNWCBhcHBsaWNhdGlvbnMg
YXQgYWxsLiBBZGRpbmcgbmVzdGVkIGludG8gdGhpcyBwaWN0dXJlIGRvZXNuJ3QNCj4gbWFrZSB0
aGluZ3MgYSBsb3Qgd29yc2VyLg0KDQpBbGwgeW91ciBjb21tZW50cyBpbmNvcnBvcmF0ZWQgZXhj
ZXB0IHRoaXMgb25lLiBBcyBzYWlkIGFsd2F5cyB0cmFwcGluZw0KI05NIGZvciBMMiBpcyBub3Qg
YSBiaWcgcHJvYmxlbSwgYXMgbG9uZyBhcyBpdCdzIHJhcmUgYW5kIGRvbid0IGJyZWFrIGZ1bmN0
aW9uLg0KVXN1YWxseSBhIHJlbGF0aXZlbHkgc3RhdGljIHNjaGVtZSBpcyBzYWZlciB0aGFuIGEg
ZHluYW1pYyBvbmUgaW4gY2FzZSBvZg0KYW55dGhpbmcgb3Zlcmxvb2tlZCBmb3IgdGhlIGluaXRp
YWwgaW1wbGVtZW50YXRpb24uIPCfmIoNCg0KVGhhbmtzDQpLZXZpbg0K
