Return-Path: <linux-kselftest+bounces-18049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAB897A80B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE7C286325
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CF15921D;
	Mon, 16 Sep 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HbLcQeEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D91332A1;
	Mon, 16 Sep 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516906; cv=none; b=k98auruHZ8LxnFRRiXVjp5w18gS/HQd/gmxqz0a75pBXdtcLWqOYR54EaMm2hdgkkWCSNpv5KDvRDS+eW4yVcWE9Ws1xwo6p19/sjMNAFHdF+mBSIfnwg5rem1p+hYw7H87L4K6AUXEY2gjT20KZw8VYrZ0Qx+CVDoSiNCaxIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516906; c=relaxed/simple;
	bh=Sf+Hn132fza0R0vtqH1OQGCq1kXlKEVpDBbwxp1eT+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6b0Tx8BilgLGk6lda0rj9uTUtyUgqDaTjY3nFM3g/BM4T1esE4DZjiXaPfs9omiHnuW66YAjxIG7PjK7Mqe2wTANIHBFscCJDCzqr1OyG/ycpxyjL5MB+T9DQkFsbZ14yygsLX3YTLjNLVHfi4GBLU5nYJlzQVwP63iEFdEmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HbLcQeEo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDfEBn010049;
	Mon, 16 Sep 2024 20:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6a4Rc1uDD13K09q2r/9hzOt+
	olsP8onR0t5S2DFb6Tg=; b=HbLcQeEoysyR2X1zA0MrWO+S4Cx/x+Qbk1qDNzON
	5bgjrGCnqjY7Nc4dW7tG44dwVcg4/g/KO+PeYBQhK68SNoKrMhLJaSOhockKG+s1
	t3ZoQ8NtIaE284v9smJFRWPx2VCdZXDqKCp/TpEbB/MAsH91nGLcWsvsqONknApX
	lUewp4a8MDn5rSpakMP4OLe+ne2FL9L0bROW83ZbKgzeFO7cuJaJclc1emnbKc5S
	Z01shC8sgRl9bIT6+9wuazDiVvhM4PK+9PbpC4la96AwnBU9jCqbRH8Br3j2VXOH
	DpigjyQUG9braJNJuMGI5gbTnC/QEswp9JZQ7Ik3nICTEw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdn42g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 20:01:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GK0v6f032508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 20:00:57 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Sep 2024 13:00:56 -0700
Date: Mon, 16 Sep 2024 13:00:56 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
        <peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
        <fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
        <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
        <muchun.song@linux.dev>, <mike.kravetz@oracle.com>,
        <erdemaktas@google.com>, <vannapurve@google.com>, <qperret@google.com>,
        <jhubbard@nvidia.com>, <willy@infradead.org>, <shuah@kernel.org>,
        <brauner@kernel.org>, <bfoster@redhat.com>,
        <kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
        <richard.weiyang@gmail.com>, <anup@brainfault.org>,
        <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
        <vkuznets@redhat.com>, <maciej.wieczor-retman@intel.com>,
        <pgonda@google.com>, <oliver.upton@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-fsdevel@kvack.org>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
Message-ID: <20240916120939512-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <24cf7a9b1ee499c4ca4da76e9945429072014d1e.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <24cf7a9b1ee499c4ca4da76e9945429072014d1e.1726009989.git.ackerleytng@google.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VtC6e3CZiXM64-CbxbBhxJzIwiUeMQt5
X-Proofpoint-GUID: VtC6e3CZiXM64-CbxbBhxJzIwiUeMQt5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160136

On Tue, Sep 10, 2024 at 11:44:01PM +0000, Ackerley Tng wrote:
> Since guest_memfd now supports mmap(), folios have to be prepared
> before they are faulted into userspace.
> 
> When memory attributes are switched between shared and private, the
> up-to-date flags will be cleared.
> 
> Use the folio's up-to-date flag to indicate being ready for the guest
> usage and can be used to mark whether the folio is ready for shared OR
> private use.

Clearing the up-to-date flag also means that the page gets zero'd out
whenever it transitions between shared and private (either direction).
pKVM (Android) hypervisor policy can allow in-place conversion between
shared/private.

I believe the important thing is that sev_gmem_prepare() needs to be
called prior to giving page to guest. In my series, I had made a
->prepare_inaccessible() callback where KVM would only do this part.
When transitioning to inaccessible, only that callback would be made,
besides the bookkeeping. The folio zeroing happens once when allocating
the folio if the folio is initially accessible (faultable).

From x86 CoCo perspective, I think it also makes sense to not zero
the folio when changing faultiblity from private to shared:
 - If guest is sharing some data with host, you've wiped the data and
   guest has to copy again.
 - Or, if SEV/TDX enforces that page is zero'd between transitions,
   Linux has duplicated the work that trusted entity has already done.

Fuad and I can help add some details for the conversion. Hopefully we
can figure out some of the plan at plumbers this week.

Thanks,
Elliot

> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> ---
>  virt/kvm/guest_memfd.c | 131 ++++++++++++++++++++++++++++++++++++++++-
>  virt/kvm/kvm_main.c    |   2 +
>  virt/kvm/kvm_mm.h      |   7 +++
>  3 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 110c4bbb004b..fb292e542381 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -129,13 +129,29 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>  }
>  
>  /**
> - * Use the uptodate flag to indicate that the folio is prepared for KVM's usage.
> + * Use folio's up-to-date flag to indicate that this folio is prepared for usage
> + * by the guest.
> + *
> + * This flag can be used whether the folio is prepared for PRIVATE or SHARED
> + * usage.
>   */
>  static inline void kvm_gmem_mark_prepared(struct folio *folio)
>  {
>  	folio_mark_uptodate(folio);
>  }
>  
> +/**
> + * Use folio's up-to-date flag to indicate that this folio is not yet prepared for
> + * usage by the guest.
> + *
> + * This flag can be used whether the folio is prepared for PRIVATE or SHARED
> + * usage.
> + */
> +static inline void kvm_gmem_clear_prepared(struct folio *folio)
> +{
> +	folio_clear_uptodate(folio);
> +}
> +
>  /*
>   * Process @folio, which contains @gfn, so that the guest can use it.
>   * The folio must be locked and the gfn must be contained in @slot.
> @@ -148,6 +164,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	pgoff_t index;
>  	int r;
>  
> +	/*
> +	 * Defensively zero folio to avoid leaking kernel memory in
> +	 * uninitialized pages. This is important since pages can now be mapped
> +	 * into userspace, where hardware (e.g. TDX) won't be clearing those
> +	 * pages.
> +	 */
>  	if (folio_test_hugetlb(folio)) {
>  		folio_zero_user(folio, folio->index << PAGE_SHIFT);
>  	} else {
> @@ -1017,6 +1039,7 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>  {
>  	struct inode *inode;
>  	struct folio *folio;
> +	bool is_prepared;
>  
>  	inode = file_inode(vmf->vma->vm_file);
>  	if (!kvm_gmem_is_faultable(inode, vmf->pgoff))
> @@ -1026,6 +1049,31 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>  	if (!folio)
>  		return VM_FAULT_SIGBUS;
>  
> +	is_prepared = folio_test_uptodate(folio);
> +	if (!is_prepared) {
> +		unsigned long nr_pages;
> +		unsigned long i;
> +
> +		if (folio_test_hugetlb(folio)) {
> +			folio_zero_user(folio, folio->index << PAGE_SHIFT);
> +		} else {
> +			/*
> +			 * Defensively zero folio to avoid leaking kernel memory in
> +			 * uninitialized pages. This is important since pages can now be
> +			 * mapped into userspace, where hardware (e.g. TDX) won't be
> +			 * clearing those pages.
> +			 *
> +			 * Will probably need a version of kvm_gmem_prepare_folio() to
> +			 * prepare the page for SHARED use.
> +			 */
> +			nr_pages = folio_nr_pages(folio);
> +			for (i = 0; i < nr_pages; i++)
> +				clear_highpage(folio_page(folio, i));
> +		}
> +
> +		kvm_gmem_mark_prepared(folio);
> +	}
> +
>  	vmf->page = folio_file_page(folio, vmf->pgoff);
>  	return VM_FAULT_LOCKED;
>  }
> @@ -1593,6 +1641,87 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
>  }
>  EXPORT_SYMBOL_GPL(kvm_gmem_populate);
>  
> +static void kvm_gmem_clear_prepared_range(struct inode *inode, pgoff_t start,
> +					  pgoff_t end)
> +{
> +	pgoff_t index;
> +
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +
> +	/* TODO: replace iteration with filemap_get_folios() for efficiency. */
> +	for (index = start; index < end;) {
> +		struct folio *folio;
> +
> +		/* Don't use kvm_gmem_get_folio to avoid allocating */
> +		folio = filemap_lock_folio(inode->i_mapping, index);
> +		if (IS_ERR(folio)) {
> +			++index;
> +			continue;
> +		}
> +
> +		kvm_gmem_clear_prepared(folio);
> +
> +		index = folio_next_index(folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
> +}
> +
> +/**
> + * Clear the prepared flag for all folios in gfn range [@start, @end) in memslot
> + * @slot.
> + */
> +static void kvm_gmem_clear_prepared_slot(struct kvm_memory_slot *slot, gfn_t start,
> +					 gfn_t end)
> +{
> +	pgoff_t start_offset;
> +	pgoff_t end_offset;
> +	struct file *file;
> +
> +	file = kvm_gmem_get_file(slot);
> +	if (!file)
> +		return;
> +
> +	start_offset = start - slot->base_gfn + slot->gmem.pgoff;
> +	end_offset = end - slot->base_gfn + slot->gmem.pgoff;
> +
> +	kvm_gmem_clear_prepared_range(file_inode(file), start_offset, end_offset);
> +
> +	fput(file);
> +}
> +
> +/**
> + * Clear the prepared flag for all folios for any slot in gfn range
> + * [@start, @end) in @kvm.
> + */
> +void kvm_gmem_clear_prepared_vm(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +	int i;
> +
> +	lockdep_assert_held(&kvm->slots_lock);
> +
> +	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> +		struct kvm_memslot_iter iter;
> +		struct kvm_memslots *slots;
> +
> +		slots = __kvm_memslots(kvm, i);
> +		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
> +			struct kvm_memory_slot *slot;
> +			gfn_t gfn_start;
> +			gfn_t gfn_end;
> +
> +			slot = iter.slot;
> +			gfn_start = max(start, slot->base_gfn);
> +			gfn_end = min(end, slot->base_gfn + slot->npages);
> +
> +			if (iter.slot->flags & KVM_MEM_GUEST_MEMFD)
> +				kvm_gmem_clear_prepared_slot(iter.slot, gfn_start, gfn_end);
> +		}
> +	}
> +}
> +
>  /**
>   * Returns true if pages in range [@start, @end) in inode @inode have no
>   * userspace mappings.
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1a7bbcc31b7e..255d27df7f5c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2565,6 +2565,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		KVM_BUG_ON(r, kvm);
>  	}
>  
> +	kvm_gmem_clear_prepared_vm(kvm, start, end);
> +
>  	kvm_handle_gfn_range(kvm, &post_set_range);
>  
>  out_unlock:
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index d8ff2b380d0e..25fd0d9f66cc 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -43,6 +43,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
>  int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  				   unsigned long attrs);
> +void kvm_gmem_clear_prepared_vm(struct kvm *kvm, gfn_t start, gfn_t end);
>  #else
>  static inline void kvm_gmem_init(struct module *module)
>  {
> @@ -68,6 +69,12 @@ static inline int kvm_gmem_should_set_attributes(struct kvm *kvm, gfn_t start,
>  	return 0;
>  }
>  
> +static inline void kvm_gmem_clear_prepared_slots(struct kvm *kvm,
> +						 gfn_t start, gfn_t end)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +
>  #endif /* CONFIG_KVM_PRIVATE_MEM */
>  
>  #endif /* __KVM_MM_H__ */
> -- 
> 2.46.0.598.g6f2099f65c-goog
> 

