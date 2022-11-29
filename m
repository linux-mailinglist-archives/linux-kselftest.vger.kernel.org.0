Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7463CADE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 23:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiK2WAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 17:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiK2V7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:59:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52626F351
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 531A661929
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 21:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A0C433C1;
        Tue, 29 Nov 2022 21:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669759175;
        bh=+W8adVt0qNP/+1paRvySD60I/TQ9TpFvbpjiyvAbBAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFX7m9ExCmU3ohxMn3j8fx39hCLVPwqgMANpN0txWwxWaK0eU4BeMAC9JVxjBLQl9
         khEL5bz7LkPjc5I5ZTjyhJi6kqoxeSxxkg5TxMqoRcLsJSna4zpaSpPIb13STZ8udG
         43by6c9EHB05xCS50AHKkyg/Gm5FiJr0qNVRrYtUQeiqdEIP33qTT9S0FsRxDOsRGi
         ldYHb63nWlwFs5Zd46O6vvXFY5mbzfd6InXISh3ep83IXBYg0QE1lCscKPKFW51hsn
         WYbhzYLibJKb1yvQA1+TOY77c3/GWuzN30DEOclthVWmm6Hlh4nUh4A3yl+WDB0Yg5
         47pHtcS8Nr28g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] kselftest/arm64: Don't drain output while spawning children
Date:   Tue, 29 Nov 2022 21:59:24 +0000
Message-Id: <20221129215926.442895-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129215926.442895-1-broonie@kernel.org>
References: <20221129215926.442895-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org; h=from:subject; bh=+W8adVt0qNP/+1paRvySD60I/TQ9TpFvbpjiyvAbBAg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhoC8UMtEjXfLbwbQEU4Rxagc/CjBu3qp2TKLbzO4 N2gxArSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aAvAAKCRAk1otyXVSH0Mo0B/ 4st+ImVjOz9wuVjI/EGgH9bJW89NAHeVMCYcPZV1+PuWsaFDD79YX9N5q/8cdxqBFrF/89TZrzN7Bo EbqZfn1t+ywNF7F7AOXGOSpdUh5SalcD/ZO02Bvjo7BC/rDHOD+1XGsMH+L5TgXmvK/39cZIM3i+qF gqnrlWYlDEPMxrbQip5yE5B08a29E6IX32GnuSg/O8CJqBFJurMqU30tRJ1l26q8fLpmAj8gNv9RXV cm+6yoPUaV5iJ5e/6MGhGISf2JoL9dl67dd+5gl/0VBtVfh50g00uJ2ugTgaIp3HWQFbN36Dqf3Q8T KDcSt+CrsLqJQXHFweIcDrRTSXm4Mg
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
index 7c04f5001648..b3bbfe8d9f56 100644
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

