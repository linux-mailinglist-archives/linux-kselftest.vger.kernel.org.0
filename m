Return-Path: <linux-kselftest+bounces-9397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF98BB20E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F1D282530
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0F158A0D;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcMdqlu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE158A04;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759405; cv=none; b=ghO0c5FIdcxNoJcPtAC1EBm+3vq/qc4jJa/qy68u8l/YMUYICRY0/AkmXOoHQW69C8RSjp4K1UVtCelhQy+hvgk0BpjfWGs7+1COOYUz0geukz+LJ7psEWq+byPInYn7UDlyhfoK11RvoNKN+So4cSEKLa25JPyFV9ujorNFzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759405; c=relaxed/simple;
	bh=wl4KaQNGGSUoln/HN59nrI9DZXm2wms4eum28pA9dLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYHOpsSyaWVNLYzTZvEv8FPymtNMJ5VBHk9Oaq2ac0fngv74K5bp4dTciA2ZKngdeT2aDFq/l48ZLGPpCr3T0/WkuoJ1ybmOKeLsZgfGA5i1ymzkZm/nuHTxBNXZWGI6IXrbZQ2U8tgWBArQ82qmdSHpEemqhqEihpQpBTHjm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcMdqlu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2465BC116B1;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759405;
	bh=wl4KaQNGGSUoln/HN59nrI9DZXm2wms4eum28pA9dLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcMdqlu028SzxGvUHkmkFsYzLK9DLlJ0smYEoaFbRsz6nd0eJHiWiTS3Ba1ejCjpw
	 CoAJow0Rt1FgNM4tEdiLD6cQLwt8572cvjve44lT7OPGhFGsWFVAB7XqESNvHuT1LP
	 VkqwJ0uEVSMlW/MsUzOQ4kEg9GJ4Gx96jyQXgPACJyMvdU1WnWWk7Q6v7RoCmlzCd4
	 UICxzjc+YRXF4qhGiU56z1PQL+iXRxM+cdpqMTXGlPNFqI7yF7kA5s3yamKARLqDPl
	 +kVh3zZZUEy0UmxksbLdRSmD2MZLM8dXFRGY2EYvlxwlyDKlh52qs9Lv5odKsIFyxf
	 bQDzBQivuom/w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] selftests/damon: classify tests for functionalities and regressions
Date: Fri,  3 May 2024 11:03:13 -0700
Message-Id: <20240503180318.72798-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON selftests can be classified into two categories: functionalities
and regressions.  Functionality tests are for checking if the function
is working as specified, while the regression tests are basically
reproducers of previously reported and fixed bugs.  The tests of the
categories are mixed in the selftests Makefile.  Separate those for
easier understanding of the types of tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 06c248880172..29a22f50e762 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -7,16 +7,21 @@ TEST_GEN_FILES += debugfs_target_ids_pid_leak
 TEST_GEN_FILES += access_memory
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
+
+# functionality tests
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
+TEST_PROGS += sysfs.sh
+TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
+TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
+TEST_PROGS += reclaim.sh lru_sort.sh
+
+# regression tests (reproducers of previously found bugs)
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += debugfs_target_ids_read_before_terminate_race.sh
 TEST_PROGS += debugfs_target_ids_pid_leak.sh
-TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
+TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
-TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
-TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
-TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
-- 
2.39.2


