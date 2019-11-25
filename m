Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00AA1088D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 07:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYG44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 01:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYG4z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 01:56:55 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2BD20679;
        Mon, 25 Nov 2019 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574665015;
        bh=BMLaCwsngB/HdLBRSJI+6cd9xLQhImPzjy3DKs9abbc=;
        h=From:To:Cc:Subject:Date:From;
        b=L+wEJ33PJz6Y+agzR82A4B782GG55WpubyIgQmw1DI830clVfSfU19C8ZlgGQqm59
         3xyyVba/CK0neafDI2dFZctYajkbYlnYcTfbApZQyjltCc4ph5OKDsE9idL0PoSqzB
         TY9BDh+Os3PoyOsYlJJKzWJz38YzURGlIdTPw8SQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v3 0/4] selftests/ftrace: Fix ftracetest testcases for non-function tracer case
Date:   Mon, 25 Nov 2019 15:56:51 +0900
Message-Id: <157466501169.21973.31401747181477687.stgit@devnote2>
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

Here is the 3rd version of patches to fix some issues which happens on
the kernel with CONFIG_FUNCTION_TRACER=n or CONFIG_DYNAMIC_FTRACE=n.

In this version and v2, I updated the descriptions of the first 2 patches
according to Steve's comment, added Steve's Reviewed-by to the 3rd patch,
and added the 4th patch which was newly found.

Thank you,

---

Masami Hiramatsu (4):
      selftests/ftrace: Fix to check the existence of set_ftrace_filter
      selftests/ftrace: Fix ftrace test cases to check unsupported
      selftests/ftrace: Do not to use absolute debugfs path
      selftests/ftrace: Fix multiple kprobe testcase


 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 tools/testing/selftests/ftrace/test.d/functions    |    4 +++-
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    6 +++---
 .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
 .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
 .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
 7 files changed, 18 insertions(+), 9 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
