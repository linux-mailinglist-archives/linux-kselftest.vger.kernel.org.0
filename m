Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521D118FD41
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCWTFK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 15:05:10 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46680 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCWTFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 15:05:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id s18so11533768pgd.13
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=62ODFo7fgtXrZQirhZFriVDxWJbpN32F85/2VefFryo=;
        b=rlLq4n/miZ/WNYaR8D0o1QhJuCKChqbKhtqfObtqtHzh3ZK09KPXexT576LOjSw3qH
         MrHnfw7INxbbdsjnuJy+239bqBeW/7MV9P98a8o70j95TzgbbxBYPny55hqrBM5l/Yo8
         wSeImOAGWwY6yzb5U5KFsBEbf+zmK7NrrnUROgF4wS5a4pa5LbSPUU/iwXNYUBeWz16T
         LwfqL3FR2iQTKHan5y65vPha46ce5jMsQ8qam1pNx3zq+CyaOFjiPKY5aqibqdv+Lceg
         kk/fUCQZjTJW8+MEGeocQphtfjQ/+5O1TwgcAwkbi7UzM3VcpJF/AM97lQXYXAYa+6Cg
         9fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=62ODFo7fgtXrZQirhZFriVDxWJbpN32F85/2VefFryo=;
        b=FdcLn4FwgHGeGCCsWMblMvkohGlzHqdu5ipAjAvsdTU/HHQs7zGgH7BgDrMII0iV4v
         iLIjj+OoIywYQJNbdUIgaY9PoO/2nERc+Jpq4/4haBaQ84x6DBoi+YQPaiGTpF7Ma0d4
         KT9cFdibv4GPdhQpTIga+29gMCcbtrsjKr+w1Qovbfzlv34OIO3J2G1cXtgsWU5XSXwk
         gJsPa4ImwocfpTFRDlJ7kBOCi/HeKdQciTwJo+hwgouvWbhzvB+oX7cpVSxfHZFVxABB
         54y2Qrs1A3E1O2ct77pFDFaXDKcA70farUaJHnwnEUO99vX5cHljp8nbqBYW270OhZNN
         a0UA==
X-Gm-Message-State: ANhLgQ2GMnGuXtaYap4mjW38K9h0IZ2qwFUHrUtLHX4p5Mx6FIPqSCX/
        Ar6e4VNpvKNw9zes+PkX/k+Sc+X0c+gvWQn6X/LNog==
X-Google-Smtp-Source: ADFU+vu60MjNR8qzisTn2g+enOhutcBQfdSiszlSCdNZiG9hSVpVqoH9ZuWAdaiqf7WCYmN1QexHDoTKiL0zlXbSGQCUgg==
X-Received: by 2002:a17:90b:14cb:: with SMTP id jz11mr910275pjb.142.1584990305331;
 Mon, 23 Mar 2020 12:05:05 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:04:59 -0700
Message-Id: <20200323190459.64737-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH rebase v2] kunit: add --make_options
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, gthelen@google.com, natechancellor@gmail.com
Cc:     linux-kselftest@vger.kernel.org, davidgow@google.com,
        kunit-dev@googlegroups.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
optional --make_options flag to kunit.py allowing for the operator to
specify extra build options.

This allows use of the clang compiler for kunit:
  tools/testing/kunit/kunit.py run --defconfig \
    --make_options CC=clang --make_options HOSTCC=clang

Signed-off-by: Greg Thelen <gthelen@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py        | 14 ++++++++++----
 tools/testing/kunit/kunit_kernel.py | 24 ++++++++++++++----------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 650bb4cfc544..7dca74774dd2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -24,7 +24,7 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'defconfig',
-					   'alltests'])
+					   'alltests', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -49,7 +49,7 @@ def get_kernel_root_path():
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
-	success = linux.build_reconfig(request.build_dir)
+	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
@@ -59,7 +59,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_start = time.time()
 	success = linux.build_um_kernel(request.alltests,
 					request.jobs,
-					request.build_dir)
+					request.build_dir,
+					request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
@@ -125,6 +126,10 @@ def main(argv, linux=None):
 				help='Run all KUnit tests through allyesconfig',
 				action='store_true')
 
+	run_parser.add_argument('--make_options',
+				help='X=Y make option, can be repeated.',
+				action='append')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -149,7 +154,8 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.defconfig,
-				       cli_args.alltests)
+				       cli_args.alltests,
+				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 415d8f3c4fe4..63dbda2d029f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -40,8 +40,10 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make_olddefconfig(self, build_dir):
+	def make_olddefconfig(self, build_dir, make_options):
 		command = ['make', 'ARCH=um', 'olddefconfig']
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -68,8 +70,10 @@ class LinuxSourceTreeOperations(object):
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
-	def make(self, jobs, build_dir):
+	def make(self, jobs, build_dir, make_options):
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -128,19 +132,19 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_config(self, build_dir):
+	def build_config(self, build_dir, make_options):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		self._kconfig.write_to_file(kconfig_path)
 		try:
-			self._ops.make_olddefconfig(build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
 			logging.error(e)
 			return False
 		return self.validate_config(build_dir)
 
-	def build_reconfig(self, build_dir):
+	def build_reconfig(self, build_dir, make_options):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -149,19 +153,19 @@ class LinuxSourceTree(object):
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
 				os.remove(kconfig_path)
-				return self.build_config(build_dir)
+				return self.build_config(build_dir, make_options)
 			else:
 				return True
 		else:
 			print('Generating .config ...')
-			return self.build_config(build_dir)
+			return self.build_config(build_dir, make_options)
 
-	def build_um_kernel(self, alltests, jobs, build_dir):
+	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
 		if alltests:
 			self._ops.make_allyesconfig()
 		try:
-			self._ops.make_olddefconfig(build_dir)
-			self._ops.make(jobs, build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
+			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False

base-commit: f90ead0534f28c96dd8149ca13408d167bed9209
-- 
2.25.1.696.g5e7596f4ac-goog

