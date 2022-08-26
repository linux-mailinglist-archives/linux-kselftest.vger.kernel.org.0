Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53B5A20B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiHZGOM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 02:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiHZGOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 02:14:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38934BCC38;
        Thu, 25 Aug 2022 23:14:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a65so678098pfa.1;
        Thu, 25 Aug 2022 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h6vPwvG1eOkQpAC5Em2N5b6VPCfvePS3xQSt2oOQck4=;
        b=hm+bW9uGuVV9IQnmCk3BOzBf0iilvnUqTXRZaVhny7OquF+nPI51w1ezQOuQ7eeckr
         YvZ6i7oqlf81Lc3vQ/WtSUpdRY+nIoZJzqQunkkqEO+Hm/Yr4RgUflRS60qPmu1In6em
         H8LUA2EjRpBcEGeNxNx+WXnKKJa4N4gW8JTwPEpa505Zkt8l6+wNJEciDDQxzi0PfvfU
         eEoEwvE1cMQfK5WCife6UJnTWhkCx6RJ8HSf9CnFxFZrLz71WSkEfjIfdRR28Zqv4Sjr
         R6uAFfHEYMSS8LKa8jhLkWmoutgubzfuOxiHwfgCO27s9QUfMRtxS5lCi+tzfO8shti0
         jbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h6vPwvG1eOkQpAC5Em2N5b6VPCfvePS3xQSt2oOQck4=;
        b=WnVHcsNrcgy3EElJ0Mx7QVxocvKz+fiaFvHCw9J1pFzOzkIb1HDyekG9t5sE+/Z3FA
         cXovIghEpAh7FRVziTKkcOh1098aiC4Mr2W0octFzj2oh1W57duAwzfwOSwkeJpj6xsb
         fYigqgNt7vi3yG10WAlKZgq5vaMRXOiyLSCUNxKuhQBz8f0rl3Tf5RYNzpdMjGcNlq+5
         hB+bliMB4HTMZCnhDso8zI4bazA2h/PhI+gUJ6zPE2x/R38lWuafBXcybP7eyCzczmJC
         ojuxnBoEq5Fk2SKpTyGTeWYrpqZctzajW3oABGV8wvcL0r0/O8KglwDEh/cEUCUBDm4Y
         aZOQ==
X-Gm-Message-State: ACgBeo1wwsKLZnWIE52JN2B8UPA67stTBxUt/VykU6PkWkXEAIoJ1hG4
        Q6gsNRqJH/kxudaNJ0Cr3P3Cg4qVe++z2WDjXvI=
X-Google-Smtp-Source: AA6agR5oDZJR/frhZRnlNnAattouhZlDZJe50IAr5qsbrG2E6Lhav8BG/MU7GCv7+pk20zQVLxQCvml4Am01ngIr8ao=
X-Received: by 2002:a63:fb4a:0:b0:429:8605:6ebf with SMTP id
 w10-20020a63fb4a000000b0042986056ebfmr2051552pgj.225.1661494447719; Thu, 25
 Aug 2022 23:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com> <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 26 Aug 2022 00:13:54 -0600
Message-ID: <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
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
        linux-kernel@vger.kernel.org
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

On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > > > There is a potential for us to hit a type conflict when including
> > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > > > with linux/tcp.h to avoid this conflict.
> > > >
> > > > Fixes errors like:
> > > > In file included from /usr/include/netinet/tcp.h:91,
> > > >                  from progs/bind4_prog.c:10:
> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> > > >    34 | typedef __INT8_TYPE__ int8_t;
> > > >       |                       ^~~~~~
> > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > > >                  from progs/bind4_prog.c:9:
> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> > > >    24 | typedef __int8_t int8_t;
> > > >       |                  ^~~~~~
> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> > > >    43 | typedef __INT64_TYPE__ int64_t;
> > > >       |                        ^~~~~~~
> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> > > >    27 | typedef __int64_t int64_t;
> > > >       |                   ^~~~~~~
> > > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> > > >
> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > index 474c6a62078a..6bd20042fd53 100644
> > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > @@ -6,8 +6,7 @@
> > > >  #include <linux/bpf.h>
> > > >  #include <linux/in.h>
> > > >  #include <linux/in6.h>
> > > > -#include <sys/socket.h>
> > > > -#include <netinet/tcp.h>
> > > These includes look normal to me.  What environment is hitting this.
> >
> > I was hitting this error with GCC 13(GCC master branch).
> These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> so does it mean all existing programs need to change to use gcc 13 ?

Well I think it's mostly just an issue getting hit with GCC-BPF as it
looks to me like a cross compilation host/target header conflict.

>
> >
> > > I don't prefer the selftest writers need to remember this rule.
> > >
> > > Beside, afaict, tcp.h should be removed because
> > > I don't see this test needs it.  I tried removing it
> > > and it works fine.  It should be removed instead of replacing it
> > > with another unnecessary tcp.h.
> >
> > Oh, that does also appear to work, thought I had tried that already but I guess
> > I hadn't, sent a v2 with them removed:
> > https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
> >
> > >
> > > > +#include <linux/tcp.h>
> > > >  #include <linux/if.h>
> > > >  #include <errno.h>
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > > index c19cfa869f30..f37617b35a55 100644
> > > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > > > @@ -6,8 +6,7 @@
> > > >  #include <linux/bpf.h>
> > > >  #include <linux/in.h>
> > > >  #include <linux/in6.h>
> > > > -#include <sys/socket.h>
> > > > -#include <netinet/tcp.h>
> > > > +#include <linux/tcp.h>
> > > >  #include <linux/if.h>
> > > >  #include <errno.h>
> > > >
> > > > --
> > > > 2.34.1
> > > >
