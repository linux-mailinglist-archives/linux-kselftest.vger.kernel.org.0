Return-Path: <linux-kselftest+bounces-27760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55049A4802F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577073A9C3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8428A237179;
	Thu, 27 Feb 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="sbP/y1Hc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B8232364;
	Thu, 27 Feb 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664606; cv=none; b=CWewBK9/1gOdMbkUHuHblxBoqsyMqGUmfubvGE+ztovb4fu934K4mtBB4cb+VdG1rW+a9N8qEvTxov5QarMLkBflqqM8TUZixSBBmg+YvPBvvvmwpms8dPOgNPt7JQ84WVBImCAEud8tVpi/ktBHIQ1FaFMxD+9bwHRQ0KrcmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664606; c=relaxed/simple;
	bh=U55Wfaml+iLmuDzRSmhF6XHXxgqauTNIupr+1KWPRZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJtqATs50LjAn9XGY7YBr9EzI1Sa208yI2FryKB6laFqXit5yq2wYJFVD7EoGZJesuuzkcpJ/NSjtyfgwBDfJBinoCINSNZiOZG3bCPaataL47BGwFx5Ypa29gQLfv2tcO2vxMBoU0vD4YsYW5tJre/rpCXdVksO0ANPyAfe6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=sbP/y1Hc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740664576; x=1741269376; i=ps.report@gmx.net;
	bh=U55Wfaml+iLmuDzRSmhF6XHXxgqauTNIupr+1KWPRZk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sbP/y1HctdaY8Nyn4Uj1Kx3Hpt1Ful3MvpliXfrPzCnncEqeMmBGchyUtAhfRsnb
	 I2z0VnLKXfPzPM2YX5f71UTMm/EHMlsozLped3ZSRRNBJiozSy6r88s5yxsfTrEoH
	 2trK96horOzs4+B5AQfxmGS091MrxysLIlq26zAjb0MzcVFileL+brqIK5H+w9OE1
	 XnDyJX5kR1Fwlt+jaJbNA6MABwn21EQneQmMGg7WMTodHrFaOiVB2oc3j0ZoVvfRN
	 C24gwFlzSzm89ZDZ5oJkIHKauMn/PyvLYP/EbyqVd8+bbbLmZYrCzpzPpLeVYuoSa
	 wOMX1sO9jWpiLgYkwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiDX-1teVfc47Dz-00UlyI; Thu, 27
 Feb 2025 14:56:16 +0100
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
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH net-next v8 6/8] net: pktgen: fix mpls reset parsing
Date: Thu, 27 Feb 2025 14:56:02 +0100
Message-ID: <20250227135604.40024-7-ps.report@gmx.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227135604.40024-1-ps.report@gmx.net>
References: <20250227135604.40024-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qXH4O+ui+hIs/MVWTwQuygtjseriezg+brhpV1ZDBDiz3fuL7Wl
 wYa5VCSKSkYbDBCwgBCjz6XYP8ui5EnBFVXhQVcB8jNdAuqroAP6BwSwmIfFF7zZiDSlFG6
 Yp75Vp7EoLYljsBAeWbj/ZBtVyT8HBqQx/WuIDWfI6OD0fLIC0m5HmIYxuwrl2l+AVq1APn
 M6xYHprMtAoH8MRbUr/HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ONC9ffTbhzc=;KaLBZ5Z2xVz2txuGiXrKGFlbIZK
 SIl7YKx4TqQ//onW/OXIJlvA8SvDInNHsBK/fAniAJHFt2RePoLNvAHt9J9jiCmSxv7w4Enu2
 XwDXj0a19gBsw0ECL+Ay1rXgY+SSEmZ7O+EsoUekm4Kz7ZhlN9u/geuylwKLKymg2s4c2Tq+8
 njAyd0fwyXPkk3EM/jSYdD9vlLr8Fr0JP8FB/VCaattrYSFTt/DQQYb5bHUnglh4quQtNF6WU
 mVHR4lq1Bd/UuvO/FRUleFvcrfEkGaGfIUyammSTR1JWfAnnVtuzvMcr/Kz7WAoV51dDiqFsD
 xzgjfArV7Y5Dgk4GF//JyLh/y9mFllBXxDF1NjBOaDJQWGI+fKjMkuBU2q8a4Cl87mXJg7qtB
 bVCFZcpnCDHHWVyOJIaji2m78tujD6mxX/+jx4L01X07b0g+QLB9rRwUaZJfoYDDdeJ55jD/V
 6x1+iahhWjlCya0zSDx3aX9GFiYXgBLxZ3bt/Bv1pgu3blNIquLLAxgWjxDcJfL8GinNg/F4j
 cB5UkgtDWibQL6f09xD+AHhywJi4eugNgMni9DF78cpz3LPCTTntn1bxBXu1WhRtgm6UteHiY
 v7Kv7VDucDpZlxE3bvF99HqCb9uD47I0tGdf0dgL9bJct86CIqHmWIG0jmV2v2rpgkUP5XWt6
 my1o8Obxm8qfTIP78ikVUAOKtHI7zNnuqG8iUilioXOe5vnFMQhR48QJduQezDqaKh6NhgjPW
 uXBCpBNmTtkggrtx6lTI7QTJ7QddywGt8Tdz+d0JNV4hyDoPooEMe0zK7zvbMPBGIZBw10Gbj
 HqAJEBf9VyDZHhtCCMC0CHzQjuS1NuR9nkZHtLxHuK7jht2V00pSjX+yc8q/5KYrjJTHyH+X3
 xfT31ElIRHBdZ1HHOWzYvG762aLv2YtOQaneh7UczKTcEYeGyNtsCDVJxi+k39W9b8mCq2vm0
 mH2CXrEK/jWc70SvnwsBMoTKNU0ovBI0iqFh+opGPtdQMa7/AdCZsslYvDYiMvPz/LYO7PNkG
 QYUJePss2rL6yATr0we8gzgj8rJcivGshVC1HMIxvPu1yvCBt+8hnCuoBJffsSsBf/+gtMJGM
 5GWoOkXLaMOyrxZI1FcgD+fQvukKo+81LyYDP2gLEJUrO5i6mW/mVo8YAZoKdwvT66VyvjQyI
 drEuOFNlO1zLQn3Ge5mIwzWipSI/fCm4gyhXNofZP0BVdkZEvNezGv1vZ3qKiuAeiT1f9iYCN
 Bhh1Qor0qssSGKd+0MNklhLkNnV0C5VLjIoPDbKvvjlYya5pOWCZPExA4e0mFCyn6A0nYwj3w
 W0JAGQsaedXaFFKwIqRvTXwtT4sWjDobIboss57qNSCgt0/HlU2iSbHnQT+QPubvhr8yexTg6
 3FRZtt7VWNu+1PbYBO4i0XDSPNIYNr6NS/QFc06CHi9kyt5BxE0Z+jeMn2

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
bW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KLS0tCkNoYW5nZXMgdjcgLT4gdjgKICAtIHJl
YmFzZWQgb24gYWN0dWFsIG5ldC1uZXh0L21haW4KICAtIGZpeCBjOTkgY29tbWVudCAoc3VnZ2Vz
dGVkIGJ5IFBhb2xvIEFiZW5pKQoKQ2hhbmdlcyB2NiAtPiB2NwogIC0gcmViYXNlZCBvbiBhY3R1
YWwgbmV0LW5leHQvbWFpbgogIC0gbm8gY2hhbmdlcwoKQ2hhbmdlcyB2NSAtPiB2NgogIC0gbm8g
Y2hhbmdlcwoKQ2hhbmdlcyB2NCAtPiB2NQogIC0gc3BsaXQgdXAgcGF0Y2hzZXQgaW50byBwYXJ0
IGkvaWkgKHN1Z2dlc3RlZCBieSBTaW1vbiBIb3JtYW4pCgpDaGFuZ2VzIHYzIC0+IHY0CiAgLSBh
ZGQgcmV2LWJ5IFNpbW9uIEhvcm1hbgoKQ2hhbmdlcyB2MiAtPiB2MzoKICAtIG5ldyBwYXRjaAot
LS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMg
Yi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCBmNGY5YzlkODM2OTQuLmM2MDRhNjhmMjg0MCAxMDA2
NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTkx
Myw4ICs5MTMsMTMgQEAgc3RhdGljIHNzaXplX3QgZ2V0X2xhYmVscyhjb25zdCBjaGFyIF9fdXNl
ciAqYnVmZmVyLAogCiAJCW1heCA9IG1pbig4LCBtYXhsZW4gLSBpKTsKIAkJbGVuID0gaGV4MzJf
YXJnKCZidWZmZXJbaV0sIG1heCwgJnRtcCk7Ci0JCWlmIChsZW4gPD0gMCkKKwkJaWYgKGxlbiA8
IDApCiAJCQlyZXR1cm4gbGVuOworCisJCS8qIHJldHVybiBlbXB0eSBsaXN0IGluIGNhc2Ugb2Yg
aW52YWxpZCBpbnB1dCBvciB6ZXJvIHZhbHVlICovCisJCWlmIChsZW4gPT0gMCB8fCB0bXAgPT0g
MCkKKwkJCXJldHVybiBtYXhsZW47CisKIAkJcGt0X2Rldi0+bGFiZWxzW25dID0gaHRvbmwodG1w
KTsKIAkJaWYgKHBrdF9kZXYtPmxhYmVsc1tuXSAmIE1QTFNfU1RBQ0tfQk9UVE9NKQogCQkJcGt0
X2Rldi0+ZmxhZ3MgfD0gRl9NUExTX1JORDsKLS0gCjIuNDguMQoK

