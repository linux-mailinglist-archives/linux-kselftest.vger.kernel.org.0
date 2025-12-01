Return-Path: <linux-kselftest+bounces-46802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8DC97A68
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33D74343533
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD831196F;
	Mon,  1 Dec 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P+JSSNig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30D253B58;
	Mon,  1 Dec 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596408; cv=none; b=QxUBCzEiKCL6A/AzuNb2zQcrraENd1FPRZwUTsoXjN7hP+zXYtc720MoSJ6UN0/9DLfr0cMCCbgWzbljeA+qcgByNIeCpG1cRLIUtUlsfkQ4zZ3nNv0tVu1yQqheaUHDKUgcIaDWoexq7mc97+jjKVQqAhzWtPZfEvlsZ1sj0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596408; c=relaxed/simple;
	bh=pODYm4/wzd6Q86QjgT9AOiW9Hx0JjcD9U2mghxXoc3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sQ10ppc3qlnMeptIasu9IsQetR9BZeoifQ0GdTRHKoJQneaaw/qp8ygenWghdJA+oQTV6b1XcoLbvc6eMqNvr8H3wK5pX8m2M4bg1O9U/i9KUYu0FhGUlfqtTK1roClzrJTYWbRmOXi5uxqOfB260WLD1Cgq3hEmlvGmJZz9Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P+JSSNig; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764596407; x=1796132407;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=nemidgf20T0MiuPAn2IxvBVJhvchWGtF0eYiaEKtbrI=;
  b=P+JSSNigEDNOfE0b8cX5xKPyPDSpMLpXNJewsX73K7UlZHkTEswNddJb
   02gQ9ZBNyNtuCjbCc25d/k3kZO94Hfp89QuHFrE9CvFKLtUjTIx4ZVms8
   QY0cFzgWAcOgZk+hnXyA8wohpJ4wlIaOM3KFuasQJfLPspuhFVXv9Zez0
   gTdvZ6OF9dsLMoUbcvllhLPYCgIa7e97jDqNDuBc7yKertyJy8it9eMbv
   d3nScw99CaMDjmc2Qh0omYOcT0sDgHaeTtBE2/hgxmllRBI3Q6RoPzVat
   mh9r6qpm9Q6E5KxBlB/gqmxnO3FC/RuBFzpzxpNNWwmWcHzeIknRcM4hN
   g==;
X-CSE-ConnectionGUID: h5WV4QyQRryAuPtxYLRY1w==
X-CSE-MsgGUID: NHijns49Qe2ZupRDZONfLQ==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="5941279"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:39:48 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:19444]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.14.220:2525] with esmtp (Farcaster)
 id d52c58bf-1924-463c-99a6-f963e446f61b; Mon, 1 Dec 2025 13:39:47 +0000 (UTC)
X-Farcaster-Flow-ID: d52c58bf-1924-463c-99a6-f963e446f61b
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 13:39:40 +0000
Received: from [192.168.8.132] (10.106.82.12) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 13:39:39 +0000
Message-ID: <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
Date: Mon, 1 Dec 2025 13:39:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
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
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
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
In-Reply-To: <20251130111812.699259-5-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D012EUC003.ant.amazon.com (10.252.51.208) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 30/11/2025 11:18, Mike Rapoport wrote:
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
> complete and add implementation of ->get_folio_noalloc() to guest_memfd
> vm_ops.
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   virt/kvm/guest_memfd.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ffadc5ee8e04..dca6e373937b 100644
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
> @@ -359,7 +360,15 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>          if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
>                  return VM_FAULT_SIGBUS;
> 
> -       folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +       folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
> +       if (!IS_ERR_OR_NULL(folio) && userfaultfd_minor(vmf->vma)) {
> +               ret = VM_FAULT_UFFD_MINOR;
> +               goto out_folio;
> +       }

I realised that I might have been wrong in [1] saying that the noalloc 
get folio was ok for our use case.  Unfortunately we rely on a minor 
fault to get generated even when the page is being allocated.  Peter and 
I discussed it originally in [2].  Since we want to populate guest 
memory with the content supplied by userspace on demand, we have to be 
able to intercept the very first access, meaning we either need a minor 
or major UFFD event for that.  We decided to make use of the minor at 
the time.  If we have to preserve the shmem semantics, it forces us to 
implement support for major/UFFDIO_COPY.

[1] 
https://lore.kernel.org/all/4405c306-9d7c-4fd6-9ea6-2ed1b73f5c2e@amazon.com
[2] https://lore.kernel.org/kvm/Z9HhTjEWtM58Zfxf@x1.local

> +
> +       if (PTR_ERR(folio) == -ENOENT)
> +               folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +
>          if (IS_ERR(folio)) {
>                  int err = PTR_ERR(folio);
> 
> @@ -390,8 +399,30 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>          return ret;
>   }
> 
> +#ifdef CONFIG_USERFAULTFD
> +static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode,
> +                                               pgoff_t pgoff)
> +{
> +       struct folio *folio;
> +
> +       folio = filemap_lock_folio(inode->i_mapping, pgoff);
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
> +       .get_folio_noalloc      = kvm_gmem_get_folio_noalloc,
> +#endif
>   };
> 
>   static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> --
> 2.51.0
> 


