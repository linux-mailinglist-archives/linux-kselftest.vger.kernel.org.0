Return-Path: <linux-kselftest+bounces-26528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A2A33DB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A914B3A92D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3F022D761;
	Thu, 13 Feb 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="DxgT9iVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5040221568;
	Thu, 13 Feb 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445574; cv=none; b=iWo6FlURZ7yeWvQJy88NEaci1qG8U3i3yQUlC1UpETrPdg2d39dbtm4Y+oGAu/gB1ROjOw6Fsk0sm8DdOjLcZgUkpXInIndQILepFXuWgnTKiQV4RA8wptneA7KqQxEccjSc+8cBWXmOUaAW5vpqDYOcJ1mGBctZfiIFnUH4Y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445574; c=relaxed/simple;
	bh=YLx+FFBcppnoQ5foXkrGLrrLX4IzH/DepVjtxekALF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIHaQDmH79bd92fVBnAz0d+t7q0hNyiD99123IYJEIPDu+EiaiOQHtq9q4zsqjiPWeYp8ALffgm48HNeFVRjLwfTjWaXhDZyHVKfqp9iCjcpUUyrMavOlaDsBil5ePVV3c4t0GE7GIfHJUngYfGLKmuPsXolqcEEYg52S0PVW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=DxgT9iVb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445567; x=1740050367; i=ps.report@gmx.net;
	bh=YLx+FFBcppnoQ5foXkrGLrrLX4IzH/DepVjtxekALF4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DxgT9iVbmc/NJVtRvskXSckHbDS78aHBkO9lYFHUc/lMTvlFbjvch+dkfk91oTJV
	 kjdDf1wFtKxLyDJzN5A6Hn4WJRhNDQ6seuofVr0KsIyrpiKwWedRwZh0/BFqA9LH4
	 kQ0cKCOgdbdr5K4T5yU4JYd6wm0kB4pXo2Xa5TRtPY/WR1Qp6mu07o/TIY1xXsHKM
	 /wYkkf7zr26riIx2q/ZOCa0Kwy07cTyyT0h/Qucg/Me658O9bRPWnXBEgXU6ilTi/
	 vMepahejldEasDKFEblovvKWlZLTfBaBoT6s/ePsuPQTJs24QlBdUyEsYQtnNbyl2
	 /kLA6E9AJacOQ7bywQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1tRHcD1670-00xIvZ; Thu, 13
 Feb 2025 12:19:27 +0100
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
Subject: [PATCH net-next v5 6/8] net: pktgen: fix mpls reset parsing
Date: Thu, 13 Feb 2025 12:19:18 +0100
Message-ID: <20250213111920.1439021-7-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:QYEnJf1FkFJvRU7GgyHEvjD4zzUM8mOi2DuD7IDEApu20zi/f7h
 4t0QYMhW7dYIPKdcn950pb/Tq5sgcdAT2Wb0a1mouLSXt885JByFQOW4bvbxPRtpma1tLef
 S+WnOqpqz/RgIerYEyIW6V+OxdOJgU5s0SwOs+dZLhN5A2XBelSzcoi4hmsM1xi+D5cvUSZ
 TS4Kln6VyNCjYhBr6kDeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fxjYW0XhBcs=;XFY+YssHXIoEYxw11exGsUzGG0l
 yHdmOnAPrfJhLzqHE0y398djJLfkNKy8ukXROaA2M4rWQwBL18alMclHSlO3dLqZM8GWW997u
 wD0wbePKDAl8WoF10GbK2j34SKbu9kIl7t5BDz/IfLwZImTzZAQeFRLGqukZpsI0JU4NpE1sV
 pzuyFsLiQi83oHqBk3ezNJDJW34veyOSWB1FLFpCSgLYwMWVuS1woOsXaICTkql5DF5KMeVEB
 P8WaOMwOY2+oykaT9g9VODziPOnJ2NvoZo1g/9gzGr8dFBaScV7SwZ5Ur7scFnamRpsXC2LnN
 JxeS5bqSfXfGv55tozCpKipdNzkwEVUeGL6Qhr9x8bpu8hFyzSbTDs3AzV2AfHyhJIlZbZnwl
 jaLuLlz1wYNTSuU99bJ5i3PLDOaDAbN0bz+He0vQPra0lMIVLwijBptpgjXIXRbM+JWDrZ8c3
 hp0STc+IXOFgbVaxIcNGgWEICOL+oxF6ofQl9j66lrEH/TD9/y846w0AKKGkJDBD3ipnG+pJQ
 HFvjk+bqk31SzAVH1iJ10PvC1Dgd5JYc4H6aDVUebXyZCjtHD8moLngwD8dRCNgt48i0U5f6F
 Uh1Gvj6BXqM6Cwb98ekB678eLxXjU/R0gY0lPip+yG24wqwM/ufwGLYwEiEeuVum8yI7EhGae
 G7Yn8az2Xhgd5pPGytWGDJ8vXfX/ug/Q3KMEGc7yFUnrNLOhURykT5vTx+i5S167AVVpjmsi+
 voaePsXDy/fMYUx7vBc57nfdPhXxA8CDwOpKlLR+aJ9IY96VTooEpAU7GjFZ5HulocEjNM1Aj
 VVzKKamaYrxMWCPoLc+2g3uK9YhmDfAICzR75DEO8pD1PC00LA4E26gtmfA/WfsSqZh8zgXbY
 IeD5D1XRj5h/7os1mkRceloIFuauR0FlchYsQGGuagPTR6KWr8F2iMDgiBEi4JrJhsYGDc2lN
 hbli2EFy1JZdoVh5IzX3BIAW4fkhjypWB5ExiQM5AYzVsFO+rcqodSOxPgKPN3m/4PjpMV7iF
 riQcpOrWFPcqtn09McrjPHacUOyAv+G4vdKYreJOHChbfcru8jdg1a8DYAxkRoMsqAgKcKbGi
 n2M2F0ULOXKjagWtllyVlj7pRxAmZtPkNim6Mn8ChbFdHTldPwROFYHRWCH4YZzS5eRGX5i3G
 Zj3viijw5wJBacvEP/Xuk7HrZtD/hSxiUG4uOwfKLCQIrlY9qDHoz/yMCj74dziQXNjuUx3oi
 I7TfTRg29opd7hOKoGKrhJcqfdLRUmaj7Jx2XN0STwa0cyEH+OHo+ftwV11rn7HIfgvDKGOAf
 Gx486GM8k/Ad5qd+4bzFwq5jxOloQLfOb0M8fPF+ZqUzkZ3TEJroDt9taQ6jeiXytPaJCJmlG
 qj7En+NGLTrQ6CtU0gHqLlEjsGcAjF/hjc7gfq1Ap9R8a7ZsCeZu7b5RSC

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
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgdjQgLT4gdjUKICAtIHNw
bGl0IHVwIHBhdGNoc2V0IGludG8gcGFydCBpL2lpIChzdWdnZXN0ZWQgYnkgU2ltb24gSG9ybWFu
KQoKQ2hhbmdlcyB2MyAtPiB2NAogIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMg
djIgLT4gdjM6CiAgLSBuZXcgcGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKysr
LQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL25ldC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNzgwNDM1
YThlNjA1Li4xYTBjZmZmMmYzZDcgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBi
L25ldC9jb3JlL3BrdGdlbi5jCkBAIC05MjUsOCArOTI1LDEzIEBAIHN0YXRpYyBzc2l6ZV90IGdl
dF9sYWJlbHMoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZmZlciwKIAogCQltYXggPSBtaW4oSEVYXzhf
RElHSVRTLCBtYXhsZW4gLSBpKTsKIAkJbGVuID0gaGV4MzJfYXJnKCZidWZmZXJbaV0sIG1heCwg
JnRtcCk7Ci0JCWlmIChsZW4gPD0gMCkKKwkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwor
CisJCS8vIHJldHVybiBlbXB0eSBsaXN0IGluIGNhc2Ugb2YgaW52YWxpZCBpbnB1dCBhbmQvb3Ig
emVybyB2YWx1ZQorCQlpZiAobGVuID09IDAgfHwgdG1wID09IDApCisJCQlyZXR1cm4gbWF4bGVu
OworCiAJCXBrdF9kZXYtPmxhYmVsc1tuXSA9IGh0b25sKHRtcCk7CiAJCWlmIChwa3RfZGV2LT5s
YWJlbHNbbl0gJiBNUExTX1NUQUNLX0JPVFRPTSkKIAkJCXBrdF9kZXYtPmZsYWdzIHw9IEZfTVBM
U19STkQ7Ci0tIAoyLjQ4LjEKCg==

