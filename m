Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49476335A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFCQ5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:57:12 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41997 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfFCQ4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:13 -0400
Received: by mail-qk1-f202.google.com with SMTP id l16so993142qkk.9
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i5cRHHCicMsppSSBbFWeJPgqhQ8FMrYjuCKfr4hxLgs=;
        b=sT3L0ZTGkrRVM9BsAKw3Is1YEd5yvotnvZZfNxBe7skB1Imy3yNX3RzPcWZ3L4hBJj
         Ir4PWq35E8DDBUgoDYzLkuASMa2VdGiH7s1U8yAi9EYUyTsOvvYIL5k/dOIxx+s0hJjp
         ivARA7eJCU7WpCZIyl+ggUCauMPneV4kiO9mITdC3bmCRoqBY9+znI9pjppaD8UIqueE
         q8SkWjwj6UsZy3S43cNZjsMLUMGx3YCtYO4jYJeCvlUuA0j/KAAmJ8e05Wl5fyvRzmAY
         H4Wc9GjlHrhbudDD44rVO5eJTf6U73Fu89LC7maXdjap9rfTt5/4PxbL/ZJXa8oMOVpN
         Mbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i5cRHHCicMsppSSBbFWeJPgqhQ8FMrYjuCKfr4hxLgs=;
        b=rmhqZWTON+jpMUE6pa7024rCPuvMY9fhajpSWN3jKrlV/cjdGZ1g5iajtsTZX2vOjS
         u9yqKo0X1ORoSjHL0VF22N6DpnPGuGV5Q1HvFReAFQWyf+Pn0mYOvYK+xy9rzkWY2O2b
         PcWh6zddGNJsGiqNlN4CmScTpbvoanZsy05jO2w12KQWtfE4jMf8XGtw/wzVtQ5s03NB
         4jFIkMA4CDiURtcOpyD8w16ZskENr+UEQ2lDeONuZbRUOVLc26frXFuD0LpHAnfIgkP5
         EaZ5TPQGocEubHQzg4f3y3H5qOD6VP7M/+YCS+tmDGcYf52cbl8r4W/cApQxmHEjj56z
         i4cw==
X-Gm-Message-State: APjAAAWUB8ySnuxNk1iBoDrfiL3BMdELQdHH/wg60WpYx1t68mWJXrZe
        Gga2AknV29QN/CUHyW1go7xo3fAWi1yP20ny
X-Google-Smtp-Source: APXvYqxlndJ8+4ezg3WqxZgwPuj7croHV+8pOSI6UJilulRqZobP0HRc/RuNHVT76apRYIt7gunvINxeeY21hcHq
X-Received: by 2002:ac8:2817:: with SMTP id 23mr23534732qtq.174.1559580972876;
 Mon, 03 Jun 2019 09:56:12 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:17 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <c529e1eeea7700beff197c4456da6a882ce2efb7.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 15/16] vfio/type1, arm64: untag user pointers in vaddr_get_pfn
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

vaddr_get_pfn() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3ddc375e7063..528e39a1c2dd 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -384,6 +384,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+	vaddr = untagged_addr(vaddr);
+
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-- 
2.22.0.rc1.311.g5d7573a151-goog

