Return-Path: <linux-kselftest+bounces-33933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD27AC6807
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 13:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14EE1BC6EDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050F5A79B;
	Wed, 28 May 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEUp9MPV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AD2459D8
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430240; cv=none; b=CjcfYHCXCFLd5chNgWvlCYjT7agxR+TA36CCle7zG6sBxF7efh/1MOAcOYDf8UpmJI9RJt3kxEf4VZsvxre8je2Cqv+4goYYRbqQaYFuIjHdcococQjHLE1JtLhk0oL5du5SPDjhx1L+bsBCvxPbOkRk1C0IUl+lCLByBZdDLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430240; c=relaxed/simple;
	bh=6rr2H6AzTQTO5djKkQwYMGvfwMBV90Oi086vuBp87VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2jPWGGdi55P7EDzPKACEAqlFByGY4YqhjiSkxZuecr1tt8I9kUsLap7agmTjzgGpttTyAiP1bA8QvPW2MeNnc1GtWe5cjPst7ZHHdPemFxIFDPvCeLI8GDOyGuE0OH1j/7Ja/vWTlgFGmQEm6Z8fXETvJeD8OvQU0NQnL1xipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEUp9MPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748430237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUmqPZP/ey41I54C3VrrZw/viH8NhQ/UPLK7npoUAdQ=;
	b=VEUp9MPVvOODjr0cJF6DVAgnhO0ceoEOFMUmilmlJTd2v2Ij8z1DPdOiIpxscnDrUOH+Vu
	p7j1R9WFgsHniJ8A1d6QxsyqPwVJ9ih/6+8tDZp/R4RZJmZk4qxpTBbS+4yOwcgjXEHAQb
	vkLm+TES2gT3gE5jTZChOt90qfCluyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-SzF1rsL_MAOpNV3TNzsUTA-1; Wed, 28 May 2025 07:03:56 -0400
X-MC-Unique: SzF1rsL_MAOpNV3TNzsUTA-1
X-Mimecast-MFC-AGG-ID: SzF1rsL_MAOpNV3TNzsUTA_1748430235
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so27634325e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 04:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748430235; x=1749035035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XUmqPZP/ey41I54C3VrrZw/viH8NhQ/UPLK7npoUAdQ=;
        b=PC2ryPe9n2SHqys75zRZ2Yu9/NoQ2F2+gezN6rDuuiF2aoYgjxMAiwyciy1dZULrB5
         m17gIkKvI4daAJCqiSMTdczKQR1+3QyxLV1LgbRVA9Yp9R2bxw21CU/RFuKHZlMCRycz
         yOWcXDI7IfIpcKnepYKL1Mq+m3jgQ9nzEYipgK0J7onKezNd2xqkwlprpZlDJ0UI1ycl
         RAzu+uuO3fbQb4j8rCpFswmhuM/yfrnLnLu1WyLHm1t74SWBBNCJB7TJRzUc08SK3PSl
         iDcTNgstcNOqs8zhzzWdKELjRUlF29Re73IrZBvqPW6S2JSked3qWi9EaCSfsxJ/Q5Bb
         m1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWgkYm257QUkFV7zZs8uNO9skZS4KfoStFf4znBtkSUPH1l/69X8WJr3z5bjJwagY80IYtwWwp7eMkUSjpMJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBi8DMSRyRtrRnKSE28AfPG7usv4ZoleoqbWqyYbbW6FLLuV3
	EQL6NzVeYG0WsZsbm3Pnc5dtEMXwWP1e7BawzzxwSx1qfuCVbcLDD6k/auLKsHMIcRQ0+KtN9Va
	M4Twe+8cDrCgknZpQGe0cusi0K7o08TaPOE6lGHIi09iYEfx5uP1yraWA4uX7kibREhETvlyulC
	pgICNQ
X-Gm-Gg: ASbGncuLaeWs+z7BaQ720birqBqOj3g9TvmyMDH0Jt0QukZi9P87n3I48A8EuTm0Dg5
	rlmbptmWcoq7qLLtJ1F6WCTX38r5I9nP3ukDEDY8WkIzsvSLOUG4iSqzf7Krmt6HJp25bGQ6nhx
	UXN00JMJ7HZJFUTC5JR6QTI0tw0z6A8rUEN3bKBM99pQ/rfnjVARwyUL/AUEOpIi9sfbN5N+ETa
	sayCbdlZmasnM+JOV+4VAFL2s8C63QBoswC2k63yHWQMOKefMER/Vg1KaCYOFu+blHw6hva2nOJ
	vo9KeNXV4qM5+mhjbb69SqB+1CFtHVCnOJkjrM59Sv4IUNv8Nhv7UzDdqUqI8PX7/uExkX+J3N4
	nJJwfJM6oaBLnKLUf8WdjEB6aeUl0e3gCXAa4qKU=
X-Received: by 2002:a05:600c:8283:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-44c94c2a4c6mr152075815e9.30.1748430235207;
        Wed, 28 May 2025 04:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvB4aiJDW65BI5a6zIT3DqbPJQlHU1DBllsmOfsWcS0yLV/1OUCDbL+TV1jsIMb/aPOJARjA==
X-Received: by 2002:a05:600c:8283:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-44c94c2a4c6mr152075445e9.30.1748430234770;
        Wed, 28 May 2025 04:03:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44ffc0eb7afsm18341125e9.0.2025.05.28.04.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 04:03:54 -0700 (PDT)
Message-ID: <1916ff1c-93e7-442a-b1be-e0e35190a6ba@redhat.com>
Date: Wed, 28 May 2025 13:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>, Dev Jain
 <dev.jain@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20250509153033.952746-1-david@redhat.com>
 <232960c2-81db-47ca-a337-38c4bce5f997@arm.com>
 <7cb7f23a-ce9e-4664-8083-deb73ed23da3@redhat.com>
 <3c15a093-7c19-4c2a-a571-56a5ed4b445f@redhat.com>
 <ee8db861-3632-48a1-977d-b05670d9637a@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ee8db861-3632-48a1-977d-b05670d9637a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 12:53, Ryan Roberts wrote:
> On 28/05/2025 11:48, David Hildenbrand wrote:
>> On 28.05.25 12:44, David Hildenbrand wrote:
>>> On 28.05.25 12:34, Ryan Roberts wrote:
>>>> Hi David,
>>>>
>>>>
>>>> On 09/05/2025 16:30, David Hildenbrand wrote:
>>>>> Let's test some basic functionality using /dev/mem. These tests will
>>>>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>>>>
>>>>> These tests will only run when /dev/mem access to the first two pages
>>>>> in physical address space is possible and allowed; otherwise, the tests
>>>>> are skipped.
>>>>
>>>> We are seeing really horrible RAS errors with this test when run on arm64 tx2
>>>> machine. Based solely on reviewing the code, I think the problem is that tx2
>>>> doesn't have anything at phys address 0, so test_read_access() is trying to put
>>>> trasactions out to a bad address on the bus.
>>>>
>>>> tx2 /proc/iomem:
>>>>
>>>> $ sudo cat /proc/iomem
>>>> 30000000-37ffffff : PCI ECAM
>>>> 38000000-3fffffff : PCI ECAM
>>>> 40000000-5fffffff : PCI Bus 0000:00
>>>> ...
>>>>
>>>> Whereas my x86 box has some reserved memory:
>>>>
>>>> $ sudo cat /proc/iomem
>>>> 00000000-00000fff : Reserved
>>>> 00001000-0003dfff : System RAM
>>>> ...
>>>>
>>>
>>> A quick fix would be to make this test specific to x86 (the only one I
>>> tested on). We should always have the lower two pages IIRC (BIOS stuff etc).
> 
> I'm not sure how far along this patch is? I'm guessing mm-stable? Perhaps you
> can do the quick fix, then I'd be happy to make this more robust for arm64 later?

Already hacking on the parsing :)

-- 
Cheers,

David / dhildenb


