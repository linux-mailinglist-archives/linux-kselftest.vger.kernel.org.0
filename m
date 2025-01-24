Return-Path: <linux-kselftest+bounces-25078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D3A1B294
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C813A7EF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FE218EA7;
	Fri, 24 Jan 2025 09:28:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7931DB13B;
	Fri, 24 Jan 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710930; cv=none; b=JegO3CO1voKZS7mj//TkrqWihIITLM0JzgsfNLY+cCg6BTfEsoRvkrJnKIZqg3a3wXFIxN7cc3H94s1l/lfNAVEMvFCrXwBJMY9jF2gMKJK2R+taPLX9nzathcxBurlW0Trzgp9T1JyPX2vR03ydnoDDhIDGWqyTQjUbRfkD9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710930; c=relaxed/simple;
	bh=nPS5b53Zs0G6o2sflMrmSqcRN33SVACBD4jaF7mu+mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb+L7jwBjdS03d3bhp2y07WL3TqkAb3aeffKZQNYOb0hm3l1GwJjErL3Wga8bY5ecCjbRXUxMNelRYq95hV9MBjW5CipqTmzMK/QVyDIzlGKAju56+xWkvclkr7U4T5ydevMRNZ5WT3TtJlwMXTuzRm3XtmDWCnzMjlX0qvffIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC80C497;
	Fri, 24 Jan 2025 01:29:14 -0800 (PST)
Received: from [10.57.95.225] (unknown [10.57.95.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716153F694;
	Fri, 24 Jan 2025 01:28:44 -0800 (PST)
Message-ID: <738fc4af-cbee-4d14-a9eb-0932ecc3371f@arm.com>
Date: Fri, 24 Jan 2025 09:28:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <850479be-000a-45a7-9669-491d4200a988@arm.com> <Z5J_FLry1C2d3BKv@x1n>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z5J_FLry1C2d3BKv@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2025 17:40, Peter Xu wrote:
> On Thu, Jan 23, 2025 at 02:38:46PM +0000, Ryan Roberts wrote:
>>> @@ -5470,7 +5471,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>>>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>>  
>>>  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
>>> -	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
>>> +
>>> +	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
>>> +		huge_pte_clear(mm, new_addr, dst_pte, sz);
>>
>> This is checking if the source huge_pte is a uffd-wp marker and clearing the
>> destination if so. The destination could have previously held arbitrary valid
>> mappings, I guess?
> 
> I think it should be all cleared.  I didn't check all mremap paths, but for
> MREMAP_FIXED at least there should be:
> 
> 	if (flags & MREMAP_FIXED) {
> 		/*
> 		 * In mremap_to().
> 		 * VMA is moved to dst address, and munmap dst first.
> 		 * do_munmap will check if dst is sealed.
> 		 */
> 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
> 		if (ret)
> 			goto out;
> 	}
> 
> It also doesn't sound right to leave anything in dest range, 

Yes, of course. And the loop over the old ptes actually skips doing anything if
the old pte is none without doing any operations on the new pte; so it must be
none by default. OK panic over! I just need to fix the arm64 issue I raised in
the other email. I'm going to send a bunch of fixes/improvements in that area.

Thanks,
Ryan


> e.g. if there
> can be any leftover dest ptes in move_page_tables(), then it means
> HPAGE_P[MU]D won't work, as they install huge entries directly.  For that I
> do see a hint in the comment too in that path:
> 
> move_normal_pud():
> 	/*
> 	 * The destination pud shouldn't be established, free_pgtables()
> 	 * should have released it.
> 	 */
> 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
> 		return false;
> 
> PMD path has similar implications.
> 
> Thanks,
> 


