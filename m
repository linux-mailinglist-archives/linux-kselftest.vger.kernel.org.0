Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601607B3F8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 10:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjI3I6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Sep 2023 04:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3I6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Sep 2023 04:58:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1441A4
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Sep 2023 01:58:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502f29ed596so2355e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Sep 2023 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696064323; x=1696669123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3HZw8pQQX9v/v+10wsqTg4XPA7R57fH2Oo8wDB0Z7M=;
        b=2WiUUhMvxE+XRYc7wsEEL2tMLvdwuDYsNqzj7vp8v+TP9ZdYm+ZX3ZvpW2Zab/A83R
         reQYtZeLDlfBOp2ah7Gsew6KgXF8MiKnnCRbAPTA3kRWbcnApvhJgQWuZIZrNzKulNur
         ZPWb78u/HJ/U6CbE+0y9r9KQs8BRf86lKNjU17g82tbnRdxRU9kDbaTxd2Hf+exUp7HY
         bLCWVQ37RfPujUqRyo1hdDqoPV61iaUSdyLkliDxt+2cLyzNlixnFoMSD/lRZJMyS5pN
         mD7Plb8exDTVao8IH8T/2hr1rVqffb9IGc0b7aSm6z9qDaBwmVvAsBxBf8sfViL3Wk/p
         Z9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064323; x=1696669123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3HZw8pQQX9v/v+10wsqTg4XPA7R57fH2Oo8wDB0Z7M=;
        b=JeOdQHl0DxkU7FVUL95HvUQiZ5vh9/7cTIuQnXLRKnqgjzAk/T7O6ESMoHffu9noJY
         9hpxioZjlZkglFu7IC1wFKIHqj7DQqUi6pVMU1rrcb/gUOn/GMBoi1u4T7xK9x20E179
         dXeVjw+54kDz/U0JlfAG51Zw3OD0p1UWYdVqaZKlYqfx65ACGR7UyVnuaY26PtNOLQrP
         Xf/VsST/U5FptYwm5uAre9Borv2etHZaEfV8CDBJ9sI1EvwkWNevsKkv3CSMEVsXOUyK
         7OFCO5QcX4HLwNclD02/Uh18n3xf7toQFwfeVRVYXJ4XNt2c9yj+rOVliQXbdrqW7Xic
         SFdg==
X-Gm-Message-State: AOJu0Yx5kUNpOzg5lDQDH3WzTyVwtJqf+ddhi1MRNDd5Dg0flzph/n7j
        vkuNu0i+/szEVYiCsD2IfiiAo5X9VidJVvYjKNkZHw==
X-Google-Smtp-Source: AGHT+IFxhb39q4JBTZZ3hg7MrAoivdSyjGobcv0TY4MZmG6o6DCJs0XGCPMuPEZv1M9HoiZyOiGUBSSyb1wdSlYNozo=
X-Received: by 2002:ac2:46cc:0:b0:501:b029:1a47 with SMTP id
 p12-20020ac246cc000000b00501b0291a47mr7588lfo.1.1696064322589; Sat, 30 Sep
 2023 01:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230926220208.1423-1-michal.wajdeczko@intel.com>
In-Reply-To: <20230926220208.1423-1-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 30 Sep 2023 16:58:28 +0800
Message-ID: <CABVgOSkYSCDeNDqkvFR9nsBc+DeWkHZ1rrq4X6=B2ZZGZdN86w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Add param generator macro for zero terminated arrays
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007f91c206068fbf89"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000007f91c206068fbf89
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Sept 2023 at 06:02, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> The existing macro KUNIT_ARRAY_PARAM can produce parameter
> generator function but only when we fully know the definition
> of the array. However, there might be cases where we would like
> to generate test params based on externaly defined array, which
> is defined as zero-terminated array, like pci_driver.id_table.

Hmm... I like the idea of this, but am a little wary of dealing with
zero-terminated arrays in a generic fashion. Some cases (pointers,
where we can just != NULL) are obvious,
but we could hit inconsistencies with things like padding, as things
like pci_driver.id_table seem to mostly be iterated over with things
like:
while (ids->vendor || ids->subvendor || ids->class_mask)

which not only ignores the padding, but also half of the fields. So
there may be a consistency issue there.

Though I suspect it's not likely to cause issues in practice.

Thoughts?
-- David
>
> Add helper macro KUNIT_ZERO_ARRAY_PARAM that can work with zero
> terminated arrays and provide example how to use it.
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>
> [ ] Starting KUnit Kernel (1/1)...
> [ ] ============================================================
> [ ] ========================= example  =========================
> [ ] =================== example_params_test  ===================
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] [SKIPPED] example value 0
> [ ] =============== [PASSED] example_params_test ===============
> [ ] =================== example_params_test  ===================
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =============== [PASSED] example_params_test ===============
> [ ] ===================== [PASSED] example =====================
> [ ] ============================================================
> [ ] Testing complete. Ran 7 tests: passed: 4, skipped: 3
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h           | 22 ++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c |  2 ++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..280113ceb6a6 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1514,6 +1514,28 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: zero terminated array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use default
> + *
> + * Define function @name_gen_params which uses zero terminated @array to generate parameters.
> + */
> +#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)                                          \
> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       {                                                                                       \
> +               typeof((array)[0]) *__prev = prev;                                              \
> +               typeof(__prev) __next = __prev ? __prev + 1 : (array);                          \
> +               void (*__get_desc)(typeof(__next), char *) = get_desc;                          \
> +               for (; memchr_inv(__next, 0, sizeof(*__next)); __prev = __next++) {             \

Are there any places where this might interact awkwardly with padding?
I _think_ it should be okay (variables with static lifetimes should
have padding initialised to zero), but there could be a case I'm
missing.


> +                       if (__get_desc)                                                         \
> +                               __get_desc(__next, desc);                                       \
> +                       return __next;                                                          \
> +               }                                                                               \
> +               return NULL;                                                                    \
> +       }
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 6bb5c2ef6696..ad9ebcfd513e 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -202,6 +202,7 @@ static void example_param_get_desc(const struct example_param *p, char *desc)
>  }
>
>  KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
> +KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param_get_desc);
>
>  /*
>   * This test shows the use of params.
> @@ -246,6 +247,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_all_expect_macros_test),
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.25.1
>

--0000000000007f91c206068fbf89
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHOBX7j6YmdTMbtcPLp
3a4wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA4MTUw
MjQyNDNaFw0yNDAyMTEwMjQyNDNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnYKS3ueVXUlVatkXVQgk8pbgZH4/s
KBKSGW9Z8e4hylAI35vqFf5f5D4U5KhUYUyG0+AYhurwEiUyZUhGcLqRNmSroohx9nbZjXDXjkVV
LXBAr7xaCU3DDQcA1SaxmALxBC7u4zlcVHfUKope2JNJ2xn5kU0Z/kr01tZuJD5/jn+2hp68jdym
tbFd3zzOJmtG6hb4ULJNXSi1qkjtZp6SyDLEsliQGRuI5AIha7GQPeSNsFmIpi+V5UxhrznuAv0y
Uxd27MtO+/mgSMpLmUb4vuSjy2zuftatzVYvFG00pfHldrnJ1od+kW8lAl6gyahVgMp+j3GAlO2M
oGCkihK9AgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJO3Y8Jq
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBD
6FapkH0ULofEkxte3BMcwbgBqSmv76ucG50GMNcGTTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MzAwODU4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbD+tlU3C47DQ9d8CAlF9
X9CEPsdlIEF6x3aGipakxqV9vGt12K0/1odIsLnnNROxYgheVh2hIzM9iB2udnNTDVM4GLYXfa6G
GP1GuIhVmobasyL4xQFyp8bXZriHkg70VIS4/dFEUawYlIE8/JWtvntOC1Truu9HTkrlM6EDyYZm
2fOVqU4b15+rphnVca24drkRKik4OevktWd31aCjKV5a2kSmRD2x/a3N7Vo3LxcS7srMpBiKt4yi
oIGio04oNWublpMomxql4WqzfgJnzWM33E7boxPDWYuekFdP/sMsHucNA7pIcNllHb/wgvuis7q8
aME2I0s7+Kl/E/aSBA==
--0000000000007f91c206068fbf89--
