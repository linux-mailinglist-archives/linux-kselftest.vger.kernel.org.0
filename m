Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4843679FDFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjINIOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjINION (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFCA1BF9
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:14:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40472c3faadso2370745e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694679247; x=1695284047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRr1rkGuTrUN4Y1UZo1LPGic4r7SXTmbnAZytMBynRY=;
        b=R0P/bDFGGU00HRZZch80NPWNzldugmJJtHADPZkt7XB6/3lvoFKveuUIKJXhR3rLCg
         /MQ5amxjdeElvJQZgXZxdC6QmumIWEUvic5xQAGQJ2O/Njy8bche5sAFin8M03KQ5q3f
         SJcVXj4sOooBoqj1ebGKqdeKlw88EIwCZ5npkZOW3Dsu7QKVRQY0fdXELQABCn5X1jKp
         W9ONx5zCpO1ZuzCykDkZPxbywZI9MEgvy/utEK4uwGDNNW41JlvK+ghIQelw8Wul9et9
         YVRjrmj0Neqz5baQMuoiIe4kgUO+/iezAjR8kYwrvQe4lrjLBiIqgIg/OfFlfUNHuOUZ
         d8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679247; x=1695284047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRr1rkGuTrUN4Y1UZo1LPGic4r7SXTmbnAZytMBynRY=;
        b=lq7kSnti/fvcP0KimQcm/nyQy8L+cN4eLkwIqaDFYngn8dk0K6sD4t7L31sdqFE2Co
         ZOZszu23/ofFFN6xQmOFYg0q8RG38YBfKnGHpriGXh1TtH7XtJnHGkYV4gQ80brt0+eZ
         S7wj5VRGgZyEnzIJyhsQW65UUNQ0+Cb5JGSNzB436KhxP9GU+WWsy3UFKuA/PeYxtz4c
         8VsTfIaGZ8CwrEDM2H5uYAKuQG2Ty/eGSmJaiyGXFuXmOhJVhVs2xHbuMdmZrasDJ1cG
         lgs6nDVfim9NuT0n2F4Xny3lmSkexzld2p5n6X5vF+0bHmMGqWUnPQYYjo9GG86vopDW
         Wcww==
X-Gm-Message-State: AOJu0YwZRHn8dwLLOJIfIprhqMWpJhU5WDF/Ii9llQueVZr0pCF/3jOk
        6JXWt0JxlW8hDA5q/JI4IrpqPw==
X-Google-Smtp-Source: AGHT+IGh6/pw8AhCYNH7FiOWterqGvoWGNUkgu/EnsrVKnj5h5ttR15SiMKATB3tNhotsC22ECVYdA==
X-Received: by 2002:a05:600c:cc:b0:3fe:1db2:5179 with SMTP id u12-20020a05600c00cc00b003fe1db25179mr3955293wmm.19.1694679247084;
        Thu, 14 Sep 2023 01:14:07 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p6-20020a7bcc86000000b003fbdbd0a7desm4074945wma.27.2023.09.14.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:14:06 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:14:05 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/9] tools: riscv: Add header file csr.h
Message-ID: <20230914-90a562a03985a9a97afd953a@orel>
References: <cover.1694421911.git.haibo1.xu@intel.com>
 <119c9d06d64b7e4932c5f74a05af1e769cbe7da6.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119c9d06d64b7e4932c5f74a05af1e769cbe7da6.1694421911.git.haibo1.xu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 09:36:58AM +0800, Haibo Xu wrote:
> Borrow the csr definitions and operations from kernel's
> arch/riscv/include/asm/csr.h to tools/ for riscv. Since
> only 64bit was supported for RISC-V KVM selftests, add
> CONFIG_64BIT definition in kvm/Makefile to ensure only
> 64bit registers were available in csr.h.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  tools/arch/riscv/include/asm/csr.h   | 521 +++++++++++++++++++++++++++
>  tools/testing/selftests/kvm/Makefile |   3 +
>  2 files changed, 524 insertions(+)
>  create mode 100644 tools/arch/riscv/include/asm/csr.h
> 
> diff --git a/tools/arch/riscv/include/asm/csr.h b/tools/arch/riscv/include/asm/csr.h
> new file mode 100644
> index 000000000000..4e86c82aacbd
> --- /dev/null
> +++ b/tools/arch/riscv/include/asm/csr.h
...
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 0102a0297b84..89ecee2fdb73 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -222,6 +222,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  ifeq ($(ARCH),s390)
>  	CFLAGS += -march=z10
>  endif
> +ifeq ($(ARCH),riscv)
> +	CFLAGS += -DCONFIG_64BIT
> +endif

This should be a separate patch, since the "import csr.h to tools" should
be completely separate from anything else. Also, all architectures that
KVM selftests supports are 64-bit, so, as another completely separate
patch, I think we should just add CONFIG_64BIT to CFLAGS for all builds,
especially since there's a chance some of the includes the other
architectures are using may need it. Of course we'll need sign-off and
testing from the other arch maintainers.

Thanks,
drew
