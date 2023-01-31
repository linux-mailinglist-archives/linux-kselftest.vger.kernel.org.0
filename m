Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2436836D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjAaTuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 14:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAaTuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 14:50:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD7530C8;
        Tue, 31 Jan 2023 11:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1A8B616C2;
        Tue, 31 Jan 2023 19:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C923C433EF;
        Tue, 31 Jan 2023 19:50:50 +0000 (UTC)
Date:   Tue, 31 Jan 2023 14:50:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
Message-ID: <20230131145048.6fac87d3@gandalf.local.home>
In-Reply-To: <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
References: <20230130181915.1113313-1-zwisler@google.com>
        <20230130181915.1113313-4-zwisler@google.com>
        <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
        <20230130145932.37cf6b73@gandalf.local.home>
        <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
        <20230130183419.0626dc21@gandalf.local.home>
        <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 30 Jan 2023 16:53:15 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I don't think /sys/kernel/debug/tracing can ever be deprecated.
> There are plenty of user space applications (not bpf related at all) that
> expect it to be in that location.
> 
> Quick search shows:
> 
> android profiler:
> https://android.googlesource.com/platform/external/perfetto/+/refs/heads/master/src/tools/dump_ftrace_stats/main.cc#60
> 
> java profiler:
> https://github.com/jvm-profiling-tools/async-profiler/blob/master/src/perfEvents_linux.cpp#L85

These can easily be changed. We have deprecated stuff in the past, by
making sure all the affected code is updated properly.

One way is to start adding printks when used. Then update to WARN() to get
people to complain. Yes, the burden is on us (me and others) to go out and
fix the issues. But it is possible to do, as I've done it before.

> 
> > If anything, leaving hardcoded calls like that forces the user to mount
> > debugfs when they may not want to. The entire point of tracefs was to allow
> > users to have access to the trace events without having to expose debugfs
> > and all the crud it brings with it. This was requested several times before
> > it was added.  
> 
> All makes sense.
> 
> > What is your technical reason for not modifying the code to look for
> > tracefs in /sys/kernel/tracing and if it's not there try
> > /sys/kernel/debug/tracing, and if both are not found, try mounting it.  
> 
> libbpf already has code to probe both locations.
> The point that full deprecation of /sys/kernel/debug/tracing is not possible,
> hence no point doing the diff:
> 48 files changed, 96 insertions(+), 95 deletions(-)
> It doesn't move the needle. Just a code churn.

As code in the Linux kernel is used as examples for future work, it should
not be using an interface that is obsolete. That's enough rational for code
churn. This "we can never deprecated so we won't even try" BS is not an
answer.

-- Steve
