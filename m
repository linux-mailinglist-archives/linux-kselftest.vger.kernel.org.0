Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09624A84C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHSVOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHSVOy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:14:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500FFC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:14:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v16so21696plo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+umGhDcbGIZE1xFjxqU0bxabGlCttQLBQ+Y53ytOqC0=;
        b=KJecqVZ9hLXEAzJJNx3+s6VztJjf7IdAGVe1xvxkaR3MIOOrRYV+x5q4PkAmG97E47
         c9AfgbCo5kEgRCZ8hdbUxNjLSW4rUHKYJHgBYeI3No9tx1HVqRlWqvIUn26TUA+AX14V
         oI6hp4R03d/+IOM+djlJ6fbgWl+wRl5B/Ynr1CRdTtUZSJ7mP1IA3WAWXKZbcoVTHxky
         HJaON41XS9BzhwFiIwRDESb3MP5Zr4dLmn8S7gctlrq5qeF7GH/LTAl44vjXwKCSwhDZ
         tdBh+2voGT5VV/9cixVn2JjqYAj65P2LXuMvq6ETnzRPAreAd+K1RuNRDQZm6Ax6r9/r
         2LUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+umGhDcbGIZE1xFjxqU0bxabGlCttQLBQ+Y53ytOqC0=;
        b=T5L9YC2Mn9t1ZaWecztdw0fV2IViRR8PMEaG55wvSBC/G/BnyYZn9TZIHOKdD8PIMY
         n3sd9hnvnEbbUDc/Ha3VAWLxNCYc/2UJN5H2OBQL51pukOxj8ThzcbodiwbJmTBqJeD2
         AqmtM32jd3WYROpo6+5IxPbo8PYDEcQ8ojFwNvnSsYuk7JPsAA1mARqzN1s8Af7rfKgz
         nQSQx7ZauI00r0+zDW8DMYQUL3wnrBoEofa6D8LJ201dBfJB9jTkWYvi7MBvj8m6fyzW
         E6bgcnQjbzwHuKXeTS94qz4C22W4ISA7/OtCu1shNqZzZrxKuzF9nM+IU/jO+1H2cYPB
         AUew==
X-Gm-Message-State: AOAM533CDQLTOZjlyBvqVRTgK2pCYyntWiI/x6FT40amqUpjv42nlcNt
        DFBGGNxh5XRv73HzMA00ZlJHCt2lnhOCCbY1aOoLQQ==
X-Google-Smtp-Source: ABdhPJxD98fjtFT8GxHwT05Ahp/1ulXZG6efUm0uXvNqB6cqEVXrUsqo9M64hDCvdg13zcl6KOod3fU3jP+YqsQ4JBs=
X-Received: by 2002:a17:90a:4603:: with SMTP id w3mr1306384pjg.20.1597871693322;
 Wed, 19 Aug 2020 14:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729192357.477350-1-vitor@massaru.org>
In-Reply-To: <20200729192357.477350-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:14:42 -0700
Message-ID: <CAFd5g45rRMDD8=wQOzh+cGHEM4WJ=4vSu44W+4yPCFNFM2SB9A@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add list_sort test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, elfring@users.sourceforge.net,
        mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 12:24 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_list_sort,
> from `lib/test_list_sort.c` to KUnit tests.
>
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Code Style Documentation: [0]
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

It would still be good to get some of the original authors/reviewers
to review this.
