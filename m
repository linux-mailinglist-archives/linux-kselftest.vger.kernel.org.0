Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88E1085E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 01:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKYALQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Nov 2019 19:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfKYALP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Nov 2019 19:11:15 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D71E207DD;
        Mon, 25 Nov 2019 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574640675;
        bh=B3WxPaJEsDK9KblA7E9S/nSP1kSgzrcxzrBva4kbfoE=;
        h=From:To:Cc:Subject:Date:From;
        b=QEDfsWi9GirxODUwIxqOgqfjtQ6KBgV3tpBn+ZLRg6UK2Uhl3g4FTtez5of/cg34W
         vQhH9pGrJ/K74wbKuYD1T5zzJIP/2EW35YsgxpDYiAeg9MxmDWQxuXvBv14Vc687Bi
         yMWe6afK1I1KqLGUSb0ChZrjxevq3l/DFXsxR3w4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v2 0/3] selftests/ftrace: Fix ftracetest testcases for non-function tracer case
Date:   Mon, 25 Nov 2019 09:11:12 +0900
Message-Id: <157464067201.2006.6413506591718899129.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here is the 2nd version of patches to fix some issues which happens on
the kernel with CONFIG_FUNCTION_TRACER=n or CONFIG_DYNAMIC_FTRACE=n.
In this version I just updated the descriptions of the first 2 patches
according to Steve's comment and add his Reviewed-by to the last patch.

Thank you,

---

Masami Hiramatsu (3):
      selftests/ftrace: Fix to check the existence of set_ftrace_filter
      selftests/ftrace: Fix ftrace test cases to check unsupported
      selftests/ftrace: Do not to use absolute debugfs path


 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 tools/testing/selftests/ftrace/test.d/functions    |    4 +++-
 .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
 .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
 .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
 6 files changed, 15 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
