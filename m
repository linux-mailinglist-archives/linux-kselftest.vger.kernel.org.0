Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02452681B0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjA3UEK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjA3UEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 15:04:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B835B7;
        Mon, 30 Jan 2023 12:04:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n6so9511989edo.9;
        Mon, 30 Jan 2023 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olCbTPRXfVI/d5f5dYzmhROECDXee3XQ0Xd1Jkwcjdg=;
        b=giiQUd/PcQXaAaDEtKJ8nFqWiHes8vTYVZheg46V/YfQXXmHlIov5DxvNfiJxpIdul
         Ym2z3k9300SYM64DgFlTShS9E9nx+KllVjo7kytdaw31ptDNlrSpGvS/DaRtW4hTYHUl
         U4jf1IWJMrwXiMDCTQ42ebEqH6e+8ZyjaxWSuiOIyG5t8oN4WSu32stj7UFUQ/4uyP6G
         8UqQ8BLtr6BRfQipRqckRanx3EAopELr5rmg5iiQx/uBQjDAftpz+u+b4rRbUh4BcNGd
         wAVOQFCTiLAc1zRrL57xZ8zBOalk33Gyo2D+rO4PiM4TyPCVjvRGfJpt72wGcTnVThiy
         sCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olCbTPRXfVI/d5f5dYzmhROECDXee3XQ0Xd1Jkwcjdg=;
        b=3XgtZerFuUoWcZy5bTaTZ7hfpVvKt5UNQBOgy2DYkSL+by0YU+oHnfUUb69yW5jbRv
         IYZtw9b87mPLH2BiXoLidXH+AH3K36+8H/g9Nm0nWblQRunKjNXdlxHg2pN8SWhZTox/
         7IAGZT7gJnmkFZTtkTHJVURHHeocjICjwME6mZeMxUsALdpYzim6QMN4CgmxYOLvYkHP
         zmrf75+PhzHiuREx2TCF/zPX3VTQZtlwgW2JExuAVEgbRzRS+Ip4z/VSfdSSNyg+qPgT
         l1yUaoEyAZ4cR9ZzdCQBR0MSOEmSLq8PkUPA0sfvm7fp35w4JOR5gt6tk+m0wKu84HhM
         3kOQ==
X-Gm-Message-State: AFqh2kpRVXvWnf1mmG1jlKIMlsCBYAXpsCRnINaiHh69BPj50P/na8gc
        I3qeuZl3Iz9hs+LP7fGoLxsnGzy1oy+l+YEoMT8=
X-Google-Smtp-Source: AMrXdXvRXTIs3H82Aw6Swuv79C57I8Tz49/T2Qn3nWRd6oDp3CI9Ma0LOXy9if2iVNg8LVP3q3fxKimM3FaTUMNJjlc=
X-Received: by 2002:a05:6402:4494:b0:49e:89e:c7b4 with SMTP id
 er20-20020a056402449400b0049e089ec7b4mr9001785edb.1.1675109043516; Mon, 30
 Jan 2023 12:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-4-zwisler@google.com>
 <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com> <20230130145932.37cf6b73@gandalf.local.home>
In-Reply-To: <20230130145932.37cf6b73@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Jan 2023 12:03:52 -0800
Message-ID: <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
To:     Steven Rostedt <rostedt@goodmis.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 11:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 30 Jan 2023 11:52:03 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Mon, Jan 30, 2023 at 10:19 AM Ross Zwisler <zwisler@chromium.org> wrote:
> > >
> > > The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> > >
> > > But, from Documentation/trace/ftrace.rst:
> > >
> > >   Before 4.1, all ftrace tracing control files were within the debugfs
> > >   file system, which is typically located at /sys/kernel/debug/tracing.
> > >   For backward compatibility, when mounting the debugfs file system,
> > >   the tracefs file system will be automatically mounted at:
> > >
> > >   /sys/kernel/debug/tracing
> > >
> > > Many tests in the bpf selftest code still refer to this older debugfs
> > > path, so let's update them to avoid confusion.
> >
> > I wish that was the case, but in reality there are still systems
> > out there where tracefs is only mounted in that old location.
> > For example in one my VMs:
> >
> > $ cat /proc/mounts |grep tracefs
> > tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0
> > $ ls /sys/kernel/tracing/
> > $ uname -r
> > 6.2.0-rc5-01030-gc1a3daf7363b
> >
> > So this change will break the tests. We cannot do it.
>
> Could we add a way to try to mount it?
>
> If anything, the tests should not have the path hard coded. It should then
> look to see if it is mounted and use the path that is found. Otherwise it
> should try mounting it at the correct location.
>
> Feel free to take the code from libtracefs (and modify it):
>
> https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89
>
> It will make the test code much more robust.

The point is not about tests. The point is that this change might break
some users that are working today with /sys/kernel/debug/tracing.
It also might be mounted differently.
For example from another system:
cat /proc/mounts|grep trace
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0

So I suggest leaving the code as-is.
