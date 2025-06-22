Return-Path: <linux-kselftest+bounces-35581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD8AE3230
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EA51891247
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99D8221739;
	Sun, 22 Jun 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlO6a+zB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E711221723;
	Sun, 22 Jun 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626219; cv=none; b=ixSBLv8E7NawoizeApJuQ2C6q+KvrFqEhmYeAkQ/ufx725JEOG6NmtaQvHATLSp2kFhGadSErSquCpgW+wqeY4JzHLL3T/wzAYVvt6ud5N4mbxPpto7xQwbU75mk7lTICt/cKZqOsI9/WauVBfwOYZOoRLrxPOVQX5dY7OpDupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626219; c=relaxed/simple;
	bh=miTM6A3QV73RUDWnpfCOrpusoocXXvQwskQZDbdPk1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQ4O/LxL+AJ1X8qD28SNeZDQm+OzgtwFnZZlcoeGbTmfoKBdoBkSW06qXPaawM5NG6L6oWh60V+gWbbNWdST9PlrDLgeG3Ok//ZoY99LY6G+9qqoJB1GHwu/zwDTpB2Gh5WTmJXyIZFwZjjZUfXj24M0NGFnOlNmswJkk6oZMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlO6a+zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C3C4CEED;
	Sun, 22 Jun 2025 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626219;
	bh=miTM6A3QV73RUDWnpfCOrpusoocXXvQwskQZDbdPk1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlO6a+zBcL8nUOw9+1ngXmZzojMVpnSCtjCLKUMlv9sOd/QF89mW7yGkv72BMnv+g
	 dzU9cbXzql1yjIQrCUZ6q6uVghbkAxovnoaxvSuRrMQnYF2jS5cSzbSaUM+aVCRmNZ
	 Zl+Byvk2A5t5GijhzxawGKsQJl2uwdSz9bTDYu1Z5ze5pVEcjuqhjMcuo69Miv2cPE
	 80wxT1Dxmixv9WCT1Fc0RORvdhSo97itef6kvUTg6e3DEfGBT73SnCf3/3yvjbPg0j
	 A0eg0dXK7X9XnwPncabF+mAjJ4IsShizBJG5rEl1xf4tIAx3JT6R4RAdpS8D4Y8Svk
	 ZHdYPZQYqjvsw==
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
Subject: [RFC PATCH 4/6] selftests/damon/sysfs.py: test monitoring attribute parameters
Date: Sun, 22 Jun 2025 14:03:28 -0700
Message-Id: <20250622210330.40490-5-sj@kernel.org>
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

