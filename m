Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14C91EC76F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgFCCkF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 22:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCCkF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 22:40:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C58320663;
        Wed,  3 Jun 2020 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591152004;
        bh=+31w9c0mvbe/cCFWUmlmX11hEzkM5dYU3hArBzTz8j8=;
        h=From:To:Cc:Subject:Date:From;
        b=gWkGUW6+6m8DHimK44S5gJp/xNxUSTvXmJemlTxRG/BxDqS6l8jG0CAz2z8KBC4zD
         OtPWhTAcvyksypsbUoFSj6tJlWJ6WOmQyTbLb4U1TMMgUPW1n6KjXhLtySf1rA2jbZ
         RGD21c9u1K2l2BCa/fbJNDXpEZR95hpWJCdqpylM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 0/7] selftsts/ftrace: Add requires list for each test case
Date:   Wed,  3 Jun 2020 11:40:01 +0900
Message-Id: <159115200085.70027.6141550347953439240.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Here is the 3rd version of the series of "requires:" list for
simplifying and unifying requirement checks for each test case.

The previous version is here.

https://lkml.kernel.org/r/159108888259.42416.547252366885528860.stgit@devnote2

I've fixed a comment in the template file in this version.

In short, this series introduces "requires:" line instead of
checking required ftrace interfaces in each test case.

The requires line supports following checks
 - tracefs interface check: Check whether the given file or directory
   in the tracefs. (No suffix) [3/7],[4/7],[5/7]
 - available tracer check: Check whether the given tracer is available
   (":tracer" suffix) [6/7]
 - README feature check: Check whether the given string is in the
   README (":README" suffix) [7/7]

This series also includes the description line fix and
unresolved -> unsupported change ([1/7] and [2/7]).

Since this series depends on following 2 commits,

commit 619ee76f5c9f ("selftests/ftrace: Return unsupported if no
 error_log file") on Shuah's Kselftest tree
commit bea24f766efc ("selftests/ftrace: Distinguish between hist
 and synthetic event checks") on Steven's Tracing tree

This can be applied on the tree which merged both of them.
Also, you can get the series from the following.

 git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git ftracetest-requires-v3


Thank you,

---

Masami Hiramatsu (7):
      selftests/ftrace: Allow ":" in description
      selftests/ftrace: Return unsupported for the unconfigured features
      selftests/ftrace: Add "requires:" list support
      selftests/ftrace: Convert required interface checks into requires list
      selftests/ftrace: Convert check_filter_file() with requires list
      selftests/ftrace: Support ":tracer" suffix for requires
      selftests/ftrace: Support ":README" suffix for requires


 tools/testing/selftests/ftrace/ftracetest          |   11 ++++++-
 .../selftests/ftrace/test.d/00basic/snapshot.tc    |    3 +-
 .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |    3 +-
 .../ftrace/test.d/direct/kprobe-direct.tc          |    6 +---
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |    6 +---
 .../ftrace/test.d/dynevent/add_remove_synth.tc     |    5 +--
 .../ftrace/test.d/dynevent/clear_select_events.tc  |   11 +------
 .../ftrace/test.d/dynevent/generic_clear_event.tc  |    8 +----
 .../selftests/ftrace/test.d/event/event-enable.tc  |    6 +---
 .../selftests/ftrace/test.d/event/event-no-pid.tc  |   11 +------
 .../selftests/ftrace/test.d/event/event-pid.tc     |   11 +------
 .../ftrace/test.d/event/subsystem-enable.tc        |    6 +---
 .../ftrace/test.d/event/toplevel-enable.tc         |    6 +---
 .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |   14 +--------
 .../ftrace/test.d/ftrace/fgraph-filter.tc          |    8 +----
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |    8 +----
 .../test.d/ftrace/func-filter-notrace-pid.tc       |   13 +-------
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |   13 +-------
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    3 +-
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    6 +---
 .../ftrace/test.d/ftrace/func_event_triggers.tc    |    7 ++---
 .../ftrace/test.d/ftrace/func_mod_trace.tc         |    3 +-
 .../ftrace/test.d/ftrace/func_profile_stat.tc      |    3 +-
 .../ftrace/test.d/ftrace/func_profiler.tc          |   12 +-------
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |    6 ++--
 .../ftrace/test.d/ftrace/func_stack_tracer.tc      |    8 +----
 .../test.d/ftrace/func_traceonoff_triggers.tc      |    6 ++--
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |   12 ++------
 tools/testing/selftests/ftrace/test.d/functions    |   28 ++++++++++++++----
 .../ftrace/test.d/instances/instance-event.tc      |    6 +---
 .../selftests/ftrace/test.d/instances/instance.tc  |    6 +---
 .../ftrace/test.d/kprobe/add_and_remove.tc         |    3 +-
 .../selftests/ftrace/test.d/kprobe/busy_check.tc   |    3 +-
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |    3 +-
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    5 +--
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    5 +--
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    4 +--
 .../ftrace/test.d/kprobe/kprobe_eventname.tc       |    3 +-
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    6 +---
 .../ftrace/test.d/kprobe/kprobe_module.tc          |    3 +-
 .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |    5 +--
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    5 +--
 .../ftrace/test.d/kprobe/kretprobe_args.tc         |    3 +-
 .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    4 +--
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    3 +-
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    3 +-
 .../selftests/ftrace/test.d/kprobe/profile.tc      |    3 +-
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 +--
 .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |    4 +--
 tools/testing/selftests/ftrace/test.d/template     |    4 +++
 .../selftests/ftrace/test.d/tracer/wakeup.tc       |    6 +---
 .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |    6 +---
 .../inter-event/trigger-action-hist-xfail.tc       |   13 +-------
 .../inter-event/trigger-field-variable-support.tc  |   16 +---------
 .../trigger-inter-event-combined-hist.tc           |   16 +---------
 .../inter-event/trigger-multi-actions-accept.tc    |   16 +---------
 .../inter-event/trigger-onchange-action-hist.tc    |    8 +----
 .../inter-event/trigger-onmatch-action-hist.tc     |   16 +---------
 .../trigger-onmatch-onmax-action-hist.tc           |   16 +---------
 .../inter-event/trigger-onmax-action-hist.tc       |   16 +---------
 .../inter-event/trigger-snapshot-action-hist.tc    |   20 +------------
 .../trigger-synthetic-event-createremove.tc        |   11 +------
 .../inter-event/trigger-synthetic-event-syntax.tc  |   11 +------
 .../inter-event/trigger-trace-action-hist.tc       |   18 +-----------
 .../ftrace/test.d/trigger/trigger-eventonoff.tc    |   11 +------
 .../ftrace/test.d/trigger/trigger-filter.tc        |   11 +------
 .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   16 +---------
 .../test.d/trigger/trigger-hist-syntax-errors.tc   |   18 +-----------
 .../ftrace/test.d/trigger/trigger-hist.tc          |   16 +---------
 .../ftrace/test.d/trigger/trigger-multihist.tc     |   16 +---------
 .../ftrace/test.d/trigger/trigger-snapshot.tc      |   16 +---------
 .../ftrace/test.d/trigger/trigger-stacktrace.tc    |   11 +------
 .../test.d/trigger/trigger-trace-marker-hist.tc    |   21 +-------------
 .../trigger/trigger-trace-marker-snapshot.tc       |   21 +-------------
 .../trigger-trace-marker-synthetic-kernel.tc       |   31 +-------------------
 .../trigger/trigger-trace-marker-synthetic.tc      |   26 +----------------
 .../ftrace/test.d/trigger/trigger-traceonoff.tc    |   11 +------
 80 files changed, 119 insertions(+), 633 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
