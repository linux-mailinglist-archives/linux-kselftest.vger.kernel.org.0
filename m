Return-Path: <linux-kselftest+bounces-35694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B10AE6B49
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D221C40DF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896912E0B7D;
	Tue, 24 Jun 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5gFFZjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA52D879D
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778230; cv=none; b=iPNzJ54zR6U50Jj4k2Nwum9kiwXYDgoJE5XdG6hg6kN4gIiXBsEAJj+26hEnu0R1vNqEBRDlmCm9aCDiEDoHe82oNk9GAPOUozSYXHQZpBqw/Mm2dAv5UevbfK6vZ1gn1HCFZxp0hCoNWAB6BxGUhbdHWSHVYI/r4DfdAzj1ZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778230; c=relaxed/simple;
	bh=/t4AUoydJ3jOkriY2x6fx+wQFZcnsKlRKuN5oo690hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG5+mF17aV0iQDE7fSXF1VixVrsaoG+df+ZnWDnus5ktM7Ow7kdVtPssQPKEkJyWB7BdiVJcJqb0xgeMg+VNQ+8ZN6QEhwhcwJAm+/fRDpqKOz/FZV/w23NrQZRH/gKnY4HuBNavwBL6VSixBiwKXsoQCcPb0Edk1dzhSgvxBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5gFFZjk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750778227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VS7WT/Myda/TmCCBpV0MVboU7jS+MnjU+H4FMQ/YZGE=;
	b=K5gFFZjkQIDbIJfuiXA+EUt60Ql6DEcHbBuhxyb+9TaBvTL4ghqSZ80+emq2lzIXH8uGuz
	uWzco2fi0mkgfNT1AnSyp3tC41RbkK5g4b4/cpXslLHHSb6Rkqqa1I/8fYHwqU9ViypL1A
	l4JN4bKmrYYK0wPwYPpvY3jRMtjmyV8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-q2Bl-CdiOH-9_BYGArTBmQ-1; Tue, 24 Jun 2025 11:17:06 -0400
X-MC-Unique: q2Bl-CdiOH-9_BYGArTBmQ-1
X-Mimecast-MFC-AGG-ID: q2Bl-CdiOH-9_BYGArTBmQ_1750778225
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a579058758so2362889f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778225; x=1751383025;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VS7WT/Myda/TmCCBpV0MVboU7jS+MnjU+H4FMQ/YZGE=;
        b=pByTnpCsLotLussOWTnOR6nMkQ3sURxb+zID2WbonXu9ZsQBiWJHhhqBKHFhgB1v9w
         s4H7oC5b7Cx/Alza2NHYuIHFuTUn+TFuQ97PEY16kYzHvDMZgyN34r5u2efG2s2OMsWL
         MxLva6+KZBDBRzsFCBYPgdxxyhX+uE7LjOl+de2kWRZeVeaO8iiXNzmT1WImWV9+FvqW
         DBKt/eX+BkAs39ac+xFIYcS2uaEOQodx4XnBDgKYYfCDEr4BY+tZoC/dbn2x/ts1MMJy
         INpxkHUhjKrh/Q6ufC6dr4iGAiCCXMdQ6Zpp+/mgcr1Fz/muSoCtwPqWdjOnx2rKNLO2
         HVnA==
X-Forwarded-Encrypted: i=1; AJvYcCV7/jo3yorjI9+106wsX3UjqYPEynHn1SQHT5FbqeWMNNb45sMZD3Ujw6clpJElN/ZXOt6Iy9XbLNWxKCXwHec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb2oyFPMQTrzvpQ2Gb/TAppVIv8S4gWpF2qbuZ8jA2fNAFpaB
	ivXOUVkR4uNhmjvxuTz01HjcMwgqxOTSU2UB1ch8tFddHsIO9W7DfCrNSvV7XGF4NSIhIJw9gwe
	4n8ZmQ33+429lvjgxE2YNHWu5CgXdWVjyJkSI1Q7UWOEtcCadSZSvFC7OfLS1Yi+D9ujePA==
X-Gm-Gg: ASbGnctGcaMCazBcHaqQBjbLd/VwiJyb34cU8hyDOvz0Xdq5t7219S7XTI75N2SMevV
	Oann0sg02DCihoYBrWdKtcg9IaQCwbStP2Dffdwhx/09VnQjzUeGGVzBOXEN9zGt8zhpu4HLFC7
	az4/zaY4iBi5mScfIbObPCfAOJzTPvNy/b3yzBqmeud88gH4XYyAHTwshFr/HfrtXjmGtYH8Sbh
	8Wg84jEh+CwGLVpYi9nLJ2bf9s/KxbvvtL45xhUnYGzHTF4UHkVFB93j00ndGM05E2uaCWXm7J7
	3x0lP5SdGo80Nj/kD5zd2/BwopH7lEWKVyy0wzs8n5cnhcWtdyr7RIg=
X-Received: by 2002:a05:6000:658:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3a6d9673f9bmr9519384f8f.36.1750778224781;
        Tue, 24 Jun 2025 08:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSv/IC3WnCIKLIezWORbCvAwDH9oA+fiyrjemvNBVXt77tG6qvLLNil4gzlrJ9PXRneuaYQQ==
X-Received: by 2002:a05:6000:658:b0:3a6:d967:380c with SMTP id ffacd0b85a97d-3a6d9673f9bmr9519353f8f.36.1750778224422;
        Tue, 24 Jun 2025 08:17:04 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8050fd6sm2232351f8f.17.2025.06.24.08.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 08:17:03 -0700 (PDT)
Message-ID: <59788375-4010-48f9-b783-2d4c51c8d546@redhat.com>
Date: Tue, 24 Jun 2025 17:17:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
To: Peter Xu <peterx@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Li Wang <liwang@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
 <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
 <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
 <239f75e4-1868-4ac9-882f-664a8863b781@redhat.com>
 <495dc88a-c0b2-4090-a89c-00f000b62a2f@redhat.com> <aFq-SAFB3eWdwwwf@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFq-SAFB3eWdwwwf@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.25 17:03, Peter Xu wrote:
> On Tue, Jun 24, 2025 at 01:48:50PM +0200, David Hildenbrand wrote:
>> The man page was updated with
>>
>> commit db3d5cc1a17b0ace008ebe1eaf0ac4d96b4b519a
>> Author: Axel Rasmussen <axelrasmussen@google.com>
>> Date:   Tue Oct 3 12:45:44 2023 -0700
>>
>>      ioctl_userfaultfd.2: Correct and update UFFDIO_API ioctl error codes
>>      First, it is not correct that repeated UFFDIO_API calls result in
>>      EINVAL.  This is true *if both calls enable features*, but in the case
>>      where we're doing a two-step feature detection handshake, the kernel
>>      explicitly expects 2 calls (one with no features set).  So, correct this
>>      description.
>>      Then, some new error cases have been added to the kernel recently, and
>>      the man page wasn't updated to note these.  So, add in descriptions of
>>      these new error cases.
>>
>> @Axel, did you ignore the automatically-set UFFD_FEATURE_INITIALIZED and the
>> repeated calls never worked, or was there actually a time where repeated
>> UFFDIO_API calls would not result in EINVAL?
> 
> The man-pages was inaccurate before. It got updated recently after Kyle
> asking similar questions, see:

Ah, great, thanks!

-- 
Cheers,

David / dhildenb


