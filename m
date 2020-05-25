Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB781E0BB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 May 2020 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgEYKVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 May 2020 06:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbgEYKVB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 May 2020 06:21:01 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D85720723;
        Mon, 25 May 2020 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590402061;
        bh=Vn+k1qgmOwxaqp1iLj7LYkWvDJze5UUoBCJFchqwW2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bLJYJIUd/rAZqeYpdF2qybKrlrfzbRP27pDhYdXi5fGRCASSX+Y6BzHfWBFCeoWel
         GL5GVpUdFbgzSKvt40WWQ26PQLonwUqSTTuRu56xGYpiKHMZqvcfOarXDfDJc0lUA+
         TbeluNx4c7sCvAYxpAkrLEqqTkCDfho/HQXN22rA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Return unsupported if no error_log file
Date:   Mon, 25 May 2020 19:20:57 +0900
Message-Id: <159040205682.10129.10826221002090446642.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check whether error_log file exists in tracing/error_log testcase
and return UNSUPPORTED if no error_log file.

This can happen if we run the ftracetest on the older stable
kernel.

Fixes: 4eab1cc461a6 ("selftests/ftrace: Add tracing/error_log testcase")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
index 021c03fd885d..23465823532b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -14,6 +14,8 @@ if [ ! -f set_event ]; then
     exit_unsupported
 fi
 
+[ -f error_log ] || exit_unsupported
+
 ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
 
 exit 0

