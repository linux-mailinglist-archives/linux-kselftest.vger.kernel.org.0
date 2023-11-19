Return-Path: <linux-kselftest+bounces-270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D017F0421
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 03:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E58280E78
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F615C5;
	Sun, 19 Nov 2023 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V++0N8cB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54844A4;
	Sat, 18 Nov 2023 18:57:39 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d13ac2796so5924676d6.2;
        Sat, 18 Nov 2023 18:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700362657; x=1700967457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZtE1sXq/6EOMIXLdRyz9i4gTsfOOa5vBqb4CxOsnD8=;
        b=V++0N8cBkqnG+bWLtWvKUKM2WZDDIANkWYzYC1c2ov3Z2f84wiYYYOL368Z5LMKr2W
         KOICjtT55KjN+bF1/8EYNactywg1PDDl7LKVk/hG+8vWhCJzCVVmiAKwMFhXVGbjalg+
         j+sWUwPlNyvOjpS1dpaH3o8I0XeP4bteHsziHh/WTOi0tYrW2Ea98aLMC/LVgjAvjrx3
         +q+3U8jA/FlHp46PvIO9zsLXXgCLkq4JvV/aipDGFN9R5ARxnVRlA0jykf7NNseR8pcI
         qq+mWLiXRA4S6EakZis4LgTNlbNj3sXYlWqbzHRwjezc7U8MLpqndvWjpZtKzqhdH7+g
         QOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700362657; x=1700967457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZtE1sXq/6EOMIXLdRyz9i4gTsfOOa5vBqb4CxOsnD8=;
        b=mXoZ+ZQUtyYgylizQ3xZ2jwXJODhB2UPaQ3UYGaCgItq4devTutsud6pQLM/QCyZZD
         K6qCMKHANiJCja5HJ9Lawq01RjlvxJRaz/VqGLGXnI/UsO3+lBlNTJx9j18hr6KyOo00
         i8vf978EsaG5lIEPCcNpSvlL37/jInbXROz1Zioh+CHDNiBTdVTohmFkQ24vW5NJfIct
         E8LqK5sL07+fJSL5fh5bXsOLyuGtKNmIjIWNSkrRzJ2mSwtMmwGcpjICr2QlzVmpsdyt
         fxej0NGQ6+V7T+DrRbAc40wa7BqXa17P4ZVmjVhcaWUhA8FRyj98qKeM8UApcQeX+xuy
         kbOg==
X-Gm-Message-State: AOJu0Yzu6n1Q+PgBnvQhnCk0UsGpCaOTrAGY1htpfq7QM+YpOAbk+FbH
	MR9MIjWZZY7SCohpM+ksARsDHkza/H8ee3cD
X-Google-Smtp-Source: AGHT+IGsCz7CzJEySl9vTXD9oR675mUX+GIN+013Sa73Md7ITvqJ85j1quqU97PyP/rhWDv6giTJKg==
X-Received: by 2002:ad4:5f08:0:b0:677:f79a:17f0 with SMTP id fo8-20020ad45f08000000b00677f79a17f0mr5498448qvb.25.1700362657542;
        Sat, 18 Nov 2023 18:57:37 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id v6-20020a0ccd86000000b0065b0771f2edsm1831981qvm.136.2023.11.18.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 18:57:37 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	shuah@kernal.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] [PATCH,breakpoints] selftests/breakpoints: Fix format specifier in ksft_print_msg in step_after_suspend_test.c
Date: Sat, 18 Nov 2023 20:57:31 -0600
Message-Id: <20231119025731.38846-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

In the function 'tools/testing/selftests/breakpoints/run_test' within step_after_suspend_test.c, the ksft_print_msg function call incorrectly used '$s' as a format specifier. This commit corrects this typo to use the proper '%s' format specifier, ensuring the error message from waitpid() is correctly displayed.

The issue manifested as a compilation warning (too many arguments for format [-Wformat-extra-args]), potentially obscuring actual runtime errors and complicating debugging processes.

This fix enhances the clarity of error messages during test failures and ensures compliance with standard C format string conventions.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 2cf6f10ab..b8703c499 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -89,7 +89,7 @@ int run_test(int cpu)
 
 	wpid = waitpid(pid, &status, __WALL);
 	if (wpid != pid) {
-		ksft_print_msg("waitpid() failed: $s\n", strerror(errno));
+		ksft_print_msg("waitpid() failed: %s\n", strerror(errno));
 		return KSFT_FAIL;
 	}
 	if (WIFEXITED(status)) {
-- 
2.39.2


