Return-Path: <linux-kselftest+bounces-19672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FFB99D66F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2860A284C5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847381C9EA7;
	Mon, 14 Oct 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3jKKITi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82B1C8787
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930319; cv=none; b=Huez8TXskTkmOcYcsWKTfjGtNXFArSi13h/8kCj8mlBi3lnjcv27l7pURc/qGUPXbLYYSGYA/ipMJlJgqowQn4zSCzETQVpLxcIfNIs+a3P52XLoP532AxpJ+x0xfhg8+5s5qtsbYfoFh00iS7nMghordHxLVvsvm++wSfVRaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930319; c=relaxed/simple;
	bh=HupeQ5exxwwn1RcmbvdOjyDz0TWWIoQW9yJfplbh+Qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0V1lqU3rAnbemhAfSYvvfatKGdv8LXw60vSJ6wY5jpxb2a517MMNZLD7nSxDVLzAfN3EXRm6eK7fAZ8rY1KS94bjPqwkDjTi415f+Gk3xKVdUHDHCYOtZdRtu38OQYnbhrRqCgaoZSVXY9SmQigvK79FxBAPKkJ+lL7ldpd250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3jKKITi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso3804576a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728930314; x=1729535114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fshFl0i7vUlrgl2oqEu5/iHYBg4ox0yO/RY+8i9ovvc=;
        b=O3jKKITiiRP2ErGJ2+BIgob+dzT+opTanztaXIWVLNTa9G44i3IslCtzMyREcFEFvR
         1TSDKSjR5CB8p1aPt8TLEJB694eQnQrYbivT/cNvYViBNkIYsnRo/baErYNjHMwid9m/
         rlUO61jykbbVh7YGNLo1GxfWhC+bG5VvxMiRywm6ZhkKQ1cAON+tb4btk3vCJ5fvP6eR
         zOvX4K8MWtxShkOF3PcUxpQpZXrHrCIXW0a2aW5K5qCIonNrxZ0HFuXQMFpL6PbagkVa
         VPB4IfJxI6d4n6zK5bokunGKbbeyw5GBQSTGoWmBYmCtPquMyj4R0XS/lkyqgm8fIAlf
         GjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930314; x=1729535114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fshFl0i7vUlrgl2oqEu5/iHYBg4ox0yO/RY+8i9ovvc=;
        b=JM8n+cKZcEHSynRb/snDhDKuYA+p2+w6V9HEHAbj29HYcpXUzCwpLR9IG76XDMkbDW
         iZtjNRBpNA1XswPlPmBKgK837qb2TJavsZc3DhEhcV26gyfOL5uTi15p0mRj7Q6T17mK
         /OpXD7GDOukErMlGYq4Wtg0y6TC2jo991A5wnMj6d2KKfCRb8//2f5kfyBOg1GqvMRQD
         gfXsIk7tv8Pul76JiyGt75RYZrwmLcR7vQSGJ45zsaLmqnuMPI+8iIJaDAycfJHhMGhu
         xh2wXDSNHZWh+rgBW+9zf0/RuGqbZ3LEFWH9J60qtR9nKW9cmh4QUnvAQW0lj9MY3L4E
         0Ypg==
X-Forwarded-Encrypted: i=1; AJvYcCWRXxYKJoulpffjsIqoQEhLgnnzBSGkL7bJcAa0AEScrreVgr3N8WaelHOfM0uG5s0h9rnbmj3xabzXAafTkNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhI3KB3GOtnVJu88abeZRyzcwfr+5VieMpQzW2wQRAYm5qUwWv
	Yf15hCOsRzBrOTtEHjvwZfP/uI/f1JE23wv4D+342syiiFcALfTFH5J6IawItxYfHNILfVKWU8O
	bGg==
X-Google-Smtp-Source: AGHT+IGKM2Sm8OIAwgoXOoTNyfkUq/meiQ50qTsXJXPzeY0vPrc5oCvB8E7lirCoRyVVsE2jhxFg4qJQsHs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:f155:0:b0:7ea:8c4c:d07c with SMTP id
 41be03b00d2f7-7ea8c4ce1cdmr5383a12.3.1728930314165; Mon, 14 Oct 2024 11:25:14
 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:25:12 -0700
In-Reply-To: <20241014105124.24473-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014105124.24473-1-adrian.hunter@intel.com> <20241014105124.24473-4-adrian.hunter@intel.com>
Message-ID: <Zw1iCMNSI4Lc0mSG@google.com>
Subject: Re: [PATCH V13 03/14] KVM: x86: Fix Intel PT Host/Guest mode when
 host tracing also
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 14, 2024, Adrian Hunter wrote:
> Ensure Intel PT tracing is disabled before VM-Entry in Intel PT Host/Guest
> mode.
> 
> Intel PT has 2 modes for tracing virtual machines. The default is System
> mode whereby host and guest output to the host trace buffer. The other is
> Host/Guest mode whereby host and guest output to their own buffers.
> Host/Guest mode is selected by kvm_intel module parameter pt_mode=1.
> 
> In Host/Guest mode, the following rule must be followed:

This is misleading and arguably wrong.  The following "rule" must _always_ be
followed.  If I weren't intimately familiar with the distinctive style of the
SDM's consistency checks, odds are good I wouldn't have any idea where this rule
came from.

> 	If the logical processor is operating with Intel PT enabled
> 	(if IA32_RTIT_CTL.TraceEn = 1) at the time of VM entry, the
> 	"load IA32_RTIT_CTL" VM-entry control must be 0.

> However, "load IA32_RTIT_CTL" VM-entry control is always 1 in Host/Guest
> mode, so IA32_RTIT_CTL.TraceEn must always be 0 at VM entry, irrespective
> of whether guest IA32_RTIT_CTL.TraceEn is 1.

Explicitly state what the bad behavior is, _somewhere_.  Similar to the previous
patch, their is a lot of information to wade through just to understand that this
results in a failed VM-Entry.

Furthermore, nothing in here spells out exactly under what conditions this bug
surfaces, which makes it unnecessarily difficult to understand what can go wrong,
and when.

> Fix by stopping host Intel PT tracing always at VM entry in Host/Guest

It's not _at_ VM-Entry.  The language matters, because this makes it sound like
PT tracing is being disabled as part of VM-Entry.

> mode.
>
> That also fixes the issue whereby the Intel PT NMI handler would
> set IA32_RTIT_CTL.TraceEn back to 1 after KVM has just set it to 0.

In theory, this should be an entirely separate fix.  In practice, simply clearing
MSR_IA32_RTIT_CTL before VM-Enter if tracing is enabled doesn't help much, i.e.
re-enabling in the NMI handler isn't all that rare.  That absolutely needs to
be called out in the changelog.

> Fixes: 2ef444f1600b ("KVM: x86: Add Intel PT context switch for each vcpu")
> Cc: stable@vger.kernel.org

This is way, way too big for stable@.  Given that host/guest mode is disabled by
default and that no one has complained about this, I think it's safe to say that
unless we can provide a minimal patch, fixing this in LTS kernels isn't a priority.

Alternatively, I'm tempted to simply drop support for host/guest mode.  It clearly
hasn't been well tested, and given the lack of bug reports, likely doesn't have
many, if any, users.  And I'm guessing the overhead needed to context switch all
the RTIT MSRs makes tracing in the guest relatively useless.

/me fiddles around

LOL, yeah, this needs to be burned with fire.  It's wildly broken.  So for stable@,
I'll post a patch to hide the module param if CONFIG_BROKEN=n (and will omit
stable@ for the previous patch).

Going forward, if someone actually cares about virtualizing PT enough to want to
fix KVM's mess, then they can put in the effort to fix all the bugs, write all
the tests, and in general clean up the implementation to meet KVM's current
standards.  E.g. KVM usage of intel_pt_validate_cap() instead of KVM's guest CPUID
and capabilities infrastructure needs to go.

My vote is to queue the current code for removal, and revisit support after the
mediated PMU has landed.  Because I don't see any point in supporting Intel PT
without a mediated PMU, as host/guest mode really only makes sense if the entire
PMU is being handed over to the guest.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f587daf2a3bb..fe5046709bc3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -217,9 +217,13 @@ module_param(ple_window_shrink, uint, 0444);
 static unsigned int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, uint, 0444);
 
-/* Default is SYSTEM mode, 1 for host-guest mode */
+/* Default is SYSTEM mode, 1 for host-guest mode (which is BROKEN) */
+#ifdef CONFIG_BROKEN
 int __read_mostly pt_mode = PT_MODE_SYSTEM;
 module_param(pt_mode, int, S_IRUGO);
+#else
+#define pt_mode PT_MODE_SYSTEM
+#endif
 
 struct x86_pmu_lbr __ro_after_init vmx_lbr_caps;
 
[ 1458.686107] ------------[ cut here ]------------
[ 1458.690766] Invalid MSR 588, please adapt vmx_possible_passthrough_msrs[]
[ 1458.690790] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.708588] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1458.725826] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S                 6.12.0-smp--65cbdf61cc85-dbg #445
[ 1458.736197] Tainted: [S]=CPU_OUT_OF_SPEC
[ 1458.740145] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1458.747651] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.754561] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1458.773346] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1458.778598] RAX: 49af8c020dc11100 RBX: 0000000000000588 RCX: 0000000000000027
[ 1458.785761] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1458.792929] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1458.800082] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1458.807250] R13: 0000000000000004 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1458.814409] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1458.822525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1458.828295] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1458.835457] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1458.842619] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1458.849794] PKRU: 55555554
[ 1458.852537] Call Trace:
[ 1458.855013]  <TASK>
[ 1458.857151]  ? __warn+0xce/0x210
[ 1458.860417]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.866713]  ? report_bug+0xbd/0x160
[ 1458.870320]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.876628]  ? handle_bug+0x63/0x90
[ 1458.880156]  ? exc_invalid_op+0x1a/0x50
[ 1458.884021]  ? asm_exc_invalid_op+0x1a/0x20
[ 1458.888243]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.894544]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1458.900846]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1458.906974]  pt_update_intercept_for_msr+0x18e/0x2d0 [kvm_intel]
[ 1458.913017]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1458.918140]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1458.922795]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1458.927902]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1458.932140]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1458.937252]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1458.942184]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1458.946688]  ? __mutex_lock+0x65/0xbe0
[ 1458.950473]  ? __mutex_lock+0x231/0xbe0
[ 1458.954345]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1458.958929]  ? kfree+0x4a/0x380
[ 1458.962109]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1458.966852]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1458.971272]  ? vma_end_read+0x14/0xf0
[ 1458.974969]  ? vma_end_read+0xd2/0xf0
[ 1458.978664]  __se_sys_ioctl+0x6b/0xc0
[ 1458.982366]  do_syscall_64+0x83/0x160
[ 1458.986075]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1458.991160] RIP: 0033:0x45d93b
[ 1458.994252] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1459.013025] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1459.020624] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1459.027789] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1459.034952] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1459.042112] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1459.049271] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1459.056440]  </TASK>
[ 1459.058670] irq event stamp: 10347
[ 1459.062107] hardirqs last  enabled at (10357): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1459.070749] hardirqs last disabled at (10372): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1459.079400] softirqs last  enabled at (10418): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.087953] softirqs last disabled at (10381): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.096505] ---[ end trace 0000000000000000 ]---
[ 1459.101160] ------------[ cut here ]------------
[ 1459.105817] Invalid MSR 589, please adapt vmx_possible_passthrough_msrs[]
[ 1459.105826] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.123618] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1459.140843] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1459.151217] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1459.156042] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1459.163554] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.170459] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1459.189245] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1459.194502] RAX: 49af8c020dc11100 RBX: 0000000000000589 RCX: 0000000000000027
[ 1459.201670] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1459.208830] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1459.215990] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1459.223154] R13: 0000000000000004 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1459.230319] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1459.238437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1459.244208] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1459.251369] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1459.258530] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1459.265698] PKRU: 55555554
[ 1459.268441] Call Trace:
[ 1459.270918]  <TASK>
[ 1459.273053]  ? __warn+0xce/0x210
[ 1459.276311]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.282614]  ? report_bug+0xbd/0x160
[ 1459.286234]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.292535]  ? handle_bug+0x63/0x90
[ 1459.296052]  ? exc_invalid_op+0x1a/0x50
[ 1459.299917]  ? asm_exc_invalid_op+0x1a/0x20
[ 1459.304133]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.310434]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.316732]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1459.322858]  pt_update_intercept_for_msr+0x19e/0x2d0 [kvm_intel]
[ 1459.328903]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.334016]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1459.338674]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.343778]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1459.348017]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.353126]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1459.358064]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1459.362559]  ? __mutex_lock+0x65/0xbe0
[ 1459.366340]  ? __mutex_lock+0x231/0xbe0
[ 1459.370205]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1459.374789]  ? kfree+0x4a/0x380
[ 1459.377958]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1459.382699]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1459.387118]  ? vma_end_read+0x14/0xf0
[ 1459.390814]  ? vma_end_read+0xd2/0xf0
[ 1459.394507]  __se_sys_ioctl+0x6b/0xc0
[ 1459.398205]  do_syscall_64+0x83/0x160
[ 1459.401903]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1459.406992] RIP: 0033:0x45d93b
[ 1459.410081] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1459.428854] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1459.436458] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1459.443621] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1459.450778] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1459.457940] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1459.465109] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1459.472273]  </TASK>
[ 1459.474493] irq event stamp: 11613
[ 1459.477922] hardirqs last  enabled at (11623): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1459.486562] hardirqs last disabled at (11632): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1459.495198] softirqs last  enabled at (11580): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.503755] softirqs last disabled at (11651): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.512304] ---[ end trace 0000000000000000 ]---
[ 1459.516951] ------------[ cut here ]------------
[ 1459.521594] Invalid MSR 58a, please adapt vmx_possible_passthrough_msrs[]
[ 1459.521601] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.539388] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1459.556613] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1459.566986] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1459.571809] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1459.579318] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.586226] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1459.605008] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1459.610262] RAX: 49af8c020dc11100 RBX: 000000000000058a RCX: 0000000000000027
[ 1459.617423] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1459.624584] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1459.631754] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1459.638915] R13: 0000000000000005 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1459.646071] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1459.654185] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1459.659960] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1459.667125] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1459.674287] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1459.681450] PKRU: 55555554
[ 1459.684192] Call Trace:
[ 1459.686675]  <TASK>
[ 1459.688814]  ? __warn+0xce/0x210
[ 1459.692077]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.698379]  ? report_bug+0xbd/0x160
[ 1459.701999]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.708312]  ? handle_bug+0x63/0x90
[ 1459.711837]  ? exc_invalid_op+0x1a/0x50
[ 1459.715704]  ? asm_exc_invalid_op+0x1a/0x20
[ 1459.719927]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.726225]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.732520]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1459.738645]  pt_update_intercept_for_msr+0x18e/0x2d0 [kvm_intel]
[ 1459.744682]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.749787]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1459.754443]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.759550]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1459.763798]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1459.768911]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1459.773844]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1459.778348]  ? __mutex_lock+0x65/0xbe0
[ 1459.782133]  ? __mutex_lock+0x231/0xbe0
[ 1459.786008]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1459.790602]  ? kfree+0x4a/0x380
[ 1459.793780]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1459.798513]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1459.802922]  ? vma_end_read+0x14/0xf0
[ 1459.806613]  ? vma_end_read+0xd2/0xf0
[ 1459.810307]  __se_sys_ioctl+0x6b/0xc0
[ 1459.813999]  do_syscall_64+0x83/0x160
[ 1459.817692]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1459.822779] RIP: 0033:0x45d93b
[ 1459.825862] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1459.844633] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1459.852227] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1459.859394] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1459.866555] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1459.873729] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1459.880889] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1459.888053]  </TASK>
[ 1459.890276] irq event stamp: 12747
[ 1459.893707] hardirqs last  enabled at (12757): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1459.902345] hardirqs last disabled at (12766): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1459.910978] softirqs last  enabled at (12716): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.919527] softirqs last disabled at (12703): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1459.928078] ---[ end trace 0000000000000000 ]---
[ 1459.932723] ------------[ cut here ]------------
[ 1459.937370] Invalid MSR 58b, please adapt vmx_possible_passthrough_msrs[]
[ 1459.937376] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1459.955169] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1459.972406] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1459.982794] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1459.987619] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1459.995124] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.002033] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1460.020843] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1460.026103] RAX: 49af8c020dc11100 RBX: 000000000000058b RCX: 0000000000000027
[ 1460.033267] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1460.040429] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1460.047591] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1460.054752] R13: 0000000000000005 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1460.061918] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1460.070028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1460.075801] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1460.082964] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1460.090132] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1460.097295] PKRU: 55555554
[ 1460.100033] Call Trace:
[ 1460.102511]  <TASK>
[ 1460.104641]  ? __warn+0xce/0x210
[ 1460.107905]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.114203]  ? report_bug+0xbd/0x160
[ 1460.117808]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.124111]  ? handle_bug+0x63/0x90
[ 1460.127639]  ? exc_invalid_op+0x1a/0x50
[ 1460.131511]  ? asm_exc_invalid_op+0x1a/0x20
[ 1460.135729]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.142026]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.148321]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1460.154450]  pt_update_intercept_for_msr+0x19e/0x2d0 [kvm_intel]
[ 1460.160489]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.165600]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1460.170258]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.175363]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1460.179604]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.184706]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1460.189644]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1460.194146]  ? __mutex_lock+0x65/0xbe0
[ 1460.197924]  ? __mutex_lock+0x231/0xbe0
[ 1460.201789]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1460.206377]  ? kfree+0x4a/0x380
[ 1460.209553]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1460.214302]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1460.218718]  ? vma_end_read+0x14/0xf0
[ 1460.222418]  ? vma_end_read+0xd2/0xf0
[ 1460.226117]  __se_sys_ioctl+0x6b/0xc0
[ 1460.229811]  do_syscall_64+0x83/0x160
[ 1460.233521]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1460.238610] RIP: 0033:0x45d93b
[ 1460.241699] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1460.260470] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1460.268067] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1460.275228] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1460.282390] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1460.289557] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1460.296718] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1460.303887]  </TASK>
[ 1460.306114] irq event stamp: 14023
[ 1460.309551] hardirqs last  enabled at (14033): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1460.318187] hardirqs last disabled at (14042): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1460.326831] softirqs last  enabled at (14070): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1460.335378] softirqs last disabled at (14083): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1460.343926] ---[ end trace 0000000000000000 ]---
[ 1460.348579] ------------[ cut here ]------------
[ 1460.353231] Invalid MSR 58c, please adapt vmx_possible_passthrough_msrs[]
[ 1460.353237] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.371028] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1460.388254] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1460.398631] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1460.403459] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1460.410967] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.417877] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1460.436658] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1460.441918] RAX: 49af8c020dc11100 RBX: 000000000000058c RCX: 0000000000000027
[ 1460.449083] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1460.456247] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1460.463406] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1460.470566] R13: 0000000000000006 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1460.477728] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1460.485848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1460.491623] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1460.498787] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1460.505952] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1460.513119] PKRU: 55555554
[ 1460.515861] Call Trace:
[ 1460.518335]  <TASK>
[ 1460.520473]  ? __warn+0xce/0x210
[ 1460.523737]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.530041]  ? report_bug+0xbd/0x160
[ 1460.533654]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.539952]  ? handle_bug+0x63/0x90
[ 1460.543477]  ? exc_invalid_op+0x1a/0x50
[ 1460.547344]  ? asm_exc_invalid_op+0x1a/0x20
[ 1460.551565]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.557869]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.564171]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1460.570300]  pt_update_intercept_for_msr+0x18e/0x2d0 [kvm_intel]
[ 1460.576335]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.581440]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1460.586096]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.591202]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1460.595449]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.600564]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1460.605503]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1460.610009]  ? __mutex_lock+0x65/0xbe0
[ 1460.613797]  ? __mutex_lock+0x231/0xbe0
[ 1460.617669]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1460.622267]  ? kfree+0x4a/0x380
[ 1460.625445]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1460.630186]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1460.634605]  ? vma_end_read+0x14/0xf0
[ 1460.638306]  ? vma_end_read+0xd2/0xf0
[ 1460.642004]  __se_sys_ioctl+0x6b/0xc0
[ 1460.645704]  do_syscall_64+0x83/0x160
[ 1460.649397]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1460.654485] RIP: 0033:0x45d93b
[ 1460.657578] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1460.676348] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1460.683942] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1460.691108] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1460.698271] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1460.705432] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1460.712594] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1460.719757]  </TASK>
[ 1460.721980] irq event stamp: 15053
[ 1460.725410] hardirqs last  enabled at (15063): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1460.734047] hardirqs last disabled at (15072): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1460.742686] softirqs last  enabled at (15104): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1460.751238] softirqs last disabled at (15115): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1460.759781] ---[ end trace 0000000000000000 ]---
[ 1460.764428] ------------[ cut here ]------------
[ 1460.769071] Invalid MSR 58d, please adapt vmx_possible_passthrough_msrs[]
[ 1460.769077] WARNING: CPU: 0 PID: 40110 at arch/x86/kvm/vmx/vmx.c:701 vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.786863] Modules linked in: kvm_intel kvm vfat fat dummy bridge stp llc intel_vsec cdc_acm cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd [last unloaded: kvm_intel]
[ 1460.804086] CPU: 0 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1460.814453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1460.819275] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1460.826784] RIP: 0010:vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.833692] Code: 00 00 c3 cc cc cc cc cc b8 02 00 00 00 c3 cc cc cc cc cc b8 0f 00 00 00 c3 cc cc cc cc cc 48 c7 c7 af ed ac c0 e8 4e 80 43 ee <0f> 0b b8 fe ff ff ff c3 cc cc cc cc cc 90 90 90 90 90 90 90 90 90
[ 1460.852464] RSP: 0018:ff31455ca2bbfc78 EFLAGS: 00010246
[ 1460.857716] RAX: 49af8c020dc11100 RBX: 000000000000058d RCX: 0000000000000027
[ 1460.864876] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: ff31459afc420b08
[ 1460.872035] RBP: 0000000000000003 R08: 000000000000ffff R09: ff3145dbffc5f000
[ 1460.879203] R10: 000000000002fffd R11: 0000000000000004 R12: 000000000000240d
[ 1460.886372] R13: 0000000000000006 R14: ff31455ce186ce80 R15: ff31455cf6c9a000
[ 1460.893543] FS:  000000003d6523c0(0000) GS:ff31459afc400000(0000) knlGS:0000000000000000
[ 1460.901658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1460.907445] CR2: 000000003d6567c8 CR3: 0000000137ca0003 CR4: 0000000000f73ef0
[ 1460.914605] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1460.921759] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1460.928920] PKRU: 55555554
[ 1460.931657] Call Trace:
[ 1460.934138]  <TASK>
[ 1460.936276]  ? __warn+0xce/0x210
[ 1460.939539]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.945842]  ? report_bug+0xbd/0x160
[ 1460.949459]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.955756]  ? handle_bug+0x63/0x90
[ 1460.959284]  ? exc_invalid_op+0x1a/0x50
[ 1460.963153]  ? asm_exc_invalid_op+0x1a/0x20
[ 1460.967368]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.973665]  ? vmx_get_passthrough_msr_slot+0x222/0x230 [kvm_intel]
[ 1460.979961]  vmx_disable_intercept_for_msr+0x38/0x170 [kvm_intel]
[ 1460.986086]  pt_update_intercept_for_msr+0x19e/0x2d0 [kvm_intel]
[ 1460.992125]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1460.997233]  vmx_set_msr+0xae3/0xbf0 [kvm_intel]
[ 1461.001891]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1461.006999]  __kvm_set_msr+0xa3/0x180 [kvm]
[ 1461.011248]  ? kvm_arch_vcpu_ioctl+0x2e2/0x1150 [kvm]
[ 1461.016361]  kvm_arch_vcpu_ioctl+0xf10/0x1150 [kvm]
[ 1461.021301]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.025795]  ? __mutex_lock+0x65/0xbe0
[ 1461.029575]  ? __mutex_lock+0x231/0xbe0
[ 1461.033438]  ? kvm_vcpu_ioctl+0x589/0x620 [kvm]
[ 1461.038032]  ? kfree+0x4a/0x380
[ 1461.041209]  ? __mutex_unlock_slowpath+0x3a/0x230
[ 1461.045950]  kvm_vcpu_ioctl+0x4f8/0x620 [kvm]
[ 1461.050370]  ? vma_end_read+0x14/0xf0
[ 1461.054069]  ? vma_end_read+0xd2/0xf0
[ 1461.057768]  __se_sys_ioctl+0x6b/0xc0
[ 1461.061463]  do_syscall_64+0x83/0x160
[ 1461.065160]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.070244] RIP: 0033:0x45d93b
[ 1461.073335] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1461.092107] RSP: 002b:00007fffccda3ba0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1461.099706] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1461.106867] RDX: 00007fffccda3c00 RSI: 000000004008ae89 RDI: 0000000000000005
[ 1461.114035] RBP: 000000000000240d R08: 0000000000000000 R09: 0000000000000007
[ 1461.121198] R10: 000000003d6563ec R11: 0000000000000246 R12: 0000000000000570
[ 1461.128364] R13: 00000000004f5b40 R14: 0000000000000002 R15: 0000000000000002
[ 1461.135530]  </TASK>
[ 1461.137753] irq event stamp: 16059
[ 1461.141183] hardirqs last  enabled at (16069): [<ffffffffaef6b916>] __console_unlock+0x76/0xa0
[ 1461.149819] hardirqs last disabled at (16078): [<ffffffffaef6b8fb>] __console_unlock+0x5b/0xa0
[ 1461.158458] softirqs last  enabled at (16046): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1461.167003] softirqs last disabled at (16041): [<ffffffffaeed4d3a>] __irq_exit_rcu+0x6a/0x100
[ 1461.175545] ---[ end trace 0000000000000000 ]---
[ 1461.201335] kvm_intel: PT tracing already disabled, RTIT_CTL = 0
[ 1461.207370] unchecked MSR access error: RDMSR from 0x584 at rIP: 0xffffffffc0a9d5a7 (pt_save_msr+0x77/0x1a0 [kvm_intel])
[ 1461.218257] Call Trace:
[ 1461.220731]  <TASK>
[ 1461.222861]  ? fixup_exception+0x50e/0x580
[ 1461.226985]  ? up+0x14/0x50
[ 1461.229802]  ? gp_try_fixup_and_notify+0x34/0xe0
[ 1461.234438]  ? exc_general_protection+0xe5/0x1f0
[ 1461.239073]  ? lock_release+0xf7/0x310
[ 1461.242845]  ? prb_read_valid+0x29/0x50
[ 1461.246700]  ? asm_exc_general_protection+0x26/0x30
[ 1461.251603]  ? pt_save_msr+0x77/0x1a0 [kvm_intel]
[ 1461.256330]  vmx_vcpu_run+0x687/0xb20 [kvm_intel]
[ 1461.261063]  ? lockdep_hardirqs_on_prepare+0x163/0x250
[ 1461.266221]  ? lock_release+0xf7/0x310
[ 1461.269997]  ? kvm_arch_vcpu_ioctl_run+0x9f/0x2720 [kvm]
[ 1461.275360]  kvm_arch_vcpu_ioctl_run+0x1784/0x2720 [kvm]
[ 1461.280718]  ? kvm_arch_vcpu_ioctl_run+0x9f/0x2720 [kvm]
[ 1461.286075]  ? arch_get_unmapped_area_topdown+0x27d/0x2d0
[ 1461.291492]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.295980]  ? lock_acquire+0xd9/0x260
[ 1461.299749]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.304237]  ? get_task_pid+0x20/0x1a0
[ 1461.308012]  ? lock_acquire+0xd9/0x260
[ 1461.311786]  ? get_task_pid+0x20/0x1a0
[ 1461.315561]  ? lock_release+0xf7/0x310
[ 1461.319337]  ? get_task_pid+0x20/0x1a0
[ 1461.323110]  ? get_task_pid+0x20/0x1a0
[ 1461.326886]  kvm_vcpu_ioctl+0x54f/0x620 [kvm]
[ 1461.331287]  ? vm_mmap_pgoff+0x119/0x1b0
[ 1461.335231]  __se_sys_ioctl+0x6b/0xc0
[ 1461.338914]  do_syscall_64+0x83/0x160
[ 1461.342598]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.347668] RIP: 0033:0x45d93b
[ 1461.350748] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1461.369518] RSP: 002b:00007fffccda3740 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1461.377111] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1461.384267] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
[ 1461.391416] RBP: 000000003d655e60 R08: 0000000000000006 R09: 0000000000005000
[ 1461.398566] R10: 0000000000000001 R11: 0000000000000246 R12: 000000003d653840
[ 1461.405720] R13: 0000000000000006 R14: 0000000000000002 R15: 0000000000000002
[ 1461.412879]  </TASK>
[ 1461.415101] kvm_intel: Loading guest Intel PT MSRs
[ 1461.420361] kvm_intel: Cleared RTIT_CTL
[ 1461.424252] kvm_intel: Cleared RTIT_CTL
[ 1461.428126] kvm_intel: Cleared RTIT_CTL
[ 1461.432002] kvm_intel: Cleared RTIT_CTL
[ 1461.435868] kvm_intel: Cleared RTIT_CTL
[ 1461.439736] kvm_intel: Cleared RTIT_CTL
[ 1461.443644] pt: ToPA ERROR encountered, trying to recover

[ 1461.443652] ======================================================
[ 1461.443653] WARNING: possible circular locking dependency detected
[ 1461.443654] 6.12.0-smp--65cbdf61cc85-dbg #445 Tainted: G S      W         
[ 1461.443655] ------------------------------------------------------
[ 1461.443656] intel_pt/40110 is trying to acquire lock:
[ 1461.443657] ffffffffb0672898 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x12/0x40
[ 1461.443660] 
               but task is already holding lock:\x00k:
[ 1461.443660] ff31455cac47a618 (&ctx->lock){-...}-{2:2}, at: __perf_event_task_sched_out+0x2f8/0x3a0
[ 1461.443663] 
               which lock already depends on the new lock.
\x00.\x0a
[ 1461.443664] 
               the existing dependency chain (in reverse order) is:\x00s:
[ 1461.443664] 
               -> #3 (&ctx->lock){-...}-{2:2}:\x00}:
[ 1461.443665]        _raw_spin_lock+0x30/0x40
[ 1461.443667]        __perf_event_task_sched_out+0x2f8/0x3a0
[ 1461.443669]        __schedule+0xd60/0xda0
[ 1461.443671]        schedule+0xb0/0x140
[ 1461.443672]        xfer_to_guest_mode_handle_work+0x4c/0xc0
[ 1461.443674]        kvm_arch_vcpu_ioctl_run+0x1a1b/0x2720 [kvm]
[ 1461.443708]        kvm_vcpu_ioctl+0x54f/0x620 [kvm]
[ 1461.443735]        __se_sys_ioctl+0x6b/0xc0
[ 1461.443737]        do_syscall_64+0x83/0x160
[ 1461.443738]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.443739] 
               -> #2 (&rq->__lock){-.-.}-{2:2}:\x00}:
[ 1461.443740]        _raw_spin_lock_nested+0x2e/0x40
[ 1461.443742]        __task_rq_lock+0x5d/0x100
[ 1461.443744]        wake_up_new_task+0xf8/0x300
[ 1461.443745]        kernel_clone+0x187/0x340
[ 1461.443746]        user_mode_thread+0xc0/0xf0
[ 1461.443748]        rest_init+0x1f/0x1f0
[ 1461.443749]        start_kernel+0x38f/0x3d0
[ 1461.443750]        x86_64_start_reservations+0x24/0x30
[ 1461.443751]        x86_64_start_kernel+0xa9/0xb0
[ 1461.443752]        common_startup_64+0x13e/0x140
[ 1461.443753] 
               -> #1 (&p->pi_lock){-.-.}-{2:2}:\x00}:
[ 1461.443754]        _raw_spin_lock_irqsave+0x5a/0x90
[ 1461.443755]        try_to_wake_up+0x56/0x840
[ 1461.443756]        up+0x3d/0x50
[ 1461.443757]        __console_unlock+0x6c/0xa0
[ 1461.443758]        console_unlock+0x6c/0x110
[ 1461.443758]        vprintk_emit+0x22e/0x330
[ 1461.443759]        _printk+0x5d/0x80
[ 1461.443761]        do_exit+0x7fb/0xa90
[ 1461.443762]        __x64_sys_exit+0x17/0x20
[ 1461.443764]        x64_sys_call+0x2113/0x2130
[ 1461.443765]        do_syscall_64+0x83/0x160
[ 1461.443766]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.443767] 
               -> #0 ((console_sem).lock){-...}-{2:2}:\x00}:
[ 1461.443768]        __lock_acquire+0x15c0/0x2ea0
[ 1461.443769]        lock_acquire+0xd9/0x260
[ 1461.443770]        _raw_spin_lock_irqsave+0x5a/0x90
[ 1461.443771]        down_trylock+0x12/0x40
[ 1461.443772]        __down_trylock_console_sem+0x46/0xc0
[ 1461.443773]        vprintk_emit+0x115/0x330
[ 1461.443773]        _printk+0x5d/0x80
[ 1461.443774]        pt_handle_status+0x1ad/0x200
[ 1461.443776]        pt_event_stop+0x127/0x200
[ 1461.443777]        event_sched_out+0xd4/0x280
[ 1461.443779]        group_sched_out+0x40/0xc0
[ 1461.443780]        __pmu_ctx_sched_out+0xeb/0x140
[ 1461.443781]        ctx_sched_out+0x124/0x190
[ 1461.443782]        __perf_event_task_sched_out+0x31b/0x3a0
[ 1461.443783]        __schedule+0xd60/0xda0
[ 1461.443785]        schedule+0xb0/0x140
[ 1461.443786]        xfer_to_guest_mode_handle_work+0x4c/0xc0
[ 1461.443787]        kvm_arch_vcpu_ioctl_run+0x1a1b/0x2720 [kvm]
[ 1461.443814]        kvm_vcpu_ioctl+0x54f/0x620 [kvm]
[ 1461.443840]        __se_sys_ioctl+0x6b/0xc0
[ 1461.443842]        do_syscall_64+0x83/0x160
[ 1461.443842]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.443843] 
               other info that might help us debug this:
\x00:\x0a
[ 1461.443844] Chain exists of:
                 (console_sem).lock --> &rq->__lock --> &ctx->lock
\x00k\x0a
[ 1461.443845]  Possible unsafe locking scenario:
\x000a
[ 1461.443845]        CPU0                    CPU1
[ 1461.443845]        ----                    ----
[ 1461.443846]   lock(&ctx->lock);
[ 1461.443846]                                lock(&rq->__lock);
[ 1461.443846]                                lock(&ctx->lock);
[ 1461.443847]   lock((console_sem).lock);
[ 1461.443847] 
                *** DEADLOCK ***
\x00*\x0a
[ 1461.443848] 3 locks held by intel_pt/40110:
[ 1461.443848]  #0: ff31455ce186cf30 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.443876]  #1: ff31459afe235b18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x1a7/0xda0
[ 1461.443878]  #2: ff31455cac47a618 (&ctx->lock){-...}-{2:2}, at: __perf_event_task_sched_out+0x2f8/0x3a0
[ 1461.443880] 
               stack backtrace:\x00e:
[ 1461.443880] CPU: 120 UID: 0 PID: 40110 Comm: intel_pt Tainted: G S      W          6.12.0-smp--65cbdf61cc85-dbg #445
[ 1461.443882] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 1461.443883] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20240508.2-0 06/25/2024
[ 1461.443883] Call Trace:
[ 1461.443884]  <TASK>
[ 1461.443884]  dump_stack_lvl+0x7e/0xc0
[ 1461.443886]  print_circular_bug+0x2e5/0x300
[ 1461.443888]  check_noncircular+0xfd/0x120
[ 1461.443890]  __lock_acquire+0x15c0/0x2ea0
[ 1461.443892]  ? save_trace+0x3d/0x300
[ 1461.443893]  ? _prb_read_valid+0x1c9/0x4d0
[ 1461.443894]  ? down_trylock+0x12/0x40
[ 1461.443895]  lock_acquire+0xd9/0x260
[ 1461.443896]  ? down_trylock+0x12/0x40
[ 1461.443898]  _raw_spin_lock_irqsave+0x5a/0x90
[ 1461.443899]  ? down_trylock+0x12/0x40
[ 1461.443900]  down_trylock+0x12/0x40
[ 1461.443900]  ? _printk+0x5d/0x80
[ 1461.443902]  __down_trylock_console_sem+0x46/0xc0
[ 1461.443903]  vprintk_emit+0x115/0x330
[ 1461.443904]  _printk+0x5d/0x80
[ 1461.443906]  pt_handle_status+0x1ad/0x200
[ 1461.443908]  pt_event_stop+0x127/0x200
[ 1461.443909]  event_sched_out+0xd4/0x280
[ 1461.443911]  group_sched_out+0x40/0xc0
[ 1461.443912]  __pmu_ctx_sched_out+0xeb/0x140
[ 1461.443914]  ctx_sched_out+0x124/0x190
[ 1461.443916]  __perf_event_task_sched_out+0x31b/0x3a0
[ 1461.443917]  ? lock_is_held_type+0x8e/0x130
[ 1461.443918]  __schedule+0xd60/0xda0
[ 1461.443920]  schedule+0xb0/0x140
[ 1461.443922]  xfer_to_guest_mode_handle_work+0x4c/0xc0
[ 1461.443923]  kvm_arch_vcpu_ioctl_run+0x1a1b/0x2720 [kvm]
[ 1461.443950]  ? kvm_arch_vcpu_ioctl_run+0x9f/0x2720 [kvm]
[ 1461.443977]  ? arch_get_unmapped_area_topdown+0x27d/0x2d0
[ 1461.443980]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.444006]  ? lock_acquire+0xd9/0x260
[ 1461.444007]  ? kvm_vcpu_ioctl+0x85/0x620 [kvm]
[ 1461.444034]  ? get_task_pid+0x20/0x1a0
[ 1461.444036]  ? lock_acquire+0xd9/0x260
[ 1461.444036]  ? get_task_pid+0x20/0x1a0
[ 1461.444037]  ? lock_release+0xf7/0x310
[ 1461.444038]  ? get_task_pid+0x20/0x1a0
[ 1461.444039]  ? get_task_pid+0x20/0x1a0
[ 1461.444041]  kvm_vcpu_ioctl+0x54f/0x620 [kvm]
[ 1461.444067]  ? vm_mmap_pgoff+0x119/0x1b0
[ 1461.444069]  __se_sys_ioctl+0x6b/0xc0
[ 1461.444070]  do_syscall_64+0x83/0x160
[ 1461.444072]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1461.444073] RIP: 0033:0x45d93b
[ 1461.444074] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1461.444075] RSP: 002b:00007fffccda3740 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1461.444076] RAX: ffffffffffffffda RBX: 000000003d655e60 RCX: 000000000045d93b
[ 1461.444076] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
[ 1461.444077] RBP: 000000003d655e60 R08: 0000000000000006 R09: 0000000000005000
[ 1461.444077] R10: 0000000000000001 R11: 0000000000000246 R12: 000000003d653840
[ 1461.444078] R13: 0000000000000006 R14: 0000000000000002 R15: 0000000000000002
[ 1461.444079]  </TASK>




