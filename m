Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B948A7F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 07:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiAKGvw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 01:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348336AbiAKGvq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 01:51:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2EC061751
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:51:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k18so30997041wrg.11
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvUeAegBbN2t7XZPXpjXropqbre3MN5PjxAyFdDVXy8=;
        b=fClPNCq1gbIhLUY0oORyPisVUYCFx2go4SFsXbaveQbet21Bh6PeApbUZjpiuYY/gs
         +TdenI7lwJdyuQnfpn/TnJkTdAS2b6TEmeXbk0EXMHOzce3tdF9PYL8pDuQgLMTOAHrU
         4LmoGIs7wKwU0KdXyAuJgs7MW/2R1XG3Qekc8RroGXFLaN4sFw3j1mCRImUM2L/9zgKj
         HPkV6IYu26y6YXI5DdTYZ2ayue5HfCo8UYLNP7ov22C0/lKnGg4trKy8L7wzBtoL6nvT
         7m+iMbI4yNY2+x2w0A2X/KszSdibg3EJC61kLmvMPnnlI6arcM+5xYbLufVTQsk45+Mc
         HAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvUeAegBbN2t7XZPXpjXropqbre3MN5PjxAyFdDVXy8=;
        b=WvNDXbPfNCOOWfI5rFY8zRnxP0BNAzpWG7wuQv3diPSsqhqAqjbMbSxw7y/1COvT4v
         pmVPS7iDJgtfmaIztRi+DaC0+G6/QZ/CPFy1VRh1bjP7fh4vXg2wQgmDiU7tSjR5lvIA
         xzoU0km4uJgC7qxqA++HBwwm52kRia+iOiH81/MLNulHTZKJwp1XPrebbbsVQdpYRr87
         1c+xAJU5s/86rvn6ueVjqDWVlS1/rEkmJFESm7uYpipe+VMb9w8ikpQfOD6LsglWNHJ8
         leO+ZM71vEvHS7a6B07pdvK2DQpFbtXvPH+UfpuPa0X1Dmd0mX1C4qCJDpNdedbC6gNA
         rJiw==
X-Gm-Message-State: AOAM533WHlq8Xh0CzJCqMPwMABCJCh1aouBayh8ej6w5KqJKZEUMJlsf
        jJGK7jIX+ZX1ydujYWYJVeZ5T/0kNjBUTpcRwthL/Q==
X-Google-Smtp-Source: ABdhPJxRT6S/xCWLMxNWCMX5VMNYulIQRzWES2torjkKuDX6004u60s96qWnFNNaOBOo/1byUIia+2fe3Rl4duBjUM8=
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2594807wru.80.1641883904288;
 Mon, 10 Jan 2022 22:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-5-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Jan 2022 14:51:32 +0800
Message-ID: <CABVgOS=oebdtvxVepSzWdWNVZTo-19MROmewb=DRszZd3YPV+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] kunit: factor out kunit_base_assert_format() call
 into kunit_fail()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 8, 2022 at 9:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We call this function first thing for all the assertion `format()`
> functions.
> This is the part that prints the file and line number and assertion type
> (EXPECTATION, ASSERTION).
>
> Having it as part of the format functions lets us have the flexibility
> to not print that information (or print it differently) for new
> assertion types, but I think this we don't need that.
>
> And in the future, we'd like to consider factoring that data (file,
> line#, type) out of the kunit_assert struct and into a `static`
> variable, as Linus suggested [1], so we'd need to extract it anyways.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>


>  lib/kunit/assert.c | 6 ------
>  lib/kunit/test.c   | 1 +
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index b972bda61c0c..4d9a1295efc7 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
>  void kunit_fail_assert_format(const struct kunit_assert *assert,
>                               struct string_stream *stream)
>  {
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream, "%pV", &assert->message);
>  }
>  EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
> @@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
>
>         unary_assert = container_of(assert, struct kunit_unary_assert, assert);
>
> -       kunit_base_assert_format(assert, stream);
>         if (unary_assert->expected_true)
>                 string_stream_add(stream,
>                                   KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
> @@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>         ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
>                                   assert);
>
> -       kunit_base_assert_format(assert, stream);
>         if (!ptr_assert->value) {
>                 string_stream_add(stream,
>                                   KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
> @@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> @@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> @@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>         binary_assert = container_of(assert, struct kunit_binary_str_assert,
>                                      assert);
>
> -       kunit_base_assert_format(assert, stream);
>         string_stream_add(stream,
>                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
>                           binary_assert->left_text,
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 5ad671745483..735c1b67d843 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>                 return;
>         }
>
> +       kunit_base_assert_format(assert, stream);
>         assert->format(assert, stream);
>
>         kunit_print_string_stream(test, stream);
> --
> 2.34.1.575.g55b058a8bb-goog
>
