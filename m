Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48B27DA07
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 23:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgI2V17 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 17:27:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10948 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgI2V1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 17:27:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a6700003>; Tue, 29 Sep 2020 14:26:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:27:49 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 29 Sep 2020 21:27:49 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/8] mm/gup_benchmark: rename to mm/gup_test
Date:   Tue, 29 Sep 2020 14:27:40 -0700
Message-ID: <20200929212747.251804-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929212747.251804-1-jhubbard@nvidia.com>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601414768; bh=zgoagjbUSVPCp8NwtjW3RngCncIQqgtt1oRw0Ap67nA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Fj4G6g/VZXf1ELuaXoxMUg9wh7tXJp6gE5e4B/atIpgSM36/KC8tbd7eRnhQtOifr
         Kz24P1WcbuX5c6a0BUXbkp0laJ52Wd9oRD56DYh+xzpXnH9BNZnzwpEmmgZaoI6n/a
         HVdN0W5RqWs1HnjVUouZs2pejfIPT6fqkoJLLPL6ApVaOxE6k8Rk4z0QOCy4PxggnS
         A5UDPqir3+93CxCkTqV/Nyl9vJE8K5k8wbfiA0wMPz7/GCwXeGmxDAjTAqcvCyGnKS
         S9I19VZOUkm14dnw+ci2WZKVgnF+OYkcuClk2DFNovf5qDT6NellJJL1H+iief9loJ
         aMo8ogi9DTq9Q==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename nearly every "gup_benchmark" reference and file name to
"gup_test". The one exception is for the actual gup benchmark test
itself.

The current code already does a *little* bit more than benchmarking,
and definitely covers more than get_user_pages_fast(). More importantly,
however, subsequent patches are about to add some functionality that is
non-benchmark related.

Closely related changes:

* Kconfig: in addition to renaming the options from GUP_BENCHMARK to
  GUP_TEST, update the help text to reflect that it's no longer a
  benchmark-only test.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst     |  6 ++--
 arch/s390/configs/debug_defconfig             |  2 +-
 arch/s390/configs/defconfig                   |  2 +-
 mm/Kconfig                                    | 15 +++++---
 mm/Makefile                                   |  2 +-
 mm/{gup_benchmark.c =3D> gup_test.c}            | 36 +++++++++----------
 tools/testing/selftests/vm/.gitignore         |  2 +-
 tools/testing/selftests/vm/Makefile           |  2 +-
 tools/testing/selftests/vm/config             |  2 +-
 .../vm/{gup_benchmark.c =3D> gup_test.c}        | 16 ++++-----
 tools/testing/selftests/vm/run_vmtests        |  8 ++---
 11 files changed, 49 insertions(+), 44 deletions(-)
 rename mm/{gup_benchmark.c =3D> gup_test.c} (80%)
 rename tools/testing/selftests/vm/{gup_benchmark.c =3D> gup_test.c} (85%)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 7ca8c7bac650..eae972b23224 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -221,12 +221,12 @@ Unit testing
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 This file::
=20
- tools/testing/selftests/vm/gup_benchmark.c
+ tools/testing/selftests/vm/gup_test.c
=20
 has the following new calls to exercise the new pin*() wrapper functions:
=20
-* PIN_FAST_BENCHMARK (./gup_benchmark -a)
-* PIN_BENCHMARK (./gup_benchmark -b)
+* PIN_FAST_BENCHMARK (./gup_test -a)
+* PIN_BENCHMARK (./gup_test -b)
=20
 You can monitor how many total dma-pinned pages have been acquired and rel=
eased
 since the system was booted, via two new /proc/vmstat entries: ::
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_de=
fconfig
index 0784bf3caf43..c624f4b1ad33 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -100,7 +100,7 @@ CONFIG_ZSMALLOC_STAT=3Dy
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
 CONFIG_IDLE_PAGE_TRACKING=3Dy
 CONFIG_PERCPU_STATS=3Dy
-CONFIG_GUP_BENCHMARK=3Dy
+CONFIG_GUP_TEST=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_PACKET_DIAG=3Dm
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 905bc8c4cfaf..878b89706998 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,7 @@ CONFIG_ZSMALLOC_STAT=3Dy
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
 CONFIG_IDLE_PAGE_TRACKING=3Dy
 CONFIG_PERCPU_STATS=3Dy
-CONFIG_GUP_BENCHMARK=3Dy
+CONFIG_GUP_TEST=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_PACKET_DIAG=3Dm
diff --git a/mm/Kconfig b/mm/Kconfig
index 1896860cf23a..588984ee5fb4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -834,13 +834,18 @@ config PERCPU_STATS
 	  information includes global and per chunk statistics, which can
 	  be used to help understand percpu memory usage.
=20
-config GUP_BENCHMARK
-	bool "Enable infrastructure for get_user_pages() and related calls benchm=
arking"
+config GUP_TEST
+	bool "Enable infrastructure for get_user_pages()-related unit tests"
 	help
-	  Provides /sys/kernel/debug/gup_benchmark that helps with testing
-	  performance of get_user_pages() and related calls.
+	  Provides /sys/kernel/debug/gup_test, which in turn provides a way
+	  to make ioctl calls that can launch kernel-based unit tests for
+	  the get_user_pages*() and pin_user_pages*() family of API calls.
=20
-	  See tools/testing/selftests/vm/gup_benchmark.c
+	  These tests include benchmark testing of the _fast variants of
+	  get_user_pages*() and pin_user_pages*(), as well as smoke tests of
+	  the non-_fast variants.
+
+	  See tools/testing/selftests/vm/gup_test.c
=20
 config GUP_GET_PTE_LOW_HIGH
 	bool
diff --git a/mm/Makefile b/mm/Makefile
index cae063dc8298..21fc9af33f9b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -90,7 +90,7 @@ obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
 obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
 obj-$(CONFIG_MEMCG_SWAP) +=3D swap_cgroup.o
 obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
-obj-$(CONFIG_GUP_BENCHMARK) +=3D gup_benchmark.o
+obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
 obj-$(CONFIG_MEMORY_FAILURE) +=3D memory-failure.o
 obj-$(CONFIG_HWPOISON_INJECT) +=3D hwpoison-inject.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) +=3D kmemleak.o
diff --git a/mm/gup_benchmark.c b/mm/gup_test.c
similarity index 80%
rename from mm/gup_benchmark.c
rename to mm/gup_test.c
index 464cae1fa3ea..10f41c0528de 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_test.c
@@ -5,13 +5,13 @@
 #include <linux/ktime.h>
 #include <linux/debugfs.h>
=20
-#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
-#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
-#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
-#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
+#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
+#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
+#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
=20
-struct gup_benchmark {
+struct gup_test {
 	__u64 get_delta_usec;
 	__u64 put_delta_usec;
 	__u64 addr;
@@ -56,7 +56,7 @@ static void verify_dma_pinned(unsigned int cmd, struct pa=
ge **pages,
 			if (WARN(!page_maybe_dma_pinned(page),
 				 "pages[%lu] is NOT dma-pinned\n", i)) {
=20
-				dump_page(page, "gup_benchmark failure");
+				dump_page(page, "gup_test failure");
 				break;
 			}
 		}
@@ -64,8 +64,8 @@ static void verify_dma_pinned(unsigned int cmd, struct pa=
ge **pages,
 	}
 }
=20
-static int __gup_benchmark_ioctl(unsigned int cmd,
-		struct gup_benchmark *gup)
+static int __gup_test_ioctl(unsigned int cmd,
+		struct gup_test *gup)
 {
 	ktime_t start_time, end_time;
 	unsigned long i, nr_pages, addr, next;
@@ -155,10 +155,10 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	return ret;
 }
=20
-static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
+static long gup_test_ioctl(struct file *filep, unsigned int cmd,
 		unsigned long arg)
 {
-	struct gup_benchmark gup;
+	struct gup_test gup;
 	int ret;
=20
 	switch (cmd) {
@@ -175,7 +175,7 @@ static long gup_benchmark_ioctl(struct file *filep, uns=
igned int cmd,
 	if (copy_from_user(&gup, (void __user *)arg, sizeof(gup)))
 		return -EFAULT;
=20
-	ret =3D __gup_benchmark_ioctl(cmd, &gup);
+	ret =3D __gup_test_ioctl(cmd, &gup);
 	if (ret)
 		return ret;
=20
@@ -185,17 +185,17 @@ static long gup_benchmark_ioctl(struct file *filep, u=
nsigned int cmd,
 	return 0;
 }
=20
-static const struct file_operations gup_benchmark_fops =3D {
+static const struct file_operations gup_test_fops =3D {
 	.open =3D nonseekable_open,
-	.unlocked_ioctl =3D gup_benchmark_ioctl,
+	.unlocked_ioctl =3D gup_test_ioctl,
 };
=20
-static int gup_benchmark_init(void)
+static int gup_test_init(void)
 {
-	debugfs_create_file_unsafe("gup_benchmark", 0600, NULL, NULL,
-				   &gup_benchmark_fops);
+	debugfs_create_file_unsafe("gup_test", 0600, NULL, NULL,
+				   &gup_test_fops);
=20
 	return 0;
 }
=20
-late_initcall(gup_benchmark_init);
+late_initcall(gup_test_init);
diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 849e8226395a..2c8ddcf41c0e 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -15,7 +15,7 @@ userfaultfd
 mlock-intersect-test
 mlock-random-test
 virtual_address_range
-gup_benchmark
+gup_test
 va_128TBswitch
 map_fixed_noreplace
 write_to_hugetlbfs
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 30873b19d04b..d1ae706d9927 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -23,7 +23,7 @@ MAKEFLAGS +=3D --no-builtin-rules
 CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS =3D -lrt
 TEST_GEN_FILES =3D compaction_test
-TEST_GEN_FILES +=3D gup_benchmark
+TEST_GEN_FILES +=3D gup_test
 TEST_GEN_FILES +=3D hmm-tests
 TEST_GEN_FILES +=3D hugepage-mmap
 TEST_GEN_FILES +=3D hugepage-shm
diff --git a/tools/testing/selftests/vm/config b/tools/testing/selftests/vm=
/config
index 69dd0d1aa30b..60e82da0de85 100644
--- a/tools/testing/selftests/vm/config
+++ b/tools/testing/selftests/vm/config
@@ -3,4 +3,4 @@ CONFIG_USERFAULTFD=3Dy
 CONFIG_TEST_VMALLOC=3Dm
 CONFIG_DEVICE_PRIVATE=3Dy
 CONFIG_TEST_HMM=3Dm
-CONFIG_GUP_BENCHMARK=3Dy
+CONFIG_GUP_TEST=3Dy
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/sel=
ftests/vm/gup_test.c
similarity index 85%
rename from tools/testing/selftests/vm/gup_benchmark.c
rename to tools/testing/selftests/vm/gup_test.c
index 31f8bb086907..e930135727a2 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -14,18 +14,18 @@
 #define MB (1UL << 20)
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
=20
-#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
+#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
+#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
=20
 /* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
-#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
-#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
-#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
+#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
=20
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
=20
-struct gup_benchmark {
+struct gup_test {
 	__u64 get_delta_usec;
 	__u64 put_delta_usec;
 	__u64 addr;
@@ -37,7 +37,7 @@ struct gup_benchmark {
=20
 int main(int argc, char **argv)
 {
-	struct gup_benchmark gup;
+	struct gup_test gup;
 	unsigned long size =3D 128 * MB;
 	int i, fd, filed, opt, nr_pages =3D 1, thp =3D -1, repeats =3D 1, write =
=3D 0;
 	int cmd =3D GUP_FAST_BENCHMARK, flags =3D MAP_PRIVATE;
@@ -104,7 +104,7 @@ int main(int argc, char **argv)
 	if (write)
 		gup.flags |=3D FOLL_WRITE;
=20
-	fd =3D open("/sys/kernel/debug/gup_benchmark", O_RDWR);
+	fd =3D open("/sys/kernel/debug/gup_test", O_RDWR);
 	if (fd =3D=3D -1)
 		perror("open"), exit(1);
=20
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftes=
ts/vm/run_vmtests
index a3f4f30f0a2e..d1843d5f3c30 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -124,9 +124,9 @@ else
 fi
=20
 echo "--------------------------------------------"
-echo "running 'gup_benchmark -U' (normal/slow gup)"
+echo "running 'gup_test -U' (normal/slow gup)"
 echo "--------------------------------------------"
-./gup_benchmark -U
+./gup_test -U
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
@@ -135,9 +135,9 @@ else
 fi
=20
 echo "------------------------------------------"
-echo "running gup_benchmark -b (pin_user_pages)"
+echo "running gup_test -b (pin_user_pages)"
 echo "------------------------------------------"
-./gup_benchmark -b
+./gup_test -b
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=3D1
--=20
2.28.0

