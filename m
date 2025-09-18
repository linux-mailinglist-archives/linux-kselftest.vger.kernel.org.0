Return-Path: <linux-kselftest+bounces-41683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5964B7F770
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BE23B58E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CF3195FF;
	Wed, 17 Sep 2025 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/jWFI4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB93161A1
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116326; cv=none; b=t6xMa7EjTI7I8zfTDqGZ3svl54X8N1wrAagnFYtdJNrnI0fr3H2DirwW9wqKJYXvsx/yOzCjGcqjSRoe6TgGb1viZ1P5wMgSgXPeAOYXFrCCe2iQ2gtlvmyn+OKjmlMaycWHewNApvS62bmSZwu+DqUFA8T5YJiAJXD0onFV6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116326; c=relaxed/simple;
	bh=t8l8bweHMpKGkJbfDFmvZ2Oxn3S78vXdaZqhk49KQPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL45Nvd8DRYQ/lSkAJkM2iDof2F36VqnRor2ihghHVU1+MEosFVkWTjXvXCiR/T7TBnzDn9JBruvzxnIWLVTM+jX4rfgaNj4A7XMKeXVnvo9eQePlDbWMArwEQ/wIwO6iVXNabcuZJ1gFHq0yVtuInf+5zJDmAwnesOO6f1NTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/jWFI4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758116323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpRpLIJcUNQ4TuuTh6GHYHjJ2Lxl5zf8mNwE4ByCqA=;
	b=V/jWFI4Ulisjg7jtiF6cuNPSOqy3oy6Zz2YsUBqI/gDdAQN2VdPEbRc7iiINS9ayg+JugI
	C+zp1jVGelgs8rmAKI0G8EXPEdLyKSyADOCzr1StOtnE1ft2q/mpS5K0GT0vGxwGHtubuU
	uFZZKNOTf+nAL5n6K6LgTRz/YJGdbYM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-PRj_NV_-NXG6zCDmXAjDxg-1; Wed, 17 Sep 2025 09:38:42 -0400
X-MC-Unique: PRj_NV_-NXG6zCDmXAjDxg-1
X-Mimecast-MFC-AGG-ID: PRj_NV_-NXG6zCDmXAjDxg_1758116320
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f28552927so20337385e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 06:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116320; x=1758721120;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWpRpLIJcUNQ4TuuTh6GHYHjJ2Lxl5zf8mNwE4ByCqA=;
        b=VOX4ainSk3id9B0woUGMewjyXNJW2PxstaB2j8tRiJUtTYZaatm2xP8zFVsTMCshsT
         8j6qzkVNcv2gXbgkBbHxwsURY3a/zLVxbjPO3cEqPCNEtoqPZZjY/7z5lBwm/HrKmYko
         Qp9d1BeyiZ87WJs9IZTYj2MGhmIpQ9BFAvLeQLHZQ3AWOTxiGdWVHXdurIYHoYZP4RDW
         kfOe/2Da7bS7Sa1eUPucnQ/j7EeCpd5Q4vv8W8ZwQuAAdS7fNP86MKtpwJIiy2R32Qe1
         C2gpDh3dOIrX0ko1OwO/nJPfDz6ea9oK6BkRzhlsQNfkGb1ODQW63vNjmvrbJtrJoW6y
         40uA==
X-Forwarded-Encrypted: i=1; AJvYcCWWsfAuZsrWa2bZjcijm2f6Y94l4L7r+Y4ZXfIWSx+p2DdebboybnW+nqFl3E6y+9djYGm04Czpd5M2rJ2OfEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxnrsIEN3F7+0ORse5Pu4pDnNWfCVio3JwspEi4F1nIcErtUR
	c2AEsiAU8T7Do+Nd8/3cTdxUIXNcx4NH1/PoscYmd2lLSoP0iGL81TJ5uTC68bM8kcHyjXbRboB
	oZelDbYOQvTM/OsszwHO5OnVwKCKNczoUZiCw04O0isoVzbWi81ATnOgey5HDT8p7q+FVeA==
X-Gm-Gg: ASbGncuPGQehluQeAAEnxazYtMuG0pGE2Q4xwf2wLssehwnjYjtF1nORak2N9O2PyGk
	zrklMRwoFRvUK+jPxR/8i95QKAIgK4EE72KCKnFDmWfJnH2Vu5HsEMbYyYHWxS+Yzuds1r+0OFf
	Cg37GmlIkMmXLmAjJIyOWonX2hptxv3E+VCuxhwbbPdFHC58UBTgIR4kJQ4jLdJpDrVWDI5+gCT
	luHucOyNMYo1bShaNYLJ659xVeIxEBhx4kmwEK7cYv8oSuhs3niQaKpFhF0mO4AHUO6bUUZtLMa
	NaW0con1yLi94AOwYf25ageUEkFHlx2CvXT4rNsUfRkZOx9JW5tCGs4N6Z7+WWXEQLT71tBJBuX
	/JeOqrmOgnG6r9OirRqDpZJgkPJdHyqgzXgq6AsQEpaG9C67OY5mteTWWk2uVGVE2
X-Received: by 2002:a05:600c:4fcf:b0:45f:2805:e269 with SMTP id 5b1f17b1804b1-461fcb3c0d2mr22688605e9.0.1758116319600;
        Wed, 17 Sep 2025 06:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvYWydvbyPpvj1AaR8P/P81WlSFuc3j+9G9hsVgOCA31SDwOQXwQpZgSSgyzLhp1LrsumRQ==
X-Received: by 2002:a05:600c:4fcf:b0:45f:2805:e269 with SMTP id 5b1f17b1804b1-461fcb3c0d2mr22687815e9.0.1758116319039;
        Wed, 17 Sep 2025 06:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm36519695e9.8.2025.09.17.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:38 -0700 (PDT)
Message-ID: <c6eacb69-86f5-4bdb-9c6b-04e3f7ef7c29@redhat.com>
Date: Wed, 17 Sep 2025 15:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250915163838.631445-4-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 18:36, Kalesh Singh wrote:
> The checks against sysctl_max_map_count are open-coded in multiple
> places. While simple checks are manageable, the logic in places like
> mremap.c involves arithmetic with magic numbers that can be difficult
> to reason about. e.g. ... >= sysctl_max_map_count - 3
> 
> To improve readability and centralize the logic, introduce a new helper,
> vma_count_remaining(). This function returns the VMA count headroom
> available for a givine process.

s/givine/given/

s/process/mm/

> 
> The most common case of checking for a single new VMA can be done with
> the convenience helper has_vma_count_remaining():
> 
>      if (!vma_count_remaining(mm))
> 
> And the complex checks in mremap.c become clearer by expressing the
> required capacity directly:
> 
>      if (vma_count_remaining(mm) <  4)
> 
> While a capacity-based function could be misused (e.g., with an
> incorrect '<' vs '<=' comparison), the improved readability at the call
> sites makes such errors less likely than with the previous open-coded
> arithmetic.
> 
> As part of this change, sysctl_max_map_count is made static to
> mm/mmap.c to improve encapsulation.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

[...]

>   	/*
> @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
>   int sysctl_legacy_va_layout;
>   #endif
>   
> +static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
> +
> +/**
> + * vma_count_remaining - Determine available VMA slots
> + * @mm: The memory descriptor for the process.
> + *
> + * Check how many more VMAs can be created for the given @mm
> + * before hitting the sysctl_max_map_count limit.
> + *
> + * Return: The number of new VMAs the process can accommodate.
> + */
> +int vma_count_remaining(const struct mm_struct *mm)
> +{
> +	const int map_count = mm->map_count;
> +	const int max_count = sysctl_max_map_count;

If we worry about rare races (sysctl_max_map_count changing?) we should 
probably force a single read through READ_ONCE()?

Otherwise one might trick vma_count_remaining() into returning a 
negative number I assume.

> +
> +	return (max_count > map_count) ? (max_count - map_count) : 0;
> +}

Nothing else jumped at me.

Not sure what the buildbot complains about but I'm sure you'll figure it 
out :)

-- 
Cheers

David / dhildenb


