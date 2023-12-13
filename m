Return-Path: <linux-kselftest+bounces-1852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7451811B4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A5F1F2196D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3657336;
	Wed, 13 Dec 2023 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="D4TjJmic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D35100
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 09:36:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so50030045e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702488984; x=1703093784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nar7AGpkKCMY3vU9wBOjKXihyoMWUwSDoyGxla1FSMU=;
        b=D4TjJmicgwyiuxU/0EQRMLlqFgwKB643M+Ls0ZrdgfTQzDGPaGC1+l7UiKTUp3QOIb
         x99r8Tj1EMoiw66hZVfozvkOmJQGuciegH+usdnX50mw1fwPKvm3dbT4ryBibHhL66d6
         B47I+JJQf6UKoeaxkSAv3Ud8TJU8S5rclkVcf1oTRsg+Qdr5z4/dMJ+nMul+SVdwKLvG
         b2eXFTTcUMyVlEcNOZ4lQaEDl/pHOGVoRtSTsj9qoYJzVBdSOk6mFBPsxejolZHdf4Y7
         85IQ993ek78WZ0ma1S7V/wEtRYvrdQBP4KkshvfvIAJ6IQB9tvvQQ2fzvtN7KJxa+Rsr
         Zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488984; x=1703093784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nar7AGpkKCMY3vU9wBOjKXihyoMWUwSDoyGxla1FSMU=;
        b=Wh7IarZN0vXHguOGdYDT2MmriNERsmEPjk/ntoyJZpk+C48CClNfwa4Gvja+cHkfNy
         lB+krVRDZjqERrhImB9PDSdQYN+htSZakxF8DUDU07mSm3NwIm0FmRrTiG5dSq1r5BOr
         tyVX+VsZuwHG8SAEsVDtdvu9fCb2zK6CWFOtfzpkvCP2Ou7NFH72BTHa3OzH/Gzq/Orf
         4/unOxxDhJsJvKL3gCG/PNifwa2t9cTvQuLXQoOPqsLoOFCLHfeU22izkwSjRrMTzAYA
         ojRWb4CCKoRT7Hyw7UvR2CQYGcxzrHXdqPIv76VRyU93Js/f2QX+wIQYCTIn5wgij+fr
         KVfw==
X-Gm-Message-State: AOJu0YwD1cyHEaIe6NSbPp82BFAtCygCf3/539IhY+dRvKeF25MXQuU5
	+HzfYfCPhBFDx+3gGxl3H9cibQ==
X-Google-Smtp-Source: AGHT+IEK2Pp7nkWqxvEj/mdVNQpoa5hctJ9KTENrVC46QZLfOUyzk+bN6eF4FhiRrxtksDL5J5C+hw==
X-Received: by 2002:a05:600c:3590:b0:40c:2c56:4f37 with SMTP id p16-20020a05600c359000b0040c2c564f37mr4662038wmq.36.1702488984605;
        Wed, 13 Dec 2023 09:36:24 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm4720420wmq.17.2023.12.13.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:36:24 -0800 (PST)
Date: Wed, 13 Dec 2023 18:36:23 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/15] RISC-V: KVM: Allow scalar crypto extensions for
 Guest/VM
Message-ID: <20231213-1c93d927d30feb6d09739e94@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-5-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:46PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable scalar crypto extensions for
> Guest/VM. This includes extensions Zbkb, Zbkc, Zbkx, Zknd, Zkne,
> Zknh, Zkr, Zksed, Zksh, and Zkt.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 10 ++++++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 518b368b41e5..7b54fa215d6d 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -140,6 +140,16 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
>  	KVM_RISCV_ISA_EXT_ZICOND,
>  	KVM_RISCV_ISA_EXT_ZBC,
> +	KVM_RISCV_ISA_EXT_ZBKB,
> +	KVM_RISCV_ISA_EXT_ZBKC,
> +	KVM_RISCV_ISA_EXT_ZBKX,
> +	KVM_RISCV_ISA_EXT_ZKND,
> +	KVM_RISCV_ISA_EXT_ZKNE,
> +	KVM_RISCV_ISA_EXT_ZKNH,
> +	KVM_RISCV_ISA_EXT_ZKR,
> +	KVM_RISCV_ISA_EXT_ZKSED,
> +	KVM_RISCV_ISA_EXT_ZKSH,
> +	KVM_RISCV_ISA_EXT_ZKT,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index f789517c9fae..b0beebd4f86e 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -43,6 +43,9 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZBA),
>  	KVM_ISA_EXT_ARR(ZBB),
>  	KVM_ISA_EXT_ARR(ZBC),
> +	KVM_ISA_EXT_ARR(ZBKB),
> +	KVM_ISA_EXT_ARR(ZBKC),
> +	KVM_ISA_EXT_ARR(ZBKX),
>  	KVM_ISA_EXT_ARR(ZBS),
>  	KVM_ISA_EXT_ARR(ZICBOM),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
> @@ -52,6 +55,13 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZIFENCEI),
>  	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
>  	KVM_ISA_EXT_ARR(ZIHPM),
> +	KVM_ISA_EXT_ARR(ZKND),
> +	KVM_ISA_EXT_ARR(ZKNE),
> +	KVM_ISA_EXT_ARR(ZKNH),
> +	KVM_ISA_EXT_ARR(ZKR),
> +	KVM_ISA_EXT_ARR(ZKSED),
> +	KVM_ISA_EXT_ARR(ZKSH),
> +	KVM_ISA_EXT_ARR(ZKT),
>  };
>  
>  static unsigned long kvm_riscv_vcpu_base2isa_ext(unsigned long base_ext)
> @@ -94,6 +104,9 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_RISCV_ISA_EXT_ZBC:
> +	case KVM_RISCV_ISA_EXT_ZBKB:
> +	case KVM_RISCV_ISA_EXT_ZBKC:
> +	case KVM_RISCV_ISA_EXT_ZBKX:
>  	case KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_RISCV_ISA_EXT_ZICNTR:
>  	case KVM_RISCV_ISA_EXT_ZICOND:
> @@ -101,6 +114,13 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZIFENCEI:
>  	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
>  	case KVM_RISCV_ISA_EXT_ZIHPM:
> +	case KVM_RISCV_ISA_EXT_ZKND:
> +	case KVM_RISCV_ISA_EXT_ZKNE:
> +	case KVM_RISCV_ISA_EXT_ZKNH:
> +	case KVM_RISCV_ISA_EXT_ZKR:
> +	case KVM_RISCV_ISA_EXT_ZKSED:
> +	case KVM_RISCV_ISA_EXT_ZKSH:
> +	case KVM_RISCV_ISA_EXT_ZKT:
>  		return false;
>  	/* Extensions which can be disabled using Smstateen */
>  	case KVM_RISCV_ISA_EXT_SSAIA:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

