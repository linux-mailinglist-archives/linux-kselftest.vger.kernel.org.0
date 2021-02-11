Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7F31900C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBKQcZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhBKQaO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:30:14 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A9C061A31
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:50 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f17so2424190qkl.5
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ca95TMJT4ShVUsz7drjIPNjU47Yiarr1AByU+uGNnGI=;
        b=UAEKzaBmpdpGJPDTslvYbeTKzc+Cl8dL29/mrc5M0LH+FkS1LQVSlP395GOW8df8ix
         2gIduDePZ+27EXjens+EPL19sNzgU0NEWkJ/yCGxwqbDfmy+MNlP+GlPPBOpYWWfqz7R
         wErE9uN+IJZseCuQHcPMn0XO7fHkiFBOX2b63/yKYcZTy+dtK1HvQNXMYPuXjwqdXaGj
         KOWDk/JyDst2nrRfkQl+aWd53zVTfts1PszjNSzUOR0MrFDxAry/IgjYczLYRsSJaHyB
         dhiqh1/yntx7YtScWKu/MfEtoXp55u5RySm0PWUzwJiLMMPbXx17IkvQ8BjK5yiCNC0b
         h4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ca95TMJT4ShVUsz7drjIPNjU47Yiarr1AByU+uGNnGI=;
        b=NDOkpBYnL+JxhBilnIZI5svVccxerjgDPq3ZOwF190BlNwDu8WoNWHmdhJw4d/vFLe
         shbBVCwm5zH1NZvaxLXlfOgW+LM5NgIgvq1W06Ww/k3C+iYHmgrYze2MS5Q5eV0KbZHF
         odavWT4SeeebD/z60hz57/oA/tvK7twlHQ+fkYiVF2nWVVqR5CRZ3LqwQSfO+BfXflQQ
         lEPf4LPP2rh3gwk48BsNPn4eDegxgyjUQ9c9ovRHPG8221YGmvfANfzuK4Rhrw0teux6
         a+ZOJWvaK72lPZzhtFEXBqcohnHxRwQfNLYXvASp6Zr80TOnwLklX8cjeAcz07yY7oME
         nBoA==
X-Gm-Message-State: AOAM531sdvt763CmRBpmZlc4YVCtj9teOCeTqBdyXT3W4Ry7smXq1fkB
        cc6F0p//Grirk0Wmc1pGmMhHgQ==
X-Google-Smtp-Source: ABdhPJwZIK99uXBH+5f+4PTL9HxSVwQu7nbwQqYusHIJqDDQiVz1HIHw9tUUE4Phj0PG69wIFw8dRw==
X-Received: by 2002:a37:49c4:: with SMTP id w187mr8918667qka.444.1613060689820;
        Thu, 11 Feb 2021 08:24:49 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:49 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v10 13/14] selftests/vm: gup_test: fix test flag
Date:   Thu, 11 Feb 2021 11:24:26 -0500
Message-Id: <20210211162427.618913-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In gup_test both gup_flags and test_flags use the same flags field.
This is broken.

Farther, in the actual gup_test.c all the passed gup_flags are erased and
unconditionally replaced with FOLL_WRITE.

Which means that test_flags are ignored, and code like this always
performs pin dump test:

155  			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
156  				nr = pin_user_pages(addr, nr, gup->flags,
157  						    pages + i, NULL);
158  			else
159  				nr = get_user_pages(addr, nr, gup->flags,
160  						    pages + i, NULL);
161  			break;

Add a new test_flags field, to allow raw gup_flags to work.
Add a new subcommand for DUMP_USER_PAGES_TEST to specify that pin test
should be performed.
Remove  unconditional overwriting of gup_flags via FOLL_WRITE. But,
preserve the previous behaviour where FOLL_WRITE was the default flag,
and add a new option "-W" to unset FOLL_WRITE.

Rename flags with gup_flags.

With the fix, dump works like this:

root@virtme:/# gup_test  -c
---- page #0, starting from user virt addr: 0x7f8acb9e4000
page:00000000d3d2ee27 refcount:2 mapcount:1 mapping:0000000000000000
index:0x0 pfn:0x100bcf
anon flags: 0x300000000080016(referenced|uptodate|lru|swapbacked)
raw: 0300000000080016 ffffd0e204021608 ffffd0e208df2e88 ffff8ea04243ec61
raw: 0000000000000000 0000000000000000 0000000200000000 0000000000000000
page dumped because: gup_test: dump_pages() test
DUMP_USER_PAGES_TEST: done

root@virtme:/# gup_test  -c -p
---- page #0, starting from user virt addr: 0x7fd19701b000
page:00000000baed3c7d refcount:1025 mapcount:1 mapping:0000000000000000
index:0x0 pfn:0x108008
anon flags: 0x300000000080014(uptodate|lru|swapbacked)
raw: 0300000000080014 ffffd0e204200188 ffffd0e205e09088 ffff8ea04243ee71
raw: 0000000000000000 0000000000000000 0000040100000000 0000000000000000
page dumped because: gup_test: dump_pages() test
DUMP_USER_PAGES_TEST: done

Refcount shows the difference between pin vs no-pin case.
Also change type of nr from int to long, as it counts number of pages.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup_test.c                         | 23 ++++++++++-------------
 mm/gup_test.h                         |  3 ++-
 tools/testing/selftests/vm/gup_test.c | 15 +++++++++++----
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index e3cf78e5873e..a6ed1c877679 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -94,7 +94,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 {
 	ktime_t start_time, end_time;
 	unsigned long i, nr_pages, addr, next;
-	int nr;
+	long nr;
 	struct page **pages;
 	int ret = 0;
 	bool needs_mmap_lock =
@@ -126,37 +126,34 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr = (next - addr) / PAGE_SIZE;
 		}
 
-		/* Filter out most gup flags: only allow a tiny subset here: */
-		gup->flags &= FOLL_WRITE;
-
 		switch (cmd) {
 		case GUP_FAST_BENCHMARK:
-			nr = get_user_pages_fast(addr, nr, gup->flags,
+			nr = get_user_pages_fast(addr, nr, gup->gup_flags,
 						 pages + i);
 			break;
 		case GUP_BASIC_TEST:
-			nr = get_user_pages(addr, nr, gup->flags, pages + i,
+			nr = get_user_pages(addr, nr, gup->gup_flags, pages + i,
 					    NULL);
 			break;
 		case PIN_FAST_BENCHMARK:
-			nr = pin_user_pages_fast(addr, nr, gup->flags,
+			nr = pin_user_pages_fast(addr, nr, gup->gup_flags,
 						 pages + i);
 			break;
 		case PIN_BASIC_TEST:
-			nr = pin_user_pages(addr, nr, gup->flags, pages + i,
+			nr = pin_user_pages(addr, nr, gup->gup_flags, pages + i,
 					    NULL);
 			break;
 		case PIN_LONGTERM_BENCHMARK:
 			nr = pin_user_pages(addr, nr,
-					    gup->flags | FOLL_LONGTERM,
+					    gup->gup_flags | FOLL_LONGTERM,
 					    pages + i, NULL);
 			break;
 		case DUMP_USER_PAGES_TEST:
-			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
-				nr = pin_user_pages(addr, nr, gup->flags,
+			if (gup->test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
+				nr = pin_user_pages(addr, nr, gup->gup_flags,
 						    pages + i, NULL);
 			else
-				nr = get_user_pages(addr, nr, gup->flags,
+				nr = get_user_pages(addr, nr, gup->gup_flags,
 						    pages + i, NULL);
 			break;
 		default:
@@ -187,7 +184,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 
 	start_time = ktime_get();
 
-	put_back_pages(cmd, pages, nr_pages, gup->flags);
+	put_back_pages(cmd, pages, nr_pages, gup->test_flags);
 
 	end_time = ktime_get();
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 90a6713d50eb..887ac1d5f5bc 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -21,7 +21,8 @@ struct gup_test {
 	__u64 addr;
 	__u64 size;
 	__u32 nr_pages_per_call;
-	__u32 flags;
+	__u32 gup_flags;
+	__u32 test_flags;
 	/*
 	 * Each non-zero entry is the number of the page (1-based: first page is
 	 * page 1, so that zero entries mean "do nothing") from the .addr base.
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 6c6336dd3b7f..943cc2608dc2 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -37,13 +37,13 @@ int main(int argc, char **argv)
 {
 	struct gup_test gup = { 0 };
 	unsigned long size = 128 * MB;
-	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 0;
+	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
 	unsigned long cmd = GUP_FAST_BENCHMARK;
 	int flags = MAP_PRIVATE;
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwSH")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -65,9 +65,13 @@ int main(int argc, char **argv)
 			 */
 			gup.which_pages[0] = 1;
 			break;
+		case 'p':
+			/* works only with DUMP_USER_PAGES_TEST */
+			gup.test_flags |= GUP_TEST_FLAG_DUMP_PAGES_USE_PIN;
+			break;
 		case 'F':
 			/* strtol, so you can pass flags in hex form */
-			gup.flags = strtol(optarg, 0, 0);
+			gup.gup_flags = strtol(optarg, 0, 0);
 			break;
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -93,6 +97,9 @@ int main(int argc, char **argv)
 		case 'w':
 			write = 1;
 			break;
+		case 'W':
+			write = 0;
+			break;
 		case 'f':
 			file = optarg;
 			break;
@@ -140,7 +147,7 @@ int main(int argc, char **argv)
 
 	gup.nr_pages_per_call = nr_pages;
 	if (write)
-		gup.flags |= FOLL_WRITE;
+		gup.gup_flags |= FOLL_WRITE;
 
 	fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	if (fd == -1) {
-- 
2.25.1

