Return-Path: <linux-kselftest+bounces-5355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F1861783
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DE7B29BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF25130AD0;
	Fri, 23 Feb 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL6RHuJw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2F1272D9;
	Fri, 23 Feb 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704911; cv=none; b=N185gf6tO37BDqca9ofe4HvDYKZd9DjEyn1foON4agBS7wSuR9SJ0dPCTobsXSydQPVyWbzlQcstY0VEWNE5q2pv5x4JBBG7bqv+/ueiDr1BzFmOzwafHMhUV43yr32wfWaTEFHJ5X6NQHms6X7a/m2bMHtMiUaSB4NLOnawdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704911; c=relaxed/simple;
	bh=UOmb8QUKpfB4+WjxyRhNnD+CWLS+80nZ+BSmHaLlkTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6EWjMwqyD8XxykJ9mXPQrdqICwXCkMjOpD5yTfYPz+L72L7WN+TviPRYWPJq8zI9Rhf5g/VIFZCaoVDLkPEqo64ojAeRgputSGlVzTaL+ZmyQc5JnHGJd+jmcag6BsBFTn256R4PZtGb0zqVO2fIdrGxNwVaWJsQpbLxVLOgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL6RHuJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42488C43390;
	Fri, 23 Feb 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704909;
	bh=UOmb8QUKpfB4+WjxyRhNnD+CWLS+80nZ+BSmHaLlkTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nL6RHuJwX6P4sv9LOiFdft0R4K907aiXbhvYbHDG7+ko+FuVWxFo/VYIyXmgnrJsE
	 jBSvrAFJgcyUw/7LMGlZZV6eB5w9bu9F3EkD4cEqmNOF5qE8oeyY9WDSmjhFtzpNPz
	 jQ5MwIhGnOCsoxY2wAc59alMd7rooFP67+PhqjyWszD8YWQo5oSJsLmeaJaELfcPmK
	 K7f/FS2xRPO93UH//GQO+RR3ybEW/3ztQhqeUVuk4hPrLd+IJv8B06bquM6EC1Mpbt
	 AhfXHZBhzz5IKvWsMLFZr/XugZdDmZ168c6TwAHz8EOLQLs09obz4ayDeppu78lhqq
	 FhZrfTFR5dFeQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:18 +0100
Subject: [PATCH net 08/10] mptcp: fix double-free on socket dismantle
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-8-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6954; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g2NHIj59A7epffNx/pwc/bVVEml4bfYZeG26nwfmrmc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqCRQrauV3D9skqzFRuo9n0hpI1aeEHyQo+
 f3gjagRL8yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c0FFD/48f2Iv5jX8iHk2IvEhVok3sehVXDBlVamGz89DgI0Lr74tb93HhoYqWdPRwqEByPrZlGF
 Y9wxH6llNoy60ZSY/LwBTvXQb5mc+LBoI9w4xOOIM3eiUCNKsSBGK3rjKPrAlv77hoAlbylodBf
 VCH6h/FzZcKCHmJmmYE2q+VmO7kuAdjwFUeWCWXfQDQvE4YRCNwOjTprhCU5a8Hgxoo/nUpBg4j
 ceyW6lqv2z/KOogyyxrUBThcjWyehP7zlk8fm9zPZE6838S+Wu8TPIzR9PUV3J5dM/7hEby4IKL
 LuuCXo8kHlmDKq+77RsQf15gzC46IFdxSJYNyxbN5koZ35yRCburXiSY11/WoimyOtxmfecIMeU
 jQsQXTjXUfuAz4QbSMF8nJvwVGYhHMbLNvBpYOT7O3LFY5pePaOMwjaw7PObDR6gjtw/EFLRII3
 lW3iA2sH3suKCGnF7iyyWD9mwNj0x5U1RVadYxM15do/cciVKF2QPkpD8K3eBgZNKLVH7sTuVMc
 3Ui/Zm6gLpURKGI2wbAu1gVXifmOI4K+Ry2Ig076B9/Aa4iS1H3EhNHAZePZzBtq/1TCyTRLDOa
 ZMh1syXjmzRnuuNcJBKpXnswyEgf7cjzIktgXMG4G1Lr2p7jGRKYeDVSDR/+tqTOkp8fMqz+RdD
 u/XMlexdZIiNulA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

when MPTCP server accepts an incoming connection, it clones its listener
socket. However, the pointer to 'inet_opt' for the new socket has the same
value as the original one: as a consequence, on program exit it's possible
to observe the following splat:

  BUG: KASAN: double-free in inet_sock_destruct+0x54f/0x8b0
  Free of addr ffff888485950880 by task swapper/25/0

  CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Not tainted 6.8.0-rc1+ #609
  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x32/0x50
   print_report+0xca/0x620
   kasan_report_invalid_free+0x64/0x90
   __kasan_slab_free+0x1aa/0x1f0
   kfree+0xed/0x2e0
   inet_sock_destruct+0x54f/0x8b0
   __sk_destruct+0x48/0x5b0
   rcu_do_batch+0x34e/0xd90
   rcu_core+0x559/0xac0
   __do_softirq+0x183/0x5a4
   irq_exit_rcu+0x12d/0x170
   sysvec_apic_timer_interrupt+0x6b/0x80
   </IRQ>
   <TASK>
   asm_sysvec_apic_timer_interrupt+0x16/0x20
  RIP: 0010:cpuidle_enter_state+0x175/0x300
  Code: 30 00 0f 84 1f 01 00 00 83 e8 01 83 f8 ff 75 e5 48 83 c4 18 44 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc fb 45 85 ed <0f> 89 60 ff ff ff 48 c1 e5 06 48 c7 43 18 00 00 00 00 48 83 44 2b
  RSP: 0018:ffff888481cf7d90 EFLAGS: 00000202
  RAX: 0000000000000000 RBX: ffff88887facddc8 RCX: 0000000000000000
  RDX: 1ffff1110ff588b1 RSI: 0000000000000019 RDI: ffff88887fac4588
  RBP: 0000000000000004 R08: 0000000000000002 R09: 0000000000043080
  R10: 0009b02ea273363f R11: ffff88887fabf42b R12: ffffffff932592e0
  R13: 0000000000000004 R14: 0000000000000000 R15: 00000022c880ec80
   cpuidle_enter+0x4a/0xa0
   do_idle+0x310/0x410
   cpu_startup_entry+0x51/0x60
   start_secondary+0x211/0x270
   secondary_startup_64_no_verify+0x184/0x18b
   </TASK>

  Allocated by task 6853:
   kasan_save_stack+0x1c/0x40
   kasan_save_track+0x10/0x30
   __kasan_kmalloc+0xa6/0xb0
   __kmalloc+0x1eb/0x450
   cipso_v4_sock_setattr+0x96/0x360
   netlbl_sock_setattr+0x132/0x1f0
   selinux_netlbl_socket_post_create+0x6c/0x110
   selinux_socket_post_create+0x37b/0x7f0
   security_socket_post_create+0x63/0xb0
   __sock_create+0x305/0x450
   __sys_socket_create.part.23+0xbd/0x130
   __sys_socket+0x37/0xb0
   __x64_sys_socket+0x6f/0xb0
   do_syscall_64+0x83/0x160
   entry_SYSCALL_64_after_hwframe+0x6e/0x76

  Freed by task 6858:
   kasan_save_stack+0x1c/0x40
   kasan_save_track+0x10/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x12c/0x1f0
   kfree+0xed/0x2e0
   inet_sock_destruct+0x54f/0x8b0
   __sk_destruct+0x48/0x5b0
   subflow_ulp_release+0x1f0/0x250
   tcp_cleanup_ulp+0x6e/0x110
   tcp_v4_destroy_sock+0x5a/0x3a0
   inet_csk_destroy_sock+0x135/0x390
   tcp_fin+0x416/0x5c0
   tcp_data_queue+0x1bc8/0x4310
   tcp_rcv_state_process+0x15a3/0x47b0
   tcp_v4_do_rcv+0x2c1/0x990
   tcp_v4_rcv+0x41fb/0x5ed0
   ip_protocol_deliver_rcu+0x6d/0x9f0
   ip_local_deliver_finish+0x278/0x360
   ip_local_deliver+0x182/0x2c0
   ip_rcv+0xb5/0x1c0
   __netif_receive_skb_one_core+0x16e/0x1b0
   process_backlog+0x1e3/0x650
   __napi_poll+0xa6/0x500
   net_rx_action+0x740/0xbb0
   __do_softirq+0x183/0x5a4

  The buggy address belongs to the object at ffff888485950880
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes inside of
   64-byte region [ffff888485950880, ffff8884859508c0)

  The buggy address belongs to the physical page:
  page:0000000056d1e95e refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888485950700 pfn:0x485950
  flags: 0x57ffffc0000800(slab|node=1|zone=2|lastcpupid=0x1fffff)
  page_type: 0xffffffff()
  raw: 0057ffffc0000800 ffff88810004c640 ffffea00121b8ac0 dead000000000006
  raw: ffff888485950700 0000000000200019 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888485950780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
   ffff888485950800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  >ffff888485950880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                     ^
   ffff888485950900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
   ffff888485950980: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc

Something similar (a refcount underflow) happens with CALIPSO/IPv6. Fix
this by duplicating IP / IPv6 options after clone, so that
ip{,6}_sock_destruct() doesn't end up freeing the same memory area twice.

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c8f931c6d5b..7833a49f6214 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3178,8 +3178,50 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
+
+static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
+{
+	const struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_txoptions *opt;
+	struct ipv6_pinfo *newnp;
+
+	newnp = inet6_sk(newsk);
+
+	rcu_read_lock();
+	opt = rcu_dereference(np->opt);
+	if (opt) {
+		opt = ipv6_dup_options(newsk, opt);
+		if (!opt)
+			net_warn_ratelimited("%s: Failed to copy ip6 options\n", __func__);
+	}
+	RCU_INIT_POINTER(newnp->opt, opt);
+	rcu_read_unlock();
+}
 #endif
 
+static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
+{
+	struct ip_options_rcu *inet_opt, *newopt = NULL;
+	const struct inet_sock *inet = inet_sk(sk);
+	struct inet_sock *newinet;
+
+	newinet = inet_sk(newsk);
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	if (inet_opt) {
+		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+				      inet_opt->opt.optlen, GFP_ATOMIC);
+		if (newopt)
+			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
+			       inet_opt->opt.optlen);
+		else
+			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
+	}
+	RCU_INIT_POINTER(newinet->inet_opt, newopt);
+	rcu_read_unlock();
+}
+
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
@@ -3200,6 +3242,13 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	__mptcp_init_sock(nsk);
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (nsk->sk_family == AF_INET6)
+		mptcp_copy_ip6_options(nsk, sk);
+	else
+#endif
+		mptcp_copy_ip_options(nsk, sk);
+
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;

-- 
2.43.0


