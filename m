Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D61873EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgCPUVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 16:21:50 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:41174 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbgCPUVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 16:21:50 -0400
Received: by mail-pj1-f73.google.com with SMTP id k3so11760090pjo.6
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=To5N8tUaCvz6MVLHlfCQ9mbVyH/J+Wx9dmrV0++j4lg=;
        b=hHtzqGW2wqp+frqqcV5F6ULbiTUd+KNsCjFgkkR6VUHzqMqAzmW7BZgNddhTlWR097
         NvSNHNUslVQPh2yVlBZ7OcDGTTHbPpPbc+2em1gzfwMUcJ4rV2omEabS55+EDGJ2vzYC
         vcqBpYFw6pKPRdsp4KkS75br6p391Xz14pXKasPdT3Q1qVDMAyeuT5apvhPvuWbnzCFV
         xCZ3NB5Q+cz3dpyEtsDkTkcHGChY6aNbT54XXP4xamsR8SaNgaQvUqyUcYJ/Ad+8TjLo
         DTePvbC0eoXKXnSxDtdqZr14znb7z+ESuzRGlV/vVFu2Ekq9NKqw4Qd48Kh8wI3VhEiz
         t+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=To5N8tUaCvz6MVLHlfCQ9mbVyH/J+Wx9dmrV0++j4lg=;
        b=YwSR7MwxCl9lUHL/C5lyweKsyAP/MdVVRYBjXrd/cLpaKUJcpno9OocgSKAs2HMnF7
         HfEjgzzvJcOnD15DOZvENstHEim0LZFjmf+mvrskPzv9OIbFZbqPtvtFOm0M1xRagq+n
         yMKmXm2CKSpwofnHaY9ydwJ2BDZ6U55HAOEoS23PMVgirktcPcT4qbqnQKqGDSSnFOZM
         b9A51qNUqlJC5n6DXmYHJh3woQUm4ugM2UjaVO4nZLVBMGALbo1/ij/MasVr0NkQ98v7
         gBZdkDIq/G9jrKlJ1JLh5W3VfhANEnzFLzc23H4TLHrlpjLgzVmflMf1NoCq4PrxWmgV
         YQ7A==
X-Gm-Message-State: ANhLgQ1BnSTxOX0g2UgcQYXcwMssXlt1dcRmQH0hXgpIxpZ0IUdHHnGs
        5144Zsb1QYmQ0IZtSiTBTrH+CP+b6oFA3XpU
X-Google-Smtp-Source: ADFU+vudic1Hqys5mhWZo4n3tXuf/uO0RkDAaANduCIY7/w+eDZqBZGdeokIqwjtq1a/MhwWU6G9/YSRXcGUiNi6
X-Received: by 2002:a65:5905:: with SMTP id f5mr1411993pgu.87.1584390108022;
 Mon, 16 Mar 2020 13:21:48 -0700 (PDT)
Date:   Mon, 16 Mar 2020 13:21:25 -0700
In-Reply-To: <20200316202125.15852-1-heidifahim@google.com>
Message-Id: <20200316202125.15852-2-heidifahim@google.com>
Mime-Version: 1.0
References: <20200316202125.15852-1-heidifahim@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v3 2/2] kunit: Run all KUnit tests through allyesconfig
From:   Heidi Fahim <heidifahim@google.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implemented the functionality to run all KUnit tests through kunit_tool
by specifying an --alltests flag, which builds UML with allyesconfig
enabled, and consequently runs every KUnit test. A new function was
added to kunit_kernel: make_allyesconfig.
Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
which call make_allyesconfig. This function calls the make command,
disables the broken configs that would otherwise prevent UML from
building, then starts the kernel with all possible configurations
enabled. All stdout and stderr is sent to test.log and read from there
then fed through kunit_parser to parse the tests to the user. Also added
a signal_handler in case kunit is interrupted while running.
Tested: Run under different conditions such as testing with
--raw_output, testing program interrupt then immediately running kunit
again without --alltests and making sure to clean the console.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
Changelog:
 v3:
 - Minor change since v2 in message for program interruption. Changed
   "Cleaning config." to "Cleaning console."

 .../kunit/configs/broken_on_uml.config        | 41 ++++++++++++
 tools/testing/kunit/kunit.py                  | 30 +++++----
 tools/testing/kunit/kunit_kernel.py           | 62 ++++++++++++++-----
 tools/testing/kunit/kunit_parser.py           |  1 +
 tools/testing/kunit/kunit_tool_test.py        | 17 ++---
 5 files changed, 115 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/kunit/configs/broken_on_uml.config

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
new file mode 100644
index 000000000000..239b9f03da2c
--- /dev/null
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -0,0 +1,41 @@
+# These are currently broken on UML and prevent allyesconfig from building
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
+# CONFIG_RESET_BRCMSTB_RESCAL is not set
+# CONFIG_RESET_INTEL_GW is not set
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 180ad1e1b04f..650bb4cfc544 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,7 +22,9 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
+					   'build_dir', 'defconfig',
+					   'alltests'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -55,24 +57,23 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
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
 
@@ -120,6 +121,10 @@ def main(argv, linux=None):
 				help='Uses a default .kunitconfig.',
 				action='store_true')
 
+	run_parser.add_argument('--alltests',
+				help='Run all KUnit tests through allyesconfig',
+				action='store_true')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -143,7 +148,8 @@ def main(argv, linux=None):
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
index d99ae75ef72f..415d8f3c4fe4 100644
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
 kunitconfig_path = '.kunitconfig'
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
@@ -57,18 +79,16 @@ class LinuxSourceTreeOperations(object):
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
+		with open(outfile, 'w') as output:
+			process = subprocess.Popen([linux_bin] + params,
+						   stdout=output,
+						   stderr=subprocess.STDOUT)
+			process.wait(timeout)
 
 
 def get_kconfig_path(build_dir):
@@ -84,6 +104,7 @@ class LinuxSourceTree(object):
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
 		self._ops = LinuxSourceTreeOperations()
+		signal.signal(signal.SIGINT, self.signal_handler)
 
 	def clean(self):
 		try:
@@ -135,7 +156,9 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir)
 
-	def build_um_kernel(self, jobs, build_dir):
+	def build_um_kernel(self, alltests, jobs, build_dir):
+		if alltests:
+			self._ops.make_allyesconfig()
 		try:
 			self._ops.make_olddefconfig(build_dir)
 			self._ops.make(jobs, build_dir)
@@ -144,10 +167,15 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], timeout=None, build_dir=''):
-		args.extend(['mem=256M'])
-		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
-			for line in process.stdout:
-				f.write(line.rstrip().decode('ascii') + '\n')
-				yield line.rstrip().decode('ascii')
+	def run_kernel(self, args=[], build_dir='', timeout=None):
+		args.extend(['mem=1G'])
+		outfile = 'test.log'
+		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		subprocess.call(['stty', 'sane'])
+		with open(outfile, 'r') as file:
+			for line in file:
+				yield line
+
+	def signal_handler(self, sig, frame):
+		logging.error('Build interruption occurred. Cleaning console.')
+		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index adf86747b07f..02815062d5a6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -65,6 +65,7 @@ def isolate_kunit_output(kernel_output):
 def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
+		yield line
 
 DIVIDER = '=' * 60
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0efae697f396..ce47e87b633a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -243,7 +243,8 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='', timeout=300)
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
+			build_dir='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 if __name__ == '__main__':
-- 
2.25.1.481.gfbce0eb801-goog

