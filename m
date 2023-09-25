Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311157AD9CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjIYONx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjIYONv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 10:13:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38311C
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:13:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7602742a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695651222; x=1696256022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3Y94KioZ4lUB6KTiVYafyhITdpeQDnL5Ld1MTAmwrE=;
        b=hfUBVOCFs3JQ8XJruqqfgzplqM+0J404RkIxvxayfzutmyY+gvOenIAsUzgTOoQ9o0
         YvvU44CgTV1BqgcdL/Wpp27xlxsBqT6mHtm22EO+/sDc8USVegMlDg1YDZaY1qAi/Tj4
         8Te9J7g5jZZD0Ya1m0omDV1rBCeCQj3YZmP0rM0VAmDCsVERGSeP4AMs8qq6O5NlGlOW
         kIMePhgX2nvtT1N5DMgwWWVR7jYZm8sfel2iOcAKMHeDz/353ychoNTTtEBJdK2lhSpC
         TTpEh1+xUWe28EheibJ/GWMXN3rdY9OrXF+AVhnLPp2zx3th8hcWmdZm6dHw3xNkglps
         4IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651222; x=1696256022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3Y94KioZ4lUB6KTiVYafyhITdpeQDnL5Ld1MTAmwrE=;
        b=Gn49yM4mBXLk/QfmNZzSK0jw5FlqRABL6I3ot2rs3qjTWzjGNomL6exBxfZwkJUR84
         t8YBD/R4K8j0hlTfjAiljsI28rYw+RVPmvZF1T5oB/nt/eMgagaUYsIqwN8anerDMCHw
         IvIASsvd2Lw3+dGBwMzh1/NEGLDbudBfl6uUxidW3MyPs3n/khFTIAuh45HGbY9taHxb
         IJhuWROzI4MY6ngAlkPdPSZTu2NqIER41Qt9mIqhkuIZTVuQAEGoJHz/FS43x7mHzpMv
         kgAgqYXSOGpw2NsT8MbgiKYUCx6hsATVOJj4h434drcn6ZycgoF/eKV7Mbf0F7qR734C
         pTEA==
X-Gm-Message-State: AOJu0YydCWgUfZTqmXKv9JfTINtyYQ192aYjtalTqjTXTBl1UA/72N0i
        plWZM7ypYi2jAIRQYzvJ2KoG0w==
X-Google-Smtp-Source: AGHT+IHN01Ha+0X82LArkbyFm3JD30PWtG77y/LlloFpNITht78xOEe93gDgtfpCK1tmqX0gcB9MJg==
X-Received: by 2002:aa7:c481:0:b0:52c:b469:bafd with SMTP id m1-20020aa7c481000000b0052cb469bafdmr4951595edq.41.1695651222046;
        Mon, 25 Sep 2023 07:13:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640206d200b005224d960e66sm5533135edy.96.2023.09.25.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:13:41 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:13:40 +0200
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
Subject: Re: [PATCH v2 4/9] RISC-V: Detect Zicond from ISA string
Message-ID: <20230925-434ad7cfaea0011fe0fb9989@orel>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925133859.1735879-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 07:08:54PM +0530, Anup Patel wrote:
> The RISC-V integer conditional (Zicond) operation extension defines
> standard conditional arithmetic and conditional-select/move operations
> which are inspired from the XVentanaCondOps extension. In fact, QEMU
> RISC-V also has support for emulating Zicond extension.
> 
> Let us detect Zicond extension from ISA string available through
> DT or ACPI.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b7efe9e2fa89..15bafc02ffd4 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -60,6 +60,7 @@
>  #define RISCV_ISA_EXT_ZIHPM		42
>  #define RISCV_ISA_EXT_SMSTATEEN		43
>  #define RISCV_ISA_EXT_XVENTANACONDOPS	44
> +#define RISCV_ISA_EXT_ZICOND		45
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3a31d34fe709..7f683916f2c2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -167,6 +167,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> +	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>  	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
