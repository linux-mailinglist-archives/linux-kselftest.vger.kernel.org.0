Return-Path: <linux-kselftest+bounces-37704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EAAB0B739
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5AA3B8DD7
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7882367CB;
	Sun, 20 Jul 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf17WfHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C823AE60;
	Sun, 20 Jul 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031835; cv=none; b=ZiGSven2DYGkzvutwNN3B2I8SdYleOs+k/VqcmHGmOevUgX5E8IXbVtVyzMkjOp+rZqEYzUK1FzXKaiiatvEQysUnoPNnpSLHyagNmta2VY5jZ3Gfi9/lqd+oFv5BK/+jKt1oaA5go3Dpd73mgMCeAnzP+RgVTCrmcx5ebaY5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031835; c=relaxed/simple;
	bh=bR51yZnycsbgoJiidDex0kuSAciWqmDBKUStvRDYoIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kffvNUDwDIrPp9Q4mST8XnUrcXEcOdjIcZVh2L2InHhZgfzWibliR8bJoRsEovmyEOFJQQTr9aEysumokuSufCocXkGz9QciAsfX7wF5l6sPXAsqB9czWw9FHzYgZjako54z/CQAEkOY+ZOYCqCNXUR/CQ8wnQDb71H3e72uPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf17WfHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B771EC4CEE7;
	Sun, 20 Jul 2025 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031834;
	bh=bR51yZnycsbgoJiidDex0kuSAciWqmDBKUStvRDYoIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sf17WfHOk3fh7lglUV7XUILRreRNOxM/D0Cm6Z6PcSrE5tS5jn0RWHTWMs2OgWzU4
	 3SC16LP+Sxe1FnyDCA9lRIBGhz431LToMGG1Mnqe3LiNjUWYHuduHvzTUhqMK2xID1
	 bWw2vcPjd9+sHG/ymDtn7s4VXFsNxt8df41yl4DqzCcNde4fMDCBaiT8XlzTyw9xpx
	 dIK48SahW2jn6UqJVqeIogfYMpkWqFViHE44zrpYtE6fKl+yxHBwc12tbjgUOPca5P
	 czYKNs73Rpi2nGFIk5aE8u2iHO8Huo4ETq8qK9nJ6ol9UIAbMSXbn1vGHWxuRlgUNO
	 9RaJaJaAKbblw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 17/22] selftests/damon/sysfs.py: test DAMOS filters commitment
Date: Sun, 20 Jul 2025 10:16:47 -0700
Message-Id: <20250720171652.92309-18-sj@kernel.org>
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

Current DAMOS scheme commitment assertion is not testing DAMOS filters.
Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 584a71cbb891..a32871b9b0f2 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -76,6 +76,21 @@ def assert_migrate_dests_committed(dests, dump):
         assert_true(dump['node_id_arr'][idx] == dest.id, 'node_id', dump)
         assert_true(dump['weight_arr'][idx] == dest.weight, 'weight', dump)
 
+def assert_filter_committed(filter_, dump):
+    assert_true(filter_.type_ == dump['type'], 'type', dump)
+    assert_true(filter_.matching == dump['matching'], 'matching', dump)
+    assert_true(filter_.allow == dump['allow'], 'allow', dump)
+    # TODO: check memcg_path and memcg_id if type is memcg
+    if filter_.type_ == 'addr':
+        assert_true([filter_.addr_start, filter_.addr_end] ==
+                    dump['addr_range'], 'addr_range', dump)
+    elif filter_.type_ == 'target':
+        assert_true(filter_.target_idx == dump['target_idx'], 'target_idx',
+                    dump)
+    elif filter_.type_ == 'hugepage_size':
+        assert_true([filter_.min_, filter_.max_] == dump['sz_range'],
+                    'sz_range', dump)
+
 def assert_access_pattern_committed(pattern, dump):
     assert_true(dump['min_sz_region'] == pattern.size[0], 'min_sz_region',
                 dump)
@@ -111,6 +126,11 @@ def assert_scheme_committed(scheme, dump):
     assert_migrate_dests_committed(scheme.dests, dump['migrate_dests'])
     assert_quota_committed(scheme.quota, dump['quota'])
     assert_watermarks_committed(scheme.watermarks, dump['wmarks'])
+    # TODO: test filters directory
+    for idx, f in enumerate(scheme.core_filters.filters):
+        assert_filter_committed(f, dump['filters'][idx])
+    for idx, f in enumerate(scheme.ops_filters.filters):
+        assert_filter_committed(f, dump['ops_filters'][idx])
 
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
-- 
2.39.5

