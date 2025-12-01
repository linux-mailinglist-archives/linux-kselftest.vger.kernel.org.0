Return-Path: <linux-kselftest+bounces-46844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7308C98F81
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 21:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411333A400B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CC2571D7;
	Mon,  1 Dec 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IUBqYe6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEC22578D;
	Mon,  1 Dec 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619990; cv=none; b=uiMHpb/3msmnniiUWWCwBs5tomBKrVNYnoa80crTgBFQsIX1cvWPRI8NIEJI21o/B+sMDHJu5HlUZhn9AzpnVOep7BrxbJNxRymOstJP41jr0FoSiiFYxYUABdig//+UPZiF6CJyqK1J0Q8vi0ZfXz5AXiiFw+Rcymv789cC8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619990; c=relaxed/simple;
	bh=MQ3eyor86sxRhc8CBbfLCATRlrWCo8STd8YRj2Xb6hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hJO91UgCGtoBa+uTC0F1TZ2iZ5whg1T1RrTr1fW0HK/MhzcCfP0mV853rI1+xhXpzu76+bLNiGRdH5+RAZtYGQoVeZhDrKv20e6Z/mPsOnt6y3+f/Sha2vGLpdm+xi9twU47k5JKkxLxlD+P1wHw6GVxhsoVTHqQDYHoifs3Shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IUBqYe6z; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764619988; x=1796155988;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=jw7sf18yjrGUxi5LoRiNzSqIdVAlpc8gStzOjw+D3GE=;
  b=IUBqYe6zTHL7cKDCv4tcAZl7nis9A77QJp5hMP46JZ12ligi0QMw2cFL
   uGgKzb3E2CmGbiKiDAZJ4nworwGOG6DLToFIWvY7CPo9abHfgcj5VGP7p
   ozMK4mP0/AxpSYY6kiINk8EJaJiY7Vb70vSe4oqde28e3eMi2IxhXbXyV
   MSi8qCRgXsDNGxUR+q6quYpEgZHkpVa13MlUFGbFPueKR28rcGT4GSQgZ
   piU7EwzqjFx5h4YdVJR3Foyttft6/EtjwJ+a7rWZsTIZrmv9Eaod9ElRt
   zBoINUcquJza4EG1KujnyPIZempEituVdKgNOiR3sP7BxjpA4QrFY371Y
   A==;
X-CSE-ConnectionGUID: UBre7cQ1R7asxuwwMHYSog==
X-CSE-MsgGUID: Awp7RMVESxm3JxgQeF7zFw==
X-IronPort-AV: E=Sophos;i="6.20,241,1758585600"; 
   d="scan'208";a="6082826"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 20:12:48 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:2863]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.60:2525] with esmtp (Farcaster)
 id 72a6fd31-2cc3-4330-9bca-5a8a723d3114; Mon, 1 Dec 2025 20:12:48 +0000 (UTC)
X-Farcaster-Flow-ID: 72a6fd31-2cc3-4330-9bca-5a8a723d3114
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 20:12:40 +0000
Received: from [192.168.8.132] (10.106.82.12) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 20:12:39 +0000
Message-ID: <76e3d5bf-df73-4293-84f6-0d6ddabd0fd7@amazon.com>
Date: Mon, 1 Dec 2025 20:12:38 +0000
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
In-Reply-To: <aS3f_PlxWLb-6NmR@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D008EUA003.ant.amazon.com (10.252.50.155) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 01/12/2025 18:35, Peter Xu wrote:
> On Mon, Dec 01, 2025 at 04:48:22PM +0000, Nikita Kalyazin wrote:
>> I believe I found the precise point where we convinced ourselves that minor
>> support was sufficient: [1].  If at this moment we don't find that reasoning
>> valid anymore, then indeed implementing missing is the only option.
>>
>> [1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local
> 
> Now after I re-read the discussion, I may have made a wrong statement
> there, sorry.  I could have got slightly confused on when the write()
> syscall can be involved.
> 
> I agree if you want to get an event when cache missed with the current uffd
> definitions and when pre-population is forbidden, then MISSING trap is
> required.  That is, with/without the need of UFFDIO_COPY being available.
> 
> Do I understand it right that UFFDIO_COPY is not allowed in your case, but
> only write()?

No, UFFDIO_COPY would work perfectly fine.  We will still use write() 
whenever we resolve stage-2 faults as they aren't visible to UFFD.  When 
a userfault occurs at an offset that already has a page in the cache, we 
will have to keep using UFFDIO_CONTINUE so it looks like both will be 
required:

  - user mapping major fault -> UFFDIO_COPY (fills the cache and sets up 
userspace PT)
  - user mapping minor fault -> UFFDIO_CONTINUE (only sets up userspace PT)
  - stage-2 fault -> write() (only fills the cache)

> 
> One way that might work this around, is introducing a new UFFD_FEATURE bit
> allowing the MINOR registration to trap all pgtable faults, which will
> change the MINOR fault semantics.

This would equally work for us.  I suppose this MINOR+MAJOR semantics 
would be more intrusive from the API point of view though.

> 
> That'll need some further thoughts, meanwhile we may also want to make sure
> the old shmem/hugetlbfs semantics are kept (e.g. they should fail MINOR
> registers if the new feature bit is enabled in the ctx somehow; or support
> them properly in the codebase).
> 
> Thanks,
> 
> --
> Peter Xu
> 


