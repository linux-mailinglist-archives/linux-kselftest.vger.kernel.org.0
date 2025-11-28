Return-Path: <linux-kselftest+bounces-46688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F4C91F62
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 13:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0479934F706
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB632862A;
	Fri, 28 Nov 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s8Zml5XV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148A2AEE4;
	Fri, 28 Nov 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332174; cv=none; b=qYg/LIeUlamt3LV1NC8k27Bc2ByeKa8Q5rOot3iiYZBYHxLrNKqjac+A+HT/3/R2hxc+RXi41sN9ip3odwB9BfUGuMfTZWz6byMTgpI78+uSb3sbL52SCUOZM3J5M0LGBR2lzKVYkSyn3RZOG7cMaqbcH8ilJbo9M5hSCdRj4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332174; c=relaxed/simple;
	bh=X0wCOz2Keh7A2/OZ8I2wdQQbyy9uFCyaA9I+TtIjomc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZIrgVp6AcKah4XygLSI1SsRVMpVfkk4/daL59pHLQ0/SKQkvgou/2eAq0dH+miBJ/CoMXYhsXsAlheqhWj0Lyr+rpMNikAfbBX+zjc4ibadhOgEu0YmHAI0ENG/hQMg8q7pWDzmTc4Ff/tT9EfrFCu9hBvv1eXOzh8GfWWnXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s8Zml5XV; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764332172; x=1795868172;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=wQmqQgiUg9lKMYuf3x986+KMHkr7rlI8OkUZkYHCLlo=;
  b=s8Zml5XVpeQAFB8Eu9hy+Q4YhziqVGUo8gLdqd7u8vaHKeJhh1ua9w1A
   YEseRNbVfjF3vJ/wch5bkAFNLedPLwql+KCg9NhJrf6rrTWH3M90qqF7X
   un3oJyXsuSJJ8eZ4Q8KDu8YcjHd7ErP7GqlfSO9fvD4diV9KZnxRCyObk
   s30LLiF8q9ywDDdbxGyHer1aqaJGjH2fs5jvuTP81DpCDuJOHOm3I0RZe
   TWcPJAeBVdjWbe9NXSDT7/WJBnzRwekg2y46zM82LQt9zcYJu/ArtIptQ
   qsq+ACzg0V7H68y8wkS90D4aFt319k4b9C8tsKjSNEusr+BcleSex8vJp
   g==;
X-CSE-ConnectionGUID: a46IeSqzQEW+DEIlmgXGXA==
X-CSE-MsgGUID: bKPh8JWXRo6VH8Yjn5Tl+g==
X-IronPort-AV: E=Sophos;i="6.20,232,1758585600"; 
   d="scan'208";a="5943764"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 12:15:54 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:6730]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525] with esmtp (Farcaster)
 id 0de054ca-fa8f-4660-b374-417544b79f00; Fri, 28 Nov 2025 12:15:54 +0000 (UTC)
X-Farcaster-Flow-ID: 0de054ca-fa8f-4660-b374-417544b79f00
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 12:15:54 +0000
Received: from [192.168.12.95] (10.106.83.26) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 28 Nov 2025
 12:15:52 +0000
Message-ID: <4405c306-9d7c-4fd6-9ea6-2ed1b73f5c2e@amazon.com>
Date: Fri, 28 Nov 2025 12:15:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, "James
 Houghton" <jthoughton@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
 <bafb0c9e-9ce6-4294-b1d6-e32c41635add@amazon.com>
 <aSgpo1_ZSmxf84-p@kernel.org>
 <13d3a7a4-5cf8-4fbe-8dba-d565525a71c6@amazon.com>
 <aSigyHj01snbfii7@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <aSigyHj01snbfii7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D014EUA003.ant.amazon.com (10.252.50.119) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 27/11/2025 19:04, Mike Rapoport wrote:
> On Thu, Nov 27, 2025 at 11:19:35AM +0000, Nikita Kalyazin wrote:
>>
>>
>> On 27/11/2025 10:36, Mike Rapoport wrote:
>>> On Wed, Nov 26, 2025 at 04:49:31PM +0000, Nikita Kalyazin wrote:
>>>> On 25/11/2025 18:38, Mike Rapoport wrote:
>>>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>>>
>>>>> +#ifdef CONFIG_USERFAULTFD
>>>>> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
>>>>
>>>> We have to name it differently, otherwise it clashes with the existing one
>>>> in this file.
>>>
>>> It's all David's fault! ;-P
>>> How about kvm_gmem_get_prepared_folio() ?
>>
>> I'm afraid it may not be ideal due to preparedness tracking being removed
>> from guest_memfd at some point [1].  Would it be too bad to add an
>> indication to userfaultfd in the name somehow given that it's already
>> guarded by the config?
> 
> Hmm, shmem also has this clash. There I picked shmem_get_folio_noalloc()
> because that describes well what it does: lookup folio in the page cache,
> grab it if it's there or return -ENOENT if it's missing.
> That's also what hugetlb does for uffd minor fault.
> 
> The guest_memfd implementation I copied from one of the older postings
> allocates the folio if it's not in the page cache and it seems to me that
> it also should only look up existing folios to keep uffd minor semantics
> uniform.

I can't see a reason for guest_memfd to deviate from shmem and hugetlb 
here so makes sense to me.

> 
> Then it makes sense also to name the vm_ops method get_folio_noalloc().
> 
> --
> Sincerely yours,
> Mike.


