Return-Path: <linux-kselftest+bounces-28330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC197A50B93
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071AC188A6D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36225484E;
	Wed,  5 Mar 2025 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXVQOUbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40423027C
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203366; cv=none; b=KsUgjobngwoTmwoILBK1Oq2h5ZXnatH1VYp/p7C1RWuLaVQk0r+qZ+Rq4eqgcbSLI9aCCQSOer8H6/Cl+SMnOCyuouJjQQSWAaMQjRQvLPiapzTLy/ffb3j8QOrhjXkI6RnU8BtiwEmnahaK5Oj45LTeZgu7bf2J/OiJkujvLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203366; c=relaxed/simple;
	bh=dCMgJit5ztRakvGnnz8cb0yJgypzeVHYeO1xe6ZE9EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Se0wAlFNecjJdOPQgr1N1c1y8TVvxpWQ1PanfuMFuaGOTBFiHL63cqozAJ1BtRRpZuWJH5VpjKk3ZliOimxCcYHzjMnZCW6X81IDq/57He2A/yYtLZl1jXAU4gQvlm9zCtA32skCv6mxDHgwRa9z/o1Y2SR3XzXRNCwGgQQgvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXVQOUbt; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e60aef2711fso4138167276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741203363; x=1741808163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7j4TYUz1ATWrlNemoGuBeGHStX0tjMRbmrIYUOKq+c=;
        b=jXVQOUbtGpdY6WLUZ5hVVxDTAKVWl1c/kHAsfXVpcEOzbi47WJvcJkHccTNWyW+2X7
         5IxZdFa1oPOKw/2bmeW7+dDKJv92MiTqPOTMY8m8PC5lCHNElpNYW46q0DQRHmeCgKsX
         S4wZ8hDq81BqZRAtmDe/2NxOpbfXUULI9xDrNeFejZp+RIJacX+o+imKr0EHyGNPLJus
         JzHTarIBf20KXGJyyp7w17QDCz8+BowB01Tek+T/OMqcZvZ3zWcdnlgys9tKrEIAMf8f
         Yg3kFYaeSU6gn/PBlQN54IXg4MoCC4CFWFhyY+mc09bAeOJ3GNnhG4jh+vk75cZk6MLr
         g0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203363; x=1741808163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7j4TYUz1ATWrlNemoGuBeGHStX0tjMRbmrIYUOKq+c=;
        b=TtU/dOclh5sXzryMi6cu7699+nylhgM9CLaZpPsW78CAvUHQtDH24CWN1j17RfCKUg
         Hqoc7mDntQpDRdFXJvEBrBfx+m+lsWrXAR9rPtFoXoL9yTzS3dSgJ2V6rw84q+z7Nzzx
         3DE6E08AFie5GN3sZRZKScaSRXSz3JCA4qKC2nAhNA4wp9llTzAEc0nKzoaBDlL5kUzI
         Hj+jncrxWjt9YevuRlmxOrqeqK8p7wyc91DyFs1Wr3rfLTzgRXPAscHY0YM+XravdSjK
         H3Bt68ymOuKkDddrRyxwUCPV+wFHD3+mwK6h/+N2wGlT27Z1StpOFxXrsdOlNELovsFm
         ii/A==
X-Forwarded-Encrypted: i=1; AJvYcCXppNtQsk+xLCXKULaW/qc2+T23a5ed/JCj0/+Mz6xWBEbDdavC4vXyB1DqRs9widRMDja4sCveB4TgpU25fjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyboV9awLqZQfBd4yhVG8joANumR2ElLd+CtbtnGduKYaF7D2J1
	7QcivpjCdK2ziVPPAbmL0AOZ9dhK6Cd0MgKU17u9VzQpeoVa6WCInEufobs98TeSL+qPQFajAsK
	WilvBrXjhky0ltH30dimgEb+iyJlPXordJCLD
X-Gm-Gg: ASbGnctjg+m8b6c/mujKOolXsiCUOMZ6yWfzja8gChrt1IXOVh4BI1NpwgyJCoQioFb
	FDHib0xFZ57T5dXDRORvVXJaYTXgLgFbbJNY0O/WDdfkKuC2mbgwHZQqRwqq4F4Psh8HFdFzZzp
	OVxNtQo3FPngsR5C7GgNueVyzfTwuD/AhktdLfZxdRzpvXQ5rR3NkrAVY=
X-Google-Smtp-Source: AGHT+IEvPOyAcjsL2RWgYwJSz3xZ1JjN9y605JD64fgEpuj1+DsSQCpfXApqeQGhC4UR0wNYkGg7VOB0kbmZ6kFv6/Y=
X-Received: by 2002:a05:6902:3210:b0:e5b:637d:f6f0 with SMTP id
 3f1490d57ef6-e611e1bae68mr5615379276.21.1741203363120; Wed, 05 Mar 2025
 11:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303133011.44095-1-kalyazin@amazon.com> <Z8YfOVYvbwlZST0J@x1.local>
In-Reply-To: <Z8YfOVYvbwlZST0J@x1.local>
From: James Houghton <jthoughton@google.com>
Date: Wed, 5 Mar 2025 11:35:27 -0800
X-Gm-Features: AQ5f1JrDW7mLkFtO0z55-PYq8YDriG8ewuUVroKEABXL5Sgdkz7qYB1ayor2JoM
Message-ID: <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
To: Peter Xu <peterx@redhat.com>
Cc: Nikita Kalyazin <kalyazin@amazon.com>, akpm@linux-foundation.org, pbonzini@redhat.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, ryan.roberts@arm.com, quic_eberman@quicinc.com, 
	graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, 
	nsaenz@amazon.es, xmarcalx@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:29=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 03, 2025 at 01:30:06PM +0000, Nikita Kalyazin wrote:
> > This series is built on top of the v3 write syscall support [1].
> >
> > With James's KVM userfault [2], it is possible to handle stage-2 faults
> > in guest_memfd in userspace.  However, KVM itself also triggers faults
> > in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> > PV EOI and page table walking code when fetching the MMIO instruction o=
n
> > x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> > that KVM would be accessing those pages via userspace page tables.  In
> > order for such faults to be handled in userspace, guest_memfd needs to
> > support userfaultfd.
> >
> > This series proposes a limited support for userfaultfd in guest_memfd:
> >  - userfaultfd support is conditional to `CONFIG_KVM_GMEM_SHARED_MEM`
> >    (as is fault support in general)
> >  - Only `page missing` event is currently supported
> >  - Userspace is supposed to respond to the event with the `write`
> >    syscall followed by `UFFDIO_CONTINUE` ioctl to unblock the faulting
> >    process.   Note that we can't use `UFFDIO_COPY` here because
> >    userfaulfd code does not know how to prepare guest_memfd pages, eg
> >    remove them from direct map [4].
> >
> > Not included in this series:
> >  - Proper interface for userfaultfd to recognise guest_memfd mappings
> >  - Proper handling of truncation cases after locking the page
> >
> > Request for comments:
> >  - Is it a sensible workflow for guest_memfd to resolve a userfault
> >    `page missing` event with `write` syscall + `UFFDIO_CONTINUE`?  One
> >    of the alternatives is teaching `UFFDIO_COPY` how to deal with
> >    guest_memfd pages.
>
> Probably not..  I don't see what protects a thread fault concurrently
> during write() happening, seeing partial data.  Since you check the page
> cache it'll let it pass, but the partial page will be faulted in there.

+1 here.

I think the simplest way to make it work would be to also check
folio_test_uptodate() in the userfaultfd_missing() check[1]. It would
pair with kvm_gmem_mark_prepared() in the write() path[2].

I'm not sure if that's the "right" way, I think it would prevent
threads from reading data as it is written.

[1]: https://lore.kernel.org/kvm/20250303133011.44095-3-kalyazin@amazon.com=
/
[2]: https://lore.kernel.org/kvm/20250303130838.28812-2-kalyazin@amazon.com=
/

> I think we may need to either go with full MISSING or full MINOR traps.

I agree, and just to clarify: you've basically implemented the MISSING
model, just using write() to resolve userfaults instead of
UFFDIO_COPY. The UFFDIO_CONTINUE implementation you have isn't really
doing much; when the page cache has a page, the fault handler will
populate the PTE for you.

I think it's probably simpler to implement the MINOR model, where
userspace can populate the page cache however it wants; write() is
perfectly fine/natural. UFFDIO_CONTINUE just needs to populate PTEs
for gmem, and the fault handler needs to check for the presence of
PTEs. The `struct vm_fault` you have should contain enough info.

> One thing to mention is we probably need MINOR sooner or later to support
> gmem huge pages.  The thing is for huge folios in gmem we can't rely on
> missing in page cache, as we always need to allocate in hugetlb sizes.
>
> >  - What is a way forward to make userfaultfd code aware of guest_memfd?
> >    I saw that Patrick hit a somewhat similar problem in [5] when trying
> >    to use direct map manipulation functions in KVM and was pointed by
> >    David at Elliot's guestmem library [6] that might include a shim for=
 that.
> >    Would the library be the right place to expose required interfaces l=
ike
> >    `vma_is_gmem`?
>
> Not sure what's the best to do, but IIUC the current way this series uses
> may not work as long as one tries to reference a kvm symbol from core mm.=
.
>
> One trick I used so far is leveraging vm_ops and provide hook function to
> report specialties when it's gmem.  In general, I did not yet dare to
> overload vm_area_struct, but I'm thinking maybe vm_ops is more possible t=
o
> be accepted.  E.g. something like this:
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5e742738240c..b068bb79fdbc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -653,8 +653,26 @@ struct vm_operations_struct {
>          */
>         struct page *(*find_special_page)(struct vm_area_struct *vma,
>                                           unsigned long addr);
> +       /*
> +        * When set, return the allowed orders bitmask in faults of mmap(=
)
> +        * ranges (e.g. for follow up huge_fault() processing).  Drivers
> +        * can use this to bypass THP setups for specific types of VMAs.
> +        */
> +       unsigned long (*get_supported_orders)(struct vm_area_struct *vma)=
;
>  };
>
> +static inline bool vma_has_supported_orders(struct vm_area_struct *vma)
> +{
> +       return vma->vm_ops && vma->vm_ops->get_supported_orders;
> +}
> +
> +static inline unsigned long vma_get_supported_orders(struct vm_area_stru=
ct *vma)
> +{
> +       if (!vma_has_supported_orders(vma))
> +               return 0;
> +       return vma->vm_ops->get_supported_orders(vma);
> +}
> +
>
> In my case I used that to allow gmem report huge page supports on faults.
>
> Said that, above only existed in my own tree so far, so I also don't know
> whether something like that could be accepted (even if it'll work for you=
).

I think it might be useful to implement an fs-generic MINOR mode. The
fault handler is already easy enough to do generically (though it
would become more difficult to determine if the "MINOR" fault is
actually a MISSING fault, but at least for my userspace, the
distinction isn't important. :)) So the question becomes: what should
UFFDIO_CONTINUE look like?

And I think it would be nice if UFFDIO_CONTINUE just called
vm_ops->fault() to get the page we want to map and then mapped it,
instead of having shmem-specific and hugetlb-specific versions (though
maybe we need to keep the hugetlb specialization...). That would avoid
putting kvm/gmem/etc. symbols in mm/userfaultfd code.

I've actually wanted to do this for a while but haven't had a good
reason to pursue it. I wonder if it can be done in a
backwards-compatible fashion...

