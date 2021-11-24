Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356445D024
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 23:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhKXWme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 17:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345462AbhKXWmd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 17:42:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14ED960E08;
        Wed, 24 Nov 2021 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637793563;
        bh=XMwCeHatEbKSFC9Dm+1fAj6kyfi8jEJ/4m1DGJkp0D4=;
        h=From:To:Cc:Subject:Date:From;
        b=gCksG1y4ST4rJ/0FvxMZHaS9icoYAYGLikkuA6jDr2PWBpyQyZFSomyVwEt2NwgTr
         v9usg0gdKmRPIS46uduhfoGzto9wOacf2bpLSg3pUsXipAOsS8G/bF0bWhW8zfM1UE
         TNTnHHe19yLRiSsr9/mRJ+0pXEcLv+NGtzqw2RzClfscRAhXa4gmpLmpRnvFgujcia
         867Qm3/y3BCF4GZTd3DBWsubmJKtUkSRTmq7TiXxMsShPyDRD4ADeZASHgxLohuFFu
         TwDTS2Ndarsdp2FbSSlv8YNd0Q1CRSzePE51ZMuVccQMBR021zi85ONRAzdAJ5+odZ
         /w99q+UxNi/zw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     keescook@chromium.org, shuah@kernel.org
Cc:     mic@digikod.net, linux-kselftest@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH selftests] selftests: harness: avoid false negatives if test has no ASSERTs
Date:   Wed, 24 Nov 2021 14:39:16 -0800
Message-Id: <20211124223916.1986279-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test can fail either immediately when ASSERT() failed or at the
end if one or more EXPECT() was not met. The exact return code
is decided based on the number of successful ASSERT()s.

If test has no ASSERT()s, however, the return code will be 0,
as if the test did not fail. Start counting ASSERT()s from 1.

Fixes: 369130b63178 ("selftests: Enhance kselftest_harness.h to print which assert failed")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ae0f0f33b2a6..79a182cfa43a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -969,7 +969,7 @@ void __run_test(struct __fixture_metadata *f,
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
-	t->step = 0;
+	t->step = 1;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-- 
2.31.1

