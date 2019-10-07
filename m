Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A2CEE21
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJGVDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 17:03:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46293 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfJGVC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 17:02:59 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so31740271ioo.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=dlHnClK45+xK8TgptSlbn0Igt59Q2MEBn/0ZQG8FWVM=;
        b=fKq740neOno3lchw1/sjyy8GaeL1LwwCTvyNrPESM9i6aa0nqgVSHamACENPddKiho
         BlguCFv/tpxKamyt/NriQVfOto6sJ8+WegNjF5hq877VmDnHt7L1T39ObsPg7V0mp3sd
         zWdV1EN1gJ8mwlfq2EusC4Nt930U92jC2rA+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=dlHnClK45+xK8TgptSlbn0Igt59Q2MEBn/0ZQG8FWVM=;
        b=IqSvkPNIweqjA0FF0YlEiz7c4fipvv0Lq9BoMFhTVmSupdIR4CQaamm4zN+6fbnFqO
         PklnnhvvmFBeYQQubJF2fT0tYuRcrfAReYJTH6FRP49lxUmOEuF6/aBi6eoVPJvsSyO5
         6ShGEa7eJ79qIlrt3uKLlXDVO16rnYlb+94uTHk+LkpLuZrSVG3YNln6e+HrYhdD6n21
         tMi/vtRi6sw30f/U9MQUzWXg1ojE0S6gPlykWMOISq2Dagrw7QTDTS331lEG1gW0LjCq
         wYBqvrv8iJ0gxl9+MuqORKNOb37wOBYlA+uKjRIPZot9KXFaP6o6zXjY0e5XuVVp3ZfP
         zeyA==
X-Gm-Message-State: APjAAAVAeRjns1VehmPNjrxlNjgOIyVVT7rIfCq95FcWhXR0+xdOdEp3
        MCXms0Nblzi1yTOtPHGsrvnn+Q==
X-Google-Smtp-Source: APXvYqwvIJ2EoZCEQERYwYD0M8Ed58Bp7vSSxe/txQVTQM3Qcr20gMiFnV8Nv8qek4iE8OyWukkHng==
X-Received: by 2002:a5e:aa10:: with SMTP id s16mr15350319ioe.21.1570482177076;
        Mon, 07 Oct 2019 14:02:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w16sm8006792ilc.62.2019.10.07.14.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 14:02:56 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.4-rc3
Message-ID: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
Date:   Mon, 7 Oct 2019 15:02:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A8F0D94AF098AD7E161F07AF"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------A8F0D94AF098AD7E161F07AF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.4-rc3.

This Kselftest update for Linux 5.4-rc3 consists fixes for existing
tests and the framework. Cristian Marussi's patches add ability to
skip targets (tests) and exclude tests that didn't build from run-list.
These patches improve the Kselftest results. Ability to skip targets
helps avoid running tests that aren't supported in certain environments.
As an example, bpf tests from mainline aren't supported on stable
kernels and have dependency on bleeding edge llvm. Being able to skip
bpf on systems that can't meet this llvm dependency will be helpful.

Kselftest can be built and installed from the main Makefile. This change
help simplify Kselftest use-cases which addresses request from users.

Kees Cook added per test timeout support to limit individual test
run-time.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.4-rc3

for you to fetch changes up to ce3a677802121e038d2f062e90f96f84e7351da0:

   selftests: watchdog: Add command line option to show watchdog_info 
(2019-10-02 13:44:43 -0600)

----------------------------------------------------------------
linux-kselftest-5.4-rc3

This Kselftest update for Linux 5.4-rc3 consists fixes for existing
tests and the framework. Cristian Marussi's patches add ability to
skip targets (tests) and exclude tests that didn't build from run-list.
These patches improve the Kselftest results. Ability to skip targets
helps avoid running tests that aren't supported in certain environments.
As an example, bpf tests from mainline aren't supported on stable kernels
and have dependency on bleeding edge llvm. Being able to skip bpf on
systems that can't meet this llvm dependency will be helpful.

Kselftest can be built and installed from the main Makefile. This change
help simplify Kselftest use-cases which addresses request from users.

Kees Cook added per test timeout support to limit individual test run-time.

----------------------------------------------------------------
Cristian Marussi (2):
       kselftest: add capability to skip chosen TARGETS
       kselftest: exclude failed TARGETS from runlist

George G. Davis (2):
       selftests: watchdog: Validate optional file argument
       selftests: watchdog: Add command line option to show watchdog_info

Kees Cook (1):
       selftests/kselftest/runner.sh: Add 45 second timeout per test

Shuah Khan (1):
       selftests: Add kselftest-all and kselftest-install targets

  Documentation/dev-tools/kselftest.rst            | 16 +++++++++++
  Makefile                                         |  5 ++--
  tools/testing/selftests/Makefile                 | 19 +++++++++++--
  tools/testing/selftests/kselftest/runner.sh      | 36 
++++++++++++++++++++++--
  tools/testing/selftests/kselftest_install.sh     |  4 +--
  tools/testing/selftests/rtc/settings             |  1 +
  tools/testing/selftests/watchdog/watchdog-test.c | 27 +++++++++++++++++-
  7 files changed, 97 insertions(+), 11 deletions(-)
  create mode 100644 tools/testing/selftests/rtc/settings

----------------------------------------------------------------

--------------A8F0D94AF098AD7E161F07AF
Content-Type: text/x-patch;
 name="linux-kselftest-5.4-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.4-rc3.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 25604904fa6e..ecdfdc9d4b03 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -89,6 +89,22 @@ To build, save output files in a separate directory with KBUILD_OUTPUT ::
 
   $ export KBUILD_OUTPUT=/tmp/kselftest; make TARGETS="size timers" kselftest
 
+Additionally you can use the "SKIP_TARGETS" variable on the make command
+line to specify one or more targets to exclude from the TARGETS list.
+
+To run all tests but a single subsystem::
+
+  $ make -C tools/testing/selftests SKIP_TARGETS=ptrace run_tests
+
+You can specify multiple tests to skip::
+
+  $  make SKIP_TARGETS="size timers" kselftest
+
+You can also specify a restricted list of tests to run together with a
+dedicated skiplist::
+
+  $  make TARGETS="bpf breakpoints size timers" SKIP_TARGETS=bpf kselftest
+
 See the top-level tools/testing/selftests/Makefile for the list of all
 possible targets.
 
diff --git a/Makefile b/Makefile
index 6f54f2f95743..02f7ede2f344 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,9 +1237,8 @@ PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-PHONY += kselftest-clean
-kselftest-clean:
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
+kselftest-%: FORCE
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
 kselftest-merge:
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..4cdbae6f4e61 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -63,6 +63,13 @@ TARGETS += zram
 TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
+# User can optionally provide a TARGETS skiplist.
+SKIP_TARGETS ?=
+ifneq ($(SKIP_TARGETS),)
+	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
+	override TARGETS := $(TMP)
+endif
+
 # Clear LDFLAGS and MAKEFLAGS if called from main
 # Makefile to avoid test build failures when test
 # Makefile doesn't have explicit build rules.
@@ -171,9 +178,12 @@ run_pstore_crash:
 # 1. output_dir=kernel_src
 # 2. a separate output directory is specified using O= KBUILD_OUTPUT
 # 3. a separate output directory is specified using KBUILD_OUTPUT
+# Avoid conflict with INSTALL_PATH set by the main Makefile
 #
-INSTALL_PATH ?= $(BUILD)/install
-INSTALL_PATH := $(abspath $(INSTALL_PATH))
+KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
+KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
+# Avoid changing the rest of the logic here and lib.mk.
+INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 
 install: all
@@ -198,11 +208,16 @@ ifdef INSTALL_PATH
 	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
 
+	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
+	@# they could be the result of a build failure and should NOT be
+	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
+		echo -n "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 00c9020bdda8..84de7bc74f2c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -3,9 +3,14 @@
 #
 # Runs a set of tests in a given subdirectory.
 export skip_rc=4
+export timeout_rc=124
 export logfile=/dev/stdout
 export per_test_logging=
 
+# Defaults for "settings" file fields:
+# "timeout" how many seconds to let each test run before failing.
+export kselftest_default_timeout=45
+
 # There isn't a shell-agnostic way to find the path of a sourced file,
 # so we must rely on BASE_DIR being set to find other tools.
 if [ -z "$BASE_DIR" ]; then
@@ -24,6 +29,16 @@ tap_prefix()
 	fi
 }
 
+tap_timeout()
+{
+	# Make sure tests will time out if utility is available.
+	if [ -x /usr/bin/timeout ] ; then
+		/usr/bin/timeout "$kselftest_timeout" "$1"
+	else
+		"$1"
+	fi
+}
+
 run_one()
 {
 	DIR="$1"
@@ -32,6 +47,18 @@ run_one()
 
 	BASENAME_TEST=$(basename $TEST)
 
+	# Reset any "settings"-file variables.
+	export kselftest_timeout="$kselftest_default_timeout"
+	# Load per-test-directory kselftest "settings" file.
+	settings="$BASE_DIR/$DIR/settings"
+	if [ -r "$settings" ] ; then
+		while read line ; do
+			field=$(echo "$line" | cut -d= -f1)
+			value=$(echo "$line" | cut -d= -f2-)
+			eval "kselftest_$field"="$value"
+		done < "$settings"
+	fi
+
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
 	if [ ! -x "$TEST" ]; then
@@ -44,14 +71,17 @@ run_one()
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
 		cd `dirname $TEST` > /dev/null
-		(((((./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
-		(if [ $? -eq $skip_rc ]; then	\
+		(rc=$?;	\
+		if [ $rc -eq $skip_rc ]; then	\
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+		elif [ $rc -eq $timeout_rc ]; then \
+			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
 		else
-			echo "not ok $test_num $TEST_HDR_MSG"
+			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
 		cd - >/dev/null
 	fi
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
index ec304463883c..e2e1911d62d5 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -24,12 +24,12 @@ main()
 		echo "$0: Installing in specified location - $install_loc ..."
 	fi
 
-	install_dir=$install_loc/kselftest
+	install_dir=$install_loc/kselftest_install
 
 # Create install directory
 	mkdir -p $install_dir
 # Build tests
-	INSTALL_PATH=$install_dir make install
+	KSFT_INSTALL_PATH=$install_dir make install
 }
 
 main "$@"
diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/rtc/settings
@@ -0,0 +1 @@
+timeout=90
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index afff120c7be6..f45e510500c0 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -19,7 +19,7 @@
 
 int fd;
 const char v = 'V';
-static const char sopts[] = "bdehp:t:Tn:NLf:";
+static const char sopts[] = "bdehp:t:Tn:NLf:i";
 static const struct option lopts[] = {
 	{"bootstatus",          no_argument, NULL, 'b'},
 	{"disable",             no_argument, NULL, 'd'},
@@ -32,6 +32,7 @@ static const struct option lopts[] = {
 	{"getpretimeout",       no_argument, NULL, 'N'},
 	{"gettimeleft",		no_argument, NULL, 'L'},
 	{"file",          required_argument, NULL, 'f'},
+	{"info",		no_argument, NULL, 'i'},
 	{NULL,                  no_argument, NULL, 0x0}
 };
 
@@ -72,6 +73,7 @@ static void usage(char *progname)
 	printf("Usage: %s [options]\n", progname);
 	printf(" -f, --file\t\tOpen watchdog device file\n");
 	printf("\t\t\tDefault is /dev/watchdog\n");
+	printf(" -i, --info\t\tShow watchdog_info\n");
 	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
 	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
 	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
@@ -97,6 +99,7 @@ int main(int argc, char *argv[])
 	int c;
 	int oneshot = 0;
 	char *file = "/dev/watchdog";
+	struct watchdog_info info;
 
 	setbuf(stdout, NULL);
 
@@ -118,6 +121,16 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	/*
+	 * Validate that `file` is a watchdog device
+	 */
+	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
+	if (ret) {
+		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
+		close(fd);
+		exit(ret);
+	}
+
 	optind = 0;
 
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
@@ -205,6 +218,18 @@ int main(int argc, char *argv[])
 		case 'f':
 			/* Handled above */
 			break;
+		case 'i':
+			/*
+			 * watchdog_info was obtained as part of file open
+			 * validation. So we just show it here.
+			 */
+			oneshot = 1;
+			printf("watchdog_info:\n");
+			printf(" identity:\t\t%s\n", info.identity);
+			printf(" firmware_version:\t%u\n",
+			       info.firmware_version);
+			printf(" options:\t\t%08x\n", info.options);
+			break;
 
 		default:
 			usage(argv[0]);

--------------A8F0D94AF098AD7E161F07AF--
