Return-Path: <linux-kselftest+bounces-43982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698BC06B93
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A3494E2F5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C15246793;
	Fri, 24 Oct 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iDxjXFPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759F233D9E;
	Fri, 24 Oct 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316576; cv=none; b=o5yEAof/j8HZvOmvXz8TJQNbqcGjRwU2K+lIuE+ejDwFKyAdLJ+7Y5dK683GUe9lUE/h3ZRZpSRkaHmLUe/j8ZTftGJ5KyPo5DM1OSeayMgsmoLNAfnGa+0ZnLYwOiHqqg0e3H7HG8B+vbGM9mz5iHOwRKl5YSUA7g9zt+9rlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316576; c=relaxed/simple;
	bh=nzQF0MiiBQiu5ky7w7PrGFrUlAnMNsaAvg/nOWMF8Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JiCn95f4klvoG2daqnkapACFWwoWzIkJ70/UzY2hbLvzUD8Wa6boigracoahlh4EVvPlPjsK9Jv5N8wTmMo1rm7xgLKJ6HMkP7n+w0hf5ipFRhTaHO88WvGlSyxcjOvG/k+28QXxGMZzec8pSgpLEXrgAAZAPu69auZ0lMKya08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iDxjXFPG; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761316574; x=1792852574;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Qxk7463vFM1P5dU1IXgB3lSRX3aE4phUbxwzBEtbrPI=;
  b=iDxjXFPGkg9xXIBW6blys1sxKLlhXkErD5Pa+Lus7nMi3OAeghk/2Bc1
   OfgSBEq/773MaSG3+tOfNbmvKtVZ6SPaogN/cWwTpFVkoTIB+5W06ddU0
   GIbLIhF15+UPJ4gEj49odX157APArHR0FdUi4AKXwG9Xk+mgy8CRwhwMB
   J8lg3KY0KpP4iUK9ZUtgns7V75tv28g7JMWccCQrtdoxlEL8hXxsFJZYf
   7UhZ5NrC0MTVxBugKBS8royuPaJyjqN4wzayW60bo7GtkRiFesHyJ4SMH
   kj3ThX3e57aMckVDH56OdSMoxWKwNkCYJ+dwrICs06wfej8w1Nj75ozBP
   w==;
X-CSE-ConnectionGUID: wFrkUWdsQhyApZmscs2aBg==
X-CSE-MsgGUID: d0QitL61TKq0bWUjo6ZXUw==
X-IronPort-AV: E=Sophos;i="6.19,252,1754956800"; 
   d="scan'208";a="4074722"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 14:36:04 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:21718]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.3.26:2525] with esmtp (Farcaster)
 id cfc190ed-a8d4-4eb6-b322-cbc2b4eabf12; Fri, 24 Oct 2025 14:36:04 +0000 (UTC)
X-Farcaster-Flow-ID: cfc190ed-a8d4-4eb6-b322-cbc2b4eabf12
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 24 Oct 2025 14:35:40 +0000
Received: from [192.168.3.241] (10.106.82.14) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 24 Oct 2025
 14:35:39 +0000
Message-ID: <8a28ddea-35c0-490e-a7d2-7fb612fdd008@amazon.com>
Date: Fri, 24 Oct 2025 15:35:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v6 1/2] KVM: guest_memfd: add generic population via write
To: Sean Christopherson <seanjc@google.com>, Nikita Kalyazin
	<kalyazin@amazon.co.uk>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
	Jack Thomson <jackabt@amazon.co.uk>, Derek Manwaring <derekmn@amazon.com>,
	Marco Cali <xmarcalx@amazon.co.uk>, <ackerleytng@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>
References: <20251020161352.69257-1-kalyazin@amazon.com>
 <20251020161352.69257-2-kalyazin@amazon.com> <aPpS2aqdobVTk_ed@google.com>
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
In-Reply-To: <aPpS2aqdobVTk_ed@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D008EUC002.ant.amazon.com (10.252.51.146) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 23/10/2025 17:07, Sean Christopherson wrote:
> On Mon, Oct 20, 2025, Nikita Kalyazin wrote:
>> From: Nikita Kalyazin <kalyazin@amazon.com>

+ Vishal and Ackerley

>>
>> write syscall populates guest_memfd with user-supplied data in a generic
>> way, ie no vendor-specific preparation is performed.  If the request is
>> not page-aligned, the remaining bytes are initialised to 0.
>>
>> write is only supported for non-CoCo setups where guest memory is not
>> hardware-encrypted.
> 
> Please include all of the "why".  The code mostly communicates the "what", but
> it doesn't capture why write() support is at all interesting, nor does it explain
> why read() isn't supported.

Hi Sean,

Thanks for the review.

Do you think including the explanation from the cover letter would be 
sufficient?  Shall I additionally say that read() isn't supported 
because there is no use case for it as of now or would it be obvious?

> 
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> 
> There's a notable lack of uAPI and Documentation chanegs.  I.e. this needs a
> GUEST_MEMFD_FLAG_xxx along with proper documentation.

Would the following be ok in the doc?

When the capability KVM_CAP_GUEST_MEMFD_WRITE is supported, the 'flags' 
field
supports GUEST_MEMFD_FLAG_WRITE. Setting this flag on guest_memfd creation
enables write() syscall operations to populate guest_memfd memory from host
userspace.

When a write() operation is performed on a guest_memfd file descriptor 
with the
GUEST_MEMFD_FLAG_WRITE set, the syscall will populate the guest memory with
user-supplied data in a generic way, without any vendor-specific 
preparation.
The write operation is only supported for non-CoCo (Confidential Computing)
setups where guest memory is not hardware-encrypted. If the write request is
not page-aligned, any remaining bytes within the page are initialized to 
zero.

> 
> And while it's definitely it's a-ok to land .write() in advance of the direct map
> changes, we do need to at least map out how we want the two to interact, e.g. so
> that we don't end up with constraints that are impossible to satisfy.
> 

write() shall not attempt to access a page that is not in the direct 
map, which I believe can be achieved via kvm_kmem_gmem_write_begin() 
consulting the KVM_GMEM_FOLIO_NO_DIRECT_MAP in folio->private 
(introduced in [1]).

Do you think we should mention it in the commit message in some way? 
What particular constraint are you cautious about?

[1] https://lore.kernel.org/kvm/20250924152214.7292-2-roypat@amazon.co.uk/

>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 94bafd6c558c..f4e218049afa 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -380,6 +380,8 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>>
>>   static struct file_operations kvm_gmem_fops = {
>>        .mmap           = kvm_gmem_mmap,
>> +     .llseek         = default_llseek,
>> +     .write_iter     = generic_perform_write,
>>        .open           = generic_file_open,
>>        .release        = kvm_gmem_release,
>>        .fallocate      = kvm_gmem_fallocate,
>> @@ -390,6 +392,49 @@ void kvm_gmem_init(struct module *module)
>>        kvm_gmem_fops.owner = module;
>>   }
>>
>> +static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>> +                                  struct address_space *mapping,
>> +                                  loff_t pos, unsigned int len,
>> +                                  struct folio **foliop,
>> +                                  void **fsdata)
> 
> Over-aggressive wrapping, this can be
> 
> 
> static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>                                       struct address_space *mapping, loff_t pos,
>                                       unsigned int len, struct folio **folio,
>                                       void **fsdata)
> 
> or
> 
> static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>                                       struct address_space *mapping,
>                                       loff_t pos, unsigned int len,
>                                       struct folio **folio, void **fsdata)
> 
> if we want to bundle pos+len.

Ack.

> 
>> +{
>> +     struct file *file = kiocb->ki_filp;
> 
> ki_filp is already a file, and even if it were a "void *", there's no need for a
> local variable.

Ack.

> 
>> +     struct inode *inode = file_inode(file);
>> +     pgoff_t index = pos >> PAGE_SHIFT;
>> +     struct folio *folio;
>> +
>> +     if (!kvm_gmem_supports_mmap(inode))
> 
> Checking for MMAP is neither sufficient nor strictly necessary.  MMAP doesn't
> imply SHARED, and it's not clear to me that mmap() support should be in any way
> tied to WRITE support.

As in my reply to the comment about doc, I plan to introduce 
KVM_CAP_GUEST_MEMFD_WRITE and GUEST_MEMFD_FLAG_WRITE.  The 
kvm_arch_supports_gmem_write() will be a weak symbol and relying on 
!kvm_arch_has_private_mem() on x86, similar to 
kvm_arch_supports_gmem_mmap().  Does it look right?

> 
>> +             return -ENODEV;
>> +
>> +     if (pos + len > i_size_read(inode))
>> +             return -EINVAL;
>> +
>> +     folio = kvm_gmem_get_folio(inode, index);
> 
> Eh, since "index" is only used once, my vote is to use "pos" and do the shift
> here, so that it's obvious that the input to kvm_gmem_get_folio() is being checked.

Ack.

> 
>> +     if (IS_ERR(folio))
>> +             return -EFAULT;
> 
> Why EFAULT?

Will propagate the error like you suggest below.

> 
>> +
>> +     *foliop = folio;
> 
> There shouldn't be any need for a local "folio".  What about having the "out"
> param be just "folio"?
> 
> E.g.
> 
> static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>                                       struct address_space *mapping,
>                                       loff_t pos, unsigned int len,
>                                       struct folio **folio, void **fsdata)
> {
>          struct inode *inode = file_inode(kiocb->ki_filp);
> 
>          if (!kvm_gmem_supports_write(inode))
>                  return -ENODEV;
> 
>          if (pos + len > i_size_read(inode))
>                  return -EINVAL;
> 
>          *folio = kvm_gmem_get_folio(inode, pos >> PAGE_SHIFT);
>          if (IS_ERR(*folio))
>                  return PTR_ERR(*folio);
> 
>          return 0;
> }

Ack.

> 
> 
>> +     return 0;
>> +}
>> +
>> +static int kvm_kmem_gmem_write_end(const struct kiocb *kiocb,
>> +                                struct address_space *mapping,
>> +                                loff_t pos, unsigned int len,
>> +                                unsigned int copied,
>> +                                struct folio *folio, void *fsdata)
>> +{
>> +     if (copied && copied < len) {
> 
> Why check if "copied" is non-zero?  I don't see why KVM should behave differently
> with respect to unwritten bytes if copy_folio_from_iter_atomic() fails on the
> first byte or the Nth byte.

No, I don't think there is a need for this check indeed.  It looks like 
a leftover from my previous changes.

> 
>> +             unsigned int from = pos & ((1UL << folio_order(folio)) - 1);
> 
> Uh, isn't this just offset_in_folio()?
> 
>> +
>> +             folio_zero_range(folio, from + copied, len - copied);
> 
> I'd probably be in favor of omitting "from" entirely, e.g.
> 
>          if (copied < len)
>                  folio_zero_range(folio, offset_in_folio(pos) + copied,
>                                   len - copied);
> 

Ack.

>> +     }
>> +
>> +     folio_unlock(folio);
>> +     folio_put(folio);
>> +
>> +     return copied;
>> +}


