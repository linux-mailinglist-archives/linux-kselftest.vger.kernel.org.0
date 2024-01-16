Return-Path: <linux-kselftest+bounces-3057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CA82E81A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 04:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BD41C22987
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB426FB6;
	Tue, 16 Jan 2024 03:15:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA56FB2
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40G3FFeF057282;
	Tue, 16 Jan 2024 11:15:15 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX10-BJD.srv.huawei-3com.com (unknown [10.153.34.12])
	by mail.maildlp.com (Postfix) with ESMTP id 021222004BB6;
	Tue, 16 Jan 2024 11:19:43 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX10-BJD.srv.huawei-3com.com (10.153.34.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 16 Jan 2024 11:15:16 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Tue, 16 Jan 2024 11:15:16 +0800
From: Huyadi <hu.yadi@h3c.com>
To: =?utf-8?B?J0fDvG50aGVyIE5vYWNrJw==?= <gnoack@google.com>
CC: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "amir73il@gmail.com"
	<amir73il@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "avagin@google.com" <avagin@google.com>,
        "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHNlbGZ0ZXN0cy9maWxlc3lzdGVtczpmaXggYnVp?=
 =?utf-8?Q?ld_error_in_overlayfs?=
Thread-Topic: [PATCH] selftests/filesystems:fix build error in overlayfs
Thread-Index: AQHaRSsZ3C6Kdahh1UyDYHPgqAANTbDabSyAgAFbR1A=
Date: Tue, 16 Jan 2024 03:15:15 +0000
Message-ID: <f25be6663bcc4608adf630509f045a76@h3c.com>
References: <20240112074059.29673-1-hu.yadi@h3c.com>
 <ZaVAjQmio26WloSk@google.com>
In-Reply-To: <ZaVAjQmio26WloSk@google.com>
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
X-MAIL:h3cspam02-ex.h3c.com 40G3FFeF057282

DQoNCg0KPk9uIEZyaSwgSmFuIDEyLCAyMDI0IGF0IDAzOjQwOjU5UE0gKzA4MDAsIEh1IFlhZGkg
d3JvdGU6DQo+PiBPbmUgYnVpbGQgaXNzdWUgY29tZXMgdXAgZHVlIHRvIGJvdGggbW91bnQuaCBp
bmNsdWRlZCBkZXZfaW5fbWFwcy5jDQo+PiANCj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkZXZf
aW5fbWFwcy5jOjEwOg0KPj4gL3Vzci9pbmNsdWRlL3N5cy9tb3VudC5oOjM1OjM6IGVycm9yOiBl
eHBlY3RlZCBpZGVudGlmaWVyIGJlZm9yZSBudW1lcmljIGNvbnN0YW50DQo+PiAgICAzNSB8ICAg
TVNfUkRPTkxZID0gMSwgIC8qIE1vdW50IHJlYWQtb25seS4gICovDQo+PiAgICAgICB8ICAgXn5+
fn5+fn5+DQo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZGV2X2luX21hcHMuYzoxMzoNCj4+IA0K
Pj4gUmVtb3ZlIG9uZSBvZiB0aGVtIHRvIHNvbHZlIGNvbmZsaWN0LCBhbm90aGVyIGVycm9yIGNv
bWVzIHVwOg0KPj4gDQo+PiBkZXZfaW5fbWFwcy5jOjE3MDo2OiBlcnJvcjogaW1wbGljaXQgZGVj
bGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYbW91bnTigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dDQo+PiAgIDE3MCB8ICBpZiAobW91bnQoTlVMTCwgIi8iLCBOVUxMLCBN
U19TTEFWRSB8IE1TX1JFQywgTlVMTCkgPT0gLTEpIHsNCj4+ICAgICAgIHwgICAgICBefn5+fg0K
Pj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4+IA0KPj4gYW5k
IHRoZW4gLCBhZGQgc3lzX21vdW50IGRlZmluaXRpb24gdG8gc29sdmUgaXQgQWZ0ZXIgYm90aCBh
Ym92ZSwgDQo+PiBkZXZfaW5fbWFwcy5jIGNhbiBiZSBidWlsdCBjb3JyZWN0bHkgb24gbXkgbWFj
aGUoZ2NjIA0KPj4gMTAuMixnbGliYy0yLjMyLGtlcm5lbC01LjEwKQ0KPg0KPlRoaXMgaXMgYXBw
YXJlbnRseSB0aGUgc2FtZSBlcnJvciBhcyBpbg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8xMWNkYWMxZS1lOTZjLTQwNWYtNjNlOC0zNWIwZTI5MjYzMzdAYXJtLmNvbS8NCj4NCj5JJ20g
Z2V0dGluZyB0aGUgaW1wcmVzc2lvbiB0aGF0IHdlIGFyZSBmaXhpbmcgdGhlIGlzc3VlIGF0IHRo
ZSB3cm9uZyBsYXllciBoZXJlPw0KPkFmdGVyIGFsbCwgdGhlIG1vdW50KCkgc3lzY2FsbCBpcyBz
dXBwb3NlZCB0byBiZSB1c2VkIHdpdGggPHN5cy9tb3VudC5oPiBhY2NvcmRpbmcgdG8gdGhlIG1v
dW50KDIpIG1hbiBwYWdlPyAgSXQgZmVlbHMgYSBiaXQgbGlrZSBjaGVhdGluZyB0byByZXNvcnQg
dG8NCj5zeXNfbW91bnQoKSBpbnN0ZWFkLi4uPw0KDQpIZWFkZXJzIGNvbmZsaWN0IGlzIGtub3du
IGlzc3VlIGR1ZSB0byBodHRwczovL3NvdXJjZXdhcmUub3JnL2dsaWJjL3dpa2kvU3luY2hyb25p
emluZ19IZWFkZXJzDQo8bGludXgvbW91bnQuaD4gYW5kIDxzeXMvbW91bnQuaD4gKE5vdGU6IG5v
IHdvcmthcm91bmQpDQpTbywgaXQgaXMgaW5jb3JyZWN0IHRvIHVzZSBib3RoIHRoZW0uDQoNCj4N
Cj5EbyB5b3UgaGF2ZSBhbnkgZGVlcGVyIHRob3VnaHRzIG9uIHdoYXQgY291bGQgYmUgdGhlIHVu
ZGVybHlpbmcgaXNzdWUgaGVyZT8NCj5XaXRoIG15IG5ld2VyIEdDQyB0b29sY2hhaW5zLCBJIGhh
dmUgYmVlbiB1bmFibGUgdG8gcmVwcm9kdWNlIHRoaXMuDQo+DQpnY2MgdmVyc2lvbiAxMC4yLjEg
MjAyMDA4MjUgKEFsaWJhYmEgMTAuMi4xLTMuNSAyLjMyKSAoR0NDKQ0KbGRkIChHTlUgbGliYykg
Mi4zMg0Ka2VybmVsIDUuMTAuMTM0LTE2LjEuYWw4Lng4Nl82NA0KIkFsaWJhYmEgQ2xvdWQgTGlu
dXggMyh0aGUgbW9zdCBiaWdnZXN0IHB1YmxpYyBjbG91ZCBwcm92aWRlcidzIE9TKQ0KDQoNCj5U
aGFua3MsDQoNCg==

