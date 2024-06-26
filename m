Return-Path: <linux-kselftest+bounces-12817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8699186F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D52D1F21AB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45A190071;
	Wed, 26 Jun 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d07QHLT4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA4190058
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418136; cv=none; b=XZV2umROA4IvLAZENIflJZmrEGOyMujw7KhVITkjF//6RcMQzR1f59gZAO/Bo/juLpTSXuarspWPet2Kv3R6YDRQIvV2+ochhEC6K0+gJYOi1tbbdNtZbd5DwhNB8Y7eX3AaUgNaLOJPjLvIkepBjCEw0aJg0p3DzeWQIVvokoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418136; c=relaxed/simple;
	bh=xo/Fvy3VWe+IOb9gaFCgMqegSWf3xAl4oMjZiNogyys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SILGr80uNbyqfRTD5ynkYDmc/qn0Fkm45CndIQzX3eIryHObcCin5fVsm9K4Dl7w9sK3z1ez2VY+QGZG+7wiWNjr/bCWfN8GZeOrbIWk2Gf8TaLV2gROFKJY/HrfIjC6waqaHoCc5JTl82UbzM5IQ4pOyPHRzJXVco4uqs677hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d07QHLT4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719418134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOXoFSz42GQtnLTfmd+KYCNYIISW1s5m+Yb3vhlcrdw=;
	b=d07QHLT4NQGoek7Dj6XGZ/ZSd4ZOcpUpC8RAznx7We6oKOUHDfawBhV2ojU972P6bSVCnH
	jJV2YYA8hhvjFPv3Fcmp91fVZ+c5R07OBhqRyIm0lxhI6pz1TYCWJs1YFlFawgM54iyl7+
	N3sSlTATjI8bSDc6ULuw/TnJxJzoZC8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-sXovaYMHOGG4IPNDJ49XdA-1; Wed, 26 Jun 2024 12:08:52 -0400
X-MC-Unique: sXovaYMHOGG4IPNDJ49XdA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b4ff2b40d9so103754726d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 09:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418132; x=1720022932;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOXoFSz42GQtnLTfmd+KYCNYIISW1s5m+Yb3vhlcrdw=;
        b=nmOG+oHxLERjUi7PUJfefKAMChSbgwQCc2a7gH5jAXCs+Ff7O9A2p+DK0z1qEDRLM2
         A4EWI8YmCv4Lpsx7JLnRO71R269HVg4JTUPueftmamibbYqJ5IPDdWnBwrK20j8HrIMR
         GWumTH4OLKtoPXcmhJvVT+2bg04UsV6I76X6dbug0hIyQ+So78YMZt/LHRrC4nqCOeFc
         WTZgvGjSKmmkVaUjCd1uENBJJq4NJDWsk7flxLunwzWpZPmfAQ8nED8jnyJTejvqjcIW
         0JUCYHtymnoTZ/ub2V9RqR6P874SHs5fp83xiOfA4yWj8v99P9s8rpv7+ynqXDKz+5oL
         9FDA==
X-Forwarded-Encrypted: i=1; AJvYcCXEU13HwR/tYPBmV/+Dx21iEI9KqLqbottoQDWdWzMx5Ygvgf9q4m/h400Lc02DFVb94NbD8WwrsBJ/AuSSmujjZ7LArUoS6d0ezba2y4GJ
X-Gm-Message-State: AOJu0YxDqw8gLmqd1LvK95XxckJVtNKNs+Df+AT3hVXFPS029NSpT4pe
	Kp4et+hFsWJGzaf4/ZuWQ1fFuBmz+KeeC8sqhnggMrdfkmXW88iJd+kPpCchOW/M6+q2CV9hr8x
	QGT7/y8G4V9OXxTSco+EfJ9m6gpuywgRRjfI5bwmpA8LY3yk/iU0dTzs/WJEjOKICmw==
X-Received: by 2002:a0c:e413:0:b0:6b0:7b72:4e1 with SMTP id 6a1803df08f44-6b540d34701mr107894016d6.65.1719418131856;
        Wed, 26 Jun 2024 09:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLkbLeXZob5Ys+oMUQQ1Zl7PQDQFc/oBoDS0ZXL7TrOaVEasSAaj57ZMlGv6EUEyv9i4yF+w==
X-Received: by 2002:a0c:e413:0:b0:6b0:7b72:4e1 with SMTP id 6a1803df08f44-6b540d34701mr107893606d6.65.1719418131367;
        Wed, 26 Jun 2024 09:08:51 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52b16e9basm46889376d6.6.2024.06.26.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:08:51 -0700 (PDT)
Message-ID: <cefafca99f046a89e111e6972ed02199ef95c250.camel@redhat.com>
Subject: Re: [PATCH 1/1] KVM: selftests: pmu_counters_test: increase
 robustness of LLC cache misses
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>
Date: Wed, 26 Jun 2024 12:08:50 -0400
In-Reply-To: <20240621204305.1730677-2-mlevitsk@redhat.com>
References: <20240621204305.1730677-1-mlevitsk@redhat.com>
	 <20240621204305.1730677-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 16:43 -0400, Maxim Levitsky wrote:
> Currently this test does a single CLFLUSH on its memory location
> but due to speculative execution this might not cause LLC misses.
> 
> Instead, do a cache flush on each loop iteration to confuse the prediction
> and make sure that cache misses always occur.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 +++++++++----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 96446134c00b7..ddc0b7e4a888e 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -14,8 +14,8 @@
>   * instructions that are needed to set up the loop and then disabled the
>   * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
>   */
> -#define NUM_EXTRA_INSNS		7
> -#define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
> +#define NUM_EXTRA_INSNS		5
> +#define NUM_INSNS_RETIRED	(NUM_BRANCHES * 2 + NUM_EXTRA_INSNS)
>  
>  static uint8_t kvm_pmu_version;
>  static bool kvm_has_perf_caps;
> @@ -133,9 +133,8 @@ static void guest_assert_event_count(uint8_t idx,
>   * doesn't need to be clobbered as the input value, @pmc_msr, is restored
>   * before the end of the sequence.
>   *
> - * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
> - * start of the loop to force LLC references and misses, i.e. to allow testing
> - * that those events actually count.
> + * If CLFUSH{,OPT} is supported, flush the cacheline containing the CLFUSH{,OPT}
> + * instruction on each loop iteration to ensure that LLC cache misses happen.
>   *
>   * If forced emulation is enabled (and specified), force emulation on a subset
>   * of the measured code to verify that KVM correctly emulates instructions and
> @@ -145,10 +144,9 @@ static void guest_assert_event_count(uint8_t idx,
>  #define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
>  do {										\
>  	__asm__ __volatile__("wrmsr\n\t"					\
> -			     clflush "\n\t"					\
> -			     "mfence\n\t"					\
> -			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> -			     FEP "loop .\n\t"					\
> +			     " mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> +			     "1: " clflush "\n\t"				\
> +			     FEP "loop 1b\n\t"					\
>  			     FEP "mov %%edi, %%ecx\n\t"				\
>  			     FEP "xor %%eax, %%eax\n\t"				\
>  			     FEP "xor %%edx, %%edx\n\t"				\
> @@ -163,9 +161,9 @@ do {										\
>  	wrmsr(pmc_msr, 0);							\
>  										\
>  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
> -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
> +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
>  	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
> -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
> +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush .", FEP);	\
>  	else									\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
>  										\

Any update? The test patched with this patch survived about 3 days of running
in a loop.

Best regards,
	Maxim Levitsky


