Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9073D8660
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 06:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhG1ECQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 00:02:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:54837 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhG1ECQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 00:02:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212606398"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="212606398"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 21:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="665721216"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2021 21:02:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 27 Jul 2021 21:02:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 21:02:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 21:02:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 21:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II7FVq0CGjEyumb2SFFeAjUPYgdB9wlRH6j6rdfjYf6xj8YQd1RAio6yOIeWfQHohNzoM+1QMiTQ3+Y44ratHbHtNVKjA/UKo6X/Ah9ber6x5uPDpoarPqVpiXTOOdKsesJry6SL8ZeGdXbXebByD5IPgVHabcdoUYiB6FLeS6zBXvuQs9vN16+VYdxcO2JXnHdBKS/lrD/MpYm9eEdsaphUUvJ5lyjCjm79i3Jt4lrVzJhq+MgXCYHKsHsS+svU160AMbxsoueh1sTYSh/2akr/llfEXSVoQ57aQcFxqVepBcdcKbtSB4uMnqntTaZYdGF8zQvwxeO6RKU5sUZ8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWaBhPCbhmMqtUgto3HlsKjv/gNRDV0J67Pfr41IGSc=;
 b=RG45mlt6WwCAFJPbrTXea1AAf8uWIeDrdNVRI4PYZoJREjbUxo7+KtbN1/v9KncmsyOR+utIpPxiIywjlvEyrzcw5BVSzueSCEOKQwToZenEuWjbkO9t4Oj+y76kYTDHjZCa9aU7yjVNA4hGKAYy2in6RUwju0kFnnSx6cQ0u5gqkFjGMBg1aulUrw9Rfu7K0SCZZFK4qBUTm5Q0YNWYq/63clJta8k3kPFuGkn3/YbqaF9Cyr0oKex3jK/C5D+uquep5xpbvoV+KRril+plQEF9oFtOpJCjIhcjIrg5nkFN+Bm0xJk3SLH96dQPXfRJI+PtJ62zxdfL5YUkK2HZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWaBhPCbhmMqtUgto3HlsKjv/gNRDV0J67Pfr41IGSc=;
 b=rx6TWRTZAtPyMu94h/wENi+km/v1IBcr8rXUqWsRNz6U2AHxTa5KrhxzEyev25KaHYf/wXzREmbjZOyFmLmRd6o6a/qCFLzfpiMPID8eBE6I24gtXxRQkPy4MqOeRGLWYfZD1QONXiWYUfStf5qdzU413Klr0UC3kmfNtshw1/I=
Received: from DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) by
 DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17; Wed, 28 Jul 2021 04:02:07 +0000
Received: from DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::4e4:c86b:b091:bc26]) by DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::4e4:c86b:b091:bc26%4]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 04:02:07 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     Erdem Aktas <erdemaktas@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Jones" <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        David Matlack <dmatlack@google.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH 0/4] TDX KVM selftests
Thread-Topic: [RFC PATCH 0/4] TDX KVM selftests
Thread-Index: AQHXgk3b4iupEkD9cUCa9RPn5NkMP6tXxJew
Date:   Wed, 28 Jul 2021 04:02:07 +0000
Message-ID: <DM8PR11MB567015E199025709764B4FD092EA9@DM8PR11MB5670.namprd11.prod.outlook.com>
References: <20210726183816.1343022-1-erdemaktas@google.com>
In-Reply-To: <20210726183816.1343022-1-erdemaktas@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b74e82dc-6ae4-4929-b526-08d9517c77c0
x-ms-traffictypediagnostic: DM8PR11MB5605:
x-microsoft-antispam-prvs: <DM8PR11MB5605FC496A44D68F34B0789892EA9@DM8PR11MB5605.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvH+iPUByacb5lqTYPxpBcznR4C2ZOlqp3f0YbPaGsyuQ6/CN2yvF29SbQ5y1CI33L/liO4dRXSMYFop1utkaTiQo0vrYJT2Qn8QB129F+9xKhAgzxnnjWfOEERlFpSaztUooMAJrkXDhF3fNS2iM/MWQOku2zEZ5hbvBnKOt+iT09GeJi/V5IcgEc/Vy0xG8ht/qeYm4uWN9I1VssagFMRKtcXaZtd46foxF3nLWmqabLw1gvs6QFqnNwFFmsxE8g1PRCB50sdJ6WmXtR4lv5z0dwGpSjjP4DirdeYXupMMIGBoffbvZnfuvotsLpihQCwzUhw3qlXmL0PK6wlCqtOm76pdYtb+dYkEP9aP/tr5woqH+0FJzabNe6mMj8qzlxSVjx+Io/Ya8h5irvGxsVJF55XFIs+M3ePpIpwg1EbkpebyyUyqso4Fmaay/Zci2j9IpoWjFx7OBkYkd5PHrs5jdpgt2Rt800O32P7eNzcJsv7eEly20rnZwpp1FCiaMUIzDALaazPMfmqdvo2acQUT9gxZPqJKeHg5qimL+zmDWQYjR4B+K0MIv+cAhPVHElCWYeRUyAmefGPEgiqXCrrZ8HC3By4a9jirvS7TebibEsryFGGPhrwqia3FJ+sXVRcDvRBIxE0CwQ0DMf6r1sf1Xz/xK7Zn34zGn3zwNfDVURsjeUt2Ihh/tzZRbTd4xPOMMJiPOXNSzKY2NsD/QTyGi51OkC+TGis2K0qxe+cISpEJor/Rt4NuZd1s+gh9FvoF/Z3JJS/YDt+jBVUXM8ILgYftJyjdvYYSnKj0X8xNQCYisGJl3zqH13EtcRTLseKit25acZ3M1CDJBfMfVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(186003)(76116006)(54906003)(122000001)(110136005)(33656002)(38100700002)(5660300002)(66446008)(66476007)(83380400001)(4326008)(316002)(66946007)(8676002)(55016002)(86362001)(9686003)(52536014)(26005)(66556008)(64756008)(478600001)(966005)(8936002)(53546011)(6506007)(7696005)(71200400001)(7416002)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0J1YkZ0VVZTU3FkNFVpS1JyMXNsbHlwYkFTb2l1ZlBOa05ZZitIVUFFRkRo?=
 =?utf-8?B?azFYaGlMWFpUcTlNcXZEYUdtVDFuN0JjV3dkOUhXSXFYR1FzYVlzSDc5cHpR?=
 =?utf-8?B?T2xrUDN3MmQydFgzVU9QSGRvMXM3T3pnUE9rN0MvMnRQRGRsMUdhd210c1NR?=
 =?utf-8?B?YTdYazBlbFVQV0dKeWRZUS9pOVZKcldRNWc0d1Z5ZjRJN1htU0FyYXZDTTc5?=
 =?utf-8?B?cnRxejc5T1pSY2crNXJSSTk2WUk0TmZGUFZYaEVJNjJ5YkxOVTE1dFRydHVN?=
 =?utf-8?B?c20xRVkyNGNvTi9WUDg4amZVVFhtQ1J1Sk1HNlVVM05MM0lnSnpNc3AvNHlO?=
 =?utf-8?B?N2ZHNWhNN0ZOSTN2MUs1VDFpcHMyRURoTUJzZWtPVzlRZ1FVUUtlVjdWVWlv?=
 =?utf-8?B?T25RSTBUQ2V0aVJuRjhHbWNOLzRaZzdtTVpGS1V0U1NyVHNWNjk2ekVPU3Z2?=
 =?utf-8?B?Q1dwbGtSbXRxSkJXeEx4Z0RvRWhHWWsyekhFNWZrb3RFMGtKL3lMaEo4Z2JO?=
 =?utf-8?B?ODhVSGJMcDhsYXE1ZDJWV3k4d21TQzUveCtrenBMWngvbjJxVXp0RnU2RVNT?=
 =?utf-8?B?UCt4QmxWUk5pOWhzbkpPU1NvY1pIaE9sa3hMWSt6WHhseVR1OXhvSWVuQlp5?=
 =?utf-8?B?WDVCVzYraWszRVhVM1VGbTVoWlQxOWlrS2dPOEh1bFluTU5hRDB4WHF5U2Mw?=
 =?utf-8?B?S0g4M0UzZXN5YmV3MHROS3FYWUNkTjlzRkNpRU9xdkFNUCtnQlVndUNJNVl0?=
 =?utf-8?B?U0t5OEFTM3FnZWZNd0RQWEp5WTFydnlrdEJEbUZiRDVWbDQ3RlltQUZPWktB?=
 =?utf-8?B?UzJuZzdMZzRlYm02SHc4OC93WWt6OHMwajZ0M05vR1JEYWV2OGtaTE1GeTNO?=
 =?utf-8?B?RnRBaGtvVHZ1NWVYcUJsUWc0N2FNaXppY20xeFNJbExmclhvcmlKNDcveVNv?=
 =?utf-8?B?Yk5rbXpyUC9EVGVkUnRnYmlENUZDUXNDQStBaFUxdFlFWTBuS2xHS0lzaWph?=
 =?utf-8?B?UTV2WjJNMHhnelRpMGVGT3FvQlhsREpVLzJwUlp1WHByZERDdVJldndtMUlo?=
 =?utf-8?B?NVhtK0pVZm1GMHVYbjVyZTc4REFRZXdVN2xhSHNUc3FUSFdGMUtKNlVGRGRV?=
 =?utf-8?B?UWR2SDYrcG1Tcy8wRmRGTWhXWmVsZW9IVVBleHI4KzJSZUE2STUyOWpZQXhY?=
 =?utf-8?B?cGJaSnJFVmFwZUJVVFYrOGlDQkdpdFZJV0tKM0FLMHVSZFFqSlpsc2IxODhv?=
 =?utf-8?B?Ly8wd05JbTFTWitKRXE5dUEvVEF3TFlCSGo5NnpsRWxYdjBNZWkyT2VUaFdi?=
 =?utf-8?B?TDg3eDJEZjI2cHY2K2RmbHhmaWo5V29SRDVkQmI4L0hVWXRBZk1ueE5Jb2I3?=
 =?utf-8?B?dWd0bzhwQlE2YVo1Qi8zY2tYUzV4S1dJZ3FVOHh2WGhVY0p2dlFKNVFlMHcv?=
 =?utf-8?B?WWpPQkJTVmFNY3VaQUxpWkRscW15TkN3MStvYkV6YnlhdFdpcHNBT081UE52?=
 =?utf-8?B?QllacG9RWFdVNjg1OTFmLzZHTlg5QWd0LzdGNm1JbTlGZUhTbzk5NVREekd3?=
 =?utf-8?B?NDVVOHVpaEpVa2ptNHpMbW1rTzJlMjg2VitLNGt3a3FBWFRYaGNLb3RyVjdB?=
 =?utf-8?B?dUgrTGh1akorM2lXM0htbFFDUmRFUEYvQkRVcUE1WFQ5MkllaThMcGk2ZU5M?=
 =?utf-8?B?TTJwdUxBV1djSUJkd1Nab2hidmttRlo0cXRPTjhBS1NJS2RMenB3ZXVZa1g0?=
 =?utf-8?Q?BSOqCm5he+zerjBfOP5djm4TSJYl+j9kh71xRwI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74e82dc-6ae4-4929-b526-08d9517c77c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 04:02:07.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVC9c2I+Ymn6EvNzBm+I5UMSuA5euDUjfBRNQDDWrqfPeqNqQ5BvzkZOVChq3kUHp4U9mL1ffM2cUSF5B/rYfKrVEp62hTyFITz6+gnZm+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVyZGVtIEFrdGFzIDxlcmRl
bWFrdGFzQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjcsIDIwMjEgMjozOCBB
TQ0KPiBUbzogbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZw0KPiBDYzogZXJkZW1ha3Rh
c0Bnb29nbGUuY29tOyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgU2h1YWgN
Cj4gS2hhbiA8c2h1YWhAa2VybmVsLm9yZz47IEFuZHJldyBKb25lcyA8ZHJqb25lc0ByZWRoYXQu
Y29tPjsgQmVuDQo+IEdhcmRvbiA8YmdhcmRvbkBnb29nbGUuY29tPjsgUGV0ZXIgWHUgPHBldGVy
eEByZWRoYXQuY29tPjsgU2Vhbg0KPiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+
OyBDaHJpc3RpYW4gQm9ybnRyYWVnZXINCj4gPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+OyBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ow0KPiBFbWFudWVsZSBHaXVzZXBwZSBFc3Bv
c2l0byA8ZWVzcG9zaXRAcmVkaGF0LmNvbT47IFJpY2FyZG8gS29sbGVyDQo+IDxyaWNhcmtvbEBn
b29nbGUuY29tPjsgRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+Ow0K
PiBBYXJvbiBMZXdpcyA8YWFyb25sZXdpc0Bnb29nbGUuY29tPjsgSmltIE1hdHRzb24NCj4gPGpt
YXR0c29uQGdvb2dsZS5jb20+OyBPbGl2ZXIgVXB0b24gPG91cHRvbkBnb29nbGUuY29tPjsgVml0
YWx5DQo+IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT47IFBldGVyIFNoaWVyIDxwc2hp
ZXJAZ29vZ2xlLmNvbT47IEF4ZWwNCj4gUmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5j
b20+OyBZYW5hbiBXYW5nDQo+IDx3YW5neWFuYW41NUBodWF3ZWkuY29tPjsgTWFjaWVqIFMuIFN6
bWlnaWVybw0KPiA8bWFjaWVqLnN6bWlnaWVyb0BvcmFjbGUuY29tPjsgRGF2aWQgTWF0bGFjayA8
ZG1hdGxhY2tAZ29vZ2xlLmNvbT47DQo+IExpa2UgWHUgPGxpa2UueHVAbGludXguaW50ZWwuY29t
Pjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gb3BlbiBsaXN0
OktFUk5FTCBWSVJUVUFMIE1BQ0hJTkUgKEtWTSkgPGt2bUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFtSRkMgUEFUQ0ggMC80XSBURFggS1ZNIHNlbGZ0ZXN0cw0KPiANCj4gVERYIHN0YW5k
cyBmb3IgVHJ1c3QgRG9tYWluIEV4dGVuc2lvbnMgd2hpY2ggaXNvbGF0ZXMgVk1zIGZyb20gdGhl
IHZpcnR1YWwtDQo+IG1hY2hpbmUgbWFuYWdlciAoVk1NKS9oeXBlcnZpc29yIGFuZCBhbnkgb3Ro
ZXIgc29mdHdhcmUgb24gdGhlDQo+IHBsYXRmb3JtLg0KPiANCj4gSW50ZWwgaGFzIHJlY2VudGx5
IHN1Ym1pdHRlZCBhIHNldCBvZiBSRkMgcGF0Y2hlcyBmb3IgS1ZNIHN1cHBvcnQgZm9yIFREWA0K
PiBhbmQgbW9yZSBpbmZvcm1hdGlvbiBjYW4gYmUgZm91bmQgb24gdGhlIGxhdGVzdCBURFggU3Vw
cG9ydA0KPiBQYXRjaGVzOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMS83LzIvNTU4DQo+IA0K
PiBEdWUgdG8gdGhlIG5hdHVyZSBvZiB0aGUgY29uZmlkZW50aWFsIGNvbXB1dGluZyBlbnZpcm9u
bWVudCB0aGF0IFREWA0KPiBwcm92aWRlcywgaXQgaXMgdmVyeSBkaWZmaWN1bHQgdG8gdmVyaWZ5
L3Rlc3QgdGhlIEtWTSBzdXBwb3J0LiBURFggcmVxdWlyZXMgVUVGSQ0KPiBhbmQgdGhlIGd1ZXN0
IGtlcm5lbCB0byBiZSBlbmxpZ2h0ZW5lZCB3aGljaCBhcmUgYWxsIHVuZGVyIGRldmVsb3BtZW50
Lg0KPiANCj4gV2UgYXJlIHdvcmtpbmcgb24gYSBzZXQgb2Ygc2VsZnRlc3RzIHRvIGNsb3NlIHRo
aXMgZ2FwIGFuZCBiZSBhYmxlIHRvIHZlcmlmeSB0aGUNCj4gS1ZNIGZ1bmN0aW9uYWxpdHkgdG8g
c3VwcG9ydCBURFggbGlmZWN5Y2xlIGFuZCBHSENJIFsxXSBpbnRlcmZhY2UuDQo+IA0KPiBXZSBh
cmUgbG9va2luZyBmb3IgYW55IGZlZWRiYWNrIG9uOg0KPiAtIFBhdGNoIHNlcmllcyBpdHNlbGYN
Cj4gLSBBbnkgc3VnZ2VzdGlvbiBvbiBob3cgd2Ugc2hvdWxkIGFwcHJvYWNoIHRlc3RpbmcgVERY
IGZ1bmN0aW9uYWxpdHkuDQo+IERvZXMgc2VsZnRlc3RzIHNlZW1zIHJlYXNvbmFibGUgb3Igc2hv
dWxkIHdlIHN3aXRjaCB0byB1c2luZyBLVk0gdW5pdCB0ZXN0cy4NCj4gSSB3b3VsZCBiZSBoYXBw
eSB0byBnZXQgc29tZSBwZXJzcGVjdGl2ZSBvbiBob3cgS1ZNIHVuaXQgdGVzdHMgY2FuIGhlbHAg
dXMNCj4gbW9yZS4NCj4gLSBBbnkgdGVzdCBjYXNlIG9yIHNjZW5hcmlvIHRoYXQgd2Ugc2hvdWxk
IGFkZC4NCj4gLSBBbnl0aGluZyBlbHNlIEkgaGF2ZSBub3QgdGhvdWdodCBvZiB5ZXQuDQo+IA0K
PiBDdXJyZW50IHBhdGNoIHNlcmllcyBwcm92aWRlIHRoZSBmb2xsb3dpbmcgY2FwYWJpbGl0aWVz
Og0KPiANCj4gLSBQcm92aWRlIGhlbHBlciBmdW5jdGlvbnMgdG8gY3JlYXRlIGEgVEQgKFRydXN0
ZWQgRG9tYWluKSB1c2luZyB0aGUgS1ZNDQo+ICAgaW9jdGxzDQo+IC0gUHJvdmlkZSBoZWxwZXIg
ZnVuY3Rpb25zIHRvIGNyZWF0ZSBhIGd1ZXN0IGltYWdlIHRoYXQgY2FuIGluY2x1ZGUgYW55DQo+
ICAgdGVzdGluZyBjb2RlDQo+IC0gUHJvdmlkZSBoZWxwZXIgZnVuY3Rpb25zIGFuZCB3cmFwcGVy
IGZ1bmN0aW9ucyB0byB3cml0ZSB0ZXN0aW5nIGNvZGUNCj4gICB1c2luZyBHSENJIGludGVyZmFj
ZQ0KPiAtIEFkZCBhIHRlc3QgY2FzZSB0aGF0IHZlcmlmaWVzIFREWCBsaWZlIGN5Y2xlDQo+IC0g
QWRkIGEgdGVzdCBjYXNlIHRoYXQgdmVyaWZpZXMgVERYIEdIQ0kgcG9ydCBJTw0KPiANCj4gVE9E
T3M6DQo+IC0gVXNlIGV4aXN0aW5nIGZ1bmN0aW9uIHRvIGNyZWF0ZSBwYWdlIHRhYmxlcyBkeW5h
bWljYWxseQ0KPiAgIChpZSBfX3ZpcnRfcGdfbWFwKCkpDQo+IC0gUmVtb3ZlIGFyYml0cmFyeSBk
ZWZpbmVkIG1hZ2ljIG51bWJlcnMgZm9yIGRhdGEgc3RydWN0dXJlIG9mZnNldHMNCj4gLSBBZGQg
VERWTUNBTEwgZm9yIGVycm9yIHJlcG9ydGluZw0KPiAtIEFkZCBhZGRpdGlvbmFsIHRlc3QgY2Fz
ZXMgYXMgc29tZSBsaXN0ZWQgYmVsb3cNCj4gLSBBZGQgI1ZFIGhhbmRsZXJzIHRvIGhlbHAgdGVz
dGluZyBtb3JlIGNvbXBsaWNhdGVkIHRlc3QgY2FzZXMNCj4gDQo+IE90aGVyIHRlc3QgY2FzZXMg
dGhhdCB3ZSBhcmUgcGxhbm5pbmcgdG8gYWRkOg0KPiAod2l0aCBjcmVkaXQgdG8gc2FnaXNAZ29v
Z2xlLmNvbSkNCj4gDQo+IFZNIGNhbGwgaW50ZXJmYWNlICAgICAgICBJbnB1dCAgICAgICAgICAg
ICAgICAgICAgICAgIE91dHB1dCAgICAgICAgICAgICAgICBSZXN1bHQNCj4gR2V0VGRWbUNhbGxJ
bmZvICAgICAgICAgIFIxMj0wICAgICAgICAgICAgICAgICAgICAgICAgTm9uZSAgICAgICAgICAg
ICAgICBWTUNBTExfU1VDQ0VTUw0KPiBNYXBHUEEgICAgICAgICAgICAgICAgICAgTWFwIHByaXZh
dGUgcGFnZSAoR1BBLlM9MCkNCj4gVk1DQUxMX1NVQ0NFU1MNCj4gTWFwR1BBICAgICAgICAgICAg
ICAgICAgIE1hcCBzaGFyZWQgcGFnZSAoR1BBLlM9MSkNCj4gVk1DQUxMX1NVQ0NFU1MNCj4gTWFw
R1BBICAgICAgICAgICAgICAgICAgIE1hcCBhbHJlYWR5IHByaXZhdGUgcGFnZSBhcyBwcml2YXRl
DQo+IFZNQ0FMTF9JTlZBTElEX09QRVJBTkQNCj4gTWFwR1BBICAgICAgICAgICAgICAgICAgIE1h
cCBhbHJlYWR5IHNoYXJlZCBwYWdlIGFzIHNoYXJlZA0KPiBWTUNBTExfSU5WQUxJRF9PUEVSQU5E
DQo+IEdldFF1b3RlDQo+IFJlcG9ydEZhdGFsRXJyb3INCj4gU2V0dXBFdmVudE5vdGlmeUludGVy
cnVwdCAgIFZhbGlkIGludGVycnVwdCB2YWx1ZSAoMzI6MjU1KQ0KPiBWTUNBTExfU1VDQ0VTUw0K
PiBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0ICAgSW52YWxpZCB2YWx1ZSAoPjI1NSkNCj4gVk1D
QUxMX0lOVkFMSURfT1BFUkFORA0KPiBJbnN0cnVjdGlvbi5DUFVJRCAgICAgICAgUjEyKEVBWCk9
MSwgUjEzKEVDWCk9MCAgICAgICBFQlhbODoxNV09MHg4DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVCWFsxNjoyM109WA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFQlhbMjQ6MzFd
PXZjcHVfaWQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRUNYWzBdPTENCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRUNYWzEyXT1ZDQo+IEluc3RydWN0aW9uLkNQVUlEICAgICAgIFIx
MihFQVgpPTEsIFIxMyhFQ1gpPTQNCj4gVk1DQUxMX0lOVkFMSURfT1BFUkFORA0KPiBWRS5SZXF1
ZXN0TU1JTw0KPiBJbnN0cnVjdGlvbi5ITFQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZNQ0FMTF9TVUNDRVNTDQo+IEluc3RydWN0aW9u
LklPICAgICAgICAgIFJlYWQvV3JpdGUgMS8yLzQgYnl0ZXMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVk1DQUxMX1NVQ0NFU1MNCj4gSW5zdHJ1Y3Rpb24uSU8gICAgICAgICAgUmVhZC9Xcml0
ZSAzIGJ5dGVzDQo+IFZNQ0FMTF9JTlZBTElEX09QRVJBTkQNCj4gSW5zdHJ1Y3Rpb24uUkRNU1Ig
ICAgICAgQWNjZXNzaWJsZSByZWdpc3RlciAgICAgICAgICAgUjExPW1zcl92YWx1ZQ0KPiBWTUNB
TExfU1VDQ0VTUw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBJbmFjY2Vzc2libGUgcmVnaXN0
ZXINCj4gVk1DQUxMX0lOVkFMSURfT1BFUkFORA0KPiBJbnN0cnVjdGlvbi5SRE1TUiAgICAgICBB
Y2Nlc3NpYmxlIHJlZ2lzdGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZNQ0FMTF9T
VUNDRVNTDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEluYWNjZXNzaWJsZSByZWdpc3Rlcg0K
PiBWTUNBTExfSU5WQUxJRF9PUEVSQU5EDQo+IElOU1RSVUNUSU9OLlBDT05GSUcNCj4gDQo+IFsx
XSBJbnRlbCBURFggR3Vlc3QtSHlwZXJ2aXNvciBDb21tdW5pY2F0aW9uIEludGVyZmFjZQ0KPiAN
Cj4gaHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vY29udGVudC9kYW0vZGV2ZWxvcC9leHRlcm5h
bC91cy9lbi9kb2N1bWVudA0KPiBzL2ludGVsLXRkeC1ndWVzdC1oeXBlcnZpc29yLWNvbW11bmlj
YXRpb24taW50ZXJmYWNlLnBkZg0KPiANCj4gDQo+IEVyZGVtIEFrdGFzICg0KToNCj4gICBLVk06
IHNlbGZ0ZXN0czogQWRkIHN1cHBvcnQgZm9yIGNyZWF0aW5nIG5vbi1kZWZhdWx0IHR5cGUgVk1z
DQo+ICAgS1ZNOiBzZWxmdGVzdDogQWRkIGhlbHBlciBmdW5jdGlvbnMgdG8gY3JlYXRlIFREWCBW
TXMNCkluIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9NYWtlZmlsZSwgJy9saWIveDg2XzY0
L3RkeF9saWIuYycgc2hvdWxkIGJlIGNoYW5nZWQgdG8gJ2xpYi94ODZfNjQvdGR4X2xpYi5jJw0K
QWZ0ZXIgdGhhdCwgYnVpbGQgYW5kIHRlc3QgcGFzc2VzLg0KDQojIC4vdGR4X3ZtX3Rlc3RzDQpW
ZXJpZnlpbmcgVEQgbGlmZWN5Y2xlOg0KVmVyaWZ5aW5nIFREIElPIEV4aXQ6DQogICAgICAgICAu
Li4gSU8gV1JJVEU6IE9LDQogICAgICAgICAuLi4gSU8gUkVBRDogT0sNCiAgICAgICAgIC4uLiBJ
TyB2ZXJpZnkgcmVhZC93cml0ZSB2YWx1ZXM6IE9LDQoNClRlc3RlZC1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KUmVnYXJkcw0KWmhlbnpob25nDQo=
