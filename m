Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A448139A7F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfFHDws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:52:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41913 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfFHDwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:52:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so1712542pff.8
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FvOvhN7lAMb05Jgucbn4i/kkfk6C+xm00bozwGUiDHE=;
        b=jSdD6RhFfZkeqgS8TcayMIER7Pkkx++KxJ0VlFLn9BvHk82PjgIJ2PrdItWwSzYW05
         NLhWR71M5RDwErf/bBmmALg5hWrf7JykHz8MqC0HoRPvtnrf7wJZvYnVmInDaDa0hprb
         7Wa5xVFo7VF+cw+RSx/ka7MEiF5SaHkm3s0FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvOvhN7lAMb05Jgucbn4i/kkfk6C+xm00bozwGUiDHE=;
        b=IzgXJYbu8oeUVeQ1hYmS77d/Kz5onev6m7QX91JHnfTm50yWPXHuhPX8zz1gZkNhh4
         wmkJZjrPkH7b5+L3GPP1+7oXH4wtYQpXBHtV+lk7zKX6s9tW344t2ycwPIdOhAVIJx8g
         M8UNy8sZMFEk0HM1FHcFMGxaIQTZVoVWE2V09RA54YkJ7P/AG+x3bmq20507xCU0m83T
         nH2j7nh5EgthAynI499pCcB6Vt00DV59mWySQZjmVJrygp194+nhI4jv5KbaVl+mQUgY
         PI9hzLfZhXcaL0ROCwq0WEaYfeqF1wXmOUsYBkpm2oazJJMHsg8V6A1B3h2KDjirE8VW
         SbHA==
X-Gm-Message-State: APjAAAUMSSCmDipg8a+M82Ny1B8kA0lvOsrPEbw/RL4s9c7FFwqTpkzQ
        MEtHtw25w74BFypNqC1PVL1Q1g==
X-Google-Smtp-Source: APXvYqwjIf2RUpKbV2HVLPuystSV0iOPs0w3Y10dXMrzubhjEtN6FPReOOA3bdEKg814UJFukvJHYg==
X-Received: by 2002:a17:90a:37c8:: with SMTP id v66mr9429258pjb.33.1559965966947;
        Fri, 07 Jun 2019 20:52:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm3510268pgj.67.2019.06.07.20.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:52:46 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:52:45 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v16 13/16] media/v4l2-core, arm64: untag user pointers in
 videobuf_dma_contig_user_get
Message-ID: <201906072052.077135B@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <31821f3538ddacb7e57e0248e86a3d28f9789d2f.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31821f3538ddacb7e57e0248e86a3d28f9789d2f.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:15PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> videobuf_dma_contig_user_get() uses provided user pointers for vma
> lookups, which can only by done with untagged pointers.
> 
> Untag the pointers in this function.
> 
> Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
