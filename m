Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BCC24A881
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHSVaQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSVaQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:30:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AEC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:30:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v16so37748plo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4HmIdyoBmXa8bkZpNumWiq3Il4t2eScz31sD6PXX/8=;
        b=LzHyIxwxQomF+vwcfBJ/wkdpfAg5oSLCfChvQzGOt35G+kfh3rTm0ZnvD5izA0tBnl
         Jc26yTxW8LPFJSedWNocy9HsICLGj7EAfvUG5VtOwEoG7yeaN5PLuw2GLxAk4tlRRyVr
         iVVYvp0Q1xDUF3awSzz7/gX4VpseJgpZrKAJu8F78NoELp3Ax3CHspGAXBNh5VWamwce
         6KUltCZzJ8VISkoiKmk08zfssHJ+kjaClWuYS4z2HPYtlSQX1loZkZdT44tAUmNfZKTw
         mCCNbrtnJI2Lp+kNvoKYD7NUqn99mt6C/ajSFf/V4utAwhuHQDgYL49oakCD4AvW+F+j
         7hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4HmIdyoBmXa8bkZpNumWiq3Il4t2eScz31sD6PXX/8=;
        b=eTDVz9GEJvuuMMup1oQbScwEcucSrY7NRGuKqcED22hDVrEw8LFk8iDw6t+ROeG8Kj
         P9PIWkT6OF0Wq9WxvPPWm8FuGACQLDTb/PRTxgSG1Q77WkhpaLERTT6efzTldJ4+3rkv
         4EL7Huu3CKPb2AvhOP9juQqy0FOPBe9gpgVtZMFkjQ8xPm+pMpXTwHA4EdJXir0nAHHG
         K9uBCFmQ1ADPR6IJCqf9KXnRhm/Z4fDprnPE0LrKBLdbOxRJ/PjZFcTyZ8l+kYyCNX3m
         zVsO/C+QO6IIBQCexWjw1cCHr8RZJeZsV5ouMtL2nFWsM062GJhLP24n+suebUwRBZRn
         HGhg==
X-Gm-Message-State: AOAM531C1RBUEoavkv40QjjqrBw4nM/vBdU83xVeLHzUPl8eEwRBOUoH
        VYFk+uEOa9fsNDYjTwLdYUXchPAdBt+QXFFU3tVQ4w==
X-Google-Smtp-Source: ABdhPJwKDzgJeqCba5RnsNXuHqPXbk2gkIIWoy+1Kv/N+HGJOGjTDlTIEKuxXw8RAASJaziJiQ8ofTFcWNHRyyTvwEo=
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr51370plg.297.1597872614809;
 Wed, 19 Aug 2020 14:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194634.68976-1-vitor@massaru.org>
In-Reply-To: <20200819194634.68976-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:30:03 -0700
Message-ID: <CAFd5g45AuxZYY_92rOXwtVjmbaGuts+DV6WpqhHNxWYNotxq+g@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix: kunit_binary_assert_format() only prints
 signed int
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 19, 2020 at 12:46 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Some tests, such as overflow_kunit(), uses unsigned int,
> But kunit_binary_assert_format() only prints signed int,
> this commit also deals with the unsigned int print.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  lib/kunit/assert.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 202f9fdeed0e..3ae90c09986a 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -104,12 +104,23 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                                   binary_assert->left_text,
>                                   binary_assert->operation,
>                                   binary_assert->right_text);
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> +
> +               if (binary_assert->left_value - 1 < 0) {
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> +                                 binary_assert->left_text,
> +                                 binary_assert->left_value);
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> +                                 binary_assert->right_text,
> +                                 binary_assert->right_value);
> +               }
> +               else {
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu\n",
>                                   binary_assert->left_text,
>                                   binary_assert->left_value);
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> +                       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu",
>                                   binary_assert->right_text,
>                                   binary_assert->right_value);
> +               }

I agree that you found a bug here; however, I disagree that this is
the correct fix. Given that the value is stored as a long long; isn't
the value always stored as a signed value? So if the value overflows,
won't it still not pass the check you have here?

>         }
>         kunit_assert_print_msg(assert, stream);
>  }
>
> base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> prerequisite-patch-id: bf4b0962b0b955e4e45f5d25fece889562118158
> --
> 2.26.2
>
