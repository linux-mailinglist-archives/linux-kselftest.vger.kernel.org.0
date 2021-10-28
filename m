Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0943E696
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhJ1Quo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhJ1Quo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 12:50:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB76C061745
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 09:48:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j21so4488028edt.11
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8Jw/S2n3WB7bDRByTQGeQns0CvXOlde4kiN/IEV98o=;
        b=PR8boEcK6RSO8eaafJJSJzKy+NQsdbysFi/aCXaszc/wOVJoO+mM0BaQ6dPPy9xKKq
         XnNEfSSYf9NJ3digurFFHlOYis4fL1gGKHiQJHJIvXMQ4steyAzNeh+mP1AK2b9WWabC
         f7D+pHU75jrNCG78NwUNk2dljTXfS61O+bxbPg2vKADcyExEWkmhVq0718tTQhcinK9w
         TrDOa5w2oDLuEJVR/+IfpAsuAczb1VG+l8ewlLw6o7j3/dJvOJGZfmijAvwegEmqjENt
         EWGl12GBnC3849MIoXM3qGsBe5i48hPnBsQsfxDsBgeZTAowHUX3drMfakwzmRW+aHTa
         8HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8Jw/S2n3WB7bDRByTQGeQns0CvXOlde4kiN/IEV98o=;
        b=WlAgKUBFXm15KDazxl0V0ZzNb/NtotP20xDM7Qm6A0/661ti0ONr+2L7YB3+9HprVr
         nsXO/n+shBPyhG6zkQkqpSTI2cyLrj6d5Ec4yIV5npZzf9hjba7zaeOcY13R0lpjB0JQ
         oBXJOmsQAP92p5p34ka4RwdHHQIg7Wlxly/zlQsmCduc9dpWLa2LIhVtIsdhPQ9YR0s3
         rpz/YoL1/VG+OcVDMO48STD7GqPV8OLOGr0POlFB0wl+P9qe0Ijy6Km+uF16vT9eMGXy
         0RHzT7H786w4DuNu4VxSwL0gsTAd6RToLRvidE4mmn6lSuXKgj/jVVe3lztVeqz8nclt
         v/4A==
X-Gm-Message-State: AOAM531MVWm42Q3b5M/S6SoicWt4rm1aqgbdU//iw2HiHCxPGBtdZglC
        pPyITPYPhbvFvjKxQ8bMXFzkOSZoLOhGiMT4Xg4QLw==
X-Google-Smtp-Source: ABdhPJynXs15eI4J4h6dypN6+uIsPodjJBAXKeImKWkhEvpw9l+CnL5egYbTMYSOE5emSX15YsoKbBx+YIZPYkVvpPU=
X-Received: by 2002:a50:e686:: with SMTP id z6mr7820251edm.311.1635439694998;
 Thu, 28 Oct 2021 09:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
 <CABVgOSkG=J7TpuzZMW_RbGA9f4NRZxGXRS8wd-cBmrWHD97pRQ@mail.gmail.com> <CAFd5g47ECaw3CRH4MKzVPYmYhsiXR5hvha0ciadAFtEuUz6Xdw@mail.gmail.com>
In-Reply-To: <CAFd5g47ECaw3CRH4MKzVPYmYhsiXR5hvha0ciadAFtEuUz6Xdw@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Thu, 28 Oct 2021 13:48:03 -0300
Message-ID: <CAAniXFTdQN3_BnRZeZLu-UHJPwyMkFZvTw7J4Sm4W+fRsuEC3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] test_hash.c: refactor into KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

On Tue, Oct 5, 2021 at 6:19 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +Shuah Khan
>
> On Sat, Oct 2, 2021 at 12:30 AM David Gow <davidgow@google.com> wrote:
> >
> > On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
> > >
> > > We refactored the lib/test_hash.c file into KUnit as part of the student
> > > group LKCAMP [1] introductory hackathon for kernel development.
> > >
> > > This test was pointed to our group by Daniel Latypov [2], so its full
> > > conversion into a pure KUnit test was our goal in this patch series, but
> > > we ran into many problems relating to it not being split as unit tests,
> > > which complicated matters a bit, as the reasoning behind the original
> > > tests is quite cryptic for those unfamiliar with hash implementations.
> > >
> > > Some interesting developments we'd like to highlight are:
> > >
> > > - In patch 1/5 we noticed that there was an unused define directive that
> > >   could be removed.
> > > - In patch 4/5 we noticed how stringhash and hash tests are all under
> > >   the lib/test_hash.c file, which might cause some confusion, and we
> > >   also broke those kernel config entries up.
> > >
> > > Overall KUnit developments have been made in the other patches in this
> > > series:
> > >
> > > In patches 2/5, 3/5 and 5/5 we refactored the lib/test_hash.c
> > > file so as to make it more compatible with the KUnit style, whilst
> > > preserving the original idea of the maintainer who designed it (i.e.
> > > George Spelvin), which might be undesirable for unit tests, but we
> > > assume it is enough for a first patch.
> > >
> > > This is our first patch series so we hope our contributions are
> > > interesting and also hope to get some useful criticism from the
> > > community. :)
> > >
> > > Changes since V1:
> > > - Fixed compilation on parisc and m68k.
> > > - Fixed whitespace mistakes.
> > > - Renamed a few functions.
> > > - Refactored globals into struct for test function params, thus removing
> > >   a patch.
> > > - Reworded some commit messages.
> > >
> > > [1] - https://lkcamp.dev/
> > > [2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/
> > >
> >
> > Thanks: I've gone through this new revision, and it still works fine,
> > and my prior comments have been addressed. The commit messages in
> > particular are much clearer, thank you! I've reviewed the various
> > patches and left a few comments here and there, but there's nothing
> > too drastic.
> >
> > I'm pretty happy with this from the KUnit side, but it would be ideal
> > if someone with more knowledge of the hash functions looked over it.
> > Unfortunately, George's email is bouncing, and no-one else has made
> > any particularly major changes to this.

I'm glad to hear this :) I'd also like to point out that "George Spelvin" is a
rather unusual figure [3] so we shouldn't be expecting much back from
him, anyway. Maybe I should've looked that up before trying to tackle this
patch, as I've no idea who might be able to properly review the hash part of
it.

> >
> > My only remaining comment on the tests themselves is that it'd be nice
> > to have them split up further into more, smaller tests. Given that
> > it's a port of an existing test, though, I understand the desire not
> > to change things too drastically.

Thanks for your comprehension!

> >
> > We also need to work out how this is going to go upstream: does it go
> > through the kunit branch (via Shuah's kselftest repo), or directly to
> > Linus (who's handled most of the other recent-ish changes here.
> > Brendan, any thoughts?
>
> I think Shuah should take them in 5.16.
>
> Shuah, let me know if you are OK taking these in 5.16 and I will
> update the patch tracker.
>

Thanks a lot for your interest in this patch :)

We were a little worried about who might be able to get it upstream, so we
appreciate that you also thought of this!

> > Cheers,
> > -- David
> >
> >
> >
> > > Isabella Basso (5):
> > >   hash.h: remove unused define directive
> > >   test_hash.c: split test_int_hash into arch-specific functions
> > >   test_hash.c: split test_hash_init
> > >   lib/Kconfig.debug: properly split hash test kernel entries
> > >   test_hash.c: refactor into kunit
> > >
> > >  include/linux/hash.h       |   5 +-
> > >  lib/Kconfig.debug          |  28 ++++-
> > >  lib/Makefile               |   3 +-
> > >  lib/test_hash.c            | 247 +++++++++++++++++--------------------
> > >  tools/include/linux/hash.h |   5 +-
> > >  5 files changed, 139 insertions(+), 149 deletions(-)
> > >
> > > --
> > > 2.33.0
> > >

I'm sorry for the delay in my response, but I think I can send a V3 soon,
probably until next week.

[3] - https://lwn.net/Articles/688216/

Cheers,
--
Isabella Basso
