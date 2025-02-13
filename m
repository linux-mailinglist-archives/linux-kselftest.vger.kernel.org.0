Return-Path: <linux-kselftest+bounces-26526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C65A33DAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBA8166AEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B1213253;
	Thu, 13 Feb 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="Fzdk/X14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224D21D3C5;
	Thu, 13 Feb 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445571; cv=none; b=FuebH21hDvbVg7Zj//nMlppN8kik6mJ7sIIdXVatbgkiLr7cU/vebmFXW8m39wOwiV3IH5P+bamk3KWmP/c4f0ZIUYyEFNt7HscxbPFBRz8iTm77urTZJPNpjX6V968NRI/HhTPCH62ZCfflo1DlFrMstQO7oxajM6hEgAVgLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445571; c=relaxed/simple;
	bh=Ca+RYzQ9soWrd7Yg/lFnhKtLF7Ve8a82GfLi0FYno3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD/VYHfY6MPKVI3cw6Cjh8kRPbNPL05Ib5koNS2LCns2UvswUDIjmmXaIzxKJQrRh4katflb+iBTjWvUAdZQKuA/fWf/ZZ1KJXwrpejWXed77fIdZTNmwYHTKQ8xKDeg/aRleRPEKye94JEjP/I2TUm9317M1qL4UUQIA/sD5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=Fzdk/X14; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445566; x=1740050366; i=ps.report@gmx.net;
	bh=Ca+RYzQ9soWrd7Yg/lFnhKtLF7Ve8a82GfLi0FYno3o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fzdk/X14cpnpwVHWdDmFzJBP9nKs3Wh3MrD6pj4jWRU8y6VNSvBCGqoIKKDK+IRT
	 SqDsLtP50+4kdBdqLEJnO6p7jcXal7DrP6hKxFG0MblqZj216znsXFfDjAecTB9YW
	 4+8OwHMH0xB5iPZwo/2Bzt/93Jop+pcPAef5sSbAeX1MwGic9tmZv+4ApVB6+pA24
	 I5hXtnWb8cgqtkad28DhMrDzQpioucbbtPM1fYp1gbweKb8zJ/nwyNvo2XdjREVDk
	 9syj+MhT+Q/hfkPQ2iWzw+k1NRJZ/ZqQHcqhgcacr8wmuC8mw83tNp5b6SWBTPSdo
	 p+NZ2kmbEknpZ+3BLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1tM4XX0VUn-010rII; Thu, 13
 Feb 2025 12:19:26 +0100
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
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 3/8] net: pktgen: remove some superfluous variable initializing
Date: Thu, 13 Feb 2025 12:19:15 +0100
Message-ID: <20250213111920.1439021-4-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213111920.1439021-1-ps.report@gmx.net>
References: <20250213111920.1439021-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:64i7/RQdDiexzAcJYHeNIJGqgbVggzVpHID1CcxRZ9thvby/FET
 8EUbMQ4u/5EJ4tlh0G5b1q4FkjHpJfky8vRsmJHQfpclaISsf1KwNsQLTqf8s1pWXO/f+eB
 Eqe4ypalmA6DiKlCGxeHOZSGzg2gZOFYgpUCdB0lu0RfIkSbadE+NSl9zrg/NuJXCnSpjo1
 wRvLEhcMqScO17zYunTfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i+omshQiwx4=;Y3iDBelKZfLiOwRQ5Dy+In1SG0X
 uINeA9KVcauZPiNspnQEZ4Omo14BuCz643Y6RzJ71TRvypswkSi1jvHF5acaduzDYPuxkDkEM
 u+7WXZW/YsZNq+PFMTXlJ2a3rgnWRD0hk1flOnUsTRiwWLXzHEtn0fjBbuj4791dZS9MLbjD1
 2cqxfDBaaXfQCscGhjjNk5ftoI30biWr3EvR16B83TuoxPX/f4I1XQoWoNz590XTgSFOjahiP
 EjV1rnn6WX3474ah2f0XegV2jZyGHV9h/WDt8SXoWuWODRiliLMF38MkIwGSYSZ6t8Lb81LF7
 712mkeRrw0OxgQ3pTSJReO5XXzLWUT3znBqxlejVCe8xHmKDKSySMZYS2DlgAkww+eIAGiria
 gK0+29le7M8tpM1nU9LFwkBLNAo84EPy3MmQcQMpV9IMbLJj2PZIdI4HvynOdjwB3T83yjLOC
 hebbPglRgvrgsVk9669l0bkeYA05innBYfj1I56YOdDenD8CyS/t04THfR3fCgSKto4740iQg
 mj16Y5nyd0C1niEbMMkWLeeniAhkPFnH2SdVTLLihs+NkBM8CusA9SxVQpJ9TJfzW8a/9AAjS
 8FPNXbATHTtvGYPEBMGnJIaq7PUuJrICYPvLwDA1XVIKZqwvg6gtkpIB6UoOS2rYsVonnkvBf
 9VLOBN0lEW5I9IhI838HBwUOak3k2yKEB0kYFDjHco/hg+5bEJXUfWywuVUBISxybZrRWAPGO
 p9pGD0pilcAF3rrgc8QZQpsErX4DetW+twHa1QAwnRdklwT9EjcNKOZNvSwOgCBUZDpM1Tmp0
 w6C46jnd+WfKSYBj4uh4oTqnSdiqLVTqqAwzqUugJj6kKyiJrXzl8H/j0uAl43zPSfWPzxl+R
 ImQAVme5iQQZN9luXNLaAlQyWuQnfUlboWXVI6cesbS//j/eOLA+CwbX8AHWUx2MC0gs8jI68
 6LvCirWW8JtcwvuE4rGVG0jRBnH1sBZgUcAOPhTqRyZ6JGqt5y9ILdXYeRi49scxEPvKtpZsS
 CYhw+8aY9CLIAdapMPYZaJxloLNlZrTzgus/kPuAD8HTmmRqyO33LEK8QntVGtULabY9/ZSGl
 VjvNL4B2lua0VjY47LV7Z9k8BI61otbIo4hVG6cbTekw5KxUPvRLJ1tjeORtFY9AEP3trkfD8
 6txYpY/xBk2ffZwAgK5kGTrZlT3/pFprOTGCpFYfijP8H3q2FKeOYrk0gc06FIK1wSLi5vmPU
 1eJCAo7vn6W22IKKJg7MTm8a5BgPjUog0fHveqHNTqSeqQdLfddhIba7lowuSAWEt9QrDjoAP
 Mr5XgWnQR+SyqbbkOQDH9hI+dPw/66PTXvuDnArmBncrPupM+JtUHFZA01SfYJVoMWGEy48pQ
 QKPcqT9QiOw7EhVQKZ0XlO6NjbNrGmrFWXwGXht/gyWrtFiU6dQ1MjYU5t

UmVtb3ZlIHNvbWUgc3VwZXJmbHVvdXMgdmFyaWFibGUgaW5pdGlhbGl6aW5nIGJlZm9yZSBoZXgz
Ml9hcmcgY2FsbCAoYXMgdGhlCnNhbWUgaW5pdCBpcyBkb25lIGhlcmUgYWxyZWFkeSkuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+ClJldmlld2VkLWJ5
OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ci0tLQpDaGFuZ2VzIHY0IC0+IHY1CiAg
LSBzcGxpdCB1cCBwYXRjaHNldCBpbnRvIHBhcnQgaS9paSAoc3VnZ2VzdGVkIGJ5IFNpbW9uIEhv
cm1hbikKICAtIGFkZCByZXYtYnkgU2ltb24gSG9ybWFuCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBu
ZXcgcGF0Y2ggKGZhY3RvcmVkIG91dCBvZiBwYXRjaCAnbmV0OiBwa3RnZW46IGZpeCBhY2Nlc3Mg
b3V0c2lkZSBvZiB1c2VyCiAgICBnaXZlbiBidWZmZXIgaW4gcGt0Z2VuX2lmX3dyaXRlKCknKQot
LS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIv
bmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYjlkOGUzM2FiZTFlLi40MzYwNzZhMmNjYjcgMTAwNjQ0
Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC0xNzk2
LDcgKzE3OTYsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsCiAJfQogCiAJaWYgKCFzdHJjbXAobmFtZSwgInRvcyIpKSB7Ci0JCV9fdTMyIHRtcF92
YWx1ZSA9IDA7CisJCV9fdTMyIHRtcF92YWx1ZTsKIAkJbGVuID0gaGV4MzJfYXJnKCZ1c2VyX2J1
ZmZlcltpXSwgSEVYXzJfRElHSVRTLCAmdG1wX3ZhbHVlKTsKIAkJaWYgKGxlbiA8IDApCiAJCQly
ZXR1cm4gbGVuOwpAQCAtMTgxMiw3ICsxODEyLDcgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lm
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCX0KIAogCWlmICghc3RyY21wKG5hbWUsICJ0cmFm
ZmljX2NsYXNzIikpIHsKLQkJX191MzIgdG1wX3ZhbHVlID0gMDsKKwkJX191MzIgdG1wX3ZhbHVl
OwogCQlsZW4gPSBoZXgzMl9hcmcoJnVzZXJfYnVmZmVyW2ldLCBIRVhfMl9ESUdJVFMsICZ0bXBf
dmFsdWUpOwogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47Ci0tIAoyLjQ4LjEKCg==

