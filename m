Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A892DD8D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgLQSy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbgLQSyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:25 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAE6C0619DD
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:04 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 19so27384602qkm.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=COwDysI4bZZEKCXTQQYU3uK6Y/IsqJ6hL7YDBk3cg/c=;
        b=i7KuMhOyFcM+TyMj/X77dnuv0gWjob2WfM13WrvtO33cVvoh/4vOeACCtT/GpbiUNL
         WO3cYvr/PjFoEbREscOUN33YZwSNmecJNT1hQZEwCrnE+LoCOsLd3GzPR/ekMxvxcxfe
         kqt1qmz1bAXeIiqNlba5Jr0x++uAYRO12MC05X/E7DusvggUAxCZl7bmMdqGIH/EBYjy
         qOeYnM9cHS2yK+r/tRFdPdSo1tUxlF7n+EwzXOQ36HGnec+7ByAT1kdBfWxH22M2MY+v
         gfKGdjmZc4u1KqDuHwGN3NNZuUWdXLv/RbdNcWxp0Y9dsQDyPupyuS0RWe1BDfl/xiB5
         m9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COwDysI4bZZEKCXTQQYU3uK6Y/IsqJ6hL7YDBk3cg/c=;
        b=flZbtGq9PbwszuAIMb2xodMuCXckVWCVtF0rWbL+W6HPw1ngOdECAip6bfGGofJw6s
         5Qe5P7ogWw9/YJjOzWzBAXCvVRJPxlCojAjz+HPw4T3C6F2N9/HIkArdnsyrNuqqHh7D
         vru6gdO8e7EZE5mlXG5/5U8ng6Drte5C8hb7VAgFZPxd+r+kTFFPXBVA/L3lHE8OzdM/
         /8UZob7qYhwL7CkLR5aZClEJLgKAxe9+brkyXQAfGl9qdGN5wUwewiW0CC6/E/xxcpMW
         6zyhBriD5yu3QDivsC/YhdlqZDbleQDxFcc2WyYxBPXwfEL1s9JTJW3uYlpHxzJRDBS/
         EI2w==
X-Gm-Message-State: AOAM530qCIVrifuI73ADFysSlb0wvy8OGOUlIgJo3LauPoVKO++ZrbLf
        GU0ifpSxIr3OAVtMWe1KXSPf3A==
X-Google-Smtp-Source: ABdhPJzWxK7UMeCHrIoSiUT4ebH815ATLU90gFdXWdc76eFy1XhzXtvmWIRlIeGJ1QgQ1s2bBj8tEg==
X-Received: by 2002:a37:a241:: with SMTP id l62mr691371qke.482.1608231183357;
        Thu, 17 Dec 2020 10:53:03 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:53:02 -0800 (PST)
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
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 09/10] selftests/vm: test flag is broken
Date:   Thu, 17 Dec 2020 13:52:42 -0500
Message-Id: <20201217185243.3288048-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In gup_test both gup_flags and test_flags use the same flags field.
This is broken, because gup_flags can be passed as raw value (via -F hex),
which can overwrite all the test flags.

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
---
 mm/gup_test.c                         |  9 +++------
 mm/gup_test.h                         |  1 +
 tools/testing/selftests/vm/gup_test.c | 11 +++++++++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index e3cf78e5873e..24c70c5814ba 100644
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
@@ -126,9 +126,6 @@ static int __gup_test_ioctl(unsigned int cmd,
 			nr = (next - addr) / PAGE_SIZE;
 		}
 
-		/* Filter out most gup flags: only allow a tiny subset here: */
-		gup->flags &= FOLL_WRITE;
-
 		switch (cmd) {
 		case GUP_FAST_BENCHMARK:
 			nr = get_user_pages_fast(addr, nr, gup->flags,
@@ -152,7 +149,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 					    pages + i, NULL);
 			break;
 		case DUMP_USER_PAGES_TEST:
-			if (gup->flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
+			if (gup->test_flags & GUP_TEST_FLAG_DUMP_PAGES_USE_PIN)
 				nr = pin_user_pages(addr, nr, gup->flags,
 						    pages + i, NULL);
 			else
@@ -187,7 +184,7 @@ static int __gup_test_ioctl(unsigned int cmd,
 
 	start_time = ktime_get();
 
-	put_back_pages(cmd, pages, nr_pages, gup->flags);
+	put_back_pages(cmd, pages, nr_pages, gup->test_flags);
 
 	end_time = ktime_get();
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 90a6713d50eb..b1b376b5d3b2 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -22,6 +22,7 @@ struct gup_test {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u32 test_flags;
 	/*
 	 * Each non-zero entry is the number of the page (1-based: first page is
 	 * page 1, so that zero entries mean "do nothing") from the .addr base.
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 6c6336dd3b7f..42c71483729f 100644
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
@@ -65,6 +65,10 @@ int main(int argc, char **argv)
 			 */
 			gup.which_pages[0] = 1;
 			break;
+		case 'p':
+			/* works only with DUMP_USER_PAGES_TEST */
+			gup.test_flags |= GUP_TEST_FLAG_DUMP_PAGES_USE_PIN;
+			break;
 		case 'F':
 			/* strtol, so you can pass flags in hex form */
 			gup.flags = strtol(optarg, 0, 0);
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
-- 
2.25.1

