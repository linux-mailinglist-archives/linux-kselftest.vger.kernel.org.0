Return-Path: <linux-kselftest+bounces-26522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA9A33D4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D7188DD26
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC4215780;
	Thu, 13 Feb 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="oSh9PzJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E4215760;
	Thu, 13 Feb 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444454; cv=none; b=cLfRSYxrHz9GtO3Oaa7NObEJwUyM2QNvv1ozBbTloedpqvtVtEMv21IbQjsP5afMPg7ws8ujLnu6Me+vcKbwhWcKNUgDn02U+AYlGvQ2JQ3JzFO3dgpQfvT6Jd0z6PtJS+jT9S3OyhKO7Eiz530LeutR2RjUEv+hwsLE8OBO++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444454; c=relaxed/simple;
	bh=OkoKFeB738bTGBSwaTIC7RA8vbYdSWHDpGQpy1zHNqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOV6QPVEIaV8ei/bGDm0Vk8LRSUJWfVHEF+zZvHmX0Y3GQ/3pfS4bUv+NjmFqzq5dL5Ds5/430IbIuTYSua3Wd+U7CWIZZNezgrP7C5ZgEbMOTEnncLLQBykzBguRWKeZdEZ56Z2BcwlLPC2We0h0yhiascUv17PFRntjIsgUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=oSh9PzJX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739444431; x=1740049231; i=ps.report@gmx.net;
	bh=OkoKFeB738bTGBSwaTIC7RA8vbYdSWHDpGQpy1zHNqQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oSh9PzJXtWdKL/hieKDUIijlcteFf+msn/u+xhPrLRvts/09VAKhdY/LxrwBHoJw
	 J/Ni0UhPPQOTEJzMy9HcdkHe9/btXGK+n5M8ytMI2afoN49tzY4jRJWCU+/ajpV6T
	 k8bc/4lYGQsIl+hESiX5dd2InWxsueVHPP4liChYEkRgjsu5lEiCGbpotPhjewIiH
	 QL6l/YAjR923KHVRfb7k3sv0bDVRb4ocVGnZIPcg1/VHZmh3hAmyGartwZOTqqvTg
	 ZgG3JntPB51fwf2eMitUjILELKVdawsULYjEBayJuwE3EPh4cyKsADwimcasYk92X
	 9zTnNfITQLBpnqK8Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1tPd3i3hPY-015DvS; Thu, 13
 Feb 2025 12:00:31 +0100
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
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v5 3/8] net: pktgen: fix hex32_arg parsing for short reads
Date: Thu, 13 Feb 2025 12:00:20 +0100
Message-ID: <20250213110025.1436160-4-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213110025.1436160-1-ps.report@gmx.net>
References: <20250213110025.1436160-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ye8dF3Z7zTMLdlHScKnbq+TuRFhD+q9H/EoAjn3mJCh2b+qPO3w
 qG832OytHXJAZxsA5zs9Ntl0vUyd5bZQKiU08NruMWb4pOQqCCATWvLkuj88Ggb+B3kqLDp
 RQCOyf8UZbTRzxWPGx6aXgMcvwVnPHiGjgjGElDkKHutnZq86RTBffuBe/aCk3pVrHjpWNk
 /VAiVXCgFJrBq7ozg56Bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ovcss+NKSy4=;x5NsgwMkqe9L8t9L34eN8uwQeRX
 Wvae2iQFjYZCqRcuwoC7Ie2gKZ4cVVwnWGxYlQ0IX3aA8E7yF7DARuvfbWqemGNxRHFsM2Q2Q
 Q7H1O4+x8zOFqbgcUNF7fNoMJejCpekhJP/Lr/TWuV3i0vICa2dBiXhdA50TzfschGyAjCGa/
 N1bAPwOBiUejq8CZk5LtcG8vjHVzVxyu6RWJ/S4hIlN9URH8x3ztyF21x2BrLOWWdQhWz9aps
 nObuXJOYFSp3RIskCkSfBieTnSPaocFqtbe/Yukhd67QNF8/pgsVLqoGpOjKNctJJnrxMUswf
 goUWx8wSragvKTj8g+sqFuFFv++PT69UZeZ39JfFSbRh9oTnk/GiE6jiPhQQfo+3HHhR1Gxh2
 +0a7lDt8R0cq+yuNVPNg7bWEokcfaFm/aWCq7tMSl+U7xX6M7nvPAQuZXwg9rvTV3X3fCMUYa
 k9yQZ2WVhbPPBHCgT+45N8oFzWgE0woyWdSMUZb/rZ2WzCvmbC9fSYDT5/raVJjMhxJUEg29D
 pi+OScjwSeCg6F/x0SWariysXHPLi/c+DCcoNWqu0/Xwr830QkNGEZL3yw11tLjQtoWspQrEL
 s+RsjDfhIAJ70acxN8utMGQYSVZ6fbmE4N9/J1rdVRSvNm6CVQwLcFFFjozmITjghHNtlzqN4
 R6MfDK+O8splj7z/uj174vFYuOqgIRM5bjyMk1hrxqIQvKN2Ywdki//j3C914nB3XtllSYsJw
 dOEEtbfXU7lMHqYXhc1xkAimV2n2qHceiRjaRRXrdBfBPpyepgNnFC+Fdhuz9LQtg8UpehP1y
 NQN9/sXX2PaviexWbl03STkcrdYiw1YQcxtWoC6A8Y0Zr3ITlKFOHJmsEA0fmlS7yqmNmME7c
 N8U2beG1ISW9WAlMpsBMRwzfvHC/GVkE53PluJphcTDS4kdGVbwi/nvUKjgvQWC+eJQG8UZhq
 0perq28tJ6rj/ZPx/jiEMytO6/0NvtM3PkkSNtvFdNL4NIsw8i6tl2fSw5jR7nakstEzJZ493
 5aScZWOgxyMyfp4T7yB/YXaEogg1/NoQ25ikyQ1jB2PmDaYH+/yLuVbY9E0Et04Nd+piO2TLG
 IykZdDH4dVuUzQe3wTWdjJEYZWjd15GXYPhIEcCBQx4Va0N7lnPYPNQcS3jdS/JUGAoqhXsFb
 8xahDc4zUAUZgNAjVH0VSum5fA4BzSNH0acfcaHLmSAgVhiNkGYvAL7mbAHQmd+6/WeYDk9yX
 urxxs0k/rV/AUCsMqmU/4Q3OXRwV7VeVM82Y0scP1h2H3PN91AS8+uV54mybKlpVp+5q2Nrr3
 pGrQjdICqlUgXc+gSmU4CFD0ayJ2dLEnmw9W19I9YlZdEMbBqC64yNFGvAVDLQpVGSy+qnfCG
 5qMpmyUzINTM6wx8x6vOHC3BYjsp3iPxvj+F3rTHHnVRbSTGitte6KBXlW

Rml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcyAoaGVyZSA3IGhleCBkaWdpdHMg
aW5zdGVhZCBvZiB0aGUKZXhwZWN0ZWQgOCksIHNoaWZ0IHJlc3VsdCBvbmx5IG9uIHN1Y2Nlc3Nm
dWwgaW5wdXQgcGFyc2luZy4KCi0gYmVmb3JlIHRoZSBwYXRjaAoKCSQgZWNobyAibXBscyAwMDAw
MTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZ3JlcCBtcGxzIC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSAgICAgbXBsczogMDAwMDEyMzAKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDEyMzAK
Ci0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvICJtcGxzIDAwMDAxMjMiID4gL3Byb2MvbmV0
L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBt
cGxzOiAwMDAwMDEyMwoJUmVzdWx0OiBPSzogbXBscz0wMDAwMDEyMwoKU2lnbmVkLW9mZi1ieTog
UGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9y
bWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAg
cGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFu
Z2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2
MzoKICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBu
ZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25l
dC9jb3JlL3BrdGdlbi5jCmluZGV4IDRmOGVjNmM5YmVkNC4uMjhkYmJmNzBlMTQyIDEwMDY0NAot
LS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtNzUzLDE0
ICs3NTMsMTUgQEAgc3RhdGljIGludCBoZXgzMl9hcmcoY29uc3QgY2hhciBfX3VzZXIgKnVzZXJf
YnVmZmVyLCB1bnNpZ25lZCBsb25nIG1heGxlbiwKIAlmb3IgKDsgaSA8IG1heGxlbjsgaSsrKSB7
CiAJCWludCB2YWx1ZTsKIAkJY2hhciBjOwotCQkqbnVtIDw8PSA0OwogCQlpZiAoZ2V0X3VzZXIo
YywgJnVzZXJfYnVmZmVyW2ldKSkKIAkJCXJldHVybiAtRUZBVUxUOwogCQl2YWx1ZSA9IGhleF90
b19iaW4oYyk7Ci0JCWlmICh2YWx1ZSA+PSAwKQorCQlpZiAodmFsdWUgPj0gMCkgeworCQkJKm51
bSA8PD0gNDsKIAkJCSpudW0gfD0gdmFsdWU7Ci0JCWVsc2UKKwkJfSBlbHNlIHsKIAkJCWJyZWFr
OworCQl9CiAJfQogCXJldHVybiBpOwogfQotLSAKMi40OC4xCgo=

