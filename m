Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18A676A54
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jan 2023 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAUXc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 18:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUXc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 18:32:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526910250;
        Sat, 21 Jan 2023 15:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F44060918;
        Sat, 21 Jan 2023 23:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE0BC433D2;
        Sat, 21 Jan 2023 23:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674343974;
        bh=xmn62+MR0FZVY202glZIVA2fWAdWaDi9PFeFOODhzlo=;
        h=From:To:Cc:Subject:Date:From;
        b=ucCJ5P6k2XO8FZmWC7j/0m3scJ+JP8M3Lt7rAMloSoivtrbhwI5Uk0TXgnZazsYQ7
         XCS1ozVJ2jOAIU/IWRJYYRfnf2HFoavTPDm31X9bX6zoqghYqPcq7acRRlYXiFqyM7
         dZIt7j+WFjX7TMRO9ZXMXgtmP6yWXY7zh0heuCAq+UM4hhJWVAeCJpYG5EKoqeuon7
         ftjBLJ7LzmwheSgDjrtP8c6bv93PUsjMdqyMEs4yEaF7jbSHzYrFgNP5xggFnkhq6y
         eVdjJC5keIt1s5R1jNeTAFcSKDYeXqCMo0SCDzcxSqwU7VFGzCohPnngBqR3sTzh41
         pJt27ge1chd8Q==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Yipeng Zou <zouyipeng@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix bash specific "==" operator
Date:   Sun, 22 Jan 2023 08:32:50 +0900
Message-Id: <167434397083.3069767.14730152459198287532.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit a1d6cd88c897 ("selftests/ftrace: event_triggers: wait
longer for test_event_enable") introduced bash specific "=="
comparation operator, that test will fail when we run it on a
posix-shell. `checkbashisms` warned it as below.

possible bashism in ftrace/func_event_triggers.tc line 45 (should be 'b = a'):
        if [ "$e" == $val ]; then

This replaces it with "=".

Fixes: a1d6cd88c897 ("selftests/ftrace: event_triggers: wait longer for test_event_enable")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
index 3eea2abf68f9..2ad7d4b501cc 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_event_triggers.tc
@@ -42,7 +42,7 @@ test_event_enabled() {
 
     while [ $check_times -ne 0 ]; do
 	e=`cat $EVENT_ENABLE`
-	if [ "$e" == $val ]; then
+	if [ "$e" = $val ]; then
 	    return 0
 	fi
 	sleep $SLEEP_TIME

