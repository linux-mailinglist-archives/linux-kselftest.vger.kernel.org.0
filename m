Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20BA311570
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 23:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhBEWb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 17:31:58 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:22678 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232453AbhBEORD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-51-InJ3Dwu4O4qYU7J-rkKpYw-1; Fri, 05 Feb 2021 15:23:47 +0000
X-MC-Unique: InJ3Dwu4O4qYU7J-rkKpYw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Feb 2021 15:23:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Feb 2021 15:23:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <shuah@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field widths
 in vsscanf
Thread-Topic: [PATCH v4 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Thread-Index: AQHW+76k9HEDtLN2E0S7ghaNw2D2r6pJrWNA
Date:   Fri, 5 Feb 2021 15:23:46 +0000
Message-ID: <82696a371fe447c2b201fc812e5a4560@AcuMS.aculab.com>
References: <20210203165009.6299-1-rf@opensource.cirrus.com>
 <20210203165009.6299-2-rf@opensource.cirrus.com>
 <YBr9c44Dvq1ZNrEa@smile.fi.intel.com> <YBwiQ+l6yqs+g+rr@alley>
 <5bfefab6-7a1b-6f5f-319c-8897dbb79a5b@opensource.cirrus.com>
 <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com>
In-Reply-To: <CAHp75VcARyR4YvnWoVk1gnR8v7u_YJPnV0x3Mbe7iLMrvpbSAQ@mail.gmail.com>
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

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDA1IEZlYnJ1YXJ5IDIwMjEgMTI6NTENCj4g
DQo+IE9uIEZyaSwgRmViIDUsIDIwMjEgYXQgMTozNSBQTSBSaWNoYXJkIEZpdHpnZXJhbGQNCj4g
PHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbT4gd3JvdGU6DQo+ID4gT24gMDQvMDIvMjAyMSAxNjoz
NSwgUGV0ciBNbGFkZWsgd3JvdGU6DQo+ID4gPiBPbiBXZWQgMjAyMS0wMi0wMyAyMTo0NTo1NSwg
QW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4+IE9uIFdlZCwgRmViIDAzLCAyMDIxIGF0IDA0
OjUwOjA3UE0gKzAwMDAsIFJpY2hhcmQgRml0emdlcmFsZCB3cm90ZToNCj4gDQo+IC4uLg0KPiAN
Cj4gPiA+Pj4gKyAgIGZvciAoOyBtYXhfY2hhcnMgPiAwOyBtYXhfY2hhcnMtLSkgew0KPiA+ID4+
DQo+ID4gPj4gTGVzcyBmcmFnaWxlIGlzIHRvIHdyaXRlDQo+ID4gPj4NCj4gPiA+PiAgICAgIHdo
aWxlIChtYXhfY2hhcnMtLSkNCj4gPiA+DQo+ID4gPiBFeGNlcHQgdGhhdCB0aGUgb3JpZ2luYWwg
d2FzIG1vcmUgb2J2aW91cyBhdCBsZWFzdCBmb3IgbWUuDQo+ID4gPiBJIGFsd2F5cyBwcmVmZXIg
bW9yZSByZWFkYWJsZSBjb2RlIHdoZW4gdGhlIGNvbXBpbGVyIG1pZ2h0IGRvDQo+ID4gPiB0aGUg
b3B0aW1pemF0aW9uIGVhc2lseS4gQnV0IHRoaXMgaXMgbXkgcGVyc29uYWwgdGFzdGUuDQo+ID4g
PiBJIGFtIGZpbmUgd2l0aCBib3RoIHZhcmlhbnRzLg0KPiANCj4gSSAqc2xpZ2h0bHkqIHByZWZl
ciB3aGlsZS1sb29wICppbiB0aGlzIGNhc2UqIGR1ZSB0byBsZXNzIGNoYXJhY3RlcnMNCj4gdG8g
cGFyc2UgdG8gdW5kZXJzdGFuZCB0aGUgbG9naWMuDQoNClRoZSB0d28gbG9vcHMgYXJlIGFsc28g
aGF2ZSBkaWZmZXJlbnQgdmFsdWVzIGZvciAnbWF4X2NoYXJzJw0KaW5zaWRlIHRoZSBsb29wIGJv
ZHkuDQoNCklmICdtYXhfY2hhcnMnIGlzIGtub3duIHRvIGJlIG5vbi16ZXJvIHRoZSBkbyAuLi4g
d2hpbGUgKC0tbWF4X2NoYXJzKTsNCmxvb3Agd2lsbCBwcm9iYWJsZSBnZW5lcmF0ZSBiZXR0ZXIg
Y29kZS4NCkJ1dCB0aGVyZSBpcyBubyBhY2NvdW50aW5nIGZvciBqdXN0IGhvdyBvZGQgc29tZSBk
ZWNpc2lvbnMgZ2NjDQptYWtlcyBhcmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

