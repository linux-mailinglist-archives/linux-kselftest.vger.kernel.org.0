Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539E6FF79C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 18:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbjEKQkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjEKQkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 12:40:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3015256
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 09:40:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f475366522so15960535e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 May 2023 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683823207; x=1686415207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWPj+0MEcU+bJjFDLtiKhJORofVGXZE+QDk7KaJWG9E=;
        b=UuPFreN/sIyZvma3z9Xm6KxNZFcbh1TpDfsITGLUWBCWA6T4xHCFr5HuwlelWhANsc
         GODLbDYWSkjxpw1FlGH7zBZhqQl+PBnoza0HREbOpZD4TA496u22UD6bDXXczi7KYVpl
         vUHL3f5x4AXj97duCDa1dgEYjprlWsVyV+SBIS6xrVMPSwQcsV6kK8n5uf0FR6XnIuc4
         bHtcnz/0qP1iI3PLzgpdryNpdPYlDZbySxQcLGTnHTgtAXoWs5v1mwmzllg9a6m64GLt
         EJC3fIG+NQH/j+vTbDoa5wKLgeATWhDm4OwK78ppk49kTcq7mfR/nc2WNPwoATtQv89M
         LAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823207; x=1686415207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWPj+0MEcU+bJjFDLtiKhJORofVGXZE+QDk7KaJWG9E=;
        b=UIf6OtL6AUX7JrjFP5V++8vDJmGKCio6aGHRC8vXS6s6pCSO3LrVjCNfzmcBnbhZsg
         DkRNDq3HGQk8G1igV/R38V7MT4hBuxx/3SW8m/cQHFVKLDuFh01DujyBsQ4N6APVcS3r
         t8FnzHYRUumwL4ZfSxb3/7g/IgOhpetUOse5NEbJIvA2AWB+tzIrgE7SeY4boInOhASf
         ahBZrvoDZmE0ABRFssvv6IWTJedjreVYvj0PQQz06VLhEZE+r1g7LJMpVebgsrTe+vKt
         BNRkltNzbw/K7pSCT1J5Tcv7V54a4O/W0ibu34G6kZCkNHiEKveajxeCoUZt1x6vCJrt
         WoZQ==
X-Gm-Message-State: AC+VfDx1jpAkPXDKsYRiliI2WlJQCdm3UrG09yJF3br4/0E/tfnGsFty
        tK2lCGD4UdwHekurETrqO0dzEQ==
X-Google-Smtp-Source: ACHHUZ5lIBereKcBnZpJKQGjLGzbXt7Ys+TI95CPzIw7E6x8cqi52/zghFhzklOdZznlq63vKEcQWg==
X-Received: by 2002:a1c:f20a:0:b0:3f1:819d:d050 with SMTP id s10-20020a1cf20a000000b003f1819dd050mr15055961wmc.37.1683823206802;
        Thu, 11 May 2023 09:40:06 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f4b6bcbd8bsm4941659wmi.31.2023.05.11.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:40:06 -0700 (PDT)
Date:   Thu, 11 May 2023 18:40:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: kvm: Add KVM_GET_REG_LIST API support
Message-ID: <20230511-d0a207eebb30fc88de875e4f@orel>
References: <cover.1683791148.git.haibo1.xu@intel.com>
 <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921fc2e1a91887170e277acb1b52df57480a5736.1683791148.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 05:22:48PM +0800, Haibo Xu wrote:
> KVM_GET_REG_LIST API will return all registers that are available to
> KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
> regression issue during VM migration.
> 
> Since this API was already supported on arm64, it'd be straightforward
> to enable it on riscv with similar code structure.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  Documentation/virt/kvm/api.rst |   2 +-
>  arch/riscv/kvm/vcpu.c          | 346 +++++++++++++++++++++++++++++++++
>  2 files changed, 347 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index add067793b90..280e89abd004 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3499,7 +3499,7 @@ VCPU matching underlying host.
>  ---------------------
>  
>  :Capability: basic
> -:Architectures: arm64, mips
> +:Architectures: arm64, mips, riscv
>  :Type: vcpu ioctl
>  :Parameters: struct kvm_reg_list (in/out)
>  :Returns: 0 on success; -1 on error
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 8bd9f2a8a0b9..fb8834e4fa15 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -657,6 +657,334 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +static inline unsigned long num_config_regs(void)
> +{
> +	return sizeof(struct kvm_riscv_config) / sizeof(unsigned long);

We can't assume all config registers are present. For example,
zicbom and zicboz block size registers are only present when their
respective extensions are available.

Thanks,
drew
