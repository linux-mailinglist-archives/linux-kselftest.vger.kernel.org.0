Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920149D087
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiAZRQW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 12:16:22 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:31129 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbiAZRQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 12:16:21 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-5jw7EpX6N4aq0oVh1z86_w-1; Wed, 26 Jan 2022 17:16:19 +0000
X-MC-Unique: 5jw7EpX6N4aq0oVh1z86_w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 26 Jan 2022 17:16:16 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 26 Jan 2022 17:16:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Christian Brauner <brauner@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: RE: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on 32-bit
 little endian
Thread-Topic: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on
 32-bit little endian
Thread-Index: AdgS2G4EeBx+7+jyRfijfhRZbWR//g==
Date:   Wed, 26 Jan 2022 17:16:16 +0000
Message-ID: <fc04219fc3414bbb968adb844052ecb7@AcuMS.aculab.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
 <20220124171253.22072-3-mathieu.desnoyers@efficios.com>
 <20220125122156.v2f5anzcs35i3rii@wittgenstein>
 <1234069751.70438.1643121673355.JavaMail.zimbra@efficios.com>
 <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com>
In-Reply-To: <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMjUgSmFudWFyeSAyMDIyIDE5OjAxDQo+
IA0KPiAtLS0tLSBPbiBKYW4gMjUsIDIwMjIsIGF0IDk6NDEgQU0sIE1hdGhpZXUgRGVzbm95ZXJz
IG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbSB3cm90ZToNCj4gDQo+ID4gLS0tLS0gT24g
SmFuIDI1LCAyMDIyLCBhdCA3OjIxIEFNLCBDaHJpc3RpYW4gQnJhdW5lciBicmF1bmVyQGtlcm5l
bC5vcmcgd3JvdGU6DQo+IFsuLi5dDQo+ID4+PiAgaW5jbHVkZS91YXBpL2xpbnV4L3JzZXEuaCB8
IDE3ICsrKystLS0tLS0tLS0tLS0tDQo+IFsuLi5dDQo+ID4+PiAgCXVuaW9uIHsNCj4gPj4NCj4g
Pj4gQSBiaXQgdW5mb3J0dW5hdGUgd2Ugc2VlbSB0byBoYXZlIHRvIGtlZXAgdGhlIHVuaW9uIGFy
b3VuZCBldmVuIHRob3VnaA0KPiA+PiBpdCdzIGp1c3Qgb25lIGZpZWxkIG5vdy4NCj4gPg0KPiA+
IFdlbGwsIGFzIGZhciBhcyB0aGUgdXNlci1zcGFjZSBwcm9qZWN0cyB0aGF0IEkga25vdyBvZiB3
aGljaCB1c2UgcnNlcQ0KPiA+IGFyZSBjb25jZXJuZWQgKGdsaWJjLCBsaWJyc2VxLCB0Y21hbGxv
YyksIHRob3NlIGVuZCB1cCB3aXRoIHRoZWlyIG93bg0KPiA+IGNvcHkgb2YgdGhlIHVhcGkgaGVh
ZGVyIGFueXdheSB0byBkZWFsIHdpdGggdGhlIGJpZy9saXR0bGUgZW5kaWFuIGZpZWxkDQo+ID4g
b24gMzItYml0LiBTbyBJJ20gdmVyeSBtdWNoIG9wZW4gdG8gcmVtb3ZlIHRoZSB1bmlvbiBpZiB3
ZSBhY2NlcHQgdGhhdA0KPiA+IHRoaXMgdWFwaSBoZWFkZXIgaXMgcmVhbGx5IGp1c3QgbWVhbnQg
dG8gZXhwcmVzcyB0aGUgQUJJIGFuZCBpcyBub3QNCj4gPiBleHBlY3RlZCB0byBiZSB1c2VkIGFz
IGFuIEFQSSBieSB1c2VyLXNwYWNlLg0KPiA+DQo+ID4gVGhhdCB3b3VsZCBtZWFuIHdlIGFsc28g
YnJpbmcgYSB1YXBpIGhlYWRlciBjb3B5IGludG8gdGhlIGtlcm5lbA0KPiA+IHJzZXEgc2VsZnRl
c3RzIGFzIHdlbGwgdG8gbWluaW1pemUgdGhlIGdhcCBiZXR3ZWVuIGxpYnJzZXEgYW5kDQo+ID4g
dGhlIGtlcm5lbCBzZWZsdGVzdHMgKHRoZSBrZXJuZWwgc2VmbHRlc3RzIHByZXR0eSBtdWNoIGlu
Y2x1ZGUgYQ0KPiA+IGNvcHkgb2YgbGlicnNlcSBmb3IgY29udmVuaWVuY2UuIGxpYnJzZXEgaXMg
bWFpbnRhaW5lZCBvdXQgb2YgdHJlZSkuDQo+ID4NCj4gPiBUaG91Z2h0cyA/DQo+IA0KPiBBY3R1
YWxseSwgaWYgd2UgZ28gYWhlYWQgYW5kIHJlbW92ZSB0aGUgdW5pb24sIGFuZCByZXBsYWNlOg0K
PiANCj4gc3RydWN0IHJzZXEgew0KPiAgIHVuaW9uIHsNCj4gICAgIF9fdTY0IHB0cjY0Ow0KPiAg
IH0gcnNlcV9jczsNCj4gWy4uLl0NCj4gfSB2Ow0KPiANCj4gYnk6DQo+IA0KPiBzdHJ1Y3QgcnNl
cSB7DQo+ICAgX191NjQgcnNlcV9jczsNCj4gfSB2Ow0KPiANCj4gZXhwcmVzc2lvbnMgc3VjaCBh
cyB0aGVzZSBhcmUgdW5jaGFuZ2VkOg0KPiANCj4gLSBzaXplb2Yodi5yc2VxX2NzKSwNCj4gLSAm
di5yc2VxX2NzLA0KPiAtIF9fYWxpZ25vZl9fKHYucnNlcV9jcyksDQo+IC0gb2Zmc2V0b2Yoc3Ry
dWN0IHJzZXEsIHJzZXFfY3MpLg0KPiANCj4gU28gdXNlcnMgb2YgdGhlIHVhcGkgcnNlcS5oIChh
cyBhbiBBUEkpIGNhbiBzdGlsbCB1c2UgcnNlcV9hYmktPnJzZXFfY3MgYmVmb3JlDQo+IGFuZCBh
ZnRlciB0aGUgY2hhbmdlLg0KDQpCdXQ6DQoJdi5yc2VxX2NzLnB0cl82NCA9ICh1aW50cHRyX3Qp
JmZvbzsNCmlzIGJyb2tlbi4NCg0KPiBCYXNlZCBvbiB0aGlzLCBJIGFtIGluY2xpbmVkIHRvIHJl
bW92ZSB0aGUgdW5pb24sIGFuZCBqdXN0IG1ha2UgdGhlIHJzZXFfY3MgZmllbGQNCj4gYSBfX3U2
NC4NCg0KSXQgcmVhbGx5IGlzIGEgc2hhbWUgdGhhdCB5b3UgY2FuJ3QgZG86DQoJdm9pZCAgICpy
c2VxX2NzIF9fYXR0cmlidXRlX18oKHNpemUoOCkpKTsNCmFuZCBoYXZlIHRoZSBjb21waWxlciBq
dXN0IERUUlQgb24gMzJiaXQgc3lzdGVtcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

