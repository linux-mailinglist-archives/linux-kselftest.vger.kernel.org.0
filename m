Return-Path: <linux-kselftest+bounces-10871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B98D411D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57FC2895B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EB1CB32F;
	Wed, 29 May 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Hr1zRBtU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBB1A0B06
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020525; cv=none; b=hL2vw2p1Oms17D+6nFCL2JB3MFXqUI6gNlSlmINHEac39UCfRyn0+9M/ndQtRBmvpwEeAd68YI3wsuiHFJPPDm3X4YbP1HfPDs40RepxwZKmG1j7E3A9S5VTnTGVY2ngoHaOpj4F2+9UzyglLZL+hg27Mqh7j3Tcxj197ZCMfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020525; c=relaxed/simple;
	bh=E9cC9YBfnRBR3Uz0I+4AkqOzYtSqq1o71OLZJ27uiMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch1SS8Q44sLIAemTu11HhzwHA+9vpKzVNYjf9O5qQZU/u75iArNYr1Dhz29ZRxaqB/+kwAvTwyOb02T6YOnq+hO2GQd6hlWS30J+lT4prvmbjymw4sMCyGAAaHYBtJz77HU1oq62ZHGrrsewWTQ/yRmCIsatWwrjSlkej8PpKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Hr1zRBtU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so241451b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717020522; x=1717625322; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RdCGT44mhuV5q5NuFAR9fXiN471X1L/TiMRJsZFqU8M=;
        b=Hr1zRBtUzGh0r7/9P95krkrlLsWI53kOVbfFbglQCOvtvTUiIuufLK3/GdJ3bgl9RE
         S3GvkhjXz6JluXHe7cg4xH6kza9MQOfrpnhe2uYqi7GRbYgf/4tA0tFgVvRSkfJxYB2Q
         RN4d8lq+QKEi/u0OQq36BrovCbs1y5W5jSMDq6Q65iChhh8YUckWBx3KRDY3ZHdTJJNh
         MimwDmQynpVX4U5v+bBpbcp325/7QIzUdrZYZ0D5E3aTHZVILXL6W1SLVgW9bg4YdvqY
         icd1HFfVdPMcgR+OXkYAubH3ejLw5JiMpIMIPr+/VUBcuoeq3cysve4cq+GoUdcv9tUo
         HXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020522; x=1717625322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdCGT44mhuV5q5NuFAR9fXiN471X1L/TiMRJsZFqU8M=;
        b=NUS9hIKUUe3YWamBWMcVMFkUuQRctRooWzaMbY1zYRa2uXBXZzm0A13XjPLM5x60ZB
         4/J1bFytjup0WOnxI67AIflMRDQQJwV7CZLM0GLqR43QMSDtgdwVuLnrbk4yBymcXR6t
         epPB4R2PJwVlsEAq9/Atb36Avo+tzBs5A5GUMssIOOszzRVE4ajv4TYnLBh7ea0mpPSP
         HWD+ZTF1iGknSkFoJsq5ZProYX1TYTbJ41TlX2Lw9SnL9yfrDCswzH2YIj7OLUIKaeFr
         EsqYbH/sUKBzwfRVt20qSg1u0QAQv4xyVAIqD55Ewgi5dk25aNewq1hmSKhHvXtoVSUc
         f1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOuAzi7c7nN/tgwwkbAAnuNJ0aVyd8XhbTM7E4V4TesdemRKPdhXLwRUM2iZGoikEzDOH22l40gokCJ7yTxnv9ohHWZuo82/ontC60tqQG
X-Gm-Message-State: AOJu0YwFtm20De0w2NvpgC3G3kuBRMAnFb0A/n2b/QQW+zy16IpI3qFC
	4BIzjl03BNvvPWLDHNW59HdG0ego0tj2tpWQdrDNAuBttyyjtvacDh8UlVG8Mps=
X-Google-Smtp-Source: AGHT+IFVbGuLQ9kLYtGQbBJcQAfO3Ny7PuBQS6jGLtBxl1ZSStjATPWV48xKuwi+JBDh4QC6bwbmFQ==
X-Received: by 2002:a05:6a20:f3a7:b0:1b0:278e:34a6 with SMTP id adf61e73a8af0-1b264636f38mr300967637.49.1717020522470;
        Wed, 29 May 2024 15:08:42 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:32f9:8d5b:110a:1952])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc3552ffsm8482750b3a.80.2024.05.29.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:08:42 -0700 (PDT)
Date: Wed, 29 May 2024 15:08:39 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 02/16] riscv: add ISA extension parsing for Zimop
Message-ID: <ZlenZ+NvXxOxvqEO@ghost>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517145302.971019-3-cleger@rivosinc.com>

On Fri, May 17, 2024 at 04:52:42PM +0200, Clément Léger wrote:
> Add parsing for Zimop ISA extension which was ratified in commit
> 58220614a5f of the riscv-isa-manual.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 1f2d2599c655..b1896dade74c 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -80,6 +80,7 @@
>  #define RISCV_ISA_EXT_ZFA		71
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
> +#define RISCV_ISA_EXT_ZIMOP		74

Since my changes for removing xandespmu haven't landed here yet I think
you should keep RISCV_ISA_EXT_XANDESPMU in the diff here and make
RISCV_ISA_EXT_ZIMOP have a key of 75. Palmer can probably resolve the
conflicting keys when these two series are merged.

- Charlie

>  
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 2993318b8ea2..41f8ae22e7a0 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -241,6 +241,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
>  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


