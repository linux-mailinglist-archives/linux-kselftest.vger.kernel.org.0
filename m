Return-Path: <linux-kselftest+bounces-37696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615FB0B725
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340141898285
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE622FE10;
	Sun, 20 Jul 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvLouwEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49922F769;
	Sun, 20 Jul 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031826; cv=none; b=D3Btc+CtQNwZvI+bQu0skRWTERjO95NLh3LYREFQ5AFlywiYC/htYa9MVdxIKBG4uYTl4G+6m83zOnl+bBFQkJcTsCFsps10QJoIrbfB981U1P1Bq966AKcaxZx2cNNI69FPIEd26t2p3vEIsHuueFKn5U9PoGTkeYgzepk8aJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031826; c=relaxed/simple;
	bh=jK/5e0f+p+R18UZwW5wG4/SSylxftyD5V+ufZGZFK+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luVnNbYcOtwgtfu541vf5k4XJ+Q77oGR/D2tg4elCPUy3wgDxZOKBhKl7SFNuG7s6ijpqEddsYpyHS78ff6N+9x3r5UDsEVNUcPgblYzVCCE7tmNIuCpA7xE4nmS/PuFbmWGiT4VrUAkJ/DaME3uu770BFuk9UHocBRa9ygARIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvLouwEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340FEC4CEEB;
	Sun, 20 Jul 2025 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031826;
	bh=jK/5e0f+p+R18UZwW5wG4/SSylxftyD5V+ufZGZFK+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvLouwEmDJk8h2O06vpBTTQnDnG2PODw+GWi1W5cN4PGz8gMXhVhHN7dwDCMH9XKG
	 YKX1+lZLc0JEf5yInJr8e4SzVj4Y7KaTvJK3y4By9gFX76Qa6kIxu49r1bAr1wEmSO
	 TW2RDft5XWBpQCgwCJ3GjEaSDZU+eThQhMruFfQiyAnlEppVd56b0bs3XH5vYDMXd8
	 58XHMC7Z62il5ngmKVh58Bfe5ExcPD75eF/MEsWXYE77HpOa12oa711Oq30PbjGrgX
	 nZrT5pr5sNoMx2EjW4oTAny2o5vl5SqxLU9lMCxde7+x5dQJ/nP5pP7+hC7k46flUc
	 cz0HjrWpvI1yw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/22] selftests/damon/drgn_dump_damon_status: dump damos->migrate_dests
Date: Sun, 20 Jul 2025 10:16:39 -0700
Message-Id: <20250720171652.92309-10-sj@kernel.org>
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
makes increasing test coverage difficult.  Add damos->migrate_dests
dumping for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/drgn_dump_damon_status.py      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 333a0d0c4bff..8db081f965f5 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -117,6 +117,19 @@ def damos_watermarks_to_dict(watermarks):
         ['high', int], ['mid', int], ['low', int],
         ])
 
+def damos_migrate_dests_to_dict(dests):
+    nr_dests = int(dests.nr_dests)
+    node_id_arr = []
+    weight_arr = []
+    for i in range(nr_dests):
+        node_id_arr.append(int(dests.node_id_arr[i]))
+        weight_arr.append(int(dests.weight_arr[i]))
+    return {
+            'node_id_arr': node_id_arr,
+            'weight_arr': weight_arr,
+            'nr_dests': nr_dests,
+            }
+
 def scheme_to_dict(scheme):
     return to_dict(scheme, [
         ['pattern', damos_access_pattern_to_dict],
@@ -125,6 +138,7 @@ def scheme_to_dict(scheme):
         ['quota', damos_quota_to_dict],
         ['wmarks', damos_watermarks_to_dict],
         ['target_nid', int],
+        ['migrate_dests', damos_migrate_dests_to_dict],
         ])
 
 def schemes_to_list(schemes):
-- 
2.39.5

