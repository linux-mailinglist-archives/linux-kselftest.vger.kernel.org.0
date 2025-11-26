Return-Path: <linux-kselftest+bounces-46496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6608C8944A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 237C3355F00
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A42FF668;
	Wed, 26 Nov 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiYIuCSU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D72FBDF4;
	Wed, 26 Nov 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152733; cv=none; b=LqEBM0dlf8ocbMbh3yCD71f91x0zeqhRMtp9xGfXwGlanbbsC71vVHLSzhuomg4eixPOK6+lQiFwpVca+o2GbExSn7wcddINKEOWkSO8nyLNIj+rYxOdZqvkCS1qakRc0CcRvXi2Av4LFPXoHacMcFWGfKL7A04eHjoj0WgSEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152733; c=relaxed/simple;
	bh=ADT5O93kPzD5IUnxNtMCPvZ3ykq6P2gnQ8CL/G2R2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OV6iP5+SWanTRhlmJAR9oaUO1gNxFcJdFXNfyZRX7NNnTqH8ibpOkstxuYshouIJX2DFigKXZqjlqEWm5vQAIHWzZB4p9xQENlAkDO1r/5Yt/iOpfCi75EbtNFPoDkF6wQysDcdKnGMTpAm7RA015tw5e8TK65aRK/TwhfMNnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiYIuCSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D812DC113D0;
	Wed, 26 Nov 2025 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152732;
	bh=ADT5O93kPzD5IUnxNtMCPvZ3ykq6P2gnQ8CL/G2R2Yg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TiYIuCSUq9QRRGD2topIHFwl1vopc3ZLruOXHs9PFa6hrCZl0gnj1E9KSrDUQJm07
	 Tv2dPgpe3TaU6zrGMJiYz/x1RjJiYCjoS0tWUnyMxE0aStEXScEdG2/MVbTeNhoIVw
	 EomHvzqTzMRIzPfLH7bujkmAqtrGEN0VnxmAs5RvxuGwlrrp+DmrBbQvImxbMcbW8D
	 SVGGQixWkF/Gh/TJQBL9VRoZsTyCFez7z9R8SR5ePpkEB7PWuFqg6ceVrItOwBEDvf
	 pXXPBuDQ4gTuQ1h+pmAsLjdmmzhrY/aPHEh4kchNz2BfsZf8keHL7/sCIG2gn2B0Wh
	 KCmcjSEepjGFA==
Message-ID: <3d5096cd-39b5-4280-95a1-78998a4e609e@kernel.org>
Date: Wed, 26 Nov 2025 11:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
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
 <20251125183840.2368510-5-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251125183840.2368510-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/25 19:38, Mike Rapoport wrote:
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

No exports and still looks clean to me, nice. :)

-- 
Cheers

David

