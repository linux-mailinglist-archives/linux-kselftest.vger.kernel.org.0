Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADD7B2362
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjI1RKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjI1RJw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 13:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F83193
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695920947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGp+PyJTr4edNcM/XwykLBZHykfZtWbhyhpNEWgpqCQ=;
        b=aeECoHE8XCeJMFQ2RBhPdZUIUVTEhTDCOlRfX5ENThbvK03IKFtvPxAEclptiAbtkl0bXF
        Z7ftB3FV1PFG/GiJZUt20xkO9Hc0ifFXHwgZS2sL5wzl0zXr3uiN+tn3z2mtptygmexrXv
        tCc9Gn/oIMO+QbpkSCMpXHxv5E8mX54=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-ssYKD9YaO0GgIwcm4bWpQA-1; Thu, 28 Sep 2023 13:09:06 -0400
X-MC-Unique: ssYKD9YaO0GgIwcm4bWpQA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4194e7f41e1so18194311cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 10:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920945; x=1696525745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGp+PyJTr4edNcM/XwykLBZHykfZtWbhyhpNEWgpqCQ=;
        b=ID9ImqtW30TBSdvKNmkxBJwFCxmO81eb/LZcIft1YIPDZ1rvl7Xe3pbQIvk5clNIL2
         hvL4O3oAudvmbtKJoiv877NEO9iFFJvnzAIKVm0qmi+kbmi431Z9mHr52EHTgut9eKGc
         uAo5Udu6phVdtyH0dliuIXrTsjN/2EFWRSVM6+emAdB1HDNxPwVn2SmDEXQrX+YokaYV
         bB7ujMKecSPcT0C3hRwVi527xXrMSzqzZMf/OFv5xH/vCBrMwEwX54IGoam9HEs5JhjQ
         5xn6F+7/eD3PBgtu0pC0V/EpdONXViAOV5hoS4gn3irF/jyRmDGGBR9TTzco2UZPYm84
         fAAw==
X-Gm-Message-State: AOJu0Yx5DaoX1IlXQ42B2nzE5pL5SEovHFx0chMrxLyt4sL4l6ycK6yp
        qEhnfye4t/8HXTTFBbd6hjiE9LT0j5FB+WW8KGTZuTy4sCXEf+WjPYQIBhdres9kvmG9zKFMjW4
        9pjO2WtkpXnjz80+j8JxxyWwyxv5VpqjQyzLv
X-Received: by 2002:a05:622a:1047:b0:417:b509:bcec with SMTP id f7-20020a05622a104700b00417b509bcecmr1672781qte.2.1695920944594;
        Thu, 28 Sep 2023 10:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNAdQBpGgtdMFpR59pTWIzxY71rITQT57TFTB0Do3EzRRb8hrXBkWSIvM3bgtsA3GlWfy09g==
X-Received: by 2002:a05:622a:1047:b0:417:b509:bcec with SMTP id f7-20020a05622a104700b00417b509bcecmr1672751qte.2.1695920944148;
        Thu, 28 Sep 2023 10:09:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id kq16-20020ac86190000000b0041976a54e1bsm175220qtb.44.2023.09.28.10.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:09:03 -0700 (PDT)
Date:   Thu, 28 Sep 2023 13:09:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRWzLC5yCypoPNk2@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923013148.1390521-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 22, 2023 at 06:31:45PM -0700, Suren Baghdasaryan wrote:
> @@ -72,6 +73,7 @@
>  #define _UFFDIO_WAKE			(0x02)
>  #define _UFFDIO_COPY			(0x03)
>  #define _UFFDIO_ZEROPAGE		(0x04)
> +#define _UFFDIO_REMAP			(0x05)
>  #define _UFFDIO_WRITEPROTECT		(0x06)
>  #define _UFFDIO_CONTINUE		(0x07)
>  #define _UFFDIO_POISON			(0x08)

Might be good to add a feature bit (UFFD_FEATURE_REMAP) for userspace to
probe?

IIUC the whole remap feature was proposed at the birth of uffd even before
COPY, but now we have tons of old kernels who will not support it.

[...]

> +int remap_pages_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			 pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
> +			 struct vm_area_struct *dst_vma,
> +			 struct vm_area_struct *src_vma,
> +			 unsigned long dst_addr, unsigned long src_addr)
> +{
> +	pmd_t _dst_pmd, src_pmdval;
> +	struct page *src_page;
> +	struct folio *src_folio;
> +	struct anon_vma *src_anon_vma, *dst_anon_vma;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pgtable_t src_pgtable, dst_pgtable;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +
> +	src_pmdval = *src_pmd;
> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
> +
> +	BUG_ON(!spin_is_locked(src_ptl));
> +	mmap_assert_locked(src_mm);
> +	mmap_assert_locked(dst_mm);
> +
> +	BUG_ON(!pmd_trans_huge(src_pmdval));
> +	BUG_ON(!pmd_none(dst_pmdval));
> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> +
> +	src_page = pmd_page(src_pmdval);
> +	if (unlikely(!PageAnonExclusive(src_page))) {
> +		spin_unlock(src_ptl);
> +		return -EBUSY;
> +	}
> +
> +	src_folio = page_folio(src_page);
> +	folio_get(src_folio);
> +	spin_unlock(src_ptl);
> +
> +	/* preallocate dst_pgtable if needed */
> +	if (dst_mm != src_mm) {
> +		dst_pgtable = pte_alloc_one(dst_mm);
> +		if (unlikely(!dst_pgtable)) {
> +			err = -ENOMEM;
> +			goto put_folio;
> +		}
> +	} else {
> +		dst_pgtable = NULL;
> +	}
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, src_addr,
> +				src_addr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	/* block all concurrent rmap walks */

This is not accurate either I think.  Maybe we can do "s/all/most/", or
just drop it (assuming the detailed and accurate version of documentation
lies above remap_pages() regarding to REMAP locking)?

> +	folio_lock(src_folio);

[...]


> +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +			  struct vm_area_struct *dst_vma,
> +			  struct vm_area_struct *src_vma,
> +			  unsigned long dst_addr, unsigned long src_addr,
> +			  pte_t *dst_pte, pte_t *src_pte,
> +			  pte_t orig_dst_pte, pte_t orig_src_pte,
> +			  spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +			  struct folio *src_folio)

remap_present_pte?

[...]

> +/**
> + * remap_pages - remap arbitrary anonymous pages of an existing vma
> + * @dst_start: start of the destination virtual memory range
> + * @src_start: start of the source virtual memory range
> + * @len: length of the virtual memory range
> + *
> + * remap_pages() remaps arbitrary anonymous pages atomically in zero
> + * copy. It only works on non shared anonymous pages because those can
> + * be relocated without generating non linear anon_vmas in the rmap
> + * code.
> + *
> + * It provides a zero copy mechanism to handle userspace page faults.
> + * The source vma pages should have mapcount == 1, which can be
> + * enforced by using madvise(MADV_DONTFORK) on src vma.
> + *
> + * The thread receiving the page during the userland page fault
> + * will receive the faulting page in the source vma through the network,
> + * storage or any other I/O device (MADV_DONTFORK in the source vma
> + * avoids remap_pages() to fail with -EBUSY if the process forks before
> + * remap_pages() is called), then it will call remap_pages() to map the
> + * page in the faulting address in the destination vma.
> + *
> + * This userfaultfd command works purely via pagetables, so it's the
> + * most efficient way to move physical non shared anonymous pages
> + * across different virtual addresses. Unlike mremap()/mmap()/munmap()
> + * it does not create any new vmas. The mapping in the destination
> + * address is atomic.
> + *
> + * It only works if the vma protection bits are identical from the
> + * source and destination vma.
> + *
> + * It can remap non shared anonymous pages within the same vma too.
> + *
> + * If the source virtual memory range has any unmapped holes, or if
> + * the destination virtual memory range is not a whole unmapped hole,
> + * remap_pages() will fail respectively with -ENOENT or -EEXIST. This
> + * provides a very strict behavior to avoid any chance of memory
> + * corruption going unnoticed if there are userland race conditions.
> + * Only one thread should resolve the userland page fault at any given
> + * time for any given faulting address. This means that if two threads
> + * try to both call remap_pages() on the same destination address at the
> + * same time, the second thread will get an explicit error from this
> + * command.
> + *
> + * The command retval will return "len" is successful. The command
> + * however can be interrupted by fatal signals or errors. If
> + * interrupted it will return the number of bytes successfully
> + * remapped before the interruption if any, or the negative error if
> + * none. It will never return zero. Either it will return an error or
> + * an amount of bytes successfully moved. If the retval reports a
> + * "short" remap, the remap_pages() command should be repeated by
> + * userland with src+retval, dst+reval, len-retval if it wants to know
> + * about the error that interrupted it.
> + *
> + * The UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES flag can be specified to
> + * prevent -ENOENT errors to materialize if there are holes in the
> + * source virtual range that is being remapped. The holes will be
> + * accounted as successfully remapped in the retval of the
> + * command. This is mostly useful to remap hugepage naturally aligned
> + * virtual regions without knowing if there are transparent hugepage
> + * in the regions or not, but preventing the risk of having to split
> + * the hugepmd during the remap.
> + *
> + * If there's any rmap walk that is taking the anon_vma locks without
> + * first obtaining the folio lock (for example split_huge_page and
> + * folio_referenced), they will have to verify if the folio->mapping

Hmm, this sentence seems to be not 100% accurate, perhaps not anymore?

As split_huge_page() should need the folio lock and it'll serialize with
REMAP with the folio lock too.  It seems to me only folio_referenced() is
the outlier so far, and that's covered by patch 1.

I did also check other users of folio_get_anon_vma() (similar to use case
of split_huge_page()) and they're all with the folio lock held, so we
should be good.

In summary, perhaps:

  - Drop split_huge_page() example here?

  - Should we document above folio_get_anon_vma() about this specialty due
    to UFFDIO_REMAP?  I'm thiking something like:

+ *
+ * NOTE: the caller should normally hold folio lock when calling this.  If
+ * not, the caller needs to double check the anon_vma didn't change after
+ * taking the anon_vma lock for either read or write (UFFDIO_REMAP can
+ * modify it concurrently without folio lock protection).  See
+ * folio_lock_anon_vma_read() which has already covered that, and comment
+ * above remap_pages().
  */
 struct anon_vma *folio_get_anon_vma(struct folio *folio)
 {
 ...
 }

> + * has changed after taking the anon_vma lock. If it changed they
> + * should release the lock and retry obtaining a new anon_vma, because
> + * it means the anon_vma was changed by remap_pages() before the lock
> + * could be obtained. This is the only additional complexity added to
> + * the rmap code to provide this anonymous page remapping functionality.
> + */
> +ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> +		    unsigned long dst_start, unsigned long src_start,
> +		    unsigned long len, __u64 mode)
> +{

[...]

> +		if (!err) {
> +			dst_addr += step_size;
> +			src_addr += step_size;
> +			moved += step_size;
> +		}
> +
> +		if ((!err || err == -EAGAIN) &&
> +		    fatal_signal_pending(current))
> +			err = -EINTR;
> +
> +		if (err && err != -EAGAIN)
> +			break;

The err handling is slightly harder to read.  I tried to rewrite it like
this:

switch (err) {
       case 0:
                dst_addr += step_size;
                src_addr += step_size;
                moved += step_size;
                /* fall through */
       case -EAGAIN:
                if (fatal_signal_pending(current)) {
                        err = -EINTR;
                        goto out;
                }
                /* Continue with the loop */
                break;
       default:
                goto out;
}

Not super good but maybe slightly better?  No strong opinions, but if you
agree that looks better we can use it.

> +	}
> +
> +out:
> +	mmap_read_unlock(dst_mm);
> +	if (dst_mm != src_mm)
> +		mmap_read_unlock(src_mm);
> +	BUG_ON(moved < 0);
> +	BUG_ON(err > 0);
> +	BUG_ON(!moved && !err);
> +	return moved ? moved : err;
> +}

I think for the rest I'll read the new version (e.g. I saw discussion on
proper handling of pmd swap entries, which is not yet addressed, but
probably will in the next one).

Thanks,

-- 
Peter Xu

