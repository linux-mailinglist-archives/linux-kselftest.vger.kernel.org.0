Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A259CA27
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiHVUiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 16:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiHVUiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 16:38:07 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772F558D0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:38:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11c5505dba2so14333721fac.13
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Lz/GpRupp9hLHPwiQc5j2fu4IqMpJfIKfxT/vi5xZAo=;
        b=HYBs3Q7D9lMDK/VeK0Uj8rnsrydYqny9N+LNnhJABOoeoXPZCRf/Ct2rhci5rbE3nR
         huR7JX+dv1NNljt8kIMLlxuXvn9RRwqGuPRFjdSaAuVBZbzpyrJ7DyokkBonquGWJdwC
         2UliRU29Z0ZryEdGfqtAyXgQrzFcAnKRhQq4ZcY0BI4Oji/6/z6pp7wWmrdEeton2xYT
         ZfYKcse8Emvtguc8OdgoQUklBA4wy0xP2Fw8FPPpwEYRg8h4CaDiO0lsL0XwBCYVWnca
         0lQvLK+8y6B27ncqIPbPJnmUKkzzazqjpjmT+JF4kT4hymynPVxw4lu4RuKBrcmw8Zc3
         K0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Lz/GpRupp9hLHPwiQc5j2fu4IqMpJfIKfxT/vi5xZAo=;
        b=VPFJFj1fAtCaImdVtzYcySKgDRMy+DsVvFD326ENfCDa3AXmvvLWWCnc0tr4doHS/6
         BcWd8p2nCSGLIoTyREYhs2TWdM2uUp5DIMJg02I0J9uzPQh7NdAEd5qqr+0tgrMF/CGh
         MCRPKaY1X73pADGVU35M3GXMq6fPVl2U990DwstY6tpUYG6JgoRVPGjG4mmT+djW6Bne
         OwaDQ6itR0g3vq7sOKOmLHvuonfu8RwIJe3ym/4XSonmFYxdeSNqNmgJffK9/ecuMCrK
         7FXUb9Nm/y9t65N2sf8JnL3TqLFIgy1Pn14BA84HHfiS11Hcybs2iox9MV6/i3Xq0MOl
         jikw==
X-Gm-Message-State: ACgBeo2u81DElVqQWHW+d8N3DjRDYWiD4LGBRFEcyscF/3vLwDUm8m3F
        LIGsSAgGHGl0LkZ22YqLO8sL/PoCtAKM2gSXfItS
X-Google-Smtp-Source: AA6agR6OnVitr++8/yJY7Lg01ef5rfEpjzO5STTtXn3xDaVoTJroKOybarW4WrZJXPfTE6Ta0RiEOl/+KUE4p8CqIJY=
X-Received: by 2002:a05:6870:f613:b0:10e:62b:1556 with SMTP id
 ek19-20020a056870f61300b0010e062b1556mr54616oab.51.1661200685205; Mon, 22 Aug
 2022 13:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com>
 <20220817164851.3574140-2-joefradley@google.com> <CABVgOSkFLNRDgo0=E9qxbi0rZziYEiPTpknEffFkzdv09wRk8A@mail.gmail.com>
In-Reply-To: <CABVgOSkFLNRDgo0=E9qxbi0rZziYEiPTpknEffFkzdv09wRk8A@mail.gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Mon, 22 Aug 2022 13:37:54 -0700
Message-ID: <CAF-60z3qm+a-POv-db8y8tsQn_qxxT_Jk+4_zHQ4xt2xd9ud8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: add kunit.enable to enable/disable KUnit test
To:     David Gow <davidgow@google.com>
Cc:     Nico Pache <npache@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 19, 2022 at 1:16 AM David Gow <davidgow@google.com> wrote:
>
> +Nico Pache in case this could be useful with kernel/kunit packaging.
>
> On Thu, Aug 18, 2022 at 12:49 AM 'Joe Fradley' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > This patch adds the kunit.enable module parameter that will need to be
> > set to true in addition to KUNIT being enabled for KUnit tests to run.
> > The default value is true giving backwards compatibility. However, for
> > the production+testing use case the new config option
> > KUNIT_ENABLE_DEFAULT_DISABLED can be enabled to default kunit.enable to
> > false requiring the tester to opt-in by passing kunit.enable=3D1 to
> > the kernel.
> >
> > Signed-off-by: Joe Fradley <joefradley@google.com>
> > ---
>
> Thanks for sending this out.
>
> I'm generally in support of the idea, and the implementation is okay,
> but there are a few small usability issues or bits of futureproofing
> we could do.
>
> On the first front, this doesn't integrate well with kunit_tool: if
> built-in tests are disabled, it will print the test header and test
> plan, but no results, which confuses the kunit_tool parser.

Thanks for pointing this out and reviewing this patch. I neglected
to test it with the wrapper script. I had only tested manually with
local VMs.

> In addition, maybe it'd be nice to have kunit_tool automatically pass
> kunit.enable=3D1 to any kernels it boots. Equally, a few minor
> naming/description suggestions.

Makes sense to me, I=E2=80=99ll add it. This would technically make the mis=
sing
TAP header and results a moot point. (But we can still safeguard that
scenario)

>
> More details in comments below.
>
> On the second topic, I think we need to work out exactly how we can
> evolve this to make it as useful as possible upstream going forward.
> In general, while there's nothing fundamentally wrong with having
> tests disabled at runtime, it is going to be a very niche feature, as
> for most users the correct solution here is to build a new kernel,
> without KUnit.
>
> My feeling is that the real distinction worth making here is that
> tests can be compiled in and loaded (e.g., if tests are embedded in a
> non-test module, like apparmor, or thunderbolt, or (soon) amdgpu), but
> won't execute automatically. Now, at the moment there's no way to
> manually trigger a test. so this distinction isn't yet important, but
> we may want to add something down the line, such as the ability to
> trigger a test via debugfs (this was proposed as part of the original
> debugfs support packages), or the ability to change the value of this
> 'enable' flag at runtime, and then load a specific test.
>
> Maybe that involves some further changes to the implementation (at its
> most extreme, it could involve moving the checks out into the module
> loader and the kernel_init_freeable() function, though I don't think
> that's _necessary_), but for the most part, it probably just involves
> describing and documenting this change as such.
>
> Would something like that still serve Android's purposes? Or is it
> critically important that the idea behind this is "if this is set to
> false, there should be no way of running KUnit tests", and having a
> manual way to trigger them down the line would defeat the point?
>

As of right now, we wouldn=E2=80=99t want someone to enable KUnit after boo=
t.
However, because we lock out debugfs for these instances maybe that
would be an acceptable path to enable it after boot.

I=E2=80=99m wondering why these =E2=80=98mixed=E2=80=99 modules would need =
that. Is it that
those tests shouldn=E2=80=99t/can=E2=80=99t run at startup?


> Cheers,
> -- David
>
> >  .../admin-guide/kernel-parameters.txt         |  6 ++++++
> >  lib/kunit/Kconfig                             |  8 ++++++++
> >  lib/kunit/test.c                              | 20 +++++++++++++++++++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index d7f30902fda0..ab4c7d133c38 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2436,6 +2436,12 @@
> >                         0: force disabled
> >                         1: force enabled
> >
> > +       kunit.enable=3D   [KUNIT] Enable executing KUnit tests. Require=
s
> > +                       CONFIG_KUNIT to be set to be fully enabled. The
> > +                       default value can be overridden to disabled via
> > +                       KUNIT_ENABLE_DEFAULT_DISABLED.
> > +                       Default is 1 (enabled)
> > +
> >         kvm.ignore_msrs=3D[KVM] Ignore guest accesses to unhandled MSRs=
.
> >                         Default is 0 (don't ignore, but inject #GP)
> >
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 0b5dfb001bac..5d6db58dbe9b 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -59,4 +59,12 @@ config KUNIT_ALL_TESTS
> >
> >           If unsure, say N.
> >
> > +config KUNIT_ENABLE_DEFAULT_DISABLED
> > +       bool "Require boot parameter to enable KUnit test execution"
> > +       help
> > +         Sets the default value of the kernel parameter kunit.enable t=
o 0
> > +         (disabled). This means to fully enable kunit, config KUNIT ne=
eds
> > +         to be enabled along with `kunit.enable=3D1` passed to the ker=
nel. This
> > +         allows KUnit to be opt-in at boot time.
> > +
>
> Hmm... would it make more sense to have this be DEFAULT_ENABLED and
> have the default value of the config option be y instead?
> Personally, I think that'd avoid the double-negative, and so might be cle=
arer.

That would definitely be more clear. We just want to make sure it's backwar=
ds
compatible, which it should be if we default it in the config to y.

>
> >  endif # KUNIT
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index b73d5bb5c473..e6f98e16e8ae 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int=
 line, const char *fmt, ...)
> >  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> >  #endif
> >
> > +/*
> > + * Enable KUnit tests to run.
> > + */
> > +#ifdef CONFIG_KUNIT_ENABLE_DEFAULT_DISABLED
> > +static bool enable_param;
> > +#else
> > +static bool enable_param =3D true;
> > +#endif
> > +module_param_named(enable, enable_param, bool, 0);
> > +MODULE_PARM_DESC(enable, "Enable KUnit tests to run");
>
> Maybe "Enable KUnit tests" is simpler than adding "to run", which
> reads a bit awkwardly.
>
> If we were to treat this variable as specifically enabling the "run
> tests on boot" and/or "module load", then that could be worked into
> the description, too.

Going the =E2=80=9CEnable KUnit tests=E2=80=9D route is definitely less awk=
ward, thanks.

>
> > +
> >  /*
> >   * KUnit statistic mode:
> >   * 0 - disabled
> > @@ -590,6 +601,12 @@ int __kunit_test_suites_init(struct kunit_suite * =
const * const suites, int num_
> >  {
> >         unsigned int i;
> >
> > +       if (!enable_param && num_suites > 0) {
> > +               pr_info("kunit: deactivated, cannot load %s\n",
> > +                       suites !=3D NULL && suites[0] !=3D NULL ? suite=
s[0]->name : "NULL");
> > +               return -EPERM;
> > +       }
> > +
>
> This mostly works, but has a few small issues:
> - KUnit will still print the header and a test plan, so kunit_tool
> will report a large number of "crashed" tests when no results are
> forthcoming.
>   It should be posible to add a similar check in kunit_run_all_tests()
> to handle that case:
> https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c#L246
>   You can test this with:
> ./tools/testing/kunit/kunit.py run --kconfig_add
> CONFIG_KUNIT_ENABLE_DEFAULT_DISABLED=3Dy

Thank you, I can easily repro that output now and adding a check in
`kunit_run_all_tests()` as you suggested cleans it up. However, it
still shows an error if the TAP header is missing and if I add the
header, it errors on having 0 tests. But maybe either of these are
OK, as it conveys no tests have run even though you're running
the `knuit_tool` assumably expecting test output. But we're not
falsely stating particular tests have crashed.

Also, now that we=E2=80=99re going to be passing in kunit.enable=3D1 it wil=
l be
very difficult, if not impossible, to get in this situation.

>
> - The message is not ideal: it only refers to the first suite in the
> module (or built into the kernel). and "cannot load" is not really
> applicable to built-in tests.

If I move this check up one call into `kunit_modue_init` I could use
the module name. (There won't be a built-in path through here any
more after the `kunit_run_all_tests() addition.) However,
`__kunit_test_suites_init()` is exported so theoretically someone else
could call it bypassing the check. So, I think I'll leave it where it's at
now and simplify the message to something like:
"kunit: disabled, not executing tests\n"

>   Maybe the goal should be less to "not load test modules" but more to
> "allow test modules to load, but don't run the tests in them".
>   Thoughts?

Originally the feeling was, if we aren't going to run the tests, why
load the test modules? However, with the =E2=80=9Cmixed=E2=80=9D modules yo=
u
mentioned in mind we would want to load them just not run the tests.

>
> - If we were to treat this as "tests load, but don't run
> automatically", then we probably don't want this to be an EPERM...

Agreed.

>
> >         for (i =3D 0; i < num_suites; i++) {
> >                 kunit_init_suite(suites[i]);
> >                 kunit_run_tests(suites[i]);
> > @@ -607,6 +624,9 @@ void __kunit_test_suites_exit(struct kunit_suite **=
suites, int num_suites)
> >  {
> >         unsigned int i;
> >
> > +       if (!enable_param)
> > +               return;
> > +
> >         for (i =3D 0; i < num_suites; i++)
> >                 kunit_exit_suite(suites[i]);
> >
> > --
> > 2.37.1.595.g718a3a8f04-goog
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kunit-dev/20220817164851.3574140-2-joefradley%40google.com.
