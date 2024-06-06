Return-Path: <linux-kselftest+bounces-11301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C48FF16C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9723282029
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC2198843;
	Thu,  6 Jun 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTsWUHvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90F197A98
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Jun 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689411; cv=none; b=uYqmD4asGz/sIF8kQki+uaI5+pe+cOwMNrrMYUM/dJego7Kc2hWeY/udt2s+j322SEsto4rkA3Z3C1w6/u2rnsdZ+lumOsWy2DKbW5hIgqb1xch0irjs4Q47MbWE14b5Jl0Uy9zJyCwcJ0WUe9L4YCH4OC35T+1WT6uSUYI8o/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689411; c=relaxed/simple;
	bh=n65GZzUczwFhc4ORxki7PkiT6dEccGLhcY4yBOHx/AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvdYG+ibKmjhCr9VyDj0c9XUvxc8B9otl35t01VFUw2st4h2cQ+/EKPr87UmYAbAcTvnrOO2lTthBGunlQzEJH9+Rpi9h7edVUgtnnKLstplUoqt+8pAWIbCww3SvuuwEgsZnILRjaZFCkSHhV23yhpTagLXaR7bIRAw8sgmWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTsWUHvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717689407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rICVcq7FiKIUG7u7jIEiVO2tUcrUM6iWDXfWLjwwGZ4=;
	b=RTsWUHvOOm8Vv/f3SEgcMVH/yo64HgjVsLNj3Lgg8lF7C4mWbpRfK5gnFDStrNnd88O5rc
	58bRuOQ5GbfJ0VPBYvWyoYjR0LIKY2x9UIo299Xgmnkwt43k5MJJxB9g5pubISkJ09p6vS
	Ei/tmFqCLoVCJaiWFJahDEWTJ0tK+5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-4T169ZikPCC27eYnYHEDew-1; Thu, 06 Jun 2024 11:56:46 -0400
X-MC-Unique: 4T169ZikPCC27eYnYHEDew-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42155e1f0aaso11243865e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2024 08:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689405; x=1718294205;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rICVcq7FiKIUG7u7jIEiVO2tUcrUM6iWDXfWLjwwGZ4=;
        b=HXfJpZxMdGZ1FEMDVCiwv09rXbnVGT+wcIkJim0IgAiwBwR1B6lsl1ZBkisjgsq1Zf
         ssFU0Nug/EKbTBP8Z6uk1A2sWMra1URe0dQc+lVCK/+Na3RwmUcFgFFzNP7KfkmotqSy
         mHL8cS/8AV4xrTfz0Jge/Bp1lUT18HOjFBVRZqvV6ElISItMXPqjnFHpsPLnlHeJWIfV
         itpZYdHvkbLmEjVYO62vUYigoRG3EQZeEEo6bQE6ilsV6JobwLXuI1eQc+V5kRNcFi4C
         0w4ksdGkSfI24Qn2wM1wTv5TlltsGrEjuORyYK33XsX5YtaoPY4pYT1gcxAfOpxbDqui
         JNLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3VLV6cwmHQ2jOZvq72eXMPQ1QAVp7wgLi0crPST5RQ4xVKO7b6dCuWcgyu0hKakx+wrEUDPYXN6EUFOhrhSq/0iupn62OVeNlbSHMz9Lr
X-Gm-Message-State: AOJu0YzE85GqaLxXheNg+JfgcNQuGh+H8DolKDvVcWlb3jMe02ptTIV9
	AKgPaTJonDbxUkF74GeKECanMXmSOiV6K6mZEWBh3Rt9UiWmJSg7haxZWrMHm6SJxN4aakRWb2i
	U4gUUkzxb4p4sKwgugKqlnsdOu0zM2siWBic8U+CnAVE3cloajq2fWrsRnKqn4/ceZ5zUxgTwAg
	==
X-Received: by 2002:a05:600c:19c7:b0:419:f911:680a with SMTP id 5b1f17b1804b1-421649ec4f1mr1464595e9.1.1717689405103;
        Thu, 06 Jun 2024 08:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFICeY1PkRTCZuslnCo8zVl10rT73fNAObHJppOV3wt8/nIAR3iHGtkV3plGrDo/QKT1YfJ2Q==
X-Received: by 2002:a05:600c:19c7:b0:419:f911:680a with SMTP id 5b1f17b1804b1-421649ec4f1mr1464195e9.1.1717689404416;
        Thu, 06 Jun 2024 08:56:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe371sm60070155e9.1.2024.06.06.08.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:56:44 -0700 (PDT)
Message-ID: <5b4e7ef2-3ced-4d4a-989c-e99b06598d32@redhat.com>
Date: Thu, 6 Jun 2024 17:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com, mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 Zi Yan <zi.yan@sent.com>, Pankaj Raghav <p.raghav@samsung.com>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606135835.600022-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 15:58, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
> 
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
> 
> Add volatile keyword to force compiler not to optimize out the loop
> where we read from the mmaped addr.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index d3c7f5fb3e7b..c573a58f80ab 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>   		char **addr)
>   {
>   	size_t i;
> -	int __attribute__((unused)) dummy = 0;
> +	volatile int __attribute__((unused)) dummy = 0;
>   
>   	srand(time(NULL));
>   
> 
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd

The rick we do in some other tests is:

char *tmp;

tmp = *whatever;
asm volatile("" : "+r" (tmp));


-- 
Cheers,

David / dhildenb


