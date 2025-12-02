Return-Path: <linux-kselftest+bounces-46912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C2C9CF1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 21:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2720F4E27FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924072F25F4;
	Tue,  2 Dec 2025 20:44:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74962853F1
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708264; cv=none; b=DjPdQR4y7Mh9mdRueU7nJy/zjprIS2EF/DM9Bpb+GUdgDKL+rAYgAqE7uKDmJBAnSB2Zr8hFMke7ipmO41O815z/Ij+2/azKQP8QeXchBndlFpavRtlXUA7sfIOFe3BsNcz0wweP/Lgi1WAMM/VO6AOMjF+/umd+S4iLMw96a4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708264; c=relaxed/simple;
	bh=IyTQ0+LDYlrueKRoH0+ipJduxi4wUeUYIoh3DtrqyFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Nspn0A/VmDtC4ue9iqWvdL1ccKOYwCkRdE73yueLa+JfbPW1jKLcogDZ2AS/ruU/PZ6qIHKnnvlfu0TYoSQ8gxwDIlNHOWTfMZ/2QmpHInwbTxZAaV2Mh6Dz4a8MDIukwcPdWevgQ/0EoK/3YZ/wL5xQZvpu5HGPUtdnf3alDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4512e9f2f82so5118218b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 12:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708262; x=1765313062;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RjyyTo2j0TjdG2AARxhfmOot6uTSHz1gbkawPQrTgc=;
        b=cngeP/ovXBC+aRrK94jWyLUkgcaafz0/hmfmRQygpoCKHEiwIriESnYRcVBRHS6XQT
         hcf08YIJbHfW7wnig8khldunbF4mGntcUBL+TbcXFMu68uJJwJp87BLH7yotVPay0Srg
         Jn8fhiYML6n/g1iNBgPxbdNluDn4kHCAhY/Cd93ED0HyTz88C6vIq3Kf3eWgON9hl9ce
         AbpJluTbxIRSk023VjOtpyl/XJdKUvq8fw8zJrf8gPmfrQ4qs7Qhm8g3S2ZkNvLTs8j9
         6b3kqs1OwaXwGfHORswcKRzh6W+QGOKJEiv7Ay4O8n2cQCTDnnL58U2LDmTFYjfleiya
         dt5g==
X-Forwarded-Encrypted: i=1; AJvYcCXPcw7dpfb+wcfwX/gbyHPJHlMf3BMAq/8u9spkO0ZOBpySmmLjHw9+PvFp4R8rEAdmklnd+ch3mRhJYvMxOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFJqfY6C4eOXm61wGNEDF2ar9IMW3Y01NmLqYdLlriwi6MoQG
	U1Gi9Z3Xe6w1n4phjQwKdfR/Qvr/cuZ9w+la/TyTDTpF3LmUO75kCOacjHh/QfXmnhST2SjLXbX
	vmxFzpd3/iFNHbuhEwrkK9wexJwUFz8VZsdDkCKOyLBDxNsha1ijxXmjTmX4=
X-Google-Smtp-Source: AGHT+IGcno7lTm3KlUfyyg6HxcRNEihdvBlo41dTmfnSxwTQvFOBjfvGHG5YVFGLwpOggsBIX7u+TikcWdt8XtDaLJYmMGOgexaJ
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:448e:b0:450:bf48:835f with SMTP id
 5614622812f47-45112bb85c5mr18603481b6e.43.1764708261842; Tue, 02 Dec 2025
 12:44:21 -0800 (PST)
Date: Tue, 02 Dec 2025 12:44:21 -0800
In-Reply-To: <20251202153032.10118-1-leon.hwang@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692f4fa5.a70a0220.d98e3.01a5.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Fix unintended eviction when updating lru hash maps
From: syzbot ci <syzbot+cibae4cdb2562c866c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kernel-patches-bot@fb.com, kpsingh@kernel.org, leon.hwang@linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, shuah@kernel.org, skb99@linux.ibm.com, 
	song@kernel.org, yonghong.song@linux.dev
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] bpf: Fix unintended eviction when updating lru hash maps
https://lore.kernel.org/all/20251202153032.10118-1-leon.hwang@linux.dev
* [PATCH bpf-next 1/3] bpf: Avoid unintended eviction when updating lru_hash maps
* [PATCH bpf-next 2/3] bpf: Avoid unintended eviction when updating lru_percpu_hash maps
* [PATCH bpf-next 3/3] selftests/bpf: Add tests to verify no unintended eviction when updating lru hash maps

and found the following issue:
general protection fault in bpf_lru_push_free

Full report is available here:
https://ci.syzbot.org/series/64db9547-852d-4c56-a3a1-3d18f254330c

***

general protection fault in bpf_lru_push_free

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      5262cb23393f7e86a64d1a45eeaa8a6f99f03d10
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/702a7a8c-4385-4089-a777-8b47155f8794/config
C repro:   https://ci.syzbot.org/findings/0cffd810-925f-42f4-88d2-8d21195f341e/c_repro
syz repro: https://ci.syzbot.org/findings/0cffd810-925f-42f4-88d2-8d21195f341e/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 UID: 0 PID: 5953 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:bpf_percpu_lru_push_free kernel/bpf/bpf_lru_list.c:539 [inline]
RIP: 0010:bpf_lru_push_free+0x6e/0xbb0 kernel/bpf/bpf_lru_list.c:551
Code: 01 0f 85 e4 00 00 00 4c 89 f0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 f7 e8 c0 82 42 00 4d 8b 3e 4c 8d 73 10 4c 89 f0 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 5b 09 00 00 45 0f b7 36 bf 08 00 00 00 44
RSP: 0018:ffffc900046d7b48 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000010 RCX: ffff888112941d00
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff888117c02300
RBP: dffffc0000000000 R08: ffffffff8f7cee77 R09: 1ffffffff1ef9dce
R10: dffffc0000000000 R11: fffffbfff1ef9dcf R12: 0000000000000002
R13: 00000000fffffffe R14: 0000000000000020 R15: 0000607d55cf6a80
FS:  000055555edc7500(0000) GS:ffff88818eb38000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed63fff CR3: 000000010bca0000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 htab_lru_push_free kernel/bpf/hashtab.c:1183 [inline]
 htab_lru_map_update_elem+0x33e/0xa90 kernel/bpf/hashtab.c:1266
 bpf_map_update_value+0x751/0x920 kernel/bpf/syscall.c:294
 map_update_elem+0x355/0x4b0 kernel/bpf/syscall.c:1817
 __sys_bpf+0x619/0x860 kernel/bpf/syscall.c:6150
 __do_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6270 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6270
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe41118f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd4179988 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe4113e5fa0 RCX: 00007fe41118f7c9
RDX: 0000000000000020 RSI: 0000200000000800 RDI: 0000000000000002
RBP: 00007fe4111f297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe4113e5fa0 R14: 00007fe4113e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_percpu_lru_push_free kernel/bpf/bpf_lru_list.c:539 [inline]
RIP: 0010:bpf_lru_push_free+0x6e/0xbb0 kernel/bpf/bpf_lru_list.c:551
Code: 01 0f 85 e4 00 00 00 4c 89 f0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 f7 e8 c0 82 42 00 4d 8b 3e 4c 8d 73 10 4c 89 f0 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 5b 09 00 00 45 0f b7 36 bf 08 00 00 00 44
RSP: 0018:ffffc900046d7b48 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000010 RCX: ffff888112941d00
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff888117c02300
RBP: dffffc0000000000 R08: ffffffff8f7cee77 R09: 1ffffffff1ef9dce
R10: dffffc0000000000 R11: fffffbfff1ef9dcf R12: 0000000000000002
R13: 00000000fffffffe R14: 0000000000000020 R15: 0000607d55cf6a80
FS:  000055555edc7500(0000) GS:ffff88818eb38000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed63fff CR3: 000000010bca0000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	01 0f                	add    %ecx,(%rdi)
   2:	85 e4                	test   %esp,%esp
   4:	00 00                	add    %al,(%rax)
   6:	00 4c 89 f0          	add    %cl,-0x10(%rcx,%rcx,4)
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 c0 82 42 00       	call   0x4282dc
  1c:	4d 8b 3e             	mov    (%r14),%r15
  1f:	4c 8d 73 10          	lea    0x10(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 5b 09 00 00    	jne    0x991
  36:	45 0f b7 36          	movzwl (%r14),%r14d
  3a:	bf 08 00 00 00       	mov    $0x8,%edi
  3f:	44                   	rex.R


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

