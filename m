Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5471B2A135F
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Oct 2020 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJaEB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 31 Oct 2020 00:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaEB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 31 Oct 2020 00:01:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6727C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 21:01:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so9072407ljk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Oct 2020 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETtqSrQhvAh1kNurb1hmA5QcXFWk0AIhIay9EmRKULE=;
        b=mHiQjW815EHewCpRcXjUgBXggmms34FwzyqgZC7aIm7n7geiTuNeF6EswiM3Kc5kGl
         t2+6HJ8eps93bd1YNv9SKTmKsI7gyrbrjV28ZsxCY2v6ByoLzBiH+5jrmDxoxVMUqfvA
         Ffqe9ZoutlC3Ze5SJeQqUGtZEHclUOYjOtacm/IzhtsBN7OHXZmR4vs4r1sGhbmqoLJ2
         XnnGTLf7aWYLEytSagawhVKvtbd/AbZSBlRqHcuzK6NPY1judRZpwjNJ7YXQlzshiW6i
         XxtpqSKNUlJav9eXYp3QlnxgopIZIC8VUjtj+GJEhfa9C9/V1mLOEg8CubWdn830KE3O
         WSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETtqSrQhvAh1kNurb1hmA5QcXFWk0AIhIay9EmRKULE=;
        b=pVWXcVIneGEBIBlUmghbNpcwGUyyW86M3jznEwpeHf7gDQJ+rBkJ5E4Sgu4ppDuDFD
         YqfdpVVA1oXlyMyCuCVn+kjS7zLihclWOafWhacD4JLpopHfeGTBlWUE5+mLzCZYc323
         lhNfeUiCM1dLRr8RdBxRDdfAembDjRJPCqMTP+yv2stO/xUYIXnR4mRyLAExhwqmP5kH
         jwL1w6L2HAOOBSbYFu9uJKm/p+BlyBDX6ynZRj4wU+S2Hv/G9RRF3KsFrtoCTkgoku7m
         vZx3VM6H5WAo7bMjxXddmZTuBAmuKJssvU5AhtVoXKzDAYWtwDACPamQ6U9sreaoZyth
         fx1Q==
X-Gm-Message-State: AOAM533mq1YoW/jd6Wk3ow3xwZWdGQVuKArcc4jaVx+LHF5G+raFbzEx
        zm9YYwxPVKR3TpAC0q0mI2kjkasqWkJOocKD9zEJWA==
X-Google-Smtp-Source: ABdhPJwLljGjbuVkn45WqSFbkW+Y4oSPE4gIh9HxQfVQ2vX401iUH6Xg48APQHoBApEEU5fyzmueYps8M0P75O01c+Y=
X-Received: by 2002:a2e:7c0f:: with SMTP id x15mr2131261ljc.401.1604116915849;
 Fri, 30 Oct 2020 21:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201030223853.554597-1-dlatypov@google.com>
In-Reply-To: <20201030223853.554597-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 31 Oct 2020 12:01:44 +0800
Message-ID: <CABVgOSkTnBpvUGYFUmdrW=ouMsrG__BeU36YAo8D6Kco4NGMFA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix extra trailing \n in raw + parsed test output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 31, 2020 at 6:39 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> For simplcity, strip all trailing whitespace from parsed output.
> I imagine no one is printing out meaningful trailing whitespace via
> KUNIT_FAIL() or similar, and that if they are, they really shouldn't.
>
> `isolate_kunit_output()` yielded liens with trailing \n, which results
> in artifacty output like this:
>
> $ ./tools/testing/kunit/kunit.py run
> [16:16:46] [FAILED] example_simple_test
> [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
>
> [16:16:46]     Expected 1 + 1 == 3, but
>
> [16:16:46]         1 + 1 == 2
>
> [16:16:46]         3 == 3
>
> [16:16:46]     not ok 1 - example_simple_test
>
> [16:16:46]
>
> After this change:
> [16:16:46]     # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> [16:16:46]     Expected 1 + 1 == 3, but
> [16:16:46]         1 + 1 == 2
> [16:16:46]         3 == 3
> [16:16:46]     not ok 1 - example_simple_test
> [16:16:46]
>
> We should *not* be expecting lines to end with \n in kunit_tool_test.py
> for this reason.
>
> Do the same for `raw_output()` as well which suffers from the same
> issue.
>
> This is a followup to [1], but rebased onto kunit-fixes to pick up the
> other raw_output() fix and fixes for kunit_tool_test.py.
>
> [1] https://lore.kernel.org/linux-kselftest/20201020233219.4146059-1-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks!

I tried this out against everything I could (including the nastier
--alltests option), and didn't hit any problems, so it looks good to
go to me!

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
