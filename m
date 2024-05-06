Return-Path: <linux-kselftest+bounces-9556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C98BD575
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 21:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9A1C2199F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3415A4B6;
	Mon,  6 May 2024 19:32:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361815A4B4
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023941; cv=none; b=MqiOtc9n+sVmjdnGbiL2sjo9LDlagTkcQEeSA4a48EuWWbcI82ul6CIQNRHJhgRnKg84RmtRKrZsMYfzpbpc9LG3aQjBHj0RduSuKQLA3MeMJRbnUZx7wSUATX57FJ10RRidQ1XXMlqu5JtyfwqVG4aEf4O5I7uo8EOco57FZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023941; c=relaxed/simple;
	bh=eI+kER1SL3aEsFbNhtCuGNlJ0SLW6TBfDVzR78QACzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MD/agy/lhnKfYPMGR4PcX67a5H0Boh+90PSFRfsxcEOfgyo1j1/kirE2IdFoA9lcD1O0pUp9Q+ESWqw81uD+KZ7S/xyOUE8TaCKvpR2c5+RKRI3tipOeu2KE1gHGQZhY9ftw1sJ0FDCyelqRIqS5Rf1F8l7F2YqjGSF91A3QFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-QUctF-81M7WgRzXbUgngrA-1; Mon, 06 May 2024 20:32:15 +0100
X-MC-Unique: QUctF-81M7WgRzXbUgngrA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 6 May
 2024 20:31:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 6 May 2024 20:31:36 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Edward Liaw' <edliaw@google.com>, Justin Stitt <justinstitt@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, "H. Peter Anvin"
	<hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: RE: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for
 elf_hash
Thread-Topic: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for
 elf_hash
Thread-Index: AQHanAFdbmzmhwAPx0KMYxInfI6/rrGIpXPggAHZwnqAACCfUA==
Date: Mon, 6 May 2024 19:31:36 +0000
Message-ID: <7332ff979f3440bd8362d37d4d1f34b8@AcuMS.aculab.com>
References: <20240501180622.1676340-1-edliaw@google.com>
 <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
 <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
 <CAG4es9WYrN_tOV1Uxi_ytO2qDRRZW5_uN=2p3iCg=P0r3mM3Og@mail.gmail.com>
In-Reply-To: <CAG4es9WYrN_tOV1Uxi_ytO2qDRRZW5_uN=2p3iCg=P0r3mM3Og@mail.gmail.com>
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

RnJvbTogRWR3YXJkIExpYXcNCj4gU2VudDogMDYgTWF5IDIwMjQgMTg6MzQNCj4gDQo+IE9uIE1v
biwgTWF5IDYsIDIwMjQgYXQgMTA6MTbigK9BTSBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdv
b2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gU3VuLCBNYXkgNSwgMjAyNCBhdCA2OjIx4oCv
QU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gRnJvbTogSnVzdGluIFN0aXR0DQo+ID4gPiA+IFNlbnQ6IDAxIE1heSAyMDI0IDIwOjU1
DQo+ID4gPiAuLi4NCj4gPiA+ID4gPiBzdGF0aWMgdW5zaWduZWQgbG9uZyBlbGZfaGFzaChjb25z
dCB1bnNpZ25lZCBjaGFyICpuYW1lKQ0KPiA+ID4gLi4uDQo+ID4gPiA+IElzIGl0IHBvc3NpYmxl
IHRvIGp1c3QgY2hhbmdlIHRoZSB0eXBlcyBvZiB0aGUgcGFyYW1ldGVycyBvZiB2ZHNvX3N5bSgp
DQo+ID4gPiA+IG9yIGRvZXMgdGhhdCB0cmlnZ2VyIGV2ZW4gbW9yZSB3YXJuaW5ncyBvbiB0aGUg
Y2FsbHNpdGVzIG9mIHZkc29fc3ltKCk/DQo+ID4gPg0KPiA+ID4gSXNuJ3QgdGhlIHByb2JsZW0g
dGhlIGRlZmluaXRpb24gb2YgZWxmX2hhc2goKT8NCj4gPiA+IEEgJ1wwJyB0ZXJtaW5hdGVkIHN0
cmluZyByZWFsbHkgb3VnaHQgdG8gYmUgJ2NoYXIgKicgbm90ICd1bnNpZ25lZCBjaGFyIConLg0K
PiA+DQo+ID4gUmlnaHQsIGFsdGhvdWdoIG5vdGUgdGhpcyBjb21tZW50IGp1c3QgYWJvdXQgaXRz
IGRlZmluaXRpb246DQo+ID4NCj4gPiAvKiBTdHJhaWdodCBmcm9tIHRoZSBFTEYgc3BlY2lmaWNh
dGlvbi4gKi8NCj4gPiBzdGF0aWMgdW5zaWduZWQgbG9uZyBlbGZfaGFzaChjb25zdCB1bnNpZ25l
ZCBjaGFyICpuYW1lKQ0KPiA+IHsNCj4gPg0KPiA+IHdoaWNoIGluZGVlZCBtYXRjaGVzIFsxXQ0K
PiA+DQo+ID4gWzFdOiBodHRwczovL21hbi5mcmVlYnNkLm9yZy9jZ2kvbWFuLmNnaT9xdWVyeT1l
bGZfaGFzaCZzZWt0aW9uPTMmYXByb3Bvcz0wJm1hbnBhdGg9RnJlZUJTRCs3LjEtDQo+IFJFTEVB
U0UNCj4gDQo+IEhvdyBhYm91dCBJIG1vdmUgdGhlIHR5cGUgY2FzdCBpbnRvIGVsZl9oYXNoLCBs
aWtlIGxpYmVsZiBkb2VzDQo+IGh0dHBzOi8vc291cmNlZm9yZ2UubmV0L3AvZWxmdG9vbGNoYWlu
L2NvZGUvSEVBRC90cmVlL3RydW5rL2xpYmVsZi9lbGZfaGFzaC5jI2w0Nw0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vcGFyc2VfdmRzby5jDQo+IGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy9wYXJzZV92ZHNvLmMNCj4gaW5kZXggNDEzZjc1NjIw
YTM1Li4zM2RiOGFiZDdkNTkgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3ZEU08vcGFyc2VfdmRzby5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08v
cGFyc2VfdmRzby5jDQo+IEBAIC01NiwxMiArNTYsMTUgQEAgc3RhdGljIHN0cnVjdCB2ZHNvX2lu
Zm8NCj4gIH0gdmRzb19pbmZvOw0KPiANCj4gIC8qIFN0cmFpZ2h0IGZyb20gdGhlIEVMRiBzcGVj
aWZpY2F0aW9uLiAqLw0KPiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgZWxmX2hhc2goY29uc3QgdW5z
aWduZWQgY2hhciAqbmFtZSkNCj4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIGVsZl9oYXNoKGNvbnN0
IGNoYXIgKm5hbWUpDQo+ICB7DQo+ICAgdW5zaWduZWQgbG9uZyBoID0gMCwgZzsNCj4gLSB3aGls
ZSAoKm5hbWUpDQo+ICsgY29uc3QgdW5zaWduZWQgY2hhciAqczsNCj4gKw0KPiArIHMgPSAoY29u
c3QgdW5zaWduZWQgY2hhciAqKSBuYW1lOw0KPiArIHdoaWxlICgqcykNCj4gICB7DQo+IC0gaCA9
IChoIDw8IDQpICsgKm5hbWUrKzsNCj4gKyBoID0gKGggPDwgNCkgKyAqcysrOw0KPiAgIGlmIChn
ID0gaCAmIDB4ZjAwMDAwMDApDQo+ICAgaCBePSBnID4+IDI0Ow0KPiAgIGggJj0gfmc7DQoNClRo
YXQgbWFrZXMgYSBsb3QgbW9yZSBzZW5zZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


