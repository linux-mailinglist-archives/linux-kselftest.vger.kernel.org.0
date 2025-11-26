Return-Path: <linux-kselftest+bounces-46494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C51C89402
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A84804ED86C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA32FBE1B;
	Wed, 26 Nov 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVwJbqF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056D2DF137;
	Wed, 26 Nov 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152378; cv=none; b=Wlz978wAPqsejYg1cgy+6j7DZml011BVcloCIb/C3acuY1Bk2H9jX8kBJYtqn+CIhCX1EB/S7u7OQkFLoeF02B8xQr2MReoT08Z0KgKV8oJ5NI6VSTFigwmEeU9/LIHzuQtFfYPLrC5rRJrSu4LH6lkIYxfXi7c+9vTC7BJ/zAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152378; c=relaxed/simple;
	bh=e9FOp73QbX/qH1ICAIHKKQ91Oue3tJPhRgVdlzZS0s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJH6LPexQCqjrtKwdAa58+cF9npqWAo026vpKhGwLAMR3nFcIu7xsiK5vRdasUDq4cFvuY5qJgJGKLAjtY6eX9WLi7kKHoNEk7Y805YESpHubm6gR47+KjtuqqoTrU998BVLF3UF46V8MFmc0QGbUrlnVo59vqBp5348ibU2Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVwJbqF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A2C113D0;
	Wed, 26 Nov 2025 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152377;
	bh=e9FOp73QbX/qH1ICAIHKKQ91Oue3tJPhRgVdlzZS0s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aVwJbqF5LwtL/GBKSUM5lJlYOc5Cq82JW3QAUHKZUy6XidPIAMiJBSP3E4lH2cDHG
	 X2Ly6ckgxDIJj4VnA4AZ02oTyXeySLUkMQ51x4rI1m7tbW8hdSz8VLQAYDgA3yquMO
	 u6becA6wo00CKuOCaiqLIYWeKbFktTC6jhiALlraSWGCnAx/bKsccS7Y0ipgbUSIUc
	 6ZhvqjZbMYnY+1beJ3/ghajKkAq2PTzStQyj+UpyKGe4FR6G4z6+y4u+49klpKMLqS
	 nFA73WD+j0GyBzg6b8/ljzsvszZFDzmfMTUq/CQKql4wVXnHk3ariH1xzaNjIjwGu0
	 Gux6LkgjkAB3Q==
Message-ID: <de66cef2-de14-4503-bbc6-21467e0e3e29@kernel.org>
Date: Wed, 26 Nov 2025 11:19:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251125183840.2368510-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> @@ -1564,7 +1571,8 @@ enum vm_fault_reason {
>   	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
>   	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
>   	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
> -	{ VM_FAULT_COMPLETED,           "COMPLETED" }
> +	{ VM_FAULT_COMPLETED,           "COMPLETED" },	\
> +	{ VM_FAULT_UFFD_MINOR,		"UFFD_MINOR" },	\
>   
>   struct vm_special_mapping {
>   	const char *name;	/* The name, e.g. "[vdso]". */
> diff --git a/mm/memory.c b/mm/memory.c
> index b59ae7ce42eb..94acbac8cefb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>   	}
>   
>   	ret = vma->vm_ops->fault(vmf);
> +	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
> +		return handle_userfault(vmf, VM_UFFD_MINOR);
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
>   			    VM_FAULT_DONE_COW)))

If we want to reduce the overhead on the fast path, we can simply do

if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
		    VM_FAULT_DONE_COW | VM_FAULT_UFFD_MINOR))) {
	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
		return handle_userfault(vmf, VM_UFFD_MINOR);
	return ret;
}

Maybe the compiler already does that to improve the likely case.

LGTM

-- 
Cheers

David

