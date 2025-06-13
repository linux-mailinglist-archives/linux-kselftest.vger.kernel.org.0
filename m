Return-Path: <linux-kselftest+bounces-34869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D7AD8412
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F01896A8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD62C375F;
	Fri, 13 Jun 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4wbjo6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B693254854
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800054; cv=none; b=r5zm3I+Ws9YjQx0N1QgXbFVM91WpvRTLjaZ6OeSZmBiGn6oUSoVcvZ0x/2ueufE+o+SiWVd2DlDyrKpmpdmihrxeBHpKCW/Fk4H8tj5m/lRzuQzoesiI83AOH03Fe5wDgrmqaPOdDzJnoLIpVymDcTRhUpbMrL6BfccUG+NbZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800054; c=relaxed/simple;
	bh=dl2zdrCpuEeSRkqv05RYFyqw6ARsbf0QtjPKUNhbn6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AN8KRrfR5/CP0ngBUifpsNB6PQgSrTdXUIYrW04uG1EmiBeGhe9+N4ZmiJS1re2Lmly3AH447GEvtYhJx1EXV/YfykR8KihoRXoaa2dd6ksUE1v22wJre0n0GePtoNF3bCbkr8clHjcQQnyNuuXmXBwMTDCBEPJkRN3/T8ApssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4wbjo6w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749800050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rcjaf27Gt9/YbDNb0ynWCORuUM3eg3EGEnmFODPaEe0=;
	b=N4wbjo6wAyGydHDN4A3+PlEPdq1xl3H0J8YABQIQ+x3BovcgVj6VePDDlb5IBevbMvy848
	MZCOsYeZfJVZkZh/wU36FBT14SkN16D59Cu9BuHvnYoxHDUfoO0G7H8FtqqZMbKEfK4mh6
	+XAdIyUALFmxgCtoNnnNq0uykcabb5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-TX-Gzy5eMyOJX1vzcJqRMg-1; Fri, 13 Jun 2025 03:34:08 -0400
X-MC-Unique: TX-Gzy5eMyOJX1vzcJqRMg-1
X-Mimecast-MFC-AGG-ID: TX-Gzy5eMyOJX1vzcJqRMg_1749800047
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so940149f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 00:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800047; x=1750404847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcjaf27Gt9/YbDNb0ynWCORuUM3eg3EGEnmFODPaEe0=;
        b=c+yhrlJTXiNkCW9s1F2gdrWfwoG9u4NGAlf7rmkquXro/mQuuJPKV2EX4Hj7qV435u
         wunMI4OBZm9Ji8DYiTtOb6u6l2yeiv6RY1jsN+VB8VgLWttiO3IGZUUkKT35z5erzTh0
         YjxhSfcLcKpdv4FVoS5fpj1J1ik/CSjFh0cwR37k1hfCyLTNPCCELC982ZcYgiqNYR/y
         P2Zov9eCyw2PVyewAug7ZZz7fwwb6xTRgoFgnWt27vv1GX6okf6UT8ZmkZsuPxRkoSd3
         AzdX9MoQTsGkt0pDH3YbPuZuzrUpLEZnBf6Vd3Om44xDckr0ytAsQ7E5+gbh/uzMogKE
         H64A==
X-Forwarded-Encrypted: i=1; AJvYcCXUOV51h1xgCPadz3fc5SA/cngN1oVZCTmBoZq4jbqtjfI7j6VwkyAIiCi4fur9ZbjQBVp8EE3+X0EQF9I2T+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbDCln4OgrXschsGfu50HcvzblhWvmn35OUoHwtSKpGJenvtd
	iVkaEzIdb0kGJHBi4JKpIJMWJWg9ZazARRZRTY6JEUtnc3AFcjBczCZ9sc0l65ScLW+DSEhvFst
	K7vQQrV8AcL6xOu5O3v/1/FYWRhsvKNLIAGMH4tJkn2b8Sxxk/AwvK5kJU+b24syuqMXVNQ==
X-Gm-Gg: ASbGnctNlrZzYV9Xc3CinU7FtjenTtPZkqmujebZR2VjjAXRMEeAhZZTr6m3HPw4ISS
	ltfQn48vKV9hcTtkCgfGqnHrEYPzDefha0UX6OreGB/lkvWQrsmU3DBBnGFnM5IR4/SZfNkDj2Q
	x8vs23KzOgZRlRPtT3qV+rZL9h7jXgRet3U4JV4v9G6XWpIyfQbcatSsrflstxS59txlKSmf1wa
	IM1aMCzpGSm2wR2ZcECja2iQWfqKi6PDHY6YbR1RgFx8NrHirvFE5Wwicm4KStPFklPvkUmd/rv
	Y5N6cg+DJ3MfXrXryKVjRXPRbaTFIC/wJvkE55x0U2JQH7nKVtoUybQDiD9mMdAmqCpLT9hQXzS
	sN1ddyC1j4mKoCcf6cVru5eSWNzk0UPApXtG+RFPS1MaqfFBQOA==
X-Received: by 2002:a05:6000:2204:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a56877ff2emr1921886f8f.58.1749800047193;
        Fri, 13 Jun 2025 00:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9TBjfgpd3Vg5LLw43B19uhX7HMLfUYejxZ7ZSVefWQp+nmtkbkT9vAdG3/PBKU2z5qAB6mg==
X-Received: by 2002:a05:6000:2204:b0:3a4:e7b7:3851 with SMTP id ffacd0b85a97d-3a56877ff2emr1921854f8f.58.1749800046729;
        Fri, 13 Jun 2025 00:34:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4? (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a7fa9dsm1491399f8f.44.2025.06.13.00.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 00:34:06 -0700 (PDT)
Message-ID: <2084f57b-056c-41db-baf8-65bbc72a66ff@redhat.com>
Date: Fri, 13 Jun 2025 09:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests: khugepaged: fix the shmem collapse
 failure
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.25 03:49, Baolin Wang wrote:
> When running the khugepaged selftest for shmem (./khugepaged all:shmem),
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
> However, after commit 2b0f922323cc ("mm: don't install PMD mappings when
> THPs are disabled by the hw/process/vma"), PMD mappings are prevented if the
> VMA is set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings
> during refault.
> 
> One way to fix this issue is to move the MADV_NOHUGEPAGE setting after the
> shmem refault. After shmem refault and check huge, the test case will unmap
> the shmem immediately. So it seems unnecessary to set the MADV_NOHUGEPAGE.
> 
> Then we can simply drop the MADV_NOHUGEPAGE setting, and all khugepaged test
> cases passed.
> 
> Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


