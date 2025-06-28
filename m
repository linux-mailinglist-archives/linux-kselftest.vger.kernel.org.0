Return-Path: <linux-kselftest+bounces-36060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9722EAEC876
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ECC3A1606
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56EC246BBD;
	Sat, 28 Jun 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSNgq90N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87224501B;
	Sat, 28 Jun 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126673; cv=none; b=WXRyofDbv2fBVTH2JnsBzKTN/3I4qN5osy/NsORGOicLuvOCXkIGvTpBMxTq6Mw2GU0yLN+5e12bXNHhL31fETv1QxNJ2+D7bK7IWCyKKdaJup1zlpVUA4wqwO203s7QRtI+qiSs7QD4Uzo2J6AL7CqLY7WFb59S4DD5hq3K+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126673; c=relaxed/simple;
	bh=LQYj+y4NHRcCBylThRwztooldZRKZFHtpfiwZ2j/m2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udRS7Duzhc+RMI+kmWt3gPQBt8blwM+88wXTF6mdAas1sQu8AyJhgTRXR7Ei7dR1wjWrNWI1thYPoT1k+YUyDtsMTVlE9D2pzR9uV6j0Jvm+Ovg7JFj7DvOJg/4q2lKh+DUozg/wZimdvN2CPNzH8xiL0fW1DKAQZ1rZjdfAMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSNgq90N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B30C4AF09;
	Sat, 28 Jun 2025 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126673;
	bh=LQYj+y4NHRcCBylThRwztooldZRKZFHtpfiwZ2j/m2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSNgq90NiT1h2PlAU76fonhPwvTnVpXfKhea107Zxg/WgkS1m5B0HUbuX8v6xv3pc
	 /Ks1xCGwDd+yjkcOLjTlVLxZ9PQrRHbGjrSPjnj6452nybIeFmYt88tSn8z2xrDqRu
	 97akYhFZwrTKu5jVQA6TBZdf9PSSZ+ldmVhvXb+FxakSVTKDCXLQy9PipwzrOj/dTP
	 jVa3PNyMtH4+Kzo8dFOsubWQExw6shD4CjdasLe5GCiRHNMeTS8whyf6uCrKbfHPNL
	 0Kp1LVjAQtRb17pRT1e4SZ7Atee/57JankmYtNoCvtIXmwyw9GtYx5gxr43oLtfofo
	 tbqWAxBs7Q+CQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] selftests/damon: add drgn script for extracting damon status
Date: Sat, 28 Jun 2025 09:04:23 -0700
Message-Id: <20250628160428.53115-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628160428.53115-1-sj@kernel.org>
References: <20250628160428.53115-1-sj@kernel.org>
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

