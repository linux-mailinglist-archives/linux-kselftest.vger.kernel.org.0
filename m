Return-Path: <linux-kselftest+bounces-28670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA2A5A42B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 20:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C823A879F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB81DE2C6;
	Mon, 10 Mar 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7MV2gdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9A1DDC07
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636640; cv=none; b=HBEX9TbUi6Pt0IBgtSAoA0SH/t2qFlo/hpsO205r+k7+V7f3Tiwdk2GDwG/ILyVF2tCkWtBaM6yCe7zzU4iJcs6XkqbJPiQccXB9JCVbzVL4Cn4ORZrP9CDbA32nySZcXPCNXoRipsmkm562grnIUNt0Iiq5kS+mvn7TTUe92k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636640; c=relaxed/simple;
	bh=LKxVGwnfTaWA1ZfDbwwbFjhkiIhpTCQkOgg+jTBzbUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvFTbjopz4qP2YtaCV2vo1p37trSFTVk5/c1nVi6l3HS17jgNbCkyFmWiszEn536J9wt3UUJste14Whg9Os+2NYGQI/v5tVqg5GjhuPggqYzIkmFjGVJ2myO+FaMKJaG0H3XQMOhZoOP4DSM5JS7IYi8yoPgDEeEIl2vwNthi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7MV2gdN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741636637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8xyWG42ZuOIaLO2r4meAYJugvJJCVkcbSBl0v7IQsw=;
	b=V7MV2gdNqKkvywcMZmsK3H/g+a3xqNF+aaFpE1mwEad1sRZXOsfnv3Rzig2LRq+Hpthal1
	wXJrn0JNnK+jvjpOt9nI9HqiEtq5k2z9uaubb8hQLRBKQ8T0Fi22q4+U/VKoU3umogE/MW
	8MhAYf54qrDHDwizMsZi34hOtqPZlOg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nGB6sNP5MqWgHtJU8aZa-Q-1; Mon, 10 Mar 2025 15:57:16 -0400
X-MC-Unique: nGB6sNP5MqWgHtJU8aZa-Q-1
X-Mimecast-MFC-AGG-ID: nGB6sNP5MqWgHtJU8aZa-Q_1741636636
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4769a1db721so5971081cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 12:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636636; x=1742241436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8xyWG42ZuOIaLO2r4meAYJugvJJCVkcbSBl0v7IQsw=;
        b=tcnAmSJLwcys+RCes5WqVv9jhhWEgu/nTfgVK5iIGxG6XCuyGEwHFUT99JW9yjqT1u
         7r4UVsZVs7IjS7eLajmiLCj8KPuCEyN5HLVkpGYqcYSVrv0PRJyXvRyCFwemeGOqZITr
         v3OdtqZVjWDA92ltSoo7Xp+4Om1ICe0A6iwbnQJjekbx+1pdxTXg7+SW2MORWwflHB0X
         iPIgcoSpyCTleZcprg4eLnggJKrzS3cYUivapRNovcMTGt6DwWlc5Zk3C5JstuhLd+YI
         Qs5ZjfMMXyJouU+WF8iBh4Ujhj5JvmJAXRQEaJRG+YPQ4C3+7W/VU6zPJnyDAK7UvGxm
         ov+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg9W422kkv2WlZXele4P7MCRRWyCDEDn5c2/+A8OPqaHQYVi3AKfS3fGEp0/yuTZyGv3iyAIARaxcJ1xf8AS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsCS/RD8JxqSM7z4YCZu+hjB+hL6pjcgnDsUcGSaRpuhWWPY+
	Am6VYS5/JOJX7bDr1nefWTQQL+lyYxV6fSoLVwRNp8p1+oILUg/7lQWolB/jG5REup/DXcAsz49
	KopuZC2kuCU38pR4dRQSrr4+2EngSha4ztjjoP+9IbZqwvjXORFzcRFT+pgEJii+dfA==
X-Gm-Gg: ASbGnctu+0pQn6lb74dJkbwzlheGM+CCjSGQRJ7avrUwu13ok10ZISSQu1RfD9EfGux
	ASqVNyiS4jee7CU7ZZ2gZ4We3wjgrYgzDHM1cHAvnqkpETItFNwW8B0pAS02k2gp95Rl3U+FO/6
	BoDaXe0coDR7Ui9eEBFb0L/CZ2Uho24aireGhkAEJ10JjvXEY0GyVBYOYqy8pAbhD3B+XAUOeDs
	W+oALg4r/CRH+1TRAv3zKyOoes3SMaquW3maV/8GKcaJCOJUyEHXoe07FDWJa3lxq7b9+nuDi6D
	ZElsz9U=
X-Received: by 2002:ac8:5745:0:b0:476:74de:81e2 with SMTP id d75a77b69052e-47674de857emr144524551cf.43.1741636636066;
        Mon, 10 Mar 2025 12:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJaP7gBJHUVmVF8NuJDRjjC2wD/aDoV/tl7RcR7xOw/jV+Wi87S1Vt6HJV54rbfWOqlAyd6g==
X-Received: by 2002:ac8:5745:0:b0:476:74de:81e2 with SMTP id d75a77b69052e-47674de857emr144523981cf.43.1741636635560;
        Mon, 10 Mar 2025 12:57:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476839ea30csm22806571cf.55.2025.03.10.12.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:57:14 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:57:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z89EFbT_DKqyJUxr@x1.local>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>

On Mon, Mar 10, 2025 at 06:12:22PM +0000, Nikita Kalyazin wrote:
> 
> 
> On 05/03/2025 20:29, Peter Xu wrote:
> > On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
> > > I think it might be useful to implement an fs-generic MINOR mode. The
> > > fault handler is already easy enough to do generically (though it
> > > would become more difficult to determine if the "MINOR" fault is
> > > actually a MISSING fault, but at least for my userspace, the
> > > distinction isn't important. :)) So the question becomes: what should
> > > UFFDIO_CONTINUE look like?
> > > 
> > > And I think it would be nice if UFFDIO_CONTINUE just called
> > > vm_ops->fault() to get the page we want to map and then mapped it,
> > > instead of having shmem-specific and hugetlb-specific versions (though
> > > maybe we need to keep the hugetlb specialization...). That would avoid
> > > putting kvm/gmem/etc. symbols in mm/userfaultfd code.
> > > 
> > > I've actually wanted to do this for a while but haven't had a good
> > > reason to pursue it. I wonder if it can be done in a
> > > backwards-compatible fashion...
> > 
> > Yes I also thought about that. :)
> 
> Hi Peter, hi James.  Thanks for pointing at the race condition!
> 
> I did some experimentation and it indeed looks possible to call
> vm_ops->fault() from userfault_continue() to make it generic and decouple
> from KVM, at least for non-hugetlb cases.  One thing is we'd need to prevent
> a recursive handle_userfault() invocation, which I believe can be solved by
> adding a new VMF flag to ignore the userfault path when the fault handler is
> called from userfault_continue().  I'm open to a more elegant solution
> though.

It sounds working to me.  Adding fault flag can also be seen as part of
extension of vm_operations_struct ops.  So we could consider reusing
fault() API indeed.

> 
> Regarding usage of the MINOR notification, in what case do you recommend
> sending it?  If following the logic implemented in shmem and hugetlb, ie if
> the page is _present_ in the pagecache, I can't see how it is going to work

It could be confusing when reading that chunk of code, because it looks
like it notifies minor fault when cache hit. But the critical part here is
that we rely on the pgtable missing causing the fault() to trigger first.
So it's more like "cache hit && pgtable missing" for minor fault.

> with the write syscall, as we'd like to know when the page is _missing_ in
> order to respond with the population via the write.  If going against
> shmem/hugetlb logic, and sending the MINOR event when the page is missing
> from the pagecache, how would it solve the race condition problem?

Should be easier we stick with mmap() rather than write().  E.g. for shmem
case of current code base:

	if (folio && vma && userfaultfd_minor(vma)) {
		if (!xa_is_value(folio))
			folio_put(folio);
		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
		return 0;
	}

vma is only availble if vmf!=NULL, aka in fault context.  With that, in
write() to shmem inodes, nothing will generate a message, because minor
fault so far is only about pgtable missing.  It needs to be mmap()ed first,
and has nothing yet to do with write() syscalls.

> 
> Also, where would the check for the folio_test_uptodate() mentioned by James
> fit into here?  Would it only be used for fortifying the MINOR (present)
> against the race?
> 
> > When Axel added minor fault, it's not a major concern as it's the only fs
> > that will consume the feature anyway in the do_fault() path - hugetlbfs has
> > its own path to take care of.. even until now.
> > 
> > And there's some valid points too if someone would argue to put it there
> > especially on folio lock - do that in shmem.c can avoid taking folio lock
> > when generating minor fault message.  It might make some difference when
> > the faults are heavy and when folio lock is frequently taken elsewhere too.
> 
> Peter, could you expand on this?  Are you referring to the following
> (shmem_get_folio_gfp)?
> 
> 	if (folio) {
> 		folio_lock(folio);
> 
> 		/* Has the folio been truncated or swapped out? */
> 		if (unlikely(folio->mapping != inode->i_mapping)) {
> 			folio_unlock(folio);
> 			folio_put(folio);
> 			goto repeat;
> 		}
> 		if (sgp == SGP_WRITE)
> 			folio_mark_accessed(folio);
> 		if (folio_test_uptodate(folio))
> 			goto out;
> 		/* fallocated folio */
> 		if (sgp != SGP_READ)
> 			goto clear;
> 		folio_unlock(folio);
> 		folio_put(folio);
> 	}
> 
> Could you explain in what case the lock can be avoided?  AFAIC, the function
> is called by both the shmem fault handler and userfault_continue().

I think you meant the UFFDIO_CONTINUE side of things.  I agree with you, we
always need the folio lock.

What I was saying is the trapping side, where the minor fault message can
be generated without the folio lock now in case of shmem.  It's about
whether we could generalize the trapping side, so handle_mm_fault() can
generate the minor fault message instead of by shmem.c.

If the only concern is "referring to a module symbol from core mm", then
indeed the trapping side should be less of a concern anyway, because the
trapping side (when in the module codes) should always be able to reference
mm functions.

Actually.. if we have a fault() flag introduced above, maybe we can
generalize the trap side altogether without the folio lock overhead.  When
the flag set, if we can always return the folio unlocked (as long as
refcount held), then in UFFDIO_CONTINUE ioctl we can lock it.

> 
> > It might boil down to how many more FSes would support minor fault, and
> > whether we would care about such difference at last to shmem users. If gmem
> > is the only one after existing ones, IIUC there's still option we implement
> > it in gmem code.  After all, I expect the change should be very under
> > control (<20 LOCs?)..
> > 
> > --
> > Peter Xu
> > 
> 

-- 
Peter Xu


