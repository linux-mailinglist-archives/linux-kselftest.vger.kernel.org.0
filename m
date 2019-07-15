Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC5698C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2019 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfGOQAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 12:00:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36019 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbfGOQAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 12:00:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so7625988pfl.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q0q/IfCRadymayHol/UUF72+yJ91bYAnFv+xLR30xQ=;
        b=awILUWqnOhL8QrLhWTtK3zyGeYzsbGaDmlapw+TJPtpLmDPRw1GP6vt2k8M63kLr39
         ZOpRC9dNiFsjXCuRW9tvX+XJ4TMinqKEg4V9d0/Cohi7g+H0FLJqsymSlujZFTSwFgq+
         HGvo45b5poteQElVP2ylrss//l0SvENb9w0NdEWBIgvpqnNLsaE/1Oq03NG9YiPmMbZi
         8k5Fou1N/CEVlyaSlbvq+wKBgrOUzCIo1B2qg8bQ1mlF2+F/VYvQbx6QNpAS+GS8VYMS
         4d6tYcKUYuIyyU24AI3+kh3w0LS9e+N+YdRnIzCnanxcL1YdF0dX0SOZIdMQqtDbfKe6
         /xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q0q/IfCRadymayHol/UUF72+yJ91bYAnFv+xLR30xQ=;
        b=VGlsqSJSOfo7PN+lp0DISOQk4ccc5SyfTzyKjhYGbtXZ43nu83SdSxYrXaUBfS7lYi
         v2TuYgCR1IYM2JGbyiSZ8/Qt2J9UA79TA3du3I3uOHuuuJQjPUJnNPnOr+Du2gh3EnRa
         WwCUinxzcl6Wn4mO7HVGBAcB5DZiUw6CqF8L0a2DTnlXmLbB47cSoMl7t53X1eptRQad
         BI0ABZc2JuLWxpYsMTvliaaXps1gUHDJou0kUGZbOAQ5KuFAQMpVOEGnZyYQlOyGJ8Qx
         U78zJe0WAS/nvWWgoLzNQPAMQxoCJPLXzTrvFgYWMAgLVGxBBulQwmY4LRiR2a3Xcg15
         rnSg==
X-Gm-Message-State: APjAAAVpqvraD+lUqmvtDWWKfCwh2xwiEjOCAn0hkzSeZACNACd104VH
        3sqpUisf0GzLT1UFbGywv1E20yWOq/3n4EiSUr1eSg==
X-Google-Smtp-Source: APXvYqw+s/Xsm1Inj9c3bcQDg7/b3DVU+zlhxUxxhLhtcMSC55W2OaWJF9iNwAodQ+4dHaGR8RmRVxTzfqDyBCor0Ro=
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr30231713pje.129.1563206445986;
 Mon, 15 Jul 2019 09:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
 <20190624175120.GN29120@arrakis.emea.arm.com>
In-Reply-To: <20190624175120.GN29120@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Jul 2019 18:00:34 +0200
Message-ID: <CAAeHK+w=Hi2OQSBfRGmw2dG15ctiHoP6DpktyFG7Qo3AohBAgA@mail.gmail.com>
Subject: Re: [PATCH v18 08/15] userfaultfd: untag user pointers
To:     Catalin Marinas <catalin.marinas@arm.com>
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 24, 2019 at 7:51 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 04:32:53PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > userfaultfd code use provided user pointers for vma lookups, which can
> > only by done with untagged pointers.
> >
> > Untag user pointers in validate_range().
> >
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  fs/userfaultfd.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
>
> Same here, it needs an ack from Al Viro.

Hi Al,

Could you take a look at this one as well and give your acked-by?

Thanks!

>
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index ae0b8b5f69e6..c2be36a168ca 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
> >  }
> >
> >  static __always_inline int validate_range(struct mm_struct *mm,
> > -                                       __u64 start, __u64 len)
> > +                                       __u64 *start, __u64 len)
> >  {
> >       __u64 task_size = mm->task_size;
> >
> > -     if (start & ~PAGE_MASK)
> > +     *start = untagged_addr(*start);
> > +
> > +     if (*start & ~PAGE_MASK)
> >               return -EINVAL;
> >       if (len & ~PAGE_MASK)
> >               return -EINVAL;
> >       if (!len)
> >               return -EINVAL;
> > -     if (start < mmap_min_addr)
> > +     if (*start < mmap_min_addr)
> >               return -EINVAL;
> > -     if (start >= task_size)
> > +     if (*start >= task_size)
> >               return -EINVAL;
> > -     if (len > task_size - start)
> > +     if (len > task_size - *start)
> >               return -EINVAL;
> >       return 0;
> >  }
> > @@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >               goto out;
> >       }
> >
> > -     ret = validate_range(mm, uffdio_register.range.start,
> > +     ret = validate_range(mm, &uffdio_register.range.start,
> >                            uffdio_register.range.len);
> >       if (ret)
> >               goto out;
> > @@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >       if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> >               goto out;
> >
> > -     ret = validate_range(mm, uffdio_unregister.start,
> > +     ret = validate_range(mm, &uffdio_unregister.start,
> >                            uffdio_unregister.len);
> >       if (ret)
> >               goto out;
> > @@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
> >       if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
> >               goto out;
> >
> > -     ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
> > +     ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
> >       if (ret)
> >               goto out;
> >
> > @@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> >                          sizeof(uffdio_copy)-sizeof(__s64)))
> >               goto out;
> >
> > -     ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
> > +     ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
> >       if (ret)
> >               goto out;
> >       /*
> > @@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> >                          sizeof(uffdio_zeropage)-sizeof(__s64)))
> >               goto out;
> >
> > -     ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
> > +     ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
> >                            uffdio_zeropage.range.len);
> >       if (ret)
> >               goto out;
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
