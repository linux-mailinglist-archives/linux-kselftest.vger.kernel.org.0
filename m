Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160702018CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405986AbgFSQw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405981AbgFSQwv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 12:52:51 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D400C06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 09:52:51 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so12020213ioa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=95l1MVTCi/7S8KtvFFky6uuPDaXVAxHS1QVJv025vvc=;
        b=DN3+VWJt4kegNaGt6irZzdSQA1JID8n9/YfMrzHpEaYJtlCV4Fp6D96MdHmBNtKqgT
         yrheJIYkbfaurKdxWS1DGN0cwpdrsRjnS11SiurTVITnjXhAZT6m9w7gbeiU54a4N8dW
         T7bl2+G7y4MrfC7ufB4SAoj+BoO4ypwK5TdSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=95l1MVTCi/7S8KtvFFky6uuPDaXVAxHS1QVJv025vvc=;
        b=Op9zm7tURj0JLRoD8gv1L4gKTd7ZMTsWbHDughuPGEgLKHhi7ax+lFd+E5KwbemLUu
         PE7YRGvZvc/cC+oaLKOSF6/yEqraRSCJc+YU9R3O6NzghJBYV6hXSN8OxDRz+BLQf0bF
         PzVscqFw5gaojON4z+hdQFCqjUEOHmrwSVNT6riBNiom/VgZChteExe7kvte+wkeyP+P
         UhD198x7bxVfzJPoq77dss81c+pr1J9quiLmGjseaqJWNOjflwSxC6MrmkDUUy+EfxGq
         UATvAAOf6GvAjoZLYluYBCyn2ENIAD7P4b9KLmRd3BrpcJ+mNfbAnKrAkVXTVHorOgyC
         58Nw==
X-Gm-Message-State: AOAM531xKBQXfD7uYUSrQSLScEf1urTiYV/8QAJkoGYUDTUs/+vBp+Jw
        gx3c9iArkFtGs/MnlVJL/PwJ8w==
X-Google-Smtp-Source: ABdhPJyppIllEsBxsT7BdLd87VJkDihdM58Pmb4lctzrvdR269bY5SB7ojGkVMVP1NDpbF3l60KVrw==
X-Received: by 2002:a02:6641:: with SMTP id l1mr4701773jaf.23.1592585570511;
        Fri, 19 Jun 2020 09:52:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y19sm3685121iod.41.2020.06.19.09.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:52:50 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [GIT PULL] Kselftest update for Linux 5.8-rc2
Message-ID: <3d0e22cc-af15-c142-1ee9-6f3c18a10557@linuxfoundation.org>
Date:   Fri, 19 Jun 2020 10:52:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus,

Please pull the following Kselftest update for Linux 5.8-rc2.

This Kselftest update for Linux 5.8-rc2 consists of:

- ftrace "requires:" list for simplifying and unifying requirement
   checks for each test case, adding "requires:" line instead of
   checking required ftrace interfaces in each test case.
- a minor spelling correction patch

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.8-rc2

for you to fetch changes up to 1b8eec510ba641418573eacc98a7e9c07726af30:

   selftests/ftrace: Support ":README" suffix for requires (2020-06-16 
10:42:47 -0600)

----------------------------------------------------------------
linux-kselftest-5.8-rc2

This Kselftest update for Linux 5.8-rc2 consists of:

- ftrace "requires:" list for simplifying and unifying requirement
   checks for each test case, adding "requires:" line instead of
   checking required ftrace interfaces in each test case.
- a minor spelling correction patch

----------------------------------------------------------------
Flavio Suligoi (1):
       tools: testing: ftrace: trigger: fix spelling mistake

Masami Hiramatsu (7):
       selftests/ftrace: Allow ":" in description
       selftests/ftrace: Return unsupported for the unconfigured features
       selftests/ftrace: Add "requires:" list support
       selftests/ftrace: Convert required interface checks into requires 
list
       selftests/ftrace: Convert check_filter_file() with requires list
       selftests/ftrace: Support ":tracer" suffix for requires
       selftests/ftrace: Support ":README" suffix for requires

  tools/testing/selftests/ftrace/ftracetest          | 11 ++++++--
  .../selftests/ftrace/test.d/00basic/snapshot.tc    |  3 +--
  .../selftests/ftrace/test.d/00basic/trace_pipe.tc  |  3 +--
  .../ftrace/test.d/direct/kprobe-direct.tc          |  6 +----
  .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  6 +----
  .../ftrace/test.d/dynevent/add_remove_synth.tc     |  5 +---
  .../ftrace/test.d/dynevent/clear_select_events.tc  | 11 +-------
  .../ftrace/test.d/dynevent/generic_clear_event.tc  |  8 +-----
  .../selftests/ftrace/test.d/event/event-enable.tc  |  6 +----
  .../selftests/ftrace/test.d/event/event-no-pid.tc  | 11 +-------
  .../selftests/ftrace/test.d/event/event-pid.tc     | 11 +-------
  .../ftrace/test.d/event/subsystem-enable.tc        |  6 +----
  .../ftrace/test.d/event/toplevel-enable.tc         |  6 +----
  .../ftrace/test.d/ftrace/fgraph-filter-stack.tc    | 14 +---------
  .../ftrace/test.d/ftrace/fgraph-filter.tc          |  8 +-----
  .../ftrace/test.d/ftrace/func-filter-glob.tc       |  8 +-----
  .../test.d/ftrace/func-filter-notrace-pid.tc       | 13 +--------
  .../ftrace/test.d/ftrace/func-filter-pid.tc        | 13 +--------
  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |  3 +--
  .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |  6 +----
  .../ftrace/test.d/ftrace/func_event_triggers.tc    |  7 +++--
  .../ftrace/test.d/ftrace/func_mod_trace.tc         |  3 +--
  .../ftrace/test.d/ftrace/func_profile_stat.tc      |  3 +--
  .../ftrace/test.d/ftrace/func_profiler.tc          | 12 +--------
  .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |  6 ++---
  .../ftrace/test.d/ftrace/func_stack_tracer.tc      |  8 +-----
  .../test.d/ftrace/func_traceonoff_triggers.tc      |  6 ++---
  .../ftrace/test.d/ftrace/tracing-error-log.tc      | 12 +++------
  tools/testing/selftests/ftrace/test.d/functions    | 28 
++++++++++++++-----
  .../ftrace/test.d/instances/instance-event.tc      |  6 +----
  .../selftests/ftrace/test.d/instances/instance.tc  |  6 +----
  .../ftrace/test.d/kprobe/add_and_remove.tc         |  3 +--
  .../selftests/ftrace/test.d/kprobe/busy_check.tc   |  3 +--
  .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |  3 +--
  .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |  3 +--
  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |  3 +--
  .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |  3 +--
  .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |  5 +---
  .../ftrace/test.d/kprobe/kprobe_args_type.tc       |  5 +---
  .../ftrace/test.d/kprobe/kprobe_args_user.tc       |  4 +--
  .../ftrace/test.d/kprobe/kprobe_eventname.tc       |  3 +--
  .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |  6 +----
  .../ftrace/test.d/kprobe/kprobe_module.tc          |  3 +--
  .../ftrace/test.d/kprobe/kprobe_multiprobe.tc      |  5 +---
  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  5 +---
  .../ftrace/test.d/kprobe/kretprobe_args.tc         |  3 +--
  .../ftrace/test.d/kprobe/kretprobe_maxactive.tc    |  4 +--
  .../ftrace/test.d/kprobe/multiple_kprobes.tc       |  3 +--
  .../selftests/ftrace/test.d/kprobe/probepoint.tc   |  3 +--
  .../selftests/ftrace/test.d/kprobe/profile.tc      |  3 +--
  .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |  5 +---
  .../ftrace/test.d/preemptirq/irqsoff_tracer.tc     |  4 +--
  tools/testing/selftests/ftrace/test.d/template     |  4 +++
  .../selftests/ftrace/test.d/tracer/wakeup.tc       |  6 +----
  .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |  6 +----
  .../inter-event/trigger-action-hist-xfail.tc       | 13 +--------
  .../inter-event/trigger-field-variable-support.tc  | 16 +----------
  .../trigger-inter-event-combined-hist.tc           | 16 +----------
  .../inter-event/trigger-multi-actions-accept.tc    | 16 +----------
  .../inter-event/trigger-onchange-action-hist.tc    |  8 +-----
  .../inter-event/trigger-onmatch-action-hist.tc     | 16 +----------
  .../trigger-onmatch-onmax-action-hist.tc           | 16 +----------
  .../inter-event/trigger-onmax-action-hist.tc       | 16 +----------
  .../inter-event/trigger-snapshot-action-hist.tc    | 20 +-------------
  .../trigger-synthetic-event-createremove.tc        | 11 +-------
  .../inter-event/trigger-synthetic-event-syntax.tc  | 11 +-------
  .../inter-event/trigger-trace-action-hist.tc       | 18 +------------
  .../ftrace/test.d/trigger/trigger-eventonoff.tc    | 11 +-------
  .../ftrace/test.d/trigger/trigger-filter.tc        | 11 +-------
  .../ftrace/test.d/trigger/trigger-hist-mod.tc      | 16 +----------
  .../test.d/trigger/trigger-hist-syntax-errors.tc   | 18 +------------
  .../ftrace/test.d/trigger/trigger-hist.tc          | 18 ++-----------
  .../ftrace/test.d/trigger/trigger-multihist.tc     | 16 +----------
  .../ftrace/test.d/trigger/trigger-snapshot.tc      | 16 +----------
  .../ftrace/test.d/trigger/trigger-stacktrace.tc    | 13 ++-------
  .../test.d/trigger/trigger-trace-marker-hist.tc    | 23 ++--------------
  .../trigger/trigger-trace-marker-snapshot.tc       | 23 ++--------------
  .../trigger-trace-marker-synthetic-kernel.tc       | 31 
+---------------------
  .../trigger/trigger-trace-marker-synthetic.tc      | 26 +-----------------
  .../ftrace/test.d/trigger/trigger-traceonoff.tc    | 11 +-------

-- 80 files changed, 123 insertions(+), 637 deletions(-)
--------------------------------------------------------------
