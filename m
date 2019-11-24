Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB61081A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2019 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXEze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Nov 2019 23:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKXEze (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Nov 2019 23:55:34 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D8B2073F;
        Sun, 24 Nov 2019 04:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574571333;
        bh=0CuBaOkD0kZlfygG7//3oYVtOE04F+HFqdcsIYasqxA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ug/ETyO8KGS+t3KruWh37nI+izedPQ/p2X1Ccx/A6yNCZJ47RVxV3+AczM3Fvh+iR
         NjC9jN7nZLt+KHlOrbpvRsX4PjIlgab24iCo47dT8mIocN6UhLUatffG9yoR0+NqvK
         BdFC/bi9EDIIo764kskUwK05ohU0bFrSIRJjgZMk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for non-function tracer case
Date:   Sun, 24 Nov 2019 13:55:30 +0900
Message-Id: <157457133001.25666.5309062776021151107.stgit@devnote2>
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

Here is a series of patches to fix some issues which happens on
the kernel with CONFIG_FUNCTION_TRACER=n but CONFIG_TRACER=y.

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
