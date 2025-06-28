Return-Path: <linux-kselftest+bounces-36062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91285AEC87B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2678189E65A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FD253F23;
	Sat, 28 Jun 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYU/71lJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFF253B59;
	Sat, 28 Jun 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126676; cv=none; b=Rll4Q+xVd0s3tMMuuMkSn5S9J3kkdtDQBRjez7nj6Kzi2H0vabhGEyCLEqe/i9dH829JfOO7nflxaATDuRG49fgi1rXGVdRNzVoH1tK0auantPHOITLidD501YsmJiqsjKO+pU24PXbOfNgqVFFx8O/saA0xz7Me5Lg9A8PdkS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126676; c=relaxed/simple;
	bh=miTM6A3QV73RUDWnpfCOrpusoocXXvQwskQZDbdPk1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQipQA3r/+CC72s1BsnbQrnaVbuBtHDfRXu33+7x9Dx4s+PKfh2usBx1tWCNX6SOBh2OrztKjqOcoy6XGxUOX5NeQ0ung9JvWwRp3bcMeSeaKwBSTv3yWSrBnOaOwYBr/gUjuI+VZQ7pWEQcxmyxccshbKxQFpAVdWOC4Vc15J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYU/71lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07606C4CEEA;
	Sat, 28 Jun 2025 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126676;
	bh=miTM6A3QV73RUDWnpfCOrpusoocXXvQwskQZDbdPk1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYU/71lJwh92l6aB/jcxuGPjkDyUhJHP2n6X2qLYacnBgfxpk8Xd0zT96ptt7ggg9
	 1IB8R6GUq/YVcrTd+Ij2w9a9VbPK1a50qs9o7bk5ioR6UTZGTnUj2si86Y+PeBx+fE
	 tX2BW/34/4AOSzVFgh/l7DpSUkPkw/3N+M5FxhcWwqIdcVPi+NltK7PBN4pv4drmIN
	 xSNnAp/WKZ7LVqXOdyiJP7HZbWz20/ftu+23XSUtbt5SwrqiNqo2LTq6fJPtIVYRNL
	 U/hNrqf5QrHkY+Sj3GWOzwR4/tiZK1LlsY6TziYppW+D7NxAbfE7UQALuS2uhLxLoB
	 f8rzMNWQaX93g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] selftests/damon/sysfs.py: test monitoring attribute parameters
Date: Sat, 28 Jun 2025 09:04:26 -0700
Message-Id: <20250628160428.53115-5-sj@kernel.org>
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

Add DAMON sysfs interface functionality tests for DAMON monitoring
attribute parameters, including intervals, intervals tuning goals, and
min/max number of regions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 4ff99db0d247..a721901a880d 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -20,6 +20,11 @@ def dump_damon_status_dict(pid):
     except Exception as e:
         return None, 'json.load fail (%s)' % e
 
+def fail(expectation, status):
+    print('unexpected %s' % expectation)
+    print(json.dumps(status, indent=4))
+    exit(1)
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(contexts=[_damon_sysfs.DamonCtx()])])
@@ -34,8 +39,33 @@ def main():
         exit(1)
 
     if len(status['contexts']) != 1:
-        print('number of contexts: %d' % len(status['contexts']))
-        exit(1)
+        fail('number of contexts', status)
+
+    ctx = status['contexts'][0]
+    attrs = ctx['attrs']
+    if attrs['sample_interval'] != 5000:
+        fail('sample interval', status)
+    if attrs['aggr_interval'] != 100000:
+        fail('aggr interval', status)
+    if attrs['ops_update_interval'] != 1000000:
+        fail('ops updte interval', status)
+
+    if attrs['intervals_goal'] != {
+            'access_bp': 0, 'aggrs': 0,
+            'min_sample_us': 0, 'max_sample_us': 0}:
+        fail('intervals goal')
+
+    if attrs['min_nr_regions'] != 10:
+        fail('min_nr_regions')
+    if attrs['max_nr_regions'] != 1000:
+        fail('max_nr_regions')
+
+    if ctx['adaptive_targets'] != []:
+        fail('adaptive_targets')
+
+    if ctx['schemes'] != []:
+        fail('schemes')
+
     kdamonds.stop()
 
 if __name__ == '__main__':
-- 
2.39.5

