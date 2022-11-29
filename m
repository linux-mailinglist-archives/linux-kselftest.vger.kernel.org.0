Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBB63B63F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiK2AE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 19:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiK2AE0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 19:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42202186D1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:04:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B60C1B80FE9
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D87C433B5;
        Tue, 29 Nov 2022 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669680263;
        bh=ffhxUDMKp+LpVrt45dMJeTgyberGxql4NgI1JZQLIGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQuZcrpUNJDuk9BahSvRvIsixECtTA9JhfRT/VtJi5aWkggEDQTqpjj5nMGNnVPIX
         BlNvq5AYq4qalttRB0TjNhCMBqLzf3Uz7lLuQSdZ4s8tKUYAua1rygutbNsZPJvp3K
         G0o3jBwmWR+RKjPNqOSwFRXvJwLgepJDb4L306CYUug3yPTGioLYnNCuc6omdKFHWp
         XTatiNuvRwuFK3Y4atMOGuhLes7GMYHvEda+VhPOsi/KXoFsCVGODgIpTEGYHHy5uu
         AvD7vplIZOqHk0DuHXU1ewRLfjb5/aCGB7LA5ub/pIUYaukBDRAS4n5xRTgq8OFdc7
         NpVd4Jkz9YcUQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] kselftest/arm64: Don't drain output while spawning children
Date:   Tue, 29 Nov 2022 00:03:54 +0000
Message-Id: <20221129000355.812425-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129000355.812425-1-broonie@kernel.org>
References: <20221129000355.812425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org; h=from:subject; bh=ffhxUDMKp+LpVrt45dMJeTgyberGxql4NgI1JZQLIGQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhUxp5Y1PuXboQC8O3kWSuJde5MJwdGEvVVgHo8Wd NuTmi0SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4VMaQAKCRAk1otyXVSH0ODcB/ 9wJH19WeEQFgzm9rfUCiHbEa7Dko4RXfIIdVdIKhoaCMLUpryUI37tS79NAThYeu3wDZfRU3jlF2ys +FcJ7MYyEIosdgZmLWLX19x8+AVgHBixJWsxu/coAvxCHLkqseHoWzRgvqiqTEQ+HvsQqpb4+0rU5X X8N3qiNeRc4ZlAbRacrddo/4THoXQ6KT8mOsDM5pj/Nlrb3iB2vV3cdrWJBTEgYkbQx5iCch9MTIDK 8+bQRFanHuC038YYLPFIfJbWvENebtR+PkmWwSiWlufpg523qPdLXHxwrWg9TLu6SK0FUgi+oZV9Q5 K08pzT5jzDQsRBW21UEtnRgB575dLd
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now we hold execution of the stress test programs until all children are
started there is no need to drain output while that is happening.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 9a3a621cc958..65262cf30b09 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -42,8 +42,6 @@ static struct child_data *children;
 static int num_children;
 static bool terminate;
 
-static void drain_output(bool flush);
-
 static int startup_pipe[2];
 
 static int num_processors(void)
@@ -138,12 +136,6 @@ static void child_start(struct child_data *child, const char *program)
 			ksft_exit_fail_msg("%s EPOLL_CTL_ADD failed: %s (%d)\n",
 					   child->name, strerror(errno), errno);
 		}
-
-		/*
-		 * Keep output flowing during child startup so logs
-		 * are more timely, can help debugging.
-		 */
-		drain_output(false);
 	}
 }
 
-- 
2.30.2

