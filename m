Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4C368FF9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 06:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBIFGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 00:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBIFGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 00:06:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B81233E0
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 21:06:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so600828wrj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 21:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq7lIttHKAd4yHs29nx4hB+Y5Sil2NIwuJQ+7f+Quy4=;
        b=V9qPMFhZvFK3UJEOt5L9CQ/4I9bbl2UNYnPKdSt+sQXJw6BthGBF8K8lKWz3OxSbDC
         g3uOUSXuwEDt76F6iwZnQM9/iu+aPOuV7xBwz8Qp5Hw1oWX9dV0JsVGC0NOXRpHHzT7U
         7YPEFigL4v8OrsWsR5elZfpv91r3QRj2tliVVJjaGEAwxCbMBQnhfj4X1Swpw6Fkw4UJ
         +yuUk/3ahRp9rnoPt6PSplOsdw6ZZ61AUEuGk0UYPTa3ujhcjVRebxMoWtJLf1T+AHWI
         jhReercwjNzWOlCgJMRY52lXSk+GUldhW/c5x3Dhv/0EiyjZEYhbj+eDM6qJ5qyJ0Rk8
         C7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq7lIttHKAd4yHs29nx4hB+Y5Sil2NIwuJQ+7f+Quy4=;
        b=mSxzmftCS7myGPolSdJ1Q+O1VoeGsWtDAVC9WZgAY6tObnypwFwDBVbEC5UXIoRY23
         Kdtk9jgL4FgnwTInNFUzIbvD+vK1l88SWp1O+kG7mhUfLAsW/0g01NucmGJ3zwfNUTGq
         TCQqy9NvISmIEvfODGEvUyttPS6gmjaupZFOzsCXfrLLCamxoj1EO33Ad82T60uvvXJf
         i0d7dfVnC2qVOFItRB3wPnKRHIQx1GN40o0paUeBhyGrbldgqTHeSHxkjr4EVJnzGL0h
         e+sPJMFjFei7GvS5TEPc54Vs3cP33IyXoKyakH+2RfCDugo9fMv2NADMGbXGaEpX7snz
         D+mQ==
X-Gm-Message-State: AO0yUKXKpiWC9ELpm0pjaTgJRaUG3hsv7jgbr5qiQmZ7ZT0TgMuCZzJX
        VHhpfm/2cmq5vhkgsmPV8a0PsUUcawBbgVxs1V8MKA==
X-Google-Smtp-Source: AK7set/fV0y4CE2KeB1AaU5aeGLI1JCa4nGM2JenpGvcsQrPtJVH+PObWCiWxyyRsHkGCoo7V3xGudC1V+IjXSkBcmY=
X-Received: by 2002:a5d:40cb:0:b0:2bf:d0b4:8bb2 with SMTP id
 b11-20020a5d40cb000000b002bfd0b48bb2mr446711wrq.695.1675919178409; Wed, 08
 Feb 2023 21:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-2-rmoar@google.com>
In-Reply-To: <20230131220355.1603527-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Feb 2023 13:06:05 +0800
Message-ID: <CABVgOSmYmP+yO1BQ2m8nA+czTjQZrYeOWkn1b47UUiFKG3NUZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized tests
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000518d6d05f43d572b"
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

--000000000000518d6d05f43d572b
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Feb 2023 at 06:04, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug in debugfs logs that causes parameterized results to not appear
> in the log because the log is reintialized (cleared) when each parameter is

Nit: s/reintialized/reinitialized

> run.
>
> Ensure these results appear in the debugfs logs and increase log size to
> allow for the size of parameterized results.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks pretty good to me, but we may need to restrict the size of
a single log line separately from that of the whole log.

(It'd also be nice to include a before/after in the commit description.)

With the stack size issue fixed, though, this looks good to me:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h | 2 +-
>  lib/kunit/test.c     | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87ea90576b50..0a077a4c067c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>  struct kunit;
>
>  /* Size of log associated with test. */
> -#define KUNIT_LOG_SIZE 512
> +#define KUNIT_LOG_SIZE 1500

This is used both as the overall log size, and the size of a single
line in kunit_log_append.

As the latter involves a local 'line' array, it can bloat out stack usage.

Could we either restrict the maximum line length separately, or rework
kunit_log_append() to not use a local variable?
(I imagine we could just vsnprintf() directly into the log buffer. We
could make two sprintf calls to calculate the length required to
maintain some atomicity as well (this could open us up to
time-of-check/time-of-use vulnerabilities, but I think the
vulnerability ship has sailed if you're passing untrusted pointers
into the kunit_log macro anyway))

>
>  /* Maximum size of parameter description string. */
>  #define KUNIT_PARAM_DESC_SIZE 128
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 51cae59d8aae..66ba93b8222c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -437,7 +437,6 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         struct kunit_try_catch_context context;
>         struct kunit_try_catch *try_catch;
>
> -       kunit_init_test(test, test_case->name, test_case->log);
>         try_catch = &test->try_catch;
>
>         kunit_try_catch_init(try_catch,
> @@ -533,6 +532,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 struct kunit_result_stats param_stats = { 0 };
>                 test_case->status = KUNIT_SKIPPED;
>
> +               kunit_init_test(&test, test_case->name, test_case->log);
> +
>                 if (!test_case->generate_params) {
>                         /* Non-parameterised test. */
>                         kunit_run_case_catch_errors(suite, test_case, &test);
> --
> 2.39.1.456.gfc5497dd1b-goog
>

--000000000000518d6d05f43d572b
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDG
NKdF5VTIdD7sGNDF6Nx9i8ahV8Jgksml2QZ7E9VPHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMDkwNTA2MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYmL0SPhnPhlaV4uEr6uC
BukjqYk/57Tnafwl1Dc+KTncKDym5v2cUWFCxfJxM8sMGPXCouSVB/60FNSELQTjhOyPVeXoOiuM
HcRYnwinwxHfkIrzBDLwVgFycYbR/Yo+ZbL7TGESobZa9yY31hb4qQ64d4gZDCinBxwfthzzbFIh
8JkYLZqDwC5jp8H8TIYN/S14dZJ0w52UCVeFgInyk4l1xfBkRHJYzoZDb3RPhIOfPezWK0vWbHyy
IRHAs8iRTqo0BLIfHBj0XYf3nTnX6eRfi0HgZWIZaH21p2QfUCiA7Gz8T+wrCcMNe/gasUkf8zl1
9ogVQLWfOT5hf4jtww==
--000000000000518d6d05f43d572b--
