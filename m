Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE627FC0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgJAI4y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 04:56:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbgJAI4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 04:56:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kNuOH-00084E-Rv; Thu, 01 Oct 2020 08:56:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: check for do_sys_openat2 in user-memory test
Date:   Thu,  1 Oct 2020 09:56:41 +0100
Message-Id: <20201001085641.51130-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

More recent libc implementations are now using openat/openat2 system
calls so also add do_sys_openat2 to the tracing so that the test
passes on these systems because do_sys_open may not be called.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index a30a9c07290d..cf1b4c3e9e6b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -9,6 +9,8 @@ grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 :;: "user-memory access syntax and ustring working on user memory";:
 echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
 	> kprobe_events
+echo 'p:myevent2 do_sys_openat2 path=+0($arg2):ustring path2=+u0($arg2):string' \
+	> kprobe_events
 
 grep myevent kprobe_events | \
 	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
-- 
2.27.0

