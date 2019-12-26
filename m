Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5E12AEED
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2019 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLZV1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Dec 2019 16:27:30 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:33324 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLZV1a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Dec 2019 16:27:30 -0500
Received: by mail-il1-f176.google.com with SMTP id v15so21060902iln.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Dec 2019 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=RJfOZVN3TcBH/XoG7lR9pBKxEzz5CfXs+3B1l1UJr7E=;
        b=UqDWb8YVtmGQvN8GJubn52OpDj1ZVlmzR1rR7m12O3v2Po6DFFYswjVXchxBcFZGqO
         EkYo4oRUNRDQcPEyTBIYrVJAPqUMXynsZrossTkvmtph/lfZFwT73MRkee0kItAgcNr6
         Sww6/UHREE/RdgVk8aBstAO172+a5cYEk/x6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=RJfOZVN3TcBH/XoG7lR9pBKxEzz5CfXs+3B1l1UJr7E=;
        b=icdSrf7sh53OjQ77/pkmaJl+MRoVzVSPAH0EgLxkU6E3qdc4RoHTdcOGpZHvSyKa0j
         b+lV7ty5FWDwpoqNWrl6vvX5ES2gXDXQp5s+mliRv89SlyaZjhcVYKGAV8IhxWu/yOwS
         V+umZxvgT0cPy2DRlfNGw0VVwZefTlEVMdKxjg9PjrX8HXav32GBwIoJaGKessweFy7X
         xOl0TpTrnw4DJhvLhFUjhGnKajiOSKKxcZM1JebuD+mgYILqUjzbaiu94glnVSctVN0g
         BEQvoOcf5KWOo+qucl7j8QTI8eiQLyZaa4kuh+Y0pz5f6vvnHbJOHhIDsSl3XYVj6k3x
         DF0A==
X-Gm-Message-State: APjAAAXumgx/HDIKHAqoClZVEH0yxW3eqBz2xJf/2QlMTaiLII47BFxO
        b+Y3F8yeuPWQbAsH+FlzhVLR1i/YPJAfAQ==
X-Google-Smtp-Source: APXvYqzWUg2n2pN+z+v/hTdS+jwBFLs35CJTChgHy57q8YvMl088pnXweXzLfJcg0RE1LUxWbfuPJg==
X-Received: by 2002:a92:838f:: with SMTP id p15mr40517033ilk.91.1577395649597;
        Thu, 26 Dec 2019 13:27:29 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z81sm11505744ilc.17.2019.12.26.13.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 13:27:28 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.5-rc4
Message-ID: <ff093d74-a232-8dfc-d632-196a7a13b611@linuxfoundation.org>
Date:   Thu, 26 Dec 2019 14:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F2659E4A04661FD971CD5793"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------F2659E4A04661FD971CD5793
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.5-rc4.

This Kselftest update for Linux 5.5-rc4 consists of:

-- rseq build failures fixes related to glibc 2.30 compatibility
    from Mathieu Desnoyers
-- Kunit fixes and cleanups from SeongJae Park
-- Fixes to filesystems/epoll, firmware, and livepatch build failures
    and skip handling.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

   Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.5-rc4

for you to fetch changes up to 2a1f40adfb54ca65dc4c93bad444dd23b800a76e:

   rseq/selftests: Clarify rseq_prepare_unload() helper requirements 
(2019-12-23 10:52:41 -0700)

----------------------------------------------------------------
linux-kselftest-5.5-rc4

This Kselftest update for Linux 5.5-rc4 consists of:

-- rseq build failures fixes related to glibc 2.30 compatibility
    from Mathieu Desnoyers
-- Kunit fixes and cleanups from SeongJae Park
-- Fixes to filesystems/epoll, firmware, and livepatch build failures
    and skip handling.

----------------------------------------------------------------
Mathieu Desnoyers (3):
       rseq/selftests: Turn off timeout setting
       rseq/selftests: Fix: Namespace gettid() for compatibility with 
glibc 2.30
       rseq/selftests: Clarify rseq_prepare_unload() helper requirements

SeongJae Park (6):
       docs/kunit/start: Use in-tree 'kunit_defconfig'
       kunit: Remove duplicated defconfig creation
       kunit: Create default config in '--build_dir'
       kunit: Place 'test.log' under the 'build_dir'
       kunit: Rename 'kunitconfig' to '.kunitconfig'
       kunit/kunit_tool_test: Test '--build_dir' option run

Shuah Khan (3):
       selftests: filesystems/epoll: fix build error
       selftests: firmware: Fix it to do root uid check and skip
       selftests: livepatch: Fix it to do root uid check and skip

  Documentation/dev-tools/kunit/start.rst            | 13 +++++--------
  tools/testing/kunit/kunit.py                       | 18 +++++++++++-------
  tools/testing/kunit/kunit_kernel.py                | 10 +++++-----
  tools/testing/kunit/kunit_tool_test.py             | 10 +++++++++-
  tools/testing/selftests/filesystems/epoll/Makefile |  2 +-
  tools/testing/selftests/firmware/fw_lib.sh         |  6 ++++++
  tools/testing/selftests/livepatch/functions.sh     | 15 ++++++++++++++-
  tools/testing/selftests/livepatch/test-state.sh    |  3 +--
  tools/testing/selftests/rseq/param_test.c          | 18 ++++++++++--------
  tools/testing/selftests/rseq/rseq.h                | 12 +++++++-----
  tools/testing/selftests/rseq/settings              |  1 +
  11 files changed, 70 insertions(+), 38 deletions(-)
  create mode 100644 tools/testing/selftests/rseq/settings

----------------------------------------------------------------

--------------F2659E4A04661FD971CD5793
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.5-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.5-rc4.diff"

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 9d6db892c41c..4e1d24db6b13 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -24,19 +24,16 @@ The wrapper can be run with:
 For more information on this wrapper (also called kunit_tool) checkout the
 :doc:`kunit-tool` page.
 
-Creating a kunitconfig
-======================
+Creating a .kunitconfig
+=======================
 The Python script is a thin wrapper around Kbuild. As such, it needs to be
-configured with a ``kunitconfig`` file. This file essentially contains the
+configured with a ``.kunitconfig`` file. This file essentially contains the
 regular Kernel config, with the specific test targets as well.
 
 .. code-block:: bash
 
-	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
 	cd $PATH_TO_LINUX_REPO
-	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
-
-You may want to add kunitconfig to your local gitignore.
+	cp arch/um/configs/kunit_defconfig .kunitconfig
 
 Verifying KUnit Works
 ---------------------
@@ -151,7 +148,7 @@ and the following to ``drivers/misc/Makefile``:
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
 
-Now add it to your ``kunitconfig``:
+Now add it to your ``.kunitconfig``:
 
 .. code-block:: none
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d621983..e59eb9e7f923 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -31,15 +31,12 @@ class KunitStatus(Enum):
 	TEST_FAILURE = auto()
 
 def create_default_kunitconfig():
-	if not os.path.exists(kunit_kernel.KUNITCONFIG_PATH):
+	if not os.path.exists(kunit_kernel.kunitconfig_path):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.KUNITCONFIG_PATH)
+				kunit_kernel.kunitconfig_path)
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
@@ -108,15 +105,22 @@ def main(argv, linux=None):
 	run_parser.add_argument('--build_dir',
 				help='As in the make command, it specifies the build '
 				'directory.',
-				type=str, default=None, metavar='build_dir')
+				type=str, default='', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
-				help='Uses a default kunitconfig.',
+				help='Uses a default .kunitconfig.',
 				action='store_true')
 
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
 		if cli_args.defconfig:
 			create_default_kunitconfig()
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..cc5d844ecca1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,7 +14,7 @@ import os
 import kunit_config
 
 KCONFIG_PATH = '.config'
-KUNITCONFIG_PATH = 'kunitconfig'
+kunitconfig_path = '.kunitconfig'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -82,7 +82,7 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(KUNITCONFIG_PATH)
+		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
 
 	def clean(self):
@@ -111,7 +111,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def build_reconfig(self, build_dir):
-		"""Creates a new .config if it is not a subset of the kunitconfig."""
+		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
 			existing_kconfig = kunit_config.Kconfig()
@@ -140,10 +140,10 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[], timeout=None, build_dir=None):
+	def run_kernel(self, args=[], timeout=None, build_dir=''):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open('test.log', 'w') as f:
+		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
 				f.write(line.rstrip().decode('ascii') + '\n')
 				yield line.rstrip().decode('ascii')
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index a2a8ea6beae3..cba97756ac4a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -174,6 +174,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_fail(self):
@@ -199,7 +200,14 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=None, timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+	def test_run_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
diff --git a/tools/testing/selftests/filesystems/epoll/Makefile b/tools/testing/selftests/filesystems/epoll/Makefile
index e62f3d4f68da..78ae4aaf7141 100644
--- a/tools/testing/selftests/filesystems/epoll/Makefile
+++ b/tools/testing/selftests/filesystems/epoll/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../../usr/include/
-LDFLAGS += -lpthread
+LDLIBS += -lpthread
 TEST_GEN_PROGS := epoll_wakeup_test
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index b879305a766d..5b8c0fedee76 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -34,6 +34,12 @@ test_modprobe()
 
 check_mods()
 {
+	local uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
+
 	trap "test_modprobe" EXIT
 	if [ ! -d $DIR ]; then
 		modprobe test_firmware
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 31eb09e38729..a6e3d5517a6f 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -7,6 +7,9 @@
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
 
+# Kselftest framework requirement - SKIP code is 4
+ksft_skip=4
+
 # log(msg) - write message to kernel log
 #	msg - insightful words
 function log() {
@@ -18,7 +21,16 @@ function log() {
 function skip() {
 	log "SKIP: $1"
 	echo "SKIP: $1" >&2
-	exit 4
+	exit $ksft_skip
+}
+
+# root test
+function is_root() {
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo "skip all tests: must be run as root" >&2
+		exit $ksft_skip
+	fi
 }
 
 # die(msg) - game over, man
@@ -62,6 +74,7 @@ function set_ftrace_enabled() {
 #		 for verbose livepatching output and turn on
 #		 the ftrace_enabled sysctl.
 function setup_config() {
+	is_root
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
index dc2908c22c26..a08212708115 100755
--- a/tools/testing/selftests/livepatch/test-state.sh
+++ b/tools/testing/selftests/livepatch/test-state.sh
@@ -8,8 +8,7 @@ MOD_LIVEPATCH=test_klp_state
 MOD_LIVEPATCH2=test_klp_state2
 MOD_LIVEPATCH3=test_klp_state3
 
-set_dynamic_debug
-
+setup_config
 
 # TEST: Loading and removing a module that modifies the system state
 
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index eec2663261f2..e8a657a5f48a 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -15,7 +15,7 @@
 #include <errno.h>
 #include <stddef.h>
 
-static inline pid_t gettid(void)
+static inline pid_t rseq_gettid(void)
 {
 	return syscall(__NR_gettid);
 }
@@ -373,11 +373,12 @@ void *test_percpu_spinlock_thread(void *arg)
 		rseq_percpu_unlock(&data->lock, cpu);
 #ifndef BENCHMARK
 		if (i != 0 && !(i % (reps / 10)))
-			printf_verbose("tid %d: count %lld\n", (int) gettid(), i);
+			printf_verbose("tid %d: count %lld\n",
+				       (int) rseq_gettid(), i);
 #endif
 	}
 	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
-		       (int) gettid(), nr_abort, signals_delivered);
+		       (int) rseq_gettid(), nr_abort, signals_delivered);
 	if (!opt_disable_rseq && thread_data->reg &&
 	    rseq_unregister_current_thread())
 		abort();
@@ -454,11 +455,12 @@ void *test_percpu_inc_thread(void *arg)
 		} while (rseq_unlikely(ret));
 #ifndef BENCHMARK
 		if (i != 0 && !(i % (reps / 10)))
-			printf_verbose("tid %d: count %lld\n", (int) gettid(), i);
+			printf_verbose("tid %d: count %lld\n",
+				       (int) rseq_gettid(), i);
 #endif
 	}
 	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
-		       (int) gettid(), nr_abort, signals_delivered);
+		       (int) rseq_gettid(), nr_abort, signals_delivered);
 	if (!opt_disable_rseq && thread_data->reg &&
 	    rseq_unregister_current_thread())
 		abort();
@@ -605,7 +607,7 @@ void *test_percpu_list_thread(void *arg)
 	}
 
 	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
-		       (int) gettid(), nr_abort, signals_delivered);
+		       (int) rseq_gettid(), nr_abort, signals_delivered);
 	if (!opt_disable_rseq && rseq_unregister_current_thread())
 		abort();
 
@@ -796,7 +798,7 @@ void *test_percpu_buffer_thread(void *arg)
 	}
 
 	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
-		       (int) gettid(), nr_abort, signals_delivered);
+		       (int) rseq_gettid(), nr_abort, signals_delivered);
 	if (!opt_disable_rseq && rseq_unregister_current_thread())
 		abort();
 
@@ -1011,7 +1013,7 @@ void *test_percpu_memcpy_buffer_thread(void *arg)
 	}
 
 	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
-		       (int) gettid(), nr_abort, signals_delivered);
+		       (int) rseq_gettid(), nr_abort, signals_delivered);
 	if (!opt_disable_rseq && rseq_unregister_current_thread())
 		abort();
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index d40d60e7499e..3f63eb362b92 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -149,11 +149,13 @@ static inline void rseq_clear_rseq_cs(void)
 /*
  * rseq_prepare_unload() should be invoked by each thread executing a rseq
  * critical section at least once between their last critical section and
- * library unload of the library defining the rseq critical section
- * (struct rseq_cs). This also applies to use of rseq in code generated by
- * JIT: rseq_prepare_unload() should be invoked at least once by each
- * thread executing a rseq critical section before reclaim of the memory
- * holding the struct rseq_cs.
+ * library unload of the library defining the rseq critical section (struct
+ * rseq_cs) or the code referred to by the struct rseq_cs start_ip and
+ * post_commit_offset fields. This also applies to use of rseq in code
+ * generated by JIT: rseq_prepare_unload() should be invoked at least once by
+ * each thread executing a rseq critical section before reclaim of the memory
+ * holding the struct rseq_cs or reclaim of the code pointed to by struct
+ * rseq_cs start_ip and post_commit_offset fields.
  */
 static inline void rseq_prepare_unload(void)
 {
diff --git a/tools/testing/selftests/rseq/settings b/tools/testing/selftests/rseq/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/rseq/settings
@@ -0,0 +1 @@
+timeout=0

--------------F2659E4A04661FD971CD5793--
