Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9DD207F0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgFXWBH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 18:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388452AbgFXWBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 18:01:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD3C061573
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 15:01:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o140so3724824yba.16
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Xpqt1NtbDbpAVLHQUxG3xmewuRdgKQp8b4JCwdr34hI=;
        b=QtzroWOF5E9gMdr4AyvUTkSmkZUjyUSwk+JoJAAr0FMGbSI1iO2slJlENx4YSdMRTc
         uuVVUArh39zt3x7CMcm844c3dhHxvuf2OAi953OVvPTeRHpmmLdBnfRNAH/TbzZpuFYx
         xkAhnXeBd454U1ohiDUGaEsL/wdzCqKwzo3tRwT2iuBAygGx9liCxCGTuP+isPJ2zYZX
         fjR9rRepFoSLswcv1EB3liVoZcexALlPKE+f5uhkvZ3a2BzKbk1VJnVKCR0Cm11HBSUr
         UJS6NUNIhE7xjKXeE/0NCkLN21wwicmQL39eH/az1x47C8+PDe1mDhflJBXDLI0E5R5M
         MrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Xpqt1NtbDbpAVLHQUxG3xmewuRdgKQp8b4JCwdr34hI=;
        b=pkHOfzmEwuIRixi6fVJIrdnri30ZN9LTmy7m8Ivqmc64LIl+4uqbrQtjhDoEP3x81c
         ncOW4jujOUfxUsowckw05M0dhTF4DvUzuf/ys2bG804zVjhAuLLfCQAaystdZAf5UW1C
         pCa/PyzpLfz6RsOW/hBLv82wtXlrnv1aZEB+0fi7aEsj8EG7/fHUv+hMCSfeaDf/G+fk
         daV3dZ5xDi7jfsW+/2Rj1zbpyAyjQ4+rPbf1g7R2k+kixH6IKPqslzENBVYqt+Uf6gnk
         gFeADo/WymjBeZgPhtWDwYwJn6ZYgB4AtqYnU4tYk2A0fxfythWlnhEx2NTYORrrwleX
         QA1g==
X-Gm-Message-State: AOAM531+Tv9jkiNcWnA1ubfMS0F/355NgDYL38rusGIEH0quvrVZ+KhZ
        duv3qNpddFFGR7DHJub82YW66tf9qossfbwZzlR6tQ==
X-Google-Smtp-Source: ABdhPJxBeGPMvVuG1sIymr9wVMvcytGhqiKQiINHDEotf65oS6N4XgRocxSJJfRl6vIMgvqKukGI1NKjGeTFff+/Xhai4g==
X-Received: by 2002:a05:6902:514:: with SMTP id x20mr31555487ybs.160.1593036064391;
 Wed, 24 Jun 2020 15:01:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 15:00:35 -0700
Message-Id: <20200624220035.237028-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [RFC v1] kunit: tool: add support for QEMU
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add basic support to run QEMU via kunit_tool. Add support for i386,
x86_64, arm, arm64, and a couple others.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch is very RFC; nevertheless, I wanted to get it out onto the
list before I fix some of the more obvious problems.

In particular, the most obvious issue is what to do about dependencies
namely QEMU and toolchains. Part of me thinks that we should do the
normal toolchain prefix thing, but it is really handy to specify to
switch between complier versions and QEMU versions with a single flag.

Another idea is to install needed dependencies like what 0day does with
its build scripts.

Another note: I only included the most straightforwardly working
architectures for this initial patch; namely all the architectures which
work with a toolchain and a QEMU architecture available on the Debian
apt repos and otherwise don't require changes to kunit_tool which are
too radical.

Ideas are welcomed!

---
 tools/testing/kunit/kunit.py        |  14 +-
 tools/testing/kunit/kunit_config.py |   2 +-
 tools/testing/kunit/kunit_kernel.py | 201 +++++++++++++++++++++++++---
 3 files changed, 195 insertions(+), 22 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f9b769f3437dd..b326cfd3982e5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -76,10 +76,10 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.alltests,
-					request.jobs,
-					request.build_dir,
-					request.make_options)
+	success = linux.build_kernel(request.alltests,
+				     request.jobs,
+				     request.build_dir,
+				     request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
@@ -235,6 +235,10 @@ def main(argv, linux=None):
 				  help='Specifies the file to read results from.',
 				  type=str, nargs='?', metavar='input_file')
 
+	run_parser.add_argument('--arch',
+				help='Specifies the architecture to run tests under.',
+				type=str, default='um', metavar='arch')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -248,7 +252,7 @@ def main(argv, linux=None):
 			create_default_kunitconfig()
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree()
+			linux = kunit_kernel.LinuxSourceTree(arch=cli_args.arch)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 02ffc3a3e5dc7..6aea9d213762a 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -53,7 +53,7 @@ class Kconfig(object):
 		return True
 
 	def write_to_file(self, path: str) -> None:
-		with open(path, 'w') as f:
+		with open(path, 'a+') as f:
 			for entry in self.entries():
 				f.write(str(entry) + '\n')
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index d6a575f92317c..c1b2cbc9f5705 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,6 +14,8 @@ import signal
 
 from contextlib import ExitStack
 
+from collections import namedtuple
+
 import kunit_config
 import kunit_parser
 
@@ -32,6 +34,10 @@ class BuildError(Exception):
 class LinuxSourceTreeOperations(object):
 	"""An abstraction over command line operations performed on a source tree."""
 
+	def __init__(self, linux_arch, cross_compile):
+		self._linux_arch = linux_arch
+		self._cross_compile = cross_compile
+
 	def make_mrproper(self):
 		try:
 			subprocess.check_output(['make', 'mrproper'])
@@ -40,12 +46,18 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
+	def make_arch_qemuconfig(self, build_dir):
+		pass
+
 	def make_olddefconfig(self, build_dir, make_options):
-		command = ['make', 'ARCH=um', 'olddefconfig']
+		command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
+		if self._cross_compile:
+			command += ['CROSS_COMPILE=' + self._cross_compile]
 		if make_options:
 			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
+		print(' '.join(command))
 		try:
 			subprocess.check_output(command, stderr=subprocess.PIPE)
 		except OSError as e:
@@ -55,27 +67,24 @@ class LinuxSourceTreeOperations(object):
 
 	def make_allyesconfig(self):
 		kunit_parser.print_with_timestamp(
-			'Enabling all CONFIGs for UML...')
+			'Enabling all CONFIGs...')
 		process = subprocess.Popen(
-			['make', 'ARCH=um', 'allyesconfig'],
+			['make', 'ARCH=' + self._linux_arch, 'allyesconfig'],
 			stdout=subprocess.DEVNULL,
 			stderr=subprocess.STDOUT)
 		process.wait()
-		kunit_parser.print_with_timestamp(
-			'Disabling broken configs to run KUnit tests...')
-		with ExitStack() as es:
-			config = open(KCONFIG_PATH, 'a')
-			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
-			config.write(disable)
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
 	def make(self, jobs, build_dir, make_options):
-		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
+		if self._cross_compile:
+			command += ['CROSS_COMPILE=' + self._cross_compile]
 		if build_dir:
 			command += ['O=' + build_dir]
+		print(' '.join(command))
 		try:
 			subprocess.check_output(command)
 		except OSError as e:
@@ -83,15 +92,167 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise BuildError(e.output)
 
-	def linux_bin(self, params, timeout, build_dir, outfile):
+	def run(self, params, timeout, build_dir, outfile):
+		pass
+
+QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
+					       'cross_compile',
+					       'qemuconfig',
+					       'qemu_arch',
+					       'kernel_path',
+					       'kernel_command_line',
+					       'extra_qemu_params'])
+
+QEMU_ARCHS = {
+	'i386'		: QemuArchParams(linux_arch='i386',
+				cross_compile=None,
+				qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
+				qemu_arch='x86_64',
+				kernel_path='arch/x86/boot/bzImage',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=['']),
+	'x86_64'	: QemuArchParams(linux_arch='x86_64',
+				cross_compile=None,
+				qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
+				qemu_arch='x86_64',
+				kernel_path='arch/x86/boot/bzImage',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=['']),
+	'arm'		: QemuArchParams(linux_arch='arm',
+				cross_compile='arm-linux-gnueabihf-',
+				qemuconfig='''CONFIG_ARCH_VIRT=y
+CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
+				qemu_arch='arm',
+				kernel_path='arch/arm/boot/zImage',
+				kernel_command_line='console=ttyAMA0',
+				extra_qemu_params=['-machine virt']),
+	'arm64'		: QemuArchParams(linux_arch='arm64',
+				cross_compile='aarch64-linux-gnu-',
+				qemuconfig='''CONFIG_SERIAL_AMBA_PL010=y
+CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
+				qemu_arch='aarch64',
+				kernel_path='arch/arm64/boot/Image.gz',
+				kernel_command_line='console=ttyAMA0',
+				extra_qemu_params=['-machine virt', '-cpu cortex-a57']),
+	'alpha'		: QemuArchParams(linux_arch='alpha',
+				cross_compile='alpha-linux-gnu-',
+				qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
+				qemu_arch='alpha',
+				kernel_path='arch/alpha/boot/vmlinux',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=['']),
+	'powerpc'	: QemuArchParams(linux_arch='powerpc',
+				cross_compile='powerpc64-linux-gnu-',
+				qemuconfig='CONFIG_PPC64=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_HVC_CONSOLE=y',
+				qemu_arch='ppc64',
+				kernel_path='vmlinux',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=['-M pseries', '-cpu power8']),
+	'riscv'		: QemuArchParams(linux_arch='riscv',
+				cross_compile='riscv64-linux-gnu-',
+				qemuconfig='CONFIG_SOC_VIRT=y\nCONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y\nCONFIG_SERIAL_OF_PLATFORM=y\nCONFIG_SERIAL_EARLYCON_RISCV_SBI=y',
+				qemu_arch='riscv64',
+				kernel_path='arch/riscv/boot/Image',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=['-machine virt', '-cpu rv64', '-bios opensbi-riscv64-virt-fw_jump.bin']),
+	's390'		: QemuArchParams(linux_arch='s390',
+				cross_compile='s390x-linux-gnu-',
+				qemuconfig='CONFIG_EXPERT=y\nCONFIG_TUNE_ZEC12=y\nCONFIG_NUMA=y\nCONFIG_MODULES=y',
+				qemu_arch='s390x',
+				kernel_path='arch/s390/boot/bzImage',
+				kernel_command_line='console=ttyS0',
+				extra_qemu_params=[
+						'-machine s390-ccw-virtio',
+						'-cpu qemu',]),
+	'sparc'		: QemuArchParams(linux_arch='sparc',
+				cross_compile='sparc64-linux-gnu-',
+				qemuconfig='CONFIG_SERIAL_8250=y\nCONFIG_SERIAL_8250_CONSOLE=y',
+				qemu_arch='sparc',
+				kernel_path='arch/sparc/boot/zImage',
+				kernel_command_line='console=ttyS0 mem=256M',
+				extra_qemu_params=['-m 256']),
+}
+
+class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
+
+	def __init__(self, qemu_arch_params):
+		super().__init__(linux_arch=qemu_arch_params.linux_arch,
+				 cross_compile=qemu_arch_params.cross_compile)
+		self._qemuconfig = qemu_arch_params.qemuconfig
+		self._qemu_arch = qemu_arch_params.qemu_arch
+		self._kernel_path = os.path.join(os.getcwd(), qemu_arch_params.kernel_path)
+		print(self._kernel_path)
+		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
+		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
+
+	def make_arch_qemuconfig(self, build_dir):
+		qemuconfig = kunit_config.Kconfig()
+		qemuconfig.parse_from_string(self._qemuconfig)
+		qemuconfig.write_to_file(get_kconfig_path(build_dir))
+
+	def run(self, params, timeout, build_dir, outfile):
+		kernel_path = os.path.join(build_dir, self._kernel_path)
+		qemu_command = ['qemu-system-' + self._qemu_arch,
+				'-nodefaults',
+				'-m', '1024',
+				'-kernel', kernel_path,
+				'-append', '\'' + ' '.join(params + [self._kernel_command_line]) + '\'',
+				'-no-reboot',
+				'-nographic',
+				'-serial stdio'] + self._extra_qemu_params
+		print(' '.join(qemu_command))
+		with open(outfile, 'w') as output:
+			process = subprocess.Popen(' '.join(qemu_command),
+						   stdin=subprocess.PIPE,
+						   stdout=output,
+						   stderr=subprocess.STDOUT,
+						   text=True, shell=True)
+		try:
+			process.wait(timeout=timeout)
+		except Exception as e:
+			print(e)
+			process.terminate()
+		return process
+
+class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
+	"""An abstraction over command line operations performed on a source tree."""
+
+	def __init__(self):
+		super().__init__(linux_arch='um', cross_compile=None)
+
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
+	def run(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
 		linux_bin = './linux'
 		if build_dir:
 			linux_bin = os.path.join(build_dir, 'linux')
 		with open(outfile, 'w') as output:
 			process = subprocess.Popen([linux_bin] + params,
+						   stdin=subprocess.PIPE,
 						   stdout=output,
-						   stderr=subprocess.STDOUT)
+						   stderr=subprocess.STDOUT,
+						   text=True)
 			process.wait(timeout)
 
 
@@ -104,11 +265,17 @@ def get_kconfig_path(build_dir):
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self):
+	def __init__(self, arch=None):
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
-		self._ops = LinuxSourceTreeOperations()
 		signal.signal(signal.SIGINT, self.signal_handler)
+		self._ops = None
+		if arch is None or arch == 'um':
+			self._ops = LinuxSourceTreeOperationsUml()
+		elif arch in QEMU_ARCHS:
+			self._ops = LinuxSourceTreeOperationsQemu(QEMU_ARCHS[arch])
+		else:
+			raise ConfigError(arch + ' is not a valid arch')
 
 	def clean(self):
 		try:
@@ -138,6 +305,7 @@ class LinuxSourceTree(object):
 			os.mkdir(build_dir)
 		self._kconfig.write_to_file(kconfig_path)
 		try:
+			self._ops.make_arch_qemuconfig(build_dir)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
 			logging.error(e)
@@ -160,10 +328,11 @@ class LinuxSourceTree(object):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
+	def build_kernel(self, alltests, jobs, build_dir, make_options):
 		if alltests:
 			self._ops.make_allyesconfig()
 		try:
+			self._ops.make_arch_qemuconfig(build_dir)
 			self._ops.make_olddefconfig(build_dir, make_options)
 			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
@@ -174,7 +343,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=[], build_dir='', timeout=None):
 		args.extend(['mem=1G', 'kunit_shutdown=halt'])
 		outfile = 'test.log'
-		self._ops.linux_bin(args, timeout, build_dir, outfile)
+		self._ops.run(args, timeout, build_dir, outfile)
 		subprocess.call(['stty', 'sane'])
 		with open(outfile, 'r') as file:
 			for line in file:

base-commit: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
prerequisite-patch-id: 2d4b5aa9fa8ada9ae04c8584b47c299a822b9455
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
prerequisite-patch-id: 97b0f3dca8a284c6f5b14fac7f10a97def18610d
prerequisite-patch-id: 4b806b7fc93ca6464395d8e193378bff4b2f5c5e
prerequisite-patch-id: 25411ef134020a4711e72f464cfeee486e1cca67
prerequisite-patch-id: 91f01e8965eedc34327e871f4a6a33187c94aeaf
prerequisite-patch-id: 2a32d1d634e155a4a933d8f902ab717bf03ca487
prerequisite-patch-id: 00b3e340d3463d2ed7872400dd408b9188652553
prerequisite-patch-id: ee2aef0c799110f798f99f3a713f7e905595ec7b
prerequisite-patch-id: a99bf1505ed65027369f3cf71e45bca2b7e07d9b
prerequisite-patch-id: 8c9d94f6e7ffefa30597e9b68fba32d3c3407205
prerequisite-patch-id: 31d4fd7c057aca679253e6af504efc215ec50716
prerequisite-patch-id: 239e1866d9237e84fb626d91330c13ea0b8bae86
-- 
2.27.0.212.ge8ba1cc988-goog

