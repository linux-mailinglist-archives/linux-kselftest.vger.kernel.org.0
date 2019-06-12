Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B325B42359
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406877AbfFLLCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:02:12 -0400
Received: from foss.arm.com ([217.140.110.172]:50388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406154AbfFLLCM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:02:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E16528;
        Wed, 12 Jun 2019 04:02:11 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04CA33F246;
        Wed, 12 Jun 2019 04:03:23 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:01:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Subject: Re: [PATCH v16 12/16] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190612110129.GC28951@C02TF0J2HF1T.local>
References: <cover.1559580831.git.andreyknvl@google.com>
 <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
 <20190603174619.GC11474@ziepe.ca>
 <CAAeHK+xy-dx4dLDLLj9dRzRNSVG9H5nDPPnjpYF38qKZNNCh_g@mail.gmail.com>
 <20190604122714.GA15385@ziepe.ca>
 <CAAeHK+xyqwuJyviGhvU7L1wPZQF7Mf9g2vgKSsYmML3fV6NrXg@mail.gmail.com>
 <20190604130207.GD15385@ziepe.ca>
 <CAAeHK+xBxDB-OBuzPDcNaTHCNJqu6djHwqoVGSYpxG33w-YR9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xBxDB-OBuzPDcNaTHCNJqu6djHwqoVGSYpxG33w-YR9g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 04, 2019 at 03:09:26PM +0200, Andrey Konovalov wrote:
> On Tue, Jun 4, 2019 at 3:02 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Tue, Jun 04, 2019 at 02:45:32PM +0200, Andrey Konovalov wrote:
> > > On Tue, Jun 4, 2019 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Tue, Jun 04, 2019 at 02:18:19PM +0200, Andrey Konovalov wrote:
> > > > > On Mon, Jun 3, 2019 at 7:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > > On Mon, Jun 03, 2019 at 06:55:14PM +0200, Andrey Konovalov wrote:
> > > > > > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > > > > > pass tagged user pointers (with the top byte set to something else other
> > > > > > > than 0x00) as syscall arguments.
> > > > > > >
> > > > > > > ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> > > > > > > e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> > > > > > >
> > > > > > > Untag user pointers in these functions.
> > > > > > >
> > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > >  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > > > > > index 5a3a1780ceea..f88ee733e617 100644
> > > > > > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > > > > > @@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> > > > > > >       if (ret)
> > > > > > >               return ret;
> > > > > > >
> > > > > > > +     cmd.start = untagged_addr(cmd.start);
> > > > > > > +
> > > > > > >       if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
> > > > > > >               return -EINVAL;
> > > > > >
> > > > > > I feel like we shouldn't thave to do this here, surely the cmd.start
> > > > > > should flow unmodified to get_user_pages, and gup should untag it?
> > > > > >
> > > > > > ie, this sort of direction for the IB code (this would be a giant
> > > > > > patch, so I didn't have time to write it all, but I think it is much
> > > > > > saner):
> > > > >
> > > > > ib_uverbs_reg_mr() passes cmd.start to mlx4_get_umem_mr(), which calls
> > > > > find_vma(), which only accepts untagged addresses. Could you explain
> > > > > how your patch helps?
> > > >
> > > > That mlx4 is just a 'weird duck', it is not the normal flow, and I
> > > > don't think the core code should be making special consideration for
> > > > it.
> > >
> > > How do you think we should do untagging (or something else) to deal
> > > with this 'weird duck' case?
> >
> > mlx4 should handle it around the call to find_vma like other patches
> > do, ideally as part of the cast from a void __user * to the unsigned
> > long that find_vma needs
> 
> So essentially what we had a few versions ago
> (https://lkml.org/lkml/2019/4/30/785) plus changing unsigned longs to
> __user * across all IB code? I think the second part is something
> that's not related to this series and needs to be done separately. I
> can move untagging back to mlx4_get_umem_mr() though.
> 
> Catalin, you've initially asked to to move untagging out of
> mlx4_get_umem_mr(), do you have any comments on this?

It's fine by me either way. My original reasoning was to untag this at
the higher level as tags may not be relevant to the mlx4 code. If that's
what Jason prefers, go for it.

-- 
Catalin
