Return-Path: <linux-kselftest+bounces-47864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53579CD6FB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D7DB300A343
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E6303A3B;
	Mon, 22 Dec 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UemjBPeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123431A304A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432087; cv=none; b=OPWZSw+9TEALe+iSUWHxY3frR3G8Mt2xzlrAxA/ULg9jN6KL+7RjDa9tbNqpkZjvQbdFLgdmF52sFpkxkd2bFw2Rv+6yQZuyLE7lUbBtdtXtQ0UZXT42kWdpFDjLMPvaUrsdmFRaOpGlCfB63YQyeN1XphHNDqOPUay44HOjkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432087; c=relaxed/simple;
	bh=/fo1P6Jvkp9HF0cJbS0xftZBxvAHWwbnAbs2Fgg1hx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZrRk5ZBNh/MGc2yDkNUBXIGKlRnBHvEv5YK0Q10NcjiyIPtYh8gOdVdwgnb69ofY9a+P/cm+umZJstggM62Vi8pjQrUomXxkYxb0jvBtW668iLAiOzCFqGMrUlPPkTCh+ejkS48/wLM4tEJn3NjK+3iLIHLCniDgxsJdPP6+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UemjBPeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766432085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG0oF06MATxg/zLOVliOY5C7b4LG+alI0dm9ELpl22A=;
	b=UemjBPePKdy+o/x/72FiQ4fxXrGCdqFe2tYX1j2W9OsGhSo3X1QGHGs70H8ywPgg51FOha
	gXoMIxeWnOFBrULsdHh34hcqpqUf1J6ugvJ/vPU2e7uPee1lQlug0P4gZtU442QgO0SKhc
	jotMRVOBQMM4b4getauDADGg//asRpY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-m_a4EoDxNqySnsdtdNnM0A-1; Mon, 22 Dec 2025 14:34:43 -0500
X-MC-Unique: m_a4EoDxNqySnsdtdNnM0A-1
X-Mimecast-MFC-AGG-ID: m_a4EoDxNqySnsdtdNnM0A_1766432083
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f4d60d1fbdso23336711cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 11:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432083; x=1767036883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VG0oF06MATxg/zLOVliOY5C7b4LG+alI0dm9ELpl22A=;
        b=QrxsZ6nWi0BKJ2YaM1ueaY67FB/cgY7OiaPmgvW4N4c+FQ6EDkYl3vNB0eatueasZu
         7EFAeCpBd2JoGOweW/18wMTY2CfW5pfQDiN/KFU0bY7CbrwZKlzlQ+2jJHj4oJOFhtZY
         IongyQxkRicT0Za1g682G0mLTyiSE5oXHmFuHaHaB+dYgO85IGqeUItuuOP0w9iL37l4
         +WS5ZeHRktLIbPFT2N9NmFiQlI0jU1DguSdStmC7Otezzl0QsNfO/YO1iHEQ7VjEw5sB
         yBqv9hceSZYPJXwfJroLrYcfd93Ph2Lw3YFKDjQGTU4ItAxmcahkqTNtiW0rrLEjoPQQ
         4VZA==
X-Gm-Message-State: AOJu0Yw9ZWsuLz4p7R/adKK6PxpmplMTC9ba0swCNm8hObwpXLPM2nEd
	htradZV4m6DSK7x+oITU/kXQ2LQeCCFW8IKndXhSMA5xMX2PHfuzgx6LoUYwUPc6s9wRExFH3YN
	ICfGrrCaJRWRWlR1V/ypVb2FP2KAQQ7s76m3cynXhiBhqwWK99SjJpU7ZPfvO2WUW/YezQQ==
X-Gm-Gg: AY/fxX5HLxAdrTUYHPDkLi1vu691hStpbf6j0bhwQbP0CqnswnkDM+Edp3VSdIAW3Ry
	ztGAT2FJHdFkjL0oneGudZxAM++0iK15pc4ZcJFW2otJ3cUijjzWlzYtL2r8jb4jswASV0qS9ww
	tPdGUI/zALTHWa8IrxV/cgWxGYyD+eCxY7DF/hlAfcJe6bTbQKCK9pF07DhS761feJ/VULwMhMc
	IL1YHX+P1pRVDU9I8gZHdzEGOSJW71+xf5DC/R0W5Fj2P2mlYmzewJNg14mi4Tz1YKfWqmYq7ZC
	C7rmqjRXg8ItvPydG7mD2fs1HzXI7kJViwVRPV85s5bNs/JmBCNb+tSApM6PW+n0TiH4xPcIlBt
	OpjQM5ab0jAikFEBZeVNvl8TCL5ElMAKf9hAphLbSZnbpMZ+zaG8BilyLdRMO0/IcY591gR0bfw
	==
X-Received: by 2002:a05:622a:17ca:b0:4e8:b446:c01b with SMTP id d75a77b69052e-4f4abda0960mr191530011cf.61.1766432083202;
        Mon, 22 Dec 2025 11:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnavtkUmnDQmxJQ3e4vwSgIlPXL3C48qTsghoyMt5JLf3ySEy2SXRpIFZDKMDuuzyt9EjIdw==
X-Received: by 2002:a05:622a:17ca:b0:4e8:b446:c01b with SMTP id d75a77b69052e-4f4abda0960mr191529671cf.61.1766432082740;
        Mon, 22 Dec 2025 11:34:42 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-48-76-65-77-217.dsl.bell.ca. [76.65.77.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac563f66sm80950521cf.15.2025.12.22.11.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 11:34:42 -0800 (PST)
Message-ID: <30c82582-9bbe-4d7b-8549-ebdb29743e86@redhat.com>
Date: Mon, 22 Dec 2025 14:34:41 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] selftests/mm: allocate 6 hugepages in
 va_high_addr_switch.sh
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 david@kernel.org, shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251221040025.3159990-2-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-20 23:00, Chunyu Hu wrote:
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

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> 
> CC: Luiz Capitulino <luizcap@redhat.com>
> Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
> index f89fe078a8e6..a0c93d348b11 100755
> --- a/tools/testing/selftests/mm/va_high_addr_switch.sh
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
> @@ -111,8 +111,8 @@ setup_nr_hugepages()
>   
>   check_test_requirements
>   save_nr_hugepages
> -# 4 keep_mapped pages, and one for tmp usage
> -setup_nr_hugepages 5
> +# The HugeTLB tests require 6 pages
> +setup_nr_hugepages 6
>   ./va_high_addr_switch --run-hugetlb
>   retcode=$?
>   restore_nr_hugepages


