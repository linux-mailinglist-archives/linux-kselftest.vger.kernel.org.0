Return-Path: <linux-kselftest+bounces-46932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15986C9EA05
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B47E64E0262
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AE72E6CC5;
	Wed,  3 Dec 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LH1lhcmq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE72E11BC;
	Wed,  3 Dec 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756218; cv=none; b=hpoBs4q/Ze43JhbPQ1bfxRpEWURW7CZRt9zbPVYlHXI9sxvu30CSCchw3WBuw6rDeEPewTi03Cp/TzphqP+YwkLBfOcPS2aF8EaoelsnL5LcOmJC44GKHgwzjq6gRIwaygjV4zTzlEzY0HEKiXNccSEE714aMaac44zYkVnbaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756218; c=relaxed/simple;
	bh=WkESfGO5MviN8fnvT23ujzkSPr3QHo9ZG/Z45XTcDio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=erWJ8g/Ahx8GDReJH6q75Q2NZwnogoSDJip2xEK8hI9crAZkSaxSagyU64SKBW7OXQTH7F7Qf8/GwXIQdglDmb/mjTdqh3Q0aLGQd5R3pSjNit4A5vTQ5FbWDGyz74g/oWv5F8rIwFk+9H7ajmhmRKW7m2hwZ/KAePJJi9JnapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LH1lhcmq; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764756217; x=1796292217;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=s7odRi39//eUzQHPeI9r1ot7neXJJbQK2cDuxp8n8TI=;
  b=LH1lhcmqF2M17HU4+PzuIW3/m/rYzi3seBaSCa7K91ezROB56szRgJKK
   SCeZKbW9HrCUucKghTu1rIz5R6GA2JBMjphCAZwrGvDhxwCnPaasutQH0
   VpOsVV8J5GlcvQ+ct1hYDjG/+2QAbl+pdMB25+awUPJftZ5Bx/Ke2rqJp
   mVieiWh+D9FZW3HY6uliO3jk2g9V924ohVpvEq8UBlYN5c78hSQS03HJb
   tlqZemYqFmLIEe1kltKKWolXEEH3YZOcKqHT8idAkcLrPKps3Dclj16kP
   ebTi8oghD0wvvsBjd7EJAhBpc8cDmc6XR6p3FPEfi6qq07xCHSjQQRcvB
   Q==;
X-CSE-ConnectionGUID: y+zHd3gVTkuBmjeZewQSHw==
X-CSE-MsgGUID: co2givXqS36NxzqAzRiVyg==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="5853166"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 10:03:19 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:6533]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525] with esmtp (Farcaster)
 id 082a07bd-3f7a-43be-a7c1-2fe7936d9f9f; Wed, 3 Dec 2025 10:03:19 +0000 (UTC)
X-Farcaster-Flow-ID: 082a07bd-3f7a-43be-a7c1-2fe7936d9f9f
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 10:03:18 +0000
Received: from [192.168.6.49] (10.106.82.29) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 3 Dec 2025
 10:03:17 +0000
Message-ID: <6b21d20c-447f-4059-8cbd-76a8eeebe834@amazon.com>
Date: Wed, 3 Dec 2025 10:03:16 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Peter Xu
	<peterx@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>, Andrea Arcangeli
	<aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, "James
 Houghton" <jthoughton@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
 <553c64e8-d224-4764-9057-84289257cac9@amazon.com> <aS3f_PlxWLb-6NmR@x1.local>
 <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com> <aS4BVC42JiUT51rS@x1.local>
 <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>
 <69bfdffd-8aa3-4375-9caf-b3311ff72448@kernel.org>
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
In-Reply-To: <69bfdffd-8aa3-4375-9caf-b3311ff72448@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D001EUB003.ant.amazon.com (10.252.51.38) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 03/12/2025 09:23, David Hildenbrand (Red Hat) wrote:
> On 12/2/25 12:50, Nikita Kalyazin wrote:
>>
>>
>> On 01/12/2025 20:57, Peter Xu wrote:
>>> On Mon, Dec 01, 2025 at 08:12:38PM +0000, Nikita Kalyazin wrote:
>>>>
>>>>
>>>> On 01/12/2025 18:35, Peter Xu wrote:
>>>>> On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
>>>>>> I believe I found the precise point where we convinced ourselves 
>>>>>> that minor
>>>>>> support was sufficient: [1].  If at this moment we don't find that 
>>>>>> reasoning
>>>>>> valid anymore, then indeed implementing missing is the only option.
>>>>>>
>>>>>> [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
>>>>>
>>>>> Now after I re-read the discussion, I may have made a wrong statement
>>>>> there, sorry.  I could have got slightly confused on when the write()
>>>>> syscall can be involved.
>>>>>
>>>>> I agree if you want to get an event when cache missed with the 
>>>>> current uffd
>>>>> definitions and when pre-population is forbidden, then MISSING trap is
>>>>> required.  That is, with/without the need of UFFDIO_COPY being 
>>>>> available.
>>>>>
>>>>> Do I understand it right that UFFDIO_COPY is not allowed in your 
>>>>> case, but
>>>>> only write()?
>>>>
>>>> No, UFFDIO_COPY would work perfectly fine.  We will still use write()
>>>> whenever we resolve stage-2 faults as they aren't visible to UFFD.  
>>>> When a
>>>> userfault occurs at an offset that already has a page in the cache, 
>>>> we will
>>>> have to keep using UFFDIO_CONTINUE so it looks like both will be 
>>>> required:
>>>>
>>>>    - user mapping major fault -> UFFDIO_COPY (fills the cache and 
>>>> sets up
>>>> userspace PT)
>>>>    - user mapping minor fault -> UFFDIO_CONTINUE (only sets up 
>>>> userspace PT)
>>>>    - stage-2 fault -> write() (only fills the cache)
>>>
>>> Is stage-2 fault about KVM_MEMORY_EXIT_FLAG_USERFAULT, per James's 
>>> series?
>>
>> Yes, that's the one ([1]).
>>
>> [1]
>> https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com
>>
>>>
>>> It looks fine indeed, but it looks slightly weird then, as you'll 
>>> have two
>>> ways to populate the page cache.  Logically here atomicity is indeed not
>>> needed when you trap both MISSING + MINOR.
>>
>> I reran the test based on the UFFDIO_COPY prototype I had using your
>> series [2], and UFFDIO_COPY is slower than write() to populate 512 MiB:
>> 237 vs 202 ms (+17%).  Even though UFFDIO_COPY alone is functionally
>> sufficient, I would prefer to have an option to use write() where
>> possible and only falling back to UFFDIO_COPY for userspace faults to
>> have better performance.
> 
> Just so I understand correctly: we could even do without UFFDIO_COPY for
> that scenario by using write() + minor faults?

We still need major fault notifications as well (which we were 
accidentally generating until this version).  But we can resolve them 
with write() + UFFDIO_CONTINUE instead of UFFDIO_COPY.

> 
> But what you are saying is that there might be a performance benefit in
> using UFFDIO_COPY for userspace faults, to avoid the write()+minor fault
> overhead?

UFFDIO_COPY _may_ be faster to resolve userspace faults because it's a 
single syscall instead of two, but the amount of userspace faults, at 
least in our scenario, is negligible compared to the amount of stage-2 
faults, so I wouldn't use it as an argument for supporting UFFDIO_COPY 
if it can be avoided.

> 
> -- 
> Cheers
> 
> David


