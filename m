Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0B757573
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGRHjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGRHjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:39:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C8210E2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so63875e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689665948; x=1692257948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEaRFoNIzIYr+GOnVlsZXUdns3iDoamWgo35J0pK7J8=;
        b=nGZ3Y26MVkcBzvpqXc8s2+fJAcwKh+rl5mjNYv2GuMgyiB3iLtgSDrPa5EZwo75fF1
         7ZT+wAuNb25Pb+bwltsgTsbmve4QudoGmOClRsaDa7mXAcZdGbaa3W7RyzJd2lsagD3t
         DlNasUzt8VCUc1luBFXdujWVZ6B6CXqroDBOi2c0A5/QZLuf14qlkfntU4d8hz71VCpJ
         A+RxGUAVxknrg05LcNKkHC1Q8dRghgqhBcUYD5zAtRWgf01ybCyI9eQn+dQgBQz3oY8r
         CKrwiP1e+shDcDKhcgMYRSMwFgVDXstL8zDy445ff+H5hddNJnIk/GuH35ANMHvUbSWA
         hriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665948; x=1692257948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEaRFoNIzIYr+GOnVlsZXUdns3iDoamWgo35J0pK7J8=;
        b=P1KMFh3oiynLjt2/tqFKIPOGo0yeWzCKjyo5UR+hRtoW68TVIpAdCKUuWIuQOpMkBZ
         WhqzYQkuOYOfjcOvpyBMgOUxZQ1Fp+DF8K3IbqnYUcbCu1xpKt6Y936DBnaFNFQoNsaR
         Eg3BhrZUBefxJstdXjeI7CR0t9UvaroJhEVePM+0aEo0DLg3opR96CC/HNZ0eGb0eRu7
         sbbE53RZRI9pQmGfVU0xr2p46hDGKaKtfyTPXU/w3xMPUet+ziZ2xbYip5TpMz9YRsrb
         fPYCa4av0WG2S3zZXKaov50ipv2yKmQXo3TAMslwA4xKSfOUasr/muWlDTSitt3sDIU+
         XQTg==
X-Gm-Message-State: ABy/qLba+nqIRcObADO3dWiYN2M4MW4WOgNDPANbgzjSiBolnaNh+62y
        TDIVTM5a0oTAFfEa8rbpjKPj29uAQeLFPUB/j4OkCw==
X-Google-Smtp-Source: APBJJlFh+F5pi/vlK1j6W4Hav2rgnJ1VKxZthWde2C4Gx765P/h+svBkGLL5/u9hb0kJWFGsyFHd2vOQidqOtMc065U=
X-Received: by 2002:a05:600c:3ba8:b0:3f1:6fe9:4a95 with SMTP id
 n40-20020a05600c3ba800b003f16fe94a95mr73257wms.4.1689665948562; Tue, 18 Jul
 2023 00:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-3-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 15:38:57 +0800
Message-ID: <CABVgOS=ttFomNVdsKAY1FZCuzi46vii=ESdGU3VeYs-pRfoPNA@mail.gmail.com>
Subject: Re: [RFC v2 2/9] kunit: Add speed attribute
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ace7990600be0280"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ace7990600be0280
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
>
> Add speed attribute to the test attribute API. This attribute will allow
> users to mark tests with a category of speed.
>
> Currently the categories of speed proposed are: normal, slow, and very_slow
> (outlined in enum kunit_speed). These are outlined in the enum kunit_speed.
>
> The assumed default speed for tests is "normal". This indicates that the
> test takes a relatively trivial amount of time (less than 1 second),
> regardless of the machine it is running on. Any test slower than this could
> be marked as "slow" or "very_slow".
>
> Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely a
> common use of the attributes API.
>
> Add an example of marking a slow test to kunit-example-test.c.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good.

Reviewed-by: David Gow <davidgow@google.com>

>
> Changes since v1:
> - Remove the "fast" category of speed.
>
>  include/kunit/test.h           | 30 +++++++++++++++++++++-
>  lib/kunit/attributes.c         | 46 +++++++++++++++++++++++++++++++++-
>  lib/kunit/kunit-example-test.c |  9 +++++++
>  3 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 1fc9155988e9..c255c98a58f7 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -63,8 +63,25 @@ enum kunit_status {
>         KUNIT_SKIPPED,
>  };
>
> +/* Attribute struct/enum definitions */
> +
> +/*
> + * Speed Attribute is stored as an enum and separated into categories of
> + * speed: very_slowm, slow, normal, and fast. These speeds are relative

Nit: we only have very_slow, slow & normal now.

> + * to other KUnit tests.
> + */
> +enum kunit_speed {
> +       KUNIT_SPEED_UNSET,
> +       KUNIT_SPEED_VERY_SLOW,
> +       KUNIT_SPEED_SLOW,
> +       KUNIT_SPEED_NORMAL,
> +       KUNIT_SPEED_MAX = KUNIT_SPEED_NORMAL,
> +};

A part of me feels that we could get away with reversing the order of
this and having KUNIT_SPEED_NORMAL == 0. (Possibly reversing the
comparisons in the filtering, too.)

That's probably not worth the added complexity though. Either way,
maybe add a note that "UNSET" == "NORMAL".


> +
>  /* Holds attributes for each test case and suite */
> -struct kunit_attributes {};
> +struct kunit_attributes {
> +       enum kunit_speed speed;
> +};
>
>  /**
>   * struct kunit_case - represents an individual test case.
> @@ -150,6 +167,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
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
> index 9bda5a5f4030..e97096dbb3b1 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -40,9 +40,53 @@ struct kunit_attr {
>         enum print_ops print;
>  };
>
> +/* String Lists for enum Attributes */
> +
> +static const char * const speed_str_list[] = {"unset", "very_slow", "slow", "normal"};
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
> +       .print = PRINT_ALWAYS,
> +};
> +
>  /* List of all Test Attributes */
>
> -static struct kunit_attr kunit_attr_list[] = {};
> +static struct kunit_attr kunit_attr_list[] = {speed_attr};
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
> 2.41.0.255.g8b1d071c50-goog
>

--000000000000ace7990600be0280
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCy
y9kKGFalWU86QBSLSasb6glqxQK5kOL1bvIM9Y+D4jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwNzM5MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAUsExTigoilV/Ym4hQfly
0NI7npe0wsYaKUSc4WCKpJ6Uyxym7y4S3J8Z9bG+fxyO940fyAvMz0zKJsr8FqH5DjsiT/tmixWb
5jXaHBbr6NjIRUPKdX7e89XkqXxMVqXEV5yHiCvaZNskpNvBYLy+qlU9T2DgkGRdOpEvupor6qHn
RBqzQrGcbsFLwRiNx8f5nZ5NYxHI3tJDj9XD1QcIowvUVpC7iqxGiIPNnwpELDinwqJDYI3XLL27
cSy2ce0iQiXtPJqlcxC65T1H2McVpRyBMVRC0QIL2BjKq9C9mFCDWZncUQit1nuaRAeCIVfCNJRY
lt1pA0Mj/bEZ9ehPkg==
--000000000000ace7990600be0280--
