Return-Path: <linux-kselftest+bounces-49349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A4D3A675
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA2163013157
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1A3590B5;
	Mon, 19 Jan 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV32ZWGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5F295DAC;
	Mon, 19 Jan 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821104; cv=none; b=oZNQiUzDoYMSptjOVz3imvQ+b3mk4TcpAqwUmrx/jvPwf/ad9Vp8iv1UFiK/r4c/UnZ4FaKWuloIIIGtqmfD0djYbR9PAp/R7tNvxD27Yi++tZU/6AoOt5GEwfwY22wKzHwGa/YEJyEtfiKKSOMuBo9dxEfe0c9s7f/7BMqo5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821104; c=relaxed/simple;
	bh=BvXjmuODmLa8CZomxpMTEXEbUGtQks5vexPAI+N0ojM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFhdIrYsGNFdEUIkOuRmbgh7XruoNdGB+k9V8RcMiWG0jVUsFTBpdxtuIi3WOQjdIHaVCeCR1JJwoDLB8IVAyUbz+w4AHIkLYdyvj/SLPahpEXcdc06nwgW5a5BB56IL/Fn81NxXjzVQ6JkcUP+JqtkcJ/UPdHe0yepRFhaPTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV32ZWGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F3C19424;
	Mon, 19 Jan 2026 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768821104;
	bh=BvXjmuODmLa8CZomxpMTEXEbUGtQks5vexPAI+N0ojM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BV32ZWGkNSR8ocs5gnGe2UT/AUPWOtlf9LQZU8GwLo+iZLChX92HMYn9QFlDIUTWA
	 TBScNOI5HjFPEFljO0JW6pR0DGZ/SGIsBo0UYaFB6bdsbuMKKhmivQOVjX6oi2fQfs
	 kdIvhKrwTqqxo0eQFmQXmBdg+Sy8d7RStppqD+Q9+sJIP5QZ7skxT2m2cUzjZszeky
	 1+jCDGb9YkLh0itbt5Tk/nF1hNubDmBO4m8JnIpXtTDxcFczQzjOOwrfPs+I4tSta+
	 pOfdGOF1KnFk8ftaOMhTHz6AFsOnJ0qXzIMBfQFdixWbgsHjJ+bcMIwk5WvZy5SRq5
	 8R/gptSDtHY9g==
Message-ID: <a6479b82-a68c-49f5-8631-b3f536059352@kernel.org>
Date: Mon, 19 Jan 2026 12:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <3d2e85ed-f072-4fca-8c22-461b001495c1@kernel.org>
 <79d2636a-bb15-4c7f-a633-c4bf408a2bc8@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <79d2636a-bb15-4c7f-a633-c4bf408a2bc8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 12:06, Lorenzo Stoakes wrote:
> On Mon, Jan 19, 2026 at 11:39:51AM +0100, David Hildenbrand (Red Hat) wrote:
>> On
>>
>> $ uname -r
>> 6.18.4-200.fc43.x86_64
>>
>> I am getting
>>
>> $ ./va_high_addr_switch
>> mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d7000 - OK
>> mmap(addr_switch_hint - pagesize, (2 * pagesize)): 0x7fe7de6d6000 - OK
>> mmap(addr_switch_hint, pagesize): 0x7fe7de6d7000 - OK
>> mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
>> mmap(NULL): 0x7fe7de6d5000 - OK
>> mmap(low_addr): 0x40000000 - OK
>> mmap(high_addr): 0x7fe7de6d5000 - OK
>> mmap(high_addr) again: 0x7fe7de6d3000 - OK
>> mmap(high_addr, MAP_FIXED): 0xffffffffffffffff - FAILED
>> mmap(-1): 0x7fe7de6d1000 - OK
>> mmap(-1) again: 0x7fe7de6cf000 - OK
>> mmap(addr_switch_hint - pagesize, pagesize): 0x7fe7de6d0000 - OK
>> mmap(addr_switch_hint - pagesize, 2 * pagesize): 0x7fe7de6cf000 - OK
>> mmap(addr_switch_hint - pagesize/2 , 2 * pagesize): 0x7fe7de6cd000 - OK
>> mmap(addr_switch_hint, pagesize): 0x7fe7de6cc000 - OK
>> mmap(addr_switch_hint, 2 * pagesize, MAP_FIXED): 0xffffffffffffffff - FAILED
>>
>>
>> Are these the same issues you see?
> 
> No, that's entirely separate bug it seems :)
> 

Oh, lol, I ran the wrong test.

Yes, on Fedora config I just get

  $ ./virtual_address_range
TAP version 13
1..1
ok 1 # SKIP prctl(PR_SET_VMA_ANON_NAME) not supported
# 1 skipped test(s) detected. Consider enabling relevant config options 
to improve coverage.
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0


> Seems to work locally for me on 6.18.3, and also in VM with tip mm-unstable,
> strange.

Maybe a hardware thing (notebook not supporting 5 level page tables, maybe?)

> 
> The issue here is with virtual_address_space.c which seems to just to be
> generally broken, I couldn't even bisect to a working one, and I really did
> try.
> 
> Actually hang on, isn't va_high_addr_space already then testing what
> virtual_address_space should be testing anyway if it were sensible??
> 
> That suggests then that just removing virtual_address_space without
> replacement (since this already exists) is the right way (...!)

I cannot really judge, I would have to decipher the details of the tests ...

-- 
Cheers

David

