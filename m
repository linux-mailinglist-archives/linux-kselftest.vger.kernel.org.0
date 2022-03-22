Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD324E35FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiCVBdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiCVBdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 21:33:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A582CD82F
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:31:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id l18so18756694ioj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 18:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=fiG1TYuywPb8D46YfLOmwuD0wtAiZkZLSs/JIg5IzAA=;
        b=CKEpwCuxCdabbwgtAzP7CO3uwmUACOV6rDOZYFHRcNIRYcUAdLNkgLSAsjQd5Bx2uv
         oa1lAxDRYvC28bOZ6k4siK3CYrv+snF1dEhU9J2wf9xpNXQ4qRppk2w6qkijKjMZtE6t
         i3D/uUY4ygm9RRRAhZYEalM+K68JKVlTQyRCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=fiG1TYuywPb8D46YfLOmwuD0wtAiZkZLSs/JIg5IzAA=;
        b=hgm/vm6yvGujP975J8bCf4GEJaWNDhf8mVh3r3RrIkFfgK2nW7oTOlkt0uEoLoKA7s
         oUAZQA1CPJF4wYxAL4lIhgL9beYMnbvfpPdDt9TP8nqJkU+luUwbjc/zAOYnqzbbFbdY
         qLazfBtkHX8kOA9/7QJzjwDFv2Rw7ZA/b++5nwg2TFZ09skXGksJaZW1BPh/potDkfo9
         486iZqf8JQAsAFdxbZDfxp7cM2E8nO9r7NUgfea5GSFrf+b8TUrckdQIuAJlPHs6LZ4/
         TtiVfcm/PbQ96BDgB8mY9Munc3vrljteIBbmP5fgfDCBhkR/58lpsEUtMTezHc8PmJVk
         bi4A==
X-Gm-Message-State: AOAM532GxtgnFWpNnkqgetlHuSChgnGZgkQMj3prrbMT81Ak7ADgpN2D
        BCGOfeEc2ihDvXNfy//cUHwalc5SxiyK6Q==
X-Google-Smtp-Source: ABdhPJzZFKuYxJA1ownkO3WYE/6v7QC4GO9EX2rshs//0RrZVxZhOmmlrkbQTqfXRmSYYDG/+uaQUA==
X-Received: by 2002:a05:6638:300b:b0:317:a127:53ac with SMTP id r11-20020a056638300b00b00317a12753acmr11395854jak.77.1647912716124;
        Mon, 21 Mar 2022 18:31:56 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g4-20020a92cda4000000b002c24724f23csm10763040ild.13.2022.03.21.18.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:31:55 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.18-rc1
Message-ID: <fac10dac-f8e3-97b9-8d11-0ca2136991ed@linuxfoundation.org>
Date:   Mon, 21 Mar 2022 19:31:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5B3800F5CA87D485C71C9073"
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B3800F5CA87D485C71C9073
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.18-rc1

This Kselftest update for Linux 5.18-rc1 consists of several build and
cleanup fixes.

- removing obsolete config options
- removing dependency on internal kernel macros
- adding config options
- several build fixes related to headers and install paths

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

   Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.18-rc1

for you to fetch changes up to f6d344cd5fa6a15e1ec2da350470b35a3f55f74c:

   selftests: Fix build when $(O) points to a relative path (2022-03-03 15:18:13 -0700)

----------------------------------------------------------------
linux-kselftest-next-5.18-rc1

This Kselftest update for Linux 5.18-rc1 consists of several build and
cleanup fixes.

- removing obsolete config options
- removing dependency on internal kernel macros
- adding config options
- several build fixes related to headers and install paths

----------------------------------------------------------------
Cristian Marussi (1):
       selftests/kselftest/runner.sh: Pass optional command parameters in environment

Geliang Tang (1):
       selftests: netfilter: fix a build error on openSUSE

Mateusz Jończyk (1):
       selftests/rtc: continuously read RTC in a loop for 30s

Muhammad Usama Anjum (19):
       selftests: futex: set DEFAULT_INSTALL_HDR_PATH
       selftests: set the BUILD variable to absolute path
       selftests: Add and export a kernel uapi headers path
       selftests: Correct the headers install path
       selftests: futex: Add the uapi headers include variable
       selftests: kvm: Add the uapi headers include variable
       selftests: landlock: Add the uapi headers include variable
       selftests: net: Add the uapi headers include variable
       selftests: mptcp: Add the uapi headers include variable
       selftests: vm: Add the uapi headers include variable
       selftests: vm: remove dependecy from internal kernel macros
       selftests: Use -isystem instead of -I to include headers
       selftests/exec: Rename file binfmt_script to binfmt_script.py
       selftests/lkdtm: Remove dead config option
       selftests/lkdtm: Add UBSAN config
       selftests: add kselftest_install to .gitignore
       selftests/exec: add generated files to .gitignore
       selftests: kvm: add generated file to the .gitignore
       selftests: Fix build when $(O) points to a relative path

  tools/testing/selftests/.gitignore                 |  1 +
  tools/testing/selftests/Makefile                   | 37 ++++++++----
  tools/testing/selftests/exec/.gitignore            |  2 +
.../exec/{binfmt_script => binfmt_script.py}       |  0
  tools/testing/selftests/futex/functional/Makefile  |  6 +-
  tools/testing/selftests/kselftest/runner.sh        | 30 +++++++++-
  tools/testing/selftests/kvm/.gitignore             |  1 +
  tools/testing/selftests/kvm/Makefile               |  2 +-
  tools/testing/selftests/landlock/Makefile          |  2 +-
  tools/testing/selftests/lkdtm/config               |  2 +-
  tools/testing/selftests/net/Makefile               |  2 +-
  tools/testing/selftests/net/mptcp/Makefile         |  2 +-
  tools/testing/selftests/netfilter/Makefile         |  1 +
  tools/testing/selftests/rtc/rtctest.c              | 66 ++++++++++++++++++++++
  tools/testing/selftests/rtc/settings               |  2 +-
  tools/testing/selftests/vm/Makefile                |  2 +-
  tools/testing/selftests/vm/userfaultfd.c           |  3 +
  18 files changed, 140 insertions(+), 23 deletions(-)
  rename tools/testing/selftests/exec/{binfmt_script => binfmt_script.py}
----------------------------------------------------------------

--------------5B3800F5CA87D485C71C9073
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.18-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.18-rc1.diff"

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 055a5019b13c..cb24124ac5b9 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -3,6 +3,7 @@ gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
+kselftest_install/
 tpm2/SpaceTest.log
 
 # Python bytecode and cache
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d08fe4cfe811..2319ec87f53d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -114,23 +114,35 @@ ifdef building_out_of_srctree
 override LDFLAGS =
 endif
 
-ifneq ($(O),)
-	BUILD := $(O)/kselftest
+top_srcdir ?= ../../..
+
+ifeq ("$(origin O)", "command line")
+  KBUILD_OUTPUT := $(O)
+endif
+
+ifneq ($(KBUILD_OUTPUT),)
+  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
+  # expand a shell special character '~'. We use a somewhat tedious way here.
+  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
+  $(if $(abs_objtree),, \
+    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
+  # $(realpath ...) resolves symlinks
+  abs_objtree := $(realpath $(abs_objtree))
+  BUILD := $(abs_objtree)/kselftest
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
-	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)/kselftest
-	else
-		BUILD := $(shell pwd)
-		DEFAULT_INSTALL_HDR_PATH := 1
-	endif
+  BUILD := $(CURDIR)
+  abs_srctree := $(shell cd $(top_srcdir) && pwd)
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
+  DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
 # Prepare for headers install
-top_srcdir ?= ../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
+export KHDR_INCLUDES
 
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
@@ -155,7 +167,7 @@ khdr:
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
 	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$(abs_objtree)/usr \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 
@@ -165,6 +177,7 @@ all: khdr
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
 		mkdir $$BUILD_TARGET  -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
+				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
@@ -172,7 +185,8 @@ all: khdr
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
+				O=$(abs_objtree);		    \
 	done;
 
 hotplug:
@@ -223,6 +237,7 @@ ifdef INSTALL_PATH
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
 	done; exit $$ret;
diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 9e2f00343f15..90c238ba6a4b 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -7,6 +7,8 @@ execveat.moved
 execveat.path.ephemeral
 execveat.ephemeral
 execveat.denatured
+non-regular
+null-argv
 /load_address_*
 /recursion-depth
 xxxxxxxx*
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 2d7fca446c7f..7f0412a26ba9 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,7 +3,7 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script
+TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
diff --git a/tools/testing/selftests/exec/binfmt_script b/tools/testing/selftests/exec/binfmt_script.py
similarity index 100%
rename from tools/testing/selftests/exec/binfmt_script
rename to tools/testing/selftests/exec/binfmt_script.py
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 5cc38de9d8ea..b8152c573e8a 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-INCLUDES := -I../include -I../../ -I../../../../../usr/include/ \
-	-I$(KBUILD_OUTPUT)/kselftest/usr/include
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES)
+INCLUDES := -I../include -I../../ -I../../../../../usr/include/
+CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 HEADERS := \
@@ -24,6 +23,7 @@ TEST_PROGS := run.sh
 
 top_srcdir = ../../../../..
 KSFT_KHDR_INSTALL := 1
+DEFAULT_INSTALL_HDR_PATH := 1
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a9ba782d8ca0..294619ade49f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -18,6 +18,8 @@ if [ -z "$BASE_DIR" ]; then
 	exit 1
 fi
 
+TR_CMD=$(command -v tr)
+
 # If Perl is unavailable, we must fall back to line-at-a-time prefixing
 # with sed instead of unbuffered output.
 tap_prefix()
@@ -49,6 +51,31 @@ run_one()
 
 	# Reset any "settings"-file variables.
 	export kselftest_timeout="$kselftest_default_timeout"
+
+	# Safe default if tr not available
+	kselftest_cmd_args_ref="KSELFTEST_ARGS"
+
+	# Optional arguments for this command, possibly defined as an
+	# environment variable built using the test executable in all
+	# uppercase and sanitized substituting non acceptable shell
+	# variable name characters with "_" as in:
+	#
+	# 	KSELFTEST_<UPPERCASE_SANITIZED_TESTNAME>_ARGS="<options>"
+	#
+	# e.g.
+	#
+	# 	rtctest --> KSELFTEST_RTCTEST_ARGS="/dev/rtc1"
+	#
+	# 	cpu-on-off-test.sh --> KSELFTEST_CPU_ON_OFF_TEST_SH_ARGS="-a -p 10"
+	#
+	if [ -n "$TR_CMD" ]; then
+		BASENAME_SANITIZED=$(echo "$BASENAME_TEST" | \
+					$TR_CMD -d "[:blank:][:cntrl:]" | \
+					$TR_CMD -c "[:alnum:]_" "_" | \
+					$TR_CMD [:lower:] [:upper:])
+		kselftest_cmd_args_ref="KSELFTEST_${BASENAME_SANITIZED}_ARGS"
+	fi
+
 	# Load per-test-directory kselftest "settings" file.
 	settings="$BASE_DIR/$DIR/settings"
 	if [ -r "$settings" ] ; then
@@ -69,7 +96,8 @@ run_one()
 		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
-		cmd="./$BASENAME_TEST"
+		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
+		cmd="./$BASENAME_TEST $kselftest_cmd_args"
 		if [ ! -x "$TEST" ]; then
 			echo "# Warning: file $TEST is not executable"
 
diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index dce7de7755e6..62f9b781545b 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -20,6 +20,7 @@
 /x86_64/hyperv_clock
 /x86_64/hyperv_cpuid
 /x86_64/hyperv_features
+/x86_64/hyperv_svm_test
 /x86_64/mmio_warning_test
 /x86_64/mmu_role_test
 /x86_64/platform_info_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 17c3f0749f05..b970397f725c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -149,7 +149,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS)
+	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index a99596ca9882..0b0049e133bb 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -Wall -O2
+CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
 
 src_test := $(wildcard *_test.c)
 
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index a26a3fa9e925..46f39ee76208 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -3,9 +3,9 @@ CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
-# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
 CONFIG_UBSAN_TRAP=y
 CONFIG_STACKPROTECTOR_STRONG=y
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9897fa9ab953..0b1488616c55 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -2,7 +2,7 @@
 # Makefile for net selftests
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
-CFLAGS += -I../../../../usr/include/
+CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 0356c4501c99..f905d5358e68 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -3,7 +3,7 @@
 top_srcdir = ../../../../..
 KSFT_KHDR_INSTALL := 1
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
+CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index e4f845dd942b..8136c1fab7ab 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh
 
+CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
 LDLIBS = -lmnl
 TEST_GEN_FILES =  nf-queue
 
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 66af608fb4c6..2b9d929a24ed 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -20,6 +20,8 @@
 
 #define NUM_UIE 3
 #define ALARM_DELTA 3
+#define READ_LOOP_DURATION_SEC 30
+#define READ_LOOP_SLEEP_MS 11
 
 static char *rtc_file = "/dev/rtc0";
 
@@ -49,6 +51,70 @@ TEST_F(rtc, date_read) {
 	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 }
 
+static time_t rtc_time_to_timestamp(struct rtc_time *rtc_time)
+{
+	struct tm tm_time = {
+	       .tm_sec = rtc_time->tm_sec,
+	       .tm_min = rtc_time->tm_min,
+	       .tm_hour = rtc_time->tm_hour,
+	       .tm_mday = rtc_time->tm_mday,
+	       .tm_mon = rtc_time->tm_mon,
+	       .tm_year = rtc_time->tm_year,
+	};
+
+	return mktime(&tm_time);
+}
+
+static void nanosleep_with_retries(long ns)
+{
+	struct timespec req = {
+		.tv_sec = 0,
+		.tv_nsec = ns,
+	};
+	struct timespec rem;
+
+	while (nanosleep(&req, &rem) != 0) {
+		req.tv_sec = rem.tv_sec;
+		req.tv_nsec = rem.tv_nsec;
+	}
+}
+
+TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
+	int rc;
+	long iter_count = 0;
+	struct rtc_time rtc_tm;
+	time_t start_rtc_read, prev_rtc_read;
+
+	TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
+	       READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
+	ASSERT_NE(-1, rc);
+	start_rtc_read = rtc_time_to_timestamp(&rtc_tm);
+	prev_rtc_read = start_rtc_read;
+
+	do  {
+		time_t rtc_read;
+
+		rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
+		ASSERT_NE(-1, rc);
+
+		rtc_read = rtc_time_to_timestamp(&rtc_tm);
+		/* Time should not go backwards */
+		ASSERT_LE(prev_rtc_read, rtc_read);
+		/* Time should not increase more then 1s at a time */
+		ASSERT_GE(prev_rtc_read + 1, rtc_read);
+
+		/* Sleep 11ms to avoid killing / overheating the RTC */
+		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
+
+		prev_rtc_read = rtc_read;
+		iter_count++;
+	} while (prev_rtc_read <= start_rtc_read + READ_LOOP_DURATION_SEC);
+
+	TH_LOG("Performed %ld RTC time reads.", iter_count);
+}
+
 TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	int i, rc, irq = 0;
 	unsigned long data;
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index a953c96aa16e..0c1a2075d5f3 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=180
+timeout=210
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..033e9e11e2da 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
+CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2f49c9af1b58..50476ec6c070 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -119,6 +119,9 @@ struct uffd_stats {
 				 ~(unsigned long)(sizeof(unsigned long long) \
 						  -  1)))
 
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"

--------------5B3800F5CA87D485C71C9073--
