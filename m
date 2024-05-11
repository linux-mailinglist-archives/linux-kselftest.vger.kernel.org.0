Return-Path: <linux-kselftest+bounces-10064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E77CA8C2CB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FE5285874
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4B16F852;
	Fri, 10 May 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZukMQaic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056816F26B
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380659; cv=none; b=ehVNWRNLEwjKc7Iaj2BXTxGqYTAF2V7uFaQGGWnVv9DqwPZ3qvQfKJi6exr/EAT1UdkooyqHpDZkq8eJsF+rfIfiAnJOiCZS1L/J72orlMyMD3TSB7loeOWk4SrrbTo/Pp4RHwz5iBWgayEM68z3kpBs3ZZ6tpkSCzTg4+/u4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380659; c=relaxed/simple;
	bh=wobe15RjhUSDH31IbITVWLdEsPp+yLOS2z+C1pm0ppY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMxnEXF+Yg+9wXtZ87kLvQ3KLJ6Ppp4FKNHrzzLNPhehZ8LrYwYNL7N0eR9W8XURu9v957bDKIuuvAUJA1t/iwCC+BYycoee1mbOmYQB+TaY1JgBSxlb/gkzbxNSKzC3RgeKyql6QoM9Sfu8mpVTPnT2oTxGuSNkabaDx1nKSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZukMQaic; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1487489a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715380657; x=1715985457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1oyif5LMXmv9cfSzvfL4iA3+1faWOlQLzQAOhWAAfQ=;
        b=ZukMQaicrjcDLhOy+w1nmyl7io/LTWVtTvA0cBYagohIsuO1/ELqAIKOhzPk9kBkEF
         TD4TgRhoTZueLZgWERN6gUMj+UkTQcx+gzx3FVoEqrAonNiVwN1xFEjdgFsZc4zkz0G7
         lNfSeIlZf89xedmoH3SHFI8P2uQFX9U0dPRpHD0g4EHp6yzZndnlCVx6boEPad6JITpw
         iwILaA24BoO6JUMLRZDa9H/h2fj7o27OcIe6svCxiPKUjs6m99ckY/3LPa5moxxLKbjw
         WwruF+0FpW8YTzUaFdCWsd89iMWpVygKCs9I6y38NLYIdKI/woBzBYy7avM2QqobZwPZ
         T/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380657; x=1715985457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1oyif5LMXmv9cfSzvfL4iA3+1faWOlQLzQAOhWAAfQ=;
        b=OLvLCd4skkI7X+85QiW36+nGv6GSqOil6fdi4pNKAeVhz2+EIYERFuIUh2qvzeWDpz
         Ww6Ne7nd+mncXaYhE709KSsGYmbfLmIP4H5foO9vcYcxXZA39rQak09Hun7r4kD90hiM
         SrX0xEitTFiI5yJa7jRZ7umQRL3Gs7rjdQQq7vOjegdAG4APddRR6H+9yuyAlvU7QTOe
         Elvktlzyvtqe+T7aIhZH08zrkL46b/qAgFbmF+GKwVt1b77jQ2ybRaQqkv9DIwpgYjrR
         7ONrXgazswjRsExuXO1G/athq4uw2jzmweYMiLRh/BD2erUcSVrhlBUA+Ifxu1cRR3bw
         zTmw==
X-Forwarded-Encrypted: i=1; AJvYcCUpI3rvZWpuKFzK8eMqLvwFlVh7zIb6NQREm0MVFs9CBrc3NkLMplDNEupWUBrKEGwTzLSJbbGAFieuz6QFKqOzZTJut+fxrcR1UhkKxs2y
X-Gm-Message-State: AOJu0YzHLTiezidOp7rtZZfykfamniERZJuwKa5i94QDPw6neTLglRK5
	WfF+UgaFbxAMzQ1ygYilIAB74fNgHA4+irWn50pRsERySzVN8TQ8SosNDlnvHr4=
X-Google-Smtp-Source: AGHT+IF+cB/VeeNmDI2ko+dsDxMtMfecI39OIzLFhWWIUSbrZvt3Adce25QglCrrCpHnBQogkCEnLA==
X-Received: by 2002:a05:6a20:1053:b0:1a9:22cc:3ed4 with SMTP id adf61e73a8af0-1afde0a993fmr4462882637.6.1715380657060;
        Fri, 10 May 2024 15:37:37 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886b72fsm5609203a91.31.2024.05.10.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:37:36 -0700 (PDT)
Date: Fri, 10 May 2024 15:37:32 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 06/29] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Message-ID: <Zj6hrE30e3yd0bf4@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-7-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-7-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:34:54PM -0700, Deepak Gupta wrote:
> zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
> menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
> while senvcfg controls enabling for U/VU mode.
> 
> zicfilp extension extends *status CSR to hold `expected landing pad` bit.
> A trap or interrupt can occur between an indirect jmp/call and target
> instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
> that when supervisor performs xret, `expected landing pad` state of CPU can
> be restored.
> 
> zicfiss adds one new CSR
> - CSR_SSP: CSR_SSP contains current shadow stack pointer.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index bbd2207adb39..3bb126d1c5ff 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -18,6 +18,15 @@
>  #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
>  #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
>  
> +/* zicfilp landing pad status bit */
> +#define SR_SPELP	_AC(0x00800000, UL)
> +#define SR_MPELP	_AC(0x020000000000, UL)
> +#ifdef CONFIG_RISCV_M_MODE
> +#define SR_ELP		SR_MPELP
> +#else
> +#define SR_ELP		SR_SPELP
> +#endif
> +
>  #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
>  #define SR_FS_OFF	_AC(0x00000000, UL)
>  #define SR_FS_INITIAL	_AC(0x00002000, UL)
> @@ -196,6 +205,8 @@
>  #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
>  #define ENVCFG_CBZE			(_AC(1, UL) << 7)
>  #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
> +#define ENVCFG_LPE			(_AC(1, UL) << 2)
> +#define ENVCFG_SSE			(_AC(1, UL) << 3)
>  #define ENVCFG_CBIE_SHIFT		4
>  #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
>  #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
> @@ -216,6 +227,11 @@
>  #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
>  #define SMSTATEEN0_SSTATEEN0_SHIFT	63
>  #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
> +/*
> + * zicfiss user mode csr
> + * CSR_SSP holds current shadow stack pointer.
> + */
> +#define CSR_SSP                 0x011
>  
>  /* symbolic CSR names: */
>  #define CSR_CYCLE		0xc00
> -- 
> 2.43.2
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


