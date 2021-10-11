Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342A442959F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJKRcO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 13:32:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:50264 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJKRcO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 13:32:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="227215564"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="227215564"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 10:30:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="440883808"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.28.12]) ([10.255.28.12])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 10:30:08 -0700
Subject: Re: [PATCH 07/14] KVM: x86: SVM: add warning for CVE-2021-3656
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-8-mlevitsk@redhat.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <4c04106a-fd8e-fb54-799f-06331a3e65b9@intel.com>
Date:   Tue, 12 Oct 2021 01:30:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-8-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/14/2021 11:48 PM, Maxim Levitsky wrote:
> Just in case, add a warning ensuring that on guest entry,
> either both VMLOAD and VMSAVE intercept is enabled or
> vVMLOAD/VMSAVE is enabled.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 861ac9f74331..deeebd05f682 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3784,6 +3784,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   
>   	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
>   
> +	/* Check that CVE-2021-3656 can't happen again */
> +	if (!svm_is_intercept(svm, INTERCEPT_VMSAVE) ||
> +	    !svm_is_intercept(svm, INTERCEPT_VMSAVE))

either one needs to be INTERCEPT_VMLOAD, right?

> +		WARN_ON(!(svm->vmcb->control.virt_ext &
> +			  VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
> +
>   	sync_lapic_to_cr8(vcpu);
>   
>   	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> 

