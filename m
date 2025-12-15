Return-Path: <linux-kselftest+bounces-47577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A11CBD154
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA846306D59A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4F331A75;
	Mon, 15 Dec 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKXDGl3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97056331A67
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788471; cv=none; b=ThC+Y4+o9eADehrh78mmXAc0hR31VTBqkSKFFowE92rTKye1fL+UZFWnCue6H3bx9vcMCE7NLxNRW4Zzc3J6cfHXR+C3EXjFBo3y2gLpdIoELs8o/tiwUnbuRceziiBJABDfbMMDXJMr7oENU2ZX/0DF86lIp9ZFD7L0+gU2o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788471; c=relaxed/simple;
	bh=ntbk0Qg64mB+eRdow45mqcltJofKTd87yIfqFj6CdOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bquKCwu5u0MVVYwQK94znCNGvmRHAMlTCuqE4IIDfSjNyvgSndnidnPgP6fpAVIP9SZbJqtMT5yEJi5ay6fxYhC41JAW6nFVSysIf/tIjsvVsSOxy4ARtGrMnqvNJgbcSUiMekd1V8zmI6El+A0FHHBOe0pHNkWMhPGFZLFwNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKXDGl3U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d0788adaso8112575ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788466; x=1766393266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPjuXZ4/6Ll8iE3Rz28AaFI0svhctDC7vgBQffR8h0U=;
        b=DKXDGl3ULK1MRRz7LvDLYS2QLxz25vmPAD+Oau0Dfs2njPIN9vPSoLtAkaXLx8kCeY
         4cxtgtdCfXiPYaNpohD4P0FYO0Z+GCozgTzeRWY5MiN925srmWukHzQM6BeJEU/Bbl27
         RLIIO+B/9gqeFht6PiNRu/EUTHodyAam8rIyKUO8VctuzZRK73sl2PmOwuvPuKYSAlcx
         k2PUF2n/7LdASaLfwW0KiYIwa5kKcP5PpkhdH4f6eOwA50NN1Aev9XjR5jOd4trH7u9e
         LDjg6Wriu+gkPN42/YQN0yyK0u+phxsXg+5d47LLEjVaUeGcPtz4RaI2V0rQgWPai2EI
         gduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788466; x=1766393266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPjuXZ4/6Ll8iE3Rz28AaFI0svhctDC7vgBQffR8h0U=;
        b=gotg0h+WjO/HLfQ5wxkwr/bFRuP+CNOzmm7l85QSVjCfZsFkNtkhp4b1q3rutdeluw
         0Koi6G7VkmB5dFoL3yyMRKykcueqEcPme8efPL94IRwA48rwWygjRVVYVm9HH56zwkfN
         KoahbwDhA5gPZ9EHjRZ3wOeQwu4yR46iMp8w1HyKGIW78pPhbLj9ODYhTcCDjATi/NOb
         7HLpVHx09Vshu95mKrDvIsJzNA8m9hjVT2fXl/hifuJhH7Ryq598ar+2GQZU8vAqh4n2
         Xgqoa2V0GZ9Mq4cK6kizQcUTbrea+JCGKf/3S0jgvYkIBHcXZoL1+3wE9qd8YnC8V6P2
         A9Ng==
X-Gm-Message-State: AOJu0YwxhHSG9KqxtE93swqr0HDtT2C5EPy0HECTHHC5L9VeobaKemkR
	Z78sHF6eQ7gZLZ8HYIFSpfnzOKGtG2Uz7c8RWdR0IYD86YY4r3HmTHNi
X-Gm-Gg: AY/fxX6EVvdEWNoJGzUllYc8tjsjzn2K+B/yX+qk09IhdkS/U8YwZ8MlM3LSVvZoa+i
	8//aS64Ln/9ckOmx56oBkM2rOv/HgDyOtqxf1woRz+WBva1Pq++nDsDzR7hNgGYbcHDOzWb+wq7
	aAwUOICfhYeKhnWfEmuPAFkRnLB6SscZBxFCiRk4mGMM4VJfwo1+SGCdVqvk0dos3PKgV4dxhKp
	ZyfdhZZfCyGkJz4dpXg+v6YOZLJNsV8rr+GcdHJDWHaK/G2gCNLNlIoT4NuYJ9WPXE+/tY8Yjy/
	iLm8lpMK3wniKVS4mEFBO77/BApqy4NUw+bEFHXXDZe4Lk9cn6zuyUkwiwFVk34Wsqrq0wE+MId
	x1G4JKqZH1KFNKuCKPA0ramOxXGuP3M1Y9cLBNFpqEJzdKPmvZVXu346XSRa9I1khSpQ7rPwjkA
	AQag3AJQdk0WpUxSUp8XqsoG2uxUlzcYko93M=
X-Google-Smtp-Source: AGHT+IEPumXAp9HZLmoAIfnYbxYk6w+/T3dU7w+yjiyvqFmWqDIigTjRbVkztYzivR4UDHXsX7nkpA==
X-Received: by 2002:a17:903:1109:b0:295:a1a5:bb0f with SMTP id d9443c01a7336-29f23e1e3f4mr96736705ad.18.1765788465873;
        Mon, 15 Dec 2025 00:47:45 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.180.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06b49csm127573265ad.95.2025.12.15.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:47:45 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] kselftest/coredump: use __builtin_trap() instead of null pointer
Date: Mon, 15 Dec 2025 14:17:37 +0530
Message-ID: <20251215084737.7504-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __builtin_trap() to truly crash the program instead of dereferencing
null pointer which may be optimized by the compiler preventing the crash
from occurring

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

Let me know if any more testing is needed to be done


[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/coredump$ make LLVM=1 W=1
  CC       stackdump_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.
  CC       coredump_socket_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.
  CC       coredump_socket_protocol_test
coredump_test_helpers.c:59:6: warning: indirection of non-volatile null pointer will be deleted, not trap [-Wnull-dereference]
   59 |         i = *(int *)NULL;
      |             ^~~~~~~~~~~~
coredump_test_helpers.c:59:6: note: consider using __builtin_trap() or qualifying pointer with 'volatile'
1 warning generated.


 tools/testing/selftests/coredump/coredump_test_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index a6f6d5f2a..5c8adee63 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -56,7 +56,7 @@ void crashing_child(void)
 		pthread_create(&thread, NULL, do_nothing, NULL);
 
 	/* crash on purpose */
-	i = *(int *)NULL;
+	__builtin_trap();
 }
 
 int create_detached_tmpfs(void)
-- 
2.43.0


