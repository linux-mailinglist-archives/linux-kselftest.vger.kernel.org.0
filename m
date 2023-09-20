Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FA7A74B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjITHrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjITHrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:47:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E33012B
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:46:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-402d499580dso70087165e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695196015; x=1695800815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVunG7o3B5X9vaQEWyirI9ryk0oP6Di9CEjbsBLCF3g=;
        b=fHfOiLxqkX2tSeVZEYuOcrhH248DI/1r3oPkrfSwzvCd19TsI7wsDzMRoMdD8OWrZk
         Lp9hTAsk6e7YDGOevgOjdXGrYp2urWkCafL/CUA1mjPfLQTUSEmY6zftslcJ8sRQsF2H
         DEEIHOKzogDrdEKiaXnCu6hP8e5lp6e7UWR3zeDC8aAPIE7H6rWrBRXPHXBjyhIhqJDB
         cxsxSJDrMxtaNZLu+Tfx9wlAnddAX8HOtLfmEqJ33R0a7SN/WfupE2L6/W6MzyIDtcqW
         xy6h+xttBcydarZT5XGW21tefc3CjBFu4hoGl5PGEelQcW61/q6oYkqIno0hdw95/tSZ
         +klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196015; x=1695800815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVunG7o3B5X9vaQEWyirI9ryk0oP6Di9CEjbsBLCF3g=;
        b=R9JHeDvUdaj81xBlW4yldGlgiMsCa0Tqk4HotlOg2zjuqnfGdDZw1LUA0cMv1mhrX8
         mabjewb/c+nB93bX0A/4vc4W2h6E+1oSsfJ07s3rY3GhVK9M1os7jGUhzBPqewX2dg2w
         RuD9d1en4SLcAmQOwAXZgFO9TpHjFJfteLQt4FWDgVjAtaiRXoAIFPxo/NBGPxTVmBbB
         0I2KQrfBvFY4fMbN6x9uy9g9A5w4YNg5l8vqVVOso+B5jfxxiGb061jbafpN+Pb57OSf
         5bfrCr0gb66esLhhT+DfbrujVBmDD4Oroox5prQx8KYUU4gJAvdLHas68vTEyMKIIr3o
         OVWw==
X-Gm-Message-State: AOJu0YwIlImSgNi7OsEOjwkBRu8LnyLTEzd6RJr1zDvOXMsWOqLDYXjp
        3CqNRIc8sYSbauhDkPV6N1O9Nw==
X-Google-Smtp-Source: AGHT+IGG/3UyVqZOOAbC3tloQ80fV1Kl6R8qcuyc4Oxl1dNBdENA4jwJSlr1R6ygp4yAftiTc+gUZw==
X-Received: by 2002:a05:600c:280b:b0:401:38dc:8916 with SMTP id m11-20020a05600c280b00b0040138dc8916mr1690704wmb.10.1695196014842;
        Wed, 20 Sep 2023 00:46:54 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a24-20020a05600c225800b00402d7105035sm1167853wmm.26.2023.09.20.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:46:54 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:46:53 +0200
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
Subject: Re: [PATCH 4/7] RISC-V: KVM: Allow Zicond extension for Guest/VM
Message-ID: <20230920-be44cc5bd0f749a1137d103c@orel>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919035343.1399389-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 09:23:40AM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zicond extension for Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index e030c12c7dfc..35ceb38a4eff 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZIHPM,
>  	KVM_RISCV_ISA_EXT_SMSTATEEN,
>  	KVM_RISCV_ISA_EXT_XVENTANACONDOPS,
> +	KVM_RISCV_ISA_EXT_ZICOND,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 17a847a1114b..d3ca4969c985 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -47,6 +47,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZICBOM),
>  	KVM_ISA_EXT_ARR(ZICBOZ),
>  	KVM_ISA_EXT_ARR(ZICNTR),
> +	KVM_ISA_EXT_ARR(ZICOND),
>  	KVM_ISA_EXT_ARR(ZICSR),
>  	KVM_ISA_EXT_ARR(ZIFENCEI),
>  	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
> @@ -95,6 +96,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZBB:
>  	case KVM_RISCV_ISA_EXT_ZBS:
>  	case KVM_RISCV_ISA_EXT_ZICNTR:
> +	case KVM_RISCV_ISA_EXT_ZICOND:
>  	case KVM_RISCV_ISA_EXT_ZICSR:
>  	case KVM_RISCV_ISA_EXT_ZIFENCEI:
>  	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
