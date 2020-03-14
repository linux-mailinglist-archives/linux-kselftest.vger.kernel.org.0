Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855401859A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 04:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCODTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Mar 2020 23:19:53 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:54640 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgCODTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Mar 2020 23:19:53 -0400
Received: by mail-oi1-f201.google.com with SMTP id d131so8412823oif.21
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Mar 2020 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FbErgK09Aa6nJYkuCUrBRaD9zp6nFWInm5nO78O2flo=;
        b=dT71Y4c2WVAAB5IgXSTJDnOtQjY8WEF1wVbvbUqQFMxmNoApirL/M5/zncSqkTWE6Z
         HxLYbw2q2fGPMxH+YEL3s3PiRxC/gMpy7IV5mkJMpAOd2DNHx4hGTYuHHKpO9e13U4FC
         jXeSBxPA+KubGo6G5pA+Qta1YYirGl6En/wK4D4v+uZPIeTK0fONXbu8vJDV0+8ZWeTi
         NG2Bw3eDeOfYRyCQLLJxk6lGY91zKrrw3hQ1Zgyzk+xqB7CS0JCODI9kZEWYoz6GOwY3
         Ca8JPg5Eq2LIzQzqirfpokHY66fl8CSEgS49JqFqXgsH9s4HMA9cOPFblqgAf15da3id
         zRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FbErgK09Aa6nJYkuCUrBRaD9zp6nFWInm5nO78O2flo=;
        b=csSq1xzPILfHF7LEH7vAxL28phqw2c4xUOmgMuYu5QWtF2ivEpuHAB6ryYx5F3M2kU
         IbGTdp7Mu9VuDuhGiD/TdHJrOkFnHc5L2vehcHEbqF4c0FvDoYwKk/bp3N39thQhCdVs
         SiTrv3jHh1WVHhifCYEQfUoW8P7Y25SfXdF/lcX4IF6K8AYoAtoD1W2Mj71GZxJLVLqa
         bdappGkCClt9+kAdKeOE2nl1Cbys4uY8KZXh9TmDCUP51ww+KQRkUz4JLhunipumSh1l
         TDr948RH1fyiQ9aEnuBmjJ41arxAfRfRV/7+p1DcRPjGRL51zUEdPyCQgvyW88To/H9u
         +72g==
X-Gm-Message-State: ANhLgQ2U6tFis9VU5fy0yECJe5v/JYhdUl1CxsaQpK1l6ATvzMOn5Blq
        1cAMiwK7YYHgvnxmztBaFZAn55FhjHDi
X-Google-Smtp-Source: ADFU+vs52dttlEPc8eM4+pYO49Ur3CNjHXgYtEqCExzv5cBIAaM+bJG9fw47aVA4R1AoKEK/fteySEH+/lLf
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr12636800pje.123.1584167046988;
 Fri, 13 Mar 2020 23:24:06 -0700 (PDT)
Date:   Fri, 13 Mar 2020 23:24:04 -0700
In-Reply-To: <4bb8eeef-54ac-86a7-4bc4-8e16fc149c1a@kernel.org>
Message-Id: <xr93y2s34fp7.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200227063134.261636-1-gthelen@google.com> <20200229015350.GA26612@ubuntu-m2-xlarge-x86>
 <4bb8eeef-54ac-86a7-4bc4-8e16fc149c1a@kernel.org>
Subject: Re: [PATCH] kunit: add --make_options
From:   Greg Thelen <gthelen@google.com>
To:     shuah <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

shuah <shuah@kernel.org> wrote:

> On 2/28/20 6:53 PM, Nathan Chancellor wrote:
>> On Wed, Feb 26, 2020 at 10:31:34PM -0800, 'Greg Thelen' via Clang Built Linux wrote:
>>> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
>>> optional --make_options flag to kunit.py allowing for the operator to
>>> specify extra build options.
>>>
>>> This allows use of the clang compiler for kunit:
>>>    tools/testing/kunit/kunit.py run --defconfig \
>>>      --make_options CC=clang --make_options HOSTCC=clang
>>>
>>> Signed-off-by: Greg Thelen <gthelen@google.com>
>> 
>> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>> 
>
> Please rebase on Linux 5.6-rc5 and resend. I tried applying
> on Linux 5.6-rc1 as well as 5.6-rc5 and both fail.
>
> thanks,
> -- Shuah

Rebased onto v5.6-rc5 below:

From 0517b2c8b481535fb52bd86e94be1fec9aaeead7 Mon Sep 17 00:00:00 2001
From: Greg Thelen <gthelen@google.com>
Date: Wed, 26 Feb 2020 22:31:34 -0800
Subject: [PATCH v2] kunit: add --make_options

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
index 180ad1e1b04f..1aa4d14dc28d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,7 +22,9 @@ import kunit_parser
 
 KunitResult = namedtuple('KunitResult', ['status','result'])
 
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
+KunitRequest = namedtuple('KunitRequest', ['raw_output', 'timeout', 'jobs',
+                                           'build_dir', 'defconfig',
+                                           'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -47,7 +49,7 @@ def get_kernel_root_path():
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
-	success = linux.build_reconfig(request.build_dir)
+	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
@@ -55,7 +57,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
-	success = linux.build_um_kernel(request.jobs, request.build_dir)
+	success = linux.build_um_kernel(request.jobs, request.build_dir, request.make_options)
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
@@ -120,6 +122,10 @@ def main(argv, linux=None):
 				help='Uses a default .kunitconfig.',
 				action='store_true')
 
+	run_parser.add_argument('--make_options',
+				help='X=Y make option, can be repeated.',
+				action='append')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -143,7 +149,8 @@ def main(argv, linux=None):
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
index d99ae75ef72f..27758d6d115b 100644
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
@@ -107,19 +111,19 @@ class LinuxSourceTree(object):
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
@@ -128,17 +132,17 @@ class LinuxSourceTree(object):
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
2.25.1.481.gfbce0eb801-goog

