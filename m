Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A51C9938
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgEGSXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 14:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 14:23:41 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A396C05BD43
        for <linux-kselftest@vger.kernel.org>; Thu,  7 May 2020 11:23:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y26so2357183ioj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 May 2020 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=ipgG7bVxBHO6i2KUwtORX/P7bJ96Jy9myM8jttxH8h0=;
        b=Iew6+vU5zbhaRcytxF7/yg0gXVBJ/raP7Af1w9QPnwPVsaA3ELnU25v5gvStd3YEWv
         ipZGP/AtTFBnxhtc2sHJZA7TF8OzkNM0E4TChWeABb2CAbTZNnQDwmAVUuC7MAHqsNX5
         59MH6oUY0Aw29BgMg1utGesU/MyGzoZGBmJ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=ipgG7bVxBHO6i2KUwtORX/P7bJ96Jy9myM8jttxH8h0=;
        b=ukmbV4v7ug+rbc/T4Dg/PG4sXWNyNeNPDuFBWN+EHAXxNOWimRq+kx8FeH96vJ5APf
         BeNjCjax9dX9yPQ4lgTPHUiLVcblPgM4OZajotXqx+bGpYibfrQkj9fmCtkms5VgKuIR
         kA1DG+Db9LEvjs12Um7DH1K0cLG7qzcCsiF8eqmdKMbqvb8Yyz0lSsuW1FT72LLIKAjr
         Z4ybDK9jlopW+7kHTF3W9ZVszQ2KFHZz+aVpBBlU5OHaYFUFn5aXUNIadwUa6mfht3X3
         ai4f4LZAmT+q3nisP3ZNbsaeppV4pEAI8787RYOgbq0Cg+H1X0/Mfdwx0xaua7g1ydR+
         zsjA==
X-Gm-Message-State: AGi0PubNM/FUH5+gTUFk7U0aAX5OQ5L1PQyfDihDhtQPwSMDl/2GVYTI
        sZINReYQVMR8t4RGPngIHQqZFA==
X-Google-Smtp-Source: APiQypL2kG1RhI04hlcZ0tVCmFltse5K0gUj5/r/pPYFcA5knj0cjT7Ft32CMLfpez8J9WE33jnZ5w==
X-Received: by 2002:a05:6602:124c:: with SMTP id o12mr15222131iou.71.1588875820360;
        Thu, 07 May 2020 11:23:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i10sm3065557ilp.28.2020.05.07.11.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 11:23:39 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.7-rc5
Message-ID: <357f0c72-ecb3-021e-4f5a-7ddc649688f2@linuxfoundation.org>
Date:   Thu, 7 May 2020 12:23:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DA18C3776462DC6A0D75C49B"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DA18C3776462DC6A0D75C49B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.7-rc5.

This Kselftest update for Linux 5.7-rc5 consists of ftrace test
fixes and fix to kvm Makefile for relocatable native/cross builds
and installs.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba:

   selftests/ftrace: Check the first record for kprobe_args_type.tc 
(2020-04-24 09:39:26 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.7-rc5

for you to fetch changes up to 66d69e081b526b6a6031f0d3ca8ddff71e5707a5:

   selftests: fix kvm relocatable native/cross builds and installs 
(2020-05-01 09:47:55 -0600)

----------------------------------------------------------------
linux-kselftest-5.7-rc5

This Kselftest update for Linux 5.7-rc5 consists of ftrace test fixes
and fix to kvm Makefile for relocatable native/cross builds and installs.

----------------------------------------------------------------
Alan Maguire (2):
       ftrace/selftests: workaround cgroup RT scheduling issues
       ftrace/selftest: make unresolved cases cause failure if 
--fail-unresolved set

Masami Hiramatsu (1):
       selftests/ftrace: Make XFAIL green color

Shuah Khan (1):
       selftests: fix kvm relocatable native/cross builds and installs

  tools/testing/selftests/ftrace/ftracetest | 32 
+++++++++++++++++++++++++++++--
  tools/testing/selftests/kvm/Makefile      | 29 
+++++++++++++++++++++++++++-
  2 files changed, 58 insertions(+), 3 deletions(-)

----------------------------------------------------------------

--------------DA18C3776462DC6A0D75C49B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.7-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.7-rc5.diff"

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 063ecb290a5a..a4605b5ee66d 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -17,6 +17,7 @@ echo "		-v|--verbose Increase verbosity of test messages"
 echo "		-vv        Alias of -v -v (Show all results in stdout)"
 echo "		-vvv       Alias of -v -v -v (Show all commands immediately)"
 echo "		--fail-unsupported Treat UNSUPPORTED as a failure"
+echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
@@ -29,8 +30,25 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# cgroup RT scheduling prevents chrt commands from succeeding, which
+# induces failures in test wakeup tests.  Disable for the duration of
+# the tests.
+
+readonly sched_rt_runtime=/proc/sys/kernel/sched_rt_runtime_us
+
+sched_rt_runtime_orig=$(cat $sched_rt_runtime)
+
+setup() {
+  echo -1 > $sched_rt_runtime
+}
+
+cleanup() {
+  echo $sched_rt_runtime_orig > $sched_rt_runtime
+}
+
 errexit() { # message
   echo "Error: $1" 1>&2
+  cleanup
   exit $err_ret
 }
 
@@ -39,6 +57,8 @@ if [ `id -u` -ne 0 ]; then
   errexit "this must be run by root user"
 fi
 
+setup
+
 # Utilities
 absdir() { # file_path
   (cd `dirname $1`; pwd)
@@ -93,6 +113,10 @@ parse_opts() { # opts
       UNSUPPORTED_RESULT=1
       shift 1
     ;;
+    --fail-unresolved)
+      UNRESOLVED_RESULT=1
+      shift 1
+    ;;
     --logdir|-l)
       LOG_DIR=$2
       shift 2
@@ -157,6 +181,7 @@ KEEP_LOG=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
+UNRESOLVED_RESULT=0
 STOP_FAILURE=0
 # Parse command-line options
 parse_opts $*
@@ -235,6 +260,7 @@ TOTAL_RESULT=0
 
 INSTANCE=
 CASENO=0
+
 testcase() { # testfile
   CASENO=$((CASENO+1))
   desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
@@ -260,7 +286,7 @@ eval_result() { # sigval
     $UNRESOLVED)
       prlog "	[${color_blue}UNRESOLVED${color_reset}]"
       UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
-      return 1 # this is a kind of bug.. something happened.
+      return $UNRESOLVED_RESULT # depends on use case
     ;;
     $UNTESTED)
       prlog "	[${color_blue}UNTESTED${color_reset}]"
@@ -273,7 +299,7 @@ eval_result() { # sigval
       return $UNSUPPORTED_RESULT # depends on use case
     ;;
     $XFAIL)
-      prlog "	[${color_red}XFAIL${color_reset}]"
+      prlog "	[${color_green}XFAIL${color_reset}]"
       XFAILED_CASES="$XFAILED_CASES $CASENO"
       return 0
     ;;
@@ -406,5 +432,7 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
 prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
 prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 
+cleanup
+
 # if no error, return 0
 exit $TOTAL_RESULT
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 712a2ddd2a27..b728c0a0f9b2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -5,8 +5,34 @@ all:
 
 top_srcdir = ../../../..
 KSFT_KHDR_INSTALL := 1
+
+# For cross-builds to work, UNAME_M has to map to ARCH and arch specific
+# directories and targets in this Makefile. "uname -m" doesn't map to
+# arch specific sub-directory names.
+#
+# UNAME_M variable to used to run the compiles pointing to the right arch
+# directories and build the right targets for these supported architectures.
+#
+# TEST_GEN_PROGS and LIBKVM are set using UNAME_M variable.
+# LINUX_TOOL_ARCH_INCLUDE is set using ARCH variable.
+#
+# x86_64 targets are named to include x86_64 as a suffix and directories
+# for includes are in x86_64 sub-directory. s390x and aarch64 follow the
+# same convention. "uname -m" doesn't result in the correct mapping for
+# s390x and aarch64.
+#
+# No change necessary for x86_64
 UNAME_M := $(shell uname -m)
 
+# Set UNAME_M for arm64 compile/install to work
+ifeq ($(ARCH),arm64)
+	UNAME_M := aarch64
+endif
+# Set UNAME_M s390x compile/install to work
+ifeq ($(ARCH),s390)
+	UNAME_M := s390x
+endif
+
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
@@ -53,7 +79,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
@@ -84,6 +110,7 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
+x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
 

--------------DA18C3776462DC6A0D75C49B--
