Return-Path: <linux-kselftest+bounces-29058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC792A6172C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F753B7920
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051E204680;
	Fri, 14 Mar 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m99CFGec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53317579;
	Fri, 14 Mar 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972371; cv=none; b=sPxlHl6kAESbHNLeYlbEurAExhoXJgdAX6QHfifBVZMM3KMaOmCRiL8Ciw/v1qnHuTkWKE+J6yCEulmRx7VS7DIeqPGC5tEzNWERuC0OCusooOxIQgRGijVu4ROugBfKZWznGX4Phlk6ibTblgKX+ktVZTOyd/brVa1z/8Mu/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972371; c=relaxed/simple;
	bh=Gte+tyJJhHhkQ4HCK5AFq1SUTXMbefl2oe3vqXFLODc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KYZfys++kqTwCsBa7ofgUeBMRJe7YHbvtplLHxmhGsIaStEb718vADGvbiuw/g8sr857ITrPAQumhSzOtoEnbYXuo1FO3Mtx/vuSGCoA3GyhgO42H1l1b9QbUfYHRjnwy+jn9cIfaAUIi2G8D9qey939Yw0kGAUFvV/+H1kLZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=m99CFGec; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741972369; x=1773508369;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=oyAepvDv+0bsEwZzYOM+K7FhxhX7gKg3uHeMpyD+04E=;
  b=m99CFGec5UA1CsU4NgmcR6G8jAAmlA9lBOGEKjfZaEp86qAjDS/4Vqq1
   RZcpFaGeJVKX0ahqfLVukdPVeW0BBE1e8Pu1bBkFUiH7xlJfWY6B+c7T2
   4i6jtp4S8NASSN0lYRA5MxSGs/muWab2c9BevrfYFtSOynhv44hku6t/A
   c=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="74461133"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:12:45 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:48372]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.123:2525] with esmtp (Farcaster)
 id a718f9c8-6f48-4c18-94f5-eb2eba6844c3; Fri, 14 Mar 2025 17:12:45 +0000 (UTC)
X-Farcaster-Flow-ID: a718f9c8-6f48-4c18-94f5-eb2eba6844c3
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 17:12:38 +0000
Received: from [192.168.30.216] (10.106.83.27) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 17:12:36 +0000
Message-ID: <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>
Date: Fri, 14 Mar 2025 17:12:35 +0000
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
References: <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com> <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com> <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com> <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com> <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com> <Z9NeTQsn4xwTtU06@x1.local>
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
In-Reply-To: <Z9NeTQsn4xwTtU06@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D006EUA003.ant.amazon.com (10.252.50.176) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 13/03/2025 22:38, Peter Xu wrote:
> On Thu, Mar 13, 2025 at 10:13:23PM +0000, Nikita Kalyazin wrote:
>> Yes, that's right, mmap() + memcpy() is functionally sufficient. write() is
>> an optimisation.  Most of the pages in guest_memfd are only ever accessed by
>> the vCPU (not userspace) via TDP (stage-2 pagetables) so they don't need
>> userspace pagetables set up.  By using write() we can avoid VMA faults,
>> installing corresponding PTEs and double page initialisation we discussed
>> earlier.  The optimised path only contains pagecache population via write().
>> Even TDP faults can be avoided if using KVM prefaulting API [1].
>>
>> [1] https://docs.kernel.org/virt/kvm/api.html#kvm-pre-fault-memory
> 
> Could you elaborate why VMA faults matters in perf?

Based on my experiments, I can populate 3GiB of guest_memfd with write() 
in 980 ms, while memcpy takes 2140 ms.  When I was profiling it, I saw 
~63% of memcpy time spent in the exception handler, which made me think 
VMA faults mattered.

> If we're talking about postcopy-like migrations on top of KVM guest-memfd,
> IIUC the VMAs can be pre-faulted too just like the TDP pgtables, e.g. with
> MADV_POPULATE_WRITE.

Yes, I was thinking about MADV_POPULATE_WRITE as well, but AFAIK it 
isn't available in guest_memfd, at least with direct map removed due to 
[1] being updated in [2]:

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..7ddaf93c5b6a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1283,7 +1283,7 @@ static int check_vma_flags(struct vm_area_struct 
*vma, unsigned long gup_flags)
  	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
  		return -EOPNOTSUPP;

-	if (vma_is_secretmem(vma))
+	if (vma_is_secretmem(vma) || vma_is_no_direct_map(vma))
  		return -EFAULT;

  	if (write) {

[1] https://elixir.bootlin.com/linux/v6.13.6/source/mm/gup.c#L1286
[2] 
https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/#m05b5c6366be27c98a86baece52b2f408c455e962

> Normally, AFAIU userapp optimizes IOs the other way round.. to change
> write()s into mmap()s, which at least avoids one round of copy.
> 
> For postcopy using minor traps (and since guest-memfd is always shared and
> non-private..), it's also possible to feed the mmap()ed VAs to NIC as
> buffers (e.g. in recvmsg(), for example, as part of iovec[]), and as long
> as the mmap()ed ranges are not registered by KVM memslots, there's no
> concern on non-atomic copy.

Yes, I see what you mean.  It may be faster depending on the setup, if 
it's possible to remove one copy.

Anyway, it looks like the solution we discussed allows to choose between 
memcpy-only and memcpy/write-combined userspace implementations.  I'm 
going to work on the next version of the series that would include MINOR 
trap and avoiding KVM dependency in mm via calling vm_ops->fault() in 
UFFDIO_CONTINUE.

> Thanks,
> 
> --
> Peter Xu
> 


