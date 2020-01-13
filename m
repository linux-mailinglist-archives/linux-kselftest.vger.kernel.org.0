Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4C139903
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMShI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 13:37:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:48391 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMShH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 13:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 10:37:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="424396844"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2020 10:37:05 -0800
Date:   Mon, 13 Jan 2020 10:37:05 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20200113183705.GL1175@linux.intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
 <20200113183228.GO13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113183228.GO13310@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 07:32:28PM +0100, Borislav Petkov wrote:
> On Fri, Dec 20, 2019 at 08:45:11PM -0800, Sean Christopherson wrote:
> > Define the VMCS execution control flags (consumed by KVM) using their
> > associated VMX_FEATURE_* to provide a strong hint that new VMX features
> > are expected to be added to VMX_FEATURE and considered for reporting via
> > /proc/cpuinfo.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/include/asm/vmx.h | 105 +++++++++++++++++++------------------
> >  1 file changed, 55 insertions(+), 50 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > index 1835767aa335..9fbba31be825 100644
> > --- a/arch/x86/include/asm/vmx.h
> > +++ b/arch/x86/include/asm/vmx.h
> > @@ -15,67 +15,70 @@
> >  #include <linux/bitops.h>
> >  #include <linux/types.h>
> >  #include <uapi/asm/vmx.h>
> > +#include <asm/vmxfeatures.h>
> > +
> > +#define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
> >  
> >  /*
> >   * Definitions of Primary Processor-Based VM-Execution Controls.
> >   */
> > -#define CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
> > -#define CPU_BASED_USE_TSC_OFFSETING             0x00000008
> > -#define CPU_BASED_HLT_EXITING                   0x00000080
> > -#define CPU_BASED_INVLPG_EXITING                0x00000200
> > -#define CPU_BASED_MWAIT_EXITING                 0x00000400
> > -#define CPU_BASED_RDPMC_EXITING                 0x00000800
> > -#define CPU_BASED_RDTSC_EXITING                 0x00001000
> > -#define CPU_BASED_CR3_LOAD_EXITING		0x00008000
> > -#define CPU_BASED_CR3_STORE_EXITING		0x00010000
> > -#define CPU_BASED_CR8_LOAD_EXITING              0x00080000
> > -#define CPU_BASED_CR8_STORE_EXITING             0x00100000
> > -#define CPU_BASED_TPR_SHADOW                    0x00200000
> > -#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
> > -#define CPU_BASED_MOV_DR_EXITING                0x00800000
> > -#define CPU_BASED_UNCOND_IO_EXITING             0x01000000
> > -#define CPU_BASED_USE_IO_BITMAPS                0x02000000
> > -#define CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
> > -#define CPU_BASED_USE_MSR_BITMAPS               0x10000000
> > -#define CPU_BASED_MONITOR_EXITING               0x20000000
> > -#define CPU_BASED_PAUSE_EXITING                 0x40000000
> > -#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
> > +#define CPU_BASED_VIRTUAL_INTR_PENDING          VMCS_CONTROL_BIT(VIRTUAL_INTR_PENDING)
> > +#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)
> 
> checkpatch correctly complains here:
> 
> WARNING: 'OFFSETING' may be misspelled - perhaps 'OFFSETTING'?
> #80: FILE: arch/x86/include/asm/vmx.h:26:
> +#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)
> 
> and VMX_FEATURE_TSC_OFFSETTING is correct.
> 
> Should I fix it up to CPU_BASED_USE_TSC_OFFSETTING while applying?

No, the CPU_BASED_* defines are used by existing KVM code, i.e. you'd
also have to touch a bunch of KVM code.


$ git grep CPU_BASED_USE_TSC_OFFSETING
arch/x86/include/asm/vmx.h:#define CPU_BASED_USE_TSC_OFFSETING             0x00000008
arch/x86/kvm/vmx/nested.c:      if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
arch/x86/kvm/vmx/nested.c:      if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
arch/x86/kvm/vmx/nested.c:      if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
arch/x86/kvm/vmx/nested.c:              CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETING |
arch/x86/kvm/vmx/vmx.c:     (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
arch/x86/kvm/vmx/vmx.c:     (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
arch/x86/kvm/vmx/vmx.c:       CPU_BASED_USE_TSC_OFFSETING |
tools/testing/selftests/kvm/include/x86_64/vmx.h:#define CPU_BASED_USE_TSC_OFFSETING            0x00000008
tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c:       control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETING;
