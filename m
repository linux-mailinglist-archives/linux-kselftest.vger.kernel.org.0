Return-Path: <linux-kselftest+bounces-49063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB2D28CA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F170530119FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D431A7E4;
	Thu, 15 Jan 2026 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFIdjlpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B9322C77
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513374; cv=none; b=e0TDQEwamEphZFIrOyF8j+oh4laCfXao4o7S3YguStt0l+O/FpOgZfwGJ+cW8PSReg/GfRCNBpxqK/WSM53dBqxZIWq1tRVsoQVoRJiipmEK9Hxl48EuRws2lSBd1mnwESwaxxY89tTxsyKfuAHg5K04lDo+M9lhF6aFtHobK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513374; c=relaxed/simple;
	bh=MX9OHFQtZsvIMUfqCbOvy5R7uP+/yaS8gtSlw1jAtO4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE5cZDmn5qrogqFJQNODjR2Yr4JFkVO7TbHMAOd8R3IXqQVOQfdbsfLgqf/shTwD9mG0PPhxMPpXpDFwjH0PLtdM2M1HZNHX/bF6ljgQksYOO6dODBrheT+QpRzwN2kp8OMG70KQraQHd8/WwQZt2DkF/1Xm18Iru0Fq1sVR4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFIdjlpe; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5636bf70eb6so452291e0c.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 13:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768513371; x=1769118171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CRW9L/9HA/1Bpy1MjTpDe5h57ZTPcwDUOwqt2sU0Wb8=;
        b=sFIdjlpexo+gDU2DbcZllOjAoKrL2T8eyYM/3uRsra4oC15rMnyIfjuHZZTZ7mB9Ql
         cGZHrIETEIhxk393rU6dWliRLI0uzFt2eFy+g5YuyWiCra2ft4ugR0+UlUHP+K8IljQn
         cuok9E1YhM8b8rs3gKcMx9RLZixutKUx/mt9MPYlKmS/DcQ6359o+NRwfRQvzaYmfoX5
         +Yz2lKhZzA5DuLou1My5Ha7vG5+X4oSmLgRyh0JUjsdlZs/18S1Vu0Q6jMGZjZBh/YsB
         aZVHdJ4K2lgqU/QE1fir2fMYR+bhDmKN6OR5/of8/Q4VAj6K5TnPsFVE6394EfrSUJWU
         55oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513371; x=1769118171;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRW9L/9HA/1Bpy1MjTpDe5h57ZTPcwDUOwqt2sU0Wb8=;
        b=cp5VXUE1+f2xcN4I00OQXETLfOkkVURKBw1h4fN+7hm/FbKw4xzLPFSR0jOzISx1dI
         ZG/CZDlmhgdwLvk3n7W+4dVsrXKfunvFOjDmjxD6/I+VaL6fBpRO6bkHrnxdK8BVPl85
         pr+kR0EOM0ASNy12D1BrKAQEZpIymJvmBjZNiCOeeqSQbRtAqYprtHXyaxngTsHNgA1s
         x2eiBhLBa94sEHStOsscHL4rlVv+EgUX4Iu420tFu3a9uIIeY43NgBaWgn6FULJdvUcD
         QWhRyMPHAKQlVg+nO4LI/xXzn/bADp5xlqwwV/EZ+bWhmEwFIHHYCfwvp/czUSomyflp
         KPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJVgQCGaSWP0P8Kn6jn2BM5E6jQNArFWBzuqGNRU+7k7uNpTs0cKJSeu2GcmSWRRyat11xTcvF90SlEC3Keh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLH7ZNSA0uv72kKVbORZxLdD3rr1Crtrp72EZ2T+I/DXH60F9
	JzH5XhsxdF5ZN/a8OTJyZvcLDqeE/j1nAQs+C28Sh2Ddb6Lt26o3S/EaxjfGS+cO5U/VQM+6snk
	CjWizeKcEDEvTf6xbeh1sXPzE5DJAsEocykQus2Wr
X-Gm-Gg: AY/fxX78S9gXKPhRdTteiufB7nxJb2S2s/Ebd+LgWfuSjUaCXP0wz5faDeA7xL7iMX9
	JcY1ZkFfpQoVOiNnNw/rsmb/o18c9JJ/knRLLiOkCvdwo0F04E6+fmJOOU5BFsQuwKQ9T6MPL/N
	B8anJUwLcpR9TQox8obAIoDkJV6Qi8fAU+wTS9QRic/zV+KPFytVLr3GcQDlTWIvhxwtHd9BSpJ
	nLEoiW1woNfSlFEyZaOVARxvHT+ZckkwNvf27rzrIkk53yCNhY7nZtxwRp3k+ouAMpnYb17N8Ft
	jkDgyYPLoOa/ui6m1pEVoqHBby19NG2YglPC
X-Received: by 2002:a05:6102:cc6:b0:5db:20ea:2329 with SMTP id
 ada2fe7eead31-5f1a55a32demr371875137.35.1768513369890; Thu, 15 Jan 2026
 13:42:49 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:42:48 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 13:42:48 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260114134510.1835-4-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com> <20260114134510.1835-4-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2026 13:42:48 -0800
X-Gm-Features: AZwV_Qjy0HC7gblz7T2Mj2ciHvpfRgcw_pe8yM4xzbPDNZpWuI6Qc22FzNRUu1Q
Message-ID: <CAEvNRgF-61VROyB0zG4Gyky_+Pks0wJBX0Uv_ysLGZCw3H8LNQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/13] mm: introduce AS_NO_DIRECT_MAP
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>, 
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>, 
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Patrick Roy <patrick.roy@linux.dev>
>
> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
> set to not present. Currently, mappings that match this description are
> secretmem mappings (memfd_secret()). Later, some guest_memfd
> configurations will also fall into this category.
>
> Reject this new type of mappings in all locations that currently reject
> secretmem mappings, on the assumption that if secretmem mappings are
> rejected somewhere, it is precisely because of an inability to deal with
> folios without direct map entries, and then make memfd_secret() use
> AS_NO_DIRECT_MAP on its address_space to drop its special
> vma_is_secretmem()/secretmem_mapping() checks.
>
> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
> set by guest_memfd) because not all guest_memfd mappings will end up
> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
> can be mapped to userspace should also be GUP-able, and generally not
> have restrictions on who can access it).
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/pagemap.h   | 16 ++++++++++++++++
>  include/linux/secretmem.h | 18 ------------------
>  lib/buildid.c             |  4 ++--
>  mm/gup.c                  | 10 +++++-----
>  mm/mlock.c                |  2 +-
>  mm/secretmem.c            |  8 ++------
>  6 files changed, 26 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..6ce7301d474a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
>  	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>  				   account usage to user cgroups */
> +	AS_NO_DIRECT_MAP = 11,	/* Folios in the mapping are not in the direct map */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS = 5,
>  	AS_FOLIO_ORDER_MIN = 16,
> @@ -345,6 +346,21 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>
> +static inline void mapping_set_no_direct_map(struct address_space *mapping)
> +{
> +	set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> +}
> +
> +static inline bool mapping_no_direct_map(const struct address_space *mapping)
> +{
> +	return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
> +}
> +
> +static inline bool vma_has_no_direct_map(const struct vm_area_struct *vma)
> +{
> +	return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>  {
>  	return mapping->gfp_mask;
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index e918f96881f5..0ae1fb057b3d 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -4,28 +4,10 @@
>
>  #ifdef CONFIG_SECRETMEM
>
> -extern const struct address_space_operations secretmem_aops;
> -
> -static inline bool secretmem_mapping(struct address_space *mapping)
> -{
> -	return mapping->a_ops == &secretmem_aops;
> -}
> -
> -bool vma_is_secretmem(struct vm_area_struct *vma);
>  bool secretmem_active(void);
>
>  #else
>
> -static inline bool vma_is_secretmem(struct vm_area_struct *vma)
> -{
> -	return false;
> -}
> -
> -static inline bool secretmem_mapping(struct address_space *mapping)
> -{
> -	return false;
> -}
> -
>  static inline bool secretmem_active(void)
>  {
>  	return false;
> diff --git a/lib/buildid.c b/lib/buildid.c
> index aaf61dfc0919..b78fe5797e9c 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -46,8 +46,8 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>
>  	freader_put_folio(r);
>
> -	/* reject secretmem folios created with memfd_secret() */
> -	if (secretmem_mapping(r->file->f_mapping))
> +	/* reject folios without direct map entries (e.g. from memfd_secret() or guest_memfd()) */
> +	if (mapping_no_direct_map(r->file->f_mapping))
>  		return -EFAULT;
>
>  	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
> diff --git a/mm/gup.c b/mm/gup.c
> index 9cad53acbc99..11461a54b3ae 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -11,7 +11,6 @@
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> -#include <linux/secretmem.h>
>
>  #include <linux/sched/signal.h>
>  #include <linux/rwsem.h>
> @@ -1216,7 +1215,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  	if ((gup_flags & FOLL_SPLIT_PMD) && is_vm_hugetlb_page(vma))
>  		return -EOPNOTSUPP;
>
> -	if (vma_is_secretmem(vma))
> +	if (vma_has_no_direct_map(vma))
>  		return -EFAULT;
>
>  	if (write) {
> @@ -2724,7 +2723,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   * This call assumes the caller has pinned the folio, that the lowest page table
>   * level still points to this folio, and that interrupts have been disabled.
>   *
> - * GUP-fast must reject all secretmem folios.
> + * GUP-fast must reject all folios without direct map entries (such as secretmem).
>   *
>   * Writing to pinned file-backed dirty tracked folios is inherently problematic
>   * (see comment describing the writable_file_mapping_allowed() function). We
> @@ -2753,7 +2752,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>  	if (WARN_ON_ONCE(folio_test_slab(folio)))
>  		return false;
>
> -	/* hugetlb neither requires dirty-tracking nor can be secretmem. */
> +	/* hugetlb neither requires dirty-tracking nor can be without direct map. */
>  	if (folio_test_hugetlb(folio))
>  		return true;
>
> @@ -2791,8 +2790,9 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>  	 * At this point, we know the mapping is non-null and points to an
>  	 * address_space object.
>  	 */
> -	if (secretmem_mapping(mapping))
> +	if (mapping_no_direct_map(mapping))
>  		return false;
> +
>  	/* The only remaining allowed file system is shmem. */
>  	return !reject_file_backed || shmem_mapping(mapping);
>  }
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 2f699c3497a5..a6f4b3df4f3f 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -474,7 +474,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
>  	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> -	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
> +	    vma_is_dax(vma) || vma_has_no_direct_map(vma) || (oldflags & VM_DROPPABLE))
>  		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
>  		goto out;
>
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index edf111e0a1bb..560cdbe1fe5d 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -134,11 +134,6 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>  	return 0;
>  }
>
> -bool vma_is_secretmem(struct vm_area_struct *vma)
> -{
> -	return vma->vm_ops == &secretmem_vm_ops;
> -}
> -
>  static const struct file_operations secretmem_fops = {
>  	.release	= secretmem_release,
>  	.mmap_prepare	= secretmem_mmap_prepare,
> @@ -156,7 +151,7 @@ static void secretmem_free_folio(struct folio *folio)
>  	folio_zero_segment(folio, 0, folio_size(folio));
>  }
>
> -const struct address_space_operations secretmem_aops = {
> +static const struct address_space_operations secretmem_aops = {
>  	.dirty_folio	= noop_dirty_folio,
>  	.free_folio	= secretmem_free_folio,
>  	.migrate_folio	= secretmem_migrate_folio,
> @@ -205,6 +200,7 @@ static struct file *secretmem_file_create(unsigned long flags)
>
>  	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  	mapping_set_unevictable(inode->i_mapping);
> +	mapping_set_no_direct_map(inode->i_mapping);
>
>  	inode->i_op = &secretmem_iops;
>  	inode->i_mapping->a_ops = &secretmem_aops;
> --
> 2.50.1

Thanks also for the cleanups!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

