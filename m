Return-Path: <linux-kselftest+bounces-27757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF4A4806F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB97B178CF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1472356B7;
	Thu, 27 Feb 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="qQpXi5D0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9201230242;
	Thu, 27 Feb 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664590; cv=none; b=iKgF0T014pvsnEIPUwY4HLxh+hR3ZEQ5IE9x7lAOen8Tm0JC7Odahfltzn161LJrQc4DCTw5eAtR4z1fbQp41D9gZXoMHA75ttYTB8Hjpmkh2nEn5aAJqS8sL4Mk/STK9ECs28oAvcjQJNFQRNUTE2ju147QhzPU7jZ/A6X1EL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664590; c=relaxed/simple;
	bh=o+P2i21j+9UsvnQZ+LIn9djpyNgEp8G7gQneFzg00Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+Fsbc4oDzbOFeuSlcLb/RXidVtOHt3+tifFAK+pjP2d+EPLB9zb5vvy5qwKrUlIlFOxhPUGshn/ia3btpW3ofnMSN2lL0pM0/uR+QX6aoKaRI+20PwEhCOrhxDYv9byht/wBh8NxS6DObOFWfcZoPZVK82nx/M+/6RyVKmZLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=qQpXi5D0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740664575; x=1741269375; i=ps.report@gmx.net;
	bh=o+P2i21j+9UsvnQZ+LIn9djpyNgEp8G7gQneFzg00Q4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qQpXi5D0NqpjNjOe+WIhApKFhvYSzRuppjSgY5pOIXm7HBUNjvUNAhyG0Qi80bxP
	 wRWNcOdQL4tfVodGJJkB8p5d0RYi/QAOi8iZDIPnkSRwjH/Oz61rebMobf8p6oobl
	 lJBHnzNePKB9NIb18YkV5v6PkXzoZEu2Zgofvj3uz2YevQFYgKU+GwTm4ccODfxJx
	 CHimGBhsI4uD/YqZcaKJZJ4T+ZNEfOdu5v+NYzI2BeWvS0WIYuIRQ0yRaBf8hhNdc
	 Nde6zALzLTBNC98mRv932n5OpoN6FV4RCRJBXEQ/xHMVEbrd2MaOutdE/qJ4gwdYo
	 Stfn8zSgxgrxBjhBcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1u0FXt0QeM-008Pax; Thu, 27
 Feb 2025 14:56:15 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v8 4/8] net: pktgen: fix mpls maximum labels list parsing
Date: Thu, 27 Feb 2025 14:56:00 +0100
Message-ID: <20250227135604.40024-5-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227135604.40024-1-ps.report@gmx.net>
References: <20250227135604.40024-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:hYU2LsKYU0iuOpOYvNQ6ecLiC2rPxBLxL7LFnrlSTqSYENmKnwT
 SuiHqPMq/oa8YAZoykYMWEWSOyZFexhh+b7B8cgysuaXrz+Q4DcfHKblutYmxBLQywEcb7m
 9KZHobsyEf+1JMJEAXnp3GmR8qixyHp+AwvtgCSRFCrqQzdPsXYNaM1EG4b82Uv1pTuIXT3
 AcmtGekFG3XPa99vIc7Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h2YcoC9du70=;W6pA1Cl6bw2nK57S1x4lm/iBV+U
 K4Fi2qomBG0ml6di8OvPdjxREreVhQZlfzxPNzvCYtOMmPdnIxd77JRzeGPj1A2Ab6bpqrU9O
 5/JhMMBDGZMACchm8Uh10upcBCsLRqB71h8vj/d7rPZ56Gb3WoPeua6E8h/OHyOykmogb5zro
 y4ewFoPyLXh9dDxBy902p9HGqKeGXlS7UobeFHKMMi2zOdxgiocRFTg/mVTotefPWx1lkmaSO
 fFj0EP5HwHR3Hu5dGqqImNq+g+NdQZZwhVGPzkuZ/+2M+hW2/WDzwOG1bQtIEc5mYcRYcXnTj
 JiVl+7qaLM6IiB5fAzFCwYrZMM4eWHGuYkUbZQQJkAJr0dQM3xx7ZoObk+RJnP0zgDP2sM+rN
 TWf/SuTP6bPmXedaLgQg/q+TkHuf2lE6GogTAnDEwrW3Ge0w606lWv77QRouN0JuTeoHJD9Vd
 YNRPHFeYy/QMCV/UHJ+GW3JvnO8PRLW/iwXb2lTNDwq33TiGCeEC9YHuemaTdOux4KpfnySF7
 EGjEj/DWdUm3DibQc+OT+eqSFp1WdyQGOB9+tMyGRrjTyNqnws/QeOxAzKhYtsRHsHCs4a2B2
 g002eNKfkcfv/mdE5CiaflTBAp4I+LJwSU4uiJ11NI5nqFzCPBUk5Kzuvx75jz4jiHe46fog1
 KhX4zGC8qvOW52eXPTfg1EBJ/rLb9yLGmDPCQZlFxqTnPeIk/Pi2xJPjQZn1+7pEt1cnwdFvh
 yIIwTaaNtcHATmuHtEhuL7p+EHpb4oYn+/LXGSUCjHhtXoiZiv2jc3oybp4VtPHHYAwnIzNcU
 aOuwxZLR2BQFVgS1wjHSmT6k3kuS2vJe388d9Gs0C+KLiCuKMzP4x4I82c8NsM9KO++10NCZw
 yNEIv5IXhG6DCuh8A7csJxXBfyN1FwmsnfXJdJgeRgUye3FwTuPFb8Hxdo0Pwrev/chZK7GLh
 ZxX/LkuvAdBrX8KgmfZsYci3pdQelgY9NS/fjl81PfE22JMyghjdimzDukyZVKH0TK7skoOco
 v+0+6APVWldWLLCTAbQ+hnGXGqdRAY02aFQTsGo1njuc9npIxhMbjpgFBFQ+NZGWL8i8gr34f
 BAViwfEwligY4WxwKg+cwKebV7rPUqz/uRjHSFj2Nrtxd0u8RMXyr3eGPtMXrTN/5AxCVoBbt
 secMjLiLC4415JP775ad5zj8gZF4p/Q31NQqae0c/xHrDRjL73AH40BB3qht2JOcHniaA9rpT
 +TIzojMTP0ugrclR0Fv+PzEqPQBgB5OkrMQPCblfLvSI2vKJg3PGyLGRtUhO8n8WiMDJEyKZF
 tWw1wisOJFuiTXl1d1fdhRNlmVyM6lsvV7uo+jlawjVGFTPPzZBSaGWNl4bB6+cgefAjVhWQ6
 KuksWwNUPYyv+R/+Q9qnM+cGJenvNzK7IWjvVxAidadn3X1cjapV/GkM5b

Rml4IG1wbHMgbWF4aW11bSBsYWJlbHMgbGlzdCBwYXJzaW5nIHVwIHRvIE1BWF9NUExTX0xBQkVM
UyBlbnRyaWVzIChpbnN0ZWFkCm9mIHVwIHRvIE1BWF9NUExTX0xBQkVMUyAtIDEpLgoKQWRkcmVz
c2VzIHRoZSBmb2xsb3dpbmc6CgoJJCBlY2hvICJtcGxzIDAwMDAwZjAwLDAwMDAwZjAxLDAwMDAw
ZjAyLDAwMDAwZjAzLDAwMDAwZjA0LDAwMDAwZjA1LDAwMDAwZjA2LDAwMDAwZjA3LDAwMDAwZjA4
LDAwMDAwZjA5LDAwMDAwZjBhLDAwMDAwZjBiLDAwMDAwZjBjLDAwMDAwZjBkLDAwMDAwZjBlLDAw
MDAwZjBmIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCS1iYXNoOiBlY2hvOiB3cml0ZSBlcnJv
cjogQXJndW1lbnQgbGlzdCB0b28gbG9uZwoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIg
PHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPgotLS0KQ2hhbmdlcyB2NyAtPiB2OAogIC0gcmViYXNlZCBvbiBhY3R1YWwgbmV0LW5l
eHQvbWFpbgogIC0gc2xpZ2h0bHkgcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2UsIG9taXQgJy8xNicg
KHN1Z2dlc3RlZCBieSBQYW9sbyBBYmVuaSkKCkNoYW5nZXMgdjYgLT4gdjcKICAtIHJlYmFzZWQg
b24gYWN0dWFsIG5ldC1uZXh0L21haW4KICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjUgLT4gdjYK
ICAtIGFkanVzdCB0byBkcm9wcGVkIHBhdGNoICduZXQ6IHBrdGdlbjogdXNlIGRlZmluZXMgZm9y
IHRoZSB2YXJpb3VzCiAgICBkZWMvaGV4IG51bWJlciBwYXJzaW5nIGRpZ2l0cyBsZW5ndGhzJwog
IC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVw
IHBhdGNoc2V0IGludG8gcGFydCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQogIC0g
Y2hhbmdlIHBhdGNoIGRlc2NyaXB0aW9uICgnRml4ZXM6JyAtPiAnQWRkcmVzc2VzIHRoZSBmb2xs
b3dpbmc6JywKICAgIHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0
CiAgLSBuZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBh
Y2Nlc3Mgb3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRl
KCknKQotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0
Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCBiNjc4YjI4ZGVkYWUuLmRlZjM1YTczNGQ5
ZCAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMK
QEAgLTkwMCw2ICs5MDAsMTAgQEAgc3RhdGljIHNzaXplX3QgZ2V0X2xhYmVscyhjb25zdCBjaGFy
IF9fdXNlciAqYnVmZmVyLCBzdHJ1Y3QgcGt0Z2VuX2RldiAqcGt0X2RldikKIAlwa3RfZGV2LT5u
cl9sYWJlbHMgPSAwOwogCWRvIHsKIAkJX191MzIgdG1wOworCisJCWlmIChuID49IE1BWF9NUExT
X0xBQkVMUykKKwkJCXJldHVybiAtRTJCSUc7CisKIAkJbGVuID0gaGV4MzJfYXJnKCZidWZmZXJb
aV0sIDgsICZ0bXApOwogCQlpZiAobGVuIDw9IDApCiAJCQlyZXR1cm4gbGVuOwpAQCAtOTExLDgg
KzkxNSw2IEBAIHN0YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1
ZmZlciwgc3RydWN0IHBrdGdlbl9kZXYgKnBrdF9kZXYpCiAJCQlyZXR1cm4gLUVGQVVMVDsKIAkJ
aSsrOwogCQluKys7Ci0JCWlmIChuID49IE1BWF9NUExTX0xBQkVMUykKLQkJCXJldHVybiAtRTJC
SUc7CiAJfSB3aGlsZSAoYyA9PSAnLCcpOwogCiAJcGt0X2Rldi0+bnJfbGFiZWxzID0gbjsKLS0g
CjIuNDguMQoK

