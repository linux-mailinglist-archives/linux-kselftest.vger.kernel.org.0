Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A9766940
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjG1Jt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjG1Jt0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:49:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6B35A2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 02:49:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso2563443a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690537753; x=1691142553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5nn0TL8ozMkfbttvB6kE7ZxMnlIo+EeJgK/9n8Mj1I=;
        b=gACLxCuQCEdu51w5VdhqNvVqjzISdVkvlBLeYLgdbaG++mxGSCdtdqms/zahddtjDi
         j0swRIun2wRShaOvnaf+KJtHxVBLMBAy+i/Ge80sFlOEt9wsFA63xc/mDWcyGjpq2JUI
         qbn10cgJWzEGQaljXx/EQImIsEBlXmq32QKDgrx368aaSED44YsEtr2B0tLz9452dkzM
         XFEefqxSqwwuL8g7g/r3nirycyUq5MNoherWPm4I+L1JFLxm6DQYSgpkG9Wz4t4Kf3p4
         KSVA0GDbMRnCMeiOnPKc6zLCdQmICLmt+RWoDujl1leVv/QmLV+UMJPjwH1PxcTJoIzG
         Rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537753; x=1691142553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5nn0TL8ozMkfbttvB6kE7ZxMnlIo+EeJgK/9n8Mj1I=;
        b=lo/EX5nWJyts1lTn9SjKhrpA5bjJ/pnI+bxSp9vLRiiXKPF3PGmGRg6mzg8uB3CsTU
         Hou+z2Q88wSyqfuZXm7kmGOn0LtN9qHg88bzBhCOgqRjWsXojfv/HysLXgfnRWqWI5CR
         eZXfA9Xtu5iy6MDF3VLeeIVyG0dEiue80OQRSZDo4FJgk/tnEwfXYQdlSp3ok6uCtCaB
         BPNM88fyHvQvBu66nLiP8XWlXjZ4RBrdP1cm85njwrZiODUsSyVjAtT5SDQbwFA+H3Wn
         JYYfHPpehjPkU+ab47KcGCkGHuCIflRNiw1qtNtgMslCU+i3oVbqsjoJis9N63HQ6kwU
         oMcw==
X-Gm-Message-State: ABy/qLa1cCUvb6zt8PEH+76UjadAcZaGpPiQvr3aAoSqDC1NCbwJQ2q+
        xpUSKUcSe/olIRcbH/ipXjCTWg==
X-Google-Smtp-Source: APBJJlGIFiMF31MKWtUHTgKLxY7INzVOjVfUymee39P/mxUdaq/c7lBnWza5/439Jb5NZ2SKbZZTFA==
X-Received: by 2002:aa7:c0d4:0:b0:522:303c:2f8c with SMTP id j20-20020aa7c0d4000000b00522303c2f8cmr1136476edp.6.1690537752939;
        Fri, 28 Jul 2023 02:49:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7d49a000000b0051dfa2e30b2sm1604860edr.9.2023.07.28.02.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:49:12 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:49:11 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vipin Sharma <vipinsh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Add guest helper to get vcpu
 id
Message-ID: <20230728-42019a78766a59dc5abdd412@orel>
References: <cover.1690364259.git.haibo1.xu@intel.com>
 <36b5837e9e94465dd2b7d7a17bb84dea082f2ffa.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b5837e9e94465dd2b7d7a17bb84dea082f2ffa.1690364259.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 03:20:07PM +0800, Haibo Xu wrote:
> Add guest_get_vcpuid() helper to simplify accessing to per-cpu
> private data. The sscratch CSR was used to store the vcpu id.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
>  tools/testing/selftests/kvm/lib/riscv/processor.c     | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 9ea6e7bedc61..ca53570ce6de 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -165,4 +165,6 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg3, unsigned long arg4,
>  			unsigned long arg5);
>  
> +uint32_t guest_get_vcpuid(void);

I'd also put this prototype somewhere common.

> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index f1b0be58a5dc..b8ad3e69a697 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -316,6 +316,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.sp), stack_vaddr + stack_size);
>  	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
>  
> +	/* Setup scratch regiter of guest */

typo: register

The comment above is pretty useless since it just states what the code
states, but with even less information, since it doesn't state how the
sscratch register is getting set up. I'd either drop it or write it
as

 /* Setup sscratch for guest_get_vcpuid() */

> +	vcpu_set_reg(vcpu, RISCV_CSR_REG(sscratch), vcpu_id);
> +
>  	/* Setup default exception vector of guest */
>  	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
>  
> @@ -424,3 +427,8 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, void (*handler)(struct ex_r
>  
>  	handlers->exception_handlers[1][0] = handler;
>  }
> +
> +uint32_t guest_get_vcpuid(void)
> +{
> +	return csr_read(CSR_SSCRATCH);
> +}
> -- 
> 2.34.1
>

Thanks,
drew
