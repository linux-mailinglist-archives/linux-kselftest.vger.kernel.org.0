Return-Path: <linux-kselftest+bounces-39231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0ACB2AD72
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80194189055C
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD8326D71;
	Mon, 18 Aug 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdBe/JAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB727B334
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532482; cv=none; b=iQ440EQEESY0XqM0Mkrbln40PdbK8CRyjd3GnJNK2bfUwZt/GhymEYGzrhGOXx2su7TwNGcBihmhwrfZdAt/WMdB6HyS4j/6VgC+UmvGlK26XRPxn3iUAAU+jyAutEAvABUA0VDnHTWBN3BVScDKgmmYEYNhOmNjIg2iAefjMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532482; c=relaxed/simple;
	bh=MURBKwc/R7RuKsiSRbxI3RncWX4NFluXSPmUPAaFQiU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jCpqIXUpEPUbNQAQejRiSJc+3Ja3Ln5Aqo+R1mVkfZeODtXI8DcV5Qg6xNkzHJoi2uIJr3H3AkRZhV6mKBelvt89LUA7dWsEq7E1ZsdpaR5cF8RMm1rkyphpH91g+SPzs80HfGJYoXLiOW5Am+AwSGleTlhIcNUgpapfZTV5iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdBe/JAy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755532479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFOQyonziRd0P3HzMjIwXGmjrOQ1EAWA6UtBYNSm0rg=;
	b=EdBe/JAystZFmQgU4Ykm4Gkmyrgs7mRFo9d3g7HXJancIMrcjmvZykbFiey1VyYVPMEt0f
	5vpDKIfbNP/1+AD6ED90v5d+8gyfHKadh/9eBrVqF/6jiwezEpoKRqwUlZ4RsekKAClYRf
	DDOxiVaozZzScAcdZ1NECjVGZjW0WKg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-bPVrnbmSPmqbsUV7T9x_mQ-1; Mon, 18 Aug 2025 11:54:38 -0400
X-MC-Unique: bPVrnbmSPmqbsUV7T9x_mQ-1
X-Mimecast-MFC-AGG-ID: bPVrnbmSPmqbsUV7T9x_mQ_1755532478
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71e81ca12b7so19758127b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 08:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532475; x=1756137275;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFOQyonziRd0P3HzMjIwXGmjrOQ1EAWA6UtBYNSm0rg=;
        b=G11EzBUkGWyKZmE+QLgfdY3Ky3JtssaWc35sOzNO2TKLIkPgdhYJ3loSrVViOiJZRy
         AmvdR1FHNSai3HZpPcWGinWAJ5iaM54VZ70jFJCpM1NQ/x9crtFbERghNF15HMDI+sYH
         NWs6tNpp35SL/ds8zRb3gY3uzXhA3cnp97NkoaA63fRV3cKTXzJeahvAQvt7NZCakNIN
         cSCEj/zQUPcoDhsTvGz3IoYtnZ9pQBR2mdwGIqRyc6LAb+8hklBLpHhHtef32GvoGckf
         nMYkja4hdL5R6Q2T1jriBhqY3aoTVDH8PEAO/IzntRCvuWqHjF3RmpYlXYYPXpqqVG9C
         dRFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuf/+A63oGH4veVU8kn6dKgwOWS+vptBJ5kSoMPLwSvLCB96WZu8YIwE2jui8dwQX0l77adUgOrxd49IC8DOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/tRq0Wl3uxxaazyqqaeSu7/HklNAGf1QRLtlRxE+V1YEjDuz
	6kAOZLSV1eJIRdp1NCTZC18JJYIgkpByvXTTStHm2nrr+Fr+TOoYg6uJf2kg81/N01ij6WjBcvn
	x6Dfw8DVte/ytHooHRHezDLEN5rKsN70G3heZxxMja/J4ebwJzv2FZcLNL1n1BqFkDppowQ==
X-Gm-Gg: ASbGnctOC/yYpyVyZCYmo9BRLejEwWlNbWJ+7Vuxacmuj4QeSBD/Db4Mqv8rPbMe+4m
	SbKhRqRc4pJqMS1k4EPRGgP2Sn8ncT1ajZaNInLEOWqPC58Pj34lByNM2O+DCkd18ufbMBmsspR
	N1d+AaUPbVMBrfJpJ885gcnkw1BnTZOndn4oL+JaHn/1AnRHIQ1a7q9j51+Cwttl30n+CigB4hu
	xYBMCKd5eaTzE3JV81zpQl9Pm+0zeHQIYpdfUt9ag6LqYQpOdQf2jxQlI99Y9VumLuadUjC+9mE
	9q9Wy4Lw6wX2c9R9exAn8cqA0OBN43OylDPyDK60cNGgDSD1TWIJBRLSmfa+aYIFDK5vhc3HfHI
	2faT42Ru6gw==
X-Received: by 2002:a05:690c:61c4:b0:719:53fd:79a7 with SMTP id 00721157ae682-71e6dadedb1mr152013127b3.1.1755532474909;
        Mon, 18 Aug 2025 08:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGayBrlxCoOrqmnrlzdUnGH2MtTi88+ZdiRrSNNWROXRqmLof08QVMP3pSMg4Ho6GDSBLWYng==
X-Received: by 2002:a05:690c:61c4:b0:719:53fd:79a7 with SMTP id 00721157ae682-71e6dadedb1mr152012707b3.1.1755532474428;
        Mon, 18 Aug 2025 08:54:34 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deb9bf6sm22785187b3.30.2025.08.18.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:54:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <86ace13c-b9fd-42e3-84e5-e3716ca21645@redhat.com>
Date: Mon, 18 Aug 2025 11:54:32 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Colin Ian King <colin.i.king@gmail.com>
References: <20250810222742.290485-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250810222742.290485-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 6:27 PM, Waiman Long wrote:
> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
> access outside of the mmap'ed area is invalid. That may not be the case
> depending on the actual memory layout of the test application. When
> that subtest was run on an x86-64 system with latest upstream kernel,
> the test passed as an error was returned from futex_wake(). On another
> powerpc system, the same subtest failed because futex_wake() returned 0.
>
>    Bail out! futex2_wake(64, 0x86) should fail, but didn't
>
> Looking further into the passed subtest on x86-64, it was found that an
> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
> because the node value test with FLAGS_NUMA set failed with a node value
> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
> because the supposed node number wasn't valid. If that memory location
> happens to have a very small value (e.g. 0), the test will pass and no
> error will be returned.
>
> Since this subtest is non-deterministic, it is dropped unless we
> explicitly set a guard page beyond the mmap region.
>
> The other problematic test is the "Memory too small" test. The
> futex_wake() function returns the -EINVAL error code because the given
> futex address isn't 8-byte aligned, not because only 4 of the 8 bytes
> are valid and the other 4 bytes are not. So proper name of this subtest
> is changed to "Mis-aligned futex" to reflect the reality.
>
> Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
> Signed-off-by: Waiman Long <longman@redhat.com>

Ping! Any comment or suggested change?

-Longman

> ---
>   tools/testing/selftests/futex/functional/futex_numa_mpol.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> index a9ecfb2d3932..802c15c82190 100644
> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> @@ -182,12 +182,10 @@ int main(int argc, char *argv[])
>   	if (futex_numa->numa == FUTEX_NO_NODE)
>   		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
>   
> -	ksft_print_msg("Memory too small\n");
> +	/* FUTEX2_NUMA futex must be 8-byte aligned */
> +	ksft_print_msg("Mis-aligned futex\n");
>   	test_futex(futex_ptr + mem_size - 4, 1);
>   
> -	ksft_print_msg("Memory out of range\n");
> -	test_futex(futex_ptr + mem_size, 1);
> -
>   	futex_numa->numa = FUTEX_NO_NODE;
>   	mprotect(futex_ptr, mem_size, PROT_READ);
>   	ksft_print_msg("Memory, RO\n");


