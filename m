Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9835D482
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhDMAvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 20:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhDMAvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 20:51:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A8C061756
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:51:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o17so7843968qkl.13
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nrlp1kHR4YlxKa1ERUxKzM68UDG0XUD95QKfpS0Cu5o=;
        b=h3yUp7NyTbEKAYKqGPKG+T7CjJdk6hNtoxyqH16UStbQV6nhTW0tD7WCB+zBjuVQmy
         u0M4Ulz8a/whzlOezQuFp2VPjZ+XpEVGGd3zNR5T6Bc9LzezzmZpT67Wv/s4Nk3hfK6v
         E5r9++tTMtEBA6zK5cSnuflFDYOL9gSopAxV9xaqxX9fn6tOpSMpZPLnKKJZJyBm39HZ
         mBNWdwYwDuOTlm1pJ+QxP2U4vDBftq2cusje1kfPx6nY3OwJHb5l3k8TXRtIwAkswtwG
         pMQzq6h2djyTDFMFUVITk+k2zx5GdnwdOUWpTG9GTKasU/7vHMbvcFMEnAoJYTy5YxqN
         1L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nrlp1kHR4YlxKa1ERUxKzM68UDG0XUD95QKfpS0Cu5o=;
        b=JcmrQsHgZYjjo8C4oRGR5TmIvwK74hBjPlkKyVVgrblyRION43+gosVNN0d5D84w+n
         r6wkDFYioQ0Ot1y948IFY4WHpzFaXe308G/KnfyNA1PQZoYHRdmlD6VrSJSIjHtZr55I
         A4wX1tJaS/1IqZmME3ac22tVcSoueTEi5w7h4e2n4+iRE6wEh9hfxRH5EH+fEFpGU3Wd
         ABFcMEttfdR1PtzmmAZqn8qrn+ok3N4bmAT3EDun12cuUDRQhGAEWO5fv+/A8UaktwLe
         FvvXxk8c3+umtBZEHI+Fc9tDdwNcrymF0cHmUSZdwix2NgTh3nFeiUai/bhuGpVd8eN9
         n0/A==
X-Gm-Message-State: AOAM533jL0xP5XFbqz6qqkqhenFK0RSLvKFAMhLUekXZGs3Jk1hJjCUi
        aAauQFGVOu+WT7NPluTg5OKvCA==
X-Google-Smtp-Source: ABdhPJxHD3b7QbTJcYNF9To6rhW0bX8+IxOxpp0Z1Pa+6iwrNw71PaaW4Ic29mUmX2AFe85LxEhBRQ==
X-Received: by 2002:a37:46c5:: with SMTP id t188mr30665833qka.47.1618275087461;
        Mon, 12 Apr 2021 17:51:27 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g3sm8773293qth.66.2021.04.12.17.51.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 12 Apr 2021 17:51:26 -0700 (PDT)
Date:   Mon, 12 Apr 2021 17:51:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE
 behavior
In-Reply-To: <20210412215437.GA1001332@xz-x1>
Message-ID: <alpine.LSU.2.11.2104121657050.1097@eggly.anvils>
References: <20210401183701.1774159-1-axelrasmussen@google.com> <alpine.LSU.2.11.2104062307110.14082@eggly.anvils> <20210412215437.GA1001332@xz-x1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 12 Apr 2021, Peter Xu wrote:
> On Tue, Apr 06, 2021 at 11:14:30PM -0700, Hugh Dickins wrote:
> > > +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > > +				     struct vm_area_struct *dst_vma,
> > > +				     unsigned long dst_addr, struct page *page,
> > > +				     enum mcopy_atomic_mode mode, bool wp_copy)
> > > +{
> 
> [...]
> 
> > > +	if (writable) {
> > > +		_dst_pte = pte_mkdirty(_dst_pte);
> > > +		if (wp_copy)
> > > +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> > > +		else
> > > +			_dst_pte = pte_mkwrite(_dst_pte);
> > > +	} else if (vm_shared) {
> > > +		/*
> > > +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> > > +		 * could be freed from under us. We could do this
> > > +		 * unconditionally, but doing it only if !writable is faster.
> > > +		 */
> > > +		set_page_dirty(page);
> > 
> > I do not remember why Andrea or I preferred set_page_dirty() here to
> > pte_mkdirty(); but I suppose there might somewhere be a BUG_ON(pte_dirty)
> > which this would avoid.  Risky to change it, though it does look odd.
> 
> Is any of the possible BUG_ON(pte_dirty) going to trigger because the pte has
> write bit cleared?  That's one question I was not very sure, e.g., whether one
> pte is allowed to be "dirty" if it's not writable.
> 
> To me it's okay, it's actually very suitable for UFFDIO_COPY case, where it is
> definitely dirty data (so we must never drop it) even if it's installed as RO,
> however to achieve that we can still set the dirty on the page rather than the
> pte as what we do here.  It's just a bit awkward as you said.
> 
> Meanwhile today I just noticed this in arm64 code:
> 
> static inline pte_t pte_wrprotect(pte_t pte)
> {
> 	/*
> 	 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
> 	 * clear), set the PTE_DIRTY bit.
> 	 */
> 	if (pte_hw_dirty(pte))
> 		pte = pte_mkdirty(pte);
> 
> 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
> 	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> 	return pte;
> }
> 
> So arm64 will explicitly set the dirty bit (from the HW dirty bit) when
> wr-protect.  It seems to prove that at least for arm64 it's very valid to have
> !write && dirty pte.

I did not mean to imply that it's wrong to have pte_dirty without
pte_write: no, I agree with you, I believe that there are accepted
and generic ways in which we can have pte_dirty without pte_write
(and we could each probably add a warning somewhere which would
very quickly prove that - but those would not prove that there
are not BUG_ONs on some other path, which had been my fear).

I wanted now to demonstrate that by pointing to change_pte_range() in
mm/mprotect.c, showing that it does not clear pte_dirty when it clears
pte_write. But alarmingly found rather the reverse: that it appears to
set pte_write when it finds pte_dirty - if dirty_accountable.

That looks very wrong, but if I spent long enough following up
dirty_accountable in detail, I think I would be reassured to find that
it is only adding the pte_write there when it had removed it from the
prot passed down, for dirty accounting reasons (which apply !VM_SHARED
protections in the VM_SHARED case, so that page_mkwrite() is called
and dirty accounting done when necessary).

What I did mean to imply is that changing set_page_dirty to pte_mkdirty,
to make that userfaultfd code block look nicer, is not a change to be
done lightly: by all means try it out, test it, and send a patch after
Axel's series is in, but please do not ask Axel to make that change as
a part of his series - it would be taking a risk, just for a cleanup.

Now, I have also looked up the mail exchange with Andrea which led to
his dcf7fe9d8976 ("userfaultfd: shmem: UFFDIO_COPY: set the page dirty
if VM_WRITE is not set") - it had to be off-list at the time.  And he
was rather led to that set_page_dirty by following old patterns left
over in shmem_getpage_gfp(); but when I said "or it could be done with
pte_mkdirty without pte_mkwrite", he answered "I explicitly avoided
that because pte_dirty then has side effects on mprotect to decide
pte_write. It looks safer to do set_page_dirty and not set dirty bits
in not writable ptes unnecessarily".

Haha: I think Andrea is referring to exactly the dirty_accountable code
in change_pte_protection() which worried me above. Now, I think that
will turn out okay (shmem does not have a page_mkwrite(), and does not
participate in dirty accounting), but you will have to do some work to
assure us all of that, before sending in a cleanup patch.

Hugh
