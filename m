Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE627A71BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjITFDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITFDW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:03:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBC95
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:03:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c8321c48fso283548f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695186193; x=1695790993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+3/wOOicjYC2xAjvdjrTiizxDM62+8wq1jD8pVAYJM=;
        b=GVKCBrVy2HKF/bepzP0e/OjjmI4zNnEwEJizGC9dZQYT1hNZReL6LKFO3fc0OdJtQ5
         cMfA++en6RbNBtGqQwM9iVbxKmDXLNmxwMa+SHZ7Y78D1LMQMp5+Ky+fQ0FVSex2VCqr
         jEuh28Q7zr99fmUiATcyFgVYapcbuctgf5BELXbcCVAGwBYLHS/qZEu5QlHSUoz6Nypm
         RgfxEq1mp2G/XUTamd5HPuvAdjHEKC18hmLSlf9CHOiIWfHICDO7PeF9KgIAu16klBrl
         zU9A2v7QsiYYlVIb2+JpjVsJJD9qUCpm2BiZvQcESjyTGOwL07BmFadDWaKa7RA8YzE5
         PQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695186193; x=1695790993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+3/wOOicjYC2xAjvdjrTiizxDM62+8wq1jD8pVAYJM=;
        b=TDqfQInxNcOSc9YuqEA3jGN4zOcV2/hmZiwqz8iuIjKiIFV/wrro1i10p1emGgNmFU
         QD0BeoRLYqx6m7fd/rwOyMx/73KS12T2ILKRsLPTr1JpRRpm3kc7nu19rqzz7fIlcNI+
         nwb44f0Ql9KZUXY2MRonsxmTTQ3HwvDUMkMsg3BIX4/wQhQRYCrJq84fvxXDSVfL4yKI
         9S6esw3KNvbyxjofRlccz38/Xomao8EyR15CIFmXOyzVM1nGW6AhbnoopTY/P4VXMNdo
         8qvnvJaOhGo07CcYxMX8hSCimzquXYX3Hgc32p8at7ROp7slntItV7hTTa7cTTSL5d9U
         UQog==
X-Gm-Message-State: AOJu0Yz0Nc2keA8ldkgu9atsmZbKs/xWQduHe1l8b1pjkMBfeK/VYZeZ
        GTpb/J2Hv4UaFYRIM4WYJimC5A==
X-Google-Smtp-Source: AGHT+IES2JCsdwAJKjskK6b48tRhcrGtknKDz0H9fUak3sptmBQ8p70dRsJQ4y4NQvgiGitKUcLV4A==
X-Received: by 2002:adf:e6d1:0:b0:315:a235:8aa8 with SMTP id y17-20020adfe6d1000000b00315a2358aa8mr3313895wrm.2.1695186193391;
        Tue, 19 Sep 2023 22:03:13 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q24-20020a7bce98000000b003fbca942499sm834220wmj.14.2023.09.19.22.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:03:13 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:03:12 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT
 registers
Message-ID: <20230920-6ef044ecc94ec729f2f6ca37@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918180646.1398384-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 11:36:43PM +0530, Anup Patel wrote:
> The ISA_EXT registers to enabled/disable ISA extensions for VCPU
> are always available when underlying host has the corresponding
> ISA extension. The copy_isa_ext_reg_indices() called by the
> KVM_GET_REG_LIST API does not align with this expectation so
> let's fix it.
> 
> Fixes: 031f9efafc08 ("KVM: riscv: Add KVM_GET_REG_LIST API support")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 1b7e9fa265cb..e7e833ced91b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -842,7 +842,7 @@ static int copy_isa_ext_reg_indices(const struct kvm_vcpu *vcpu,
>  		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_ISA_EXT | i;
>  
>  		isa_ext = kvm_isa_ext_arr[i];
> -		if (!__riscv_isa_extension_available(vcpu->arch.isa, isa_ext))
> +		if (!__riscv_isa_extension_available(NULL, isa_ext))
>  			continue;
>  
>  		if (uindices) {
> -- 
> 2.34.1
>


Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
