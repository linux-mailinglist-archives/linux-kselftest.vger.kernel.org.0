Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23B33576
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfFCQ4J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:56:09 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:49849 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbfFCQ4H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:07 -0400
Received: by mail-vk1-f201.google.com with SMTP id i138so6767067vke.16
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y8tRh8UuVncP1ncRA8ZfIPgOhX9+nAfsBu2vnbYNOEE=;
        b=eFK1jtlEFrS3m2V50O3J5bSuSe+f8SF2oOEJcYGOiFDh2Xi4MGaW9nDUncCGVcGUyN
         tYL5ptbIsLBKOxSfh5JEibNl8mgQflxa8qzQZCZGbKOMu+ue4btTZbmvk6Kxh+WcG+Wv
         fn/kF4y9wQfMzaBiS9+LkicOpt8tKnLL/K7iTnBUbTxgKs5dHlS/ncUSuv8GobYsG6Cu
         6qM+L38/9FABz5BxD3BPgItX9XL5QdXg0jsVIbHzcM5qVU0wJRygy73ep5mkhIvjeckb
         fTT0sIEfasP+T2Y6+uUP2P0imGCc2+QNF2QVC0kVT6BdFDtQ0zPTYlADXVtguKUh5EC4
         AB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y8tRh8UuVncP1ncRA8ZfIPgOhX9+nAfsBu2vnbYNOEE=;
        b=djCL69e397rW8HbG9tDjM7SYXFYifJUt7ee5KyY0+O6dFUbEYM3kJrnsOWs/+crYgD
         qZk3uG3naUvkoZ5xldxXFNrlHTYGq74AdDW16hv34158M/ZvoVyu9VBQuUnJD7oj//aO
         V8HI9IKTorsMQ89P2zHGRz6uM3Q5zwYSKVSCKQdEfLuOmbGDSuHJIK4YIXupcFNHeK8x
         AXAdIE8+xZIyEMkiND0AKWGq9LJE+Gu3WOq2ahFStUPxLdD4XJ9rO/ik/s2QNmizeJ5R
         WhXBzauivN3MeMK3guzDuTi1/0H91zpNawVCz4bb+Kdwc4B9tfgYw7cMWjA+SrBkTsLV
         OADQ==
X-Gm-Message-State: APjAAAWI/3nJXlVJcgMWSrVFW7FErnO84EZ5H2X/ddElhoCsBJTGCYs4
        Ld3XHpboWGBWksBenvCUasQYyyKxIuCzz/bY
X-Google-Smtp-Source: APXvYqzz/ntPC10OZ0frdLABrSNi7hvZ/ytx4Ex3aaENCq428cafLYJMM+5BmbKZZkSR6QrCbMGhJA3iBNJvNJC5
X-Received: by 2002:a9f:25c6:: with SMTP id 64mr157298uaf.36.1559580966349;
 Mon, 03 Jun 2019 09:56:06 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:15 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <31821f3538ddacb7e57e0248e86a3d28f9789d2f.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 13/16] media/v4l2-core, arm64: untag user pointers in videobuf_dma_contig_user_get
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
        Andrey Konovalov <andreyknvl@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

videobuf_dma_contig_user_get() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the pointers in this function.

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/media/v4l2-core/videobuf-dma-contig.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/media/v4l2-core/videobuf-dma-contig.c
index e1bf50df4c70..8a1ddd146b17 100644
--- a/drivers/media/v4l2-core/videobuf-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
@@ -160,6 +160,7 @@ static void videobuf_dma_contig_user_put(struct videobuf_dma_contig_memory *mem)
 static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
 					struct videobuf_buffer *vb)
 {
+	unsigned long untagged_baddr = untagged_addr(vb->baddr);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long prev_pfn, this_pfn;
@@ -167,22 +168,22 @@ static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
 	unsigned int offset;
 	int ret;
 
-	offset = vb->baddr & ~PAGE_MASK;
+	offset = untagged_baddr & ~PAGE_MASK;
 	mem->size = PAGE_ALIGN(vb->size + offset);
 	ret = -EINVAL;
 
 	down_read(&mm->mmap_sem);
 
-	vma = find_vma(mm, vb->baddr);
+	vma = find_vma(mm, untagged_baddr);
 	if (!vma)
 		goto out_up;
 
-	if ((vb->baddr + mem->size) > vma->vm_end)
+	if ((untagged_baddr + mem->size) > vma->vm_end)
 		goto out_up;
 
 	pages_done = 0;
 	prev_pfn = 0; /* kill warning */
-	user_address = vb->baddr;
+	user_address = untagged_baddr;
 
 	while (pages_done < (mem->size >> PAGE_SHIFT)) {
 		ret = follow_pfn(vma, user_address, &this_pfn);
-- 
2.22.0.rc1.311.g5d7573a151-goog

