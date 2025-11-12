Return-Path: <linux-kselftest+bounces-45426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CEC53512
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CB74545702
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52B33F394;
	Wed, 12 Nov 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg+Iy5FU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9E33F388;
	Wed, 12 Nov 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962133; cv=none; b=AIHisnDX8eQMOcfo1xiH3/3FuUG6p4v0RLAniEuA165N/dmdqc167PjqOkxQhSWeYMh8xM93AncBY2yEowj1uebomxC36imKh4WUTtIANvzkrTEdXTdFTiZDG3sLItJvZSkdt1wjgxf1BAdUQ8MUwQu2Kq32M+m/yxmUZ2EkQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962133; c=relaxed/simple;
	bh=Ydpo3xsumi/0AU0ywoSi8MHefmYKBp2O+zycDWbAlqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFkZLUunT4rgbt5JbRQgpxjZdjFPuF/Fu/1yFtZTYpBV0R61OOKDJ/FUBcfIfzhS6Zbi7lt77zjlWfD5Xu19HVBvm10prSxoPYnB7uHb1NKXN/r3NwgKShFQdZ+hoZ67HMUB7jbbklQ7DQvsoeFHxhPWOs8X/uZ7Mkso2LZyvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg+Iy5FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B9C113D0;
	Wed, 12 Nov 2025 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962133;
	bh=Ydpo3xsumi/0AU0ywoSi8MHefmYKBp2O+zycDWbAlqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rg+Iy5FUuR0ooXsRWmZ7hGatyVWmvp72qpBrqVWMcmB/BuD7VDSM+iqFRVTPiczNx
	 5U2G+YmR+esLUWkDZF0qWemYZXgEnh5ngPcocxe1UnXxc/yK+9gCaQkKbv8KA6KR0c
	 mq3RaDiWMH2WnEcKJxhqk3qFLKWbLn++cjQK7fF1FWAxUqjPC/pZrbIiouTc+2C6cD
	 +6X0a1lHaESDqKqwA6n0jxZ3qb0+SDXEla6TyFJthCovxImSHbJ6+l5gZ6thQH3hZi
	 hYZ0FWZrB3AgEuhyh8NJDbqStNejmwBULgg8U10Np7m5eR505QXSMQ/iRnj7mdrPUM
	 JqN0EnmuyfyXQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/9] mm/damon: rename damos->filters to damos->core_filters
Date: Wed, 12 Nov 2025 07:41:05 -0800
Message-ID: <20251112154114.66053-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters that are handled by the ops layer are linked to
damos->ops_filters.  Owing to the ops_ prefix on the name, it is easy to
understand it is for ops layer handled filters.  The other types of
filters, which are handled by the core layer, are linked to
damos->filters.  Because of the name, it is easy to confuse the list is
there for not only core layer handled ones but all filters.  Avoid such
confusions by renaming the field to core_filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h                                  | 10 +++++-----
 mm/damon/core.c                                        |  6 +++---
 mm/damon/tests/core-kunit.h                            |  4 ++--
 .../testing/selftests/damon/drgn_dump_damon_status.py  |  8 ++++----
 tools/testing/selftests/damon/sysfs.py                 |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6e3db165fe60..3813373a9200 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -492,7 +492,7 @@ struct damos_migrate_dests {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @migrate_dests:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
- * @filters:		Additional set of &struct damos_filter for &action.
+ * @core_filters:	Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
  * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
@@ -518,7 +518,7 @@ struct damos_migrate_dests {
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
- * &filters
+ * &core_filters
  *
  * The minimum entity that @action can be applied depends on the underlying
  * &struct damon_operations.  Since it may not be aligned with the core layer
@@ -562,7 +562,7 @@ struct damos {
 			struct damos_migrate_dests migrate_dests;
 		};
 	};
-	struct list_head filters;
+	struct list_head core_filters;
 	struct list_head ops_filters;
 	void *last_applied;
 	struct damos_stat stat;
@@ -872,10 +872,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	list_for_each_entry_safe(goal, next, &(quota)->goals, list)
 
 #define damos_for_each_core_filter(f, scheme) \
-	list_for_each_entry(f, &(scheme)->filters, list)
+	list_for_each_entry(f, &(scheme)->core_filters, list)
 
 #define damos_for_each_core_filter_safe(f, next, scheme) \
-	list_for_each_entry_safe(f, next, &(scheme)->filters, list)
+	list_for_each_entry_safe(f, next, &(scheme)->core_filters, list)
 
 #define damos_for_each_ops_filter(f, scheme) \
 	list_for_each_entry(f, &(scheme)->ops_filters, list)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d4cb11ced13f..aedb315b075a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -306,7 +306,7 @@ void damos_add_filter(struct damos *s, struct damos_filter *f)
 	if (damos_filter_for_ops(f->type))
 		list_add_tail(&f->list, &s->ops_filters);
 	else
-		list_add_tail(&f->list, &s->filters);
+		list_add_tail(&f->list, &s->core_filters);
 }
 
 static void damos_del_filter(struct damos_filter *f)
@@ -397,7 +397,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	 */
 	scheme->next_apply_sis = 0;
 	scheme->walk_completed = false;
-	INIT_LIST_HEAD(&scheme->filters);
+	INIT_LIST_HEAD(&scheme->core_filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
@@ -995,7 +995,7 @@ static void damos_set_filters_default_reject(struct damos *s)
 		s->core_filters_default_reject = false;
 	else
 		s->core_filters_default_reject =
-			damos_filters_default_reject(&s->filters);
+			damos_filters_default_reject(&s->core_filters);
 	s->ops_filters_default_reject =
 		damos_filters_default_reject(&s->ops_filters);
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0d2d8cda8631..4380d0312d24 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -876,7 +876,7 @@ static void damos_test_commit_filter(struct kunit *test)
 static void damos_test_help_initailize_scheme(struct damos *scheme)
 {
 	INIT_LIST_HEAD(&scheme->quota.goals);
-	INIT_LIST_HEAD(&scheme->filters);
+	INIT_LIST_HEAD(&scheme->core_filters);
 	INIT_LIST_HEAD(&scheme->ops_filters);
 }
 
@@ -1140,7 +1140,7 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	struct damos scheme;
 	struct damos_filter *target_filter, *anon_filter;
 
-	INIT_LIST_HEAD(&scheme.filters);
+	INIT_LIST_HEAD(&scheme.core_filters);
 	INIT_LIST_HEAD(&scheme.ops_filters);
 
 	damos_set_filters_default_reject(&scheme);
diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index cb4fdbe68acb..5374d18d1fa8 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -175,11 +175,11 @@ def scheme_to_dict(scheme):
         ['target_nid', int],
         ['migrate_dests', damos_migrate_dests_to_dict],
         ])
-    filters = []
+    core_filters = []
     for f in list_for_each_entry(
-            'struct damos_filter', scheme.filters.address_of_(), 'list'):
-        filters.append(damos_filter_to_dict(f))
-    dict_['filters'] = filters
+            'struct damos_filter', scheme.core_filters.address_of_(), 'list'):
+        core_filters.append(damos_filter_to_dict(f))
+    dict_['core_filters'] = core_filters
     ops_filters = []
     for f in list_for_each_entry(
             'struct damos_filter', scheme.ops_filters.address_of_(), 'list'):
diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index b34aea0a6775..b4c5ef5c4d69 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -132,7 +132,7 @@ def assert_scheme_committed(scheme, dump):
     assert_watermarks_committed(scheme.watermarks, dump['wmarks'])
     # TODO: test filters directory
     for idx, f in enumerate(scheme.core_filters.filters):
-        assert_filter_committed(f, dump['filters'][idx])
+        assert_filter_committed(f, dump['core_filters'][idx])
     for idx, f in enumerate(scheme.ops_filters.filters):
         assert_filter_committed(f, dump['ops_filters'][idx])
 
-- 
2.47.3

