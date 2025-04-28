Return-Path: <linux-kselftest+bounces-31758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70EFA9EA88
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A67189C802
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F1125E83E;
	Mon, 28 Apr 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgXCvYfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C625DD15
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828328; cv=none; b=SXlxcVBukhx5aJQV8W372OogxR1pvBn78sI9iAJwk14GR2OE/lhpcvYWrUfD1QJes0FvBQ8RUlSYYAcQ4ZX3d8b4ocapi6HOOxxMNXU1cbpQdVrinxC/7eb/quLOUDv1qQxUYGYK5QbfaTjaJ4PE2BSnaD0ddAtFM4GS3GzFyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828328; c=relaxed/simple;
	bh=shrVW23MJmXPTGr7Fi7hfalJrHhCvaQGn7EfPJfZHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDgfa1aga2yt+cuz0JnJ/hNgAl+hfjdFyga1NH8J+D0LzVx7dhgkQFiGBIy5cyD7vuNlg2lm4siOB+jSG4oclTlbPJ/1zZvX7Q4+P5f54NAgRGQnHfRtgVsXJGbLKfeLGfTVZyJqPV/LNhViZZTpq5yNbRbnl8hu99BLFymIAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgXCvYfE; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745828323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDD4f3PJohVRbIgegKL4gSaxyAoWqWwnyjgGj9h1ygw=;
	b=BgXCvYfEYOgYlLJ1CvN2ual2TU/chQyaWi5wpad8tR3nAaFu7FsOpzpDnCkM1r5iD1nYuz
	DEfR8J8CpxP5bRA4HrjZeSA3QvIzZWgzZ7QGvQgyQYNJBZb733wqORpCqt/GeuuQ5r/AfA
	DEUcrhF7AxAa0GiFgJDIMCP0TT/DpIw=
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
Subject: [PATCH bpf-next v1 2/3] bpf, sockmap: Affinitize workqueue to a specific CPU
Date: Mon, 28 Apr 2025 16:16:53 +0800
Message-ID: <20250428081744.52375-3-jiayuan.chen@linux.dev>
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

Introduce a sk_psock_schedule_delayed_work() wrapper function, which calls
schedule_delayed_work_on() to specify the CPU for running the workqueue if
the BPF program has set the redirect CPU using
bpf_sk_skb_set_redirect_cpu(). Otherwise, it falls back to the original
logic.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h | 12 ++++++++++++
 net/core/skmsg.c      |  9 +++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index b888481a845d..21c7dd47186f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -396,6 +396,18 @@ static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 	sk_error_report(sk);
 }
 
+static inline void sk_psock_schedule_delayed_work(struct sk_psock *psock,
+						  int delay)
+{
+	s32 redir_cpu = psock->redir_cpu;
+
+	if (redir_cpu != BPF_SK_REDIR_CPU_UNSET)
+		schedule_delayed_work_on(redir_cpu, &psock->work,
+					 delay);
+	else
+		schedule_delayed_work(&psock->work, delay);
+}
+
 struct sk_psock *sk_psock_init(struct sock *sk, int node);
 void sk_psock_stop(struct sk_psock *psock);
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 292752c783b5..af00c09263a8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -689,7 +689,7 @@ static void sk_psock_backlog(struct work_struct *work)
 					 * other work that might be here.
 					 */
 					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-						schedule_delayed_work(&psock->work, 1);
+						sk_psock_schedule_delayed_work(psock, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
@@ -940,6 +940,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 		sock_drop(from->sk, skb);
 		return -EIO;
 	}
+	psock_other->redir_cpu = from->redir_cpu;
 	spin_lock_bh(&psock_other->ingress_lock);
 	if (!sk_psock_test_state(psock_other, SK_PSOCK_TX_ENABLED)) {
 		spin_unlock_bh(&psock_other->ingress_lock);
@@ -949,7 +950,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_delayed_work(&psock_other->work, 0);
+	sk_psock_schedule_delayed_work(psock_other, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -1027,7 +1028,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_delayed_work(&psock->work, 0);
+				sk_psock_schedule_delayed_work(psock, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
@@ -1059,7 +1060,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_delayed_work(&psock->work, 0);
+			sk_psock_schedule_delayed_work(psock, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
-- 
2.47.1


