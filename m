Return-Path: <linux-kselftest+bounces-21873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46DB9C5ADC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF4282812
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA971FF02F;
	Tue, 12 Nov 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="UXrVeWYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039F1632E9;
	Tue, 12 Nov 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422952; cv=none; b=djSOUH/QVAEw5g8US+FliKC1P79dLi8CKqYsR4jU3A3hKLt6qzTp7RuQex4twYY3CRuClcKPBGlUFumvcHH2L9IZalunCT/hzHkLxjizESbVMvJwD07880KJ/cXC8EfBKg+eyVLCguT23w/4Dleu3OdoIwnLDqjhCRZW1fkRISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422952; c=relaxed/simple;
	bh=m0eo4X3kqJSUHkhXYkHQiXzeJnIdCYY/2I64fubKglY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=blO+0VSQYubZ2x5AWDh3o1vCXuGK1O9Dz0xUyBJh8E1XTeUKZmanqjeQeZEU4aQYTRW29MLoJR+jFN8iBz7Etlf8AYxR6UStytItOgl31PKgvojLrbYuH83khSQ/eLzuozpF4RRCUDosJz5QRVIWtxKeM0vgI6qzFRrda8ONfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=UXrVeWYI; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1731422952; x=1762958952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmAWYVWTItYY6sYiriVLXoFyHZtABKNORDlLDv0YA8o=;
  b=UXrVeWYInzuGE/UWjF5JE2ASMqWuu2B1GqdN2+KVdccPWrmiIvRdvtDP
   KQUIOXbCs+k38n1wQwKKf7+Gnh934HP2+T7wBs9BiGIpJr5FHgUs9VgbR
   SnNiFeEU8uMFNMB7bq76hx1Z2IgJfKuqIT/fhBnFHSm6E8FwtCT8Jp2iG
   4=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="384565955"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:49:07 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:13328]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.131:2525] with esmtp (Farcaster)
 id 10c75058-a729-46eb-ac89-a0cf40349664; Tue, 12 Nov 2024 14:49:05 +0000 (UTC)
X-Farcaster-Flow-ID: 10c75058-a729-46eb-ac89-a0cf40349664
Received: from EX19D030EUC001.ant.amazon.com (10.252.61.228) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 14:48:58 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D030EUC001.ant.amazon.com (10.252.61.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 14:48:58 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 14:48:57 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTPS id 842D1402F3;
	Tue, 12 Nov 2024 14:48:49 +0000 (UTC)
Message-ID: <bb534fec-b45d-4ff8-aa55-7201766936b5@amazon.co.uk>
Date: Tue, 12 Nov 2024 14:48:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/6] arch: introduce set_direct_map_valid_noflush()
To: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
	<tabba@google.com>, <quic_eberman@quicinc.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <jthoughton@google.com>, <ackerleytng@google.com>,
	<vannapurve@google.com>, <rppt@kernel.org>
CC: <graf@amazon.com>, <jgowans@amazon.com>, <derekmn@amazon.com>,
	<kalyazin@amazon.com>, <xmarcalx@amazon.com>, <linux-mm@kvack.org>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <20241030134912.515725-2-roypat@amazon.co.uk>
 <a774e13e-0616-4d96-bb51-bac0fcb2cb9b@redhat.com>
 <440b2682-dbfb-4a5c-927c-2397413a7f9c@suse.cz>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <440b2682-dbfb-4a5c-927c-2397413a7f9c@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Mon, 2024-11-11 at 12:12 +0000, Vlastimil Babka wrote:
> On 10/31/24 10:57, David Hildenbrand wrote:
>> On 30.10.24 14:49, Patrick Roy wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> From: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>
>>> Add an API that will allow updates of the direct/linear map for a set of
>>> physically contiguous pages.
>>>
>>> It will be used in the following patches.
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>>
>>
>> [...]
>>
>>>   #ifdef CONFIG_DEBUG_PAGEALLOC
>>>   void __kernel_map_pages(struct page *page, int numpages, int enable)
>>>   {
>>> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
>>> index e7aec20fb44f1..3030d9245f5ac 100644
>>> --- a/include/linux/set_memory.h
>>> +++ b/include/linux/set_memory.h
>>> @@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struct page *page)
>>>      return 0;
>>>   }
>>>
>>> +static inline int set_direct_map_valid_noflush(struct page *page,
>>> +                                           unsigned nr, bool valid)
>>
>> I recall that "unsigned" is frowned upon; "unsigned int".
>>
>>> +{
>>> +    return 0;
>>> +}
>>
>> Can we add some kernel doc for this?
>>
>> In particular
>>
>> (a) What does it mean when we return 0? That it worked? Then, this
> 
> Seems so.
> 
>>      dummy function looks wrong. Or this it return the
> 
> That's !CONFIG_ARCH_HAS_SET_DIRECT_MAP and other functions around do it the
> same way. Looks like the current callers can only exist with the CONFIG_
> enabled in the first place.

Yeah, it looks a bit weird, but these functions seem to generally return
0 if the operation is not supported. ARM specifically has 

	if (!can_set_direct_map())
		return 0;

inside `set_direct_map_invalid_{noflush,default}`. Documenting this
definitely cannot hurt, I'll keep it on my todo list for the next
iteration :)

>>      number of processed entries? Then we'd have a possible "int" vs.
>>      "unsigned int" inconsistency.
>>
>> (b) What are the semantics when we fail halfway through the operation
>>      when processing nr > 1? Is it "all or nothing"?
> 
> Looking at x86 implementation it seems like it can just bail out in the
> middle, but then I'm not sure if it can really fail in the middle, hmm...

If I understood Mike correctly when talking about this at LPC, then it
can only fail if during break-up of huge mappings, it fails to allocate
page tables to hold the lower-granularity mappings (which happens before
any present bits are modified).

Best,
Patrick

