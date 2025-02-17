Return-Path: <linux-kselftest+bounces-26800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0DA38B36
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 19:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A1D1894025
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461ED235BE8;
	Mon, 17 Feb 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLu68NYN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D822F3BA;
	Mon, 17 Feb 2025 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816589; cv=none; b=uHA6keqx+S2zD7O8j7OdbwFV3pIAA3+g/8SVbGgKcz4Bk0WWyGuDRAtXECQfR+zIiCX5Eovlz754V1Tfdc/22slXSj64dO4QK8sZ9WbABUFB1AIGb+F9+0ANf27J52BGEtiXoFd5joXxp8l6RNsyLzJUBRemRCYPoUGATh81Vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816589; c=relaxed/simple;
	bh=n7g0gJyMQcouAhbIJm6xczE9AEtKmUwr5Noo4sba+Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8u1YIhE4dny7vEYP7lw9kXBxkJtmzkhKqihKtBRgs6/+vhoa7SvZTWym9vnSOmoXe5JOanR502iZVgZykwqBvvCx7i4bsuD6u6sOTWMEFHokjFaCuh617G3iu27F8sAtHI3ipBaN+gjyxok94R4eWCfxE2TdGErTfWgPWKSgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLu68NYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6391CC4CED1;
	Mon, 17 Feb 2025 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739816588;
	bh=n7g0gJyMQcouAhbIJm6xczE9AEtKmUwr5Noo4sba+Eo=;
	h=From:To:Cc:Subject:Date:From;
	b=LLu68NYN496qBbaqRSyGErO6IEO6gRJ4Q926sHunH4ZdV3Mt5L3UM/pSsGOW62oEk
	 ehACslGrGgnIN1+lWVzjugfZiitQXZre+zEbe6GLY4pbSz5uydItbdAasum2JcQiDf
	 5efrfPmdyUGzR8gMp/MysHuEVxmi11El5HTY+el8BLYPQI/f1Y2cjZzskSaM3oWgso
	 g2Q1mCNRVh3SzmO+SXXarxxynkjblP+4o33D2CZDwVkHNWtRd3VNKpcUcjXmLwsP7u
	 +nK/jO+Hh9Gtq6FeW1iXKTdIhegGjZTrOLCFowunMr+p6QB86RP/JuPe885gYI9DNw
	 FP+mbNJQtbpnQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests/damon/damos_quota_goal: handle minimum quota that cannot be further reduced
Date: Mon, 17 Feb 2025 10:23:04 -0800
Message-Id: <20250217182304.45215-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_goal.py selftest see if DAMOS quota goals tuning feature
increases or reduces the effective size quota for given score as
expected.  The tuning feature sets the minimum quota size as one byte,
so if the effective size quota is already one, we cannot expect it
further be reduced.  However the test is not aware of the edge case, and
fails since it shown no expected change of the effective quota.  Handle
the case by updating the failure logic for no change to see if it was
the case, and simply skips to next test input.

Fixes: f1c07c0a1662b ("selftests/damon: add a test for DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.10.x
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171423.b28a918d-lkp@intel.com
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damos_quota_goal.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
index 18246f3b62f7..f76e0412b564 100755
--- a/tools/testing/selftests/damon/damos_quota_goal.py
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -63,6 +63,9 @@ def main():
             if last_effective_bytes != 0 else -1.0))
 
         if last_effective_bytes == goal.effective_bytes:
+            # effective quota was already minimum that cannot be more reduced
+            if expect_increase is False and last_effective_bytes == 1:
+                continue
             print('efective bytes not changed: %d' % goal.effective_bytes)
             exit(1)
 

base-commit: 20017459916819f8ae15ca3840e71fbf0ea8354e
-- 
2.39.5

