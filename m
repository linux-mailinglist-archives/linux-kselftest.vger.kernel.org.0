Return-Path: <linux-kselftest+bounces-28667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0FA5A1BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909CF188DEF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10092234966;
	Mon, 10 Mar 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ntwx2Uyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284B233725;
	Mon, 10 Mar 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630352; cv=none; b=YB1cMGFlSYw7FK7JcbRoM9zRqnGt0WgmhctiYVbe+1IgaQ18vMRIDZHw8RmmQKNaHCd64riQpw1H904hhhHq9km+j2YQCy1Deoa4J9pmixh1l6K9PTpeU7/LNBfL9fI3qcdEXwshxajlpwb8RqbE6wDfLbFAx4ycrRfw7OSLYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630352; c=relaxed/simple;
	bh=HG/W4n5uZlKY6cxWkKtd3p2/Kd4jfK+Mk8Uxv4orh/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ql5BMjqAJbOHwuNZyjWJsRnZB/LehRN5Vi7LEICAixKRm5tU9uhc/j/uW7MA1oV1stMZVCQL6IqehiArTnNzwNXm8PA/q38qQwOn4d8IbWgq4zy+TWzXPGgraRsy2XInmIfrElP+xscKST/ZjDQ7cdQPUaAn4mIOgrprowDIuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ntwx2Uyu; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741630351; x=1773166351;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=AJNzET63DVGR7tJQ8b5ZW+nPqzzSSt+0wH0JG0KxXMQ=;
  b=Ntwx2Uyu3x33GAf7fzYGVLxmIbFhej99vgmteWkYBNzqLRgg9breUu7v
   RS/98kS+foQ5MCCOrVk7xuB2NdOOKWkMQQSIMdPnvKGbG/Mia7UcNYqjl
   mY+uwxwnlKnj2dg/KWDW5uCx38+L0nfQXMQ6PD8IQxO34/qWXbOmLehxM
   E=;
X-IronPort-AV: E=Sophos;i="6.14,236,1736812800"; 
   d="scan'208";a="278114488"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 18:12:26 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:59359]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.60:2525] with esmtp (Farcaster)
 id c3925b25-0958-4048-85a6-faf49dbd70a0; Mon, 10 Mar 2025 18:12:24 +0000 (UTC)
X-Farcaster-Flow-ID: c3925b25-0958-4048-85a6-faf49dbd70a0
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Mar 2025 18:12:24 +0000
Received: from [192.168.30.50] (10.106.82.18) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 10 Mar 2025
 18:12:23 +0000
Message-ID: <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
Date: Mon, 10 Mar 2025 18:12:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
To: Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
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
In-Reply-To: <Z8i0HXen8gzVdgnh@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D004EUC004.ant.amazon.com (10.252.51.191) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 05/03/2025 20:29, Peter Xu wrote:
> On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
>> I think it might be useful to implement an fs-generic MINOR mode. The
>> fault handler is already easy enough to do generically (though it
>> would become more difficult to determine if the "MINOR" fault is
>> actually a MISSING fault, but at least for my userspace, the
>> distinction isn't important. :)) So the question becomes: what should
>> UFFDIO_CONTINUE look like?
>>
>> And I think it would be nice if UFFDIO_CONTINUE just called
>> vm_ops->fault() to get the page we want to map and then mapped it,
>> instead of having shmem-specific and hugetlb-specific versions (though
>> maybe we need to keep the hugetlb specialization...). That would avoid
>> putting kvm/gmem/etc. symbols in mm/userfaultfd code.
>>
>> I've actually wanted to do this for a while but haven't had a good
>> reason to pursue it. I wonder if it can be done in a
>> backwards-compatible fashion...
> 
> Yes I also thought about that. :)

Hi Peter, hi James.  Thanks for pointing at the race condition!

I did some experimentation and it indeed looks possible to call 
vm_ops->fault() from userfault_continue() to make it generic and 
decouple from KVM, at least for non-hugetlb cases.  One thing is we'd 
need to prevent a recursive handle_userfault() invocation, which I 
believe can be solved by adding a new VMF flag to ignore the userfault 
path when the fault handler is called from userfault_continue().  I'm 
open to a more elegant solution though.

Regarding usage of the MINOR notification, in what case do you recommend 
sending it?  If following the logic implemented in shmem and hugetlb, ie 
if the page is _present_ in the pagecache, I can't see how it is going 
to work with the write syscall, as we'd like to know when the page is 
_missing_ in order to respond with the population via the write.  If 
going against shmem/hugetlb logic, and sending the MINOR event when the 
page is missing from the pagecache, how would it solve the race 
condition problem?

Also, where would the check for the folio_test_uptodate() mentioned by 
James fit into here?  Would it only be used for fortifying the MINOR 
(present) against the race?

> When Axel added minor fault, it's not a major concern as it's the only fs
> that will consume the feature anyway in the do_fault() path - hugetlbfs has
> its own path to take care of.. even until now.
> 
> And there's some valid points too if someone would argue to put it there
> especially on folio lock - do that in shmem.c can avoid taking folio lock
> when generating minor fault message.  It might make some difference when
> the faults are heavy and when folio lock is frequently taken elsewhere too.

Peter, could you expand on this?  Are you referring to the following 
(shmem_get_folio_gfp)?

	if (folio) {
		folio_lock(folio);

		/* Has the folio been truncated or swapped out? */
		if (unlikely(folio->mapping != inode->i_mapping)) {
			folio_unlock(folio);
			folio_put(folio);
			goto repeat;
		}
		if (sgp == SGP_WRITE)
			folio_mark_accessed(folio);
		if (folio_test_uptodate(folio))
			goto out;
		/* fallocated folio */
		if (sgp != SGP_READ)
			goto clear;
		folio_unlock(folio);
		folio_put(folio);
	}

Could you explain in what case the lock can be avoided?  AFAIC, the 
function is called by both the shmem fault handler and userfault_continue().

> It might boil down to how many more FSes would support minor fault, and
> whether we would care about such difference at last to shmem users. If gmem
> is the only one after existing ones, IIUC there's still option we implement
> it in gmem code.  After all, I expect the change should be very under
> control (<20 LOCs?)..
> 
> --
> Peter Xu
> 


