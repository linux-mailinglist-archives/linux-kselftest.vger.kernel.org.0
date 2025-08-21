Return-Path: <linux-kselftest+bounces-39523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F4B2FEF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2FB17B7E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760A2765DF;
	Thu, 21 Aug 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Sx/XziRd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1127258EFF;
	Thu, 21 Aug 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790735; cv=none; b=qPXpVwDAqPCfEs4Lu4+6f+/MmRH1Q4QupDmjrspdBj3D6octHF0AodH7ppbZLg6WKTJsne1HDlp0uhxRVKH5PgvTybbpb60IDE6wta2CUnWLfE9nosaq1l9VdQUcmWP6KPErgjs9Y7Eps5QM5gU2JLYZ/V+4z2PhE8z8iqAMifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790735; c=relaxed/simple;
	bh=34WxhVkd3Zb9HWQceYCWNuG5BF2cNsCX7/SRYVYgZDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YfPkdjfZNYW9KRkRolzb4DKalQkl8LpnSnNA5JTyK4bcICWQ6fNLY2ihZbUqhd4Vtlxw/jWfzAO6FMVnWDleJ2UZvfBGX7OmsvaG8TpqhhWG9QeR5qoFDgVDPbSV8LFOL+QX2dhetolxZVnGTicSbD+4GmLlr5ca0iXzCZnANb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Sx/XziRd reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=N3Ina/fhCR8xT0SbpvmwgG8VxddZ2Fai2XOqRVIwIcE=; b=S
	x/XziRdPgFrU2/P3dXRFlhoWrVS5011E2vH98MZN04FsdskRB7VMaTzQDrW3l8vt
	Pwmin/i3MZYHW7HZAJgikWQLStZWrFzH4/4DOvdImWD5fO5D6Dpp3UG+PTyzA7mb
	2Fextc/rqXntkcUu8oiSiRZfwfI323+i9P7OLIGnFI=
Received: from phoenix500526$163.com ( [120.230.124.83] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Thu, 21 Aug 2025 23:38:13 +0800
 (CST)
Date: Thu, 21 Aug 2025 23:38:13 +0800 (CST)
From: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests
 to cover SIB handling logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAEf4Bzbpu9PM6GHV6ewE_hJJ7=94Rn1ZYq5QWVnpoH6_LRQDCw@mail.gmail.com>
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com>
 <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
 <30d8fcac.2669.19882763de2.Coremail.phoenix500526@163.com>
 <e7ba3f7f-38b8-4c06-8aff-ef1fb8d04d86@linux.dev>
 <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
 <0f6d16c1-0e85-4709-9846-3a993a9f041b@linux.dev>
 <65e51538.57aa.1989d162bb8.Coremail.phoenix500526@163.com>
 <2559a8cd-b439-43fc-96e4-d5f2941ca4d8@linux.dev>
 <3fbb9319.20c8.198a1410186.Coremail.phoenix500526@163.com>
 <6c444d7d-524d-4bc8-bda6-0440af621ebe@linux.dev>
 <46f4c341.1dea.198b845a4b0.Coremail.phoenix500526@163.com>
 <7495eeb9-777b-4b9e-8312-c6654268d6ec@linux.dev>
 <CAEf4Bzbpu9PM6GHV6ewE_hJJ7=94Rn1ZYq5QWVnpoH6_LRQDCw@mail.gmail.com>
X-NTES-SC: AL_Qu2eB/uSv04i5SSQYukfmUsVh+o9X8K1vfsk3oZfPJp+jAPo8CYNenRSAXvt8e60NDCgmgmGWztUxPtYULV/TqgBw3HLFMj7h2JODLD44ZLNbA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <eb7a3ed.9723.198cd47d479.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgD3X+xmPadotSMfAA--.2845W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAGwiGinMrOWNQACsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKSW4gdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gd2l0aCBZb25naG9uZyBTb25nLCB3
ZSBmb3VuZCB0aGF0IHNvbWUgY29tcGlsZXIgd291bGQgZ2VuZXJhdGUKc3VjaCBhbiBhcmd1ZW1l
bnQgZm9ybWF0LiBBbHRob3VnaCBJIGhhdmUgbmV2ZXIgZW5jb3VudGVyIHN1Y2ggYW4gaXNzdWUs
IEkgZm91bmQgdGhhdCB0aGUgCmdsb2JhbCB2b2xhdGlsZSB2YXJpYWJsZSBjb3VsZCB0cmlnZ2Vy
IHRoZSBjb21waWxlciB0byBnZW5lcmF0ZSB0aGlzIGFyZ3VtZW50IHNwZWMuIFNvIEkgdHJpZWQg
dG8gCnNvbHZlIHRoaXMgcHJvYmxlbS4gSSBndWVzcyB0aGlzIHdvdWxkIG5vdCBiZSBhIHByb2Js
ZW0gc2luY2Ugd2UgaGF2ZSBhbHJlYWR5IHVzZWQgU1RBUF9QUk9CRV9BU00KdG8gcmVsaWFibHkg
Z2VuZXJhdGUgU0lCIGFyZ3VtZW50IHNwZWMuIAoKQlRXLCBJIGhhdmUgYW5vdGhlciBpc3N1ZSB0
byBkaXNjdXNzLiAKCk5vdywgYmNjIGZyYW1ld29yayBpcyBub3QgYSByZWNvbW1lbmRhdGlvbiBm
b3Igd3JpdGluZyBicGYgcHJvZ3JhbSwgc28gYnBmdHJhY2UgaXMgbm93IG1pZ3JhdGluZyAKZnJv
bSBiY2MgZnJhbWV3b3JrIHRvIGxpYmJwZi4gQmNjIGZyYW1ld29yayBwcm92aWRlcyBzb21lIHJl
bGV2YW50IEFQSXMgZm9yIGdldCB1c2R0IHByb2JlIGluZm9bMV0uCkFuZCBJIGZvdW5kIHRoYXQg
dGhlcmUgaXMgbm90IHNpbWlsYXIgQVBJcyBpbiBsaWJicGYsIHRoZXJlZm9yZSBJIGhhdmUgdG8g
cGFyc2UgZWxmIGZpbGUgbWFudWFsbHkuIAoKQ291bGQgd2UgYWRkIHNvbWUgcmVsZXZhbnQgQVBJ
cywgbWF5YmUgbGlrZSBgYnBmX3Byb2dyYW1fX3VzZHRfcHJvYmVfbGlzdGAsIGluIGxpYmJwZj8g
SSBjYW4gbWFrZQphIHBhdGNoIHRvIGltcGxlbWVudCBpdC4gV0RZVD8KCgpbMV0uIGh0dHBzOi8v
Z2l0aHViLmNvbS9icGZ0cmFjZS9icGZ0cmFjZS9ibG9iLzFjZDRiYmRkNGExM2RkNTU4ODBmMmNj
NjM4ZGRlNjQxZmI1Zjg0NzQvc3JjL3VzZHQuY3BwI0wxMzFDMS1MMTUyQzIKCgoKCgoKCkF0IDIw
MjUtMDgtMjEgMDc6MDA6MzUsICJBbmRyaWkgTmFrcnlpa28iIDxhbmRyaWkubmFrcnlpa29AZ21h
aWwuY29tPiB3cm90ZToKPk9uIE1vbiwgQXVnIDE4LCAyMDI1IGF0IDEwOjM14oCvQU0gWW9uZ2hv
bmcgU29uZyA8eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+IHdyb3RlOgo+Pgo+Pgo+Pgo+PiBPbiA4
LzE3LzI1IDY6NDMgQU0sIOi1teS9s+eCnCB3cm90ZToKPj4gPgo+PiA+Cj4+ID4KPj4gPgo+PiA+
Cj4+ID4KPj4gPiBIaSwgWW9uZ2hvbmcuIEkndmUgYWxyZWFkeSBmaWxlZCBhbiBpc3N1ZVsxXSBp
biBHQ0MgIGNvbW11bml0eS4KPj4gPgo+PiA+Cj4+ID4gQWNjcm9kaW5nIHRvIHRoZSBkaXNjdXNz
aW9uLCBpdCdzIG5vdCBhIGdjYyBidWcgYnV0IG1heSBiZSBhIHN5c3RlbXRhcCBidWcuCj4+ID4g
SSBkb24ndCBrbm93IGhvdyB0byByZXBvcnQgdGhpcyBidWcgdG8gc3lzdGVtdGFwLCBidXQgSSBm
b3VuZCB0aGF0IHRoZQo+PiA+IGxpYmJwZi91c2R0IGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4gSSd2
ZSBmaWxlZCBhbiBpc3N1ZSBpbiBsaWJicGYvdXNkdCByZXBvWzJdLgo+PiA+Cj4+ID4gSSBhbHNv
IGhhdmUgc29tZSBpZGVhcyBhYm91dCBpdC4gSSB3cm90ZSBpdCBkb3duIGluIHRoZSBpc3N1ZVsy
XSBjb21tZW50Lgo+PiA+IE1heSBiZSB3ZSBjYW4gZGlzY3VzcyB0aGVyZS4KPj4gPgo+PiA+IFsx
XS4gaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9MTIxNTY5Cj4+
ID4gWzJdLiBodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL3VzZHQvaXNzdWVzLzEzCj4+Cj4+IFRo
YW5rcyBmb3IgZmlsaW5nIGFuIGlzc3VlIG9uIGdjYyBhbmQgZ2V0dGluZyBzb21lIGZlZWRiYWNr
L3N1Z2dlc3Rpb25zCj4+IGZyb20gZ2NjIGNvbW11bml0eS4KPj4KPj4gQ3VycmVudGx5LCBsaWJi
cGYvdXNkdCBkb2VzIG5vdCBzdXBvcnQgZm9ybWF0IGxpa2UgJy0xQHRpKCVyaXApJy4gSWYgd2Ug
ZG8KPgo+RXhhY3RseSwgaXQgZG9lc24ndC4gSSBoYXZlbid0IHlldCByYW4gaW50byBhIGNhc2Ug
d2hlcmUgcmVhbC13b3JsZAo+YXBwbGljYXRpb25zIHdvdWxkIHVzZSBzdWNoIGFuIGFyZ3VtZW50
IGZvcm1hdCwgc28gdGhlcmUgd2FzIG5vCj5pbmNlbnRpdmUgaW4gdHJ5aW5nIHRvIHN1cHBvcnQg
aXQuCj4KPldhcyB0aGlzIGlzc3VlIGRpc2NvdmVyZWQgYXMgcGFydCBvZiB0ZXN0aW5nIG9uIHNv
bWUgcmVhbCB3b3JsZAo+YXBwbGljYXRpb24sIG9yIGl0J3MgbW9zdGx5IHRocm91Z2ggdGVzdGlu
ZyBvbiBzeW50aGV0aWMgY2FzZXM/Cj4KPj4gaW50ZW5kIHRvIGltcGxlbWVudCB0aGlzLiBsaWJi
cGYvdXNkdCBjYW4gcmVqZWN0IHRoYXQgaWYgJ3RpJyBpcyBhCj4+IHN0YXRpYyB2YXJpYWJsZS4g
bGliYnBmIGNhbiBwcm92aWRlIHNvbWUgaGludHMgYWJvdXQgaG93IHRvIG1ha2UgaXQKPj4gd29y
ayAoc2VlIGFib3ZlIFsxXSBhbmQgWzJdKS4gVGhlbiwgaXQgd291bGQgYmUgdXNlcidzIHJlcG9u
c2liaWxpdHkgdG8KPj4gY2hhbmdlIGNvZGUgc28gbGliYnBmIGNhbiBzdXBwb3J0IGl0Lgo+Pgo+
PiA+Cj4+ID4KPj4gPgo+Cj5bLi4uXQo=

