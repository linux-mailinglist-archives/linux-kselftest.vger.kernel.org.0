Return-Path: <linux-kselftest+bounces-4797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C6856C72
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B976F1C21893
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F613A87C;
	Thu, 15 Feb 2024 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqdgbkKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24913A86C;
	Thu, 15 Feb 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021547; cv=none; b=FwOhGb34KXwflr+5CBFmMw0Mfubf5+KPQ8DEW2WjPIbGOPhYvDWh1XoXnk6W/J+IZDV7j5PIFMa8xW3yWmhUseZKqObQfh1QrGnP01B65EvSuXSFVnAKA+yW7H11wWraQpfkrmyQmnyazzx/nYvI/irC5/hALUoBVGflqIbVFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021547; c=relaxed/simple;
	bh=O9TaPCeVsjOq9jAAugHSwpNIaCX6JMv1ouUykBv8gj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XrC0uxlfJV+BErA7XvBrUIUiS5RjkRrcdQNbs9Q+wvRRsHAZITMkWK6fMCasa7JZDS8SRZfDOtcaSvsCC7YFumlPKuOkNyj2oGixEJBb16C/kW6wxqHfdwanZyRSShVI3srkdR2H+46Tb7P54ChU+BFYsaiLJ5xcxtzyNzsltNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqdgbkKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77328C43609;
	Thu, 15 Feb 2024 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021547;
	bh=O9TaPCeVsjOq9jAAugHSwpNIaCX6JMv1ouUykBv8gj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hqdgbkKAclztcu1xQRYG5SwRNJ7ZTkGqDGETsTIo85MclM/Y+UlJmyJFDI+lhumWL
	 ZOxv2dd/1qSHYPuFazvJBD5EDLz0NXcwX8UmSkZP79zygVUbkxXRr51z8fcTNTn7Iv
	 MKIXrQG/GYm6NRL4z2VHRrjjvYOboYe4RRe3oXLqFGTbukkF2ncBaPG+o48tHopYrB
	 GmDqT0esOcC01P3siGojYFcKyedjUuXGCCOgtwyMteCXjXqCsV1tkhxRddCpESewXa
	 Og5CX31merFzpt8biF5tqb26ZKAjNiEYWRVHneSnNQPLDgiWJDPYijgzXe3pWKroZJ
	 gr91bOtOZE9UQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:30 +0100
Subject: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3080; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xtj9AwzwqPCqP5Friqh0vCOkOhD544GhNiZf9ekwIjU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcc3yITjm+xGd3bhfD6bwGDlnT5JnEpdqxGj
 PhywDxO5umJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHAAKCRD2t4JPQmmg
 c56hD/4jXp5hKXebFuJVEHHOfdxqoyu+ghz9oB7ej8NcNVkhVR71JwrdGzHhiOtZ5VHdCcioCrT
 snpg2EkpSCaNk0rj3FWP622w2st+18qVuicEQ4KM77Dl8lxFeQRgYWWWXuHanuH7YSsYl0lKudW
 T4IsCOgKJybSYMTlXxR8MgOVOPeVaEXG5qYmHDxB4itbeVbJoU9Py2PEl9N5h+3KrMqlqNzTxYW
 DHR3ZeBjz+6J4/OrxL1xUnK6KovOqZ8IEJIb/lFRicruFZcx5P41qyylcFfp7OKYEvw1t5UaopQ
 FlnPJvkZZVDeNXEhNf1SEsXGUG/MIReDU3MhToj5sHrw0npRicV+H2QazESpa3jgrR2z0GtemRi
 dTgN8ZZ6b1BrUik+FCLDPCdcbj7RQvzUalUkIktJAyUKoOhnlJWsYhz/Mt04Xi4BhH2hOGTTdTZ
 vjVdh/1Rr8OorQA7zSglQosfdtuXTrzd4+cQD2SuhrYPkMJy2iepEfgCZzBZlc30MeXRAd6g+8p
 X2i18RDY34ZT/GmHA/rsq1FswcULdaIjcf4jy8ibt946SIMff923FweP4OjYp24dFH2IgMbJve4
 GG8j+/vDfkYKf8oRPj+cEESKJFmWE5zGEAs0n90PevE0DIaHcAn11CZxEKdl1ic1062ABiwho1z
 YbJXY9Lv8sojGlQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Since the introduction of the subflow ULP diag interface, the
dump callback accessed all the subflow data with lockless.

We need either to annotate all the read and write operation accordingly,
or acquire the subflow socket lock. Let's do latter, even if slower, to
avoid a diffstat havoc.

Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - This patch modifies the existing ULP API. No better solutions have
    been found for -net, and there is some similar prior art, see
    commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").

    Please also note that TLS ULP Diag has likely the same issue.
To: Boris Pismenny <borisp@nvidia.com>
To: John Fastabend <john.fastabend@gmail.com>
---
 include/net/tcp.h  | 2 +-
 net/mptcp/diag.c   | 6 +++++-
 net/tls/tls_main.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dd78a1181031..f6eba9652d01 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
 	/* cleanup ulp */
 	void (*release)(struct sock *sk);
 	/* diagnostic */
-	int (*get_info)(const struct sock *sk, struct sk_buff *skb);
+	int (*get_info)(struct sock *sk, struct sk_buff *skb);
 	size_t (*get_info_size)(const struct sock *sk);
 	/* clone ulp */
 	void (*clone)(const struct request_sock *req, struct sock *newsk,
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index a536586742f2..e57c5f47f035 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -13,17 +13,19 @@
 #include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
-static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
+static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
 	u32 flags = 0;
+	bool slow;
 	int err;
 
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
 
+	slow = lock_sock_fast(sk);
 	rcu_read_lock();
 	sf = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
 	if (!sf) {
@@ -69,11 +71,13 @@ static int subflow_get_info(const struct sock *sk, struct sk_buff *skb)
 	}
 
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_end(skb, start);
 	return 0;
 
 nla_failure:
 	rcu_read_unlock();
+	unlock_sock_fast(sk, slow);
 	nla_nest_cancel(skb, start);
 	return err;
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c2c6800949d..b4674f03d71a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1003,7 +1003,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
 	return 0;
 }
 
-static int tls_get_info(const struct sock *sk, struct sk_buff *skb)
+static int tls_get_info(struct sock *sk, struct sk_buff *skb)
 {
 	u16 version, cipher_type;
 	struct tls_context *ctx;

-- 
2.43.0


