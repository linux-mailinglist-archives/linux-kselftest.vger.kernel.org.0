Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729C2CC8BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgLBVQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 16:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLBVQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 16:16:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742EC0617A6
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 13:16:00 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o190so91531qkf.15
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=gpYfjjVyPChH5XBEuEH1c2uCHNEnIzUnJDng/FcjP0Q=;
        b=JxZBZcJg8zLpCUKv4LaZW1qeFFBtQrOtmtshwIIg06kKA/3KXacaS5+6dEbO7SpoPT
         PwRGDTvg7ZNavjW19r6NwfV9cU/NCZuAhMDo8VEk3PW2Xjzlhi12W/NrvXJ+Ry/T6YmI
         dzDiTVp+m0Fzz3dM/cOrEbzWAQeybiv9OxwbNji5/Ewb8f7Y9k2VaGvrBICO6c57nmFi
         C4PU73aVtLcOxCGGGytlQJHoukC+rsP9hYtyQYG8PkN7dBh36MsR+ZeciaiXhRymlyeA
         mWw2XXGVR3ETOssu2aHyzK8R5kUnSRUIbvvwQ51RyKO9ZmT2R0HzM2vE7i+bh4dL/0Sr
         PZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=gpYfjjVyPChH5XBEuEH1c2uCHNEnIzUnJDng/FcjP0Q=;
        b=ANoL1tn9WNvGjDjXOJJykvAqegqBPwK6qeEEDokmECxMQs4RGwCtCq9FWbMWf5Enik
         0A1kZcufCrV5qJMJWTUGpPr16EkngTtcLvaxLZHlWZrWm/gl48kgrc6HhjGDdwwcG8At
         oGazznMggl1bfrIc01ZRi+f4AnhxXmn7sJ8wHwgQxnI/95z/zrraZQV1IXqkqDiDrqfr
         +NV6+68M11ZZnOXgqTFxTXbAOAmTlKWHIldo/KwPOZygQneKTGDZlPAv2SvWRgUp8E9Y
         q+h3NuqvHHTebfFnI1UYDQOKpyh3P9vdYKf7ajzeyocqblY8fKJWIa/7IbujhNN7aBmK
         6pIg==
X-Gm-Message-State: AOAM532GE+8ldQFH1u+uiJZ0Zz4jQSE24sTPRdGdJoZg2ltfO7uWCWWs
        i/hBtOYlIkNjgCSAYMj1VXpVpNfDhKfEovaNjrwF
X-Google-Smtp-Source: ABdhPJw6a2eCfW4XxyJ1xbNVmhrHWMEtYxnLZpw5s/9d+csck/5wm1AhcaljJwd0r0z3+fENr06spZJJScBW6pyXXQq6
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:5762:: with SMTP id
 r2mr48569qvx.45.1606943759960; Wed, 02 Dec 2020 13:15:59 -0800 (PST)
Date:   Wed,  2 Dec 2020 13:15:42 -0800
Message-Id: <20201202211542.1121189-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers portable
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
respectively, resulting in a build warning. Cast to {u,}int64_t, and
use the PRI{d,u}64 macros defined in inttypes.h to print them. This
ought to be portable to all platforms.

Splitting this off into a separate function lets us remove some lines,
and get rid of some (I would argue) stylistically odd cases where we
joined printf() and exit() into a single statement with a ,.

Finally, this also fixes a "missing braces around initializer" warning
when we initialize prms in wp_range().

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 77 +++++++++++-------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 9b0912a01777..31e1ff887e4b 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -55,6 +55,8 @@
 #include <setjmp.h>
 #include <stdbool.h>
 #include <assert.h>
+#include <inttypes.h>
+#include <stdint.h>
 
 #include "../kselftest.h"
 
@@ -135,6 +137,12 @@ static void usage(void)
 	exit(1);
 }
 
+static void uffd_error(const char *message, __s64 code)
+{
+	fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
+	exit(1);
+}
+
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 			     unsigned long n_cpus)
 {
@@ -331,7 +339,7 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 
 static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 {
-	struct uffdio_writeprotect prms = { 0 };
+	struct uffdio_writeprotect prms;
 
 	/* Write protection page faults */
 	prms.range.start = start;
@@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
 
 	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
-		fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
+		fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
+			(uint64_t)start);
 		exit(1);
 	}
 }
@@ -474,14 +483,11 @@ static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
 	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy->copy != -EEXIST) {
-			fprintf(stderr, "UFFDIO_COPY retry error %Ld\n",
-				uffdio_copy->copy);
-			exit(1);
+			uffd_error("UFFDIO_COPY retry error",
+				   uffdio_copy->copy);
 		}
-	} else {
-		fprintf(stderr,	"UFFDIO_COPY retry unexpected %Ld\n",
-			uffdio_copy->copy); exit(1);
-	}
+	} else
+		uffd_error("UFFDIO_COPY retry unexpected", uffdio_copy->copy);
 }
 
 static int __copy_page(int ufd, unsigned long offset, bool retry)
@@ -502,15 +508,11 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.copy = 0;
 	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy.copy != -EEXIST) {
-			fprintf(stderr, "UFFDIO_COPY error %Ld\n",
-				uffdio_copy.copy);
-			exit(1);
-		}
-	} else if (uffdio_copy.copy != page_size) {
-		fprintf(stderr, "UFFDIO_COPY unexpected copy %Ld\n",
-			uffdio_copy.copy); exit(1);
-	} else {
+		if (uffdio_copy.copy != -EEXIST)
+			uffd_error("UFFDIO_COPY error", uffdio_copy.copy);
+	} else if (uffdio_copy.copy != page_size)
+		uffd_error("UFFDIO_COPY unexpected copy", uffdio_copy.copy);
+	else {
 		if (test_uffdio_copy_eexist && retry) {
 			test_uffdio_copy_eexist = false;
 			retry_copy_page(ufd, &uffdio_copy, offset);
@@ -788,7 +790,8 @@ static int userfaultfd_open(int features)
 		return 1;
 	}
 	if (uffdio_api.api != UFFD_API) {
-		fprintf(stderr, "UFFDIO_API error %Lu\n", uffdio_api.api);
+		fprintf(stderr, "UFFDIO_API error: %" PRIu64 "\n",
+			(uint64_t)uffdio_api.api);
 		return 1;
 	}
 
@@ -950,13 +953,12 @@ static void retry_uffdio_zeropage(int ufd,
 				     offset);
 	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
 		if (uffdio_zeropage->zeropage != -EEXIST) {
-			fprintf(stderr, "UFFDIO_ZEROPAGE retry error %Ld\n",
-				uffdio_zeropage->zeropage);
-			exit(1);
+			uffd_error("UFFDIO_ZEROPAGE retry error",
+				   uffdio_zeropage->zeropage);
 		}
 	} else {
-		fprintf(stderr, "UFFDIO_ZEROPAGE retry unexpected %Ld\n",
-			uffdio_zeropage->zeropage); exit(1);
+		uffd_error("UFFDIO_ZEROPAGE retry unexpected",
+			   uffdio_zeropage->zeropage);
 	}
 }
 
@@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
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
+			uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
+						 "UFFDIO_ZEROPAGE -EEXIST" :
+						 "UFFDIO_ZEROPAGE error",
+				   uffdio_zeropage.zeropage);
 		} else {
 			if (uffdio_zeropage.zeropage != -EINVAL) {
-				fprintf(stderr,
-					"UFFDIO_ZEROPAGE not -EINVAL %Ld\n",
-					uffdio_zeropage.zeropage);
-				exit(1);
+				uffd_error("UFFDIO_ZEROPAGE not -EINVAL",
+					   uffdio_zeropage.zeropage);
 			}
 		}
 	} else if (has_zeropage) {
 		if (uffdio_zeropage.zeropage != page_size) {
-			fprintf(stderr, "UFFDIO_ZEROPAGE unexpected %Ld\n",
-				uffdio_zeropage.zeropage); exit(1);
+			uffd_error("UFFDIO_ZEROPAGE unexpected",
+				   uffdio_zeropage.zeropage);
 		} else {
 			if (test_uffdio_zeropage_eexist && retry) {
 				test_uffdio_zeropage_eexist = false;
@@ -1008,9 +1004,8 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 			return 1;
 		}
 	} else {
-		fprintf(stderr,
-			"UFFDIO_ZEROPAGE succeeded %Ld\n",
-			uffdio_zeropage.zeropage); exit(1);
+		uffd_error("UFFDIO_ZEROPAGE succeeded",
+			   uffdio_zeropage.zeropage);
 	}
 
 	return 0;
-- 
2.29.2.454.gaff20da3a2-goog

