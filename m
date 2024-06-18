Return-Path: <linux-kselftest+bounces-12173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA990DDDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3331C2311A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21316DC19;
	Tue, 18 Jun 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB6XPpzd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0ED46BA6
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744054; cv=none; b=ZogHrnkFg0TvR/q/JcuDqriQJSPVvcpCATyhxCK9U7kQtD4m/GFwAAgvkg8fYtnEVLZhCuMWQzzWUQFyedb5KoGOujlAumr9+4S3y9xXtxLoaQsNcFOx44SW4CHF6+C045EZGzWZ+WPsh5QXjl55QddaEXpueDkGyThST9S4Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744054; c=relaxed/simple;
	bh=OCrX4q63PJGIMkk1OE7cn8W3PWwaJkynKJIRmjgsbeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiL7GlE72Gnl2Q3hSGN4Ntih5XJWMEiOvOkp53BPGR4lcLOd/xvZw+Tyyi1YujZUO88NnUHQvgKjvIw8kD8NHhtiFIHCdVj1lLtsru35YdR4IqH2/aQpy2MwbHs5qagu3LsvjLdfD5DFZVQ8FcrJs+9m10S4ukFMxltJJtkR/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB6XPpzd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718744051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T4M1vg2KI3INTfsrYTcRbvvCZ9fFmnVg64uCWrgyPMY=;
	b=OB6XPpzdQreQTTud8ju1z91iIkFaXR7mXksUTIq+3rvubtUQmZK/I7cWYZGM03NnJ8faKV
	7GeRPfaPjlbvArOCydwAqpZRRagTPac7RGAK/fknWVGwfAPpXioDJw4MiGDkxsv0mslBOJ
	h9YCs84gyEHtP53ZwwVlCIZNnn612kc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-wjxpQNuzNl2SjwvMndFgbw-1; Tue, 18 Jun 2024 16:54:10 -0400
X-MC-Unique: wjxpQNuzNl2SjwvMndFgbw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3625bef4461so116905f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 13:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718744049; x=1719348849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T4M1vg2KI3INTfsrYTcRbvvCZ9fFmnVg64uCWrgyPMY=;
        b=CnyIqUeBiDx9eU+bMqI7otNWvD6f1Nq/vINlpDPsV1ax3Nq/WYnWe4H1S1VtT7KpNi
         mo+U/vool0+pRaikpC2e3yFq8LvBI3x7gLv0HeXwQXr2+vc/hepAPXXbRF+riGpcIxpA
         bFgrT5QtDu4jL4tEeMJgjcQsoXYuz8Eoyw1WC8ih8v7qoDJPCOrbWFuSVrX569sLvQHA
         8LLzyHTxGEwNQZSWDwiINPbF+mU40D2AiHDVjmiipwXtYVHFw+ezcT35yQrC1d/v78vF
         I8XoX9w/JZaDQ2ICgiFYOF9660rNv+3phW8yzh4F91f86BJ5Aaui0/bnLqHoD1K6A1OH
         VZvA==
X-Forwarded-Encrypted: i=1; AJvYcCVH/sn7kXeUeg/EkvrTRP5Yrug2G/fmK18kfwjeTQg0Bl1Frpxpu+jNfa9TKUJUFRcNhWbXTfH3rCHsC2GhNstgktEYKMowuiKMVwBhhvFk
X-Gm-Message-State: AOJu0Yyk1bKOSaI//e+NYcM42MsYipEs8Ol4iKkXzpiJGDMoRCPgC3BX
	at6Orrf49+l687Y1ra1fhn+wBqvtr7jgLtEvrtSVwABoD6RX5mUXkvpcywPr26bg3/BRxyIsy/n
	E0jLoNmVMuWmsUtQvLgeoYCEntbrKCZMdN85hgxGug32fgtM5INefQEltYhp+sADv/A==
X-Received: by 2002:adf:f10d:0:b0:35f:1bb0:ed8e with SMTP id ffacd0b85a97d-3609ea6c78amr3512072f8f.21.1718744049264;
        Tue, 18 Jun 2024 13:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2dQnC66MnPCev8ct4GNUIewCHJAEIIYdimrD2HDVajRPI3kf7fS3o3xuuC3od8NCHsWLEJQ==
X-Received: by 2002:adf:f10d:0:b0:35f:1bb0:ed8e with SMTP id ffacd0b85a97d-3609ea6c78amr3512046f8f.21.1718744048694;
        Tue, 18 Jun 2024 13:54:08 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23361.dip0.t-ipconnect.de. [79.242.51.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f612800csm199946905e9.28.2024.06.18.13.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 13:54:08 -0700 (PDT)
Message-ID: <916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
Date: Tue, 18 Jun 2024 22:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-2-jhubbard@nvidia.com>
 <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
 <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.06.24 22:14, John Hubbard wrote:
> On 6/17/24 11:56 PM, David Hildenbrand wrote:
>> On 18.06.24 04:24, John Hubbard wrote:
> ...
>>> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
>>> index f2babec79bb6..27bf2f84231d 100644
>>> --- a/tools/testing/selftests/mm/seal_elf.c
>>> +++ b/tools/testing/selftests/mm/seal_elf.c
>>> @@ -2,7 +2,7 @@
>>>    #define _GNU_SOURCE
>>>    #include <sys/mman.h>
>>>    #include <stdint.h>
>>> -#include <unistd.h>
>>> +#include <asm-generic/unistd.h>
>>>    #include <string.h>
>>>    #include <sys/time.h>
>>>    #include <sys/resource.h>
>>
>> Still confused. Let's take a look at "microblaze".
>>
>> arch/microblaze/include/asm/unistd.h
>>    -> #include <uapi/asm/unistd.h>
>>
>> arch/microblaze/include/uapi/asm/unistd.h
>>    -> #include <asm/unistd_32.h>
>>     -> Generated during "make headers"
>>
>> usr/include/asm/unistd_32.h is generated via
>> arch/microblaze/kernel/syscalls/Makefile with the syshdr command.
>>
>> So we never end up including asm-generic/unistd.h directly on microblaze, but rather converts it (IIUC) to something else.
>>
> 
> Yes.
>    
>> That will work as expected here?
>>
> 
> No. :)
> 
> The problem, and the source of confusion here, is that for most user
> space programs, the header file inclusion behaves as you've mentioned
> above. However, those programs are installed on a single computer that
> has a single set of asm and kernel headers installed.
> 
> We are quite special here, because we are building a set of user space
> programs that:
> 
>       a) Mostly avoids using the installed (distro) system header files.
> 
>       b) Must build (and run) on all supported CPU architectures
> 
>       c) Must occasionally use symbols that have so new that they have not
>          yet been included in the distro's header files.
> 
> Doing (a) creates a new problem: how to get a set of cross-platform
> headers that works in all cases.
> 
> Fortunately, asm-generic headers solve that one. Which is why we need to
> use them here.
> 
> The reason this hasn't really come up yet, is that until now, the
> kselftests requirement (which I'm trying to remove) was that "make
> headers" must first be run. That allowed the selftests to get a snapshot
> of sufficiently new header files that looked just like (and conflict
> with) the installed system headers.
> 
> I can update the commit description with some of the above, if it helps.

I think it will. The main concern I had was that we could be ending up 
including headers with *wrong* data. As long as (a) it compiles where 
it's supposed to compile (b) it runs where it's supposed to run, we're 
good :)

-- 
Cheers,

David / dhildenb


