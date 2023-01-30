Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D2681FB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjA3Xe3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 18:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjA3Xe2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 18:34:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207813AA2;
        Mon, 30 Jan 2023 15:34:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E73ECE1331;
        Mon, 30 Jan 2023 23:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3544C433D2;
        Mon, 30 Jan 2023 23:34:21 +0000 (UTC)
Date:   Mon, 30 Jan 2023 18:34:19 -0500
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
Message-ID: <20230130183419.0626dc21@gandalf.local.home>
In-Reply-To: <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
References: <20230130181915.1113313-1-zwisler@google.com>
        <20230130181915.1113313-4-zwisler@google.com>
        <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
        <20230130145932.37cf6b73@gandalf.local.home>
        <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
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

On Mon, 30 Jan 2023 12:03:52 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > So this change will break the tests. We cannot do it.  
> >
> > Could we add a way to try to mount it?
> >
> > If anything, the tests should not have the path hard coded. It should then
> > look to see if it is mounted and use the path that is found. Otherwise it
> > should try mounting it at the correct location.
> >
> > Feel free to take the code from libtracefs (and modify it):
> >
> > https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89
> >
> > It will make the test code much more robust.  
> 
> The point is not about tests. The point is that this change might break
> some users that are working today with /sys/kernel/debug/tracing.

> It also might be mounted differently.
> For example from another system:
> cat /proc/mounts|grep trace
> tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
> tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0

Yes, and the code works when it's mounted multiple times.

> 
> So I suggest leaving the code as-is.

Why?  I want to make /sys/kernel/debug/tracing deprecated. It's a hack to
not break old code. I've had complaints about that hack, and there's even
systems that disable the auto mounting (that is, /sys/kernel/debug/tracing
would not exist in such configs) This was never expected to be a permanent
solution.

If anything, leaving hardcoded calls like that forces the user to mount
debugfs when they may not want to. The entire point of tracefs was to allow
users to have access to the trace events without having to expose debugfs
and all the crud it brings with it. This was requested several times before
it was added.

What is your technical reason for not modifying the code to look for
tracefs in /sys/kernel/tracing and if it's not there try
/sys/kernel/debug/tracing, and if both are not found, try mounting it.

That change is not hard and makes the code much more robust and does not
break anything.

-- Steve


