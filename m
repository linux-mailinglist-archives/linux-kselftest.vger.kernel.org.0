Return-Path: <linux-kselftest+bounces-40818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F6B45329
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6F91651ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764C2045B5;
	Fri,  5 Sep 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIcNh29G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B81D63F7
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064661; cv=none; b=qIWdy99m8Uq2AaJhpGRbDNsZlBDIcqi3+G/lmtEARBKxkiM0mxH45PdoA7U6EOEmzK8xTPRPk4cX4u+DFBjUVMs1bAo0irSVzZiUa3hAwBGiLNpWCVx4gHA5Zl0PaLkognALHsbufpOQQmMVPzm3SLOgdWB1wt0Ht+m9T537+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064661; c=relaxed/simple;
	bh=cComBjj/vDPU72+FvDU/MvSfl4KJJjzD7B7BldnVSPI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mSfcShD/B3kVpXfZlmbxOnmMhhKXc8kfJ384EfR75ADZzL7X8H0Ti2mJ7+UA2IB8MF3KyeTUxj+sSE2320hNULE1FKItUZVFt0N1pukblYt5xC88rLZyqSDvpxn8XWk7MK/AjI4L48anOM/227WRIf0pdLpz/jcXJGITYPms788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xIcNh29G; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so1870436a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757064659; x=1757669459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+LobxBsVhrOLP6eF1oCgb7vPNLRbOh2IXRKPy/RCs6I=;
        b=xIcNh29GzwH9dnw2XaBpohJleGt/Ng66Iwem73Bf2P+50OVY3657NmKft3NkveS4Gk
         a4a1S8y/+Vk2YBljNaiym9NoiuH8HhRki5df4HT33ZMBbYQbb/DzpbRi8aulMhXNryAZ
         dlGRoZ8Q3u7YzjxenEIFLL+30VO4nDH4VbPXrxQYrKN1IykmDnRK3VQMYuWboWG5ZcHR
         4jryTYWhN/pwM7DOc4bPlC8Fr1n24wXcJtUixPm0E5ZVrQstc5U0tHp7sjjnvGKfSIPb
         XoJWmJ0vJ0Ui0IaMXq5S3m9nW3Q9EXx00PlrhgXTt3Ool/lpAM7Fx0+RoJrTanJhrxrJ
         i5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064659; x=1757669459;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LobxBsVhrOLP6eF1oCgb7vPNLRbOh2IXRKPy/RCs6I=;
        b=iaSV26EQK05HrBDfsxDzzn+D+ySxAf16hQqHq0R68Vj83kw3Wb/jiWcQVL97c3IoN8
         O0MGPtACxC+dHlR7EpeVT98+KetcCrKS9k51BbOFOSi2TZMigdcvR9lRJuJuO3oJ5tEQ
         o5PHHJfV0dNW+7JVK7lfX8dADxxwrlc2uw1RuVwqaX4mWtfluYzeAbfrva93pr4S0gd9
         0hkFPO1hQuRlB+ctH5XWqBGW9c4n1DS7Og+8Aym4iOCnOXYLgvc4SDCJZBxjzUFQjcS7
         /xRhWPXxXsKbluFNMf7c3eNrrFNUz9t2EHI4zECiXtowZaq8xl+Fn0jKKQIWNk0GCrYw
         AHmg==
X-Forwarded-Encrypted: i=1; AJvYcCVO3OLhPVcoW0JYW0fqQVzSqsC9SiWNovkWBFfB8wtV9vqVs24KJzF7xDq0Zf8kIAG6IicHXlRFPhgVxOkUVJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkcQE4oO1eAVlcjP3ccS3MsUSjhFoBkKF6ykxJXlhLXq/rB0C
	13OuUwaGPM3A35QdxOYYbGVrB6fsXR+O01asmlBXzNWjewcs7kf0DBtbdg95x1BA1wbK9UigGGJ
	ztbXZsD19MQ28ONskVt5n9Z+8w1ZYQItzHq5NBvNbRA==
X-Gm-Gg: ASbGncsu2cg4Lknyh8CTok1UBQ1kLVGNwv6oQyIsI/RAnYKL+nV1zuPLCrFfdc8WuCO
	PoB8gXcqGSujnss+roh39vIbgsyKMgdzuHSSvVBu8MpxM7pPnI6vaVK71yF8CfZjrhsB13VGIG+
	lao8zspbeMD1GTcg5VLswj24VmFDn/vFh7WZX3UrvT+zA3xzCNHG7W4VnaFSOwG+Q3vBSrj0OVm
	5B1Dqk5lePxNnpPUJquXz7wO5OI0ehhFcr91zdc
X-Google-Smtp-Source: AGHT+IHXA2PhuxH15MNyIwAlo4Zsa1wegxGTRmX/0N7BbPmF1yBcGj4uXgca0x/iboAEfGk+fwKK4A1E3Kyu6BjOlso=
X-Received: by 2002:a17:90b:4d92:b0:327:e018:204a with SMTP id
 98e67ed59e1d1-3281531d3e3mr29191395a91.0.1757064658607; Fri, 05 Sep 2025
 02:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 5 Sep 2025 15:00:47 +0530
X-Gm-Features: Ac12FXzSXlXs-UMpYMYTMehHV94NkxIEElsCgVxRk1HWKsb_351cP0b29GGHSf8
Message-ID: <CA+G9fYsmo39mXw-U7VKJgHWTBB5bXNgwOqNfmDWRqvbqmxnD2g@mail.gmail.com>
Subject: next-20250905: x86_64: udpgso_bench.sh triggers NULL deref in zerocopy_fill_skb_from_iter
To: Netdev <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Biggers <ebiggers@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Pengtao He <hept.hept.hept@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The following kernel crash was noticed on x86_64 running selftests net
udpgso_bench.sh
on Linux next-20250905 tag.

Regression Analysis:
- New regression? yes
- Reproducibility? Re-validation is in progress

First seen on next-20250905
Bad: next-20250905
Good: next-20250904

Test regression: next-20250905 x86_64 selftests net BUG kernel NULL
pointer dereference zerocopy_fill_skb_from_iter

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

x86_64:
 Test:
    * selftests: net: udpgso_bench.sh

Test error:
selftests: net: udpgso_bench.sh
ipv4
tcp

<trim>

# tcp zerocopy
[  991.110488] SELinux: unrecognized netlink message: protocol=4
nlmsg_type=19 sclass=netlink_tcpdiag_socket pid=64835 comm=ss
# RTNETLINK answers: Invalid argument
[  991.129878] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  991.136850] #PF: supervisor read access in kernel mode
[  991.141986] #PF: error_code(0x0000) - not-present page
[  991.147118] PGD 0 P4D 0
[  991.149657] Oops: Oops: 0000 [#1] SMP PTI
[  991.153661] CPU: 0 UID: 0 PID: 64842 Comm: udpgso_bench_tx Tainted:
G S                  6.17.0-rc4-next-20250905 #1 PREEMPT(voluntary)
[  991.165907] Tainted: [S]=CPU_OUT_OF_SPEC
[  991.169825] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[  991.177209] RIP: 0010:zerocopy_fill_skb_from_iter
(include/linux/page-flags.h:284)
[ 991.182954] Code: 4d 85 c0 0f 84 04 01 00 00 44 39 c7 41 0f 4d f8 4c
63 de 4a 8b 54 dc 30 49 89 d6 4d 29 ce 49 c1 fe 06 49 d3 ee 4d 85 f6
74 24 <48> 8b 4a 08 f6 c1 01 0f 85 cb 00 00 00 0f 1f 44 00 00 31 c9 48
f7
All code
========
   0: 4d 85 c0              test   %r8,%r8
   3: 0f 84 04 01 00 00    je     0x10d
   9: 44 39 c7              cmp    %r8d,%edi
   c: 41 0f 4d f8          cmovge %r8d,%edi
  10: 4c 63 de              movslq %esi,%r11
  13: 4a 8b 54 dc 30        mov    0x30(%rsp,%r11,8),%rdx
  18: 49 89 d6              mov    %rdx,%r14
  1b: 4d 29 ce              sub    %r9,%r14
  1e: 49 c1 fe 06          sar    $0x6,%r14
  22: 49 d3 ee              shr    %cl,%r14
  25: 4d 85 f6              test   %r14,%r14
  28: 74 24                je     0x4e
  2a:* 48 8b 4a 08          mov    0x8(%rdx),%rcx <-- trapping instruction
  2e: f6 c1 01              test   $0x1,%cl
  31: 0f 85 cb 00 00 00    jne    0x102
  37: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  3c: 31 c9                xor    %ecx,%ecx
  3e: 48                    rex.W
  3f: f7                    .byte 0xf7

Code starting with the faulting instruction
===========================================
   0: 48 8b 4a 08          mov    0x8(%rdx),%rcx
   4: f6 c1 01              test   $0x1,%cl
   7: 0f 85 cb 00 00 00    jne    0xd8
   d: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  12: 31 c9                xor    %ecx,%ecx
  14: 48                    rex.W
  15: f7                    .byte 0xf7
[  991.201691] RSP: 0018:ffffb11281d0ba90 EFLAGS: 00010202
[  991.206910] RAX: ffffe14ec4208000 RBX: 0000000000005000 RCX: 0000000000000009
[  991.214033] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000001000
[  991.221156] RBP: ffffb11281d0bb88 R08: 00000000000020ff R09: ffffe14ec4208000
[  991.228280] R10: 0000000000000005 R11: 0000000000000006 R12: ffff96b4825f4200
[  991.235406] R13: 0000000000000001 R14: 000000003d6277bf R15: 0000000000000000
[  991.242529] FS:  00007f41e80b9740(0000) GS:ffff96b83bc1b000(0000)
knlGS:0000000000000000
[  991.250608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  991.256378] CR2: 0000000000000008 CR3: 0000000106c42003 CR4: 00000000003706f0
[  991.263513] Call Trace:
[  991.265956]  <TASK>
[  991.268055] __zerocopy_sg_from_iter (net/core/datagram.c:?)
[  991.272674] ? kmalloc_reserve (net/core/skbuff.c:581)
[  991.276599] skb_zerocopy_iter_stream (net/core/skbuff.c:1867)
[  991.281219] tcp_sendmsg_locked (net/ipv4/tcp.c:1283)
[  991.285493] tcp_sendmsg (net/ipv4/tcp.c:1393)
[  991.288896] inet6_sendmsg (net/ipv6/af_inet6.c:661)
[  991.292466] __sock_sendmsg (net/socket.c:717)
[  991.296126] __sys_sendto (net/socket.c:?)
[  991.299785] __x64_sys_sendto (net/socket.c:2235 net/socket.c:2231
net/socket.c:2231)
[  991.303622] x64_sys_call (arch/x86/entry/syscall_64.c:41)
[  991.307462] do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[  991.311128] ? irqentry_exit (kernel/entry/common.c:210)
[  991.314881] ? exc_page_fault (arch/x86/mm/fault.c:1536)
[  991.318720] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  991.323762] RIP: 0033:0x7f41e814b687
[ 991.327352] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00
59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10
0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff
ff
All code
========
   0: 48 89 fa              mov    %rdi,%rdx
   3: 4c 89 df              mov    %r11,%rdi
   6: e8 58 b3 00 00        call   0xb363
   b: 8b 93 08 03 00 00    mov    0x308(%rbx),%edx
  11: 59                    pop    %rcx
  12: 5e                    pop    %rsi
  13: 48 83 f8 fc          cmp    $0xfffffffffffffffc,%rax
  17: 74 1a                je     0x33
  19: 5b                    pop    %rbx
  1a: c3                    ret
  1b: 0f 1f 84 00 00 00 00 nopl   0x0(%rax,%rax,1)
  22: 00
  23: 48 8b 44 24 10        mov    0x10(%rsp),%rax
  28: 0f 05                syscall
  2a:* 5b                    pop    %rbx <-- trapping instruction
  2b: c3                    ret
  2c: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
  33: 83 e2 39              and    $0x39,%edx
  36: 83 fa 08              cmp    $0x8,%edx
  39: 75 de                jne    0x19
  3b: e8 23 ff ff ff        call   0xffffffffffffff63

Code starting with the faulting instruction
===========================================
   0: 5b                    pop    %rbx
   1: c3                    ret
   2: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
   9: 83 e2 39              and    $0x39,%edx
   c: 83 fa 08              cmp    $0x8,%edx
   f: 75 de                jne    0xffffffffffffffef
  11: e8 23 ff ff ff        call   0xffffffffffffff39
[  991.346124] RSP: 002b:00007ffdd843ba50 EFLAGS: 00000202 ORIG_RAX:
000000000000002c
[  991.353680] RAX: ffffffffffffffda RBX: 00007f41e80b9740 RCX: 00007f41e814b687
[  991.360806] RDX: 000000000000f180 RSI: 000056251f1fd100 RDI: 0000000000000005
[  991.367931] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  991.375063] R10: 0000000004000000 R11: 0000000000000202 R12: 0000000000000000
[  991.382193] R13: 000056251f1fb080 R14: 000001a670e438d8 R15: 0000000000000005
[  991.389357]  </TASK>
[  991.391571] Modules linked in: mptcp_diag tcp_diag inet_diag
xt_conntrack xfrm_user ipip bridge stp llc geneve vxlan act_csum
act_pedit openvswitch nsh nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 psample cls_flower sch_prio xt_mark nft_compat
nf_tables sch_ingress act_mirred cls_basic sch_fq_codel vrf pktgen
macvtap macvlan tap x86_pkg_temp_thermal ip_tables x_tables [last
unloaded: test_bpf]
[  991.426812] CR2: 0000000000000008
[  991.430121] ---[ end trace 0000000000000000 ]---
[  991.434733] RIP: 0010:zerocopy_fill_skb_from_iter
(include/linux/page-flags.h:284)
[ 991.440477] Code: 4d 85 c0 0f 84 04 01 00 00 44 39 c7 41 0f 4d f8 4c
63 de 4a 8b 54 dc 30 49 89 d6 4d 29 ce 49 c1 fe 06 49 d3 ee 4d 85 f6
74 24 <48> 8b 4a 08 f6 c1 01 0f 85 cb 00 00 00 0f 1f 44 00 00 31 c9 48
f7
All code
========
   0: 4d 85 c0              test   %r8,%r8
   3: 0f 84 04 01 00 00    je     0x10d
   9: 44 39 c7              cmp    %r8d,%edi
   c: 41 0f 4d f8          cmovge %r8d,%edi
  10: 4c 63 de              movslq %esi,%r11
  13: 4a 8b 54 dc 30        mov    0x30(%rsp,%r11,8),%rdx
  18: 49 89 d6              mov    %rdx,%r14
  1b: 4d 29 ce              sub    %r9,%r14
  1e: 49 c1 fe 06          sar    $0x6,%r14
  22: 49 d3 ee              shr    %cl,%r14
  25: 4d 85 f6              test   %r14,%r14
  28: 74 24                je     0x4e
  2a:* 48 8b 4a 08          mov    0x8(%rdx),%rcx <-- trapping instruction
  2e: f6 c1 01              test   $0x1,%cl
  31: 0f 85 cb 00 00 00    jne    0x102
  37: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  3c: 31 c9                xor    %ecx,%ecx
  3e: 48                    rex.W
  3f: f7                    .byte 0xf7

Code starting with the faulting instruction
===========================================
   0: 48 8b 4a 08          mov    0x8(%rdx),%rcx
   4: f6 c1 01              test   $0x1,%cl
   7: 0f 85 cb 00 00 00    jne    0xd8
   d: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  12: 31 c9                xor    %ecx,%ecx
  14: 48                    rex.W
  15: f7                    .byte 0xf7
[  991.459215] RSP: 0018:ffffb11281d0ba90 EFLAGS: 00010202
[  991.464434] RAX: ffffe14ec4208000 RBX: 0000000000005000 RCX: 0000000000000009
[  991.471557] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000001000
[  991.478681] RBP: ffffb11281d0bb88 R08: 00000000000020ff R09: ffffe14ec4208000
[  991.485807] R10: 0000000000000005 R11: 0000000000000006 R12: ffff96b4825f4200
[  991.492930] R13: 0000000000000001 R14: 000000003d6277bf R15: 0000000000000000
[  991.500054] FS:  00007f41e80b9740(0000) GS:ffff96b83bc1b000(0000)
knlGS:0000000000000000
[  991.508132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  991.513870] CR2: 0000000000000008 CR3: 0000000106c42003 CR4: 00000000003706f0
[  991.520994] note: udpgso_bench_tx[64842] exited with irqs disabled


## Source
* Kernel version: 6.17.0-rc4
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250905
* Git commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
* Architectures: x86_64
* Toolchains: clang-nightly
* Kconfigs: defconfig+selftests/*/config

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29777495/log_file/
* LAVA test log: https://lkft.validation.linaro.org/scheduler/job/8434053#L16943
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250905/log-parser-test/oops-oops-oops-smp-pti/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32GkXBGNRNDEj5d64zd73eXhXQC
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32GkU7mdlpISpPeeeEwIfAJuzqG/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32GkU7mdlpISpPeeeEwIfAJuzqG/config

--
Linaro LKFT
https://lkft.linaro.org

