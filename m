Return-Path: <linux-kselftest+bounces-41475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC623B57784
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32603B0883
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13752FFDFC;
	Mon, 15 Sep 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z7OFn1Jm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6672F0C6A;
	Mon, 15 Sep 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934060; cv=none; b=N9gLUPcsQb08DPo8a4ym5WYBUvtRtJorAbUbB6qiIdXBvXNpY8DVbIG4rohZPY5bZHsTLHBh/aIqL/5Eh2eYgorrRnbQnvKIDR9iLOaFl+I583YdruGzAUEPlH42Gf580QQPqqsvDymYCbo9d5/IuXrfP3e+TDs2Xp11q9cDD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934060; c=relaxed/simple;
	bh=tO+J030RANL3qO9YTazthtZ1bMv2wDCZoy0frgFXq0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=revi946A6ayWi/qtuPI73oYMwalMaMDepfH8ELCDb+FPEM3st6bo5YVo7gOqqFHRjR4YrtcutZ1fTqS+BRq7qVfY2tGSyvWZBt2IfZ9/P+KzI8Q+Y59sfsyP3UaxuAhDQ8p+k/owWPYQP6VIts+Ene2LE8WH8gUXHviuFo4kQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z7OFn1Jm; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757934057; x=1789470057;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=S0HcVXIWVLuQhI/jDHrRwQTnt9fr8t8TU4iKQqRk+Sw=;
  b=Z7OFn1JmgJAbCB7fhQf/vKAhcom+ddAF+5ABJnGv152IboA+YfwDmtZo
   MnMiaBU9LWjGSsADWcCz3W/hZPG1UY2Bqupli3HkYSMYPFH6Qqu1xrCV8
   oAN/m0zS1Rzjaamehj0K6nkJTVrbhZt2hBmKUGtU33yhYKE33VTa6LJIy
   6ZrxFCc5t3isJiXZKij5b/IjBsoyaMJ/ymdh7XOG3P1BNuSXx8qFWNp8n
   Wx7wBdmuF918z1odLB13d2peDk4Pk6gd/WNjqaSHO/YztyXfuOD65CUDs
   QCwaKHd1pNP9JDpjMamTHXRrdx19RwyNThgqeIIIl1PHQLieqJRPRCHvK
   Q==;
X-CSE-ConnectionGUID: U4Uc6E/wRaSDxuiA5wLPAQ==
X-CSE-MsgGUID: x309l3HlSUOILP8TdJIs4Q==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2117592"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:00:47 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:23682]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.47.2:2525] with esmtp (Farcaster)
 id c1cb5186-d18b-4524-af53-bd7d19a45e92; Mon, 15 Sep 2025 11:00:46 +0000 (UTC)
X-Farcaster-Flow-ID: c1cb5186-d18b-4524-af53-bd7d19a45e92
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 11:00:46 +0000
Received: from [192.168.5.30] (10.106.83.11) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 15 Sep 2025
 11:00:45 +0000
Message-ID: <64b92c8b-1b9b-4ad1-afc4-0d4eb31336b5@amazon.com>
Date: Mon, 15 Sep 2025 12:00:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: James Houghton <jthoughton@google.com>
CC: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
 <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
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
In-Reply-To: <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D001EUA004.ant.amazon.com (10.252.50.19) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 12/09/2025 23:34, James Houghton wrote:
> On Thu, Sep 11, 2025 at 3:15 AM Nikita Kalyazin <kalyazin@amazon.com> wrote:
>>
>>
>>
>> On 10/09/2025 22:23, James Houghton wrote:
>>> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita <kalyazin@amazon.co.uk> wrote:
>>>>
>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>
>>> Hi Nikita,
>>
>> Hi James,
>>
>> Thanks for the review!
> 
> :) I hope it's actually helpful.
> 
>>
>>
>>>>
>>>> write syscall populates guest_memfd with user-supplied data in a generic
>>>> way, ie no vendor-specific preparation is performed.  This is supposed
>>>> to be used in non-CoCo setups where guest memory is not
>>>> hardware-encrypted.
>>>
>>> What's meant to happen if we do use this for CoCo VMs? I would expect
>>> write() to fail, but I don't see why it would (seems like we need/want
>>> a check that we aren't write()ing to private memory).
>>
>> I am not so sure that write() should fail even in CoCo VMs if we access
>> not-yet-prepared pages.  My understanding was that the CoCoisation of
>> the memory occurs during "preparation".  But I may be wrong here.
> 
> This sounds fine to me, but could you update the changelog with what
> the behavior is for CoCo VMs and why we don't allow writing to the
> same pages/regions twice? Something like:
> 
> "Although write() is only meant to be used for non-CoCo VMs, it is
> valid for CoCo VMs as well: the written contents will be encrypted
> (when the page is prepared). Because the contents may be encrypted, it
> is nonsensical to write() again, so write()ing to prepared pages is
> disallowed (even if the no memory encryption occurs). Furthermore, in
> the near future, page preparation will also result in pages being
> removed from the direct map, so there will be no direct map through
> which to perform the second write()."
> 
> (This is all provided that it's actually okay to write() content that
> will be encrypted... I don't know why that would be improper, but I'm
> not exactly an expert here.)

 From what Vishal is saying in the other thread, it looks clearer to 
disallow write() for CoCo VM types as it looks like we gain nothing from 
supporting it now.

> 
>>>> @@ -390,6 +392,63 @@ void kvm_gmem_init(struct module *module)
>>>>           kvm_gmem_fops.owner = module;
>>>>    }
>>>>
>>>> +static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,
>>>> +                                    struct address_space *mapping,
>>>> +                                    loff_t pos, unsigned int len,
>>>> +                                    struct folio **foliop,
>>>> +                                    void **fsdata)
>>>> +{
>>>> +       struct file *file = kiocb->ki_filp;
>>>> +       pgoff_t index = pos >> PAGE_SHIFT;
>>>> +       struct folio *folio;
>>>> +
>>>> +       if (!PAGE_ALIGNED(pos) || len != PAGE_SIZE)
>>>> +               return -EINVAL;
>>>
>>> Requiring pos to be page-aligned seems like a strange restriction, and
>>> requiring len to be exactly PAGE_SIZE just seems wrong. I don't see
>>> any reason why the below logic can't be made to work with an
>>> unrestricted pos and len (in other words, I don't see how guest_memfd
>>> is special vs other filesystems in this regard).
>>
>> I don't have a real reason to apply those restrictions.  Happy to remove
>> them, thanks.
> 
> Thanks! Presumably you'll make it so that any unaligned segments will
> be left as zeroes; please describe this in the changelog as well. :)

Will do!

> 
>>>> +
>>>> +       if (pos + len > i_size_read(file_inode(file)))
>>>> +               return -EINVAL;
>>>> +
>>>> +       folio = kvm_gmem_get_folio(file_inode(file), index);
>>>> +       if (IS_ERR(folio))
>>>> +               return -EFAULT;
>>>> +
>>>> +       if (WARN_ON_ONCE(folio_test_large(folio))) {
>>>> +               folio_unlock(folio);
>>>> +               folio_put(folio);
>>>> +               return -EFAULT;
>>>> +       }
>>>> +
>>>> +       if (folio_test_uptodate(folio)) {
>>>> +               folio_unlock(folio);
>>>> +               folio_put(folio);
>>>> +               return -ENOSPC;
>>>
>>> Does it actually matter for the folio not to be uptodate? It seems
>>> unnecessarily restrictive not to be able to overwrite data if we're
>>> saying that this is only usable for unencrypted memory anyway.
>>
>> In the context of direct map removal [1] it does actually because when
>> we mark a folio as prepared, we remove it from the direct map making it
>> inaccessible to the way write() performs the copy.  It does not matter
>> if direct map removal isn't enabled though.  Do you think it should be
>> conditional?
> 
> Oh, good point. It's simpler (both to implement and to describe) to
> disallow a second write() call in all cases (no matter if the direct
> map for the page has been removed or if the contents have been
> encrypted), so I'm all for leaving it unconditional like you have now.
> Thanks!
> 
>>
>> [1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk
>>
>>>
>>> Is ENOSPC really the right errno for this? (Maybe -EFAULT?)
>>
>> I don't have a strong opinion here.  My reasoning was if the folio is
>> already "sealed" by the direct map removal, then it is no longer a part
>> of the "writable space", so -ENOSPC makes sense.  Maybe this intuition
>> only works for me so I'm happy to change to -EFAULT if it looks less
>> confusing.
> 
> Oh actually.... how about EEXIST? That feels like the most natural.
> But also no strong opinion here.

Yes, I like EEXIST.  Will use it next time, thanks!

> 
> Thanks for all the clarification, Nikita. :)


