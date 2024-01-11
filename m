Return-Path: <linux-kselftest+bounces-2819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ADD82A615
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 03:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81535B2466D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DB19C;
	Thu, 11 Jan 2024 02:35:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12819B
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40B2Y871043214;
	Thu, 11 Jan 2024 10:34:08 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX07-IMDC.srv.huawei-3com.com (unknown [10.62.14.16])
	by mail.maildlp.com (Postfix) with ESMTP id 62E4122D49A4;
	Thu, 11 Jan 2024 10:38:28 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX07-IMDC.srv.huawei-3com.com (10.62.14.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 11 Jan 2024 10:34:08 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Thu, 11 Jan 2024 10:34:08 +0800
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
        "514118380@qq.com" <514118380@qq.com>, Huyadi <hu.yadi@h3c.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHNlbGZ0ZXN0cy9sYW5kbG9jazpGaXggdHdvIGJ1?=
 =?utf-8?Q?ild_issues?=
Thread-Topic: [PATCH] selftests/landlock:Fix two build issues
Thread-Index: AQHaQ5QxkbjYpIV9GUSOObpENmDqbrDSzGWAgAEYDgA=
Date: Thu, 11 Jan 2024 02:34:08 +0000
Message-ID: <9820400d6083428bbab2dfe5d5682d19@h3c.com>
References: <20240110070854.7077-1-hu.yadi@h3c.com>
 <20240110.ob2roh1Xai9y@digikod.net>
In-Reply-To: <20240110.ob2roh1Xai9y@digikod.net>
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
X-MAIL:h3cspam02-ex.h3c.com 40B2Y871043214

DQotPk9uIFdlZCwgSmFuIDEwLCAyMDI0IGF0IDAzOjA4OjU0UE0gKzA4MDAsIEh1IFlhZGkgd3Jv
dGU6DQo+PiBGcm9tOiAiSHUuWWFkaSIgPGh1LnlhZGlAaDNjLmNvbT4NCj4+IA0KPj4gVHdvIGlz
c3VlcyBjb21lcyB1cCAgd2hpbGUgYnVpbGRpbmcgc2VsZnRlc3QvbGFuZGxvY2s6DQo+PiANCj4+
IHRoZSBmaXJzdCBvbmUgaXMgYXMgdG8gZ2V0dGlkDQo+PiANCj4+IG5ldF90ZXN0LmM6IEluIGZ1
bmN0aW9uIOKAmHNldF9zZXJ2aWNl4oCZOg0KPj4gbmV0X3Rlc3QuYzo5MTo0NTogd2FybmluZzog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZ2V0dGlk4oCZOyBkaWQgeW91IG1l
YW4g4oCYZ2V0Z2lk4oCZPyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4+ICAg
ICAiX3NlbGZ0ZXN0cy1sYW5kbG9jay1uZXQtdGlkJWQtaW5kZXglZCIsIGdldHRpZCgpLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZXRnaWQNCj4+IG5l
dF90ZXN0LmM6KC50ZXh0KzB4NGUwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZ2V0dGlkJw0K
Pj4gDQo+PiB0aGUgc2Vjb25kIGlzIGNvbXBpbGVyIGVycm9yDQo+PiBnY2MgLVdhbGwgLU8yIC1p
c3lzdGVtICAgZnNfdGVzdC5jIC1sY2FwIC1vIC9ob21lL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QNCj4+IGZzX3Rlc3QuYzo0NTc1Ojk6IGVycm9yOiBpbml0
aWFsaXplciBlbGVtZW50IGlzIG5vdCBjb25zdGFudA0KPj4gICAubW50ID0gbW50X3RtcCwNCj4+
ICAgICAgICAgIF5+fn5+fn4NCj4NCj5XaGF0IGlzIHRoZSB2ZXJzaW9uIG9mIEdDQyAoYW5kIGhl
YWRlcnMpIGFuZCBvbiB3aGljaCBzeXN0ZW0gKGFuZA0KPnZlcnNpb24pIGFyZSB5b3UgYnVpbGRp
bmcgdGhlc2UgdGVzdHM/DQoNCmdjYyA3LjMgLyBnbGliYy0yLjI4LyBrZXJuZWwgNC4xOS8gT3Bl
bkV1bG9yMjAuMDMNCg0KPj4gDQo+PiB0aGlzIHBhdGNoIGlzIHRvIGZpeCB0aGVtDQo+PiANCj4+
IFNpZ25lZC1vZmYtYnk6IEh1LllhZGkgPGh1LnlhZGlAaDNjLmNvbT4NCj4+IFN1Z2dlc3RlZC1i
eTogSmlhbyA8amlhb3h1cG9AaDNjLmNvbT4NCj4+IFJldmlld2VkLWJ5OkJlcmxpbiA8YmVybGlu
QGgzYy5jb20+DQo+PiAtLS0NCj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9m
c190ZXN0LmMgIHwgNSArKysrLSAgDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9j
ay9uZXRfdGVzdC5jIHwgMyArLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYyANCj4+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bGFuZGxvY2svZnNfdGVzdC5jDQo+PiBpbmRleCAxOGUxZjg2YTYyMzQuLjkzZWI0MGEwOTA3MyAx
MDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3Qu
Yw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+
PiBAQCAtNDU3Miw3ICs0NTcyLDEwIEBAIEZJWFRVUkVfVkFSSUFOVChsYXlvdXQzX2ZzKQ0KPj4g
IC8qIGNsYW5nLWZvcm1hdCBvZmYgKi8NCj4+ICBGSVhUVVJFX1ZBUklBTlRfQUREKGxheW91dDNf
ZnMsIHRtcGZzKSB7DQo+PiAgCS8qIGNsYW5nLWZvcm1hdCBvbiAqLw0KPj4gLQkubW50ID0gbW50
X3RtcCwNCj4+ICsJLm1udCA9IHsNCj4+ICsJCS50eXBlID0gInRtcGZzIiwNCj4+ICsgICAgICAg
IAkuZGF0YSA9ICJzaXplPTRtLG1vZGU9NzAwIiwNCj4NCj5XaGVuIGFwcGx5aW5nIHRoaXMgcGF0
Y2ggd2UgZ2V0OiAic3BhY2UgYmVmb3JlIHRhYiBpbiBpbmRlbnQiDQoNClNvcnJ5IGZvciBpbmNv
bnZlbmllbnQsIEknbGwgcmVzZW5kIGl0IHYyIGFmdGVyIGNoZWNrcGF0Y2gucGwgc2hvd3Mgbm8g
ZXJyb3IuDQoNCj4+ICsJfSwNCj4+ICAJLmZpbGVfcGF0aCA9IGZpbGUxX3MxZDEsDQo+PiAgfTsN
Cj4+ICANCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9u
ZXRfdGVzdC5jIA0KPj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9uZXRfdGVz
dC5jDQo+PiBpbmRleCA5MjllMjFjNGRiMDUuLjhmYjM1N2RlOGM1NSAxMDA2NDQNCj4+IC0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL25ldF90ZXN0LmMNCj4+ICsrKyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL25ldF90ZXN0LmMNCj4+IEBAIC0xOCw3ICsx
OCw2IEBADQo+PiAgI2luY2x1ZGUgPHN5cy9wcmN0bC5oPg0KPj4gICNpbmNsdWRlIDxzeXMvc29j
a2V0Lmg+DQo+PiAgI2luY2x1ZGUgPHN5cy91bi5oPg0KPj4gLQ0KPj4gICNpbmNsdWRlICJjb21t
b24uaCINCj4+ICANCj4+ICBjb25zdCBzaG9ydCBzb2NrX3BvcnRfc3RhcnQgPSAoMSA8PCAxMCk7
IEBAIC04OCw3ICs4Nyw3IEBAIHN0YXRpYyBpbnQgDQo+PiBzZXRfc2VydmljZShzdHJ1Y3Qgc2Vy
dmljZV9maXh0dXJlICpjb25zdCBzcnYsDQo+PiAgCWNhc2UgQUZfVU5JWDoNCj4+ICAJCXNydi0+
dW5peF9hZGRyLnN1bl9mYW1pbHkgPSBwcm90LmRvbWFpbjsNCj4+ICAJCXNwcmludGYoc3J2LT51
bml4X2FkZHIuc3VuX3BhdGgsDQo+PiAtCQkJIl9zZWxmdGVzdHMtbGFuZGxvY2stbmV0LXRpZCVk
LWluZGV4JWQiLCBnZXR0aWQoKSwNCj4+ICsJCQkiX3NlbGZ0ZXN0cy1sYW5kbG9jay1uZXQtdGlk
JWxkLWluZGV4JWQiLCBzeXNjYWxsKFNZU19nZXR0aWQpLA0KPg0KPllvdSBzZW50IGFub3RoZXIg
cGF0Y2ggdGhhdCAicmVwbGFjZSBTWVNfPHN5c2NhbGw+IHdpdGggX19OUl88c3lzY2FsbD4iLg0K
PldoeSBub3QgaGVyZT8NCj4NCj5QbGVhc2UgZm9sbG93IHRoZSBzYW1lIGFwcHJvYWNoOg0KPmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvc3RhYmxlL2MvODcxMjllZjEzNjAzYWU0NmM4MmJjZDA5ZWVk
OTQ4YWNmMDUwNmRiYg0KDQpHb3QgaXQsIEknbGwgcmVzZW5kIGl0IHYyIGluY2x1ZGluZyB0aGUg
Zml4IA0KDQo+PiAgCQkJaW5kZXgpOw0KPj4gIAkJc3J2LT51bml4X2FkZHJfbGVuID0gU1VOX0xF
Tigmc3J2LT51bml4X2FkZHIpOw0KPj4gIAkJc3J2LT51bml4X2FkZHIuc3VuX3BhdGhbMF0gPSAn
XDAnOw0KPj4gLS0NCj4+IDIuMjMuMA0KPj4gDQo+PiANCg0KIA0K

