Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4C16F45E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 01:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgBZAdg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 19:33:36 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:41364 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAdd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 19:33:33 -0500
Received: by mail-il1-f180.google.com with SMTP id f10so830247ils.8
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 16:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=cF+cf0TvkH5gluf6NeH9N2EMiwXac4QQvmLsm1w4peg=;
        b=LzQ3sDXI5B9SS8btnv7UsZwmgPQT1E2mlEvqy1i+cvj41J+Ovgq6F1UVuAEgImU+Gr
         4lHglaykDuUOxBe9ORomJhj71jtlpwtHfZ0Cnl+nwD6zDhc6H3NFuy1K4I7anPv5G/sG
         gQSFoj9KapxLN7rA0UJodWSB3amwaA+Afd8RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=cF+cf0TvkH5gluf6NeH9N2EMiwXac4QQvmLsm1w4peg=;
        b=dfmYljKy/4zuqr9bC8FeSvOiNFHFA6TLeWBUlmgNxt9TvNydwsm2p9feusbnKUHGEu
         FKqbOTIqEmkwCDAluiG0cryjhULDsGRJNUc6A9KRSFoc9gp/sdmVJaHOKZmzKG6ypwxo
         Od5L80ToLMHvhRKQ3pw05UoEdZ0VBNcjhDN7rvGyKKYqM9x2vvp/0S9JUIaYjzUqMaAo
         rCp6thwb65CfCJg9xllnrDBFaTEovmh0pzz14dQa3+f+XItayN6LAS3W87H+bG9XO95D
         dEuSGBJOj/XNG/zp03Al4YE23TRLd40GzFAxfL0V8WBWwU3OZOWiMqG1adPTJWyn5D14
         i76w==
X-Gm-Message-State: APjAAAUhLykQ3revF/vxeVvIExU0IIvKjJT0aiTmc01CuiViXR+eK5LL
        NXey2XJ2F5PRqu8OV6nqUzk4huxPApc=
X-Google-Smtp-Source: APXvYqyAvDBmc4k6IovdR72VFQDAWbh7Erl6Plnv0T9BmtvK9APLkVvmjUyCnZA9zQ94gKHtPU+UWg==
X-Received: by 2002:a92:8458:: with SMTP id l85mr1425672ild.296.1582677212122;
        Tue, 25 Feb 2020 16:33:32 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o76sm140657ili.8.2020.02.25.16.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 16:33:31 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest kunit update for Linux 5.6-rc4
Message-ID: <728b8941-6687-d3b3-2156-1d74ee4dc3db@linuxfoundation.org>
Date:   Tue, 25 Feb 2020 17:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EAD8E6D2B4D83A7CBD97E73B"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------EAD8E6D2B4D83A7CBD97E73B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest kunit update for Linux 5.6-rc4.

This Kselftest kunit update consists of fixes to documentation and
run-time tool from Brendan Higgins and Heidi Fahim.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.6-rc4

for you to fetch changes up to be886ba90cce2fb2f5a4dbcda8f3be3fd1b2f484:

   kunit: run kunit_tool from any directory (2020-02-19 15:58:07 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.6-rc4

This Kselftest kunit update consists of fixes to documentation and
run-time tool from Brendan Higgins and Heidi Fahim.

----------------------------------------------------------------
Brendan Higgins (1):
       Documentation: kunit: fixed sphinx error in code block

Heidi Fahim (2):
       kunit: test: Improve error messages for kunit_tool when 
kunitconfig is invalid
       kunit: run kunit_tool from any directory

  Documentation/dev-tools/kunit/usage.rst |  1 +
  tools/testing/kunit/kunit.py            | 12 ++++++++++++
  tools/testing/kunit/kunit_kernel.py     | 28 ++++++++++++++++------------
  3 files changed, 29 insertions(+), 12 deletions(-)

----------------------------------------------------------------

--------------EAD8E6D2B4D83A7CBD97E73B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.6-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.6-rc4.diff"

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 7cd56a1993b1..607758a66a99 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -551,6 +551,7 @@ options to your ``.config``:
 Once the kernel is built and installed, a simple
 
 .. code-block:: bash
+
 	modprobe example-test
 
 ...will run the tests.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e59eb9e7f923..180ad1e1b04f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -24,6 +24,8 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
+KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
+
 class KunitStatus(Enum):
 	SUCCESS = auto()
 	CONFIG_FAILURE = auto()
@@ -35,6 +37,13 @@ def create_default_kunitconfig():
 		shutil.copyfile('arch/um/configs/kunit_defconfig',
 				kunit_kernel.kunitconfig_path)
 
+def get_kernel_root_path():
+	parts = sys.argv[0] if not __file__ else __file__
+	parts = os.path.realpath(parts).split('tools/testing/kunit')
+	if len(parts) != 2:
+		sys.exit(1)
+	return parts[0]
+
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	config_start = time.time()
@@ -114,6 +123,9 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
+		if get_kernel_root_path():
+			os.chdir(get_kernel_root_path())
+
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..d99ae75ef72f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -93,6 +93,20 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
+	def validate_config(self, build_dir):
+		kconfig_path = get_kconfig_path(build_dir)
+		validated_kconfig = kunit_config.Kconfig()
+		validated_kconfig.read_from_file(kconfig_path)
+		if not self._kconfig.is_subset_of(validated_kconfig):
+			invalid = self._kconfig.entries() - validated_kconfig.entries()
+			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
+					  'but not in .config: %s' % (
+					', '.join([str(e) for e in invalid])
+			)
+			logging.error(message)
+			return False
+		return True
+
 	def build_config(self, build_dir):
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
@@ -103,12 +117,7 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			logging.error('Provided Kconfig is not contained in validated .config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def build_reconfig(self, build_dir):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
@@ -133,12 +142,7 @@ class LinuxSourceTree(object):
 		except (ConfigError, BuildError) as e:
 			logging.error(e)
 			return False
-		used_kconfig = kunit_config.Kconfig()
-		used_kconfig.read_from_file(get_kconfig_path(build_dir))
-		if not self._kconfig.is_subset_of(used_kconfig):
-			logging.error('Provided Kconfig is not contained in final config!')
-			return False
-		return True
+		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], timeout=None, build_dir=''):
 		args.extend(['mem=256M'])

--------------EAD8E6D2B4D83A7CBD97E73B--
