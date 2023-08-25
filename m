Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6078804D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242514AbjHYGu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjHYGuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:50:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C751FCB
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:50:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso42385e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946200; x=1693551000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FA/+Ol2iP4xqokbaojLMTC5najdd/YvWpKxhAyMj9I=;
        b=PNIsfJjtG7HYETBfCMMovu/UTixhoCEwZBJotuzkKrU01zedMLJtbOOdO0TxsOQD7F
         /HyrVRxG1d/NqL7bBfg+HTQP447WsPzxPDCb+MsMHQlyF/Uubh6Gh/y/5KpUREroYSy5
         Hvy0kWsayIvQsV5u0x6YuC/3o0EbcBc9cRzroxWFzHf3wUQMQxx8X7w3Do+kpBPZKdN6
         kZ0NxxE62QkKLQie4qujI/Xz4pdlGjkt9JKab+lbiTQg7BY6rf2iYMoN2WpggHWuPAts
         KXNZoQ1BupvKghlJ5L1t8PuEZ/b1Gqd4Z3jLVUoyILr9x6NllTsNj5y1wt2osh5ALuGX
         VNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946200; x=1693551000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FA/+Ol2iP4xqokbaojLMTC5najdd/YvWpKxhAyMj9I=;
        b=OIftVrG2+kYRg8bPqr7NDgeXN71sicXCAF7exiYG6HVy91qHYepV79FPG+l7gj9WPF
         pbtBzS191wIyD+/qX+HjOcGduhaD/UExtrnxhCWC9V4QIZ644j7bljghO7CyPQEfNKhX
         wm6uDutBBx8CxJXBHEJUfAK645Q9fUPf/744m8O5WBQaAxBaMBD0qx8PSReLmsF9r3dR
         yriOvo7cIrch1RN6likZdysvTIH08JcGUgMt0XTQAQ61yGZu8d/amVRpx1uWXHmuDexf
         gzJBABCiccpjCcOG1wPfvT8oXARolTpsrf3ML9fa/lrMxIKGkk1Od3Hl2vi/iTyI1MN7
         BOxw==
X-Gm-Message-State: AOJu0YzhyXFNhwNl/RV4TPZ+zi9UjaEewC04Y6ROeQa2vhx9Cipn9EVt
        GYZWL+3fsjnYkeJ7wyWVfUeGh3X2Jq8vILTGdF1sDg==
X-Google-Smtp-Source: AGHT+IHJ4qPPsVqQj0XX6AWmzratqc1OJGZA4PLhuZHNXFUuOpEpIUYDMR9sDIAyXf0uBZWz+7y6lu8bwI2JxNGGvAU=
X-Received: by 2002:a05:600c:3b02:b0:400:46db:1bf2 with SMTP id
 m2-20020a05600c3b0200b0040046db1bf2mr134613wms.2.1692946199992; Thu, 24 Aug
 2023 23:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-9-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-9-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:48 +0800
Message-ID: <CABVgOSnG8epucY52ppNW7-vC_-QL3Lau9zsaw20dXgWTC0GV+Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] kunit: string-stream: Add tests for freeing
 resource-managed string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e488dc0603b9c0bd"
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

--000000000000e488dc0603b9c0bd
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, 'Richard Fitzgerald' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> string_stream_managed_free_test() allocates a resource-managed
> string_stream and tests that kunit_free_string_stream() calls
> string_stream_destroy().
>
> string_stream_resource_free_test() allocates a resource-managed
> string_stream and tests that string_stream_destroy() is called
> when the test resources are cleaned up.
>
> The old string_stream_init_test() has been split into two tests,
> one for kunit_alloc_string_stream() and the other for
> alloc_string_stream().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V4:
> - Added test case for kunit_free_string_stream().
> - Split the initialization test into separate tests for managed and
>   unmanaged allocations.
> ---

Looking over this again, I'm not convinced the streams are actually
getting freed. Once the stub has finished, the stream is removed from
the list of deferred actions / resources.

I'll have another look tomorrow in case I missed anything, but if so,
this might need to be explained further / made more obvious.

-- David

>  lib/kunit/string-stream-test.c | 135 ++++++++++++++++++++++++++++++++-
>  lib/kunit/string-stream.c      |   3 +
>  2 files changed, 134 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 45a2d221f1b5..6897c57e0db7 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -6,11 +6,25 @@
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
> +       /* For testing resource-managed free. */
> +       struct string_stream *freed_stream;
> +       bool stream_free_again;
> +};
> +
> +static void cleanup_raw_stream(void *p)
> +{
> +       struct string_stream *stream = p;
> +
> +       string_stream_destroy(stream);
> +}

Is this worth having here? It's only used once, and it could easily be
replaced with a manual call to string_stream_destroy() at the end of
the function.

If it were likely that list_empty() or string_stream_is_empty() would
crash, it would be more worthwhile to make sure the cleanup happens
anyway, but as-is, I think it's safe enough either way.

> +
>  static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
>  {
>         char *str = string_stream_get_string(stream);
> @@ -21,11 +35,12 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
>         return str;
>  }
>
> -/* string_stream object is initialized correctly. */
> -static void string_stream_init_test(struct kunit *test)
> +/* Managed string_stream object is initialized correctly. */
> +static void string_stream_managed_init_test(struct kunit *test)
>  {
>         struct string_stream *stream;
>
> +       /* Resource-managed initialization. */
>         stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> @@ -37,6 +52,101 @@ static void string_stream_init_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
>  }
>
> +/* Unmanaged string_stream object is initialized correctly. */
> +static void string_stream_unmanaged_init_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       kunit_add_action(test, cleanup_raw_stream, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_FALSE(test, stream->append_newlines);
> +
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +}
> +
> +static void string_stream_destroy_stub(struct string_stream *stream)
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

Are we ever actually freeing this during test exit? I don't think so.

I think you'd need to either free 'stream' here, or free it (either
manually or with a deferred action) at the end of every test which
uses this stub.

That being said, I'd agree it's best to avoid manually calling
deactivate_static_stub() and/or changin current->kunit_test during
cleanup. While it should actually be safe, as far as I can tell, it'd
be very confusing.

> +}
> +
> +/* kunit_free_string_stream() calls string_stream_desrtoy() */
> +static void string_stream_managed_free_test(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv = test->priv;
> +       struct string_stream *stream;
> +
> +       priv->freed_stream = NULL;
> +       priv->stream_free_again = false;
> +       kunit_activate_static_stub(test,
> +                                  string_stream_destroy,
> +                                  string_stream_destroy_stub);
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* This should call the stub function. */
> +       kunit_free_string_stream(test, stream);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, priv->freed_stream, stream);
> +       KUNIT_EXPECT_FALSE(test, priv->stream_free_again);

Stream is never freed here?

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
> +                                  string_stream_destroy,
> +                                  string_stream_destroy_stub);
> +
> +       stream = kunit_alloc_string_stream(fake_test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
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

We need to free stream here.


> +}
> +
>  /*
>   * Add a series of lines to a string_stream. Check that all lines
>   * appear in the correct order and no characters are dropped.
> @@ -327,8 +437,24 @@ static void string_stream_auto_newline_test(struct kunit *test)
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
>  static struct kunit_case string_stream_test_cases[] = {
> -       KUNIT_CASE(string_stream_init_test),
> +       KUNIT_CASE(string_stream_managed_init_test),
> +       KUNIT_CASE(string_stream_unmanaged_init_test),
> +       KUNIT_CASE(string_stream_managed_free_test),
> +       KUNIT_CASE(string_stream_resource_free_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
> @@ -341,6 +467,7 @@ static struct kunit_case string_stream_test_cases[] = {
>
>  static struct kunit_suite string_stream_test_suite = {
>         .name = "string-stream-test",
> -       .test_cases = string_stream_test_cases
> +       .test_cases = string_stream_test_cases,
> +       .init = string_stream_test_init,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index c39f1cba3bcd..d2ded5207e9e 100644
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
> @@ -170,6 +171,8 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
>
>  void string_stream_destroy(struct string_stream *stream)
>  {
> +       KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
> +
>         if (!stream)
>                 return;
>
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230824143129.1957914-9-rf%40opensource.cirrus.com.

--000000000000e488dc0603b9c0bd
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDb
NOn358ej0DGQrwPIF2NSgmZy3cpNOogXbaUkwmLVDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjUwMDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAm2zMDzbCRxZplIfgjyMn
PdqCZ/ox10zFQPDWi871FWlLGgl1ujxQsBGefbFtNWr0pHO9DlVjQ/RhpGbU5Yz9kXG9SIYcQlvB
A4KzVrWVk+kal6KIVo7jSbklW9NGXf+kZv/pCrpcTNq1kxOqtInBsKo+q86EDVwuhFoEyB85PaN7
8cEB49W2vJBoBk0h8vBKOXM9Ovrd9od17g2LConnGDGYpdM4Qbq7q0QOACe0msHSCJagbdD/KEU4
ZJAZGC14sFjO1p4Vf6ZrSUW0aWrfCzhMb8TZ97zbaV10ff5sDsaHyx+ibGzK3uZYrXHD4R+cQC48
GUuQA+5diGNHn3t8kA==
--000000000000e488dc0603b9c0bd--
