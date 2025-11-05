Return-Path: <linux-kselftest+bounces-44798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08853C3576C
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5467C4F5BA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB126303A02;
	Wed,  5 Nov 2025 11:46:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E326F2A1;
	Wed,  5 Nov 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343207; cv=none; b=IJEPPLmMpkyrr8etPPUzQq7PvrHemtP6axQr0udsyx7axpr33xWb1zCT0aNCMflwuOVgHRGYNCF8Hu7jCcRIeShH9ozBPQP6Nkc4BwlMFsddI9H+hBQopb+GUqroFIM/0SgOZJp2RJW1AohHFrmai01ACAcd/w+oo9slmIWT2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343207; c=relaxed/simple;
	bh=hkfHasFk7m70dEz22ujbyfyr/wCs7n1zVvGYo0pWuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqkFxfOvCmYe3OUNg9Qlru8WrfRro4vu4sc7Ub1+NUpbhhnH7h57xLgNmY/FFHreRVgeBVuKkvMOnwTkqd0rpV1vUpsiPOtXog63QFVb1cD055UZsWlmeFtsmTwbchNu38UmkZUT2qVVkcXKiLFc2BJwd4wFDcfz74bN1EdJ5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id A3AD38B2A0C; Wed,  5 Nov 2025 19:38:04 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
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
Subject: [PATCH net v4 1/3] mptcp: disallow MPTCP subflows from sockmap
Date: Wed,  5 Nov 2025 19:36:07 +0800
Message-ID: <20251105113625.148900-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105113625.148900-1-jiayuan.chen@linux.dev>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sockmap feature allows bpf syscall from userspace using , or based
on bpf sockops, replacing the sk_prot of sockets during protocol stack
processing with sockmap's custom read/write interfaces.
'''
tcp_rcv_state_process()
  subflow_syn_recv_sock()
    tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
      bpf_skops_established       <== sockops
        bpf_sock_map_update(sk)   <== call bpf helper
          tcp_bpf_update_proto()  <== update sk_prot
'''
Consider two scenarios:

1. When the server has MPTCP enabled and the client also requests MPTCP,
   the sk passed to the BPF program is a subflow sk. Since subflows only
   handle partial data, replacing their sk_prot is meaningless and will
   cause traffic disruption.

2. When the server has MPTCP enabled but the client sends a TCP SYN
   without MPTCP, subflow_syn_recv_sock() performs a fallback on the
   subflow, replacing the subflow sk's sk_prot with the native sk_prot.
   '''
   subflow_ulp_fallback()
    subflow_drop_ctx()
      mptcp_subflow_ops_undo_override()
   '''
   Subsequently, accept::mptcp_stream_accept::mptcp_fallback_tcp_ops()
   converts the subflow to plain TCP.

For the first case, we should prevent it from being combined with sockmap
by setting sk_prot->psock_update_sk_prot to NULL, which will be blocked by
sockmap's own flow.

For the second case, since subflow_syn_recv_sock() has already restored
sk_prot to native tcp_prot/tcpv6_prot, no further action is needed.

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/subflow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30961b3d1702..ddd0fc6fcf45 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2144,6 +2144,10 @@ void __init mptcp_subflow_init(void)
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
 	tcp_prot_override.diag_destroy = tcp_abort_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcp_prot_override.psock_update_sk_prot = NULL;
+#endif
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
@@ -2180,6 +2184,10 @@ void __init mptcp_subflow_init(void)
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
 	tcpv6_prot_override.diag_destroy = tcp_abort_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcpv6_prot_override.psock_update_sk_prot = NULL;
+#endif
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
-- 
2.43.0


