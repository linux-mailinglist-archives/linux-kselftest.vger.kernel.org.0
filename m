Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C769B2BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBQS57 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 13:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBQS56 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 13:57:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787AE27D41
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 10:57:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q10-20020a056902150a00b0091b90b20cd9so1011103ybu.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ysoRUQ2NmWRIM1ClHrF/cO9hSIq1YGVMNf9jCB9BrVw=;
        b=XAPGbj1IByG6uK7uszQdQg3mPW1GPtzcnx3PltocNfok0FAlbTJlsiDAtzlIeANIPf
         fO2PGyc+1Yrrr2iQHRJW1uG6plUGdQdUFZdCoMktOdc0lrM4jZTG1ohm/QcXXfI0hadv
         GtSjObwkGPmR/5cmQDt3zcFhFwX/rJosVDD0EAT9ImJR7gmAI+3gxCVTZ8M0qdxRwYC3
         mpYa/AmsasfbqcrLw0gP5GIq3H/m/nm1y44alb3SATCtSy/9O92SkQhlDKNyD8yPY2fZ
         mzRt1yhz3anLtW7OUvVwGK6v/mqys+iSrS1zfYC1LaCUTjwjWjv1z5EvAE4H0uNtGHXv
         1Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysoRUQ2NmWRIM1ClHrF/cO9hSIq1YGVMNf9jCB9BrVw=;
        b=zsdSHcSYm3WpyJf2x9r3xluUk6ntlBJZp9JiawqpmapbfujAYVNurci5kF7OoHIpNd
         NPljRGaZRfwa0Jyi6uAp8mtSeSrkOvElBIMk8tO1/cqdW66LGdUPa7RvYI9EPEV11P0L
         LIuJKirVlbzov95Zf6DWhgl5HB+tHyxGqGnBa3wi1geSBWeYPpdROXlbmhBZVAislBDP
         r3GsAlcLVZuEhxUcT/woMoNdSqlEXOUzqkjei4eEkbGN5wPfgPeo2h0L3nINN3mMbeis
         MB6xG6kzYgWslEL/xzGb2evygZIK/kIlvYLFqnl32M1h84whKLex0vedLfIoBcGGb+gc
         /WsQ==
X-Gm-Message-State: AO0yUKXCiQPQkwG/AomTly1dmxuUDhXIlrr0mdWq2nBjokQkjGcAWtlg
        cYQZbS0qqpFB4ub8oUXfLycYOOi70i5ifTOQRA==
X-Google-Smtp-Source: AK7set/7cglHBHgHgMHXJGb2yqkYii4BdyONKgmYXXDpOWww80xi2p3bOZiV1Yk3Wn70LTN5dPgXnzFYFaZNy7W5Iw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1443:b0:8bd:4ab5:18f4 with
 SMTP id a3-20020a056902144300b008bd4ab518f4mr497438ybv.6.1676660275638; Fri,
 17 Feb 2023 10:57:55 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:57:54 +0000
In-Reply-To: <Y+1bom6CMFeNGWmm@google.com> (message from Sean Christopherson
 on Wed, 15 Feb 2023 14:24:34 -0800)
Mime-Version: 1.0
Message-ID: <diqzy1owjf0t.fsf@ackerleytng-cloudtop.c.googlers.com>
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


> > I figured it out!
> >
> > GCC assumes that the stack is 16-byte aligned **before** the call
> > instruction. Since call pushes rip to the stack, GCC will compile code
> > assuming that on entrance to the function, the stack is -8 from a
> > 16-byte aligned address.
> >
> > Since for TDs we do a ljmp to guest code, providing a function's
> > address, the stack was not modified by a call instruction pushing rip to
> > the stack, so the stack is 16-byte aligned when the guest code starts
> > running, instead of 16-byte aligned -8 that GCC expects.
> >
> > For VMs, we set rip to a function pointer, and the VM starts running
> > with a 16-byte algined stack too.
> >
> > To fix this, I propose that in vm_arch_vcpu_add(), we align the
> > allocated stack address and then subtract 8 from that:
> >
> > @@ -573,10 +573,13 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm  
> *vm,
> > uint32_t vcpu_id,
> >         vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> >         vcpu_setup(vm, vcpu);
> >
> > +       stack_vaddr += (DEFAULT_STACK_PGS * getpagesize());
> > +       stack_vaddr = ALIGN_DOWN(stack_vaddr, 16) - 8;

> The ALIGN_DOWN should be unnecessary, we've got larger issues if  
> getpagesize() isn't
> 16-byte aligned and/or if __vm_vaddr_alloc() returns anything but a  
> page-aligned
> address.  Maybe add a TEST_ASSERT() sanity check that stack_vaddr is  
> page-aligned
> at this point?

> And in addition to the comment suggested by Maciej, can you also add a  
> comment
> explaining the -8 adjust?  Yeah, someone can go read the changelog, but I  
> think
> this is worth explicitly documenting in code.

> Lastly, can you post it as a standalone patch?

> Many thanks!

Thanks Maciej and Sean, I've made the changes you requested and posted
it as a standalone patch at
https://lore.kernel.org/lkml/32866e5d00174697730d6231d2fb81f6b8d98c8a.1676659352.git.ackerleytng@google.com/
