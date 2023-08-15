Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE777CA3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjHOJRt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjHOJQR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:16:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9985EC9
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so6564a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692090974; x=1692695774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0f8w7owQcbw1LL51RJELQ9OagPNcNBNfy3AmNaWvoA=;
        b=PEoaI8sQTO6vo/EWjKPIKb4Y4w7+1LMJM/JLBk1/WSF+sUXxkM27RsPCMtPGOwAeq+
         PtdUMelsI9rIjG6btlKgUj0tgZaq6Vuf8aT36mOxaEMmrl3uZu+auT4hdDZC7tc/BUC9
         67VYi+JxDSf4vTDxz0+52l9ScsgXEtk89RRqcxyoTteYk6rdM1SLu/J1ijcuRBNS5w8f
         nMCVhE3SMlftkGOaVxkku2jREqv6aTMwQy5PXBdN3zl2yHIKsuxSlxFjr1Tg3Nrq3gd0
         8X7Z+YrD+O/Zvbc6+5OAYJpdvQ9cOgfX6Bgunp/QRXbekIdH6WB9ALoOjhMNG1nIy7b/
         +k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090974; x=1692695774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0f8w7owQcbw1LL51RJELQ9OagPNcNBNfy3AmNaWvoA=;
        b=TKimblSWHHVmimPvld39I6I7/R8lUobPoa5QDEqa18GDCSS4TKuqXfCuF4c5xGBOKf
         G15Rccg/UcU4akEJGTcTY9ggM9MNvW2kMU+evdPV2KbBv2nG8ZXAq28z45bpZQ/VojPR
         m+E/cvLYr8uTCRZoQdT7aQHwlBUnw22w2SVxAXN7GRKyxSOqJtQxmOxEF4FC7HTlfQNM
         Ibt4arYyqzs/STjyfzhNvtf76ElI5mqBGeADYMX9yzbD3eJL+0+XXkLK4XMal0cwQ5mf
         gaGFhbEvPzLJ6HZtmlm0GaF/LLCLTAjA63RXzr5EN4ffTHiDV5AaLMW2hY7V22Lp8oZK
         Ek4A==
X-Gm-Message-State: AOJu0Ywm6aCbCPD02NnZb7MmSirJLQYoerSbJhbe/a0ivlyW0DZAMQw2
        Z6tfKwgxZ4GY3l4XzzVP5EYihnTZB9OodPJDpa2t8A==
X-Google-Smtp-Source: AGHT+IErOGiSXuO2KhoTx8h2C/VqwcwZLk2AcwHLAKfig7tTRld+hNRAntYgbzWL8o8MFxC4OOIrnR1Pw81qiBOa1+Q=
X-Received: by 2002:a50:c05d:0:b0:522:41c9:9b9 with SMTP id
 u29-20020a50c05d000000b0052241c909b9mr328628edd.5.1692090973961; Tue, 15 Aug
 2023 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-2-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-2-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Aug 2023 17:15:59 +0800
Message-ID: <CABVgOS=-he=eD8vkwNO2gW5YsRy9mi7T9cGryWqvObP5Yxm_PA@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] kunit: string-stream: Improve testing of string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000074c9980602f2a1a8"
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

--00000000000074c9980602f2a1a8
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Aug 2023 at 21:23, Richard Fitzgerald
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
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Thanks. These tests are much better than the original string stream ones.

It looks good to me. I left a few notes below (mostly to myself), but
nothing that would require a new version by itself.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream-test.c | 200 ++++++++++++++++++++++++++++++---
>  1 file changed, 184 insertions(+), 16 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 110f3a993250..1d46d5f06d2a 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -11,38 +11,206 @@
>
>  #include "string-stream.h"
>
> -static void string_stream_test_empty_on_creation(struct kunit *test)
> +/* string_stream object is initialized correctly. */
> +static void string_stream_init_test(struct kunit *test)
>  {
> -       struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);

As the kernel test robot notes, this may trigger a sparse warning, as
KUnit stores integer types as 'long long' internally in assertions.
Ignore it for now, we'll see if we can fix it in KUnit.

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

Assuming the 'd' in '%d' counts, this still has every letter of the
alphabet in it. :-)

> +
> +               /* Sanity-check that our test string isn't truncated */
> +               KUNIT_ASSERT_LT(test, len, sizeof(line));
> +
> +               string_stream_add(stream, line);
> +               total_len += len;
> +       }
> +       num_lines = i;
> +
> +       concat_string = string_stream_get_string(stream);
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

This being deterministic is good. There are a few tests which are
doing similar things with randomness, and I think we'll want to have a
shared framework for it at some point (to enable a 'fuzzing' mode
which is _not_ deterministic), but this is good for now.

> +       total_len = 0;
> +       for (i = 0; i < 100; ++i) {
> +               offset = prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +               string_stream_add(stream, "%s\n", &line[offset]);
> +               total_len += sizeof(line) - offset;
> +       }
> +       num_lines = i;
> +
> +       concat_string = string_stream_get_string(stream);
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
> +               "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIZE",
> +               "SEVEN", "EIGHT", "NINE", "TEN",
> +       };

This is fine, but I wonder if it'd be more resilient to potential
changes to the string-string implementation if these arrays didn't
have the same shape (in terms of length and length of substrings).

e.g., if we made the 2nd one "NINE", "EIGHT", "SEVEN"..., so it
doesn't have the same number of strings (due to missing "TEN") and the
lengths of them are not equivalent (strlen("one") != strlen("NINE")).

I doubt it'd make much difference, but maybe it'd catch some nasty
use-after-free or similar errors, and having the strings be different
makes it more obvious that there's not something being tested which
relies on them being the same.

(Don't bother resending the series just for this, though. But if we
have to do a new version anyway...)



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
> +       KUNIT_EXPECT_EQ(test, strlen(string_stream_get_string(stream_1)), 0);
> +
> +       /* Add some data to stream_1 */
> +       for (i = 0; i < ARRAY_SIZE(strings_1); ++i)
> +               string_stream_add(stream_1, "%s\n", strings_1[i]);
> +
> +       original_content = string_stream_get_string(stream_1);
> +
> +       /* Append content of empty stream to non-empty stream */
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), original_content);
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
> +       stream_2_content = string_stream_get_string(stream_2);
> +       combined_length = strlen(original_content) + strlen(stream_2_content);
> +       combined_length++; /* for terminating \0 */
> +       combined_content = kunit_kmalloc(test, combined_length, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
> +       snprintf(combined_content, combined_length, "%s%s", original_content, stream_2_content);
> +
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), combined_content);
> +
> +       /* Append content of non-empty stream to empty stream */
> +       string_stream_destroy(stream_1);
> +
> +       stream_1 = alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream_1), stream_2_content);
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
>         {}
>  };
>
> --
> 2.30.2
>

--00000000000074c9980602f2a1a8
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDV
gBz6leMVQ9/VHHLpDnjyzM6Rbe32MJz2F4Oz4YLXOzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTUwOTE2MTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARXcak0h8gvTtkH8snhTu
xjcAV+VfB2+bsv2y82ZPaqDBsmAbFJMDlTL/zwfb0SGrbHuO04PP4eLWCTY4MOCYHaLD55KEi95C
b9mytmgS4gO6YloV6+ZOxQ8WFs4OJppw+bGjowpgSmqoRakDIZ7IsZeIYk4oyTNvhetNuQqg0Fca
BArR2eHvAppn++DVo1F8D1ouPaiH1mTj0wYOY5nXrEoK8QghSzRwT8XE0usS3QOWqnU08svIu82L
f08cGMjuhD5+Ja+bcwmhmmjj1+YWc42IbfqtJWl7y0l+EPAUFF3UbLNwhSx8Nne6mMhygenC5sLb
viyMvUJm/3mP7SDmxg==
--00000000000074c9980602f2a1a8--
