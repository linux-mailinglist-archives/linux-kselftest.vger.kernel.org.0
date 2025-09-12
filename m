Return-Path: <linux-kselftest+bounces-41397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D5B5522E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7847BF0A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D7B30E0D1;
	Fri, 12 Sep 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NhVLix94"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3EF30E84B;
	Fri, 12 Sep 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688532; cv=none; b=VSWADoB+iGRkyaEbLvNFtYsny2YW2akzagYzaOVwWiqDdmkPVKZk2ev5SOvdCvQCwNhnSRkssADk4CDikSDA1sx+jdfOEqvWWVQFOsGKK9UWRjrU8bKc/DW4vy3E3Vb64Lo/adS+WdNQj1fvtLEZi166ygi5YwJxArlf6cDTn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688532; c=relaxed/simple;
	bh=ILOwdw+8/X9P9sqh/TGoh+Yj8hhDU7UscYwopqzb1Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mUdbJVNwlGDCtOV4XeLtEgO0vUdgYQ98H8ZrKCzNEmoV1vRxM/PC+Jvf1PjmTvoFuVt4Ls+e+r1qIGR64Mzkub2yW4dUwLE9IaXX15kZPzNrgC4P97i1HV/xE5mfPWwlkkZ10r1miu7WnI0nEk0nv7ccmtP6tH8/teZBsL+xrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NhVLix94; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757688530; x=1789224530;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Rmxb9oICTSLggNhSJyI8b5ZCsmMUPRCvEQnPT27T0yA=;
  b=NhVLix94cF6uofPhYk+vj2r3GWZWAXBjebkmvnHpC0pEYHyQpS7IGUfD
   DOttZwk9BcT/pLU+pu9ZJv/WIiOp/drggv7WzZCUm0qRjD4wXDMAgFwgt
   vNP6LuNcdTiFQsjapSni5COmGEyWRCfWq/RyO1L4e8lj8U2eBjMpBut4H
   cKP1Q5oXP9azBnQFqFF7Jlqkaoce2Ex+G3wrAcSNCXynIqAHTzu4dZaan
   wtRINJEwEuyEX2Y1BP1Ly10Y2RhTlB7izepHcwrCzaVnhXefljkaHxBNt
   GoWgHl48R/d/BSL9DyDcu6NoKsZAVtGAodGR42vyRWHj698siJ6qVNz3v
   w==;
X-CSE-ConnectionGUID: psJj/C1kRGmHQMaRmCeG8g==
X-CSE-MsgGUID: Yi2MyhueTGy18U9Y/ecwdg==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2028649"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 14:48:38 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:6406]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.26:2525] with esmtp (Farcaster)
 id 1f70f2ba-cad2-4689-94e8-60b6da797a6a; Fri, 12 Sep 2025 14:48:37 +0000 (UTC)
X-Farcaster-Flow-ID: 1f70f2ba-cad2-4689-94e8-60b6da797a6a
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 14:48:37 +0000
Received: from [192.168.23.20] (10.106.83.17) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 12 Sep 2025
 14:48:36 +0000
Message-ID: <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com>
Date: Fri, 12 Sep 2025 15:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: David Hildenbrand <david@redhat.com>, James Houghton
	<jthoughton@google.com>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
 <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
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
In-Reply-To: <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D010EUC001.ant.amazon.com (10.252.51.232) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 12/09/2025 14:36, David Hildenbrand wrote:
> On 11.09.25 12:15, Nikita Kalyazin wrote:
>>
>>
>> On 10/09/2025 22:23, James Houghton wrote:
>>> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita 
>>> <kalyazin@amazon.co.uk> wrote:
>>>>
>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>
>>> Hi Nikita,
>>
>> Hi James,
>>
>> Thanks for the review!
>>
>>
>>>>
>>>> write syscall populates guest_memfd with user-supplied data in a 
>>>> generic
>>>> way, ie no vendor-specific preparation is performed.  This is supposed
>>>> to be used in non-CoCo setups where guest memory is not
>>>> hardware-encrypted.
>>>
>>> What's meant to happen if we do use this for CoCo VMs? I would expect
>>> write() to fail, but I don't see why it would (seems like we need/want
>>> a check that we aren't write()ing to private memory).
>>
>> I am not so sure that write() should fail even in CoCo VMs if we access
>> not-yet-prepared pages.  My understanding was that the CoCoisation of
>> the memory occurs during "preparation".  But I may be wrong here.
> 
> But how do you handle that a page is actually inaccessible and should
> not be touched?
> 
> IOW, with CXL you could crash the host.
> 
> There is likely some state check missing, or it should be restricted to
> VM types.

Sorry, I'm missing the link between VM types and CXL.  How are they related?

My thinking was it is a regular (accessible) page until it is "prepared" 
by the CoCo hardware, which is currently tracked by the up-to-date flag, 
so it is safe to assume that until it is "prepared", it is accessible 
because it was allocated by filemap_grab_folio() -> 
filemap_alloc_folio() and hasn't been taken over by the CoCo hardware. 
What scenario can you see where it doesn't apply as of now?

I am aware of an attempt to remove preparation tracking from 
guest_memfd, but it is still at an RFC stage AFAIK [1].

> 
> Do we know how this would interact with the direct-map removal?

I'm using folio_test_uptodate() to determine if the page has been 
removed from the direct map as kvm_gmem_mark_prepared() is what 
currently removes the page from the direct map and marks it as 
up-to-date.  [2] is a Firecracker feature branch where the two work in 
combination.

[1]: https://lore.kernel.org/kvm/20250715225523.yzmrwghbhi56tqux@amd.com
[2]: 
https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding

> 
> -- 
> Cheers
> 
> David / dhildenb
> 


