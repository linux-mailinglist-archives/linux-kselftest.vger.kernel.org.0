Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42B16528F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 23:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBSWd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 17:33:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37789 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgBSWd5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 17:33:57 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so2445253ioc.4
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=3WH4sH3qXfwAjdTN8MsLrGU6BPBsh8QW0D+6WZ3tOh8=;
        b=Ll95HVHWiMHdEmcbAGKKsK6EYO5885Qz7yat7axULxDcR8Bmzck8E8EIdMKNN2eL0j
         Lajk0H6Xy1wp58NsptXfrf9wZbjRrjaviQGtjZ1IhAopAu1Iz6ddROf9VnGryRa2SCos
         vx+b+M9VcDSo/le0vGQiyjOk9TrrqwynzahFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=3WH4sH3qXfwAjdTN8MsLrGU6BPBsh8QW0D+6WZ3tOh8=;
        b=JjRsoaLLzEzx0P/cqwfbvoC/IVjGhHQpZ02NepnXinFhhFBdkWVUidaQQUXKfHcWjL
         qUPYj4tQsvwjwcHMUoMZvhRagRfacCcE7fwNh+H7ltHQTS5FPCSozd0DwvhQMnhR2AjT
         GODr4xglbJDR+1iEO2Ny6wdimhJXgsKvhxnGmBQHziEDWkLPN2qFTU5iIfBI2hgcujDH
         /zf8k49X/e7Sav0tSXJNlpA3wLZBTx0mOK/LU3hIGEBaoeI2ynbssY1uEJiiVh1+MmRN
         OkmKWCUDMaLRA0YSvd544klHHPtDDcsteTqF7rSsOThbfADmli926XssMt5v+EB6gEOI
         ckQA==
X-Gm-Message-State: APjAAAXbY281bpTx1MJc13x1O8t6EoHWXP5VEF55WJ14Ipy3h88fiJ5n
        eh/OOe2uxJLGhtDVUWKNl37lV8RNZo0=
X-Google-Smtp-Source: APXvYqwuPgqyxng1Ttjy7iI+0lcZjieLUgwnLpa9LHed/M0Ip6a3uxSK6TARCRfgKQLjfm2z5WSxPw==
X-Received: by 2002:a02:cc59:: with SMTP id i25mr22046907jaq.78.1582151633541;
        Wed, 19 Feb 2020 14:33:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n207sm228323iod.55.2020.02.19.14.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 14:33:52 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.6-rc3
Message-ID: <a95f0345-405b-82f4-85cd-c0b80ba700e7@linuxfoundation.org>
Date:   Wed, 19 Feb 2020 15:33:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DD846DF4203760B69CD87552"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DD846DF4203760B69CD87552
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.6-rc3

This Kselftest update for Linux 5.6-rc3 consists of fixes to build
failures and other test bugs.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.6-rc3

for you to fetch changes up to 9a0584f05687947d5a0b87f046bcd2592a55e67c:

   selftests: openat2: fix build error on newer glibc (2020-02-13 
13:15:45 -0700)

----------------------------------------------------------------
linux-kselftest-5.6-rc3

This Kselftest update for Linux 5.6-rc3 consists of fixes to build
failures and other test bugs.

----------------------------------------------------------------
Aleksa Sarai (1):
       selftests: openat2: fix build error on newer glibc

Colin Ian King (1):
       selftests: fix spelling mistaked "chaigned" -> "chained"

Dmitry Safonov (1):
       selftests: use LDLIBS for libraries instead of LDFLAGS

Jiri Benc (2):
       selftests: allow detection of build failures
       selftests: fix too long argument

Nikita Sobolev (1):
       Kernel selftests: tpm2: check for tpm support

Steven Rostedt (VMware) (1):
       selftests/ftrace: Have pid filter test use instance flag

  tools/testing/selftests/Makefile                   | 12 +++++++++--
  .../ftrace/test.d/ftrace/func-filter-pid.tc        |  8 +-------
  tools/testing/selftests/futex/functional/Makefile  |  2 +-
  tools/testing/selftests/lib.mk                     | 23 
++++++++++++----------
  tools/testing/selftests/net/Makefile               |  4 ++--
  tools/testing/selftests/openat2/helpers.c          |  2 +-
  tools/testing/selftests/openat2/resolve_test.c     |  2 +-
  tools/testing/selftests/rtc/Makefile               |  2 +-
  tools/testing/selftests/timens/Makefile            |  2 +-
  tools/testing/selftests/tpm2/test_smoke.sh         | 13 ++++++++++--
  tools/testing/selftests/tpm2/test_space.sh         |  9 ++++++++-
  11 files changed, 50 insertions(+), 29 deletions(-)

----------------------------------------------------------------

--------------DD846DF4203760B69CD87552
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.6-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.6-rc3.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 63430e2664c2..6ec503912bea 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -77,6 +77,12 @@ ifneq ($(SKIP_TARGETS),)
 	override TARGETS := $(TMP)
 endif
 
+# User can set FORCE_TARGETS to 1 to require all targets to be successfully
+# built; make will fail if any of the targets cannot be built. If
+# FORCE_TARGETS is not set (the default), make will succeed if at least one
+# of the targets gets built.
+FORCE_TARGETS ?=
+
 # Clear LDFLAGS and MAKEFLAGS if called from main
 # Makefile to avoid test build failures when test
 # Makefile doesn't have explicit build rules.
@@ -151,7 +157,8 @@ all: khdr
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;	\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
+				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
 
@@ -205,7 +212,8 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
 	done; exit $$ret;
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 64cfcc75e3c1..f2ee1e889e13 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: ftrace - function pid filters
+# flags: instance
 
 # Make sure that function pid matching filter works.
 # Also test it on an instance directory
@@ -96,13 +97,6 @@ do_test() {
 }
 
 do_test
-
-mkdir instances/foo
-cd instances/foo
-do_test
-cd ../../
-rmdir instances/foo
-
 do_reset
 
 exit 0
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 30996306cabc..23207829ec75 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../
 CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
-LDFLAGS := $(LDFLAGS) -pthread -lrt
+LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..3ed0134a764d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -83,17 +83,20 @@ else
 	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
+define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+
 define INSTALL_RULE
-	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then					\
-		mkdir -p ${INSTALL_PATH};										\
-		echo "rsync -a $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(INSTALL_PATH)/";	\
-		rsync -a $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(INSTALL_PATH)/;		\
-	fi
-	@if [ "X$(TEST_GEN_PROGS)$(TEST_CUSTOM_PROGS)$(TEST_GEN_PROGS_EXTENDED)$(TEST_GEN_FILES)" != "X" ]; then					\
-		mkdir -p ${INSTALL_PATH};										\
-		echo "rsync -a $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(INSTALL_PATH)/";	\
-		rsync -a $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(INSTALL_PATH)/;		\
-	fi
+	$(eval INSTALL_LIST = $(TEST_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
 endef
 
 install: all
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b5694196430a..287ae916ec0b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -27,5 +27,5 @@ KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
-$(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
-$(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
+$(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
+$(OUTPUT)/tcp_inq: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
index e9a6557ab16f..5074681ffdc9 100644
--- a/tools/testing/selftests/openat2/helpers.c
+++ b/tools/testing/selftests/openat2/helpers.c
@@ -46,7 +46,7 @@ int sys_renameat2(int olddirfd, const char *oldpath,
 
 int touchat(int dfd, const char *path)
 {
-	int fd = openat(dfd, path, O_CREAT);
+	int fd = openat(dfd, path, O_CREAT, 0700);
 	if (fd >= 0)
 		close(fd);
 	return fd;
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index 7a94b1da8e7b..bbafad440893 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -230,7 +230,7 @@ void test_openat2_opath_tests(void)
 		{ .name = "[in_root] garbage link to /root",
 		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = "root",		.pass = true },
-		{ .name = "[in_root] chainged garbage links to /root",
+		{ .name = "[in_root] chained garbage links to /root",
 		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = "root",		.pass = true },
 		{ .name = "[in_root] relative path to 'root'",
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index de9c8566672a..2d93d65723c9 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
 
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index e9fb30bd8aeb..b4fd9a934654 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -2,6 +2,6 @@ TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
-LDFLAGS := -lrt -ldl
+LDLIBS := -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..b630c7b5950a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,8 +1,17 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+self.flags = flags
 
-python -m unittest -v tpm2_tests.SmokeTest
-python -m unittest -v tpm2_tests.AsyncTest
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+
+if [ -f /dev/tpm0 ] ; then
+	python -m unittest -v tpm2_tests.SmokeTest
+	python -m unittest -v tpm2_tests.AsyncTest
+else
+	exit $ksft_skip
+fi
 
 CLEAR_CMD=$(which tpm2_clear)
 if [ -n $CLEAR_CMD ]; then
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index a6f5e346635e..180b469c53b4 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,4 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-python -m unittest -v tpm2_tests.SpaceTest
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if [ -f /dev/tpmrm0 ] ; then
+	python -m unittest -v tpm2_tests.SpaceTest
+else
+	exit $ksft_skip
+fi

--------------DD846DF4203760B69CD87552--
