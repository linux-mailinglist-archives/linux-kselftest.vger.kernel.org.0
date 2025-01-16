Return-Path: <linux-kselftest+bounces-24636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BDA13621
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 10:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085B43A12D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670E1D7E30;
	Thu, 16 Jan 2025 09:04:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665891A08BC;
	Thu, 16 Jan 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018285; cv=none; b=N/hIjhl5cG/YvXomlTquURjfE44Wd05jA6tDhTQAbQFih4cf6owPicF5XeqcBGxb6JDv4xZiqWVtGOccsdMWPPCashwRr8xwab3g7cpFpC4OrA5JF/71f9WhI8WfZk1XKlcV/av1faDJOwwn3wFO+EX0BiFyWeuaamRICc+tgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018285; c=relaxed/simple;
	bh=kGkp+1pokDJpHR7iSo16jsNz+JlQ+wnqu3AQ9BEa/jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg/Gx5oEFJ9+7pT74sEn6Mxu710o+YeDlMQkbARc6hzDhZXQDN4OJ4gHlUJrbfgPWpEzJqbuesMbT5bAk83OLajYJy0YBpmaFIvbgVswYL+Fh66cbhd9+wb7ZRBaUxWOktqSjWlLPWoFi/pfgAKu87jth4wYFuR9Pj+QzDcJlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A9911FB;
	Thu, 16 Jan 2025 01:05:09 -0800 (PST)
Received: from [10.57.94.252] (unknown [10.57.94.252])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247763F673;
	Thu, 16 Jan 2025 01:04:39 -0800 (PST)
Message-ID: <873aede9-bfcd-4c95-a93d-ec1881554f39@arm.com>
Date: Thu, 16 Jan 2025 09:04:37 +0000
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
 <20250107144755.1871363-2-ryan.roberts@arm.com> <Z4gaUAt9w8s1rLPK@x1n>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z4gaUAt9w8s1rLPK@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/01/2025 20:28, Peter Xu wrote:
> On Tue, Jan 07, 2025 at 02:47:52PM +0000, Ryan Roberts wrote:
>> When mremap()ing a memory region previously registered with userfaultfd
>> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
>> inconsistency in flag clearing leads to a mismatch between the vma flags
>> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
>> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
>> to trigger a warning in page_table_check_pte_flags() due to setting the
>> pte to writable while uffd-wp is still set.
>>
>> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
>> such mremap() so that the values are consistent with the existing
>> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
>> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
>> PTE, huge PMD and hugetlb paths.
>>
>> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>> Cc: stable@vger.kernel.org
> 
> Nothing I see wrong:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Great thanks!

> 
> One trivial thing: some multiple-line comments is following the net/ coding
> style rather than mm/, but well.. I don't think it's a huge deal.
> 
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

Noted, I'll aim to get it right in future.

> 
> Thanks again.
> 


