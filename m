Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452481A8D93
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633790AbgDNVWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633788AbgDNVWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 17:22:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD12C061A0E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 14:22:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so11483300ioe.10
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilwZvdttSDEf//UskpYPZ2Zul+38PvYFS4ITo0BhVJA=;
        b=iWtWvCpFojn+zp72PxXsySj8a1IOuguJWRadY2He89g2jKfIrkDIDsZxFKL266KGki
         VYt1qRq7ugoU9K4KY7Px5/NNCBfQ1fIiDGwwyuvslEupGI/fPEvW040+9Xk50MTZ7qCg
         SVeBk8S2orjp+O9htqCVs4kx+7F5x4QyWIjH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ilwZvdttSDEf//UskpYPZ2Zul+38PvYFS4ITo0BhVJA=;
        b=I4AlkXkNWg5YgtQPcoBrg4ML5rgL4zjSSvB2NZBAxgK/QPUVmbCc42OrFp102uh9gh
         pLcFPL7IqrE+4azS5oer8W2WiHmA9xjVCAdzM/JPpHuQG1T4mfoiIrMHwVC1bPa7Se8s
         C6AdONTeN6/UdDdPBV0WzE1ODLvClAAqXChJ1fqgbXjbo7FV9b9nvrsXUlNJs8g3lwyq
         mz1WmIsYfse8isLIHJEuXtHU0hAcAWWdiB4ljSg1tNrECfXYwC69o6yqugUj47sNVHxK
         uumPh+7m1uVHZwz0sRqw9WESDnkukb4A6wVmJnFJMRvi03u6YEoUX3Fl+4ctwxSq6q42
         aBxw==
X-Gm-Message-State: AGi0PuZaAFVoF8Bo+fHCFVscpUrxw5s/jjN28GkUqzsv89yBykMLh10z
        kSnyY0jPt1XUC7dis5nomRObJw==
X-Google-Smtp-Source: APiQypL/Ae/ff0zNVb9OVOr0KWtWAAM2/DX8BUZnYx+4o1BcRxeK60TWgr07hBr4eYrJYptq/2yxcA==
X-Received: by 2002:a05:6602:1da:: with SMTP id w26mr23430071iot.191.1586899331545;
        Tue, 14 Apr 2020 14:22:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q29sm5217326ill.65.2020.04.14.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:22:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, bamv2005@gmail.com, skhan@linuxfoundation.org,
        khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: add build/cross-build dependency check script
Date:   Tue, 14 Apr 2020 15:22:08 -0600
Message-Id: <20200414212208.21667-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add build/cross-build dependency check script kselftest_deps.sh
This script does the following:

Usage: ./kselftest_deps.sh -[p] <compiler> [test_name]

	kselftest_deps.sh [-p] gcc
	kselftest_deps.sh [-p] gcc vm
	kselftest_deps.sh [-p] aarch64-linux-gnu-gcc
	kselftest_deps.sh [-p] aarch64-linux-gnu-gcc vm

- Should be run in selftests directory in the kernel repo.
- Checks if Kselftests can be built/cross-built on a system.
- Parses all test/sub-test Makefile to find library dependencies.
- Runs compile test on a trivial C file with LDLIBS specified
  in the test Makefiles to identify missing library dependencies.
- Prints suggested target list for a system filtering out tests
  failed the build dependency check from the TARGETS in Selftests
  the main Makefile when optional -p is specified.
- Prints pass/fail dependency check for each tests/sub-test.
- Prints pass/fail targets and libraries.
- Default: runs dependency checks on all tests.
- Optional test name can be specified to check dependencies for it.

To make LDLIBS parsing easier
- change gpio and memfd Makefiles to use the same temporary variable used
  to find and add libraries to LDLIBS.
- simlify LDLIBS append logic in intel_pstate/Makefile.

Results from run on x86_64 system (trimmed detailed pass/fail list):
========================================================
Kselftest Dependency Check for [./kselftest_deps.sh gcc ] results...
========================================================
Checked tests defining LDLIBS dependencies
--------------------------------------------------------
Total tests with Dependencies:
55 Pass: 53 Fail: 2
--------------------------------------------------------
Targets passed build dependency check on system:
bpf capabilities filesystems futex gpio intel_pstate membarrier memfd
mqueue net powerpc ptp rseq rtc safesetid timens timers vDSO vm
--------------------------------------------------------
FAIL: netfilter/Makefile dependency check: -lmnl
FAIL: gpio/Makefile dependency check: -lmount
--------------------------------------------------------
Targets failed build dependency check on system:
gpio netfilter
--------------------------------------------------------
Missing libraries system
-lmnl -lmount
--------------------------------------------------------
========================================================

Results from run on x86_64 system with aarch64-linux-gnu-gcc:
(trimmed detailed pass/fail list):
========================================================
Kselftest Dependency Check for [./kselftest_deps.sh aarch64-linux-gnu-gcc ]
results...
========================================================
Checked tests defining LDLIBS dependencies
--------------------------------------------------------
Total tests with Dependencies:
55 Pass: 41 Fail: 14
--------------------------------------------------------
Targets failed build dependency check on system:
bpf capabilities filesystems futex gpio intel_pstate membarrier memfd
mqueue net powerpc ptp rseq rtc timens timers vDSO vm
--------------------------------------------------------
--------------------------------------------------------
Targets failed build dependency check on system:
bpf capabilities gpio memfd mqueue net netfilter safesetid vm
--------------------------------------------------------
Missing libraries system
-lcap -lcap-ng -lelf -lfuse -lmnl -lmount -lnuma -lpopt -lz
--------------------------------------------------------
========================================================

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/gpio/Makefile         |  12 +-
 tools/testing/selftests/intel_pstate/Makefile |   2 +-
 tools/testing/selftests/kselftest_deps.sh     | 272 ++++++++++++++++++
 tools/testing/selftests/memfd/Makefile        |  14 +-
 4 files changed, 291 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/kselftest_deps.sh

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 0bb80619db58..32bdc978a711 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
-MOUNT_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
-MOUNT_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
-ifeq ($(MOUNT_LDLIBS),)
-MOUNT_LDLIBS := -lmount -I/usr/include/libmount
+VAR_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
+VAR_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lmount -I/usr/include/libmount
 endif
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
-LDLIBS += $(MOUNT_LDLIBS)
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
+LDLIBS += $(VAR_LDLIBS)
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 7340fd6a9a9f..39f0fa2a8fd6 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
-LDLIBS := $(LDLIBS) -lm
+LDLIBS += -lm
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
new file mode 100755
index 000000000000..bb9c22e7af0e
--- /dev/null
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -0,0 +1,272 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# kselftest_deps.sh
+#
+# Checks for kselftest build dependencies on the build system.
+# Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+#
+#
+
+usage()
+{
+
+echo -e "Usage: $0 -[p] <compiler> [test_name]\n"
+echo -e "\tkselftest_deps.sh [-p] gcc"
+echo -e "\tkselftest_deps.sh [-p] gcc vm"
+echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc"
+echo -e "\tkselftest_deps.sh [-p] aarch64-linux-gnu-gcc vm\n"
+echo "- Should be run in selftests directory in the kernel repo."
+echo "- Checks if Kselftests can be built/cross-built on a system."
+echo "- Parses all test/sub-test Makefile to find library dependencies."
+echo "- Runs compile test on a trivial C file with LDLIBS specified"
+echo "  in the test Makefiles to identify missing library dependencies."
+echo "- Prints suggested target list for a system filtering out tests"
+echo "  failed the build dependency check from the TARGETS in Selftests"
+echo "  main Makefile when optional -p is specified."
+echo "- Prints pass/fail dependency check for each tests/sub-test."
+echo "- Prints pass/fail targets and libraries."
+echo "- Default: runs dependency checks on all tests."
+echo "- Optional test name can be specified to check dependencies for it."
+exit 1
+
+}
+
+# Start main()
+main()
+{
+
+base_dir=`pwd`
+# Make sure we're in the selftests top-level directory.
+if [ $(basename "$base_dir") !=  "selftests" ]; then
+	echo -e "\tPlease run $0 in"
+	echo -e "\ttools/testing/selftests directory ..."
+	exit 1
+fi
+
+print_targets=0
+
+while getopts "p" arg; do
+    case $arg in
+        p)
+		print_targets=1
+	shift;;
+    esac
+done
+
+if [ $# -eq 0 ]
+then
+	usage
+fi
+
+# Compiler
+CC=$1
+
+tmp_file=$(mktemp).c
+trap "rm -f $tmp_file.o $tmp_file $tmp_file.bin" EXIT
+#echo $tmp_file
+
+pass=$(mktemp).out
+trap "rm -f $pass" EXIT
+#echo $pass
+
+fail=$(mktemp).out
+trap "rm -f $fail" EXIT
+#echo $fail
+
+# Generate tmp source fire for compile test
+cat << "EOF" > $tmp_file
+int main()
+{
+}
+EOF
+
+# Save results
+total_cnt=0
+fail_trgts=()
+fail_libs=()
+fail_cnt=0
+pass_trgts=()
+pass_libs=()
+pass_cnt=0
+
+# Get all TARGETS from selftests Makefile
+targets=$(egrep "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
+
+# Single test case
+if [ $# -eq 2 ]
+then
+	test=$2/Makefile
+
+	l1_test $test
+	l2_test $test
+	l3_test $test
+
+	print_results $1 $2
+	exit $?
+fi
+
+# Level 1: LDLIBS set static.
+#
+# Find all LDLIBS set statically for all executables built by a Makefile
+# and filter out VAR_LDLIBS to discard the following:
+# 	gpio/Makefile:LDLIBS += $(VAR_LDLIBS)
+# Append space at the end of the list to append more tests.
+
+l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
+		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+
+# Level 2: LDLIBS set dynamically.
+#
+# Level 2
+# Some tests have multiple valid LDLIBS lines for individual sub-tests
+# that need dependency checks. Find them and append them to the tests
+# e.g: vm/Makefile:$(OUTPUT)/userfaultfd: LDLIBS += -lpthread
+# Filter out VAR_LDLIBS to discard the following:
+# 	memfd/Makefile:$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
+# Append space at the end of the list to append more tests.
+
+l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
+		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+
+# Level 3
+# gpio,  memfd and others use pkg-config to find mount and fuse libs
+# respectively and save it in VAR_LDLIBS. If pkg-config doesn't find
+# any, VAR_LDLIBS set to default.
+# Use the default value and filter out pkg-config for dependency check.
+# e.g:
+# gpio/Makefile
+#	VAR_LDLIBS := $(shell pkg-config --libs mount) 2>/dev/null)
+# memfd/Makefile
+#	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+
+l3_tests=$(grep -r --include=Makefile "^VAR_LDLIBS" | \
+       		grep -v "pkg-config" | awk -F: '{print $1}')
+
+#echo $l1_tests
+#echo $l2_1_tests
+#echo $l3_tests
+
+all_tests
+print_results $1 $2
+
+exit $?
+}
+# end main()
+
+all_tests()
+{
+	for test in $l1_tests; do
+		l1_test $test
+	done
+
+	for test in $l2_tests; do
+		l2_test $test
+	done
+
+	for test in $l3_tests; do
+		l3_test $test
+	done
+}
+
+# Use same parsing used for l1_tests and pick libraries this time.
+l1_test()
+{
+	test_libs=$(grep --include=Makefile "^LDLIBS" $test | \
+			grep -v "VAR_LDLIBS" | \
+			sed -e 's/\:/ /' | \
+	       		sed -e 's/+/ /' | cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+# Use same parsing used for l2__tests and pick libraries this time.
+l2_test()
+{
+	test_libs=$(grep --include=Makefile ": LDLIBS" $test | \
+			grep -v "VAR_LDLIBS" | \
+			sed -e 's/\:/ /' | sed -e 's/+/ /' | \
+			cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+l3_test()
+{
+	test_libs=$(grep --include=Makefile "^VAR_LDLIBS" $test | \
+			grep -v "pkg-config" | sed -e 's/\:/ /' |
+			sed -e 's/+/ /' | cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
+check_libs()
+{
+
+if [[ ! -z "${test_libs// }" ]]
+then
+
+	#echo $test_libs
+
+	for lib in $test_libs; do
+
+	let total_cnt+=1
+	$CC -o $tmp_file.bin $lib $tmp_file > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "FAIL: $test dependency check: $lib" >> $fail
+		let fail_cnt+=1
+		fail_libs+="$lib "
+		fail_target=$(echo "$test" | cut -d "/" -f1)
+		fail_trgts+="$fail_target "
+		targets=$(echo "$targets" | grep -v "$fail_target")
+	else
+		echo "PASS: $test dependency check passed $lib" >> $pass
+		let pass_cnt+=1
+		pass_libs+="$lib "
+		pass_trgts+="$(echo "$test" | cut -d "/" -f1) "
+	fi
+
+	done
+fi
+}
+
+print_results()
+{
+	echo -e "========================================================";
+	echo -e "Kselftest Dependency Check for [$0 $1 $2] results..."
+
+	if [ $print_targets -ne 0 ]
+	then
+	echo -e "Suggested Selftest Targets for your configuration:"
+	echo -e "$targets";
+	fi
+
+	echo -e "========================================================";
+	echo -e "Checked tests defining LDLIBS dependencies"
+	echo -e "--------------------------------------------------------";
+	echo -e "Total tests with Dependencies:"
+	echo -e "$total_cnt Pass: $pass_cnt Fail: $fail_cnt";
+
+	if [ $pass_cnt -ne 0 ]; then
+	echo -e "--------------------------------------------------------";
+	cat $pass
+	echo -e "--------------------------------------------------------";
+	echo -e "Targets passed build dependency check on system:"
+	echo -e "$(echo "$pass_trgts" | xargs -n1 | sort -u | xargs)"
+	fi
+
+	if [ $fail_cnt -ne 0 ]; then
+	echo -e "--------------------------------------------------------";
+	cat $fail
+	echo -e "--------------------------------------------------------";
+	echo -e "Targets failed build dependency check on system:"
+	echo -e "$(echo "$fail_trgts" | xargs -n1 | sort -u | xargs)"
+	echo -e "--------------------------------------------------------";
+	echo -e "Missing libraries system"
+	echo -e "$(echo "$fail_libs" | xargs -n1 | sort -u | xargs)"
+	fi
+
+	echo -e "--------------------------------------------------------";
+	echo -e "========================================================";
+}
+
+main "$@"
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 187b14cad00c..4da8b565fa32 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -8,11 +8,21 @@ TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
 TEST_GEN_FILES := fuse_test fuse_mnt
 
-fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
+VAR_CFLAGS := $(shell pkg-config fuse --cflags 2>/dev/null)
+ifeq ($(VAR_CFLAGS),)
+VAR_CFLAGS := -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse
+endif
+
+VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lfuse -pthread
+endif
+
+fuse_mnt.o: CFLAGS += $(VAR_CFLAGS)
 
 include ../lib.mk
 
-$(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
+$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
 $(OUTPUT)/memfd_test: memfd_test.c common.c
 $(OUTPUT)/fuse_test: fuse_test.c common.c
-- 
2.20.1

