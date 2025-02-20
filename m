Return-Path: <linux-kselftest+bounces-27056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC614A3D49B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A43189E953
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6C1EE7A1;
	Thu, 20 Feb 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYWEBBYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943431EC00B
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043447; cv=none; b=TF1PxZhMOh+xwZUC13SirabVm5pG7RqkZ9VpuspbmrMKMDef/kvACxPKFaxG5/Fepvg0dDKgGdJy37VYrlOZxuyV49bYqXB4zDUfSCv4LGpIBciqQrXpV/ul3c5vj0uxV3xdn39LA7uWZdxbeQ9X71xT4gSHOuZUu8MNuRN+hUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043447; c=relaxed/simple;
	bh=QFMH5cVq3bPNCINQ2gzof644QH5INZW41/T9A1hzqQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw3G/jt0GG9Tval/ZGzcgeaXmaw7TgznSwUcBeigI4sSuW7fKLs9UtjVE+7J5y2vtqxHGVEObOHtTjNUICK7klV/1qaKD/TgX8yWVvEG9kpnvlX8t8o5pKONOsOzq9eF7+TDWKxXVcWg6wZFcKh6FDLI1AGmSX1gTO9fTH6NTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYWEBBYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740043444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fFvyCIWMKh3wka+TR0+Xm2EQq9FKeB2rd7/ppzgWCJ4=;
	b=KYWEBBYjE2C38KGtaNQxKz5BmaZmtGu4P4D0Q3SP7Wha7yT5a/TH47o18O3HgHg/AxbZKL
	mremH6tIzljT2f0Hm9H2nsa/XRbdbXltv7wFGX74VPsaQfMJBo7RUzYn+DI3ew4kwMDHai
	BGgHwcJg4avljV5qKlU1Hy53cToqfUI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-QNvd7MCoN4mKqCRG08F7qg-1; Thu, 20 Feb 2025 04:24:02 -0500
X-MC-Unique: QNvd7MCoN4mKqCRG08F7qg-1
X-Mimecast-MFC-AGG-ID: QNvd7MCoN4mKqCRG08F7qg_1740043441
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f36f03312so307958f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 01:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740043441; x=1740648241;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFvyCIWMKh3wka+TR0+Xm2EQq9FKeB2rd7/ppzgWCJ4=;
        b=fBkwTMJJGXLpllb4oOKj6hyoojawnVYsz+M08AAtDmplcxXQHctVI+JXGx/22MajDX
         2b+VWfe2zokkgFip7NvOKWddrFa3WU7WOPaDr/A2xdM2ShneGDdr6c2vUFT83LSBAzg8
         O+mwJv2foigTSi0oR3gSa8t1UDuogveVABKuAnq8/OcXjxMyKJlsu0ipNw16yMt1UmDp
         8HSZKKwHaCaGhV5JCH3/niNlvBy0JcFVYPZKlEZDfg3a1LgOanXlwcZndleVI2+lRT8w
         g96gQ4HlOae6OOWn/aI95ZX7LLIoKWx+HM27+ScP1t0QabUs3IHSCWNgrry0vfLCNBiP
         pD4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgvTH03lLSziUKjqxViD15wxTC+iKbzNv/1DCd5RYRns54hCIfIVJH8C169G4SqgDlGGiiLRvIDDUkZbXNYMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQjSxt9Cfr5golh9JAoh1quL5xb1jfP4buOQ5SlSBaO4+aPXe
	PEebO2Qf8wy8rcDh0mX4jfEUh6Bo39bvSIa+pdi52IqnAle5PKS/m5r4Lp0rXVAlzXtS5Oda0DL
	DBeurFR6Qtls7ZdN2Ym82UJ4SfiuqUSH2bGqyYJaEfj91Li40AuPYPN8gXLyAxIAGKQsi9SSDZQ
	==
X-Gm-Gg: ASbGncudtxyQj28uTSNHY7lhjfURUvu+6zAcB5Akm+/dnw3wcdqJKVDElkpKB4dxWVf
	zbFxfuYwm8mDEdPsubUKErhE3ELPtbOD3GUkyqg4+RDF2LM2dGmaxRKNjOBIW9qOFFQqAVNamCv
	1ErXPd/WbOyf/A6PVR7vldNZV6SOcZ+RSB4Mk8hjdUlM8YBLq7owHYRNFejGcrafQReDfre5mI4
	wdcEX8EGwuL26ST25JDcspPG0i/u472Wp9u7FWfxlqLzn8r/ggDt1hu/PyCs2gXoIFg/yYfHUMD
	DK9Xz27vC/WHJv8mvLFqm8izNqlE3G7ejA5gxIeMKKtYSRxDy2Lo415aqHKyrMxBbPJTJJYCAn7
	lU+uuZ2B9lWPUOh5zXh7p3CwjWKCxZw==
X-Received: by 2002:a5d:6402:0:b0:38f:2f0e:980c with SMTP id ffacd0b85a97d-38f33f57c13mr13344130f8f.47.1740043441354;
        Thu, 20 Feb 2025 01:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI3roX65hkIqh5GF76I3lV0G/tJhHexZzeUM6o+hPY34QemFDlxno+ImnmvamvVYBP2oAW3A==
X-Received: by 2002:a5d:6402:0:b0:38f:2f0e:980c with SMTP id ffacd0b85a97d-38f33f57c13mr13344095f8f.47.1740043440896;
        Thu, 20 Feb 2025 01:24:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591513bsm20268843f8f.55.2025.02.20.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:23:59 -0800 (PST)
Message-ID: <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
Date: Thu, 20 Feb 2025 10:23:57 +0100
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
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 10:04, Lorenzo Stoakes wrote:
> On Thu, Feb 20, 2025 at 09:57:37AM +0100, David Hildenbrand wrote:
>> On 20.02.25 09:51, Lorenzo Stoakes wrote:
>>> On Wed, Feb 19, 2025 at 12:56:31PM -0800, Kalesh Singh wrote:
>>>>> We also can't change smaps in the way you want, it _has_ to still give
>>>>> output per VMA information.
>>>>
>>>> Sorry I wasn't suggesting to change the entries in smaps, rather
>>>> agreeing to your marker suggestion. Maybe a set of ranges for each
>>>> smaps entry that has guards? It doesn't solve the use case, but does
>>>> make these regions visible to userspace.
>>>
>>> No, you are not providing a usecase for this. /proc/$pid/pagemaps does not
>>> contaminate the smaps output, mess with efforts to make it RCU readable,
>>> require updating the ioctl interface, etc. so it is clearly the better
>>> choice.
>>>
>>>>
>>>>>
>>>>> The proposed change that would be there would be a flag or something
>>>>> indicating that the VMA has guard regions _SOMEWHERE_ in it.
>>>>>
>>>>> Since this doesn't solve your problem, adds complexity, and nobody else
>>>>> seems to need it, I would suggest this is not worthwhile and I'd rather not
>>>>> do this.
>>>>>
>>>>> Therefore for your needs there are literally only two choices here:
>>>>>
>>>>> 1. Add a bit to /proc/$pid/pagemap OR
>>>>> 2. a new interface.
>>>>>
>>>>> I am not in favour of a new interface here, if we can just extend pagemap.
>>>>>
>>>>> What you'd have to do is:
>>>>>
>>>>> 1. Find virtual ranges via /proc/$pid/maps
>>>>> 2. iterate through /proc/$pid/pagemaps to retrieve state for all ranges.
>>>>>
>>>>
>>>> Could we also consider an smaps field like:
>>>>
>>>> VmGuards: [AAA, BBB), [CCC, DDD), ...
>>>>
>>>> or something of that sort?
>>>
>>> No, absolutely, categorically not. You realise these could be thousands of
>>> characters long right?
>>>
>>> /proc/$pid/pagemaps resolves this without contaminating this output.
>>>
>>>>> Well I'm glad that you guys find it useful for _something_ ;)
>>>>>
>>>>> Again this wasn't written only for you (it is broadly a good feature for
>>>>> upstream), but I did have your use case in mind, so I'm a little
>>>>> disappointed that it doesn't help, as I like to solve problems.
>>>>>
>>>>> But I'm glad it solves at least some for you...
>>>>
>>>> I recall Liam had a proposal to store the guard ranges in the maple tree?
>>>>
>>>> I wonder if that can be used in combination with this approach to have
>>>> a better representation of this?
>>>
>>> This was an alternative proposal made prior to the feature being
>>> implemented (and you and others at Google were welcome to comment and many
>>> were cc'd, etc.).
>>>
>>> There is no 'in combination with'. This feature would take weeks/months to
>>> implement, fundamentally impact the maple tree VMA implementation
>>> and... not actually achieve anything + immediately be redundant.
>>>
>>> Plus it'd likely be slower, have locking implications, would have kernel
>>> memory allocation implications, a lot more complexity and probably other
>>> problems besides (we discussed this at length at the time and a number of
>>> issues came up, I can't recall all of them).
>>>
>>> To be crystal clear - we are empathically NOT changing /proc/$pid/maps to
>>> lie about VMAs regardless of underlying implementation, nor adding
>>> thousands of characters to /proc/$pid/smaps entries.
>>
>> Yes. Calling it a "guard region" might be part of the problem
>> (/"misunderstanding"), because it reminds people of "virtual memory
>> regions".
>>
>> "Guard markers" or similar might have been clearer that these operate on
>> individual PTEs, require page table scanning etc ... which makes them a lot
>> more scalable and fine-grained and provides all these benfits, with the
>> downside being that we don't end up with that many "virtual memory regions"
>> that maps/smaps operate on.
> 
> Honestly David you and the naming... :P
> 
 > I disagree, sorry. Saying 'guard' anything might make people think 
one> thing or another. We can't account for that. I mean don't get me 
started on
> 'pinning' or any of the million other overloaded terms we use...
> 
 > I _hugely_ publicly went out of my way to express the limitations, I 
gave a> talk, we had meetings, I mentioned it in the series.
> 
> Honestly if at that point you still don't realise, that's not a naming
> problem. It's a 'did not participate with upstream' problem.
> 
> I like guard regions, as they're not pages as we previously referred to
> them. People have no idea what a marker is, it doesn't sound like it spans
> ranges, no don't like it sorry.
> 
> And sorry but this naming topic is closed :) I already let you change the
> naming of the MADV_'s, which broke my heart, there will not be a second
> heart breaking...

Lorenzo, I was not pushing for it to be changed *now*, that ship has 
sailed, and personally, I *don't* find it confusing because I know how 
it works under the hood.

I was trying to find a reason *why* people would thing that it would 
show up in smaps in the first place. For example, just when reading the 
MAN page *today*.

Doesn't really matter now, it is named the way it is, and all we can do 
is try making documentation clearer if it keeps confusing people.

Your conclusion is 'did not participate with upstream'; I don't agree 
with that. But maybe you and Kalesh have a history on that that let's 
you react on his questions IMHO more emotionally than it should have been.


> 
>>
>> [...]
>>
>>>
>>> As I said to you earlier, the _best_ we could do in smaps would be to add a
>>> flag like 'Grd' or something to indicate some part of the VMA is
>>> guarded. But I won't do that unless somebody has an -actual use case- for
>>> it.
>>
>> Right, and that would limit where you have to manually scan. Something
>> similar is being done with uffd-wp markers IIRC.
> 
> Yeah that's a good point, but honestly if you're reading smaps that reads
> the page tables, then reading /proc/$pid/pagemaps and reading page tables
> TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
> /proc/$pid/pagemaps and reading page tables once.

Right; I recently wished that we would have an interface to obtain more 
VMA flags without having to go through smaps

-- 
Cheers,

David / dhildenb


