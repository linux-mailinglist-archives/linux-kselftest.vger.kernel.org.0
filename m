Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE93F7FFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhHZBhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhHZBhX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:37:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3525C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:36:36 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q3so1673634iot.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bN4zsDLKjtt39ALjBnlM/U1e98GFstFGSAjcJ+DqyDw=;
        b=jHGlMt2EU21XsDt8PXNtXXjDxr+y+uRiVBmep5USzEgnidbtBhGBtCCoHQ2Dp/4GMC
         rxpn8+Rb6shA1JFazRqV5kDLNQumDQLtJQa7mseQxwbgDRdtI6USuWvqM+c5R6pRaJHm
         ob+K/oJlDz+A8nfYT/8X2IfbO625U+waXKC/8jWigvl2r5BHlHz1oBw+CI8kS6lKEiEI
         wzLbq1n40fjbu+m9V7Wm1U/V158Bi6WKwvelY6SXuB9r7AKFnc1IfDxsEvF4I6Qu0trc
         c+IM4fGCkZzNH9Bcy5iXe27YgJCtna0wFHXhnKzKcHoDqyFxkA56WH875Y1aqSyo4TBp
         r1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN4zsDLKjtt39ALjBnlM/U1e98GFstFGSAjcJ+DqyDw=;
        b=t4fPGhGkiQSZUcfVXjUyDTvS6rnPoSZ+S5OqO966lA74aXdbVut/rOLtx+4xzPxC8+
         ZlegJCE2oidU51CPZa0/A+SXr3mAYv4Tr911gH5LJfGy9ixHWS0EwygsUXx9ZNtueKiM
         hB9PDabagPsctpLHo9nCmp3eowz1irH2RnYNLmcYDgxQxuzt6maxoSyJwllaPkfIp1ki
         jFZLALknpenXsQVul+VuUSmaEcMlkYa1cNuNnOPBLguZtzHuva65Q96UsiWgOsn8a+ty
         f+kmgYriFokOFT1uWPOMVsCk9TvzeZKG5n6a45b5pnWiPf4juoYxvmLVfNCQJ+PuDor7
         yM8Q==
X-Gm-Message-State: AOAM531ypelf/yHnF+Y+m8yus46xNP9bb9dh28poYSg5S1ikNicbtD68
        dYypGveJskwRg5tMLbTm+dIl8I2LnZyfnIpTRx4bWA==
X-Google-Smtp-Source: ABdhPJwYi9XsM0xb81tdbgKWfXpRxk1BO+Q9BaoJARp+y8loxJcmGF5nA8e8UActTFD60kaCalkfPZ/1u4qtvRXDK4A=
X-Received: by 2002:a5d:8484:: with SMTP id t4mr1032429iom.126.1629941796235;
 Wed, 25 Aug 2021 18:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 25 Aug 2021 18:36:24 -0700
Message-ID: <CAGS_qxqQWVmmgou9rg-KdfuN9aj+mcjFUh5y8AEyvunUcn9hOQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] test_hash.c: refactor into KUnit
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     linux@sciencehorizons.net, geert@linux-m68k.org,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, davidgow@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 25, 2021 at 6:26 PM Isabella Basso <isabellabdoamaral@usp.br> wrote:
>
> We refactored the lib/test_hash.c file into KUnit as part of the student
> group LKCAMP [1] introductory hackathon for kernel development.
>
> This test was pointed to our group by Daniel Latypov [2], so its full

Oh, I hope I didn't lead you down a rabbit hole.

I just looked and saw that it used pr_info()'s to show that it was
skipping some stuff.
And I thought the new SKIP test support in 5.14 was something y'all
might not have been aware of, so I pointed to it as a motivating
example to rebase to get the latest KUnit patches.

I didn't do my homework and look into the test to see how suitable or
not it was for KUnit.
But I'll try and find some time soon to go over and review at the
KUnit parts of this patch series.

> conversion into a pure KUnit test was our goal in this patch series, but
> we ran into many problems relating to it not being split as unit tests,
> which complicated matters a bit, as the reasoning behind the original
> tests is quite cryptic for those unfamiliar with hash implementations.
>
> Some interesting developments we'd like to highlight are:
>
> - In patch 1/6 we noticed that there was an unused define directive that
>   could be removed.
> - In patch 5/6 we noticed how stringhash and hash tests are all under
>   the lib/test_hash.c file, which might cause some confusion, and we
>   also broke those kernel config entries up.
>
> Overall KUnit developments have been made in the other patches in this
> series:
>
> In patches 2/6 through 4/6 and 6/6 we refactored the lib/test_hash.c
> file so as to make it more compatible with the KUnit style, whilst
> preserving the original idea of the maintainer who designed it (i.e.
> George Spelvin), which might be undesirable for unit tests, but we
> assume it is enough for a first patch.
>
> This is our first patch series so we hope our contributions are
> interesting and also hope to get some useful criticism from the
> community :)
>
> [1] - https://lkcamp.dev/
> [2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/
>
> Isabella Basso (6):
>   hash.h: remove unused define directive
>   test_hash.c: move common definitions to top of file
>   test_hash.c: split test_int_hash into arch-specific functions
>   test_hash.c: split test_hash_init
>   lib/Kconfig.debug: properly split hash test kernel entries
>   test_hash.c: refactor into kunit
>
>  include/linux/hash.h       |   5 +-
>  lib/Kconfig.debug          |  28 ++++-
>  lib/Makefile               |   3 +-
>  lib/test_hash.c            | 249 ++++++++++++++++---------------------
>  tools/include/linux/hash.h |   5 +-
>  5 files changed, 136 insertions(+), 154 deletions(-)
>
> --
> 2.33.0
>
