Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B3016F1B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgBYVtS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 16:49:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:48317 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbgBYVtR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 16:49:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 13:49:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="230253937"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [134.134.177.78]) ([134.134.177.78])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2020 13:49:13 -0800
To:     sean.j.christopherson@intel.com
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
Date:   Tue, 25 Feb 2020 13:49:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20191221044513.21680-14-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sean,

> Add a new feature flag, X86_FEATURE_MSR_IA32_FEAT_CTL, to track whether
> IA32_FEAT_CTL has been initialized.  This will allow KVM, and any future
> subsystems that depend on IA32_FEAT_CTL, to rely purely on cpufeatures
> to query platform support, e.g. allows a future patch to remove KVM's
> manual IA32_FEAT_CTL MSR checks.
> 
> Various features (on platforms that support IA32_FEAT_CTL) are dependent
> on IA32_FEAT_CTL being configured and locked, e.g. VMX and LMCE.  The
> MSR is always configured during boot, but only if the CPU vendor is
> recognized by the kernel.  Because CPUID doesn't incorporate the current
> IA32_FEAT_CTL value in its reporting of relevant features, it's possible
> for a feature to be reported as supported in cpufeatures but not truly
> enabled, e.g. if the CPU supports VMX but the kernel doesn't recognize
> the CPU.
> 
> As a result, without the flag, KVM would see VMX as supported even if
> IA32_FEAT_CTL hasn't been initialized, and so would need to manually
> read the MSR and check the various enabling bits to avoid taking an
> unexpected #GP on VMXON.


I recently ran into a general protection fault that I believe is the
fault of this patch:

> [   32.189584] general protection fault, maybe for address 0xffffb567801bcf58: 0000 [#1] SMP PTI
> [   32.198103] CPU: 1 PID: 2600 Comm: rngd Not tainted 5.6.0-rc2-jk+ #2
> [   32.204454] Hardware name: Intel Corporation S2600STQ/S2600STQ, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [   32.214887] RIP: 0010:hardware_enable+0x100/0x1a0 [kvm_intel]
> [   32.220628] Code: 00 00 48 39 f8 74 0f 65 48 89 3d 43 a2 cb 3c e8 66 d3 cc c5 66 90 48 89 df 57 9d 0f 1f 44 00 00 bf 01 00 00 00 e8 90 3d ca c5 <f3> 0f c7 34 24 31 c0 80 3d 59 8d 03 00 00 75 36 48 8b 5c 24 10 65
> [   32.239373] RSP: 0000:ffffb567801bcf58 EFLAGS: 00010002
> [   32.244598] RAX: 0000000000300000 RBX: 0000000000000086 RCX: ffff8f2650440000
> [   32.251730] RDX: 0000000000300000 RSI: 0000000000000000 RDI: ffff8f2650457020
> [   32.258862] RBP: 0000000000000007 R08: 000000077ea5d531 R09: 0000000000000000
> [   32.265986] R10: 000001432bf20982 R11: 0000000000000000 R12: ffffd55b80467110
> [   32.273118] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   32.280243] FS:  00007facfe66f700(0000) GS:ffff8f2650440000(0000) knlGS:0000000000000000
> [   32.288329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.294077] CR2: 00007facf0003000 CR3: 0000000b7d402006 CR4: 00000000007626e0
> [   32.301210] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   32.308342] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   32.315474] PKRU: 55555554
> [   32.318186] Call Trace:
> [   32.320642]  <IRQ>
> [   32.322689]  kvm_arch_hardware_enable+0x84/0x240 [kvm]
> [   32.327836]  hardware_enable_nolock+0x31/0x60 [kvm]
> [   32.332717]  flush_smp_call_function_queue+0x4d/0xe0
> [   32.337683]  smp_call_function_interrupt+0x3a/0xd0
> [   32.342471]  call_function_interrupt+0xf/0x20
> [   32.346830]  </IRQ>
> [   32.348935] RIP: 0033:0x7facffd4c753
> [   32.352514] Code: e8 48 c7 45 e0 00 00 00 00 eb 5f 48 8b 45 c8 48 8b 50 38 48 8b 45 c8 8b 40 40 89 c0 48 01 d0 48 89 45 f0 48 8b 45 f0 0f b6 00 <83> c0 01 89 c2 48 8b 45 f0 88 10 48 8b 45 c8 8b 50 40 48 8b 45 c8
> [   32.371263] RSP: 002b:00007facfe66ebf0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff03
> [   32.378826] RAX: 00000000000000ee RBX: 0000000000004097 RCX: 0000000000000000
> [   32.385961] RDX: 0000562781dbadf0 RSI: 0000000000000000 RDI: 00007ffd7edf9080
> [   32.393092] RBP: 00007facfe66ec30 R08: 00007ffd7edf9080 R09: 000000000000cd4a
> [   32.400226] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   32.407358] R13: 00007facf0000b20 R14: 0000562781dba2e8 R15: 00007facfe66ed10
> [   32.414493] Modules linked in: ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter rfkill ib_isert iscsi
> _target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib vfat fat ib_umad rpcrdma sunrpc intel_rapl_msr intel_rapl_common rdma_ucm ib_iser rdma_cm isst_if_common iw_cm ib_cm libiscsi skx_edac scsi_transport_iscsi nfit libnv
> dimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate i40iw qat_c62x iTCO_wdt ipmi_ssif iTCO_vendor_support ib_uverbs mei_me intel_qat intel_uncore ib_c
> ore joydev intel_rapl_perf pcspkr ipmi_si authenc ioatdma mei i2c_i801 lpc_ich dca ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad ip_tables ast i2c_algo_bit drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec drm ice i40e crc32
> c_intel wmi fuse
> [   32.498314] ---[ end trace bfeeeba337a01208 ]---

I noticed that a slightly older commit from before this does not fail.
Additionally, the system reports the following during boot:

kvm: disabled by bios

I looked into the vmx_disabled_by_bios and noticed that it checks for
both X86_FEATURE_MSR_IA32_FEAT_CTL and X86_FEATURE_VMX.

Compared to the older code before commit a4d0b2fdbcf7 ("KVM: VMX: Use
VMX feature flag to query BIOS enabling") it's not clear to me how
exactly this could fail to match up.

I suspect something is wrong and the features are enabled even though
the BIOS has it disabled, leading to later failure because of this.

Thanks,
Jake
