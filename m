Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D04C5A2D35
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiHZRPq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbiHZRPm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 13:15:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49E6A496;
        Fri, 26 Aug 2022 10:15:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso2412925pjr.3;
        Fri, 26 Aug 2022 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Tu7jZIwBy6/TS9+OySwXlSz0DQjny7bOfymyrHR7AeA=;
        b=K1ywY816vNzOH+FurpUkO1yIy9EQewMiISFKqCKsUaxaE0Kt571wzuyKwEowB2S3l0
         ilLiFXIPQ3UT3Ji4zwRxiq8FFSx4Wb/DfmuQqgZdegeYbgfNtks1w5q2bv1zCpDsZ1he
         CSI+dyf6Vd737/GR0pKlyxajy32IYiOAm+nCprTtXiMGNAEMjjieR5azvlpv5NNBAc7z
         tWwSel7dSyf0NJVbVHuc0MPI0VMyUM9uOhDTi97yupW7uBVxA7+nEhuaVyxyb+UlyVMg
         dcNe3WbtnJyuVWu3T96ZmI6TEtMl119ukss1P7NgofqpoSGSZAk+Ch3wQKKKqdsVyvgq
         K5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Tu7jZIwBy6/TS9+OySwXlSz0DQjny7bOfymyrHR7AeA=;
        b=i4ym7goh2d0OOPheapPQTYM5qXyDgUpKlMMrpj6HL4l0PxwIG2D6N8UluEPgcs9wpJ
         pV6Js8n9QX2J0LGJMiqSUEolqMZGCEWoqXpzKWKp8zV6hCXTwzEFelnRqxl9NsfO/7K0
         6aabG3RSNsLVqtnbMKVxz3c0LG8d/wLtRqiHMMBEujaSJjg8aAR/Y/AVqQc+9nIIH6Ci
         omHAjSioc2PwyBUef3ThwPo8Tm8SLHuGKDICElbjdzk7g4hC4clBF+p1vA67+WPe4uhP
         zfPgfulGMZSxhJphz4BNtsmCpXOib0FKnA+gxde7iHinnulpHtxX349pqxm4V8kA3AS6
         7jUA==
X-Gm-Message-State: ACgBeo0L82pOZdMPbUd5Yozsge7ngwj6gz3XhygIfJwCp0xGye3OFSPP
        hzvF0VV3DS5l1eVtuQ53t1ULZrvBY/kHMeCTwV8=
X-Google-Smtp-Source: AA6agR5IkkCY9xhQdSMz9NzCNcAayQ+g0Ik/Vceq7ZYqgL9iiUzRaxGcmtELFqloO++Zxi/GuJBPD4nwO5VdqDJRxsg=
X-Received: by 2002:a17:902:6b82:b0:16d:d268:3842 with SMTP id
 p2-20020a1709026b8200b0016dd2683842mr4573674plk.16.1661534140902; Fri, 26 Aug
 2022 10:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
 <87k06vdtwu.fsf@oracle.com> <CADvTj4pjOu8zupK=-Vmr9Y4B3ojjBshUC6PN+_9AJQh_YXngww@mail.gmail.com>
 <87czcndkxq.fsf@oracle.com>
In-Reply-To: <87czcndkxq.fsf@oracle.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 26 Aug 2022 11:15:28 -0600
Message-ID: <CADvTj4oxd2hB6JH3qYNvCvU0c2Sq5M2UfD=zNPnYsEQT56nYuw@mail.gmail.com>
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

On Fri, Aug 26, 2022 at 10:33 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Fri, Aug 26, 2022 at 7:19 AM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >> >>
> >> >> On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> >> >> > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >> >> > >
> >> >> > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> >> >> > > > There is a potential for us to hit a type conflict when including
> >> >> > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> >> >> > > > with linux/tcp.h to avoid this conflict.
> >> >> > > >
> >> >> > > > Fixes errors like:
> >> >> > > > In file included from /usr/include/netinet/tcp.h:91,
> >> >> > > >                  from progs/bind4_prog.c:10:
> >> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> >> >> > > >    34 | typedef __INT8_TYPE__ int8_t;
> >> >> > > >       |                       ^~~~~~
> >> >> > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> >> >> > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> >> >> > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> >> >> > > >                  from progs/bind4_prog.c:9:
> >> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> >> >> > > >    24 | typedef __int8_t int8_t;
> >> >> > > >       |                  ^~~~~~
> >> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24:
> >> >> > > > error: conflicting types for 'int64_t'; have 'long int'
> >> >> > > >    43 | typedef __INT64_TYPE__ int64_t;
> >> >> > > >       |                        ^~~~~~~
> >> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note:
> >> >> > > > previous declaration of 'int64_t' with type 'int64_t' {aka
> >> >> > > > 'long long int'}
> >> >> > > >    27 | typedef __int64_t int64_t;
> >> >> > > >       |                   ^~~~~~~
> >> >> > > > make: *** [Makefile:537:
> >> >> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o]
> >> >> > > > Error 1
> >> >> > > >
> >> >> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >> >> > > > ---
> >> >> > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> >> >> > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> >> >> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> >> >> > > >
> >> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> >> > > > b/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> >> > > > index 474c6a62078a..6bd20042fd53 100644
> >> >> > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> >> >> > > > @@ -6,8 +6,7 @@
> >> >> > > >  #include <linux/bpf.h>
> >> >> > > >  #include <linux/in.h>
> >> >> > > >  #include <linux/in6.h>
> >> >> > > > -#include <sys/socket.h>
> >> >> > > > -#include <netinet/tcp.h>
> >> >> > > These includes look normal to me.  What environment is hitting this.
> >> >> >
> >> >> > I was hitting this error with GCC 13(GCC master branch).
> >> >> These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> >> >> so does it mean all existing programs need to change to use gcc 13 ?
> >> >
> >> > Well I think it's mostly just an issue getting hit with GCC-BPF as it
> >> > looks to me like a cross compilation host/target header conflict.
> >>
> >> This is an interesting issue.
> >>
> >> Right now the BPF GCC target is a sort of a bare-metal target.  As such,
> >> it provides a set of header files that implement ISO C types and other
> >> machinery (i.e. it doesn't rely on a C library to provide them):
> >>
> >>   iso646.h
> >>   stdalign.h
> >>   stdarg.h
> >>   stdatomic.h
> >>   stdbool.h
> >>   stddef.h
> >>   stdfix.h
> >>   stdint.h
> >>   stdnoreturn.h
> >>   tgmath.h
> >>   unwind.h
> >>   varargs.h
> >>
> >> This is because we were expecting this to be used like:
> >>
> >>        <compiler-provided std C headers>
> >>                   |        |
> >>                   v        |
> >>         <kernel headers>   |
> >>                   |        |
> >>                   v        v
> >>                <BPF C program>
> >>
> >> However, if it is expected/intended for C BPF programs to include libc
> >> headers, such as sys/socket.h, this can quickly go sour as you have
> >> found with that conflict.
> >>
> >> So this leads to the question: should we turn the BPF target into a
> >> target that assumes a libc?  This basically means we will be assuming
> >> BPF programs are always compiled in an environment that provides a
> >> standard stdint.h, stdbool.h and friends.
> >
> > Well for a normal GCC BPF setup we're basically cross compiling for the
> > BPF bare metal target while sharing headers with the build host(for libbpf
> > and any other libc headers that get included).
> >
> > On the other hand when using GCC BPF as part of a full cross toolchain
> > we actually end up sharing headers with our real cross target architecture
> > sysroot(which would provide a libc), essentially in that case BPF is a bare
> > metal cross target which shares headers with the real cross target(which
> > is not a bare metal target). For this libbpf is installed to the real
> > cross target
> > sysroot which is used by both GCC BPF(for bpf progs) and the real cross
> > target GCC compiler(for userspace side). From my understanding with this
> > setup GCC BPF will pick up the real cross target libc headers as a fallback
> > which may sometimes have conflict/compatibility issues with the kernel
> > headers.
> >
> > I think it's probably best to avoid depending on libc headers as things may
> > otherwise get even more complex. You would essentially have 2 libc's
> > in a normal GCC BPF setup and 3 libc's in a full cross toolchain setup(you'd
> > have one for the build host, one for the real cross target arch and one for
> > the BPF target arch).
> >
> > Cross build systems will typically allow a libc choice as
> > well(glibc/musl/uclibc)
> > and we don't really want the bpf programs to have to care about the specific
> > libc being used as they are bare metal programs which shouldn't depend on
> > a libc.
> >
>
> I don't understand what do you mean with "real cross target".

I mean the real cross target architecture as in the real hardware target
architecture, for example aarch64 when cross compiling from a x86_64
build host.

>
> From the toolchain perspective, the compiler is targetted to just one
> platform: bpf-unknown-none.  As is usual for bare-metal targets, the
> compiler provides headers to implement the C standard with things like
> floating-point types and standard integer types, `bool', etc.

Yeah, I mean gcc doesn't have proper multi-arch support like llvm does
so a complete gcc cross toolchain(one which is sufficient to build
kernel/userspace needed for say an aarch64 cross target along with bpf
programs) is effectively two gcc toolchains bundled together. In some ways
it gets used more like a separate language than a separate target.

I have a pending series for buildroot adding gcc-bpf support if you're
curious what this currently looks like:
https://lore.kernel.org/buildroot/20220809094109.2279598-1-james.hilliard1@gmail.com/

>
> If you then -I directories in order to "share headers with the build
> host" or with that "real cross target", or to use any other header that
> may implement the same types (typically a libc) then well, thats when
> the problem arises.

Well I'm using -idirafter for including those build host/real cross target
header directories with lowest priority, since those directories have least
priority the conflicts would otherwise be missing header errors AFAIU if
I didn't include them.

From my understanding we need to include these directories as they
provide the kernel headers required by many bpf programs.

>
> I don't know how much sense does it makes to include glibc headers like
> sys/socket.h in BPF C programs: I'm no BPF programmer.  But if it is
> something to be supported, we will have to change the compiler to not
> provide the standard headers.

I think it's best to just avoid libc headers in BPF programs.

>
> >> Thoughts?
> >>
> >> >> > > I don't prefer the selftest writers need to remember this rule.
> >> >> > >
> >> >> > > Beside, afaict, tcp.h should be removed because
> >> >> > > I don't see this test needs it.  I tried removing it
> >> >> > > and it works fine.  It should be removed instead of replacing it
> >> >> > > with another unnecessary tcp.h.
> >> >> >
> >> >> > Oh, that does also appear to work, thought I had tried that already but I guess
> >> >> > I hadn't, sent a v2 with them removed:
> >> >> > https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
> >> >> >
> >> >> > >
> >> >> > > > +#include <linux/tcp.h>
> >> >> > > >  #include <linux/if.h>
> >> >> > > >  #include <errno.h>
> >> >> > > >
> >> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> >> > > > b/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> >> > > > index c19cfa869f30..f37617b35a55 100644
> >> >> > > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> >> >> > > > @@ -6,8 +6,7 @@
> >> >> > > >  #include <linux/bpf.h>
> >> >> > > >  #include <linux/in.h>
> >> >> > > >  #include <linux/in6.h>
> >> >> > > > -#include <sys/socket.h>
> >> >> > > > -#include <netinet/tcp.h>
> >> >> > > > +#include <linux/tcp.h>
> >> >> > > >  #include <linux/if.h>
> >> >> > > >  #include <errno.h>
> >> >> > > >
> >> >> > > > --
> >> >> > > > 2.34.1
> >> >> > > >
