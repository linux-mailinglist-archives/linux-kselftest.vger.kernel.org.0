Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F63217D7D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 05:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGHDUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDUF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 23:20:05 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D282C061755;
        Tue,  7 Jul 2020 20:20:05 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id y13so21577839ybj.10;
        Tue, 07 Jul 2020 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y395uq9ReqH2QX93opdrgHuWiwbpwhJOGLNOpbOYln4=;
        b=Wa8yVrPinL0aOLQ7Hfplhtj7J5g22NlsP9MXp9Ms1yv22XoeLGiaVaVtB7/gkAG+L4
         UaXBz9HCVN+/t+fFjg6mi8JG0/BQdFZjNE863x13dQns4fkFPVoCu42dG3DO3qoIT/6u
         Cpy36Kyz0MA4rfwt25sjvA6WzYaC8byEvYRNxhDKXuNtKauPWy0pJH2oIYh87jeE8rqI
         sTc7OvVyRJBa0mWBkrmQIbW+Tsn2cSJil+Fxu5m8vZEXDASfOo5NYCKWpuATdLbxv0Iv
         h5TzHkfcpbW7Vv0fyH+dQFQm3/1LracmJdRBWRrklkQs3rbDadtCep+hheCFXlroyhP4
         Khfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y395uq9ReqH2QX93opdrgHuWiwbpwhJOGLNOpbOYln4=;
        b=Zu+/TTPicRBxgh+anTiQavyRkQqGUjOc/Qx4WegqGUNKeiR1CY/JFsOF/XIxMOyrT+
         Fnc5XRYvlXnlI+2gzbbcgsSPSb/iTIY3OxpDrWuYeDoUqPj/am+WeeEwNpADipoli5uW
         CtPcINCNntIcgQvbyz5HZEHH0pFdqNF54I0RSn8kv7hK8Ex4NcV/fFeqxznoeVWy+MKg
         /gNO4+pT0xr9IPfKE5HVAbl3wl+tV0jez9MnWwgFR6qc03xvYGeuQm9RTWbrgfNJhuX7
         hTxyrj6LrSpgzPRIAi8uPuXVREa8D76adj8tQx9QBdM/5r0jtdIKsiN/I84REq4MbV6f
         ZuHA==
X-Gm-Message-State: AOAM532sCP+9XKp8eGr0yghShSbn591BlWU2cE9Ba5BPqOuJjGupBkhs
        HVrE7UMCox1CD3zUxX55K6jfCPXi06vXZ/llvC68GIw7
X-Google-Smtp-Source: ABdhPJyJ0RqaPrAnLPhG8IAkVYaMuSdrLUc0ZhLlso+NQ+N29OO5Ct2wudI/5Wei+530PO0W2GZbgRwzD0UxnqNEto0=
X-Received: by 2002:a25:b28d:: with SMTP id k13mr2515633ybj.162.1594178404356;
 Tue, 07 Jul 2020 20:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200701225352.9649-1-rcampbell@nvidia.com> <20200701225352.9649-4-rcampbell@nvidia.com>
In-Reply-To: <20200701225352.9649-4-rcampbell@nvidia.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 8 Jul 2020 13:19:53 +1000
Message-ID: <CACAvsv4fbO8JtAjRYKnUBTccsZO7xeR4T6bYirY3QDDr1F2jsA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v3 3/5] nouveau: fix mapping 2MB sysmem pages
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        ML nouveau <nouveau@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2 Jul 2020 at 08:54, Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> The nvif_object_ioctl() method NVIF_VMM_V0_PFNMAP wasn't correctly
> setting the hardware specific GPU page table entries for 2MB sized
> pages. Fix this by adding functions to set and clear PD0 GPU page
> table entries.
I can take this one in my tree now, it's fairly independent of the rest.

Ben.

>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  5 +-
>  .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 82 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> index 199f94e15c5f..19a6804e3989 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -1204,7 +1204,6 @@ nvkm_vmm_pfn_unmap(struct nvkm_vmm *vmm, u64 addr, u64 size)
>  /*TODO:
>   * - Avoid PT readback (for dma_unmap etc), this might end up being dealt
>   *   with inside HMM, which would be a lot nicer for us to deal with.
> - * - Multiple page sizes (particularly for huge page support).
>   * - Support for systems without a 4KiB page size.
>   */
>  int
> @@ -1220,8 +1219,8 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 addr, u64 size, u64 *pfn)
>         /* Only support mapping where the page size of the incoming page
>          * array matches a page size available for direct mapping.
>          */
> -       while (page->shift && page->shift != shift &&
> -              page->desc->func->pfn == NULL)
> +       while (page->shift && (page->shift != shift ||
> +              page->desc->func->pfn == NULL))
>                 page++;
>
>         if (!page->shift || !IS_ALIGNED(addr, 1ULL << shift) ||
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> index d86287565542..ed37fddd063f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
> @@ -258,12 +258,94 @@ gp100_vmm_pd0_unmap(struct nvkm_vmm *vmm,
>         VMM_FO128(pt, vmm, pdei * 0x10, 0ULL, 0ULL, pdes);
>  }
>
> +static void
> +gp100_vmm_pd0_pfn_unmap(struct nvkm_vmm *vmm,
> +                       struct nvkm_mmu_pt *pt, u32 ptei, u32 ptes)
> +{
> +       struct device *dev = vmm->mmu->subdev.device->dev;
> +       dma_addr_t addr;
> +
> +       nvkm_kmap(pt->memory);
> +       while (ptes--) {
> +               u32 datalo = nvkm_ro32(pt->memory, pt->base + ptei * 16 + 0);
> +               u32 datahi = nvkm_ro32(pt->memory, pt->base + ptei * 16 + 4);
> +               u64 data   = (u64)datahi << 32 | datalo;
> +
> +               if ((data & (3ULL << 1)) != 0) {
> +                       addr = (data >> 8) << 12;
> +                       dma_unmap_page(dev, addr, 1UL << 21, DMA_BIDIRECTIONAL);
> +               }
> +               ptei++;
> +       }
> +       nvkm_done(pt->memory);
> +}
> +
> +static bool
> +gp100_vmm_pd0_pfn_clear(struct nvkm_vmm *vmm,
> +                       struct nvkm_mmu_pt *pt, u32 ptei, u32 ptes)
> +{
> +       bool dma = false;
> +
> +       nvkm_kmap(pt->memory);
> +       while (ptes--) {
> +               u32 datalo = nvkm_ro32(pt->memory, pt->base + ptei * 16 + 0);
> +               u32 datahi = nvkm_ro32(pt->memory, pt->base + ptei * 16 + 4);
> +               u64 data   = (u64)datahi << 32 | datalo;
> +
> +               if ((data & BIT_ULL(0)) && (data & (3ULL << 1)) != 0) {
> +                       VMM_WO064(pt, vmm, ptei * 16, data & ~BIT_ULL(0));
> +                       dma = true;
> +               }
> +               ptei++;
> +       }
> +       nvkm_done(pt->memory);
> +       return dma;
> +}
> +
> +static void
> +gp100_vmm_pd0_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
> +                 u32 ptei, u32 ptes, struct nvkm_vmm_map *map)
> +{
> +       struct device *dev = vmm->mmu->subdev.device->dev;
> +       dma_addr_t addr;
> +
> +       nvkm_kmap(pt->memory);
> +       while (ptes--) {
> +               u64 data = 0;
> +
> +               if (!(*map->pfn & NVKM_VMM_PFN_W))
> +                       data |= BIT_ULL(6); /* RO. */
> +
> +               if (!(*map->pfn & NVKM_VMM_PFN_VRAM)) {
> +                       addr = *map->pfn >> NVKM_VMM_PFN_ADDR_SHIFT;
> +                       addr = dma_map_page(dev, pfn_to_page(addr), 0,
> +                                           1UL << 21, DMA_BIDIRECTIONAL);
> +                       if (!WARN_ON(dma_mapping_error(dev, addr))) {
> +                               data |= addr >> 4;
> +                               data |= 2ULL << 1; /* SYSTEM_COHERENT_MEMORY. */
> +                               data |= BIT_ULL(3); /* VOL. */
> +                               data |= BIT_ULL(0); /* VALID. */
> +                       }
> +               } else {
> +                       data |= (*map->pfn & NVKM_VMM_PFN_ADDR) >> 4;
> +                       data |= BIT_ULL(0); /* VALID. */
> +               }
> +
> +               VMM_WO064(pt, vmm, ptei++ * 16, data);
> +               map->pfn++;
> +       }
> +       nvkm_done(pt->memory);
> +}
> +
>  static const struct nvkm_vmm_desc_func
>  gp100_vmm_desc_pd0 = {
>         .unmap = gp100_vmm_pd0_unmap,
>         .sparse = gp100_vmm_pd0_sparse,
>         .pde = gp100_vmm_pd0_pde,
>         .mem = gp100_vmm_pd0_mem,
> +       .pfn = gp100_vmm_pd0_pfn,
> +       .pfn_clear = gp100_vmm_pd0_pfn_clear,
> +       .pfn_unmap = gp100_vmm_pd0_pfn_unmap,
>  };
>
>  static void
> --
> 2.20.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
