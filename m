Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E66362DA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Apr 2021 06:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhDQERS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Apr 2021 00:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDQERS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Apr 2021 00:17:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B885EC061756
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 21:16:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c1so24938808ljd.7
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGVMmGP8qLWqxfzlvKNYjiwykEo01hrsV+jCrcf2K9A=;
        b=fOsAgPf8o6Dbhq3uqWlVbEOlFNhmZSJvTgrDnSpAF/JcfY7XTI+pTsL+8B7RwdJajg
         8/ZW9B50SAuqcQ5ePSKTa2S+0n+SHk7n2QJV2Uk/G8cXqZx+0FBr8wnt8Gspz5Jn0nXR
         b/7TP3jV144sT4gCZhqxdl+VwK+wPQ9nlhMWwpSm3qMpueE19aYFrf08f8PgWnzI4eJ6
         q5cC/Xu+GFoPi+Zv89RV9aMKtC5uD6r07NMI70W8FCCzl2S6nc9/tTgct4LXethwme1I
         0wxdA/42h9lzA7ix5Q6r1YD55fqDQjNXo+9bW+bCK6LWmglgnOwjSLVfLFnQFZX0jYGN
         xlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGVMmGP8qLWqxfzlvKNYjiwykEo01hrsV+jCrcf2K9A=;
        b=otjq9aLXEAycz6mcRu9c0cgw2DfIbtjk0DDXa7lV7P6AY5Ijf0jthOd0kQ9uDo0RDK
         VeveIwYEothMwkv+UebIngF20sfkzl4h4b1yaMU03asmgvUQiZi9P/mQK8/AmZZtXBsH
         VvuTnXoMLuhXcn4IHkADPCR1fstlzn1ZEo16Ra7vDS6MAGh834xxXKgQs4PVSyhU3vy5
         wpQ3Bl2yhLW3UUSV+se9Ka+tMFmozf8X2Zc4KzzJo0IburoQOGcvudGGPubq0l2c5+EG
         qLFLQr5gDUowV8O7oO/Z2bvXJWPh1ivM+cCFfkOYfnswZ24zSeM3JnOasyeyrVSHtzx3
         8uuA==
X-Gm-Message-State: AOAM531S6QXS+Y+t30RBpqCniaWb8c0HRCHSwCvrxMSN6eQqrYFIOGg2
        owW6CVTk3JeCowway3ETKBbkfAm7kias+koOMt6t8Q==
X-Google-Smtp-Source: ABdhPJyB5dG7lvpLgm/JXqI0ZZJiAvl68+1WjW8NOUNoozxo70lJ+PFqZkzI7DVVieLWqqR8Cg4J0DDn0aW+uJj9ADM=
X-Received: by 2002:a2e:bb95:: with SMTP id y21mr1452149lje.510.1618633008874;
 Fri, 16 Apr 2021 21:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210416180427.1545645-1-dlatypov@google.com>
In-Reply-To: <20210416180427.1545645-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 17 Apr 2021 12:16:37 +0800
Message-ID: <CABVgOS=A2jBjyspJHLK7Pc3+2HzK6NWFKDtejCVO88UnLySRig@mail.gmail.com>
Subject: Re: [PATCH v6] lib: add basic KUnit test for lib/math
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 17, 2021 at 2:04 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Add basic test coverage for files that don't require any config options:
> * part of math.h (what seem to be the most commonly used macros)
> * gcd.c
> * lcm.c
> * int_sqrt.c
> * reciprocal_div.c
> (Ignored int_pow.c since it's a simple textbook algorithm.)
>
> These tests aren't particularly interesting, but they
> * provide short and simple examples of parameterized tests
> * provide a place to add tests for any new files in this dir
> * are written so adding new test cases to cover edge cases should be easy
>   * looking at code coverage, we hit all the branches in the .c files
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---

Thanks: I've tested this version, and am happy with it. A part of me
still kind-of would like there to be names for the parameters, but I
definitely understand that it doesn't really work well for the lcm and
gcd cases where we're doing both (a,b) and (b,a). So let's keep it
as-is.

Hopefully we can get these in for 5.13!

Cheers,
-- David
