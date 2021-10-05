Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89A4232C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJEVVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhJEVVc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 17:21:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5459C061749
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 14:19:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so659615pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqCgn0aR6MOwk9tPJfJQ1joytFSNdU+PPgwwrO6xJlI=;
        b=PeELKdrd2cYGP2YhLx/BUG9C0M7dCY7GpMFStukaQTqPiIBnJQpAbJ6eKYF/wAzQXB
         uCe4bOILYDhJzRJaw8b1uzoSdc9troRrH51TOnnZbbyJdwDtEYp0nG7+ys2c3L8romn5
         wH3HiI6x5+mqBt4Ne5NnRWgkD6piQAy/thWmMtbqcJrfTkIRbWm1wFYNGJNdhD8ps6aE
         mewTlq/1HvZlkjlL8qDskzOsTsKFUOvILu84oKE7N01jzAj4xmeAB0Pzg8WLT5zH7sKJ
         rerV59ccdBd79b0gl83XhMbzq/jbWKeLcCEEWr74fsl24W8bfFgtzu28cBS2lB8fad9/
         OCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqCgn0aR6MOwk9tPJfJQ1joytFSNdU+PPgwwrO6xJlI=;
        b=tU5Qyg6Dk8GpOww2NNxsKWzKHUXfEXF6m3vmp1ydejMI632Ql0DYf8WTOH6cQkEoS0
         oEDaINp8eIvYO445B8T+KZw6dvmU+HemPT8gblYDfRQ7swRq2ija7LSnBL9PwUn4QYCK
         ODqy2lh0V1wRgsaJzxJ7N/hORDIReA7UpwWsAqhqobP1LjpmICuz1ctKjv1j162giT3e
         Aregzl6CCJePNFjFMvEmPHDS5Rowxldq2tG7CO6ZnCNEWHvhAtTnMhfHa/8v2JGdFez4
         brTLZtZg6ZpBTBvcHSxlGjoUHDGh/fTflIgUTbpB6F8CpdRE0DhGS6u6qovA208QvcdF
         7hXQ==
X-Gm-Message-State: AOAM532OfHHoZqLzGQ4oSeLNGeOBPtrpj5y0GVwSxEoPk8ccu65IwuCG
        yeDB3KkMq2lR8qi7mnWveKlrlSjRpwFMzJhBD7Zlxs9Sujc=
X-Google-Smtp-Source: ABdhPJwIYwD2mwMY7UV/wgmEJL38fXuPQlhIzuHh00eQwOuBfhYyHK1J09g7y4Jz42UNP5guuQY20p7Iu0TGJ8XmSHQ=
X-Received: by 2002:a17:903:208b:b0:13e:d2b9:f2e8 with SMTP id
 d11-20020a170903208b00b0013ed2b9f2e8mr7288540plc.66.1633468781010; Tue, 05
 Oct 2021 14:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br> <CABVgOSkG=J7TpuzZMW_RbGA9f4NRZxGXRS8wd-cBmrWHD97pRQ@mail.gmail.com>
In-Reply-To: <CABVgOSkG=J7TpuzZMW_RbGA9f4NRZxGXRS8wd-cBmrWHD97pRQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Oct 2021 14:19:30 -0700
Message-ID: <CAFd5g47ECaw3CRH4MKzVPYmYhsiXR5hvha0ciadAFtEuUz6Xdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] test_hash.c: refactor into KUnit
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Isabella Basso <isabellabdoamaral@usp.br>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Shuah Khan

On Sat, Oct 2, 2021 at 12:30 AM David Gow <davidgow@google.com> wrote:
>
> On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
> >
> > We refactored the lib/test_hash.c file into KUnit as part of the student
> > group LKCAMP [1] introductory hackathon for kernel development.
> >
> > This test was pointed to our group by Daniel Latypov [2], so its full
> > conversion into a pure KUnit test was our goal in this patch series, but
> > we ran into many problems relating to it not being split as unit tests,
> > which complicated matters a bit, as the reasoning behind the original
> > tests is quite cryptic for those unfamiliar with hash implementations.
> >
> > Some interesting developments we'd like to highlight are:
> >
> > - In patch 1/5 we noticed that there was an unused define directive that
> >   could be removed.
> > - In patch 4/5 we noticed how stringhash and hash tests are all under
> >   the lib/test_hash.c file, which might cause some confusion, and we
> >   also broke those kernel config entries up.
> >
> > Overall KUnit developments have been made in the other patches in this
> > series:
> >
> > In patches 2/5, 3/5 and 5/5 we refactored the lib/test_hash.c
> > file so as to make it more compatible with the KUnit style, whilst
> > preserving the original idea of the maintainer who designed it (i.e.
> > George Spelvin), which might be undesirable for unit tests, but we
> > assume it is enough for a first patch.
> >
> > This is our first patch series so we hope our contributions are
> > interesting and also hope to get some useful criticism from the
> > community. :)
> >
> > Changes since V1:
> > - Fixed compilation on parisc and m68k.
> > - Fixed whitespace mistakes.
> > - Renamed a few functions.
> > - Refactored globals into struct for test function params, thus removing
> >   a patch.
> > - Reworded some commit messages.
> >
> > [1] - https://lkcamp.dev/
> > [2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/
> >
>
> Thanks: I've gone through this new revision, and it still works fine,
> and my prior comments have been addressed. The commit messages in
> particular are much clearer, thank you! I've reviewed the various
> patches and left a few comments here and there, but there's nothing
> too drastic.
>
> I'm pretty happy with this from the KUnit side, but it would be ideal
> if someone with more knowledge of the hash functions looked over it.
> Unfortunately, George's email is bouncing, and no-one else has made
> any particularly major changes to this.
>
> My only remaining comment on the tests themselves is that it'd be nice
> to have them split up further into more, smaller tests. Given that
> it's a port of an existing test, though, I understand the desire not
> to change things too drastically.
>
> We also need to work out how this is going to go upstream: does it go
> through the kunit branch (via Shuah's kselftest repo), or directly to
> Linus (who's handled most of the other recent-ish changes here.
> Brendan, any thoughts?

I think Shuah should take them in 5.16.

Shuah, let me know if you are OK taking these in 5.16 and I will
update the patch tracker.

> Cheers,
> -- David
>
>
>
> > Isabella Basso (5):
> >   hash.h: remove unused define directive
> >   test_hash.c: split test_int_hash into arch-specific functions
> >   test_hash.c: split test_hash_init
> >   lib/Kconfig.debug: properly split hash test kernel entries
> >   test_hash.c: refactor into kunit
> >
> >  include/linux/hash.h       |   5 +-
> >  lib/Kconfig.debug          |  28 ++++-
> >  lib/Makefile               |   3 +-
> >  lib/test_hash.c            | 247 +++++++++++++++++--------------------
> >  tools/include/linux/hash.h |   5 +-
> >  5 files changed, 139 insertions(+), 149 deletions(-)
> >
> > --
> > 2.33.0
> >
