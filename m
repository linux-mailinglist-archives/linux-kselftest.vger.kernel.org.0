Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A526034733
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2019 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfFDMpp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 08:45:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFDMpp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 08:45:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so12622289pfe.6
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2019 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SX1wXsAGfUFN70h44peTZcKIMqGr5ZE+ZDyQc1zQL5o=;
        b=E/mvMDTExggwag20QOMbkhKP75T7Pk+0ZF0pcXUr5AaTNbmr23JwDn0UqrTqxdl5Je
         krdUOdiGs3h2/gebELEz8jqrOUeDCDUC2JEOV4V8ITgtQF1Ax7woXAnTfQ5gsE1sKCk5
         73PDFS4epP+6c23bo89e7xnteUzAo/q7k0cXafuB0juxjfStepuJz67jDdEHof0O7Ctq
         rV/upWmgoM7X7JZZHSCmqQbuzKuvYpbwxz+61v3PWpNyw0Pr5WN0hOaTsMwrna556VUE
         CzT1IMUxqM0c1X/8hXFuS/fU+Fq0VdvtOqB87v2sTCjXWa4vVxnoJGfUoTWZKlqF7TqV
         Xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SX1wXsAGfUFN70h44peTZcKIMqGr5ZE+ZDyQc1zQL5o=;
        b=BUaoUCFkgqCtBoQj18WptgF+qjcEVTdoz6aQMQ/q1ToMVfcIisv0wpUTKsSTrm9kEi
         pa6y5mjryV6GyJ0ZIuUmvO6L5B+uZjZTrXsmXjwqHTvWN305rW24qDKM+nFy2UKmzOok
         1NytPBVsWIvS1uBXf7lL0eFiBKQmpg6311asjnJpAXg+hdvrNfaxm5zr8GJmA1/201Ap
         u3oRsxHfSLdHbea+wum4SYmAzVZk4Lmeb1cuW5gb5YCWofEcy/qHykUag4Oo9rCkh4uw
         LqZxaweZN3UOeOmBf2Nh0dncvzxbp7X70b7Ep1EC/5zqYK7y2JkfEeULqVJIFRF/eNqD
         GyWA==
X-Gm-Message-State: APjAAAVLvAZ8Dh9rBzL1wTSG8qra1NybCUniQOSHHYR2vLulxnQfxS3T
        0UhEUksztz7b2SdjkF64Gg1SUrfn1lUx0jh3rvNzCg==
X-Google-Smtp-Source: APXvYqzZt2kMUXJ9WHlwmRLt2vrbUVohOpQLy3RY96eqdlAIdJcx5KC4nxWy0iNPEMefwexAGDMOHmuMZCiVo+DqZfo=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr28955959pje.123.1559652343964;
 Tue, 04 Jun 2019 05:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
 <20190603174619.GC11474@ziepe.ca> <CAAeHK+xy-dx4dLDLLj9dRzRNSVG9H5nDPPnjpYF38qKZNNCh_g@mail.gmail.com>
 <20190604122714.GA15385@ziepe.ca>
In-Reply-To: <20190604122714.GA15385@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Jun 2019 14:45:32 +0200
Message-ID: <CAAeHK+xyqwuJyviGhvU7L1wPZQF7Mf9g2vgKSsYmML3fV6NrXg@mail.gmail.com>
Subject: Re: [PATCH v16 12/16] IB, arm64: untag user pointers in ib_uverbs_(re)reg_mr()
To:     Jason Gunthorpe <jgg@ziepe.ca>
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

On Tue, Jun 4, 2019 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 04, 2019 at 02:18:19PM +0200, Andrey Konovalov wrote:
> > On Mon, Jun 3, 2019 at 7:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Jun 03, 2019 at 06:55:14PM +0200, Andrey Konovalov wrote:
> > > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > > pass tagged user pointers (with the top byte set to something else other
> > > > than 0x00) as syscall arguments.
> > > >
> > > > ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> > > > e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> > > >
> > > > Untag user pointers in these functions.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > >  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > > > index 5a3a1780ceea..f88ee733e617 100644
> > > > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > > > @@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > +     cmd.start = untagged_addr(cmd.start);
> > > > +
> > > >       if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
> > > >               return -EINVAL;
> > >
> > > I feel like we shouldn't thave to do this here, surely the cmd.start
> > > should flow unmodified to get_user_pages, and gup should untag it?
> > >
> > > ie, this sort of direction for the IB code (this would be a giant
> > > patch, so I didn't have time to write it all, but I think it is much
> > > saner):
> >
> > Hi Jason,
> >
> > ib_uverbs_reg_mr() passes cmd.start to mlx4_get_umem_mr(), which calls
> > find_vma(), which only accepts untagged addresses. Could you explain
> > how your patch helps?
>
> That mlx4 is just a 'weird duck', it is not the normal flow, and I
> don't think the core code should be making special consideration for
> it.

How do you think we should do untagging (or something else) to deal
with this 'weird duck' case?

>
> Jason
