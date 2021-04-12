Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE135D2C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 23:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbhDLVzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 17:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237700AbhDLVzC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 17:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618264484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSg/4g7S1VAs0BEe21c6JFZm2CbvqXRaPJMkscjjUzQ=;
        b=inutjazrEeRzr033gJXnuAEJuuW9F61w88eB6QP+2TNHEt0tFFDArPcZj3U8M1YpVdk7JW
        BfRB9Knk9OA2v5Oh3C41ky1mfC5O3GivqYUDNjomj4KBEATTIuEIIH23XIlgKaM6L0eDY2
        K/Z+AJoaP01Cy69B1xAfDUia4djdYkY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-ozIJvPrPO1CPAKI2qDQa8Q-1; Mon, 12 Apr 2021 17:54:42 -0400
X-MC-Unique: ozIJvPrPO1CPAKI2qDQa8Q-1
Received: by mail-qv1-f71.google.com with SMTP id p2so8860793qvi.6
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 14:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSg/4g7S1VAs0BEe21c6JFZm2CbvqXRaPJMkscjjUzQ=;
        b=nY6PvqFME2ZHIkOlQwLFFS5fkRzEWpqu0GYa9kAxfcYp4PbP6Ug1X9vzijSaD+AOYY
         f1ZWkgF5QkvAMiC/hlZ40GmIazuV76oM+TJ/4VmGgdAU7iC5eW+8EAnPxmgviQsVr+hO
         7L0g8SlOTq6kvX6jdHs7ynkya9y4dR3meR4cXejwx533p2aGJpwQ2ldlj6t1Bgp20e9H
         fwAQsPfEBoIATbbly6MlZT4Ejaopn4k0N9og3s8O51HQv/wfd2NN4VqvCwg20ypcoChg
         +JFfyfblAxNu3fmVTtGm6OFvGmRWiCriVbvbXBL3d7mUY5oqvYIaDTuxAHiMxGuSKz4m
         YOyQ==
X-Gm-Message-State: AOAM530N+gdHkEEi8OxyhOQ5pg1EfAUsLMXxJxq39yNDw/QbrjdZETVk
        YkU79K2smsNrzp43zFyxhleHRuUvsR4pGYdna7mwM71rC9UoXaFscqS1EMRY/VNZBVmNdCMJiam
        8snYjS4DtDccRsnPlt+rt2Wx5UyTb
X-Received: by 2002:a05:6214:14b4:: with SMTP id bo20mr4943789qvb.20.1618264482035;
        Mon, 12 Apr 2021 14:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbD4DC7OMtAMwjp3Zq2ZGY5AAvdzECr9OQOYMWUawBpI5JNBVDfUwjpTZGyULdEUCkWeV3/g==
X-Received: by 2002:a05:6214:14b4:: with SMTP id bo20mr4943769qvb.20.1618264481785;
        Mon, 12 Apr 2021 14:54:41 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id z18sm3501170qkg.42.2021.04.12.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:54:40 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:54:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE behavior
Message-ID: <20210412215437.GA1001332@xz-x1>
References: <20210401183701.1774159-1-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104062307110.14082@eggly.anvils>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Hugh,

On Tue, Apr 06, 2021 at 11:14:30PM -0700, Hugh Dickins wrote:
> > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > +				     struct vm_area_struct *dst_vma,
> > +				     unsigned long dst_addr, struct page *page,
> > +				     enum mcopy_atomic_mode mode, bool wp_copy)
> > +{

[...]

> > +	if (writable) {
> > +		_dst_pte = pte_mkdirty(_dst_pte);
> > +		if (wp_copy)
> > +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> > +		else
> > +			_dst_pte = pte_mkwrite(_dst_pte);
> > +	} else if (vm_shared) {
> > +		/*
> > +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> > +		 * could be freed from under us. We could do this
> > +		 * unconditionally, but doing it only if !writable is faster.
> > +		 */
> > +		set_page_dirty(page);
> 
> I do not remember why Andrea or I preferred set_page_dirty() here to
> pte_mkdirty(); but I suppose there might somewhere be a BUG_ON(pte_dirty)
> which this would avoid.  Risky to change it, though it does look odd.

Is any of the possible BUG_ON(pte_dirty) going to trigger because the pte has
write bit cleared?  That's one question I was not very sure, e.g., whether one
pte is allowed to be "dirty" if it's not writable.

To me it's okay, it's actually very suitable for UFFDIO_COPY case, where it is
definitely dirty data (so we must never drop it) even if it's installed as RO,
however to achieve that we can still set the dirty on the page rather than the
pte as what we do here.  It's just a bit awkward as you said.

Meanwhile today I just noticed this in arm64 code:

static inline pte_t pte_wrprotect(pte_t pte)
{
	/*
	 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
	 * clear), set the PTE_DIRTY bit.
	 */
	if (pte_hw_dirty(pte))
		pte = pte_mkdirty(pte);

	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
	return pte;
}

So arm64 will explicitly set the dirty bit (from the HW dirty bit) when
wr-protect.  It seems to prove that at least for arm64 it's very valid to have
!write && dirty pte.

Thanks,

-- 
Peter Xu

