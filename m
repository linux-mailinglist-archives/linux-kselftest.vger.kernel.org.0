Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7442942999E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 01:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJKXJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhJKXJ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 19:09:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9DEC06161C
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 16:07:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r134so10453528iod.11
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=P+dOL8YCkCS+M9njSgrTchU0oQ1w/SWbaVmp/lr8Y1U=;
        b=RggLfEDZBaS0Ty2wwLTktSTJsSOpGf0SlGVzyaZtFR5v3eqKCfQaylkVmTXqaXJoJH
         PbDoPrRoffIP1ndUO3HUftKGh4C7bpP3kEvu6cipEWkdX3+AGmM62sHq8viHgVvM/BuM
         kho84/Xiq++KETp07vB6l/PSu+bCiDcq/VER4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=P+dOL8YCkCS+M9njSgrTchU0oQ1w/SWbaVmp/lr8Y1U=;
        b=YjsCHMmfTnp4W+4ax3YO9v8nwoVkaAEum6TTSHL/yChNsHXqmEPX683N21nVnVIwdS
         Y4nYC3efvujRdbyHtui9yw9zJlw9t2/MbBPcSerHKtZNtkIy+Kf0u/Q2X4KdkKFt3Ia0
         9UwpJ8eqP2fCocy8m8pPJ9Zlub38oTPaQJ2cx/dk++KKJ1NqiZp2pDZCwgyKoRuPMHqw
         sScXBureZLgT5fgviaDNJNfwB7ReR7geMNI5an6G82zsm054RlTW6sBDKemt9HIgoSOj
         54ZmWRlrI22RXa/MWCHXxsQLVeF0J52S2n6SIX+szEH/J0eMnAD3Qq0JWnOf20B21c0z
         wxyw==
X-Gm-Message-State: AOAM533Hs7sJkRPZ9RYeLO2r+LO2/QPDihhdFZMBV+JIeYUJW3u5VKJ4
        ui7s1fyiOgtLJlR7t3F3e1M26g==
X-Google-Smtp-Source: ABdhPJyLG2fxYcCj8gSY58fMhphGKXalXwHfvMWUmHMiBWRXqt3MR+fw6JXO/NEviWcrTL5DyhJg1w==
X-Received: by 2002:a05:6602:2f16:: with SMTP id q22mr11803163iow.29.1633993676091;
        Mon, 11 Oct 2021 16:07:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l20sm4699705ioh.34.2021.10.11.16.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 16:07:55 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 5.15-rc6
Message-ID: <4972e6a4-54cd-ab86-757e-6078e9c66a30@linuxfoundation.org>
Date:   Mon, 11 Oct 2021 17:07:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8F9B7E04D3AB73465DD1E6F0"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------8F9B7E04D3AB73465DD1E6F0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.15-rc6.

This KUnit fixes update for Linux 5.15-rc6 consists of:

- Fixes to address the structleak plugin causing the stack frame size
   to grow immensely when used with KUnit. Fixes include adding a new
   makefile to disable structleak and using it from KUnit iio, device
   property, thunderbolt, and bitfield tests to disable it.

- KUnit framework reference count leak in kfree_at_end

- KUnit tool fix to resolve conflict between --json and --raw_output
   and generate correct test output in either case.

- kernel-doc warnings due to mismatched arg names

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.15-rc6

for you to fetch changes up to 361b57df62de249dc0b2acbf48823662a5001bcd:

   kunit: fix kernel-doc warnings due to mismatched arg names (2021-10-06 17:54:07 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.15-rc6

This KUnit fixes update for Linux 5.15-rc6 consists of:

- Fixes to address the structleak plugin causing the stack frame size
   to grow immensely when used with KUnit. Fixes include adding a new
   makefile to disable structleak and using it from KUnit iio, device
   property, thunderbolt, and bitfield tests to disable it.

- KUnit framework reference count leak in kfree_at_end

- KUnit tool fix to resolve conflict between --json and --raw_output
   and generate correct test output in either case.

- kernel-doc warnings due to mismatched arg names

----------------------------------------------------------------
Arnd Bergmann (1):
       bitfield: build kunit tests without structleak plugin

Brendan Higgins (4):
       gcc-plugins/structleak: add makefile var for disabling structleak
       iio/test-format: build kunit tests without structleak plugin
       device property: build kunit tests without structleak plugin
       thunderbolt: build kunit tests without structleak plugin

Daniel Latypov (2):
       kunit: tool: better handling of quasi-bool args (--json, --raw_output)
       kunit: fix kernel-doc warnings due to mismatched arg names

Xiyu Yang (1):
       kunit: fix reference count leak in kfree_at_end

  drivers/base/test/Makefile             |  2 +-
  drivers/iio/test/Makefile              |  1 +
  drivers/thunderbolt/Makefile           |  1 +
  include/kunit/test.h                   |  6 +++---
  lib/Makefile                           |  2 +-
  lib/kunit/executor_test.c              |  4 ++--
  scripts/Makefile.gcc-plugins           |  4 ++++
  tools/testing/kunit/kunit.py           | 24 ++++++++++++++++++++++--
  tools/testing/kunit/kunit_tool_test.py |  8 ++++++++
  9 files changed, 43 insertions(+), 9 deletions(-)
----------------------------------------------------------------

--------------8F9B7E04D3AB73465DD1E6F0
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.15-rc6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.15-rc6.diff"

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 64b2f3d744d5..7f76fee6f989 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
-CFLAGS_REMOVE_property-entry-test.o += -fplugin-arg-structleak_plugin-byref -fplugin-arg-structleak_plugin-byref-all
+CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b495301..467519a2027e 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,3 +5,4 @@
 
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
+CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index da19d7987d00..78fd365893c1 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -7,6 +7,7 @@ thunderbolt-objs += usb4_port.o nvm.o retimer.o quirks.o
 thunderbolt-${CONFIG_ACPI} += acpi.o
 thunderbolt-$(CONFIG_DEBUG_FS) += debugfs.o
 thunderbolt-${CONFIG_USB4_KUNIT_TEST} += test.o
+CFLAGS_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 
 thunderbolt_dma_test-${CONFIG_USB4_DMA_TEST} += dma_test.o
 obj-$(CONFIG_USB4_DMA_TEST) += thunderbolt_dma_test.o
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..018e776a34b9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -613,7 +613,7 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
  * and is automatically cleaned up after the test case concludes. See &struct
  * kunit_resource for more information.
  */
-void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
 
 /**
  * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
@@ -657,9 +657,9 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
  *
  * See kcalloc() and kunit_kmalloc_array() for more information.
  */
-static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
+static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
-	return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
+	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
 void kunit_cleanup(struct kunit *test);
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37..a841be5244ac 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -351,7 +351,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 obj-$(CONFIG_PLDMFW) += pldmfw/
 
 # KUnit tests
-CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
+CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index cdbe54b16501..e14a18af573d 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -116,8 +116,8 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_and_get_resource(test, NULL, kfree_res_free, GFP_KERNEL,
-				     (void *)to_free);
+	kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
+			     (void *)to_free);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329..4aad28480035 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -19,6 +19,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
 		+= -fplugin-arg-structleak_plugin-byref
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
 		+= -fplugin-arg-structleak_plugin-byref-all
+ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
+    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
+endif
+export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5a931456e718..ac35c61f65f5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
-from typing import Iterable
+from typing import Iterable, Sequence
 
 import kunit_config
 import kunit_json
@@ -186,6 +186,26 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				exec_result.elapsed_time))
 	return parse_result
 
+# Problem:
+# $ kunit.py run --json
+# works as one would expect and prints the parsed test results as JSON.
+# $ kunit.py run --json suite_name
+# would *not* pass suite_name as the filter_glob and print as json.
+# argparse will consider it to be another way of writing
+# $ kunit.py run --json=suite_name
+# i.e. it would run all tests, and dump the json to a `suite_name` file.
+# So we hackily automatically rewrite --json => --json=stdout
+pseudo_bool_flag_defaults = {
+		'--json': 'stdout',
+		'--raw_output': 'kunit',
+}
+def massage_argv(argv: Sequence[str]) -> Sequence[str]:
+	def massage_arg(arg: str) -> str:
+		if arg not in pseudo_bool_flag_defaults:
+			return arg
+		return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
+	return list(map(massage_arg, argv))
+
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -303,7 +323,7 @@ def main(argv, linux=None):
 				  help='Specifies the file to read results from.',
 				  type=str, nargs='?', metavar='input_file')
 
-	cli_args = parser.parse_args(argv)
+	cli_args = parser.parse_args(massage_argv(argv))
 
 	if get_kernel_root_path():
 		os.chdir(get_kernel_root_path())
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..1edcc8373b4e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -408,6 +408,14 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_does_not_take_positional_args(self):
+		# --raw_output is a string flag, but we don't want it to consume
+		# any positional arguments, only ones after an '='
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
+
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)

--------------8F9B7E04D3AB73465DD1E6F0--
