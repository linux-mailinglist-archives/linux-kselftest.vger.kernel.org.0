Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D602014CDC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2020 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgA2Pow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jan 2020 10:44:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34788 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA2Pov (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jan 2020 10:44:51 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so230374iof.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2020 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=esAnZQBaKwkjiW91r4Jqm8++mRgXYQrcjauxSAefTQs=;
        b=ExXSgAfz1c5JRtqY0AuFi9QQpEcF2OWoN7JT4napboPCFhLyG70E3ESBe2OQoka19L
         dgXBlvYdP2IafQXpchsf3uKu+6fU6VqIoKWeZGeCAT8tJoX9G6IA4H9xGDod1fICTubI
         futa5/RQUlYIACC2Jj7ebXTZH2M/QVKlMfaLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=esAnZQBaKwkjiW91r4Jqm8++mRgXYQrcjauxSAefTQs=;
        b=fpVxyShA41+WQKWUX7F2q/Jff90AkpBOV/BjYWSa6Sy5U6b5nXN8kfFmhFhjbIwo4M
         O66n/lyVPVpvc4fLsNQBOrOmgmRkhkDrVKgMhoTnAOI5YPqJOEpw+KnAChxu0tTYS9mw
         sQw68qu/KzwNEFZTUssDjinQgueLOGhLePsurttaUmqzw5iVBO0kNLQ4Ojq9czhQ8jKj
         KILtTyEaw1vY3mfsW5VvgRcsCSiU8fax3Kdiej43fkZMYKqUtkDLFdN/ujmSvcF6QF28
         G4jAFeBXUm0oCgt9DzoSaUIXzuNXZS3ji5qLGiWMdIJEiy24mpr0F5W5kOv06f3m3ntT
         jxzQ==
X-Gm-Message-State: APjAAAXJXglot5xxazQjjxE9n5t8lxpuicSRRc3bWpCzbnDCUSvmwc5S
        W119lfTxw+uALjzIJ7WtXq9qDQ==
X-Google-Smtp-Source: APXvYqwbq+TmQZypbiQTysxvbSv+XHY6FkRCmJ5dEZjIqRrNF7v5kvtxt3kZTTTkyGQttzzL+0EAlQ==
X-Received: by 2002:a6b:f913:: with SMTP id j19mr83008iog.124.1580312690025;
        Wed, 29 Jan 2020 07:44:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l8sm618781ioc.42.2020.01.29.07.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 07:44:49 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.6-rc1
Message-ID: <7ecbedec-d72c-62cb-3fd4-192910a8043d@linuxfoundation.org>
Date:   Wed, 29 Jan 2020 08:44:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DFE7F240807E7357421E0404"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------DFE7F240807E7357421E0404
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.6-rc1

This Kselftest update for Linux 5.6-rc1 consists of several fixes to
framework and individual tests. In addition, it enables LKDTM tests
adding lkdtm target to kselftest Makefile.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

   Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.6-rc1

for you to fetch changes up to af4ddd607dff7aabd466a4a878e01b9f592a75ab:

   selftests/ftrace: fix glob selftest (2020-01-28 13:36:48 -0700)

----------------------------------------------------------------
linux-kselftest-5.6-rc1

This Kselftest update for Linux 5.6-rc1 consists of several fixes to
framework and individual tests. In addition, it enables LKDTM tests
adding lkdtm target to kselftest Makefile.

----------------------------------------------------------------
Cristian Marussi (1):
       selftests: fix build behaviour on targets' failures

Dan Carpenter (1):
       selftests: Uninitialized variable in test_cgcore_proc_migration()

Kees Cook (1):
       selftests/lkdtm: Add tests for LKDTM targets

Matthieu Baerts (1):
       selftests: settings: tests can be in subsubdirs

Miroslav Benes (2):
       selftests/livepatch: Replace set_dynamic_debug() with 
setup_config() in README
       selftests/livepatch: Remove unused local variable in 
set_ftrace_enabled()

Siddhesh Poyarekar (1):
       kselftest: Minimise dependency of get_size on C library interfaces

Sven Schnelle (1):
       selftests/ftrace: fix glob selftest

  MAINTAINERS                                        |  1 +
  tools/testing/selftests/Makefile                   | 19 +++--
  tools/testing/selftests/cgroup/test_core.c         |  2 +-
  .../ftrace/test.d/ftrace/func-filter-glob.tc       |  2 +-
  tools/testing/selftests/kselftest/runner.sh        |  2 +-
  tools/testing/selftests/livepatch/README           |  2 +-
  tools/testing/selftests/livepatch/functions.sh     |  1 -
  tools/testing/selftests/lkdtm/Makefile             | 12 +++
  tools/testing/selftests/lkdtm/config               |  1 +
  tools/testing/selftests/lkdtm/run.sh               | 92 
++++++++++++++++++++++
  tools/testing/selftests/lkdtm/tests.txt            | 71 +++++++++++++++++
  tools/testing/selftests/size/get_size.c            | 24 ++++--
  12 files changed, 211 insertions(+), 18 deletions(-)
  create mode 100644 tools/testing/selftests/lkdtm/Makefile
  create mode 100644 tools/testing/selftests/lkdtm/config
  create mode 100755 tools/testing/selftests/lkdtm/run.sh
  create mode 100644 tools/testing/selftests/lkdtm/tests.txt
----------------------------------------------------------------

--------------DFE7F240807E7357421E0404
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.6-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.6-rc1.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..0587fcc197c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9581,6 +9581,7 @@ LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm/*
+F:	tools/testing/selftests/lkdtm/*
 
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b001c602414b..5182d6078cbc 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += kexec
 TARGETS += kvm
 TARGETS += lib
 TARGETS += livepatch
+TARGETS += lkdtm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
@@ -143,11 +144,13 @@ else
 endif
 
 all: khdr
-	@for TARGET in $(TARGETS); do		\
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		mkdir $$BUILD_TARGET  -p;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
-	done;
+	@ret=1;							\
+	for TARGET in $(TARGETS); do				\
+		BUILD_TARGET=$$BUILD/$$TARGET;			\
+		mkdir $$BUILD_TARGET  -p;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;	\
+		ret=$$((ret * $$?));				\
+	done; exit $$ret;
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
@@ -196,10 +199,12 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
-	@for TARGET in $(TARGETS); do \
+	@ret=1;	\
+	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
-	done;
+		ret=$$((ret * $$?));		\
+	done; exit $$ret;
 
 	@# Ask all targets to emit their test scripts
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2b..e19ce940cd6a 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -369,7 +369,7 @@ static void *dummy_thread_fn(void *arg)
 static int test_cgcore_proc_migration(const char *root)
 {
 	int ret = KSFT_FAIL;
-	int t, c_threads, n_threads = 13;
+	int t, c_threads = 0, n_threads = 13;
 	char *src = NULL, *dst = NULL;
 	pthread_t threads[n_threads];
 
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 27a54a17da65..f4e92afab14b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
 ftrace_filter_check 'schedule*' '^schedule.*$'
 
 # filter by *mid*end
-ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+ftrace_filter_check '*pin*lock' '.*pin.*lock$'
 
 # filter by start*mid*
 ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a8d20cbb711c..e84d901f8567 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -91,7 +91,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=$(basename "$PWD")
+	DIR="${PWD#${BASE_DIR}/}"
 	test_num=0
 	total=$(echo "$@" | wc -w)
 	echo "1..$total"
diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
index b73cd0e2dd51..621d325425c2 100644
--- a/tools/testing/selftests/livepatch/README
+++ b/tools/testing/selftests/livepatch/README
@@ -35,7 +35,7 @@ Adding tests
 ------------
 
 See the common functions.sh file for the existing collection of utility
-functions, most importantly set_dynamic_debug() and check_result().  The
+functions, most importantly setup_config() and check_result().  The
 latter function greps the kernel's ring buffer for "livepatch:" and
 "test_klp" strings, so tests be sure to include one of those strings for
 result comparison.  Other utility functions include general module
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index a6e3d5517a6f..2aab9791791d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -64,7 +64,6 @@ function set_dynamic_debug() {
 }
 
 function set_ftrace_enabled() {
-	local sysctl="$1"
 	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
 	echo "livepatch: $result" > /dev/kmsg
 }
diff --git a/tools/testing/selftests/lkdtm/Makefile b/tools/testing/selftests/lkdtm/Makefile
new file mode 100644
index 000000000000..1bcc9ee990eb
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for LKDTM regression tests
+
+include ../lib.mk
+
+# NOTE: $(OUTPUT) won't get default value if used before lib.mk
+TEST_FILES := tests.txt
+TEST_GEN_PROGS = $(patsubst %,$(OUTPUT)/%.sh,$(shell awk '{print $$1}' tests.txt | sed -e 's/\#//'))
+all: $(TEST_GEN_PROGS)
+
+$(OUTPUT)/%: run.sh tests.txt
+	install -m 0744 run.sh $@
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
new file mode 100644
index 000000000000..d874990e442b
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/config
@@ -0,0 +1 @@
+CONFIG_LKDTM=y
diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
new file mode 100755
index 000000000000..dadf819148a4
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# This reads tests.txt for the list of LKDTM tests to invoke. Any marked
+# with a leading "#" are skipped. The rest of the line after the
+# test name is either the text to look for in dmesg for a "success",
+# or the rationale for why a test is marked to be skipped.
+#
+set -e
+TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
+KSELFTEST_SKIP_TEST=4
+
+# Verify we have LKDTM available in the kernel.
+if [ ! -r $TRIGGER ] ; then
+	/sbin/modprobe -q lkdtm || true
+	if [ ! -r $TRIGGER ] ; then
+		echo "Cannot find $TRIGGER (missing CONFIG_LKDTM?)"
+	else
+		echo "Cannot write $TRIGGER (need to run as root?)"
+	fi
+	# Skip this test
+	exit $KSELFTEST_SKIP_TEST
+fi
+
+# Figure out which test to run from our script name.
+test=$(basename $0 .sh)
+# Look up details about the test from master list of LKDTM tests.
+line=$(egrep '^#?'"$test"'\b' tests.txt)
+if [ -z "$line" ]; then
+	echo "Skipped: missing test '$test' in tests.txt"
+	exit $KSELFTEST_SKIP_TEST
+fi
+# Check that the test is known to LKDTM.
+if ! egrep -q '^'"$test"'$' "$TRIGGER" ; then
+	echo "Skipped: test '$test' missing in $TRIGGER!"
+	exit $KSELFTEST_SKIP_TEST
+fi
+
+# Extract notes/expected output from test list.
+test=$(echo "$line" | cut -d" " -f1)
+if echo "$line" | grep -q ' ' ; then
+	expect=$(echo "$line" | cut -d" " -f2-)
+else
+	expect=""
+fi
+
+# If the test is commented out, report a skip
+if echo "$test" | grep -q '^#' ; then
+	test=$(echo "$test" | cut -c2-)
+	if [ -z "$expect" ]; then
+		expect="crashes entire system"
+	fi
+	echo "Skipping $test: $expect"
+	exit $KSELFTEST_SKIP_TEST
+fi
+
+# If no expected output given, assume an Oops with back trace is success.
+if [ -z "$expect" ]; then
+	expect="call trace:"
+fi
+
+# Clear out dmesg for output reporting
+dmesg -c >/dev/null
+
+# Prepare log for report checking
+LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
+cleanup() {
+	rm -f "$LOG"
+}
+trap cleanup EXIT
+
+# Most shells yell about signals and we're expecting the "cat" process
+# to usually be killed by the kernel. So we have to run it in a sub-shell
+# and silence errors.
+($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
+
+# Record and dump the results
+dmesg -c >"$LOG"
+cat "$LOG"
+# Check for expected output
+if egrep -qi "$expect" "$LOG" ; then
+	echo "$test: saw '$expect': ok"
+	exit 0
+else
+	if egrep -qi XFAIL: "$LOG" ; then
+		echo "$test: saw 'XFAIL': [SKIP]"
+		exit $KSELFTEST_SKIP_TEST
+	else
+		echo "$test: missing '$expect': [FAIL]"
+		exit 1
+	fi
+fi
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
new file mode 100644
index 000000000000..92ca32143ae5
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -0,0 +1,71 @@
+#PANIC
+BUG kernel BUG at
+WARNING WARNING:
+WARNING_MESSAGE message trigger
+EXCEPTION
+#LOOP Hangs the system
+#EXHAUST_STACK Corrupts memory on failure
+#CORRUPT_STACK Crashes entire system on success
+#CORRUPT_STACK_STRONG Crashes entire system on success
+CORRUPT_LIST_ADD list_add corruption
+CORRUPT_LIST_DEL list_del corruption
+CORRUPT_USER_DS Invalid address limit on user-mode return
+STACK_GUARD_PAGE_LEADING
+STACK_GUARD_PAGE_TRAILING
+UNSET_SMEP CR4 bits went missing
+DOUBLE_FAULT
+UNALIGNED_LOAD_STORE_WRITE
+#OVERWRITE_ALLOCATION Corrupts memory on failure
+#WRITE_AFTER_FREE Corrupts memory on failure
+READ_AFTER_FREE
+#WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
+READ_BUDDY_AFTER_FREE
+SLAB_FREE_DOUBLE
+SLAB_FREE_CROSS
+SLAB_FREE_PAGE
+#SOFTLOCKUP Hangs the system
+#HARDLOCKUP Hangs the system
+#SPINLOCKUP Hangs the system
+#HUNG_TASK Hangs the system
+EXEC_DATA
+EXEC_STACK
+EXEC_KMALLOC
+EXEC_VMALLOC
+EXEC_RODATA
+EXEC_USERSPACE
+EXEC_NULL
+ACCESS_USERSPACE
+ACCESS_NULL
+WRITE_RO
+WRITE_RO_AFTER_INIT
+WRITE_KERN
+REFCOUNT_INC_OVERFLOW
+REFCOUNT_ADD_OVERFLOW
+REFCOUNT_INC_NOT_ZERO_OVERFLOW
+REFCOUNT_ADD_NOT_ZERO_OVERFLOW
+REFCOUNT_DEC_ZERO
+REFCOUNT_DEC_NEGATIVE Negative detected: saturated
+REFCOUNT_DEC_AND_TEST_NEGATIVE Negative detected: saturated
+REFCOUNT_SUB_AND_TEST_NEGATIVE Negative detected: saturated
+REFCOUNT_INC_ZERO
+REFCOUNT_ADD_ZERO
+REFCOUNT_INC_SATURATED Saturation detected: still saturated
+REFCOUNT_DEC_SATURATED Saturation detected: still saturated
+REFCOUNT_ADD_SATURATED Saturation detected: still saturated
+REFCOUNT_INC_NOT_ZERO_SATURATED
+REFCOUNT_ADD_NOT_ZERO_SATURATED
+REFCOUNT_DEC_AND_TEST_SATURATED Saturation detected: still saturated
+REFCOUNT_SUB_AND_TEST_SATURATED Saturation detected: still saturated
+#REFCOUNT_TIMING timing only
+#ATOMIC_TIMING timing only
+USERCOPY_HEAP_SIZE_TO
+USERCOPY_HEAP_SIZE_FROM
+USERCOPY_HEAP_WHITELIST_TO
+USERCOPY_HEAP_WHITELIST_FROM
+USERCOPY_STACK_FRAME_TO
+USERCOPY_STACK_FRAME_FROM
+USERCOPY_STACK_BEYOND
+USERCOPY_KERNEL
+USERCOPY_KERNEL_DS
+STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
+CFI_FORWARD_PROTO
diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 2ad45b944355..2980b1a63366 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -11,23 +11,35 @@
  * own execution.  It also attempts to have as few dependencies
  * on kernel features as possible.
  *
- * It should be statically linked, with startup libs avoided.
- * It uses no library calls, and only the following 3 syscalls:
+ * It should be statically linked, with startup libs avoided.  It uses
+ * no library calls except the syscall() function for the following 3
+ * syscalls:
  *   sysinfo(), write(), and _exit()
  *
  * For output, it avoids printf (which in some C libraries
  * has large external dependencies) by  implementing it's own
  * number output and print routines, and using __builtin_strlen()
+ *
+ * The test may crash if any of the above syscalls fails because in some
+ * libc implementations (e.g. the GNU C Library) errno is saved in
+ * thread-local storage, which does not get initialized due to avoiding
+ * startup libs.
  */
 
 #include <sys/sysinfo.h>
 #include <unistd.h>
+#include <sys/syscall.h>
 
 #define STDOUT_FILENO 1
 
 static int print(const char *s)
 {
-	return write(STDOUT_FILENO, s, __builtin_strlen(s));
+	size_t len = 0;
+
+	while (s[len] != '\0')
+		len++;
+
+	return syscall(SYS_write, STDOUT_FILENO, s, len);
 }
 
 static inline char *num_to_str(unsigned long num, char *buf, int len)
@@ -79,12 +91,12 @@ void _start(void)
 	print("TAP version 13\n");
 	print("# Testing system size.\n");
 
-	ccode = sysinfo(&info);
+	ccode = syscall(SYS_sysinfo, &info);
 	if (ccode < 0) {
 		print("not ok 1");
 		print(test_name);
 		print(" ---\n reason: \"could not get sysinfo\"\n ...\n");
-		_exit(ccode);
+		syscall(SYS_exit, ccode);
 	}
 	print("ok 1");
 	print(test_name);
@@ -100,5 +112,5 @@ void _start(void)
 	print(" ...\n");
 	print("1..1\n");
 
-	_exit(0);
+	syscall(SYS_exit, 0);
 }

--------------DFE7F240807E7357421E0404--
