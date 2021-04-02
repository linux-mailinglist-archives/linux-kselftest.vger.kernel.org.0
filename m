Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D035279E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhDBIza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhDBIza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 04:55:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9AC0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 01:55:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso4329510pji.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVi33W6kFMo5p4VQs7HO2/NAwfVOX/Oq4ggQUR4cf5s=;
        b=FQHNta89onUKom3TbcnPmiHImDN7n8SYW6GvDBG+34z4M01pFAQ/m6KMPd0BcaYH3D
         auDS3XSHvSPopN/JJpse9aSjH78pCqGMHS6pprDERI1WCJdekFgRNaOZMj8jOpkuj38e
         j0iJiOtWwymHGpQ2OQQsh0JUEAPlscQ/jIqZvWevp4ug0Uu8Rxw2H19a7Mh0cLpg6MFy
         UVuNQv2lzYBsTJ2D2XCLreyvSZ9xFZJT7zSqsxdDa6o4gIMQoX9v59+pCvs6vNRljeg/
         fv0rpSFSRZHjnHuKg5AA+vdyYkuwGeR06RSNIbLNYBpmDCZc/IAapy5ta+tQKcr5OKZk
         SwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVi33W6kFMo5p4VQs7HO2/NAwfVOX/Oq4ggQUR4cf5s=;
        b=flZorgHzMcoiHceOU14ytrnwkTA8UZLUDAkBT6z/wljstkNeHdg1CFNBghGWrMvKnP
         a2IBIhcjnq0y7Wx/qUQ1yLsd0r+6Ct4sZHbmABc2Ttn5HhyISNG4G854ah3LzcW/R+Cb
         HFzVlqGU/Xkyp+z/7Ggi6D+EvDfAAAYKCM4Hy2FgLu+IUci4n0LlJJtrwA6vIA7cZhaS
         kl5xtiZbNw5VXwL0GAEY2446CQ916x7baNEbdP14PaG1QeIn4M/1jb8D3gMibZ94/QC2
         GfcpQZ1M/Jg5rXgaf9gj/lsyJoAlBLsMZzj5OFWoRapoih5CTtNYNjnLfFy4cT5THewA
         bGmA==
X-Gm-Message-State: AOAM532p316/EvC6GdjET6r4H/rE1zbyLMwjSbhzdBecV5YsM9+aJtS0
        w55IFaJGL/mUYjdM7QIbkNacioXKY1oDgs/xNFYZAg==
X-Google-Smtp-Source: ABdhPJymf4782vco0OM/BGsM0691U+Z23gZWGigWivFhx70aZZRQDgRXoyGexs9btn9Wb7taONcvEv2MMRFHAogHThw=
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr12598214pjb.80.1617353729010;
 Fri, 02 Apr 2021 01:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com> <20210311152314.3814916-2-dlatypov@google.com>
In-Reply-To: <20210311152314.3814916-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 2 Apr 2021 01:55:17 -0700
Message-ID: <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> From: Uriel Guajardo <urielguajardo@google.com>
>
> Add a kunit_fail_current_test() function to fail the currently running
> test, if any, with an error message.
>
> This is largely intended for dynamic analysis tools like UBSAN and for
> fakes.
> E.g. say I had a fake ops struct for testing and I wanted my `free`
> function to complain if it was called with an invalid argument, or
> caught a double-free. Most return void and have no normal means of
> signalling failure (e.g. super_operations, iommu_ops, etc.).
>
> Key points:
> * Always update current->kunit_test so anyone can use it.
>   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>   CONFIG_KASAN=y
>
> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>
> * Forward the file and line number to make it easier to track down
> failures
>
> * Declare the helper function for nice __printf() warnings about mismatched
> format strings even when KUnit is not enabled.
>
> Example output from kunit_fail_current_test("message"):
> [15:19:34] [FAILED] example_simple_test
> [15:19:34]     # example_simple_test: initializing
> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> [15:19:34]     not ok 1 - example_simple_test
>
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
