Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF46E511E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDQTm4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDQTmz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 15:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC47128
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681760529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ys6bHj0kEYQG5dBpJYBFUjQoxCIC6tHrlD1Aj5lZyJw=;
        b=Kjs+gutowKsBOsVCMyf+X8BSM4s+IoyHdnZum9xJZsssfnG/n7r1tTC9imyhNmh0cMQQvu
        K/5rC2uhwBwDzSgXQgSZYVqeSMyiHxmUud9EsmH5hanGhavlbA1ghz1a+VhrKTbzx5FkbW
        pewqLkGWt6jwtRjLpQh5MEsEqF3z8WQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1NKj98OSMAeuhZhaVeXKYg-1; Mon, 17 Apr 2023 15:42:06 -0400
X-MC-Unique: 1NKj98OSMAeuhZhaVeXKYg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-54fc7fcb81dso4736147b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 12:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760526; x=1684352526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys6bHj0kEYQG5dBpJYBFUjQoxCIC6tHrlD1Aj5lZyJw=;
        b=jQtls59qbQKEbMtUBdyuOl+QGSP2E/Q1Kl6RY7Ibc0YDemogoFTJoSFvT4cQMYIQ6r
         7LRivB/ZF/Ed9kzaTouR/rwYjeFPodJ9Jx5jHA6JvBtL+jChE3odyiTk9lz1ds2DWbXn
         6RM+AyWUQZ9NOmm/TvLF04gbv+Wel3HdDbdkz2PqLiIu+ILkgdyD2n0XUnBsrmi3W0Qf
         1U1TtwnFIgVeW+nQ3/VyHfbQCXBLKnw/oO39bE1dBwBSAfoHDcnoqaQIsiMofN1Ld06q
         XMYUMVAbKM7xU/0uF5704pU+LkAc3jb36VsbROD92aeRtoV1NixP9sJOVRwAzrWjhy3B
         2L7A==
X-Gm-Message-State: AAQBX9c1g7JK0NYcfSERkdHRu+7gs/gEtnY6cqv7enrJmsKuJ3TaVp+I
        DqLYNbMv72fjWVumimEOseKTJHAvyioqjZTD3z+GaUMG5ZkfkIRRq49w76PLcmu9cYvywJmVX6w
        RK0UW5sYswpeVNxI3jacNvkyxrSOM
X-Received: by 2002:a25:f812:0:b0:b92:2ec4:468 with SMTP id u18-20020a25f812000000b00b922ec40468mr8387666ybd.2.1681760525805;
        Mon, 17 Apr 2023 12:42:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350aD9Z53Fp0pWibrCkct8vOfri8wqcOppIT0+JRo2FSozSVhj1pOMlZkHbkZQMla/ukf75rU0w==
X-Received: by 2002:a25:f812:0:b0:b92:2ec4:468 with SMTP id u18-20020a25f812000000b00b922ec40468mr8387624ybd.2.1681760525481;
        Mon, 17 Apr 2023 12:42:05 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id a67-20020a254d46000000b00b8bfb4c4f1esm3139594ybb.62.2023.04.17.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:42:04 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:42:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v13 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZD2hCoTqSMtpjmaX@x1n>
References: <20230417125630.1146906-1-usama.anjum@collabora.com>
 <20230417125630.1146906-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417125630.1146906-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Muhammad,

On Mon, Apr 17, 2023 at 05:56:27PM +0500, Muhammad Usama Anjum wrote:
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long addr = end;
> +	pte_t *pte, *orig_pte;
> +	spinlock_t *ptl;
> +	bool is_written;
> +	int ret = 0;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
> +
> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +			n_pages = p->max_pages - p->found_pages;
> +
> +		is_written = !is_pmd_uffd_wp(*pmd);
> +
> +		/*
> +		 * Break huge page into small pages if the WP operation need to
> +		 * be performed is on a portion of the huge page.
> +		 */
> +		if (is_written && PM_SCAN_DO_UFFD_WP(p) &&
> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, start);
> +			goto process_smaller_pages;
> +		}
> +
> +		ret = pagemap_scan_output(is_written, vma->vm_file,
> +					  pmd_present(*pmd), is_swap_pmd(*pmd),
> +					  p, start, n_pages);
> +
> +		if (ret >= 0 && is_written && PM_SCAN_DO_UFFD_WP(p))
> +			make_uffd_wp_pmd(vma, addr, pmd);
> +
> +		spin_unlock(ptl);
> +		return ret;
> +	}
> +process_smaller_pages:
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +#endif
> +
> +	pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
> +		is_written = !is_pte_uffd_wp(*pte);
> +
> +		ret = pagemap_scan_output(is_written, vma->vm_file,
> +					  pte_present(*pte), is_swap_pte(*pte),
> +					  p, addr, 1);
> +
> +		if (ret >= 0 && is_written && PM_SCAN_DO_UFFD_WP(p))
> +			make_uffd_wp_pte(vma, addr, pte);
> +	}
> +	pte_unmap_unlock(orig_pte, ptl);

IIUC tlb flushes, mmu notifications are still missing here, am I right?

Thanks,

> +
> +	cond_resched();
> +	return ret;
> +}

-- 
Peter Xu

