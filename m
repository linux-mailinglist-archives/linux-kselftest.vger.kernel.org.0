Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09666B9227
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 12:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCNLx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNLx4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 07:53:56 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCD18AA6;
        Tue, 14 Mar 2023 04:53:55 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4PbX402HfLzvjfn; Tue, 14 Mar 2023 12:53:52 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/clone3: fix number of tests in ksft_set_plan
Date:   Tue, 14 Mar 2023 12:53:52 +0100
Message-Id: <20230314115352.20623-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
added an additional test, so the number passed to ksft_set_plan needs to
be bumped accordingly.

Also use ksft_finish to print results and exit. This will catch future
mismatches between ksft_set_plan and the number of tests being run.

Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/clone3/clone3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 4fce46afe6db..7b45c9854202 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -129,7 +129,7 @@ int main(int argc, char *argv[])
 	uid_t uid = getuid();
 
 	ksft_print_header();
-	ksft_set_plan(17);
+	ksft_set_plan(18);
 	test_clone3_supported();
 
 	/* Just a simple clone3() should return 0.*/
-- 
2.39.1

