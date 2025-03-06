Return-Path: <linux-kselftest+bounces-28383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E866A5461C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87AE170ECF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D47208988;
	Thu,  6 Mar 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBhL/fJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD97208979
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252791; cv=none; b=rNpVqgrq5K+ht/gEoAz5auHdhmzLP9FBpVad6eEn6JqVnmabJfeKSwZ4ECa8zjbEbNWXIP6qViFidWQI5Cxo+hELxqxKqCB1YsrPm4ktr1AtDUXU294LvBy2zfOxQ80VyFqjcAqmmMM26SQUnqzv49FlPtRXTQS9Dap94Y2X1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252791; c=relaxed/simple;
	bh=mf58Myv1K0m3ZaI7IqcyVzcArb/fIOAqAO4NCBEARQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2/ZJivRVdrYVD32AxIpMZd4V/4RkDCtA7hHrhQN2ZOWLt+cD1f2fTWPGQ9+rnqCk5d0E1oV73L9xpWrqMJVbzs46azZHdUuqS/s30w4Np9dZTNE8GE0c+lsADt0PT+ZgVd/mGPQHyMupf47Etl04ltL7og4Tw4Oc01+XTE3/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBhL/fJ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741252788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j4u9DLEhIx3HFuqYUpbNqKrefyTEPoTUC28xU5Dyl5E=;
	b=QBhL/fJ13eWOszQv/fgRjMvnfkpVc5pjo27tZ4jxMsFyBl5E9DD1IkSoQulh1DqbdrzUrG
	lZJCjE9j8D0AueKGRHJJiA/g1YzZWbkxzfJqRD7+Qb4MNPE21iMl4v3YiYE7txxmGPWcr3
	spseNNKFGObFu5D3DGBfd1iWXMx9lEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Vkfaylq0NaOGrRI1Ooud0Q-1; Thu, 06 Mar 2025 04:19:47 -0500
X-MC-Unique: Vkfaylq0NaOGrRI1Ooud0Q-1
X-Mimecast-MFC-AGG-ID: Vkfaylq0NaOGrRI1Ooud0Q_1741252786
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912a0439afso164613f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 01:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252786; x=1741857586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4u9DLEhIx3HFuqYUpbNqKrefyTEPoTUC28xU5Dyl5E=;
        b=Iw3gGhuZyB6Kcg3G1P64Sk9skJHOwtvzjru2tEfUqz6K9Zw2vjewTmcZHYBWWLkic6
         liNjm+0zZQP0UNiU9qpuEoCzYQLsmhti/lwVS4mSs43L9PotOOkUbgyRjJFigyjdizPL
         k9DHAK5USkTjiBkrnKM6Onp9/KsNZLg8IkKTsINpU5zMCzy79jn+c3PNTkdsRh3nNnKZ
         S4LAJB9zKcqnAUdWDbR7L3yHADq0K6JX0GIKp1bqrPyXhXNIsK80CXFaYcHdLkv9m5bd
         5dfYwQI2gkVoZDKm3Bt7Aie+wUuZzBkMPpVbGJKFFP53nzoWIOZpVlE1411p8fdd4Jnl
         oKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPXxtghLhv/rlhZ3Xp3Y1kqwiLe+4dxk9fjn1jaqwfLZNNt71ouQYKnGYGSWGwjA7572WrWCB5TNIu2ydahL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQ62fOom8ZNvCyHQ+WWqWQDa8yywWWgfsginqS7pJgBIPgkZH
	36YKx2kV83ra1l4IWLcQlOEbTzNCwJKKNzKCJKkZEHyOwuJyJkCNc6jXZTEaYT5q25rFva+pOaf
	iPeCJatvFfrhS3SS3Tp3hhdob91vU0lwEOaeqRN8Yvj6KclnqZA6gBjRXmOXS3EhGuQ==
X-Gm-Gg: ASbGncsbkcQKAGA0ZSCvdMBNE3WMYBM1eLuJsTNtZpjoYGq28Z0eKsploCuSMyFD11k
	Nmqw9ToLRqcANfOzlfP40lKbq+mixv8UXj/9RQL+IgfOuU50tYHnqTcX6Z/HRgN9Wy7wCOi8MuG
	Fgl1bLlDl6FZ78+tm94oP/YT4YD8NyCgr+xcJPQxSQ9dABLZD8zolm7YKt5Q8pXRVZoEH3OIFdz
	gvQxWEi6owvlIgSxdD2Y8lPji3oOJNRPhOuYfwcSLRrGkcUWgXkPqBJqNaeirHsAWQbn3KV94so
	dNxCuHrv9wRnSDI/g5zkYKDNOgRkn4L0u538kgFo+K5LPzoq40ZWYnbYibgopWhlK4tZHpJPfhQ
	56n3lKnJy1xZ+xtg+OBy+fMsrae8cKs3psk3+IB6Jvh8=
X-Received: by 2002:a5d:64ae:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3911f72ff44mr5895161f8f.2.1741252786104;
        Thu, 06 Mar 2025 01:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgHNDlyxd7gScP5sRIupjVHZHV0IbVTS8wDNRrqJlrNF8ED9HuMeKDsApwMXgdi6IQFHmMpw==
X-Received: by 2002:a5d:64ae:0:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3911f72ff44mr5895129f8f.2.1741252785657;
        Thu, 06 Mar 2025 01:19:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm1425864f8f.33.2025.03.06.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:19:45 -0800 (PST)
Message-ID: <4a9f102a-60db-475a-a933-975edb2fb1dd@redhat.com>
Date: Thu, 6 Mar 2025 10:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
To: Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <FB1376C8-E0AD-40CE-BDE8-AF9269EA68CC@nvidia.com>
 <238c28cb-ce1c-40f5-ec9e-82c5312f0947@google.com>
 <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <43642DB0-17E5-4B3E-9095-665806FE38C5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 22:08, Zi Yan wrote:
> On 5 Mar 2025, at 15:50, Hugh Dickins wrote:
> 
>> On Wed, 5 Mar 2025, Zi Yan wrote:
>>> On 4 Mar 2025, at 6:49, Hugh Dickins wrote:
>>>>
>>>> I think (might be wrong, I'm in a rush) my mods are all to this
>>>> "add two new (not yet used) functions for folio_split()" patch:
>>>> please merge them in if you agree.
>>>>
>>>> 1. From source inspection, it looks like a folio_set_order() was missed.
>>>
>>> Actually no. folio_set_order(folio, new_order) is called multiple times
>>> in the for loop above. It is duplicated but not missing.
>>
>> I was about to disagree with you, when at last I saw that, yes,
>> it is doing that on "folio" at the time of setting up "new_folio".
>>
>> That is confusing: in all other respects, that loop is reading folio
>> to set up new_folio.  Do you have a reason for doing it there?
> 
> No. I agree your fix is better. Just point out folio_set_order() should
> not trigger a bug.
> 
>>
>> The transient "nested folio" situation is anomalous either way.
>> I'd certainly prefer it to be done at the point where you
>> ClearPageCompound when !new_order; but if you think there's an issue
>> with racing isolate_migratepages_block() or something like that, which
>> your current placement handles better, then please add a line of comment
>> both where you do it and where I expected to find it - thanks.
> 
> Sure. I will use your patch unless I find some racing issue.
> 
>>
>> (Historically, there was quite a lot of difficulty in getting the order
>> of events in __split_huge_page_tail() to be safe: I wonder whether we
>> shall see a crop of new weird bugs from these changes. I note that your
>> loops advance forwards, whereas the old ones went backwards: but I don't
>> have anything to say you're wrong.  I think it's mainly a matter of how
>> the first tail or two gets handled: which might be why you want to
>> folio_set_order(folio, new_order) at the earliest opportunity.)
> 
> I am worried about that too. In addition, in __split_huge_page_tail(),
> page refcount is restored right after new tail folio split is done,
> whereas I needed to delay them until all new after-split folios
> are done, since non-uniform split is iterative and only the after-split
> folios NOT containing the split_at page will be released. These
> folios are locked and frozen after __split_folio_to_order() like
> the original folio. Maybe because there are more such locked frozen
> folios than before?

What's the general concern here?

A frozen folio cannot be referenced and consequently not trusted. For 
example, if we want to speculatively lookup a folio in the pagecache and 
find it to be frozen, we'll have to spin (retry) until we find a folio 
that is unfrozen.

While a folio has a refcount of 0, there are no guarantees. It could 
change its size, it could be freed + reallocated (changed mapping etc) ...

So whoever wants to grab a speculative reference -- using 
folio_try_get() -- must re-verify folio properties after grabbing the 
speculative reference succeeded. Including whether it is small/large, 
number of pages, mapping, ...

The important part is to unfreeze a folio only once it was fully 
prepared (e.g., order set, compound pages links to head set up etc).

I am not sure if the sequence in which you process folios during a split 
matters here when doing a split: only that, whatever new folio  is 
unfrozen, is properly initialized.

-- 
Cheers,

David / dhildenb


