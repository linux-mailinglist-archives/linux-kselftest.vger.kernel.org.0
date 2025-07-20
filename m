Return-Path: <linux-kselftest+bounces-37698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175CB0B727
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E449C18989F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED38235056;
	Sun, 20 Jul 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMXsHj0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039522156D;
	Sun, 20 Jul 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031828; cv=none; b=oC2uaWC+FgzMcrpnhcdxPVwX5NiZnt27pBjZZ9YMfNpwGQYnfzzPyV+VTYvxluDBPsSyFH+qtlZ8CP8E1GnXfijDb4p2f3SPaYbENiQ8yPY1JBfk+eEhmc1UcRp5u49YB+QqwNmSRP/GSFyGB7FYzc2OvpRQGfS+mdIwK/HpJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031828; c=relaxed/simple;
	bh=Wceb9ArDixVkfJWULunRIrNmsNWtcFz3oVNo4mLAvbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1u3L7W3U1XkjFd7tNCF/tK/vcKGLx994VCJWN1fdDMJRrss846dy2DRrQ5UjezdPQffuHqYhRFImdMsGcptCyQ2z6amFHqUPJ0QMviSFd1nwF6It2z2VfoQaTc2tPW7GN9x2m1ftcomzAXeuPUGskpvIAB7FDwTN0tEsmE6ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMXsHj0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B301C4CEF6;
	Sun, 20 Jul 2025 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031828;
	bh=Wceb9ArDixVkfJWULunRIrNmsNWtcFz3oVNo4mLAvbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMXsHj0YZz9us6RSod5WaJviNIlobPKj1lkhfkBHxblgcViTGP4mKwPfYok4YJRH1
	 yr8InuUOE2+bwBLQZCqD+Z0a3ZFu0Kgo/sQsx5Kkno92OMf2bmCSl8qkA2DFXiHc/z
	 /96chNgKboautKIjJDGHr66W/6WTpbbjH5dihwfwGVNv+UaYJHF6oXwgDt9Im4I6RS
	 qw1pAQqYVxDfoY1aLWI2UVpQuPBENBRp82xH1vTRLLli2Cju8u5svTmyk73mqJ2lMb
	 JexlRm79DsDg8phBdspk0MU5dI3QO8iAYNvG0vU73LoYsPBYmZ6/f/9E/AHQdL/lP4
	 KM/Gv/w748UZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/22] selftests/damon/drgn_dump_damon_status: dump DAMOS filters
Date: Sun, 20 Jul 2025 10:16:41 -0700
Message-Id: <20250720171652.92309-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status.py is a script for dumping DAMON internal status
in json format.  It is being used for seeing if DAMON parameters that
are set using _damon_sysfs.py are actually passed to DAMON in the kernel
space.  It is, however, not dumping full DAMON internal status, and it
makes increasing test coverage difficult.  Add damos filters dumping for
more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/drgn_dump_damon_status.py | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index cf5d492670d8..7233369a3a44 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -135,8 +135,37 @@ def damos_migrate_dests_to_dict(dests):
             'nr_dests': nr_dests,
             }
 
+def damos_filter_to_dict(damos_filter):
+    filter_type_keyword = {
+            0: 'anon',
+            1: 'active',
+            2: 'memcg',
+            3: 'young',
+            4: 'hugepage_size',
+            5: 'unmapped',
+            6: 'addr',
+            7: 'target'
+            }
+    dict_ = {
+            'type': filter_type_keyword[int(damos_filter.type)],
+            'matching': bool(damos_filter.matching),
+            'allow': bool(damos_filter.allow),
+            }
+    type_ = dict_['type']
+    if type_ == 'memcg':
+        dict_['memcg_id'] = int(damos_filter.memcg_id)
+    elif type_ == 'addr':
+        dict_['addr_range'] = [int(damos_filter.addr_range.start),
+                               int(damos_filter.addr_range.end)]
+    elif type_ == 'target':
+        dict_['target_idx'] = int(damos_filter.target_idx)
+    elif type_ == 'hugeapge_size':
+        dict_['sz_range'] = [int(damos_filter.sz_range.min),
+                             int(damos_filter.sz_range.max)]
+    return dict_
+
 def scheme_to_dict(scheme):
-    return to_dict(scheme, [
+    dict_ = to_dict(scheme, [
         ['pattern', damos_access_pattern_to_dict],
         ['action', int],
         ['apply_interval_us', int],
@@ -145,6 +174,18 @@ def scheme_to_dict(scheme):
         ['target_nid', int],
         ['migrate_dests', damos_migrate_dests_to_dict],
         ])
+    filters = []
+    for f in list_for_each_entry(
+            'struct damos_filter', scheme.filters.address_of_(), 'list'):
+        filters.append(damos_filter_to_dict(f))
+    dict_['filters'] = filters
+    ops_filters = []
+    for f in list_for_each_entry(
+            'struct damos_filter', scheme.ops_filters.address_of_(), 'list'):
+        ops_filters.append(damos_filter_to_dict(f))
+    dict_['ops_filters'] = ops_filters
+
+    return dict_
 
 def schemes_to_list(schemes):
     return [scheme_to_dict(s)
-- 
2.39.5

