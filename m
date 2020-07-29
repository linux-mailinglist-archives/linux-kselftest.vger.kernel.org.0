Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0822325B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2T7l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2T7k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 15:59:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4EC061794
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:59:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so13573864pfu.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXah3Xc+kLkZM/PLhPslS3L9/VAQlpaeM7DPNTz+mRo=;
        b=m0yOqGSSOobbbR1nXbyONcYMoY9QcZn/h7RfTI6uhYaO/tH+AqMNCgY4tLf21I8vXk
         Yh4Ks3FqHTvlZaNLAK1//sEF+F4zflndG/1gOtS0jQVceWjtcIlAGrVYWF18eEEftqub
         ChyKawfxRra4GHOAfLwuDeqdkMpSTXvbb5AjPF/Cr6ypx42CMLxmJa0i1AeERJm2jfhU
         UekCtB4i6g+uwk7Wnp1Ba+mt9c2OV22+9zXc2UAog6H1P87JdmRhoZPaSDwcTULzPjNh
         Bo5jaFASd2oYnfR3SQqwi4ctv3IU2uD24B7oxSMByDICnt6HRM6SfF2MXCNJ4WPzptly
         KFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXah3Xc+kLkZM/PLhPslS3L9/VAQlpaeM7DPNTz+mRo=;
        b=tAsB5Fuba+eGk+ZWvgMyH4+QQHv4FTv+jVTBj5obo4S+mw335VKNg+I5o0U0hrBV8j
         RS1NaQPnN9ABqNIbAYAZLAjKuFxWELgMW/slqLwYuWttGENa9kAA9OF7dw230IfSPBNk
         i3tJANL6FPynTuOImnxlKfXbGOTMrKD9Yr2hifIKz2vepzqc18TSEMIi0iPIKMM/htNF
         JGgJ0Sz/crd0EWbs2ND0+BTm43JJgHy3C0XOVbu8gCdqcEx/NizvHb++SP2Radtd9QeT
         s1fi3r52PBFZvgH5eQ5J0XemMBLwKNTzKjgqjGk/HfXj9ZyT8n7V9pwEM57RGY0d5dlD
         Ij9Q==
X-Gm-Message-State: AOAM533kV6kCd4uB7Lq8y7WEv7VlKhj6tsseaINHAcppGDbVVVrQd8S9
        A/urmxtwuivrLwMBh6gN6OJFAd5uvl6n+dfn1IFEfw==
X-Google-Smtp-Source: ABdhPJz4+pNEnpxR6psAD32318hc3ZwUR5qnxVTyp2ARSiG9KBGqwIhTNfVJC84ocOmqyUoFZ5D9UM2pjZdwWleigPM=
X-Received: by 2002:a63:d501:: with SMTP id c1mr30791224pgg.159.1596052779669;
 Wed, 29 Jul 2020 12:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200729191151.476368-1-vitor@massaru.org> <20200729191948.GZ3703480@smile.fi.intel.com>
In-Reply-To: <20200729191948.GZ3703480@smile.fi.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Jul 2020 12:59:28 -0700
Message-ID: <CAFd5g47MGZTo0k4s1ohRNT09D=NrsBQHOHQwLVq=uh8ezCuAQA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, fkostenzer@live.at,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 12:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 29, 2020 at 04:11:51PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the test_sort.c to KUnit test.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> Looks like you mixed up commit message and changelog / comments.
>
> > Code Style Documentation: [0]
> >
> > Fix these warnings Reported-by lkp@intel.com
> >
> > WARNING: modpost: vmlinux.o(.data+0x4fc70): Section mismatch in reference from the variable sort_test_cases to the variable .init.text:sort_test
> >    The variable sort_test_cases references
> >    the variable __init sort_test
> >    If the reference is valid then annotate the
> >    variable with or __refdata (see linux/init.h) or name the variable
> >
> > WARNING: modpost: lib/sort_kunit.o(.data+0x11c): Section mismatch in reference from the variable sort_test_cases to the function .init.text:sort_test()
> >    The variable sort_test_cases references
> >    the function __init sort_test()
>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
>
> This should be in different order: Link, Reported-by, SoB.
> Also [0] is unnecessary
>
> >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
>
> Still opened question why kunit is a suffix? Can't we leave same name? Can't we
> do it rather prefix?

Sorry to jump in now; I thought Vitor's reply with a link to the new
proposed documentation[1] addressed this. The naming convention issue
came up about a month ago[2]. The people in the discussion (including
myself) came to an agreement on _kunit.c. That being said, the
documentation hasn't been accepted yet, so if you really feel strongly
about it, now is the time to change it.

All that being said, I would rather not discuss that issue here for
the benefit of the participants in the preceding discussions.

I posted lore links for the relevant threads, which should be easy
enough to In-Reply-To your way into. Nevertheless, if it makes it
easier, let me know and I can CC you into the discussions.

[1] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
[2] https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u

Cheers
