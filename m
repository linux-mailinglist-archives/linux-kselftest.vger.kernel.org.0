Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF78C5A50A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2PuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2PuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:50:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77CD47B8C;
        Mon, 29 Aug 2022 08:50:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so3657598pjj.4;
        Mon, 29 Aug 2022 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=taWUzi4UHNfxICa8CAve34OKJtJJKSkD21g1k9CF/lA=;
        b=bnPj20mJnripHXQ/GXvCmT3YEOJYNbHJkMkHYD8cOZCdgZEOncfbxWW7i8XLvWPDT9
         zo7UAer/yx8HxZEp6Ek/u3o1cgFe35r8AtlRmiq+gnwHIYY3ElFXHTfkh42rzH90I0gm
         m/EMCBdk4lYUnl+11n2bG2S26YwT9UUc7clJqCaOcBVqBNXDfjqjBXSTIWzj+HCUqNRT
         qNi5LZLElki9RY4b5b3yiHAvuR27ALlvvOYFsLNrMBm/IaeBjZTU0cbFAdz6Op1dbc5g
         vR5QTAQp4RnYAWwNN5+5Z+fLbZcrIJeil/1JSrt4lN/ooVCdEX4XSMfU5YjzWrZSny/h
         xGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=taWUzi4UHNfxICa8CAve34OKJtJJKSkD21g1k9CF/lA=;
        b=XRGc0TwrOeazTzCvZoEERvnWxfW2/8pIxXS89pXdwulgIz6hcnl5WCL2thudximj4T
         47Wbem/M6Rxh6sIijXz4RqLhmJo002pW5rIJPf6AVaMx8vgZkrpsf8aB4TzUm/E4iZI7
         cMXJpQqx6HP7pMi7wsv5SHqSZkEtKap1hxALbiGRPdgHuwPX/67Ab8JOFJCHZO3fpGhj
         UabpjeagJNcq8toFLKO68TlBhJFC+pZMnoGswnGdJc6tS4JJ25CRudEUAibhnNJMVEk5
         c4wmI2B/aLo2Cj9VC24KRV7kx1tP0vjOPA3PmhAvMgM18ZeIHhb/Sci6bZoVHjnw3Qm+
         fTVw==
X-Gm-Message-State: ACgBeo3pQH9t4WZCT6ruaHKDIo3CNmHGGTgyFFp/Ccts/2o7utY80YmG
        eJ+nEI5cwG0XbtgCyRkMm6ulmR0br4C0IBSGPFA=
X-Google-Smtp-Source: AA6agR4Z7lZcBO08T5IU5jtduvQotk3IRF4XS9ujug0Qp2Q/1F53ezAKf+Bg8HsYE1WjtYp8IpfZMYcn4CE3dbBTQe8=
X-Received: by 2002:a17:90a:d714:b0:1fd:ea53:b924 with SMTP id
 y20-20020a17090ad71400b001fdea53b924mr2976795pju.70.1661788208072; Mon, 29
 Aug 2022 08:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220826055025.1018491-1-james.hilliard1@gmail.com> <e3d9f936-926c-8cd4-1a21-4c2894bf22b6@iogearbox.net>
In-Reply-To: <e3d9f936-926c-8cd4-1a21-4c2894bf22b6@iogearbox.net>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 29 Aug 2022 09:49:55 -0600
Message-ID: <CADvTj4qBmZyzoSsHVYcg1mLvBRqCr59dWJk2t_mf7njUesa+dA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix connect4_prog tcp/socket header type conflict
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 29, 2022 at 9:11 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 7:50 AM, James Hilliard wrote:
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > index b241932911db..0f68b8d756b3 100644
> > --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> > +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> > @@ -7,8 +7,7 @@
> >   #include <linux/bpf.h>
> >   #include <linux/in.h>
> >   #include <linux/in6.h>
> > -#include <sys/socket.h>
> > -#include <netinet/tcp.h>
> > +#include <linux/tcp.h>
> >   #include <linux/if.h>
> >   #include <errno.h>
>
> Can't we just add:
>
> #include "bpf_tcp_helpers.h"

Yeah, that seems to work, changed in v2:
https://lore.kernel.org/bpf/20220829154710.3870139-1-james.hilliard1@gmail.com/

>
> It does define SOL_TCP already and is used also in other prog tests. I presume this
> would avoid the need the change all the below.
>
> > @@ -52,7 +51,7 @@ static __inline int verify_cc(struct bpf_sock_addr *ctx,
> >       char buf[TCP_CA_NAME_MAX];
> >       int i;
> >
> > -     if (bpf_getsockopt(ctx, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
> > +     if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
> >               return 1;
> >
> >       for (i = 0; i < TCP_CA_NAME_MAX; i++) {
> > @@ -70,12 +69,12 @@ static __inline int set_cc(struct bpf_sock_addr *ctx)
> >       char reno[TCP_CA_NAME_MAX] = "reno";
> >       char cubic[TCP_CA_NAME_MAX] = "cubic";
> >
> > -     if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
> > +     if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
> >               return 1;
> >       if (verify_cc(ctx, reno))
> >               return 1;
> >
> > -     if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
> > +     if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
> >               return 1;
> >       if (verify_cc(ctx, cubic))
> >               return 1;
> > @@ -113,15 +112,15 @@ static __inline int set_keepalive(struct bpf_sock_addr *ctx)
> >       if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &one, sizeof(one)))
> >               return 1;
> >       if (ctx->type == SOCK_STREAM) {
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
> >                       return 1;
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
> >                       return 1;
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPCNT, &one, sizeof(one)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPCNT, &one, sizeof(one)))
> >                       return 1;
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_SYNCNT, &one, sizeof(one)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_SYNCNT, &one, sizeof(one)))
> >                       return 1;
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
> >                       return 1;
> >       }
> >       if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &zero, sizeof(zero)))
> > @@ -135,7 +134,7 @@ static __inline int set_notsent_lowat(struct bpf_sock_addr *ctx)
> >       int lowat = 65535;
> >
> >       if (ctx->type == SOCK_STREAM) {
> > -             if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
> > +             if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
> >                       return 1;
> >       }
> >
> >
>
