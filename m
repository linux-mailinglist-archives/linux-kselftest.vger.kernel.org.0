Return-Path: <linux-kselftest+bounces-44669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF21C2D55A
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 18:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775643A5934
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD123195EC;
	Mon,  3 Nov 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="chCqRGOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED37305068;
	Mon,  3 Nov 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188926; cv=none; b=Zh9fZPX0Snw9kqzVmITopriznlHe2jQ2SpynFThFbsROBeHzyvRQl2Ku2mJ0NFreuDrQSYDc+nVICa4ruPINYWIaHd/2os9Td6AjFSbfk/4HbedT8NaBBaydn97wpUXWRGwVvf92QonBOtgwZtwvpe1+nXJeCZISWYMN8EE1MZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188926; c=relaxed/simple;
	bh=bERujlan6xYBCXPOFlM4FGae/3KW3OBLj5Y11k2yHJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q8e/8xVBODnU7xHgh6kuPPKqltzYldVJG69smml4a+NZ/7A8fYdn9viiVn8LGQFavGOq0AX5RdQgS3UYgou+c2Hmy2/ijy4g1njhVEcNIYe9ZXC7ZZgtq3IAcPvYfqH26kbTXfXDGB/IeksFBrnpr8q4AzDxe3mz6AKQhp1so4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=chCqRGOi; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762188924; x=1793724924;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=UEH2vz5x8bkUyz4ezTN39e/gCvIEAbggvIgsadkudPo=;
  b=chCqRGOiza9e64wPfZ0xn/xoLDFY7WOUDUi1aP+e+3HOGVMr+tu4OtQ2
   uiOdWTeWCdyfOoDZ1S070zbr9T5yRT4mHMMomEtsXczFD6pW2iGF2sicx
   3/ujdrpTPFR/voLEzBlm5TP1Q6gM4sQ56akOZw9fcnOYR8mKupVmbgQtv
   uSz8vVXT+HxpG4ByhE3Eaxtm6atBgHS4PoXyav0PlhOuUEvHuVB9XCv6o
   o3DuKRiFRciUGsLMd4VBu+lSzi7xP2j6hAjuswNhk+APSavJmKR75guYH
   MYN5GO5xZYZ9UmgoPliL0a4FxSK9etL4YwSkMrsg2QLK0ZwJsqVHbhLMW
   Q==;
X-CSE-ConnectionGUID: meLlLgWBTP27Rl/TBc+JIw==
X-CSE-MsgGUID: K7u5/hGKSz6id+1S8o9fbg==
X-IronPort-AV: E=Sophos;i="6.19,276,1754956800"; 
   d="scan'208";a="4501536"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 16:55:05 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:12012]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.15.8:2525] with esmtp (Farcaster)
 id bb542154-10c3-4be7-aa9d-727e3397c42e; Mon, 3 Nov 2025 16:55:05 +0000 (UTC)
X-Farcaster-Flow-ID: bb542154-10c3-4be7-aa9d-727e3397c42e
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 3 Nov 2025 16:55:05 +0000
Received: from [192.168.10.21] (10.106.83.21) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 3 Nov 2025
 16:55:04 +0000
Message-ID: <2c61545f-befb-4681-95fd-ff281e1a947b@amazon.com>
Date: Mon, 3 Nov 2025 16:55:02 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v6 1/2] KVM: guest_memfd: add generic population via write
To: Sean Christopherson <seanjc@google.com>
CC: Nikita Kalyazin <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
	Jack Thomson <jackabt@amazon.co.uk>, Derek Manwaring <derekmn@amazon.com>,
	Marco Cali <xmarcalx@amazon.co.uk>, <ackerleytng@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>
References: <20251020161352.69257-1-kalyazin@amazon.com>
 <20251020161352.69257-2-kalyazin@amazon.com> <aPpS2aqdobVTk_ed@google.com>
 <8a28ddea-35c0-490e-a7d2-7fb612fdd008@amazon.com>
 <aQPakDuteQkg0hTu@google.com>
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
In-Reply-To: <aQPakDuteQkg0hTu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUA002.ant.amazon.com (10.252.50.108) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 30/10/2025 21:37, Sean Christopherson wrote:
> On Fri, Oct 24, 2025, Nikita Kalyazin wrote:
>>
>>
>> On 23/10/2025 17:07, Sean Christopherson wrote:
>>> On Mon, Oct 20, 2025, Nikita Kalyazin wrote:
>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> + Vishal and Ackerley
>>
>>>>
>>>> write syscall populates guest_memfd with user-supplied data in a generic
>>>> way, ie no vendor-specific preparation is performed.  If the request is
>>>> not page-aligned, the remaining bytes are initialised to 0.
>>>>
>>>> write is only supported for non-CoCo setups where guest memory is not
>>>> hardware-encrypted.
>>>
>>> Please include all of the "why".  The code mostly communicates the "what", but
>>> it doesn't capture why write() support is at all interesting, nor does it explain
>>> why read() isn't supported.
>>
>> Hi Sean,
>>
>> Thanks for the review.
>>
>> Do you think including the explanation from the cover letter would be
>> sufficient?
> 
> It's pretty close.  A few more details would be helpful, e.g. to explain that VMMs
> may use write() to populate the initial image

Ack.

> 
>> Shall I additionally say that read() isn't supported because there is no use
>> case for it as of now or would it be obvious?
> 
> Hmm, I think if you want to exclude read() support, the changelog should explicitly
> state why.  E.g. "there's no use case" is quite different from "deliberately
> don't support read() for security reasons".

Ack.

> 
>>>> Signed-off-by: Nikitia Kalyazin <kalyazin@amazon.com>
>>>> ---
>>>>    virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>>>
>>> There's a notable lack of uAPI and Documentation chanegs.  I.e. this needs a
>>> GUEST_MEMFD_FLAG_xxx along with proper documentation.
>>
>> Would the following be ok in the doc?
>>
>> When the capability KVM_CAP_GUEST_MEMFD_WRITE is supported, the 'flags'
> 
> No capability is necessary, see d2042d8f96dd ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP
> into KVM_CAP_GUEST_MEMFD_FLAGS").

Thanks, I didn't realise that kvm/next was behind kvm/master.

> 
>> field
>> supports GUEST_MEMFD_FLAG_WRITE. Setting this flag on guest_memfd creation
>> enables write() syscall operations to populate guest_memfd memory from host
>> userspace.
>>
>> When a write() operation is performed on a guest_memfd file descriptor with
>> the
>> GUEST_MEMFD_FLAG_WRITE set, the syscall will populate the guest memory with
>> user-supplied data in a generic way, without any vendor-specific
>> preparation.
>> The write operation is only supported for non-CoCo (Confidential Computing)
>> setups where guest memory is not hardware-encrypted.
> 
> The restriction should be that guest memory must be SHARED, i.e. not PRIVATE.
> Strictly speaking, guest memory can be encrypted, e.g. with SME and TME (I think
> TME is still a thing?), but with a shared key and thus accessible from the host.
> 
> Even if that weren't the case, we want to support this for CoCo VMs.

To clarify, should it depend on GUEST_MEMFD_FLAG_INIT_SHARED for now?

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5bd76cf394fa..5fbf65f49586 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -736,7 +736,7 @@ static inline u64 
kvm_gmem_get_supported_flags(struct kvm *kvm)
         u64 flags = GUEST_MEMFD_FLAG_MMAP;

         if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
-               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+               flags |= GUEST_MEMFD_FLAG_INIT_SHARED | 
GUEST_MEMFD_FLAG_WRITE;

         return flags;
  }

> 
>> If the write request is not page-aligned, any remaining bytes within the page
>> are initialized to zero.
> 
> Why?  (Honest question, e.g. is that standard file semantics?)

The clause was originally suggested by James in v5 [1].  The behaviour 
shouldn't be deviating from the standard semantics though, so I will 
omit it.  Moreover, when looking at the shmem implementation, I realised 
that I hadn't handled the case of clearing bytes _before_ written bytes 
properly.  I will fix it in the next version.

[1] 
https://lore.kernel.org/kvm/CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com/

> 
>>> And while it's definitely it's a-ok to land .write() in advance of the direct map
>>> changes, we do need to at least map out how we want the two to interact, e.g. so
>>> that we don't end up with constraints that are impossible to satisfy.
>>>
>>
>> write() shall not attempt to access a page that is not in the direct map,
>> which I believe can be achieved via kvm_kmem_gmem_write_begin() consulting
>> the KVM_GMEM_FOLIO_NO_DIRECT_MAP in folio->private (introduced in [1]).
>>
>> Do you think we should mention it in the commit message in some way? What
>> particular constraint are you cautious about?
> 
> I want to be cautious with respect to the ABI/uAPI.  Patrick's series also adds
> a flag, and guest_memfd doesn't currently provide a way to toggle flags after the
> file is created.  That begs the question of how GUEST_MEMFD_FLAG_NO_DIRECT_MAP
> will co-exist with GUEST_MEMFD_FLAG_WRITE.  Presumably the goal is to use write()
> to initialize memory, and _then_ nuke the direct map.
> 
> I want line of sight to understanding the exact semantics/flows.  E.g. will KVM
> require userspace to clear GUEST_MEMFD_FLAG_WRITE before allowing
> NO_DIRECT_MAP?  Or will the write() simply fail?  How will the sequencing be
> achieved?

No, I don't think we can clear the GUEST_MEMFD_FLAG_WRITE as we expect 
faults and writes to different pages to be arriving interspersed: some 
pages will be populated by write() proactively, some will be allocated 
by faults in the user mapping on demand.  Both write() and the fault 
handler, if they need to allocate a page, will be writing content to it 
and "sealing" by removing it from the direct map.  If write() faces an 
already "sealed" page, it will fail (with EEXIST [1]).

> 
>>>> +     struct inode *inode = file_inode(file);
>>>> +     pgoff_t index = pos >> PAGE_SHIFT;
>>>> +     struct folio *folio;
>>>> +
>>>> +     if (!kvm_gmem_supports_mmap(inode))
>>>
>>> Checking for MMAP is neither sufficient nor strictly necessary.  MMAP doesn't
>>> imply SHARED, and it's not clear to me that mmap() support should be in any way
>>> tied to WRITE support.
>>
>> As in my reply to the comment about doc, I plan to introduce
>> KVM_CAP_GUEST_MEMFD_WRITE and GUEST_MEMFD_FLAG_WRITE.  The
>> kvm_arch_supports_gmem_write() will be a weak symbol and relying on
>> !kvm_arch_has_private_mem() on x86, similar to
>> kvm_arch_supports_gmem_mmap().  Does it look right?
> 
> No.  As above, write() should be allowed iff memory is SHARED.  Relevant commits
> that are now in Linus' tree:
> 
>    44c6cb9fe9888b371e31165b2854bd0f4e2787d4 KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with private memory
>    9aef71c892a55e004419923ba7129abe3e58d9f1 KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
>    5d3341d684be80892d8f6f9812f90f9274b81177 KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED

Ack.


