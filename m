Return-Path: <linux-kselftest+bounces-39547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB294B30370
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5AD5E55BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F602E975A;
	Thu, 21 Aug 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIxzo4UE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5D2E8B6C
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806833; cv=none; b=O9XHPUSWVyVJQioJwZGKVx745alHo4QuxzdZfc1jEKM6/MQhujH7mTnvM4KIuJuYleuc9BI0VV6OUHpQGKZ7p76rT5G/1ND9l3B1P9cmfby7OxMOl8KMk7vgOSw/q1/gDAHhZM8YQz7nPywcD2fC4cxrVgzXNc6do0nao053uCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806833; c=relaxed/simple;
	bh=1aX6aTG8s6ax1CtK3pZ1UQ/TXpBX5+Ze6lBjUUjUQPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAO2o2sK8V3zpLLQ4MLuJmi1opLyr+wVH/SAqdxpeKZYVI8vkmTjXdhRW5C7Yvpt4oiLrLHPvhVJcUz8wJ/LHgbrzDPl6qQ7Fvw2OUkVcd8GSmec0akaBC+3M9zAvFVcj3EVSoEpwxB5hT8deo7Cvri+cCDgxplVwwoa3y+T5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIxzo4UE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LLdMjSHtv+zm1bY5U2c0p8D/d+U3cemLYeHBKaj7voE=;
	b=NIxzo4UEjkUMNKT5bhBCkgjEd5jwPUdalQ4T3oqamAXQ3QiO6Z+cw2/uKVnf7PGMNdO346
	WVTyJEt9vH8c83nVPmhjQww+wGmRXZnr6KcnoYulRd0/fgUCenj6fxvdi35EAAPd7bMeCv
	4bU2bpdVx+QxpvSL26b5jN65ns1i1Gw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-asJNbWKIP8Gqe2TlOkV-uA-1; Thu, 21 Aug 2025 16:07:07 -0400
X-MC-Unique: asJNbWKIP8Gqe2TlOkV-uA-1
X-Mimecast-MFC-AGG-ID: asJNbWKIP8Gqe2TlOkV-uA_1755806827
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b51411839so818855e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806826; x=1756411626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLdMjSHtv+zm1bY5U2c0p8D/d+U3cemLYeHBKaj7voE=;
        b=VWz0XeOe00LI2eeUhyqNiyXIGGRnAyVFfrj5ZUsIC8an7v6syoogUwGiA9TZmGiK+K
         eI5aacmsS22tO4uyasU0W4CLSGWsZ7gsPK7ITdU5oCJo1ngV40pMgRI3YPC1G27fqhJ3
         3pe0mDFJwbhu1KiXpAGnExMnAA2zEqxQA8A21gzY6F+dF0EmQt3zApUkb+t9wUtWIoZg
         5cGSFpINy2pM4uU/AWyHX8znZgMa/lcGlyjfQzv3SfkmEek2y3M0aCV8OoD8mIx+DmEi
         K46JrVjtwesEbzbOmJl5xe3nSUWp90hGPH4oc7qi1nPYUkBjVvo7Bn7Iw45YOCXo4sc9
         kXrg==
X-Forwarded-Encrypted: i=1; AJvYcCVz5hCnysFvQX6ZWUNfRsGavWv2P/kJMsGtRh2mZrW1gpjJO0oQx/m5urjHHAte6PyTOCAiVF3XhOwLTiXu2ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErLMME3mvnhDvXS64WaRkC16w2M5R41QYlOplYAfuTtEAYeFH
	+EKBSPMVRRJ5EkaghcHdnzFwAfm1uQB/LYEMtMvlGFDo9Jlha6BOxt0YODmAatMaQclEeKw8Yh6
	qyhKh/6v+pHYjfwyPV5TC1t+jUg5ZqUZBljaBSTv9aZfloRTiY3qbuDn5aOKzloX7JAqN5Q==
X-Gm-Gg: ASbGncvcaybSOVLcoZmobljthBCuvROyscAtxzAHlJzQkIY4LjLvG/Qaq2GcyXtwbtI
	XQ68olh9785Izky++VsoJIo6C5dLqGAZvAh1bJCO0cp8YchiTC7ljFBobUdT78qskSeP4elD3La
	rZ3rNLYmiAPJq/1ZoD6+kwY3aCswOQqVAj5CDhaEV0NHgij4kBfIrWaZgbPs1dIinmanteBAQrE
	ZgIrWYCx85qibPjlw1dgF71EwzI2OtngMhb93NbVw7U1bSmPciRTb+cVEtB9BCaSEOWjoY7SJH4
	i5nBO3GHA2QM662EflZySfkEPv8dUt2YofXApgbay5IqbLxgG8JQtnYCjwxt7k8+1mjfty0ta6U
	iYdJh+aMdsMnWVQz89C64Eg==
X-Received: by 2002:a05:600c:4506:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-45b5179b6camr3190925e9.8.1755806826449;
        Thu, 21 Aug 2025 13:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7XEacdneicK9OezeDu7E6BzvwjamEpx7+RbUEh0t7qSo20kryXdXhBwYQdhu2/m95zw+e6A==
X-Received: by 2002:a05:600c:4506:b0:456:1bae:5470 with SMTP id 5b1f17b1804b1-45b5179b6camr3190665e9.8.1755806825859;
        Thu, 21 Aug 2025 13:07:05 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788df7sm12764142f8f.48.2025.08.21.13.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:05 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@axis.com,
	linux-scsi@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org,
	io-uring@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alex Dubov <oakad@yahoo.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brett Creeley <brett.creeley@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Gilbert <dgilbert@interlog.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lars Persson <lars.persson@axis.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH RFC 00/35] mm: remove nth_page()
Date: Thu, 21 Aug 2025 22:06:26 +0200
Message-ID: <20250821200701.1329277-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is based on mm-unstable and was cross-compiled heavily.

I should probably have already dropped the RFC label but I want to hear
first if I ignored some corner case (SG entries?) and I need to do
at least a bit more testing.

I will only CC non-MM folks on the cover letter and the respective patch
to not flood too many inboxes (the lists receive all patches).

---

As discussed recently with Linus, nth_page() is just nasty and we would
like to remove it.

To recap, the reason we currently need nth_page() within a folio is because
on some kernel configs (SPARSEMEM without SPARSEMEM_VMEMMAP), the
memmap is allocated per memory section.

While buddy allocations cannot cross memory section boundaries, hugetlb
and dax folios can.

So crossing a memory section means that "page++" could do the wrong thing.
Instead, nth_page() on these problematic configs always goes from
page->pfn, to the go from (++pfn)->page, which is rather nasty.

Likely, many people have no idea when nth_page() is required and when
it might be dropped.

We refer to such problematic PFN ranges and "non-contiguous pages".
If we only deal with "contiguous pages", there is not need for nth_page().

Besides that "obvious" folio case, we might end up using nth_page()
within CMA allocations (again, could span memory sections), and in
one corner case (kfence) when processing memblock allocations (again,
could span memory sections).

So let's handle all that, add sanity checks, and remove nth_page().

Patch #1 -> #5   : stop making SPARSEMEM_VMEMMAP user-selectable + cleanups
Patch #6 -> #12  : disallow folios to have non-contiguous pages
Patch #13 -> #20 : remove nth_page() usage within folios
Patch #21        : disallow CMA allocations of non-contiguous pages
Patch #22 -> #31 : sanity+check + remove nth_page() usage within SG entry
Patch #32        : sanity-check + remove nth_page() usage in
                   unpin_user_page_range_dirty_lock()
Patch #33        : remove nth_page() in kfence
Patch #34        : adjust stale comment regarding nth_page
Patch #35        : mm: remove nth_page()

A lot of this is inspired from the discussion at [1] between Linus, Jason
and me, so cudos to them.

[1] https://lore.kernel.org/all/CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com/T/#u

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@axis.com
Cc: linux-scsi@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: io-uring@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: kasan-dev@googlegroups.com
Cc: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-riscv@lists.infradead.org

David Hildenbrand (35):
  mm: stop making SPARSEMEM_VMEMMAP user-selectable
  arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
  s390/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
  x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
  wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu
    kernel config
  mm/page_alloc: reject unreasonable folio/compound page sizes in
    alloc_contig_range_noprof()
  mm/memremap: reject unreasonable folio/compound page sizes in
    memremap_pages()
  mm/hugetlb: check for unreasonable folio sizes when registering hstate
  mm/mm_init: make memmap_init_compound() look more like
    prep_compound_page()
  mm/hugetlb: cleanup hugetlb_folio_init_tail_vmemmap()
  mm: sanity-check maximum folio size in folio_set_order()
  mm: limit folio/compound page sizes in problematic kernel configs
  mm: simplify folio_page() and folio_page_idx()
  mm/mm/percpu-km: drop nth_page() usage within single allocation
  fs: hugetlbfs: remove nth_page() usage within folio in
    adjust_range_hwpoison()
  mm/pagewalk: drop nth_page() usage within folio in folio_walk_start()
  mm/gup: drop nth_page() usage within folio when recording subpages
  io_uring/zcrx: remove "struct io_copy_cache" and one nth_page() usage
  io_uring/zcrx: remove nth_page() usage within folio
  mips: mm: convert __flush_dcache_pages() to
    __flush_dcache_folio_pages()
  mm/cma: refuse handing out non-contiguous page ranges
  dma-remap: drop nth_page() in dma_common_contiguous_remap()
  scatterlist: disallow non-contigous page ranges in a single SG entry
  ata: libata-eh: drop nth_page() usage within SG entry
  drm/i915/gem: drop nth_page() usage within SG entry
  mspro_block: drop nth_page() usage within SG entry
  memstick: drop nth_page() usage within SG entry
  mmc: drop nth_page() usage within SG entry
  scsi: core: drop nth_page() usage within SG entry
  vfio/pci: drop nth_page() usage within SG entry
  crypto: remove nth_page() usage within SG entry
  mm/gup: drop nth_page() usage in unpin_user_page_range_dirty_lock()
  kfence: drop nth_page() usage
  block: update comment of "struct bio_vec" regarding nth_page()
  mm: remove nth_page()

 arch/arm64/Kconfig                            |  1 -
 arch/mips/include/asm/cacheflush.h            | 11 +++--
 arch/mips/mm/cache.c                          |  8 ++--
 arch/s390/Kconfig                             |  1 -
 arch/x86/Kconfig                              |  1 -
 crypto/ahash.c                                |  4 +-
 crypto/scompress.c                            |  8 ++--
 drivers/ata/libata-sff.c                      |  6 +--
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  2 +-
 drivers/memstick/core/mspro_block.c           |  3 +-
 drivers/memstick/host/jmb38x_ms.c             |  3 +-
 drivers/memstick/host/tifm_ms.c               |  3 +-
 drivers/mmc/host/tifm_sd.c                    |  4 +-
 drivers/mmc/host/usdhi6rol0.c                 |  4 +-
 drivers/scsi/scsi_lib.c                       |  3 +-
 drivers/scsi/sg.c                             |  3 +-
 drivers/vfio/pci/pds/lm.c                     |  3 +-
 drivers/vfio/pci/virtio/migrate.c             |  3 +-
 fs/hugetlbfs/inode.c                          | 25 ++++------
 include/crypto/scatterwalk.h                  |  4 +-
 include/linux/bvec.h                          |  7 +--
 include/linux/mm.h                            | 48 +++++++++++++++----
 include/linux/page-flags.h                    |  5 +-
 include/linux/scatterlist.h                   |  4 +-
 io_uring/zcrx.c                               | 34 ++++---------
 kernel/dma/remap.c                            |  2 +-
 mm/Kconfig                                    |  3 +-
 mm/cma.c                                      | 36 +++++++++-----
 mm/gup.c                                      | 13 +++--
 mm/hugetlb.c                                  | 23 ++++-----
 mm/internal.h                                 |  1 +
 mm/kfence/core.c                              | 17 ++++---
 mm/memremap.c                                 |  3 ++
 mm/mm_init.c                                  | 13 ++---
 mm/page_alloc.c                               |  5 +-
 mm/pagewalk.c                                 |  2 +-
 mm/percpu-km.c                                |  2 +-
 mm/util.c                                     | 33 +++++++++++++
 tools/testing/scatterlist/linux/mm.h          |  1 -
 .../selftests/wireguard/qemu/kernel.config    |  1 -
 40 files changed, 203 insertions(+), 150 deletions(-)


base-commit: c0e3b3f33ba7b767368de4afabaf7c1ddfdc3872
-- 
2.50.1


