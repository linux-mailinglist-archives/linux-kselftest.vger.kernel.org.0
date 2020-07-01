Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7048211663
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jul 2020 00:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGAWy3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jul 2020 18:54:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19513 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGAWyO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jul 2020 18:54:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efd13e30000>; Wed, 01 Jul 2020 15:53:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 15:54:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 15:54:14 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 22:54:05 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 1 Jul 2020 22:54:05 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efd140c0008>; Wed, 01 Jul 2020 15:54:05 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 3/5] nouveau: fix mapping 2MB sysmem pages
Date:   Wed, 1 Jul 2020 15:53:50 -0700
Message-ID: <20200701225352.9649-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701225352.9649-1-rcampbell@nvidia.com>
References: <20200701225352.9649-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593644003; bh=LJGpDBN6OLESv1BK8GJcMMzgaimKKBD7JI7EOfFUHn4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=DjjW30v6+Cfy6bZJwRzn6y5hmjWqM49qlwQHrTkQrUPuvuiOLetOQUCY7U0j8/urh
         nt+Z80p6IZGt7VC8tHXR1vJZKl/aB5O/jSTGSuu9ov+eo4KeWqGhWNpj+Lws1qIjbF
         TI3AelyG54HMZxvT+bVo6jwwx2EliKrnwqwj7zPgry7tU3wVH7TKl2s8RDvkSLC1BS
         xo6LbZrVkrFmsXCoXX4HGfC1IrsTK81hV2vomfaeLuNEzzf9UvIwuaoEllgGowzRAZ
         Bnzq0HEu/7VtHC90/QE5/OBdQB6rWSEIEOM/3ytIwXoPoYpoUAgyoApHh1dnGavQrv
         0PsJwxJDp+j9Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The nvif_object_ioctl() method NVIF_VMM_V0_PFNMAP wasn't correctly
setting the hardware specific GPU page table entries for 2MB sized
pages. Fix this by adding functions to set and clear PD0 GPU page
table entries.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  5 +-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    | 82 +++++++++++++++++++
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index 199f94e15c5f..19a6804e3989 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1204,7 +1204,6 @@ nvkm_vmm_pfn_unmap(struct nvkm_vmm *vmm, u64 addr, u6=
4 size)
 /*TODO:
  * - Avoid PT readback (for dma_unmap etc), this might end up being dealt
  *   with inside HMM, which would be a lot nicer for us to deal with.
- * - Multiple page sizes (particularly for huge page support).
  * - Support for systems without a 4KiB page size.
  */
 int
@@ -1220,8 +1219,8 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u64 =
addr, u64 size, u64 *pfn)
 	/* Only support mapping where the page size of the incoming page
 	 * array matches a page size available for direct mapping.
 	 */
-	while (page->shift && page->shift !=3D shift &&
-	       page->desc->func->pfn =3D=3D NULL)
+	while (page->shift && (page->shift !=3D shift ||
+	       page->desc->func->pfn =3D=3D NULL))
 		page++;
=20
 	if (!page->shift || !IS_ALIGNED(addr, 1ULL << shift) ||
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index d86287565542..ed37fddd063f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -258,12 +258,94 @@ gp100_vmm_pd0_unmap(struct nvkm_vmm *vmm,
 	VMM_FO128(pt, vmm, pdei * 0x10, 0ULL, 0ULL, pdes);
 }
=20
+static void
+gp100_vmm_pd0_pfn_unmap(struct nvkm_vmm *vmm,
+			struct nvkm_mmu_pt *pt, u32 ptei, u32 ptes)
+{
+	struct device *dev =3D vmm->mmu->subdev.device->dev;
+	dma_addr_t addr;
+
+	nvkm_kmap(pt->memory);
+	while (ptes--) {
+		u32 datalo =3D nvkm_ro32(pt->memory, pt->base + ptei * 16 + 0);
+		u32 datahi =3D nvkm_ro32(pt->memory, pt->base + ptei * 16 + 4);
+		u64 data   =3D (u64)datahi << 32 | datalo;
+
+		if ((data & (3ULL << 1)) !=3D 0) {
+			addr =3D (data >> 8) << 12;
+			dma_unmap_page(dev, addr, 1UL << 21, DMA_BIDIRECTIONAL);
+		}
+		ptei++;
+	}
+	nvkm_done(pt->memory);
+}
+
+static bool
+gp100_vmm_pd0_pfn_clear(struct nvkm_vmm *vmm,
+			struct nvkm_mmu_pt *pt, u32 ptei, u32 ptes)
+{
+	bool dma =3D false;
+
+	nvkm_kmap(pt->memory);
+	while (ptes--) {
+		u32 datalo =3D nvkm_ro32(pt->memory, pt->base + ptei * 16 + 0);
+		u32 datahi =3D nvkm_ro32(pt->memory, pt->base + ptei * 16 + 4);
+		u64 data   =3D (u64)datahi << 32 | datalo;
+
+		if ((data & BIT_ULL(0)) && (data & (3ULL << 1)) !=3D 0) {
+			VMM_WO064(pt, vmm, ptei * 16, data & ~BIT_ULL(0));
+			dma =3D true;
+		}
+		ptei++;
+	}
+	nvkm_done(pt->memory);
+	return dma;
+}
+
+static void
+gp100_vmm_pd0_pfn(struct nvkm_vmm *vmm, struct nvkm_mmu_pt *pt,
+		  u32 ptei, u32 ptes, struct nvkm_vmm_map *map)
+{
+	struct device *dev =3D vmm->mmu->subdev.device->dev;
+	dma_addr_t addr;
+
+	nvkm_kmap(pt->memory);
+	while (ptes--) {
+		u64 data =3D 0;
+
+		if (!(*map->pfn & NVKM_VMM_PFN_W))
+			data |=3D BIT_ULL(6); /* RO. */
+
+		if (!(*map->pfn & NVKM_VMM_PFN_VRAM)) {
+			addr =3D *map->pfn >> NVKM_VMM_PFN_ADDR_SHIFT;
+			addr =3D dma_map_page(dev, pfn_to_page(addr), 0,
+					    1UL << 21, DMA_BIDIRECTIONAL);
+			if (!WARN_ON(dma_mapping_error(dev, addr))) {
+				data |=3D addr >> 4;
+				data |=3D 2ULL << 1; /* SYSTEM_COHERENT_MEMORY. */
+				data |=3D BIT_ULL(3); /* VOL. */
+				data |=3D BIT_ULL(0); /* VALID. */
+			}
+		} else {
+			data |=3D (*map->pfn & NVKM_VMM_PFN_ADDR) >> 4;
+			data |=3D BIT_ULL(0); /* VALID. */
+		}
+
+		VMM_WO064(pt, vmm, ptei++ * 16, data);
+		map->pfn++;
+	}
+	nvkm_done(pt->memory);
+}
+
 static const struct nvkm_vmm_desc_func
 gp100_vmm_desc_pd0 =3D {
 	.unmap =3D gp100_vmm_pd0_unmap,
 	.sparse =3D gp100_vmm_pd0_sparse,
 	.pde =3D gp100_vmm_pd0_pde,
 	.mem =3D gp100_vmm_pd0_mem,
+	.pfn =3D gp100_vmm_pd0_pfn,
+	.pfn_clear =3D gp100_vmm_pd0_pfn_clear,
+	.pfn_unmap =3D gp100_vmm_pd0_pfn_unmap,
 };
=20
 static void
--=20
2.20.1

