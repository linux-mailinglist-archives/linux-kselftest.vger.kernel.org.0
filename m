Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAFD40F748
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhIQMLb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhIQMLb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE5660187;
        Fri, 17 Sep 2021 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880609;
        bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1AJZJ/ykgRigh5f2FwPivzoyK1bX7icB7x8k3oiSidyEEfiMAFsLb+o//L25z5xT
         VEVRl5bhO/wbzLdqcSGkpD3hkxirkDUz/Dvc4lWS2hh1yUPyejmPlNylERG6PRfW4q
         hxm4ZCm8BOrB9zwzkfazzA2yCFYGOdgnPUgvIsgXD6qFefHp2kfue1bZbTuVp4PpkL
         FLBM+LoyZNO9GS7LmCORhmfB8qxtn3bleyCLoqWXNRoboQnJbYWscnKrWCbdg8XMMH
         b45lvp8ka6jcw8T1aZxz1233Fk7CKGXAuyps5gEaOxgvoLMWyrRw3BDacy843pF16i
         kVUiJDPpj9J1A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/4] selftests: arm64: Fix and enable test for setting current VL in vec-syscfg
Date:   Fri, 17 Sep 2021 13:08:54 +0100
Message-Id: <20210917120855.13858-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917120855.13858-1-broonie@kernel.org>
References: <20210917120855.13858-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject; bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhRIVTFuBDgWBwg6p1HNOQXNGec+AhKNKFSyB3BGEV FVIWvTmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUSFUwAKCRAk1otyXVSH0PIIB/ 9jetOr4qozgIrSr+rO4ct6fg2NiySwJCBd+qPDdhxnIoUhTwMD1RJHJ9HLS7wdPdXbycp6IdxBr8Qu i9E5EFTvoP33SONsNuLDCoQRoLvq1hJiYIYyMhfUrChyVeUJtNGfTfOL4b+26a/mzyWJ2J9Rf/2moN ypWx7X0cNsk5z9onjeIWQfkpp/YYis6qlMElMk0AnRhuIbX9P+PClis7d9GHRfw491Ne+BtrfiGRDX mLRW0kO5mWL+pBMKiVDDSl7UWVgZAhxbSzWUL9MsduUEFg3h3NhsdE86YjAGkvnGO1gWDXOHhadu1+ xNLLIpxdb0+Un3+RmKaZDlje8ZE0Ck
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We had some test code for verifying that we can write the current VL via
the prctl() interface but the condition for the test was inverted which
wasn't noticed as it was never actually hooked up to the array of tests
we execute. Fix this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index d48d3ee1bc36..9d6ac843e651 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -329,12 +329,9 @@ static void prctl_set_same(struct vec_data *data)
 		return;
 	}
 
-	if (cur_vl != data->rdvl())
-		ksft_test_result_pass("%s current VL is %d\n",
-				      data->name, ret);
-	else
-		ksft_test_result_fail("%s prctl() VL %d but RDVL is %d\n",
-				      data->name, ret, data->rdvl());
+	ksft_test_result(cur_vl == data->rdvl(),
+			 "%s set VL %d and have VL %d\n",
+			 data->name, cur_vl, data->rdvl());
 }
 
 /* Can we set a new VL for this process? */
@@ -555,6 +552,7 @@ static const test_type tests[] = {
 	proc_write_max,
 
 	prctl_get,
+	prctl_set_same,
 	prctl_set,
 	prctl_set_no_child,
 	prctl_set_for_child,
-- 
2.20.1

