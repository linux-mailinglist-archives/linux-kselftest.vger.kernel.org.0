Return-Path: <linux-kselftest+bounces-33931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B7AC67AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445993A4880
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8D2139D8;
	Wed, 28 May 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgKji96V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD33398A
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429346; cv=none; b=qdVnLoFQp1eeH14vp52Gn5K56r+njn2+eKa7YajGKmfi9qzL8Od91n2Ff6kR/W+ZjGZZlV+j0p6zUHz7eqCrbOkXiU7H6OGJnZ8wxUPfYJCKCwGw2FNyA/GhOODnoTh86+BquYaZBwXpMGV4inIRjfiHSo4Y0bQss+U45TKB7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429346; c=relaxed/simple;
	bh=ohq0aKy46MqiNiDa5pDJ2hhxanBLxI6940+C/u71zSw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AnMp0i/k4S/VHStW7eSv0KNAMdkyLgykA1qS6OysZCFFKs2PUKEsLl9U4caqr4/sfJiHmls4XaOBfFhlXxlICmXtbOINyhz8HpPoL4d8jmNz6SvfapfHmd4dg/m0PvYhjitocxfehI1H72g7wPHHx2pG9NI9LZiP8l5bqTAyBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgKji96V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748429343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L9zdNnDwAfNYHub/SLO4R5U1ZnoXRuT66VkqLwVbfTw=;
	b=hgKji96VZdmfvDLLpIdIWs8ueDqTPq1ES5pQ/dyMnz3hGMF3lkxRpHPf7APSuWvk6aJow+
	aQE7bgOTDqkkDWQDIhRVXYDQIR5tnze/0HjwQ8E4KyGJOhcg31NjR0fosuwPRYnJc1ps2P
	TYKJcGCaM62k8Iahqs/OposwleYgsos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-LNCvA1p8N5eklivB9IDSBQ-1; Wed, 28 May 2025 06:49:02 -0400
X-MC-Unique: LNCvA1p8N5eklivB9IDSBQ-1
X-Mimecast-MFC-AGG-ID: LNCvA1p8N5eklivB9IDSBQ_1748429341
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso33086805e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 03:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748429341; x=1749034141;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9zdNnDwAfNYHub/SLO4R5U1ZnoXRuT66VkqLwVbfTw=;
        b=ritofb+ni1YJPb241j11x/j/uIlx13G1nU9E8/T04Yf0m5u9jZ0y52mdv8oC2chZQq
         llbDK9vTXFrYXzJs43W968i52QiYKN1Xq40tk0Mn6fyZXg/4+FvzcbRrvCMZqydMwWGl
         4OGfwx+PoYvXbJ0vzF6Q+rYGskhE2uAq8Sxv3doFrM1GHBa/ckJVBuXW56e0TcmcSpt3
         YaWOMvPrsn1M01bTqeaf2btkfTlfk7YvqUY3VqPmCZjuLTIevdelX7kUDEsZigaBXEOw
         +/3SitU2GNs/4d7KEKO6L+Sap106aFEIoaz0Q5ojQg1ezUoVmdxzasEBQqx4aYIsZ9np
         UVCw==
X-Forwarded-Encrypted: i=1; AJvYcCWd4aGhdgN0oqhAY+HGuXutb9FLm+6siL6WRqJu++6jitoceWwA4HHxQEgf8cKkhbGZD8AGa2hV6VDYJBAlHVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkv9OZ+FqV04VW2PS/Vjx1OK18UMM3cDL6NuBSJ8aw96yRdDP
	FjdfR72OOyE7MaZPvTGVnlDoMXKgusgluHZNxYoRQhk+1sUcKGZajP8+M8HcYBhNRyeNqZiN9bP
	CdkI/saoNHS1VDJ0LR07/WByxcnK5/wuXJuPempnE1WrPVdij/uc1dNDBwKmjMPfi0pR+Lg==
X-Gm-Gg: ASbGncs6ThuRURv/guMC27ugB235QI+dAqkctpgVfgW60o/Fa22cXCGy/I8XUtWZZKa
	bUj7XrH1NN/Zh1Kq2aqdpXNjI/1/+HxrUMXxc+yuNt8hu6jCdcOspF2Hs3ENywYgvxY8TgRjyLq
	PlgFEfxOj2d5utJEtD7PgUPBDQxkdmCNkJTv8ze2l4D2brUvxhwgHNUQ1AL8RtTd1RRjAgRzNQ3
	OKRWHDTLl3O6lg9Jlqsue4Q6Egskle+gJHqoRp2XQEnZ4m3owQhLC7qTbSBvjysR1wRDGkRk7ur
	5NG6lXEng18ecI41rECZ3uMVRalIVIdx8uuLLJlG+FMU19FjSHIWawcgF4f0Ond7nV7nEUGNDx6
	kYzzU31CfQowp0dgpbxqX6PTA8hTrk7ubP0k8Jas=
X-Received: by 2002:a05:600c:648a:b0:43e:a7c9:8d2b with SMTP id 5b1f17b1804b1-44c92f21e1fmr127213115e9.24.1748429340969;
        Wed, 28 May 2025 03:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhLT5tb7zUh11ADM14vMwzRiC9TD0IByrsLMVhGQOhNMyEK6r+6gLgjV47NeCbATlZyERZlA==
X-Received: by 2002:a05:600c:648a:b0:43e:a7c9:8d2b with SMTP id 5b1f17b1804b1-44c92f21e1fmr127212825e9.24.1748429340531;
        Wed, 28 May 2025 03:49:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450725403c6sm14119995e9.3.2025.05.28.03.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 03:49:00 -0700 (PDT)
Message-ID: <3c15a093-7c19-4c2a-a571-56a5ed4b445f@redhat.com>
Date: Wed, 28 May 2025 12:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Xu <peterx@redhat.com>, Dev Jain
 <dev.jain@arm.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20250509153033.952746-1-david@redhat.com>
 <232960c2-81db-47ca-a337-38c4bce5f997@arm.com>
 <7cb7f23a-ce9e-4664-8083-deb73ed23da3@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7cb7f23a-ce9e-4664-8083-deb73ed23da3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 12:44, David Hildenbrand wrote:
> On 28.05.25 12:34, Ryan Roberts wrote:
>> Hi David,
>>
>>
>> On 09/05/2025 16:30, David Hildenbrand wrote:
>>> Let's test some basic functionality using /dev/mem. These tests will
>>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>>
>>> These tests will only run when /dev/mem access to the first two pages
>>> in physical address space is possible and allowed; otherwise, the tests
>>> are skipped.
>>
>> We are seeing really horrible RAS errors with this test when run on arm64 tx2
>> machine. Based solely on reviewing the code, I think the problem is that tx2
>> doesn't have anything at phys address 0, so test_read_access() is trying to put
>> trasactions out to a bad address on the bus.
>>
>> tx2 /proc/iomem:
>>
>> $ sudo cat /proc/iomem
>> 30000000-37ffffff : PCI ECAM
>> 38000000-3fffffff : PCI ECAM
>> 40000000-5fffffff : PCI Bus 0000:00
>> ...
>>
>> Whereas my x86 box has some reserved memory:
>>
>> $ sudo cat /proc/iomem
>> 00000000-00000fff : Reserved
>> 00001000-0003dfff : System RAM
>> ...
>>
> 
> A quick fix would be to make this test specific to x86 (the only one I
> tested on). We should always have the lower two pages IIRC (BIOS stuff etc).
> 
>> I think perhaps the only safe way to handle this is to parse /proc/iomem for a
>> region of "System RAM" that is at least 2 pages then use that for your read
>> tests. This would also solve the hypothetical issue of reading something that
>> has read size effects.
> 
> That sounds also plausible yes. I somehow remembered that mmap() would
> fail if "there is nothing".

Ah, my memory comes back, we perform checks only with CONFIG_STRICT_DEVMEM.

-- 
Cheers,

David / dhildenb


