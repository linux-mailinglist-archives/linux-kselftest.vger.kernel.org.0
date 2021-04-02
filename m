Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C105A3530BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhDBVZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhDBVZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:25:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B6C061788
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:25:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w2so2676309ilj.12
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9rvBUxt0gD7J/4lPVmkW5NC9txJcpKPfeTcuPwhZrE=;
        b=IAS9s+W/KelcH9FuBLGV79jg3RBD5yGvJgOPiLqa5H2ENC9WE56t7KHhTKARkdCq4s
         nrUjlGcDeknGHHiHSXf31RMlCUm7UYHs/BnjnMhy0EWgeH9KpnnNSLlOJE5Q4Qr8OLwN
         8NLNIn+7V5ZYtslSy5abpNiUJ+jHt2RaTgDWr0j3NWTqk89KKA+I7zJjHWbJIxUnZxUL
         TUcf8qxem91c49uxqRDrN2jLEZq7Gd6npHKc8tCgVxO6MVcGI8rMvoaICojGuDpUyTiS
         x6UcGDiqXdRp2yr2aMuyJ6woPc6faJgR16MTSiGLnjinGjZrfTvC0BsxZ5s98nHH4ydL
         yluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9rvBUxt0gD7J/4lPVmkW5NC9txJcpKPfeTcuPwhZrE=;
        b=KZ8byCUp+yEbU94qXvCfMGyRL2PJtP5Xco/PEnPEVoqFZHl+PE+OTyW4JHuZ8Bg7jo
         kZu6HknQ5an9PIb6CGdTM4d7fd0A/9QlSupVKXuE0HCOKABU6NpVbHaYSPm4dnqq8vjd
         6ZS3aT5aEM+rDx9plLh3UHtAaP9CazXq8ZTew7UDSzj/k5KfEVyOyjOaY1PSSsebnIhj
         65Xdj4CSFazklozQM8CzshapSOtsET2S7zyP7k585pKBZeJgH6hEQAU3opx5PrevmxT9
         KWyGQ6zzDsUoCSgvTC8IeQU24JKtxJrvlQnMdE3are9rjQNMlWZLoLxmWGHvFGzS/CIf
         6wcQ==
X-Gm-Message-State: AOAM5338BSKEUWIiC5pyaYnRV4t8lTi5LeklDxMslsdzo+QiXackRiKh
        9B9xhXzOv6NkXVPFvC3AJGqaB1NUVpfdNHeZyfsXTA==
X-Google-Smtp-Source: ABdhPJwCDq6Ept4G8BvWEHVX+L6RWxh/oywAHSZGHMZbbuglhagFIk94ClfIQQ2KRrf/TwAi8ObwNkWq6gHyXtPcPvQ=
X-Received: by 2002:a92:c24c:: with SMTP id k12mr11813867ilo.75.1617398711588;
 Fri, 02 Apr 2021 14:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com> <20210311152314.3814916-2-dlatypov@google.com>
 <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com> <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
In-Reply-To: <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 2 Apr 2021 14:25:00 -0700
Message-ID: <CAGS_qxozjVfeOa42Y+v7dB0s6Ucvf8yHhRxDpficEJ9MGE-orw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 2, 2021 at 10:53 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/2/21 2:55 AM, Brendan Higgins wrote:
> > On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
> >>
> >> From: Uriel Guajardo <urielguajardo@google.com>
> >>
> >> Add a kunit_fail_current_test() function to fail the currently running
> >> test, if any, with an error message.
> >>
> >> This is largely intended for dynamic analysis tools like UBSAN and for
> >> fakes.
> >> E.g. say I had a fake ops struct for testing and I wanted my `free`
> >> function to complain if it was called with an invalid argument, or
> >> caught a double-free. Most return void and have no normal means of
> >> signalling failure (e.g. super_operations, iommu_ops, etc.).
> >>
> >> Key points:
> >> * Always update current->kunit_test so anyone can use it.
> >>    * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> >>    CONFIG_KASAN=y
> >>
> >> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> >> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> >>
> >> * Forward the file and line number to make it easier to track down
> >> failures
> >>
> >> * Declare the helper function for nice __printf() warnings about mismatched
> >> format strings even when KUnit is not enabled.
> >>
> >> Example output from kunit_fail_current_test("message"):
> >> [15:19:34] [FAILED] example_simple_test
> >> [15:19:34]     # example_simple_test: initializing
> >> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> >> [15:19:34]     not ok 1 - example_simple_test
> >>
> >> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> >> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> >> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
>
> Please run checkpatch on your patches in the future. I am seeing
> a few checkpatch readability type improvements that can be made.
>
> Please make changes and send v2 with Brendan's Reviewed-by.

Thanks for the catch.
checkpatch.pl --strict should now be happy (aside from complaining
about line wrapping)

v5 here: https://lore.kernel.org/linux-kselftest/20210402212131.835276-1-dlatypov@google.com

Note: Brendan didn't give an explicit Reviewed-by on the second patch,
not sure if that was intentional.

>
> thanks,
> -- Shuah
