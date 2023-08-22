Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E75784C2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjHVVm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHVVmZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 17:42:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A5DEC
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79248cacfeaso31098539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692740543; x=1693345343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Ow6pCM+QP20h9g5N2QdjyOQ38DqfmJbWYeM8K1qy+4=;
        b=i20RSApAOKJ8ir/jJsfJdPMau9sFLKKFzH6B+BHHpOzr48x9Zyv+B6H0aUTWLLFJn0
         TQtaVX0uIct/8a1ZutlOlFnoEpaaK64QVZl3G+2gFh3n+5V6C3O+1rmk9dCprwmkZ0Lm
         9SCcXovO4dPpCvNpEh+Kzh9kxr9GAtWoK8gjmIK0mVdNv63/2XNH0+qqezIC8GVfrbdw
         HD/oK2+U/wtoZYACKCJQfjQ0yba40qV0dUGopakg+QC2VpErWjmHWIilptZDH7h/jqzI
         Hg+BY/D0UekKBcXqLmnnfO10+/0SJ34wzRZwUBXnzinSseqm1iOoSdsgpBRw/cazEEtu
         QOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740543; x=1693345343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ow6pCM+QP20h9g5N2QdjyOQ38DqfmJbWYeM8K1qy+4=;
        b=WZzrwLn3RNuD9KM5cScLBJnrzY2vScy2Xa8CStjMza7IS8JderqlT6EA984f0bC9Ye
         /5aM1i+rinBfnULDBjwADmGrCNotMfOh1NDIi4yBkTD6gfGofjsfT0snJPg3JJOp2t+r
         +HE5zogsH+3umPNqUPxz40NdjDvCCLye80udhLJvC/ve6t6KErLGt4o9PDuaXI1d3PkM
         iTqaG61J+wPc5DwcJfg0XlAXkfo8cLTG9Rualq/ZKjaVaDYYo+L7sjci4frtSovCAAqX
         2W/JEj1T9Ic7D+t78hrz4VlKjiY5gWbKUWDWlD3G3fs/8lGBUWIaOwtjFEWDuq+WXZwa
         lmlQ==
X-Gm-Message-State: AOJu0Ywuc8KQFQ2cMm8t2fift9nbiSgSS0T8mn06VlcNEsQVVYQBYRh0
        Onb0/OdxJtKW9wtMqkLRH/qSpg==
X-Google-Smtp-Source: AGHT+IEcpbrFTOH03Us9iPSIjiXeODFg/lzJ/XzgUDSbSKxU/6ulWFVq80iXoxB8Lz7Yq2tK3/gcOg==
X-Received: by 2002:a5e:c102:0:b0:788:2eaf:46ce with SMTP id v2-20020a5ec102000000b007882eaf46cemr1048760iol.9.1692740543076;
        Tue, 22 Aug 2023 14:42:23 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id 3-20020a5ea503000000b0078714764ca0sm2930223iog.40.2023.08.22.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:42:22 -0700 (PDT)
Date:   Tue, 22 Aug 2023 21:42:20 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
Message-ID: <20230822214220.jjx3srik4mteeond@google.com>
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
 <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
 <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 02:38:29PM -0700, Justin Stitt wrote:
> On Tue, Aug 22, 2023 at 2:36 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 11:26 PM Justin Stitt <justinstitt@google.com> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 2:15 PM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 11:06 PM Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 10:57 PM Justin Stitt <justinstitt@google.com> wrote:
> > > > > >
> > > > > [...]
> > > > > > > > > Here's the invocation I am running to build kselftest:
> > > > > > > > > `$ make LLVM=1 ARCH=x86_64 mrproper headers && make LLVM=1 ARCH=x86_64
> > > > > > > > > -j128 V=1 -C tools/testing/selftests`
> > > > > > >
> > > > > > > I think I fixed the same issue in the script I am running to launch
> > > > > > > those tests in a VM. This was in commit
> > > > > > > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> > > > > > >
> > > > > > > And in the commit log, I wrote:
> > > > > > > ```
> > > > > > > According to commit 01d6c48a828b ("Documentation: kselftest:
> > > > > > > "make headers" is a prerequisite"), running the kselftests requires
> > > > > > > to run "make headers" first.
> > > > > > > ```
> > > > > > >
> > > > > > > So my assumption is that you also need to run "make headers" with the
> > > > > > > proper flags before compiling the selftests themselves (I might be
> > > > > > > wrong but that's how I read the commit).
> > > > > >
> > > > > > In my original email I pasted the invocation I used which includes the
> > > > > > headers target. What are the "proper flags" in this case?
> > > > > >
> > > > >
> > > > > "make LLVM=1 ARCH=x86_64 headers" no?
> > > > >
> > > > > But now I'm starting to wonder if that was not the intent of your
> > > > > combined "make mrproper headers". I honestly never tried to combine
> > > > > the 2. It's worth a try to split them I would say.
> > > >
> > > > Apologies, I just tested it, and it works (combining the 2).
> > > >
> > > > Which kernel are you trying to test?
> > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > >
> > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> > >
> > > I ran these exact commands:
> > > |    $ make mrproper
> > > |    $ make LLVM=1 ARCH=x86_64 headers
> > > |    $ make LLVM=1 ARCH=x86_64 -j128 -C tools/testing/selftests
> > > TARGETS=hid &> out
> > >
> > > and here's the contents of `out` (still warnings/errors):
> > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59c6d
> > >
> > > I have a feeling I'm doing something fundamentally incorrectly. Any ideas?
> >
> > Sigh... there is a high chance my Makefile is not correct and uses the
> > installed headers (I was running the exact same commands, but on a
> > v6.4-rc7+ kernel).
> >
> > But sorry, it will have to wait for tomorrow if you want me to have a
> > look at it. It's 11:35 PM here, and I need to go to bed
> Take it easy. Thanks for the prompt responses here! I'd like to get
> the entire kselftest make target building with Clang so that we can
> close [1].
>
> >
> > Cheers,
> > Benjamin
> >
> > >
> > > To be clear, I can build the Kernel itself just fine across many
> > > configs and architectures. I have, at the very least, the dependencies
> > > required to accomplish that.
> > >
> > > >
> > > > FTR:
> > > > $> git checkout v6.5-rc7
> > > > $> make LLVM=1 ARCH=x86_64 mrproper headers
> > > > $> make LLVM=1 ARCH=x86_64 -j8 -C tools/testing/selftests TARGETS=hid
> > > >
> > > > ->   BINARY   hid_bpf
> > > >
> > > > Cheers,
> > > > Benjamin
> > > >
> > >
> >
>
> [1]: https://github.com/ClangBuiltLinux/linux/issues/1910

Erhm, I meant [1]: https://github.com/ClangBuiltLinux/linux/issues/1698
