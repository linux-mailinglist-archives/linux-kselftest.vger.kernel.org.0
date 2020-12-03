Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636722CDD06
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgLCSDb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 13:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgLCSDb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 13:03:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D839C061A4F
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 10:02:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c137so3713934ybf.21
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OHcxlT1QLl/FypmS4f7/3LnVbjzBRqlZYN2Df71kYOc=;
        b=YfLZRH6bg5kepViQkaLDAXuwXmNNZ44BW+UtnlU24zvLry0yspfTHy08MMtE/CcSBe
         itfWLWvF8BcxRfW070C208+z1lM+ECRkaL4EwpHIpzVJ82/VPAl55iTrwJjK1dSINlJS
         T5HysDAguzta/NQgWLg9m0EWrDZ4h/9IUgSUo57YTBHWukOLbyyhlLY5+wtXH2TAtTpU
         xkbXzBcEwP4eg5vWKrkXOCMryFDUW2915AsVusqvs24Ikw1U+OSd7I/tRwqWBbdi3gXW
         VCHipdobtFw1a1QOJAeVxsBpW3Yr/aNvISm/2fQBB0rWOOk/E65v3VhiHjR0rN0gZxJq
         jLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OHcxlT1QLl/FypmS4f7/3LnVbjzBRqlZYN2Df71kYOc=;
        b=mYpUUB9wVvlwI5bH9VcZne+jHhXOBbNzi8MAK5lvIBgsYOxlYNCXMsFB86D8xNlPWk
         r34TOCDDg7PrKnzUh5N63YmuKMZzhGTrJY3On2OMqYlUtXkB+nyh/hsqJa+Jx3PVmvGb
         6qMgUtEFWG3aOk5JAZpms7vZdSReuU0e9ikYAQxuDo9d4zEXNajEs0mwWYI9E7BLc8QE
         ddv0GazyHwJmedW3+vj1C13CNHqPbJuwdeKMNxUYgfXnGhk75SARy89yRWUq8eoZtkhl
         u/4L6LG2GKZRJYrBsvD70rO5eR/6SvUdeCx4sq0AHARTFW/ayxYJz5LWG7Zy4HwD122w
         W21Q==
X-Gm-Message-State: AOAM533ZlZoP7uhS+47HZKX7R0J3Mt1KOFxLoZ1nKdOgfJ2HosUHXOev
        ERtDA3mSOt+IfOQRHeGUmgN4jsDaLEvhf0wNvD1y
X-Google-Smtp-Source: ABdhPJxuinEJZ84ydvLjxAaVndzUAZeyW/0anaog6zUnKaGgoL4crbNmfmo7c4A9zPFdnsoazG1CT4MvyYzAc6XW6ut+
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6949:: with SMTP id
 e70mr321309ybc.313.1607018570266; Thu, 03 Dec 2020 10:02:50 -0800 (PST)
Date:   Thu,  3 Dec 2020 10:02:44 -0800
Message-Id: <20201203180244.1811601-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] userfaultfd: selftests: make __{s,u}64 format specifiers portable
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>
Cc:     Greg Thelen <gthelen@google.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On certain platforms (powerpcle is the one on which I ran into this),
"%Ld" and "%Lu" are unsuitable for printing __s64 and __u64,
respectively, resulting in build warnings. Cast to {u,}int64_t, and
use the PRI{d,u}64 macros defined in inttypes.h to print them. This
ought to be portable to all platforms.

Splitting this off into a separate macro lets us remove some lines,
and get rid of some (I would argue) stylistically odd cases where we
joined printf() and exit() into a single statement with a ,.

Finally, this also fixes a "missing braces around initializer" warning
when we initialize prms in wp_range().

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 81 ++++++++++--------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9b0912a01777..70ea08da5f91 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -55,6 +55,8 @@
 #include <setjmp.h>
 #include <stdbool.h>
 #include <assert.h>
+#include <inttypes.h>
+#include <stdint.h>
 
 #include "../kselftest.h"
 
@@ -135,6 +137,13 @@ static void usage(void)
 	exit(1);
 }
 
+#define uffd_error(code, fmt, ...)                                             \
+	do {                                                                   \
+		fprintf(stderr, fmt, ##__VA_ARGS__);                           \
+		fprintf(stderr, ": %" PRId64 "\n", (int64_t)(code));           \
+		exit(1);                                                       \
+	} while (0)
+
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 			     unsigned long n_cpus)
 {
@@ -331,7 +340,7 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 
 static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 {
-	struct uffdio_writeprotect prms = { 0 };
+	struct uffdio_writeprotect prms;
 
 	/* Write protection page faults */
 	prms.range.start = start;
@@ -340,7 +349,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
 
 	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
-		fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
+		fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
+			(uint64_t)start);
 		exit(1);
 	}
 }
@@ -474,14 +484,11 @@ static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
 	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy->copy != -EEXIST) {
-			fprintf(stderr, "UFFDIO_COPY retry error %Ld\n",
-				uffdio_copy->copy);
-			exit(1);
+			uffd_error(uffdio_copy->copy,
+				   "UFFDIO_COPY retry error");
 		}
-	} else {
-		fprintf(stderr,	"UFFDIO_COPY retry unexpected %Ld\n",
-			uffdio_copy->copy); exit(1);
-	}
+	} else
+		uffd_error(uffdio_copy->copy, "UFFDIO_COPY retry unexpected");
 }
 
 static int __copy_page(int ufd, unsigned long offset, bool retry)
@@ -502,14 +509,10 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.copy = 0;
 	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy.copy != -EEXIST) {
-			fprintf(stderr, "UFFDIO_COPY error %Ld\n",
-				uffdio_copy.copy);
-			exit(1);
-		}
+		if (uffdio_copy.copy != -EEXIST)
+			uffd_error(uffdio_copy.copy, "UFFDIO_COPY error");
 	} else if (uffdio_copy.copy != page_size) {
-		fprintf(stderr, "UFFDIO_COPY unexpected copy %Ld\n",
-			uffdio_copy.copy); exit(1);
+		uffd_error(uffdio_copy.copy, "UFFDIO_COPY unexpected copy");
 	} else {
 		if (test_uffdio_copy_eexist && retry) {
 			test_uffdio_copy_eexist = false;
@@ -788,7 +791,8 @@ static int userfaultfd_open(int features)
 		return 1;
 	}
 	if (uffdio_api.api != UFFD_API) {
-		fprintf(stderr, "UFFDIO_API error %Lu\n", uffdio_api.api);
+		fprintf(stderr, "UFFDIO_API error: %" PRIu64 "\n",
+			(uint64_t)uffdio_api.api);
 		return 1;
 	}
 
@@ -950,13 +954,12 @@ static void retry_uffdio_zeropage(int ufd,
 				     offset);
 	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
 		if (uffdio_zeropage->zeropage != -EEXIST) {
-			fprintf(stderr, "UFFDIO_ZEROPAGE retry error %Ld\n",
-				uffdio_zeropage->zeropage);
-			exit(1);
+			uffd_error(uffdio_zeropage->zeropage,
+				   "UFFDIO_ZEROPAGE retry error");
 		}
 	} else {
-		fprintf(stderr, "UFFDIO_ZEROPAGE retry unexpected %Ld\n",
-			uffdio_zeropage->zeropage); exit(1);
+		uffd_error(uffdio_zeropage->zeropage,
+			   "UFFDIO_ZEROPAGE retry unexpected");
 	}
 }
 
@@ -965,6 +968,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 	struct uffdio_zeropage uffdio_zeropage;
 	int ret;
 	unsigned long has_zeropage;
+	__s64 res;
 
 	has_zeropage = uffd_test_ops->expected_ioctls & (1 << _UFFDIO_ZEROPAGE);
 
@@ -976,29 +980,17 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 	uffdio_zeropage.range.len = page_size;
 	uffdio_zeropage.mode = 0;
 	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+	res = uffdio_zeropage.zeropage;
 	if (ret) {
 		/* real retval in ufdio_zeropage.zeropage */
 		if (has_zeropage) {
-			if (uffdio_zeropage.zeropage == -EEXIST) {
-				fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
-				exit(1);
-			} else {
-				fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
-					uffdio_zeropage.zeropage);
-				exit(1);
-			}
-		} else {
-			if (uffdio_zeropage.zeropage != -EINVAL) {
-				fprintf(stderr,
-					"UFFDIO_ZEROPAGE not -EINVAL %Ld\n",
-					uffdio_zeropage.zeropage);
-				exit(1);
-			}
-		}
+			uffd_error(res, "UFFDIO_ZEROPAGE %s",
+				   res == -EEXIST ? "-EEXIST" : "error");
+		} else if (res != -EINVAL)
+			uffd_error(res, "UFFDIO_ZEROPAGE not -EINVAL");
 	} else if (has_zeropage) {
-		if (uffdio_zeropage.zeropage != page_size) {
-			fprintf(stderr, "UFFDIO_ZEROPAGE unexpected %Ld\n",
-				uffdio_zeropage.zeropage); exit(1);
+		if (res != page_size) {
+			uffd_error(res, "UFFDIO_ZEROPAGE unexpected");
 		} else {
 			if (test_uffdio_zeropage_eexist && retry) {
 				test_uffdio_zeropage_eexist = false;
@@ -1007,11 +999,8 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 			}
 			return 1;
 		}
-	} else {
-		fprintf(stderr,
-			"UFFDIO_ZEROPAGE succeeded %Ld\n",
-			uffdio_zeropage.zeropage); exit(1);
-	}
+	} else
+		uffd_error(res, "UFFDIO_ZEROPAGE succeeded");
 
 	return 0;
 }
-- 
2.29.2.454.gaff20da3a2-goog

