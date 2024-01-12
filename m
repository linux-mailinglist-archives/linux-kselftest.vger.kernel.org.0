Return-Path: <linux-kselftest+bounces-2885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232182BA28
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 04:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A8A1F211EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F61B27B;
	Fri, 12 Jan 2024 03:51:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747922078
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40C3p4MT003113;
	Fri, 12 Jan 2024 11:51:04 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX03-IMDC.srv.huawei-3com.com (unknown [10.62.14.12])
	by mail.maildlp.com (Postfix) with ESMTP id 70BD02383F3B;
	Fri, 12 Jan 2024 11:55:26 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX03-IMDC.srv.huawei-3com.com (10.62.14.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 12 Jan 2024 11:51:05 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 12 Jan 2024 11:51:05 +0800
From: Huyadi <hu.yadi@h3c.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gc2VsZnRlc3RzL2xhbmRsb2NrOkZp?=
 =?utf-8?Q?x_two_build_issues?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHNlbGZ0ZXN0cy9sYW5kbG9jazpGaXggdHdvIGJ1?=
 =?utf-8?Q?ild_issues?=
Thread-Index: AQHaQ5QxkbjYpIV9GUSOObpENmDqbrDSzGWAgAEYDgCAADzbgIABap9w
Date: Fri, 12 Jan 2024 03:51:05 +0000
Message-ID: <9a040b2653114a059956ee33703cf05e@h3c.com>
References: <20240110070854.7077-1-hu.yadi@h3c.com>
 <20240110.ob2roh1Xai9y@digikod.net>
 <9820400d6083428bbab2dfe5d5682d19@h3c.com>
 <20240111.Ooraegolah6n@digikod.net>
In-Reply-To: <20240111.Ooraegolah6n@digikod.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40C3p4MT003113

Pk9uIFRodSwgSmFuIDExLCAyMDI0IGF0IDAyOjM0OjA4QU0gKzAwMDAsIEh1eWFkaSB3cm90ZToN
Cj4+IA0KPj4gLT5PbiBXZWQsIEphbiAxMCwgMjAyNCBhdCAwMzowODo1NFBNICswODAwLCBIdSBZ
YWRpIHdyb3RlOg0KPj4gPj4gRnJvbTogIkh1LllhZGkiIDxodS55YWRpQGgzYy5jb20+DQo+PiA+
PiANCj4+ID4+IFR3byBpc3N1ZXMgY29tZXMgdXAgIHdoaWxlIGJ1aWxkaW5nIHNlbGZ0ZXN0L2xh
bmRsb2NrOg0KPj4gPj4gDQo+PiA+PiB0aGUgZmlyc3Qgb25lIGlzIGFzIHRvIGdldHRpZA0KPj4g
Pj4gDQo+PiA+PiBuZXRfdGVzdC5jOiBJbiBmdW5jdGlvbiDigJhzZXRfc2VydmljZeKAmToNCj4+
ID4+IG5ldF90ZXN0LmM6OTE6NDU6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uIOKAmGdldHRpZOKAmTsgZGlkIHlvdSBtZWFuIOKAmGdldGdpZOKAmT8gWy1XaW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+PiA+PiAgICAgIl9zZWxmdGVzdHMtbGFuZGxvY2st
bmV0LXRpZCVkLWluZGV4JWQiLCBnZXR0aWQoKSwNCj4+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fg0KPj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0Z2lkDQo+PiA+PiBuZXRfdGVzdC5jOigudGV4
dCsweDRlMCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGdldHRpZCcNCj4+ID4+IA0KPj4gPj4g
dGhlIHNlY29uZCBpcyBjb21waWxlciBlcnJvcg0KPj4gPj4gZ2NjIC1XYWxsIC1PMiAtaXN5c3Rl
bSAgIGZzX3Rlc3QuYyAtbGNhcCAtbyAvaG9tZS9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9sYW5kbG9jay9mc190ZXN0DQo+PiA+PiBmc190ZXN0LmM6NDU3NTo5OiBlcnJvcjogaW5pdGlh
bGl6ZXIgZWxlbWVudCBpcyBub3QgY29uc3RhbnQNCj4+ID4+ICAgLm1udCA9IG1udF90bXAsDQo+
PiA+PiAgICAgICAgICBefn5+fn5+DQo+PiA+DQo+PiA+V2hhdCBpcyB0aGUgdmVyc2lvbiBvZiBH
Q0MgKGFuZCBoZWFkZXJzKSBhbmQgb24gd2hpY2ggc3lzdGVtIChhbmQNCj4+ID52ZXJzaW9uKSBh
cmUgeW91IGJ1aWxkaW5nIHRoZXNlIHRlc3RzPw0KPj4gDQo+PiBnY2MgNy4zIC8gZ2xpYmMtMi4y
OC8ga2VybmVsIDQuMTkvIE9wZW5FdWxvcjIwLjAzDQo+DQo+VGhlc2UgYXJlIG9sZCB2ZXJzaW9u
cy4gWW91IHNob3VsZCBtZW50aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGljaCB2ZXJzaW9u
IG9mIGdsaWJjIGFkZGVkIGdldHRpZCgpLj4NCg0KT2ssIEknbGwgYWRkIGl0IC4NCg0KPj4gDQo+
PiA+PiANCj4+ID4+IHRoaXMgcGF0Y2ggaXMgdG8gZml4IHRoZW0NCj4+ID4+IA0KPj4gPj4gU2ln
bmVkLW9mZi1ieTogSHUuWWFkaSA8aHUueWFkaUBoM2MuY29tPg0KPj4gPj4gU3VnZ2VzdGVkLWJ5
OiBKaWFvIDxqaWFveHVwb0BoM2MuY29tPiBSZXZpZXdlZC1ieTpCZXJsaW4gDQo+PiA+PiA8YmVy
bGluQGgzYy5jb20+DQo+PiA+PiAtLS0NCj4+ID4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9s
YW5kbG9jay9mc190ZXN0LmMgIHwgNSArKysrLSANCj4+ID4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2xhbmRsb2NrL25ldF90ZXN0LmMgfCAzICstLQ0KPj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4gPj4gDQo+PiA+PiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+PiA+PiBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYw0KPj4gPj4gaW5kZXggMThl
MWY4NmE2MjM0Li45M2ViNDBhMDkwNzMgMTAwNjQ0DQo+PiA+PiAtLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMNCj4+ID4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYw0KPj4gPj4gQEAgLTQ1NzIsNyArNDU3MiwxMCBA
QCBGSVhUVVJFX1ZBUklBTlQobGF5b3V0M19mcykNCj4+ID4+ICAvKiBjbGFuZy1mb3JtYXQgb2Zm
ICovDQo+PiA+PiAgRklYVFVSRV9WQVJJQU5UX0FERChsYXlvdXQzX2ZzLCB0bXBmcykgew0KPj4g
Pj4gIAkvKiBjbGFuZy1mb3JtYXQgb24gKi8NCj4+ID4+IC0JLm1udCA9IG1udF90bXAsDQo+DQo+
Q2FuIHlvdSBqdXN0IGNhc3QgbW50X3RtcD8gSXQgZXhpc3RzIHRvIGF2b2lkIHN1Y2ggZHVwbGlj
YXRlIGNvZGUuDQoNCkkgdHJpZWQgdG8gYWRkIGNhc3QsIGJ1dCBpdCBpcyBub3QgZWZmZWN0aXZl
LiAgd2hhdCdzIG1vcmUsIGFsbCBGSVhUVVJFX1ZBUklBTlRfQUREIGRlY2xhcmF0aW9uIHVuZGVy
IHRvb2xzL3Rlc3RpbmcgYXJlIGFzc2lnbmVkIHdpdGggY29uc3RhbnQsDQpTbywgY3VycmVudCBz
b2x1dGlvbiBsb29rcyBmaW5lIHRvIG1lLCB3aGF0J3MgeW91ciBvcHRpb24/DQo+DQo+PiA+PiAr
CS5tbnQgPSB7DQo+PiA+PiArCQkudHlwZSA9ICJ0bXBmcyIsDQo+PiA+PiArICAgICAgICAJLmRh
dGEgPSAic2l6ZT00bSxtb2RlPTcwMCIsDQo+PiA+DQo+PiA+V2hlbiBhcHBseWluZyB0aGlzIHBh
dGNoIHdlIGdldDogInNwYWNlIGJlZm9yZSB0YWIgaW4gaW5kZW50Ig0KPj4gDQo+PiBTb3JyeSBm
b3IgaW5jb252ZW5pZW50LCBJJ2xsIHJlc2VuZCBpdCB2MiBhZnRlciBjaGVja3BhdGNoLnBsIHNo
b3dzIG5vIGVycm9yLg0KPj4gDQo+PiA+PiArCX0sDQo+PiA+PiAgCS5maWxlX3BhdGggPSBmaWxl
MV9zMWQxLA0KPj4gPj4gIH07DQo+PiA+PiAgDQo+PiA+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbGFuZGxvY2svbmV0X3Rlc3QuYw0KPj4gPj4gYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9sYW5kbG9jay9uZXRfdGVzdC5jDQo+PiA+PiBpbmRleCA5MjllMjFjNGRiMDUu
LjhmYjM1N2RlOGM1NSAxMDA2NDQNCj4+ID4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2xhbmRsb2NrL25ldF90ZXN0LmMNCj4+ID4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2xhbmRsb2NrL25ldF90ZXN0LmMNCj4+ID4+IEBAIC0xOCw3ICsxOCw2IEBADQo+PiA+PiAgI2lu
Y2x1ZGUgPHN5cy9wcmN0bC5oPg0KPj4gPj4gICNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQo+PiA+
PiAgI2luY2x1ZGUgPHN5cy91bi5oPg0KPj4gPj4gLQ0KPj4gPj4gICNpbmNsdWRlICJjb21tb24u
aCINCj4+ID4+ICANCj4+ID4+ICBjb25zdCBzaG9ydCBzb2NrX3BvcnRfc3RhcnQgPSAoMSA8PCAx
MCk7IEBAIC04OCw3ICs4Nyw3IEBAIHN0YXRpYyANCj4+ID4+IGludCBzZXRfc2VydmljZShzdHJ1
Y3Qgc2VydmljZV9maXh0dXJlICpjb25zdCBzcnYsDQo+PiA+PiAgCWNhc2UgQUZfVU5JWDoNCj4+
ID4+ICAJCXNydi0+dW5peF9hZGRyLnN1bl9mYW1pbHkgPSBwcm90LmRvbWFpbjsNCj4+ID4+ICAJ
CXNwcmludGYoc3J2LT51bml4X2FkZHIuc3VuX3BhdGgsDQo+PiA+PiAtCQkJIl9zZWxmdGVzdHMt
bGFuZGxvY2stbmV0LXRpZCVkLWluZGV4JWQiLCBnZXR0aWQoKSwNCj4+ID4+ICsJCQkiX3NlbGZ0
ZXN0cy1sYW5kbG9jay1uZXQtdGlkJWxkLWluZGV4JWQiLCBzeXNjYWxsKFNZU19nZXR0aWQpLA0K
Pj4gPg0KPj4gPllvdSBzZW50IGFub3RoZXIgcGF0Y2ggdGhhdCAicmVwbGFjZSBTWVNfPHN5c2Nh
bGw+IHdpdGggX19OUl88c3lzY2FsbD4iLg0KPj4gPldoeSBub3QgaGVyZT8NCj4+ID4NCj4+ID5Q
bGVhc2UgZm9sbG93IHRoZSBzYW1lIGFwcHJvYWNoOg0KPj4gPmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvc3RhYmxlL2MvODcxMjllZjEzNjAzYWU0NmM4MmJjZDA5ZWVkOTQ4YWNmMDUwNg0KPj4gPmRi
Yg0KPg0KPkNhbiB5b3UgcGxlYXNlIGFkZCBhIGdldHBpZCgpIGhlbHBlciBsaWtlIGZvciByZW5h
bWVhdDIoKSBpbiB0aGlzIGNvbW1pdD8+DQoNClRoYW5rcyB5b3VyIHdhcm0gaW5zdHJ1Y3Rpb24s
IEknbGwgZG8gaXQgYW5kIHNlbmQgcGF0Y2ggc29vbi4NCg0KPkFsc28sIGFsbCBMYW5kbG9jay1y
ZWxhdGVkIGNvZGUgaXMgZm9ybWF0dGVkIHdpdGggY2xhbmctZm9ybWF0LiBZb3UgY2FuIGRvIGl0
IHdpdGggY2xhbmctZm9ybWF0IC1pIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrLyou
W2NoXQ0KPg0KPj4gDQo+PiBHb3QgaXQsIEknbGwgcmVzZW5kIGl0IHYyIGluY2x1ZGluZyB0aGUg
Zml4DQo+PiANCj4+ID4+ICAJCQlpbmRleCk7DQo+PiA+PiAgCQlzcnYtPnVuaXhfYWRkcl9sZW4g
PSBTVU5fTEVOKCZzcnYtPnVuaXhfYWRkcik7DQo+PiA+PiAgCQlzcnYtPnVuaXhfYWRkci5zdW5f
cGF0aFswXSA9ICdcMCc7DQo+PiA+PiAtLQ0KPj4gPj4gMi4yMy4wDQo+PiA+PiANCj4+ID4+IA0K
Pj4gDQo+PiAgDQogDQo=

