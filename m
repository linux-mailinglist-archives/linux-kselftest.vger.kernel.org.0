Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C560A298A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391439AbfEXNOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 09:14:05 -0400
Received: from casper.infradead.org ([85.118.1.10]:53982 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391560AbfEXNOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 09:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/n51XGtaWTFL2kzn79WHLkkiSbCnRxm63xReP9D+Qhg=; b=bUkJxWW27UUn0amoOcX30OMJrj
        ZKVRSd1fLa7wKAL02nzw4IuOiQA4rzgr054ftsu9MviuEbu9mlGcvkuzEzVnirDZFWPfHjMMLLRk3
        ZsW9iClnPD6BeArzI/irNnfgAKRVNaTgvodZ4TtoBZwoHm+HpL855LvNq4JvaGdw7aEGxArIj4/ar
        bjQ2iBjNGlyPTpQSCWDE80zIQI9EXYMUp8RizSkmI+AmxIKaaD96lVlDCETopHnXFcxZVFNsAuFYn
        eLi0l7CIdF+p1i1kh/+U5yW0qGVeRM/1NgoUENimwmZJ/qxCwebQt5wRW4slq4faCCWf2/ok2eNHJ
        OcM7Zp+w==;
Received: from 177.97.63.247.dynamic.adsl.gvt.net.br ([177.97.63.247] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUA1G-0007UW-C4; Fri, 24 May 2019 13:13:58 +0000
Date:   Fri, 24 May 2019 10:13:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 14/17] media/v4l2-core, arm64: untag user pointers
 in videobuf_dma_contig_user_get
Message-ID: <20190524101345.67c425fa@coco.lan>
In-Reply-To: <b7999d13af54eb3ed8d7b0192397c7cde3df0b28.1557160186.git.andreyknvl@google.com>
References: <cover.1557160186.git.andreyknvl@google.com>
        <b7999d13af54eb3ed8d7b0192397c7cde3df0b28.1557160186.git.andreyknvl@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon,  6 May 2019 18:31:00 +0200
Andrey Konovalov <andreyknvl@google.com> escreveu:

> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> videobuf_dma_contig_user_get() uses provided user pointers for vma
> lookups, which can only by done with untagged pointers.
> 
> Untag the pointers in this function.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/media/v4l2-core/videobuf-dma-contig.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/media/v4l2-core/videobuf-dma-contig.c
> index e1bf50df4c70..8a1ddd146b17 100644
> --- a/drivers/media/v4l2-core/videobuf-dma-contig.c
> +++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
> @@ -160,6 +160,7 @@ static void videobuf_dma_contig_user_put(struct videobuf_dma_contig_memory *mem)
>  static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
>  					struct videobuf_buffer *vb)
>  {
> +	unsigned long untagged_baddr = untagged_addr(vb->baddr);
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long prev_pfn, this_pfn;
> @@ -167,22 +168,22 @@ static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
>  	unsigned int offset;
>  	int ret;
>  
> -	offset = vb->baddr & ~PAGE_MASK;
> +	offset = untagged_baddr & ~PAGE_MASK;
>  	mem->size = PAGE_ALIGN(vb->size + offset);
>  	ret = -EINVAL;
>  
>  	down_read(&mm->mmap_sem);
>  
> -	vma = find_vma(mm, vb->baddr);
> +	vma = find_vma(mm, untagged_baddr);
>  	if (!vma)
>  		goto out_up;
>  
> -	if ((vb->baddr + mem->size) > vma->vm_end)
> +	if ((untagged_baddr + mem->size) > vma->vm_end)
>  		goto out_up;
>  
>  	pages_done = 0;
>  	prev_pfn = 0; /* kill warning */
> -	user_address = vb->baddr;
> +	user_address = untagged_baddr;
>  
>  	while (pages_done < (mem->size >> PAGE_SHIFT)) {
>  		ret = follow_pfn(vma, user_address, &this_pfn);



Thanks,
Mauro
