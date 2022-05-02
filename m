Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F151778D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387169AbiEBTrp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387164AbiEBTrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 15:47:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A3766D
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 12:44:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g23so17728160edy.13
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDKVWt6i2JVgFk5hQ0cN9rigyvuCgGuIi+Y1yp/hEyU=;
        b=TLtjDxEJVxuw3SDFmLZl8TjFa8ejjCV3hSGdqXW2sRhBwizgDwOo86ygS46gw7eTvm
         PBhdDyHf67jHns5ihyVOs1EfqxVt7ghQtbNRbE/sVB6sTp68ZpTvEkvn3tJjmmNJvSRw
         RDQaqk4afuv9yqUsvbQy0Go1AgpdtuumIJ1g92KJ3ZiNk0T9CXWokaS+GAGSn0I0TjTh
         Wv5u0d1BjKgGgVdwosc4UX/r5t9UGsx8DdITX0PmNMYzh34kmaq6gakslFC0c6AfQkmZ
         7Dd+xJKBepC2+GMa3teQ1Z8xFFTEe31e1TKdpiAWN0Ic48syWs7ikQFT09Hing9UxufT
         +e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDKVWt6i2JVgFk5hQ0cN9rigyvuCgGuIi+Y1yp/hEyU=;
        b=SyKOoJ9wPUDG5e8c+8MG9UwYu71WcfA13yk463QqsiEA8Ko8epfxohVPvom72urM8A
         /omx06ezw5dTr4I12Q3mzLzchfuJAEwXBv2WVGUZp5heFJQDQpSqoYvcMTxD/TtXhxT2
         Ra/QyR17emN2ZiGvNL+DaUks5I+n8N2JEZxP4SLwt09Ef6SRDohkC/FOUl+HHhR1rpKd
         MzdM7r4mR5DCIyuAeDkY6gARCHXGreq+drl6ruJqWjb5D24xcqsH3lLq3GHDfrkulCtv
         MJpvVNMYifnKh1WGJa7mxkcofZKVE/p1vG6x+6oca+BnnUm2uCxz+AiAVNDq/TkeudPr
         bKlg==
X-Gm-Message-State: AOAM530L4SaZKhvUsT1HE2lfxkPrTio0zoUUkKlgnNYbSzKHsI+hrTq6
        BJNY6OXwZIjqaYAt4VRt6H1X1OmdHTIToW0yGNXW/XpoJfs=
X-Google-Smtp-Source: ABdhPJyun65U+qmsvNP0CPUrRwCwtM7NXVQ4tmjQOfX2KctcnsTKxhSP1ggdLyYcwj+iiMCezATnBVAevDvBMIb1V2g=
X-Received: by 2002:a50:d585:0:b0:425:c9db:cf26 with SMTP id
 v5-20020a50d585000000b00425c9dbcf26mr14841032edi.222.1651520651119; Mon, 02
 May 2022 12:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220502093625.GA23225@kernel.org>
In-Reply-To: <20220502093625.GA23225@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 2 May 2022 14:43:59 -0500
Message-ID: <CAGS_qxoc=AnkzUtaFpJvF08Z_Z15h9sZxYNQT5-S9C7aM4poEg@mail.gmail.com>
Subject: Re: [PATCH] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 2, 2022 at 4:36 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
>
> Therefore, the whole chain may be made `const`.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for this, the code definitely should have been this way from the start.

I had wanted to make this change but mistakenly thought the format
func took it via non-const for some reason.
I must have misread it once and got it into my head that we were
leaving the door open for mutable child structs (which sounds like a
bad idea).

> ---
>  include/kunit/test.h | 2 +-
>  lib/kunit/test.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 00b9ff7783ab..2eff4f1beb42 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -774,7 +774,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
>  void kunit_do_failed_assertion(struct kunit *test,
>                                const struct kunit_loc *loc,
>                                enum kunit_assert_type type,
> -                              struct kunit_assert *assert,
> +                              const struct kunit_assert *assert,
>                                const char *fmt, ...);
>
>  #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 3bca3bf5c15b..b84aed09a009 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -241,7 +241,7 @@ static void kunit_print_string_stream(struct kunit *test,
>  }
>
>  static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
> -                      enum kunit_assert_type type, struct kunit_assert *assert,
> +                      enum kunit_assert_type type, const struct kunit_assert *assert,
>                        const struct va_format *message)
>  {
>         struct string_stream *stream;
> @@ -281,7 +281,7 @@ static void __noreturn kunit_abort(struct kunit *test)
>  void kunit_do_failed_assertion(struct kunit *test,
>                                const struct kunit_loc *loc,
>                                enum kunit_assert_type type,
> -                              struct kunit_assert *assert,
> +                              const struct kunit_assert *assert,
>                                const char *fmt, ...)
>  {
>         va_list args;
> --
> 2.35.3
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220502093625.GA23225%40kernel.org.
