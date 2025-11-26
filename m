Return-Path: <linux-kselftest+bounces-46530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBEC8B118
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D53B4A1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993733BBA6;
	Wed, 26 Nov 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nsdLdEje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829B339B2A;
	Wed, 26 Nov 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175799; cv=none; b=URhGRlrGGkYex+im6YlT6MNBf3fTDzg8Nn6DNnK579DN9XDeoNyQPtbO7aD54IctpvAo3gcXzA+4L2YG8Hg7VxBtr0vboyNyXDq9UZd16LS7aD6wBO24Oxbya7/LnDJSN1q7SEfIYx8PZWz9u8LgMyMEu35uFTTSjczce0CYfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175799; c=relaxed/simple;
	bh=eNoy1zVkFFETFLQf0EQvOtQux4gE5R7H8t1ByzzM6eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UMe7jRUS7ldnHakXwFj2b98tRGnZW3oBOwyIhBy1/1e2xdlAN4ISgshv2VyZ3mwlGPN5bqL9yYxosirBi05w40eRbJeyNUx98FDzHQLw4r6O8CSDMCAIrhoARYAiVvm8RYh4aFShbv0yl6660c1A4ZHOsPFTjE3/A56wC0BuGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nsdLdEje; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764175797; x=1795711797;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=ODZ1VeNiyr/lGvz6HoLA70V3LBo9h0c48wtwRnKdqzI=;
  b=nsdLdEje8vlF7r9+7R0AGkBG6Foye5yWxuLBueTv12uHqnjkskUsIS4I
   MUucYa5ndyf7nYBMUudJqfLUaREl0I7kmHO4enRDS0OxCocWw7prGH/oC
   8WXfu3JKLJ0QZ08rlZIqEMMZqykg0+Za4cVw9ScyPMo1AtpsAXvBIKucY
   MOqME7MQKyoGMjD9GGihpTBRMYAi/bUxKS5gLV4ORUumiSKRp4TrhVtzE
   NN4+lpY4lcM9+WSP+fMk9xf8WpM0Yz6GwqOltRwJwngDdMbmhFsXrQz46
   KaqYxmmor1vkN76b2QvkT1nV5sanLHKDkTM7I28OiU06cVMfdzwqPUMf7
   A==;
X-CSE-ConnectionGUID: cGVRR6noRwWrARLD/aWlaA==
X-CSE-MsgGUID: 8cTU9VN8SHafCqwLnVItPg==
X-IronPort-AV: E=Sophos;i="6.20,228,1758585600"; 
   d="scan'208";a="5848663"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 16:49:39 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:15053]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.255:2525] with esmtp (Farcaster)
 id ac3d6538-a606-4006-a0e4-7164b8793913; Wed, 26 Nov 2025 16:49:39 +0000 (UTC)
X-Farcaster-Flow-ID: ac3d6538-a606-4006-a0e4-7164b8793913
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 26 Nov 2025 16:49:33 +0000
Received: from [192.168.8.204] (10.106.83.30) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 26 Nov 2025
 16:49:32 +0000
Message-ID: <bafb0c9e-9ce6-4294-b1d6-e32c41635add@amazon.com>
Date: Wed, 26 Nov 2025 16:49:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
	<david@redhat.com>, Hugh Dickins <hughd@google.com>, James Houghton
	<jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, Michal Hocko
	<mhocko@suse.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, "Sean Christopherson" <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <20251125183840.2368510-5-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D014EUA001.ant.amazon.com (10.252.50.20) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 25/11/2025 18:38, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> userfaultfd notifications about minor page faults used for live migration
> and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
> mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
> minor fault registration mode").
> 
> To use the same mechanism for VMs that use guest_memfd to map their memory,
> guest_memfd should support userfaultfd minor mode.
> 
> Extend ->fault() method of guest_memfd with ability to notify core page
> fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
> complete and add implementation of ->get_shared_folio() to guest_memfd
> vm_ops.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   virt/kvm/guest_memfd.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ffadc5ee8e04..2a2b076293f9 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/pagemap.h>
>   #include <linux/anon_inodes.h>
> +#include <linux/userfaultfd_k.h>
> 
>   #include "kvm_mm.h"
> 
> @@ -369,6 +370,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>                  return vmf_error(err);
>          }
> 
> +       if (userfaultfd_minor(vmf->vma)) {
> +               folio_unlock(folio);
> +               folio_put(folio);
> +               return VM_FAULT_UFFD_MINOR;
> +       }
> +
>          if (WARN_ON_ONCE(folio_test_large(folio))) {
>                  ret = VM_FAULT_SIGBUS;
>                  goto out_folio;
> @@ -390,8 +397,29 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>          return ret;
>   }
> 
> +#ifdef CONFIG_USERFAULTFD
> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)

We have to name it differently, otherwise it clashes with the existing 
one in this file.

> +{
> +       struct folio *folio;
> +
> +       folio = kvm_gmem_get_folio(inode, pgoff);

                   ^^

> +       if (IS_ERR_OR_NULL(folio))
> +               return folio;
> +
> +       if (!folio_test_uptodate(folio)) {
> +               clear_highpage(folio_page(folio, 0));
> +               kvm_gmem_mark_prepared(folio);
> +       }
> +
> +       return folio;
> +}
> +#endif
> +
>   static const struct vm_operations_struct kvm_gmem_vm_ops = {
>          .fault = kvm_gmem_fault_user_mapping,
> +#ifdef CONFIG_USERFAULTFD
> +       .get_folio      = kvm_gmem_get_folio,
> +#endif
>   };
> 
>   static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> --
> 2.50.1
> 


