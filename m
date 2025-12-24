Return-Path: <linux-kselftest+bounces-47950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A975CDBB0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA4E3009FD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8932A3FE;
	Wed, 24 Dec 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ5ep3wV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175A32ED2D
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766565693; cv=none; b=aP6eM+gXw+iQU8C1bgDGgeh5rpxMgP2kZxuRakeF+TSRTHD0ZsMPg8oqMJhuPuHUv8L5AD2lvsiJ/jd0yLQKBtdX7XvyAyOljqokxDX5KW0zXPpC1Aj54iOM5m849fLt7h8WMxXs5kMJWfqVbpo/3zl6iRgQmnVsUoxG8XWGDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766565693; c=relaxed/simple;
	bh=b9azLrvng1W+owOZrrSCG2h1ZMWVw5Gr5XMFi74WAM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uLLl8to7xdDCERQ7GW3vhX4PiFtw/M4UAnL6kiUCaNXHwYW9AnF/V+NJ7Opr+1lRcts0jxL5oS5HsVqNb92rtFalE/UF1rq5er7o8GS56ebiSIBVhI1DOpe+Mrusqo8vRR6Vbfcw+PCnkITAzgoFqxb37/lssDRNOQLERk9YmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ5ep3wV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0bae9acd4so54411135ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766565691; x=1767170491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8kS3dI32T4iLMQTgoo/uaduNvix6IC7/fsObmlhneA=;
        b=pQ5ep3wVfk1TrgXMj9F7XkgQcm9Up/0Xqf90pGo3X6YK7oW99zLO1qaxolzxnAViRE
         8g5shygaZJF1EcsddL85GCLOMPqap8uPd1U21D8xf5VK/KPMzfBUQf+CO8ZXmuMvY7u+
         fdBBepH2Syl8Y8RbT9EU7slEOLibIEgWCYuZLoEgoBZXn3EOO51rqw6bmWbFPBDI4J5J
         S93tZ3AhXKSOgzaFvGpNs/9cLZTzkc6HRfp0w0LF8YrHUonWkR0KN0+GJVyPhYuVM+8R
         q8mE75Dr/Kn2hpgp2XnAvLmXY7n2R6K+ohvtYy7ujGnzcvAKMMwozuPOwq+pQxWxAyqA
         w9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766565691; x=1767170491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8kS3dI32T4iLMQTgoo/uaduNvix6IC7/fsObmlhneA=;
        b=mg0isJivi5n7YyisaouNtArbkwVG0Phx8fTdBKCYaNjd2V9N+6n8A+tCl2I6uQwZK2
         CaLi7r4CpFmMuvgcjJCNO/f92wYB9Z7OGpB1XcNM/Vu3Jjev+hYu+xGVOrYXoLe1hQF3
         DQEFOev0o1sei77MV9Mx6B/orNPkXUpXsd7HMYPkyogVJLe+uO3BTy/4IXXaN8P76ZWo
         YnJUPMBk2gPY1fXTwAvziiGVnFSBXl+PKW0IJx1nWRGyYbDZqhgrJ3Hr3z9wqZWa0KLq
         jt7NYEsFh/0bdxYeZOZLxMx7pKs6McdupO8wM/v/IO+fJWjAg2ov71qEb1SG5s9I8jzR
         Lgrg==
X-Forwarded-Encrypted: i=1; AJvYcCV/nWVvX2LiVAxpjXh8YRBypUrG6zMM5NMrWFh31CK+Wx+i8AN1bKkWSgyDFij3xNbncrkyR71sGsxWhuYElV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRW9DEbBP7lerP+X8EpCCtq/AKZOsEsVV8a+CECOaKTkgSk0gG
	9zYB40WrCdMA4DdDJ5Ssa5EZdX/SpwDgee1Wz7MTICQ9zWvDVcSRp7Svo3Zy2e/GA6kUUSMXEkM
	tqw==
X-Google-Smtp-Source: AGHT+IEyqeTMoaShXNRUvtHOhlYNvGlKrvndvLDnIj+Cloeh6LxSFejF5eSTr8OUrR3lJf2+Y5Rv2yfKdg==
X-Received: from pjbei18.prod.google.com ([2002:a17:90a:e552:b0:343:af64:f654])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54b:b0:2a2:d2e8:9f25
 with SMTP id d9443c01a7336-2a2f28368eamr173738215ad.33.1766565691337; Wed, 24
 Dec 2025 00:41:31 -0800 (PST)
Date: Wed, 24 Dec 2025 16:41:20 +0800
In-Reply-To: <871plslxsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <871plslxsw.ffs@tglx>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251224084120.249417-1-wakel@google.com>
Subject: [PATCH] kselftest/harness: Use helper to avoid zero-size memset warning
From: Wake Liu <wakel@google.com>
To: tglx@linutronix.de, kees@kernel.org, shuah@kernel.org, nathan@kernel.org
Cc: luto@amacapital.net, wad@chromium.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

When building kselftests with a toolchain that enables source
fortification (e.g., Android's build environment, which uses
-D_FORTIFY_SOURCE=3), a build failure occurs in tests that use an
empty FIXTURE().

The root cause is that an empty fixture struct results in
`sizeof(self_private)` evaluating to 0. The compiler's fortification
checks then detect the `memset()` call with a compile-time constant size
of 0, issuing a `-Wuser-defined-warnings` which is promoted to an error
by `-Werror`.

An initial attempt to guard the call with `if (sizeof(self_private) > 0)`
was insufficient. The compiler's static analysis is aggressive enough
to flag the `memset(..., 0)` pattern before evaluating the conditional,
thus still triggering the error.

To resolve this robustly, this change introduces a `static inline`
helper function, `__kselftest_memset_safe()`. This function wraps the
size check and the `memset()` call. By replacing the direct `memset()`
in the `__TEST_F_IMPL` macro with a call to this helper, we create an
abstraction boundary. This prevents the compiler's static analyzer from
"seeing" the problematic pattern at the macro expansion site, resolving
the build failure.

Build Context:
Compiler: Android (14488419, +pgo, +bolt, +lto, +mlgo, based on r584948) clang version 22.0.0 (https://android.googlesource.com/toolchain/llvm-project 2d65e4108033380e6fe8e08b1f1826cd2bfb0c99)
Relevant Options: -O2 -Wall -Werror -D_FORTIFY_SOURCE=3 -target i686-linux-android10000

Test: m kselftest_futex_futex_requeue_pi

Change-Id: If4fdfe6ffcbe9736fbd8f66b2453e8cbbb95e25e
Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 3f66e862e83eb..159cd6729af33 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -70,6 +70,12 @@
 
 #include "kselftest.h"
 
+static inline void __kselftest_memset_safe(void *s, int c, size_t n)
+{
+	if (n > 0)
+		memset(s, c, n);
+}
+
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
@@ -416,7 +422,7 @@
 				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
 					MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
 			} else { \
-				memset(&self_private, 0, sizeof(self_private)); \
+				__kselftest_memset_safe(&self_private, 0, sizeof(self_private)); \
 				self = &self_private; \
 			} \
 		} \
-- 
2.52.0.351.gbe84eed79e-goog


