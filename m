Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7307DB581
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 09:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjJ3Iyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3Iyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 04:54:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707494;
        Mon, 30 Oct 2023 01:54:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F9DEC433C7;
        Mon, 30 Oct 2023 08:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1698656086; bh=Y6RkweAiaJcVTeeS6WX5S7GACsI1tkgdNxGrycq560I=;
        h=From:Date:Subject:To:Cc:From;
        b=cn+rmzhle65x84iyJBGFRYCM2SAQk6RZcrLyMpA0vG4eQkzCnT94mAodYULDbIJHP
         kTk1MQvNbEo7Y+DyDz3wOOafQ8FCAN5+0dg0GMXigbyOxhBNoXvfNcWPyjEW0bL88P
         Crlsmg8Y44fGHA6XivePoPKWiIhN/LW3EyfSEkoU=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 15061C4332F;
        Mon, 30 Oct 2023 08:54:46 +0000 (UTC)
From:   Itaru Kitayama <itaru.kitayama@linux.dev>
Date:   Mon, 30 Oct 2023 17:54:45 +0900
Subject: [PATCH] Lower the ptrace permissions so that the memfd_secrect
 test program runs without an issue.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-selftest-v1-1-743df68bb996@linux.dev>
X-B4-Tracking: v=1; b=H4sIAFRvP2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA2MD3eLUnLSS1OIS3WRz0yTDJBMzAwtDcyWg8oKi1LTMCrBR0bG1tQB
 ajs+YWgAAAA==
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Itaru Kitayama <itaru.kitayama@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698656085; l=1171;
 i=itaru.kitayama@linux.dev; s=20231030; h=from:subject:message-id;
 bh=0yXLvAw3hkhizEEQX735jRdYWkFus1UusgKEaYjOuWM=;
 b=89ytidZI13PJru53wdET0bYxdvD3UHcUSfWSvoeULHl5lYVnnUAZXTBUz7i3iDUa7HYr/SDzo
 9SsAc+E87oFCrEQEpJS+9zCDSPF8qhi3AinWq3wst4TTeAt6gA+9RPt
X-Developer-Key: i=itaru.kitayama@linux.dev; a=ed25519;
 pk=4yYhz2CbKL7F2qR5IzP7QvqM9B6c+dfWJRHWez+rMDw=
X-Endpoint-Received: by B4 Relay for itaru.kitayama@linux.dev/20231030 with auth_id=92
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



---
On Ubuntu and probably other distros, ptrace permissions are tightend a
bit by default; i.e., /proc/sys/kernel/yama/ptrace_score is set to 1.
This cases memfd_secret's ptrace attach test fails with a permission
error. Set it to 0 piror to running the program. 

Signed-off-by: Itaru Kitayama <itaru.kitayama@linux.dev>
---
 tools/testing/selftests/mm/run_vmtests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3e2bc818d566..7d31718ce834 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -303,6 +303,7 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
+echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
 CATEGORY="memfd_secret" run_test ./memfd_secret
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-selftest-c75b1b460817

Best regards,
-- 
Itaru Kitayama <itaru.kitayama@linux.dev>

