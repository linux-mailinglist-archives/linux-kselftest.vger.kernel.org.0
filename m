Return-Path: <linux-kselftest+bounces-9101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165A8B6726
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C8283692
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FB10E4;
	Tue, 30 Apr 2024 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIUnrvPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD51113
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439193; cv=none; b=ZwX78JNYSyg3FTDl+FR1DGBsZJNeX6FrUZdY8iaBxs9uRi/mliha1SuNuLGOsx5d0Ca/QnvCP5FielAQmEF9Z66ZKKHLl4FsEbj7wP8KDxPFrYeEy5tNz5a08lygthsZcfhNjx3feTr2Rj+3qbkFUQ2lcG4EJWDVE4IuR07HfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439193; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YHdBvaoR77kmEYhTNXBDS9WRr3mp7lhdu9vuh/WY3DCNoQHIoYl83HWPcnfFnz4HVcI+b/sJljEpwCsTEf4ObIc2s+6lYtQjR/JD1pNu6IXzV5DmrFIY1c5q3Q5MTIQFGSsOFm5JIqSFqLL2tRq4bnRkbbmODbSVb5QT4vB/KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIUnrvPu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-60361c6fa70so5076841a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439192; x=1715043992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=pIUnrvPu19HKo6KofwgjMrtkwNpbkF3GtTZC7LSI0Om2iqrAKRwaSaKeS6iw3h9UMV
         ZdMho5vD2PhzadZJAxpE6ayXw1XlXLRsMNaxMSlGjHUfExHrEeg2fHjwScmIDonSCXH5
         uhEydjFRqeuauhJZV2SZWAPL+tLh/TDI3sj8Oe0fbCy+wN5eQeciKbcvhhLBX20/q8Fz
         OGa03/tm23pzRyVtNSL2kJtBf5nReYZMmgMw5j5TZZbGKEwaMYS6Lb2SIW+JIWjT/TzY
         zNkIIM1KBvItOnmFkiYt64OsREUPs9D9bXObKwV394b6NiRULc5/huPoCimnwff1BUUv
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439192; x=1715043992;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=stEN0UKl3wTXt2V68KHiu5OpUcWI0t9rAE/bod3vOEeJBEqKX2PtePNAe+S+aQUwLr
         Hc4b7/W/wX0LOmuXu7Svz9O/y31z3XUcN1ZVURdn7dZISzgSTYTVb/3y/vXS2vziS/rI
         D/ztltAm6Loc+Md5D09qK3mt4PKiulqlYfRHKkZXi3xeriVP8lKP3O5V+kcTM/dddLpZ
         iPjrHeCN7NpL/OppEeG3kWTXl2FStNXgfoBR87L7mB+B6tXY0rdphL9NV/UEscb1XbRJ
         O1VFJprnm61pFqLo7BGWr9Xb4Ou89wT8zR86WVIB0iTBiNsLtkeeoKmSvkMdEJgIQDm7
         8c+g==
X-Forwarded-Encrypted: i=1; AJvYcCWApJNv++aDfnXfvaI8+EWlV/h6NoBPoWG/Jf5AfFCT4izXjN3nN6xPjVl3sjt/RfySBfhmCQIrHMPp7l/7C4JpA4VusFGo4ox935IO0eGw
X-Gm-Message-State: AOJu0YwAJozH0GEOFHD6y5Z2kRHHCOtWBlGZB3gYuoffUm4lV0dweu98
	vZSejtasSYvJyqyD/bBtl1cFsKkHqR60aFS5hQfdmAnVzVORZQZITDPUQfuk/xt20CRN7kRyxtD
	Jvg==
X-Google-Smtp-Source: AGHT+IH3du7DU4SSas1waSsGTfaKPkaIxmUOV3AAlzhPD+DO0cmHY4Fhz82mZzN9VrX9rQfmrW+YUUXg57Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:33c4:0:b0:60a:869f:3a6c with SMTP id
 z187-20020a6333c4000000b0060a869f3a6cmr2542pgz.5.1714439191602; Mon, 29 Apr
 2024 18:06:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 01:06:27 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430010628.430427-1-edliaw@google.com>
Subject: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
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
2.44.0.769.g3c40516874-goog


