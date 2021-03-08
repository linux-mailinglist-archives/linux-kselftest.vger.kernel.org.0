Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAB3314F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Mar 2021 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCHRdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Mar 2021 12:33:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:36619 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhCHRdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Mar 2021 12:33:21 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-114-VZLpIMkBOySF_toWHzBKNQ-1; Mon, 08 Mar 2021 17:33:17 +0000
X-MC-Unique: VZLpIMkBOySF_toWHzBKNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Mar 2021 17:33:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Mar 2021 17:33:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zebediah Figura' <zfigura@codeweavers.com>,
        =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "pgriffais@valvesoftware.com" <pgriffais@valvesoftware.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "malteskarupke@fastmail.fm" <malteskarupke@fastmail.fm>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [RFC PATCH v2 00/13] Add futex2 syscall
Thread-Topic: [RFC PATCH v2 00/13] Add futex2 syscall
Thread-Index: AQHXFDasHACUUxYyXUab2jknvqbfD6p6VuaA
Date:   Mon, 8 Mar 2021 17:33:17 +0000
Message-ID: <27f3db94ae674d69889301f515ddf483@AcuMS.aculab.com>
References: <20210304004219.134051-1-andrealmeid@collabora.com>
 <2421ca75-5688-61c6-c0ac-02e55e7272a3@codeweavers.com>
In-Reply-To: <2421ca75-5688-61c6-c0ac-02e55e7272a3@codeweavers.com>
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

DQoNCkZyb206IFplYmVkaWFoIEZpZ3VyYQ0KPiBTZW50OiAwOCBNYXJjaCAyMDIxIDE2OjE4DQo+
IA0KPiBPbiAzLzMvMjEgNjo0MiBQTSwgQW5kcsOpIEFsbWVpZGEgd3JvdGU6DQo+ID4gICAqKiBU
aGUgd2FpdCBvbiBtdWx0aXBsZSBwcm9ibGVtDQo+ID4NCj4gPiAgIFRoZSB1c2UgY2FzZSBsaWVz
IGluIHRoZSBXaW5lIGltcGxlbWVudGF0aW9uIG9mIHRoZSBXaW5kb3dzIE5UIGludGVyZmFjZQ0K
PiA+ICAgV2FpdE11bHRpcGxlT2JqZWN0cy4gVGhpcyBXaW5kb3dzIEFQSSBmdW5jdGlvbiBhbGxv
d3MgYSB0aHJlYWQgdG8gc2xlZXANCj4gPiAgIHdhaXRpbmcgb24gdGhlIGZpcnN0IG9mIGEgc2V0
IG9mIGV2ZW50IHNvdXJjZXMgKG11dGV4ZXMsIHRpbWVycywgc2lnbmFsLA0KPiA+ICAgY29uc29s
ZSBpbnB1dCwgZXRjKSB0byBzaWduYWwuICBDb25zaWRlcmluZyB0aGlzIGlzIGEgcHJpbWl0aXZl
DQo+ID4gICBzeW5jaHJvbml6YXRpb24gb3BlcmF0aW9uIGZvciBXaW5kb3dzIGFwcGxpY2F0aW9u
cywgYmVpbmcgYWJsZSB0byBxdWlja2x5DQo+ID4gICBzaWduYWwgZXZlbnRzIG9uIHRoZSBwcm9k
dWNlciBzaWRlLCBhbmQgcXVpY2tseSBnbyB0byBzbGVlcCBvbiB0aGUNCj4gPiAgIGNvbnN1bWVy
IHNpZGUgaXMgZXNzZW50aWFsIGZvciBnb29kIHBlcmZvcm1hbmNlIG9mIHRob3NlIHJ1bm5pbmcg
b3ZlciBXaW5lLg0KPiANCj4gSXQncyBwcm9iYWJseSB3b3J0aCBwb2ludGluZyBvdXQsIGZvciBi
ZXR0ZXIgb3IgZm9yIHdvcnNlLCB3aGlsZSB0aGlzIGlzDQo+ICphKiB1c2UgY2FzZSwgaXQncyBh
bHNvIGxpbWl0ZWQgdG8gYW4gb3V0LW9mLXRyZWUgcGF0Y2ggc2V0L2ZvcmtlZA0KPiB2ZXJzaW9u
cyBvZiBXaW5lLiBJJ20gY3VycmVudGx5IHdvcmtpbmcgb24gYSBkaWZmZXJlbnQgYXBwcm9hY2gg
dGhhdA0KPiBzaG91bGQgYmUgdXBzdHJlYW1hYmxlIHRvIFdpbmUgcHJvcGVyLCBhcyBkZXRhaWxl
ZCBpbiBbMV0uDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9mNGNj
MWEzOC0xNDQxLTYyZjgtNDdlNC0wYzY3ZjVhZDFkNDNAY29kZXdlYXZlcnMuY29tLw0KDQoqIE50
UHVsc2VFdmVudCBjYW4ndCB3b3JrIHJpZ2h0LiBXZSBiYWRseSBlbXVsYXRlIGl0IGJ5IHNldHRp
bmcgYW5kIHRoZW4NCmltbWVkaWF0ZWx5IHJlc2V0dGluZyB0aGUgZXZlbnQsIGJ1dCBkdWUgdG8g
dGhlIGFib3ZlIGdhcCBiZXR3ZWVuIHBvbGwoKQ0KYW5kIHJlYWQoKSwgbW9zdCB0aHJlYWRzIGVu
ZCB1cCBtaXNzaW5nIHRoZSB3YWtldXAgYW55d2F5Lg0KDQpBcyB5b3Ugc3RhdGVkIGxhdGVyIFB1
bHNlRXZlbnQoKSBpcyBjb21wbGV0ZWx5IGJyb2tlbiBhbnl3YXkuDQpBdCBsZWFzdCBvbmUgb2Yg
dGhlIHByb2JsZW1zIGlzIHRoYXQgaW4gb3JkZXIgdG8gY29tcGxldGUgYW4gYXN5bmMgaW8NCihh
bmQgYWxsIGlvIGlzIGFzeW5jKSB0byBmaW5hbCAnY29weV90b191c2VyJyBtdXN0IGJlIGRvbmUg
aW4gdGhlDQpjb250ZXh0IG9mIHRoZSBpbml0aWF0aW5nIHRocmVhZC4NClNvIGlmIHRoZSB0aHJl
YWQgaXMgaW4gV2FpdE11bHRpcGxlT2JqZWN0cyAoaXQgdXN1YWxseSBpcykgYW5kIGFuIGFzeW5j
IGlvDQpjb21wbGV0ZXMgKGVnIHJlY2VpdmUgZGF0YSBvbiBhIFRDUCBjb25uZWN0aW9uKSB0aGUg
dGhyZWFkIHN0b3BzIHdhaXRpbmcNCndoaWxlIHRoZSBpbyBjb21wbGV0aW9uIGNhbGxiYWNrIGlz
IGRvbmUuDQpJZiBhIHB1bHNlRXZlbnQgaGFwcGVucyBkdXJpbmcgdGhhdCB3aW5kb3cgdGhlbiBp
dCBpcyBsb3N0Lg0KDQpNaW5kIHlvdSB0aGVyZSB3YXMgKG1heWJlIGlzIHN0aWxsKSBhIGJ1ZyBp
biBXTU8gb24gNjRiaXQgd2luZG93cw0KdGhhdCBtZWFucyB0aGUgcHJvY2VzcyBjb21wbGV0ZWx5
IG1pc3NlcyBpbyBjb21wbGV0aW9uIGNhbGxiYWNrcw0KaWYgKEkgdGhpbmspIHRoZXkgaGFwcGVu
IHdoaWxlIHRoZSBwcm9jZXNzIGlzIGJlaW5nIHNjaGVkdWxlZC4NClRoZXJlIGlzIGEgbG9vcCBp
biBXTU8gLSB0aGF0IGZhaWxzIHRvIHJlY292ZXIgYmVjYXVzZSBpbnRlcnJ1cHRzDQphcmUgZGlz
YWJsZWQgYW5kIGEgMzAgc2Vjb25kIHRpbWVyIHRoYXQgdW5ibG9ja3MgdGhpbmdzLg0KSSBoYWQg
dG8gYWRkIGNvZGUgdG8gd3JpdGUgdG8gdGhlIGlvYXBpYyB0byByZXF1ZXN0IHRoZSBoYXJkd2Fy
ZQ0KaW50ZXJydXB0IHRvIHVuYmxvY2sgZXZlcnl0aGluZyA6LSkNCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

