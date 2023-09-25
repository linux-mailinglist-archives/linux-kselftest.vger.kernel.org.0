Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776A7AD9C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjIYOMU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYOMT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 10:12:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17210E
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:12:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1183812566b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695651131; x=1696255931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/rofqFh8NF2bW6Oc7Qv5lPSnTwmY73T4eLOI12vOJ8=;
        b=mQn2Hr1cGI80tnYHcV1zdCjADXujIc7XLlZT8kL4pZTetrnydLOzMGg+q1U02UeNGZ
         dl/FOb5LYO3ctf02RzInwA507XQg9mSRCBVJpyRALqyzkP4zfns3Jdh3zD68XK5JTUeh
         /1rG+6Mo9p/O3wPGSX814LVB7fbi66SuNHkukb+k6JkD4zcqvNrheo3ccKWQS6pErwR8
         D45HqaxNTWzdStQbmypiqECDjOEuNgx+pC6SRUJCnUjjuocAsanKaTWEe+yhkvqRFjQ7
         50+y6tLGM/Iq30bMU1V49J8nCVZLgGOq13R+5IHeys8fyaSXUJzB821rgKNjaoUxknAJ
         jmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651131; x=1696255931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/rofqFh8NF2bW6Oc7Qv5lPSnTwmY73T4eLOI12vOJ8=;
        b=lQ5z518ScB8SRcsd12d3a287eFkHTc/n3Dy5f/NDQ5drdj0AdKkcoM+bsWh9yUiKVA
         mhsF/kPg4XciQr8FdCx3kRYgRJb33eApUk0+E6KFJp6kibeb1uKGFGP6VgbIiSPOvBOz
         /qbDCTFfeaAlZmuYkZ5YtNO/kJJkVwX1vuXDqqL0VE1A9yA0VqPjEC7BNBP41LbVrj2x
         SAJYjmcHRoyO2hnc+ANAQlA9nEYt0t648Nj4RYPOfKdqw5u9zPM9JAszki2P38bvF9IX
         7i6DWo/jru8SW4r5lPyecwJ/jeELX9wldnfyRNBeAeVfy7fpKTdTUieLKZuofz8INVb/
         qpVA==
X-Gm-Message-State: AOJu0YzN+2qhzpmvpoKkf7iPFs4CCKYaC0wCwoaxWTA3s9xT10O0osR3
        biouH9ce6HKfj1nChCl1GlWgpw==
X-Google-Smtp-Source: AGHT+IFc1y5XpN3d0KtV5nTRC/Wd4d8VRWVBVtMw1jlx1Qoo6mIZn+OlkXm+iBDkHp3bx2ipX7q9qQ==
X-Received: by 2002:a17:906:768f:b0:9ae:4a8b:fe2f with SMTP id o15-20020a170906768f00b009ae4a8bfe2fmr11054575ejm.11.1695651131376;
        Mon, 25 Sep 2023 07:12:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id sa21-20020a170906edb500b009add084a00csm6314532ejb.36.2023.09.25.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:12:10 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:12:10 +0200
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
Subject: Re: [PATCH v2 3/9] dt-bindings: riscv: Add Zicond extension entry
Message-ID: <20230925-4a65c32623adcdf50c496005@orel>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925133859.1735879-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925133859.1735879-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 07:08:53PM +0530, Anup Patel wrote:
> Add an entry for the Zicond extension to the riscv,isa-extensions property.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index cad8ef68eca7..3f0b47686080 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -225,6 +225,12 @@ properties:
>              ratified in the 20191213 version of the unprivileged ISA
>              specification.
>  
> +        - const: zicond
> +          description:
> +            The standard Zicond extension for conditional arithmetic and
> +            conditional-select/move operations as ratified in commit 95cf1f9
> +            ("Add changes requested by Ved during signoff") of riscv-zicond.
> +
>          - const: zicsr
>            description: |
>              The standard Zicsr extension for control and status register
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

