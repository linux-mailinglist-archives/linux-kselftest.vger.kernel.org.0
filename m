Return-Path: <linux-kselftest+bounces-46377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA3C800FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B02D4E3449
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8962F4A00;
	Mon, 24 Nov 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAXJgd8K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A660296BC4;
	Mon, 24 Nov 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982205; cv=none; b=VuDsEc1hb1A3Jb5OLcRt+EaSJkCxbMQa7k6EyZ8Qn6FRqfyEJ3jtaVcCaYQVwqrPtKrGM3+0N0BqL+KndLBh7o6tXkLjjDodAAjwIqtsib6UYdnYLX4YmXgyjZMoEmd++alQSZX97VgUWQhg7H+wJErWaLmhyCg63r0tc6rLiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982205; c=relaxed/simple;
	bh=dPX6RM/71Vh3Rg6mMUUHNMjki5uHeW9Di7AFUe06SIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qf9C2l23hzzHLAcjDy9IN/mjveI4oGCSk3IV9hU+00twV2cQprrAKZcOR03WZu+ZopkWszJ1j5jzSk12odsoW8yNZ36quQ0PgPLMmM9pjnAWVsHbgTpOCHIOYWomc5mDosxSMCqbUcnkNnAmWtMw7oEwfjGJy1h9O6dpHOJgoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAXJgd8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E8FC4CEFB;
	Mon, 24 Nov 2025 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763982204;
	bh=dPX6RM/71Vh3Rg6mMUUHNMjki5uHeW9Di7AFUe06SIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tAXJgd8KRu8Q5V9aLwauZ1k+fElq8tVU+jgRk9V8z9tI8Wt82uOnUMl4A41BAxhlH
	 a97WXS50IpqSn9hKKdunuS4HBW2ES2f0Vv6k68wx8XxHSXmvVPAbatbuM8ocpG2k3s
	 W78fXij3OS3qK5KaDT+OO9o+l8Csdaj/Xz161iBtcKql4r5F2AgBR/M2a25HYp1yHD
	 b81IFqXfFkgCxXe0QBvBzGoAjRknxrnmYYbwqgP6tqBPcxW/GAuT4vGKtCGbRpmb86
	 8p6A0ytk0HtSUfUyuLrEC3z7MWaPMnyKG8LvVPtKjJw3gd3LZCWvJj/PwioCnqL9fY
	 mJK76Wr1oG7pQ==
Message-ID: <a06e57ff-b77b-44fd-9b69-929d7647644b@kernel.org>
Date: Mon, 24 Nov 2025 12:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] userfaultfd, shmem: use a VMA callback to handle
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
References: <20251123102707.559422-1-rppt@kernel.org>
 <20251123102707.559422-3-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123102707.559422-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 11:27, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> it needs to get a folio that already exists in the pagecache backing
> that VMA.
> 
> Instead of using shmem_get_folio() for that, add a get_pagecache_folio()

get_shared_folio()

Given that the helper now no longer receives a VMA, I assume we can just 
really call it get_folio() and the "shared" part would be implicit. 
(from the inode)

> method to 'struct vm_operations_struct' that will return a folio if it
> exists in the VMA's pagecache at given pgoff.
> 
> Implement get_pagecache_folio() method for shmem and slightly refactor
> userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
> this new API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Nothing else jumped at me :)

-- 
Cheers

David

