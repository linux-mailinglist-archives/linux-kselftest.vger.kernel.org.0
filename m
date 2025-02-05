Return-Path: <linux-kselftest+bounces-25845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B188A28B6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1433A80AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664351991DB;
	Wed,  5 Feb 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="mGBNQtPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEB18CBFB;
	Wed,  5 Feb 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761136; cv=none; b=uYYRMmc5uDXQ+AGXDgHuTykmJYTSMJ/WGTNTcBPJjSEj+uErQzKga7TijeefVRO5quppaFsj/OCDBP/PgSRrzC2iwoaW9PVJH5LO+xLZf+wFttrh2cPzSxWDwW6rFaePwtKqcKDF1FH2QovZkEk6nvqF9wAXfPPbI/WX1VALvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761136; c=relaxed/simple;
	bh=f37hhHJiJKAnuE19WVG25n29TMCE4FA65Sj0CGh2ASk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND8hihD7Z9klibTXtQS0K7setueuS5VW2MFtaghoEcbb10xqwq7C2GHiAM50Re28i6sZ6B76gbQ1eLEXjuUhFOA/yhN8Qgg41B/+W4aZEYhuoRO45lHNqaBT86JKafE4zVsAF2DXdcPBlGvQZQ2zcMKUusJzo7BePbPXgBJwf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=mGBNQtPH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761125; x=1739365925; i=ps.report@gmx.net;
	bh=f37hhHJiJKAnuE19WVG25n29TMCE4FA65Sj0CGh2ASk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mGBNQtPHmFYpspr6mdCOI3Y5KcMVJB06KDZJmO/gOiN24KAAMYNn+a0rJeWK9mGQ
	 nUfoGaS4bR+CYdxw/0qhwh8IIuZYS8rSD3opUFvhlVE2ffMqfH16D1VEMrmrG8T8W
	 t+uDh1upf74r6b4iKdguUMgzSr1nTgIiQ+xnChN3bWi816MYF06IrcbUmduJpJEof
	 OvVBz+i3kBcnQ1tEzDWRv3dX8yy4dXIFOCrSLsXwfwa8f+Bfqp6LSUSClnuigIPjB
	 o+7oHl6TsjOLD+i9l6jP/7NvGG6XlDqvAf+PYFjNb5NHPzmJbKTsb/sNZiViROhZs
	 K1433ippHSap5rn+5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1tlBVg3ReG-000ULO; Wed, 05
 Feb 2025 14:12:04 +0100
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
Subject: [PATCH net-next v4 14/17] net: pktgen: hex32_arg/num_arg error out in case no characters are available
Date: Wed,  5 Feb 2025 14:11:50 +0100
Message-ID: <20250205131153.476278-15-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:M0Dcyil/fed6e0PMh9kYIQPeSzJ9N2shPblHH2cfYWmID4P+tff
 TA6AdzKkK9ZZGHme388VAbybPc1uj3FJzcatPIPAse1rN515qSnEs83uibwsGgwl/0JzxQT
 Uq2H2K483HcvsKSmaNle1uJvJeRnAuYIDZB45/uZVi2B5MVJyGzgiZ54f3fxiusXSW5hM1F
 5AFdQDUxouHu1Tqd07HqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pllvyhmy4Ao=;G5J6kKI5ro32Q9VaO5dIYZ2kFQw
 04BEuEyVGOwJlRd4nmcNY/3X92uT3ly6lNOYSPIin0yX98aNRTrEtojRNJD9FesexFALxljbA
 MUNJ/lRMYUG+wijbjZS499tR82ntbXrrTexwAGIiXrKydoiQe/XHds/ea5p23nCmqydhomOoN
 NAb1oVXuAzMedqAyhD3A4ZcBpZdDOOgNVXi53IAmF/7TBtEAHOQbJz7tFYA89f+pvk56hNgTZ
 qxMFv8T/YES9HBIkRQnU4RfFkMjFZQ7rZzkNiQ1mKvAn2/qv5kMKTMYg33UJl0CRBKSWhs4PA
 6eD5F2tbTnWXDz+++gzzeUaEoUQqVzW39uGKUA7n2GLM0f4/4rTmDJb9hQH0rNnfDHGMf/Lad
 MIf2Zz3pcW0ecGC6zT/LJWvZ9QCeJIqPAEz+Xvib2NHZ6m2DzGlIYpKmHccaxO0VrD5tP1iL9
 7+bCTdlQlysdU5i2hFilEIzx58GWFfBr0DcM1D5kR/3OogYs2ErtcwSdS8tIQRHW5dt88IIy/
 sAiMjrIwkcL01RpKs5fYKBIGDof+QvCpfihYLrvS3ezDIa4w20lg8LtlXOIYD/qBx1+CaNA+t
 3ef3jxlig08v4G7Z81tGC1SFVwWu66k7psi0EGda2sxuksQCToB+tZ4QthAMCAPOZ2ysFZ8OU
 iyZ5XXw9Jc3KisqE8HoqOU+rUJDa2NHdX+TruDTw1npdYeYzBcmilGIRp/U5wAOK0yFjmOiGP
 Lugv/Q+uhrlThITGCizf41PStgBBHjGo9m14p6FoiZ0pcXTH6oMoj+kPATSz93KF61kjxW/VQ
 GKUERjDpmDLT9dHdjzvjWh6IZoVUEzwQ3syxsVjMn7c0VTM/uMiW1qGyFSU5/FOhCWYEkCMDq
 wziZ3BgylVk5ui0mOZjFYnEXCIO7Ne07wheVwR5Qv1ASMZeBqb+433rL8WUyBoNO0N0GCwnrR
 mo1diI8dJBC17w/zrz7zlYpa8Fps5kBAI449jKQOkmSLnIEN588jXqT1R4jOJjsaY8t2DSwiv
 jy9kRXUTY1KhG3zM6zoNfZcrtq7VgN8FlHwRUDgzCMv0zSDZXAXjZUTdVI4avz6JU97lHosYg
 iPZbc/qvpsHgQyjGYHbFCyoIv1UPAxvSaldf4+6cL0+xPWe/57pEpliTGCB+HIhyKtWKZv2OH
 4ed5Ik1Z79OI/LnzrjtYu6gtj19YUqJ1JsiP1+1Qsj4n5bLOsDMrHBZv1+qkYrIprMd3pyVUF
 r8SegQr81P1mQCaFNUliPGhJIeNthZvFcA31ddfEJQ0vZANVEjgSVYAQJzwAQWrqjTYxyGF+n
 cSSY8jWmg7wKSM7vhdFia9LFXvK3r70DVRfmM2FxXOUTfo=

SW4gaGV4MzJfYXJnKCkgYW5kIG51bV9hcmcoKSBlcnJvciBvdXQgaW4gY2FzZSBubyBjaGFyYWN0
ZXJzIGFyZSBhdmFpbGFibGUKKG1heGxlbiA9IDApLgoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2Vp
ZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KQ2hhbmdlcyB2MyAtPiB2NAogIC0gbmV3IHBh
dGNoIChmYWN0b3JlZCBvdXQgb2YgcGF0Y2ggJ25ldDogcGt0Z2VuOiBmaXggYWNjZXNzIG91dHNp
ZGUgb2YgdXNlcgogICAgZ2l2ZW4gYnVmZmVyIGluIHBrdGdlbl9pZl93cml0ZSgpJykKLS0tCiBu
ZXQvY29yZS9wa3RnZW4uYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwpp
bmRleCAzYzQyZWNmMTdiYTIuLmNiM2I3MzJmZDBhMyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0
Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTc2MSw2ICs3NjEsOSBAQCBzdGF0aWMg
aW50IGhleDMyX2FyZyhjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWZmZXIsIHVuc2lnbmVkIGxv
bmcgbWF4bGVuLAogCWludCBpID0gMDsKIAkqbnVtID0gMDsKIAorCWlmICghbWF4bGVuKQorCQly
ZXR1cm4gLUVJTlZBTDsKKwogCWZvciAoOyBpIDwgbWF4bGVuOyBpKyspIHsKIAkJaW50IHZhbHVl
OwogCQljaGFyIGM7CkBAIC04MDgsNiArODExLDkgQEAgc3RhdGljIGxvbmcgbnVtX2FyZyhjb25z
dCBjaGFyIF9fdXNlciAqdXNlcl9idWZmZXIsIHVuc2lnbmVkIGxvbmcgbWF4bGVuLAogCWludCBp
OwogCSpudW0gPSAwOwogCisJaWYgKCFtYXhsZW4pCisJCXJldHVybiAtRUlOVkFMOworCiAJZm9y
IChpID0gMDsgaSA8IG1heGxlbjsgaSsrKSB7CiAJCWNoYXIgYzsKIAkJaWYgKGdldF91c2VyKGMs
ICZ1c2VyX2J1ZmZlcltpXSkpCi0tIAoyLjQ4LjEKCg==

