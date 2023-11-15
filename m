Return-Path: <linux-kselftest+bounces-134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0F7EC6D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40AD1F27802
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54B381A7;
	Wed, 15 Nov 2023 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/JVzdB+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2135F1D
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:12:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4341AD
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700061176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1vpeVSkQSN5Cc84JVJPa41eUhmal473AXk2MWuCa9pY=;
	b=G/JVzdB+XHs66LHxTN88yoAUiINQxzsPNCngfYrvb/pJ6t68bu0KRAGdvoDavwy+dWdH2E
	TWRc0Mkn8YPvn2/R2I+2P3W5rLTiVqP2S35WFz3K7VpqGBZ5PBDMJM4niWYZimVOdeiEld
	xd8oQ8Zo5OqYfy21nx8Z2oqFqN6Kr30=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-4KA17kNjNq-kneDyRqmkAw-1; Wed, 15 Nov 2023 10:12:54 -0500
X-MC-Unique: 4KA17kNjNq-kneDyRqmkAw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f7384d5a2so3211731f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700061173; x=1700665973;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vpeVSkQSN5Cc84JVJPa41eUhmal473AXk2MWuCa9pY=;
        b=kR5y8HxtUXjK5m14M4380sv50XyJK8A0FUq6gL+Wquzz40KUb7rFVcrX6bmEQSquyC
         /kZre9P0J7nXSArxM5cN+3G2146dfIKCDbFlvq9YpKFH4vASBEUaYvKdNpqqWguw9VhI
         4KezlNELP5whILcuPhgv5dkEKCzSKtSr5YsnIYTyKHPmFBHIEihseERJklE3kSWiBqcC
         kwDgDvW9T1GufOKGHxKaBrSez6EBv2nH6WZtJZ+I0Q5o/dMpffxLAKQziirKDsvPxbds
         Ea8IatgCpzaP53VxcKQ6ULMJkgsntEZNijFY4J3cHJn2sB0TNwowisO0yOBqbKVXno0y
         n7Gw==
X-Gm-Message-State: AOJu0YwQNvdsrTFbDhIJb0v4CK1+x4VT9hZwfyFFmyAXMXWRMaOoAF//
	AL9kxulSOMrMkV0AxMq2PkhL4y/m+Af5p9sqbSDY7jvxf9GPEB9KAk93174/BIs4udgA9zbeKME
	ITI1Uuy0nvjZ/FroOsLM0Z3GtwYaZ
X-Received: by 2002:adf:ec0b:0:b0:32f:7867:112 with SMTP id x11-20020adfec0b000000b0032f78670112mr9447020wrn.13.1700061173140;
        Wed, 15 Nov 2023 07:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHya+Kw12o5Oq8HpHRwzsHHH2umNz9vFMY1lchKtT7bYuggtJeYehNxgDcTB++R7ORLgbxLxA==
X-Received: by 2002:adf:ec0b:0:b0:32f:7867:112 with SMTP id x11-20020adfec0b000000b0032f78670112mr9446984wrn.13.1700061172656;
        Wed, 15 Nov 2023 07:12:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:ed00:59ee:f048:4ed9:62a6? (p200300cbc706ed0059eef0484ed962a6.dip0.t-ipconnect.de. [2003:cb:c706:ed00:59ee:f048:4ed9:62a6])
        by smtp.gmail.com with ESMTPSA id e6-20020adff346000000b0032ddc3b88e9sm10906034wrp.0.2023.11.15.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:12:52 -0800 (PST)
Message-ID: <ede57bf9-de69-48bc-9e09-b0ae3e37c8ab@redhat.com>
Date: Wed, 15 Nov 2023 16:12:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
 jannh@google.com, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.23 21:05, Mark Brown wrote:
> Since multiple architectures have support for shadow stacks and we need to
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/x86/Kconfig   | 1 +
>   fs/proc/task_mmu.c | 2 +-
>   include/linux/mm.h | 2 +-
>   mm/Kconfig         | 6 ++++++
>   4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..14b7703a9a2b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
>   	depends on AS_WRUSS
>   	depends on X86_64
>   	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_USER_SHADOW_STACK
>   	select X86_CET
>   	help
>   	  Shadow stack protection is a hardware feature that detects function
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..f0a904aeee8e 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>   		[ilog2(VM_UFFD_MINOR)]	= "ui",
>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>   		[ilog2(VM_SHADOW_STACK)] = "ss",
>   #endif
>   	};
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 418d26608ece..10462f354614 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
>   #endif
>   #endif /* CONFIG_ARCH_HAS_PKEYS */
>   
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>   /*
>    * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
>    * support core mm.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..b8638da636e1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
>   	bool
>   	depends on !STACK_GROWSUP
>   
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x86 CET, arm64 GCS, RISC-V Zisslpcfi).
> +

Probably less controversial if we start with one example we have in 
place: "e.g., x86 CET". That should be sufficient to understand what 
this is about :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


