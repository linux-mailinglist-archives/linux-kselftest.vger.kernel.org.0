Return-Path: <linux-kselftest+bounces-26532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BFA33DCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C413E3A3BB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8701C863A;
	Thu, 13 Feb 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="TBZRDG/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC929242932;
	Thu, 13 Feb 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445593; cv=none; b=VQ4sc20qL4DxoeQE8cO6NZZQeLU4pJz0ZgZt8uXSAM1TajhDfC7cMYmztYl0rW3ylqJJppHX/DMkA1tMgzii5owezu76/2n0/xA1+QEhwXC1hHChkt/CBMe7v60IbtCZUZE6xpAaEISY6eIKhLg69As5S3bXRA7pWYdvni3f6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445593; c=relaxed/simple;
	bh=9uuNd+3GB1+s/Ck5oO4hLGm+v5ubjOuu0ksS9ejQBNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi+uDzt1S6C9JmiiI29vWO5tnFnwQSXrdhi9GHKYJL+7Fh81FNmnKC/RKKRvBEfeRo/q+vMugeMrFGrClYWQlsxT/aFlTvTTHodJTQR8lvzj29lYJ1bcL2LQpOJI0/LuBLo6T9Q4x8A/ANiIbaRfN/krbfAUdWOQE6vVdz+3ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=TBZRDG/F; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739445567; x=1740050367; i=ps.report@gmx.net;
	bh=9uuNd+3GB1+s/Ck5oO4hLGm+v5ubjOuu0ksS9ejQBNs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TBZRDG/FU0Dd4edOMyPZ+IfPz2xRYwX40eJqSzlOBXPLNCpof4UyIQ7/T//7VrGt
	 SEK+moDh96OhXlQqkvAZ4G7TTFDZQFVTQF1p7cgtdpGM+tt970HS0znfzn/Q3pACV
	 kOmDga7MT3x7Dhqs7IODF5uJ8H2n0SO0h2bT2RqSpgvN5wbbvp24k+n/ZCgZkjwf2
	 XIFTOjSnPtYeao5w020W/NUuIHIaXzieyjO4iR1Si0HU+LEovLV5fUAgydDvZSNGn
	 Lhh7GikTJ2amgk0u1eT71q/Jvb3KQjG4xsRJkoi8yI5AKX9TnUhEdVkWpgt8SL++O
	 tp84Dydk7x3OTtkXig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.197]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1tfEvb2j9w-006yzf; Thu, 13
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
Subject: [PATCH net-next v5 7/8] net: pktgen: remove all superfluous index assignements
Date: Thu, 13 Feb 2025 12:19:19 +0100
Message-ID: <20250213111920.1439021-8-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:vgUEgNqAatG/XR1nP5KVaQnazr37N5sLpoB+44LlcguynB0/xZk
 xTDi+3eNeKMPZgUTQAqxiwXkXV6C48nb+OpG5mVXJzdP7jY0efdE8AftqGtQ1ao8yIDO1++
 iWxdGXGzVRjcbksf5O9B/SfpUEt/nVAmtS04bI6GZZNNd+xTiN0M9QHxUkDTM5uNm4K9MZe
 WWOq5k6GhVHc2i8UpGkIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FcH4IGXayf8=;FoGcasg0FZKe6gwAuzvYfL2dbSe
 nIdX+32GMTUMsxyt7w+frcz9J/VqsLZ44Z+ItkTTouB1Taz0+PIXDUO88Bye5XazkmLQIUJks
 QMiasMhoRZEiQeS+61M+q+lEsTCRPlA7nnU5065mqr8IRd43p/bSVSluXAmFArQaV0TL2W//a
 HncM97jSrsz1606BWRni2+oW0eqwZcOn8/MA+lagjVP1a2VuyKCxSRKd3cFoQCRx9jjULShAf
 b9bWYjNQqxmOX7mQwgjatstvxvlWCKedkvvZY/GtApnY16EYOEQgtEuwhQGn6MsRsqV5Gc3Xr
 tyUQyuSxK9bUJCqfkjPe39PB/obgdk4mpN6kK1072qDXF6Xg/IyDAt3YRimAK2QUUxUltVKr9
 Ao/1LTNO7tGlW2SZWWBI0qluGJn2wtpr1Mjs4C4t9E/a3Dn0sGEpfbbJ33B7gmtoGVrRDcTZX
 gQBZWXr6BY/JlokRoOzogFBjJMl3PbhdbrhnlU7A6oO4MonGu2Kzp7lS+Utt8M+fWBkKE0T5G
 HsD0yuh01uFgblkk1SWJXXlYzG9ZZDzLYm7sq+EsB2sPuWnpu9kaHfQHLxRXFTdVC2XqvgcVW
 MC8o4s8Wu7a3PEh07gWf9MZG9t3C6iyTDE3FPapg36nQFngQwt+o5Bl9im29EYsZoyJx4uZzT
 M+WNiQyPmpNhMpxvqdhdMHM8mrNfI9zfnXeMjVEVV0GSTC8tSGOtDQ5hYdEt5NEjy9Nif6BVc
 BHiHRSdCvd0ldgPBqff8qIL4wkpPOq50GXlWaDCoVhBpxGkcS8tstHTjIPob+1GKHQA4b+QLC
 YCVCagQtU5cRDtb0IspqrxlcOT296UeaHiKHjV2ld4AVLDQAUQDRJyiIGUsZF2GGvWtNZ4rDH
 93/swLHPXCbElP8Oaq2W8oM0uhf9LASDGNgapxbrmh3CMfuG+d3N+Qb5WxbGJJ60ERP1UP2dE
 E4tqa9w5lWZ/lZHMQKBDJpVVOyD65xWF8lDiEAeT0PhvZiMRvuyfECyaeUFZAKYV/9HXR/8tg
 IvDTk9p91MbQX3raeTDyDr6cwHxNF4//vgw1S8do72vMGDsybqpQa/xuzeSIzwGEh2sHlUInp
 LX6wSubYZtEucTSI2LAPrBWoRqdXWRD2RAJOV8Ivlw94DSO4kumBfNVsZMpFW80uvHHqWRjss
 lIsDDjR0Fpu4xTd3RhY98AYAbZ0uP5ZAOrOG4UHWXcrwnuuI7YdzmzoCOrstkn/wg6iJ2a7w2
 HY+EHbyI8GCnwRenEpCbODJps4OQ0zUpjE2clmZmaL+y1sHQSr9b6R4ZRBX8yyvAvXAE/vunm
 dM8xschpplX8feFXNMiWvu6ljmVvJp02H8Dlu+pTORpp+74BanCTJILf5YvYl13kYx/A9oHJ/
 5hwrO3OAmvm+Cbag2B+NDsxSp4rqgCQAI1RXG3ECMjI9hnP6IBAK/9/Por

UmVtb3ZlIGFsbCBzdXBlcmZsdW91cyBpbmRleCAoJ2kgKz0gbGVuJykgYXNzaWduZW1lbnRzICh2
YWx1ZSBub3QgdXNlZAphZnRlcndhcmRzKS4KClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVy
IDxwcy5yZXBvcnRAZ214Lm5ldD4KLS0tCkNoYW5nZXMgdjQgLT4gdjUKICAtIG5ldyBwYXRjaCAo
c3VnZ2VzdGVkIGJ5IFNpbW9uIEhvcm1hbikKLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDUyICsr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQv
Y29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IDFhMGNmZmYyZjNkNy4uYmMw
MTAyMGZhMDNjIDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9w
a3RnZW4uYwpAQCAtMTA0MCw3ICsxMDQwLDYgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dy
aXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAK
LQkJaSArPSBsZW47CiAJCWlmICh2YWx1ZSA8IDE0ICsgMjAgKyA4KQogCQkJdmFsdWUgPSAxNCAr
IDIwICsgODsKIAkJaWYgKHZhbHVlICE9IHBrdF9kZXYtPm1pbl9wa3Rfc2l6ZSkgewpAQCAtMTA1
OCw3ICsxMDU3LDYgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxl
ICpmaWxlLAogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJ
CWlmICh2YWx1ZSA8IDE0ICsgMjAgKyA4KQogCQkJdmFsdWUgPSAxNCArIDIwICsgODsKIAkJaWYg
KHZhbHVlICE9IHBrdF9kZXYtPm1heF9wa3Rfc2l6ZSkgewpAQCAtMTA3OCw3ICsxMDc2LDYgQEAg
c3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAo
bGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlmICh2YWx1ZSA8IDE0
ICsgMjAgKyA4KQogCQkJdmFsdWUgPSAxNCArIDIwICsgODsKIAkJaWYgKHZhbHVlICE9IHBrdF9k
ZXYtPm1pbl9wa3Rfc2l6ZSkgewpAQCAtMTEwMSw3ICsxMDk4LDYgQEAgc3RhdGljIHNzaXplX3Qg
cGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCiAJCWZpbGxfaW1peF9kaXN0cmli
dXRpb24ocGt0X2Rldik7CiAKLQkJaSArPSBsZW47CiAJCXJldHVybiBjb3VudDsKIAl9CiAKQEAg
LTExMTEsNyArMTEwNyw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVu
OwogCQlkZWJ1ZyA9IHZhbHVlOwogCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiBkZWJ1Zz0ldSIs
IGRlYnVnKTsKIAkJcmV0dXJuIGNvdW50OwpAQCAtMTEyMyw3ICsxMTE4LDYgQEAgc3RhdGljIHNz
aXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAobGVuIDwgMCkK
IAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCXBrdF9kZXYtPm5mcmFncyA9IHZhbHVl
OwogCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiBmcmFncz0lZCIsIHBrdF9kZXYtPm5mcmFncyk7
CiAJCXJldHVybiBjb3VudDsKQEAgLTExMzQsNyArMTEyOCw2IEBAIHN0YXRpYyBzc2l6ZV90IHBr
dGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1
cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlpZiAodmFsdWUgPT0gMHg3RkZGRkZGRikKIAkJCXBr
dF9kZXYtPmRlbGF5ID0gVUxMT05HX01BWDsKIAkJZWxzZQpAQCAtMTE1MCw3ICsxMTQzLDYgQEAg
c3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAo
bGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlmICghdmFsdWUpCiAJ
CQlyZXR1cm4gLUVJTlZBTDsKIAkJcGt0X2Rldi0+ZGVsYXkgPSBwa3RfZGV2LT5taW5fcGt0X3Np
emUqOCpOU0VDX1BFUl9VU0VDL3ZhbHVlOwpAQCAtMTE2Niw3ICsxMTU4LDYgQEAgc3RhdGljIHNz
aXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAobGVuIDwgMCkK
IAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlmICghdmFsdWUpCiAJCQlyZXR1cm4g
LUVJTlZBTDsKIAkJcGt0X2Rldi0+ZGVsYXkgPSBOU0VDX1BFUl9TRUMvdmFsdWU7CkBAIC0xMTgy
LDcgKzExNzMsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsCiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKIAotCQlpICs9IGxlbjsKIAkJ
aWYgKHZhbHVlICE9IHBrdF9kZXYtPnVkcF9zcmNfbWluKSB7CiAJCQlwa3RfZGV2LT51ZHBfc3Jj
X21pbiA9IHZhbHVlOwogCQkJcGt0X2Rldi0+Y3VyX3VkcF9zcmMgPSB2YWx1ZTsKQEAgLTExOTYs
NyArMTE4Niw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAq
ZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlp
ZiAodmFsdWUgIT0gcGt0X2Rldi0+dWRwX2RzdF9taW4pIHsKIAkJCXBrdF9kZXYtPnVkcF9kc3Rf
bWluID0gdmFsdWU7CiAJCQlwa3RfZGV2LT5jdXJfdWRwX2RzdCA9IHZhbHVlOwpAQCAtMTIxMCw3
ICsxMTk5LDYgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpm
aWxlLAogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlm
ICh2YWx1ZSAhPSBwa3RfZGV2LT51ZHBfc3JjX21heCkgewogCQkJcGt0X2Rldi0+dWRwX3NyY19t
YXggPSB2YWx1ZTsKIAkJCXBrdF9kZXYtPmN1cl91ZHBfc3JjID0gdmFsdWU7CkBAIC0xMjI0LDcg
KzEyMTIsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZp
bGUsCiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKIAotCQlpICs9IGxlbjsKIAkJaWYg
KHZhbHVlICE9IHBrdF9kZXYtPnVkcF9kc3RfbWF4KSB7CiAJCQlwa3RfZGV2LT51ZHBfZHN0X21h
eCA9IHZhbHVlOwogCQkJcGt0X2Rldi0+Y3VyX3VkcF9kc3QgPSB2YWx1ZTsKQEAgLTEyNDgsNyAr
MTIzNSw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwKIAkJCQkgICEocGt0X2Rldi0+ZmxhZ3MgJiBGX1NIQVJFRCkpKQogCQkJcmV0dXJuIC1FSU5W
QUw7CiAKLQkJaSArPSBsZW47CiAJCXBrdF9kZXYtPmNsb25lX3NrYiA9IHZhbHVlOwogCiAJCXNw
cmludGYocGdfcmVzdWx0LCAiT0s6IGNsb25lX3NrYj0lZCIsIHBrdF9kZXYtPmNsb25lX3NrYik7
CkBAIC0xMjYwLDcgKzEyNDYsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3Ry
dWN0IGZpbGUgKmZpbGUsCiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsKIAotCQlpICs9
IGxlbjsKIAkJcGt0X2Rldi0+Y291bnQgPSB2YWx1ZTsKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJP
SzogY291bnQ9JWxsdSIsCiAJCQkodW5zaWduZWQgbG9uZyBsb25nKXBrdF9kZXYtPmNvdW50KTsK
QEAgLTEyNzIsNyArMTI1Nyw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0g
bGVuOwogCQlpZiAocGt0X2Rldi0+c3JjX21hY19jb3VudCAhPSB2YWx1ZSkgewogCQkJcGt0X2Rl
di0+c3JjX21hY19jb3VudCA9IHZhbHVlOwogCQkJcGt0X2Rldi0+Y3VyX3NyY19tYWNfb2Zmc2V0
ID0gMDsKQEAgLTEyODcsNyArMTI3MSw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0J
CWkgKz0gbGVuOwogCQlpZiAocGt0X2Rldi0+ZHN0X21hY19jb3VudCAhPSB2YWx1ZSkgewogCQkJ
cGt0X2Rldi0+ZHN0X21hY19jb3VudCA9IHZhbHVlOwogCQkJcGt0X2Rldi0+Y3VyX2RzdF9tYWNf
b2Zmc2V0ID0gMDsKQEAgLTEzMDIsNyArMTI4NSw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9p
Zl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVu
OwogCi0JCWkgKz0gbGVuOwogCQlpZiAoKHZhbHVlID4gMSkgJiYKIAkJICAgICgocGt0X2Rldi0+
eG1pdF9tb2RlID09IE1fUVVFVUVfWE1JVCkgfHwKIAkJICAgICAoKHBrdF9kZXYtPnhtaXRfbW9k
ZSA9PSBNX1NUQVJUX1hNSVQpICYmCkBAIC0xMzIyLDggKzEzMDQsNiBAQCBzdGF0aWMgc3NpemVf
dCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCWlmIChsZW4gPCAwKQogCQkJ
cmV0dXJuIGxlbjsKIAotCQlpICs9IGxlbjsKLQogCQlpZiAobm9kZV9wb3NzaWJsZSh2YWx1ZSkp
IHsKIAkJCXBrdF9kZXYtPm5vZGUgPSB2YWx1ZTsKIAkJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6
IG5vZGU9JWQiLCBwa3RfZGV2LT5ub2RlKTsKQEAgLTEzNDcsNyArMTMyNyw2IEBAIHN0YXRpYyBz
c2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJbWVtc2V0KGYsIDAs
IHNpemVvZihmKSk7CiAJCWlmIChjb3B5X2Zyb21fdXNlcihmLCAmdXNlcl9idWZmZXJbaV0sIGxl
bikpCiAJCQlyZXR1cm4gLUVGQVVMVDsKLQkJaSArPSBsZW47CiAKIAkJaWYgKHN0cmNtcChmLCAi
c3RhcnRfeG1pdCIpID09IDApIHsKIAkJCXBrdF9kZXYtPnhtaXRfbW9kZSA9IE1fU1RBUlRfWE1J
VDsKQEAgLTEzODgsNyArMTM2Nyw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShz
dHJ1Y3QgZmlsZSAqZmlsZSwKIAkJbWVtc2V0KGYsIDAsIDMyKTsKIAkJaWYgKGNvcHlfZnJvbV91
c2VyKGYsICZ1c2VyX2J1ZmZlcltpXSwgbGVuKSkKIAkJCXJldHVybiAtRUZBVUxUOwotCQlpICs9
IGxlbjsKIAogCQlmbGFnID0gcGt0Z2VuX3JlYWRfZmxhZyhmLCAmZGlzYWJsZSk7CiAJCWlmIChm
bGFnKSB7CkBAIC0xNDQ2LDcgKzE0MjQsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCX0KIAkJaWYgKGRlYnVnKQogCQkJcHJfZGVidWcoImRz
dF9taW4gc2V0IHRvOiAlc1xuIiwgcGt0X2Rldi0+ZHN0X21pbik7Ci0JCWkgKz0gbGVuOworCiAJ
CXNwcmludGYocGdfcmVzdWx0LCAiT0s6IGRzdF9taW49JXMiLCBwa3RfZGV2LT5kc3RfbWluKTsK
IAkJcmV0dXJuIGNvdW50OwogCX0KQEAgLTE0NjcsNyArMTQ0NSw3IEBAIHN0YXRpYyBzc2l6ZV90
IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfQogCQlpZiAoZGVidWcpCiAJ
CQlwcl9kZWJ1ZygiZHN0X21heCBzZXQgdG86ICVzXG4iLCBwa3RfZGV2LT5kc3RfbWF4KTsKLQkJ
aSArPSBsZW47CisKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogZHN0X21heD0lcyIsIHBrdF9k
ZXYtPmRzdF9tYXgpOwogCQlyZXR1cm4gY291bnQ7CiAJfQpAQCAtMTQ5MSw3ICsxNDY5LDYgQEAg
c3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAo
ZGVidWcpCiAJCQlwcl9kZWJ1ZygiZHN0NiBzZXQgdG86ICVzXG4iLCBidWYpOwogCi0JCWkgKz0g
bGVuOwogCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiBkc3Q2PSVzIiwgYnVmKTsKIAkJcmV0dXJu
IGNvdW50OwogCX0KQEAgLTE1MTQsNyArMTQ5MSw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9p
Zl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGRlYnVnKQogCQkJcHJfZGVidWcoImRz
dDZfbWluIHNldCB0bzogJXNcbiIsIGJ1Zik7CiAKLQkJaSArPSBsZW47CiAJCXNwcmludGYocGdf
cmVzdWx0LCAiT0s6IGRzdDZfbWluPSVzIiwgYnVmKTsKIAkJcmV0dXJuIGNvdW50OwogCX0KQEAg
LTE1MzYsNyArMTUxMiw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwKIAkJaWYgKGRlYnVnKQogCQkJcHJfZGVidWcoImRzdDZfbWF4IHNldCB0bzog
JXNcbiIsIGJ1Zik7CiAKLQkJaSArPSBsZW47CiAJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IGRz
dDZfbWF4PSVzIiwgYnVmKTsKIAkJcmV0dXJuIGNvdW50OwogCX0KQEAgLTE1NjAsNyArMTUzNSw2
IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJ
aWYgKGRlYnVnKQogCQkJcHJfZGVidWcoInNyYzYgc2V0IHRvOiAlc1xuIiwgYnVmKTsKIAotCQlp
ICs9IGxlbjsKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogc3JjNj0lcyIsIGJ1Zik7CiAJCXJl
dHVybiBjb3VudDsKIAl9CkBAIC0xNTgxLDcgKzE1NTUsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3Rn
ZW5faWZfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCX0KIAkJaWYgKGRlYnVnKQogCQkJcHJf
ZGVidWcoInNyY19taW4gc2V0IHRvOiAlc1xuIiwgcGt0X2Rldi0+c3JjX21pbik7Ci0JCWkgKz0g
bGVuOworCiAJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IHNyY19taW49JXMiLCBwa3RfZGV2LT5z
cmNfbWluKTsKIAkJcmV0dXJuIGNvdW50OwogCX0KQEAgLTE2MDIsNyArMTU3Niw3IEBAIHN0YXRp
YyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJfQogCQlpZiAo
ZGVidWcpCiAJCQlwcl9kZWJ1Zygic3JjX21heCBzZXQgdG86ICVzXG4iLCBwa3RfZGV2LT5zcmNf
bWF4KTsKLQkJaSArPSBsZW47CisKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogc3JjX21heD0l
cyIsIHBrdF9kZXYtPnNyY19tYXgpOwogCQlyZXR1cm4gY291bnQ7CiAJfQpAQCAtMTY1NSw3ICsx
NjI5LDYgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LAogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlmICh2
YWx1ZSA+IE1BWF9DRkxPV1MpCiAJCQl2YWx1ZSA9IE1BWF9DRkxPV1M7CiAKQEAgLTE2NzAsNyAr
MTY0Myw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmls
ZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlwa3Rf
ZGV2LT5zcGkgPSB2YWx1ZTsKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogc3BpPSV1IiwgcGt0
X2Rldi0+c3BpKTsKIAkJcmV0dXJuIGNvdW50OwpAQCAtMTY4Miw3ICsxNjU0LDYgQEAgc3RhdGlj
IHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAobGVuIDwg
MCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCXBrdF9kZXYtPmxmbG93ID0gdmFs
dWU7CiAJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IGZsb3dsZW49JXUiLCBwa3RfZGV2LT5sZmxv
dyk7CiAJCXJldHVybiBjb3VudDsKQEAgLTE2OTQsNyArMTY2NSw2IEBAIHN0YXRpYyBzc2l6ZV90
IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQly
ZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlwa3RfZGV2LT5xdWV1ZV9tYXBfbWluID0gdmFs
dWU7CiAJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IHF1ZXVlX21hcF9taW49JXUiLCBwa3RfZGV2
LT5xdWV1ZV9tYXBfbWluKTsKIAkJcmV0dXJuIGNvdW50OwpAQCAtMTcwNiw3ICsxNjc2LDYgQEAg
c3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAo
bGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCXBrdF9kZXYtPnF1ZXVl
X21hcF9tYXggPSB2YWx1ZTsKIAkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogcXVldWVfbWFwX21h
eD0ldSIsIHBrdF9kZXYtPnF1ZXVlX21hcF9tYXgpOwogCQlyZXR1cm4gY291bnQ7CkBAIC0xNzE5
LDcgKzE2ODgsNyBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsCiAJCWxlbiA9IGdldF9sYWJlbHMoJnVzZXJfYnVmZmVyW2ldLCBtYXgsIHBrdF9kZXYp
OwogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47Ci0JCWkgKz0gbGVuOworCiAJCWNudCA9
IHNwcmludGYocGdfcmVzdWx0LCAiT0s6IG1wbHM9Iik7CiAJCWZvciAobiA9IDA7IG4gPCBwa3Rf
ZGV2LT5ucl9sYWJlbHM7IG4rKykKIAkJCWNudCArPSBzcHJpbnRmKHBnX3Jlc3VsdCArIGNudCwK
QEAgLTE3NDIsNyArMTcxMSw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0g
bGVuOwogCQlpZiAodmFsdWUgPD0gNDA5NSkgewogCQkJcGt0X2Rldi0+dmxhbl9pZCA9IHZhbHVl
OyAgLyogdHVybiBvbiBWTEFOICovCiAKQEAgLTE3NzAsNyArMTczOCw2IEBAIHN0YXRpYyBzc2l6
ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJ
CQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlpZiAoKHZhbHVlIDw9IDcpICYmIChwa3Rf
ZGV2LT52bGFuX2lkICE9IDB4ZmZmZikpIHsKIAkJCXBrdF9kZXYtPnZsYW5fcCA9IHZhbHVlOwog
CQkJc3ByaW50ZihwZ19yZXN1bHQsICJPSzogdmxhbl9wPSV1IiwgcGt0X2Rldi0+dmxhbl9wKTsK
QEAgLTE3ODYsNyArMTc1Myw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1
Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0g
bGVuOwogCQlpZiAoKHZhbHVlIDw9IDEpICYmIChwa3RfZGV2LT52bGFuX2lkICE9IDB4ZmZmZikp
IHsKIAkJCXBrdF9kZXYtPnZsYW5fY2ZpID0gdmFsdWU7CiAJCQlzcHJpbnRmKHBnX3Jlc3VsdCwg
Ik9LOiB2bGFuX2NmaT0ldSIsIHBrdF9kZXYtPnZsYW5fY2ZpKTsKQEAgLTE4MDIsNyArMTc2OCw2
IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJ
aWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlpZiAoKHZhbHVl
IDw9IDQwOTUpICYmICgocGt0X2Rldi0+dmxhbl9pZCAhPSAweGZmZmYpKSkgewogCQkJcGt0X2Rl
di0+c3ZsYW5faWQgPSB2YWx1ZTsgIC8qIHR1cm4gb24gU1ZMQU4gKi8KIApAQCAtMTgzMCw3ICsx
Nzk1LDYgQEAgc3RhdGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LAogCQlpZiAobGVuIDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCWlmICgo
dmFsdWUgPD0gNykgJiYgKHBrdF9kZXYtPnN2bGFuX2lkICE9IDB4ZmZmZikpIHsKIAkJCXBrdF9k
ZXYtPnN2bGFuX3AgPSB2YWx1ZTsKIAkJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IHN2bGFuX3A9
JXUiLCBwa3RfZGV2LT5zdmxhbl9wKTsKQEAgLTE4NDYsNyArMTgxMCw2IEBAIHN0YXRpYyBzc2l6
ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJ
CQlyZXR1cm4gbGVuOwogCi0JCWkgKz0gbGVuOwogCQlpZiAoKHZhbHVlIDw9IDEpICYmIChwa3Rf
ZGV2LT5zdmxhbl9pZCAhPSAweGZmZmYpKSB7CiAJCQlwa3RfZGV2LT5zdmxhbl9jZmkgPSB2YWx1
ZTsKIAkJCXNwcmludGYocGdfcmVzdWx0LCAiT0s6IHN2bGFuX2NmaT0ldSIsIHBrdF9kZXYtPnN2
bGFuX2NmaSk7CkBAIC0xODY0LDcgKzE4MjcsNiBAQCBzdGF0aWMgc3NpemVfdCBwa3RnZW5faWZf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCWlmIChsZW4gPCAwKQogCQkJcmV0dXJuIGxlbjsK
IAotCQlpICs9IGxlbjsKIAkJaWYgKGxlbiA9PSAyKSB7CiAJCQlwa3RfZGV2LT50b3MgPSB0bXBf
dmFsdWU7CiAJCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiB0b3M9MHglMDJ4IiwgcGt0X2Rldi0+
dG9zKTsKQEAgLTE4ODIsNyArMTg0NCw2IEBAIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJaWYgKGxlbiA8IDApCiAJCQlyZXR1cm4gbGVuOwogCi0J
CWkgKz0gbGVuOwogCQlpZiAobGVuID09IDIpIHsKIAkJCXBrdF9kZXYtPnRyYWZmaWNfY2xhc3Mg
PSB0bXBfdmFsdWU7CiAJCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiB0cmFmZmljX2NsYXNzPTB4
JTAyeCIsIHBrdF9kZXYtPnRyYWZmaWNfY2xhc3MpOwpAQCAtMTg5OCw3ICsxODU5LDYgQEAgc3Rh
dGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlpZiAobGVu
IDwgMCkKIAkJCXJldHVybiBsZW47CiAKLQkJaSArPSBsZW47CiAJCXBrdF9kZXYtPnNrYl9wcmlv
cml0eSA9IHZhbHVlOwogCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIk9LOiBza2JfcHJpb3JpdHk9JWki
LAogCQkJcGt0X2Rldi0+c2tiX3ByaW9yaXR5KTsKQEAgLTIwMTUsNyArMTk3NSw3IEBAIHN0YXRp
YyBzc2l6ZV90IHBrdGdlbl90aHJlYWRfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCX0KIAkJ
aWYgKGNvcHlfZnJvbV91c2VyKGYsICZ1c2VyX2J1ZmZlcltpXSwgbGVuKSkKIAkJCXJldHVybiAt
RUZBVUxUOwotCQlpICs9IGxlbjsKKwogCQltdXRleF9sb2NrKCZwa3RnZW5fdGhyZWFkX2xvY2sp
OwogCQlyZXQgPSBwa3RnZW5fYWRkX2RldmljZSh0LCBmKTsKIAkJbXV0ZXhfdW5sb2NrKCZwa3Rn
ZW5fdGhyZWFkX2xvY2spOwotLSAKMi40OC4xCgo=

