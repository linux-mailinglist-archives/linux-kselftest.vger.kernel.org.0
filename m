Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5542489
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438520AbfFLLom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:44:42 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40207 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438519AbfFLLoP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:44:15 -0400
Received: by mail-yb1-f201.google.com with SMTP id u3so8872315ybu.7
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OMWTVS19S/O2L7wjAg8YO34JfVmTuzDlFYDWpvnlfdc=;
        b=l/pAL0pYNwxIjhI4A5Di3+u8zRy7KDPlydIoJClA3OuILFZkNAGW7KJJpakHJKu6oE
         BOdwx+v3Y6mB0EaDg1WhpBGkC44sbC2cWM9OPunZvHIIMbKjR7+B/dGr9AjLsLmz2Olt
         nLMYnF0Wzf15zXWsTdJBm9qmaTa4PXWly/FRd7uizPU6BFseaNjpN6LtFlJq58pOQv7T
         WsZKhldlre+UFCD7WiBxmS6BBO31lObcc7zusnLdA80L2jwrzKGvI3ypNGCThs2lIqG6
         VybQ3v2ZWx5KHhiRN49MNNAagP8G3S94nC+koOMwbLACD7/N8Wf3tprbj1wNC/YGyAaz
         DFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OMWTVS19S/O2L7wjAg8YO34JfVmTuzDlFYDWpvnlfdc=;
        b=lErIoEcmNA76UvTGhWXR8fobUMnFA5wvYgwgZndGePH0Ahgp4fgwJOQM5kvgnBmuTf
         ChG9n50GOaVHod8C9fX3l30g9sq3MNOJWVsDgplYvCvZ9/ni+B/1Bh7xX4T5D3bNDH7P
         KpoADcz3SBigTQNCN/XGxQo3cmEHiuFuYmrDXR5L42ExeSljvaQSt9aKPGZSgxOP6/yS
         PdxUhWf8gfRYwkIUZnvr6+b4ncvQ0Y1UZ36R2e6zdPZ5u6alg3L8Cdu9gn1zIUa1SwFI
         Cp14KbDInXiaEl8/I8JOMdtx2MbmcrvWZS1g5zsxSNoTJlpFddpMiHFzRQ3qgfDvabYj
         E7OA==
X-Gm-Message-State: APjAAAUOxOhzOMnK5Z2Peb6dPd1qYF6qObJMxvkCvqnLWZ2soTLyF/f8
        sbZTwfJVtMr7KLE4TzbmzhjdkEqqFnaB02sb
X-Google-Smtp-Source: APXvYqwTs0S91VLJ1vEb2xUG3SN6RjfUTygp4K8Hjte1QQ8AktyAJh0LJ+M6BJ5qwoi87JfKLCpvnOyNNEEmSEtd
X-Received: by 2002:a25:aab0:: with SMTP id t45mr38754945ybi.201.1560339854764;
 Wed, 12 Jun 2019 04:44:14 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:29 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <7fbcdbe16a2bd99e92eb4541248469738d89a122.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 12/15] media/v4l2-core, arm64: untag user pointers in videobuf_dma_contig_user_get
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

Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

