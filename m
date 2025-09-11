Return-Path: <linux-kselftest+bounces-41220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEAEB52E18
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8D3189F1A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A32773EC;
	Thu, 11 Sep 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mg3Bl/KA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1D265CC9;
	Thu, 11 Sep 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585727; cv=none; b=owX07q4+xMSqOLyMKvD9TEfntybDI8P9ACDiSC1/4PUoI/6VoKBLxveGzli/mbppi5OQuhQv9twAZB8bVYb2RzErq9d5kkkgpIBdjjE0HPPJj2TqUPo10NZ+fuC1zCPBdQlh5GHMzb5ol1UyaFhkwTIX7lq+FrrHl6Y4WlzXywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585727; c=relaxed/simple;
	bh=qfByK8A76quZCJEvUoRsX5AtGpNwGrhhYA7hmt70vco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZVnSM68PPVSHlASFZNI5ANF2TOxBV0ChzlMELQ36fJ3rZ+49BsYLvCF0ZYQy/rz6bn0ex3H0BZdZDFDOVJ/z3HhVx5V069qurabb0zFeDCr6hO6NtR5ZXB9uQk6591WNsYGFBajv6aWHVWPAbTEJdzQUrQLUfhBSLk6H6OF2DGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mg3Bl/KA; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757585725; x=1789121725;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=pBOXF5cUR6LGzOYbM3tKNFJCTf0YPJn8QfNkLLZc7fE=;
  b=Mg3Bl/KAOv75OLQbJDX7RzC7bOOSL5gveYgoKSP1ndbR8VI9z0WHfPCP
   2C+de8ZvZ3HXIjCUjp2ZauTchEzlLdhrxf8V+iXFhtVdu0LF+BlFK+9XH
   Z7P8nA9gVnbzYc00FaZNgKr5Ovj5BKATO2Vo5u0meN6NCkMQZ3d8FYrCa
   AMSXwkw9sW7VX/jkRpR4M3kJ/t5AM8kIVasWNJGPVUp+TVtMEbGYhX5us
   ccbsXlE5EQisTH+uuzdRSNMrXLCx00GwwDcSGK+Ow7/hoHCR2DoDOmDeQ
   GbJm2SaRgImym3b3n/OA6nV1HILEjW3Qc6aMUE7eySFYyNvIXXRuFeZQb
   A==;
X-CSE-ConnectionGUID: jRxUyoo3QmawX2nqYiay6w==
X-CSE-MsgGUID: LuAmflx1Qx2BllfjvK602Q==
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="1955965"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:15:14 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:9714]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.170:2525] with esmtp (Farcaster)
 id 1b8c8f7a-af85-4246-b525-572a67d46c92; Thu, 11 Sep 2025 10:15:14 +0000 (UTC)
X-Farcaster-Flow-ID: 1b8c8f7a-af85-4246-b525-572a67d46c92
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 10:15:14 +0000
Received: from [192.168.31.34] (10.106.82.9) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 11 Sep 2025
 10:15:13 +0000
Message-ID: <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
Date: Thu, 11 Sep 2025 11:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: James Houghton <jthoughton@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
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
In-Reply-To: <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D014EUC002.ant.amazon.com (10.252.51.161) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 10/09/2025 22:23, James Houghton wrote:
> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita <kalyazin@amazon.co.uk> wrote:
>>
>> From: Nikita Kalyazin <kalyazin@amazon.com>
> 
> Hi Nikita,

Hi James,

Thanks for the review!


>>
>> write syscall populates guest_memfd with user-supplied data in a generic
>> way, ie no vendor-specific preparation is performed.  This is supposed
>> to be used in non-CoCo setups where guest memory is not
>> hardware-encrypted.
> 
> What's meant to happen if we do use this for CoCo VMs? I would expect
> write() to fail, but I don't see why it would (seems like we need/want
> a check that we aren't write()ing to private memory).

I am not so sure that write() should fail even in CoCo VMs if we access 
not-yet-prepared pages.  My understanding was that the CoCoisation of 
the memory occurs during "preparation".  But I may be wrong here.


> 
>> The following behaviour is implemented:
>>   - only page-aligned count and offset are allowed
>>   - if the memory is already allocated, the call will successfully
>>     populate it
>>   - if the memory is not allocated, the call will both allocate and
>>     populate
>>   - if the memory is already populated, the call will not repopulate it
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   virt/kvm/guest_memfd.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 08a6bc7d25b6..a2e86ec13e4b 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -379,7 +379,9 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>>   }
>>
>>   static struct file_operations kvm_gmem_fops = {
>> -       .mmap           = kvm_gmem_mmap,
>> +       .mmap           = kvm_gmem_mmap,
>> +       .llseek         = default_llseek,
>> +       .write_iter     = generic_perform_write,
> 
> You seem to have accidentally replaced some tabs with spaces here. :)
> Please keep the style consistent.

Thanks for spotting that, will fix in the next version!


> 
>>          .open           = generic_file_open,
>>          .release        = kvm_gmem_release,
>>          .fallocate      = kvm_gmem_fallocate,
>> @@ -390,6 +392,63 @@ void kvm_gmem_init(struct module *module)
>>          kvm_gmem_fops.owner = module;
>>   }
>>
>> +static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>> +                                    struct address_space *mapping,
>> +                                    loff_t pos, unsigned int len,
>> +                                    struct folio **foliop,
>> +                                    void **fsdata)
>> +{
>> +       struct file *file = kiocb->ki_filp;
>> +       pgoff_t index = pos >> PAGE_SHIFT;
>> +       struct folio *folio;
>> +
>> +       if (!PAGE_ALIGNED(pos) || len != PAGE_SIZE)
>> +               return -EINVAL;
> 
> Requiring pos to be page-aligned seems like a strange restriction, and
> requiring len to be exactly PAGE_SIZE just seems wrong. I don't see
> any reason why the below logic can't be made to work with an
> unrestricted pos and len (in other words, I don't see how guest_memfd
> is special vs other filesystems in this regard).

I don't have a real reason to apply those restrictions.  Happy to remove 
them, thanks.


> 
>> +
>> +       if (pos + len > i_size_read(file_inode(file)))
>> +               return -EINVAL;
>> +
>> +       folio = kvm_gmem_get_folio(file_inode(file), index);
>> +       if (IS_ERR(folio))
>> +               return -EFAULT;
>> +
>> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
>> +               folio_unlock(folio);
>> +               folio_put(folio);
>> +               return -EFAULT;
>> +       }
>> +
>> +       if (folio_test_uptodate(folio)) {
>> +               folio_unlock(folio);
>> +               folio_put(folio);
>> +               return -ENOSPC;
> 
> Does it actually matter for the folio not to be uptodate? It seems
> unnecessarily restrictive not to be able to overwrite data if we're
> saying that this is only usable for unencrypted memory anyway.

In the context of direct map removal [1] it does actually because when 
we mark a folio as prepared, we remove it from the direct map making it 
inaccessible to the way write() performs the copy.  It does not matter 
if direct map removal isn't enabled though.  Do you think it should be 
conditional?

[1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk

> 
> Is ENOSPC really the right errno for this? (Maybe -EFAULT?)

I don't have a strong opinion here.  My reasoning was if the folio is 
already "sealed" by the direct map removal, then it is no longer a part 
of the "writable space", so -ENOSPC makes sense.  Maybe this intuition 
only works for me so I'm happy to change to -EFAULT if it looks less 
confusing.


> 
>> +       }
>> +
>> +       *foliop = folio;
>> +       return 0;
>> +}
>> +
>> +static int kvm_kmem_gmem_write_end(const struct kiocb *kiocb,
>> +                                  struct address_space *mapping,
>> +                                  loff_t pos, unsigned int len,
>> +                                  unsigned int copied,
>> +                                  struct folio *folio, void *fsdata)
>> +{
>> +       if (copied) {
>> +               if (copied < len) {
>> +                       unsigned int from = pos & (PAGE_SIZE - 1);
> 
> How about:
> 
> unsigned int from  = pos & ((1UL << folio_order(*folio)) - 1)
> 
> So that we don't need to require !folio_test_large() in
> kvm_kmem_gmem_write_begin().

Thanks, will apply to the next version.


> 
>> +
>> +                       folio_zero_range(folio, from + copied, len - copied);
>> +               }
>> +               kvm_gmem_mark_prepared(folio);
>> +       }
>> +
>> +       folio_unlock(folio);
>> +       folio_put(folio);
>> +
>> +       return copied;
>> +}
>> +
>>   static int kvm_gmem_migrate_folio(struct address_space *mapping,
>>                                    struct folio *dst, struct folio *src,
>>                                    enum migrate_mode mode)
>> @@ -442,6 +501,8 @@ static void kvm_gmem_free_folio(struct folio *folio)
>>
>>   static const struct address_space_operations kvm_gmem_aops = {
>>          .dirty_folio = noop_dirty_folio,
>> +       .write_begin = kvm_kmem_gmem_write_begin,
>> +       .write_end = kvm_kmem_gmem_write_end,
>>          .migrate_folio  = kvm_gmem_migrate_folio,
>>          .error_remove_folio = kvm_gmem_error_folio,
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> @@ -489,6 +550,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>          }
>>
>>          file->f_flags |= O_LARGEFILE;
>> +       file->f_mode |= FMODE_LSEEK | FMODE_PWRITE;
>>
>>          inode = file->f_inode;
>>          WARN_ON(file->f_mapping != inode->i_mapping);
>> --
>> 2.50.1
>>


