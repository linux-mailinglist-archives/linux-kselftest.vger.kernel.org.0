Return-Path: <linux-kselftest+bounces-42984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849ABD134F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 04:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58FB3B2004
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 02:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20B2586E8;
	Mon, 13 Oct 2025 02:19:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DDC169AE6;
	Mon, 13 Oct 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321950; cv=none; b=h8Pq/sEDezJzCSiMN2YL+IY41U+jY77VJhTNfwmYygXIEiO1OXTEWl/f9QNmMvklY903XoAWP+WsDkLG69eRt6DtvlqArzaQvOXYwSVBWxDL8DZbgIUWQVXOwWmJwLZ2E2D4hO3tRWMm9Tnjl2nC7hBSbtvlvP66DZ8rK7k/vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321950; c=relaxed/simple;
	bh=wckOwuj24Ij1V2m401eRdyD2GopDhpl7foF6Yjx/7Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECUIfhaOSJ9cn8W4cV1nwFaKHQPSaY5LIJYe1pJAuuhBY0Ez4lfamf8X5GP1E5dDAdtHeO8QeD2b+5QxeQsu31LYqOWZ8Pib9nwnW8h5C5qgC4rUbuYSBra38FCvoFWbjrVocq4zma3LPl6O2HbrrWe1UMPH0GKdNhgfphMoIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
	<wireguard@lists.zx2c4.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Hildenbrand
	<david@redhat.com>, Feng Tang <feng.tang@linux.alibaba.com>, Florian Westphal
	<fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>, "Jason A . Donenfeld"
	<Jason@zx2c4.com>, Joel Granados <joel.granados@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
	<kees@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Petr
 Mladek" <pmladek@suse.com>, Phil Auld <pauld@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0ggdjNdIGh1bmdfdGFzazog?=
 =?utf-8?Q?Panic_after_fixed_number_of_hung_tasks?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCB2M10gaHVuZ190YXNrOiBQYW5p?=
 =?utf-8?Q?c_after_fixed_number_of_hung_tasks?=
Thread-Index: AQHcO3v66ZG2hk4PtE6ORt/xqoKtirS/VpVw
Date: Mon, 13 Oct 2025 02:14:58 +0000
Message-ID: <2b19bac7de174fe6baa07234b88c8156@baidu.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
In-Reply-To: <0aea408f-f6d7-4e2d-8cee-1801ad7f3139@web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM

PiDigKYNCj4gPiBUaGlzIHBhdGNoIGV4dGVuZHMgdGhlIOKApg0KPiANCj4gV2lsbCBhbm90aGVy
IGltcGVyYXRpdmUgd29yZGluZyBhcHByb2FjaCBiZWNvbWUgbW9yZSBoZWxwZnVsIGZvciBhbg0K
PiBpbXByb3ZlZCBjaGFuZ2UgZGVzY3JpcHRpb24/DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtDQo+
IGVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdD9oPXY2LjE3I245NA0KPiAN
Cg0Kd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uDQo+IA0KPiDigKYNCj4gPiArKysgYi9rZXJuZWwv
aHVuZ190YXNrLmMNCj4g4oCmDQo+IEBAIC0yMjksOSArMjMyLDExIEBAIHN0YXRpYyB2b2lkIGNo
ZWNrX2h1bmdfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQsDQo+IHVuc2lnbmVkIGxvbmcgdGlt
ZW91dCkg4oCmDQo+ID4gIAl0cmFjZV9zY2hlZF9wcm9jZXNzX2hhbmcodCk7DQo+ID4NCj4gPiAt
CWlmIChzeXNjdGxfaHVuZ190YXNrX3BhbmljKSB7DQo+ID4gKwlpZiAoc3lzY3RsX2h1bmdfdGFz
a19wYW5pYyAmJg0KPiA+ICsJCQkodG90YWxfaHVuZ190YXNrID49IHN5c2N0bF9odW5nX3Rhc2tf
cGFuaWMpKSB7DQo+IOKApg0KPiANCj4gSSBzdWdnZXN0IHRvIHVzZSB0aGUgZm9sbG93aW5nIHNv
dXJjZSBjb2RlIHZhcmlhbnQgaW5zdGVhZC4NCj4gDQo+IAlpZiAoc3lzY3RsX2h1bmdfdGFza19w
YW5pYyAmJiB0b3RhbF9odW5nX3Rhc2sgPj0gc3lzY3RsX2h1bmdfdGFza19wYW5pYykNCj4gew0K
PiANCg0Kd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uDQoNCnRoYW5rcw0KDQotTGkNCg0KPiANCj4g
UmVnYXJkcywNCj4gTWFya3VzDQoNCg==

