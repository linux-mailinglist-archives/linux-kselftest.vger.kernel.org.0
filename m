Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C9341A40F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhI1AMr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Sep 2021 20:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238253AbhI1AMr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Sep 2021 20:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34621611CE;
        Tue, 28 Sep 2021 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632787869;
        bh=e0biuuUrxQBT6LwpPLtkePfaM2PRMIsMY1zCFndAnbo=;
        h=From:To:Cc:Subject:Date:From;
        b=RJaEqtQXdLxj6Bv/EYcrKJ4xld+xTLIqUyaaZth7z7NGNxViLNOX/7hH+DXJ2Pss3
         erVJhPu5aeU7raUaGQbGnCQ8Z7FA0dmOJIeYDfWl6vDDa9XLEffU/34wMdKLx6oimn
         X28SO9GMjmBaM/bdoywAoFvNvrW3kAejHn+w4yOCEnZKXqEaUUI5ClQ/tSopmoQofb
         jtjs5Ne2ZikLopaJnt3gifHQ0l593ylx/iXuQTzkyGatobUpOIGvbPxvHQbCp0WuSk
         Hkb67Hb+QpO4nnPwkgw1xQBpkjtV5Ndkeikk19PhMpRt1rP041FwuJD41MV+cPFy4G
         wdgCd6DclL/7w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Stop tracing before searching non-exist event entry
Date:   Tue, 28 Sep 2021 09:11:06 +0900
Message-Id: <163278786632.187921.7275187717663096458.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stop tracing before searching the pattern which is expected to
not exist on the trace buffer. In some case, it will take too
long and may not come back eternally because while searching
the tracing data will be increased by the searching activity.

I found this with enabling kernel debug options, like kmemleak,
lockdep etc. and run it on qemu with 2 CPUs. It did not come
back in 20 minutes and finally I need to interrupt it to stop.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func_profiler.tc          |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
index 1dbd766c0cd2..440f4d87aa4b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
@@ -56,6 +56,9 @@ clear_trace
 sleep 1
 
 echo "make sure something other than scheduler is being traced"
+
+echo 0 > tracing_on
+
 if ! grep -v -e '^#' -e 'schedule' trace > /dev/null; then
 	cat trace
 	fail "no other functions besides schedule was found"

