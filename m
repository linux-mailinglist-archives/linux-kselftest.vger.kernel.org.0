Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070321E10C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 21:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGMT5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 15:57:40 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:41756 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMT5j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 15:57:39 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 58DA3BC0C2;
        Mon, 13 Jul 2020 19:57:35 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     shuah@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ravi.bangoria@linux.ibm.com, broonie@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] selftests: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 21:57:29 +0200
Message-Id: <20200713195729.37666-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 tools/testing/selftests/futex/include/atomic.h        | 2 +-
 tools/testing/selftests/futex/include/futextest.h     | 2 +-
 tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c | 2 +-
 tools/testing/selftests/vDSO/parse_vdso.c             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/include/atomic.h b/tools/testing/selftests/futex/include/atomic.h
index 428bcd921bb5..23703ecfcd68 100644
--- a/tools/testing/selftests/futex/include/atomic.h
+++ b/tools/testing/selftests/futex/include/atomic.h
@@ -5,7 +5,7 @@
  *
  * DESCRIPTION
  *      GCC atomic builtin wrappers
- *      http://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Atomic-Builtins.html
+ *      https://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Atomic-Builtins.html
  *
  * AUTHOR
  *      Darren Hart <dvhart@linux.intel.com>
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..2a210c482f7b 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -211,7 +211,7 @@ futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
  * @newval:	The new value to try and assign the futex
  *
  * Implement cmpxchg using gcc atomic builtins.
- * http://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Atomic-Builtins.html
+ * https://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Atomic-Builtins.html
  *
  * Return the old futex value.
  */
diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index c1f324afdbf3..946c52e1f327 100644
--- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
@@ -12,7 +12,7 @@
  * times. Then check the output count from perf is as expected.
  *
  * Based on:
- *   http://ozlabs.org/~anton/junkcode/perf_events_example1.c
+ *   https://ozlabs.org/~anton/junkcode/perf_events_example1.c
  *
  * Copyright (C) 2018 Michael Neuling, IBM Corporation.
  */
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..3413fc00c835 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -5,7 +5,7 @@
  * This code is meant to be linked in to various programs that run on Linux.
  * As such, it is available with as few restrictions as possible.  This file
  * is licensed under the Creative Commons Zero License, version 1.0,
- * available at http://creativecommons.org/publicdomain/zero/1.0/legalcode
+ * available at https://creativecommons.org/publicdomain/zero/1.0/legalcode
  *
  * The vDSO is a regular ELF DSO that the kernel maps into user space when
  * it starts a program.  It works equally well in statically and dynamically
-- 
2.27.0

