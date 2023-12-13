Return-Path: <linux-kselftest+bounces-1850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79569811AAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662901C211B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C5F3BB4F;
	Wed, 13 Dec 2023 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V2pepHry"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23961F5
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 09:17:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3363880e9f3so827962f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 09:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702487820; x=1703092620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C506FxcdrW3cyYw/Gu8XEv6qnEjyNrzFxfEz8PrYaS0=;
        b=V2pepHrydbC0zouOnBsWtdNiaYBMrzlYkPFHnJVCD8qFfqvz8Rw0sGhz5h7UFTVqrw
         zNC29ppyk/blvrSTLx9xLBWXiGW+24K3DXwaSR8T2vIhg4CKGwbB3BbmLdurqzMdKVoC
         m6fcFyfpNyyIbAPPXrt6kjvrcW1S1JHr7jeP3/o/QFKfNS+uM/5iiMc6Xtu0WWrAvy1x
         jTegrUi/WEH03MA2tr/1LItpAvCqNzY91x5qK57WAn9a6WtC2H3ynjjK64SMLttRAslr
         8Nwbbsd7T7dYviUWmHx4pojGWUqlfAbbSL5y5XGAAliPsUwsYib53EOpWfkHZapbTSbB
         /e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487820; x=1703092620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C506FxcdrW3cyYw/Gu8XEv6qnEjyNrzFxfEz8PrYaS0=;
        b=P5bu2DaM0FPcaETcfnWL80aR1naXjpNPZlcoT6kwBT9txjKDD2gQEVqIlJI9Vd6C3I
         0Wjhfvh8PCz1YIDUM7IoTO0k38kIVyPgURN5o0gJwjaqUrpQob1wxFPAW2OfCCMw9mEv
         xV0rqk1GJEup23WbI6twcPdlIxLk/8Vbj1319Wb6ZOwm+CgsppFlWguLrw7rV0xOWRxx
         e25JULRzJi3G7J5hYcmB+zmE+PO1Y/536fJxeNza8eosgAbrlzBzlsaxu03wGZ42+kGR
         usug/SrIMLK4R5UG4yplAsiKyrp5Nna1yTbQoDbbTh/8cy6tvDKeKbHRadu45zvBZYMR
         DOhQ==
X-Gm-Message-State: AOJu0YwbORGezw+mk1X17jA2NJvczjd4GWvwjjpYkSsD65SIg15cxrMu
	jC+T9/SNFcAjVhu4IuXioiB32Q==
X-Google-Smtp-Source: AGHT+IEVDrfNO7CiPC4KOQpU3GVq/lmfkGprbr9y6hJhwCs4R3hB+0wxmUeWY8FRM2GIz0IX65tHbA==
X-Received: by 2002:a5d:4fc5:0:b0:336:3749:83b9 with SMTP id h5-20020a5d4fc5000000b00336374983b9mr797373wrw.108.1702487820605;
        Wed, 13 Dec 2023 09:17:00 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4a88000000b00334b302e97fsm13746137wrq.96.2023.12.13.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:17:00 -0800 (PST)
Date: Wed, 13 Dec 2023 18:16:59 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/15] RISC-V: KVM: Allow Zbc extension for Guest/VM
Message-ID: <20231213-73671e24dacd8ae821943638@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-3-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:44PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zbc extension for Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 60d3b21dead7..518b368b41e5 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZIHPM,
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
>  	KVM_RISCV_ISA_EXT_ZICOND,
> +	KVM_RISCV_ISA_EXT_ZBC,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index f8c9fa0c03c5..f789517c9fae 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -42,6 +42,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SVPBMT),
>  	KVM_ISA_EXT_ARR(ZBA),
>  	KVM_ISA_EXT_ARR(ZBB),
> +	KVM_ISA_EXT_ARR(ZBC),
>  	KVM_ISA_EXT_ARR(ZBS),
>  	KVM_ISA_EXT_ARR(ZICBOM),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
> @@ -92,6 +93,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_SVNAPOT:
>  	case KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_RISCV_ISA_EXT_ZBB:
> +	case KVM_RISCV_ISA_EXT_ZBC:
>  	case KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_RISCV_ISA_EXT_ZICNTR:
>  	case KVM_RISCV_ISA_EXT_ZICOND:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

