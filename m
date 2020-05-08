Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF81CB82D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEHTUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:20:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12187 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgEHTUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:20:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5b0750002>; Fri, 08 May 2020 12:18:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 12:20:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 12:20:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 19:20:23 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 8 May 2020 19:20:23 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eb5b0f60004>; Fri, 08 May 2020 12:20:23 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/6] nouveau: make nvkm_vmm_ctor() and nvkm_mmu_ptp_get() static
Date:   Fri, 8 May 2020 12:20:05 -0700
Message-ID: <20200508192009.15302-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588965493; bh=UimsBeIVOkWEdmHzrySmbrv0g1UsXEtKPJuhHnie4M0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=KKNQarbrKCL+A2uq6eUbu3sp1uxj3GGpuOL9lXpMyq52NNDdm48U3ifnP4/t/UorY
         1SiTX4guN6BwWo1esZDajBTGO07fr6PAvRi/8UEXk0TE1y+jq8lklt1+SrRTitxi74
         27WqawBqg/41WUPdk961/gGvPkUPvP40smrtp1TrWDmYNl2VnFkzVoxFZ54I+VnJam
         ViCsCAJx30m2bgrSN5gERkQ6utV3XLAcwwP3MnKR8wPYEL3/sv7fTBw8Y3IrlRyJ/o
         Pn5vzmJrhtoge7dEpylwIcZOXiTceBLBDQnYOT59JwKg6/z8rncY2K/4QYYw1GQYkd
         01OWiexrsF5rQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The functions nvkm_vmm_ctor() and nvkm_mmu_ptp_get() are not called outside
of the file defining them so make them static.
Also, remove a useless semicolon after a {} statement block.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h  | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c b/drivers/gpu/d=
rm/nouveau/nvkm/subdev/mmu/base.c
index ee11ccaf0563..de91e9a26172 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c
@@ -61,7 +61,7 @@ nvkm_mmu_ptp_put(struct nvkm_mmu *mmu, bool force, struct=
 nvkm_mmu_pt *pt)
 	kfree(pt);
 }
=20
-struct nvkm_mmu_pt *
+static struct nvkm_mmu_pt *
 nvkm_mmu_ptp_get(struct nvkm_mmu *mmu, u32 size, bool zero)
 {
 	struct nvkm_mmu_pt *pt;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.c
index 41640e0584ac..67b00dcef4b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -580,7 +580,7 @@ nvkm_vmm_iter(struct nvkm_vmm *vmm, const struct nvkm_v=
mm_page *page,
 				it.pte[it.lvl]++;
 			}
 		}
-	};
+	}
=20
 	nvkm_vmm_flush(&it);
 	return ~0ULL;
@@ -1030,7 +1030,7 @@ nvkm_vmm_ctor_managed(struct nvkm_vmm *vmm, u64 addr,=
 u64 size)
 	return 0;
 }
=20
-int
+static int
 nvkm_vmm_ctor(const struct nvkm_vmm_func *func, struct nvkm_mmu *mmu,
 	      u32 pd_header, bool managed, u64 addr, u64 size,
 	      struct lock_class_key *key, const char *name,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h b/drivers/gpu/dr=
m/nouveau/nvkm/subdev/mmu/vmm.h
index 5e55ecbd8005..fd722bdc4c78 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h
@@ -163,9 +163,6 @@ int nvkm_vmm_new_(const struct nvkm_vmm_func *, struct =
nvkm_mmu *,
 		  u32 pd_header, bool managed, u64 addr, u64 size,
 		  struct lock_class_key *, const char *name,
 		  struct nvkm_vmm **);
-int nvkm_vmm_ctor(const struct nvkm_vmm_func *, struct nvkm_mmu *,
-		  u32 pd_header, bool managed, u64 addr, u64 size,
-		  struct lock_class_key *, const char *name, struct nvkm_vmm *);
 struct nvkm_vma *nvkm_vmm_node_search(struct nvkm_vmm *, u64 addr);
 struct nvkm_vma *nvkm_vmm_node_split(struct nvkm_vmm *, struct nvkm_vma *,
 				     u64 addr, u64 size);
--=20
2.20.1

