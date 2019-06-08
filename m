Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0393939A9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfFHD7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:59:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43131 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbfFHD7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:59:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so2133894pgv.10
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJIAAqD1NAp4Th9vkRNxbBLJIPc3y8ChkLIZvf3dmAk=;
        b=U7O6NbXBNIeRlPVLj5xwiYB9yIq5HbXkmt1o7eZLIHcCi1sfFtD4pKc4GGOrbqMYRh
         sgIk+ERejfY1WzlSSBSK2Vn9ctskkWUfC7d9RXEYuV+TF3EleJl2nI9tZYJCJJbjZfXj
         ev4abqGBRmVAB5Xa6TnqWXyvladDJfFjes7a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJIAAqD1NAp4Th9vkRNxbBLJIPc3y8ChkLIZvf3dmAk=;
        b=kGzg9OdwW2C///uPB9wHqEOHsPtw4FJHtq2sY6wESv6t/DlFivVJhGTyARD0iX2SZL
         oSwBvEzGcoX21IumfEVkWwm1qo6n/j2opxVhRlOucocLCs3WNFjRtL17Ofm4Bp8pTLk6
         j1jEpumtLitlMuH3iJeeMQOAw6ahdORpgyusw1VSJ/Co9P2x9wIfnIIsGZtAd1z+n9Qq
         q23sYSjm4lHcbfgzx7lcY/sAzzrxAqoYldUM6xTWXk2xUHAfVe9B/kPMB7E703Rcqor2
         THP89IZabVTfd6+XvEywUmMudC1DKPrvk6eIZsz3qNYAh1tSl8yFscTNAsLs9DPVmYYa
         hdOg==
X-Gm-Message-State: APjAAAVU1Lzd+4Qoa9vL3zbssIYYJOjzSwggdtOpUL4vz3+qYinVy4We
        as9UTt+I06LvC/NzxUulRYw+zQ==
X-Google-Smtp-Source: APXvYqwFvS5ZtgK4hv3bppgp+xNWkWaUdmJ6Dck4NUo25EMo4bji/jhdzX5h+4T1rhnDZmDRvB93qA==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr8851590pjq.69.1559966359909;
        Fri, 07 Jun 2019 20:59:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o70sm4127428pfo.33.2019.06.07.20.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:59:19 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:59:18 -0700
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
Subject: Re: [PATCH v16 06/16] mm, arm64: untag user pointers in mm/gup.c
Message-ID: <201906072059.7D80BA0@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <e1f6d268135f683fd70c2af27e75f694d7ffaf48.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f6d268135f683fd70c2af27e75f694d7ffaf48.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:08PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> mm/gup.c provides a kernel interface that accepts user addresses and
> manipulates user pages directly (for example get_user_pages, that is used
> by the futex syscall). Since a user can provided tagged addresses, we need
> to handle this case.
> 
> Add untagging to gup.c functions that use user addresses for vma lookups.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..c37df3d455a2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -802,6 +802,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	if (!nr_pages)
>  		return 0;
>  
> +	start = untagged_addr(start);
> +
>  	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
>  
>  	/*
> @@ -964,6 +966,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	vm_fault_t ret, major = 0;
>  
> +	address = untagged_addr(address);
> +
>  	if (unlocked)
>  		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
>  
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
