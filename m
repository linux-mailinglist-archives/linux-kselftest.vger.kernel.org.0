Return-Path: <linux-kselftest+bounces-25846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8300EA28B77
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D638C16965F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3D1DB92A;
	Wed,  5 Feb 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="qH65W6Rt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6FC198822;
	Wed,  5 Feb 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761138; cv=none; b=PR3UKDr85FVB6jqGRrKsyhjXqhm7rQ3FLFjRCVxrImH3ehZL4qdNJ+2LMtFYqpGqAiwg7L+U5MdmIxsvgV6A34sYEJCCn4tgLbur9lfY+e3khSuwoWmA1rqWayD1pRuEnA7VI5U4CWyld1Tpr2TS9eGA5RU42JqR0ppRWkVV7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761138; c=relaxed/simple;
	bh=MKL4T/vs4ciWtm1Nxs3Uo7fEfdIgvT5ROwme3MNF4kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcLmuQHDS60MJEIwWdfncc9xSp2AXWM9DLXmfRp633McCO/aSSEM0cOBDhFDuaCUPraxDkZO9//mKKWlmkI1xI6oakID9ER1tCnsYJdCAJxvWJjZCTU1P9+n64TKi3ezyORrrMxvJVp4L5QZH7ZgUIJ0IyzdWtMx6wMqCHqi6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=qH65W6Rt; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761125; x=1739365925; i=ps.report@gmx.net;
	bh=MKL4T/vs4ciWtm1Nxs3Uo7fEfdIgvT5ROwme3MNF4kE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qH65W6RtJfCt6p5xFn/2Ot1m096iAkQ2OM3t9FXYV62B96BH7beukAHObxM2ayjB
	 xKBt2ci9PA7SzNEyKNCEutq2wgC7//PESUPi9M40S1pkIjB4eBcA9OPEtgAvKkeqz
	 HbSOCWLTgT2rfHLi/0Ukr+/JaPLvaF5Rphazhj2++S4LmKFkreJ0kn7BLIzFhThSh
	 iUlr4rYvJCyfYr1I13w72OGjTLxBfdf8dalBtaZk4bMXEvEH4hDrEqfZPIlrZMKeZ
	 lxMYlaBKKksa0mxOKYRHC78eaurC7VZqY7nVcbxdgCJ9Qm0AP1v0tww9tkCaHTHZ+
	 7jRWjHE46WTQBnS2Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1u3orN1ycy-00LK5C; Wed, 05
 Feb 2025 14:12:05 +0100
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
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v4 16/17] net: pktgen: fix mpls reset parsing
Date: Wed,  5 Feb 2025 14:11:52 +0100
Message-ID: <20250205131153.476278-17-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:nVpVkHJ34UhSeujiytmBNDzUCIvcQIZynsFPHAS0nlPJizg/RDY
 DVxOaUStZSL/XGGjcBnXhASUFcay3MG1HsiZJAKkEtRVkvJwt/t+38YYKUxlexlWLIrgA2p
 HKSmBGvpRlnhOgpT0F/t74oM62Iqf5TEStcWZgxzARwsZqUFbGqIDVjUtkTJX987SWXcUNL
 ibdqucSIBGa1RECnXp5LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3CrqbqQOtDw=;3PXG7U2162NU/U29UWKEx4RSCq7
 PXv8/x5It45iCwcy29hsHrI7cJIiJwwOeD6bdyWD9aCUdviD11VWUx1zyOoWfY0aTueAei6FO
 qo3aQ7laCNp31atSwDF7ycij3rN1T209OEBgjaXY3vx0YL3Z7YLKy9plaznB7Y2mMk9z1IZzu
 YUJos1PsXic+oQR/uM+0ZphFANUOv0l4nUWsv32GmiL9xf7J7jPxa1j1neB2ReAnGcAfRCnrk
 vZXMERR/xDY5/8SgeEw7q8/qUxOW1ywPMHfL9TvpcDdcvnGT71pfH9exU0npxrIJJH3rNVq/m
 zFL2tLYBii8L3B809lNOk0h5bzrPFeuVr/TzVDyEsOPd7z+xKz163Pn3YejA3W01XSeDM4cf4
 5YQ8ufb086qlBprkmmlDuI+qQ2GI3XG405l942aT1V25y16D//slKfDFGrjmDtvtDSl4vJYIL
 g0G+pt+o3TWwU3iAWUNsaCdFNPBhqaUzGC5orR8RcfqAWdE6DxwqBUFMcrNJq8ZYLHU1WOxiZ
 sD6j1XNdxnrsL/PLYZohE5tlU0fYzrkNn1dApHMxwCq2Nl/D0B9OspNGW4Ct3bUAG8gsbq2Wy
 XvppyOwlEL5a9AMN/aVlKRwbxJ/d4aDtm9QtpB8dPONWK88ClpjVZA7ANg1wIeBvJsWNuAsGJ
 aWZ1wRqj+ETV1eel5yPzM7/571tIwev7URdWBBp1Cdlz5Yb8S3t/2r4YJXmVdiveMOGNO/L+t
 qE8PGjtEmdqXmyxMNnggWWYd7CXMcHWQ9JKSxARZpGeeTY8ZvN7//RAg9RqElJvd5HAcssWSZ
 lOqgR60Jm3ZrqtIL24YozsoU7T4K8NdeS/tFAjG2bQMj5xyi4DHI4wyUNUu5o9c9OoLmRhDHl
 TDwYFzEP1xitZlA4E08MrhE4fbfs8vltw+L9y5zT7bsp9DnqkQusOqitWNfUXTd0uk9G59Afk
 /Gsh4cPXHZgQNWEAXIKRnDIZ0ZybgEenxwhYcr1ysI20au2XJloim3vvjenXw67gytUFUmps8
 UBuhUJCopWF/v6+s+M1aLmVehl/naZaHNla9a4iIIJOPQdgX5Elw0s+F8NuYPSa6QJQ1eyg8w
 pyJfbLd8hnFdsJ1r7ENm4b5eC0gmY9H2A6wlMYcRkBhw4YkdXtv8qu7PFt8doGoJukaYH6uD4
 Krdpt3gAg5n5c/GzUHMKGcyZXjJFExBsRxFsdtg1c6swFR981YR4qVFXEqTooXhM/z4MRu8Fm
 YQaafiHQqbLkl+5KwLZ+S5h3VKfq3yHp/r8KObRePss12dV1IpTg7nJFEnK/ngKFp3jDxe1ym
 xZof4q5Z14r3S7EZ6XTYanjcseBhmNE8kQrzW28N+2zpkY=

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
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgdjMgLT4gdjQKICAgICAg
ICAgIC0gYWRkIHJldi1ieSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBuZXcg
cGF0Y2gKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9jb3JlL3Br
dGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggYTQ2ZWIyMGVkZjZjLi40MzQ1MzFhM2Uz
YzAgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3JlL3BrdGdlbi5j
CkBAIC05MzAsOCArOTMwLDEzIEBAIHN0YXRpYyBpbnQgZ2V0X2xhYmVscyhjb25zdCBjaGFyIF9f
dXNlciAqYnVmZmVyLCBpbnQgbWF4bGVuLCBzdHJ1Y3QgcGt0Z2VuX2RldiAqCiAKIAkJbWF4ID0g
bWluKEhFWF84X0RJR0lUUywgbWF4bGVuIC0gaSk7CiAJCWxlbiA9IGhleDMyX2FyZygmYnVmZmVy
W2ldLCBtYXgsICZ0bXApOwotCQlpZiAobGVuIDw9IDApCisJCWlmIChsZW4gPCAwKQogCQkJcmV0
dXJuIGxlbjsKKworCQkvLyByZXR1cm4gZW1wdHkgbGlzdCBpbiBjYXNlIG9mIGludmFsaWQgaW5w
dXQgYW5kL29yIHplcm8gdmFsdWUKKwkJaWYgKGxlbiA9PSAwIHx8IHRtcCA9PSAwKQorCQkJcmV0
dXJuIG1heGxlbjsKKwogCQlwa3RfZGV2LT5sYWJlbHNbbl0gPSBodG9ubCh0bXApOwogCQlpZiAo
cGt0X2Rldi0+bGFiZWxzW25dICYgTVBMU19TVEFDS19CT1RUT00pCiAJCQlwa3RfZGV2LT5mbGFn
cyB8PSBGX01QTFNfUk5EOwotLSAKMi40OC4xCgo=

