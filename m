Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0043CEF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbfFKOih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 10:38:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35757 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfFKOig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 10:38:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so5223895plo.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2019 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Bb9evtnnpvJpDG7+k/xfmfwlxE7BAZZaECd7yQ/bgY=;
        b=vFVLFZFyIF01TbjN+xeeME15qV8KkCRDccJHkbwPJnzYqntxAPPejl4UucLg68kkqb
         BaObH7iQP83sFpaN8IH2/Yu4t4nwUDbwn3rb15fIHqVU7geywA3LRxp1p4GflSM3qTjJ
         iWM19kJHA7FmF25W9uFiY1kMJbcO4WOESGJU61YywCA+i6Ylfs/3WF6YNj5xaMoYJ89L
         XqlvBDrbDKlYUJNKkeiCJcKNhxFQvdK51GyYrA4cNM42eSbHTJc/2qrnnTIYWyQugg14
         drUy2FSlkxzvJpoh5mj5M9w5F5osUe6J99CThZKFzYA/JvReekTQOE0mCFzBedDfUO6l
         PqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Bb9evtnnpvJpDG7+k/xfmfwlxE7BAZZaECd7yQ/bgY=;
        b=jka1n467d/BxTBjfOo4owVmLspd8h4J2EWDhOMZrAZke+MfhmFFQcW1ip7I+OmlNkp
         Upbdn6zAeaPTJM5tB0sLh6j3gN9MIIumeU0Asxv/zvsaL7/lEAJifAwUMMZnQLlmX+KD
         3zxaz6SoXw2kkoPW8OCXbppkgC0Iy0pADVEayb81PMnRqDhkKnNYerLLo6df4p/OHyOq
         VW/3OgzVSYlvg7egpYD0xGnQnmZBP/Tr8ayM76rYjN9SuFrNLFNHVOsUhjieAUxfyQFE
         kMt+Q9MOeeEisKPl496vB4TmiuuJyfQ881vtLEdPm9e6vL5B4AAb/eJzPnFJv/23qovh
         SXGA==
X-Gm-Message-State: APjAAAWZlHO9+hsl1wEKfzz7X6Y1PLcw+SqdCqSB86gnP1avhHsrohue
        2Hk+2UrFaLu8GSgB/R729p10ur5ciPcb0Y8nowlZnA==
X-Google-Smtp-Source: APXvYqyIzOH5zo/01pYiY/WLl0OLwpsCvaKKuk+vDciT43wSxP3iXzYy6GsWF4y5D8CeYcDREH0+OmLOdYtg4cNrux0=
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr78131643plh.147.1560263915764;
 Tue, 11 Jun 2019 07:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
 <201906072101.58C919E@keescook>
In-Reply-To: <201906072101.58C919E@keescook>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Jun 2019 16:38:24 +0200
Message-ID: <CAAeHK+y8CH4P3vheUDCEnPAuO-2L6mc-sz6wMA_hT=wC1Cy3KQ@mail.gmail.com>
Subject: Re: [PATCH v16 08/16] fs, arm64: untag user pointers in copy_mount_options
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 8, 2019 at 6:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 03, 2019 at 06:55:10PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > In copy_mount_options a user address is being subtracted from TASK_SIZE.
> > If the address is lower than TASK_SIZE, the size is calculated to not
> > allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
> > However if the address is tagged, then the size will be calculated
> > incorrectly.
> >
> > Untag the address before subtracting.
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> One thing I just noticed in the commit titles... "arm64" is in the
> prefix, but these are arch-indep areas. Should the ", arm64" be left
> out?
>
> I would expect, instead:
>
>         fs/namespace: untag user pointers in copy_mount_options

Hm, I've added the arm64 tag in all of the patches because they are
related to changes in arm64 kernel ABI. I can remove it from all the
patches that only touch common code if you think that it makes sense.

Thanks!

>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  fs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index b26778bdc236..2e85712a19ed 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2993,7 +2993,7 @@ void *copy_mount_options(const void __user * data)
> >        * the remainder of the page.
> >        */
> >       /* copy_from_user cannot cross TASK_SIZE ! */
> > -     size = TASK_SIZE - (unsigned long)data;
> > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> >       if (size > PAGE_SIZE)
> >               size = PAGE_SIZE;
> >
> > --
> > 2.22.0.rc1.311.g5d7573a151-goog
> >
>
> --
> Kees Cook
