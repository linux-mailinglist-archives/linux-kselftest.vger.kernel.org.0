Return-Path: <linux-kselftest+bounces-40442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33FB3E72D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741CF3BF9FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266DD342CB0;
	Mon,  1 Sep 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dr4VYQ9d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB6342C96;
	Mon,  1 Sep 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737007; cv=none; b=TqXEGL455FrBCkj7n6WUI2bMJ/bdNBpJBWiZHliw/N8nbIdPFUDI6TMFlti6MfCBV6PMjLHp0+NbOfMUxhYX0NQltcujcjZISO7YII5kvKKsB3B5d8H/t9lE6Vsi8YG9mTNhpwoUgltfN9s8rptIFirDuEvnKy88ZT2w2X9rk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737007; c=relaxed/simple;
	bh=0xcK1J5+hsUnCJvdm8xfBNDb1E5BCiku7ILTg1rUZC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EsN3ibQaVNv95eNKzX7uVIaApSMh7rpDKCZQ1tzi8iXTzO+uuVTnGZIoMGCzhWsmO4PERsmbPqe/YcFUrYfjxh8GPF/lF9IhoBfLm7EJKa2R+ZlcLFVC6xY4B1ddsjUF81vw07hf0vLWvTLgsO+WQmUs53HVdqAbxMvVv7E9eTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Dr4VYQ9d; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756737005; x=1788273005;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=AoelNy+fFiAsI/G6P79kebWdwgtGSe9WtMaZxZOBfQk=;
  b=Dr4VYQ9daPb6aAJ1VPofghaH5JgQcg5vqgH9Cnna7vx9hqku3L0IcBKH
   +n9GibT1e0FwJM9/6AEzS85fBlGAa4rLw8GZV9xOUw355qGo94rDfqTdV
   XTvBJ++p0EDBFKK6x7f5zrc6AydPQqFpMFsXix0P2jhTwUVKgUHueZOhS
   Ft78yOV1OB0DTLCu9y6cZ6lI4DkCeB/R7TzUXtPAYgypVsePRDZwUYPef
   fMdtwX5c2vbJNdc2+DMD3PkG5l7se6pBupL+0a4z+6emVuDeMxnfD0yBy
   usc30+A4U8UTTg8L4MPZKJhYsv4vnzPsSEvWNH2vCxio44Dfn/ku1enmI
   w==;
X-CSE-ConnectionGUID: 39Z989SVTZKj52biPXCDLA==
X-CSE-MsgGUID: XJvmmOfCSa2eaac9pprUFw==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1362825"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 14:29:54 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:14142]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.0.202:2525] with esmtp (Farcaster)
 id afac050d-f855-48c7-8123-57b7c6b12256; Mon, 1 Sep 2025 14:29:54 +0000 (UTC)
X-Farcaster-Flow-ID: afac050d-f855-48c7-8123-57b7c6b12256
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 14:29:53 +0000
Received: from [192.168.30.195] (10.106.83.14) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 1 Sep 2025 14:29:52 +0000
Message-ID: <bb929cd5-7ac1-4159-8614-553e84176968@amazon.com>
Date: Mon, 1 Sep 2025 15:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
To: David Hildenbrand <david@redhat.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250828153049.3922-1-kalyazin@amazon.com>
 <20250828153049.3922-2-kalyazin@amazon.com>
 <d58425d4-8e4f-4b70-915f-322658e9878e@redhat.com>
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
In-Reply-To: <d58425d4-8e4f-4b70-915f-322658e9878e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D009EUB002.ant.amazon.com (10.252.51.66) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 28/08/2025 21:01, David Hildenbrand wrote:
> On 28.08.25 17:31, Kalyazin, Nikita wrote:
>> write syscall populates guest_memfd with user-supplied data in a generic
>> way, ie no vendor-specific preparation is performed.  This is supposed
>> to be used in non-CoCo setups where guest memory is not
>> hardware-encrypted.
>>
>> The following behaviour is implemented:
>>   - only page-aligned count and offset are allowed
>>   - if the memory is already allocated, the call will successfully
>>     populate it
>>   - if the memory is not allocated, the call will both allocate and
>>     populate
>>   - if the memory is already populated, the call will not repopulate it
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
> 
> Just nothing that checkpatch complains about
> 
> a) Usage of "unsigned" instead of "unsigned int"

Hi David,


I copied the prototypes straight from the fs.h...  In any case, will fix 
in the next version.

> 
> b) The From doesn't completely match the SOB: "Kalyazin, Nikita" vs
> "Nikita Kalyazin"

It's about .com vs .co.uk, I think.  Will have to use "From:" apparently.


Thanks,
Nikita

> 
> -- 
> Cheers
> 
> David / dhildenb
> 


