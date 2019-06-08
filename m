Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3339A6F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfFHDvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:51:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37954 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfFHDvk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:51:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so2137865pgl.5
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3wKfqS97rJvrbhUUDlvq7gOlHPn2Fxrd7rOcfg+ujIw=;
        b=RYl1PwRkMzex6A4O7SLxvvwiq5dij7m4eHDLUNE4a3aGBYLeVjbDL8gLqao1EoQT+p
         YQb1mF9o9UcoV8td3+9AP7z+CkGq6mDaNnYR3pzaWwp8gUl1cHoE4YNqEbgWKNWvGAFB
         0KAoZe50aGSCoeHmlFMZ5SpxFp6+d2TadDVto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wKfqS97rJvrbhUUDlvq7gOlHPn2Fxrd7rOcfg+ujIw=;
        b=arXuXWtcny8657+bNq56zFOMupQweut2d/LSQoi8k6rsfw6D8R/BCj5qRZ0v37MeJq
         l8pzfEDqNtBDRNNjx7veT0L7L/jRNIRE4OCvj8R6Zex1oxJDOIL21HK8cjqX4GN2/0G1
         Gk2vy4eK75a71bvW91AqzKs4KRqtkZHM0cmwP7cJy3UthGRHDonfPpsHMesiMt+wBK4/
         f2a/ap/1VFBSmsH+1ilpyQ2oPW8P1NE4hd1aupTIilPdyi8GaF+NB5nuo0vCwbhCSUjS
         jodJPWGOof4tx7NaDtVLP6QPnvYqGivC/Wzt8e/ShcgC/OZRy2mDt2wHDaS++lxyWmkO
         e57Q==
X-Gm-Message-State: APjAAAVvvhYPuVu5tBi8VLTr0EjmbZD62Es0Yh8F3lGQsRT2NNFDUDDQ
        Ho2FwbobDvcn1xAM+fho/XMeyQ==
X-Google-Smtp-Source: APXvYqw907PVDblcTVkonPdzATNJGir/Lb4Vx1Ol6psoQ6Dh4wHkfs9go3mE5W0bvdvS6vG2+lgMCw==
X-Received: by 2002:a63:161b:: with SMTP id w27mr5796313pgl.338.1559965870042;
        Fri, 07 Jun 2019 20:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm3563052pgi.80.2019.06.07.20.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:51:09 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:51:08 -0700
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
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <201906072051.3047B3DC56@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> copy_from_user (and a few other similar functions) are used to copy data
> from user memory into the kernel memory or vice versa. Since a user can
> provided a tagged pointer to one of the syscalls that use copy_from_user,
> we need to correctly handle such pointers.
> 
> Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
> before performing access validity checks.
> 
> Note, that this patch only temporarily untags the pointers to perform the
> checks, but then passes them as is into the kernel internals.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/include/asm/uaccess.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e5d5f31c6d36..9164ecb5feca 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  	return ret;
>  }
>  
> -#define access_ok(addr, size)	__range_ok(addr, size)
> +#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
>  #define user_addr_max			get_fs
>  
>  #define _ASM_EXTABLE(from, to)						\
> @@ -226,7 +226,8 @@ static inline void uaccess_enable_not_uao(void)
>  
>  /*
>   * Sanitise a uaccess pointer such that it becomes NULL if above the
> - * current addr_limit.
> + * current addr_limit. In case the pointer is tagged (has the top byte set),
> + * untag the pointer before checking.
>   */
>  #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
>  static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
> @@ -234,10 +235,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>  	void __user *safe_ptr;
>  
>  	asm volatile(
> -	"	bics	xzr, %1, %2\n"
> +	"	bics	xzr, %3, %2\n"
>  	"	csel	%0, %1, xzr, eq\n"
>  	: "=&r" (safe_ptr)
> -	: "r" (ptr), "r" (current_thread_info()->addr_limit)
> +	: "r" (ptr), "r" (current_thread_info()->addr_limit),
> +	  "r" (untagged_addr(ptr))
>  	: "cc");
>  
>  	csdb();
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
