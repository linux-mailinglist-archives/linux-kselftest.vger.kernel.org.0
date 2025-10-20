Return-Path: <linux-kselftest+bounces-43532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1181BEF645
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8BD1888197
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74D2D0C64;
	Mon, 20 Oct 2025 06:05:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4833F6;
	Mon, 20 Oct 2025 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940336; cv=none; b=SwVDbzw1C4jw4tqv+zKLZBZXoz8RZ3Yi4kyAkwQHXupBnIpyUARu660gpN8xLII7lZcnz9jCsIdoosyuziOePYZ6VLFNrDSNRFjnyqJMTBNLBTaVe+kXtbG660r9+QbVEDNAUqoLhuIdVo8rTbQIsFLTdJ8pw61NkdMpec1Wg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940336; c=relaxed/simple;
	bh=JN0kAYHKGuMXtTDQCxXntwNjscgj3btMyUd4B5mll5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGOu+q2+7acB5REJYqg25x5GKsUyOZat2PcO81m9ZMjMHa+6v4a9ndYy64sVVNHxxz0eSgZX0I8ZraScbmNTLt0JpQJYpqLICMtKKAZkIu9gWJAMY3OOOE75BIT8kwENijV5+9j5nvpvy7wNxtE+GoSv3rWkNBpImnbwSGfFLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 132888B2A56; Mon, 20 Oct 2025 14:05:26 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
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
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/3] mptcp: Fix conflicts between MPTCP and sockmap
Date: Mon, 20 Oct 2025 14:04:45 +0800
Message-ID: <20251020060503.325369-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overall, we encountered a warning [1] that can be triggered by running the
selftest I provided.

MPTCP creates subflows for data transmission between two endpoints.
However, BPF can use sockops to perform additional operations when TCP
completes the three-way handshake. The issue arose because we used sockmap
in sockops, which replaces sk->sk_prot and some handlers. Since subflows
also have their own specialized handlers, this creates a conflict and leads
to traffic failure. Therefore, we need to reject operations targeting
subflows.

This patchset simply prevents the combination of subflows and sockmap
without changing any functionality.

A complete integration of MPTCP and sockmap would require more effort, for
example, we would need to retrieve the parent socket from subflows in
sockmap and implement handlers like read_skb.

If maintainers don't object, we can further improve this in subsequent
work.

v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev/T/#t

[1] truncated warning:
[   18.234652] ------------[ cut here ]------------
[   18.234664] WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 mptcp_stream_accept+0x34c/0x380
[   18.234726] Modules linked in:
[   18.234755] RIP: 0010:mptcp_stream_accept+0x34c/0x380
[   18.234762] RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
[   18.234800] PKRU: 55555554
[   18.234806] Call Trace:
[   18.234810]  <TASK>
[   18.234837]  do_accept+0xeb/0x190
[   18.234861]  ? __x64_sys_pselect6+0x61/0x80
[   18.234898]  ? _raw_spin_unlock+0x12/0x30
[   18.234915]  ? alloc_fd+0x11e/0x190
[   18.234925]  __sys_accept4+0x8c/0x100
[   18.234930]  __x64_sys_accept+0x1f/0x30
[   18.234933]  x64_sys_call+0x202f/0x20f0
[   18.234966]  do_syscall_64+0x72/0x9a0
[   18.234979]  ? switch_fpu_return+0x60/0xf0
[   18.234993]  ? irqentry_exit_to_user_mode+0xdb/0x1e0
[   18.235002]  ? irqentry_exit+0x3f/0x50
[   18.235005]  ? clear_bhb_loop+0x50/0xa0
[   18.235022]  ? clear_bhb_loop+0x50/0xa0
[   18.235025]  ? clear_bhb_loop+0x50/0xa0
[   18.235028]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   18.235066]  </TASK>
[   18.235109] ---[ end trace 0000000000000000 ]---
[   18.235677] sockmap: MPTCP sockets are not supported

Jiayuan Chen (3):
  net,mptcp: fix incorrect IPv4/IPv6 fallback detection with BPF Sockmap
  bpf,sockmap: disallow MPTCP sockets from sockmap updates
  selftests/bpf: Add mptcp test with sockmap

 net/core/sock_map.c                           |   9 ++
 net/mptcp/protocol.c                          |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_sockmap.c       |  43 ++++++
 4 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c

-- 
2.43.0


