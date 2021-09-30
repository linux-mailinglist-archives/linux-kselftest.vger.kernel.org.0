Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5522541E490
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 01:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhI3XHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhI3XHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 19:07:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E17C06176C
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 16:05:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a131-20020a1c7f89000000b0030d4c90fa87so227894wmd.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0ppBwTzFJyZU29k8NnFVLUpHHN0JjRi2ilKWlfGyr0=;
        b=m2W5aSaVDKwfE3FNc+9wDnzbsnXUemJv1W/XOL/bODteZ54AjfeknMIk0XJmaHIXGk
         IiFldHCpDiSZXB27lktyzl2WdQPvYj3GRqi8aPca+9ZHwQcJmIG5J8FJN0hoAhaVb1k+
         naiQmaAMU4RBS1xtI88TWO0YEWcBcRQd9Uginpojd5BDJeMmA9NjJbdeQxKK2sCfQSUn
         5MChR5QLV+mKB60e4Q1RLjzDCuDr7HZm1GjYr8l2nOhDnuTm40eF28v517eCMIhPqBYk
         ZV6hrXHgC/yExiT/3vMJd8W88pibHT05YG3ZLzzvsXjQF9wswSfYciSVljvHFrnhA0ZX
         0qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0ppBwTzFJyZU29k8NnFVLUpHHN0JjRi2ilKWlfGyr0=;
        b=4AyMuAvtMOvEBbOSiiAOR0zGefTtIQicbC6PebBaWfS8ZTsYhojOY+BLHZAOTmljVw
         di5HCliGf/zLdanX7iyOLA7HGMw/S/m6Zle8Tywd/w6cyudDHNWU2qTeEVjlqi0jlGfr
         Uxe/ZWjIxQbb9dMbf/LgbcuBE8mVxXMKhi6AXZFMBd25+CDUa7mdQjtasjjpgNJT/wrD
         uD+6D8tRx5IazwncmRrIXUu6cJFUVSrMRO/FjPu91K6prtNC7qDxKw2ZcGAzxCJCLvct
         f3eqaraFUGKkiS3T5r98nvcZOK7prPu8oiw7HrUnpmSOyb7TFLP5ewKnudbawJ/DIYGm
         QRfA==
X-Gm-Message-State: AOAM5319Yzmwwu7IAawqzgzYqicQkBDGqBE75KWxd7XhKmHXyNCAH2lt
        32vBpUL/aQzN8qAO1fYtW8QLbde4+wCzWXAWFbHSrA==
X-Google-Smtp-Source: ABdhPJyQKGxZL9U7h8OsHsmjGbjG2xDqezB1BjC2QfAaVsqTUNY3IYI2VzP39BmKu96VSzdwhdlAS9X09q/4zRwh8Fw=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1390669wmi.7.1633043121905;
 Thu, 30 Sep 2021 16:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-5-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Oct 2021 07:05:10 +0800
Message-ID: <CABVgOS=SVHSrnTaa0hYsyn8KV_A7FCTaAmDx5ST6Jb2k4TXWSg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
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

On Fri, Oct 1, 2021 at 6:21 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The new --run_isolated flag makes the tool boot the kernel once per
> suite or test, preventing leftover state from one suite to impact the
> other. This can be useful as a starting point to debugging test
> hermeticity issues.
>
> Note: it takes a lot longer, so people should not use it normally.
>
> Consider the following very simplified example:
>
>   bool disable_something_for_test = false;
>   void function_being_tested() {
>     ...
>     if (disable_something_for_test) return;
>     ...
>   }
>
>   static void test_before(struct kunit *test)
>   {
>     disable_something_for_test = true;
>     function_being_tested();
>     /* oops, we forgot to reset it back to false */
>   }
>
>   static void test_after(struct kunit *test)
>   {
>     /* oops, now "fixing" test_before can cause test_after to fail! */
>     function_being_tested();
>   }
>
> Presented like this, the issues are obvious, but it gets a lot more
> complicated to track down as the amount of test setup and helper
> functions increases.
>
> Another use case is memory corruption. It might not be surfaced as a
> failure/crash in the test case or suite that caused it. I've noticed in
> kunit's own unit tests, the 3rd suite after might be the one to finally
> crash after an out-of-bounds write, for example.
>
> Example usage:
>
> Per suite:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
> ...
> Starting KUnit Kernel (1/7)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> ....
> Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/7)...
> ============================================================
> ======== [PASSED] kunit-try-catch-test ========
> ...
>
> Per test:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
> Starting KUnit Kernel (1/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
> Starting KUnit Kernel (2/23)...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] filter_subsuite_test
> ...
>
> It works with filters as well:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
> ...
> Starting KUnit Kernel (1/1)...
> ============================================================
> ======== [PASSED] example ========
> ...
>
> It also handles test filters, '*.*skip*' runs these 3 tests:
>   kunit_status.kunit_status_mark_skipped_test
>   example.example_skip_test
>   example.example_mark_skipped_test
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks -- this version works for me.

I think the requirement that test and suite names contain neither full
stops nor spaces is a reasonable one. There aren't any current tests
which would break it, as far as I know.

Cheers,
-- David
