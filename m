Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333421516E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEFQbx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:31:53 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:47399 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfEFQbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:51 -0400
Received: by mail-yw1-f74.google.com with SMTP id z130so26340812ywb.14
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qJJU2gbhvvSzaaRZNAk/AylUL7YQ1I9YBdVQ8VYA/h0=;
        b=smw+2+zeQRYDg9lMdhXKhP6q2UgWQk5tdiALYOGrpKFur5CJhfOg9OO/PZTfQT7ZwY
         RvP2Hk/sSL7ML8WOTNeWv38qmUNAe4g4KhC0ua28+5atrFm7K5fmvkLjk0Db/ljqag0b
         dQjecdgCCDsZyAajxBKxJc7LsxcMY95MEt9IiglDE0kwt30ExqYblax2XRbyRPQRXMO4
         E+sey04rspIj0vK4v2o8+jJjIqc7WmoTjK96Ljfvnn/wyfRgdPoxhrZ+nqZ5Pgf+9DsA
         QtQ6iTRFCgpCJVB7xCQGyTJqnI3tF0Os9MEQkOzATYUN++U4ys3fnY4AQGWE9mngxzPC
         elwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qJJU2gbhvvSzaaRZNAk/AylUL7YQ1I9YBdVQ8VYA/h0=;
        b=JznxW2R/obZB94uTihFvL943V+1Q73vei2NDlOQ6lLrshpAVd60w5RF3TWGkP0rRoD
         XwfAwPe8tDOFFxWYABpOLP4JBTIxTr0qhI1r+mNMzb4Uak1FYYU0Ui2vl/ME439or4aX
         aocouBwvgO5I8msLNhIOYncJwSbPJEulqzXRcr1EYmENepKS+0kyqVTFufqaKba8BHj/
         jod2MSJuNpZTIvkzGHji3Gj/ts4NTk0VfHuy9VpBX9eIBQYn5inbHRwc08sUtJPyh/lQ
         BhO+ot2725x/uO7MsTTSAjJE7rruyYe+9jz27t2KifXqomF+UCiaw5uDOOLiI26+B87U
         1lvQ==
X-Gm-Message-State: APjAAAVSyseRBTjOThWJk1AWw6tGwV+vGWnoESRbzGjByAr1Sh7jyhrA
        9s29NpRGoimq5EqJLmXMBHcGesCmJa0QYK8C
X-Google-Smtp-Source: APXvYqx1X9tJcqBzNMWoEfXSSulDx8NO+a1TdtkQwmCv7glkGcm++BXem7IIU8nDFZviDaBVQ7bW4qmRV4r3Auad
X-Received: by 2002:a25:2a17:: with SMTP id q23mr16755885ybq.195.1557160310462;
 Mon, 06 May 2019 09:31:50 -0700 (PDT)
Date:   Mon,  6 May 2019 18:31:00 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <b7999d13af54eb3ed8d7b0192397c7cde3df0b28.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 14/17] media/v4l2-core, arm64: untag user pointers in videobuf_dma_contig_user_get
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
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
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

videobuf_dma_contig_user_get() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the pointers in this function.

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
2.21.0.1020.gf2820cf01a-goog

