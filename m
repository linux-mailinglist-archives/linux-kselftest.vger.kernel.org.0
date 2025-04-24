Return-Path: <linux-kselftest+bounces-31552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A388A9AE1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783504A1059
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691DA27C877;
	Thu, 24 Apr 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nI2wKPbP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4027B517
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499466; cv=none; b=k2ta7/hLymTGlnzl5xqPw/yme9WyPkcfTrhg3XG+CBdnSpeLPKwVSbBiy5GATfmnH0Kv6enkfi6hmnaP8DHm48iDL8r1TThnCWUOhO+52UE21N8GJ27QPPYXupHaCkbEjIcUKCqR9wBdqmnCBZpvtX/0j14dHqDG/xkIc+A0NqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499466; c=relaxed/simple;
	bh=reTdbb+6O0sXBwedeFukDBYju2S+gng4mftDGCp7r68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/2QRdZVIV9MfitLd1GvatQgfmR6P0rD6lQGM8NAfIv4JMmGWFh5e7pku16HcQdYbxUobvlJHaVpevIF1Du4d9Pa+eTl0BKPgEfLolTLMUXQCUa8DfS2t757JqrMKSsPGjvIvVzfM/LZUJgY5SZiSnjfDxq4m+7fujUaAA79xcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nI2wKPbP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso604968f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745499461; x=1746104261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPQSBVtSMsvYsAl+gZRdiR2fvyhUD5u3wJ4ZqhPNu8A=;
        b=nI2wKPbPDt/hA2aXCHz+p57vALDN2e0hpjTHegksYqxT2aEG28AMjyogp5hLa/Se7J
         RvMfNz+b/RK0nTGxhlIWSa9mUUQCwCjv1UaOAm4gBFxAscrFmuRqNUDXmsIO/BEfEbqa
         xPgRj74zkANoWWlSUcFp1weo3fvKoFhAkgSlQV6ZqY4XkxNKS8AW88ToTpcs74wRtf6N
         y+u+JySzY/KXJl0fmBuovbx+mL7K5497jTjUbj6HnczAvxg50JIDFLl80A9dSapQzSxF
         Dt0IVrBcAC3fZmvjDj1Ik3cB4QINSqsHPaf7F1tGy8JBh5+Y6fBc3d1N3vhbyHDQGcuR
         PhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499461; x=1746104261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPQSBVtSMsvYsAl+gZRdiR2fvyhUD5u3wJ4ZqhPNu8A=;
        b=pOTFdT6keyuBKLKqNxNOU9M01g4NVpwpGr2vFUEWsIFjYsCI102UXXGnG3gw86ytXM
         44vXYyFcI1Jldk1nSpr9f5iArcFcClQfY9ngXhHg+fqEGtcw/BEiqEbrxqNMdyCyZ0t1
         lmFMG9QiL3ljQD2CY1R778GSMrtnwik6NNFkS9nGJEE8iYMqYzcYIcNVQDAxEJivkPVB
         NXj7BOkzYsqp97Exfgim3crwc+4mS+UWhXJ0SYz8CwU8ThtnNAN1tnSY0Ba7MfIsu3vn
         Xv3IaiHMRnCJmCasIAVyLaxMas+co13J2MvG0KEE39Xgm6ZeDKGTgZClpWyEVlZTtLnY
         Quzg==
X-Forwarded-Encrypted: i=1; AJvYcCXQediVLg34rTdmADYXsHnryMaffyWadgJWGkaxLHkEbjD/VOmocsJHnNnH9CPBMDRTwvoPiuBsCK+P/Dju0bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T0mz+Cb8ArYqMYVFeDFkC+jSV1Aw+CPTllK2/16tajCIrBjR
	/a4t7rRggysIlE/Z3q8UTVgGc2wcl1F/wWVy4XZ6ND4/Y6T9np5A0ZyY/BvSJvY=
X-Gm-Gg: ASbGnctmgMedEktls1D2Bvx7TJQhK5WS0wUsLxpfTBNmu931pA9QrtKVD9FM2mj13sx
	rkAqQ6iJRjQJynS0dRDmhvEmT/an6Il+KdruAtY4weyisE0GeFaYmiNJ4g2Y40EjIVW6ws5Aj6c
	PRM4dV86PxqVP4aNWJ0NiL1TBtqdR9Qo87ORC1nMYCKe2X4x4DsGcuxDU5e27RzOOV091V7phWn
	qASLmn4QrEkUSjTH4YvW057Gu73p5m0mRDOkK+jxCBbQC6ntpdPURfQZo6JU5hCsiX1CH3gA/gu
	J37sePtwO0SEE6T1wl88pQosdt1X
X-Google-Smtp-Source: AGHT+IGWv3/WPoD+1AaHzmJVHKE9pYWAl7MImqfR1l23ycVK/8svQHojX4uoV4n0a06YqpUIKi6wnQ==
X-Received: by 2002:a05:6000:1e48:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3a06cf5f657mr1695750f8f.25.1745499461227;
        Thu, 24 Apr 2025 05:57:41 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d54f019sm2068909f8f.96.2025.04.24.05.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:57:40 -0700 (PDT)
Date: Thu, 24 Apr 2025 14:57:39 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v5 03/13] riscv: sbi: add FWFT extension interface
Message-ID: <20250424-dc96e54988e25abfc2bb9cf8@orel>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-4-cleger@rivosinc.com>
 <20250424-c85c9d2f189fe4470038b519@orel>
 <67e81f13-5e5e-4630-9a3f-73856b952e6e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e81f13-5e5e-4630-9a3f-73856b952e6e@rivosinc.com>

On Thu, Apr 24, 2025 at 02:32:01PM +0200, Clément Léger wrote:
> 
> 
> On 24/04/2025 13:00, Andrew Jones wrote:
> > On Thu, Apr 17, 2025 at 02:19:50PM +0200, Clément Léger wrote:
> >> This SBI extensions enables supervisor mode to control feature that are
> >> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
> >> DTE, etc). Add an interface to set local features for a specific cpu
> >> mask as well as for the online cpu mask.
> >>
> >> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >> ---
> >>  arch/riscv/include/asm/sbi.h | 17 +++++++++++
> >>  arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 74 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> >> index 7ec249fea880..c8eab315c80e 100644
> >> --- a/arch/riscv/include/asm/sbi.h
> >> +++ b/arch/riscv/include/asm/sbi.h
> >> @@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> >>  				unsigned long asid);
> >>  long sbi_probe_extension(int ext);
> >>  
> >> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
> >> +int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
> >> +			       unsigned long value, unsigned long flags);
> > 
> > I'm confused by the naming that includes 'local' and 'cpumask' together
> > and...
> > 
> >> +/**
> >> + * sbi_fwft_local_set() - Set a feature on all online cpus
> >> + * @feature: The feature to be set
> >> + * @value: The feature value to be set
> >> + * @flags: FWFT feature set flags
> >> + *
> >> + * Return: 0 on success, appropriate linux error code otherwise.
> >> + */
> >> +static inline int sbi_fwft_local_set(u32 feature, unsigned long value,
> >> +				     unsigned long flags)
> >> +{
> >> +	return sbi_fwft_local_set_cpumask(cpu_online_mask, feature, value, flags);
> > 
> > ...that something named with just 'local' is applied to all online cpus.
> > I've always considered 'local' functions to only affect the calling cpu.
> 
> Yeah I thought of that as well, local here refers to the fact that this
> function applies for a local feature (as described in the SBI
> documentation) but agreed that it's really missleading. Any idea for a
> better naming ?

I'd drop 'local' from these names and when we deal with global features we
can add 'global' to their function names. If we really must have something
now, then maybe 'per_cpu' instead of 'local'.

Thanks,
drew

