Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70985A89EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIAAqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIAAqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 20:46:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35BE97E0;
        Wed, 31 Aug 2022 17:46:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v4so14920441pgi.10;
        Wed, 31 Aug 2022 17:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=hVUDBmAm8ghtBWsJyFWWPpx9AOLq04Rjhtv04IS+LAE=;
        b=KkhaBQQLRgaV9ZczziOecu+Xs+rhwwll/IJzTX19g2xivKtRYZJtM8Q0W7jEwxrt+K
         Ykvxa5OYoMZ03ztdeDBKJvGA2xobgv/RxH9DfWlHJ3LbXNtlZ6mJ3/BGNKwbp488Lfu6
         FGfhSKw6gA+QMWDQ0MhjM9sMfu0yqWjbCR14Or+gXeohOxpyQRnr7cexhKhbGZt9xFu+
         feZFCHPuc4jNv/NJoi6E7cJJsWZv+82rvctAH/ofQicG/5QkmM0gdDtzow1PSmw9wHIi
         4hgl61KgWjpPMHsOKZiE1c8DDnaD+IeyWW/5Q4PAgYmjIX1pmY0u4ezvYCIF5P4insrv
         t8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=hVUDBmAm8ghtBWsJyFWWPpx9AOLq04Rjhtv04IS+LAE=;
        b=BSJoWggM20aLIKpxUKRSCohKKv7Akr9WS20wjWtxTcRWmUGMv5iA/cH4q021rwQmgs
         sLSvnwi50++ug9J/oUBe/gIIUeiki/AB/SP2HSOtk5cqehGMXqMR0dlypP9llI7/sgFE
         DEkP3LpW1+rFwANiSv3Cjqq6OLPfEMZbY4sb98M/E+WeVvnajjMFavYqOuJk3vzSxzDx
         FuTSsFBsuvJKBQWrgpM6Llx9F5wyPWbNmvUvunInpROi8m9x1QtUXTrBTT5+Zty3RlAM
         LgocL7OImy2Tc/RUHqnc84AsyXLbCBVX+4nwG/Z6Pw85rt/lpmnlEDdX0cadZnfmi9/4
         5YXQ==
X-Gm-Message-State: ACgBeo1ROi2DmNFu7KD2uOciVHSGP/6PPyNwp3EV7nD4aNJjyPcYQLt2
        bQtRahL1OZsX7kDkUfVoy4c=
X-Google-Smtp-Source: AA6agR7n6Cs/4GNYEYUbQFQwGHzVEtICF+tay1Z22HLpsobG0RBA8mK4KCLwmvjDJmsGPmrpMJIF5g==
X-Received: by 2002:a63:2cc6:0:b0:41c:5f9c:e15c with SMTP id s189-20020a632cc6000000b0041c5f9ce15cmr23641691pgs.241.1661993193126;
        Wed, 31 Aug 2022 17:46:33 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709029a0b00b00172bd7505e6sm12181964plp.12.2022.08.31.17.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:46:32 -0700 (PDT)
Date:   Wed, 31 Aug 2022 17:46:31 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sagi Shahar <sagis@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [RFC PATCH v2 03/17] KVM: selftest: Adding TDX life cycle test.
Message-ID: <20220901004631.GC2711697@ls.amr.corp.intel.com>
References: <20220830222000.709028-1-sagis@google.com>
 <20220830222000.709028-4-sagis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830222000.709028-4-sagis@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 10:19:46PM +0000,
Sagi Shahar <sagis@google.com> wrote:

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
> index 61b997dfc420..d5de52657112 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
> @@ -51,6 +51,12 @@
>  #define _PAGE_RW            (1UL<<1)       /* writeable */
>  #define _PAGE_PS            (1UL<<7)       /* page size bit*/
>  
> +#define TDX_INSTRUCTION_IO 30
> +
> +#define TDX_SUCCESS_PORT 0x30
> +#define TDX_IO_READ 0
> +#define TDX_IO_WRITE 1
> +
>  #define GDT_ENTRY(flags, base, limit)				\
>  		((((base)  & 0xff000000ULL) << (56-24)) |	\
>  		 (((flags) & 0x0000f0ffULL) << 40) |		\
> @@ -83,4 +89,147 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
>  			  size_t guest_code_size,
>  			  uint64_t guest_code_signature);
>  
> +/*
> + * Generic TDCALL function that can be used to communicate with TDX module or
> + * VMM.
> + * Input operands: rax, rbx, rcx, rdx, r8-r15, rbp, rsi, rdi
> + * Output operands: rax, r8-r15, rbx, rdx, rdi, rsi
> + * rcx is actually a bitmap to tell TDX module which register values will be
> + * exposed to the VMM.
> + * XMM0-XMM15 registers can be used as input operands but the current
> + * implementation does not support it yet.
> + */
> +static inline void tdcall(struct kvm_regs *regs)
> +{
> +	asm volatile (
> +			"mov %13, %%rax;\n\t"
> +			"mov %14, %%rbx;\n\t"
> +			"mov %15, %%rcx;\n\t"
> +			"mov %16, %%rdx;\n\t"
> +			"mov %17, %%r8;\n\t"
> +			"mov %18, %%r9;\n\t"
> +			"mov %19, %%r10;\n\t"
> +			"mov %20, %%r11;\n\t"
> +			"mov %21, %%r12;\n\t"
> +			"mov %22, %%r13;\n\t"
> +			"mov %23, %%r14;\n\t"
> +			"mov %24, %%r15;\n\t"
> +			"mov %25, %%rbp;\n\t"
> +			"mov %26, %%rsi;\n\t"
> +			"mov %27, %%rdi;\n\t"
> +			".byte 0x66, 0x0F, 0x01, 0xCC;\n\t"
> +			"mov %%rax, %0;\n\t"
> +			"mov %%rbx, %1;\n\t"
> +			"mov %%rdx, %2;\n\t"
> +			"mov %%r8, %3;\n\t"
> +			"mov %%r9, %4;\n\t"
> +			"mov %%r10, %5;\n\t"
> +			"mov %%r11, %6;\n\t"
> +			"mov %%r12, %7;\n\t"
> +			"mov %%r13, %8;\n\t"
> +			"mov %%r14, %9;\n\t"
> +			"mov %%r15, %10;\n\t"
> +			"mov %%rsi, %11;\n\t"
> +			"mov %%rdi, %12;\n\t"
> +			: "=m" (regs->rax), "=m" (regs->rbx), "=m" (regs->rdx),
> +			"=m" (regs->r8), "=m" (regs->r9), "=m" (regs->r10),
> +			"=m" (regs->r11), "=m" (regs->r12), "=m" (regs->r13),
> +			"=m" (regs->r14), "=m" (regs->r15), "=m" (regs->rsi),
> +			"=m" (regs->rdi)
> +			: "m" (regs->rax), "m" (regs->rbx), "m" (regs->rcx),
> +			"m" (regs->rdx), "m" (regs->r8), "m" (regs->r9),
> +			"m" (regs->r10), "m" (regs->r11), "m" (regs->r12),
> +			"m" (regs->r13), "m" (regs->r14), "m" (regs->r15),
> +			"m" (regs->rbp), "m" (regs->rsi), "m" (regs->rdi)
> +			: "rax", "rbx", "rcx", "rdx", "r8", "r9", "r10", "r11",
> +			"r12", "r13", "r14", "r15", "rbp", "rsi", "rdi");
> +}

Sometimes compiler (my gcc is (Ubuntu 11.1.0-1ubuntu1~20.04) 11.1.0) doesn't like
clobering the frame pointer as follows. (I edited the caller site for other test.)

   x86_64/tdx_vm_tests.c:343:1: error: bp cannot be used in ‘asm’ here

I ended up the following workaround.  I didn't use pushq/popq pair because
I didn't want to play with offset in the stack of the caller.


diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index aa6961c6f304..8ddf3b64f003 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -122,7 +122,11 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
  */
 static inline void tdcall(struct kvm_regs *regs)
 {
+       unsigned long saved_rbp = 0;
+
        asm volatile (
+               /* gcc complains that frame pointer %rbp can't be clobbered. */
+                       "movq %%rbp, %28;\n\t"
                        "mov %13, %%rax;\n\t"
                        "mov %14, %%rbx;\n\t"
                        "mov %15, %%rcx;\n\t"
@@ -152,6 +156,8 @@ static inline void tdcall(struct kvm_regs *regs)
                        "mov %%r15, %10;\n\t"
                        "mov %%rsi, %11;\n\t"
                        "mov %%rdi, %12;\n\t"
+                       "movq %28, %%rbp\n\t"
+                       "movq $0, %28\n\t"
                        : "=m" (regs->rax), "=m" (regs->rbx), "=m" (regs->rdx),
                        "=m" (regs->r8), "=m" (regs->r9), "=m" (regs->r10),
                        "=m" (regs->r11), "=m" (regs->r12), "=m" (regs->r13),
@@ -161,9 +167,10 @@ static inline void tdcall(struct kvm_regs *regs)
                        "m" (regs->rdx), "m" (regs->r8), "m" (regs->r9),
                        "m" (regs->r10), "m" (regs->r11), "m" (regs->r12),
                        "m" (regs->r13), "m" (regs->r14), "m" (regs->r15),
-                       "m" (regs->rbp), "m" (regs->rsi), "m" (regs->rdi)
+                       "m" (regs->rbp), "m" (regs->rsi), "m" (regs->rdi),
+                       "m" (saved_rbp)
                        : "rax", "rbx", "rcx", "rdx", "r8", "r9", "r10", "r11",
-                       "r12", "r13", "r14", "r15", "rbp", "rsi", "rdi");
+                         "r12", "r13", "r14", "r15", "rsi", "rdi");
 }

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
