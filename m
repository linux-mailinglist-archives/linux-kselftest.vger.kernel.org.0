Return-Path: <linux-kselftest+bounces-12162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C228290DA36
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F81B1F23A97
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E013E8BE;
	Tue, 18 Jun 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up4vogZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85A13B7AF;
	Tue, 18 Jun 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730226; cv=none; b=U6Bk/8m2bJ3uA3j/UN8oFXvnJngXRCXNoHtTRw+jGE18LT/mu8mUwBCEC55ijQwup1dHb8QWZsC1in2bcVbxUL4nEwFvkJIzMiyGOVs4/GywZrjbuByUf9FfS7NbU53CN8WxwW6745u4/Gx0KdXGUjBGokJymj6yzGLi4u10Evc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730226; c=relaxed/simple;
	bh=CtGaNkTL/9amFsgyYKl9SxuviYHI3HseYRI/Q1bDLQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZZHW+CB4LhUyKhmlGLLYmrqK9PSfaI7AfQ7qqH8eit/vgiXLZQa/1RaMsvJIWvSWq6/iDqJ7C0s+8BMKdCLyj284qbrEmqTqGf6evhdmlfJpszmlueQvZt5fntrOCGJMSeJ4iZtcVAHMFW2ZDFzK6h97sjaJzjfxdtbwr85ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up4vogZ2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so5347505e9.1;
        Tue, 18 Jun 2024 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730223; x=1719335023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7cfNBOfuFJPSZY7IxUtOnUVCtTCdHPOx1EZyVWIQQ4=;
        b=Up4vogZ2FqpA32o6lCTIh7UuSS09dt6tmH6xjzI28hmYnSB7r9lF2ySoo0ieuzwMbh
         wGIlUSfl4W4cpOEOX4NR4sqZbelaBJBWlDm6+LHj4uJ6Gr25d9ovKQ37BiD8Pcf7MK+J
         0GorNe7pUdgG5RyyqqC0Heegno/AzuUrp22/ySlUPw/yBECgyUiajm6bLvULg0Tzu7HJ
         u9HxjdtFhpghMRTwGceE4EUKqLjsn8bF1ofCLl5tqZ3f2RVa9eHhhLzJfhVas3jErdJU
         UxWOvZtWivZhwagaSK9mqRVy9590FhbmW01gSjDo+Xale5IC2YF53ZLcoz9YNSd6t7po
         ACSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730223; x=1719335023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7cfNBOfuFJPSZY7IxUtOnUVCtTCdHPOx1EZyVWIQQ4=;
        b=DcWUzAYJ4XRCTNL/JPvPgk5i8+qnz0dPlVGBnGuRqgYvbNAprRhuNG4W/akS39Jtu7
         yluOg7P2/JhAo+8+Nr9M0M56aQDEc+ZSYtRsJUhP+0s8/ZUdcxlk86fQgR9draH3+uwv
         I1AEEQYSSgKcr4t6pOKgOdpL2lOma02WdJ/0H468r72N3LQXpXuhUb0zSX2gpfuFm+8+
         NfZCnC1AsXaZOWqe8GV/Gu1q/Il7gbcbMqlutt1wD3bacrFz6PIlzjyJugpwZuwJUlhF
         97SqfyN0CRGOK6YT8ug/zk/3RJIsxd9blY0zOLZ0CDscZhFJpjghecgO1rYduNM6dWAO
         mt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhu2McohiFwOUIWk4fjIMQXAfngwEsMjoPFiIjg+nTpRJh6HZDCKmVlsjjz5Rrz8cNBRrWh7rig4DvaAutmOdAChYTbRnHLFI0zZ3z+9RPyjkNWd4rVlJcRChY4ptBaCvc6HoTSRgf29IqOkT8
X-Gm-Message-State: AOJu0Yw3caTAW86jr67gDSekkD3egVH+iU0coopWP2TuSuJehlDw0w7G
	b8FdVRa70/iN6fQ+aFkQwLq7wAgV/FCo6ssS+ngkvPnr4V5SzldV
X-Google-Smtp-Source: AGHT+IHSMLp1ejoXYFvbDmZ/tMgLQxuH5E/0V9ZZ9Cx5lTPM8Oqiwqw8KmNzCNk0wx2k87O3wkUBXA==
X-Received: by 2002:a05:600c:1d26:b0:421:67db:f251 with SMTP id 5b1f17b1804b1-4247516f320mr708285e9.1.1718730222918;
        Tue, 18 Jun 2024 10:03:42 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:42 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 2/5] kunit: kunit-test: Remove stub for log tests
Date: Tue, 18 Jun 2024 18:03:28 +0100
Message-Id: <20240618170331.264851-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since now we are exporting string-stream functions into the KUnit
namespace, we can safely use them in kunit-test when it is compiled as
a module as well. So, remove the stubs used when kunit-test is compiled
as a module. Import the KUnit namespace in the test.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes

 lib/kunit/kunit-test.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 37e02be1e710..d86f7cb3b3e4 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -577,12 +577,6 @@ static struct kunit_suite kunit_resource_test_suite = {
 	.test_cases = kunit_resource_test_cases,
 };
 
-/*
- * Log tests call string_stream functions, which aren't exported. So only
- * build this code if this test is built-in.
- */
-#if IS_BUILTIN(CONFIG_KUNIT_TEST)
-
 /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
 KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
 
@@ -637,17 +631,6 @@ static void kunit_log_newline_test(struct kunit *test)
 		kunit_skip(test, "only useful when debugfs is enabled");
 	}
 }
-#else
-static void kunit_log_test(struct kunit *test)
-{
-	kunit_skip(test, "Log tests only run when built-in");
-}
-
-static void kunit_log_newline_test(struct kunit *test)
-{
-	kunit_skip(test, "Log tests only run when built-in");
-}
-#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
 
 static struct kunit_case kunit_log_test_cases[] = {
 	KUNIT_CASE(kunit_log_test),
@@ -872,4 +855,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_fault_test_suite);
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


