Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E4D12D4E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2019 23:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfL3W5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Dec 2019 17:57:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44007 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfL3W5U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Dec 2019 17:57:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so11637450oth.10
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Dec 2019 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sBBrrw22kuSjnl1mPst55HS1k3vPiVxgPrWU23NB7mo=;
        b=Tztuhl0k3dSgivDlNV3t1P3XJTN6aa6BN01VJRNlszeiPxVi5zQslNfi3kZH1ZIcuR
         WVkbClfV2KnskamFYo4RTRNsIjsOAcu7rw/kzz3uwfmc0lPXDFP2i1aKED6jOwh6A6C7
         dqgUvL+yLu4UqzX/A0n60T6N8/u2RRhudcEC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sBBrrw22kuSjnl1mPst55HS1k3vPiVxgPrWU23NB7mo=;
        b=UVsJnGFOivBUUx/TIs+Mm6d145GNpgBFvWKY0FN0NiPL8coo+JLT1GDAQ17OpnO9v5
         KmiHo8RNw2A+nn78B+5/rzn2YbgIq16W/grdDKeyIDQiiNu8BueREoBnyr+NtxAX03aE
         yMDonwpofEVtC1VzLcysXGzg84MHXduMPYdqzlvZfOVlDMGQvp4u4f3uS8XhXMTBZwXx
         y+7OSNGjIbboAxYRkL2EnwWSd66Y+X2uLT86IiKMH5Hs6W2LfzNNJY+XCQ68o7l3uChA
         ISG/DP8PWayRKAIB372hAbPJmq5QfgM+p+RvAh93TttiO3t/8M8I1WZkGKu5GzlJkybY
         JVMg==
X-Gm-Message-State: APjAAAXvzdfPcu/QkJHPuE0YFYg58RzKHqnjR8HMjwKuUzraoo5nDVUw
        kN8Ucadt5DqKow2I2NpYB4+Oew==
X-Google-Smtp-Source: APXvYqz7a5WET3xufZGCo8PqvFOGDR5KCXdj8ov9EEc9lrw3YsKgT0dT/3JamgH75yzigQyQY2hEfw==
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr60726491otp.177.1577746638226;
        Mon, 30 Dec 2019 14:57:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a65sm16251212otb.68.2019.12.30.14.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 14:57:17 -0800 (PST)
Date:   Mon, 30 Dec 2019 14:57:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] selftests/lkdtm: Add tests for LKDTM targets
Message-ID: <201912301453.19D686EE6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds a basic framework for running all the "safe" LKDTM tests. This
will allow easy introspection into any selftest logs to examine the
results of most LKDTM tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: refreshed for v5.5, added new tests since v1
v1: https://lore.kernel.org/lkml/201905091013.E228F0F0BE@keescook/
---
 MAINTAINERS                             |  1 +
 tools/testing/selftests/Makefile        |  1 +
 tools/testing/selftests/lkdtm/Makefile  | 12 ++++
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/run.sh    | 91 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt | 70 +++++++++++++++++++
 6 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/lkdtm/Makefile
 create mode 100644 tools/testing/selftests/lkdtm/config
 create mode 100755 tools/testing/selftests/lkdtm/run.sh
 create mode 100644 tools/testing/selftests/lkdtm/tests.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..eacc00c6cfd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9578,6 +9578,7 @@ LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm/*
+F:	tools/testing/selftests/lkdtm/*
 
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b001c602414b..f0b02a12ba39 100644
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
index 000000000000..793ee0d5d5a3
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -0,0 +1,91 @@
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
+if egrep -qi "$expect" "$LOG" ; then
+	echo "$test: saw '$expect': ok"
+	exit 0
+else
+	if egrep -qi XFAIL: "$LOG" ; then
+		echo "$test: saw 'XFAIL': [SKIP]"
+		exit 4
+	else
+		echo "$test: missing '$expect': [FAIL]"
+		exit 1
+	fi
+fi
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
new file mode 100644
index 000000000000..fc55f8ef8bee
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -0,0 +1,70 @@
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
-- 
2.20.1


-- 
Kees Cook
