Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE856E070A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDMGie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGid (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 02:38:33 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4FF6EA0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:38:32 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id k20so9688198ual.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 23:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681367911; x=1683959911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfwwmZ797c9xLIMORVneRiyMQiXRFQ2cMiC+cfc48n8=;
        b=60NmV70EIZMeQvFllKeJCQS7pvb6AMoLi95FvMfOhZp2tCpcWRAM+GjODvswclnW1d
         f/yWk6aRJ2+L3yVbbZ0F/wLCzGeEM1QGwVHT/M7uwV/mFQhGwJLu1oCRHX2clvumEh+N
         O/fvIdGplSy28XUtLJky6wFf+hDtr1sQT0AK2qNd1YNelLWB5NVEz0AEDXSI+EJ3lCIl
         /xf5Khb4tMDfygT0U/JU7sZJL+6YtFI8WeNqv4fluIzpFTiYS/4Gydy08e34XDfiJ9Di
         cgb/jxSJdsffx8pOPgyuOWfOKHTLjgW6GceSUDtYGg1nSVB4Gh5PuGHtadTrM5gq2BCm
         KVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367911; x=1683959911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfwwmZ797c9xLIMORVneRiyMQiXRFQ2cMiC+cfc48n8=;
        b=cF+X96RS4p6n8C2vPymEyFwZKzhJbbZZWoxRAY+vBuYD6pHX4uf6VV8c4m9QDn63Dz
         3X8Xvpom9mgVnIHoyowpPQg0W2sbMoyzVIyQB8DzfcLoF1+MeHaoTHyrIn3bMtgTM4HC
         xCKJlou68Gfh/WQWJte5VEWbmy8LpnWe3CjMrm05PUyeEMmKNjhMIsE4jE+vfHtcHrBV
         sVjth+oEN50mNYXr2zAODwFB6PJ5W4+jmRnHuqMOGf4OY6vqIrdLH7+52ASx1a6CqBI+
         XdAhcJmJNVCa6AR/No5vwLmVV3DaQY/L11bd7YynLivYzEmU507zilgK2vSPD6tSoGOx
         +BYw==
X-Gm-Message-State: AAQBX9cLy+els1TOZ9SHEwzYMbU40oCQUC8HK4LWo7T8ENQTiqdhvLNw
        1UrD6hsN8byV3QDQIJHuS9ZrY6keKqEyH04GTtKTokmTUXnj0wFSVck=
X-Google-Smtp-Source: AKy350buR+IMsN3gQ/Qm9xmbi16+NqI2Zw1leTzTUGRGgjpHf7YdF1274W7FOyU42ipsFQ+B3FnO3a0fBXengwwkx+w=
X-Received: by 2002:a1f:2004:0:b0:40e:fee9:667a with SMTP id
 g4-20020a1f2004000000b0040efee9667amr386431vkg.3.1681367911148; Wed, 12 Apr
 2023 23:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com> <20230411160056.1586-4-michal.wajdeczko@intel.com>
In-Reply-To: <20230411160056.1586-4-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Apr 2023 14:38:19 +0800
Message-ID: <CABVgOSk3K08W8E5gdycVFJRqo4NdxQvHpxS2OwMEZ48GZVrTUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001aa9d105f931f91b"
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

--0000000000001aa9d105f931f91b
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Apr 2023 at 00:01, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> There is function to report status of either suite or test, but it
> doesn't support parameterized subtests that have to log report on
> its own. Extend it to also accept subtest level results to avoid
> code duplication.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> ---

Thanks: this is definitely an improvement on how we handle this.

There's definitely more we can do, particularly looking forward to
supporting more complex test hierarchies in the future, but getting
everything under kunit_print_ok_not_ok is an improvement regardless of
when happens down the line.

My only real concern is that the way the indent is printed is a bit
subtle and difficult to understand fully on first glance. I've added
some notes below.

>  lib/kunit/test.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 5679197b5f8a..692fce258c5b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>                   kunit_suite_num_test_cases(suite));
>  }
>
> +enum kunit_test_or_suite {
> +       KUNIT_SUITE = 0,
> +       KUNIT_TEST,
> +       KUNIT_SUBTEST,
> +};
> +

As Rae notes, this probably won't be how this code eventually evolves.
I don't think it's a problem to have it now, though.

>  static void kunit_print_ok_not_ok(void *test_or_suite,
> -                                 bool is_test,
> +                                 enum kunit_test_or_suite is_test,
>                                   enum kunit_status status,
>                                   size_t test_number,
>                                   const char *description,
> @@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>                         (status == KUNIT_SKIPPED) ? directive : "");
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
> +                         "%.*s%s %zd %s%s%s",
> +                         (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,
> +                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,

This feels a little bit _too_ clever here: I feel it at the very least
needs a comment, and maybe it'd make more sense to either:
- Make is_test explicitly a "nesting depth" integer, and calculate the
indent based on that.
- Have is_test as an enum, and then just explicitly handle each value
separately. (Like we do with suite vs test).

I think that the former is probably the right long-term solution (it's
much more extensible to more levels of nesting), but the latter is
definitely easier given the differences between suites and tests at
the moment.

If we do continue to share a codepath between tests and subtests, I'd
prefer it if we either didn't use strlen(), or went to some greater
effort to document how that works (hopefully we can guarantee that the
compiler will treat this as a constant). Equally, a comment or
something noting that this will read invalid memory if is_test > 2,
due to the hardcoded two KUNIT_SUBTEST_INDENT, would be nice.


>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
>                           (status == KUNIT_SKIPPED) ? directive : "");
> @@ -209,7 +217,7 @@ static size_t kunit_suite_counter = 1;
>
>  static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
> -       kunit_print_ok_not_ok((void *)suite, false,
> +       kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
>                               kunit_suite_has_succeeded(suite),
>                               kunit_suite_counter++,
>                               suite->name,
> @@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>                                                  "param-%d", test.param_index);
>                                 }
>
> -                               kunit_log(KERN_INFO, &test,
> -                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> -                                         "%s %d %s%s%s",
> -                                         kunit_status_to_ok_not_ok(test.status),
> -                                         test.param_index + 1, param_desc,
> -                                         test.status == KUNIT_SKIPPED ? " # SKIP " : "",
> -                                         test.status == KUNIT_SKIPPED ? test.status_comment : "");
> +                               kunit_print_ok_not_ok(&test, KUNIT_SUBTEST,
> +                                                     test.status,
> +                                                     test.param_index + 1,
> +                                                     param_desc,
> +                                                     test.status_comment);
>
>                                 /* Get next param. */
>                                 param_desc[0] = '\0';
> @@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_print_test_stats(&test, param_stats);
>
> -               kunit_print_ok_not_ok(&test, true, test_case->status,
> +               kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->status,
>                                       kunit_test_case_num(suite, test_case),
>                                       test_case->name,
>                                       test.status_comment);
> --
> 2.25.1
>

Otherwise, this all looks good to me. Thanks very much!

Cheers,
-- David

--0000000000001aa9d105f931f91b
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAD
xFpxh2ZoJz5ItoNPZ0GbCor9HHaKAd/OYu3z4oL6GzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTMwNjM4MzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdRN/ck+0kDGXoPb/YGem
jZsz36XX8vyyJZlOgJI9uEOuhre7uqkRe0VZJkIZOlLsfp2cyETYh12XjkRoKnqwJVzNRslhpDZe
R38a5Q/AR8io7rYE8tfpAmt+vZ7/mSA1oFCqf//LXrzxvrbfPBGRe7BOBcGh6g951awjM1rJbCsR
rkeUvOcOW2kyhJS2exljWcjXJbKq0goFymJ0Y0yxTUuFBGDYNVNFP0PlmjOOxN0ewmTuuZyyr8s8
tKDKZVAy2lfqqH7qGKzvCCezOxKh7rMPrCmgDZoYQqgAqnoddaFC270c9OGXIU1dOSyi3I8TGSSI
5tuLGU9NLKA29woXhg==
--0000000000001aa9d105f931f91b--
