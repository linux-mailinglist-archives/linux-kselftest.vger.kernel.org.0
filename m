Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F7272F8D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbjFNJQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFNJQ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 05:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852619A;
        Wed, 14 Jun 2023 02:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FDD63DB4;
        Wed, 14 Jun 2023 09:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726EDC433C8;
        Wed, 14 Jun 2023 09:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686734186;
        bh=qCYtDEkJIsAAneLcaHdq99ShqXpvpDVAtXNVqr0abXw=;
        h=From:To:Cc:Subject:Date:From;
        b=aB8IRJMAdIix0fvOi2TCSHCN8ctHlA2WEMSYaRTg8BYRvIwXAIetS7RGQHQMQUXC2
         hjVM5AzXtA/VmXktwMtFgKZH8TvL4NzHvhhwpPJZIMB6jaVf1U7fHsrBdqTQ2gK741
         2bk/Aruj4+5KMp56i5ohpHTgV7sPPqYD1zh+CMhwO5cylU3Wa0WwiA1v890OfId8Cy
         7pW1K5n82/IuBDVSfJ4xvc3U62iOqrX4p2aymKE1+ESrltYlwxr6hLAbFnN9z1wg2D
         pEDuinCPOFUhzHSjgYE+8t7wqHV8h2OKPn4moDnr7xtaGAPHkOOaqqnxztiw1ThUnJ
         LlV2NmG/TKSVQ==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/ftrace: Fix dependencies for some of the synthetic event tests
Date:   Wed, 14 Jun 2023 14:40:46 +0530
Message-Id: <20230614091046.2178539-1-naveen@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit b81a3a100cca1b ("tracing/histogram: Add simple tests for
stacktrace usage of synthetic events") changed the output text in
tracefs README, but missed updating some of the dependencies specified
in selftests. This causes some of the tests to exit as unsupported.

Fix this by changing the grep pattern. Since we want these tests to work
on older kernels, match only against the common last part of the
pattern.

Fixes: b81a3a100cca ("tracing/histogram: Add simple tests for stacktrace usage of synthetic events")
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 .../trigger/inter-event/trigger-synthetic-event-dynstring.tc    | 2 +-
 .../inter-event/trigger-synthetic_event_syntax_errors.tc        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 213d890ed1886e..174376ddbc6c7a 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "' >> synthetic_events":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
index 955e3ceea44b5b..b927ee54c02da5 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser errors
-# requires: synthetic_events error_log "char name[]' >> synthetic_events":README
+# requires: synthetic_events error_log "' >> synthetic_events":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'

base-commit: dbcf76390eb9a65d5d0c37b0cd57335218564e37
-- 
2.40.1

