Return-Path: <linux-kselftest+bounces-12333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF79108B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4779B1C213B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94D01AE09E;
	Thu, 20 Jun 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM5CDvSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C7176255
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894716; cv=none; b=f8JjNlrvWftNnnY+40zcZze5oplehQUkuNr0xpHXtlPBIOqg7ViP99KcSVx6YHzdpzrENMJovhcse3gF+BqrjjbC90a7JXng+Fd7YlZHFtPv3n7sV+Yo34W7q87/5/vjcpvECyupt3Vp4uuJx6h2t1dNEx5xwbaJIERdDD4m/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894716; c=relaxed/simple;
	bh=ALksFnrKrcGn12QSjQcEuQIf8P+ZdXhTU6QEsfAxmlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6duqmtmb2UspaMVG/MXCAEwDF1K5dJODOVw8FEgira3K7HZQWbZ5Dg+Dxz28rbhImJZvwbvu1Am6n9d67TqU2A4nUZ0e5pabeaoTNYlBU2/0eaLQdanvB19dLufxMC3E6D1qjG6fqV3DLan78W23ies4tjBKSYvZoeU7CIBr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM5CDvSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718894714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CJbY92tZcmS6AFMXxjNinJra1MdkazuQMLItm3eS/94=;
	b=UM5CDvSQ0+8HOFAayImkQSI2LX0tLcoouJa/u4FrK/v7RcdP/1isO/+YxvR8yCCk4kQlGz
	G4SEoDiGAisen6N+DdiaYQ5nR6sZB48/9mt9nO1bZuqs75E8KpWzqBg3t+8vFxmLpdMpAx
	xheMWnlUdVOsR+YR+x+3aiNEl15C6LQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-VfHm2tv0OiyvmQC2nDNnJQ-1; Thu, 20 Jun 2024 10:45:12 -0400
X-MC-Unique: VfHm2tv0OiyvmQC2nDNnJQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42183fdd668so8158085e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 07:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894711; x=1719499511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJbY92tZcmS6AFMXxjNinJra1MdkazuQMLItm3eS/94=;
        b=pjGmROrB7mAFH/R94l1xiczXqniYbcgT+sOQtk4Q6NotBEiRzVu5MwR9lOjHtNefDB
         FM+3RvSZ28V7AtHOlw2EncyWp6XeX+ta44GUCuvin9rO9SCKWLY5YmMB1biruWmu6gLY
         umQqUla6S9u+W4zE8s0JvwbjsWW58A3ofduJMaIr7fkSw4p9w79wMt0ugoHk+9h+ycey
         vIzjkzdag0lu6Dq9RwnvyST6Ypfygv3E2OhPIvbXwNLKH7zvHvgrwx76axXGBCa/MiwR
         b8pVRdOhRMWwgt994UQzn8lRVZNzqSHFwGNUoTK6bCryK6YfYVHpO0U144pzvuYF21ME
         whEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMGmAu91bNYO3rGYbz3EUyM9FR2atDSzs1AE8kB2Hv4Be5gmHzUntQiqhwvfphsYCfCvMJslomRfWgQUxi6pGBDqzLvA6CavlyuDq3nwkW
X-Gm-Message-State: AOJu0YwPyliLCuzGB4S+WrS8jFpCmQVQioIZ19gI8UjofSDj2bTQUP95
	8GfAekKl7qxcoQ5t+D8zdJQWBo4JL2NwY89pdbQQGZArVjONu3AjaXh+yLhiuo1UwfvWGfbBYx0
	rBWjI1w2e9rI+C5Hir7fZRVHGJuYxsRuMGEpghe92pBlalwmXoWVrOD6GClfYxYpqYw==
X-Received: by 2002:a05:600c:68c5:b0:422:6765:271c with SMTP id 5b1f17b1804b1-4247517e003mr43369775e9.20.1718894711487;
        Thu, 20 Jun 2024 07:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKuCXPZ7Phm93DcTUNnHXYK16JnGZOeEfUrlDl01RVTYUaUYKRZaRjwAw2Hbkju/eEkt47hg==
X-Received: by 2002:a05:600c:68c5:b0:422:6765:271c with SMTP id 5b1f17b1804b1-4247517e003mr43369545e9.20.1718894710957;
        Thu, 20 Jun 2024 07:45:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3621a4a17e6sm7025688f8f.19.2024.06.20.07.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:45:10 -0700 (PDT)
Message-ID: <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
Date: Thu, 20 Jun 2024 16:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Elliot Berman
 <quic_eberman@quicinc.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240620142956.GI2494510@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.06.24 16:29, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
>> On 20.06.24 15:55, Jason Gunthorpe wrote:
>>> On Thu, Jun 20, 2024 at 09:32:11AM +0100, Fuad Tabba wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jun 20, 2024 at 5:11 AM Christoph Hellwig <hch@infradead.org> wrote:
>>>>>
>>>>> On Wed, Jun 19, 2024 at 08:51:35AM -0300, Jason Gunthorpe wrote:
>>>>>> If you can't agree with the guest_memfd people on how to get there
>>>>>> then maybe you need a guest_memfd2 for this slightly different special
>>>>>> stuff instead of intruding on the core mm so much. (though that would
>>>>>> be sad)
>>>>>
>>>>> Or we're just not going to support it at all.  It's not like supporting
>>>>> this weird usage model is a must-have for Linux to start with.
>>>>
>>>> Sorry, but could you please clarify to me what usage model you're
>>>> referring to exactly, and why you think it's weird? It's just that we
>>>> have covered a few things in this thread, and to me it's not clear if
>>>> you're referring to protected VMs sharing memory, or being able to
>>>> (conditionally) map a VM's memory that's backed by guest_memfd(), or
>>>> if it's the Exclusive pin.
>>>
>>> Personally I think mapping memory under guest_memfd is pretty weird.
>>>
>>> I don't really understand why you end up with something different than
>>> normal CC. Normal CC has memory that the VMM can access and memory it
>>> cannot access. guest_memory is supposed to hold the memory the VMM cannot
>>> reach, right?
>>>
>>> So how does normal CC handle memory switching between private and
>>> shared and why doesn't that work for pKVM? I think the normal CC path
>>> effectively discards the memory content on these switches and is
>>> slow. Are you trying to make the switch content preserving and faster?
>>>
>>> If yes, why? What is wrong with the normal CC model of slow and
>>> non-preserving shared memory?
>>
>> I'll leave the !huge page part to Fuad.
>>
>> Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
>> now the VM requests to make one subpage private.
> 
> I think the general CC model has the shared/private setup earlier on
> the VM lifecycle with large runs of contiguous pages. It would only
> become a problem if you intend to to high rate fine granual
> shared/private switching. Which is why I am asking what the actual
> "why" is here.

I am not an expert on that, but I remember that the way memory 
shared<->private conversion happens can heavily depend on the VM use 
case, and that under pKVM we might see more frequent conversion, without 
even going to user space.

> 
>> How to handle that without eventually running into a double
>> memory-allocation? (in the worst case, allocating a 1GiB huge page
>> for shared and for private memory).
> 
> I expect you'd take the linear range of 1G of PFNs and fragment it
> into three ranges private/shared/private that span the same 1G.
> 
> When you construct a page table (ie a S2) that holds these three
> ranges and has permission to access all the memory you want the page
> table to automatically join them back together into 1GB entry.
> 
> When you construct a page table that has only access to the shared,
> then you'd only install the shared hole at its natural best size.
> 
> So, I think there are two challenges - how to build an allocator and
> uAPI to manage this sort of stuff so you can keep track of any
> fractured pfns and ensure things remain in physical order.
> 
> Then how to re-consolidate this for the KVM side of the world.

Exactly!

> 
> guest_memfd, or something like it, is just really a good answer. You
> have it obtain the huge folio, and keep track on its own which sub
> pages can be mapped to a VMA because they are shared. KVM will obtain
> the PFNs directly from the fd and KVM will not see the shared
> holes. This means your S2's can be trivially constructed correctly.
> 
> No need to double allocate..

Yes, that's why my thinking so far was:

Let guest_memfd (or something like that) consume huge pages (somehow, 
let it access the hugetlb reserves). Preallocate that memory once, as 
the VM starts up: just like we do with hugetlb in VMs.

Let KVM track which parts are shared/private, and if required, let it 
map only the shared parts to user space. KVM has all information to make 
these decisions.

If we could disallow pinning any shared pages, that would make life a 
lot easier, but I think there were reasons for why we might require it. 
To convert shared->private, simply unmap that folio (only the shared 
parts could possibly be mapped) from all user page tables.

Of course, there might be alternatives, and I'll be happy to learn about 
them. The allcoator part would be fairly easy, and the uAPI part would 
similarly be comparably easy. So far the theory :)

> 
> I'm kind of surprised the CC folks don't want the same thing for
> exactly the same reason. It is much easier to recover the huge
> mappings for the S2 in the presence of shared holes if you track it
> this way. Even CC will have this problem, to some degree, too.

Precisely! RH (and therefore, me) is primarily interested in existing 
guest_memfd users at this point ("CC"), and I don't see an easy way to 
get that running with huge pages in the existing model reasonably well ...

-- 
Cheers,

David / dhildenb


