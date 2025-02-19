Return-Path: <linux-kselftest+bounces-26945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B7A3B518
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A00E7A209D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90B1EFFB8;
	Wed, 19 Feb 2025 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="aIJ2iyGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AA1EFF94;
	Wed, 19 Feb 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954748; cv=none; b=iq0xTGh8N32mWbiaSSH7Cs5xPo9/YnvKU3CBIl42wjTelh2fZTdQmUf//m+paZ/wl4A/5uSTbSbLKwZgBg9AelpwIIzvP3jLalE3U14ANKpA64ag3T39qdV0Hp+LjqSW5vgy9YY3RzN5xHt+Hvn28pgn9vy/8x6t0AiyYofaf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954748; c=relaxed/simple;
	bh=jQSyn7wtfwTSn8STW3p9jeiyw5W5pOvWUq+BYK5KgUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC9iPrRMdgJC4TYhoXW9jEar7nS5gOotHHPtqK4gHnaY4QFeMvYMAgnFMvKsHCb3xiNPwig2aYsNw0yDcggW9ziGiewXxph4pMCJFXILfxidlArSedU1Qu89jdo5dw8pX2JZ7cu3tU4EhSHzk99b+IRZgUHtHT6tq1kym3jhFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=aIJ2iyGu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739954734; x=1740559534; i=ps.report@gmx.net;
	bh=jQSyn7wtfwTSn8STW3p9jeiyw5W5pOvWUq+BYK5KgUg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aIJ2iyGuaiMbE93A8dGpRLJ+KLxRMmNzm4Ckzx95d2mdRud6MSRyo4HS2pbuK7ys
	 Fa8LtsGCLdcMUrgG6BDGCih8jT2wucwyuVER13gEV0/a960+dMyV2XUr8NY1vHNEX
	 2VndcWJU2GTzPNvAxRgw0yAvpiozQH3mT514wJdTx1785MONbjASELWJLGAmbvTaQ
	 Q1NQZ/iHeVglPzjGmv61YyHMA0+0CAz4BoP+F9QpndI7GSswNXzxOVUJW67I2LcIX
	 3v4BoHX1ZbxWhOFp8lRD4OTzQAYeYSnuDZELi4oOdns6Qn7vTRUNC2zG4RkhUowJA
	 o2rtvlyhy11fZwuqCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1thcm12Q7L-001O5Z; Wed, 19
 Feb 2025 09:45:34 +0100
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH net-next v6 3/7] net: pktgen: fix hex32_arg parsing for short reads
Date: Wed, 19 Feb 2025 09:45:23 +0100
Message-ID: <20250219084527.20488-4-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219084527.20488-1-ps.report@gmx.net>
References: <20250219084527.20488-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:9pn5Xrv/PCkdI1VP/j57XJtVIK9FZHbIOPMwNdHfkmam32zOdAm
 V3b7cvWY9P+wHyNgfwx7nbq44iVrmXbrbUNtCgVLJf1z8OyZAQh36qya793zF+d0PoB9uqf
 Bouu9Sw1vfW9btRlDKLCpjDeA05aUQYEdIg31el2U5IypYm3nbIG+Q+m16js8ugMb/tieI+
 75ncs1bnoYBZN5UAlMQ9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RaQ9u2grzD4=;0in4g0i/E6fnVkVP6XR0MTGuMyl
 ahQVdQqLxK7T2Ri78B57hAyJP1fxTHLZKQBfHb7BCKDkBP4oyRHkx3UFmqMiLSoxHUEuZ/569
 qhuMyX2+3Ot1Wo3AzawAPBIRCXLtKi7LAmDgBXEyCP7LjE1Dqav12YTlvhR6CYlylHcbpytYC
 tvo0u3FWqtNNJYATSXdvJgUhJkdzt+CLyMbYUXZPFUu/JG/9KzPJYQGbsEzod02D7sFbAqINC
 wzY0LJFQ950tmicGMtgaPHcHsFUH3lNY8qJuBmykpMmq5koUSZSceQIC+PERW7bLMjMl4aC4Q
 2BbBkJoTuulBLnUjoA9snroAipAR0zoF+DRLdaRV5I8aFM/7SiWZKKY3e6LxqdqNJi+7qaMdI
 bhHp/b00E0XudeK3qRGHUPRv/CKTP/dd8g5dPOb3FDC1+pzsAP8IyIenRj6SDRJfyrwUP82Gf
 Q3xfJWnP2ukk/p/P2CHIJwtm9+D1a5qDHl/3+4h73lYZCm428t8J+vt8pckR8dtL3YtFo/MNw
 EcswZagW/vATFCrAZf4V98aqhxNR5H06C4YX9NyzDZ7NY2PTBkGQtpMLkMTXzSrtyCjaWlpcS
 egNc0W/zm7SrOboiKVrPdz+viLzz9H3AA0uvL3V2/p6ufXvgAQfp3652AGAkIUEOF75Jvgtzz
 AO4aZhcjyMPa+wNs50KIGwRC8Y6tj9KKgtdiKak1L9/4p2N6e4is5DGftoCO0i6oWq0ODJOaU
 OLWbDEYquVAK3cqljFor0jxrLJYX8W8lINwjnT5GZTulTZM22Z26FdoVeKfiucZl54Z1Ce0h8
 C1S6mCz64Fm/z8Jhkk+AejmfatQEhtevj/SP+ntPVPEct5aTbJ2S4CBYewrhe5zW8A4+jpWEF
 eSdpbgCZnjNYlGNIqfVAsn/phHcWUVWsphUizEOXSjXBJHqFGOXkOGhrUcea0AI2DIF0dYLUG
 37kcLjL98gcarm/G7mu3FxvdCn3T4XO5Wfc8QwaZ1GgM0DUMPRTdjvdZUP0U+jrqNHzxNDVcn
 LPT5gGQM8xkT5YgMpGNBCIjALEZY0cHbL5U1pVC3vLdRUmMQrSu3IlWEjkCrSQKHRcEg635Jp
 HCxw3ILK0yJCT3I9iea7bkTvkZOPVXXGco3sxfBpbBYxknjlE4AKrNaTJTAzMt1/kKWQgly/1
 Mnz8o2MvVmUbUsGAMvMRcDODWOuI0Jt+zCjm5USI/StOSVf/zb1hmVNGMM53osUoxiqvfos3N
 AeNGrCS5uV4ov1j4c+EcKZImadhURSO/IromrvryaHiRz8NMuiPRJ5fCirlUnXC7OM2AaXdLO
 vIe5e9e0w5pZcj+Yiw8S/wcZa7vGnduCOn9KFm+55DGXkFOPqyxE8Rs0QFerML+BVE1lA7ozC
 D9pVZWlOtNHmMI4RaPAt80qqg4Quz3hp9qNfGJNmQ9Lc4VwFWfHn5Rs9uL

Rml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcyAoaGVyZSA3IGhleCBkaWdpdHMg
aW5zdGVhZCBvZiB0aGUKZXhwZWN0ZWQgOCksIHNoaWZ0IHJlc3VsdCBvbmx5IG9uIHN1Y2Nlc3Nm
dWwgaW5wdXQgcGFyc2luZy4KCi0gYmVmb3JlIHRoZSBwYXRjaAoKCSQgZWNobyAibXBscyAwMDAw
MTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZ3JlcCBtcGxzIC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSAgICAgbXBsczogMDAwMDEyMzAKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDEyMzAK
Ci0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvICJtcGxzIDAwMDAxMjMiID4gL3Byb2MvbmV0
L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBt
cGxzOiAwMDAwMDEyMwoJUmVzdWx0OiBPSzogbXBscz0wMDAwMDEyMwoKU2lnbmVkLW9mZi1ieTog
UGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9y
bWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2NSAtPiB2NgogIC0gbm8gY2hhbmdl
cwoKQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0IGkvaWkg
KHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBhZGQgcmV2
LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAtIG5vIGNoYW5nZXMKCkNoYW5n
ZXMgdjEgLT4gdjI6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysr
Ky0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDRm
OGVjNmM5YmVkNC4uMjhkYmJmNzBlMTQyIDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYwor
KysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtNzUzLDE0ICs3NTMsMTUgQEAgc3RhdGljIGludCBo
ZXgzMl9hcmcoY29uc3QgY2hhciBfX3VzZXIgKnVzZXJfYnVmZmVyLCB1bnNpZ25lZCBsb25nIG1h
eGxlbiwKIAlmb3IgKDsgaSA8IG1heGxlbjsgaSsrKSB7CiAJCWludCB2YWx1ZTsKIAkJY2hhciBj
OwotCQkqbnVtIDw8PSA0OwogCQlpZiAoZ2V0X3VzZXIoYywgJnVzZXJfYnVmZmVyW2ldKSkKIAkJ
CXJldHVybiAtRUZBVUxUOwogCQl2YWx1ZSA9IGhleF90b19iaW4oYyk7Ci0JCWlmICh2YWx1ZSA+
PSAwKQorCQlpZiAodmFsdWUgPj0gMCkgeworCQkJKm51bSA8PD0gNDsKIAkJCSpudW0gfD0gdmFs
dWU7Ci0JCWVsc2UKKwkJfSBlbHNlIHsKIAkJCWJyZWFrOworCQl9CiAJfQogCXJldHVybiBpOwog
fQotLSAKMi40OC4xCgo=

