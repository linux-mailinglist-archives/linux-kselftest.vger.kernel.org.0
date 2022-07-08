Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739DD56B213
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiGHEyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 00:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiGHEyl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 00:54:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47A76E96
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jul 2022 21:54:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b26so28982345wrc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jul 2022 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sz8usM5OOAxMSGMRGNk8MoEaRmhzBeAasBjyztwmQ0o=;
        b=XvQr0qdgMR+nOcAcTf+7xs8BktG18BYs/gyLp5C5uUsjKtaGS7EF9lRf5zMCPTk5BJ
         91x/Spo8Cfl4CVSPbPoMfLrZsEwhY0cNHM2q7EZ0nlSFf2pbkNNGBgFJwDr4PWfiQA1R
         rjSqjpl0EY3iSCJAU48gfTIUWBgXCZlfQnTkkQe5IaGiy4iNSAVkSmARbuu5920d6StE
         Mu+9ay0uGrpKJNlbX9QXXUknZR2EeKcCJs4NUI/9GG+xW0j5zMKpqA9wT3lgzcNdk1P3
         +DDWrQu8tOvaOqcdVi11eMbXfr8ZoiUe4Ta28ix+r6raRL7MH0DfN1S0WQseo23ZyBuK
         IaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sz8usM5OOAxMSGMRGNk8MoEaRmhzBeAasBjyztwmQ0o=;
        b=p1hcpliURPrtW7ihOHxfHJi+RYGbF4wpvtc4KAB5alg6LoIwGyqa6oXNvN3FKrNmzA
         0mCVLtTFMU5yf52gd7541lVsPytGTDZk69Mhoj+OC9OUYQjdr9PsFdk79pBFi4Nq7lsd
         wjdrxO6RgMvhALQF4hLPqBX/aGs9jeWHZn+VxKxzPUzeukx2AskEn+gcb7Mzssp8QGpb
         dJvfOwb01H2HK5R2FrWHQltKwP9pe8q1E3YhPemTb3dcEXf4NPww5cYGWzL8LfSre2Pa
         +05GFEjkSaM0fi8Bqc9qeXfGVkoGGXh0JnnXc+4gIkd45vS2JYBbZD/w0FF/BHxXUSmI
         tmsg==
X-Gm-Message-State: AJIora9FJ1fvdm+7FmSX2k/8ubisWRhH4B2m29fdEHIzSPD68N/Q8xrN
        7REtAhlhoG22aA/njunJgRl7VwbK/+Jmb8udbpNrlg==
X-Google-Smtp-Source: AGRyM1tIeGQJ+ivPnEvcRAtn4O4y3vU//xrt6CdwdEW1jsM9325goPmktj2iKPfJEmyAwwTZyTpi7ATaQ047jGlt+PQ=
X-Received: by 2002:adf:e804:0:b0:21d:6e85:7550 with SMTP id
 o4-20020adfe804000000b0021d6e857550mr1349414wrm.337.1657256077460; Thu, 07
 Jul 2022 21:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com> <20220702040959.3232874-2-davidgow@google.com>
 <Ysd9FG1fOSnzKv8d@dev-arch.thelio-3990X>
In-Reply-To: <Ysd9FG1fOSnzKv8d@dev-arch.thelio-3990X>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Jul 2022 12:54:26 +0800
Message-ID: <CABVgOS=-B3HDxS-6N2Yn897C7giPtBe3jxLomY_Om15Kee5UYw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] module: panic: Taint the kernel when selftest
 modules load
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 8, 2022 at 8:40 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Jul 02, 2022 at 12:09:57PM +0800, David Gow wrote:
> > Taint the kernel with TAINT_TEST whenever a test module loads, by adding
> > a new "TEST" module property, and setting it for all modules in the
> > tools/testing directory. This property can also be set manually, for
> > tests which live outside the tools/testing directory with:
> > MODULE_INFO(test, "Y");
> >
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  kernel/module/main.c  | 7 +++++++
> >  scripts/mod/modpost.c | 3 +++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index fed58d30725d..730503561eb0 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1988,6 +1988,13 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
> >       /* Set up license info based on the info section */
> >       set_license(mod, get_modinfo(info, "license"));
> >
> > +     if (!get_modinfo(info, "test")) {
> > +             if (!test_taint(TAINT_TEST))
> > +                     pr_warn_once("%s: loading test module taints kernel.\n",
> > +                                  mod->name);
> > +             add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 29d5a841e215..5937212b4433 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
> >
> >       if (strstarts(mod->name, "drivers/staging"))
> >               buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
> > +
> > +     if (strstarts(mod->name, "tools/testing"))
> > +             buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
> >  }
> >
> >  static void add_exported_symbols(struct buffer *buf, struct module *mod)
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
> >
>
> Hi David,
>
> This change has landed in linux-next as commit e20729ede7ed ("module:
> panic: taint the kernel when selftest modules load") and on all of my
> test machines, I see this new message printed, even though as far as I
> am aware, I am not loading any testing modules. For example, in QEMU, I
> see:
>
> [    0.596978] serio: loading test module taints kernel.
>
> and on my Honeycomb LX2, I see:
>
> [    5.400861] fuse: loading test module taints kernel.
>
> It seems like the get_modinfo() check might be wrong? The following diff
> resolves it for me, I can send a formal patch if necessary (although it
> appears to have gone in via -mm so I assume Andrew can squash this in).
>

Whoops: this is definitely the wrong way round. Thanks very much for
catching it! (I'd swapped it locally at some point to test, and
must've accidentally committed it.)

I've sent out v6 with this fixed (and a couple of other minor changes):
https://lore.kernel.org/linux-kselftest/20220708044847.531566-2-davidgow@google.com/T/#u

That being said, if just squashing your change below in is easier, I'm
fine with that, too. (The other changes are minor enough that we could
live without them and/or send them in separately.)

Unless there are any objections, should Andrew update this patch in
his tree, and we remove the series from the kunit tree?

Cheers,
-- David

>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 730503561eb0..4f91e41b8bc9 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1988,7 +1988,7 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
>         /* Set up license info based on the info section */
>         set_license(mod, get_modinfo(info, "license"));
>
> -       if (!get_modinfo(info, "test")) {
> +       if (get_modinfo(info, "test")) {
>                 if (!test_taint(TAINT_TEST))
>                         pr_warn_once("%s: loading test module taints kernel.\n",
>                                      mod->name);
