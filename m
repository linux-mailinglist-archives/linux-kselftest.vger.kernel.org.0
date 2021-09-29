Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B541C836
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbhI2PWu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344945AbhI2PWt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5C061406;
        Wed, 29 Sep 2021 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928868;
        bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhDxAvqGuk4gjSaw/u7suqBShWZitKs4l0MORhCDIah7Ba6B05VkNIcZvu4qfjFFq
         VQWeVtPfZr8M9EwpRVDYMo0cI/no8XOCISRHr51A4ulK20QzwhVe70GEDlKYxPDjui
         DdVxX4podzquXk4jMj3kUCVta2jFP/i2VQYIkadWeVOU0FVhs/6LDGcbkIMRZcXXKu
         BUS+10E2q49Mo111Jq7pImGpS22TKoWHZF1j0tBJOgWTrRHeqANs3Yxg4SoNqV4Ir6
         nKMAIA4Msf52KVf78Y2erazXtyegv+63unnJfA3Tjg+fmi7NpZ7jEpOQj/IMNv7VE7
         AnlacoFbln9Vw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/4] selftests: arm64: Fix and enable test for setting current VL in vec-syscfg
Date:   Wed, 29 Sep 2021 16:19:24 +0100
Message-Id: <20210929151925.9601-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929151925.9601-1-broonie@kernel.org>
References: <20210929151925.9601-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject; bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVIP7FuBDgWBwg6p1HNOQXNGec+AhKNKFSyB3BGEV FVIWvTmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVSD+wAKCRAk1otyXVSH0PTjB/ 4p/nWoBhi3G1+VcFCzwv8M3vueltacjBVsZQXc0B+t4AdlMdidasVXrmR1QcPgZOTI4XXFBy0+62EO iNF6LN858wKUSACqGvDoga7zksHO9eC58IeKPE9pOLsRSmH9V78pVAKRHeTvlyMNT6B8PtVGECYzq/ tyQqo0G/OJ/BS+ss1+fRHij0ht85QImS3bkYzFayIkPPZRqB58h33uEdXYEgs7xomIcWMZ0tg6N7eZ HPzScgqgAmcIqTJ/Sxs8vc/D31PiySTLrExJ7ztoJRGcjvnDhmaPfNjzqOgy1bftFD2UwD1P/1vr3k HcyOkXmCidUYkbvLeB8o+s5nt0NEqc
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

