Return-Path: <linux-kselftest+bounces-24218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B493A095DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAF0188A141
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF7211A14;
	Fri, 10 Jan 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzC4JiDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11979211A00
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523439; cv=none; b=SOo6e0trLv4tPpST2+XDGH/GpgJlKEaGFmIGV1PoOhAvmCHVgN1VPxx7e6XkjIcZzsgw5ZBgYXKIzPoWY0J2ETZHIZw6id/5UZZs/OaQPReE7+St1Jw5XS7DN/GczF9cgGoMK/Z0j62VE07+hvXgoKhfDcO13118WLUVRFrQDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523439; c=relaxed/simple;
	bh=2+cBIIR7LO4sojF3Wgoeo/qXP179dMwxUw99C3PR4lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw5BlFMJ+5vb0/VNJdZXd5bk8U8H5ten9ZPa8FlwDP1j6RgS3Bw7rVm45omBHWWQQ163OLy6X7a4OtKW5KogTXd98fxIzLiTMTMer9mAXeEWAaiqjNSskhVxmcGgIeyDV3k70LdjEMXk/b13gM9Mc77pvS5QaaT3rC9Kf/LcsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzC4JiDf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736523436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iGRW3EjYoaHnU1UgrHzDsOJIdj/L/nZ/ZHngEURoeG0=;
	b=MzC4JiDfBFf0pAeMAktsY6A74Jiw1o0Lmca7BuJDfE4+omAFY3CCuY1aEDkl4xp3umzovc
	wgvn3aSqgsFwQi0IURJR7SeCx+MbtwyIAr7I4jw0O3QhphBVW1/k9041TXkUhYbMwCQuMO
	e8DpoCufkBIXYchFvgfs2IWMhETH3Sc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-CR950fVXP16tnD0hioGEmw-1; Fri, 10 Jan 2025 10:37:15 -0500
X-MC-Unique: CR950fVXP16tnD0hioGEmw-1
X-Mimecast-MFC-AGG-ID: CR950fVXP16tnD0hioGEmw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so17503985e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 07:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523433; x=1737128233;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGRW3EjYoaHnU1UgrHzDsOJIdj/L/nZ/ZHngEURoeG0=;
        b=O22ibWzK/Eo1M5FbTxtJoh3cZYIL47YbckBVBa47UaAdKhpy0g8NM/IuKfjs6Usacu
         KiM+imeDXWPvNG9YMooNBF3+2Xv4iw6hYTFQu6vvWE9mV1nDIwrAMv2vYdmAn1rgOkQj
         flcVcb977DMlefPd2dwsRTzUDqNWA5QdjICKnzQxiUo+CbR/091mlu75yQV7C0qmoqr6
         f4QVjjXJ0GzbuNIES8k8vadmbac3fKVYrV7F8X9j/6TCCSE8JQwCdUMfvGXF4+bw6K9q
         V41Gsibk/dDyjfRAd2NE8T8xbcKjEOJlarVABKrR8QkHoxlN6NKS19PrP0Tfmdyb8S2o
         cYTA==
X-Forwarded-Encrypted: i=1; AJvYcCXbWKyFevsGWLEVwJ3B7gni7LMOghnfKfis5xXvBGDNfCK1DsoRly8n5+cHk51RXf7AqBs4b2WbYTBKfcDOl3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObThPhrI4tQwSSrVd6T5jfRKmyILVKSt2mhjsA4cpScMoWhef
	rQc1g5S6w8WVUO+TmTNxFUJzjlnQ9cJJuzoxqQ09pv603s6SBE5MKp8uT4U1byFzWdf507nxjeB
	+YMTmjL5lwvmSL8MVm5IeaumI8skZrwJB32csu4kQeDz7EIAmYFFc6sQthedf295I4g==
X-Gm-Gg: ASbGncujuFVNj2/31DpucHu1F0jpsu08LfUid++G/AvOW+q4YsZcqvfUv/RKs52RK/Q
	TB/8BTjAkt2XNo66gCrSHahlHDO5pUg5Aucm5ssp43XBq10DuZpOeDKrXHRNlwzFTj3+kXTNOfh
	IPlRcytO4oU/S0HJfcfJwmc7k7rO7F6jivZ8QL9sbEwo3myP0ZK4NqjSw+cZui20BDNC10x2aZv
	+6F9q/UmYcwchDG4daMcCPxoKoyByAumYzwZcaobQFhgptwLsrAYhGuRk1R5sN4NJyUzWwwdHNU
	TC5GAOndVsJXTHWyE/Ns/8EYhqUWQLNG0+BlDMQpsFwoTy2YLkQF/Cy9wEslFX158AOhKYyMqor
	Abav3B26h
X-Received: by 2002:a05:600c:a45:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-436e26adfa2mr97573085e9.3.1736523433453;
        Fri, 10 Jan 2025 07:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEclmDX9PRS4TPCr7abhZLUtWoXiHmCuvgDfqD8GeR4mu9tOK0lTmkeZFg3OU9/+cocJDep7w==
X-Received: by 2002:a05:600c:a45:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-436e26adfa2mr97572865e9.3.1736523433048;
        Fri, 10 Jan 2025 07:37:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1957sm55356285e9.16.2025.01.10.07.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:37:10 -0800 (PST)
Message-ID: <1a5c39e5-a138-4713-bfbb-54f62896a702@redhat.com>
Date: Fri, 10 Jan 2025 16:37:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: virtual_address_range: Unmap chunks
 after validation
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-2-262a2bf3c3d0@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110-virtual_address_range-tests-v2-2-262a2bf3c3d0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.01.25 14:05, Thomas Weißschuh wrote:
> For each accessed chunk a PTE is created.
> More than 1GiB of PTEs is used in this way.
> Remove each PTE after validating a chunk to reduce peak memory usage.
> 
> It is important to only unmap memory that previously mmap()ed,
> as unmapping other mappings like the stack, heap or executable mappings
> will crash the process.
> The mappings read from /proc/self/maps and the return values from mmap()
> don't allow a simple correlation due to merging and no guaranteed order.
> To correlate the pointers and mappings use prctl(PR_SET_VMA_ANON_NAME).
> While it introduces a test dependency, other alternatives would
> introduce runtime or development overhead.
> 
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/mm/config                  |  1 +
>   tools/testing/selftests/mm/virtual_address_range.c | 26 ++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index 4309916f629e36498efb07eb606b2f0c49ee6211..a28baa536332f3fcfb1b83759b5fbb432ae80178 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -7,3 +7,4 @@ CONFIG_TEST_HMM=m
>   CONFIG_GUP_TEST=y
>   CONFIG_TRANSPARENT_HUGEPAGE=y
>   CONFIG_MEM_SOFT_DIRTY=y
> +CONFIG_ANON_VMA_NAME=y

I'm afraid, nobody uses these :) People run these tests against 
arbitrary kernels (i.e., distro kernels).

In addition to that, we should handle it like uffd-unit-tests.c and 
sense support for CONFIG_ANON_VMA_NAME in the current kernel.

If not around skip the test, like uffd-unit-tests.c does.

> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index ea6ccf49ef4c552f26317c2a40b09bca1a677f8f..4fc1c21a5e218eaec4d059b75c31a21dd4e8a215 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -10,6 +10,7 @@
>   #include <string.h>
>   #include <unistd.h>
>   #include <errno.h>
> +#include <sys/prctl.h>
>   #include <sys/mman.h>
>   #include <sys/time.h>
>   #include <fcntl.h>
> @@ -82,6 +83,17 @@ static void validate_addr(char *ptr, int high_addr)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);
>   }
>   
> +static void mark_addr(char *ptr)

I would call this "mark_range" and pass the size (MAP_CHUNK_SIZE) as well.

> +{
> +	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, MAP_CHUNK_SIZE, "virtual_address_range"))
> +		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed: %s\n", strerror(errno));
> +}
> +
> +static int is_marked_addr(const char *vma_name)

"is_marked_vma" / "is_marked_mapping" ?

Because you are not passing an address ...


Apart from that LGTM.

-- 
Cheers,

David / dhildenb


