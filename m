Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99737A71BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjITFE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:04:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B09C
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:04:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32003aae100so297747f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695186290; x=1695791090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEB/+sTWkenU048pGBgzJ6Jvl2oPst1aTirG4EAC08Q=;
        b=c4Mhub7CG2DD2s6gB6JguiV5OcQmz4rzU3Y7d+8jodqz+fet/S6GsoxbBF9fpzhxQa
         jhTUChLsjXUkwXTyXInqPbSynLtwZWOVsS7QCfBQnuQaR60oK5Cm+qZfTQdeUpplC8le
         lSYqCiDhbVROIRANGllmTj86SiZ7tT9a4OGAHQrsfhA9uXEvwiSL/cJIP6lArDZ+yU4L
         aGrVjG1N4kiWinxQC7IG0B3gIK7xZbO43Apesp+gc52iHXP+bfIaV/CufKvhsP0xVfQe
         8PatSAM4MGyK6GB/KOmTIq+alcSE3ZdPyL6kMLNQe4FCHBewGLHyGKzXX7VWi8u5t3IG
         jWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695186290; x=1695791090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEB/+sTWkenU048pGBgzJ6Jvl2oPst1aTirG4EAC08Q=;
        b=ktRLN3GOHbN4WHB+Yuh/A6efl1KtmO66BBqgeD8x7ELdOE3aO1/GGUpgmpSQmCK4zT
         N1vNeoJDO3NuXVbB71CwRXY3uMyEA055w7poT63wHKpQzFId9kWSc+ECFYybCeyYZEb2
         trZQWhxJ1uKQij+1N3zGLAsWVpEWGL10v3Pt8hJ3ViAuO/ZhtPwIS+e5Xn30K6DFfzLM
         +cJgYkaWPnOh4oqkTcgXaQ7I+IjxuA4UbOiNU0q7ghWM/4gGTbQhZwn8i8Vjg1gPLx1o
         KdKWjmi/s4dcRLi6y0muPlbu8D7oySdWfauGG9lO7cjm0OuiB9RoXhCxYyDnUbOwuZAx
         UPBg==
X-Gm-Message-State: AOJu0YyXLxHXPk9j0U4sVHPThsioRwPe5WUpvXAbPmiTNvk4dGO1tJ1n
        tWTLnZrrLciidPjNN7ZJZfokeg==
X-Google-Smtp-Source: AGHT+IHXyPOuAuTi8aEkKO3moX8fQpaU0lfGW1nRZkQaf15yWDuJBf3mHzKEV7pGHCYUkUS0KuWetQ==
X-Received: by 2002:adf:fad2:0:b0:31f:f8a7:a26c with SMTP id a18-20020adffad2000000b0031ff8a7a26cmr889677wrs.25.1695186290202;
        Tue, 19 Sep 2023 22:04:50 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b003177074f830sm15881840wrc.59.2023.09.19.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 22:04:49 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:04:48 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for
 missing extensions
Message-ID: <20230920-baeb582c4f56bc5c59e23086@orel>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
 <20230918180646.1398384-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918180646.1398384-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 18, 2023 at 11:36:44PM +0530, Anup Patel wrote:
> The riscv_vcpu_get_isa_ext_single() should fail with -ENOENT error
> when corresponding ISA extension is not available on the host.
> 
> Fixes: e98b1085be79 ("RISC-V: KVM: Factor-out ONE_REG related code to its own source file")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index e7e833ced91b..b7e0e03c69b1 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -460,8 +460,11 @@ static int riscv_vcpu_get_isa_ext_single(struct kvm_vcpu *vcpu,
>  	    reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
>  		return -ENOENT;
>  
> -	*reg_val = 0;
>  	host_isa_ext = kvm_isa_ext_arr[reg_num];
> +	if (!__riscv_isa_extension_available(NULL, host_isa_ext))
> +		return -ENOENT;
> +
> +	*reg_val = 0;
>  	if (__riscv_isa_extension_available(vcpu->arch.isa, host_isa_ext))
>  		*reg_val = 1; /* Mark the given extension as available */
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
