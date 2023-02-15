Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB726972D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 01:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBOAuk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 19:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOAuh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 19:50:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA102BEC3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:50:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e11-20020a17090a77cb00b0022925dd66d3so247342pjs.4
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jAtu+jAzoPXgZmgX0Gm/pPUfllI1EZc5ORAFaSSbbuE=;
        b=L/+DzgtP0mxJhAdZ5Z/aVaM/bV88j5aAGhM00slMCuZIfD+STsib8GLR0j1uVV3RGR
         dtA3VBBk5jqr92WFuvac+vtWgHA9axC9yGsdotN1s2zvptok+vXYQTN9VdjbJUigRS3O
         2jZY5F7cgm/oyxFyh78x1KjMGS84KKZlOUGs6YwT05zphD47TUJZoNMNMn1v+XLRjeSK
         rSh8mZTOHGk2MfbxNhVhiYQK3lh4+2xmCp2uAw2N1A6T0rO/ZsTPr+kcEit0Z/bi8vDo
         Q2uYusX/6wxTlJTAAVRHOiWXIGmZtT5M0QHuzbFHJE61DGFFaGulvIopfgOxvaWpLaaP
         39lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAtu+jAzoPXgZmgX0Gm/pPUfllI1EZc5ORAFaSSbbuE=;
        b=J/kEXJ9nYJt/K2okgHMt2hUWDaZLlGrOz8h97JZ2dfxOHTaA2q5CI73mlISWmw//i1
         RylXVOWza5NWXcSANa94qc98UEi5jZ0XyTYv3QKPZr50Sldki3chlThnPwzPlaGHrcDr
         kXAVWKS/9yRwAwKwwxME29yEA1wq02b9Cx4MhKDyE1RZldxig0jwxajRbLBswXX0m1hH
         AfTcI9vs+4u0szmzq4atw8TdBp5RwW9lZib1Yh7qLjnjcw33aQg3rL+W8WddT8WiIGDH
         bgkewoSPIGlNg4iZx3SrFnZVlhqJV1TkPPirZu0TvLy+Tl4wJ6KmqHxJG7JZGHp+RlbW
         UzeA==
X-Gm-Message-State: AO0yUKX+P31GY9uRSB5BFzXn1Rx0Dy+wSuYw6PNQtp90E5FpWpV8idLr
        heOOp9jOoXNFwaMEHTBFFuGJVdSICuHMuf631w==
X-Google-Smtp-Source: AK7set/B9k2Ck9cwqCz3QkOM260/f27rO5NkJ+CBnzWZ5I7LICMI8IV8Q/zzgS1M+gU0YZA5XK2frvm7yadOvdfolw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:d908:b0:233:a844:1e9e with
 SMTP id c8-20020a17090ad90800b00233a8441e9emr272542pjv.60.1676422235601; Tue,
 14 Feb 2023 16:50:35 -0800 (PST)
Date:   Wed, 15 Feb 2023 00:50:33 +0000
In-Reply-To: <Y88ylDFfMQNcUEw7@google.com> (message from Sean Christopherson
 on Tue, 24 Jan 2023 01:21:24 +0000)
Mime-Version: 1.0
Message-ID: <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
From:   Ackerley Tng <ackerleytng@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     erdemaktas@google.com, mail@maciej.szmigiero.name,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Mon, Jan 23, 2023, Erdem Aktas wrote:
> > On Mon, Jan 23, 2023 at 10:53 AM Sean Christopherson  
> <seanjc@google.com> wrote:
> > >
> > > On Mon, Jan 23, 2023, Maciej S. Szmigiero wrote:
> > > > On 23.01.2023 19:30, Erdem Aktas wrote:
> > > > > On Fri, Jan 20, 2023 at 4:28 PM Sean Christopherson  
> <seanjc@google.com> wrote:
> > > > > >
> > > > > > On Sat, Jan 21, 2023, Ackerley Tng wrote:
> > > > > > > Some SSE instructions assume a 16-byte aligned stack, and GCC  
> compiles
> > > > > > > assuming the stack is aligned:
> > > > > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This  
> combination
> > > > > > > results in a #GP in guests.
> > > > > > >
> > > > > > > Adding this compiler flag will generate an alternate prologue  
> and
> > > > > > > epilogue to realign the runtime stack, which makes selftest  
> code
> > > > > > > slower and bigger, but this is okay since we do not need  
> selftest code
> > > > > > > to be extremely performant.
> > > > > >
> > > > > > Huh, I had completely forgotten that this is why SSE is  
> problematic.  I ran into
> > > > > > this with the base UPM selftests and just disabled SSE.   
> /facepalm.
> > > > > >
> > > > > > We should figure out exactly what is causing a misaligned  
> stack.  As you've noted,
> > > > > > the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm  
> misreading vm_arch_vcpu_add(),
> > > > > > the starting stack should be page aligned, which means  
> something is causing the
> > > > > > stack to become unaligned at runtime.  I'd rather hunt down  
> that something than
> > > > > > paper over it by having the compiler force realignment.
> > > > >
> > > > > Is not it due to the 32bit execution part of the guest code at  
> boot
> > > > > time. Any push/pop of 32bit registers might make it a 16-byte
> > > > > unaligned stack.
> > > >
> > > > 32-bit stack needs to be 16-byte aligned, too (at function call  
> boundaries) -
> > > > see [1] chapter 2.2.2 "The Stack Frame"
> > >
> > > And this showing up in the non-TDX selftests rules that out as the  
> sole problem;
> > > the selftests stuff 64-bit mode, i.e. don't have 32-bit boot code.
> >
> > Thanks Maciej and Sean for the clarification. I was suspecting the
> > hand-coded assembly part that we have for TDX tests but  it being
> > happening in the non-TDX selftests disproves it.

> Not necessarily, it could be both.  Goofs in the handcoded assembly and  
> PEBKAC
> on my end :-)

I figured it out!

GCC assumes that the stack is 16-byte aligned **before** the call
instruction. Since call pushes rip to the stack, GCC will compile code
assuming that on entrance to the function, the stack is -8 from a
16-byte aligned address.

Since for TDs we do a ljmp to guest code, providing a function's
address, the stack was not modified by a call instruction pushing rip to
the stack, so the stack is 16-byte aligned when the guest code starts
running, instead of 16-byte aligned -8 that GCC expects.

For VMs, we set rip to a function pointer, and the VM starts running
with a 16-byte algined stack too.

To fix this, I propose that in vm_arch_vcpu_add(), we align the
allocated stack address and then subtract 8 from that:

@@ -573,10 +573,13 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,  
uint32_t vcpu_id,
         vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
         vcpu_setup(vm, vcpu);

+       stack_vaddr += (DEFAULT_STACK_PGS * getpagesize());
+       stack_vaddr = ALIGN_DOWN(stack_vaddr, 16) - 8;
+
         /* Setup guest general purpose registers */
         vcpu_regs_get(vcpu, &regs);
         regs.rflags = regs.rflags | 0x2;
-       regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
+       regs.rsp = stack_vaddr;
         regs.rip = (unsigned long) guest_code;
         vcpu_regs_set(vcpu, &regs);
