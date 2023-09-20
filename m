Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB37A745F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjITHid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjITHiR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:38:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED99122
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:38:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4051fea48a8so6210355e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695195490; x=1695800290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zz3/ecOKh4XgsJl46wvd3sKyjYtoix9I3w8gro1wfuw=;
        b=cm0vLhfht5SysJJxneUJRJXDWefeNpW+wH2/8WrEcjg28/Usqq2r5VVb6o5oH7gHy6
         7N8eZ39T8tDSBOK1hg63PfQi7k1Wm3TtLpjgxKbk8mo2EXZ/qSIQKrRxMdJGgdz44MMp
         3cVSuNYnvWbvwUrRzujB+KGPDS5IUUsoG6OjcLlfwwGYd8mH2xHm5AXbQno8qxpT/V/P
         XWVY0Zy2s61i73t0tFEMY9chGCBDbCGrHyXQ1QW0UV89GM3IIYu1KxJe+JHYLLAoqx03
         X7P6n6YmUOe2u2YMFwOnxEn9X4DjJ3MI6eLq2VrzW4T+StGvTuByOsHZmEjQuefSGM+2
         65Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195490; x=1695800290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz3/ecOKh4XgsJl46wvd3sKyjYtoix9I3w8gro1wfuw=;
        b=f8Kwz+fae6xZR4oZ6PegmF4CyyyR4xHAu7j+ES77vmUo/bEJBBbMuAncWcJS/kJ0PB
         aM6GuOgk1xCSZx3sxiy/akDgLhXbQOO3Kw1KAf8AsH+HtZrQidc1ppaBbP95WMRgag4K
         2iga93zE6QiGxfJuLFORIbTUcpApNpaX1VQ9nVhoBzfL8CbF3V5VsoDlpOV7bo/JgfXf
         gnBChmqlIqbgF+725c1IBTRBwkmfXebvtznHCjmmJsbAFx5kMPNLKcj6TKrG3yyX01VV
         wIyqgumw8QSHlV1KFN/kxvHk0EcZ8svgbV3Mw6ZkXwG/XyiqfMLWGQbOD4f+bpk6QhSx
         tIwQ==
X-Gm-Message-State: AOJu0YwfJqDFXOgyCqI2Q/LNHIDbReKwMm+wf5ZRDHliy3HLPw+RRQzR
        dwoiqEgQHk/pc4ooqWnFjNqPRA==
X-Google-Smtp-Source: AGHT+IHTqEA03iyluOTE5KNwlZAgRLI+hQhb/1jCFIbu1+TPY1ZpietUNW+El8NpgjOI/gBNn23OCQ==
X-Received: by 2002:a05:600c:2909:b0:401:2ee0:754a with SMTP id i9-20020a05600c290900b004012ee0754amr1614112wmd.13.1695195489693;
        Wed, 20 Sep 2023 00:38:09 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b004052093a8f6sm1176515wms.25.2023.09.20.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:38:09 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:38:03 +0200
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
Subject: Re: [PATCH 1/7] RISC-V: Detect XVentanaCondOps from ISA string
Message-ID: <20230920-ab82cd5fbac7606ba747afa4@orel>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919035343.1399389-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 09:23:37AM +0530, Anup Patel wrote:
> The Veyron-V1 CPU supports custom conditional arithmetic and
> conditional-select/move operations referred to as XVentanaCondOps
> extension. In fact, QEMU RISC-V also has support for emulating
> XVentanaCondOps extension.
> 
> Let us detect XVentanaCondOps extension from ISA string available
> through DT or ACPI.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
>  arch/riscv/include/asm/hwcap.h                          | 1 +
>  arch/riscv/kernel/cpufeature.c                          | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 36ff6749fbba..cad8ef68eca7 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -171,6 +171,13 @@ properties:
>              memory types as ratified in the 20191213 version of the privileged
>              ISA specification.
>  
> +        - const: xventanacondops
> +          description: |
> +            The Ventana specific XVentanaCondOps extension for conditional
> +            arithmetic and conditional-select/move operations defined by the
> +            Ventana custom extensions specification v1.0.1 (or higher) at
> +            https://github.com/ventanamicro/ventana-custom-extensions/releases.
> +
>          - const: zba
>            description: |
>              The standard Zba bit-manipulation extension for address generation
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0f520f7d058a..b7efe9e2fa89 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -59,6 +59,7 @@
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
>  #define RISCV_ISA_EXT_SMSTATEEN		43
> +#define RISCV_ISA_EXT_XVENTANACONDOPS	44
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3755a8c2a9de..3a31d34fe709 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACONDOPS),
>  };
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> -- 
> 2.34.1
>

Besides Conor's comment about splitting the patch,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
