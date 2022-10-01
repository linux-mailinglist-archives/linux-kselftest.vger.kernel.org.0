Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E491A5F199E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiJADeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiJADdT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:33:19 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0281A1E83
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:53 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id k14so3189550vkk.0
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MBhHhtXbDsiway1LMzlcELeGMzcNHFbcwEKs3wX9KOU=;
        b=ZyTfcD6N6nZOblaPyUHWbSCuIlll1U8i40v5SoHAsXrPxJGKbDSO54kPaUsKZs1sTL
         wsMjeX85MtLLpXdvA09Piz/qlKPW+V4zN4EzQgXIcM4EZAdZZHJEHKogbckZnj43Edw6
         0JYAbpztt6kkHH00R0hnP3i1fwrBj72kxiAKDmdzfJ7pek8j5eq/t1NflJS5WbBoFYF9
         6q5a0jkp9Tt9y4nPgRe8f9WhyfRZTJDJyzFQDYVZpaoApndf8trzqBsVK+rajyChUblr
         yHJMLn91L0QM2hov7Wo6lEiJmLhJ1tLXEA5KJgE46XL748I11a8WAarRmIAU5d6dx1Pn
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MBhHhtXbDsiway1LMzlcELeGMzcNHFbcwEKs3wX9KOU=;
        b=Kqzy4DdlTReT+dmj08erPBpnqkKLyHsd4VI3NvtONT6KceBQI5QO9+gXcA+sTk4Dhr
         UEKO5mFvIhY4r8OXOA+gM1ZG4Dl/dL0jBZpfK826ouT8cua71U6SQsC4bEsgw452JzeH
         hQmS44V8D3S99UCvJzg8FJPSD+61iEpdD/D0HdXKhH/A/9wyhnGqHvj5RaqJ/IFe+ri5
         FSC331eC5nD8cOD3jGMKcxQcbRo9hYZ88PJcZ+ZCTD72JPlHN6NtdAGkPHZcFdUxXPy6
         TUdR5vq7fm21jgTs9R4Kt/6hz2UsauRgAq10sXLYQ4v3aeuC6DMRgx0D4sZ1TCiYeuRr
         ipZw==
X-Gm-Message-State: ACrzQf20F4ouJZXR/9az/OjZPCO3d20/b5ZOEWpB+dKVmSpRHJWuvQ7z
        1WvqDccK7Y4BA3zbz9zJ5RrRXw3g5IGxsovvSL1V1w==
X-Google-Smtp-Source: AMsMyM6NpxUU2chI0LB/P8QrZ0DHJ/V99f8T0G+Bh/JVHDJbOQwqgc/Q9OXBv7BsPAzsUsRebH4mocCmGvKLb0WXjfQ=
X-Received: by 2002:a1f:20d0:0:b0:39e:befa:fb4b with SMTP id
 g199-20020a1f20d0000000b0039ebefafb4bmr5513369vkg.7.1664594811527; Fri, 30
 Sep 2022 20:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-3-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Oct 2022 11:26:40 +0800
Message-ID: <CABVgOSn3SupF_z84FghxX-yK-CLx_RQMkUxF_hGUw6a3w7h-7Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000073ca9705e9f0ae76"
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

--00000000000073ca9705e9f0ae76
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 8:26 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Context:
> Currently this macro's name, KUNIT_ASSERTION conflicts with the name of
> an enum whose values are {KUNIT_EXPECTATION, KUNIT_ASSERTION}.
>
> It's hard to think of a better name for the enum, so rename this macro.
> It's also a bit strange that the macro might do nothing depending on the
> boolean argument `pass`. Why not have callers check themselves?
>
> This patch:
> Moves the pass/fail checking into the callers of KUNIT_ASSERTION, so now
> we only call it when the check has failed.
> Then we rename the macro the _KUNIT_FAILED() to reflect the new
> semantics.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. I can't say the name _KUNIT_FAILED() feels perfect
to me, but I can't think of anything better, either. We've not used a
leading underscore for internal macros much thus far, as well, though
I've no personal objections to starting.

Regardless, let's get this in.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  include/kunit/test.h | 123 +++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 58 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 3476549106f7..fec437c8a2b7 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -475,30 +475,27 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                assert_format_t assert_format,
>                                const char *fmt, ...);
>
> -#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
> -       if (unlikely(!(pass))) {                                               \
> -               static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
> -               struct assert_class __assertion = INITIALIZER;                 \
> -               kunit_do_failed_assertion(test,                                \
> -                                         &__loc,                              \
> -                                         assert_type,                         \
> -                                         &__assertion.assert,                 \
> -                                         assert_format,                       \
> -                                         fmt,                                 \
> -                                         ##__VA_ARGS__);                      \
> -       }                                                                      \
> +#define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
> +       static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;               \
> +       struct assert_class __assertion = INITIALIZER;                         \
> +       kunit_do_failed_assertion(test,                                        \
> +                                 &__loc,                                      \
> +                                 assert_type,                                 \
> +                                 &__assertion.assert,                         \
> +                                 assert_format,                               \
> +                                 fmt,                                         \
> +                                 ##__VA_ARGS__);                              \
>  } while (0)
>
>
>  #define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)                     \
> -       KUNIT_ASSERTION(test,                                                  \
> -                       assert_type,                                           \
> -                       false,                                                 \
> -                       kunit_fail_assert,                                     \
> -                       kunit_fail_assert_format,                              \
> -                       {},                                                    \
> -                       fmt,                                                   \
> -                       ##__VA_ARGS__)
> +       _KUNIT_FAILED(test,                                                    \
> +                     assert_type,                                             \
> +                     kunit_fail_assert,                                       \
> +                     kunit_fail_assert_format,                                \
> +                     {},                                                      \
> +                     fmt,                                                     \
> +                     ##__VA_ARGS__)
>
>  /**
>   * KUNIT_FAIL() - Always causes a test to fail when evaluated.
> @@ -523,15 +520,19 @@ void kunit_do_failed_assertion(struct kunit *test,
>                               expected_true,                                   \
>                               fmt,                                             \
>                               ...)                                             \
> -       KUNIT_ASSERTION(test,                                                  \
> -                       assert_type,                                           \
> -                       !!(condition) == !!expected_true,                      \
> -                       kunit_unary_assert,                                    \
> -                       kunit_unary_assert_format,                             \
> -                       KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,             \
> -                                                      expected_true),         \
> -                       fmt,                                                   \
> -                       ##__VA_ARGS__)
> +do {                                                                          \
> +       if (likely(!!(condition) == !!expected_true))                          \
> +               break;                                                         \
> +                                                                              \
> +       _KUNIT_FAILED(test,                                                    \
> +                     assert_type,                                             \
> +                     kunit_unary_assert,                                      \
> +                     kunit_unary_assert_format,                               \
> +                     KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,               \
> +                                                    expected_true),           \
> +                     fmt,                                                     \
> +                     ##__VA_ARGS__);                                          \
> +} while (0)
>
>  #define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
>         KUNIT_UNARY_ASSERTION(test,                                            \
> @@ -581,16 +582,18 @@ do {                                                                             \
>                 .right_text = #right,                                          \
>         };                                                                     \
>                                                                                \
> -       KUNIT_ASSERTION(test,                                                  \
> -                       assert_type,                                           \
> -                       __left op __right,                                     \
> -                       assert_class,                                          \
> -                       format_func,                                           \
> -                       KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,               \
> -                                                       __left,                \
> -                                                       __right),              \
> -                       fmt,                                                   \
> -                       ##__VA_ARGS__);                                        \
> +       if (likely(__left op __right))                                         \
> +               break;                                                         \
> +                                                                              \
> +       _KUNIT_FAILED(test,                                                    \
> +                     assert_type,                                             \
> +                     assert_class,                                            \
> +                     format_func,                                             \
> +                     KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,                 \
> +                                                     __left,                  \
> +                                                     __right),                \
> +                     fmt,                                                     \
> +                     ##__VA_ARGS__);                                          \
>  } while (0)
>
>  #define KUNIT_BINARY_INT_ASSERTION(test,                                      \
> @@ -639,16 +642,19 @@ do {                                                                             \
>                 .right_text = #right,                                          \
>         };                                                                     \
>                                                                                \
> -       KUNIT_ASSERTION(test,                                                  \
> -                       assert_type,                                           \
> -                       strcmp(__left, __right) op 0,                          \
> -                       kunit_binary_str_assert,                               \
> -                       kunit_binary_str_assert_format,                        \
> -                       KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,               \
> -                                                       __left,                \
> -                                                       __right),              \
> -                       fmt,                                                   \
> -                       ##__VA_ARGS__);                                        \
> +       if (likely(strcmp(__left, __right) op 0))                              \
> +               break;                                                         \
> +                                                                              \
> +                                                                              \
> +       _KUNIT_FAILED(test,                                                    \
> +                     assert_type,                                             \
> +                     kunit_binary_str_assert,                                 \
> +                     kunit_binary_str_assert_format,                          \
> +                     KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,                 \
> +                                                     __left,                  \
> +                                                     __right),                \
> +                     fmt,                                                     \
> +                     ##__VA_ARGS__);                                          \
>  } while (0)
>
>  #define KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                         \
> @@ -659,15 +665,16 @@ do {                                                                             \
>  do {                                                                          \
>         const typeof(ptr) __ptr = (ptr);                                       \
>                                                                                \
> -       KUNIT_ASSERTION(test,                                                  \
> -                       assert_type,                                           \
> -                       !IS_ERR_OR_NULL(__ptr),                                \
> -                       kunit_ptr_not_err_assert,                              \
> -                       kunit_ptr_not_err_assert_format,                       \
> -                       KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,                    \
> -                                                     __ptr),                  \
> -                       fmt,                                                   \
> -                       ##__VA_ARGS__);                                        \
> +       if (!IS_ERR_OR_NULL(__ptr))                                            \
> +               break;                                                         \
> +                                                                              \
> +       _KUNIT_FAILED(test,                                                    \
> +                     assert_type,                                             \
> +                     kunit_ptr_not_err_assert,                                \
> +                     kunit_ptr_not_err_assert_format,                         \
> +                     KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr, __ptr),              \
> +                     fmt,                                                     \
> +                     ##__VA_ARGS__);                                          \
>  } while (0)
>
>  /**
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221001002638.2881842-3-dlatypov%40google.com.

--00000000000073ca9705e9f0ae76
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGH0uAg+eV8wUdHQOJ7
yfswDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjA2MjAw
MjAzNTNaFw0yMjEyMTcwMjAzNTNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv9aO5pJtu5ZPHSb99iASzp2mcnJtk
JIh8xsJ+fNj9OOm0B7Rbg2l0+F4c19b1DyIzz/DHXIX9Gc55kfd4TBzhITOJmB+WdbaWS8Lnr9gu
SVO8OISymO6uVA0Lmkfne3zV0TwRtFkEeff0+P+MqdaLutOmOcLQRp8eAzb/TNKToSROBYmBRcuA
hDOMCVZZozIJ7T4nHBjfOrR+nJ4mjBIDRnDucs4dazypyiYiHYLfedCxp8vldywHMsTxl59Ue9Yk
RVewDw3HWvWUIMbc+Y636UXdUn4axP1TXN0khUpexMoc5qCHxpBIE/AyeS4WPASlE8uVY9Qg8dT6
kJmeOT+ZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDyAvtuc
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD0
IgjX1rpOSXmta2Q1MFB5FdHqmXAkn4wLRl4zG7Q1ejAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMDEwMzI2NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJfPYbC3aehho2t0rbyiv
SmvAhS/BoSvIEpfAdOLs1p+hh3vGMDOuUjaxKZW4KCegvXA9nXLPFMlCx2D8nGx9fV83us/g6ON6
bEeR8Tcw+9UlAsdznR+99lUtMunOjmSIUEtA+OsvHAjAZuNIxzcUQ/24Rfeemit67SfXE8dYkzlf
/AEhRymjQxyzqzc1sjK8HknMjuluMHfiejQ7baTrVoNvNh/xsXJlzj6EKTYjpyxOwIp17ckiuzU1
IFqBldk8taZtd+oyyBPvHStsiBGWdIvOZKo8IbsJYIRD5j46jj0YrRSUhZbdNDLZFed8RYMvB/0n
aE0URjRniPZH1QLqsQ==
--00000000000073ca9705e9f0ae76--
