Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FD7A74D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 09:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjITHuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 03:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjITHuW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 03:50:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06C183
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:50:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f71b25a99so6423930f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695196213; x=1695801013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7CkeCjzvtAvF0BFc3WkolXtUPqkPIzEOcb2KkTPFs0=;
        b=Elt+kzVC7E2IH0bp6reU6j/ZHuNUhA+qTEhn3dH9kd7dAAFz06uWdp01/UJUXuySeE
         b5nA7ae92GreyupW3kXnq5YbNu9o9NJhAD2adh9gFiMXPwUo081zAJAUpvfIqGFFAYto
         FgaJpAkvBZwgYkiPB8+CN0q+26+vemKFTIzcrcUnct4o4KvhBm5h6idG6fO1UxzgPx43
         AcfNNkqwjyIhb9PRxURyr6udIBY3665zvrpycU89TbQ9/+DeWaWjC/ItBLU0GBoR9LEt
         JLH/rrIBuUYrl+3t9FkBSZ1akwCXwtyfYTmC8fm6oL0gBIL4xmHGOWzgDY8hHAeE2x6K
         c06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196213; x=1695801013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7CkeCjzvtAvF0BFc3WkolXtUPqkPIzEOcb2KkTPFs0=;
        b=G/7DVc+P3maxFVG6mai/gVJmQXFfaFC1VllTHV326Gks+FEcwstl80cxSuo7UGlxfZ
         eNfp+sPG9GbQkgPaP9ZH/Gej5dxPsUlVOIJNW9VXBIHmalY+Z1SLmrA4SU3Uf8DSsTGN
         YwKAl1Y0M+PVOMMkT6OgrFCs+jlJT9Q/ncxuYM6XspZECYXtttwAvZSwie1KR3b+bSJ9
         8ZRF+irRHdtQ1w96ye+Ca1H5qRL4nzexMUoF6PZ1A2/UAvA5F0sQP8bdFDL6EQY6SLXT
         mROyZlrTIPo4qHm3Eo9rJq9PbmOnWe67KIkOQDJa0UbU0DU/jUYrTHfjJuBne3RNitLe
         hpFw==
X-Gm-Message-State: AOJu0Yz2d6D4fhN0zQDBmBZPdiwzgZLaZJ/z6gQtwfS0eDTlMW5JOC+D
        NHqw+W491KhdGsHEDQbVBIkTAw==
X-Google-Smtp-Source: AGHT+IGw1VBQZO24lqLlXFGTfo8W9hy1BjDwhuuXt9Rrtc78ra8pQJSm+b20JrGdyY74TJahcGWzCA==
X-Received: by 2002:adf:d0c8:0:b0:31f:d8b3:ea06 with SMTP id z8-20020adfd0c8000000b0031fd8b3ea06mr1576992wrh.0.1695196213173;
        Wed, 20 Sep 2023 00:50:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z8-20020a056000110800b0031f9bdb79dasm17647528wrw.61.2023.09.20.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:50:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:50:12 +0200
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
Subject: Re: [PATCH 5/7] KVM: riscv: selftests: Add senvcfg register to
 get-reg-list test
Message-ID: <20230920-a6e56a81b36f95d115efceff@orel>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-6-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919035343.1399389-6-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 19, 2023 at 09:23:41AM +0530, Anup Patel wrote:
> We have a new senvcfg register in the general CSR ONE_REG interface
> so let us add it to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 85907c86b835..0928c35470ae 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -209,6 +209,8 @@ static const char *general_csr_id_to_str(__u64 reg_off)
>  		return RISCV_CSR_GENERAL(satp);
>  	case KVM_REG_RISCV_CSR_REG(scounteren):
>  		return RISCV_CSR_GENERAL(scounteren);
> +	case KVM_REG_RISCV_CSR_REG(senvcfg):
> +		return RISCV_CSR_GENERAL(senvcfg);
>  	}
>  
>  	TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
> @@ -532,6 +534,7 @@ static __u64 base_regs[] = {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sip),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(satp),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scounteren),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(senvcfg),
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
>  	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
