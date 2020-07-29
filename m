Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5223260F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2URN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2URN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 16:17:13 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D0C061794
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 13:17:13 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 133so13216385ybu.7
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsAi/yM0dYoTsEAduerPAEeoeBRABFVM36ZfoeomatY=;
        b=Sdzx2SqpXH3YztrrLNOADE5QjX5DPMw9qzcr7aHGCh/zp+I48O4kqqRZpqulQK7b2A
         C0RuSwWADNheZUXSP4rEN1wGIvAHpzoqMuGaY9bfPEyvF7S943eq2s4cUgghOcvSf/gF
         pgSXR0NUIxtUVLHek5C2iWFuwwFK1cYRX3ViHbez65SiI4fPMcJckFrPEMykGyiQCS78
         qAbpP8IMzkK2emxhZ0eXkv50SN/md9uBSLITI1PlvPb8m7/drlC3Ebg9l9hlt1cSmd1U
         zk+/6KjyjmyFpbWHSa1K7nCrIHFc4aSgPROhI0PTheyPL6km/Re6ghueTxNzyrTKrFW1
         WtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsAi/yM0dYoTsEAduerPAEeoeBRABFVM36ZfoeomatY=;
        b=riUOyvLKgAYqBY5x+jYueoj7AliymdCi+xsaLH62ghnJxB+RTdoR+SzUV7Ks+I+Ykp
         mYrFYREu7qHW5GpYeUroWijdeCA7SZwpXGgXgfEMFux6OS3T8DzLMzg0ek6FkDVRpkW8
         Ay846y2AdleAYXFOGOBu8X2DXrMXkTTn0bkDOobVwuVDTytdj2w5twfL01q2inKQr2zB
         9waUzmF0wc0fkRyd4JDn4MIyI4XiXfUxjT9t0RAeSqJWyIqXw8yJr1Szh7DqqZN9tV2J
         TF3EMKkA1S7mNKA9qhpa8WGTPnRmMDatcXJw9J2bkbnP00whdq9CI6X8dC9B0goK6Sww
         7gkQ==
X-Gm-Message-State: AOAM530sWoZ0PQ2a4fsDDv6H/bXrw7B4RrOlXHMnptCRaStPF8yjFNVB
        oP+1aadZBKDvpa6htCb8ENF3tk2ZaBmBRXmhmLLLRA==
X-Google-Smtp-Source: ABdhPJyPk3kjiGNYFFk4yzHPEbfFcoZIfz0gAfhNJ3Fsk1YWxiMbGPNT80Yqs2GsCLymQyrnK2dqTUc8spmJdwVOFPE=
X-Received: by 2002:a25:bb0d:: with SMTP id z13mr229226ybg.488.1596053832271;
 Wed, 29 Jul 2020 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200729191151.476368-1-vitor@massaru.org> <20200729191948.GZ3703480@smile.fi.intel.com>
In-Reply-To: <20200729191948.GZ3703480@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 29 Jul 2020 17:16:29 -0300
Message-ID: <CADQ6JjU1wg_mrhuGkgiNWmJLCvNcOVwS0Hysda+OXuDcCj8y=Q@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, fkostenzer@live.at, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 4:19 PM Andy Shevchenko
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

Sure, thanks!

>
> >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
>
> Still opened question why kunit is a suffix? Can't we leave same name? Can't we
> do it rather prefix?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
