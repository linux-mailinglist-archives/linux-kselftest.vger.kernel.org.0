Return-Path: <linux-kselftest+bounces-25831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B5A28B45
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF513A74C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC578F41;
	Wed,  5 Feb 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="F+821hWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D1282FA;
	Wed,  5 Feb 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761125; cv=none; b=JNDslZUzovoUC43wrhc2w1UW/2MMOuHQagUud6gYhnDUfXp+cXwCioXyYdUrQDGbFhUnu1zcJZmj99PBvRJ5akSmBjt/FGJz6zDvbqEdanS+ba86BXgCre7JZ03X7X5GDnk9+wMmNPbfaNGCLUuT7Mo2GFsW3UplRxJZq9Y6RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761125; c=relaxed/simple;
	bh=stM1/9AjdKijeAXGohpQ5QK37hC4Y9Dsyuw8pztVBdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krsp1AGzLlVPyen2iNZqs84LDpwpSY8XpR8bXRqeFN84lcDQJKzer06AnzCoGmqP/fXlkEnC9lj/KL9NKqLQRtYLgmfIQzzcX+Dedwj5tFNEnzkNp1wzMK0vudb7jIRKSjR83RUi+9u1Vhc2yRsa7L0n1hX7H1Ttb8zYUaS30x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=F+821hWC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761121; x=1739365921; i=ps.report@gmx.net;
	bh=stM1/9AjdKijeAXGohpQ5QK37hC4Y9Dsyuw8pztVBdY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F+821hWCj96ncGZVKge9ozOYia7SicXwX4hTxxaFVkcxzXUmxnhV9reW92nB9sks
	 R8ulkcAxltxm0XZ13YNesK8KA+gtxf5WW7pvGEbpssJC9E3ZnVBa83uEwo8eaRmlK
	 DX1A5WQzeGskqyPuNqpDTd7oRvPycSRuIsX6Au0ur3hAEBhijbrTacgUZ8hpbs/Dr
	 N3i6GVpGj3yDskWIJcrtzZHgcX33csljnP43lJ4F35YzmOEQoRjOHcPl2ua7LZyBL
	 crrF4tvLEOhY8JmdWDEHuVUqe/Hbr+WuAFd4eLLI/BoGbTYhbJk1MWm4nZoOEWgzX
	 z4cCykctfumI71APdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1tf6xv2htK-006Y5Y; Wed, 05
 Feb 2025 14:12:01 +0100
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
Subject: [PATCH net-next v4 03/17] net: pktgen: fix hex32_arg parsing for short reads
Date: Wed,  5 Feb 2025 14:11:39 +0100
Message-ID: <20250205131153.476278-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:d7X7Px23WAQWipDRMSCjC7PcFAy9nU/diRro79SzNpoJt7TjYkQ
 j9Xz2MAcQa4WVlrejBxMd9cGAC6Vo9t973zkDR5woa8vAZP3V1Am7jeLu5SWczC5+X06ynL
 GPin3+0hHnsmTmMjbRbBJ+bIdTQMTfuTwJ4E/Q61puwHJWgRsz1a90IjHoxuO3hw0AG6iDA
 W5pDjECcSDXkLYRGnNDzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qhr2/ur4X6Q=;LRkCfqVH5Sdl7DThzSwHdKMV7bi
 3c8NXaaKjFmgYd+veUfj4OMwY16r9p/TJjwCls8c58CSxkGlt4TqtGgZLISSQMeZT70mkkyi9
 h/ys6WG/dA3TuYGpM1kP8RI9UyMazGQzw75O2iAt9yGO4FSZDWDLDM9j1qxFw+RSvZrOOmGkS
 HleHWuqYD62G9MCBLqF4HIsr3eI9AdeXQDq/DSSD7SfuWuokIZTdRrYFaC2CoAJcvCHYF/GGr
 GWmowfuqke0GvKRZzntZtCax4jEO9zLco8Alm1+uSfMZ/I7Bfixg+Z3TvLB6oQffK5LqUUDdM
 d5C2RmiZ1cTHSEYdweO7ni571EszyzOqNKWifGLNtGhxes7bwLEQCA8n+nz+0iiuLW5krlfBV
 gkE0m9MNn5Xxm04RqlCwadUqpp3eBu6B0BZrMG8BA4xK8WEAKNM4b6ztG5u77WZTnScvk01k8
 GSmFncdANOFSTn+jh+hKLFsKVopGU/X7v4iaGv29L7oOMz0bREF2VZs6krZMJtoOKvkv9V3DG
 lFSr0n+kSCwBvpOydTKB63UmqsOfFdNM0C/IaFBJ4C1AkeVFQ6P6VQXoS8avtpjX775sv3gWD
 tvhDichvjeD5AP33fX9l3IVUNddlGIY6Nv+qrA9pA9ASigTU22vBHJr2+CZoVyZjhTAzmdu2l
 yDBiUGul1mVcL8l5M7m2wJYJpeY2tZui0KO/XCMOAylDxP/srmDAtXqsJxTA4fYfw8XppfZJG
 KKF9myXa7Emm3KDrlbMZCbLsRsvNU3qDvNHAR2Wq43gznL7piv8VEYw5Ut133RwGWBy3pNCE5
 /MIuisD5SFSB7LdZtL7hRQjH435gnFT2OafWHGQD+4UAj5+HR5Dzcl7nYsJB8Can47ZVd99Dg
 smvxT+Xz6G222HS3QaPPcsPSwLkoenbm56tdKvo4+pD/6LJhVQSi6fxY1wq82SWw9wR7rD01V
 jOENcRznDtIilFfCCbAHRDpqE+zbkgCnatwPQ+NIjWgPhet3CeunGR97C7aUOx5MJnyuFhLYU
 fFn9R7HdkuJxIJZN/6zHgjz21TL4Vnvo9f2pm/cQDYFCyDe+9RABnUio7H60FScp+iHKW79vl
 YPgdusBnWU6qUb+XwGsFrXSJSY1etBH+wEFbaS4si2VXZo0r+Ju7L8hZc//9KG2Vumag/RMCQ
 7UUNCbNWhGhUkjFuFd1LFwJlRv7nWTde52KflfQ5VKqgl/7fiSUMj72eJ0boG+4vqm6Y3Vd7L
 dWEU2TQeb1H3yP6AnVzieUEWSVIhcvu5FEi0nt4H9reQJHOID7Vn8rkRQewjNsC6Z2x+uHKMM
 /jZ3qrJly+S1praVcdGeoaRpfwYH/KsHdRm66SUto5UWrpMi2bWQ8UX4i5Uj5kPAB/cQKf+in
 NFqdPrHdBqfY637rCQJni2F9WsVjMg4Yt083DR1dFT5I2kLSrYZjoPOb7r

Rml4IGhleDMyX2FyZyBwYXJzaW5nIGZvciBzaG9ydCByZWFkcyAoaGVyZSA3IGhleCBkaWdpdHMg
aW5zdGVhZCBvZiB0aGUKZXhwZWN0ZWQgOCksIHNoaWZ0IHJlc3VsdCBvbmx5IG9uIHN1Y2Nlc3Nm
dWwgaW5wdXQgcGFyc2luZy4KCi0gYmVmb3JlIHRoZSBwYXRjaAoKCSQgZWNobyAibXBscyAwMDAw
MTIzIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAKCSQgZ3JlcCBtcGxzIC9wcm9jL25ldC9wa3Rn
ZW4vbG9cQDAKCSAgICAgbXBsczogMDAwMDEyMzAKCVJlc3VsdDogT0s6IG1wbHM9MDAwMDEyMzAK
Ci0gd2l0aCBwYXRjaCBhcHBsaWVkCgoJJCBlY2hvICJtcGxzIDAwMDAxMjMiID4gL3Byb2MvbmV0
L3BrdGdlbi9sb1xAMAoJJCBncmVwIG1wbHMgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJICAgICBt
cGxzOiAwMDAwMDEyMwoJUmVzdWx0OiBPSzogbXBscz0wMDAwMDEyMwoKU2lnbmVkLW9mZi1ieTog
UGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgpSZXZpZXdlZC1ieTogU2ltb24gSG9y
bWFuIDxob3Jtc0BrZXJuZWwub3JnPgotLS0KQ2hhbmdlcyB2MyAtPiB2NAogIC0gYWRkIHJldi1i
eSBTaW1vbiBIb3JtYW4KCkNoYW5nZXMgdjIgLT4gdjM6CiAgLSBubyBjaGFuZ2VzCgpDaGFuZ2Vz
IHYxIC0+IHYyOgogIC0gbmV3IHBhdGNoCi0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCA3ICsrKyst
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA0Zjhl
YzZjOWJlZDQuLjI4ZGJiZjcwZTE0MiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysr
IGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTc1MywxNCArNzUzLDE1IEBAIHN0YXRpYyBpbnQgaGV4
MzJfYXJnKGNvbnN0IGNoYXIgX191c2VyICp1c2VyX2J1ZmZlciwgdW5zaWduZWQgbG9uZyBtYXhs
ZW4sCiAJZm9yICg7IGkgPCBtYXhsZW47IGkrKykgewogCQlpbnQgdmFsdWU7CiAJCWNoYXIgYzsK
LQkJKm51bSA8PD0gNDsKIAkJaWYgKGdldF91c2VyKGMsICZ1c2VyX2J1ZmZlcltpXSkpCiAJCQly
ZXR1cm4gLUVGQVVMVDsKIAkJdmFsdWUgPSBoZXhfdG9fYmluKGMpOwotCQlpZiAodmFsdWUgPj0g
MCkKKwkJaWYgKHZhbHVlID49IDApIHsKKwkJCSpudW0gPDw9IDQ7CiAJCQkqbnVtIHw9IHZhbHVl
OwotCQllbHNlCisJCX0gZWxzZSB7CiAJCQlicmVhazsKKwkJfQogCX0KIAlyZXR1cm4gaTsKIH0K
LS0gCjIuNDguMQoK

