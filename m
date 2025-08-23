Return-Path: <linux-kselftest+bounces-39778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5505EB326B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CB75867C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBF1F4E34;
	Sat, 23 Aug 2025 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="XhUexk+9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5146B5;
	Sat, 23 Aug 2025 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921095; cv=none; b=GHnbuJ9+VPI41+1ISkurq2rAyOBtHIOLN7Nwnzb2gYMzYi23XYenOmKSngulT/rMjuKEHt7CaECsUFT0nTp/6CsvzU/xTqmTFSNwiLYyyoqT60OLBP0ywMSFKwZWZsqU4Lf0m7KwYdzRm4xxyAb8lGxj87tQG+gh52khUoE6Vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921095; c=relaxed/simple;
	bh=1TISuDhLdnS+PrYh6dlwKmizrs0fxQnxYYNpzrEysu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DJhorS+V/FIRwr2E2ZBzsOfxIjrW4jHV4+6+OgR3GHiiD7UcnWBWKeszV7FVTKiLi7Tp3ao3b40NMCVJ0zm0kPOOaNT73w75Ygx/TnbXbnYTm2+3sp2c+9RaycWcnVoGhX1qo4JfEQHuL7kcYDjux8BDJA/gYPrrfibsAsn2E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=XhUexk+9 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Sr/6dPBvtGY/3P5o6WjCBqERoXf2pdxCs4QnO4LtHRo=; b=X
	hUexk+9Vuxsf3ikBU7nFCejW1idoAZ5IlMb+jAhd1TV4stgnxAMHh/q+XYsA39OF
	eap3TaM2sAaaV/wNcpq73x8+T16/rCJPujjIK42qZbsybYlXpEzupl+bb2SFyb3B
	w4o7HHNfUvWoaXo5f/sove/vbrUVmnmnZAlmGLAals=
Received: from phoenix500526$163.com ( [120.230.124.83] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Sat, 23 Aug 2025 11:51:02 +0800
 (CST)
Date: Sat, 23 Aug 2025 11:51:02 +0800 (CST)
From: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH bpf-next v13 2/2] selftests/bpf: Enrich
 subtest_basic_usdt case in selftests to cover SIB handling logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAEf4Bzbs3hV_Q47+d93tTX13WkrpkpOb4=U04mZCjHyZg4aVdw@mail.gmail.com>
References: <20250822151611.1084244-1-phoenix500526@163.com>
 <20250822151611.1084244-3-phoenix500526@163.com>
 <CAEf4Bzbs3hV_Q47+d93tTX13WkrpkpOb4=U04mZCjHyZg4aVdw@mail.gmail.com>
X-NTES-SC: AL_Qu2eB/WZvkgt5CScY+kfmUsVh+o9X8K1vfsk3oZfPJp+jCzp0SwFYFhTLVD49dCDIgW9tQiHaDhx9f1hb5l+dKgnOJ7oxIpGqVwNkj0wKXZNOQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3045f879.119d.198d50d1a35.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3twWnOqloIR8gAA--.14307W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawmyiGipMysgqAADsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCj4+ICsgICAgICAgICAgICAgICBTVEFQX1BST0JFX0FTTSh0ZXN0LCB1c2R0X3NpYiwg
LTJAKCUlcmR4LCUlcmF4LDIpKQoKCkkgdGhpbmsgc3VjaCBoYXJkLWNvZGluZywgZm9yIGV4YW1w
bGUgLTJAKCUlcmR4LCUlcmF4LDIpLCBpcyBub3QgdmVyeSBtYWludGFpbmFibGUuCkVzc2VudGlh
bGx5LCBTVEFQX1BST0JFX0FTTSBqdXN0IHBlcmZvcm1zIHNpbXBsZSB0ZXh0IHN1YnN0aXR1dGlv
bi4gQnV0IGluIFNJQiBhZGRyZXNzaW5nLApib3RoIHNjYWxlIGFuZCBzaXplIGRlcGVuZCBvbiB0
aGUgYWN0dWFsIHBhcmFtZXRlciB0eXBlLgoKRm9yIGluc3RhbmNlLCBpbiAtMkAoJSVyZHgsJSVy
YXgsMiksIHRoZSAtMiBhbmQgMiBjb21lIGZyb20gdGhlIGZhY3QgdGhhdCBudW1zIGlzIGFuCmFy
cmF5IG9mIHR5cGUgc2hvcnQ6IHRoZSBzaXplIG9mIGEgc2hvcnQgaXMgMiwgc28gdGhlIHNjYWxl
IGlzIDI7IGFuZCBzaW5jZSBzaG9ydCBpcyBhIHNpZ25lZCB0eXBlLAp0aGUgc2l6ZSBpcyAtMi4K
ClNUQVBfUFJPQkVfQVNNIGlzIGV4cGFuZGVkIGF0IHRoZSBwcmVwcm9jZXNzaW5nIHN0YWdlLCB3
aGlsZSBhdCB0aGF0IHN0YWdlIHdlIGNhbm5vdApjb21wdXRlIHRoZSBhY3R1YWwgc2l6ZSBvZiBu
dW1zLiBJZiB0aGUgdHlwZSBvZiBudW1zIGNoYW5nZXMgaW4gdGhlIGZ1dHVyZSwgaXQgY291bGQg
bGVhZCB0byBlcnJvcnMuCgoKCkF0IDIwMjUtMDgtMjMgMDY6NTk6NDksICJBbmRyaWkgTmFrcnlp
a28iIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToKPk9uIEZyaSwgQXVnIDIyLCAy
MDI1IGF0IDg6MTbigK9BTSBKaWF3ZWkgWmhhbyA8cGhvZW5peDUwMDUyNkAxNjMuY29tPiB3cm90
ZToKPj4KPj4gV2hlbiB1c2luZyBHQ0Mgb24geDg2LTY0IHRvIGNvbXBpbGUgYW4gdXNkdCBwcm9n
IHdpdGggLU8xIG9yIGhpZ2hlcgo+PiBvcHRpbWl6YXRpb24sIHRoZSBjb21waWxlciB3aWxsIGdl
bmVyYXRlIFNJQiBhZGRyZXNzaW5nIG1vZGUgZm9yIGdsb2JhbAo+PiBhcnJheSBhbmQgUEMtcmVs
YXRpdmUgYWRkcmVzc2luZyBtb2RlIGZvciBnbG9iYWwgdmFyaWFibGUsCj4+IGUuZy4gIjFALTk2
KCVyYnAsJXJheCw4KSIgYW5kICItMUA0K3QxKCVyaXApIi4KPj4KPj4gSW4gdGhpcyBwYXRjaDoK
Pj4gLSBlbnJpY2ggc3VidGVzdF9iYXNpY191c2R0IHRlc3QgY2FzZSB0byBjb3ZlciBTSUIgYWRk
cmVzc2luZyB1c2R0IGFyZ3VtZW50IHNwZWMKPj4gICBoYW5kbGluZyBsb2dpYwo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKaWF3ZWkgWmhhbyA8cGhvZW5peDUwMDUyNkAxNjMuY29tPgo+PiAtLS0KPj4g
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZHQuYyB8IDQ0ICsrKysr
KysrKysrKysrKysrKy0KPj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0
X3VzZHQuYyB8IDMwICsrKysrKysrKysrKysKPj4gIDIgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZHQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL3VzZHQuYwo+PiBpbmRleCA5MDU3ZTk4M2NjNTQuLmMwNGI0MTZhYTRh
OCAxMDA2NDQKPj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
dXNkdC5jCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Vz
ZHQuYwo+PiBAQCAtMjUsNiArMjUsMTAgQEAgdW5zaWduZWQgc2hvcnQgdGVzdF91c2R0MF9zZW1h
cGhvcmUgU0VDKCIucHJvYmVzIik7Cj4+ICB1bnNpZ25lZCBzaG9ydCB0ZXN0X3VzZHQzX3NlbWFw
aG9yZSBTRUMoIi5wcm9iZXMiKTsKPj4gIHVuc2lnbmVkIHNob3J0IHRlc3RfdXNkdDEyX3NlbWFw
aG9yZSBTRUMoIi5wcm9iZXMiKTsKPj4KPj4gKyNpZiAoKGRlZmluZWQoX194ODZfNjRfXykgfHwg
ZGVmaW5lZChfX2kzODZfXykpICYmIGRlZmluZWQoX19HTlVDX18pICYmICFkZWZpbmVkKF9fY2xh
bmdfXykpCj4KPmRvZXMgY2xhbmcgZGVmaW5lIF9fR05VQ19fIGFzIHdlbGw/IG90aGVyd2lzZSB3
aHkgIWRlZmluZShfX2NsYW5nX18pID8KPgo+PiArdW5zaWduZWQgc2hvcnQgdGVzdF91c2R0X3Np
Yl9zZW1hcGhvcmUgU0VDKCIucHJvYmVzIik7Cj4+ICsjZW5kaWYKPj4gKwo+PiAgc3RhdGljIHZv
aWQgX19hbHdheXNfaW5saW5lIHRyaWdnZXJfZnVuYyhpbnQgeCkgewo+PiAgICAgICAgIGxvbmcg
eSA9IDQyOwo+Pgo+PiBAQCAtNDAsMTIgKzQ0LDI5IEBAIHN0YXRpYyB2b2lkIF9fYWx3YXlzX2lu
bGluZSB0cmlnZ2VyX2Z1bmMoaW50IHgpIHsKPj4gICAgICAgICB9Cj4+ICB9Cj4+Cj4+ICsjaWYg
KChkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19pMzg2X18pKSAmJiBkZWZpbmVkKF9f
R05VQ19fKSAmJiAhZGVmaW5lZChfX2NsYW5nX18pKQo+PiArc3RhdGljIF9fYXR0cmlidXRlX18o
KG9wdGltaXplKCJPMSIpKSkgdm9pZCB0cmlnZ2VyX3NpYl9zcGVjKHZvaWQpCj4KPnlvdSB1c2Ug
YXNzZW1ibHkgZGlyZWN0bHksIHNvIG9wdGltaXplKCkgc2hvdWxkIGJlIGlycmVsZXZhbnQsIG5v
Pwo+Cj5TbyB3ZSBjYW4gbWFrZSB0aGlzIG5vbi1HQ0Mgc3BlY2lmaWMsIHJpZ2h0Pwo+Cj4+ICt7
Cj4+ICsgICAgICAgLyogQmFzZSBhZGRyZXNzICsgb2Zmc2V0ICsgKGluZGV4ICogc2NhbGUpICov
Cj4+ICsgICAgICAgLyogRm9yY2UgU0lCIGFkZHJlc3Npbmcgd2l0aCBpbmxpbmUgYXNzZW1ibHkg
Ki8KPj4gKyAgICAgICBhc20gdm9sYXRpbGUoCj4+ICsgICAgICAgICAgICAgICAiIyBwcm9iZSBw
b2ludCB3aXRoIG1lbW9yeSBhY2Nlc3NcbiIKPj4gKyAgICAgICAgICAgICAgIFNUQVBfUFJPQkVf
QVNNKHRlc3QsIHVzZHRfc2liLCAtMkAoJSVyZHgsJSVyYXgsMikpCj4KPmlzIGl0IGd1YXJhbnRl
ZWQgdGhhdCBudW1zIGFkZHJlc3Mgd2lsbCBlbmQgdXAgaW4gcmR4IGFuZCBhIGluIHJheD8uLi4K
Pgo+SSdkIGZlZWwgbW9yZSBjb21mb3J0YWJsZSBpZiB5b3UgZXhwbGljaXRseSBzZXQgdXAgcmR4
IGFuZCByYXggaW4KPmFzc2VtYmx5LCB0aGVuIGFkZCBVU0RUIHdpdGggU1RBUF9QUk9CRV9BU00u
IFRoYXQgc2hvdWxkIGJlIHBvc3NpYmxlCj53aXRoIGVtYmVkZGVkIGFzc2VtYmx5LCBubz8KPgo+
PiArICAgICAgICAgICAgICAgIiMgZW5kIHByb2JlIHBvaW50Igo+Cj53aHkgdGhlc2UgdW5uZWNl
c3NhcnkgY29tbWVudHMgZW1iZWRkZWQgaW4gdGhlIGFzc2VtYmx5Py4uLgo+Cj4+ICsgICAgICAg
ICAgICAgICA6Cj4+ICsgICAgICAgICAgICAgICA6ICJkIihudW1zKSwgImEiKDApCj4+ICsgICAg
ICAgICAgICAgICA6ICJtZW1vcnkiCj4+ICsgICAgICAgKTsKPj4gK30KPgo+Wy4uLl0KPgo+PiAr
Cj4+ICtpbnQgdXNkdF9zaWJfY2FsbGVkOwo+PiArdTY0IHVzZHRfc2liX2Nvb2tpZTsKPj4gK2lu
dCB1c2R0X3NpYl9hcmdfY250Owo+PiAraW50IHVzZHRfc2liX2FyZ19yZXQ7Cj4+ICt1NjQgdXNk
dF9zaWJfYXJnOwo+PiAraW50IHVzZHRfc2liX2FyZ19zaXplOwo+PiArCj4+ICsvLyBOb3RlOiB1
c2R0X3NpYiBpcyBvbmx5IHRlc3RlZCBvbiB4ODYtcmVsYXRlZCBhcmNoaXRlY3R1cmVzLCBzbyBp
dCByZXF1aXJlcwo+PiArLy8gbWFudWFsIGF0dGFjaCBzaW5jZSBhdXRvLWF0dGFjaCB3aWxsIHBh
bmljIHRlc3RzIHVuZGVyIG90aGVyIGFyY2hpdGVjdHVyZXMKPgo+ZG9uJ3QgdXNlIGMrKyBzdHls
ZSBjb21tZW50cwo+Cj4+ICtTRUMoInVzZHQiKQo+PiAraW50IHVzZHRfc2liKHN0cnVjdCBwdF9y
ZWdzICpjdHgpCj4+ICt7Cj4+ICsgICAgICAgbG9uZyB0bXA7Cj4+ICsKPj4gKyAgICAgICBpZiAo
bXlfcGlkICE9IChicGZfZ2V0X2N1cnJlbnRfcGlkX3RnaWQoKSA+PiAzMikpCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMDsKPj4gKwo+PiArICAgICAgIF9fc3luY19mZXRjaF9hbmRfYWRkKCZ1
c2R0X3NpYl9jYWxsZWQsIDEpOwo+PiArCj4+ICsgICAgICAgdXNkdF9zaWJfY29va2llID0gYnBm
X3VzZHRfY29va2llKGN0eCk7Cj4+ICsgICAgICAgdXNkdF9zaWJfYXJnX2NudCA9IGJwZl91c2R0
X2FyZ19jbnQoY3R4KTsKPj4gKwo+PiArICAgICAgIHVzZHRfc2liX2FyZ19yZXQgPSBicGZfdXNk
dF9hcmcoY3R4LCAwLCAmdG1wKTsKPj4gKyAgICAgICB1c2R0X3NpYl9hcmcgPSAoc2hvcnQpdG1w
Owo+PiArICAgICAgIHVzZHRfc2liX2FyZ19zaXplID0gYnBmX3VzZHRfYXJnX3NpemUoY3R4LCAw
KTsKPj4gKwo+PiArICAgICAgIHJldHVybiAwOwo+PiArfQo+PiArCj4+ICBjaGFyIF9saWNlbnNl
W10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsKPj4gLS0KPj4gMi40My4wCj4+Cg==

