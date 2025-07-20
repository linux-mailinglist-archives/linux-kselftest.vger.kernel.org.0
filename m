Return-Path: <linux-kselftest+bounces-37707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57507B0B740
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1D13BAE43
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FC23D2AF;
	Sun, 20 Jul 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6FYk7+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C221CA14;
	Sun, 20 Jul 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031838; cv=none; b=Hbomb6jx2mBYib81pki2PyP/U4QuRk290KbKTcBEGjTdk60aVwEtDX5UQSf5+pGz1j/jHeoENs+RCQDJbNwABOuup/wuOx7cr4f4NwaVZPyE4LiiYx43NBZMRjIg59lgqxURkl3Jepb1VjA3nSt/fE099J7pM/g2bcNa9iZwa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031838; c=relaxed/simple;
	bh=XaEwHmsTCEj3MYPTKjfzApW/gRohngxzmhlfcQnc+6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqIWdDK3rbg8QdRWoDkTLpUgk61tv4oU0sj8Derr+6wAQvdJVU5rzGa7inIvls8C6yGt07DmovEwzEbMFrrGH/PE7GBsO4Ua5vn9o8a8PJrN4H2/p9I7Ja+jfk14mwc1rsARNC9IzDJV4zFFkfXJGWYXV9kWiXrH5MCdySN46B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6FYk7+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FF0C4CEE7;
	Sun, 20 Jul 2025 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031837;
	bh=XaEwHmsTCEj3MYPTKjfzApW/gRohngxzmhlfcQnc+6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6FYk7+FjY2JFzMMV/RSnEMvOGF6gOf+bdziruxGPA3qqqOs33FyJmu+nWZrQQkqj
	 Wjs+G4n5fXv03zT9S3DSxG/bXjRV37UmpJGZS1WhLe5gFaZjK2dF27r0JcY39Fg6g+
	 96Wc5nVV1mgyYieftkotK9xmG0JgtTuRDc8lHB3gZEDoQXzPm5a9baklAObWMyoDw5
	 gptlsEF78FxELQHH25WNL65NWs8iaI+15piasMmEvJrdxsZF2llhDoo4dPm0DYYd/D
	 s8dae4vLtcEsyJsnhl9cwNrVcCYV7Lz1wTLZZaNYeklx70AL2oNvzKvhagYwrV8k1y
	 fJeIFmccr3MCg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 19/22] selftests/damon/sysfs.py: generalize monitoring attributes commit assertion
Date: Sun, 20 Jul 2025 10:16:49 -0700
Message-Id: <20250720171652.92309-20-sj@kernel.org>
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

DAMON monitoring attributes commitment assertion is hard-coded for a
specific test case.  Split it out into a general version that can be
reused for different test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 9e5c72804edf..ed4c3e9fc972 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -137,6 +137,29 @@ def assert_schemes_committed(schemes, dump):
     for idx, scheme in enumerate(schemes):
         assert_scheme_committed(scheme, dump[idx])
 
+def assert_monitoring_attrs_committed(attrs, dump):
+    assert_true(dump['sample_interval'] == attrs.sample_us, 'sample_interval',
+                dump)
+    assert_true(dump['aggr_interval'] == attrs.aggr_us, 'aggr_interval', dump)
+    assert_true(dump['intervals_goal']['access_bp'] ==
+                attrs.intervals_goal.access_bp, 'access_bp',
+                dump['intervals_goal'])
+    assert_true(dump['intervals_goal']['aggrs'] == attrs.intervals_goal.aggrs,
+                'aggrs', dump['intervals_goal'])
+    assert_true(dump['intervals_goal']['min_sample_us'] ==
+                attrs.intervals_goal.min_sample_us, 'min_sample_us',
+                dump['intervals_goal'])
+    assert_true(dump['intervals_goal']['max_sample_us'] ==
+                attrs.intervals_goal.max_sample_us, 'max_sample_us',
+                dump['intervals_goal'])
+
+    assert_true(dump['ops_update_interval'] == attrs.update_us,
+                'ops_update_interval', dump)
+    assert_true(dump['min_nr_regions'] == attrs.min_nr_regions,
+                'min_nr_regions', dump)
+    assert_true(dump['max_nr_regions'] == attrs.max_nr_regions,
+                'max_nr_regions', dump)
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -158,23 +181,8 @@ def main():
         fail('number of contexts', status)
 
     ctx = status['contexts'][0]
-    attrs = ctx['attrs']
-    if attrs['sample_interval'] != 5000:
-        fail('sample interval', status)
-    if attrs['aggr_interval'] != 100000:
-        fail('aggr interval', status)
-    if attrs['ops_update_interval'] != 1000000:
-        fail('ops updte interval', status)
-
-    if attrs['intervals_goal'] != {
-            'access_bp': 0, 'aggrs': 0,
-            'min_sample_us': 0, 'max_sample_us': 0}:
-        fail('intervals goal')
-
-    if attrs['min_nr_regions'] != 10:
-        fail('min_nr_regions')
-    if attrs['max_nr_regions'] != 1000:
-        fail('max_nr_regions')
+
+    assert_monitoring_attrs_committed(_damon_sysfs.DamonAttrs(), ctx['attrs'])
 
     if ctx['adaptive_targets'] != [
             { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
-- 
2.39.5

