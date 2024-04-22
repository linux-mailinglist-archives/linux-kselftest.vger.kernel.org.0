Return-Path: <linux-kselftest+bounces-8639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D88AD70F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7506AB21ADB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217A1CF9C;
	Mon, 22 Apr 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV7VWp2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644A1C286;
	Mon, 22 Apr 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823404; cv=none; b=G3eAzS69BoQBieMQng+YbcNPyWAqmXJk4wUtKnMh8ibd5UYbVpyRz4jJf8BDbpqX+6LTXYmuMSHIUhE0s8gp9Rj7YGgdOkKroryCLxYlGTlzNrOHM0SJTAWI40+ODoZodf8ODHPNutDOrR+F7I+ddlMX2BSV43Q8iIR2s4wKYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823404; c=relaxed/simple;
	bh=GY0MXRD7EIQgOXVFSSvngeEgnL9PKDqVeT3TM0piVIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDYfpJ8sEQub4vD4DujYba8ZymS6dwERV4L4eZ1ju2RiitLCfvUCzBo4NMd4/xvCc3l3ZSGGwpGXnYo5tkFrn6/vJZLD4TtNNy7VKvaG+p5oSvuplOMMZ6g4mKyG/7Dt2Wl2jWoIlLzz2O2HWC1/VY2dMWiTZh4DoUk2F/XHITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV7VWp2U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713823403; x=1745359403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GY0MXRD7EIQgOXVFSSvngeEgnL9PKDqVeT3TM0piVIs=;
  b=PV7VWp2UI9VZ/Kj2cEIBvXpBBc2ET47RN+2P89JT1MjkNXz2q0Ilr//s
   h1ItFJ3dhKTbj8f2rkH5NBFpc1RFPlwLkx4jCtFgN+7RMitScCKuSl/5b
   5755i9+8w4anJptHWhuGNdwxv2Dkst1tAr9oZfsM6wd6VzZV6hQ/wd7eG
   feUretYgn4903kH9763S1e1W1qPxeJGv+A6QmBPiR3nE4l1gD5aKTy1E7
   tec50Pp7ajTAI9f24DO+JZ6Rjuy2oAo3oFaSgKf52Y83Ol9i7a7sIZM2L
   GMK2QI2Nhu6lxfDVN/3HXVx4ao//rMIx3xS8Q1JE2SzzDjz1jEDRCOEG0
   g==;
X-CSE-ConnectionGUID: be4FNByxQ1CckZBPvbuu4Q==
X-CSE-MsgGUID: G3nao+doTr2jLMyTRSe0fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31875700"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="31875700"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:02:52 -0700
X-CSE-ConnectionGUID: G06rEvsPSBmK/RPfjndAuQ==
X-CSE-MsgGUID: g//wDu7URXmaIJN9nPSsCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28813444"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.61]) ([10.24.10.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:02:51 -0700
Message-ID: <71260288-3666-4419-8283-6565e91aaba4@intel.com>
Date: Mon, 22 Apr 2024 15:02:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
To: David Woodhouse <dwmw2@infradead.org>, Jack Allister
 <jalliste@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240408220705.7637-1-jalliste@amazon.com>
 <20240408220705.7637-3-jalliste@amazon.com>
 <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com>
 <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org>
 <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org>
 <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
 <c863ffcfd4edda9a1a46e3351766a655c5523f7d.camel@infradead.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <c863ffcfd4edda9a1a46e3351766a655c5523f7d.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/20/2024 9:03 AM, David Woodhouse wrote:
> On Fri, 2024-04-19 at 16:54 -0700, Chen, Zide wrote:
>>
>> However, the selftest hangs:
>>
>> [Apr19 16:15] kselftest: Running tests in kvm
>> [Apr19 16:16] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [  +0.000628] rcu:      78-...0: (1 GPs behind) idle=3c8c/1/0x4000000000000000 softirq=5908/5913 fqs=14025
>> [  +0.000468] rcu:      (detected by 104, t=60003 jiffies, g=60073, q=3100 ncpus=128)
>> [  +0.000389] Sending NMI from CPU 104 to CPUs 78:
>> [  +0.000360] NMI backtrace for cpu 78
>> [  +0.000004] CPU: 78 PID: 33515 Comm: pvclock_test Tainted: G O       6.9.0-rc1zide-l0+ #194
>> [  +0.000003] Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05.08.01 08/18/2023
>> [  +0.000002] RIP: 0010:pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
> 
> Ah, kvm_get_time_scale() doesn't much like being asked to scale to zero.
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a07b60351894..45fb99986cf9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3046,7 +3046,8 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
>  		 * Copy from the field protected solely by ka->tsc_write_lock,
>  		 * to the field protected by the ka->pvclock_sc seqlock.
>  		 */
> -		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio;
> +		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio ? :
> +			kvm_caps.default_tsc_scaling_ratio;
>  
>  		/*
>  		 * Calculate the scaling factors precisely the same way
> 		 * that kvm_guest_time_update() does.
>  		last_tsc_hz = kvm_scale_tsc(tsc_khz * 1000,
>                                           ka->last_tsc_scaling_ratio);

Should be ka->master_tsc_scaling_ratio?

If I restored the KVM_REQ_GLOBAL_CLOCK_UPDATE request from
kvm_arch_vcpu_load(), the selftest works for me, and I ran the test for
1000+ iterations, w/ or w/o TSC scaling, the TEST_ASSERT(delta_corrected
 <= ±1) never got hit. This is awesome!

However, without KVM_REQ_GLOBAL_CLOCK_UPDATE, it still fails on creating
a VM. Maybe the init sequence sill needs some rework.

 BUG: unable to handle page fault for address: 005b29e3f221ccf0
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 86 PID: 4118 Comm: pvclock_test Tainted
 Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05.08.01 08/18/2023
 RIP: 0010:start_creating+0x80/0x190
 Code: ce ad 48 c7 c6 70 a1 ce ad 48 c7 c7 80 1c 9b ab e8 b5 10 d5 ff 4c
63 e0 45 85 e4 0f 85 cd 00 00 00 48 85 db 0f 84 b5 00 00 00 <48> 8b 43
30 48 8d b8 b8 >
 RSP: 0018:ff786eaacf3cfdd0 EFLAGS: 00010206
 RAX: 0000000000000000 RBX: 005b29e3f221ccc0 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffadcea170 RDI: 0000000000000000
 RBP: ffffffffc06ac8cf R08: ffffffffa6ea0fe0 R09: ffffffffc06a5940
 R10: ff786eaacf3cfe30 R11: 00000013a7b5feaa R12: 0000000000000000
 R13: 0000000000000124 R14: ff786eaacfa11000 R15: 00000000000081a4
 FS:  00007f0837c89740(0000) GS:ff4f44b6bfd80000(0000)
knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0
 CR2: 005b29e3f221ccf0 CR3: 000000014bdf8002 CR4: 0000000000f73ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x81/0x150
  ? do_user_addr_fault+0x64/0x6c0
  ? exc_page_fault+0x8a/0x1a0
  ? asm_exc_page_fault+0x26/0x30
  ? start_creating+0x80/0x190
  __debugfs_create_file+0x43/0x1f0
  kvm_create_vm_debugfs+0x28b/0x2d0 [kvm]
  kvm_create_vm+0x457/0x650 [kvm]
  kvm_dev_ioctl+0x88/0x180 [kvm]
  __x64_sys_ioctl+0x8e/0xd0
  do_syscall_64+0x5b/0x120
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7f0837b1a94f
 Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89
44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0
3d 00 f0 ff ff >
 RSP: 002b:00007ffe01be3fc0 EFLAGS: 00000246 ORIG_RAX
 RAX: ffffffffffffffda RBX: 0000000000434480 RCX: 00007f0837b1a94f
 RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000005
 RBP: 0000000000000009 R08: 000000000041b1a0 R09: 000000000041bfcf
 R10: 00007f0837bd8882 R11: 0000000000000246 R12: 0000000000434480
 R13: 000000000041e0f0 R14: 0000000000001000 R15: 0000000000000207
  </TASK>
 Modules linked in: kvm_intel(O) kvm(O) [last unloaded: kvm(O)]
 CR2: 005b29e3f221ccf0

