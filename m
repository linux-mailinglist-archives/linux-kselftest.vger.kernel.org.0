Return-Path: <linux-kselftest+bounces-10666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022318CE4B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B259B282375
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CC85C70;
	Fri, 24 May 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="e///wh0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36385931;
	Fri, 24 May 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548929; cv=none; b=uYSIQ8dmcEMwrWSquF8YtavAPNAidUkACxhyUHh69NOXDylyH5YUNgRkgL40gH7p3wo2mITy2vu6ufwPKmIFtoFgueAW42zYla3Yzjs2P+vtKBQJPE7FIV+CJqyhpT81zmR/f5uOKkPuU/ZSk7PrX0F7p/P29Ytfkb6dzs+zaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548929; c=relaxed/simple;
	bh=v3x1Hr63ZlkyPq+bsb5kU2yJX1PC7tT3ck6zS7F56Xo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEh9FARqwfRiadOornyya29tAeC+ucHHjCPDva3HyWQ6MAqY7ubRW2IHgdWcfUndZjVtIR4UAIUOhQQ+wncpKMPwXSm2YZbM6fgC9Xb7ceQGyabLNwJ/qRPKy+pSHAb9ybtqH7Nj34wxq3cibZPWY8NLDFprfIBp7DwBBTocazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=e///wh0x; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 4F211104679D;
	Fri, 24 May 2024 13:59:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 4F211104679D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1716548344; bh=v3x1Hr63ZlkyPq+bsb5kU2yJX1PC7tT3ck6zS7F56Xo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=e///wh0xtKwyN00jheU7ut6g2Ocp3Cv5q6trRvel7B+MljRQc0pUbA7qhmGtaJo3P
	 ln4gLvIqx5i1hZt3PRMfhU663Wvu51XJrzqedODWY/zk9kkFBgXQ4KoHydxYkU7Oe9
	 fJRaAl92GbrmPW0nB+1V3pg33DUNi2dVVBPmXth8=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 4B9BB305EE18;
	Fri, 24 May 2024 13:59:04 +0300 (MSK)
From: Khannanov Lenar <Lenar.Khannanov@infotecs.ru>
To: "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>
CC: "brauner@kernel.org" <brauner@kernel.org>, "fweimer@redhat.com"
	<fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>, "shuah@kernel.org" <shuah@kernel.org>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Subject: Re: selftests: clone3: clone3_cap_checkpoint_restore fails - Could
 not set CAP_CHECKPOINT_RESTORE
Thread-Topic: selftests: clone3: clone3_cap_checkpoint_restore fails - Could
 not set CAP_CHECKPOINT_RESTORE
Thread-Index: AQHarcljyzSqEdNYbUK4bASISxnLQQ==
Date: Fri, 24 May 2024 10:59:03 +0000
Message-ID: <3805f5f4-34c3-4c29-a03f-80ac2563cef3@infotecs.ru>
References: <CA+G9fYsVnDSwudT=go0p__2Jas-JuT-8Y+9Jk1xPtA1h4Nmreg@mail.gmail.com>
In-Reply-To: <CA+G9fYsVnDSwudT=go0p__2Jas-JuT-8Y+9Jk1xPtA1h4Nmreg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <986D0C423F8752498E6A79AB6E0BA374@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/05/24 09:04:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/05/24 05:27:00 #25259167
X-KLMS-AntiVirus-Status: Clean, skipped

DQpJIHByZXN1bWUgdGhhdCB0ZXN0IGZhaWxzIGJlY2F1c2Ugb2YgdGhlIGRpZmZlcmVuY2UgYmV0
d2VlbiBkZWZpbml0aW9uIG9mIHN0cnVjdCBfY2FwX3N0cnVjdCAoc3RydWN0IGxpYmNhcCBpbiB0
ZXN0KS4gQ29tbWl0IGFjYTA3NjQ0MzU5MSAoTWFrZSBjYXBfdCBvcGVyYXRpb25zIHRocmVhZCBz
YWZlLikgaW50cm9kdWNlcyBtdXRleCBmaWVsZCBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBzdHJ1
Y3R1cmUuIFRlc3QgdXNlcyBvd24gZGVmaW5pdGlvbiB0byBzZXQgQ0FQX0NIRUNLUE9JTlRfUkVT
VE9SRS4gQXMgZGF0YSBtZW1iZXIgb2YgdGhlc2UgdHdvIHZlcnNpb25zIG9mIHN0cnVjdHVyZXMg
aXMgYXQgdGhlIGRpZmZlcmVudCBvZmZzZXRzLCBDQVBfQ0hFQ0tQT0lOVF9SRVNUT1JFIGlzIGxv
c3QgYW5kIHRoYXQncyB3aHkgY2FwX3NldF9wcm9jIHJldHVybnMgRVBFUk0uDQoNCg0K0KEg0YPQ
stCw0LbQtdC90LjQtdC8LA0K0JvQtdC90LDRgCDQpdCw0L3QvdCw0L3QvtCyDQrQn9GA0L7Qs9GA
0LDQvNC80LjRgdGCDQrQntGC0LTQtdC7INGA0LDQt9GA0LDQsdC+0YLQutC4DQrQkNCeICLQmNC9
0YTQvtCi0LXQmtChIiDQsiDQsy4g0KHQsNC90LrRgi3Qn9C10YLQtdGA0LHRg9GA0LMNCjE5MDAw
MCwg0LMuINCh0LDQvdC60YIt0J/QtdGC0LXRgNCx0YPRgNCzLCDRg9C7LiDQkNGA0YLQuNC70LvQ
tdGA0LjQudGB0LrQsNGPLCDQtC4gMSwg0LvQuNGC0LXRgCDQkCwg0JHQpiDCq9CV0LLRgNC+0L/Q
sCDQpdCw0YPRgcK7DQpUOiArNyA0OTUgNzM3LTYxLTkyICgg0LTQvtCxLiA3MTk2KQ0K0KQ6ICs3
IDQ5NSA3MzctNzItNzgNCg0KDQpMZW5hci5LaGFubmFub3ZAaW5mb3RlY3MucnUNCnd3dy5pbmZv
dGVjcy5ydQ0KDQoNCg==

