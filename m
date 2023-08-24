Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062D787B96
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjHXWnH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbjHXWm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 18:42:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370781BF1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 15:42:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso14645e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916971; x=1693521771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU7nBIlr13kHPh3ffj0Bs8FBEPhhunXghwLuQjfy248=;
        b=FaI3z8OyYlCDHSzwVfguNSrt8P+bI0TWsz+T2y5rhBU4/jjeYVSApSOILNjNZ4Fnpo
         BqSw0LIEybrzlXZhIq0e1+wEsDqifkg+aTu8YrPIMN8OWZZ79nZXkIaVd4PQQ+28cuet
         AmRLKWqTYEHU0akRVvGGowyw7xoO9RhwOVlLJzekmUe8L0QoCKQr17xWRe+Tc/Hbkx2B
         sku27mOGeNdszcWvjdJnNNzG31mBNxP06siwdz3hz3+BdmUHUHLga5tzd9L7CpCHOrRH
         n/h5CFP2q4R9pO9RkHr9EE9U1N+hCqoJR8qVPbm+7a4+aulArMC/U59vwvMRFwxSZCC8
         5GNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916971; x=1693521771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU7nBIlr13kHPh3ffj0Bs8FBEPhhunXghwLuQjfy248=;
        b=AHNRfN0ZJRpq/+PEXMhw8zf2lefdvj3UMwBbEd37qJHgyj7NUlQudy7ayZgzWHGxDl
         0aPhRWV/cOXGL9jZnZT1d2/yWLw4HtP0HUe2f+0HVKLVApyrkFI9mk6THmpNJqOvam3S
         L+zXFFlE6gzb78W+AHYjlkgj+paAGRb8jJlgo3WY8pLIR6fr1tDSqbewgscFriScaa5w
         n/FdqbjlM+N2Xjkm30GZK7mHdlS/XdSVriRrd/Eu9IZ6t7H2Kwe1URWveKk7+c6WRuDG
         tD5p5UrSGWTkMV9LwujGZgld+8wDjFwyM3aXrvidlobkV8n9lkdxhiJiOnApkF4rqvFp
         Aoeg==
X-Gm-Message-State: AOJu0YxiLBux+6vFMTDRk6XXmONopdY0zyXMReJ0MM4goM6Wf0TH+p+x
        chLHsAz6dvmZIFMyftyThXALKY3H2xrSsTn+JLmoLQ==
X-Google-Smtp-Source: AGHT+IH53BUBV63w3V83nXwdt/eBOtP9hHipVU0n+i9CYFUmyBscQNLJJWJFc4Ec9D7HwptgdQ5IHpOAz6a7zPWkI9E=
X-Received: by 2002:a05:600c:3b02:b0:401:7c14:948d with SMTP id
 m2-20020a05600c3b0200b004017c14948dmr75229wms.2.1692916971467; Thu, 24 Aug
 2023 15:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-3-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-3-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 24 Aug 2023 18:42:39 -0400
Message-ID: <CA+GJov7nzgmGmMooAj9BpQ267W6atcsZJ=tULQQJYjbuQL4E0w@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] kunit: string-stream: Improve testing of string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 24, 2023 at 10:31=E2=80=AFAM Richard Fitzgerald
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

Hello!

These tests all look good to me. I like all of the details and
comments. Great to see these additions to the string-stream-test!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> Changes since V4:
> - Test cases for appending empty strings have been squashed into this
>   patch.
> - Call to string_stream_get_string() is wrapped in a local function
>   get_concatenated_string(). This is to avoid a lot of code churn later
>   when string_stream_get_string() is changed to return an unmanaged buffe=
r.
> ---
>  lib/kunit/string-stream-test.c | 232 ++++++++++++++++++++++++++++++---
>  1 file changed, 216 insertions(+), 16 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 110f3a993250..2b761ba01835 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -11,38 +11,238 @@
>
>  #include "string-stream.h"
>
> -static void string_stream_test_empty_on_creation(struct kunit *test)
> +static char *get_concatenated_string(struct kunit *test, struct string_s=
tream *stream)
>  {
> -       struct string_stream *stream =3D alloc_string_stream(test, GFP_KE=
RNEL);
> +       char *str =3D string_stream_get_string(stream);
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
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);

As mentioned in the last version, if this causes a warning we will
look into it on the KUnit side.

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
> -       struct string_stream *stream =3D alloc_string_stream(test, GFP_KE=
RNEL);
> +       struct string_stream *stream;
> +       char line[60];
> +       char *concat_string, *pos, *string_end;
> +       size_t len, total_len;
> +       int num_lines, i;
>
> -       string_stream_add(stream, "Foo");
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> -       KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
> +       /* Add series of sequence numbered lines */
> +       total_len =3D 0;
> +       for (i =3D 0; i < 100; ++i) {
> +               len =3D snprintf(line, sizeof(line),
> +                       "The quick brown fox jumps over the lazy penguin =
%d\n", i);
> +
> +               /* Sanity-check that our test string isn't truncated */
> +               KUNIT_ASSERT_LT(test, len, sizeof(line));
> +
> +               string_stream_add(stream, line);
> +               total_len +=3D len;
> +       }
> +       num_lines =3D i;
> +
> +       concat_string =3D get_concatenated_string(test, stream);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> +       KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> +
> +       /*
> +        * Split the concatenated string at the newlines and check that
> +        * all the original added strings are present.
> +        */
> +       pos =3D concat_string;
> +       for (i =3D 0; i < num_lines; ++i) {
> +               string_end =3D strchr(pos, '\n');
> +               KUNIT_EXPECT_NOT_NULL(test, string_end);
> +
> +               /* Convert to NULL-terminated string */
> +               *string_end =3D '\0';
> +
> +               snprintf(line, sizeof(line),
> +                        "The quick brown fox jumps over the lazy penguin=
 %d", i);
> +               KUNIT_EXPECT_STREQ(test, pos, line);
> +
> +               pos =3D string_end + 1;
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
> -       struct string_stream *stream =3D alloc_string_stream(test, GFP_KE=
RNEL);
> -       char *output;
> +       static const char line[] =3D
> +               "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +               " 0123456789!$%^&*()_-+=3D{}[]:;@'~#<>,.?/|";
> +       struct string_stream *stream;
> +       struct rnd_state rnd;
> +       char *concat_string, *pos, *string_end;
> +       size_t offset, total_len;
> +       int num_lines, i;
>
> -       string_stream_add(stream, "Foo");
> -       string_stream_add(stream, " %s", "bar");
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> -       output =3D string_stream_get_string(stream);
> -       KUNIT_ASSERT_STREQ(test, output, "Foo bar");
> +       /*
> +        * Log many lines of varying lengths until we have created
> +        * many fragments.
> +        * The "randomness" must be repeatable.
> +        */
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       total_len =3D 0;
> +       for (i =3D 0; i < 100; ++i) {
> +               offset =3D prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +               string_stream_add(stream, "%s\n", &line[offset]);
> +               total_len +=3D sizeof(line) - offset;
> +       }
> +       num_lines =3D i;
> +
> +       concat_string =3D get_concatenated_string(test, stream);
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, concat_string);
> +       KUNIT_EXPECT_EQ(test, strlen(concat_string), total_len);
> +
> +       /*
> +        * Split the concatenated string at the newlines and check that
> +        * all the original added strings are present.
> +        */
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       pos =3D concat_string;
> +       for (i =3D 0; i < num_lines; ++i) {
> +               string_end =3D strchr(pos, '\n');
> +               KUNIT_EXPECT_NOT_NULL(test, string_end);
> +
> +               /* Convert to NULL-terminated string */
> +               *string_end =3D '\0';
> +
> +               offset =3D prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +               KUNIT_EXPECT_STREQ(test, pos, &line[offset]);
> +
> +               pos =3D string_end + 1;
> +       }
> +
> +       /* There shouldn't be any more data after this */
> +       KUNIT_EXPECT_EQ(test, strlen(pos), 0);
> +}
> +
> +/* Appending the content of one string stream to another. */
> +static void string_stream_append_test(struct kunit *test)
> +{
> +       static const char * const strings_1[] =3D {
> +               "one", "two", "three", "four", "five", "six",
> +               "seven", "eight", "nine", "ten",
> +       };
> +       static const char * const strings_2[] =3D {
> +               "Apple", "Pear", "Orange", "Banana", "Grape", "Apricot",
> +       };
> +       struct string_stream *stream_1, *stream_2;
> +       const char *original_content, *stream_2_content;

I would maybe consider changing the name original_content to
stream_1_content but definitely not worth it as this version looks
very good.

> +       char *combined_content;
> +       size_t combined_length;
> +       int i;
> +
> +       stream_1 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +
> +       stream_2 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /* Append content of empty stream to empty stream */
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_EQ(test, strlen(get_concatenated_string(test, stream=
_1)), 0);
> +
> +       /* Add some data to stream_1 */
> +       for (i =3D 0; i < ARRAY_SIZE(strings_1); ++i)
> +               string_stream_add(stream_1, "%s\n", strings_1[i]);
> +
> +       original_content =3D get_concatenated_string(test, stream_1);
> +
> +       /* Append content of empty stream to non-empty stream */
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),=
 original_content);
> +
> +       /* Add some data to stream_2 */
> +       for (i =3D 0; i < ARRAY_SIZE(strings_2); ++i)
> +               string_stream_add(stream_2, "%s\n", strings_2[i]);
> +
> +       /* Append content of non-empty stream to non-empty stream */
> +       string_stream_append(stream_1, stream_2);
> +
> +       /*
> +        * End result should be the original content of stream_1 plus
> +        * the content of stream_2.
> +        */
> +       stream_2_content =3D get_concatenated_string(test, stream_2);
> +       combined_length =3D strlen(original_content) + strlen(stream_2_co=
ntent);
> +       combined_length++; /* for terminating \0 */
> +       combined_content =3D kunit_kmalloc(test, combined_length, GFP_KER=
NEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, combined_content);
> +       snprintf(combined_content, combined_length, "%s%s", original_cont=
ent, stream_2_content);
> +
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),=
 combined_content);
> +
> +       /* Append content of non-empty stream to empty stream */
> +       string_stream_destroy(stream_1);
> +
> +       stream_1 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),=
 stream_2_content);
> +}
> +
> +/* Adding an empty string should not create a fragment. */
> +static void string_stream_append_empty_string_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +       int original_frag_count;
> +
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /* Formatted empty string */
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +
> +       /* Adding an empty string to a non-empty stream */
> +       string_stream_add(stream, "Add this line");
> +       original_frag_count =3D list_count_nodes(&stream->fragments);
> +
> +       string_stream_add(stream, "%s", "");
> +       KUNIT_EXPECT_EQ(test, list_count_nodes(&stream->fragments), origi=
nal_frag_count);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "=
Add this line");
>  }
>
>  static struct kunit_case string_stream_test_cases[] =3D {
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
