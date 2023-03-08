Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D86B0538
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCHLAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjCHLAe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:00:34 -0500
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 03:00:30 PST
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E887366
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Mar 2023 03:00:30 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4PWq0x6dkyzvjhV; Wed,  8 Mar 2023 11:53:20 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <--cc=linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Andrey Vagin <avagin@openvz.org>
Subject: [PATCH 2/2] selftests/clone3: test clone3 with CLONE_NEWTIME
Date:   Wed,  8 Mar 2023 11:53:20 +0100
Message-Id: <20230308105320.10685-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20230308105126.10107-1-tklauser@distanz.ch>
References: <20230308105126.10107-1-tklauser@distanz.ch>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Verify that clone3 can be called successfully with CLONE_NEWTIME in
flags.

Cc: Andrey Vagin <avagin@openvz.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/clone3/clone3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index cd4582129c7d..4fce46afe6db 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -195,5 +195,8 @@ int main(int argc, char *argv[])
 	test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
 			CLONE3_ARGS_NO_TEST);
 
+	/* Do a clone3() in a new time namespace */
+	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
+
 	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
 }
-- 
2.39.1

