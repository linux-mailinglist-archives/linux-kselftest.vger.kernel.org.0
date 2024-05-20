Return-Path: <linux-kselftest+bounces-10445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804448CA196
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44005282433
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBF137C21;
	Mon, 20 May 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhfZTKji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAB34CDE
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227801; cv=none; b=hGEArAua7Ujbqq/UEmtytijk86uAbOjmCuA0UXOwbWi31TSf3iXijf4kHTYVtZ1mJrA6EysNd25NGHPi9GoE6T0lIu3NLfEEm6QsXczKkK7JZ5rZHYUBL/9PWNQcI5WwT/78XKOg5CsRxwJ7Ypm3NrwUbbB1mjL5grh6FVDkobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227801; c=relaxed/simple;
	bh=hh63JzVkq3RFqwduAXD7nF+C9C+KYPzdxNLZnuAzF64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lRaWPCirmJlDaUqC0am9Mc9Gyl8hGKbmnQ5vvKK1ezIHv79uryO2F696uiYh1kckyLcU66SXfj8yCGSuyK9o5jEHg8ychM/nFycmpr0kBmE8BcygoJn448Hkuxi5XUshFjCPg9DT9hftIqxICB/t4YGGZ9Hhev5I5wFIaoJ0xjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhfZTKji; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec5ce555f6so119783515ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716227799; x=1716832599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBM9TYW+bx0dFVR3I0872jrLR5NKUzwrIIEe5tnLaNs=;
        b=vhfZTKji9pvOGcNf4p+ePouAmwdPP4+lRYZQoJkuO+CPIa0v2XQxWdK1Tfb3utSQv2
         PotqQ7FFZAit5bjFPQhimyRtOk6YIaUyxMCFrGkTl3g7PY1BxlunaWMztsmvkLW6eBhs
         dGbjuzczB3YfyG36mBtIGx7dT0Q64HOVgINcIUeIwQfD8DL/kMyuCCKen7Igu7/MbFIj
         +P2yl9lqW3qytcOhc9qJTpGOcIWx8SSvVeMTMCzRUoZQ+ds+8T5AukrTnTDJeaCuMoY3
         PuBJMPkrxmCVs6tKB8dUUIazGY46rBX5wCy4Cs+9i3t+N+a3H3c6HpZuffk7ny0e0R2N
         RASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227799; x=1716832599;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBM9TYW+bx0dFVR3I0872jrLR5NKUzwrIIEe5tnLaNs=;
        b=qwILJo4/s5yVmAqq9j/LHM8EnrL29iE9+OM1kfdEwVYQAn0DeFbuRGltnzCoRrvLaa
         lQNIglX22vlYH9DpY9QyTs9EyFt5R2BasSPO9EOO3cMgsDCyD9gG0cRG0dYiRc5exTPK
         +/PvaZZjjG7ZZTBYez+Rno19W5J3QsE6fPsZWq1bMm1amXQMw936kz+ROrIJRQKffiVy
         3cakgCxwwDzhjzFP28Y0rv/vsPKJo27Ctuj0yKTq0CqH3QNiA9Ruhm8TdcsT+XgZ042J
         z+aphMBQCxz9u+fb51+2Veh/NEPNckSLasu7XPNov1+pAgUlzAzCx8kpSmEJLpRbhx14
         x2JA==
X-Forwarded-Encrypted: i=1; AJvYcCUQBomZB1ammc39oKxjA/DRkKzReyUT5y82RvRqnl6Dva+IKiQkNwhHmT+p5xbq1+Y5VyTnM4AFjSuAPTfQBgV9c5pyVeI4WhwCzivLHMNO
X-Gm-Message-State: AOJu0YwhP9IiIqcwUhVidM85ImRpYDtaYylN+mUKufKpWbOxb9YGmeJl
	2UzmjFGz/jD+nZ5cyLMs819fuZ44pGe6fBLDKv32RM6zXjJZ6LEqJQnYU7/47krQ+eQgQ95NwPa
	WJA==
X-Google-Smtp-Source: AGHT+IGj95gLCpyblFJ+pwIY+HiJCy20O8Y2ZVsTP33S8ecicT9VG4slD5xQlkr5v4v8OD/7ntCEuybKbio=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f547:b0:1f3:665:9041 with SMTP id
 d9443c01a7336-1f306659434mr2255965ad.0.1716227799032; Mon, 20 May 2024
 10:56:39 -0700 (PDT)
Date: Mon, 20 May 2024 17:56:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240520175629.162697-1-edliaw@google.com>
Subject: [PATCH RESEND 6.6.y] kselftest: Add a ksft_perror() helper
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]

The standard library perror() function provides a convenient way to print
an error message based on the current errno but this doesn't play nicely
with KTAP output. Provide a helper which does an equivalent thing in a KTAP
compatible format.

nolibc doesn't have a strerror() and adding the table of strings required
doesn't seem like a good fit for what it's trying to do so when we're using
that only print the errno.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers test to generate KTAP output")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index e8eecbc83a60..ad7b97e16f37 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -48,6 +48,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
 #endif
@@ -156,6 +157,19 @@ static inline void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_perror(const char *msg)
+{
+#ifndef NOLIBC
+	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+#else
+	/*
+	 * nolibc doesn't provide strerror() and it seems
+	 * inappropriate to add one, just print the errno.
+	 */
+	ksft_print_msg("%s: %d)\n", msg, errno);
+#endif
+}
+
 static inline void ksft_test_result_pass(const char *msg, ...)
 {
 	int saved_errno = errno;
-- 
2.45.0.215.g3402c0e53f-goog


