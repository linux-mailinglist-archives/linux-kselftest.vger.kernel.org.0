Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4656F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2019 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFZRS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jun 2019 13:18:27 -0400
Received: from foss.arm.com ([217.140.110.172]:37610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZRS1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jun 2019 13:18:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC85360;
        Wed, 26 Jun 2019 10:18:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 876353F718;
        Wed, 26 Jun 2019 10:18:21 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:18:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v18 00/15] arm64: untag user pointers passed to the kernel
Message-ID: <20190626171819.GG29672@arrakis.emea.arm.com>
References: <cover.1561386715.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,

On Mon, Jun 24, 2019 at 04:32:45PM +0200, Andrey Konovalov wrote:
> Andrey Konovalov (14):
>   arm64: untag user pointers in access_ok and __uaccess_mask_ptr
>   lib: untag user pointers in strn*_user
>   mm: untag user pointers passed to memory syscalls
>   mm: untag user pointers in mm/gup.c
>   mm: untag user pointers in get_vaddr_frames
>   fs/namespace: untag user pointers in copy_mount_options
>   userfaultfd: untag user pointers
>   drm/amdgpu: untag user pointers
>   drm/radeon: untag user pointers in radeon_gem_userptr_ioctl
>   IB/mlx4: untag user pointers in mlx4_get_umem_mr
>   media/v4l2-core: untag user pointers in videobuf_dma_contig_user_get
>   tee/shm: untag user pointers in tee_shm_register
>   vfio/type1: untag user pointers in vaddr_get_pfn
>   selftests, arm64: add a selftest for passing tagged pointers to kernel
> 
> Catalin Marinas (1):
>   arm64: Introduce prctl() options to control the tagged user addresses
>     ABI
> 
>  arch/arm64/Kconfig                            |  9 +++
>  arch/arm64/include/asm/processor.h            |  8 +++
>  arch/arm64/include/asm/thread_info.h          |  1 +
>  arch/arm64/include/asm/uaccess.h              | 12 +++-
>  arch/arm64/kernel/process.c                   | 72 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +
>  drivers/gpu/drm/radeon/radeon_gem.c           |  2 +
>  drivers/infiniband/hw/mlx4/mr.c               |  7 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c |  9 +--
>  drivers/tee/tee_shm.c                         |  1 +
>  drivers/vfio/vfio_iommu_type1.c               |  2 +
>  fs/namespace.c                                |  2 +-
>  fs/userfaultfd.c                              | 22 +++---
>  include/uapi/linux/prctl.h                    |  5 ++
>  kernel/sys.c                                  | 12 ++++
>  lib/strncpy_from_user.c                       |  3 +-
>  lib/strnlen_user.c                            |  3 +-
>  mm/frame_vector.c                             |  2 +
>  mm/gup.c                                      |  4 ++
>  mm/madvise.c                                  |  2 +
>  mm/mempolicy.c                                |  3 +
>  mm/migrate.c                                  |  2 +-
>  mm/mincore.c                                  |  2 +
>  mm/mlock.c                                    |  4 ++
>  mm/mprotect.c                                 |  2 +
>  mm/mremap.c                                   |  7 ++
>  mm/msync.c                                    |  2 +
>  tools/testing/selftests/arm64/.gitignore      |  1 +
>  tools/testing/selftests/arm64/Makefile        | 11 +++
>  .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++
>  tools/testing/selftests/arm64/tags_test.c     | 29 ++++++++
>  32 files changed, 232 insertions(+), 25 deletions(-)

It looks like we got to an agreement on how to deal with tagged user
addresses between SPARC ADI and ARM Memory Tagging. If there are no
other objections, what's your preferred way of getting this series into
-next first and then mainline? Are you ok to merge them into the mm
tree?

Thanks.

-- 
Catalin
