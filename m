Return-Path: <linux-kselftest+bounces-34804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EAAAD6D1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 12:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71925178060
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354D235059;
	Thu, 12 Jun 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hS1tIghM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75E231A4D
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722947; cv=none; b=fWH+NWH+WBIbdDhaIfg+wOJcmVBZ73rxfQq8ukCEuU7hOKDR4US5wI3ADUHQSwDMOLfkeQZaB+h5SCMYsH4k0c0hC8UCfA4aRKMEE5I9UccylymdgVvYBe4FVwjI+TeWtSYuxBOe4eFNcgT7/sYwi/ePbZ1FKuyLoLUDbKhCLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722947; c=relaxed/simple;
	bh=62F4NJB2BS7u3zfidjfNCmpCwpjdsdZtOmNG51qYGT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Df2kUsFe0pQAYNpb+wOJ2Oztc9XQNgKJMElEz/uk1YmEPhFPU+69pWRi6/p5U+uXRdnuKxsxOdWo7Dhh5gokekXvoxbwtk/CWFzy70IGoiQw4+xooVevA74QEtHxACOnDs6vZAViWWF82IaGdwBrb6HI1UNckBlWYoSRjZk3A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hS1tIghM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749722944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FtyzcGGcDbQZcQDEpMvfV5feFpNxVQq4Iu8Jf7s2lq4=;
	b=hS1tIghM+xQxnrZOMiA7aZ9UJeMQc38zY6UlYrgOjQfWL5ERukjKxUDW7Pyn+BCq5YW2ET
	H9KOK1GnCbnfJeHfIONmaqnhBZmr2iaFDyHNwRXC8zqoEJieMMYntmWO6G6/0mpxwl3si3
	jtlxLmRGSZrlrhyMw1ZDv9/RKmh767o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Lle7jux1O7SKfeGm8kgI6w-1; Thu, 12 Jun 2025 06:09:01 -0400
X-MC-Unique: Lle7jux1O7SKfeGm8kgI6w-1
X-Mimecast-MFC-AGG-ID: Lle7jux1O7SKfeGm8kgI6w_1749722940
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d57a0641so5392425e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 03:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749722939; x=1750327739;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtyzcGGcDbQZcQDEpMvfV5feFpNxVQq4Iu8Jf7s2lq4=;
        b=oy4nunmZ7SIRc7zO0/USdTMm4XFMe0quy+uaFhEg80Jn/ApE2fPvTOUIfQO8B3FZt7
         deoA7ucNuZHy0FELft7o+9pxCuhVlE83BD1e1XNl3kZfRxovMeJ87DTrBnQwveJ98+hn
         ujHta80Wz/wvOukHbEK6lBUQDC1MIGM1tRDMCbMRRsCAxTPHA7Ec3RQ+OsjO6drNZbZ/
         03tldLXzjCDOwFPbZGoxoMOssZCd/M8/3BxkjGephPgb2VcyjRlNYb6rQsnYwy0EEHlo
         dnui+9v2HXmYnJiEBpFthlYUr4PWkvOxfK6pVON0Fcok2OgLz7T7yT5sFKqD136Ae2wB
         YZag==
X-Forwarded-Encrypted: i=1; AJvYcCWGyxI7041T0l6eozHeaQWYCHStPGZFX40FtDmVVHbojQu4REtg475m7V9Ogf5ZipYI9xl55ij1+cBTT8DBMAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCqHjfW9lnjHAxZxVjWbZrwXxrSE47QlZJ0Bl1WgLhI6UbP6K
	rUXIKy5Bq4Ho5cWyROxg3uvszrnc9uVtyaqPQX/CsDF59pRe2+S/qr9zKgxc0md+AS2ELYaqX7w
	tFoTHZD+q4qhbT3DwJpLc178PHphJsW57BNpecMSXnfPs4qvkZEDdLCZZNHlca78hwcpwcA==
X-Gm-Gg: ASbGnctvV6lMDkbOLwjaMb5/rekumiamaOsMyvi0EGbWJNDtwUTVlKBDtdYwK6KaOiw
	kTSY4XI2wp0nvo/2kP+hKDmbHdEHzM3/Sqzn5X+WT12sUp0X9u2EPMwbxwUQW7+8SziWY8Y2Xvx
	gCg4XCNpEq2g6wrWlYWXv1+WgZXh7+D8G66akwqa0SeGr9sWZIUdScknnqaWFNeUcNr6/jy/Bqp
	6hzvUUzcNa6E2zpusYL3oh48kHPWBmiVaPjabJRemkbGN9gzsBuqQUb0hcdmJMQbm4gyMYBDd7j
	pni7s3Fs34Zzzl07T1213Ga17uM6wVoWHPoMldwKwkkzIz93w2Wn9Rv+lCl/ewSakLrsADlelkW
	VKAhsDhcvTtEAoHuMg0ONiQDnLMx/I3jDK08RusJWyVK92FYrQA==
X-Received: by 2002:a05:600c:8b27:b0:450:cde3:f266 with SMTP id 5b1f17b1804b1-4532d33d836mr18693075e9.22.1749722939554;
        Thu, 12 Jun 2025 03:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSsfAJFhAj1LcsO8Jt31ws3dd4bwGEqWAtTOW4HUlzcpub5aRnbZ7DphGMfuDuZaTWtm26Nw==
X-Received: by 2002:a05:600c:8b27:b0:450:cde3:f266 with SMTP id 5b1f17b1804b1-4532d33d836mr18692795e9.22.1749722939148;
        Thu, 12 Jun 2025 03:08:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561a3c763sm1530124f8f.62.2025.06.12.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:08:58 -0700 (PDT)
Message-ID: <e06530f6-5c2e-4b6f-b175-c7aaab79aa4e@redhat.com>
Date: Thu, 12 Jun 2025 12:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 05:54, Baolin Wang wrote:
> When running the khugepaged selftest for shmem (./khugepaged all:shmem),

Hmm, this combination is not run automatically through run_tests.sh, 
right? IIUC, it only runs "./khugepaged" which tests anon only ...

Should we add it there? Then I would probably have noticed that myself 
earlier :)

> I encountered the following test failures:
> "
> Run test: collapse_full (khugepaged:shmem)
> Collapse multiple fully populated PTE table.... Fail
> ...
> Run test: collapse_single_pte_entry (khugepaged:shmem)
> Collapse PTE table with single PTE entry present.... Fail
> ...
> Run test: collapse_full_of_compound (khugepaged:shmem)
> Allocate huge page... OK
> Split huge page leaving single PTE page table full of compound pages... OK
> Collapse PTE table full of compound pages.... Fail
> "
> 
> The reason for the failure is that, it will set MADV_NOHUGEPAGE to prevent
> khugepaged from continuing to scan shmem VMA after khugepaged finishes
> scanning in the wait_for_scan() function. Moreover, shmem requires a refault
> to establish PMD mappings.
> 
> However, after commit 2b0f922323cc, PMD mappings are prevented if the VMA is
> set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings during
> refault.

Right. It's always problematic when we have some contradicting 
information in the VMA vs. pagecache.

> 
> To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem refault.
> With this fix, the shmem test case passes.
> 
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   tools/testing/selftests/mm/khugepaged.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 8a4d34cce36b..d462f62d8116 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
>   		usleep(TICK);
>   	}
>   
> -	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
> -
>   	return timeout == -1;
>   }
>   
> @@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
>   	if (ops != &__anon_ops)
>   		ops->fault(p, 0, nr_hpages * hpage_pmd_size);
>   
> +	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
>   	if (ops->check_huge(p, expect ? nr_hpages : 0))
>   		success("OK");
>   	else

It's a shame we have this weird interface: there is no way we can clear 
VM_HUGEPAGE without setting VM_NOHUGEPAGE :(

But, do we even care about setting MADV_NOHUGEPAGE at all? IIUC, we'll 
almost immediately later call cleanup_area() where we munmap(), right?

-- 
Cheers,

David / dhildenb


