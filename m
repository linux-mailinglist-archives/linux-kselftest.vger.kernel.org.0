Return-Path: <linux-kselftest+bounces-26564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278CA34B26
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BC23A83B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422E23A9BC;
	Thu, 13 Feb 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtAHrHnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313231FDA76
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465348; cv=none; b=rI3i2snr7Wo8z7HSRYSlxBv0qPyYHMlVJ0qK/bYifZUvhQ5hCCH5cT4Sn708m/+9sBcblv9vRjCN01U1kyEu7TERnAtMQCpK//SI0qNzjvikHiiYg2Vk1oukUH0btIPVLTqKu0b1tazVnTV4VbFrSxWQj8dgi46vCjHCkEep2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465348; c=relaxed/simple;
	bh=stjsMCoXmAOuqNoWr54apqYrZ9Lu1dlfD+lCCAbl6FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SToSK3jq7Irpnf2vQ0Bc7x7Sv5ikmclSzUuRkJrBJYC00/dUt84jFwLYuL3+5+fqH/tL8G9IdsmpDsGwapDHRu+bMBLiwI+5w2u9cBL/yXStUPtXSRjH8RqIdcIBalgL9TXlyz4gqZyRw3nT7p6QITb+5Jgh1mbIuyc5YH3CZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtAHrHnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739465344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JROJFeKJG/7QhErL5KNFi8pxb9777JdDet+vnroXIfk=;
	b=NtAHrHntTNMphsDEW3LhcvhZBirzUeikoHjM4kqEyMjMJf2yAy2X3PQkwtgS1rj2JsiAtg
	Kn9OqwoLTSO0oAGtdYyQjhSaiJgc7Mx89IssUDiJH0tWZTa+DMgLIeINZRl7JW9QJ1jvhH
	IVONRvpVzQ9BXajzi8vIPqulG2b1gYM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-szve13OsNrC4SATVl-dH8A-1; Thu, 13 Feb 2025 11:49:02 -0500
X-MC-Unique: szve13OsNrC4SATVl-dH8A-1
X-Mimecast-MFC-AGG-ID: szve13OsNrC4SATVl-dH8A_1739465342
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47197ef01dcso11334011cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 08:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465342; x=1740070142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JROJFeKJG/7QhErL5KNFi8pxb9777JdDet+vnroXIfk=;
        b=VzsFibPVa+AA8kmhpafoamA8Lsr9sDgGl/BSFl+yQp+KOI93zl7eSKlwiEaKtEFJiP
         ERPOLC7F62Q4zPzVGwrrSS5RtLow6BiMmLo9u+kq887XfokMIj0cdVFNpq5MYKuZO18P
         dkB7hSqrx107OXihl/djaH/xBFNjzvA4EeJVAeyo1CyU3WeqaH2k61/LYTaHGeEAWHXC
         eJWac2uUXh50DzhSHSkZWXvZbddA+wXVUZ+cTVSnhn3pOBksyDsaVtIhMi59PGezOAUz
         64L1Hv5dVo10HSYE7R3vQ4tDI8S3iZPvneGE259a2QxoZE/IH/2CEvcdU1R/L9CIaCL7
         G9vw==
X-Forwarded-Encrypted: i=1; AJvYcCWkiUplVVsFH7Oi0T8eWcoXCbhWp6LCLUNK+xXwvTea9ABIKvIX46OesTc+c5qPeCxMzi+FCSRAMGrV4vtePQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17RBevTvA5vO0vpDMnWV1LiCxAYvzcUMvzTRl9IUJtIVWOO7E
	XJbDG+q4ONWLZX5IomSSNbdHyZuYGSgWnvuxAtnNgwH76lEGxee5BYaz7sSTO89XiHuhmleeUMB
	M+v+q+jUAj4Ohs5CYxzfIe3kgzrHNOfBqSrsNIcknT6uUx6ggFc7RP1uyORl/wZAlgg==
X-Gm-Gg: ASbGncv9ZsI9rWGSE7CkIVVTDUaguzOcnlOCE1EPtRXdhxvvaVkw7YDETDppNUmmn/Z
	CdVRcRwnD56kmAg6UDoQzUtHsjwgh5JVZP31y/8hepFw34PO0w6t4OPNd/Tw8ixa0dHXiOkqQod
	XxO/4uMMNLUxfEhH0MRrFjr/b4fxQ9oipM7TY2SO6f5/lE5sNiPfa6Q34F7YfSSLuheCKG3vITO
	DVoV3TyVPQxtGcF8N6ktF4+WZpwetYauzMeGxHDB9jsedUPu19iqblV2WQ=
X-Received: by 2002:a05:622a:19a7:b0:471:97ef:28c2 with SMTP id d75a77b69052e-471bee88bf9mr76398601cf.50.1739465341921;
        Thu, 13 Feb 2025 08:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH90wp0Io4FsbD9Y9r1xlzUmOh6kR8o9MWqYgVTnqP+eNEwiXXiw94ZJu2zck2E6XolQdT0w==
X-Received: by 2002:a05:622a:19a7:b0:471:97ef:28c2 with SMTP id d75a77b69052e-471bee88bf9mr76397931cf.50.1739465341491;
        Thu, 13 Feb 2025 08:49:01 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af36f2sm9540111cf.54.2025.02.13.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:49:00 -0800 (PST)
Date: Thu, 13 Feb 2025 11:48:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
Message-ID: <Z64ieVfqTL2Wtqa5@x1.local>
References: <Z0yjGA25b8TfLMnd@x1n>
 <diqz8qqa9t84.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <diqz8qqa9t84.fsf@ackerleytng-ctop.c.googlers.com>

On Thu, Feb 13, 2025 at 07:52:43AM +0000, Ackerley Tng wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Sep 10, 2024 at 11:43:46PM +0000, Ackerley Tng wrote:
> >> +static struct folio *kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
> >> +						  struct hugepage_subpool *spool)
> >> +{
> >> +	bool memcg_charge_was_prepared;
> >> +	struct mem_cgroup *memcg;
> >> +	struct mempolicy *mpol;
> >> +	nodemask_t *nodemask;
> >> +	struct folio *folio;
> >> +	gfp_t gfp_mask;
> >> +	int ret;
> >> +	int nid;
> >> +
> >> +	gfp_mask = htlb_alloc_mask(h);
> >> +
> >> +	memcg = get_mem_cgroup_from_current();
> >> +	ret = mem_cgroup_hugetlb_try_charge(memcg,
> >> +					    gfp_mask | __GFP_RETRY_MAYFAIL,
> >> +					    pages_per_huge_page(h));
> >> +	if (ret == -ENOMEM)
> >> +		goto err;
> >> +
> >> +	memcg_charge_was_prepared = ret != -EOPNOTSUPP;
> >> +
> >> +	/* Pages are only to be taken from guest_memfd subpool and nowhere else. */
> >> +	if (hugepage_subpool_get_pages(spool, 1))
> >> +		goto err_cancel_charge;
> >> +
> >> +	nid = kvm_gmem_get_mpol_node_nodemask(htlb_alloc_mask(h), &mpol,
> >> +					      &nodemask);
> >> +	/*
> >> +	 * charge_cgroup_reservation is false because we didn't make any cgroup
> >> +	 * reservations when creating the guest_memfd subpool.
> >
> > Hmm.. isn't this the exact reason to set charge_cgroup_reservation==true
> > instead?
> >
> > IIUC gmem hugetlb pages should participate in the hugetlb cgroup resv
> > charge as well.  It is already involved in the rest cgroup charges, and I
> > wonder whether it's intended that the patch treated the resv accounting
> > specially.
> >
> > Thanks,
> >
> 
> Thank you for your careful reviews!
> 
> I misunderstood charging a cgroup for hugetlb reservations when I was
> working on this patch.
> 
> Before this, I thought hugetlb_cgroup_charge_cgroup_rsvd() was only for
> resv_map reservations, so I set charge_cgroup_reservation to false since
> guest_memfd didn't use resv_map, but I understand better now. Please
> help me check my understanding:
> 
> + All reservations are made at the hstate
> + In addition, every reservation is associated with a subpool (through
>   spool->rsv_hpages) or recorded in a resv_map
>     + Reservations are either in a subpool or in a resv_map but not both
> + hugetlb_cgroup_charge_cgroup_rsvd() is for any reservation
> 
> Regarding the time that a cgroup is charged for reservations:
> 
> + If a reservation is made during subpool creation, the cgroup is not
>   charged during the reservation by the subpool, probably by design
>   since the process doing the mount may not be the process using the
>   pages

Exactly.

> + Charging a cgroup for the reservation happens in
>   hugetlb_reserve_pages(), which is called at mmap() time.

Yes, or if it's not charged in hugetlb_reserve_pages() it needs to be
charged at folio allocation as of now.

> 
> For guest_memfd, I see two options:
> 
> Option 1: Charge cgroup for reservations at fault time
> 
> Pros:
> 
> + Similar in behavior to a fd on a hugetlbfs mount, where the cgroup of
>   the process calling fallocate() is charged for the reservation.
> + Symmetric approach, since uncharging happens when the hugetlb folio is
>   freed.
> 
> Cons:
> 
> + Room for allocation failure after guest_memfd creation. Even though
>   this guest_memfd had been created with a subpool and pages have been
>   reserved, there is a chance of hitting the cgroup's hugetlb
>   reservation cap and failing to allocate a page.
> 
> Option 2 (preferred): Charge cgroup for reservations at guest_memfd
> creation time
> 
> Pros:
> 
> + Once guest_memfd file is created, a page is guaranteed at fault time.

This would definitely be nice, that whatever that can block the guest from
using the memory should be a fault upfront when a VM boots if ever possible
(e.g. this is not a mmap() interface, so user yet doesn't allow NORESERVE).

It'll be slightly different from the spool use case of mount points, but I
think it's a new use case anyway, so IIUC we can define its behavior to
best suite the use case.

> + Simplifies/doesn't carry over the complexities of the hugetlb(fs)
>   reservation system
> 
> Cons:
> 
> + The cgroup being charged is the cgroup of the process creating
>   guest_memfd, which might be an issue if users expect the process
>   faulting the page to be charged.

Right, though I can't picture such use case yet.

I'm guessing multiple processes use of guest-memfd is still very far away.
When it happens, I would expect these tasks be put into the same cgroup..
Maybe kubevirt already have some of such use, I can go and have a check.

If they're not in the same cgroup, it's still more reasonable to always
charge that at the VM instance, rather than whatever other process that may
operate on the guest memory.

So it could be that we don't see major cons in solution 2.  In general, I
agree with your preference.

> 
> Implementation:
> 
> + At guest_memfd creation time, when creating the subpool, charge the
>   cgroups for everything:
>    + for hugetlb usage

I suppose here you meant the global reservation?  If so, I agree.

IIUC the new code shouldn't need to worry on this if the subpool is created
by the API, as that API does the global charging, like we discussed
elsewhere.

If you meant hugetlb_cgroup_commit_charge(),IMHO it should still be left
done until allocation.  In guest-memfd case, when fallocate().  AFAICT,
that's the only reason why we need two of such anyway..

>    + hugetlb reservation usage and

Agree on this one.

>    + hugetlb usage by page count (as in mem_cgroup_charge_hugetlb(),
>      which is new since [1])

This one should, IMHO, also be done only during allocation.

Thanks,

> + Refactoring in [1] would be focused on just dequeueing a folio or
>   failing which, allocating a surplus folio.
>    + After allocation, don't set cgroup on the folio so that the freeing
>      process doesn't uncharge anything
> + Uncharge when the file is closed
> 
> Please let me know if anyone has any thoughts/suggestions!
> 
> >> +	 *
> >> +	 * use_hstate_resv is true because we reserved from global hstate when
> >> +	 * creating the guest_memfd subpool.
> >> +	 */
> >> +	folio = hugetlb_alloc_folio(h, mpol, nid, nodemask, false, true);
> >> +	mpol_cond_put(mpol);
> >> +
> >> +	if (!folio)
> >> +		goto err_put_pages;
> >> +
> >> +	hugetlb_set_folio_subpool(folio, spool);
> >> +
> >> +	if (memcg_charge_was_prepared)
> >> +		mem_cgroup_commit_charge(folio, memcg);
> >> +
> >> +out:
> >> +	mem_cgroup_put(memcg);
> >> +
> >> +	return folio;
> >> +
> >> +err_put_pages:
> >> +	hugepage_subpool_put_pages(spool, 1);
> >> +
> >> +err_cancel_charge:
> >> +	if (memcg_charge_was_prepared)
> >> +		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
> >> +
> >> +err:
> >> +	folio = ERR_PTR(-ENOMEM);
> >> +	goto out;
> >> +}
> 
> [1] https://lore.kernel.org/all/7348091f4c539ed207d9bb0f3744d0f0efb7f2b3.1726009989.git.ackerleytng@google.com/
> 

-- 
Peter Xu


