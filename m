Return-Path: <linux-kselftest+bounces-482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050F7F617F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 15:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79225B213DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84D33074;
	Thu, 23 Nov 2023 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA0eFvKR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ACED44
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=22lkuupwOi3hQyJ80zjsVGNVUUakiKR9P1emLJtIdd0=;
	b=IA0eFvKR5SAjdih0mGGQZ1wNIX2Qyo6LQhIJBIb4Fei32k8u3ffDYiKU0Zh6krOHOKaxQR
	YpZ5OiNuNWKkrqzWBTcFnTBZGnAPLt1eeybN+J6gZ636QmcOi84XzUU9jCmiLUEfBi+0Td
	wI/fdrkNY+Ek8BPOYKiYy6oZlEi8aj0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-jkCEIukUNt-p_X4AWXzJ-A-1; Thu, 23 Nov 2023 09:30:46 -0500
X-MC-Unique: jkCEIukUNt-p_X4AWXzJ-A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c51a7df557so7110411fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 06:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749845; x=1701354645;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22lkuupwOi3hQyJ80zjsVGNVUUakiKR9P1emLJtIdd0=;
        b=RxzBvk+M6UZUrt5NWtSgVV5RjKTIMXwMHDjppfOJBk0fCHgRa0XJ6sAHcyfDaVm6ls
         4HJpePpgX1T0MVTYGERcu5EVwi2eNqRpU3sBynTo2TnimYMC8J7eaS/83tnHpeQX13k4
         7i5GpQnLChnl+IlosYWXhS00sKNCZp5T3uaxdzDc0EPhP7ipmemvkaT1O9ccPKOmRkZ7
         D+F7LhV7MLg9yoX/YDNk3VF4hPNXOLPmLqSwnzs+ipb4i289wQFvnGCAKDaaKvldw3Hs
         8HGVWBjeHDh5J/Rp2r1Mh/15LwKPrEZ8oRlRfvXQj1IeYNyg2EXu+Y6xOcHCVFvJQi7g
         F3ew==
X-Gm-Message-State: AOJu0Yz8oN0VWhNHhUB2WPXUVx83o7JLphxtxj/1UCK/HLIeV7IbAQW4
	ns7go+iHW1vzB7ov/I86ZXFi/lr3UwdE/q36BcvoevqEzzpmMoNC+gLX55Z6YfFbe5/7uv/MEZ3
	LdnZ+f7L24bBLPSN66jumojs+wzmdLFHznX2e
X-Received: by 2002:a05:651c:1214:b0:2bc:d8cb:59fe with SMTP id i20-20020a05651c121400b002bcd8cb59femr3944438lja.8.1700749844771;
        Thu, 23 Nov 2023 06:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaP3pVQfTih1k5s7Q4cFcnc5LQv+SCNgGHEweImwr6WvbNRyXZ7e2KaHTHZEe9LdiiGTQrYg==
X-Received: by 2002:a05:651c:1214:b0:2bc:d8cb:59fe with SMTP id i20-20020a05651c121400b002bcd8cb59femr3944425lja.8.1700749844298;
        Thu, 23 Nov 2023 06:30:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:c800:ed2f:91bf:8c46:7078? (p200300cbc716c800ed2f91bf8c467078.dip0.t-ipconnect.de. [2003:cb:c716:c800:ed2f:91bf:8c46:7078])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040b3645a7c2sm2188202wmo.40.2023.11.23.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 06:30:43 -0800 (PST)
Message-ID: <19e138f1-477a-4d79-97a3-68604f8da098@redhat.com>
Date: Thu, 23 Nov 2023 15:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: prevent duplicate runs caused by
 TEST_GEN_PROGS
Content-Language: en-US
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: shuah@kernel.org, akpm@linux-foundation.org, jsavitz@redhat.com
References: <20231120222908.28559-1-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231120222908.28559-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.23 23:29, Nico Pache wrote:
> commit 05f1edac8009 ("selftests/mm: run all tests from run_vmtests.sh")
> fixed the inconsistancy caused by tests being defined as TEST_GEN_PROGS.
> This issue was leading to tests not being executed via run_vmtests.sh and
> furthermore some tests running twice due to the kselftests wrapper also
> executing them.
> 
> Fix the definition of two tests (soft-dirty and pagemap_ioctl)
> that are still incorrectly defined.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   tools/testing/selftests/mm/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 78dfec8bc676..dede0bcf97a3 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -60,7 +60,7 @@ TEST_GEN_FILES += mrelease_test
>   TEST_GEN_FILES += mremap_dontunmap
>   TEST_GEN_FILES += mremap_test
>   TEST_GEN_FILES += on-fault-limit
> -TEST_GEN_PROGS += pagemap_ioctl
> +TEST_GEN_FILES += pagemap_ioctl
>   TEST_GEN_FILES += thuge-gen
>   TEST_GEN_FILES += transhuge-stress
>   TEST_GEN_FILES += uffd-stress
> @@ -72,7 +72,7 @@ TEST_GEN_FILES += mdwe_test
>   TEST_GEN_FILES += hugetlb_fault_after_madv
>   
>   ifneq ($(ARCH),arm64)
> -TEST_GEN_PROGS += soft-dirty
> +TEST_GEN_FILES += soft-dirty
>   endif
>   
>   ifeq ($(ARCH),x86_64)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


