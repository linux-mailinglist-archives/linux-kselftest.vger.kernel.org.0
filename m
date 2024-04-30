Return-Path: <linux-kselftest+bounces-9099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A268B6707
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 02:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854E41C22BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5B205E2C;
	Tue, 30 Apr 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaYb4yUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68599323D
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438166; cv=none; b=RCpA61whepzzUUMbH6Wq6blIWSbeey/nDYASHR5DSeLpA5BHcB171vT8I33geQHr24rv0xl1BqpfjNCaNFdkvd52DYCoyk6CbVdF9cVhLyG+/tLIrNNtyetZ4mGONECRlQIsjNiUJ3H8p6P0+rMqLxRi2Qgo8tsLrLoURA/SL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438166; c=relaxed/simple;
	bh=CQZ+rutb34tlCcqKjJD9BEd+5QtdQSwRC5IuvL3355o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qd2O7EelKsg5LMyP5SulqJpdRsGTg+nwHSNV1PtyCz7lQi4o0n0lFkJFmyyc3SQgHcxBpseUm9NJ1Phk8TaEh7/KhmR3eD4ial/O+gPKXXGITv6h2RN9nND76cWnhAwoRY/SES4Hd3Czg05kNFiyF+13k25qyEcJmuJXcLpTSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaYb4yUX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bd64c9eadso27576417b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714438164; x=1715042964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=GaYb4yUXbCmmbmZV6ysZZs3f85p6iLWfuWgI9fS5K2ZeZmCp4PxqsgegMZtVKPTZW+
         Yp87VNUXr2ekbURwSsyjeAYb0fxIDLY0jiOLbNjH8dPRFZ/WTKGF6/3I5Q/2xWeTYSXb
         EXQvwPHeIKgoqx4ADeEaf9NuFygAycrodBhZQ8Na55etqhDBb+tH7Ib7G67yct/saZUW
         Jytl5bsyBo1I+W8m5b/9LL0HTY74A9Xc6GwRT24tvpK3Sf+jgdbXzP3FjJkqwBhjw2vr
         29o6eQlK2J5ZXkejW4ZPAPu0zFcZbTOVoLGN+eDa1fL1r6VvEqHYsUfVTAUQcoUdh26u
         QdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438164; x=1715042964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1ppiacHBGt4deDldEbdpGFMwipyVa+kEjFesHxd+4M=;
        b=LSEcGIgMhe5Jp9HGl/c3WfjZSJPz6EvhDwbddQNz576l4hg9QoupxnAugKF9pJE6cT
         tk1ww95LiNuEGvZS0Yt7fL/zZb4N/19bczAR7CBj7HRDi9UYAwQdRNcNxYDPnNuqQCPv
         hvWdmWyygugEm3KqFYUP7iE+lkhENhjwqAu4BVhoVQk8C22Y4c1J1GvkXLqQ8Qj2ByXh
         /b8wIU+q3TmZZ1oItpcpa/8LfinStkSlD9Fa/g2I6ijr9i1IT8CY269LP+MEwYWV3qaD
         rONQuKp+xA7mrDG4IXzKIK1m1Rqic4QJ656VLYlE7h7i0dQ7aE2nqkYSOaaOVyAM54n7
         Yzbw==
X-Forwarded-Encrypted: i=1; AJvYcCUN/anM8aKzIwbdyCH9CDtIYPPhR1PtlJ2g7F/xjGVcejccTtQdOXWLNRSBpka54/0KkAbYQ+Z8cdfQ2P9ir93+GNiVXj4ojDafOjlWRNnP
X-Gm-Message-State: AOJu0YwJ4cH7uuL50uTL2CUSdmmT5fSuN/IFikKkdpnOUPC+XHswsdPf
	WPqcnYSWEVk+GKsgZtii7R0KVOEbe+KNNL5f1McNsVeBsiBI6bHuU2qXuQNQV5zQ6MXphhsv4Rv
	p6w==
X-Google-Smtp-Source: AGHT+IENnLlqrYtXCXtylGWiSBp8/4kI2FR3F2c3tGK00X6zJWwQq7PGDw9yYT+bwAFRgrPuE9Ry+c7gJvM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:20ca:b0:dc6:d233:ffdd with SMTP id
 dj10-20020a05690220ca00b00dc6d233ffddmr4176106ybb.0.1714438164494; Mon, 29
 Apr 2024 17:49:24 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:49:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430004909.425336-1-edliaw@google.com>
Subject: [PATCH] kselftest: Add a ksft_perror() helper
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


