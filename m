Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199E44CC556
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 19:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiCCSlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 13:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiCCSlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 13:41:00 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6E3204E
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 10:40:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p20so8036535ljo.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9eIeQ0ho5+PgyAKnaaB11UpUGBa3mppG5jHpvKWnBA=;
        b=BjH5X6Yj0lRLeYOc8+oSpAblIl1dkXNqVGcH9rXpzrumLG854C8lBpc1Hf32dy9X7S
         qN144M6BlKdb/TeKDx4m4KlRfbXCKSuIqZSqDAKIaMsp/mNK0QGzcF0nI54JGHx/GDIf
         JiaQLSrtU95mf2sbhwjFSoKjW96x+Y/thc44fNJ1JCLIcNzbIhDJPp339LrPgRBP548x
         Lqw1WlROjRYD6A8BHvM+qqmOmYuhm94stV8lJbFSYie+bs4si8ZjxZPjzxUSVl2KkMlH
         E45QFbuyDCz8Jrn4GPhNWcrNdFjXLzSLHep6Zk6vW/eISe6AvtEYi0RsmuJydwV0rYk7
         zKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9eIeQ0ho5+PgyAKnaaB11UpUGBa3mppG5jHpvKWnBA=;
        b=BEsLYCgCM0ldqGCzkz99O/OdH8JmAw+aIMTmaK6xKmdqWw1D8UPoVtb1EEag3Gu9g8
         yiEzCHO3AUrVR5RsPtB+oVBMnclZKs2Rm7hu8IoJbiIG9hFKEqTH37vxIWL62JMv8wrK
         b74PnmKXwRN1oDs1j/iYOofUnWh0vqntRcwqyyNIxZjH3t63vz0SfToJ7PmVSrpJFvb2
         kegszdQYOlTVakyCOle3Vu8zicSrR9/xD7p5YOw/777XAhw82dCx6mGpXJDSkAeNrHox
         PM1zWVebtmg6jXA5pFJQLPr3kyTjjvWby4KZGGB6AOpr68+4bMmUJijzWfQKEfkIY8p/
         E5bA==
X-Gm-Message-State: AOAM530iYUnaujXePuGPoMRE4BMvxxT+es5jjtq3iNM6+baxJTRQVogE
        SVUTXMZwHA5ak2U5PE1ChRY+z+6o5pM2ORpB/tlKmQ==
X-Google-Smtp-Source: ABdhPJwyjNAAm+EL9aaDfd+4HLNYZJcB+u5Y2JbOp3rzBkroi7cpVqLVVllTAVIMTyL9bcg2tNAPemU2mRq88VzGMek=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr17157636ljr.472.1646332810871; Thu, 03
 Mar 2022 10:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20220303090643.241747-1-davidgow@google.com> <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
 <202203030947.E2FA3D9@keescook> <YiEISsoS/XrbEtbm@thelio-3990X>
In-Reply-To: <YiEISsoS/XrbEtbm@thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Mar 2022 10:39:58 -0800
Message-ID: <CAKwvOdkA1c3U6+-6hB3Nj9m2Z8eYzsFWm5X4se2eq_cF3NB2jA@mail.gmail.com>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 3, 2022 at 10:26 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 10:04:28AM -0800, Kees Cook wrote:
> > How does -mno-global-merge get KBUILD_CFLAGS in the first place? If it's
> > arm/arm64 only, shouldn't that get relocated to those architectures?
> >
> > *time travel* found it:
> >
> > 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang")
> >
> > So I think this may have been universally true long ago, and now only
> > arm/arm64 need it?

Looks like that's the case from LLVM sources.

<snip>

> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index a2391b8de5a5..dcab28c44c26 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -48,6 +48,13 @@ CHECKFLAGS += -D__ARMEL__
> >  KBUILD_LDFLAGS       += -EL
> >  endif
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> > +# source of a reference will be _MergedGlobals and not on of the whitelisted names.

I think there's a typo in the original comment.
s/on of/one of/ ?

Also, I'm not sure what's meant by _MergedGlobals. Perhaps this is an
opportunity to make this clearer?

"Clang's "global-merge" pass (implemented only for arm and aarch64)
may break modpost Pattern 2 if symbols are renamed and thus don't
appear on modpost's allowlist.

> > +# See modpost pattern 2
> > +KBUILD_CFLAGS        += -mno-global-merge
> > +endif
> > +



-- 
Thanks,
~Nick Desaulniers
