Return-Path: <linux-kselftest+bounces-6972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E6894D45
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 10:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6317B2831B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A2B3D552;
	Tue,  2 Apr 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQwcj2r0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF617C7C;
	Tue,  2 Apr 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045742; cv=none; b=kuKLGN5kXgSrvD7iyIERaFJ8OC20WCDkEjJce7LdjWMr6xxIgN0Xv+ziyUnnY3yzuCE+6S0WY4ykHD9qaUze85WEbNcs+jlOq/elzybucsbQT+Ato1ExYwZieleE5aomyvrIbzB7vo+scg4cygkXSDlSJHHonAkBPvgyn8XSO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045742; c=relaxed/simple;
	bh=3iZPnAPI66QzUGmJLEWma+5qsOXYgGLymnqizxhUAR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Kjqs8jfIYqqT665lokGz0NtC7ULe/VhnT+zzUfAWTy9zP//xk3u67Sw/rvyP0GnsfI3TuCB/e52URgpJTcDUNTEfB/7yXJ2zi4LM7NQeMy4V8qkiCQvCtGErOnpoVVwjOt6s1p3Z20USpOnz2XOGu1QzYqesWe9CG52UHwBczg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQwcj2r0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so60206161fa.0;
        Tue, 02 Apr 2024 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045739; x=1712650539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbyV4WUgAMKjf0Mlsuuxt1eYx/2JWso6ImFJm4FWdFU=;
        b=kQwcj2r0na1EoVFd1KNvNcWbeg3i1XtRVuHL9kmAbCFtlL2kxyCNiKtKM2KcA4Jjwd
         5G2hrsR/e8m1Qs+Pm0h8vE1Ltao5sAmLpp3jC4ya+cCSE50kRbSdFEdJINgjb4Urie3Y
         wRJY/RTyQgPMVRnyHrsg5/mktu/Z5wOsYd71w6oQ0gEQ3wUERUTW4+MxmMqRwqIhHGJX
         jgeHrgWSYlCxfmmUyG4uYW+ekkXkvnMlkRrDKbsZSalecUEkvFj+W4T9usuzm/zAp0D1
         2SZKG+DfgxNFnLuc+l4oet0J3Ppodl2wGBMoguhUIYeOpgUVHSoSNTGA47WmpOL2988R
         j5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045739; x=1712650539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbyV4WUgAMKjf0Mlsuuxt1eYx/2JWso6ImFJm4FWdFU=;
        b=eUXT3Q1zZpLgsuKoOODLfJzhbVZuVKaIu/t/fWUgkSEjHOnipvI+BaTYi0BkXb1T8f
         qHrvdqNri91WDEicy+dB3z9Vtd2nspGBoXo7zPn07Fy3zyNA25DsPoOnRZRib3xShp2m
         5dZUmYeVPxoQfYNQ1a0EADt9i4TgLbIjDdp6FCyfxYwkUKguIBWcKhYLF2UDOHYMeHsp
         dLkI8ynhhZxLI6tPwRlEEQHOFo6Qcc1LqWtNbFNaFRiixHDubquApxfOMlNdZEbi9+3X
         Cn1N2R89e4mNWONUCECDJBQPCJJdL9F9LxlLHDnAB+4sxeUQA2AuFRukOXTZ8w86Hvxq
         ye+w==
X-Forwarded-Encrypted: i=1; AJvYcCV71t1V9FARNnO9Q3AY4c/2BkcPAS9IQox2ha54+u9SDlKXux6Rx/Q51aPOhfpVIwSO9RtRIRf8SdMGSVwAqCLh+qV3Hwgs7CbdF2wjlugM/tiUa7zwg+0ebPFak68Yn3NyzeZVK/tM4SEN7yZy
X-Gm-Message-State: AOJu0Yy12MWsWfpczfMJdsEJzgQkpvsx++jyFilYri4BoakQZI68UliZ
	RfwkOKz0lLp93xB1gaK4iEcuxyBXOymVEg5+O0A2w7b1CEJZpufu1Q1LPSh7jR8=
X-Google-Smtp-Source: AGHT+IHgua8TBONeiwUcNe4bMHjogMUN1adTlj7GLKrCh1fzmOQ8fxahTuSchvLoKTrtDhg7d1ySrQ==
X-Received: by 2002:a05:651c:168c:b0:2d6:ba96:b9a8 with SMTP id bd12-20020a05651c168c00b002d6ba96b9a8mr6910192ljb.27.1712045738888;
        Tue, 02 Apr 2024 01:15:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm17295591wmq.3.2024.04.02.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:15:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftest/mm: Fix spelling mistake "skiped" -> "skipped"
Date: Tue,  2 Apr 2024 09:15:37 +0100
Message-Id: <20240402081537.1365939-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ksft_test_result_skip message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 2d277620fad2..db845dca8d19 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -502,7 +502,7 @@ static void test_child_ksm_err(int status)
 	else if (status == -2)
 		ksft_test_result_fail("Merge in child failed\n");
 	else if (status == -3)
-		ksft_test_result_skip("Merge in child skiped\n");
+		ksft_test_result_skip("Merge in child skipped\n");
 }
 
 /* Verify that prctl ksm flag is inherited. */
-- 
2.39.2


