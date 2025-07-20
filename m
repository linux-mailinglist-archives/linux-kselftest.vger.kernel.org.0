Return-Path: <linux-kselftest+bounces-37708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36321B0B73D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3337D1766CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD623E34D;
	Sun, 20 Jul 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T32J1KG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133D23E25B;
	Sun, 20 Jul 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031839; cv=none; b=CMx3d/wOM8kb7aRH3ajbu3cK03mz/a69R3tUtRhkFjnTuqs2j0WrxQXqL10yKJB/OKbeSrWDK2kH+hgvFJ4JSB9J+UQlMTX1+NGYFnYAxr9/i8CLtawuMXzPLnOKf2b8NsDxFb2KqOydGdgJZ0Qi2A8wvkh+COTF7T2Y/2PJ838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031839; c=relaxed/simple;
	bh=YYPpAhV0Q2sUhsH9Nl2X69H/hWtTyYi5oXTnfRZyejg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWmsEFmTz4j1Jvk2nh71CO4v8l/9Bl5q2hT+NC0Pp/YgslpP/fDSIKh6uk9bmJ5nYosFA8nxAlnlt2ROSL+iWb59amkR7HoWh3xBusfuMOAFznsg0sTE+GEx7I3UffdhlhMt+7KLGE7fX4lCzo6wyqxIHswCzAJ6LrKPBrErK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T32J1KG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE9C4CEF6;
	Sun, 20 Jul 2025 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031839;
	bh=YYPpAhV0Q2sUhsH9Nl2X69H/hWtTyYi5oXTnfRZyejg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T32J1KG3uKsQ7UQl9LfjeFQlf85s4pehoO+UGWx4bBQY5nRlmlN7qO7KZMvfRS7b4
	 4dyMO2jM4w5lpwytCR171X8m6M3iBllFkbxljGFr94yNppi4LwPw6nBrPm1SCl401c
	 oXko3CDFXijQidbmNpWM9DHGgp6U7q6LlAMY2B1/7Trb0VSVKZFfhY/6yGUKSsVMVI
	 Z46Yra/A0pLVf690EfSxbr1GEnv4SnQY7bwgwemQM1MOlReu/8Xc+t4iXxEyG2TCuJ
	 SvCShf6pZyk4pbje9MQdawVE3M4ZM5D6SuJSyal8mvVhx8x3Ct8msgKY8Ogv5qxGWx
	 Jk/7MeoDM5kZg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 21/22] selftests/damon/sysfs.py: test non-default parameters runtime commit
Date: Sun, 20 Jul 2025 10:16:51 -0700
Message-Id: <20250720171652.92309-22-sj@kernel.org>
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

sysfs.py is testing only the default and minimum DAMON parameters.  Add
another test case for more non-default additional DAMON parameters
commitment on runtime.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 429865e5ac9c..b2cb178dda15 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -194,6 +194,59 @@ def main():
 
     assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
 
+    context = _damon_sysfs.DamonCtx(
+            monitoring_attrs=_damon_sysfs.DamonAttrs(
+                sample_us=100000, aggr_us=2000000,
+                intervals_goal=_damon_sysfs.IntervalsGoal(
+                    access_bp=400, aggrs=3, min_sample_us=5000,
+                    max_sample_us=10000000),
+                update_us=2000000),
+            schemes=[_damon_sysfs.Damos(
+                action='pageout',
+                access_pattern=_damon_sysfs.DamosAccessPattern(
+                    size=[4096, 2**10],
+                    nr_accesses=[3, 317],
+                    age=[5,71]),
+                quota=_damon_sysfs.DamosQuota(
+                    sz=100*1024*1024, ms=100,
+                    goals=[_damon_sysfs.DamosQuotaGoal(
+                        metric='node_mem_used_bp',
+                        target_value=9950,
+                        nid=1)],
+                    reset_interval_ms=1500,
+                    weight_sz_permil=20,
+                    weight_nr_accesses_permil=200,
+                    weight_age_permil=1000),
+                watermarks=_damon_sysfs.DamosWatermarks(
+                    metric = 'free_mem_rate', interval = 500000, # 500 ms
+                    high = 500, mid = 400, low = 50),
+                target_nid=1,
+                apply_interval_us=1000000,
+                dests=_damon_sysfs.DamosDests(
+                    dests=[_damon_sysfs.DamosDest(id=1, weight=30),
+                           _damon_sysfs.DamosDest(id=0, weight=70)]),
+                core_filters=[
+                    _damon_sysfs.DamosFilter(type_='addr', matching=True,
+                                             allow=False, addr_start=42,
+                                             addr_end=4242),
+                    ],
+                ops_filters=[
+                    _damon_sysfs.DamosFilter(type_='anon', matching=True,
+                                             allow=True),
+                    ],
+                )])
+    context.idx = 0
+    context.kdamond = kdamonds.kdamonds[0]
+    kdamonds.kdamonds[0].contexts = [context]
+    kdamonds.kdamonds[0].commit()
+
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+
     kdamonds.stop()
 
 if __name__ == '__main__':
-- 
2.39.5

