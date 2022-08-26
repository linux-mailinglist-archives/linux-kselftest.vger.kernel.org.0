Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCA5A2B3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbiHZP2d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344593AbiHZP1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 11:27:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE92610F;
        Fri, 26 Aug 2022 08:25:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y141so1855771pfb.7;
        Fri, 26 Aug 2022 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T4eXzYnQ/a8WHMGiUIkj7JnQqVL36zLCgnWVX8RYols=;
        b=p06dBWS/7fcNz0PovW46mb6trO7AIKsFhnFSdjgfhZEHcZ9AkDjCgGkhZE6iX3azrg
         /sINeNqrAklWpJfP2QcP5auIjim9y0j+i3MZe64iDxdcmFAGBwLZwSi1918mLqNiea1y
         nXxAw/VoElQdX9MvjzhlmmKowqg1V/NmbQLzOvWLerWQCdYsnEliu/Nr1lurJQIFpbXX
         A1etQH6U6MkAPebwQHcxoE5uPBsdLR3HzXnd4ATyCLd0REUVSDRSKLPEgFbhLWTVcuSC
         sfOxWz3KSwYITGEXQr3h92X+32sNA5U473hqN4GJ/sXcYCjEFOBS74D3ZIKU/JaMLJhO
         T7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T4eXzYnQ/a8WHMGiUIkj7JnQqVL36zLCgnWVX8RYols=;
        b=KXzCKRNcc+gv6iqtVi74CQL32PLFrZpGsm7IGY+KCvbOp74ww7L/v+ucxJ4FEDzEYR
         rpu/kW/FrNE8SKvhR33IFY1m2MW0lTJ0fxPUF4vSsiBlyXNQuSXAHtB+6XrKNCqUkNQp
         2zoHL/PYH2nFkCb1pZQGfBO26k+S4p1gRybfq+P8lQUGtJswfRUHefDX4CIHlZS/Azcw
         gmwyazAOcO4KxiTRwttFSSYUXvuAE+snGKjPtjnnbFwjDUrRvKMvMZ6ZKDFfTpWjE15A
         m57PPz9ZfRKR18+zJfkbgxGUgw0cpcisFfsGzncuScCfRaOaKY77vHY1L5nLXVMU+uqv
         RL7A==
X-Gm-Message-State: ACgBeo0zjqSQrUT/E/+uBUhdC0jKAmVsxGYWENhpEE0mnPOxYbZXSygp
        8ECd1JvJwrd3zdEtZxLV7NiuNsdKyNiu3bEgP0I=
X-Google-Smtp-Source: AA6agR7MVTXWgeqKm0XAUZzYKkJ+MxnAEj0ELqDuzrzicncnGLvsMui70bDCxtWyLxBHr16kZDNK6yR6l5gLNozEqcI=
X-Received: by 2002:a65:6944:0:b0:41b:4483:35cc with SMTP id
 w4-20020a656944000000b0041b448335ccmr3738941pgq.296.1661527552581; Fri, 26
 Aug 2022 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com> <87k06vdtwu.fsf@oracle.com>
In-Reply-To: <87k06vdtwu.fsf@oracle.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 26 Aug 2022 09:25:39 -0600
Message-ID: <CADvTj4pjOu8zupK=-Vmr9Y4B3ojjBshUC6PN+_9AJQh_YXngww@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.faust@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 7:19 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >>
> >> On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> >> > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >> > >
> >> > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> >> > > > There is a potential for us to hit a type conflict when including
> >> > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> >> > > > with linux/tcp.h to avoid this conflict.
> >> > > >
> >> > > > Fixes errors like:
> >> > > > In file included from /usr/include/netinet/tcp.h:91,
> >> > > >                  from progs/bind4_prog.c:10:
> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> >> > > >    34 | typedef __INT8_TYPE__ int8_t;
> >> > > >       |                       ^~~~~~
> >> > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> >> > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> >> > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> >> > > >                  from progs/bind4_prog.c:9:
> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> >> > > >    24 | typedef __int8_t int8_t;
> >> > > >       |                  ^~~~~~
> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24:
> >> > > > error: conflicting types for 'int64_t'; have 'long int'
> >> > > >    43 | typedef __INT64_TYPE__ int64_t;
> >> > > >       |                        ^~~~~~~
> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note:
> >> > > > previous declaration of 'int64_t' with type 'int64_t' {aka
> >> > > > 'long long int'}
> >> > > >    27 | typedef __int64_t int64_t;
> >> > > >       |                   ^~~~~~~
> >> > > > make: *** [Makefile:537:
> >> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o]
> >> > > > Error 1
> >> > > >
> >> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> > > > ---
> >> > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> >> > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> >> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> >> > > >
> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> > > > b/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> > > > index 474c6a62078a..6bd20042fd53 100644
> >> > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> > > > @@ -6,8 +6,7 @@
> >> > > >  #include <linux/bpf.h>
> >> > > >  #include <linux/in.h>
> >> > > >  #include <linux/in6.h>
> >> > > > -#include <sys/socket.h>
> >> > > > -#include <netinet/tcp.h>
> >> > > These includes look normal to me.  What environment is hitting this.
> >> >
> >> > I was hitting this error with GCC 13(GCC master branch).
> >> These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> >> so does it mean all existing programs need to change to use gcc 13 ?
> >
> > Well I think it's mostly just an issue getting hit with GCC-BPF as it
> > looks to me like a cross compilation host/target header conflict.
>
> This is an interesting issue.
>
> Right now the BPF GCC target is a sort of a bare-metal target.  As such,
> it provides a set of header files that implement ISO C types and other
> machinery (i.e. it doesn't rely on a C library to provide them):
>
>   iso646.h
>   stdalign.h
>   stdarg.h
>   stdatomic.h
>   stdbool.h
>   stddef.h
>   stdfix.h
>   stdint.h
>   stdnoreturn.h
>   tgmath.h
>   unwind.h
>   varargs.h
>
> This is because we were expecting this to be used like:
>
>        <compiler-provided std C headers>
>                   |        |
>                   v        |
>         <kernel headers>   |
>                   |        |
>                   v        v
>                <BPF C program>
>
> However, if it is expected/intended for C BPF programs to include libc
> headers, such as sys/socket.h, this can quickly go sour as you have
> found with that conflict.
>
> So this leads to the question: should we turn the BPF target into a
> target that assumes a libc?  This basically means we will be assuming
> BPF programs are always compiled in an environment that provides a
> standard stdint.h, stdbool.h and friends.

Well for a normal GCC BPF setup we're basically cross compiling for the
BPF bare metal target while sharing headers with the build host(for libbpf
and any other libc headers that get included).

On the other hand when using GCC BPF as part of a full cross toolchain
we actually end up sharing headers with our real cross target architecture
sysroot(which would provide a libc), essentially in that case BPF is a bare
metal cross target which shares headers with the real cross target(which
is not a bare metal target). For this libbpf is installed to the real
cross target
sysroot which is used by both GCC BPF(for bpf progs) and the real cross
target GCC compiler(for userspace side). From my understanding with this
setup GCC BPF will pick up the real cross target libc headers as a fallback
which may sometimes have conflict/compatibility issues with the kernel
headers.

I think it's probably best to avoid depending on libc headers as things may
otherwise get even more complex. You would essentially have 2 libc's
in a normal GCC BPF setup and 3 libc's in a full cross toolchain setup(you'd
have one for the build host, one for the real cross target arch and one for
the BPF target arch).

Cross build systems will typically allow a libc choice as
well(glibc/musl/uclibc)
and we don't really want the bpf programs to have to care about the specific
libc being used as they are bare metal programs which shouldn't depend on
a libc.

>
> Thoughts?
>
> >> > > I don't prefer the selftest writers need to remember this rule.
> >> > >
> >> > > Beside, afaict, tcp.h should be removed because
> >> > > I don't see this test needs it.  I tried removing it
> >> > > and it works fine.  It should be removed instead of replacing it
> >> > > with another unnecessary tcp.h.
> >> >
> >> > Oh, that does also appear to work, thought I had tried that already but I guess
> >> > I hadn't, sent a v2 with them removed:
> >> > https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
> >> >
> >> > >
> >> > > > +#include <linux/tcp.h>
> >> > > >  #include <linux/if.h>
> >> > > >  #include <errno.h>
> >> > > >
> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> > > > b/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> > > > index c19cfa869f30..f37617b35a55 100644
> >> > > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> > > > @@ -6,8 +6,7 @@
> >> > > >  #include <linux/bpf.h>
> >> > > >  #include <linux/in.h>
> >> > > >  #include <linux/in6.h>
> >> > > > -#include <sys/socket.h>
> >> > > > -#include <netinet/tcp.h>
> >> > > > +#include <linux/tcp.h>
> >> > > >  #include <linux/if.h>
> >> > > >  #include <errno.h>
> >> > > >
> >> > > > --
> >> > > > 2.34.1
> >> > > >
