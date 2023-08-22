Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4C784C27
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjHVVip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjHVVip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 17:38:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB2133
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:38:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so12312976a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692740322; x=1693345122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yto2kk6DBSJ1V5ZImzvYQx7OM25yQ1eu7dHzXWPe8ao=;
        b=vmKH5XaOyyiRgLUGfWw3BHuFln5Yd03mzRPVgPjr+nY/eAZ+J4Fg0KV7ycSV2XTYVZ
         m0EYdreTRwSwva2WtoEjz3iadvJZQdb20kzUhLVc4vt/J2IjKrptWOYEx0kPl9CE4fPe
         P73C7+YqSzqDTWVSFIW64es0ra2GYNm3HN7hV6nuu1vTNlKFQkwDSovL34JgrbdK12A1
         pBLPBQV//uXBUqhrGwtXm2wA/9TlkdAfNSzGf0m2+9UbQYidCE/184s+j5PNrgUEqGhv
         lURkL6pi4yWpzb5OO6ZgTy8MYWUIT5qLyuuMUR1Rnh5T4siYsVkwhqBiB4JQJuwYa7EH
         Pw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740322; x=1693345122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yto2kk6DBSJ1V5ZImzvYQx7OM25yQ1eu7dHzXWPe8ao=;
        b=HP8/ZeGo56pTs9odmK240SDqcqTEcvpw3lnAWASHKzX01uqraawlNv84zBaGY/cVUp
         WnMAG5X/mzrBV0GkXv99sOZye1uLU+GLL9b5sBejjgEPUwWx4BT7uUT4v+8JBlEmZWBK
         Lh8zIFyIuT4Gs4Qgz9Goau39H3mXGTaAC14Lv2m28Qf6lm9C1iGz2A9PTVh8ujZAY1Y9
         AJOdVdMurRi1zHgc+/Jco8UGm2UbsVLl5waxWHbQ8my6pDQ8FSGLlCLY5JzUXEdqDJ2V
         H3KDyKIS4VgssBWnJbxj5+uJTDrsz98ultyTTPSngCGPSDW7Cx4nGfxT74DyrNne6tUf
         gWUw==
X-Gm-Message-State: AOJu0YwONHy6i6zQNyQxqw4+iuucyjeJt5SWB7S7U6yJp2cxEok1RgQX
        e7rcSshhoFydTEFKiie+Qs+o6a5Vr3WWuVBHw1s2UAx+uI9M/pwP4VmuAw==
X-Google-Smtp-Source: AGHT+IG9y9F4GEeS+t1s2A1hj/NgdZZSvZh6IBK6jRU2acBGiGcHy35VP9tKp6KwcvC4f9C3t3Y2KbT5MO4fhwkvnuM=
X-Received: by 2002:a05:6402:792:b0:521:ad49:8493 with SMTP id
 d18-20020a056402079200b00521ad498493mr12142075edy.6.1692740322016; Tue, 22
 Aug 2023 14:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com> <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 22 Aug 2023 14:38:29 -0700
Message-ID: <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 2:36=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Justin Stitt <justinstitt@google=
.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 2:15=E2=80=AFPM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 11:06=E2=80=AFPM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@=
google.com> wrote:
> > > > >
> > > > [...]
> > > > > > > > Here's the invocation I am running to build kselftest:
> > > > > > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLV=
M=3D1 ARCH=3Dx86_64
> > > > > > > > -j128 V=3D1 -C tools/testing/selftests`
> > > > > >
> > > > > > I think I fixed the same issue in the script I am running to la=
unch
> > > > > > those tests in a VM. This was in commit
> > > > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ serie=
s).
> > > > > >
> > > > > > And in the commit log, I wrote:
> > > > > > ```
> > > > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > > > "make headers" is a prerequisite"), running the kselftests requ=
ires
> > > > > > to run "make headers" first.
> > > > > > ```
> > > > > >
> > > > > > So my assumption is that you also need to run "make headers" wi=
th the
> > > > > > proper flags before compiling the selftests themselves (I might=
 be
> > > > > > wrong but that's how I read the commit).
> > > > >
> > > > > In my original email I pasted the invocation I used which include=
s the
> > > > > headers target. What are the "proper flags" in this case?
> > > > >
> > > >
> > > > "make LLVM=3D1 ARCH=3Dx86_64 headers" no?
> > > >
> > > > But now I'm starting to wonder if that was not the intent of your
> > > > combined "make mrproper headers". I honestly never tried to combine
> > > > the 2. It's worth a try to split them I would say.
> > >
> > > Apologies, I just tested it, and it works (combining the 2).
> > >
> > > Which kernel are you trying to test?
> > > I tested your 2 commands on v6.5-rc7 and it just works.
> >
> > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> >
> > I ran these exact commands:
> > |    $ make mrproper
> > |    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> > |    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selftests
> > TARGETS=3Dhid &> out
> >
> > and here's the contents of `out` (still warnings/errors):
> > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
> >
> > I have a feeling I'm doing something fundamentally incorrectly. Any ide=
as?
>
> Sigh... there is a high chance my Makefile is not correct and uses the
> installed headers (I was running the exact same commands, but on a
> v6.4-rc7+ kernel).
>
> But sorry, it will have to wait for tomorrow if you want me to have a
> look at it. It's 11:35 PM here, and I need to go to bed
Take it easy. Thanks for the prompt responses here! I'd like to get
the entire kselftest make target building with Clang so that we can
close [1].

>
> Cheers,
> Benjamin
>
> >
> > To be clear, I can build the Kernel itself just fine across many
> > configs and architectures. I have, at the very least, the dependencies
> > required to accomplish that.
> >
> > >
> > > FTR:
> > > $> git checkout v6.5-rc7
> > > $> make LLVM=3D1 ARCH=3Dx86_64 mrproper headers
> > > $> make LLVM=3D1 ARCH=3Dx86_64 -j8 -C tools/testing/selftests TARGETS=
=3Dhid
> > >
> > > ->   BINARY   hid_bpf
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
>

[1]: https://github.com/ClangBuiltLinux/linux/issues/1910
