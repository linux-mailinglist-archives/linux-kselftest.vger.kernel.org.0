Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A568650F77
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfFXPBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 11:01:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37964 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbfFXPBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 11:01:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so7021072plb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLg06i/VCl1+ARgBePt6UCtgCE6yMoeYz0XGu/hbFeo=;
        b=MwA/LDiusqfNWsTB2DaatzITy3M650ma8hf3fWZJJgZo0sU5+WHRov34/AgR5khfdn
         43QWHZ5AnOHm74CPfDOEecH6k3NeL2D42ht4vodc0QKm4kkProj+2T//kWp6iTgN3F0V
         SMoSonCHMQtZbalEg27bzapOmKXhEcFOVUU3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLg06i/VCl1+ARgBePt6UCtgCE6yMoeYz0XGu/hbFeo=;
        b=NkzQvPYnkVgcj3DysX/HNtdqPflo/Iza186DnFW/dstYA8e0C6Z4ievx/4vAjer2At
         0mhRRwucyg/vTVCcJiOHbohiG5RdeBl2oaQwluIBK+4PASbtBCczkfKq62o5bLJhom4N
         rVsBRrvYpX807xAdAr+6HJw5YwltIKHulkxBAwY3k2FlbLsvBN8zVcdrnRFgIUl+WsEA
         c3Leq3AfsiXfSXAuByg6zuKlUOMIajdj3ZHl6BCFEJQgTWEO0GKc6LjqsDvtBtCs+iBk
         7qDtHxs5QjBZNxOWWBfC1FfY2zxMjzOUQo1mjlq5gmaqJaJ/BSKlzVox/3v/eXAEICZf
         8mgw==
X-Gm-Message-State: APjAAAWoLuyma0y0+inWiykgDl70XZxnsH5JCHXdrcHdcFBj9rysycG0
        m/HC9qEgNfvVgn0LZ9gU5zAj2g==
X-Google-Smtp-Source: APXvYqxWnwPjr90pgAz811Ip1hR0DU+KY/u+1S7JOfCxDoc+41R5+q814qY7q3l7dWsEUazPv/NQog==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr71103307plr.12.1561388501191;
        Mon, 24 Jun 2019 08:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm10325517pjl.23.2019.06.24.08.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 08:01:40 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:01:39 -0700
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
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <201906240801.BE42EB3AA@keescook>
References: <cover.1561386715.git.andreyknvl@google.com>
 <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> only by done with untagged pointers.
> 
> Untag user pointers in this function.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
> index 355205a28544..13d9f917f249 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -378,6 +378,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
>  	 * again
>  	 */
>  	if (!ib_access_writable(access_flags)) {
> +		unsigned long untagged_start = untagged_addr(start);
>  		struct vm_area_struct *vma;
>  
>  		down_read(&current->mm->mmap_sem);
> @@ -386,9 +387,9 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
>  		 * cover the memory, but for now it requires a single vma to
>  		 * entirely cover the MR to support RO mappings.
>  		 */
> -		vma = find_vma(current->mm, start);
> -		if (vma && vma->vm_end >= start + length &&
> -		    vma->vm_start <= start) {
> +		vma = find_vma(current->mm, untagged_start);
> +		if (vma && vma->vm_end >= untagged_start + length &&
> +		    vma->vm_start <= untagged_start) {
>  			if (vma->vm_flags & VM_WRITE)
>  				access_flags |= IB_ACCESS_LOCAL_WRITE;
>  		} else {
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
