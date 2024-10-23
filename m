Return-Path: <linux-kselftest+bounces-20447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8EB9AC691
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0311C21A47
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71A19D075;
	Wed, 23 Oct 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEh9j9mh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C719CD0E
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675800; cv=none; b=oCbxTQn85FqbSWW+Jx4mhys9KC1RbePCDBc20SCgm+PZ1+Nu0AfdcCW1aa2IaSZWcczEdTmdp95lUByhLeB9GDj4/2tUpLa2sqYfI+2Vlai7YOXa9ovhkhrv3u53eZpWNslR37GRgaeitVKd/FpwdwWnwGd0HrtNsHKGf8qygPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675800; c=relaxed/simple;
	bh=5ZBamS1Ea597xMRWnxUmpWUHfW/ju3MyCBHyH44X3Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgN4qSOdH765DrGhbf6iE7M2I8e3hl6n+4pL4PnTV3ddsoG0HXRai9YSo6ykIdOBHPNXqFkSuf5SJN2tk2BWnEi+YJPs2ciC3ixWryqHAkYaLlXF+tTfpSDFIeiLZyqR07QdzihqxeCbB7ZQ2Xm1Jady2H9LxXi2cmY1r2BG5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEh9j9mh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729675798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NglIqu+VxUNes8wq3KeSCbvotAenvubJqH0EIAV9xBE=;
	b=aEh9j9mhUp2qMMTlVwhJYVMMkohL/u04RsoHccSoPd6yEP3nRvpvK74u22f+NsA3GUyeZV
	5zYO3ZnFqbgDY53nRUUSVrwN+AChpzLluepQvv/lrrYEZTdv3skQ+BbUxkmSfL/dg4xiDX
	Vz+QhMEW2gGw4Y8B/xYfhOyVKrTFbMA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-n5y0v0L5P9mb_VX_HE37TQ-1; Wed, 23 Oct 2024 05:29:56 -0400
X-MC-Unique: n5y0v0L5P9mb_VX_HE37TQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539eb3416cdso5517778e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 02:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675795; x=1730280595;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NglIqu+VxUNes8wq3KeSCbvotAenvubJqH0EIAV9xBE=;
        b=LoUPSgU6P3fqap88vaJZLmgHwEYF2uSjCAssuR501idli93tsKICypXFq8zbKbBQwt
         rCSfFSjAUzvpg2DUrXSOu8B5DqIbHL7oOY6QtM4/+C1/QWy7rrDqNFwNqFjrdcHdNExg
         oqkIBNsnCxVtAfRTyoSFNZskOwCfKYpViXCnt6OMR1y4LMqSLgKbEzIe1ZQ2ctd7UJfL
         WzcaseVubV7LEUunDwQHATepttwAjFlIwmmL9Rm3BrgChYBPtUEZIn7rz6eD7NIVkjay
         VldwMgd/DVylqrMw6LWxlb26fErNopaof69OQ/PB8Vh5DL1q+13IXODV49wcUvvOmtVa
         B0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXzU+J5cyPGy5Q8y8BQ3hvbfkkMj1OqvDHIMkzFR3d80zjlTtY9tRJAWSTBszgTt/o/dQW5bzYUcUUJMmhNPI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSP5amZHsi17r1QBQlMnShSt0qvyJqWzHjmiSoIaI0nj8idKWg
	t/BBfovrijfQldZRzjc9ZugX0I7d2eX1olz5+tk7RDSu1H7Vx/dn1bake90fTmGPkL4X+t9rVBB
	GplSvEl+HPdeNcCnoHJdQMuci5wtLWBS5Ju7l0APJNtxY25ijryAlkscHFnleu0KwBA==
X-Received: by 2002:a05:6512:2355:b0:539:fa43:fc36 with SMTP id 2adb3069b0e04-53b1a2f42abmr790943e87.12.1729675794935;
        Wed, 23 Oct 2024 02:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiYyj6F7YDQSLG2wAFhIUANmvWJj0aVgSUN/OMCnMStsfisyFRCfqYCP13y+F3bTLBHAWAWA==
X-Received: by 2002:a05:6512:2355:b0:539:fa43:fc36 with SMTP id 2adb3069b0e04-53b1a2f42abmr790923e87.12.1729675794470;
        Wed, 23 Oct 2024 02:29:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bdbb01sm10999135e9.20.2024.10.23.02.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:29:53 -0700 (PDT)
Message-ID: <1768ef5d-7289-4d2b-ae02-f5d2a20d5320@redhat.com>
Date: Wed, 23 Oct 2024 11:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
 fw@deneb.enyo.de, James.Bottomley@hansenpartnership.com,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
 brauner@kernel.org, chris@zankel.net, deller@gmx.de, hch@infradead.org,
 ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com,
 jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, mattst88@gmail.com, muchun.song@linux.dev,
 paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org,
 sidhartha.kumar@oracle.com, surenb@google.com, tsbogend@alpha.franken.de,
 willy@infradead.org, elver@google.com,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <87a5eysmj1.fsf@mid.deneb.enyo.de>
 <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
 <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com>
 <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
 <f000d21f-dd04-462a-9d34-d0e7f0f7dc2e@redhat.com>
 <b5792b5f-298b-499f-abc2-db773ceeed36@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b5792b5f-298b-499f-abc2-db773ceeed36@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 11:18, Lorenzo Stoakes wrote:
> On Wed, Oct 23, 2024 at 11:13:47AM +0200, David Hildenbrand wrote:
>> On 23.10.24 11:06, Vlastimil Babka wrote:
>>> On 10/23/24 10:56, Dmitry Vyukov wrote:
>>>>>
>>>>> Overall while I sympathise with this, it feels dangerous and a pretty major
>>>>> change, because there'll be something somewhere that will break because it
>>>>> expects faults to be swallowed that we no longer do swallow.
>>>>>
>>>>> So I'd say it'd be something we should defer, but of course it's a highly
>>>>> user-facing change so how easy that would be I don't know.
>>>>>
>>>>> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
>>>>> guards' series is the place to also fundmentally change how user access
>>>>> page faults are handled within the kernel :)
>>>>
>>>> Will delivering signals on kernel access be a backwards compatible
>>>> change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
>>>> It's just somewhat painful to detect/update all userspace if we add
>>>> this feature in future. Can we say signal delivery on kernel accesses
>>>> is unspecified?
>>>
>>> Would adding signal delivery to guard PTEs only help enough the ASAN etc
>>> usecase? Wouldn't it be instead possible to add some prctl to opt-in the
>>> whole ASANized process to deliver all existing segfaults as signals instead
>>> of -EFAULT ?
>>
>> Not sure if it is an "instead", you might have to deliver the signal in
>> addition to letting the syscall fail (not that I would be an expert on
>> signal delivery :D ).
>>
>> prctl sounds better, or some way to configure the behavior on VMA ranges;
>> otherwise we would need yet another marker, which is not the end of the
>> world but would make it slightly more confusing.
>>
> 
> Yeah prctl() sounds sensible, and since we are explicitly adding a marker
> for guard pages here we can do this as a follow up too without breaking any
> userland expectations, i.e. 'new feature to make guard pages signal' is not
> going to contradict the default behaviour.
> 
> So all makes sense to me, but I do think best as a follow up! :)

Yeah, fully agreed. And my gut feeling is that it might not be that easy 
... :)

In the end, what we want is *some* notification that a guard PTE was 
accessed. Likely the notification must not necessarily completely 
synchronous (although it would be ideal) and it must not be a signal.

Maybe having a different way to obtain that information from user space 
would work.
-- 
Cheers,

David / dhildenb


