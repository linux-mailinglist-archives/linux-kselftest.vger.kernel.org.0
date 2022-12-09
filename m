Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F26489A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 21:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIUpN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 15:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIUpM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 15:45:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D2ABA35
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Dec 2022 12:45:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w23so6080927ply.12
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Dec 2022 12:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrO0N2BhoytOAhhhHfUhdN91u6TruVaipT5ISV1vaYc=;
        b=f95FMmTEKSCikEYcOfIHQeZ11wft/M7xtxOLWqo9ddBFll+PEIhNuP8Altnit2pg7l
         zyRhiE+JRDfj5dB8/WxDXf1drX13fZ1eOh7rba0AIhbehJO0Y9D2Isb+V0FtO1vE8xtB
         hYMCbXb+6k8JyDHQhnThQvX/+T5zbEXkZxYWQBSqRWCBdOVJmssGwx1Y5IXZJw/6XRzs
         S3ZdcDYHIQuWdKlJwLHVsg5FbzwD0u0eYrShli67IQw7Q2mlLjgxmxsG0ncnWSJMMZVg
         KepJ3JyFSc3873pExBYAY27kO9Gx8PluA0Mbdjh+rOeLvfI90C98illSL1VVYvLRtJsW
         Xzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrO0N2BhoytOAhhhHfUhdN91u6TruVaipT5ISV1vaYc=;
        b=eSPwf9JmGDguoVX5wLnqSx/n58m4cmfiySIS9Wj94YQCbnvfBwBpkmnpQXFlL9245T
         eUAO+PV1wQfHP3EKWIyqL641rcuDFilFNeHQC1gBXdP+BSyI/Sdo4k8XSahRnUDGUonM
         +RwWXCrERvMKQRmdJIY9GMKLt6+VpEX4DECyk97wKmAkQPDpDEPFnsH8oebjgKGVgfeg
         LzYF8kP2svonvW06qju6hdumwVTPFwLnIaJLAXxvcaOyrzOd8guGgKw1NC6+9qJD2m8f
         39Sj6hgX/gYcmb3b5/cFAN60yKf1lvPXmrCeKLZws9+Nw3cMJs/E7fnUlH0uSP4gMxbp
         0FJA==
X-Gm-Message-State: ANoB5pkK4z31+ZxNk3LWNT+CgPjmkfAbde6V3j/gbIksX8GAMurAvKDi
        +qB73JQuUmHL1KLYxEy8c/ozbQ==
X-Google-Smtp-Source: AA0mqf5qINBTPYAP4qeg1UzaZ6wwLAd0BwvCi3JbF60z/oyrT5V6BtufJ7TAxCe0PKR19lvup9WOtA==
X-Received: by 2002:a05:6a20:baa3:b0:9d:c38f:9bdd with SMTP id fb35-20020a056a20baa300b0009dc38f9bddmr20370pzb.2.1670618705014;
        Fri, 09 Dec 2022 12:45:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y10-20020aa793ca000000b0057555d35f79sm1614631pff.101.2022.12.09.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 12:45:04 -0800 (PST)
Date:   Fri, 9 Dec 2022 20:45:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: selftests: Correctly initialize the VA space
 for TTBR0_EL1
Message-ID: <Y5OeTeq55OgBJbjT@google.com>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
 <20221209015307.1781352-5-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209015307.1781352-5-oliver.upton@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 09, 2022, Oliver Upton wrote:
> An interesting feature of the Arm architecture is that the stage-1 MMU
> supports two distinct VA regions, controlled by TTBR{0,1}_EL1. As KVM
> selftests on arm64 only uses TTBR0_EL1, the VA space is constrained to
> [0, 2^(va_bits)). This is different from other architectures that
> allow for addressing low and high regions of the VA space from a single
> page table.
> 
> KVM selftests' VA space allocator presumes the valid address range is
> split between low and high memory based the MSB, which of course is a
> poor match for arm64's TTBR0 region.
> 
> Add a helper that correctly handles both addressing schemes with a
> comment describing each.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---

Thanks much!  Looks awesome, especially the comment!

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  .../selftests/kvm/include/kvm_util_base.h     |  1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 49 ++++++++++++++++---
>  2 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 6cd86da698b3..b193863d754f 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -103,6 +103,7 @@ struct kvm_vm {
>  	struct sparsebit *vpages_mapped;
>  	bool has_irqchip;
>  	bool pgd_created;
> +	bool has_split_va_space;
>  	vm_paddr_t ucall_mmio_addr;
>  	vm_paddr_t pgd;
>  	vm_vaddr_t gdt;
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index a256ec67aff6..53d15f32f220 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -186,6 +186,43 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>  	       "Missing new mode params?");
>  
> +/*
> + * Initializes vm->vpages_valid to match the canonical VA space of the
> + * architecture.
> + *
> + * Most architectures split the range addressed by a single page table into a
> + * low and high region based on the MSB of the VA. On architectures with this
> + * behavior the VA region spans [0, 2^(va_bits - 1)), [-(2^(va_bits - 1), -1].
> + *
> + * arm64 is a bit different from the rest of the crowd, as the low and high
> + * regions of the VA space are addressed by distinct paging structures
> + * (TTBR{0,1}_EL1).

Oooh, they're different CR3s in x86 terminology?
