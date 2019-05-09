Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3260F18EBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 19:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEIROJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 13:14:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37386 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEIROJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 13:14:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so1655150pfi.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2019 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=S42wLF8DqiazmIgnqiYi8pJSaWpKh/ng4T41SuYQhkk=;
        b=Z1AdviOY+UrNYpqr8+dHD6vOBj1ZXwomyMMvpcDNBOn4PRJZ+gEF3bz9dnkyMXetXs
         U2tMrTb447RqV8zv59to0oIcXjzkDStbK25LAyuDE95s2JrT8wMtU9/ePvDjgIENErCP
         oI+LOH5X5LYwEN0kI0gcl1XTxZ4+TDFOwk+C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=S42wLF8DqiazmIgnqiYi8pJSaWpKh/ng4T41SuYQhkk=;
        b=hLgZvE93q/JuhwvzTsMtLBO9WmxczV5tqU8rODUniKACDLs5DnfUgblciVaICcaJi8
         y1G8a/r52fX4pxrszJ3qzn8wCRvmMSV6mwjukuxbZO+eECZPo0hX+Px7jc+Ua7yi6poB
         boAgLVHACjygBPxOmftTv+EQjyTFP/BWuxqW5nIlfBErTA0EBzaRXkmQ+OHy+60ogfq2
         +ic+rp4UmQ9oLY7iquDHB1VCLmWzmk4xi4TahMk2aebvlschnAn/Yy0X9tyFdt5Zaffi
         stFFhHoY4qaFm7nN4xFlOAAQHXi8o/osjDF/F52MXHXbqupoGdNg3DuoKFO+ZKoJgtn9
         q6vw==
X-Gm-Message-State: APjAAAWG5Kd8Rpn5JoJtIwjpgoY9eJDcd4uZrrjpoxm+trMIvbkDJOlM
        kt+TxBYGX3iLoMuqnUYYmTqgUTmsbs4=
X-Google-Smtp-Source: APXvYqzEpGjEEQr9wRCziFPQerirAmhYX1TfzqvbhYjF9dVM1aJn7ynTkvg809wHw1VvkjJpyYdH7Q==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr6993575pgm.358.1557422047739;
        Thu, 09 May 2019 10:14:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm7744824pgq.1.2019.05.09.10.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:14:06 -0700 (PDT)
Date:   Thu, 9 May 2019 10:14:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/lkdtm: Add tests for LKDTM targets
Message-ID: <201905091013.E228F0F0BE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds a basic framework for running all the "safe" lkdtm tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS                             |  1 +
 tools/testing/selftests/Makefile        |  1 +
 tools/testing/selftests/lkdtm/Makefile  | 11 ++++
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/run.sh    | 86 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt | 64 ++++++++++++++++++
 6 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/lkdtm/Makefile
 create mode 100644 tools/testing/selftests/lkdtm/config
 create mode 100755 tools/testing/selftests/lkdtm/run.sh
 create mode 100644 tools/testing/selftests/lkdtm/tests.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c2fce72e694..055f1a09b1da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8977,6 +8977,7 @@ LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm/*
+F:	tools/testing/selftests/lkdtm/*
 
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..c2397baeb777 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -23,6 +23,7 @@ TARGETS += kcmp
 TARGETS += kvm
 TARGETS += lib
 TARGETS += livepatch
+TARGETS += lkdtm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/lkdtm/Makefile b/tools/testing/selftests/lkdtm/Makefile
new file mode 100644
index 000000000000..f322d281fd8e
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for LKDTM regression tests
+
+include ../lib.mk
+
+# NOTE: $(OUTPUT) won't get default value if used before lib.mk
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
index 000000000000..117349bf78ca
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# This reads tests.txt for the list of LKDTM tests to invoke. Any marked
+# with a leading "#" are skipped. The line after the test name is either
+# the text to look for in dmesg for a "success", or the rationale for why
+# a test is marked to be skipped.
+#
+set -e
+TRIGGER=/sys/kernel/debug/provoke-crash/DIRECT
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
+	exit 4
+fi
+
+# Figure out which test to run from our script name.
+test=$(basename $0 .sh)
+# Look up details about the test from master list of LKDTM tests.
+line=$(egrep '^#?'"$test"'\b' tests.txt)
+if [ -z "$line" ]; then
+	echo "Skipped: missing test '$test' in tests.txt"
+	exit 4
+fi
+# Check that the test is known to LKDTM.
+if ! egrep -q '^'"$test"'$' "$TRIGGER" ; then
+	echo "Skipped: test '$test' missing in $TRIGGER!"
+	exit 4
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
+	exit 4
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
+if grep -qi "$expect" "$LOG" ; then
+	echo "$test: saw '$expect': ok"
+	exit 0
+else
+	echo "$test: missing '$expect': [FAIL]"
+	exit 1
+fi
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
new file mode 100644
index 000000000000..59df8a23db45
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -0,0 +1,64 @@
+#PANIC
+BUG kernel BUG at
+WARNING WARNING:
+EXCEPTION BUG: unable to handle kernel
+#LOOP Hangs the system
+#EXHAUST_STACK Corrupts memory on failure
+#CORRUPT_STACK Crashes entire system on success
+#CORRUPT_STACK_STRONG Crashes entire system on success
+CORRUPT_LIST_ADD list_add corruption
+CORRUPT_LIST_DEL list_del corruption
+CORRUPT_USER_DS Invalid address limit on user-mode return
+STACK_GUARD_PAGE_LEADING
+STACK_GUARD_PAGE_TRAILING
+UNALIGNED_LOAD_STORE_WRITE
+#OVERWRITE_ALLOCATION Corrupts memory on failure
+#WRITE_AFTER_FREE Corrupts memory on failure
+READ_AFTER_FREE
+#WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
+READ_BUDDY_AFTER_FREE
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
-- 
2.17.1


-- 
Kees Cook
