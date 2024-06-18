Return-Path: <linux-kselftest+bounces-12178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC590DEEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E81E1C20A22
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBE1779A9;
	Tue, 18 Jun 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guS6XOuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D631C2BD
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718748271; cv=none; b=gpaCeDGigw8W1SyR9RPXupwaaCV9oEbqTUcpV6yUE7rZDE67oj0d+B63uIXjWaT7ArkVcVa6EV3zdJuNhyFvaI6OI6YI8tO+C49Fu9zgQhqFUGMdRAap1iOsC4zp4jZ0VVXBrk8+jqaMtkc40k+VDmN6c0Ndo7ctDSyTPfkixYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718748271; c=relaxed/simple;
	bh=k+AclwJ00wodQRcHvDDfQG4xJoRkvU++PvRojRz0nO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKnYKV0gO0Dfiq2xdMh/7/gSRtqabtSYXQOyyG7+NRo2xTVxGcT7qxk3itHVUIEB9huoec4bsIcdtrH6Y6vU8NxM/dJBoTbYPyJWoi1lWuBmnpfgg9V2ZRAz7HXNTkEVEuWj/Wt3wrhl7SNEJf95rDqoapoUSFvC5Dddqi4EmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guS6XOuD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718748268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ndV5FarTOlzZV/t0MMVk4Q1U46OLyggJTJ8Uaq4m1Q=;
	b=guS6XOuDILot9YsQSjLtD+RrkK28Ay6oTnIjxNtwmoant0TCzArPpi9JGSWA34UNBbhtpS
	ELYQMVepYcBxXg02knaSvVyHEulmTnkZfRwH3+DKCCBL5wanhnbTFuErhcliXC3zGrh++S
	hq+3WaqLL3zIJQkhxKcKcYg7CI8/DU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-XMHZwmeTOLmHaCmV5BaWEw-1; Tue, 18 Jun 2024 18:04:27 -0400
X-MC-Unique: XMHZwmeTOLmHaCmV5BaWEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217b3d2044so45620395e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 15:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718748266; x=1719353066;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ndV5FarTOlzZV/t0MMVk4Q1U46OLyggJTJ8Uaq4m1Q=;
        b=mHwA2CZXhXGniubM8TeIOvLCKcdQ3PHWxEG8t54pSa76c7OWdHJMqq/8acpYcis0Ni
         MDwbDcY5BcyKi6DHzM5L8JPRcDsrWuuGm4yljUwQZyaollvaMrsc1d1iISbtLCBIQ+qu
         y45LUCLMh2kxLVgIMcX1lJnDn5nK9iiy73+FGBqEvajzwyhDdtQxMAnkY6g/knTOjX8N
         k9vmMgUbC5LrhmzF4RyPJi+R3wMIxe9wOe4+L3AkMqwSmc6Lxa76Et9xb0praC0T/2tR
         7MAKgAJirYVIjW1NFzmpq30TI/f0Ur4QqLSzchj0EAP1RGuJSaurCx93kWrRy1PQbK8Q
         LTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNm7iN+I/9K3W+Kcw013rLwdeKmroPec7eiJdN+U5isxpO54baUoDCu/cSsrA9T3rriNcaArxwWSbUGulU6E7eMUn4yMq+XfIkiOhd+bI7
X-Gm-Message-State: AOJu0YxBhotUQ1xNS0XqSay7pbzc6iuvZdL94jSTLSg3c7QXIPbnLWRE
	M4BF2YVdJozesR5ueNa4s2Qm9SsWkaohHNRDUkpGqAEFRfJlXCHPkYxd6hhpl9JiUOI+u6Bj+80
	Bsb8mS9DYJohK4nXsa04fYMO7o9yhwKIXfR8Bc6UQfpT4Svf1EnTvYDXH2g199SGveA==
X-Received: by 2002:a05:600c:1990:b0:421:7997:bf79 with SMTP id 5b1f17b1804b1-4247529b19bmr5546815e9.36.1718748266255;
        Tue, 18 Jun 2024 15:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGJAy7vVj2i/xBWOLbYxsadYShTEsT6E2xN9Aah1dml2fUURa916XLtKeZT9X9ildyswuGXg==
X-Received: by 2002:a05:600c:1990:b0:421:7997:bf79 with SMTP id 5b1f17b1804b1-4247529b19bmr5546535e9.36.1718748265769;
        Tue, 18 Jun 2024 15:04:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2295sm15269409f8f.82.2024.06.18.15.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 15:04:25 -0700 (PDT)
Message-ID: <1454f3e5-8b42-4568-a6c2-a0872397230a@redhat.com>
Date: Wed, 19 Jun 2024 00:04:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-2-jhubbard@nvidia.com>
 <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
 <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
 <916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
 <ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.24 23:29, John Hubbard wrote:
> On 6/18/24 1:54 PM, David Hildenbrand wrote:
>> On 18.06.24 22:14, John Hubbard wrote:
>>> On 6/17/24 11:56 PM, David Hildenbrand wrote:
>>>> On 18.06.24 04:24, John Hubbard wrote:
>>> ...
> ...
>>> I can update the commit description with some of the above, if it helps.
>>
>> I think it will. The main concern I had was that we could be ending up including headers with *wrong* data. As long as (a) it compiles where it's supposed to compile (b) it runs where it's supposed to run, we're good :)
>>
> 
> OK, I've drafted an updated commit description (below), and in order
> to reduce email churn perhaps it's best for me to hold onto it for a
> day or two, while we see how v3 fares in linux-next. (Thanks, Andrew,
> for patching that up with my Makefile fix.)
> 
> Here's the draft:
> selftests/mm: mseal, self_elf: fix missing __NR_mseal
> 
> The selftests/mm build isn't exactly "broken", according to the current
> documentation, which still claims that one must run "make headers",
> before building the kselftests. However, according to the new plan to
> get rid of that requirement [1], they are future-broken: attempting to
> build selftests/mm *without* first running "make headers" will fail due
> to not finding __NR_mseal.
> 
> Therefore, include asm-generic/unistd.h, which has all of the system
> call numbers that are needed, abstracted across the various CPU arches.
> 
> Some explanation in support of this "asm-generic" approach:
> 
> For most user space programs, the header file inclusion behaves as
> per this microblaze example, which comes from David Hildenbrand
> (thanks!) :
> 
>       arch/microblaze/include/asm/unistd.h
>           -> #include <uapi/asm/unistd.h>
> 
>       arch/microblaze/include/uapi/asm/unistd.h
>           -> #include <asm/unistd_32.h>
>           -> Generated during "make headers"
> 
>       usr/include/asm/unistd_32.h is generated via
>       arch/microblaze/kernel/syscalls/Makefile with the syshdr command.
> 
>       So we never end up including asm-generic/unistd.h directly on
>       microblaze... [2]
> 
> However, those programs are installed on a single computer that has a
> single set of asm and kernel headers installed.
> 
> In contrast, the kselftests are quite special, because they must provide
> a set of user space programs that:
> 
>       a) Mostly avoid using the installed (distro) system header files.
> 
>       b) Build (and run) on all supported CPU architectures
> 
>       c) Occasionally use symbols that have so new that they have not
>          yet been included in the distro's header files.
> 
> Doing (a) creates a new problem: how to get a set of cross-platform
> headers that works in all cases.
> 
> Fortunately, asm-generic headers solve that one. Which is why we need to
> use them here--at least, for particularly difficult headers such as
> unistd.h.
> 
> The reason this hasn't really come up yet, is that until now, the
> kselftests requirement (which I'm trying to eventually remove) was that
> "make headers" must first be run. That allowed the selftests to get a
> snapshot of sufficiently new header files that looked just like (and
> conflict with) the installed system headers.
> 
> And as an aside, this is also an improvement over past practices of
> simply open-coding in a single (not per-arch) definition of a new
> symbol, directly into the selftest code.
> 
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
> 
> [2] https://lore.kernel.org/all/0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com/
> 
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Cc: Jeff Xu <jeffxu@chromium.org>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


