Return-Path: <linux-kselftest+bounces-27324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CFBA418FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849907A3D2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07332505A1;
	Mon, 24 Feb 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="G+zSAxgy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6224E4DA;
	Mon, 24 Feb 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388984; cv=none; b=Wo4ryEyvl1eKa7lIfq5DC82Hoq1Y1WivGfj0bRdpMYbWKPGE7gpOsbF+jcKCivJ7p8q13oPCqwmT8E4UdXkzAHSCg7sYyfwVWuge4VKNlhSQhslBSqfLbNtsZEAoQ6nkCctgx7GiedVjWD8Vw5MNVTs4OAO2S0dLCZXv28DbheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388984; c=relaxed/simple;
	bh=kRFGlPJgnIW7IkE6wIvC7DL94aODzN6M4qobmhxPsWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHCpu7iJhQRZjzrYmKpxdRzXtiZh4tXY/bYllSF+KUDC7D1daq7Nn9pa26/eI/yQATb2zq1v74CEye7GEtyOQEjtp/US/juskfsph5pE4K2v2S8296BuB7dEn7Ls1urbV5vzblNQVKsj9U3wNRBtABFTDyBNlemE3XWDOsw+OJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=G+zSAxgy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740388972; x=1740993772; i=ps.report@gmx.net;
	bh=kRFGlPJgnIW7IkE6wIvC7DL94aODzN6M4qobmhxPsWI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G+zSAxgyfm/kxcEcfjDI/yHowo87U4Z12CJU5CtK09Qt218Lggq2ddHrm0IxqeCk
	 UFACoV599Qvpm45qgHjohd7u59Ib+vrQ2jCISRqAsOxAAUkQtSAQ0paollNsZc7Nz
	 O00QYspIZdy7FpsPqad/jQsJC73XSh6CgZR72reW/o/aiilUHB5YpOouFIoULI98+
	 4OWuN+fXOTHrdHm/6L05VjodXtOLu+Wk6cJ3S3ZYpcQzorxUuWwEfcEj8uvQO+9XX
	 Plub2QSlGrFpYbqSonFPCGUTi4EDOX4Y+PlwiDUhhUKhp9JgPlbUH0O8mR8yo72Fq
	 m3I+NRsgXoLDCfGlig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.227]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1tc00c3V3C-00DGQq; Mon, 24
 Feb 2025 10:22:52 +0100
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
	Frederic Weisbecker <frederic@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v7 6/8] net: pktgen: fix mpls reset parsing
Date: Mon, 24 Feb 2025 10:22:40 +0100
Message-ID: <20250224092242.13192-7-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224092242.13192-1-ps.report@gmx.net>
References: <20250224092242.13192-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:8CmP8IrLCVeESkIphKVCLcRoepPcXiSiAUMVWzns9yYJozc8YJY
 Al0aGb2R+pSzHzfFxSj4f9Z4mYLJ9V/Biwd2pwxiBVKdX6GrUUpoa+e/DHA3b4+pjfxfWHj
 S2rcf1HPAD4ur2bChXTCoDgDHlCquBf4bt7D5OeIHmUHBelbEyuf82mk17NUUuHUBBxunH2
 Vkwjn75Zl2Hfev33oJb0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nt7r+GWd794=;FHASirbO5CZC5j13Ue17qfo5Y0q
 M+FXwUcg6q3EweCHI2GDDVShWPGsBSwh676Mqi5CU6uQvEjQVYlhNNQoiPCwvw/xBzZ431fGB
 cXD2aRby5aMcJy+ZlSVZfvh7xMr5h8W93v5KpLrFbNEx3kYoAp9FozzNoz3auBjWRDavUdi75
 piF2tkHtd4HpPFAKQtN84LeM1+QGjpa9RbwMSzeqEzr4mCppUEmROb8kflBrtg6fdpjlatiWL
 MTaK/x7kvjdyFH7KfbEapYfLwYmF4EYpaTVX9RDLFNbyDg4H7lkIzFr5ZUADL244TFIYlOqxC
 hQC1srqJEGRZIWI83+HwuAiABxkoFh/FDjBsr2wa6IKPxrNl8UPqQxdRDJUOBSmZYxGHhZ0Gt
 BWGJXHqQ19eQkmynxbpEo7Ml8stQaGsPTgsj78i/aLkOtrS/BGOCs+lSI5OMOVHQF5I9SShyo
 od1m1nawj2dBD6WEowlmbW42cau/iLeCiZtQn+AxWHWDWtH5k4/KoJb3zQhlfNVusT4f1M8qj
 Gkx5smRxWfg7HriWIhIcGe2wh5ZTdFhvRprctpjDk9KUHG02jz5wH1dzLBOuSw5M7BkL1Jcgi
 UaT2fiidqs5jpJ7o0lOQJZm5kbUB3PHVh0clEV746Dyz6o7S83Vn4iqEWCLSOUo9PGLcbl6w+
 +m8JshcF0mPRoIUQ9LTPJoBpqg4WuSrpr/zQbogzukxYgEme/8i+Sw5MDBvMM/AjrcFydvm1i
 GBKYcM5kNRa9ImUnwaqLyxjL2/bY/kWwJzv3ZDWCfIQ3l5+aY5EuO/gKHi9/iM0SMgvStuW6L
 ZdaizEfblS7hxut96rfdi881CqwPxttKopEtrfWiqXUOlqosO/0aM0yoFVfciSUhlrA4WcDbA
 TksKh0I7KICKCsOViDMKIVfwjcrxHOgEIG6ASdkk9iPMwU5Y01UHCj3+cuT12SK7l5/SdMoP6
 9rrvWAPDupw7PYWIkJRH9PVaooRP16je3N/Hr7edx7mgwOHEOQIbsmmqnbtkum1tNKprmzi7J
 WlBRc7Fv0yEc9mYfw1g+l0ZqGXClCROOsscVBpK4LnOja15bGR37QYR9Le7a2txLA4Z58JCFB
 9ylu0Ms8eKfhGUMCx29ett3Nv0BKwITuo5x38hLjf68c1hHE4rl2NvvOhb77WKwcP581YtfLO
 yjEzVrZMRfZpp+E1+at3O3ujlAYO4cWau3am4+pHlbxjO42HRMdqqg22qCjcefjryhyaYaw5C
 XVQFw9zGnQbvq16XCQe0Nn0icd4N8EoB2whX/sYU3h2M5BtTa42ECwwrOTiq8syoH//mNsk/w
 hkVVGuP4vpVEUI2opw71pKJXf0nEEbfBeREeMAgrmNoAQm11RsItW3XEe3i9giBB/Chn/rGII
 +IIDlOHcOH7paqOg7/1Se4snQl670T6EQll6pMJy0tZsxXkIVFvKXIqyj/

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
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgdjYgLT4gdjcKICAtIHJl
YmFzZWQgb24gYWN0dWFsIG5ldC1uZXh0L21haW4KICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjUg
LT4gdjYKICAtIG5vIGNoYW5nZXMKCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNwbGl0IHVwIHBhdGNo
c2V0IGludG8gcGFydCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFuKQoKQ2hhbmdlcyB2
MyAtPiB2NAogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAg
LSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9j
b3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYWU1ZTgxZTYyNzMzLi5iYjEz
YTQ1OTE3MDkgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3Br
dGdlbi5jCkBAIC05MTUsOCArOTE1LDEzIEBAIHN0YXRpYyBzc2l6ZV90IGdldF9sYWJlbHMoY29u
c3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwKIAogCQltYXggPSBtaW4oOCwgbWF4bGVuIC0gaSk7CiAJ
CWxlbiA9IGhleDMyX2FyZygmYnVmZmVyW2ldLCBtYXgsICZ0bXApOwotCQlpZiAobGVuIDw9IDAp
CisJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKKworCQkvLyByZXR1cm4gZW1wdHkgbGlz
dCBpbiBjYXNlIG9mIGludmFsaWQgaW5wdXQgYW5kL29yIHplcm8gdmFsdWUKKwkJaWYgKGxlbiA9
PSAwIHx8IHRtcCA9PSAwKQorCQkJcmV0dXJuIG1heGxlbjsKKwogCQlwa3RfZGV2LT5sYWJlbHNb
bl0gPSBodG9ubCh0bXApOwogCQlpZiAocGt0X2Rldi0+bGFiZWxzW25dICYgTVBMU19TVEFDS19C
T1RUT00pCiAJCQlwa3RfZGV2LT5mbGFncyB8PSBGX01QTFNfUk5EOwotLSAKMi40OC4xCgo=

