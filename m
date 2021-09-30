Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748C341D16A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbhI3CbL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 22:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3CbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 22:31:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AFC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 19:29:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so1949370wrb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 19:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBQ+fBqDufsZ2pR8Xs3PtO6hk0wPJayHkkMAyHuIi34=;
        b=EfuvwwpifNif07V/TXk0XigOLO/sb0r5QM4s8dgLsMzYO1El6z53yKSVCTRHk2uNeY
         9gBZG3OwmIWvrydxCyBCZflkQ0JfAFKS2cyqneYBfPXSOT5ttikZoziGgZokFGurfw3F
         rfrdp9TDhTgTrTtISOHvaVZ3WktooGW74MNfxeTWmULfBbj5IMMUTYMkkME0468pT/Kg
         AbINvei0os7aMIegWOB1aFE4D/Lx6F6GjP2pLISdNHfbvUhgGxqIuWqm37X0hAujbnjv
         UPetHiD+57qXQnPAFWe/jO+FsX+3Is/znOjc5fEFTLLmPLgsEUEq5pQQ0uRjelpSEdK6
         ilMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBQ+fBqDufsZ2pR8Xs3PtO6hk0wPJayHkkMAyHuIi34=;
        b=ZKsGYYlO3XHqdJjXh5K7zx63UzVHqcyUIEl1HrlSmLVU2/JqNYoZ+jSRySOc+NyYcK
         BjO3888xwierlKZePIyf4lPdjYEnsXN2vtmVQJ6WgiDhwgz5M9xco3P9Wg/x7R5XdfVK
         HmbJEKd0EFW4aFNPOY48H3TSyrd0kdUZs9/BbMhHSKYaOebTVxY+o3UdGLsyGrIODQav
         JFX7SIXmsMwCA546beGK3Qkm1F/73tW71NlRCBwQkOUynGLmtW4hxLMIx4UkaYjrFm9x
         clWxA0nRCselOZVylKcxZGlMNIeyXYS6e8IATn9LEy6llvuCIJTFMz6wZ39+o2kOTDNz
         PPWQ==
X-Gm-Message-State: AOAM533djTvbmGS+EetGrLa/e67gg3iX5vyQwnbDEz41AFTrHe1+n/XZ
        +fBrJbqZK9AnwK9at5HKdvkgkpPr0qVEJ+W0e6MZYQ==
X-Google-Smtp-Source: ABdhPJzRiRV6qDjf56A7NSUtAMTXlkbO4pQs0kSE/pzCmZDMa+Oi2afBja47mDpohYgkoYAaRSoJ7t6YUoMlHRLR4z8=
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr3377012wrl.200.1632968967342;
 Wed, 29 Sep 2021 19:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210929195436.1405996-1-dlatypov@google.com> <20210929195436.1405996-4-dlatypov@google.com>
In-Reply-To: <20210929195436.1405996-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Sep 2021 10:29:16 +0800
Message-ID: <CABVgOSk_kj4w74gP8og_x07AQgwaF0WkH5-hmkoEdcviQb5_tQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kunit: tool: actually track how long it took to
 run tests
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

On Thu, Sep 30, 2021 at 3:54 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is a long standing bug in kunit tool.
> Since these files were added, run_kernel() has always yielded lines.
>
> That means, the call to run_kernel() returns before the kernel finishes
> executing tests, potentially before a single line of output is even
> produced.
>
> So code like this
>   time_start = time.time()
>   result = linux.run_kernel(...)
>   time_end = time.time()
>
> would only measure the time taken for python to give back the generator
> object.
>
> From a caller's perspective, the only way to know the kernel has exited
> is for us to consume all the output from the `result` generator object.
> Alternatively, we could change run_kernel() to try and do its own book
> keeping and return the total time, but that doesn't seem worth it.
>
> This change makes us record `time_end` after we're doing parsing all the
> output (which should mean we've consumed all of it, or errored out).
> That means we're including in the parsing time as well, but that should
> be quite small, and it's better than claiming it took 0s to run tests.
>
> Let's use this as an example:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit example
>
> Before:
> Elapsed time: 7.684s total, 0.001s configuring, 4.692s building, 0.000s running
>
> After:
> Elapsed time: 6.283s total, 0.001s configuring, 3.202s building, 3.079s running
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks for looking into and fixing this: clearly I should've noticed
it before. :-)

Including the parsing time as well doesn't worry me: as you note, it
should be negligible.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 31eec9f6ecc3..5e717594df5b 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -101,12 +101,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
>                 filter_glob=request.filter_glob,
>                 build_dir=request.build_dir)
>
> +       result = parse_tests(parse_request, run_result)
> +
> +       # run_kernel() doesn't block on the kernel exiting.
> +       # That only happens after we get the last line of output from `run_result`.
> +       # So exec_time here actually contains parsing + execution time, which is fine.
>         test_end = time.time()
>         exec_time = test_end - test_start
>
> -       # Named tuples are immutable, so we rebuild them here manually
> -       result = parse_tests(parse_request, run_result)
> -
>         return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
>
>  def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
> --
> 2.33.0.685.g46640cef36-goog
>
