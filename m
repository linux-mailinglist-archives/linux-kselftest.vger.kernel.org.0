Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834278804E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjHYGuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242514AbjHYGtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6831119AC
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so66215e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946192; x=1693550992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eU3bHDgxeyb0VTQXH885fCuFHCmILRsPy049OZuFaJ4=;
        b=TnMn0Ty0N6qVF4GnI2LtbfDptEHLV225YMc4Ry52LqYpUwFSTwZHHIwxsEbtvhUJ+a
         ypKGgYBNESIboD0H/OzBASeQzF0xDJTuhymFB2i8axPbxVCno+uJnTz5D7mJZ6kLm8ar
         6rNyaCMshUltiPKsDba/AhtYeg32SxGpol6pp34E4gj3gnw1s8nRp+NMtm28H4PYXJA0
         vOckHWjVgm2Ojd2vI8KxynCSQPd92vLOR0JdXi5Te55OrEKgNz+fZStkhHkFhmSNqcFR
         ZQZTa2kZtvdHapNdD6aHZQQJnYKxnizjlSz3Z4/CGIZALQWoI56EXCrfkJY2IPR4z+RH
         y/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946192; x=1693550992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eU3bHDgxeyb0VTQXH885fCuFHCmILRsPy049OZuFaJ4=;
        b=RPvsPsqO7MQi8KH5OOZ4kUKPDQYTREMUYAyenwRRYA+PH08W34q3DJE+QE6jtU0Y0W
         dJ72Tb+IP8mtOXGsDV08+4yrHIQB0Kdn2v0boQxwJQCr0BhByD3h7GYz4yW8UTdKgXM7
         wCD7YoSE085cAm0jdpZA/4rHKjnCCIxzJNZBeFs2yGaqxTM2V/FnIN2z3DPMjS4fFaGe
         pYZQmI3crQjYpx7+EObA1X5+JHVS7B9NoZtalUB2BtT6HH8h9t+W6ZfQ78EzK/TDAQj2
         oyuEdZr8JcT9ne8LG4co9P5r6jl7VBbToo7zQsLcF7ZkZMiycBso0sOc3af9xjmrHHbS
         tb5Q==
X-Gm-Message-State: AOJu0YyBT2ujLIVVQ1pEy/LKL4NI6a7gyqjM3TEuwzZCv2wy1BQx4QP8
        Qm+xJKaHq2MU1KCD8Im9fbAfASQlusmoTNZTkayRsw==
X-Google-Smtp-Source: AGHT+IHdMzfEKROiRObW8KorRUM7kB3jkLUsMgPDYJLbs6+BKO0twjV/lUgjH/D8slEuZ1QNRMjd7Ga12R1cq+vebvs=
X-Received: by 2002:a05:600c:1d0b:b0:3fe:cd3a:ef92 with SMTP id
 l11-20020a05600c1d0b00b003fecd3aef92mr133968wms.6.1692946191863; Thu, 24 Aug
 2023 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-7-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-7-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:40 +0800
Message-ID: <CABVgOS=vK+Vn_5hco8Pc3Ur8TpKhOaQ5KwaCs5s3OP6foVdxVA@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] kunit: string-stream: Add kunit_alloc_string_stream()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000686cca0603b9c0fe"
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

--000000000000686cca0603b9c0fe
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add function kunit_alloc_string_stream() to do a resource-managed
> allocation of a string stream, and corresponding
> kunit_free_string_stream() to free the resource-managed stream.
>
> This is preparing for decoupling the string_stream
> implementation from struct kunit, to reduce the amount of code
> churn when that happens. Currently:
>  - kunit_alloc_string_stream() only calls alloc_string_stream().
>  - kunit_free_string_stream() takes a struct kunit* which
>    isn't used yet.
>
> Callers of the old alloc_string_stream() and
> string_stream_destroy() are all requesting a managed allocation
> so have been changed to use the new functions.
>
> alloc_string_stream() has been temporarily made static because
> its current behavior has been replaced with
> kunit_alloc_string_stream().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream-test.c | 28 ++++++++++++++--------------
>  lib/kunit/string-stream.c      | 12 +++++++++++-
>  lib/kunit/string-stream.h      |  3 ++-
>  lib/kunit/test.c               |  4 ++--
>  4 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 2a9936db1b9f..89549c237069 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -25,7 +25,7 @@ static void string_stream_init_test(struct kunit *test)
>  {
>         struct string_stream *stream;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         KUNIT_EXPECT_EQ(test, stream->length, 0);
> @@ -49,7 +49,7 @@ static void string_stream_line_add_test(struct kunit *test)
>         size_t len, total_len;
>         int num_lines, i;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         /* Add series of sequence numbered lines */
> @@ -105,7 +105,7 @@ static void string_stream_variable_length_line_test(struct kunit *test)
>         size_t offset, total_len;
>         int num_lines, i;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         /*
> @@ -165,10 +165,10 @@ static void string_stream_append_test(struct kunit *test)
>         size_t combined_length;
>         int i;
>
> -       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
>
> -       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
>
>         /* Append content of empty stream to empty stream */
> @@ -206,9 +206,9 @@ static void string_stream_append_test(struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), combined_content);
>
>         /* Append content of non-empty stream to empty stream */
> -       string_stream_destroy(stream_1);
> +       kunit_free_string_stream(test, stream_1);
>
> -       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
>
>         string_stream_append(stream_1, stream_2);
> @@ -221,13 +221,13 @@ static void string_stream_append_auto_newline_test(struct kunit *test)
>         struct string_stream *stream_1, *stream_2;
>
>         /* Stream 1 has newline appending enabled */
> -       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       stream_1 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
>         string_stream_set_append_newlines(stream_1, true);
>         KUNIT_EXPECT_TRUE(test, stream_1->append_newlines);
>
>         /* Stream 2 does not append newlines */
> -       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
>
>         /* Appending a stream with a newline should not add another newline */
> @@ -238,8 +238,8 @@ static void string_stream_append_auto_newline_test(struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
>                            "Original string\nAppended content\nMore stuff\n");
>
> -       string_stream_destroy(stream_2);
> -       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       kunit_free_string_stream(test, stream_2);
> +       stream_2 = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
>
>         /*
> @@ -260,7 +260,7 @@ static void string_stream_append_empty_string_test(struct kunit *test)
>         struct string_stream *stream;
>         int original_frag_count;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         /* Formatted empty string */
> @@ -282,7 +282,7 @@ static void string_stream_no_auto_newline_test(struct kunit *test)
>  {
>         struct string_stream *stream;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         /*
> @@ -305,7 +305,7 @@ static void string_stream_auto_newline_test(struct kunit *test)
>  {
>         struct string_stream *stream;
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
>         string_stream_set_append_newlines(stream, true);
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 1dcf6513b692..12ecf15e1f6b 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -153,7 +153,7 @@ bool string_stream_is_empty(struct string_stream *stream)
>         return list_empty(&stream->fragments);
>  }
>
> -struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
> +static struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
>  {
>         struct string_stream *stream;
>
> @@ -173,3 +173,13 @@ void string_stream_destroy(struct string_stream *stream)
>  {
>         string_stream_clear(stream);
>  }
> +
> +struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
> +{
> +       return alloc_string_stream(test, gfp);
> +}
> +
> +void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
> +{
> +       string_stream_destroy(stream);
> +}
> diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
> index 048930bf97f0..3e70ee9d66e9 100644
> --- a/lib/kunit/string-stream.h
> +++ b/lib/kunit/string-stream.h
> @@ -30,7 +30,8 @@ struct string_stream {
>
>  struct kunit;
>
> -struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
> +struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp);
> +void kunit_free_string_stream(struct kunit *test, struct string_stream *stream);
>
>  int __printf(2, 3) string_stream_add(struct string_stream *stream,
>                                      const char *fmt, ...);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49698a168437..93d9225d61e3 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -308,7 +308,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>
>         kunit_set_failure(test);
>
> -       stream = alloc_string_stream(test, GFP_KERNEL);
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         if (IS_ERR(stream)) {
>                 WARN(true,
>                      "Could not allocate stream to print failed assertion in %s:%d\n",
> @@ -322,7 +322,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
>
>         kunit_print_string_stream(test, stream);
>
> -       string_stream_destroy(stream);
> +       kunit_free_string_stream(test, stream);
>  }
>
>  void __noreturn __kunit_abort(struct kunit *test)
> --
> 2.30.2
>

--000000000000686cca0603b9c0fe
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAx
d71DhhuOjDIKrEnVuCAp8SIEConHAmIMni/0Nx7oRTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5NTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAB9Is2Jv5mFGEdnrnoqDK
IwQZ0ZGTtfryCmnqUOzrILVKusQMMdLxsroRD6ynBDE/Pgq1pZuUuYv0BZOSzTTslEYvKQqgQDOr
XREYnYVrqYYkhtUcATRJ3C5LgQLe4GPXCkGSivVidU22NkgSrcQgo5vbh6RfpElPYhGfLtJqmq5s
c710M8S3oAWe5JpF59GEoA/UdDr3R78qFqCpm4WIXQOaYaQVPz1a/TntIvpHdiVvN7mNFci/R9U/
a1beUvuo/C75gQ8+fW1AXqcCfxKQuEac0lM62VjPXQqQisZEXJC2sED71NXCBTWVdfZrqW12Lw56
d1c0H7XziR7Y/Erbog==
--000000000000686cca0603b9c0fe--
