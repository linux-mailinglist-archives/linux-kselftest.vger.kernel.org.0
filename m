Return-Path: <linux-kselftest+bounces-32837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B920AB3160
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88083A6E14
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACC2586C4;
	Mon, 12 May 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKdwlCkT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8C1A238E
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037893; cv=none; b=o7yftG+w8cfiVRNyu2lV/UxcmLHMoK+nENPBFjViXPBAUnv91Hbnr+mdI0DZljJYrIPsD2Q2LL+EnyOZK2KO9F8Qn1JbtbzLlME/snls47LWynjZuEbhUadFA1JT6FKHKYuoOzKo39GCPAMUWwRoMDCh1l1lAD8+7sIN0sqCDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037893; c=relaxed/simple;
	bh=M2opDrzT9jyzuWK6WuKNN5+h/4aFqEUsWQ+yxVm5ic0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHO+vuqyiwYG9PFgDSK9RriAD/dP5b+hrpbKaOxw+O7JLadP9XemwUQTZNHAbeIfLX7ypxYgQG4beWjh/Du2wEfboa4A613ulrGVZ8zrucxknIaMBSxqivzXK5+hXlWQICHEWM86q8i8xREMOEPcSd+4ftzWc2QjKUA7z4TLtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKdwlCkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747037889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WRxwvAlC+nEd7AYBAr4XoAmvWJCgq6lY5R92DeO0kko=;
	b=HKdwlCkTLhbv1CgB+GrnpY3HMenQut3ga1aiBGLWnEsQEwhmbmKEMKdXePPPgb11Ly157I
	ahorjeTr4ULGTHxkRt57Ud4YPWkb+YLdskW/DlP4ZzvbSCBowrj4w/ZdrUqZzoyFza9adf
	AA/wca5tG6IYwi6UOlVlr7FSkkybKwk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147--bI2F_AcO_Gt-DAsBHDUgQ-1; Mon, 12 May 2025 04:18:07 -0400
X-MC-Unique: -bI2F_AcO_Gt-DAsBHDUgQ-1
X-Mimecast-MFC-AGG-ID: -bI2F_AcO_Gt-DAsBHDUgQ_1747037887
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-440a4e2bad7so20486305e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 01:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747037887; x=1747642687;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WRxwvAlC+nEd7AYBAr4XoAmvWJCgq6lY5R92DeO0kko=;
        b=tEifcYqG/qYvcFJqjOjgFBXy4r+TFmrgCMmnoSfxnV4rcMqbXeUTIcWlpJQai3CF9W
         4FfTmwlT0v1orLv/fFaLkN3sdogbwy2BvNhOdy/JGaNcjmX8jdLK4XkzAnEv7BVnj2mc
         cYl1Y3ZCWJqD8YS8+rPb32j2yvkAnLq3fDo4ZD0tM7f2ZBbCas9kOKC+L/G6Dv5wo3jI
         WMIZUe748LifRM90HwkfFzmLOL+JC4JDarIb3Z4w+qjWHEv9fUqj81Cp8iLcvjRYMriT
         IlNLwJFczGFzGZ2MuysNnHKkeOfGexoL3LUDD14nxIOqfhPUhseVrrYjsPi3LvuZ8ObT
         sDpA==
X-Forwarded-Encrypted: i=1; AJvYcCVlI2jopJEEg26aVYyz+dg3mAPoJVfnT3B2CCBa7+JWuwVjLrVj9+IDBwTll60e2vGyNhmQE9o/YtPQqcKgdX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9oFVb3gMM4tPPQUB8asLPGaavr4SdPhfanpep5/M7KlYhhit
	NBqIr8RSo9KMMpcfpNzgGA6LgwZeNatqcEMssOt8pjr7/HiQNOBwUn2qnQrvmg1eye/WMOWvMSx
	oLZVdOviMyK3J8rgwl3IIzZ25JstqB5y8E7PDwgGHXLJBq/HfT3ddWiZtFAQWMBULig==
X-Gm-Gg: ASbGncuiFq43qDKEWoVBusb0b6KzKxbx3YiFyg5ox3N8248jJ+zRT0TYWPPHPgJmWKh
	qAI96R7ANrLzqggmHYu766sHz9CSyYFIwEKezKpOZwp2XQ6qK4dI6ESY5wIAt4O8t0z0VwsbXvg
	GlUkJnCKkQFyAi9XQN/wf6zC+e3GiEx1BiY8XiSyKmoxWEOpKhqsWkLFoa+m/pEYcAXUtB1TbFM
	8edwXstjf7bGlSkdgD70TdGDGq42YS7rrA3MrH5SgiEpbQdv6+7EF3X6jvi4HGe7L8zpy/vo6O8
	nP+BTaBNxNpJtFZhE+G1dXq0cyvmUWrUyTFl3F7E47lW5buTMkd/km2T5BcUFvocif8g9bj3Tq/
	2cioJ6sp8W0WXaoD0jY/nM32ZPAwkt8cBU21Xn/s=
X-Received: by 2002:a05:6000:1849:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-3a1f6cc850dmr10678481f8f.25.1747037886672;
        Mon, 12 May 2025 01:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPfcIwxLpos1wyYPUfrRn08KRXYHVOwvUadmPBb9k2o6DYgVghhajHD/0JKUfZyePfClWRzA==
X-Received: by 2002:a05:6000:1849:b0:38d:ae1e:2f3c with SMTP id ffacd0b85a97d-3a1f6cc850dmr10678450f8f.25.1747037886290;
        Mon, 12 May 2025 01:18:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0? (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf38sm11578699f8f.77.2025.05.12.01.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:18:05 -0700 (PDT)
Message-ID: <56a3ce13-f8fb-4f9a-93ea-ff77d7b109b1@redhat.com>
Date: Mon, 12 May 2025 10:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: add simple VM_PFNMAP tests based on
 mmap'ing /dev/mem
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>
References: <20250509153033.952746-1-david@redhat.com>
 <bfdd4a08-1887-421f-8ea4-d48eb0cee778@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bfdd4a08-1887-421f-8ea4-d48eb0cee778@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.25 17:55, Lorenzo Stoakes wrote:
> On Fri, May 09, 2025 at 05:30:32PM +0200, David Hildenbrand wrote:
>> Let's test some basic functionality using /dev/mem. These tests will
>> implicitly cover some PAT (Page Attribute Handling) handling on x86.
>>
>> These tests will only run when /dev/mem access to the first two pages
>> in physical address space is possible and allowed; otherwise, the tests
>> are skipped.
>>
>> On current x86-64 with PAT inside a VM, all tests pass:
>>
>> 	TAP version 13
>> 	1..6
>> 	# Starting 6 tests from 1 test cases.
>> 	#  RUN           pfnmap.madvise_disallowed ...
>> 	#            OK  pfnmap.madvise_disallowed
>> 	ok 1 pfnmap.madvise_disallowed
>> 	#  RUN           pfnmap.munmap_split ...
>> 	#            OK  pfnmap.munmap_split
>> 	ok 2 pfnmap.munmap_split
>> 	#  RUN           pfnmap.mremap_fixed ...
>> 	#            OK  pfnmap.mremap_fixed
>> 	ok 3 pfnmap.mremap_fixed
>> 	#  RUN           pfnmap.mremap_shrink ...
>> 	#            OK  pfnmap.mremap_shrink
>> 	ok 4 pfnmap.mremap_shrink
>> 	#  RUN           pfnmap.mremap_expand ...
>> 	#            OK  pfnmap.mremap_expand
>> 	ok 5 pfnmap.mremap_expand
>> 	#  RUN           pfnmap.fork ...
>> 	#            OK  pfnmap.fork
>> 	ok 6 pfnmap.fork
>> 	# PASSED: 6 / 6 tests passed.
>> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> However, we are able to trigger:
>>
>> [   27.888251] x86/PAT: pfnmap:1790 freeing invalid memtype [mem 0x00000000-0x00000fff]
>>
>> There are probably more things worth testing in the future, such as
>> MAP_PRIVATE handling. But this set of tests is sufficient to cover most of
>> the things we will rework regarding PAT handling.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Nice, big improvement!
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks! It was worth spending the time on using the harness.

The FIXTURE_TEARDOWN() stuff is really confusing. It's not actually 
required to teardown most stuff (unless you create files in setup etc), 
because all tests are executed in a fork'ed child, where fd's, mappings, 
... will go away immediately afterwards during the exit().

I still implemented FIXTURE_TEARDOWN (like everybody else), because 
maybe the manual teardown can find other issues not triggered during exit().

-- 
Cheers,

David / dhildenb


