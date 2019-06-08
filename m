Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC639A59
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfFHDsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 23:48:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45720 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbfFHDsK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 23:48:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so1132907plb.12
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 20:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNlIE7RpVdU5f0iicQk2k5+1DUNsXJMHiELoWiOeeG4=;
        b=D3MmOWnYob5UGtglFoMh75eVVkGVzLzcVT66trF4Vmsjdvy86taKH6QFas2mfzRzwj
         M8+OanNKrPI4fOGoGPo9/Uo5q+LH1LQX0K1IVkP72ijXTjagsPaUUaKA337dIrVp0dDF
         lHdVQs6LUPfUrx+oo7yXpxf993QJ3yfDpOh+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNlIE7RpVdU5f0iicQk2k5+1DUNsXJMHiELoWiOeeG4=;
        b=nD2BB+TijBJr3jKpd8Q8tz9lqRonjnClRUycjuukpFpA3dCrLUr9rKsi0v70D7Ii+c
         sX/+PL3KxacDxu558FDMJLVhDyDuQ2pif0VBwK3h3PbNoKSpt5RaHjgUGSszp83z6h2E
         r4SOSlgDAZ+1CcIlfLp861F4kZM+Lo0mHt2W6LYjwtjiYUBkHK9HKXOjpsKQlJhoEa5q
         B//g7T8NqRAPyq+OHRwObdV0eZy2Rd8mRoAfIuDIAt7UBykFyw5n8a11HCSHJEcIkgNN
         ebX++2WyT0WWF4xBFB9RRDljG0s5tilVoJFgDCAJRNEuIOwT/xdL6CeW+PlN/0Fz7Fku
         zf6Q==
X-Gm-Message-State: APjAAAXd75rgddVrOKP8Ssly6w2A7YSqQC5MneOnUL6V6zuroJcesuAu
        5qUv/GXFKD9ygr6y1m45ec4SjA==
X-Google-Smtp-Source: APXvYqzUHOb4VtJencGcx41aqOHHoNwcDiffGcfqaDDdYTWrPV9XhElqMpS0fUjS81CjEO5luRHFeQ==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr34327398plz.195.1559965689632;
        Fri, 07 Jun 2019 20:48:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13sm3156889pjq.20.2019.06.07.20.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 20:48:08 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:48:07 -0700
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
Subject: Re: [PATCH v16 03/16] lib, arm64: untag user pointers in strn*_user
Message-ID: <201906072047.50371DBE2@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <14f17ef1902aa4f07a39f96879394e718a1f5dc1.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f17ef1902aa4f07a39f96879394e718a1f5dc1.1559580831.git.andreyknvl@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:05PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> strncpy_from_user and strnlen_user accept user addresses as arguments, and
> do not go through the same path as copy_from_user and others, so here we
> need to handle the case of tagged user addresses separately.
> 
> Untag user pointers passed to these functions.
> 
> Note, that this patch only temporarily untags the pointers to perform
> validity checks, but then uses them as is to perform user memory accesses.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/strncpy_from_user.c | 3 ++-
>  lib/strnlen_user.c      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 023ba9f3b99f..dccb95af6003 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -6,6 +6,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> +#include <linux/mm.h>
>  
>  #include <asm/byteorder.h>
>  #include <asm/word-at-a-time.h>
> @@ -108,7 +109,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
>  		return 0;
>  
>  	max_addr = user_addr_max();
> -	src_addr = (unsigned long)src;
> +	src_addr = (unsigned long)untagged_addr(src);
>  	if (likely(src_addr < max_addr)) {
>  		unsigned long max = max_addr - src_addr;
>  		long retval;
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index 7f2db3fe311f..28ff554a1be8 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -2,6 +2,7 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
> +#include <linux/mm.h>
>  
>  #include <asm/word-at-a-time.h>
>  
> @@ -109,7 +110,7 @@ long strnlen_user(const char __user *str, long count)
>  		return 0;
>  
>  	max_addr = user_addr_max();
> -	src_addr = (unsigned long)str;
> +	src_addr = (unsigned long)untagged_addr(str);
>  	if (likely(src_addr < max_addr)) {
>  		unsigned long max = max_addr - src_addr;
>  		long retval;
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
