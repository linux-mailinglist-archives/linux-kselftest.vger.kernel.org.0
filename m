Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D48179117
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgCDNQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 08:16:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbgCDNQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 08:16:08 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j9Tsb-0007Mc-KU
        for linux-kselftest@vger.kernel.org; Wed, 04 Mar 2020 13:16:05 +0000
Received: by mail-pl1-f197.google.com with SMTP id w11so934609plp.22
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 05:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FoiB6hzDhu7zhsE/qqdlngAwyG5TADZ8ljLTza6EBz0=;
        b=Jnu4jcusB5+0CuEEVTIE2hRAOQeHypXMnW6rxfR0JxA980BKmaiYRbY9EE11iJKjBJ
         1F8f73uHfqbQckgwA/1ixvRMCP2oKgI2zpOIap6hv5Lb230fmKlyof8LMpuc2dp930c1
         ph3km8PZzOKpvcGHaC+1QeGABIjThwVGVpMB+b/qLrkETSBoQ2eTGyaiOZMSMi0d7FqF
         AQlaqzRe4zUSpZGjJkSxx3TRnQvhfnKWorDfLu5WDuTKS7o1FTWGWJM77/4bXxIR7Nhd
         rQoTCXgeX1dzyKXnKWcxyGp5Jiuf5+7G0qgdNwivvhYTQDgHXTF7bkoBiUcMnoPNLsVt
         sxrg==
X-Gm-Message-State: ANhLgQ30MZPQOE0SoKu7lZhzuLULVbFm2qp58gAngPFes+qwdz3VSGvf
        nfRbPcJZGsPMTz/U7Ifi0NzVArKoDqAlXubS7+IQPS/i+wcKA3AcEia+75u4S6OTI4G2lVbladX
        mUiV5yiNKFA2A9T3VXJKhqNTie07Au1jeondttiTSV9Q1
X-Received: by 2002:a17:902:d90f:: with SMTP id c15mr3056606plz.190.1583327763908;
        Wed, 04 Mar 2020 05:16:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvK4uTGiKzjtuDXnV1Gfy92QDaS45ZMs1S30Dw1XFtBScjRpPMHg0ViyThdR/UnPOLJjZ/fzQ==
X-Received: by 2002:a17:902:d90f:: with SMTP id c15mr3056579plz.190.1583327763544;
        Wed, 04 Mar 2020 05:16:03 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id a143sm3394286pfd.108.2020.03.04.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 05:16:02 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCH] selftests/powerpc: Turn off timeout setting for benchmarks, dscr, signal, tm
Date:   Wed,  4 Mar 2020 21:15:53 +0800
Message-Id: <20200304131553.27582-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some specific tests in powerpc can take longer than the default 45
seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
Add 45 second timeout per test) to run, the following test result was
collected across 2 Power8 nodes and 1 Power9 node in our pool:
  powerpc/benchmarks/futex_bench - 52s
  powerpc/dscr/dscr_sysfs_test - 116s
  powerpc/signal/signal_fuzzer - 88s
  powerpc/tm/tm_unavailable_test - 168s
  powerpc/tm/tm-poison - 240s

Thus they will fail with TIMEOUT error. Disable the timeout setting
for these sub-tests to allow them finish properly.

https://bugs.launchpad.net/bugs/1864642
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

