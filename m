Return-Path: <linux-kselftest+bounces-5241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC285E9AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DA7285377
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8B128370;
	Wed, 21 Feb 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUF8O8Cg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64564127B71;
	Wed, 21 Feb 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549927; cv=none; b=i3pZQ14iMtoMJzcdywQ5XafVOBYx9Z6Wqsj9Uhwbw1fdp1Wr5GnVjUhB0eHhnK4Y45v8IPH++TJA4RtdJKOnYi5qkO6/RfhvDU94l1MIHj+qCwmBXX6dFgo/0Ffwhm1rqKzPzZrJcuaZaQBHs2jalVSgsdlmFl6rJyOlcleRc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549927; c=relaxed/simple;
	bh=k+Kpk6TIz1SIhQ50dNt75EsjDGXOXq9Y38B0rd5jg98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bz7Npgoipfuer5Glaf06tls/RmUodXVdQhk6EKWxxYny9xHkOBDgNOF088U/XVjL4xMR7t7tWeXX9Ohps47eNLE2V3MW8sbv2QbrZQ/VIyJgNYV2gW9vWENtYohm09A32cG5R/CY+6vse4pu0DZ5qGcjIkjkaTUDksOk4U7VUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUF8O8Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D94C433F1;
	Wed, 21 Feb 2024 21:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708549927;
	bh=k+Kpk6TIz1SIhQ50dNt75EsjDGXOXq9Y38B0rd5jg98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUF8O8CgBSnq2Ydlb46crEoAOETjJg9dY4xTSHylQGbulJ3ZCRfbdhSS1JZgHx8Ue
	 hyQqKPzjPsNXhcywSCgb/xgDxGoP1Ycvkk5ol8azXAmWJRdK//pAi80HBFZRJHCWN1
	 vxUtCh9WHdClFBcEbnl1Zu9Y1erLaSsbiq1qi1tqhu1zusHFO5zuf5c29W76UFJEVj
	 8eVz9DSVmbF2H6MeVwInGYbRZoCnqD5Eeiauu17AW+t4rajqtlsFWimjg4GL2l4d+q
	 VHJecw7JIumaNO0hMyh27HeiLFy2G9E3NR9Qf37HnLI5mNLoUgtijIBm2HmGiuQsUE
	 hAepdQNTbnNEQ==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	bernd.edlinger@hotmail.de,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/2] selftest: damon: fix minor typos in test logs
Date: Wed, 21 Feb 2024 13:11:47 -0800
Message-Id: <20240221211148.46522-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221211148.46522-1-sj@kernel.org>
References: <20240221211148.46522-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>

This patch resolves a spelling error in the test log, preventing potential
confusion.

It is submitted as part of my application to the "Linux Kernel
Bug Fixing Spring Unpaid 2024" mentorship program of the Linux
Foundation.

Link: https://lore.kernel.org/r/20240204122523.14160-1-vincenzo.mezzela@gmail.com
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py  | 2 +-
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 8c690ba1a573..28c887a0108f 100644
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -20,7 +20,7 @@ def main():
 
     err = kdamonds.start()
     if err != None:
-        print('kdmaond start failed: %s' % err)
+        print('kdamond start failed: %s' % err)
         exit(1)
 
     while proc.poll() == None:
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index cdbf19b442c9..90ad7409a7a6 100644
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -23,7 +23,7 @@ def main():
 
     err = kdamonds.start()
     if err != None:
-        print('kdmaond start failed: %s' % err)
+        print('kdamond start failed: %s' % err)
         exit(1)
 
     wss_collected = []
-- 
2.39.2


