Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575BD67B827
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAYRNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjAYRNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74781A5C3;
        Wed, 25 Jan 2023 09:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEBBB81B4A;
        Wed, 25 Jan 2023 17:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D970EC433A0;
        Wed, 25 Jan 2023 17:13:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKjL8-004NqF-2j;
        Wed, 25 Jan 2023 12:13:38 -0500
Message-ID: <20230125171338.659803282@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 12:12:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-kselftest@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [for-next][PATCH 02/12] tracing/selftests: Add test for event filtering on function name
References: <20230125171252.431857411@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

With the new filter logic of passing in the name of a function to match an
instruction pointer (or the address of the function), add a test to make
sure that it is functional.

This is also the first test to test plain filtering. The filtering has
been tested via the trigger logic, which uses the same code, but there was
nothing to test just the event filter, so this test is the first to add
such a case.

Link: https://lkml.kernel.org/r/20221219183214.075559302@goodmis.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: linux-kselftest@vger.kernel.org
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/filter/event-filter-function.tc    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
new file mode 100644
index 000000000000..e2ff3bf4df80
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter function - test event filtering on functions
+# requires: set_event events/kmem/kmem_cache_free/filter
+# flags: instance
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo "Test event filter function name"
+echo 0 > tracing_on
+echo 0 > events/enable
+echo > trace
+echo 'call_site.function == exit_mmap' > events/kmem/kmem_cache_free/filter
+echo 1 > events/kmem/kmem_cache_free/enable
+echo 1 > tracing_on
+ls > /dev/null
+echo 0 > events/kmem/kmem_cache_free/enable
+
+hitcnt=`grep kmem_cache_free trace| grep exit_mmap | wc -l`
+misscnt=`grep kmem_cache_free trace| grep -v exit_mmap | wc -l`
+
+if [ $hitcnt -eq 0 ]; then
+	exit_fail
+fi
+
+if [ $misscnt -gt 0 ]; then
+	exit_fail
+fi
+
+address=`grep ' exit_mmap$' /proc/kallsyms | cut -d' ' -f1`
+
+echo "Test event filter function address"
+echo 0 > tracing_on
+echo 0 > events/enable
+echo > trace
+echo "call_site.function == 0x$address" > events/kmem/kmem_cache_free/filter
+echo 1 > events/kmem/kmem_cache_free/enable
+echo 1 > tracing_on
+sleep 1
+echo 0 > events/kmem/kmem_cache_free/enable
+
+hitcnt=`grep kmem_cache_free trace| grep exit_mmap | wc -l`
+misscnt=`grep kmem_cache_free trace| grep -v exit_mmap | wc -l`
+
+if [ $hitcnt -eq 0 ]; then
+	exit_fail
+fi
+
+if [ $misscnt -gt 0 ]; then
+	exit_fail
+fi
+
+reset_events_filter
+
+exit 0
-- 
2.39.0
