Return-Path: <linux-kselftest+bounces-25587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA761A260D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 18:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC57A259F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7C20FA8B;
	Mon,  3 Feb 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="s1ZPJ5h1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98620F07A;
	Mon,  3 Feb 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602167; cv=none; b=prWe/ZhHJMJLl7LpVZkDl+8FDUuh4hoLromkQ+xjyhFEf9Ly8VxgcY8v9AWjxaWry0SxMrNDXk580dHWNGsfMep+ZVamTbput+/15e5MJRvdujd3PxqQpk+PIaMz/LfJ9jLBMKyELicLrbJxGa5vFvztDxRbnRAm4Pew8NZdxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602167; c=relaxed/simple;
	bh=XYAqqxfOd4K97F96CABMIElX44iLTKCo20ntWNluzPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6uPpevBiYlbXwhfkuIHSFSG4xN1Um9ZzrPC93Q9aHVhFKzacbqHS/RD4YM90c6Q+3FlRSwSeIRCcYy5G+dVrQS45PLuf9BJ+m4dNwYy8+7dwEd8urDHPmMwE9/FVl0axBwGHYRyIPSXMW8OMBxdE0mfWi5clTO76VhwQ3LJFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=s1ZPJ5h1; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738602149; x=1739206949; i=ps.report@gmx.net;
	bh=XYAqqxfOd4K97F96CABMIElX44iLTKCo20ntWNluzPE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s1ZPJ5h14084YKFsis9wl2u/reRbhgIMu+izkOeHw0FbvU5dXfctjdi/QbQhxESc
	 Xt7bu89FKTG88pebzlbjUQv0w5ocL8QI4NNiXAeNuWi9mVCTW6EXFOI16+ufRUxpQ
	 9m1fySp8mS9du1akMe/Fg6axCFW774YvbcpLRF7tI72mB45NNGxPMO4IANUf5sCaI
	 spG8gYgDZFzrQc5EPHPSCCYZ/aZDmkaRvJE2HEcakqxq8DbuYcKO4mYSpz8/wtuTe
	 eh1/KvrNtv4tCdUGSfwWRHSjuWT6ICj64AKLkv3fgJ/Db/H5IblgNU5zK9j9C0frR
	 kqpd4ttFYXNK52i1kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1tNT1Q1aXx-014taD; Mon, 03
 Feb 2025 18:02:29 +0100
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
Subject: [PATCH net-next v3 04/10] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
Date: Mon,  3 Feb 2025 18:01:55 +0100
Message-ID: <20250203170201.1661703-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:ps5aTIrNCztv6KI7hrchAjf0FiOZxzlsJJmIWAvelJgKo4W6KaX
 6thWWPM7+LZXGhNoEGa3EsgM6CrARQLQ6n9LROJQHRelThtkjg6yXvdA7TJxC1KlKIwa5k7
 Lolip95Pm5iv99Y2qFbIjtjMKaFbI0PJjMDXUu6roLdiAb0ZI+uBdKcB/yRjqV16INJt+p6
 DwsUF/RFGflviZfLM7utA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BCJTPxYCcjw=;KT9wdtvHNdO99CXmHd3twLqvsx5
 wgoJTTNhpZUFjcxh1yh681C6J8OrqeeJSqxuH897f6YOTWzxgN3p+lu94ozu7oVjdjzrUiqIm
 O9YWNPVYgGxDbWmxOKXJjFB2m8oID1RaXltleKsc2DQv+YlwCLIREy+G33WqEEUatFg/rSLjp
 m6cfUFHbOl5ab9PYqGwaO3w4Aq/Ni4Zl0XTvDdaCf319z0WEq/mW83+swxJ+xxnJYMVt1he4h
 2DB2br3tLYbABhiJ7kV0O55muUvaF4MsaixTpIoF0yHDHiHv4+PpthnA6ZE0/zf8mPLAb4snj
 cpmeqR+GWoOC5kfYC5cVrbGvm5pSFpix5t84cxthgP77ymh8F/Je0NyAGW2q3wyxLKiZ0mHAj
 T0B7jbFMmoSxT4CoKbq3lY7YcNX1Z8DwptLFHAGT6ceSAWmD0DVq4MrhILzwwiIQJLY9hJREx
 bPykwsLUDJkQoefOWqtHpid/UuXatO+dwKhKnUErBGVrsPBTaXiSh+pu16vpDC76yMb1xfXvO
 X5ppAJuf5sCyDulNzrnPxpoK/xn03CHDZaqAuNE/fGo6JW0kFFb8OUKZptV2uNVo8rWjReBz/
 E0m2RMQ4J1U2lKy2P72lOpbyGVDyQzN4P+VclgyObfYZZyo6PoEJAPe8qdvE0/oxqFg690JQS
 E2AsdktME5/YB5F2YQlvNpjeN6lFN1Ws50+96eQZlfCE53z9/EHy8/SZPUtvFJbA30Iqm8s/p
 VMblI/pb+W6lLFgvW60c91LupX7eVHEanhaiGk8ZC/5WvMq2JYqvhw054i8J3H+nuJxqmvZTM
 QY4Vw4obNVegjbCsPGZe0u9StFcBz9wQCSvo1SyzAWoy3VOJjJjhfvc8aN7dKmqnkAhBSjzst
 MxtTg2NcmztiTe+35bnX07ehgfgZuAPw9enQpoVmxltXP2Nl1ALO7lZLapOvZ/NDxU9uDSiai
 SfGxsYpPuGituklkQjoSXVqQwwF9sZs5ZyHjtp8FJSCfg7l3UuwSBW2JGiYFgb2i0oCy1ECDZ
 GpPhjY7uLlyzStEKXyiuTVZLLewyzN/0QKIYqBdd4WY0c2lm2/rqivEydfKDLJOpCDxV3x3ga
 RwVpHyQOyBKmiYXPh864sYsSac73GRtPkXNJRLd5hGAf9IMotxb8h/P5r5WkssSn/JM6jVB/O
 cDyyAHwonqbud1OPS+RdkPCJZ4QysvvEteYj5EzbrnlQ1MYB6QZ4xa/t0FB90qOmQkgS6B6EI
 m6bImxZa4YrCVZtAnT4LPJxwZHGipHSH2aSgZoJRYv45b0PnYPHr/DUvHd4CZWcIZTFDbXYuw
 P3Kt/2Wo0BFQj5alSWpA2NNWhwICOchMJ5bMO4z9lhu9xc=

R2l2ZW4gYW4gaW52YWxpZCAncmF0ZScgY29tbWFuZCBlLmcuICdyYXRlIDAnIHRoZSByZXR1cm4g
dmFsdWUgaXMgJzEnLApsZWFkaW5nIHRvIHRoZSBmb2xsb3dpbmcgbWlzbGVhZGluZyBvdXRwdXQ6
CgotIHRoZSBnb29kIGNhc2UKCgkkIGVjaG8gInJhdGUgMTAwIiA+IC9wcm9jL25ldC9wa3RnZW4v
bG9cQDAKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBP
SzogcmF0ZT0xMDAKCi0gdGhlIGJhZCBjYXNlIChiZWZvcmUgdGhlIHBhdGNoKQoKCSQgZWNobyAi
cmF0ZSAwIiA+IC9wcm9jL25ldC9wa3RnZW4vbG9cQDAiCgktYmFzaDogZWNobzogd3JpdGUgZXJy
b3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2MvbmV0L3BrdGdlbi9s
b1xAMAoJUmVzdWx0OiBObyBzdWNoIHBhcmFtZXRlciAiYXRlIgoKLSB3aXRoIHBhdGNoIGFwcGxp
ZWQKCgkkIGVjaG8gInJhdGUgMCIgPiAvcHJvYy9uZXQvcGt0Z2VuL2xvXEAwCgktYmFzaDogZWNo
bzogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQKCSQgZ3JlcCAiUmVzdWx0OiIgL3Byb2Mv
bmV0L3BrdGdlbi9sb1xAMAoJUmVzdWx0OiBJZGxlCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlk
ZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQpDaGFuZ2VzIHYyIC0+IHYzOgogIC0gbm8gY2hh
bmdlcwoKQ2hhbmdlcyB2MSAtPiB2MjoKICAtIG5ldyBwYXRjaAotLS0KIG5ldC9jb3JlL3BrdGdl
bi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRl
eCAyOGRiYmY3MGUxNDIuLjc1Yzc1MTFiZjQ5MiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2Vu
LmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTExMTUsNyArMTExNSw3IEBAIHN0YXRpYyBz
c2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAogCQlpICs9IGxlbjsK
IAkJaWYgKCF2YWx1ZSkKLQkJCXJldHVybiBsZW47CisJCQlyZXR1cm4gLUVJTlZBTDsKIAkJcGt0
X2Rldi0+ZGVsYXkgPSBwa3RfZGV2LT5taW5fcGt0X3NpemUqOCpOU0VDX1BFUl9VU0VDL3ZhbHVl
OwogCQlpZiAoZGVidWcpCiAJCQlwcl9pbmZvKCJEZWxheSBzZXQgYXQ6ICVsbHUgbnNcbiIsIHBr
dF9kZXYtPmRlbGF5KTsKLS0gCjIuNDguMQoK

