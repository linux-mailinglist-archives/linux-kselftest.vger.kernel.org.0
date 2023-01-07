Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A7660F1C
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jan 2023 14:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjAGNcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Jan 2023 08:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjAGNcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Jan 2023 08:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98795D415;
        Sat,  7 Jan 2023 05:32:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575A360C14;
        Sat,  7 Jan 2023 13:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D1C433D2;
        Sat,  7 Jan 2023 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673098350;
        bh=lA+rE8kKU4UerwopcQ1eDt8yxXIRd212goJdv8X2Ulo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kX2M9ZVPoclER5r+AYgjQNDSJPnG2X0VHHYExO94dzwNPeeIwexodLfSdEtSHz53T
         bRIVV77kkNHpyFAG0a3VQyfdq7TJ/tJZcYHCehITGUgcpAsHb/yFmG6hV+uyCHlG3W
         bGMNDuAVxWUt0bzV62ordUOSXhHNPsKi2fi6PEyThPykZUoVpV+CAolu2JAKwUcwzL
         cCBW3jih6ABBjXOxH4YtoU+S0iTZhLYXUwZUGGhWz7uEZ8Av0Wr7LTav/vja7VdFJM
         PSmtvrlnuouQVx5BrVyq1kH/3eOds0fy9dbhURyXv7uKocmtRLcUIZfA3j6Rh/9xKx
         K+U9yjfSNjhng==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests/ftrace: Fix eprobe syntax test case to check filter support
Date:   Sat,  7 Jan 2023 22:32:27 +0900
Message-Id: <167309834742.640500.379128668288448035.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <167309832823.640500.13244630381161014364.stgit@devnote3>
References: <167309832823.640500.13244630381161014364.stgit@devnote3>
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

Fix eprobe syntax test case to check whether the kernel supports the filter
on eprobe for filter syntax test command. Without this fix, this test case
will fail if the kernel supports eprobe but doesn't support the filter on
eprobe.

Fixes: 9e14bae7d049 ("selftests/ftrace: Add eprobe syntax error testcase")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
index fc1daac7f066..4f5e8c665156 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -22,6 +22,8 @@ check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
 check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
 check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'	# BAD_ATTACH_ARG
 
-check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER
+if grep -q '<attached-group>\.<attached-event>.*\[if <filter>\]' README; then
+  check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER
+fi
 
 exit 0

