Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D374118957F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 07:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCRGAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Mar 2020 02:00:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRGAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Mar 2020 02:00:37 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jERkp-0004y5-Ml
        for linux-kselftest@vger.kernel.org; Wed, 18 Mar 2020 06:00:35 +0000
Received: by mail-pj1-f71.google.com with SMTP id l5so1364898pjr.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Mar 2020 23:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b0/tNNqegNvmzJPE8xlSwvL87jSpyw10AJbcYVQwQMg=;
        b=EJXdwIErRWKeXPqie4T7KsLeK7lsBu2yrtjpuaL7tOGVKXUxhh9mjYPhP1MXdb0xXq
         /yBwWgAMqdjLOPiKxgqiDKBxKYgQZzzXZNlqGfgdq3v6mWGiTbjHPYRpXwctb6tsnApa
         AAbr7ULmP533zoCsm7wNYfhDqqkj7dadiT3J/JSpE0qE+Vimf0yrasG14QnxD5fM6uJs
         sjjB9V08kHVgKe/onaZDsIE+ylWDCSMoCWVIr7ZMDCwtNtC+van3AUO3nD5w0p/WQGT3
         7qoF3XTXbiFipwWSNiNg3AF+FxvGVusNS0F6928BVxFZRnY4dh2g6g0Bna/1prSZoPpA
         /+fA==
X-Gm-Message-State: ANhLgQ018EgrP8LEeGh5b9XS2TwyyJsn+VijP8CxK8B748XdIEVmv6PE
        5KZYXzrMfPRAl2EtMfMIW6xFJDkO2XvntEdJ1VfFuYSwZlW1/5dkEjWnSfQEBhIdGI0V3oUwsNS
        pwvnnpRthgL51j+Q8a7QkQM9CgZsJkX4Xcq7oc7pg66Ra
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr2341856plr.106.1584511233912;
        Tue, 17 Mar 2020 23:00:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvVGczB2g1SGGZP1BmZR4xDWO4bLplF3TV1wHlLRgWCjvk6SPk4YN9+wtndPUrGsBimOgK+w==
X-Received: by 2002:a17:902:b088:: with SMTP id p8mr2341818plr.106.1584511233560;
        Tue, 17 Mar 2020 23:00:33 -0700 (PDT)
Received: from localhost.localdomain (114-136-162-243.emome-ip.hinet.net. [114.136.162.243])
        by smtp.gmail.com with ESMTPSA id 5sm5081619pfw.98.2020.03.17.23.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 23:00:32 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCHv2] selftests/powerpc: Turn off timeout setting for benchmarks, dscr, signal, tm
Date:   Wed, 18 Mar 2020 14:00:04 +0800
Message-Id: <20200318060004.10685-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some specific tests in powerpc can take longer than the default 45
seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
Add 45 second timeout per test") to run, the following test result was
collected across 2 Power8 nodes and 1 Power9 node in our pool:
  powerpc/benchmarks/futex_bench - 52s
  powerpc/dscr/dscr_sysfs_test - 116s
  powerpc/signal/signal_fuzzer - 88s
  powerpc/tm/tm_unavailable_test - 168s
  powerpc/tm/tm-poison - 240s

Thus they will fail with TIMEOUT error. Disable the timeout setting
for these sub-tests to allow them finish properly.

https://bugs.launchpad.net/bugs/1864642
Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/benchmarks/Makefile | 2 ++
 tools/testing/selftests/powerpc/benchmarks/settings | 1 +
 tools/testing/selftests/powerpc/dscr/Makefile       | 2 ++
 tools/testing/selftests/powerpc/dscr/settings       | 1 +
 tools/testing/selftests/powerpc/signal/Makefile     | 2 ++
 tools/testing/selftests/powerpc/signal/settings     | 1 +
 tools/testing/selftests/powerpc/tm/Makefile         | 2 ++
 tools/testing/selftests/powerpc/tm/settings         | 1 +
 8 files changed, 12 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/settings
 create mode 100644 tools/testing/selftests/powerpc/dscr/settings
 create mode 100644 tools/testing/selftests/powerpc/signal/settings
 create mode 100644 tools/testing/selftests/powerpc/tm/settings

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index d40300a..a32a6ab 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -2,6 +2,8 @@
 TEST_GEN_PROGS := gettimeofday context_switch fork mmap_bench futex_bench null_syscall
 TEST_GEN_FILES := exec_target
 
+TEST_FILES := settings
+
 CFLAGS += -O2
 
 top_srcdir = ../../../../..
diff --git a/tools/testing/selftests/powerpc/benchmarks/settings b/tools/testing/selftests/powerpc/benchmarks/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index 5df4763..cfa6eed 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -3,6 +3,8 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
 	      dscr_inherit_test dscr_inherit_exec_test dscr_sysfs_test	\
 	      dscr_sysfs_thread_test
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/dscr/settings b/tools/testing/selftests/powerpc/dscr/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index 113838f..153fafc 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -5,6 +5,8 @@ CFLAGS += -maltivec
 $(OUTPUT)/signal_tm: CFLAGS += -mhtm
 $(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/signal/settings b/tools/testing/selftests/powerpc/signal/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index b15a1a3..7b99d09 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -7,6 +7,8 @@ TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
 	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt \
 	tm-signal-context-force-tm tm-poison
 
+TEST_FILES := settings
+
 top_srcdir = ../../../../..
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/tm/settings b/tools/testing/selftests/powerpc/tm/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4
