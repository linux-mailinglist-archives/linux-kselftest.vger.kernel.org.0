Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CC1EAFD9
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 21:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAT4U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 15:56:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:57277 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgFAT4T (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 15:56:19 -0400
IronPort-SDR: NbOBXrz8k7Dum5hWyl0MviT63QRaWbNmstWkSll5yp3yJAHP/ZLXaLkAnQqWvVo9WIp074qu0H
 Z+SxTmwJcmhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 12:56:17 -0700
IronPort-SDR: 6uJS/LVhJgWFuf565jK0Jbi8pJ4sWIcgKu/ww8CiO2p0+U2ZaPMYZq1R8KRSOnx8j76nuhxtyl
 ZT2qLVdY2lOw==
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="293307084"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.213.167.214]) ([10.213.167.214])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 12:56:16 -0700
Subject: Re: [PATCH 0/7] selftsts/ftrace: Add requires list for each test case
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <159102252279.31199.12855129586058455119.stgit@devnote2>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <3de208f9-8dd1-3b3a-55e8-134de30fa851@linux.intel.com>
Date:   Mon, 1 Jun 2020 14:56:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159102252279.31199.12855129586058455119.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Masami,

On 6/1/2020 9:42 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is a series for adding "requires:" list for simplifying and
> unifying requirement checks for each test case.
> This series also includes the description line fix and
> unresolved -> unsupported change ([1/7] and [2/7]).
> 
> Currently, we have many similar requirement checker to find
> unconfigured or unsupported (in older kernels) feature in
> each test case. I think it is a good time to unify those similar
> checks.
> 
> As same as "description:" or "flags:" line, this series introduces
> new "requires:" line, and convert current checking code intor the
> "requires:" line.
> This requires line gives some good effects, not only simplyfies
> the code, but also unifies the reason message, and because it checks
> the requirements before running the testc ase, it skips unneeded
> ftrace initialization.
> 
> The requires line supports following checks
>   - tracefs interface check: Check whether the given file or directory
>     in the tracefs. (No suffix) [3/7],[4/7],[5/7]
>   - available tracer check: Check whether the given tracer is available
>     (":tracer" suffix) [6/7]
>   - README feature check: Check whether the given string is in the
>     README (":README" suffix) [7/7]
> 
> Note that since the requires line returns UNSUPPORTED error,
> the requirements must be one of ftrace feature, but not the
> user-space environmental requirement. If there is some issue
> in user-space (e.g. lack of the command, modules, etc) it must
> report UNRESOLVED error.
> 
> Since this series depends on following 2 commits,
> 
> commit 619ee76f5c9f ("selftests/ftrace: Return unsupported if no
>   error_log file") on Shuah's Kselftest tree
> commit bea24f766efc ("selftests/ftrace: Distinguish between hist
>   and synthetic event checks") on Steven's Tracing tree
> 
> This can be applied on the tree which merged both of them.
> Also, you can get the series from the following.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git ftracetest-requires-v1
> 
> 
> Thank you,

Very nice, thanks for doing this.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> 
> ---
> 
> Masami Hiramatsu (7):
>        selftests/ftrace: Allow ":" in description
>        selftests/ftrace: Return unsupported for the unconfigured features
>        selftests/ftrace: Add "requires:" list support
>        selftests/ftrace: Convert required interface checks into requires list
>        selftests/ftrace: Convert check_filter_file() with requires list
>        selftests/ftrace: Support ":tracer" suffix for requires
>        selftests/ftrace: Support ":README" suffix for requires
> 
> 
>   tools/testing/selftests/ftrace/ftracetest          |   11 ++++++-
>   .../selftests/ftrace/test.d/00basic/snapshot.tc    |    3 +-
>   .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |    3 +-
>   .../ftrace/test.d/direct/kprobe-direct.tc          |    6 +---
>   .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |    6 +---
>   .../ftrace/test.d/dynevent/add_remove_synth.tc     |    5 +--
>   .../ftrace/test.d/dynevent/clear_select_events.tc  |   11 +------
>   .../ftrace/test.d/dynevent/generic_clear_event.tc  |    8 +----
>   .../selftests/ftrace/test.d/event/event-enable.tc  |    6 +---
>   .../selftests/ftrace/test.d/event/event-no-pid.tc  |   11 +------
>   .../selftests/ftrace/test.d/event/event-pid.tc     |   11 +------
>   .../ftrace/test.d/event/subsystem-enable.tc        |    6 +---
>   .../ftrace/test.d/event/toplevel-enable.tc         |    6 +---
>   .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    |   14 +--------
>   .../ftrace/test.d/ftrace/fgraph-filter.tc          |    8 +----
>   .../ftrace/test.d/ftrace/func-filter-glob.tc       |    8 +----
>   .../test.d/ftrace/func-filter-notrace-pid.tc       |   13 +-------
>   .../ftrace/test.d/ftrace/func-filter-pid.tc        |   13 +-------
>   .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    3 +-
>   .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    6 +---
>   .../ftrace/test.d/ftrace/func_event_triggers.tc    |    7 ++---
>   .../ftrace/test.d/ftrace/func_mod_trace.tc         |    3 +-
>   .../ftrace/test.d/ftrace/func_profile_stat.tc      |    3 +-
>   .../ftrace/test.d/ftrace/func_profiler.tc          |   12 +-------
>   .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |    6 ++--
>   .../ftrace/test.d/ftrace/func_stack_tracer.tc      |    8 +----
>   .../test.d/ftrace/func_traceonoff_triggers.tc      |    6 ++--
>   .../ftrace/test.d/ftrace/tracing-error-log.tc      |   12 ++------
>   tools/testing/selftests/ftrace/test.d/functions    |   28 ++++++++++++++----
>   .../ftrace/test.d/instances/instance-event.tc      |    6 +---
>   .../selftests/ftrace/test.d/instances/instance.tc  |    6 +---
>   .../ftrace/test.d/kprobe/add_and_remove.tc         |    3 +-
>   .../selftests/ftrace/test.d/kprobe/busy_check.tc   |    3 +-
>   .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |    5 +--
>   .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    5 +--
>   .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    5 +--
>   .../ftrace/test.d/kprobe/kprobe_eventname.tc       |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    6 +---
>   .../ftrace/test.d/kprobe/kprobe_module.tc          |    3 +-
>   .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |    5 +--
>   .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    5 +--
>   .../ftrace/test.d/kprobe/kretprobe_args.tc         |    3 +-
>   .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |    4 +--
>   .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    3 +-
>   .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    3 +-
>   .../selftests/ftrace/test.d/kprobe/profile.tc      |    3 +-
>   .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 +--
>   .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |    4 +--
>   tools/testing/selftests/ftrace/test.d/template     |    4 +++
>   .../selftests/ftrace/test.d/tracer/wakeup.tc       |    6 +---
>   .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |    6 +---
>   .../inter-event/trigger-action-hist-xfail.tc       |   13 +-------
>   .../inter-event/trigger-field-variable-support.tc  |   16 +---------
>   .../trigger-inter-event-combined-hist.tc           |   16 +---------
>   .../inter-event/trigger-multi-actions-accept.tc    |   16 +---------
>   .../inter-event/trigger-onchange-action-hist.tc    |    8 +----
>   .../inter-event/trigger-onmatch-action-hist.tc     |   16 +---------
>   .../trigger-onmatch-onmax-action-hist.tc           |   16 +---------
>   .../inter-event/trigger-onmax-action-hist.tc       |   16 +---------
>   .../inter-event/trigger-snapshot-action-hist.tc    |   20 +------------
>   .../trigger-synthetic-event-createremove.tc        |   11 +------
>   .../inter-event/trigger-synthetic-event-syntax.tc  |   11 +------
>   .../inter-event/trigger-trace-action-hist.tc       |   18 +-----------
>   .../ftrace/test.d/trigger/trigger-eventonoff.tc    |   11 +------
>   .../ftrace/test.d/trigger/trigger-filter.tc        |   11 +------
>   .../ftrace/test.d/trigger/trigger-hist-mod.tc      |   16 +---------
>   .../test.d/trigger/trigger-hist-syntax-errors.tc   |   18 +-----------
>   .../ftrace/test.d/trigger/trigger-hist.tc          |   16 +---------
>   .../ftrace/test.d/trigger/trigger-multihist.tc     |   16 +---------
>   .../ftrace/test.d/trigger/trigger-snapshot.tc      |   16 +---------
>   .../ftrace/test.d/trigger/trigger-stacktrace.tc    |   11 +------
>   .../test.d/trigger/trigger-trace-marker-hist.tc    |   21 +-------------
>   .../trigger/trigger-trace-marker-snapshot.tc       |   21 +-------------
>   .../trigger-trace-marker-synthetic-kernel.tc       |   31 +-------------------
>   .../trigger/trigger-trace-marker-synthetic.tc      |   26 +----------------
>   .../ftrace/test.d/trigger/trigger-traceonoff.tc    |   11 +------
>   80 files changed, 120 insertions(+), 633 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
