Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DB38F713
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 02:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhEYAtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 20:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 20:49:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB2AC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 17:47:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ot16so13909554pjb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aG1Rk5mQ6z7zKWiJZBw5W/DM6fEf1eH6Gw8m5QrPn6c=;
        b=QR4dlJitbXI+n2SuQmeqvwhpZ4erLgtJeD+20fHpsj1zCrkgqD2kuysJABRminlNZL
         uev+h8FUtyM45q2ptwZOu455Tesj7I56vZfSuzm967wdf45LH/1tgaltfMNi2FsV269g
         zw8XAJpTnPBnZIlAkQD3IBRXkZHhM0BUs12D/m0Tsi341e29s/bu9aou+BqtNrjFKfQW
         eG1dqNLJp/ftsBw+PoLSY7vLBHxEWxz+D6MswH/Zs8/DurU3sLs2rTkcEransI7uazP6
         aR2NCvLo/rVuCdZzVAVClVTFT5V5g3+TU6m7CmPJM5AdCsEgxBOxBSWDc8wSNJAwC7Xo
         A0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aG1Rk5mQ6z7zKWiJZBw5W/DM6fEf1eH6Gw8m5QrPn6c=;
        b=t+KQLw26iHiLVBBC7pte4MKZtj1QN1705CPaia+5JNaIpc6t7tvjTpxl+vhiB/d+tM
         LIwnCG9WFdRSWzAUMkiyrYzLNKQsMZUGxakOF8kHfKivoPyGPOcEfv1MI60yaCCwHtbN
         FFuswrvsokNhIkJVH7PTZaPBbn0xYC0Spx7O3YROTB2IAD/8XbhOc0L/oDpYPhUXif7q
         uaqVOuOCG41V9w3DRlUdO0d3aNs8sblsigLjG356i2sjMth7pwCANE0tNV0bMW4RwEJH
         2f08WOF7o8JNf1XCy8wjgnpau3Tl1t3c5+StJlHkzFs1Fhi/T1WscZOpoPk1KTmWeWah
         OrJQ==
X-Gm-Message-State: AOAM530Jggcl9ZlNj9KpBDKxjgZ50MW5HgKZMzeaaBlh8lXz4Umq5szr
        245ICkyzGswKWuxGVYYjV/yKfQ==
X-Google-Smtp-Source: ABdhPJx9VcemTXJxbYreb2y0AJZ0f7ed6bUubYmVR81BO/HH6rHyizGkROhdf+EjCPQ0jJkQr7K5XQ==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr1881796pjl.23.1621903665386;
        Mon, 24 May 2021 17:47:45 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id k7sm481354pjj.46.2021.05.24.17.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:47:44 -0700 (PDT)
Date:   Tue, 25 May 2021 00:47:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Ben Gardon <bgardon@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/2] KVM: Deliver VM fault signals to userspace
Message-ID: <YKxJLcg/WomPE422@google.com>
References: <20210519210437.1688484-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519210437.1688484-1-jthoughton@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 19, 2021, James Houghton wrote:
> This patch has been written to support page-ins using userfaultfd's
> SIGBUS feature.  When a userfaultfd is created with UFFD_FEATURE_SIGBUS,
> `handle_userfault` will return VM_FAULT_SIGBUS instead of putting the
> calling thread to sleep. Normal (non-guest) threads that access memory
> that has been registered with a UFFD_FEATURE_SIGBUS userfaultfd receive
> a SIGBUS.
> 
> When a vCPU gets an EPT page fault in a userfaultfd-registered region,
> KVM calls into `handle_userfault` to resolve the page fault. With
> UFFD_FEATURE_SIGBUS, VM_FAULT_SIGBUS is returned, but a SIGBUS is never
> delivered to the userspace thread. This patch propagates the
> VM_FAULT_SIGBUS error up to KVM, where we then send the signal.
> 
> Upon receiving a VM_FAULT_SIGBUS, the KVM_RUN ioctl will exit to
> userspace. This functionality already exists.

I would strongly prefer to fix this in KVM by returning a KVM specific exit
reason (instead of -EFAULT), with additional information provided in vcpu->run,
e.g. address, etc...

VirtioFS has (had?) a similar problem with a file being truncated in the host
and the guest being killed as a result due to KVM returning -EFAULT without any
useful information[*].  That idea never got picked up, but I'm 99% certain the
solution would provide exactly the functionality you want.

[*] https://lkml.kernel.org/r/20200617230052.GB27751@linux.intel.com


Handling this purely in KVM would have several advantages:

  - No need to plumb @fault_error around mm/.  KVM might be able to fudge this
    anyways by looking for -EFAULT, but then it would mess up SIGBUS vs SIGSEGV.

  - KVM can provide more relevant information then the signal path, e.g. guest
    RIP and GPA.  This probably isn't useful for your use case, but for debug
    and other use cases it can be very helpful.

  - The error and its info are synchronous and delivered together (on exit to
    userspace), instead of being split across KVM and the signal handling.

  - This behavior needs to be opt-in to avoid breaking KVM's (awful) ABI, but we
    might be able to get away with squeezing the extra info into vcpu->run even
    if userspace doesn't opt-in (though that doesn't mean userspace will do
    anything with it).

  - I hate signal handling (ok, not a legitimate reason).

The big downside is that implementing the synchronous reporting would need to
either be done for every KVM architecture, or would need to touch every arch if
done generically.  I haven't looked at other architectures for this specific
issue, so I don't know which of those routes would be least awful.

A very incomplete patch for x86 would look something like:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0144c40d09c7..2d4d32425c49 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2875,8 +2875,11 @@ static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *
        send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
 }
 
-static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
+static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, hva_t hva,
+                              kvm_pfn_t pfn)
 {
+       struct kvm_mem_fault_exit *fault = &vcpu->run->mem_fault;
+
        /*
         * Do not cache the mmio info caused by writing the readonly gfn
         * into the spte otherwise read access on readonly gfn also can
@@ -2886,25 +2889,32 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
                return RET_PF_EMULATE;
 
        if (pfn == KVM_PFN_ERR_HWPOISON) {
-               kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn), current);
+               kvm_send_hwpoison_signal(hva, current);
                return RET_PF_RETRY;
        }
 
+       fault->userspace_address = hva;
+       fault->guest_physical_address = gpa;
+       fault->guest_rip = kvm_rip_read(vcpu);
+
+       if (vcpu->kvm->arch.mem_fault_reporting_enabled)
+               return KVM_EXIT_MEM_FAULT;
+
        return -EFAULT;
 }
 
-static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
-                               kvm_pfn_t pfn, unsigned int access,
+static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, gva_t gva, gpa_t gpa,
+                               hva_t hva, kvm_pfn_t pfn, unsigned int access,
                                int *ret_val)
 {
        /* The pfn is invalid, report the error! */
        if (unlikely(is_error_pfn(pfn))) {
-               *ret_val = kvm_handle_bad_page(vcpu, gfn, pfn);
+               *ret_val = kvm_handle_bad_page(vcpu, gpa, hva, pfn);
                return true;
        }
 
        if (unlikely(is_noslot_pfn(pfn))) {
-               vcpu_cache_mmio_info(vcpu, gva, gfn,
+               vcpu_cache_mmio_info(vcpu, gva, gpa >> PAGE_SHIFT,
                                     access & shadow_mmio_access_mask);
                /*
                 * If MMIO caching is disabled, emulate immediately without
@@ -3746,7 +3756,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
                         write, &map_writable))
                return RET_PF_RETRY;
 
-       if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, pfn, ACC_ALL, &r))
+       if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gpa, hva, pfn, ACC_ALL, &r))
                return r;
 
        r = RET_PF_RETRY;
