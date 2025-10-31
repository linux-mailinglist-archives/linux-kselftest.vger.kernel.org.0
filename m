Return-Path: <linux-kselftest+bounces-44541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FE0C261B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CA51B24927
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC2271459;
	Fri, 31 Oct 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCSoX7Dk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDD170826;
	Fri, 31 Oct 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927649; cv=none; b=U+y1benfxJAD3A8yAQsU4rRKZlMt+BYzjU+G2vkM74XU4nGl1hTpHP8aCWy1ENpQxRbG3FpKlQ+EqHnVO0uE8ToiomW//HJT7//fYZmcO7U+RQeB1vG3guUgonoaGSEoD6/7t99JFCd0XO6cfwhSf9vYocFdog0TWQFf+K7Ks24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927649; c=relaxed/simple;
	bh=Yb/w+7MPzDjhDPB34mgEUk5mobDcE3LsCSh5TaxunmU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OwH5ghOobCp6oilBUdArEADRwoFk5rF6OvDfOQ+cCN8yPOxVcwmM1koC28eESOYWGv3pPmuoCO2nHzeBeVWI9f6TK5nemxFB5lMaMLoX9x5evL8jOgZTNj0h498F/+ySfWGd1vIhpBnSyOkC6cJtFOMzn3/aGtZ0OkGY31Br3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCSoX7Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04632C4CEE7;
	Fri, 31 Oct 2025 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761927649;
	bh=Yb/w+7MPzDjhDPB34mgEUk5mobDcE3LsCSh5TaxunmU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iCSoX7DkJPWMSC6vPQmObXvrr+WIOnvIoemLZ4fEkqO0sGymPNXDSl2jcdm1e2XiY
	 aEnH3/W5PPMpquXKNf5aLUKtPsy+0Onor2Xo430d6nzbRLyfhq5j/GXDsvMErQNerC
	 w247H1RpO20FbE6LcDPj+G76ApLj9vCwScGmHJQdeJOVkWbRfMSk2v5xW9ws0b6uDk
	 RZt4SyBMmp+GKCozRVX1MgANx0PWejuea5Tq9NrZH+ZYaukM7nWcKcXbhItDz729pk
	 m0Msc9Dr2YfYzkriRGdWSTu6jttdKovCjJ8qEduLht78Hcb2O6MWxgjYE2++RNUMdg
	 rDXkWfG23LlPw==
Content-Type: multipart/mixed; boundary="===============7198071862224552361=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09feef91b51f675195b5b1b9a854d844c9999c0cebb429d785fe60f6c787dc8b@mail.kernel.org>
In-Reply-To: <20251031-tc_edt-v1-2-5d34a5823144@bootlin.com>
References: <20251031-tc_edt-v1-2-5d34a5823144@bootlin.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: integrate test_tc_edt into test_progs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Oct 2025 16:20:49 +0000 (UTC)

--===============7198071862224552361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

CmBgYApjb21taXQgZmIwYzVjZmFkMzdlYWFkMzBmNTg0Y2FhZjUzZmU5ODI0MDI2YmM5MgpBdXRo
b3I6IEFsZXhpcyBMb3Rob3LDqSAoZUJQRiBGb3VuZGF0aW9uKSA8YWxleGlzLmxvdGhvcmVAYm9v
dGxpbi5jb20+CgpzZWxmdGVzdHMvYnBmOiBpbnRlZ3JhdGUgdGVzdF90Y19lZHQgaW50byB0ZXN0
X3Byb2dzCgpUaGlzIHBhdGNoIGNvbnZlcnRzIHRlc3RfdGNfZWR0LnNoIHRvIHRoZSB0ZXN0X3By
b2dzIGZyYW1ld29yaywKY3JlYXRpbmcgYSBuZXcgdGVzdCB0aGF0IG1lYXN1cmVzIEJQRi1iYXNl
ZCB0cmFmZmljIHNoYXBpbmcgdG8gdmVyaWZ5CnRoYXQgdGhlIHJlc3VsdGluZyByYXRlIG1hdGNo
ZXMgNU1icHMgd2l0aGluIGEgMiUgZXJyb3IgbWFyZ2luLgoKPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvdGVzdF90Y19lZHQuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfdGNfZWR0LmMKPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uYTc3ZTQ4ZmRmCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfdGNfZWR0
LmMKClsgLi4uIF0KCj4gKyNkZWZpbmUgVEFSR0VUX1JBVEVfTUJQUwk1LjAKPiArI2RlZmluZSBS
QVRFX0VSUk9SX1BFUkNFTlQJMi4wCgpbIC4uLiBdCgo+ICtzdGF0aWMgdm9pZCBydW5fdGVzdCh2
b2lkKQo+ICt7Cj4gKwlfX3U2NCByeF9ieXRlc19zdGFydCwgcnhfYnl0ZXNfZW5kOwo+ICsJZG91
YmxlIHJhdGVfbWJwcywgcmF0ZV9lcnJvcjsKPiArCXB0aHJlYWRfdCBzZXJ2ZXJfdGhyZWFkID0g
MDsKPiArCXN0cnVjdCBjb25uZWN0aW9uICpjb25uOwo+ICsJX191NjQgdHNfc3RhcnQsIHRzX2Vu
ZDsKPiArCWludCByZXQ7Cj4gKwo+ICsKPiArCWNvbm4gPSBzZXR1cF9jb25uZWN0aW9uKCk7Cj4g
KwlpZiAoIUFTU0VSVF9PS19QVFIoY29ubiwgInNldHVwIGNsaWVudCBhbmQgc2VydmVyIGNvbm5l
Y3Rpb24iKSkKPiArCQlyZXR1cm47Cj4gKwo+ICsJcmV0ID0gcHRocmVhZF9jcmVhdGUoJnNlcnZl
cl90aHJlYWQsIE5VTEwsIHJ1bl9zZXJ2ZXIsCj4gKwkJCSAgICAgKHZvaWQgKikoJmNvbm4tPnNl
cnZlcl9jb25uX2ZkKSk7Cj4gKwlpZiAoIUFTU0VSVF9PSyhyZXQsICJzdGFydCBzZXJ2ZXIgcngg
dGhyZWFkIikpCj4gKwkJZ290byBlbmRfY2xlYW51cF9jb25uOwo+ICsJaWYgKCFBU1NFUlRfT0so
cmVhZF9yeF9ieXRlcygmcnhfYnl0ZXNfc3RhcnQpLCAicmVhZCByeF9ieXRlcyIpKQo+ICsJCWdv
dG8gZW5kX2tpbGxfdGhyZWFkOwo+ICsJdHNfc3RhcnQgPSBnZXRfdGltZV9ucygpOwo+ICsJd2hp
bGUgKHRydWUpIHsKPiArCQlzZW5kKGNvbm4tPmNsaWVudF9jb25uX2ZkLCAodm9pZCAqKXR4X2J1
ZmZlciwgQlVGRkVSX0xFTiwgMCk7Cj4gKwkJdHNfZW5kID0gZ2V0X3RpbWVfbnMoKTsKPiArCQlp
ZiAoKHRzX2VuZCAtIHRzX3N0YXJ0KS8xMDAwMDAgPj0gVElNRU9VVF9NUykgewogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXgoKRG9lcyB0aGlzIHRpbWUgY29u
dmVyc2lvbiB1c2UgdGhlIGNvcnJlY3QgZGl2aXNvcj8gVGhlIHRpbWVvdXQgY2hlY2sKYXBwZWFy
cyB0byBkaXZpZGUgbmFub3NlY29uZHMgYnkgMTAwMDAwLCBidXQgVElNRU9VVF9NUyBpcyAyMDAw
Cm1pbGxpc2Vjb25kcy4gQ29udmVydGluZyBuYW5vc2Vjb25kcyB0byBtaWxsaXNlY29uZHMgcmVx
dWlyZXMgZGl2aWRpbmcKYnkgMTAwMDAwMCwgbm90IDEwMDAwMC4gV2l0aCB0aGUgY3VycmVudCBj
YWxjdWxhdGlvbiwgdGhlIHRpbWVvdXQgd291bGQKdHJpZ2dlciBhZnRlciAyMDAgbWlsbGlzZWNv
bmRzIHJhdGhlciB0aGFuIDIwMDAgbWlsbGlzZWNvbmRzLgoKPiArCQkJdHhfdGltZW91dCA9IHRy
dWU7Cj4gKwkJCXJldCA9IHJlYWRfcnhfYnl0ZXMoJnJ4X2J5dGVzX2VuZCk7Cj4gKwkJCWlmICgh
QVNTRVJUX09LKHJldCwgInJlYWRfcnhfYnl0ZXMiKSkKPiArCQkJCWdvdG8gZW5kX2NsZWFudXBf
Y29ubjsKPiArCQkJYnJlYWs7Cj4gKwkJfQo+ICsJfQo+ICsKPiArCXJhdGVfbWJwcyA9IChyeF9i
eXRlc19lbmQgLSByeF9ieXRlc19zdGFydCkgLwo+ICsJCSAgICAoKHRzX2VuZCAtIHRzX3N0YXJ0
KSAvIDEwMDAuMCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5e
XgoKQ2FuIHRoaXMgcmF0ZSBjYWxjdWxhdGlvbiBwcm9kdWNlIHRoZSBjb3JyZWN0IHVuaXRzPyBU
aGUgbnVtZXJhdG9yIGlzIGluCmJ5dGVzLCBhbmQgdGhlIGRlbm9taW5hdG9yIChuYW5vc2Vjb25k
cyAvIDEwMDAuMCkgaXMgaW4gbWljcm9zZWNvbmRzLApnaXZpbmcgYnl0ZXMgcGVyIG1pY3Jvc2Vj
b25kIHdoaWNoIGVxdWFscyBtZWdhYnl0ZXMgcGVyIHNlY29uZCAoTUIvcykuCkhvd2V2ZXIsIHRo
ZSBjb21taXQgbWVzc2FnZSBzdGF0ZXMgdGhlIHRlc3QgdmVyaWZpZXMgIjVNYnBzIiAobWVnYWJp
dHMKcGVyIHNlY29uZCksIGFuZCBUQVJHRVRfUkFURV9NQlBTIHN1Z2dlc3RzIHRoZSBzYW1lLiBD
b252ZXJ0aW5nIE1CL3MgdG8KTWJwcyByZXF1aXJlcyBtdWx0aXBseWluZyBieSA4IChiaXRzIHBl
ciBieXRlKSwgd2hpY2ggYXBwZWFycyB0byBiZQptaXNzaW5nLiBJcyB0aGUgdGVzdCBtZWFzdXJp
bmcgaW4gdGhlIHdyb25nIHVuaXRzLCBvciBpcyB0aGVyZSBhIG5hbWluZwppbmNvbnNpc3RlbmN5
PwoKPiArCXJhdGVfZXJyb3IgPQo+ICsJCWZhYnMoKHJhdGVfbWJwcyAtIFRBUkdFVF9SQVRFX01C
UFMpICogMTAwLjAgLyBUQVJHRVRfUkFURV9NQlBTKTsKPiArCWZwcmludGYoc3RkZXJyLCAiUmF0
ZTpcdCVmXG5FcnJvcjpcdCVmXG4iLCByYXRlX21icHMsIHJhdGVfZXJyb3IpOwo+ICsKPiArCUFT
U0VSVF9MRShyYXRlX2Vycm9yLCBSQVRFX0VSUk9SX1BFUkNFTlQsCj4gKwkJICAicmF0ZSBlcnJv
ciBpcyBsb3dlciB0aGFuIHRocmVzaG9sZCIpOwo+ICsKPiArZW5kX2tpbGxfdGhyZWFkOgo+ICsJ
dHhfdGltZW91dCA9IHRydWU7Cj4gK2VuZF9jbGVhbnVwX2Nvbm46Cj4gKwljbGVhbnVwX2Nvbm5l
Y3Rpb24oY29ubik7Cj4gK30KCgpgYGAKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVh
c2UgZml4IHRoZSBidWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0
dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xh
dWRlL1JFQURNRS5tZAoKSW4tUmVwbHktVG8tU3ViamVjdDogYHNlbGZ0ZXN0cy9icGY6IGludGVn
cmF0ZSB0ZXN0X3RjX2VkdCBpbnRvIHRlc3RfcHJvZ3NgCkNJIHJ1biBzdW1tYXJ5OiBodHRwczov
L2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xODk3ODE3MDk3Mgo=

--===============7198071862224552361==--

