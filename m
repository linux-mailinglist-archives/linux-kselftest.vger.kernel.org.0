Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6B6B84DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 23:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCMWj5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCMWj4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 18:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD76FFF7;
        Mon, 13 Mar 2023 15:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B4A3B815E9;
        Mon, 13 Mar 2023 22:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F03BC433D2;
        Mon, 13 Mar 2023 22:39:49 +0000 (UTC)
Date:   Mon, 13 Mar 2023 18:39:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: use canonical ftrace
 path
Message-ID: <20230313183946.1a98ef01@gandalf.local.home>
In-Reply-To: <20230313205628.1058720-3-zwisler@kernel.org>
References: <20230310192050.4096886-1-zwisler@kernel.org>
        <20230313205628.1058720-1-zwisler@kernel.org>
        <20230313205628.1058720-3-zwisler@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 13 Mar 2023 14:56:28 -0600
Ross Zwisler <zwisler@kernel.org> wrote:

> From: Ross Zwisler <zwisler@google.com>
> 
> The canonical location for the tracefs filesystem is at
> /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> Many tests in the bpf selftest code still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  tools/testing/selftests/bpf/get_cgroup_id_user.c    |  9 +++++++--
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c    |  7 ++++++-
>  .../selftests/bpf/prog_tests/task_fd_query_tp.c     |  9 +++++++--
>  .../selftests/bpf/prog_tests/tp_attach_query.c      |  9 +++++++--
>  .../testing/selftests/bpf/prog_tests/trace_printk.c | 10 +++++++---
>  .../selftests/bpf/prog_tests/trace_vprintk.c        | 10 +++++++---
>  .../selftests/bpf/progs/test_stacktrace_map.c       |  2 +-
>  tools/testing/selftests/bpf/progs/test_tracepoint.c |  2 +-
>  tools/testing/selftests/bpf/test_ftrace.sh          |  7 ++++++-
>  tools/testing/selftests/bpf/test_tunnel.sh          | 13 +++++++++----
>  tools/testing/selftests/bpf/trace_helpers.c         |  8 ++++++--
>  11 files changed, 64 insertions(+), 22 deletions(-)

