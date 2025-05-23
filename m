Return-Path: <linux-kselftest+bounces-33671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD57AC29D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D481C06CBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116A29A33E;
	Fri, 23 May 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kx+jOfLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9946226D04
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025439; cv=none; b=RlxeNaItqa5v1c9NM/UT7h5xLZGZPVyMS230sf/ch8uBrspcUCwFT29GjcWF6baix1EzGDp9olbb9z8Hxg/g7vZygHWB73CCL/BuKJ7yUEZ52UNpIF6fZBiuQtoLlWEN+OEIquDsKhWBB0NwnF66+8S1lTS1Y65zva/Vm/xm7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025439; c=relaxed/simple;
	bh=fBP8ebQ6vsk2kNEGZF28FbWUrY3UqYBKVgD7KsehzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piDV3ZmcdEd7ooyXBXjknRMjMv9lMGKG1FvUN8bMBbH3xQzVhgNSiKXlch13uPRlPWan9Zc0krqFMUcRMO0s9CnmTxeU70lLT5ADTC9rd0jOH2CEXgZG6UHVaVoaerekV/rtlGFjXlqLhuKpXeogr0UWXUJNnxnn1LskciGnV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kx+jOfLF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2322f8afe02so1543125ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748025437; x=1748630237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+jN5GB4ngQwEolzoVEKYGux1P77VDkeV8jyjKjQj7pI=;
        b=kx+jOfLFtsQKMtUb47OqLL1G6Io3wm0pD7E2k7rrjbnweQg/NLyAIJyeEu/kyvMhBv
         UQ1hyQxVbMTH3wsGV+2Q+6nM7EDNJGEO+pJ9qNuNd+IGT+E0mANo8wBxsQINqAfnUKqb
         8j2/2v/rD0LLKsDfVorS7JYIypIIA2nuXcPKORQo3Hx5jic2lowqWYB/7eB9KUpHKm+T
         zo6U0kaN6mZ7SqNY+fYX1onRVfj7mqrHVQ/43xyGgRlZINPjp1wNXcEMhGHnSEjJt/+V
         NlkEn+Zqr8j76T1OfE/7WGXYY9+dPbFOz+/k9/YktBhvfeG3QjDvNsuKZLyp6CTcRNle
         hHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025437; x=1748630237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jN5GB4ngQwEolzoVEKYGux1P77VDkeV8jyjKjQj7pI=;
        b=vZvVFlKytmKFM20+kxqD9jT+QcpvfPxV43vYd8EZHa6TINycgfOVImcj8IKbGCB1Dc
         UyET5M6TWxUn/3aJL7A2UsQM/ktDb1Jh/FHu8dYU9Zy9p5J28g9u8JgpcbwWwPXghLWt
         BSmaTQkIiGbH26C13ev2zHu+7tLOAdayHjLqCCdLuJweGwxiu9tK96YAAv8AsionP29Z
         AbFXZGAqXk+UwoDyv2SR8pC9PPhjIRB4W1lWVc5uMQ29c1CNZEsAIBJvyX3Oci8Ae8+T
         sB0XIHKe+F2+MSPV6UPWHmn86s9LpaD/Ui35lJdECXUB6OorYBXq/2UIF1L7jLADOhrs
         56mw==
X-Forwarded-Encrypted: i=1; AJvYcCVoB7cAP5j53evnXXmCoX4OxogUJT8YWlXd5ceUiboz+igmBmjNj2YkdaIkeB+DZRdAhxAiXhTAr5Kf9JZCOjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfHEE1hbEftJ+uVTBApPBkps0imy6I8dp9pt7TQBpzVYH7d12
	92ZGP9enLs6xxyyxdjNd8H+xs/lb1KlodxKVBS+SpM7A2kkyF9elP6qFIHUg3F1LQ+8=
X-Gm-Gg: ASbGncuI76DND+u+iKDNCeiAS5yCTJojICnnwZSZ1/Ez9G1mOny1I4GXjhc6pR4he7/
	RUQJUY6oBruapz754v6PXpAKzKWoufsQCBagomSfx1ifjtc4qG62tFEUHHzpI8viEjVyZ/4Rk/5
	ioYesvKu6buTtOySFM3C22GRBbTANQlGGuifuZV0d+i8SuNobsSlxeCp+bCBQN5S+1wIz9iesmE
	4e7qBFUDlvAA769+qTwQ5ccwYEWZXKGVDZYV0i65aoTMkmFBdDO/DcHD//ayYZn2AGktT23Zptj
	7UCBW39Irsn8AZCMUTWEMoM41K3DI5OyA1T7JfE0tAZuFPQ=
X-Google-Smtp-Source: AGHT+IG8tomY7/3cAclRkVBgo4GdCG/oz04LT8S0Un+srTCw4pvpQpH3EIf/46AHjipa24+aocSy/g==
X-Received: by 2002:a17:902:fc44:b0:22c:35c5:e30e with SMTP id d9443c01a7336-23414f69078mr5977735ad.13.1748025437265;
        Fri, 23 May 2025 11:37:17 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:bb2c:c7d9:9014:13ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9736esm127127745ad.149.2025.05.23.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:37:16 -0700 (PDT)
Date: Fri, 23 May 2025 11:37:14 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v8 07/14] riscv: misaligned: use on_each_cpu() for scalar
 misaligned access probing
Message-ID: <aDDAWmNlr_mzrdLm@ghost>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-8-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523101932.1594077-8-cleger@rivosinc.com>

On Fri, May 23, 2025 at 12:19:24PM +0200, Clément Léger wrote:
> schedule_on_each_cpu() was used without any good reason while documented
> as very slow. This call was in the boot path, so better use
> on_each_cpu() for scalar misaligned checking. Vector misaligned check
> still needs to use schedule_on_each_cpu() since it requires irqs to be
> enabled but that's less of a problem since this code is ran in a kthread.
> Add a comment to explicit that.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  arch/riscv/kernel/traps_misaligned.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 592b1a28e897..34b4a4e9dfca 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -627,6 +627,10 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>  {
>  	int cpu;
>  
> +	/*
> +	 * While being documented as very slow, schedule_on_each_cpu() is used since
> +	 * kernel_vector_begin() expects irqs to be enabled or it will panic()
> +	 */
>  	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>  
>  	for_each_online_cpu(cpu)
> @@ -647,7 +651,7 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>  
>  static bool unaligned_ctl __read_mostly;
>  
> -static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
> +static void check_unaligned_access_emulated(void *arg __always_unused)
>  {
>  	int cpu = smp_processor_id();
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> @@ -688,7 +692,7 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> -	schedule_on_each_cpu(check_unaligned_access_emulated);
> +	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>  
>  	for_each_online_cpu(cpu)
>  		if (per_cpu(misaligned_access_speed, cpu)
> -- 
> 2.49.0
> 

