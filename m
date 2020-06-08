Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6B1F21A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jun 2020 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgFHVxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Jun 2020 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHVxQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Jun 2020 17:53:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9CC08C5C2
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Jun 2020 14:53:15 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v13so14973050otp.4
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jun 2020 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=P0e4Qtfee5PLNZW89c3vmeVGsvQYeJAMKOzqAOnsokQ=;
        b=XYtkjH2yhUhKLDMfvKbtdMOowMjh+taXYRaoyO1RMTxa/tLM/oYuLHIcEVOQ9PChPo
         o+e4aJJv7KTwRFd0gVLhyyBrsbJZ34SQc/ziNG4VbdFRN/+STeDAcOGvYqPVBaA12cT6
         3dILKgIQeEb1D2I360Fq3eB92+2wKgFYkov/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=P0e4Qtfee5PLNZW89c3vmeVGsvQYeJAMKOzqAOnsokQ=;
        b=gnGujWPlKiTUFPyr780b183FGmqDZ0silEJgfF1Zk6j9YcTcQ9acn09pE8UX60x9wM
         /RVWYnJD/GFglGcX98jDUxClgX3cRmONiGN1JOnhfNan0r0aKllkcDJjvIJocP1UHCL2
         SdWqM+sOlARRnyxasW8OW4ZSxKsLsWQP+MmiDfA6bXlBTd6ZLdrc2U8rx1jB66xpnwfk
         hyrtYUlbUAbwswrYzV78sSG/qIGk6OzMiUhk93EvAl9wPrbUbILl3ulF9hgBrbhTLW1k
         KoY+82mAPXM5AuIcZfy9mDGcm8lRV96Xi28LdiVGtFioYtHQjDA8/+Re3W5iLYbuUO4z
         d9bg==
X-Gm-Message-State: AOAM532sC+/gWbjvH7u1KqGB3ZHu26S+1AFoUSR1dv4AUPKV0DAvE3DR
        B3kD5gFyOd3z9lPAVHFRvS+INZDZROw=
X-Google-Smtp-Source: ABdhPJyLMGoyef2Lcde0Gqxop50kwKDaThjWAsdVkDYM1i+Q/ZMzELr/YbawXnalovQAOHesU2WgoA==
X-Received: by 2002:a05:6830:19d3:: with SMTP id p19mr12449127otp.176.1591653194819;
        Mon, 08 Jun 2020 14:53:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 33sm1794864ott.0.2020.06.08.14.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 14:53:14 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, vbabka@suse.cz
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.8-rc1
Message-ID: <9e5f53d8-ecc7-5d78-e232-3f525541bf88@linuxfoundation.org>
Date:   Mon, 8 Jun 2020 15:53:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9530114B82D05A0A3E51D6BA"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------9530114B82D05A0A3E51D6BA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.8-rc1.

This Kselftest update for Linux 5.8-rc1 consists of:

- Several fixes from Masami Hiramatsu to improve coverage for
   lib and sysctl tests.
- Clean up to vdso test and a new test for getcpu() from Mark Brown.
- Add new gen_tar selftests Makefile target generate selftest package
   running "make gen_tar" in selftests directory from Veronika Kabatova.
- Other miscellaneous fixes to timens, exec, tpm2 tests.

diff is attached.

Please note that there is a conflict in
tools/testing/selftests/sysctl/sysctl.sh

between commit:

   eee470e0739a ("selftests/sysctl: Fix to load test_sysctl module")

from the kselftest tree and patch:

   "tools/testing/selftests/sysctl/sysctl.sh: support CONFIG_TEST_SYSCTL=y"

Stephen fixed this up in linux-next. Masami double checked the fix.
Please let me know if you see any problems and would like me to
address them.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

   Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.8-rc1

for you to fetch changes up to 382561a0f11c4995d48ab82670412f8d6c418430:

   selftests/sysctl: Make sysctl test driver as a module (2020-06-02 
10:27:02 -0600)

----------------------------------------------------------------
linux-kselftest-5.8-rc1

This Kselftest update for Linux 5.8-rc1 consists of:

- Several fixes from Masami Hiramatsu to improve coverage for
   lib and sysctl tests.
- Clean up to vdso test and a new test for getcpu() from Mark Brown.
- Add new gen_tar selftests Makefile target generate selftest package
   running "make gen_tar" in selftests directory from Veronika Kabatova.
- Other miscellaneous fixes to timens, exec, tpm2 tests.

----------------------------------------------------------------
Andrei Vagin (1):
       selftests/timens: handle a case when alarm clocks are not supported

Kees Cook (1):
       selftests/exec: Verify execve of non-regular files fail

Mark Brown (3):
       selftests: vdso: Rename vdso_test to vdso_test_gettimeofday
       selftests: vdso: Use a header file to prototype parse_vdso API
       selftests: vdso: Add a selftest for vDSO getcpu()

Masami Hiramatsu (6):
       selftests/ftrace: Use printf for backslash included command
       selftests/ftrace: Return unsupported if no error_log file
       lib: Make prime number generator independently selectable
       lib: Make test_sysctl initialized as module
       selftests/sysctl: Fix to load test_sysctl module
       selftests/sysctl: Make sysctl test driver as a module

Nikita Sobolev (1):
       Kernel selftests: Add check if TPM devices are supported

Veronika Kabatova (1):
       selftests: introduce gen_tar Makefile target

  Documentation/dev-tools/kselftest.rst              | 23 +++++++++
  lib/math/Kconfig                                   |  7 ++-
  lib/test_sysctl.c                                  |  2 +-
  tools/testing/selftests/Makefile                   |  9 +++-
  tools/testing/selftests/exec/.gitignore            |  1 +
  tools/testing/selftests/exec/Makefile              |  2 +-
  tools/testing/selftests/exec/execveat.c            |  8 ++++
  .../ftrace/test.d/ftrace/tracing-error-log.tc      |  2 +
tools/testing/selftests/ftrace/test.d/functions    |  8 ++--
  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  4 +-
  tools/testing/selftests/gen_kselftest_tar.sh       |  5 ++
  tools/testing/selftests/sysctl/config              |  2 +-
  tools/testing/selftests/sysctl/sysctl.sh           | 13 +-----
  tools/testing/selftests/timens/clock_nanosleep.c   |  2 +-
  tools/testing/selftests/timens/timens.c            |  2 +-
  tools/testing/selftests/timens/timens.h            | 13 +++++-
  tools/testing/selftests/timens/timer.c             |  5 ++
  tools/testing/selftests/timens/timerfd.c           |  5 ++
  tools/testing/selftests/tpm2/test_smoke.sh         |  5 ++
  tools/testing/selftests/tpm2/test_space.sh         |  5 ++
  tools/testing/selftests/vDSO/.gitignore            |  2 +
  tools/testing/selftests/vDSO/Makefile              |  5 +-
  tools/testing/selftests/vDSO/parse_vdso.c          | 24 +---------
  tools/testing/selftests/vDSO/parse_vdso.h          | 31 +++++++++++++
  .../selftests/vDSO/vdso_standalone_test_x86.c      |  4 +-
  tools/testing/selftests/vDSO/vdso_test_getcpu.c    | 54 
++++++++++++++++++++++
  .../vDSO/{vdso_test.c => vdso_test_gettimeofday.c} | 10 ++--
  27 files changed, 196 insertions(+), 57 deletions(-)
  create mode 100644 tools/testing/selftests/vDSO/parse_vdso.h
  create mode 100644 tools/testing/selftests/vDSO/vdso_test_getcpu.c
  rename tools/testing/selftests/vDSO/{vdso_test.c => 
vdso_test_gettimeofday.c} (84%)

----------------------------------------------------------------

--------------9530114B82D05A0A3E51D6BA
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.8-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.8-rc1.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 61ae13c44f91..d4f6341cf4d9 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -151,6 +151,29 @@ note some tests will require root privileges::
    $ cd kselftest
    $ ./run_kselftest.sh
 
+Packaging selftests
+===================
+
+In some cases packaging is desired, such as when tests need to run on a
+different system. To package selftests, run::
+
+   $ make -C tools/testing/selftests gen_tar
+
+This generates a tarball in the `INSTALL_PATH/kselftest-packages` directory. By
+default, `.gz` format is used. The tar format can be overridden by specifying
+a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_ option
+is supported, such as::
+
+    $ make -C tools/testing/selftests gen_tar FORMAT=.xz
+
+`make gen_tar` invokes `make install` so you can use it to package a subset of
+tests by using variables specified in `Running a subset of selftests`_
+section::
+
+    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
+
+.. _tar's auto-compress: https://www.gnu.org/software/tar/manual/html_node/gzip.html#auto_002dcompress
+
 Contributing new tests
 ======================
 
diff --git a/lib/math/Kconfig b/lib/math/Kconfig
index 15bd50d92308..f19bc9734fa7 100644
--- a/lib/math/Kconfig
+++ b/lib/math/Kconfig
@@ -6,7 +6,12 @@ config CORDIC
 	  calculations are in fixed point. Module will be called cordic.
 
 config PRIME_NUMBERS
-	tristate
+	tristate "Simple prime number generator for testing"
+	help
+	  This option provides a simple prime number generator for test
+	  modules.
+
+	  If unsure, say N.
 
 config RATIONAL
 	bool
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 566dad3f4196..ec4d0f03475d 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -149,7 +149,7 @@ static int __init test_sysctl_init(void)
 	}
 	return 0;
 }
-late_initcall(test_sysctl_init);
+module_init(test_sysctl_init);
 
 static void __exit test_sysctl_exit(void)
 {
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2ff68702fd41..1195bd85af38 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -249,10 +249,17 @@ else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
+FORMAT ?= .gz
+TAR_PATH = $(abspath ${INSTALL_PATH}/kselftest-packages/kselftest.tar${FORMAT})
+gen_tar: install
+	@mkdir -p ${INSTALL_PATH}/kselftest-packages/
+	@tar caf ${TAR_PATH} --exclude=kselftest-packages -C ${INSTALL_PATH} .
+	@echo "Created ${TAR_PATH}"
+
 clean:
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
+.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index c078ece12ff0..94b02a18f230 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,3 +9,4 @@ execveat.ephemeral
 execveat.denatured
 /recursion-depth
 xxxxxxxx*
+pipe
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 33339e31e365..cfafa1f8a2fa 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS := execveat
-TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
+TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index cbb6efbdb786..67bf7254a48f 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -5,7 +5,9 @@
  * Selftests for execveat(2).
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE  /* to get O_PATH, AT_EMPTY_PATH */
+#endif
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -311,6 +313,10 @@ static int run_tests(void)
 	fail += check_execveat_fail(AT_FDCWD, fullname_symlink,
 				    AT_SYMLINK_NOFOLLOW, ELOOP);
 
+	/*  Non-regular file failure */
+	fail += check_execveat_fail(dot_dfd, "pipe", 0, EACCES);
+	unlink("pipe");
+
 	/* Shell script wrapping executable file: */
 	/*   dfd + path */
 	fail += check_execveat(subdir_dfd, "../script", 0);
@@ -384,6 +390,8 @@ static void prerequisites(void)
 	fd = open("subdir.ephemeral/script", O_RDWR|O_CREAT|O_TRUNC, 0755);
 	write(fd, script, strlen(script));
 	close(fd);
+
+	mkfifo("pipe", 0755);
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
index 021c03fd885d..23465823532b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -14,6 +14,8 @@ if [ ! -f set_event ]; then
     exit_unsupported
 fi
 
+[ -f error_log ] || exit_unsupported
+
 ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
 
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 61a3c7e2634d..697c77ef2e2b 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -119,12 +119,14 @@ yield() {
     ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
 
+# Since probe event command may include backslash, explicitly use printf "%s"
+# to NOT interpret it.
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
-    pos=$(echo -n "${2%^*}" | wc -c) # error position
-    command=$(echo "$2" | tr -d ^)
+    pos=$(printf "%s" "${2%^*}" | wc -c) # error position
+    command=$(printf "%s" "$2" | tr -d ^)
     echo "Test command: $command"
     echo > error_log
-    (! echo "$command" >> "$3" ) 2> /dev/null
+    (! printf "%s" "$command" >> "$3" ) 2> /dev/null
     grep "$1: error:" -A 3 error_log
     N=$(tail -n 1 error_log | wc -c)
     # "  Command: " and "^\n" => 13
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index ef1e9bafb098..eb0f4ab4e070 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -91,7 +91,9 @@ esac
 if grep -q "Create/append/" README && grep -q "imm-value" README; then
 echo 'p:kprobes/testevent _do_fork' > kprobe_events
 check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
-echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
 check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing/selftests/gen_kselftest_tar.sh
index 8b2b6088540d..4a974bc03385 100755
--- a/tools/testing/selftests/gen_kselftest_tar.sh
+++ b/tools/testing/selftests/gen_kselftest_tar.sh
@@ -49,6 +49,11 @@ main()
 	# directory
 	./kselftest_install.sh "$install_dir"
 	(cd "$install_work"; tar $copts "$dest"/kselftest${ext} $install_name)
+
+	# Don't put the message at the actual end as people may be parsing the
+	# "archive created" line in their scripts.
+	echo -e "\nConsider using 'make gen_tar' instead of this script\n"
+
 	echo "Kselftest archive kselftest${ext} created!"
 
 	# clean up top-level install work directory
diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
index 6ca14800d755..fc263efd1fad 100644
--- a/tools/testing/selftests/sysctl/config
+++ b/tools/testing/selftests/sysctl/config
@@ -1 +1 @@
-CONFIG_TEST_SYSCTL=y
+CONFIG_TEST_SYSCTL=m
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 6a970b127c9b..c3459f9f2429 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -40,16 +40,6 @@ ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
 ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
 ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
 
-test_modprobe()
-{
-       if [ ! -d $DIR ]; then
-               echo "$0: $DIR not present" >&2
-               echo "You must have the following enabled in your kernel:" >&2
-               cat $TEST_DIR/config >&2
-               exit $ksft_skip
-       fi
-}
-
 function allow_user_defaults()
 {
 	if [ -z $DIR ]; then
@@ -125,10 +115,12 @@ function load_req_mod()
 	if [ ! -d $DIR ]; then
 		if ! modprobe -q -n $TEST_DRIVER; then
 			echo "$0: module $TEST_DRIVER not found [SKIP]"
+			echo "You must set CONFIG_TEST_SYSCTL=m in your kernel" >&2
 			exit $ksft_skip
 		fi
 		modprobe $TEST_DRIVER
 		if [ $? -ne 0 ]; then
+			echo "$0: modprobe $TEST_DRIVER failed."
 			exit
 		fi
 	fi
@@ -929,7 +921,6 @@ test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
 load_req_mod
-test_modprobe
 
 trap "test_finish" EXIT
 
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 8e7b7c72ef65..72d41b955fb2 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 
 	ksft_set_plan(4);
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	if (unshare_timens())
 		return 1;
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 098be7c83be3..52b6a1185f52 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
 
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
index e09e7e39bc52..d4fc52d47146 100644
--- a/tools/testing/selftests/timens/timens.h
+++ b/tools/testing/selftests/timens/timens.h
@@ -14,15 +14,26 @@
 #endif
 
 static int config_posix_timers = true;
+static int config_alarm_timers = true;
 
-static inline void check_config_posix_timers(void)
+static inline void check_supported_timers(void)
 {
+	struct timespec ts;
+
 	if (timer_create(-1, 0, 0) == -1 && errno == ENOSYS)
 		config_posix_timers = false;
+
+	if (clock_gettime(CLOCK_BOOTTIME_ALARM, &ts) == -1 && errno == EINVAL)
+		config_alarm_timers = false;
 }
 
 static inline bool check_skip(int clockid)
 {
+	if (!config_alarm_timers && clockid == CLOCK_BOOTTIME_ALARM) {
+		ksft_test_result_skip("CLOCK_BOOTTIME_ALARM isn't supported\n");
+		return true;
+	}
+
 	if (config_posix_timers)
 		return false;
 
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 96dba11ebe44..5e7f0051bd7b 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -22,6 +22,9 @@ int run_test(int clockid, struct timespec now)
 	timer_t fd;
 	int i;
 
+	if (check_skip(clockid))
+		return 0;
+
 	for (i = 0; i < 2; i++) {
 		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
 		int flags = 0;
@@ -74,6 +77,8 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
+	check_supported_timers();
+
 	ksft_set_plan(3);
 
 	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index eff1ec5ff215..9edd43d6b2c1 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -28,6 +28,9 @@ int run_test(int clockid, struct timespec now)
 	long long elapsed;
 	int fd, i;
 
+	if (check_skip(clockid))
+		return 0;
+
 	if (tclock_gettime(clockid, &now))
 		return pr_perror("clock_gettime(%d)", clockid);
 
@@ -81,6 +84,8 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
+	check_supported_timers();
+
 	ksft_set_plan(3);
 
 	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..663062701d5a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
 
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index a6f5e346635e..36c9d030a1c6 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,4 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpmrm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SpaceTest
diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 382cfb39a1a3..5eb64d41e541 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
+vdso_test_gettimeofday
+vdso_test_getcpu
 vdso_standalone_test_x86
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 9e03d61f52fd..0069f2f83f86 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,7 @@ include ../lib.mk
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-TEST_GEN_PROGS := $(OUTPUT)/vdso_test
+TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 ifeq ($(ARCH),x86)
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
@@ -17,7 +17,8 @@ LDLIBS += -lgcc_s
 endif
 
 all: $(TEST_GEN_PROGS)
-$(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
+$(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
+$(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 1dbb4b87268f..413f75620a35 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -21,29 +21,7 @@
 #include <limits.h>
 #include <elf.h>
 
-/*
- * To use this vDSO parser, first call one of the vdso_init_* functions.
- * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
- * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
- * Then call vdso_sym for each symbol you want.  For example, to look up
- * gettimeofday on x86_64, use:
- *
- *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
- * or
- *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
- *
- * vdso_sym will return 0 if the symbol doesn't exist or if the init function
- * failed or was not called.  vdso_sym is a little slow, so its return value
- * should be cached.
- *
- * vdso_sym is threadsafe; the init functions are not.
- *
- * These are the prototypes:
- */
-extern void vdso_init_from_auxv(void *auxv);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void *vdso_sym(const char *version, const char *name);
-
+#include "parse_vdso.h"
 
 /* And here's the code. */
 #ifndef ELF_BITS
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selftests/vDSO/parse_vdso.h
new file mode 100644
index 000000000000..de0453067d7c
--- /dev/null
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef PARSE_VDSO_H
+#define PARSE_VDSO_H
+
+#include <stdint.h>
+
+/*
+ * To use this vDSO parser, first call one of the vdso_init_* functions.
+ * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
+ * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
+ * Then call vdso_sym for each symbol you want.  For example, to look up
+ * gettimeofday on x86_64, use:
+ *
+ *     <some pointer> = vdso_sym("LINUX_2.6", "gettimeofday");
+ * or
+ *     <some pointer> = vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
+ *
+ * vdso_sym will return 0 if the symbol doesn't exist or if the init function
+ * failed or was not called.  vdso_sym is a little slow, so its return value
+ * should be cached.
+ *
+ * vdso_sym is threadsafe; the init functions are not.
+ *
+ * These are the prototypes:
+ */
+void *vdso_sym(const char *version, const char *name);
+void vdso_init_from_sysinfo_ehdr(uintptr_t base);
+void vdso_init_from_auxv(void *auxv);
+
+#endif
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 5ac4b00acfbc..8a44ff973ee1 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -16,9 +16,7 @@
 #include <unistd.h>
 #include <stdint.h>
 
-extern void *vdso_sym(const char *version, const char *name);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void vdso_init_from_auxv(void *auxv);
+#include "parse_vdso.h"
 
 /* We need a libc functions... */
 int strcmp(const char *a, const char *b)
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
new file mode 100644
index 000000000000..fc25ede131b8
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vdso_test_getcpu.c: Sample code to test parse_vdso.c and vDSO getcpu()
+ *
+ * Copyright (c) 2020 Arm Ltd
+ */
+
+#include <stdint.h>
+#include <elf.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <sys/time.h>
+
+#include "../kselftest.h"
+#include "parse_vdso.h"
+
+const char *version = "LINUX_2.6";
+const char *name = "__vdso_getcpu";
+
+struct getcpu_cache;
+typedef long (*getcpu_t)(unsigned int *, unsigned int *,
+			 struct getcpu_cache *);
+
+int main(int argc, char **argv)
+{
+	unsigned long sysinfo_ehdr;
+	unsigned int cpu, node;
+	getcpu_t get_cpu;
+	long ret;
+
+	sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
+	}
+
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
+
+	get_cpu = (getcpu_t)vdso_sym(version, name);
+	if (!get_cpu) {
+		printf("Could not find %s\n", name);
+		return KSFT_SKIP;
+	}
+
+	ret = get_cpu(&cpu, &node, 0);
+	if (ret == 0) {
+		printf("Running on CPU %u node %u\n", cpu, node);
+	} else {
+		printf("%s failed\n", name);
+		return KSFT_FAIL;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
similarity index 84%
rename from tools/testing/selftests/vDSO/vdso_test.c
rename to tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index 719d5a6bd664..8ccc73ed8240 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * vdso_test.c: Sample code to test parse_vdso.c
+ * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
+ *                           vDSO gettimeofday()
  * Copyright (c) 2014 Andy Lutomirski
  *
  * Compile with:
- * gcc -std=gnu99 vdso_test.c parse_vdso.c
+ * gcc -std=gnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
  *
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, too.
  */
@@ -16,10 +17,7 @@
 #include <sys/time.h>
 
 #include "../kselftest.h"
-
-extern void *vdso_sym(const char *version, const char *name);
-extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-extern void vdso_init_from_auxv(void *auxv);
+#include "parse_vdso.h"
 
 /*
  * ARM64's vDSO exports its gettimeofday() implementation with a different

--------------9530114B82D05A0A3E51D6BA--
