Return-Path: <linux-kselftest+bounces-27065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C4A3DA4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF92C1899F2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E51F460D;
	Thu, 20 Feb 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5rRcDv7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFE286298
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055469; cv=none; b=AUikEuxeB64fGjUSUB/5XBk9qN5v0zO2V/v/dXAqPVLpAx+/NvxqmHXpw8kXXkWsrJTfm7B9YGPjZdF+A7M/q+HI8bfcgar+2hvxjtYd1znkcKHcYm4O5cNb2/Pgqp+qKNs+E4YoxBUn8n/pdv/3Ev1Z2SpDJpI8jxfAm3dopwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055469; c=relaxed/simple;
	bh=bPFiUomZF13Dz9mQWRWn2aK4Lk9XxmWw21ZdXhWu68M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkiCjcrtdx1YjZktIj8Ko9GcuaA+4OfBAnuYUB9pBoIdsvOE/2L3uR5bMNog4NazPPmh7uUpl6S9afBvwxgPpNkJXOmqQC4HFCYpVfMkIFcPvQfzDHfpqiFpnFT/5w0Rpg6jKcRwrEjOc4xNECUX1GfpUGCdNKbghrkax1BMBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5rRcDv7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740055466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Aw2uty6j9x0fqEkPxv/nF0HlVK8X1BpwPiiIHwWFu90=;
	b=V5rRcDv7Rb/HXjvRU5rhyNkn/fvuR5f2nwzfP9PBCaMhGsOr2tD/0xkyXvnFAxvTC6Jyb/
	xlWz3mEarLAsmADN3FBr8RCbAghSyZOX/ZqKAZVh4w/EzBWAYRjcXAU6z3AqrgpkcMbUFt
	ukOyNXF7Hz+9B/RRqqbsKtGNNTBHsUU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-kMq1zVdxOmOXa4CKl38D6A-1; Thu, 20 Feb 2025 07:44:25 -0500
X-MC-Unique: kMq1zVdxOmOXa4CKl38D6A-1
X-Mimecast-MFC-AGG-ID: kMq1zVdxOmOXa4CKl38D6A_1740055464
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f443b4949so435180f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 04:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740055464; x=1740660264;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Aw2uty6j9x0fqEkPxv/nF0HlVK8X1BpwPiiIHwWFu90=;
        b=Izp4aDtNmTzufum4p/CkrXWtyUSWMRbwbXuSwhe3SCvBT/0230lsZspOzlDWy1F/VE
         Zk5B9brhyrvD6VbH9872kVNyBUgsjyDJQ09UdNJWjYUx9/Ogx0auwxQ59TUTj06Jc+Tm
         LkgfQXQcEpp++EYD9qKbORnBPTpLlMbTsL8F/lDgU62fDLxv5Zbzf/L37gMQtc8zr9eR
         hYidXGT3itIQbkVwxRBtEDU2AEpybs/DOB0zIi1VSgYcYEkvvtGZD1rjfLmTAhLmzqde
         8gC4Pi5T3KM7qJssNxkd529EZ9d6iaS+15+uVlMAuZyU8oj7DG1a0ZuSVIdVfd0I3UK0
         u2hg==
X-Forwarded-Encrypted: i=1; AJvYcCVmaPoj+mdRB4dPhI/PSVqH5SISKWLHGyB3PTfj8VaudRapUdcWROYKnKnur0DwZUB7rluXoHUtfZNkLrZz8XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ikh9SpJayFztvVEYFjFO9uBABS1RLt0dHs8ncyD506JVnq2T
	/gpOoU0luNZjXPENVlWFe7HCkrlkwqICOS1cercQd06Te4LOh+kTjGSvHQ8Oi0DV+WM0U3TaL1H
	jaONfrbzfFUrglrlQ4f5xGB7/mH86D9M7j1mg0zXvInfYwtD/UDLxtwepAUedRIw9Mg==
X-Gm-Gg: ASbGnctegTUBKaIkRMkPgixKqPpMsmHFnqCWirKniwsz2WMADTCTKkUzqBOEZTYiFgX
	P2q2fmoeBUCJA9dUvSlnw1QKuPBbFIpfgS1c5MMXQdUOY9+LIFqj5VtTK7Od2EtrJujlrR43NBM
	c8tSS5UwBYTJWqhjy3G7+JCA7+Sf2ueAD43Ii8g0hY6tDQjNfq+0X9efigI2bteI9nr0n/rpA4P
	S4Um529wFSFjuB5YcbTNfHYqAA/cnZXFQG0f4hKlj/Qr6S3XxF02IGEz6Rp4afwkLJ719OwWxbM
	b8NqBoR48cXONvYqe19t2gzwmQ+7esVOO9OJ7uH2WfNP8fY8QOfcGjNRyr3LILkO4RXgtGYyCOT
	1iBTrfCqV2DfBFj2C6NBOLrT/6AxNIQ==
X-Received: by 2002:a5d:58c3:0:b0:38d:e61a:bc7 with SMTP id ffacd0b85a97d-38f3406cd95mr18809400f8f.40.1740055464400;
        Thu, 20 Feb 2025 04:44:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWR1r+x5fxTVDkaeTb+DGmJUge83PhPNpWxQET+3WOp7mEtvkA8YLL3jY58yOBXvJyv+SzYA==
X-Received: by 2002:a5d:58c3:0:b0:38d:e61a:bc7 with SMTP id ffacd0b85a97d-38f3406cd95mr18809375f8f.40.1740055463978;
        Thu, 20 Feb 2025 04:44:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm20836738f8f.56.2025.02.20.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:44:22 -0800 (PST)
Message-ID: <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
Date: Thu, 20 Feb 2025 13:44:20 +0100
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
Cc: Kalesh Singh <kaleshsingh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>
References: <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
 <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 11:15, Lorenzo Stoakes wrote:
> On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
>>>> Your conclusion is 'did not participate with upstream'; I don't agree with
>>>> that. But maybe you and Kalesh have a history on that that let's you react
>>>> on his questions IMHO more emotionally than it should have been.
>>>
>>> This is wholly unfair, I have been very reasonable in response to this
>>> thread. I have offered to find solutions, I have tried to understand the
>>> problem in spite of having gone to great lengths to try to discuss the
>>> limitations of the proposed approach in every venue I possibly could.
>>>
>>> I go out of my way to deal professionally and objectively with what is
>>> presented. Nothing here is emotional. So I'd ask that you please abstain
>>> from making commentary like this which has no basis.
>>
>> I appreciate everything you write below. But this request is just
>> impossible. I will keep raising my opinion and misunderstandings will
>> happen.
> 
> Well I wouldn't ask you not to express your opinion David, you know I respect
> and like you, and by all means push back hard or call out what you think is bad
> behaviour :)
> 
> I just meant to say, in my view, that there was no basis, but I appreciate
> miscommunications happen.
 > > So apologies if I came off as being difficult or rude, it actually 
wasn't
> intended. And to re-emphasise - I have zero personal issue with anybody in this
> thread whatsoever!

It sounded to me like you were trying to defend your work (again, IMHO 
too emotionally, and I might have completely misinterpreted that) and 
slowly switching to "friendly fire" (towards me). Apologies from my side 
if I completely misunderstood/misinterpreted that.

To recap: what we have upstream is great; you did a great job. Yes, the 
mechanism has its drawbacks, but that's just part of the design.

Some people maybe have wrong expectations, maybe there were 
misunderstandings, or maybe there are requirements that only now pop up; 
it's sometimes unavoidable, and that's ok.

We can try to document it better (and I was trying to find clues why 
people might be mislead), and see if/how we could sort out these 
requirements. But we can likely not make it perfect in any possible way 
(I'm sure there are plenty of use cases where what we currently have is 
more than sufficient).

 > > I just want to find the best way forward, technically and am 
willing to do
> whatever work is required to make the guard region implementation as good as it
> possibly can be.
> 
>>
>> Note that the whole "Honestly David you and the naming. .." thing could have
>> been written as "I don't think it's a naming problem."
> 
> I feel like I _always_ get in trouble when I try to write in a 'tongue-in-cheek'
> style, which is what this was meant to be... so I think herein lies the basis of
> the miscommunication :)
> 
> I apologise, the household is ill, which maybe affects my judgment in how I
> write these, but in general text is a very poor medium. It was meant to be said
> in a jolly tone with a wink...
> 
> I think maybe I should learn my lesson with these things, I thought the ':p'
> would make this clear but yeah, text, poor medium.
> 
> Anyway apologies if this seemed disrespectful.

No worries, it's hard to really make me angry, and I appreciate your 
openness and your apology (well, and you and your work, obviously).

I'll note, though, if my memory serves me right, that nobody so far ever 
  criticized the way I communicate upstream, or even told me to abstain 
from certain communication.

That probably hurt most, now that a couple of hours passed. Nothing that 
a couple of beers and a bit of self-reflection on my communication style 
can't fix ;)

[...]

>>>>> Yeah that's a good point, but honestly if you're reading smaps that reads
>>>>> the page tables, then reading /proc/$pid/pagemaps and reading page tables
>>>>> TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
>>>>> /proc/$pid/pagemaps and reading page tables once.
>>>>
>>>> Right; I recently wished that we would have an interface to obtain more VMA
>>>> flags without having to go through smaps
>>>
>>> Well maybe that lends itself to the idea of adding a whole new interface in
>>> general...
>>
>> An extended "maps" interface might be reasonable, that allows for exposing
>> more things without walking the page tables. (e.g., flags)
>>
>> Maybe one could have an indicator that says "ever had guard regions in this
>> mapping" without actually walking the page tables.
> 
> Yeah this is something we've discussed before, but it's a little fraught. Let's
> say it was a VMA flag, in this case we'd have to make this flag 'sticky' and not
> impact merging (easy enough) to account for splits/merges.
 > > The problem comes in that we would then need to acquire the VMA 
write lock to do
> it, something we don't currently require on application of guard regions.

Right, and we shouldn't write-lock the mmap. We'd need some way to just 
atomically set such an indicator on a VMA.

I'll also note that it might be helpful for smallish region, but 
especially for large ones (including when they are split and the 
indicator is wrong), it's less helpful. I don't have to tell you about 
the VMA merging implications, probably it would be like VM_SOFTDIRTY 
handling :)

> 
> We'd also have to make sure nothing else makes any assumptions about VMA flags
> implying differences in VMAs in this one instance (though we do already do this
> for VM_SOFTDIRTY).
> 
> I saw this as possibly something like VM_MAYBE_GUARD_REGIONS or something.

Yes.

-- 
Cheers,

David / dhildenb


