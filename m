Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38CE5873B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiHAWDp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHAWDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 18:03:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81785273
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 15:03:42 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o2so9420969iof.8
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Aug 2022 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=TSRyc+/+YJtS9s6hi+1vjE8GWAp5Ub+fgCppGZZsMO0=;
        b=SHB8YgmPvstE8ESUWCJwla52M+MHhxbuM/JZETG9QluYVUJRg8NdT0s4/Vc8YmgPvb
         uUOsa79M7tyY3OdrSP76iqSRTRe53H6/hmvfbuVM2pDni22BZg5Hm/1uNlLJbnpO1p3j
         C148+HEzQAKkQ1Lmqk8TrQIwT94I8pSv9h8QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=TSRyc+/+YJtS9s6hi+1vjE8GWAp5Ub+fgCppGZZsMO0=;
        b=2HD35lT9zlT7dIEyvSKwK1T0cohZbohkFhiskYjHXdEzXgx+mg+LWa2G+mFgZtdRof
         QdN5voV20o32Yw7INr0cR+dFupDQbD1AtaM1OOCOyubV7uZZil8Is792uy7WLb5+AQMn
         usJASV61ztKd56Qf1OropnItopIW7eDsHO0WhH5H5nC+qAXbGXC6eeR/3gj0hItgfakR
         d4KOrLQH2V98SfhMfmUKBEelVQ2/Wc+2WPPuIY6c5Gg3se/4YhNU+R2oVUS1oJYx0Y/k
         kOfz21mgjrwHdR+JRCBR06H+bgWOLpNCEBfSXvkA2QzpThqLgyvbzt8Ul7JE5s7fEyFm
         3duA==
X-Gm-Message-State: AJIora/ALqy3YLo4VyLtJmSSO8Hg3y/4lxqhvo78Yj4AzQkOByIhPmSG
        wPyd/ymd2ZWby7uvCvcX1KwJvg==
X-Google-Smtp-Source: AGRyM1vC+vhoGLValBnsTXoMmO0PlZSDPHyAz7fiSUFTKCvDeFKuqKFx+StJzeTBD8Jt+wvTYUMaxw==
X-Received: by 2002:a05:6602:2b10:b0:67b:80f8:6f2b with SMTP id p16-20020a0566022b1000b0067b80f86f2bmr6286288iov.147.1659391421681;
        Mon, 01 Aug 2022 15:03:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l16-20020a922810000000b002de1e1d7316sm4549641ilf.56.2022.08.01.15.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 15:03:40 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.20-rc1
Message-ID: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
Date:   Mon, 1 Aug 2022 16:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EF7D0570A6C96A81F8E7B289"
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF7D0570A6C96A81F8E7B289
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.20-rc1.

This Kselftest update for Linux 5.20-rc1 consists of:

- timers test build fixes and cleanups for new tool chains
- removing khdr from kselftest framework and main Makefile
- changes to test output messages to improve reports

Please not that this update also included main Makefile change
to kselftest build logic in it.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

   Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.20-rc1

for you to fetch changes up to 4062eba9f3d072e72645860fbc5d160428a75c50:

   Makefile: replace headers_install with headers for kselftest (2022-07-26 18:06:33 -0600)

----------------------------------------------------------------
linux-kselftest-next-5.20-rc1

This Kselftest update for Linux 5.20-rc1 consists of:

- timers test build fixes and cleanups for new tool chains
- removing khdr from kselftest framework and main Makefile
- changes to test output messages to improve reports

----------------------------------------------------------------
Gautam (2):
       kselftests: Enable the echo command to print newlines in Makefile
       kselftests/damon: add support for cases where debugfs cannot be read

Gautam Menghani (3):
       selftests: Make the usage formatting consistent in kselftest_deps.sh
       selftests/drivers/gpu: Add error messages to drm_mm.sh
       selftests/kcmp: Make the test output consistent and clear

Guillaume Tucker (6):
       selftests: drop khdr make target
       selftests: stop using KSFT_KHDR_INSTALL
       selftests: drop KSFT_KHDR_INSTALL make target
       Makefile: add headers_install to kselftest targets
       selftests/landlock: drop deprecated headers dependency
       Makefile: replace headers_install with headers for kselftest

Johannes Holland (1):
       selftests/tpm2: increase timeout for kselftests

Soumya Negi (1):
       selftests: drivers/dma-buf: Improve message in selftest summary

Wolfram Sang (9):
       selftests: timers: valid-adjtimex: build fix for newer toolchains
       selftests: timers: fix declarations of main()
       selftests: timers: nanosleep: adapt to kselftest framework
       selftests: timers: inconsistency-check: adapt to kselftest framework
       selftests: timers: clocksource-switch: fix passing errors from child
       selftests: timers: clocksource-switch: sort includes
       selftests: timers: clocksource-switch: add command line switch to skip sanity check
       selftests: timers: clocksource-switch: add 'runtime' command line parameter
       selftests: timers: clocksource-switch: adapt to kselftest framework

Xiang wangx (1):
       userfaultfd/selftests: Fix typo in comment

Zan Aziz (1):
       selftests:timers: globals don't need initialization to 0

  Makefile                                           |  4 +-
  tools/testing/selftests/Makefile                   | 30 +--------
  tools/testing/selftests/arm64/mte/Makefile         |  1 -
  tools/testing/selftests/arm64/signal/Makefile      |  1 -
  .../testing/selftests/arm64/signal/test_signals.h  |  4 +-
  tools/testing/selftests/damon/_chk_dependency.sh   | 10 +++
  tools/testing/selftests/drivers/dma-buf/udmabuf.c  |  3 +-
  tools/testing/selftests/drivers/gpu/drm_mm.sh      |  4 +-
  .../selftests/drivers/s390x/uvdevice/Makefile      |  1 -
  tools/testing/selftests/futex/functional/Makefile  |  1 -
  tools/testing/selftests/kcmp/kcmp_test.c           |  6 +-
  tools/testing/selftests/kselftest_deps.sh          |  2 +-
  tools/testing/selftests/kvm/Makefile               |  1 -
  tools/testing/selftests/landlock/Makefile          | 10 +--
  tools/testing/selftests/lib.mk                     | 38 ------------
  tools/testing/selftests/net/Makefile               |  1 -
  tools/testing/selftests/net/mptcp/Makefile         |  1 -
  tools/testing/selftests/tc-testing/Makefile        |  1 -
  tools/testing/selftests/timers/adjtick.c           |  2 +-
  .../testing/selftests/timers/alarmtimer-suspend.c  |  2 +-
  tools/testing/selftests/timers/change_skew.c       |  2 +-
  .../testing/selftests/timers/clocksource-switch.c  | 71 ++++++++++++++--------
  .../testing/selftests/timers/inconsistency-check.c | 32 +++++-----
  tools/testing/selftests/timers/nanosleep.c         | 18 +++---
  tools/testing/selftests/timers/raw_skew.c          |  2 +-
  tools/testing/selftests/timers/skew_consistency.c  |  2 +-
  tools/testing/selftests/timers/valid-adjtimex.c    |  2 +-
  tools/testing/selftests/tpm2/settings              |  1 +
  tools/testing/selftests/vm/Makefile                |  1 -
  tools/testing/selftests/vm/userfaultfd.c           |  2 +-
  30 files changed, 111 insertions(+), 145 deletions(-)
  create mode 100644 tools/testing/selftests/tpm2/settings
----------------------------------------------------------------

--------------EF7D0570A6C96A81F8E7B289
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.20-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.20-rc1.diff"

diff --git a/Makefile b/Makefile
index 8973b285ce6c..5c934d16664c 100644
--- a/Makefile
+++ b/Makefile
@@ -1347,10 +1347,10 @@ tools/%: FORCE
 # Kernel selftest
 
 PHONY += kselftest
-kselftest:
+kselftest: headers
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-kselftest-%: FORCE
+kselftest-%: headers FORCE
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index de11992dc577..5047d8eef53e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -143,7 +143,6 @@ endif
 # Prepare for headers install
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
-export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 export KHDR_INCLUDES
 
@@ -151,30 +150,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-# Install headers here once for all tests. KSFT_KHDR_INSTALL_DONE
-# is used to avoid running headers_install from lib.mk.
-# Invoke headers install with --no-builtin-rules to avoid circular
-# dependency in "make kselftest" case. In this case, second level
-# make inherits builtin-rules which will use the rule generate
-# Makefile.o and runs into
-# "Circular Makefile.o <- prepare dependency dropped."
-# and headers_install fails and test compile fails.
-#
-# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
-# invokes them as sub-makes and --no-builtin-rules is not necessary,
-# but doesn't cause any failures. Keep it simple and use the same
-# flags in both cases.
-# Local build cases: "make kselftest", "make -C" - headers are installed
-# in the default INSTALL_HDR_PATH usr/include.
-khdr:
-ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
-else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$(abs_objtree)/usr \
-		ARCH=$(ARCH) -C $(top_srcdir) headers_install
-endif
-
-all: khdr
+all:
 	@ret=1;							\
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
@@ -253,7 +229,7 @@ ifdef INSTALL_PATH
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo -n "Emit Tests for $$TARGET\n"; \
+		echo -ne "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
 			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
@@ -274,4 +250,4 @@ clean:
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
+.PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index 409e3e53d00a..a5a0744423d8 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -22,7 +22,6 @@ ifeq ($(mte_cc_support),1)
 TEST_GEN_PROGS := $(PROGS)
 
 # Get Kernel headers installed and use them.
-KSFT_KHDR_INSTALL := 1
 else
     $(warning compiler "$(CC)" does not support the ARMv8.5 MTE extension.)
     $(warning test program "mte" will not be created.)
diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index ac4ad0005715..be7520a863b0 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -11,7 +11,6 @@ PROGS := $(patsubst %.c,%,$(SRCS))
 TEST_GEN_PROGS := $(notdir $(PROGS))
 
 # Get Kernel headers installed and use them.
-KSFT_KHDR_INSTALL := 1
 
 # Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
 # to account for any OUTPUT target-dirs optionally provided by
diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index c70fdec7d7c4..0c645834ddc3 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -9,9 +9,7 @@
 #include <ucontext.h>
 
 /*
- * Using ARCH specific and sanitized Kernel headers installed by KSFT
- * framework since we asked for it by setting flag KSFT_KHDR_INSTALL
- * in our Makefile.
+ * Using ARCH specific and sanitized Kernel headers from the tree.
  */
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 0189db81550b..0328ac0b5a5e 100644
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -26,3 +26,13 @@ do
 		exit 1
 	fi
 done
+
+permission_error="Operation not permitted"
+for f in attrs target_ids monitor_on
+do
+	status=$( cat "$DBGFS/$f" 2>&1 )
+	if [ "${status#*$permission_error}" != "$status" ]; then
+		echo "Permission for reading $DBGFS/$f denied; maybe secureboot enabled?"
+		exit $ksft_skip
+	fi
+done
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index de1c4e6de0b2..c812080e304e 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -32,7 +32,8 @@ int main(int argc, char *argv[])
 
 	devfd = open("/dev/udmabuf", O_RDWR);
 	if (devfd < 0) {
-		printf("%s: [skip,no-udmabuf]\n", TEST_PREFIX);
+		printf("%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		       TEST_PREFIX);
 		exit(77);
 	}
 
diff --git a/tools/testing/selftests/drivers/gpu/drm_mm.sh b/tools/testing/selftests/drivers/gpu/drm_mm.sh
index b789dc8257e6..09c76cd7661d 100755
--- a/tools/testing/selftests/drivers/gpu/drm_mm.sh
+++ b/tools/testing/selftests/drivers/gpu/drm_mm.sh
@@ -3,7 +3,7 @@
 # Runs API tests for struct drm_mm (DRM range manager)
 
 if ! /sbin/modprobe -n -q test-drm_mm; then
-       echo "drivers/gpu/drm_mm: [skip]"
+       echo "drivers/gpu/drm_mm: module test-drm_mm is not found in /lib/modules/`uname -r` [skip]"
        exit 77
 fi
 
@@ -11,6 +11,6 @@ if /sbin/modprobe -q test-drm_mm; then
        /sbin/modprobe -q -r test-drm_mm
        echo "drivers/gpu/drm_mm: ok"
 else
-       echo "drivers/gpu/drm_mm: [FAIL]"
+       echo "drivers/gpu/drm_mm: module test-drm_mm could not be removed [FAIL]"
        exit 1
 fi
diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
index 5e701d2708d4..891215a7dc8a 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
@@ -11,7 +11,6 @@ else
 TEST_GEN_PROGS := test_uvdevice
 
 top_srcdir ?= ../../../../../..
-KSFT_KHDR_INSTALL := 1
 khdr_dir = $(top_srcdir)/usr/include
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index b8152c573e8a..732149011692 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -22,7 +22,6 @@ TEST_GEN_FILES := \
 TEST_PROGS := run.sh
 
 top_srcdir = ../../../../..
-KSFT_KHDR_INSTALL := 1
 DEFAULT_INSTALL_HDR_PATH := 1
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..25110c7c0b3e 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -88,6 +88,9 @@ int main(int argc, char **argv)
 		int pid2 = getpid();
 		int ret;
 
+		ksft_print_header();
+		ksft_set_plan(3);
+
 		fd2 = open(kpath, O_RDWR, 0644);
 		if (fd2 < 0) {
 			perror("Can't open file");
@@ -152,7 +155,6 @@ int main(int argc, char **argv)
 			ksft_inc_pass_cnt();
 		}
 
-		ksft_print_cnts();
 
 		if (ret)
 			ksft_exit_fail();
@@ -162,5 +164,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	return 0;
 }
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 00e60d6eb16b..708cb5429633 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -26,7 +26,7 @@ echo "  main Makefile when optional -p is specified."
 echo "- Prints pass/fail dependency check for each tests/sub-test."
 echo "- Prints pass/fail targets and libraries."
 echo "- Default: runs dependency checks on all tests."
-echo "- Optional test name can be specified to check dependencies for it."
+echo "- Optional: test name can be specified to check dependencies for it."
 exit 1
 
 }
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 22423c871ed6..120951fc304a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -4,7 +4,6 @@ include ../../../build/Build.include
 all:
 
 top_srcdir = ../../../..
-KSFT_KHDR_INSTALL := 1
 
 # For cross-builds to work, UNAME_M has to map to ARCH and arch specific
 # directories and targets in this Makefile. "uname -m" doesn't map to
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index 0b0049e133bb..a6959df28eb0 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -8,17 +8,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
 
 TEST_GEN_PROGS_EXTENDED := true
 
-KSFT_KHDR_INSTALL := 1
 OVERRIDE_TARGETS := 1
 include ../lib.mk
 
-khdr_dir = $(top_srcdir)/usr/include
-
-$(khdr_dir)/linux/landlock.h: khdr
-	@:
-
 $(OUTPUT)/true: true.c
 	$(LINK.c) $< $(LDLIBS) -o $@ -static
 
-$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
-	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
+$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1a5cc3cd97ec..947fc72413e9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -51,45 +51,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-ifdef KSFT_KHDR_INSTALL
-top_srcdir ?= ../../../..
-include $(top_srcdir)/scripts/subarch.include
-ARCH		?= $(SUBARCH)
-
-# set default goal to all, so make without a target runs all, even when
-# all isn't the first target in the file.
-.DEFAULT_GOAL := all
-
-# Invoke headers install with --no-builtin-rules to avoid circular
-# dependency in "make kselftest" case. In this case, second level
-# make inherits builtin-rules which will use the rule generate
-# Makefile.o and runs into
-# "Circular Makefile.o <- prepare dependency dropped."
-# and headers_install fails and test compile fails.
-# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
-# invokes them as sub-makes and --no-builtin-rules is not necessary,
-# but doesn't cause any failures. Keep it simple and use the same
-# flags in both cases.
-# Note that the support to install headers from lib.mk is necessary
-# when test Makefile is run directly with "make -C".
-# When local build is done, headers are installed in the default
-# INSTALL_HDR_PATH usr/include.
-.PHONY: khdr
-.NOTPARALLEL:
-khdr:
-ifndef KSFT_KHDR_INSTALL_DONE
-ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
-else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
-		ARCH=$(ARCH) -C $(top_srcdir) headers_install
-endif
-endif
-
-all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
-else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
-endif
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7ea54af55490..bc006f2693da 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -62,7 +62,6 @@ TEST_PROGS += test_vxlan_vnifiltering.sh
 
 TEST_FILES := settings
 
-KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 include bpf/Makefile
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index f905d5358e68..1af2f66fb59a 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 top_srcdir = ../../../../..
-KSFT_KHDR_INSTALL := 1
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/tc-testing/Makefile b/tools/testing/selftests/tc-testing/Makefile
index 4d639279f41e..cb553eac9f41 100644
--- a/tools/testing/selftests/tc-testing/Makefile
+++ b/tools/testing/selftests/tc-testing/Makefile
@@ -5,7 +5,6 @@ top_srcdir = $(abspath ../../../..)
 APIDIR := $(top_scrdir)/include/uapi
 TEST_GEN_FILES = action.o
 
-KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 PROBE := $(shell $(LLC) -march=bpf -mcpu=probe -filetype=null /dev/null 2>&1)
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 54d8d87f36b3..47e05fdc32c5 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -165,7 +165,7 @@ int check_tick_adj(long tickval)
 	return  0;
 }
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timespec raw;
 	long tick, max, interval, err;
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 54da4b088f4c..4332b494103d 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -92,7 +92,7 @@ long long timespec_sub(struct timespec a, struct timespec b)
 	return ret;
 }
 
-int final_ret = 0;
+int final_ret;
 
 void sigalarm(int signo)
 {
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index c4eab7124990..992a77f2a74c 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -55,7 +55,7 @@ int change_skew_test(int ppm)
 }
 
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timex tx;
 	int i, ret;
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index ef8eb3604595..c5264594064c 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -23,17 +23,17 @@
  */
 
 
+#include <fcntl.h>
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/timex.h>
-#include <time.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <string.h>
 #include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
 #include "../kselftest.h"
 
 
@@ -110,21 +110,40 @@ int run_tests(int secs)
 
 	sprintf(buf, "./inconsistency-check -t %i", secs);
 	ret = system(buf);
-	if (ret)
-		return ret;
+	if (WIFEXITED(ret) && WEXITSTATUS(ret))
+		return WEXITSTATUS(ret);
 	ret = system("./nanosleep");
-	return ret;
+	return WIFEXITED(ret) ? WEXITSTATUS(ret) : 0;
 }
 
 
 char clocksource_list[10][30];
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	char orig_clk[512];
-	int count, i, status;
+	int count, i, status, opt;
+	int do_sanity_check = 1;
+	int runtime = 60;
 	pid_t pid;
 
+	/* Process arguments */
+	while ((opt = getopt(argc, argv, "st:")) != -1) {
+		switch (opt) {
+		case 's':
+			do_sanity_check = 0;
+			break;
+		case 't':
+			runtime = atoi(optarg);
+			break;
+		default:
+			printf("Usage: %s [-s] [-t <secs>]\n", argv[0]);
+			printf("	-s: skip sanity checks\n");
+			printf("	-t: Number of seconds to run\n");
+			exit(-1);
+		}
+	}
+
 	get_cur_clocksource(orig_clk, 512);
 
 	count = get_clocksources(clocksource_list);
@@ -135,23 +154,25 @@ int main(int argv, char **argc)
 	}
 
 	/* Check everything is sane before we start switching asynchronously */
-	for (i = 0; i < count; i++) {
-		printf("Validating clocksource %s\n", clocksource_list[i]);
-		if (change_clocksource(clocksource_list[i])) {
-			status = -1;
-			goto out;
-		}
-		if (run_tests(5)) {
-			status = -1;
-			goto out;
+	if (do_sanity_check) {
+		for (i = 0; i < count; i++) {
+			printf("Validating clocksource %s\n",
+				clocksource_list[i]);
+			if (change_clocksource(clocksource_list[i])) {
+				status = -1;
+				goto out;
+			}
+			if (run_tests(5)) {
+				status = -1;
+				goto out;
+			}
 		}
 	}
 
-
 	printf("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
-		return run_tests(60);
+		return run_tests(runtime);
 
 	while (pid != waitpid(pid, &status, WNOHANG))
 		for (i = 0; i < count; i++)
@@ -162,7 +183,9 @@ int main(int argv, char **argc)
 out:
 	change_clocksource(orig_clk);
 
-	if (status)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+	/* Print at the end to not mix output with child process */
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_test_result(!status, "clocksource-switch\n");
+	ksft_exit(!status);
 }
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index e6756d9c60a7..36a49fba6c9b 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -122,30 +122,28 @@ int consistency_test(int clock_type, unsigned long seconds)
 		if (inconsistent >= 0) {
 			unsigned long long delta;
 
-			printf("\%s\n", start_str);
+			ksft_print_msg("\%s\n", start_str);
 			for (i = 0; i < CALLS_PER_LOOP; i++) {
 				if (i == inconsistent)
-					printf("--------------------\n");
-				printf("%lu:%lu\n", list[i].tv_sec,
+					ksft_print_msg("--------------------\n");
+				ksft_print_msg("%lu:%lu\n", list[i].tv_sec,
 							list[i].tv_nsec);
 				if (i == inconsistent + 1)
-					printf("--------------------\n");
+					ksft_print_msg("--------------------\n");
 			}
 			delta = list[inconsistent].tv_sec * NSEC_PER_SEC;
 			delta += list[inconsistent].tv_nsec;
 			delta -= list[inconsistent+1].tv_sec * NSEC_PER_SEC;
 			delta -= list[inconsistent+1].tv_nsec;
-			printf("Delta: %llu ns\n", delta);
+			ksft_print_msg("Delta: %llu ns\n", delta);
 			fflush(0);
 			/* timestamp inconsistency*/
 			t = time(0);
-			printf("%s\n", ctime(&t));
-			printf("[FAILED]\n");
+			ksft_print_msg("%s\n", ctime(&t));
 			return -1;
 		}
 		now = list[0].tv_sec;
 	}
-	printf("[OK]\n");
 	return 0;
 }
 
@@ -178,16 +176,22 @@ int main(int argc, char *argv[])
 
 	setbuf(stdout, NULL);
 
+	ksft_print_header();
+	ksft_set_plan(maxclocks - userclock);
+
 	for (clockid = userclock; clockid < maxclocks; clockid++) {
 
-		if (clockid == CLOCK_HWSPECIFIC)
+		if (clockid == CLOCK_HWSPECIFIC || clock_gettime(clockid, &ts)) {
+			ksft_test_result_skip("%-31s\n", clockstring(clockid));
 			continue;
+		}
 
-		if (!clock_gettime(clockid, &ts)) {
-			printf("Consistent %-30s ", clockstring(clockid));
-			if (consistency_test(clockid, runtime))
-				return ksft_exit_fail();
+		if (consistency_test(clockid, runtime)) {
+			ksft_test_result_fail("%-31s\n", clockstring(clockid));
+			ksft_exit_fail();
+		} else {
+			ksft_test_result_pass("%-31s\n", clockstring(clockid));
 		}
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..df1d03516e7b 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -133,33 +133,37 @@ int main(int argc, char **argv)
 	long long length;
 	int clockid, ret;
 
+	ksft_print_header();
+	ksft_set_plan(NR_CLOCKIDS);
+
 	for (clockid = CLOCK_REALTIME; clockid < NR_CLOCKIDS; clockid++) {
 
 		/* Skip cputime clockids since nanosleep won't increment cputime */
 		if (clockid == CLOCK_PROCESS_CPUTIME_ID ||
 				clockid == CLOCK_THREAD_CPUTIME_ID ||
-				clockid == CLOCK_HWSPECIFIC)
+				clockid == CLOCK_HWSPECIFIC) {
+			ksft_test_result_skip("%-31s\n", clockstring(clockid));
 			continue;
+		}
 
-		printf("Nanosleep %-31s ", clockstring(clockid));
 		fflush(stdout);
 
 		length = 10;
 		while (length <= (NSEC_PER_SEC * 10)) {
 			ret = nanosleep_test(clockid, length);
 			if (ret == UNSUPPORTED) {
-				printf("[UNSUPPORTED]\n");
+				ksft_test_result_skip("%-31s\n", clockstring(clockid));
 				goto next;
 			}
 			if (ret < 0) {
-				printf("[FAILED]\n");
-				return ksft_exit_fail();
+				ksft_test_result_fail("%-31s\n", clockstring(clockid));
+				ksft_exit_fail();
 			}
 			length *= 100;
 		}
-		printf("[OK]\n");
+		ksft_test_result_pass("%-31s\n", clockstring(clockid));
 next:
 		ret = 0;
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index b41d8dd0c40c..5beceeed0d11 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -89,7 +89,7 @@ void get_monotonic_and_raw(struct timespec *mon, struct timespec *raw)
 	}
 }
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timespec mon, raw, start, end;
 	long long delta1, delta2, interval, eppm, ppm;
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 8066be9aff11..63913f75b384 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -38,7 +38,7 @@
 
 #define NSEC_PER_SEC 1000000000LL
 
-int main(int argv, char **argc)
+int main(int argc, char **argv)
 {
 	struct timex tx;
 	int ret, ppm;
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 5397de708d3c..48b9a803235a 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -40,7 +40,7 @@
 #define ADJ_SETOFFSET 0x0100
 
 #include <sys/syscall.h>
-static int clock_adjtime(clockid_t id, struct timex *tx)
+int clock_adjtime(clockid_t id, struct timex *tx)
 {
 	return syscall(__NR_clock_adjtime, id, tx);
 }
diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
new file mode 100644
index 000000000000..a62d2fa1275c
--- /dev/null
+++ b/tools/testing/selftests/tpm2/settings
@@ -0,0 +1 @@
+timeout=600
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 44f25acfbeca..108587cb327a 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -94,7 +94,6 @@ TEST_PROGS := run_vmtests.sh
 TEST_FILES := test_vmalloc.sh
 TEST_FILES += test_hmm.sh
 
-KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/madv_populate: vm_util.c
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0bdfc1955229..4bc24581760d 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -860,7 +860,7 @@ static int stress(struct uffd_stats *uffd_stats)
 	/*
 	 * Be strict and immediately zap area_src, the whole area has
 	 * been transferred already by the background treads. The
-	 * area_src could then be faulted in in a racy way by still
+	 * area_src could then be faulted in a racy way by still
 	 * running uffdio_threads reading zeropages after we zapped
 	 * area_src (but they're guaranteed to get -EEXIST from
 	 * UFFDIO_COPY without writing zero pages into area_dst

--------------EF7D0570A6C96A81F8E7B289--
