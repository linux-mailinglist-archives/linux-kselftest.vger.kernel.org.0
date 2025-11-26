Return-Path: <linux-kselftest+bounces-46495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2AC89417
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C404ED205
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DAA218845;
	Wed, 26 Nov 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axZ+8RER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA330170B;
	Wed, 26 Nov 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152495; cv=none; b=MIJ7WMOY5eQyoJrvAmo5pCQPuqKk+qFePC7On7zPbZyys4d3FcbtehX46c9IaPP7m7dpkzs6gQ+q/IW2FhRgFemO9Fa+wNtxttU56/4jNFYJje30qlpnOmznSRQx/qMD4uIUf/Yzw3O9K6VJJG+xj0rv0x/Cyon0ea5BIoLhXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152495; c=relaxed/simple;
	bh=BcAJVj6qcG98+h3lf093r2ZIpIwJSDn8eL4opofTeJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyv/M7h+y6panULYnRVW+/2w2YSUdcfQwXYzofkZ5DAuw6XgSQrTpYz93qd5qiNqpZc1Iad0vEaDTJTYWkAPR3xpcHJ3t7+ILjWFJGK4zfqFnCAjerhuQgaSZfuX8Le5zGMGklVhleLWITHYEn3RscsXUGN9CDlHRG+3KpTq2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axZ+8RER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C92C113D0;
	Wed, 26 Nov 2025 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152493;
	bh=BcAJVj6qcG98+h3lf093r2ZIpIwJSDn8eL4opofTeJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=axZ+8RERz4f1+HlUZSmBzSNN+DZ5wmCTdjZPn+Sn67DidzcPbG/trkh2LUzqBiNtF
	 0sFGfznqxNBm7RWh6g+IVpJmKoHoafpH8Yt7dbwq7doRbnBSKsf7N4K7+bBhL7qlOI
	 5aprOxQI8T39czEKCl0l1bC44w/FvReoiJi63qEA8zrUs1iSVcJIq01THJwLkwOHUj
	 qsTRe6tkhu39lUVNgjh1wtKAn0la7WVupbaLryeHQVLDH7dLm8ptKOkmnv2h7q2zFf
	 19T/KELXMc/RHK6snLqr+wIIhe+an8YnI+2fVfJUVgS+S9sxhF5DCjtHL7SLpE/S2K
	 CjxAmheibuLzw==
Message-ID: <ab2044e8-5d9e-4ccb-b430-dcfdd5e32e3a@kernel.org>
Date: Wed, 26 Nov 2025 11:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] userfaultfd, shmem: use a VMA callback to handle
 UFFDIO_CONTINUE
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
 <20251125183840.2368510-3-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251125183840.2368510-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 19:38, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> it needs to get a folio that already exists in the pagecache backing
> that VMA.
> 
> Instead of using shmem_get_folio() for that, add a get_folio() method to
> 'struct vm_operations_struct' that will return a folio if it exists in
> the VMA's pagecache at given pgoff.
> 
> Implement get_folio() method for shmem and slightly refactor
> userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
> this new API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

