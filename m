Return-Path: <linux-kselftest+bounces-46632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB9C8E0AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74E6E341C1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306532B9B1;
	Thu, 27 Nov 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b21RDsDx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0332B987;
	Thu, 27 Nov 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242844; cv=none; b=jesHwd1+ZuPkU9obm1uK03LtvmYUZNKP2ppGlDLjmo7aNnsUsAL1aItkiSE/mUEDGRDpvhhxpeKYYVngJBRb55zd0tJSFX2RZxcM75eNwvgIjIPX5NkAyNQGZGx2HjgmcPslDImaRRMv9MvPse9MGR9LYOzdcnlmRnNsMJJ3dAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242844; c=relaxed/simple;
	bh=muetvljUY3Nkik/PobN2fmNoxtVaO6scpEpns09bMHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNgqrNCZQYmTqjQwTGVH9jIx17kUCGOvF9Z0V2xHET1VXyCkM1l46jJLEzA04sryWXBJkhqtIrELZ0aSu4qRklM6vNSZLJ3khNFyhByUTni8s1arLgYzN98tid9uqSnNcEcWsqWAzmw99WpnR9AxqSwoLEoWDRkWJfCqP/81lLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b21RDsDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A317C4CEF8;
	Thu, 27 Nov 2025 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764242843;
	bh=muetvljUY3Nkik/PobN2fmNoxtVaO6scpEpns09bMHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b21RDsDxdy85ey8AfYrH0yNpETemOuc8/zJEIQrhlSIr1zrzEHVNWmb9xrVmYGYGA
	 umX8lU3bIw6mNbLZKK3YDmJPuIP/LArzTepOUMLLfqIS6TKKqu5RVtrzP4fqgtE6VH
	 YJlQlMLRoyR9Ly8y5VCfCu6iVe1CRYLZwqh3jvDsM6rGz0a70MuTDOIPtwJ0QM/UDz
	 TYvDohZpmz9VYMobH5ImBRZM7tZrMt7/n103jYmaupkbNrAEbhDzoTSKGbXaMd5ELB
	 9L6WSZDtSb3tBzCVGJwsiN5MtPG3rlRjraE1yQ+FGv6pocryFVju3v+p1o2zfCPU07
	 KgLYSETML2Cfw==
Message-ID: <35f8ca1b-b5ea-420d-af3a-ba9acc7b39c7@kernel.org>
Date: Thu, 27 Nov 2025 12:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: Mike Rapoport <rppt@kernel.org>, Nikita Kalyazin <kalyazin@amazon.com>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
 <bafb0c9e-9ce6-4294-b1d6-e32c41635add@amazon.com>
 <aSgpo1_ZSmxf84-p@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aSgpo1_ZSmxf84-p@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/25 11:36, Mike Rapoport wrote:
> On Wed, Nov 26, 2025 at 04:49:31PM +0000, Nikita Kalyazin wrote:
>> On 25/11/2025 18:38, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> +#ifdef CONFIG_USERFAULTFD
>>> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
>>
>> We have to name it differently, otherwise it clashes with the existing one
>> in this file.
> 
> It's all David's fault! ;-P

As usual :)

> How about kvm_gmem_get_prepared_folio() ?

Or maybe just spell out that it is for vm_ops

kvm_gmem_vm_ops_get_folio()

-- 
Cheers

David

