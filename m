Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30D35D480
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhDMAlq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 20:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhDMAlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 20:41:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6AC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:41:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so14394373ybf.12
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vH+aY5sKXJkDs8jsVbkpjqnXz1Xvj6HvHJjjppBr9BA=;
        b=grCsILMmw3YXjmVUSW69na7/7CNd/G5rNIh44l2CNqkDnHw2T8Gh5+fS8LDy9j8D7v
         f1K0cu61OApqTj/laAkJwMP3By9XaSBMCWg0bK+FEiDD5HkBJNH1N72a9j69fi3Kkr7z
         hovzLIagNv3YMOSEvkxRTtQtfq1tEqUf+mX+3R2udQOQVUr4ORFUTsnt8HMpujGBRHgr
         IwERFbnxkAaz1whijXZuqwxccw2h+Jf8nUXft+zCZyWaDHkE98rZfnTsQMWj5uTx04iM
         mx0fAlxGSsiSeIs7sijRz90DvN00o3N3yU/ErKHlAXMyJhd3TxSfgwip1pj8rikS4VHC
         o50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vH+aY5sKXJkDs8jsVbkpjqnXz1Xvj6HvHJjjppBr9BA=;
        b=UgHJY2/H/NTJF0iIAjGCLb0OFXCWhVM06A+5uIfCx+L+I7zYelP2vpMDUPDQU6xCvg
         gdIwRJzUOuv346/S2CbGlKMGAw2fTKhykE3I/l1V3qx+5/Lsq9uCjSe54KqR1UeYNUZ/
         X2kbQdDc4ivJRgM4mb5fEQhSMgdebqy0law2dwSsEhAi2ecgZWA2zdz2AcHODNYd2BtS
         QivEsAc4tK3jl22u0BKCyO6tV/yz9h18Z6Crw2io7Kp6so4DCfwACcuwAuLCUSr9i4bO
         giIkZPyaUJ19b4y03PgD577zarEkScftq4abO9XUtdQi/sAF7503I+TIgrC8wamIDXxk
         DENA==
X-Gm-Message-State: AOAM532hct9DfSz0Yl6+JpDN9nyV2omesdNa+m4r9dLRKzktpE6R1VMT
        9rUaChAPORwN9Xm1Y6I8ybBpM+5MJwCpSQ==
X-Google-Smtp-Source: ABdhPJz4tAO0w3tS6VI3WRmLLvpIM8ndmqH0OvEuAlmNA7aWtVKS9IJgJGSZeAsoBbfhRmwmdc12BcSZYVxm1Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9582:4774:7806:b32])
 (user=dlatypov job=sendgmr) by 2002:a5b:307:: with SMTP id
 j7mr37583682ybp.481.1618274485430; Mon, 12 Apr 2021 17:41:25 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:41:05 -0700
Message-Id: <20210413004105.785863-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2] Documentation: kunit: add tips for running KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is long overdue.

There are several things that aren't nailed down (in-tree
.kunitconfig's), or partially broken (GCOV on UML), but having them
documented, warts and all, is better than having nothing.

This covers a bunch of the more recent features
* kunit_filter_glob
* kunit.py run --kunitconfig
* slightly more detail on building tests as modules
* CONFIG_KUNIT_DEBUGFS

By my count, the only headline features now not mentioned are the KASAN
integration and KernelCI json output support (kunit.py run --json).

And then it also discusses how to get code coverage reports under UML
and non-UML since this is a question people have repeatedly asked.

Non-UML coverage collection is no different from normal, but we should
probably explicitly call this out.

As for UML, I was able to get it working again with two small hacks.*
E.g. with CONFIG_KUNIT=y && CONFIG_KUNIT_ALL_TESTS=y
  Overall coverage rate:
    lines......: 15.1% (18294 of 120776 lines)
    functions..: 16.8% (1860 of 11050 functions)

Note: this doesn't document --alltests since this is not stable yet.
Hopefully being run more frequently as part of KernelCI will help...

*Using gcc/gcov-6 and not using uml_abort() in os_dump_core().
I've documented these hacks in "Notes" but left TODOs for
brendanhiggins@google.com who tracked down the runtime issue in GCC.
To be clear: these are not issues specific to KUnit, but rather to UML.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/index.rst       |   1 +
 .../dev-tools/kunit/running_tips.rst          | 260 ++++++++++++++++++
 Documentation/dev-tools/kunit/start.rst       |   2 +
 3 files changed, 263 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/running_tips.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 848478838347..7f7cf8d2ab20 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -14,6 +14,7 @@ KUnit - Unit Testing for the Linux Kernel
 	style
 	faq
 	tips
+	running_tips
 
 What is KUnit?
 ==============
diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
new file mode 100644
index 000000000000..52cc62d1c83b
--- /dev/null
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -0,0 +1,260 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Tips For Running KUnit Tests
+============================
+
+Using ``kunit.py run`` ("kunit tool")
+=====================================
+
+Running from any directory
+--------------------------
+
+It can be handy to create a bash function like:
+
+.. code-block:: bash
+
+	function run_kunit() {
+	  ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
+	}
+
+.. note::
+	Early versions of ``kunit.py`` (before 5.6) didn't work unless run from
+	the kernel root, hence the use of a subshell and ``cd``.
+
+Running a subset of tests
+-------------------------
+
+``kunit.py run`` accepts an optional glob argument to filter tests. Currently
+this only matches against suite names, but this may change in the future.
+
+Say that we wanted to run the sysctl tests, we could do so via:
+
+.. code-block:: bash
+
+	$ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
+	$ ./tools/testing/kunit/kunit.py run 'sysctl*'
+
+We're paying the cost of building more tests than we need this way, but it's
+easier than fiddling with ``.kunitconfig`` files or commenting out
+``kunit_suite``'s.
+
+However, if we wanted to define a set of tests in a less ad hoc way, the next
+tip is useful.
+
+Defining a set of tests
+-----------------------
+
+``kunit.py run`` (along with ``build``, and ``config``) supports a
+``--kunitconfig`` flag. So if you have a set of tests that you want to run on a
+regular basis (especially if they have other dependencies), you can create a
+specific ``.kunitconfig`` for them.
+
+E.g. kunit has one for its tests:
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit/.kunitconfig
+
+Alternatively, if you're following the convention of naming your
+file ``.kunitconfig``, you can just pass in the dir, e.g.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
+
+.. note::
+	This is a relatively new feature (5.12+) so we don't have any
+	conventions yet about on what files should be checked in versus just
+	kept around locally. It's up to you and your maintainer to decide if a
+	config is useful enough to submit (and therefore have to maintain).
+
+.. note::
+	Having ``.kunitconfig`` fragments in a parent and child directory is
+	iffy. There's discussion about adding an "import" statement in these
+	files to make it possible to have a top-level config run tests from all
+	child directories. But that would mean ``.kunitconfig`` files are no
+	longer just simple .config fragments.
+
+	One alternative would be to have kunit tool recursively combine configs
+	automagically, but tests could theoretically depend on incompatible
+	options, so handling that would be tricky.
+
+Generating code coverage reports under UML
+------------------------------------------
+
+.. note::
+	TODO(brendanhiggins@google.com): There are various issues with UML and
+	versions of gcc 7 and up. You're likely to run into missing ``.gcda``
+	files or compile errors. We know one `faulty GCC commit
+	<https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
+	but not how we'd go about getting this fixed. The compile errors still
+	need some investigation.
+
+.. note::
+	TODO(brendanhiggins@google.com): for recent versions of Linux
+	(5.10-5.12, maybe earlier), there's a bug with gcov counters not being
+	flushed in UML. This translates to very low (<1%) reported coverage. This is
+	related to the above issue and can be worked around by replacing the
+	one call to ``uml_abort()`` with a plain ``exit()``.
+
+
+This is different from the "normal" way of getting coverage information that is
+documented in Documentation/dev-tools/gcov.rst.
+
+Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
+
+.. code-block:: none
+
+	CONFIG_DEBUG_KERNEL=y
+	CONFIG_DEBUG_INFO=y
+	CONFIG_GCOV=y
+
+
+Putting it together into a copy-pastable sequence of commands:
+
+.. code-block:: bash
+
+	# Append coverage options to the current config
+	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
+	$ ./tools/testing/kunit/kunit.py run
+	# Extract the coverage information from the build dir (.kunit/)
+	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
+
+	# From here on, it's the same process as with CONFIG_GCOV_KERNEL=y
+	# E.g. can generate an HTML report in a tmp dir like so:
+	$ genhtml -o /tmp/coverage_html coverage.info
+
+
+If your installed version of gcc doesn't work, you can tweak the steps:
+
+.. code-block:: bash
+
+	# need to edit tools/testing/kunit/kunit_kernel.py to call make with 'CC=/usr/bin/gcc-6'
+	$ $EDITOR tools/testing/kunit/kunit_kernel.py
+
+	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/ --gcov-tool=/usr/bin/gcov-6
+
+
+Running tests manually
+======================
+
+Running tests without using ``kunit.py run`` is also an important use case.
+Currently it's your only option if you want to test on architectures other than
+UML.
+
+As running the tests under UML is fairly straightforward (configure and compile
+the kernel, run the ``./linux`` binary), this section will focus on testing
+non-UML architectures.
+
+
+Running built-in tests
+----------------------
+
+When setting tests to ``=y``, the tests will run as part of boot and print
+results to dmesg in TAP format. So you just need to add your tests to your
+``.config``, build and boot your kernel as normal.
+
+So if we compiled our kernel with:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+
+Then we'd see output like this in dmesg signaling the test ran and passed:
+
+.. code-block:: none
+
+	TAP version 14
+	1..1
+	    # Subtest: example
+	    1..1
+	    # example_simple_test: initializing
+	    ok 1 - example_simple_test
+	ok 1 - example
+
+Running tests as modules
+------------------------
+
+Depending on the tests, you can build them as loadable modules.
+
+For example, we'd change the config options from before to
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+
+Then after booting into our kernel, we can run the test via
+
+.. code-block:: none
+
+	$ modprobe kunit-example-test
+
+This will then cause it to print TAP output to stdout.
+
+.. note::
+	The ``modprobe`` will *not* have a non-zero exit code if any test
+	failed (as of 5.13). But ``kunit.py parse`` would, see below.
+
+.. note::
+	You can set ``CONFIG_KUNIT=m`` as well, however, some features will not
+	work and thus some tests might break. Ideally tests would specify they
+	depend on ``KUNIT=y`` in their ``Kconfig``'s, but this is an edge case
+	most test authors won't think about.
+	As of 5.13, the only difference is that ``current->kunit_test`` will
+	not exist.
+
+Pretty-printing results
+-----------------------
+
+You can use ``kunit.py parse`` to parse dmesg for test output and print out
+results in the same familiar format that ``kunit.py run`` does.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py parse /var/log/dmesg
+
+
+Retrieving per suite results
+----------------------------
+
+Regardless of how you're running your tests, you can enable
+``CONFIG_KUNIT_DEBUGFS`` to expose per-suite TAP-formatted results:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=m
+	CONFIG_KUNIT_DEBUGFS=y
+
+The results for each suite will be exposed under
+``/sys/kernel/debug/kunit/<suite>/results``.
+So using our example config:
+
+.. code-block:: bash
+
+	$ modprobe kunit-example-test > /dev/null
+	$ cat /sys/kernel/debug/kunit/example/results
+	... <TAP output> ...
+
+	# After removing the module, the corresponding files will go away
+	$ modprobe -r kunit-example-test
+	$ cat /sys/kernel/debug/kunit/example/results
+	/sys/kernel/debug/kunit/example/results: No such file or directory
+
+Generating code coverage reports
+--------------------------------
+
+See Documentation/dev-tools/gcov.rst for details on how to do this.
+
+The only vaguely KUnit-specific advice here is that you probably want to build
+your tests as modules. That way you can isolate the coverage from tests from
+other code executed during boot, e.g.
+
+.. code-block:: bash
+
+	# Reset coverage counters before running the test.
+	$ echo 0 > /sys/kernel/debug/gcov/reset
+	$ modprobe kunit-example-test
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 0e65cabe08eb..aa56d7ca6bfb 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -236,5 +236,7 @@ Next Steps
 ==========
 *   Check out the :doc:`tips` page for tips on
     writing idiomatic KUnit tests.
+*   Check out the :doc:`running_tips` page for tips on
+    how to make running KUnit tests easier.
 *   Optional: see the :doc:`usage` page for a more
     in-depth explanation of KUnit.

base-commit: de2fcb3e62013738f22bbb42cbd757d9a242574e
-- 
2.31.1.295.g9ea45b61b8-goog

