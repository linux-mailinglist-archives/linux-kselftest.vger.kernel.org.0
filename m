Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9E4011F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhIEWct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Sep 2021 18:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhIEWcs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Sep 2021 18:32:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8CC061575
        for <linux-kselftest@vger.kernel.org>; Sun,  5 Sep 2021 15:31:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i21so9616004ejd.2
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Sep 2021 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQBzpOrkgt1sL5aFZ4ypTx/31uYXv7KGinPeuizSygY=;
        b=JxcOyyugTRMkxVBO9psg4Jzl3NliBERfPC1KPUtxtZkV9yMGsKON1zg7daaZKoSnlp
         3M+WO+08tTsi5kpjhAbjAVW+rQIr2QyP3BcLvrOYPR4HeJ02GIT9sZDY3oXYTqs1s6Y6
         98sT2r5k7pctQ9krCefkpm6VNMSLbyigftwjGs21SS/hsExc7VePwvSrdDDqa1A4zUaW
         N0sQwlXVB0LHsq6+JGPZuEgcZMR9VQDjtvAuq4DTUy6oV1iF+m/t+alXGyxRF489mFQh
         WjjUo1+tK5raRH4TUjCQZzw0SEfeCkSCjsDn8El2UAAwcjlVyPJrbo6nPEES2Y0a2uFz
         9Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQBzpOrkgt1sL5aFZ4ypTx/31uYXv7KGinPeuizSygY=;
        b=lLEtU1/5I8xfroQGQEdktdyAlry0gYpKb0QbZ5faJTKpR3+0iAIpsqfj/N5VD1raOK
         6ZlsNUgYhBBTyZs0h5gqlF3rK4DI0yFog5ehHivster08LGWNLvi8h90Udq2qYTHLXB4
         PLXcN2k4YueAoio4KDzBn7e05WfWWi1OFAr8pGr1abZowfEMo9xmSnPGXkSa6GBrrVBo
         75L5yI7acKHYF/74Ywcgd0PsU3K+wbN90+a206JhIT+M55wN+xYSsOEd62/i9Bry/Std
         d5q3q6XrjyppmdX5BC8plGleK33ZjS1sQ1EjA4v5wQqlp/1iWuOF8zPnEvsJrZ4zIvQW
         3+ZA==
X-Gm-Message-State: AOAM532kBO6k8qwnl2EMQQ+8CuhVoB8bRR5vLJ7kOqO32MHswS+tlFXn
        ij5iTmj+K7iXA4uSEY4pi/R7vfeb+HtZVvhWouj3hg==
X-Google-Smtp-Source: ABdhPJz9SSYRr/gjgg62TZKE74JqYdhBC0T2ckfqD385iZBfk0LXoaPi8NW+0cJehqzqO68EknrpN4ceDjS/IdHWygY=
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr10628308ejb.555.1630881103283;
 Sun, 05 Sep 2021 15:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
 <20210826012626.1163705-2-isabellabdoamaral@usp.br> <CABVgOS==dbwMyFcP5ZMhMWGSNTXgsCw1gm2DnoCCnhA0SRhpzw@mail.gmail.com>
In-Reply-To: <CABVgOS==dbwMyFcP5ZMhMWGSNTXgsCw1gm2DnoCCnhA0SRhpzw@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Sun, 5 Sep 2021 19:31:31 -0300
Message-ID: <CAAniXFT_C0kZ64uJWYwXsFR3KDyqmXdZH=vrWqmOvaioW7yLvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hash.h: remove unused define directive
To:     David Gow <davidgow@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David,

On Thu, Aug 26, 2021 at 1:01 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, Aug 26, 2021 at 9:26 AM Isabella Basso <isabellabdoamaral@usp.br>=
 wrote:
> >
> > The HAVE_ARCH_HASH_32 (single underscore) define hasn't been used for
> > any known supported architectures that have their own hash function
> > implementation (i.e. m68k, Microblaze, H8/300, pa-risc) since George's
> > patch [1], which introduced it.
> >
> > The supported 32-bit architectures from the list above have only been
> > making use of the (more general) HAVE_ARCH__HASH_32 define, which only
> > lacks the right shift operator, that wasn't targeted for optimizations
> > so far.
> >
> > [1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.scienceho=
rizons.net/
> >
> > Co-developed-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.co=
m>
> > Signed-off-by: Augusto Dur=C3=A3es Camargo <augusto.duraes33@gmail.com>
> > Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> > Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
> > Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> > ---
>
> I'm not familiar with the hash functions here, so take this with the
> appropriate heap of salt, but it took me a little while to understand
> exactly what this is doing.
>
> As I understand it:
> - There are separate __hash_32() and hash_32() functions.
> - Both of these have generic implementations, which can optionally be
> overridden by an architecture-specific optimised version.
> - There aren't any architectures which provide an optimised hash_32()
> implementation.
> - This patch therefore removes support for architecture-specific
> hash_32() implementations, and leaves only the generic implementation.
> - This generic implementation of hash_32() itself relies on
> __hash_32(), which may still be optimised.
>
> Could the commit description be updated to make this a bit clearer?

Sure, that makes perfect sense! Thank you very much for the feedback! Writi=
ng
those descriptions was quite a challenge for me, as I wasn't perfectly sure=
 of
what the appropriate reasoning should be for the message. I'm also glad I w=
as
able to get a grasp similar to yours. :)

> While we are getting rid of the HAVE_ARCH_HASH_32 #define, that seems
> to be a side-effect/implementation detail of removing support for
> architecture-specific hash_32() implementations...
>
> The other wild, out-there option would be to remove __hash_32()
> entirely and make everything use hash_32(), which then could have
> architecture-specific implementations. A quick grep reveals that
> there's only one use of __hash_32() outside of the hashing code itself
> (in fs/namei.c). This would be much more consistent with what
> hash_64() does, but also would be significantly more work, and
> potentially could have some implication (full_name_hash() performance
> maybe?) which I'm not aware of. So it's possibly not worth it.

I do agree with you that it seems a bit over the top, as I'm also really no=
t
aware of the performance implications of such a change (and that seemed to =
be
what motivated most of the patch series that introduced the __hash_32() to
fs/namei.c), so I'd rather not mess with fs/namei.c based on consistency
reasons alone.

Thanks,
--
Isabella Basso
