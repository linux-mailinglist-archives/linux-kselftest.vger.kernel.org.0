Return-Path: <linux-kselftest+bounces-44003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8BEC073D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2A69565E69
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606C336EC8;
	Fri, 24 Oct 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XyG+AKVJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787311F03EF;
	Fri, 24 Oct 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322417; cv=none; b=Ix/ihqNBMZgTq0pQtB3NNoqaMiY31kMzjBYs2a6Fd2e2hTQpkodl5s3ZxPDvDpmww1Rp7KjHjqj9minkeck/0JCnimeYyBi29kduSQNhfGa0vEYy0Qtfi144ixDEGr/NJhyFZ6muApIajNZen5J1g3akLeNmS27tcC+oHEvXrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322417; c=relaxed/simple;
	bh=CpGJCR5GrHZAy/E9dvgxNwyLC6bZSH7ZV1VpCx8P21g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFQLbJzwk8Irg+HDG+DkNc33ZZ5EPF/k82waZfQrkTSykagWVzNEpsbXZBRlY76iMXbErgAVwuni8SpvRGVGvKYU0olt16GRcG7sAlJ40Fh8FVD2byXtqoPiuMh9bI2TlZO8ujw+taiNnSdm0ZmYtPqz0lKciISNkwyPGGYO2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XyG+AKVJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761322412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpGJCR5GrHZAy/E9dvgxNwyLC6bZSH7ZV1VpCx8P21g=;
	b=XyG+AKVJzongeO1way5/7Nhm+FdVRnCzUvd2DCS0MRmr1FJ8msK7RDMCE0xvJoIwMObCnS
	yyhrUFMLxJmROnaJZzNtIEjxpqx1lWDm0VmozsUQBUVgqhvs2WkKwefneii26eskxpRhcs
	3uv/TlMG+qoKrJ4agvkYRXaygai4MTE=
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
 colin.i.king@gmail.com, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Sat, 25 Oct 2025 00:13:19 +0800
In-Reply-To: <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
	 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
	 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
	 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

T24gVGh1LCAyMDI1LTEwLTIzIGF0IDEwOjM4IC0wNzAwLCBFZHVhcmQgWmluZ2VybWFuIHdyb3Rl
Ogo+IE9uIFRodSwgMjAyNS0xMC0yMyBhdCAxOToyNiArMDgwMCwgS2FGYWkgV2FuIHdyb3RlOgo+
IAo+IFsuLi5dCj4gCj4gPiA+IEBAIC0xNjE3Myw2ICsxNjE3MywyNSBAQCBzdGF0aWMgaW50IGlz
X3BrdF9wdHJfYnJhbmNoX3Rha2VuKHN0cnVjdAo+ID4gPiBicGZfcmVnX3N0YXRlICpkc3RfcmVn
LAo+ID4gPiDCoHN0YXRpYyBpbnQgaXNfYnJhbmNoX3Rha2VuKHN0cnVjdCBicGZfcmVnX3N0YXRl
ICpyZWcxLCBzdHJ1Y3QgYnBmX3JlZ19zdGF0ZQo+ID4gPiAqcmVnMiwKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OCBvcGNvZGUsIGJv
b2wgaXNfam1wMzIpCj4gPiA+IMKgewo+ID4gPiArwqDCoMKgwqDCoMKgIGlmIChyZWcxID09IHJl
ZzIpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoIChvcGNvZGUp
IHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBCUEZfSkdFOgo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEJQRl9KTEU6Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pTR0U6Cj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pTTEU6Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pFUToKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2FzZSBCUEZfSlNFVDoKPiA+IAo+ID4gT3RoZXJzIGFyZSBmaW5lLCBidXQgQlBGX0pT
RVQgb24gdGhlIHNhbWUgcmVnaXN0ZXIgY291bGQgYmUgMCAoaWYgdmFsdWUgaXMgMCkuCj4gPiBB
bmQgaXQncyB1bmtub3duIHRvIHRha2UgdGhlIGJyYW5jaCBpZiAwIHdpdGhpbiB0aGUgcmFuZ2Uu
Cj4gCj4gUmlnaHQsIG1pc3NlZCB0aGF0IG9uZS4KPiAKPiA+IAo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDE7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pHVDoKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY2FzZSBCUEZfSkxUOgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjYXNlIEJQRl9KU0dUOgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIEJQRl9KU0xUOgo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNl
IEJQRl9KTkU6Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVs
dDoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtMTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiArwqDC
oMKgwqDCoMKgIH0KPiA+ID4gCj4gPiA+IEJ1dCB0aGF0J3MgdG9vIG11Y2ggY29kZSBmb3IgYW4g
YXJ0aWZpY2lhbCBjYXNlLgo+ID4gPiBJZGssIGVpdGhlciB3YXkgaXMgZmluZSB3aXRoIG1lLgo+
ID4gCj4gPiBUaGVyZSBpcyBpc19zY2FsYXJfYnJhbmNoX3Rha2VuKCkgaW4gaXNfYnJhbmNoX3Rh
a2VuKCksIEkgbWlzc2VkIGl0LiBJJ2xsIGEpCj4gPiBjaGVjayB0aGUgb3Bjb2RlIG9uZSBieSBv
bmUgaW4gaXNfc2NhbGFyX2JyYW5jaF90YWtlbigpLCBhbmQgYikga2VlcCB0aGlzIHBhdGNoCj4g
PiBmb3IgdW5rbm93biBCUEZfSlNFVCBicmFuY2guCj4gCj4gU291bmRzIGdvb2QgdG8gbWUuIE5v
dGUgdGhhdCB0aGUgbG9naWMgaXMgY29ycmVjdCBmb3IgYm90aCBzY2FsYXIgYW5kCj4gbm9uLXNj
YWxhciBjYXNlcywgc28gSSBkb24ndCB0aGluayB3ZSBoYXZlIHRvIGNvbnN0cmFpbiBpdCB0bwo+
IGlzX3NjYWxhcl9icmFuY2hfdGFrZW4oKSAoZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSBuZWVkIHRv
IGNoZWNrIGlmCj4gcG9pbnRlciBjb21wYXJpc29ucyBhcmUgYWxsb3dlZCwgYXMgbm8gbmV3IGlu
Zm9ybWF0aW9uIGlzIGluZmVycmVkCj4gZnJvbSBjb21wYXJpc29ucyB3aXRoIHNlbGYpLgoKRm9y
IG5vbi1zY2FsYXIgY2FzZXMgd2Ugb25seSBhbGxvdyBwb2ludGVyIGNvbXBhcmlzb24gb24gcGt0
X3B0ciwgdGhpcyBjaGVjayBpcyBiZWZvcmUKaXNfYnJhbmNoX3Rha2VuKCkKCglzcmNfcmVnID0g
JnJlZ3NbaW5zbi0+c3JjX3JlZ107CglpZiAoIShyZWdfaXNfcGt0X3BvaW50ZXJfYW55KGRzdF9y
ZWcpICYmIHJlZ19pc19wa3RfcG9pbnRlcl9hbnkoc3JjX3JlZykpICYmCgkgICAgaXNfcG9pbnRl
cl92YWx1ZShlbnYsIGluc24tPnNyY19yZWcpKSB7CgkJdmVyYm9zZShlbnYsICJSJWQgcG9pbnRl
ciBjb21wYXJpc29uIHByb2hpYml0ZWRcbiIsCgkJCWluc24tPnNyY19yZWcpOwoJCXJldHVybiAt
RUFDQ0VTOwoJfSAKCmFuZCBpbiB0aGUgZW5kIG9mIGNoZWNrX2NvbmRfam1wX29wKCkgKGFmdGVy
IGlzX2JyYW5jaF90YWtlbigpKSwgd2UgY2hlY2tlZCBhZ2FpbgoKCX0gZWxzZSBpZiAoIXRyeV9t
YXRjaF9wa3RfcG9pbnRlcnMoaW5zbiwgZHN0X3JlZywgJnJlZ3NbaW5zbi0+c3JjX3JlZ10sCgkJ
CQkJICAgdGhpc19icmFuY2gsIG90aGVyX2JyYW5jaCkgJiYKCQkgICBpc19wb2ludGVyX3ZhbHVl
KGVudiwgaW5zbi0+ZHN0X3JlZykpIHsKCQl2ZXJib3NlKGVudiwgIlIlZCBwb2ludGVyIGNvbXBh
cmlzb24gcHJvaGliaXRlZFxuIiwKCQkJaW5zbi0+ZHN0X3JlZyk7CgkJcmV0dXJuIC1FQUNDRVM7
Cgl9Cgp0aGlzIHRpbWUgd2XCoGNoZWNrIGlmIGl0IGlzIHZhbGlkIGNvbXBhcmlzb24gb24gcGt0
X3B0ciBpbiB0cnlfbWF0Y2hfcGt0X3BvaW50ZXJzKCkuwqAKCkN1cnJlbnRseSB3ZSBqdXN0IGFs
bG93IDQgb3Bjb2RlIChCUEZfSkdULCBCUEZfSkxULCBCUEZfSkdFLCBCUEZfSkxFKSBvbiBwa3Rf
cHRyLCBhbmQgd2l0aApjb25kaXRpb25zLiBCdXQgd2UgYnlwYXNzIHRoZXNlIHByb2hpYml0cyBp
biBwcml2aWxlZ2VkIG1vZGUgKGlzX3BvaW50ZXJfdmFsdWUoKSBhbHdheXPCoApyZXR1cm4gZmFs
c2UgaW4gcHJpdmlsZWdlZCBtb2RlKS4KClNvIHRoZSBsb2dpYyBza2lwIHRoZXNlIHByb2hpYml0
cyBmb3IgcGt0X3B0ciBpbiB1bnByaXZpbGVnZWQgbW9kZS4KCi0tIApUaGFua3MsCkthRmFpCg==


