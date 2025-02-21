Return-Path: <linux-kselftest+bounces-27242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6128A4025F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AEE4412F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1104257AEB;
	Fri, 21 Feb 2025 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="qqXXQ370"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6AA254AFC;
	Fri, 21 Feb 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174791; cv=none; b=DIIfy5wcQF25oupJYuAt5G1SLsgdFCSjgYl09wnVD3lGRKWH3zEPIpOW6fsokwnCBt1OhdkOZlWch2H/TNMgI3UDbGB3qkbalXlKO1XDe6HdJaag1rYco5dLqaY3/nQUH4v0MXnMR/CIktGa0RnjMhEKss1C3jXtP0eLVQ1qpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174791; c=relaxed/simple;
	bh=Qwm/ZyjpdhkDocHMi8i0ILfU4x9hiN8jcpFLjrntmoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3gHb0j28gvVIgMzSymh6/nz5lNAVIEi5wvNTs2QTxFyYwc+JAuon1r95UQMGzL0N+QkC0rxTfmxvu68aXwg1NC0OI8W46plceP57N9CUQiD1Xdm7PYqgie3F6BywkK3kMmb+qEYGiKeOZ8btvqeZAucH36s7UxvqLfc4aFzeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=qqXXQ370; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740174772; x=1740779572; i=ps.report@gmx.net;
	bh=Qwm/ZyjpdhkDocHMi8i0ILfU4x9hiN8jcpFLjrntmoY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qqXXQ370oFnCrQBLYEVKs1nHXoRDqA1ZhAjqhAPRLfu4sjpodQVzHtPCU5XJlIWG
	 XCMpi0Pjr85cLkoyrTKYG+YBL39Mq4EMpJY4VX1Bpxb/x1RHfuqHHreVMoNAZN8FR
	 UzHiRtkcON5DiIx2qPrld+PG3iRd6hTPO7OqrciS4evAy0NuAKke7lJkg4ycjUWPe
	 y2DfJ/+n6R4UlaGrb9gYTfbofGISfZUx+lCsfjpJEhH3Ka/Lhr6M5fhnH3Geegwws
	 lGJ2ljflG6hyXOf01G1NBSSsWmjsP1CS5kIabLYU1YkPzvugDcUWIJTpvL3xWSSpb
	 pPn4/4VbbE+LDk2GcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1t23mp1W0p-00qSBz; Fri, 21
 Feb 2025 22:52:52 +0100
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
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v6 6/8] net: pktgen: fix mpls reset parsing
Date: Fri, 21 Feb 2025 22:52:44 +0100
Message-ID: <20250221215246.383373-7-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221215246.383373-1-ps.report@gmx.net>
References: <20250221215246.383373-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XCPdRkYaXrxHVQCYuZroPgUyVu/nBy1PlfUO+RagSKzue6EGDh7
 9a1Jv6eGKwNWYW1zNyRtQfBa0Ttf8fqDql7kvE78cb8UIqEnoo+GrfBfOZfb7sibNNIsp0Z
 2vivF5GhMhHyIlC0M6dbbLyF7kbT0Hh8eZnCcvkf/CR+VVU2QW/7PQ4D8yUNdhUle3tT0Q+
 TLxVsVZXCl2bBpKqXMuyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3BS/0PHFWLo=;QpWdXmmbMNa+DayRbtScybxB2Mg
 5w3tmXepl3PdJuTrlQZedwb99MKBiZJqseK62zCy/1A8JoP85ob2F229Hsg1sfecwI5sKszbW
 dplUUcKZ1UgryZon0y4LaWGhjPOZsWhl+kY2tt3RGr2tBpSQLKvV3XZwZ+NK9vG49iyuMMPSu
 rhj2YYRKorX4943ZtivWQKMx/CCBP4wtOOyb9v7nGwdwZoX0Vx1yYEQJnPt9dH37wdE+mzTSA
 QEGAAx4ssnLf/Q3DB/NTHWTH/+8G9DqvSoDrsW84JI/SGpXqP9FlqPAg2XPIBMaKwpYN+TCXw
 GjGwOeuVb2JXZ8DbUViIhENI0uf7dFKfTAwF32Fn3ehviqvcPwLjnFtGJFQIqmF5N44OoC9v4
 KeYE2NQtYOFx7nYfSSwBfxzfavuawHoIptbR8+T4i4zZvSbjhSx8nGkH45zXxATmGfm7Xl80W
 +hvvSCAtZkiuwjdLjHkPLXJpDGzHjszkOx2Q+nwRzF7PI9YDwkg3dxfw8OQy2Z/4uWaFTeiIV
 fRaJc1i6SzI2gDui9mdtTYJAE0g2gRzZodbIuh4maeAeIVbOLsI0Adz7H2kI26yoXNu354GKN
 XRDWTbK1M/Y1A+WMrmyiM4ts2k8UGQc1QV4TNdWUX8vX33QM8R8c3K3B+7nw99iCbvRBuvcmL
 aFse7hA2vJw63YnHNEyvSnYkZTPMdBgIqkf8oXBI5u66/EN1wATtmyoiFsPtZfQqpQo8PgY70
 LHYLKMbP/l2eNmwABTJiYXBGkKJszIyLXfVeD9IWTuvnRNoMCWjXAXa/6Cus1vQgAmjTTjgnW
 E/iMSoKimm5XzKE4s8K9BjTTn20u/8F+YGQ+wFhNDV6CptAJyM7mioXTYWW2Oh9d5wC0JwFwc
 WUtmVNVYvh5qVH2Yu3AM/t6xsxhRGZJGXHCFIdtiy93Q1Kp6FMi7Li0Cn41Ruiu1UI0953I9z
 uAqBiYsrPhLc9wVG7XiPYhewm14Rhzy0dLkD5K4q/BOBD2u5t7Jw8i2abtaMJEwP90kf2fgku
 rZjdidu8kuXPUAt/ltg+AzsaITb8GL64kTmz+bkkrC7GNya93gTZHVE9Q971HNgleFHwOEVsE
 0Ctz3/UD75mWZrx0bLDcXn4AkrbW8+KLbzG7ZWWSByT8rolW6GWCkc5dNusUfGDL6PjHWBotO
 pmT5yAX+byCV27jTFxy8dieulmwu0x6wXko81kWe8lSFsaRPiYBmyKIDTBm0blPVQBawUg7vJ
 u6Zq2B/53xlcFRRB2yKOBDxxjESZk0D2Z/Amhf++0gqo1oKbFK5+UrA1n2D3quGMeL/5iPdVe
 Ewm2VofVPOG9MuWLWYT0eudRcLksjan+y6lqNiTzcnIuoVZWFQCd+ro/ahBfAkG6ylTltihWy
 gER9Va3exVHWukzusBVcWUaruEUPMgM3TeOVbYKJw9LDMcUZWQFLcKp9vO

Rml4IG1wbHMgbGlzdCByZXNldCBwYXJzaW5nIHRvIHdvcmsgYXMgZGVzY3JpYmUgaW4KRG9jdW1l
bnRhdGlvbi9uZXR3b3JraW5nL3BrdGdlbi5yc3Q6CgogIHBnc2V0ICJtcGxzIDAiICAgIHR1cm4g
b2ZmIG1wbHMgKG9yIGFueSBpbnZhbGlkIGFyZ3VtZW50IHdvcmtzIHRvbyEpCgotIGJlZm9yZSB0
aGUgcGF0Y2gKCgkkIGVjaG8gIm1wbHMgMDAwMDAwMDEsMDAwMDAwMDIiID4gL3Byb2MvbmV0L3Br
dGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBtcGxz
OiAwMDAwMDAwMSwgMDAwMDAwMDIKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDAwMDEsMDAwMDAwMDIK
CgkkIGVjaG8gIm1wbHMgMDAwMDAwMDEsMDAwMDAwMDIiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xA
MAoJJCBlY2hvICJtcGxzIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMg
L3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBtcGxzOiAwMDAwMDAwMAoJUmVzdWx0OiBPSzog
bXBscz0wMDAwMDAwMAoKCSQgZWNobyAibXBscyAwMDAwMDAwMSwwMDAwMDAwMiIgPiAvcHJvYy9u
ZXQvcGt0Z2VuL2xvXEAwCgkkIGVjaG8gIm1wbHMgaW52YWxpZCIgPiAvcHJvYy9uZXQvcGt0Z2Vu
L2xvXEAwCgkkIGdyZXAgbXBscyAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCglSZXN1bHQ6IE9LOiBt
cGxzPQoKLSBhZnRlciB0aGUgcGF0Y2gKCgkkIGVjaG8gIm1wbHMgMDAwMDAwMDEsMDAwMDAwMDIi
ID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9s
b1xAMAoJICAgICBtcGxzOiAwMDAwMDAwMSwgMDAwMDAwMDIKCVJlc3VsdDogT0s6IG1wbHM9MDAw
MDAwMDEsMDAwMDAwMDIKCgkkIGVjaG8gIm1wbHMgMDAwMDAwMDEsMDAwMDAwMDIiID4gL3Byb2Mv
bmV0L3BrdGdlbi9sb1xAMAoJJCBlY2hvICJtcGxzIDAiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xA
MAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBPSzogbXBscz0K
CgkkIGVjaG8gIm1wbHMgMDAwMDAwMDEsMDAwMDAwMDIiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xA
MAoJJCBlY2hvICJtcGxzIGludmFsaWQiID4gL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJJCBncmVw
IG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBPSzogbXBscz0KClNpZ25lZC1v
ZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KUmV2aWV3ZWQtYnk6IFNp
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgdjUgLT4gdjYKICAtIG5v
IGNoYW5nZXMKCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNoc2V0IGludG8gcGFy
dCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQoKQ2hhbmdlcyB2MyAtPiB2NAogIC0g
YWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBuZXcgcGF0Y2gK
LS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3BrdGdlbi5j
IGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYWU1ZTgxZTYyNzMzLi5iYjEzYTQ1OTE3MDkgMTAw
NjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5jCkBAIC05
MTUsOCArOTE1LDEzIEBAIHN0YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29uc3QgY2hhciBfX3Vz
ZXIgKmJ1ZmZlciwKIAogCQltYXggPSBtaW4oOCwgbWF4bGVuIC0gaSk7CiAJCWxlbiA9IGhleDMy
X2FyZygmYnVmZmVyW2ldLCBtYXgsICZ0bXApOwotCQlpZiAobGVuIDw9IDApCisJCWlmIChsZW4g
PCAwKQogCQkJcmV0dXJuIGxlbjsKKworCQkvLyByZXR1cm4gZW1wdHkgbGlzdCBpbiBjYXNlIG9m
IGludmFsaWQgaW5wdXQgYW5kL29yIHplcm8gdmFsdWUKKwkJaWYgKGxlbiA9PSAwIHx8IHRtcCA9
PSAwKQorCQkJcmV0dXJuIG1heGxlbjsKKwogCQlwa3RfZGV2LT5sYWJlbHNbbl0gPSBodG9ubCh0
bXApOwogCQlpZiAocGt0X2Rldi0+bGFiZWxzW25dICYgTVBMU19TVEFDS19CT1RUT00pCiAJCQlw
a3RfZGV2LT5mbGFncyB8PSBGX01QTFNfUk5EOwotLSAKMi40OC4xCgo=

