Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061C7DA507
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 05:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjJ1DeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1DeT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 23:34:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC2106
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 20:34:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE39C433C7;
        Sat, 28 Oct 2023 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698464056;
        bh=GSCg8MotGa6UfxyDTlFmyiyhwNgWtF3ruxwlA0Hr0wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=uLYxybp8qzfs3zZKcm40jtkuui2m6uv/ZU/cCNRwQnlpWRCDcr5YpdMycqRhhyGOO
         frv14rnFL8o5KvYRD6kKK0qeknBW8hxTo08XGgzUM+3x9fRafKz5bX3GLuujjEE+/A
         IuOZvbwtzk/98H237798PTm0kiYylLeThZS9wQ9isTUOO58yeuP6Z43oJVFVOQbOAY
         z6AqXaQMSYg+cpEV3oGtRGU+HGV8bTYZNwBa1xuB5KZv+hkJ4nmmlsNjP/xsjWr281
         6JjeSbI3+ImF0m28cOhqu9m3iiN1amU29qtB/7pGtAhdeHdozClxB+hP5JnBn/ajxv
         l8RTfu4oGLapA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Add test case for a symbol in a module without module name
Date:   Sat, 28 Oct 2023 12:34:12 +0900
Message-Id: <169846405196.88147.17766692778800222203.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a test case for probing on a symbol in a module without module name.
When probing on a symbol in a module, ftrace accepts both the syntax that
<MODNAME>:<SYMBOL> and <SYMBOL>. Current test case only checks the former
syntax. This adds a test for the latter one.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_module.tc          |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index 7e74ee11edf9..4b32e1b9a8d3 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -13,6 +13,12 @@ fi
 MOD=trace_printk
 FUNC=trace_printk_irq_work
 
+:;: "Add an event on a module function without module name" ;:
+
+echo "p:event0 $FUNC" > kprobe_events
+test -d events/kprobes/event0 || exit_failure
+echo "-:kprobes/event0" >> kprobe_events
+
 :;: "Add an event on a module function without specifying event name" ;:
 
 echo "p $MOD:$FUNC" > kprobe_events

