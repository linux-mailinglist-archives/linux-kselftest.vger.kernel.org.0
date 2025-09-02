Return-Path: <linux-kselftest+bounces-40521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BEB3F6FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FF41A85505
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3D2E62D4;
	Tue,  2 Sep 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUOwD4n4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BE1D61B7
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799397; cv=none; b=VcemxI8H64L8CGlWdWogPwq3trqHat+zDNtYDhmyA7xLBeUHRggoFvltwzr+ibvs7nnvbixHv86rDl0etMN84dK7Ust2HyO/tBaxXtAk2veMxTNYTo/Qwr3ovvRgymlSDth5tLr9pgbRk4uq/6isrxwf+hjTOCYC7vgC/9U8ITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799397; c=relaxed/simple;
	bh=t7/vF9dNYzb/M++bW1nPgrkfh6GxO9QAwezn4Q4Qc+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSFYj5dxT8zKrwjR7dmbehT5bb3KxPpGh+BzwJeQzLt3JgFcHkQYuseBoOje/hpD5HwpmMRXphHePW9fAYiGKSna+ppHRK74niOZwciinwpHgcMxwd3zatA3K5Rnib8SR5k/srswFSOpIf3jMLPX/ub284nWDwIJXXaJDAGB9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUOwD4n4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756799394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hHVHx/+P6A3oOw/REhPFFE+HyRwHnNoOuSJdLwK8AQ4=;
	b=VUOwD4n4K9NmrXh5uzMXQuNP7IUYkUutyHp0K0/JXi8Ab4jIsvX0uSZ0kxUSjhurcDhmnC
	YdrnOi2wKUvHau1WhZysqvAbBg/nubWv/Ipbo2/OJQeMUTG5uafmSbOgUGFlsmqpsIJvMx
	cBHEG5V+lb40vJvQsWXH1b3ZIzdH05c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-2svSsFr-MmCHfsxq2D_YZg-1; Tue, 02 Sep 2025 03:49:51 -0400
X-MC-Unique: 2svSsFr-MmCHfsxq2D_YZg-1
X-Mimecast-MFC-AGG-ID: 2svSsFr-MmCHfsxq2D_YZg_1756799390
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b883aa405so18130965e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 00:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799390; x=1757404190;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHVHx/+P6A3oOw/REhPFFE+HyRwHnNoOuSJdLwK8AQ4=;
        b=DYuutxXzILq+KYr9aTCdF3M6wSEJYongGD0pD8gibJDtfyOn4411e8x93RMfcK4RIK
         Y0lItDX0I3aK/m9a2UlSlMbGv+zkpTgzKxVYmOZ7dAGG9boF6/dzZpeTAoutlKT+vEsU
         78RRevb72Zrz3NQu3gjvW25pCNfGeB5AtKKuUvGBVu3hSjtNMoU0ZRkBdqNtiCSTyag3
         xthM20YJ2m+S9Hf1qH1VFbTfs/wlC0hbT/O6Y5nG1IWsi2gYGsTx+4LKjnQKVdpldd7w
         vnEmRzJ8suBNRBTjD+7WeumeOXXyZzjJ4uDW6jpNGD+KrD6EZBZomVPoMiYo4+i/gpDP
         NH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUWKy+sKbCjJYs4h+7X+o7dC6mw1yCHXcxWQm7L17OHWeIm0fdTLwnvfFVQAHCOHP0OlBKpIXsuqUf1HBur6xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+VmLzDZzOGUzj4als9b2N/ONuJMPsRHAF5LUZ4+1NB2VOmGN
	NtVcNseYQV7thhpW2OwsHuZ137TuVpIBbV+YqOu3Ly0JTdkxHpWJBaPlZ7pXGOAmySSDcHcEL+Z
	K2Nu/aWJjoYvQJKY2RKQJ5jwqlGi0BdXYkHOG4GSf/G5C0G4POj7v0plP/trx1KEVpQgcFw==
X-Gm-Gg: ASbGncsdXb8KdGRXYAtPLYyUUQwkWwPmXLZtUr7W6eTANaoEeW0Cgac9FeK5oXzFQhO
	Y1ECjnFSi4HUXzxHhM8Ezjdg9zELyU4cV8hQpkTDj1EipYbSlXma58klfbeUjmgFR5P8KT5QQP5
	loiKN9lxK6q1Zzbl3XJmSseM3l0aG2CQ5x+tW6O3jON9SKdxTgOFDhkNF0Arb4v0rhptPNnUO3y
	+lKaiX+CkaX6y39p02reLctty7SHUr3PyTX6G0jA9sb/jPjQSt6CD6y9Ph841npOeQl1eou2d/3
	FbTbTcDLmn0p+5dX0HJ3w67NA2QVBYbK4/buBP+2Fx4T7YPWQ6C8H/Bfw5jlExvzhfCzD7jJOyF
	2IQctThnlwebXC7bS4laAjUn/1hea2Omh5vsXZoaQhpL5wL9kvdHu7X5uwicrDXoJfz4=
X-Received: by 2002:a05:6000:2204:b0:3c9:a722:e189 with SMTP id ffacd0b85a97d-3d1df920006mr7643381f8f.62.1756799390130;
        Tue, 02 Sep 2025 00:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuDBI69XEEhubRkSjfJw5Jpg1YUgWVdAxF+z/bqhAU2b1VzSp1W9hZ6ptgSepPCQNp5CF6sg==
X-Received: by 2002:a05:6000:2204:b0:3c9:a722:e189 with SMTP id ffacd0b85a97d-3d1df920006mr7643358f8f.62.1756799389677;
        Tue, 02 Sep 2025 00:49:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm18611700f8f.47.2025.09.02.00.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:49:49 -0700 (PDT)
Message-ID: <dd30710a-a210-44dc-93f9-1e7ddf096251@redhat.com>
Date: Tue, 2 Sep 2025 09:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <20250902025112.d2n3o4imeptppctd@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902025112.d2n3o4imeptppctd@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +	/*
>> +	 * To challenge spitting code, we will mremap page[x] of the
>> +	 * thp[x] into a smaller area, and trigger the split from that
>> +	 * smaller area. This will end up replacing the PMD mappings in
>> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>> +	 */
>> +	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> +	if (page_area == MAP_FAILED) {
>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>> +		goto out;
>> +	}
>> -		if (i % pagesize == 0 &&
>> -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
>> -			thp_size++;
>> +	for (i = 0; i < nr_thps; i++) {
>> +		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
>> +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>> +			     page_area + pagesize * i);
> 
> Would this create one hole at the beginning of each 2M range and cause
> splitting underlining THP?

Yes, it will create a hole (this also happens in the old code).

As the comment above it now states: "leaving the THPs unsplit"

There is a check verifying that after this mremap code.

-- 
Cheers

David / dhildenb


