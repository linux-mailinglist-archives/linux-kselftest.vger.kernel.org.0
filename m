Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B539A99
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfFHD6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:58:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36229 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbfFHD6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:58:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so2239777pfm.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l14jgAawlsDS1VZ8WGmfB4MOY8oLSSKNbX7PpDlwP4w=;
        b=C5Gjab6oABNd7uWOUXVxMun2EBOiIN1zQFBFmz4oVz6alLd7w4ZDoA104BjgrPqBY8
         M11UcHeF2K3I4znphl64bBg5eiZ8uh03AO1nktwVISAdyYWU8VZro1t6U3J4ibUtkAgv
         yam4Xd5rREh0IexVfq4tELDc0YZWvN5ZcS9CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l14jgAawlsDS1VZ8WGmfB4MOY8oLSSKNbX7PpDlwP4w=;
        b=Lv5hff7SuMrFpU2j7DFxBSYueo82YlPJ+hLulnf+pbsvNMW8nI5SRgVw6Q12Y0yxVs
         CefhKHuVXKatv3uynG4XiFKmiLSeUtYthwXsy30WuDeHCUg2THiDdztIStKTBm6tAjvw
         zX1bZsS0076Cg2rNL+4GdNgrFMvvDPGW9vOOv2xp/287aFAlb9BnHNCI+tTTEMWoaiRN
         ECKOl07Xaukn4mCzQkexNC27h6lDkKgClBfES2Du/F0GB5sZJkT1oimIu2W9uPr0EgNR
         wYjeCHf8q8upYAURsqzrUBllxIUoQBvTpZe/oXTc6djJbkXadaaB7zyWasLqp4U7rwI8
         oTMQ==
X-Gm-Message-State: APjAAAWTqesLR3oMp0mu2Tiw5z4kYs2w22zyuKsNuu/CMjXroJPnDNb9
        mx6vk8paDRdb3DTbu4NQ3nw4bg==
X-Google-Smtp-Source: APXvYqxfp4HEsqQlOvNH04bl9SHArYk4hyQYoSWfdJS+DhwTyJyuL+IfwdxORVSQ19uSVN9pTMHd5w==
X-Received: by 2002:a63:1657:: with SMTP id 23mr5550367pgw.98.1559966287061;
        Fri, 07 Jun 2019 20:58:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l2sm246111pgs.33.2019.06.07.20.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:58:06 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:58:05 -0700
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 15/16] vfio/type1, arm64: untag user pointers in
 vaddr_get_pfn
Message-ID: <201906072058.BB57EFA@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <c529e1eeea7700beff197c4456da6a882ce2efb7.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c529e1eeea7700beff197c4456da6a882ce2efb7.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:17PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> vaddr_get_pfn() uses provided user pointers for vma lookups, which can
> only by done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/vfio/vfio_iommu_type1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3ddc375e7063..528e39a1c2dd 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -384,6 +384,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  
>  	down_read(&mm->mmap_sem);
>  
> +	vaddr = untagged_addr(vaddr);
> +
>  	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
>  
>  	if (vma && vma->vm_flags & VM_PFNMAP) {
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
