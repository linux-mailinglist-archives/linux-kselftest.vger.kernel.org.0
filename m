Return-Path: <linux-kselftest+bounces-42349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E32B9FFB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FCF169EAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65A29BD83;
	Thu, 25 Sep 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4q97snF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3EA29B229
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810154; cv=none; b=l1aDL8mS7YpS264gsHlzqSWmb1KVtFDtkfSAMNbGllQ11bTPZdnkQynbJP1q3XCIKR6CugFB0yZrWrhGLmey0w2zetCNw4nxx/xwCjItGZn0L9YQDp0IU2jn2eMU610vRE4F08DoM9pBIGlXTTGVFCzqxBfkhRW8dO6YVtH9urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810154; c=relaxed/simple;
	bh=D7B17HCKz9nacwG7ZH5m7J7E2r4Whs5KBEZsYzJQ9uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCOjAiHocAlDCgbOcbWqB8DosdSyDBYg3E8nyzAbry1q0Y03HVAIFocnWZi/wSysYW6Nva+nI7XO4WAcSrEbg7dWVwtIKmzjV1UZRLrrH6I1UOyEdBX1q9C4XnyS5Rng3aNQK4aHhxrkHtBa5swxI6YSEEi9BVWWxvfuzW+U15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4q97snF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54a30515cfso1610147a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758810152; x=1759414952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SblUb3K9vKSfuIkumtnWvH3DVTbw+wxBSl+ZySJr9Gg=;
        b=T4q97snFYwFV/I/rP2KGop0IKIfGS+1zuH81GX5DFJO3Qtx1vN1lWqnhoMJNLPZ/SX
         +mkLKxlLA9+gFbsZWyUN+v1/EZGqCcyejP5rC/sXixM/JkZaIILAbryD9GFy0CmLi6cE
         3LtKRPU5oj77JeTKYK/H+qJDMKHb9ZWyyrmU/rMXsvT/iCHZjLGfzUepZhkPociBvV7P
         blBdvByUFYRk7jHiqg/fICeKlTeA0btmqMoV5QJskIH3Ky8Ehc06UmfQGp7/qXlkeH8F
         bNUwcj1rc1yVtgHiTlVtPODWt/VWLxapmW8/lgb9d9Z6Nd0RqNFEpgfRerdESIG7FMU/
         wGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810152; x=1759414952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SblUb3K9vKSfuIkumtnWvH3DVTbw+wxBSl+ZySJr9Gg=;
        b=uLtLLJDkJhgJ+ula7zExRgaNcJAhGGb1kKQ562/MPyV1FX6n/caUr5dRGndKqfdB2s
         mwdd/fjl8ZVv/1qwCnfUVV0jsNoJ+HHDqkR+Hm6LjeMzRScriRfAXnR7bXXdECfHhu+w
         aT9jFRa61lFPveVoD1seJB7kV32fSKnLZTSkFmV6mgP5egAJHDlbmn+HQ/6oIfIZOJPU
         fHqQTP1Q0zSuZvje0sUBFRgF62hZ3t1Zn4LF+9802LuuRpp55tt1t/Veesx5ML5E/aDD
         G8svUCPzYq+laPGFhR+n164IcK5Y0Sm7U+/2lSfpQSD5X9turFXgjGMFPYpdqvaWJpUy
         gtsw==
X-Forwarded-Encrypted: i=1; AJvYcCXtHImvcA7GWMls89sqbtrNSrB/DK1x4TQX1VobBNJk8FuwacdxQQzul/B/KJHgZFRebhdSix4vBmL3HXPZT6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGP7nFpgp3jpzt8FQshw4ug4tA+4hqkeg03z63+dwKoVMYqSj3
	vmbdz5DvSeUDS4XEaAmjTN7tb3sTqPbjuE4sfExyLZtst0qtGTHhQjdWXuPUpRpfpf41JI4MN3F
	q2I/r9w==
X-Google-Smtp-Source: AGHT+IH/f88NvvxTkAVG4DhhjQkTxFzTBsV5SbcgowW0+JrB9EElqsyS6+jWyWSmkD83IUsL47BQyHKSocQ=
X-Received: from pjbmj16.prod.google.com ([2002:a17:90b:3690:b0:32e:c154:c2f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5107:b0:32b:a311:d1ae
 with SMTP id 98e67ed59e1d1-334567a1c56mr2743555a91.10.1758810152121; Thu, 25
 Sep 2025 07:22:32 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:22:30 -0700
In-Reply-To: <20250827175247.83322-9-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-9-shivankg@amd.com>
Message-ID: <aNVQJqYLX17v-fsf@google.com>
Subject: Re: [PATCH kvm-next V11 6/7] KVM: guest_memfd: Enforce NUMA mempolicy
 using shared policy
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Shivank Garg wrote:
> @@ -26,6 +28,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
>  	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
>  }
>  
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index);
> +
>  /**
>   * folio_file_pfn - like folio_file_page, but return a pfn.
>   * @folio: The folio which contains this index.
> @@ -112,7 +117,25 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
>  	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	struct mempolicy *policy;
> +	struct folio *folio;
> +
> +	/*
> +	 * Fast-path: See if folio is already present in mapping to avoid
> +	 * policy_lookup.
> +	 */
> +	folio = __filemap_get_folio(inode->i_mapping, index,
> +				    FGP_LOCK | FGP_ACCESSED, 0);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
> +	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
> +					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +					 mapping_gfp_mask(inode->i_mapping), policy);
> +	mpol_cond_put(policy);
> +
> +	return folio;
>  }
>  
>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -372,8 +395,45 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_NUMA
> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> +					     unsigned long addr, pgoff_t *pgoff)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
> +						   pgoff_t index)

I keep reading this is "page offset policy", as opposed to "policy given a page
offset".  Another oddity that is confusing is that this helper explicitly does
get_task_policy(current), while kvm_gmem_get_policy() lets the caller do that.
The end result is the same, but I think it would be helpful for gmem to be
internally consistent.

If we have kvm_gmem_get_policy() use this helper, then we can kill two birds with
one stone:

static struct mempolicy *__kvm_gmem_get_policy(struct gmem_inode *gi,
					       pgoff_t index)
{
	struct mempolicy *mpol;

	mpol = mpol_shared_policy_lookup(&gi->policy, index);
	return mpol ? mpol : get_task_policy(current);
}

static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
					     unsigned long addr, pgoff_t *pgoff)
{
	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);

	return __kvm_gmem_get_policy(GMEM_I(file_inode(vma->vm_file)), *pgoff);
}

