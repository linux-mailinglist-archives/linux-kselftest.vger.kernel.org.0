Return-Path: <linux-kselftest+bounces-21874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9D9C5B11
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664571F230D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6A20370D;
	Tue, 12 Nov 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpNyR69h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB02036EE
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423188; cv=none; b=Xsji56i34gaREy4C/6v+Tu0rZZqzk+5bHP9L9uL1ja4Yer3sRlsZoALAsZC5fUDOqGG2RKQw9sgsQ4mMGwsdjgDHsLeX/SpI9PpmFtb0FHzffhgKkzkZPH2kTKcQeXqoWYLd6jTAMy+CdVICqhFITzzzoun5aV9tt/W34gs/uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423188; c=relaxed/simple;
	bh=PFAaWUvIyI3giFGudIqxe60yKDKb1iju/nGcamc34BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s76Z9aJ5JU6Mu2BuJF8r3KhLWokgEHDuAlUv1Xi7GwkokqggN9gOTdpuKzQ+v2n0QGBfoe9bsjepqpB5EAZmFy1ITcFq7TuVNPJh0oDsu82DlyV7UD7K6519UBeiHlizzEU39axqneGI46A0hNNal8VlAF886pd94m/eIpQ667k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpNyR69h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0gJGIdsoCUz3ckQL83q6kRW+jiBXvU5rpWKRHe1/m98=;
	b=gpNyR69ho0NrcTBQgvDlvzmDTUV3daMcZJUrBLPSa68CV+ow/oJ8TdACQ5NXeuWP3g1XBm
	k6dJ1ZLRbEKFqGYBiRxFx3lr/rcar66sKrwE4emArsCxAqcJdAcc9ZwHB765eT48szKmek
	MaBv5q4r29EdJVnPFUXz8YWaEcWtlSY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-AI1QoD1sN96-wjEZo9RJ9g-1; Tue, 12 Nov 2024 09:53:04 -0500
X-MC-Unique: AI1QoD1sN96-wjEZo9RJ9g-1
X-Mimecast-MFC-AGG-ID: AI1QoD1sN96-wjEZo9RJ9g
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e294566dso4180159e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 06:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423183; x=1732027983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0gJGIdsoCUz3ckQL83q6kRW+jiBXvU5rpWKRHe1/m98=;
        b=gx7MB+J1XjeUe10g0KH7C3T1Wvgmjna/tdodnBUGX6fqo1/7+p3205Lq4us63vGyNQ
         1mnhklXTaLwsiZRsQ/Tl+3kW8nwNqP0JAG4uiw+OzFwCWrbIist62ce4Rc0fD3hEWlk+
         gc8nBatxVj8/lQWtrr4spgtAOQnAxv6Lj5iZvIZRPy7czyj/6C8ROWrGAjhPveyy9LTU
         pncsLUZA7ATyPEFJcuS5VuTRsDFTLPLPzbLoTUfXjS3CiZyvM07NrDPLltbNLRUkXRtq
         ZRtmeSldk6dIpS0cdlYNyxDiHf4c1Th9qE3t/7J88fWBU4bP4X3ocy0JXefE0hTbkEul
         Rw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE5yWrak5SE76xeaVQWOBJ4Sz6J3xjb0vxzT/dlaEW/6QgNYfAh1t334UJzn//6WQ8BF9BtrZ+5RsIMPz4jTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWI8iWGoD++sHshBi/lx5w1N8Kr55n4hjx/gpa50YB/xe0vG9
	3MW/5duoynMw8tZQjhmbTIa4Nbvp7RQLI9phCc0E2NgKdKu9YktQNrSRZ67hhcX/gHfCgOJ4qAE
	5e15zbKNr9t49BInBAOptCPDbeguUicivxZdzvK+NWNnRXGIF774JgGHSf7jQahMO/Q==
X-Received: by 2002:a05:6512:130e:b0:539:896e:46c9 with SMTP id 2adb3069b0e04-53d862be340mr8794121e87.45.1731423182705;
        Tue, 12 Nov 2024 06:53:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWbnpbXzRLMvOa0UtrtzbmtKcDGrKbBby1v5EU8Z2y9SKUzZkouXaYSPO+sb/cLeasmpm09Q==
X-Received: by 2002:a05:6512:130e:b0:539:896e:46c9 with SMTP id 2adb3069b0e04-53d862be340mr8794102e87.45.1731423182255;
        Tue, 12 Nov 2024 06:53:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5b96sm220710455e9.41.2024.11.12.06.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:53:00 -0800 (PST)
Message-ID: <f4c5d0a6-a582-44e3-8949-c199cc0bfba7@redhat.com>
Date: Tue, 12 Nov 2024 15:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, ackerleytng@google.com, vannapurve@google.com,
 rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, faresx@amazon.com
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
 <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
 <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
 <02f77d32-e2a1-431b-bb67-33d36c06acd3@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <02f77d32-e2a1-431b-bb67-33d36c06acd3@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.24 15:40, Patrick Roy wrote:
> 
> Hi David,
> 
> sorry for the late response, I ended up catching the flu last week and
> was out of commission for a while :(
> 
> On Mon, 2024-11-04 at 21:30 +0000, David Hildenbrand wrote:
>>>> We talked about shared (faultable) vs. private (unfaultable), and how it
>>>> would interact with the directmap patches here.
>>>>
>>>> As discussed, having private (unfaultable) memory with the direct-map
>>>> removed and shared (faultable) memory with the direct-mapping can make
>>>> sense for non-TDX/AMD-SEV/... non-CoCo use cases. Not sure about CoCo,
>>>> the discussion here seems to indicate that it might currently not be
>>>> required.
>>>>
>>>> So one thing we could do is that shared (faultable) will have a direct
>>>> mapping and be gup-able and private (unfaultable) memory will not have a
>>>> direct mapping and is, by design, not gup-able.>
>>>> Maybe it could make sense to not have a direct map for all guest_memfd
>>>> memory, making it behave like secretmem (and it would be easy to
>>>> implement)? But I'm not sure if that is really desirable in VM context.
>>>
>>> This would work for us (in this scenario, the swiotlb areas would be
>>> "traditional" memory, e.g. set to shared via mem attributes instead of
>>> "shared" inside KVM), it's kinda what I had prototyped in my v1 of this
>>> series (well, we'd need to figure out how to get the mappings of gmem
>>> back into KVM, since in this setup, short-circuiting it into
>>> userspace_addr wouldn't work, unless we banish swiotlb into a different
>>> memslot altogether somehow).
>>
>> Right.
> 
> "right" as in, "yes we could do that"? :p

"right" as in "I see how that could work" :)

[...]

> 
> I remember talking to someone at some point about whether we could reuse
> the proc-local stuff for guest memory, but I cannot remember the outcome
> of that discussion... (or maybe I just wanted to have a discussion about
> it, but forgot to follow up on that thought?).  I guess we wouldn't use
> proc-local _allocations_, but rather just set up proc-local mappings of
> the gmem allocations that have been removed from the direct map.

Yes. And likely only for memory we really access / try access, if possible.

> 
> I'm wondering, where exactly would be the differences to Sean's idea
> about messing with the CR3 register inside KVM to temporarily install
> page tables that contain all the gmem stuff, conceptually? Wouldn't we
> run into the same interrupt problems that Sean foresaw for the CR3
> stuff? (which, admittedly, I still don't quite follow what these are :(
> ).

I'd need some more details on that. If anything would rely on the direct 
mapping (from IRQ context?) than ... we obviously cannot remove the 
direct mapping :)

-- 
Cheers,

David / dhildenb


