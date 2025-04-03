Return-Path: <linux-kselftest+bounces-30074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06685A7A85D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B07188C0B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8324EF7A;
	Thu,  3 Apr 2025 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JrKs5v21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813824E4A6;
	Thu,  3 Apr 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699735; cv=none; b=GgMoA279LY7GINVA56gbI58U5638XAbR7QHJjJ30mIMkN7yXYTGx9BFKYrWKe6cJvLkEVnjMe1eUo24NEQROWvhKr/vbpDUfG+xHDPEXu6Vs0+2c10OHaAk8FeDz2HNh+xEUDTNnCsgXF3KbHXFWBlW+g9Vg6pZo2oZ/esITTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699735; c=relaxed/simple;
	bh=nEBOH/dFNMNTqALWSglPk/TvW7lARIaHB0EWLmJAQ5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XHTXmKFnj8DNA636XMTp7CklqQ8sIbQfDsA8NDdbAV6WiYU5+Q2XTbe/Ko61f0Yc5FT0dqayxbdIgm+T8GYk1U9ifkvWzfRNxz2DAvCw6sFfsx4E/3oa2m2Lhejmv0aNNGOZyhnAv73lEuCRfUB6yJ5BL+UG18tNY0sj2A+rRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JrKs5v21; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743699733; x=1775235733;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=KlPQHNK4sdCepvEZdU0irxqePyaQDuuzF2VIlGStZwo=;
  b=JrKs5v21eopkV0S8+zu1KlIvQ5k4MBesA0wG+45sat6q+gGxot65wSuy
   m01XdVaQwKtsp/W+ymXUHwae12TZBJB9JbmiWQE3uvJzV7LHeXhVXy/0L
   5Z86nMvQHqsmlunKZEnJSCkh6BdOEb3NpofOZGEcveMxLfxaG7aPRJxE+
   8=;
X-IronPort-AV: E=Sophos;i="6.15,184,1739836800"; 
   d="scan'208";a="813168728"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 17:02:02 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:19366]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.20:2525] with esmtp (Farcaster)
 id de9133ca-eaf3-4ef6-b0ed-37928d983369; Thu, 3 Apr 2025 17:02:01 +0000 (UTC)
X-Farcaster-Flow-ID: de9133ca-eaf3-4ef6-b0ed-37928d983369
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 17:02:00 +0000
Received: from [192.168.28.77] (10.106.82.23) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 3 Apr 2025
 17:01:59 +0000
Message-ID: <0c72b9a9-3726-4cc0-809b-3e19413a4476@amazon.com>
Date: Thu, 3 Apr 2025 18:01:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: allow to register continue for
 guest_memfd
To: James Houghton <jthoughton@google.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <peterx@redhat.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250402160721.97596-1-kalyazin@amazon.com>
 <20250402160721.97596-4-kalyazin@amazon.com>
 <CADrL8HVADXDKUu4mn-dHb9ih=ZnuMWtKfqL2xFxKf2yff7RJvQ@mail.gmail.com>
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
In-Reply-To: <CADrL8HVADXDKUu4mn-dHb9ih=ZnuMWtKfqL2xFxKf2yff7RJvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D011EUA003.ant.amazon.com (10.252.50.178) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 02/04/2025 22:25, James Houghton wrote:
> On Wed, Apr 2, 2025 at 9:08 AM Nikita Kalyazin <kalyazin@amazon.com> wrote:
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   include/linux/userfaultfd_k.h | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>> index 75342022d144..bc184edfbb85 100644
>> --- a/include/linux/userfaultfd_k.h
>> +++ b/include/linux/userfaultfd_k.h
>> @@ -212,6 +212,10 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>>          return vma->vm_flags & __VM_UFFD_FLAGS;
>>   }
>>
>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>> +bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
>> +#endif
>> +
>>   static inline bool vma_can_userfault(struct vm_area_struct *vma,
>>                                       unsigned long vm_flags,
>>                                       bool wp_async)
>> @@ -222,7 +226,11 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>>                  return false;
>>
>>          if ((vm_flags & VM_UFFD_MINOR) &&
>> -           (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
>> +           (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma))
>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>> +            && !kvm_gmem_vma_is_gmem(vma)
>> +#endif
> 
> Maybe a better way to do this is to add a vm_ops->can_userfault() or
> something, so we could write something like this:
> 
> if (vma->vm_ops && !vma->vm_ops->can_userfault)
>    return false;
> if (vma->vm_ops && !vma->vm_ops->can_userfault(vm_flags))
>    return false;

I like that, thanks!  What do you see passing vm_flags being useful for? 
  Shall we pass the entire vma struct like in most of other callbacks?

> 
> And shmem/hugetlbfs can advertise support for everything they already
> support that way.
> 
>> +           )
>>                  return false;
>>
>>          /*
>> @@ -244,6 +252,9 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>>
>>          /* By default, allow any of anon|shmem|hugetlb */
>>          return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>> +           kvm_gmem_vma_is_gmem(vma) ||
>> +#endif
>>              vma_is_shmem(vma);
>>   }
>>
>> --
>> 2.47.1
>>


