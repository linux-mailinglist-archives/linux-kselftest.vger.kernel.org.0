Return-Path: <linux-kselftest+bounces-28988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C5A6040A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAD4219A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD41F754A;
	Thu, 13 Mar 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QwYtpq5z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6C1F0997;
	Thu, 13 Mar 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904030; cv=none; b=WBydxstfAj0MT00pqLjAmky1T/1lkS7xYofGRFNBZ4REWHE01qNK+G8xrDlMMpURZSJnBW68T7XwOeHihYwp3L2dCEJijc7X3WjfLzjAYCtlQb8Jmj+WQkfff0ebMlM4CZyjNdt3oKhY2SHMCa4H6Q37+dutib2uQyJsCmLNNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904030; c=relaxed/simple;
	bh=6et2f+IAaWWEtqOwRSdd4hH+fOa2/crNtycQ3NR4sHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hcewjQaIFcaAjmAMiP50JD2tgoXRsW3PLMz1BgtkRvPbMlBgGviGB7q6eqLaAGmh89wU4dgb+S7oMKhSdgM9+eiHaXL4F4kuMBZ4g29EDQKYFL+Tavg/PdrTiR1FlG0WmfFikz7k6JH2YwQZxQ03P0mHM/ZHaMcGYMCLYJPGcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QwYtpq5z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741904028; x=1773440028;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=ykTJUUOvH2VvwmsTF8Y9p+LL6eaaY5GGxwQKE1SyE+c=;
  b=QwYtpq5zgJDfsss5OYFlFcZxPzO2XShKe1onQqBnnIDCWY5szpO4d07Z
   r5H30etVQrHLZ9SJ3Y4ALMq4/x6sDxGghIf2/5NQd0nZmhZUIPrj3axKG
   NboMEKntEWK/sXHNhoaOp9B3IIl+ApmZk2LU840UxooqLV4zZSPqKVRWc
   k=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="178481195"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 22:13:46 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:22832]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.72:2525] with esmtp (Farcaster)
 id c936554d-6948-4d14-b818-fcc3de9bf611; Thu, 13 Mar 2025 22:13:45 +0000 (UTC)
X-Farcaster-Flow-ID: c936554d-6948-4d14-b818-fcc3de9bf611
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 22:13:42 +0000
Received: from [192.168.31.185] (10.106.83.24) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 22:13:41 +0000
Message-ID: <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
Date: Thu, 13 Mar 2025 22:13:23 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
To: Peter Xu <peterx@redhat.com>
CC: James Houghton <jthoughton@google.com>, <akpm@linux-foundation.org>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <david@redhat.com>,
	<ryan.roberts@arm.com>, <quic_eberman@quicinc.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local> <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local> <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local> <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local> <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
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
In-Reply-To: <Z9MuC5NCFUpCZ9l8@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D012EUC002.ant.amazon.com (10.252.51.162) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 13/03/2025 19:12, Peter Xu wrote:
> On Thu, Mar 13, 2025 at 03:25:16PM +0000, Nikita Kalyazin wrote:
>>
>>
>> On 12/03/2025 19:32, Peter Xu wrote:
>>> On Wed, Mar 12, 2025 at 05:07:25PM +0000, Nikita Kalyazin wrote:
>>>> However if MISSING is not registered, the kernel will auto-populate with a
>>>> clear page, ie there is no way to inject custom content from userspace.  To
>>>> explain my use case a bit more, the population thread will be trying to copy
>>>> all guest memory proactively, but there will inevitably be cases where a
>>>> page is accessed through pgtables _before_ it gets populated.  It is not
>>>> desirable for such access to result in a clear page provided by the kernel.
>>>
>>> IMHO populating with a zero page in the page cache is fine. It needs to
>>> make sure all accesses will go via the pgtable, as discussed below in my
>>> previous email [1], then nobody will be able to see the zero page, not
>>> until someone updates the content then follow up with a CONTINUE to install
>>> the pgtable entry.
>>>
>>> If there is any way that the page can be accessed without the pgtable
>>> installation, minor faults won't work indeed.
>>
>> I think I see what you mean now.  I agree, it isn't the end of the world if
>> the kernel clears the page and then userspace overwrites it.
>>
>> The way I see it is:
>>
>> @@ -400,20 +401,26 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>>          if (WARN_ON_ONCE(folio_test_large(folio))) {
>>                  ret = VM_FAULT_SIGBUS;
>>                  goto out_folio;
>>          }
>>
>>          if (!folio_test_uptodate(folio)) {
>>                  clear_highpage(folio_page(folio, 0));
>>                  kvm_gmem_mark_prepared(folio);
>>          }
>>
>> +       if (userfaultfd_minor(vmf->vma)) {
>> +               folio_unlock(folio);
>> +               filemap_invalidate_unlock_shared(inode->i_mapping);
>> +               return handle_userfault(vmf, VM_UFFD_MISSING);
>> +       }
> 
> I suppose you meant s/MISSING/MINOR/.

Yes, that's what I meant, thank you.

>> +
>>          vmf->page = folio_file_page(folio, vmf->pgoff);
>>
>>   out_folio:
>>          if (ret != VM_FAULT_LOCKED) {
>>                  folio_unlock(folio);
>>                  folio_put(folio);
>>          }
>>
>> On the first fault (cache miss), the kernel will allocate/add/clear the page
>> (as there is no MISSING trap now), and once the page is in the cache, a
>> MINOR event will be sent for userspace to copy its content. Please let me
>> know if this is an acceptable semantics.
>>
>> Since userspace is getting notified after KVM calls
>> kvm_gmem_mark_prepared(), which removes the page from the direct map [1],
>> userspace can't use write() to populate the content because write() relies
>> on direct map [2].  However userspace can do a plain memcpy that would use
>> user pagetables instead.  This forces userspace to respond to stage-2 and
>> VMA faults in guest_memfd differently, via write() and memcpy respectively.
>> It doesn't seem like a significant problem though.
> 
> It looks ok in general, but could you remind me why you need to stick with
> write() syscall?
> 
> IOW, if gmemfd will always need mmap() and it's fully accessible from
> userspace in your use case, wouldn't mmap()+memcpy() always work already,
> and always better than write()?

Yes, that's right, mmap() + memcpy() is functionally sufficient. 
write() is an optimisation.  Most of the pages in guest_memfd are only 
ever accessed by the vCPU (not userspace) via TDP (stage-2 pagetables) 
so they don't need userspace pagetables set up.  By using write() we can 
avoid VMA faults, installing corresponding PTEs and double page 
initialisation we discussed earlier.  The optimised path only contains 
pagecache population via write().  Even TDP faults can be avoided if 
using KVM prefaulting API [1].

[1] https://docs.kernel.org/virt/kvm/api.html#kvm-pre-fault-memory

> 
> Thanks,
> 
>>
>> I believe, with this approach the original race condition is gone because
>> UFFD messages are only sent on cache hit and it is up to userspace to
>> serialise writes.  Please correct me if I'm wrong here.
>>
>> [1] https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/#mdf41fe2dc33332e9c500febd47e14ae91ad99724
>> [2] https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com/T/#mf5d794aa31d753cbc73e193628f31e418051983d
>>
>>>>
>>>>> as long as the content can only be accessed from the pgtable (either via
>>>>> mmap() or GUP on top of it), then afaiu it could work similarly like
>>>>> MISSING faults, because anything trying to access it will be trapped.
>>>
>>> [1]
>>>
>>> --
>>> Peter Xu
>>>
>>
>>
> 
> --
> Peter Xu
> 


