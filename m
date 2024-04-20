Return-Path: <linux-kselftest+bounces-8550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BE8ABB00
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4251F2141A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BADDDD9;
	Sat, 20 Apr 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e07pBdHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D910E9;
	Sat, 20 Apr 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713609199; cv=none; b=hzBo0MgIpiwAA8CSQdL5dugsPoRD/6nKpKIUC6W8FEC6MwfqJ+ou6mw6PrigRLNPawzZPb0om9QbhNnfNM3ZV8CsZC+7SQu29x35vhC1A1hieFYGtuJbu4H9HcO1BDK9BrSn1JZq9kKMDECyHZLmmzNtBLrkVecchokhChxH+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713609199; c=relaxed/simple;
	bh=uCBzkeKDUcXAUWXc8aBmUEuXlcrHj3mTawwZyw6cz1U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TwWjWI3wKiZCWyoek3PcHE+I5mdXtlaFiWm8BcImgHxEMRCUecaK6yF073CmpjZoFUazNR+Cv3eoG7zyz9tBrEHeHKvfPxdzex8qPxyIBeNckshxnoYLaLA+B/mnqGPEh5Zn3/wawmWsj6WLdSZkQxW5Ji4d1qj6oLZxciDPVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e07pBdHG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2v0U1qmA++9w1Jh5dVmPOFSqjxrTtrX+D1bwJ59pq+Y=; b=e07pBdHGCC94WzMDzl8xSsHR8D
	jahRw/VHYhwVFeYrXlABBbMnVRfg61r+39eN8DjWF96/y2InBCePsdg5T6cDR0ddyo4NeXohjERMa
	pB0aApbaBd8feKHb9jglruAPmUArOz6enH7bVJl9TuXPlu5iWe65ImBwagAePR0kL4m7xpFXBZ1lp
	BUlS2g47VkY2ZlGo8ZRSjpZ3wSwe8q25zGn7nj2DVuJMptmaRjMjJWt3qcrqZ9nYD7x8bfRHpovXt
	Ybwvnd/LFDtwUynYeqVxRoxD+lNeOEYBhES1+sJ8+lAZVZWRPXxRI8ZNBfk74YzYHERbc7kZfKU6b
	p0eBwzSw==;
Received: from [154.49.97.73] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry81V-0000000CpTY-0Gbi;
	Sat, 20 Apr 2024 10:32:45 +0000
Date: Sat, 20 Apr 2024 11:32:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Chen, Zide" <zide.chen@intel.com>, Jack Allister <jalliste@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>
CC: Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_KVM=3A_selftests=3A_Add_KVM/PV_c?=
 =?US-ASCII?Q?lock_selftest_to_prove_timer_drift_correction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
References: <20240408220705.7637-1-jalliste@amazon.com> <20240408220705.7637-3-jalliste@amazon.com> <3664e8ec-1fa1-48c0-a80d-546b7f6cd671@intel.com> <17F1A2E9-6BAD-40E7-ACDD-B110CFC124B3@infradead.org> <65FF4D51-05A8-42E0-9D07-6E42913CC75E@infradead.org> <6dca783b-6532-4fa7-9e04-1c0a382a00b0@intel.com>
Message-ID: <9412F330-145D-4319-86E1-D5C5FAFBBF9D@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 20 April 2024 00:54:05 BST, "Chen, Zide" <zide=2Echen@intel=2Ecom> wrote=
:
>
>
>On 4/19/2024 11:43 AM, David Woodhouse wrote:
>> On 19 April 2024 19:40:06 BST, David Woodhouse <dwmw2@infradead=2Eorg> =
wrote:
>>> On 19 April 2024 18:13:16 BST, "Chen, Zide" <zide=2Echen@intel=2Ecom> =
wrote:
>>>> I'm wondering what's the underling theory that we definitely can achi=
eve
>>>> =C2=B11ns accuracy? I tested it on a Sapphire Rapids @2100MHz TSC fre=
quency,
>>>> and I can see delta_corrected=3D2 in ~2% cases=2E
>>>
>>> Hm=2E Thanks for testing!
>>>
>>> So the KVM clock is based on the guest TSC=2E Given a delta between th=
e guest TSC T and some reference point in time R, the KVM clock is expresse=
d as a(T-R)+r, where little r is the value of the KVM clock when the guest =
TSC was R, and (a) is the rate of the guest TSC=2E
>>>
>>> When set the clock with KVM_SET_CLOCK_GUEST, we are changing the value=
s of R and r to a new point in time=2E Call the new ones Q and q respective=
ly=2E
>>>
>>> But we calculate precisely (within 1ns at least) what the KVM clock wo=
uld have been with the *old* formula, and adjust our new offset (q) so that=
 at our new reference TSC value Q, the formulae give exactly the same resul=
t=2E
>>>
>>> And because the *rates* are the same, they should continue to give the=
 same results, =C2=B11ns=2E
>>>
>>> Or such *was* my theory, at least=2E=20
>>>
>>> Would be interesting to see it disproven with actual numbers for the o=
ld+new pvclock structs, so I can understand where the logic goes wrong=2E
>>>
>>> Were you using frequency scaling?
>>>
>>=20
>> Oh, also please could you test the updated version I posted yesterday, =
from https://git=2Einfradead=2Eorg/?p=3Dusers/dwmw2/linux=2Egit;a=3Dshortlo=
g;h=3Drefs/heads/clocks
>
>I failed to check out your branch, instead I downloaded the patch series
>from:
>https://lore=2Ekernel=2Eorg/linux-kselftest/FABCFBD0-4B76-4662-9F7B-7E1A8=
56BBBB6@infradead=2Eorg/T/#t
>
>However, the selftest hangs:

Odd=2E It locks up in kvm_arch_init_vm()=2E Maybe when I get back to my de=
sk something will be obvious=2E But please could I have your =2Econfig?

If you're able to bisect and see which patch causes that, it would also be=
 much appreciated=2E Thanks!

>[Apr19 16:15] kselftest: Running tests in kvm
>[Apr19 16:16] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>[  +0=2E000628] rcu:      78-=2E=2E=2E0: (1 GPs behind)
>idle=3D3c8c/1/0x4000000000000000 softirq=3D5908/5913 fqs=3D14025
>[  +0=2E000468] rcu:      (detected by 104, t=3D60003 jiffies, g=3D60073,
>q=3D3100 ncpus=3D128)
>[  +0=2E000389] Sending NMI from CPU 104 to CPUs 78:
>[  +0=2E000360] NMI backtrace for cpu 78
>[  +0=2E000004] CPU: 78 PID: 33515 Comm: pvclock_test Tainted: G
>O       6=2E9=2E0-rc1zide-l0+ #194
>[  +0=2E000003] Hardware name: Inspur NF5280M7/NF5280M7, BIOS 05=2E08=2E0=
1
>08/18/2023
>[  +0=2E000002] RIP: 0010:pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
>[  +0=2E000079] Code: ea 83 e1 40 48 0f 45 c2 31 d2 48 3d 00 94 35 77 76
>0e 48 d1 e8 83 ea 01 48 3d 00 94 35 77 77 f2 48 3d 00 ca 9a 3b 89 c1 77
>0d <01> c9 83 c2 01 81 f9 00 ca 9a 3b 76 f3 88 93 8c 95 00 00 31 c0 ba
>[  +0=2E000002] RSP: 0018:ff368a58cfe07e30 EFLAGS: 00000087
>[  +0=2E000002] RAX: 0000000000000000 RBX: ff368a58e0ccd000 RCX:
>0000000000000000
>[  +0=2E000001] RDX: 000000005ca49a49 RSI: 00000000000029aa RDI:
>0000019ee77a1c00
>[  +0=2E000002] RBP: ff368a58cfe07e50 R08: 0000000000000001 R09:
>0000000000000000
>[  +0=2E000000] R10: ff26383d853ab400 R11: 0000000000000002 R12:
>0000000000000000
>[  +0=2E000001] R13: ff368a58e0cd6400 R14: 0000000000000293 R15:
>ff368a58e0cd69f0
>[  +0=2E000001] FS:  00007f6946473740(0000) GS:ff26384c7fb80000(0000)
>knlGS:0000000000000000
>[  +0=2E000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[  +0=2E000001] CR2: 00007f69463bd445 CR3: 000000016f466006 CR4:
>0000000000f71ef0
>[  +0=2E000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>0000000000000000
>[  +0=2E000000] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
>0000000000000400
>[  +0=2E000001] PKRU: 55555554
>[  +0=2E000001] Call Trace:
>[  +0=2E000004]  <NMI>
>[  +0=2E000003]  ? nmi_cpu_backtrace+0x87/0xf0
>[  +0=2E000008]  ? nmi_cpu_backtrace_handler+0x11/0x20
>[  +0=2E000005]  ? nmi_handle+0x5f/0x170
>[  +0=2E000005]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
>[  +0=2E000045]  ? default_do_nmi+0x79/0x1a0
>[  +0=2E000004]  ? exc_nmi+0xf0/0x130
>[  +0=2E000001]  ? end_repeat_nmi+0xf/0x53
>[  +0=2E000006]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
>[  +0=2E000041]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
>[  +0=2E000040]  ? pvclock_update_vm_gtod_copy+0xb5/0x200 [kvm]
>[  +0=2E000039]  </NMI>
>[  +0=2E000000]  <TASK>
>[  +0=2E000001]  ? preempt_count_add+0x73/0xa0
>[  +0=2E000004]  kvm_arch_init_vm+0xf1/0x1e0 [kvm]
>[  +0=2E000049]  kvm_create_vm+0x370/0x650 [kvm]
>[  +0=2E000036]  kvm_dev_ioctl+0x88/0x180 [kvm]
>[  +0=2E000034]  __x64_sys_ioctl+0x8e/0xd0
>[  +0=2E000007]  do_syscall_64+0x5b/0x120
>[  +0=2E000003]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
>[  +0=2E000003] RIP: 0033:0x7f694631a94f
>[  +0=2E000002] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10
>00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f
>05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
>[  +0=2E000001] RSP: 002b:00007ffca91b2e50 EFLAGS: 00000246 ORIG_RAX:
>0000000000000010
>[  +0=2E000002] RAX: ffffffffffffffda RBX: 0000000000434480 RCX:
>00007f694631a94f
>[  +0=2E000001] RDX: 0000000000000000 RSI: 000000000000ae01 RDI:
>0000000000000005
>[  +0=2E000000] RBP: 0000000000000009 R08: 000000000041b198 R09:
>000000000041bfbf
>[  +0=2E000001] R10: 00007f69463d8882 R11: 0000000000000246 R12:
>0000000000434480
>[  +0=2E000000] R13: 000000000041e0f0 R14: 0000000000001000 R15:
>0000000000000207
>[  +0=2E000002]  </TASK>


