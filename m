Return-Path: <linux-kselftest+bounces-18344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF79857F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F10A2859AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295315CD46;
	Wed, 25 Sep 2024 11:27:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19B6FDC
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263662; cv=none; b=o8IeZjKh33E/oq6VPW060sGm1MDN90dup46MK3B6Fg51DteHmKenCY3vslqLPYjwAsRVjODElQtb7GhLN8mBQdrncJnKTWXGYj8BCpQIQ4cyD1Wv5ExjocAm6F0GcIQP3ld7VYYCbIVqd9Ouwav97uVn6dWWx17EitG3kowtLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263662; c=relaxed/simple;
	bh=nlwY4nKqkWCXyO3T2vmHu68hC7HddzgTamRajvxJbjk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pES0ueFJE3xNVRsqYqi1P0ZSeFvL7H5DzyS7EJo9nec3ltkh1miErYKkz05/OgaG+VXz+ci+hTodD9YcGaM3iWsfRM2a+OZwVYxNMq231sZ8w+yhBXgTynUv6rtSH/HQtJkK28Wk5wk3AItA51Twpwi10koiMQjMTT/JxxJLuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-201-7-hegE0WNKa5nIuQIrIH7w-1; Wed, 25 Sep 2024 12:27:30 +0100
X-MC-Unique: 7-hegE0WNKa5nIuQIrIH7w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 25 Sep
 2024 12:26:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 25 Sep 2024 12:26:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vinicius Peixoto' <vpeixoto@lkcamp.dev>, Brendan Higgins
	<brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "kunit-dev@googlegroups.com"
	<kunit-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>
Subject: RE: [PATCH 0/1] Add KUnit tests for lib/crc16.c
Thread-Topic: [PATCH 0/1] Add KUnit tests for lib/crc16.c
Thread-Index: AQHbDUbburejGRqRfUyI9R5kM3ntM7JoXa8Q
Date: Wed, 25 Sep 2024 11:26:43 +0000
Message-ID: <51c4ba25f9284a749b451ca203fcc124@AcuMS.aculab.com>
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
In-Reply-To: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVmluaWNpdXMgUGVpeG90bw0KPiBTZW50OiAyMyBTZXB0ZW1iZXIgMjAyNCAwMDoyNw0K
PiANCj4gSGkgYWxsLA0KPiANCj4gVGhpcyBwYXRjaCB3YXMgZGV2ZWxvcGVkIGR1cmluZyBhIGhh
Y2thdGhvbiBvcmdhbml6ZWQgYnkgTEtDQU1QIFsxXSwNCj4gd2l0aCB0aGUgb2JqZWN0aXZlIG9m
IHdyaXRpbmcgS1VuaXQgdGVzdHMsIGJvdGggdG8gaW50cm9kdWNlIHBlb3BsZSB0bw0KPiB0aGUg
a2VybmVsIGRldmVsb3BtZW50IHByb2Nlc3MgYW5kIHRvIGxlYXJuIGFib3V0IGRpZmZlcmVudCBz
dWJzeXN0ZW1zDQo+ICh3aXRoIHRoZSBwb3NpdGl2ZSBzaWRlIGVmZmVjdCBvZiBpbXByb3Zpbmcg
dGhlIGtlcm5lbCB0ZXN0IGNvdmVyYWdlLCBvZg0KPiBjb3Vyc2UpLg0KPiANCj4gV2Ugbm90aWNl
ZCB0aGVyZSB3ZXJlIHRlc3RzIGZvciBDUkMzMiBpbiBsaWIvY3JjMzJ0ZXN0LmMgYW5kIHRob3Vn
aHQgaXQNCj4gd291bGQgYmUgbmljZSB0byBoYXZlIHNvbWV0aGluZyBzaW1pbGFyIGZvciBDUkMx
Niwgc2luY2UgaXQgc2VlbXMgdG8gYmUNCj4gd2lkZWx5IHVzZWQgaW4gbmV0d29yayBkcml2ZXJz
IChhcyB3ZWxsIGFzIGluIHNvbWUgZXh0NCBjb2RlKS4NCj4gDQo+IEFsdGhvdWdoIHRoaXMgcGF0
Y2ggdHVybmVkIG91dCBxdWl0ZSBiaWcsIG1vc3Qgb2YgdGhlIExPQ3MgY29tZSBmcm9tDQo+IHRh
YmxlcyBjb250YWluaW5nIHJhbmRvbWx5LWdlbmVyYXRlZCB0ZXN0IGRhdGEgdGhhdCB3ZSB1c2Ug
dG8gdmFsaWRhdGUNCj4gdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uIG9mIENSQy0xNi4NCj4g
DQo+IFdlIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIGFueSBmZWVkYmFjay9zdWdnZXN0aW9ucyBv
biBob3cgdG8gaW1wcm92ZQ0KPiB0aGlzLiBUaGFua3MhIDotKQ0KDQpXb3VsZCBpcyBiZSBiZXR0
ZXIgdG8gdXNlIGEgdHJpdmlhbCBQUk5HIHRvIGdlbmVyYXRlIHJlcGVhdGFibGUgJ3JhbmRvbSBl
bm91Z2gnDQpkYXRhLCByYXRoZXIgdGhhbiBoYXZpbmcgYSBsYXJnZSBzdGF0aWMgYXJyYXk/DQoN
CkFzIGEgbWF0dGVyIG9mIGludGVyZXN0LCBob3cgaW4gY3JjMTYgaW1wbGVtZW50ZWQgKEkga25v
dyBJIGNvdWxkIGxvb2spLg0KVGhlIGNvZGUgdmVyc2lvbjoNCg0KdWludDMyX3QNCmNyY19zdGVw
KHVpbnQzMl90IGNyYywgdWludDMyX3QgYnl0ZV92YWwpDQp7DQogICAgdWludDMyX3QgdCA9IGNy
YyBeIChieXRlX3ZhbCAmIDB4ZmYpOw0KICAgIHQgPSAodCBeIHQgPDwgNCkgJiAweGZmOw0KICAg
IHJldHVybiBjcmMgPj4gOCBeIHQgPDwgOCBeIHQgPDwgMyBeIHQgPj4gNDsNCn0NCg0KbWF5IHdl
bGwgYmUgZmFzdGVyIHRoYW4gYSBsb29rdXAgdGFibGUgdmVyc2lvbi4NCkVzcGVjaWFsbHkgb24g
bW9kZXJuIG11bHRpLWlzc3VlIGNwdSBhbmQvb3IgZm9yIHNtYWxsIGJ1ZmZlcnMgd2hlcmUgdGhl
IGxvb2t1cA0KdGFibGUgd29uJ3QgbmVjZXNzYXJpbHkgYmUgcmVzaWRlbnQgaW4gdGhlIEQtY2Fj
aGUuDQoNCkl0IGlzIHNsaWdodGx5IHNsb3dlciB0aGFuIHRoZSB0YWJsZSBsb29rdXAgb24gdGhl
IHNpbXBsZSBOaW9zLUlJIGNwdS4NCkJ1dCB3ZSB1c2UgYSBjdXN0b20gaW5zdHJ1Y3Rpb24gdG8g
ZG8gaXQgaW4gb25lIGNsb2NrLg0KDQoJRGF2aWQNCg0KPiANCj4gVmluaWNpdXMgUGVpeG90byAo
MSk6DQo+ICAgbGliL2NyYzE2X2t1bml0LmM6IGFkZCBLVW5pdCB0ZXN0cyBmb3IgY3JjMTYNCj4g
DQo+ICBsaWIvS2NvbmZpZy5kZWJ1ZyB8ICAgOCArDQo+ICBsaWIvTWFrZWZpbGUgICAgICB8ICAg
MSArDQo+ICBsaWIvY3JjMTZfa3VuaXQuYyB8IDcxNSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcyNCBpbnNlcnRpb25z
KCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL2NyYzE2X2t1bml0LmMNCj4gDQo+IC0tDQo+
IDIuNDMuMA0KPiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K


