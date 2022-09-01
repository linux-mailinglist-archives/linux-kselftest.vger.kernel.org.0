Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDF5A8A84
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiIABUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 21:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiIABUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 21:20:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6181690;
        Wed, 31 Aug 2022 18:20:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 76so16103646pfy.3;
        Wed, 31 Aug 2022 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=j6hcngYlpvs5vhfu0mW47DQwHIYzAccUtyEnKVrv4bk=;
        b=Ig9Jz4jFpQYi8elhuz6NJZGp+7tykwAd+nejNRkApGgSCIGRxS9VSxgP40TfiKEoXH
         jVEGavejFbJKhMGtTtw6DgNifjj4+qZMIN+G/LNuLMf1grvfxCFz1bTjy8ZV3vyowdSv
         fhR+7g4wulbwNCcPK6RUiqXS0MdUJ6QoA27l8UJMy+5Wi4rexR/yDBcz/IrUcBkrZlvq
         oP1iDMKbU4KCvvmfrcrqwQ7rAraaU48gkzG0opBzFQSdzWGSaAhTFyTY4yAam+v6dZ+o
         xpYxDlTtusVBFCqjMWkOAZDTgaQjYjsJVqxQjWUzfGnHhEtXc52amf6gQHHeISjvtulj
         7GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=j6hcngYlpvs5vhfu0mW47DQwHIYzAccUtyEnKVrv4bk=;
        b=o84xAQ4vEnEUQecRTIk9Zlt2avPO0QxbiYBqLXr+H3FcM9Wl8Vo+4beMLTd2irWFs2
         O1zCNP/iwHUZapvfAgG1f7BwxBXp6kwpMQvG87MDH9752RYRRfrc0QAwGOfGKW/ECRRp
         P+raAAyQ4oRTicEOZ4nKyb/1E2I9FFdSx9RWPPyBrS1h36UyjORQ8+CMt58Kjushhezu
         9RXOYaaNvG0bNTpZ/HkNuXyfdfn2Ux/VAR7vJv2P05YFmLwnIUhVGfF9KN509a6IUtiD
         m1DeInJBBV1mtH3nWIwOPbUWHthjgHLBG7ZjFvpuVYWaUO9hfoKnq28Ptn7HjZ0xeFSA
         AD4A==
X-Gm-Message-State: ACgBeo2bbs3hs2SCNKyIsin3e6t3xxlkoX8gEjS8HG8h2LqCkMmF79Mf
        CrKvxG3GCgJebQDw1rwAqUE=
X-Google-Smtp-Source: AA6agR6davf04hg04CsbracjQnxa6NDVqvhJ2bCajCUXxLblO7l7GGadazUwNB0kHWiXtXbDC293Og==
X-Received: by 2002:a63:1043:0:b0:429:fd41:b7cb with SMTP id 3-20020a631043000000b00429fd41b7cbmr23574082pgq.442.1661995236799;
        Wed, 31 Aug 2022 18:20:36 -0700 (PDT)
Received: from localhost ([192.55.55.51])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b00172dd10f64fsm6473650plg.263.2022.08.31.18.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:20:36 -0700 (PDT)
Date:   Wed, 31 Aug 2022 18:20:34 -0700
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
Subject: Re: [RFC PATCH v2 02/17] KVM: selftest: Add helper functions to
 create TDX VMs
Message-ID: <20220901012034.GD2711697@ls.amr.corp.intel.com>
References: <20220830222000.709028-1-sagis@google.com>
 <20220830222000.709028-3-sagis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220830222000.709028-3-sagis@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 10:19:45PM +0000,
Sagi Shahar <sagis@google.com> wrote:

> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index f35626df1dea..2a6e28c769f2 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -8,6 +8,7 @@
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> +#include "tdx.h"
>  
>  #ifndef NUM_INTERRUPTS
>  #define NUM_INTERRUPTS 256
> @@ -641,6 +642,32 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	return vcpu;
>  }
>  
> +/*
> + * Adds a vCPU to a TD (Trusted Domain) with minimum  defaults. It will not set
> + * up any general purpose registers as they will be initialized by the TDX. In
> + * TDX, vCPUs RIP is set to 0xFFFFFFF0. See Intel TDX EAS Section "Initial State
> + * of Guest GPRs" for more information on vCPUs initial register values when
> + * entering the TD first time.
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   vcpuid - The id of the VCPU to add to the VM.
> + */
> +struct kvm_vcpu *vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpu_id)
> +{
> +	struct kvm_mp_state mp_state;
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu = __vm_vcpu_add(vm, vcpu_id);
> +	initialize_td_vcpu(vcpu);
> +
> +	/* Setup the MP state */
> +	mp_state.mp_state = 0;
> +	vcpu_mp_state_set(vcpu, &mp_state);
> +
> +	return vcpu;
> +}
> +

It's better to use symbolic value.  I know this is copied from vmx version, though.

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 3bb7dc5a55ea..4009bc926e33 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -636,7 +636,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
        vcpu_regs_set(vcpu, &regs);
 
        /* Setup the MP state */
-       mp_state.mp_state = 0;
+       mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
        vcpu_mp_state_set(vcpu, &mp_state);
 
        return vcpu;
@@ -662,7 +662,7 @@ struct kvm_vcpu *vm_vcpu_add_tdx(struct kvm_vm *vm, uint32_t vcpu_id)
        initialize_td_vcpu(vcpu);
 
        /* Setup the MP state */
-       mp_state.mp_state = 0;
+       mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
        vcpu_mp_state_set(vcpu, &mp_state);
 
        return vcpu;


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
