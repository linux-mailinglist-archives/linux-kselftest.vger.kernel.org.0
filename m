Return-Path: <linux-kselftest+bounces-2888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917682BAD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 06:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC621C23105
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6E5B20C;
	Fri, 12 Jan 2024 05:25:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315735B5C2
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40C5OW5L068788;
	Fri, 12 Jan 2024 13:24:32 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX05-IMDC.srv.huawei-3com.com (unknown [10.62.14.14])
	by mail.maildlp.com (Postfix) with ESMTP id CAE0720081B9;
	Fri, 12 Jan 2024 13:28:54 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX05-IMDC.srv.huawei-3com.com (10.62.14.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 12 Jan 2024 13:24:33 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 12 Jan 2024 13:24:33 +0800
From: Huyadi <hu.yadi@h3c.com>
To: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "mic@digikod.net" <mic@digikod.net>
CC: "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHNlbGZ0ZXN0cy9jb3JlOiBGaXggYnVpbGQgaXNz?=
 =?utf-8?B?dWUgd2l0aCBDTE9TRV9SQU5HRV9VTlNIQVJF?=
Thread-Topic: [PATCH] selftests/core: Fix build issue with CLOSE_RANGE_UNSHARE
Thread-Index: AQHaREFKmm7LKypC3ku5ZfvLUDPhobDVpjEw
Date: Fri, 12 Jan 2024 05:24:33 +0000
Message-ID: <721bdbfd706645379b6164199aa31165@h3c.com>
References: <20240111034747.39746-1-hu.yadi@h3c.com>
In-Reply-To: <20240111034747.39746-1-hu.yadi@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 40C5OW5L068788

QW55IGNvbW1lbnRzIHdpbGwgYmUgYXBwcmVjaWF0ZWQNCg0KPkZyb206ICJIdS5ZYWRpIiA8aHUu
eWFkaUBoM2MuY29tPg0KPg0KPkFkZCBoZWFkIGZpbGUgdG8gZml4IGNwbXBpbGUgZXJyb3I6DQo+
DQo+Z2NjIC1nIC1pc3lzdGVtIC9ob21lL2xpbnV4L3Vzci9pbmNsdWRlICAgICBjbG9zZV9yYW5n
ZV90ZXN0LmMgIC1vIC9ob21lL2xpbnV4L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUvY2xv
c2VfcmFuZ2VfdGVzdA0KPmNsb3NlX3JhbmdlX3Rlc3QuYzogSW4gZnVuY3Rpb24g4oCYY2xvc2Vf
cmFuZ2VfdW5zaGFyZeKAmToNCj5jbG9zZV9yYW5nZV90ZXN0LmM6MTExOjExOiBlcnJvcjog4oCY
Q0xPU0VfUkFOR0VfVU5TSEFSReKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5j
dGlvbik7IGRpZCB5b3UgbWVhbiDigJhDTE9ORV9ORVdVU0VS4oCZPw0KPiAgICAgICAgICAgQ0xP
U0VfUkFOR0VfVU5TSEFSRSk7DQo+ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+DQoN
Cj5TaWduZWQtb2ZmLWJ5OiBIdS5ZYWRpIDxodS55YWRpQGgzYy5jb20+DQo+U3VnZ2VzdGVkLWJ5
OiBKaWFvIDxqaWFveHVwb0BoM2MuY29tPg0KPlJldmlld2VkLWJ5OiBCZXJsaW4gPGJlcmxpbkBo
M2MuY29tPg0KPi0tLQ0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb3JlL2Nsb3NlX3Jhbmdl
X3Rlc3QuYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUvY2xv
c2VfcmFuZ2VfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29yZS9jbG9zZV9yYW5n
ZV90ZXN0LmMNCj5pbmRleCA1MzQ1NzZmMDZkZjEuLjU2M2JjMWU1NTkzNyAxMDA2NDQNCj4tLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb3JlL2Nsb3NlX3JhbmdlX3Rlc3QuYw0KPisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NvcmUvY2xvc2VfcmFuZ2VfdGVzdC5jDQo+QEAgLTEy
LDcgKzEyLDcgQEANCj4gI2luY2x1ZGUgPHN5c2NhbGwuaD4NCj4gI2luY2x1ZGUgPHVuaXN0ZC5o
Pg0KPiAjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+DQo+LQ0KPisjaW5jbHVkZSA8bGludXgvY2xv
c2VfcmFuZ2UuaD4NCj4gI2luY2x1ZGUgIi4uL2tzZWxmdGVzdF9oYXJuZXNzLmgiDQo+ICNpbmNs
dWRlICIuLi9jbG9uZTMvY2xvbmUzX3NlbGZ0ZXN0cy5oIg0KPiANCj4tLSANCj4yLjIzLjANCg==

