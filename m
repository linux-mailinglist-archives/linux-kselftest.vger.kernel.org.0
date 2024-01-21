Return-Path: <linux-kselftest+bounces-3281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B704183555D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 12:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A951C20A28
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jan 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8583613E;
	Sun, 21 Jan 2024 11:02:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856914F78
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Jan 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705834956; cv=none; b=bWrHM3et5BUDxSwZu6+RRcmeXu3jRhJxH4ro5oyLUyK0R9VGiXDlyCKQUDilAyuuwyM1dhQxo+G5sYhJeB99wwt1vSDWsRvyako7Ad3x4GuiQkrHpB3e6k0zhbwCFeA+cy7BiKSf7+cxoDrAMKQQvWbblAMrobjJZyYv80Ej+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705834956; c=relaxed/simple;
	bh=bwH0/B8eYrOSIj4xed+TVE18YuK3niXz1ojq9e0EIcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2Po2p/oS5pSUdvYoZr9R2KTT7OxpVOzISuPa9JTGpWYS4OVTpyMLnlbOHZOwQnY4tCT9PVhV9iKM+uZaRDQleBc29Ka4r1lRcrF5MTdHwJhHRFv2s22A48u/OGJ60bOHH6gid5DBp7bi1YBIn4Aw2BJ2IIWNAz5+KXo47G1zKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40LB27dr021839;
	Sun, 21 Jan 2024 19:02:07 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX12-BJD.srv.huawei-3com.com (unknown [10.153.34.14])
	by mail.maildlp.com (Postfix) with ESMTP id 605412004BA4;
	Sun, 21 Jan 2024 19:06:44 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX12-BJD.srv.huawei-3com.com (10.153.34.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Sun, 21 Jan 2024 19:02:09 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Sun, 21 Jan 2024 19:02:09 +0800
From: Huyadi <hu.yadi@h3c.com>
To: =?utf-8?B?J01pY2thw6tsIFNhbGHDvG4n?= <mic@digikod.net>
CC: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "avagin@google.com" <avagin@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>,
        "konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9sYW5kbG9jazpGaXggdHdv?=
 =?utf-8?Q?_build_issues?=
Thread-Topic: [PATCH v4] selftests/landlock:Fix two build issues
Thread-Index: AQHaR51Te/ejhd6BskWKYK0XmAmChrDgkaUAgAOROrA=
Date: Sun, 21 Jan 2024 11:02:09 +0000
Message-ID: <798652cb83554c1e8674cc98f45393ed@h3c.com>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
 <20240119.Ugaehae2ze5b@digikod.net>
In-Reply-To: <20240119.Ugaehae2ze5b@digikod.net>
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
X-MAIL:h3cspam02-ex.h3c.com 40LB27dr021839

PiBPbiBNb24sIEphbiAxNSwgMjAyNCBhdCAwNjoyNDowOVBNICswODAwLCBIdSBZYWRpIHdyb3Rl
Og0KPj4gIEZyb206ICJIdS5ZYWRpIiA8aHUueWFkaUBoM2MuY29tPg0KPj4gDQo+PiBUd28gaXNz
dWVzIGNvbWVzIHVwIHdoaWxlIGJ1aWxkaW5nIHNlbGZ0ZXN0L2xhbmRsb2NrIG9uIG15IHNpZGUg
KGdjYyANCj4+IDcuMy9nbGliYy0yLjI4L2tlcm5lbC00LjE5KQ0KPj4gDQo+PiB0aGUgZmlyc3Qg
b25lIGlzIGFzIHRvIGdldHRpZA0KPj4gDQo+PiBuZXRfdGVzdC5jOiBJbiBmdW5jdGlvbiDigJhz
ZXRfc2VydmljZeKAmToNCj4+IG5ldF90ZXN0LmM6OTE6NDU6IHdhcm5pbmc6IGltcGxpY2l0IGRl
Y2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGdldHRpZOKAmTsgWy1XaW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dDQo+PiAgICAgIl9zZWxmdGVzdHMtbGFuZGxvY2stbmV0LXRpZCVkLWluZGV4
JWQiLCBnZXR0aWQoKSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ2V0Z2lkDQo+PiBuZXRfdGVzdC5jOigudGV4dCsweDRlMCk6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8gYGdldHRpZCcNCj4+IA0KPj4gdGhlIHNlY29uZCBpcyBjb21waWxlciBlcnJvcg0K
Pj4gZ2NjIC1XYWxsIC1PMiAtaXN5c3RlbSAgIGZzX3Rlc3QuYyAtbGNhcCAtbyBzZWxmdGVzdHMv
bGFuZGxvY2svZnNfdGVzdA0KPj4gZnNfdGVzdC5jOjQ1NzU6OTogZXJyb3I6IGluaXRpYWxpemVy
IGVsZW1lbnQgaXMgbm90IGNvbnN0YW50DQo+PiAgIC5tbnQgPSBtbnRfdG1wLA0KPj4gICAgICAg
ICAgXn5+fn5+fg0KPj4gDQo+PiBGaXhlczogMDRmOTA3MGU5OWE0ICgic2VsZnRlc3RzL2xhbmRs
b2NrOiBBZGQgdGVzdHMgZm9yIHBzZXVkbyANCj4+IGZpbGVzeXN0ZW1zIikNCj4+IEZpeGVzOiBh
NTQ5ZDA1NWEyMmUgKCJzZWxmdGVzdHMvbGFuZGxvY2s6IEFkZCBuZXR3b3JrIHRlc3RzIikNCj4N
Cj5Db3VsZCB5b3UgcGxlYXNlIGNyZWF0ZSB0d28gcGF0Y2hlcyBhcyByZXF1ZXN0ZWQgZm9yIHYz
LCBvbmUgcGVyIGZpeD8NCj5UaGlzIGlzIHVzZWZ1bCBiZWNhdXNlIGl0IGVuYWJsZXMgdG8gYmFj
a3BvcnQgdGhlc2UgZml4ZXMgd2hlbiBhcHByb3ByaWF0ZS4NCg0KT0ssIEknbGwgcmVzZW5kIGl0
IGJ5IHR3byBwYXRjaGVzIHdpdGggeW91ciB3YXJtbHkgaW5zdHJ1Y3Rpb24uDQpUaGFua3MgYWdh
aW4uDQoNCj4+IA0KPj4gdGhpcyBwYXRjaCBpcyB0byBmaXggdGhlbQ0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBIdS5ZYWRpIDxodS55YWRpQGgzYy5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEppYW8g
PGppYW94dXBvQGgzYy5jb20+DQo+PiBSZXZpZXdlZC1ieTogQmVybGluIDxiZXJsaW5AaDNjLmNv
bT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyB2NCAtPiB2MzoNCj4+ICAgZml4IGdldHRpZCBlcnJvciBm
cm9tIGtlcm5lbCB0ZXN0IHJvYm90DQo+PiAgIA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2Uta2J1aWxkLWFsbC8yMDI0MDExNTExNDcuVDFzMTFpSEotbGtwQGludGVsLg0KPj4gY29tLw0K
Pj4gQ2hhbmdlcyB2MyAtPiB2MjoNCj4+ICAtIGFkZCBoZWxwZXIgb2YgZ2V0dGlkIGluc3RlYWQg
b2YgX19OUl9nZXR0aWQNCj4+ICAtIGFkZCBnY2MvZ2xpYmMgdmVyc2lvbiBpbmZvIGluIGNvbW1l
bnRzIENoYW5nZXMgdjEgLT4gdjI6DQo+PiAgLSBmaXggd2hpdGVzcGFjZSBlcnJvcg0KPj4gIC0g
cmVwbGFjZSBTWVNfZ2V0dGlkIHdpdGggX05SX2dldHRpZA0KPj4gDQo+PiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jICB8IDUgKysrKy0gIA0KPj4gdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvbGFuZGxvY2svbmV0X3Rlc3QuYyB8IDcgKysrKysrLQ0KPj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYyANCj4+
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+PiBpbmRleCAx
OGUxZjg2YTYyMzQuLmE5OTJjZjdjMGFkMSAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xhbmRsb2NrL2ZzX3Rlc3QuYw0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+PiBAQCAtNDU3Miw3ICs0NTcyLDEwIEBAIEZJWFRV
UkVfVkFSSUFOVChsYXlvdXQzX2ZzKQ0KPj4gIC8qIGNsYW5nLWZvcm1hdCBvZmYgKi8NCj4+ICBG
SVhUVVJFX1ZBUklBTlRfQUREKGxheW91dDNfZnMsIHRtcGZzKSB7DQo+PiAgCS8qIGNsYW5nLWZv
cm1hdCBvbiAqLw0KPj4gLQkubW50ID0gbW50X3RtcCwNCj4+ICsJLm1udCA9IHsNCj4+ICsJCS50
eXBlID0gInRtcGZzIiwNCj4+ICsJCS5kYXRhID0gInNpemU9NG0sbW9kZT03MDAiLA0KPj4gKwl9
LA0KPg0KPkkgcmVxdWVzdGVkIHNvbWUgY2hhbmdlcyBoZXJlLg0KPg0KPj4gIAkuZmlsZV9wYXRo
ID0gZmlsZTFfczFkMSwNCj4+ICB9Ow0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGFuZGxvY2svbmV0X3Rlc3QuYyANCj4+IGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbGFuZGxvY2svbmV0X3Rlc3QuYw0KPj4gaW5kZXggOTI5ZTIxYzRkYjA1Li5kNTBmMjky
MGVkODIgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9u
ZXRfdGVzdC5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9uZXRf
dGVzdC5jDQo+IEBAIC0yMSw2ICsyMSwxMSBAQA0KPg0KPldlIHNob3VsZCBpbmNsdWRlIHN5cy9z
eXNjYWxsLmgNCj4NCj4+IA0KPj4gICNpbmNsdWRlICJjb21tb24uaCINCj4+IA0KPj4gK3N0YXRp
YyBwaWRfdCBsYW5kbG9ja19nZXR0aWQodm9pZCkNCj4NCj5QbGVhc2UgcmVuYW1lIHRvIHN5c19n
ZXR0aWQoKS4NCj4NCj4+ICt7DQo+PiArICAgICAgICByZXR1cm4gc3lzY2FsbChfX05SX2dldHRp
ZCk7DQo+PiArfQ0KPj4gKw0KPj4gIGNvbnN0IHNob3J0IHNvY2tfcG9ydF9zdGFydCA9ICgxIDw8
IDEwKTsNCj4+IA0KPj4gIHN0YXRpYyBjb25zdCBjaGFyIGxvb3BiYWNrX2lwdjRbXSA9ICIxMjcu
MC4wLjEiOyBAQCAtODgsNyArOTMsNyBAQCANCj4+IHN0YXRpYyBpbnQgc2V0X3NlcnZpY2Uoc3Ry
dWN0IHNlcnZpY2VfZml4dHVyZSAqY29uc3Qgc3J2LA0KPj4gIAljYXNlIEFGX1VOSVg6DQo+PiAg
CQlzcnYtPnVuaXhfYWRkci5zdW5fZmFtaWx5ID0gcHJvdC5kb21haW47DQo+PiAgCQlzcHJpbnRm
KHNydi0+dW5peF9hZGRyLnN1bl9wYXRoLA0KPj4gLQkJCSJfc2VsZnRlc3RzLWxhbmRsb2NrLW5l
dC10aWQlZC1pbmRleCVkIiwgZ2V0dGlkKCksDQo+PiArCQkJIl9zZWxmdGVzdHMtbGFuZGxvY2st
bmV0LXRpZCVkLWluZGV4JWQiLCBsYW5kbG9ja19nZXR0aWQoKSwNCj4+ICAJCQlpbmRleCk7DQo+
PiAgCQlzcnYtPnVuaXhfYWRkcl9sZW4gPSBTVU5fTEVOKCZzcnYtPnVuaXhfYWRkcik7DQo+PiAg
CQlzcnYtPnVuaXhfYWRkci5zdW5fcGF0aFswXSA9ICdcMCc7DQo+PiAtLQ0KPj4gMi4yMy4wDQo+
Pg0K

