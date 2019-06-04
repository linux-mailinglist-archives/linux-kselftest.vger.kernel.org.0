Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6C34664
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2019 14:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFDMSb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 08:18:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfFDMSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 08:18:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so12581275pfe.6
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2019 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izP2xVkH+lJ1XiJaz25EL/2sjI5XZqFKPi8rAth3/y8=;
        b=anXrne3zDdmEVildSzDwGKYMdshtpWiEi/bSjfUgHwDoCg62X8GEgJ1oLKPrpJDBTp
         sCO27Nd8vGOH1LG/aPfklMvFylAFcLd0duV9qTE0Uw2bgUkgehc21vjcK8KjtBKBSIeh
         hbrrSVL1q8qPT28KLxALn+5w5v0FjrGnKuEQGLgwne0GhOjJGw91IA05Yw5AYbDH2v2V
         eAfpEy7jnKgsdj8ID/iHcGjtOrlCN+u9PocCqqNSQrn/Xx8uaOQ0ef5ELA37nbSJameE
         4YvdhcrfbGwQSFgLEIgyOhrMQbK4CtUaCUAqm4fpOOKP+JqNZLGloD+rwiN3Vuf1ojqO
         poUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izP2xVkH+lJ1XiJaz25EL/2sjI5XZqFKPi8rAth3/y8=;
        b=hvohxmnT0IVlUcZWX/twbyx/sjerXgXumZ4k9YshtrNTCjaPQgpDJVAPAaus3L/M4S
         1RAYDtHABFEZH+mUXMlqwUdC+wAgbLqWypL8vYoUo6MWMrEayEt3q4lEKqVOjmIwZFxl
         GuWjmyCkXrmUQvPmUQS7hvVgOaY1ytq/YLhXdHCqYBWenA6Ez6tmbIAVabI4ugQAxYU0
         F21Y/IHrj/L8NceEYhduNUX4twJg3zL1VggrnGxU8emUGaI/6CmGl7GK8nY2Z/PYUpb/
         FTJYkA0cWtE33wRsFM820dBx6yaSxNIzC7JWW64U/TB6fCkrihDz06KHJ5ZZvuiS8BTs
         UwxA==
X-Gm-Message-State: APjAAAVmRGB9AN00YuKnCofEJJRwbn6zIHSJ5qEwg7bxUVtIMFIFIpCw
        HCp4rM6Uv06M437Ao7akxhwqezuvTVRjuhcZjc1oEw==
X-Google-Smtp-Source: APXvYqz1BnXRogJ38HsJg+YXXm2v0kW8wf81Q7/M4AVfD5zoRhp7qhUtn8D86raEkRJz58lLKdDFOynhTkL7EDkBRUg=
X-Received: by 2002:a63:1919:: with SMTP id z25mr35448936pgl.440.1559650710127;
 Tue, 04 Jun 2019 05:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
 <20190603174619.GC11474@ziepe.ca>
In-Reply-To: <20190603174619.GC11474@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Jun 2019 14:18:19 +0200
Message-ID: <CAAeHK+xy-dx4dLDLLj9dRzRNSVG9H5nDPPnjpYF38qKZNNCh_g@mail.gmail.com>
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

On Mon, Jun 3, 2019 at 7:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jun 03, 2019 at 06:55:14PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> > e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> >
> > Untag user pointers in these functions.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 5a3a1780ceea..f88ee733e617 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> >       if (ret)
> >               return ret;
> >
> > +     cmd.start = untagged_addr(cmd.start);
> > +
> >       if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
> >               return -EINVAL;
>
> I feel like we shouldn't thave to do this here, surely the cmd.start
> should flow unmodified to get_user_pages, and gup should untag it?
>
> ie, this sort of direction for the IB code (this would be a giant
> patch, so I didn't have time to write it all, but I think it is much
> saner):

Hi Jason,

ib_uverbs_reg_mr() passes cmd.start to mlx4_get_umem_mr(), which calls
find_vma(), which only accepts untagged addresses. Could you explain
how your patch helps?

Thanks!

>
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 54628ef879f0ce..7b3b736c87c253 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -193,7 +193,7 @@ EXPORT_SYMBOL(ib_umem_find_best_pgsz);
>   * @access: IB_ACCESS_xxx flags for memory being pinned
>   * @dmasync: flush in-flight DMA when the memory region is written
>   */
> -struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
> +struct ib_umem *ib_umem_get(struct ib_udata *udata, void __user *addr,
>                             size_t size, int access, int dmasync)
>  {
>         struct ib_ucontext *context;
> @@ -201,7 +201,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>         struct page **page_list;
>         unsigned long lock_limit;
>         unsigned long new_pinned;
> -       unsigned long cur_base;
> +       void __user *cur_base;
>         struct mm_struct *mm;
>         unsigned long npages;
>         int ret;
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5a3a1780ceea4d..94389e7f12371f 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -735,7 +735,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>                 }
>         }
>
> -       mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
> +       mr = pd->device->ops.reg_user_mr(pd, u64_to_user_ptr(cmd.start),
> +                                        cmd.length, cmd.hca_va,
>                                          cmd.access_flags,
>                                          &attrs->driver_udata);
>         if (IS_ERR(mr)) {
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 4d033796dcfcc2..bddbb952082fc5 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -786,7 +786,7 @@ static int mr_cache_max_order(struct mlx5_ib_dev *dev)
>  }
>
>  static int mr_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
> -                      u64 start, u64 length, int access_flags,
> +                      void __user *start, u64 length, int access_flags,
>                        struct ib_umem **umem, int *npages, int *page_shift,
>                        int *ncont, int *order)
>  {
> @@ -1262,8 +1262,8 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
>                                  attr->access_flags, mode);
>  }
>
> -struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> -                                 u64 virt_addr, int access_flags,
> +struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, void __user *start,
> +                                 u64 length, u64 virt_addr, int access_flags,
>                                   struct ib_udata *udata)
>  {
>         struct mlx5_ib_dev *dev = to_mdev(pd->device);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index ec6446864b08e9..b3c8eaaa35c760 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2464,8 +2464,8 @@ struct ib_device_ops {
>         struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
>                                      u64 virt_addr, int mr_access_flags,
>                                      struct ib_udata *udata);
> -       int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
> -                            u64 virt_addr, int mr_access_flags,
> +       int (*rereg_user_mr)(struct ib_mr *mr, int flags, void __user *start,
> +                            u64 length, u64 virt_addr, int mr_access_flags,
>                              struct ib_pd *pd, struct ib_udata *udata);
>         int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
>         struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
