Return-Path: <linux-kselftest+bounces-26868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BECA3A240
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44853A1CDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380126E63D;
	Tue, 18 Feb 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr/ywwtv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853B26E171
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895156; cv=none; b=oH/oOcYGDbLqnUNWJ0TGwdnyUel6GYiFjRfBuieyywsLIzkCfC2bs6HH7RgPS+IPLTztnNi6ShBiJWxJgJZP6Rlnxk9fIxtgeYWca6OZkX3hZeqXFwNDY9CJ4xYoMKiNRlntUJqUBb6iBfHqCUViRA2BzVa6zr8QjYA9fQmIOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895156; c=relaxed/simple;
	bh=bhgPQFSELaI350GW+yyUY2g30cWw1ue+kK9U/gBGJ+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwqpQ8PCLbZKTD0kw7GccWGS9PTvOu/cGnS15p1v9bZJ8HE6A0L+jUA36JuXg7vLbkhHC/7fZl2ZjigjptFAJVnBbA/pTifv+VFNwGeu9Czbz7xuxnjxvaM51G2YZjjacHCyZ8tRThFFzWCRyjcNZppU8xk/M4syPHj7ikfgIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hr/ywwtv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739895153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qPrl3VBWVHIaEvfm5FHekwOGQkEzqzqF8ZKou2UTYEw=;
	b=hr/ywwtv5e4EfBC3b1q/45VtXDwFd8n3TaNQQ4E2pQfO/WNx/c4ov4ZbId2VZAimjq/XnG
	vkNVh+Iqgz+HgN5KKCF3NMwSNtxDA5PpbOhEubfJG0arRVUWOP/5GI3/S5C/zaPcFooRgX
	PMtl2dzjW4y4GhgJz3nOLXLw9y6GPGE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-cHHCsmNOMpmvp3PrH4m7GQ-1; Tue, 18 Feb 2025 11:12:32 -0500
X-MC-Unique: cHHCsmNOMpmvp3PrH4m7GQ-1
X-Mimecast-MFC-AGG-ID: cHHCsmNOMpmvp3PrH4m7GQ_1739895151
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so47558305e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895151; x=1740499951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPrl3VBWVHIaEvfm5FHekwOGQkEzqzqF8ZKou2UTYEw=;
        b=hLagPHvDlCbUowF32N8DI30F0BI95Bp9pOwKFmFFIyNxW5tZTj2it1cgabPWpcRN8Y
         WRmYsixuH5gwYe3JXMaEM+DNzZm7cu9LC78n0PrAQxPUu9+bgDms8qtwGJwUaoWgLOIo
         daqmQk9/pg5TNfFZUiMG4iOh5eWM4OgvqZo66qv/2a3r4dc+H6FKsjPjsVUPG7cOMGjw
         D8AHOHSTJj01vAxWpVsVJOOVlZzKWKF/lfPGDBmdQ4yZNGwQMOrer4gpo+6Q/GoS9EH7
         FNCB5fnoPvlh16Dv3Hkffw59JLJ2EQFFGx7FTsDn3RlaRxUFlDTQfz3HWj8sL23sYwPQ
         vlCw==
X-Forwarded-Encrypted: i=1; AJvYcCWqrP/THBzO3d7Op5Jp+YJDjjFK/x9RB31kjqHoownGkZPO403Lsf4YdnM0VwLv70QGcHFFmuothHSOA4OMPjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhXwaX0hd62CRSrJSvnhvdeElngxmv6tpYPK7WGT8jL2mFE1z
	tESoaFyqwspi0596kLRf8W8Cc0pwLMb+7tMQb0P7StS10R/zSOAUpbU2KmaDVOWH0PRy3Oh59ux
	q1qYbDRjDde9IT27BiNTQDq4jZA1dNr4Rte/ksqCBJM5VO+k/+wOsjhxjD65Cc3CWow==
X-Gm-Gg: ASbGncu9CspD2FdbAW+UsZkCahsQ3xo9xb0raGYFftU5lSVWYLPrc4nJVCL09CuGMB1
	cMG/KijUiew1yUR40f55rfo7rfzx8+yITaQC5XQJz5VR9VMD+oc/8M2DaoS0HBzFXDyn2svARWM
	lw4scW8fWaLvE4vRitMNHBDQytWAXwvc5mBLR/h+KN33uUnL2KF729stmwZc0oB6VsOxzl78Rcs
	FjyIDA83EFkljqt3T1zqlRBhurP9ZPqYKVn80oQfnstQAe8ubChcHn+Sw5KxCLKKhznaj/8/t07
	ZBOZmQMJq8GTHMXgERT2yxbEqJfLh8NrCQ==
X-Received: by 2002:a05:600c:3ba6:b0:439:91dd:cfaf with SMTP id 5b1f17b1804b1-43999da55damr2421665e9.18.1739895151244;
        Tue, 18 Feb 2025 08:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH92K++cC6xDJY2j/PMK6R78q23skDZQsnW1aMpOh6cHc3xvEiDq38ZeyklE0eZ+XCX3RGQFw==
X-Received: by 2002:a05:600c:3ba6:b0:439:91dd:cfaf with SMTP id 5b1f17b1804b1-43999da55damr2421325e9.18.1739895150812;
        Tue, 18 Feb 2025 08:12:30 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61a2.dip0.t-ipconnect.de. [91.12.97.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdce7sm15527728f8f.96.2025.02.18.08.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:12:29 -0800 (PST)
Message-ID: <a99f132c-4e92-4755-9ba6-d28d9d168971@redhat.com>
Date: Tue, 18 Feb 2025 17:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] xarray: add xas_try_split() to split a multi-index
 entry.
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
 <0bb75517-9418-4145-8aa8-b05373010711@redhat.com>
 <F5D2A2F4-34DC-4967-A149-A4D5578B5DB2@nvidia.com>
 <af3b230c-7aeb-44bf-8db3-3538dfb1b93c@redhat.com>
 <DA7491B4-7794-4F86-AFBC-BB8BFBD1D9B3@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <DA7491B4-7794-4F86-AFBC-BB8BFBD1D9B3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Now, can it happen that xas_try_split() would ever perform a partial split in any way, when invoked from __split_unmapped_folio(), such that we run into the do { } while(); loop and fail with -ENOMEM after already having performed changes -- xas_update().
>>
>> Or is that simply impossible?
> 
> Right. It is impossible. xas_try_split() either splits by copying @entry
> to all the replacement entries, or is trying to allocate a new xa_node,
> which can result in -ENOMEM. These two will not be mixed.
> 
>>
>> Maybe it's just the do { } while(); loop in there that is confusing me. (again, no expert)
> 
> Yeah, that the do while loop is confusing. Let me restructure the code
> so that the do while loop only runs in the @entry copy case not the
> xa_node allocation case.

Great!

> 
>>
>>> xas_try_split() imposes what kind of split it does and is usually used to
>>> split from order N to order N-1:
>>
>> You mean that old_order -> split_order will in the case of __split_unmapped_folio() always be a difference of 1?
> 
> Yes for !uniform_split case. For uniform_split case (split_huge_page*() uses),
> xas_split() is used and all required new xa_node are preallocated by
> xas_split_alloc() in __folio_split().

Got it, thanks!

-- 
Cheers,

David / dhildenb


