Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4001F16EFD3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 21:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgBYUMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 15:12:06 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:59681 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgBYUMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 15:12:05 -0500
Received: by mail-pj1-f73.google.com with SMTP id z5so323245pjq.9
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o7uyCNm3PwcTObFLNHL0wKjFetUXQ9LZudj5gbkagCg=;
        b=CG3sVubIl1XtHpely2x6iI3gAxlI/J9joPRgYReo4LLymfpQyhJPsuUzS6TAmtbK5m
         wWoQNbvEf3hTv4pAY/G47YzEE1FURpjhZa4Qp6f/+S0FD8wPbhAOI6/Wvq/KXEFngKcO
         8xpxCcYebMDiL4IUu97BsivOvXK4zXp2qfpPFFsBPYXVq6JmNxr2JUDKVDaq7Nj4GrL4
         8wauJomThGX+QnNKqqfpj1jh8NqMyZ2kM74F9tQTM9XmjnZ3gF5wL2/yhTQqtjSyzLTB
         PtAITMiMKM8n20CyIvKwpRzAzQ/tAeRHxM6FCnTsgzmD5rMvv1hzyh+leyeLSktckdMP
         vLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o7uyCNm3PwcTObFLNHL0wKjFetUXQ9LZudj5gbkagCg=;
        b=hG+mwo7MHX67ENPfAgDPtjg05s1Ob0mVFgTnAZ+L9lL1IKQnZiZf+g2ScH22VlUVhy
         hndW6sKvawn66s9Q7ySlyGBQjggHROCpGoduY9QTGRUEDPxbuCJKGMS0hKYMGfSOAhZ3
         7IO2RgHD3C8dKNFwqg2XvQtKs6XfFoFaUQ/wp23z4qFMksa30my3x1OKbJ/9ZFMDX+lO
         9DvIhhfauZp9taGEHHLCZsgtkaFlO/Oaz/cPnQe6eoc1kilZ9Y1jmTy/jCrekmBReyph
         18EeayAUwPS7MIoStW+1KYVUlfkMlCCGpieg68kGFOTq+9ri6DP34VaaQDESF/xzqMxy
         qeGA==
X-Gm-Message-State: APjAAAUt/WDH/RZlqk8bnYjaRqbp+ruPOEa0DH0+KyAmx1a/Fthl6Snr
        jPQGRbR7F3m5m0lSwOlK9fo4O5Xs16+/2+ky
X-Google-Smtp-Source: APXvYqy3QkSKgLaYw5ctE8KDVob2ow1Jd3/T6qCQ2XgvdaOUbMQbU6PUrWwtB3xCN0enaV9K+tgYAQYfzDi3uGyU
X-Received: by 2002:a63:a4b:: with SMTP id z11mr226540pgk.398.1582661524712;
 Tue, 25 Feb 2020 12:12:04 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:11:30 -0800
In-Reply-To: <20200225201130.211124-1-heidifahim@google.com>
Message-Id: <20200225201130.211124-2-heidifahim@google.com>
Mime-Version: 1.0
References: <20200225201130.211124-1-heidifahim@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 2/2] kunit: Run all KUnit tests through allyesconfig
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implemented the functionality to run all KUnit tests through kunit_tool
by specifying an --alltests flag, which builds UML with allyesconfig
enabled, and consequently runs every KUnit test. Two new methods have
been added to kunit_kernel: make_allyesconfig and run_allconfig.
Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
which sets jobs to the max number of cpus on the user's computer. This
is done to shorten the long running time it takes to build and start a
kernel with all configs enabled. It then calls the make command,
disables the broken configs that would otherwise prevent UML from
building, then starts the kernel with all possible configurations
enabled. All stdout and stderr is sent to test.log and read from there
then fed through kunit_parser to parse the tests to the user. Also added
a signal_handler to clean the config in case kunit is interrupted while
running.
Tested: Run under different conditions such as testing with
--raw_output, testing program interrupt then immediately running kunit
again without --alltests and making sure to clean the configs. Formal
unit tests will be submitted in a future patchset.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 .../kunit/configs/broken_on_uml.config        | 38 ++++++++++
 tools/testing/kunit/kunit.py                  | 37 ++++++----
 tools/testing/kunit/kunit_kernel.py           | 71 +++++++++++++------
 tools/testing/kunit/kunit_parser.py           |  1 +
 tools/testing/kunit/kunit_tool_test.py        | 17 +++--
 5 files changed, 122 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/kunit/configs/broken_on_uml.config

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
new file mode 100644
index 000000000000..6d746588d46e
--- /dev/null
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -0,0 +1,38 @@
+# CONFIG_STATIC_LINK is not set
+# CONFIG_UML_NET_VECTOR is not set
+# CONFIG_UML_NET_VDE is not set
+# CONFIG_UML_NET_PCAP is not set
+# CONFIG_NET_PTP_CLASSIFY is not set
+# CONFIG_IP_VS is not set
+# CONFIG_BRIDGE_EBT_BROUTE is not set
+# CONFIG_BRIDGE_EBT_T_FILTER is not set
+# CONFIG_BRIDGE_EBT_T_NAT is not set
+# CONFIG_MTD_NAND_CADENCE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_BLK_DEV_NULL_BLK is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+# CONFIG_NULL_TTY is not set
+# CONFIG_PTP_1588_CLOCK is not set
+# CONFIG_PINCTRL_EQUILIBRIUM is not set
+# CONFIG_DMABUF_SELFTESTS is not set
+# CONFIG_COMEDI is not set
+# CONFIG_XIL_AXIS_FIFO is not set
+# CONFIG_EXFAT_FS is not set
+# CONFIG_STM_DUMMY is not set
+# CONFIG_FSI_MASTER_ASPEED is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_UBIFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
+# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
+# CONFIG_KCOV is not set
+# CONFIG_LKDTM is not set
+# CONFIG_REED_SOLOMON_TEST is not set
+# CONFIG_TEST_RHASHTABLE is not set
+# CONFIG_TEST_MEMINIT is not set
+# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
+# CONFIG_DEBUG_INFO_BTF is not set
+# CONFIG_PTP_1588_CLOCK_INES is not set
+# CONFIG_QCOM_CPR is not set
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..37bd20a2a1c5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,7 +22,9 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
+					   'build_dir', 'defconfig',
+					   'alltests'])
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -33,7 +35,7 @@ class KunitStatus(Enum):
 def create_default_kunitconfig():
 	if not os.path.exists(kunit_kernel.kunitconfig_path):
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
-				kunit_kernel.kunitconfig_path)
+				kunit_kernel.KUNITCONFIG_PATH)
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -46,24 +48,24 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	success = linux.build_um_kernel(request.alltests,
+					request.jobs,
+					request.build_dir)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
 
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
-
-	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
-					      [],
-					      'Tests not Parsed.')
+	kunit_output = linux.run_kernel(
+		timeout=None if request.alltests else request.timeout,
+		alltests=request.alltests,
+		build_dir=request.build_dir)
 	if request.raw_output:
-		kunit_parser.raw_output(
-			linux.run_kernel(timeout=request.timeout,
-					 build_dir=request.build_dir))
+		raw_output = kunit_parser.raw_output(kunit_output)
+		isolated = list(kunit_parser.isolate_kunit_output(raw_output))
+		test_result = kunit_parser.parse_test_result(isolated)
 	else:
-		kunit_output = linux.run_kernel(timeout=request.timeout,
-						build_dir=request.build_dir)
 		test_result = kunit_parser.parse_run_tests(kunit_output)
 	test_end = time.time()
 
@@ -111,15 +113,19 @@ def main(argv, linux=None):
 				help='Uses a default .kunitconfig.',
 				action='store_true')
 
+	run_parser.add_argument('--alltests',
+				help='Run all KUnit tests through allyesconfig',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
+			kunit_kernel.KUNITCONFIG_PATH = os.path.join(
 				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
+				kunit_kernel.KUNITCONFIG_PATH)
 
 		if cli_args.defconfig:
 			create_default_kunitconfig()
@@ -131,7 +137,8 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig)
+				       cli_args.defconfig,
+				       cli_args.alltests)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..2b0de7d52110 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -10,11 +10,16 @@
 import logging
 import subprocess
 import os
+import signal
+
+from contextlib import ExitStack
 
 import kunit_config
+import kunit_parser
 
 KCONFIG_PATH = '.config'
-kunitconfig_path = '.kunitconfig'
+KUNITCONFIG_PATH = '.kunitconfig'
+BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
@@ -40,12 +45,29 @@ class LinuxSourceTreeOperations(object):
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
-			subprocess.check_output(command)
+			subprocess.check_output(command, stderr=subprocess.PIPE)
 		except OSError as e:
 			raise ConfigError('Could not call make command: ' + e)
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
+	def make_allyesconfig(self):
+		kunit_parser.print_with_timestamp(
+			'Enabling all CONFIGs for UML...')
+		process = subprocess.Popen(
+			['make', 'ARCH=um', 'allyesconfig'],
+			stdout=subprocess.DEVNULL,
+			stderr=subprocess.STDOUT)
+		process.wait()
+		kunit_parser.print_with_timestamp(
+			'Disabling broken configs to run KUnit tests...')
+		with ExitStack() as es:
+			config = open(KCONFIG_PATH, 'a')
+			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
+			config.write(disable)
+		kunit_parser.print_with_timestamp(
+			'Starting Kernel with all configs takes a few minutes...')
+
 	def make(self, jobs, build_dir):
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
 		if build_dir:
@@ -57,19 +79,16 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise BuildError(e.output)
 
-	def linux_bin(self, params, timeout, build_dir):
+	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
 			linux_bin = os.path.join(build_dir, 'linux')
-		process = subprocess.Popen(
-			[linux_bin] + params,
-			stdin=subprocess.PIPE,
-			stdout=subprocess.PIPE,
-			stderr=subprocess.PIPE)
-		process.wait(timeout=timeout)
-		return process
-
+		with open(outfile, 'w') as output:
+			process = subprocess.Popen([linux_bin] + params,
+						   stdout=output,
+						   stderr=subprocess.STDOUT)
+			process.wait(timeout)
 
 def get_kconfig_path(build_dir):
 	kconfig_path = KCONFIG_PATH
@@ -82,8 +101,9 @@ class LinuxSourceTree(object):
 
 	def __init__(self):
 		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
+		self._kconfig.read_from_file(KUNITCONFIG_PATH)
 		self._ops = LinuxSourceTreeOperations()
+		signal.signal(signal.SIGINT, self.signal_handler)
 
 	def clean(self):
 		try:
@@ -126,7 +146,10 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir)
 
-	def build_um_kernel(self, jobs, build_dir):
+	def build_um_kernel(self, alltests, jobs, build_dir):
+		if alltests:
+			jobs = os.cpu_count()
+			self._ops.make_allyesconfig()
 		try:
 			self._ops.make_olddefconfig(build_dir)
 			self._ops.make(jobs, build_dir)
@@ -140,10 +163,18 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def run_kernel(self, args=[], timeout=None, build_dir=''):
-		args.extend(['mem=256M'])
-		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
-			for line in process.stdout:
-				f.write(line.rstrip().decode('ascii') + '\n')
-				yield line.rstrip().decode('ascii')
+	def run_kernel(self, args=[], alltests=False, build_dir='', timeout=None):
+		args.extend(['mem=1G']) if alltests else args.extend(['mem=256M'])
+		outfile = 'test.log'
+		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		subprocess.call(['stty', 'sane'])
+		if alltests:
+			self.clean()
+		with open(outfile, 'r') as file:
+			for line in file:
+				yield line
+
+	def signal_handler(self, sig, frame):
+		logging.error('Build interruption occurred. Cleaning .config.')
+		subprocess.call(['stty', 'sane'])
+		self.clean()
\ No newline at end of file
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 077b21d42258..5b2051848e2f 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -65,6 +65,7 @@ def isolate_kunit_output(kernel_output):
 def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
+		yield line
 
 DIVIDER = '=' * 60
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0efae697f396..9ce4c5cdbdaf 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -243,7 +243,8 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			alltests=False, build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_fail(self):
@@ -258,25 +259,27 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
 
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			alltests=False, build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			alltests=False, build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.25.0.265.gbab2e86ba0-goog

