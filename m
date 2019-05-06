Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6955114B3E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEFNxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 09:53:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43331 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfEFNxN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 09:53:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so1612465pfa.10
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfsikH3ADmgNVGOW8dVHffAJXBPBy/1Drd0IdtpjjJ8=;
        b=kv7aGbZwowOP86IiNXKGTzv02HGdI2dS555U/AmH12LgQOZnKLK39c4sVdRuufn96A
         qthFKSfdn7G60uj86be1sn6Yz08bEym7ZdQPS1mHAwXca2PX4G4xwzBsumjfQSNalrzf
         yL5bwTZ9P03pKULjLPyCJCemso/1RN2dFNxsJkh8Db8dDQ4uyTu4XB2OtIwgRdUtOIbE
         AyYkrbplUjKWiH4tJjgIH/K5mFuPdBD8NVSdZa64NURA8ieEyhpOBhaJlBUr1GIoMIGp
         v2ptbSyS2qLsf62uamUc0COAt9buSU1YrXxFbkm18U+53rgjezb09axtZoHwZgv8hVgU
         L1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfsikH3ADmgNVGOW8dVHffAJXBPBy/1Drd0IdtpjjJ8=;
        b=RrE9/kE8YL+nTL+hzcPTBDzWqx1yQhEZHhIsgvINzVBG7kV0oeVITmzBbKGxBZmOXi
         hjAvM2I/Jki+1LiaCehQm9eZxgYc7dbfxaWxnHMyG5JKE8TdUGV2Zlmx8Tano0lxtEBv
         7gTDRbhfwTKLXJOITv3Qh7TK2zmlR6uo0mDeuuKugSwMnfUSQnbnbW9jZU68Q/qjArK8
         rOjjcbUtOTWLrmccbNwVMPU26jR/LU/ce+VYROzwj3BDeIICUwEXSlR0Cpovcq5qiwY/
         gtJHj31znKL5DLPIAf4xhw6a27lwuy1E2XRqWg7sDVNFU+A3q02k4JT0WGYqeeVYl/gU
         nUNQ==
X-Gm-Message-State: APjAAAUJIjV/gWuR/4ZslwbMgSbsO5tNvwez6FMu17hma8Dyz7Z3TFc4
        9x4dX3njt/Bp6aO4ojANylkC5Gjp10jv1b1CljQjag==
X-Google-Smtp-Source: APXvYqz1fgwxD3Q1L0PJp0GBoiDCnAmVuD+UduBO6dKustad4HqnmYC98uMKFLNp2x7D5yl19BVMVIT9EGy2Pg34Ktk=
X-Received: by 2002:aa7:9116:: with SMTP id 22mr33262822pfh.165.1557150792655;
 Mon, 06 May 2019 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com> <8e20df035de677029b3f970744ba2d35e2df1db3.1556630205.git.andreyknvl@google.com>
 <20190503165113.GJ55449@arrakis.emea.arm.com>
In-Reply-To: <20190503165113.GJ55449@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 6 May 2019 15:53:01 +0200
Message-ID: <CAAeHK+wCyCa-5=bPNwfivP6sEODOXKE1bPjcjc2y_T4rN+-6gA@mail.gmail.com>
Subject: Re: [PATCH v14 08/17] mm, arm64: untag user pointers in get_vaddr_frames
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
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 3, 2019 at 6:51 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 30, 2019 at 03:25:04PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > get_vaddr_frames uses provided user pointers for vma lookups, which can
> > only by done with untagged pointers. Instead of locating and changing
> > all callers of this function, perform untagging in it.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/frame_vector.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> > index c64dca6e27c2..c431ca81dad5 100644
> > --- a/mm/frame_vector.c
> > +++ b/mm/frame_vector.c
> > @@ -46,6 +46,8 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
> >       if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
> >               nr_frames = vec->nr_allocated;
> >
> > +     start = untagged_addr(start);
> > +
> >       down_read(&mm->mmap_sem);
> >       locked = 1;
> >       vma = find_vma_intersection(mm, start, start + 1);
>
> Is this some buffer that the user may have malloc'ed? I got lost when
> trying to track down the provenience of this buffer.

The caller that I found when I was looking at this:

drivers/gpu/drm/exynos/exynos_drm_g2d.c:482
exynos_g2d_set_cmdlist_ioctl()->g2d_map_cmdlist_gem()->g2d_userptr_get_dma_addr()->get_vaddr_frames()

>
> --
> Catalin
