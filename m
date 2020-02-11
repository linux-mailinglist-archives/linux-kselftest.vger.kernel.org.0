Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5851159B34
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 22:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBKVc1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 16:32:27 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46536 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgBKVbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 16:31:50 -0500
Received: by mail-pf1-f202.google.com with SMTP id c185so18913pfb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oB/Ey/8TQSLxLE4nxrYY+XZpQi+kp38f/+tIBytEV40=;
        b=sp6WphDYXb2X3mQBQgW3dvcrJHj8vSV5lrKYnswHU1iTTWS1In4+V5pQeYClvKpLer
         d0BwO/zKCma7B9BnnZ3OphIRrqDXnE5kfyQjE9dS3ztTsy6bAgHP2LI2YT38Tkd3jQva
         xT6hS13N7dUcNC41YLFkqp/FYvN1CThSOT7Z1/w5JKEuumlic131LbCF6KPyz/Usw+ua
         RcPKq8hnVfVKouREexBbABUIiH4NlcXs3TlT80tnVidlmJYkFKa54QzreQGukT9dtaH0
         tz6OF1cnkEvQcznXAh27Z3mcoX0TwjuPH99zONL7Qrb+fkTnKxnACNvZ8tFo0w9IQ0O2
         hK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oB/Ey/8TQSLxLE4nxrYY+XZpQi+kp38f/+tIBytEV40=;
        b=RuDU8CTqPmdl8ZUX39CLasSYENviVtMTw+ESsuyIgCA1+FD6+Moc91vwJ9cUQYZ0DH
         ahCNHCC4HFET/8dtunruNlpx9KNFAyEGogdZze5EyInZlsc0sV+p+dqwMEepn+VrQLP7
         +VvGBJS0e3C76moWpCxU6LDKK6zEuFtflgy2qGgTm8jPJh2ESJ1jfUPf9g3CrIXWhaP2
         3qeQGHQEFKSJlmV/eXXj/nZDMrXdpOK2aldLzeGjvyBk/xqiddATZZjjeGO1NQJndpBB
         jAsh9i86sunPuEyLn12rxsfysxYZWT1U68Mx3Qv3Vl42kp2QZDdHpoI6HZb9Pn2sBu2Y
         2zJQ==
X-Gm-Message-State: APjAAAUAdHwts/OXGySj75ifnZlauWMc9xGYvQD4DyCg9JK+I0JWN8Eo
        d2Ts98O89pIivxuOGPiabeM3cUz5JC6ByiaF/w==
X-Google-Smtp-Source: APXvYqzNebfevMqBhFvJCd98JV9tuMRt4HShdr1sq3pyLR3ZFgEQaj3XK4BOsxd8u9u0t3V/Wd77eghpjxPim/0vRg==
X-Received: by 2002:a63:5947:: with SMTP id j7mr9206537pgm.48.1581456709223;
 Tue, 11 Feb 2020 13:31:49 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:21 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
usage or hugetlb reservation counter.

Adds a new interface to uncharge a hugetlb_cgroup counter via
hugetlb_cgroup_uncharge_counter.

Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v12:
- Instead of true/false param for rsvd or non-rsvd calls, now there is:
hugetlb_cgroup_*() call for non-rsvd
hugetlb_cgroup_*_rsvd() call for rsvd
__hugetlb_cgroup_*(, bool) for both.
- Removed review tags as this patch changed quite a bit.

Changes in v11:
- Changed all 'reserved' or 'reservation' to 'rsvd' to reflect the user
interface.
- Expanded comment that describes tail pages usage.
facing naming.

Changes in v10:
- Added missing VM_BUG_ON

Changes in V9:
- Fixed HUGETLB_CGROUP_MIN_ORDER.
- Minor variable name update.
- Moved some init/cleanup code from later patches in the series to this
patch.
- Updated reparenting of reservation accounting.

---
 include/linux/hugetlb_cgroup.h | 123 +++++++++++++++++++----
 mm/hugetlb.c                   |   2 +
 mm/hugetlb_cgroup.c            | 174 +++++++++++++++++++++++++++------
 3 files changed, 251 insertions(+), 48 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 063962f6dfc6a..5443f4548d523 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -20,32 +20,64 @@
 struct hugetlb_cgroup;
 /*
  * Minimum page order trackable by hugetlb cgroup.
- * At least 3 pages are necessary for all the tracking information.
+ * At least 4 pages are necessary for all the tracking information.
+ * The second tail page (hpage[2]) is the fault usage cgroup.
+ * The third tail page (hpage[3]) is the reservation usage cgroup.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2

 #ifdef CONFIG_CGROUP_HUGETLB

-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *
+__hugetlb_cgroup_from_page(struct page *page, bool rsvd)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-	return (struct hugetlb_cgroup *)page[2].private;
+	if (rsvd)
+		return (struct hugetlb_cgroup *)page[3].private;
+	else
+		return (struct hugetlb_cgroup *)page[2].private;
+}
+
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+{
+	return __hugetlb_cgroup_from_page(page, false);
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline struct hugetlb_cgroup *
+hugetlb_cgroup_from_page_rsvd(struct page *page)
+{
+	return __hugetlb_cgroup_from_page(page, true);
+}
+
+static inline int __set_hugetlb_cgroup(struct page *page,
+				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);

 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
-	page[2].private	= (unsigned long)h_cg;
+	if (rsvd)
+		page[3].private = (unsigned long)h_cg;
+	else
+		page[2].private = (unsigned long)h_cg;
 	return 0;
 }

+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg)
+{
+	return __set_hugetlb_cgroup(page, h_cg, false);
+}
+
+static inline int set_hugetlb_cgroup_rsvd(struct page *page,
+					  struct hugetlb_cgroup *h_cg)
+{
+	return __set_hugetlb_cgroup(page, h_cg, true);
+}
+
 static inline bool hugetlb_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(hugetlb_cgrp_subsys);
@@ -53,13 +85,27 @@ static inline bool hugetlb_cgroup_disabled(void)

 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 					struct hugetlb_cgroup **ptr);
+extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
+					     struct hugetlb_cgroup **ptr);
 extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					 struct hugetlb_cgroup *h_cg,
 					 struct page *page);
+extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
+					      struct hugetlb_cgroup *h_cg,
+					      struct page *page);
 extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 					 struct page *page);
+extern void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
+					      struct page *page);
+
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg);
+extern void hugetlb_cgroup_uncharge_cgroup_rsvd(int idx, unsigned long nr_pages,
+						struct hugetlb_cgroup *h_cg);
+extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+					    unsigned long nr_pages,
+					    struct cgroup_subsys_state *css);
+
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 				   struct page *newhpage);
@@ -70,8 +116,26 @@ static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
 	return NULL;
 }

-static inline
-int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
+static inline struct hugetlb_cgroup *
+hugetlb_cgroup_from_page_resv(struct page *page)
+{
+	return NULL;
+}
+
+static inline struct hugetlb_cgroup *
+hugetlb_cgroup_from_page_rsvd(struct page *page)
+{
+	return NULL;
+}
+
+static inline int set_hugetlb_cgroup(struct page *page,
+				     struct hugetlb_cgroup *h_cg)
+{
+	return 0;
+}
+
+static inline int set_hugetlb_cgroup_rsvd(struct page *page,
+					  struct hugetlb_cgroup *h_cg)
 {
 	return 0;
 }
@@ -81,28 +145,51 @@ static inline bool hugetlb_cgroup_disabled(void)
 	return true;
 }

-static inline int
-hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup **ptr)
+static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
+					       struct hugetlb_cgroup **ptr)
 {
 	return 0;
 }

-static inline void
-hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
-			     struct hugetlb_cgroup *h_cg,
-			     struct page *page)
+static inline int hugetlb_cgroup_charge_cgroup_rsvd(int idx,
+						    unsigned long nr_pages,
+						    struct hugetlb_cgroup **ptr)
+{
+	return 0;
+}
+
+static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
+						struct hugetlb_cgroup *h_cg,
+						struct page *page)
 {
 }

 static inline void
-hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)
+hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
+				  struct hugetlb_cgroup *h_cg,
+				  struct page *page)
+{
+}
+
+static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
+						struct page *page)
+{
+}
+
+static inline void hugetlb_cgroup_uncharge_page_rsvd(int idx,
+						     unsigned long nr_pages,
+						     struct page *page)
+{
+}
+static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
+						  unsigned long nr_pages,
+						  struct hugetlb_cgroup *h_cg)
 {
 }

 static inline void
-hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-			       struct hugetlb_cgroup *h_cg)
+hugetlb_cgroup_uncharge_cgroup_rsvd(int idx, unsigned long nr_pages,
+				    struct hugetlb_cgroup *h_cg)
 {
 }

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec4..357817e33fb34 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1069,6 +1069,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1254,6 +1255,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL);
+	set_hugetlb_cgroup_rsvd(page, NULL);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 08b2adcdb5c1c..b8246389fb153 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -61,14 +61,26 @@ struct hugetlb_cgroup {
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;

 static inline struct page_counter *
-hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
-				   bool rsvd)
+__hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
+				     bool rsvd)
 {
 	if (rsvd)
 		return &h_cg->rsvd_hugepage[idx];
 	return &h_cg->hugepage[idx];
 }

+static inline struct page_counter *
+hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx)
+{
+	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, false);
+}
+
+static inline struct page_counter *
+hugetlb_cgroup_counter_from_cgroup_rsvd(struct hugetlb_cgroup *h_cg, int idx)
+{
+	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, true);
+}
+
 static inline
 struct hugetlb_cgroup *hugetlb_cgroup_from_css(struct cgroup_subsys_state *s)
 {
@@ -97,8 +109,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	int idx;

 	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
-		if (page_counter_read(&h_cg->hugepage[idx]))
+		if (page_counter_read(
+			    hugetlb_cgroup_counter_from_cgroup(h_cg, idx)) ||
+		    page_counter_read(hugetlb_cgroup_counter_from_cgroup_rsvd(
+			    h_cg, idx))) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -109,18 +125,34 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;

 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *counter = &h_cgroup->hugepage[idx];
-		struct page_counter *parent = NULL;
+		struct page_counter *fault_parent = NULL;
+		struct page_counter *rsvd_parent = NULL;
 		unsigned long limit;
 		int ret;

-		if (parent_h_cgroup)
-			parent = &parent_h_cgroup->hugepage[idx];
-		page_counter_init(counter, parent);
+		if (parent_h_cgroup) {
+			fault_parent = hugetlb_cgroup_counter_from_cgroup(
+				parent_h_cgroup, idx);
+			rsvd_parent = hugetlb_cgroup_counter_from_cgroup_rsvd(
+				parent_h_cgroup, idx);
+		}
+		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
+								     idx),
+				  fault_parent);
+		page_counter_init(
+			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
+			rsvd_parent);

 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_set_max(counter, limit);
+
+		ret = page_counter_set_max(
+			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
+			limit);
+		VM_BUG_ON(ret);
+		ret = page_counter_set_max(
+			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
+			limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -150,7 +182,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }

-
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -227,8 +258,9 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
 		 !hugetlb_cgroup_is_root(hugetlb));
 }

-int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
-				 struct hugetlb_cgroup **ptr)
+static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
+					  struct hugetlb_cgroup **ptr,
+					  bool rsvd)
 {
 	int ret = 0;
 	struct page_counter *counter;
@@ -251,51 +283,104 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();

-	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
-				     &counter)) {
+	if (!page_counter_try_charge(
+		    __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
+		    nr_pages, &counter)) {
 		ret = -ENOMEM;
 		hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
 			      HUGETLB_MAX);
+		css_put(&h_cg->css);
+		goto done;
 	}
-	css_put(&h_cg->css);
+	/* Reservations take a reference to the css because they do not get
+	 * reparented.
+	 */
+	if (!rsvd)
+		css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
 	return ret;
 }

+int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
+				 struct hugetlb_cgroup **ptr)
+{
+	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, ptr, false);
+}
+
+int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
+				      struct hugetlb_cgroup **ptr)
+{
+	return __hugetlb_cgroup_charge_cgroup(idx, nr_pages, ptr, true);
+}
+
 /* Should be called with hugetlb_lock held */
-void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
-				  struct hugetlb_cgroup *h_cg,
-				  struct page *page)
+static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
+					   struct hugetlb_cgroup *h_cg,
+					   struct page *page, bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;

-	set_hugetlb_cgroup(page, h_cg);
+	__set_hugetlb_cgroup(page, h_cg, rsvd);
 	return;
 }

+void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
+				  struct hugetlb_cgroup *h_cg,
+				  struct page *page)
+{
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, false);
+}
+
+void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
+				       struct hugetlb_cgroup *h_cg,
+				       struct page *page)
+{
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, true);
+}
+
 /*
  * Should be called with hugetlb_lock held
  */
-void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-				  struct page *page)
+static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
+					   struct page *page, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;

 	if (hugetlb_cgroup_disabled())
 		return;
 	lockdep_assert_held(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(page);
+	h_cg = __hugetlb_cgroup_from_page(page, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	set_hugetlb_cgroup(page, NULL);
-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
+	__set_hugetlb_cgroup(page, NULL, rsvd);
+
+	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
+								   rsvd),
+			      nr_pages);
+
+	if (rsvd)
+		css_put(&h_cg->css);
+
 	return;
 }

-void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-				    struct hugetlb_cgroup *h_cg)
+void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
+				  struct page *page)
+{
+	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, false);
+}
+
+void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
+				       struct page *page)
+{
+	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, true);
+}
+
+static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
+					     struct hugetlb_cgroup *h_cg,
+					     bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
@@ -303,8 +388,35 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
 		return;

-	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
-	return;
+	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
+								   rsvd),
+			      nr_pages);
+
+	if (rsvd)
+		css_put(&h_cg->css);
+}
+
+void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
+				    struct hugetlb_cgroup *h_cg)
+{
+	__hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg, false);
+}
+
+void hugetlb_cgroup_uncharge_cgroup_rsvd(int idx, unsigned long nr_pages,
+					 struct hugetlb_cgroup *h_cg)
+{
+	__hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg, true);
+}
+
+void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
+				     unsigned long nr_pages,
+				     struct cgroup_subsys_state *css)
+{
+	if (hugetlb_cgroup_disabled() || !p || !css)
+		return;
+
+	page_counter_uncharge(p, nr_pages);
+	css_put(css);
 }

 enum {
@@ -419,7 +531,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
 		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
+			__hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
 			nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
@@ -675,6 +787,7 @@ void __init hugetlb_cgroup_file_init(void)
 void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);

 	if (hugetlb_cgroup_disabled())
@@ -683,10 +796,11 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
 	spin_lock(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_page(oldhpage);
+	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
 	set_hugetlb_cgroup(oldhpage, NULL);

 	/* move the h_cg details to new cgroup */
-	set_hugetlb_cgroup(newhpage, h_cg);
+	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	return;
--
2.25.0.225.g125e21ebc7-goog
