Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA38378803F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbjHYGty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbjHYGto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEB1FCB
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso42285e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946180; x=1693550980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pY8QtsRI8zkJplMHCqbCZJl0cdRyUo2ewm0WA42S3xE=;
        b=oZXHGLnN5Bf+XJdbezm2FduSgb7fvjr6v2PtYYF4n4oOh/2D8Q4ySkcFGBFOykm7dH
         f9yv7l8Kraa/EvD+qwZfyowAEggT0+eWT2U+g3+3vmKxr1Sgp2lUa8LH7Vlb7c6/SGOv
         NuHuQYqA2z7lqJy30tv7osDuTF6dOI3fC1s7ldyjFanGYnFu70WJKKYGVFh2Kf9IAlxT
         SpXPcOYEopcdPLEGAKXxXIG0bg1QUpEbEMZnBuRBrjqQ1kRms2NT5Hjg1c/AmCNex3Hi
         PyUdWNj6xR+zyHuMMuAvx7Z4P6nm9h979bnOOQN3e8h9RlcfvLDp6mGTVaej5q1Ck4Gt
         24Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946180; x=1693550980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY8QtsRI8zkJplMHCqbCZJl0cdRyUo2ewm0WA42S3xE=;
        b=OEk2Pf2jVBB36JlbBdDecOtHG976ypHs4hc15gmq4G07e4xQSypbZSoAlJITESzTJm
         Opa6fBXS3QNZMi3Nkp0hL7RuLpJUNZUWH8eromvaZJJ15h4J3kjou9aL7tWCMlWqDqxA
         IjjmuTxVQLKEMN8OSvb49bASozUxuvdP7JHZ4jdECWmyGXzG86QQIWnJuvNvFMt6ILi4
         7FFHgbRw5XVicCIxcP5qZwbM1eSnh1wybO8kDHbxg1q039eciwluyjgdJgEJLobcYMqA
         l2WGNMeHFhkU73k52l80VpL9cEW5qjYndlTVckjThqeyP0La82ni4B4qAdJxQ6gMdbyc
         jnfQ==
X-Gm-Message-State: AOJu0YxlDZuX6nWNbO5L2+DMaraXQwoxw1aFwO17C1swwKGyQuzI8VcE
        kDg6/1lBqUUVFI49i6ZUmA7UUBaUuK9+aVFqpIarZWtdeIP80C+zNKg=
X-Google-Smtp-Source: AGHT+IFkufJtS6lZhDP2VRCgLlGQeED7mercg+zbW6WucUF8ifEBjfv8JrUfXfkL8AKEeWvLTNDqiyPmqzT4krxyZ6o=
X-Received: by 2002:a05:600c:5106:b0:3fe:eb42:7ec with SMTP id
 o6-20020a05600c510600b003feeb4207ecmr102437wms.1.1692946180073; Thu, 24 Aug
 2023 23:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-5-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-5-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:28 +0800
Message-ID: <CABVgOSms9GsXxCm1dUztJbcuX=QC7gNB3Kyc65=6UFExeyPxNQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] kunit: string-stream: Add cases for
 string_stream newline appending
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b563ad0603b9bf8a"
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

--000000000000b563ad0603b9bf8a
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add test cases for testing the string_stream feature that appends a
> newline to strings that do not already end with a newline.
>
> string_stream_no_auto_newline_test() tests with this feature disabled.
> Newlines should not be added or dropped.
>
> string_stream_auto_newline_test() tests with this feature enabled.
> Newlines should be added to lines that do not end with a newline.
>
> string_stream_append_auto_newline_test() tests appending the
> content of one stream to another stream when the target stream
> has newline appending enabled.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V4:
> - string_stream_append_auto_newline_test() doesn't clear the destination
>   stream_1 between the newline and no-newline case. This is just a
>   simplification of the code.
>
> - string_stream_no_auto_newline_test() uses the same set of test strings
>   as string_stream_auto_newline_test().
> ---

Much better, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream-test.c | 93 ++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 2b761ba01835..2a9936db1b9f 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -32,6 +32,7 @@ static void string_stream_init_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
>         KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
>         KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
>  }
> @@ -214,6 +215,45 @@ static void string_stream_append_test(struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), stream_2_content);
>  }
>
> +/* Appending the content of one string stream to one with auto-newlining. */
> +static void string_stream_append_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream_1, *stream_2;
> +
> +       /* Stream 1 has newline appending enabled */
> +       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +       string_stream_set_append_newlines(stream_1, true);
> +       KUNIT_EXPECT_TRUE(test, stream_1->append_newlines);
> +
> +       /* Stream 2 does not append newlines */
> +       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /* Appending a stream with a newline should not add another newline */
> +       string_stream_add(stream_1, "Original string\n");
> +       string_stream_add(stream_2, "Appended content\n");
> +       string_stream_add(stream_2, "More stuff\n");
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
> +                          "Original string\nAppended content\nMore stuff\n");
> +
> +       string_stream_destroy(stream_2);
> +       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /*
> +        * Appending a stream without newline should add a final newline.
> +        * The appended string_stream is treated as a single string so newlines
> +        * should not be inserted between fragments.
> +        */
> +       string_stream_add(stream_2, "Another");
> +       string_stream_add(stream_2, "And again");
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
> +                          "Original string\nAppended content\nMore stuff\nAnotherAnd again\n");
> +}
> +
>  /* Adding an empty string should not create a fragment. */
>  static void string_stream_append_empty_string_test(struct kunit *test)
>  {
> @@ -237,12 +277,65 @@ static void string_stream_append_empty_string_test(struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "Add this line");
>  }
>
> +/* Adding strings without automatic newline appending */
> +static void string_stream_no_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Add some strings with and without newlines. All formatted newlines
> +        * should be preserved. It should not add any extra newlines.
> +        */
> +       string_stream_add(stream, "One");
> +       string_stream_add(stream, "Two\n");
> +       string_stream_add(stream, "%s\n", "Three");
> +       string_stream_add(stream, "%s", "Four\n");
> +       string_stream_add(stream, "Five\n%s", "Six");
> +       string_stream_add(stream, "Seven\n\n");
> +       string_stream_add(stream, "Eight");
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream),
> +                          "OneTwo\nThree\nFour\nFive\nSixSeven\n\nEight");
> +}
> +
> +/* Adding strings with automatic newline appending */
> +static void string_stream_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       string_stream_set_append_newlines(stream, true);
> +       KUNIT_EXPECT_TRUE(test, stream->append_newlines);
> +
> +       /*
> +        * Add some strings with and without newlines. Newlines should
> +        * be appended to lines that do not end with \n, but newlines
> +        * resulting from the formatting should not be changed.
> +        */
> +       string_stream_add(stream, "One");
> +       string_stream_add(stream, "Two\n");
> +       string_stream_add(stream, "%s\n", "Three");
> +       string_stream_add(stream, "%s", "Four\n");
> +       string_stream_add(stream, "Five\n%s", "Six");
> +       string_stream_add(stream, "Seven\n\n");
> +       string_stream_add(stream, "Eight");
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream),
> +                          "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
> +}
> +
>  static struct kunit_case string_stream_test_cases[] = {
>         KUNIT_CASE(string_stream_init_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
> +       KUNIT_CASE(string_stream_append_auto_newline_test),
>         KUNIT_CASE(string_stream_append_empty_string_test),
> +       KUNIT_CASE(string_stream_no_auto_newline_test),
> +       KUNIT_CASE(string_stream_auto_newline_test),
>         {}
>  };
>
> --
> 2.30.2
>

--000000000000b563ad0603b9bf8a
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCu
rveUM8FnqciEB27EIFr5/rkP43e4YY35xjU1iXB7xDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5NDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAk2Shz6EWvMNYNA1T/Yo0
nIcN4+W6wyvEZt72Y+d2lD9ynFMB+Eh/vU/20he1DoMyeD0z6pVqJ12BFOh33W6YiKHqBEQ6ZhWB
+sfWt5gm2xP075nNSmJuC4zLYE8qWOsKmFAh3QdusP3FQf2yHhTIwrM6/IqQdVfwHkjCYNtloSDJ
+Ml6OKMUfXxqTNypHL82cT/lmAqcxbeWCfU9Wdmr4YXyUSju17vXriQbXXUSFHDeXMvtZ4SvMiXK
lzsvZWVxSRDLr8kc8bR6OQERLADNAXwcRxFSRzGcHSKwvWYy62bTtDZaxIaNFwH709qr6LHVW0VC
1e0hj8le6+NAL2kpqw==
--000000000000b563ad0603b9bf8a--
