Return-Path: <linux-kselftest+bounces-33240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182FAABA7BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCD7B9BB0
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2924C14830A;
	Sat, 17 May 2025 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PhSQsqo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic310-21.consmr.mail.sg3.yahoo.com (sonic310-21.consmr.mail.sg3.yahoo.com [106.10.244.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB0142659
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447269; cv=none; b=GsAo6EsdNVBA15D3JIb9qqfJlsfJOHE/d259+p8pRdFuGSqM46UUQwYMdu8de2CKKP84uf9/97rBNeh09jNrtAgTyIqYbeV9eNtxwmbLsy7v3Vz8bpA81LfbMheTiPNL0ZXMEYJG6GoRYSmruIj4XBF6mj1BuOLi6tvZrte+P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447269; c=relaxed/simple;
	bh=BCc/rW32Wnzn+wJPRrS/IrXs4Sf04HskW80DQ3/jWJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=FtvIbXVQo38UKXEEFoMfVoN0mTAQ1lDu4S0FGynculr+Kgmb3PhNsGSiCgZUcQs0uFEWJMq8McM8U2GhDOqm3IrleYHJr8cNiN+jxsE5jE90z7HlV7PEIvUICqRNr/u47Vr7/LfpVtd5EsA0rcgPxcH7HjTbU0KnAFWRnIzj3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PhSQsqo2; arc=none smtp.client-ip=106.10.244.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747447265; bh=qo5n+gwuGJKsyCjzzOb8RdhLxii5DRJbYX6ajPgcKzc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=PhSQsqo22VfS3C0opSGGaw9LWIH/CAQc+zUjLJulzK6l9dDs7XC/whXUor3dvAiUX97zLkFFqi1X1Z+BuokdyJZJNQyb6FqnftwvGK/P3N0OYzusNbd0qkovPvuISRJpjHrZJBugkJeuCiAHQOBrTzdDnOPhEYtfCsbQVpygDFBMQ6A+kIfr02wnq4pgp10JrWDykr91GrxNCVxMeEchyUmifXQOKtunF5fWFGYmSBAXOrCHpot6NhW0m0bK7zm8QXxoMTohVqLTWkJIn9ghUwQh0h538as+bS1J/ck+bAkhmSUbmPrsVeEkiaGNVRkX6+7ZIq1yfdQo5i6d5xsn4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747447265; bh=ny8UPW8Jxw6n9CBOrH2hWxK5wclWd5xmDoaEIBzYJvj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lBYqBAswIneIHdY3vVLsf9ap1sFG88nOk1Tjd1FNVVQQW1Dhd2GJyMxsnosOikn1RlDgTd0iowP/ydyV0OvEzB/LG2JwPYiK8TBXE7+F+mugjfn4KD6n4bvLe6eZ2cnMjpQ6wVeZEPAOd6DGA1NDFQOnYLrSJZozDnNqm3ZLh5KZYLideBGCxOpj3fw7iBHj9B7ydWsJM2LZCxsukM/IHHsINexPvdjvDLpMQSniFRfB2t9IT7hdtSNQ4owNU1Ihhl1c7PiTIYNFD6rVZ9NDHEEkaeX6257GP4Hmi8S3mZtFOV7mC7jxubXJEGJmHFO3Xrzp0FI1vt7CmlkFFIXByg==
X-YMail-OSG: GppRZk4VM1lcKNeSUXCBUGMgyTrnA62D.PL7wG7XQeIO16UpV2VkETDwCBcPm9v
 OWYV6pCLhGqwYh9y5HUHRWFbE_pRO3yXH84LVG0p1ZJXu4cd1M38pyJNOQ3pR0q8NGMkJIJLF_hr
 64IxzKHYhKTq5wHUJsGMHZc.zOMHzuttjL30nYNNdStfNdtt7JySaMzB3uJBbNKNO_PMA_ZCGYPO
 lEg4IPhtRLwx4MGRp6yck._MuusQLe8wPv0fAUCvwEGipLKOXXrjWLOCqfQwpD0pj52kCPw898xb
 N4h6_lUCGfIci_4V3dCQAOE6kKduscRk3BfiKs.5XvvyCjxkFBsTfMJYOY417gztsDW2bKEXXVjI
 y3b01VtULIaBweMBZE.QJVldX1JYv8bnyLjR.Z0QvljfIfIerFgTwvgQO9NhgfYHbM9_GiE_Ltz4
 ZDF4pRxNvhTFQv5ClA3rdp71L2ZFZgJHEFCaWYe1uagZL995uyS8XsBMz2a6YWlIPuz3UlifxDE0
 Ix0GsfHh0lwSNLSoXF2IoqMApoCxIZa32VIa8k9c6Jwwfhl8kBtamFgtp0PxUyFCHTN30ZgwDTkg
 2JEQpuFbhocGinCEpMXf9IUhoORBbw7eDu5yO32fStWPINjENUf2tjV2Cr.22Md88p35QkfTPWlB
 gsCEEnG960f1TeIgbP3tQXA.8zPqANzlkSP.wtz3HE4lcSNemQ3KRQtbX2ORZxo5zhRjvFqOMQH0
 Fy2vuEYOxwaCSQjhebxeOB2ii_m5Ws_TiSsuyNorRn4xxyQxiHXeAcwByAATAet6SN3Em8L_ezl4
 NxX7dKYzTQ870wUZZsMWI_RSuVgPb.9AUS3DxyLRzBTs0hpk75GR0HYpXj_eCnR7fW1uITk3d_wc
 gg12tWv8ngNZbfDQo4Hjx7rPdvljOxuEcwsSCHme2wXy77o_rU4gXXfZpyEnNatg7BinpWtwKsDt
 xD5wpG1WPUN9CJFD81St3SEnhnXwX.I5hfQavLbOvvWH6ZPb4kIoiNqXfQyoWIli5Q.f3QGqcAzg
 0LibGOZgIpA.SI7Y7jF6O_0SHwXNkEsAC8tg4jz8k1GRF6CFhwWZdBiA.3d.fTQAfyOA2uwfPlpA
 AE4wE58cYdlAKDsTenfpzEJ5gF.i6UD3ZBS1tRC26nL3C0rc.5nu_C16aC.vtDEPpcu1u20fZpR7
 iiOCag3o6P5fyPOsACZTK5eAV.a8K1pd4gh7hZPZwgva5.y_0RxcbJKseCEqxsTuabtQDdFf1uE.
 ibjQpe5T7VwLNj.9QsAgzOB5h.D9vxiVil6m.QLUkubagDU14QpMVA6oi7seHG4POJuK.4hq19Ij
 DCLe5g.xbXQPOR4SsuAvywBo5MmkhUCSpiiO.o_2VKoE1tCN6lb23Kv4o7Bd5J6ZmXFI0SugvZ0x
 WXkPcKJREA_HOQyNoGL0ifImf6o6Q_j8YtszOwEkWIERgZxpLVfbmym6BihiPN0br7HjHCbZsaEx
 cCw1T1cZl23U.GdYt2V3MFmG2vGL0kDuGonit.vOf0U09P.5dyyi5VZhbw5.Gabv.N46N3wa5uu5
 s.hx49NHHcHlF4TjGflDn2p6UAAMpbF6JrYgUY3lS8UH7U0CA64XLJq8__QRUIg8Sc34VM1ETpDi
 HofB7r3b6twWny74vu9hc0zALkFCsDupFFO5cWdpoPky9Bq61YZF_ucZ.9KY1BmftBPGjSGNVHur
 o_ounwJorJvBFgp6pBN74Sr5MLfsMbZMz5ghx7HQWwS9YydJEpigNHByZK3NYooy7Ole9BOOm_Ok
 JQD.4W7QNhNvuydC2k40JDM8gW4mtHca_im6PwYVvqhvmpcdBOXsm3lyuSIW2WWLXnATKkTm5U4t
 ec71NL08M2dNmyU6K9bLcKLX8QKwyezPcMaK15ce47KdR5YTfRMzRaQlP3m4Btjaie5MxJKM03iG
 WHSzB57P69mrGyO8.d7oyKSpsw8kcsquMHBMM9Gixe_aZscjbBGpl_bXjDxPQfWGef__HnyVAKH9
 OEk9gUo_ls7amlzGlQ_TLbDgV0d54oMlKLu3hXVy.4g7gzvDpUWc36O2Zy1OYntDPyrpKhMc15Eh
 pvJGkSCRTJsDA9BY5clvA8tLfYCzySiV4hWBfT_yfnDzZZ0RczP2GqgsC25cX19VaaZaeyEmDbcq
 3pqa_E9rf.xzUrv.M5D090KX07Gp5x7WDtIoKxy6R65nLA3ai.1OXOwQTLLWJ3ykAHjK_9Z0RtHz
 gVNaHdA--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 2be6ad18-c3c1-4c4e-925f-89c4652d90b4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 May 2025 02:01:05 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d03aced6d3b859f668a0d0f42d96a57;
          Sat, 17 May 2025 02:00:59 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: skhan@linuxfoundation.org,
	bongsu.jeon@samsung.com,
	shuah@kernel.org
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: nci: Fix "Electrnoics" to "Electronics"
Date: Fri, 16 May 2025 18:59:37 -0700
Message-ID: <20250517020003.1159640-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250517020003.1159640-1-sumanth.gavini.ref@yahoo.com>

Fix misspelling reported by codespell

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 tools/testing/selftests/nci/nci_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 1562aa7d60b0..6dec59d64083 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 Samsung Electrnoics
+ * Copyright (C) 2021 Samsung Electronics
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  *
  * Test code for nci
-- 
2.43.0


