Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372D44847F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 19:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiADSgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiADSgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 13:36:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE7C061761;
        Tue,  4 Jan 2022 10:36:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z9so82018105edm.10;
        Tue, 04 Jan 2022 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZE5U0vM24EpvrhbcMYz6etgOBCEzcX+TELpWaNM7ER0=;
        b=bZTKsOtT0SR13Cw2XIVqRkCVT0V/TME94gCx0uguPkDbFsxe6SEWfawmaJYTUz5BQY
         dehvditKiugSxP5f8OOcChyLs6Mx25OqWSUkp8IlbnCaIsuJsXxZZQiBT4u4mSdXZUE6
         F+HthoqB0uTNP/AxkOP0yx1QSi7B81nMf+JdBly7chyr2KG2NBOLHrS2mrWfYBPI+6bB
         uRJkagDVHm8aaJDpRQjmO+QshyC+5mefmZaA1UqlZr6tYaSr5hp3I6YZ/Pe0gxeJU7at
         LU6VW2WimkD8U0xkzwfXffhFcQQpYBh/XtQcBmDO9Wa3mdWHo9RU2/4WrRzX8NUwOSwS
         B88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZE5U0vM24EpvrhbcMYz6etgOBCEzcX+TELpWaNM7ER0=;
        b=q26fEQBMQLWYlQgjzEOTfVtKr3sHxK81Gy458DvAWr46vEdR6xxwQ8mTXYhjfPnt1C
         UhdcQ+l+il03jFr/F83KEKb5Of+n2w+YXWHe85HNc/zHXVt7WN8FW6n08lcp+wp899se
         Pe8EHZ5lsx5ZWsuzNgjAdZ2LWK41d2DBuWKt56UmWwyO+I4yiI2j6+ylYrDvbm5tMT3h
         mDy2tr/k4Oyz/pptIPHXTzG/kGhMv06lxUzDMC4TrI2G7brpZmoXpq4V9QOfABw0WuLt
         rTpZPk1WiOrl9W3GI8CdQ03u7hJJ47GsTzeyG7Vc8m9smjW3qPZ3oHUyR462UUFbDeHy
         TR3g==
X-Gm-Message-State: AOAM532MgMaUXfvjM2PFOYvqn12NPpXHCxqc8j/HYuzrr2QM42NTd1lO
        8nURpl5op0eFt3pa7OYwgUo=
X-Google-Smtp-Source: ABdhPJyeZEb01hhLiVti+YB+CYU1jAKYTcmhM6awaH7CMwFWUcMsajOTi6vNFmWidl5GhvOTYaO4/w==
X-Received: by 2002:a17:906:eb04:: with SMTP id mb4mr39189145ejb.27.1641321410431;
        Tue, 04 Jan 2022 10:36:50 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id z22sm213115edd.68.2022.01.04.10.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:36:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <d43887b6-630c-446e-caee-dcbaa72f2466@redhat.com>
Date:   Tue, 4 Jan 2022 19:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 00/21] AMX Support in KVM
Content-Language: en-US
To:     Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
References: <20211229131328.12283-1-yang.zhong@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/29/21 14:13, Yang Zhong wrote:
> Highly appreciate for your review. This version mostly addressed the comments
> from Sean. Most comments are adopted except three which are not closed and
> need more discussions:
> 
>    - Move the entire xfd write emulation code to x86.c. Doing so requires
>      introducing a new kvm_x86_ops callback to disable msr write bitmap.
>      According to Paolo's earlier comment he prefers to handle it in vmx.c.

Yes, I do.

>    - Directly check msr_bitmap in update_exception_bitmap() (for
>      trapping #NM) and vcpu_enter_guest() (for syncing guest xfd after
>      vm-exit) instead of introducing an extra flag in the last patch. However,
>      doing so requires another new kvm_x86_ops callback for checking
>      msr_bitmap since vcpu_enter_guest() is x86 common code. Having an
>      extra flag sounds simpler here (at least for the initial AMX support).
>      It does penalize nested guest with one xfd sync per exit, but it's not
>      worse than a normal guest which initializes xfd but doesn't run
>      AMX applications at all. Those could be improved afterwards.

The thing to do here would be to move 
MAX_POSSIBLE_PASSTHROUGH_MSRS/MAX_DIRECT_ACCESS_MSRS from VMX/SVM to 
core code.  For now we can keep the flag.

>    - Disable #NM trap for nested guest. This version still chooses to always
>      trap #NM (regardless in L1 or L2) as long as xfd write interception is disabled.
>      In reality #NM is rare if nested guest doesn't intend to run AMX applications
>      and always-trap is safer than dynamic trap for the basic support in case
>      of any oversight here.

Sean was justifying this with lack of support for nested AMX, but I'm 
not sure actually what is missing at all.  That is, an L1 hypervisor 
could expose AMX to L2, and then an L2->L0->L2 exit/reentry would have 
to trap #NM.  Otherwise it would miss an XFD_ERR update.

So the patches look good now.

Paolo

> (Jing is temporarily leave for family reason, Yang helped work out this version)
> 
> ----
> v3->v4:
>    - Verify kvm selftest for AMX (Paolo)
>    - Move fpstate buffer expansion from kvm_vcpu_after_set_cpuid () to
>      kvm_check_cpuid() and improve patch description (Sean)
>    - Drop 'preemption' word in #NM interception patch (Sean)
>    - Remove 'trap_nm' flag. Replace it by: (Sean)
>      * Trapping #NM according to guest_fpu::xfd when write to xfd is
>        intercepted.
>      * Always trapping #NM when xfd write interception is disabled
>    - Use better name for #NM related functions (Sean)
>    - Drop '#ifdef CONFIG_X86_64' in __kvm_set_xcr (Sean)
>    - Update description for KVM_CAP_XSAVE2 and prevent the guest from
>      using the wrong ioctl (Sean)
>    - Replace 'xfd_out_of_sync' with a better name (Sean)
> 
> v2->v3:
>    - Trap #NM until write IA32_XFD with a non-zero value (Thomas)
>    - Revise return value in __xstate_request_perm() (Thomas)
>    - Revise doc for KVM_GET_SUPPORTED_CPUID (Paolo)
>    - Add Thomas's reviewed-by on one patch
>    - Reorder disabling read interception of XFD_ERR patch (Paolo)
>    - Move disabling r/w interception of XFD from x86.c to vmx.c (Paolo)
>    - Provide the API doc together with the new KVM_GET_XSAVE2 ioctl (Paolo)
>    - Make KVM_CHECK_EXTENSION(KVM_CAP_XSAVE2) return minimum size of struct
>      kvm_xsave (4K) (Paolo)
>    - Request permission at the start of vm_create_with_vcpus() in selftest
>    - Request permission conditionally when XFD is supported (Paolo)
> 
> v1->v2:
>    - Live migration supported and verified with a selftest
>    - Rebase to Thomas's new series for guest fpstate reallocation [1]
>    - Expand fpstate at KVM_SET_CPUID2 instead of when emulating XCR0
>      and IA32_XFD (Thomas/Paolo)
>    - Accordingly remove all exit-to-userspace stuff
>    - Intercept #NM to save guest XFD_ERR and restore host/guest value
>      at preemption on/off boundary (Thomas)
>    - Accordingly remove all xfd_err logic in preemption callback and
>      fpu_swap_kvm_fpstate()
>    - Reuse KVM_SET_XSAVE to handle both legacy and expanded buffer (Paolo)
>    - Don't return dynamic bits w/o prctl() in KVM_GET_SUPPORTED_CPUID (Paolo)
>    - Check guest permissions for dynamic features in CPUID[0xD] instead
>      of only for AMX at KVM_SET_CPUID (Paolo)
>    - Remove dynamic bit check for 32-bit guest in __kvm_set_xcr() (Paolo)
>    - Fix CPUID emulation for 0x1d and 0x1e (Paolo)
>    - Move "disable interception" to the end of the series (Paolo)
> 
> This series brings AMX (Advanced Matrix eXtensions) virtualization support
> to KVM. The preparatory series from Thomas [1] is also included.
> 
> A large portion of the changes in this series is to deal with eXtended
> Feature Disable (XFD) which allows resizing of the fpstate buffer to
> support dynamically-enabled XSTATE features with large state component
> (e.g. 8K for AMX).
> 
> There are a lot of simplications when comparing v2/v3 to the original
> proposal [2] and the first version [3]. Thanks to Thomas and Paolo for
> many good suggestions.
> 
> The support is based on following key changes:
> 
>    - Guest permissions for dynamically-enabled XSAVE features
> 
>      Native tasks have to request permission via prctl() before touching
>      a dynamic-resized XSTATE compoenent. Introduce guest permissions
>      for the similar purpose. Userspace VMM is expected to request guest
>      permission only once when the first vCPU is created.
> 
>      KVM checks guest permission in KVM_SET_CPUID2. Setting XFD in guest
>      cpuid w/o proper permissions fails this operation. In the meantime,
>      unpermitted features are also excluded in KVM_GET_SUPPORTED_CPUID.
> 
>    - Extend fpstate reallocation mechanism to cover guest fpu
> 
>      Unlike native tasks which have reallocation triggered from #NM
>      handler, guest fpstate reallocation is requested by KVM when it
>      identifies the intention on using dynamically-enabled XSAVE
>      features inside guest.
> 
>      Extend fpu core to allow KVM request fpstate buffer expansion
>      for a guest fpu containter.
> 
>    - Trigger fpstate reallocation in KVM
> 
>      This could be done either statically (before guest runs) or
>      dynamically (in the emulation path). According to discussion [1]
>      we decide to statically enable all xfeatures allowed by guest perm
>      in KVM_SET_CPUID2, with fpstate buffer sized accordingly. This spares
>      a lot of code and also avoid imposing an ordered restore sequence
>      (XCR0, XFD and XSTATE) to userspace VMM.
> 
>    - RDMSR/WRMSR emulation for IA32_XFD
> 
>      Because fpstate expansion is completed in KVM_SET_CPUID2, emulating
>      r/w access to IA32_XFD simply involves the xfd field in the guest
>      fpu container. If write and guest fpu is currently active, the
>      software state (guest_fpstate::xfd and per-cpu xfd cache) is also
>      updated.
> 
>    - RDMSR/WRMSR emulation for XFD_ERR
> 
>      When XFD causes an instruction to generate #NM, XFD_ERR contains
>      information about which disabled state components are being accessed.
>      It'd be problematic if the XFD_ERR value generated in guest is
>      consumed/clobbered by the host before the guest itself doing so.
> 
>      Intercept #NM exception to save the guest XFD_ERR value when write
>      IA32_XFD with a non-zero value for 1st time. There is at most one
>      interception per guest task given a dynamic feature.
> 
>      RDMSR/WRMSR emulation uses the saved value. The host value (always
>      ZERO outside of the host #NM handler) is restored before enabling
>      preemption. The saved guest value is restored right before entering
>      the guest (with preemption disabled).
> 
>    - Get/set dynamic xfeature state for migration
> 
>      Introduce new capability (KVM_CAP_XSAVE2) to deal with >4KB fpstate
>      buffer. Reading this capability returns the size of the current
>      guest fpstate (e.g. after expansion). Userspace VMM uses a new ioctl
>      (KVM_GET_XSAVE2) to read guest fpstate from the kernel and reuses
>      the existing ioctl (KVM_SET_XSAVE) to update guest fpsate to the
>      kernel. KVM_SET_XSAVE is extended to do properly_sized memdup_user()
>      based on the guest fpstate.
> 
>    - Expose related cpuid bits to guest
> 
>      The last step is to allow exposing XFD, AMX_TILE, AMX_INT8 and
>      AMX_BF16 in guest cpuid. Adding those bits into kvm_cpu_caps finally
>      activates all previous logics in this series
> 
>    - Optimization: disable interception for IA32_XFD
> 
>      IA32_XFD can be frequently updated by the guest, as it is part of
>      the task state and swapped in context switch when prev and next have
>      different XFD setting. Always intercepting WRMSR can easily cause
>      non-negligible overhead.
> 
>      Disable r/w emulation for IA32_XFD after intercepting the first
>      WRMSR(IA32_XFD) with a non-zero value. However MSR passthrough
>      implies the software state (guest_fpstate::xfd and per-cpu xfd
>      cache) might be out of sync with MSR. This suggests KVM needs to
>      re-sync them at VM-exit before preemption is enabled.
> 
> Thanks Jun Nakajima and Kevin Tian for the design suggestions when this
> version is being internally worked on.
> 
> [1] https://lore.kernel.org/all/20211214022825.563892248@linutronix.de/
> [2] https://www.spinics.net/lists/kvm/msg259015.html
> [3] https://lore.kernel.org/lkml/20211208000359.2853257-1-yang.zhong@intel.com/
> 
> Thanks,
> Yang
> 
> ---
> 
> 
> Guang Zeng (1):
>    kvm: x86: Add support for getting/setting expanded xstate buffer
> 
> Jing Liu (11):
>    kvm: x86: Fix xstate_required_size() to follow XSTATE alignment rule
>    kvm: x86: Exclude unpermitted xfeatures at KVM_GET_SUPPORTED_CPUID
>    x86/fpu: Make XFD initialization in __fpstate_reset() a function
>      argument
>    kvm: x86: Check and enable permitted dynamic xfeatures at
>      KVM_SET_CPUID2
>    kvm: x86: Add emulation for IA32_XFD
>    x86/fpu: Prepare xfd_err in struct fpu_guest
>    kvm: x86: Intercept #NM for saving IA32_XFD_ERR
>    kvm: x86: Emulate IA32_XFD_ERR for guest
>    kvm: x86: Disable RDMSR interception of IA32_XFD_ERR
>    kvm: x86: Add XCR0 support for Intel AMX
>    kvm: x86: Add CPUID support for Intel AMX
> 
> Kevin Tian (3):
>    x86/fpu: Provide fpu_update_guest_perm_features() for guest
>    x86/fpu: Provide fpu_update_guest_xfd() for IA32_XFD emulation
>    kvm: x86: Disable interception for IA32_XFD on demand
> 
> Thomas Gleixner (5):
>    x86/fpu: Extend fpu_xstate_prctl() with guest permissions
>    x86/fpu: Prepare guest FPU for dynamically enabled FPU features
>    x86/fpu: Add guest support to xfd_enable_feature()
>    x86/fpu: Add uabi_size to guest_fpu
>    x86/fpu: Provide fpu_sync_guest_vmexit_xfd_state()
> 
> Wei Wang (1):
>    kvm: selftests: Add support for KVM_CAP_XSAVE2
> 
>   Documentation/virt/kvm/api.rst                |  46 +++++-
>   arch/x86/include/asm/cpufeatures.h            |   2 +
>   arch/x86/include/asm/fpu/api.h                |  11 ++
>   arch/x86/include/asm/fpu/types.h              |  32 ++++
>   arch/x86/include/asm/kvm_host.h               |   1 +
>   arch/x86/include/uapi/asm/kvm.h               |  16 +-
>   arch/x86/include/uapi/asm/prctl.h             |  26 ++--
>   arch/x86/kernel/fpu/core.c                    | 104 ++++++++++++-
>   arch/x86/kernel/fpu/xstate.c                  | 147 +++++++++++-------
>   arch/x86/kernel/fpu/xstate.h                  |  15 +-
>   arch/x86/kernel/process.c                     |   2 +
>   arch/x86/kvm/cpuid.c                          |  99 +++++++++---
>   arch/x86/kvm/vmx/vmcs.h                       |   5 +
>   arch/x86/kvm/vmx/vmx.c                        |  45 +++++-
>   arch/x86/kvm/vmx/vmx.h                        |   2 +-
>   arch/x86/kvm/x86.c                            | 105 ++++++++++++-
>   include/uapi/linux/kvm.h                      |   4 +
>   tools/arch/x86/include/uapi/asm/kvm.h         |  16 +-
>   tools/include/uapi/linux/kvm.h                |   3 +
>   .../testing/selftests/kvm/include/kvm_util.h  |   2 +
>   .../selftests/kvm/include/x86_64/processor.h  |  10 ++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  32 ++++
>   .../selftests/kvm/lib/x86_64/processor.c      |  67 +++++++-
>   .../testing/selftests/kvm/x86_64/evmcs_test.c |   2 +-
>   tools/testing/selftests/kvm/x86_64/smm_test.c |   2 +-
>   .../testing/selftests/kvm/x86_64/state_test.c |   2 +-
>   .../kvm/x86_64/vmx_preemption_timer_test.c    |   2 +-
>   27 files changed, 691 insertions(+), 109 deletions(-)
> 

