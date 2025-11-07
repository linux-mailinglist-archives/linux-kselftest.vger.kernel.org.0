Return-Path: <linux-kselftest+bounces-45072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239DC3F278
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DE11348C25
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6D2F531F;
	Fri,  7 Nov 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+KqY78U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5212E229C;
	Fri,  7 Nov 2025 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507653; cv=none; b=El7BCk0X7/1b4HA28pYKrsoJnwUgU+6Mk1pbDc4dcFlLI8f6z0zDJhdZFltPs8JmEoc3Oqo9OnXKKM+Un40ouFKHyQundaS/6lymLAUCiWwOk3uUu+lDkZAwTI4gf/EchdZiEldQWj2FYoRRs6A5A955VmSgDyPgfwFDItAvNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507653; c=relaxed/simple;
	bh=XYsZOHDCQvqBnfIJG8n72IsqXz8wRu5FCAMH1Fh68L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5gk0MNoTd23tQpWeDJaQojZ/LDL0yt+PmkZT28jyJG+XdVJsMdAg+gwUbyzY+ezVzGzGGRE11IJRFS6M8X17r1ZXInYppjHjFUALcxzPOqUhcCQ7sAyhlyZnizTKt4AptHSGWrZzgHXjhThSvaLWCkrpofX1naeP8n0jAOTS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+KqY78U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B39C19423;
	Fri,  7 Nov 2025 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762507652;
	bh=XYsZOHDCQvqBnfIJG8n72IsqXz8wRu5FCAMH1Fh68L8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L+KqY78U5Aw8o2oFDAC9jsuAfpaoekJrMt9UmrwJZZ0IuMSJpB5oih+tmojGWpYmF
	 CSW4agR0Ki5dfjyQqPpDDNMck6Po/SHEklb3UdtbBVN/tlwVIJutMAvTQk+T9sJ8Bk
	 5DmZXrEgpsQDNnlglx7teswqt1Lrh6fNpjMuRgfR2xrezYr4BnWuaJAiQXwWXvPAwz
	 0bdfriP8Lv8haXp3SVfdAw5w22/5H6c3cxo26kCeLzRYopHrypfnK9mE7QBYyPgX+j
	 I1wCfHzqQtDOcp+OFq09FHUFlOTk5+Kv5O/fuOryyYSxAdLqfqID3B45ME/ih4CU5z
	 bfcESEkKYBDQQ==
Message-ID: <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
Date: Fri, 7 Nov 2025 10:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org> <aQyOZ6eYng-IjxS_@fedora>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aQyOZ6eYng-IjxS_@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 13:02, Ankit Khushwaha wrote:
> On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 06.11.25 11:49, Ankit Khushwaha wrote:
>>> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
>>> triggers following warning:
>>>
>>> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
>>> false [-Wtautological-compare]
>>>    1035 |                 if (addr + c.dest_alignment < addr) {
>>>         |                                             ^
>>>
>>> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
>>
>> With which compiler are you seeing this?
> 
> Hi David,
> 
> clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.
> 
> To reproduce:
> 	make -C tools/testing/selftests/mm CC=clang

Thanks, and thanks to Lorenzo for the details.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

