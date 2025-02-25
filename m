Return-Path: <linux-kselftest+bounces-27537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D06A45005
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627977AB0A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A721A42D;
	Tue, 25 Feb 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S66W9kHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451B219A93;
	Tue, 25 Feb 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522221; cv=none; b=mAOuzEwPl19M8vFynhhJ8RCHFjoB0CpElvV1fgfYPu+CinG3jkTSLqgak9dzWpHzs8Rfzg4vlEu0B6SXfA4DFjVk0qHPGjynqjtpfTritODZwIE0WK6Tw3a6hOuU6NKRaD+EfW/y3ICFgqqUxK4foQ0fPkBBkVkTqgxqqUO8gY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522221; c=relaxed/simple;
	bh=JZwrDWNwK0HGwgbbnUAETnfdZFPS3H25nSzCsf8e/C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dssNFQsn7nEb3lK6cocTmBcs24XHeDk3p757q4ymNNHtC6dLMb1AoPEbuxRQvfKaqNQnC+52Jy8ntYN17yxmOazhiZj325PCJI+DAaB5FkAVJBogM31+dFwGNOTN9ttoR6Ru3b0oeEhbxn/YpXTo6cPfPEn6RKy/URjXpMeAmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S66W9kHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F3C4CEE7;
	Tue, 25 Feb 2025 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522220;
	bh=JZwrDWNwK0HGwgbbnUAETnfdZFPS3H25nSzCsf8e/C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S66W9kHZZShg8xZlcQ533Ohn8T+1do/8o72DrPZ2fNwWyRvPGR7e3p1nLBNM6lOYD
	 3toGrsMjMc//M4hGKTPTB3s78O9hrdbCHlo+AD0EqnU2zAVSwfqqZfv4BakSmdyJCV
	 m7lNZ48We5IKAq3puevP6JLpbJcdJEtMRLYQX+eOPhaEPR1iaYhMtErRQvmhWuMpGl
	 zNsMZF3FvtkOuAyxphChsIcljZbXj7ErHf1l3iQjzAcS3zFNj2a1uL0MnZgQyi6Y0a
	 KnFR2rqlwbq4oYUlj4hleJXVioXQkHhOisYWyziPULl1L2jll3EAtWzB1nq/SK9edi
	 gsbniAPsLXUFQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] selftests/damon/damon_nr_regions: sort collected regiosn before checking with min/max boundaries
Date: Tue, 25 Feb 2025 14:23:33 -0800
Message-Id: <20250225222333.505646-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225222333.505646-1-sj@kernel.org>
References: <20250225222333.505646-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_regions.py starts DAMON, periodically collect number of regions
in snapshots, and see if it is in the requested range.  The check code
assumes the numbers are sorted on the collection list, but there is no
such guarantee.  Hence this can result in false positive test success.
Sort the list before doing the check.

Fixes: 781497347d1b ("selftests/damon: implement test for min/max_nr_regions")
Cc: <stable@vger.kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damon_nr_regions.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index 6f1c1d88e309..58f3291fed12 100755
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -65,6 +65,7 @@ def test_nr_regions(real_nr_regions, min_nr_regions, max_nr_regions):
 
     test_name = 'nr_regions test with %d/%d/%d real/min/max nr_regions' % (
             real_nr_regions, min_nr_regions, max_nr_regions)
+    collected_nr_regions.sort()
     if (collected_nr_regions[0] < min_nr_regions or
         collected_nr_regions[-1] > max_nr_regions):
         print('fail %s' % test_name)
-- 
2.39.5

