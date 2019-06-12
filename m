Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD02F42386
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408972AbfFLLIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:08:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45630 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408952AbfFLLIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:08:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so9444158pfm.12
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w620wCIkG8GXS/KYH0IDoZ7ej5kJ3WmWx8LtN+LbTUQ=;
        b=VggNUJ7a0brq2Ev6nAJQqO2O72gohucw8zeY5YtHck9VQOLSeh4HE1gegC/6IXwwZQ
         yGU57RiXcKZXz6rEKzU45Xf6W2ce+VRfcbyLnBuDiGAB0WY+oQBhpKyfWyvJoxfZX9DP
         yh5EZsvMAI815IqL/1YdyEKkghoO2fuJKDAzd5Q9y/OjjRwPS+GPbIwNDHqKiLuIYdn3
         FS/k/NQyAktrRCCDybeyESanVpXbjmTwdROU2U/U+lx1nc+kfxYxbzF+ximhp+/PoGPk
         LddaTqB/qiSjwgqbl0KdSRDedqW9qTDDWoaJfcFucWGR/PYqdZ87SzwkAPpr4TVyN7Wo
         N3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w620wCIkG8GXS/KYH0IDoZ7ej5kJ3WmWx8LtN+LbTUQ=;
        b=rt9T6FCy6I9Pve0KLOfOjqu8k75VXkWJ6Ex/7yEsI/at55akCicrHhmTtUJAHQRsL3
         YP6Xuw5T+1M9kPYrPRMhB9g2SK0d/JPSBo0HGRr55A6jD2aKnKNYQTiGVV2ePvNyJKzK
         rzYMii4hcRI3ESLWdraEe8jLHNrLewS6pzSsktELr9uuy6bYMTZawvYcO9kkba1Xbo3V
         RwZYP9F9mexR8SAKQ5NzsurxyQMFyO4QCOQrDGFxSH3MJqpwD/kobvFLnWlcZCXXJvED
         G9+GKa8Uo1pX8qTnrxZwGUQbzdBq2xdhnkEurIAusUrGzFu7MM9J5pTpeiXTTDPadxyQ
         HIMA==
X-Gm-Message-State: APjAAAW4vPF/2cS+1k3zUeLFtqa8Krl2MhRfleyFI9TxzW0/X6chOg1f
        IOJwnyb4XACisd8GVavnLOAgmD5hCo9GMEbXxTfb2w==
X-Google-Smtp-Source: APXvYqxvUwlKkJ1D0n5ZAgi1aKr005PngCLgks22Vr4JdWsBWlki9wY2M2Qsc1xcmNb71INK9Pq98aEQaKS4b6HnOls=
X-Received: by 2002:aa7:97bb:: with SMTP id d27mr18449962pfq.93.1560337726555;
 Wed, 12 Jun 2019 04:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <e410843d00a4ecd7e525a7a949e605ffc6c394c4.1559580831.git.andreyknvl@google.com>
 <d0dffcf8-d7bf-a7b4-5766-3a6f87437851@oracle.com>
In-Reply-To: <d0dffcf8-d7bf-a7b4-5766-3a6f87437851@oracle.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Jun 2019 13:08:35 +0200
Message-ID: <CAAeHK+yTmU9Vz0OB4b7bcgjU3W1v6NFxgpiy4tud7j0AHXkwtw@mail.gmail.com>
Subject: Re: [PATCH v16 04/16] mm: untag user pointers in do_pages_move
To:     Khalid Aziz <khalid.aziz@oracle.com>
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
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>, enh <enh@google.com>,
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

On Tue, Jun 11, 2019 at 10:18 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 6/3/19 10:55 AM, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > do_pages_move() is used in the implementation of the move_pages syscall.
> >
> > Untag user pointers in this function.
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/migrate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index f2ecc2855a12..3930bb6fa656 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1617,6 +1617,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> >               if (get_user(node, nodes + i))
> >                       goto out_flush;
> >               addr = (unsigned long)p;
> > +             addr = untagged_addr(addr);
>
> Why not just "addr = (unsigned long)untagged_addr(p);"

Will do in the next version. I think I'll also merge this commit into
the "untag user pointers passed to memory syscalls" one.

>
> --
> Khalid
>
