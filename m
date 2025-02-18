Return-Path: <linux-kselftest+bounces-26885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2CA3A45D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A234B167D22
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049226F47D;
	Tue, 18 Feb 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzDmiwHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C226B2D2
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899920; cv=none; b=Zsds8wbwI4y9v8z5rGNn05etS3gvAc+vLcnu3UIAnd/TA956fqTJk/XOWHDF+2EAMHyi9w8bg0/ISaNGlNo2JLGNJNyLP6SVV878T+Zbss51GnMX96L9WoFX8188lutQp8ZhYcbAIdLFWuoT3jBTEKmUmSGMv3wiw1rG11KzMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899920; c=relaxed/simple;
	bh=V94V+hX4hqsirUQz7oeUw3wf0C69qxMeM9OnPIoCnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzoRBhcE6oTjrw0g5FdbOR60O0jgFSbxfU1HREWKO8iUpz/8ruDFTVDxiJoe4RibtCHJOEdWA9q3YGVJ9eD4f1bYBipao8oQRYmRPJgQbsvSONjsxrVFvCXagTOydmGBVhB7qvWNkWLC66h7PRm5xDZHS3lY86jr95sFFvHqbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzDmiwHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739899918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k9xHqsqZZZLVC2Xvqig7d9EyE1//QtkdJtmVvzdVGVU=;
	b=ZzDmiwHqbopjSqUNwVLI+1UoDtq4Qw/cvp2lYhfs1ZjZA0bSJTMTb4gvjWbc2XmbUZEVsN
	HE6zs/J7F7k8ZKd+ypiMHsN4kIxyEMJdaMJtz/J4kECScppwCAmakmC0nWLmWR2FxykwaR
	xLjuO1xRTfBkPFFeQ/aTYPjOmtzCA6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-tN2OojGlNw-lgiiYr-WfkQ-1; Tue, 18 Feb 2025 12:31:56 -0500
X-MC-Unique: tN2OojGlNw-lgiiYr-WfkQ-1
X-Mimecast-MFC-AGG-ID: tN2OojGlNw-lgiiYr-WfkQ_1739899916
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935bcec74so30198705e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 09:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899915; x=1740504715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9xHqsqZZZLVC2Xvqig7d9EyE1//QtkdJtmVvzdVGVU=;
        b=ehCk+umE63/gbeaSPlpjk4wm+Qg26InVRifxcfo7R2iWxcQtYQFwBX04VPTAjTWtjj
         bbcOlTNlk4UabGwhP69OadT8QQAAKE/+vGRn+bVLHsaHQVTu2HEiJc1sDs8IMIEPNQX+
         gNnHRG9LJ7BLxY28I8CgurH8unNjfbC7cq3d9Yz4ZX+aj7/GYm3Jbban4P6gBjG/95S5
         vh/77mdqTxPUtWL+j2ZQeOAvCA9UeBaVpDEyONmmAZuOEUFX4px37c/xwZIJ+2jZ6W4p
         DyjMWn6x7LWfV2IKJOR/q1cSbXRL5/yMup+Mw05YQ2IzrEUNbWyPFvPRyyKukW4b2w/I
         uWlA==
X-Forwarded-Encrypted: i=1; AJvYcCXl20eKCODXWsDiSQvr95Jm8S7UaQ7P1OJpJVIktnmCs4VJ2qb7VyEvUsGcudPlRyOXgFch1zvdCyKCPlWIKUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/v29wGHgSv1VrotaHfGwMC0sqmA0Gm/gQ9LToed2IEpicoUEp
	1LoL/p65CkDPHBDwVuwbR53iUDjhfb+oAuHmZsuDBDd2tyDoqPMIZfS48PykfdUZDm69r78rtFn
	cLuHRxNJU17dbU5wWv4cz1F+IXcsUJaU4jLz/oAQ0yHwBb7PygBZbWJb14HIKkts1vw==
X-Gm-Gg: ASbGncv4Kddzj6+bKFiF2GsZVWTIcwIFocDuClz83rR5HPleZL4fDPSO2EZXFdJRmX5
	avHNQHC/bIQyTjK1dhx0tNVEcniberWhje94UohxZGO3Mj6yhaliQEX8NhJSTLHcMus6m2KIgIL
	kr3/fu63Rkwa1egUbHhG3ocyHnFF5gCM3lqicrZM/3R/CDvSVU9V3OzeVzDKgOb/CE07/pVPYuj
	uaLtRj9KLAZpa8LL3xdgEE3bMtvJoQknnvjnlcppKV3jdRNumPj/Oto18fTGEKBrG5j8gIEdjFA
	k98OdHAHZ+sUVs80XEKZd2fw/5ZwpW/Pog0Bnx7uowK0af5Fjp+mrcWT5H8U7Lutgw5Be7T0GW0
	Vm0cediKAqIPcyAoCuJGDvABC1tfIxBB4
X-Received: by 2002:a05:600c:4688:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-4398ec2acb9mr61264785e9.31.1739899915543;
        Tue, 18 Feb 2025 09:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+4sIZ8F6YkIlbm3nUsGkjLl9lg6scQnHsjrcRbzy1cF83VaTT+hS4NLhKSLXXrGzpOjl0oA==
X-Received: by 2002:a05:600c:4688:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-4398ec2acb9mr61264435e9.31.1739899915210;
        Tue, 18 Feb 2025 09:31:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7df2sm15572642f8f.84.2025.02.18.09.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:31:54 -0800 (PST)
Message-ID: <ac7d3b7c-7b36-47d2-be59-c1b6e0fa2d38@redhat.com>
Date: Tue, 18 Feb 2025 18:31:52 +0100
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
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
 <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
 <62c0ba1c-7724-4033-b1de-d62a59751ca5@lucifer.local>
 <a49d277e-128c-4853-bdeb-3a94134acbf6@redhat.com>
 <6eb33b5d-3040-4637-b627-48f8f78e4e28@lucifer.local>
 <b30a6306-d62b-4515-add8-4550d044501c@redhat.com>
 <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
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
In-Reply-To: <c0e079bd-a840-4240-93ae-0ee2755d425a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> See mlock2();
>>
>> SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
>> {
>> 	vm_flags_t vm_flags = VM_LOCKED;
>>
>> 	if (flags & ~MLOCK_ONFAULT)
>> 		return -EINVAL;
>>
>> 	if (flags & MLOCK_ONFAULT)
>> 		vm_flags |= VM_LOCKONFAULT;
>>
>> 	return do_mlock(start, len, vm_flags);
>> }
>>
>>
>> VM_LOCKONFAULT always as VM_LOCKED set as well.
> 
> OK cool, that makes sense.
> 
> As with much kernel stuff, I knew this in the past. Then I forgot. Then I knew
> again, then... :P if only somebody would write it down in a book...

And if there would be such a book in the makings, I would consider 
hurrying up and preordering it ;)

-- 
Cheers,

David / dhildenb


