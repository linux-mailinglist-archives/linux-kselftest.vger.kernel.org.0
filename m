Return-Path: <linux-kselftest+bounces-25584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C1A260D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FD2167F0C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B20E718;
	Mon,  3 Feb 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="mH8PohwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3820E702;
	Mon,  3 Feb 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602164; cv=none; b=UcwvMEyo6coM4KYqvhLxqdxV0fm1E2EowCNMkLJ7ECo1yoN2xfsN8l7sVXeVbvOpz/BMKniEi93G8PyTH9DvHQ4vVc4vCU1iajAk9mr8vglSF8O13DeNLvIcX6No4nxP2ck9dnYjv/cs1KogWJ9LzIZiqvSeW2o2KdTYJ6CWdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602164; c=relaxed/simple;
	bh=VKeJPykxZdE/Mr4hHDair/L6boyyhsX+C2ZqoZQ8AAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY3XhMfwdZTY5M0X6mcQkKtpMNBoFrmwnqL0F6GoAXS1bB1DTmMvQ/uEKPSgLjliTjSbn4OGZc6smEt3zk9dQ5ptuYKOT0jnj+YmCxnexW8AGdtUx8u3T6lPj3pdasad2qTpa0SucU+dl7dwsv4OJlvhuvXHtQBRcwYPsh2uotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=mH8PohwQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602151; x=1739206951; i=ps.report@gmx.net;
	bh=VKeJPykxZdE/Mr4hHDair/L6boyyhsX+C2ZqoZQ8AAA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mH8PohwQjWtTFL9DXDkG6aZEwgcVV0HgV0ovZpn7+Y7a0Mw9RvEn/Y11tJDNvD+n
	 Yxse7aFrxOxgLDKPbz1k4ZqQSCIvzaJ5POoU++MxtlPBDO/xWt4E2YUJ/3KVrd5GO
	 FnXfGTUqh3EI4x6+yKNT0JU5wBRI7R8Np/hEOwaQK5bdaNLtFK6WLjqWIyiH2Gpwf
	 KYnpmMLjF8d3Oaz3tprqY25RKrsTr9SyMpHECNIrsBZi9qw6tqUaqrpSJGow830pI
	 smfVsOjBMLawLfzDo8LmYt7ltEXI6awXIsdOYks/sY5B38fVOK/yKvC81NmXhwBTM
	 JNp2blXvRueSTPk1kA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1tVhYu15WJ-013GUJ; Mon, 03
 Feb 2025 18:02:31 +0100
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
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v3 09/10] net: pktgen: fix mpls reset parsing
Date: Mon,  3 Feb 2025 18:02:00 +0100
Message-ID: <20250203170201.1661703-10-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203170201.1661703-1-ps.report@gmx.net>
References: <20250203170201.1661703-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Kw7ZC8sWxfBb7UyA9bra3jH02e2hgYK2QIN/3ob1J4tRSoPKuf7
 poFYMbvSgIbh8Bcge1qA9yr+g78OWJ0tgDRBkEH+IFVScHQmXzL0+t/qJgBrIwVsxY1VH/J
 +D336VJofatifWAjXDJqSGcdic5tsH4LQqeQpNcrYvPgqICD9zCtTxks6zG6fSmtfifeSvH
 rpoDSURVSb+aI0bvZi1ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sLPmEis8ypU=;usPIvFg+ebfXKF8GTL4S/p6iEtx
 X9sD7H6043680naB1blsFhbWVY7VbwJlYOGYUUBjeERgtmWy4XIrxDsY2+AQOnG2GHZFiYUvd
 DugAyKKlfHi0mhN33qo52hakZacuyTO7vN9mI62sSwVboCkiMYhvhW98Lcfo0ZVOIEQaIUCuh
 YE/1gu73Gk5xw7lKPNo4Qd1phoxdKpxRg+vBv0e/LdlieJITJ3aJiZgNN0IH6JsYKds5k+1Ut
 AxbyVLOqZdGb2SY8f4HMsONQ+ooePitB36WqYfDf0NfHKvWHLgr8pDt4t8sNKnc0/wp405bA2
 NdqVVW5VBC4Jdz34NHziqv69x8QSm69rguLftbhw81dl1wOiXTtGXmWm84N6DjIr/q4C1s20E
 rKu0BlTHSy3dAt7wp86SuQsZpnoWBOPKxM5WMEzmfsBqeGRRJAKzH4qBIN5xBcg27LuVBm6SC
 dQj7madiiiNfJ+spZ+iSII1kYYqqJCJrvirmj0QKZ72R0yeOYTMHQWdUmPZsN94jPasZtzWPw
 oiQjfdrDkSTFBBqy01uSOFkLJmEmPBej75WNQvIMB04r9JO4K3OSA9B0B4jHifn65PsWVn5XD
 jTSOssVx6IfRL+3cSD287HSiBoOpezbLOthHx/57YqzCfXBDktuy8on6kcZvJBaiDQZGmlpSF
 nKYsZizLsQQRz3NdNv6BkqHTe9K+GPqoZJzBVzgWr024LSEqwpQ4D6ak7QzVsJQ11m3WQ6eU5
 WdPkmpUu7VgcWtsuJ5IKsz6SYYcdGTSFN+8ToSE/DUdbwzMtkfebiyCtbNO9DYnuJQkuIWXde
 lFn27/OE1+Tg3l0IgcQm20mvpp90pVhUtguKi2zx5hrljdU0tdgRHsY2V/Vo4O0qi/oPZorG4
 IERLSjFfL8isLQ/llNigI8fZRF6enCHcqxI5J/a6lwXUVxEeuQP0nChT+gQhH9soJJs0oZZCM
 VmuOVDgT7+Bd4o1l7oghY3ppbTQXRRqy1Cr8HMncAc6EznNNMKkHwpxvb3p/OcNL3dBnF8y5A
 XtT4sH0xZrZMSwPRDsSAe8znPxaVn7HJ8wVZ/nCs7glsECe49JahgjmvxXUZyun1Swv4Sdlt4
 hEbvrpwZJM4MGix3cdiBZmcVPthqhXvv/PDbpLaThbgxqs3gqJkQpL+dh/aGjpCk1mG3lQX5t
 hh6KzYMfGBnmJlj2gRTrAGym6sIHvmBISW0vUgFXg04aXjPZtWs6G4PedsHn6e8OSLddPbiNb
 96N7nWO23ZblGViUOXVDg6fwficjyWvUcQ6e3wtGlzCvVhZ7jviFwGCD1JosnNEjb752I11c6
 Jh8BRAY+Xgy6Wl/TCJmIneX7rlk4HQ3OUb2WDXPivCPQzQ=

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
ZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCkNoYW5nZXMgdjIg
LT4gdjM6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNjY3NTM3NWMw
NTJjLi43MzI4NjgxYmFmYjIgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25l
dC9jb3JlL3BrdGdlbi5jCkBAIC05MjQsOCArOTI0LDEzIEBAIHN0YXRpYyBzc2l6ZV90IGdldF9s
YWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwgaW50IG1heGxlbiwgc3RydWN0IHBrdGdl
bl9kCiAKIAkJbWF4ID0gbWluKDgsIG1heGxlbiAtIGkpOwogCQlsZW4gPSBoZXgzMl9hcmcoJmJ1
ZmZlcltpXSwgbWF4LCAmdG1wKTsKLQkJaWYgKGxlbiA8PSAwKQorCQlpZiAobGVuIDwgMCkKIAkJ
CXJldHVybiBsZW47CisKKwkJLy8gcmV0dXJuIGVtcHR5IGxpc3QgaW4gY2FzZSBvZiBpbnZhbGlk
IGlucHV0IGFuZC9vciB6ZXJvIHZhbHVlCisJCWlmIChsZW4gPT0gMCB8fCB0bXAgPT0gMCkKKwkJ
CXJldHVybiBtYXhsZW47CisKIAkJcGt0X2Rldi0+bGFiZWxzW25dID0gaHRvbmwodG1wKTsKIAkJ
aWYgKHBrdF9kZXYtPmxhYmVsc1tuXSAmIE1QTFNfU1RBQ0tfQk9UVE9NKQogCQkJcGt0X2Rldi0+
ZmxhZ3MgfD0gRl9NUExTX1JORDsKLS0gCjIuNDguMQoK

