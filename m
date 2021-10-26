Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3443BD9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 01:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhJZXLI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 19:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhJZXLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 19:11:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB747C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 16:08:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g141so867621wmg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSV6Ft6zAu1jkbpHI7z7p0QwFJUvX7Q+m/djpD5eMGQ=;
        b=APKmkyYkLJxj5o9ZLwSTljNtuMGy5RpTE0BOfsldRr2a4d9/duXUZKJGl62dLqEouh
         2HCND4JByvSL0uGxvDFeQdBh2UGhJg8pE8BW8Jl3bURmVkwTCLY++ENHe7rcqjm5iqL/
         C1SKm0ls1xUcMztWsUQ6TuR9U8ZPA53xfC8AqcxvSusu2atI6R8L7p1JRvR00Pdxvymx
         9Yw6rOpnr2nfzf0qlZU2oA66sWt8vZw6rL+T+AJtZs9OFYREUMRwMJFDx99K7EMgLkZ6
         fmRre32IKdZPMF55GKv6rHvW17nv9exCd6ZxVrgUtn/b33ipALiQQR+tNfd5WQ1r4YwU
         2EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSV6Ft6zAu1jkbpHI7z7p0QwFJUvX7Q+m/djpD5eMGQ=;
        b=FWXDFBEzzyd3OHlV+BnMbQpElE99vO9cj6onjDJP4UWmfuT6eKr05areNTdMRfdV2Z
         5k3Nflh05u5dcb1AUwlczR0N1ql3EyLaVhBhYSZUKuxmvFbmyTVEK25aaJOlBWOU2bqe
         89tJYjNAwpIV+qUo7fzxSd7S/QTVNZwoe+NmwAFT/T6mhn1OMnAWC//jRPZPxhZQ6skD
         cBHtLVhGMIMWn8PrUWVjuGzFNhJ1StjEmKh4sTfCXCWxfQ+vaPf6sitwo4jQtMGTnu6e
         CEMv78MS8x29Jta2Hu73Z00hMD0/kdXf4vMgoBLdVUih67fPUkuTwPNNOAy8Vs20O372
         zMIg==
X-Gm-Message-State: AOAM5314kEMGyqTLoT4Ox4hzm3CmeeCPy+l73RuqsgAtIOd7V4w1aANP
        V8EfQgMnrVpHfTZKa12m62WdGTHlJBfz1kbDcr0CbQ==
X-Google-Smtp-Source: ABdhPJy4W3Y0kS0tSehWOfSkiwmO09a7tuKF6lYhyraCB8ay2PowxlgpetT0jxFNzQFp2hNsXOKv3sMkQNZSdH5MaeE=
X-Received: by 2002:a7b:c103:: with SMTP id w3mr1770472wmi.179.1635289721986;
 Tue, 26 Oct 2021 16:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211026153638.3857452-1-dlatypov@google.com>
In-Reply-To: <20211026153638.3857452-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Oct 2021 07:08:31 +0800
Message-ID: <CABVgOSnfJT2jaXCEtewo+DRk73=G-bVWu8pgXj54p40qMDVgnw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: remove claims that kunit is a
 mocking framework
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 11:36 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> KUnit does not have any first party support for "mocking".
>
> The original RFC had some, but the code got dropped.
> However, the documentation patches never got updated. This fixes that.
>
> https://kunit.dev/mocking.html has a current writeup on the status quo
> and will hopefully be eventually folded into the in-kernel
> Documentation.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Yeah: this definitely is a bit misleading. Thanks for updating it.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/api/index.rst | 3 +--
>  Documentation/dev-tools/kunit/api/test.rst  | 3 +--
>  Documentation/dev-tools/kunit/index.rst     | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index b33ad72bcf0b..3006cadcf44a 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -12,5 +12,4 @@ following sections:
>
>  Documentation/dev-tools/kunit/api/test.rst
>
> - - documents all of the standard testing API excluding mocking
> -   or mocking related features.
> + - documents all of the standard testing API
> diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
> index aaa97f17e5b3..c5eca423e8b6 100644
> --- a/Documentation/dev-tools/kunit/api/test.rst
> +++ b/Documentation/dev-tools/kunit/api/test.rst
> @@ -4,8 +4,7 @@
>  Test API
>  ========
>
> -This file documents all of the standard testing API excluding mocking or mocking
> -related features.
> +This file documents all of the standard testing API.
>
>  .. kernel-doc:: include/kunit/test.h
>     :internal:
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index cacb35ec658d..7af7dec83646 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -19,7 +19,7 @@ KUnit - Unit Testing for the Linux Kernel
>  What is KUnit?
>  ==============
>
> -KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
> +KUnit is a lightweight unit testing framework for the Linux kernel.
>
>  KUnit is heavily inspired by JUnit, Python's unittest.mock, and
>  Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
>
> base-commit: 2ab5d5e67f7ab2d2ecf67b8855ac65691f4e4b4d
> --
> 2.33.0.1079.g6e70778dc9-goog
>
