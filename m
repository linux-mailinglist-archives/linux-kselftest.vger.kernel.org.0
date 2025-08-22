Return-Path: <linux-kselftest+bounces-39697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CFB31FB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1390C1CE6009
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10A23E358;
	Fri, 22 Aug 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="SxvdzIjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C62253AE;
	Fri, 22 Aug 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877216; cv=none; b=uq+bAUYUM5ES3/gccpqEVe3OkwNMMIBX6PUedjKLEmV0tIm7l5igqKw6oke1bxXl9TuuDWvw+F2ITX+Srdid7vb15W3K/Nkn+IHYLeX7DHa+Qy7evZsBWwNhLY7hH1qXmRnOTb6y3MdCrBCLH1ZtMmdDhWNS6OuWGA261VrFLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877216; c=relaxed/simple;
	bh=8IBLvXRHu6u5QjRZvO+ml8Wcl5FrQ18oG9mLPGafaq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=YSF8Hprop/u+fq/Jav+DKeVMhBoSFQu799/9vJmvabTvnCYwKa9O5s4petn8FQA7fQ1JZhVhGLbCJxXoRzTaD6FjQK/Sq+BWtHS2DRPmpHpjVXIaO7hq9CP3K2G4eOVbJYwBO8Yt8n3k9UbMkS7FjxBuJp0K1W4uN0X8LOtN5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=SxvdzIjk reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=23sgGgwyxKJtoJOOlVQjOMRFjR55O7BKqyKdOFmt2UA=; b=S
	xvdzIjk0UdDwkE2Bi6hCelinkUaO7TmW0tAsH4AciSJA4tqyn73LJ0PsNWiBv5nv
	KgxrI2IL2FAOns15zYGkKaT1t0YdO/D2eMvEfbgO2k24cwCkSYJpmsUhBZOaRHHG
	rquwsu57sKtbeS17T21diui7W7ER3t0QUUfVPA/wqA=
Received: from phoenix500526$163.com ( [120.230.124.83] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Fri, 22 Aug 2025 23:39:26 +0800
 (CST)
Date: Fri, 22 Aug 2025 23:39:26 +0800 (CST)
From: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT
 selftests to cover SIB handling logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAEf4BzZLMp5oLnF_Nfjru7+zE2P4981GXWGf6d=6jEY4TqBt4Q@mail.gmail.com>
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
 <eb7a3ed.9723.198cd47d479.Coremail.phoenix500526@163.com>
 <CAEf4BzZLMp5oLnF_Nfjru7+zE2P4981GXWGf6d=6jEY4TqBt4Q@mail.gmail.com>
X-NTES-SC: AL_Qu2eB/ScuEkt4CSfYekfmUsVh+o9X8K1vfsk3oZfPJp+jB/o8AU8Z1lMJ1nW+euOIgmlrheYSRJPzuZ6Z7ZSWYANcqbJEnpVNnMFgG4VcUeLAw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1fee1812.996d.198d26f4d99.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jCgvCgDXf48vj6hozAYgAA--.2691W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFBqxiGiogESwtQACs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgpPaywgSSBzZWUuIEkgZmlsZSBhbiBpc3N1ZSBpbiBsaWJicGYgcmVwbyB0byB0cmFj
ayB0aGlzIGRpc2N1c3Npb24uIAoKRllJOiBodHRwczovL2dpdGh1Yi5jb20vbGliYnBmL2xpYmJw
Zi9pc3N1ZXMvOTE4CgoKCgoKCgoKQXQgMjAyNS0wOC0yMiAwMjoyODozMSwgIkFuZHJpaSBOYWty
eWlrbyIgPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOgo+T24gVGh1LCBBdWcgMjEs
IDIwMjUgYXQgODozOOKAr0FNIOi1teS9s+eCnCA8cGhvZW5peDUwMDUyNkAxNjMuY29tPiB3cm90
ZToKPj4KPj4KPj4KPj4KPj4KPj4KPj4KPj4KPj4KPj4KPj4gSW4gdGhlIHByZXZpb3VzIGRpc2N1
c3Npb24gd2l0aCBZb25naG9uZyBTb25nLCB3ZSBmb3VuZCB0aGF0IHNvbWUgY29tcGlsZXIgd291
bGQgZ2VuZXJhdGUKPj4gc3VjaCBhbiBhcmd1ZW1lbnQgZm9ybWF0LiBBbHRob3VnaCBJIGhhdmUg
bmV2ZXIgZW5jb3VudGVyIHN1Y2ggYW4gaXNzdWUsIEkgZm91bmQgdGhhdCB0aGUKPj4gZ2xvYmFs
IHZvbGF0aWxlIHZhcmlhYmxlIGNvdWxkIHRyaWdnZXIgdGhlIGNvbXBpbGVyIHRvIGdlbmVyYXRl
IHRoaXMgYXJndW1lbnQgc3BlYy4gU28gSSB0cmllZCB0bwo+PiBzb2x2ZSB0aGlzIHByb2JsZW0u
IEkgZ3Vlc3MgdGhpcyB3b3VsZCBub3QgYmUgYSBwcm9ibGVtIHNpbmNlIHdlIGhhdmUgYWxyZWFk
eSB1c2VkIFNUQVBfUFJPQkVfQVNNCj4+IHRvIHJlbGlhYmx5IGdlbmVyYXRlIFNJQiBhcmd1bWVu
dCBzcGVjLgo+Cj5ZZXAsIGxldCdzIGhvbGQgb2ZmIG9uIGltcGxlbWVudGluZyB0aGlzLCBhcyBp
dCBkb2Vzbid0IHNlZW0gdG8gYmUKPnJlYWxseSBuZWNlc3NhcnkgaW4gcHJhY3RpY2UuCj4KPj4K
Pj4gQlRXLCBJIGhhdmUgYW5vdGhlciBpc3N1ZSB0byBkaXNjdXNzLgo+Pgo+PiBOb3csIGJjYyBm
cmFtZXdvcmsgaXMgbm90IGEgcmVjb21tZW5kYXRpb24gZm9yIHdyaXRpbmcgYnBmIHByb2dyYW0s
IHNvIGJwZnRyYWNlIGlzIG5vdyBtaWdyYXRpbmcKPj4gZnJvbSBiY2MgZnJhbWV3b3JrIHRvIGxp
YmJwZi4gQmNjIGZyYW1ld29yayBwcm92aWRlcyBzb21lIHJlbGV2YW50IEFQSXMgZm9yIGdldCB1
c2R0IHByb2JlIGluZm9bMV0uCj4+IEFuZCBJIGZvdW5kIHRoYXQgdGhlcmUgaXMgbm90IHNpbWls
YXIgQVBJcyBpbiBsaWJicGYsIHRoZXJlZm9yZSBJIGhhdmUgdG8gcGFyc2UgZWxmIGZpbGUgbWFu
dWFsbHkuCj4+Cj4+IENvdWxkIHdlIGFkZCBzb21lIHJlbGV2YW50IEFQSXMsIG1heWJlIGxpa2Ug
YGJwZl9wcm9ncmFtX191c2R0X3Byb2JlX2xpc3RgLCBpbiBsaWJicGY/IEkgY2FuIG1ha2UKPj4g
YSBwYXRjaCB0byBpbXBsZW1lbnQgaXQuIFdEWVQ/Cj4+Cj4KPkknbSBub3QgeWV0IGNvbnZpbmNl
ZCB0aGlzIGJlbG9uZ3MgaW4gbGliYnBmLCB0YmguIFRoZSBwcm9jZXNzIG9mCj5kaXNjb3Zlcmlu
ZyBVU0RUcyBhY3R1YWxseSBpbnZvbHZlZCB0d28gc2VwYXJhdGUgdGFza3M6IGRpc2NvdmVyaW5n
Cj5iaW5hcmllcyAoZXhlY3V0YWJsZSBhbmQgc2hhcmVkIGxpYnMpIHRoYXQgY29uc3RpdHV0ZSBh
IHByb2Nlc3MsIGFuZAo+dGhlbiBmb3IgZWFjaCBiaW5hcnkgZGlzY292ZXJpbmcgd2hpY2ggVVNE
VHMgYmVsb25nIHRvIGl0LiBUaGUgZmlyc3QKPnBhcnQgaXMgcHJldHR5IGNsZWFybHkgb3V0IG9m
IHNjb3BlIGZvciBsaWJicGYuIFNlY29uZCBvbmUgaW4KPnByaW5jaXBsZSBjYW4gYmUgYWRkZWQs
IGJ1dCBhcyBJIHNhaWQgSSdtIGEgYml0IGhlc2l0YW50IGF0IHRoaXMKPnBvaW50LCBhcyB3ZSBk
b24ndCBldmVuIGhhdmUgIlVTRFQgbWFuYWdlciIgZXhwb3NlZCB0aHJvdWdoIHB1YmxpYwo+QVBJ
Lgo+Cj5TbyBub3QgeWV0Lgo+Cj4+Cj4+IFsxXS4gaHR0cHM6Ly9naXRodWIuY29tL2JwZnRyYWNl
L2JwZnRyYWNlL2Jsb2IvMWNkNGJiZGQ0YTEzZGQ1NTg4MGYyY2M2MzhkZGU2NDFmYjVmODQ3NC9z
cmMvdXNkdC5jcHAjTDEzMUMxLUwxNTJDMgo+Pgo+Pgo+Pgo+Pgo+Pgo+Pgo+Pgo+PiBBdCAyMDI1
LTA4LTIxIDA3OjAwOjM1LCAiQW5kcmlpIE5ha3J5aWtvIiA8YW5kcmlpLm5ha3J5aWtvQGdtYWls
LmNvbT4gd3JvdGU6Cj4+ID5PbiBNb24sIEF1ZyAxOCwgMjAyNSBhdCAxMDozNeKAr0FNIFlvbmdo
b25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXguZGV2PiB3cm90ZToKPj4gPj4KPj4gPj4KPj4g
Pj4KPj4gPj4gT24gOC8xNy8yNSA2OjQzIEFNLCDotbXkvbPngpwgd3JvdGU6Cj4+ID4+ID4KPj4g
Pj4gPgo+PiA+PiA+Cj4+ID4+ID4KPj4gPj4gPgo+PiA+PiA+Cj4+ID4+ID4gSGksIFlvbmdob25n
LiBJJ3ZlIGFscmVhZHkgZmlsZWQgYW4gaXNzdWVbMV0gaW4gR0NDICBjb21tdW5pdHkuCj4+ID4+
ID4KPj4gPj4gPgo+PiA+PiA+IEFjY3JvZGluZyB0byB0aGUgZGlzY3Vzc2lvbiwgaXQncyBub3Qg
YSBnY2MgYnVnIGJ1dCBtYXkgYmUgYSBzeXN0ZW10YXAgYnVnLgo+PiA+PiA+IEkgZG9uJ3Qga25v
dyBob3cgdG8gcmVwb3J0IHRoaXMgYnVnIHRvIHN5c3RlbXRhcCwgYnV0IEkgZm91bmQgdGhhdCB0
aGUKPj4gPj4gPiBsaWJicGYvdXNkdCBoYXZlIHRoZSBzYW1lIHByb2JsZW0uIEkndmUgZmlsZWQg
YW4gaXNzdWUgaW4gbGliYnBmL3VzZHQgcmVwb1syXS4KPj4gPj4gPgo+PiA+PiA+IEkgYWxzbyBo
YXZlIHNvbWUgaWRlYXMgYWJvdXQgaXQuIEkgd3JvdGUgaXQgZG93biBpbiB0aGUgaXNzdWVbMl0g
Y29tbWVudC4KPj4gPj4gPiBNYXkgYmUgd2UgY2FuIGRpc2N1c3MgdGhlcmUuCj4+ID4+ID4KPj4g
Pj4gPiBbMV0uIGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTEy
MTU2OQo+PiA+PiA+IFsyXS4gaHR0cHM6Ly9naXRodWIuY29tL2xpYmJwZi91c2R0L2lzc3Vlcy8x
Mwo+PiA+Pgo+PiA+PiBUaGFua3MgZm9yIGZpbGluZyBhbiBpc3N1ZSBvbiBnY2MgYW5kIGdldHRp
bmcgc29tZSBmZWVkYmFjay9zdWdnZXN0aW9ucwo+PiA+PiBmcm9tIGdjYyBjb21tdW5pdHkuCj4+
ID4+Cj4+ID4+IEN1cnJlbnRseSwgbGliYnBmL3VzZHQgZG9lcyBub3Qgc3Vwb3J0IGZvcm1hdCBs
aWtlICctMUB0aSglcmlwKScuIElmIHdlIGRvCj4+ID4KPj4gPkV4YWN0bHksIGl0IGRvZXNuJ3Qu
IEkgaGF2ZW4ndCB5ZXQgcmFuIGludG8gYSBjYXNlIHdoZXJlIHJlYWwtd29ybGQKPj4gPmFwcGxp
Y2F0aW9ucyB3b3VsZCB1c2Ugc3VjaCBhbiBhcmd1bWVudCBmb3JtYXQsIHNvIHRoZXJlIHdhcyBu
bwo+PiA+aW5jZW50aXZlIGluIHRyeWluZyB0byBzdXBwb3J0IGl0Lgo+PiA+Cj4+ID5XYXMgdGhp
cyBpc3N1ZSBkaXNjb3ZlcmVkIGFzIHBhcnQgb2YgdGVzdGluZyBvbiBzb21lIHJlYWwgd29ybGQK
Pj4gPmFwcGxpY2F0aW9uLCBvciBpdCdzIG1vc3RseSB0aHJvdWdoIHRlc3Rpbmcgb24gc3ludGhl
dGljIGNhc2VzPwo+PiA+Cj4+ID4+IGludGVuZCB0byBpbXBsZW1lbnQgdGhpcy4gbGliYnBmL3Vz
ZHQgY2FuIHJlamVjdCB0aGF0IGlmICd0aScgaXMgYQo+PiA+PiBzdGF0aWMgdmFyaWFibGUuIGxp
YmJwZiBjYW4gcHJvdmlkZSBzb21lIGhpbnRzIGFib3V0IGhvdyB0byBtYWtlIGl0Cj4+ID4+IHdv
cmsgKHNlZSBhYm92ZSBbMV0gYW5kIFsyXSkuIFRoZW4sIGl0IHdvdWxkIGJlIHVzZXIncyByZXBv
bnNpYmlsaXR5IHRvCj4+ID4+IGNoYW5nZSBjb2RlIHNvIGxpYmJwZiBjYW4gc3VwcG9ydCBpdC4K
Pj4gPj4KPj4gPj4gPgo+PiA+PiA+Cj4+ID4+ID4KPj4gPgo+PiA+Wy4uLl0K

