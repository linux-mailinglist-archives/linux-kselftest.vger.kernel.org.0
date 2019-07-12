Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9292A674F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGLSHa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 14:07:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33647 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLSHa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 14:07:30 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so22341462iog.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2019 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=zH/cR8qCLeWj8t0FBhVbxcO4aJ7y3OVxP3p9IqD3n44=;
        b=OcAgL43vwXMOo9mz3V/4FGNRuLu5rMz1RRZr1F3y6J3ZrhyssyeAYUUlchox78lG/p
         I8ggHkHBQ7Jyf1jpR23uQHEYE7A9MA0EQxE0q6DfTKLEM5z6qHe/FdY6ydaDI6cdq3kL
         cPSbxfpIxvLZaKhjixw3wFOwjvjkoy1aSrPz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=zH/cR8qCLeWj8t0FBhVbxcO4aJ7y3OVxP3p9IqD3n44=;
        b=KHgM0rwKZ3hWZSS1E0Ia6znPdb1H2/b3lXgGmKLbN1V25x7C5011QTJFHq1SgiOvBD
         py5XAppCCQgNCHH137VAcvo5MgbHBAWy2Xk9u8vWkXqWGlZ2txN/XBtCqvFsAgSOkjmu
         pc3ey+J3VdLAXRES6/IPjaj/+Y4jYtTVJOJxsPIeQg5Wa0IgEZeeQcfwGenMwMg0CEQq
         b/4IwJZxVQslHi47y6OFH14qFdj125Dq6gvFr29UcIpeTP1W+1GvX+wA06OYsrk1aoH2
         x1FIx9KKmyYIz4GKub1G0TQClTVb4PTrJC9KUrPivmQm88uf/ReQ0/0QAKPyaai0QMeF
         cJpQ==
X-Gm-Message-State: APjAAAWlqr+OPpayiDTLtHaXgZuxtJlBFyw8H75g0os5vo2FDo3L8+BP
        949Bdbzw1klkTu9Es4pTYuXaEA==
X-Google-Smtp-Source: APXvYqx0s+GNPXQQ4lN4heBRdaxgBr6Iq6YxmULre9kE0B9zl2kdgGJBqAPxIeaYOoWBxD82ouhjxA==
X-Received: by 2002:a6b:dc17:: with SMTP id s23mr8747778ioc.56.1562954848960;
        Fri, 12 Jul 2019 11:07:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h18sm7398924iob.80.2019.07.12.11.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 11:07:28 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.3-rc1
Message-ID: <c5cd56e2-26ab-650b-581d-b3030ab31be4@linuxfoundation.org>
Date:   Fri, 12 Jul 2019 12:07:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FCC4C6504BD95ED355FF1705"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------FCC4C6504BD95ED355FF1705
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.3-rc1.

This Kselftest update for Linux 5.3-rc1 consists of build failure
fixes and minor code cleaning patch to remove duplicate headers.

diff is attached.
thanks,
-- Shuah


----------------------------------------------------------------

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

   Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.3-rc1

for you to fetch changes up to ee8a84c60bcc1f1615bd9cb3edfe501e26cdc85b:

   rseq/selftests: Fix Thumb mode build failure on arm32 (2019-07-08 
13:00:41 -0600)

----------------------------------------------------------------
linux-kselftest-5.3-rc1

This Kselftest update for Linux 5.3-rc1 consists of build failure
fixes and minor code cleaning patch to remove duplicate headers.

----------------------------------------------------------------
Mathieu Desnoyers (1):
       rseq/selftests: Fix Thumb mode build failure on arm32

Naresh Kamboju (1):
       selftests: dma-buf: Adding kernel config fragment CONFIG_UDMABUF=y

Shuah Khan (1):
       selftests: timestamping: Fix SIOCGSTAMP undeclared build failure

YueHaibing (1):
       kselftests: cgroup: remove duplicated include from test_freezer.c

  tools/testing/selftests/cgroup/test_freezer.c      |  1 -
  tools/testing/selftests/drivers/dma-buf/config     |  1 +
  .../networking/timestamping/timestamping.c         |  9 +---
  tools/testing/selftests/rseq/rseq-arm.h            | 61 
++++++++++++----------
  4 files changed, 35 insertions(+), 37 deletions(-)
  create mode 100644 tools/testing/selftests/drivers/dma-buf/config

----------------------------------------------------------------

--------------FCC4C6504BD95ED355FF1705
Content-Type: text/x-patch;
 name="linux-kselftest-5.3-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.3-rc1.diff"

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 2bfddb6d6d3b..8219a30853d2 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -11,7 +11,6 @@
 #include <stdlib.h>
 #include <sys/inotify.h>
 #include <string.h>
-#include <sys/types.h>
 #include <sys/wait.h>
 
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/drivers/dma-buf/config b/tools/testing/selftests/drivers/dma-buf/config
new file mode 100644
index 000000000000..d708515cff1b
--- /dev/null
+++ b/tools/testing/selftests/drivers/dma-buf/config
@@ -0,0 +1 @@
+CONFIG_UDMABUF=y
diff --git a/tools/testing/selftests/networking/timestamping/timestamping.c b/tools/testing/selftests/networking/timestamping/timestamping.c
index 0fbed67bf4f6..aca3491174a1 100644
--- a/tools/testing/selftests/networking/timestamping/timestamping.c
+++ b/tools/testing/selftests/networking/timestamping/timestamping.c
@@ -32,6 +32,7 @@
 #include <asm/types.h>
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
+#include <linux/sockios.h>
 
 #ifndef SO_TIMESTAMPING
 # define SO_TIMESTAMPING         37
@@ -42,14 +43,6 @@
 # define SO_TIMESTAMPNS 35
 #endif
 
-#ifndef SIOCGSTAMPNS
-# define SIOCGSTAMPNS 0x8907
-#endif
-
-#ifndef SIOCSHWTSTAMP
-# define SIOCSHWTSTAMP 0x89b0
-#endif
-
 static void usage(const char *error)
 {
 	if (error)
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 84f28f147fb6..5943c816c07c 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -6,6 +6,8 @@
  */
 
 /*
+ * - ARM little endian
+ *
  * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
  * value 0x5de3. This traps if user-space reaches this instruction by mistake,
  * and the uncommon operand ensures the kernel does not move the instruction
@@ -22,36 +24,40 @@
  * def3        udf    #243      ; 0xf3
  * e7f5        b.n    <7f5>
  *
- * pre-ARMv6 big endian code:
- * e7f5        b.n    <7f5>
- * def3        udf    #243      ; 0xf3
+ * - ARMv6+ big endian (BE8):
  *
  * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
- * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
- * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
- * (which match), so there is no need to reverse the endianness of the data
- * representation of the signature. However, the choice between BE32 and BE8
- * is done by the linker, so we cannot know whether code and data endianness
- * will be mixed before the linker is invoked.
+ * code and big-endian data. The data value of the signature needs to have its
+ * byte order reversed to generate the trap instruction:
+ *
+ * Data: 0xf3def5e7
+ *
+ * Translates to this A32 instruction pattern:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * Translates to this T16 instruction pattern:
+ *
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * - Prior to ARMv6 big endian (BE32):
+ *
+ * Prior to ARMv6, -mbig-endian generates big-endian code and data
+ * (which match), so the endianness of the data representation of the
+ * signature should not be reversed. However, the choice between BE32
+ * and BE8 is done by the linker, so we cannot know whether code and
+ * data endianness will be mixed before the linker is invoked. So rather
+ * than try to play tricks with the linker, the rseq signature is simply
+ * data (not a trap instruction) prior to ARMv6 on big endian. This is
+ * why the signature is expressed as data (.word) rather than as
+ * instruction (.inst) in assembler.
  */
 
-#define RSEQ_SIG_CODE	0xe7f5def3
-
-#ifndef __ASSEMBLER__
-
-#define RSEQ_SIG_DATA							\
-	({								\
-		int sig;						\
-		asm volatile ("b 2f\n\t"				\
-			      "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
-			      "2:\n\t"					\
-			      "ldr %[sig], 1b\n\t"			\
-			      : [sig] "=r" (sig));			\
-		sig;							\
-	})
-
-#define RSEQ_SIG	RSEQ_SIG_DATA
-
+#ifdef __ARMEB__
+#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+) */
+#else
+#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
 #endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -125,8 +131,7 @@ do {									\
 		__rseq_str(table_label) ":\n\t"				\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
-		".arm\n\t"						\
-		".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"		\
+		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
 		"b %l[" __rseq_str(abort_label) "]\n\t"

--------------FCC4C6504BD95ED355FF1705--
