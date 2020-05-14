Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9621D3DA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 May 2020 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgENTgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 May 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENTgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 May 2020 15:36:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8673CC061A0C
        for <linux-kselftest@vger.kernel.org>; Thu, 14 May 2020 12:36:04 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j4so3317457otr.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 May 2020 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mB8eiiLNg/9uJ3nUxq/59BVSbCYvlFaWEg3uZJv8hY=;
        b=gbnfcEGyjeI2E05TrmYnpbwO5XUejuKLbsbfrYHUGBGhzXIfKiaSJxWicb5N9NCYXW
         GgYgl4zbUlTIApjgtdTSRPdDIVkeB2irPolCipFB5kshPF5Y8JSOno5jkZzxLeOgmTBA
         Khm1PuSmasV1okZgPN0wEhJ5FpwHNTQgUrqD7kuusrZVDPFEwMJqKWROLlNg+VD9saM1
         zo6geu9ijH30I+HzUS0S0ko1pe/p6ezJMWrpUw+GPieAzEKOzZXw10hS+DmoEXNJF7yu
         DLLhyWlNbOxS/Mqzt4igaQYo6zd7p2jg1Yhot90+cQvX8PLiDDZmfLIY/VXizJUffaey
         yAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mB8eiiLNg/9uJ3nUxq/59BVSbCYvlFaWEg3uZJv8hY=;
        b=BxkVN5iAaueFyNuuwkI81qiP+jZW2c6R7dNQ+9B4AgXp3qvJFbUPwplMZRlBhVbM85
         is4ViGmGADMh/hVMJ8lSen+Gz4rKBkoqOhSFdKZt09LmZtMj/Mj7MOTJ4SYpop4sFsRz
         vWkCuuqa7I6lND/XrVc9sM7ywhBJ6K5MnO3r2ISdJWKZF74PcB1ufBHj2CAeo/QDriyI
         DuA9ALRiQTtsLSVMsgh2ufN+kDBpH26DRzdKOwqktb8Bg1nd90ysyJtPN5IPiR7iNo2J
         Sx6CJEto5bIQ7IxiLOOkJKVHnwbd0qzD4kC/wA+UE+3ENbAyEG85+ZlRGGgLT0zagH2I
         eAqw==
X-Gm-Message-State: AOAM533AkBUFPcA5P6HT1vV7dk/5YK8uz9wurS0ZvyN9vyUlGJ64qbM9
        Hphnb7oBJreCeI5/sU+aumW1/T5eRIgZclr38ThVxA==
X-Google-Smtp-Source: ABdhPJxzXMbOXADm7edX7KBcGIZwn9CE69pYU7XfrV+RF4T8zgJb4e8inNsnKPyJ3tbNEN/48TKx17tf/NonaZ9sMkI=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr4430416oto.251.1589484963699;
 Thu, 14 May 2020 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200513042956.109987-1-davidgow@google.com>
In-Reply-To: <20200513042956.109987-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 21:35:52 +0200
Message-ID: <CANpmjNOzxt3QL8BR+J+GDT=5BJkEQqEeXXJgqWx7JZAR6G8sHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 13 May 2020 at 06:30, David Gow <davidgow@google.com> wrote:
>
> This is a proof-of-concept to support "skipping" tests.
>
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
>
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
>
> kunit_tool will parse this SKIP directive, and renders skipped tests in
> yellow and counts them. Skipped tests do not affect the result for a
> suite.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Following on from discussions about the KCSAN test[1], which requires a
> multi-core/processor system to make sense, it would be useful for tests
> to be able to mark themselves as "skipped", where tests have runtime
> dependencies which aren't met.
>
> As a proof-of-concept, this patch doesn't implement some things which
> we'd ideally like to have (e.g., non-static "reasons" for skipping the
> test, maybe some SKIP macros akin to the EXPECT and ASSERT ones), and
> the implementation is still pretty hacky, but I though I'd put this out
> there to see if there are any thoughts on the concept in general.
>
> Cheers,
> -- David
>
> [1]: https://lkml.org/lkml/2020/5/5/31
>
>  include/kunit/test.h                | 12 ++++++++++++
>  lib/kunit/kunit-example-test.c      |  7 +++++++
>  lib/kunit/test.c                    | 23 ++++++++++++++++-------
>  tools/testing/kunit/kunit_parser.py | 21 +++++++++++++++++----
>  4 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..7817c5580b2c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -178,6 +178,7 @@ struct kunit_suite {
>         /* private - internal use only */
>         struct dentry *debugfs;
>         char *log;
> +       const char *skip_directive;
>  };
>
>  /**
> @@ -213,6 +214,8 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +
> +       const char *skip_directive;
>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> @@ -391,6 +394,15 @@ void kunit_cleanup(struct kunit *test);
>
>  void kunit_log_append(char *log, const char *fmt, ...);
>
> +#define kunit_mark_skipped(test_or_suite, reason)                      \
> +       (test_or_suite)->skip_directive = "SKIP " reason
> +

Would it be useful to make this accept any string possibly with a
format? Otherwise, the reason will always need to be a constant string
here.

I'm fine with printing more detailed info via pr_warn() or so, if
that's an unreasonable request.

> +#define kunit_skip(test_or_suite, reason)                              \
> +       do {                                                            \
> +               kunit_mark_skipped(test_or_suite, reason);              \
> +               kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
> +       } while (0)
> +
[...]

This looks good to me. One question I'd have is: will this work in
test_init functions? Because in the KCSAN test, the test setup
determines if we have enough CPUs, and then causes test_init to return
a non-zero error code.

Thanks,
-- Marco
