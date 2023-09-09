Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8E799603
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 05:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjIIDXj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 23:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjIIDXh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED51FF5;
        Fri,  8 Sep 2023 20:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC5C433CD;
        Sat,  9 Sep 2023 03:23:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZb-000YkY-0G;
        Fri, 08 Sep 2023 23:23:51 -0400
Message-ID: <20230909032350.900547495@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Naveen N Rao <naveen@kernel.org>
Subject: [for-linus][PATCH 14/15] selftests/ftrace: Fix dependencies for some of the synthetic event
 tests
References: <20230909031615.047488015@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Naveen N Rao <naveen@kernel.org>

Commit b81a3a100cca1b ("tracing/histogram: Add simple tests for
stacktrace usage of synthetic events") changed the output text in
tracefs README, but missed updating some of the dependencies specified
in selftests. This causes some of the tests to exit as unsupported.

Fix this by changing the grep pattern. Since we want these tests to work
on older kernels, match only against the common last part of the
pattern.

Link: https://lore.kernel.org/linux-trace-kernel/20230614091046.2178539-1-naveen@kernel.org

Cc: <linux-kselftest@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Fixes: b81a3a100cca ("tracing/histogram: Add simple tests for stacktrace usage of synthetic events")
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../trigger/inter-event/trigger-synthetic-event-dynstring.tc    | 2 +-
 .../inter-event/trigger-synthetic_event_syntax_errors.tc        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 213d890ed188..174376ddbc6c 100644
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
index 955e3ceea44b..b927ee54c02d 100644
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
-- 
2.40.1
