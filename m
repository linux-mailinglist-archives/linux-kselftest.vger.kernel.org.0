Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE628F9C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391987AbgJOTzL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391983AbgJOTzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 15:55:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DADC0613D2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 12:55:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r4so444489ioh.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=AfaUv++4RzIF+YTHhBRlhZxrNYXvn+QuW5gq/QPyzDo=;
        b=GOhzNFx7yUpwqDp2BHxbIEhdGZMHVI/nSt6OExpr23l4tL0Z039DI4Cjyit8X59mv4
         loMXV7cO2PGrH9t5byQiFM1Ul6fyER9zlegoRhG0IzJ2zhDcvs040WS3PZXH0X7LfXjK
         OiX5u7m6Ur26wDyLgLbQ/+e8s52ZwYJMA784I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=AfaUv++4RzIF+YTHhBRlhZxrNYXvn+QuW5gq/QPyzDo=;
        b=fizkHrg27UQhZ6n6xVYO27QA5HgNO4vYqrPAnMQnZaO2G0+mLZQVJ7KS9wW6RN6X0i
         QG0jZdOkU3O8mATk6+JLHch/TLieh11fFe0EJdCWANBPuvc7///IZMeoTx9m+lhDEi6S
         ei4SrqoNfT989sFwavzedrtYPpK6ODnK3iJu95DW5NEE3Hlf52r85SltgOwVCOYRlj4c
         xTTiuKvZSRW611CKtaaPxrFqZd/vyqxQVAJlRC0friRsltyDVSlsqla+CvOlgnnVH863
         ObHVc8RcTfNDf2n0FT9WP+CDvZeg5u1bBf6F/v7PtOCVtap1C6GZGpJQBOhXrWKVhzuy
         3Qpg==
X-Gm-Message-State: AOAM53264RbTJhWATypIYZx/6HqVkc4Onn2WopeO2Lzmeooocvtj+DWE
        2N3rwMAaysy2y7dQIIrhg+jITVzzbMQqZg==
X-Google-Smtp-Source: ABdhPJw9UnDzIe3RSfqQZfzWQ9jX5fG64Xs7CgH7jizrLeb/Ung+vEZOS2RJhStwhUNtQSksJMUxCA==
X-Received: by 2002:a6b:fb0d:: with SMTP id h13mr4509257iog.12.1602791709907;
        Thu, 15 Oct 2020 12:55:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m66sm1056983ill.69.2020.10.15.12.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 12:55:09 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest next update for Linux 5.10-rc1
Message-ID: <e91227aa-4f7d-7a45-0b40-c6bbc72ea67f@linuxfoundation.org>
Date:   Thu, 15 Oct 2020 13:55:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------FFFB3B08D01412D12F7B500D"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------FFFB3B08D01412D12F7B500D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest next update for Linux 5.10-rc1

This kselftest update for Linux 5.10-rc1 consists of enhancements to

-- speed up headers_install done during selftest build
-- add generic make nesting support
-- add support to select individual tests:
    - Selftests build/install generates run_kselftest.sh script to run
      selftests on a target system. Currently the script doesn't have
      support for selecting individual tests. Add support for it.

      With this enhancement, user can select test collections (or tests)
      individually. e.g:

      run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

      Additionally adds a way to list all known tests with "-l", usage
      with "-h", and perform a dry run without running tests with "-n".

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.10-rc1

for you to fetch changes up to 4c8511317b4ec75cc3868f80a7b9fddb8322e512:

   doc: dev-tools: kselftest.rst: Update examples and paths (2020-10-07 
07:59:24 -0600)

----------------------------------------------------------------
linux-kselftest-next-5.10-rc1

This kselftest update for Linux 5.10-rc1 consists of enhancements to

-- speed up headers_install done during selftest build
-- add generic make nesting support
-- add support to select individual tests:
    - Selftests build/install generates run_kselftest.sh script to run
      selftests on a target system. Currently the script doesn't have
      support for selecting individual tests. Add support for it.

      With this enhancement, user can select test collections (or tests)
      individually. e.g:

      run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep

      Additionally adds a way to list all known tests with "-l", usage
      with "-h", and perform a dry run without running tests with "-n".

----------------------------------------------------------------
Denys Vlasenko (1):
       selftests: use "$(MAKE)" instead of "make" for headers_install

Gabriel Krisman Bertazi (1):
       selftests: Add missing gitignore entries

Greg Thelen (1):
       selftests: more general make nesting support

Kees Cook (3):
       selftests: Extract run_kselftest.sh and generate stand-alone test 
list
       selftests/run_kselftest.sh: Make each test individually selectable
       doc: dev-tools: kselftest.rst: Update examples and paths

  Documentation/dev-tools/kselftest.rst        | 35 +++++++----
  tools/testing/selftests/Makefile             | 34 ++++------
  tools/testing/selftests/firmware/.gitignore  |  2 +
  tools/testing/selftests/lib.mk               |  9 ++-
  tools/testing/selftests/netfilter/.gitignore |  2 +
  tools/testing/selftests/ptrace/.gitignore    |  1 +
  tools/testing/selftests/run_kselftest.sh     | 93 
++++++++++++++++++++++++++++
  7 files changed, 135 insertions(+), 41 deletions(-)
  create mode 100644 tools/testing/selftests/firmware/.gitignore
  create mode 100644 tools/testing/selftests/netfilter/.gitignore
  create mode 100755 tools/testing/selftests/run_kselftest.sh
----------------------------------------------------------------

--------------FFFB3B08D01412D12F7B500D
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.10-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.10-rc1.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 469d115a95f1..a901def730d9 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -125,32 +125,41 @@ Note that some tests will require root privileges.
 Install selftests
 =================
 
-You can use the kselftest_install.sh tool to install selftests in the
-default location, which is tools/testing/selftests/kselftest, or in a
-user specified location.
+You can use the "install" target of "make" (which calls the `kselftest_install.sh`
+tool) to install selftests in the default location (`tools/testing/selftests/kselftest_install`),
+or in a user specified location via the `INSTALL_PATH` "make" variable.
 
 To install selftests in default location::
 
-   $ cd tools/testing/selftests
-   $ ./kselftest_install.sh
+   $ make -C tools/testing/selftests install
 
 To install selftests in a user specified location::
 
-   $ cd tools/testing/selftests
-   $ ./kselftest_install.sh install_dir
+   $ make -C tools/testing/selftests install INSTALL_PATH=/some/other/path
 
 Running installed selftests
 ===========================
 
-Kselftest install as well as the Kselftest tarball provide a script
-named "run_kselftest.sh" to run the tests.
+Found in the install directory, as well as in the Kselftest tarball,
+is a script named `run_kselftest.sh` to run the tests.
 
 You can simply do the following to run the installed Kselftests. Please
 note some tests will require root privileges::
 
-   $ cd kselftest
+   $ cd kselftest_install
    $ ./run_kselftest.sh
 
+To see the list of available tests, the `-l` option can be used::
+
+   $ ./run_kselftest.sh -l
+
+The `-c` option can be used to run all the tests from a test collection, or
+the `-t` option for specific single tests. Either can be used multiple times::
+
+   $ ./run_kselftest.sh -c bpf -c seccomp -t timers:posix_timers -t timer:nanosleep
+
+For other features see the script usage output, seen with the `-h` option.
+
 Packaging selftests
 ===================
 
@@ -160,9 +169,9 @@ different system. To package selftests, run::
    $ make -C tools/testing/selftests gen_tar
 
 This generates a tarball in the `INSTALL_PATH/kselftest-packages` directory. By
-default, `.gz` format is used. The tar format can be overridden by specifying
-a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_ option
-is supported, such as::
+default, `.gz` format is used. The tar compression format can be overridden by
+specifying a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_
+option is supported, such as::
 
     $ make -C tools/testing/selftests gen_tar FORMAT=.xz
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9018f45d631d..d9c283503159 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -88,10 +88,10 @@ endif
 # of the targets gets built.
 FORCE_TARGETS ?=
 
-# Clear LDFLAGS and MAKEFLAGS if called from main
-# Makefile to avoid test build failures when test
-# Makefile doesn't have explicit build rules.
-ifeq (1,$(MAKELEVEL))
+# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
+# implicit rules to sub-test Makefiles which avoids build failures in test
+# Makefile that don't have explicit build rules.
+ifeq (,$(LINK.c))
 override LDFLAGS =
 override MAKEFLAGS =
 endif
@@ -206,6 +206,7 @@ KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
 # Avoid changing the rest of the logic here and lib.mk.
 INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
+TEST_LIST := $(INSTALL_PATH)/kselftest-list.txt
 
 install: all
 ifdef INSTALL_PATH
@@ -214,6 +215,8 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/module.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
+	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
+	rm -f $(TEST_LIST)
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
@@ -222,33 +225,18 @@ ifdef INSTALL_PATH
 		ret=$$((ret * $$?));		\
 	done; exit $$ret;
 
-	@# Ask all targets to emit their test scripts
-	echo "#!/bin/sh" > $(ALL_SCRIPT)
-	echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
-	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
-	echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
-	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
-	echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
-	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
-	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
-	echo "fi" >> $(ALL_SCRIPT)
 
-	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
+	@# Ask all targets to emit their test scripts
+	@# While building kselftest-list.text skip also non-existent TARGET dirs:
 	@# they could be the result of a build failure and should NOT be
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
-		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
-		echo -n "run_many" >> $(ALL_SCRIPT); \
 		echo -n "Emit Tests for $$TARGET\n"; \
-		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
-		echo "" >> $(ALL_SCRIPT);	    \
-		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
+		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
+			-C $$TARGET emit_tests >> $(TEST_LIST); \
 	done;
-
-	chmod u+x $(ALL_SCRIPT)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
diff --git a/tools/testing/selftests/firmware/.gitignore b/tools/testing/selftests/firmware/.gitignore
new file mode 100644
index 000000000000..62abc92a94c4
--- /dev/null
+++ b/tools/testing/selftests/firmware/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fw_namespace
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7a17ea815736..30848ca36555 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -47,9 +47,9 @@ ARCH		?= $(SUBARCH)
 khdr:
 ifndef KSFT_KHDR_INSTALL_DONE
 ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
 else
-	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
+	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
 		ARCH=$(ARCH) -C $(top_srcdir) headers_install
 endif
 endif
@@ -107,9 +107,8 @@ endif
 emit_tests:
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
-		echo "	\\";				\
-		echo -n "	\"$$BASENAME_TEST\"";	\
-	done;						\
+		echo "$(COLLECTION):$$BASENAME_TEST";	\
+	done
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
diff --git a/tools/testing/selftests/netfilter/.gitignore b/tools/testing/selftests/netfilter/.gitignore
new file mode 100644
index 000000000000..8448f74adfec
--- /dev/null
+++ b/tools/testing/selftests/netfilter/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+nf-queue
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 7bebf9534a86..792318aaa30c 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
 peeksiginfo
+vmaccess
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
new file mode 100755
index 000000000000..609a4ef9300e
--- /dev/null
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Run installed kselftest tests.
+#
+BASE_DIR=$(realpath $(dirname $0))
+cd $BASE_DIR
+TESTS="$BASE_DIR"/kselftest-list.txt
+if [ ! -r "$TESTS" ] ; then
+	echo "$0: Could not find list of tests to run ($TESTS)" >&2
+	available=""
+else
+	available="$(cat "$TESTS")"
+fi
+
+. ./kselftest/runner.sh
+ROOT=$PWD
+
+usage()
+{
+	cat <<EOF
+Usage: $0 [OPTIONS]
+  -s | --summary		Print summary with detailed log in output.log
+  -t | --test COLLECTION:TEST	Run TEST from COLLECTION
+  -c | --collection COLLECTION	Run all tests from COLLECTION
+  -l | --list			List the available collection:test entries
+  -d | --dry-run		Don't actually run any tests
+  -h | --help			Show this usage info
+EOF
+	exit $1
+}
+
+COLLECTIONS=""
+TESTS=""
+dryrun=""
+while true; do
+	case "$1" in
+		-s | --summary)
+			logfile="$BASE_DIR"/output.log
+			cat /dev/null > $logfile
+			shift ;;
+		-t | --test)
+			TESTS="$TESTS $2"
+			shift 2 ;;
+		-c | --collection)
+			COLLECTIONS="$COLLECTIONS $2"
+			shift 2 ;;
+		-l | --list)
+			echo "$available"
+			exit 0 ;;
+		-n | --dry-run)
+			dryrun="echo"
+			shift ;;
+		-h | --help)
+			usage 0 ;;
+		"")
+			break ;;
+		*)
+			usage 1 ;;
+	esac
+done
+
+# Add all selected collections to the explicit test list.
+if [ -n "$COLLECTIONS" ]; then
+	for collection in $COLLECTIONS ; do
+		found="$(echo "$available" | grep "^$collection:")"
+		if [ -z "$found" ] ; then
+			echo "No such collection '$collection'" >&2
+			exit 1
+		fi
+		TESTS="$TESTS $found"
+	done
+fi
+# Replace available test list with explicitly selected tests.
+if [ -n "$TESTS" ]; then
+	valid=""
+	for test in $TESTS ; do
+		found="$(echo "$available" | grep "^${test}$")"
+		if [ -z "$found" ] ; then
+			echo "No such test '$test'" >&2
+			exit 1
+		fi
+		valid="$valid $found"
+	done
+	available="$(echo "$valid" | sed -e 's/ /\n/g')"
+fi
+
+collections=$(echo "$available" | cut -d: -f1 | uniq)
+for collection in $collections ; do
+	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
+	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
+	($dryrun cd "$collection" && $dryrun run_many $tests)
+done

--------------FFFB3B08D01412D12F7B500D--
