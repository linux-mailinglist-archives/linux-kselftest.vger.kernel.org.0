Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7556B5F199F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiJADeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiJADdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:33:20 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D11A9A6C
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:59 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id k9so3168337vke.4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=et9LiRvBfdcBWCV8xVR77mU+ae2l2VwrnqFsBVVoG1o=;
        b=bWIMKNSUrpBzo0M0jNR+yayktcoO8f2efmfmFmBEkf8hnkhc7/U2Ut6EVfoyyylAqH
         /jJpw17cSm5ap08JyWQ7jsrfa5bq5e88ZbAv6oto8aw2ZEqXTYdCZvasr3W55UEiU3z/
         dNkjLNi9xmSyojPlvj3j4zKStiChwFJBzSKt0kAu9XUUTbk7O8BLof9RMqwjDIDhodFS
         oqUwQHn2BfqV11pvw9ssDNx0oqZcaOUQwwdzs3iDEzEvnet3sUbQzaG968nIlaB4lqta
         hq/dYKmU0s7sP9BcXtK9BNUfEdbT5XL4eWQ3Yiriw/eJFHJe6VfcsCO9Q0FIDiQESwzV
         CTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=et9LiRvBfdcBWCV8xVR77mU+ae2l2VwrnqFsBVVoG1o=;
        b=RWxaHEjuI7X/9b2m9SEB/F/wKfR6n3pZ2K5XbmL2/tDbQMsvouswD0j7fZUHnw0QXz
         7rNKeblUM3gt8u+bBRTOIopPraFGNvF7FKs1qSmgyOkHcuK4d79qCYukcpSPQ46BzCeR
         YNSdd+epKA31t8j9mV1lKuHVEM0/8FUq/9O5+IpDpbiPH23FcC0yRJknV7xyvKtlXVqc
         ixMowGqgVSp/vmI/j8N67A1cGnCgk/f0emPLVAmUVKl6OtVv2R82FrLUqHoy6SXRNhjj
         4B03GggdPu8xUbsT65DNA3jMl4PDVqBe1q8OwPjv/HCX4znht+aprbhV4nodYghNZQ1F
         A8dg==
X-Gm-Message-State: ACrzQf1yogR8lsBqs6VOTJH5JaZTRgHV0G7FnINJi7fxDuH9aAuJ/iiH
        NRWdtVgK92PaoJcMk9eGMwVMh7aplmVbEk7jsGLBnA==
X-Google-Smtp-Source: AMsMyM55m9YyPy17rp3FaDs3x+K1e22KHLG5Tg1IUWuk9Gz/H4ypX30srsmO1I3sdJosTOSmmGVmbWMRScBMdR1ujEQ=
X-Received: by 2002:a1f:a7ca:0:b0:3a2:cb7e:65a1 with SMTP id
 q193-20020a1fa7ca000000b003a2cb7e65a1mr5995677vke.4.1664594817957; Fri, 30
 Sep 2022 20:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-4-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Oct 2022 11:26:46 +0800
Message-ID: <CABVgOSnunybuq-G5hXA-tms5nUwwEWwPpHrK=zgRfdzC6Y_wuQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d697f905e9f0aeaf"
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

--000000000000d697f905e9f0aeaf
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 8:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> These macros exist because passing an initializer list to other macros
> is hard.
>
> The goal of these macros is to generate a line like
>   struct $ASSERT_TYPE __assertion = $APPROPRIATE_INITIALIZER;
> e.g.
>   struct kunit_unary_assertion __assertion = {
>           .condition = "foo()",
>           .expected_true = true
>   };
>
> But the challenge is you can't pass `{.condition=..., .expect_true=...}`
> as a macro argument, since the comma means you're actually passing two
> arguments, `{.condition=...` and `.expect_true=....}`.
> So we'd made custom macros for each different initializer-list shape.
>
> But we can work around this with the following generic macro
>   #define KUNIT_INIT_ASSERT(initializers...) { initializers }
>
> Note: this has the downside that we have to rename some macros arguments
> to not conflict with the struct field names (e.g. `expected_true`).
> It's a bit gross, but probably worth reducing the # of macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I agree with you on both fronts here: this is 'a bit gross', and is
also 'worth it'.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/assert.h | 48 ------------------------------------------
>  include/kunit/test.h   | 27 +++++++++++++-----------
>  2 files changed, 15 insertions(+), 60 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index ace3de8d1ee7..01b191fa17c3 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -90,19 +90,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>                                const struct va_format *message,
>                                struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_UNARY_ASSERT_STRUCT() - Initializes &struct kunit_unary_assert.
> - * @cond: A string representation of the expression asserted true or false.
> - * @expect_true: True if of type KUNIT_{EXPECT|ASSERT}_TRUE, false otherwise.
> - *
> - * Initializes a &struct kunit_unary_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> - */
> -#define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {                   \
> -       .condition = cond,                                                     \
> -       .expected_true = expect_true                                           \
> -}
> -
>  /**
>   * struct kunit_ptr_not_err_assert - An expectation/assertion that a pointer is
>   *     not NULL and not a -errno.
> @@ -123,20 +110,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>                                      const struct va_format *message,
>                                      struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_PTR_NOT_ERR_ASSERT_STRUCT() - Initializes a
> - *     &struct kunit_ptr_not_err_assert.
> - * @txt: A string representation of the expression passed to the expectation.
> - * @val: The actual evaluated pointer value of the expression.
> - *
> - * Initializes a &struct kunit_ptr_not_err_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> - */
> -#define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {                             \
> -       .text = txt,                                                           \
> -       .value = val                                                           \
> -}
> -
>  /**
>   * struct kunit_binary_assert_text - holds strings for &struct
>   *     kunit_binary_assert and friends to try and make the structs smaller.
> @@ -173,27 +146,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                 const struct va_format *message,
>                                 struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
> - *     kunit_binary_assert, kunit_binary_ptr_assert, etc.
> - *
> - * @text_: Pointer to a kunit_binary_assert_text.
> - * @left_val: The actual evaluated value of the expression in the left slot.
> - * @right_val: The actual evaluated value of the expression in the right slot.
> - *
> - * Initializes a binary assert like kunit_binary_assert,
> - * kunit_binary_ptr_assert, etc. This relies on these structs having the same
> - * fields but with different types for left_val/right_val.
> - * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
> - */
> -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(text_,                                \
> -                                       left_val,                              \
> -                                       right_val) {                           \
> -       .text = text_,                                                         \
> -       .left_value = left_val,                                                \
> -       .right_value = right_val                                               \
> -}
> -
>  /**
>   * struct kunit_binary_ptr_assert - An expectation/assertion that compares two
>   *     pointer values (for example, KUNIT_EXPECT_PTR_EQ(test, foo, bar)).
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index fec437c8a2b7..e49348bbc6ee 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -514,22 +514,25 @@ void kunit_do_failed_assertion(struct kunit *test,
>                              fmt,                                              \
>                              ##__VA_ARGS__)
>
> +/* Helper to safely pass around an initializer list to other macros. */
> +#define KUNIT_INIT_ASSERT(initializers...) { initializers }
> +
>  #define KUNIT_UNARY_ASSERTION(test,                                           \
>                               assert_type,                                     \
> -                             condition,                                       \
> -                             expected_true,                                   \
> +                             condition_,                                      \
> +                             expected_true_,                                  \
>                               fmt,                                             \
>                               ...)                                             \
>  do {                                                                          \
> -       if (likely(!!(condition) == !!expected_true))                          \
> +       if (likely(!!(condition_) == !!expected_true_))                        \
>                 break;                                                         \
>                                                                                \
>         _KUNIT_FAILED(test,                                                    \
>                       assert_type,                                             \
>                       kunit_unary_assert,                                      \
>                       kunit_unary_assert_format,                               \
> -                     KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,               \
> -                                                    expected_true),           \
> +                     KUNIT_INIT_ASSERT(.condition = #condition_,              \
> +                                       .expected_true = expected_true_),      \
>                       fmt,                                                     \
>                       ##__VA_ARGS__);                                          \
>  } while (0)
> @@ -589,9 +592,9 @@ do {                                                                               \
>                       assert_type,                                             \
>                       assert_class,                                            \
>                       format_func,                                             \
> -                     KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,                 \
> -                                                     __left,                  \
> -                                                     __right),                \
> +                     KUNIT_INIT_ASSERT(.text = &__text,                       \
> +                                       .left_value = __left,                  \
> +                                       .right_value = __right),               \
>                       fmt,                                                     \
>                       ##__VA_ARGS__);                                          \
>  } while (0)
> @@ -650,9 +653,9 @@ do {                                                                               \
>                       assert_type,                                             \
>                       kunit_binary_str_assert,                                 \
>                       kunit_binary_str_assert_format,                          \
> -                     KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,                 \
> -                                                     __left,                  \
> -                                                     __right),                \
> +                     KUNIT_INIT_ASSERT(.text = &__text,                       \
> +                                       .left_value = __left,                  \
> +                                       .right_value = __right),               \
>                       fmt,                                                     \
>                       ##__VA_ARGS__);                                          \
>  } while (0)
> @@ -672,7 +675,7 @@ do {                                                                               \
>                       assert_type,                                             \
>                       kunit_ptr_not_err_assert,                                \
>                       kunit_ptr_not_err_assert_format,                         \
> -                     KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr, __ptr),              \
> +                     KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
>                       fmt,                                                     \
>                       ##__VA_ARGS__);                                          \
>  } while (0)
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

--000000000000d697f905e9f0aeaf
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBY
zU9yue4nhOPKfFhWtL2iie/vzsTkBSod31jvwJ6S3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMDEwMzI2NThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkLKdFsoc3/P7uRDCUOP+
zHJmOhpMRco0H89lEq90Sax40SS55upo2rnqAJKFNCvOI2isBTLnZ56NFH7FrSMX2LZtLX3YzfAA
rshkiESJOadeAIG4vs61EbNizjj5AewFXe/nmYvw9EP32fiqRr9PAme6f0gvUpZR2mfNQlxZGF0b
QBJ/4tPvtrQNv+PBmzvHfOJkt5m8DLhYbNkJNfYFqY/cdfQ6sx/+D2xevmnefzYLpog3ahXgf/lJ
RVS0oCOitQfyj3M3jS4AqA5/HtI/g9C/2/l+xXIzeSkLaoM8Zl+PkXdSolVlB+9x5QBEicNeiyVn
VrKSBRQG0sujMcK/OA==
--000000000000d697f905e9f0aeaf--
