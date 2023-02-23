Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A26A028F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjBWFwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 00:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjBWFwB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 00:52:01 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22990498AB
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 21:51:57 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536be69eadfso161903047b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 21:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rR0Y8hmOA8JMs7G+6t8ljnm4a8oPXVDJ9wsmZlKOvX0=;
        b=da32qjlPzT+jT2GhuISdufryjmJ8ZTut8dlweo8Uaj2kdW0DOwDT5hp2S/Hp83nlIL
         IayMW8Hey0IImoUhMhF0rx31FvxdzbsyGZKHHD/J/Awn5ZlGNga/7jI6YeG06fk5pAhQ
         yCmZ93zi4BDdbeu+wl2I+rtIB34Ch0wb7uygGyTqPacnYJQuX7C6Xb2XYl1VvOALvjrj
         6MpwK/862/Mk4dpFIl1gukMnToJTFHxxPM9SVjHruF8HfsL/j5MmvUIaewVeLct5n46D
         aUv9swGCiOssJ+AkuBup6T/kHtopWiR24lRqsJDEGSoEjXzMUIinyNTfcLvxhYqicf4Q
         Iwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR0Y8hmOA8JMs7G+6t8ljnm4a8oPXVDJ9wsmZlKOvX0=;
        b=LYnTdIZhEwA249z78rQBOMOziQtQ9TimXTqlxOCv83XYgFCR6rJjeTdR4+rYeag2gQ
         yWhckzMGjgKYiuacMnwnokZCNetasXxzDhUP7+DP3ZrGAiGRGn2zimhPuw6UVT7NGS0/
         fT+7bZEGfmgcagPOPRq/aMb7dIPnG7jKbP4sPMmom3gaCPoiuHC7nB4Q5aS/FotqK7mu
         X9PovVP6vMOzV7lZdjy6wXylF+SAc22C8oy8uUOu5tSUtCWHYIy/W//UEXe8q1aBSq2n
         OfL5CcSH7V4r+gqNASErQ0KkfHLlbWjdm+vvQY8xB+JQS1Hesj+7Be6xACneeWMn+he5
         yd3A==
X-Gm-Message-State: AO0yUKUkAlj1W2HNrfnLe5J1yd6yCUWkV2kxV08fhfqc3CgBkMOOxcxI
        qzcgAu45ex91uPwjbIf8GwzdFcWWf7GNggRoIOWtTQ==
X-Google-Smtp-Source: AK7set9yP94TsxHgmStrTjYxH8JUMIy7slEkehmZ3t1r1LGaGvG7HPdrgCIllC3xNUhfhsqqMcHttjNfMpsHH4SJ1t8=
X-Received: by 2002:a81:ae01:0:b0:533:9c5b:7278 with SMTP id
 m1-20020a81ae01000000b005339c5b7278mr1869033ywh.0.1677131515952; Wed, 22 Feb
 2023 21:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20230222182740.254087-1-rmoar@google.com> <20230222182740.254087-3-rmoar@google.com>
In-Reply-To: <20230222182740.254087-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 23 Feb 2023 13:51:43 +0800
Message-ID: <CABVgOSmJRxCT=NZ7ZWMwCrpHJHnHBAa=XmuNcLAJd_FrBvMZBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: fix bug of extra newline characters in
 debugfs logs
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000046872305f5579c25"
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

--00000000000046872305f5579c25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2023 at 02:27, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug of the extra newline characters in debugfs logs. When a line is
> added to debugfs with a newline character at the end, an extra line appea=
rs
> in the debugfs log.
>
> This is due to a discrepancy between how the lines are printed and how th=
ey
> are added to the logs. Remove this discrepancy by checking if the a newli=
ne

Nit: "if the a"?

> character is present before adding a newline character to the log. This
> should closely match the printk behavior.
>
> Add kunit_log_newline_test to provide test coverage for this issue. (Also=
,
> move kunit_log_test above suite definition to remove the unnecessary
> declaration prior to the suite definition)
>
> As an example, say we add these two lines to the log:
>
> kunit_log(..., =E2=80=9CKTAP version 1\n=E2=80=9D);
> kunit_log(..., =E2=80=9C1..1=E2=80=9D);

Nit: Please use regular quotes here ("), rather than the "smart quotes" (=
=E2=80=9C=E2=80=9D).

>
> The debugfs log before this fix:
>
>  KTAP version 1
>
>  1..1
>
> The debugfs log after this fix:
>
>  KTAP version 1
>  1..1
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>
This overall seems better. I haven't finished reviewing the series
yet, but there are a few obvious issues with this patch still...

Most notably, kunit-log-test.kunit_log_test now fails.

-- David

> Changes from v1 -> v2:
> - Changed the way extra newlines are removed. Instead of removing extra
>   newline characters, add a newline if one is not present. This is a bit
>   cleaner.
> - Add before and after results to the commit message.
> - Note: I looked into using KERN_CONT to match the printk behavior to
>   vsnprintf but this could cause issues with KTAP printing on the same li=
ne
>   as interrupting kernel messages. I also looked at adding KERN_CONT
>   functionality to kunit_log and I did get this to work but it was a bit
>   messy because it required a few calls to kunit_log_newline in
>   kunit_run_tests. If this is very desired functionality, happy to add th=
is
>   to version 3.
>
>  include/kunit/test.h   |  9 ++++++++-
>  lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++------------
>  lib/kunit/test.c       | 14 ++++++++++++++
>  3 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 0668d29f3453..3031ad29718b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -375,6 +375,13 @@ static inline void *kunit_kcalloc(struct kunit *test=
, size_t n, size_t size, gfp
>
>  void kunit_cleanup(struct kunit *test);
>
> +/**
> + * kunit_log_newline() - Add newline to the end of log if not already
> + * present at the end of the log.
> + * @log: The log to add the newline to.
> + */
> +void kunit_log_newline(char *log);
> +

I don't think this function needs to be public. Maybe keep it static
and internal to test.c?

>  void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>
>  /**
> @@ -420,7 +427,7 @@ void __printf(2, 3) kunit_log_append(char *log, const=
 char *fmt, ...);
>  #define kunit_log(lvl, test_or_suite, fmt, ...)                         =
       \
>         do {                                                            \
>                 printk(lvl fmt, ##__VA_ARGS__);                         \
> -               kunit_log_append((test_or_suite)->log,  fmt "\n",       \
> +               kunit_log_append((test_or_suite)->log,  fmt,    \
>                                  ##__VA_ARGS__);                        \
>         } while (0)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 4df0335d0d06..b63595d3e241 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite =
=3D {
>         .test_cases =3D kunit_resource_test_cases,
>  };
>
> -static void kunit_log_test(struct kunit *test);
> -
> -static struct kunit_case kunit_log_test_cases[] =3D {
> -       KUNIT_CASE(kunit_log_test),
> -       {}
> -};
> -
> -static struct kunit_suite kunit_log_test_suite =3D {
> -       .name =3D "kunit-log-test",
> -       .test_cases =3D kunit_log_test_cases,
> -};
> -
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> @@ -481,6 +469,29 @@ static void kunit_log_test(struct kunit *test)
>  #endif
>  }
>
> +static void kunit_log_newline_test(struct kunit *test)
> +{
> +       kunit_info(test, "Add newline\n");
> +       if (test->log) {
> +               KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "Add ne=
wline\n"),
> +                       "Missing log line, full log:\n%s", test->log);
> +               KUNIT_EXPECT_NULL(test, strstr(test->log, "Add newline\n\=
n"));
> +       } else {
> +               kunit_skip(test, "only useful when debugfs is enabled");
> +       }
> +}
> +
> +static struct kunit_case kunit_log_test_cases[] =3D {
> +       KUNIT_CASE(kunit_log_test),

This test is failing now:
[13:42:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kunit-log-test (2 =
subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:42:51] put this in log.
[13:42:51] this too.
[13:42:51] add to suite log.
[13:42:51] along with this.
[13:42:51]     # kunit_log_test: EXPECTATION FAILED at
lib/kunit/kunit-test.c:459
[13:42:51]     Expected strstr(test->log, "put this in log.") is not
null, but is
[13:42:51]     # kunit_log_test: EXPECTATION FAILED at
lib/kunit/kunit-test.c:461
[13:42:51]     Expected strstr(test->log, "this too.") is not null, but is
[13:42:51]     # kunit_log_test: EXPECTATION FAILED at
lib/kunit/kunit-test.c:463
[13:42:51]     Expected strstr(suite.log, "add to suite log.") is not
null, but is
[13:42:51]     # kunit_log_test: EXPECTATION FAILED at
lib/kunit/kunit-test.c:465
[13:42:51]     Expected strstr(suite.log, "along with this.") is not
null, but is
[13:42:51] [FAILED] kunit_log_test
[13:42:51] [PASSED] kunit_log_newline_test
[13:42:51] # kunit-log-test: pass:1 fail:1 skip:0 total:2
[13:42:51] # Totals: pass:1 fail:1 skip:0 total:2
[13:42:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] kun=
it-log-test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> +       KUNIT_CASE(kunit_log_newline_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite =3D {
> +       .name =3D "kunit-log-test",
> +       .test_cases =3D kunit_log_test_cases,
> +};
> +
>  static void kunit_status_set_failure_test(struct kunit *test)
>  {
>         struct kunit fake;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index fb6b39cca0ae..1ea981392af3 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -108,6 +108,17 @@ static void kunit_print_test_stats(struct kunit *tes=
t,
>                   stats.total);
>  }
>
> +void kunit_log_newline(char *log)
> +{
> +       int log_len, len_left;
> +
> +       log_len =3D strlen(log);
> +       len_left =3D KUNIT_LOG_SIZE - log_len - 1;
> +
> +       if (log_len > 0 && log[log_len - 1] !=3D '\n')
> +               strncat(log, "\n", len_left);
> +}
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -134,6 +145,9 @@ void kunit_log_append(char *log, const char *fmt, ...=
)
>         va_start(args, fmt);
>         vsnprintf(log + log_len, min(len, len_left), fmt, args);
>         va_end(args);
> +
> +       /* Add newline to end of log if not already present. */
> +       kunit_log_newline(log);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
>
> --
> 2.39.2.637.g21b0678d19-goog
>

--00000000000046872305f5579c25
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCk
FQI6/mSoy5LIh3lipH/nLYSH5z3FoRL2YkyKaEypCzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjMwNTUxNTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQEoup9tNOt/B3QSwV2dH
8qwlR/dABh5pwxHiH57Jv3yPvfNR4KaJvY8hSImYGy26oMFKAQCgfBuXE4f6eqzXYqFJl6OUorWX
e+RFyoBKBoPVj9NWO+z8TjOpEYm9aCAx3eUVYxmdg6FACUAGuw3+gS1xYVWpd3irNtz+aCk+uobO
IaAbQRx8LPRNh0YFdDJLRoFwCj8QMRd6cl7ouuab2SqQbDuasIWL6vz7rjDr+a7SAR4KI24ib5+O
5m/dQ0XnoC0rmnLBSEJmmemMcKSoRNc1TLOEWRc4rZHpzjFo8yegtzoUpKSOA1W15GUq2JGaCpyD
AB6UDgv+KsaZgr0avg==
--00000000000046872305f5579c25--
