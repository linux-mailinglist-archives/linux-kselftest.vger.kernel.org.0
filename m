Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58875787BF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 01:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjHXXXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbjHXXXY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 19:23:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888B1FE0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:22:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso17725e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692919362; x=1693524162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD51eiYcaQn5WhBvWvLxZwZ1h4UgqAmFPZTuFJKE3KI=;
        b=YDOum+1QrwiOwbVtsZhDKlIEOlY1Pe4rvQ+lBrmqh/vt+VqpGw0WF1PWWa83KIiJIa
         bxkHx+583GIuvh18kjtT32tk0Pd8jZOkSxXuyLIZQJK2U+w8EUVchMSsVjOPbcM8krHm
         EMqjA0IBZR6HdkEzh3NIBqD+JbyK/5tVHx7IDDsUxPVt2wn98huz8xl6U+VrlF0P+1x3
         jYOcbxBoVaL6KzT4q7TayFK6lV95MoRkdDXxeHONMTPUz3dLNtoIC7MONbGfhZDD3nvF
         hjEaqw8i5M/20uq/Fn5SNGcJUMgE47Czj4Il0Eeh7Y4pGer2JfOBSCtyAUdcnIgVOof+
         r59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692919362; x=1693524162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xD51eiYcaQn5WhBvWvLxZwZ1h4UgqAmFPZTuFJKE3KI=;
        b=mFkHu+Vxbo4ginb4RPbKBLFY1Yg1k0pp66DB8+ehyHgAY8F2nOTZ48pZ/dPjqbDm3N
         OJbmgiFiG6JUh8u/oKbYAb1jxry2sYeJ1KX2f05JEnCZJhteop3HyBeJsEeKq/0sn5Oq
         9fJaGmWNZc7ejmneIK8SRdYFVK2ksdpAxK0tkbujBb4e/wxfeZH62ZLPhkTLVlIMHX2o
         s+tfisUT6SPhGupvPpexUF8okMUsxeTSyf5DjwvClssfGHcclGf/LgiZfyq/Q0srk7dD
         TxvEiBdlYaClap5O40oay9P4XayCKoiSo/QDZmFNdERiO4WXLemuwNr2jyxBiG/lTk96
         fVhQ==
X-Gm-Message-State: AOJu0YzXdwWqvcjKMkBkx0TMyyHM4dgPrMVBI2uVGtw/LNs6d+zFIMbq
        DUPuapsJU3N5IQSQ4etrhWnsVSp92Ga2kt9gR/vMog==
X-Google-Smtp-Source: AGHT+IGVSRr7eLTlRHPkeJGhugZwnen04zrc3z0Cj0jn/IuZF/ez1W4nmQcOvEF/+LAVg6lR6TCoZTPgoQHKLON++EQ=
X-Received: by 2002:a05:600c:6027:b0:3f7:e4d8:2569 with SMTP id
 az39-20020a05600c602700b003f7e4d82569mr48096wmb.5.1692919362396; Thu, 24 Aug
 2023 16:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-5-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-5-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 24 Aug 2023 19:22:30 -0400
Message-ID: <CA+GJov5yLRrTOszc=yh4qBjXiU9swjZ0NdNuLkQWQZquH7g2ow@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] kunit: string-stream: Add cases for
 string_stream newline appending
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

On Thu, Aug 24, 2023 at 10:32=E2=80=AFAM Richard Fitzgerald
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

Hi!

This looks good to me! I like the changes.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> Changes since V4:
> - string_stream_append_auto_newline_test() doesn't clear the destination
>   stream_1 between the newline and no-newline case. This is just a
>   simplification of the code.
>
> - string_stream_no_auto_newline_test() uses the same set of test strings
>   as string_stream_auto_newline_test().
> ---
>  lib/kunit/string-stream-test.c | 93 ++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
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
> @@ -214,6 +215,45 @@ static void string_stream_append_test(struct kunit *=
test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),=
 stream_2_content);
>  }
>
> +/* Appending the content of one string stream to one with auto-newlining=
. */
> +static void string_stream_append_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream_1, *stream_2;
> +
> +       /* Stream 1 has newline appending enabled */
> +       stream_1 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_1);
> +       string_stream_set_append_newlines(stream_1, true);
> +       KUNIT_EXPECT_TRUE(test, stream_1->append_newlines);
> +
> +       /* Stream 2 does not append newlines */
> +       stream_2 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /* Appending a stream with a newline should not add another newli=
ne */
> +       string_stream_add(stream_1, "Original string\n");
> +       string_stream_add(stream_2, "Appended content\n");
> +       string_stream_add(stream_2, "More stuff\n");
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
> +                          "Original string\nAppended content\nMore stuff=
\n");
> +
> +       string_stream_destroy(stream_2);
> +       stream_2 =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream_2);
> +
> +       /*
> +        * Appending a stream without newline should add a final newline.
> +        * The appended string_stream is treated as a single string so ne=
wlines
> +        * should not be inserted between fragments.
> +        */
> +       string_stream_add(stream_2, "Another");
> +       string_stream_add(stream_2, "And again");
> +       string_stream_append(stream_1, stream_2);
> +       KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream_1),
> +                          "Original string\nAppended content\nMore stuff=
\nAnotherAnd again\n");
> +}
> +
>  /* Adding an empty string should not create a fragment. */
>  static void string_stream_append_empty_string_test(struct kunit *test)
>  {
> @@ -237,12 +277,65 @@ static void string_stream_append_empty_string_test(=
struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, get_concatenated_string(test, stream), "=
Add this line");
>  }
>
> +/* Adding strings without automatic newline appending */
> +static void string_stream_no_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       /*
> +        * Add some strings with and without newlines. All formatted newl=
ines
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
> +                          "OneTwo\nThree\nFour\nFive\nSixSeven\n\nEight"=
);
> +}
> +
> +/* Adding strings with automatic newline appending */
> +static void string_stream_auto_newline_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream =3D alloc_string_stream(test, GFP_KERNEL);
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
> +                          "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEi=
ght\n");
> +}
> +
>  static struct kunit_case string_stream_test_cases[] =3D {
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
