Return-Path: <linux-kselftest+bounces-9891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12E8C173E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA502859AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534A14C5BF;
	Thu,  9 May 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikPWTFLf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549412AAE2
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285049; cv=none; b=TRTKjAnj8WvqQI6AF59TivUSa7NU186xsHXKwuOF389gNFQuHvVSWpbsXExj6+LJn1DIuEZJB0HT+WFl9bvc2nTl1kyCaZLTg6HJ3YlijIFtq2DCRrSiKfCIJo3YOAZrjc8m5fIpMy+Q2Hy+2L7bundG+ejAslS3Oz+Dg1ngfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285049; c=relaxed/simple;
	bh=lsXtuizLhZ+2u6FWrGdtvNuTtQC3hi372PcTiByEdNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqB6BILaNVNnscwHCPPX0nhfeq/C6dyo73wwnE7yM1W9dKOmXK8+6eu5wOIT2tNPlpYNt8VRMsXQANw5f9TA+/dDfY5006AVngGwGZqs1rjKAvp4nPIbY0Hjs2NV11JairGJjkDOqtrqFCN9g/X56G9hhU5O18/NeETte5x/x8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikPWTFLf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6efef492e79so1330312b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285046; x=1715889846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0otcg5Kc1nNe2NFGUPsfuJIN9yuuH8NW7LY5DKgrkM=;
        b=ikPWTFLfehW7leObcy3O6NE3i/Oh4gJBUhzWu9gdSLLB1igGQ48E7LG41RV9Fyp8tH
         F2itPIV7vSa6C5OT/cZOh5oAMjB1vng3Lf4dcDbFE2L/PiC86OyUgwkeLlwBb4Uvi4la
         VI2yJlMk/eQRQ9Ay9JYRSKJ2h24eJIyXcequ0Fa7Wkj/mDEHUirzIAu3Y6/S4LHwIsYS
         Ivg7b3TTl3cNv6UG2o1QE2FWOTpheWYA8KoBpO1rzCbT2EWmyl65bhQHiWL3iqd58k+n
         XoIScWS1Q6z0k5EZuFOvHp7AzSjNYZ5FP8guvou8dXsPHj1pVB0pEZyIpiSU44yr6qYm
         2GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285046; x=1715889846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0otcg5Kc1nNe2NFGUPsfuJIN9yuuH8NW7LY5DKgrkM=;
        b=uE2zMnCj0Mzpj/qyBzNC1caIrBeYo7OM4tTa+ST1hoWQNkXtm2OS9XqOvOOkdCQtcP
         Hgu6Y6MwZiMeFK6aWqW6BR0vEdj7nQSYOOGZreoLkxfbDEYqek3yMr2Yxve95mMRsqK2
         ZIcKL+e8vpBjCy1m7kNPsFbrWWbyl/PdpQ0KT5tURQo/qWlMYmuRQe4pqNiF/KfskhCy
         oxag07GemMtpmeFTLcPzPQpBeCrMAk4s7FkH01YqVqhrxrJYe72sqjWeeRs9wnz4w2qs
         4NI0kuDJEtLBzvhL8SZfuOk7TcRPktQWxmLalqrBHFlQ8ZZ3ZpgnG0VgiVJM/H6le3vK
         YNag==
X-Forwarded-Encrypted: i=1; AJvYcCVsLTbZptIa8CE38K1fBOpz9scAdF06cjA2S3w+H4wAuV3IXUkFNN8p0mmXkX6fP0IQvUXj9tlaeLwxyDK1co6u1K9EbIc2YZ6zxPkz6hYg
X-Gm-Message-State: AOJu0YxHFu4MtRLQW3f3EiBbYW6jb4rRjlGAA3t81ETjDvgF+u6X+SC8
	DMlNJdv+wcw4yIEcR+a7LagqAVJ0XyoQSxejNFKl6fHr+6zdze+tgloCuync8xzk2Uu5YyO5QoM
	L1g==
X-Google-Smtp-Source: AGHT+IHJWSxIWf7k9jnbwrAmheoAWG8ycVBs/La0GyeTAF4mCIcXMoq1cZGgpfURlks7BqOhLA9SGrNDEDQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:1144:b0:6f3:ecdc:1b94 with SMTP id
 d2e1a72fcca58-6f4e03a253amr15967b3a.6.1715285046407; Thu, 09 May 2024
 13:04:06 -0700 (PDT)
Date: Thu,  9 May 2024 19:59:00 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-69-edliaw@google.com>
Subject: [PATCH v3 68/68] selftests/x86: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Drop #define __USE_GNU too, as it is bad practice and the GNU extensions
aren't actually being used in test_FCMOV, etc. where it is being defined.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/x86/amx.c                     | 2 --
 tools/testing/selftests/x86/check_initial_reg_state.c | 3 ---
 tools/testing/selftests/x86/corrupt_xstate_header.c   | 3 ---
 tools/testing/selftests/x86/entry_from_vm86.c         | 3 ---
 tools/testing/selftests/x86/fsgsbase.c                | 2 --
 tools/testing/selftests/x86/fsgsbase_restore.c        | 2 --
 tools/testing/selftests/x86/ioperm.c                  | 2 --
 tools/testing/selftests/x86/iopl.c                    | 2 --
 tools/testing/selftests/x86/lam.c                     | 1 -
 tools/testing/selftests/x86/ldt_gdt.c                 | 2 --
 tools/testing/selftests/x86/mov_ss_trap.c             | 2 --
 tools/testing/selftests/x86/nx_stack.c                | 2 --
 tools/testing/selftests/x86/ptrace_syscall.c          | 2 --
 tools/testing/selftests/x86/sigaltstack.c             | 2 --
 tools/testing/selftests/x86/sigreturn.c               | 3 ---
 tools/testing/selftests/x86/single_step_syscall.c     | 3 ---
 tools/testing/selftests/x86/syscall_arg_fault.c       | 3 ---
 tools/testing/selftests/x86/syscall_numbering.c       | 3 ---
 tools/testing/selftests/x86/sysret_rip.c              | 3 ---
 tools/testing/selftests/x86/sysret_ss_attrs.c         | 3 ---
 tools/testing/selftests/x86/test_FCMOV.c              | 4 ----
 tools/testing/selftests/x86/test_FCOMI.c              | 4 ----
 tools/testing/selftests/x86/test_FISTTP.c             | 4 ----
 tools/testing/selftests/x86/test_mremap_vdso.c        | 1 -
 tools/testing/selftests/x86/test_shadow_stack.c       | 3 ---
 tools/testing/selftests/x86/test_syscall_vdso.c       | 4 ----
 tools/testing/selftests/x86/test_vsyscall.c           | 3 ---
 tools/testing/selftests/x86/unwind_vdso.c             | 3 ---
 tools/testing/selftests/x86/vdso_restorer.c           | 3 ---
 29 files changed, 77 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 95aad6d8849b..3259362a7117 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/x86/check_initial_reg_state.c b/tools/testing/selftests/x86/check_initial_reg_state.c
index 3bc95f3ed585..0129cdae8abe 100644
--- a/tools/testing/selftests/x86/check_initial_reg_state.c
+++ b/tools/testing/selftests/x86/check_initial_reg_state.c
@@ -3,9 +3,6 @@
  * check_initial_reg_state.c - check that execve sets the correct state
  * Copyright (c) 2014-2016 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 
 unsigned long ax, bx, cx, dx, si, di, bp, sp, flags;
diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index cf9ce8fbb656..d2c746149678 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -4,9 +4,6 @@
  *
  * Based on analysis and a test case from Thomas Gleixner.
  */
-
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index d1e919b0c1dc..9fa9d4a847ac 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -5,9 +5,6 @@
  *
  * This exercises a few paths that need to special-case vm86 mode.
  */
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <stdlib.h>
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 8c780cce941d..348134d2cefc 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -3,8 +3,6 @@
  * fsgsbase.c, an fsgsbase test
  * Copyright (c) 2014-2016 Andy Lutomirski
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
index 6fffadc51579..88dce47ab8e6 100644
--- a/tools/testing/selftests/x86/fsgsbase_restore.c
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -12,8 +12,6 @@
  *
  * This is not part of fsgsbase.c, because that test is 64-bit only.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
index 57ec5e99edb9..07b7c10f8d39 100644
--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -3,8 +3,6 @@
  * ioperm.c - Test case for ioperm(2)
  * Copyright (c) 2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/x86/iopl.c b/tools/testing/selftests/x86/iopl.c
index 7e3e09c1abac..baa691154905 100644
--- a/tools/testing/selftests/x86/iopl.c
+++ b/tools/testing/selftests/x86/iopl.c
@@ -3,8 +3,6 @@
  * iopl.c - Test case for a Linux on Xen 64-bit bug
  * Copyright (c) 2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..cbfb19d546fa 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 3a29346e1452..3b4237a85a12 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -3,8 +3,6 @@
  * ldt_gdt.c - Test cases for LDT and GDT access
  * Copyright (c) 2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
 #include <err.h>
 #include <stdio.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
index cc3de6ff9fba..47ecc63220b7 100644
--- a/tools/testing/selftests/x86/mov_ss_trap.c
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -19,8 +19,6 @@
  *
  * This should mostly cover CVE-2018-1087 and CVE-2018-8897.
  */
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <sys/ptrace.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/x86/nx_stack.c b/tools/testing/selftests/x86/nx_stack.c
index ea4a4e246879..97c5b34096cc 100644
--- a/tools/testing/selftests/x86/nx_stack.c
+++ b/tools/testing/selftests/x86/nx_stack.c
@@ -23,8 +23,6 @@
  * Regular stack is completely overwritten before testing.
  * Test doesn't exit SIGSEGV handler after first fault at INT3.
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
 #undef NDEBUG
 #include <assert.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 12aaa063196e..bdc81c8bd1a7 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <sys/ptrace.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index f689af75e979..7f41c3a4268b 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
-#define _GNU_SOURCE
 #include <signal.h>
 #include <stdio.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 5d7961a5f7f6..2054f729b2c2 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -24,9 +24,6 @@
  *
  * Do not run on outdated, unpatched kernels at risk of nasty crashes.
  */
-
-#define _GNU_SOURCE
-
 #include <sys/time.h>
 #include <time.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/x86/single_step_syscall.c b/tools/testing/selftests/x86/single_step_syscall.c
index 9a30f443e928..375f3b50a0b5 100644
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -9,9 +9,6 @@
  * immediately issues #DB from CPL 0.  This requires special handling in
  * the kernel.
  */
-
-#define _GNU_SOURCE
-
 #include <sys/time.h>
 #include <time.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 461fa41a4d02..10eee1bcd015 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -3,9 +3,6 @@
  * syscall_arg_fault.c - tests faults 32-bit fast syscall stack args
  * Copyright (c) 2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 991591718bb0..c72fc8aaa4d3 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -5,9 +5,6 @@
  *
  * Copyright (c) 2018 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d902..24bc219358a5 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -3,9 +3,6 @@
  * sigreturn.c - tests that x86 avoids Intel SYSRET pitfalls
  * Copyright (c) 2014-2016 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/x86/sysret_ss_attrs.c b/tools/testing/selftests/x86/sysret_ss_attrs.c
index 5f3d4fca440f..f8b9e0b2a0c5 100644
--- a/tools/testing/selftests/x86/sysret_ss_attrs.c
+++ b/tools/testing/selftests/x86/sysret_ss_attrs.c
@@ -7,9 +7,6 @@
  * the hidden attributes set to an unusable state.  Make sure the kernel
  * doesn't let this happen.
  */
-
-#define _GNU_SOURCE
-
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/x86/test_FCMOV.c b/tools/testing/selftests/x86/test_FCMOV.c
index 6b5036fbb735..0c9431ba7d31 100644
--- a/tools/testing/selftests/x86/test_FCMOV.c
+++ b/tools/testing/selftests/x86/test_FCMOV.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#undef _GNU_SOURCE
-#define _GNU_SOURCE 1
-#undef __USE_GNU
-#define __USE_GNU 1
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/test_FCOMI.c b/tools/testing/selftests/x86/test_FCOMI.c
index aec6692c6dcf..ba186665918d 100644
--- a/tools/testing/selftests/x86/test_FCOMI.c
+++ b/tools/testing/selftests/x86/test_FCOMI.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#undef _GNU_SOURCE
-#define _GNU_SOURCE 1
-#undef __USE_GNU
-#define __USE_GNU 1
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/test_FISTTP.c b/tools/testing/selftests/x86/test_FISTTP.c
index 09789c0ce3e9..95580cdaaa32 100644
--- a/tools/testing/selftests/x86/test_FISTTP.c
+++ b/tools/testing/selftests/x86/test_FISTTP.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#undef _GNU_SOURCE
-#define _GNU_SOURCE 1
-#undef __USE_GNU
-#define __USE_GNU 1
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..34f199b0d615 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -9,7 +9,6 @@
  * Can be built statically:
  * gcc -Os -Wall -static -m32 test_mremap_vdso.c
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index ee909a7927f9..ca1c13e89d8d 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -7,9 +7,6 @@
  * special glibc shadow stack support (longjmp(), swapcontext(), etc). Just
  * stick to the basics and hope the compiler doesn't do anything strange.
  */
-
-#define _GNU_SOURCE
-
 #include <sys/syscall.h>
 #include <asm/mman.h>
 #include <sys/mman.h>
diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
index 8965c311bd65..5cd13279bba5 100644
--- a/tools/testing/selftests/x86/test_syscall_vdso.c
+++ b/tools/testing/selftests/x86/test_syscall_vdso.c
@@ -8,10 +8,6 @@
  * Can be built statically:
  * gcc -Os -Wall -static -m32 test_syscall_vdso.c thunks_32.S
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE 1
-#undef __USE_GNU
-#define __USE_GNU 1
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index d4c8e8d79d38..8e879263412d 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <sys/time.h>
 #include <time.h>
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 4c311e1af4c7..754f5d4d425a 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -5,9 +5,6 @@
  *
  * This tests __kernel_vsyscall's unwind info.
  */
-
-#define _GNU_SOURCE
-
 #include <features.h>
 #include <stdio.h>
 
diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f2434155..8193de22a390 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -10,9 +10,6 @@
  * 64-bit userspace has never supported sa_restorer == NULL, so this is
  * 32-bit only.
  */
-
-#define _GNU_SOURCE
-
 #include <err.h>
 #include <stdio.h>
 #include <dlfcn.h>
-- 
2.45.0.118.g7fe29c98d7-goog


