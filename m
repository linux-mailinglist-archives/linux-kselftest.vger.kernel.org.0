Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F827B7870
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjJDHNC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbjJDHNC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 03:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF45B7
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696403530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogdl0KSnIs9uHB330mT8IMZQGmhaWVWoV431L0BUr2w=;
        b=OgGIMvxYexVXz46KxszoPFJHQNEHFTCIC1Mes5qXZfJQU8pL20oOFHd1E+9u3qrZfuw7YX
        gjnrwMcd3Krx6Jervdx0fGwHyVlLe0suoP15SX8tRdMCWKMB4Z4bINAU/pKjFHE2exfKS1
        BsGNTeOllkLwS+j3KMZw/A/pWNV394k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-n9jS_mPgOy-q2uT0dK1SCQ-1; Wed, 04 Oct 2023 03:11:59 -0400
X-MC-Unique: n9jS_mPgOy-q2uT0dK1SCQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c62aa0a29fso16702745ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 00:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696403518; x=1697008318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogdl0KSnIs9uHB330mT8IMZQGmhaWVWoV431L0BUr2w=;
        b=ZNoCrLxdkrr0BH3WsVJwwwq3JQlZnh2TBmEYRAzf+FzFvv3oIEYUNrXb4c4ThGcz+i
         D/s0n6lH9fOVDsoAOO7eNQ4+Q8Dds1jUXIpke0sH4jpBOskZFNbk1hNdds59/1BIAKO4
         B7+UztL8LmsfLy8AD6jXl9V7neHuAYXACu8fe4+1Kymar18+EmRcxCI0vgMz4H0m9FVK
         IRz/hDDKnPQrlzYOh1zUDnnYjapXpzZTNcwqaO8nJuTLH6mLrqHaMfTO3es4b003+M2V
         ksUSVqRkGu7LH9gKTpAojITlLOYBoNVGbindUQ0388izWt9lJ/r3wpZje7SIOP25dhpa
         5lRA==
X-Gm-Message-State: AOJu0YxuEgTixEGQVNGVhlVxGMP7vHSq+eUIPAXwj+R+i2EaLDqVPDZQ
        Z+68lQ1hIoeBcHqqw9ZghOCiFyPbxufMOtQ8xJYBXO7+wVvvOv9l6e/XYYShZybn2wDstCY+rMT
        7PkBzMQusd0otplMJiMKVavwxaX5p
X-Received: by 2002:a17:902:ba8c:b0:1c6:28f6:954a with SMTP id k12-20020a170902ba8c00b001c628f6954amr1694528pls.64.1696403518404;
        Wed, 04 Oct 2023 00:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/KWKMRn6u9ael6llbc5GIEtNFeP3dBPrSMq6zdIRSNSEh3iAJa6shAO4kYbSwC0nWEb1YQ==
X-Received: by 2002:a17:902:ba8c:b0:1c6:28f6:954a with SMTP id k12-20020a170902ba8c00b001c628f6954amr1694518pls.64.1696403518099;
        Wed, 04 Oct 2023 00:11:58 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:bd00:96e0:9a9b:ef6c:8085])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001c728609574sm2864745plh.6.2023.10.04.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 00:11:57 -0700 (PDT)
Date:   Wed, 4 Oct 2023 04:11:52 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>
Subject: Re: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
Message-ID: <ZR0QOGo5DftkRWsr@redhat.com>
References: <20230928001956.924301-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 05:19:51PM -0700, Sean Christopherson wrote:
> Rework how KVM limits guest-unsupported xfeatures to effectively hide
> only when saving state for userspace (KVM_GET_XSAVE), i.e. to let userspace
> load all host-supported xfeatures (via KVM_SET_XSAVE) irrespective of
> what features have been exposed to the guest.

Ok, IIUC your changes provide:
- KVM_GET_XSAVE will return only guest-supported xfeatures
- KVM_SET_XSAVE will allow user to set any xfeatures supported by host
Is that correct?

> 
> The effect on KVM_SET_XSAVE was knowingly done by commit ad856280ddea
> ("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0"):
> 
>     As a bonus, it will also fail if userspace tries to set fpu features
>     (with the KVM_SET_XSAVE ioctl) that are not compatible to the guest
>     configuration.  Such features will never be returned by KVM_GET_XSAVE
>     or KVM_GET_XSAVE2.
> 
> Peventing userspace from doing stupid things is usually a good idea, but in
> this case restricting KVM_SET_XSAVE actually exacerbated the problem that
> commit ad856280ddea was fixing.  As reported by Tyler, rejecting KVM_SET_XSAVE
> for guest-unsupported xfeatures breaks live migration from a kernel without
> commit ad856280ddea, to a kernel with ad856280ddea.  I.e. from a kernel that
> saves guest-unsupported xfeatures to a kernel that doesn't allow loading
> guest-unuspported xfeatures.

So this patch is supposed to fix migration of VM from a host with
pre-ad856280ddea (OLD) kernel to a host with ad856280ddea + your set(NEW).
Right?

Let's get the scenario here, where all machines are the same:
1 - VM created on OLD kernel with a host-supported xfeature F, which is not
    guest supported.
2 - VM is migrated to a NEW kernel/host, and KVM_SET_XSAVE xfeature F.
3 - VM will be migrated to another host, qemu requests KVM_GET_XSAVE, which
    returns only guest-supported xfeatures, and this is passed to next host
4 - VM will be started on 3rd host with guest-supported xfeatures, meaning
    xfeature F is filtered-out, which is not good, because the VM will have
    less features compared to boot.

In fact, I notice something would possibly happen between 2 and 3, since
qemu will run KVM_GET_XSAVE at kvm_cpu_synchronize_state() and
KVM_SET_XSAVE at kvm_cpu_exec(), which happens quite often (when vcpu stops
/ resumes for some reason).


Also, even if I got something wrong, and for some reason qemu will be able
to store the original VM xfeatures between migrations, we have the original
issue ad856280ddea was dealing with: newer machines -> older machines
migration:

1 - User gets a VM from an OLD kernel, with a newer host (more xfeatures).
2 - User migrates VM to NEW kernel, and we suppose qemu stores  original
    xfeatures (it works). Migration can occur to newer or same gen hosts.
3 - At some point, if migration is attempted to an older host (less
    xfeatures), qemu will abort the VM.

> 
> To make matters even worse, QEMU doesn't terminate if KVM_SET_XSAVE fails,
> and so the end result is that the live migration results (possibly silent)
> guest data corruption instead of a failed migration.

And this is something that really needs to be fixed in QEMU side.

> 
> Patch 1 refactors the FPU code to let KVM pass in a mask of which xfeatures
> to save, patch 2 fixes KVM by passing in guest_supported_xcr0 instead of
> modifying user_xfeatures directly.

At my current understanding of this patchset, I would not recomment merging
it, as it would introduce a lot of undesired behaviors.

Please let me know if I got something wrong, so I can review it again.

Thanks!
Leo

> 
> Patches 3-5 are regression tests.
> 
> I have no objection if anyone wants patches 1 and 2 squashed together, I
> split them purely to make review easier.
> 
> Note, this doesn't fix the scenario where a guest is migrated from a "bad"
> to a "good" kernel and the target host doesn't support the over-saved set
> of xfeatures.  I don't see a way to safely handle that in the kernel without
> an opt-in, which more or less defeats the purpose of handling it in KVM.
> 
> Sean Christopherson (5):
>   x86/fpu: Allow caller to constrain xfeatures when copying to uabi
>     buffer
>   KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}
>   KVM: selftests: Touch relevant XSAVE state in guest for state test
>   KVM: selftests: Load XSAVE state into untouched vCPU during state test
>   KVM: selftests: Force load all supported XSAVE state in state test
> 
>  arch/x86/include/asm/fpu/api.h                |   3 +-
>  arch/x86/kernel/fpu/core.c                    |   5 +-
>  arch/x86/kernel/fpu/xstate.c                  |  12 +-
>  arch/x86/kernel/fpu/xstate.h                  |   3 +-
>  arch/x86/kvm/cpuid.c                          |   8 --
>  arch/x86/kvm/x86.c                            |  37 +++---
>  .../selftests/kvm/include/x86_64/processor.h  |  23 ++++
>  .../testing/selftests/kvm/x86_64/state_test.c | 110 +++++++++++++++++-
>  8 files changed, 168 insertions(+), 33 deletions(-)
> 
> 
> base-commit: 5804c19b80bf625c6a9925317f845e497434d6d3
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 

