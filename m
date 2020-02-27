Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C1171104
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 07:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgB0Gbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 01:31:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50375 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgB0Gbj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 01:31:39 -0500
Received: by mail-pl1-f202.google.com with SMTP id g5so1341971plq.17
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 22:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2XUDk4no3p+9z2Ml5E7VHydPfxYI6SLTr8vWXCSaN+Q=;
        b=hLQLTp30uB7qRRaTV3Qoxiy0ZM28IvvyDy6A/mJtLFSJ9cTU+otmILqRaFwyqO1Sfa
         F41zNoX97AReMIsW40DwwhHfGBdVdw7oHP8WTWMl3KBlQpL/tgc49qJ8GyDavSIM88Q/
         tILuTSvbMGYS+4lXyqlrxoOKpRFG+6vka/2qEbwOCstWRBHw2owbWGorggB3Auys+RAh
         PwQZLOceN7KpMZGjyQD7Smr4LnPbP/+qyzDqT774fU1RrL4Y8FNR6wJo5ogs9QWWzIKC
         q64qBGzA1gKZSFs33VbocfATrY0qikmPxOiW0xIRsAP1YoGs0rFDbRgHkjIGsQ+MYV7d
         kbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2XUDk4no3p+9z2Ml5E7VHydPfxYI6SLTr8vWXCSaN+Q=;
        b=dRn2jqjT8AbFp1geaThp2e6kgBAsWwINHlc5tW7fJUgjr9/wmjyas751Z0t3dsdig5
         BkkDBJRH5e8k5Ng9oeWNI5fU0T8Xf3vInF7BAUz4xhfMi5BWjr7XuuD1rM02AqbFk3FD
         jHZ94V7ynhRya/PmRwIJzietuSHz5D8MZ+7r3DUY9Dlw6sKe0y56xhTw2Efr8VGHjZlO
         ABTjb8g6wsMp3v8I0kQ88WKuDq/KF1Uu49FrAVR2Cws6ST4fGkR1oLrPmY4HpwP1k4bC
         qjM+r+a6FYmgaATJiNAcPQjk528Pk3xedxhssmhsC8/wX/Qzd668KQ2+WmUe3Tlca/yy
         MH0g==
X-Gm-Message-State: APjAAAXNLQtVMxN2jaBKyRcjiEYj+6sgqU3bY8SDoNbBhN9ZL8ohbMsj
        MNZ37RFcVQcBL7vvA5UD60bgvboG7I3n
X-Google-Smtp-Source: APXvYqyl0RW6hMTNXIe5Rp5nx3gL/2ub/AREq3c9SPFgA2UYd8WTzS/IyxSn/0lm0mTaaq6EuGNZKkAYNj1E
X-Received: by 2002:a63:fc56:: with SMTP id r22mr2532491pgk.147.1582785097892;
 Wed, 26 Feb 2020 22:31:37 -0800 (PST)
Date:   Wed, 26 Feb 2020 22:31:34 -0800
Message-Id: <20200227063134.261636-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] kunit: add --make_options
From:   Greg Thelen <gthelen@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
optional --make_options flag to kunit.py allowing for the operator to
specify extra build options.

This allows use of the clang compiler for kunit:
  tools/testing/kunit/kunit.py run --defconfig \
    --make_options CC=clang --make_options HOSTCC=clang

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/kunit/kunit.py        | 15 +++++++++++----
 tools/testing/kunit/kunit_kernel.py | 24 ++++++++++++++----------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..34a7ec8d9594 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,7 +22,9 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output', 'timeout', 'jobs',
+                                           'build_dir', 'defconfig',
+                                           'make_options'])
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -38,7 +40,7 @@ def create_default_kunitconfig():
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
-	success = linux.build_reconfig(request.build_dir)
+	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
@@ -46,7 +48,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	success = linux.build_um_kernel(request.jobs, request.build_dir, request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
@@ -111,6 +113,10 @@ def main(argv, linux=None):
 				help='Uses a default .kunitconfig.',
 				action='store_true')
 
+	run_parser.add_argument('--make_options',
+				help='X=Y make option, can be repeated.',
+				action='append')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -131,7 +137,8 @@ def main(argv, linux=None):
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
-				       cli_args.defconfig)
+				       cli_args.defconfig,
+				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..2b9b3fdbc13f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -35,8 +35,10 @@ class LinuxSourceTreeOperations(object):
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
@@ -46,8 +48,10 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output)
 
-	def make(self, jobs, build_dir):
+	def make(self, jobs, build_dir, make_options):
 		command = ['make', 'ARCH=um', '--jobs=' + str(jobs)]
+		if make_options:
+			command.extend(make_options)
 		if build_dir:
 			command += ['O=' + build_dir]
 		try:
@@ -93,13 +97,13 @@ class LinuxSourceTree(object):
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
@@ -110,7 +114,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def build_reconfig(self, build_dir):
+	def build_reconfig(self, build_dir, make_options):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
@@ -119,17 +123,17 @@ class LinuxSourceTree(object):
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
 
-	def build_um_kernel(self, jobs, build_dir):
+	def build_um_kernel(self, jobs, build_dir, make_options):
 		try:
-			self._ops.make_olddefconfig(build_dir)
-			self._ops.make(jobs, build_dir)
+			self._ops.make_olddefconfig(build_dir, make_options)
+			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
-- 
2.25.0.265.gbab2e86ba0-goog

