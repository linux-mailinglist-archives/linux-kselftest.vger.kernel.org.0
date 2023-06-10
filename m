Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB20272AA45
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFJI3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFJI3e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 04:29:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978733A89
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f60ab57c8eso591e87.1
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686385770; x=1688977770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wB0smwUqFU7Sizb8C/ji33ky29+VcE7ZYqhhQUBN1Y=;
        b=EcVAIF/N5ptVf/hhpXSleAi+dAK3sfuMOj6U8uu+xRHY2TT1yaZLuw7Bb/Q1LY65h/
         2UN506kUwvlsNfe1BLCoqCPSBeW9B4BhYxOmz97EFz1b5nfixvtF6lm96au6YiVuJa7a
         fGG21b4XgZxjrwUDR6eVqvcNsvmRRWkQU85bVSiJlN3dI/Idb6hE1AODU5Cn5Z+iRdpc
         hb+U1q10+kWtG/HJwNVZP5MHdZgIPLsJgoErUplmbRqv+vIso+dmb3OTdKZWFaZOydSU
         CVfBScz9DRO3JiZmzXyyj3KDKwooFVm4TPUcYVIBjifMQU8sU9wWOuQYQ5h9w5OaBegY
         1gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686385770; x=1688977770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wB0smwUqFU7Sizb8C/ji33ky29+VcE7ZYqhhQUBN1Y=;
        b=aR0orgAWzAhoClSR8XJRcgGZM04epdmpx2BKKFStqPCjaPJg+lDbZIzKaToom9Ck8i
         b+8NtUAdAVotcScA58vlLaqTEOQgw2+S0ATmZ1C0WTJSRtg6eC5VGygLUCqotF+Tf1B9
         i6hNpCoPeyQLTHwiIjrqW4DPLb+FYLf06ZDakmmDAgN0dKcni5hT/eNlBt6JiQB6mRr0
         J6FAvqbd9NringEp42fZsg1Kppvw4mDHCEp8I3kXJh3zvfnRApx2rVtdyhCdzcZBvqn+
         MZuclap9H4dmlQmjS+oxMLkA1Cr7DMwuCFqAietMUK/wtkMmuKQGq23ino2dxa8XfL9K
         K16w==
X-Gm-Message-State: AC+VfDyj233BxF6XD2qZMKPqk1UKBIQuP+k9ZKQvtj4yKKJjx5xqpwGS
        BUcnO8qOLiuYlyAnPZO+NPCKWq6GgxRUC3yDPjL+i8q9NbEOCgWkSvU=
X-Google-Smtp-Source: ACHHUZ7xwV7/6oPG3+D1na+WwgxPJmThN3bgtHodu1x81iDpgJGYfqTEXdThqOKddEx0kkzYmSxfi/3EkOUwR7FklEw=
X-Received: by 2002:ac2:5ece:0:b0:4f1:21a2:901f with SMTP id
 d14-20020ac25ece000000b004f121a2901fmr14285lfq.3.1686385769631; Sat, 10 Jun
 2023 01:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-3-rmoar@google.com>
In-Reply-To: <20230610005149.1145665-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 10 Jun 2023 16:29:16 +0800
Message-ID: <CABVgOS=4ioKpNOh-hPGEv70LSVwFh2SC0BL_dK1pWZR3pLwrtQ@mail.gmail.com>
Subject: Re: [RFC v1 2/6] kunit: Add speed attribute
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c853de05fdc24870"
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

--000000000000c853de05fdc24870
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
>
> Add speed attribute to the test attribute API. This attribute will allow
> users to mark tests with a category of speed.
>
> Currently the categories of speed proposed are: fast, normal, slow, and
> very_slow. These are outlined in the enum kunit_speed. Note the speed
> attribute can also be left as unset and then, will act as the default which
> is "normal", during filtering.

Do we need both "fast" and "normal". KUnit tests are normally very
fast: I'm not sure there's a way to make them faster enough to make a
separate category here useful.

>
> Note speed is intended to be marked based on relative speeds rather than
> quantitative speeds of KUnit tests. This is because tests may run on
> various architectures at different speeds.

My rule of thumb here is that a test is slow if it takes more than a
"trivial" amount of time (<1s), regardless of the machine it's running
on.

While the actual speed taken varies a lot (the time_test_cases take ~3
seconds on most fast, modern machines, even under something like qemu,
but ~15 minutes on an old 486), it's the idea that a test is doing
some significant amount of work (loops over many thousands or millions
of entries, etc) that pretty comfortably divides these into "normal"
and "slow".

Most tests run very, very quickly on even very slow systems, as all
they're doing is checking the result of one or two trivial
calculations or functions.

> Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely a
> common use of the attributes API.

I'd ask if we need a KUNIT_CASE_VERY_SLOW() as well, but let's leave
that until we have something which uses it.


> Add an example of marking a slow test to kunit-example-test.c.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h           | 31 ++++++++++++++++++++++-
>  lib/kunit/attributes.c         | 45 +++++++++++++++++++++++++++++++++-
>  lib/kunit/kunit-example-test.c |  9 +++++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 1fc9155988e9..3d684723ae57 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -63,8 +63,26 @@ enum kunit_status {
>         KUNIT_SKIPPED,
>  };
>
> +/* Attribute struct/enum definitions */
> +
> +/*
> + * Speed Attribute is stored as an enum and separated into categories of
> + * speed: very_slowm, slow, normal, and fast. These speeds are relative
> + * to other KUnit tests.
> + */
> +enum kunit_speed {
> +       KUNIT_SPEED_UNSET,
> +       KUNIT_SPEED_VERY_SLOW,
> +       KUNIT_SPEED_SLOW,
> +       KUNIT_SPEED_NORMAL,
> +       KUNIT_SPEED_FAST,
> +       KUNIT_SPEED_MAX = KUNIT_SPEED_FAST,
> +};

Question: Does it make sense to have these in this order: slow ->
fast? I think it does ("speed>slow" seems more correct than
"speed<slow"), but it'd be the other way round if we wanted to call
this, e.g., size instead of speed.

That being said, if it went the other way, we could rely on the fact
that the default is fast, and not need a separate "unset" default...

> +
>  /* Holds attributes for each test case and suite */
> -struct kunit_attributes {};
> +struct kunit_attributes {
> +       enum kunit_speed speed;
> +};
>
>  /**
>   * struct kunit_case - represents an individual test case.
> @@ -150,6 +168,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>                 { .run_case = test_name, .name = #test_name,    \
>                   .attr = attributes }
>
> +/**
> + * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
> + * with the slow attribute
> + *
> + * @test_name: a reference to a test case function.
> + */
> +
> +#define KUNIT_CASE_SLOW(test_name)                     \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .attr.speed = KUNIT_SPEED_SLOW }
> +
>  /**
>   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
>   *
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index 0ea641be795f..e17889f94693 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -28,9 +28,52 @@ struct kunit_attr {
>         void *attr_default;
>  };
>
> +/* String Lists for enum Attributes */
> +
> +static const char * const speed_str_list[] = {"unset", "very_slow", "slow", "normal", "fast"};
> +
> +/* To String Methods */
> +
> +static const char *attr_enum_to_string(void *attr, const char * const str_list[], bool *to_free)
> +{
> +       long val = (long)attr;
> +
> +       *to_free = false;
> +       if (!val)
> +               return NULL;
> +       return str_list[val];
> +}
> +
> +static const char *attr_speed_to_string(void *attr, bool *to_free)
> +{
> +       return attr_enum_to_string(attr, speed_str_list, to_free);
> +}
> +
> +/* Get Attribute Methods */
> +
> +static void *attr_speed_get(void *test_or_suite, bool is_test)
> +{
> +       struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> +       struct kunit_case *test = is_test ? test_or_suite : NULL;
> +
> +       if (test)
> +               return ((void *) test->attr.speed);
> +       else
> +               return ((void *) suite->attr.speed);
> +}
> +
> +/* Attribute Struct Definitions */
> +
> +static const struct kunit_attr speed_attr = {
> +       .name = "speed",
> +       .get_attr = attr_speed_get,
> +       .to_string = attr_speed_to_string,
> +       .attr_default = (void *)KUNIT_SPEED_NORMAL,
> +};
> +
>  /* List of all Test Attributes */
>
> -static struct kunit_attr kunit_attr_list[1] = {};
> +static struct kunit_attr kunit_attr_list[1] = {speed_attr};

Nit: Can we remove the hardcoded [1] here, and let the compiler do this for us?

>
>  /* Helper Functions to Access Attributes */
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index b69b689ea850..01a769f35e1d 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -220,6 +220,14 @@ static void example_params_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
>  }
>
> +/*
> + * This test should always pass. Can be used to practice filtering attributes.
> + */
> +static void example_slow_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> +}

Would we want to actually make this test slow? e.g. introduce a delay
or a big loop or something.
Probably not (I think it'd be more irritating than illuminating), but
maybe worth thinking of.


> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -237,6 +245,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
>
> --
> 2.41.0.162.gfafddb0af9-goog
>

--000000000000c853de05fdc24870
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBF
8IQhY013OD8bWOI2XWJaqOz5YQ3EMQkAKFhZTagc6jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwODI5MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANicNQCr681PHFiJ+TUe7
iFR/g7slZ8pQQZGBN1WMV5lMxiAe4AQ/2WlVb04xmfVfd/dAc5xS2tpkyOU+dd/SXDJqXhnswKbn
CabMYCBckUFnfNP+uIdxffEITZ8mvWSLCaJqBEXOCVZ0KWOQ3LVOVRvPoSbkN1SmbxLbJiQUtLBD
vwwhhvJQlWUcB2aGqZRctCbc25yMzvmZr2kavtCfrEUmFICinA3WsQnQaqqZaTvKwLdYFbgrYXjW
DrCMlzrdNQyJsXbLox5WwRwxoMgQ44i3sYZPdPnpGizap++JNw9Zmk5zcLz9dgrI41ZbHrKT2C9/
0kwa7SIynzfUjxM+Vw==
--000000000000c853de05fdc24870--
