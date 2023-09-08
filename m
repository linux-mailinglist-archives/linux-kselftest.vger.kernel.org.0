Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A07799212
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 00:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjIHWRK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjIHWRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 18:17:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977681FC9;
        Fri,  8 Sep 2023 15:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE4C433C7;
        Fri,  8 Sep 2023 22:17:04 +0000 (UTC)
Date:   Fri, 8 Sep 2023 18:17:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace/selftests: Add softlink to latest log directory
Message-ID: <20230908181721.00f7eb71@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

When I'm debugging something with the ftrace selftests and need to look at
the logs, it becomes tedious that I need to do the following:

 ls -ltr logs
 [ copy the last directory ]
 ls logs/<paste-last-dir>

to see where the logs are.

Instead, do the common practice of having a "latest" softlink to the last
run selftest. This way after running the selftest I only need to do:

 ls logs/latest/

and it will always give me the directory of the last run selftest logs!

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index cb5f18c06593..7df8baa0f98f 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -124,6 +124,7 @@ parse_opts() { # opts
     ;;
     --logdir|-l)
       LOG_DIR=$2
+      LINK_PTR=
       shift 2
     ;;
     *.tc)
@@ -181,7 +182,10 @@ fi
 TOP_DIR=`absdir $0`
 TEST_DIR=$TOP_DIR/test.d
 TEST_CASES=`find_testcases $TEST_DIR`
-LOG_DIR=$TOP_DIR/logs/`date +%Y%m%d-%H%M%S`/
+LOG_TOP_DIR=$TOP_DIR/logs
+LOG_DATE=`date +%Y%m%d-%H%M%S`
+LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
+LINK_PTR=$LOG_TOP_DIR/latest
 KEEP_LOG=0
 KTAP=0
 DEBUG=0
@@ -207,6 +211,10 @@ else
   LOG_FILE=$LOG_DIR/ftracetest.log
   mkdir -p $LOG_DIR || errexit "Failed to make a log directory: $LOG_DIR"
   date > $LOG_FILE
+  if [ "x-$LINK_PTR" != "x-" ]; then
+    unlink $LINK_PTR
+    ln -fs $LOG_DATE $LINK_PTR
+  fi
 fi
 
 # Define text colors
