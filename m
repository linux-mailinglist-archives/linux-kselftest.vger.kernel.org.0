Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CC681A75
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjA3T1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 14:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbjA3T1f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 14:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4773EC6C
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 11:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675106776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxRPh/paZX5a/mJDhNvLvYnOtz1Fnppz2zZO/ehY1gY=;
        b=U95HQXeZxqsPumu/gpogtkGnTWlCU6P0uDMv4GK8KFAqXDEc+BHTxHRGR1kPaBSKjyBUV4
        20hbiHYgE3QUe3sBA6DWfNsDKxjEAgCHl9ONaNGtyMbzJAVZkMoWhRnyEKxfhPt8ho5wjr
        rlVsiSgQMfkoCYp6nf9y+PQZM9GByoE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-rtMUg1YEOVCWFFpYe3SwyA-1; Mon, 30 Jan 2023 14:26:15 -0500
X-MC-Unique: rtMUg1YEOVCWFFpYe3SwyA-1
Received: by mail-wr1-f72.google.com with SMTP id bj7-20020a0560001e0700b002bfb3c6ec00so2159158wrb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 11:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxRPh/paZX5a/mJDhNvLvYnOtz1Fnppz2zZO/ehY1gY=;
        b=BRyJ4qRr4RhLCTbHuDqvnt4EmX95xhtVeSAUx4qlW4VhhC+UzsFgUuPXicIY2L+Yqz
         0Ayx/OaOwhv0DXJ0+9ENgsdlPQzuUGnG5aV+4B41T/nRlJVCGkhsAuAMLlEMRyfTyt+P
         iZiz3OgO7RX8W9OhLQHDwAhzd7eiEO7vbPmEDolkL2aM1S0cjHiHiqoofMHYcx0YHY5+
         atZ8wU9d+cm2FPy95ENREJ7b5RffhoU5cjqM2VdAkCrJg/Rlyz9vu3JVlfTFUz+e+SmL
         Rq4LMf2tDVLDI4cdgYIKKoNsvzuKzMNWdttdYWi0lxWsATjkSDPDWkPk5M1QnrcHVVKc
         lknA==
X-Gm-Message-State: AO0yUKUrrpnGwSUYOsq95D3WLzMoKxpptvWonycuqEaTqbZntge4At6Z
        aHMc/HIYJhWHiZSzHLPfJoR7IaDBF0//4wovJcIcUBhUznYuNek+JunZFGlk0joXgZvbj6/hly9
        1ozIQSe5b5PeJdCjZKU9wuZnLnR3h
X-Received: by 2002:a5d:5908:0:b0:2bf:f027:3c30 with SMTP id v8-20020a5d5908000000b002bff0273c30mr3314163wrd.56.1675106774175;
        Mon, 30 Jan 2023 11:26:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+eycYJ8p0mkRD8mPxEc0uaHr5C6uQOIksxyy+K6HKOMMdutlQSlkQGNzjc/g2dbWuMCMCRzg==
X-Received: by 2002:a5d:5908:0:b0:2bf:f027:3c30 with SMTP id v8-20020a5d5908000000b002bff0273c30mr3314130wrd.56.1675106773965;
        Mon, 30 Jan 2023 11:26:13 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002bc8130cca7sm12742836wrr.23.2023.01.30.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:26:13 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:26:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
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
Subject: Re: [PATCH 0/9] use canonical ftrace path whenever possible
Message-ID: <20230130142555-mutt-send-email-mst@kernel.org>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 11:19:06AM -0700, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> There are many places where this older debugfs path is still used in
> code comments, selftests, examples and tools, so let's update them to
> avoid confusion.
> 
> I've broken up the series as best I could by maintainer or directory,
> and I've only sent people the patches that I think they care about to
> avoid spamming everyone.
> 
> Ross Zwisler (9):
>   tracing: always use canonical ftrace path
>   bpf: use canonical ftrace path
>   selftests/bpf: use canonical ftrace path
>   perf docs: use canonical ftrace path
>   tools/power: use canonical ftrace path
>   selftests: use canonical ftrace path
>   tools/virtio: use canonical ftrace path
>   leaking_addresses: also skip canonical ftrace path
>   tools/kvm_stat: use canonical ftrace path
> 
>  include/linux/kernel.h                        |  2 +-
>  include/linux/tracepoint.h                    |  4 ++--
>  include/uapi/linux/bpf.h                      |  8 ++++----
>  kernel/trace/Kconfig                          | 20 +++++++++----------
>  kernel/trace/kprobe_event_gen_test.c          |  2 +-
>  kernel/trace/ring_buffer.c                    |  2 +-
>  kernel/trace/synth_event_gen_test.c           |  2 +-
>  kernel/trace/trace.c                          |  2 +-
>  samples/bpf/cpustat_kern.c                    |  4 ++--
>  samples/bpf/hbm.c                             |  4 ++--
>  samples/bpf/ibumad_kern.c                     |  4 ++--
>  samples/bpf/lwt_len_hist.sh                   |  2 +-
>  samples/bpf/offwaketime_kern.c                |  2 +-
>  samples/bpf/task_fd_query_user.c              |  4 ++--
>  samples/bpf/test_lwt_bpf.sh                   |  2 +-
>  samples/bpf/test_overhead_tp_kern.c           |  4 ++--
>  samples/user_events/example.c                 |  4 ++--
>  scripts/leaking_addresses.pl                  |  1 +
>  scripts/tracing/draw_functrace.py             |  6 +++---
>  scripts/tracing/ftrace-bisect.sh              |  4 ++--
>  tools/include/uapi/linux/bpf.h                |  8 ++++----
>  tools/kvm/kvm_stat/kvm_stat                   |  2 +-
>  tools/lib/api/fs/tracing_path.c               |  4 ++--
>  tools/lib/traceevent/event-parse.c            |  8 ++++----
>  tools/perf/Documentation/perf-list.txt        |  2 +-
>  tools/perf/Documentation/perf-script-perl.txt |  2 +-
>  .../perf/Documentation/perf-script-python.txt |  4 ++--
>  tools/power/pm-graph/sleepgraph.py            |  4 ++--
>  .../x86/amd_pstate_tracer/amd_pstate_trace.py |  4 ++--
>  .../intel_pstate_tracer.py                    | 10 +++++-----
>  .../selftests/bpf/get_cgroup_id_user.c        |  2 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        |  2 +-
>  .../bpf/prog_tests/task_fd_query_tp.c         |  2 +-
>  .../bpf/prog_tests/tp_attach_query.c          |  2 +-
>  .../selftests/bpf/prog_tests/trace_printk.c   |  2 +-
>  .../selftests/bpf/prog_tests/trace_vprintk.c  |  2 +-
>  .../selftests/bpf/progs/test_stacktrace_map.c |  2 +-
>  .../selftests/bpf/progs/test_tracepoint.c     |  2 +-
>  tools/testing/selftests/bpf/test_ftrace.sh    |  2 +-
>  tools/testing/selftests/bpf/test_tunnel.sh    |  8 ++++----
>  tools/testing/selftests/bpf/trace_helpers.c   |  4 ++--
>  .../testing/selftests/user_events/dyn_test.c  |  2 +-
>  .../selftests/user_events/ftrace_test.c       | 10 +++++-----
>  .../testing/selftests/user_events/perf_test.c |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c  |  4 ++--
>  tools/tracing/latency/latency-collector.c     |  2 +-
>  tools/virtio/virtio-trace/README              |  2 +-
>  tools/virtio/virtio-trace/trace-agent.c       |  2 +-
>  48 files changed, 96 insertions(+), 95 deletions(-)
> 
> -- 
> 2.39.1.456.gfc5497dd1b-goog

