Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273867D963
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 00:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAZXGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 18:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjAZXGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 18:06:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BF71647
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 15:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674774328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G80kkE2v/2t8LugwPN0qlzuOddCJjg+Ah5mVEUF3+sk=;
        b=X+gC5xUbGHKIsuSxEyX6B9x9Ob+RL+cttK7ZEzdt7BuKRJ8xq692g45gSRYz0JY6NkR2I7
        2ChMgWy8qw+L+lB0LUr0RWedAg+wmDT+feIOEYS15INUb0xWj2hiOeYMfSEND75mymuZDM
        ncjwmH9Rsl0mBm/pqJPpuSlxVvgphlw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-J91xnHsCOzWDK8o_m8dHkQ-1; Thu, 26 Jan 2023 18:05:27 -0500
X-MC-Unique: J91xnHsCOzWDK8o_m8dHkQ-1
Received: by mail-qk1-f199.google.com with SMTP id j11-20020a05620a410b00b007066f45a99aso2013987qko.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 15:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G80kkE2v/2t8LugwPN0qlzuOddCJjg+Ah5mVEUF3+sk=;
        b=mKuywxlNO6prhNcjhX9V/0jGiBHtKp8/9n7WtYyjtuyYvP/PKDJ54779hQ+18N0Vrm
         UtJigOrSb3oRbsRXWEfGGF1LSA+a+F33m46fol1YCwRf46k0xGjvUQpvB/z+EafCffeG
         RpVXnmSQHYg7Cdl21QXgfc5R1wtqJeXUvr65iIOjV2pvsrna6X8KjzVdxvgCTgtdQkWM
         XSk+29IwG0Dz/c/2jofQC8rr3Pe0T1Hjztf6mc9mibWwZEDVwfAtUgF97084+HMp09dY
         XlttGWRTxqF8qanpkNn3T+DD8IlvA1/56ocjNfAIXLtqNknCu+JsY7SU6oSbZdHbvAY+
         VNiQ==
X-Gm-Message-State: AO0yUKV3f8SXJEHNGf4qd+8brxUB9/bSasJJJ3qGduf923ZW8T0AGUm1
        nzJV9067Ze33Cl7EhIwfATmllUdJaADUCp8wxPWGAaUQkWj99FgntiqKyq0O1Hb4mn9pTj3S2gl
        pjAQr86D8egkljLLieh0uX9LsQsFn
X-Received: by 2002:a05:622a:1c5:b0:3b8:73c:15f6 with SMTP id t5-20020a05622a01c500b003b8073c15f6mr11374349qtw.11.1674774326354;
        Thu, 26 Jan 2023 15:05:26 -0800 (PST)
X-Google-Smtp-Source: AK7set9onta2cNDlVgcGkRiwDi871FevIHRkBeCDiEydwiYl3vguAC/yAo67CKDw3uPKqMKsLocxJw==
X-Received: by 2002:a05:622a:1c5:b0:3b8:73c:15f6 with SMTP id t5-20020a05622a01c500b003b8073c15f6mr11374288qtw.11.1674774326028;
        Thu, 26 Jan 2023 15:05:26 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id k8-20020ac85fc8000000b003b81188b617sm1577994qta.9.2023.01.26.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 15:05:25 -0800 (PST)
Date:   Thu, 26 Jan 2023 18:05:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Message-ID: <Y9MHM+RVzvigcTTk@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-2-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 01:43:20PM +0500, Muhammad Usama Anjum wrote:
> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
> faults on its own. It can be used to track that which pages have been
> written-to from the time the pages were write-protected. It is very
> efficient way to track the changes as uffd is by nature pte/pmd based.
> 
> UFFD synchronous WP sends the page faults to the userspace where the
> pages which have been written-to can be tracked. But it is not efficient.
> This is why this asynchronous version is being added. After setting the
> WP Async, the pages which have been written to can be found in the pagemap
> file or information can be obtained from the PAGEMAP_IOCTL.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v7:
> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
> - Handle automatic page fault resolution in better way (thanks to Peter)
> ---
>  fs/userfaultfd.c                 | 11 +++++++++++
>  include/linux/userfaultfd_k.h    |  6 ++++++
>  include/uapi/linux/userfaultfd.h |  8 +++++++-
>  mm/memory.c                      | 29 +++++++++++++++++++++++++++--
>  4 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 15a5bf765d43..b82af02092ce 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1867,6 +1867,10 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  	mode_wp = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_WP;
>  	mode_dontwake = uffdio_wp.mode & UFFDIO_WRITEPROTECT_MODE_DONTWAKE;
>  
> +	/* Write protection cannot be disabled in case of aync WP */

s/aync/async/

A slight reworded version:

        /* Unprotection is not supported if in async WP mode */

> +	if (!mode_wp && (ctx->features & UFFD_FEATURE_WP_ASYNC))
> +		return -EINVAL;
> +
>  	if (mode_wp && mode_dontwake)
>  		return -EINVAL;
>  
> @@ -1950,6 +1954,13 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  	return ret;
>  }
>  
> +int userfaultfd_wp_async(struct vm_area_struct *vma)
> +{
> +	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
> +
> +	return (ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC));
> +}
> +
>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>  {
>  	/*
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 9df0b9a762cc..5db51fccae1d 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
>  				  unsigned long end, struct list_head *uf);
>  extern void userfaultfd_unmap_complete(struct mm_struct *mm,
>  				       struct list_head *uf);
> +extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>  
>  #else /* CONFIG_USERFAULTFD */
>  
> @@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +int userfaultfd_wp_async(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_USERFAULTFD */
>  
>  static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 005e5e306266..f4252ef40071 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -38,7 +38,8 @@
>  			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
>  			   UFFD_FEATURE_MINOR_SHMEM |		\
>  			   UFFD_FEATURE_EXACT_ADDRESS |		\
> -			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
> +			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
> +			   UFFD_FEATURE_WP_ASYNC)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -203,6 +204,10 @@ struct uffdio_api {
>  	 *
>  	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
>  	 * write-protection mode is supported on both shmem and hugetlbfs.
> +	 *
> +	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
> +	 * asynchronous mode is supported in which the write fault is automatically
> +	 * resolved and write-protection is un-set.
>  	 */
>  #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
>  #define UFFD_FEATURE_EVENT_FORK			(1<<1)
> @@ -217,6 +222,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>  #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
> +#define UFFD_FEATURE_WP_ASYNC			(1<<13)
>  	__u64 features;
>  
>  	__u64 ioctls;
> diff --git a/mm/memory.c b/mm/memory.c
> index 4000e9f017e0..8c03b133d483 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  
>  	if (likely(!unshare)) {
>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> +			if (userfaultfd_wp_async(vma)) {
> +				/*
> +				 * Nothing needed (cache flush, TLB invalidations,
> +				 * etc.) because we're only removing the uffd-wp bit,
> +				 * which is completely invisible to the user. This
> +				 * falls through to possible CoW.

Here it says it falls through to CoW, but..

> +				 */
> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
> +					   pte_clear_uffd_wp(*vmf->pte));
> +				return 0;

... it's not doing so.  The original lines should do:

https://lore.kernel.org/all/Y8qq0dKIJBshua+X@x1n/

Side note: you cannot modify pgtable after releasing the pgtable lock.
It's racy.

> +			}
>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>  			return handle_userfault(vmf, VM_UFFD_WP);
>  		}
> @@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  
>  	if (vma_is_anonymous(vmf->vma)) {
>  		if (likely(!unshare) &&
> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
> -			return handle_userfault(vmf, VM_UFFD_WP);
> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
> +			if (userfaultfd_wp_async(vmf->vma)) {
> +				/*
> +				 * Nothing needed (cache flush, TLB invalidations,
> +				 * etc.) because we're only removing the uffd-wp bit,
> +				 * which is completely invisible to the user. This
> +				 * falls through to possible CoW.
> +				 */
> +				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
> +					   pmd_clear_uffd_wp(*vmf->pmd));

This is for THP, not hugetlb.

Clearing uffd-wp bit here for the whole pmd is wrong to me, because we
track writes in small page sizes only.  We should just split.

The relevant code for hugetlb resides in hugetlb_fault().

> +				return 0;
> +			} else {
> +				return handle_userfault(vmf, VM_UFFD_WP);
> +			}
> +		}
>  		return do_huge_pmd_wp_page(vmf);
>  	}
>  
> -- 
> 2.30.2
> 

-- 
Peter Xu

