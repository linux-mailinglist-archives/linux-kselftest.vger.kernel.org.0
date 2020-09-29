Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CA27DA16
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgI2V2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 17:28:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10957 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2V1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 17:27:51 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a6710002>; Tue, 29 Sep 2020 14:26:09 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:27:50 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 29 Sep 2020 21:27:50 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/8] selftests/vm: only some gup_test items are really benchmarks
Date:   Tue, 29 Sep 2020 14:27:44 -0700
Message-ID: <20200929212747.251804-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929212747.251804-1-jhubbard@nvidia.com>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601414769; bh=VqO1TvmFLxjF608zTUu9TzXtJloRWalC7nSuAm8hXYw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=VyRtiJak6O6/eR4n0r9a0PKX8GjLV7Xf5/J6jwCKxfrxeMNnd6X2H0W++Rnj1Mj6y
         Jtf+ubaCJsDEWbNTR3/gbqUXZUzLLvTo2FbrHDmvMnsDa+oGm1yy4vlu8J/yabhk8e
         p0CJGBxQAldgBElNrkYKEvWYw4vy2E7AXTUxG+MhrXOsOiwhaDUiqwVS9VMckEXDB9
         12YxopG5NMdvHw8qyn/UhG1vixGd6xRgeHWr+Dde6dBI+iqSvBSBux3UkkdoLdpMV9
         YmLLy6sU7uqw8IXIv0VyH8wyMAciTY/RsaTDV2xc/UBoXU5PpsYSCxRZ/Ma/EhRNkx
         5sK+YSKhkMazw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Therefore, some minor cleanup and improvements are in order:

1. Rename the other items appropriately.

2. Stop reporting timing information on the non-benchmark items. It's
   still being recorded and is available, but there's no point in
   cluttering up the report with data that no one reasonably needs to
   check.

3. Don't do iterations, for non-benchmark items.

4. Print out a shorter, more appropriate report for the non-benchmark
   tests.

5. Add the command that was run, to the report. This really helps, as
   there are quite a lot of options now.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst |  2 +-
 mm/gup_test.c                             | 14 +++----
 mm/gup_test.h                             |  8 ++--
 tools/testing/selftests/vm/gup_test.c     | 47 +++++++++++++++++++----
 4 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index eae972b23224..fcf605be43d0 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -226,7 +226,7 @@ This file::
 has the following new calls to exercise the new pin*() wrapper functions:
=20
 * PIN_FAST_BENCHMARK (./gup_test -a)
-* PIN_BENCHMARK (./gup_test -b)
+* PIN_BASIC_TEST (./gup_test -b)
=20
 You can monitor how many total dma-pinned pages have been acquired and rel=
eased
 since the system was booted, via two new /proc/vmstat entries: ::
diff --git a/mm/gup_test.c b/mm/gup_test.c
index 9f8c1cbe3553..8055617f0cd4 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -13,13 +13,13 @@ static void put_back_pages(unsigned int cmd, struct pag=
e **pages,
=20
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
-	case GUP_BENCHMARK:
+	case GUP_BASIC_TEST:
 		for (i =3D 0; i < nr_pages; i++)
 			put_page(pages[i]);
 		break;
=20
 	case PIN_FAST_BENCHMARK:
-	case PIN_BENCHMARK:
+	case PIN_BASIC_TEST:
 	case PIN_LONGTERM_BENCHMARK:
 		unpin_user_pages(pages, nr_pages);
 		break;
@@ -34,7 +34,7 @@ static void verify_dma_pinned(unsigned int cmd, struct pa=
ge **pages,
=20
 	switch (cmd) {
 	case PIN_FAST_BENCHMARK:
-	case PIN_BENCHMARK:
+	case PIN_BASIC_TEST:
 	case PIN_LONGTERM_BENCHMARK:
 		for (i =3D 0; i < nr_pages; i++) {
 			page =3D pages[i];
@@ -87,7 +87,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr =3D get_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
-		case GUP_BENCHMARK:
+		case GUP_BASIC_TEST:
 			nr =3D get_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
 			break;
@@ -95,7 +95,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr =3D pin_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
-		case PIN_BENCHMARK:
+		case PIN_BASIC_TEST:
 			nr =3D pin_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
 			break;
@@ -148,10 +148,10 @@ static long gup_test_ioctl(struct file *filep, unsign=
ed int cmd,
=20
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
-	case GUP_BENCHMARK:
 	case PIN_FAST_BENCHMARK:
-	case PIN_BENCHMARK:
 	case PIN_LONGTERM_BENCHMARK:
+	case GUP_BASIC_TEST:
+	case PIN_BASIC_TEST:
 		break;
 	default:
 		return -EINVAL;
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 931c2f3f477a..921b4caad8ef 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -5,10 +5,10 @@
 #include <linux/types.h>
=20
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
-#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_test)
-#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_test)
-#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_test)
-#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_test)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 2, struct gup_test)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_test)
+#define GUP_BASIC_TEST		_IOWR('g', 4, struct gup_test)
+#define PIN_BASIC_TEST		_IOWR('g', 5, struct gup_test)
=20
 struct gup_test {
 	__u64 get_delta_usec;
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftest=
s/vm/gup_test.c
index 4e9f5d0ed0fc..67d57a1cc8b6 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -14,12 +14,30 @@
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
=20
+static char *cmd_to_str(unsigned long cmd)
+{
+	switch (cmd) {
+	case GUP_FAST_BENCHMARK:
+		return "GUP_FAST_BENCHMARK";
+	case PIN_FAST_BENCHMARK:
+		return "PIN_FAST_BENCHMARK";
+	case PIN_LONGTERM_BENCHMARK:
+		return "PIN_LONGTERM_BENCHMARK";
+	case GUP_BASIC_TEST:
+		return "GUP_BASIC_TEST";
+	case PIN_BASIC_TEST:
+		return "PIN_BASIC_TEST";
+	}
+	return "Unknown command";
+}
+
 int main(int argc, char **argv)
 {
 	struct gup_test gup;
 	unsigned long size =3D 128 * MB;
 	int i, fd, filed, opt, nr_pages =3D 1, thp =3D -1, repeats =3D 1, write =
=3D 0;
-	int cmd =3D GUP_FAST_BENCHMARK, flags =3D MAP_PRIVATE;
+	int cmd =3D GUP_FAST_BENCHMARK;
+	int flags =3D MAP_PRIVATE;
 	char *file =3D "/dev/zero";
 	char *p;
=20
@@ -29,7 +47,7 @@ int main(int argc, char **argv)
 			cmd =3D PIN_FAST_BENCHMARK;
 			break;
 		case 'b':
-			cmd =3D PIN_BENCHMARK;
+			cmd =3D PIN_BASIC_TEST;
 			break;
 		case 'L':
 			cmd =3D PIN_LONGTERM_BENCHMARK;
@@ -50,7 +68,7 @@ int main(int argc, char **argv)
 			thp =3D 0;
 			break;
 		case 'U':
-			cmd =3D GUP_BENCHMARK;
+			cmd =3D GUP_BASIC_TEST;
 			break;
 		case 'u':
 			cmd =3D GUP_FAST_BENCHMARK;
@@ -100,16 +118,29 @@ int main(int argc, char **argv)
 	for (; (unsigned long)p < gup.addr + size; p +=3D PAGE_SIZE)
 		p[0] =3D 0;
=20
-	for (i =3D 0; i < repeats; i++) {
+	/* Only report timing information on the *_BENCHMARK commands: */
+	if ((cmd =3D=3D PIN_FAST_BENCHMARK) || (cmd =3D=3D GUP_FAST_BENCHMARK) ||
+	     (cmd =3D=3D PIN_LONGTERM_BENCHMARK)) {
+		for (i =3D 0; i < repeats; i++) {
+			gup.size =3D size;
+			if (ioctl(fd, cmd, &gup))
+				perror("ioctl"), exit(1);
+
+			printf("%s: Time: get:%lld put:%lld us",
+			       cmd_to_str(cmd), gup.get_delta_usec,
+			       gup.put_delta_usec);
+			if (gup.size !=3D size)
+				printf(", truncated (size: %lld)", gup.size);
+			printf("\n");
+		}
+	} else {
 		gup.size =3D size;
 		if (ioctl(fd, cmd, &gup))
 			perror("ioctl"), exit(1);
=20
-		printf("Time: get:%lld put:%lld us", gup.get_delta_usec,
-			gup.put_delta_usec);
+		printf("%s: done\n", cmd_to_str(cmd));
 		if (gup.size !=3D size)
-			printf(", truncated (size: %lld)", gup.size);
-		printf("\n");
+			printf("Truncated (size: %lld)\n", gup.size);
 	}
=20
 	return 0;
--=20
2.28.0

