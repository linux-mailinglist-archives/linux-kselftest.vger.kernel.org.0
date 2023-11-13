Return-Path: <linux-kselftest+bounces-56-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD27EA6D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 00:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25DE1F2336B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B853D3B1;
	Mon, 13 Nov 2023 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI1lAhXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CD20B28;
	Mon, 13 Nov 2023 23:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC0FC433BB;
	Mon, 13 Nov 2023 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699917414;
	bh=dPVoMDdmT5O1esgQWn70/S96MaB0QJhFZeyDdB51SV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hI1lAhXtQRQbllmzOAC535px+CS/59GlFEZ4lC79yB3rdRgJ+kL07ZMIxvwco0l9T
	 zxMDew8xOTlCcPa2jFI2Sme5tZGGfDsLMbxlXJU49JY48lCe4CE475FUEBgSYkEuB2
	 hdWwI94GGojwWMjlzeyKliPLpDXcq5uPxJMsAjkF2t4suKToCe/kipFxuWyaw819Yr
	 e60yuioQ/tN+7D3cPteCJ/ofeqS5m4sKvxmlhzmk7BncTn27NpWTkGzI82z4KSXBko
	 BDNcsydUcSeyxqitahiSSS+lNU4pxwlFSsoPw2UNXtAY99cXhFpcbAV4ANPIrBnKCn
	 SiiGrPQydjUHQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 14 Nov 2023 00:16:14 +0100
Subject: [PATCH net 2/5] mptcp: fix possible NULL pointer dereference on
 close
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-2-7b9cd6a7b7f4@kernel.org>
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Poorva Sonparote <psonparo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 stable@vger.kernel.org, 
 syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5094; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WP+ZlYiFDCyBXD0py15W3W5RddJq4LOh+TwUP0e8fpE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5ZoA45/dNQjJQWX3BOf8JTPbTiAR5XJbvrB
 nQRVRTKsSqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWQAKCRD2t4JPQmmg
 c0JhEADL0kxbBRg9/fZeQdpxXLlue7l4rOoaoYPtDlTz+Feye6GMkf1zv7pTXJ2EHw6GskMB4J7
 lxbi8KQevrB6pj2SNUlvP+gZ0qgq48MLx1+FnUlIeebceO6RQpi0gVqebECJ2SYG7pFe7pffHHb
 KJFbAiu1qRSg4NF95Z6Z9CwcUhH12jQy/X3qOnHh2vr69SzFHPkVZu6dF8Edpr6nti9sKfe0rVO
 RvCeTFljmvf1qrh7ZneFu6R0eev19O1VCvExUcQIIRWcFVWu13fyt1z50ApgeFtjo6dEYtjs2mf
 suPxQ1DW5ZY2VRNGm9f4vc4g5zDCE62GuNXDOOAcCIBmpyHwYKyw4jozEw0eOX2nsaX1P581IWH
 RpiIskRzKpwz+VFyfN5DCEYUP1TZbTiqqoJlYZseOK6y6GG475cr4G7W8wtSPQ0TagPR4E+5prG
 yAVH9TvT4O80iocQdeMZUMUrVoXO3J+u/81PmqrLS7uK7iUZk5g1P+ODGFueqGuPKXMhEtDvKcB
 4pqAIVm0YCp7HC72bZTKJ3luTIHBlygeZ4b129CLhstza0VAjmCIf/jbAbAkTW32Y99Wzzz19CX
 D2x+Uks+uVY3ZSOAAXRbWkBJq+fYwx67rTAm+NLrYeKRnqBKEHCraqTJbO724ftISkGh25KPLuE
 JkYSUYBg0W2Stqg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After the blamed commit below, the MPTCP release callback can
dereference the first subflow pointer via __mptcp_set_connected()
and send buffer auto-tuning. Such pointer is always expected to be
valid, except at socket destruction time, when the first subflow is
deleted and the pointer zeroed.

If the connect event is handled by the release callback while the
msk socket is finally released, MPTCP hits the following splat:

  general protection fault, probably for non-canonical address 0xdffffc00000000f2: 0000 [#1] PREEMPT SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000790-0x0000000000000797]
  CPU: 1 PID: 26719 Comm: syz-executor.2 Not tainted 6.6.0-syzkaller-10102-gff269e2cd5ad #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
  RIP: 0010:mptcp_subflow_ctx net/mptcp/protocol.h:542 [inline]
  RIP: 0010:__mptcp_propagate_sndbuf net/mptcp/protocol.h:813 [inline]
  RIP: 0010:__mptcp_set_connected+0x57/0x3e0 net/mptcp/subflow.c:424
  RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8a62323c
  RDX: 00000000000000f2 RSI: ffffffff8a630116 RDI: 0000000000000790
  RBP: ffff88803334b100 R08: 0000000000000001 R09: 0000000000000000
  R10: 0000000000000001 R11: 0000000000000034 R12: ffff88803334b198
  R13: ffff888054f0b018 R14: 0000000000000000 R15: ffff88803334b100
  FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fbcb4f75198 CR3: 000000006afb5000 CR4: 00000000003506f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   mptcp_release_cb+0xa2c/0xc40 net/mptcp/protocol.c:3405
   release_sock+0xba/0x1f0 net/core/sock.c:3537
   mptcp_close+0x32/0xf0 net/mptcp/protocol.c:3084
   inet_release+0x132/0x270 net/ipv4/af_inet.c:433
   inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
   __sock_release+0xae/0x260 net/socket.c:659
   sock_close+0x1c/0x20 net/socket.c:1419
   __fput+0x270/0xbb0 fs/file_table.c:394
   task_work_run+0x14d/0x240 kernel/task_work.c:180
   exit_task_work include/linux/task_work.h:38 [inline]
   do_exit+0xa92/0x2a20 kernel/exit.c:876
   do_group_exit+0xd4/0x2a0 kernel/exit.c:1026
   get_signal+0x23ba/0x2790 kernel/signal.c:2900
   arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
   exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
   exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
   syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
   do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
   entry_SYSCALL_64_after_hwframe+0x63/0x6b
  RIP: 0033:0x7fb515e7cae9
  Code: Unable to access opcode bytes at 0x7fb515e7cabf.
  RSP: 002b:00007fb516c560c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: 000000000000003c RBX: 00007fb515f9c120 RCX: 00007fb515e7cae9
  RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000006
  RBP: 00007fb515ec847a R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 000000000000006e R14: 00007fb515f9c120 R15: 00007ffc631eb968
   </TASK>

To avoid sparkling unneeded conditionals, address the issue explicitly
checking msk->first only in the critical place.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Reported-by: <syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/454
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 66e947054945..bc81ea53a049 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3402,10 +3402,11 @@ static void mptcp_release_cb(struct sock *sk)
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
 	if (unlikely(msk->cb_flags)) {
-		/* be sure to set the current sk state before tacking actions
-		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
+		/* be sure to set the current sk state before taking actions
+		 * depending on sk_state (MPTCP_ERROR_REPORT)
+		 * On sk release avoid actions depending on the first subflow
 		 */
-		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags) && msk->first)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);

-- 
2.40.1


