Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC01521A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEFQ5A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:57:00 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:36624 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEFQ5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:57:00 -0400
Received: by mail-it1-f172.google.com with SMTP id o190so3885419itc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=8Y5Xe8FFynGJJHYSKmWrW7EYukbHTGhN9R5pJsyai68=;
        b=F9v3NXhaxMyikacdI+1KmN7CfYn+gfoDOrSKrvDKSdGY8QvS9PM79kMFKZncziIMNR
         18MGDtAneVww0kCGSCQMNVvziqBN0H3QQ/yVXYJ6fWyPWYV9od7XS4RDb8b+kp3xwC2i
         Gs8H0TDuDxTk+i+80cxmcPU40y/2rBb8GBU04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=8Y5Xe8FFynGJJHYSKmWrW7EYukbHTGhN9R5pJsyai68=;
        b=uZOg+ZoZFHSVZesSSH+Ix8qI6gutkiEcMZ4BDL0JfFonMsqnpcBoz2Xr/DH8EUWXLe
         +6iGDYz+MmUf8td39kHlI0wryAkYvA+ofpaT0eWqHlD0YWwnsE3f/o50tHH4y0VO/VIQ
         VRAKGwpk5F2fbrI4bhVg4UoJNhVYVUGcVr+oK1uyv2iGZvigeMgCMkOydOBv4fNMbBNE
         N9pSP9su9U+oKCI8pNJQlL1Yo2aTcep482bJjumGxStFNMDvVgNqOpS3Ab6Xd077gfMw
         gM7j4MESRYH6B/hgOp8QmPIO/TukQAB3Sl+TQC2g+76U3TP1LUv4LFzZcZVDE8yV4+nP
         7bxg==
X-Gm-Message-State: APjAAAUfanJOzkkWH3MSl8xRqpm5XOCyCc6+Q3sdzw3DtX5rFceUX/sg
        Ix7S88WImhtEMHuctg/YuOj0gA==
X-Google-Smtp-Source: APXvYqwkIwDKKdjsH8iVRkLy/KPudb6G60nUEXov0EyfF/tD05PLSpYqa7G6dZ0qYGz+d518bIIWLA==
X-Received: by 2002:a05:660c:306:: with SMTP id u6mr18707746itj.59.1557161818096;
        Mon, 06 May 2019 09:56:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 10sm1832301ioo.27.2019.05.06.09.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:56:57 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.2-rc1
Message-ID: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
Date:   Mon, 6 May 2019 10:56:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------63B04A47C23346E373CCE94E"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------63B04A47C23346E373CCE94E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.2-rc1

This Kselftest update for Linux 5.2-rc1 consists of

- fixes to seccomp test, and kselftest framework
- cleanups to remove duplicate header defines
- fixes to efivarfs "make clean" target
- cgroup cleanup path
- Moving the IMA kexec_load selftest to selftests/kexec work from
   Mimi Johar and Petr Vorel
- A framework to kselftest for writing kernel test modules addition
   from Tobin C. Harding

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

   Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc1

for you to fetch changes up to d917fb876f6eaeeea8a2b620d2a266ce26372f4d:

   selftests: build and run gpio when output directory is the src dir 
(2019-04-22 17:02:26 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc1

This Kselftest update for Linux 5.2-rc1 consists of

- fixes to seccomp test, and kselftest framework
- cleanups to remove duplicate header defines
- fixes to efivarfs "make clean" target
- cgroup cleanup path
- Moving the IMA kexec_load selftest to selftests/kexec work from
   Mimi Johar and Petr Vorel
- A framework to kselftest for writing kernel test modules addition
   from Tobin C. Harding

----------------------------------------------------------------
Kees Cook (3):
       selftests/seccomp: Handle namespace failures gracefully
       selftests/harness: Add 30 second timeout per test
       selftests/ipc: Fix msgque compiler warnings

Mathieu Desnoyers (1):
       rseq/selftests: Adapt number of threads to the number of detected 
cpus

Mimi Zohar (9):
       selftests/kexec: move the IMA kexec_load selftest to selftests/kexec
       selftests/kexec: cleanup the kexec selftest
       selftests/kexec: define a set of common functions
       selftests/kexec: define common logging functions
       selftests/kexec: define "require_root_privileges"
       selftests/kexec: kexec_file_load syscall test
       selftests/kexec: check kexec_load and kexec_file_load are enabled
       selftests/kexec: make kexec_load test independent of IMA being 
enabled
       selftests/kexec: update get_secureboot_mode

Petr Vorel (1):
       selftests/kexec: Add missing '=y' to config options

Po-Hsu Lin (1):
       selftests/efivarfs: clean up test files from test_create*()

Roman Gushchin (1):
       selftests: cgroup: fix cleanup path in test_memcg_subtree_control()

Sabyasachi Gupta (4):
       selftest/x86/mpx-dig.c: Remove duplicate header
       selftest/timers: Remove duplicate header
       selftest/rseq: Remove duplicate header
       selftest/gpio: Remove duplicate header

Shuah Khan (2):
       selftests: fix headers_install circular dependency
       selftests: build and run gpio when output directory is the src dir

Tobin C. Harding (6):
       lib/test_printf: Add empty module_exit function
       kselftest: Add test runner creation script
       kselftest: Add test module framework header
       lib: Use new kselftest header
       lib/string: Add strscpy_pad() function
       lib: Add test module for strscpy_pad

ZhangXiaoxu (1):
       selftests: efivarfs: remove the test_create_read file if it was exist

  Documentation/dev-tools/kselftest.rst              |  94 ++++++++-
  include/linux/string.h                             |   4 +
  lib/Kconfig.debug                                  |   3 +
  lib/Makefile                                       |   1 +
  lib/string.c                                       |  47 ++++-
  lib/test_bitmap.c                                  |  20 +-
  lib/test_printf.c                                  |  17 +-
  lib/test_strscpy.c                                 | 150 ++++++++++++++
  tools/testing/selftests/Makefile                   |  63 +++++-
  tools/testing/selftests/cgroup/test_memcontrol.c   |  38 ++--
  tools/testing/selftests/efivarfs/efivarfs.sh       |  28 ++-
  tools/testing/selftests/gpio/gpio-mockup-chardev.c |   1 -
  tools/testing/selftests/ima/config                 |   4 -
  tools/testing/selftests/ima/test_kexec_load.sh     |  54 -----
  tools/testing/selftests/ipc/msgque.c               |  11 +-
  tools/testing/selftests/{ima => kexec}/Makefile    |   5 +-
  tools/testing/selftests/kexec/config               |   3 +
  tools/testing/selftests/kexec/kexec_common_lib.sh  | 220 
+++++++++++++++++++++
  .../selftests/kexec/test_kexec_file_load.sh        | 208 
+++++++++++++++++++
  tools/testing/selftests/kexec/test_kexec_load.sh   |  47 +++++
  tools/testing/selftests/kselftest_harness.h        |   2 +
  tools/testing/selftests/kselftest_module.h         |  48 +++++
  tools/testing/selftests/kselftest_module.sh        |  84 ++++++++
  tools/testing/selftests/lib.mk                     |  38 +++-
  tools/testing/selftests/lib/Makefile               |   2 +-
  tools/testing/selftests/lib/bitmap.sh              |  18 +-
  tools/testing/selftests/lib/config                 |   1 +
  tools/testing/selftests/lib/prime_numbers.sh       |  17 +-
  tools/testing/selftests/lib/printf.sh              |  19 +-
  tools/testing/selftests/lib/strscpy.sh             |   3 +
  tools/testing/selftests/rseq/rseq.h                |   1 -
  tools/testing/selftests/rseq/run_param_test.sh     |   7 +-
  tools/testing/selftests/seccomp/seccomp_bpf.c      |  43 ++--
  tools/testing/selftests/timers/skew_consistency.c  |   1 -
  tools/testing/selftests/x86/mpx-dig.c              |   2 -
  35 files changed, 1081 insertions(+), 223 deletions(-)
  create mode 100644 lib/test_strscpy.c
  delete mode 100644 tools/testing/selftests/ima/config
  delete mode 100755 tools/testing/selftests/ima/test_kexec_load.sh
rename tools/testing/selftests/{ima => kexec}/Makefile (59%)
  create mode 100644 tools/testing/selftests/kexec/config
  create mode 100755 tools/testing/selftests/kexec/kexec_common_lib.sh
  create mode 100755 tools/testing/selftests/kexec/test_kexec_file_load.sh
  create mode 100755 tools/testing/selftests/kexec/test_kexec_load.sh
  create mode 100644 tools/testing/selftests/kselftest_module.h
  create mode 100755 tools/testing/selftests/kselftest_module.sh
  create mode 100755 tools/testing/selftests/lib/strscpy.sh
----------------------------------------------------------------

--------------63B04A47C23346E373CCE94E
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc1.diff"

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 7756f7a7c23b..c8c03388b9de 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -14,6 +14,10 @@ in safe mode with a limited scope. In limited mode, cpu-hotplug test is
 run on a single cpu as opposed to all hotplug capable cpus, and memory
 hotplug test is run on 2% of hotplug capable memory instead of 10%.
 
+kselftest runs as a userspace process.  Tests that can be written/run in
+userspace may wish to use the `Test Harness`_.  Tests that need to be
+run in kernel space may wish to use a `Test Module`_.
+
 Running the selftests (hotplug tests are run in limited mode)
 =============================================================
 
@@ -161,11 +165,97 @@ Contributing new tests (details)
 
    e.g: tools/testing/selftests/android/config
 
+Test Module
+===========
+
+Kselftest tests the kernel from userspace.  Sometimes things need
+testing from within the kernel, one method of doing this is to create a
+test module.  We can tie the module into the kselftest framework by
+using a shell script test runner.  ``kselftest_module.sh`` is designed
+to facilitate this process.  There is also a header file provided to
+assist writing kernel modules that are for use with kselftest:
+
+- ``tools/testing/kselftest/kselftest_module.h``
+- ``tools/testing/kselftest/kselftest_module.sh``
+
+How to use
+----------
+
+Here we show the typical steps to create a test module and tie it into
+kselftest.  We use kselftests for lib/ as an example.
+
+1. Create the test module
+
+2. Create the test script that will run (load/unload) the module
+   e.g. ``tools/testing/selftests/lib/printf.sh``
+
+3. Add line to config file e.g. ``tools/testing/selftests/lib/config``
+
+4. Add test script to makefile  e.g. ``tools/testing/selftests/lib/Makefile``
+
+5. Verify it works:
+
+.. code-block:: sh
+
+   # Assumes you have booted a fresh build of this kernel tree
+   cd /path/to/linux/tree
+   make kselftest-merge
+   make modules
+   sudo make modules_install
+   make TARGETS=lib kselftest
+
+Example Module
+--------------
+
+A bare bones test module might look like this:
+
+.. code-block:: c
+
+   // SPDX-License-Identifier: GPL-2.0+
+
+   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+   #include "../tools/testing/selftests/kselftest_module.h"
+
+   KSTM_MODULE_GLOBALS();
+
+   /*
+    * Kernel module for testing the foobinator
+    */
+
+   static int __init test_function()
+   {
+           ...
+   }
+
+   static void __init selftest(void)
+   {
+           KSTM_CHECK_ZERO(do_test_case("", 0));
+   }
+
+   KSTM_MODULE_LOADERS(test_foo);
+   MODULE_AUTHOR("John Developer <jd@fooman.org>");
+   MODULE_LICENSE("GPL");
+
+Example test script
+-------------------
+
+.. code-block:: sh
+
+    #!/bin/bash
+    # SPDX-License-Identifier: GPL-2.0+
+    $(dirname $0)/../kselftest_module.sh "foo" test_foo
+
+
 Test Harness
 ============
 
-The kselftest_harness.h file contains useful helpers to build tests.  The tests
-from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as example.
+The kselftest_harness.h file contains useful helpers to build tests.  The
+test harness is for userspace testing, for kernel space testing see `Test
+Module`_ above.
+
+The tests from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as
+example.
 
 Example
 -------
diff --git a/include/linux/string.h b/include/linux/string.h
index 6ab0a6fa512e..4deb11f7976b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
+
+/* Wraps calls to strscpy()/memset(), no arch specific code required */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..4b644ad399dd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1769,6 +1769,9 @@ config TEST_HEXDUMP
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
 
+config TEST_STRSCPY
+	tristate "Test strscpy*() family of functions at runtime"
+
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 3b08673e8881..b4e08d6234ba 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
+obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
diff --git a/lib/string.c b/lib/string.c
index 3ab861c1a857..6016eb3ac73d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
  * @src: Where to copy the string from
  * @count: Size of destination buffer
  *
- * Copy the string, or as much of it as fits, into the dest buffer.
- * The routine returns the number of characters copied (not including
- * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
- * The behavior is undefined if the string buffers overlap.
- * The destination buffer is always NUL terminated, unless it's zero-sized.
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always NUL terminated, unless it's zero-sized.
  *
  * Preferred to strlcpy() since the API doesn't require reading memory
  * from the src string beyond the specified "count" bytes, and since
@@ -173,8 +171,10 @@ EXPORT_SYMBOL(strlcpy);
  *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
- * with an overflow test, then just memset() the tail of the dest buffer.
+ * zeroed.  If zeroing is desired please use strscpy_pad().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
@@ -237,6 +237,39 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strscpy);
 #endif
 
+/**
+ * strscpy_pad() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always %NUL terminated, unless it's zero-sized.
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * For full explanation of why you may want to consider using the
+ * 'strscpy' functions please see the function docstring for strscpy().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
+ */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	written = strscpy(dest, src, count);
+	if (written < 0 || written == count - 1)
+		return written;
+
+	memset(dest + written + 1, 0, count - written - 1);
+
+	return written;
+}
+EXPORT_SYMBOL(strscpy_pad);
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..792d90608052 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "../tools/testing/selftests/kselftest_module.h"
+
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
 
@@ -361,7 +363,7 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
-static int __init test_bitmap_init(void)
+static void __init selftest(void)
 {
 	test_zero_clear();
 	test_fill_set();
@@ -369,22 +371,8 @@ static int __init test_bitmap_init(void)
 	test_bitmap_arr32();
 	test_bitmap_parselist();
 	test_mem_optimisations();
-
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_warn("failed %u out of %u tests\n",
-			failed_tests, total_tests);
-
-	return failed_tests ? -EINVAL : 0;
 }
 
-static void __exit test_bitmap_cleanup(void)
-{
-}
-
-module_init(test_bitmap_init);
-module_exit(test_bitmap_cleanup);
-
+KSTM_MODULE_LOADERS(test_bitmap);
 MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 659b6cc0d483..f4fcc1c43739 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -21,6 +21,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#include "../tools/testing/selftests/kselftest_module.h"
+
 #define BUF_SIZE 256
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
@@ -590,12 +592,11 @@ test_pointer(void)
 	flags();
 }
 
-static int __init
-test_printf_init(void)
+static void __init selftest(void)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
-		return -ENOMEM;
+		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
 	test_basic();
@@ -604,16 +605,8 @@ test_printf_init(void)
 	test_pointer();
 
 	kfree(alloced_buffer);
-
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
-
-	return failed_tests ? -EINVAL : 0;
 }
 
-module_init(test_printf_init);
-
+KSTM_MODULE_LOADERS(test_printf);
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
new file mode 100644
index 000000000000..a827f94601f5
--- /dev/null
+++ b/lib/test_strscpy.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/string.h>
+
+#include "../tools/testing/selftests/kselftest_module.h"
+
+/*
+ * Kernel module for testing 'strscpy' family of functions.
+ */
+
+KSTM_MODULE_GLOBALS();
+
+/*
+ * tc() - Run a specific test case.
+ * @src: Source string, argument to strscpy_pad()
+ * @count: Size of destination buffer, argument to strscpy_pad()
+ * @expected: Expected return value from call to strscpy_pad()
+ * @terminator: 1 if there should be a terminating null byte 0 otherwise.
+ * @chars: Number of characters from the src string expected to be
+ *         written to the dst buffer.
+ * @pad: Number of pad characters expected (in the tail of dst buffer).
+ *       (@pad does not include the null terminator byte.)
+ *
+ * Calls strscpy_pad() and verifies the return value and state of the
+ * destination buffer after the call returns.
+ */
+static int __init tc(char *src, int count, int expected,
+		     int chars, int terminator, int pad)
+{
+	int nr_bytes_poison;
+	int max_expected;
+	int max_count;
+	int written;
+	char buf[6];
+	int index, i;
+	const char POISON = 'z';
+
+	total_tests++;
+
+	if (!src) {
+		pr_err("null source string not supported\n");
+		return -1;
+	}
+
+	memset(buf, POISON, sizeof(buf));
+	/* Future proofing test suite, validate args */
+	max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
+	max_expected = count - 1;    /* Space for the null */
+	if (count > max_count) {
+		pr_err("count (%d) is too big (%d) ... aborting", count, max_count);
+		return -1;
+	}
+	if (expected > max_expected) {
+		pr_warn("expected (%d) is bigger than can possibly be returned (%d)",
+			expected, max_expected);
+	}
+
+	written = strscpy_pad(buf, src, count);
+	if ((written) != (expected)) {
+		pr_err("%d != %d (written, expected)\n", written, expected);
+		goto fail;
+	}
+
+	if (count && written == -E2BIG) {
+		if (strncmp(buf, src, count - 1) != 0) {
+			pr_err("buffer state invalid for -E2BIG\n");
+			goto fail;
+		}
+		if (buf[count - 1] != '\0') {
+			pr_err("too big string is not null terminated correctly\n");
+			goto fail;
+		}
+	}
+
+	for (i = 0; i < chars; i++) {
+		if (buf[i] != src[i]) {
+			pr_err("buf[i]==%c != src[i]==%c\n", buf[i], src[i]);
+			goto fail;
+		}
+	}
+
+	if (terminator) {
+		if (buf[count - 1] != '\0') {
+			pr_err("string is not null terminated correctly\n");
+			goto fail;
+		}
+	}
+
+	for (i = 0; i < pad; i++) {
+		index = chars + terminator + i;
+		if (buf[index] != '\0') {
+			pr_err("padding missing at index: %d\n", i);
+			goto fail;
+		}
+	}
+
+	nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
+	for (i = 0; i < nr_bytes_poison; i++) {
+		index = sizeof(buf) - 1 - i; /* Check from the end back */
+		if (buf[index] != POISON) {
+			pr_err("poison value missing at index: %d\n", i);
+			goto fail;
+		}
+	}
+
+	return 0;
+fail:
+	failed_tests++;
+	return -1;
+}
+
+static void __init selftest(void)
+{
+	/*
+	 * tc() uses a destination buffer of size 6 and needs at
+	 * least 2 characters spare (one for null and one to check for
+	 * overflow).  This means we should only call tc() with
+	 * strings up to a maximum of 4 characters long and 'count'
+	 * should not exceed 4.  To test with longer strings increase
+	 * the buffer size in tc().
+	 */
+
+	/* tc(src, count, expected, chars, terminator, pad) */
+	KSTM_CHECK_ZERO(tc("a", 0, -E2BIG, 0, 0, 0));
+	KSTM_CHECK_ZERO(tc("", 0, -E2BIG, 0, 0, 0));
+
+	KSTM_CHECK_ZERO(tc("a", 1, -E2BIG, 0, 1, 0));
+	KSTM_CHECK_ZERO(tc("", 1, 0, 0, 1, 0));
+
+	KSTM_CHECK_ZERO(tc("ab", 2, -E2BIG, 1, 1, 0));
+	KSTM_CHECK_ZERO(tc("a", 2, 1, 1, 1, 0));
+	KSTM_CHECK_ZERO(tc("", 2, 0, 0, 1, 1));
+
+	KSTM_CHECK_ZERO(tc("abc", 3, -E2BIG, 2, 1, 0));
+	KSTM_CHECK_ZERO(tc("ab", 3, 2, 2, 1, 0));
+	KSTM_CHECK_ZERO(tc("a", 3, 1, 1, 1, 1));
+	KSTM_CHECK_ZERO(tc("", 3, 0, 0, 1, 2));
+
+	KSTM_CHECK_ZERO(tc("abcd", 4, -E2BIG, 3, 1, 0));
+	KSTM_CHECK_ZERO(tc("abc", 4, 3, 3, 1, 0));
+	KSTM_CHECK_ZERO(tc("ab", 4, 2, 2, 1, 1));
+	KSTM_CHECK_ZERO(tc("a", 4, 1, 1, 1, 2));
+	KSTM_CHECK_ZERO(tc("", 4, 0, 0, 1, 3));
+}
+
+KSTM_MODULE_LOADERS(test_strscpy);
+MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..f2ebf8cf4686 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,11 +15,11 @@ TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
-TARGETS += ima
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
+TARGETS += kexec
 TARGETS += kvm
 TARGETS += lib
 TARGETS += livepatch
@@ -75,12 +75,15 @@ ifneq ($(KBUILD_SRC),)
 override LDFLAGS =
 endif
 
-BUILD := $(O)
-ifndef BUILD
-  BUILD := $(KBUILD_OUTPUT)
-endif
-ifndef BUILD
-  BUILD := $(shell pwd)
+ifneq ($(O),)
+	BUILD := $(O)
+else
+	ifneq ($(KBUILD_OUTPUT),)
+		BUILD := $(KBUILD_OUTPUT)
+	else
+		BUILD := $(shell pwd)
+		DEFAULT_INSTALL_HDR_PATH := 1
+	endif
 endif
 
 # KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
@@ -89,8 +92,50 @@ endif
 # with system() call. Export it here to cover override RUN_TESTS defines.
 export KSFT_TAP_LEVEL=`echo 1`
 
+# Prepare for headers install
+top_srcdir ?= ../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH           ?= $(SUBARCH)
+export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
-all:
+
+# build and run gpio when output directory is the src dir.
+# gpio has dependency on tools/gpio and builds tools/gpio
+# objects in the src directory in all cases making the src
+# repo dirty even when objects are relocated.
+ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	TMP := $(filter-out gpio, $(TARGETS))
+	TARGETS := $(TMP)
+endif
+
+# set default goal to all, so make without a target runs all, even when
+# all isn't the first target in the file.
+.DEFAULT_GOAL := all
+
+# Install headers here once for all tests. KSFT_KHDR_INSTALL_DONE
+# is used to avoid running headers_install from lib.mk.
+# Invoke headers install with --no-builtin-rules to avoid circular
+# dependency in "make kselftest" case. In this case, second level
+# make inherits builtin-rules which will use the rule generate
+# Makefile.o and runs into
+# "Circular Makefile.o <- prepare dependency dropped."
+# and headers_install fails and test compile fails.
+#
+# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
+# invokes them as sub-makes and --no-builtin-rules is not necessary,
+# but doesn't cause any failures. Keep it simple and use the same
+# flags in both cases.
+# Local build cases: "make kselftest", "make -C" - headers are installed
+# in the default INSTALL_HDR_PATH usr/include.
+khdr:
+ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+else
+	make --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+		ARCH=$(ARCH) -C $(top_srcdir) headers_install
+endif
+
+all: khdr
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
@@ -173,4 +218,4 @@ clean:
 		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
+.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 28d321ba311b..6f339882a6ca 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -26,7 +26,7 @@
  */
 static int test_memcg_subtree_control(const char *root)
 {
-	char *parent, *child, *parent2, *child2;
+	char *parent, *child, *parent2 = NULL, *child2 = NULL;
 	int ret = KSFT_FAIL;
 	char buf[PAGE_SIZE];
 
@@ -34,50 +34,54 @@ static int test_memcg_subtree_control(const char *root)
 	parent = cg_name(root, "memcg_test_0");
 	child = cg_name(root, "memcg_test_0/memcg_test_1");
 	if (!parent || !child)
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_create(parent))
-		goto cleanup;
+		goto cleanup_free;
 
 	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_create(child))
-		goto cleanup;
+		goto cleanup_parent;
 
 	if (cg_read_strstr(child, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_child;
 
 	/* Create two nested cgroups without enabling memory controller */
 	parent2 = cg_name(root, "memcg_test_1");
 	child2 = cg_name(root, "memcg_test_1/memcg_test_1");
 	if (!parent2 || !child2)
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(parent2))
-		goto cleanup;
+		goto cleanup_free2;
 
 	if (cg_create(child2))
-		goto cleanup;
+		goto cleanup_parent2;
 
 	if (cg_read(child2, "cgroup.controllers", buf, sizeof(buf)))
-		goto cleanup;
+		goto cleanup_all;
 
 	if (!cg_read_strstr(child2, "cgroup.controllers", "memory"))
-		goto cleanup;
+		goto cleanup_all;
 
 	ret = KSFT_PASS;
 
-cleanup:
-	cg_destroy(child);
-	cg_destroy(parent);
-	free(parent);
-	free(child);
-
+cleanup_all:
 	cg_destroy(child2);
+cleanup_parent2:
 	cg_destroy(parent2);
+cleanup_free2:
 	free(parent2);
 	free(child2);
+cleanup_child:
+	cg_destroy(child);
+cleanup_parent:
+	cg_destroy(parent);
+cleanup_free:
+	free(parent);
+	free(child);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index a47029a799d2..a90f394f9aa9 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -7,6 +7,12 @@ test_guid=210be57c-9849-4fc7-a635-e6382d1aec27
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+file_cleanup()
+{
+	chattr -i $1
+	rm -f $1
+}
+
 check_prereqs()
 {
 	local msg="skip all tests:"
@@ -58,8 +64,10 @@ test_create()
 
 	if [ $(stat -c %s $file) -ne 5 ]; then
 		echo "$file has invalid size" >&2
+		file_cleanup $file
 		exit 1
 	fi
+	file_cleanup $file
 }
 
 test_create_empty()
@@ -72,12 +80,14 @@ test_create_empty()
 		echo "$file can not be created without writing" >&2
 		exit 1
 	fi
+	file_cleanup $file
 }
 
 test_create_read()
 {
 	local file=$efivarfs_mount/$FUNCNAME-$test_guid
 	./create-read $file
+	file_cleanup $file
 }
 
 test_delete()
@@ -92,11 +102,7 @@ test_delete()
 		exit 1
 	fi
 
-	rm $file 2>/dev/null
-	if [ $? -ne 0 ]; then
-		chattr -i $file
-		rm $file
-	fi
+	file_cleanup $file
 
 	if [ -e $file ]; then
 		echo "$file couldn't be deleted" >&2
@@ -150,11 +156,7 @@ test_valid_filenames()
 			echo "$file could not be created" >&2
 			ret=1
 		else
-			rm $file 2>/dev/null
-			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
-			fi
+			file_cleanup $file
 		fi
 	done
 
@@ -187,11 +189,7 @@ test_invalid_filenames()
 
 		if [ -e $file ]; then
 			echo "Creating $file should have failed" >&2
-			rm $file 2>/dev/null
-			if [ $? -ne 0 ]; then
-				chattr -i $file
-				rm $file
-			fi
+			file_cleanup $file
 			ret=1
 		fi
 	done
diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index aaa1e9f083c3..d587c814a9ca 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
deleted file mode 100644
index 6bc86d4d9bb4..000000000000
--- a/tools/testing/selftests/ima/config
+++ /dev/null
@@ -1,4 +0,0 @@
-CONFIG_IMA_APPRAISE
-CONFIG_IMA_ARCH_POLICY
-CONFIG_SECURITYFS
-CONFIG_KEXEC_VERIFY_SIG
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
deleted file mode 100755
index 1c10093fb526..000000000000
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-# Loading a kernel image via the kexec_load syscall should fail
-# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
-# is booted in secureboot mode.
-
-TEST="$0"
-EFIVARFS="/sys/firmware/efi/efivars"
-rc=0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# kexec requires root privileges
-if [ $UID != 0 ]; then
-	echo "$TEST: must be run as root" >&2
-	exit $ksft_skip
-fi
-
-# Make sure that efivars is mounted in the normal location
-if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
-	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
-	exit $ksft_skip
-fi
-
-# Get secureboot mode
-file="$EFIVARFS/SecureBoot-*"
-if [ ! -e $file ]; then
-	echo "$TEST: unknown secureboot mode" >&2
-	exit $ksft_skip
-fi
-secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
-
-# kexec_load should fail in secure boot mode
-KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
-kexec -l $KERNEL_IMAGE &>> /dev/null
-if [ $? == 0 ]; then
-	kexec -u
-	if [ "$secureboot" == "1" ]; then
-		echo "$TEST: kexec_load succeeded [FAIL]"
-		rc=1
-	else
-		echo "$TEST: kexec_load succeeded [PASS]"
-	fi
-else
-	if [ "$secureboot" == "1" ]; then
-		echo "$TEST: kexec_load failed [PASS]"
-	else
-		echo "$TEST: kexec_load failed [FAIL]"
-		rc=1
-	fi
-fi
-
-exit $rc
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index dac927e82336..4c156aeab6b8 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/msg.h>
+#include <sys/msg.h>
 #include <fcntl.h>
 
 #include "../kselftest.h"
@@ -73,7 +74,7 @@ int restore_queue(struct msgque_data *msgque)
 	return 0;
 
 destroy:
-	if (msgctl(id, IPC_RMID, 0))
+	if (msgctl(id, IPC_RMID, NULL))
 		printf("Failed to destroy queue: %d\n", -errno);
 	return ret;
 }
@@ -120,7 +121,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 
 	ret = 0;
 err:
-	if (msgctl(msgque->msq_id, IPC_RMID, 0)) {
+	if (msgctl(msgque->msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
 		return -errno;
 	}
@@ -129,7 +130,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 
 int dump_queue(struct msgque_data *msgque)
 {
-	struct msqid64_ds ds;
+	struct msqid_ds ds;
 	int kern_id;
 	int i, ret;
 
@@ -245,7 +246,7 @@ int main(int argc, char **argv)
 	return ksft_exit_pass();
 
 err_destroy:
-	if (msgctl(msgque.msq_id, IPC_RMID, 0)) {
+	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
 		return ksft_exit_fail();
 	}
diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/kexec/Makefile
similarity index 59%
rename from tools/testing/selftests/ima/Makefile
rename to tools/testing/selftests/kexec/Makefile
index 0b3adf5444b6..8e9b27a7452f 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -1,10 +1,11 @@
-# Makefile for kexec_load
+# Makefile for kexec tests
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
+TEST_FILES := kexec_common_lib.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/kexec/config b/tools/testing/selftests/kexec/config
new file mode 100644
index 000000000000..8962e862b2b8
--- /dev/null
+++ b/tools/testing/selftests/kexec/config
@@ -0,0 +1,3 @@
+CONFIG_IMA_APPRAISE=y
+CONFIG_IMA_ARCH_POLICY=y
+CONFIG_SECURITYFS=y
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
new file mode 100755
index 000000000000..43017cfe88f7
--- /dev/null
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -0,0 +1,220 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
+
+VERBOSE="${VERBOSE:-1}"
+IKCONFIG="/tmp/config-`uname -r`"
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
+
+log_info()
+{
+	[ $VERBOSE -ne 0 ] && echo "[INFO] $1"
+}
+
+# The ksefltest framework requirement returns 0 for PASS.
+log_pass()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
+	exit 0
+}
+
+# The ksefltest framework requirement returns 1 for FAIL.
+log_fail()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
+	exit 1
+}
+
+# The ksefltest framework requirement returns 4 for SKIP.
+log_skip()
+{
+	[ $VERBOSE -ne 0 ] && echo "$1"
+	exit 4
+}
+
+# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
+# (Based on kdump-lib.sh)
+get_efivarfs_secureboot_mode()
+{
+	local efivarfs="/sys/firmware/efi/efivars"
+	local secure_boot_file=""
+	local setup_mode_file=""
+	local secureboot_mode=0
+	local setup_mode=0
+
+	# Make sure that efivar_fs is mounted in the normal location
+	if ! grep -q "^\S\+ $efivarfs efivarfs" /proc/mounts; then
+		log_info "efivars is not mounted on $efivarfs"
+		return 0;
+	fi
+	secure_boot_file=$(find "$efivarfs" -name SecureBoot-* 2>/dev/null)
+	setup_mode_file=$(find "$efivarfs" -name SetupMode-* 2>/dev/null)
+	if [ -f "$secure_boot_file" ] && [ -f "$setup_mode_file" ]; then
+		secureboot_mode=$(hexdump -v -e '/1 "%d\ "' \
+			"$secure_boot_file"|cut -d' ' -f 5)
+		setup_mode=$(hexdump -v -e '/1 "%d\ "' \
+			"$setup_mode_file"|cut -d' ' -f 5)
+
+		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+			log_info "secure boot mode enabled (CONFIG_EFIVAR_FS)"
+			return 1;
+		fi
+	fi
+	return 0;
+}
+
+get_efi_var_secureboot_mode()
+{
+	local efi_vars
+	local secure_boot_file
+	local setup_mode_file
+	local secureboot_mode
+	local setup_mode
+
+	if [ ! -d "$efi_vars" ]; then
+		log_skip "efi_vars is not enabled\n"
+	fi
+	secure_boot_file=$(find "$efi_vars" -name SecureBoot-* 2>/dev/null)
+	setup_mode_file=$(find "$efi_vars" -name SetupMode-* 2>/dev/null)
+	if [ -f "$secure_boot_file/data" ] && \
+	   [ -f "$setup_mode_file/data" ]; then
+		secureboot_mode=`od -An -t u1 "$secure_boot_file/data"`
+		setup_mode=`od -An -t u1 "$setup_mode_file/data"`
+
+		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
+			log_info "secure boot mode enabled (CONFIG_EFI_VARS)"
+			return 1;
+		fi
+	fi
+	return 0;
+}
+
+# Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
+# The secure boot mode can be accessed either as the last integer
+# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
+# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
+# SetupMode can be similarly accessed.
+# Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
+get_secureboot_mode()
+{
+	local secureboot_mode=0
+
+	get_efivarfs_secureboot_mode
+	secureboot_mode=$?
+
+	# fallback to using the efi_var files
+	if [ $secureboot_mode -eq 0 ]; then
+		get_efi_var_secureboot_mode
+		secureboot_mode=$?
+	fi
+
+	if [ $secureboot_mode -eq 0 ]; then
+		log_info "secure boot mode not enabled"
+	fi
+	return $secureboot_mode;
+}
+
+require_root_privileges()
+{
+	if [ $(id -ru) -ne 0 ]; then
+		log_skip "requires root privileges"
+	fi
+}
+
+# Look for config option in Kconfig file.
+# Return 1 for found and 0 for not found.
+kconfig_enabled()
+{
+	local config="$1"
+	local msg="$2"
+
+	grep -E -q $config $IKCONFIG
+	if [ $? -eq 0 ]; then
+		log_info "$msg"
+		return 1
+	fi
+	return 0
+}
+
+# Attempt to get the kernel config first via proc, and then by
+# extracting it from the kernel image or the configs.ko using
+# scripts/extract-ikconfig.
+# Return 1 for found.
+get_kconfig()
+{
+	local proc_config="/proc/config.gz"
+	local module_dir="/lib/modules/`uname -r`"
+	local configs_module="$module_dir/kernel/kernel/configs.ko"
+
+	if [ ! -f $proc_config ]; then
+		modprobe configs > /dev/null 2>&1
+	fi
+	if [ -f $proc_config ]; then
+		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
+		if [ $? -eq 0 ]; then
+			return 1
+		fi
+	fi
+
+	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
+	if [ ! -f $extract_ikconfig ]; then
+		log_skip "extract-ikconfig not found"
+	fi
+
+	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
+	if [ $? -eq 1 ]; then
+		if [ ! -f $configs_module ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+		$extract_ikconfig $configs_module > $IKCONFIG
+		if [ $? -eq 1 ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+	fi
+	return 1
+}
+
+# Make sure that securityfs is mounted
+mount_securityfs()
+{
+	if [ -z $SECURITYFS ]; then
+		SECURITYFS=/sys/kernel/security
+		mount -t securityfs security $SECURITYFS
+	fi
+
+	if [ ! -d "$SECURITYFS" ]; then
+		log_fail "$SECURITYFS :securityfs is not mounted"
+	fi
+}
+
+# The policy rule format is an "action" followed by key-value pairs.  This
+# function supports up to two key-value pairs, in any order.
+# For example: action func=<keyword> [appraise_type=<type>]
+# Return 1 for found and 0 for not found.
+check_ima_policy()
+{
+	local action="$1"
+	local keypair1="$2"
+	local keypair2="$3"
+	local ret=0
+
+	mount_securityfs
+
+	local ima_policy=$SECURITYFS/ima/policy
+	if [ ! -e $ima_policy ]; then
+		log_fail "$ima_policy not found"
+	fi
+
+	if [ -n $keypair2 ]; then
+		grep -e "^$action.*$keypair1" "$ima_policy" | \
+			grep -q -e "$keypair2"
+	else
+		grep -q -e "^$action.*$keypair1" "$ima_policy"
+	fi
+
+	# invert "grep -q" result, returning 1 for found.
+	[ $? -eq 0 ] && ret=1
+	return $ret
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
new file mode 100755
index 000000000000..fa7c24e8eefb
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -0,0 +1,208 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Loading a kernel image via the kexec_file_load syscall can verify either
+# the IMA signature stored in the security.ima xattr or the PE signature,
+# both signatures depending on the IMA policy, or none.
+#
+# To determine whether the kernel image is signed, this test depends
+# on pesign and getfattr.  This test also requires the kernel to be
+# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
+# enabled or access to the extract-ikconfig script.
+
+TEST="KEXEC_FILE_LOAD"
+. ./kexec_common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kexec kernel image to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
+		"IMA kernel image signature required"
+	if [ $? -eq 1 ]; then
+		log_info "IMA signature required"
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kexec kernel image be signed.  Policy rules are walked
+	# sequentially.  As a result, a policy rule may be defined, but
+	# might not necessarily be used.  This test assumes if a policy
+	# rule is specified, that is the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require pesign.
+# Return 1 for PE signature found and 0 for not found.
+check_for_pesig()
+{
+	which pesign > /dev/null 2>&1 || log_skip "pesign not found"
+
+	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
+	local ret=$?
+	if [ $ret -eq 1 ]; then
+		log_info "kexec kernel image PE signed"
+	else
+		log_info "kexec kernel image not PE signed"
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require getfattr.
+# Return 1 for IMA signature found and 0 for not found.
+check_for_imasig()
+{
+	local ret=0
+
+	which getfattr > /dev/null 2>&1
+	if [ $?	-eq 1 ]; then
+		log_skip "getfattr not found"
+	fi
+
+	line=$(getfattr -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
+	echo $line | grep -q "security.ima=0x03"
+	if [ $? -eq 0 ]; then
+		ret=1
+		log_info "kexec kernel image IMA signed"
+	else
+		log_info "kexec kernel image not IMA signed"
+	fi
+	return $ret
+}
+
+kexec_file_load_test()
+{
+	local succeed_msg="kexec_file_load succeeded"
+	local failed_msg="kexec_file_load failed"
+	local key_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+
+		# In secureboot mode with an architecture  specific
+		# policy, make sure either an IMA or PE signature exists.
+		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
+			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing sig)"
+		fi
+
+		if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 0 ]; then
+			log_fail "$succeed_msg (possibly missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 0 ]; then
+			log_info "No signature verification required"
+		elif [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
+	            && [ $ima_read_policy -eq 1 ]; then
+			log_info "No signature verification required"
+		fi
+
+		log_pass "$succeed_msg"
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	echo $line | grep -q "Required key not available"
+	if [ $? -eq 0 ]; then
+		if [ $platform_keyring -eq 0 ]; then
+			log_pass "$failed_msg (-ENOKEY), $key_msg"
+		else
+			log_pass "$failed_msg (-ENOKEY)"
+		fi
+	fi
+
+	if [ $kexec_sig_required -eq 1 -o $pe_sig_required -eq 1 ] \
+	     && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
+	if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
+	    && [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 0 ] \
+	    && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (possibly missing IMA sig)"
+	fi
+
+	log_pass "$failed_msg"
+	return 0
+}
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC_FILE=y" "kexec_file_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_file_load is not enabled"
+fi
+
+# Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"architecture specific policy enabled"
+arch_policy=$?
+
+kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y" \
+	"platform keyring enabled"
+platform_keyring=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
+	"kexec signed kernel image required"
+kexec_sig_required=$?
+
+kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
+	"PE signed kernel image required"
+pe_sig_required=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+get_secureboot_mode
+secureboot=$?
+
+# Are there pe and ima signatures
+check_for_pesig
+pe_signed=$?
+
+check_for_imasig
+ima_signed=$?
+
+# Test loading the kernel image via kexec_file_load syscall
+kexec_file_load_test
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
new file mode 100755
index 000000000000..49c6aa929137
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
+
+TEST="$0"
+. ./kexec_common_lib.sh
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC=y" "kexec_load is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_load is not enabled"
+fi
+
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
+get_secureboot_mode
+secureboot=$?
+
+# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
+kexec --load $KERNEL_IMAGE > /dev/null 2>&1
+if [ $? -eq 0 ]; then
+	kexec --unload
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+		log_fail "kexec_load succeeded"
+	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
+		log_info "Either IMA or the IMA arch policy is not enabled"
+	fi
+	log_pass "kexec_load succeeded"
+else
+	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
+		log_pass "kexec_load failed"
+	else
+		log_fail "kexec_load failed"
+	fi
+fi
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2d90c98eeb67..941d9391377f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -696,6 +696,7 @@ void __run_test(struct __test_metadata *t)
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
+	alarm(30);
 	child_pid = fork();
 	if (child_pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
@@ -744,6 +745,7 @@ void __run_test(struct __test_metadata *t)
 		}
 	}
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
+	alarm(0);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
new file mode 100644
index 000000000000..e8eafaf0941a
--- /dev/null
+++ b/tools/testing/selftests/kselftest_module.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __KSELFTEST_MODULE_H
+#define __KSELFTEST_MODULE_H
+
+#include <linux/module.h>
+
+/*
+ * Test framework for writing test modules to be loaded by kselftest.
+ * See Documentation/dev-tools/kselftest.rst for an example test module.
+ */
+
+#define KSTM_MODULE_GLOBALS()			\
+static unsigned int total_tests __initdata;	\
+static unsigned int failed_tests __initdata
+
+#define KSTM_CHECK_ZERO(x) do {						\
+	total_tests++;							\
+	if (x) {							\
+		pr_warn("TC failed at %s:%d\n", __func__, __LINE__);	\
+		failed_tests++;						\
+	}								\
+} while (0)
+
+static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
+{
+	if (failed_tests == 0)
+		pr_info("all %u tests passed\n", total_tests);
+	else
+		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
+
+	return failed_tests ? -EINVAL : 0;
+}
+
+#define KSTM_MODULE_LOADERS(__module)			\
+static int __init __module##_init(void)			\
+{							\
+	pr_info("loaded.\n");				\
+	selftest();					\
+	return kstm_report(total_tests, failed_tests);	\
+}							\
+static void __exit __module##_exit(void)		\
+{							\
+	pr_info("unloaded.\n");				\
+}							\
+module_init(__module##_init);				\
+module_exit(__module##_exit)
+
+#endif	/* __KSELFTEST_MODULE_H */
diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
new file mode 100755
index 000000000000..18e1c7992d30
--- /dev/null
+++ b/tools/testing/selftests/kselftest_module.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+#
+# Runs an individual test module.
+#
+# kselftest expects a separate executable for each test, this can be
+# created by adding a script like this:
+#
+#   #!/bin/sh
+#   SPDX-License-Identifier: GPL-2.0+
+#   $(dirname $0)/../kselftest_module.sh "description" module_name
+#
+# Example: tools/testing/selftests/lib/printf.sh
+
+desc=""				# Output prefix.
+module=""			# Filename (without the .ko).
+args=""				# modprobe arguments.
+
+modprobe="/sbin/modprobe"
+
+main() {
+    parse_args "$@"
+    assert_root
+    assert_have_module
+    run_module
+}
+
+parse_args() {
+    script=${0##*/}
+
+    if [ $# -lt 2 ]; then
+	echo "Usage: $script <description> <module_name> [FAIL]"
+	exit 1
+    fi
+
+    desc="$1"
+    shift || true
+    module="$1"
+    shift || true
+    args="$@"
+}
+
+assert_root() {
+    if [ ! -w /dev ]; then
+	skip "please run as root"
+    fi
+}
+
+assert_have_module() {
+    if ! $modprobe -q -n $module; then
+	skip "module $module is not found"
+    fi
+}
+
+run_module() {
+    if $modprobe -q $module $args; then
+	$modprobe -q -r $module
+	say "ok"
+    else
+	fail ""
+    fi
+}
+
+say() {
+    echo "$desc: $1"
+}
+
+
+fail() {
+    say "$1 [FAIL]" >&2
+    exit 1
+}
+
+skip() {
+    say "$1 [SKIP]" >&2
+    # Kselftest framework requirement - SKIP code is 4.
+    exit 4
+}
+
+#
+# Main script
+#
+main "$@"
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 8b0f16409ed7..5979fdc4f36c 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,7 +3,16 @@
 CC := $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
-OUTPUT := $(shell pwd)
+    ifneq ($(O),)
+	OUTPUT := $(O)
+    else
+	ifneq ($(KBUILD_OUTPUT),)
+		OUTPUT := $(KBUILD_OUTPUT)
+	else
+		OUTPUT := $(shell pwd)
+		DEFAULT_INSTALL_HDR_PATH := 1
+	endif
+    endif
 endif
 
 # The following are built by lib.mk common compile rules.
@@ -21,9 +30,34 @@ top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
+# set default goal to all, so make without a target runs all, even when
+# all isn't the first target in the file.
+.DEFAULT_GOAL := all
+
+# Invoke headers install with --no-builtin-rules to avoid circular
+# dependency in "make kselftest" case. In this case, second level
+# make inherits builtin-rules which will use the rule generate
+# Makefile.o and runs into
+# "Circular Makefile.o <- prepare dependency dropped."
+# and headers_install fails and test compile fails.
+# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
+# invokes them as sub-makes and --no-builtin-rules is not necessary,
+# but doesn't cause any failures. Keep it simple and use the same
+# flags in both cases.
+# Note that the support to install headers from lib.mk is necessary
+# when test Makefile is run directly with "make -C".
+# When local build is done, headers are installed in the default
+# INSTALL_HDR_PATH usr/include.
 .PHONY: khdr
 khdr:
-	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+ifndef KSFT_KHDR_INSTALL_DONE
+ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+else
+	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
+		ARCH=$(ARCH) -C $(top_srcdir) headers_install
+endif
+endif
 
 all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 else
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index 70d5711e3ac8..9f26635f3e57 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -3,6 +3,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index 5a90006d1aea..5511dddc5c2d 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,19 +1,3 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# Runs bitmap infrastructure tests using test_bitmap kernel module
-if ! /sbin/modprobe -q -n test_bitmap; then
-	echo "bitmap: module test_bitmap is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q test_bitmap; then
-	/sbin/modprobe -q -r test_bitmap
-	echo "bitmap: ok"
-else
-	echo "bitmap: [FAIL]"
-	exit 1
-fi
+$(dirname $0)/../kselftest_module.sh "bitmap" test_bitmap
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 126933bcc950..14a77ea4a8da 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,3 +1,4 @@
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
+CONFIG_TEST_STRSCPY=m
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 78e7483c8d60..43b28f24e453 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -1,19 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if ! /sbin/modprobe -q -n prime_numbers; then
-	echo "prime_numbers: module prime_numbers is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q prime_numbers selftest=65536; then
-	/sbin/modprobe -q -r prime_numbers
-	echo "prime_numbers: ok"
-else
-	echo "prime_numbers: [FAIL]"
-	exit 1
-fi
+$(dirname $0)/../kselftest_module.sh "prime numbers" prime_numbers selftest=65536
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 45a23e2d64ad..2ffa61da0296 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,19 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Runs printf infrastructure using test_printf kernel module
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if ! /sbin/modprobe -q -n test_printf; then
-	echo "printf: module test_printf is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q test_printf; then
-	/sbin/modprobe -q -r test_printf
-	echo "printf: ok"
-else
-	echo "printf: [FAIL]"
-	exit 1
-fi
+# Tests the printf infrastructure using test_printf kernel module.
+$(dirname $0)/../kselftest_module.sh "printf" test_printf
diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
new file mode 100755
index 000000000000..71f2be6afba6
--- /dev/null
+++ b/tools/testing/selftests/lib/strscpy.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+$(dirname $0)/../kselftest_module.sh "strscpy*" test_strscpy
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70f9b52..6c1126e7f685 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <linux/rseq.h>
 
 /*
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index 3acd6d75ff9f..e426304fd4a0 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+ or MIT
 
+NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
+
 EXTRA_ARGS=${@}
 
 OLDIFS="$IFS"
@@ -28,15 +30,16 @@ IFS="$OLDIFS"
 
 REPS=1000
 SLOW_REPS=100
+NR_THREADS=$((6*${NR_CPUS}))
 
 function do_tests()
 {
 	local i=0
 	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
 		echo "Running test ${TEST_NAME[$i]}"
-		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		echo "Running compare-twice test ${TEST_NAME[$i]}"
-		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
 		let "i++"
 	done
 }
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f69d2ee29742..3a280b7efc87 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3079,9 +3079,9 @@ TEST(user_notification_basic)
 
 	/* Check that we get -ENOSYS with no listener attached */
 	if (pid == 0) {
-		if (user_trap_syscall(__NR_getpid, 0) < 0)
+		if (user_trap_syscall(__NR_getppid, 0) < 0)
 			exit(1);
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret >= 0 || errno != ENOSYS);
 	}
 
@@ -3096,12 +3096,12 @@ TEST(user_notification_basic)
 	EXPECT_EQ(seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog), 0);
 
 	/* Check that the basic notification machinery works */
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	/* Installing a second listener in the chain should EBUSY */
-	EXPECT_EQ(user_trap_syscall(__NR_getpid,
+	EXPECT_EQ(user_trap_syscall(__NR_getppid,
 				    SECCOMP_FILTER_FLAG_NEW_LISTENER),
 		  -1);
 	EXPECT_EQ(errno, EBUSY);
@@ -3110,7 +3110,7 @@ TEST(user_notification_basic)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != USER_NOTIF_MAGIC);
 	}
 
@@ -3128,7 +3128,7 @@ TEST(user_notification_basic)
 	EXPECT_GT(poll(&pollfd, 1, -1), 0);
 	EXPECT_EQ(pollfd.revents, POLLOUT);
 
-	EXPECT_EQ(req.data.nr,  __NR_getpid);
+	EXPECT_EQ(req.data.nr,  __NR_getppid);
 
 	resp.id = req.id;
 	resp.error = 0;
@@ -3160,7 +3160,7 @@ TEST(user_notification_kill_in_middle)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
@@ -3172,7 +3172,7 @@ TEST(user_notification_kill_in_middle)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != USER_NOTIF_MAGIC);
 	}
 
@@ -3282,7 +3282,7 @@ TEST(user_notification_closed_listener)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid,
+	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
@@ -3293,7 +3293,7 @@ TEST(user_notification_closed_listener)
 	ASSERT_GE(pid, 0);
 	if (pid == 0) {
 		close(listener);
-		ret = syscall(__NR_getpid);
+		ret = syscall(__NR_getppid);
 		exit(ret != -1 && errno != ENOSYS);
 	}
 
@@ -3316,14 +3316,15 @@ TEST(user_notification_child_pid_ns)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
-		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	EXPECT_EQ(req.pid, pid);
@@ -3355,7 +3356,8 @@ TEST(user_notification_sibling_pid_ns)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
@@ -3368,7 +3370,7 @@ TEST(user_notification_sibling_pid_ns)
 		ASSERT_GE(pid2, 0);
 
 		if (pid2 == 0)
-			exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+			exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 		EXPECT_EQ(waitpid(pid2, &status, 0), pid2);
 		EXPECT_EQ(true, WIFEXITED(status));
@@ -3377,11 +3379,11 @@ TEST(user_notification_sibling_pid_ns)
 	}
 
 	/* Create the sibling ns, and sibling in it. */
-	EXPECT_EQ(unshare(CLONE_NEWPID), 0);
-	EXPECT_EQ(errno, 0);
+	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(errno, 0);
 
 	pid2 = fork();
-	EXPECT_GE(pid2, 0);
+	ASSERT_GE(pid2, 0);
 
 	if (pid2 == 0) {
 		ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
@@ -3389,7 +3391,7 @@ TEST(user_notification_sibling_pid_ns)
 		 * The pid should be 0, i.e. the task is in some namespace that
 		 * we can't "see".
 		 */
-		ASSERT_EQ(req.pid, 0);
+		EXPECT_EQ(req.pid, 0);
 
 		resp.id = req.id;
 		resp.error = 0;
@@ -3419,14 +3421,15 @@ TEST(user_notification_fault_recv)
 
 	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
 
-	listener = user_trap_syscall(__NR_getpid, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
-		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
 	/* Do a bad recv() */
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, NULL), -1);
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711c78ee..8066be9aff11 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607ef5c11..880fbf676968 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>

--------------63B04A47C23346E373CCE94E--
