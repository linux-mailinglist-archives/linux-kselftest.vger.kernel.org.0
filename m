Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513511A6FA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 01:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbgDMXBY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 19:01:24 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.101]:24475 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbgDMXBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 19:01:20 -0400
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 19:01:18 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 9404C42AA83
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 17:15:49 -0500 (CDT)
Received: from host2044.hostmonster.com ([67.20.76.238])
        by cmsmtp with SMTP
        id O7MrjreVtSl8qO7MrjKRkC; Mon, 13 Apr 2020 17:15:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bird.org;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sQu4WEdlJRk8GMcfv/gw1olojUXkrtm0cH84qMuTAvM=; b=XzTaPzF2UY2XkhBLalrRhUaAdA
        DSmKi1Yqab3n8Dj1uB8S/bXQ1gaQNoutbiIj4kRPfXcwyuxx1vPFt/O9Nlr+WudB8vsCwOYzTHe1B
        atRdgVzOGMToFE1DtmJKY+fqYYbEGXSjuWvxQl9Ir9eyhyPmVOZyU9L+z3rL0IiXzKQTnzXrDKUZt
        UEC4the9wOiPc92/bp8TCmf5AacJcBQtR+9OyNJAZzDK+AUfYeeEOXnkt31YwetOep4u/YDOXMv6Z
        SpfKwSDhz/qShlrmgsmHf+ny3ghW6mkAFmpM5ho66JJeI/uzTZkg34Mswzt6ew5Hk5oytn69Qb4iM
        HBqYG3Cw==;
Received: from [192.34.114.49] (port=45370 helo=[10.0.1.61])
        by host2044.hostmonster.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@bird.org>)
        id 1jO7Mq-003TNd-NJ; Mon, 13 Apr 2020 16:15:48 -0600
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tbird20d@gmail.com, tim.bird@sony.com
From:   Tim Bird <tim@bird.org>
Subject: [PATCH] selftest: add a script to perform selftest compile tests
Message-ID: <86508e9d-4aff-d9a0-3783-971a4686ccd1@bird.org>
Date:   Mon, 13 Apr 2020 16:15:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bird.org
X-BWhitelist: no
X-Source-IP: 192.34.114.49
X-Source-L: No
X-Exim-ID: 1jO7Mq-003TNd-NJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.0.1.61]) [192.34.114.49]:45370
X-Source-Auth: tim@bird.org
X-Email-Count: 2
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: yes
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tim Bird <tim.bird@sony.com>

Add ksft-compile-test.sh.  This is a program used to test
cross-compilation and installation of selftest tests.

See the test usage for help

This program currently tests 3 scenarios out of a larger matrix
of possibly interesting scenarios.  For each scenario, it conducts
multiple tests for correctness.  This version tests:
 1) does the test compile
 2) is the kernel source directory clean after the compile
 3) does the test install operation succeed
 4) does the test run script reference the test

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 MAINTAINERS                                  |   6 +
 tools/testing/selftests/ksft-compile-test.sh | 567 +++++++++++++++++++++++++++
 2 files changed, 573 insertions(+)
 create mode 100755 tools/testing/selftests/ksft-compile-test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18c..a6289c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9127,6 +9127,12 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL SELFTEST SELFTEST
+M:	Tim Bird <tim.bird@sony.com>
+L:	linux-kselftest@vger.kernel.org
+S:	Maintained
+F:	tools/testing/selftests/ksft-compile-test.sh
+
 KERNEL UNIT TESTING FRAMEWORK (KUnit)
 M:	Brendan Higgins <brendanhiggins@google.com>
 L:	linux-kselftest@vger.kernel.org
diff --git a/tools/testing/selftests/ksft-compile-test.sh b/tools/testing/selftests/ksft-compile-test.sh
new file mode 100755
index 0000000..e36e858
--- /dev/null
+++ b/tools/testing/selftests/ksft-compile-test.sh
@@ -0,0 +1,567 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only OR MIT
+#
+# ksft-compile-test.sh - test compiling Linux kernel selftests under lots of
+#   different configurations.  This is used to check that cross-compilation
+#   and install works properly for a newly submitted test target, and
+#   also that changes to existing test Makefiles don't regress with regard to
+#   this functionality.
+#
+# Copyright 2020 Sony Corporation
+#
+# Here are the things that Shuah Kahn asked for on 3/6/2020
+# 1. Cross-compilation & relocatable build support
+# 2. Generates objects in objdir/kselftest without cluttering main objdir
+# 3. Leave source directory clean
+# 4. Installs correctly in objdir/kselftest/kselftest_install and adds
+#        itself to run_kselftest.sh script generated during install.
+#
+# Would be nice to make sure other features also work:
+# 5. can use absolute, relative, or current directory for output directory
+# 6. can use ~ in output directory path
+#
+# matrix of build combinations:
+# dimensions:
+#   cwd:         top-level, build-dir, tools/testing/selftests/<target>
+#   change-dir:  <none>, -C tools/testing/selftests (selftests)
+#   make-target: <none>, kselftest-install, install
+#   output-dir:  <none>, KBUILD_OUTPUT-rel, KBUILD_OUTPUT-abs, O-rel, O-abs
+#
+# NOTE: you should not put your output directory inside your source directory
+#  Parts of the kbuild system don't like this.
+#
+# The test matrix is not full:
+#   <cwd>,<change-dir>,<make target>,<output-dir>
+#   top, none, kselftest-install, none
+#   top, none, kselftest-install, KBO-rel
+# 2 top, none, kselftest-install, KBO-abs
+#   top, none, kselftest-install, O-rel
+# 1 top, none, kselftest-install, O-abs
+#   top, selftests, none , none
+#   top, selftests, none , KBO-rel
+# 3 top, selftests, none , KBO-abs
+#   top, selftests, none , O-rel
+# 4 top, selftests, none , O-abs
+#   build-dir, none, kselftest-install, none
+#   build-dir, none, kselftest-install, KBO-rel
+#   build-dir, none, kselftest-install, KBO-abs
+#   build-dir, none, kselftest-install, O-rel
+#   build-dir, none, kselftest-install, O-abs
+#   build-dir, selftests, none, none
+#   build-dir, selftests, none, KBO-rel
+#   build-dir, selftests, none, KBO-abs
+#   build-dir, selftests, none, kselftest-install, O-rel
+#   build-dir, selftests, none, O-abs
+# 5 target, none, none, none
+# 6 target, none, install, none
+#   target, none, none, KBO-rel
+#   target, none, install, KBO-rel
+#   target, none, none, KBO-abs
+#   target, none, install, KBO-abs
+#   target, none, none, O-rel
+#   target, none, install, O-rel
+#   target, none, none, O-abs
+#   target, none, install, O-abs
+#
+# 1 = Shuah preferred test (top-level, kselftest-install, with O=)
+# 3 = Fuego (Tim's) default build style
+#
+# To do for this test:
+#
+
+usage() {
+    cat <<HERE
+Usage: ksft-compile-test.sh [-h|--help] [TARGETS="<targets>"] [<options>]
+
+compile_test.sh will test building selftest programs in the indicated
+target areas.  The script tests various output-directory configurations.
+
+OPTIONS
+  -h, --help          Show this usage help.
+  TARGETS="<targets>" Indicate the set of targets to test. <targets> is a
+                        space-separated list of testing areas from
+                        tools/testing/selftests/Makefile
+  O=<dir>             Indicate a directory to use for output.  Normally, the
+                        program creates a temporary directory for testing, and
+                        removes it when done.  This sets -p, to avoid removing
+                        the directory at the end of the test.  Using O= with an
+                        existing directory can save time (the kernel does not
+                        need to be rebuilt).  The directory must already exist.
+  -c <config-file>    Specify a configuration file for the kernel.
+                        If not specified, an appropriate defconfig will be used.
+  -p, --preserve      Preserve files when this test completes.
+                        If not specified, test will remove working files when
+                        it completes.
+  -l <log-file>       Specify the file to use for log output.  All test output
+                        goes to STDOUT (and STDERR) A subset of output
+                        is placed in the logfile.  If not specified, the
+                        filename 'compile-test-log-<timestamp>.txt' is used.
+  -s, --summary       Show summary of results at end of test.
+  -e <extra-data-file> Put contents of <extra-data-file> in the header of
+                        the logfile (and in test output).  This allows a CI
+                        system to add additional information about the build
+                        system, toolchain, etc. used for the test.
+  -C <kernel-src-dir> Use the indicated directory (instead of current
+                        working directory) as the kernel source dir.
+
+ENVIRONMENT
+  Set ARCH and CROSS_COMPILE to values appropriate for your environment
+  (the same as for a Linux kernel image build)
+
+  You can use a TARGETS environment variable, instead of the TARGETS=
+  command line option.
+
+OUTPUT
+  Program output is in TAP13 format.  The exit code indicates if the test was
+  100% successful (SKIPS are counted as failures).
+HERE
+    exit 1
+}
+
+INDENT=3
+DEBUG=1
+
+dprint() {
+    if [ $DEBUG = 1 ] ; then
+        echo "$1"
+    fi
+}
+
+# parse command line options
+CONFIG_FILE=use_defconfig
+PRESERVE_FILES=0
+LOGFILE="$(pwd)/compile-test-log-$(date -Iseconds).txt"
+SHOW_SUMMARY=0
+SRC_TOP="$(realpath $(pwd))"
+
+while [ -n "$1" ] ; do
+    case $1 in
+        -h|--help)
+            usage
+            ;;
+        TARGETS=*)
+            TARGETS="${1#TARGETS=}"
+            export TARGETS
+            shift
+            ;;
+        O=*)
+            OUTPUT_DIR="${1#O=}"
+            shift
+            export OUTPUT_DIR
+            PRESERVE_FILES=1
+            if [ ! -d "$OUTPUT_DIR" ] ; then
+                echo "Error: output directory $OUTPUT_DIR does not exist"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            ;;
+        -c)
+            CONFIG_FILE="$2"
+            shift 2
+            if [ ! -f ${CONFIG_FILE} ] ; then
+                echo "Error: Can't read specified config file $CONFIG_FILE"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            ;;
+        -p|--preserve)
+            PRESERVE_FILES=1
+            shift
+            ;;
+        -l)
+            LOGFILE=="$2"
+            shift 2
+            if [ -z "$LOGFILE" ] ; then
+                echo "Error: No log-file specified with -l"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            echo "Using logfile $LOGFILE"
+            ;;
+        -s|--summary)
+            SHOW_SUMMARY=1
+            shift
+            ;;
+        -e)
+            EXTRA_DATA_FILE="$2"
+            shift 2
+            if [ -z "$EXTRA_DATA_FILE" ] ; then
+                echo "Error: No <extra-data-file> specified with -e"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            if [ ! -f "$EXTRA_DATA_FILE" ] ; then
+                echo "Error: Extra data file '$EXTRA_DATA_FILE' does not exist"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            echo "Using extra data file $EXTRA_DATA_FILE"
+            ;;
+        -C)
+            SRC_TOP="$(realpath $2)"
+            shift 2
+            if [ ! -d $SRC_TOP ] ; then
+                echo "Error: Kernel source dir '$SRC_TOP' does not exist"
+                echo "Use '-h' to get program usage"
+                exit 1
+            fi
+            if [ ! -f "$SRC_TOP/MAINTAINERS" ] ; then
+                echo "Error: $SRC_TOP doesn't seem to be a kernel source tree."
+                echo "Missing MAINTAINERS file."
+                exit 1
+            fi
+            echo "Using kernel source tree: $SRC_TOP"
+            cd $SRC_TOP
+            ;;
+        *)
+            echo "Error: Unknown option '$1'"
+            echo "Use '-h' to get program usage"
+            exit 1
+            ;;
+    esac
+done
+
+# for debugging option parsing
+dprint "TARGETS=$TARGETS"
+dprint "CONFIG_FILE=$CONFIG_FILE"
+dprint "LOGFILE=$LOGFILE"
+dprint "PRESERVE_FILES=$PRESERVE_FILES"
+dprint "OUTPUT_DIR=$OUTPUT_DIR"
+dprint "SRC_TOP=$SRC_TOP"
+
+#### logging routines
+# log_msg - put a single-line message in the logfile (and STDOUT)
+log_msg() {
+    echo "$1" | tee -a $LOGFILE
+}
+
+# log_result - put TAP-syntax prefix and description to logfile
+#  $1 = result to log
+#  $2 = result description (usually "$test_id", but may include SKIP)
+# Uses global TEST_NUM
+log_result() {
+    if [ $1 = 0 ] ; then
+        log_msg "ok $TEST_NUM $2"
+    else
+        log_msg "not ok $TEST_NUM $2"
+    fi
+}
+
+# log_cmd - put output of command into logfile
+#  $1 - command to execute
+log_cmd() {
+    RETCODE=/tmp/$$-${RANDOM}
+    touch $RETCODE
+    bash -c "{ $1; echo \$? >$RETCODE ; } 2>&1 | tee -a $LOGFILE"
+    RESULT=$(cat $RETCODE)
+    rm -f $RETCODE
+    return $RESULT
+}
+
+# log_cmd_indented - put output of command into logfile, indented by INDENT
+#  $1 - command to execute
+# Uses global INDENT
+log_cmd_indented() {
+    RETCODE=/tmp/$$-${RANDOM}
+    TMPOUT=/tmp/$$-${RANDOM}
+    touch $RETCODE
+    bash -c "{ $1; echo \$? >$RETCODE ; } 2>&1 | tee -a $TMPOUT"
+    RESULT=$(cat $RETCODE)
+
+    # could use sed here instead of pr, if needed
+    cat $TMPOUT | pr -to $INDENT >>$LOGFILE
+
+    rm -f $RETCODE $TMPOUT
+    return $RESULT
+}
+
+# do some sanity checks before we get started
+test_pre_check() {
+    # are we in the top directory of a kernel source tree?
+    if [ ! -f "MAINTAINERS" ] ; then
+        echo "Error: We're not in a kernel source tree (no MAINTAINERS file)"
+        echo "Use '-h' to get program usage"
+        exit 1
+    fi
+
+    if [ -z $ARCH ] ; then
+        ARCH_ARGS=""
+    else
+        ARCH_ARGS="ARCH=$ARCH"
+    fi
+    export ARCH_ARGS
+
+    if [ -z "$CROSS_COMPILE" -a -n "$ARCH_ARGS" ] ; then
+       echo "Warning: no CROSS_COMPILE prefix defined, but ARCH $ARCH specified"
+       echo "Usually, if you specify an ARCH you need to specify CROSS_COMPILE"
+       echo "Use '-h' to get program usage"
+    fi
+}
+
+# prepare for tests
+# on completion, following should be set:
+#   INDENT, TARGET_LIST, NUM_MAKE_JOBS, KBUILD_DIR_REL, KBUILD_DIR_ABS
+# Uses: ARCH
+test_setup() {
+    echo "In test setup"
+
+    # read target list from test variable, if defined
+    if [ -n "${TARGETS}" ] ; then
+        TARGET_LIST="${TARGETS}"
+    else
+        # use hardcoded kselftest target list for now
+        TARGET_LIST="android arm64 bpf breakpoints capabilities cgroup \
+            clone3 cpufreq cpu-hotplug drivers/dma-buf efivarfs exec \
+            filesystems filesystems/binderfs filesystems/epoll firmware \
+            ftrace futex gpio intel_pstate ipc ir kcmp kexec kvm lib \
+            livepatch lkdtm membarrier memfd memory-hotplug mount mqueue \
+            net net/mptcp netfilter networking/timestamping nsfs pidfd \
+            powerpc proc pstore ptrace openat2 rseq rtc seccomp sigaltstack \
+            size sparc64 splice static_keys sync sysctl timens timers tmpfs \
+            tpm2 user vm x86 zram"
+        # FIXTHIS - query kernel for kselftest full target list
+        #TARGET_LIST=$(make --no-print-directory -s \
+        #                -C tools/testing/selftests show_targets)
+    fi
+
+    # get number of parallel jobs to start in make
+    proc_count=$(cat /proc/cpuinfo | grep processor | wc -l)
+    NUM_MAKE_JOBS=$(( proc_count / 2 ))
+    if [ $NUM_MAKE_JOBS -lt 1 ] ; then
+        NUM_MAKE_JOBS=1
+    fi
+
+    if [ -z "$OUTPUT_DIR" ] ; then
+        # make output dir
+        tmp1=$(mktemp -d ../ksft-XXXXXX)
+        export KBUILD_DIR_REL="$tmp1"
+        export KBUILD_DIR_ABS=$(realpath $tmp1)
+    else
+        export KBUILD_DIR_REL=$(realpath --relative-to=$(pwd) $OUTPUT_DIR)
+        export KBUILD_DIR_ABS=$(realpath $OUTPUT_DIR)
+    fi
+    mkdir -p $KBUILD_DIR_ABS
+
+    # for setup, use KBUILD_OUTPUT environment var for output dir
+    KBUILD_OUTPUT=$KBUILD_DIR_ABS
+
+    if [ $CONFIG_FILE = "use_defconfig" ] ; then
+        make $ARCH_ARGS defconfig
+    else
+        cp $CONFIG_FILE $KBUILD_OUTPUT/.config
+    fi
+    make $ARCH_ARGS oldconfig
+
+    # this should only be needed once
+    make $ARCH_ARGS -j $NUM_MAKE_JOBS headers_install
+
+    make $ARCH_ARGS -j $NUM_MAKE_JOBS vmlinux
+}
+
+#
+# $1 = KBUILD_DIR
+# $2 = target
+check_output_dir() {
+    install_result=0
+    log_msg "# Contents of kselftest_install directory:"
+    if [ -d $1/kselftest/kselftest_install ] ; then
+        pushd $1/kselftest/kselftest_install >/dev/null
+
+        log_cmd_indented "ls -lR"
+        log_msg "# File types:"
+        log_cmd_indented "find . -type f | xargs file -n | \
+                            sed \"s/BuildID.*, //\""
+
+        # check that run scripts has the target
+        if ! grep "^cd $2" run_kselftest.sh 2>&1 >/dev/null ; then
+            log_mesg "# Missing target $2 in run_kselftest.sh"
+            install_result=1
+        fi
+
+        popd >/dev/null
+    else
+        log_msg "# Missing $KBUILD_OUTPUT/kselftest/kselftest_install directory"
+        install_result=1
+    fi
+    return $install_result
+}
+
+# do_test - perform one test combination
+#  $1 = method (string for use in test_id)
+#  $2 = target
+#  $3 = compile args
+#  $4 = install args (if any)
+#  $5 = clean args
+#
+# Uses: ARCH_ARGS, KBUILD_DIR and LOGFILE (indirectly), and SRC_TOP
+# Uses and sets: TEST_NUM
+#
+do_test() {
+    method=$1
+    target=$2
+    COMPILE_ARGS=$3
+    INSTALL_ARGS=$4
+    CLEAN_ARGS=$4
+
+    TARGET_DIR=$SRC_TOP/tools/testing/selftests/$target
+
+    SRC_LS_FILE1="$(mktemp)"
+    SRC_LS_FILE2="$(mktemp)"
+    ls -lR $TARGET_DIR >$SRC_LS_FILE1
+
+    test_id="$target compile $method"
+    TEST_NUM=$(( TEST_NUM + 1 ))
+    log_msg "# $TEST_NUM $test_id"
+
+    # do the compile
+    log_cmd_indented "make $ARCH_ARGS TARGETS=\"$target\" $COMPILE_ARGS"
+    compile_result=$?
+
+    log_result $compile_result "$test_id"
+
+    # check that nothing changed in the src directory
+    test_id="$target src tree clean after compile $method"
+    TEST_NUM=$(( TEST_NUM + 1 ))
+    log_msg "# $TEST_NUM $test_id"
+
+    ls -lR $TARGET_DIR >$SRC_LS_FILE2
+    log_cmd_indented "diff -u $SRC_LS_FILE1 $SRC_LS_FILE2"
+    src_clean_result=$?
+
+    if [ $src_clean_result != 0 ] ; then
+        log_msg "# File or directory changes found in $TARGET_DIR"
+    fi
+
+    log_result $src_clean_result "$test_id"
+    rm $SRC_LS_FILE1
+    rm $SRC_LS_FILE2
+
+    test_id="$target install $method"
+    TEST_NUM=$(( TEST_NUM + 1 ))
+    log_msg "# $TEST_NUM $test_id"
+
+    if [ -n "INSTALL_ARGS" ] ; then
+        # skip the install test if it didn't compile
+        if [ $compile_result != 0 ] ; then
+            install_result=$compile_result
+            reason="compile failed"
+            log_result $install_result "$test_id  # SKIP - $reason"
+
+        else
+            # now do install
+            log_cmd_indented "make $ARCH_ARGS TARGETS=\"$target\" $INSTALL_ARGS"
+            install_result=$?
+            log_result $install_result "$test_id"
+        fi
+    else
+        install_result=$compile_result
+        log_result $install_result "$test_id"
+    fi
+
+    test_id="$target check install output $method"
+    TEST_NUM=$(( TEST_NUM + 1 ))
+    log_msg "# $TEST_NUM $test_id"
+
+    # check results
+    if [ $install_result = 0 ] ; then
+        check_output_dir $KBUILD_DIR $target
+        install_output_result=$?
+        log_result $install_output_result "$test_id"
+    else
+        log_result $install_result "$test_id  # SKIP - install failed"
+    fi
+
+    # clean up after test
+    make $ARCH_ARGS TARGETS=\"$target\" $CLEAN_ARGS
+
+    # clear out install directory for next test
+    rm -rf $KBUILD_DIR/kselftest/kselftest_install
+    mkdir -p $KBUILD_DIR/kselftest/kselftest_install
+}
+
+test_run() {
+    export KBUILD_DIR=$KBUILD_DIR_ABS
+    NUM_SCENARIOS=3
+    TESTS_PER_SCENARIO=4
+
+    # output the header
+    log_msg "ARCH=$ARCH"
+    log_msg "CROSS_COMPILE=$CROSS_COMPILE"
+    if [ -f "$EXTRA_DATA_FILE" ] ; then
+        log_msg "=== Test Details ==="
+        log_cmd "cat $EXTRA_DATA_FILE"
+        log_msg "==="
+    fi
+    log_msg "TAP VERSION 13"
+
+    target_count=$(echo $TARGET_LIST | wc -w)
+    export test_count=$(( target_count * $NUM_SCENARIOS * $TESTS_PER_SCENARIO ))
+    log_msg "1..$test_count"
+
+    # disable 'stop-on-error'
+    set +e
+
+    export TEST_NUM=0
+    for target in $TARGET_LIST ; do
+        echo "##########  Doing tests for target $target ##########"
+
+        # clean out directory to force a re-build
+        make $ARCH_ARGS TARGETS=\"$target\" -C tools/testing/selftests clean
+
+        ### MATRIX SCENARIO: KBUILD_OUTPUT,-C
+        export KBUILD_OUTPUT="$KBUILD_DIR"
+        method="KBUILD_OUTPUT,-C"
+        COMPILE_ARGS="-C tools/testing/selftests"
+        INSTALL_ARGS="$COMPILE_ARGS install"
+        CLEAN_ARGS="$COMPILE_ARGS clean"
+        do_test "$method" $target "$COMPILE_ARGS" "$INSTALL_ARGS" "$CLEAN_ARGS"
+
+        ### MATRIX SCENARIO: O,-C
+        unset KBUILD_OUTPUT
+        O_TMP="$KBUILD_DIR"
+        method="O,-C"
+        COMPILE_ARGS="-C tools/testing/selftests O=$O_TMP"
+        INSTALL_ARGS="$COMPILE_ARGS install"
+        CLEAN_ARGS="$COMPILE_ARGS clean"
+        do_test "$method" $target "$COMPILE_ARGS" "$INSTALL_ARGS" "$CLEAN_ARGS"
+
+        ### MATRIX SCENARIO: O,top
+        method="O,top"
+        COMPILE_ARGS="O=$O_TMP kselftest-install"
+        INSTALL_ARGS=""
+        CLEAN_ARGS="O=$O_TMP kselftest-clean"
+        do_test "$method" $target "$COMPILE_ARGS" "$INSTALL_ARGS" "$CLEAN_ARGS"
+
+    done
+    set -e
+}
+
+test_cleanup() {
+    echo "In test cleanup"
+    if [ -z "$OUTPUT_DIR" ] ; then
+        if [ "$PRESERVE_FILES" = 0 ] ; then
+            rm -rf $KBUILD_DIR_ABS
+        else
+            echo "Build data was left in directory $KBUILD_DIR_ABS"
+        fi
+    else
+        echo "Not removing files in user-specified output dir $OUTPUT_DIR"
+    fi
+}
+
+# this is main()
+test_pre_check
+test_setup
+dprint "TARGET_LIST=$TARGET_LIST"
+test_run
+test_cleanup
+
+echo "Done. Log file is in $LOGFILE"
+
+if [ "$SHOW_SUMMARY" = 1 ] ; then
+    ok_count=$(grep ^ok $LOGFILE | wc -l)
+    fail_count=$(grep "^not ok" $LOGFILE | grep -v SKIP | wc -l)
+    skip_count=$(grep "^not ok" $LOGFILE | grep SKIP | wc -l)
+    total=$(( ok_count + fail_count + skip_count ))
+    echo "OK: $ok_count, FAIL: $fail_count, SKIP: $skip_count, TOTAL: $total"
+fi
-- 
2.1.4

