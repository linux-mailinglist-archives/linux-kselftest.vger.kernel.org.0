Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC24CDD05
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiCDS5a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 13:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiCDS5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 13:57:30 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D239F1D6F54;
        Fri,  4 Mar 2022 10:56:41 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 224IuJHs020122;
        Sat, 5 Mar 2022 03:56:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 224IuJHs020122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646420179;
        bh=ae5Yd4J05pJERqgIww/ekBg7J6J/HW2Ax8vCdSSmy7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WKMGWPQS0Angn6t12jeTQy1uq7SLzAJU1sXmgpzQtIHXctTlvx1O0lx3cm1Mn/83A
         f4BNL0rhAMmm3jEPmI9iYkzOGjqwz0Hw8hAZfrdcUZTTOBv1zl35I0a1QhcjaR1kXg
         PVNwELdrqMn/QhbIfySunaXJa4W7oHu1fSQ4QdmOYGKONCQzltHfAxL916AOH7qMBD
         OXSwajo5M5YSX9KY9yONKMtmjySyfsD8mRYrZc0d/CdanYqsmXfRA9sgZ/ZNDwTPa/
         24dEYq9D/tTuJ90JcGf92jiA8byZ6erLknY4PA27638/IAImOhPOSLQl2lZM5bvNyr
         Js+MOIERcMr6g==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so8748642pjl.4;
        Fri, 04 Mar 2022 10:56:19 -0800 (PST)
X-Gm-Message-State: AOAM533e4EUJWcFmMOPyXUohtVpK3SWdGNf8NFgsB/24D2cbt4fqMdzt
        QsmQGn5Zz/BwGCNmBhAH+BqBDW5TxlTqexyANiQ=
X-Google-Smtp-Source: ABdhPJwRRAwCRJWCopAh560BqX5nnMFeJX4fJRkUamLZIOmZSLvfoVWOOqJxRKhig5RNtnEWMDnmuKsSg5SnHO/by8w=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr43172969plr.136.1646420178457; Fri, 04
 Mar 2022 10:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20220304170813.1689186-1-nathan@kernel.org> <202203041005.A3B985C@keescook>
 <YiJXUL3zIik+4QDv@thelio-3990X>
In-Reply-To: <YiJXUL3zIik+4QDv@thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 5 Mar 2022 03:55:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+4t_c=SLJqVWYVMaQ8C1uqWCeOFJ6eNczT1TUgEG_Cg@mail.gmail.com>
Message-ID: <CAK7LNAT+4t_c=SLJqVWYVMaQ8C1uqWCeOFJ6eNczT1TUgEG_Cg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Make $(LLVM) more flexible
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 5, 2022 at 3:15 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Mar 04, 2022 at 10:09:03AM -0800, Kees Cook wrote:
> > On Fri, Mar 04, 2022 at 10:08:14AM -0700, Nathan Chancellor wrote:
> > > [...]
> > >
> > > Update and reorder the documentation to reflect these new additions.
> > > At the same time, notate that LLVM=0 is not the same as just omitting it
> > > altogether, which has confused people in the past.
> >
> > Is it worth making LLVM=0 actually act the way it's expected to?
>
> I don't really see the point, omitting $(LLVM) altogether is simpler.
> Why specify LLVM=0 if you want GNU tools, since it is the default?
> However, I can look into changing that in a new revision or a follow up
> if others disagree?


Changing the meaning of LLVM=0 is beyond the scope of what
we are trying to achieve now.

I think documenting it is enough.

(If we have a good reason to change it, we can. But, it should be
done in a separate patch, at least)






-- 
Best Regards
Masahiro Yamada
