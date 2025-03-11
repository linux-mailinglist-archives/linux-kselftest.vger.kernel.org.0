Return-Path: <linux-kselftest+bounces-28780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79FA5CFF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18311189EC0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957B25C6FF;
	Tue, 11 Mar 2025 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0E6LAaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A499222562
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722793; cv=none; b=ocexACzJ2AjEcYFoKy/NniReuMMhCKg/okDk+BGsNX9cv9ErqzvaF7N5km9dWP+JDRaaYGnX2m+aRkccZCEBiSsvpjROIYULMHD1Y0s1p7onRvT4G1IPHYWS10Y5jszw+UxkbdJcj5K8o3RvcMMbD3v018xAX/XzrTLRkbyUL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722793; c=relaxed/simple;
	bh=NJseY7C1SpSFVTv5dLsOc50D7N9N2dODG4zTKs2IhPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bN6ctsVFy949f2BfHYmA8pw8PI1CPA4RmEbfxl+FfBFJisTScQIrvAgwjIRP6sJsXWGaOpaRFm5I5um1Yku+A8mYwdwZtOA5cZEt+PVbo8n1p7v4rsLqO5LFbXgPJE2iZe0VLBzaZfIAsS2O0Kr1qhfAEkDYQIrZffGemxg2tX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0E6LAaM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741722790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nSCELKnz9oT5fhXD+6YV9v49S2Dc+mXaAiXl2NGEuuc=;
	b=L0E6LAaMjVp+N4sWb+FtmItr4h7FiUu+Sadj6t9o8zkuFc7zTB8OcPJCIZw8aAU/SsBsHl
	aCsVQ3zxMjywbSm63iZhRdvwDXV1PuyqK9VfWjRYng9UiY4/JLR3FZOrpBr5CuFjZmMj2h
	WTrj1MX+mYXerSHTKdGDvDp4nHG/HTk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Qw8FKgucNPyAww9A67hoSw-1; Tue, 11 Mar 2025 15:53:05 -0400
X-MC-Unique: Qw8FKgucNPyAww9A67hoSw-1
X-Mimecast-MFC-AGG-ID: Qw8FKgucNPyAww9A67hoSw_1741722784
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so15645085e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722784; x=1742327584;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nSCELKnz9oT5fhXD+6YV9v49S2Dc+mXaAiXl2NGEuuc=;
        b=KAplTouTkmDjmJNJ/St5t5o1aEhV8rrGlOSvz5xXhNIC8yQhGoyirIYrbEcZnvGOz4
         4pK7WxDSeVz1eIlnDXMcG0vo3epDJ7Bof2whxavYE6xlCqD+ddKYd+6rLhJ+9u9l7vZa
         vXVo2QB9IRTm9QsuSN3Ie9D9dOaeMwme2E/7IzJJJqQwlIqJDiTXkQy0TLwj8uRAUbSp
         TgxBwVtJd09jbHYJtpCFvbWW2YfGEIYgaTJh/ms00WZWZ97eFzSEqF2xdvCTSAgas5Ki
         CdoHZ9H0OqjMNxtTHE1I4fQXURk6DxhS0eXGipoiGA06nvCUFRAq7GySjzbYg6Zzx+8V
         sn7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7aF9RJ0lHOuEX//qxFYxDyYppm8qk6DH7F617/1fOEr1NZwoEpDE9wpeiA30SCzjHCFOLgEdDr1uaKJapfUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAebloO3Px7A34jN2dvmG+Urdwcq197skEtlGh8Q2WjUcxwYnN
	nQcyBV5puwRIFVl8Um2/oS+NTs5HAKZzd2SiA71/QZgxPoqvGgRuo6r21hPFk2zEtKfhNWwlXek
	AmpbbtmgcMsZc/kxxy4RkZPdGwkERJ6NF3o1LgP2SNj/1KwcrnxH1MqvB2xCI7gvuBg==
X-Gm-Gg: ASbGnctW0Vp8kE5FZSCDbjaptombA5xKbP16bTEscOO9nehphRvZUWJ4FaZxx5nsRb0
	/i32+H0N3LHgdbKC90+Eks3aL26jBkqWxbU8zrLDEKFe40JYOy5ZXbIScZL7opchVOQ5+I1282X
	bKlmP+pxzJ1M/MTN9hSrUWfY8F/6iX4/VHlNATRNKIkU6chZRomezaBqogO50dLNH0RJPRSQSnu
	LNjJqZZvSCWh8griwoO17lO+7/UH6aHorAyaA4C21IHo1ZUz9+DSliBekcOL2LNDKrCd6DiQSiu
	AIgD+dqHj3ajW6W18gEYKGUSrFZoyXCPQymrpZ0iL3wUSRCD7V1XtGmtTnqNTlZe1dYEDE4UbUQ
	/f3M9TwDhzCRo55TyYIlqi+edZV8LJIBqtE1AY2z8+yQ=
X-Received: by 2002:a05:6000:156b:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-39132dc56f2mr16878805f8f.38.1741722784118;
        Tue, 11 Mar 2025 12:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhgrD+N+YZbd6fE1d4KfDD97I29g3PdoOxBvKU5p2H5xD2/2UEdWQ4/lMIeGhrmuFg8yRU/w==
X-Received: by 2002:a05:6000:156b:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-39132dc56f2mr16878799f8f.38.1741722783778;
        Tue, 11 Mar 2025 12:53:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce9f2d081sm129445495e9.21.2025.03.11.12.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:53:03 -0700 (PDT)
Message-ID: <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
Date: Tue, 11 Mar 2025 20:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 14:00, Brendan Jackman wrote:
> On Thu, 6 Mar 2025 at 15:40, David Hildenbrand <david@redhat.com> wrote:
>> Yes, just skip 9pfs early, and mention in the commit message that 9pfs
>> has a history of being probematic with "use-after-unlink", maybe
>> mentioning the discussion I linked above.
>>
>> Maybe something like this would work?
>>
>> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
>> index 9423ad439a614..349e40d3979f2 100644
>> --- a/tools/testing/selftests/mm/gup_longterm.c
>> +++ b/tools/testing/selftests/mm/gup_longterm.c
>> @@ -47,6 +47,16 @@ static __fsword_t get_fs_type(int fd)
>>           return ret ? 0 : fs.f_type;q
>>    }
>>
>> +static bool fs_is_problematic(__fsword_t fs_type)
>> +{
>> +       switch (fs_type) {
>> +       case V9FS_MAGIC:
>> +               return false;
>> +       default:
>> +               return true;
>> +       }
>> +}
> 
> Ugh, some fun discoveries.
> 
> 1. fstatfs() seems to have the same bug as ftruncate() i.e. it doesn't
> work on unlinked files on 9pfs. This can be worked around by calling
> it on the parent directory, but...

oO what a piece of bad software :(

> 
> 2. 9pfs seems to pass the f_type through from the host. So you can't
> detect it this way anyway.
> 
> [3. I guess overlayfs & friends would also be an issue here although
> that doesn't affect my usecase.]
> 
> Anyway, I think we would have to scrape /proc/mounts to do this :(
> 

The question I am asking myself: is this a 9pfs design bug or is it a 
9pfs hypervisor bug. Because we shouldn't try too hard to work around 
hypervisor bugs.

Which 9pfs implementation are you using in the hypervisor?

> I think the proper way to deal with this is something like what I've
> described here[0]. I.e. have a central facility as part of kselftest
> to detect relevant characteristics of the platform. This logic could
> be written in a proper programming language or in Bash, then the
> relevant info could be passed in via the environment or whatever (e.g.
> export KSFT_SYSENV_cwd_ftruncate_unlinked_works=1).
> 
> [0] https://lore.kernel.org/all/Z8WJEsEAwUPeMkqy@google.com/
> 
> But, to find an immediate way to get these tests working, I think we
> are stuck with just peeking at errno and guessing for the time being.



-- 
Cheers,

David / dhildenb


