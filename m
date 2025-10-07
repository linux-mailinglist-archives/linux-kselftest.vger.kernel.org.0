Return-Path: <linux-kselftest+bounces-42848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352BBC21AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508821889267
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5102E7BD4;
	Tue,  7 Oct 2025 16:22:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9032E7F0D;
	Tue,  7 Oct 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854173; cv=none; b=MUrt9sZsU/0u00rXGrse9HrhrROYq8NX/dMZWFbVyqatL7XDqmU0qYNBeGscZvMYTCFZt96Z6yYS3hGthOGiufOuoKguvrfrp0T+y5S1TKsEmhgL+NtGHLbRd7wRA0dnezi4NNYNbBE849LaCIVWD7lHkzOGwLO+wPMIvyAIaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854173; c=relaxed/simple;
	bh=FxtD5IGXeq7MCAvR+IxCPdcBc032QcgvLySh7UVr4uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AqA5VF4qmzViv/MzI5G7XaVHzIyiZVXGfHHfyx2AUjhmy+CtUH3shsibn9J0OoBF+siIsnBqNzXoTf+uxzAFrU/dPcU68U/Q3dPfd0fsFqV+A/D6gbHu/0+VxN9MmOd/gpQzuE6cj8ex4A48s4hjF1fMqKQsnGKkQ5YIY6MUmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ch16R56SFz9sSC;
	Tue,  7 Oct 2025 17:59:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osQ9mmBknqDa; Tue,  7 Oct 2025 17:59:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ch16R41Z2z9sRy;
	Tue,  7 Oct 2025 17:59:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 799A68B770;
	Tue,  7 Oct 2025 17:59:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id z2pXmbf4wtaa; Tue,  7 Oct 2025 17:59:27 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D16208B76E;
	Tue,  7 Oct 2025 17:59:26 +0200 (CEST)
Message-ID: <feadc4f6-839b-4c04-b6df-dedf279fb315@csgroup.eu>
Date: Tue, 7 Oct 2025 17:59:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected][linux-next20251003] tmp2 selftests resulting in Kernel
 OOPs
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linux-kselftest@vger.kernel.org,
 daleksan@redhat.com, jstancek@redhat.com, jarkko@kernel.org,
 pmenzel@molgen.mpg.de
References: <88f1df7e-8347-45f7-a2a1-e321e72e4009@linux.ibm.com>
 <3d7a5f70-7ece-48ba-92bd-8b6473fd8b6c@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <3d7a5f70-7ece-48ba-92bd-8b6473fd8b6c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/10/2025 à 17:08, Venkat Rao Bagalkote a écrit :
> 
> On 07/10/25 10:59 am, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>>
>> IBM CI has reported a kernel OOPs while running TPM2selftests on IBM 
>> Power11 system with linux-next20251002 kernel.
>>
>>
>> Test Case:
>>
>> make run_tests
>> TAP version 13
>> 1..3
>> # timeout set to 600
>> # selftests: tpm2: test_smoke.sh
>> # test_read_partial_overwrite (tpm2_tests.SmokeTest) ... ok
>> # test_read_partial_resp (tpm2_tests.SmokeTest) ... ok
>> # test_seal_with_auth (tpm2_tests.SmokeTest) ... ok
>> # test_seal_with_policy (tpm2_tests.SmokeTest) ... ok
>> # test_seal_with_too_long_auth (tpm2_tests.SmokeTest) ... ok
>> # test_send_two_cmds (tpm2_tests.SmokeTest) ... ok
>> # test_too_short_cmd (tpm2_tests.SmokeTest) ... ok
>> # test_unseal_with_wrong_auth (tpm2_tests.SmokeTest) ... ok
>> # test_unseal_with_wrong_policy (tpm2_tests.SmokeTest) ... ERROR
>> #
>> # ======================================================================
>> # ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
>> # -----------------------------------------------------
>>
>>
>> Traces:
>>
>>
>> [  452.604333] BUG: KASAN: slab-use-after-free in tpmrm_release+0x78/0xa8
>> [  452.604345] Read of size 8 at addr c00000001c650000 by task 
>> python3/1856
>> [  452.604353]
>> [  452.604358] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded 
>> Not tainted 6.17.0-next-20251003 #1 VOLUNTARY
>> [  452.604364] Hardware name: IBM,9080-HEX Power11 (architected) 
>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [  452.604368] Call Trace:
>> [  452.604370] [c0000000c1867840] [c00000000187ea4c] 
>> dump_stack_lvl+0x84/0xe8 (unreliable)
>> [  452.604380] [c0000000c1867870] [c000000000803754] 
>> print_address_description.constprop.0+0x11c/0x56c
>> [  452.604388] [c0000000c1867910] [c000000000803c84] 
>> print_report+0xe0/0x358
>> [  452.604394] [c0000000c18679e0] [c000000000804124] 
>> kasan_report+0x128/0x1f4
>> [  452.604400] [c0000000c1867af0] [c0000000008062b4] 
>> __asan_load8+0xa8/0xe0
>> [  452.604406] [c0000000c1867b10] [c000000000f2ec18] 
>> tpmrm_release+0x78/0xa8
>> [  452.604412] [c0000000c1867b40] [c0000000008b6a2c] __fput+0x21c/0x60c
>> [  452.604417] [c0000000c1867bc0] [c0000000008ada70] sys_close+0x74/0xd0
>> [  452.604424] [c0000000c1867bf0] [c000000000039270] 
>> system_call_exception+0x1e0/0x460
>> [  452.604431] [c0000000c1867e50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>> [  452.604438] ---- interrupt: 3000 at 0x7fffb7534ab4
>> [  452.604443] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: 
>> 0000000000000000
>> [  452.604446] REGS: c0000000c1867e80 TRAP: 3000   Not tainted 
>> (6.17.0-next-20251003)
>> [  452.604449] MSR:  800000000280f033 
>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
>> [  452.604466] IRQMASK: 0
>> [  452.604466] GPR00: 0000000000000006 00007ffff65d76b0 
>> 00007fffb7c17700 0000000000000006
>> [  452.604466] GPR04: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000004
>> [  452.604466] GPR08: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [  452.604466] GPR12: 0000000000000000 00007fffb7e6b8e0 
>> 00000000000000a1 00007fffb67acec0
>> [  452.604466] GPR16: 0000000164032ad0 00007fffb67aceb0 
>> 00007fffb76f6a90 0000000000000000
>> [  452.604466] GPR20: 00007fffb6f21850 0000000000000000 
>> 00007fffb71062c0 0000000164034490
>> [  452.604466] GPR24: 00007fffb6f2fea0 00007fffb67acea8 
>> 0000000164032b18 00007fffb7c45b32
>> [  452.604466] GPR28: 00007fffb7c678e0 00007fffb67aceb8 
>> 0000000000000006 0000000164034490
>> [  452.604510] NIP [00007fffb7534ab4] 0x7fffb7534ab4
>> [  452.604513] LR [00007fffb7534ab4] 0x7fffb7534ab4
>> [  452.604516] ---- interrupt: 3000
>> [  452.604518]
>> [  452.604601] Allocated by task 1856:
>> [  452.604607]  kasan_save_stack+0x34/0x64
>> [  452.604614]  kasan_save_track+0x2c/0x50
>> [  452.604621]  kasan_save_alloc_info+0x58/0x74
>> [  452.604628]  __kasan_kmalloc+0x12c/0x168
>> [  452.604635]  __kmalloc_cache_noprof+0x1d8/0x71c
>> [  452.604643]  tpmrm_open+0x88/0x168
>> [  452.604649]  chrdev_open+0x1f4/0x484
>> [  452.604656]  do_dentry_open+0x578/0x9cc
>> [  452.604663]  vfs_open+0x68/0x23c
>> [  452.604670]  do_open+0x514/0x74c
>> [  452.604676]  path_openat+0x16c/0x380
>> [  452.604682]  do_filp_open+0x104/0x230
>> [  452.604689]  do_sys_openat2+0xb8/0x154
>> [  452.604696]  sys_openat+0xcc/0x130
>> [  452.604703]  system_call_exception+0x1e0/0x460
>> [  452.604710]  system_call_vectored_common+0x15c/0x2ec
>> [  452.604718]
>> [  452.604722] Freed by task 1856:
>> [  452.604726]  kasan_save_stack+0x34/0x64
>> [  452.604733]  kasan_save_track+0x2c/0x50
>> [  452.604739]  __kasan_save_free_info+0x64/0x110
>> [  452.604747]  __kasan_slab_free+0xb0/0x10c
>> [  452.604753]  kfree+0x220/0x624
>> [  452.604760]  tpmrm_release+0x6c/0xa8
>> [  452.604766]  __fput+0x21c/0x60c
>> [  452.604772]  sys_close+0x74/0xd0
>> [  452.604779]  system_call_exception+0x1e0/0x460
>> [  452.604786]  system_call_vectored_common+0x15c/0x2ec
>> [  452.604794]
>> [  452.604797] The buggy address belongs to the object at 
>> c00000001c650000
>> [  452.604797]  which belongs to the cache kmalloc-8k of size 8192
>> [  452.604806] The buggy address is located 0 bytes inside of
>> [  452.604806]  freed 8192-byte region [c00000001c650000, 
>> c00000001c652000)
>> [  452.604815]
>> [  452.604818] The buggy address belongs to the physical page:
>> [  452.604824] page: refcount:0 mapcount:0 mapping:0000000000000000 
>> index:0xc00000001c644000 pfn:0x1c60
>> [  452.604833] head: order:3 mapcount:0 entire_mapcount:0 
>> nr_pages_mapped:0 pincount:0
>> [  452.604840] flags: 0x3ffffe00000040(head|node=0|zone=0| 
>> lastcpupid=0x1fffff)
>> [  452.604849] page_type: f5(slab)
>> [  452.604856] raw: 003ffffe00000040 c000000007012300 5deadbeef0000122 
>> 0000000000000000
>> [  452.604864] raw: c00000001c644000 000000008020001e 00000000f5000000 
>> 0000000000000000
>> [  452.604872] head: 003ffffe00000040 c000000007012300 
>> 5deadbeef0000122 0000000000000000
>> [  452.604879] head: c00000001c644000 000000008020001e 
>> 00000000f5000000 0000000000000000
>> [  452.604887] head: 003ffffe00000003 c00c000000071801 
>> 00000000ffffffff 00000000ffffffff
>> [  452.604894] head: ffffffffffffffff 0000000000000000 
>> 00000000ffffffff 0000000000000008
>> [  452.604900] page dumped because: kasan: bad access detected
>> [  452.604905]
>> [  452.604908] Memory state around the buggy address:
>> [  452.604914]  c00000001c64ff00: fc fc fc fc fc fc fc fc fc fc fc fc 
>> fc fc fc fc
>> [  452.604920]  c00000001c64ff80: fc fc fc fc fc fc fc fc fc fc fc fc 
>> fc fc fc fc
>> [  452.604927] >c00000001c650000: fa fb fb fb fb fb fb fb fb fb fb fb 
>> fb fb fb fb
>> [  452.604933]                    ^
>> [  452.604937]  c00000001c650080: fb fb fb fb fb fb fb fb fb fb fb fb 
>> fb fb fb fb
>> [  452.604944]  c00000001c650100: fb fb fb fb fb fb fb fb fb fb fb fb 
>> fb fb fb fb
>> [  452.604950] 
>> ==================================================================
>> [  452.604955] Disabling lock debugging due to kernel taint
>> [  452.604961] Kernel attempted to read user page (770) - exploit 
>> attempt? (uid: 0)
>> [  452.604969] BUG: Kernel NULL pointer dereference on read at 0x00000770
>> [  452.604975] Faulting instruction address: 0xc0000000002b2e0c
>> [  452.604982] Oops: Kernel access of bad area, sig: 11 [#1]
>> [  452.604987] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
>> [  452.604996] Modules linked in: nft_fib_inet nft_fib_ipv4 
>> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
>> nft_reject nft_ct nft_chain_nat nf_nat bonding nf_conntrack tls 
>> nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink sunrpc 
>> pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi 
>> ibmveth scsi_transport_srp pseries_wdt
>> [  452.605073] CPU: 24 UID: 0 PID: 1856 Comm: python3 Kdump: loaded 
>> Tainted: G    B               6.17.0-next-20251003 #1 VOLUNTARY
>> [  452.605084] Tainted: [B]=BAD_PAGE
>> [  452.605089] Hardware name: IBM,9080-HEX Power11 (architected) 
>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [  452.605096] NIP:  c0000000002b2e0c LR: c0000000002b2e08 CTR: 
>> 0000000000000000
>> [  452.605103] REGS: c0000000c1867820 TRAP: 0300   Tainted: G B       
>> (6.17.0-next-20251003)
>> [  452.605110] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
>> 28284420  XER: 0000000d
>> [  452.605132] CFAR: c000000000807920 DAR: 0000000000000770 DSISR: 
>> 40000000 IRQMASK: 0
>> [  452.605132] GPR00: c0000000002b2e08 c0000000c1867ac0 
>> c00000000234a500 0000000000000001
>> [  452.605132] GPR04: 0000000000000008 0000000000000000 
>> c0000000002b2e08 0000000000000001
>> [  452.605132] GPR08: 0000000000000020 0000000000000001 
>> 0000000000000001 a80e000000000000
>> [  452.605132] GPR12: c00e0000009b1c8c c000000d0ddeb700 
>> 0000000000000000 0000000000000000
>> [  452.605132] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [  452.605132] GPR20: 0000000000000008 0000000000000000 
>> c000000008202f00 c00000007b9ff620
>> [  452.605132] GPR24: c00000008a76cb20 c00000008a76cb40 
>> c00000008a76cb08 c000000002201e80
>> [  452.605132] GPR28: c000000061569248 0000000000000770 
>> c00000008a76cb00 0000000000000768
>> [  452.605227] NIP [c0000000002b2e0c] up_read+0x50/0x17c
>> [  452.605237] LR [c0000000002b2e08] up_read+0x4c/0x17c
>> [  452.605245] Call Trace:
>> [  452.605249] [c0000000c1867ac0] [c0000000002b2e08] 
>> up_read+0x4c/0x17c (unreliable)
>> [  452.605261] [c0000000c1867b10] [c000000000f2ec28] 
>> tpmrm_release+0x88/0xa8
>> [  452.605271] [c0000000c1867b40] [c0000000008b6a2c] __fput+0x21c/0x60c
>> [  452.605280] [c0000000c1867bc0] [c0000000008ada70] sys_close+0x74/0xd0
>> [  452.605291] [c0000000c1867bf0] [c000000000039270] 
>> system_call_exception+0x1e0/0x460
>> [  452.605301] [c0000000c1867e50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>> [  452.605312] ---- interrupt: 3000 at 0x7fffb7534ab4
>> [  452.605319] NIP:  00007fffb7534ab4 LR: 00007fffb7534ab4 CTR: 
>> 0000000000000000
>> [  452.605326] REGS: c0000000c1867e80 TRAP: 3000   Tainted: G B       
>> (6.17.0-next-20251003)
>> [  452.605333] MSR:  800000000280f033 
>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44284422  XER: 00000000
>> [  452.605362] IRQMASK: 0
>> [  452.605362] GPR00: 0000000000000006 00007ffff65d76b0 
>> 00007fffb7c17700 0000000000000006
>> [  452.605362] GPR04: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000004
>> [  452.605362] GPR08: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [  452.605362] GPR12: 0000000000000000 00007fffb7e6b8e0 
>> 00000000000000a1 00007fffb67acec0
>> [  452.605362] GPR16: 0000000164032ad0 00007fffb67aceb0 
>> 00007fffb76f6a90 0000000000000000
>> [  452.605362] GPR20: 00007fffb6f21850 0000000000000000 
>> 00007fffb71062c0 0000000164034490
>> [  452.605362] GPR24: 00007fffb6f2fea0 00007fffb67acea8 
>> 0000000164032b18 00007fffb7c45b32
>> [  452.605362] GPR28: 00007fffb7c678e0 00007fffb67aceb8 
>> 0000000000000006 0000000164034490
>> [  452.605450] NIP [00007fffb7534ab4] 0x7fffb7534ab4
>> [  452.605456] LR [00007fffb7534ab4] 0x7fffb7534ab4
>> [  452.605462] ---- interrupt: 3000
>> [  452.605467] Code: fbc1fff0 7c7f1b78 f8010010 f821ffb1 e92d0c78 
>> f9210028 39200000 3ba30008 38800008 7fa3eb78 48554af5 60000000 
>> <ebdf0008> eb8d0908 7bc90764 fbc10020
>> [  452.605501] ---[ end trace 0000000000000000 ]---
>> [  452.613685] pstore: backend (nvram) writing error (-1)
>> [  452.613691]
>>
>>
> 
> Git bisect is pointing to eb28a2adba0654878bcfd909b429bf567b35922b as 
> first bad commit.

Should be fixed by the following change ?

diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index 13322dd9ac9e0..334b3ec2b36a5 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -54,8 +54,8 @@ static int tpmrm_release(struct inode *inode, struct 
file *file)

  	tpm_common_release(file, fpriv);
  	tpm2_del_space(fpriv->chip, &priv->space);
-	kfree(priv);
  	up_read(&fpriv->chip->open_lock);
+	kfree(priv);

  	return 0;
  }


> 
> 
> eb28a2adba0654878bcfd909b429bf567b35922b is the first bad commit
> commit eb28a2adba0654878bcfd909b429bf567b35922b
> Author: Jonathan McDowell <noodles@meta.com>
> Date:   Tue Sep 23 18:10:00 2025 +0100
> 
>      tpm: Ensure exclusive userspace access when using /dev/tpm<n>
> 
>      There is an is_open lock on /dev/tpm<n> that dates back to at least
>      2013, but it only prevents multiple accesses via *this* interface. 
> It is
>      perfectly possible for userspace to use /dev/tpmrm<n>, or the 
> kernel to
>      use the internal interfaces, to access the TPM. For tooling expecting
>      exclusive access, such as firmware updates, this can cause issues.
> 
>      Close the userspace loophole by changing the simple bit lock to a full
>      read/write mutex. Direct /dev/tpm<n> access needs an exclusive write
>      lock, the resource broker continues to allow concurrent access 
> *except*
>      when /dev/tpm<n> is open.
> 
>      Signed-off-by: Jonathan McDowell <noodles@meta.com>
>      Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>      Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
>   drivers/char/tpm/tpm-chip.c  |  1 +
>   drivers/char/tpm/tpm-dev.c   | 14 ++++++++------
>   drivers/char/tpm/tpmrm-dev.c | 20 ++++++++++++++++++--
>   include/linux/tpm.h          |  3 ++-
>   4 files changed, 29 insertions(+), 9 deletions(-)
> 
> 
> 
> Git bisect log:
> 
> 
> git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> git bisect good e5f0a698b34ed76002dc5cff3804a61c80233a7a
> # status: waiting for bad commit, 1 good commit known
> # bad: [47a8d4b89844f5974f634b4189a39d5ccbacd81c] Add linux-next 
> specific files for 20251003
> git bisect bad 47a8d4b89844f5974f634b4189a39d5ccbacd81c
> # good: [f79e772258df311c2cb21594ca0996318e720d28] Merge tag 'media/ 
> v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux- 
> media
> git bisect good f79e772258df311c2cb21594ca0996318e720d28
> # good: [6bda5a67f6a2ae4c0153e693e96bd408d054c732] Merge branch 'xtensa- 
> for-next' of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fjcmvbkbc%2Flinux- 
> xtensa.git&data=05%7C02%7Cchristophe.leroy2%40cs- 
> soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485179363%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=0Y%2BuK%2B%2BkZRoXNH%2FK4Ni4hd3RVZJmX8c2SqoLd40qq2Q%3D&reserved=0
> git bisect good 6bda5a67f6a2ae4c0153e693e96bd408d054c732
> # bad: [09026363ffabf7bb33e0ce000d8bff3e41b0c3de] Merge branch 'next' of 
> https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpcmoore%2Faudit.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485205361%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=XuvSxtgtEAPPm3jl6X02nRyTfSh0EXMCUorpI21Y6Cs%3D&reserved=0
> git bisect bad 09026363ffabf7bb33e0ce000d8bff3e41b0c3de
> # good: [c32d529ea3e39ba4918f3865ef90ef6bddaa498c] Merge branch 'for- 
> next' of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhid%2Fhid.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485215132%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=eOflHx6SriPsE%2FEwEURKIEzRciXVlmsDJ7F%2F1tTJVtk%3D&reserved=0
> git bisect good c32d529ea3e39ba4918f3865ef90ef6bddaa498c
> # good: [3fa51882336f09d1a8a03edf107ef43e3b872fc1] Merge branch 'next' 
> of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fiwlwifi%2Fiwlwifi-next.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485223439%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kf7T2nWCNZ3zKqCl%2FFyIMWoWDqerBMMJJmwEDC3dldo%3D&reserved=0
> git bisect good 3fa51882336f09d1a8a03edf107ef43e3b872fc1
> # good: [acc26ceeebaa1880ceb70379abb3fac92d1007d5] Merge branch 'drm-xe- 
> next' of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Fxe%2Fkernel.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485231891%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=rAhIU15LaLZVLiCngMMd%2FD8WZFNbBbxlqb95l4ZqN3E%3D&reserved=0
> git bisect good acc26ceeebaa1880ceb70379abb3fac92d1007d5
> # good: [3e06c10cef8079782836155d66c2a91798600cfc] Merge branch 'for- 
> next' of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fdevice-mapper%2Flinux-dm.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485239888%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=96H7h%2FqU8AOA6BMX3gRIqFvbwree0RrwBKFiyAbbWqw%3D&reserved=0
> git bisect good 3e06c10cef8079782836155d66c2a91798600cfc
> # bad: [cf305bb4070bef42cea469a6c4e751a63f5cacf2] Merge branch 'next' of 
> https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fjarkko%2Flinux-tpmdd.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485248529%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aYTIA07yF9iCvHBin54NcH7%2Bhcn4wpuUR1%2BCGncndKQ%3D&reserved=0
> git bisect bad cf305bb4070bef42cea469a6c4e751a63f5cacf2
> # good: [19766d4984c39d75393d22cbdad14974cb7f9366] Merge branch 'next' 
> of https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fcschaufler%2Fsmack- 
> next&data=05%7C02%7Cchristophe.leroy2%40cs- 
> soprasteria.com%7C18e20b6baa664009b66c08de05b37367%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638954465485256294%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=SAfMhKzF9h2YURPEqPu6ze2oIUJ87TNyRIFC%2B1JjWGE%3D&reserved=0
> git bisect good 19766d4984c39d75393d22cbdad14974cb7f9366
> # good: [4e349e68974e71da13d4b34988f795f4cfe29650] tpm: use a map for 
> tpm2_calc_ordinal_duration()
> git bisect good 4e349e68974e71da13d4b34988f795f4cfe29650
> # bad: [b6889908d493fe03a1db28aa9afdade6bceda158] tpm: Allow for 
> exclusive TPM access when using /dev/tpm<n>
> git bisect bad b6889908d493fe03a1db28aa9afdade6bceda158
> # bad: [eb28a2adba0654878bcfd909b429bf567b35922b] tpm: Ensure exclusive 
> userspace access when using /dev/tpm<n>
> git bisect bad eb28a2adba0654878bcfd909b429bf567b35922b
> # good: [11baa7201b1baefd281e5a7faf7de5b7e407364c] tpm: Prevent local 
> DOS via tpm/tpm0/ppi/*operations
> git bisect good 11baa7201b1baefd281e5a7faf7de5b7e407364c
> # first bad commit: [eb28a2adba0654878bcfd909b429bf567b35922b] tpm: 
> Ensure exclusive userspace access when using /dev/tpm<n>
> 
>>
>> If you happen to fix this, please add below tag.
>>
>>
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>
>>
>> Regards,
>>
>> Venkat.
>>
> 


