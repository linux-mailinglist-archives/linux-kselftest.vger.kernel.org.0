Return-Path: <linux-kselftest+bounces-49342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCED3A53F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC70303F34C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3A30B50C;
	Mon, 19 Jan 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPCyN0dl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B762DB79F;
	Mon, 19 Jan 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819196; cv=none; b=UHoUefYKXXnrPqjw/REMhd+T1ZYXIkdXCQIheX36iQ4Gjkpw29PLZJwMKUduKzUlhDoVy1qTxGHYkIf5AaHZtjJcFWuejNWOW675sRh3SspFKrGYo3mnkme+9b/Ho9db4YE4ulB+fHe35NS04b/xkof7D1Q3tV+jdZ72Uzjt8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819196; c=relaxed/simple;
	bh=bI669qC6s3Cud/xoDjw02dNzaCGh567RaObYNbGa/sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ky+ujMKGER2NffFk0olzOY9fdg6BGp3TryrrRIZf3q49WOYXC5ncAix972Af8hZ6aVaodyGJXanzLeM+q3TAh3R4UCLpK1FEyW8Ei1jzi3WUj8Rzkb+dYXytWDZLdYKQTgD5Vo6oOt+0txeOuZRLZHvuC1InVKsmhGGVFiazxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPCyN0dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC18C116C6;
	Mon, 19 Jan 2026 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768819196;
	bh=bI669qC6s3Cud/xoDjw02dNzaCGh567RaObYNbGa/sQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FPCyN0dlTBHW970efzSsD2UQe7KrHSpW6NAJpINTNJrYaJTzUn/5gCkw+19AL+7gB
	 Z9kymMeNPY28bUgU07Cs42jNclJtLZylJc9NlXslm/2Zu1VBLs3QuiqHJYceKVIWeD
	 bWEn4hBjaleGOXeFl8a5dlfg+GuKHh3Ge4AdsnzZDZfgpPsagpUg3iqjPKiX5tJXMf
	 Ha/HSGddWdJZygGC1zEwhMajLZFILWbb3TVJcH2+EgkL+mFu4PAhPiAiFXjhQ8KxQS
	 G2mmX8MlSaCX7WWy5Elb261of8ZXNUZ6DxmlbwO0K4hFMcG4ndhLB9ASZbVk+Pd/1y
	 IBlgkwikGUyJA==
Message-ID: <3d2e85ed-f072-4fca-8c22-461b001495c1@kernel.org>
Date: Mon, 19 Jan 2026 11:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/26 14:20, Lorenzo Stoakes wrote:
> This self test is asserting internal implementation details and is highly
> vulnerable to internal kernel changes as a result.
> 
> It is currently failing locally from at least v6.17, and it seems that it
> may have been failing for longer in many configurations/hardware as it
> skips if e.g. CONFIG_ANON_VMA_NAME is not specified.
> 
> With these skips and the fact that run_vmtests.sh won't run the tests in
> certain configurations it is likely we have simply missed this test being
> broken in CI for a long while.
> 
> I have tried multiple versions of these tests and am unable to find a
> working bisect as previous versions of the test fail also.
> 
> The tests are essentially mmap()'ing a series of mappings with no hint and
> asserting what the get_unmapped_area*() functions will come up with, with
> seemingly few checks for what other mappings may already be in place.
> 
> It then appears to be mmap()'ing with a hint, and making a series of
> similar assertions about the internal implementation details of the hinting
> logic.
> 
> Commit 0ef3783d7558 ("selftests/mm: add support to test 4PB VA on PPC64"),
> commit 3bd6137220bb ("selftests/mm: virtual_address_range: avoid reading
> from VM_IO mappings"), and especially commit a005145b9c96 ("selftests/mm:
> virtual_address_range: mmap() without PROT_WRITE") are good examples of the
> whack-a-mole nature of maintaining this test.
> 
> The last commit there being particularly pertinent as it was accounting for
> an internal implementation detail change that really should have no bearing
> on self-tests, that is commit e93d2521b27f ("x86/vdso: Split virtual clock
> pages into dedicated mapping").
> 
> The purpose of the mm self-tests are to assert attributes about the API
> exposed to users, and to ensure that expectations are met.
> 
> This test is emphatically not doing this, rather making a series of
> assumptions about internal implementation details and asserting them.
> 
> It therefore, sadly, seems that the best course is to remove this test
> altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

On

$ uname -r
6.18.4-200.fc43.x86_64

I am getting

$ ./va_high_addr_switch
mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d7000 - OK
mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7fe7de6d6000 - OK
mmap(addr_switch_hint, pagesize): 0x7fe7de6d7000 - OK
mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(NULL): 0x7fe7de6d5000 - OK
mmap(low_addr): 0x40000000 - OK
mmap(high_addr): 0x7fe7de6d5000 - OK
mmap(high_addr) again: 0x7fe7de6d3000 - OK
mmap(high_addr, MAP_FIXED): 0xffffffffffffffff - FAILED
mmap(-1): 0x7fe7de6d1000 - OK
mmap(-1) again: 0x7fe7de6cf000 - OK
mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d0000 - OK
mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7fe7de6cf000 - OK
mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7fe7de6cd000 - OK
mmap(addr_switch_hint, pagesize): 0x7fe7de6cc000 - OK
mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED


Are these the same issues you see?

-- 
Cheers

David

