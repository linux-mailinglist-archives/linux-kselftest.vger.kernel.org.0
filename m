Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E759FCF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiHXON5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiHXON4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 10:13:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172298360
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 07:13:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so11876905oti.9
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NqT0CqG5IRpN9kntDLlkZGK+Mpp/ZgreQmsBIBUO/BE=;
        b=NKk68KbUJ+5sG6x/hnEZPobpVgtP+rHXieux2O5XXlfxtK9vhxz6sbDPf4NDMP3nwT
         kACNB6SCthoVR2nLQBBSnr7rGCJhVk70cXXTX/cCuyBNGqVqEAiU5t/m/3Xk8V4F/JH/
         64v5Yk89h4ISXJgR9ANCHS+jz1VAX9Mkdkod9+OnH83i8hLTa+0Mu4+6+CwMdRUcDCEx
         sNd8FnBQlUGRNtlBrTWTPT5z8FDediLfFAR0JBC/C2mdShwAH3Wye3W1eyjDv6/+D5qb
         We6VCoLaySUXj/4tEFj0ES/fRmVodT7R9BBxptNZdREomzI0iLc5+dmi5ubH/5SIQIlm
         ue0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NqT0CqG5IRpN9kntDLlkZGK+Mpp/ZgreQmsBIBUO/BE=;
        b=Rr4pJ6T63o6q13ktm/UNIcBy34DOMyFH7UWAWPRJsk/zFEQdhSQZp7LPqpdxoDLFJD
         wjkmSoFcm4GjtCTx6wMjyJzX6pgEpOq4MhFcvChlkHnMWUFIVJIGyfnUWwxwXOAY4Quh
         gGPen3hnGeCOlOC8Iv/r92PE77YORaEbh5vF43BH7ZQ93KHfjKDKsHuPJzUfP4EKf2iB
         i3B7jEWTvIDYIeq3M+6JVhX5AMB5hc36skfNUocVJ9QObHuLfGzZa2fnNs4pddY1v0Z2
         r5EKDOxutIRbXC5Q1y4OgDGFe7gt/cv33Z9ZZBmeRUq9yx1oUln0zZspC1wbGnk4UUwM
         5A4w==
X-Gm-Message-State: ACgBeo1ztKYkXHrYrpy2z7o07JzHS5wnM7iXcGPfU7ucjiuoHiKyUNJR
        cW7jk4Cc1mjF35LgsTJ47MAig7bv5f8EVnlt3DcI
X-Google-Smtp-Source: AA6agR4dkt0mNqbSbClQ+VhCF/JvuFXQCyMwhDT9aNLpFc4XPXA80vjQdKD3qzi1YjjlOp8qRiTUBwtlt6+QN06HGxM=
X-Received: by 2002:a05:6830:60c:b0:637:2636:eaf2 with SMTP id
 w12-20020a056830060c00b006372636eaf2mr11078335oti.358.1661350433665; Wed, 24
 Aug 2022 07:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
 <20220823142456.3977086-2-joefradley@google.com> <CABVgOS=E44fQ5UY5b3np5ZSrkDeXkkEAPBBA5yDd3bE72gotww@mail.gmail.com>
 <CAF-60z1H77S-pVevKyZ7DQ9e09h4=Gnhbv9RA_SWTk=kmsq18g@mail.gmail.com> <CABVgOS=_pYqA6yEc5C4o+JpxSghVsWZV_rZ2TXHrgwjkvou28g@mail.gmail.com>
In-Reply-To: <CABVgOS=_pYqA6yEc5C4o+JpxSghVsWZV_rZ2TXHrgwjkvou28g@mail.gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Wed, 24 Aug 2022 07:13:42 -0700
Message-ID: <CAF-60z1xq3cMBO5xwRtFsm2upDT=je1H_QQG+AF4yKGZ30SjPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add kunit.enable to enable/disable KUnit test
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Aug 23, 2022 at 11:33 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Aug 24, 2022 at 1:04 PM Joe Fradley <joefradley@google.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 9:31 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Tue, Aug 23, 2022 at 10:25 PM 'Joe Fradley' via KUnit Development
> > > <kunit-dev@googlegroups.com> wrote:
> > > >
> > > > This patch adds the kunit.enable module parameter that will need to be
> > > > set to true in addition to KUNIT being enabled for KUnit tests to run.
> > > > The default value is true giving backwards compatibility. However, for
> > > > the production+testing use case the new config option
> > > > KUNIT_DEFAULT_ENABLED can be set to N requiring the tester to opt-in
> > > > by passing kunit.enable=1 to the kernel.
> > > >
> > > > Signed-off-by: Joe Fradley <joefradley@google.com>
> > > > ---
> > >
> > > Thanks very much. This looks good to me, and works on my machine.
> > >
> > > I've put a few comments/ideas below, but none of them feel necessary to me.
> >
> > Thank you for the review. I need to do one follow up revision to base this
> > off of the appropriate `linux-kselftest/kunit` branch.
> >
>
> This already applies cleanly to linux-kselftest/kunit -- it should be
> fine as-is.

Ok great, I'll leave as-is.


>
> (It also applies fine to kselftest/kunit-fixes, for what it's worth.)
>
> Cheers,
> -- David
>
> > >
> > > Regardless, this is
> > > Reviewed-by: David Gow <davidgow@google.com>
> > >
> > > Cheers,
> > > -- David
> > >
> > > > Changes since v1:
> > > > - Created a function to get kunit enable state
> > > > - Check kunit enable state in kunit_run_all_tests() in executor.c
> > > > - Load test module even if KUnit is disabled but still don't execute
> > > >   tests
> > > > - Simplified kunit disable message and kunit.enable parameter
> > > >   description
> > > > - Flipped around logic of new config to be KUNIT_DEFAULT_ENABLED
> > > > - kunit_tool.py now passes kunit.enable=1 to kernel
> > > >
> > > >  .../admin-guide/kernel-parameters.txt         |  6 +++++
> > > >  include/kunit/test.h                          |  2 ++
> > > >  lib/kunit/Kconfig                             | 11 +++++++++
> > > >  lib/kunit/executor.c                          |  4 ++++
> > > >  lib/kunit/test.c                              | 24 +++++++++++++++++++
> > > >  tools/testing/kunit/kunit_kernel.py           |  1 +
> > > >  6 files changed, 48 insertions(+)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index adfda56b2691..7aa3abd7f1c5 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -2432,6 +2432,12 @@
> > > >                         0: force disabled
> > > >                         1: force enabled
> > > >
> > > > +       kunit.enable=   [KUNIT] Enable executing KUnit tests. Requires
> > > > +                       CONFIG_KUNIT to be set to be fully enabled. The
> > > > +                       default value can be overridden via
> > > > +                       KUNIT_DEFAULT_ENABLED.
> > > > +                       Default is 1 (enabled)
> > > > +
> > > >         kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
> > > >                         Default is 0 (don't ignore, but inject #GP)
> > > >
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index c958855681cc..ee6bf4ecbd89 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -228,6 +228,8 @@ static inline void kunit_set_failure(struct kunit *test)
> > > >         WRITE_ONCE(test->status, KUNIT_FAILURE);
> > > >  }
> > > >
> > > > +bool kunit_enabled(void);
> > > > +
> > >
> > > This probably isn't strictly necessary at this stage, given that it
> > > just checks one variable. That being said, I don't think it hurts (and
> > > personally, I quite like it), and find it more future-proof than
> > > exposing the variable more widely anyway.
> >
> > It also addressed it being a static variable.
> >
> > >
> > > >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > > >
> > > >  int kunit_run_tests(struct kunit_suite *suite);
> > > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > > index 0b5dfb001bac..626719b95bad 100644
> > > > --- a/lib/kunit/Kconfig
> > > > +++ b/lib/kunit/Kconfig
> > > > @@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
> > > >
> > > >           If unsure, say N.
> > > >
> > > > +config KUNIT_DEFAULT_ENABLED
> > > > +       bool "Default value of kunit.enable"
> > > > +       default y
> > > > +       help
> > > > +         Sets the default value of kunit.enable. If set to N then KUnit
> > > > +         tests will not execute unless kunit.enable=1 is passed to the
> > > > +         kernel command line.
> > > > +
> > > > +         In most cases this should be left as Y. Only if additional opt-in
> > > > +         behavior is needed should this be set to N.
> > > > +
> > > >  endif # KUNIT
> > > > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > > > index 5e223327196a..9bbc422c284b 100644
> > > > --- a/lib/kunit/executor.c
> > > > +++ b/lib/kunit/executor.c
> > > > @@ -190,6 +190,10 @@ int kunit_run_all_tests(void)
> > > >  {
> > > >         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
> > > >         int err = 0;
> > > > +       if (!kunit_enabled()) {
> > > > +               pr_info("kunit: disabled\n");
> > > > +               goto out;
> > > > +       }
> > > >
> > > >         if (filter_glob_param) {
> > > >                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index b73d5bb5c473..1e54373309a4 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> > > >  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> > > >  #endif
> > > >
> > > > +/*
> > > > + * Enable KUnit tests to run.
> > > > + */
> > > > +#ifdef CONFIG_KUNIT_DEFAULT_ENABLED
> > > > +static bool enable_param = true;
> > > > +#else
> > > > +static bool enable_param;
> > > > +#endif
> > > > +module_param_named(enable, enable_param, bool, 0);
> > > > +MODULE_PARM_DESC(enable, "Enable KUnit tests");
> > > > +
> > > >  /*
> > > >   * KUnit statistic mode:
> > > >   * 0 - disabled
> > > > @@ -586,10 +597,20 @@ static void kunit_init_suite(struct kunit_suite *suite)
> > > >         suite->suite_init_err = 0;
> > > >  }
> > > >
> > > > +bool kunit_enabled(void)
> > > > +{
> > > > +       return enable_param;
> > > > +}
> > > > +
> > > >  int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
> > > >  {
> > > >         unsigned int i;
> > > >
> > > > +       if (!kunit_enabled() && num_suites > 0) {
> > > > +               pr_info("kunit: disabled\n");
> > >
> > > _Maybe_ this could be pr_info_once(), if you were worried about spam
> > > (if a whole bunch of test modules were loaded at once). That being
> > > said, I prefer it as-is, as I don't think there are a lot of cases
> > > where large number of kunit test modules are loaded on a system with
> > > KUnit disable. And I'm liable to forget that KUnit is disabled if a
> > > system has been running for a while (and maybe one test module was
> > > loaded a boot), and end up wondering why my test isn't running.
> >
> > That's the same conclusion I came to after considering the one time
> > message used for the test taint message.
> >
> > >
> > > So, I'm all for leaving this as-is, personally.
> > >
> > > > +               return 0;
> > > > +       }
> > > > +
> > > >         for (i = 0; i < num_suites; i++) {
> > > >                 kunit_init_suite(suites[i]);
> > > >                 kunit_run_tests(suites[i]);
> > > > @@ -607,6 +628,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
> > > >  {
> > > >         unsigned int i;
> > > >
> > > > +       if (!kunit_enabled())
> > > > +               return;
> > > > +
> > > >         for (i = 0; i < num_suites; i++)
> > > >                 kunit_exit_suite(suites[i]);
> > > >
> > > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > > index f5c26ea89714..ef794da420d7 100644
> > > > --- a/tools/testing/kunit/kunit_kernel.py
> > > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > > @@ -359,6 +359,7 @@ class LinuxSourceTree:
> > > >                         args = []
> > > >                 if filter_glob:
> > > >                         args.append('kunit.filter_glob='+filter_glob)
> > > > +               args.append('kunit.enable=1')
> > > >
> > > >                 process = self._ops.start(args, build_dir)
> > > >                 assert process.stdout is not None  # tell mypy it's set
> > > > --
> > > > 2.37.1.595.g718a3a8f04-goog
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220823142456.3977086-2-joefradley%40google.com.
