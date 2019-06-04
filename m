Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C03347B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2019 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFDNJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 09:09:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44000 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfFDNJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 09:09:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so10334204pgv.10
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2019 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBLpk28DZpa5o94Q/0/LiLBGCkVoEs9cAD1KugSM2WY=;
        b=Lkz8dpKPRyddE/5l1SxtFW2tJDVJSIsNFYCOD1eigwQMuFNNmYLAz8pfUb/eNChwZF
         OH2h9RaIuTJvzD4zfwI4In+YKCusdO0C+/wNdpvUvPZXC2iOOrHIqrrS+koi+fxYqD+r
         iK2Zgy43Tahmq3qaqGtP4n+xMyhj8Yk3JvazolAsNKLfjKj1GXO3dAAQy063Hi2tMAsN
         GhJY2yKC3BApNCj1AkvEe/6mz6FyJyIhhdR95z/RQ7El5pARzqaaKppkgNvLbKRJzKwz
         N+Va7sAICkGdL463idSaVxKwCH7V2NZvNaXeQHS+go3oLu7b/Bj32cawMXuwRC+DSWx3
         9rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBLpk28DZpa5o94Q/0/LiLBGCkVoEs9cAD1KugSM2WY=;
        b=CikcSOQkC5kX+puYXztFO8EFHshmvmNARjJTH8n9qWy5mml+SRpZog+tCY8735iA0k
         GlVK4RL0/kSHRU7OAG4HCyw3njBWYNKWhKOecrI5UA6biHIhozWuKlb/d50rRmDi0L7e
         BK/ZBUsyKoBjkZykzTv42rOTFQK0YzMqQZLPDB2BTKp4VIBBvPaqY9CEa/C4MuFmeby7
         +7WFlI4AolgWUGjJDfb3i2XjkZlyi2JGj7EXPtX5qhZOSItAD86JZKtJbrFaH2HNhfwM
         THXo9bOgfAM+Hf3pXXDvg6A2QgLevaXKAdfqdi/FxbyijYC5Wd6DoYOczRiDJE/xjKgl
         e+5A==
X-Gm-Message-State: APjAAAVDQMkmGWFYNFiv+y4wVPQpBnGC3rGOMwSh3RoE5kzEud4+/E8K
        xzo6WIU/biTztwWx2hCJtiE7J1k55D/eumJw/N9TPg==
X-Google-Smtp-Source: APXvYqwE+yY3fi9MHe5pAmjH6ujV7dnKQuJJ2mvTpcdW82/qczftH0mUauffZu6ryTn350uiR7ngmmR4ga1rtqlB5p8=
X-Received: by 2002:aa7:8491:: with SMTP id u17mr25575697pfn.93.1559653777333;
 Tue, 04 Jun 2019 06:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
 <20190603174619.GC11474@ziepe.ca> <CAAeHK+xy-dx4dLDLLj9dRzRNSVG9H5nDPPnjpYF38qKZNNCh_g@mail.gmail.com>
 <20190604122714.GA15385@ziepe.ca> <CAAeHK+xyqwuJyviGhvU7L1wPZQF7Mf9g2vgKSsYmML3fV6NrXg@mail.gmail.com>
 <20190604130207.GD15385@ziepe.ca>
In-Reply-To: <20190604130207.GD15385@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Jun 2019 15:09:26 +0200
Message-ID: <CAAeHK+xBxDB-OBuzPDcNaTHCNJqu6djHwqoVGSYpxG33w-YR9g@mail.gmail.com>
Subject: Re: [PATCH v16 12/16] IB, arm64: untag user pointers in ib_uverbs_(re)reg_mr()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
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

On Tue, Jun 4, 2019 at 3:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 04, 2019 at 02:45:32PM +0200, Andrey Konovalov wrote:
> > On Tue, Jun 4, 2019 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jun 04, 2019 at 02:18:19PM +0200, Andrey Konovalov wrote:
> > > > On Mon, Jun 3, 2019 at 7:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Mon, Jun 03, 2019 at 06:55:14PM +0200, Andrey Konovalov wrote:
> > > > > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > > > > pass tagged user pointers (with the top byte set to something else other
> > > > > > than 0x00) as syscall arguments.
> > > > > >
> > > > > > ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> > > > > > e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> > > > > >
> > > > > > Untag user pointers in these functions.
> > > > > >
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > >  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > > > > index 5a3a1780ceea..f88ee733e617 100644
> > > > > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > > > > @@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> > > > > >       if (ret)
> > > > > >               return ret;
> > > > > >
> > > > > > +     cmd.start = untagged_addr(cmd.start);
> > > > > > +
> > > > > >       if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
> > > > > >               return -EINVAL;
> > > > >
> > > > > I feel like we shouldn't thave to do this here, surely the cmd.start
> > > > > should flow unmodified to get_user_pages, and gup should untag it?
> > > > >
> > > > > ie, this sort of direction for the IB code (this would be a giant
> > > > > patch, so I didn't have time to write it all, but I think it is much
> > > > > saner):
> > > >
> > > > Hi Jason,
> > > >
> > > > ib_uverbs_reg_mr() passes cmd.start to mlx4_get_umem_mr(), which calls
> > > > find_vma(), which only accepts untagged addresses. Could you explain
> > > > how your patch helps?
> > >
> > > That mlx4 is just a 'weird duck', it is not the normal flow, and I
> > > don't think the core code should be making special consideration for
> > > it.
> >
> > How do you think we should do untagging (or something else) to deal
> > with this 'weird duck' case?
>
> mlx4 should handle it around the call to find_vma like other patches
> do, ideally as part of the cast from a void __user * to the unsigned
> long that find_vma needs

So essentially what we had a few versions ago
(https://lkml.org/lkml/2019/4/30/785) plus changing unsigned longs to
__user * across all IB code? I think the second part is something
that's not related to this series and needs to be done separately. I
can move untagging back to mlx4_get_umem_mr() though.

Catalin, you've initially asked to to move untagging out of
mlx4_get_umem_mr(), do you have any comments on this?

>
> Jason
