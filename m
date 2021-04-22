Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752613687AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Apr 2021 22:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhDVUGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Apr 2021 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhDVUGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Apr 2021 16:06:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F065C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 13:06:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11so18251370pjr.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/wwW78VpebQLZFuGwc6FJXnLCeLVtTQN01haPD78WA=;
        b=AT041JTA4EKF/eOPh/bYSQmEq1e8ixvzp5E+CaUpUwWwSuzv7kO7YkV0sGWze83npE
         HYgDgDQprhfVO+BPYkbpw2BTMloZerEiWcTgHwg3vYSLYUECDYqwaAkbnkAKgzJwvOhF
         xXHv4A4tZQoVx00IsIJCj3DEZQjBgOiOq1ldbL9ZV7xy64A0nMKJ+WY4Q0jfzEhn82Z7
         dHBgh7UMplxXYHdeB++4XfYJdgjxoblqHQ/39JZnV1VaMdt1g+IHwlUN78VKC405w334
         hKk8ICKyDAGh8wzM4sWFbEcyqv1wOgmFFKPbj76Kxi99aRUdLBCnUe+MQbV/yUdt+n6i
         Ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/wwW78VpebQLZFuGwc6FJXnLCeLVtTQN01haPD78WA=;
        b=cK86gMkrR6zjhWgz4GTKHEbG7or3pxQ3Tv+81IsfAQLZF5tsDsX01U+2FJcPpT7Rt/
         aZ7SGqQuNaBzdHCpfgsKTGoHSwjVlP0QFUxzQPzMu96PXMfO3Jc/rK9g/tM2/OM26fnV
         Fv7GzqsvNMs5ea3t2NJWTpOT9/H/cLAWqDdCkATNS3DBpHN3So93QT2U7QwItETSKo98
         jg5P5q3kfLOkWPxNhnrUh8zlkMhhapgbaX4EH47PPEpxKKxntHfVr59FjpHXhcySECHl
         ErqvqKvJjHuPRNMv+rkWrTOYSayxFB3GjYQVvuQO7RQ9UvUzPNvnpWsL3S2JOxL3Qwk0
         uLmQ==
X-Gm-Message-State: AOAM532V9wyHOqJzObQPjNr4GU8mtgPViiji/DkH/qCJXF+kXu7kEKbl
        oNZFWjFUhX+pWZsPP/YiC1j/CRw94eM+mDTpniXUMA==
X-Google-Smtp-Source: ABdhPJxJpEXfoFweuKypCLsg/2sIhYtqWnkmp09HbBahY/Y1a2LjMDjNxvniKWyvhFFnfN/N9TMrgljGpOFm4/NcuMU=
X-Received: by 2002:a17:902:7892:b029:ea:b8a9:6190 with SMTP id
 q18-20020a1709027892b02900eab8a96190mr219313pll.80.1619121969851; Thu, 22 Apr
 2021 13:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210421183222.2557747-1-dlatypov@google.com>
In-Reply-To: <20210421183222.2557747-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 22 Apr 2021 13:05:58 -0700
Message-ID: <CAFd5g44MTJU8z6nk-=wa-2jyQrDmpgDTj0_EZV-zFXhLxsXA_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 21, 2021 at 11:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Functionally, this just means that the test output will be slightly
> changed and it'll now depend on CONFIG_KUNIT=y/m.
>
> It'll still run at boot time and can still be built as a loadable
> module.
>
> There was a pre-existing patch to convert this test that I found later,
> here [1]. Compared to [1], this patch doesn't rename files and uses
> KUnit features more heavily (i.e. does more than converting pr_err()
> calls to KUNIT_FAIL()).
>
> What this conversion gives us:
> * a shorter test thanks to KUnit's macros
> * a way to run this a bit more easily via kunit.py (and
> CONFIG_KUNIT_ALL_TESTS=y) [2]
> * a structured way of reporting pass/fail
> * uses kunit-managed allocations to avoid the risk of memory leaks
> * more descriptive error messages:
>   * i.e. it prints out which fields are invalid, what the expected
>   values are, etc.
>
> What this conversion does not do:
> * change the name of the file (and thus the name of the module)
> * change the name of the config option
>
> Leaving these as-is for now to minimize the impact to people wanting to
> run this test. IMO, that concern trumps following KUnit's style guide
> for both names, at least for now.
>
> [1] https://lore.kernel.org/linux-kselftest/20201015014616.309000-1-vitor@massaru.org/
> [2] Can be run via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_TEST_LIST_SORT=y
> EOF
>
> [16:55:56] Configuring KUnit Kernel ...
> [16:55:56] Building KUnit Kernel ...
> [16:56:29] Starting KUnit Kernel ...
> [16:56:32] ============================================================
> [16:56:32] ======== [PASSED] list_sort ========
> [16:56:32] [PASSED] list_sort_test
> [16:56:32] ============================================================
> [16:56:32] Testing complete. 1 tests run. 0 failed. 0 crashed.
> [16:56:32] Elapsed time: 35.668s total, 0.001s configuring, 32.725s building, 0.000s running
>
> Note: the build time is as after a `make mrproper`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
