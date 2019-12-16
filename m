Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01712182E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 19:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLPSlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 13:41:52 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44165 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfLPSAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:54 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so6112705iln.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=KSUAdhz+vIugIss82NFyhlKndLXwafhdT+xyyXHhYHY=;
        b=As+0EmrmSyvB/2LCKTrQXc/ECwVdW73EFgcs7EUEzl3hCzPsmAUGgN22M8ITSVivLX
         nDiQMuqRWYkYhMFr0GIkdhWkXrknrovGAv+Wfvz3b58ytTXB+qzGgUeULyOrbJLPN7PJ
         a+pWI/+/8178e+piJe+n93UahUfVP/jOIXOKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=KSUAdhz+vIugIss82NFyhlKndLXwafhdT+xyyXHhYHY=;
        b=OP/tJC+hig8hayAUG1fr9ePxYo70gIVPQOUosx6xAMTlX6Mvb2MoUgpFA8x97IPMlg
         0vcScuzSorAtlTaIvKnxpUL7ReSshvPFpyBRlSPaOq9cYY8khEuSLc1KK8ZRb386LKFl
         IRe5GtNY82HFqOLfDLXwKrjxgTH8l8LPQDGqFwW2W5h+sfewgosYnGAurEaJ/gAsj9Nh
         QYqyn7lTSAIV5zgxjOLfqUjKVlX0aWvIV1db0WNAAphWwi4X+p/GfHX/pbobvS7WO0V5
         p+RoNMackfqsRp99/yrek+PUSNFshGvAduoWU5SA3JGryRNQcm93BFjQWkH1tpsQSAEX
         HOhw==
X-Gm-Message-State: APjAAAUEbKw7pWQ5RM3Qu+uXgTEtN+zqkRMkXfB1DYLYzYsb2TcG6UOq
        fsdpylrpN0uclgxlrq9VDWXdfw==
X-Google-Smtp-Source: APXvYqzsq8qWcwv737mGIpKtsb5AHF8xbPZ2rX0ut/NnO5TFbqdOIStN3iq8MrNNdFyLVCnu1OQh6g==
X-Received: by 2002:a92:160a:: with SMTP id r10mr7234221ill.14.1576519253421;
        Mon, 16 Dec 2019 10:00:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l4sm3424376ioa.9.2019.12.16.10.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:00:52 -0800 (PST)
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.5-rc3
Message-ID: <57894f9b-3cd0-f42d-cdc2-e3b8cb7255ab@linuxfoundation.org>
Date:   Mon, 16 Dec 2019 11:00:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0512B299E187455BF371CC22"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------0512B299E187455BF371CC22
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.5-rc3.

This Kselftest fixes update for Linux 5.5-rc2 consists of

-- ftrace and safesetid test fixes from Masami Hiramatsu
-- Kunit fixes from Brendan Higgins, Iurii Zaikin, and Heidi Fahim
-- Kselftest framework fixes from SeongJae Park and Michael Ellerman

I was planning to send this for rc2 and ran into kernel.org outage
and decided to wait on it.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.5-rc2

for you to fetch changes up to 4eac734486fd431e0756cc5e929f140911a36a53:

   kselftest: Support old perl versions (2019-12-11 10:31:16 -0700)

----------------------------------------------------------------
linux-kselftest-5.5-rc2

This Kselftest fixes update for Linux 5.5-rc2 consists of

-- ftrace and safesetid test fixes from Masami Hiramatsu
-- Kunit fixes from Brendan Higgins, Iurii Zaikin, and Heidi Fahim
-- Kselftest framework fixes from SeongJae Park and Michael Ellerman

----------------------------------------------------------------
Brendan Higgins (2):
       Documentation: kunit: fix typos and gramatical errors
       Documentation: kunit: add documentation for kunit_tool

Heidi Fahim (1):
       kunit: testing kunit: Bug fix in test_run_timeout function

Iurii Zaikin (1):
       fs/ext4/inode-test: Fix inode test on 32 bit platforms.

Masami Hiramatsu (7):
       selftests/ftrace: Fix to check the existence of set_ftrace_filter
       selftests/ftrace: Fix ftrace test cases to check unsupported
       selftests/ftrace: Do not to use absolute debugfs path
       selftests/ftrace: Fix multiple kprobe testcase
       selftests: safesetid: Move link library to LDLIBS
       selftests: safesetid: Check the return value of setuid/setgid
       selftests: safesetid: Fix Makefile to set correct test program

Michael Ellerman (1):
       selftests: Fix dangling documentation references to 
kselftest_module.sh

SeongJae Park (2):
       kselftest/runner: Print new line in print of timeout log
       kselftest: Support old perl versions

  Documentation/dev-tools/kselftest.rst              |  8 +--
  Documentation/dev-tools/kunit/index.rst            |  1 +
  Documentation/dev-tools/kunit/kunit-tool.rst       | 57 
++++++++++++++++++++++
  Documentation/dev-tools/kunit/start.rst            | 13 +++--
  Documentation/dev-tools/kunit/usage.rst            | 24 ++++-----
  fs/ext4/inode-test.c                               |  2 +-
  tools/testing/kunit/kunit_tool_test.py             |  2 +-
  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  2 +
  .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |  5 ++
  tools/testing/selftests/ftrace/test.d/functions    |  5 +-
  .../ftrace/test.d/kprobe/multiple_kprobes.tc       |  6 +--
.../inter-event/trigger-action-hist-xfail.tc       |  4 +-
  .../inter-event/trigger-onchange-action-hist.tc    |  2 +-
  .../inter-event/trigger-snapshot-action-hist.tc    |  4 +-
  tools/testing/selftests/kselftest/module.sh        |  2 +-
  tools/testing/selftests/kselftest/prefix.pl        |  1 +
  tools/testing/selftests/kselftest/runner.sh        |  1 +
  tools/testing/selftests/safesetid/Makefile         |  5 +-
  tools/testing/selftests/safesetid/safesetid-test.c | 15 ++++--
  19 files changed, 119 insertions(+), 40 deletions(-)
  create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst

----------------------------------------------------------------

--------------0512B299E187455BF371CC22
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.5-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.5-rc2.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ecdfdc9d4b03..61ae13c44f91 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -203,12 +203,12 @@ Test Module
 Kselftest tests the kernel from userspace.  Sometimes things need
 testing from within the kernel, one method of doing this is to create a
 test module.  We can tie the module into the kselftest framework by
-using a shell script test runner.  ``kselftest_module.sh`` is designed
+using a shell script test runner.  ``kselftest/module.sh`` is designed
 to facilitate this process.  There is also a header file provided to
 assist writing kernel modules that are for use with kselftest:
 
 - ``tools/testing/kselftest/kselftest_module.h``
-- ``tools/testing/kselftest/kselftest_module.sh``
+- ``tools/testing/kselftest/kselftest/module.sh``
 
 How to use
 ----------
@@ -247,7 +247,7 @@ A bare bones test module might look like this:
 
    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-   #include "../tools/testing/selftests/kselftest_module.h"
+   #include "../tools/testing/selftests/kselftest/module.h"
 
    KSTM_MODULE_GLOBALS();
 
@@ -276,7 +276,7 @@ Example test script
 
     #!/bin/bash
     # SPDX-License-Identifier: GPL-2.0+
-    $(dirname $0)/../kselftest_module.sh "foo" test_foo
+    $(dirname $0)/../kselftest/module.sh "foo" test_foo
 
 
 Test Harness
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 26ffb46bdf99..c60d760a0eed 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
 
 	start
 	usage
+	kunit-tool
 	api/index
 	faq
 
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
new file mode 100644
index 000000000000..50d46394e97e
--- /dev/null
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+kunit_tool How-To
+=================
+
+What is kunit_tool?
+===================
+
+kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
+the Linux kernel as UML (`User Mode Linux
+<http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
+the test results and displaying them in a user friendly manner.
+
+What is a kunitconfig?
+======================
+
+It's just a defconfig that kunit_tool looks for in the base directory.
+kunit_tool uses it to generate a .config as you might expect. In addition, it
+verifies that the generated .config contains the CONFIG options in the
+kunitconfig; the reason it does this is so that it is easy to be sure that a
+CONFIG that enables a test actually ends up in the .config.
+
+How do I use kunit_tool?
+========================
+
+If a kunitconfig is present at the root directory, all you have to do is:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run
+
+However, you most likely want to use it with the following options:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
+
+- ``--timeout`` sets a maximum amount of time to allow tests to run.
+- ``--jobs`` sets the number of threads to use to build the kernel.
+
+If you just want to use the defconfig that ships with the kernel, you can
+append the ``--defconfig`` flag as well:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all` --defconfig
+
+.. note::
+	This command is particularly helpful for getting started because it
+	just works. No kunitconfig needs to be present.
+
+For a list of all the flags supported by kunit_tool, you can run:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --help
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index aeeddfafeea2..9d6db892c41c 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -19,11 +19,14 @@ The wrapper can be run with:
 
 .. code-block:: bash
 
-   ./tools/testing/kunit/kunit.py run
+	./tools/testing/kunit/kunit.py run --defconfig
+
+For more information on this wrapper (also called kunit_tool) checkout the
+:doc:`kunit-tool` page.
 
 Creating a kunitconfig
 ======================
-The Python script is a thin wrapper around Kbuild as such, it needs to be
+The Python script is a thin wrapper around Kbuild. As such, it needs to be
 configured with a ``kunitconfig`` file. This file essentially contains the
 regular Kernel config, with the specific test targets as well.
 
@@ -59,8 +62,8 @@ If everything worked correctly, you should see the following:
 followed by a list of tests that are run. All of them should be passing.
 
 .. note::
-   Because it is building a lot of sources for the first time, the ``Building
-   kunit kernel`` step may take a while.
+	Because it is building a lot of sources for the first time, the
+	``Building KUnit kernel`` step may take a while.
 
 Writing your first test
 =======================
@@ -159,7 +162,7 @@ Now you can run the test:
 
 .. code-block:: bash
 
-	./tools/testing/kunit/kunit.py
+	./tools/testing/kunit/kunit.py run
 
 You should see the following failure:
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c6e69634e274..b9a065ab681e 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -16,7 +16,7 @@ Organization of this document
 =============================
 
 This document is organized into two main sections: Testing and Isolating
-Behavior. The first covers what a unit test is and how to use KUnit to write
+Behavior. The first covers what unit tests are and how to use KUnit to write
 them. The second covers how to use KUnit to isolate code and make it possible
 to unit test code that was otherwise un-unit-testable.
 
@@ -174,13 +174,13 @@ Test Suites
 ~~~~~~~~~~~
 
 Now obviously one unit test isn't very helpful; the power comes from having
-many test cases covering all of your behaviors. Consequently it is common to
-have many *similar* tests; in order to reduce duplication in these closely
-related tests most unit testing frameworks provide the concept of a *test
-suite*, in KUnit we call it a *test suite*; all it is is just a collection of
-test cases for a unit of code with a set up function that gets invoked before
-every test cases and then a tear down function that gets invoked after every
-test case completes.
+many test cases covering all of a unit's behaviors. Consequently it is common
+to have many *similar* tests; in order to reduce duplication in these closely
+related tests most unit testing frameworks - including KUnit - provide the
+concept of a *test suite*. A *test suite* is just a collection of test cases
+for a unit of code with a set up function that gets invoked before every test
+case and then a tear down function that gets invoked after every test case
+completes.
 
 Example:
 
@@ -211,7 +211,7 @@ KUnit test framework.
 .. note::
    A test case will only be run if it is associated with a test suite.
 
-For a more information on these types of things see the :doc:`api/test`.
+For more information on these types of things see the :doc:`api/test`.
 
 Isolating Behavior
 ==================
@@ -338,7 +338,7 @@ We can easily test this code by *faking out* the underlying EEPROM:
 		return count;
 	}
 
-	ssize_t fake_eeprom_write(struct eeprom *this, size_t offset, const char *buffer, size_t count)
+	ssize_t fake_eeprom_write(struct eeprom *parent, size_t offset, const char *buffer, size_t count)
 	{
 		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
 
@@ -454,7 +454,7 @@ KUnit on non-UML architectures
 By default KUnit uses UML as a way to provide dependencies for code under test.
 Under most circumstances KUnit's usage of UML should be treated as an
 implementation detail of how KUnit works under the hood. Nevertheless, there
-are instances where being able to run architecture specific code, or test
+are instances where being able to run architecture specific code or test
 against real hardware is desirable. For these reasons KUnit supports running on
 other architectures.
 
@@ -557,7 +557,7 @@ run your tests on your hardware setup just by compiling for your architecture.
 .. important::
    Always prefer tests that run on UML to tests that only run under a particular
    architecture, and always prefer tests that run under QEMU or another easy
-   (and monitarily free) to obtain software environment to a specific piece of
+   (and monetarily free) to obtain software environment to a specific piece of
    hardware.
 
 Nevertheless, there are still valid reasons to write an architecture or hardware
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 92a9da1774aa..bbce1c328d85 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -25,7 +25,7 @@
  * For constructing the negative timestamp lower bound value.
  * binary: 10000000 00000000 00000000 00000000
  */
-#define LOWER_MSB_1 (-0x80000000L)
+#define LOWER_MSB_1 (-(UPPER_MSB_0) - 1L)  /* avoid overflow */
 /*
  * For constructing the negative timestamp upper bound value.
  * binary: 11111111 11111111 11111111 11111111
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 4a12baa0cd4e..a2a8ea6beae3 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -199,7 +199,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
index 36fb59f886ea..1a52f2883fe0 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -3,6 +3,8 @@
 # description: ftrace - stacktrace filter command
 # flags: instance
 
+[ ! -f set_ftrace_filter ] && exit_unsupported
+
 echo _do_fork:stacktrace >> set_ftrace_filter
 
 grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
index 86a1f07ef2ca..71fa3f49e35e 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
   exit_unresolved
 fi
 
+if ! grep -q "function" available_tracers ; then
+  echo "Function trace is not enabled"
+  exit_unsupported
+fi
+
 ORIG_CPUMASK=`cat tracing_cpumask`
 
 do_reset() {
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 86986c4bba54..5d4550591ff9 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -46,6 +46,9 @@ reset_events_filter() { # reset all current setting filters
 }
 
 reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+    if [ ! -f set_ftrace_filter ]; then
+      return 0
+    fi
     echo > set_ftrace_filter
     grep -v '^#' set_ftrace_filter | while read t; do
 	tr=`echo $t | cut -d: -f2`
@@ -93,7 +96,7 @@ initialize_ftrace() { # Reset ftrace to initial-state
     disable_events
     [ -f set_event_pid ] && echo > set_event_pid
     [ -f set_ftrace_pid ] && echo > set_ftrace_pid
-    [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
+    [ -f set_ftrace_notrace ] && echo > set_ftrace_notrace
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
     [ -f kprobe_events ] && echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 5862eee91e1d..6e3dbe5f96b7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -20,9 +20,9 @@ while read i; do
   test $N -eq 256 && break
 done
 
-L=`wc -l kprobe_events`
-if [ $L -ne $N ]; then
-  echo "The number of kprobes events ($L) is not $N"
+L=`cat kprobe_events | wc -l`
+if [ $L -ne 256 ]; then
+  echo "The number of kprobes events ($L) is not 256"
   exit_fail
 fi
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
index 1221240f8cf6..3f2aee115f6e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-action-hist-xfail.tc
@@ -21,10 +21,10 @@ grep -q "snapshot()" README || exit_unsupported # version issue
 
 echo "Test expected snapshot action failure"
 
-echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >> events/sched/sched_waking/trigger && exit_fail
 
 echo "Test expected save action failure"
 
-echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger && exit_fail
+echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)' >> events/sched/sched_waking/trigger && exit_fail
 
 exit_xfail
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 064a284e4e75..c80007aa9f86 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -16,7 +16,7 @@ grep -q "onchange(var)" README || exit_unsupported # version issue
 
 echo "Test onchange action"
 
-echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
 
 ping $LOCALHOST -c 3
 nice -n 1 ping $LOCALHOST -c 3
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 18fff69fc433..f546c1b66a9b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -23,9 +23,9 @@ grep -q "snapshot()" README || exit_unsupported # version issue
 
 echo "Test snapshot action"
 
-echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+echo 1 > events/sched/enable
 
-echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> events/sched/sched_waking/trigger
 
 ping $LOCALHOST -c 3
 nice -n 1 ping $LOCALHOST -c 3
diff --git a/tools/testing/selftests/kselftest/module.sh b/tools/testing/selftests/kselftest/module.sh
index 18e1c7992d30..fb4733faff12 100755
--- a/tools/testing/selftests/kselftest/module.sh
+++ b/tools/testing/selftests/kselftest/module.sh
@@ -9,7 +9,7 @@
 #
 #   #!/bin/sh
 #   SPDX-License-Identifier: GPL-2.0+
-#   $(dirname $0)/../kselftest_module.sh "description" module_name
+#   $(dirname $0)/../kselftest/module.sh "description" module_name
 #
 # Example: tools/testing/selftests/lib/printf.sh
 
diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
index ec7e48118183..31f7c2a0a8bd 100755
--- a/tools/testing/selftests/kselftest/prefix.pl
+++ b/tools/testing/selftests/kselftest/prefix.pl
@@ -3,6 +3,7 @@
 # Prefix all lines with "# ", unbuffered. Command being piped in may need
 # to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
 use strict;
+use IO::Handle;
 
 binmode STDIN;
 binmode STDOUT;
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..a8d20cbb711c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -79,6 +79,7 @@ run_one()
 		if [ $rc -eq $skip_rc ]; then	\
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
+			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index 98da7a504737..fa02c4d5ec13 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -Wall -lcap -O2
+CFLAGS = -Wall -O2
+LDLIBS = -lcap
 
-TEST_PROGS := run_tests.sh
+TEST_PROGS := safesetid-test.sh
 TEST_GEN_FILES := safesetid-test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 8f40c6ecdad1..0c4d50644c13 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -213,7 +213,8 @@ static void test_setuid(uid_t child_uid, bool expect_success)
 	}
 
 	if (cpid == 0) {	    /* Code executed by child */
-		setuid(child_uid);
+		if (setuid(child_uid) < 0)
+			exit(EXIT_FAILURE);
 		if (getuid() == child_uid)
 			exit(EXIT_SUCCESS);
 		else
@@ -291,8 +292,10 @@ int main(int argc, char **argv)
 
 	// First test to make sure we can write userns mappings from a user
 	// that doesn't have any restrictions (as long as it has CAP_SETUID);
-	setuid(NO_POLICY_USER);
-	setgid(NO_POLICY_USER);
+	if (setuid(NO_POLICY_USER) < 0)
+		die("Error with set uid(%d)\n", NO_POLICY_USER);
+	if (setgid(NO_POLICY_USER) < 0)
+		die("Error with set gid(%d)\n", NO_POLICY_USER);
 
 	// Take away all but setid caps
 	drop_caps(true);
@@ -306,8 +309,10 @@ int main(int argc, char **argv)
 		die("test_userns failed when it should work\n");
 	}
 
-	setuid(RESTRICTED_PARENT);
-	setgid(RESTRICTED_PARENT);
+	if (setuid(RESTRICTED_PARENT) < 0)
+		die("Error with set uid(%d)\n", RESTRICTED_PARENT);
+	if (setgid(RESTRICTED_PARENT) < 0)
+		die("Error with set gid(%d)\n", RESTRICTED_PARENT);
 
 	test_setuid(ROOT_USER, false);
 	test_setuid(ALLOWED_CHILD1, true);

--------------0512B299E187455BF371CC22--
