Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820612DD8E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgLQSyv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbgLQSyu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:50 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61140C0619D9
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:02 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 19so27384493qkm.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ddKWF6rz+jusoSW85/8ZXU7qwdgQHa0ysIZMt3vGuRI=;
        b=Y+S8xlyU6M5Ma07Mnlbu0DPfFn/l4z5e0Vd6UE2ZGYZEAAz2VUjCv85uIPBF+ol81+
         x6jfcFfQXXfM7DS+Bi1SZQakCCvVq2axWBhBi5ojyTi/cRQTb6GD/pUVhV/vrnQcNmRa
         etvfj8gKeVup6AH3odppjx3qV8QIUj0njVsO0LCaHIzs8e4cpZjqpAs7q3EkhxdjKIFU
         +s2WxTbDpBRPNe2G67zpaxHjz519rXrhaV2TjNjuSBqGlt6oo06S/MB4nD3NLz8njfbS
         q5pG0fnAWGtmTtakVPZ/oEhADYpxQfD49mZ+SrYC19Vy0j5KIogPu+5mO4pJSH8DdOcd
         iRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddKWF6rz+jusoSW85/8ZXU7qwdgQHa0ysIZMt3vGuRI=;
        b=ChtYnfRo3WNnoPYKc2qpJ2ULQHqzs3VFweQNQaSrhYwBoICj7eAfic+TTYOHD0Ogph
         eei87GnMJbG6Q+INpmBudW2AF17zL8yvUSMo6+bRsXR1TozIqMaXZ0D9SQ7Cz3cfLx6X
         1Nz4AFBOsIIDXDKFJb9p3+nfZLhuygnz/oanV5Ac3ZLEvkckW5Z/Wa2VyNTtU8ZRhthw
         vBicXlWEPW+1NFniyt2xf7Rnzk8P3AmkBgHwsR3y430pwMrBb7TB9WrFiIJekbn70HmC
         b//hLaKirZqH9FC+GvmE44uYSFEUUeUycH5v/13gwNS2qnN0BTrHXoUwLX2ZR3U3DuKN
         tAgg==
X-Gm-Message-State: AOAM532yKM2syhqQAqIIxZoADPDOBOIfMFbWLMUpXqLvn6EarWA2kR98
        5+IQCb6LbjvsWLXT2WreqKloUA==
X-Google-Smtp-Source: ABdhPJxGcmSkWGboMlUiUt5OdTP7H/VwwMXdIJqjPcipfMa9wI/JO+uBMKdmiESr7baRF4zUa8CYMQ==
X-Received: by 2002:a05:620a:75a:: with SMTP id i26mr730856qki.314.1608231181586;
        Thu, 17 Dec 2020 10:53:01 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:53:00 -0800 (PST)
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
Subject: [PATCH v4 08/10] mm/gup: limit number of gup migration failures, honor failures
Date:   Thu, 17 Dec 2020 13:52:41 -0500
Message-Id: <20201217185243.3288048-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

check_and_migrate_movable_pages() does not honor isolation errors, and also
retries migration failures indefinably.

Fix both of the above issues: add a new function that checks and unpins
pages range check_and_unpin_pages().

Move the retry loop from  check_and_migrate_movable_pages() to
__gup_longterm_locked().

Rename check_and_migrate_movable_pages() as migrate_movable_pages() and
make this function accept already unpinned pages. Also, track the errors
during isolation, so they can be re-tried with a different maximum limit,
the isolation errors should be ephemeral.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 179 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 68 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1ebb7cc2fbe4..70cc8b8f67c4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1550,27 +1550,57 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 
-static long check_and_migrate_movable_pages(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long nr_pages,
-					    struct page **pages,
-					    struct vm_area_struct **vmas,
-					    unsigned int gup_flags)
-{
-	unsigned long i;
-	unsigned long step;
-	bool drain_allow = true;
-	bool migrate_allow = true;
+/*
+ * Verify that there are no unpinnable (movable) pages, if so return true.
+ * Otherwise an unpinnable pages is found return false, and unpin all pages.
+ */
+static bool check_and_unpin_pages(unsigned long nr_pages, struct page **pages,
+				  unsigned int gup_flags)
+{
+	unsigned long i, step;
+
+	for (i = 0; i < nr_pages; i += step) {
+		struct page *head = compound_head(pages[i]);
+
+		step = compound_nr(head) - (pages[i] - head);
+		if (!is_pinnable_page(head))
+			break;
+	}
+
+	if (i >= nr_pages)
+		return true;
+
+	if (gup_flags & FOLL_PIN) {
+		unpin_user_pages(pages, nr_pages);
+	} else {
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+	}
+
+	return false;
+}
+
+#define PINNABLE_MIGRATE_MAX	10
+#define PINNABLE_ISOLATE_MAX	100
+
+/*
+ * Migrate pages that cannot be pinned.  Return zero on success and error code
+ * on migration failure. If migration was successful but page isolation had
+ * failures return number of pages that failed to be isolated.
+ */
+static long migrate_movable_pages(unsigned long nr_pages, struct page **pages)
+{
+	unsigned long i, step;
 	LIST_HEAD(movable_page_list);
-	long ret = nr_pages;
+	long ret = 0;
+	long error_count = 0;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
 		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
-check_again:
-	for (i = 0; i < nr_pages;) {
-
+	lru_add_drain_all();
+	for (i = 0; i < nr_pages; i += step) {
 		struct page *head = compound_head(pages[i]);
 
 		/*
@@ -1583,62 +1613,42 @@ static long check_and_migrate_movable_pages(struct mm_struct *mm,
 		 * these entries, try to move them out if possible.
 		 */
 		if (!is_pinnable_page(head)) {
-			if (PageHuge(head))
-				isolate_huge_page(head, &movable_page_list);
-			else {
-				if (!PageLRU(head) && drain_allow) {
-					lru_add_drain_all();
-					drain_allow = false;
-				}
-
+			if (PageHuge(head)) {
+				if (!isolate_huge_page(head, &movable_page_list))
+					error_count += step;
+			} else {
 				if (!isolate_lru_page(head)) {
 					list_add_tail(&head->lru, &movable_page_list);
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_lru(head),
 							    thp_nr_pages(head));
+				} else {
+					error_count += step;
 				}
 			}
 		}
-
-		i += step;
 	}
 
 	if (!list_empty(&movable_page_list)) {
-		/*
-		 * drop the above get_user_pages reference.
-		 */
-		if (gup_flags & FOLL_PIN)
-			unpin_user_pages(pages, nr_pages);
-		else
-			for (i = 0; i < nr_pages; i++)
-				put_page(pages[i]);
+		ret = migrate_pages(&movable_page_list, alloc_migration_target,
+				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
+				    MR_LONGTERM_PIN);
+		/* Assume -EBUSY failure if some pages were not migrated */
+		if (ret > 0)
+			ret = -EBUSY;
+	}
 
-		if (migrate_pages(&movable_page_list, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_LONGTERM_PIN)) {
-			/*
-			 * some of the pages failed migration. Do get_user_pages
-			 * without migration.
-			 */
-			migrate_allow = false;
+	if (ret && !list_empty(&movable_page_list))
+		putback_movable_pages(&movable_page_list);
 
-			if (!list_empty(&movable_page_list))
-				putback_movable_pages(&movable_page_list);
-		}
-		/*
-		 * We did migrate all the pages, Try to get the page references
-		 * again migrating any pages which we failed to isolate earlier.
-		 */
-		ret = __get_user_pages_locked(mm, start, nr_pages,
-					      pages, vmas, NULL,
-					      gup_flags);
-
-		if ((ret > 0) && migrate_allow) {
-			nr_pages = ret;
-			drain_allow = true;
-			goto check_again;
-		}
-	}
+	/*
+	 * Check if there were isolation errors, if so they should not be
+	 * counted toward PINNABLE_MIGRATE_MAX, so separate them, by
+	 * returning number of pages failed to isolate.
+	 */
+	if (!ret && error_count)
+		ret = error_count;
 
 	return ret;
 }
@@ -1654,22 +1664,55 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 				  struct vm_area_struct **vmas,
 				  unsigned int gup_flags)
 {
-	unsigned long flags = 0;
+	int migrate_retry = 0;
+	int isolate_retry = 0;
+	unsigned int flags;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
-		flags = memalloc_pin_save();
+	if (!(gup_flags & FOLL_LONGTERM))
+		return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					       NULL, gup_flags);
 
-	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
-				     gup_flags);
+	/*
+	 * Without FOLL_WRITE fault handler may return zero page, which can
+	 * be in a movable zone, and also will fail to isolate during migration,
+	 * thus the longterm pin will fail.
+	 */
+	gup_flags &= FOLL_WRITE;
 
-	if (gup_flags & FOLL_LONGTERM) {
-		if (rc > 0)
-			rc = check_and_migrate_movable_pages(mm, start, rc,
-							     pages, vmas,
-							     gup_flags);
-		memalloc_pin_restore(flags);
+	flags = memalloc_pin_save();
+	/*
+	 * Migration may fail, we retry before giving up. Also, because after
+	 * migration pages[] becomes outdated, we unpin and repin all pages
+	 * in the range, so pages array is repopulated with new values.
+	 * Also, because of this we cannot retry migration failures in a loop
+	 * without pinning/unpinnig pages.
+	 */
+	for (; ; ) {
+		rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
+					     NULL, gup_flags);
+
+		/* Return if error or if all pages are pinnable */
+		if (rc <= 0 || check_and_unpin_pages(rc, pages, gup_flags))
+			break;
+
+		/* Some pages are not pinnable, migrate them */
+		rc = migrate_movable_pages(rc, pages);
+
+		/*
+		 * If there is an error, and we tried maximum number of times
+		 * bail out. Notice: we return an error code, and all pages are
+		 * unpinned
+		 */
+		if (rc < 0 && migrate_retry++ >= PINNABLE_MIGRATE_MAX) {
+			break;
+		} else if (rc > 0 && isolate_retry++ >= PINNABLE_ISOLATE_MAX) {
+			rc = -EBUSY;
+			break;
+		}
 	}
+	memalloc_pin_restore(flags);
+
 	return rc;
 }
 
-- 
2.25.1

