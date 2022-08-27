Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1C5A375F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiH0Lip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiH0Lio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 07:38:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082153018;
        Sat, 27 Aug 2022 04:38:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so3942526pfb.7;
        Sat, 27 Aug 2022 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fKm8PTeHvCa5gW5IYcXvuTsv3yWHzgHsjdj8oIF/6x4=;
        b=fR5HBKlN7VZTa78dk2ANAMFEBQ2PRWmM8MhMTZnTcytzb2rjbofsUTFedrZUXf5nd9
         2OWUVq7tYvfmUSIq3+qH3PzcW+HHKpCNCMqEbOG1W7bS/0+fi476T2IF2zGk3opOOKAQ
         cUtuxaWSTPxmcQgKxAVkpTEyikcixreELEmf/Jn7d4tScrIrGybzvMk/VHT8GEjNcnFy
         e2PS04NlgzFUdz11VtUSvZiXEWingoXqCVs+ILfwtf5wv9aLiCr3tPL8s/s1roRTg7km
         8ZCBJy5GU+Z6g8Lri7wP0nSH9I9v+E3OqsvpEiOVFJCWzs5x22eSZy4VKhef5myFrbn/
         8hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fKm8PTeHvCa5gW5IYcXvuTsv3yWHzgHsjdj8oIF/6x4=;
        b=Egw/j5zuX6S0v1NYNNjdAkozmaJnWQpe4GN6vXP+tmIlLr8lR+StNY9Z88stDMgXL2
         vu7zERJynOUYXqzZrWg8w5dXf/B2OKSw0TkCP5D4K2+/idmAKZWhRrYjngeMP6ZKOpp6
         oi2Ojv4xcmchu5YCvpKHC4A0pBUeQdoPAbI/dvsWV3l8lf90PXT9OQOmS1NBptgpkGhg
         U7Fvl4evKvo1J8SYzqnkmNbQiZ8BddYLADjn1r9iYJa5bHyY3NWowi3JGnXLTmpss2Hs
         0tOl9MNRKRe2dNMQ+kfYW9NBTBIYybiLyb2Vht42qkldz8NtbxEkHY1hi1UprO/by4DS
         o77g==
X-Gm-Message-State: ACgBeo3HNHFm7MpFrDl50AR5r6RkHHuBrKHYJkYHBZBXcOnO1XIxdhwo
        +QR8L6yWLLtczWKA7Y9H6a+Z3H3M7KTKE/7RceU=
X-Google-Smtp-Source: AA6agR6CQgq187WrNQh/reDXejA6D1Rg4+gPGYq1dxoJuoHn2mznmL+vIAffWbzJjxb4AWn8ObVNGvTP+MQmXaBoR6w=
X-Received: by 2002:a63:fb4a:0:b0:429:8605:6ebf with SMTP id
 w10-20020a63fb4a000000b0042986056ebfmr6651316pgj.225.1661600323166; Sat, 27
 Aug 2022 04:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220826052925.980431-1-james.hilliard1@gmail.com> <20220826230455.b5dcrvlmollglhx3@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220826230455.b5dcrvlmollglhx3@kafai-mbp.dhcp.thefacebook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 27 Aug 2022 05:38:29 -0600
Message-ID: <CADvTj4rkSRsOtDcC1SCsGH59DyYQWJY_YRJAyt4a29yZP=SSLQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
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

On Fri, Aug 26, 2022 at 5:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 25, 2022 at 11:29:22PM -0600, James Hilliard wrote:
> > There is a potential for us to hit a type conflict when including
> > netinet/tcp.h with sys/socket.h, we can remove these as they are not
> > actually needed.
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
> > Changes v1 -> v2:
> >   - just remove netinet/tcp.h and sys/socket.h
> > ---
> >  tools/testing/selftests/bpf/progs/bind4_prog.c | 2 --
> >  tools/testing/selftests/bpf/progs/bind6_prog.c | 2 --
> >  2 files changed, 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > index 474c6a62078a..a487f60b73ac 100644
> > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > @@ -6,8 +6,6 @@
> >  #include <linux/bpf.h>
> >  #include <linux/in.h>
> >  #include <linux/in6.h>
> > -#include <sys/socket.h>
> > -#include <netinet/tcp.h>
> >  #include <linux/if.h>
> Are the AF_INET and SOCK_STREAM coming from linux/if.h somehow
> and they are not from indirectly including sys/socket.h ?

Hmm, seems they are both coming from sys/socket.h:

Tests with my v2 patch applied:
progs/bind4_prog.c:15: error: "AF_INET" redefined [-Werror]
   15 | #define AF_INET nonsense
      |
In file included from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
                 from /usr/include/linux/if.h:28,
                 from progs/bind4_prog.c:9:
/usr/include/x86_64-linux-gnu/bits/socket.h:97: note: this is the
location of the previous definition
   97 | #define AF_INET         PF_INET
      |

progs/bind4_prog.c:15: error: "SOCK_STREAM" redefined [-Werror]
   15 | #define SOCK_STREAM nonsense
      |
In file included from /usr/include/x86_64-linux-gnu/bits/socket.h:38,
                 from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
                 from /usr/include/linux/if.h:28,
                 from progs/bind4_prog.c:9:
/usr/include/x86_64-linux-gnu/bits/socket_type.h:28: note: this is the
location of the previous definition
   28 | #define SOCK_STREAM SOCK_STREAM
      |

So I guess the problematic header is netinet/tcp.h and sys/socket.h is
just a redundant include?

Removing just netinet/tcp.h does appear sufficient to fix the issue.

>
> If the program does not need if.h, what should it use ?
> There are other progs in selftest/bpf that include sys/socket.h
> and they have no issue ?

I'm still working through gcc issues with the test suite so there's
probably some cases I haven't identified yet but this is the only one
that seemed to need any code changes when removing those 2
headers that I've found so far:
https://lore.kernel.org/bpf/20220826055025.1018491-1-james.hilliard1@gmail.com/
