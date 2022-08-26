Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E555A2DB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbiHZRmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbiHZRmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 13:42:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9FE2C64;
        Fri, 26 Aug 2022 10:42:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo8730809pjd.3;
        Fri, 26 Aug 2022 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SVEAc9oaWwhvsLjCRpgqc3gUfUn0N+3jiLz9lf/QEE0=;
        b=jrbTNnCOFn/3IiMbZtS5oHbXx/Z/L+v8WALSOxCOUFCaVYnGdV9w8k1AI0vjJxSdFj
         m68cRNUVk7cXGOoGaIP5uKsvRlx/V+oTn4LYwkbbC2Vsam1+/SsFT2ctnqHANIgH4xBe
         ixnCvpdXJBCfGSB6ZDZxPRe7d2Jm3RPuuxHJxO6VG8nkOLZJAnx/maXDun1H0eqaMxsp
         ZmGCB6eFljZBXIJKnnHyZzPNycSW58BlELK4CyymZULNmfLr9F7zBO4Vejf32Hhl4huN
         y61UnFf3o3uNOSXrrbMJqKHxLPzFFn6b308Q92LnMKRrInwqk3EytJ09j2ETLL2/DjcQ
         D9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SVEAc9oaWwhvsLjCRpgqc3gUfUn0N+3jiLz9lf/QEE0=;
        b=tI8rHVHu9Y0CK/04frz3LzWyn7/JGSExrpUzH+pBJA1bbeCBb3/mjZXo1xM6+m7v2g
         EZEgP9lCxWu8yJFKRQffXOdBLsMe7aSHIEH9OH0V8xm2TDHtAj3AHJd28kEtkiMbB4ZZ
         PURn7L26F6yRFnmdthmFRKY6UraNQoC238jFsTLmPrtNrgDJ0W32O7PCcN2nE2i0BB5M
         KBHuxhnZ1JEU8Zsy7aekCuOoqvh9omIM5PgUnvsdLw9TAntJAcfVI5e6cWqScdvkN7go
         9la15YyFgGTJ7LbCi9sJNeFomJSyeve4Z+J0QXZvhcO0NwnzTC8v5HfPsw1tYeGOwdTq
         7v0Q==
X-Gm-Message-State: ACgBeo2w+4pvown2/OId2EDDcLRHEGowDa4y1/60pgdmLxYFS1U+9GMA
        83XMaNcacyYACSrt4Mo1UOrq50KvruixuNSkd/A=
X-Google-Smtp-Source: AA6agR73VkI5nQg0Uq15XnxNDnwRXSDwjN4iilceZ2rCXSyc+ELTXRAfOfJ4O12Z1tONjm9l2NqVwPWAN5MiGrI9Ulc=
X-Received: by 2002:a17:902:6b82:b0:16d:d268:3842 with SMTP id
 p2-20020a1709026b8200b0016dd2683842mr4673930plk.16.1661535742946; Fri, 26 Aug
 2022 10:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com> <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 26 Aug 2022 11:42:10 -0600
Message-ID: <CADvTj4qg6R9udazmGFoFhn9pXN6HOqLGEsQOhCAELi1LxzoTmw@mail.gmail.com>
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

On Fri, Aug 26, 2022 at 11:17 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Aug 26, 2022 at 12:13:54AM -0600, James Hilliard wrote:
> > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> > > > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > >
> > > > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > > > > > There is a potential for us to hit a type conflict when including
> > > > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > > > > > with linux/tcp.h to avoid this conflict.
> > > > > >
> > > > > > Fixes errors like:
> > > > > > In file included from /usr/include/netinet/tcp.h:91,
> > > > > >                  from progs/bind4_prog.c:10:
> > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> > > > > >    34 | typedef __INT8_TYPE__ int8_t;
> > > > > >       |                       ^~~~~~
> > > > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > > > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > > > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > > > > >                  from progs/bind4_prog.c:9:
> > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> > > > > >    24 | typedef __int8_t int8_t;
> > > > > >       |                  ^~~~~~
> > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> > > > > >    43 | typedef __INT64_TYPE__ int64_t;
> > > > > >       |                        ^~~~~~~
> > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> > > > > >    27 | typedef __int64_t int64_t;
> > > > > >       |                   ^~~~~~~
> > > > > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> > > > > >
> > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> > > > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> > > > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > index 474c6a62078a..6bd20042fd53 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > > @@ -6,8 +6,7 @@
> > > > > >  #include <linux/bpf.h>
> > > > > >  #include <linux/in.h>
> > > > > >  #include <linux/in6.h>
> > > > > > -#include <sys/socket.h>
> > > > > > -#include <netinet/tcp.h>
> > > > > These includes look normal to me.  What environment is hitting this.
> > > >
> > > > I was hitting this error with GCC 13(GCC master branch).
> > > These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> > > so does it mean all existing programs need to change to use gcc 13 ?
> >
> > Well I think it's mostly just an issue getting hit with GCC-BPF as it
> > looks to me like a cross compilation host/target header conflict.
> The users have been using these headers in the bpf progs.

Users can migrate away from libc headers over time, migrating away
shouldn't cause regressions and should improve reliability.

> The solution should be on the GCC-BPF side instead of changing
> all bpf progs.

I mean, GCC doesn't really control which libc is available, it seems to
be a bad idea to use libc headers in general as they are developed
separately from GCC and the kernel/libbpf.

I'm not really sure how one would fix this on the GCC-BPF side without
introducing more potential header conflicts.
