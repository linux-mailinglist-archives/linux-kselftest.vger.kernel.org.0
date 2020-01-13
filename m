Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3547E1398EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 19:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAMScj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 13:32:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgAMScj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 13:32:39 -0500
Received: from zn.tnic (p200300EC2F05D30049A87F91DFBF49F4.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:49a8:7f91:dfbf:49f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63B0C1EC0CD0;
        Mon, 13 Jan 2020 19:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578940356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RBW1TCM6YPQlrLEyu7NFV1MDLei+4JpYY2ymbBbRI68=;
        b=VyN/ooBc5iiyPlTUlqldiBTCt29HwDoTiD6Ey/I6uzPt3mCbCr8TL2UUjlo4TUJ5+pJweE
        AyoXTnRkd/eVyf9RHRFAZ4Ccl+P9GC0chkkXxYIZELQ+MiVviifPcx7HOFq0CoovzMgFdB
        G8y+SSry8iOc4sNMcE6Ds+Vtkn0YQNM=
Date:   Mon, 13 Jan 2020 19:32:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v5 17/19] KVM: VMX: Use VMX_FEATURE_* flags to define
 VMCS control bits
Message-ID: <20200113183228.GO13310@zn.tnic>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191221044513.21680-18-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 20, 2019 at 08:45:11PM -0800, Sean Christopherson wrote:
> Define the VMCS execution control flags (consumed by KVM) using their
> associated VMX_FEATURE_* to provide a strong hint that new VMX features
> are expected to be added to VMX_FEATURE and considered for reporting via
> /proc/cpuinfo.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/vmx.h | 105 +++++++++++++++++++------------------
>  1 file changed, 55 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 1835767aa335..9fbba31be825 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -15,67 +15,70 @@
>  #include <linux/bitops.h>
>  #include <linux/types.h>
>  #include <uapi/asm/vmx.h>
> +#include <asm/vmxfeatures.h>
> +
> +#define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
>  
>  /*
>   * Definitions of Primary Processor-Based VM-Execution Controls.
>   */
> -#define CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
> -#define CPU_BASED_USE_TSC_OFFSETING             0x00000008
> -#define CPU_BASED_HLT_EXITING                   0x00000080
> -#define CPU_BASED_INVLPG_EXITING                0x00000200
> -#define CPU_BASED_MWAIT_EXITING                 0x00000400
> -#define CPU_BASED_RDPMC_EXITING                 0x00000800
> -#define CPU_BASED_RDTSC_EXITING                 0x00001000
> -#define CPU_BASED_CR3_LOAD_EXITING		0x00008000
> -#define CPU_BASED_CR3_STORE_EXITING		0x00010000
> -#define CPU_BASED_CR8_LOAD_EXITING              0x00080000
> -#define CPU_BASED_CR8_STORE_EXITING             0x00100000
> -#define CPU_BASED_TPR_SHADOW                    0x00200000
> -#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
> -#define CPU_BASED_MOV_DR_EXITING                0x00800000
> -#define CPU_BASED_UNCOND_IO_EXITING             0x01000000
> -#define CPU_BASED_USE_IO_BITMAPS                0x02000000
> -#define CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
> -#define CPU_BASED_USE_MSR_BITMAPS               0x10000000
> -#define CPU_BASED_MONITOR_EXITING               0x20000000
> -#define CPU_BASED_PAUSE_EXITING                 0x40000000
> -#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
> +#define CPU_BASED_VIRTUAL_INTR_PENDING          VMCS_CONTROL_BIT(VIRTUAL_INTR_PENDING)
> +#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)

checkpatch correctly complains here:

WARNING: 'OFFSETING' may be misspelled - perhaps 'OFFSETTING'?
#80: FILE: arch/x86/include/asm/vmx.h:26:
+#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)

and VMX_FEATURE_TSC_OFFSETTING is correct.

Should I fix it up to CPU_BASED_USE_TSC_OFFSETTING while applying?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
