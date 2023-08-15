Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79C77CA49
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbjHOJSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjHOJSI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:18:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F872D46
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so53575e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692091026; x=1692695826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qug5S17714MO0uPqBT/Puf5x8YeprFiKveXZAH4nUik=;
        b=wr/NnU+tCpSgCyDYbBpWTaNiNfzDsYcUiE7iOvIYfQF5Nlp75VSwcUpRp1DOcPW7Or
         tMtHnxozjzdchFVJyBJDvHoIG8fWHZHBDsTGScNLA+mouvrIF45OW5wW7fRe++EGGkIi
         GrbyWl4aNsxEVOaE+TajZ//D3sYYGZ/2YFq5515uEcNeCLeQNSKmgp/0SUgntnR1qCf9
         O53doaHOesoXUzHFlMTjxKzjBVRrREPW9cumuOPBqmYbRmumS+oy4JL0GC1jcbjP9sfM
         T1SgFAp72OtXuVE3jnXfJNLEJPPNkJvEgOLPzSbgeD6XB2r85QyQVTiCsK3jErSJcGHq
         +zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091026; x=1692695826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qug5S17714MO0uPqBT/Puf5x8YeprFiKveXZAH4nUik=;
        b=Fpe6JPj95e793357nKQQvtbPyaXP338x2vjkUN8VX+j8zXOnvGK8U7sDnmb/aKzvUc
         IWyOqa4/odvHoKgkSWLwdteh9xIjSQ6qDJH7vDbdWPyL8IxowvdYRgmBKrLeJuPtOCpC
         dBSdm3Fu27Wm4T9BqChLVdJ9FPAAvsQA0km3k8T9E5VzIpcylGtmQWgrNz0782yxQQyy
         cIRcgFNgNz/Qwx+H39xkmeQy9j4qZcltzY19uFn3aYo+mMjBmgr2gO+A+4IcLgb25ZjE
         6VXtJlac70/M/A8WCXtBF3zU3H4RY2jBWNSON45osT3oQ37bpaAnYqLQKZBvTt3zghJm
         BkHw==
X-Gm-Message-State: AOJu0Yw6yar2bxOp/PXOCAq/YArz7mXrJE6bZ08dZi9LWoqW2DgdtlN5
        ggLapsxcuVGma7s0/WIUf9pkme7wSAArxR0zcA4asg==
X-Google-Smtp-Source: AGHT+IE/m4UU74CPHkuRcQ47gN7+1Vxpi/zYYRaLMf9wSBtUKMfHhjLQ0UDVGfPWE9QuK0KZjICnuK6CJaO1dx7raA0=
X-Received: by 2002:a05:600c:3590:b0:3fd:e15:41e3 with SMTP id
 p16-20020a05600c359000b003fd0e1541e3mr388957wmq.2.1692091026626; Tue, 15 Aug
 2023 02:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-9-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-9-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:16:55 +0800
Message-ID: <CABVgOS==iS3oADLyz96U56vBHvYt2Kwx4Yr6reLWC62jDn9M5A@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] kunit: string-stream: Add test for freeing
 resource-managed string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000095ee9a0602f2a4f3"
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

--00000000000095ee9a0602f2a4f3
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> string_stream_resource_free_test() allocates a resource-managed
> string_stream and tests that raw_free_string_stream() is called when
> the test resources are cleaned up.
>
> string_stream_init_test() is extended to test allocating a
> string_stream that is not resource-managed.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Glad to see this tested. It's nice to see the static_stub being useful
here, too.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream-test.c | 117 ++++++++++++++++++++++++++++++++-
>  lib/kunit/string-stream.c      |   3 +
>  2 files changed, 119 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 437aa4b3179d..05bfade2bd8a 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -6,16 +6,27 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <linux/slab.h>
>
>  #include "string-stream.h"
>
> +struct string_stream_test_priv {
> +       struct string_stream *raw_stream;
> +
> +       /* For testing resource-managed free */
> +       struct string_stream *freed_stream;
> +       bool stream_free_again;
> +};
> +
>  /* string_stream object is initialized correctly. */
>  static void string_stream_init_test(struct kunit *test)
>  {
> +       struct string_stream_test_priv *priv = test->priv;
>         struct string_stream *stream;
>
> +       /* Resource-managed initialization */
>         stream = alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> @@ -26,6 +37,86 @@ static void string_stream_init_test(struct kunit *test)
>         KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +
> +       free_string_stream(test, stream);
> +
> +       /*
> +        * Raw initialization. This allocation is not resource-managed
> +        * so store it in priv->raw_stream to be cleaned up by the
> +        * exit function.
> +        */
> +       priv->raw_stream = raw_alloc_string_stream(GFP_KERNEL);
> +       stream = priv->raw_stream;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_PTR_EQ(test, stream->test, NULL);
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);

Again, this will probably annoy sparse, so expect an email from ktr.
We'll look into how to fix this in either KUnit or sparse separately.


> +       KUNIT_EXPECT_FALSE(test, stream->append_newlines);
> +
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +}
> +
> +static void string_stream_raw_free_string_stream_stub(struct string_stream *stream)
> +{
> +       struct kunit *fake_test = kunit_get_current_test();
> +       struct string_stream_test_priv *priv = fake_test->priv;
> +
> +       if (priv->freed_stream)
> +               priv->stream_free_again = true;
> +
> +       priv->freed_stream = stream;
> +
> +       /*
> +        * Avoid calling deactivate_static_stub() or changing
> +        * current->kunit_test during cleanup. Leave the stream to
> +        * be freed during the test exit.
> +        */
> +}
> +
> +/* string_stream object is freed when test is cleaned up. */
> +static void string_stream_resource_free_test(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv = test->priv;
> +       struct kunit *fake_test;
> +       struct string_stream *stream;
> +
> +       fake_test = kunit_kzalloc(test, sizeof(*fake_test), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_test);
> +
> +       kunit_init_test(fake_test, "string_stream_fake_test", NULL);
> +       fake_test->priv = priv;
> +
> +       /*
> +        * Activate stub before creating string_stream so the
> +        * string_stream will be cleaned up first.
> +        */
> +       priv->freed_stream = NULL;
> +       priv->stream_free_again = false;
> +       kunit_activate_static_stub(fake_test,
> +                                  raw_free_string_stream,
> +                                  string_stream_raw_free_string_stream_stub);
> +
> +       stream = alloc_string_stream(fake_test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Ensure the stream is freed when this test terminates.
> +        */
> +       priv->raw_stream = stream;
> +
> +       /* Set current->kunit_test to fake_test so the static stub will be called. */
> +       current->kunit_test = fake_test;
> +
> +       /* Cleanup test - the stub function should be called */
> +       kunit_cleanup(fake_test);
> +
> +       /* Set current->kunit_test back to current test. */
> +       current->kunit_test = test;
> +
> +       KUNIT_EXPECT_PTR_EQ(test, priv->freed_stream, stream);
> +       KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
>  }
>
>  /*
> @@ -279,8 +370,30 @@ static void string_stream_auto_newline_test(struct kunit *test)
>                            "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>  }
>
> +static int string_stream_test_init(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv;
> +
> +       priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       test->priv = priv;
> +
> +       return 0;
> +}
> +
> +static void string_stream_test_exit(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv = test->priv;
> +
> +       if (priv && priv->raw_stream)
> +               raw_free_string_stream(priv->raw_stream);
> +}
> +
>  static struct kunit_case string_stream_test_cases[] = {
>         KUNIT_CASE(string_stream_init_test),
> +       KUNIT_CASE(string_stream_resource_free_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
> @@ -292,6 +405,8 @@ static struct kunit_case string_stream_test_cases[] = {
>
>  static struct kunit_suite string_stream_test_suite = {
>         .name = "string-stream-test",
> -       .test_cases = string_stream_test_cases
> +       .test_cases = string_stream_test_cases,
> +       .init = string_stream_test_init,
> +       .exit = string_stream_test_exit,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 06104a729b45..1b55ac1be2e5 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -6,6 +6,7 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> @@ -167,6 +168,8 @@ bool string_stream_is_empty(struct string_stream *stream)
>
>  void raw_free_string_stream(struct string_stream *stream)
>  {
> +       KUNIT_STATIC_STUB_REDIRECT(raw_free_string_stream, stream);
> +
>         string_stream_clear(stream);
>         kfree(stream);
>  }
> --
> 2.30.2
>

--00000000000095ee9a0602f2a4f3
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBU
PXSwCHXaTDXgWDEUvZDpLVRYQQAAP3sm9haeWxZXxTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE3MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAnxwwIdOOzL75wa3TKxmm
Qri9lvhS90xo/L0PnarKmANIAel9p3ka+s1oqOVM/JIzQfKJCzBuzmYZYLalN6DzoFVEoZv33UAs
kA1PGU3cqh/kpT6DoypGKSTxPvFY0FukGyHHML+ucauAdoJ3diMlLUlx1la+VCD3kl9yoCITDI7Y
fk3VF+TqDDqx6mtQqifqrGTNYSKcLrQNbql/SPTOU4C/TWm4ja9MG0nY5XvLeHSMSzQ4bWce6xIz
LYv0FuoAWm0GKV9QSi7vkYyGIjxUA8yb/eP6heM3P75Y0oMkOeD6Ruyh8K7ouCTtUoPnnWBZkzYA
KLiHpcEUcqEk1gn/JQ==
--00000000000095ee9a0602f2a4f3--
