Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F0388128
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhERUPm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 16:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhERUPl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 16:15:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C286C06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:14:23 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so10236346ili.9
        for <linux-kselftest@vger.kernel.org>; Tue, 18 May 2021 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4yq51jnaEpYr1mj0fdxPgkJkvktEB+YhgPxv+OfCmw=;
        b=COBfj+yqn2cS8Ym0dqgASbW+HUjnOLPy5U98goZImLjM3xShmgB6PjyuJCSolRztsm
         YIjhfiDQj3XRsSB9L28XRiyypiYbKdCKBWrxNWrYUeFQBhKXlKxd+OsytjtDbExd9SgT
         ODpHkO0BV6ljthw0txMNb0dcHYRwccT4RbnVBzBSVXYUQ5r++jizmqUdaHM3CmFxvokN
         oKLd412RlkLmkNh4s8klfYezkgrcsfu88Z410A9SKFeEkCCvhkXJsm5cC5u1J9Gca+75
         +QoCHeTGY8Q5Kw2uziZshbiA0QKZrccoauzWs9yDs7Yx9Eirtu7cX05fHHLXHuGX6BTi
         k2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4yq51jnaEpYr1mj0fdxPgkJkvktEB+YhgPxv+OfCmw=;
        b=j11J95XFBs9rSESwEAYFKy3c6b3w70nbBD0ZJobaYzEOa14IUbiQ1KxeylPQqZ1TLW
         cRSdC4z7oU9da3XMm9hgpIuu7lXrqGNkEFo7ITuDiZxbO6rHShRSsA6jZ48ecewUyYTc
         cqxi08mlCD/jA32GVk1vzY8cT2liGXfzq+NRIqEiC1Yv8xWNNme1vJgZXmzI0ATLLagx
         7aWc6yXAqSvw9GjDZkNl+EV8In334MKBtxpoWDWvJHlvo8SkKwLSs3zDhc6axoIruJoH
         c+puRmu+gvXrYBJbcNYNP1OxXREeKt80yHb7JGlYnDn1q5b6XVGMbSYFiQNJQv/jlAaO
         zm1w==
X-Gm-Message-State: AOAM533uu6MJLLBizc8Hz00WFL2nFzM9eRyM4/u3idgcJIRyHbmuZelU
        afv7XLoWAW2w41j0y1Z9NGhlzEM+kMMlhXaM19XMhQ==
X-Google-Smtp-Source: ABdhPJxrjMOgYuGI3QB3Hok+i4wUTYOykWv7xKKNSDHGVr9kw4mfNthVU3hj/29JzT3vfqyIJytLQopfuffFVIPqoUg=
X-Received: by 2002:a05:6e02:b2c:: with SMTP id e12mr6432139ilu.136.1621368862619;
 Tue, 18 May 2021 13:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210518035825.1885357-1-davidgow@google.com>
In-Reply-To: <20210518035825.1885357-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 18 May 2021 13:14:11 -0700
Message-ID: <CAGS_qxoAvQpX=Q4dZe6Rynfwmete6Vek5u9VYud8zLtqonGF8w@mail.gmail.com>
Subject: Re: [PATCH] kunit: arch/um/configs: Enable KUNIT_ALL_TESTS by default
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 17, 2021 at 8:58 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Make the default .kunitconfig (specified in
> arch/um/configs/kunit_defconfig) specify CONFIG_KUNIT_ALL_TESTS by
> default. KUNIT_ALL_TESTS runs all tests which have satisfied
> dependencies in the current .config (which would be the architecture
> defconfig).
>
> Currently, the default .kunitconfig enables only the example tests and
> KUnit's own tests. While this does provide a good example of what a
> .kunitconfig for running a few individual tests should look like, it
> does mean that kunit_tool runs a pretty paltry collection of tests by
> default.

From the perspective of someone trying out KUnit for the first time,
I'd personally
* try out `kunit.py run`
* then maybe grep for a test/suite name that sounds interesting.

So I'm strongly in favor of the default running a wider variety of tests.
The build and execution time is still very quick, so no complaints there.

I also think this makes the set of (most of) the existing tests more
discoverable then grepping around for #include <kunit/test.h> or
similar indicators.

But I'm also biased in that I like seeing larger numbers of tests.

>
> A default run of ./tools/testing/kunit/kunit.py run now runs 70 tests
> instead of 14.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  arch/um/configs/kunit_defconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> index 9235b7d42d38..becf3432a375 100644
> --- a/arch/um/configs/kunit_defconfig
> +++ b/arch/um/configs/kunit_defconfig
> @@ -1,3 +1,2 @@
>  CONFIG_KUNIT=y
> -CONFIG_KUNIT_TEST=y
> -CONFIG_KUNIT_EXAMPLE_TEST=y

I think it's maybe still useful to have an example of selecting a specific test.
I'd lean towards keeping one or both of these.

KUNIT_TEST might not be as clear as KUNIT_EXAMPLE_TEST, so I'd lean
towards keeping that one, if we don't want both.


> +CONFIG_KUNIT_ALL_TESTS=y
> --
> 2.31.1.751.gd2f1c929bd-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20210518035825.1885357-1-davidgow%40google.com.
