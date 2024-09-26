Return-Path: <linux-kselftest+bounces-18404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9E998777A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A9284E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB8155A3C;
	Thu, 26 Sep 2024 16:22:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87A14A4E0
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367732; cv=none; b=Yce0JYsSn4fEyllES/1e5R1M437hhzL63i0mhtKPD+N7wB4pwIK/rzhwVrQSLopYxA9qXX0N3jBKmazb7HlvOGvUqKOPDEnCklBSV4lZZkgiq4gRzpkfOKgubbYWUgfi9lfvshGhe/GIDN3DSPmJ4nKS91p6EyGOdNB0snrGnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367732; c=relaxed/simple;
	bh=O6+YVeNDRTi0JnhIKBZA5TXaFxsqhvlhr61gALTh0Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FOG8raiM2f0s83EfS0VlYEfLaVhjeqTr6j/Z79hgfaBxwdPBmEMe6cePkWCU8wTvWrLLN5L67ERBEndPU8NgFil6oHf9tngrHxNvv6FLNl9U1bGAQZ64mFnzykq1mLvcvrLTc1zgx1+sktf2aFv06a+ZOHXN4o7fL1KJY2pzkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-SFvXZk6PPUOdnKT3Tr7TnQ-1; Thu, 26 Sep 2024 17:22:00 +0100
X-MC-Unique: SFvXZk6PPUOdnKT3Tr7TnQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 26 Sep
 2024 17:21:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 26 Sep 2024 17:21:12 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vinicius Peixoto' <vpeixoto@lkcamp.dev>, =?utf-8?B?QW5kcsOpIEFsbWVpZGE=?=
	<andrealmeid@riseup.net>
CC: Brendan Higgins <brendan.higgins@linux.dev>, "~lkcamp/patches@lists.sr.ht"
	<~lkcamp/patches@lists.sr.ht>, Rae Moar <rmoar@google.com>, David Gow
	<davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 0/1] Add KUnit tests for lib/crc16.c
Thread-Topic: [PATCH 0/1] Add KUnit tests for lib/crc16.c
Thread-Index: AQHbDtY1vq0etu3wdUK8sqieRnvh+bJqPLsw
Date: Thu, 26 Sep 2024 16:21:12 +0000
Message-ID: <7f67ae7f15524e4eab6b15cdfd750a04@AcuMS.aculab.com>
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
 <8291c6eb-750a-4ab2-8904-65d723d034dd@riseup.net>
 <6d3025ed-e00d-4f8a-bab7-256cf78774af@lkcamp.dev>
In-Reply-To: <6d3025ed-e00d-4f8a-bab7-256cf78774af@lkcamp.dev>
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

Li4uDQo+IFRoZSBjaGVja3N1bXMgZm9yIHRoZSByYW5kb21seS1nZW5lcmF0ZWQgdGVzdCBjYXNl
cyB3ZXJlIGNhbGN1bGF0ZWQNCj4gdXNpbmcgYSByZWZlcmVuY2UgaW1wbGVtZW50YXRpb24gWzFd
IGFuZCB0aGlzIHRlc3QgY29tcGFyZXMgdGhlbSBhZ2FpbnN0DQo+IHRoZSB2YWx1ZXMgeWllbGRl
ZCBieSB0aGUga2VybmVsJ3MgaW1wbGVtZW50YXRpb24uDQoNCkknZCBqdXN0IHVzZSBhIG5hw692
ZSBpbXBsZW1lbnRhdGlvbiAtIGRvZXNuJ3QgcmVhbGx5IG1hdHRlcg0KaWYgaXQgaXMgYSBiaXQg
c2xvdy4NCg0KU2xvdyBpcyByZWxhdGl2ZSAtIHRoaXMgY29kZSBvbmx5IHRha2VzIDM1bXMgdG8g
Y3JjLTY0IG92ZXIgNU1CIG9mIGRhdGEuDQoNCnsNCiAgICB2b2xhdGlsZSBjb25zdCB1aW50MzJf
dCAqciA9IChjb25zdCB2b2lkICopYnVmOw0KICAgIGZvciAoY3JjID0gMDsgciA8IChjb25zdCB1
aW50MzJfdCAqKWJ1Zl9lbmQ7IHIrKykgew0KICAgICAgICB1aW50NjRfdCB2YWwgPSBsZTMydG9o
KCpyKTsNCiAgICAgICAgY3JjIF49IGJzd2FwNjQodmFsKTsNCiAgICAgICAgZm9yIChpID0gMDsg
aSA8IDMyOyBpKyspIHsNCiAgICAgICAgICAgIGlmIChjcmMgJiAoMXVsbCA8PCA2MykpDQogICAg
ICAgICAgICAgICAgY3JjID0gKGNyYyA8PCAxKSBeIDB4NDJmMGUxZWJhOWVhMzY5M3VsbDsNCiAg
ICAgICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICBjcmMgPSBjcmMgPDwgMTsNCiAgICAgICAg
fQ0KICAgIH0NCn0NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


