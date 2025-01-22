Return-Path: <linux-kselftest+bounces-24943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AAA19442
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDB0188CF88
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25149215065;
	Wed, 22 Jan 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="dIrGOq/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00183214235;
	Wed, 22 Jan 2025 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556908; cv=none; b=d5NQ5s23aRZUJKt9MYdGMg16b5b5s+6XVn3hBj6TCNH6QSXCHuAMdmWpTJe3nQKNwl6Fb8YAbY2Yv8tVM9dVNQb8nRiIS9f56YUPEhwnmkOARNA0QcMmXphBxr0GtWqvmlCag1N8NCQUDsDqqt9OSJ68KfVBJ4xYBBw1yxs+xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556908; c=relaxed/simple;
	bh=SrAuI6Xzqo4U/BtMFWcAR5rKSTPYSN+fVoaIp7b0wfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZQX9VXVRbcyl6rdpn5MYq5Oc3olAHDPifsNibBUtVAjvO293SScTWRMYXEJwFKsUfx2kjWDVrcbuQEtbSIFh6qe+BzNHfXIQxDOtg9EDYMsFWm0y1g6PVUMpuTpyFkzBoPP9ybl0+O8B1xT9kjxbP30H3W67e06EuQ5iFIcaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=dIrGOq/i; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556885; x=1738161685; i=ps.report@gmx.net;
	bh=SrAuI6Xzqo4U/BtMFWcAR5rKSTPYSN+fVoaIp7b0wfg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dIrGOq/iqQg3GFU8YoqtJMTbRVkzYwB1vpnEYBvwQp1G6a+HhAXCkA+TgWmpZWfm
	 fU6x383ZH+OTpbzP0+Bu81ndSFXNTeZ0b6UPcpeEkayz8Td4lAGhFShY/P3dlpSm2
	 goHhYKwBfEZ1HZlmzdSY1AIsDHks/7eHikWxDCky+RAnZgKgJ9YBkRRLImZzjZn56
	 DaUxueOuKYAuR4CxrG63FTjsoZWA5AcNhApUchZR5dkwLhSiifd2I/Ut8fRKGt8mB
	 myiR3jwa/YHZV4rr1x9V20CCYKfY5gtLgxY8qOdRRd4/GZDEmxY5QA4nhQgHNSUx4
	 47lkC7dlHOcNuXJ2ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUZ4-1t9JWK3ZPw-00d6bk; Wed, 22
 Jan 2025 15:41:24 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 0/8] Some pktgen fixes/improvments
Date: Wed, 22 Jan 2025 15:41:02 +0100
Message-ID: <20250122144110.619989-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:/wcjGWJRmCXVeylaUlnbgM9rsQe2c+r8+W0QjoAQbKYuk7+nulL
 X/SJ9eYf9u4V6rHwXV/FYgQuQzTh1NKpbOgtmPWVaBQTXenl0Z/ADl+tT2BQig7FRWiiyg7
 iGsjcfoxz9UrAzHAR2i+YbqjkCTrvrbvlk2encsgyonHSaI9ynvHle6V2YNF1+YgYk//zmE
 DKePfyjbu5RJf2beZDnfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DUOCOqGNfLY=;fIWlLC+Jn/p58bj0MZGFt+NemuW
 th4e17QvqECE64/kXSnzRE4FyRIGW90b7EepWipN0ogGemzaYvo1g2nZN2SCvuaAf79UzrjVG
 6Ic693+4XXq9MKlymctdw15kIPQQ3rcfBj0S1zcCAJxocMovMG09oYMBkORPcgYD2XqQAjAaO
 sp2LDkdMsDtpfBp5y035JkLiGDFAHtlJVubUIoeDelGEGby4NS3RjvsA3VeilhUUjRoNwfx+W
 56WIzpM7zk8QLwNC3zymLQvKT8hXAA3J09ygEIYi/eKtbCSoIk2WzBpH6s21+rcy6KRHiW15l
 mvSpp0DLZ7Z/VO7oebtQxj4/kprHNMC1RYBBCxQ25e3cx/NLAESFit5cMgVEcn5BQyW1iTZ8u
 tHY1IQkKBaFZzrs1Sj1gdgxZGYfqZeUlMb0Kp32PUrOqPusNLdmTi1Zeg5cQxSH70f1JKhgMB
 nQ1B8AXtr9/mnQqDOMgcW11zuoC+tiDlrpmdkO5/dXio7yWXRY8+K1/gf/83KvnxC63quMi56
 G0n6kpMW6yMyrrYZ5gX9HpSkIH75EARKVvF/Cv6BeRQoJxWnPMXH2W63/7vzvxrT6CrxwRWyl
 4F3Oc3Ac9ph6nLWKy88yAOUDeIiqs665y2JZ0eRdq8uUgOpy4DG1ZkhUnQ2BqdxJTAeQ/EAaZ
 4HYR0JZih6vYG9FIS2f6yXczGQb1ydOtY4iLcfxNdG7tagCGeu+S+9toEFX4FMx30vjOCUg5d
 Dz1qncnaIJ1bgDS8EUlm2lLoNYhOPzIsViqBwrJSSyAcAOok35IHA5qnG3XBdRKndeW6/gATJ
 2Aq2zpxqxo7lxYwca/xNAFQzbmg5Y2NlspjSmY+5JSqrMN8Cu6GC0+2zz0K+wiQDk89AIoKhx
 6XNMLOdgBLDoW6N+apdINcCH8H4uDO0axDEISbtEAFABqdLshKvRaZNaEnq/q5R2E4GD9UYNM
 hrhhvyMl/Gq+7wlYPj+RGlSuMIBch4f4boFxsva/sSFCdyu7+ojGsdOdR2/BsmRrScXDh1533
 X5kYGNrbDC63wO7dh0w/x8Y/7ZI6E2DOpekaPhPO9q4Evl8f0Rvvz9yGfDxc+NQQThQZy70jT
 c2wBn3u0A+NJAUexqT5RF0FftL+ncnn966DKPC2WabJEP2gfZbFw11yRqCrBVz3DouCVBY7bO
 JzOSWh3ageP2GERfnfk8QSPm7FBXVl429GHmTHr5qrg==

V2hpbGUgdGFraW5nIGEgbG9vayBhdCAnW1BBVENIIG5ldF0gcGt0Z2VuOiBBdm9pZCBvdXQtb2Yt
cmFuZ2UgaW4KZ2V0X2ltaXhfZW50cmllcycgKFsxXSkgYW5kICdbUEFUQ0ggbmV0IHYyXSBwa3Rn
ZW46IEF2b2lkIG91dC1vZi1ib3VuZHMgYWNjZXNzCmluIGdldF9pbWl4X2VudHJpZXMnIChbMl0s
IFszXSkgYW5kIGRvaW5nIHNvbWUgdGVzdHMgYW5kIGNvZGUgcmV2aWV3IEkKZGV0ZWN0ZWQgdGhh
dCB0aGUgL3Byb2MvbmV0L3BrdGdlbi8uLi4gcGFyc2luZyBsb2dpYyBkb2VzIG5vdCBob25vdXIg
dGhlCnVzZXIgZ2l2ZW4gYnVmZmVyIGJvdW5kcyAocmVzdWx0aW5nIGluIG91dC1vZi1ib3VuZHMg
YWNjZXNzKS4KClRoaXMgY2FuIGJlIG9ic2VydmVkIGUuZy4gYnkgdGhlIGZvbGxvd2luZyBzaW1w
bGUgdGVzdCAoc29tZXRpbWVzIHRoZQpvbGQvJ2xvbmdlcicgcHJldmlvdXMgdmFsdWUgaXMgcmUt
cmVhZCBmcm9tIHRoZSBidWZmZXIpOgoKICAgICAgICAkIGVjaG8gYWRkX2RldmljZSBsb0AwID4g
L3Byb2MvbmV0L3BrdGdlbi9rcGt0Z2VuZF8wCgogICAgICAgICQgZWNobyAibWluX3BrdF9zaXpl
IDEyMzQ1IiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAgJiYgZ3JlcCBtaW5fcGt0X3NpemUgL3By
b2MvbmV0L3BrdGdlbi9sb1xAMApQYXJhbXM6IGNvdW50IDEwMDAgIG1pbl9wa3Rfc2l6ZTogMTIz
NDUgIG1heF9wa3Rfc2l6ZTogMApSZXN1bHQ6IE9LOiBtaW5fcGt0X3NpemU9MTIzNDUKCiAgICAg
ICAgJCBlY2hvIC1uICJtaW5fcGt0X3NpemUgMTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAg
JiYgZ3JlcCBtaW5fcGt0X3NpemUgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMApQYXJhbXM6IGNvdW50
IDEwMDAgIG1pbl9wa3Rfc2l6ZTogMTIzNDUgIG1heF9wa3Rfc2l6ZTogMApSZXN1bHQ6IE9LOiBt
aW5fcGt0X3NpemU9MTIzNDUKCiAgICAgICAgJCBlY2hvICJtaW5fcGt0X3NpemUgMTIzIiA+IC9w
cm9jL25ldC9wa3RnZW4vbG9cQDAgJiYgZ3JlcCBtaW5fcGt0X3NpemUgL3Byb2MvbmV0L3BrdGdl
bi9sb1xAMApQYXJhbXM6IGNvdW50IDEwMDAgIG1pbl9wa3Rfc2l6ZTogMTIzICBtYXhfcGt0X3Np
emU6IDAKUmVzdWx0OiBPSzogbWluX3BrdF9zaXplPTEyMwoKU28gZml4IHRoZSBvdXQtb2YtYm91
bmRzIGFjY2VzcyAoYW5kIHR3byBtaW5vciBmaW5kaW5ncykgYW5kIGFkZCBhIHNpbXBsZQpwcm9j
X25ldF9wa3RnZW4gc2VsZnRlc3QuLi4KClJlZ2FyZHMsClBldGVyCgpDaGFuZ2VzIHYxIC0+IHYy
OgogLSBuZXcgcGF0Y2g6ICduZXQ6IHBrdGdlbjogZml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBz
aG9ydCByZWFkcycKIC0gbmV3IHBhdGNoOiAnbmV0OiBwa3RnZW46IGZpeCAncmF0ZSAwJyBlcnJv
ciBoYW5kbGluZyAocmV0dXJuIC1FSU5WQUwpJwogLSBuZXcgcGF0Y2g6ICduZXQ6IHBrdGdlbjog
Zml4ICdyYXRlcCAwJyBlcnJvciBoYW5kbGluZyAocmV0dXJuIC1FSU5WQUwpJwogLSBuZXQvY29y
ZS9wa3RnZW4uYzogYWRkaXRpb25hbCBmaXggZ2V0X2ltaXhfZW50cmllcygpIGFuZCBnZXRfbGFi
ZWxzKCkKIC0gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Byb2NfbmV0X3BrdGdlbi5jOgog
ICAtIGZpeCB0eW9wIG5vdCB2cy4gbm9kIChzdWdnZXN0ZWQgYnkgSmFrdWIgS2ljaW5za2kpCiAg
IC0gZml4IG1pc2FsaWduZWQgbGluZSAoc3VnZ2VzdGVkIGJ5IEpha3ViIEtpY2luc2tpKQogICAt
IGVuYWJsZSBmb21lcmx5IGNvbW1lbnRlZCBvdXQgQ09ORklHX1hGUk0gZGVwZW5kZW50IHRlc3Qg
KGNvbW1hbmQgc3BpKSwKICAgICBhcyBDT05GSUdfWEZSTSBpcyBlbmFibGVkIHZpYSB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvY29uZmlnCiAgICAgQ09ORklHX1hGUk1fSU5URVJGQUNFL0NP
TkZJR19YRlJNX1VTRVIgKHN1Z2dlc3RleCBieSBKYWt1YiBLaWNpbnNraSkKICAgLSBhZGQgQ09O
RklHX05FVF9QS1RHRU49bSB0byB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvY29uZmlnCiAg
ICAgKHN1Z2dlc3RlZCBieSBKYWt1YiBLaWNpbnNraSkKICAgLSBhZGQgbW9kcHJvYmUgcGt0Z2Vu
IHRvIEZJWFRVUkVfU0VUVVAoKSAoc3VnZ2VzdGVkIGJ5IEpha3ViIEtpY2luc2tpKQogICAtIGZp
eCBzb21lIGNoZWNrcGF0Y2ggd2FybmluZ3MgKE1pc3NpbmcgYSBibGFuayBsaW5lIGFmdGVyIGRl
Y2xhcmF0aW9ucykKICAgLSBzaHJpbmsgbGluZSBsZW5ndGggYnkgcmUtbmFtaW5nIHNvbWUgdmFy
aWFibGVzIChjb21tYW5kIC0+IGNtZCwKICAgICBkZXZpY2UgLT4gZGV2KQogICAtIGFkZCAncmF0
ZSAwJyB0ZXN0Y2FzZQogICAtIGFkZCAncmF0ZXAgMCcgdGVzdGNhc2UKClsxXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNDEwMDYyMjEyMjEuMzc0NDk5NS0xLWFydGVtLmNoZXJu
eXNoZXZAcmVkLXNvZnQucnUvClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAy
NTAxMDkwODMwMzkuMTQwMDQtMS1wY2hlbGtpbkBpc3ByYXMucnUvClszXSBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29t
bWl0Lz9pZD03NjIwMWI1OTc5NzY4NTAwYmNhMzYyODcxZGI2NmQ3N2NiNGMyMjVlCgpQZXRlciBT
ZWlkZXJlciAoOCk6CiAgbmV0OiBwa3RnZW46IHJlcGxhY2UgRU5PVFNVUFAgd2l0aCBFT1BOT1RT
VVBQCiAgbmV0OiBwa3RnZW46IGVuYWJsZSAncGFyYW09dmFsdWUnIHBhcnNpbmcKICBuZXQ6IHBr
dGdlbjogZml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcwogIG5ldDogcGt0Z2Vu
OiBmaXggJ3JhdGUgMCcgZXJyb3IgaGFuZGxpbmcgKHJldHVybiAtRUlOVkFMKQogIG5ldDogcGt0
Z2VuOiBmaXggJ3JhdGVwIDAnIGVycm9yIGhhbmRsaW5nIChyZXR1cm4gLUVJTlZBTCkKICBuZXQ6
IHBrdGdlbjogZml4IGFjY2VzcyBvdXRzaWRlIG9mIHVzZXIgZ2l2ZW4gYnVmZmVyIGluCiAgICBw
a3RnZW5fdGhyZWFkX3dyaXRlKCkKICBuZXQ6IHBrdGdlbjogZml4IGFjY2VzcyBvdXRzaWRlIG9m
IHVzZXIgZ2l2ZW4gYnVmZmVyIGluCiAgICBwa3RnZW5faWZfd3JpdGUoKQogIHNlbGZ0ZXN0OiBu
ZXQ6IGFkZCBwcm9jX25ldF9wa3RnZW4KCiBuZXQvY29yZS9wa3RnZW4uYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyMzggKysrKy0tLQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
L01ha2VmaWxlICAgICAgICAgIHwgICAxICsKIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9j
b25maWcgICAgICAgICAgICB8ICAgMSArCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcHJv
Y19uZXRfcGt0Z2VuLmMgfCA2MDUgKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDc2MSBpbnNlcnRpb25zKCspLCA4NCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcHJvY19uZXRfcGt0Z2VuLmMKCi0tIAoyLjQ4LjEK
Cg==

