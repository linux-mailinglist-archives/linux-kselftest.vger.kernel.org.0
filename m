Return-Path: <linux-kselftest+bounces-3441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1786839E75
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 02:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7DC289ABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADF15BE;
	Wed, 24 Jan 2024 01:55:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05A15BB
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061324; cv=none; b=DnZSTbt2knEhEUVxqjSD+eVodURLIKBAMP1XeWGTeWmEfW561DDqPVLB3NZGlMiDasZDBg8PCgEpNafQ1jw690RpNp2cJf6qQgBEO+VKXXFpbdNFvU9kifOc3rRHG+BUQDqVgIjjq8AUajMCUMmvqGFqLpTZ7HTAxtI7WVtIxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061324; c=relaxed/simple;
	bh=KzfL/eA5X9Q8Ecu3aHYbw/T9JAuqCN1j0cbZS03ao4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P4ipM6XIW+gI+yXP6+1Ye3Z6dbFSyM46faPiQn1jEUB8QXTboMA78F3JBr2DvUsiBSIZv0LJVrxuJjXE0+qXbgNsIbMIHt3AQs45GRMoTPxKOSxIrM8ApXqyAv0v0BIN5NiIVQNZVCpgZiKVqAC15JOLzfSwk7OZw3QQ4znYfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40O1sptq034324;
	Wed, 24 Jan 2024 09:54:51 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 2F6EB2004BC6;
	Wed, 24 Jan 2024 09:59:30 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 24 Jan 2024 09:54:52 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 24 Jan 2024 09:54:52 +0800
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
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NF0gc2VsZnRlc3RzL2xhbmRsb2Nr?=
 =?utf-8?Q?:Fix_two_build_issues?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9sYW5kbG9jazpGaXggdHdv?=
 =?utf-8?Q?_build_issues?=
Thread-Index: AQHaR51Te/ejhd6BskWKYK0XmAmChrDgkaUAgAbFurD//7YlAIABM8jQ
Date: Wed, 24 Jan 2024 01:54:52 +0000
Message-ID: <381b0dd202074938b527c5b27c86c34f@h3c.com>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
 <20240119.Ugaehae2ze5b@digikod.net>
 <adec399e50c74b30b59480d92c431241@h3c.com>
 <20240123.deeT9hegh4vo@digikod.net>
In-Reply-To: <20240123.deeT9hegh4vo@digikod.net>
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
X-MAIL:h3cspam02-ex.h3c.com 40O1sptq034324

DQo+T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMTI6MDQ6MTdQTSArMDAwMCwgSHV5YWRpIHdyb3Rl
Og0KPj4gDQo+PiA+PiBDaGFuZ2VzIHYzIC0+IHYyOg0KPj4gPj4gIC0gYWRkIGhlbHBlciBvZiBn
ZXR0aWQgaW5zdGVhZCBvZiBfX05SX2dldHRpZA0KPj4gPj4gIC0gYWRkIGdjYy9nbGliYyB2ZXJz
aW9uIGluZm8gaW4gY29tbWVudHMgQ2hhbmdlcyB2MSAtPiB2MjoNCj4+ID4+ICAtIGZpeCB3aGl0
ZXNwYWNlIGVycm9yDQo+PiA+PiAgLSByZXBsYWNlIFNZU19nZXR0aWQgd2l0aCBfTlJfZ2V0dGlk
DQo+PiA+PiANCj4+ID4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0
LmMgIHwgNSArKysrLSANCj4+ID4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xhbmRsb2NrL25l
dF90ZXN0LmMgfCA3ICsrKysrKy0NCj4+ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiA+PiANCj4+ID4+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMNCj4+ID4+IGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+PiA+PiBpbmRleCAxOGUxZjg2YTYyMzQu
LmE5OTJjZjdjMGFkMSAxMDA2NDQNCj4+ID4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2xhbmRsb2NrL2ZzX3Rlc3QuYw0KPj4gPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bGFuZGxvY2svZnNfdGVzdC5jDQo+PiA+PiBAQCAtNDU3Miw3ICs0NTcyLDEwIEBAIEZJWFRVUkVf
VkFSSUFOVChsYXlvdXQzX2ZzKQ0KPj4gPj4gIC8qIGNsYW5nLWZvcm1hdCBvZmYgKi8NCj4+ID4+
ICBGSVhUVVJFX1ZBUklBTlRfQUREKGxheW91dDNfZnMsIHRtcGZzKSB7DQo+PiA+PiAgCS8qIGNs
YW5nLWZvcm1hdCBvbiAqLw0KPj4gPj4gLQkubW50ID0gbW50X3RtcCwNCj4+ID4+ICsJLm1udCA9
IHsNCj4+ID4+ICsJCS50eXBlID0gInRtcGZzIiwNCj4+ID4+ICsJCS5kYXRhID0gInNpemU9NG0s
bW9kZT03MDAiLA0KPj4gPj4gKwl9LA0KPj4gPg0KPj4gPkkgcmVxdWVzdGVkIHNvbWUgY2hhbmdl
cyBoZXJlLg0KPj4gPg0KPj4gDQo+PiBDb3VsZCB5b3UgZ2l2ZSBtZSBzb21lIGluc3BpcmF0aW9u
IGhvdyB0byBmaXggaXQ/IA0KPj4gaXQgbG9va3MgZmluZSB0byBtZSB0byBhc3NpZ24gdmFsdWUg
YXMgYWJvdmUsIHdoaWNoIGNvbnNpc3RlbnQgd2l0aCBvdGhlciBwc2V1ZG8gRlMgdGVzdHMuDQo+
PiBUaGFua3MgaW4gYWR2YW5jZS4NCj4NCj5KdXN0IGFkZCBhbmQgdXNlIHRoaXMgZm9yIHRoZSB0
d28gdG1wZnMgZGF0YToNCj4jZGVmaW5lIE1OVF9UTVBfREFUQSAic2l6ZT00bSxtb2RlPTcwMCIN
Cj4NCj5Zb3UgY2FuIGFsc28gbWFrZSB0aGUgbW50X3RtcCB2YXJpYWJsZSBzdGF0aWMgY29uc3Qu
DQoNCg0Kc3RhdGljIGNvbnN0IGlzIG5vdCB1c2VmdWwgZm9yIHRoZSBjYXNlLCB0aGUgZXJyb3Qg
c3RpbGwsIGFuZCBJJ2xsIHVzZSBtYWNybyBkZWZpbml0aW9uIHRvIHNvbHZlIGl0Lg0KdGhhbmtz
IHlvdXIgd2FybWx5IGluc3RydWN0aW9uLEknbGwgc2VuZCBuZXh0IHZlcnNpb24gLCBwbGVhc2Ug
aGVscCB0byByZXZpZXcgaXQuDQoNCg0KPiANCj4gPj4gIAkuZmlsZV9wYXRoID0gZmlsZTFfczFk
MSwNCj4gPj4gIH07DQo+ID4+IA0KPiAgICANCg==

