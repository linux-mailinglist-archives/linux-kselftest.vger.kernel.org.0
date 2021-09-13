Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4450408B40
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhIMMom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 08:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhIMMom (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6778160C51;
        Mon, 13 Sep 2021 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537006;
        bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsVlkaUrS+3ekkQW+0XLo0Cy4RXS0q0rlm3/jiNgVzKgxf8U47jTWa+ctvI5U/8O3
         hJDcXgKcvAGj0PTWj1p5oBqcgHUoJwJ2RAb//xEUT8kQawZl34bgoUZJJG/x77NCNp
         oty8QD2pe8JGKOivjpWAPc84TpM0Uv3aMSsxlME9A9VjoE9vgl4O+MiqyjfhxsZ1mA
         JdptSp6kNr3mZq2gGBWUFLcezvUUjeFu3K5XEPKUBdcoy1xsjEOkejxZ/FwTMBtuSw
         4brEbteyUznBM20PzpYtjS/6BiMNCvVjyJzc4cbd0c9BgEQoo0gQ2HxfK9Rpb+YFgw
         W9dnXfxTN4dzA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] selftests: arm64: Fix and enable test for setting current VL in vec-syscfg
Date:   Mon, 13 Sep 2021 13:37:10 +0100
Message-Id: <20210913123711.51274-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913123711.51274-1-broonie@kernel.org>
References: <20210913123711.51274-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; h=from:subject; bh=034J/1+mWeQStGpdMFtVOiBVU1WdpiXGK6aJYR8cNz8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0X1FuBDgWBwg6p1HNOQXNGec+AhKNKFSyB3BGEV FVIWvTmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9F9QAKCRAk1otyXVSH0K3LB/ 9KtfrwHWNbfN2vcRqvKPgp1aiw6Ai2pS1ug/5gOHZ86dac0ofWR27zcyN+2AphQM8icX+DqL+jrv/b jBee9Ef8e5vtGXZky1rfPVMsqcvk7MyP5yDCSCxtGeljYR28Gr7bM/msbHsndwhrv5LItp0U0pdZcM XO9OfQV5wp4QMwTT/A0Zca3d8jECf6H2uhcu1mLWAwlopKzkmBLi4blt4gqOEcvLYT73ZNWvNzJp2C HkKUkPaaI/0ZhPL93YUU0TrO6ejsPatNgfVUFodCOM/qy8iamPnzaUU+b+gRhTDnmuq8TKCbpA2yEk /eFChSROYjhJ20x6N+lYNnwF8/yFMl
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

