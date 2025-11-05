Return-Path: <linux-kselftest+bounces-44799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B635EC3576F
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11714F63DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6630FC2E;
	Wed,  5 Nov 2025 11:46:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E02DEA61;
	Wed,  5 Nov 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343207; cv=none; b=tp+8GXOp+MhtJ9IptEtzG79C1mVGiHc6SPq9r/6xPReAx2OvELXOdx+ItEYNSHZkNzM8KNYu/ZErIfckHi1vI9mwRhXcIdcALgoR2ZIVOd+eLEOqI36ziCOI1UGNC9fXoUSyCM1Jm/NfTM0Eu5NYlfuAxSPTEq2Ovbi9fFYmyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343207; c=relaxed/simple;
	bh=fiKRi3GH6r/B8XX9d8B5w8Dvfv11FfmscbTJItgzweg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncgk1dDYZsFjd92gjWS4Fgm7TD0suos552uveYx63eGCiJvRGsDhkvHvkoF7sQfCwZODd9BM20BniEyEoGku62cYctOg1SA5C3aOGBFWUiU/VRMLzh/+jS4XT6VyDWiToTSx2bBxDlXohPgNGs9eXSsvV+Kr4giQaYIHAvBaTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id ABCB78B2A0B; Wed,  5 Nov 2025 19:37:59 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 0/3] mptcp: Fix conflicts between MPTCP and sockmap
Date: Wed,  5 Nov 2025 19:36:06 +0800
Message-ID: <20251105113625.148900-1-jiayuan.chen@linux.dev>
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

sockmap works by replacing sk_data_ready, recvmsg, sendmsg operations and
implementing fast socket-level forwarding logic:
1. Users can obtain file descriptors through userspace socket()/accept()
   interfaces, then call BPF syscall to perform these replacements.
2. Users can also use the bpf_sock_hash_update helper (in sockops programs)
   to replace handlers when TCP connections enter ESTABLISHED state
  (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB/BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)

However, when combined with MPTCP, an issue arises: MPTCP creates subflow
sk's and performs TCP handshakes, so the BPF program obtains subflow sk's
and may incorrectly replace their sk_prot. We need to reject such
operations. In patch 1, we set psock_update_sk_prot to NULL in the
subflow's custom sk_prot.

Additionally, if the server's listening socket has MPTCP enabled and the
client's TCP also uses MPTCP, we should allow the combination of subflow
and sockmap. This is because the latest Golang programs have enabled MPTCP
for listening sockets by default [2]. For programs already using sockmap,
upgrading Golang should not cause sockmap functionality to fail.

Patch 2 prevents the WARNING from occurring.


[1] truncated warning:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 \
mptcp_stream_accept+0x34c/0x380
Modules linked in:
RIP: 0010:mptcp_stream_accept+0x34c/0x380
RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
PKRU: 55555554
Call Trace:
 <TASK>
 do_accept+0xeb/0x190
 ? __x64_sys_pselect6+0x61/0x80
 ? _raw_spin_unlock+0x12/0x30
 ? alloc_fd+0x11e/0x190
 __sys_accept4+0x8c/0x100
 __x64_sys_accept+0x1f/0x30
 x64_sys_call+0x202f/0x20f0
 do_syscall_64+0x72/0x9a0
 ? switch_fpu_return+0x60/0xf0
 ? irqentry_exit_to_user_mode+0xdb/0x1e0
 ? irqentry_exit+0x3f/0x50
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
---[ end trace 0000000000000000 ]---

[2]: https://go-review.googlesource.com/c/go/+/607715

---
v3 -> v4: Addressed questions from Matthieu and Paolo, explained sockmap's
          operational mechanism, and finalized the changes
v2 -> v3: Adopted Jakub Sitnicki's suggestions - atomic retrieval of
          sk_family is required
v1 -> v2: Had initial discussion with Matthieu on sockmap and MPTCP
          technical details

v3: https://lore.kernel.org/bpf/20251023125450.105859-1-jiayuan.chen@linux.dev/
v2: https://lore.kernel.org/bpf/20251020060503.325369-1-jiayuan.chen@linux.dev/T/#t
v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05534fe6f1@linux.dev/T/#t

Jiayuan Chen (3):
  mptcp: disallow MPTCP subflows from sockmap
  net,mptcp: fix proto fallback detection with BPF
  selftests/bpf: Add mptcp test with sockmap

 net/mptcp/protocol.c                          |   6 +-
 net/mptcp/subflow.c                           |   8 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 150 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_sockmap.c       |  43 +++++
 4 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c


base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
-- 
2.43.0


