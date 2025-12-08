Return-Path: <linux-kselftest+bounces-47275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DFCADA32
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245B53009575
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238B54654;
	Mon,  8 Dec 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3j438Sx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F813B8D59
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Dec 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208850; cv=none; b=Jf1b4kDgNEaQ14vGLaZiNos5ESmaTesFQjqJ+zmteISU4fs5y2IIbqBTF65puokKgva6Rl0Oy6bP81xNJwu/Gpt8HKE2E9vzK/+6Yit0hUPASW4qcMg5BpEmIvYbg+yVxmJah9ISDBSixSpx5CEzwHaAQ3JmlhDxrZT21PcAk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208850; c=relaxed/simple;
	bh=4fnOMgjetkJF3HKmZRMVlyn3xnBGJbVQAXJ3bmTzB3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NahxPKStMmyxSVPxe3RMLXa97MlCJ82xJpJ7FMK3F2P5DCp7KBt05XnjHOt65u1IsiDdRBHJqiYZswBtLZPEUHi/2vd+lB6Q0DCcKm9izQROE4kDPsOxKHVagK7mehLyowKTaa5kN26pSxvAx0iq1O+Y9HZj0IW7p6Zn6VOVWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3j438Sx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765208847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgJIxL0CX5OTd128INGYaD4p8fQ/cO5lOBgWZ/PrYF8=;
	b=h3j438SxYBPT2oEXiykiq/BWQJUFyah94lo0KZRRe65LVcaB7/0F1/2Zk/L43FFpL81Jb8
	TSZJCha+hc3fmtucV7aaEUYdVE8Z9q1qXBHbe4pznM3p5g92Q66Z0XSMqJ0kp1jBSiAttN
	YnxAHou3L7OE+PzHKbj8rLuc7ZfCEn0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ya1-2uPvOJykZte3adrVoQ-1; Mon, 08 Dec 2025 10:47:26 -0500
X-MC-Unique: ya1-2uPvOJykZte3adrVoQ-1
X-Mimecast-MFC-AGG-ID: ya1-2uPvOJykZte3adrVoQ_1765208845
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so22905665ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 07:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208845; x=1765813645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgJIxL0CX5OTd128INGYaD4p8fQ/cO5lOBgWZ/PrYF8=;
        b=vpntetUWZOhtIQlD46VPn4FHr/8/AJl5j4KrFO5pRTeUiJWDVz7wqwfYsTEsSAALlw
         J/oaUWvUk8fjrggBkpDekA53VuP/vE1k0vEgD1YwbOmtQdx65NfM3xY/5Nn5ypde9iV8
         WPhURm0GqDiQFJOc6AKOpXlkRz17xVjd/HzWDiWiUA3jOv3ydFd+SWYW0+dsDqNXy7dK
         ZKq/00i4P2hWeizxf6enzA0IiMwcDq5F9qQ6k6AwYDkO75UZenKEdQqyRqrrIypeNJv4
         Gup5t78t9Ikf+55f4IcN/38rO52PERynkfNk+bjGnfpPPYHjakL13iUfKOfo4PBurdeE
         qxng==
X-Gm-Message-State: AOJu0Yy+iI64MIXl3ZkRsE0MzmzbB3vUyGNNNuxeKehveE9STvAfnLJW
	HK2hMlT885AgXddZ6+oMbWT0xCCnPeeTelnPuQ8AhbE2NEjW2CIjjCOd7Ur2+x0Cc3BtopnqgFj
	aKk2Awcljr5qdGblZozWkSuhuOye7gAkrFC2VB/gVE9ltwsOtUZs9IgUOgaFjio7AgFwcmA==
X-Gm-Gg: ASbGncuZgOYOZj+lgYl3r5puZh4FjK0drPu9nPwMXuHa333edJQsWREult1d/3BmK27
	7t39QEaqGQ8Iaw8pNsBiCA41VlPv5lM4NI/XV+lSwvwT0/bsKx4lEigqK7kMNw4h8G14gLCAu4o
	xZ5sA+YvmgyddEMd11/SDYW5dxMPownyQQP20THfRl6lONsaWp5KmrYBqiyECXJkUlkq3umMbYk
	99VYzjm+bFskz7izD22UAlzPff/q9wrOy8TLrPZ7S56DR00E2V2pfGCKVzaFYlj5kzpt3ybd5m5
	WdE3PvlPjwCcS9CQO0+aM+5hVV4keMkX3oOtPwb8HuiAQsauFrER+qLFKwZe55/xf9kPvtq48By
	SAg3/ef5aRJGjExPNU2Nedh4JMx3lEV6z3ATA6M/7RhZuWFVsF1ISFUANQh0ak31t7tsQ/SA5lQ
	==
X-Received: by 2002:a05:7022:e0d:b0:11b:ca88:c50f with SMTP id a92af1059eb24-11e032ae38cmr5385604c88.40.1765208845340;
        Mon, 08 Dec 2025 07:47:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcI88OCdHn0429dQauXa74FPpbQ0zI+AbQVlLrbOvpfEmA7o1JoeSaFNGOnyv86keP6Q29fw==
X-Received: by 2002:a05:7022:e0d:b0:11b:ca88:c50f with SMTP id a92af1059eb24-11e032ae38cmr5385574c88.40.1765208844810;
        Mon, 08 Dec 2025 07:47:24 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-48-76-65-77-217.dsl.bell.ca. [76.65.77.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm56899085c88.2.2025.12.08.07.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:47:24 -0800 (PST)
Message-ID: <efdd610d-a56f-4f3f-ab5c-9b0da1762ab6@redhat.com>
Date: Mon, 8 Dec 2025 10:47:19 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] selftests/mm: allocate 6 hugepages in
 va_high_addr_switch.sh
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251207122239.3228920-1-chuhu@redhat.com>
 <20251207122239.3228920-2-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251207122239.3228920-2-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-07 07:22, Chunyu Hu wrote:
> The va_high_addr_switch test requires 6 hugepages, not 5. If running the
> test directly by: ./va_high_addr_switch.sh, the test will hit a mmap 'FAIL'
> caused by not enough hugepages:
>    ```
>    mmap(addr_switch_hint - hugepagesize, 2*hugepagesize, MAP_HUGETLB): 0x7f330f800000 - OK
>    mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0xffffffffffffffff - FAILED
>    ```
> The failure can't be hit if run the tests by running 'run_vmtests.sh -t
> hugevm' because the nr_hugepages is set to 128 at the beginning of
> run_vmtests.sh and va_high_addr_switch.sh skip the setup of nr_hugepages
> because already enough.
> 
> CC: Luiz Capitulino <luizcap@redhat.com>
> Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.sh | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> index f89fe078a8e6..98f3dfab62c5 100755
> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -111,8 +111,10 @@ setup_nr_hugepages()
>   
>   check_test_requirements
>   save_nr_hugepages
> -# 4 keep_mapped pages, and one for tmp usage
> -setup_nr_hugepages 5
> +# 5 keep_mapped hugepages are reserved in the first testings, and the last test
> +# requires two hugepages, with one verlaped with the last second test, so one
> +# extra, totally 6 hugepages

IMHO, I'd just say "The HugeTLB tests require 6 pages", otherwise the
fix look good to me.

> +setup_nr_hugepages 6
>   ./va_high_addr_switch --run-hugetlb
>   retcode=$?
>   restore_nr_hugepages


