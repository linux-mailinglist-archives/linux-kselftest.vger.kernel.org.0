Return-Path: <linux-kselftest+bounces-35578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02AAE3229
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDCC1890F60
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF152192E1;
	Sun, 22 Jun 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeidBmbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15421771F;
	Sun, 22 Jun 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626216; cv=none; b=PcgUospmxy1S+CELN0UOBT8IF/cU/bqMJcHPzypgbYhjXMsnRR9HRc9jdsmhiLv/MYtAVf1TzhGCJEhAwY/GiHWbdmCeLLw7UKK/vR1ASgHSJyJ05a8phvbTWnCvm9w0JMY+D7TvJUoanfMLQJgHSWiE/P9UvXZtLrqtBbCWsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626216; c=relaxed/simple;
	bh=LQYj+y4NHRcCBylThRwztooldZRKZFHtpfiwZ2j/m2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWbNKs7IkwhY0kySDEIy+3vJQfMZjYX5Uy9zSK/GafQBoPBJAPZcaXG09ri1/lxM/OXwJk3zP9/gmPGXaGEMOzD6uxiY7nHOFFFd5BVXLk6MxLaTlS3L3wy/gvtQuiVxMEk/o+/1ce05ZZK1qwdiQyskNbgqAp/kfny+QnOfqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeidBmbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A51C4CEE3;
	Sun, 22 Jun 2025 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626215;
	bh=LQYj+y4NHRcCBylThRwztooldZRKZFHtpfiwZ2j/m2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeidBmbxkU6ngF7IBtFVu+zih2sxcShx+26Ils18iTjjo3npHIk8HmWLSrAod6gSV
	 qLvYEF7/ME/PMIqWbWeYPkCpXjnBlZi1lQiA8lpj8f7ZbGpoySZfprOuVjfo/to63d
	 GLIyKZZMTU+NwnwXouQCAw07vzo90OLAvtzdYCsTgF18tj13yf3H+bUH6KbZHdsYIt
	 YV1crGBjVPxVHSrNWcEE/bLFKLiLbRNuLtmQBqxdqfwP0346HCVNL5x3qEWnrrI91o
	 G6xKbqLroOpTioNGy8+meoe3rkSJmqwYWhxO9AM10wvKeU+nyYmroaaR000kOKX33q
	 bd5dQ9/O1UyFg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] selftests/damon: add drgn script for extracting damon status
Date: Sun, 22 Jun 2025 14:03:25 -0700
Message-Id: <20250622210330.40490-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622210330.40490-1-sj@kernel.org>
References: <20250622210330.40490-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'drgn' is a useful tool for extracting kernel internal data structures
such as DAMON's parameter and running status.  Add a 'drgn' script that
extracts such DAMON internal data at runtime, for using it as a tool for
seeing if a test input has made expected results in the kernel.

The script saves or prints out the DAMON internal data as a json file or
string.  This is for making use of it not very depends on 'drgn'.  If
'drgn' is not available on a test setup and we find alternative tools
for doing that, the json-based tests can be updated to use an
alternative tool in future.

Note that the script is tested with 'drgn v0.0.22'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/drgn_dump_damon_status.py | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100755 tools/testing/selftests/damon/drgn_dump_damon_status.py

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
new file mode 100755
index 000000000000..333a0d0c4bff
--- /dev/null
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -0,0 +1,161 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0
+
+'''
+Read DAMON context data and dump as a json string.
+'''
+import drgn
+from drgn import FaultError, NULL, Object, cast, container_of, execscript, offsetof, reinterpret, sizeof
+from drgn.helpers.common import *
+from drgn.helpers.linux import *
+
+import json
+import sys
+
+if "prog" not in globals():
+    try:
+        prog = drgn.get_default_prog()
+    except drgn.NoDefaultProgramError:
+        prog = drgn.program_from_kernel()
+        drgn.set_default_prog(prog)
+
+def to_dict(object, attr_name_converter):
+    d = {}
+    for attr_name, converter in attr_name_converter:
+        d[attr_name] = converter(getattr(object, attr_name))
+    return d
+
+def intervals_goal_to_dict(goal):
+    return to_dict(goal, [
+        ['access_bp', int],
+        ['aggrs', int],
+        ['min_sample_us', int],
+        ['max_sample_us', int],
+        ])
+
+def attrs_to_dict(attrs):
+    return to_dict(attrs, [
+        ['sample_interval', int],
+        ['aggr_interval', int],
+        ['ops_update_interval', int],
+        ['intervals_goal', intervals_goal_to_dict],
+        ['min_nr_regions', int],
+        ['max_nr_regions', int],
+        ])
+
+def addr_range_to_dict(addr_range):
+    return to_dict(addr_range, [
+        ['start', int],
+        ['end', int],
+        ])
+
+def region_to_dict(region):
+    return to_dict(region, [
+        ['ar', addr_range_to_dict],
+        ['sampling_addr', int],
+        ['nr_accesses', int],
+        ['nr_accesses_bp', int],
+        ['age', int],
+        ])
+
+def regions_to_list(regions):
+    return [region_to_dict(r)
+            for r in list_for_each_entry(
+                'struct damon_region', regions.address_of_(), 'list')]
+
+def target_to_dict(target):
+    return to_dict(target, [
+        ['pid', int],
+        ['nr_regions', int],
+        ['regions_list', regions_to_list],
+        ])
+
+def targets_to_list(targets):
+    return [target_to_dict(t)
+            for t in list_for_each_entry(
+                'struct damon_target', targets.address_of_(), 'list')]
+
+def damos_access_pattern_to_dict(pattern):
+    return to_dict(pattern, [
+        ['min_sz_region', int],
+        ['max_sz_region', int],
+        ['min_nr_accesses', int],
+        ['max_nr_accesses', int],
+        ['min_age_region', int],
+        ['max_age_region', int],
+        ])
+
+def damos_quota_goal_to_dict(goal):
+    return to_dict(goal, [
+        ['metric', int],
+        ['target_value', int],
+        ['current_value', int],
+        ['last_psi_total', int],
+        ['nid', int],
+        ])
+
+def damos_quota_goals_to_list(goals):
+    return [damos_quota_goal_to_dict(g)
+            for g in list_for_each_entry(
+                'struct damos_quota_goal', goals.address_of_(), 'list')]
+
+def damos_quota_to_dict(quota):
+    return to_dict(quota, [
+        ['reset_interval', int],
+        ['ms', int], ['sz', int],
+        ['goals', damos_quota_goals_to_list],
+        ['esz', int],
+        ['weight_sz', int],
+        ['weight_nr_accesses', int],
+        ['weight_age', int],
+        ])
+
+def damos_watermarks_to_dict(watermarks):
+    return to_dict(watermarks, [
+        ['metric', int],
+        ['interval', int],
+        ['high', int], ['mid', int], ['low', int],
+        ])
+
+def scheme_to_dict(scheme):
+    return to_dict(scheme, [
+        ['pattern', damos_access_pattern_to_dict],
+        ['action', int],
+        ['apply_interval_us', int],
+        ['quota', damos_quota_to_dict],
+        ['wmarks', damos_watermarks_to_dict],
+        ['target_nid', int],
+        ])
+
+def schemes_to_list(schemes):
+    return [scheme_to_dict(s)
+            for s in list_for_each_entry(
+                'struct damos', schemes.address_of_(), 'list')]
+
+def damon_ctx_to_dict(ctx):
+    return to_dict(ctx, [
+        ['attrs', attrs_to_dict],
+        ['adaptive_targets', targets_to_list],
+        ['schemes', schemes_to_list],
+        ])
+
+def main():
+    if len(sys.argv) < 3:
+        print('Usage: %s <kdamond pid> <file>' % sys.argv[0])
+        exit(1)
+
+    pid = int(sys.argv[1])
+    file_to_store = sys.argv[2]
+
+    kthread_data = cast('struct kthread *',
+                        find_task(prog, pid).worker_private).data
+    ctx = cast('struct damon_ctx *', kthread_data)
+    status = {'contexts': [damon_ctx_to_dict(ctx)]}
+    if file_to_store == 'stdout':
+        print(json.dumps(status, indent=4))
+    else:
+        with open(file_to_store, 'w') as f:
+            json.dump(status, f, indent=4)
+
+if __name__ == '__main__':
+    main()
-- 
2.39.5

