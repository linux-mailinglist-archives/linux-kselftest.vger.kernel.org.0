Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9537E595F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjKHOnd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 09:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjKHOnc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 09:43:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4761BD7
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 06:43:30 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-f2DJacRmPsWNj5mB7xeKRQ-1; Wed, 08 Nov 2023 14:43:27 +0000
X-MC-Unique: f2DJacRmPsWNj5mB7xeKRQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 8 Nov
 2023 14:43:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 8 Nov 2023 14:43:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mina Almasry' <almasrymina@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Jeroen de Borst" <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Subject: RE: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Thread-Topic: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Thread-Index: AQHaEFtCwSYr9EEKH0iEeRZOyEz/y7BwghiQ
Date:   Wed, 8 Nov 2023 14:43:23 +0000
Message-ID: <1478ddd0902941fba8316e8883de2758@AcuMS.aculab.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com>
In-Reply-To: <20231106024413.2801438-10-almasrymina@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogTWluYSBBbG1hc3J5DQo+IFNlbnQ6IDA2IE5vdmVtYmVyIDIwMjMgMDI6NDQNCj4gDQo+
IEZvciBkZXZpY2UgbWVtb3J5IFRDUCwgd2UgZXhwZWN0IHRoZSBza2IgaGVhZGVycyB0byBiZSBh
dmFpbGFibGUgaW4gaG9zdA0KPiBtZW1vcnkgZm9yIGFjY2VzcywgYW5kIHdlIGV4cGVjdCB0aGUg
c2tiIGZyYWdzIHRvIGJlIGluIGRldmljZSBtZW1vcnkNCj4gYW5kIHVuYWNjZXNzaWJsZSB0byB0
aGUgaG9zdC4gV2UgZXhwZWN0IHRoZXJlIHRvIGJlIG5vIG1peGluZyBhbmQNCj4gbWF0Y2hpbmcg
b2YgZGV2aWNlIG1lbW9yeSBmcmFncyAodW5hY2Nlc3NpYmxlKSB3aXRoIGhvc3QgbWVtb3J5IGZy
YWdzDQo+IChhY2Nlc3NpYmxlKSBpbiB0aGUgc2FtZSBza2IuDQo+IA0KPiBBZGQgYSBza2ItPmRl
dm1lbSBmbGFnIHdoaWNoIGluZGljYXRlcyB3aGV0aGVyIHRoZSBmcmFncyBpbiB0aGlzIHNrYg0K
PiBhcmUgZGV2aWNlIG1lbW9yeSBmcmFncyBvciBub3QuDQo+IA0KLi4uDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPiBpbmRl
eCAxZmFlMjc2YzEzNTMuLjhmYjQ2OGZmODExNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51
eC9za2J1ZmYuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+IEBAIC04MDUsNiAr
ODA1LDggQEAgdHlwZWRlZiB1bnNpZ25lZCBjaGFyICpza19idWZmX2RhdGFfdDsNCj4gICAqCUBj
c3VtX2xldmVsOiBpbmRpY2F0ZXMgdGhlIG51bWJlciBvZiBjb25zZWN1dGl2ZSBjaGVja3N1bXMg
Zm91bmQgaW4NCj4gICAqCQl0aGUgcGFja2V0IG1pbnVzIG9uZSB0aGF0IGhhdmUgYmVlbiB2ZXJp
ZmllZCBhcw0KPiAgICoJCUNIRUNLU1VNX1VOTkVDRVNTQVJZIChtYXggMykNCj4gKyAqCUBkZXZt
ZW06IGluZGljYXRlcyB0aGF0IGFsbCB0aGUgZnJhZ21lbnRzIGluIHRoaXMgc2tiIGFyZSBiYWNr
ZWQgYnkNCj4gKyAqCQlkZXZpY2UgbWVtb3J5Lg0KPiAgICoJQGRzdF9wZW5kaW5nX2NvbmZpcm06
IG5lZWQgdG8gY29uZmlybSBuZWlnaGJvdXINCj4gICAqCUBkZWNyeXB0ZWQ6IERlY3J5cHRlZCBT
S0INCj4gICAqCUBzbG93X2dybzogc3RhdGUgcHJlc2VudCBhdCBHUk8gdGltZSwgc2xvd2VyIHBy
ZXBhcmUgc3RlcCByZXF1aXJlZA0KPiBAQCAtOTkxLDcgKzk5Myw3IEBAIHN0cnVjdCBza19idWZm
IHsNCj4gICNpZiBJU19FTkFCTEVEKENPTkZJR19JUF9TQ1RQKQ0KPiAgCV9fdTgJCQljc3VtX25v
dF9pbmV0OjE7DQo+ICAjZW5kaWYNCj4gLQ0KPiArCV9fdTgJCQlkZXZtZW06MTsNCj4gICNpZiBk
ZWZpbmVkKENPTkZJR19ORVRfU0NIRUQpIHx8IGRlZmluZWQoQ09ORklHX05FVF9YR1JFU1MpDQo+
ICAJX191MTYJCQl0Y19pbmRleDsJLyogdHJhZmZpYyBjb250cm9sIGluZGV4ICovDQo+ICAjZW5k
aWYNCj4gQEAgLTE3NjYsNiArMTc2OCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2tiX3pjb3B5
X2Rvd25ncmFkZV9tYW5hZ2VkKHN0cnVjdCBza19idWZmICpza2IpDQo+ICAJCV9fc2tiX3pjb3B5
X2Rvd25ncmFkZV9tYW5hZ2VkKHNrYik7DQo+ICB9DQoNCkRvZXNuJ3QgdGhhdCBibG9hdCBzdHJ1
Y3Qgc2tfYnVmZj8NCkknbSBub3Qgc3VyZSB0aGVyZSBhcmUgYW55IHNwYXJlIGJpdHMgYXZhaWxh
YmxlLg0KQWx0aG91Z2ggQ09ORklHX05FVF9TV0lUQ0hERVYgYW5kIENPTkZJR19ORVRfU0NIRUQg
c2VlbSB0bw0KYWxyZWFkeSBhZGQgcGFkZGluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

