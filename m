Return-Path: <linux-kselftest+bounces-38367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872EB1C3B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390EA186FD5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEC21CC79;
	Wed,  6 Aug 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="c54s3wP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C422904;
	Wed,  6 Aug 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473693; cv=none; b=KJbauVr0/45K7y/otp38O7Lky2BkWIGJ5KYQZ2tDdHork6lQ9foO9uhsLvltJe2g66i0jQUx9nHaHFUQhJtHCZlFDaKeOlfiPlmV6Zl3UQoYScRku5eoY7qI1UFNsRwjDKB89d+AxNhUZUX8IyFZezeg9Pt7ar9muiXoy3E69sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473693; c=relaxed/simple;
	bh=L18x3n0Qgl4lVs+Z9ZFglVRU0vLUp/CruW8wFiT1QfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IQjo/uIqepo7chE6EFgeggo1KO2/UGnO9UiUk0txRVKigGCEhXJS9d6J+qQ7cLcTqyj2YZ9oh+348tHCFp3tmXkTra//0WoID6kS/utbNa26DUJ/bu/bp/5SxE4mHRcDl+wOCTA4IEOBzhQuwsGLrBOe0nuhdEHkcseiqxDK4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=c54s3wP2 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=QzKGHkQdK0bBRBUTozmgAfsqu4s3xVI4zk+6kEWtcVQ=; b=c
	54s3wP2ww5tR5bh9A31RvZAgGZpX10TLpTSyUMkPuHwHnB2Kc6YCAp6jFJvr1WKA
	/LM7BrelO+XRPYYa1dJL4aiQeE1gT1FCq0OF0P11za+iEimD9QPncHtRjEUen5Tr
	xguMl/NG3alS2l6UjMv9OfslXGo9mBO5JpI2y6HksE=
Received: from phoenix500526$163.com ( [120.230.124.59] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Wed, 6 Aug 2025 17:47:36 +0800 (CST)
Date: Wed, 6 Aug 2025 17:47:36 +0800 (CST)
From: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v6 2/2] selftests/bpf: Force -O2 for USDT selftests
 to cover SIB handling logic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20250519(9504565a)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <058d4d74-23ff-444b-a773-9d45204900f2@linux.dev>
References: <20250802084803.108777-1-phoenix500526@163.com>
 <20250802084803.108777-3-phoenix500526@163.com>
 <058d4d74-23ff-444b-a773-9d45204900f2@linux.dev>
X-NTES-SC: AL_Qu2eBvicvE4u4CSdbOkfmUsVh+o9X8K1vfsk3oZfPJp+jCLp1yY+THNTMH/b4cWDNTqunQiHQiJp+uZHV6V3YawLZvTuhmOs4NaAknJTr1/35Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <393dae7e.9b04.1987ec77091.Coremail.phoenix500526@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgD313O5JJNoRQoUAA--.51653W
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAOhiGiTGhWjkQABs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpPSywgSeKAmXZlIGFscmVhZHkgYWRkZWQgYW4gdXNkdF9vMiB0ZXN0IGFuZCBwYXNzZWQgaXQu
wqAKCgoKCkF0IDIwMjUtMDgtMDYgMDM6NDI6MjIsICJZb25naG9uZyBTb25nIiA8eW9uZ2hvbmcu
c29uZ0BsaW51eC5kZXY+IHdyb3RlOgo+Cj4KPk9uIDgvMi8yNSAxOjQ4IEFNLCBKaWF3ZWkgWmhh
byB3cm90ZToKPj4gV2hlbiB1c2luZyBHQ0Mgb24geDg2LTY0IHRvIGNvbXBpbGUgYW4gdXNkdCBw
cm9nIHdpdGggLU8xIG9yIGhpZ2hlcgo+PiBvcHRpbWl6YXRpb24sIHRoZSBjb21waWxlciB3aWxs
IGdlbmVyYXRlIFNJQiBhZGRyZXNzaW5nIG1vZGUgZm9yIGdsb2JhbAo+PiBhcnJheSBhbmQgUEMt
cmVsYXRpdmUgYWRkcmVzc2luZyBtb2RlIGZvciBnbG9iYWwgdmFyaWFibGUsCj4+IGUuZy4gIjFA
LTk2KCVyYnAsJXJheCw4KSIgYW5kICItMUA0K3QxKCVyaXApIi4KPj4KPj4gSW4gdGhpcyBwYXRj
aDoKPj4gLSBmb3JjZSAtTzIgb3B0aW1pemF0aW9uIGZvciB1c2R0LnRlc3QubyB0byBnZW5lcmF0
ZSBTSUIgYWRkcmVzc2luZyB1c2R0Cj4+ICAgIGFyZ3VtZW50IHNwZWMuCj4+IC0gY2hhbmdlIHRo
ZSBnbG9iYWwgdmFyaWFibGUgdDEgdG8gYSBsb2NhbCB2YXJpYWJsZSwgdG8gYXZvaWQgY29tcGls
ZXIKPj4gICAgZ2VuZXJhdGluZyBQQy1yZWxhdGl2ZSBhZGRyZXNzaW5nIG1vZGUgZm9yIGl0Lgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKaWF3ZWkgWmhhbyA8cGhvZW5peDUwMDUyNkAxNjMuY29tPgo+
PiAtLS0KPj4gICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUgICAgICAgICAg
fCAgOCArKysrKysrKwo+PiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L3VzZHQuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9NYWtlZmlsZQo+PiBpbmRleCA5MTBkOGQ2NDAyZWYuLjRiNzdkMDZkNWM0MiAxMDA2NDQKPj4g
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlCj4+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZQo+PiBAQCAtNzU5LDYgKzc1OSwxNCBAQCBU
UlVOTkVSX0JQRl9CVUlMRF9SVUxFIDo9ICQkKGVycm9yIG5vIEJQRiBvYmplY3RzIHNob3VsZCBi
ZSBidWlsdCkKPj4gICBUUlVOTkVSX0JQRl9DRkxBR1MgOj0KPj4gICAkKGV2YWwgJChjYWxsIERF
RklORV9URVNUX1JVTk5FUix0ZXN0X21hcHMpKQo+PiAgIAo+PiArIyBGb3JjZSB1c2R0LmMgdG8g
dXNlIC1PMiBvcHRpbWl6YXRpb24gdG8gZ2VuZXJhdGUgU0lCIGFkZHJlc3NpbmcKPj4gKyMgT25s
eSBhcHBseSBvbiB4ODYgYXJjaGl0ZWN0dXJlIHdoZXJlIFNJQiBhZGRyZXNzaW5nIGlzIHJlbGV2
YW50Cj4+ICtpZmVxICgkKEFSQ0gpLCB4ODYpCj4+ICskKE9VVFBVVCkvdXNkdC50ZXN0Lm86IENG
TEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFHUykpCj4+ICskKE9VVFBVVCkvY3B1djQvdXNkdC50
ZXN0Lm86IENGTEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFHUykpCj4+ICskKE9VVFBVVCkvbm9f
YWx1MzIvdXNkdC50ZXN0Lm86IENGTEFHUzo9JChzdWJzdCBPMCxPMiwkKENGTEFHUykpCj4+ICtl
bmRpZgo+Cj5UaGlzIGlzIG5vIGdvb2QuIFlvdSBzaG91bGQgbm90IGNoYW5nZSBmcm9tIC1PMCB0
byAtTzIuIFRoZSBleGlzdGluZyB1c2R0LmMKPnRlc3Qgc2hvdWxkIGJlIGtlcHQuIEkgYXNzdW1l
IGF0IC1PMCBsZXZlbCwgdGhlIGNvbXBpbGVyIHByb2JhYmx5Cj53b24ndCBnZW5lcmF0ZSBTSUIg
cGF0dGVybi4KPgo+WW91IGNvdWxkIGFkZCBhbm90aGVyIHVzZHQgdGVzdCBlLmcuIHVzZHRfbzIu
YyBhbmQgZm9yY2UKPnVzZHRfbzIgaXMgY29tcGlsZWQgd2l0aCAtTzIgb3B0aW1pemF0aW9ucyBh
bmQgaW4gdXNkdF9vMiBmb2N1c2luZyBvbgo+U0lCIHByb2JlLgo+Cj4+ICsKPj4gICAjIERlZmlu
ZSB0ZXN0X3ZlcmlmaWVyIHRlc3QgcnVubmVyLgo+PiAgICMgSXQgaXMgbXVjaCBzaW1wbGVyIHRo
YW4gdGVzdF9tYXBzL3Rlc3RfcHJvZ3MgYW5kIHN1ZmZpY2llbnRseSBkaWZmZXJlbnQgZnJvbQo+
PiAgICMgdGhlbSAoZS5nLiwgdGVzdC5oIGlzIHVzaW5nIGNvbXBsZXRlbHkgcGF0dGVybiksIHRo
YXQgaXQncyB3b3J0aCBqdXN0Cj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ190ZXN0cy91c2R0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy91c2R0LmMKPj4gaW5kZXggNDk1ZDY2NDE0YjU3Li44NmYzNTRkMjVhZWYgMTAwNjQ0
Cj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3VzZHQuYwo+
PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy91c2R0LmMKPj4g
QEAgLTE0LDEwICsxNCwxNSBAQCBzdGF0aWMgdm9sYXRpbGUgaW50IGlkeCA9IDI7Cj4+ICAgc3Rh
dGljIHZvbGF0aWxlIF9fdTY0IGJsYSA9IDB4RkVEQ0JBOTg3NjU0MzIxMFVMTDsKPj4gICBzdGF0
aWMgdm9sYXRpbGUgc2hvcnQgbnVtc1tdID0gey0xLCAtMiwgLTMsIC00fTsKPj4gICAKPj4gLXN0
YXRpYyB2b2xhdGlsZSBzdHJ1Y3Qgewo+PiAtCWludCB4Owo+PiAtCXNpZ25lZCBjaGFyIHk7Cj4+
IC19IHQxID0geyAxLCAtMTI3IH07Cj4+ICsvKgo+PiArICogVE9ETzogIEF0IE8yIG9wdGltaXph
dGlvbiBsZXZlbCwgdDEncyBVU0RUIGFyZ3VtZW50IHNwZWMgYmVjb21lcyAtMUA0K3QxKCVyaXAp
Lgo+PiArICogU2luY2UgbGliYnBmIGRvZXNuJ3Qgc3VwcG9ydCBSSVAgYWRkcmVzc2luZyBtb2Rl
IHlldCwgdGhpcyBjYXVzZXMgInVucmVjb2duaXplZCByZWdpc3RlciIgZXJyb3JzLgo+PiArICog
VGhpcyB0ZXN0IHdpbGwgYmUgcmUtZW5hYmxlZCBvbmNlIGxpYmJwZiBzdXBwb3J0cyBSSVAgYWRk
cmVzc2luZyBtb2RlLgo+PiArICovCj4+ICsvLyBzdGF0aWMgdm9sYXRpbGUgc3RydWN0IHsKPj4g
Ky8vCWludCB4Owo+PiArLy8Jc2lnbmVkIGNoYXIgeTsKPj4gKy8vIH0gdDEgPSB7IDEsIC0xMjcg
fTsKPj4gICAKPgo+Wy4uLl0K

