Return-Path: <linux-kselftest+bounces-2818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BA82A5FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 03:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462741C22EFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A238804;
	Thu, 11 Jan 2024 02:25:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF67FC
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40B2P3Oi095226;
	Thu, 11 Jan 2024 10:25:03 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX01-IMDC.srv.huawei-3com.com (unknown [10.62.14.10])
	by mail.maildlp.com (Postfix) with ESMTP id 559F822D4780;
	Thu, 11 Jan 2024 10:29:23 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX01-IMDC.srv.huawei-3com.com (10.62.14.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 11 Jan 2024 10:25:04 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Thu, 11 Jan 2024 10:25:03 +0800
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
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHNlbGZ0ZXN0cy9tb3ZlX21vdW50X3NldF9n?=
 =?utf-8?Q?roup:Make_tests_build_with_old_libc?=
Thread-Topic: [PATCH v2] selftests/move_mount_set_group:Make tests build with
 old libc
Thread-Index: AQHaQ5cFEyIWLbXjpU+9djDN1vXVNrDSzHOAgAEVTtA=
Date: Thu, 11 Jan 2024 02:25:03 +0000
Message-ID: <6c398076d4624691a97766bad168d975@h3c.com>
References: <20240110072901.5873-1-hu.yadi@h3c.com>
 <20240110.Yap9Aw9aeghu@digikod.net>
In-Reply-To: <20240110.Yap9Aw9aeghu@digikod.net>
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
X-MAIL:h3cspam02-ex.h3c.com 40B2P3Oi095226

DQo+T24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMDM6Mjk6MDFQTSArMDgwMCwgSHUgWWFkaSB3cm90
ZToNCj4+IEZyb206ICJIdS5ZYWRpIiA8aHUueWFkaUBoM2MuY29tPg0KPj4gDQo+PiBSZXBsYWNl
IFNZU188c3lzY2FsbD4gd2l0aCBfX05SXzxzeXNjYWxsPi4gIFVzaW5nIHRoZSBfX05SXzxzeXNj
YWxsPiANCj4+IG5vdGF0aW9uLCBwcm92aWRlZCBieSBVQVBJLCBpcyB1c2VmdWwgdG8gYnVpbGQg
dGVzdHMgb24gc3lzdGVtcyANCj4+IHdpdGhvdXQgdGhlIFNZU188c3lzY2FsbD4gZGVmaW5pdGlv
bnMuDQo+DQo+VGhpcyBsb29rcyBhIGxvdCBsaWtlIHRoYXQuLi4NCj5odHRwczovL2dpdC5rZXJu
ZWwub3JnL3N0YWJsZS9jLzg3MTI5ZWYxMzYwM2FlNDZjODJiY2QwOWVlZDk0OGFjZjA1MDZkYmIN
Cg0KWWVzLCBJIHBpY2tlZCB1cCBjb21tZW50cyBmcm9tIGFib3ZlIGNvbW1pdCBpbiBvcmRlciBm
b3IgY29uc2lzdGVudCwNCkkgd291bGQgc2VuZCB2MyBwYXRjaCBpZiBpdCBpcyBpbmFwcHJvcHJp
YXRlLiANCg0KPj4gDQo+PiBSZXBsYWNlIFNZU19tb3ZlX21vdW50IHdpdGggX19OUl9tb3ZlX21v
dW50DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEh1LllhZGkgPGh1LnlhZGlAaDNjLmNvbT4gU3Vn
Z2VzdGVkLWJ5OkppYW8gDQo+PiA8amlhb3h1cG9AaDNjLmNvbT4gUmV2aWV3ZWQtYnk6QmVybGlu
IDxiZXJsaW5AaDNjLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyB2MSAtPiB2MjoNCj4+ICAtIEZp
eCBtYWlsIG9mIFN1Z2dlc3RlZC1ieSBhbmQgUmV2aWV3ZWQtYnkNCj4+IA0KPj4gIC4uLi9tb3Zl
X21vdW50X3NldF9ncm91cC9tb3ZlX21vdW50X3NldF9ncm91cF90ZXN0LmMgICAgICAgICAgfCA0
ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IA0KPj4gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tb3Zl
X21vdW50X3NldF9ncm91cC9tb3ZlX21vdW50X3NldF9ncm91cF90ZQ0KPj4gc3QuYyANCj4+IGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW92ZV9tb3VudF9zZXRfZ3JvdXAvbW92ZV9tb3VudF9z
ZXRfZ3JvdXBfdGUNCj4+IHN0LmMgaW5kZXggNTBlZDVkNDc1ZGQxLi5iY2Y1MWQ3ODVhMzcgMTAw
NjQ0DQo+PiAtLS0gDQo+PiBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21vdmVfbW91bnRfc2V0
X2dyb3VwL21vdmVfbW91bnRfc2V0X2dyb3VwX3RlDQo+PiBzdC5jDQo+PiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tb3ZlX21vdW50X3NldF9ncm91cC9tb3ZlX21vdW50X3NldF9ncm91
DQo+PiArKysgcF90ZXN0LmMNCj4+IEBAIC0yMTgsNyArMjE4LDcgQEAgc3RhdGljIGJvb2wgbW92
ZV9tb3VudF9zZXRfZ3JvdXBfc3VwcG9ydGVkKHZvaWQpDQo+PiAgCWlmIChtb3VudChOVUxMLCBT
RVRfR1JPVVBfRlJPTSwgTlVMTCwgTVNfU0hBUkVELCAwKSkNCj4+ICAJCXJldHVybiAtMTsNCj4+
ICANCj4+IC0JcmV0ID0gc3lzY2FsbChTWVNfbW92ZV9tb3VudCwgQVRfRkRDV0QsIFNFVF9HUk9V
UF9GUk9NLA0KPj4gKwlyZXQgPSBzeXNjYWxsKF9fTlJfbW92ZV9tb3VudCwgQVRfRkRDV0QsIFNF
VF9HUk9VUF9GUk9NLA0KPj4gIAkJICAgICAgQVRfRkRDV0QsIFNFVF9HUk9VUF9UTywgTU9WRV9N
T1VOVF9TRVRfR1JPVVApOw0KPj4gIAl1bW91bnQyKCIvdG1wIiwgTU5UX0RFVEFDSCk7DQo+PiAg
DQo+PiBAQCAtMzYzLDcgKzM2Myw3IEBAIFRFU1RfRihtb3ZlX21vdW50X3NldF9ncm91cCwgY29t
cGxleF9zaGFyaW5nX2NvcHlpbmcpDQo+PiAgCQkgICAgICAgQ0xPTkVfVk0gfCBDTE9ORV9GSUxF
Uyk7IEFTU0VSVF9HVChwaWQsIDApOw0KPj4gIAlBU1NFUlRfRVEod2FpdF9mb3JfcGlkKHBpZCks
IDApOw0KPj4gIA0KPj4gLQlBU1NFUlRfRVEoc3lzY2FsbChTWVNfbW92ZV9tb3VudCwgY2FfZnJv
bS5tbnRmZCwgIiIsDQo+PiArCUFTU0VSVF9FUShzeXNjYWxsKF9fTlJfbW92ZV9tb3VudCwgY2Ff
ZnJvbS5tbnRmZCwgIiIsDQo+PiAgCQkJICBjYV90by5tbnRmZCwgIiIsIE1PVkVfTU9VTlRfU0VU
X0dST1VQDQo+PiAgCQkJICB8IE1PVkVfTU9VTlRfRl9FTVBUWV9QQVRIIHwgTU9WRV9NT1VOVF9U
X0VNUFRZX1BBVEgpLA0KPj4gIAkJICAwKTsNCj4+IC0tDQo+PiAyLjIzLjANCj4+ICANCg==

