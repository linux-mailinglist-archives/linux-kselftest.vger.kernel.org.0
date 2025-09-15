Return-Path: <linux-kselftest+bounces-41477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCAEB5778C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753CF444C6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F402FE04D;
	Mon, 15 Sep 2025 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s/gQstQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB442FDC58;
	Mon, 15 Sep 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934080; cv=none; b=rQYz/oCWC0ChzO5TLkNytb455rXBmMnM5vpq+aWEagXvpACeDMsg4jWHEv66RDugBTYxT72sD5rMEOaiTxrmJmsPFPvS039Ipi/tLl6YjotC0I9ncXL0hUUc6UTlLhpiHC6P53EbfGxvxo543AQQS1ko79vZpn6Wbkf3QFhPlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934080; c=relaxed/simple;
	bh=xpAUPePhRWxhrO0/ae0lk1DKjdlzLHclKISJmCT6TBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hNv4DMo51Oxu3Ho97dvqWwkqy94BqA3PQ9LwsIT0rZOHmYRRssAxwhW011bO74pIpAKZikdjqwkpM8VTUWotdPfCf14EwNCFmJMcfCtbSouyLuCD2qtagErzp3tLoUbf6jY5EV8p1/97NBnXxZYXr4tBdqmakv5KoEuUjJVwZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s/gQstQr; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757934078; x=1789470078;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=1Kwr4FzPi3FfskUj5Y/Y5lkZmxFcjq2K32+BQbpo/kE=;
  b=s/gQstQraabAAF539bX3Q7Iv6KK1NgzAIfk/WKoi73rXX/DSzfcgCZsT
   82tyINTKBqbGo+a6TfffbPA8qPO0/uhSlaL470rgseeDlFOGZ/wp1omLj
   9fhNlECtfy1gwlvyfnlLmSAx3HV/lnoWsZpqvXyUAJGvJTZhzpyJgciK0
   9iYvTqH36fI1WfpRDGfprbf1KJC4dMgRgDNMN1TJuc7wj5DOSf0d4seCl
   PX8DHqHg4EThwXao857XYFkwDBoZ1QgTId7YQu7e09WPEAmRC16EQ2omb
   dWMRnDgdaomEs6PFBDreyAsb2aXWVKUQi2SGGnPCcXlKKGPia4SbVcjX6
   w==;
X-CSE-ConnectionGUID: qythty/WSlCz4BOBKikTpA==
X-CSE-MsgGUID: j12QYeiPQ9Kqf7MyLfzP3A==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2010688"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:01:06 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:6017]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.39.25:2525] with esmtp (Farcaster)
 id cac95356-4c9f-4e37-bf25-376a937af6a4; Mon, 15 Sep 2025 11:01:06 +0000 (UTC)
X-Farcaster-Flow-ID: cac95356-4c9f-4e37-bf25-376a937af6a4
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 11:01:06 +0000
Received: from [192.168.5.30] (10.106.83.11) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 15 Sep 2025
 11:01:05 +0000
Message-ID: <3b56b4a0-ac52-4e1e-9f1b-7379af307292@amazon.com>
Date: Mon, 15 Sep 2025 12:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: Vishal Annapurve <vannapurve@google.com>, David Hildenbrand
	<david@redhat.com>
CC: James Houghton <jthoughton@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
 <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
 <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com>
 <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
 <CAGtprH8QjeuR90QJ7byxoAPfb30kmUEDhRhzqNZqSpR8y_+z9g@mail.gmail.com>
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
In-Reply-To: <CAGtprH8QjeuR90QJ7byxoAPfb30kmUEDhRhzqNZqSpR8y_+z9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D014EUC002.ant.amazon.com (10.252.51.161) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 13/09/2025 01:18, Vishal Annapurve wrote:
> On Fri, Sep 12, 2025 at 8:39 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>>>> What's meant to happen if we do use this for CoCo VMs? I would expect
>>>>>> write() to fail, but I don't see why it would (seems like we need/want
>>>>>> a check that we aren't write()ing to private memory).
>>>>>
>>>>> I am not so sure that write() should fail even in CoCo VMs if we access
>>>>> not-yet-prepared pages.  My understanding was that the CoCoisation of
>>>>> the memory occurs during "preparation".  But I may be wrong here.
>>>>
>>>> But how do you handle that a page is actually inaccessible and should
>>>> not be touched?
>>>>
>>>> IOW, with CXL you could crash the host.
>>>>
>>>> There is likely some state check missing, or it should be restricted to
>>>> VM types.
>>>
>>> Sorry, I'm missing the link between VM types and CXL.  How are they related?
>>
>> I think what you explain below clarifies it.
>>
>>>
>>> My thinking was it is a regular (accessible) page until it is "prepared"
>>> by the CoCo hardware, which is currently tracked by the up-to-date flag,
>>> so it is safe to assume that until it is "prepared", it is accessible
>>> because it was allocated by filemap_grab_folio() ->
>>> filemap_alloc_folio() and hasn't been taken over by the CoCo hardware.
>>> What scenario can you see where it doesn't apply as of now?
>>
>> Thanks for clarifying, see below.
>>
>>>
>>> I am aware of an attempt to remove preparation tracking from
>>> guest_memfd, but it is still at an RFC stage AFAIK [1].
>>>
>>>>
>>>> Do we know how this would interact with the direct-map removal?
>>>
>>> I'm using folio_test_uptodate() to determine if the page has been
>>> removed from the direct map as kvm_gmem_mark_prepared() is what
>>> currently removes the page from the direct map and marks it as
>>> up-to-date.  [2] is a Firecracker feature branch where the two work in
>>> combination.
>>
>> Ah, okay. Yes, I recalled [1] that we wanted to change these semantics
>> to be "uptodate: was zeroed", and that preparation handling would be
>> essentially handled by the arch backend.
> 
> Yes, I think we should not be overloading uptodate flag to be an
> indicator of what is private for CoCo guests. Uptodate flag should
> just mean zeroed/fresh folio. It's possible that future allocator
> backing for huge pages already provides uptodate folios.

Good point, thanks for sharing.

> 
> If there is no current use case for read/write for CoCo VMs, I think
> it makes sense to disable it for now by checking the VM type before
> adding further overloading of uptodate flags.

Sounds fair.  I can add a check for the VM type and only allow it for 
KVM_X86_SW_PROTECTED_VM on x86.  When ARM CCA support [1] is added we 
should also check for KVM_VM_TYPE_ARM_NORMAL on ARM.

[1]: 
https://lore.kernel.org/kvm/20250820145606.180644-1-steven.price@arm.com

> 
>>
>> --
>> Cheers
>>
>> David / dhildenb
>>
>>


