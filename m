Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5710B1EC773
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 04:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFCCkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 22:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgFCCkX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A388820757;
        Wed,  3 Jun 2020 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591152023;
        bh=VfQvDWSn/f05Fb8HRvfqUjtKhARLcQsB2AaWUbTXdcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APbAt4lv8UAhUkXxGDy9cCxDUNYDGAbXQvNcC5W6fmeWT902i7cUE55sB+HF3tW6X
         woVqdp4QTGuK47xf2y87vjc1V51KVC1oohIouxz+4mFiEwva+PE/0FYnIUWuWJhOJ8
         xFgz+vZ0XGA7gLIL/HZXbM4MLeo7p54Rdg2nnUKU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/7] selftests/ftrace: Return unsupported for the unconfigured features
Date:   Wed,  3 Jun 2020 11:40:19 +0900
Message-Id: <159115201908.70027.9721176218630572669.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159115200085.70027.6141550347953439240.stgit@devnote2>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As same as other test cases, return unsupported if kprobe_events
or argument access feature are not found.

There can be a new arch which does not port those features yet,
and an older kernel which doesn't support it.
Those can not enable the features.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
---
 .../ftrace/test.d/direct/kprobe-direct.tc          |    2 +-
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
index 801ecb63e84c..e95b744b23e4 100644
--- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -10,7 +10,7 @@ fi
 
 if [ ! -f kprobe_events ]; then
 	echo "No kprobe_events file -please build CONFIG_KPROBE_EVENTS"
-	exit_unresolved;
+	exit_unsupported;
 fi
 
 echo "Let the module run a little"
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index 0f60087583d8..b41471f301ab 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -4,7 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-grep -q '\$arg<N>' README || exit_unresolved # depends on arch
+grep -q '\$arg<N>' README || exit_unsupported # depends on arch
 grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
 grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
 

