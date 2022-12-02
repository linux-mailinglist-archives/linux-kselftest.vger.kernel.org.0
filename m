Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7357B640BAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiLBREk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 12:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiLBREP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 12:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830CE802B;
        Fri,  2 Dec 2022 09:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDB57B821F7;
        Fri,  2 Dec 2022 17:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98815C433C1;
        Fri,  2 Dec 2022 17:03:33 +0000 (UTC)
Date:   Fri, 2 Dec 2022 12:03:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] selftests/ftrace: Use long for synthetic event probe test
Message-ID: <20221202120331.343a821d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From 8bb1734388b89bdb2ac176882786dc02b7df92c2 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Wed, 30 Nov 2022 17:31:34 -0500
Subject: [PATCH] selftests/ftrace: Use long for synthetic event probe test

On 32bit the trigger-synthetic-eprobe.tc selftest fails with the error:

hist:syscalls:sys_exit_openat: error: Param type doesn't match synthetic event field type
  Command: hist:keys=common_pid:filename=$__arg__1,ret=ret:onmatch(syscalls.sys_enter_openat).trace(synth_open,$filename,$ret)
                                                                                                               ^
This is because the synth_open synthetic event is created with:

  echo "$SYNTH u64 filename; s64 ret;" > synthetic_events

Which works fine on 64 bit, as filename is a pointer and the return is
also a long. But for 32 bit architectures, it doesn't work.

Use "unsigned long" and "long" instead so that it works for both 64 bit
and 32 bit architectures.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/trigger/inter-event/trigger-synthetic-eprobe.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
index 6461c375694f..c2a8ab01e13b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc
@@ -14,7 +14,7 @@ FIELD="filename"
 SYNTH="synth_open"
 EPROBE="eprobe_open"
 
-echo "$SYNTH u64 filename; s64 ret;" > synthetic_events
+echo "$SYNTH unsigned long filename; long ret;" > synthetic_events
 echo "hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
 echo "hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
 
-- 
2.35.1

