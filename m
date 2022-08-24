Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8971659F2EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiHXFE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiHXFE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 01:04:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310F297
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 22:04:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso11157785otv.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FEu1GvIpeCpM8hJ8un7HNlhm5XQJuSVqg9LiyNborLs=;
        b=eM9jY9n/nAsi6JcWq17o/mhwmHIba6ufZg3x6fJd37FgjJhHnMxO7ByjDyLZ1jT1r/
         YSbKHrZKfLnoPOM4FymS/XBQQ8QDaz7lQCKnGWANZ6BRexLJj3g+MmfiQHyTeSgaRpqO
         dm9AjQ46xLAaLBpajFl6iYt9SFgBF2qkb67XuR6zZc82gkmATVGFFGoXGRhzm7sEMtC8
         h1wSBgHXT6FsloM7pgjpY5AEzn+CzqcJ5rDh5hKi5t7fPJlopE7PEInYorr1MVYv1hLH
         Kqtu+1Wdte5R+6FJyKoc8LwShvjlpwTLr4GQNAuYEpA0fuAn6OtPN+WejAOBKEYSsiPg
         BqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FEu1GvIpeCpM8hJ8un7HNlhm5XQJuSVqg9LiyNborLs=;
        b=0BKM7Yj/5FLUyTq2MxEjRci2gXLXN99dv6gaheWuGIKt6ZTAR42XJKc2DW2obPd0K7
         cAZSnp5mj2/7FSQW6wxNbWiBJXhrEKSNKrBRz3rMFOEM2c4otXLy3yhR7R5ESgS7vjxn
         oqxPoUMeMJA9rrnIhJQjIKTakEcA72w4/UblYALZknsf19AN5m+9RtvxUGH6/QfNOry2
         q3LD79mH968hMKiaV7qu6/buOgO4ugwdvJ0ob0a+MHFnbxKFRMu1jh9l0oZPniNe9yoF
         has7gO7E3kez6xpidG2a5jkIEDyvhlT9kQTwq4O5uxcpTkuupQdKSXqyDKq4J6MszA6g
         xmmg==
X-Gm-Message-State: ACgBeo3qxO0Omju9o00uA3emtd8PeUW2olOppZMjuFPf4d8A1Y8KAm4g
        YQC2EdBFIDXj1wKV/F+7ZsWw/2MhwJu6fIYIsc2W
X-Google-Smtp-Source: AA6agR4zkt3484xjhGMOG71v+tGSLBvBNl8auVoFfkuI3hAwdWGQO+tr5dWAgxtix0nbpYmK+zZqZir8MTinFp1Sn/M=
X-Received: by 2002:a05:6830:60c:b0:637:2636:eaf2 with SMTP id
 w12-20020a056830060c00b006372636eaf2mr10453757oti.358.1661317492400; Tue, 23
 Aug 2022 22:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
 <20220823142456.3977086-2-joefradley@google.com> <CABVgOS=E44fQ5UY5b3np5ZSrkDeXkkEAPBBA5yDd3bE72gotww@mail.gmail.com>
In-Reply-To: <CABVgOS=E44fQ5UY5b3np5ZSrkDeXkkEAPBBA5yDd3bE72gotww@mail.gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Tue, 23 Aug 2022 22:04:41 -0700
Message-ID: <CAF-60z1H77S-pVevKyZ7DQ9e09h4=Gnhbv9RA_SWTk=kmsq18g@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 9:31 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Aug 23, 2022 at 10:25 PM 'Joe Fradley' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > This patch adds the kunit.enable module parameter that will need to be
> > set to true in addition to KUNIT being enabled for KUnit tests to run.
> > The default value is true giving backwards compatibility. However, for
> > the production+testing use case the new config option
> > KUNIT_DEFAULT_ENABLED can be set to N requiring the tester to opt-in
> > by passing kunit.enable=1 to the kernel.
> >
> > Signed-off-by: Joe Fradley <joefradley@google.com>
> > ---
>
> Thanks very much. This looks good to me, and works on my machine.
>
> I've put a few comments/ideas below, but none of them feel necessary to me.

Thank you for the review. I need to do one follow up revision to base this
off of the appropriate `linux-kselftest/kunit` branch.

>
> Regardless, this is
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> > Changes since v1:
> > - Created a function to get kunit enable state
> > - Check kunit enable state in kunit_run_all_tests() in executor.c
> > - Load test module even if KUnit is disabled but still don't execute
> >   tests
> > - Simplified kunit disable message and kunit.enable parameter
> >   description
> > - Flipped around logic of new config to be KUNIT_DEFAULT_ENABLED
> > - kunit_tool.py now passes kunit.enable=1 to kernel
> >
> >  .../admin-guide/kernel-parameters.txt         |  6 +++++
> >  include/kunit/test.h                          |  2 ++
> >  lib/kunit/Kconfig                             | 11 +++++++++
> >  lib/kunit/executor.c                          |  4 ++++
> >  lib/kunit/test.c                              | 24 +++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py           |  1 +
> >  6 files changed, 48 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index adfda56b2691..7aa3abd7f1c5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2432,6 +2432,12 @@
> >                         0: force disabled
> >                         1: force enabled
> >
> > +       kunit.enable=   [KUNIT] Enable executing KUnit tests. Requires
> > +                       CONFIG_KUNIT to be set to be fully enabled. The
> > +                       default value can be overridden via
> > +                       KUNIT_DEFAULT_ENABLED.
> > +                       Default is 1 (enabled)
> > +
> >         kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
> >                         Default is 0 (don't ignore, but inject #GP)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index c958855681cc..ee6bf4ecbd89 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -228,6 +228,8 @@ static inline void kunit_set_failure(struct kunit *test)
> >         WRITE_ONCE(test->status, KUNIT_FAILURE);
> >  }
> >
> > +bool kunit_enabled(void);
> > +
>
> This probably isn't strictly necessary at this stage, given that it
> just checks one variable. That being said, I don't think it hurts (and
> personally, I quite like it), and find it more future-proof than
> exposing the variable more widely anyway.

It also addressed it being a static variable.

>
> >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> >
> >  int kunit_run_tests(struct kunit_suite *suite);
> > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > index 0b5dfb001bac..626719b95bad 100644
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
> >
> >           If unsure, say N.
> >
> > +config KUNIT_DEFAULT_ENABLED
> > +       bool "Default value of kunit.enable"
> > +       default y
> > +       help
> > +         Sets the default value of kunit.enable. If set to N then KUnit
> > +         tests will not execute unless kunit.enable=1 is passed to the
> > +         kernel command line.
> > +
> > +         In most cases this should be left as Y. Only if additional opt-in
> > +         behavior is needed should this be set to N.
> > +
> >  endif # KUNIT
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 5e223327196a..9bbc422c284b 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -190,6 +190,10 @@ int kunit_run_all_tests(void)
> >  {
> >         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
> >         int err = 0;
> > +       if (!kunit_enabled()) {
> > +               pr_info("kunit: disabled\n");
> > +               goto out;
> > +       }
> >
> >         if (filter_glob_param) {
> >                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index b73d5bb5c473..1e54373309a4 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> >  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> >  #endif
> >
> > +/*
> > + * Enable KUnit tests to run.
> > + */
> > +#ifdef CONFIG_KUNIT_DEFAULT_ENABLED
> > +static bool enable_param = true;
> > +#else
> > +static bool enable_param;
> > +#endif
> > +module_param_named(enable, enable_param, bool, 0);
> > +MODULE_PARM_DESC(enable, "Enable KUnit tests");
> > +
> >  /*
> >   * KUnit statistic mode:
> >   * 0 - disabled
> > @@ -586,10 +597,20 @@ static void kunit_init_suite(struct kunit_suite *suite)
> >         suite->suite_init_err = 0;
> >  }
> >
> > +bool kunit_enabled(void)
> > +{
> > +       return enable_param;
> > +}
> > +
> >  int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
> >  {
> >         unsigned int i;
> >
> > +       if (!kunit_enabled() && num_suites > 0) {
> > +               pr_info("kunit: disabled\n");
>
> _Maybe_ this could be pr_info_once(), if you were worried about spam
> (if a whole bunch of test modules were loaded at once). That being
> said, I prefer it as-is, as I don't think there are a lot of cases
> where large number of kunit test modules are loaded on a system with
> KUnit disable. And I'm liable to forget that KUnit is disabled if a
> system has been running for a while (and maybe one test module was
> loaded a boot), and end up wondering why my test isn't running.

That's the same conclusion I came to after considering the one time
message used for the test taint message.

>
> So, I'm all for leaving this as-is, personally.
>
> > +               return 0;
> > +       }
> > +
> >         for (i = 0; i < num_suites; i++) {
> >                 kunit_init_suite(suites[i]);
> >                 kunit_run_tests(suites[i]);
> > @@ -607,6 +628,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
> >  {
> >         unsigned int i;
> >
> > +       if (!kunit_enabled())
> > +               return;
> > +
> >         for (i = 0; i < num_suites; i++)
> >                 kunit_exit_suite(suites[i]);
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index f5c26ea89714..ef794da420d7 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -359,6 +359,7 @@ class LinuxSourceTree:
> >                         args = []
> >                 if filter_glob:
> >                         args.append('kunit.filter_glob='+filter_glob)
> > +               args.append('kunit.enable=1')
> >
> >                 process = self._ops.start(args, build_dir)
> >                 assert process.stdout is not None  # tell mypy it's set
> > --
> > 2.37.1.595.g718a3a8f04-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220823142456.3977086-2-joefradley%40google.com.
