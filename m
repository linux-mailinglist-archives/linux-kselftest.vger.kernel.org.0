Return-Path: <linux-kselftest+bounces-38940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D942B25C34
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2015C8113
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E625A2C2;
	Thu, 14 Aug 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="gv2boPI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F82571C9;
	Thu, 14 Aug 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154113; cv=none; b=FkYusxxwX4x6VHaNQKlitIg0Ju69FqDkdSo7Uh6On0VKjfXhSFpvWDIp83E9h2iztOxD5zbtGxJ8NOAE3kgL7D4lMFi7NL6lzbgaICInM/BAJ2f2gtqUF2FBsNWAPmJPtdk8GyKIck/BFCTpB9EsXmGeil6prkgI918AIozJxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154113; c=relaxed/simple;
	bh=UeaI+r6RLQaPLS2L41/1GvaQ44iR/OPXvshVJGLJRYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eIxmQPITX1TNrRm9rw6S7ZjNBvdJ7vIU6jvePd3viyqFTZygUgWxCyeVi8yGpE1eQ4jc3aljqMxdTp2VcNwfW69RtzbZDv40/UXy56ygQAH9rptN2QNLFo/LdRAnZf0vq3allvRYtJDUTMS1F/nJuECyOsr5Xsc3lmFUT/6U8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=gv2boPI9 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2L0qUKH/tSWiOlgk1aoo4VVytXAKs8kx/jLyi5XtEAE=; b=g
	v2boPI9aKg1NYYS3P2Kofn1g+EGwaCgFWPgq3tIj2rG4t/ArLRUsObXEMYNyxLef
	uVD72ebNlVtqK+PnIpnQ9s89Gc+0tCAjKgmwHOvoUCkWo5mlFEHE6coc2ks8kr1X
	VktAmePunm5CaboYw0eaPjyH5a1Y/KHBIhC+J++QCk=
Received: from phoenix500526$163.com ( [120.230.124.83] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Thu, 14 Aug 2025 14:48:00 +0800
 (CST)
Date: Thu, 14 Aug 2025 14:48:00 +0800 (CST)
From: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH bpf-next v8 2/2] selftests/bpf: Add an usdt_o2 test
 case in selftests to cover SIB handling logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <CAEf4BzbQ00YtbSqRotMEN4eBJC7aYNy9fFRO-Q_=Z0uS6O06mg@mail.gmail.com>
References: <20250807023430.4566-1-phoenix500526@163.com>
 <20250807023430.4566-3-phoenix500526@163.com>
 <CAEf4BzbQ00YtbSqRotMEN4eBJC7aYNy9fFRO-Q_=Z0uS6O06mg@mail.gmail.com>
X-NTES-SC: AL_Qu2eB/2eu0gj5iCcZekfmUsVh+o9X8K1vfsk3oZfPJp+jCHpwBAmdHNTP3T91tCDJhi2nQiHWxFr6fxIXJdlY7oMKD0hQgR2BLwDdCZGXaGaog==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <10b5dedd.4d59.198a755e12e.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgCHTzqghp1ostAZAA--.1457W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBawWpiGidggVa6QACsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgo+SGF2ZSB5b3UgY29uc2lkZXJlZCB1c2luZyBHQ0MncyBfX2F0dHJpYnV0ZV9fKChvcHRp
bWl6ZSgiTzIiKSkpCj5hdHRyaWJ1dGUuIEl0IHNlZW1zIGxpa2UgQ2xhbmcgZG9lc24ndCBoYXZl
IHN1cHBvcnQgZm9yIHNvbWV0aGluZyBsaWtlCj50aGF0LCBidXQgd2UnbGwgc3RpbGwgaGF2ZSB0
aGlzIGNvdmVyZWQgaW4gQlBGIENJIGZvciBHQ0MtYnVpbHQKPnNlbGZ0ZXN0cy4gVGhlbiBJJ2Qg
anVzdCBhZGQgdGhpcyBhcyBhbm90aGVyIHN1YnRlc3QgdG8gZXhpc3RpbmcgdXNkdAo+dGVzdHMu
Cj4KPkNhbiB5b3UgcGxlYXNlIHRyeSB0aGF0PwoKRG9uZQoKCj5JcyBzZW1hcGhvcmUgZXNzZW50
aWFsIHRvIHRoaXMgdGVzdD8KCgpJdCdzIG5vIGVzc2VudGlhbC4gSSd2ZSBhbHJlYWR5IHJlbW92
ZWQgaXQgaW4gdGhlIG5ldyBwYXRjaC4gCgoKCkF0IDIwMjUtMDgtMTQgMDg6MDQ6MzUsICJBbmRy
aWkgTmFrcnlpa28iIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToKPk9uIFdlZCwg
QXVnIDYsIDIwMjUgYXQgNzozNeKAr1BNIEppYXdlaSBaaGFvIDxwaG9lbml4NTAwNTI2QDE2My5j
b20+IHdyb3RlOgo+Pgo+PiBXaGVuIHVzaW5nIEdDQyBvbiB4ODYtNjQgdG8gY29tcGlsZSBhbiB1
c2R0IHByb2cgd2l0aCAtTzEgb3IgaGlnaGVyCj4+IG9wdGltaXphdGlvbiwgdGhlIGNvbXBpbGVy
IHdpbGwgZ2VuZXJhdGUgU0lCIGFkZHJlc3NpbmcgbW9kZSBmb3IgZ2xvYmFsCj4+IGFycmF5IGFu
ZCBQQy1yZWxhdGl2ZSBhZGRyZXNzaW5nIG1vZGUgZm9yIGdsb2JhbCB2YXJpYWJsZSwKPj4gZS5n
LiAiMUAtOTYoJXJicCwlcmF4LDgpIiBhbmQgIi0xQDQrdDEoJXJpcCkiLgo+Pgo+PiBJbiB0aGlz
IHBhdGNoOgo+PiAtIGFkZCB1c2R0X28yIHRlc3QgY2FzZSB0byBjb3ZlciBTSUIgYWRkcmVzc2lu
ZyB1c2R0IGFyZ3VtZW50IHNwZWMKPj4gICBoYW5kbGluZyBsb2dpYwo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBKaWF3ZWkgWmhhbyA8cGhvZW5peDUwMDUyNkAxNjMuY29tPgo+PiAtLS0KPj4gIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZSAgICAgICAgICB8ICA4ICsrKwo+PiAgLi4u
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy91c2R0X28yLmMgICAgICAgIHwgNzEgKysrKysrKysr
KysrKysrKysrKwo+PiAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF91c2R0X28yLmMgICAg
ICAgIHwgMzcgKysrKysrKysrKwo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMTYgaW5zZXJ0aW9ucygr
KQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3VzZHRfbzIuYwo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3VzZHRfbzIuYwo+Pgo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL01ha2VmaWxlCj4+IGluZGV4IDkxMGQ4ZDY0MDJlZi4uNjhjZjZhOWNmMDVmIDEwMDY0NAo+
PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUKPj4gKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlCj4+IEBAIC03NTksNiArNzU5LDE0IEBA
IFRSVU5ORVJfQlBGX0JVSUxEX1JVTEUgOj0gJCQoZXJyb3Igbm8gQlBGIG9iamVjdHMgc2hvdWxk
IGJlIGJ1aWx0KQo+PiAgVFJVTk5FUl9CUEZfQ0ZMQUdTIDo9Cj4+ICAkKGV2YWwgJChjYWxsIERF
RklORV9URVNUX1JVTk5FUix0ZXN0X21hcHMpKQo+Pgo+PiArIyBVc2UgLU8yIG9wdGltaXphdGlv
biB0byBnZW5lcmF0ZSBTSUIgYWRkcmVzc2luZyB1c2R0IGFyZ3VtZW50IHNwZWMKPj4gKyMgT25s
eSBhcHBseSBvbiB4ODYgYXJjaGl0ZWN0dXJlIHdoZXJlIFNJQiBhZGRyZXNzaW5nIGlzIHJlbGV2
YW50Cj4+ICtpZmVxICgkKEFSQ0gpLCB4ODYpCj4+ICskKE9VVFBVVCkvdXNkdF9vMi50ZXN0Lm86
IENGTEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFHUykpCj4+ICskKE9VVFBVVCkvY3B1djQvdXNk
dF9vMi50ZXN0Lm86IENGTEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFHUykpCj4+ICskKE9VVFBV
VCkvbm9fYWx1MzIvdXNkdF9vMi50ZXN0Lm86IENGTEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFH
UykpCj4+ICtlbmRpZgo+PiArCj4KPkhhdmUgeW91IGNvbnNpZGVyZWQgdXNpbmcgR0NDJ3MgX19h
dHRyaWJ1dGVfXygob3B0aW1pemUoIk8yIikpKQo+YXR0cmlidXRlLiBJdCBzZWVtcyBsaWtlIENs
YW5nIGRvZXNuJ3QgaGF2ZSBzdXBwb3J0IGZvciBzb21ldGhpbmcgbGlrZQo+dGhhdCwgYnV0IHdl
J2xsIHN0aWxsIGhhdmUgdGhpcyBjb3ZlcmVkIGluIEJQRiBDSSBmb3IgR0NDLWJ1aWx0Cj5zZWxm
dGVzdHMuIFRoZW4gSSdkIGp1c3QgYWRkIHRoaXMgYXMgYW5vdGhlciBzdWJ0ZXN0IHRvIGV4aXN0
aW5nIHVzZHQKPnRlc3RzLgo+Cj5DYW4geW91IHBsZWFzZSB0cnkgdGhhdD8KPgo+PiAgIyBEZWZp
bmUgdGVzdF92ZXJpZmllciB0ZXN0IHJ1bm5lci4KPj4gICMgSXQgaXMgbXVjaCBzaW1wbGVyIHRo
YW4gdGVzdF9tYXBzL3Rlc3RfcHJvZ3MgYW5kIHN1ZmZpY2llbnRseSBkaWZmZXJlbnQgZnJvbQo+
PiAgIyB0aGVtIChlLmcuLCB0ZXN0LmggaXMgdXNpbmcgY29tcGxldGVseSBwYXR0ZXJuKSwgdGhh
dCBpdCdzIHdvcnRoIGp1c3QKPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL3VzZHRfbzIuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9w
cm9nX3Rlc3RzL3VzZHRfbzIuYwo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAw
MDAwMDAwMDAuLmYwNGI3NTZiMzY0MAo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZHRfbzIuYwo+PiBAQCAtMCwwICsxLDcx
IEBACj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+PiArLyogQ29weXJp
Z2h0IChjKSAyMDI1IEppYXdlaSBaaGFvIDxwaG9lbml4NTAwNTI2QDE2My5jb20+LiAqLwo+PiAr
I2luY2x1ZGUgPHRlc3RfcHJvZ3MuaD4KPj4gKwo+PiArI2RlZmluZSBfU0RUX0hBU19TRU1BUEhP
UkVTIDEKPj4gKyNpbmNsdWRlICIuLi9zZHQuaCIKPj4gKyNpbmNsdWRlICJ0ZXN0X3VzZHRfbzIu
c2tlbC5oIgo+PiArCj4+ICtpbnQgbGV0c190ZXN0X3RoaXMoaW50KTsKPj4gKwo+PiArI2RlZmlu
ZSB0ZXN0X3ZhbHVlIDB4RkVEQ0JBOTg3NjU0MzIxMFVMTAo+PiArI2RlZmluZSBTRUMobmFtZSkg
X19hdHRyaWJ1dGVfXygoc2VjdGlvbihuYW1lKSwgdXNlZCkpCj4+ICsKPj4gKwo+PiArc3RhdGlj
IHZvbGF0aWxlIF9fdTY0IGFycmF5WzFdID0ge3Rlc3RfdmFsdWV9Owo+PiArdW5zaWduZWQgc2hv
cnQgdGVzdF91c2R0MV9zZW1hcGhvcmUgU0VDKCIucHJvYmVzIik7Cj4+ICsKPgo+SXMgc2VtYXBo
b3JlIGVzc2VudGlhbCB0byB0aGlzIHRlc3Q/Cj4KPj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUg
dm9pZCB0cmlnZ2VyX2Z1bmModm9pZCkKPj4gK3sKPj4gKyAgICAgICAvKiBCYXNlIGFkZHJlc3Mg
KyBvZmZzZXQgKyAoaW5kZXggKiBzY2FsZSkgKi8KPj4gKyAgICAgICBpZiAodGVzdF91c2R0MV9z
ZW1hcGhvcmUpIHsKPj4gKyAgICAgICAgICAgICAgIGZvciAodm9sYXRpbGUgaW50IGkgPSAwOyBp
IDw9IDA7IGkrKykKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgU1RBUF9QUk9CRTEodGVzdCwg
dXNkdDEsIGFycmF5W2ldKTsKPj4gKyAgICAgICB9Cj4+ICt9Cj4+ICsKPgo+Wy4uLl0K

