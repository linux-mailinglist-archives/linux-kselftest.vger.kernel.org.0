Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3434A851EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2019 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfHGRRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Aug 2019 13:17:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36933 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfHGRRs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Aug 2019 13:17:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so41807964plr.4
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2019 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eJrnZxNMCItWIynTatJDEuA9CjWuilxGr3zPMXDYoA=;
        b=lvCOFn8kPw5sKWIBqAtj9nTDw5hreHjOLB8fZD9LK4XqWLqI/y9ZOZsE/4TR27f4Um
         7sNjnMM7si41kfySDx/t9SNrRsRpe9RSjuTSsxtP/LZWsBQ/9wQ/cD4jAY9Afx15eKqx
         drzyP65XIEr5B54raR+/HRbXQh7LyawRCf3zPKIRTqPoYkdFiyNYDBtM/quaMKyDYY7N
         e0hyz+AA4niyiPyNwzehq1Nhy/KS415dSI2CnjbBlju4Nld2LwgPUsvJDvfBXebX8Wbi
         Nmslq3Y7cfQOcqEViWBEfcEzC2SDosb0kffCvwGdMnZ05+LE89QNyyYCkt8oyQaFasdF
         n/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eJrnZxNMCItWIynTatJDEuA9CjWuilxGr3zPMXDYoA=;
        b=kR9Gfh0S7ey96VvetdSFS6x3UnJxsTwbQVMhB20ED/e6iSAhD2P215oxg/rBAYhVme
         9IlOcMA9qtDHVqbB15tsezuhk/jIXBoX7YZGA4D/8Fpq8RwwWuw4uLnXPMcfw3HoAKw0
         AmcD7so9cPVBXgRdqGH3GsRxKxF6Am+OvUl2IgO4nveYSQkU/WXe7B1aBSRcZpsf6Z6R
         m7lXgePiGOdwMYJIQYrtmyRa6EeFQicQSkZguvl9KYchTFK5QOMzk2jQkyiD24sTHPww
         nSpVHR4bOC3w+k7LFH/ex/JNcqQuRD2+Z+ARJ0uxRy+iXzVUj7oZ8ciLo1GYk0Yfk8/w
         0jeA==
X-Gm-Message-State: APjAAAX+HCl/Hf0IlXVq1YWbP9/mAl8I31H21x7+e1/9KswgND1LaFuB
        Ofl0v96cbWKc3kuUic2b2i+yIaMnQT1BlC4rCschMA==
X-Google-Smtp-Source: APXvYqyBW2S319ERBiJQIcPzcGoHmCZb6zerpXN+gU6uALMoVMzBI9LSMd7krnp9xpHZv3cXEfAdJC0fzaJdRwq+DTM=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr8596413pgq.130.1565198266795;
 Wed, 07 Aug 2019 10:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com> <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck> <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com> <20190806171335.4dzjex5asoertaob@willie-the-truck>
In-Reply-To: <20190806171335.4dzjex5asoertaob@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 19:17:35 +0200
Message-ID: <CAAeHK+zF01mxU+PkEYLkoVu-ZZM6jNfL_OwMJKRwLr-sdU4Myg@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
To:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        dri-devel@lists.freedesktop.org,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 6, 2019 at 7:13 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Jul 24, 2019 at 03:20:59PM +0100, Will Deacon wrote:
> > On Wed, Jul 24, 2019 at 04:16:49PM +0200, Andrey Konovalov wrote:
> > > On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
> > > > > Should this go through the mm or the arm tree?
> > > >
> > > > I would certainly prefer to take at least the arm64 bits via the arm64 tree
> > > > (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
> > > > the new ABI.
> > >
> > > Sounds good! Should I post those patches together with the
> > > Documentation patches from Vincenzo as a separate patchset?
> >
> > Yes, please (although as you say below, we need a new version of those
> > patches from Vincenzo to address the feedback on v5). The other thing I
> > should say is that I'd be happy to queue the other patches in the series
> > too, but some of them are missing acks from the relevant maintainers (e.g.
> > the mm/ and fs/ changes).
>
> Ok, I've queued patches 1, 2, and 15 on a stable branch here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/tbi
>
> which should find its way into -next shortly via our for-next/core branch.
> If you want to make changes, please send additional patches on top.
>
> This is targetting 5.4, but I will drop it before the merge window if
> we don't have both of the following in place:
>
>   * Updated ABI documentation with Acks from Catalin and Kevin

Catalin has posted a new version today.

>   * The other patches in the series either Acked (so I can pick them up)
>     or queued via some other tree(s) for 5.4.

So we have the following patches in this series:

1. arm64: untag user pointers in access_ok and __uaccess_mask_ptr
2. arm64: Introduce prctl() options to control the tagged user addresses ABI
3. lib: untag user pointers in strn*_user
4. mm: untag user pointers passed to memory syscalls
5. mm: untag user pointers in mm/gup.c
6. mm: untag user pointers in get_vaddr_frames
7. fs/namespace: untag user pointers in copy_mount_options
8. userfaultfd: untag user pointers
9. drm/amdgpu: untag user pointers
10. drm/radeon: untag user pointers in radeon_gem_userptr_ioctl
11. IB/mlx4: untag user pointers in mlx4_get_umem_mr
12. media/v4l2-core: untag user pointers in videobuf_dma_contig_user_get
13. tee/shm: untag user pointers in tee_shm_register
14. vfio/type1: untag user pointers in vaddr_get_pfn
15. selftests, arm64: add a selftest for passing tagged pointers to kernel

1, 2 and 15 have been picked by Will.

11 has been picked up by Jason.

9, 10, 12, 13 and 14 have acks from their subsystem maintainers.

3 touches generic lib code, I'm not sure if there's a dedicated
maintainer for that.

The ones that are left are the mm ones: 4, 5, 6, 7 and 8.

Andrew, could you take a look and give your Acked-by or pick them up directly?

>
> Make sense?
>
> Cheers,
>
> Will

Thanks!
