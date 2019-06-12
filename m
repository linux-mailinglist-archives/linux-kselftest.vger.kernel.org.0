Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6350428EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439716AbfFLO1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 10:27:19 -0400
Received: from foss.arm.com ([217.140.110.172]:54060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439675AbfFLO1F (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1BAA2B;
        Wed, 12 Jun 2019 07:27:04 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DCE73F557;
        Wed, 12 Jun 2019 07:26:59 -0700 (PDT)
Subject: Re: [PATCH v17 01/15] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <9ed583c1a3acf014987e3aef12249506c1c69146.1560339705.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <52e93b24-3302-e890-5799-6502042ea5c9@arm.com>
Date:   Wed, 12 Jun 2019 15:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9ed583c1a3acf014987e3aef12249506c1c69146.1560339705.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/06/2019 12:43, Andrey Konovalov wrote:
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
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/include/asm/uaccess.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e5d5f31c6d36..df729afca0ba 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -73,6 +73,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>  	unsigned long ret, limit = current_thread_info()->addr_limit;
>  
> +	addr = untagged_addr(addr);
> +
>  	__chk_user_ptr(addr);
>  	asm volatile(
>  	// A + B <= C + 1 for all A,B,C, in four easy steps:
> @@ -226,7 +228,8 @@ static inline void uaccess_enable_not_uao(void)
>  
>  /*
>   * Sanitise a uaccess pointer such that it becomes NULL if above the
> - * current addr_limit.
> + * current addr_limit. In case the pointer is tagged (has the top byte set),
> + * untag the pointer before checking.
>   */
>  #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
>  static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
> @@ -234,10 +237,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
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
> 

-- 
Regards,
Vincenzo
