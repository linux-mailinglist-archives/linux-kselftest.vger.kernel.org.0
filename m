Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7680D51A03
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfFXRv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 13:51:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfFXRv3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 13:51:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25DB8360;
        Mon, 24 Jun 2019 10:51:28 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606C33F718;
        Mon, 24 Jun 2019 10:51:23 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:51:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v18 08/15] userfaultfd: untag user pointers
Message-ID: <20190624175120.GN29120@arrakis.emea.arm.com>
References: <cover.1561386715.git.andreyknvl@google.com>
 <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 24, 2019 at 04:32:53PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> userfaultfd code use provided user pointers for vma lookups, which can
> only by done with untagged pointers.
> 
> Untag user pointers in validate_range().
> 
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  fs/userfaultfd.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Same here, it needs an ack from Al Viro.

> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index ae0b8b5f69e6..c2be36a168ca 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
>  }
>  
>  static __always_inline int validate_range(struct mm_struct *mm,
> -					  __u64 start, __u64 len)
> +					  __u64 *start, __u64 len)
>  {
>  	__u64 task_size = mm->task_size;
>  
> -	if (start & ~PAGE_MASK)
> +	*start = untagged_addr(*start);
> +
> +	if (*start & ~PAGE_MASK)
>  		return -EINVAL;
>  	if (len & ~PAGE_MASK)
>  		return -EINVAL;
>  	if (!len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> +	if (*start < mmap_min_addr)
>  		return -EINVAL;
> -	if (start >= task_size)
> +	if (*start >= task_size)
>  		return -EINVAL;
> -	if (len > task_size - start)
> +	if (len > task_size - *start)
>  		return -EINVAL;
>  	return 0;
>  }
> @@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		goto out;
>  	}
>  
> -	ret = validate_range(mm, uffdio_register.range.start,
> +	ret = validate_range(mm, &uffdio_register.range.start,
>  			     uffdio_register.range.len);
>  	if (ret)
>  		goto out;
> @@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
>  		goto out;
>  
> -	ret = validate_range(mm, uffdio_unregister.start,
> +	ret = validate_range(mm, &uffdio_unregister.start,
>  			     uffdio_unregister.len);
>  	if (ret)
>  		goto out;
> @@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
>  	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
>  		goto out;
>  
> -	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
> +	ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
>  	if (ret)
>  		goto out;
>  
> @@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  			   sizeof(uffdio_copy)-sizeof(__s64)))
>  		goto out;
>  
> -	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
> +	ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
>  	if (ret)
>  		goto out;
>  	/*
> @@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
>  			   sizeof(uffdio_zeropage)-sizeof(__s64)))
>  		goto out;
>  
> -	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
> +	ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
>  			     uffdio_zeropage.range.len);
>  	if (ret)
>  		goto out;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
