Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B3299823
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 21:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgJZUop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 16:44:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40414 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgJZUop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 16:44:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id x13so6729104pgp.7
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Oct 2020 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXoBtb7hZg65eUO5Skt0IZ7KKc+QKlYeerwa/eOfSGQ=;
        b=j3nVfTLfrQADpl0INIZy5QtGpAuuKuwsllTEBcNuaN7bttWfpOO1ARbJEZbEIoZLzu
         yqyL75Q9qQVSD2oG47onib/wJaJI5MYz/xuC3Mq3TEsNg8t9StZwThI1DwkOv1Dcl4Wy
         juxbKlVizYkYQaTYhEXGKk2KlIdfKWHxxfLvvwRKZ8VyTEHawpTX6Q/3u6nlQTH0QLus
         +dZULHFwZoXtc/R55kZgQudJZd+dWJLqyywDC4CuVknjfGcVR1plj639HZ7yuhdZsmvg
         ddUW+NNCStRG5onZJ+oN4H+7/3nMYsTlyWFeSOt0vt0YD9o6bM85UtS7f43cjIrGdWwQ
         KwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXoBtb7hZg65eUO5Skt0IZ7KKc+QKlYeerwa/eOfSGQ=;
        b=Uj2LBdgft04PZTTDYCAhJ5V1tfGVR07OcrOjYsv7XDifCSzWxcwv/HthgI6ko/I8Cr
         jtEopzC5G99d+1k3s5NicxLhqbyl7JcUy/Q4TcGkA8vFG3eMLpnZlZdjVLyo5iIO9U/G
         gBvwhhS2EWKinyJiwRaQeg+vR+zg48itjSmRW8scFe2d7Yfpau5VNaMI7+KDyQHSZ1i9
         EPoUS8Fa/i83AsdEe0Xfhsekd9cjY8y0Aje/Z9ay50ETey9v1h1VKkksXBHoOne4hCOY
         CqGf5bNe/l/1vHT4SiXWTVjU/QLs97KPSx5NCS1PrkgokAL2Mt2nM2TlkXfHikhlqpcZ
         30Mw==
X-Gm-Message-State: AOAM530LANzJeLhARKDlC3Pf5nxjzqET0rJPcwIeDXrFHhPNOodIzQkE
        R+iPCWH0ixbN/2wPhkcMRIUUgmcjJRse0KIZVZOkAA==
X-Google-Smtp-Source: ABdhPJzAJHZdaHLqZ+e5l/ypR2UFgs1n9sRrJr/lJKrbWsJNPX7rD/s7XOYH2ghPx1yqE+pDgbxxly1kBIL35ym68Y4=
X-Received: by 2002:a63:495d:: with SMTP id y29mr13514203pgk.384.1603745084311;
 Mon, 26 Oct 2020 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd5g44CxPuXbHund397PJSQPHGhWy1-7ij7JnJNzCO0NF6dCA@mail.gmail.com>
 <20201022063526.12554-1-sjpark@amazon.com> <20201025124459.GA1157488@surfacebook.localdomain>
In-Reply-To: <20201025124459.GA1157488@surfacebook.localdomain>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 26 Oct 2020 13:44:33 -0700
Message-ID: <CAFd5g45N_7HTTObU799_S-9QPFXhQkeQ=yqvH-J79ROvKSXs4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 25, 2020 at 5:45 AM <andy@surfacebook.localdomain> wrote:
>
> On Thu, Oct 22, 2020 at 08:35:26AM +0200, SeongJae Park wrote:
> > On Wed, 21 Oct 2020 14:32:52 -0700 Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> > > On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> > > > used UPPER_SNAKE_CASE naming convention that usually means it is
> > > > constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> > > > default config in '--build_dir'") made it modifiable to fix a use case
> > > > of the tool and thus the naming also changed to lower_snake_case.
> > > > However, this resulted in a confusion.  As a result, some successing
> > > > changes made the tool unittest fail, and a fix[1] of it again incurred
> > > > the '--build_dir' use case failure.
> > > >
> > > > As the previous commit fixed the '--build_dir' use case without
> > > > modifying the variable again, this commit marks the variable as constant
> > > > again with UPPER_SNAKE_CASE, to reduce future confusions.
> > > >
> > > > [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
> > > >
> > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > >
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Thanks :)
> >
> > >
> > > Thanks for this! This is something I meant to fix a while ago and forgot about.
> > >
> > > One minor issue, this patch does not apply on torvalds/master right
> > > now. Could you please rebase this?
> >
> > Surely of course, I will send next version soon.
>
> May I ask what happened to [1]?
> I mean it seems these two are goind to collide.
>
> Brendan?
>
> [1]: https://lore.kernel.org/linux-kselftest/20201015152348.65147-1-andriy.shevchenko@linux.intel.com/

Sorry for the confusion here. After an initial glance at your patches
(before I did the review end of last week) I thought only the first
patch from SeongJae would potentially conflict with yours (Andy's)
(hence why I hadn't reviewed it yet, I was waiting until after I
looked at yours).

I noticed on Friday that SeongJae's changes were actually fully
encompassed by Andy's, so I am taking Andy's not SongJae's. Sorry, I
was going to notify SongJae today, but you beat me to it.

Sorry everyone.
