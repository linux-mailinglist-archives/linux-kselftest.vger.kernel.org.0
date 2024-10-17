Return-Path: <linux-kselftest+bounces-19964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB09A25AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BEC1C20C6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380111DE8A8;
	Thu, 17 Oct 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLzL2fcc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F31DE8A4
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176999; cv=none; b=CwPk6bpXR3DkI0hrE9U2GzkuMIFrw+QiVCZoQRnuJKBcFr9v0UUxWDokPN/rdD5ExqDVyk+sl3OHg2pgMwU/h4BKLK2Ygw5LUTVMiQBvaitHuNFutW+g/iuqZsO3Sx2c1HkaNJGvSVAgGWvWuvJZh++qvVKFQhn1fp4JlFbwxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176999; c=relaxed/simple;
	bh=ahaN8/bn/1F79tSZ8q5oj15hHgim7szJYjJbuWXiP9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwwnRdk8sm+N1Ggp5c4o3xHxHdb6EuNQ0QNV73R2Mo45yGdDYvZaNyLPtleQMvkvWZjz0uWcOu0CmM3PycGfLG3foi47A2xxAhFHW4yN/ICUOTFZo6ZU1pv7bLdB0VEZB62qmGoUiTFaEo0g0eoVv6Pav6FmvEEup0fONYE4kjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLzL2fcc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729176996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lkrny24ugYkx/dzeS4nu76fI2FwDJlgQ1Q4zPnIoh/E=;
	b=iLzL2fcc5XwatXkVIKesn3GckpM+wAemEXqcfyTZbtd+8HMe1ZodtfLv0GsKEi+mf3WFsT
	GtMhSRp9GVhISA5Djl/i7rJQ6gEwDm8QPaDpL9UEcvSalSRfj+1Et5WvdBOLndEfMHEPbi
	1jEmqFgHtx5kmVyKiMn26H+hGmCbA34=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-P0Wj0ofFPM2TCSsG3lX6pg-1; Thu, 17 Oct 2024 10:56:35 -0400
X-MC-Unique: P0Wj0ofFPM2TCSsG3lX6pg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so547968f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 07:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176994; x=1729781794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lkrny24ugYkx/dzeS4nu76fI2FwDJlgQ1Q4zPnIoh/E=;
        b=sxYl+NomQ5pQJEY9J3ypxgNzVd6H9FGMzQBOMzFTunrMSpJT5aVvSkW/XnE7rqILxc
         TqCFxVGua9OxN7q0W6A1H0DzptHQdKTVIHhlfhufGW7OtK40dxLKYvWoIOddWhcVOh+w
         H26nhTToT7yeRnhGeXulh2ijvKjCh6GLfbthV5bsp42xIAI87BbdHiiKV2Cz1V2clgYr
         S0DUbHHcoWWpWN4iJFOBdzMHAsHOQjlW9ck9V4i2RzCEySrgvzE8LVShDClMU90+OHuz
         f2YQL3wLrh4BaFIMNY3j4puDUG7ecKvHt0gCw8bg8lAMcmtObwrE18qZnJwb4uS0RPQL
         fn1A==
X-Forwarded-Encrypted: i=1; AJvYcCVRft4itLeMnrgRYpvRSsRw8unajPpCe4rZtAM8U5VCyx2No2JYHTpjGQ8/wVhsT1IFNXrHjcU1cd4gpFQ/srM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItZLjsSr7R8Bk7qD4nDkjMN4nj7Jk/3phZLbVpGRhVyxhHkKA
	XKseU9x/YW0OjuHAk387k7RwJ7nUBONu00fN3Zf5n2KYUsqXixAKdZsBitwqKefI3hM8ipQnGpX
	U7nxQKXTSAa8e1M0G/iM9sHekLRYCnhzx4d/3wwH0CwVLJkQThWYmSKwiM41/WZ+uMQ==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr14757516f8f.26.1729176994189;
        Thu, 17 Oct 2024 07:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyVCqXnlZdEr4Aqw5wezq88XLLTgNCm3TbjQGwcJzfHdNW5KvChf5Wlg2cdODPFlHtUexjTQ==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr14757426f8f.26.1729176992283;
        Thu, 17 Oct 2024 07:56:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf82b1sm7554576f8f.72.2024.10.17.07.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:56:31 -0700 (PDT)
Message-ID: <98eacabd-3465-4f5d-b045-8e8595d68676@redhat.com>
Date: Thu, 17 Oct 2024 16:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
 quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
 fvdl@google.com, jthoughton@google.com, seanjc@google.com,
 pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
 jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
 erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
 jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
 brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
 pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
 anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
 vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com> <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com> <ZxBRC-v9w7xS0xgk@x1n>
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
In-Reply-To: <ZxBRC-v9w7xS0xgk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.24 01:49, Peter Xu wrote:
> On Wed, Oct 16, 2024 at 07:51:57PM -0300, Jason Gunthorpe wrote:
>> On Wed, Oct 16, 2024 at 04:16:17PM -0400, Peter Xu wrote:
>>>
>>> Is there chance that when !CoCo will be supported, then external modules
>>> (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?
>>>
>>> To support CoCo, I understand gmem+offset is required all over the places.
>>> However in a non-CoCo context, I wonder whether the other modules are
>>> required to stick with gmem+offset, or they can reuse the old VA ways,
>>> because how it works can fundamentally be the same as before, except that
>>> the folios now will be managed by gmemfd.
>>
>> My intention with iommufd was to see fd + offest as the "new" way
>> to refer to all guest memory and discourage people from using VMA
>> handles.
> 
> Does it mean anonymous memory guests will not be supported at all for
> iommufd?
> 
> Indeed it's very rare now, lose quite some flexibility (v.s. fd based), and
> I can't think of a lot besides some default configs or KSM users (which I
> would expect rare), but still I wonder there're other use cases that people
> would still need to stick with anon, hence fd isn't around.

Not sure I completely understand the question, but for most VMs out 
there I expect an anonymous memory to remain the default memory backing.

Regarding users of iommufd, I have absolutely no clue :)

-- 
Cheers,

David / dhildenb


