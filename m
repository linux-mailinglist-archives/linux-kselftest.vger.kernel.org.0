Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF7298702
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770602AbgJZGlW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16903 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770535AbgJZGlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f680001>; Sun, 25 Oct 2020 23:40:40 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:01 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:01 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 5/9] selftests/vm: only some gup_test items are really benchmarks
Date:   Sun, 25 Oct 2020 23:40:17 -0700
Message-ID: <20201026064021.3545418-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026064021.3545418-1-jhubbard@nvidia.com>
References: <20201026064021.3545418-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694440; bh=NxnuVV34DOWHPgW892qcJLQ6f9CUj10LF23lyEi9hac=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type:X-NVConfidentiality:
         Content-Transfer-Encoding;
        b=E1YgppwgU1b/CpA7wYDE1oZfLxkzJZ8OGQrCwVlzIWCLrE2new4GAyA3aiwqZ8EuK
         VrkPirm8FQDhW0CsGrzf1rZrRQ88Jg9McNg4bOscIUIQxPTP56oAPoupQaKA0WuH4a
         BJt4Y2BzkPBDdQupdfePR2QkoyyTNC3coElbVuJ4pCfce6cMRs2BX8mGfjvIF4TGXC
         660tHpdQjDnuKeS4Ihvr9Rccr/CoMNRffHwXXYF5S+szHLzOOTFcK/1b6DKZT6rn3T
         DJXNbfBbqGXi5hYwHfFEg/LjE39K88c+uHFw8xwMElsZgCFX5+VtM8IhM2Dyu25kSI
         bVLjaxp7PYqEg==
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

6. Use a larger integer type for cmd, now that it's being compared
   Otherwise it doesn't work, because in this case cmd is about 3 billion,
   which is the perfect size for problems with signed vs unsigned int.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>
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
index 4c2d70d88f24..173bb38f3688 100644
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
@@ -94,7 +94,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr =3D get_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
-		case GUP_BENCHMARK:
+		case GUP_BASIC_TEST:
 			nr =3D get_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
 			break;
@@ -102,7 +102,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr =3D pin_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
-		case PIN_BENCHMARK:
+		case PIN_BASIC_TEST:
 			nr =3D pin_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
 			break;
@@ -157,10 +157,10 @@ static long gup_test_ioctl(struct file *filep, unsign=
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
index 1a54771ad97e..f9163e1bb57a 100644
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
+	unsigned long cmd =3D GUP_FAST_BENCHMARK;
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
@@ -104,18 +122,31 @@ int main(int argc, char **argv)
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
 		if (ioctl(fd, cmd, &gup)) {
 			perror("ioctl");
 			exit(1);
 		}
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
2.29.0

