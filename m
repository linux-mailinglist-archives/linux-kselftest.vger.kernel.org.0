Return-Path: <linux-kselftest+bounces-17568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E128972849
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 06:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A6D1C21673
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 04:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0813E02D;
	Tue, 10 Sep 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqYwfJCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4B4F218;
	Tue, 10 Sep 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942192; cv=none; b=uKmSeC0hOIwNgB30yCdmCB2Vzmy32I7dtfmQbcZ1Nyx0IiSEDWm6lfA6NgfpS7rEMBbT4BGbL/XKcF6SEjWtnQ1eA1oKCwPAMwcxdzcgvbAzxw0/AKaVdl2d8Z6gDqJzWKF8k7eMRgyIEdiXeEtyHS+5UENyD16UN+D9yDex+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942192; c=relaxed/simple;
	bh=vlw2z+zMCOSWZfPXqjgmrLHLdDcARE9vUY0Asa1BWBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qr9c9KOgPuks2ET4Elolt523YCr+bZrBtDK9eZOwJhZ43gVsICs3hwdzaVjOI9cx85f2gzoE6Iodr8ZMccwOYkYznM6G569Vc3f6/Xp9c7WmiimeiFFCuR3dIv4UMhzoff8VeTQ2UPgKNKqSvOSXOn27Rchm289gsqTSdkdV/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqYwfJCF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d704704aso302271b3a.3;
        Mon, 09 Sep 2024 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725942190; x=1726546990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zd2t+1Q+VsqsdwvP16Ht+eR5qAMW6t/6AxS6U9SFphk=;
        b=IqYwfJCFNGRg97he8yP0ndEviN6w1kyxLev0yjn/GqxvZTq57YFL9PV97LhB59rBjD
         tOSb0Y40YKGktOOURhXwZOdJYw52VrKKaInH0NOSRfFwSxvQkJhH91VpjQIdj02kelmn
         vLLzthO5/r3cu+eEuVqnyBYe5T5WKqZ1AS+rTsuZPyyB+5aBrm/MpYH22F1gL+eP3bJh
         +EccWi899QKAICfQiE9kT++WKUA6gGYlOIaRLKETSXk+8Hh6+FjD6km/AYGp6sz3Hn9j
         5gkaN/z1j/iobbtx4CRj3HwIuUFj1JqRFrNp06cCEl7GZOFd4PKffD97b2SdBlpVA6Iu
         oR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942190; x=1726546990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd2t+1Q+VsqsdwvP16Ht+eR5qAMW6t/6AxS6U9SFphk=;
        b=aPZSG0mEvp7+j7NkPlwx6lf/R390rAh0iih93AKNNEbOtongN+1ZUO5Uh4JRaTkaNU
         Zei3YhmoLLol1NhGiXuj2AECCw9UGpIh3VF23mizcuyt1sUOGhRHP+SqrigUcjz1tnta
         AksAdjm825FjOoXrHfrPm8VzV8zP/QF/KxnU2+2O7cCBOFEQHMRB7lr99Xeg6RsI3Dif
         HPnqgqqpNHb0AkDsjUuYRiGlOTejUt0o+aE8jXQ4Mo9M79VeidErs1+KASDnxOaeDxwS
         JVrdYqVxx3ohc/a4wbSH/V2tm1RyqJJ0FI2XMb1T6Sig7ODOWh+vvHRJQthHEDA9ThkA
         jKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAq4ettfoJ6FCeBNt8Umk6Kd+IOSrowm8vQUluDpkmLRI3J1N21CA3Asv44F0tkpO8L/VAB4affvt+PZrOxGV6@vger.kernel.org, AJvYcCV3U/ApYsUs+7OTPSLeXWu5cBhAK8VtQhvibD+SmqiOg58fvNf1A9l3vL0fhidAlGGX+uF4b8af9/sf1iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLfth+I0v7bDZApMSrnCpCmjgBgD9VgZ5qwoNarFkAS7zv8Fk
	PCgkGKdvHj0S3CUWq0Z4Y5uDSBBOtYlzFuP4Nr/qkGLnOGJKf9R+
X-Google-Smtp-Source: AGHT+IGSnxWeuRNGYssxJfeRvEFEPxPgqViau0O11iCDk1e/b0iDz+P9SBswKmV4/t4cYl3DNTZJeA==
X-Received: by 2002:a05:6a21:3a4a:b0:1ce:d08c:2c10 with SMTP id adf61e73a8af0-1cf2a0b79e7mr11783370637.28.1725942190196;
        Mon, 09 Sep 2024 21:23:10 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:8527:dba1:3ddd:e486])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fca6a1sm502970b3a.26.2024.09.09.21.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:23:09 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] list: test: Mending tests for list_cut_position()
Date: Tue, 10 Sep 2024 12:23:04 +0800
Message-ID: <20240910042304.67421-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mending test for list_cut_position*() for the missing check of integer
"i" after the second loop. The variable should be checked for second
time to make sure both lists after the cut operation are formed as
expected.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 lib/list-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..f59188fc2aca 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -404,10 +404,13 @@ static void list_test_list_cut_position(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 2);
 
+	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
 }
 
 static void list_test_list_cut_before(struct kunit *test)
@@ -432,10 +435,13 @@ static void list_test_list_cut_before(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 1);
 
+	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(i, 2);
 }
 
 static void list_test_list_splice(struct kunit *test)
-- 
2.43.0


