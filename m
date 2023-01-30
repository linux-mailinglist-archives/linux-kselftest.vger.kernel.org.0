Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297F681895
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbjA3ST4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 13:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjA3STn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:43 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277ED3CE3F
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 10:19:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z2so4911211ilq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAFjNasnKQN5LUWGdN7AtadW817QQm7F4FvMhjCHwb0=;
        b=RfZdv5XTG+8uD8qkRBhdwNBF0cK8e8hji8B33Gj95Q6avMrpQVnYUAuUvQ6T7IR8+p
         MYCxMzFUWeWWkyawSiU0lbQwLFknwHfAQy3hsCbXbZdWrjCG2Tc3YHS7D6WPN1oWkG0f
         eFMyiUb05xok2QkhaK8jh7WLReqLeYSqv2qpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAFjNasnKQN5LUWGdN7AtadW817QQm7F4FvMhjCHwb0=;
        b=BQjt/phh2qkBF3L9aU/CX5Z5Wtuz/bFR+OTXKtHw0wJBIMcsanFMYStpHLz7OpJxSQ
         kmTbNl1Wn9BCUbaEoxqS9slX03ROUX6Fr1hcaQgBFkPXrGycUmErYwqny7C7hpMvSuYO
         fgByzp0IDin7rRY3/MLx1BBZgppqSBSP/v7LMnNO02SEl6u9xyZIQmL/KxjyD4eBkdwx
         3bxZuwyN6fBTS4uCgI5jgsKyOO7CsmFwBu2D1e5N3PICGSXOtD2XNz9Ymnybd2Ps6S15
         17tklzN2aQ0a7Ygc1MH1JfmbtXf+rS19rx57EkGWiYe3P26zlMJXrXZ5mYeTio4HC+h6
         xsCw==
X-Gm-Message-State: AO0yUKXGCuPqIvZbVg/deLhO5RZ0W+Wv60jminROMy8qljisNKhBFibV
        v7nvKUT4Uo47p96Li4RfX5xVHA==
X-Google-Smtp-Source: AK7set+mwFjhaqPt63RqulQxBusxgMUOOgqwMk/p2L94uGQONgxdBYrhcYQqNFbg7qLSnkSytLx+CQ==
X-Received: by 2002:a05:6e02:1541:b0:310:c510:780c with SMTP id j1-20020a056e02154100b00310c510780cmr12382570ilu.11.1675102780494;
        Mon, 30 Jan 2023 10:19:40 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:40 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Tycho Andersen <tycho@tycho.pizza>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/9] use canonical ftrace path whenever possible
Date:   Mon, 30 Jan 2023 11:19:06 -0700
Message-Id: <20230130181915.1113313-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

There are many places where this older debugfs path is still used in
code comments, selftests, examples and tools, so let's update them to
avoid confusion.

I've broken up the series as best I could by maintainer or directory,
and I've only sent people the patches that I think they care about to
avoid spamming everyone.

Ross Zwisler (9):
  tracing: always use canonical ftrace path
  bpf: use canonical ftrace path
  selftests/bpf: use canonical ftrace path
  perf docs: use canonical ftrace path
  tools/power: use canonical ftrace path
  selftests: use canonical ftrace path
  tools/virtio: use canonical ftrace path
  leaking_addresses: also skip canonical ftrace path
  tools/kvm_stat: use canonical ftrace path

 include/linux/kernel.h                        |  2 +-
 include/linux/tracepoint.h                    |  4 ++--
 include/uapi/linux/bpf.h                      |  8 ++++----
 kernel/trace/Kconfig                          | 20 +++++++++----------
 kernel/trace/kprobe_event_gen_test.c          |  2 +-
 kernel/trace/ring_buffer.c                    |  2 +-
 kernel/trace/synth_event_gen_test.c           |  2 +-
 kernel/trace/trace.c                          |  2 +-
 samples/bpf/cpustat_kern.c                    |  4 ++--
 samples/bpf/hbm.c                             |  4 ++--
 samples/bpf/ibumad_kern.c                     |  4 ++--
 samples/bpf/lwt_len_hist.sh                   |  2 +-
 samples/bpf/offwaketime_kern.c                |  2 +-
 samples/bpf/task_fd_query_user.c              |  4 ++--
 samples/bpf/test_lwt_bpf.sh                   |  2 +-
 samples/bpf/test_overhead_tp_kern.c           |  4 ++--
 samples/user_events/example.c                 |  4 ++--
 scripts/leaking_addresses.pl                  |  1 +
 scripts/tracing/draw_functrace.py             |  6 +++---
 scripts/tracing/ftrace-bisect.sh              |  4 ++--
 tools/include/uapi/linux/bpf.h                |  8 ++++----
 tools/kvm/kvm_stat/kvm_stat                   |  2 +-
 tools/lib/api/fs/tracing_path.c               |  4 ++--
 tools/lib/traceevent/event-parse.c            |  8 ++++----
 tools/perf/Documentation/perf-list.txt        |  2 +-
 tools/perf/Documentation/perf-script-perl.txt |  2 +-
 .../perf/Documentation/perf-script-python.txt |  4 ++--
 tools/power/pm-graph/sleepgraph.py            |  4 ++--
 .../x86/amd_pstate_tracer/amd_pstate_trace.py |  4 ++--
 .../intel_pstate_tracer.py                    | 10 +++++-----
 .../selftests/bpf/get_cgroup_id_user.c        |  2 +-
 .../bpf/prog_tests/kprobe_multi_test.c        |  2 +-
 .../bpf/prog_tests/task_fd_query_tp.c         |  2 +-
 .../bpf/prog_tests/tp_attach_query.c          |  2 +-
 .../selftests/bpf/prog_tests/trace_printk.c   |  2 +-
 .../selftests/bpf/prog_tests/trace_vprintk.c  |  2 +-
 .../selftests/bpf/progs/test_stacktrace_map.c |  2 +-
 .../selftests/bpf/progs/test_tracepoint.c     |  2 +-
 tools/testing/selftests/bpf/test_ftrace.sh    |  2 +-
 tools/testing/selftests/bpf/test_tunnel.sh    |  8 ++++----
 tools/testing/selftests/bpf/trace_helpers.c   |  4 ++--
 .../testing/selftests/user_events/dyn_test.c  |  2 +-
 .../selftests/user_events/ftrace_test.c       | 10 +++++-----
 .../testing/selftests/user_events/perf_test.c |  8 ++++----
 tools/testing/selftests/vm/protection_keys.c  |  4 ++--
 tools/tracing/latency/latency-collector.c     |  2 +-
 tools/virtio/virtio-trace/README              |  2 +-
 tools/virtio/virtio-trace/trace-agent.c       |  2 +-
 48 files changed, 96 insertions(+), 95 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

