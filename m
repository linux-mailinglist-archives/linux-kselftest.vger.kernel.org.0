Return-Path: <linux-kselftest+bounces-33994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1084AC7E14
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 14:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02631BC73EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBB226173;
	Thu, 29 May 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kP6lhdRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA05225407
	for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522590; cv=none; b=GgJcSaCIBZ1osULzZMWzwgLFqnzjlTBWmFLJYFMDpK1oabh35SkfpNoKVpk8y6EEXM3+C+vXvlRroq4BKNUzVEpjNuUNbeknpAMmY1ERGI7FijrJNun4iNbu1nhlYWXfQHRQci5x4ofz5D6KmqCMsvOl0ubwwVjjROaTSza0zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522590; c=relaxed/simple;
	bh=V+k0YYVajMtJvjJHVuTTJYUaZiiFudh9Jn7Ksm1pgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hko3E19OUF7MnIvfu+dWKhdmlVwF3wXSekrUHYj+Iklvkf6WR/dKUvQ5vtoUsLgu8vVWu2MFYkxbd4zlP5W3V+SL7Lc8SVnlQgidHnCQsNIBRrt29FsrTt8XT0zKxEnEZegZ4S7BRL4GBjmF4sjex93Z9gc9PaoEPybbOszKNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kP6lhdRG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a35c894313so764579f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1748522587; x=1749127387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJYtTflbkn898/BLxpK7QKxJtXnTWVg7vYFavAXp8EE=;
        b=kP6lhdRGJGkdXgQzXxmy1ksFt5oU4/5W/LyM1p1LngNC0bZNtI6jROQSrP3jnzjdZl
         Ltb4flIV+bPyYT4hvSKuuYQlJUy/DM0Md4TFDwk5L4NjClsQ6l1qDNUWDWe6lzTsdZpy
         mn0Cfy3cb2NHpD8nn3RLAVLf2l92ajODi23NtUwlVuAWCE7jCSTGZYiACsJNke7l2UWp
         4e0h7xJXJEiEXIHo+Z2yKwQ1Ufmx6b2msJXicZ7ZMiSntjaJe/6qHwg6rbVnwXHWaSEF
         0lnFZdOJW5YBrDMEzPzs0jl7pIvSOiRNqxJgrnS7oCDjqER8i4o/K99GZAGiTaSc48U6
         1YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522587; x=1749127387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJYtTflbkn898/BLxpK7QKxJtXnTWVg7vYFavAXp8EE=;
        b=ZPZ5g0oFY4RvQDscZq5SxXw47yPISkTmlJMDC0a2QtH2KLIE0i6H+AyGtEM5ABMGBm
         fLjPS5YWV+2zQHtS9CxA/8KblDg56VfhOhcpdEHFXjl7GzQ+9J73V8K1ydFxxszoKg57
         yQdsAre+kcecXjoTpuhCipzzdMCtJW1JNbg9Q5onbVgIpj5YuWd7ncbcoUm+hOmX/8J3
         Njwtmnb9Kw7n7YyxnVyjYlHRESnpuNWYOAYb5SYfHQyAJIoxnfCNQj3Z+YeXYqV/EbZ3
         doT1O4OoAm5Y/8ymf9K2yGJ8XKcxEOUkgClTGukr9snZ4TlPlF0McFBjSENKPikAw6+/
         O05A==
X-Forwarded-Encrypted: i=1; AJvYcCX93JROvAydUg54rAqGgD8j9Z7i/r0K21TTlu6WeNnOPusfxnpPtcigxB8ynKZ/D4Paj+PXwYHz97b2i5SqEkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyeolbZSY8DzDYZufVka/6DWbseRTlO3OEN6q+hCAAgGkIm5o
	HrLzYm2ukOe8djPilqm9F67mbEsZL7vb42vDKqdEDTCqP/VN+3NumlBzPPbiaYa1W34=
X-Gm-Gg: ASbGncsFOIQKCzAArYZ9//7u7WjgP0s4jvROdQOclSIWqZVOOlMmeHrpHGThOp8SXLo
	qJb5+Vd10hiQf/fAIoehmHZFoBdleKiQ5CB5KChSviatqsSg/ymz4BpjgiUOhD2I25cuDgVt7zx
	bYPxQQyvf0UOpHEHsXI+5iIeDpK275EEn7ueUjgXVlxg+qP9LIMBHweVO8k/N5zGc9LJdRhaN9Z
	01qg6tDRiqIfBj6tKJ0K/3RsWZHi+qyJ036iHtF2wA4WxfnD6jS8S/XfgPkswHk71tTT+rPeAlJ
	LBosw5yp4Es/TL2YyN94k2rkULvJVI5fl+pegJk=
X-Google-Smtp-Source: AGHT+IH1qVc7QxmWdlIwYswNWc2JM2wrCY/fhXTQ9RO7aSAjTmjiWe3//9USHzfv3DqUERGinpMtXg==
X-Received: by 2002:a05:6000:26c8:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3a4ef70e20dmr1890290f8f.55.1748522586703;
        Thu, 29 May 2025 05:43:06 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe7415asm1948902f8f.57.2025.05.29.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:43:06 -0700 (PDT)
Date: Thu, 29 May 2025 14:43:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v8 08/14] riscv: misaligned: declare
 misaligned_access_speed under CONFIG_RISCV_MISALIGNED
Message-ID: <20250529-84d9bececfab561dfc68b723@orel>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-9-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523101932.1594077-9-cleger@rivosinc.com>

On Fri, May 23, 2025 at 12:19:25PM +0200, Clément Léger wrote:
> While misaligned_access_speed was defined in a file compile with
> CONFIG_RISCV_MISALIGNED, its definition was under
> CONFIG_RISCV_SCALAR_MISALIGNED. This resulted in compilation problems
> when using it in a file compiled with CONFIG_RISCV_MISALIGNED.
> 
> Move the declaration under CONFIG_RISCV_MISALIGNED so that it can be
> used unconditionnally when compiled with that config and remove the check
> for that variable in traps_misaligned.c.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h  | 5 ++++-
>  arch/riscv/kernel/traps_misaligned.c | 2 --
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index dbe5970d4fe6..2bfa4ef383ed 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -72,7 +72,6 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
>  #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
> -DECLARE_PER_CPU(long, misaligned_access_speed);
>  #else
>  static inline bool unaligned_ctl_available(void)
>  {
> @@ -80,6 +79,10 @@ static inline bool unaligned_ctl_available(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_RISCV_MISALIGNED)
> +DECLARE_PER_CPU(long, misaligned_access_speed);
> +#endif
> +
>  bool __init check_vector_unaligned_access_emulated_all_cpus(void);
>  #if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
>  void check_vector_unaligned_access_emulated(struct work_struct *work __always_unused);
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 34b4a4e9dfca..f1b2af515592 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -369,9 +369,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
> -#endif
>  
>  	if (!unaligned_enabled)
>  		return -1;
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

