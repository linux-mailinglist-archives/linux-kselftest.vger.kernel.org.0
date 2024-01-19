Return-Path: <linux-kselftest+bounces-3223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA935832381
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 03:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849A12866F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671F1391;
	Fri, 19 Jan 2024 02:58:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170B138F
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633113; cv=none; b=iMdyBUa7R6yGtEVcVJBZYMp/wo/JCbX8pwjHuX9lS+12dHKkLHXdmu7k0zZCRsa/NLTHXhAmdSe0w0kJsAjHU0w2zg/mwApUJyeLYBL4GH0k3MYJe6suZOIfhbd5+MEIRuAi7Wk3pITm6ploukeg8Kb+7mbebCovy4tPyl3eZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633113; c=relaxed/simple;
	bh=wTuOtLp0K3RgyC3KOzCWVfI7I4OOv/HcKRoWWEzway0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDj80h8BnTzKJNR6Pjr++J6H9JM27yqrVenUU24BucOM2UIUrA+ZfCVhfDs/HWu2sZpmjfOcp6c5B4Ssz/lWkg5bhSl+YF3ph4FHPgm6EDF9GzEMNz0l7dlk1adQ4TJ75rUK9OLrR4+muy1L1wOrA3sArfAZ0fVw1PUJyIH23Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40J2vhvT092086;
	Fri, 19 Jan 2024 10:57:43 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX07-IMDC.srv.huawei-3com.com (unknown [10.62.14.16])
	by mail.maildlp.com (Postfix) with ESMTP id DEA3A22CFEC6;
	Fri, 19 Jan 2024 11:02:14 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX07-IMDC.srv.huawei-3com.com (10.62.14.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 19 Jan 2024 10:57:43 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 19 Jan 2024 10:57:43 +0800
From: Huyadi <hu.yadi@h3c.com>
To: "'Christian Brauner'" <brauner@kernel.org>
CC: "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "mic@digikod.net" <mic@digikod.net>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9tb3ZlX21vdW50X3NldF9n?=
 =?utf-8?Q?roup:Make_tests_build_with_old_libc?=
Thread-Topic: [PATCH v4] selftests/move_mount_set_group:Make tests build with
 old libc
Thread-Index: AQHaRII9d44IpKHVmkiSX1xdCq/Vx7DfKLkAgAFS0NA=
Date: Fri, 19 Jan 2024 02:57:43 +0000
Message-ID: <8918d5e83d54418b9db3ee9c055d675d@h3c.com>
References: <20240111113229.10820-1-hu.yadi@h3c.com>
 <20240118-sezieren-neurologie-6690110057ca@brauner>
In-Reply-To: <20240118-sezieren-neurologie-6690110057ca@brauner>
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
X-MAIL:h3cspam02-ex.h3c.com 40J2vhvT092086

DQo+T24gVGh1LCAxMSBKYW4gMjAyNCAxOTozMjoyOSArMDgwMCwgSHUgWWFkaSB3cm90ZToNCj4+
IFJlcGxhY2UgU1lTXzxzeXNjYWxsPiB3aXRoIF9fTlJfPHN5c2NhbGw+LiAgVXNpbmcgdGhlIF9f
TlJfPHN5c2NhbGw+IA0KPj4gbm90YXRpb24sIHByb3ZpZGVkIGJ5IFVBUEksIGlzIHVzZWZ1bCB0
byBidWlsZCB0ZXN0cyBvbiBzeXN0ZW1zIA0KPj4gd2l0aG91dCB0aGUgU1lTXzxzeXNjYWxsPiBk
ZWZpbml0aW9ucy4NCj4+IA0KPj4gUmVwbGFjZSBTWVNfbW92ZV9tb3VudCB3aXRoIF9fTlJfbW92
ZV9tb3VudA0KPj4gDQo+PiBTaW1pbGFyIGNoYW5nZXM6IGNvbW1pdCA4NzEyOWVmMTM2MDMgKCJz
ZWxmdGVzdHMvbGFuZGxvY2s6IE1ha2UgdGVzdHMgDQo+PiBidWlsZCB3aXRoIG9sZCBsaWJjIikN
Cj4+IA0KPj4gWy4uLl0NCj4NCj5BcHBsaWVkIHRvIHRoZSB2ZnMubWlzYyBicmFuY2ggb2YgdGhl
IHZmcy92ZnMuZ2l0IHRyZWUuDQo+UGF0Y2hlcyBpbiB0aGUgdmZzLm1pc2MgYnJhbmNoIHNob3Vs
ZCBhcHBlYXIgaW4gbGludXgtbmV4dCBzb29uLg0KPg0KPlBsZWFzZSByZXBvcnQgYW55IG91dHN0
YW5kaW5nIGJ1Z3MgdGhhdCB3ZXJlIG1pc3NlZCBkdXJpbmcgcmV2aWV3IGluIGEgbmV3IHJldmll
dyB0byB0aGUgb3JpZ2luYWwgcGF0Y2ggc2VyaWVzIGFsbG93aW5nIHVzIHRvIGRyb3AgaXQuDQo+
DQo+SXQncyBlbmNvdXJhZ2VkIHRvIHByb3ZpZGUgQWNrZWQtYnlzIGFuZCBSZXZpZXdlZC1ieXMg
ZXZlbiB0aG91Z2ggdGhlIHBhdGNoIGhhcyBub3cgYmVlbiBhcHBsaWVkLiBJZiBwb3NzaWJsZSBw
YXRjaCB0cmFpbGVycyB3aWxsIGJlIHVwZGF0ZWQuDQo+DQo+Tm90ZSB0aGF0IGNvbW1pdCBoYXNo
ZXMgc2hvd24gYmVsb3cgYXJlIHN1YmplY3QgdG8gY2hhbmdlIGR1ZSB0byByZWJhc2UsIHRyYWls
ZXIgdXBkYXRlcyBvciBzaW1pbGFyLiBJZiBpbiBkb3VidCwgcGxlYXNlIGNoZWNrIHRoZSBsaXN0
ZWQgYnJhbmNoLg0KPg0KPnRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdmZzL3Zmcy5naXQNCj5icmFuY2g6IHZmcy5taXNjDQo+DQoNCk1heSBJ
IHRha2UgdGhlIGxpYmVydHkgdG8gYXNrIHdoeSBJIGRvbid0IHNlZSBwYXRjaCBhcHBsaWVkIHRv
IGFib3ZlIGJyYW5jaD8NCmFuZCBiZWxvdyBjb21taXQgYWxzbyBzaG93cyBlcnJvcjoNCg0KQmFk
IG9iamVjdCBpZDogMDc3OGIwYTFhOGQyDQoNCj5bMS8xXSBzZWxmdGVzdHMvbW92ZV9tb3VudF9z
ZXRfZ3JvdXA6TWFrZSB0ZXN0cyBidWlsZCB3aXRoIG9sZCBsaWJjDQo+ICAgICBodHRwczovL2dp
dC5rZXJuZWwub3JnL3Zmcy92ZnMvYy8wNzc4YjBhMWE4ZDINCg==

