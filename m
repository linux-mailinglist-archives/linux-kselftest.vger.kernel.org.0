Return-Path: <linux-kselftest+bounces-29606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A651A6CA0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 13:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747A91B6299F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8E210F53;
	Sat, 22 Mar 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PGz4+vk4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B991FDE20
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645494; cv=none; b=gZfFMCgF1WaUW1XQ1Fez7CTvn3B2gjMqX04lbdFegaYKsm9WtpH4X1p1S03guRke8sdauHZVCnNj3aSLwLpkfuc2sWZGH81Mi3yQf+hnSo842wgbCkCTTP8B4/Zo7fFDncYWs23o9qZMeCOY/+Qg30FvD/muIx8u+WV9t4JWBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645494; c=relaxed/simple;
	bh=agXkiGFN3pRSirDibT3Is62w5VAOvoBQs/Nh4XJOasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n46viNT/S9dTnDL4ezU9jwleAjQF4ey0RNqn4eyGb6qBPNoMOt5LKa7MYnL8utlnl7T8jrW9c8e97gnCNN4P4i96I9U9hSpkXTs8bdCzgP9+ODc6u2HuPWBl6wQuhQ+HbHPwqmLuhYV7fMHMWfFSPDEIfxosy0qxO57pN8s05uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PGz4+vk4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso30619245e9.3
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742645490; x=1743250290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ziiq3UhvtJ6MupRnu2iXbvKb4C8ssOZnnAFtArF91s=;
        b=PGz4+vk4qiKYg/YvfMDFtT/bD+TDntuLtERDl6kymConMa2BOJsFTVh1vMAL8ThaEg
         8LNAZ2l1rflf05FZom/J4lJUUTY/F7x59XPolfRQSyICe6KBofHCzx3HafNDJqb4AZpT
         AO1EX6/lTB9n05QohCWa2AydwXLQpa6jyThh7faWGa6fGL2XbIhILLJ1/uEKeBfXz95P
         8fDMkzSatkEJJCZ1naibWBWt7ul8R7qDHsYuLeuueyHfucGun2o24hKcCr6w29n1hJsf
         anRPYGqh9OGgUCl9cK8TzAqDlHMFMN+LjUx3hulQ5lw1w9YK40bwWO8wn2BOnZdecVcO
         FO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645490; x=1743250290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ziiq3UhvtJ6MupRnu2iXbvKb4C8ssOZnnAFtArF91s=;
        b=rCgf29+8nI9TjNfJnYSUPr/EVv498GBHE79UrzwoPNbiOfNA+bLqIeHs9CSyXE9v77
         C3f7rsnHT/1CYDtlZNytyp4Ef6IlAap5u7mo04pFibMvMk3LrKg2tsZ/p03/Mk0HMukk
         sTpAGfGOgwp122ZwcgtcYgU66g9TBNbI6MSJ1xCEGC83mEKYrAh6PHm8snbLtigCGPU+
         8y9k0cyOLM2VSPYpUDBQgeA4gLUqSRDh1tVLIeD2Au/RAgHV5uUy0O9U75/EuDC3d+g3
         oSbkQL6ldk8aJU3KNnJatAGBAepo/Hsz7rE4JkDiZEDEZIT8xjcpBR8hUKPBWp4LyjcY
         D+pA==
X-Forwarded-Encrypted: i=1; AJvYcCXMpe9JyoULeEfBk8PLRTTdmWqrzQVeBW67gb76sKiXDqMhl5ChLanZzodQyHISI6m8TmdU1GOtnKf7F8yOySk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7PTUqDCyYVQZGb2lqB/Pf/bycfCgEtWO9Sr6N3Ax/jXBPz9V
	sC6sEHq8CfuhV301Yop0qipWPhP5HOoEF9geuJnfMv+BMpEeR3KGAJMQOIKhPX0=
X-Gm-Gg: ASbGncvGMZnHiofURikUWVxGnUhn3orU49IYCO0l21PyTxG2cIZaNJFCTYYDVEYv87C
	9RuNdPGiWqolDb/sY9F7zxViqvNmk0b1anbqsWto6isjUxLSuymICge8+I6e6LTKxxK0Ws0Y4HT
	WIynueHsgPIyI/KmYpvV7xf3WRC8umh6ekwLw0XOSfEXi7n265FjYtDciiWw+1+0QkH8AA6EItg
	+P3I4GFPEunqwDGScc4n23huuaVZH211aogKmKxppeNlQ1WCfSDlEqo0snCkR+zHCklokqJw/7N
	J2BGIKqaVM7cQ0rhLCD7QlyGi4LSMiLwQt1y0/wsqUy4nQQRP8z2ch42hNQbTDCX3JuINdDxvw=
	=
X-Google-Smtp-Source: AGHT+IGsHzS2CnUx6O6IJsZhddczC84GZPnNGQQkPB8/ybhQKGV2Kfjw2uDFE9TfCJR/LH0wxQtdTA==
X-Received: by 2002:a05:600c:35ca:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43d50873bedmr68826135e9.0.1742645490542;
        Sat, 22 Mar 2025 05:11:30 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fb3sm106377745e9.2.2025.03.22.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:11:29 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:11:28 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 03/18] riscv: sbi: add FWFT extension interface
Message-ID: <20250322-a87faa18fe5b54b7cb61b353@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-4-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:09PM +0100, Clément Léger wrote:
> This SBI extensions enables supervisor mode to control feature that are
> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
> DTE, etc). Add an interface to set local features for a specific cpu
> mask as well as for the online cpu mask.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 20 +++++++++++
>  arch/riscv/kernel/sbi.c      | 69 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index d11d22717b49..1cecfa82c2e5 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -503,6 +503,26 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>  				unsigned long asid);
>  long sbi_probe_extension(int ext);
>  
> +int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
> +			       unsigned long value, unsigned long flags);
> +/**
> + * sbi_fwft_local_set() - Set a feature on all online cpus
> + * @feature: The feature to be set
> + * @value: The feature value to be set
> + * @flags: FWFT feature set flags
> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> + static inline int sbi_fwft_local_set(u32 feature, unsigned long value,
> +				      unsigned long flags)
> + {
> +	 return sbi_fwft_local_set_cpumask(cpu_online_mask, feature, value,
> +					   flags);

Let flags stick out. We have 100 chars.

> + }
> +
> +int sbi_fwft_get(u32 feature, unsigned long *value);
> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
> +
>  /* Check if current SBI specification version is 0.1 or not */
>  static inline int sbi_spec_is_0_1(void)
>  {
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 1989b8cade1b..d41a5642be24 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,6 +299,75 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +/**
> + * sbi_fwft_get() - Get a feature for the local hart
> + * @feature: The feature ID to be set
> + * @value: Will contain the feature value on success
> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> +int sbi_fwft_get(u32 feature, unsigned long *value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +/**
> + * sbi_fwft_set() - Set a feature on the local hart
> + * @feature: The feature ID to be set
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
> +	atomic_t error;
> +};
> +
> +static void cpu_sbi_fwft_set(void *arg)
> +{
> +	struct fwft_set_req *req = arg;
> +	int ret;
> +
> +	ret = sbi_fwft_set(req->feature, req->value, req->flags);
> +	if (ret)
> +		atomic_set(&req->error, ret);
> +}
> +
> +/**
> + * sbi_fwft_local_set() - Set a feature for the specified cpumask

sbi_fwft_local_set_cpumask

> + * @mask: CPU mask of cpus that need the feature to be set
> + * @feature: The feature ID to be set
> + * @value: The feature value to be set
> + * @flags: FWFT feature set flags
> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> +int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
> +			       unsigned long value, unsigned long flags)
> +{
> +	struct fwft_set_req req = {
> +		.feature = feature,
> +		.value = value,
> +		.flags = flags,
> +		.error = ATOMIC_INIT(0),
> +	};
> +
> +	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
> +		return -EINVAL;
> +
> +	on_each_cpu_mask(mask, cpu_sbi_fwft_set, &req, 1);
> +
> +	return atomic_read(&req.error);
> +}
> +
>  /**
>   * sbi_set_timer() - Program the timer for next timer event.
>   * @stime_value: The value after which next timer event should fire.
> -- 
> 2.47.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

