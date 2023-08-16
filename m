Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A977E9FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjHPTzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345902AbjHPTy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 15:54:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC3E6B
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 12:54:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso23335e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692215693; x=1692820493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjHULN60LOK6sMroIvytXpZMa57ES8qNRCsKudjX8T0=;
        b=e0cb4tMwDk5FMZ86vb49ETWHd7bZ0WItpn8UQPzDfIe1jbynr1yxDbCITBLCuDZOFl
         XmaIRuUvZgLO0dWdUFHtetnDPcNDt6PpBPdPBM3vpcyoTX0ExaGkN/fc8Ty5mymP4fpN
         o2MouqVjylabsIg7eyRaF+qilh4Q4yjVPJQZx0kI+y5D8bfKG0Ium/eBFF9i4tGGHksP
         tAofU+M1r+VYnVIf2iEmJDaigIkyvsuaO+LDLugfcNbVzYgN/qQyut8q9EJqTT75egsR
         sybKjUaHddllcd8qRgFvuD5V+gO0wBj5GDntBd06/civOlppWuD/mtwmvJyNd+rmVZRP
         /uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692215693; x=1692820493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjHULN60LOK6sMroIvytXpZMa57ES8qNRCsKudjX8T0=;
        b=aKNkPYmGsYQ/2DXNyQU8v8UfkLId4IcKjcpZ6ukyJ7Qsq7mhG+oKoXEngYPNtgPOW6
         Dwv8ny55RivxzvylmQhpl8kVWZu/FNvsV+hq7VZ25KGi693R4YCwfkwhERjNFbOPvWFE
         +ZTMT6S9pR6dFCc882NRUkGlHMajXvVniH92TD3f4rqOr5AWD7D6LCqbtmrQNtDUyuti
         DVYEo5nEbx/hXZMzZbMKAYu9y7retm4Pld/ErylJYZ/+O8fbao0s6DO1W3Y5hKvPPDp7
         6ZXC+LsWdHUJlOCp/nOG6THrBdLwJi3rmlXBeNhSW445vCU6+seJL+Sj/UPdIMXMfx5O
         nodQ==
X-Gm-Message-State: AOJu0YyHuY+eYuYSUQ46j0nW5+OP9MgwPmM33iPYfq4MxUJHY8srvxJg
        fs+th0xoypAoDwNKpr4ptPNAohk1E7KTob+XtqfYIQ==
X-Google-Smtp-Source: AGHT+IFPfs6lZhWG6fWNy5jBPku/jodi0a7zo8JNNUQnt8oIZUUqIwbRxTcO715QlvgAOk7BEKFAL9odg5VViqJe+7w=
X-Received: by 2002:a05:600c:4708:b0:3f6:f4b:d4a6 with SMTP id
 v8-20020a05600c470800b003f60f4bd4a6mr1362wmo.7.1692215693407; Wed, 16 Aug
 2023 12:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132309.32641-1-rf@opensource.cirrus.com> <20230814132309.32641-6-rf@opensource.cirrus.com>
In-Reply-To: <20230814132309.32641-6-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 16 Aug 2023 15:54:41 -0400
Message-ID: <CA+GJov6haKmH5Hyt=Pck8kUim8k0X+sNNWGjK4huMRYBDuOpBA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] kunit: string-stream: Add cases for
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 9:23=E2=80=AFAM Richard Fitzgerald
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
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

These two cases seem very clean to me. I appreciate the organization
and commenting on the tests.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream-test.c | 51 ++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index efe13e3322b5..46c2ac162fe8 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -23,6 +23,7 @@ static void string_stream_init_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
>         KUNIT_EXPECT_PTR_EQ(test, stream->test, test);
>         KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_FALSE(test, stream->append_newlines);
>
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
>  }
> @@ -226,12 +227,62 @@ static void string_stream_append_empty_string_test(=
struct kunit *test)
>         KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream), "Add t=
his line");
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
> +        * Add some strings with and without newlines. All formatted
> +        * newlines should be preserved. No extra newlines should be
> +        * added.
> +        */
> +       string_stream_add(stream, "One");
> +       string_stream_add(stream, "Two\n");
> +       string_stream_add(stream, "%s\n", "Three");
> +       string_stream_add(stream, "Four");
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> +                          "OneTwo\nThree\nFour");
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
> +       KUNIT_EXPECT_STREQ(test, string_stream_get_string(stream),
> +                          "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEi=
ght\n");
> +}
> +
>  static struct kunit_case string_stream_test_cases[] =3D {
>         KUNIT_CASE(string_stream_init_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
>         KUNIT_CASE(string_stream_append_empty_string_test),
> +       KUNIT_CASE(string_stream_no_auto_newline_test),
> +       KUNIT_CASE(string_stream_auto_newline_test),
>         {}
>  };
>
> --
> 2.30.2
>
