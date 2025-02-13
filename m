Return-Path: <linux-kselftest+bounces-26503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E8A3393F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59017188885D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BA20AF9F;
	Thu, 13 Feb 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7ScULWp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B120A5CF
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433168; cv=none; b=b2ArnpYcv1NVP0OgQtbh8xUcgHhLjzYgFqIKz7Gz+ZGuykAi/ffzCtn3IHLhfRVYU4LMqFsp1Bo6WMOiAAKjJyuLQ4z75f/y8Nn6ean/NAO5aP/RkaJjKLePGnbny5pIep73FCEW5w7uEAawuagQV68zFJ2N+ysLWAo/9f3ELIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433168; c=relaxed/simple;
	bh=hgpCl1lxKo/kIuxoni1SiHuSq25qQajNllEP8s/7/gQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gj03Kzv0GKziDBbGTmyXtXmHEJn87AM/ptNX+1P6rcaDGVWscfPponJUQZ9Y2lyFwbGCpfOkTtpE7LUKsZyo4ZvYAkKPAWu0+e5bGEWMzCdKZPydEt4VcNKtkWn5tRi3YFEuc09aaHFvDJpuQkoVwyiodFBB5CkbV/Iw7HtLkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7ScULWp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa6793e8b8so1540445a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739433165; x=1740037965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3fdef+uSLahSNZ8rFt65Bjz3vZBpG34zxr3rjAfeYo=;
        b=G7ScULWpBRuU3TZ3JvQhAbSeRY2ebxFPfYbi0UWr4z3lt0CPjm786oQCmTgtQdoitb
         mAfk049BU4j8hk9XkvjY6f6BCoiUBoyri7fDQN9VoTrluWtK4bKfdRoYebQIOO7e+1QJ
         0Y0c1rL21AETlfQVJeIqYKXwUBm+Exr/v8KLqVDtPpgjl8Ghj59uYb44cO8cjqTwdWuD
         9XBMGG32lE8kQ/nCkx7w19m7bhx19BYjxPdeQr0tGwMQsxAS8PKR07lcSDf4FZjKeR66
         jWU9DPOj/IJRep1+Rc8sqAkx7PfUbHt1LWtIv4giDsUYefUDPsZTmfRO4bgQ0iQuLnjh
         qcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739433165; x=1740037965;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3fdef+uSLahSNZ8rFt65Bjz3vZBpG34zxr3rjAfeYo=;
        b=sSgxFFzp8GTNoHSHlxtk8deM+K32ZdD1/CuO3H97/TVdbBsoih964EgkvkC4lrhdTi
         FcBj5n8fnKdlY6S3WGxkcJ+Q6Cri+n6m3YlLKPqZqK4ixGIU0b+/xqsx3eTbqLJjJY0+
         UWdVDTwMtVsJ99+6oE/vOvIbq9wTqQZI3w2TSzieSinTg0TgYkOydCMr/Jdv5BrcDOTv
         r0EdeHNom9vhmkri6JIKIIRDkTT8I6FBEZZa1qc9PzfaqmsscYETGMvqA5BVqyvL5kuv
         +ArQGz3CNVTEZB4U2XSI2LxzNugCI2nxtCE9qx9PCqvQ5bWVktKXUzjMwA8nBTStLNan
         1mWg==
X-Forwarded-Encrypted: i=1; AJvYcCWHuqHBV8c9jf4z1sMCA+hBMxLS/47UsiLakeeBuKoq2yqnGmGrKzopzFg7iXsYP8kji50fHCO2JJHNr1kkUPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZn3Wp3Uz1GfMYi/k9SdXHuGgs9vu/fy/RpRlfyfZfNYiu/aI
	WgFOD+sdoJbGAig68FyfnWrbw0ONlyInC1XWj7cMy1V3YMKg8auM5PTgAKkYJQoa0Ay1YP8Q2hl
	hQ0qQQSDFkEaQbvgI8SjNVg==
X-Google-Smtp-Source: AGHT+IESiBQ2QnxPu6gqE49lswYwYQOD6YLayJmOTZp5Cen+Q2e/br3WnYY0oOlxgR3gCXnEsaeI4jJPUjsup5i1Xg==
X-Received: from pfmx14.prod.google.com ([2002:a62:fb0e:0:b0:730:8854:cc56])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22d3:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-7322c591b87mr8612290b3a.9.1739433164873;
 Wed, 12 Feb 2025 23:52:44 -0800 (PST)
Date: Thu, 13 Feb 2025 07:52:43 +0000
In-Reply-To: <Z0yjGA25b8TfLMnd@x1n> (message from Peter Xu on Sun, 1 Dec 2024
 12:55:36 -0500)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz8qqa9t84.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
From: Ackerley Tng <ackerleytng@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 10, 2024 at 11:43:46PM +0000, Ackerley Tng wrote:
>> +static struct folio *kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
>> +						  struct hugepage_subpool *spool)
>> +{
>> +	bool memcg_charge_was_prepared;
>> +	struct mem_cgroup *memcg;
>> +	struct mempolicy *mpol;
>> +	nodemask_t *nodemask;
>> +	struct folio *folio;
>> +	gfp_t gfp_mask;
>> +	int ret;
>> +	int nid;
>> +
>> +	gfp_mask = htlb_alloc_mask(h);
>> +
>> +	memcg = get_mem_cgroup_from_current();
>> +	ret = mem_cgroup_hugetlb_try_charge(memcg,
>> +					    gfp_mask | __GFP_RETRY_MAYFAIL,
>> +					    pages_per_huge_page(h));
>> +	if (ret == -ENOMEM)
>> +		goto err;
>> +
>> +	memcg_charge_was_prepared = ret != -EOPNOTSUPP;
>> +
>> +	/* Pages are only to be taken from guest_memfd subpool and nowhere else. */
>> +	if (hugepage_subpool_get_pages(spool, 1))
>> +		goto err_cancel_charge;
>> +
>> +	nid = kvm_gmem_get_mpol_node_nodemask(htlb_alloc_mask(h), &mpol,
>> +					      &nodemask);
>> +	/*
>> +	 * charge_cgroup_reservation is false because we didn't make any cgroup
>> +	 * reservations when creating the guest_memfd subpool.
>
> Hmm.. isn't this the exact reason to set charge_cgroup_reservation==true
> instead?
>
> IIUC gmem hugetlb pages should participate in the hugetlb cgroup resv
> charge as well.  It is already involved in the rest cgroup charges, and I
> wonder whether it's intended that the patch treated the resv accounting
> specially.
>
> Thanks,
>

Thank you for your careful reviews!

I misunderstood charging a cgroup for hugetlb reservations when I was
working on this patch.

Before this, I thought hugetlb_cgroup_charge_cgroup_rsvd() was only for
resv_map reservations, so I set charge_cgroup_reservation to false since
guest_memfd didn't use resv_map, but I understand better now. Please
help me check my understanding:

+ All reservations are made at the hstate
+ In addition, every reservation is associated with a subpool (through
  spool->rsv_hpages) or recorded in a resv_map
    + Reservations are either in a subpool or in a resv_map but not both
+ hugetlb_cgroup_charge_cgroup_rsvd() is for any reservation

Regarding the time that a cgroup is charged for reservations:

+ If a reservation is made during subpool creation, the cgroup is not
  charged during the reservation by the subpool, probably by design
  since the process doing the mount may not be the process using the
  pages
+ Charging a cgroup for the reservation happens in
  hugetlb_reserve_pages(), which is called at mmap() time.

For guest_memfd, I see two options:

Option 1: Charge cgroup for reservations at fault time

Pros:

+ Similar in behavior to a fd on a hugetlbfs mount, where the cgroup of
  the process calling fallocate() is charged for the reservation.
+ Symmetric approach, since uncharging happens when the hugetlb folio is
  freed.

Cons:

+ Room for allocation failure after guest_memfd creation. Even though
  this guest_memfd had been created with a subpool and pages have been
  reserved, there is a chance of hitting the cgroup's hugetlb
  reservation cap and failing to allocate a page.

Option 2 (preferred): Charge cgroup for reservations at guest_memfd
creation time

Pros:

+ Once guest_memfd file is created, a page is guaranteed at fault time.
+ Simplifies/doesn't carry over the complexities of the hugetlb(fs)
  reservation system

Cons:

+ The cgroup being charged is the cgroup of the process creating
  guest_memfd, which might be an issue if users expect the process
  faulting the page to be charged.

Implementation:

+ At guest_memfd creation time, when creating the subpool, charge the
  cgroups for everything:
   + for hugetlb usage
   + hugetlb reservation usage and
   + hugetlb usage by page count (as in mem_cgroup_charge_hugetlb(),
     which is new since [1])
+ Refactoring in [1] would be focused on just dequeueing a folio or
  failing which, allocating a surplus folio.
   + After allocation, don't set cgroup on the folio so that the freeing
     process doesn't uncharge anything
+ Uncharge when the file is closed

Please let me know if anyone has any thoughts/suggestions!

>> +	 *
>> +	 * use_hstate_resv is true because we reserved from global hstate when
>> +	 * creating the guest_memfd subpool.
>> +	 */
>> +	folio = hugetlb_alloc_folio(h, mpol, nid, nodemask, false, true);
>> +	mpol_cond_put(mpol);
>> +
>> +	if (!folio)
>> +		goto err_put_pages;
>> +
>> +	hugetlb_set_folio_subpool(folio, spool);
>> +
>> +	if (memcg_charge_was_prepared)
>> +		mem_cgroup_commit_charge(folio, memcg);
>> +
>> +out:
>> +	mem_cgroup_put(memcg);
>> +
>> +	return folio;
>> +
>> +err_put_pages:
>> +	hugepage_subpool_put_pages(spool, 1);
>> +
>> +err_cancel_charge:
>> +	if (memcg_charge_was_prepared)
>> +		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
>> +
>> +err:
>> +	folio = ERR_PTR(-ENOMEM);
>> +	goto out;
>> +}

[1] https://lore.kernel.org/all/7348091f4c539ed207d9bb0f3744d0f0efb7f2b3.1726009989.git.ackerleytng@google.com/

