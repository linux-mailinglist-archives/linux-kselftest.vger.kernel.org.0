Return-Path: <linux-kselftest+bounces-49223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC72D38B72
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F826304F156
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA93128CC;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at9hip/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B803128A3;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615660; cv=none; b=MJOXft93dwGob3Xt/YjitOZid/Ca0wX020MnGooVQHBvSJBOG7dUBnf3pTK3RMyRoBnnRWPGVt3pxLrZfQOHiPIHrqMUsEOWxd8UmvGGeemGNXZBX9bc79Qr6GPio2NSDrNs5Ac/xdXDa6iwkeupbC2recVrG5LV+Ieqtl07S9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615660; c=relaxed/simple;
	bh=CG7FIKN2uhUYlogFlECFQp/aiQrzKBqLzUq1oqqm9T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0XMSqKfB8B7Zcbg57+DshgOaa5+q6rHq8hDVq8eEaChuwbuqMi2MLiAZBD0ksIZJaM1GRI3qB08HUh4eAdFsM2PFAoAaOk1dw+Zr1YZweiW3kGmqEWCxXkanQwiVgj6lhmD1i+YncD/H00TXD5BKycY/Hd8iy0MB1UN82H38tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at9hip/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E459C19425;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615660;
	bh=CG7FIKN2uhUYlogFlECFQp/aiQrzKBqLzUq1oqqm9T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=at9hip/NNgMK8XQXptqszZ0yNlLCCj33sTWAYLEG7gA86bgGbokQZ6kMguug4V2HD
	 0GLqeAdfMX4UfamKQb9liCDGMwge3QZmZ1JKHjfUADAXDmMi36bhwKB8dNgyI/j3gy
	 zjuYz8Keoai8fJLsezHOoK8HnZngvOhHl9gpJS8kllJ0USgEEnJnZvpZARkQrsPTI9
	 +UmhKqb7jXAiReAvDexmQCAVfRI6abg/0SAg86Xtn+xbkA/wYNO5v/LB9ywXymGOWf
	 DbZpGm5YCaZ4ioKXa5CcKDtWxO8WD5nmKK8HisOiLj9SOIvpZggL/3pweYE61B0xew
	 FE/g3vijElxvQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] selftests/damon/wss_estimation: deduplicate failed samples output
Date: Fri, 16 Jan 2026 18:07:28 -0800
Message-ID: <20260117020731.226785-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117020731.226785-1-sj@kernel.org>
References: <20260117020731.226785-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the test fails, it shows whole sampled working set size
measurements.  The purpose is showing the distribution of the measured
values, to let the tester know if it was just intermittent failure.
Multiple same values on the output are therefore unnecessary.  It was
not a big deal since the test was failing only once in the past.  But
the test can now fail multiple times with increased working set size,
until it passes or the working set size reaches a limit.  Hence the
noisy output can be quite long and annoying.  Print only the
deduplicated distribution information.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../sysfs_update_schemes_tried_regions_wss_estimation.py    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index cdccb9f0f855..35c724a63f6c 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -53,7 +53,11 @@ def pass_wss_estimation(sz_region):
             print('the error rate is not acceptable (> %f)' %
                     acceptable_error_rate)
             print('samples are as below')
-            print('\n'.join(['%d' % wss for wss in wss_collected]))
+            for idx, wss in enumerate(wss_collected):
+                if idx < len(wss_collected) - 1 and \
+                        wss_collected[idx + 1] == wss:
+                    continue
+                print('%d/%d: %d' % (idx, len(wss_collected), wss))
             return False
     return True
 
-- 
2.47.3

