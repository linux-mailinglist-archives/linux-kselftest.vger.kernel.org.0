Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFF170E44
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 03:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgB0CMX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 21:12:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:55531 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgB0CMX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 21:12:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 18:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="241882156"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2020 18:12:21 -0800
Date:   Wed, 26 Feb 2020 18:12:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
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
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Message-ID: <20200227021221.GA14478@linux.intel.com>
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 25, 2020 at 01:49:13PM -0800, Jacob Keller wrote:
> I recently ran into a general protection fault that I believe is the
> fault of this patch:
> 
> > [   32.189584] general protection fault, maybe for address 0xffffb567801bcf58: 0000 [#1] SMP PTI
> > [   32.198103] CPU: 1 PID: 2600 Comm: rngd Not tainted 5.6.0-rc2-jk+ #2
> > [   32.204454] Hardware name: Intel Corporation S2600STQ/S2600STQ, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > [   32.214887] RIP: 0010:hardware_enable+0x100/0x1a0 [kvm_intel]
> > [   32.220628] Code: <f3> 0f c7 34 24 31 c0 80 3d 59 8d 03 00 00 75 36 48 8b 5c 24 10 65
> > [   32.239373] RSP: 0000:ffffb567801bcf58 EFLAGS: 00010002
> > [   32.244598] RAX: 0000000000300000 RBX: 0000000000000086 RCX: ffff8f2650440000
> > [   32.251730] RDX: 0000000000300000 RSI: 0000000000000000 RDI: ffff8f2650457020
> > [   32.258862] RBP: 0000000000000007 R08: 000000077ea5d531 R09: 0000000000000000
> > [   32.265986] R10: 000001432bf20982 R11: 0000000000000000 R12: ffffd55b80467110
> > [   32.273118] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [   32.280243] FS:  00007facfe66f700(0000) GS:ffff8f2650440000(0000) knlGS:0000000000000000
> > [   32.288329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   32.294077] CR2: 00007facf0003000 CR3: 0000000b7d402006 CR4: 00000000007626e0
> > [   32.301210] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   32.308342] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   32.315474] PKRU: 55555554
> > [   32.318186] Call Trace:
> > [   32.320642]  <IRQ>
> > [   32.322689]  kvm_arch_hardware_enable+0x84/0x240 [kvm]
> > [   32.327836]  hardware_enable_nolock+0x31/0x60 [kvm]
> > [   32.332717]  flush_smp_call_function_queue+0x4d/0xe0
> > [   32.337683]  smp_call_function_interrupt+0x3a/0xd0
> > [   32.342471]  call_function_interrupt+0xf/0x20
> > [   32.346830]  </IRQ>
> > [   32.498314] ---[ end trace bfeeeba337a01208 ]---
> 
> I noticed that a slightly older commit from before this does not fail.
> Additionally, the system reports the following during boot:
> 
> kvm: disabled by bios

One other thing that's been bothering me; you mention in a later email that
this bug resulting in a crash during boot.  The low timestamps also suggest
the system is fairly early in its bringup.

But KVM only does VMXON when it actually creates a VM[*].  During boot I
would expect the bug to result in KVM being incorrectly loaded/enabled, but
that alone wouldn't trigger a crash.

I assume/hope your system is automatically running some form of virt
process at boot?  Not that there's anything wrong with that, it's just
suprising and I want to make sure there's not something really funky going
on.

[*] KVM also does VMXON when hotplugging a CPU, but only if KVM has active
    VMs, and the IPI callback above indicates this isn't the hotplug case.
