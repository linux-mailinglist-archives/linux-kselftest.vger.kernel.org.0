Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F357A74AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjITHrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjITHqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:46:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB6CEA
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:46:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402d499580dso70079445e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695195964; x=1695800764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCQ64axOzYWQoVJr89JJGEJBkzqcHIgukSDri2Lu2nY=;
        b=gyy/EoGYbXfyOyLpfHmDk2WWbOm9L6Zqt4sjxcvHKfTBm6XNcQ8YSz6YjLKJRGyUSJ
         c91AkGYNN/LlvPGeoNjPduIyomQsXUhY48vcfafjMUSBTZ6A0SLRO0nkPfMTmzdn+DPx
         apOLtHGVcULHy/b/KcG9CvQ9J7MFWuybFZHJ91cBojYo2OvxoT8gcBispXSV5r8+Df+Z
         EBITdzHl5MLglRy+VRQkEM5U6hVwfgLOffEFUXZE8ubWnzR8QKA1fjYqMxtSKqgKXrJ8
         ay993suO4Qh93QmcU/F9s/Hmm8u1lZWM3Wzh30RzmXuM5YRsU7H7DSH4qeRMdRP5X5Of
         JQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195964; x=1695800764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCQ64axOzYWQoVJr89JJGEJBkzqcHIgukSDri2Lu2nY=;
        b=rVYf5tMId3x5GS/6tVWfacpj2W14YhWdOVR8xlcjCw6aJVXfFnFIecK2qt2eUXb1FM
         YrbxBNWSLfU2sYDwAgAVHpxtbwrBLM8RnqTB5LpvL6ah9wmk0zoEsp3++andkat4f74o
         5ZPC+vg8b7ZGcj6jhAqFBd5F4KNvyl5U2K8ykWF5z1c17/TujkrozdWXYV5kdHWGOnS9
         aYgxzxvtghxbREkGiRgE7nNtBF8Wf7Nm3b3BZEe7lvE/iI6xgIdPjmUOAySwHMKBlZQe
         y7hvlG4gg9T7g+xnfsbCuuV0M4z7FFa2+3e71UJcYHuWVerQ5QFzJdpllk/Ts53HeFIt
         5oSg==
X-Gm-Message-State: AOJu0YyVKtuT6l9q/NJDCJVmFGH0LdT6rFBcjfdSa/XLi4z58jsgHev6
        7j154Nou6X/86ZyKdC6obacGGA==
X-Google-Smtp-Source: AGHT+IGLhZyo0JLpS7qrAayTtRpx8WJ35UC8iBDR4G+V5sBDzN/EMK5surVVEn79abyRomu1HrsACQ==
X-Received: by 2002:a7b:cd94:0:b0:401:b204:3b85 with SMTP id y20-20020a7bcd94000000b00401b2043b85mr1635240wmj.36.1695195963742;
        Wed, 20 Sep 2023 00:46:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d6045000000b0032008f99216sm10914828wrt.96.2023.09.20.00.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:46:03 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:46:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/7] RISC-V: KVM: Allow XVentanaCondOps extension for
 Guest/VM
Message-ID: <20230920-64bd7206b92e056d76cd9715@orel>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919035343.1399389-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 09:23:39AM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable XVentanaCondOps extension for
> Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index b1baf6f096a3..e030c12c7dfc 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -138,6 +138,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZIFENCEI,
>  	KVM_RISCV_ISA_EXT_ZIHPM,
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
> +	KVM_RISCV_ISA_EXT_XVENTANACONDOPS,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 388599fcf684..17a847a1114b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -40,6 +40,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SVINVAL),
>  	KVM_ISA_EXT_ARR(SVNAPOT),
>  	KVM_ISA_EXT_ARR(SVPBMT),
> +	KVM_ISA_EXT_ARR(XVENTANACONDOPS),
>  	KVM_ISA_EXT_ARR(ZBA),
>  	KVM_ISA_EXT_ARR(ZBB),
>  	KVM_ISA_EXT_ARR(ZBS),
> @@ -89,6 +90,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_SSTC:
>  	case KVM_RISCV_ISA_EXT_SVINVAL:
>  	case KVM_RISCV_ISA_EXT_SVNAPOT:
> +	case KVM_RISCV_ISA_EXT_XVENTANACONDOPS:
>  	case KVM_RISCV_ISA_EXT_ZBA:
>  	case KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_RISCV_ISA_EXT_ZBS:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
