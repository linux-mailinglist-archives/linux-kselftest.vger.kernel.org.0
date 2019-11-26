Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7997B109A37
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfKZIeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 03:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKZIeK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 03:34:10 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C04D20678;
        Tue, 26 Nov 2019 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574757250;
        bh=NhI4EfKwPcLoYXk+wFbO8vNvXMQ5HBUlN7GfedQK2uA=;
        h=From:To:Cc:Subject:Date:From;
        b=MFHxPOoLgYIcHgJVoMBhGikpoqo549+5B9Wtrtr0Rt/GPLUSM7H87WfsfbF76xvm0
         XHn98ARm78nD/nbxHcoKaGT8SMp81k4KNUrFKbQguVZIB+lc73lyWi6t+W9WkqTwYR
         ZHmfIeOViGnuwqLKIbZMIRJypk1z8lto8tl+SUUw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v4 0/4] selftests/ftrace: Fix ftracetest testcases for non-function tracer case
Date:   Tue, 26 Nov 2019 17:34:07 +0900
Message-Id: <157475724667.3389.15752644047898709246.stgit@devnote2>
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

Here is the 4th version of patches to fix some issues which happens on
the kernel with CONFIG_FUNCTION_TRACER=n or CONFIG_DYNAMIC_FTRACE=n.

In this version I fixed [1/4] to cleanup set_ftrace_notrace (Thanks Steve!)

Thank you,

---

Masami Hiramatsu (4):
      selftests/ftrace: Fix to check the existence of set_ftrace_filter
      selftests/ftrace: Fix ftrace test cases to check unsupported
      selftests/ftrace: Do not to use absolute debugfs path
      selftests/ftrace: Fix multiple kprobe testcase


 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 tools/testing/selftests/ftrace/test.d/functions    |    5 ++++-
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    6 +++---
 .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
 .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
 .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
 7 files changed, 19 insertions(+), 9 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
