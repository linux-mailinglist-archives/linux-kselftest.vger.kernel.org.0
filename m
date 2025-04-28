Return-Path: <linux-kselftest+bounces-31757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC4A9EA7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8589D3B7F0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E125DAED;
	Mon, 28 Apr 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZKeJ9jKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F938211476
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828306; cv=none; b=f15jxOkcP7XjLaE53ddBYHP8DsufQVPAiXa6/K77cKobvVtTm5y/PtH4K+SmJPaqpMdartDX+UhI7hVhcRxVmx8hUFWQoN8xBTEXPalbIJ9O44EajEty/a7E+J+bJzDX69vLFeRGZMmUpzCamFOY0TF741uwEEerG9R2xOl3yNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828306; c=relaxed/simple;
	bh=IMJE7V9CVXOWAC+XyzS2qXoKTYeaPy4ubI1JKh8jn9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haB6V2hdvHIep9dbHPH9lPmZTy30exe/AQpGN+yLj5ZhN1+3kYWtA1J5Hcs5NOAaktGLQSFDUdUuXzsTRQljNrFxDGEH7ddf2Kq3b5v4ajskpq6kzLouUlKojMo/hF0gVgJkfTyg+/fRBY7kucP5TaiONx3xkwat/lMjoUAvq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZKeJ9jKB; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745828301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=La6440s7eHKYWjOaUhORIlr3h2SS6qaflsCpheO/PtQ=;
	b=ZKeJ9jKBrWm2iWByTW0FEsf9ZQEJ1C/gXyVtG0KS80uWaAxGbGTAo3Zexb3Oip/tFP3rjV
	IvQWM+GcZ56ws0qFC++XnwZDnGV6p3/NkspAxOqoqo1x8tg8ui/+aw+djVZALbiLuwcI3A
	h18sHpm4TBlncQO8Gb4fihG733zEYBo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/3] bpf, sockmap: Introduce a new kfunc for sockmap
Date: Mon, 28 Apr 2025 16:16:52 +0800
Message-ID: <20250428081744.52375-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250428081744.52375-1-jiayuan.chen@linux.dev>
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since the helper list is effectively frozen and the existing helpers
cannot be extended, we add a new kfunc instead which simply set the
redir_cpu to psock.

The new kfunc is used to set redir_cpu to psock.

All these changes conform to the kfuncs.rst documentation.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 Documentation/bpf/map_sockmap.rst | 14 +++++++++++
 include/linux/skmsg.h             |  3 +++
 kernel/bpf/btf.c                  |  3 +++
 net/core/skmsg.c                  |  1 +
 net/core/sock_map.c               | 39 +++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
index 2d630686a00b..eca3dfc1c85f 100644
--- a/Documentation/bpf/map_sockmap.rst
+++ b/Documentation/bpf/map_sockmap.rst
@@ -212,6 +212,20 @@ following cases:
 
 Returns 0
 
+bpf_sk_skb_set_redirect_cpu()
+^^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    int bpf_sk_skb_set_redirect_cpu(struct __sk_buff *s, int redir_cpu)
+
+This kfunc ``bpf_sk_skb_set_redirect_cpu()`` is available to
+``BPF_PROG_TYPE_SK_SKB`` BPF programs. It sets the CPU affinity, allowing the
+sockmap packet redirecting process to run on the specified CPU as much as
+possible, helping users reduce the interference between the sockmap redirecting
+background thread and other threads.
+
+Returns 0 on success, or a negative error in case of failure.
+
 bpf_msg_cork_bytes()
 ^^^^^^^^^^^^^^^^^^^^^^
 .. code-block:: c
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 0b9095a281b8..b888481a845d 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -16,6 +16,8 @@
 #define MAX_MSG_FRAGS			MAX_SKB_FRAGS
 #define NR_MSG_FRAG_IDS			(MAX_MSG_FRAGS + 1)
 
+#define BPF_SK_REDIR_CPU_UNSET		-1
+
 enum __sk_action {
 	__SK_DROP = 0,
 	__SK_PASS,
@@ -86,6 +88,7 @@ struct sk_psock {
 	u32				apply_bytes;
 	u32				cork_bytes;
 	u32				eval;
+	s32				redir_cpu;
 	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a91822bae043..2a8f59e2c639 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -219,6 +219,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
 	BTF_KFUNC_HOOK_KPROBE,
+	BTF_KFUNC_HOOK_SK_MSG,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -8649,6 +8650,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_SCHED_ACT;
 	case BPF_PROG_TYPE_SK_SKB:
 		return BTF_KFUNC_HOOK_SK_SKB;
+	case BPF_PROG_TYPE_SK_MSG:
+		return BTF_KFUNC_HOOK_SK_MSG;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 		return BTF_KFUNC_HOOK_SOCKET_FILTER;
 	case BPF_PROG_TYPE_LWT_OUT:
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 276934673066..292752c783b5 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -741,6 +741,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
 	psock->saved_write_space = sk->sk_write_space;
+	psock->redir_cpu = BPF_SK_REDIR_CPU_UNSET;
 
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82a14f131d00..9f1e531a3807 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -701,6 +701,45 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
 	.arg4_type      = ARG_ANYTHING,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_sk_skb_set_redirect_cpu(struct __sk_buff *s, int redir_cpu)
+{
+	struct sk_buff *skb = (struct sk_buff *)s;
+	struct sock *sk = skb->sk;
+	struct sk_psock *psock;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (!sk || redir_cpu >= num_possible_cpus())
+		return -EINVAL;
+
+	psock = sk_psock(sk);
+	if (!psock)
+		return -ENOENT;
+
+	psock->redir_cpu = redir_cpu;
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_sk_sockmap_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_sk_skb_set_redirect_cpu)
+BTF_KFUNCS_END(bpf_sk_sockmap_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_sk_sockmap_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_sk_sockmap_kfunc_ids,
+};
+
+static int init_sockmap_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_sk_sockmap_kfunc_set);
+}
+
+late_initcall(init_sockmap_subsystem);
+
 struct sock_map_seq_info {
 	struct bpf_map *map;
 	struct sock *sk;
-- 
2.47.1


