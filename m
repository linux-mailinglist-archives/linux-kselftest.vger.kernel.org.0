Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2978747912
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGDUjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDUjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB6810D5
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688503090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiN6SRntMpmLKff29Z5XUQOre6SW7MCigDg36wB8/qk=;
        b=QKmUDJMmb01U5UxiQ6pKPWoqgGZTxAjR0+JbYzy/ZUVwrynAYZfHqyr855IpV3/VlVqD2B
        i1fVcCjsiJ+Ft9ncxmZJhW3nC2AtASQHknCpiyepZuWoD4Eg/GjXW8VMNmWjKgylPS6AXz
        uoftZ5Ntr4rmATETEkT03HUXlr5R0rE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-1sxo7HWeM56YR-wpx_szXg-1; Tue, 04 Jul 2023 16:38:09 -0400
X-MC-Unique: 1sxo7HWeM56YR-wpx_szXg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635eb5b04e1so13483096d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503089; x=1691095089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiN6SRntMpmLKff29Z5XUQOre6SW7MCigDg36wB8/qk=;
        b=VBP3FbebTrSFP6laPFD5sYjEkkVvGjcjBssIJ1rJDEWNhqWHvKy949bGeoscQoNA/Y
         eraTkN+qIaICJLDn3UvKf0tQElZ+VNOag3WtHKhWeoEeoMBt4k4C6WRZv7/Srk2XHhi2
         MT/YnsVIrOjoFhxYEVU+rNYwqHb6On+abgDnMU4h8af4o+0/MOL03jaPr1451XnKV/Zm
         CTrx5VFQBNyRze3vgbGurtG3MaWgf/wf5IB8SSLFqP8wsg4OCEquLveCOv38hZUzT4vz
         4HIkkn/JvrQfbBk/lMwQqZelNvhoJi60cqEd7p+09AWdE7+yJITJou6enrJnxzS/ZGy9
         wW4w==
X-Gm-Message-State: ABy/qLZMFOlU7FxXwJqWP8DTvO6ij1cFQe7TokK8l4BpMuBlOFkPco+9
        gEHSMg4SluWrtuDooT147ZGI518JdqTqKumwDUkiTZzuA6atB7Jgeb1SHpUu4pMKWRT4PtcWimQ
        /LKvRUKw7O4xFgYirwokhkvhK59ZF
X-Received: by 2002:a0c:fbcf:0:b0:62b:5410:322d with SMTP id n15-20020a0cfbcf000000b0062b5410322dmr15036171qvp.6.1688503088949;
        Tue, 04 Jul 2023 13:38:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG375vyIaJBYFnL5bU0MfybucMW/WIKE8gkWJWbSUXDdU9ab+mVDx4mopfcejBo2eXWtik8qg==
X-Received: by 2002:a0c:fbcf:0:b0:62b:5410:322d with SMTP id n15-20020a0cfbcf000000b0062b5410322dmr15036147qvp.6.1688503088597;
        Tue, 04 Jul 2023 13:38:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ec17-20020ad44e71000000b00632191a70a2sm12606315qvb.103.2023.07.04.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:38:08 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:38:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
Message-ID: <ZKSDLogLASaZgKCP@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629205040.665834-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 01:50:35PM -0700, Axel Rasmussen wrote:
> The basic idea here is to "simulate" memory poisoning for VMs. A VM
> running on some host might encounter a memory error, after which some
> page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> once poisoned, pages can never become "un-poisoned". So, when we live
> migrate the VM, we need to preserve the poisoned status of these pages.
> 
> When live migrating, we try to get the guest running on its new host as
> quickly as possible. So, we start it running before all memory has been
> copied, and before we're certain which pages should be poisoned or not.
> 
> So the basic way to use this new feature is:
> 
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_POISON - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.
> 
> UFFDIO_POISON does not handle unmapping previously-present PTEs. This
> isn't needed, because during live migration we want to intercept
> all accesses with userfaultfd (not just writes, so WP mode isn't useful
> for this). So whether minor or missing mode is being used (or both), the
> PTE won't be present in any case, so handling that case isn't needed.
> 
> Why return VM_FAULT_HWPOISON instead of VM_FAULT_SIGBUS when one of
> these markers is encountered? For "normal" userspace programs there
> isn't a big difference, both yield a SIGBUS. The difference for KVM is
> key though: VM_FAULT_HWPOISON will result in an MCE being injected into
> the guest (which is the behavior we want). With VM_FAULT_SIGBUS, the
> hypervisor would need to catch the SIGBUS and deal with the MCE
> injection itself.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Maybe have a cover letter for the next version?

> ---
>  fs/userfaultfd.c                 | 63 ++++++++++++++++++++++++++++++++
>  include/linux/swapops.h          |  3 +-
>  include/linux/userfaultfd_k.h    |  4 ++
>  include/uapi/linux/userfaultfd.h | 25 +++++++++++--
>  mm/memory.c                      |  4 ++
>  mm/userfaultfd.c                 | 62 ++++++++++++++++++++++++++++++-
>  6 files changed, 156 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7cecd49e078b..c26a883399c9 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1965,6 +1965,66 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  	return ret;
>  }
>  
> +static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long arg)
> +{
> +	__s64 ret;
> +	struct uffdio_poison uffdio_poison;
> +	struct uffdio_poison __user *user_uffdio_poison;
> +	struct userfaultfd_wake_range range;
> +
> +	user_uffdio_poison = (struct uffdio_poison __user *)arg;
> +
> +	ret = -EAGAIN;
> +	if (atomic_read(&ctx->mmap_changing))
> +		goto out;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(&uffdio_poison, user_uffdio_poison,
> +			   /* don't copy the output fields */
> +			   sizeof(uffdio_poison) - (sizeof(__s64))))
> +		goto out;
> +
> +	ret = validate_range(ctx->mm, uffdio_poison.range.start,
> +			     uffdio_poison.range.len);
> +	if (ret)
> +		goto out;
> +
> +	ret = -EINVAL;
> +	/* double check for wraparound just in case. */
> +	if (uffdio_poison.range.start + uffdio_poison.range.len <=
> +	    uffdio_poison.range.start) {

Brackets not needed here.

> +		goto out;
> +	}
> +	if (uffdio_poison.mode & ~UFFDIO_POISON_MODE_DONTWAKE)
> +		goto out;
> +
> +	if (mmget_not_zero(ctx->mm)) {
> +		ret = mfill_atomic_poison(ctx->mm, uffdio_poison.range.start,
> +					  uffdio_poison.range.len,
> +					  &ctx->mmap_changing, 0);
> +		mmput(ctx->mm);
> +	} else {
> +		return -ESRCH;
> +	}
> +
> +	if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
> +		return -EFAULT;
> +	if (ret < 0)
> +		goto out;
> +
> +	/* len == 0 would wake all */
> +	BUG_ON(!ret);
> +	range.len = ret;
> +	if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
> +		range.start = uffdio_poison.range.start;
> +		wake_userfault(ctx, &range);
> +	}
> +	ret = range.len == uffdio_poison.range.len ? 0 : -EAGAIN;
> +
> +out:
> +	return ret;
> +}
> +
>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>  {
>  	/*
> @@ -2066,6 +2126,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
>  	case UFFDIO_CONTINUE:
>  		ret = userfaultfd_continue(ctx, arg);
>  		break;
> +	case UFFDIO_POISON:
> +		ret = userfaultfd_poison(ctx, arg);
> +		break;
>  	}
>  	return ret;
>  }
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 4c932cb45e0b..8259fee32421 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
>  
>  #define  PTE_MARKER_UFFD_WP			BIT(0)
>  #define  PTE_MARKER_SWAPIN_ERROR		BIT(1)
> -#define  PTE_MARKER_MASK			(BIT(2) - 1)
> +#define  PTE_MARKER_UFFD_POISON			BIT(2)

One more tab.

Though I remembered the last time we discussed IIRC we plan to rename
SWAPIN_ERROR and reuse it, could you explain why a new bit is still needed?

I think I commented this but I'll do it again: IIUC any existing host
swapin errors for guest pages should be reported as MCE too, afaict,
happened in kvm context.

> +#define  PTE_MARKER_MASK			(BIT(3) - 1)
>  
>  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
>  {
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index ac7b0c96d351..ac8c6854097c 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
>  	MFILL_ATOMIC_COPY,
>  	MFILL_ATOMIC_ZEROPAGE,
>  	MFILL_ATOMIC_CONTINUE,
> +	MFILL_ATOMIC_POISON,
>  	NR_MFILL_ATOMIC_MODES,
>  };
>  
> @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
>  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
>  				     unsigned long len, atomic_t *mmap_changing,
>  				     uffd_flags_t flags);
> +extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> +				   unsigned long len, atomic_t *mmap_changing,
> +				   uffd_flags_t flags);
>  extern int mwriteprotect_range(struct mm_struct *dst_mm,
>  			       unsigned long start, unsigned long len,
>  			       bool enable_wp, atomic_t *mmap_changing);
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 66dd4cd277bd..62151706c5a3 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -39,7 +39,8 @@
>  			   UFFD_FEATURE_MINOR_SHMEM |		\
>  			   UFFD_FEATURE_EXACT_ADDRESS |		\
>  			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
> -			   UFFD_FEATURE_WP_UNPOPULATED)
> +			   UFFD_FEATURE_WP_UNPOPULATED |	\
> +			   UFFD_FEATURE_POISON)
>  #define UFFD_API_IOCTLS				\
>  	((__u64)1 << _UFFDIO_REGISTER |		\
>  	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -49,12 +50,14 @@
>  	 (__u64)1 << _UFFDIO_COPY |		\
>  	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
>  	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
> -	 (__u64)1 << _UFFDIO_CONTINUE)
> +	 (__u64)1 << _UFFDIO_CONTINUE |		\
> +	 (__u64)1 << _UFFDIO_POISON)
>  #define UFFD_API_RANGE_IOCTLS_BASIC		\
>  	((__u64)1 << _UFFDIO_WAKE |		\
>  	 (__u64)1 << _UFFDIO_COPY |		\
> +	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
>  	 (__u64)1 << _UFFDIO_CONTINUE |		\
> -	 (__u64)1 << _UFFDIO_WRITEPROTECT)
> +	 (__u64)1 << _UFFDIO_POISON)

May not be a large deal, but it's still better to declare the feature &
ioctls after all things implemented.  Maybe make these few lines
(UFFD_API*, and the new feature bit) as the last patch to enable the
feature?

>  
>  /*
>   * Valid ioctl command number range with this API is from 0x00 to
> @@ -71,6 +74,7 @@
>  #define _UFFDIO_ZEROPAGE		(0x04)
>  #define _UFFDIO_WRITEPROTECT		(0x06)
>  #define _UFFDIO_CONTINUE		(0x07)
> +#define _UFFDIO_POISON			(0x08)
>  #define _UFFDIO_API			(0x3F)
>  
>  /* userfaultfd ioctl ids */
> @@ -91,6 +95,8 @@
>  				      struct uffdio_writeprotect)
>  #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
>  				      struct uffdio_continue)
> +#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
> +				      struct uffdio_poison)
>  
>  /* read() structure */
>  struct uffd_msg {
> @@ -225,6 +231,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
>  #define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
> +#define UFFD_FEATURE_POISON			(1<<14)
>  	__u64 features;
>  
>  	__u64 ioctls;
> @@ -321,6 +328,18 @@ struct uffdio_continue {
>  	__s64 mapped;
>  };
>  
> +struct uffdio_poison {
> +	struct uffdio_range range;
> +#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
> +	__u64 mode;
> +
> +	/*
> +	 * Fields below here are written by the ioctl and must be at the end:
> +	 * the copy_from_user will not read past here.
> +	 */
> +	__s64 updated;
> +};
> +
>  /*
>   * Flags for the userfaultfd(2) system call itself.
>   */
> diff --git a/mm/memory.c b/mm/memory.c
> index d8a9a770b1f1..7fbda39e060d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3692,6 +3692,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  	if (WARN_ON_ONCE(!marker))
>  		return VM_FAULT_SIGBUS;
>  
> +	/* Poison emulation explicitly requested for this PTE. */
> +	if (marker & PTE_MARKER_UFFD_POISON)
> +		return VM_FAULT_HWPOISON;
> +
>  	/* Higher priority than uffd-wp when data corrupted */
>  	if (marker & PTE_MARKER_SWAPIN_ERROR)
>  		return VM_FAULT_SIGBUS;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index a2bf37ee276d..87b62ca1e09e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -286,6 +286,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>  	goto out;
>  }
>  
> +/* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> +static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
> +				   struct vm_area_struct *dst_vma,
> +				   unsigned long dst_addr,
> +				   uffd_flags_t flags)
> +{
> +	int ret;
> +	struct mm_struct *dst_mm = dst_vma->vm_mm;
> +	pte_t _dst_pte, *dst_pte;
> +	spinlock_t *ptl;
> +
> +	_dst_pte = make_pte_marker(PTE_MARKER_UFFD_POISON);
> +	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> +
> +	if (vma_is_shmem(dst_vma)) {
> +		struct inode *inode;
> +		pgoff_t offset, max_off;
> +
> +		/* serialize against truncate with the page table lock */
> +		inode = dst_vma->vm_file->f_inode;
> +		offset = linear_page_index(dst_vma, dst_addr);
> +		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +		ret = -EFAULT;
> +		if (unlikely(offset >= max_off))
> +			goto out_unlock;
> +	}

Maybe good chance to have a mfill_file_over_size() helper?  Other potential
users are mfill_atomic_pte_zeropage() and mfill_atomic_install_pte().

> +
> +	ret = -EEXIST;
> +	/*
> +	 * For now, we don't handle unmapping pages, so only support filling in
> +	 * none PTEs, or replacing PTE markers.
> +	 */
> +	if (!pte_none_mostly(*dst_pte))
> +		goto out_unlock;
> +
> +	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +
> +	/* No need to invalidate - it was non-present before */
> +	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +	ret = 0;
> +out_unlock:
> +	pte_unmap_unlock(dst_pte, ptl);
> +	return ret;
> +}
> +
>  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  {
>  	pgd_t *pgd;
> @@ -336,8 +381,12 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
>  	 * by THP.  Since we can not reliably insert a zero page, this
>  	 * feature is not supported.
> +	 *
> +	 * PTE marker handling for hugetlb is a bit special, so for now
> +	 * UFFDIO_POISON is not supported.
>  	 */
> -	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> +	    uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
>  		mmap_read_unlock(dst_mm);
>  		return -EINVAL;
>  	}
> @@ -481,6 +530,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
>  		return mfill_atomic_pte_continue(dst_pmd, dst_vma,
>  						 dst_addr, flags);
> +	} else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> +		return mfill_atomic_pte_poison(dst_pmd, dst_vma,
> +					       dst_addr, flags);
>  	}
>  
>  	/*
> @@ -702,6 +754,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
>  }
>  
> +ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> +			    unsigned long len, atomic_t *mmap_changing,
> +			    uffd_flags_t flags)
> +{
> +	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +			    uffd_flags_set_mode(flags, MFILL_ATOMIC_POISON));
> +}
> +
>  long uffd_wp_range(struct vm_area_struct *dst_vma,
>  		   unsigned long start, unsigned long len, bool enable_wp)
>  {
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
Peter Xu

