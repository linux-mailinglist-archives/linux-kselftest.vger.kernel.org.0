Return-Path: <linux-kselftest+bounces-7508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B089E5B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F9B21A7F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0E158A2B;
	Tue,  9 Apr 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCSsPGAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DF433A6
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702582; cv=none; b=Y4KdcjKQFGYLYXXGJC8UAOnrykDuuc7vYG/zQxdzM1CLNI/yStm/7KJvambh567mtsECc1spTXyI2azf36D6vd+FPQJZJLcYs+HLcrXyfxXI3CVAk/SUvS/m/Hy9OxeQoGJpp3vyuNm025BoN5N1i/2U39VXgIGz/rtnHAjhaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702582; c=relaxed/simple;
	bh=EOPsmlwJFzGM2UI4dOfw8LD2YE7U8XKi3h9Rz8SnOGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlrhLgXQxiCo6sk/2xlhKLvM8lCsHPkcn1VLN4BLLhEVdGjtpleiM7fJlXNWoACrSo4UyiDI9QWwutqNtmqTYZOKh651ZEhsOIzZXKoFc0+i5cn0OmS/TVeUbZBE8YT1cl3A+iMwLwP83ws82MFWNjNrDLtefgGeKXf+iUd3O+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCSsPGAj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6167463c60cso70244607b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712702580; x=1713307380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvOU5J+d22A5HC2jQZ6Bg8Tqj0DfjFxuF6JsjQ8c2sA=;
        b=bCSsPGAj2sH3nm8iuc9uHWwxbeMLxKveiK608uUbrm/qgZRujlPVFzgM4hgJuVGy2o
         GWmWW4LMn/JLrJCBLaeYqmEuJ0Z2QXHLGnjGIUwMuGirgJ/j+N3kcVKBD324GELrDYvD
         rlpgmoXaCpqvFAodqxCgmVle1qwse+OXbHrCurV8QTnuSZekY+Pw8T9YX9RDry9DmE/m
         k81lJX2LI+PMjvYkegbybF5tav0mA3Mdui9yQC8JH6gbIxBOTltyggqJ3GY2FRuvWjGW
         1+cFWKkSldUox9uVW0/d7mul/6X10Vus7ISsbefgbxzAAekBm40QByEOeocGSuZwt9CZ
         JwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702580; x=1713307380;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvOU5J+d22A5HC2jQZ6Bg8Tqj0DfjFxuF6JsjQ8c2sA=;
        b=WJybJAxfcDmBpZCtnYJ6vgHZ7YDqLGl2aLQbbW5Et7rBk16gLPvt7PhanC7tqAobqU
         OkXO5rykVwaNIQTLaxpfIteqPVhOMerB6nmK6h8it+i2vOXUnptyrVEiLmm1zEAnnrNc
         bcXNAVR1bc00/ydgzYpCZfJ9KETSYkDADkUa+T8clxd/PFvSZs3Reb45SZze4ahIJRLM
         uD8dzBJgztm97r2tqDXWd7BxYj3m5e9l3CVYDOYGW+fsz57zUmvh4ay2hZmmwaCQ8KPb
         lyFrH1aJOVID9t4ggiryL8bueacUr5fz3FJTnunWDhTnXG1sgiFvoZ/c7UKWXmT15L37
         CSCA==
X-Gm-Message-State: AOJu0YxoFyldywxUjyf0fVeDsFc1ZkkBwpuYp8lGxCnD7VfITDPIVKME
	eRLONMPDUQgL8zpxzTBSEmeMnwoUvqAd5HOY7GIs9lwl59fvcmeU7n+2iyQIV101/Oz5eshy/7l
	32g==
X-Google-Smtp-Source: AGHT+IEG/dXsyx++mqFslFlSc76Kv14rRGbklYITWYGwB/A65qSHXmzSLYmI3ivC7yI9+fzybcMRqsjyIHQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a002:0:b0:614:2a7d:5ad3 with SMTP id
 x2-20020a81a002000000b006142a7d5ad3mr980648ywg.0.1712702579990; Tue, 09 Apr
 2024 15:42:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Apr 2024 15:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409224256.1581292-1-seanjc@google.com>
Subject: [PATCH] selftests: kselftest_harness: Print empty string, not empty
 fmt on PASS/FAIL
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When printing nothing for the diagnostic on PASS/FAIL, use a string format
with an empty string, not an empty format with a NULL parameter.  Clang
complains about the empty format string, which in turn breaks building
with -Werror.

../kselftest_harness.h:1205:30: error: format string is empty [-Werror,-Wformat-zero-length]
                              diagnostic ? "%s" : "", diagnostic);
                                                  ^~
Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
Cc: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..79ac9e9ada33 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1197,12 +1197,11 @@ void __run_test(struct __fixture_metadata *f,
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
 	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
-		diagnostic = NULL;
+		diagnostic = "";
 	else
 		diagnostic = "unknown";
 
-	ksft_test_result_code(t->exit_code, test_name,
-			      diagnostic ? "%s" : "", diagnostic);
+	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
 }
 
 static int test_harness_run(int argc, char **argv)

base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.44.0.478.gd926399ef9-goog


