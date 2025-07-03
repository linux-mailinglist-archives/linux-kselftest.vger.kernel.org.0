Return-Path: <linux-kselftest+bounces-36410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7DAF6D30
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A803B069F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143A2D29CE;
	Thu,  3 Jul 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFvV1K6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D262D29C8
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531941; cv=none; b=XLygIIIyItm0fjiEcJ+A98Ml/+WRi61tsZ6DCArNt6vmwzZa+Lgkxsmbb7vr8zNbL9apVT0jtotGfHegaU6WzsHBoLU1GiGhXPpxczEPnS7+vg8q4gQOIjoYV6MkWjFJj5cKWNeQ9HNsA789DfgNfduT5XJ3EhwOeXleKMnzdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531941; c=relaxed/simple;
	bh=u/mXG+meyVkPQSN2d60rE2m9IxtuxrWEsKxW9ctKNZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzxF2b+W/gphsO4Y4D92dg0McaLT9+pvQpJmiHwmhCBxVwXtrxcX2OdTo7Wtym0ivoMgzYq6Jr2YxLNFrfgkbNjX8hJBUYj4hHNV5sBa7EbknbitNY+1esMegMCeEfEZwbUc2ZGPzWWCchtZDr+8p1Yvc2y8jstW8j09EswnRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFvV1K6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gwm34b4PAcYIoCMAqHNNcMIyyJWm1FjC0e6znIfowBQ=;
	b=aFvV1K6FauOVacgWV3B1Lpwop+XqLF/WBN5gf62w0Yr5VvdV4UsgeK3r1NzEwIyJOngwPG
	BJq8mWLM4wUxDXTFvwon7QX9QY3zVtwaWFtFrWapoUf1eBeyfCABtpkUnq3LCBRwmkUlON
	btuVVNmcBzuoiTukt/8sI+bqdKQKT2M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0zyKdPEgPbeWr1GjH1V1QQ-1; Thu, 03 Jul 2025 04:38:54 -0400
X-MC-Unique: 0zyKdPEgPbeWr1GjH1V1QQ-1
X-Mimecast-MFC-AGG-ID: 0zyKdPEgPbeWr1GjH1V1QQ_1751531934
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a584d0669fso165138221cf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 01:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531934; x=1752136734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gwm34b4PAcYIoCMAqHNNcMIyyJWm1FjC0e6znIfowBQ=;
        b=HbNUNa9lq48/hukllqbnu7RYF2Fi5WtLT2rmuP+GNd+YY7umIUY9W9gl9Rc0mXHXHv
         P9+5D8FLZXk7XjLlFiHULs6cLHMovo7LO2ITR0oLPORufEBaRo23B7Epf5L0xbdKbvDD
         aWo07s23VSludOm3FLKQnDn7G5iVgy8mfPw5TynjpvaCuPxs9Z3+h2tBZLhlYCHNizRJ
         Km4Oj+s4IoJ/JXTr8k73MGoTBBJSVu+paDScMOMOT8iSw2F/Wfb91IutXkzYyjd/WLg3
         JF/cFhBfP2QEH2mQEtJCjIY4TDEYk/Kn9O6Sqo4Xx9mF6wJY6LbcxbJmoANZi9kkOGyE
         KrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxhmBCo9Dpw25wGLdvmzPkfzMsAaYT65c/3mz/6xN9/RDrELDJF1UjWfJr/RpXTP3rkneTu0LrZPikQvlE0/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTH9STibEMBMguQRDdcvnqIuPw2J742Ev/KxFKDkpur2zxEYv
	Sui2EVv1mX9XboGVR0zToeo8AOZAkn5zFyuIUztG5PspahkjgZb3VJyFv68mSXf68hzfyIvoOAa
	EERx0YEbi9Vl/E2bO1dXwulbqmrG1VDIjvNgddJiH7tnrSQIxPeUvvXEPp81K/LSg7jU5ZQ==
X-Gm-Gg: ASbGncvD1tIkU0F0XQbHm01IlLTECPPzSA7FXvi2U7H2oi8/KuWUyAKShH9tuRxKTHR
	pejwOTr78vhP5k+RNnlHaNKcCeYzMo5fVs/7O85hUHIuWhcd+vVtK68i82QC4N+JdceZIkRGw84
	5zBv88KQhV7cIcUwT8IZBB0d1EMLhRby6SVAumkiuKqrYUp54sTjjaGrqHTDbLLfHYirnTpy3Mj
	iDHZaPWLQu+zgBjXdwzujf5yOgHpkbJ3JaTQkatyDCJlIgncAIEzl6nRJ8CHylAzcqxVfe5TCR+
	GZzYK2Ysl6MvQURUh7ieIdWnWtlcxWNyyftiuLMuRhPc
X-Received: by 2002:a05:620a:28d0:b0:7c7:739d:5cea with SMTP id af79cd13be357-7d5d1cc976bmr335587685a.35.1751531934189;
        Thu, 03 Jul 2025 01:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG66Bc+x/z1lMoRTJBPMfEoClFFZ2A277lXc5gjdCv9n4Sr9TbMvl9YfSBPbAiwce62LOrADQ==
X-Received: by 2002:a05:620a:28d0:b0:7c7:739d:5cea with SMTP id af79cd13be357-7d5d1cc976bmr335583885a.35.1751531933764;
        Thu, 03 Jul 2025 01:38:53 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443229ccfsm1072780185a.88.2025.07.03.01.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:38:53 -0700 (PDT)
Message-ID: <d6ded113-2fab-45a1-94dc-5cde0c9f9006@redhat.com>
Date: Thu, 3 Jul 2025 10:38:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] selftests/mm: Skip hugepage-mremap test if
 userfaultfd unavailable
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-8-aboorvad@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250703060656.54345-8-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 08:06, Aboorva Devarajan wrote:
> Gracefully skip test if userfaultfd is not supported (ENOSYS) or not
> permitted (EPERM), instead of failing. This avoids misleading failures
> with clear skip messages.
> --------------
> Before Patch
> --------------
> ~ running ./hugepage-mremap
> ...
> ~ Bail out! userfaultfd: Function not implemented
> ~ Planned tests != run tests (1 != 0)
> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> ~ [FAIL]
> not ok 4 hugepage-mremap # exit=1
> 
> --------------
> After Patch
> --------------
> ~ running ./hugepage-mremap
> ...
> ~ ok 2 # SKIP userfaultfd is not supported/not enabled.
> ~ 1 skipped test(s) detected.
> ~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> ~ [SKIP]
> ok 4 hugepage-mremap # SKIP
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/hugepage-mremap.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
> index c463d1c09c9b..1a0e6dd87578 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -65,10 +65,20 @@ static void register_region_with_uffd(char *addr, size_t len)
>   	struct uffdio_api uffdio_api;
>   
>   	/* Create and enable userfaultfd object. */
> -
>   	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> -	if (uffd == -1)
> -		ksft_exit_fail_msg("userfaultfd: %s\n", strerror(errno));
> +	if (uffd == -1) {
> +		switch (errno) {
> +		case EPERM:
> +			ksft_exit_skip("No userfaultfd permissions, try running as root.\n");

"Insufficient permissions, try ..." ?

> +			break;
> +		case ENOSYS:
> +			ksft_exit_skip("userfaultfd is not supported/not enabled.\n");
> +			break;

Note that we have in tools/testing/selftests/mm/config

	CONFIG_USERFAULTFD=y

But I don't have anything about making the test more versatile.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


