Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A83788044
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbjHYGty (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbjHYGtd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358801FE9
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso42185e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946168; x=1693550968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhDp2kjJzIhg7wYFwKSKVdDRtwpRP1OuIpAzLl2nndk=;
        b=bJgkeEwQz++r6bRWyPcsWdqa+IGVGbH144OM8+P80VZ2XI7lhWJdX5BG1JGB6Tq4bM
         vMaAg8E9glYeppcc34ywDziPTOcQXnW/pxQ9SGUr3PSDPEIk8x6rjpDV+iKzu0WlQVOp
         vxOtthgpcgdqy25NIsoWLPkuTrCvVjCJLmHm2SzJYnyLNKd6GeyszXrTpUWajCPZ9yia
         9MrM64YT6gtJnjpMWiZhngVtMNgU/fFEDIAXTv49vQKkQRV6HQCUcXddEhwxg732axSD
         3dMdjbvBpU0obyYW7bNc7xyMya7Q1plK3a+Omc2mITXuiMsYkQmlXVz45eBOs+wB6ccf
         FEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946168; x=1693550968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhDp2kjJzIhg7wYFwKSKVdDRtwpRP1OuIpAzLl2nndk=;
        b=bONCR0oCZB7ZA3pf2APSHM4bQSqyuFY7JZfpkgbX+wI1TH/tuYJJxavWG24hFBOK2R
         bH14RTt4pZ0CQRv36C30bXBc9rzMMJnHJfawVgaXdyJGucpQBQAprYDDbCm1l0jdezeF
         rkm1xA3XTpMus+DyC8aP0qBXY/jJoNjFkxTxewBYXf1D11tjVdSP5qCsEoXKMWKifRUC
         i+7brYO4GHTArkxGCt32tntqxh1CnCmtmjcwgpkmiPArDqlNhDe5MoAkdwkvErjby5YD
         Iftm60FLVk9c4m2ZcQFz+hGF8x15LycWp1BFQc31Odn78/v0weie+hZ36mYNMbk1iSBY
         Vlpg==
X-Gm-Message-State: AOJu0YyXv9FZ0rOuVnbWzoUNKnevHlH93m22QKT6WTM5hEF3bhrpXrZv
        GhbJY+8cQwjiOijkzV74ZId+i5E9NMqCkLjugnrMUDs2w/U5LonMhyw=
X-Google-Smtp-Source: AGHT+IF5xymPSXe4tSBK8NStSLQdaQ1lABDrQGfQwp+tcHfPVkxg1IzRtPPwOJy0Q+M7RSbt7THZx5s43J8NBVoITZI=
X-Received: by 2002:a05:600c:5106:b0:3fe:eb42:7ec with SMTP id
 o6-20020a05600c510600b003feeb4207ecmr102381wms.1.1692946168488; Thu, 24 Aug
 2023 23:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-3-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-3-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:16 +0800
Message-ID: <CABVgOSn4H7HAbn2ZR0KFBwLT6GfBteaGVJa8KT8Q4fjhM7nUQw@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] kunit: string-stream: Improve testing of string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000659830603b9bfdf"
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

--0000000000000659830603b9bfdf
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:33, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Replace the minimal tests with more-thorough testing.
>
> string_stream_init_test() tests that struct string_stream is
> initialized correctly.
>
> string_stream_line_add_test() adds a series of numbered lines and
> checks that the resulting string contains all the lines.
>
> string_stream_variable_length_line_test() adds a large number of
> lines of varying length to create many fragments, then tests that all
> lines are present.
>
> string_stream_append_test() tests various cases of using
> string_stream_append() to append the content of one stream to another.
>
> Adds string_stream_append_empty_string_test() to test that adding an
> empty string to a string_stream doesn't create a new empty fragment.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since V4:
> - Test cases for appending empty strings have been squashed into this
>   patch.
> - Call to string_stream_get_string() is wrapped in a local function
>   get_concatenated_string(). This is to avoid a lot of code churn later
>   when string_stream_get_string() is changed to return an unmanaged buffer.
> ---

This looks good to me. I'm not 100% sold on the
'get_concatenated_string()' function long-term (despite its obvious
benefits during the refactoring), but that's just personal taste. This
version is fine regardless.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream-test.c | 232 ++++++++++++++++++++++++++++++---
>  1 file changed, 216 insertions(+), 16 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 110f3a993250..2b761ba01835 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -11,38 +11,238 @@
>
>  #include "string-stream.h"
>
> -static void string_stream_test_empty_on_creation(struct kunit *test)
> +static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
>  {
> -       struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
> +       char *str = string_stream_get_string(stream);
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +
> +       return str;
> +}
> +
> +/* string_stream object is initialized correctly. */
> +static void string_stream_init_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
>  }
>
> -static void string_stream_test_not_empty_after_add(struct kunit *test)
> +/*
> + * Add a series of lines to a string_stream. Check that all lines
> + * appear in the correct order and no characters are dropped.
> + */
> +static void string_stream_line_add_test(struct kunit *test)
>  {
> -       struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
> +       struct string_stream *stream;
> +       char line[60];
> +       char *concat_string, *pos, *string_end;
> +       size_t len, total_len;
> +       int num_lines, i;
>
> -       string_stream_add(stream, "Foo");
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> -       KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
> +       /* Add series of sequence numbered lines */
> +       total_len = 0;
> +       for (i = 0; i < 100; ++i) {
> +               len = snprintf(line, sizeof(line),
> +                       "The quick brown fox jumps over the lazy penguin %d\n", i);
> +
> +               /* Sanity-check that our test string isn't truncated */
> +               KUNIT_ASSERT_LT(test, len, sizeof(line));
> +
> +               string_stream_add(stream, line);
> +               total_len += len;
> +       }
> +       num_lines = i;
> +
> +       concat_string = get_concatenated_string(test, stream);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> +       KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> +
> +       /*
> +        * Split the concatenated string at the newlines and check that
> +        * all the original added strings are present.
> +        */
> +       pos = concat_string;
> +       for (i = 0; i < num_lines; ++i) {
> +               string_end = strchr(pos, '\n');
> +               KUNIT_EXPECT_NOT_NULL(test, string_end);
> +
> +               /* Convert to NULL-terminated string */
> +               *string_end = '\0';
> +
> +               snprintf(line, sizeof(line),
> +                        "The quick brown fox jumps over the lazy penguin %d", i);
> +               KUNIT_EXPECT_STREQ(test, pos, line);
> +
> +               pos = string_end + 1;
> +       }
> +
> +       /* There shouldn't be any more data after this */
> +       KUNIT_EXPECT_EQ(test, strlen(pos), 0);
>  }
>
> -static void string_stream_test_get_string(struct kunit *test)
> +/* Add a series of lines of variable length to a string_stream. */
> +static void string_stream_variable_length_line_test(struct kunit *test)
>  {
> -       struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
> -       char *output;
> +       static const char line[] =
> +               "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +               " 0123456789!$%^&*()_-+={}[]:;@'~#<>,.?/|";
> +       struct string_stream *stream;
> +       struct rnd_state rnd;
> +       char *concat_string, *pos, *string_end;
> +       size_t offset, total_len;
> +       int num_lines, i;
>
> -       string_stream_add(stream, "Foo");
> -       string_stream_add(stream, " %s", "bar");
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> -       output = string_stream_get_string(stream);
> -       KUNIT_ASSERT_STREQ(test, output, "Foo bar");
> +       /*
> +        * Log many lines of varying lengths until we have created
> +        * many fragments.
> +        * The "randomness" must be repeatable.
> +        */
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       total_len = 0;
> +       for (i = 0; i < 100; ++i) {
> +               offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +               string_stream_add(stream, "%s\n", &line[offset]);
> +               total_len += sizeof(line) - offset;
> +       }
> +       num_lines = i;
> +
> +       concat_string = get_concatenated_string(test, stream);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> +       KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> +
> +       /*
> +        * Split the concatenated string at the newlines and check that
> +        * all the original added strings are present.
> +        */
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       pos = concat_string;
> +       for (i = 0; i < num_lines; ++i) {
> +               string_end = strchr(pos, '\n');
> +               KUNIT_EXPECT_NOT_NULL(test, string_end);
> +
> +               /* Convert to NULL-terminated string */
> +               *string_end = '\0';
> +
> +               offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +               KUNIT_EXPECT_STREQ(test, pos, &line[offset]);
> +
> +               pos = string_end + 1;
> +       }
> +
> +       /* There shouldn't be any more data after this */
> +       KUNIT_EXPECT_EQ(test, strlen(pos), 0);
> +}
> +
> +/* Appending the content of one string stream to another. */
> +static void string_stream_append_test(struct kunit *test)
> +{
> +       static const char * const strings_1[] = {
> +               "one", "two", "three", "four", "five", "six",
> +               "seven", "eight", "nine", "ten",
> +       };
> +       static const char * const strings_2[] = {
> +               "Apple", "Pear", "Orange", "Banana", "Grape", "Apricot",
> +       };
> +       struct string_stream *stream_1, *stream_2;
> +       const char *original_content, *stream_2_content;
> +       char *combined_content;
> +       size_t combined_length;
> +       int i;
> +
> +       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +
> +       stream_2 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /* Append content of empty stream to empty stream */
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_EQ(test, strlen(get_concatenated_string(test, stream_1)), 0);
> +
> +       /* Add some data to stream_1 */
> +       for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
> +               string_stream_add(stream_1, "%s\n", strings_1[i]);
> +
> +       original_content = get_concatenated_string(test, stream_1);
> +
> +       /* Append content of empty stream to non-empty stream */
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), original_content);
> +
> +       /* Add some data to stream_2 */
> +       for (i = 0; i < ARRAY_SIZE(strings_2); ++i)
> +               string_stream_add(stream_2, "%s\n", strings_2[i]);
> +
> +       /* Append content of non-empty stream to non-empty stream */
> +       string_stream_append(stream_1, stream_2);
> +
> +       /*
> +        * End result should be the original content of stream_1 plus
> +        * the content of stream_2.
> +        */
> +       stream_2_content = get_concatenated_string(test, stream_2);
> +       combined_length = strlen(original_content) + strlen(stream_2_content);
> +       combined_length++; /* for terminating \0 */
> +       combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
> +       snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
> +
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), combined_content);
> +
> +       /* Append content of non-empty stream to empty stream */
> +       string_stream_destroy(stream_1);
> +
> +       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1), stream_2_content);
> +}
> +
> +/* Adding an empty string should not create a fragment. */
> +static void string_stream_append_empty_string_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       int original_frag_count;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Formatted empty string */
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +
> +       /* Adding an empty string to a non-empty stream */
> +       string_stream_add(stream, "Add this line");
> +       original_frag_count = list_count_nodes(&stream->fragments);
> +
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), original_frag_count);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "Add this line");
>  }
>
>  static struct kunit_case string_stream_test_cases[] = {
> -       KUNIT_CASE(string_stream_test_empty_on_creation),
> -       KUNIT_CASE(string_stream_test_not_empty_after_add),
> -       KUNIT_CASE(string_stream_test_get_string),
> +       KUNIT_CASE(string_stream_init_test),
> +       KUNIT_CASE(string_stream_line_add_test),
> +       KUNIT_CASE(string_stream_variable_length_line_test),
> +       KUNIT_CASE(string_stream_append_test),
> +       KUNIT_CASE(string_stream_append_empty_string_test),
>         {}
>  };
>
> --
> 2.30.2
>

--0000000000000659830603b9bfdf
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBp
CymOZNeQOn00m7rMi0DtyTQuY2VZtoBmSkEOUMZqyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbxiXoSEoMb5tnNCEWF7M
tgSoSFoNJDILn4rRfvRY5blKaUHdoAfEpWIG1mxDEtytU/e5P5XzPdNRZBpBb6JxfK5xTX+68mGu
KYE918Lzxd3LGv9w/Oi8MaUfoFylUc0tGTimrAU3o5rRQExfaG4XEeFEgNtzArr3JogNBqJ7B94g
qXhpw/R/oTiblacym8P437ZiRZWtN+zdplLEKbzHtxHhP6MRsFRPyiIVhco9+83c8SDitctpkD5e
m6mcHM+cH8JuL7sTlC2g3mkjjDTPMDWM1LVeZEciFYmy63MIQM4Wa3+XpdZDvJtH36pscpE1LdZ4
xQTNqUuYNoJXMbI5Ew==
--0000000000000659830603b9bfdf--
