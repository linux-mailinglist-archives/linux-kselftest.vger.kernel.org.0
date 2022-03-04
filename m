Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D04CD3B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 12:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiCDLoT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiCDLoT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 06:44:19 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679EBD7DC;
        Fri,  4 Mar 2022 03:43:31 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j5so6346988ila.2;
        Fri, 04 Mar 2022 03:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4smpWMe7kSNBH0mRyoIMNTCTp8csrNBkurRrsmlpIPo=;
        b=Ur9aq7eu3Eytryp1K22lJVyJFJLao0GT/R+/PN3J6sz5zlBiBu4s+f/HQFxo2H8Nm9
         GP3Ros3dd5himrsMXzLzfpEiM9v8ea7hJpqgd6jOifMxgyXR/cpGRJCCY/OBlFApGf3A
         RtfR0KBU/MgazXjpTwjeae0OQsTp3lUMJQgl27/xGVRRouUKBQxgb/Vfoe+BzyFyC3AK
         /TlzntsQrj8hu0bsunpO1u2Q1NzK5ZUJEvuWr2NLFoGtiy9jwes569YIRxx+ZRLOZzcY
         4Hxjl8pqBoOWxnLimr6+kOSjSGaQjskL7h1ahZxjTy+zFX1iNwqxmQHPz2XhtX7Gw/+/
         dgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4smpWMe7kSNBH0mRyoIMNTCTp8csrNBkurRrsmlpIPo=;
        b=d3gNyMon4o/rlr8uKdaqEnludvpoBPM+plU7kssEy+m9TNpKtAWluBXLCvLIf09en+
         rrK2PFVyu7egcHerT/OlLQUwyBcJ9P3Qx1tL/hJA21XMiUtHK6qZGqYLw2HuN20v96Pi
         X20XYktImwFG+DTMolZ+q6ZmREZ6MpTsFUvTEmwscVfo84Ljf1f3oo0AEWZpZPLDwg2Z
         oc7XLDEhWrI+Qt2Fu4Fi8txz1kKVyxe5/vRUBS0dSeGj/F/PHYZBa3dUZ+EJtnAWgwoG
         LFf4sB79YCl/vWXms/rB3fBaBJ0oAweXdG6ngynFrqtMJtej2UM4Y1icHfcPatPedpsv
         DIKA==
X-Gm-Message-State: AOAM533eSHEpHx90kdqXpcAPSgoOXQXwxKisBk9hD+Po+4yVzWgwfweQ
        SU6l0yqS4nSMNa/7HzmR7pGqi4vS1E7pcRyJizI=
X-Google-Smtp-Source: ABdhPJyBKRfl8PIOw+S6NEi0bCOL4PLN6OdToYMyK9eSpcrGOMTwep1WROvcrBL/LJenmf9yUE7+X4L3oo43anfTfUs=
X-Received: by 2002:a05:6e02:164f:b0:2c6:1b85:b985 with SMTP id
 v15-20020a056e02164f00b002c61b85b985mr955047ilu.4.1646394210485; Fri, 04 Mar
 2022 03:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20220303090643.241747-1-davidgow@google.com> <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
 <202203030947.E2FA3D9@keescook> <YiEISsoS/XrbEtbm@thelio-3990X> <CAKwvOdkA1c3U6+-6hB3Nj9m2Z8eYzsFWm5X4se2eq_cF3NB2jA@mail.gmail.com>
In-Reply-To: <CAKwvOdkA1c3U6+-6hB3Nj9m2Z8eYzsFWm5X4se2eq_cF3NB2jA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 4 Mar 2022 12:42:54 +0100
Message-ID: <CA+icZUXf9m13GrqvCLkDRsnQt0X2VQ=yVrJRYz=6fhCJXR4-Xg@mail.gmail.com>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 3, 2022 at 9:43 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Mar 3, 2022 at 10:26 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 10:04:28AM -0800, Kees Cook wrote:
> > > How does -mno-global-merge get KBUILD_CFLAGS in the first place? If it's
> > > arm/arm64 only, shouldn't that get relocated to those architectures?
> > >
> > > *time travel* found it:
> > >
> > > 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang")
> > >
> > > So I think this may have been universally true long ago, and now only
> > > arm/arm64 need it?
>
> Looks like that's the case from LLVM sources.
>
> <snip>
>
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index a2391b8de5a5..dcab28c44c26 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -48,6 +48,13 @@ CHECKFLAGS += -D__ARMEL__
> > >  KBUILD_LDFLAGS       += -EL
> > >  endif
> > >
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> > > +# source of a reference will be _MergedGlobals and not on of the whitelisted names.
>
> I think there's a typo in the original comment.
> s/on of/one of/ ?
>
> Also, I'm not sure what's meant by _MergedGlobals. Perhaps this is an
> opportunity to make this clearer?
>
> "Clang's "global-merge" pass (implemented only for arm and aarch64)
> may break modpost Pattern 2 if symbols are renamed and thus don't
> appear on modpost's allowlist.
>
> > > +# See modpost pattern 2
> > > +KBUILD_CFLAGS        += -mno-global-merge
> > > +endif
> > > +
>

I can remember on x86-64 I was able to build and boot by dropping it entirely.

- Sedat -

>
>
> --
> Thanks,
> ~Nick Desaulniers
