Return-Path: <linux-kselftest+bounces-8510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11908AB7FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A993E28293F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35971422C2;
	Fri, 19 Apr 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aM+8QuBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29A13F441;
	Fri, 19 Apr 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570847; cv=none; b=WUgTX6oLRYSPPhL/Ng7+/yfaiB+aTnvjlcBFpgz7LjX/Gw4Qr00vrZxPLayJ4lk62T00tdeAH9NWNuM3rV0/u1hDUaqqlHPpra10B0MemrlPmPyDqlBBnnLwzzeZ7/lr8pect82SSH8esGTsHpXO6aCZVc2wWXjeCoyH4TJhkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570847; c=relaxed/simple;
	bh=8GE7m676RhbHyGc6Ef+cB3co2RkVph79ZyRb3QpnOWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbohBUY/nFSqxV2k3OkoVpg4cjVQb6xaU0aGApsZT7nEbMHUfD5jp4RdaC7z+DriX7nlWOJeGcbkLouWZ/jcEAnPmvghToVPJmSzPPVpa+wMutDCHQbUHq7GXX+J9p5pHDxqXcXucv6cNOLLi+sv2oHKnMdbnGPA3ZkETZ3Kuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aM+8QuBp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713570846; x=1745106846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8GE7m676RhbHyGc6Ef+cB3co2RkVph79ZyRb3QpnOWs=;
  b=aM+8QuBpjafD3N4l5ghbGywcuLLEFwwHKGiZU6iciHp0lu4dBP+okB9I
   vZe6hJ2/MYWtjoi5eEHUoD4Laz7pLu72DzutOJvoDyHhBGiXp6furcFCt
   KzsqC3lvhcm8z2NjVQQFPUx/IYrmLv3jMjakYTr7gkeiEvaaFiHKeYi2t
   TB1/EExrITeviecehvinEA6HCkEAO26ukBDg9CsS4toKjFrnbSBLhkWPg
   ne/WKtVlwd4ouKD0J8xcneGY74DpU/IuAEPBmvwcYPl6ltHeKBUU2L8zp
   GbzbaAvk6x0suIYYBrKHP1ZmxkzvhJAAOOCJKiGYOQ9EiwIQizxQ+ZbE6
   g==;
X-CSE-ConnectionGUID: PcjiBSFGTvWh9bEdCfkoFQ==
X-CSE-MsgGUID: 1VFC28aPRWSQpZtMzZxdcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9051126"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9051126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 16:54:05 -0700
X-CSE-ConnectionGUID: AQcHAM+7Rg2bWtBu0cN6mg==
X-CSE-MsgGUID: +nIN0VkYRtSwCD/toGjuOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23504164"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.31]) ([10.24.10.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 16:54:06 -0700
Message-ID: <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
Date: Fri, 19 Apr 2024 16:54:05 -0700
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
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/19/2024 11:43 AM, David Woodhouse wrote:
> On 19 April 2024 19:40:06 BST, David Woodhouse <dwmw2@infradead.org> wrote:
>> On 19 April 2024 18:13:16 BST, "Chen, Zide" <zide.chen@intel.com> wrote:
>>> I'm wondering what's the underling theory that we definitely can achieve
>>> ±1ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC frequency,
>>> and I can see delta_corrected=2 in ~2% cases.
>>
>> Hm. Thanks for testing!
>>
>> So the KVM clock is based on the guest TSC. Given a delta between the guest TSC T and some reference point in time R, the KVM clock is expressed as a(T-R)+r, where little r is the value of the KVM clock when the guest TSC was R, and (a) is the rate of the guest TSC.
>>
>> When set the clock with KVM_SET_CLOCK_GUEST, we are changing the values of R and r to a new point in time. Call the new ones Q and q respectively.
>>
>> But we calculate precisely (within 1ns at least) what the KVM clock would have been with the *old* formula, and adjust our new offset (q) so that at our new reference TSC value Q, the formulae give exactly the same result.
>>
>> And because the *rates* are the same, they should continue to give the same results, ±1ns.
>>
>> Or such *was* my theory, at least. 
>>
>> Would be interesting to see it disproven with actual numbers for the old+new pvclock structs, so I can understand where the logic goes wrong.
>>
>> Were you using frequency scaling?
>>
> 
> Oh, also please could you test the updated version I posted yesterday, from https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/clocks

I failed to check out your branch, instead I downloaded the patch series
from:
https://lore.kernel.org/linux-kselftest/FABCFBD0-4B76-4662-9F7B-7E1A856BBBB6@infradead.org/T/#t

However, the selftest hangs:

[Apr19 16:15] kselftest: Running tests in kvm
[Apr19 16:16] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  +0.000628] rcu:      78-...0: (1 GPs behind)
idle=3c8c/1/0x4000000000000000 softirq=5908/5913 fqs=14025
[  +0.000468] rcu:      (detected by 104, t=60003 jiffies, g=60073,
q=3100 ncpus=128)
[  +0.000389] Sending NMI from CPU 104 to CPUs 78:
[  +0.000360] NMI backtrace for cpu 78
[  +0.000004] CPU: 78 PID: 33515 Comm: pvclock_test Tainted: G
O       6.9.0-rc1zide-l0+ #194
[  +0.000003] Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05.08.01
08/18/2023
[  +0.000002] RIP: 0010:pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
[  +0.000079] Code: ea 83 e1 40 48 0f 45 c2 31 d2 48 3d 00 94 35 77 76
0e 48 d1 e8 83 ea 01 48 3d 00 94 35 77 77 f2 48 3d 00 ca 9a 3b 89 c1 77
0d <01> c9 83 c2 01 81 f9 00 ca 9a 3b 76 f3 88 93 8c 95 00 00 31 c0 ba
[  +0.000002] RSP: 0018:ff368a58cfe07e30 EFLAGS: 00000087
[  +0.000002] RAX: 0000000000000000 RBX: ff368a58e0ccd000 RCX:
0000000000000000
[  +0.000001] RDX: 000000005ca49a49 RSI: 00000000000029aa RDI:
0000019ee77a1c00
[  +0.000002] RBP: ff368a58cfe07e50 R08: 0000000000000001 R09:
0000000000000000
[  +0.000000] R10: ff26383d853ab400 R11: 0000000000000002 R12:
0000000000000000
[  +0.000001] R13: ff368a58e0cd6400 R14: 0000000000000293 R15:
ff368a58e0cd69f0
[  +0.000001] FS:  00007f6946473740(0000) GS:ff26384c7fb80000(0000)
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f69463bd445 CR3: 000000016f466006 CR4:
0000000000f71ef0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000000] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
0000000000000400
[  +0.000001] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000004]  <NMI>
[  +0.000003]  ? nmi_cpu_backtrace+0x87/0xf0
[  +0.000008]  ? nmi_cpu_backtrace_handler+0x11/0x20
[  +0.000005]  ? nmi_handle+0x5f/0x170
[  +0.000005]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
[  +0.000045]  ? default_do_nmi+0x79/0x1a0
[  +0.000004]  ? exc_nmi+0xf0/0x130
[  +0.000001]  ? end_repeat_nmi+0xf/0x53
[  +0.000006]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
[  +0.000041]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
[  +0.000040]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
[  +0.000039]  </NMI>
[  +0.000000]  <TASK>
[  +0.000001]  ? preempt_count_add+0x73/0xa0
[  +0.000004]  kvm_arch_init_vm+0xf1/0x1e0 [kvm]
[  +0.000049]  kvm_create_vm+0x370/0x650 [kvm]
[  +0.000036]  kvm_dev_ioctl+0x88/0x180 [kvm]
[  +0.000034]  __x64_sys_ioctl+0x8e/0xd0
[  +0.000007]  do_syscall_64+0x5b/0x120
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
[  +0.000003] RIP: 0033:0x7f694631a94f
[  +0.000002] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f
05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  +0.000001] RSP: 002b:00007ffca91b2e50 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000002] RAX: ffffffffffffffda RBX: 0000000000434480 RCX:
00007f694631a94f
[  +0.000001] RDX: 0000000000000000 RSI: 000000000000ae01 RDI:
0000000000000005
[  +0.000000] RBP: 0000000000000009 R08: 000000000041b198 R09:
000000000041bfbf
[  +0.000001] R10: 00007f69463d8882 R11: 0000000000000246 R12:
0000000000434480
[  +0.000000] R13: 000000000041e0f0 R14: 0000000000001000 R15:
0000000000000207
[  +0.000002]  </TASK>

