Return-Path: <linux-kselftest+bounces-43121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12CBD8ACD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE17E580652
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D0330DED0;
	Tue, 14 Oct 2025 10:04:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B53090F9
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436262; cv=none; b=h55NlJv06ibz9gg8mki/57lIt+R/BTojDwLoTuoyx+93orM7FdG5q7rGtCAtUk4VcsO/1Vw5I15646n8smXebouT/ejN7A5/TS9t4lldK/mZipvLBeWXMtYUbTAPLKgBNJT0S3v5orYkUn6MFzpCHl+OdyVmnWtoORBOMtFCbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436262; c=relaxed/simple;
	bh=Ktrzl3+rFB0DYSw+mzf8Wr5le2N//JG3Jmezq490Eng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=TnJ1v2LAjT6cdbnmcaUD4EiJOsjSYqgUCHmwjKdeE2zoN2pGndZoq0FpLX1KrAEJobn3jgsSjv4+nsqILKBsxoJJfPz4/PoR/VNpIqK4XRA76U1NAViBGDI/M62oB6kq79VbpJdEVQlSihRxoP/ryb9XGfguALN4PA350sKmkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430929af37bso25671305ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436260; x=1761041060;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GH+KMJg65TPnbgWnuocNKVgpnsMrWf8epTMXXTaDAq0=;
        b=GYdVr/RIWZ03AB8jBgxmfFGOPNYYPp/8UxwLW0sy8KFAZDrZfk3ROLezkYAurNGjUT
         Z4p6yfJTEQ+xwKFr2wJ9F56O8w1pM309bUq52Lj93k05rR9awS4Gb4Sx5ZsBEJZdAlgO
         iO4LvPx2lirSVb1pwhO++plIqO0G5KthvqjszxWsu3dBLJS74LMJK9fhzAAKcA7fxN+/
         CJw+QVhSGvVrxRQU52n3JlezDa0Psroc8eCwctM804PIeMm1yI5y/hmG0772qpe+Faek
         TU3Ijr74GDI6KjWgtB8Rj3kF9ZEVorGZ3HXbziMemjKFr+pRl4/g/asx7NUcvSWhaaMU
         kIwA==
X-Forwarded-Encrypted: i=1; AJvYcCV3lsDoNETzy6EvEOqzX5JLkUXHto0Zd4qkoEmC904DWzhfGpP89O/HVpkZxpQ1dRIoVOPfmgLdGG0KEaFRY/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI0K0tTi/pLHu8XTMrZaF4nn5RnMeEcVeAqQEQfDUHiZ69WcG
	GxLdOORrtak0CG+pJ2GiUQfbzPq/usEh1fh+74qj1g9mKI+u69Xmr+N/kCJDaUE2FTB/N94LmlX
	+4eW82o/SNbRCxkFk6YvadGo8A2QHUzeUa8RSCbhrNtVrorZmqg3WQ5J26dI=
X-Google-Smtp-Source: AGHT+IGz2nDs6O23O9XvrI8+go74XaGnVI0mw9uQ08Gv7HrjA7t3Y0/hk3lcuiAO7H/cMIk375ht76/469QuZmsy6j1NehDau3rk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:42f:a4d7:ebac with SMTP id
 e9e14a558f8ab-42fa4d7f0acmr152220895ab.4.1760436260071; Tue, 14 Oct 2025
 03:04:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 03:04:20 -0700
In-Reply-To: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee2024.050a0220.ac43.00ef.GAE@google.com>
Subject: [syzbot ci] Re: net/tls: support setting the maximum payload size
From: syzbot ci <syzbot+cidd78f5a1c7478a8a@syzkaller.appspotmail.com>
To: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	shuah@kernel.org, wilfred.mallawa@wdc.com, wilfred.opensource@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v5] net/tls: support setting the maximum payload size
https://lore.kernel.org/all/20251014051825.1084403-2-wilfred.opensource@gmail.com
* [PATCH net-next v5 1/2] net/tls: support setting the maximum payload size
* [PATCH net-next v5 2/2] selftests: tls: add tls record_size_limit test

and found the following issue:
general protection fault in tls_setsockopt

Full report is available here:
https://ci.syzbot.org/series/210c88bf-945a-460c-9fe3-c55bd1958b5d

***

general protection fault in tls_setsockopt

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      18a7e218cfcdca6666e1f7356533e4c988780b57
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/ae03b3d4-e809-4b0e-bd4a-76b4ae8e9d74/config
C repro:   https://ci.syzbot.org/findings/d0b97737-6ea7-4c05-b10b-71dc834c9393/c_repro
syz repro: https://ci.syzbot.org/findings/d0b97737-6ea7-4c05-b10b-71dc834c9393/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000023: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
CPU: 1 UID: 0 PID: 5970 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:do_tls_setsockopt_tx_payload_len net/tls/tls_main.c:847 [inline]
RIP: 0010:do_tls_setsockopt net/tls/tls_main.c:887 [inline]
RIP: 0010:tls_setsockopt+0x189/0x1590 net/tls/tls_main.c:906
Code: ff df 80 3c 08 00 74 08 4c 89 ff e8 51 67 3c f8 41 bc 18 01 00 00 4d 03 27 4c 89 e0 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 80 3c 38 00 74 08 4c 89 e7 e8 28 67 3c f8 49 83 3c 24 00 0f 84
RSP: 0018:ffffc90003e57cc0 EFLAGS: 00010202
RAX: 0000000000000023 RBX: ffff88816adfcc00 RCX: dffffc0000000000
RDX: 0000000000000006 RSI: ffffffff8d7e872a RDI: ffffffff8bc074e0
RBP: ffffc90003e57e38 R08: ffffffff8f9e0f77 R09: 1ffffffff1f3c1ee
R10: dffffc0000000000 R11: fffffbfff1f3c1ef R12: 0000000000000118
R13: 1ffff920007cafa4 R14: ffff88816b33bde8 R15: dffffc0000000000
FS:  00005555585b2500(0000) GS:ffff8882a9d0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000180 CR3: 000000010739e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
 __sys_setsockopt net/socket.c:2385 [inline]
 __do_sys_setsockopt net/socket.c:2391 [inline]
 __se_sys_setsockopt net/socket.c:2388 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f499fb8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecf309e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f499fde5fa0 RCX: 00007f499fb8eec9
RDX: 0000000000000005 RSI: 000000000000011a RDI: 0000000000000003
RBP: 00007f499fc11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f499fde5fa0 R14: 00007f499fde5fa0 R15: 0000000000000005
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_tls_setsockopt_tx_payload_len net/tls/tls_main.c:847 [inline]
RIP: 0010:do_tls_setsockopt net/tls/tls_main.c:887 [inline]
RIP: 0010:tls_setsockopt+0x189/0x1590 net/tls/tls_main.c:906
Code: ff df 80 3c 08 00 74 08 4c 89 ff e8 51 67 3c f8 41 bc 18 01 00 00 4d 03 27 4c 89 e0 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 80 3c 38 00 74 08 4c 89 e7 e8 28 67 3c f8 49 83 3c 24 00 0f 84
RSP: 0018:ffffc90003e57cc0 EFLAGS: 00010202
RAX: 0000000000000023 RBX: ffff88816adfcc00 RCX: dffffc0000000000
RDX: 0000000000000006 RSI: ffffffff8d7e872a RDI: ffffffff8bc074e0
RBP: ffffc90003e57e38 R08: ffffffff8f9e0f77 R09: 1ffffffff1f3c1ee
R10: dffffc0000000000 R11: fffffbfff1f3c1ef R12: 0000000000000118
R13: 1ffff920007cafa4 R14: ffff88816b33bde8 R15: dffffc0000000000
FS:  00005555585b2500(0000) GS:ffff8882a9d0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000180 CR3: 000000010739e000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	df 80 3c 08 00 74    	filds  0x7400083c(%rax)
   6:	08 4c 89 ff          	or     %cl,-0x1(%rcx,%rcx,4)
   a:	e8 51 67 3c f8       	call   0xf83c6760
   f:	41 bc 18 01 00 00    	mov    $0x118,%r12d
  15:	4d 03 27             	add    (%r15),%r12
  18:	4c 89 e0             	mov    %r12,%rax
  1b:	48 c1 e8 03          	shr    $0x3,%rax
  1f:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  26:	fc ff df
* 29:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 28 67 3c f8       	call   0xf83c6760
  38:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
  3d:	0f                   	.byte 0xf
  3e:	84                   	.byte 0x84


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

