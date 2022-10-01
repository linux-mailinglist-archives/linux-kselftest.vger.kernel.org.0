Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552035F199B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiJADd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiJADcu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:32:50 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38223120E
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:46 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id b15so3174067vkp.2
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kGUBYqlK+mie3Yqwksx30erH3GgBkjXy+nhZ0lynKaQ=;
        b=nA6CGWyqxVuFdPaRBZj1uZugi5wg+blHaa3XKOwsTLQfzQSjA9h4d2FHPm9ZFS8+qk
         qHUZSF4WBncYT8SmpCFirN6sZKKpNZb2/VPdrMRGOnidkQkulpwwicQ6zKNMw+aOzuCX
         HXnXD2utjxSmCLffkLm2wJt1Y4rVC3ZWonJXhZoIhh/K7D0FZnh8phic4PdoJC2ihQ2m
         J9CeMQpnNgLYhxDFzGktE6oQYhqQ/6J9Bdmn7SSxChf5p8y2+Vj04Q95UJQ3Y5YiZuxJ
         LNnnBEQ3QxIfowamLwcj2ycOoKjh0KDoA+5P5lQV0liZBLa5CfWcHvxWL1n/KtnWYldp
         P0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kGUBYqlK+mie3Yqwksx30erH3GgBkjXy+nhZ0lynKaQ=;
        b=DfxePSAqXClQChcUZFwj3mapqRkQxH8LMX3M88ZH/mem0bm8qxryzSQQLrHyOK0ECc
         NZP5tmNg2lkOOcH2VzktsPevU5F9Xuk1OkDi7/VjA3J3t0qCqVKl7gKu3qVuplR4jB9z
         Ziq7J4xvMvqg3wHXkIoLx5Mp1eJ/KPVq7jd7/pusjFUXYZj7PBKHtCfceQ/Fvpq/U/R2
         DhaTcVnK2LuPwSgS9/YYmffSQ1TUSiIvPj9I7gLWogEN8g9snWtLFD5YpHwrbZ/LmW7M
         pQswfPruTy2fCVOOXwTxuaHje3iP9++aAGyLZUc73JO2Gg8LT4q87oQ94OWm7xfUXci1
         wGdg==
X-Gm-Message-State: ACrzQf1QGI9YhhQ7KbVy/3f2gf0M9vP8mfB3rlkUA1dSrvmEfOvy0KiP
        KU3K7tV8RUi3q6XT16Y7Oz1P9gaz3rIw67cEMBNPBQ==
X-Google-Smtp-Source: AMsMyM7N/kpjvd3PgF0HQbufyEvO+wxawm6EilaiP+Sm0RroTdNPwLUg0FdX7oUst1G8qyWvWhythX7K2F2jxiQ1cAs=
X-Received: by 2002:a1f:2f96:0:b0:3a2:8e31:b066 with SMTP id
 v144-20020a1f2f96000000b003a28e31b066mr5930506vkv.34.1664594805507; Fri, 30
 Sep 2022 20:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-2-dlatypov@google.com>
In-Reply-To: <20221001002638.2881842-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Oct 2022 11:26:34 +0800
Message-ID: <CABVgOS=VZ0NZ_xKrXg5SsiZQMq-_UxKiyEKj-LMKUM=TSNLN3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: remove format func from struct kunit_assert,
 get it to 0 bytes
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000019391805e9f0ae7a"
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

--00000000000019391805e9f0ae7a
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 8:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Each calll to a KUNIT_EXPECT_*() macro creates a local variable which
> contains a struct kunit_assert.
>
> Normally, we'd hope the compiler would be able to optimize this away,
> but we've seen cases where it hasn't, see
> https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/GbrMNej2BAAJ.
>
> In changes like commit 21957f90b28f ("kunit: split out part of
> kunit_assert into a static const"), we've moved more and more parts out
> of struct kunit_assert and its children types (kunit_binary_assert).
>
> This patch removes the final field and gets us to:
>   sizeof(struct kunit_assert) == 0
>   sizeof(struct kunit_binary_assert) == 24 (on UML x86_64).
>
> This also reduces the amount of macro plumbing going on at the cost of
> passing in one more arg to the base KUNIT_ASSERTION macro and
> kunit_do_failed_assertion().
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Very glad to see this finally happening: we've definitely still been
seeing these stack size warnings, so reducing the stack use is good

And as someone who has always been a little uneasy with the number of
nested macros, the simplification is also a big win.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  include/kunit/assert.h | 28 ++++++----------------------
>  include/kunit/test.h   | 17 +++++++++++------
>  lib/kunit/test.c       |  7 ++++---
>  3 files changed, 21 insertions(+), 31 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 4b52e12c2ae8..ace3de8d1ee7 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -42,16 +42,15 @@ struct kunit_loc {
>
>  /**
>   * struct kunit_assert - Data for printing a failed assertion or expectation.
> - * @format: a function which formats the data in this kunit_assert to a string.
>   *
>   * Represents a failed expectation/assertion. Contains all the data necessary to
>   * format a string to a user reporting the failure.
>   */
> -struct kunit_assert {
> -       void (*format)(const struct kunit_assert *assert,
> -                      const struct va_format *message,
> -                      struct string_stream *stream);
> -};
> +struct kunit_assert {};
> +
> +typedef void (*assert_format_t)(const struct kunit_assert *assert,
> +                               const struct va_format *message,
> +                               struct string_stream *stream);
>
>  void kunit_assert_prologue(const struct kunit_loc *loc,
>                            enum kunit_assert_type type,
> @@ -71,16 +70,6 @@ void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               const struct va_format *message,
>                               struct string_stream *stream);
>
> -/**
> - * KUNIT_INIT_FAIL_ASSERT_STRUCT - Initializer for &struct kunit_fail_assert.
> - *
> - * Initializes a &struct kunit_fail_assert. Intended to be used in
> - * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
> - */
> -#define KUNIT_INIT_FAIL_ASSERT_STRUCT {                                        \
> -       .assert = { .format = kunit_fail_assert_format },               \
> -}
> -
>  /**
>   * struct kunit_unary_assert - Represents a KUNIT_{EXPECT|ASSERT}_{TRUE|FALSE}
>   * @assert: The parent of this type.
> @@ -110,7 +99,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
>  #define KUNIT_INIT_UNARY_ASSERT_STRUCT(cond, expect_true) {                   \
> -       .assert = { .format = kunit_unary_assert_format },                     \
>         .condition = cond,                                                     \
>         .expected_true = expect_true                                           \
>  }
> @@ -145,7 +133,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>   * KUNIT_EXPECT_* and KUNIT_ASSERT_* macros.
>   */
>  #define KUNIT_INIT_PTR_NOT_ERR_STRUCT(txt, val) {                             \
> -       .assert = { .format = kunit_ptr_not_err_assert_format },               \
>         .text = txt,                                                           \
>         .value = val                                                           \
>  }
> @@ -190,7 +177,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   * KUNIT_INIT_BINARY_ASSERT_STRUCT() - Initializes a binary assert like
>   *     kunit_binary_assert, kunit_binary_ptr_assert, etc.
>   *
> - * @format_func: a function which formats the assert to a string.
>   * @text_: Pointer to a kunit_binary_assert_text.
>   * @left_val: The actual evaluated value of the expression in the left slot.
>   * @right_val: The actual evaluated value of the expression in the right slot.
> @@ -200,11 +186,9 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>   * fields but with different types for left_val/right_val.
>   * This is ultimately used by binary assertion macros like KUNIT_EXPECT_EQ, etc.
>   */
> -#define KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,                          \
> -                                       text_,                                 \
> +#define KUNIT_INIT_BINARY_ASSERT_STRUCT(text_,                                \
>                                         left_val,                              \
>                                         right_val) {                           \
> -       .assert = { .format = format_func },                                   \
>         .text = text_,                                                         \
>         .left_value = left_val,                                                \
>         .right_value = right_val                                               \
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 840a2c375065..3476549106f7 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -472,9 +472,10 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                const struct kunit_loc *loc,
>                                enum kunit_assert_type type,
>                                const struct kunit_assert *assert,
> +                              assert_format_t assert_format,
>                                const char *fmt, ...);
>
> -#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
> +#define KUNIT_ASSERTION(test, assert_type, pass, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
>         if (unlikely(!(pass))) {                                               \
>                 static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
>                 struct assert_class __assertion = INITIALIZER;                 \
> @@ -482,6 +483,7 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                           &__loc,                              \
>                                           assert_type,                         \
>                                           &__assertion.assert,                 \
> +                                         assert_format,                       \
>                                           fmt,                                 \
>                                           ##__VA_ARGS__);                      \
>         }                                                                      \
> @@ -493,7 +495,8 @@ void kunit_do_failed_assertion(struct kunit *test,
>                         assert_type,                                           \
>                         false,                                                 \
>                         kunit_fail_assert,                                     \
> -                       KUNIT_INIT_FAIL_ASSERT_STRUCT,                         \
> +                       kunit_fail_assert_format,                              \
> +                       {},                                                    \
>                         fmt,                                                   \
>                         ##__VA_ARGS__)
>
> @@ -524,6 +527,7 @@ void kunit_do_failed_assertion(struct kunit *test,
>                         assert_type,                                           \
>                         !!(condition) == !!expected_true,                      \
>                         kunit_unary_assert,                                    \
> +                       kunit_unary_assert_format,                             \
>                         KUNIT_INIT_UNARY_ASSERT_STRUCT(#condition,             \
>                                                        expected_true),         \
>                         fmt,                                                   \
> @@ -581,8 +585,8 @@ do {                                                                               \
>                         assert_type,                                           \
>                         __left op __right,                                     \
>                         assert_class,                                          \
> -                       KUNIT_INIT_BINARY_ASSERT_STRUCT(format_func,           \
> -                                                       &__text,               \
> +                       format_func,                                           \
> +                       KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,               \
>                                                         __left,                \
>                                                         __right),              \
>                         fmt,                                                   \
> @@ -639,8 +643,8 @@ do {                                                                               \
>                         assert_type,                                           \
>                         strcmp(__left, __right) op 0,                          \
>                         kunit_binary_str_assert,                               \
> -                       KUNIT_INIT_BINARY_ASSERT_STRUCT(kunit_binary_str_assert_format,\
> -                                                       &__text,               \
> +                       kunit_binary_str_assert_format,                        \
> +                       KUNIT_INIT_BINARY_ASSERT_STRUCT(&__text,               \
>                                                         __left,                \
>                                                         __right),              \
>                         fmt,                                                   \
> @@ -659,6 +663,7 @@ do {                                                                               \
>                         assert_type,                                           \
>                         !IS_ERR_OR_NULL(__ptr),                                \
>                         kunit_ptr_not_err_assert,                              \
> +                       kunit_ptr_not_err_assert_format,                       \
>                         KUNIT_INIT_PTR_NOT_ERR_STRUCT(#ptr,                    \
>                                                       __ptr),                  \
>                         fmt,                                                   \
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index b73d5bb5c473..53bf1793f915 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -247,7 +247,7 @@ static void kunit_print_string_stream(struct kunit *test,
>
>  static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>                        enum kunit_assert_type type, const struct kunit_assert *assert,
> -                      const struct va_format *message)
> +                      assert_format_t assert_format, const struct va_format *message)
>  {
>         struct string_stream *stream;
>
> @@ -263,7 +263,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>         }
>
>         kunit_assert_prologue(loc, type, stream);
> -       assert->format(assert, message, stream);
> +       assert_format(assert, message, stream);
>
>         kunit_print_string_stream(test, stream);
>
> @@ -287,6 +287,7 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                const struct kunit_loc *loc,
>                                enum kunit_assert_type type,
>                                const struct kunit_assert *assert,
> +                              assert_format_t assert_format,
>                                const char *fmt, ...)
>  {
>         va_list args;
> @@ -296,7 +297,7 @@ void kunit_do_failed_assertion(struct kunit *test,
>         message.fmt = fmt;
>         message.va = &args;
>
> -       kunit_fail(test, loc, type, assert, &message);
> +       kunit_fail(test, loc, type, assert, assert_format, &message);
>
>         va_end(args);
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

--00000000000019391805e9f0ae7a
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCb
6uL5NWq6un7oHLphi0xYeIUGMDHnotEfZMOa7ydVPjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMDEwMzI2NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHdlIMVrpwuZX8tYGpjPH
OIqE+KWNH3jIkOU+gK+IF8aBvLsX4J4X/OvSfkpHXaYK0+BHRi8X9qsFKR7AE4+tqlVJLnnUlbjc
nXF125pPJjRSfwcK3N1Z4Qjk2t4CIkafwfwkb4SydIYBcz3pcXm+UJVjQt1EZV13zpf8ejA2HZwg
/8jy6yXv24xf9PWp0mYvGdDcd71k5BvGreNlDkaoEUHK0ihyf+tIiNSo+Xf9iNuHdYEqvY4Lmsi5
YyrpN7/kyE7pbF8tLdHbD4NssjWA54xhc3rnpUGKMXMq5jFPd0ez3BmQbLby12WNknDjJQ2VoT8c
xzdx48kVkxk4PO8Xbw==
--00000000000019391805e9f0ae7a--
