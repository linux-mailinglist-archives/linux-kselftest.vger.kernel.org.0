Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2282859F3A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiHXGeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 02:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiHXGeB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 02:34:01 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483B7F26A
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 23:33:59 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id n125so16592154vsc.5
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YkPxi1nya94NH0mL+b69fb+nbRfXVe8xmZdluIjWTMA=;
        b=YRXsF1dlhjN2VxoC4846qi/7so5ni1yCRue1KdIHNcnjbLDO/krRCiN1FGDAtOfDwh
         64PGSGBkJnSgSd31vEJp3S+t+lgefFHp6G8wlN9JFpJZo/IRK8k0DIZa3xWmyWn9LoE/
         0/b1L2LYyMvUsSNhzLxrmSIFVd6R7oIgnxrdfx3TSSsnPxEpQzGrlOL2KHPMXsI+oQRN
         Cuof37MFqWOV2ZRturBlY8V5qnSNwtOw19cJl1zT48pISZYoHr7fiPpRnoDDtpA1NICR
         8Gw8bcEBpLU3vfn8wWepXswTTjDFQ3yq4llRAoOYz+YJEiN0o1zOW7xlGycDXzSMckYw
         Hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YkPxi1nya94NH0mL+b69fb+nbRfXVe8xmZdluIjWTMA=;
        b=zhXHOj9D5oOpTIjx6HhOrLBtu6cupyJG1KCOVOxIp69jqViEtLu0dl4MMgJBsMOGmN
         p2w4SgAThaa17q4k2sJlOdh0N7Rxa3k28YJn1A92fbFYXHnhvTSZBtp0aYKZX2hgq+0h
         iPkrpA/NN5cJ9lV6PztLFpS9d1bvjbjWh5PELNYh37dtILrSB1LCbtGpwoXAZUwpyG4C
         VrD5pGv1lC5qa9lvOwVHKc8KzpZJjGrJXIZMOE+cZaw/+QqUwv/CYSJL0mxpGFnMQtyQ
         OM3K3dypQZecpRHf51OlXZG153IlSvO0s6AxJDBoBzkHsWtXg1J0PSydvpXyn4WzQFlu
         aLlw==
X-Gm-Message-State: ACgBeo3poDRrqRLWx9TgpUi9RlIgmCETwFI09lq1Cx/USPfDkHeoSm1V
        O7ADJBvuYNIxsH0l4t+CGS5FBSF6CZ538Mx3Wn46kA==
X-Google-Smtp-Source: AA6agR7zpVquLRURrSfHIWBbJV4K+2DK/lUwvmEa/aotqNLqOUUlJdQqtTG1uCjkRe+VQmCCcUmLJ7vybj2omO2S+9c=
X-Received: by 2002:a05:6102:2146:b0:38f:f3d6:51da with SMTP id
 h6-20020a056102214600b0038ff3d651damr9766614vsg.38.1661322838798; Tue, 23 Aug
 2022 23:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
 <20220823142456.3977086-2-joefradley@google.com> <CABVgOS=E44fQ5UY5b3np5ZSrkDeXkkEAPBBA5yDd3bE72gotww@mail.gmail.com>
 <CAF-60z1H77S-pVevKyZ7DQ9e09h4=Gnhbv9RA_SWTk=kmsq18g@mail.gmail.com>
In-Reply-To: <CAF-60z1H77S-pVevKyZ7DQ9e09h4=Gnhbv9RA_SWTk=kmsq18g@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 24 Aug 2022 14:33:45 +0800
Message-ID: <CABVgOS=_pYqA6yEc5C4o+JpxSghVsWZV_rZ2TXHrgwjkvou28g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add kunit.enable to enable/disable KUnit test
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000af9da605e6f6dd66"
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

--000000000000af9da605e6f6dd66
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 24, 2022 at 1:04 PM Joe Fradley <joefradley@google.com> wrote:
>
> On Tue, Aug 23, 2022 at 9:31 PM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 10:25 PM 'Joe Fradley' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > This patch adds the kunit.enable module parameter that will need to be
> > > set to true in addition to KUNIT being enabled for KUnit tests to run.
> > > The default value is true giving backwards compatibility. However, for
> > > the production+testing use case the new config option
> > > KUNIT_DEFAULT_ENABLED can be set to N requiring the tester to opt-in
> > > by passing kunit.enable=1 to the kernel.
> > >
> > > Signed-off-by: Joe Fradley <joefradley@google.com>
> > > ---
> >
> > Thanks very much. This looks good to me, and works on my machine.
> >
> > I've put a few comments/ideas below, but none of them feel necessary to me.
>
> Thank you for the review. I need to do one follow up revision to base this
> off of the appropriate `linux-kselftest/kunit` branch.
>

This already applies cleanly to linux-kselftest/kunit -- it should be
fine as-is.

(It also applies fine to kselftest/kunit-fixes, for what it's worth.)

Cheers,
-- David

> >
> > Regardless, this is
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> > > Changes since v1:
> > > - Created a function to get kunit enable state
> > > - Check kunit enable state in kunit_run_all_tests() in executor.c
> > > - Load test module even if KUnit is disabled but still don't execute
> > >   tests
> > > - Simplified kunit disable message and kunit.enable parameter
> > >   description
> > > - Flipped around logic of new config to be KUNIT_DEFAULT_ENABLED
> > > - kunit_tool.py now passes kunit.enable=1 to kernel
> > >
> > >  .../admin-guide/kernel-parameters.txt         |  6 +++++
> > >  include/kunit/test.h                          |  2 ++
> > >  lib/kunit/Kconfig                             | 11 +++++++++
> > >  lib/kunit/executor.c                          |  4 ++++
> > >  lib/kunit/test.c                              | 24 +++++++++++++++++++
> > >  tools/testing/kunit/kunit_kernel.py           |  1 +
> > >  6 files changed, 48 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index adfda56b2691..7aa3abd7f1c5 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2432,6 +2432,12 @@
> > >                         0: force disabled
> > >                         1: force enabled
> > >
> > > +       kunit.enable=   [KUNIT] Enable executing KUnit tests. Requires
> > > +                       CONFIG_KUNIT to be set to be fully enabled. The
> > > +                       default value can be overridden via
> > > +                       KUNIT_DEFAULT_ENABLED.
> > > +                       Default is 1 (enabled)
> > > +
> > >         kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
> > >                         Default is 0 (don't ignore, but inject #GP)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index c958855681cc..ee6bf4ecbd89 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -228,6 +228,8 @@ static inline void kunit_set_failure(struct kunit *test)
> > >         WRITE_ONCE(test->status, KUNIT_FAILURE);
> > >  }
> > >
> > > +bool kunit_enabled(void);
> > > +
> >
> > This probably isn't strictly necessary at this stage, given that it
> > just checks one variable. That being said, I don't think it hurts (and
> > personally, I quite like it), and find it more future-proof than
> > exposing the variable more widely anyway.
>
> It also addressed it being a static variable.
>
> >
> > >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > >
> > >  int kunit_run_tests(struct kunit_suite *suite);
> > > diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> > > index 0b5dfb001bac..626719b95bad 100644
> > > --- a/lib/kunit/Kconfig
> > > +++ b/lib/kunit/Kconfig
> > > @@ -59,4 +59,15 @@ config KUNIT_ALL_TESTS
> > >
> > >           If unsure, say N.
> > >
> > > +config KUNIT_DEFAULT_ENABLED
> > > +       bool "Default value of kunit.enable"
> > > +       default y
> > > +       help
> > > +         Sets the default value of kunit.enable. If set to N then KUnit
> > > +         tests will not execute unless kunit.enable=1 is passed to the
> > > +         kernel command line.
> > > +
> > > +         In most cases this should be left as Y. Only if additional opt-in
> > > +         behavior is needed should this be set to N.
> > > +
> > >  endif # KUNIT
> > > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > > index 5e223327196a..9bbc422c284b 100644
> > > --- a/lib/kunit/executor.c
> > > +++ b/lib/kunit/executor.c
> > > @@ -190,6 +190,10 @@ int kunit_run_all_tests(void)
> > >  {
> > >         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
> > >         int err = 0;
> > > +       if (!kunit_enabled()) {
> > > +               pr_info("kunit: disabled\n");
> > > +               goto out;
> > > +       }
> > >
> > >         if (filter_glob_param) {
> > >                 suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index b73d5bb5c473..1e54373309a4 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> > >  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
> > >  #endif
> > >
> > > +/*
> > > + * Enable KUnit tests to run.
> > > + */
> > > +#ifdef CONFIG_KUNIT_DEFAULT_ENABLED
> > > +static bool enable_param = true;
> > > +#else
> > > +static bool enable_param;
> > > +#endif
> > > +module_param_named(enable, enable_param, bool, 0);
> > > +MODULE_PARM_DESC(enable, "Enable KUnit tests");
> > > +
> > >  /*
> > >   * KUnit statistic mode:
> > >   * 0 - disabled
> > > @@ -586,10 +597,20 @@ static void kunit_init_suite(struct kunit_suite *suite)
> > >         suite->suite_init_err = 0;
> > >  }
> > >
> > > +bool kunit_enabled(void)
> > > +{
> > > +       return enable_param;
> > > +}
> > > +
> > >  int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
> > >  {
> > >         unsigned int i;
> > >
> > > +       if (!kunit_enabled() && num_suites > 0) {
> > > +               pr_info("kunit: disabled\n");
> >
> > _Maybe_ this could be pr_info_once(), if you were worried about spam
> > (if a whole bunch of test modules were loaded at once). That being
> > said, I prefer it as-is, as I don't think there are a lot of cases
> > where large number of kunit test modules are loaded on a system with
> > KUnit disable. And I'm liable to forget that KUnit is disabled if a
> > system has been running for a while (and maybe one test module was
> > loaded a boot), and end up wondering why my test isn't running.
>
> That's the same conclusion I came to after considering the one time
> message used for the test taint message.
>
> >
> > So, I'm all for leaving this as-is, personally.
> >
> > > +               return 0;
> > > +       }
> > > +
> > >         for (i = 0; i < num_suites; i++) {
> > >                 kunit_init_suite(suites[i]);
> > >                 kunit_run_tests(suites[i]);
> > > @@ -607,6 +628,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
> > >  {
> > >         unsigned int i;
> > >
> > > +       if (!kunit_enabled())
> > > +               return;
> > > +
> > >         for (i = 0; i < num_suites; i++)
> > >                 kunit_exit_suite(suites[i]);
> > >
> > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > index f5c26ea89714..ef794da420d7 100644
> > > --- a/tools/testing/kunit/kunit_kernel.py
> > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > @@ -359,6 +359,7 @@ class LinuxSourceTree:
> > >                         args = []
> > >                 if filter_glob:
> > >                         args.append('kunit.filter_glob='+filter_glob)
> > > +               args.append('kunit.enable=1')
> > >
> > >                 process = self._ops.start(args, build_dir)
> > >                 assert process.stdout is not None  # tell mypy it's set
> > > --
> > > 2.37.1.595.g718a3a8f04-goog
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220823142456.3977086-2-joefradley%40google.com.

--000000000000af9da605e6f6dd66
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDv
KesMIjvT60PMO4LfTFLxZIWVuHkg3KUEhCwR8PCYkTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjQwNjMzNTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAF6fmonHeVP8XQaWe2y57
kE46bxeOfiHpNGwAcQw1WYPbCU6GPnsDNdzS0fO6pxAYpjXHSykqmLxbDLMVlQeFA2YOCx/j1lLQ
uq3mKelpM1EhLW0c/uS66MLkgqjahAfcVas3Ke3Qrzs8w7WCdrL8vDvBd9u3ubcV2yTUF8p4yFaK
DpLEmFS2hrIodiIDsa2VYw0SMS6/oYjoP/HytMyXfQqiUI8oslIzdGSZodiTkjiHDzQBCzx+X9Mg
hJ4tZI5EXl2q/Td+2Xx10Ure2rwGVYCfMMFLrWBXIEMDhFAEFfvEKrz2YOYRyIFLpeYhHtAz9Usm
CV7AXM2HdE09Q50vig==
--000000000000af9da605e6f6dd66--
