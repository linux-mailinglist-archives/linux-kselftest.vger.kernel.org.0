Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C69F681AFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbjA3T77 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbjA3T7o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 14:59:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B545F73;
        Mon, 30 Jan 2023 11:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE6FBCE19A3;
        Mon, 30 Jan 2023 19:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042CCC433EF;
        Mon, 30 Jan 2023 19:59:35 +0000 (UTC)
Date:   Mon, 30 Jan 2023 14:59:32 -0500
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
Message-ID: <20230130145932.37cf6b73@gandalf.local.home>
In-Reply-To: <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
References: <20230130181915.1113313-1-zwisler@google.com>
        <20230130181915.1113313-4-zwisler@google.com>
        <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
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

On Mon, 30 Jan 2023 11:52:03 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jan 30, 2023 at 10:19 AM Ross Zwisler <zwisler@chromium.org> wrote:
> >
> > The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> >
> > But, from Documentation/trace/ftrace.rst:
> >
> >   Before 4.1, all ftrace tracing control files were within the debugfs
> >   file system, which is typically located at /sys/kernel/debug/tracing.
> >   For backward compatibility, when mounting the debugfs file system,
> >   the tracefs file system will be automatically mounted at:
> >
> >   /sys/kernel/debug/tracing
> >
> > Many tests in the bpf selftest code still refer to this older debugfs
> > path, so let's update them to avoid confusion.  
> 
> I wish that was the case, but in reality there are still systems
> out there where tracefs is only mounted in that old location.
> For example in one my VMs:
> 
> $ cat /proc/mounts |grep tracefs
> tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0
> $ ls /sys/kernel/tracing/
> $ uname -r
> 6.2.0-rc5-01030-gc1a3daf7363b
> 
> So this change will break the tests. We cannot do it.

Could we add a way to try to mount it?

If anything, the tests should not have the path hard coded. It should then
look to see if it is mounted and use the path that is found. Otherwise it
should try mounting it at the correct location.

Feel free to take the code from libtracefs (and modify it):

https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89

It will make the test code much more robust.

-- Steve
