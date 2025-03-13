Return-Path: <linux-kselftest+bounces-28943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055FA5F4AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05D83BD3E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249992676C4;
	Thu, 13 Mar 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g8/beGCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AB267387
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869561; cv=none; b=I6KnxfbmRHz61ZQr4dF5VPo0zHYQgk6nMoz6elZbhLOHDg3lrVEkEGzlhaUxxEb+08Y5UCx4c4dotK4cTc7tKhXkCAhgzIUAhyljB5cHySyaQwIe+g1cRt1waz9hE0W5ryA/aHHlLVuVi3I7ENfYixkQ7OT0QWCpqTTik8kEd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869561; c=relaxed/simple;
	bh=cg5D6pfaTmMxWwYRdSc3ve1jzhcFg1ZIMZvTd79kFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Damskl0cwUAYaIVWI93f2TcDzSbOb6pWp+dBRiIJ3APo4HemQU/lqO+z4FC7hXaL6mS7RoQmtHeNeR/QKrjm/6x+BY9/XcFo4BzqSsaYsuQrLTr/P930gCQv6crpaNf12Te7hCjjylhRwNW+XHjm4vA3ExTl3vDPXk6yI6GpuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g8/beGCL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390fdaf2897so782251f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741869556; x=1742474356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSlQ1L6rFi2oeV1zF6QF9pposhG4AHSuAju9zq00g0c=;
        b=g8/beGCLOIwMbAr2nOkT6riGp9wK5SU+DNXVeYT8uNdesrrwWIU5ahZ6rcrcSpz+xi
         fouAPAFJKfZxZqeyMRMDQAdFXtxnw0fjXVc0fLArJTBF0RK+C6S8o4a0mnCbf2/cYdJP
         qIk7jOORmsHdORaeoK4TZvXgSElkeq1sN2h21She9BJLs32XBBVVWDcSja/wwO20pn0x
         5vFZ+tsoYK2IiNObKtBp4hV2sAnNGqf0FQtagqEjIAaplToKtn+1iCL+vvUocrICMasP
         7z7xUfI2deJU0YW7K9/Ls2Q9a6FE+3nF1vGOM+tGxt/5u/k1KH1N7YqiMwYLTSnEhUvP
         k0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869556; x=1742474356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSlQ1L6rFi2oeV1zF6QF9pposhG4AHSuAju9zq00g0c=;
        b=SoiWgqOx0WSkU3DN/eWLG6gb+5VN8c9O8PTJUAE1INfXaedzzvPpyJrR+S3naeX9DA
         BR2O38ByCFdHEdIlk+Q26mUiJ9iRUWzZ5avPck5HqVxCvKAVlss6R0eblCWEUw7SebYL
         MHEXvTzV7pEFHgqcYxG6DzAba0hA9f6VQG4B+qRoKLcFMPHXqwLP8iAxSj7Z0FPSyBnN
         oL0B9AYMPyVkSUvjksKSUOuwaSDPLqLokhXzVWK51x8kLWEGflmTm6IiNLF5WaOUcMPH
         1ogeavYeWjC+IJWQly8lfPK5pvxw/+ETRoYWFoYqkGZNMIlQyHygpjlSOnb6zWOkbB3y
         NP+A==
X-Forwarded-Encrypted: i=1; AJvYcCUwK90yniRoVn2bi13S6zuRGY7Vkuza0rj6Dyor3smCDHnjq/9E8DFSS8+mLRsj4QLE8nQR/g5yY2Q2DzWXbxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxCVUzZmbM3H1J6C/XGWe+3e/zSvvX2tv5CLNaIQ7ycT5PIc4
	bw1aU+lVBM5BRzJAqw5CyJVSXirZQBgIuLjZeCS/On5Pm+JLwrAzPg7BgWgWtwI=
X-Gm-Gg: ASbGncuTqMqBAJuA2m1TJTtCPqN/Jy33pLGXAwP+lCCNtHh1zbQNPaVy/Tr7McQED0Q
	1rdiDfD219Su4MvxA+KH2FW0hS0fQcuyxOyu1QqIUFjsxdyUFZm5qTfO7upVRKvvoFWL6Kkc1li
	MZP8tZn9+gSq0m7Q95GR4Ng04lKHUQ+3LTDLeIj17nV8bjJyRKnYEkQWYUTQF/0zqFVVBtbodVR
	FYPfsJ7W0hcCwAK6ijiNtPx+mv6FLU1eI8K1DObJY23lEsqnuvXd2AWK4+sx24uDskwPouhUylE
	YCl8VhBC+7IjCwsOWgGfAnTQ/C1VUdZOA07MxOODuDI=
X-Google-Smtp-Source: AGHT+IHljsBKLiMSwe9a9spi/guXRSlSUeFAziwYEZ2f83TIkAwW439SP28/QrmHbhabYpknI9/fAQ==
X-Received: by 2002:a5d:64ac:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-39132d228c5mr22022486f8f.17.1741869556082;
        Thu, 13 Mar 2025 05:39:16 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df33aasm1978419f8f.2.2025.03.13.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:39:15 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:39:14 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 02/17] riscv: sbi: add FWFT extension interface
Message-ID: <20250313-5c22df0c08337905367fa125@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-3-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:09PM +0100, Clément Léger wrote:
> This SBI extensions enables supervisor mode to control feature that are
> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
> DTE, etc).
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h |  5 ++
>  arch/riscv/kernel/sbi.c      | 97 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index bb077d0c912f..fc87c609c11a 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -503,6 +503,11 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>  				unsigned long asid);
>  long sbi_probe_extension(int ext);
>  
> +int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
> +			  bool revert_on_failure);
> +int sbi_fwft_get(u32 feature, unsigned long *value);
> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
> +
>  /* Check if current SBI specification version is 0.1 or not */
>  static inline int sbi_spec_is_0_1(void)
>  {
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 1989b8cade1b..256910db1307 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,6 +299,103 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +int sbi_fwft_get(u32 feature, unsigned long *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * sbi_fwft_set() - Set a feature on all online cpus

copy+paste of description from sbi_fwft_all_cpus_set(). This function
only sets the feature on the calling hart.

> + * @feature: The feature to be set
> + * @value: The feature value to be set
> + * @flags: FWFT feature set flags
> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +struct fwft_set_req {
> +	u32 feature;
> +	unsigned long value;
> +	unsigned long flags;
> +	cpumask_t mask;
> +};
> +
> +static void cpu_sbi_fwft_set(void *arg)
> +{
> +	struct fwft_set_req *req = arg;
> +
> +	if (sbi_fwft_set(req->feature, req->value, req->flags))
> +		cpumask_clear_cpu(smp_processor_id(), &req->mask);
> +}
> +
> +static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
> +				      unsigned long flags,
> +				      bool revert_on_fail)
> +{
> +	int ret;
> +	unsigned long prev_value;
> +	cpumask_t tmp;
> +	struct fwft_set_req req = {
> +		.feature = feature,
> +		.value = value,
> +		.flags = flags,
> +	};
> +
> +	cpumask_copy(&req.mask, cpu_online_mask);
> +
> +	/* We can not revert if features are locked */
> +	if (revert_on_fail && flags & SBI_FWFT_SET_FLAG_LOCK)

Should use () around the flags &. I thought checkpatch complained about
that?

> +		return -EINVAL;
> +
> +	/* Reset value is the same for all cpus, read it once. */

How do we know we're reading the reset value? sbi_fwft_all_cpus_set() may
be called multiple times on the same feature. And harts may have had
sbi_fwft_set() called on them independently. I think we should drop the
whole prev_value optimization.

> +	ret = sbi_fwft_get(feature, &prev_value);
> +	if (ret)
> +		return ret;
> +
> +	/* Feature might already be set to the value we want */
> +	if (prev_value == value)
> +		return 0;
> +
> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
> +	if (cpumask_equal(&req.mask, cpu_online_mask))
> +		return 0;
> +
> +	pr_err("Failed to set feature %x for all online cpus, reverting\n",
> +	       feature);

nit: I'd let the above line stick out. We have 100 chars.

> +
> +	req.value = prev_value;
> +	cpumask_copy(&tmp, &req.mask);
> +	on_each_cpu_mask(&req.mask, cpu_sbi_fwft_set, &req, 1);
> +	if (cpumask_equal(&req.mask, &tmp))
> +		return 0;

I'm not sure we want the revert_on_fail support either. What happens when
the revert fails and we return -EINVAL below? Also returning zero when
revert succeeds means the caller won't know if we successfully set what
we wanted or just successfully reverted.

> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * sbi_fwft_all_cpus_set() - Set a feature on all online cpus
> + * @feature: The feature to be set
> + * @value: The feature value to be set
> + * @flags: FWFT feature set flags
> + * @revert_on_fail: true if feature value should be restored to it's orignal

its original

> + * 		    value on failure.

Line 'value' up under 'true'

> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> +int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
> +			  bool revert_on_fail)
> +{
> +	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
> +		return sbi_fwft_set(feature, value, flags);
> +
> +	return sbi_fwft_feature_local_set(feature, value, flags,
> +					  revert_on_fail);
> +}
> +
>  /**
>   * sbi_set_timer() - Program the timer for next timer event.
>   * @stime_value: The value after which next timer event should fire.
> -- 
> 2.47.2

Thanks,
drew

