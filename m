Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB46E0700
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 08:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDMGcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 02:32:06 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F95FD4
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:32:05 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id y21so328107ual.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681367524; x=1683959524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBVRwCd0XyvMtiQMNMvH2nrvOyt912yUgZm7nUopVO0=;
        b=IrQcO27XJyLCx0ACyQPDk5+x9cDxuEiv6OZ3Rdw3M0n4RQDK2RYxZd4E1/7E7Jkxcv
         /nptbo3l3Q7NIfUNDjRCB92rKmLvChW2Fd6eSsy7j1fUJ2VnI5Ce/AI0SiRPlM8ya8kP
         oIXQmx0BHLT4ztSHYDTp7+6R9DHAW9qytmbGckvb2oiwpPckRSZlBRf9//GfoQ3KJp4q
         q5j6+GGFDGh6c1WLZZhclXDIOfJRfNEbud6VoaXSAjJ6pN634Lb5Eom14d+XmtEG9OCF
         ZJD0kf1QK1IQWmFsk2cOf9Nh/nS6lSQcExP2yp1duo5duRNzWa7KEVGi+0efExweU1yu
         8ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367524; x=1683959524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBVRwCd0XyvMtiQMNMvH2nrvOyt912yUgZm7nUopVO0=;
        b=aVbVN65cmUhdJAL6sIXKHSkDMkjLJhZ21tWn1Gp5XmrOvy2Ksf2O6maIx9EMSLHkvp
         0BJ1qCK+sLn0Uu+Qh13C9N3kG5Fyf1i4d6Ski2d5V0XqYgJDQF9qWNYhvCHG/4iReDwp
         JlI6KYQ8XW6CIOc2QOJfkHo3mEati3ZPi9Ofeamrps+M95iUs6w1D52pWJwfg7cGr5ih
         +3dHhst02REtV7ke8f0X7a6XiKYAcCfhaKRGTKyYE3vcWMXe+9aBIQcamUw0r0Y1995N
         W8r/IJudC0iQyb+eNMFTOlFDy+EqSh314Sy8+BrwJ3ekDsUcTA4nm654bfqOuFMQqRB/
         BXzw==
X-Gm-Message-State: AAQBX9fQiT921W1zGlI+81A7rypps5n8eEBzEQv3PZEwuJ0NCpoGF0eu
        PfVCGWFvaqFp5QwiGLJ/sKGN3p05oy0b0AH+ylRW6g==
X-Google-Smtp-Source: AKy350bW3LuuJN0uBVj3Y6a9pjzZvVXaMKrWTuxkSCFH+clCAcZCGNXNp54JNuVvqsC7DQFR6kQ8t2H/jb/vyUnsNSs=
X-Received: by 2002:a1f:2081:0:b0:43c:2acb:9a60 with SMTP id
 g123-20020a1f2081000000b0043c2acb9a60mr398213vkg.3.1681367524073; Wed, 12 Apr
 2023 23:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
 <20230411160056.1586-4-michal.wajdeczko@intel.com> <CA+GJov53J4WhXXUSrGDPZ-hqogL0eYOzaf_RgGQ1paj=_EtLUA@mail.gmail.com>
In-Reply-To: <CA+GJov53J4WhXXUSrGDPZ-hqogL0eYOzaf_RgGQ1paj=_EtLUA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Apr 2023 14:31:52 +0800
Message-ID: <CABVgOSnyvEhgNyxqvJtu6ttXSdAB6t1SaN6-4SCmHYW25AKZoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
To:     Rae Moar <rmoar@google.com>
Cc:     Michal Wajdeczko <michal.wajdeczko@intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000838a005f931e24e"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000000838a005f931e24e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Apr 2023 at 04:28, Rae Moar <rmoar@google.com> wrote:
>
> On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
> >
> > There is function to report status of either suite or test, but it
> > doesn't support parameterized subtests that have to log report on
> > its own. Extend it to also accept subtest level results to avoid
> > code duplication.
> >
> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> > Cc: David Gow <davidgow@google.com>
> > ---
> >  lib/kunit/test.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 5679197b5f8a..692fce258c5b 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_s=
uite *suite)
> >                   kunit_suite_num_test_cases(suite));
> >  }
> >
> > +enum kunit_test_or_suite {
> > +       KUNIT_SUITE =3D 0,
> > +       KUNIT_TEST,
> > +       KUNIT_SUBTEST,
> > +};
> > +
>
> Hi Michal!
>
> Since KUnit's goal is to progress toward supporting arbitrary levels
> of testing, I like the idea of starting to adjust these helper
> functions to allow for greater levels of testing.
>
> However, I'm not sure about this kunit_test_or_suite enum. If our goal
> is to support an arbitrary number of levels of tests then this enum
> still limits us to a finite number of levels. However, if we only want
> to focus on supporting parameterized tests (which is our direct goal),
> this could be the right solution.
>
> Maybe instead we could use an integer denoting the test level instead?
> This would remove the limit but would also remove the nice names of
> the levels.
>
> I'm curious what others opinions are on these ideas?
>
> A bit of a nit: if we do use this enum I wonder if we could clarify
> the name to be kunit_test_level as the current name of
> kunit_test_or_suite seems to indicate to me a binary of two options
> rather than three.
>
> >  static void kunit_print_ok_not_ok(void *test_or_suite,
> > -                                 bool is_test,
> > +                                 enum kunit_test_or_suite is_test,
>
> Similar to above, I think the name of is_test could be clarified. It
> is currently a bit confusing to me as they are all tests. Maybe
> test_level?

I agree with Rae that this is not the ideal long-term solution.

We're basically encoding two things here:
- Are we dealing with a 'struct kunit_suite' or a 'struct kunit'?
- How nested the test is.

Given KUnit originally only had a 2-level nesting (suite->test), and
now has 3-level nesting (always suite->test[->param]), this works, but
the KTAP format permits arbitrary nesting of tests, and we'll want to
have something like that in KUnit going forward. We don't have a
design for that yet, but it could conceivably allow nested suites,
thus breaking the rule that nesting level 0 is always a suite, and the
rest are all tests.

So there's definitely a part of me that would prefer to pass those two
pieces of information in separate arguments, rather than relying on an
enum like this.

That being said, this is all very fuzzy future plans, rather than
anything concrete, and this will all likely need reworking if we do
anything drastic anyway, so I'm not worried if we go with this for
now, and change it when we need to. I do think it's an improvement
over what we're doing currently.
(For example, another possible implementation for nested tests could
be to get rid of the distinction between tests and suites completely:
or at least have them share 'struct kunit', so this wouldn't need
passing in separately.)

Cheers,
-- David


>
> >                                   enum kunit_status status,
> >                                   size_t test_number,
> >                                   const char *description,
> > @@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_sui=
te,
> >                         (status =3D=3D KUNIT_SKIPPED) ? directive : "")=
;
> >         else
> >                 kunit_log(KERN_INFO, test,
> > -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
> > +                         "%.*s%s %zd %s%s%s",
> > +                         (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,
>
> I would consider saving the length of KUNIT_SUBTEST_INDENT as a macro.
> Maybe KUNIT_INDENT_LEN?
>
> > +                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,
> >                           kunit_status_to_ok_not_ok(status),
> >                           test_number, description, directive_header,
> >                           (status =3D=3D KUNIT_SKIPPED) ? directive : "=
");
> > @@ -209,7 +217,7 @@ static size_t kunit_suite_counter =3D 1;
> >
> >  static void kunit_print_suite_end(struct kunit_suite *suite)
> >  {
> > -       kunit_print_ok_not_ok((void *)suite, false,
> > +       kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
> >                               kunit_suite_has_succeeded(suite),
> >                               kunit_suite_counter++,
> >                               suite->name,
> > @@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                                                  "param-%d", test.param=
_index);
> >                                 }
> >
> > -                               kunit_log(KERN_INFO, &test,
> > -                                         KUNIT_SUBTEST_INDENT KUNIT_SU=
BTEST_INDENT
> > -                                         "%s %d %s%s%s",
> > -                                         kunit_status_to_ok_not_ok(tes=
t.status),
> > -                                         test.param_index + 1, param_d=
esc,
> > -                                         test.status =3D=3D KUNIT_SKIP=
PED ? " # SKIP " : "",
> > -                                         test.status =3D=3D KUNIT_SKIP=
PED ? test.status_comment : "");
> > +                               kunit_print_ok_not_ok(&test, KUNIT_SUBT=
EST,
> > +                                                     test.status,
> > +                                                     test.param_index =
+ 1,
> > +                                                     param_desc,
> > +                                                     test.status_comme=
nt);
> >
> >                                 /* Get next param. */
> >                                 param_desc[0] =3D '\0';
> > @@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> >
> >                 kunit_print_test_stats(&test, param_stats);
> >
> > -               kunit_print_ok_not_ok(&test, true, test_case->status,
> > +               kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->sta=
tus,
> >                                       kunit_test_case_num(suite, test_c=
ase),
> >                                       test_case->name,
> >                                       test.status_comment);
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kunit-dev/20230411160056.1586-4-michal.wajdeczko%40intel.com.

--0000000000000838a005f931e24e
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCH
t+NBk9qYQZ+zYdk+4/0bxVvdzjZpVaJcU4CgG4yjjjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTMwNjMyMDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAULSum0CNGSc+m7MrAaM5
77/7mtBeLNDfRAp28EeRM+1HXwqx/lfFMkft/kcU5evm5yHiau+JehvOqWh+sEg2KQOXTuj9M62R
fFafxJRClMEn7uk0NhIZEm5SaayzYyhKnaF9h7MYQf2C4fbCXFKuSJL8mYwY1Dt7xcXQG0Eik892
kZg4ox7fFTKg9fc1AhCLuNTy1f6lPE+ynwjFxXBZ6u0il6fFXfs8AF+RxRNpaAZ4BEDg9UujtNrX
5qNMJoA9Yq/3xgiMK83GTQT6PreK1RlJZuvTyanRnmr0NfwdkFsMFtTEaoc9p8ImQ2dk82Hkgr1j
HtZ/A3yrMytrPzy9/g==
--0000000000000838a005f931e24e--
