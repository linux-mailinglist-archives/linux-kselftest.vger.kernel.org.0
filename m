Return-Path: <linux-kselftest+bounces-38374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EFB1C640
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5102A18C3224
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F3221544;
	Wed,  6 Aug 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOljfUj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021E33985
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484440; cv=none; b=J68BamvHxWBTEXA2Swx0HGe4O+KEx9OyLhVJrnBKyZxK9TfrPu6AkjEFS1pgAgjZn6WzAsvRTaoCEepbUP29GR5drJg2Y5SZ+yg4ZXNjx7BnZfyydcCnmfEXVCFYEa1Em2anavsJuI32EdYIwBeMQGmxBD9cR0dtj2xub8TwVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484440; c=relaxed/simple;
	bh=ufU2Mu4myF2+yACQiODiRh+3hlp2kMgjerZyfXe7DfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czDe2ajhgoScgEP+KD8aGmMtX6CKkoHa2EkCi7Quxr1I1yt8LccdSbQS33wBI0Pqqh/wdtja4bK6aBah4we+ZyIar7TbDCWY9U5NLhctNjBq2u2SG9R4YUdQfTmyGhh5Nr3nopE/hAQKsDH3rWeaAcY/9KY43gihth5K0TAb3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOljfUj2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=du+uAPV+viA6SIQNfFwbJjlhxucMQkz0DAyZJ6nNc3I=;
	b=JOljfUj2i/CP0+qgYo2jD6z3fo3bQYZ3EgrCXjZhlvY6sQqSab3j8MmEgiO/HQe8n3d/v9
	3Ff5rf/ZFPKgMCsHiOea9hDyML0YZrlrEGaWi4MrxW9ZIft4LJrdn892xnzDQUjjVG8rLL
	9XhEBYu+jU9DZgLU4+gFZgrTkk2z0ek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-O67jlgivNoSF3Nb_ntlzwA-1; Wed, 06 Aug 2025 08:47:16 -0400
X-MC-Unique: O67jlgivNoSF3Nb_ntlzwA-1
X-Mimecast-MFC-AGG-ID: O67jlgivNoSF3Nb_ntlzwA_1754484435
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e4b85895so7696535e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 05:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484435; x=1755089235;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=du+uAPV+viA6SIQNfFwbJjlhxucMQkz0DAyZJ6nNc3I=;
        b=VAOw3ue+aFy4oP21j7cPQSDmYgap/GyFCz4vLM5Hc5oniqKrS7ZhkKLNELi0/6rZv3
         xA5tdvxbLL6s+432Q5WGr7e2wmcLl+zUH8zxhhTye9j4CuQDhI0p9oo8KurIcUWjNgb4
         oARkx+NqEhNBUoekHFXjEnFjDohTN/BOYek5W9qG5/BVGptvbrcF/ejH1H9KzlrI9GPA
         QN5rEt0edOz/jJNZMKg7AwiqvXp4UHBUDGZN5VVCJtlUxDZekLROasBTtL0nKe4awGJs
         moQp1G7CKN3U87ptZ7D4p4ABwuuqIFUYzDOV5ulNf4GZ/5iVJKzIWXBB0TSARfpLlPGg
         Id5A==
X-Forwarded-Encrypted: i=1; AJvYcCVJBzI/o79K66w4B/Gcyde2tPc0oh6XzdlUbKjU89FFE4/m7ppxYk4jG0u9dvw3+Uw4VHIBzs1ZG/gufnetsK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgnVFycQAYzF0wQic13R4mI3OZSQwx+SamKDwox51g4SUEq/Y
	lL3szsLzSv/XzCBEB7OtEIpON0GGFshtFM4aiiLbUWGahlXFigTDgR1ZCW9oCX0iQNW/fFJkJvX
	zsHQHDRopJiYG9tMj9CV2dV3EYp8wBoWHkDedhMG/HYYP3zvXkrbatzizVW8WT99l5XSowQ==
X-Gm-Gg: ASbGnctBKcilbCZyvg8X2NzwPSg7MG476T9faZ2HRrVOaK41u0uZx+rxvWZaPTl+HaW
	hlUbVrEB0vzI7xBvUNhFoLNxiKmGCXEQufdPEvhgbd9Sr2lD8r25byznbntMkF1gQP0/hKvUSiH
	PiAsYQh7YU4Tqi5v4GIH/lW6fjqvoH8g2Hycm+5n1Dr8aGN571BKRWhgHIvdUTb1FCzTb9HQb4A
	VT04eGp12mD3bmxFM+7uisjCc9Wei74Nq8BadNbkL/O9qAlMp9SZDkWsU/axJlGtvBbFT7Gq0by
	6VTEsgU4ZOKCngwjaoOzC/J8AaQmJH/3cixhBJhTnwZa8NDv7phSipf+XWcz8SLrBAffF4JUPpb
	r/4u4LnMxZyQb1he2eVu/rFb9g2CJYfrSz1AicFvEY2yLVrk+X9gp95i1Liaj4zex/8g=
X-Received: by 2002:a05:600c:1550:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-459e7447856mr18428655e9.1.1754484435063;
        Wed, 06 Aug 2025 05:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWLZ8ZHFSzUGM3QUGYEAYSt+YHr4y08dG1ATS1v5CDniPdYt8JEUnU0hkuZRyg5nvDeoR8KA==
X-Received: by 2002:a05:600c:1550:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-459e7447856mr18428415e9.1.1754484434644;
        Wed, 06 Aug 2025 05:47:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm23238259f8f.42.2025.08.06.05.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:47:14 -0700 (PDT)
Message-ID: <60b6c458-e3d0-4123-9815-44e8e8ae0e60@redhat.com>
Date: Wed, 6 Aug 2025 14:47:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/huge_memory: move to next folio after
 folio_split() succeeds.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806022045.342824-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 04:20, Zi Yan wrote:
> Current behavior is to move to next PAGE_SIZE and split, but that makes it
> hard to check after-split folio orders. This is a preparation patch to
> allow more precise split_huge_page_test check in an upcoming commit.
> 
> split_folio_to_order() part is not changed, since split_pte_mapped_thp test
> relies on its current behavior.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

>   
> +		nr_pages = folio_nr_pages(folio);
> +
>   		if (!folio_test_anon(folio)) {
>   			mapping = folio->mapping;
>   			target_order = max(new_order,
> @@ -4385,15 +4388,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>   		if (!folio_test_anon(folio) && folio->mapping != mapping)
>   			goto unlock;
>   
> -		if (in_folio_offset < 0 ||
> -		    in_folio_offset >= folio_nr_pages(folio)) {
> +		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
>   			if (!split_folio_to_order(folio, target_order))
>   				split++;
>   		} else {
> -			struct page *split_at = folio_page(folio,
> -							   in_folio_offset);
> -			if (!folio_split(folio, target_order, split_at, NULL))
> +			struct page *split_at =
> +				folio_page(folio, in_folio_offset);

Can we add an empty line here, and just have this in a single line, 
please (feel free to exceed 80chars if it makes the code look less ugly).

> +			if (!folio_split(folio, target_order, split_at, NULL)) {
>   				split++;
> +				addr += PAGE_SIZE * nr_pages;

Hm, but won't we do another "addr += PAGE_SIZE" in the for loop?


-- 
Cheers,

David / dhildenb


