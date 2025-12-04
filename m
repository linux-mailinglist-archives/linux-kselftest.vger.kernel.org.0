Return-Path: <linux-kselftest+bounces-47048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234CCA4C33
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD4963002E8C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA083002AE;
	Thu,  4 Dec 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="auNXdOHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8522F28EC;
	Thu,  4 Dec 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869251; cv=none; b=L3EXmHdT43vC+LjtzXJ5RdL9k4UZqhj4NPE8HAabquTGvbWNeJ6ZQ2danAxMcl0FW91omBWoAsgM+VeBs7xJLJ5PV1Xq2eGrERyceVku21Kk4Dv9qT7lrE6ObxsR1kM7wwLhSdEr1OUYCwQoXh7L2ZO460O9tgGdNhfqE+kn+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869251; c=relaxed/simple;
	bh=hJrZNiixpwQSuLl+5TGcL5061MC4y1DMUo+oqB1goIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=uQVujMQnUbH28CoPoQ9uFHf6ahnoR4ayHWlrSexWrAPERVpX/Fj6XiFVwWOtOLlqprMC+vm+xIn5OX7/6v3uWhDqQm6aoNLU/w0Vre62FPi1iiPxfJM25c2wNjx2gz/+zco+zub8hkYBy7FXmwVroQhqREef/e6i01ITy6qabjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=auNXdOHx; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764869247; x=1796405247;
  h=message-id:date:mime-version:reply-to:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=+B+opqRca5hXbovGvQR+mVja5lmSAC1UXe+INpSdy+s=;
  b=auNXdOHxFZARzy6TfwY2qgwLYaWivQvSNSvHopm/NAmqhtpH7BfgE7VW
   5B5WkxeVhvCtJJJ1TwunDsqA4BoiEEiM1Y5lKmicADGg6Q/23rmHlcOq3
   CrVCGVAhtU0jkoWyNt8AMSBhrGa9PBh63jUYD1wyPqkfVKRD5KYWisRWM
   qCF35dJy5i3lGWq9sgkq9YUEnD/oRbQjXKJyh7jZkfAGZCVnSjw8pMxn4
   KL5nFl09TFL+Etk6U46Ruzmx8kZt/9NWYs77/RsiA7C9kyqOoN17Jeqkp
   64Z6Md/a0tAtdtYx9edshaM1BdSuIE+wx4bjTP8Mt2APQ49f7vobzc090
   Q==;
X-CSE-ConnectionGUID: tD7J2gDkR+OI14Z+1N4E4A==
X-CSE-MsgGUID: yxbASA5+QGOcaYoyBNhwmA==
X-IronPort-AV: E=Sophos;i="6.20,249,1758585600"; 
   d="scan'208";a="6143936"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 17:27:09 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:2904]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.45.40:2525] with esmtp (Farcaster)
 id 2e22cb74-9984-4686-b8b5-55012d26fc9d; Thu, 4 Dec 2025 17:27:09 +0000 (UTC)
X-Farcaster-Flow-ID: 2e22cb74-9984-4686-b8b5-55012d26fc9d
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Dec 2025 17:27:07 +0000
Received: from [192.168.12.174] (10.106.82.9) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 4 Dec 2025
 17:27:06 +0000
Message-ID: <2afda7a3-3c48-44e4-b462-49e0d223208b@amazon.com>
Date: Thu, 4 Dec 2025 17:27:04 +0000
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
From: Nikita Kalyazin <kalyazin@amazon.com>
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
 <6b21d20c-447f-4059-8cbd-76a8eeebe834@amazon.com>
Content-Language: en-US
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <6b21d20c-447f-4059-8cbd-76a8eeebe834@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D015EUB004.ant.amazon.com (10.252.51.13) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 03/12/2025 10:03, Nikita Kalyazin wrote:
> On 03/12/2025 09:23, David Hildenbrand (Red Hat) wrote:
>> On 12/2/25 12:50, Nikita Kalyazin wrote:
>>>
>>>
>>> On 01/12/2025 20:57, Peter Xu wrote:
>>>> On Mon, Dec 01, 2025 at 08:12:38PM +0000, Nikita Kalyazin wrote:
>>>>>
>>>>>
>>>>> On 01/12/2025 18:35, Peter Xu wrote:
>>>>>> On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
>>>>>>> I believe I found the precise point where we convinced ourselves 
>>>>>>> that minor
>>>>>>> support was sufficient: [1].  If at this moment we don't find 
>>>>>>> that reasoning
>>>>>>> valid anymore, then indeed implementing missing is the only option.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
>>>>>>
>>>>>> Now after I re-read the discussion, I may have made a wrong statement
>>>>>> there, sorry.  I could have got slightly confused on when the write()
>>>>>> syscall can be involved.
>>>>>>
>>>>>> I agree if you want to get an event when cache missed with the 
>>>>>> current uffd
>>>>>> definitions and when pre-population is forbidden, then MISSING 
>>>>>> trap is
>>>>>> required.  That is, with/without the need of UFFDIO_COPY being 
>>>>>> available.
>>>>>>
>>>>>> Do I understand it right that UFFDIO_COPY is not allowed in your 
>>>>>> case, but
>>>>>> only write()?
>>>>>
>>>>> No, UFFDIO_COPY would work perfectly fine.  We will still use write()
>>>>> whenever we resolve stage-2 faults as they aren't visible to UFFD. 
>>>>> When a
>>>>> userfault occurs at an offset that already has a page in the cache, 
>>>>> we will
>>>>> have to keep using UFFDIO_CONTINUE so it looks like both will be 
>>>>> required:
>>>>>
>>>>>    - user mapping major fault -> UFFDIO_COPY (fills the cache and 
>>>>> sets up
>>>>> userspace PT)
>>>>>    - user mapping minor fault -> UFFDIO_CONTINUE (only sets up 
>>>>> userspace PT)
>>>>>    - stage-2 fault -> write() (only fills the cache)
>>>>
>>>> Is stage-2 fault about KVM_MEMORY_EXIT_FLAG_USERFAULT, per James's 
>>>> series?
>>>
>>> Yes, that's the one ([1]).
>>>
>>> [1]
>>> https://lore.kernel.org/kvm/20250618042424.330664-1- 
>>> jthoughton@google.com
>>>
>>>>
>>>> It looks fine indeed, but it looks slightly weird then, as you'll 
>>>> have two
>>>> ways to populate the page cache.  Logically here atomicity is indeed 
>>>> not
>>>> needed when you trap both MISSING + MINOR.
>>>
>>> I reran the test based on the UFFDIO_COPY prototype I had using your
>>> series [2], and UFFDIO_COPY is slower than write() to populate 512 MiB:
>>> 237 vs 202 ms (+17%).  Even though UFFDIO_COPY alone is functionally
>>> sufficient, I would prefer to have an option to use write() where
>>> possible and only falling back to UFFDIO_COPY for userspace faults to
>>> have better performance.
>>
>> Just so I understand correctly: we could even do without UFFDIO_COPY for
>> that scenario by using write() + minor faults?
> 
> We still need major fault notifications as well (which we were 
> accidentally generating until this version).  But we can resolve them 
> with write() + UFFDIO_CONTINUE instead of UFFDIO_COPY.

We had a conversation about that at the guest_memfd sync today:

Q: Is it possible from the API point of view to support MISSING 
notifications without supporting UFFDIO_COPY?

A: The manpage [1] says on UFFDIO_REGISTER_MODE_MISSING that "the page 
fault is resolved from user-space by either an UFFDIO_COPY or an 
UFFDIO_ZEROPAGE ioctl", but I don't think it's actually enforced 
anywhere in the code.

Q: UFFDIO_COPY is supposed to provide atomic semantics, while write() + 
UFFDIO_CONTINUE does not. Is it a problem?

A: It isn't a problem for the particular Firecracker use case because 1) 
vCPUs can be prevented from seeing partially populated pages in the 
cache via KVM userfault intercept [2] and 2) we do not use other 
userspace mappings.  However, as James pointed, in the general case, 
other actors may observe partially populated pages via other userspace 
mappings.

[1] https://man7.org/linux/man-pages/man2/userfaultfd.2.html
[2] 
https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com

> 
>>
>> But what you are saying is that there might be a performance benefit in
>> using UFFDIO_COPY for userspace faults, to avoid the write()+minor fault
>> overhead?
> 
> UFFDIO_COPY _may_ be faster to resolve userspace faults because it's a 
> single syscall instead of two, but the amount of userspace faults, at 
> least in our scenario, is negligible compared to the amount of stage-2 
> faults, so I wouldn't use it as an argument for supporting UFFDIO_COPY 
> if it can be avoided.
> 
>>
>> -- 
>> Cheers
>>
>> David
> 


