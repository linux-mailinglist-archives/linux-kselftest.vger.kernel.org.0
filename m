Return-Path: <linux-kselftest+bounces-44630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA2C2A2B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 07:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A03AC4DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 06:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9F28DEE9;
	Mon,  3 Nov 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gzUUfsj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38D154BE2
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151044; cv=none; b=ukDmfIwLS7EevsTJFlIbuMoFcPApEUod9S/GTMY1QCYtyrsZZaSnv8Aj9iuL24m4RYQ2Yue/twpobqvdhH+26ioPcdd0+MCslCS2LowMHwBTXX6e1cFODt50b37hXW1LLwd6ILyvN68ELb8P7sC1iKfvFnJAVKqujFEgQxtBmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151044; c=relaxed/simple;
	bh=WTaKpLvTjt4nUuQt9UAtDrAjwa0SikWZXQFh6O2+IeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gff7ySxRgrD4LaQ+2KNMFSrI8Pr5KCqVTT1T5QE9zEup0CunbVuSeJEDlZ1Lk6YhLBx0kxyujiSl/UHOp2mtj8tMfuTfaWK7wjJ42LJBygVc71mEyTytzAiMUSQhoAgzg66TfZNiB/TG6PsEEl0bYoHGICm9bDq9url/Td1sRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gzUUfsj/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7df70d3be4043296471f3cd3267898f953985d9a.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762151030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTaKpLvTjt4nUuQt9UAtDrAjwa0SikWZXQFh6O2+IeA=;
	b=gzUUfsj/fpRCUVEd+stNrAlAIx6WukwkBKUN6cdU8BXB6bc5iuOFhYHd2iJ0E2E+NruhAe
	ZDThNdUJApFoCyPPedqvzE1SEbk8PPwQvqz1P2damHKbAdK8Gcrxbee35ZUVzWQ4Z+KlIz
	+RejTO0uHrTQvijeeFTlqEn2ld7zMfo=
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same scalar register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
 <paul.chaignon@gmail.com>, Matan Shachnai <m.shachnai@gmail.com>, Henriette
 Herzog <henriette.herzog@rub.de>, Luis Gerhorst <luis.gerhorst@fau.de>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 colin.i.king@gmail.com, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Mon, 03 Nov 2025 14:23:21 +0800
In-Reply-To: <CAADnVQ+4QoCU4gYEfTR6Ok122zkfG32s8AxRx-irMcCA1jEhvQ@mail.gmail.com>
References: <20251031154107.403054-1-kafai.wan@linux.dev>
	 <20251031154107.403054-2-kafai.wan@linux.dev>
	 <CAADnVQ+4QoCU4gYEfTR6Ok122zkfG32s8AxRx-irMcCA1jEhvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

T24gRnJpLCAyMDI1LTEwLTMxIGF0IDA5OjM3IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gRnJpLCBPY3QgMzEsIDIwMjUgYXQgODo0NOKAr0FNIEthRmFpIFdhbiA8a2FmYWku
d2FuQGxpbnV4LmRldj4gd3JvdGU6Cj4gPiAKPiA+IFdoZW4gY29uZGl0aW9uYWwganVtcHMgYXJl
IHBlcmZvcm1lZCBvbiB0aGUgc2FtZSBzY2FsYXIgcmVnaXN0ZXIKPiA+IChlLmcuLCByMCA8PSBy
MCwgcjAgPiByMCwgcjAgPCByMCksIHRoZSBCUEYgdmVyaWZpZXIgaW5jb3JyZWN0bHkKPiA+IGF0
dGVtcHRzIHRvIGFkanVzdCB0aGUgcmVnaXN0ZXIncyBtaW4vbWF4IGJvdW5kcy4gVGhpcyBsZWFk
cyB0bwo+ID4gaW52YWxpZCByYW5nZSBib3VuZHMgYW5kIHRyaWdnZXJzIGEgQlVHIHdhcm5pbmcu
Cj4gPiAKPiA+IFRoZSBwcm9ibGVtYXRpYyBCUEYgcHJvZ3JhbToKPiA+IMKgwqAgMDogY2FsbCBi
cGZfZ2V0X3ByYW5kb21fdTMyCj4gPiDCoMKgIDE6IHc4ID0gMHg4MDAwMDAwMAo+ID4gwqDCoCAy
OiByMCAmPSByOAo+ID4gwqDCoCAzOiBpZiByMCA+IHIwIGdvdG8gPGV4aXQ+Cj4gPiAKPiA+IFRo
ZSBpbnN0cnVjdGlvbiAzIHRyaWdnZXJzIGtlcm5lbCB3YXJuaW5nOgo+ID4gwqDCoCAzOiBpZiBy
MCA+IHIwIGdvdG8gPGV4aXQ+Cj4gPiDCoMKgIHRydWVfcmVnMTogcmFuZ2UgYm91bmRzIHZpb2xh
dGlvbiB1NjQ9WzB4MSwgMHgwXSBzNjQ9WzB4MSwgMHgwXSB1MzI9WzB4MSwgMHgwXSBzMzI9WzB4
MSwgMHgwXQo+ID4gdmFyX29mZj0oMHgwLCAweDApCj4gPiDCoMKgIHRydWVfcmVnMjogY29uc3Qg
dG51bSBvdXQgb2Ygc3luYyB3aXRoIHJhbmdlIGJvdW5kcyB1NjQ9WzB4MCwgMHhmZmZmZmZmZmZm
ZmZmZmZmXQo+ID4gczY0PVsweDgwMDAwMDAwMDAwMDAwMDAsIDB4N2ZmZmZmZmZmZmZmZmZmZl0g
dmFyX29mZj0oMHgwLCAweDApCj4gPiAKPiA+IENvbXBhcmluZyBhIHJlZ2lzdGVyIHdpdGggaXRz
ZWxmIHNob3VsZCBub3QgY2hhbmdlIGl0cyBib3VuZHMgYW5kCj4gPiBmb3IgbW9zdCBjb21wYXJp
c29uIG9wZXJhdGlvbnMsIGNvbXBhcmluZyBhIHJlZ2lzdGVyIHdpdGggaXRzZWxmIGhhcwo+ID4g
YSBrbm93biByZXN1bHQgKGUuZy4sIHIwID09IHIwIGlzIGFsd2F5cyB0cnVlLCByMCA8IHIwIGlz
IGFsd2F5cyBmYWxzZSkuCj4gPiAKPiA+IEZpeCB0aGlzIGJ5Ogo+ID4gMS4gRW5oYW5jZSBpc19z
Y2FsYXJfYnJhbmNoX3Rha2VuKCkgdG8gcHJvcGVybHkgaGFuZGxlIGJyYW5jaCBkaXJlY3Rpb24K
PiA+IMKgwqAgY29tcHV0YXRpb24gZm9yIHNhbWUgcmVnaXN0ZXIgY29tcGFyaXNvbnMgYWNyb3Nz
IGFsbCBCUEYganVtcCBvcGVyYXRpb25zCj4gPiAyLiBBZGRzIGVhcmx5IHJldHVybiBpbiByZWdf
c2V0X21pbl9tYXgoKSB0byBhdm9pZCBib3VuZHMgYWRqdXN0bWVudAo+ID4gwqDCoCBmb3IgdW5r
bm93biBicmFuY2ggZGlyZWN0aW9ucyAoZS5nLiwgQlBGX0pTRVQpIG9uIHRoZSBzYW1lIHJlZ2lz
dGVyCj4gPiAKPiA+IFRoZSBmaXggZW5zdXJlcyB0aGF0IHVubmVjZXNzYXJ5IGJvdW5kcyBhZGp1
c3RtZW50cyBhcmUgc2tpcHBlZCwgcHJldmVudGluZwo+ID4gdGhlIHZlcmlmaWVyIGJ1ZyB3aGls
ZSBtYWludGFpbmluZyBjb3JyZWN0IGJyYW5jaCBkaXJlY3Rpb24gYW5hbHlzaXMuCj4gPiAKPiA+
IFJlcG9ydGVkLWJ5OiBLYWl5YW4gTWVpIDxNMjAyNDcyMjEwQGh1c3QuZWR1LmNuPgo+ID4gUmVw
b3J0ZWQtYnk6IFlpbmhhbyBIdSA8ZGRkZGRkQGh1c3QuZWR1LmNuPgo+ID4gQ2xvc2VzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMTg4MWYwZjUuMzAwZGYuMTk5ZjI1NzZhMDEuQ29yZW1h
aWwua2FpeWFubUBodXN0LmVkdS5jbi8KPiA+IFNpZ25lZC1vZmYtYnk6IEthRmFpIFdhbiA8a2Fm
YWkud2FuQGxpbnV4LmRldj4KPiA+IC0tLQo+ID4gwqBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgfCAz
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDMzIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZp
ZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwo+ID4gaW5kZXggNTQyZTIzZmIxOWM3Li5hNTcx
MjYzZjRlYmUgMTAwNjQ0Cj4gPiAtLS0gYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMKPiA+ICsrKyBi
L2tlcm5lbC9icGYvdmVyaWZpZXIuYwo+ID4gQEAgLTE1OTk1LDYgKzE1OTk1LDggQEAgc3RhdGlj
IGludCBpc19zY2FsYXJfYnJhbmNoX3Rha2VuKHN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWcxLCBz
dHJ1Y3QKPiA+IGJwZl9yZWdfc3RhCj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAob3Bj
b2RlKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBjYXNlIEJQRl9KRVE6Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAocmVnMSA9PSByZWcyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIGNvbnN0YW50cywgdW1pbi91bWF4IGFuZCBzbWluL3NtYXggY2hl
Y2tzIHdvdWxkIGJlCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlZHVu
ZGFudCBpbiB0aGlzIGNhc2UgYmVjYXVzZSB0aGV5IGFsbCBzaG91bGQgbWF0Y2gKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiBAQCAtMTYwMjEsNiArMTYwMjMsOCBA
QCBzdGF0aWMgaW50IGlzX3NjYWxhcl9icmFuY2hfdGFrZW4oc3RydWN0IGJwZl9yZWdfc3RhdGUg
KnJlZzEsIHN0cnVjdAo+ID4gYnBmX3JlZ19zdGEKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiDC
oMKgwqDCoMKgwqDCoCBjYXNlIEJQRl9KTkU6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocmVnMSA9PSByZWcyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qIGNvbnN0YW50cywgdW1pbi91bWF4IGFuZCBzbWluL3NtYXggY2hlY2tzIHdvdWxkIGJl
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlZHVuZGFudCBpbiB0aGlz
IGNhc2UgYmVjYXVzZSB0aGV5IGFsbCBzaG91bGQgbWF0Y2gKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICovCj4gPiBAQCAtMTYwNDcsNiArMTYwNTEsMTIgQEAgc3RhdGljIGlu
dCBpc19zY2FsYXJfYnJhbmNoX3Rha2VuKHN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWcxLCBzdHJ1
Y3QKPiA+IGJwZl9yZWdfc3RhCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKg
wqAgY2FzZSBCUEZfSlNFVDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChy
ZWcxID09IHJlZzIpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAodG51bV9pc19jb25zdCh0MSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0MS52YWx1ZSAh
PSAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVs
c2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIChzbWluMSA8PSAwICYmIHNtYXgxID49IDApID8gLTEgOiAxOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmICghaXNfcmVnX2NvbnN0KHJlZzIsIGlzX2ptcDMyKSkgewo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2FwKHJlZzEsIHJl
ZzIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
d2FwKHQxLCB0Mik7Cj4gPiBAQCAtMTYwNTksNDggKzE2MDY5LDY0IEBAIHN0YXRpYyBpbnQgaXNf
c2NhbGFyX2JyYW5jaF90YWtlbihzdHJ1Y3QgYnBmX3JlZ19zdGF0ZSAqcmVnMSwgc3RydWN0Cj4g
PiBicGZfcmVnX3N0YQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsKPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pHVDoKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChyZWcxID09IHJlZzIpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHVtaW4xID4gdW1heDIpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGVsc2UgaWYgKHVtYXgxIDw9IHVtaW4yKQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2UgQlBGX0pT
R1Q6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmVnMSA9PSByZWcyKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAw
Owo+IAo+IFRoaXMgaXMgdWdsaWVyIHRoYW4gdGhlIHByZXZpb3VzIHZlcnNpb24uCj4gcmVnMSA9
PSByZWcyIGlzIGEgc3l6Ym90IHRlcnJpdG9yeS4KPiBXZSBzaG91bGRuJ3QgdWdsaWZ5IHRoZSBj
b2RlIGV2ZXJ5d2hlcmUgYmVjYXVzZSBvZiBpdC4KPiAKb2ssIHdpbGwgdXBkYXRlIGluIHY0Lgo+
IHB3LWJvdDogY3IKCi0tIApUaGFua3MsCkthRmFpCg==


