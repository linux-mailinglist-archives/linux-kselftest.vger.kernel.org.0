Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5B3A1AD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhFIQ2K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 12:28:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:57730 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhFIQ2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 12:28:08 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-FdJreY3ZMLiLZuNVmMRzPw-1; Wed, 09 Jun 2021 17:26:11 +0100
X-MC-Unique: FdJreY3ZMLiLZuNVmMRzPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 9 Jun 2021 17:26:09 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 9 Jun 2021 17:26:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@collabora.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Andrey Semashev" <andrey.semashev@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "malteskarupke@fastmail.fm" <malteskarupke@fastmail.fm>,
        Ingo Molnar <mingo@redhat.com>,
        "pgriffais@valvesoftware.com" <pgriffais@valvesoftware.com>,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "z.figura12@gmail.com" <z.figura12@gmail.com>
Subject: RE: [PATCH v4 00/15] Add futex2 syscalls
Thread-Topic: [PATCH v4 00/15] Add futex2 syscalls
Thread-Index: AQHXXHH+yOYikfdseE6EaGQch1EuiqsL3IpQ
Date:   Wed, 9 Jun 2021 16:26:09 +0000
Message-ID: <ae5b077863fb4853b4f26c3f0b176ac0@AcuMS.aculab.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <22137ccd-c5e6-9fcc-a176-789558e9ab1e@collabora.com>
 <20210608122622.oxf662ruaawrtyrd@linutronix.de>
 <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
In-Reply-To: <YL99cR0H+7xgU8L1@hirez.programming.kicks-ass.net>
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMDggSnVuZSAyMDIxIDE1OjI0DQouLi4NCj4g
QW5kIGlmIHdlJ3JlIGdvaW5nIHRvIGRvIGEgbmV3IGludGVyZmFjZSwgd2Ugb3VnaHQgdG8gbWFr
ZSBvbmUgdGhhdCBjYW4NCj4gc29sdmUgYWxsIHRoZXNlIHByb2JsZW1zLiBOb3csIGlkZWFsbHkg
Z2xpYmMgd2lsbCBicmluZyBmb3J0aCBzb21lDQo+IG9waW5pb25zLCBidXQgaWYgdGhleSBkb24n
dCB3YW50IHRvIHBsYXksIHdlJ2xsIGdvIGJhY2sgdG8gdGhlIGdvb2Qgb2xkDQo+IGRheXMgb2Yg
bm9uLXN0YW5kYXJkIGxvY2tpbmcgbGlicmFyaWVzLi4gd2UncmUgaGFsZndheSB0aGVyZSBhbHJl
YWR5IGR1ZQ0KPiB0byBnbGliYyBub3Qgd2FudGluZyB0byBicmVhayB3aXRoIFBPU0lYIHdlcmUg
d2Uga25vdyBQT1NJWCB3YXMganVzdA0KPiBkZWFkIHdyb25nIGJyb2tlbi4NCg0KSSBoYWQgYSBw
cm9ibGVtIHdpdGggcHRocmVhZF9icm9hZGNhc3QoKS4NCkkndmUgZ290IG11bHRpcGxlIHRocmVh
ZHMgYWxsIGJvdW5kIHRvIGRpZmZlcmVudCBjcHUgYW5kDQpJIHJlYWxseSBkbyB3YW50IHRvIHdh
a2UgdGhlbSBhbGwgdXAgYXQgb25jZS4NCk5vdywgSSBrbm93IHRoZXknbGwgc3BpbiBvbiB0aGUg
bXV0ZXggZm9yIGEgYml0IC0gYnV0IHRoYXQNCmlzIHNvb24gcmVsZWFzZWQgKHRoZSAnYWRhcHRp
dmUnIHNwaW4gaXMgcHJvYmFibHkgbG9uZyBlbm91Z2gpLg0KDQpCdXQgd2hhdCBhY3R1YWxseSBo
YXBwZW5zIChwcm9iYWJseSBiZWNhdXNlIG9mIHRoZSB3YXkgZ2xpYmMNCmlzIGNvbnN0cmFpbmVk
IGJ5IHRoZSBmdXRleHQgc3lzdGVtIGNhbGwpIGlzOg0KMSkgVGhlIGZpcnN0IHRocmVhZCBpcyB3
b2tlbi4NCjIpIEl0J3MgY3B1IGNvbWVzIG91dCBvZiBzbGVlcC4NCjMpIE9uY2UgcnVubmluZyBp
dCB3YWtlcyB0aGUgc2Vjb25kIHRocmVhZC4NCjQpIEl0J3MgY3B1IGNvbWVzIG91dCBvZiBzbGVl
cC4NCi4uLg0KU28geW91IGdldCBhIHZlcnkgc2xvdyByaXBwbGUgb2YgdGhlIHRocmVhZHMgc3Rh
cnRpbmcuDQoNCldvcnNlIHN0aWxsLCBpZiB0aGUgdGhyZWFkIGNhbid0IGJlIHNjaGVkdWxlZCAo
ZWcgYmVjYXVzZQ0KaXRzIGNwdSBpcyBydW5uaW5nIGFsbCB0aGUgbmV0d29yayBzdGFjayBzb2Z0
aW50IGNvZGUpDQp0aGVuIG5vbmUgb2YgdGhlIGxhdGVyIHRocmVhZHMgc3RhcnQgcnVubmluZy4N
Cg0KSSd2ZSBtaXRpZ2F0ZWQgaXQgYnkgdXNpbmcgYSBzZXBhcmF0ZSBjdiBmb3IgZWFjaCB0aHJl
YWQNCmFuZCBsb29waW5nIHRvIHdha2UgdGhlbSBhbGwgLSBidXQgaXQgc2hvdWxkbid0IHJlYWxs
eQ0KYmUgbmVjZXNzYXJ5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

