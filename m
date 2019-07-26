Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42C76EE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2019 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGZQWc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jul 2019 12:22:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46069 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfGZQWc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jul 2019 12:22:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so28718311plp.12
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2019 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tjhcSRmIRXUILRS/jy/QiJdV3Z5E1s7xQzD5RJUqH7Q=;
        b=UO4hLjUItbB6ULBWQOmwqIJJ0t3923sVzDDDeStO7mSA/Bh+vF+0trnk/xlQZkqI5C
         iwYyPjMiVPlMRR5k+6Hrq87bXuZjU3ZDHWJSBrvBn0Ez1BWq6Rc9z0Ys3mLzmdFxg25y
         duGoe/AzBtiUob6yFfepgE9R9RJ0LITqZpkSpPt8YAfB2ZPGq1tjefoHVcNcwUqg9l7U
         Od5f5FjeOMOVeX5z4wWU8swRAndpFG7hfnKGzp/yOUAzC3sBjyITLPaYlUI8uUTOnwDt
         LV6seuE0PvYIcvQJkpR7uceH3Xr9cOOomgV23HvZjLFmQZdHjT0AMWLagTetoWDrTUxC
         OKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tjhcSRmIRXUILRS/jy/QiJdV3Z5E1s7xQzD5RJUqH7Q=;
        b=tZpI19Prfs1bRzqHOIFQqNh710XPof/DK0U2Dq2g53e2xXxt473KWS+ZD8ynUnwmg3
         IkNYdEO7tAqwx3nhkHKigVUvaBV0956o11btm+iE4LRf4LxsbZ626ZCQppd5WGXRZ16W
         fbwMQoAxzEIovBiqAq6JaKv8+Q5kBzAXeQ5MkzN5i9AaWk4kx09bsNtZIyc/kx3SJiXM
         +h2HC52ZzvKgCvCJ+ZvIhyX4tBxgdY8E7JBH6X7TftJO9bZF0fDmBbdFqKU1lI+hyc3h
         tLvwPviDGBiWAXm+14JIChNT+9sxgEzR8CjE1h+vgvm/YaTFV+B2JUmZ+FGuuiQW9wqM
         EMEg==
X-Gm-Message-State: APjAAAVh0aACsCL30tgnjBi9PVtHrPgHkux6KjBHyaWFlHa21VOMU+Wc
        SzbNVRvUAfTBxf9kqujXLa/t1W01Ur0=
X-Google-Smtp-Source: APXvYqwRGZjimDoN0Ifg4KsikRTFzC8uTbFRXzYuLY+8ZFeCLXhnSEodDmSJP55fWDQxYndQvdCSxD1e+sQ=
X-Received: by 2002:a65:4808:: with SMTP id h8mr91147086pgs.22.1564158150843;
 Fri, 26 Jul 2019 09:22:30 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:22:25 -0700
Message-Id: <20190726162226.252750-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 1/2] tests: move common definitions and functions into pidfd.h
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move definitions and functions used across different pidfd tests into
pidfd.h header.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Christian Brauner <christian@brauner.io>
---
Changes since v1 (https://lore.kernel.org/linux-kselftest/20190723173907.196488-1-surenb@google.com)
	- Move common test definitions and functions into pidfd.h as per Christian Brauner
	- Code cleanup and additional error handling as per Christian Brauner
Changes since v2 (https://lore.kernel.org/linux-kselftest/20190725002204.185225-2-surenb@google.com)
	- Added waitpid to prevent zombies as per Yann Droneaud

Patches are based on v5.3-rc1 in Linus' tree.
---
 tools/testing/selftests/pidfd/pidfd.h          | 18 ++++++++++++++++++
 .../testing/selftests/pidfd/pidfd_open_test.c  |  5 -----
 tools/testing/selftests/pidfd/pidfd_test.c     | 10 ----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 8452e910463f..db4377af6be7 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,14 @@
 
 #include "../kselftest.h"
 
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open -1
+#endif
+
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal -1
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -53,5 +61,15 @@ int wait_for_pid(pid_t pid)
 	return WEXITSTATUS(status);
 }
 
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
 
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 0377133dd6dc..b9fe75fc3e51 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -22,11 +22,6 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(__NR_pidfd_open, pid, flags);
-}
-
 static int safe_int(const char *numstr, int *converted)
 {
 	char *err = NULL;
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7eaa8a3de262..17b2fd621726 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -21,10 +21,6 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-#ifndef __NR_pidfd_send_signal
-#define __NR_pidfd_send_signal -1
-#endif
-
 #define str(s) _str(s)
 #define _str(s) #s
 #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
@@ -47,12 +43,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-					unsigned int flags)
-{
-	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
-- 
2.22.0.709.g102302147b-goog

