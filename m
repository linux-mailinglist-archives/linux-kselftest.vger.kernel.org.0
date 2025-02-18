Return-Path: <linux-kselftest+bounces-26879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8091DA3A3DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF075175740
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6ED26FD87;
	Tue, 18 Feb 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8nM7U7/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38F26FA5D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898852; cv=none; b=dYCnL+ne04hy4fGw6QFlMyyIHEbnTPrXJTfFWosI73yec+KTe2MJ1DOrC5lHeeIWTvW9oFkfS7v5k2GfkBQx5rVuNrdXkyIDVQBheFNj7v/9N7xGW5zNISIwym3RhatSVXLXe7S8ilzlcZz/F7JBKHLtliKTass37vqVzJz8zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898852; c=relaxed/simple;
	bh=oS0tZoN4Fkj65drnVSK2nyc6sIR47m3XmHuL7mHUSs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8mZdNVzsOn9JfrFK3i2Glmu5Vm8YZTaAvjAl8D0T6MD9OTqLHwGD1gX3ekPfFsxZB+WSoQqc/U8ZkuLmltRMySkvvrV2pnmEQWhmqBaAi9w/9qpk7kNMNtiQIpEBOsT1Ti0tKpfY7KWe1JDLbofNfhiTHSZKoQHvJdtVQ+goH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8nM7U7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739898849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L3NuFt+4Dnd+neKbQ+jbC6ujGzOMAwlD8ogbRoP62Oo=;
	b=O8nM7U7/nzYR2JkVKK84kwaHL+0FuiN1BLapTaSya2pyFxqxfZe6qppgvTffMPU2hTaBhT
	Tt+SJUcOwp81OXDuDHy6TzfOKrz8Z1jQf2FhHVQARBuK82T3NzGjfvyCP+rfnVscba4IEJ
	JC1n2mRL++z1yuBq3TzpJJWfng4WxTY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-I-iQFCPiN9Cs8afFp9a0fw-1; Tue, 18 Feb 2025 12:14:07 -0500
X-MC-Unique: I-iQFCPiN9Cs8afFp9a0fw-1
X-Mimecast-MFC-AGG-ID: I-iQFCPiN9Cs8afFp9a0fw_1739898846
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e89e910so30555885e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 09:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898846; x=1740503646;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3NuFt+4Dnd+neKbQ+jbC6ujGzOMAwlD8ogbRoP62Oo=;
        b=gXP5iQ7SpVjtkhOVVEA5EQ9RolguEdVqN6usdOmlpJnSjS8+dWOG4NEI9FPGF4iJRb
         KF7XcehOnw3eQKQTovyrbtIFuqysWwy9wlTduIvJi4UhVlccigkEzn3d36lrUW9efBat
         vPPNl9M0RE4kUHW3cwPWuDn1+d31zCyJALWxfH6NELcRDFbU1lPhG0z1+McPhYtwH48x
         ADJ+KbtDWIec/tXbLWs+zONpA/F5hEbZULTKMMfZIVfEFhIixZbCoQ/1nm7LPCMT67VL
         MbI0N05G/TV2wxAY1Lg6wrS0fSGy/3MRtsS+Kk/wkplUaKrsgd3xU/qEA59Kql8tlmGv
         yw1g==
X-Forwarded-Encrypted: i=1; AJvYcCWZOc6fZ8RZDMLwp8Rzdh7XUzO49wNQ5rhgTrazEK8kvgrNKu3XoZ3wZp42JUReFLcg7easxMyGWiFmqvsVYyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zMD12Fva3Q7RCTtEjl7wq0zPiUcgW+cgremLTiniIwjpQKDx
	898d/vZ6GMlKpBJ7UrmPXrBkca14gC96B1QKBswDqXbchhZezM7Q/F7xk9EtDOQRqhiUdpzomum
	oXDt0sx8hmv5ne70hQYJOkgiVByEM/LxASAoBeFk7NM1RB50mH1SW6Jq+ypBcVNweqg==
X-Gm-Gg: ASbGncsFltqYb/WDECMcYScS8iSAtrvakbkbb3KPDdAIB3tDnivAjrzLHNYnVwhQvuF
	Wl54ru09Fvcy8R4CkcPMrzvUoVO6B6dmJdNq4XAJHcmRjSnmBJfZnZQWimeWRQSDvweSxBSjERz
	IcplAa/n9E2I2k+ttV5UoxBxIOzFjL6tc9oMQZaAKBYIaKNgRMN5lVIWlIFcilUrOa+njId2NMC
	WWB6O16I+UCseuU6Pa5aQtxEe8tXoZLNtfBM2vT2mfBNCOOA6hpzRNA3jWj6sKxOsn0Zv1VhRiE
	cZdrTv9vFfagdUqOZBnuoQfT0Ts6p2aWuIoVvo+Vdg8H2r1mqtoem9HR92rH8gkkwG8A5fyl/Et
	3iX/+lb6+J4Udn6rnEsAX5eDUIo1xSUHB
X-Received: by 2002:adf:fec1:0:b0:38f:2352:4314 with SMTP id ffacd0b85a97d-38f33f52ffemr13435395f8f.38.1739898845225;
        Tue, 18 Feb 2025 09:14:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTSOAxcqXOCNJjH/JhnX+PVn0iy4O2Qkn73Uck2K2Adk4fk0DrrR0lhowJOKrHxnoP5yBnqQ==
X-Received: by 2002:adf:fec1:0:b0:38f:2352:4314 with SMTP id ffacd0b85a97d-38f33f52ffemr13435285f8f.38.1739898843296;
        Tue, 18 Feb 2025 09:14:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5923sm15666137f8f.74.2025.02.18.09.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:14:02 -0800 (PST)
Message-ID: <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
Date: Tue, 18 Feb 2025 18:14:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 17:43, Lorenzo Stoakes wrote:
> On Tue, Feb 18, 2025 at 04:20:18PM +0100, David Hildenbrand wrote:
>>> Right yeah that'd be super weird. And I don't want to add that logic.
>>>
>>>> Also not sure what happens if one does an mlock()/mlockall() after
>>>> already installing PTE markers.
>>>
>>> The existing logic already handles non-present cases by skipping them, in
>>> mlock_pte_range():
>>>
>>> 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
>>> 		ptent = ptep_get(pte);
>>> 		if (!pte_present(ptent))
>>> 			continue;
>>>
>>> 		...
>>> 	}
>>
>> I *think* that code only updates already-mapped folios, to properly call
>> mlock_folio()/munlock_folio().
> 
> Guard regions _are_ 'already mapped' :) so it leaves them in place.

"mapped folios" -- there is no folio mapped. Yes, the VMA is in place.

> 
> do_mlock() -> apply_vma_lock_flags() -> mlock_fixup() -> mlock_vma_pages_range()
> implies this will be invoked.

Yes, to process any already mapped folios, to then continue population 
later.

> 
>>
>> It is not the code that populates pages on mlock()/mlockall(). I think all
>> that goes via mm_populate()/__mm_populate(), where "ordinary GUP" should
>> apply.
> 
> OK I want to correct what I said earlier.
> 
> Installing a guard region then attempting mlock() will result in an error. The
> populate will -EFAULT and stop at the guard region, which causes mlock() to
> error out.

Right, that's my expectation.

> 
> This is a partial failure, so the VMA is split and has VM_LOCKED applied, but
> the populate halts at the guard region.
> 
> This is ok as per previous discussion on aggregate operation failure, there can
> be no expectation of 'unwinding' of partially successful operations that form
> part of a requested aggregate one.
> 
> However, given there's stuff to clean up, and on error a user _may_ wish to then
> remove guard regions and try again, I guess there's no harm in keeping the code
> as it is where we allow MADV_GUARD_REMOVE even if VM_LOCKED is in place.

Likely yes; it's all weird code.

> 
>>
>> See populate_vma_page_range(), especially also the VM_LOCKONFAULT handling.
> 
> Yeah that code is horrible, you just reminded me of it... 'rightly or wrongly'
> yeah wrongly, very wrongly...
> 
>>
>>>
>>> Which covers off guard regions. Removing the guard regions after this will
>>> leave you in a weird situation where these entries will be zapped... maybe
>>> we need a patch to make MADV_GUARD_REMOVE check VM_LOCKED and in this case
>>> also populate?
>>
>> Maybe? Or we say that it behaves like MADV_DONTNEED_LOCKED.
> 
> See above, no we should not :P this is only good for cleanup after mlock()
> failure, although no sane program should really be trying to do this, a sane
> program would give up here (and it's a _programmatic error_ to try to mlock() a
> range with guard regions).
 >>>> Somme apps use mlockall(), and it might be nice to just be able to 
use guard
>> pages as if "Nothing happened".
> 
> Sadly I think not given above :P

QEMU, for example, will issue an mlockall(MCL_CURRENT | MCL_FUTURE); 
when requested to then exit(); if it fails.

Assume glibc or any lib uses it, QEMU would have no real way of figuring 
that out or instructing offending libraries to disabled that, at least 
for now  ...

... turning RT VMs less usable if any library uses guard regions. :(

There is upcoming support for MCL_ONFAULT in QEMU [1] (see below).

[1] https://lkml.kernel.org/r/20250212173823.214429-3-peterx@redhat.com

> 
>>
>> E.g., QEMU has the option to use mlockall().
>>
>>>
>>> Then again we're currently asymmetric as you can add them _before_
>>> mlock()'ing...
>>
>> Right.
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> I think the _LOCKED idea is therefore kaput, because it just won't work
> properly because populating guard regions fails.

Right, I think basic VM_LOCKED is out of the picture. VM_LOCKONFAULT 
might be interesting, because we are skipping the population stage.

> 
> It fails because it tries to 'touch' the memory, but 'touching' guard
> region memory causes a segfault. This kind of breaks the idea of
> mlock()'ing guard regions.
> 
> I think adding workarounds to make this possible in any way is not really
> worth it (and would probably be pretty gross).
> 
> We already document that 'mlock()ing lightweight guard regions will fail'
> as per man page so this is all in line with that.

Right, and I claim that supporting VM_LOCKONFAULT might likely be as 
easy as allowing install/remove of guard regions when that flag is set.

-- 
Cheers,

David / dhildenb


