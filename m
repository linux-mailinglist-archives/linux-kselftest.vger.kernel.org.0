Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8724E5A2050
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHZFbc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHZFbb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:31:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50253CCE15;
        Thu, 25 Aug 2022 22:31:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t129so585573pfb.6;
        Thu, 25 Aug 2022 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TfD4HCYoChvyYnkvNrMrHlsM7n269RaODhEp3vSm1O4=;
        b=HTc7PlwiIm8xv8yZNKosixZUkPSqCLgG5ny44zUllqazGVdUqOwQwX/7AXDoFAsq6u
         mLduSjj8gVFOi0bg61DdeYGp48YwxAbYtS4pYNaFd9tSwQEYUOBtldiOoA+DA1cg9lT6
         QHyC4t8t1OCmWgXNVdE50o/4r90gAWKV8bwsJD+3bYtLnJN6Q/4XVJNWAhiuIQQWhnI5
         /Hh0FXxhH1yzjnOPUokDmEb4KAZi3Zm6jvWgHIEVoKk1Odq016NVyMIAnHRje30Eq78F
         /OrZW/2tdfGF2N7WP1yXP6Zx0uEjd6/4gwdLJQwZaqezyraMnDS3GhdkGOxHFHc+OzeV
         ZprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TfD4HCYoChvyYnkvNrMrHlsM7n269RaODhEp3vSm1O4=;
        b=PE269EhKi3QHyGT66aG4eUFOoVXXUJDzIBlNIHQMpUD63R75Xei9HvY7vWc684orot
         wMZyerjfiTt8bHWXSmq76nK9MJXUORcDLCj9EkZuSshzFeae8wdzGLBzRhCp1aL/sUOX
         iZ2sL46sdAjaCna3yDXSDqBWpA6k5GYUULxResSPweXqQE43kqbndPzwwPYawOBEyKxw
         7pyvolUxpf3kh4TrIUSBA2ZFHuYmz+gnjMfCtmezBJb2t+xMcdmK98Y0+gOTDV3XHLfi
         3KXOcfv1tLjTooo4g+Wu/j6tKJ4e4idsZgJMVzqwWHq0NcPeRkOYHxuXDdFDS/HiBQ2c
         RkNA==
X-Gm-Message-State: ACgBeo3bPcds59IQYTKB9Mwh+FE2x4OvnTTf4XThAn03U709ppwTMlbZ
        pUTjWLXy6ovJ1u+tfJptwnffahshV5T0QR0qmUk=
X-Google-Smtp-Source: AA6agR5YvLzan8H2pefnDg1cA7FcHaE7HfI1uPSXxQcqEZ5nvMtf1xkPsJlx97VByWFwjXS6ULNzJYJ2giw3AMUfzzw=
X-Received: by 2002:a65:6944:0:b0:41b:4483:35cc with SMTP id
 w4-20020a656944000000b0041b448335ccmr2035097pgq.296.1661491888797; Thu, 25
 Aug 2022 22:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com> <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 25 Aug 2022 23:31:15 -0600
Message-ID: <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
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

On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > There is a potential for us to hit a type conflict when including
> > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > with linux/tcp.h to avoid this conflict.
> >
> > Fixes errors like:
> > In file included from /usr/include/netinet/tcp.h:91,
> >                  from progs/bind4_prog.c:10:
> > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> >    34 | typedef __INT8_TYPE__ int8_t;
> >       |                       ^~~~~~
> > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> >                  from progs/bind4_prog.c:9:
> > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> >    24 | typedef __int8_t int8_t;
> >       |                  ^~~~~~
> > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> >    43 | typedef __INT64_TYPE__ int64_t;
> >       |                        ^~~~~~~
> > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> >    27 | typedef __int64_t int64_t;
> >       |                   ^~~~~~~
> > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > index 474c6a62078a..6bd20042fd53 100644
> > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > @@ -6,8 +6,7 @@
> >  #include <linux/bpf.h>
> >  #include <linux/in.h>
> >  #include <linux/in6.h>
> > -#include <sys/socket.h>
> > -#include <netinet/tcp.h>
> These includes look normal to me.  What environment is hitting this.

I was hitting this error with GCC 13(GCC master branch).

> I don't prefer the selftest writers need to remember this rule.
>
> Beside, afaict, tcp.h should be removed because
> I don't see this test needs it.  I tried removing it
> and it works fine.  It should be removed instead of replacing it
> with another unnecessary tcp.h.

Oh, that does also appear to work, thought I had tried that already but I guess
I hadn't, sent a v2 with them removed:
https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u

>
> > +#include <linux/tcp.h>
> >  #include <linux/if.h>
> >  #include <errno.h>
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > index c19cfa869f30..f37617b35a55 100644
> > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> > @@ -6,8 +6,7 @@
> >  #include <linux/bpf.h>
> >  #include <linux/in.h>
> >  #include <linux/in6.h>
> > -#include <sys/socket.h>
> > -#include <netinet/tcp.h>
> > +#include <linux/tcp.h>
> >  #include <linux/if.h>
> >  #include <errno.h>
> >
> > --
> > 2.34.1
> >
