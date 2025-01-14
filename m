Return-Path: <linux-kselftest+bounces-24428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5ECA10053
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 06:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D711670D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F00233534;
	Tue, 14 Jan 2025 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F32cSSGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D5240251
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832507; cv=none; b=uPYlvUoFtRGKdhvdAbzAOdlu52nRf7blC9uw8t/M13aHFksTS+g9mQCI7kW8jWRymJFOXHudn6iWdtNmaaDeE3RYUxtq7mQhqHbr9ocMOZb2ht2K5NEajBxvo+S9CfmZ1ncsiXaGjEc6jhQ8w5z34m/kfnWHvl7a4o7F8T1E+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832507; c=relaxed/simple;
	bh=GQshcU8QyJxIFhKdNOE0/w+AaKJphQdmAFnP00ASe6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=WD4k/FGPMBLwsISP6p0L5Q7pHxwOEXxUAkjWNBhbtOMuuLJ46RVBHxvjjSyFqGyVj2LP3qH+qK7YhxY97fwBz+bDkay2vod5BKTp6uDCvyjBtUgBR86n9la32nCjH277VOzOKLdjajRtAYqqBA+zvab98m31+825ld32zcXmHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F32cSSGE; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so34425005ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 21:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736832503; x=1737437303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/hyRwhy9eFQaQwT5Y554E2+vSBUsIfx45e4KpeScOPg=;
        b=F32cSSGEHVpODakRoQj+4olryw3DfmY5CsOYgKIKd2zCQZ1LkupPjvoeIjzluGyXoP
         wu2uGmSHl8gAIVs2HKw8slFCYDFtIBRZuJyysxd8C37gcB5iBzfe/DYgUM+pGRA6kUzk
         d0K2DuiUHETGiBilgHnQXPT7DOQH5lYPMLBsd4wx8ImOARHg5PsmO0qNyfCX2CdjvO4U
         1vuQ9FwJUhYLfgd3tFnPcWweEqKTGS/Tc87TZL/bS44MSmoJHfju27bdMYDQJ0Gpx1ft
         YDX83Pe14IBtmSPKgpWDYyuc/thl1xGtbMVQI33rn4GAX+jbQ9KZvk7JL0GPwmQONzZ7
         7TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736832503; x=1737437303;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hyRwhy9eFQaQwT5Y554E2+vSBUsIfx45e4KpeScOPg=;
        b=HlP+jZ5p7p8+t1nlPA7w6u2BRJdi5ywT8zaR9BIzvXcdpYp9ZLUKmKziUXbRwvVVVD
         7h+WsoVii2fkVbTnO8WLL2+GE2RdQr+529CQ/q45RHZsIXDZMey5Rz0k96odS8+AJTxC
         yLXWli8VcgA2yehz2c+fy4EdhsNb8OwgnRJ6tq5F2r804/ZU3V4BspMVcFnJ4JgeIv6A
         fpdN4xtlej5uMhbQf9UO4bblT9pgsmFJ4LRfnRbnthyhdfwtD8VVsub/rEh6C+Mhfh5n
         f92/NcFHs8r5TgeLsiyYyAw/Ut9k6ugvqRueaCMHSkjJrgeyZq9NRQb0KeJ9QAKpSlBE
         6oRw==
X-Forwarded-Encrypted: i=1; AJvYcCUgiItCFvpeFTCLAVodZO1LmyflCNRuQwUKuoxz6Gust5fbK0wYFmvVwiV6NcoUt4A1Y27ssIYNR0nC4/HWP9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5a7YbRnNTeGYoixsBdxLA4HWyVZsqjYd156ed3QWg58dTbn+b
	p7bBKMPe28zRvKxRo5dk6cJ7NUQHEmZx2pBm8yWjufDgf+7bOeYswep8iEm05pA=
X-Gm-Gg: ASbGncuCYDgTkb8sx8juMOU1Pm9zckv9hAYWQ1DvmPkZGjmK1bnITuU674LcskavJF3
	YmCjiynKLvIzMl+1OuifJnSnjPe38LRkoZCCHOQ8fUB4VZQeAySLI2mA5OgjubRVq02wubbV3JA
	eMQgIFL+9U7/m3nWZLQQnfDT+vc+Kt0S3x69hqsutGsWJgVvrgRkICeR1gsqxayqDVHV0XZpJXi
	v0Uu3vJI6mufJdvWKjSDAiDvIcvmhZqaZIsQMEmE0AUiQDMjXg8eA1FcKrwX15yM9FlMzlBSlRf
	5sVV
X-Google-Smtp-Source: AGHT+IFFGVHpfUG8VTfLaLNGH63wxU+Nwu7BqgDd/pRCCnZpwPE2D3wlvuT3cfxMO0fJl4clFa4nnQ==
X-Received: by 2002:a05:6e02:1a82:b0:3a7:d7dd:e70f with SMTP id e9e14a558f8ab-3ce3a88a4a1mr214560075ab.12.1736832503331;
        Mon, 13 Jan 2025 21:28:23 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4afc39d6sm31893185ab.69.2025.01.13.21.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 21:28:22 -0800 (PST)
Message-ID: <7c181d03-b0d0-4b81-bbd0-06943a58a287@sifive.com>
Date: Mon, 13 Jan 2025 23:28:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] RISC-V: hwprobe: Expose Zicbom extension and its
 block size
To: Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250114021936.17234-1-cuiyunhui@bytedance.com>
 <20250114021936.17234-3-cuiyunhui@bytedance.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
Cc: ajones@ventanamicro.com, alexghiti@rivosinc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, charlie@rivosinc.com, cleger@rivosinc.com,
 conor.dooley@microchip.com, conor@kernel.org, corbet@lwn.net,
 evan@rivosinc.com, jesse@rivosinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, shuah@kernel.org
In-Reply-To: <20250114021936.17234-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yunhui,

On 2025-01-13 8:19 PM, Yunhui Cui wrote:
> Expose Zicbom through hwprobe and also provide a key to extract its
> respective block size.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
>  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 955fbcd19ce9..0ea7754b2049 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -242,6 +242,9 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
>         defined in version 1.0 of the RISC-V Pointer Masking extensions.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
> +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>       mistakenly classified as a bitmask rather than a value.
> @@ -281,6 +284,9 @@ The following keys are defined:
>  * :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF`: An enum value describing the
>       performance of misaligned vector accesses on the selected set of processors.
>  
> +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
> +  represents the size of the Zicbom block in bytes.
> +
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN`: The performance of misaligned
>      vector accesses is unknown.

The new key needs to go further down, below this list of possible values for the
previous key.

Regards,
Samuel

>  
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 1ce1df6d0ff3..89379f9a2e6e 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 10
> +#define RISCV_HWPROBE_MAX_KEY 11
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 3af142b99f77..b15c0bd83ef2 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -73,6 +73,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
>  #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
>  #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
> +#define		RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 50)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> @@ -94,6 +95,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW		2
>  #define		RISCV_HWPROBE_MISALIGNED_VECTOR_FAST		3
>  #define		RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED	4
> +#define RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE	11
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index cb93adfffc48..04150e62f998 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -106,6 +106,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		EXT_KEY(ZCA);
>  		EXT_KEY(ZCB);
>  		EXT_KEY(ZCMOP);
> +		EXT_KEY(ZICBOM);
>  		EXT_KEY(ZICBOZ);
>  		EXT_KEY(ZICOND);
>  		EXT_KEY(ZIHINTNTL);
> @@ -278,6 +279,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>  			pair->value = riscv_cboz_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE:
> +		pair->value = 0;
> +		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
> +			pair->value = riscv_cbom_block_size;
> +		break;
>  	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
>  		pair->value = user_max_virt_addr();
>  		break;


