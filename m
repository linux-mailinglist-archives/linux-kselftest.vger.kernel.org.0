Return-Path: <linux-kselftest+bounces-46874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D55C9B5CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFA3451B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ED63115AE;
	Tue,  2 Dec 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oRWBLFKl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB5280309;
	Tue,  2 Dec 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676266; cv=none; b=JVJ3nBg6lS3qvJzHeKY4sCMwZ0luBBPXOUkUpbfQkHXaGyyj3KBlnyLGJLN5NkVvlR9krpGrIXouJMnqVGDp5KYmtl1lyfXEHGF6yx/32B9TP2ydogNrOSld/5ELdfI+tqr0MjHdul1hV5zz0P8kRqXP4gEI6R62HKO3M22nO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676266; c=relaxed/simple;
	bh=lgksDGV3VJRcya5McuA/e8Esq2KIX/Dc3eb4iph/8P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F+X4Awj8SQSer861RavStvX78YvgJY9EGf3vGHEXk6L39zoSkg4uVHp50MlDO4Q74KjsBv3ZK3FVRqHGz2+EERj9qRhF6+yFVNj7X2GgAqkm4mgM04G21L4uhPIewYu76YpbDn734A9pckl1VM5e+MS9q92ECqDupPWrn1CRUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oRWBLFKl; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764676265; x=1796212265;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=KFJG4v1V23XNGxr101Iy6bR88wmMiiVy8jZ4JavjKdg=;
  b=oRWBLFKltBtOvwOpM/9ktlnXk9sF22t+4jJzcvk2YDXbaf7pz11sPUi0
   blfbiEobGffgCHeZ5GzqLay+alGgcQokdBuHf7YMaY3BKDLfbLtpzg9NM
   uaRTr2ePydIZ+5joY05s2hqiRkoRRyqLRT+unJqhzmYfZ659ByljfyhAI
   6IipIwf1Rk6OMQakvkS2JGe4KDWJMqM9ouygIK9Trf7OgHL9oT9gwwT5F
   +xfdnPXsUnrEorgoDi4WGnhgr24GcNc4pbLyWX/CS9G4Hb2soL4jG41r9
   JAboE897bOuhtToVnytmeFe7gxew+MCl573jKYbYeOrvtgObkRlnquYY9
   w==;
X-CSE-ConnectionGUID: ZfUcYgzQQUuMfJ3SHdBYRg==
X-CSE-MsgGUID: vFh6YIAsTW6Teg9ZRJZHPA==
X-IronPort-AV: E=Sophos;i="6.20,242,1758585600"; 
   d="scan'208";a="6004691"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 11:50:45 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:1507]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id 8ae9055c-a10c-49bd-84a1-a1fa87042f96; Tue, 2 Dec 2025 11:50:45 +0000 (UTC)
X-Farcaster-Flow-ID: 8ae9055c-a10c-49bd-84a1-a1fa87042f96
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 11:50:37 +0000
Received: from [192.168.12.25] (10.106.83.17) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 2 Dec 2025
 11:50:36 +0000
Message-ID: <415a5956-1dec-4f10-be36-85f6d4d8f4b4@amazon.com>
Date: Tue, 2 Dec 2025 11:50:31 +0000
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
To: Peter Xu <peterx@redhat.com>
CC: "David Hildenbrand (Red Hat)" <david@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, <linux-mm@kvack.org>, Andrea Arcangeli
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
In-Reply-To: <aS4BVC42JiUT51rS@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D015EUA002.ant.amazon.com (10.252.50.219) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 01/12/2025 20:57, Peter Xu wrote:
> On Mon, Dec 01, 2025 at 08:12:38PM +0000, Nikita Kalyazin wrote:
>>
>>
>> On 01/12/2025 18:35, Peter Xu wrote:
>>> On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
>>>> I believe I found the precise point where we convinced ourselves that minor
>>>> support was sufficient: [1].  If at this moment we don't find that reasoning
>>>> valid anymore, then indeed implementing missing is the only option.
>>>>
>>>> [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
>>>
>>> Now after I re-read the discussion, I may have made a wrong statement
>>> there, sorry.  I could have got slightly confused on when the write()
>>> syscall can be involved.
>>>
>>> I agree if you want to get an event when cache missed with the current uffd
>>> definitions and when pre-population is forbidden, then MISSING trap is
>>> required.  That is, with/without the need of UFFDIO_COPY being available.
>>>
>>> Do I understand it right that UFFDIO_COPY is not allowed in your case, but
>>> only write()?
>>
>> No, UFFDIO_COPY would work perfectly fine.  We will still use write()
>> whenever we resolve stage-2 faults as they aren't visible to UFFD.  When a
>> userfault occurs at an offset that already has a page in the cache, we will
>> have to keep using UFFDIO_CONTINUE so it looks like both will be required:
>>
>>   - user mapping major fault -> UFFDIO_COPY (fills the cache and sets up
>> userspace PT)
>>   - user mapping minor fault -> UFFDIO_CONTINUE (only sets up userspace PT)
>>   - stage-2 fault -> write() (only fills the cache)
> 
> Is stage-2 fault about KVM_MEMORY_EXIT_FLAG_USERFAULT, per James's series?

Yes, that's the one ([1]).

[1] 
https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com

> 
> It looks fine indeed, but it looks slightly weird then, as you'll have two
> ways to populate the page cache.  Logically here atomicity is indeed not
> needed when you trap both MISSING + MINOR.

I reran the test based on the UFFDIO_COPY prototype I had using your 
series [2], and UFFDIO_COPY is slower than write() to populate 512 MiB: 
237 vs 202 ms (+17%).  Even though UFFDIO_COPY alone is functionally 
sufficient, I would prefer to have an option to use write() where 
possible and only falling back to UFFDIO_COPY for userspace faults to 
have better performance.

[2] 
https://lore.kernel.org/all/7666ee96-6f09-4dc1-8cb2-002a2d2a29cf@amazon.com

> 
>>
>>>
>>> One way that might work this around, is introducing a new UFFD_FEATURE bit
>>> allowing the MINOR registration to trap all pgtable faults, which will
>>> change the MINOR fault semantics.
>>
>> This would equally work for us.  I suppose this MINOR+MAJOR semantics would
>> be more intrusive from the API point of view though.
> 
> Yes it is, it's just that I don't know whether it'll be harder when you
> want to completely support UFFDIO_COPY here, per previous discussions.
> 
> After a 2nd thought, such UFFD_FEATURE is probably not a good design,
> because it essentially means that feature bit will functionally overlap
> with what MISSING trap was trying to do, however duplicating that concept
> in a VMA that was registered as MINOR only.
> 
> Maybe it's possible instead if we allow a module to support MISSING trap,
> but without supporting UFFDIO_COPY ioctl.
> 
> That is, the MISSING events will be properly generated if MISSING traps are
> supported, however the module needs to provide its own way to resolve it if
> UFFDIO_COPY ioctl isn't available.  Gmem is fine in this case as long as
> it'll always be registered with both MISSING+MINOR traps, then resolving
> using write()s would work.

Yes, this would also work for me.  This is almost how it was 
(accidentally) working until this version of the patches.  If this is a 
lighter undertaking compared to implementing UFFDIO_COPY, I'd be happy 
with it too.

> 
> Such would be possible when with something like my v3 previously:
> 
> https://lore.kernel.org/all/20250926211650.525109-1-peterx@redhat.com/#t
> 
> Then gmem needs to declare VM_UFFD_MISSING + VM_UFFD_MINOR in
> uffd_features, but _UFFDIO_CONTINUE only (without _UFFDIO_COPY) in
> uffd_ioctls.
> 
> Since Mike already took this series over, I'll leave that to you all to
> decide.

Thanks for you input, Peter.

> 
> --
> Peter Xu
> 


