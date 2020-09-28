Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2027A77E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgI1GWT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 02:22:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2557 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgI1GWE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 02:22:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7180d90001>; Sun, 27 Sep 2020 23:21:13 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 06:22:02 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 28 Sep 2020 06:22:02 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/8] selftests/vm: gup_test: introduce the dump_pages() sub-test
Date:   Sun, 27 Sep 2020 23:21:57 -0700
Message-ID: <20200928062159.923212-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928062159.923212-1-jhubbard@nvidia.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601274073; bh=w5tBxpMI8YINMUR83e6/Vx1VxBEjMs3TXUkBG1Thw54=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rzTD0u01V+KC9mk62B9+WdAVUG3QDLYZHnqlQfjmQjDuDzUcXg30WlpzwGSzoMwuj
         La74Dy/Yplgcq/QaSbXgBVqLSY/hDFDyOlYiU4ZwA4B7rpE7cfnZ87JPRq1fSWGqoR
         2yk+SrtxF2r0RWJC5RArfKPr34E2CdTD6+0/4IF2LoW5+CjyTEDcePdTZBZQnObjWg
         13D+WMMWVt1ErP1y6MCe1oR1STyhDZPy/gw6R/YQqzIipv40M/noB9+O+R8qFUkJmJ
         GI7Pp0WQAJmB72w0YiH5miA3iCCBwLJs5AC3gI6TzLa6Y4AvaLw7CH1sGhbvwdXR73
         6eikaWsb9Fqrg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For quite a while, I was doing a quick hack to gup_test.c (previously,
gup_benchmark.c) whenever I wanted to try out my changes to dump_page().
This makes that hack unnecessary, and instead allows anyone to easily
get the same coverage from a user space program. That saves a lot of
time because you don't have to change the kernel, in order to test
different pages and options.

The new sub-test takes advantage of the existing gup_test
infrastructure, which already provides a simple user space program, some
allocated user space pages, an ioctl call, pinning of those pages (via
either get_user_pages or pin_user_pages) and a corresponding kernel-side
test invocation. There's not much more required, mainly just a couple of
inputs from the user.

In fact, the new test re-uses the existing command line options in order
to get various helpful combinations (THP or normal, _fast or slow gup,
gup vs. pup, and more).

New command line options are: which pages to dump, and what type of
"get/pin" to use.

In order to figure out which pages to dump, the logic is:

* If the user doesn't specify anything, the page 0 (the first page in
the address range that the program sets up for testing) is dumped.

* Or, the user can type up to 8 page indices anywhere on the command
line. If you type more than 8, then it uses the first 8 and ignores the
remaining items.

For example:

    ./gup_test -ct -F 1 0 19 0x1000

Meaning:
    -c:          dump pages sub-test
    -t:          use THP pages
    -F 1:        use pin_user_pages() instead of get_user_pages()
    0 19 0x1000: dump pages 0, 19, and 4096

Also, invoke the new test from run_vmtests.sh. This keeps it in use, and
also provides a good example of how to invoke it.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/Kconfig                            |  6 +++
 mm/gup_test.c                         | 54 ++++++++++++++++++++++++++-
 mm/gup_test.h                         | 10 +++++
 tools/testing/selftests/vm/gup_test.c | 47 +++++++++++++++++++++--
 4 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 588984ee5fb4..f7c4c21e5cb1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -845,6 +845,12 @@ config GUP_TEST
 	  get_user_pages*() and pin_user_pages*(), as well as smoke tests of
 	  the non-_fast variants.
=20
+	  There is also a sub-test that allows running dump_page() on any
+	  of up to eight pages (selected by command line args) within the
+	  range of user-space addresses. These pages are either pinned via
+	  pin_user_pages*(), or pinned via get_user_pages*(), as specified
+	  by other command line arguments.
+
 	  See tools/testing/selftests/vm/gup_test.c
=20
 config GUP_GET_PTE_LOW_HIGH
diff --git a/mm/gup_test.c b/mm/gup_test.c
index a980c4a194f0..e79dc364eafb 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -7,7 +7,7 @@
 #include "gup_test.h"
=20
 static void put_back_pages(unsigned int cmd, struct page **pages,
-			   unsigned long nr_pages)
+			   unsigned long nr_pages, unsigned int gup_test_flags)
 {
 	unsigned long i;
=20
@@ -23,6 +23,15 @@ static void put_back_pages(unsigned int cmd, struct page=
 **pages,
 	case PIN_LONGTERM_BENCHMARK:
 		unpin_user_pages(pages, nr_pages);
 		break;
+	case DUMP_USER_PAGES_TEST:
+		if (gup_test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN) {
+			unpin_user_pages(pages, nr_pages);
+		} else {
+			for (i =3D 0; i < nr_pages; i++)
+				put_page(pages[i]);
+
+		}
+		break;
 	}
 }
=20
@@ -49,6 +58,37 @@ static void verify_dma_pinned(unsigned int cmd, struct p=
age **pages,
 	}
 }
=20
+static void dump_pages_test(struct gup_test *gup, struct page **pages,
+			    unsigned long nr_pages)
+{
+	unsigned int index_to_dump;
+	unsigned int i;
+
+	/*
+	 * Zero out any user-supplied page index that is out of range. Remember:
+	 * .which_pages[] contains a 1-based set of page indices.
+	 */
+	for (i =3D 0; i < GUP_TEST_MAX_PAGES_TO_DUMP; i++) {
+		if (gup->which_pages[i] > nr_pages) {
+			pr_warn("ZEROING due to out of range: .which_pages[%u]: %u\n",
+				i, gup->which_pages[i]);
+			gup->which_pages[i] =3D 0;
+		}
+	}
+
+	for (i =3D 0; i < GUP_TEST_MAX_PAGES_TO_DUMP; i++) {
+		index_to_dump =3D gup->which_pages[i];
+
+		if (index_to_dump) {
+			index_to_dump--; // Decode from 1-based, to 0-based
+			pr_info("---- page #%u, starting from user virt addr: 0x%llx\n",
+				index_to_dump, gup->addr);
+			dump_page(pages[index_to_dump],
+				  "gup_test: dump_pages() test");
+		}
+	}
+}
+
 static int __gup_test_ioctl(unsigned int cmd,
 		struct gup_test *gup)
 {
@@ -104,6 +144,14 @@ static int __gup_test_ioctl(unsigned int cmd,
 					    gup->flags | FOLL_LONGTERM,
 					    pages + i, NULL);
 			break;
+		case DUMP_USER_PAGES_TEST:
+			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
+				nr =3D pin_user_pages(addr, nr, gup->flags,
+						    pages + i, NULL);
+			else
+				nr =3D get_user_pages(addr, nr, gup->flags,
+						    pages + i, NULL);
+			break;
 		default:
 			kvfree(pages);
 			ret =3D -EINVAL;
@@ -127,10 +175,11 @@ static int __gup_test_ioctl(unsigned int cmd,
 	 * state: print a warning if any non-dma-pinned pages are found:
 	 */
 	verify_dma_pinned(cmd, pages, nr_pages);
+	dump_pages_test(gup, pages, nr_pages);
=20
 	start_time =3D ktime_get();
=20
-	put_back_pages(cmd, pages, nr_pages);
+	put_back_pages(cmd, pages, nr_pages, gup->flags);
=20
 	end_time =3D ktime_get();
 	gup->put_delta_usec =3D ktime_us_delta(end_time, start_time);
@@ -152,6 +201,7 @@ static long gup_test_ioctl(struct file *filep, unsigned=
 int cmd,
 	case PIN_LONGTERM_BENCHMARK:
 	case GUP_BASIC_TEST:
 	case PIN_BASIC_TEST:
+	case DUMP_USER_PAGES_TEST:
 		break;
 	default:
 		return -EINVAL;
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 921b4caad8ef..90a6713d50eb 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -9,6 +9,11 @@
 #define PIN_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_test)
 #define GUP_BASIC_TEST		_IOWR('g', 4, struct gup_test)
 #define PIN_BASIC_TEST		_IOWR('g', 5, struct gup_test)
+#define DUMP_USER_PAGES_TEST	_IOWR('g', 6, struct gup_test)
+
+#define GUP_TEST_MAX_PAGES_TO_DUMP		8
+
+#define GUP_TEST_FLAG_DUMP_PAGES_USE_PIN	0x1
=20
 struct gup_test {
 	__u64 get_delta_usec;
@@ -17,6 +22,11 @@ struct gup_test {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	/*
+	 * Each non-zero entry is the number of the page (1-based: first page is
+	 * page 1, so that zero entries mean "do nothing") from the .addr base.
+	 */
+	__u32 which_pages[GUP_TEST_MAX_PAGES_TO_DUMP];
 };
=20
 #endif	/* __GUP_TEST_H */
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftest=
s/vm/gup_test.c
index 67d57a1cc8b6..68137b337114 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -27,21 +27,23 @@ static char *cmd_to_str(unsigned long cmd)
 		return "GUP_BASIC_TEST";
 	case PIN_BASIC_TEST:
 		return "PIN_BASIC_TEST";
+	case DUMP_USER_PAGES_TEST:
+		return "DUMP_USER_PAGES_TEST";
 	}
 	return "Unknown command";
 }
=20
 int main(int argc, char **argv)
 {
-	struct gup_test gup;
+	struct gup_test gup =3D { 0 };
 	unsigned long size =3D 128 * MB;
 	int i, fd, filed, opt, nr_pages =3D 1, thp =3D -1, repeats =3D 1, write =
=3D 0;
-	int cmd =3D GUP_FAST_BENCHMARK;
+	unsigned long cmd =3D GUP_FAST_BENCHMARK;
 	int flags =3D MAP_PRIVATE;
 	char *file =3D "/dev/zero";
 	char *p;
=20
-	while ((opt =3D getopt(argc, argv, "m:r:n:f:abtTLUuwSH")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "m:r:n:F:f:abctTLUuwSH")) !=3D -1) {
 		switch (opt) {
 		case 'a':
 			cmd =3D PIN_FAST_BENCHMARK;
@@ -52,6 +54,21 @@ int main(int argc, char **argv)
 		case 'L':
 			cmd =3D PIN_LONGTERM_BENCHMARK;
 			break;
+		case 'c':
+			cmd =3D DUMP_USER_PAGES_TEST;
+			/*
+			 * Dump page 0 (index 1). May be overridden later, by
+			 * user's non-option arguments.
+			 *
+			 * .which_pages is zero-based, so that zero can mean "do
+			 * nothing".
+			 */
+			gup.which_pages[0] =3D 1;
+			break;
+		case 'F':
+			/* strtol, so you can pass flags in hex form */
+			gup.flags =3D strtol(optarg, 0, 0);
+			break;
 		case 'm':
 			size =3D atoi(optarg) * MB;
 			break;
@@ -91,6 +108,30 @@ int main(int argc, char **argv)
 		}
 	}
=20
+	if (optind < argc) {
+		int extra_arg_count =3D 0;
+		/*
+		 * For example:
+		 *
+		 *   ./gup_test -c 0 1 0x1001
+		 *
+		 * ...to dump pages 0, 1, and 4097
+		 */
+
+		while ((optind < argc) &&
+		       (extra_arg_count < GUP_TEST_MAX_PAGES_TO_DUMP)) {
+			/*
+			 * Do the 1-based indexing here, so that the user can
+			 * use normal 0-based indexing on the command line.
+			 */
+			long page_index =3D strtol(argv[optind], 0, 0) + 1;
+
+			gup.which_pages[extra_arg_count] =3D page_index;
+			extra_arg_count++;
+			optind++;
+		}
+	}
+
 	filed =3D open(file, O_RDWR|O_CREAT);
 	if (filed < 0) {
 		perror("open");
--=20
2.28.0

