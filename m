Return-Path: <linux-kselftest+bounces-46425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4378C84D72
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F3E3AFBBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D231619E;
	Tue, 25 Nov 2025 11:57:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C468314A89;
	Tue, 25 Nov 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071875; cv=none; b=ZkhkBk3E9qMrqWyD/5esgHcPnQCAS+Zs6/vcyp5Io5s9x3dUc87Emn5UNNCV1K0ZirR3y8vJgRkeeTqgxcyy+Vdg5sLM4hA0sxYeVzU8mUyr2a0IenHND+Ey4pQUSLIaU76G5NtwZvW8RoLCQE0FUyohnvvVZofZ5ZMUFWoThWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071875; c=relaxed/simple;
	bh=h+0zY3hYZrpAB5Wqkh5NLThM1vTJvoHZwkygu2+9/5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpB+W8pfdd4KObgIgTlQdUUHgwKIRcDv48Ql/PmzL5AMJX9eb9eGnB9N9qz2tvXgvFxzFYWLqOd9iZLMNoLnGnquRIOf1K2BBVQf4QFD1eM03R9lT3hHg4rO7KOnGLqRboLPSM6amXiwRpoNFcFOsRyTNomyIBoPAuACXZx2rjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 65EBA8B2A0B; Tue, 25 Nov 2025 19:57:46 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/3] bpf: Fix FIONREAD and copied_seq issues
Date: Tue, 25 Nov 2025 19:56:37 +0800
Message-ID: <20251125115709.249440-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller reported a bug [1] where a socket using sockmap, after being
unloaded, exposed incorrect copied_seq calculation. The selftest I
provided can be used to reproduce the issue reported by syzkaller.

TCP recvmsg seq # bug 2: copied E92C873, seq E68D125, rcvnxt E7CEB7C, fl 40
WARNING: CPU: 1 PID: 5997 at net/ipv4/tcp.c:2724 tcp_recvmsg_locked+0xb2f/0x2910 net/ipv4/tcp.c:2724
Call Trace:
 <TASK>
 receive_fallback_to_copy net/ipv4/tcp.c:1968 [inline]
 tcp_zerocopy_receive+0x131a/0x2120 net/ipv4/tcp.c:2200
 do_tcp_getsockopt+0xe28/0x26c0 net/ipv4/tcp.c:4713
 tcp_getsockopt+0xdf/0x100 net/ipv4/tcp.c:4812
 do_sock_getsockopt+0x34d/0x440 net/socket.c:2421
 __sys_getsockopt+0x12f/0x260 net/socket.c:2450
 __do_sys_getsockopt net/socket.c:2457 [inline]
 __se_sys_getsockopt net/socket.c:2454 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2454
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

A sockmap socket maintains its own receive queue (ingress_msg) which may
contain data from either its own protocol stack or forwarded from other
sockets.

                                                     FD1:read()
                                                     --  FD1->copied_seq++
                                                         |  [read data]
                                                         |
                                [enqueue data]           v
                  [sockmap]     -> ingress to self ->  ingress_msg queue
FD1 native stack  ------>                                 ^
-- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
                                       |                  |
                                       |             ingress to FD1
                                       v                  ^
                                      ...                 |  [sockmap]
                                                     FD2 native stack

The issue occurs when reading from ingress_msg: we update tp->copied_seq
by default, but if the data comes from other sockets (not the socket's
own protocol stack), tcp->rcv_nxt remains unchanged. Later, when
converting back to a native socket, reads may fail as copied_seq could
be significantly larger than rcv_nxt.

Additionally, FIONREAD calculation based on copied_seq and rcv_nxt is
insufficient for sockmap sockets, requiring separate field tracking.

[1] https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983

---

v1 -> v4: Use skmsg.sk instead of extending BPF_F_XXX macro and fix CI
          failure reported by CI
v1: https://lore.kernel.org/bpf/20251117110736.293040-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  bpf, sockmap: Fix incorrect copied_seq calculation
  bpf, sockmap: Fix FIONREAD for sockmap
  bpf, selftest: Add tests for FIONREAD and copied_seq

 include/linux/skmsg.h                         |  58 ++++-
 net/core/skmsg.c                              |  28 ++-
 net/ipv4/tcp_bpf.c                            |  26 ++-
 net/ipv4/udp_bpf.c                            |  25 ++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 203 +++++++++++++++++-
 .../bpf/progs/test_sockmap_pass_prog.c        |   8 +
 6 files changed, 331 insertions(+), 17 deletions(-)

-- 
2.43.0


